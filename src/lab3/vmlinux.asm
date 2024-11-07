
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

ffffffe000200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer
ffffffe000200000:	00006117          	auipc	sp,0x6
ffffffe000200004:	00010113          	mv	sp,sp

    # 初始化虚拟内存
    call setup_vm
ffffffe000200008:	6f9000ef          	jal	ffffffe000200f00 <setup_vm>
    call relocate
ffffffe00020000c:	034000ef          	jal	ffffffe000200040 <relocate>
    
    call mm_init
ffffffe000200010:	3f4000ef          	jal	ffffffe000200404 <mm_init>
    call setup_vm_final
ffffffe000200014:	7e1000ef          	jal	ffffffe000200ff4 <setup_vm_final>
    call task_init
ffffffe000200018:	43c000ef          	jal	ffffffe000200454 <task_init>

    la t0, _traps
ffffffe00020001c:	00000297          	auipc	t0,0x0
ffffffe000200020:	06428293          	addi	t0,t0,100 # ffffffe000200080 <_traps>
    csrw stvec, t0  # set stvec = _traps
ffffffe000200024:	10529073          	csrw	stvec,t0

    li t0, 32
ffffffe000200028:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
ffffffe00020002c:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
ffffffe000200030:	234000ef          	jal	ffffffe000200264 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe000200034:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200038:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe00020003c:	350010ef          	jal	ffffffe00020138c <start_kernel>

ffffffe000200040 <relocate>:
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    li t0, 0xffffffe000000000 - 0x80000000
ffffffe000200040:	fbf0029b          	addiw	t0,zero,-65
ffffffe000200044:	01f29293          	slli	t0,t0,0x1f
    add ra, ra, t0
ffffffe000200048:	005080b3          	add	ra,ra,t0
    # csrw stvec, ra
    add sp, sp, t0
ffffffe00020004c:	00510133          	add	sp,sp,t0

    # need a fence to ensure the new translations are in use
    sfence.vma zero, zero
ffffffe000200050:	12000073          	sfence.vma

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    # set PPN
    la t0, early_pgtbl
ffffffe000200054:	00007297          	auipc	t0,0x7
ffffffe000200058:	fac28293          	addi	t0,t0,-84 # ffffffe000207000 <early_pgtbl>
    srl t0, t0, 12 
ffffffe00020005c:	00c2d293          	srli	t0,t0,0xc

    # set ASID
    li t1, 0
ffffffe000200060:	00000313          	li	t1,0
    sll t1, t1, 44
ffffffe000200064:	02c31313          	slli	t1,t1,0x2c

    # set mode
    li t2, 8
ffffffe000200068:	00800393          	li	t2,8
    sll t2, t2, 60
ffffffe00020006c:	03c39393          	slli	t2,t2,0x3c

    # set satp
    or t0, t0, t1
ffffffe000200070:	0062e2b3          	or	t0,t0,t1
    or t0, t0, t2
ffffffe000200074:	0072e2b3          	or	t0,t0,t2
    csrw satp, t0
ffffffe000200078:	18029073          	csrw	satp,t0
    ret
ffffffe00020007c:	00008067          	ret

ffffffe000200080 <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
ffffffe000200080:	ef810113          	addi	sp,sp,-264 # ffffffe000205ef8 <_sbss+0xef8>
    sd x0, 0(sp)
ffffffe000200084:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
ffffffe000200088:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
ffffffe00020008c:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
ffffffe000200090:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
ffffffe000200094:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
ffffffe000200098:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
ffffffe00020009c:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
ffffffe0002000a0:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
ffffffe0002000a4:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
ffffffe0002000a8:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
ffffffe0002000ac:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
ffffffe0002000b0:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
ffffffe0002000b4:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
ffffffe0002000b8:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
ffffffe0002000bc:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
ffffffe0002000c0:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
ffffffe0002000c4:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
ffffffe0002000c8:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
ffffffe0002000cc:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
ffffffe0002000d0:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
ffffffe0002000d4:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
ffffffe0002000d8:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
ffffffe0002000dc:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
ffffffe0002000e0:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
ffffffe0002000e4:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
ffffffe0002000e8:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
ffffffe0002000ec:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
ffffffe0002000f0:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
ffffffe0002000f4:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
ffffffe0002000f8:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
ffffffe0002000fc:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
ffffffe000200100:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
ffffffe000200104:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
ffffffe000200108:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
ffffffe00020010c:	14202573          	csrr	a0,scause
    csrr a1, sepc
ffffffe000200110:	141025f3          	csrr	a1,sepc
    call trap_handler
ffffffe000200114:	585000ef          	jal	ffffffe000200e98 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
ffffffe000200118:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
ffffffe00020011c:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
ffffffe000200120:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
ffffffe000200124:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
ffffffe000200128:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
ffffffe00020012c:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
ffffffe000200130:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
ffffffe000200134:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
ffffffe000200138:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
ffffffe00020013c:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
ffffffe000200140:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
ffffffe000200144:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
ffffffe000200148:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
ffffffe00020014c:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
ffffffe000200150:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
ffffffe000200154:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
ffffffe000200158:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
ffffffe00020015c:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
ffffffe000200160:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
ffffffe000200164:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
ffffffe000200168:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
ffffffe00020016c:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
ffffffe000200170:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
ffffffe000200174:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
ffffffe000200178:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
ffffffe00020017c:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
ffffffe000200180:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
ffffffe000200184:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
ffffffe000200188:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
ffffffe00020018c:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
ffffffe000200190:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
ffffffe000200194:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
ffffffe000200198:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
ffffffe00020019c:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
ffffffe0002001a0:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
ffffffe0002001a4:	10200073          	sret

ffffffe0002001a8 <__dummy>:

    .extern dummy
    .globl __dummy
__dummy:
    # 将 sepc 设置为 dummy() 的地址，并使用 sret 从 S 模式中返回
    la t0, dummy
ffffffe0002001a8:	00000297          	auipc	t0,0x0
ffffffe0002001ac:	4e428293          	addi	t0,t0,1252 # ffffffe00020068c <dummy>
    csrw sepc, t0
ffffffe0002001b0:	14129073          	csrw	sepc,t0
    sret
ffffffe0002001b4:	10200073          	sret

ffffffe0002001b8 <__switch_to>:

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
ffffffe0002001b8:	02050513          	addi	a0,a0,32
    sd ra, 0(a0)
ffffffe0002001bc:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
ffffffe0002001c0:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
ffffffe0002001c4:	00853823          	sd	s0,16(a0)
    sd s1, 24(a0)
ffffffe0002001c8:	00953c23          	sd	s1,24(a0)
    sd s2, 32(a0)
ffffffe0002001cc:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
ffffffe0002001d0:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
ffffffe0002001d4:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
ffffffe0002001d8:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
ffffffe0002001dc:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
ffffffe0002001e0:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
ffffffe0002001e4:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
ffffffe0002001e8:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
ffffffe0002001ec:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
ffffffe0002001f0:	07b53423          	sd	s11,104(a0)

    # restore state from next process
    add a1, a1, 32
ffffffe0002001f4:	02058593          	addi	a1,a1,32
    ld ra, 0(a1)
ffffffe0002001f8:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
ffffffe0002001fc:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
ffffffe000200200:	0105b403          	ld	s0,16(a1)
    ld s1, 24(a1)
ffffffe000200204:	0185b483          	ld	s1,24(a1)
    ld s2, 32(a1)
ffffffe000200208:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
ffffffe00020020c:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
ffffffe000200210:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
ffffffe000200214:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
ffffffe000200218:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
ffffffe00020021c:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
ffffffe000200220:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
ffffffe000200224:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
ffffffe000200228:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
ffffffe00020022c:	0685bd83          	ld	s11,104(a1)

ffffffe000200230:	00008067          	ret

ffffffe000200234 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
ffffffe000200234:	fe010113          	addi	sp,sp,-32
ffffffe000200238:	00113c23          	sd	ra,24(sp)
ffffffe00020023c:	00813823          	sd	s0,16(sp)
ffffffe000200240:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
ffffffe000200244:	c01027f3          	rdtime	a5
ffffffe000200248:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
ffffffe00020024c:	fe843783          	ld	a5,-24(s0)
}
ffffffe000200250:	00078513          	mv	a0,a5
ffffffe000200254:	01813083          	ld	ra,24(sp)
ffffffe000200258:	01013403          	ld	s0,16(sp)
ffffffe00020025c:	02010113          	addi	sp,sp,32
ffffffe000200260:	00008067          	ret

ffffffe000200264 <clock_set_next_event>:

void clock_set_next_event() {
ffffffe000200264:	fe010113          	addi	sp,sp,-32
ffffffe000200268:	00113c23          	sd	ra,24(sp)
ffffffe00020026c:	00813823          	sd	s0,16(sp)
ffffffe000200270:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe000200274:	fc1ff0ef          	jal	ffffffe000200234 <get_cycles>
ffffffe000200278:	00050713          	mv	a4,a0
ffffffe00020027c:	00004797          	auipc	a5,0x4
ffffffe000200280:	d8478793          	addi	a5,a5,-636 # ffffffe000204000 <TIMECLOCK>
ffffffe000200284:	0007b783          	ld	a5,0(a5)
ffffffe000200288:	00f707b3          	add	a5,a4,a5
ffffffe00020028c:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe000200290:	fe843503          	ld	a0,-24(s0)
ffffffe000200294:	251000ef          	jal	ffffffe000200ce4 <sbi_set_timer>
ffffffe000200298:	00000013          	nop
ffffffe00020029c:	01813083          	ld	ra,24(sp)
ffffffe0002002a0:	01013403          	ld	s0,16(sp)
ffffffe0002002a4:	02010113          	addi	sp,sp,32
ffffffe0002002a8:	00008067          	ret

ffffffe0002002ac <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
ffffffe0002002ac:	fe010113          	addi	sp,sp,-32
ffffffe0002002b0:	00113c23          	sd	ra,24(sp)
ffffffe0002002b4:	00813823          	sd	s0,16(sp)
ffffffe0002002b8:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
ffffffe0002002bc:	00006797          	auipc	a5,0x6
ffffffe0002002c0:	d4478793          	addi	a5,a5,-700 # ffffffe000206000 <kmem>
ffffffe0002002c4:	0007b783          	ld	a5,0(a5)
ffffffe0002002c8:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
ffffffe0002002cc:	fe843783          	ld	a5,-24(s0)
ffffffe0002002d0:	0007b703          	ld	a4,0(a5)
ffffffe0002002d4:	00006797          	auipc	a5,0x6
ffffffe0002002d8:	d2c78793          	addi	a5,a5,-724 # ffffffe000206000 <kmem>
ffffffe0002002dc:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
ffffffe0002002e0:	00001637          	lui	a2,0x1
ffffffe0002002e4:	00000593          	li	a1,0
ffffffe0002002e8:	fe843503          	ld	a0,-24(s0)
ffffffe0002002ec:	17c020ef          	jal	ffffffe000202468 <memset>
    return (void *)r;
ffffffe0002002f0:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002f4:	00078513          	mv	a0,a5
ffffffe0002002f8:	01813083          	ld	ra,24(sp)
ffffffe0002002fc:	01013403          	ld	s0,16(sp)
ffffffe000200300:	02010113          	addi	sp,sp,32
ffffffe000200304:	00008067          	ret

ffffffe000200308 <kfree>:

void kfree(void *addr) {
ffffffe000200308:	fd010113          	addi	sp,sp,-48
ffffffe00020030c:	02113423          	sd	ra,40(sp)
ffffffe000200310:	02813023          	sd	s0,32(sp)
ffffffe000200314:	03010413          	addi	s0,sp,48
ffffffe000200318:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // LOG(RED "kfree(addr: %p)" CLEAR, addr);

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe00020031c:	fd843783          	ld	a5,-40(s0)
ffffffe000200320:	00078693          	mv	a3,a5
ffffffe000200324:	fd840793          	addi	a5,s0,-40
ffffffe000200328:	fffff737          	lui	a4,0xfffff
ffffffe00020032c:	00e6f733          	and	a4,a3,a4
ffffffe000200330:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe000200334:	fd843783          	ld	a5,-40(s0)
ffffffe000200338:	00001637          	lui	a2,0x1
ffffffe00020033c:	00000593          	li	a1,0
ffffffe000200340:	00078513          	mv	a0,a5
ffffffe000200344:	124020ef          	jal	ffffffe000202468 <memset>

    r = (struct run *)addr;
ffffffe000200348:	fd843783          	ld	a5,-40(s0)
ffffffe00020034c:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe000200350:	00006797          	auipc	a5,0x6
ffffffe000200354:	cb078793          	addi	a5,a5,-848 # ffffffe000206000 <kmem>
ffffffe000200358:	0007b703          	ld	a4,0(a5)
ffffffe00020035c:	fe843783          	ld	a5,-24(s0)
ffffffe000200360:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe000200364:	00006797          	auipc	a5,0x6
ffffffe000200368:	c9c78793          	addi	a5,a5,-868 # ffffffe000206000 <kmem>
ffffffe00020036c:	fe843703          	ld	a4,-24(s0)
ffffffe000200370:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe000200374:	00000013          	nop
}
ffffffe000200378:	02813083          	ld	ra,40(sp)
ffffffe00020037c:	02013403          	ld	s0,32(sp)
ffffffe000200380:	03010113          	addi	sp,sp,48
ffffffe000200384:	00008067          	ret

ffffffe000200388 <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe000200388:	fd010113          	addi	sp,sp,-48
ffffffe00020038c:	02113423          	sd	ra,40(sp)
ffffffe000200390:	02813023          	sd	s0,32(sp)
ffffffe000200394:	03010413          	addi	s0,sp,48
ffffffe000200398:	fca43c23          	sd	a0,-40(s0)
ffffffe00020039c:	fcb43823          	sd	a1,-48(s0)
    // LOG(RED "kfreerange(start: %p, end: %p)" CLEAR, start, end);
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe0002003a0:	fd843703          	ld	a4,-40(s0)
ffffffe0002003a4:	000017b7          	lui	a5,0x1
ffffffe0002003a8:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003ac:	00f70733          	add	a4,a4,a5
ffffffe0002003b0:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003b4:	00f777b3          	and	a5,a4,a5
ffffffe0002003b8:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003bc:	01c0006f          	j	ffffffe0002003d8 <kfreerange+0x50>
        kfree((void *)addr);
ffffffe0002003c0:	fe843503          	ld	a0,-24(s0)
ffffffe0002003c4:	f45ff0ef          	jal	ffffffe000200308 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003c8:	fe843703          	ld	a4,-24(s0)
ffffffe0002003cc:	000017b7          	lui	a5,0x1
ffffffe0002003d0:	00f707b3          	add	a5,a4,a5
ffffffe0002003d4:	fef43423          	sd	a5,-24(s0)
ffffffe0002003d8:	fe843703          	ld	a4,-24(s0)
ffffffe0002003dc:	000017b7          	lui	a5,0x1
ffffffe0002003e0:	00f70733          	add	a4,a4,a5
ffffffe0002003e4:	fd043783          	ld	a5,-48(s0)
ffffffe0002003e8:	fce7fce3          	bgeu	a5,a4,ffffffe0002003c0 <kfreerange+0x38>
    }
}
ffffffe0002003ec:	00000013          	nop
ffffffe0002003f0:	00000013          	nop
ffffffe0002003f4:	02813083          	ld	ra,40(sp)
ffffffe0002003f8:	02013403          	ld	s0,32(sp)
ffffffe0002003fc:	03010113          	addi	sp,sp,48
ffffffe000200400:	00008067          	ret

ffffffe000200404 <mm_init>:

void mm_init(void) {
ffffffe000200404:	ff010113          	addi	sp,sp,-16
ffffffe000200408:	00113423          	sd	ra,8(sp)
ffffffe00020040c:	00813023          	sd	s0,0(sp)
ffffffe000200410:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200414:	00003517          	auipc	a0,0x3
ffffffe000200418:	bf450513          	addi	a0,a0,-1036 # ffffffe000203008 <__func__.2+0x8>
ffffffe00020041c:	71d010ef          	jal	ffffffe000202338 <printk>
    kfreerange(_ekernel, (char *)VM_END);
ffffffe000200420:	c0100793          	li	a5,-1023
ffffffe000200424:	01b79593          	slli	a1,a5,0x1b
ffffffe000200428:	00009517          	auipc	a0,0x9
ffffffe00020042c:	bd850513          	addi	a0,a0,-1064 # ffffffe000209000 <_ebss>
ffffffe000200430:	f59ff0ef          	jal	ffffffe000200388 <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200434:	00003517          	auipc	a0,0x3
ffffffe000200438:	bec50513          	addi	a0,a0,-1044 # ffffffe000203020 <__func__.2+0x20>
ffffffe00020043c:	6fd010ef          	jal	ffffffe000202338 <printk>
}
ffffffe000200440:	00000013          	nop
ffffffe000200444:	00813083          	ld	ra,8(sp)
ffffffe000200448:	00013403          	ld	s0,0(sp)
ffffffe00020044c:	01010113          	addi	sp,sp,16
ffffffe000200450:	00008067          	ret

ffffffe000200454 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe000200454:	fe010113          	addi	sp,sp,-32
ffffffe000200458:	00113c23          	sd	ra,24(sp)
ffffffe00020045c:	00813823          	sd	s0,16(sp)
ffffffe000200460:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe000200464:	7e800513          	li	a0,2024
ffffffe000200468:	751010ef          	jal	ffffffe0002023b8 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe00020046c:	e41ff0ef          	jal	ffffffe0002002ac <kalloc>
ffffffe000200470:	00050713          	mv	a4,a0
ffffffe000200474:	00006797          	auipc	a5,0x6
ffffffe000200478:	b9478793          	addi	a5,a5,-1132 # ffffffe000206008 <idle>
ffffffe00020047c:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe000200480:	00006797          	auipc	a5,0x6
ffffffe000200484:	b8878793          	addi	a5,a5,-1144 # ffffffe000206008 <idle>
ffffffe000200488:	0007b783          	ld	a5,0(a5)
ffffffe00020048c:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe000200490:	00006797          	auipc	a5,0x6
ffffffe000200494:	b7878793          	addi	a5,a5,-1160 # ffffffe000206008 <idle>
ffffffe000200498:	0007b783          	ld	a5,0(a5)
ffffffe00020049c:	0007b823          	sd	zero,16(a5)
ffffffe0002004a0:	00006717          	auipc	a4,0x6
ffffffe0002004a4:	b6870713          	addi	a4,a4,-1176 # ffffffe000206008 <idle>
ffffffe0002004a8:	00073703          	ld	a4,0(a4)
ffffffe0002004ac:	0107b783          	ld	a5,16(a5)
ffffffe0002004b0:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe0002004b4:	00006797          	auipc	a5,0x6
ffffffe0002004b8:	b5478793          	addi	a5,a5,-1196 # ffffffe000206008 <idle>
ffffffe0002004bc:	0007b783          	ld	a5,0(a5)
ffffffe0002004c0:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe0002004c4:	00006797          	auipc	a5,0x6
ffffffe0002004c8:	b4478793          	addi	a5,a5,-1212 # ffffffe000206008 <idle>
ffffffe0002004cc:	0007b703          	ld	a4,0(a5)
ffffffe0002004d0:	00006797          	auipc	a5,0x6
ffffffe0002004d4:	b5078793          	addi	a5,a5,-1200 # ffffffe000206020 <task>
ffffffe0002004d8:	00e7b023          	sd	a4,0(a5)
ffffffe0002004dc:	00006797          	auipc	a5,0x6
ffffffe0002004e0:	b4478793          	addi	a5,a5,-1212 # ffffffe000206020 <task>
ffffffe0002004e4:	0007b703          	ld	a4,0(a5)
ffffffe0002004e8:	00006797          	auipc	a5,0x6
ffffffe0002004ec:	b2878793          	addi	a5,a5,-1240 # ffffffe000206010 <current>
ffffffe0002004f0:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002004f4:	00100793          	li	a5,1
ffffffe0002004f8:	fef42623          	sw	a5,-20(s0)
ffffffe0002004fc:	1600006f          	j	ffffffe00020065c <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
ffffffe000200500:	dadff0ef          	jal	ffffffe0002002ac <kalloc>
ffffffe000200504:	00050693          	mv	a3,a0
ffffffe000200508:	00006717          	auipc	a4,0x6
ffffffe00020050c:	b1870713          	addi	a4,a4,-1256 # ffffffe000206020 <task>
ffffffe000200510:	fec42783          	lw	a5,-20(s0)
ffffffe000200514:	00379793          	slli	a5,a5,0x3
ffffffe000200518:	00f707b3          	add	a5,a4,a5
ffffffe00020051c:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe000200520:	00006717          	auipc	a4,0x6
ffffffe000200524:	b0070713          	addi	a4,a4,-1280 # ffffffe000206020 <task>
ffffffe000200528:	fec42783          	lw	a5,-20(s0)
ffffffe00020052c:	00379793          	slli	a5,a5,0x3
ffffffe000200530:	00f707b3          	add	a5,a4,a5
ffffffe000200534:	0007b783          	ld	a5,0(a5)
ffffffe000200538:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe00020053c:	00006717          	auipc	a4,0x6
ffffffe000200540:	ae470713          	addi	a4,a4,-1308 # ffffffe000206020 <task>
ffffffe000200544:	fec42783          	lw	a5,-20(s0)
ffffffe000200548:	00379793          	slli	a5,a5,0x3
ffffffe00020054c:	00f707b3          	add	a5,a4,a5
ffffffe000200550:	0007b783          	ld	a5,0(a5)
ffffffe000200554:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe000200558:	6ad010ef          	jal	ffffffe000202404 <rand>
ffffffe00020055c:	00050793          	mv	a5,a0
ffffffe000200560:	00078713          	mv	a4,a5
ffffffe000200564:	0007069b          	sext.w	a3,a4
ffffffe000200568:	666667b7          	lui	a5,0x66666
ffffffe00020056c:	66778793          	addi	a5,a5,1639 # 66666667 <PHY_SIZE+0x5e666667>
ffffffe000200570:	02f687b3          	mul	a5,a3,a5
ffffffe000200574:	0207d793          	srli	a5,a5,0x20
ffffffe000200578:	4027d79b          	sraiw	a5,a5,0x2
ffffffe00020057c:	00078693          	mv	a3,a5
ffffffe000200580:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe000200584:	40f687bb          	subw	a5,a3,a5
ffffffe000200588:	00078693          	mv	a3,a5
ffffffe00020058c:	00068793          	mv	a5,a3
ffffffe000200590:	0027979b          	slliw	a5,a5,0x2
ffffffe000200594:	00d787bb          	addw	a5,a5,a3
ffffffe000200598:	0017979b          	slliw	a5,a5,0x1
ffffffe00020059c:	40f707bb          	subw	a5,a4,a5
ffffffe0002005a0:	0007879b          	sext.w	a5,a5
ffffffe0002005a4:	0017879b          	addiw	a5,a5,1
ffffffe0002005a8:	0007869b          	sext.w	a3,a5
ffffffe0002005ac:	00006717          	auipc	a4,0x6
ffffffe0002005b0:	a7470713          	addi	a4,a4,-1420 # ffffffe000206020 <task>
ffffffe0002005b4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005b8:	00379793          	slli	a5,a5,0x3
ffffffe0002005bc:	00f707b3          	add	a5,a4,a5
ffffffe0002005c0:	0007b783          	ld	a5,0(a5)
ffffffe0002005c4:	00068713          	mv	a4,a3
ffffffe0002005c8:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe0002005cc:	00006717          	auipc	a4,0x6
ffffffe0002005d0:	a5470713          	addi	a4,a4,-1452 # ffffffe000206020 <task>
ffffffe0002005d4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005d8:	00379793          	slli	a5,a5,0x3
ffffffe0002005dc:	00f707b3          	add	a5,a4,a5
ffffffe0002005e0:	0007b783          	ld	a5,0(a5)
ffffffe0002005e4:	fec42703          	lw	a4,-20(s0)
ffffffe0002005e8:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe0002005ec:	00006717          	auipc	a4,0x6
ffffffe0002005f0:	a3470713          	addi	a4,a4,-1484 # ffffffe000206020 <task>
ffffffe0002005f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005f8:	00379793          	slli	a5,a5,0x3
ffffffe0002005fc:	00f707b3          	add	a5,a4,a5
ffffffe000200600:	0007b783          	ld	a5,0(a5)
ffffffe000200604:	00000717          	auipc	a4,0x0
ffffffe000200608:	ba470713          	addi	a4,a4,-1116 # ffffffe0002001a8 <__dummy>
ffffffe00020060c:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe000200610:	00006717          	auipc	a4,0x6
ffffffe000200614:	a1070713          	addi	a4,a4,-1520 # ffffffe000206020 <task>
ffffffe000200618:	fec42783          	lw	a5,-20(s0)
ffffffe00020061c:	00379793          	slli	a5,a5,0x3
ffffffe000200620:	00f707b3          	add	a5,a4,a5
ffffffe000200624:	0007b783          	ld	a5,0(a5)
ffffffe000200628:	00078693          	mv	a3,a5
ffffffe00020062c:	00006717          	auipc	a4,0x6
ffffffe000200630:	9f470713          	addi	a4,a4,-1548 # ffffffe000206020 <task>
ffffffe000200634:	fec42783          	lw	a5,-20(s0)
ffffffe000200638:	00379793          	slli	a5,a5,0x3
ffffffe00020063c:	00f707b3          	add	a5,a4,a5
ffffffe000200640:	0007b783          	ld	a5,0(a5)
ffffffe000200644:	00001737          	lui	a4,0x1
ffffffe000200648:	00e68733          	add	a4,a3,a4
ffffffe00020064c:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200650:	fec42783          	lw	a5,-20(s0)
ffffffe000200654:	0017879b          	addiw	a5,a5,1
ffffffe000200658:	fef42623          	sw	a5,-20(s0)
ffffffe00020065c:	fec42783          	lw	a5,-20(s0)
ffffffe000200660:	0007871b          	sext.w	a4,a5
ffffffe000200664:	01f00793          	li	a5,31
ffffffe000200668:	e8e7dce3          	bge	a5,a4,ffffffe000200500 <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe00020066c:	00003517          	auipc	a0,0x3
ffffffe000200670:	9cc50513          	addi	a0,a0,-1588 # ffffffe000203038 <__func__.2+0x38>
ffffffe000200674:	4c5010ef          	jal	ffffffe000202338 <printk>
}
ffffffe000200678:	00000013          	nop
ffffffe00020067c:	01813083          	ld	ra,24(sp)
ffffffe000200680:	01013403          	ld	s0,16(sp)
ffffffe000200684:	02010113          	addi	sp,sp,32
ffffffe000200688:	00008067          	ret

ffffffe00020068c <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe00020068c:	fd010113          	addi	sp,sp,-48
ffffffe000200690:	02113423          	sd	ra,40(sp)
ffffffe000200694:	02813023          	sd	s0,32(sp)
ffffffe000200698:	03010413          	addi	s0,sp,48
    // LOG(RED);
    uint64_t MOD = 1000000007;
ffffffe00020069c:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe0002006a0:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe0002006a4:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe0002006a8:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe0002006ac:	fff00793          	li	a5,-1
ffffffe0002006b0:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002006b4:	fe442783          	lw	a5,-28(s0)
ffffffe0002006b8:	0007871b          	sext.w	a4,a5
ffffffe0002006bc:	fff00793          	li	a5,-1
ffffffe0002006c0:	00f70e63          	beq	a4,a5,ffffffe0002006dc <dummy+0x50>
ffffffe0002006c4:	00006797          	auipc	a5,0x6
ffffffe0002006c8:	94c78793          	addi	a5,a5,-1716 # ffffffe000206010 <current>
ffffffe0002006cc:	0007b783          	ld	a5,0(a5)
ffffffe0002006d0:	0087b703          	ld	a4,8(a5)
ffffffe0002006d4:	fe442783          	lw	a5,-28(s0)
ffffffe0002006d8:	fcf70ee3          	beq	a4,a5,ffffffe0002006b4 <dummy+0x28>
ffffffe0002006dc:	00006797          	auipc	a5,0x6
ffffffe0002006e0:	93478793          	addi	a5,a5,-1740 # ffffffe000206010 <current>
ffffffe0002006e4:	0007b783          	ld	a5,0(a5)
ffffffe0002006e8:	0087b783          	ld	a5,8(a5)
ffffffe0002006ec:	fc0784e3          	beqz	a5,ffffffe0002006b4 <dummy+0x28>
            if (current->counter == 1) {
ffffffe0002006f0:	00006797          	auipc	a5,0x6
ffffffe0002006f4:	92078793          	addi	a5,a5,-1760 # ffffffe000206010 <current>
ffffffe0002006f8:	0007b783          	ld	a5,0(a5)
ffffffe0002006fc:	0087b703          	ld	a4,8(a5)
ffffffe000200700:	00100793          	li	a5,1
ffffffe000200704:	00f71e63          	bne	a4,a5,ffffffe000200720 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe000200708:	00006797          	auipc	a5,0x6
ffffffe00020070c:	90878793          	addi	a5,a5,-1784 # ffffffe000206010 <current>
ffffffe000200710:	0007b783          	ld	a5,0(a5)
ffffffe000200714:	0087b703          	ld	a4,8(a5)
ffffffe000200718:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe00020071c:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe000200720:	00006797          	auipc	a5,0x6
ffffffe000200724:	8f078793          	addi	a5,a5,-1808 # ffffffe000206010 <current>
ffffffe000200728:	0007b783          	ld	a5,0(a5)
ffffffe00020072c:	0087b783          	ld	a5,8(a5)
ffffffe000200730:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe000200734:	fe843783          	ld	a5,-24(s0)
ffffffe000200738:	00178713          	addi	a4,a5,1
ffffffe00020073c:	fd843783          	ld	a5,-40(s0)
ffffffe000200740:	02f777b3          	remu	a5,a4,a5
ffffffe000200744:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe000200748:	00006797          	auipc	a5,0x6
ffffffe00020074c:	8c878793          	addi	a5,a5,-1848 # ffffffe000206010 <current>
ffffffe000200750:	0007b783          	ld	a5,0(a5)
ffffffe000200754:	0187b783          	ld	a5,24(a5)
ffffffe000200758:	fe843603          	ld	a2,-24(s0)
ffffffe00020075c:	00078593          	mv	a1,a5
ffffffe000200760:	00003517          	auipc	a0,0x3
ffffffe000200764:	8f050513          	addi	a0,a0,-1808 # ffffffe000203050 <__func__.2+0x50>
ffffffe000200768:	3d1010ef          	jal	ffffffe000202338 <printk>
            LOG(RED "%llu\n", current->thread.ra);
ffffffe00020076c:	00006797          	auipc	a5,0x6
ffffffe000200770:	8a478793          	addi	a5,a5,-1884 # ffffffe000206010 <current>
ffffffe000200774:	0007b783          	ld	a5,0(a5)
ffffffe000200778:	0207b783          	ld	a5,32(a5)
ffffffe00020077c:	00078713          	mv	a4,a5
ffffffe000200780:	00003697          	auipc	a3,0x3
ffffffe000200784:	88068693          	addi	a3,a3,-1920 # ffffffe000203000 <__func__.2>
ffffffe000200788:	04d00613          	li	a2,77
ffffffe00020078c:	00003597          	auipc	a1,0x3
ffffffe000200790:	8f458593          	addi	a1,a1,-1804 # ffffffe000203080 <__func__.2+0x80>
ffffffe000200794:	00003517          	auipc	a0,0x3
ffffffe000200798:	8f450513          	addi	a0,a0,-1804 # ffffffe000203088 <__func__.2+0x88>
ffffffe00020079c:	39d010ef          	jal	ffffffe000202338 <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002007a0:	f15ff06f          	j	ffffffe0002006b4 <dummy+0x28>

ffffffe0002007a4 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe0002007a4:	fd010113          	addi	sp,sp,-48
ffffffe0002007a8:	02113423          	sd	ra,40(sp)
ffffffe0002007ac:	02813023          	sd	s0,32(sp)
ffffffe0002007b0:	03010413          	addi	s0,sp,48
ffffffe0002007b4:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe0002007b8:	00003697          	auipc	a3,0x3
ffffffe0002007bc:	9d068693          	addi	a3,a3,-1584 # ffffffe000203188 <__func__.1>
ffffffe0002007c0:	06500613          	li	a2,101
ffffffe0002007c4:	00003597          	auipc	a1,0x3
ffffffe0002007c8:	8bc58593          	addi	a1,a1,-1860 # ffffffe000203080 <__func__.2+0x80>
ffffffe0002007cc:	00003517          	auipc	a0,0x3
ffffffe0002007d0:	8e450513          	addi	a0,a0,-1820 # ffffffe0002030b0 <__func__.2+0xb0>
ffffffe0002007d4:	365010ef          	jal	ffffffe000202338 <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe0002007d8:	00006797          	auipc	a5,0x6
ffffffe0002007dc:	83878793          	addi	a5,a5,-1992 # ffffffe000206010 <current>
ffffffe0002007e0:	0007b783          	ld	a5,0(a5)
ffffffe0002007e4:	0187b703          	ld	a4,24(a5)
ffffffe0002007e8:	fd843783          	ld	a5,-40(s0)
ffffffe0002007ec:	0187b783          	ld	a5,24(a5)
ffffffe0002007f0:	00003697          	auipc	a3,0x3
ffffffe0002007f4:	99868693          	addi	a3,a3,-1640 # ffffffe000203188 <__func__.1>
ffffffe0002007f8:	06600613          	li	a2,102
ffffffe0002007fc:	00003597          	auipc	a1,0x3
ffffffe000200800:	88458593          	addi	a1,a1,-1916 # ffffffe000203080 <__func__.2+0x80>
ffffffe000200804:	00003517          	auipc	a0,0x3
ffffffe000200808:	8cc50513          	addi	a0,a0,-1844 # ffffffe0002030d0 <__func__.2+0xd0>
ffffffe00020080c:	32d010ef          	jal	ffffffe000202338 <printk>
    if(current->pid != next->pid) {
ffffffe000200810:	00006797          	auipc	a5,0x6
ffffffe000200814:	80078793          	addi	a5,a5,-2048 # ffffffe000206010 <current>
ffffffe000200818:	0007b783          	ld	a5,0(a5)
ffffffe00020081c:	0187b703          	ld	a4,24(a5)
ffffffe000200820:	fd843783          	ld	a5,-40(s0)
ffffffe000200824:	0187b783          	ld	a5,24(a5)
ffffffe000200828:	06f70a63          	beq	a4,a5,ffffffe00020089c <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe00020082c:	00005797          	auipc	a5,0x5
ffffffe000200830:	7e478793          	addi	a5,a5,2020 # ffffffe000206010 <current>
ffffffe000200834:	0007b783          	ld	a5,0(a5)
ffffffe000200838:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe00020083c:	00005797          	auipc	a5,0x5
ffffffe000200840:	7d478793          	addi	a5,a5,2004 # ffffffe000206010 <current>
ffffffe000200844:	fd843703          	ld	a4,-40(s0)
ffffffe000200848:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe00020084c:	00005797          	auipc	a5,0x5
ffffffe000200850:	7c478793          	addi	a5,a5,1988 # ffffffe000206010 <current>
ffffffe000200854:	0007b783          	ld	a5,0(a5)
ffffffe000200858:	0187b703          	ld	a4,24(a5)
ffffffe00020085c:	00005797          	auipc	a5,0x5
ffffffe000200860:	7b478793          	addi	a5,a5,1972 # ffffffe000206010 <current>
ffffffe000200864:	0007b783          	ld	a5,0(a5)
ffffffe000200868:	0107b603          	ld	a2,16(a5)
ffffffe00020086c:	00005797          	auipc	a5,0x5
ffffffe000200870:	7a478793          	addi	a5,a5,1956 # ffffffe000206010 <current>
ffffffe000200874:	0007b783          	ld	a5,0(a5)
ffffffe000200878:	0087b783          	ld	a5,8(a5)
ffffffe00020087c:	00078693          	mv	a3,a5
ffffffe000200880:	00070593          	mv	a1,a4
ffffffe000200884:	00003517          	auipc	a0,0x3
ffffffe000200888:	88c50513          	addi	a0,a0,-1908 # ffffffe000203110 <__func__.2+0x110>
ffffffe00020088c:	2ad010ef          	jal	ffffffe000202338 <printk>
        __switch_to(prev, next);
ffffffe000200890:	fd843583          	ld	a1,-40(s0)
ffffffe000200894:	fe843503          	ld	a0,-24(s0)
ffffffe000200898:	921ff0ef          	jal	ffffffe0002001b8 <__switch_to>
    }
}
ffffffe00020089c:	00000013          	nop
ffffffe0002008a0:	02813083          	ld	ra,40(sp)
ffffffe0002008a4:	02013403          	ld	s0,32(sp)
ffffffe0002008a8:	03010113          	addi	sp,sp,48
ffffffe0002008ac:	00008067          	ret

ffffffe0002008b0 <do_timer>:

void do_timer() {
ffffffe0002008b0:	ff010113          	addi	sp,sp,-16
ffffffe0002008b4:	00113423          	sd	ra,8(sp)
ffffffe0002008b8:	00813023          	sd	s0,0(sp)
ffffffe0002008bc:	01010413          	addi	s0,sp,16
    LOG(RED);
ffffffe0002008c0:	00003697          	auipc	a3,0x3
ffffffe0002008c4:	8d868693          	addi	a3,a3,-1832 # ffffffe000203198 <__func__.0>
ffffffe0002008c8:	07000613          	li	a2,112
ffffffe0002008cc:	00002597          	auipc	a1,0x2
ffffffe0002008d0:	7b458593          	addi	a1,a1,1972 # ffffffe000203080 <__func__.2+0x80>
ffffffe0002008d4:	00002517          	auipc	a0,0x2
ffffffe0002008d8:	7dc50513          	addi	a0,a0,2012 # ffffffe0002030b0 <__func__.2+0xb0>
ffffffe0002008dc:	25d010ef          	jal	ffffffe000202338 <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe0002008e0:	00005797          	auipc	a5,0x5
ffffffe0002008e4:	73078793          	addi	a5,a5,1840 # ffffffe000206010 <current>
ffffffe0002008e8:	0007b783          	ld	a5,0(a5)
ffffffe0002008ec:	0187b703          	ld	a4,24(a5)
ffffffe0002008f0:	00005797          	auipc	a5,0x5
ffffffe0002008f4:	71878793          	addi	a5,a5,1816 # ffffffe000206008 <idle>
ffffffe0002008f8:	0007b783          	ld	a5,0(a5)
ffffffe0002008fc:	0187b783          	ld	a5,24(a5)
ffffffe000200900:	00f70c63          	beq	a4,a5,ffffffe000200918 <do_timer+0x68>
ffffffe000200904:	00005797          	auipc	a5,0x5
ffffffe000200908:	70c78793          	addi	a5,a5,1804 # ffffffe000206010 <current>
ffffffe00020090c:	0007b783          	ld	a5,0(a5)
ffffffe000200910:	0087b783          	ld	a5,8(a5)
ffffffe000200914:	00079663          	bnez	a5,ffffffe000200920 <do_timer+0x70>
        schedule();
ffffffe000200918:	038000ef          	jal	ffffffe000200950 <schedule>
ffffffe00020091c:	0200006f          	j	ffffffe00020093c <do_timer+0x8c>
    }
    else --(current->counter);
ffffffe000200920:	00005797          	auipc	a5,0x5
ffffffe000200924:	6f078793          	addi	a5,a5,1776 # ffffffe000206010 <current>
ffffffe000200928:	0007b783          	ld	a5,0(a5)
ffffffe00020092c:	0087b703          	ld	a4,8(a5)
ffffffe000200930:	fff70713          	addi	a4,a4,-1
ffffffe000200934:	00e7b423          	sd	a4,8(a5)
}
ffffffe000200938:	00000013          	nop
ffffffe00020093c:	00000013          	nop
ffffffe000200940:	00813083          	ld	ra,8(sp)
ffffffe000200944:	00013403          	ld	s0,0(sp)
ffffffe000200948:	01010113          	addi	sp,sp,16
ffffffe00020094c:	00008067          	ret

ffffffe000200950 <schedule>:

