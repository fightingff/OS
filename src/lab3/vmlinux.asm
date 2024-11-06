
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
ffffffe000200008:	735000ef          	jal	ffffffe000200f3c <setup_vm>
    call relocate
ffffffe00020000c:	030000ef          	jal	ffffffe00020003c <relocate>
    
    call mm_init
ffffffe000200010:	3f0000ef          	jal	ffffffe000200400 <mm_init>
    call task_init
ffffffe000200014:	43c000ef          	jal	ffffffe000200450 <task_init>

    la t0, _traps
ffffffe000200018:	00000297          	auipc	t0,0x0
ffffffe00020001c:	06428293          	addi	t0,t0,100 # ffffffe00020007c <_traps>
    csrw stvec, t0  # set stvec = _traps
ffffffe000200020:	10529073          	csrw	stvec,t0

    li t0, 32
ffffffe000200024:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
ffffffe000200028:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
ffffffe00020002c:	234000ef          	jal	ffffffe000200260 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe000200030:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200034:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe000200038:	7f9000ef          	jal	ffffffe000201030 <start_kernel>

ffffffe00020003c <relocate>:
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    li t0, 0xffffffe000000000 - 0x80000000
ffffffe00020003c:	fbf0029b          	addiw	t0,zero,-65
ffffffe000200040:	01f29293          	slli	t0,t0,0x1f
    add ra, ra, t0
ffffffe000200044:	005080b3          	add	ra,ra,t0
    add sp, sp, t0
ffffffe000200048:	00510133          	add	sp,sp,t0

    # need a fence to ensure the new translations are in use
    sfence.vma zero, zero
ffffffe00020004c:	12000073          	sfence.vma

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    # set PPN
    la t0, early_pgtbl
ffffffe000200050:	00007297          	auipc	t0,0x7
ffffffe000200054:	fb028293          	addi	t0,t0,-80 # ffffffe000207000 <early_pgtbl>
    srl t0, t0, 12 
ffffffe000200058:	00c2d293          	srli	t0,t0,0xc

    # set ASID
    li t1, 0
ffffffe00020005c:	00000313          	li	t1,0
    sll t1, t1, 44
ffffffe000200060:	02c31313          	slli	t1,t1,0x2c

    # set mode
    li t2, 8
ffffffe000200064:	00800393          	li	t2,8
    sll t2, t2, 60
ffffffe000200068:	03c39393          	slli	t2,t2,0x3c

    # set satp
    or t0, t0, t1
ffffffe00020006c:	0062e2b3          	or	t0,t0,t1
    or t0, t0, t2
ffffffe000200070:	0072e2b3          	or	t0,t0,t2
    csrw satp, t0
ffffffe000200074:	18029073          	csrw	satp,t0
    ret
ffffffe000200078:	00008067          	ret

ffffffe00020007c <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
ffffffe00020007c:	ef810113          	addi	sp,sp,-264 # ffffffe000205ef8 <_sbss+0xef8>
    sd x0, 0(sp)
ffffffe000200080:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
ffffffe000200084:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
ffffffe000200088:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
ffffffe00020008c:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
ffffffe000200090:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
ffffffe000200094:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
ffffffe000200098:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
ffffffe00020009c:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
ffffffe0002000a0:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
ffffffe0002000a4:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
ffffffe0002000a8:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
ffffffe0002000ac:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
ffffffe0002000b0:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
ffffffe0002000b4:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
ffffffe0002000b8:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
ffffffe0002000bc:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
ffffffe0002000c0:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
ffffffe0002000c4:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
ffffffe0002000c8:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
ffffffe0002000cc:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
ffffffe0002000d0:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
ffffffe0002000d4:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
ffffffe0002000d8:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
ffffffe0002000dc:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
ffffffe0002000e0:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
ffffffe0002000e4:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
ffffffe0002000e8:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
ffffffe0002000ec:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
ffffffe0002000f0:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
ffffffe0002000f4:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
ffffffe0002000f8:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
ffffffe0002000fc:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
ffffffe000200100:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
ffffffe000200104:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
ffffffe000200108:	14202573          	csrr	a0,scause
    csrr a1, sepc
ffffffe00020010c:	141025f3          	csrr	a1,sepc
    call trap_handler
ffffffe000200110:	5c5000ef          	jal	ffffffe000200ed4 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
ffffffe000200114:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
ffffffe000200118:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
ffffffe00020011c:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
ffffffe000200120:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
ffffffe000200124:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
ffffffe000200128:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
ffffffe00020012c:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
ffffffe000200130:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
ffffffe000200134:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
ffffffe000200138:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
ffffffe00020013c:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
ffffffe000200140:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
ffffffe000200144:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
ffffffe000200148:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
ffffffe00020014c:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
ffffffe000200150:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
ffffffe000200154:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
ffffffe000200158:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
ffffffe00020015c:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
ffffffe000200160:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
ffffffe000200164:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
ffffffe000200168:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
ffffffe00020016c:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
ffffffe000200170:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
ffffffe000200174:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
ffffffe000200178:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
ffffffe00020017c:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
ffffffe000200180:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
ffffffe000200184:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
ffffffe000200188:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
ffffffe00020018c:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
ffffffe000200190:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
ffffffe000200194:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
ffffffe000200198:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
ffffffe00020019c:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
ffffffe0002001a0:	10200073          	sret

ffffffe0002001a4 <__dummy>:

    .extern dummy
    .globl __dummy
__dummy:
    # 将 sepc 设置为 dummy() 的地址，并使用 sret 从 S 模式中返回
    la t0, dummy
ffffffe0002001a4:	00000297          	auipc	t0,0x0
ffffffe0002001a8:	4e428293          	addi	t0,t0,1252 # ffffffe000200688 <dummy>
    csrw sepc, t0
ffffffe0002001ac:	14129073          	csrw	sepc,t0
    sret
ffffffe0002001b0:	10200073          	sret

ffffffe0002001b4 <__switch_to>:

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
ffffffe0002001b4:	02050513          	addi	a0,a0,32
    sd ra, 0(a0)
ffffffe0002001b8:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
ffffffe0002001bc:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
ffffffe0002001c0:	00853823          	sd	s0,16(a0)
    sd s1, 24(a0)
ffffffe0002001c4:	00953c23          	sd	s1,24(a0)
    sd s2, 32(a0)
ffffffe0002001c8:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
ffffffe0002001cc:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
ffffffe0002001d0:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
ffffffe0002001d4:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
ffffffe0002001d8:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
ffffffe0002001dc:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
ffffffe0002001e0:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
ffffffe0002001e4:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
ffffffe0002001e8:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
ffffffe0002001ec:	07b53423          	sd	s11,104(a0)

    # restore state from next process
    add a1, a1, 32
ffffffe0002001f0:	02058593          	addi	a1,a1,32
    ld ra, 0(a1)
ffffffe0002001f4:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
ffffffe0002001f8:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
ffffffe0002001fc:	0105b403          	ld	s0,16(a1)
    ld s1, 24(a1)
ffffffe000200200:	0185b483          	ld	s1,24(a1)
    ld s2, 32(a1)
ffffffe000200204:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
ffffffe000200208:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
ffffffe00020020c:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
ffffffe000200210:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
ffffffe000200214:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
ffffffe000200218:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
ffffffe00020021c:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
ffffffe000200220:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
ffffffe000200224:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
ffffffe000200228:	0685bd83          	ld	s11,104(a1)

ffffffe00020022c:	00008067          	ret

ffffffe000200230 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
ffffffe000200230:	fe010113          	addi	sp,sp,-32
ffffffe000200234:	00113c23          	sd	ra,24(sp)
ffffffe000200238:	00813823          	sd	s0,16(sp)
ffffffe00020023c:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
ffffffe000200240:	c01027f3          	rdtime	a5
ffffffe000200244:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
ffffffe000200248:	fe843783          	ld	a5,-24(s0)
}
ffffffe00020024c:	00078513          	mv	a0,a5
ffffffe000200250:	01813083          	ld	ra,24(sp)
ffffffe000200254:	01013403          	ld	s0,16(sp)
ffffffe000200258:	02010113          	addi	sp,sp,32
ffffffe00020025c:	00008067          	ret

ffffffe000200260 <clock_set_next_event>:

void clock_set_next_event() {
ffffffe000200260:	fe010113          	addi	sp,sp,-32
ffffffe000200264:	00113c23          	sd	ra,24(sp)
ffffffe000200268:	00813823          	sd	s0,16(sp)
ffffffe00020026c:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe000200270:	fc1ff0ef          	jal	ffffffe000200230 <get_cycles>
ffffffe000200274:	00050713          	mv	a4,a0
ffffffe000200278:	00004797          	auipc	a5,0x4
ffffffe00020027c:	d8878793          	addi	a5,a5,-632 # ffffffe000204000 <TIMECLOCK>
ffffffe000200280:	0007b783          	ld	a5,0(a5)
ffffffe000200284:	00f707b3          	add	a5,a4,a5
ffffffe000200288:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe00020028c:	fe843503          	ld	a0,-24(s0)
ffffffe000200290:	291000ef          	jal	ffffffe000200d20 <sbi_set_timer>
ffffffe000200294:	00000013          	nop
ffffffe000200298:	01813083          	ld	ra,24(sp)
ffffffe00020029c:	01013403          	ld	s0,16(sp)
ffffffe0002002a0:	02010113          	addi	sp,sp,32
ffffffe0002002a4:	00008067          	ret

ffffffe0002002a8 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
ffffffe0002002a8:	fe010113          	addi	sp,sp,-32
ffffffe0002002ac:	00113c23          	sd	ra,24(sp)
ffffffe0002002b0:	00813823          	sd	s0,16(sp)
ffffffe0002002b4:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
ffffffe0002002b8:	00006797          	auipc	a5,0x6
ffffffe0002002bc:	d4878793          	addi	a5,a5,-696 # ffffffe000206000 <kmem>
ffffffe0002002c0:	0007b783          	ld	a5,0(a5)
ffffffe0002002c4:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
ffffffe0002002c8:	fe843783          	ld	a5,-24(s0)
ffffffe0002002cc:	0007b703          	ld	a4,0(a5)
ffffffe0002002d0:	00006797          	auipc	a5,0x6
ffffffe0002002d4:	d3078793          	addi	a5,a5,-720 # ffffffe000206000 <kmem>
ffffffe0002002d8:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
ffffffe0002002dc:	00001637          	lui	a2,0x1
ffffffe0002002e0:	00000593          	li	a1,0
ffffffe0002002e4:	fe843503          	ld	a0,-24(s0)
ffffffe0002002e8:	625010ef          	jal	ffffffe00020210c <memset>
    return (void *)r;
ffffffe0002002ec:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002f0:	00078513          	mv	a0,a5
ffffffe0002002f4:	01813083          	ld	ra,24(sp)
ffffffe0002002f8:	01013403          	ld	s0,16(sp)
ffffffe0002002fc:	02010113          	addi	sp,sp,32
ffffffe000200300:	00008067          	ret

ffffffe000200304 <kfree>:

void kfree(void *addr) {
ffffffe000200304:	fd010113          	addi	sp,sp,-48
ffffffe000200308:	02113423          	sd	ra,40(sp)
ffffffe00020030c:	02813023          	sd	s0,32(sp)
ffffffe000200310:	03010413          	addi	s0,sp,48
ffffffe000200314:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe000200318:	fd843783          	ld	a5,-40(s0)
ffffffe00020031c:	00078693          	mv	a3,a5
ffffffe000200320:	fd840793          	addi	a5,s0,-40
ffffffe000200324:	fffff737          	lui	a4,0xfffff
ffffffe000200328:	00e6f733          	and	a4,a3,a4
ffffffe00020032c:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe000200330:	fd843783          	ld	a5,-40(s0)
ffffffe000200334:	00001637          	lui	a2,0x1
ffffffe000200338:	00000593          	li	a1,0
ffffffe00020033c:	00078513          	mv	a0,a5
ffffffe000200340:	5cd010ef          	jal	ffffffe00020210c <memset>

    r = (struct run *)addr;
ffffffe000200344:	fd843783          	ld	a5,-40(s0)
ffffffe000200348:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe00020034c:	00006797          	auipc	a5,0x6
ffffffe000200350:	cb478793          	addi	a5,a5,-844 # ffffffe000206000 <kmem>
ffffffe000200354:	0007b703          	ld	a4,0(a5)
ffffffe000200358:	fe843783          	ld	a5,-24(s0)
ffffffe00020035c:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe000200360:	00006797          	auipc	a5,0x6
ffffffe000200364:	ca078793          	addi	a5,a5,-864 # ffffffe000206000 <kmem>
ffffffe000200368:	fe843703          	ld	a4,-24(s0)
ffffffe00020036c:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe000200370:	00000013          	nop
}
ffffffe000200374:	02813083          	ld	ra,40(sp)
ffffffe000200378:	02013403          	ld	s0,32(sp)
ffffffe00020037c:	03010113          	addi	sp,sp,48
ffffffe000200380:	00008067          	ret

ffffffe000200384 <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe000200384:	fd010113          	addi	sp,sp,-48
ffffffe000200388:	02113423          	sd	ra,40(sp)
ffffffe00020038c:	02813023          	sd	s0,32(sp)
ffffffe000200390:	03010413          	addi	s0,sp,48
ffffffe000200394:	fca43c23          	sd	a0,-40(s0)
ffffffe000200398:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe00020039c:	fd843703          	ld	a4,-40(s0)
ffffffe0002003a0:	000017b7          	lui	a5,0x1
ffffffe0002003a4:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003a8:	00f70733          	add	a4,a4,a5
ffffffe0002003ac:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003b0:	00f777b3          	and	a5,a4,a5
ffffffe0002003b4:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe0002003b8:	01c0006f          	j	ffffffe0002003d4 <kfreerange+0x50>
        kfree((void *)addr);
ffffffe0002003bc:	fe843503          	ld	a0,-24(s0)
ffffffe0002003c0:	f45ff0ef          	jal	ffffffe000200304 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe0002003c4:	fe843703          	ld	a4,-24(s0)
ffffffe0002003c8:	000017b7          	lui	a5,0x1
ffffffe0002003cc:	00f707b3          	add	a5,a4,a5
ffffffe0002003d0:	fef43423          	sd	a5,-24(s0)
ffffffe0002003d4:	fe843703          	ld	a4,-24(s0)
ffffffe0002003d8:	000017b7          	lui	a5,0x1
ffffffe0002003dc:	00f70733          	add	a4,a4,a5
ffffffe0002003e0:	fd043783          	ld	a5,-48(s0)
ffffffe0002003e4:	fce7fce3          	bgeu	a5,a4,ffffffe0002003bc <kfreerange+0x38>
    }
}
ffffffe0002003e8:	00000013          	nop
ffffffe0002003ec:	00000013          	nop
ffffffe0002003f0:	02813083          	ld	ra,40(sp)
ffffffe0002003f4:	02013403          	ld	s0,32(sp)
ffffffe0002003f8:	03010113          	addi	sp,sp,48
ffffffe0002003fc:	00008067          	ret

ffffffe000200400 <mm_init>:

void mm_init(void) {
ffffffe000200400:	ff010113          	addi	sp,sp,-16
ffffffe000200404:	00113423          	sd	ra,8(sp)
ffffffe000200408:	00813023          	sd	s0,0(sp)
ffffffe00020040c:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200410:	00003517          	auipc	a0,0x3
ffffffe000200414:	bf850513          	addi	a0,a0,-1032 # ffffffe000203008 <__func__.3+0x8>
ffffffe000200418:	3c5010ef          	jal	ffffffe000201fdc <printk>
    kfreerange(_ekernel, (char *)VM_END);
ffffffe00020041c:	fff00793          	li	a5,-1
ffffffe000200420:	02079593          	slli	a1,a5,0x20
ffffffe000200424:	00008517          	auipc	a0,0x8
ffffffe000200428:	bdc50513          	addi	a0,a0,-1060 # ffffffe000208000 <_ebss>
ffffffe00020042c:	f59ff0ef          	jal	ffffffe000200384 <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200430:	00003517          	auipc	a0,0x3
ffffffe000200434:	bf050513          	addi	a0,a0,-1040 # ffffffe000203020 <__func__.3+0x20>
ffffffe000200438:	3a5010ef          	jal	ffffffe000201fdc <printk>
}
ffffffe00020043c:	00000013          	nop
ffffffe000200440:	00813083          	ld	ra,8(sp)
ffffffe000200444:	00013403          	ld	s0,0(sp)
ffffffe000200448:	01010113          	addi	sp,sp,16
ffffffe00020044c:	00008067          	ret

