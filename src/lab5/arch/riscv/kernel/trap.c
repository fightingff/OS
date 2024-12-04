#include "vm.h"
#include "mm.h"
#include "defs.h"
#include "string.h"
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

    bool is_interrupt = ((scause & SCAUSE_INTERRUPT) > 0);
    uint64_t exception_code = scause & (~SCAUSE_INTERRUPT);

    if(is_interrupt && exception_code == SCAUSE_INT_TIMER) {
        // Supervisor software interrupt from a S-mode timer interrupt 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");
        // 设置下一次时钟中断
        clock_set_next_event();
        // schedule
        do_timer();
    } else if(!is_interrupt && exception_code == SCAUSE_EXC_U_ECALL) {
        if(regs->x[17] == SYS_GETPID){
            regs->x[10] = current->pid;
            LOG(GREEN "ecall: SYS_GETPID" CLEAR);
        } else if(regs->x[17] == SYS_WRITE){
            regs->x[10] = printk("%s", regs->x[11]);
            LOG(GREEN "ecall: SYS_WRITE" CLEAR);
        } else {
            printk("[U] Unhandled ecall: ecall_type=%016llX \n", regs->x[17]);
        }
        regs->sepc += 4;
    } else if(!is_interrupt && (
        exception_code == SCAUSE_EXC_INSTRUCTION_PAGE_FAULT
        || exception_code == SCAUSE_EXC_LOAD_PAGE_FAULT
        || exception_code == SCAUSE_EXC_STORE_OR_AMO_PAGE_FAULT
    )) {
        // 处理 PAGE_FAULT
        // 进行 Demand Paging
        /**
         * If stval is written with a nonzero value when a breakpoint, address-misaligned, access-fault, or page fault exception occurs on an instruction fetch, load, or store, then stval will contain the faulting virtual address.
         */
        
        uint64_t bad_addr = csr_read(stval);
        struct vm_area_struct *vma = find_vma(&current->mm, bad_addr);
        
        ASSERT(vma != NULL);
        ASSERT(!(exception_code == SCAUSE_EXC_INSTRUCTION_PAGE_FAULT && !(vma->vm_flags & VM_EXEC)));

        do_map_one_page(current->pgd, vma, bad_addr);

    }
    else {
        // 其他 interrupt / exceptiont
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    }
}