void schedule() {
ffffffe000200950:	fe010113          	addi	sp,sp,-32
ffffffe000200954:	00113c23          	sd	ra,24(sp)
ffffffe000200958:	00813823          	sd	s0,16(sp)
ffffffe00020095c:	02010413          	addi	s0,sp,32
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    // LOG(RED);
    struct task_struct *next = idle;
ffffffe000200960:	00005797          	auipc	a5,0x5
ffffffe000200964:	6a878793          	addi	a5,a5,1704 # ffffffe000206008 <idle>
ffffffe000200968:	0007b783          	ld	a5,0(a5)
ffffffe00020096c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200970:	00100793          	li	a5,1
ffffffe000200974:	fef42223          	sw	a5,-28(s0)
ffffffe000200978:	0540006f          	j	ffffffe0002009cc <schedule+0x7c>
        if(task[i]->counter > next->counter){
ffffffe00020097c:	00005717          	auipc	a4,0x5
ffffffe000200980:	6a470713          	addi	a4,a4,1700 # ffffffe000206020 <task>
ffffffe000200984:	fe442783          	lw	a5,-28(s0)
ffffffe000200988:	00379793          	slli	a5,a5,0x3
ffffffe00020098c:	00f707b3          	add	a5,a4,a5
ffffffe000200990:	0007b783          	ld	a5,0(a5)
ffffffe000200994:	0087b703          	ld	a4,8(a5)
ffffffe000200998:	fe843783          	ld	a5,-24(s0)
ffffffe00020099c:	0087b783          	ld	a5,8(a5)
ffffffe0002009a0:	02e7f063          	bgeu	a5,a4,ffffffe0002009c0 <schedule+0x70>
            next = task[i];
ffffffe0002009a4:	00005717          	auipc	a4,0x5
ffffffe0002009a8:	67c70713          	addi	a4,a4,1660 # ffffffe000206020 <task>
ffffffe0002009ac:	fe442783          	lw	a5,-28(s0)
ffffffe0002009b0:	00379793          	slli	a5,a5,0x3
ffffffe0002009b4:	00f707b3          	add	a5,a4,a5
ffffffe0002009b8:	0007b783          	ld	a5,0(a5)
ffffffe0002009bc:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009c0:	fe442783          	lw	a5,-28(s0)
ffffffe0002009c4:	0017879b          	addiw	a5,a5,1
ffffffe0002009c8:	fef42223          	sw	a5,-28(s0)
ffffffe0002009cc:	fe442783          	lw	a5,-28(s0)
ffffffe0002009d0:	0007871b          	sext.w	a4,a5
ffffffe0002009d4:	01f00793          	li	a5,31
ffffffe0002009d8:	fae7d2e3          	bge	a5,a4,ffffffe00020097c <schedule+0x2c>
        }
    }

    if(next->counter == 0) {
ffffffe0002009dc:	fe843783          	ld	a5,-24(s0)
ffffffe0002009e0:	0087b783          	ld	a5,8(a5)
ffffffe0002009e4:	0c079e63          	bnez	a5,ffffffe000200ac0 <schedule+0x170>
        printk("\n");
ffffffe0002009e8:	00002517          	auipc	a0,0x2
ffffffe0002009ec:	76050513          	addi	a0,a0,1888 # ffffffe000203148 <__func__.2+0x148>
ffffffe0002009f0:	149010ef          	jal	ffffffe000202338 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009f4:	00100793          	li	a5,1
ffffffe0002009f8:	fef42023          	sw	a5,-32(s0)
ffffffe0002009fc:	0ac0006f          	j	ffffffe000200aa8 <schedule+0x158>
            task[i]->counter = task[i]->priority;
ffffffe000200a00:	00005717          	auipc	a4,0x5
ffffffe000200a04:	62070713          	addi	a4,a4,1568 # ffffffe000206020 <task>
ffffffe000200a08:	fe042783          	lw	a5,-32(s0)
ffffffe000200a0c:	00379793          	slli	a5,a5,0x3
ffffffe000200a10:	00f707b3          	add	a5,a4,a5
ffffffe000200a14:	0007b703          	ld	a4,0(a5)
ffffffe000200a18:	00005697          	auipc	a3,0x5
ffffffe000200a1c:	60868693          	addi	a3,a3,1544 # ffffffe000206020 <task>
ffffffe000200a20:	fe042783          	lw	a5,-32(s0)
ffffffe000200a24:	00379793          	slli	a5,a5,0x3
ffffffe000200a28:	00f687b3          	add	a5,a3,a5
ffffffe000200a2c:	0007b783          	ld	a5,0(a5)
ffffffe000200a30:	01073703          	ld	a4,16(a4)
ffffffe000200a34:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200a38:	00005717          	auipc	a4,0x5
ffffffe000200a3c:	5e870713          	addi	a4,a4,1512 # ffffffe000206020 <task>
ffffffe000200a40:	fe042783          	lw	a5,-32(s0)
ffffffe000200a44:	00379793          	slli	a5,a5,0x3
ffffffe000200a48:	00f707b3          	add	a5,a4,a5
ffffffe000200a4c:	0007b783          	ld	a5,0(a5)
ffffffe000200a50:	0187b583          	ld	a1,24(a5)
ffffffe000200a54:	00005717          	auipc	a4,0x5
ffffffe000200a58:	5cc70713          	addi	a4,a4,1484 # ffffffe000206020 <task>
ffffffe000200a5c:	fe042783          	lw	a5,-32(s0)
ffffffe000200a60:	00379793          	slli	a5,a5,0x3
ffffffe000200a64:	00f707b3          	add	a5,a4,a5
ffffffe000200a68:	0007b783          	ld	a5,0(a5)
ffffffe000200a6c:	0107b603          	ld	a2,16(a5)
ffffffe000200a70:	00005717          	auipc	a4,0x5
ffffffe000200a74:	5b070713          	addi	a4,a4,1456 # ffffffe000206020 <task>
ffffffe000200a78:	fe042783          	lw	a5,-32(s0)
ffffffe000200a7c:	00379793          	slli	a5,a5,0x3
ffffffe000200a80:	00f707b3          	add	a5,a4,a5
ffffffe000200a84:	0007b783          	ld	a5,0(a5)
ffffffe000200a88:	0087b783          	ld	a5,8(a5)
ffffffe000200a8c:	00078693          	mv	a3,a5
ffffffe000200a90:	00002517          	auipc	a0,0x2
ffffffe000200a94:	6c050513          	addi	a0,a0,1728 # ffffffe000203150 <__func__.2+0x150>
ffffffe000200a98:	0a1010ef          	jal	ffffffe000202338 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a9c:	fe042783          	lw	a5,-32(s0)
ffffffe000200aa0:	0017879b          	addiw	a5,a5,1
ffffffe000200aa4:	fef42023          	sw	a5,-32(s0)
ffffffe000200aa8:	fe042783          	lw	a5,-32(s0)
ffffffe000200aac:	0007871b          	sext.w	a4,a5
ffffffe000200ab0:	01f00793          	li	a5,31
ffffffe000200ab4:	f4e7d6e3          	bge	a5,a4,ffffffe000200a00 <schedule+0xb0>
        }
        schedule();
ffffffe000200ab8:	e99ff0ef          	jal	ffffffe000200950 <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200abc:	00c0006f          	j	ffffffe000200ac8 <schedule+0x178>
        switch_to(next);
ffffffe000200ac0:	fe843503          	ld	a0,-24(s0)
ffffffe000200ac4:	ce1ff0ef          	jal	ffffffe0002007a4 <switch_to>
ffffffe000200ac8:	00000013          	nop
ffffffe000200acc:	01813083          	ld	ra,24(sp)
ffffffe000200ad0:	01013403          	ld	s0,16(sp)
ffffffe000200ad4:	02010113          	addi	sp,sp,32
ffffffe000200ad8:	00008067          	ret

ffffffe000200adc <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200adc:	f7010113          	addi	sp,sp,-144
ffffffe000200ae0:	08113423          	sd	ra,136(sp)
ffffffe000200ae4:	08813023          	sd	s0,128(sp)
ffffffe000200ae8:	06913c23          	sd	s1,120(sp)
ffffffe000200aec:	07213823          	sd	s2,112(sp)
ffffffe000200af0:	07313423          	sd	s3,104(sp)
ffffffe000200af4:	09010413          	addi	s0,sp,144
ffffffe000200af8:	faa43423          	sd	a0,-88(s0)
ffffffe000200afc:	fab43023          	sd	a1,-96(s0)
ffffffe000200b00:	f8c43c23          	sd	a2,-104(s0)
ffffffe000200b04:	f8d43823          	sd	a3,-112(s0)
ffffffe000200b08:	f8e43423          	sd	a4,-120(s0)
ffffffe000200b0c:	f8f43023          	sd	a5,-128(s0)
ffffffe000200b10:	f7043c23          	sd	a6,-136(s0)
ffffffe000200b14:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200b18:	fa843e03          	ld	t3,-88(s0)
ffffffe000200b1c:	fa043e83          	ld	t4,-96(s0)
ffffffe000200b20:	f9843f03          	ld	t5,-104(s0)
ffffffe000200b24:	f9043f83          	ld	t6,-112(s0)
ffffffe000200b28:	f8843283          	ld	t0,-120(s0)
ffffffe000200b2c:	f8043483          	ld	s1,-128(s0)
ffffffe000200b30:	f7843903          	ld	s2,-136(s0)
ffffffe000200b34:	f7043983          	ld	s3,-144(s0)
ffffffe000200b38:	000e0893          	mv	a7,t3
ffffffe000200b3c:	000e8813          	mv	a6,t4
ffffffe000200b40:	000f0513          	mv	a0,t5
ffffffe000200b44:	000f8593          	mv	a1,t6
ffffffe000200b48:	00028613          	mv	a2,t0
ffffffe000200b4c:	00048693          	mv	a3,s1
ffffffe000200b50:	00090713          	mv	a4,s2
ffffffe000200b54:	00098793          	mv	a5,s3
ffffffe000200b58:	00000073          	ecall
ffffffe000200b5c:	00050e93          	mv	t4,a0
ffffffe000200b60:	00058e13          	mv	t3,a1
ffffffe000200b64:	fbd43823          	sd	t4,-80(s0)
ffffffe000200b68:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200b6c:	fb043783          	ld	a5,-80(s0)
ffffffe000200b70:	fcf43023          	sd	a5,-64(s0)
ffffffe000200b74:	fb843783          	ld	a5,-72(s0)
ffffffe000200b78:	fcf43423          	sd	a5,-56(s0)
ffffffe000200b7c:	fc043703          	ld	a4,-64(s0)
ffffffe000200b80:	fc843783          	ld	a5,-56(s0)
ffffffe000200b84:	00070313          	mv	t1,a4
ffffffe000200b88:	00078393          	mv	t2,a5
ffffffe000200b8c:	00030713          	mv	a4,t1
ffffffe000200b90:	00038793          	mv	a5,t2
}
ffffffe000200b94:	00070513          	mv	a0,a4
ffffffe000200b98:	00078593          	mv	a1,a5
ffffffe000200b9c:	08813083          	ld	ra,136(sp)
ffffffe000200ba0:	08013403          	ld	s0,128(sp)
ffffffe000200ba4:	07813483          	ld	s1,120(sp)
ffffffe000200ba8:	07013903          	ld	s2,112(sp)
ffffffe000200bac:	06813983          	ld	s3,104(sp)
ffffffe000200bb0:	09010113          	addi	sp,sp,144
ffffffe000200bb4:	00008067          	ret

ffffffe000200bb8 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200bb8:	fc010113          	addi	sp,sp,-64
ffffffe000200bbc:	02113c23          	sd	ra,56(sp)
ffffffe000200bc0:	02813823          	sd	s0,48(sp)
ffffffe000200bc4:	03213423          	sd	s2,40(sp)
ffffffe000200bc8:	03313023          	sd	s3,32(sp)
ffffffe000200bcc:	04010413          	addi	s0,sp,64
ffffffe000200bd0:	00050793          	mv	a5,a0
ffffffe000200bd4:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200bd8:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200bdc:	00000893          	li	a7,0
ffffffe000200be0:	00000813          	li	a6,0
ffffffe000200be4:	00000793          	li	a5,0
ffffffe000200be8:	00000713          	li	a4,0
ffffffe000200bec:	00000693          	li	a3,0
ffffffe000200bf0:	00200593          	li	a1,2
ffffffe000200bf4:	44424537          	lui	a0,0x44424
ffffffe000200bf8:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200bfc:	ee1ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200c00:	00050713          	mv	a4,a0
ffffffe000200c04:	00058793          	mv	a5,a1
ffffffe000200c08:	fce43823          	sd	a4,-48(s0)
ffffffe000200c0c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c10:	fd043703          	ld	a4,-48(s0)
ffffffe000200c14:	fd843783          	ld	a5,-40(s0)
ffffffe000200c18:	00070913          	mv	s2,a4
ffffffe000200c1c:	00078993          	mv	s3,a5
ffffffe000200c20:	00090713          	mv	a4,s2
ffffffe000200c24:	00098793          	mv	a5,s3
}
ffffffe000200c28:	00070513          	mv	a0,a4
ffffffe000200c2c:	00078593          	mv	a1,a5
ffffffe000200c30:	03813083          	ld	ra,56(sp)
ffffffe000200c34:	03013403          	ld	s0,48(sp)
ffffffe000200c38:	02813903          	ld	s2,40(sp)
ffffffe000200c3c:	02013983          	ld	s3,32(sp)
ffffffe000200c40:	04010113          	addi	sp,sp,64
ffffffe000200c44:	00008067          	ret

ffffffe000200c48 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200c48:	fc010113          	addi	sp,sp,-64
ffffffe000200c4c:	02113c23          	sd	ra,56(sp)
ffffffe000200c50:	02813823          	sd	s0,48(sp)
ffffffe000200c54:	03213423          	sd	s2,40(sp)
ffffffe000200c58:	03313023          	sd	s3,32(sp)
ffffffe000200c5c:	04010413          	addi	s0,sp,64
ffffffe000200c60:	00050793          	mv	a5,a0
ffffffe000200c64:	00058713          	mv	a4,a1
ffffffe000200c68:	fcf42623          	sw	a5,-52(s0)
ffffffe000200c6c:	00070793          	mv	a5,a4
ffffffe000200c70:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200c74:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200c78:	fc846683          	lwu	a3,-56(s0)
ffffffe000200c7c:	00000893          	li	a7,0
ffffffe000200c80:	00000813          	li	a6,0
ffffffe000200c84:	00000793          	li	a5,0
ffffffe000200c88:	00000713          	li	a4,0
ffffffe000200c8c:	00000593          	li	a1,0
ffffffe000200c90:	53525537          	lui	a0,0x53525
ffffffe000200c94:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200c98:	e45ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200c9c:	00050713          	mv	a4,a0
ffffffe000200ca0:	00058793          	mv	a5,a1
ffffffe000200ca4:	fce43823          	sd	a4,-48(s0)
ffffffe000200ca8:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200cac:	fd043703          	ld	a4,-48(s0)
ffffffe000200cb0:	fd843783          	ld	a5,-40(s0)
ffffffe000200cb4:	00070913          	mv	s2,a4
ffffffe000200cb8:	00078993          	mv	s3,a5
ffffffe000200cbc:	00090713          	mv	a4,s2
ffffffe000200cc0:	00098793          	mv	a5,s3
}
ffffffe000200cc4:	00070513          	mv	a0,a4
ffffffe000200cc8:	00078593          	mv	a1,a5
ffffffe000200ccc:	03813083          	ld	ra,56(sp)
ffffffe000200cd0:	03013403          	ld	s0,48(sp)
ffffffe000200cd4:	02813903          	ld	s2,40(sp)
ffffffe000200cd8:	02013983          	ld	s3,32(sp)
ffffffe000200cdc:	04010113          	addi	sp,sp,64
ffffffe000200ce0:	00008067          	ret

ffffffe000200ce4 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200ce4:	fc010113          	addi	sp,sp,-64
ffffffe000200ce8:	02113c23          	sd	ra,56(sp)
ffffffe000200cec:	02813823          	sd	s0,48(sp)
ffffffe000200cf0:	03213423          	sd	s2,40(sp)
ffffffe000200cf4:	03313023          	sd	s3,32(sp)
ffffffe000200cf8:	04010413          	addi	s0,sp,64
ffffffe000200cfc:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200d00:	00000893          	li	a7,0
ffffffe000200d04:	00000813          	li	a6,0
ffffffe000200d08:	00000793          	li	a5,0
ffffffe000200d0c:	00000713          	li	a4,0
ffffffe000200d10:	00000693          	li	a3,0
ffffffe000200d14:	fc843603          	ld	a2,-56(s0)
ffffffe000200d18:	00000593          	li	a1,0
ffffffe000200d1c:	54495537          	lui	a0,0x54495
ffffffe000200d20:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200d24:	db9ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200d28:	00050713          	mv	a4,a0
ffffffe000200d2c:	00058793          	mv	a5,a1
ffffffe000200d30:	fce43823          	sd	a4,-48(s0)
ffffffe000200d34:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d38:	fd043703          	ld	a4,-48(s0)
ffffffe000200d3c:	fd843783          	ld	a5,-40(s0)
ffffffe000200d40:	00070913          	mv	s2,a4
ffffffe000200d44:	00078993          	mv	s3,a5
ffffffe000200d48:	00090713          	mv	a4,s2
ffffffe000200d4c:	00098793          	mv	a5,s3
}
ffffffe000200d50:	00070513          	mv	a0,a4
ffffffe000200d54:	00078593          	mv	a1,a5
ffffffe000200d58:	03813083          	ld	ra,56(sp)
ffffffe000200d5c:	03013403          	ld	s0,48(sp)
ffffffe000200d60:	02813903          	ld	s2,40(sp)
ffffffe000200d64:	02013983          	ld	s3,32(sp)
ffffffe000200d68:	04010113          	addi	sp,sp,64
ffffffe000200d6c:	00008067          	ret

ffffffe000200d70 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200d70:	fb010113          	addi	sp,sp,-80
ffffffe000200d74:	04113423          	sd	ra,72(sp)
ffffffe000200d78:	04813023          	sd	s0,64(sp)
ffffffe000200d7c:	03213c23          	sd	s2,56(sp)
ffffffe000200d80:	03313823          	sd	s3,48(sp)
ffffffe000200d84:	05010413          	addi	s0,sp,80
ffffffe000200d88:	fca43423          	sd	a0,-56(s0)
ffffffe000200d8c:	fcb43023          	sd	a1,-64(s0)
ffffffe000200d90:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200d94:	00000893          	li	a7,0
ffffffe000200d98:	00000813          	li	a6,0
ffffffe000200d9c:	00000793          	li	a5,0
ffffffe000200da0:	fb843703          	ld	a4,-72(s0)
ffffffe000200da4:	fc043683          	ld	a3,-64(s0)
ffffffe000200da8:	fc843603          	ld	a2,-56(s0)
ffffffe000200dac:	00100593          	li	a1,1
ffffffe000200db0:	44424537          	lui	a0,0x44424
ffffffe000200db4:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200db8:	d25ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200dbc:	00050713          	mv	a4,a0
ffffffe000200dc0:	00058793          	mv	a5,a1
ffffffe000200dc4:	fce43823          	sd	a4,-48(s0)
ffffffe000200dc8:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200dcc:	fd043703          	ld	a4,-48(s0)
ffffffe000200dd0:	fd843783          	ld	a5,-40(s0)
ffffffe000200dd4:	00070913          	mv	s2,a4
ffffffe000200dd8:	00078993          	mv	s3,a5
ffffffe000200ddc:	00090713          	mv	a4,s2
ffffffe000200de0:	00098793          	mv	a5,s3
}
ffffffe000200de4:	00070513          	mv	a0,a4
ffffffe000200de8:	00078593          	mv	a1,a5
ffffffe000200dec:	04813083          	ld	ra,72(sp)
ffffffe000200df0:	04013403          	ld	s0,64(sp)
ffffffe000200df4:	03813903          	ld	s2,56(sp)
ffffffe000200df8:	03013983          	ld	s3,48(sp)
ffffffe000200dfc:	05010113          	addi	sp,sp,80
ffffffe000200e00:	00008067          	ret