ffffffe000200450 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe000200450:	fe010113          	addi	sp,sp,-32
ffffffe000200454:	00113c23          	sd	ra,24(sp)
ffffffe000200458:	00813823          	sd	s0,16(sp)
ffffffe00020045c:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe000200460:	7e800513          	li	a0,2024
ffffffe000200464:	3f9010ef          	jal	ffffffe00020205c <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe000200468:	e41ff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe00020046c:	00050713          	mv	a4,a0
ffffffe000200470:	00006797          	auipc	a5,0x6
ffffffe000200474:	b9878793          	addi	a5,a5,-1128 # ffffffe000206008 <idle>
ffffffe000200478:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe00020047c:	00006797          	auipc	a5,0x6
ffffffe000200480:	b8c78793          	addi	a5,a5,-1140 # ffffffe000206008 <idle>
ffffffe000200484:	0007b783          	ld	a5,0(a5)
ffffffe000200488:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe00020048c:	00006797          	auipc	a5,0x6
ffffffe000200490:	b7c78793          	addi	a5,a5,-1156 # ffffffe000206008 <idle>
ffffffe000200494:	0007b783          	ld	a5,0(a5)
ffffffe000200498:	0007b823          	sd	zero,16(a5)
ffffffe00020049c:	00006717          	auipc	a4,0x6
ffffffe0002004a0:	b6c70713          	addi	a4,a4,-1172 # ffffffe000206008 <idle>
ffffffe0002004a4:	00073703          	ld	a4,0(a4)
ffffffe0002004a8:	0107b783          	ld	a5,16(a5)
ffffffe0002004ac:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe0002004b0:	00006797          	auipc	a5,0x6
ffffffe0002004b4:	b5878793          	addi	a5,a5,-1192 # ffffffe000206008 <idle>
ffffffe0002004b8:	0007b783          	ld	a5,0(a5)
ffffffe0002004bc:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe0002004c0:	00006797          	auipc	a5,0x6
ffffffe0002004c4:	b4878793          	addi	a5,a5,-1208 # ffffffe000206008 <idle>
ffffffe0002004c8:	0007b703          	ld	a4,0(a5)
ffffffe0002004cc:	00006797          	auipc	a5,0x6
ffffffe0002004d0:	b5478793          	addi	a5,a5,-1196 # ffffffe000206020 <task>
ffffffe0002004d4:	00e7b023          	sd	a4,0(a5)
ffffffe0002004d8:	00006797          	auipc	a5,0x6
ffffffe0002004dc:	b4878793          	addi	a5,a5,-1208 # ffffffe000206020 <task>
ffffffe0002004e0:	0007b703          	ld	a4,0(a5)
ffffffe0002004e4:	00006797          	auipc	a5,0x6
ffffffe0002004e8:	b2c78793          	addi	a5,a5,-1236 # ffffffe000206010 <current>
ffffffe0002004ec:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002004f0:	00100793          	li	a5,1
ffffffe0002004f4:	fef42623          	sw	a5,-20(s0)
ffffffe0002004f8:	1600006f          	j	ffffffe000200658 <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
ffffffe0002004fc:	dadff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe000200500:	00050693          	mv	a3,a0
ffffffe000200504:	00006717          	auipc	a4,0x6
ffffffe000200508:	b1c70713          	addi	a4,a4,-1252 # ffffffe000206020 <task>
ffffffe00020050c:	fec42783          	lw	a5,-20(s0)
ffffffe000200510:	00379793          	slli	a5,a5,0x3
ffffffe000200514:	00f707b3          	add	a5,a4,a5
ffffffe000200518:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe00020051c:	00006717          	auipc	a4,0x6
ffffffe000200520:	b0470713          	addi	a4,a4,-1276 # ffffffe000206020 <task>
ffffffe000200524:	fec42783          	lw	a5,-20(s0)
ffffffe000200528:	00379793          	slli	a5,a5,0x3
ffffffe00020052c:	00f707b3          	add	a5,a4,a5
ffffffe000200530:	0007b783          	ld	a5,0(a5)
ffffffe000200534:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe000200538:	00006717          	auipc	a4,0x6
ffffffe00020053c:	ae870713          	addi	a4,a4,-1304 # ffffffe000206020 <task>
ffffffe000200540:	fec42783          	lw	a5,-20(s0)
ffffffe000200544:	00379793          	slli	a5,a5,0x3
ffffffe000200548:	00f707b3          	add	a5,a4,a5
ffffffe00020054c:	0007b783          	ld	a5,0(a5)
ffffffe000200550:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe000200554:	355010ef          	jal	ffffffe0002020a8 <rand>
ffffffe000200558:	00050793          	mv	a5,a0
ffffffe00020055c:	00078713          	mv	a4,a5
ffffffe000200560:	0007069b          	sext.w	a3,a4
ffffffe000200564:	666667b7          	lui	a5,0x66666
ffffffe000200568:	66778793          	addi	a5,a5,1639 # 66666667 <PHY_SIZE+0x5e666667>
ffffffe00020056c:	02f687b3          	mul	a5,a3,a5
ffffffe000200570:	0207d793          	srli	a5,a5,0x20
ffffffe000200574:	4027d79b          	sraiw	a5,a5,0x2
ffffffe000200578:	00078693          	mv	a3,a5
ffffffe00020057c:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe000200580:	40f687bb          	subw	a5,a3,a5
ffffffe000200584:	00078693          	mv	a3,a5
ffffffe000200588:	00068793          	mv	a5,a3
ffffffe00020058c:	0027979b          	slliw	a5,a5,0x2
ffffffe000200590:	00d787bb          	addw	a5,a5,a3
ffffffe000200594:	0017979b          	slliw	a5,a5,0x1
ffffffe000200598:	40f707bb          	subw	a5,a4,a5
ffffffe00020059c:	0007879b          	sext.w	a5,a5
ffffffe0002005a0:	0017879b          	addiw	a5,a5,1
ffffffe0002005a4:	0007869b          	sext.w	a3,a5
ffffffe0002005a8:	00006717          	auipc	a4,0x6
ffffffe0002005ac:	a7870713          	addi	a4,a4,-1416 # ffffffe000206020 <task>
ffffffe0002005b0:	fec42783          	lw	a5,-20(s0)
ffffffe0002005b4:	00379793          	slli	a5,a5,0x3
ffffffe0002005b8:	00f707b3          	add	a5,a4,a5
ffffffe0002005bc:	0007b783          	ld	a5,0(a5)
ffffffe0002005c0:	00068713          	mv	a4,a3
ffffffe0002005c4:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe0002005c8:	00006717          	auipc	a4,0x6
ffffffe0002005cc:	a5870713          	addi	a4,a4,-1448 # ffffffe000206020 <task>
ffffffe0002005d0:	fec42783          	lw	a5,-20(s0)
ffffffe0002005d4:	00379793          	slli	a5,a5,0x3
ffffffe0002005d8:	00f707b3          	add	a5,a4,a5
ffffffe0002005dc:	0007b783          	ld	a5,0(a5)
ffffffe0002005e0:	fec42703          	lw	a4,-20(s0)
ffffffe0002005e4:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe0002005e8:	00006717          	auipc	a4,0x6
ffffffe0002005ec:	a3870713          	addi	a4,a4,-1480 # ffffffe000206020 <task>
ffffffe0002005f0:	fec42783          	lw	a5,-20(s0)
ffffffe0002005f4:	00379793          	slli	a5,a5,0x3
ffffffe0002005f8:	00f707b3          	add	a5,a4,a5
ffffffe0002005fc:	0007b783          	ld	a5,0(a5)
ffffffe000200600:	00000717          	auipc	a4,0x0
ffffffe000200604:	ba470713          	addi	a4,a4,-1116 # ffffffe0002001a4 <__dummy>
ffffffe000200608:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe00020060c:	00006717          	auipc	a4,0x6
ffffffe000200610:	a1470713          	addi	a4,a4,-1516 # ffffffe000206020 <task>
ffffffe000200614:	fec42783          	lw	a5,-20(s0)
ffffffe000200618:	00379793          	slli	a5,a5,0x3
ffffffe00020061c:	00f707b3          	add	a5,a4,a5
ffffffe000200620:	0007b783          	ld	a5,0(a5)
ffffffe000200624:	00078693          	mv	a3,a5
ffffffe000200628:	00006717          	auipc	a4,0x6
ffffffe00020062c:	9f870713          	addi	a4,a4,-1544 # ffffffe000206020 <task>
ffffffe000200630:	fec42783          	lw	a5,-20(s0)
ffffffe000200634:	00379793          	slli	a5,a5,0x3
ffffffe000200638:	00f707b3          	add	a5,a4,a5
ffffffe00020063c:	0007b783          	ld	a5,0(a5)
ffffffe000200640:	00001737          	lui	a4,0x1
ffffffe000200644:	00e68733          	add	a4,a3,a4
ffffffe000200648:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe00020064c:	fec42783          	lw	a5,-20(s0)
ffffffe000200650:	0017879b          	addiw	a5,a5,1
ffffffe000200654:	fef42623          	sw	a5,-20(s0)
ffffffe000200658:	fec42783          	lw	a5,-20(s0)
ffffffe00020065c:	0007871b          	sext.w	a4,a5
ffffffe000200660:	01f00793          	li	a5,31
ffffffe000200664:	e8e7dce3          	bge	a5,a4,ffffffe0002004fc <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe000200668:	00003517          	auipc	a0,0x3
ffffffe00020066c:	9d050513          	addi	a0,a0,-1584 # ffffffe000203038 <__func__.3+0x38>
ffffffe000200670:	16d010ef          	jal	ffffffe000201fdc <printk>
}
ffffffe000200674:	00000013          	nop
ffffffe000200678:	01813083          	ld	ra,24(sp)
ffffffe00020067c:	01013403          	ld	s0,16(sp)
ffffffe000200680:	02010113          	addi	sp,sp,32
ffffffe000200684:	00008067          	ret

ffffffe000200688 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe000200688:	fd010113          	addi	sp,sp,-48
ffffffe00020068c:	02113423          	sd	ra,40(sp)
ffffffe000200690:	02813023          	sd	s0,32(sp)
ffffffe000200694:	03010413          	addi	s0,sp,48
    LOG(RED);
ffffffe000200698:	00003697          	auipc	a3,0x3
ffffffe00020069c:	96868693          	addi	a3,a3,-1688 # ffffffe000203000 <__func__.3>
ffffffe0002006a0:	04100613          	li	a2,65
ffffffe0002006a4:	00003597          	auipc	a1,0x3
ffffffe0002006a8:	9ac58593          	addi	a1,a1,-1620 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002006ac:	00003517          	auipc	a0,0x3
ffffffe0002006b0:	9ac50513          	addi	a0,a0,-1620 # ffffffe000203058 <__func__.3+0x58>
ffffffe0002006b4:	129010ef          	jal	ffffffe000201fdc <printk>
    uint64_t MOD = 1000000007;
ffffffe0002006b8:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe0002006bc:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe0002006c0:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe0002006c4:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe0002006c8:	fff00793          	li	a5,-1
ffffffe0002006cc:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002006d0:	fe442783          	lw	a5,-28(s0)
ffffffe0002006d4:	0007871b          	sext.w	a4,a5
ffffffe0002006d8:	fff00793          	li	a5,-1
ffffffe0002006dc:	00f70e63          	beq	a4,a5,ffffffe0002006f8 <dummy+0x70>
ffffffe0002006e0:	00006797          	auipc	a5,0x6
ffffffe0002006e4:	93078793          	addi	a5,a5,-1744 # ffffffe000206010 <current>
ffffffe0002006e8:	0007b783          	ld	a5,0(a5)
ffffffe0002006ec:	0087b703          	ld	a4,8(a5)
ffffffe0002006f0:	fe442783          	lw	a5,-28(s0)
ffffffe0002006f4:	fcf70ee3          	beq	a4,a5,ffffffe0002006d0 <dummy+0x48>
ffffffe0002006f8:	00006797          	auipc	a5,0x6
ffffffe0002006fc:	91878793          	addi	a5,a5,-1768 # ffffffe000206010 <current>
ffffffe000200700:	0007b783          	ld	a5,0(a5)
ffffffe000200704:	0087b783          	ld	a5,8(a5)
ffffffe000200708:	fc0784e3          	beqz	a5,ffffffe0002006d0 <dummy+0x48>
            if (current->counter == 1) {
ffffffe00020070c:	00006797          	auipc	a5,0x6
ffffffe000200710:	90478793          	addi	a5,a5,-1788 # ffffffe000206010 <current>
ffffffe000200714:	0007b783          	ld	a5,0(a5)
ffffffe000200718:	0087b703          	ld	a4,8(a5)
ffffffe00020071c:	00100793          	li	a5,1
ffffffe000200720:	00f71e63          	bne	a4,a5,ffffffe00020073c <dummy+0xb4>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe000200724:	00006797          	auipc	a5,0x6
ffffffe000200728:	8ec78793          	addi	a5,a5,-1812 # ffffffe000206010 <current>
ffffffe00020072c:	0007b783          	ld	a5,0(a5)
ffffffe000200730:	0087b703          	ld	a4,8(a5)
ffffffe000200734:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe000200738:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe00020073c:	00006797          	auipc	a5,0x6
ffffffe000200740:	8d478793          	addi	a5,a5,-1836 # ffffffe000206010 <current>
ffffffe000200744:	0007b783          	ld	a5,0(a5)
ffffffe000200748:	0087b783          	ld	a5,8(a5)
ffffffe00020074c:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe000200750:	fe843783          	ld	a5,-24(s0)
ffffffe000200754:	00178713          	addi	a4,a5,1
ffffffe000200758:	fd843783          	ld	a5,-40(s0)
ffffffe00020075c:	02f777b3          	remu	a5,a4,a5
ffffffe000200760:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe000200764:	00006797          	auipc	a5,0x6
ffffffe000200768:	8ac78793          	addi	a5,a5,-1876 # ffffffe000206010 <current>
ffffffe00020076c:	0007b783          	ld	a5,0(a5)
ffffffe000200770:	0187b783          	ld	a5,24(a5)
ffffffe000200774:	fe843603          	ld	a2,-24(s0)
ffffffe000200778:	00078593          	mv	a1,a5
ffffffe00020077c:	00003517          	auipc	a0,0x3
ffffffe000200780:	8fc50513          	addi	a0,a0,-1796 # ffffffe000203078 <__func__.3+0x78>
ffffffe000200784:	059010ef          	jal	ffffffe000201fdc <printk>
            LOG(RED "%llu\n", current->thread.ra);
ffffffe000200788:	00006797          	auipc	a5,0x6
ffffffe00020078c:	88878793          	addi	a5,a5,-1912 # ffffffe000206010 <current>
ffffffe000200790:	0007b783          	ld	a5,0(a5)
ffffffe000200794:	0207b783          	ld	a5,32(a5)
ffffffe000200798:	00078713          	mv	a4,a5
ffffffe00020079c:	00003697          	auipc	a3,0x3
ffffffe0002007a0:	86468693          	addi	a3,a3,-1948 # ffffffe000203000 <__func__.3>
ffffffe0002007a4:	04d00613          	li	a2,77
ffffffe0002007a8:	00003597          	auipc	a1,0x3
ffffffe0002007ac:	8a858593          	addi	a1,a1,-1880 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002007b0:	00003517          	auipc	a0,0x3
ffffffe0002007b4:	8f850513          	addi	a0,a0,-1800 # ffffffe0002030a8 <__func__.3+0xa8>
ffffffe0002007b8:	025010ef          	jal	ffffffe000201fdc <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002007bc:	f15ff06f          	j	ffffffe0002006d0 <dummy+0x48>

ffffffe0002007c0 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe0002007c0:	fd010113          	addi	sp,sp,-48
ffffffe0002007c4:	02113423          	sd	ra,40(sp)
ffffffe0002007c8:	02813023          	sd	s0,32(sp)
ffffffe0002007cc:	03010413          	addi	s0,sp,48
ffffffe0002007d0:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe0002007d4:	00003697          	auipc	a3,0x3
ffffffe0002007d8:	9b468693          	addi	a3,a3,-1612 # ffffffe000203188 <__func__.2>
ffffffe0002007dc:	06500613          	li	a2,101
ffffffe0002007e0:	00003597          	auipc	a1,0x3
ffffffe0002007e4:	87058593          	addi	a1,a1,-1936 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002007e8:	00003517          	auipc	a0,0x3
ffffffe0002007ec:	87050513          	addi	a0,a0,-1936 # ffffffe000203058 <__func__.3+0x58>
ffffffe0002007f0:	7ec010ef          	jal	ffffffe000201fdc <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe0002007f4:	00006797          	auipc	a5,0x6
ffffffe0002007f8:	81c78793          	addi	a5,a5,-2020 # ffffffe000206010 <current>
ffffffe0002007fc:	0007b783          	ld	a5,0(a5)
ffffffe000200800:	0187b703          	ld	a4,24(a5)
ffffffe000200804:	fd843783          	ld	a5,-40(s0)
ffffffe000200808:	0187b783          	ld	a5,24(a5)
ffffffe00020080c:	00003697          	auipc	a3,0x3
ffffffe000200810:	97c68693          	addi	a3,a3,-1668 # ffffffe000203188 <__func__.2>
ffffffe000200814:	06600613          	li	a2,102
ffffffe000200818:	00003597          	auipc	a1,0x3
ffffffe00020081c:	83858593          	addi	a1,a1,-1992 # ffffffe000203050 <__func__.3+0x50>
ffffffe000200820:	00003517          	auipc	a0,0x3
ffffffe000200824:	8b050513          	addi	a0,a0,-1872 # ffffffe0002030d0 <__func__.3+0xd0>
ffffffe000200828:	7b4010ef          	jal	ffffffe000201fdc <printk>
    if(current->pid != next->pid) {
ffffffe00020082c:	00005797          	auipc	a5,0x5
ffffffe000200830:	7e478793          	addi	a5,a5,2020 # ffffffe000206010 <current>
ffffffe000200834:	0007b783          	ld	a5,0(a5)
ffffffe000200838:	0187b703          	ld	a4,24(a5)
ffffffe00020083c:	fd843783          	ld	a5,-40(s0)
ffffffe000200840:	0187b783          	ld	a5,24(a5)
ffffffe000200844:	06f70a63          	beq	a4,a5,ffffffe0002008b8 <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe000200848:	00005797          	auipc	a5,0x5
ffffffe00020084c:	7c878793          	addi	a5,a5,1992 # ffffffe000206010 <current>
ffffffe000200850:	0007b783          	ld	a5,0(a5)
ffffffe000200854:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe000200858:	00005797          	auipc	a5,0x5
ffffffe00020085c:	7b878793          	addi	a5,a5,1976 # ffffffe000206010 <current>
ffffffe000200860:	fd843703          	ld	a4,-40(s0)
ffffffe000200864:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe000200868:	00005797          	auipc	a5,0x5
ffffffe00020086c:	7a878793          	addi	a5,a5,1960 # ffffffe000206010 <current>
ffffffe000200870:	0007b783          	ld	a5,0(a5)
ffffffe000200874:	0187b703          	ld	a4,24(a5)
ffffffe000200878:	00005797          	auipc	a5,0x5
ffffffe00020087c:	79878793          	addi	a5,a5,1944 # ffffffe000206010 <current>
ffffffe000200880:	0007b783          	ld	a5,0(a5)
ffffffe000200884:	0107b603          	ld	a2,16(a5)
ffffffe000200888:	00005797          	auipc	a5,0x5
ffffffe00020088c:	78878793          	addi	a5,a5,1928 # ffffffe000206010 <current>
ffffffe000200890:	0007b783          	ld	a5,0(a5)
ffffffe000200894:	0087b783          	ld	a5,8(a5)
ffffffe000200898:	00078693          	mv	a3,a5
ffffffe00020089c:	00070593          	mv	a1,a4
ffffffe0002008a0:	00003517          	auipc	a0,0x3
ffffffe0002008a4:	87050513          	addi	a0,a0,-1936 # ffffffe000203110 <__func__.3+0x110>
ffffffe0002008a8:	734010ef          	jal	ffffffe000201fdc <printk>
        __switch_to(prev, next);
ffffffe0002008ac:	fd843583          	ld	a1,-40(s0)
ffffffe0002008b0:	fe843503          	ld	a0,-24(s0)
ffffffe0002008b4:	901ff0ef          	jal	ffffffe0002001b4 <__switch_to>
    }
}
ffffffe0002008b8:	00000013          	nop
ffffffe0002008bc:	02813083          	ld	ra,40(sp)
ffffffe0002008c0:	02013403          	ld	s0,32(sp)
ffffffe0002008c4:	03010113          	addi	sp,sp,48
ffffffe0002008c8:	00008067          	ret

