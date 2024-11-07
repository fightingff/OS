
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
ffffffe000200008:	785000ef          	jal	ffffffe000200f8c <setup_vm>
    call relocate
ffffffe00020000c:	030000ef          	jal	ffffffe00020003c <relocate>
    
    call mm_init
ffffffe000200010:	440000ef          	jal	ffffffe000200450 <mm_init>
    call task_init
ffffffe000200014:	48c000ef          	jal	ffffffe0002004a0 <task_init>

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
ffffffe000200038:	048010ef          	jal	ffffffe000201080 <start_kernel>

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
ffffffe000200110:	615000ef          	jal	ffffffe000200f24 <trap_handler>
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
ffffffe0002001a8:	53428293          	addi	t0,t0,1332 # ffffffe0002006d8 <dummy>
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
ffffffe000200290:	2e1000ef          	jal	ffffffe000200d70 <sbi_set_timer>
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
ffffffe0002002e8:	675010ef          	jal	ffffffe00020215c <memset>
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

    LOG(RED "kfree(addr: %p)\n" CLEAR, addr);
ffffffe000200318:	fd843783          	ld	a5,-40(s0)
ffffffe00020031c:	00078713          	mv	a4,a5
ffffffe000200320:	00003697          	auipc	a3,0x3
ffffffe000200324:	ce068693          	addi	a3,a3,-800 # ffffffe000203000 <__func__.1>
ffffffe000200328:	01900613          	li	a2,25
ffffffe00020032c:	00003597          	auipc	a1,0x3
ffffffe000200330:	ce458593          	addi	a1,a1,-796 # ffffffe000203010 <__func__.3+0x8>
ffffffe000200334:	00003517          	auipc	a0,0x3
ffffffe000200338:	ce450513          	addi	a0,a0,-796 # ffffffe000203018 <__func__.3+0x10>
ffffffe00020033c:	4f1010ef          	jal	ffffffe00020202c <printk>

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe000200340:	fd843783          	ld	a5,-40(s0)
ffffffe000200344:	00078693          	mv	a3,a5
ffffffe000200348:	fd840793          	addi	a5,s0,-40
ffffffe00020034c:	fffff737          	lui	a4,0xfffff
ffffffe000200350:	00e6f733          	and	a4,a3,a4
ffffffe000200354:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe000200358:	fd843783          	ld	a5,-40(s0)
ffffffe00020035c:	00001637          	lui	a2,0x1
ffffffe000200360:	00000593          	li	a1,0
ffffffe000200364:	00078513          	mv	a0,a5
ffffffe000200368:	5f5010ef          	jal	ffffffe00020215c <memset>

    r = (struct run *)addr;
ffffffe00020036c:	fd843783          	ld	a5,-40(s0)
ffffffe000200370:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe000200374:	00006797          	auipc	a5,0x6
ffffffe000200378:	c8c78793          	addi	a5,a5,-884 # ffffffe000206000 <kmem>
ffffffe00020037c:	0007b703          	ld	a4,0(a5)
ffffffe000200380:	fe843783          	ld	a5,-24(s0)
ffffffe000200384:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe000200388:	00006797          	auipc	a5,0x6
ffffffe00020038c:	c7878793          	addi	a5,a5,-904 # ffffffe000206000 <kmem>
ffffffe000200390:	fe843703          	ld	a4,-24(s0)
ffffffe000200394:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe000200398:	00000013          	nop
}
ffffffe00020039c:	02813083          	ld	ra,40(sp)
ffffffe0002003a0:	02013403          	ld	s0,32(sp)
ffffffe0002003a4:	03010113          	addi	sp,sp,48
ffffffe0002003a8:	00008067          	ret

ffffffe0002003ac <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe0002003ac:	fd010113          	addi	sp,sp,-48
ffffffe0002003b0:	02113423          	sd	ra,40(sp)
ffffffe0002003b4:	02813023          	sd	s0,32(sp)
ffffffe0002003b8:	03010413          	addi	s0,sp,48
ffffffe0002003bc:	fca43c23          	sd	a0,-40(s0)
ffffffe0002003c0:	fcb43823          	sd	a1,-48(s0)
    LOG(RED "kfreerange(start: %p, end: %p)\n" CLEAR, start, end);
ffffffe0002003c4:	fd043783          	ld	a5,-48(s0)
ffffffe0002003c8:	fd843703          	ld	a4,-40(s0)
ffffffe0002003cc:	00003697          	auipc	a3,0x3
ffffffe0002003d0:	cf468693          	addi	a3,a3,-780 # ffffffe0002030c0 <__func__.0>
ffffffe0002003d4:	02800613          	li	a2,40
ffffffe0002003d8:	00003597          	auipc	a1,0x3
ffffffe0002003dc:	c3858593          	addi	a1,a1,-968 # ffffffe000203010 <__func__.3+0x8>
ffffffe0002003e0:	00003517          	auipc	a0,0x3
ffffffe0002003e4:	c7050513          	addi	a0,a0,-912 # ffffffe000203050 <__func__.3+0x48>
ffffffe0002003e8:	445010ef          	jal	ffffffe00020202c <printk>
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe0002003ec:	fd843703          	ld	a4,-40(s0)
ffffffe0002003f0:	000017b7          	lui	a5,0x1
ffffffe0002003f4:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003f8:	00f70733          	add	a4,a4,a5
ffffffe0002003fc:	fffff7b7          	lui	a5,0xfffff
ffffffe000200400:	00f777b3          	and	a5,a4,a5
ffffffe000200404:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe000200408:	01c0006f          	j	ffffffe000200424 <kfreerange+0x78>
        kfree((void *)addr);
ffffffe00020040c:	fe843503          	ld	a0,-24(s0)
ffffffe000200410:	ef5ff0ef          	jal	ffffffe000200304 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe000200414:	fe843703          	ld	a4,-24(s0)
ffffffe000200418:	000017b7          	lui	a5,0x1
ffffffe00020041c:	00f707b3          	add	a5,a4,a5
ffffffe000200420:	fef43423          	sd	a5,-24(s0)
ffffffe000200424:	fe843703          	ld	a4,-24(s0)
ffffffe000200428:	000017b7          	lui	a5,0x1
ffffffe00020042c:	00f70733          	add	a4,a4,a5
ffffffe000200430:	fd043783          	ld	a5,-48(s0)
ffffffe000200434:	fce7fce3          	bgeu	a5,a4,ffffffe00020040c <kfreerange+0x60>
    }
}
ffffffe000200438:	00000013          	nop
ffffffe00020043c:	00000013          	nop
ffffffe000200440:	02813083          	ld	ra,40(sp)
ffffffe000200444:	02013403          	ld	s0,32(sp)
ffffffe000200448:	03010113          	addi	sp,sp,48
ffffffe00020044c:	00008067          	ret

ffffffe000200450 <mm_init>:

void mm_init(void) {
ffffffe000200450:	ff010113          	addi	sp,sp,-16
ffffffe000200454:	00113423          	sd	ra,8(sp)
ffffffe000200458:	00813023          	sd	s0,0(sp)
ffffffe00020045c:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200460:	00003517          	auipc	a0,0x3
ffffffe000200464:	c3050513          	addi	a0,a0,-976 # ffffffe000203090 <__func__.3+0x88>
ffffffe000200468:	3c5010ef          	jal	ffffffe00020202c <printk>
    kfreerange(_ekernel, (char *)(PHY_END + PA2VA_OFFSET));
ffffffe00020046c:	c0100793          	li	a5,-1023
ffffffe000200470:	01b79593          	slli	a1,a5,0x1b
ffffffe000200474:	00008517          	auipc	a0,0x8
ffffffe000200478:	b8c50513          	addi	a0,a0,-1140 # ffffffe000208000 <_ebss>
ffffffe00020047c:	f31ff0ef          	jal	ffffffe0002003ac <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200480:	00003517          	auipc	a0,0x3
ffffffe000200484:	c2850513          	addi	a0,a0,-984 # ffffffe0002030a8 <__func__.3+0xa0>
ffffffe000200488:	3a5010ef          	jal	ffffffe00020202c <printk>
}
ffffffe00020048c:	00000013          	nop
ffffffe000200490:	00813083          	ld	ra,8(sp)
ffffffe000200494:	00013403          	ld	s0,0(sp)
ffffffe000200498:	01010113          	addi	sp,sp,16
ffffffe00020049c:	00008067          	ret

ffffffe0002004a0 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe0002004a0:	fe010113          	addi	sp,sp,-32
ffffffe0002004a4:	00113c23          	sd	ra,24(sp)
ffffffe0002004a8:	00813823          	sd	s0,16(sp)
ffffffe0002004ac:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe0002004b0:	7e800513          	li	a0,2024
ffffffe0002004b4:	3f9010ef          	jal	ffffffe0002020ac <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe0002004b8:	df1ff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe0002004bc:	00050713          	mv	a4,a0
ffffffe0002004c0:	00006797          	auipc	a5,0x6
ffffffe0002004c4:	b4878793          	addi	a5,a5,-1208 # ffffffe000206008 <idle>
ffffffe0002004c8:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe0002004cc:	00006797          	auipc	a5,0x6
ffffffe0002004d0:	b3c78793          	addi	a5,a5,-1220 # ffffffe000206008 <idle>
ffffffe0002004d4:	0007b783          	ld	a5,0(a5)
ffffffe0002004d8:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe0002004dc:	00006797          	auipc	a5,0x6
ffffffe0002004e0:	b2c78793          	addi	a5,a5,-1236 # ffffffe000206008 <idle>
ffffffe0002004e4:	0007b783          	ld	a5,0(a5)
ffffffe0002004e8:	0007b823          	sd	zero,16(a5)
ffffffe0002004ec:	00006717          	auipc	a4,0x6
ffffffe0002004f0:	b1c70713          	addi	a4,a4,-1252 # ffffffe000206008 <idle>
ffffffe0002004f4:	00073703          	ld	a4,0(a4)
ffffffe0002004f8:	0107b783          	ld	a5,16(a5)
ffffffe0002004fc:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe000200500:	00006797          	auipc	a5,0x6
ffffffe000200504:	b0878793          	addi	a5,a5,-1272 # ffffffe000206008 <idle>
ffffffe000200508:	0007b783          	ld	a5,0(a5)
ffffffe00020050c:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe000200510:	00006797          	auipc	a5,0x6
ffffffe000200514:	af878793          	addi	a5,a5,-1288 # ffffffe000206008 <idle>
ffffffe000200518:	0007b703          	ld	a4,0(a5)
ffffffe00020051c:	00006797          	auipc	a5,0x6
ffffffe000200520:	b0478793          	addi	a5,a5,-1276 # ffffffe000206020 <task>
ffffffe000200524:	00e7b023          	sd	a4,0(a5)
ffffffe000200528:	00006797          	auipc	a5,0x6
ffffffe00020052c:	af878793          	addi	a5,a5,-1288 # ffffffe000206020 <task>
ffffffe000200530:	0007b703          	ld	a4,0(a5)
ffffffe000200534:	00006797          	auipc	a5,0x6
ffffffe000200538:	adc78793          	addi	a5,a5,-1316 # ffffffe000206010 <current>
ffffffe00020053c:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200540:	00100793          	li	a5,1
ffffffe000200544:	fef42623          	sw	a5,-20(s0)
ffffffe000200548:	1600006f          	j	ffffffe0002006a8 <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
ffffffe00020054c:	d5dff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe000200550:	00050693          	mv	a3,a0
ffffffe000200554:	00006717          	auipc	a4,0x6
ffffffe000200558:	acc70713          	addi	a4,a4,-1332 # ffffffe000206020 <task>
ffffffe00020055c:	fec42783          	lw	a5,-20(s0)
ffffffe000200560:	00379793          	slli	a5,a5,0x3
ffffffe000200564:	00f707b3          	add	a5,a4,a5
ffffffe000200568:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe00020056c:	00006717          	auipc	a4,0x6
ffffffe000200570:	ab470713          	addi	a4,a4,-1356 # ffffffe000206020 <task>
ffffffe000200574:	fec42783          	lw	a5,-20(s0)
ffffffe000200578:	00379793          	slli	a5,a5,0x3
ffffffe00020057c:	00f707b3          	add	a5,a4,a5
ffffffe000200580:	0007b783          	ld	a5,0(a5)
ffffffe000200584:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe000200588:	00006717          	auipc	a4,0x6
ffffffe00020058c:	a9870713          	addi	a4,a4,-1384 # ffffffe000206020 <task>
ffffffe000200590:	fec42783          	lw	a5,-20(s0)
ffffffe000200594:	00379793          	slli	a5,a5,0x3
ffffffe000200598:	00f707b3          	add	a5,a4,a5
ffffffe00020059c:	0007b783          	ld	a5,0(a5)
ffffffe0002005a0:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe0002005a4:	355010ef          	jal	ffffffe0002020f8 <rand>
ffffffe0002005a8:	00050793          	mv	a5,a0
ffffffe0002005ac:	00078713          	mv	a4,a5
ffffffe0002005b0:	0007069b          	sext.w	a3,a4
ffffffe0002005b4:	666667b7          	lui	a5,0x66666
ffffffe0002005b8:	66778793          	addi	a5,a5,1639 # 66666667 <PHY_SIZE+0x5e666667>
ffffffe0002005bc:	02f687b3          	mul	a5,a3,a5
ffffffe0002005c0:	0207d793          	srli	a5,a5,0x20
ffffffe0002005c4:	4027d79b          	sraiw	a5,a5,0x2
ffffffe0002005c8:	00078693          	mv	a3,a5
ffffffe0002005cc:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe0002005d0:	40f687bb          	subw	a5,a3,a5
ffffffe0002005d4:	00078693          	mv	a3,a5
ffffffe0002005d8:	00068793          	mv	a5,a3
ffffffe0002005dc:	0027979b          	slliw	a5,a5,0x2
ffffffe0002005e0:	00d787bb          	addw	a5,a5,a3
ffffffe0002005e4:	0017979b          	slliw	a5,a5,0x1
ffffffe0002005e8:	40f707bb          	subw	a5,a4,a5
ffffffe0002005ec:	0007879b          	sext.w	a5,a5
ffffffe0002005f0:	0017879b          	addiw	a5,a5,1
ffffffe0002005f4:	0007869b          	sext.w	a3,a5
ffffffe0002005f8:	00006717          	auipc	a4,0x6
ffffffe0002005fc:	a2870713          	addi	a4,a4,-1496 # ffffffe000206020 <task>
ffffffe000200600:	fec42783          	lw	a5,-20(s0)
ffffffe000200604:	00379793          	slli	a5,a5,0x3
ffffffe000200608:	00f707b3          	add	a5,a4,a5
ffffffe00020060c:	0007b783          	ld	a5,0(a5)
ffffffe000200610:	00068713          	mv	a4,a3
ffffffe000200614:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe000200618:	00006717          	auipc	a4,0x6
ffffffe00020061c:	a0870713          	addi	a4,a4,-1528 # ffffffe000206020 <task>
ffffffe000200620:	fec42783          	lw	a5,-20(s0)
ffffffe000200624:	00379793          	slli	a5,a5,0x3
ffffffe000200628:	00f707b3          	add	a5,a4,a5
ffffffe00020062c:	0007b783          	ld	a5,0(a5)
ffffffe000200630:	fec42703          	lw	a4,-20(s0)
ffffffe000200634:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe000200638:	00006717          	auipc	a4,0x6
ffffffe00020063c:	9e870713          	addi	a4,a4,-1560 # ffffffe000206020 <task>
ffffffe000200640:	fec42783          	lw	a5,-20(s0)
ffffffe000200644:	00379793          	slli	a5,a5,0x3
ffffffe000200648:	00f707b3          	add	a5,a4,a5
ffffffe00020064c:	0007b783          	ld	a5,0(a5)
ffffffe000200650:	00000717          	auipc	a4,0x0
ffffffe000200654:	b5470713          	addi	a4,a4,-1196 # ffffffe0002001a4 <__dummy>
ffffffe000200658:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe00020065c:	00006717          	auipc	a4,0x6
ffffffe000200660:	9c470713          	addi	a4,a4,-1596 # ffffffe000206020 <task>
ffffffe000200664:	fec42783          	lw	a5,-20(s0)
ffffffe000200668:	00379793          	slli	a5,a5,0x3
ffffffe00020066c:	00f707b3          	add	a5,a4,a5
ffffffe000200670:	0007b783          	ld	a5,0(a5)
ffffffe000200674:	00078693          	mv	a3,a5
ffffffe000200678:	00006717          	auipc	a4,0x6
ffffffe00020067c:	9a870713          	addi	a4,a4,-1624 # ffffffe000206020 <task>
ffffffe000200680:	fec42783          	lw	a5,-20(s0)
ffffffe000200684:	00379793          	slli	a5,a5,0x3
ffffffe000200688:	00f707b3          	add	a5,a4,a5
ffffffe00020068c:	0007b783          	ld	a5,0(a5)
ffffffe000200690:	00001737          	lui	a4,0x1
ffffffe000200694:	00e68733          	add	a4,a3,a4
ffffffe000200698:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe00020069c:	fec42783          	lw	a5,-20(s0)
ffffffe0002006a0:	0017879b          	addiw	a5,a5,1
ffffffe0002006a4:	fef42623          	sw	a5,-20(s0)
ffffffe0002006a8:	fec42783          	lw	a5,-20(s0)
ffffffe0002006ac:	0007871b          	sext.w	a4,a5
ffffffe0002006b0:	01f00793          	li	a5,31
ffffffe0002006b4:	e8e7dce3          	bge	a5,a4,ffffffe00020054c <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe0002006b8:	00003517          	auipc	a0,0x3
ffffffe0002006bc:	a1850513          	addi	a0,a0,-1512 # ffffffe0002030d0 <__func__.0+0x10>
ffffffe0002006c0:	16d010ef          	jal	ffffffe00020202c <printk>
}
ffffffe0002006c4:	00000013          	nop
ffffffe0002006c8:	01813083          	ld	ra,24(sp)
ffffffe0002006cc:	01013403          	ld	s0,16(sp)
ffffffe0002006d0:	02010113          	addi	sp,sp,32
ffffffe0002006d4:	00008067          	ret