ffffffe000200e04 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200e04:	fb010113          	addi	sp,sp,-80
ffffffe000200e08:	04113423          	sd	ra,72(sp)
ffffffe000200e0c:	04813023          	sd	s0,64(sp)
ffffffe000200e10:	03213c23          	sd	s2,56(sp)
ffffffe000200e14:	03313823          	sd	s3,48(sp)
ffffffe000200e18:	05010413          	addi	s0,sp,80
ffffffe000200e1c:	fca43423          	sd	a0,-56(s0)
ffffffe000200e20:	fcb43023          	sd	a1,-64(s0)
ffffffe000200e24:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e28:	00000893          	li	a7,0
ffffffe000200e2c:	00000813          	li	a6,0
ffffffe000200e30:	00000793          	li	a5,0
ffffffe000200e34:	fb843703          	ld	a4,-72(s0)
ffffffe000200e38:	fc043683          	ld	a3,-64(s0)
ffffffe000200e3c:	fc843603          	ld	a2,-56(s0)
ffffffe000200e40:	00000593          	li	a1,0
ffffffe000200e44:	44424537          	lui	a0,0x44424
ffffffe000200e48:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e4c:	c91ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200e50:	00050713          	mv	a4,a0
ffffffe000200e54:	00058793          	mv	a5,a1
ffffffe000200e58:	fce43823          	sd	a4,-48(s0)
ffffffe000200e5c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e60:	fd043703          	ld	a4,-48(s0)
ffffffe000200e64:	fd843783          	ld	a5,-40(s0)
ffffffe000200e68:	00070913          	mv	s2,a4
ffffffe000200e6c:	00078993          	mv	s3,a5
ffffffe000200e70:	00090713          	mv	a4,s2
ffffffe000200e74:	00098793          	mv	a5,s3
ffffffe000200e78:	00070513          	mv	a0,a4
ffffffe000200e7c:	00078593          	mv	a1,a5
ffffffe000200e80:	04813083          	ld	ra,72(sp)
ffffffe000200e84:	04013403          	ld	s0,64(sp)
ffffffe000200e88:	03813903          	ld	s2,56(sp)
ffffffe000200e8c:	03013983          	ld	s3,48(sp)
ffffffe000200e90:	05010113          	addi	sp,sp,80
ffffffe000200e94:	00008067          	ret

ffffffe000200e98 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200e98:	fe010113          	addi	sp,sp,-32
ffffffe000200e9c:	00113c23          	sd	ra,24(sp)
ffffffe000200ea0:	00813823          	sd	s0,16(sp)
ffffffe000200ea4:	02010413          	addi	s0,sp,32
ffffffe000200ea8:	fea43423          	sd	a0,-24(s0)
ffffffe000200eac:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200eb0:	fe843783          	ld	a5,-24(s0)
ffffffe000200eb4:	0207d063          	bgez	a5,ffffffe000200ed4 <trap_handler+0x3c>
ffffffe000200eb8:	fe843783          	ld	a5,-24(s0)
ffffffe000200ebc:	0ff7f713          	zext.b	a4,a5
ffffffe000200ec0:	00500793          	li	a5,5
ffffffe000200ec4:	00f71863          	bne	a4,a5,ffffffe000200ed4 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200ec8:	b9cff0ef          	jal	ffffffe000200264 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200ecc:	9e5ff0ef          	jal	ffffffe0002008b0 <do_timer>
ffffffe000200ed0:	01c0006f          	j	ffffffe000200eec <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200ed4:	fe043603          	ld	a2,-32(s0)
ffffffe000200ed8:	fe843583          	ld	a1,-24(s0)
ffffffe000200edc:	00002517          	auipc	a0,0x2
ffffffe000200ee0:	2cc50513          	addi	a0,a0,716 # ffffffe0002031a8 <__func__.0+0x10>
ffffffe000200ee4:	454010ef          	jal	ffffffe000202338 <printk>
    }
ffffffe000200ee8:	00000013          	nop
ffffffe000200eec:	00000013          	nop
ffffffe000200ef0:	01813083          	ld	ra,24(sp)
ffffffe000200ef4:	01013403          	ld	s0,16(sp)
ffffffe000200ef8:	02010113          	addi	sp,sp,32
ffffffe000200efc:	00008067          	ret

ffffffe000200f00 <setup_vm>:
extern char _sdata[], _edata[];

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000200f00:	fe010113          	addi	sp,sp,-32
ffffffe000200f04:	00113c23          	sd	ra,24(sp)
ffffffe000200f08:	00813823          	sd	s0,16(sp)
ffffffe000200f0c:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200f10:	00001637          	lui	a2,0x1
ffffffe000200f14:	00000593          	li	a1,0
ffffffe000200f18:	00006517          	auipc	a0,0x6
ffffffe000200f1c:	0e850513          	addi	a0,a0,232 # ffffffe000207000 <early_pgtbl>
ffffffe000200f20:	548010ef          	jal	ffffffe000202468 <memset>
    //     early_pgtbl[i] |= ((1 << 4) - 1);
    // }


    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
ffffffe000200f24:	00200793          	li	a5,2
ffffffe000200f28:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200f2c:	00006717          	auipc	a4,0x6
ffffffe000200f30:	0d470713          	addi	a4,a4,212 # ffffffe000207000 <early_pgtbl>
ffffffe000200f34:	fe843783          	ld	a5,-24(s0)
ffffffe000200f38:	00379793          	slli	a5,a5,0x3
ffffffe000200f3c:	00f707b3          	add	a5,a4,a5
ffffffe000200f40:	20000737          	lui	a4,0x20000
ffffffe000200f44:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200f48:	00006717          	auipc	a4,0x6
ffffffe000200f4c:	0b870713          	addi	a4,a4,184 # ffffffe000207000 <early_pgtbl>
ffffffe000200f50:	fe843783          	ld	a5,-24(s0)
ffffffe000200f54:	00379793          	slli	a5,a5,0x3
ffffffe000200f58:	00f707b3          	add	a5,a4,a5
ffffffe000200f5c:	0007b783          	ld	a5,0(a5)
ffffffe000200f60:	00f7e713          	ori	a4,a5,15
ffffffe000200f64:	00006697          	auipc	a3,0x6
ffffffe000200f68:	09c68693          	addi	a3,a3,156 # ffffffe000207000 <early_pgtbl>
ffffffe000200f6c:	fe843783          	ld	a5,-24(s0)
ffffffe000200f70:	00379793          	slli	a5,a5,0x3
ffffffe000200f74:	00f687b3          	add	a5,a3,a5
ffffffe000200f78:	00e7b023          	sd	a4,0(a5)


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
ffffffe000200f7c:	18000793          	li	a5,384
ffffffe000200f80:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200f84:	00006717          	auipc	a4,0x6
ffffffe000200f88:	07c70713          	addi	a4,a4,124 # ffffffe000207000 <early_pgtbl>
ffffffe000200f8c:	fe843783          	ld	a5,-24(s0)
ffffffe000200f90:	00379793          	slli	a5,a5,0x3
ffffffe000200f94:	00f707b3          	add	a5,a4,a5
ffffffe000200f98:	20000737          	lui	a4,0x20000
ffffffe000200f9c:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200fa0:	00006717          	auipc	a4,0x6
ffffffe000200fa4:	06070713          	addi	a4,a4,96 # ffffffe000207000 <early_pgtbl>
ffffffe000200fa8:	fe843783          	ld	a5,-24(s0)
ffffffe000200fac:	00379793          	slli	a5,a5,0x3
ffffffe000200fb0:	00f707b3          	add	a5,a4,a5
ffffffe000200fb4:	0007b783          	ld	a5,0(a5)
ffffffe000200fb8:	00f7e713          	ori	a4,a5,15
ffffffe000200fbc:	00006697          	auipc	a3,0x6
ffffffe000200fc0:	04468693          	addi	a3,a3,68 # ffffffe000207000 <early_pgtbl>
ffffffe000200fc4:	fe843783          	ld	a5,-24(s0)
ffffffe000200fc8:	00379793          	slli	a5,a5,0x3
ffffffe000200fcc:	00f687b3          	add	a5,a3,a5
ffffffe000200fd0:	00e7b023          	sd	a4,0(a5)

    printk("...setup_vm done!\n");
ffffffe000200fd4:	00002517          	auipc	a0,0x2
ffffffe000200fd8:	21450513          	addi	a0,a0,532 # ffffffe0002031e8 <__func__.0+0x50>
ffffffe000200fdc:	35c010ef          	jal	ffffffe000202338 <printk>
}
ffffffe000200fe0:	00000013          	nop
ffffffe000200fe4:	01813083          	ld	ra,24(sp)
ffffffe000200fe8:	01013403          	ld	s0,16(sp)
ffffffe000200fec:	02010113          	addi	sp,sp,32
ffffffe000200ff0:	00008067          	ret

ffffffe000200ff4 <setup_vm_final>:

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
ffffffe000200ff4:	fd010113          	addi	sp,sp,-48
ffffffe000200ff8:	02113423          	sd	ra,40(sp)
ffffffe000200ffc:	02813023          	sd	s0,32(sp)
ffffffe000201000:	00913c23          	sd	s1,24(sp)
ffffffe000201004:	03010413          	addi	s0,sp,48
    memset(swapper_pg_dir, 0x0, PGSIZE);
ffffffe000201008:	00001637          	lui	a2,0x1
ffffffe00020100c:	00000593          	li	a1,0
ffffffe000201010:	00007517          	auipc	a0,0x7
ffffffe000201014:	ff050513          	addi	a0,a0,-16 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201018:	450010ef          	jal	ffffffe000202468 <memset>
    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    // LOG(BLUE "_stext: %p, _etext: %p" CLEAR, _stext, _etext);
    // LOG(BLUE "_srodata: %p, _erodata: %p" CLEAR, _srodata, _erodata);
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);
ffffffe00020101c:	fffff597          	auipc	a1,0xfffff
ffffffe000201020:	fe458593          	addi	a1,a1,-28 # ffffffe000200000 <_skernel>
ffffffe000201024:	fffff717          	auipc	a4,0xfffff
ffffffe000201028:	fdc70713          	addi	a4,a4,-36 # ffffffe000200000 <_skernel>
ffffffe00020102c:	04100793          	li	a5,65
ffffffe000201030:	01f79793          	slli	a5,a5,0x1f
ffffffe000201034:	00f70633          	add	a2,a4,a5
ffffffe000201038:	00001717          	auipc	a4,0x1
ffffffe00020103c:	4a870713          	addi	a4,a4,1192 # ffffffe0002024e0 <_etext>
ffffffe000201040:	fffff797          	auipc	a5,0xfffff
ffffffe000201044:	fc078793          	addi	a5,a5,-64 # ffffffe000200000 <_skernel>
ffffffe000201048:	40f707b3          	sub	a5,a4,a5
ffffffe00020104c:	00b00713          	li	a4,11
ffffffe000201050:	00078693          	mv	a3,a5
ffffffe000201054:	00007517          	auipc	a0,0x7
ffffffe000201058:	fac50513          	addi	a0,a0,-84 # ffffffe000208000 <swapper_pg_dir>
ffffffe00020105c:	118000ef          	jal	ffffffe000201174 <create_mapping>

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);
ffffffe000201060:	00002597          	auipc	a1,0x2
ffffffe000201064:	fa058593          	addi	a1,a1,-96 # ffffffe000203000 <__func__.2>
ffffffe000201068:	00002717          	auipc	a4,0x2
ffffffe00020106c:	f9870713          	addi	a4,a4,-104 # ffffffe000203000 <__func__.2>
ffffffe000201070:	04100793          	li	a5,65
ffffffe000201074:	01f79793          	slli	a5,a5,0x1f
ffffffe000201078:	00f70633          	add	a2,a4,a5
ffffffe00020107c:	00002717          	auipc	a4,0x2
ffffffe000201080:	2ec70713          	addi	a4,a4,748 # ffffffe000203368 <_erodata>
ffffffe000201084:	00002797          	auipc	a5,0x2
ffffffe000201088:	f7c78793          	addi	a5,a5,-132 # ffffffe000203000 <__func__.2>
ffffffe00020108c:	40f707b3          	sub	a5,a4,a5
ffffffe000201090:	00300713          	li	a4,3
ffffffe000201094:	00078693          	mv	a3,a5
ffffffe000201098:	00007517          	auipc	a0,0x7
ffffffe00020109c:	f6850513          	addi	a0,a0,-152 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002010a0:	0d4000ef          	jal	ffffffe000201174 <create_mapping>

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_sdata, (uint64_t)_sdata - PA2VA_OFFSET, VM_END -(uint64_t)_sdata, 0b0111);
ffffffe0002010a4:	00003597          	auipc	a1,0x3
ffffffe0002010a8:	f5c58593          	addi	a1,a1,-164 # ffffffe000204000 <TIMECLOCK>
ffffffe0002010ac:	00003717          	auipc	a4,0x3
ffffffe0002010b0:	f5470713          	addi	a4,a4,-172 # ffffffe000204000 <TIMECLOCK>
ffffffe0002010b4:	04100793          	li	a5,65
ffffffe0002010b8:	01f79793          	slli	a5,a5,0x1f
ffffffe0002010bc:	00f70633          	add	a2,a4,a5
ffffffe0002010c0:	00003797          	auipc	a5,0x3
ffffffe0002010c4:	f4078793          	addi	a5,a5,-192 # ffffffe000204000 <TIMECLOCK>
ffffffe0002010c8:	c0100713          	li	a4,-1023
ffffffe0002010cc:	01b71713          	slli	a4,a4,0x1b
ffffffe0002010d0:	40f707b3          	sub	a5,a4,a5
ffffffe0002010d4:	00700713          	li	a4,7
ffffffe0002010d8:	00078693          	mv	a3,a5
ffffffe0002010dc:	00007517          	auipc	a0,0x7
ffffffe0002010e0:	f2450513          	addi	a0,a0,-220 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002010e4:	090000ef          	jal	ffffffe000201174 <create_mapping>

    printk("...create_mapping done!\n");
ffffffe0002010e8:	00002517          	auipc	a0,0x2
ffffffe0002010ec:	11850513          	addi	a0,a0,280 # ffffffe000203200 <__func__.0+0x68>
ffffffe0002010f0:	248010ef          	jal	ffffffe000202338 <printk>
    // set satp with swapper_pg_dir
    csr_write(satp, ((uint64_t)swapper_pg_dir - PA2VA_OFFSET) >> 12 | (8llu << 60));
ffffffe0002010f4:	00007717          	auipc	a4,0x7
ffffffe0002010f8:	f0c70713          	addi	a4,a4,-244 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002010fc:	04100793          	li	a5,65
ffffffe000201100:	01f79793          	slli	a5,a5,0x1f
ffffffe000201104:	00f707b3          	add	a5,a4,a5
ffffffe000201108:	00c7d713          	srli	a4,a5,0xc
ffffffe00020110c:	fff00793          	li	a5,-1
ffffffe000201110:	03f79793          	slli	a5,a5,0x3f
ffffffe000201114:	00f767b3          	or	a5,a4,a5
ffffffe000201118:	fcf43c23          	sd	a5,-40(s0)
ffffffe00020111c:	fd843783          	ld	a5,-40(s0)
ffffffe000201120:	18079073          	csrw	satp,a5
    LOG(RED "satp: %p" CLEAR, csr_read(satp));
ffffffe000201124:	180027f3          	csrr	a5,satp
ffffffe000201128:	00078493          	mv	s1,a5
ffffffe00020112c:	00048793          	mv	a5,s1
ffffffe000201130:	00078713          	mv	a4,a5
ffffffe000201134:	00002697          	auipc	a3,0x2
ffffffe000201138:	17c68693          	addi	a3,a3,380 # ffffffe0002032b0 <__func__.1>
ffffffe00020113c:	05d00613          	li	a2,93
ffffffe000201140:	00002597          	auipc	a1,0x2
ffffffe000201144:	0e058593          	addi	a1,a1,224 # ffffffe000203220 <__func__.0+0x88>
ffffffe000201148:	00002517          	auipc	a0,0x2
ffffffe00020114c:	0e050513          	addi	a0,a0,224 # ffffffe000203228 <__func__.0+0x90>
ffffffe000201150:	1e8010ef          	jal	ffffffe000202338 <printk>
    // YOUR CODE HERE

    // flush TLB
    asm volatile("sfence.vma zero, zero");
ffffffe000201154:	12000073          	sfence.vma

    // flush icache
    asm volatile("fence.i");
ffffffe000201158:	0000100f          	fence.i
    return;
ffffffe00020115c:	00000013          	nop
}
ffffffe000201160:	02813083          	ld	ra,40(sp)
ffffffe000201164:	02013403          	ld	s0,32(sp)
ffffffe000201168:	01813483          	ld	s1,24(sp)
ffffffe00020116c:	03010113          	addi	sp,sp,48
ffffffe000201170:	00008067          	ret

ffffffe000201174 <create_mapping>:


/* 创建多级页表映射关系 */
/* 不要修改该接口的参数和返回值 */
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
ffffffe000201174:	f8010113          	addi	sp,sp,-128
ffffffe000201178:	06113c23          	sd	ra,120(sp)
ffffffe00020117c:	06813823          	sd	s0,112(sp)
ffffffe000201180:	08010413          	addi	s0,sp,128
ffffffe000201184:	faa43423          	sd	a0,-88(s0)
ffffffe000201188:	fab43023          	sd	a1,-96(s0)
ffffffe00020118c:	f8c43c23          	sd	a2,-104(s0)
ffffffe000201190:	f8d43823          	sd	a3,-112(s0)
ffffffe000201194:	f8e43423          	sd	a4,-120(s0)
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe000201198:	fe043423          	sd	zero,-24(s0)
ffffffe00020119c:	1a00006f          	j	ffffffe00020133c <create_mapping+0x1c8>
        uint64_t va_s = va + i;
ffffffe0002011a0:	fa043703          	ld	a4,-96(s0)
ffffffe0002011a4:	fe843783          	ld	a5,-24(s0)
ffffffe0002011a8:	00f707b3          	add	a5,a4,a5
ffffffe0002011ac:	fef43023          	sd	a5,-32(s0)
        uint64_t index2 = (va_s >> 30) & 0x1ff;
ffffffe0002011b0:	fe043783          	ld	a5,-32(s0)
ffffffe0002011b4:	01e7d793          	srli	a5,a5,0x1e
ffffffe0002011b8:	1ff7f793          	andi	a5,a5,511
ffffffe0002011bc:	fcf43c23          	sd	a5,-40(s0)
        uint64_t index1 = (va_s >> 21) & 0x1ff;
ffffffe0002011c0:	fe043783          	ld	a5,-32(s0)
ffffffe0002011c4:	0157d793          	srli	a5,a5,0x15
ffffffe0002011c8:	1ff7f793          	andi	a5,a5,511
ffffffe0002011cc:	fcf43823          	sd	a5,-48(s0)
        uint64_t index0 = (va_s >> 12) & 0x1ff;
ffffffe0002011d0:	fe043783          	ld	a5,-32(s0)
ffffffe0002011d4:	00c7d793          	srli	a5,a5,0xc
ffffffe0002011d8:	1ff7f793          	andi	a5,a5,511
ffffffe0002011dc:	fcf43423          	sd	a5,-56(s0)

        // LOG();
        if(!(pgtbl[index2] & 1)) {
ffffffe0002011e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002011e4:	00379793          	slli	a5,a5,0x3
ffffffe0002011e8:	fa843703          	ld	a4,-88(s0)
ffffffe0002011ec:	00f707b3          	add	a5,a4,a5
ffffffe0002011f0:	0007b783          	ld	a5,0(a5)
ffffffe0002011f4:	0017f793          	andi	a5,a5,1
ffffffe0002011f8:	02079e63          	bnez	a5,ffffffe000201234 <create_mapping+0xc0>
            pgtbl[index2] = ((uint64_t)kalloc() - PA2VA_OFFSET >> 12 << 10) | 1;
ffffffe0002011fc:	8b0ff0ef          	jal	ffffffe0002002ac <kalloc>
ffffffe000201200:	00050793          	mv	a5,a0
ffffffe000201204:	00078713          	mv	a4,a5
ffffffe000201208:	04100793          	li	a5,65
ffffffe00020120c:	01f79793          	slli	a5,a5,0x1f
ffffffe000201210:	00f707b3          	add	a5,a4,a5
ffffffe000201214:	00c7d793          	srli	a5,a5,0xc
ffffffe000201218:	00a79713          	slli	a4,a5,0xa
ffffffe00020121c:	fd843783          	ld	a5,-40(s0)
ffffffe000201220:	00379793          	slli	a5,a5,0x3
ffffffe000201224:	fa843683          	ld	a3,-88(s0)
ffffffe000201228:	00f687b3          	add	a5,a3,a5
ffffffe00020122c:	00176713          	ori	a4,a4,1
ffffffe000201230:	00e7b023          	sd	a4,0(a5)
            // LOG(RED "pgtbl[index2]: %p" CLEAR, pgtbl[index2]);
        }

        // LOG();
        uint64_t *pgtbl1 = (uint64_t *)((pgtbl[index2] >> 10 << 12) + PA2VA_OFFSET);