ffffffe0002008cc <do_timer>:

void do_timer() {
ffffffe0002008cc:	ff010113          	addi	sp,sp,-16
ffffffe0002008d0:	00113423          	sd	ra,8(sp)
ffffffe0002008d4:	00813023          	sd	s0,0(sp)
ffffffe0002008d8:	01010413          	addi	s0,sp,16
    LOG(RED);
ffffffe0002008dc:	00003697          	auipc	a3,0x3
ffffffe0002008e0:	8bc68693          	addi	a3,a3,-1860 # ffffffe000203198 <__func__.1>
ffffffe0002008e4:	07000613          	li	a2,112
ffffffe0002008e8:	00002597          	auipc	a1,0x2
ffffffe0002008ec:	76858593          	addi	a1,a1,1896 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002008f0:	00002517          	auipc	a0,0x2
ffffffe0002008f4:	76850513          	addi	a0,a0,1896 # ffffffe000203058 <__func__.3+0x58>
ffffffe0002008f8:	6e4010ef          	jal	ffffffe000201fdc <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe0002008fc:	00005797          	auipc	a5,0x5
ffffffe000200900:	71478793          	addi	a5,a5,1812 # ffffffe000206010 <current>
ffffffe000200904:	0007b783          	ld	a5,0(a5)
ffffffe000200908:	0187b703          	ld	a4,24(a5)
ffffffe00020090c:	00005797          	auipc	a5,0x5
ffffffe000200910:	6fc78793          	addi	a5,a5,1788 # ffffffe000206008 <idle>
ffffffe000200914:	0007b783          	ld	a5,0(a5)
ffffffe000200918:	0187b783          	ld	a5,24(a5)
ffffffe00020091c:	00f70c63          	beq	a4,a5,ffffffe000200934 <do_timer+0x68>
ffffffe000200920:	00005797          	auipc	a5,0x5
ffffffe000200924:	6f078793          	addi	a5,a5,1776 # ffffffe000206010 <current>
ffffffe000200928:	0007b783          	ld	a5,0(a5)
ffffffe00020092c:	0087b783          	ld	a5,8(a5)
ffffffe000200930:	00079663          	bnez	a5,ffffffe00020093c <do_timer+0x70>
        schedule();
ffffffe000200934:	038000ef          	jal	ffffffe00020096c <schedule>
ffffffe000200938:	0200006f          	j	ffffffe000200958 <do_timer+0x8c>
    }
    else --(current->counter);
ffffffe00020093c:	00005797          	auipc	a5,0x5
ffffffe000200940:	6d478793          	addi	a5,a5,1748 # ffffffe000206010 <current>
ffffffe000200944:	0007b783          	ld	a5,0(a5)
ffffffe000200948:	0087b703          	ld	a4,8(a5)
ffffffe00020094c:	fff70713          	addi	a4,a4,-1
ffffffe000200950:	00e7b423          	sd	a4,8(a5)
}
ffffffe000200954:	00000013          	nop
ffffffe000200958:	00000013          	nop
ffffffe00020095c:	00813083          	ld	ra,8(sp)
ffffffe000200960:	00013403          	ld	s0,0(sp)
ffffffe000200964:	01010113          	addi	sp,sp,16
ffffffe000200968:	00008067          	ret

ffffffe00020096c <schedule>:

void schedule() {
ffffffe00020096c:	fe010113          	addi	sp,sp,-32
ffffffe000200970:	00113c23          	sd	ra,24(sp)
ffffffe000200974:	00813823          	sd	s0,16(sp)
ffffffe000200978:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    LOG(RED);
ffffffe00020097c:	00003697          	auipc	a3,0x3
ffffffe000200980:	82c68693          	addi	a3,a3,-2004 # ffffffe0002031a8 <__func__.0>
ffffffe000200984:	07f00613          	li	a2,127
ffffffe000200988:	00002597          	auipc	a1,0x2
ffffffe00020098c:	6c858593          	addi	a1,a1,1736 # ffffffe000203050 <__func__.3+0x50>
ffffffe000200990:	00002517          	auipc	a0,0x2
ffffffe000200994:	6c850513          	addi	a0,a0,1736 # ffffffe000203058 <__func__.3+0x58>
ffffffe000200998:	644010ef          	jal	ffffffe000201fdc <printk>
    struct task_struct *next = idle;
ffffffe00020099c:	00005797          	auipc	a5,0x5
ffffffe0002009a0:	66c78793          	addi	a5,a5,1644 # ffffffe000206008 <idle>
ffffffe0002009a4:	0007b783          	ld	a5,0(a5)
ffffffe0002009a8:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009ac:	00100793          	li	a5,1
ffffffe0002009b0:	fef42223          	sw	a5,-28(s0)
ffffffe0002009b4:	0540006f          	j	ffffffe000200a08 <schedule+0x9c>
        if(task[i]->counter > next->counter){
ffffffe0002009b8:	00005717          	auipc	a4,0x5
ffffffe0002009bc:	66870713          	addi	a4,a4,1640 # ffffffe000206020 <task>
ffffffe0002009c0:	fe442783          	lw	a5,-28(s0)
ffffffe0002009c4:	00379793          	slli	a5,a5,0x3
ffffffe0002009c8:	00f707b3          	add	a5,a4,a5
ffffffe0002009cc:	0007b783          	ld	a5,0(a5)
ffffffe0002009d0:	0087b703          	ld	a4,8(a5)
ffffffe0002009d4:	fe843783          	ld	a5,-24(s0)
ffffffe0002009d8:	0087b783          	ld	a5,8(a5)
ffffffe0002009dc:	02e7f063          	bgeu	a5,a4,ffffffe0002009fc <schedule+0x90>
            next = task[i];
ffffffe0002009e0:	00005717          	auipc	a4,0x5
ffffffe0002009e4:	64070713          	addi	a4,a4,1600 # ffffffe000206020 <task>
ffffffe0002009e8:	fe442783          	lw	a5,-28(s0)
ffffffe0002009ec:	00379793          	slli	a5,a5,0x3
ffffffe0002009f0:	00f707b3          	add	a5,a4,a5
ffffffe0002009f4:	0007b783          	ld	a5,0(a5)
ffffffe0002009f8:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009fc:	fe442783          	lw	a5,-28(s0)
ffffffe000200a00:	0017879b          	addiw	a5,a5,1
ffffffe000200a04:	fef42223          	sw	a5,-28(s0)
ffffffe000200a08:	fe442783          	lw	a5,-28(s0)
ffffffe000200a0c:	0007871b          	sext.w	a4,a5
ffffffe000200a10:	01f00793          	li	a5,31
ffffffe000200a14:	fae7d2e3          	bge	a5,a4,ffffffe0002009b8 <schedule+0x4c>
        }
    }

    if(next->counter == 0) {
ffffffe000200a18:	fe843783          	ld	a5,-24(s0)
ffffffe000200a1c:	0087b783          	ld	a5,8(a5)
ffffffe000200a20:	0c079e63          	bnez	a5,ffffffe000200afc <schedule+0x190>
        printk("\n");
ffffffe000200a24:	00002517          	auipc	a0,0x2
ffffffe000200a28:	72450513          	addi	a0,a0,1828 # ffffffe000203148 <__func__.3+0x148>
ffffffe000200a2c:	5b0010ef          	jal	ffffffe000201fdc <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a30:	00100793          	li	a5,1
ffffffe000200a34:	fef42023          	sw	a5,-32(s0)
ffffffe000200a38:	0ac0006f          	j	ffffffe000200ae4 <schedule+0x178>
            task[i]->counter = task[i]->priority;
ffffffe000200a3c:	00005717          	auipc	a4,0x5
ffffffe000200a40:	5e470713          	addi	a4,a4,1508 # ffffffe000206020 <task>
ffffffe000200a44:	fe042783          	lw	a5,-32(s0)
ffffffe000200a48:	00379793          	slli	a5,a5,0x3
ffffffe000200a4c:	00f707b3          	add	a5,a4,a5
ffffffe000200a50:	0007b703          	ld	a4,0(a5)
ffffffe000200a54:	00005697          	auipc	a3,0x5
ffffffe000200a58:	5cc68693          	addi	a3,a3,1484 # ffffffe000206020 <task>
ffffffe000200a5c:	fe042783          	lw	a5,-32(s0)
ffffffe000200a60:	00379793          	slli	a5,a5,0x3
ffffffe000200a64:	00f687b3          	add	a5,a3,a5
ffffffe000200a68:	0007b783          	ld	a5,0(a5)
ffffffe000200a6c:	01073703          	ld	a4,16(a4)
ffffffe000200a70:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200a74:	00005717          	auipc	a4,0x5
ffffffe000200a78:	5ac70713          	addi	a4,a4,1452 # ffffffe000206020 <task>
ffffffe000200a7c:	fe042783          	lw	a5,-32(s0)
ffffffe000200a80:	00379793          	slli	a5,a5,0x3
ffffffe000200a84:	00f707b3          	add	a5,a4,a5
ffffffe000200a88:	0007b783          	ld	a5,0(a5)
ffffffe000200a8c:	0187b583          	ld	a1,24(a5)
ffffffe000200a90:	00005717          	auipc	a4,0x5
ffffffe000200a94:	59070713          	addi	a4,a4,1424 # ffffffe000206020 <task>
ffffffe000200a98:	fe042783          	lw	a5,-32(s0)
ffffffe000200a9c:	00379793          	slli	a5,a5,0x3
ffffffe000200aa0:	00f707b3          	add	a5,a4,a5
ffffffe000200aa4:	0007b783          	ld	a5,0(a5)
ffffffe000200aa8:	0107b603          	ld	a2,16(a5)
ffffffe000200aac:	00005717          	auipc	a4,0x5
ffffffe000200ab0:	57470713          	addi	a4,a4,1396 # ffffffe000206020 <task>
ffffffe000200ab4:	fe042783          	lw	a5,-32(s0)
ffffffe000200ab8:	00379793          	slli	a5,a5,0x3
ffffffe000200abc:	00f707b3          	add	a5,a4,a5
ffffffe000200ac0:	0007b783          	ld	a5,0(a5)
ffffffe000200ac4:	0087b783          	ld	a5,8(a5)
ffffffe000200ac8:	00078693          	mv	a3,a5
ffffffe000200acc:	00002517          	auipc	a0,0x2
ffffffe000200ad0:	68450513          	addi	a0,a0,1668 # ffffffe000203150 <__func__.3+0x150>
ffffffe000200ad4:	508010ef          	jal	ffffffe000201fdc <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200ad8:	fe042783          	lw	a5,-32(s0)
ffffffe000200adc:	0017879b          	addiw	a5,a5,1
ffffffe000200ae0:	fef42023          	sw	a5,-32(s0)
ffffffe000200ae4:	fe042783          	lw	a5,-32(s0)
ffffffe000200ae8:	0007871b          	sext.w	a4,a5
ffffffe000200aec:	01f00793          	li	a5,31
ffffffe000200af0:	f4e7d6e3          	bge	a5,a4,ffffffe000200a3c <schedule+0xd0>
        }
        schedule();
ffffffe000200af4:	e79ff0ef          	jal	ffffffe00020096c <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200af8:	00c0006f          	j	ffffffe000200b04 <schedule+0x198>
        switch_to(next);
ffffffe000200afc:	fe843503          	ld	a0,-24(s0)
ffffffe000200b00:	cc1ff0ef          	jal	ffffffe0002007c0 <switch_to>
ffffffe000200b04:	00000013          	nop
ffffffe000200b08:	01813083          	ld	ra,24(sp)
ffffffe000200b0c:	01013403          	ld	s0,16(sp)
ffffffe000200b10:	02010113          	addi	sp,sp,32
ffffffe000200b14:	00008067          	ret

ffffffe000200b18 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200b18:	f7010113          	addi	sp,sp,-144
ffffffe000200b1c:	08113423          	sd	ra,136(sp)
ffffffe000200b20:	08813023          	sd	s0,128(sp)
ffffffe000200b24:	06913c23          	sd	s1,120(sp)
ffffffe000200b28:	07213823          	sd	s2,112(sp)
ffffffe000200b2c:	07313423          	sd	s3,104(sp)
ffffffe000200b30:	09010413          	addi	s0,sp,144
ffffffe000200b34:	faa43423          	sd	a0,-88(s0)
ffffffe000200b38:	fab43023          	sd	a1,-96(s0)
ffffffe000200b3c:	f8c43c23          	sd	a2,-104(s0)
ffffffe000200b40:	f8d43823          	sd	a3,-112(s0)
ffffffe000200b44:	f8e43423          	sd	a4,-120(s0)
ffffffe000200b48:	f8f43023          	sd	a5,-128(s0)
ffffffe000200b4c:	f7043c23          	sd	a6,-136(s0)
ffffffe000200b50:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200b54:	fa843e03          	ld	t3,-88(s0)
ffffffe000200b58:	fa043e83          	ld	t4,-96(s0)
ffffffe000200b5c:	f9843f03          	ld	t5,-104(s0)
ffffffe000200b60:	f9043f83          	ld	t6,-112(s0)
ffffffe000200b64:	f8843283          	ld	t0,-120(s0)
ffffffe000200b68:	f8043483          	ld	s1,-128(s0)
ffffffe000200b6c:	f7843903          	ld	s2,-136(s0)
ffffffe000200b70:	f7043983          	ld	s3,-144(s0)
ffffffe000200b74:	000e0893          	mv	a7,t3
ffffffe000200b78:	000e8813          	mv	a6,t4
ffffffe000200b7c:	000f0513          	mv	a0,t5
ffffffe000200b80:	000f8593          	mv	a1,t6
ffffffe000200b84:	00028613          	mv	a2,t0
ffffffe000200b88:	00048693          	mv	a3,s1
ffffffe000200b8c:	00090713          	mv	a4,s2
ffffffe000200b90:	00098793          	mv	a5,s3
ffffffe000200b94:	00000073          	ecall
ffffffe000200b98:	00050e93          	mv	t4,a0
ffffffe000200b9c:	00058e13          	mv	t3,a1
ffffffe000200ba0:	fbd43823          	sd	t4,-80(s0)
ffffffe000200ba4:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200ba8:	fb043783          	ld	a5,-80(s0)
ffffffe000200bac:	fcf43023          	sd	a5,-64(s0)
ffffffe000200bb0:	fb843783          	ld	a5,-72(s0)
ffffffe000200bb4:	fcf43423          	sd	a5,-56(s0)
ffffffe000200bb8:	fc043703          	ld	a4,-64(s0)
ffffffe000200bbc:	fc843783          	ld	a5,-56(s0)
ffffffe000200bc0:	00070313          	mv	t1,a4
ffffffe000200bc4:	00078393          	mv	t2,a5
ffffffe000200bc8:	00030713          	mv	a4,t1
ffffffe000200bcc:	00038793          	mv	a5,t2
}
ffffffe000200bd0:	00070513          	mv	a0,a4
ffffffe000200bd4:	00078593          	mv	a1,a5
ffffffe000200bd8:	08813083          	ld	ra,136(sp)
ffffffe000200bdc:	08013403          	ld	s0,128(sp)
ffffffe000200be0:	07813483          	ld	s1,120(sp)
ffffffe000200be4:	07013903          	ld	s2,112(sp)
ffffffe000200be8:	06813983          	ld	s3,104(sp)
ffffffe000200bec:	09010113          	addi	sp,sp,144
ffffffe000200bf0:	00008067          	ret

ffffffe000200bf4 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200bf4:	fc010113          	addi	sp,sp,-64
ffffffe000200bf8:	02113c23          	sd	ra,56(sp)
ffffffe000200bfc:	02813823          	sd	s0,48(sp)
ffffffe000200c00:	03213423          	sd	s2,40(sp)
ffffffe000200c04:	03313023          	sd	s3,32(sp)
ffffffe000200c08:	04010413          	addi	s0,sp,64
ffffffe000200c0c:	00050793          	mv	a5,a0
ffffffe000200c10:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200c14:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200c18:	00000893          	li	a7,0
ffffffe000200c1c:	00000813          	li	a6,0
ffffffe000200c20:	00000793          	li	a5,0
ffffffe000200c24:	00000713          	li	a4,0
ffffffe000200c28:	00000693          	li	a3,0
ffffffe000200c2c:	00200593          	li	a1,2
ffffffe000200c30:	44424537          	lui	a0,0x44424
ffffffe000200c34:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200c38:	ee1ff0ef          	jal	ffffffe000200b18 <sbi_ecall>
ffffffe000200c3c:	00050713          	mv	a4,a0
ffffffe000200c40:	00058793          	mv	a5,a1
ffffffe000200c44:	fce43823          	sd	a4,-48(s0)
ffffffe000200c48:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c4c:	fd043703          	ld	a4,-48(s0)
ffffffe000200c50:	fd843783          	ld	a5,-40(s0)
ffffffe000200c54:	00070913          	mv	s2,a4
ffffffe000200c58:	00078993          	mv	s3,a5
ffffffe000200c5c:	00090713          	mv	a4,s2
ffffffe000200c60:	00098793          	mv	a5,s3
}
ffffffe000200c64:	00070513          	mv	a0,a4
ffffffe000200c68:	00078593          	mv	a1,a5
ffffffe000200c6c:	03813083          	ld	ra,56(sp)
ffffffe000200c70:	03013403          	ld	s0,48(sp)
ffffffe000200c74:	02813903          	ld	s2,40(sp)
ffffffe000200c78:	02013983          	ld	s3,32(sp)
ffffffe000200c7c:	04010113          	addi	sp,sp,64
ffffffe000200c80:	00008067          	ret

