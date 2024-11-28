#include "stdint.h"
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"
#include "syscall.h"

extern struct task_struct *current;

void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs) {
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();

        // schedule
        do_timer();
    }else if(!(scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_EXCEPTION_U){
        if(regs->x[17] == SYS_GETPID){
            regs->x[10] = current->pid;
        }else if(regs->x[17] == SYS_WRITE){
            regs->x[10] = printk("%s", regs->x[12]);
        }else {
             printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
        }

    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    }
}