ffffffe000201234:	fd843783          	ld	a5,-40(s0)
ffffffe000201238:	00379793          	slli	a5,a5,0x3
ffffffe00020123c:	fa843703          	ld	a4,-88(s0)
ffffffe000201240:	00f707b3          	add	a5,a4,a5
ffffffe000201244:	0007b783          	ld	a5,0(a5)
ffffffe000201248:	00a7d793          	srli	a5,a5,0xa
ffffffe00020124c:	00c79713          	slli	a4,a5,0xc
ffffffe000201250:	fbf00793          	li	a5,-65
ffffffe000201254:	01f79793          	slli	a5,a5,0x1f
ffffffe000201258:	00f707b3          	add	a5,a4,a5
ffffffe00020125c:	fcf43023          	sd	a5,-64(s0)
        if(!(pgtbl1[index1] & 1)) {
ffffffe000201260:	fd043783          	ld	a5,-48(s0)
ffffffe000201264:	00379793          	slli	a5,a5,0x3
ffffffe000201268:	fc043703          	ld	a4,-64(s0)
ffffffe00020126c:	00f707b3          	add	a5,a4,a5
ffffffe000201270:	0007b783          	ld	a5,0(a5)
ffffffe000201274:	0017f793          	andi	a5,a5,1
ffffffe000201278:	02079e63          	bnez	a5,ffffffe0002012b4 <create_mapping+0x140>
            pgtbl1[index1] = ((uint64_t)kalloc() - PA2VA_OFFSET>> 12 << 10) | 1;
ffffffe00020127c:	830ff0ef          	jal	ffffffe0002002ac <kalloc>
ffffffe000201280:	00050793          	mv	a5,a0
ffffffe000201284:	00078713          	mv	a4,a5
ffffffe000201288:	04100793          	li	a5,65
ffffffe00020128c:	01f79793          	slli	a5,a5,0x1f
ffffffe000201290:	00f707b3          	add	a5,a4,a5
ffffffe000201294:	00c7d793          	srli	a5,a5,0xc
ffffffe000201298:	00a79713          	slli	a4,a5,0xa
ffffffe00020129c:	fd043783          	ld	a5,-48(s0)
ffffffe0002012a0:	00379793          	slli	a5,a5,0x3
ffffffe0002012a4:	fc043683          	ld	a3,-64(s0)
ffffffe0002012a8:	00f687b3          	add	a5,a3,a5
ffffffe0002012ac:	00176713          	ori	a4,a4,1
ffffffe0002012b0:	00e7b023          	sd	a4,0(a5)
            // LOG(RED "pgtbl1[index1]: %p" CLEAR, pgtbl1[index1]);
        }

        // LOG();
        uint64_t *pgtbl0 = (uint64_t *)((pgtbl1[index1] >> 10 << 12) + PA2VA_OFFSET);
ffffffe0002012b4:	fd043783          	ld	a5,-48(s0)
ffffffe0002012b8:	00379793          	slli	a5,a5,0x3
ffffffe0002012bc:	fc043703          	ld	a4,-64(s0)
ffffffe0002012c0:	00f707b3          	add	a5,a4,a5
ffffffe0002012c4:	0007b783          	ld	a5,0(a5)
ffffffe0002012c8:	00a7d793          	srli	a5,a5,0xa
ffffffe0002012cc:	00c79713          	slli	a4,a5,0xc
ffffffe0002012d0:	fbf00793          	li	a5,-65
ffffffe0002012d4:	01f79793          	slli	a5,a5,0x1f
ffffffe0002012d8:	00f707b3          	add	a5,a4,a5
ffffffe0002012dc:	faf43c23          	sd	a5,-72(s0)
        if(!(pgtbl0[index0] & 1)) {
ffffffe0002012e0:	fc843783          	ld	a5,-56(s0)
ffffffe0002012e4:	00379793          	slli	a5,a5,0x3
ffffffe0002012e8:	fb843703          	ld	a4,-72(s0)
ffffffe0002012ec:	00f707b3          	add	a5,a4,a5
ffffffe0002012f0:	0007b783          	ld	a5,0(a5)
ffffffe0002012f4:	0017f793          	andi	a5,a5,1
ffffffe0002012f8:	02079a63          	bnez	a5,ffffffe00020132c <create_mapping+0x1b8>
            pgtbl0[index0] = ((pa + i >> 12) << 10) | perm;
ffffffe0002012fc:	f9843703          	ld	a4,-104(s0)
ffffffe000201300:	fe843783          	ld	a5,-24(s0)
ffffffe000201304:	00f707b3          	add	a5,a4,a5
ffffffe000201308:	00c7d793          	srli	a5,a5,0xc
ffffffe00020130c:	00a79693          	slli	a3,a5,0xa
ffffffe000201310:	fc843783          	ld	a5,-56(s0)
ffffffe000201314:	00379793          	slli	a5,a5,0x3
ffffffe000201318:	fb843703          	ld	a4,-72(s0)
ffffffe00020131c:	00f707b3          	add	a5,a4,a5
ffffffe000201320:	f8843703          	ld	a4,-120(s0)
ffffffe000201324:	00e6e733          	or	a4,a3,a4
ffffffe000201328:	00e7b023          	sd	a4,0(a5)
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe00020132c:	fe843703          	ld	a4,-24(s0)
ffffffe000201330:	000017b7          	lui	a5,0x1
ffffffe000201334:	00f707b3          	add	a5,a4,a5
ffffffe000201338:	fef43423          	sd	a5,-24(s0)
ffffffe00020133c:	fe843703          	ld	a4,-24(s0)
ffffffe000201340:	f9043783          	ld	a5,-112(s0)
ffffffe000201344:	e4f76ee3          	bltu	a4,a5,ffffffe0002011a0 <create_mapping+0x2c>
            // LOG(RED "pgtbl0[index0]: %p" CLEAR, pgtbl0[index0]);
        }
    }
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
ffffffe000201348:	f8843883          	ld	a7,-120(s0)
ffffffe00020134c:	f9043803          	ld	a6,-112(s0)
ffffffe000201350:	f9843783          	ld	a5,-104(s0)
ffffffe000201354:	fa043703          	ld	a4,-96(s0)
ffffffe000201358:	00002697          	auipc	a3,0x2
ffffffe00020135c:	f6868693          	addi	a3,a3,-152 # ffffffe0002032c0 <__func__.0>
ffffffe000201360:	08f00613          	li	a2,143
ffffffe000201364:	00002597          	auipc	a1,0x2
ffffffe000201368:	ebc58593          	addi	a1,a1,-324 # ffffffe000203220 <__func__.0+0x88>
ffffffe00020136c:	00002517          	auipc	a0,0x2
ffffffe000201370:	eec50513          	addi	a0,a0,-276 # ffffffe000203258 <__func__.0+0xc0>
ffffffe000201374:	7c5000ef          	jal	ffffffe000202338 <printk>
ffffffe000201378:	00000013          	nop
ffffffe00020137c:	07813083          	ld	ra,120(sp)
ffffffe000201380:	07013403          	ld	s0,112(sp)
ffffffe000201384:	08010113          	addi	sp,sp,128
ffffffe000201388:	00008067          	ret

ffffffe00020138c <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe00020138c:	ff010113          	addi	sp,sp,-16
ffffffe000201390:	00113423          	sd	ra,8(sp)
ffffffe000201394:	00813023          	sd	s0,0(sp)
ffffffe000201398:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe00020139c:	00002517          	auipc	a0,0x2
ffffffe0002013a0:	f3450513          	addi	a0,a0,-204 # ffffffe0002032d0 <__func__.0+0x10>
ffffffe0002013a4:	795000ef          	jal	ffffffe000202338 <printk>
    printk(" ZJU Operating System\n");
ffffffe0002013a8:	00002517          	auipc	a0,0x2
ffffffe0002013ac:	f3050513          	addi	a0,a0,-208 # ffffffe0002032d8 <__func__.0+0x18>
ffffffe0002013b0:	789000ef          	jal	ffffffe000202338 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe0002013b4:	0b0000ef          	jal	ffffffe000201464 <run_idle>
    return 0;
ffffffe0002013b8:	00000793          	li	a5,0
}
ffffffe0002013bc:	00078513          	mv	a0,a5
ffffffe0002013c0:	00813083          	ld	ra,8(sp)
ffffffe0002013c4:	00013403          	ld	s0,0(sp)
ffffffe0002013c8:	01010113          	addi	sp,sp,16
ffffffe0002013cc:	00008067          	ret

ffffffe0002013d0 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe0002013d0:	ff010113          	addi	sp,sp,-16
ffffffe0002013d4:	00113423          	sd	ra,8(sp)
ffffffe0002013d8:	00813023          	sd	s0,0(sp)
ffffffe0002013dc:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe0002013e0:	00000593          	li	a1,0
ffffffe0002013e4:	00000513          	li	a0,0
ffffffe0002013e8:	861ff0ef          	jal	ffffffe000200c48 <sbi_system_reset>

ffffffe0002013ec <test>:
    __builtin_unreachable();
}

void test() {
ffffffe0002013ec:	fe010113          	addi	sp,sp,-32
ffffffe0002013f0:	00113c23          	sd	ra,24(sp)
ffffffe0002013f4:	00813823          	sd	s0,16(sp)
ffffffe0002013f8:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe0002013fc:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe000201400:	fec42783          	lw	a5,-20(s0)
ffffffe000201404:	0017879b          	addiw	a5,a5,1 # 1001 <PGSIZE+0x1>
ffffffe000201408:	fef42623          	sw	a5,-20(s0)
ffffffe00020140c:	fec42783          	lw	a5,-20(s0)
ffffffe000201410:	0007869b          	sext.w	a3,a5
ffffffe000201414:	55e64737          	lui	a4,0x55e64
ffffffe000201418:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <PHY_SIZE+0x4de63b89>
ffffffe00020141c:	02e68733          	mul	a4,a3,a4
ffffffe000201420:	02075713          	srli	a4,a4,0x20
ffffffe000201424:	4197571b          	sraiw	a4,a4,0x19
ffffffe000201428:	00070693          	mv	a3,a4
ffffffe00020142c:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffe000201430:	40e6873b          	subw	a4,a3,a4
ffffffe000201434:	00070693          	mv	a3,a4
ffffffe000201438:	05f5e737          	lui	a4,0x5f5e
ffffffe00020143c:	1007071b          	addiw	a4,a4,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe000201440:	02e6873b          	mulw	a4,a3,a4
ffffffe000201444:	40e787bb          	subw	a5,a5,a4
ffffffe000201448:	0007879b          	sext.w	a5,a5
ffffffe00020144c:	fa079ae3          	bnez	a5,ffffffe000201400 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe000201450:	00002517          	auipc	a0,0x2
ffffffe000201454:	ea050513          	addi	a0,a0,-352 # ffffffe0002032f0 <__func__.0+0x30>
ffffffe000201458:	6e1000ef          	jal	ffffffe000202338 <printk>
            i = 0;
ffffffe00020145c:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe000201460:	fa1ff06f          	j	ffffffe000201400 <test+0x14>

ffffffe000201464 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe000201464:	ff010113          	addi	sp,sp,-16
ffffffe000201468:	00113423          	sd	ra,8(sp)
ffffffe00020146c:	00813023          	sd	s0,0(sp)
ffffffe000201470:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe000201474:	0000006f          	j	ffffffe000201474 <run_idle+0x10>

ffffffe000201478 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe000201478:	fe010113          	addi	sp,sp,-32
ffffffe00020147c:	00113c23          	sd	ra,24(sp)
ffffffe000201480:	00813823          	sd	s0,16(sp)
ffffffe000201484:	02010413          	addi	s0,sp,32
ffffffe000201488:	00050793          	mv	a5,a0
ffffffe00020148c:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe000201490:	fec42783          	lw	a5,-20(s0)
ffffffe000201494:	0ff7f793          	zext.b	a5,a5
ffffffe000201498:	00078513          	mv	a0,a5
ffffffe00020149c:	f1cff0ef          	jal	ffffffe000200bb8 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe0002014a0:	fec42783          	lw	a5,-20(s0)
ffffffe0002014a4:	0ff7f793          	zext.b	a5,a5
ffffffe0002014a8:	0007879b          	sext.w	a5,a5
}
ffffffe0002014ac:	00078513          	mv	a0,a5
ffffffe0002014b0:	01813083          	ld	ra,24(sp)
ffffffe0002014b4:	01013403          	ld	s0,16(sp)
ffffffe0002014b8:	02010113          	addi	sp,sp,32
ffffffe0002014bc:	00008067          	ret

ffffffe0002014c0 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe0002014c0:	fe010113          	addi	sp,sp,-32
ffffffe0002014c4:	00113c23          	sd	ra,24(sp)
ffffffe0002014c8:	00813823          	sd	s0,16(sp)
ffffffe0002014cc:	02010413          	addi	s0,sp,32
ffffffe0002014d0:	00050793          	mv	a5,a0
ffffffe0002014d4:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe0002014d8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014dc:	0007871b          	sext.w	a4,a5
ffffffe0002014e0:	02000793          	li	a5,32
ffffffe0002014e4:	02f70263          	beq	a4,a5,ffffffe000201508 <isspace+0x48>
ffffffe0002014e8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014ec:	0007871b          	sext.w	a4,a5
ffffffe0002014f0:	00800793          	li	a5,8
ffffffe0002014f4:	00e7de63          	bge	a5,a4,ffffffe000201510 <isspace+0x50>
ffffffe0002014f8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014fc:	0007871b          	sext.w	a4,a5
ffffffe000201500:	00d00793          	li	a5,13
ffffffe000201504:	00e7c663          	blt	a5,a4,ffffffe000201510 <isspace+0x50>
ffffffe000201508:	00100793          	li	a5,1
ffffffe00020150c:	0080006f          	j	ffffffe000201514 <isspace+0x54>
ffffffe000201510:	00000793          	li	a5,0
}
ffffffe000201514:	00078513          	mv	a0,a5
ffffffe000201518:	01813083          	ld	ra,24(sp)
ffffffe00020151c:	01013403          	ld	s0,16(sp)
ffffffe000201520:	02010113          	addi	sp,sp,32
ffffffe000201524:	00008067          	ret

ffffffe000201528 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe000201528:	fb010113          	addi	sp,sp,-80
ffffffe00020152c:	04113423          	sd	ra,72(sp)
ffffffe000201530:	04813023          	sd	s0,64(sp)
ffffffe000201534:	05010413          	addi	s0,sp,80
ffffffe000201538:	fca43423          	sd	a0,-56(s0)
ffffffe00020153c:	fcb43023          	sd	a1,-64(s0)
ffffffe000201540:	00060793          	mv	a5,a2
ffffffe000201544:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe000201548:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe00020154c:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe000201550:	fc843783          	ld	a5,-56(s0)
ffffffe000201554:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe000201558:	0100006f          	j	ffffffe000201568 <strtol+0x40>
        p++;