ffffffe0002006d8 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe0002006d8:	fd010113          	addi	sp,sp,-48
ffffffe0002006dc:	02113423          	sd	ra,40(sp)
ffffffe0002006e0:	02813023          	sd	s0,32(sp)
ffffffe0002006e4:	03010413          	addi	s0,sp,48
    LOG(RED);
ffffffe0002006e8:	00003697          	auipc	a3,0x3
ffffffe0002006ec:	92068693          	addi	a3,a3,-1760 # ffffffe000203008 <__func__.3>
ffffffe0002006f0:	04100613          	li	a2,65
ffffffe0002006f4:	00003597          	auipc	a1,0x3
ffffffe0002006f8:	9f458593          	addi	a1,a1,-1548 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe0002006fc:	00003517          	auipc	a0,0x3
ffffffe000200700:	9f450513          	addi	a0,a0,-1548 # ffffffe0002030f0 <__func__.0+0x30>
ffffffe000200704:	129010ef          	jal	ffffffe00020202c <printk>
    uint64_t MOD = 1000000007;
ffffffe000200708:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe00020070c:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe000200710:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe000200714:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe000200718:	fff00793          	li	a5,-1
ffffffe00020071c:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000200720:	fe442783          	lw	a5,-28(s0)
ffffffe000200724:	0007871b          	sext.w	a4,a5
ffffffe000200728:	fff00793          	li	a5,-1
ffffffe00020072c:	00f70e63          	beq	a4,a5,ffffffe000200748 <dummy+0x70>
ffffffe000200730:	00006797          	auipc	a5,0x6
ffffffe000200734:	8e078793          	addi	a5,a5,-1824 # ffffffe000206010 <current>
ffffffe000200738:	0007b783          	ld	a5,0(a5)
ffffffe00020073c:	0087b703          	ld	a4,8(a5)
ffffffe000200740:	fe442783          	lw	a5,-28(s0)
ffffffe000200744:	fcf70ee3          	beq	a4,a5,ffffffe000200720 <dummy+0x48>
ffffffe000200748:	00006797          	auipc	a5,0x6
ffffffe00020074c:	8c878793          	addi	a5,a5,-1848 # ffffffe000206010 <current>
ffffffe000200750:	0007b783          	ld	a5,0(a5)
ffffffe000200754:	0087b783          	ld	a5,8(a5)
ffffffe000200758:	fc0784e3          	beqz	a5,ffffffe000200720 <dummy+0x48>
            if (current->counter == 1) {
ffffffe00020075c:	00006797          	auipc	a5,0x6
ffffffe000200760:	8b478793          	addi	a5,a5,-1868 # ffffffe000206010 <current>
ffffffe000200764:	0007b783          	ld	a5,0(a5)
ffffffe000200768:	0087b703          	ld	a4,8(a5)
ffffffe00020076c:	00100793          	li	a5,1
ffffffe000200770:	00f71e63          	bne	a4,a5,ffffffe00020078c <dummy+0xb4>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe000200774:	00006797          	auipc	a5,0x6
ffffffe000200778:	89c78793          	addi	a5,a5,-1892 # ffffffe000206010 <current>
ffffffe00020077c:	0007b783          	ld	a5,0(a5)
ffffffe000200780:	0087b703          	ld	a4,8(a5)
ffffffe000200784:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe000200788:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe00020078c:	00006797          	auipc	a5,0x6
ffffffe000200790:	88478793          	addi	a5,a5,-1916 # ffffffe000206010 <current>
ffffffe000200794:	0007b783          	ld	a5,0(a5)
ffffffe000200798:	0087b783          	ld	a5,8(a5)
ffffffe00020079c:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe0002007a0:	fe843783          	ld	a5,-24(s0)
ffffffe0002007a4:	00178713          	addi	a4,a5,1
ffffffe0002007a8:	fd843783          	ld	a5,-40(s0)
ffffffe0002007ac:	02f777b3          	remu	a5,a4,a5
ffffffe0002007b0:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe0002007b4:	00006797          	auipc	a5,0x6
ffffffe0002007b8:	85c78793          	addi	a5,a5,-1956 # ffffffe000206010 <current>
ffffffe0002007bc:	0007b783          	ld	a5,0(a5)
ffffffe0002007c0:	0187b783          	ld	a5,24(a5)
ffffffe0002007c4:	fe843603          	ld	a2,-24(s0)
ffffffe0002007c8:	00078593          	mv	a1,a5
ffffffe0002007cc:	00003517          	auipc	a0,0x3
ffffffe0002007d0:	94450513          	addi	a0,a0,-1724 # ffffffe000203110 <__func__.0+0x50>
ffffffe0002007d4:	059010ef          	jal	ffffffe00020202c <printk>
            LOG(RED "%llu\n", current->thread.ra);
ffffffe0002007d8:	00006797          	auipc	a5,0x6
ffffffe0002007dc:	83878793          	addi	a5,a5,-1992 # ffffffe000206010 <current>
ffffffe0002007e0:	0007b783          	ld	a5,0(a5)
ffffffe0002007e4:	0207b783          	ld	a5,32(a5)
ffffffe0002007e8:	00078713          	mv	a4,a5
ffffffe0002007ec:	00003697          	auipc	a3,0x3
ffffffe0002007f0:	81c68693          	addi	a3,a3,-2020 # ffffffe000203008 <__func__.3>
ffffffe0002007f4:	04d00613          	li	a2,77
ffffffe0002007f8:	00003597          	auipc	a1,0x3
ffffffe0002007fc:	8f058593          	addi	a1,a1,-1808 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe000200800:	00003517          	auipc	a0,0x3
ffffffe000200804:	94050513          	addi	a0,a0,-1728 # ffffffe000203140 <__func__.0+0x80>
ffffffe000200808:	025010ef          	jal	ffffffe00020202c <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe00020080c:	f15ff06f          	j	ffffffe000200720 <dummy+0x48>

ffffffe000200810 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe000200810:	fd010113          	addi	sp,sp,-48
ffffffe000200814:	02113423          	sd	ra,40(sp)
ffffffe000200818:	02813023          	sd	s0,32(sp)
ffffffe00020081c:	03010413          	addi	s0,sp,48
ffffffe000200820:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe000200824:	00003697          	auipc	a3,0x3
ffffffe000200828:	9fc68693          	addi	a3,a3,-1540 # ffffffe000203220 <__func__.2>
ffffffe00020082c:	06500613          	li	a2,101
ffffffe000200830:	00003597          	auipc	a1,0x3
ffffffe000200834:	8b858593          	addi	a1,a1,-1864 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe000200838:	00003517          	auipc	a0,0x3
ffffffe00020083c:	8b850513          	addi	a0,a0,-1864 # ffffffe0002030f0 <__func__.0+0x30>
ffffffe000200840:	7ec010ef          	jal	ffffffe00020202c <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe000200844:	00005797          	auipc	a5,0x5
ffffffe000200848:	7cc78793          	addi	a5,a5,1996 # ffffffe000206010 <current>
ffffffe00020084c:	0007b783          	ld	a5,0(a5)
ffffffe000200850:	0187b703          	ld	a4,24(a5)
ffffffe000200854:	fd843783          	ld	a5,-40(s0)
ffffffe000200858:	0187b783          	ld	a5,24(a5)
ffffffe00020085c:	00003697          	auipc	a3,0x3
ffffffe000200860:	9c468693          	addi	a3,a3,-1596 # ffffffe000203220 <__func__.2>
ffffffe000200864:	06600613          	li	a2,102
ffffffe000200868:	00003597          	auipc	a1,0x3
ffffffe00020086c:	88058593          	addi	a1,a1,-1920 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe000200870:	00003517          	auipc	a0,0x3
ffffffe000200874:	8f850513          	addi	a0,a0,-1800 # ffffffe000203168 <__func__.0+0xa8>
ffffffe000200878:	7b4010ef          	jal	ffffffe00020202c <printk>
    if(current->pid != next->pid) {
ffffffe00020087c:	00005797          	auipc	a5,0x5
ffffffe000200880:	79478793          	addi	a5,a5,1940 # ffffffe000206010 <current>
ffffffe000200884:	0007b783          	ld	a5,0(a5)
ffffffe000200888:	0187b703          	ld	a4,24(a5)
ffffffe00020088c:	fd843783          	ld	a5,-40(s0)
ffffffe000200890:	0187b783          	ld	a5,24(a5)
ffffffe000200894:	06f70a63          	beq	a4,a5,ffffffe000200908 <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe000200898:	00005797          	auipc	a5,0x5
ffffffe00020089c:	77878793          	addi	a5,a5,1912 # ffffffe000206010 <current>
ffffffe0002008a0:	0007b783          	ld	a5,0(a5)
ffffffe0002008a4:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe0002008a8:	00005797          	auipc	a5,0x5
ffffffe0002008ac:	76878793          	addi	a5,a5,1896 # ffffffe000206010 <current>
ffffffe0002008b0:	fd843703          	ld	a4,-40(s0)
ffffffe0002008b4:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe0002008b8:	00005797          	auipc	a5,0x5
ffffffe0002008bc:	75878793          	addi	a5,a5,1880 # ffffffe000206010 <current>
ffffffe0002008c0:	0007b783          	ld	a5,0(a5)
ffffffe0002008c4:	0187b703          	ld	a4,24(a5)
ffffffe0002008c8:	00005797          	auipc	a5,0x5
ffffffe0002008cc:	74878793          	addi	a5,a5,1864 # ffffffe000206010 <current>
ffffffe0002008d0:	0007b783          	ld	a5,0(a5)
ffffffe0002008d4:	0107b603          	ld	a2,16(a5)
ffffffe0002008d8:	00005797          	auipc	a5,0x5
ffffffe0002008dc:	73878793          	addi	a5,a5,1848 # ffffffe000206010 <current>
ffffffe0002008e0:	0007b783          	ld	a5,0(a5)
ffffffe0002008e4:	0087b783          	ld	a5,8(a5)
ffffffe0002008e8:	00078693          	mv	a3,a5
ffffffe0002008ec:	00070593          	mv	a1,a4
ffffffe0002008f0:	00003517          	auipc	a0,0x3
ffffffe0002008f4:	8b850513          	addi	a0,a0,-1864 # ffffffe0002031a8 <__func__.0+0xe8>
ffffffe0002008f8:	734010ef          	jal	ffffffe00020202c <printk>
        __switch_to(prev, next);
ffffffe0002008fc:	fd843583          	ld	a1,-40(s0)
ffffffe000200900:	fe843503          	ld	a0,-24(s0)
ffffffe000200904:	8b1ff0ef          	jal	ffffffe0002001b4 <__switch_to>
    }
}
ffffffe000200908:	00000013          	nop
ffffffe00020090c:	02813083          	ld	ra,40(sp)
ffffffe000200910:	02013403          	ld	s0,32(sp)
ffffffe000200914:	03010113          	addi	sp,sp,48
ffffffe000200918:	00008067          	ret

ffffffe00020091c <do_timer>:

void do_timer() {
ffffffe00020091c:	ff010113          	addi	sp,sp,-16
ffffffe000200920:	00113423          	sd	ra,8(sp)
ffffffe000200924:	00813023          	sd	s0,0(sp)
ffffffe000200928:	01010413          	addi	s0,sp,16
    LOG(RED);
ffffffe00020092c:	00003697          	auipc	a3,0x3
ffffffe000200930:	90468693          	addi	a3,a3,-1788 # ffffffe000203230 <__func__.1>
ffffffe000200934:	07000613          	li	a2,112
ffffffe000200938:	00002597          	auipc	a1,0x2
ffffffe00020093c:	7b058593          	addi	a1,a1,1968 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe000200940:	00002517          	auipc	a0,0x2
ffffffe000200944:	7b050513          	addi	a0,a0,1968 # ffffffe0002030f0 <__func__.0+0x30>
ffffffe000200948:	6e4010ef          	jal	ffffffe00020202c <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe00020094c:	00005797          	auipc	a5,0x5
ffffffe000200950:	6c478793          	addi	a5,a5,1732 # ffffffe000206010 <current>
ffffffe000200954:	0007b783          	ld	a5,0(a5)
ffffffe000200958:	0187b703          	ld	a4,24(a5)
ffffffe00020095c:	00005797          	auipc	a5,0x5
ffffffe000200960:	6ac78793          	addi	a5,a5,1708 # ffffffe000206008 <idle>
ffffffe000200964:	0007b783          	ld	a5,0(a5)
ffffffe000200968:	0187b783          	ld	a5,24(a5)
ffffffe00020096c:	00f70c63          	beq	a4,a5,ffffffe000200984 <do_timer+0x68>
ffffffe000200970:	00005797          	auipc	a5,0x5
ffffffe000200974:	6a078793          	addi	a5,a5,1696 # ffffffe000206010 <current>
ffffffe000200978:	0007b783          	ld	a5,0(a5)
ffffffe00020097c:	0087b783          	ld	a5,8(a5)
ffffffe000200980:	00079663          	bnez	a5,ffffffe00020098c <do_timer+0x70>
        schedule();
ffffffe000200984:	038000ef          	jal	ffffffe0002009bc <schedule>
ffffffe000200988:	0200006f          	j	ffffffe0002009a8 <do_timer+0x8c>
    }
    else --(current->counter);
ffffffe00020098c:	00005797          	auipc	a5,0x5
ffffffe000200990:	68478793          	addi	a5,a5,1668 # ffffffe000206010 <current>
ffffffe000200994:	0007b783          	ld	a5,0(a5)
ffffffe000200998:	0087b703          	ld	a4,8(a5)
ffffffe00020099c:	fff70713          	addi	a4,a4,-1
ffffffe0002009a0:	00e7b423          	sd	a4,8(a5)
}
ffffffe0002009a4:	00000013          	nop
ffffffe0002009a8:	00000013          	nop
ffffffe0002009ac:	00813083          	ld	ra,8(sp)
ffffffe0002009b0:	00013403          	ld	s0,0(sp)
ffffffe0002009b4:	01010113          	addi	sp,sp,16
ffffffe0002009b8:	00008067          	ret

ffffffe0002009bc <schedule>:

