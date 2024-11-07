#include "defs.h"
#include "printk.h"
#include "string.h"
#include "mm.h"
#include "vm.h"

extern char _stext[], _etext[];
extern char _srodata[], _erodata[];

extern char *_stext, *_etext;
extern char *_srodata, *_erodata;

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
    /* 
     * 1. 由于是进行 1GiB 的映射，这里不需要使用多级页表 
     * 2. 将 va 的 64bit 作为如下划分： | high bit | 9 bit | 30 bit |
     *     high bit 可以忽略
     *     中间 9 bit 作为 early_pgtbl 的 index
     *     低 30 bit 作为页内偏移，这里注意到 30 = 9 + 9 + 12，即我们只使用根页表，根页表的每个 entry 都对应 1GiB 的区域
     * 3. Page Table Entry 的权限 V | R | W | X 位设置为 1
    **/

    /*
     63      54 53        28 27        19 18        10 9   8 7 6 5 4 3 2 1 0
    ┌──────────┬────────────┬────────────┬────────────┬─────┬─┬─┬─┬─┬─┬─┬─┬─┐
    │ Reserved │   PPN[2]   │   PPN[1]   │   PPN[0]   │ RSW │D│A│G│U│X│W│R│V│
    └──────────┴────────────┴────────────┴────────────┴─────┴─┴─┴─┴─┴─┴─┴─┴─┘
                                                        │   │ │ │ │ │ │ │ │
                                                        │   │ │ │ │ │ │ │ └──── V - Valid
                                                        │   │ │ │ │ │ │ └────── R - Readable
                                                        │   │ │ │ │ │ └──────── W - Writable
                                                        │   │ │ │ │ └────────── X - Executable
                                                        │   │ │ │ └──────────── U - User
                                                        │   │ │ └────────────── G - Global
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);

    // for(uint64_t i = 0; i < (1 << 9); i++) {
    //     uint64_t physical_page_number = 0;
    //     if(i == ((PHY_START >> 30) & 0x1FF) || i == ((VM_START >> 30) & 0x1FF)) {
    //         LOG(RED "%lx\n" CLEAR, (PHY_START >> 30));
    //         physical_page_number = (PHY_START >> 30);
    //     }
        
    //     // 设置 PPN
    //     early_pgtbl[i] |= (physical_page_number << 28);
    //     // V | R | W | X 设置为 1
    //     early_pgtbl[i] |= ((1 << 4) - 1);
    // }


    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
    early_pgtbl[index] = (PHY_START >> 12) << 10;
    early_pgtbl[index] |= ((1 << 4) - 1);


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
    early_pgtbl[index] = (PHY_START >> 12) << 10;
    early_pgtbl[index] |= ((1 << 4) - 1);

    LOG(RED "text: %p" CLEAR, _stext);
    printk("...setup_vm done!\n");
}

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
    memset(swapper_pg_dir, 0x0, PGSIZE);

    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    LOG(BLUE "_stext: %p, _etext: %p" CLEAR, _stext, _etext);
    LOG(BLUE "_srodata: %p, _erodata: %p" CLEAR, _srodata, _erodata);
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, PGROUNDUP((uint64_t)_erodata), PGROUNDUP((uint64_t)_erodata) - PA2VA_OFFSET, VM_END - PGROUNDUP((uint64_t)_erodata), 0b0111);

    printk("...create_mapping done!\n");
    // set satp with swapper_pg_dir
    asm volatile("csrw satp, %0" :: "r"(((uint64_t)swapper_pg_dir >> 12) | (8llu << 60)));

    // YOUR CODE HERE

    // flush TLB
    asm volatile("sfence.vma zero, zero");

    // flush icache
    // asm volatile("fence.i");
    return;
}


/* 创建多级页表映射关系 */
/* 不要修改该接口的参数和返回值 */
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
    /*
     * pgtbl 为根页表的基地址
     * va, pa 为需要映射的虚拟地址、物理地址
     * sz 为映射的大小，单位为字节
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
        uint64_t va_s = va + i;
        uint64_t index2 = (va_s >> 30) & 0x1ff;
        uint64_t index1 = (va_s >> 21) & 0x1ff;
        uint64_t index0 = (va_s >> 12) & 0x1ff;

        if(!(pgtbl[index2] & 1)) {
            pgtbl[index2] = ((uint64_t)kalloc() << 10) | perm;
        }

        uint64_t *pgtbl1 = (uint64_t *)(pgtbl[index2] >> 10);
        if(!(pgtbl1[index1] & 1)) {
            pgtbl1[index1] = ((uint64_t)kalloc() << 10) | perm;
        }

        uint64_t *pgtbl0 = (uint64_t *)(pgtbl1[index1] >> 10);
        if(!(pgtbl0[index0] & 1)) {
            pgtbl0[index0] = ((pa >> 12) << 10) | perm;
        }
    }
   
}