ffffffe00020155c:	fd843783          	ld	a5,-40(s0)
ffffffe000201560:	00178793          	addi	a5,a5,1
ffffffe000201564:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe000201568:	fd843783          	ld	a5,-40(s0)
ffffffe00020156c:	0007c783          	lbu	a5,0(a5)
ffffffe000201570:	0007879b          	sext.w	a5,a5
ffffffe000201574:	00078513          	mv	a0,a5
ffffffe000201578:	f49ff0ef          	jal	ffffffe0002014c0 <isspace>
ffffffe00020157c:	00050793          	mv	a5,a0
ffffffe000201580:	fc079ee3          	bnez	a5,ffffffe00020155c <strtol+0x34>
    }

    if (*p == '-') {
ffffffe000201584:	fd843783          	ld	a5,-40(s0)
ffffffe000201588:	0007c783          	lbu	a5,0(a5)
ffffffe00020158c:	00078713          	mv	a4,a5
ffffffe000201590:	02d00793          	li	a5,45
ffffffe000201594:	00f71e63          	bne	a4,a5,ffffffe0002015b0 <strtol+0x88>
        neg = true;
ffffffe000201598:	00100793          	li	a5,1
ffffffe00020159c:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe0002015a0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015a4:	00178793          	addi	a5,a5,1
ffffffe0002015a8:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002015ac:	0240006f          	j	ffffffe0002015d0 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe0002015b0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015b4:	0007c783          	lbu	a5,0(a5)
ffffffe0002015b8:	00078713          	mv	a4,a5
ffffffe0002015bc:	02b00793          	li	a5,43
ffffffe0002015c0:	00f71863          	bne	a4,a5,ffffffe0002015d0 <strtol+0xa8>
        p++;
ffffffe0002015c4:	fd843783          	ld	a5,-40(s0)
ffffffe0002015c8:	00178793          	addi	a5,a5,1
ffffffe0002015cc:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe0002015d0:	fbc42783          	lw	a5,-68(s0)
ffffffe0002015d4:	0007879b          	sext.w	a5,a5
ffffffe0002015d8:	06079c63          	bnez	a5,ffffffe000201650 <strtol+0x128>
        if (*p == '0') {
ffffffe0002015dc:	fd843783          	ld	a5,-40(s0)
ffffffe0002015e0:	0007c783          	lbu	a5,0(a5)
ffffffe0002015e4:	00078713          	mv	a4,a5
ffffffe0002015e8:	03000793          	li	a5,48
ffffffe0002015ec:	04f71e63          	bne	a4,a5,ffffffe000201648 <strtol+0x120>
            p++;
ffffffe0002015f0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015f4:	00178793          	addi	a5,a5,1
ffffffe0002015f8:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe0002015fc:	fd843783          	ld	a5,-40(s0)
ffffffe000201600:	0007c783          	lbu	a5,0(a5)
ffffffe000201604:	00078713          	mv	a4,a5
ffffffe000201608:	07800793          	li	a5,120
ffffffe00020160c:	00f70c63          	beq	a4,a5,ffffffe000201624 <strtol+0xfc>
ffffffe000201610:	fd843783          	ld	a5,-40(s0)
ffffffe000201614:	0007c783          	lbu	a5,0(a5)
ffffffe000201618:	00078713          	mv	a4,a5
ffffffe00020161c:	05800793          	li	a5,88
ffffffe000201620:	00f71e63          	bne	a4,a5,ffffffe00020163c <strtol+0x114>
                base = 16;
ffffffe000201624:	01000793          	li	a5,16
ffffffe000201628:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe00020162c:	fd843783          	ld	a5,-40(s0)
ffffffe000201630:	00178793          	addi	a5,a5,1
ffffffe000201634:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201638:	0180006f          	j	ffffffe000201650 <strtol+0x128>
            } else {
                base = 8;
ffffffe00020163c:	00800793          	li	a5,8
ffffffe000201640:	faf42e23          	sw	a5,-68(s0)
ffffffe000201644:	00c0006f          	j	ffffffe000201650 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe000201648:	00a00793          	li	a5,10
ffffffe00020164c:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe000201650:	fd843783          	ld	a5,-40(s0)
ffffffe000201654:	0007c783          	lbu	a5,0(a5)
ffffffe000201658:	00078713          	mv	a4,a5
ffffffe00020165c:	02f00793          	li	a5,47
ffffffe000201660:	02e7f863          	bgeu	a5,a4,ffffffe000201690 <strtol+0x168>
ffffffe000201664:	fd843783          	ld	a5,-40(s0)
ffffffe000201668:	0007c783          	lbu	a5,0(a5)
ffffffe00020166c:	00078713          	mv	a4,a5
ffffffe000201670:	03900793          	li	a5,57
ffffffe000201674:	00e7ee63          	bltu	a5,a4,ffffffe000201690 <strtol+0x168>
            digit = *p - '0';
ffffffe000201678:	fd843783          	ld	a5,-40(s0)
ffffffe00020167c:	0007c783          	lbu	a5,0(a5)
ffffffe000201680:	0007879b          	sext.w	a5,a5
ffffffe000201684:	fd07879b          	addiw	a5,a5,-48
ffffffe000201688:	fcf42a23          	sw	a5,-44(s0)
ffffffe00020168c:	0800006f          	j	ffffffe00020170c <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe000201690:	fd843783          	ld	a5,-40(s0)
ffffffe000201694:	0007c783          	lbu	a5,0(a5)
ffffffe000201698:	00078713          	mv	a4,a5
ffffffe00020169c:	06000793          	li	a5,96
ffffffe0002016a0:	02e7f863          	bgeu	a5,a4,ffffffe0002016d0 <strtol+0x1a8>
ffffffe0002016a4:	fd843783          	ld	a5,-40(s0)
ffffffe0002016a8:	0007c783          	lbu	a5,0(a5)
ffffffe0002016ac:	00078713          	mv	a4,a5
ffffffe0002016b0:	07a00793          	li	a5,122
ffffffe0002016b4:	00e7ee63          	bltu	a5,a4,ffffffe0002016d0 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe0002016b8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016bc:	0007c783          	lbu	a5,0(a5)
ffffffe0002016c0:	0007879b          	sext.w	a5,a5
ffffffe0002016c4:	fa97879b          	addiw	a5,a5,-87
ffffffe0002016c8:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002016cc:	0400006f          	j	ffffffe00020170c <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe0002016d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002016d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002016d8:	00078713          	mv	a4,a5
ffffffe0002016dc:	04000793          	li	a5,64
ffffffe0002016e0:	06e7f863          	bgeu	a5,a4,ffffffe000201750 <strtol+0x228>
ffffffe0002016e4:	fd843783          	ld	a5,-40(s0)
ffffffe0002016e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002016ec:	00078713          	mv	a4,a5
ffffffe0002016f0:	05a00793          	li	a5,90
ffffffe0002016f4:	04e7ee63          	bltu	a5,a4,ffffffe000201750 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe0002016f8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016fc:	0007c783          	lbu	a5,0(a5)
ffffffe000201700:	0007879b          	sext.w	a5,a5
ffffffe000201704:	fc97879b          	addiw	a5,a5,-55
ffffffe000201708:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe00020170c:	fd442783          	lw	a5,-44(s0)
ffffffe000201710:	00078713          	mv	a4,a5
ffffffe000201714:	fbc42783          	lw	a5,-68(s0)
ffffffe000201718:	0007071b          	sext.w	a4,a4
ffffffe00020171c:	0007879b          	sext.w	a5,a5
ffffffe000201720:	02f75663          	bge	a4,a5,ffffffe00020174c <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe000201724:	fbc42703          	lw	a4,-68(s0)
ffffffe000201728:	fe843783          	ld	a5,-24(s0)
ffffffe00020172c:	02f70733          	mul	a4,a4,a5
ffffffe000201730:	fd442783          	lw	a5,-44(s0)
ffffffe000201734:	00f707b3          	add	a5,a4,a5
ffffffe000201738:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe00020173c:	fd843783          	ld	a5,-40(s0)
ffffffe000201740:	00178793          	addi	a5,a5,1
ffffffe000201744:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe000201748:	f09ff06f          	j	ffffffe000201650 <strtol+0x128>
            break;
ffffffe00020174c:	00000013          	nop
    }

    if (endptr) {
ffffffe000201750:	fc043783          	ld	a5,-64(s0)
ffffffe000201754:	00078863          	beqz	a5,ffffffe000201764 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe000201758:	fc043783          	ld	a5,-64(s0)
ffffffe00020175c:	fd843703          	ld	a4,-40(s0)
ffffffe000201760:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe000201764:	fe744783          	lbu	a5,-25(s0)
ffffffe000201768:	0ff7f793          	zext.b	a5,a5
ffffffe00020176c:	00078863          	beqz	a5,ffffffe00020177c <strtol+0x254>
ffffffe000201770:	fe843783          	ld	a5,-24(s0)
ffffffe000201774:	40f007b3          	neg	a5,a5
ffffffe000201778:	0080006f          	j	ffffffe000201780 <strtol+0x258>
ffffffe00020177c:	fe843783          	ld	a5,-24(s0)
}
ffffffe000201780:	00078513          	mv	a0,a5
ffffffe000201784:	04813083          	ld	ra,72(sp)
ffffffe000201788:	04013403          	ld	s0,64(sp)
ffffffe00020178c:	05010113          	addi	sp,sp,80
ffffffe000201790:	00008067          	ret

ffffffe000201794 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe000201794:	fd010113          	addi	sp,sp,-48
ffffffe000201798:	02113423          	sd	ra,40(sp)
ffffffe00020179c:	02813023          	sd	s0,32(sp)
ffffffe0002017a0:	03010413          	addi	s0,sp,48
ffffffe0002017a4:	fca43c23          	sd	a0,-40(s0)
ffffffe0002017a8:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe0002017ac:	fd043783          	ld	a5,-48(s0)
ffffffe0002017b0:	00079863          	bnez	a5,ffffffe0002017c0 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe0002017b4:	00002797          	auipc	a5,0x2
ffffffe0002017b8:	b5478793          	addi	a5,a5,-1196 # ffffffe000203308 <__func__.0+0x48>
ffffffe0002017bc:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe0002017c0:	fd043783          	ld	a5,-48(s0)
ffffffe0002017c4:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe0002017c8:	0240006f          	j	ffffffe0002017ec <puts_wo_nl+0x58>
        putch(*p++);
ffffffe0002017cc:	fe843783          	ld	a5,-24(s0)
ffffffe0002017d0:	00178713          	addi	a4,a5,1
ffffffe0002017d4:	fee43423          	sd	a4,-24(s0)
ffffffe0002017d8:	0007c783          	lbu	a5,0(a5)
ffffffe0002017dc:	0007871b          	sext.w	a4,a5
ffffffe0002017e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002017e4:	00070513          	mv	a0,a4
ffffffe0002017e8:	000780e7          	jalr	a5
    while (*p) {
ffffffe0002017ec:	fe843783          	ld	a5,-24(s0)
ffffffe0002017f0:	0007c783          	lbu	a5,0(a5)
ffffffe0002017f4:	fc079ce3          	bnez	a5,ffffffe0002017cc <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe0002017f8:	fe843703          	ld	a4,-24(s0)
ffffffe0002017fc:	fd043783          	ld	a5,-48(s0)
ffffffe000201800:	40f707b3          	sub	a5,a4,a5
ffffffe000201804:	0007879b          	sext.w	a5,a5
}
ffffffe000201808:	00078513          	mv	a0,a5
ffffffe00020180c:	02813083          	ld	ra,40(sp)
ffffffe000201810:	02013403          	ld	s0,32(sp)
ffffffe000201814:	03010113          	addi	sp,sp,48
ffffffe000201818:	00008067          	ret

ffffffe00020181c <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe00020181c:	f9010113          	addi	sp,sp,-112
ffffffe000201820:	06113423          	sd	ra,104(sp)
ffffffe000201824:	06813023          	sd	s0,96(sp)
ffffffe000201828:	07010413          	addi	s0,sp,112
ffffffe00020182c:	faa43423          	sd	a0,-88(s0)
ffffffe000201830:	fab43023          	sd	a1,-96(s0)
ffffffe000201834:	00060793          	mv	a5,a2
ffffffe000201838:	f8d43823          	sd	a3,-112(s0)
ffffffe00020183c:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe000201840:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201844:	0ff7f793          	zext.b	a5,a5
ffffffe000201848:	02078663          	beqz	a5,ffffffe000201874 <print_dec_int+0x58>
ffffffe00020184c:	fa043703          	ld	a4,-96(s0)
ffffffe000201850:	fff00793          	li	a5,-1
ffffffe000201854:	03f79793          	slli	a5,a5,0x3f
ffffffe000201858:	00f71e63          	bne	a4,a5,ffffffe000201874 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe00020185c:	00002597          	auipc	a1,0x2
ffffffe000201860:	ab458593          	addi	a1,a1,-1356 # ffffffe000203310 <__func__.0+0x50>
ffffffe000201864:	fa843503          	ld	a0,-88(s0)
ffffffe000201868:	f2dff0ef          	jal	ffffffe000201794 <puts_wo_nl>
ffffffe00020186c:	00050793          	mv	a5,a0
ffffffe000201870:	2c80006f          	j	ffffffe000201b38 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe000201874:	f9043783          	ld	a5,-112(s0)
ffffffe000201878:	00c7a783          	lw	a5,12(a5)
ffffffe00020187c:	00079a63          	bnez	a5,ffffffe000201890 <print_dec_int+0x74>
ffffffe000201880:	fa043783          	ld	a5,-96(s0)
ffffffe000201884:	00079663          	bnez	a5,ffffffe000201890 <print_dec_int+0x74>
        return 0;
ffffffe000201888:	00000793          	li	a5,0
ffffffe00020188c:	2ac0006f          	j	ffffffe000201b38 <print_dec_int+0x31c>
    }

    bool neg = false;
ffffffe000201890:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe000201894:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201898:	0ff7f793          	zext.b	a5,a5
ffffffe00020189c:	02078063          	beqz	a5,ffffffe0002018bc <print_dec_int+0xa0>
ffffffe0002018a0:	fa043783          	ld	a5,-96(s0)
ffffffe0002018a4:	0007dc63          	bgez	a5,ffffffe0002018bc <print_dec_int+0xa0>
        neg = true;
ffffffe0002018a8:	00100793          	li	a5,1
ffffffe0002018ac:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe0002018b0:	fa043783          	ld	a5,-96(s0)
ffffffe0002018b4:	40f007b3          	neg	a5,a5
ffffffe0002018b8:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe0002018bc:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe0002018c0:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002018c4:	0ff7f793          	zext.b	a5,a5
ffffffe0002018c8:	02078863          	beqz	a5,ffffffe0002018f8 <print_dec_int+0xdc>
ffffffe0002018cc:	fef44783          	lbu	a5,-17(s0)
ffffffe0002018d0:	0ff7f793          	zext.b	a5,a5
ffffffe0002018d4:	00079e63          	bnez	a5,ffffffe0002018f0 <print_dec_int+0xd4>
ffffffe0002018d8:	f9043783          	ld	a5,-112(s0)
ffffffe0002018dc:	0057c783          	lbu	a5,5(a5)
ffffffe0002018e0:	00079863          	bnez	a5,ffffffe0002018f0 <print_dec_int+0xd4>
ffffffe0002018e4:	f9043783          	ld	a5,-112(s0)
ffffffe0002018e8:	0047c783          	lbu	a5,4(a5)
ffffffe0002018ec:	00078663          	beqz	a5,ffffffe0002018f8 <print_dec_int+0xdc>
ffffffe0002018f0:	00100793          	li	a5,1
ffffffe0002018f4:	0080006f          	j	ffffffe0002018fc <print_dec_int+0xe0>
ffffffe0002018f8:	00000793          	li	a5,0
ffffffe0002018fc:	fcf40ba3          	sb	a5,-41(s0)
ffffffe000201900:	fd744783          	lbu	a5,-41(s0)
ffffffe000201904:	0017f793          	andi	a5,a5,1
ffffffe000201908:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe00020190c:	fa043683          	ld	a3,-96(s0)
ffffffe000201910:	00002797          	auipc	a5,0x2
ffffffe000201914:	a1878793          	addi	a5,a5,-1512 # ffffffe000203328 <__func__.0+0x68>
ffffffe000201918:	0007b783          	ld	a5,0(a5)
ffffffe00020191c:	02f6b7b3          	mulhu	a5,a3,a5
ffffffe000201920:	0037d713          	srli	a4,a5,0x3
ffffffe000201924:	00070793          	mv	a5,a4
ffffffe000201928:	00279793          	slli	a5,a5,0x2
ffffffe00020192c:	00e787b3          	add	a5,a5,a4
ffffffe000201930:	00179793          	slli	a5,a5,0x1
ffffffe000201934:	40f68733          	sub	a4,a3,a5
ffffffe000201938:	0ff77713          	zext.b	a4,a4
ffffffe00020193c:	fe842783          	lw	a5,-24(s0)
ffffffe000201940:	0017869b          	addiw	a3,a5,1
ffffffe000201944:	fed42423          	sw	a3,-24(s0)
ffffffe000201948:	0307071b          	addiw	a4,a4,48
ffffffe00020194c:	0ff77713          	zext.b	a4,a4
ffffffe000201950:	ff078793          	addi	a5,a5,-16
ffffffe000201954:	008787b3          	add	a5,a5,s0
ffffffe000201958:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe00020195c:	fa043703          	ld	a4,-96(s0)
ffffffe000201960:	00002797          	auipc	a5,0x2
ffffffe000201964:	9c878793          	addi	a5,a5,-1592 # ffffffe000203328 <__func__.0+0x68>
ffffffe000201968:	0007b783          	ld	a5,0(a5)
ffffffe00020196c:	02f737b3          	mulhu	a5,a4,a5
ffffffe000201970:	0037d793          	srli	a5,a5,0x3
ffffffe000201974:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe000201978:	fa043783          	ld	a5,-96(s0)
ffffffe00020197c:	f80798e3          	bnez	a5,ffffffe00020190c <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe000201980:	f9043783          	ld	a5,-112(s0)
ffffffe000201984:	00c7a703          	lw	a4,12(a5)
ffffffe000201988:	fff00793          	li	a5,-1
ffffffe00020198c:	02f71063          	bne	a4,a5,ffffffe0002019ac <print_dec_int+0x190>
ffffffe000201990:	f9043783          	ld	a5,-112(s0)
ffffffe000201994:	0037c783          	lbu	a5,3(a5)
ffffffe000201998:	00078a63          	beqz	a5,ffffffe0002019ac <print_dec_int+0x190>
        flags->prec = flags->width;
ffffffe00020199c:	f9043783          	ld	a5,-112(s0)
ffffffe0002019a0:	0087a703          	lw	a4,8(a5)
ffffffe0002019a4:	f9043783          	ld	a5,-112(s0)
ffffffe0002019a8:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe0002019ac:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe0002019b0:	f9043783          	ld	a5,-112(s0)
ffffffe0002019b4:	0087a703          	lw	a4,8(a5)
ffffffe0002019b8:	fe842783          	lw	a5,-24(s0)
ffffffe0002019bc:	fcf42823          	sw	a5,-48(s0)
ffffffe0002019c0:	f9043783          	ld	a5,-112(s0)
ffffffe0002019c4:	00c7a783          	lw	a5,12(a5)
ffffffe0002019c8:	fcf42623          	sw	a5,-52(s0)
ffffffe0002019cc:	fd042783          	lw	a5,-48(s0)
ffffffe0002019d0:	00078593          	mv	a1,a5
ffffffe0002019d4:	fcc42783          	lw	a5,-52(s0)
ffffffe0002019d8:	00078613          	mv	a2,a5
ffffffe0002019dc:	0006069b          	sext.w	a3,a2
ffffffe0002019e0:	0005879b          	sext.w	a5,a1
ffffffe0002019e4:	00f6d463          	bge	a3,a5,ffffffe0002019ec <print_dec_int+0x1d0>
ffffffe0002019e8:	00058613          	mv	a2,a1
ffffffe0002019ec:	0006079b          	sext.w	a5,a2
ffffffe0002019f0:	40f707bb          	subw	a5,a4,a5
ffffffe0002019f4:	0007871b          	sext.w	a4,a5
ffffffe0002019f8:	fd744783          	lbu	a5,-41(s0)
ffffffe0002019fc:	0007879b          	sext.w	a5,a5
ffffffe000201a00:	40f707bb          	subw	a5,a4,a5
ffffffe000201a04:	fef42023          	sw	a5,-32(s0)
ffffffe000201a08:	0280006f          	j	ffffffe000201a30 <print_dec_int+0x214>
        putch(' ');
ffffffe000201a0c:	fa843783          	ld	a5,-88(s0)
ffffffe000201a10:	02000513          	li	a0,32
ffffffe000201a14:	000780e7          	jalr	a5
        ++written;
ffffffe000201a18:	fe442783          	lw	a5,-28(s0)
ffffffe000201a1c:	0017879b          	addiw	a5,a5,1
ffffffe000201a20:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a24:	fe042783          	lw	a5,-32(s0)
ffffffe000201a28:	fff7879b          	addiw	a5,a5,-1
ffffffe000201a2c:	fef42023          	sw	a5,-32(s0)
ffffffe000201a30:	fe042783          	lw	a5,-32(s0)
ffffffe000201a34:	0007879b          	sext.w	a5,a5
ffffffe000201a38:	fcf04ae3          	bgtz	a5,ffffffe000201a0c <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
ffffffe000201a3c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201a40:	0ff7f793          	zext.b	a5,a5
ffffffe000201a44:	04078463          	beqz	a5,ffffffe000201a8c <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe000201a48:	fef44783          	lbu	a5,-17(s0)
ffffffe000201a4c:	0ff7f793          	zext.b	a5,a5
ffffffe000201a50:	00078663          	beqz	a5,ffffffe000201a5c <print_dec_int+0x240>
ffffffe000201a54:	02d00793          	li	a5,45
ffffffe000201a58:	01c0006f          	j	ffffffe000201a74 <print_dec_int+0x258>
ffffffe000201a5c:	f9043783          	ld	a5,-112(s0)
ffffffe000201a60:	0057c783          	lbu	a5,5(a5)
ffffffe000201a64:	00078663          	beqz	a5,ffffffe000201a70 <print_dec_int+0x254>
ffffffe000201a68:	02b00793          	li	a5,43
ffffffe000201a6c:	0080006f          	j	ffffffe000201a74 <print_dec_int+0x258>
ffffffe000201a70:	02000793          	li	a5,32
ffffffe000201a74:	fa843703          	ld	a4,-88(s0)
ffffffe000201a78:	00078513          	mv	a0,a5
ffffffe000201a7c:	000700e7          	jalr	a4
        ++written;
ffffffe000201a80:	fe442783          	lw	a5,-28(s0)
ffffffe000201a84:	0017879b          	addiw	a5,a5,1
ffffffe000201a88:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201a8c:	fe842783          	lw	a5,-24(s0)
ffffffe000201a90:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201a94:	0280006f          	j	ffffffe000201abc <print_dec_int+0x2a0>
        putch('0');
ffffffe000201a98:	fa843783          	ld	a5,-88(s0)
ffffffe000201a9c:	03000513          	li	a0,48
ffffffe000201aa0:	000780e7          	jalr	a5
        ++written;
ffffffe000201aa4:	fe442783          	lw	a5,-28(s0)
ffffffe000201aa8:	0017879b          	addiw	a5,a5,1
ffffffe000201aac:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201ab0:	fdc42783          	lw	a5,-36(s0)
ffffffe000201ab4:	0017879b          	addiw	a5,a5,1
ffffffe000201ab8:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201abc:	f9043783          	ld	a5,-112(s0)
ffffffe000201ac0:	00c7a703          	lw	a4,12(a5)
ffffffe000201ac4:	fd744783          	lbu	a5,-41(s0)
ffffffe000201ac8:	0007879b          	sext.w	a5,a5
ffffffe000201acc:	40f707bb          	subw	a5,a4,a5
ffffffe000201ad0:	0007879b          	sext.w	a5,a5
ffffffe000201ad4:	fdc42703          	lw	a4,-36(s0)
ffffffe000201ad8:	0007071b          	sext.w	a4,a4
ffffffe000201adc:	faf74ee3          	blt	a4,a5,ffffffe000201a98 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201ae0:	fe842783          	lw	a5,-24(s0)
ffffffe000201ae4:	fff7879b          	addiw	a5,a5,-1
ffffffe000201ae8:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201aec:	03c0006f          	j	ffffffe000201b28 <print_dec_int+0x30c>
        putch(buf[i]);
ffffffe000201af0:	fd842783          	lw	a5,-40(s0)
ffffffe000201af4:	ff078793          	addi	a5,a5,-16
ffffffe000201af8:	008787b3          	add	a5,a5,s0
ffffffe000201afc:	fc87c783          	lbu	a5,-56(a5)
ffffffe000201b00:	0007871b          	sext.w	a4,a5
ffffffe000201b04:	fa843783          	ld	a5,-88(s0)
ffffffe000201b08:	00070513          	mv	a0,a4
ffffffe000201b0c:	000780e7          	jalr	a5
        ++written;
ffffffe000201b10:	fe442783          	lw	a5,-28(s0)
ffffffe000201b14:	0017879b          	addiw	a5,a5,1
ffffffe000201b18:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b1c:	fd842783          	lw	a5,-40(s0)
ffffffe000201b20:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b24:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b28:	fd842783          	lw	a5,-40(s0)
ffffffe000201b2c:	0007879b          	sext.w	a5,a5
ffffffe000201b30:	fc07d0e3          	bgez	a5,ffffffe000201af0 <print_dec_int+0x2d4>
    }

    return written;
ffffffe000201b34:	fe442783          	lw	a5,-28(s0)
}
ffffffe000201b38:	00078513          	mv	a0,a5
ffffffe000201b3c:	06813083          	ld	ra,104(sp)
ffffffe000201b40:	06013403          	ld	s0,96(sp)
ffffffe000201b44:	07010113          	addi	sp,sp,112
ffffffe000201b48:	00008067          	ret