void schedule() {
ffffffe0002009bc:	fe010113          	addi	sp,sp,-32
ffffffe0002009c0:	00113c23          	sd	ra,24(sp)
ffffffe0002009c4:	00813823          	sd	s0,16(sp)
ffffffe0002009c8:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    LOG(RED);
ffffffe0002009cc:	00003697          	auipc	a3,0x3
ffffffe0002009d0:	87468693          	addi	a3,a3,-1932 # ffffffe000203240 <__func__.0>
ffffffe0002009d4:	07f00613          	li	a2,127
ffffffe0002009d8:	00002597          	auipc	a1,0x2
ffffffe0002009dc:	71058593          	addi	a1,a1,1808 # ffffffe0002030e8 <__func__.0+0x28>
ffffffe0002009e0:	00002517          	auipc	a0,0x2
ffffffe0002009e4:	71050513          	addi	a0,a0,1808 # ffffffe0002030f0 <__func__.0+0x30>
ffffffe0002009e8:	644010ef          	jal	ffffffe00020202c <printk>
    struct task_struct *next = idle;
ffffffe0002009ec:	00005797          	auipc	a5,0x5
ffffffe0002009f0:	61c78793          	addi	a5,a5,1564 # ffffffe000206008 <idle>
ffffffe0002009f4:	0007b783          	ld	a5,0(a5)
ffffffe0002009f8:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009fc:	00100793          	li	a5,1
ffffffe000200a00:	fef42223          	sw	a5,-28(s0)
ffffffe000200a04:	0540006f          	j	ffffffe000200a58 <schedule+0x9c>
        if(task[i]->counter > next->counter){
ffffffe000200a08:	00005717          	auipc	a4,0x5
ffffffe000200a0c:	61870713          	addi	a4,a4,1560 # ffffffe000206020 <task>
ffffffe000200a10:	fe442783          	lw	a5,-28(s0)
ffffffe000200a14:	00379793          	slli	a5,a5,0x3
ffffffe000200a18:	00f707b3          	add	a5,a4,a5
ffffffe000200a1c:	0007b783          	ld	a5,0(a5)
ffffffe000200a20:	0087b703          	ld	a4,8(a5)
ffffffe000200a24:	fe843783          	ld	a5,-24(s0)
ffffffe000200a28:	0087b783          	ld	a5,8(a5)
ffffffe000200a2c:	02e7f063          	bgeu	a5,a4,ffffffe000200a4c <schedule+0x90>
            next = task[i];
ffffffe000200a30:	00005717          	auipc	a4,0x5
ffffffe000200a34:	5f070713          	addi	a4,a4,1520 # ffffffe000206020 <task>
ffffffe000200a38:	fe442783          	lw	a5,-28(s0)
ffffffe000200a3c:	00379793          	slli	a5,a5,0x3
ffffffe000200a40:	00f707b3          	add	a5,a4,a5
ffffffe000200a44:	0007b783          	ld	a5,0(a5)
ffffffe000200a48:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a4c:	fe442783          	lw	a5,-28(s0)
ffffffe000200a50:	0017879b          	addiw	a5,a5,1
ffffffe000200a54:	fef42223          	sw	a5,-28(s0)
ffffffe000200a58:	fe442783          	lw	a5,-28(s0)
ffffffe000200a5c:	0007871b          	sext.w	a4,a5
ffffffe000200a60:	01f00793          	li	a5,31
ffffffe000200a64:	fae7d2e3          	bge	a5,a4,ffffffe000200a08 <schedule+0x4c>
        }
    }

    if(next->counter == 0) {
ffffffe000200a68:	fe843783          	ld	a5,-24(s0)
ffffffe000200a6c:	0087b783          	ld	a5,8(a5)
ffffffe000200a70:	0c079e63          	bnez	a5,ffffffe000200b4c <schedule+0x190>
        printk("\n");
ffffffe000200a74:	00002517          	auipc	a0,0x2
ffffffe000200a78:	76c50513          	addi	a0,a0,1900 # ffffffe0002031e0 <__func__.0+0x120>
ffffffe000200a7c:	5b0010ef          	jal	ffffffe00020202c <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a80:	00100793          	li	a5,1
ffffffe000200a84:	fef42023          	sw	a5,-32(s0)
ffffffe000200a88:	0ac0006f          	j	ffffffe000200b34 <schedule+0x178>
            task[i]->counter = task[i]->priority;
ffffffe000200a8c:	00005717          	auipc	a4,0x5
ffffffe000200a90:	59470713          	addi	a4,a4,1428 # ffffffe000206020 <task>
ffffffe000200a94:	fe042783          	lw	a5,-32(s0)
ffffffe000200a98:	00379793          	slli	a5,a5,0x3
ffffffe000200a9c:	00f707b3          	add	a5,a4,a5
ffffffe000200aa0:	0007b703          	ld	a4,0(a5)
ffffffe000200aa4:	00005697          	auipc	a3,0x5
ffffffe000200aa8:	57c68693          	addi	a3,a3,1404 # ffffffe000206020 <task>
ffffffe000200aac:	fe042783          	lw	a5,-32(s0)
ffffffe000200ab0:	00379793          	slli	a5,a5,0x3
ffffffe000200ab4:	00f687b3          	add	a5,a3,a5
ffffffe000200ab8:	0007b783          	ld	a5,0(a5)
ffffffe000200abc:	01073703          	ld	a4,16(a4)
ffffffe000200ac0:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200ac4:	00005717          	auipc	a4,0x5
ffffffe000200ac8:	55c70713          	addi	a4,a4,1372 # ffffffe000206020 <task>
ffffffe000200acc:	fe042783          	lw	a5,-32(s0)
ffffffe000200ad0:	00379793          	slli	a5,a5,0x3
ffffffe000200ad4:	00f707b3          	add	a5,a4,a5
ffffffe000200ad8:	0007b783          	ld	a5,0(a5)
ffffffe000200adc:	0187b583          	ld	a1,24(a5)
ffffffe000200ae0:	00005717          	auipc	a4,0x5
ffffffe000200ae4:	54070713          	addi	a4,a4,1344 # ffffffe000206020 <task>
ffffffe000200ae8:	fe042783          	lw	a5,-32(s0)
ffffffe000200aec:	00379793          	slli	a5,a5,0x3
ffffffe000200af0:	00f707b3          	add	a5,a4,a5
ffffffe000200af4:	0007b783          	ld	a5,0(a5)
ffffffe000200af8:	0107b603          	ld	a2,16(a5)
ffffffe000200afc:	00005717          	auipc	a4,0x5
ffffffe000200b00:	52470713          	addi	a4,a4,1316 # ffffffe000206020 <task>
ffffffe000200b04:	fe042783          	lw	a5,-32(s0)
ffffffe000200b08:	00379793          	slli	a5,a5,0x3
ffffffe000200b0c:	00f707b3          	add	a5,a4,a5
ffffffe000200b10:	0007b783          	ld	a5,0(a5)
ffffffe000200b14:	0087b783          	ld	a5,8(a5)
ffffffe000200b18:	00078693          	mv	a3,a5
ffffffe000200b1c:	00002517          	auipc	a0,0x2
ffffffe000200b20:	6cc50513          	addi	a0,a0,1740 # ffffffe0002031e8 <__func__.0+0x128>
ffffffe000200b24:	508010ef          	jal	ffffffe00020202c <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200b28:	fe042783          	lw	a5,-32(s0)
ffffffe000200b2c:	0017879b          	addiw	a5,a5,1
ffffffe000200b30:	fef42023          	sw	a5,-32(s0)
ffffffe000200b34:	fe042783          	lw	a5,-32(s0)
ffffffe000200b38:	0007871b          	sext.w	a4,a5
ffffffe000200b3c:	01f00793          	li	a5,31
ffffffe000200b40:	f4e7d6e3          	bge	a5,a4,ffffffe000200a8c <schedule+0xd0>
        }
        schedule();
ffffffe000200b44:	e79ff0ef          	jal	ffffffe0002009bc <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200b48:	00c0006f          	j	ffffffe000200b54 <schedule+0x198>
        switch_to(next);
ffffffe000200b4c:	fe843503          	ld	a0,-24(s0)
ffffffe000200b50:	cc1ff0ef          	jal	ffffffe000200810 <switch_to>
ffffffe000200b54:	00000013          	nop
ffffffe000200b58:	01813083          	ld	ra,24(sp)
ffffffe000200b5c:	01013403          	ld	s0,16(sp)
ffffffe000200b60:	02010113          	addi	sp,sp,32
ffffffe000200b64:	00008067          	ret

ffffffe000200b68 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200b68:	f7010113          	addi	sp,sp,-144
ffffffe000200b6c:	08113423          	sd	ra,136(sp)
ffffffe000200b70:	08813023          	sd	s0,128(sp)
ffffffe000200b74:	06913c23          	sd	s1,120(sp)
ffffffe000200b78:	07213823          	sd	s2,112(sp)
ffffffe000200b7c:	07313423          	sd	s3,104(sp)
ffffffe000200b80:	09010413          	addi	s0,sp,144
ffffffe000200b84:	faa43423          	sd	a0,-88(s0)
ffffffe000200b88:	fab43023          	sd	a1,-96(s0)
ffffffe000200b8c:	f8c43c23          	sd	a2,-104(s0)
ffffffe000200b90:	f8d43823          	sd	a3,-112(s0)
ffffffe000200b94:	f8e43423          	sd	a4,-120(s0)
ffffffe000200b98:	f8f43023          	sd	a5,-128(s0)
ffffffe000200b9c:	f7043c23          	sd	a6,-136(s0)
ffffffe000200ba0:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200ba4:	fa843e03          	ld	t3,-88(s0)
ffffffe000200ba8:	fa043e83          	ld	t4,-96(s0)
ffffffe000200bac:	f9843f03          	ld	t5,-104(s0)
ffffffe000200bb0:	f9043f83          	ld	t6,-112(s0)
ffffffe000200bb4:	f8843283          	ld	t0,-120(s0)
ffffffe000200bb8:	f8043483          	ld	s1,-128(s0)
ffffffe000200bbc:	f7843903          	ld	s2,-136(s0)
ffffffe000200bc0:	f7043983          	ld	s3,-144(s0)
ffffffe000200bc4:	000e0893          	mv	a7,t3
ffffffe000200bc8:	000e8813          	mv	a6,t4
ffffffe000200bcc:	000f0513          	mv	a0,t5
ffffffe000200bd0:	000f8593          	mv	a1,t6
ffffffe000200bd4:	00028613          	mv	a2,t0
ffffffe000200bd8:	00048693          	mv	a3,s1
ffffffe000200bdc:	00090713          	mv	a4,s2
ffffffe000200be0:	00098793          	mv	a5,s3
ffffffe000200be4:	00000073          	ecall
ffffffe000200be8:	00050e93          	mv	t4,a0
ffffffe000200bec:	00058e13          	mv	t3,a1
ffffffe000200bf0:	fbd43823          	sd	t4,-80(s0)
ffffffe000200bf4:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200bf8:	fb043783          	ld	a5,-80(s0)
ffffffe000200bfc:	fcf43023          	sd	a5,-64(s0)
ffffffe000200c00:	fb843783          	ld	a5,-72(s0)
ffffffe000200c04:	fcf43423          	sd	a5,-56(s0)
ffffffe000200c08:	fc043703          	ld	a4,-64(s0)
ffffffe000200c0c:	fc843783          	ld	a5,-56(s0)
ffffffe000200c10:	00070313          	mv	t1,a4
ffffffe000200c14:	00078393          	mv	t2,a5
ffffffe000200c18:	00030713          	mv	a4,t1
ffffffe000200c1c:	00038793          	mv	a5,t2
}
ffffffe000200c20:	00070513          	mv	a0,a4
ffffffe000200c24:	00078593          	mv	a1,a5
ffffffe000200c28:	08813083          	ld	ra,136(sp)
ffffffe000200c2c:	08013403          	ld	s0,128(sp)
ffffffe000200c30:	07813483          	ld	s1,120(sp)
ffffffe000200c34:	07013903          	ld	s2,112(sp)
ffffffe000200c38:	06813983          	ld	s3,104(sp)
ffffffe000200c3c:	09010113          	addi	sp,sp,144
ffffffe000200c40:	00008067          	ret

ffffffe000200c44 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200c44:	fc010113          	addi	sp,sp,-64
ffffffe000200c48:	02113c23          	sd	ra,56(sp)
ffffffe000200c4c:	02813823          	sd	s0,48(sp)
ffffffe000200c50:	03213423          	sd	s2,40(sp)
ffffffe000200c54:	03313023          	sd	s3,32(sp)
ffffffe000200c58:	04010413          	addi	s0,sp,64
ffffffe000200c5c:	00050793          	mv	a5,a0
ffffffe000200c60:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200c64:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200c68:	00000893          	li	a7,0
ffffffe000200c6c:	00000813          	li	a6,0
ffffffe000200c70:	00000793          	li	a5,0
ffffffe000200c74:	00000713          	li	a4,0
ffffffe000200c78:	00000693          	li	a3,0
ffffffe000200c7c:	00200593          	li	a1,2
ffffffe000200c80:	44424537          	lui	a0,0x44424
ffffffe000200c84:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200c88:	ee1ff0ef          	jal	ffffffe000200b68 <sbi_ecall>
ffffffe000200c8c:	00050713          	mv	a4,a0
ffffffe000200c90:	00058793          	mv	a5,a1
ffffffe000200c94:	fce43823          	sd	a4,-48(s0)
ffffffe000200c98:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c9c:	fd043703          	ld	a4,-48(s0)
ffffffe000200ca0:	fd843783          	ld	a5,-40(s0)
ffffffe000200ca4:	00070913          	mv	s2,a4
ffffffe000200ca8:	00078993          	mv	s3,a5
ffffffe000200cac:	00090713          	mv	a4,s2
ffffffe000200cb0:	00098793          	mv	a5,s3
}
ffffffe000200cb4:	00070513          	mv	a0,a4
ffffffe000200cb8:	00078593          	mv	a1,a5
ffffffe000200cbc:	03813083          	ld	ra,56(sp)
ffffffe000200cc0:	03013403          	ld	s0,48(sp)
ffffffe000200cc4:	02813903          	ld	s2,40(sp)
ffffffe000200cc8:	02013983          	ld	s3,32(sp)
ffffffe000200ccc:	04010113          	addi	sp,sp,64
ffffffe000200cd0:	00008067          	ret

ffffffe000200cd4 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200cd4:	fc010113          	addi	sp,sp,-64
ffffffe000200cd8:	02113c23          	sd	ra,56(sp)
ffffffe000200cdc:	02813823          	sd	s0,48(sp)
ffffffe000200ce0:	03213423          	sd	s2,40(sp)
ffffffe000200ce4:	03313023          	sd	s3,32(sp)
ffffffe000200ce8:	04010413          	addi	s0,sp,64
ffffffe000200cec:	00050793          	mv	a5,a0
ffffffe000200cf0:	00058713          	mv	a4,a1
ffffffe000200cf4:	fcf42623          	sw	a5,-52(s0)
ffffffe000200cf8:	00070793          	mv	a5,a4
ffffffe000200cfc:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200d00:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200d04:	fc846683          	lwu	a3,-56(s0)
ffffffe000200d08:	00000893          	li	a7,0
ffffffe000200d0c:	00000813          	li	a6,0
ffffffe000200d10:	00000793          	li	a5,0
ffffffe000200d14:	00000713          	li	a4,0
ffffffe000200d18:	00000593          	li	a1,0
ffffffe000200d1c:	53525537          	lui	a0,0x53525
ffffffe000200d20:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200d24:	e45ff0ef          	jal	ffffffe000200b68 <sbi_ecall>
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

ffffffe000200d70 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200d70:	fc010113          	addi	sp,sp,-64
ffffffe000200d74:	02113c23          	sd	ra,56(sp)
ffffffe000200d78:	02813823          	sd	s0,48(sp)
ffffffe000200d7c:	03213423          	sd	s2,40(sp)
ffffffe000200d80:	03313023          	sd	s3,32(sp)
ffffffe000200d84:	04010413          	addi	s0,sp,64
ffffffe000200d88:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200d8c:	00000893          	li	a7,0
ffffffe000200d90:	00000813          	li	a6,0
ffffffe000200d94:	00000793          	li	a5,0
ffffffe000200d98:	00000713          	li	a4,0
ffffffe000200d9c:	00000693          	li	a3,0
ffffffe000200da0:	fc843603          	ld	a2,-56(s0)
ffffffe000200da4:	00000593          	li	a1,0
ffffffe000200da8:	54495537          	lui	a0,0x54495
ffffffe000200dac:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200db0:	db9ff0ef          	jal	ffffffe000200b68 <sbi_ecall>
ffffffe000200db4:	00050713          	mv	a4,a0
ffffffe000200db8:	00058793          	mv	a5,a1
ffffffe000200dbc:	fce43823          	sd	a4,-48(s0)
ffffffe000200dc0:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200dc4:	fd043703          	ld	a4,-48(s0)
ffffffe000200dc8:	fd843783          	ld	a5,-40(s0)
ffffffe000200dcc:	00070913          	mv	s2,a4
ffffffe000200dd0:	00078993          	mv	s3,a5
ffffffe000200dd4:	00090713          	mv	a4,s2
ffffffe000200dd8:	00098793          	mv	a5,s3
}
ffffffe000200ddc:	00070513          	mv	a0,a4
ffffffe000200de0:	00078593          	mv	a1,a5
ffffffe000200de4:	03813083          	ld	ra,56(sp)
ffffffe000200de8:	03013403          	ld	s0,48(sp)
ffffffe000200dec:	02813903          	ld	s2,40(sp)
ffffffe000200df0:	02013983          	ld	s3,32(sp)
ffffffe000200df4:	04010113          	addi	sp,sp,64
ffffffe000200df8:	00008067          	ret

ffffffe000200dfc <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200dfc:	fb010113          	addi	sp,sp,-80
ffffffe000200e00:	04113423          	sd	ra,72(sp)
ffffffe000200e04:	04813023          	sd	s0,64(sp)
ffffffe000200e08:	03213c23          	sd	s2,56(sp)
ffffffe000200e0c:	03313823          	sd	s3,48(sp)
ffffffe000200e10:	05010413          	addi	s0,sp,80
ffffffe000200e14:	fca43423          	sd	a0,-56(s0)
ffffffe000200e18:	fcb43023          	sd	a1,-64(s0)
ffffffe000200e1c:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e20:	00000893          	li	a7,0
ffffffe000200e24:	00000813          	li	a6,0
ffffffe000200e28:	00000793          	li	a5,0
ffffffe000200e2c:	fb843703          	ld	a4,-72(s0)
ffffffe000200e30:	fc043683          	ld	a3,-64(s0)
ffffffe000200e34:	fc843603          	ld	a2,-56(s0)
ffffffe000200e38:	00100593          	li	a1,1
ffffffe000200e3c:	44424537          	lui	a0,0x44424
ffffffe000200e40:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e44:	d25ff0ef          	jal	ffffffe000200b68 <sbi_ecall>
ffffffe000200e48:	00050713          	mv	a4,a0
ffffffe000200e4c:	00058793          	mv	a5,a1
ffffffe000200e50:	fce43823          	sd	a4,-48(s0)
ffffffe000200e54:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e58:	fd043703          	ld	a4,-48(s0)
ffffffe000200e5c:	fd843783          	ld	a5,-40(s0)
ffffffe000200e60:	00070913          	mv	s2,a4
ffffffe000200e64:	00078993          	mv	s3,a5
ffffffe000200e68:	00090713          	mv	a4,s2
ffffffe000200e6c:	00098793          	mv	a5,s3
}
ffffffe000200e70:	00070513          	mv	a0,a4
ffffffe000200e74:	00078593          	mv	a1,a5
ffffffe000200e78:	04813083          	ld	ra,72(sp)
ffffffe000200e7c:	04013403          	ld	s0,64(sp)
ffffffe000200e80:	03813903          	ld	s2,56(sp)
ffffffe000200e84:	03013983          	ld	s3,48(sp)
ffffffe000200e88:	05010113          	addi	sp,sp,80
ffffffe000200e8c:	00008067          	ret

