    .extern trap_handler
    .section .text.entry
    .align 2

    .globl _traps 
_traps:
    # 同理，在 _traps 的首尾我们都需要做类似的操作，进入 trap 的时候需要切换到内核栈，处理完成后需要再切换回来
    # 注意如果是内核线程（没有用户栈）触发了异常，则不需要进行切换。（内核线程的 sp 永远指向的内核栈，且 sscratch 为 0）

    # 切换到内核栈
    # 需要判断是否是内核线程，如果是内核线程则不需要切换
    # csrrw 原子性交换
    csrrw sp, sscratch, sp
    bnez sp, no_switch_begin
    csrrw sp, sscratch, sp

no_switch_begin:
    addi sp, sp, -280   # allocate 256 bytes stack space
    sd x0, 0(sp)
    sd x1, 8(sp)
    sd x2, 16(sp)
    sd x3, 24(sp)
    sd x4, 32(sp)
    sd x5, 40(sp)
    sd x6, 48(sp)
    sd x7, 56(sp)
    sd x8, 64(sp)
    sd x9, 72(sp)
    sd x10, 80(sp)
    sd x11, 88(sp)
    sd x12, 96(sp)
    sd x13, 104(sp)
    sd x14, 112(sp)
    sd x15, 120(sp)
    sd x16, 128(sp)
    sd x17, 136(sp)
    sd x18, 144(sp)
    sd x19, 152(sp)
    sd x20, 160(sp)
    sd x21, 168(sp)
    sd x22, 176(sp)
    sd x23, 184(sp)
    sd x24, 192(sp)
    sd x25, 200(sp)
    sd x26, 208(sp)
    sd x27, 216(sp)
    sd x28, 224(sp)
    sd x29, 232(sp)
    sd x30, 240(sp)
    sd x31, 248(sp)
    csrr t0, sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
    csrr t0, sstatus
    sd t0, 264(sp)
    csrr t0, sscratch
    sd t0, 272(sp)
    csrw sscratch, zero


    # function parameters: scause, sepc
    csrr a0, scause
    csrr a1, sepc
    mv a2, sp
    call trap_handler
    # 2. call trap_handler

    ld t0, 272(sp)
    csrw sscratch, t0
    ld t0, 256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
    ld x31, 248(sp)
    ld x30, 240(sp)
    ld x29, 232(sp)
    ld x28, 224(sp)
    ld x27, 216(sp)
    ld x26, 208(sp)
    ld x25, 200(sp)
    ld x24, 192(sp)
    ld x23, 184(sp)
    ld x22, 176(sp)
    ld x21, 168(sp)
    ld x20, 160(sp)
    ld x19, 152(sp)
    ld x18, 144(sp)
    ld x17, 136(sp)
    ld x16, 128(sp)
    ld x15, 120(sp)
    ld x14, 112(sp)
    ld x13, 104(sp)
    ld x12, 96(sp)
    ld x11, 88(sp)
    ld x10, 80(sp)
    ld x9, 72(sp)
    ld x8, 64(sp)
    ld x7, 56(sp)
    ld x6, 48(sp)
    ld x5, 40(sp)
    ld x4, 32(sp)
    ld x3, 24(sp)
    ld x2, 16(sp) 
    ld x1, 8(sp)
    ld x0, 0(sp)
    addi sp, sp, 280    # restore stack pointer
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    csrrw sp, sscratch, sp
    bnez sp, no_switch_end
    csrrw sp, sscratch, sp

no_switch_end:
    sret    
    # 4. return from trap

    .extern dummy
    .globl __dummy
__dummy:
    # sepc 在 __switch_to 中被设置了，这里仅需交换栈指针
    # 交换 用户态 和 内核态 的 栈指针
    csrrw sp, sscratch, sp
    sret

    .globl __ret_from_fork
__ret_from_fork:
    # 目前的 sp 是内核态指针
    # load 之前存的 父线程 的寄存器
    ld x31, 248(sp)
    ld x30, 240(sp)
    ld x29, 232(sp)
    ld x28, 224(sp)
    ld x27, 216(sp)
    ld x26, 208(sp)
    ld x25, 200(sp)
    ld x24, 192(sp)
    ld x23, 184(sp)
    ld x22, 176(sp)
    ld x21, 168(sp)
    ld x20, 160(sp)
    ld x19, 152(sp)
    ld x18, 144(sp)
    ld x17, 136(sp)
    ld x16, 128(sp)
    ld x15, 120(sp)
    ld x14, 112(sp)
    ld x13, 104(sp)
    ld x12, 96(sp)
    ld x11, 88(sp)
    ld x10, 80(sp)
    ld x9, 72(sp)
    ld x8, 64(sp)
    ld x7, 56(sp)
    ld x6, 48(sp)
    ld x5, 40(sp)
    ld x4, 32(sp)
    ld x3, 24(sp)
    # ld x2, 16(sp) 不要 load sp
    ld x1, 8(sp)
    ld x0, 0(sp)

    addi sp, sp, 35 * 8    # restore stack pointer

    # 交换 sp 和 sscratch
    csrrw sp, sscratch, sp
    sret

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
    sd ra, 0(a0)
    sd sp, 8(a0)
    sd s0, 16(a0)
    sd s1, 24(a0)
    sd s2, 32(a0)
    sd s3, 40(a0)
    sd s4, 48(a0)
    sd s5, 56(a0)
    sd s6, 64(a0)
    sd s7, 72(a0)
    sd s8, 80(a0)
    sd s9, 88(a0)
    sd s10, 96(a0)
    sd s11, 104(a0)
    
    # save sepc, sstatus, sscratch
    csrr t0, sepc
    sd t0, 112(a0)
    csrr t0, sstatus
    sd t0, 120(a0)
    csrr t0, sscratch
    sd t0, 128(a0)

    # restore state from next process
    add a1, a1, 32
    ld ra, 0(a1)
    ld sp, 8(a1)
    ld s0, 16(a1)
    ld s1, 24(a1)
    ld s2, 32(a1)
    ld s3, 40(a1)
    ld s4, 48(a1)
    ld s5, 56(a1)
    ld s6, 64(a1)
    ld s7, 72(a1)
    ld s8, 80(a1)
    ld s9, 88(a1)
    ld s10, 96(a1)
    ld s11, 104(a1)

    # sepc, sstatus, sscratch
    ld t0, 112(a1)
    csrw sepc, t0
    ld t0, 120(a1)
    csrw sstatus, t0
    ld t0, 128(a1)
    csrw sscratch, t0

    # 切换页表
    ld t0, 136(a1)
    # t0 是地址, 需要转换为 PPN
    slli t0, t0, 8
    srli t0, t0, 20

    # set ASID
    li t1, 0
    slli t1, t1, 44

    # set mode
    li t2, 8
    slli t2, t2, 60

    # set satp
    or t0, t0, t1
    or t0, t0, t2
    csrw satp, t0

    # 刷新 TLB
    sfence.vma zero, zero
    ret