ffffffe000200c84 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200c84:	fc010113          	addi	sp,sp,-64
ffffffe000200c88:	02113c23          	sd	ra,56(sp)
ffffffe000200c8c:	02813823          	sd	s0,48(sp)
ffffffe000200c90:	03213423          	sd	s2,40(sp)
ffffffe000200c94:	03313023          	sd	s3,32(sp)
ffffffe000200c98:	04010413          	addi	s0,sp,64
ffffffe000200c9c:	00050793          	mv	a5,a0
ffffffe000200ca0:	00058713          	mv	a4,a1
ffffffe000200ca4:	fcf42623          	sw	a5,-52(s0)
ffffffe000200ca8:	00070793          	mv	a5,a4
ffffffe000200cac:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200cb0:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200cb4:	fc846683          	lwu	a3,-56(s0)
ffffffe000200cb8:	00000893          	li	a7,0
ffffffe000200cbc:	00000813          	li	a6,0
ffffffe000200cc0:	00000793          	li	a5,0
ffffffe000200cc4:	00000713          	li	a4,0
ffffffe000200cc8:	00000593          	li	a1,0
ffffffe000200ccc:	53525537          	lui	a0,0x53525
ffffffe000200cd0:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200cd4:	e45ff0ef          	jal	ffffffe000200b18 <sbi_ecall>
ffffffe000200cd8:	00050713          	mv	a4,a0
ffffffe000200cdc:	00058793          	mv	a5,a1
ffffffe000200ce0:	fce43823          	sd	a4,-48(s0)
ffffffe000200ce4:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ce8:	fd043703          	ld	a4,-48(s0)
ffffffe000200cec:	fd843783          	ld	a5,-40(s0)
ffffffe000200cf0:	00070913          	mv	s2,a4
ffffffe000200cf4:	00078993          	mv	s3,a5
ffffffe000200cf8:	00090713          	mv	a4,s2
ffffffe000200cfc:	00098793          	mv	a5,s3
}
ffffffe000200d00:	00070513          	mv	a0,a4
ffffffe000200d04:	00078593          	mv	a1,a5
ffffffe000200d08:	03813083          	ld	ra,56(sp)
ffffffe000200d0c:	03013403          	ld	s0,48(sp)
ffffffe000200d10:	02813903          	ld	s2,40(sp)
ffffffe000200d14:	02013983          	ld	s3,32(sp)
ffffffe000200d18:	04010113          	addi	sp,sp,64
ffffffe000200d1c:	00008067          	ret

ffffffe000200d20 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200d20:	fc010113          	addi	sp,sp,-64
ffffffe000200d24:	02113c23          	sd	ra,56(sp)
ffffffe000200d28:	02813823          	sd	s0,48(sp)
ffffffe000200d2c:	03213423          	sd	s2,40(sp)
ffffffe000200d30:	03313023          	sd	s3,32(sp)
ffffffe000200d34:	04010413          	addi	s0,sp,64
ffffffe000200d38:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200d3c:	00000893          	li	a7,0
ffffffe000200d40:	00000813          	li	a6,0
ffffffe000200d44:	00000793          	li	a5,0
ffffffe000200d48:	00000713          	li	a4,0
ffffffe000200d4c:	00000693          	li	a3,0
ffffffe000200d50:	fc843603          	ld	a2,-56(s0)
ffffffe000200d54:	00000593          	li	a1,0
ffffffe000200d58:	54495537          	lui	a0,0x54495
ffffffe000200d5c:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200d60:	db9ff0ef          	jal	ffffffe000200b18 <sbi_ecall>
ffffffe000200d64:	00050713          	mv	a4,a0
ffffffe000200d68:	00058793          	mv	a5,a1
ffffffe000200d6c:	fce43823          	sd	a4,-48(s0)
ffffffe000200d70:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d74:	fd043703          	ld	a4,-48(s0)
ffffffe000200d78:	fd843783          	ld	a5,-40(s0)
ffffffe000200d7c:	00070913          	mv	s2,a4
ffffffe000200d80:	00078993          	mv	s3,a5
ffffffe000200d84:	00090713          	mv	a4,s2
ffffffe000200d88:	00098793          	mv	a5,s3
}
ffffffe000200d8c:	00070513          	mv	a0,a4
ffffffe000200d90:	00078593          	mv	a1,a5
ffffffe000200d94:	03813083          	ld	ra,56(sp)
ffffffe000200d98:	03013403          	ld	s0,48(sp)
ffffffe000200d9c:	02813903          	ld	s2,40(sp)
ffffffe000200da0:	02013983          	ld	s3,32(sp)
ffffffe000200da4:	04010113          	addi	sp,sp,64
ffffffe000200da8:	00008067          	ret

ffffffe000200dac <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200dac:	fb010113          	addi	sp,sp,-80
ffffffe000200db0:	04113423          	sd	ra,72(sp)
ffffffe000200db4:	04813023          	sd	s0,64(sp)
ffffffe000200db8:	03213c23          	sd	s2,56(sp)
ffffffe000200dbc:	03313823          	sd	s3,48(sp)
ffffffe000200dc0:	05010413          	addi	s0,sp,80
ffffffe000200dc4:	fca43423          	sd	a0,-56(s0)
ffffffe000200dc8:	fcb43023          	sd	a1,-64(s0)
ffffffe000200dcc:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200dd0:	00000893          	li	a7,0
ffffffe000200dd4:	00000813          	li	a6,0
ffffffe000200dd8:	00000793          	li	a5,0
ffffffe000200ddc:	fb843703          	ld	a4,-72(s0)
ffffffe000200de0:	fc043683          	ld	a3,-64(s0)
ffffffe000200de4:	fc843603          	ld	a2,-56(s0)
ffffffe000200de8:	00100593          	li	a1,1
ffffffe000200dec:	44424537          	lui	a0,0x44424
ffffffe000200df0:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200df4:	d25ff0ef          	jal	ffffffe000200b18 <sbi_ecall>
ffffffe000200df8:	00050713          	mv	a4,a0
ffffffe000200dfc:	00058793          	mv	a5,a1
ffffffe000200e00:	fce43823          	sd	a4,-48(s0)
ffffffe000200e04:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e08:	fd043703          	ld	a4,-48(s0)
ffffffe000200e0c:	fd843783          	ld	a5,-40(s0)
ffffffe000200e10:	00070913          	mv	s2,a4
ffffffe000200e14:	00078993          	mv	s3,a5
ffffffe000200e18:	00090713          	mv	a4,s2
ffffffe000200e1c:	00098793          	mv	a5,s3
}
ffffffe000200e20:	00070513          	mv	a0,a4
ffffffe000200e24:	00078593          	mv	a1,a5
ffffffe000200e28:	04813083          	ld	ra,72(sp)
ffffffe000200e2c:	04013403          	ld	s0,64(sp)
ffffffe000200e30:	03813903          	ld	s2,56(sp)
ffffffe000200e34:	03013983          	ld	s3,48(sp)
ffffffe000200e38:	05010113          	addi	sp,sp,80
ffffffe000200e3c:	00008067          	ret

ffffffe000200e40 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200e40:	fb010113          	addi	sp,sp,-80
ffffffe000200e44:	04113423          	sd	ra,72(sp)
ffffffe000200e48:	04813023          	sd	s0,64(sp)
ffffffe000200e4c:	03213c23          	sd	s2,56(sp)
ffffffe000200e50:	03313823          	sd	s3,48(sp)
ffffffe000200e54:	05010413          	addi	s0,sp,80
ffffffe000200e58:	fca43423          	sd	a0,-56(s0)
ffffffe000200e5c:	fcb43023          	sd	a1,-64(s0)
ffffffe000200e60:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e64:	00000893          	li	a7,0
ffffffe000200e68:	00000813          	li	a6,0
ffffffe000200e6c:	00000793          	li	a5,0
ffffffe000200e70:	fb843703          	ld	a4,-72(s0)
ffffffe000200e74:	fc043683          	ld	a3,-64(s0)
ffffffe000200e78:	fc843603          	ld	a2,-56(s0)
ffffffe000200e7c:	00000593          	li	a1,0
ffffffe000200e80:	44424537          	lui	a0,0x44424
ffffffe000200e84:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e88:	c91ff0ef          	jal	ffffffe000200b18 <sbi_ecall>
ffffffe000200e8c:	00050713          	mv	a4,a0
ffffffe000200e90:	00058793          	mv	a5,a1
ffffffe000200e94:	fce43823          	sd	a4,-48(s0)
ffffffe000200e98:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e9c:	fd043703          	ld	a4,-48(s0)
ffffffe000200ea0:	fd843783          	ld	a5,-40(s0)
ffffffe000200ea4:	00070913          	mv	s2,a4
ffffffe000200ea8:	00078993          	mv	s3,a5
ffffffe000200eac:	00090713          	mv	a4,s2
ffffffe000200eb0:	00098793          	mv	a5,s3
ffffffe000200eb4:	00070513          	mv	a0,a4
ffffffe000200eb8:	00078593          	mv	a1,a5
ffffffe000200ebc:	04813083          	ld	ra,72(sp)
ffffffe000200ec0:	04013403          	ld	s0,64(sp)
ffffffe000200ec4:	03813903          	ld	s2,56(sp)
ffffffe000200ec8:	03013983          	ld	s3,48(sp)
ffffffe000200ecc:	05010113          	addi	sp,sp,80
ffffffe000200ed0:	00008067          	ret

ffffffe000200ed4 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200ed4:	fe010113          	addi	sp,sp,-32
ffffffe000200ed8:	00113c23          	sd	ra,24(sp)
ffffffe000200edc:	00813823          	sd	s0,16(sp)
ffffffe000200ee0:	02010413          	addi	s0,sp,32
ffffffe000200ee4:	fea43423          	sd	a0,-24(s0)
ffffffe000200ee8:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200eec:	fe843783          	ld	a5,-24(s0)
ffffffe000200ef0:	0207d063          	bgez	a5,ffffffe000200f10 <trap_handler+0x3c>
ffffffe000200ef4:	fe843783          	ld	a5,-24(s0)
ffffffe000200ef8:	0ff7f713          	zext.b	a4,a5
ffffffe000200efc:	00500793          	li	a5,5
ffffffe000200f00:	00f71863          	bne	a4,a5,ffffffe000200f10 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200f04:	b5cff0ef          	jal	ffffffe000200260 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200f08:	9c5ff0ef          	jal	ffffffe0002008cc <do_timer>
ffffffe000200f0c:	01c0006f          	j	ffffffe000200f28 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200f10:	fe043603          	ld	a2,-32(s0)
ffffffe000200f14:	fe843583          	ld	a1,-24(s0)
ffffffe000200f18:	00002517          	auipc	a0,0x2
ffffffe000200f1c:	2a050513          	addi	a0,a0,672 # ffffffe0002031b8 <__func__.0+0x10>
ffffffe000200f20:	0bc010ef          	jal	ffffffe000201fdc <printk>
    }
ffffffe000200f24:	00000013          	nop
ffffffe000200f28:	00000013          	nop
ffffffe000200f2c:	01813083          	ld	ra,24(sp)
ffffffe000200f30:	01013403          	ld	s0,16(sp)
ffffffe000200f34:	02010113          	addi	sp,sp,32
ffffffe000200f38:	00008067          	ret

ffffffe000200f3c <setup_vm>:
#include "string.h"

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000200f3c:	fe010113          	addi	sp,sp,-32
ffffffe000200f40:	00113c23          	sd	ra,24(sp)
ffffffe000200f44:	00813823          	sd	s0,16(sp)
ffffffe000200f48:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200f4c:	00001637          	lui	a2,0x1
ffffffe000200f50:	00000593          	li	a1,0
ffffffe000200f54:	00006517          	auipc	a0,0x6
ffffffe000200f58:	0ac50513          	addi	a0,a0,172 # ffffffe000207000 <early_pgtbl>
ffffffe000200f5c:	1b0010ef          	jal	ffffffe00020210c <memset>
        early_pgtbl[i] |= ((1 << 4) - 1);
    }
    */

    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
ffffffe000200f60:	00200793          	li	a5,2
ffffffe000200f64:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200f68:	00006717          	auipc	a4,0x6
ffffffe000200f6c:	09870713          	addi	a4,a4,152 # ffffffe000207000 <early_pgtbl>
ffffffe000200f70:	fe843783          	ld	a5,-24(s0)
ffffffe000200f74:	00379793          	slli	a5,a5,0x3
ffffffe000200f78:	00f707b3          	add	a5,a4,a5
ffffffe000200f7c:	20000737          	lui	a4,0x20000
ffffffe000200f80:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200f84:	00006717          	auipc	a4,0x6
ffffffe000200f88:	07c70713          	addi	a4,a4,124 # ffffffe000207000 <early_pgtbl>
ffffffe000200f8c:	fe843783          	ld	a5,-24(s0)
ffffffe000200f90:	00379793          	slli	a5,a5,0x3
ffffffe000200f94:	00f707b3          	add	a5,a4,a5
ffffffe000200f98:	0007b783          	ld	a5,0(a5)
ffffffe000200f9c:	00f7e713          	ori	a4,a5,15
ffffffe000200fa0:	00006697          	auipc	a3,0x6
ffffffe000200fa4:	06068693          	addi	a3,a3,96 # ffffffe000207000 <early_pgtbl>
ffffffe000200fa8:	fe843783          	ld	a5,-24(s0)
ffffffe000200fac:	00379793          	slli	a5,a5,0x3
ffffffe000200fb0:	00f687b3          	add	a5,a3,a5
ffffffe000200fb4:	00e7b023          	sd	a4,0(a5)


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
ffffffe000200fb8:	18000793          	li	a5,384
ffffffe000200fbc:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200fc0:	00006717          	auipc	a4,0x6
ffffffe000200fc4:	04070713          	addi	a4,a4,64 # ffffffe000207000 <early_pgtbl>
ffffffe000200fc8:	fe843783          	ld	a5,-24(s0)
ffffffe000200fcc:	00379793          	slli	a5,a5,0x3
ffffffe000200fd0:	00f707b3          	add	a5,a4,a5
ffffffe000200fd4:	20000737          	lui	a4,0x20000
ffffffe000200fd8:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200fdc:	00006717          	auipc	a4,0x6
ffffffe000200fe0:	02470713          	addi	a4,a4,36 # ffffffe000207000 <early_pgtbl>
ffffffe000200fe4:	fe843783          	ld	a5,-24(s0)
ffffffe000200fe8:	00379793          	slli	a5,a5,0x3
ffffffe000200fec:	00f707b3          	add	a5,a4,a5
ffffffe000200ff0:	0007b783          	ld	a5,0(a5)
ffffffe000200ff4:	00f7e713          	ori	a4,a5,15
ffffffe000200ff8:	00006697          	auipc	a3,0x6
ffffffe000200ffc:	00868693          	addi	a3,a3,8 # ffffffe000207000 <early_pgtbl>
ffffffe000201000:	fe843783          	ld	a5,-24(s0)
ffffffe000201004:	00379793          	slli	a5,a5,0x3
ffffffe000201008:	00f687b3          	add	a5,a3,a5
ffffffe00020100c:	00e7b023          	sd	a4,0(a5)

    printk("...setup_vm done!\n");
ffffffe000201010:	00002517          	auipc	a0,0x2
ffffffe000201014:	1e850513          	addi	a0,a0,488 # ffffffe0002031f8 <__func__.0+0x50>
ffffffe000201018:	7c5000ef          	jal	ffffffe000201fdc <printk>
ffffffe00020101c:	00000013          	nop
ffffffe000201020:	01813083          	ld	ra,24(sp)
ffffffe000201024:	01013403          	ld	s0,16(sp)
ffffffe000201028:	02010113          	addi	sp,sp,32
ffffffe00020102c:	00008067          	ret

ffffffe000201030 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe000201030:	ff010113          	addi	sp,sp,-16
ffffffe000201034:	00113423          	sd	ra,8(sp)
ffffffe000201038:	00813023          	sd	s0,0(sp)
ffffffe00020103c:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe000201040:	00002517          	auipc	a0,0x2
ffffffe000201044:	1d050513          	addi	a0,a0,464 # ffffffe000203210 <__func__.0+0x68>
ffffffe000201048:	795000ef          	jal	ffffffe000201fdc <printk>
    printk(" ZJU Operating System\n");
ffffffe00020104c:	00002517          	auipc	a0,0x2
ffffffe000201050:	1cc50513          	addi	a0,a0,460 # ffffffe000203218 <__func__.0+0x70>
ffffffe000201054:	789000ef          	jal	ffffffe000201fdc <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe000201058:	0b0000ef          	jal	ffffffe000201108 <run_idle>
    return 0;
ffffffe00020105c:	00000793          	li	a5,0
}
ffffffe000201060:	00078513          	mv	a0,a5
ffffffe000201064:	00813083          	ld	ra,8(sp)
ffffffe000201068:	00013403          	ld	s0,0(sp)
ffffffe00020106c:	01010113          	addi	sp,sp,16
ffffffe000201070:	00008067          	ret

ffffffe000201074 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe000201074:	ff010113          	addi	sp,sp,-16
ffffffe000201078:	00113423          	sd	ra,8(sp)
ffffffe00020107c:	00813023          	sd	s0,0(sp)
ffffffe000201080:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe000201084:	00000593          	li	a1,0
ffffffe000201088:	00000513          	li	a0,0
ffffffe00020108c:	bf9ff0ef          	jal	ffffffe000200c84 <sbi_system_reset>

