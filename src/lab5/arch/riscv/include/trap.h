#ifndef __TRAP_H__
#define __TRAP_H__

// 定义 trap 类型的一些常量
// SCAUSE_INTERRUPT: 最高位为 1 表示是 interrupt，为 0 表示是 exception
// SCAUSE_TIMER_INT: 时钟中断的值 5
#define SCAUSE_INTERRUPT 0x8000000000000000

// interrupt / exception 的 exception code
#define SCAUSE_INT_TIMER 5

#define SCAUSE_EXC_U_ECALL 8 // Environment call from U-mode
#define SCAUSE_EXC_INSTRUCTION_PAGE_FAULT 12 // Instruction page fault
#define SCAUSE_EXC_LOAD_PAGE_FAULT 13 // Load page fault
#define SCAUSE_EXC_STORE_OR_AMO_PAGE_FAULT 15 // Store/AMO Page Fault

struct pt_regs{
    uint64_t x[32];
    uint64_t sepc, sstatus, sscratch;
};

#endif