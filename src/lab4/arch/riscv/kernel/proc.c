#include "mm.h"
#include "vm.h"
#include "defs.h"
#include "proc.h"
#include "string.h"
#include "stdlib.h"
#include "printk.h"

extern void __dummy();
extern uint64_t swapper_pg_dir[512];

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

// 用户程序的代码段
extern char _sramdisk[], _eramdisk[];

void task_init() {
    srand(2024);

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;

    // 1. 参考 idle 的设置，为 task[1] ~ task[NR_TASKS - 1] 进行初始化
    // 2. 其中每个线程的 state 为 TASK_RUNNING, 此外，counter 和 priority 进行如下赋值：
    //     - counter  = 0;
    //     - priority = rand() 产生的随机数（控制范围在 [PRIORITY_MIN, PRIORITY_MAX] 之间）
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 thread_struct 中的 ra 和 sp
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /*
    对于每个进程，初始化我们刚刚在 thread_struct 中添加的三个变量，具体而言：
        - 将 sepc 设置为 USER_START
        - 配置 sstatus 中的 SPP（使得 sret 返回至 U-Mode）、SPIE（sret 之后开启中断）、SUM（S-Mode 可以访问 User 页面）
        - 将 sscratch 设置为 U-Mode 的 sp，其值为 USER_END （将用户态栈放置在 user space 的最后一个页面）
    
    对于每个进程，创建属于它自己的页表：
        - 为了避免 U-Mode 和 S-Mode 切换的时候切换页表，我们将内核页表 swapper_pg_dir 复制到每个进程的页表中
        - 将 uapp 所在的页面映射到每个进程的页表中
    */

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
        task[i] = (struct task_struct *)kalloc();
        task[i]->state = TASK_RUNNING;

        task[i]->counter = 0;
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);

        task[i]->pid = i;

        task[i]->thread.ra = (uint64_t)__dummy;
        task[i]->thread.sepc = USER_START;

        /**
         * 配置 sstatus 中的 SPP（使得 sret 返回至 U-Mode）、SPIE（sret 之后开启中断）、SUM（S-Mode 可以访问 User 页面）
         * SPP 置 0: When an SRET instruction (see Section 3.3.2) is executed to return from the trap handler, the privilege level is set to user mode if the SPP bit is 0, or supervisor mode if the SPP bit is 1; SPP is then set to 0.
         * SPIE 置 1: The SPIE bit indicates whether supervisor interrupts were enabled prior to trapping into supervisor mode. When a trap is taken into supervisor mode, SPIE is set to SIE, and SIE is set to 0. When an SRET instruction is executed, SIE is set to SPIE, then SPIE is set to 1
         * SUM 置 1
         */
        task[i]->thread.sstatus = csr_read(sstatus);
        task[i]->thread.sstatus &= ~(1ull << SPP);
        task[i]->thread.sstatus |= (1ull << SPIE);
        task[i]->thread.sstatus |= (1ull << SUM);

        // 一个 page 4KiB，刚好是 512 个 64 bit，刚好是一级页表的大小
        task[i]->pgd = alloc_page();

        printk("task[%d]->pgd = %p\n", i, task[i]->pgd);
        // 先复制一遍内核态的页表
        memcpy(task[i]->pgd, swapper_pg_dir, 512 * 8);

        // 复制程序并构造映射
        // 每个用户态程序运行的都是复制一遍的代码段
        // 先开一些 page，复制一遍代码段
        uint64_t user_app_len = _eramdisk - _sramdisk;
        uint64_t user_app_pages_count = user_app_len / PGSIZE + (user_app_len % PGSIZE != 0);
        uint64_t *user_app_page = alloc_pages(user_app_pages_count);
        memcpy(user_app_page, _sramdisk, user_app_len);
        // 构建映射
        create_mapping(task[i]->pgd, USER_START, (uint64_t)user_app_page - PA2VA_OFFSET, user_app_pages_count * PGSIZE, 0x1F);

        // 构建并映射用户栈
        // 开一个 page 作为用户栈
        uint64_t *user_stack = alloc_page();
        uint64_t va = USER_END - PGSIZE;
        uint64_t pa = (uint64_t)user_stack - PA2VA_OFFSET;
        create_mapping(task[i]->pgd, va, pa, PGSIZE, 0x17);

        // 转为物理地址
        task[i]->pgd = (uint64_t *)((uint64_t)task[i]->pgd - PA2VA_OFFSET);
        
        // 设置栈指针
        // sp 为内核态指针
        // sscratch 为用户态指针
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
        task[i]->thread.sscratch = USER_END;
    }
    printk("...task_init done!\n");
}

#if TEST_SCHED
#define MAX_OUTPUT ((NR_TASKS - 1) * 10)
char tasks_output[MAX_OUTPUT];
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    // LOG(RED);
    uint64_t MOD = 1000000007;
    uint64_t auto_inc_local_var = 0;
    int last_counter = -1;
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
            if (current->counter == 1) {
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
            // LOG(RED "%llu\n", current->thread.ra);
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
            if (tasks_output_index == MAX_OUTPUT) {
                for (int i = 0; i < MAX_OUTPUT; ++i) {
                    if (tasks_output[i] != expected_output[i]) {
                        printk("\033[31mTest failed!\033[0m\n");
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
            }
            #endif
        }
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    LOG(RED);
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
    if(current->pid != next->pid) {
        struct task_struct *prev = current;
        current = next;
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
        __switch_to(prev, next);
    }
}

void do_timer() {
    // LOG(RED);
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
        schedule();
    }
    else --(current->counter);
}

void schedule() {
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    // LOG(RED);
    struct task_struct *next = idle;
    for(int i = 1; i < NR_TASKS; ++i) {
        if(task[i]->counter > next->counter){
            next = task[i];
        }
    }

    if(next->counter == 0) {
        printk("\n");
        for(int i = 1; i < NR_TASKS; ++i) {
            task[i]->counter = task[i]->priority;
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
        }
        schedule();
    } else {
        switch_to(next);
    }
}