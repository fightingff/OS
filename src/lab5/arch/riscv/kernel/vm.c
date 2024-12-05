#include "defs.h"
#include "printk.h"
#include "string.h"
#include "mm.h"
#include "vm.h"

extern char _stext[], _etext[];
extern char _srodata[], _erodata[];
extern char _sdata[], _edata[];

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

/*
Physical Address
-------------------------------------------
                     | OpenSBI | Kernel |
-------------------------------------------
                     ↑
                0x80000000
                     ├───────────────────────────────────────────────────┐
                     |                                                   |
Virtual Address      ↓                                                   ↓
-----------------------------------------------------------------------------------------------
                     | OpenSBI | Kernel |                                | OpenSBI | Kernel |
-----------------------------------------------------------------------------------------------
                     ↑                                                   ↑
                0x80000000                                       0xffffffe000000000
*/
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

    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff; // 9-bit index
    // early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN还是4KiB页
    // early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;   // 9-bit index
    early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN
    early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X

    LOG(RED "text: %p" CLEAR, _stext);
    printk("...setup_vm done!\n");
}

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
    memset(swapper_pg_dir, 0x0, PGSIZE);

    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_sdata, (uint64_t)_sdata - PA2VA_OFFSET, VM_END - (uint64_t)_sdata, 0b0111);

    printk("...create_mapping done!\n");
    // set satp with swapper_pg_dir
    csr_write(satp, ((uint64_t)swapper_pg_dir - PA2VA_OFFSET) >> 12 | (8llu << 60));

    // flush TLB
    asm volatile("sfence.vma zero, zero");

    // flush icache
    asm volatile("fence.i");

    printk("...setup_vm_final done!\n");
    return;
}