ffffffe000201090 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe000201090:	fe010113          	addi	sp,sp,-32
ffffffe000201094:	00113c23          	sd	ra,24(sp)
ffffffe000201098:	00813823          	sd	s0,16(sp)
ffffffe00020109c:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe0002010a0:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe0002010a4:	fec42783          	lw	a5,-20(s0)
ffffffe0002010a8:	0017879b          	addiw	a5,a5,1
ffffffe0002010ac:	fef42623          	sw	a5,-20(s0)
ffffffe0002010b0:	fec42783          	lw	a5,-20(s0)
ffffffe0002010b4:	0007869b          	sext.w	a3,a5
ffffffe0002010b8:	55e64737          	lui	a4,0x55e64
ffffffe0002010bc:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <PHY_SIZE+0x4de63b89>
ffffffe0002010c0:	02e68733          	mul	a4,a3,a4
ffffffe0002010c4:	02075713          	srli	a4,a4,0x20
ffffffe0002010c8:	4197571b          	sraiw	a4,a4,0x19
ffffffe0002010cc:	00070693          	mv	a3,a4
ffffffe0002010d0:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffe0002010d4:	40e6873b          	subw	a4,a3,a4
ffffffe0002010d8:	00070693          	mv	a3,a4
ffffffe0002010dc:	05f5e737          	lui	a4,0x5f5e
ffffffe0002010e0:	1007071b          	addiw	a4,a4,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe0002010e4:	02e6873b          	mulw	a4,a3,a4
ffffffe0002010e8:	40e787bb          	subw	a5,a5,a4
ffffffe0002010ec:	0007879b          	sext.w	a5,a5
ffffffe0002010f0:	fa079ae3          	bnez	a5,ffffffe0002010a4 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe0002010f4:	00002517          	auipc	a0,0x2
ffffffe0002010f8:	13c50513          	addi	a0,a0,316 # ffffffe000203230 <__func__.0+0x88>
ffffffe0002010fc:	6e1000ef          	jal	ffffffe000201fdc <printk>
            i = 0;
ffffffe000201100:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe000201104:	fa1ff06f          	j	ffffffe0002010a4 <test+0x14>

ffffffe000201108 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe000201108:	ff010113          	addi	sp,sp,-16
ffffffe00020110c:	00113423          	sd	ra,8(sp)
ffffffe000201110:	00813023          	sd	s0,0(sp)
ffffffe000201114:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe000201118:	0000006f          	j	ffffffe000201118 <run_idle+0x10>

ffffffe00020111c <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe00020111c:	fe010113          	addi	sp,sp,-32
ffffffe000201120:	00113c23          	sd	ra,24(sp)
ffffffe000201124:	00813823          	sd	s0,16(sp)
ffffffe000201128:	02010413          	addi	s0,sp,32
ffffffe00020112c:	00050793          	mv	a5,a0
ffffffe000201130:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe000201134:	fec42783          	lw	a5,-20(s0)
ffffffe000201138:	0ff7f793          	zext.b	a5,a5
ffffffe00020113c:	00078513          	mv	a0,a5
ffffffe000201140:	ab5ff0ef          	jal	ffffffe000200bf4 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe000201144:	fec42783          	lw	a5,-20(s0)
ffffffe000201148:	0ff7f793          	zext.b	a5,a5
ffffffe00020114c:	0007879b          	sext.w	a5,a5
}
ffffffe000201150:	00078513          	mv	a0,a5
ffffffe000201154:	01813083          	ld	ra,24(sp)
ffffffe000201158:	01013403          	ld	s0,16(sp)
ffffffe00020115c:	02010113          	addi	sp,sp,32
ffffffe000201160:	00008067          	ret

ffffffe000201164 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe000201164:	fe010113          	addi	sp,sp,-32
ffffffe000201168:	00113c23          	sd	ra,24(sp)
ffffffe00020116c:	00813823          	sd	s0,16(sp)
ffffffe000201170:	02010413          	addi	s0,sp,32
ffffffe000201174:	00050793          	mv	a5,a0
ffffffe000201178:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe00020117c:	fec42783          	lw	a5,-20(s0)
ffffffe000201180:	0007871b          	sext.w	a4,a5
ffffffe000201184:	02000793          	li	a5,32
ffffffe000201188:	02f70263          	beq	a4,a5,ffffffe0002011ac <isspace+0x48>
ffffffe00020118c:	fec42783          	lw	a5,-20(s0)
ffffffe000201190:	0007871b          	sext.w	a4,a5
ffffffe000201194:	00800793          	li	a5,8
ffffffe000201198:	00e7de63          	bge	a5,a4,ffffffe0002011b4 <isspace+0x50>
ffffffe00020119c:	fec42783          	lw	a5,-20(s0)
ffffffe0002011a0:	0007871b          	sext.w	a4,a5
ffffffe0002011a4:	00d00793          	li	a5,13
ffffffe0002011a8:	00e7c663          	blt	a5,a4,ffffffe0002011b4 <isspace+0x50>
ffffffe0002011ac:	00100793          	li	a5,1
ffffffe0002011b0:	0080006f          	j	ffffffe0002011b8 <isspace+0x54>
ffffffe0002011b4:	00000793          	li	a5,0
}
ffffffe0002011b8:	00078513          	mv	a0,a5
ffffffe0002011bc:	01813083          	ld	ra,24(sp)
ffffffe0002011c0:	01013403          	ld	s0,16(sp)
ffffffe0002011c4:	02010113          	addi	sp,sp,32
ffffffe0002011c8:	00008067          	ret

ffffffe0002011cc <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe0002011cc:	fb010113          	addi	sp,sp,-80
ffffffe0002011d0:	04113423          	sd	ra,72(sp)
ffffffe0002011d4:	04813023          	sd	s0,64(sp)
ffffffe0002011d8:	05010413          	addi	s0,sp,80
ffffffe0002011dc:	fca43423          	sd	a0,-56(s0)
ffffffe0002011e0:	fcb43023          	sd	a1,-64(s0)
ffffffe0002011e4:	00060793          	mv	a5,a2
ffffffe0002011e8:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe0002011ec:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe0002011f0:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe0002011f4:	fc843783          	ld	a5,-56(s0)
ffffffe0002011f8:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe0002011fc:	0100006f          	j	ffffffe00020120c <strtol+0x40>
        p++;
ffffffe000201200:	fd843783          	ld	a5,-40(s0)
ffffffe000201204:	00178793          	addi	a5,a5,1
ffffffe000201208:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe00020120c:	fd843783          	ld	a5,-40(s0)
ffffffe000201210:	0007c783          	lbu	a5,0(a5)
ffffffe000201214:	0007879b          	sext.w	a5,a5
ffffffe000201218:	00078513          	mv	a0,a5
ffffffe00020121c:	f49ff0ef          	jal	ffffffe000201164 <isspace>
ffffffe000201220:	00050793          	mv	a5,a0
ffffffe000201224:	fc079ee3          	bnez	a5,ffffffe000201200 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe000201228:	fd843783          	ld	a5,-40(s0)
ffffffe00020122c:	0007c783          	lbu	a5,0(a5)
ffffffe000201230:	00078713          	mv	a4,a5
ffffffe000201234:	02d00793          	li	a5,45
ffffffe000201238:	00f71e63          	bne	a4,a5,ffffffe000201254 <strtol+0x88>
        neg = true;
ffffffe00020123c:	00100793          	li	a5,1
ffffffe000201240:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe000201244:	fd843783          	ld	a5,-40(s0)
ffffffe000201248:	00178793          	addi	a5,a5,1
ffffffe00020124c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201250:	0240006f          	j	ffffffe000201274 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe000201254:	fd843783          	ld	a5,-40(s0)
ffffffe000201258:	0007c783          	lbu	a5,0(a5)
ffffffe00020125c:	00078713          	mv	a4,a5
ffffffe000201260:	02b00793          	li	a5,43
ffffffe000201264:	00f71863          	bne	a4,a5,ffffffe000201274 <strtol+0xa8>
        p++;
ffffffe000201268:	fd843783          	ld	a5,-40(s0)
ffffffe00020126c:	00178793          	addi	a5,a5,1
ffffffe000201270:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe000201274:	fbc42783          	lw	a5,-68(s0)
ffffffe000201278:	0007879b          	sext.w	a5,a5
ffffffe00020127c:	06079c63          	bnez	a5,ffffffe0002012f4 <strtol+0x128>
        if (*p == '0') {
ffffffe000201280:	fd843783          	ld	a5,-40(s0)
ffffffe000201284:	0007c783          	lbu	a5,0(a5)
ffffffe000201288:	00078713          	mv	a4,a5
ffffffe00020128c:	03000793          	li	a5,48
ffffffe000201290:	04f71e63          	bne	a4,a5,ffffffe0002012ec <strtol+0x120>
            p++;
ffffffe000201294:	fd843783          	ld	a5,-40(s0)
ffffffe000201298:	00178793          	addi	a5,a5,1
ffffffe00020129c:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe0002012a0:	fd843783          	ld	a5,-40(s0)
ffffffe0002012a4:	0007c783          	lbu	a5,0(a5)
ffffffe0002012a8:	00078713          	mv	a4,a5
ffffffe0002012ac:	07800793          	li	a5,120
ffffffe0002012b0:	00f70c63          	beq	a4,a5,ffffffe0002012c8 <strtol+0xfc>
ffffffe0002012b4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012b8:	0007c783          	lbu	a5,0(a5)
ffffffe0002012bc:	00078713          	mv	a4,a5
ffffffe0002012c0:	05800793          	li	a5,88
ffffffe0002012c4:	00f71e63          	bne	a4,a5,ffffffe0002012e0 <strtol+0x114>
                base = 16;
ffffffe0002012c8:	01000793          	li	a5,16
ffffffe0002012cc:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe0002012d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002012d4:	00178793          	addi	a5,a5,1
ffffffe0002012d8:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002012dc:	0180006f          	j	ffffffe0002012f4 <strtol+0x128>
            } else {
                base = 8;
ffffffe0002012e0:	00800793          	li	a5,8
ffffffe0002012e4:	faf42e23          	sw	a5,-68(s0)
ffffffe0002012e8:	00c0006f          	j	ffffffe0002012f4 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe0002012ec:	00a00793          	li	a5,10
ffffffe0002012f0:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe0002012f4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012f8:	0007c783          	lbu	a5,0(a5)
ffffffe0002012fc:	00078713          	mv	a4,a5
ffffffe000201300:	02f00793          	li	a5,47
ffffffe000201304:	02e7f863          	bgeu	a5,a4,ffffffe000201334 <strtol+0x168>
ffffffe000201308:	fd843783          	ld	a5,-40(s0)
ffffffe00020130c:	0007c783          	lbu	a5,0(a5)
ffffffe000201310:	00078713          	mv	a4,a5
ffffffe000201314:	03900793          	li	a5,57
ffffffe000201318:	00e7ee63          	bltu	a5,a4,ffffffe000201334 <strtol+0x168>
            digit = *p - '0';
ffffffe00020131c:	fd843783          	ld	a5,-40(s0)
ffffffe000201320:	0007c783          	lbu	a5,0(a5)
ffffffe000201324:	0007879b          	sext.w	a5,a5
ffffffe000201328:	fd07879b          	addiw	a5,a5,-48
ffffffe00020132c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201330:	0800006f          	j	ffffffe0002013b0 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe000201334:	fd843783          	ld	a5,-40(s0)
ffffffe000201338:	0007c783          	lbu	a5,0(a5)
ffffffe00020133c:	00078713          	mv	a4,a5
ffffffe000201340:	06000793          	li	a5,96
ffffffe000201344:	02e7f863          	bgeu	a5,a4,ffffffe000201374 <strtol+0x1a8>
ffffffe000201348:	fd843783          	ld	a5,-40(s0)
ffffffe00020134c:	0007c783          	lbu	a5,0(a5)
ffffffe000201350:	00078713          	mv	a4,a5
ffffffe000201354:	07a00793          	li	a5,122
ffffffe000201358:	00e7ee63          	bltu	a5,a4,ffffffe000201374 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe00020135c:	fd843783          	ld	a5,-40(s0)
ffffffe000201360:	0007c783          	lbu	a5,0(a5)
ffffffe000201364:	0007879b          	sext.w	a5,a5
ffffffe000201368:	fa97879b          	addiw	a5,a5,-87
ffffffe00020136c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201370:	0400006f          	j	ffffffe0002013b0 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe000201374:	fd843783          	ld	a5,-40(s0)
ffffffe000201378:	0007c783          	lbu	a5,0(a5)
ffffffe00020137c:	00078713          	mv	a4,a5
ffffffe000201380:	04000793          	li	a5,64
ffffffe000201384:	06e7f863          	bgeu	a5,a4,ffffffe0002013f4 <strtol+0x228>
ffffffe000201388:	fd843783          	ld	a5,-40(s0)
ffffffe00020138c:	0007c783          	lbu	a5,0(a5)
ffffffe000201390:	00078713          	mv	a4,a5
ffffffe000201394:	05a00793          	li	a5,90
ffffffe000201398:	04e7ee63          	bltu	a5,a4,ffffffe0002013f4 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe00020139c:	fd843783          	ld	a5,-40(s0)
ffffffe0002013a0:	0007c783          	lbu	a5,0(a5)
ffffffe0002013a4:	0007879b          	sext.w	a5,a5
ffffffe0002013a8:	fc97879b          	addiw	a5,a5,-55
ffffffe0002013ac:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe0002013b0:	fd442783          	lw	a5,-44(s0)
ffffffe0002013b4:	00078713          	mv	a4,a5
ffffffe0002013b8:	fbc42783          	lw	a5,-68(s0)
ffffffe0002013bc:	0007071b          	sext.w	a4,a4
ffffffe0002013c0:	0007879b          	sext.w	a5,a5
ffffffe0002013c4:	02f75663          	bge	a4,a5,ffffffe0002013f0 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe0002013c8:	fbc42703          	lw	a4,-68(s0)
ffffffe0002013cc:	fe843783          	ld	a5,-24(s0)
ffffffe0002013d0:	02f70733          	mul	a4,a4,a5
ffffffe0002013d4:	fd442783          	lw	a5,-44(s0)
ffffffe0002013d8:	00f707b3          	add	a5,a4,a5
ffffffe0002013dc:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe0002013e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002013e4:	00178793          	addi	a5,a5,1
ffffffe0002013e8:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe0002013ec:	f09ff06f          	j	ffffffe0002012f4 <strtol+0x128>
            break;
ffffffe0002013f0:	00000013          	nop
    }

    if (endptr) {
ffffffe0002013f4:	fc043783          	ld	a5,-64(s0)
ffffffe0002013f8:	00078863          	beqz	a5,ffffffe000201408 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe0002013fc:	fc043783          	ld	a5,-64(s0)
ffffffe000201400:	fd843703          	ld	a4,-40(s0)
ffffffe000201404:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe000201408:	fe744783          	lbu	a5,-25(s0)
ffffffe00020140c:	0ff7f793          	zext.b	a5,a5
ffffffe000201410:	00078863          	beqz	a5,ffffffe000201420 <strtol+0x254>
ffffffe000201414:	fe843783          	ld	a5,-24(s0)
ffffffe000201418:	40f007b3          	neg	a5,a5
ffffffe00020141c:	0080006f          	j	ffffffe000201424 <strtol+0x258>
ffffffe000201420:	fe843783          	ld	a5,-24(s0)
}
ffffffe000201424:	00078513          	mv	a0,a5
ffffffe000201428:	04813083          	ld	ra,72(sp)
ffffffe00020142c:	04013403          	ld	s0,64(sp)
ffffffe000201430:	05010113          	addi	sp,sp,80
ffffffe000201434:	00008067          	ret

ffffffe000201438 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe000201438:	fd010113          	addi	sp,sp,-48
ffffffe00020143c:	02113423          	sd	ra,40(sp)
ffffffe000201440:	02813023          	sd	s0,32(sp)
ffffffe000201444:	03010413          	addi	s0,sp,48
ffffffe000201448:	fca43c23          	sd	a0,-40(s0)
ffffffe00020144c:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe000201450:	fd043783          	ld	a5,-48(s0)
ffffffe000201454:	00079863          	bnez	a5,ffffffe000201464 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe000201458:	00002797          	auipc	a5,0x2
ffffffe00020145c:	df078793          	addi	a5,a5,-528 # ffffffe000203248 <__func__.0+0xa0>
ffffffe000201460:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe000201464:	fd043783          	ld	a5,-48(s0)
ffffffe000201468:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe00020146c:	0240006f          	j	ffffffe000201490 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe000201470:	fe843783          	ld	a5,-24(s0)
ffffffe000201474:	00178713          	addi	a4,a5,1
ffffffe000201478:	fee43423          	sd	a4,-24(s0)
ffffffe00020147c:	0007c783          	lbu	a5,0(a5)
ffffffe000201480:	0007871b          	sext.w	a4,a5
ffffffe000201484:	fd843783          	ld	a5,-40(s0)
ffffffe000201488:	00070513          	mv	a0,a4
ffffffe00020148c:	000780e7          	jalr	a5
    while (*p) {
ffffffe000201490:	fe843783          	ld	a5,-24(s0)
ffffffe000201494:	0007c783          	lbu	a5,0(a5)
ffffffe000201498:	fc079ce3          	bnez	a5,ffffffe000201470 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe00020149c:	fe843703          	ld	a4,-24(s0)
ffffffe0002014a0:	fd043783          	ld	a5,-48(s0)
ffffffe0002014a4:	40f707b3          	sub	a5,a4,a5
ffffffe0002014a8:	0007879b          	sext.w	a5,a5
}
ffffffe0002014ac:	00078513          	mv	a0,a5
ffffffe0002014b0:	02813083          	ld	ra,40(sp)
ffffffe0002014b4:	02013403          	ld	s0,32(sp)
ffffffe0002014b8:	03010113          	addi	sp,sp,48
ffffffe0002014bc:	00008067          	ret

ffffffe0002014c0 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe0002014c0:	f9010113          	addi	sp,sp,-112
ffffffe0002014c4:	06113423          	sd	ra,104(sp)
ffffffe0002014c8:	06813023          	sd	s0,96(sp)
ffffffe0002014cc:	07010413          	addi	s0,sp,112
ffffffe0002014d0:	faa43423          	sd	a0,-88(s0)
ffffffe0002014d4:	fab43023          	sd	a1,-96(s0)
ffffffe0002014d8:	00060793          	mv	a5,a2
ffffffe0002014dc:	f8d43823          	sd	a3,-112(s0)
ffffffe0002014e0:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe0002014e4:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002014e8:	0ff7f793          	zext.b	a5,a5
ffffffe0002014ec:	02078663          	beqz	a5,ffffffe000201518 <print_dec_int+0x58>
ffffffe0002014f0:	fa043703          	ld	a4,-96(s0)
ffffffe0002014f4:	fff00793          	li	a5,-1
ffffffe0002014f8:	03f79793          	slli	a5,a5,0x3f
ffffffe0002014fc:	00f71e63          	bne	a4,a5,ffffffe000201518 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe000201500:	00002597          	auipc	a1,0x2
ffffffe000201504:	d5058593          	addi	a1,a1,-688 # ffffffe000203250 <__func__.0+0xa8>
ffffffe000201508:	fa843503          	ld	a0,-88(s0)
ffffffe00020150c:	f2dff0ef          	jal	ffffffe000201438 <puts_wo_nl>
ffffffe000201510:	00050793          	mv	a5,a0
ffffffe000201514:	2c80006f          	j	ffffffe0002017dc <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe000201518:	f9043783          	ld	a5,-112(s0)
ffffffe00020151c:	00c7a783          	lw	a5,12(a5)
ffffffe000201520:	00079a63          	bnez	a5,ffffffe000201534 <print_dec_int+0x74>
ffffffe000201524:	fa043783          	ld	a5,-96(s0)
ffffffe000201528:	00079663          	bnez	a5,ffffffe000201534 <print_dec_int+0x74>
        return 0;