ffffffe000200e90 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200e90:	fb010113          	addi	sp,sp,-80
ffffffe000200e94:	04113423          	sd	ra,72(sp)
ffffffe000200e98:	04813023          	sd	s0,64(sp)
ffffffe000200e9c:	03213c23          	sd	s2,56(sp)
ffffffe000200ea0:	03313823          	sd	s3,48(sp)
ffffffe000200ea4:	05010413          	addi	s0,sp,80
ffffffe000200ea8:	fca43423          	sd	a0,-56(s0)
ffffffe000200eac:	fcb43023          	sd	a1,-64(s0)
ffffffe000200eb0:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200eb4:	00000893          	li	a7,0
ffffffe000200eb8:	00000813          	li	a6,0
ffffffe000200ebc:	00000793          	li	a5,0
ffffffe000200ec0:	fb843703          	ld	a4,-72(s0)
ffffffe000200ec4:	fc043683          	ld	a3,-64(s0)
ffffffe000200ec8:	fc843603          	ld	a2,-56(s0)
ffffffe000200ecc:	00000593          	li	a1,0
ffffffe000200ed0:	44424537          	lui	a0,0x44424
ffffffe000200ed4:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200ed8:	c91ff0ef          	jal	ffffffe000200b68 <sbi_ecall>
ffffffe000200edc:	00050713          	mv	a4,a0
ffffffe000200ee0:	00058793          	mv	a5,a1
ffffffe000200ee4:	fce43823          	sd	a4,-48(s0)
ffffffe000200ee8:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200eec:	fd043703          	ld	a4,-48(s0)
ffffffe000200ef0:	fd843783          	ld	a5,-40(s0)
ffffffe000200ef4:	00070913          	mv	s2,a4
ffffffe000200ef8:	00078993          	mv	s3,a5
ffffffe000200efc:	00090713          	mv	a4,s2
ffffffe000200f00:	00098793          	mv	a5,s3
ffffffe000200f04:	00070513          	mv	a0,a4
ffffffe000200f08:	00078593          	mv	a1,a5
ffffffe000200f0c:	04813083          	ld	ra,72(sp)
ffffffe000200f10:	04013403          	ld	s0,64(sp)
ffffffe000200f14:	03813903          	ld	s2,56(sp)
ffffffe000200f18:	03013983          	ld	s3,48(sp)
ffffffe000200f1c:	05010113          	addi	sp,sp,80
ffffffe000200f20:	00008067          	ret

ffffffe000200f24 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200f24:	fe010113          	addi	sp,sp,-32
ffffffe000200f28:	00113c23          	sd	ra,24(sp)
ffffffe000200f2c:	00813823          	sd	s0,16(sp)
ffffffe000200f30:	02010413          	addi	s0,sp,32
ffffffe000200f34:	fea43423          	sd	a0,-24(s0)
ffffffe000200f38:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200f3c:	fe843783          	ld	a5,-24(s0)
ffffffe000200f40:	0207d063          	bgez	a5,ffffffe000200f60 <trap_handler+0x3c>
ffffffe000200f44:	fe843783          	ld	a5,-24(s0)
ffffffe000200f48:	0ff7f713          	zext.b	a4,a5
ffffffe000200f4c:	00500793          	li	a5,5
ffffffe000200f50:	00f71863          	bne	a4,a5,ffffffe000200f60 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200f54:	b0cff0ef          	jal	ffffffe000200260 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200f58:	9c5ff0ef          	jal	ffffffe00020091c <do_timer>
ffffffe000200f5c:	01c0006f          	j	ffffffe000200f78 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200f60:	fe043603          	ld	a2,-32(s0)
ffffffe000200f64:	fe843583          	ld	a1,-24(s0)
ffffffe000200f68:	00002517          	auipc	a0,0x2
ffffffe000200f6c:	2e850513          	addi	a0,a0,744 # ffffffe000203250 <__func__.0+0x10>
ffffffe000200f70:	0bc010ef          	jal	ffffffe00020202c <printk>
    }
ffffffe000200f74:	00000013          	nop
ffffffe000200f78:	00000013          	nop
ffffffe000200f7c:	01813083          	ld	ra,24(sp)
ffffffe000200f80:	01013403          	ld	s0,16(sp)
ffffffe000200f84:	02010113          	addi	sp,sp,32
ffffffe000200f88:	00008067          	ret

ffffffe000200f8c <setup_vm>:
#include "string.h"

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000200f8c:	fe010113          	addi	sp,sp,-32
ffffffe000200f90:	00113c23          	sd	ra,24(sp)
ffffffe000200f94:	00813823          	sd	s0,16(sp)
ffffffe000200f98:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200f9c:	00001637          	lui	a2,0x1
ffffffe000200fa0:	00000593          	li	a1,0
ffffffe000200fa4:	00006517          	auipc	a0,0x6
ffffffe000200fa8:	05c50513          	addi	a0,a0,92 # ffffffe000207000 <early_pgtbl>
ffffffe000200fac:	1b0010ef          	jal	ffffffe00020215c <memset>
    //     early_pgtbl[i] |= ((1 << 4) - 1);
    // }


    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
ffffffe000200fb0:	00200793          	li	a5,2
ffffffe000200fb4:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200fb8:	00006717          	auipc	a4,0x6
ffffffe000200fbc:	04870713          	addi	a4,a4,72 # ffffffe000207000 <early_pgtbl>
ffffffe000200fc0:	fe843783          	ld	a5,-24(s0)
ffffffe000200fc4:	00379793          	slli	a5,a5,0x3
ffffffe000200fc8:	00f707b3          	add	a5,a4,a5
ffffffe000200fcc:	20000737          	lui	a4,0x20000
ffffffe000200fd0:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200fd4:	00006717          	auipc	a4,0x6
ffffffe000200fd8:	02c70713          	addi	a4,a4,44 # ffffffe000207000 <early_pgtbl>
ffffffe000200fdc:	fe843783          	ld	a5,-24(s0)
ffffffe000200fe0:	00379793          	slli	a5,a5,0x3
ffffffe000200fe4:	00f707b3          	add	a5,a4,a5
ffffffe000200fe8:	0007b783          	ld	a5,0(a5)
ffffffe000200fec:	00f7e713          	ori	a4,a5,15
ffffffe000200ff0:	00006697          	auipc	a3,0x6
ffffffe000200ff4:	01068693          	addi	a3,a3,16 # ffffffe000207000 <early_pgtbl>
ffffffe000200ff8:	fe843783          	ld	a5,-24(s0)
ffffffe000200ffc:	00379793          	slli	a5,a5,0x3
ffffffe000201000:	00f687b3          	add	a5,a3,a5
ffffffe000201004:	00e7b023          	sd	a4,0(a5)


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
ffffffe000201008:	18000793          	li	a5,384
ffffffe00020100c:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000201010:	00006717          	auipc	a4,0x6
ffffffe000201014:	ff070713          	addi	a4,a4,-16 # ffffffe000207000 <early_pgtbl>
ffffffe000201018:	fe843783          	ld	a5,-24(s0)
ffffffe00020101c:	00379793          	slli	a5,a5,0x3
ffffffe000201020:	00f707b3          	add	a5,a4,a5
ffffffe000201024:	20000737          	lui	a4,0x20000
ffffffe000201028:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe00020102c:	00006717          	auipc	a4,0x6
ffffffe000201030:	fd470713          	addi	a4,a4,-44 # ffffffe000207000 <early_pgtbl>
ffffffe000201034:	fe843783          	ld	a5,-24(s0)
ffffffe000201038:	00379793          	slli	a5,a5,0x3
ffffffe00020103c:	00f707b3          	add	a5,a4,a5
ffffffe000201040:	0007b783          	ld	a5,0(a5)
ffffffe000201044:	00f7e713          	ori	a4,a5,15
ffffffe000201048:	00006697          	auipc	a3,0x6
ffffffe00020104c:	fb868693          	addi	a3,a3,-72 # ffffffe000207000 <early_pgtbl>
ffffffe000201050:	fe843783          	ld	a5,-24(s0)
ffffffe000201054:	00379793          	slli	a5,a5,0x3
ffffffe000201058:	00f687b3          	add	a5,a3,a5
ffffffe00020105c:	00e7b023          	sd	a4,0(a5)

    printk("...setup_vm done!\n");
ffffffe000201060:	00002517          	auipc	a0,0x2
ffffffe000201064:	23050513          	addi	a0,a0,560 # ffffffe000203290 <__func__.0+0x50>
ffffffe000201068:	7c5000ef          	jal	ffffffe00020202c <printk>
ffffffe00020106c:	00000013          	nop
ffffffe000201070:	01813083          	ld	ra,24(sp)
ffffffe000201074:	01013403          	ld	s0,16(sp)
ffffffe000201078:	02010113          	addi	sp,sp,32
ffffffe00020107c:	00008067          	ret

ffffffe000201080 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe000201080:	ff010113          	addi	sp,sp,-16
ffffffe000201084:	00113423          	sd	ra,8(sp)
ffffffe000201088:	00813023          	sd	s0,0(sp)
ffffffe00020108c:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe000201090:	00002517          	auipc	a0,0x2
ffffffe000201094:	21850513          	addi	a0,a0,536 # ffffffe0002032a8 <__func__.0+0x68>
ffffffe000201098:	795000ef          	jal	ffffffe00020202c <printk>
    printk(" ZJU Operating System\n");
ffffffe00020109c:	00002517          	auipc	a0,0x2
ffffffe0002010a0:	21450513          	addi	a0,a0,532 # ffffffe0002032b0 <__func__.0+0x70>
ffffffe0002010a4:	789000ef          	jal	ffffffe00020202c <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe0002010a8:	0b0000ef          	jal	ffffffe000201158 <run_idle>
    return 0;
ffffffe0002010ac:	00000793          	li	a5,0
}
ffffffe0002010b0:	00078513          	mv	a0,a5
ffffffe0002010b4:	00813083          	ld	ra,8(sp)
ffffffe0002010b8:	00013403          	ld	s0,0(sp)
ffffffe0002010bc:	01010113          	addi	sp,sp,16
ffffffe0002010c0:	00008067          	ret

ffffffe0002010c4 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe0002010c4:	ff010113          	addi	sp,sp,-16
ffffffe0002010c8:	00113423          	sd	ra,8(sp)
ffffffe0002010cc:	00813023          	sd	s0,0(sp)
ffffffe0002010d0:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe0002010d4:	00000593          	li	a1,0
ffffffe0002010d8:	00000513          	li	a0,0
ffffffe0002010dc:	bf9ff0ef          	jal	ffffffe000200cd4 <sbi_system_reset>

ffffffe0002010e0 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe0002010e0:	fe010113          	addi	sp,sp,-32
ffffffe0002010e4:	00113c23          	sd	ra,24(sp)
ffffffe0002010e8:	00813823          	sd	s0,16(sp)
ffffffe0002010ec:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe0002010f0:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe0002010f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002010f8:	0017879b          	addiw	a5,a5,1
ffffffe0002010fc:	fef42623          	sw	a5,-20(s0)
ffffffe000201100:	fec42783          	lw	a5,-20(s0)
ffffffe000201104:	0007869b          	sext.w	a3,a5
ffffffe000201108:	55e64737          	lui	a4,0x55e64
ffffffe00020110c:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <PHY_SIZE+0x4de63b89>
ffffffe000201110:	02e68733          	mul	a4,a3,a4
ffffffe000201114:	02075713          	srli	a4,a4,0x20
ffffffe000201118:	4197571b          	sraiw	a4,a4,0x19
ffffffe00020111c:	00070693          	mv	a3,a4
ffffffe000201120:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffe000201124:	40e6873b          	subw	a4,a3,a4
ffffffe000201128:	00070693          	mv	a3,a4
ffffffe00020112c:	05f5e737          	lui	a4,0x5f5e
ffffffe000201130:	1007071b          	addiw	a4,a4,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe000201134:	02e6873b          	mulw	a4,a3,a4
ffffffe000201138:	40e787bb          	subw	a5,a5,a4
ffffffe00020113c:	0007879b          	sext.w	a5,a5
ffffffe000201140:	fa079ae3          	bnez	a5,ffffffe0002010f4 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe000201144:	00002517          	auipc	a0,0x2
ffffffe000201148:	18450513          	addi	a0,a0,388 # ffffffe0002032c8 <__func__.0+0x88>
ffffffe00020114c:	6e1000ef          	jal	ffffffe00020202c <printk>
            i = 0;
ffffffe000201150:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe000201154:	fa1ff06f          	j	ffffffe0002010f4 <test+0x14>

ffffffe000201158 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe000201158:	ff010113          	addi	sp,sp,-16
ffffffe00020115c:	00113423          	sd	ra,8(sp)
ffffffe000201160:	00813023          	sd	s0,0(sp)
ffffffe000201164:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe000201168:	0000006f          	j	ffffffe000201168 <run_idle+0x10>

ffffffe00020116c <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe00020116c:	fe010113          	addi	sp,sp,-32
ffffffe000201170:	00113c23          	sd	ra,24(sp)
ffffffe000201174:	00813823          	sd	s0,16(sp)
ffffffe000201178:	02010413          	addi	s0,sp,32
ffffffe00020117c:	00050793          	mv	a5,a0
ffffffe000201180:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe000201184:	fec42783          	lw	a5,-20(s0)
ffffffe000201188:	0ff7f793          	zext.b	a5,a5
ffffffe00020118c:	00078513          	mv	a0,a5
ffffffe000201190:	ab5ff0ef          	jal	ffffffe000200c44 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe000201194:	fec42783          	lw	a5,-20(s0)
ffffffe000201198:	0ff7f793          	zext.b	a5,a5
ffffffe00020119c:	0007879b          	sext.w	a5,a5
}
ffffffe0002011a0:	00078513          	mv	a0,a5
ffffffe0002011a4:	01813083          	ld	ra,24(sp)
ffffffe0002011a8:	01013403          	ld	s0,16(sp)
ffffffe0002011ac:	02010113          	addi	sp,sp,32
ffffffe0002011b0:	00008067          	ret

ffffffe0002011b4 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe0002011b4:	fe010113          	addi	sp,sp,-32
ffffffe0002011b8:	00113c23          	sd	ra,24(sp)
ffffffe0002011bc:	00813823          	sd	s0,16(sp)
ffffffe0002011c0:	02010413          	addi	s0,sp,32
ffffffe0002011c4:	00050793          	mv	a5,a0
ffffffe0002011c8:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe0002011cc:	fec42783          	lw	a5,-20(s0)
ffffffe0002011d0:	0007871b          	sext.w	a4,a5
ffffffe0002011d4:	02000793          	li	a5,32
ffffffe0002011d8:	02f70263          	beq	a4,a5,ffffffe0002011fc <isspace+0x48>
ffffffe0002011dc:	fec42783          	lw	a5,-20(s0)
ffffffe0002011e0:	0007871b          	sext.w	a4,a5
ffffffe0002011e4:	00800793          	li	a5,8
ffffffe0002011e8:	00e7de63          	bge	a5,a4,ffffffe000201204 <isspace+0x50>
ffffffe0002011ec:	fec42783          	lw	a5,-20(s0)
ffffffe0002011f0:	0007871b          	sext.w	a4,a5
ffffffe0002011f4:	00d00793          	li	a5,13
ffffffe0002011f8:	00e7c663          	blt	a5,a4,ffffffe000201204 <isspace+0x50>
ffffffe0002011fc:	00100793          	li	a5,1
ffffffe000201200:	0080006f          	j	ffffffe000201208 <isspace+0x54>
ffffffe000201204:	00000793          	li	a5,0
}
ffffffe000201208:	00078513          	mv	a0,a5
ffffffe00020120c:	01813083          	ld	ra,24(sp)
ffffffe000201210:	01013403          	ld	s0,16(sp)
ffffffe000201214:	02010113          	addi	sp,sp,32
ffffffe000201218:	00008067          	ret

