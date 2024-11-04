#ifndef __TRAP_H__
#define __TRAP_H__

#define SCAUSE_INTERRUPT 0x8000000000000000
#define SCAUSE_TIMER_INT 5

// 定义 trap 类型的一些常量
// SCAUSE_INTERRUPT: 最高位为 1 表示是 interrupt，为 0 表示是 exception
// SCAUSE_TIMER_INT: 时钟中断的值 5

#endif