#include "printk.h"
#include "defs.h"

extern void test();

int start_kernel() {
    printk("2024");
    printk(" ZJU Operating System\n");

    // debug for csr_read
    // uint64_t x = csr_read(sie);
    // printk("sstatus = %lx\n", x);

    test();
    return 0;
}