ffffffe000201b4c <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201b4c:	f4010113          	addi	sp,sp,-192
ffffffe000201b50:	0a113c23          	sd	ra,184(sp)
ffffffe000201b54:	0a813823          	sd	s0,176(sp)
ffffffe000201b58:	0c010413          	addi	s0,sp,192
ffffffe000201b5c:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201b60:	f4b43823          	sd	a1,-176(s0)
ffffffe000201b64:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe000201b68:	f8043023          	sd	zero,-128(s0)
ffffffe000201b6c:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201b70:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201b74:	7a00006f          	j	ffffffe000202314 <vprintfmt+0x7c8>
        if (flags.in_format) {
ffffffe000201b78:	f8044783          	lbu	a5,-128(s0)
ffffffe000201b7c:	72078c63          	beqz	a5,ffffffe0002022b4 <vprintfmt+0x768>
            if (*fmt == '#') {
ffffffe000201b80:	f5043783          	ld	a5,-176(s0)
ffffffe000201b84:	0007c783          	lbu	a5,0(a5)
ffffffe000201b88:	00078713          	mv	a4,a5
ffffffe000201b8c:	02300793          	li	a5,35
ffffffe000201b90:	00f71863          	bne	a4,a5,ffffffe000201ba0 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201b94:	00100793          	li	a5,1
ffffffe000201b98:	f8f40123          	sb	a5,-126(s0)
ffffffe000201b9c:	76c0006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
ffffffe000201ba0:	f5043783          	ld	a5,-176(s0)
ffffffe000201ba4:	0007c783          	lbu	a5,0(a5)
ffffffe000201ba8:	00078713          	mv	a4,a5
ffffffe000201bac:	03000793          	li	a5,48
ffffffe000201bb0:	00f71863          	bne	a4,a5,ffffffe000201bc0 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe000201bb4:	00100793          	li	a5,1
ffffffe000201bb8:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201bbc:	74c0006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201bc0:	f5043783          	ld	a5,-176(s0)
ffffffe000201bc4:	0007c783          	lbu	a5,0(a5)
ffffffe000201bc8:	00078713          	mv	a4,a5
ffffffe000201bcc:	06c00793          	li	a5,108
ffffffe000201bd0:	04f70063          	beq	a4,a5,ffffffe000201c10 <vprintfmt+0xc4>
ffffffe000201bd4:	f5043783          	ld	a5,-176(s0)
ffffffe000201bd8:	0007c783          	lbu	a5,0(a5)
ffffffe000201bdc:	00078713          	mv	a4,a5
ffffffe000201be0:	07a00793          	li	a5,122
ffffffe000201be4:	02f70663          	beq	a4,a5,ffffffe000201c10 <vprintfmt+0xc4>
ffffffe000201be8:	f5043783          	ld	a5,-176(s0)
ffffffe000201bec:	0007c783          	lbu	a5,0(a5)
ffffffe000201bf0:	00078713          	mv	a4,a5
ffffffe000201bf4:	07400793          	li	a5,116
ffffffe000201bf8:	00f70c63          	beq	a4,a5,ffffffe000201c10 <vprintfmt+0xc4>
ffffffe000201bfc:	f5043783          	ld	a5,-176(s0)
ffffffe000201c00:	0007c783          	lbu	a5,0(a5)
ffffffe000201c04:	00078713          	mv	a4,a5
ffffffe000201c08:	06a00793          	li	a5,106
ffffffe000201c0c:	00f71863          	bne	a4,a5,ffffffe000201c1c <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201c10:	00100793          	li	a5,1
ffffffe000201c14:	f8f400a3          	sb	a5,-127(s0)
ffffffe000201c18:	6f00006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
ffffffe000201c1c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c20:	0007c783          	lbu	a5,0(a5)
ffffffe000201c24:	00078713          	mv	a4,a5
ffffffe000201c28:	02b00793          	li	a5,43
ffffffe000201c2c:	00f71863          	bne	a4,a5,ffffffe000201c3c <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201c30:	00100793          	li	a5,1
ffffffe000201c34:	f8f402a3          	sb	a5,-123(s0)
ffffffe000201c38:	6d00006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
ffffffe000201c3c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c40:	0007c783          	lbu	a5,0(a5)
ffffffe000201c44:	00078713          	mv	a4,a5
ffffffe000201c48:	02000793          	li	a5,32
ffffffe000201c4c:	00f71863          	bne	a4,a5,ffffffe000201c5c <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201c50:	00100793          	li	a5,1
ffffffe000201c54:	f8f40223          	sb	a5,-124(s0)
ffffffe000201c58:	6b00006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
ffffffe000201c5c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c60:	0007c783          	lbu	a5,0(a5)
ffffffe000201c64:	00078713          	mv	a4,a5
ffffffe000201c68:	02a00793          	li	a5,42
ffffffe000201c6c:	00f71e63          	bne	a4,a5,ffffffe000201c88 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201c70:	f4843783          	ld	a5,-184(s0)
ffffffe000201c74:	00878713          	addi	a4,a5,8
ffffffe000201c78:	f4e43423          	sd	a4,-184(s0)
ffffffe000201c7c:	0007a783          	lw	a5,0(a5)
ffffffe000201c80:	f8f42423          	sw	a5,-120(s0)
ffffffe000201c84:	6840006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe000201c88:	f5043783          	ld	a5,-176(s0)
ffffffe000201c8c:	0007c783          	lbu	a5,0(a5)
ffffffe000201c90:	00078713          	mv	a4,a5
ffffffe000201c94:	03000793          	li	a5,48
ffffffe000201c98:	04e7f663          	bgeu	a5,a4,ffffffe000201ce4 <vprintfmt+0x198>
ffffffe000201c9c:	f5043783          	ld	a5,-176(s0)
ffffffe000201ca0:	0007c783          	lbu	a5,0(a5)
ffffffe000201ca4:	00078713          	mv	a4,a5
ffffffe000201ca8:	03900793          	li	a5,57
ffffffe000201cac:	02e7ec63          	bltu	a5,a4,ffffffe000201ce4 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe000201cb0:	f5043783          	ld	a5,-176(s0)
ffffffe000201cb4:	f5040713          	addi	a4,s0,-176
ffffffe000201cb8:	00a00613          	li	a2,10
ffffffe000201cbc:	00070593          	mv	a1,a4
ffffffe000201cc0:	00078513          	mv	a0,a5
ffffffe000201cc4:	865ff0ef          	jal	ffffffe000201528 <strtol>
ffffffe000201cc8:	00050793          	mv	a5,a0
ffffffe000201ccc:	0007879b          	sext.w	a5,a5
ffffffe000201cd0:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201cd4:	f5043783          	ld	a5,-176(s0)
ffffffe000201cd8:	fff78793          	addi	a5,a5,-1
ffffffe000201cdc:	f4f43823          	sd	a5,-176(s0)
ffffffe000201ce0:	6280006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
ffffffe000201ce4:	f5043783          	ld	a5,-176(s0)
ffffffe000201ce8:	0007c783          	lbu	a5,0(a5)
ffffffe000201cec:	00078713          	mv	a4,a5
ffffffe000201cf0:	02e00793          	li	a5,46
ffffffe000201cf4:	06f71863          	bne	a4,a5,ffffffe000201d64 <vprintfmt+0x218>
                fmt++;
ffffffe000201cf8:	f5043783          	ld	a5,-176(s0)
ffffffe000201cfc:	00178793          	addi	a5,a5,1
ffffffe000201d00:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000201d04:	f5043783          	ld	a5,-176(s0)
ffffffe000201d08:	0007c783          	lbu	a5,0(a5)
ffffffe000201d0c:	00078713          	mv	a4,a5
ffffffe000201d10:	02a00793          	li	a5,42
ffffffe000201d14:	00f71e63          	bne	a4,a5,ffffffe000201d30 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000201d18:	f4843783          	ld	a5,-184(s0)
ffffffe000201d1c:	00878713          	addi	a4,a5,8
ffffffe000201d20:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d24:	0007a783          	lw	a5,0(a5)
ffffffe000201d28:	f8f42623          	sw	a5,-116(s0)
ffffffe000201d2c:	5dc0006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d30:	f5043783          	ld	a5,-176(s0)
ffffffe000201d34:	f5040713          	addi	a4,s0,-176
ffffffe000201d38:	00a00613          	li	a2,10
ffffffe000201d3c:	00070593          	mv	a1,a4
ffffffe000201d40:	00078513          	mv	a0,a5
ffffffe000201d44:	fe4ff0ef          	jal	ffffffe000201528 <strtol>
ffffffe000201d48:	00050793          	mv	a5,a0
ffffffe000201d4c:	0007879b          	sext.w	a5,a5
ffffffe000201d50:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201d54:	f5043783          	ld	a5,-176(s0)
ffffffe000201d58:	fff78793          	addi	a5,a5,-1
ffffffe000201d5c:	f4f43823          	sd	a5,-176(s0)
ffffffe000201d60:	5a80006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201d64:	f5043783          	ld	a5,-176(s0)
ffffffe000201d68:	0007c783          	lbu	a5,0(a5)
ffffffe000201d6c:	00078713          	mv	a4,a5
ffffffe000201d70:	07800793          	li	a5,120
ffffffe000201d74:	02f70663          	beq	a4,a5,ffffffe000201da0 <vprintfmt+0x254>
ffffffe000201d78:	f5043783          	ld	a5,-176(s0)
ffffffe000201d7c:	0007c783          	lbu	a5,0(a5)
ffffffe000201d80:	00078713          	mv	a4,a5
ffffffe000201d84:	05800793          	li	a5,88
ffffffe000201d88:	00f70c63          	beq	a4,a5,ffffffe000201da0 <vprintfmt+0x254>
ffffffe000201d8c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d90:	0007c783          	lbu	a5,0(a5)
ffffffe000201d94:	00078713          	mv	a4,a5
ffffffe000201d98:	07000793          	li	a5,112
ffffffe000201d9c:	30f71063          	bne	a4,a5,ffffffe00020209c <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201da0:	f5043783          	ld	a5,-176(s0)
ffffffe000201da4:	0007c783          	lbu	a5,0(a5)
ffffffe000201da8:	00078713          	mv	a4,a5
ffffffe000201dac:	07000793          	li	a5,112
ffffffe000201db0:	00f70663          	beq	a4,a5,ffffffe000201dbc <vprintfmt+0x270>
ffffffe000201db4:	f8144783          	lbu	a5,-127(s0)
ffffffe000201db8:	00078663          	beqz	a5,ffffffe000201dc4 <vprintfmt+0x278>
ffffffe000201dbc:	00100793          	li	a5,1
ffffffe000201dc0:	0080006f          	j	ffffffe000201dc8 <vprintfmt+0x27c>
ffffffe000201dc4:	00000793          	li	a5,0
ffffffe000201dc8:	faf403a3          	sb	a5,-89(s0)
ffffffe000201dcc:	fa744783          	lbu	a5,-89(s0)
ffffffe000201dd0:	0017f793          	andi	a5,a5,1
ffffffe000201dd4:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201dd8:	fa744783          	lbu	a5,-89(s0)
ffffffe000201ddc:	0ff7f793          	zext.b	a5,a5
ffffffe000201de0:	00078c63          	beqz	a5,ffffffe000201df8 <vprintfmt+0x2ac>
ffffffe000201de4:	f4843783          	ld	a5,-184(s0)
ffffffe000201de8:	00878713          	addi	a4,a5,8
ffffffe000201dec:	f4e43423          	sd	a4,-184(s0)
ffffffe000201df0:	0007b783          	ld	a5,0(a5)
ffffffe000201df4:	01c0006f          	j	ffffffe000201e10 <vprintfmt+0x2c4>
ffffffe000201df8:	f4843783          	ld	a5,-184(s0)
ffffffe000201dfc:	00878713          	addi	a4,a5,8
ffffffe000201e00:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e04:	0007a783          	lw	a5,0(a5)
ffffffe000201e08:	02079793          	slli	a5,a5,0x20
ffffffe000201e0c:	0207d793          	srli	a5,a5,0x20
ffffffe000201e10:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201e14:	f8c42783          	lw	a5,-116(s0)
ffffffe000201e18:	02079463          	bnez	a5,ffffffe000201e40 <vprintfmt+0x2f4>
ffffffe000201e1c:	fe043783          	ld	a5,-32(s0)
ffffffe000201e20:	02079063          	bnez	a5,ffffffe000201e40 <vprintfmt+0x2f4>
ffffffe000201e24:	f5043783          	ld	a5,-176(s0)
ffffffe000201e28:	0007c783          	lbu	a5,0(a5)
ffffffe000201e2c:	00078713          	mv	a4,a5
ffffffe000201e30:	07000793          	li	a5,112
ffffffe000201e34:	00f70663          	beq	a4,a5,ffffffe000201e40 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201e38:	f8040023          	sb	zero,-128(s0)
ffffffe000201e3c:	4cc0006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201e40:	f5043783          	ld	a5,-176(s0)
ffffffe000201e44:	0007c783          	lbu	a5,0(a5)
ffffffe000201e48:	00078713          	mv	a4,a5
ffffffe000201e4c:	07000793          	li	a5,112
ffffffe000201e50:	00f70a63          	beq	a4,a5,ffffffe000201e64 <vprintfmt+0x318>
ffffffe000201e54:	f8244783          	lbu	a5,-126(s0)
ffffffe000201e58:	00078a63          	beqz	a5,ffffffe000201e6c <vprintfmt+0x320>
ffffffe000201e5c:	fe043783          	ld	a5,-32(s0)
ffffffe000201e60:	00078663          	beqz	a5,ffffffe000201e6c <vprintfmt+0x320>
ffffffe000201e64:	00100793          	li	a5,1
ffffffe000201e68:	0080006f          	j	ffffffe000201e70 <vprintfmt+0x324>
ffffffe000201e6c:	00000793          	li	a5,0
ffffffe000201e70:	faf40323          	sb	a5,-90(s0)
ffffffe000201e74:	fa644783          	lbu	a5,-90(s0)
ffffffe000201e78:	0017f793          	andi	a5,a5,1
ffffffe000201e7c:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201e80:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201e84:	f5043783          	ld	a5,-176(s0)
ffffffe000201e88:	0007c783          	lbu	a5,0(a5)
ffffffe000201e8c:	00078713          	mv	a4,a5
ffffffe000201e90:	05800793          	li	a5,88
ffffffe000201e94:	00f71863          	bne	a4,a5,ffffffe000201ea4 <vprintfmt+0x358>
ffffffe000201e98:	00001797          	auipc	a5,0x1
ffffffe000201e9c:	49878793          	addi	a5,a5,1176 # ffffffe000203330 <upperxdigits.1>
ffffffe000201ea0:	00c0006f          	j	ffffffe000201eac <vprintfmt+0x360>
ffffffe000201ea4:	00001797          	auipc	a5,0x1
ffffffe000201ea8:	4a478793          	addi	a5,a5,1188 # ffffffe000203348 <lowerxdigits.0>
ffffffe000201eac:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201eb0:	fe043783          	ld	a5,-32(s0)
ffffffe000201eb4:	00f7f793          	andi	a5,a5,15
ffffffe000201eb8:	f9843703          	ld	a4,-104(s0)
ffffffe000201ebc:	00f70733          	add	a4,a4,a5
ffffffe000201ec0:	fdc42783          	lw	a5,-36(s0)
ffffffe000201ec4:	0017869b          	addiw	a3,a5,1
ffffffe000201ec8:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201ecc:	00074703          	lbu	a4,0(a4)
ffffffe000201ed0:	ff078793          	addi	a5,a5,-16
ffffffe000201ed4:	008787b3          	add	a5,a5,s0
ffffffe000201ed8:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201edc:	fe043783          	ld	a5,-32(s0)
ffffffe000201ee0:	0047d793          	srli	a5,a5,0x4
ffffffe000201ee4:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201ee8:	fe043783          	ld	a5,-32(s0)
ffffffe000201eec:	fc0792e3          	bnez	a5,ffffffe000201eb0 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201ef0:	f8c42703          	lw	a4,-116(s0)
ffffffe000201ef4:	fff00793          	li	a5,-1
ffffffe000201ef8:	02f71663          	bne	a4,a5,ffffffe000201f24 <vprintfmt+0x3d8>
ffffffe000201efc:	f8344783          	lbu	a5,-125(s0)
ffffffe000201f00:	02078263          	beqz	a5,ffffffe000201f24 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201f04:	f8842703          	lw	a4,-120(s0)
ffffffe000201f08:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f0c:	0007879b          	sext.w	a5,a5
ffffffe000201f10:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f14:	0007879b          	sext.w	a5,a5
ffffffe000201f18:	40f707bb          	subw	a5,a4,a5
ffffffe000201f1c:	0007879b          	sext.w	a5,a5
ffffffe000201f20:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f24:	f8842703          	lw	a4,-120(s0)
ffffffe000201f28:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f2c:	0007879b          	sext.w	a5,a5
ffffffe000201f30:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f34:	0007879b          	sext.w	a5,a5
ffffffe000201f38:	40f707bb          	subw	a5,a4,a5
ffffffe000201f3c:	0007871b          	sext.w	a4,a5
ffffffe000201f40:	fdc42783          	lw	a5,-36(s0)
ffffffe000201f44:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201f48:	f8c42783          	lw	a5,-116(s0)
ffffffe000201f4c:	f8f42823          	sw	a5,-112(s0)
ffffffe000201f50:	f9442783          	lw	a5,-108(s0)
ffffffe000201f54:	00078593          	mv	a1,a5
ffffffe000201f58:	f9042783          	lw	a5,-112(s0)
ffffffe000201f5c:	00078613          	mv	a2,a5
ffffffe000201f60:	0006069b          	sext.w	a3,a2
ffffffe000201f64:	0005879b          	sext.w	a5,a1
ffffffe000201f68:	00f6d463          	bge	a3,a5,ffffffe000201f70 <vprintfmt+0x424>
ffffffe000201f6c:	00058613          	mv	a2,a1
ffffffe000201f70:	0006079b          	sext.w	a5,a2
ffffffe000201f74:	40f707bb          	subw	a5,a4,a5
ffffffe000201f78:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201f7c:	0280006f          	j	ffffffe000201fa4 <vprintfmt+0x458>
                    putch(' ');
ffffffe000201f80:	f5843783          	ld	a5,-168(s0)
ffffffe000201f84:	02000513          	li	a0,32
ffffffe000201f88:	000780e7          	jalr	a5
                    ++written;
ffffffe000201f8c:	fec42783          	lw	a5,-20(s0)
ffffffe000201f90:	0017879b          	addiw	a5,a5,1
ffffffe000201f94:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f98:	fd842783          	lw	a5,-40(s0)
ffffffe000201f9c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201fa0:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201fa4:	fd842783          	lw	a5,-40(s0)
ffffffe000201fa8:	0007879b          	sext.w	a5,a5
ffffffe000201fac:	fcf04ae3          	bgtz	a5,ffffffe000201f80 <vprintfmt+0x434>
                }

                if (prefix) {
ffffffe000201fb0:	fa644783          	lbu	a5,-90(s0)
ffffffe000201fb4:	0ff7f793          	zext.b	a5,a5
ffffffe000201fb8:	04078463          	beqz	a5,ffffffe000202000 <vprintfmt+0x4b4>
                    putch('0');
ffffffe000201fbc:	f5843783          	ld	a5,-168(s0)
ffffffe000201fc0:	03000513          	li	a0,48
ffffffe000201fc4:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000201fc8:	f5043783          	ld	a5,-176(s0)
ffffffe000201fcc:	0007c783          	lbu	a5,0(a5)
ffffffe000201fd0:	00078713          	mv	a4,a5
ffffffe000201fd4:	05800793          	li	a5,88
ffffffe000201fd8:	00f71663          	bne	a4,a5,ffffffe000201fe4 <vprintfmt+0x498>
ffffffe000201fdc:	05800793          	li	a5,88
ffffffe000201fe0:	0080006f          	j	ffffffe000201fe8 <vprintfmt+0x49c>
ffffffe000201fe4:	07800793          	li	a5,120
ffffffe000201fe8:	f5843703          	ld	a4,-168(s0)
ffffffe000201fec:	00078513          	mv	a0,a5
ffffffe000201ff0:	000700e7          	jalr	a4
                    written += 2;
ffffffe000201ff4:	fec42783          	lw	a5,-20(s0)
ffffffe000201ff8:	0027879b          	addiw	a5,a5,2
ffffffe000201ffc:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202000:	fdc42783          	lw	a5,-36(s0)
ffffffe000202004:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202008:	0280006f          	j	ffffffe000202030 <vprintfmt+0x4e4>
                    putch('0');
ffffffe00020200c:	f5843783          	ld	a5,-168(s0)
ffffffe000202010:	03000513          	li	a0,48
ffffffe000202014:	000780e7          	jalr	a5
                    ++written;
ffffffe000202018:	fec42783          	lw	a5,-20(s0)
ffffffe00020201c:	0017879b          	addiw	a5,a5,1
ffffffe000202020:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202024:	fd442783          	lw	a5,-44(s0)
ffffffe000202028:	0017879b          	addiw	a5,a5,1
ffffffe00020202c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202030:	f8c42783          	lw	a5,-116(s0)
ffffffe000202034:	fd442703          	lw	a4,-44(s0)
ffffffe000202038:	0007071b          	sext.w	a4,a4
ffffffe00020203c:	fcf748e3          	blt	a4,a5,ffffffe00020200c <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202040:	fdc42783          	lw	a5,-36(s0)
ffffffe000202044:	fff7879b          	addiw	a5,a5,-1
ffffffe000202048:	fcf42823          	sw	a5,-48(s0)
ffffffe00020204c:	03c0006f          	j	ffffffe000202088 <vprintfmt+0x53c>
                    putch(buf[i]);
ffffffe000202050:	fd042783          	lw	a5,-48(s0)
ffffffe000202054:	ff078793          	addi	a5,a5,-16
ffffffe000202058:	008787b3          	add	a5,a5,s0
ffffffe00020205c:	f807c783          	lbu	a5,-128(a5)
ffffffe000202060:	0007871b          	sext.w	a4,a5
ffffffe000202064:	f5843783          	ld	a5,-168(s0)
ffffffe000202068:	00070513          	mv	a0,a4
ffffffe00020206c:	000780e7          	jalr	a5
                    ++written;
ffffffe000202070:	fec42783          	lw	a5,-20(s0)
ffffffe000202074:	0017879b          	addiw	a5,a5,1
ffffffe000202078:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe00020207c:	fd042783          	lw	a5,-48(s0)
ffffffe000202080:	fff7879b          	addiw	a5,a5,-1
ffffffe000202084:	fcf42823          	sw	a5,-48(s0)
ffffffe000202088:	fd042783          	lw	a5,-48(s0)
ffffffe00020208c:	0007879b          	sext.w	a5,a5
ffffffe000202090:	fc07d0e3          	bgez	a5,ffffffe000202050 <vprintfmt+0x504>
                }

                flags.in_format = false;
ffffffe000202094:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000202098:	2700006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe00020209c:	f5043783          	ld	a5,-176(s0)
ffffffe0002020a0:	0007c783          	lbu	a5,0(a5)
ffffffe0002020a4:	00078713          	mv	a4,a5
ffffffe0002020a8:	06400793          	li	a5,100
ffffffe0002020ac:	02f70663          	beq	a4,a5,ffffffe0002020d8 <vprintfmt+0x58c>
ffffffe0002020b0:	f5043783          	ld	a5,-176(s0)
ffffffe0002020b4:	0007c783          	lbu	a5,0(a5)
ffffffe0002020b8:	00078713          	mv	a4,a5
ffffffe0002020bc:	06900793          	li	a5,105
ffffffe0002020c0:	00f70c63          	beq	a4,a5,ffffffe0002020d8 <vprintfmt+0x58c>
ffffffe0002020c4:	f5043783          	ld	a5,-176(s0)
ffffffe0002020c8:	0007c783          	lbu	a5,0(a5)
ffffffe0002020cc:	00078713          	mv	a4,a5
ffffffe0002020d0:	07500793          	li	a5,117
ffffffe0002020d4:	08f71063          	bne	a4,a5,ffffffe000202154 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe0002020d8:	f8144783          	lbu	a5,-127(s0)
ffffffe0002020dc:	00078c63          	beqz	a5,ffffffe0002020f4 <vprintfmt+0x5a8>
ffffffe0002020e0:	f4843783          	ld	a5,-184(s0)
ffffffe0002020e4:	00878713          	addi	a4,a5,8
ffffffe0002020e8:	f4e43423          	sd	a4,-184(s0)
ffffffe0002020ec:	0007b783          	ld	a5,0(a5)
ffffffe0002020f0:	0140006f          	j	ffffffe000202104 <vprintfmt+0x5b8>
ffffffe0002020f4:	f4843783          	ld	a5,-184(s0)
ffffffe0002020f8:	00878713          	addi	a4,a5,8
ffffffe0002020fc:	f4e43423          	sd	a4,-184(s0)
ffffffe000202100:	0007a783          	lw	a5,0(a5)
ffffffe000202104:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000202108:	fa843583          	ld	a1,-88(s0)
ffffffe00020210c:	f5043783          	ld	a5,-176(s0)
ffffffe000202110:	0007c783          	lbu	a5,0(a5)
ffffffe000202114:	0007871b          	sext.w	a4,a5
ffffffe000202118:	07500793          	li	a5,117
ffffffe00020211c:	40f707b3          	sub	a5,a4,a5
ffffffe000202120:	00f037b3          	snez	a5,a5
ffffffe000202124:	0ff7f793          	zext.b	a5,a5
ffffffe000202128:	f8040713          	addi	a4,s0,-128
ffffffe00020212c:	00070693          	mv	a3,a4
ffffffe000202130:	00078613          	mv	a2,a5
ffffffe000202134:	f5843503          	ld	a0,-168(s0)
ffffffe000202138:	ee4ff0ef          	jal	ffffffe00020181c <print_dec_int>
ffffffe00020213c:	00050793          	mv	a5,a0
ffffffe000202140:	fec42703          	lw	a4,-20(s0)
ffffffe000202144:	00f707bb          	addw	a5,a4,a5
ffffffe000202148:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe00020214c:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202150:	1b80006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
ffffffe000202154:	f5043783          	ld	a5,-176(s0)
ffffffe000202158:	0007c783          	lbu	a5,0(a5)
ffffffe00020215c:	00078713          	mv	a4,a5
ffffffe000202160:	06e00793          	li	a5,110
ffffffe000202164:	04f71c63          	bne	a4,a5,ffffffe0002021bc <vprintfmt+0x670>
                if (flags.longflag) {
ffffffe000202168:	f8144783          	lbu	a5,-127(s0)
ffffffe00020216c:	02078463          	beqz	a5,ffffffe000202194 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
ffffffe000202170:	f4843783          	ld	a5,-184(s0)
ffffffe000202174:	00878713          	addi	a4,a5,8
ffffffe000202178:	f4e43423          	sd	a4,-184(s0)
ffffffe00020217c:	0007b783          	ld	a5,0(a5)
ffffffe000202180:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe000202184:	fec42703          	lw	a4,-20(s0)
ffffffe000202188:	fb043783          	ld	a5,-80(s0)
ffffffe00020218c:	00e7b023          	sd	a4,0(a5)
ffffffe000202190:	0240006f          	j	ffffffe0002021b4 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe000202194:	f4843783          	ld	a5,-184(s0)
ffffffe000202198:	00878713          	addi	a4,a5,8
ffffffe00020219c:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021a0:	0007b783          	ld	a5,0(a5)
ffffffe0002021a4:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe0002021a8:	fb843783          	ld	a5,-72(s0)
ffffffe0002021ac:	fec42703          	lw	a4,-20(s0)
ffffffe0002021b0:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe0002021b4:	f8040023          	sb	zero,-128(s0)
ffffffe0002021b8:	1500006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
ffffffe0002021bc:	f5043783          	ld	a5,-176(s0)
ffffffe0002021c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002021c4:	00078713          	mv	a4,a5
ffffffe0002021c8:	07300793          	li	a5,115
ffffffe0002021cc:	02f71e63          	bne	a4,a5,ffffffe000202208 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
ffffffe0002021d0:	f4843783          	ld	a5,-184(s0)
ffffffe0002021d4:	00878713          	addi	a4,a5,8
ffffffe0002021d8:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021dc:	0007b783          	ld	a5,0(a5)
ffffffe0002021e0:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe0002021e4:	fc043583          	ld	a1,-64(s0)
ffffffe0002021e8:	f5843503          	ld	a0,-168(s0)
ffffffe0002021ec:	da8ff0ef          	jal	ffffffe000201794 <puts_wo_nl>
ffffffe0002021f0:	00050793          	mv	a5,a0
ffffffe0002021f4:	fec42703          	lw	a4,-20(s0)
ffffffe0002021f8:	00f707bb          	addw	a5,a4,a5
ffffffe0002021fc:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202200:	f8040023          	sb	zero,-128(s0)
ffffffe000202204:	1040006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
ffffffe000202208:	f5043783          	ld	a5,-176(s0)
ffffffe00020220c:	0007c783          	lbu	a5,0(a5)
ffffffe000202210:	00078713          	mv	a4,a5
ffffffe000202214:	06300793          	li	a5,99
ffffffe000202218:	02f71e63          	bne	a4,a5,ffffffe000202254 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
ffffffe00020221c:	f4843783          	ld	a5,-184(s0)
ffffffe000202220:	00878713          	addi	a4,a5,8
ffffffe000202224:	f4e43423          	sd	a4,-184(s0)
ffffffe000202228:	0007a783          	lw	a5,0(a5)
ffffffe00020222c:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000202230:	fcc42703          	lw	a4,-52(s0)
ffffffe000202234:	f5843783          	ld	a5,-168(s0)
ffffffe000202238:	00070513          	mv	a0,a4
ffffffe00020223c:	000780e7          	jalr	a5
                ++written;
ffffffe000202240:	fec42783          	lw	a5,-20(s0)
ffffffe000202244:	0017879b          	addiw	a5,a5,1
ffffffe000202248:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe00020224c:	f8040023          	sb	zero,-128(s0)
ffffffe000202250:	0b80006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
ffffffe000202254:	f5043783          	ld	a5,-176(s0)
ffffffe000202258:	0007c783          	lbu	a5,0(a5)
ffffffe00020225c:	00078713          	mv	a4,a5
ffffffe000202260:	02500793          	li	a5,37
ffffffe000202264:	02f71263          	bne	a4,a5,ffffffe000202288 <vprintfmt+0x73c>
                putch('%');
ffffffe000202268:	f5843783          	ld	a5,-168(s0)
ffffffe00020226c:	02500513          	li	a0,37
ffffffe000202270:	000780e7          	jalr	a5
                ++written;
ffffffe000202274:	fec42783          	lw	a5,-20(s0)
ffffffe000202278:	0017879b          	addiw	a5,a5,1
ffffffe00020227c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202280:	f8040023          	sb	zero,-128(s0)
ffffffe000202284:	0840006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
ffffffe000202288:	f5043783          	ld	a5,-176(s0)
ffffffe00020228c:	0007c783          	lbu	a5,0(a5)
ffffffe000202290:	0007871b          	sext.w	a4,a5
ffffffe000202294:	f5843783          	ld	a5,-168(s0)
ffffffe000202298:	00070513          	mv	a0,a4
ffffffe00020229c:	000780e7          	jalr	a5
                ++written;
ffffffe0002022a0:	fec42783          	lw	a5,-20(s0)
ffffffe0002022a4:	0017879b          	addiw	a5,a5,1
ffffffe0002022a8:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002022ac:	f8040023          	sb	zero,-128(s0)
ffffffe0002022b0:	0580006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
ffffffe0002022b4:	f5043783          	ld	a5,-176(s0)
ffffffe0002022b8:	0007c783          	lbu	a5,0(a5)
ffffffe0002022bc:	00078713          	mv	a4,a5
ffffffe0002022c0:	02500793          	li	a5,37
ffffffe0002022c4:	02f71063          	bne	a4,a5,ffffffe0002022e4 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe0002022c8:	f8043023          	sd	zero,-128(s0)
ffffffe0002022cc:	f8043423          	sd	zero,-120(s0)
ffffffe0002022d0:	00100793          	li	a5,1
ffffffe0002022d4:	f8f40023          	sb	a5,-128(s0)
ffffffe0002022d8:	fff00793          	li	a5,-1
ffffffe0002022dc:	f8f42623          	sw	a5,-116(s0)
ffffffe0002022e0:	0280006f          	j	ffffffe000202308 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
ffffffe0002022e4:	f5043783          	ld	a5,-176(s0)
ffffffe0002022e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002022ec:	0007871b          	sext.w	a4,a5
ffffffe0002022f0:	f5843783          	ld	a5,-168(s0)
ffffffe0002022f4:	00070513          	mv	a0,a4
ffffffe0002022f8:	000780e7          	jalr	a5
            ++written;
ffffffe0002022fc:	fec42783          	lw	a5,-20(s0)
ffffffe000202300:	0017879b          	addiw	a5,a5,1
ffffffe000202304:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe000202308:	f5043783          	ld	a5,-176(s0)
ffffffe00020230c:	00178793          	addi	a5,a5,1
ffffffe000202310:	f4f43823          	sd	a5,-176(s0)
ffffffe000202314:	f5043783          	ld	a5,-176(s0)
ffffffe000202318:	0007c783          	lbu	a5,0(a5)
ffffffe00020231c:	84079ee3          	bnez	a5,ffffffe000201b78 <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202320:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202324:	00078513          	mv	a0,a5
ffffffe000202328:	0b813083          	ld	ra,184(sp)
ffffffe00020232c:	0b013403          	ld	s0,176(sp)
ffffffe000202330:	0c010113          	addi	sp,sp,192
ffffffe000202334:	00008067          	ret

ffffffe000202338 <printk>:

int printk(const char* s, ...) {
ffffffe000202338:	f9010113          	addi	sp,sp,-112
ffffffe00020233c:	02113423          	sd	ra,40(sp)
ffffffe000202340:	02813023          	sd	s0,32(sp)
ffffffe000202344:	03010413          	addi	s0,sp,48
ffffffe000202348:	fca43c23          	sd	a0,-40(s0)
ffffffe00020234c:	00b43423          	sd	a1,8(s0)
ffffffe000202350:	00c43823          	sd	a2,16(s0)
ffffffe000202354:	00d43c23          	sd	a3,24(s0)
ffffffe000202358:	02e43023          	sd	a4,32(s0)
ffffffe00020235c:	02f43423          	sd	a5,40(s0)
ffffffe000202360:	03043823          	sd	a6,48(s0)
ffffffe000202364:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe000202368:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe00020236c:	04040793          	addi	a5,s0,64
ffffffe000202370:	fcf43823          	sd	a5,-48(s0)
ffffffe000202374:	fd043783          	ld	a5,-48(s0)
ffffffe000202378:	fc878793          	addi	a5,a5,-56
ffffffe00020237c:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000202380:	fe043783          	ld	a5,-32(s0)
ffffffe000202384:	00078613          	mv	a2,a5
ffffffe000202388:	fd843583          	ld	a1,-40(s0)
ffffffe00020238c:	fffff517          	auipc	a0,0xfffff
ffffffe000202390:	0ec50513          	addi	a0,a0,236 # ffffffe000201478 <putc>
ffffffe000202394:	fb8ff0ef          	jal	ffffffe000201b4c <vprintfmt>
ffffffe000202398:	00050793          	mv	a5,a0
ffffffe00020239c:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe0002023a0:	fec42783          	lw	a5,-20(s0)
}
ffffffe0002023a4:	00078513          	mv	a0,a5
ffffffe0002023a8:	02813083          	ld	ra,40(sp)
ffffffe0002023ac:	02013403          	ld	s0,32(sp)
ffffffe0002023b0:	07010113          	addi	sp,sp,112
ffffffe0002023b4:	00008067          	ret

ffffffe0002023b8 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe0002023b8:	fe010113          	addi	sp,sp,-32
ffffffe0002023bc:	00113c23          	sd	ra,24(sp)
ffffffe0002023c0:	00813823          	sd	s0,16(sp)
ffffffe0002023c4:	02010413          	addi	s0,sp,32
ffffffe0002023c8:	00050793          	mv	a5,a0
ffffffe0002023cc:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe0002023d0:	fec42783          	lw	a5,-20(s0)
ffffffe0002023d4:	fff7879b          	addiw	a5,a5,-1
ffffffe0002023d8:	0007879b          	sext.w	a5,a5
ffffffe0002023dc:	02079713          	slli	a4,a5,0x20
ffffffe0002023e0:	02075713          	srli	a4,a4,0x20
ffffffe0002023e4:	00004797          	auipc	a5,0x4
ffffffe0002023e8:	c3478793          	addi	a5,a5,-972 # ffffffe000206018 <seed>
ffffffe0002023ec:	00e7b023          	sd	a4,0(a5)
}
ffffffe0002023f0:	00000013          	nop
ffffffe0002023f4:	01813083          	ld	ra,24(sp)
ffffffe0002023f8:	01013403          	ld	s0,16(sp)
ffffffe0002023fc:	02010113          	addi	sp,sp,32
ffffffe000202400:	00008067          	ret

ffffffe000202404 <rand>:

int rand(void) {
ffffffe000202404:	ff010113          	addi	sp,sp,-16
ffffffe000202408:	00113423          	sd	ra,8(sp)
ffffffe00020240c:	00813023          	sd	s0,0(sp)
ffffffe000202410:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe000202414:	00004797          	auipc	a5,0x4
ffffffe000202418:	c0478793          	addi	a5,a5,-1020 # ffffffe000206018 <seed>
ffffffe00020241c:	0007b703          	ld	a4,0(a5)
ffffffe000202420:	00001797          	auipc	a5,0x1
ffffffe000202424:	f4078793          	addi	a5,a5,-192 # ffffffe000203360 <lowerxdigits.0+0x18>
ffffffe000202428:	0007b783          	ld	a5,0(a5)
ffffffe00020242c:	02f707b3          	mul	a5,a4,a5
ffffffe000202430:	00178713          	addi	a4,a5,1
ffffffe000202434:	00004797          	auipc	a5,0x4
ffffffe000202438:	be478793          	addi	a5,a5,-1052 # ffffffe000206018 <seed>
ffffffe00020243c:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe000202440:	00004797          	auipc	a5,0x4
ffffffe000202444:	bd878793          	addi	a5,a5,-1064 # ffffffe000206018 <seed>
ffffffe000202448:	0007b783          	ld	a5,0(a5)
ffffffe00020244c:	0217d793          	srli	a5,a5,0x21
ffffffe000202450:	0007879b          	sext.w	a5,a5
}
ffffffe000202454:	00078513          	mv	a0,a5
ffffffe000202458:	00813083          	ld	ra,8(sp)
ffffffe00020245c:	00013403          	ld	s0,0(sp)
ffffffe000202460:	01010113          	addi	sp,sp,16
ffffffe000202464:	00008067          	ret

ffffffe000202468 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe000202468:	fc010113          	addi	sp,sp,-64
ffffffe00020246c:	02113c23          	sd	ra,56(sp)
ffffffe000202470:	02813823          	sd	s0,48(sp)
ffffffe000202474:	04010413          	addi	s0,sp,64
ffffffe000202478:	fca43c23          	sd	a0,-40(s0)
ffffffe00020247c:	00058793          	mv	a5,a1
ffffffe000202480:	fcc43423          	sd	a2,-56(s0)
ffffffe000202484:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe000202488:	fd843783          	ld	a5,-40(s0)
ffffffe00020248c:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202490:	fe043423          	sd	zero,-24(s0)
ffffffe000202494:	0280006f          	j	ffffffe0002024bc <memset+0x54>
        s[i] = c;
ffffffe000202498:	fe043703          	ld	a4,-32(s0)
ffffffe00020249c:	fe843783          	ld	a5,-24(s0)
ffffffe0002024a0:	00f707b3          	add	a5,a4,a5
ffffffe0002024a4:	fd442703          	lw	a4,-44(s0)
ffffffe0002024a8:	0ff77713          	zext.b	a4,a4
ffffffe0002024ac:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002024b0:	fe843783          	ld	a5,-24(s0)
ffffffe0002024b4:	00178793          	addi	a5,a5,1
ffffffe0002024b8:	fef43423          	sd	a5,-24(s0)
ffffffe0002024bc:	fe843703          	ld	a4,-24(s0)
ffffffe0002024c0:	fc843783          	ld	a5,-56(s0)
ffffffe0002024c4:	fcf76ae3          	bltu	a4,a5,ffffffe000202498 <memset+0x30>
    }
    return dest;
ffffffe0002024c8:	fd843783          	ld	a5,-40(s0)
}
ffffffe0002024cc:	00078513          	mv	a0,a5
ffffffe0002024d0:	03813083          	ld	ra,56(sp)
ffffffe0002024d4:	03013403          	ld	s0,48(sp)
ffffffe0002024d8:	04010113          	addi	sp,sp,64
ffffffe0002024dc:	00008067          	ret