/* 创建多级页表映射关系 */
/* 不要修改该接口的参数和返回值 */
/*
                                Virtual Address                                     Physical Address

                          9             9            9              12          55        12 11       0
   ┌────────────────┬────────────┬────────────┬─────────────┬────────────────┐ ┌────────────┬──────────┐
   │                │   VPN[2]   │   VPN[1]   │   VPN[0]    │     OFFSET     │ │     PPN    │  OFFSET  │
   └────────────────┴────┬───────┴─────┬──────┴──────┬──────┴───────┬────────┘ └────────────┴──────────┘
                         │             │             │              │                 ▲          ▲
                         │             │             │              │                 │          │
                         │             │             │              │                 │          │
┌────────────────────────┘             │             │              │                 │          │
│                                      │             │              │                 │          │
│                                      │             │              └─────────────────│──────────┘
│    ┌─────────────────┐               │             │                                │
│511 │                 │  ┌────────────┘             │                                │
│    │                 │  │                          │                                │
│    │                 │  │     ┌─────────────────┐  │                                │
│    │                 │  │ 511 │                 │  │                                │
│    │                 │  │     │                 │  │                                │
│    │                 │  │     │                 │  │     ┌─────────────────┐        │
│    │   44       10   │  │     │                 │  │ 511 │                 │        │
│    ├────────┬────────┤  │     │                 │  │     │                 │        │
└───►│   PPN  │  flags │  │     │                 │  │     │                 │        │
     ├────┬───┴────────┤  │     │   44       10   │  │     │                 │        │
     │    │            │  │     ├────────┬────────┤  │     │                 │        │
     │    │            │  └────►│   PPN  │  flags │  │     │                 │        │
     │    │            │        ├────┬───┴────────┤  │     │   44       10   │        │
     │    │            │        │    │            │  │     ├────────┬────────┤        │
   1 │    │            │        │    │            │  └────►│   PPN  │  flags │        │
     │    │            │        │    │            │        ├────┬───┴────────┤        │
   0 │    │            │        │    │            │        │    │            │        │
     └────┼────────────┘      1 │    │            │        │    │            │        │
     ▲    │                     │    │            │        │    └────────────┼────────┘
     │    │                   0 │    │            │        │                 │
     │    └────────────────────►└────┼────────────┘      1 │                 │
     │                               │                     │                 │
 ┌───┴────┐                          │                   0 │                 │
 │  satp  │                          └────────────────────►└─────────────────┘
 └────────┘
*/
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
    /*
     * pgtbl 为根页表的基地址 的 虚拟地址
     * va, pa 为需要映射的虚拟地址、物理地址
     * sz 为映射的大小，单位为字节
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
        // 分别获取三级索引 index2, index1, index0
        uint64_t va_s = va + i;
        uint64_t index2 = (va_s >> 30) & 0x1ff;
        uint64_t index1 = (va_s >> 21) & 0x1ff;
        uint64_t index0 = (va_s >> 12) & 0x1ff;

        // 根页表
        if(!(pgtbl[index2] & 1)) {  // 根据 V bit 判断页表项是否存在
            // 先减去 PA2VA_OFFSET转换为物理地址，然后右移12位转换为PPN ，最后左移10位或上权限为转换为页表项
            pgtbl[index2] = (((uint64_t)kalloc() - PA2VA_OFFSET) >> 12 << 10) | 1;
        }

        // 二级页表
        uint64_t *pgtbl1 = (uint64_t *)((uint64_t)(pgtbl[index2] >> 10 << 12) + PA2VA_OFFSET);
        if(!(pgtbl1[index1] & 1)) {
            pgtbl1[index1] = (((uint64_t)kalloc() - PA2VA_OFFSET) >> 12 << 10) | 1;
        }

        // 叶子页表
        uint64_t *pgtbl0 = (uint64_t *)((uint64_t)(pgtbl1[index1] >> 10 << 12) + PA2VA_OFFSET);
        if(!(pgtbl0[index0] & 1)) {
            // 此时正确设置页表项的 PPN 和权限
            pgtbl0[index0] = (((pa + i) >> 12) << 10) | perm;
        }
    }
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
}

void copy_mapping(uint64_t *dest_pgd, uint64_t *src_pgd) {
    // 深拷贝页表
    // 传入的 dest_pgd 和 src_pgd 是虚拟地址

    for(int i = 0; i < 512; i++) {
        LOG(GREEN "copy_mapping %d, %p, %p" CLEAR, i, dest_pgd, src_pgd);
        if(dest_pgd[i] == src_pgd[i]) { // 内核页
            continue;
        }
        LOG(GREEN "copy_mapping_) %d" CLEAR, i);
        if(!(src_pgd[i] & 1)) { // 该页表项不存在
            continue;
        }
        LOG(GREEN "copy_mapping_) %d" CLEAR, i);

        uint64_t *src_page = (uint64_t *)PA2VA(src_pgd[i] >> 10 << 12);

        if(dest_pgd[i] & 0b1110) { // 为叶子节点
            // 将 src 的 PTE_W 位置 0
            src_pgd[i] &= ~0x4;

            dest_pgd[i] = (VA2PA(src_page) >> 12 << 10);
            dest_pgd[i] |= (src_pgd[i] & 0x3FF);

            get_page(src_page);

            // flush TLB and icache
            asm volatile("sfence.vma zero, zero");
            asm volatile("fence.i");
            continue;
        }

        // 不为叶子节点就递归
        uint64_t *dest_page = (uint64_t *)alloc_page();
        dest_pgd[i] = (VA2PA(dest_page) >> 12 << 10);
        dest_pgd[i] |= (src_pgd[i] & 0x3FF);
        memset(dest_page, 0, PGSIZE);
        copy_mapping(dest_page, src_page);
    }
}

uint64_t * find_pte(uint64_t *pgd, uint64_t addr) {
    // 传入的 pgd 为物理地址, addr 为虚拟地址
    pgd = (uint64_t *)PA2VA(pgd);

    uint64_t index2 = (addr >> 30) & 0x1ff;
    uint64_t index1 = (addr >> 21) & 0x1ff;
    uint64_t index0 = (addr >> 12) & 0x1ff;
    if(!(pgd[index2] & 1)) {
        return NULL;
    }
    
    uint64_t *pgd1 = (uint64_t *)PA2VA(pgd[index2] >> 10 << 12);
    if(!(pgd1[index1] & 1)) {
        return NULL;
    }

    uint64_t *pgd0 = (uint64_t *)PA2VA(pgd1[index1] >> 10 << 12);
    if(!(pgd0[index0] & 1)) {
        return NULL;
    }

    return &pgd0[index0];
}