ffffffe00020152c:	00000793          	li	a5,0
ffffffe000201530:	2ac0006f          	j	ffffffe0002017dc <print_dec_int+0x31c>
    }

    bool neg = false;
ffffffe000201534:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe000201538:	f9f44783          	lbu	a5,-97(s0)
ffffffe00020153c:	0ff7f793          	zext.b	a5,a5
ffffffe000201540:	02078063          	beqz	a5,ffffffe000201560 <print_dec_int+0xa0>
ffffffe000201544:	fa043783          	ld	a5,-96(s0)
ffffffe000201548:	0007dc63          	bgez	a5,ffffffe000201560 <print_dec_int+0xa0>
        neg = true;
ffffffe00020154c:	00100793          	li	a5,1
ffffffe000201550:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe000201554:	fa043783          	ld	a5,-96(s0)
ffffffe000201558:	40f007b3          	neg	a5,a5
ffffffe00020155c:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe000201560:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe000201564:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201568:	0ff7f793          	zext.b	a5,a5
ffffffe00020156c:	02078863          	beqz	a5,ffffffe00020159c <print_dec_int+0xdc>
ffffffe000201570:	fef44783          	lbu	a5,-17(s0)
ffffffe000201574:	0ff7f793          	zext.b	a5,a5
ffffffe000201578:	00079e63          	bnez	a5,ffffffe000201594 <print_dec_int+0xd4>
ffffffe00020157c:	f9043783          	ld	a5,-112(s0)
ffffffe000201580:	0057c783          	lbu	a5,5(a5)
ffffffe000201584:	00079863          	bnez	a5,ffffffe000201594 <print_dec_int+0xd4>
ffffffe000201588:	f9043783          	ld	a5,-112(s0)
ffffffe00020158c:	0047c783          	lbu	a5,4(a5)
ffffffe000201590:	00078663          	beqz	a5,ffffffe00020159c <print_dec_int+0xdc>
ffffffe000201594:	00100793          	li	a5,1
ffffffe000201598:	0080006f          	j	ffffffe0002015a0 <print_dec_int+0xe0>
ffffffe00020159c:	00000793          	li	a5,0
ffffffe0002015a0:	fcf40ba3          	sb	a5,-41(s0)
ffffffe0002015a4:	fd744783          	lbu	a5,-41(s0)
ffffffe0002015a8:	0017f793          	andi	a5,a5,1
ffffffe0002015ac:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe0002015b0:	fa043683          	ld	a3,-96(s0)
ffffffe0002015b4:	00002797          	auipc	a5,0x2
ffffffe0002015b8:	cb478793          	addi	a5,a5,-844 # ffffffe000203268 <__func__.0+0xc0>
ffffffe0002015bc:	0007b783          	ld	a5,0(a5)
ffffffe0002015c0:	02f6b7b3          	mulhu	a5,a3,a5
ffffffe0002015c4:	0037d713          	srli	a4,a5,0x3
ffffffe0002015c8:	00070793          	mv	a5,a4
ffffffe0002015cc:	00279793          	slli	a5,a5,0x2
ffffffe0002015d0:	00e787b3          	add	a5,a5,a4
ffffffe0002015d4:	00179793          	slli	a5,a5,0x1
ffffffe0002015d8:	40f68733          	sub	a4,a3,a5
ffffffe0002015dc:	0ff77713          	zext.b	a4,a4
ffffffe0002015e0:	fe842783          	lw	a5,-24(s0)
ffffffe0002015e4:	0017869b          	addiw	a3,a5,1
ffffffe0002015e8:	fed42423          	sw	a3,-24(s0)
ffffffe0002015ec:	0307071b          	addiw	a4,a4,48
ffffffe0002015f0:	0ff77713          	zext.b	a4,a4
ffffffe0002015f4:	ff078793          	addi	a5,a5,-16
ffffffe0002015f8:	008787b3          	add	a5,a5,s0
ffffffe0002015fc:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe000201600:	fa043703          	ld	a4,-96(s0)
ffffffe000201604:	00002797          	auipc	a5,0x2
ffffffe000201608:	c6478793          	addi	a5,a5,-924 # ffffffe000203268 <__func__.0+0xc0>
ffffffe00020160c:	0007b783          	ld	a5,0(a5)
ffffffe000201610:	02f737b3          	mulhu	a5,a4,a5
ffffffe000201614:	0037d793          	srli	a5,a5,0x3
ffffffe000201618:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe00020161c:	fa043783          	ld	a5,-96(s0)
ffffffe000201620:	f80798e3          	bnez	a5,ffffffe0002015b0 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe000201624:	f9043783          	ld	a5,-112(s0)
ffffffe000201628:	00c7a703          	lw	a4,12(a5)
ffffffe00020162c:	fff00793          	li	a5,-1
ffffffe000201630:	02f71063          	bne	a4,a5,ffffffe000201650 <print_dec_int+0x190>
ffffffe000201634:	f9043783          	ld	a5,-112(s0)
ffffffe000201638:	0037c783          	lbu	a5,3(a5)
ffffffe00020163c:	00078a63          	beqz	a5,ffffffe000201650 <print_dec_int+0x190>
        flags->prec = flags->width;
ffffffe000201640:	f9043783          	ld	a5,-112(s0)
ffffffe000201644:	0087a703          	lw	a4,8(a5)
ffffffe000201648:	f9043783          	ld	a5,-112(s0)
ffffffe00020164c:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe000201650:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201654:	f9043783          	ld	a5,-112(s0)
ffffffe000201658:	0087a703          	lw	a4,8(a5)
ffffffe00020165c:	fe842783          	lw	a5,-24(s0)
ffffffe000201660:	fcf42823          	sw	a5,-48(s0)
ffffffe000201664:	f9043783          	ld	a5,-112(s0)
ffffffe000201668:	00c7a783          	lw	a5,12(a5)
ffffffe00020166c:	fcf42623          	sw	a5,-52(s0)
ffffffe000201670:	fd042783          	lw	a5,-48(s0)
ffffffe000201674:	00078593          	mv	a1,a5
ffffffe000201678:	fcc42783          	lw	a5,-52(s0)
ffffffe00020167c:	00078613          	mv	a2,a5
ffffffe000201680:	0006069b          	sext.w	a3,a2
ffffffe000201684:	0005879b          	sext.w	a5,a1
ffffffe000201688:	00f6d463          	bge	a3,a5,ffffffe000201690 <print_dec_int+0x1d0>
ffffffe00020168c:	00058613          	mv	a2,a1
ffffffe000201690:	0006079b          	sext.w	a5,a2
ffffffe000201694:	40f707bb          	subw	a5,a4,a5
ffffffe000201698:	0007871b          	sext.w	a4,a5
ffffffe00020169c:	fd744783          	lbu	a5,-41(s0)
ffffffe0002016a0:	0007879b          	sext.w	a5,a5
ffffffe0002016a4:	40f707bb          	subw	a5,a4,a5
ffffffe0002016a8:	fef42023          	sw	a5,-32(s0)
ffffffe0002016ac:	0280006f          	j	ffffffe0002016d4 <print_dec_int+0x214>
        putch(' ');
ffffffe0002016b0:	fa843783          	ld	a5,-88(s0)
ffffffe0002016b4:	02000513          	li	a0,32
ffffffe0002016b8:	000780e7          	jalr	a5
        ++written;
ffffffe0002016bc:	fe442783          	lw	a5,-28(s0)
ffffffe0002016c0:	0017879b          	addiw	a5,a5,1
ffffffe0002016c4:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe0002016c8:	fe042783          	lw	a5,-32(s0)
ffffffe0002016cc:	fff7879b          	addiw	a5,a5,-1
ffffffe0002016d0:	fef42023          	sw	a5,-32(s0)
ffffffe0002016d4:	fe042783          	lw	a5,-32(s0)
ffffffe0002016d8:	0007879b          	sext.w	a5,a5
ffffffe0002016dc:	fcf04ae3          	bgtz	a5,ffffffe0002016b0 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
ffffffe0002016e0:	fd744783          	lbu	a5,-41(s0)
ffffffe0002016e4:	0ff7f793          	zext.b	a5,a5
ffffffe0002016e8:	04078463          	beqz	a5,ffffffe000201730 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe0002016ec:	fef44783          	lbu	a5,-17(s0)
ffffffe0002016f0:	0ff7f793          	zext.b	a5,a5
ffffffe0002016f4:	00078663          	beqz	a5,ffffffe000201700 <print_dec_int+0x240>
ffffffe0002016f8:	02d00793          	li	a5,45
ffffffe0002016fc:	01c0006f          	j	ffffffe000201718 <print_dec_int+0x258>
ffffffe000201700:	f9043783          	ld	a5,-112(s0)
ffffffe000201704:	0057c783          	lbu	a5,5(a5)
ffffffe000201708:	00078663          	beqz	a5,ffffffe000201714 <print_dec_int+0x254>
ffffffe00020170c:	02b00793          	li	a5,43
ffffffe000201710:	0080006f          	j	ffffffe000201718 <print_dec_int+0x258>
ffffffe000201714:	02000793          	li	a5,32
ffffffe000201718:	fa843703          	ld	a4,-88(s0)
ffffffe00020171c:	00078513          	mv	a0,a5
ffffffe000201720:	000700e7          	jalr	a4
        ++written;
ffffffe000201724:	fe442783          	lw	a5,-28(s0)
ffffffe000201728:	0017879b          	addiw	a5,a5,1
ffffffe00020172c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201730:	fe842783          	lw	a5,-24(s0)
ffffffe000201734:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201738:	0280006f          	j	ffffffe000201760 <print_dec_int+0x2a0>
        putch('0');
ffffffe00020173c:	fa843783          	ld	a5,-88(s0)
ffffffe000201740:	03000513          	li	a0,48
ffffffe000201744:	000780e7          	jalr	a5
        ++written;
ffffffe000201748:	fe442783          	lw	a5,-28(s0)
ffffffe00020174c:	0017879b          	addiw	a5,a5,1
ffffffe000201750:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201754:	fdc42783          	lw	a5,-36(s0)
ffffffe000201758:	0017879b          	addiw	a5,a5,1
ffffffe00020175c:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201760:	f9043783          	ld	a5,-112(s0)
ffffffe000201764:	00c7a703          	lw	a4,12(a5)
ffffffe000201768:	fd744783          	lbu	a5,-41(s0)
ffffffe00020176c:	0007879b          	sext.w	a5,a5
ffffffe000201770:	40f707bb          	subw	a5,a4,a5
ffffffe000201774:	0007879b          	sext.w	a5,a5
ffffffe000201778:	fdc42703          	lw	a4,-36(s0)
ffffffe00020177c:	0007071b          	sext.w	a4,a4
ffffffe000201780:	faf74ee3          	blt	a4,a5,ffffffe00020173c <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201784:	fe842783          	lw	a5,-24(s0)
ffffffe000201788:	fff7879b          	addiw	a5,a5,-1
ffffffe00020178c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201790:	03c0006f          	j	ffffffe0002017cc <print_dec_int+0x30c>
        putch(buf[i]);
ffffffe000201794:	fd842783          	lw	a5,-40(s0)
ffffffe000201798:	ff078793          	addi	a5,a5,-16
ffffffe00020179c:	008787b3          	add	a5,a5,s0
ffffffe0002017a0:	fc87c783          	lbu	a5,-56(a5)
ffffffe0002017a4:	0007871b          	sext.w	a4,a5
ffffffe0002017a8:	fa843783          	ld	a5,-88(s0)
ffffffe0002017ac:	00070513          	mv	a0,a4
ffffffe0002017b0:	000780e7          	jalr	a5
        ++written;
ffffffe0002017b4:	fe442783          	lw	a5,-28(s0)
ffffffe0002017b8:	0017879b          	addiw	a5,a5,1
ffffffe0002017bc:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe0002017c0:	fd842783          	lw	a5,-40(s0)
ffffffe0002017c4:	fff7879b          	addiw	a5,a5,-1
ffffffe0002017c8:	fcf42c23          	sw	a5,-40(s0)
ffffffe0002017cc:	fd842783          	lw	a5,-40(s0)
ffffffe0002017d0:	0007879b          	sext.w	a5,a5
ffffffe0002017d4:	fc07d0e3          	bgez	a5,ffffffe000201794 <print_dec_int+0x2d4>
    }

    return written;
ffffffe0002017d8:	fe442783          	lw	a5,-28(s0)
}
ffffffe0002017dc:	00078513          	mv	a0,a5
ffffffe0002017e0:	06813083          	ld	ra,104(sp)
ffffffe0002017e4:	06013403          	ld	s0,96(sp)
ffffffe0002017e8:	07010113          	addi	sp,sp,112
ffffffe0002017ec:	00008067          	ret