ffffffe00020121c <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe00020121c:	fb010113          	addi	sp,sp,-80
ffffffe000201220:	04113423          	sd	ra,72(sp)
ffffffe000201224:	04813023          	sd	s0,64(sp)
ffffffe000201228:	05010413          	addi	s0,sp,80
ffffffe00020122c:	fca43423          	sd	a0,-56(s0)
ffffffe000201230:	fcb43023          	sd	a1,-64(s0)
ffffffe000201234:	00060793          	mv	a5,a2
ffffffe000201238:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe00020123c:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe000201240:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe000201244:	fc843783          	ld	a5,-56(s0)
ffffffe000201248:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe00020124c:	0100006f          	j	ffffffe00020125c <strtol+0x40>
        p++;
ffffffe000201250:	fd843783          	ld	a5,-40(s0)
ffffffe000201254:	00178793          	addi	a5,a5,1
ffffffe000201258:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe00020125c:	fd843783          	ld	a5,-40(s0)
ffffffe000201260:	0007c783          	lbu	a5,0(a5)
ffffffe000201264:	0007879b          	sext.w	a5,a5
ffffffe000201268:	00078513          	mv	a0,a5
ffffffe00020126c:	f49ff0ef          	jal	ffffffe0002011b4 <isspace>
ffffffe000201270:	00050793          	mv	a5,a0
ffffffe000201274:	fc079ee3          	bnez	a5,ffffffe000201250 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe000201278:	fd843783          	ld	a5,-40(s0)
ffffffe00020127c:	0007c783          	lbu	a5,0(a5)
ffffffe000201280:	00078713          	mv	a4,a5
ffffffe000201284:	02d00793          	li	a5,45
ffffffe000201288:	00f71e63          	bne	a4,a5,ffffffe0002012a4 <strtol+0x88>
        neg = true;
ffffffe00020128c:	00100793          	li	a5,1
ffffffe000201290:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe000201294:	fd843783          	ld	a5,-40(s0)
ffffffe000201298:	00178793          	addi	a5,a5,1
ffffffe00020129c:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002012a0:	0240006f          	j	ffffffe0002012c4 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe0002012a4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012a8:	0007c783          	lbu	a5,0(a5)
ffffffe0002012ac:	00078713          	mv	a4,a5
ffffffe0002012b0:	02b00793          	li	a5,43
ffffffe0002012b4:	00f71863          	bne	a4,a5,ffffffe0002012c4 <strtol+0xa8>
        p++;
ffffffe0002012b8:	fd843783          	ld	a5,-40(s0)
ffffffe0002012bc:	00178793          	addi	a5,a5,1
ffffffe0002012c0:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe0002012c4:	fbc42783          	lw	a5,-68(s0)
ffffffe0002012c8:	0007879b          	sext.w	a5,a5
ffffffe0002012cc:	06079c63          	bnez	a5,ffffffe000201344 <strtol+0x128>
        if (*p == '0') {
ffffffe0002012d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002012d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002012d8:	00078713          	mv	a4,a5
ffffffe0002012dc:	03000793          	li	a5,48
ffffffe0002012e0:	04f71e63          	bne	a4,a5,ffffffe00020133c <strtol+0x120>
            p++;
ffffffe0002012e4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012e8:	00178793          	addi	a5,a5,1
ffffffe0002012ec:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe0002012f0:	fd843783          	ld	a5,-40(s0)
ffffffe0002012f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002012f8:	00078713          	mv	a4,a5
ffffffe0002012fc:	07800793          	li	a5,120
ffffffe000201300:	00f70c63          	beq	a4,a5,ffffffe000201318 <strtol+0xfc>
ffffffe000201304:	fd843783          	ld	a5,-40(s0)
ffffffe000201308:	0007c783          	lbu	a5,0(a5)
ffffffe00020130c:	00078713          	mv	a4,a5
ffffffe000201310:	05800793          	li	a5,88
ffffffe000201314:	00f71e63          	bne	a4,a5,ffffffe000201330 <strtol+0x114>
                base = 16;
ffffffe000201318:	01000793          	li	a5,16
ffffffe00020131c:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000201320:	fd843783          	ld	a5,-40(s0)
ffffffe000201324:	00178793          	addi	a5,a5,1
ffffffe000201328:	fcf43c23          	sd	a5,-40(s0)
ffffffe00020132c:	0180006f          	j	ffffffe000201344 <strtol+0x128>
            } else {
                base = 8;
ffffffe000201330:	00800793          	li	a5,8
ffffffe000201334:	faf42e23          	sw	a5,-68(s0)
ffffffe000201338:	00c0006f          	j	ffffffe000201344 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe00020133c:	00a00793          	li	a5,10
ffffffe000201340:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe000201344:	fd843783          	ld	a5,-40(s0)
ffffffe000201348:	0007c783          	lbu	a5,0(a5)
ffffffe00020134c:	00078713          	mv	a4,a5
ffffffe000201350:	02f00793          	li	a5,47
ffffffe000201354:	02e7f863          	bgeu	a5,a4,ffffffe000201384 <strtol+0x168>
ffffffe000201358:	fd843783          	ld	a5,-40(s0)
ffffffe00020135c:	0007c783          	lbu	a5,0(a5)
ffffffe000201360:	00078713          	mv	a4,a5
ffffffe000201364:	03900793          	li	a5,57
ffffffe000201368:	00e7ee63          	bltu	a5,a4,ffffffe000201384 <strtol+0x168>
            digit = *p - '0';
ffffffe00020136c:	fd843783          	ld	a5,-40(s0)
ffffffe000201370:	0007c783          	lbu	a5,0(a5)
ffffffe000201374:	0007879b          	sext.w	a5,a5
ffffffe000201378:	fd07879b          	addiw	a5,a5,-48
ffffffe00020137c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201380:	0800006f          	j	ffffffe000201400 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe000201384:	fd843783          	ld	a5,-40(s0)
ffffffe000201388:	0007c783          	lbu	a5,0(a5)
ffffffe00020138c:	00078713          	mv	a4,a5
ffffffe000201390:	06000793          	li	a5,96
ffffffe000201394:	02e7f863          	bgeu	a5,a4,ffffffe0002013c4 <strtol+0x1a8>
ffffffe000201398:	fd843783          	ld	a5,-40(s0)
ffffffe00020139c:	0007c783          	lbu	a5,0(a5)
ffffffe0002013a0:	00078713          	mv	a4,a5
ffffffe0002013a4:	07a00793          	li	a5,122
ffffffe0002013a8:	00e7ee63          	bltu	a5,a4,ffffffe0002013c4 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe0002013ac:	fd843783          	ld	a5,-40(s0)
ffffffe0002013b0:	0007c783          	lbu	a5,0(a5)
ffffffe0002013b4:	0007879b          	sext.w	a5,a5
ffffffe0002013b8:	fa97879b          	addiw	a5,a5,-87
ffffffe0002013bc:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002013c0:	0400006f          	j	ffffffe000201400 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe0002013c4:	fd843783          	ld	a5,-40(s0)
ffffffe0002013c8:	0007c783          	lbu	a5,0(a5)
ffffffe0002013cc:	00078713          	mv	a4,a5
ffffffe0002013d0:	04000793          	li	a5,64
ffffffe0002013d4:	06e7f863          	bgeu	a5,a4,ffffffe000201444 <strtol+0x228>
ffffffe0002013d8:	fd843783          	ld	a5,-40(s0)
ffffffe0002013dc:	0007c783          	lbu	a5,0(a5)
ffffffe0002013e0:	00078713          	mv	a4,a5
ffffffe0002013e4:	05a00793          	li	a5,90
ffffffe0002013e8:	04e7ee63          	bltu	a5,a4,ffffffe000201444 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe0002013ec:	fd843783          	ld	a5,-40(s0)
ffffffe0002013f0:	0007c783          	lbu	a5,0(a5)
ffffffe0002013f4:	0007879b          	sext.w	a5,a5
ffffffe0002013f8:	fc97879b          	addiw	a5,a5,-55
ffffffe0002013fc:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000201400:	fd442783          	lw	a5,-44(s0)
ffffffe000201404:	00078713          	mv	a4,a5
ffffffe000201408:	fbc42783          	lw	a5,-68(s0)
ffffffe00020140c:	0007071b          	sext.w	a4,a4
ffffffe000201410:	0007879b          	sext.w	a5,a5
ffffffe000201414:	02f75663          	bge	a4,a5,ffffffe000201440 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe000201418:	fbc42703          	lw	a4,-68(s0)
ffffffe00020141c:	fe843783          	ld	a5,-24(s0)
ffffffe000201420:	02f70733          	mul	a4,a4,a5
ffffffe000201424:	fd442783          	lw	a5,-44(s0)
ffffffe000201428:	00f707b3          	add	a5,a4,a5
ffffffe00020142c:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe000201430:	fd843783          	ld	a5,-40(s0)
ffffffe000201434:	00178793          	addi	a5,a5,1
ffffffe000201438:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe00020143c:	f09ff06f          	j	ffffffe000201344 <strtol+0x128>
            break;
ffffffe000201440:	00000013          	nop
    }

    if (endptr) {
ffffffe000201444:	fc043783          	ld	a5,-64(s0)
ffffffe000201448:	00078863          	beqz	a5,ffffffe000201458 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe00020144c:	fc043783          	ld	a5,-64(s0)
ffffffe000201450:	fd843703          	ld	a4,-40(s0)
ffffffe000201454:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe000201458:	fe744783          	lbu	a5,-25(s0)
ffffffe00020145c:	0ff7f793          	zext.b	a5,a5
ffffffe000201460:	00078863          	beqz	a5,ffffffe000201470 <strtol+0x254>
ffffffe000201464:	fe843783          	ld	a5,-24(s0)
ffffffe000201468:	40f007b3          	neg	a5,a5
ffffffe00020146c:	0080006f          	j	ffffffe000201474 <strtol+0x258>
ffffffe000201470:	fe843783          	ld	a5,-24(s0)
}
ffffffe000201474:	00078513          	mv	a0,a5
ffffffe000201478:	04813083          	ld	ra,72(sp)
ffffffe00020147c:	04013403          	ld	s0,64(sp)
ffffffe000201480:	05010113          	addi	sp,sp,80
ffffffe000201484:	00008067          	ret

ffffffe000201488 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe000201488:	fd010113          	addi	sp,sp,-48
ffffffe00020148c:	02113423          	sd	ra,40(sp)
ffffffe000201490:	02813023          	sd	s0,32(sp)
ffffffe000201494:	03010413          	addi	s0,sp,48
ffffffe000201498:	fca43c23          	sd	a0,-40(s0)
ffffffe00020149c:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe0002014a0:	fd043783          	ld	a5,-48(s0)
ffffffe0002014a4:	00079863          	bnez	a5,ffffffe0002014b4 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe0002014a8:	00002797          	auipc	a5,0x2
ffffffe0002014ac:	e3878793          	addi	a5,a5,-456 # ffffffe0002032e0 <__func__.0+0xa0>
ffffffe0002014b0:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe0002014b4:	fd043783          	ld	a5,-48(s0)
ffffffe0002014b8:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe0002014bc:	0240006f          	j	ffffffe0002014e0 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe0002014c0:	fe843783          	ld	a5,-24(s0)
ffffffe0002014c4:	00178713          	addi	a4,a5,1
ffffffe0002014c8:	fee43423          	sd	a4,-24(s0)
ffffffe0002014cc:	0007c783          	lbu	a5,0(a5)
ffffffe0002014d0:	0007871b          	sext.w	a4,a5
ffffffe0002014d4:	fd843783          	ld	a5,-40(s0)
ffffffe0002014d8:	00070513          	mv	a0,a4
ffffffe0002014dc:	000780e7          	jalr	a5
    while (*p) {
ffffffe0002014e0:	fe843783          	ld	a5,-24(s0)
ffffffe0002014e4:	0007c783          	lbu	a5,0(a5)
ffffffe0002014e8:	fc079ce3          	bnez	a5,ffffffe0002014c0 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe0002014ec:	fe843703          	ld	a4,-24(s0)
ffffffe0002014f0:	fd043783          	ld	a5,-48(s0)
ffffffe0002014f4:	40f707b3          	sub	a5,a4,a5
ffffffe0002014f8:	0007879b          	sext.w	a5,a5
}
ffffffe0002014fc:	00078513          	mv	a0,a5
ffffffe000201500:	02813083          	ld	ra,40(sp)
ffffffe000201504:	02013403          	ld	s0,32(sp)
ffffffe000201508:	03010113          	addi	sp,sp,48
ffffffe00020150c:	00008067          	ret

ffffffe000201510 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000201510:	f9010113          	addi	sp,sp,-112
ffffffe000201514:	06113423          	sd	ra,104(sp)
ffffffe000201518:	06813023          	sd	s0,96(sp)
ffffffe00020151c:	07010413          	addi	s0,sp,112
ffffffe000201520:	faa43423          	sd	a0,-88(s0)
ffffffe000201524:	fab43023          	sd	a1,-96(s0)
ffffffe000201528:	00060793          	mv	a5,a2
ffffffe00020152c:	f8d43823          	sd	a3,-112(s0)
ffffffe000201530:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe000201534:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201538:	0ff7f793          	zext.b	a5,a5
ffffffe00020153c:	02078663          	beqz	a5,ffffffe000201568 <print_dec_int+0x58>
ffffffe000201540:	fa043703          	ld	a4,-96(s0)
ffffffe000201544:	fff00793          	li	a5,-1
ffffffe000201548:	03f79793          	slli	a5,a5,0x3f
ffffffe00020154c:	00f71e63          	bne	a4,a5,ffffffe000201568 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe000201550:	00002597          	auipc	a1,0x2
ffffffe000201554:	d9858593          	addi	a1,a1,-616 # ffffffe0002032e8 <__func__.0+0xa8>
ffffffe000201558:	fa843503          	ld	a0,-88(s0)
ffffffe00020155c:	f2dff0ef          	jal	ffffffe000201488 <puts_wo_nl>
ffffffe000201560:	00050793          	mv	a5,a0
ffffffe000201564:	2c80006f          	j	ffffffe00020182c <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe000201568:	f9043783          	ld	a5,-112(s0)
ffffffe00020156c:	00c7a783          	lw	a5,12(a5)
ffffffe000201570:	00079a63          	bnez	a5,ffffffe000201584 <print_dec_int+0x74>
ffffffe000201574:	fa043783          	ld	a5,-96(s0)
ffffffe000201578:	00079663          	bnez	a5,ffffffe000201584 <print_dec_int+0x74>
        return 0;
ffffffe00020157c:	00000793          	li	a5,0
ffffffe000201580:	2ac0006f          	j	ffffffe00020182c <print_dec_int+0x31c>
    }

    bool neg = false;
ffffffe000201584:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe000201588:	f9f44783          	lbu	a5,-97(s0)
ffffffe00020158c:	0ff7f793          	zext.b	a5,a5
ffffffe000201590:	02078063          	beqz	a5,ffffffe0002015b0 <print_dec_int+0xa0>
ffffffe000201594:	fa043783          	ld	a5,-96(s0)
ffffffe000201598:	0007dc63          	bgez	a5,ffffffe0002015b0 <print_dec_int+0xa0>
        neg = true;
ffffffe00020159c:	00100793          	li	a5,1
ffffffe0002015a0:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe0002015a4:	fa043783          	ld	a5,-96(s0)
ffffffe0002015a8:	40f007b3          	neg	a5,a5
ffffffe0002015ac:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe0002015b0:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe0002015b4:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002015b8:	0ff7f793          	zext.b	a5,a5
ffffffe0002015bc:	02078863          	beqz	a5,ffffffe0002015ec <print_dec_int+0xdc>
ffffffe0002015c0:	fef44783          	lbu	a5,-17(s0)
ffffffe0002015c4:	0ff7f793          	zext.b	a5,a5
ffffffe0002015c8:	00079e63          	bnez	a5,ffffffe0002015e4 <print_dec_int+0xd4>
ffffffe0002015cc:	f9043783          	ld	a5,-112(s0)
ffffffe0002015d0:	0057c783          	lbu	a5,5(a5)
ffffffe0002015d4:	00079863          	bnez	a5,ffffffe0002015e4 <print_dec_int+0xd4>
ffffffe0002015d8:	f9043783          	ld	a5,-112(s0)
ffffffe0002015dc:	0047c783          	lbu	a5,4(a5)
ffffffe0002015e0:	00078663          	beqz	a5,ffffffe0002015ec <print_dec_int+0xdc>
ffffffe0002015e4:	00100793          	li	a5,1
ffffffe0002015e8:	0080006f          	j	ffffffe0002015f0 <print_dec_int+0xe0>
ffffffe0002015ec:	00000793          	li	a5,0
ffffffe0002015f0:	fcf40ba3          	sb	a5,-41(s0)
ffffffe0002015f4:	fd744783          	lbu	a5,-41(s0)
ffffffe0002015f8:	0017f793          	andi	a5,a5,1
ffffffe0002015fc:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000201600:	fa043683          	ld	a3,-96(s0)
ffffffe000201604:	00002797          	auipc	a5,0x2
ffffffe000201608:	cfc78793          	addi	a5,a5,-772 # ffffffe000203300 <__func__.0+0xc0>
ffffffe00020160c:	0007b783          	ld	a5,0(a5)
ffffffe000201610:	02f6b7b3          	mulhu	a5,a3,a5
ffffffe000201614:	0037d713          	srli	a4,a5,0x3
ffffffe000201618:	00070793          	mv	a5,a4
ffffffe00020161c:	00279793          	slli	a5,a5,0x2
ffffffe000201620:	00e787b3          	add	a5,a5,a4
ffffffe000201624:	00179793          	slli	a5,a5,0x1
ffffffe000201628:	40f68733          	sub	a4,a3,a5
ffffffe00020162c:	0ff77713          	zext.b	a4,a4
ffffffe000201630:	fe842783          	lw	a5,-24(s0)
ffffffe000201634:	0017869b          	addiw	a3,a5,1
ffffffe000201638:	fed42423          	sw	a3,-24(s0)
ffffffe00020163c:	0307071b          	addiw	a4,a4,48
ffffffe000201640:	0ff77713          	zext.b	a4,a4
ffffffe000201644:	ff078793          	addi	a5,a5,-16
ffffffe000201648:	008787b3          	add	a5,a5,s0
ffffffe00020164c:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe000201650:	fa043703          	ld	a4,-96(s0)
ffffffe000201654:	00002797          	auipc	a5,0x2
ffffffe000201658:	cac78793          	addi	a5,a5,-852 # ffffffe000203300 <__func__.0+0xc0>
ffffffe00020165c:	0007b783          	ld	a5,0(a5)
ffffffe000201660:	02f737b3          	mulhu	a5,a4,a5
ffffffe000201664:	0037d793          	srli	a5,a5,0x3
ffffffe000201668:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe00020166c:	fa043783          	ld	a5,-96(s0)
ffffffe000201670:	f80798e3          	bnez	a5,ffffffe000201600 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe000201674:	f9043783          	ld	a5,-112(s0)
ffffffe000201678:	00c7a703          	lw	a4,12(a5)
ffffffe00020167c:	fff00793          	li	a5,-1
ffffffe000201680:	02f71063          	bne	a4,a5,ffffffe0002016a0 <print_dec_int+0x190>
ffffffe000201684:	f9043783          	ld	a5,-112(s0)
ffffffe000201688:	0037c783          	lbu	a5,3(a5)
ffffffe00020168c:	00078a63          	beqz	a5,ffffffe0002016a0 <print_dec_int+0x190>
        flags->prec = flags->width;
ffffffe000201690:	f9043783          	ld	a5,-112(s0)
ffffffe000201694:	0087a703          	lw	a4,8(a5)
ffffffe000201698:	f9043783          	ld	a5,-112(s0)
ffffffe00020169c:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe0002016a0:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe0002016a4:	f9043783          	ld	a5,-112(s0)
ffffffe0002016a8:	0087a703          	lw	a4,8(a5)
ffffffe0002016ac:	fe842783          	lw	a5,-24(s0)
ffffffe0002016b0:	fcf42823          	sw	a5,-48(s0)
ffffffe0002016b4:	f9043783          	ld	a5,-112(s0)
ffffffe0002016b8:	00c7a783          	lw	a5,12(a5)
ffffffe0002016bc:	fcf42623          	sw	a5,-52(s0)
ffffffe0002016c0:	fd042783          	lw	a5,-48(s0)
ffffffe0002016c4:	00078593          	mv	a1,a5
ffffffe0002016c8:	fcc42783          	lw	a5,-52(s0)
ffffffe0002016cc:	00078613          	mv	a2,a5
ffffffe0002016d0:	0006069b          	sext.w	a3,a2
ffffffe0002016d4:	0005879b          	sext.w	a5,a1
ffffffe0002016d8:	00f6d463          	bge	a3,a5,ffffffe0002016e0 <print_dec_int+0x1d0>
ffffffe0002016dc:	00058613          	mv	a2,a1
ffffffe0002016e0:	0006079b          	sext.w	a5,a2
ffffffe0002016e4:	40f707bb          	subw	a5,a4,a5
ffffffe0002016e8:	0007871b          	sext.w	a4,a5
ffffffe0002016ec:	fd744783          	lbu	a5,-41(s0)
ffffffe0002016f0:	0007879b          	sext.w	a5,a5
ffffffe0002016f4:	40f707bb          	subw	a5,a4,a5
ffffffe0002016f8:	fef42023          	sw	a5,-32(s0)
ffffffe0002016fc:	0280006f          	j	ffffffe000201724 <print_dec_int+0x214>
        putch(' ');
ffffffe000201700:	fa843783          	ld	a5,-88(s0)
ffffffe000201704:	02000513          	li	a0,32
ffffffe000201708:	000780e7          	jalr	a5
        ++written;
ffffffe00020170c:	fe442783          	lw	a5,-28(s0)
ffffffe000201710:	0017879b          	addiw	a5,a5,1
ffffffe000201714:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201718:	fe042783          	lw	a5,-32(s0)
ffffffe00020171c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201720:	fef42023          	sw	a5,-32(s0)
ffffffe000201724:	fe042783          	lw	a5,-32(s0)
ffffffe000201728:	0007879b          	sext.w	a5,a5
ffffffe00020172c:	fcf04ae3          	bgtz	a5,ffffffe000201700 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
ffffffe000201730:	fd744783          	lbu	a5,-41(s0)
ffffffe000201734:	0ff7f793          	zext.b	a5,a5
ffffffe000201738:	04078463          	beqz	a5,ffffffe000201780 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe00020173c:	fef44783          	lbu	a5,-17(s0)
ffffffe000201740:	0ff7f793          	zext.b	a5,a5
ffffffe000201744:	00078663          	beqz	a5,ffffffe000201750 <print_dec_int+0x240>
ffffffe000201748:	02d00793          	li	a5,45
ffffffe00020174c:	01c0006f          	j	ffffffe000201768 <print_dec_int+0x258>
ffffffe000201750:	f9043783          	ld	a5,-112(s0)
ffffffe000201754:	0057c783          	lbu	a5,5(a5)
ffffffe000201758:	00078663          	beqz	a5,ffffffe000201764 <print_dec_int+0x254>
ffffffe00020175c:	02b00793          	li	a5,43
ffffffe000201760:	0080006f          	j	ffffffe000201768 <print_dec_int+0x258>
ffffffe000201764:	02000793          	li	a5,32
ffffffe000201768:	fa843703          	ld	a4,-88(s0)
ffffffe00020176c:	00078513          	mv	a0,a5
ffffffe000201770:	000700e7          	jalr	a4
        ++written;
ffffffe000201774:	fe442783          	lw	a5,-28(s0)
ffffffe000201778:	0017879b          	addiw	a5,a5,1
ffffffe00020177c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201780:	fe842783          	lw	a5,-24(s0)
ffffffe000201784:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201788:	0280006f          	j	ffffffe0002017b0 <print_dec_int+0x2a0>
        putch('0');
ffffffe00020178c:	fa843783          	ld	a5,-88(s0)
ffffffe000201790:	03000513          	li	a0,48
ffffffe000201794:	000780e7          	jalr	a5
        ++written;
ffffffe000201798:	fe442783          	lw	a5,-28(s0)
ffffffe00020179c:	0017879b          	addiw	a5,a5,1
ffffffe0002017a0:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe0002017a4:	fdc42783          	lw	a5,-36(s0)
ffffffe0002017a8:	0017879b          	addiw	a5,a5,1
ffffffe0002017ac:	fcf42e23          	sw	a5,-36(s0)
ffffffe0002017b0:	f9043783          	ld	a5,-112(s0)
ffffffe0002017b4:	00c7a703          	lw	a4,12(a5)
ffffffe0002017b8:	fd744783          	lbu	a5,-41(s0)
ffffffe0002017bc:	0007879b          	sext.w	a5,a5
ffffffe0002017c0:	40f707bb          	subw	a5,a4,a5
ffffffe0002017c4:	0007879b          	sext.w	a5,a5
ffffffe0002017c8:	fdc42703          	lw	a4,-36(s0)
ffffffe0002017cc:	0007071b          	sext.w	a4,a4
ffffffe0002017d0:	faf74ee3          	blt	a4,a5,ffffffe00020178c <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe0002017d4:	fe842783          	lw	a5,-24(s0)
ffffffe0002017d8:	fff7879b          	addiw	a5,a5,-1
ffffffe0002017dc:	fcf42c23          	sw	a5,-40(s0)
ffffffe0002017e0:	03c0006f          	j	ffffffe00020181c <print_dec_int+0x30c>
        putch(buf[i]);
ffffffe0002017e4:	fd842783          	lw	a5,-40(s0)
ffffffe0002017e8:	ff078793          	addi	a5,a5,-16
ffffffe0002017ec:	008787b3          	add	a5,a5,s0
ffffffe0002017f0:	fc87c783          	lbu	a5,-56(a5)
ffffffe0002017f4:	0007871b          	sext.w	a4,a5
ffffffe0002017f8:	fa843783          	ld	a5,-88(s0)
ffffffe0002017fc:	00070513          	mv	a0,a4
ffffffe000201800:	000780e7          	jalr	a5
        ++written;
ffffffe000201804:	fe442783          	lw	a5,-28(s0)
ffffffe000201808:	0017879b          	addiw	a5,a5,1
ffffffe00020180c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201810:	fd842783          	lw	a5,-40(s0)
ffffffe000201814:	fff7879b          	addiw	a5,a5,-1
ffffffe000201818:	fcf42c23          	sw	a5,-40(s0)
ffffffe00020181c:	fd842783          	lw	a5,-40(s0)
ffffffe000201820:	0007879b          	sext.w	a5,a5
ffffffe000201824:	fc07d0e3          	bgez	a5,ffffffe0002017e4 <print_dec_int+0x2d4>
    }

    return written;
ffffffe000201828:	fe442783          	lw	a5,-28(s0)
}
ffffffe00020182c:	00078513          	mv	a0,a5
ffffffe000201830:	06813083          	ld	ra,104(sp)
ffffffe000201834:	06013403          	ld	s0,96(sp)
ffffffe000201838:	07010113          	addi	sp,sp,112
ffffffe00020183c:	00008067          	ret

