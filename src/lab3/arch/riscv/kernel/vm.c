#include "defs.h"
#include "printk.h"
#include "string.h"

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

    /*
    for(uint64_t i = 0; i < (1 << 9); i++) {
        uint64_t virtual_page_number = (i << 18); // 大页的开头的第一个小页页号
        uint64_t physical_page_number = 0;
        if(virtual_page_number == (PHY_START >> 12) || virtual_page_number == (VM_START >> 12)) {
            LOG(RED "%lx\n", (PHY_START >> 12));
            physical_page_number = (PHY_START >> 12);
        }
        
        // 设置 PPN
        early_pgtbl[i] |= (physical_page_number << 10);
        // V | R | W | X 设置为 1
        early_pgtbl[i] |= ((1 << 4) - 1);
    }
    */

    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
    early_pgtbl[index] = (PHY_START >> 12) << 10;
    early_pgtbl[index] |= ((1 << 4) - 1);


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
    early_pgtbl[index] = (PHY_START >> 12) << 10;
    early_pgtbl[index] |= ((1 << 4) - 1);

    printk("...setup_vm done!\n");
}