ffffffe0002017f0 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe0002017f0:	f4010113          	addi	sp,sp,-192
ffffffe0002017f4:	0a113c23          	sd	ra,184(sp)
ffffffe0002017f8:	0a813823          	sd	s0,176(sp)
ffffffe0002017fc:	0c010413          	addi	s0,sp,192
ffffffe000201800:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201804:	f4b43823          	sd	a1,-176(s0)
ffffffe000201808:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe00020180c:	f8043023          	sd	zero,-128(s0)
ffffffe000201810:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201814:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201818:	7a00006f          	j	ffffffe000201fb8 <vprintfmt+0x7c8>
        if (flags.in_format) {
ffffffe00020181c:	f8044783          	lbu	a5,-128(s0)
ffffffe000201820:	72078c63          	beqz	a5,ffffffe000201f58 <vprintfmt+0x768>
            if (*fmt == '#') {
ffffffe000201824:	f5043783          	ld	a5,-176(s0)
ffffffe000201828:	0007c783          	lbu	a5,0(a5)
ffffffe00020182c:	00078713          	mv	a4,a5
ffffffe000201830:	02300793          	li	a5,35
ffffffe000201834:	00f71863          	bne	a4,a5,ffffffe000201844 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201838:	00100793          	li	a5,1
ffffffe00020183c:	f8f40123          	sb	a5,-126(s0)
ffffffe000201840:	76c0006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
ffffffe000201844:	f5043783          	ld	a5,-176(s0)
ffffffe000201848:	0007c783          	lbu	a5,0(a5)
ffffffe00020184c:	00078713          	mv	a4,a5
ffffffe000201850:	03000793          	li	a5,48
ffffffe000201854:	00f71863          	bne	a4,a5,ffffffe000201864 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe000201858:	00100793          	li	a5,1
ffffffe00020185c:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201860:	74c0006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201864:	f5043783          	ld	a5,-176(s0)
ffffffe000201868:	0007c783          	lbu	a5,0(a5)
ffffffe00020186c:	00078713          	mv	a4,a5
ffffffe000201870:	06c00793          	li	a5,108
ffffffe000201874:	04f70063          	beq	a4,a5,ffffffe0002018b4 <vprintfmt+0xc4>
ffffffe000201878:	f5043783          	ld	a5,-176(s0)
ffffffe00020187c:	0007c783          	lbu	a5,0(a5)
ffffffe000201880:	00078713          	mv	a4,a5
ffffffe000201884:	07a00793          	li	a5,122
ffffffe000201888:	02f70663          	beq	a4,a5,ffffffe0002018b4 <vprintfmt+0xc4>
ffffffe00020188c:	f5043783          	ld	a5,-176(s0)
ffffffe000201890:	0007c783          	lbu	a5,0(a5)
ffffffe000201894:	00078713          	mv	a4,a5
ffffffe000201898:	07400793          	li	a5,116
ffffffe00020189c:	00f70c63          	beq	a4,a5,ffffffe0002018b4 <vprintfmt+0xc4>
ffffffe0002018a0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018a4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018a8:	00078713          	mv	a4,a5
ffffffe0002018ac:	06a00793          	li	a5,106
ffffffe0002018b0:	00f71863          	bne	a4,a5,ffffffe0002018c0 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe0002018b4:	00100793          	li	a5,1
ffffffe0002018b8:	f8f400a3          	sb	a5,-127(s0)
ffffffe0002018bc:	6f00006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
ffffffe0002018c0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018c4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018c8:	00078713          	mv	a4,a5
ffffffe0002018cc:	02b00793          	li	a5,43
ffffffe0002018d0:	00f71863          	bne	a4,a5,ffffffe0002018e0 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe0002018d4:	00100793          	li	a5,1
ffffffe0002018d8:	f8f402a3          	sb	a5,-123(s0)
ffffffe0002018dc:	6d00006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
ffffffe0002018e0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018e4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018e8:	00078713          	mv	a4,a5
ffffffe0002018ec:	02000793          	li	a5,32
ffffffe0002018f0:	00f71863          	bne	a4,a5,ffffffe000201900 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe0002018f4:	00100793          	li	a5,1
ffffffe0002018f8:	f8f40223          	sb	a5,-124(s0)
ffffffe0002018fc:	6b00006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
ffffffe000201900:	f5043783          	ld	a5,-176(s0)
ffffffe000201904:	0007c783          	lbu	a5,0(a5)
ffffffe000201908:	00078713          	mv	a4,a5
ffffffe00020190c:	02a00793          	li	a5,42
ffffffe000201910:	00f71e63          	bne	a4,a5,ffffffe00020192c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201914:	f4843783          	ld	a5,-184(s0)
ffffffe000201918:	00878713          	addi	a4,a5,8
ffffffe00020191c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201920:	0007a783          	lw	a5,0(a5)
ffffffe000201924:	f8f42423          	sw	a5,-120(s0)
ffffffe000201928:	6840006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe00020192c:	f5043783          	ld	a5,-176(s0)
ffffffe000201930:	0007c783          	lbu	a5,0(a5)
ffffffe000201934:	00078713          	mv	a4,a5
ffffffe000201938:	03000793          	li	a5,48
ffffffe00020193c:	04e7f663          	bgeu	a5,a4,ffffffe000201988 <vprintfmt+0x198>
ffffffe000201940:	f5043783          	ld	a5,-176(s0)
ffffffe000201944:	0007c783          	lbu	a5,0(a5)
ffffffe000201948:	00078713          	mv	a4,a5
ffffffe00020194c:	03900793          	li	a5,57
ffffffe000201950:	02e7ec63          	bltu	a5,a4,ffffffe000201988 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe000201954:	f5043783          	ld	a5,-176(s0)
ffffffe000201958:	f5040713          	addi	a4,s0,-176
ffffffe00020195c:	00a00613          	li	a2,10
ffffffe000201960:	00070593          	mv	a1,a4
ffffffe000201964:	00078513          	mv	a0,a5
ffffffe000201968:	865ff0ef          	jal	ffffffe0002011cc <strtol>
ffffffe00020196c:	00050793          	mv	a5,a0
ffffffe000201970:	0007879b          	sext.w	a5,a5
ffffffe000201974:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201978:	f5043783          	ld	a5,-176(s0)
ffffffe00020197c:	fff78793          	addi	a5,a5,-1
ffffffe000201980:	f4f43823          	sd	a5,-176(s0)
ffffffe000201984:	6280006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
ffffffe000201988:	f5043783          	ld	a5,-176(s0)
ffffffe00020198c:	0007c783          	lbu	a5,0(a5)
ffffffe000201990:	00078713          	mv	a4,a5
ffffffe000201994:	02e00793          	li	a5,46
ffffffe000201998:	06f71863          	bne	a4,a5,ffffffe000201a08 <vprintfmt+0x218>
                fmt++;
ffffffe00020199c:	f5043783          	ld	a5,-176(s0)
ffffffe0002019a0:	00178793          	addi	a5,a5,1
ffffffe0002019a4:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe0002019a8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002019b0:	00078713          	mv	a4,a5
ffffffe0002019b4:	02a00793          	li	a5,42
ffffffe0002019b8:	00f71e63          	bne	a4,a5,ffffffe0002019d4 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe0002019bc:	f4843783          	ld	a5,-184(s0)
ffffffe0002019c0:	00878713          	addi	a4,a5,8
ffffffe0002019c4:	f4e43423          	sd	a4,-184(s0)
ffffffe0002019c8:	0007a783          	lw	a5,0(a5)
ffffffe0002019cc:	f8f42623          	sw	a5,-116(s0)
ffffffe0002019d0:	5dc0006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe0002019d4:	f5043783          	ld	a5,-176(s0)
ffffffe0002019d8:	f5040713          	addi	a4,s0,-176
ffffffe0002019dc:	00a00613          	li	a2,10
ffffffe0002019e0:	00070593          	mv	a1,a4
ffffffe0002019e4:	00078513          	mv	a0,a5
ffffffe0002019e8:	fe4ff0ef          	jal	ffffffe0002011cc <strtol>
ffffffe0002019ec:	00050793          	mv	a5,a0
ffffffe0002019f0:	0007879b          	sext.w	a5,a5
ffffffe0002019f4:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe0002019f8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019fc:	fff78793          	addi	a5,a5,-1
ffffffe000201a00:	f4f43823          	sd	a5,-176(s0)
ffffffe000201a04:	5a80006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201a08:	f5043783          	ld	a5,-176(s0)
ffffffe000201a0c:	0007c783          	lbu	a5,0(a5)
ffffffe000201a10:	00078713          	mv	a4,a5
ffffffe000201a14:	07800793          	li	a5,120
ffffffe000201a18:	02f70663          	beq	a4,a5,ffffffe000201a44 <vprintfmt+0x254>
ffffffe000201a1c:	f5043783          	ld	a5,-176(s0)
ffffffe000201a20:	0007c783          	lbu	a5,0(a5)
ffffffe000201a24:	00078713          	mv	a4,a5
ffffffe000201a28:	05800793          	li	a5,88
ffffffe000201a2c:	00f70c63          	beq	a4,a5,ffffffe000201a44 <vprintfmt+0x254>
ffffffe000201a30:	f5043783          	ld	a5,-176(s0)
ffffffe000201a34:	0007c783          	lbu	a5,0(a5)
ffffffe000201a38:	00078713          	mv	a4,a5
ffffffe000201a3c:	07000793          	li	a5,112
ffffffe000201a40:	30f71063          	bne	a4,a5,ffffffe000201d40 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201a44:	f5043783          	ld	a5,-176(s0)
ffffffe000201a48:	0007c783          	lbu	a5,0(a5)
ffffffe000201a4c:	00078713          	mv	a4,a5
ffffffe000201a50:	07000793          	li	a5,112
ffffffe000201a54:	00f70663          	beq	a4,a5,ffffffe000201a60 <vprintfmt+0x270>
ffffffe000201a58:	f8144783          	lbu	a5,-127(s0)
ffffffe000201a5c:	00078663          	beqz	a5,ffffffe000201a68 <vprintfmt+0x278>
ffffffe000201a60:	00100793          	li	a5,1
ffffffe000201a64:	0080006f          	j	ffffffe000201a6c <vprintfmt+0x27c>
ffffffe000201a68:	00000793          	li	a5,0
ffffffe000201a6c:	faf403a3          	sb	a5,-89(s0)
ffffffe000201a70:	fa744783          	lbu	a5,-89(s0)
ffffffe000201a74:	0017f793          	andi	a5,a5,1
ffffffe000201a78:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201a7c:	fa744783          	lbu	a5,-89(s0)
ffffffe000201a80:	0ff7f793          	zext.b	a5,a5
ffffffe000201a84:	00078c63          	beqz	a5,ffffffe000201a9c <vprintfmt+0x2ac>
ffffffe000201a88:	f4843783          	ld	a5,-184(s0)
ffffffe000201a8c:	00878713          	addi	a4,a5,8
ffffffe000201a90:	f4e43423          	sd	a4,-184(s0)
ffffffe000201a94:	0007b783          	ld	a5,0(a5)
ffffffe000201a98:	01c0006f          	j	ffffffe000201ab4 <vprintfmt+0x2c4>
ffffffe000201a9c:	f4843783          	ld	a5,-184(s0)
ffffffe000201aa0:	00878713          	addi	a4,a5,8
ffffffe000201aa4:	f4e43423          	sd	a4,-184(s0)
ffffffe000201aa8:	0007a783          	lw	a5,0(a5)
ffffffe000201aac:	02079793          	slli	a5,a5,0x20
ffffffe000201ab0:	0207d793          	srli	a5,a5,0x20
ffffffe000201ab4:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201ab8:	f8c42783          	lw	a5,-116(s0)
ffffffe000201abc:	02079463          	bnez	a5,ffffffe000201ae4 <vprintfmt+0x2f4>
ffffffe000201ac0:	fe043783          	ld	a5,-32(s0)
ffffffe000201ac4:	02079063          	bnez	a5,ffffffe000201ae4 <vprintfmt+0x2f4>
ffffffe000201ac8:	f5043783          	ld	a5,-176(s0)
ffffffe000201acc:	0007c783          	lbu	a5,0(a5)
ffffffe000201ad0:	00078713          	mv	a4,a5
ffffffe000201ad4:	07000793          	li	a5,112
ffffffe000201ad8:	00f70663          	beq	a4,a5,ffffffe000201ae4 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201adc:	f8040023          	sb	zero,-128(s0)
ffffffe000201ae0:	4cc0006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201ae4:	f5043783          	ld	a5,-176(s0)
ffffffe000201ae8:	0007c783          	lbu	a5,0(a5)
ffffffe000201aec:	00078713          	mv	a4,a5
ffffffe000201af0:	07000793          	li	a5,112
ffffffe000201af4:	00f70a63          	beq	a4,a5,ffffffe000201b08 <vprintfmt+0x318>
ffffffe000201af8:	f8244783          	lbu	a5,-126(s0)
ffffffe000201afc:	00078a63          	beqz	a5,ffffffe000201b10 <vprintfmt+0x320>
ffffffe000201b00:	fe043783          	ld	a5,-32(s0)
ffffffe000201b04:	00078663          	beqz	a5,ffffffe000201b10 <vprintfmt+0x320>
ffffffe000201b08:	00100793          	li	a5,1
ffffffe000201b0c:	0080006f          	j	ffffffe000201b14 <vprintfmt+0x324>
ffffffe000201b10:	00000793          	li	a5,0
ffffffe000201b14:	faf40323          	sb	a5,-90(s0)
ffffffe000201b18:	fa644783          	lbu	a5,-90(s0)
ffffffe000201b1c:	0017f793          	andi	a5,a5,1
ffffffe000201b20:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201b24:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201b28:	f5043783          	ld	a5,-176(s0)
ffffffe000201b2c:	0007c783          	lbu	a5,0(a5)
ffffffe000201b30:	00078713          	mv	a4,a5
ffffffe000201b34:	05800793          	li	a5,88
ffffffe000201b38:	00f71863          	bne	a4,a5,ffffffe000201b48 <vprintfmt+0x358>
ffffffe000201b3c:	00001797          	auipc	a5,0x1
ffffffe000201b40:	73478793          	addi	a5,a5,1844 # ffffffe000203270 <upperxdigits.1>
ffffffe000201b44:	00c0006f          	j	ffffffe000201b50 <vprintfmt+0x360>
ffffffe000201b48:	00001797          	auipc	a5,0x1
ffffffe000201b4c:	74078793          	addi	a5,a5,1856 # ffffffe000203288 <lowerxdigits.0>
ffffffe000201b50:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201b54:	fe043783          	ld	a5,-32(s0)
ffffffe000201b58:	00f7f793          	andi	a5,a5,15
ffffffe000201b5c:	f9843703          	ld	a4,-104(s0)
ffffffe000201b60:	00f70733          	add	a4,a4,a5
ffffffe000201b64:	fdc42783          	lw	a5,-36(s0)
ffffffe000201b68:	0017869b          	addiw	a3,a5,1
ffffffe000201b6c:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201b70:	00074703          	lbu	a4,0(a4)
ffffffe000201b74:	ff078793          	addi	a5,a5,-16
ffffffe000201b78:	008787b3          	add	a5,a5,s0
ffffffe000201b7c:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201b80:	fe043783          	ld	a5,-32(s0)
ffffffe000201b84:	0047d793          	srli	a5,a5,0x4
ffffffe000201b88:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201b8c:	fe043783          	ld	a5,-32(s0)
ffffffe000201b90:	fc0792e3          	bnez	a5,ffffffe000201b54 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201b94:	f8c42703          	lw	a4,-116(s0)
ffffffe000201b98:	fff00793          	li	a5,-1
ffffffe000201b9c:	02f71663          	bne	a4,a5,ffffffe000201bc8 <vprintfmt+0x3d8>
ffffffe000201ba0:	f8344783          	lbu	a5,-125(s0)
ffffffe000201ba4:	02078263          	beqz	a5,ffffffe000201bc8 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201ba8:	f8842703          	lw	a4,-120(s0)
ffffffe000201bac:	fa644783          	lbu	a5,-90(s0)
ffffffe000201bb0:	0007879b          	sext.w	a5,a5
ffffffe000201bb4:	0017979b          	slliw	a5,a5,0x1
ffffffe000201bb8:	0007879b          	sext.w	a5,a5
ffffffe000201bbc:	40f707bb          	subw	a5,a4,a5
ffffffe000201bc0:	0007879b          	sext.w	a5,a5
ffffffe000201bc4:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201bc8:	f8842703          	lw	a4,-120(s0)
ffffffe000201bcc:	fa644783          	lbu	a5,-90(s0)
ffffffe000201bd0:	0007879b          	sext.w	a5,a5
ffffffe000201bd4:	0017979b          	slliw	a5,a5,0x1
ffffffe000201bd8:	0007879b          	sext.w	a5,a5
ffffffe000201bdc:	40f707bb          	subw	a5,a4,a5
ffffffe000201be0:	0007871b          	sext.w	a4,a5
ffffffe000201be4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201be8:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201bec:	f8c42783          	lw	a5,-116(s0)
ffffffe000201bf0:	f8f42823          	sw	a5,-112(s0)
ffffffe000201bf4:	f9442783          	lw	a5,-108(s0)
ffffffe000201bf8:	00078593          	mv	a1,a5
ffffffe000201bfc:	f9042783          	lw	a5,-112(s0)
ffffffe000201c00:	00078613          	mv	a2,a5
ffffffe000201c04:	0006069b          	sext.w	a3,a2
ffffffe000201c08:	0005879b          	sext.w	a5,a1
ffffffe000201c0c:	00f6d463          	bge	a3,a5,ffffffe000201c14 <vprintfmt+0x424>
ffffffe000201c10:	00058613          	mv	a2,a1
ffffffe000201c14:	0006079b          	sext.w	a5,a2
ffffffe000201c18:	40f707bb          	subw	a5,a4,a5
ffffffe000201c1c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201c20:	0280006f          	j	ffffffe000201c48 <vprintfmt+0x458>
                    putch(' ');
ffffffe000201c24:	f5843783          	ld	a5,-168(s0)
ffffffe000201c28:	02000513          	li	a0,32
ffffffe000201c2c:	000780e7          	jalr	a5
                    ++written;
ffffffe000201c30:	fec42783          	lw	a5,-20(s0)
ffffffe000201c34:	0017879b          	addiw	a5,a5,1
ffffffe000201c38:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201c3c:	fd842783          	lw	a5,-40(s0)
ffffffe000201c40:	fff7879b          	addiw	a5,a5,-1
ffffffe000201c44:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201c48:	fd842783          	lw	a5,-40(s0)
ffffffe000201c4c:	0007879b          	sext.w	a5,a5
ffffffe000201c50:	fcf04ae3          	bgtz	a5,ffffffe000201c24 <vprintfmt+0x434>
                }

                if (prefix) {
ffffffe000201c54:	fa644783          	lbu	a5,-90(s0)
ffffffe000201c58:	0ff7f793          	zext.b	a5,a5
ffffffe000201c5c:	04078463          	beqz	a5,ffffffe000201ca4 <vprintfmt+0x4b4>
                    putch('0');
ffffffe000201c60:	f5843783          	ld	a5,-168(s0)
ffffffe000201c64:	03000513          	li	a0,48
ffffffe000201c68:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000201c6c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c70:	0007c783          	lbu	a5,0(a5)
ffffffe000201c74:	00078713          	mv	a4,a5
ffffffe000201c78:	05800793          	li	a5,88
ffffffe000201c7c:	00f71663          	bne	a4,a5,ffffffe000201c88 <vprintfmt+0x498>
ffffffe000201c80:	05800793          	li	a5,88
ffffffe000201c84:	0080006f          	j	ffffffe000201c8c <vprintfmt+0x49c>
ffffffe000201c88:	07800793          	li	a5,120
ffffffe000201c8c:	f5843703          	ld	a4,-168(s0)
ffffffe000201c90:	00078513          	mv	a0,a5
ffffffe000201c94:	000700e7          	jalr	a4
                    written += 2;
ffffffe000201c98:	fec42783          	lw	a5,-20(s0)
ffffffe000201c9c:	0027879b          	addiw	a5,a5,2
ffffffe000201ca0:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201ca4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201ca8:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201cac:	0280006f          	j	ffffffe000201cd4 <vprintfmt+0x4e4>
                    putch('0');
ffffffe000201cb0:	f5843783          	ld	a5,-168(s0)
ffffffe000201cb4:	03000513          	li	a0,48
ffffffe000201cb8:	000780e7          	jalr	a5
                    ++written;
ffffffe000201cbc:	fec42783          	lw	a5,-20(s0)
ffffffe000201cc0:	0017879b          	addiw	a5,a5,1
ffffffe000201cc4:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201cc8:	fd442783          	lw	a5,-44(s0)
ffffffe000201ccc:	0017879b          	addiw	a5,a5,1
ffffffe000201cd0:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201cd4:	f8c42783          	lw	a5,-116(s0)
ffffffe000201cd8:	fd442703          	lw	a4,-44(s0)
ffffffe000201cdc:	0007071b          	sext.w	a4,a4
ffffffe000201ce0:	fcf748e3          	blt	a4,a5,ffffffe000201cb0 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201ce4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201ce8:	fff7879b          	addiw	a5,a5,-1
ffffffe000201cec:	fcf42823          	sw	a5,-48(s0)
ffffffe000201cf0:	03c0006f          	j	ffffffe000201d2c <vprintfmt+0x53c>
                    putch(buf[i]);
ffffffe000201cf4:	fd042783          	lw	a5,-48(s0)
ffffffe000201cf8:	ff078793          	addi	a5,a5,-16
ffffffe000201cfc:	008787b3          	add	a5,a5,s0
ffffffe000201d00:	f807c783          	lbu	a5,-128(a5)
ffffffe000201d04:	0007871b          	sext.w	a4,a5
ffffffe000201d08:	f5843783          	ld	a5,-168(s0)
ffffffe000201d0c:	00070513          	mv	a0,a4
ffffffe000201d10:	000780e7          	jalr	a5
                    ++written;
ffffffe000201d14:	fec42783          	lw	a5,-20(s0)
ffffffe000201d18:	0017879b          	addiw	a5,a5,1
ffffffe000201d1c:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201d20:	fd042783          	lw	a5,-48(s0)
ffffffe000201d24:	fff7879b          	addiw	a5,a5,-1
ffffffe000201d28:	fcf42823          	sw	a5,-48(s0)
ffffffe000201d2c:	fd042783          	lw	a5,-48(s0)
ffffffe000201d30:	0007879b          	sext.w	a5,a5
ffffffe000201d34:	fc07d0e3          	bgez	a5,ffffffe000201cf4 <vprintfmt+0x504>
                }

                flags.in_format = false;
ffffffe000201d38:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201d3c:	2700006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201d40:	f5043783          	ld	a5,-176(s0)
ffffffe000201d44:	0007c783          	lbu	a5,0(a5)
ffffffe000201d48:	00078713          	mv	a4,a5
ffffffe000201d4c:	06400793          	li	a5,100
ffffffe000201d50:	02f70663          	beq	a4,a5,ffffffe000201d7c <vprintfmt+0x58c>
ffffffe000201d54:	f5043783          	ld	a5,-176(s0)
ffffffe000201d58:	0007c783          	lbu	a5,0(a5)
ffffffe000201d5c:	00078713          	mv	a4,a5
ffffffe000201d60:	06900793          	li	a5,105
ffffffe000201d64:	00f70c63          	beq	a4,a5,ffffffe000201d7c <vprintfmt+0x58c>
ffffffe000201d68:	f5043783          	ld	a5,-176(s0)
ffffffe000201d6c:	0007c783          	lbu	a5,0(a5)
ffffffe000201d70:	00078713          	mv	a4,a5
ffffffe000201d74:	07500793          	li	a5,117
ffffffe000201d78:	08f71063          	bne	a4,a5,ffffffe000201df8 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe000201d7c:	f8144783          	lbu	a5,-127(s0)
ffffffe000201d80:	00078c63          	beqz	a5,ffffffe000201d98 <vprintfmt+0x5a8>
ffffffe000201d84:	f4843783          	ld	a5,-184(s0)
ffffffe000201d88:	00878713          	addi	a4,a5,8
ffffffe000201d8c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d90:	0007b783          	ld	a5,0(a5)
ffffffe000201d94:	0140006f          	j	ffffffe000201da8 <vprintfmt+0x5b8>
ffffffe000201d98:	f4843783          	ld	a5,-184(s0)
ffffffe000201d9c:	00878713          	addi	a4,a5,8
ffffffe000201da0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201da4:	0007a783          	lw	a5,0(a5)
ffffffe000201da8:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000201dac:	fa843583          	ld	a1,-88(s0)
ffffffe000201db0:	f5043783          	ld	a5,-176(s0)
ffffffe000201db4:	0007c783          	lbu	a5,0(a5)
ffffffe000201db8:	0007871b          	sext.w	a4,a5
ffffffe000201dbc:	07500793          	li	a5,117
ffffffe000201dc0:	40f707b3          	sub	a5,a4,a5
ffffffe000201dc4:	00f037b3          	snez	a5,a5
ffffffe000201dc8:	0ff7f793          	zext.b	a5,a5
ffffffe000201dcc:	f8040713          	addi	a4,s0,-128
ffffffe000201dd0:	00070693          	mv	a3,a4
ffffffe000201dd4:	00078613          	mv	a2,a5
ffffffe000201dd8:	f5843503          	ld	a0,-168(s0)
ffffffe000201ddc:	ee4ff0ef          	jal	ffffffe0002014c0 <print_dec_int>
ffffffe000201de0:	00050793          	mv	a5,a0
ffffffe000201de4:	fec42703          	lw	a4,-20(s0)
ffffffe000201de8:	00f707bb          	addw	a5,a4,a5
ffffffe000201dec:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201df0:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201df4:	1b80006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
ffffffe000201df8:	f5043783          	ld	a5,-176(s0)
ffffffe000201dfc:	0007c783          	lbu	a5,0(a5)
ffffffe000201e00:	00078713          	mv	a4,a5
ffffffe000201e04:	06e00793          	li	a5,110
ffffffe000201e08:	04f71c63          	bne	a4,a5,ffffffe000201e60 <vprintfmt+0x670>
                if (flags.longflag) {
ffffffe000201e0c:	f8144783          	lbu	a5,-127(s0)
ffffffe000201e10:	02078463          	beqz	a5,ffffffe000201e38 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
ffffffe000201e14:	f4843783          	ld	a5,-184(s0)
ffffffe000201e18:	00878713          	addi	a4,a5,8
ffffffe000201e1c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e20:	0007b783          	ld	a5,0(a5)
ffffffe000201e24:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe000201e28:	fec42703          	lw	a4,-20(s0)
ffffffe000201e2c:	fb043783          	ld	a5,-80(s0)
ffffffe000201e30:	00e7b023          	sd	a4,0(a5)
ffffffe000201e34:	0240006f          	j	ffffffe000201e58 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe000201e38:	f4843783          	ld	a5,-184(s0)
ffffffe000201e3c:	00878713          	addi	a4,a5,8
ffffffe000201e40:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e44:	0007b783          	ld	a5,0(a5)
ffffffe000201e48:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000201e4c:	fb843783          	ld	a5,-72(s0)
ffffffe000201e50:	fec42703          	lw	a4,-20(s0)
ffffffe000201e54:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe000201e58:	f8040023          	sb	zero,-128(s0)
ffffffe000201e5c:	1500006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
ffffffe000201e60:	f5043783          	ld	a5,-176(s0)
ffffffe000201e64:	0007c783          	lbu	a5,0(a5)
ffffffe000201e68:	00078713          	mv	a4,a5
ffffffe000201e6c:	07300793          	li	a5,115
ffffffe000201e70:	02f71e63          	bne	a4,a5,ffffffe000201eac <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
ffffffe000201e74:	f4843783          	ld	a5,-184(s0)
ffffffe000201e78:	00878713          	addi	a4,a5,8
ffffffe000201e7c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e80:	0007b783          	ld	a5,0(a5)
ffffffe000201e84:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe000201e88:	fc043583          	ld	a1,-64(s0)
ffffffe000201e8c:	f5843503          	ld	a0,-168(s0)
ffffffe000201e90:	da8ff0ef          	jal	ffffffe000201438 <puts_wo_nl>
ffffffe000201e94:	00050793          	mv	a5,a0
ffffffe000201e98:	fec42703          	lw	a4,-20(s0)
ffffffe000201e9c:	00f707bb          	addw	a5,a4,a5
ffffffe000201ea0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201ea4:	f8040023          	sb	zero,-128(s0)
ffffffe000201ea8:	1040006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
ffffffe000201eac:	f5043783          	ld	a5,-176(s0)
ffffffe000201eb0:	0007c783          	lbu	a5,0(a5)
ffffffe000201eb4:	00078713          	mv	a4,a5
ffffffe000201eb8:	06300793          	li	a5,99
ffffffe000201ebc:	02f71e63          	bne	a4,a5,ffffffe000201ef8 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
ffffffe000201ec0:	f4843783          	ld	a5,-184(s0)
ffffffe000201ec4:	00878713          	addi	a4,a5,8
ffffffe000201ec8:	f4e43423          	sd	a4,-184(s0)
ffffffe000201ecc:	0007a783          	lw	a5,0(a5)
ffffffe000201ed0:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000201ed4:	fcc42703          	lw	a4,-52(s0)
ffffffe000201ed8:	f5843783          	ld	a5,-168(s0)
ffffffe000201edc:	00070513          	mv	a0,a4
ffffffe000201ee0:	000780e7          	jalr	a5
                ++written;
ffffffe000201ee4:	fec42783          	lw	a5,-20(s0)
ffffffe000201ee8:	0017879b          	addiw	a5,a5,1
ffffffe000201eec:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201ef0:	f8040023          	sb	zero,-128(s0)
ffffffe000201ef4:	0b80006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
ffffffe000201ef8:	f5043783          	ld	a5,-176(s0)
ffffffe000201efc:	0007c783          	lbu	a5,0(a5)
ffffffe000201f00:	00078713          	mv	a4,a5
ffffffe000201f04:	02500793          	li	a5,37
ffffffe000201f08:	02f71263          	bne	a4,a5,ffffffe000201f2c <vprintfmt+0x73c>
                putch('%');
ffffffe000201f0c:	f5843783          	ld	a5,-168(s0)
ffffffe000201f10:	02500513          	li	a0,37
ffffffe000201f14:	000780e7          	jalr	a5
                ++written;
ffffffe000201f18:	fec42783          	lw	a5,-20(s0)
ffffffe000201f1c:	0017879b          	addiw	a5,a5,1
ffffffe000201f20:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201f24:	f8040023          	sb	zero,-128(s0)
ffffffe000201f28:	0840006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
ffffffe000201f2c:	f5043783          	ld	a5,-176(s0)
ffffffe000201f30:	0007c783          	lbu	a5,0(a5)
ffffffe000201f34:	0007871b          	sext.w	a4,a5
ffffffe000201f38:	f5843783          	ld	a5,-168(s0)
ffffffe000201f3c:	00070513          	mv	a0,a4
ffffffe000201f40:	000780e7          	jalr	a5
                ++written;
ffffffe000201f44:	fec42783          	lw	a5,-20(s0)
ffffffe000201f48:	0017879b          	addiw	a5,a5,1
ffffffe000201f4c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201f50:	f8040023          	sb	zero,-128(s0)
ffffffe000201f54:	0580006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
ffffffe000201f58:	f5043783          	ld	a5,-176(s0)
ffffffe000201f5c:	0007c783          	lbu	a5,0(a5)
ffffffe000201f60:	00078713          	mv	a4,a5
ffffffe000201f64:	02500793          	li	a5,37
ffffffe000201f68:	02f71063          	bne	a4,a5,ffffffe000201f88 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe000201f6c:	f8043023          	sd	zero,-128(s0)
ffffffe000201f70:	f8043423          	sd	zero,-120(s0)
ffffffe000201f74:	00100793          	li	a5,1
ffffffe000201f78:	f8f40023          	sb	a5,-128(s0)
ffffffe000201f7c:	fff00793          	li	a5,-1
ffffffe000201f80:	f8f42623          	sw	a5,-116(s0)
ffffffe000201f84:	0280006f          	j	ffffffe000201fac <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
ffffffe000201f88:	f5043783          	ld	a5,-176(s0)
ffffffe000201f8c:	0007c783          	lbu	a5,0(a5)
ffffffe000201f90:	0007871b          	sext.w	a4,a5
ffffffe000201f94:	f5843783          	ld	a5,-168(s0)
ffffffe000201f98:	00070513          	mv	a0,a4
ffffffe000201f9c:	000780e7          	jalr	a5
            ++written;
ffffffe000201fa0:	fec42783          	lw	a5,-20(s0)
ffffffe000201fa4:	0017879b          	addiw	a5,a5,1
ffffffe000201fa8:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe000201fac:	f5043783          	ld	a5,-176(s0)
ffffffe000201fb0:	00178793          	addi	a5,a5,1
ffffffe000201fb4:	f4f43823          	sd	a5,-176(s0)
ffffffe000201fb8:	f5043783          	ld	a5,-176(s0)
ffffffe000201fbc:	0007c783          	lbu	a5,0(a5)
ffffffe000201fc0:	84079ee3          	bnez	a5,ffffffe00020181c <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000201fc4:	fec42783          	lw	a5,-20(s0)
}
ffffffe000201fc8:	00078513          	mv	a0,a5
ffffffe000201fcc:	0b813083          	ld	ra,184(sp)
ffffffe000201fd0:	0b013403          	ld	s0,176(sp)
ffffffe000201fd4:	0c010113          	addi	sp,sp,192
ffffffe000201fd8:	00008067          	ret

ffffffe000201fdc <printk>:

int printk(const char* s, ...) {
ffffffe000201fdc:	f9010113          	addi	sp,sp,-112
ffffffe000201fe0:	02113423          	sd	ra,40(sp)
ffffffe000201fe4:	02813023          	sd	s0,32(sp)
ffffffe000201fe8:	03010413          	addi	s0,sp,48
ffffffe000201fec:	fca43c23          	sd	a0,-40(s0)
ffffffe000201ff0:	00b43423          	sd	a1,8(s0)
ffffffe000201ff4:	00c43823          	sd	a2,16(s0)
ffffffe000201ff8:	00d43c23          	sd	a3,24(s0)
ffffffe000201ffc:	02e43023          	sd	a4,32(s0)
ffffffe000202000:	02f43423          	sd	a5,40(s0)
ffffffe000202004:	03043823          	sd	a6,48(s0)
ffffffe000202008:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe00020200c:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe000202010:	04040793          	addi	a5,s0,64
ffffffe000202014:	fcf43823          	sd	a5,-48(s0)
ffffffe000202018:	fd043783          	ld	a5,-48(s0)
ffffffe00020201c:	fc878793          	addi	a5,a5,-56
ffffffe000202020:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000202024:	fe043783          	ld	a5,-32(s0)
ffffffe000202028:	00078613          	mv	a2,a5
ffffffe00020202c:	fd843583          	ld	a1,-40(s0)
ffffffe000202030:	fffff517          	auipc	a0,0xfffff
ffffffe000202034:	0ec50513          	addi	a0,a0,236 # ffffffe00020111c <putc>
ffffffe000202038:	fb8ff0ef          	jal	ffffffe0002017f0 <vprintfmt>
ffffffe00020203c:	00050793          	mv	a5,a0
ffffffe000202040:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000202044:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202048:	00078513          	mv	a0,a5
ffffffe00020204c:	02813083          	ld	ra,40(sp)
ffffffe000202050:	02013403          	ld	s0,32(sp)
ffffffe000202054:	07010113          	addi	sp,sp,112
ffffffe000202058:	00008067          	ret

ffffffe00020205c <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe00020205c:	fe010113          	addi	sp,sp,-32
ffffffe000202060:	00113c23          	sd	ra,24(sp)
ffffffe000202064:	00813823          	sd	s0,16(sp)
ffffffe000202068:	02010413          	addi	s0,sp,32
ffffffe00020206c:	00050793          	mv	a5,a0
ffffffe000202070:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe000202074:	fec42783          	lw	a5,-20(s0)
ffffffe000202078:	fff7879b          	addiw	a5,a5,-1
ffffffe00020207c:	0007879b          	sext.w	a5,a5
ffffffe000202080:	02079713          	slli	a4,a5,0x20
ffffffe000202084:	02075713          	srli	a4,a4,0x20
ffffffe000202088:	00004797          	auipc	a5,0x4
ffffffe00020208c:	f9078793          	addi	a5,a5,-112 # ffffffe000206018 <seed>
ffffffe000202090:	00e7b023          	sd	a4,0(a5)
}
ffffffe000202094:	00000013          	nop
ffffffe000202098:	01813083          	ld	ra,24(sp)
ffffffe00020209c:	01013403          	ld	s0,16(sp)
ffffffe0002020a0:	02010113          	addi	sp,sp,32
ffffffe0002020a4:	00008067          	ret

ffffffe0002020a8 <rand>:

int rand(void) {
ffffffe0002020a8:	ff010113          	addi	sp,sp,-16
ffffffe0002020ac:	00113423          	sd	ra,8(sp)
ffffffe0002020b0:	00813023          	sd	s0,0(sp)
ffffffe0002020b4:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe0002020b8:	00004797          	auipc	a5,0x4
ffffffe0002020bc:	f6078793          	addi	a5,a5,-160 # ffffffe000206018 <seed>
ffffffe0002020c0:	0007b703          	ld	a4,0(a5)
ffffffe0002020c4:	00001797          	auipc	a5,0x1
ffffffe0002020c8:	1dc78793          	addi	a5,a5,476 # ffffffe0002032a0 <lowerxdigits.0+0x18>
ffffffe0002020cc:	0007b783          	ld	a5,0(a5)
ffffffe0002020d0:	02f707b3          	mul	a5,a4,a5
ffffffe0002020d4:	00178713          	addi	a4,a5,1
ffffffe0002020d8:	00004797          	auipc	a5,0x4
ffffffe0002020dc:	f4078793          	addi	a5,a5,-192 # ffffffe000206018 <seed>
ffffffe0002020e0:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe0002020e4:	00004797          	auipc	a5,0x4
ffffffe0002020e8:	f3478793          	addi	a5,a5,-204 # ffffffe000206018 <seed>
ffffffe0002020ec:	0007b783          	ld	a5,0(a5)
ffffffe0002020f0:	0217d793          	srli	a5,a5,0x21
ffffffe0002020f4:	0007879b          	sext.w	a5,a5
}
ffffffe0002020f8:	00078513          	mv	a0,a5
ffffffe0002020fc:	00813083          	ld	ra,8(sp)
ffffffe000202100:	00013403          	ld	s0,0(sp)
ffffffe000202104:	01010113          	addi	sp,sp,16
ffffffe000202108:	00008067          	ret

ffffffe00020210c <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe00020210c:	fc010113          	addi	sp,sp,-64
ffffffe000202110:	02113c23          	sd	ra,56(sp)
ffffffe000202114:	02813823          	sd	s0,48(sp)
ffffffe000202118:	04010413          	addi	s0,sp,64
ffffffe00020211c:	fca43c23          	sd	a0,-40(s0)
ffffffe000202120:	00058793          	mv	a5,a1
ffffffe000202124:	fcc43423          	sd	a2,-56(s0)
ffffffe000202128:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe00020212c:	fd843783          	ld	a5,-40(s0)
ffffffe000202130:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202134:	fe043423          	sd	zero,-24(s0)
ffffffe000202138:	0280006f          	j	ffffffe000202160 <memset+0x54>
        s[i] = c;
ffffffe00020213c:	fe043703          	ld	a4,-32(s0)
ffffffe000202140:	fe843783          	ld	a5,-24(s0)
ffffffe000202144:	00f707b3          	add	a5,a4,a5
ffffffe000202148:	fd442703          	lw	a4,-44(s0)
ffffffe00020214c:	0ff77713          	zext.b	a4,a4
ffffffe000202150:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202154:	fe843783          	ld	a5,-24(s0)
ffffffe000202158:	00178793          	addi	a5,a5,1
ffffffe00020215c:	fef43423          	sd	a5,-24(s0)
ffffffe000202160:	fe843703          	ld	a4,-24(s0)
ffffffe000202164:	fc843783          	ld	a5,-56(s0)
ffffffe000202168:	fcf76ae3          	bltu	a4,a5,ffffffe00020213c <memset+0x30>
    }
    return dest;
ffffffe00020216c:	fd843783          	ld	a5,-40(s0)
}
ffffffe000202170:	00078513          	mv	a0,a5
ffffffe000202174:	03813083          	ld	ra,56(sp)
ffffffe000202178:	03013403          	ld	s0,48(sp)
ffffffe00020217c:	04010113          	addi	sp,sp,64
ffffffe000202180:	00008067          	ret
