    .extern start_kernel
    .extern clock_set_next_event
    .extern _traps
    .extern mm_init
    .extern task_init
    .section .text.init
    .globl _start
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer

    call mm_init
    call task_init

    la t0, _traps
    csrw stvec, t0  # set stvec = _traps

    li t0, 32
    csrs sie, t0    # set sie[STIE] = 1
   
    call clock_set_next_event
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
    csrs sstatus, t0 # set sstatus[SIE] = 1

    call start_kernel

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 # <-- change to your stack size

    .globl boot_stack_top
boot_stack_top: