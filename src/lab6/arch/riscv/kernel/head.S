    .extern start_kernel
    .extern clock_set_next_event
    .extern _traps
    .extern mm_init
    .extern task_init
    .extern setup_vm
    .extern setup_vm_final
    .extern early_pgtbl
    .extern virtio_dev_init
    .extern mbr_init
    .section .text.init
    .globl _start
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer

    # 初始化虚拟内存
    call setup_vm
    call relocate
    
    call mm_init
    call setup_vm_final
    call task_init
    call virtio_dev_init
    call mbr_init

    la t0, _traps
    csrw stvec, t0  # set stvec = _traps

    li t0, 32
    csrs sie, t0    # set sie[STIE] = 1
   
    call clock_set_next_event
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    # li t0, 2
    # csrs sstatus, t0 # set sstatus[SIE] = 1

    call start_kernel

relocate:
    # set ra = ra + PA2VA_OFFSET
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    li t0, 0xffffffe000000000 - 0x80000000
    add ra, ra, t0
    csrw stvec, ra # set stvec = va(ra)
    add sp, sp, t0

    # need a fence to ensure the new translations are in use
    sfence.vma zero, zero

    # set satp with early_pgtbl

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    # set PPN
    la t0, early_pgtbl
    srl t0, t0, 12 

    # set ASID
    li t1, 0
    sll t1, t1, 44

    # set mode
    li t2, 8
    sll t2, t2, 60

    # set satp
    or t0, t0, t1
    or t0, t0, t2
    csrw satp, t0
    ret

    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 # <-- change to your stack size

    .globl boot_stack_top
boot_stack_top: