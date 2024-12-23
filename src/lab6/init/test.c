#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    __builtin_unreachable();
}

void test() {
    int i = 0;
    while (1) {
        if ((++i) % 100000000 == 0){        
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
            i = 0;
        }
    }
}

void run_idle() {
    while (1) {
        // do nothing
    }
}