ffffffe000201840 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201840:	f4010113          	addi	sp,sp,-192
ffffffe000201844:	0a113c23          	sd	ra,184(sp)
ffffffe000201848:	0a813823          	sd	s0,176(sp)
ffffffe00020184c:	0c010413          	addi	s0,sp,192
ffffffe000201850:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201854:	f4b43823          	sd	a1,-176(s0)
ffffffe000201858:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe00020185c:	f8043023          	sd	zero,-128(s0)
ffffffe000201860:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201864:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201868:	7a00006f          	j	ffffffe000202008 <vprintfmt+0x7c8>
        if (flags.in_format) {
ffffffe00020186c:	f8044783          	lbu	a5,-128(s0)
ffffffe000201870:	72078c63          	beqz	a5,ffffffe000201fa8 <vprintfmt+0x768>
            if (*fmt == '#') {
ffffffe000201874:	f5043783          	ld	a5,-176(s0)
ffffffe000201878:	0007c783          	lbu	a5,0(a5)
ffffffe00020187c:	00078713          	mv	a4,a5
ffffffe000201880:	02300793          	li	a5,35
ffffffe000201884:	00f71863          	bne	a4,a5,ffffffe000201894 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201888:	00100793          	li	a5,1
ffffffe00020188c:	f8f40123          	sb	a5,-126(s0)
ffffffe000201890:	76c0006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
ffffffe000201894:	f5043783          	ld	a5,-176(s0)
ffffffe000201898:	0007c783          	lbu	a5,0(a5)
ffffffe00020189c:	00078713          	mv	a4,a5
ffffffe0002018a0:	03000793          	li	a5,48
ffffffe0002018a4:	00f71863          	bne	a4,a5,ffffffe0002018b4 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe0002018a8:	00100793          	li	a5,1
ffffffe0002018ac:	f8f401a3          	sb	a5,-125(s0)
ffffffe0002018b0:	74c0006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe0002018b4:	f5043783          	ld	a5,-176(s0)
ffffffe0002018b8:	0007c783          	lbu	a5,0(a5)
ffffffe0002018bc:	00078713          	mv	a4,a5
ffffffe0002018c0:	06c00793          	li	a5,108
ffffffe0002018c4:	04f70063          	beq	a4,a5,ffffffe000201904 <vprintfmt+0xc4>
ffffffe0002018c8:	f5043783          	ld	a5,-176(s0)
ffffffe0002018cc:	0007c783          	lbu	a5,0(a5)
ffffffe0002018d0:	00078713          	mv	a4,a5
ffffffe0002018d4:	07a00793          	li	a5,122
ffffffe0002018d8:	02f70663          	beq	a4,a5,ffffffe000201904 <vprintfmt+0xc4>
ffffffe0002018dc:	f5043783          	ld	a5,-176(s0)
ffffffe0002018e0:	0007c783          	lbu	a5,0(a5)
ffffffe0002018e4:	00078713          	mv	a4,a5
ffffffe0002018e8:	07400793          	li	a5,116
ffffffe0002018ec:	00f70c63          	beq	a4,a5,ffffffe000201904 <vprintfmt+0xc4>
ffffffe0002018f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018f8:	00078713          	mv	a4,a5
ffffffe0002018fc:	06a00793          	li	a5,106
ffffffe000201900:	00f71863          	bne	a4,a5,ffffffe000201910 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201904:	00100793          	li	a5,1
ffffffe000201908:	f8f400a3          	sb	a5,-127(s0)
ffffffe00020190c:	6f00006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
ffffffe000201910:	f5043783          	ld	a5,-176(s0)
ffffffe000201914:	0007c783          	lbu	a5,0(a5)
ffffffe000201918:	00078713          	mv	a4,a5
ffffffe00020191c:	02b00793          	li	a5,43
ffffffe000201920:	00f71863          	bne	a4,a5,ffffffe000201930 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201924:	00100793          	li	a5,1
ffffffe000201928:	f8f402a3          	sb	a5,-123(s0)
ffffffe00020192c:	6d00006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
ffffffe000201930:	f5043783          	ld	a5,-176(s0)
ffffffe000201934:	0007c783          	lbu	a5,0(a5)
ffffffe000201938:	00078713          	mv	a4,a5
ffffffe00020193c:	02000793          	li	a5,32
ffffffe000201940:	00f71863          	bne	a4,a5,ffffffe000201950 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201944:	00100793          	li	a5,1
ffffffe000201948:	f8f40223          	sb	a5,-124(s0)
ffffffe00020194c:	6b00006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
ffffffe000201950:	f5043783          	ld	a5,-176(s0)
ffffffe000201954:	0007c783          	lbu	a5,0(a5)
ffffffe000201958:	00078713          	mv	a4,a5
ffffffe00020195c:	02a00793          	li	a5,42
ffffffe000201960:	00f71e63          	bne	a4,a5,ffffffe00020197c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201964:	f4843783          	ld	a5,-184(s0)
ffffffe000201968:	00878713          	addi	a4,a5,8
ffffffe00020196c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201970:	0007a783          	lw	a5,0(a5)
ffffffe000201974:	f8f42423          	sw	a5,-120(s0)
ffffffe000201978:	6840006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe00020197c:	f5043783          	ld	a5,-176(s0)
ffffffe000201980:	0007c783          	lbu	a5,0(a5)
ffffffe000201984:	00078713          	mv	a4,a5
ffffffe000201988:	03000793          	li	a5,48
ffffffe00020198c:	04e7f663          	bgeu	a5,a4,ffffffe0002019d8 <vprintfmt+0x198>
ffffffe000201990:	f5043783          	ld	a5,-176(s0)
ffffffe000201994:	0007c783          	lbu	a5,0(a5)
ffffffe000201998:	00078713          	mv	a4,a5
ffffffe00020199c:	03900793          	li	a5,57
ffffffe0002019a0:	02e7ec63          	bltu	a5,a4,ffffffe0002019d8 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe0002019a4:	f5043783          	ld	a5,-176(s0)
ffffffe0002019a8:	f5040713          	addi	a4,s0,-176
ffffffe0002019ac:	00a00613          	li	a2,10
ffffffe0002019b0:	00070593          	mv	a1,a4
ffffffe0002019b4:	00078513          	mv	a0,a5
ffffffe0002019b8:	865ff0ef          	jal	ffffffe00020121c <strtol>
ffffffe0002019bc:	00050793          	mv	a5,a0
ffffffe0002019c0:	0007879b          	sext.w	a5,a5
ffffffe0002019c4:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe0002019c8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019cc:	fff78793          	addi	a5,a5,-1
ffffffe0002019d0:	f4f43823          	sd	a5,-176(s0)
ffffffe0002019d4:	6280006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
ffffffe0002019d8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019dc:	0007c783          	lbu	a5,0(a5)
ffffffe0002019e0:	00078713          	mv	a4,a5
ffffffe0002019e4:	02e00793          	li	a5,46
ffffffe0002019e8:	06f71863          	bne	a4,a5,ffffffe000201a58 <vprintfmt+0x218>
                fmt++;
ffffffe0002019ec:	f5043783          	ld	a5,-176(s0)
ffffffe0002019f0:	00178793          	addi	a5,a5,1
ffffffe0002019f4:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe0002019f8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019fc:	0007c783          	lbu	a5,0(a5)
ffffffe000201a00:	00078713          	mv	a4,a5
ffffffe000201a04:	02a00793          	li	a5,42
ffffffe000201a08:	00f71e63          	bne	a4,a5,ffffffe000201a24 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000201a0c:	f4843783          	ld	a5,-184(s0)
ffffffe000201a10:	00878713          	addi	a4,a5,8
ffffffe000201a14:	f4e43423          	sd	a4,-184(s0)
ffffffe000201a18:	0007a783          	lw	a5,0(a5)
ffffffe000201a1c:	f8f42623          	sw	a5,-116(s0)
ffffffe000201a20:	5dc0006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201a24:	f5043783          	ld	a5,-176(s0)
ffffffe000201a28:	f5040713          	addi	a4,s0,-176
ffffffe000201a2c:	00a00613          	li	a2,10
ffffffe000201a30:	00070593          	mv	a1,a4
ffffffe000201a34:	00078513          	mv	a0,a5
ffffffe000201a38:	fe4ff0ef          	jal	ffffffe00020121c <strtol>
ffffffe000201a3c:	00050793          	mv	a5,a0
ffffffe000201a40:	0007879b          	sext.w	a5,a5
ffffffe000201a44:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201a48:	f5043783          	ld	a5,-176(s0)
ffffffe000201a4c:	fff78793          	addi	a5,a5,-1
ffffffe000201a50:	f4f43823          	sd	a5,-176(s0)
ffffffe000201a54:	5a80006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201a58:	f5043783          	ld	a5,-176(s0)
ffffffe000201a5c:	0007c783          	lbu	a5,0(a5)
ffffffe000201a60:	00078713          	mv	a4,a5
ffffffe000201a64:	07800793          	li	a5,120
ffffffe000201a68:	02f70663          	beq	a4,a5,ffffffe000201a94 <vprintfmt+0x254>
ffffffe000201a6c:	f5043783          	ld	a5,-176(s0)
ffffffe000201a70:	0007c783          	lbu	a5,0(a5)
ffffffe000201a74:	00078713          	mv	a4,a5
ffffffe000201a78:	05800793          	li	a5,88
ffffffe000201a7c:	00f70c63          	beq	a4,a5,ffffffe000201a94 <vprintfmt+0x254>
ffffffe000201a80:	f5043783          	ld	a5,-176(s0)
ffffffe000201a84:	0007c783          	lbu	a5,0(a5)
ffffffe000201a88:	00078713          	mv	a4,a5
ffffffe000201a8c:	07000793          	li	a5,112
ffffffe000201a90:	30f71063          	bne	a4,a5,ffffffe000201d90 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201a94:	f5043783          	ld	a5,-176(s0)
ffffffe000201a98:	0007c783          	lbu	a5,0(a5)
ffffffe000201a9c:	00078713          	mv	a4,a5
ffffffe000201aa0:	07000793          	li	a5,112
ffffffe000201aa4:	00f70663          	beq	a4,a5,ffffffe000201ab0 <vprintfmt+0x270>
ffffffe000201aa8:	f8144783          	lbu	a5,-127(s0)
ffffffe000201aac:	00078663          	beqz	a5,ffffffe000201ab8 <vprintfmt+0x278>
ffffffe000201ab0:	00100793          	li	a5,1
ffffffe000201ab4:	0080006f          	j	ffffffe000201abc <vprintfmt+0x27c>
ffffffe000201ab8:	00000793          	li	a5,0
ffffffe000201abc:	faf403a3          	sb	a5,-89(s0)
ffffffe000201ac0:	fa744783          	lbu	a5,-89(s0)
ffffffe000201ac4:	0017f793          	andi	a5,a5,1
ffffffe000201ac8:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201acc:	fa744783          	lbu	a5,-89(s0)
ffffffe000201ad0:	0ff7f793          	zext.b	a5,a5
ffffffe000201ad4:	00078c63          	beqz	a5,ffffffe000201aec <vprintfmt+0x2ac>
ffffffe000201ad8:	f4843783          	ld	a5,-184(s0)
ffffffe000201adc:	00878713          	addi	a4,a5,8
ffffffe000201ae0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201ae4:	0007b783          	ld	a5,0(a5)
ffffffe000201ae8:	01c0006f          	j	ffffffe000201b04 <vprintfmt+0x2c4>
ffffffe000201aec:	f4843783          	ld	a5,-184(s0)
ffffffe000201af0:	00878713          	addi	a4,a5,8
ffffffe000201af4:	f4e43423          	sd	a4,-184(s0)
ffffffe000201af8:	0007a783          	lw	a5,0(a5)
ffffffe000201afc:	02079793          	slli	a5,a5,0x20
ffffffe000201b00:	0207d793          	srli	a5,a5,0x20
ffffffe000201b04:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201b08:	f8c42783          	lw	a5,-116(s0)
ffffffe000201b0c:	02079463          	bnez	a5,ffffffe000201b34 <vprintfmt+0x2f4>
ffffffe000201b10:	fe043783          	ld	a5,-32(s0)
ffffffe000201b14:	02079063          	bnez	a5,ffffffe000201b34 <vprintfmt+0x2f4>
ffffffe000201b18:	f5043783          	ld	a5,-176(s0)
ffffffe000201b1c:	0007c783          	lbu	a5,0(a5)
ffffffe000201b20:	00078713          	mv	a4,a5
ffffffe000201b24:	07000793          	li	a5,112
ffffffe000201b28:	00f70663          	beq	a4,a5,ffffffe000201b34 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201b2c:	f8040023          	sb	zero,-128(s0)
ffffffe000201b30:	4cc0006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201b34:	f5043783          	ld	a5,-176(s0)
ffffffe000201b38:	0007c783          	lbu	a5,0(a5)
ffffffe000201b3c:	00078713          	mv	a4,a5
ffffffe000201b40:	07000793          	li	a5,112
ffffffe000201b44:	00f70a63          	beq	a4,a5,ffffffe000201b58 <vprintfmt+0x318>
ffffffe000201b48:	f8244783          	lbu	a5,-126(s0)
ffffffe000201b4c:	00078a63          	beqz	a5,ffffffe000201b60 <vprintfmt+0x320>
ffffffe000201b50:	fe043783          	ld	a5,-32(s0)
ffffffe000201b54:	00078663          	beqz	a5,ffffffe000201b60 <vprintfmt+0x320>
ffffffe000201b58:	00100793          	li	a5,1
ffffffe000201b5c:	0080006f          	j	ffffffe000201b64 <vprintfmt+0x324>
ffffffe000201b60:	00000793          	li	a5,0
ffffffe000201b64:	faf40323          	sb	a5,-90(s0)
ffffffe000201b68:	fa644783          	lbu	a5,-90(s0)
ffffffe000201b6c:	0017f793          	andi	a5,a5,1
ffffffe000201b70:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201b74:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201b78:	f5043783          	ld	a5,-176(s0)
ffffffe000201b7c:	0007c783          	lbu	a5,0(a5)
ffffffe000201b80:	00078713          	mv	a4,a5
ffffffe000201b84:	05800793          	li	a5,88
ffffffe000201b88:	00f71863          	bne	a4,a5,ffffffe000201b98 <vprintfmt+0x358>
ffffffe000201b8c:	00001797          	auipc	a5,0x1
ffffffe000201b90:	77c78793          	addi	a5,a5,1916 # ffffffe000203308 <upperxdigits.1>
ffffffe000201b94:	00c0006f          	j	ffffffe000201ba0 <vprintfmt+0x360>
ffffffe000201b98:	00001797          	auipc	a5,0x1
ffffffe000201b9c:	78878793          	addi	a5,a5,1928 # ffffffe000203320 <lowerxdigits.0>
ffffffe000201ba0:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201ba4:	fe043783          	ld	a5,-32(s0)
ffffffe000201ba8:	00f7f793          	andi	a5,a5,15
ffffffe000201bac:	f9843703          	ld	a4,-104(s0)
ffffffe000201bb0:	00f70733          	add	a4,a4,a5
ffffffe000201bb4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201bb8:	0017869b          	addiw	a3,a5,1
ffffffe000201bbc:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201bc0:	00074703          	lbu	a4,0(a4)
ffffffe000201bc4:	ff078793          	addi	a5,a5,-16
ffffffe000201bc8:	008787b3          	add	a5,a5,s0
ffffffe000201bcc:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201bd0:	fe043783          	ld	a5,-32(s0)
ffffffe000201bd4:	0047d793          	srli	a5,a5,0x4
ffffffe000201bd8:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201bdc:	fe043783          	ld	a5,-32(s0)
ffffffe000201be0:	fc0792e3          	bnez	a5,ffffffe000201ba4 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201be4:	f8c42703          	lw	a4,-116(s0)
ffffffe000201be8:	fff00793          	li	a5,-1
ffffffe000201bec:	02f71663          	bne	a4,a5,ffffffe000201c18 <vprintfmt+0x3d8>
ffffffe000201bf0:	f8344783          	lbu	a5,-125(s0)
ffffffe000201bf4:	02078263          	beqz	a5,ffffffe000201c18 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201bf8:	f8842703          	lw	a4,-120(s0)
ffffffe000201bfc:	fa644783          	lbu	a5,-90(s0)
ffffffe000201c00:	0007879b          	sext.w	a5,a5
ffffffe000201c04:	0017979b          	slliw	a5,a5,0x1
ffffffe000201c08:	0007879b          	sext.w	a5,a5
ffffffe000201c0c:	40f707bb          	subw	a5,a4,a5
ffffffe000201c10:	0007879b          	sext.w	a5,a5
ffffffe000201c14:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201c18:	f8842703          	lw	a4,-120(s0)
ffffffe000201c1c:	fa644783          	lbu	a5,-90(s0)
ffffffe000201c20:	0007879b          	sext.w	a5,a5
ffffffe000201c24:	0017979b          	slliw	a5,a5,0x1
ffffffe000201c28:	0007879b          	sext.w	a5,a5
ffffffe000201c2c:	40f707bb          	subw	a5,a4,a5
ffffffe000201c30:	0007871b          	sext.w	a4,a5
ffffffe000201c34:	fdc42783          	lw	a5,-36(s0)
ffffffe000201c38:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201c3c:	f8c42783          	lw	a5,-116(s0)
ffffffe000201c40:	f8f42823          	sw	a5,-112(s0)
ffffffe000201c44:	f9442783          	lw	a5,-108(s0)
ffffffe000201c48:	00078593          	mv	a1,a5
ffffffe000201c4c:	f9042783          	lw	a5,-112(s0)
ffffffe000201c50:	00078613          	mv	a2,a5
ffffffe000201c54:	0006069b          	sext.w	a3,a2
ffffffe000201c58:	0005879b          	sext.w	a5,a1
ffffffe000201c5c:	00f6d463          	bge	a3,a5,ffffffe000201c64 <vprintfmt+0x424>
ffffffe000201c60:	00058613          	mv	a2,a1
ffffffe000201c64:	0006079b          	sext.w	a5,a2
ffffffe000201c68:	40f707bb          	subw	a5,a4,a5
ffffffe000201c6c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201c70:	0280006f          	j	ffffffe000201c98 <vprintfmt+0x458>
                    putch(' ');
ffffffe000201c74:	f5843783          	ld	a5,-168(s0)
ffffffe000201c78:	02000513          	li	a0,32
ffffffe000201c7c:	000780e7          	jalr	a5
                    ++written;
ffffffe000201c80:	fec42783          	lw	a5,-20(s0)
ffffffe000201c84:	0017879b          	addiw	a5,a5,1
ffffffe000201c88:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201c8c:	fd842783          	lw	a5,-40(s0)
ffffffe000201c90:	fff7879b          	addiw	a5,a5,-1
ffffffe000201c94:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201c98:	fd842783          	lw	a5,-40(s0)
ffffffe000201c9c:	0007879b          	sext.w	a5,a5
ffffffe000201ca0:	fcf04ae3          	bgtz	a5,ffffffe000201c74 <vprintfmt+0x434>
                }

                if (prefix) {
ffffffe000201ca4:	fa644783          	lbu	a5,-90(s0)
ffffffe000201ca8:	0ff7f793          	zext.b	a5,a5
ffffffe000201cac:	04078463          	beqz	a5,ffffffe000201cf4 <vprintfmt+0x4b4>
                    putch('0');
ffffffe000201cb0:	f5843783          	ld	a5,-168(s0)
ffffffe000201cb4:	03000513          	li	a0,48
ffffffe000201cb8:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000201cbc:	f5043783          	ld	a5,-176(s0)
ffffffe000201cc0:	0007c783          	lbu	a5,0(a5)
ffffffe000201cc4:	00078713          	mv	a4,a5
ffffffe000201cc8:	05800793          	li	a5,88
ffffffe000201ccc:	00f71663          	bne	a4,a5,ffffffe000201cd8 <vprintfmt+0x498>
ffffffe000201cd0:	05800793          	li	a5,88
ffffffe000201cd4:	0080006f          	j	ffffffe000201cdc <vprintfmt+0x49c>
ffffffe000201cd8:	07800793          	li	a5,120
ffffffe000201cdc:	f5843703          	ld	a4,-168(s0)
ffffffe000201ce0:	00078513          	mv	a0,a5
ffffffe000201ce4:	000700e7          	jalr	a4
                    written += 2;
ffffffe000201ce8:	fec42783          	lw	a5,-20(s0)
ffffffe000201cec:	0027879b          	addiw	a5,a5,2
ffffffe000201cf0:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201cf4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201cf8:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201cfc:	0280006f          	j	ffffffe000201d24 <vprintfmt+0x4e4>
                    putch('0');
ffffffe000201d00:	f5843783          	ld	a5,-168(s0)
ffffffe000201d04:	03000513          	li	a0,48
ffffffe000201d08:	000780e7          	jalr	a5
                    ++written;
ffffffe000201d0c:	fec42783          	lw	a5,-20(s0)
ffffffe000201d10:	0017879b          	addiw	a5,a5,1
ffffffe000201d14:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201d18:	fd442783          	lw	a5,-44(s0)
ffffffe000201d1c:	0017879b          	addiw	a5,a5,1
ffffffe000201d20:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201d24:	f8c42783          	lw	a5,-116(s0)
ffffffe000201d28:	fd442703          	lw	a4,-44(s0)
ffffffe000201d2c:	0007071b          	sext.w	a4,a4
ffffffe000201d30:	fcf748e3          	blt	a4,a5,ffffffe000201d00 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201d34:	fdc42783          	lw	a5,-36(s0)
ffffffe000201d38:	fff7879b          	addiw	a5,a5,-1
ffffffe000201d3c:	fcf42823          	sw	a5,-48(s0)
ffffffe000201d40:	03c0006f          	j	ffffffe000201d7c <vprintfmt+0x53c>
                    putch(buf[i]);
ffffffe000201d44:	fd042783          	lw	a5,-48(s0)
ffffffe000201d48:	ff078793          	addi	a5,a5,-16
ffffffe000201d4c:	008787b3          	add	a5,a5,s0
ffffffe000201d50:	f807c783          	lbu	a5,-128(a5)
ffffffe000201d54:	0007871b          	sext.w	a4,a5
ffffffe000201d58:	f5843783          	ld	a5,-168(s0)
ffffffe000201d5c:	00070513          	mv	a0,a4
ffffffe000201d60:	000780e7          	jalr	a5
                    ++written;
ffffffe000201d64:	fec42783          	lw	a5,-20(s0)
ffffffe000201d68:	0017879b          	addiw	a5,a5,1
ffffffe000201d6c:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201d70:	fd042783          	lw	a5,-48(s0)
ffffffe000201d74:	fff7879b          	addiw	a5,a5,-1
ffffffe000201d78:	fcf42823          	sw	a5,-48(s0)
ffffffe000201d7c:	fd042783          	lw	a5,-48(s0)
ffffffe000201d80:	0007879b          	sext.w	a5,a5
ffffffe000201d84:	fc07d0e3          	bgez	a5,ffffffe000201d44 <vprintfmt+0x504>
                }

                flags.in_format = false;
ffffffe000201d88:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201d8c:	2700006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201d90:	f5043783          	ld	a5,-176(s0)
ffffffe000201d94:	0007c783          	lbu	a5,0(a5)
ffffffe000201d98:	00078713          	mv	a4,a5
ffffffe000201d9c:	06400793          	li	a5,100
ffffffe000201da0:	02f70663          	beq	a4,a5,ffffffe000201dcc <vprintfmt+0x58c>
ffffffe000201da4:	f5043783          	ld	a5,-176(s0)
ffffffe000201da8:	0007c783          	lbu	a5,0(a5)
ffffffe000201dac:	00078713          	mv	a4,a5
ffffffe000201db0:	06900793          	li	a5,105
ffffffe000201db4:	00f70c63          	beq	a4,a5,ffffffe000201dcc <vprintfmt+0x58c>
ffffffe000201db8:	f5043783          	ld	a5,-176(s0)
ffffffe000201dbc:	0007c783          	lbu	a5,0(a5)
ffffffe000201dc0:	00078713          	mv	a4,a5
ffffffe000201dc4:	07500793          	li	a5,117
ffffffe000201dc8:	08f71063          	bne	a4,a5,ffffffe000201e48 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe000201dcc:	f8144783          	lbu	a5,-127(s0)
ffffffe000201dd0:	00078c63          	beqz	a5,ffffffe000201de8 <vprintfmt+0x5a8>
ffffffe000201dd4:	f4843783          	ld	a5,-184(s0)
ffffffe000201dd8:	00878713          	addi	a4,a5,8
ffffffe000201ddc:	f4e43423          	sd	a4,-184(s0)
ffffffe000201de0:	0007b783          	ld	a5,0(a5)
ffffffe000201de4:	0140006f          	j	ffffffe000201df8 <vprintfmt+0x5b8>
ffffffe000201de8:	f4843783          	ld	a5,-184(s0)
ffffffe000201dec:	00878713          	addi	a4,a5,8
ffffffe000201df0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201df4:	0007a783          	lw	a5,0(a5)
ffffffe000201df8:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000201dfc:	fa843583          	ld	a1,-88(s0)
ffffffe000201e00:	f5043783          	ld	a5,-176(s0)
ffffffe000201e04:	0007c783          	lbu	a5,0(a5)
ffffffe000201e08:	0007871b          	sext.w	a4,a5
ffffffe000201e0c:	07500793          	li	a5,117
ffffffe000201e10:	40f707b3          	sub	a5,a4,a5
ffffffe000201e14:	00f037b3          	snez	a5,a5
ffffffe000201e18:	0ff7f793          	zext.b	a5,a5
ffffffe000201e1c:	f8040713          	addi	a4,s0,-128
ffffffe000201e20:	00070693          	mv	a3,a4
ffffffe000201e24:	00078613          	mv	a2,a5
ffffffe000201e28:	f5843503          	ld	a0,-168(s0)
ffffffe000201e2c:	ee4ff0ef          	jal	ffffffe000201510 <print_dec_int>
ffffffe000201e30:	00050793          	mv	a5,a0
ffffffe000201e34:	fec42703          	lw	a4,-20(s0)
ffffffe000201e38:	00f707bb          	addw	a5,a4,a5
ffffffe000201e3c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201e40:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201e44:	1b80006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
ffffffe000201e48:	f5043783          	ld	a5,-176(s0)
ffffffe000201e4c:	0007c783          	lbu	a5,0(a5)
ffffffe000201e50:	00078713          	mv	a4,a5
ffffffe000201e54:	06e00793          	li	a5,110
ffffffe000201e58:	04f71c63          	bne	a4,a5,ffffffe000201eb0 <vprintfmt+0x670>
                if (flags.longflag) {
ffffffe000201e5c:	f8144783          	lbu	a5,-127(s0)
ffffffe000201e60:	02078463          	beqz	a5,ffffffe000201e88 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
ffffffe000201e64:	f4843783          	ld	a5,-184(s0)
ffffffe000201e68:	00878713          	addi	a4,a5,8
ffffffe000201e6c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e70:	0007b783          	ld	a5,0(a5)
ffffffe000201e74:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe000201e78:	fec42703          	lw	a4,-20(s0)
ffffffe000201e7c:	fb043783          	ld	a5,-80(s0)
ffffffe000201e80:	00e7b023          	sd	a4,0(a5)
ffffffe000201e84:	0240006f          	j	ffffffe000201ea8 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe000201e88:	f4843783          	ld	a5,-184(s0)
ffffffe000201e8c:	00878713          	addi	a4,a5,8
ffffffe000201e90:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e94:	0007b783          	ld	a5,0(a5)
ffffffe000201e98:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000201e9c:	fb843783          	ld	a5,-72(s0)
ffffffe000201ea0:	fec42703          	lw	a4,-20(s0)
ffffffe000201ea4:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe000201ea8:	f8040023          	sb	zero,-128(s0)
ffffffe000201eac:	1500006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
ffffffe000201eb0:	f5043783          	ld	a5,-176(s0)
ffffffe000201eb4:	0007c783          	lbu	a5,0(a5)
ffffffe000201eb8:	00078713          	mv	a4,a5
ffffffe000201ebc:	07300793          	li	a5,115
ffffffe000201ec0:	02f71e63          	bne	a4,a5,ffffffe000201efc <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
ffffffe000201ec4:	f4843783          	ld	a5,-184(s0)
ffffffe000201ec8:	00878713          	addi	a4,a5,8
ffffffe000201ecc:	f4e43423          	sd	a4,-184(s0)
ffffffe000201ed0:	0007b783          	ld	a5,0(a5)
ffffffe000201ed4:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe000201ed8:	fc043583          	ld	a1,-64(s0)
ffffffe000201edc:	f5843503          	ld	a0,-168(s0)
ffffffe000201ee0:	da8ff0ef          	jal	ffffffe000201488 <puts_wo_nl>
ffffffe000201ee4:	00050793          	mv	a5,a0
ffffffe000201ee8:	fec42703          	lw	a4,-20(s0)
ffffffe000201eec:	00f707bb          	addw	a5,a4,a5
ffffffe000201ef0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201ef4:	f8040023          	sb	zero,-128(s0)
ffffffe000201ef8:	1040006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
ffffffe000201efc:	f5043783          	ld	a5,-176(s0)
ffffffe000201f00:	0007c783          	lbu	a5,0(a5)
ffffffe000201f04:	00078713          	mv	a4,a5
ffffffe000201f08:	06300793          	li	a5,99
ffffffe000201f0c:	02f71e63          	bne	a4,a5,ffffffe000201f48 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
ffffffe000201f10:	f4843783          	ld	a5,-184(s0)
ffffffe000201f14:	00878713          	addi	a4,a5,8
ffffffe000201f18:	f4e43423          	sd	a4,-184(s0)
ffffffe000201f1c:	0007a783          	lw	a5,0(a5)
ffffffe000201f20:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000201f24:	fcc42703          	lw	a4,-52(s0)
ffffffe000201f28:	f5843783          	ld	a5,-168(s0)
ffffffe000201f2c:	00070513          	mv	a0,a4
ffffffe000201f30:	000780e7          	jalr	a5
                ++written;
ffffffe000201f34:	fec42783          	lw	a5,-20(s0)
ffffffe000201f38:	0017879b          	addiw	a5,a5,1
ffffffe000201f3c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201f40:	f8040023          	sb	zero,-128(s0)
ffffffe000201f44:	0b80006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
ffffffe000201f48:	f5043783          	ld	a5,-176(s0)
ffffffe000201f4c:	0007c783          	lbu	a5,0(a5)
ffffffe000201f50:	00078713          	mv	a4,a5
ffffffe000201f54:	02500793          	li	a5,37
ffffffe000201f58:	02f71263          	bne	a4,a5,ffffffe000201f7c <vprintfmt+0x73c>
                putch('%');
ffffffe000201f5c:	f5843783          	ld	a5,-168(s0)
ffffffe000201f60:	02500513          	li	a0,37
ffffffe000201f64:	000780e7          	jalr	a5
                ++written;
ffffffe000201f68:	fec42783          	lw	a5,-20(s0)
ffffffe000201f6c:	0017879b          	addiw	a5,a5,1
ffffffe000201f70:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201f74:	f8040023          	sb	zero,-128(s0)
ffffffe000201f78:	0840006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
ffffffe000201f7c:	f5043783          	ld	a5,-176(s0)
ffffffe000201f80:	0007c783          	lbu	a5,0(a5)
ffffffe000201f84:	0007871b          	sext.w	a4,a5
ffffffe000201f88:	f5843783          	ld	a5,-168(s0)
ffffffe000201f8c:	00070513          	mv	a0,a4
ffffffe000201f90:	000780e7          	jalr	a5
                ++written;
ffffffe000201f94:	fec42783          	lw	a5,-20(s0)
ffffffe000201f98:	0017879b          	addiw	a5,a5,1
ffffffe000201f9c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201fa0:	f8040023          	sb	zero,-128(s0)
ffffffe000201fa4:	0580006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
ffffffe000201fa8:	f5043783          	ld	a5,-176(s0)
ffffffe000201fac:	0007c783          	lbu	a5,0(a5)
ffffffe000201fb0:	00078713          	mv	a4,a5
ffffffe000201fb4:	02500793          	li	a5,37
ffffffe000201fb8:	02f71063          	bne	a4,a5,ffffffe000201fd8 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe000201fbc:	f8043023          	sd	zero,-128(s0)
ffffffe000201fc0:	f8043423          	sd	zero,-120(s0)
ffffffe000201fc4:	00100793          	li	a5,1
ffffffe000201fc8:	f8f40023          	sb	a5,-128(s0)
ffffffe000201fcc:	fff00793          	li	a5,-1
ffffffe000201fd0:	f8f42623          	sw	a5,-116(s0)
ffffffe000201fd4:	0280006f          	j	ffffffe000201ffc <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
ffffffe000201fd8:	f5043783          	ld	a5,-176(s0)
ffffffe000201fdc:	0007c783          	lbu	a5,0(a5)
ffffffe000201fe0:	0007871b          	sext.w	a4,a5
ffffffe000201fe4:	f5843783          	ld	a5,-168(s0)
ffffffe000201fe8:	00070513          	mv	a0,a4
ffffffe000201fec:	000780e7          	jalr	a5
            ++written;
ffffffe000201ff0:	fec42783          	lw	a5,-20(s0)
ffffffe000201ff4:	0017879b          	addiw	a5,a5,1
ffffffe000201ff8:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe000201ffc:	f5043783          	ld	a5,-176(s0)
ffffffe000202000:	00178793          	addi	a5,a5,1
ffffffe000202004:	f4f43823          	sd	a5,-176(s0)
ffffffe000202008:	f5043783          	ld	a5,-176(s0)
ffffffe00020200c:	0007c783          	lbu	a5,0(a5)
ffffffe000202010:	84079ee3          	bnez	a5,ffffffe00020186c <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202014:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202018:	00078513          	mv	a0,a5
ffffffe00020201c:	0b813083          	ld	ra,184(sp)
ffffffe000202020:	0b013403          	ld	s0,176(sp)
ffffffe000202024:	0c010113          	addi	sp,sp,192
ffffffe000202028:	00008067          	ret

ffffffe00020202c <printk>:

int printk(const char* s, ...) {
ffffffe00020202c:	f9010113          	addi	sp,sp,-112
ffffffe000202030:	02113423          	sd	ra,40(sp)
ffffffe000202034:	02813023          	sd	s0,32(sp)
ffffffe000202038:	03010413          	addi	s0,sp,48
ffffffe00020203c:	fca43c23          	sd	a0,-40(s0)
ffffffe000202040:	00b43423          	sd	a1,8(s0)
ffffffe000202044:	00c43823          	sd	a2,16(s0)
ffffffe000202048:	00d43c23          	sd	a3,24(s0)
ffffffe00020204c:	02e43023          	sd	a4,32(s0)
ffffffe000202050:	02f43423          	sd	a5,40(s0)
ffffffe000202054:	03043823          	sd	a6,48(s0)
ffffffe000202058:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe00020205c:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe000202060:	04040793          	addi	a5,s0,64
ffffffe000202064:	fcf43823          	sd	a5,-48(s0)
ffffffe000202068:	fd043783          	ld	a5,-48(s0)
ffffffe00020206c:	fc878793          	addi	a5,a5,-56
ffffffe000202070:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000202074:	fe043783          	ld	a5,-32(s0)
ffffffe000202078:	00078613          	mv	a2,a5
ffffffe00020207c:	fd843583          	ld	a1,-40(s0)
ffffffe000202080:	fffff517          	auipc	a0,0xfffff
ffffffe000202084:	0ec50513          	addi	a0,a0,236 # ffffffe00020116c <putc>
ffffffe000202088:	fb8ff0ef          	jal	ffffffe000201840 <vprintfmt>
ffffffe00020208c:	00050793          	mv	a5,a0
ffffffe000202090:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000202094:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202098:	00078513          	mv	a0,a5
ffffffe00020209c:	02813083          	ld	ra,40(sp)
ffffffe0002020a0:	02013403          	ld	s0,32(sp)
ffffffe0002020a4:	07010113          	addi	sp,sp,112
ffffffe0002020a8:	00008067          	ret

ffffffe0002020ac <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe0002020ac:	fe010113          	addi	sp,sp,-32
ffffffe0002020b0:	00113c23          	sd	ra,24(sp)
ffffffe0002020b4:	00813823          	sd	s0,16(sp)
ffffffe0002020b8:	02010413          	addi	s0,sp,32
ffffffe0002020bc:	00050793          	mv	a5,a0
ffffffe0002020c0:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe0002020c4:	fec42783          	lw	a5,-20(s0)
ffffffe0002020c8:	fff7879b          	addiw	a5,a5,-1
ffffffe0002020cc:	0007879b          	sext.w	a5,a5
ffffffe0002020d0:	02079713          	slli	a4,a5,0x20
ffffffe0002020d4:	02075713          	srli	a4,a4,0x20
ffffffe0002020d8:	00004797          	auipc	a5,0x4
ffffffe0002020dc:	f4078793          	addi	a5,a5,-192 # ffffffe000206018 <seed>
ffffffe0002020e0:	00e7b023          	sd	a4,0(a5)
}
ffffffe0002020e4:	00000013          	nop
ffffffe0002020e8:	01813083          	ld	ra,24(sp)
ffffffe0002020ec:	01013403          	ld	s0,16(sp)
ffffffe0002020f0:	02010113          	addi	sp,sp,32
ffffffe0002020f4:	00008067          	ret

ffffffe0002020f8 <rand>:

int rand(void) {
ffffffe0002020f8:	ff010113          	addi	sp,sp,-16
ffffffe0002020fc:	00113423          	sd	ra,8(sp)
ffffffe000202100:	00813023          	sd	s0,0(sp)
ffffffe000202104:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe000202108:	00004797          	auipc	a5,0x4
ffffffe00020210c:	f1078793          	addi	a5,a5,-240 # ffffffe000206018 <seed>
ffffffe000202110:	0007b703          	ld	a4,0(a5)
ffffffe000202114:	00001797          	auipc	a5,0x1
ffffffe000202118:	22478793          	addi	a5,a5,548 # ffffffe000203338 <lowerxdigits.0+0x18>
ffffffe00020211c:	0007b783          	ld	a5,0(a5)
ffffffe000202120:	02f707b3          	mul	a5,a4,a5
ffffffe000202124:	00178713          	addi	a4,a5,1
ffffffe000202128:	00004797          	auipc	a5,0x4
ffffffe00020212c:	ef078793          	addi	a5,a5,-272 # ffffffe000206018 <seed>
ffffffe000202130:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe000202134:	00004797          	auipc	a5,0x4
ffffffe000202138:	ee478793          	addi	a5,a5,-284 # ffffffe000206018 <seed>
ffffffe00020213c:	0007b783          	ld	a5,0(a5)
ffffffe000202140:	0217d793          	srli	a5,a5,0x21
ffffffe000202144:	0007879b          	sext.w	a5,a5
}
ffffffe000202148:	00078513          	mv	a0,a5
ffffffe00020214c:	00813083          	ld	ra,8(sp)
ffffffe000202150:	00013403          	ld	s0,0(sp)
ffffffe000202154:	01010113          	addi	sp,sp,16
ffffffe000202158:	00008067          	ret

ffffffe00020215c <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe00020215c:	fc010113          	addi	sp,sp,-64
ffffffe000202160:	02113c23          	sd	ra,56(sp)
ffffffe000202164:	02813823          	sd	s0,48(sp)
ffffffe000202168:	04010413          	addi	s0,sp,64
ffffffe00020216c:	fca43c23          	sd	a0,-40(s0)
ffffffe000202170:	00058793          	mv	a5,a1
ffffffe000202174:	fcc43423          	sd	a2,-56(s0)
ffffffe000202178:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe00020217c:	fd843783          	ld	a5,-40(s0)
ffffffe000202180:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202184:	fe043423          	sd	zero,-24(s0)
ffffffe000202188:	0280006f          	j	ffffffe0002021b0 <memset+0x54>
        s[i] = c;
ffffffe00020218c:	fe043703          	ld	a4,-32(s0)
ffffffe000202190:	fe843783          	ld	a5,-24(s0)
ffffffe000202194:	00f707b3          	add	a5,a4,a5
ffffffe000202198:	fd442703          	lw	a4,-44(s0)
ffffffe00020219c:	0ff77713          	zext.b	a4,a4
ffffffe0002021a0:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002021a4:	fe843783          	ld	a5,-24(s0)
ffffffe0002021a8:	00178793          	addi	a5,a5,1
ffffffe0002021ac:	fef43423          	sd	a5,-24(s0)
ffffffe0002021b0:	fe843703          	ld	a4,-24(s0)
ffffffe0002021b4:	fc843783          	ld	a5,-56(s0)
ffffffe0002021b8:	fcf76ae3          	bltu	a4,a5,ffffffe00020218c <memset+0x30>
    }
    return dest;
ffffffe0002021bc:	fd843783          	ld	a5,-40(s0)
}
ffffffe0002021c0:	00078513          	mv	a0,a5
ffffffe0002021c4:	03813083          	ld	ra,56(sp)
ffffffe0002021c8:	03013403          	ld	s0,48(sp)
ffffffe0002021cc:	04010113          	addi	sp,sp,64
ffffffe0002021d0:	00008067          	ret
