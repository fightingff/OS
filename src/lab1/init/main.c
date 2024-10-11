#include "printk.h"
#include "defs.h"

extern void test();

int start_kernel() {
    printk("2024");
    printk(" ZJU Operating System\n");

    // debug for csr_read
    // uint64_t x = csr_read(sstatus);
    // printk("sstatus = 0x%lx\n", x);

    // debug for csr_write
    // uint64_t x = csr_read(sscratch);
    // printk("former: sscratch = 0x%lx\n", x);    // get former value
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    test();
    return 0;
}
