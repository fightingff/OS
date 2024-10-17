
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer
    80200000:	00004117          	auipc	sp,0x4
    80200004:	05013103          	ld	sp,80(sp) # 80204050 <_GLOBAL_OFFSET_TABLE_+0x18>

    call mm_init
    80200008:	3b0000ef          	jal	802003b8 <mm_init>
    call task_init
    8020000c:	3f0000ef          	jal	802003fc <task_init>

    la t0, _traps
    80200010:	00004297          	auipc	t0,0x4
    80200014:	0502b283          	ld	t0,80(t0) # 80204060 <_GLOBAL_OFFSET_TABLE_+0x28>
    csrw stvec, t0  # set stvec = _traps
    80200018:	10529073          	csrw	stvec,t0

    li t0, 32
    8020001c:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
    80200020:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
    80200024:	1f4000ef          	jal	80200218 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
    80200028:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
    8020002c:	1002a073          	csrs	sstatus,t0

    call start_kernel
    80200030:	6e9000ef          	jal	80200f18 <start_kernel>

0000000080200034 <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
    80200034:	ef810113          	addi	sp,sp,-264
    sd x0, 0(sp)
    80200038:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
    8020003c:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
    80200040:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
    80200044:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
    80200048:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
    8020004c:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
    80200050:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
    80200054:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
    80200058:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
    8020005c:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
    80200060:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
    80200064:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
    80200068:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
    8020006c:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
    80200070:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
    80200074:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
    80200078:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
    8020007c:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
    80200080:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
    80200084:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
    80200088:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
    8020008c:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
    80200090:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
    80200094:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
    80200098:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
    8020009c:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
    802000a0:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
    802000a4:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
    802000a8:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
    802000ac:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
    802000b0:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
    802000b4:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
    802000b8:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
    802000bc:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
    802000c0:	14202573          	csrr	a0,scause
    csrr a1, sepc
    802000c4:	141025f3          	csrr	a1,sepc
    call trap_handler
    802000c8:	5e9000ef          	jal	80200eb0 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
    802000cc:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
    802000d0:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
    802000d4:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
    802000d8:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
    802000dc:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
    802000e0:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
    802000e4:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
    802000e8:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
    802000ec:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
    802000f0:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
    802000f4:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
    802000f8:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
    802000fc:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
    80200100:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
    80200104:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
    80200108:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
    8020010c:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
    80200110:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
    80200114:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
    80200118:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
    8020011c:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
    80200120:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
    80200124:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
    80200128:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
    8020012c:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
    80200130:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
    80200134:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
    80200138:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
    8020013c:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
    80200140:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
    80200144:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
    80200148:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
    8020014c:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
    80200150:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
    80200154:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
    80200158:	10200073          	sret

000000008020015c <__dummy>:

    .extern dummy
    .globl __dummy
__dummy:
    # 将 sepc 设置为 dummy() 的地址，并使用 sret 从 S 模式中返回
    la t0, dummy
    8020015c:	00004297          	auipc	t0,0x4
    80200160:	efc2b283          	ld	t0,-260(t0) # 80204058 <_GLOBAL_OFFSET_TABLE_+0x20>
    csrw sepc, t0
    80200164:	14129073          	csrw	sepc,t0
    sret
    80200168:	10200073          	sret

000000008020016c <__switch_to>:

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
    8020016c:	02050513          	addi	a0,a0,32
    sd ra, 0(a0)
    80200170:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
    80200174:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
    80200178:	00853823          	sd	s0,16(a0)
    sd s1, 24(a0)
    8020017c:	00953c23          	sd	s1,24(a0)
    sd s2, 32(a0)
    80200180:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
    80200184:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
    80200188:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
    8020018c:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
    80200190:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
    80200194:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
    80200198:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
    8020019c:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
    802001a0:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
    802001a4:	07b53423          	sd	s11,104(a0)

    # restore state from next process
    add a1, a1, 32
    802001a8:	02058593          	addi	a1,a1,32
    ld ra, 0(a1)
    802001ac:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
    802001b0:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
    802001b4:	0105b403          	ld	s0,16(a1)
    ld s1, 24(a1)
    802001b8:	0185b483          	ld	s1,24(a1)
    ld s2, 32(a1)
    802001bc:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
    802001c0:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
    802001c4:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
    802001c8:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
    802001cc:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
    802001d0:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
    802001d4:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
    802001d8:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
    802001dc:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
    802001e0:	0685bd83          	ld	s11,104(a1)

    802001e4:	00008067          	ret

00000000802001e8 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
    802001e8:	fe010113          	addi	sp,sp,-32
    802001ec:	00113c23          	sd	ra,24(sp)
    802001f0:	00813823          	sd	s0,16(sp)
    802001f4:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
    802001f8:	c01027f3          	rdtime	a5
    802001fc:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
    80200200:	fe843783          	ld	a5,-24(s0)
}
    80200204:	00078513          	mv	a0,a5
    80200208:	01813083          	ld	ra,24(sp)
    8020020c:	01013403          	ld	s0,16(sp)
    80200210:	02010113          	addi	sp,sp,32
    80200214:	00008067          	ret

0000000080200218 <clock_set_next_event>:

void clock_set_next_event() {
    80200218:	fe010113          	addi	sp,sp,-32
    8020021c:	00113c23          	sd	ra,24(sp)
    80200220:	00813823          	sd	s0,16(sp)
    80200224:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
    80200228:	fc1ff0ef          	jal	802001e8 <get_cycles>
    8020022c:	00050713          	mv	a4,a0
    80200230:	00004797          	auipc	a5,0x4
    80200234:	dd078793          	addi	a5,a5,-560 # 80204000 <TIMECLOCK>
    80200238:	0007b783          	ld	a5,0(a5)
    8020023c:	00f707b3          	add	a5,a4,a5
    80200240:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    80200244:	fe843503          	ld	a0,-24(s0)
    80200248:	2b5000ef          	jal	80200cfc <sbi_set_timer>
    8020024c:	00000013          	nop
    80200250:	01813083          	ld	ra,24(sp)
    80200254:	01013403          	ld	s0,16(sp)
    80200258:	02010113          	addi	sp,sp,32
    8020025c:	00008067          	ret

0000000080200260 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
    80200260:	fe010113          	addi	sp,sp,-32
    80200264:	00113c23          	sd	ra,24(sp)
    80200268:	00813823          	sd	s0,16(sp)
    8020026c:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
    80200270:	00006797          	auipc	a5,0x6
    80200274:	d9078793          	addi	a5,a5,-624 # 80206000 <kmem>
    80200278:	0007b783          	ld	a5,0(a5)
    8020027c:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
    80200280:	fe843783          	ld	a5,-24(s0)
    80200284:	0007b703          	ld	a4,0(a5)
    80200288:	00006797          	auipc	a5,0x6
    8020028c:	d7878793          	addi	a5,a5,-648 # 80206000 <kmem>
    80200290:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
    80200294:	00001637          	lui	a2,0x1
    80200298:	00000593          	li	a1,0
    8020029c:	fe843503          	ld	a0,-24(s0)
    802002a0:	555010ef          	jal	80201ff4 <memset>
    return (void *)r;
    802002a4:	fe843783          	ld	a5,-24(s0)
}
    802002a8:	00078513          	mv	a0,a5
    802002ac:	01813083          	ld	ra,24(sp)
    802002b0:	01013403          	ld	s0,16(sp)
    802002b4:	02010113          	addi	sp,sp,32
    802002b8:	00008067          	ret

00000000802002bc <kfree>:

void kfree(void *addr) {
    802002bc:	fd010113          	addi	sp,sp,-48
    802002c0:	02113423          	sd	ra,40(sp)
    802002c4:	02813023          	sd	s0,32(sp)
    802002c8:	03010413          	addi	s0,sp,48
    802002cc:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
    802002d0:	fd843783          	ld	a5,-40(s0)
    802002d4:	00078693          	mv	a3,a5
    802002d8:	fd840793          	addi	a5,s0,-40
    802002dc:	fffff737          	lui	a4,0xfffff
    802002e0:	00e6f733          	and	a4,a3,a4
    802002e4:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
    802002e8:	fd843783          	ld	a5,-40(s0)
    802002ec:	00001637          	lui	a2,0x1
    802002f0:	00000593          	li	a1,0
    802002f4:	00078513          	mv	a0,a5
    802002f8:	4fd010ef          	jal	80201ff4 <memset>

    r = (struct run *)addr;
    802002fc:	fd843783          	ld	a5,-40(s0)
    80200300:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
    80200304:	00006797          	auipc	a5,0x6
    80200308:	cfc78793          	addi	a5,a5,-772 # 80206000 <kmem>
    8020030c:	0007b703          	ld	a4,0(a5)
    80200310:	fe843783          	ld	a5,-24(s0)
    80200314:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
    80200318:	00006797          	auipc	a5,0x6
    8020031c:	ce878793          	addi	a5,a5,-792 # 80206000 <kmem>
    80200320:	fe843703          	ld	a4,-24(s0)
    80200324:	00e7b023          	sd	a4,0(a5)

    return;
    80200328:	00000013          	nop
}
    8020032c:	02813083          	ld	ra,40(sp)
    80200330:	02013403          	ld	s0,32(sp)
    80200334:	03010113          	addi	sp,sp,48
    80200338:	00008067          	ret

000000008020033c <kfreerange>:

void kfreerange(char *start, char *end) {
    8020033c:	fd010113          	addi	sp,sp,-48
    80200340:	02113423          	sd	ra,40(sp)
    80200344:	02813023          	sd	s0,32(sp)
    80200348:	03010413          	addi	s0,sp,48
    8020034c:	fca43c23          	sd	a0,-40(s0)
    80200350:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
    80200354:	fd843703          	ld	a4,-40(s0)
    80200358:	000017b7          	lui	a5,0x1
    8020035c:	fff78793          	addi	a5,a5,-1 # fff <_skernel-0x801ff001>
    80200360:	00f70733          	add	a4,a4,a5
    80200364:	fffff7b7          	lui	a5,0xfffff
    80200368:	00f777b3          	and	a5,a4,a5
    8020036c:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    80200370:	01c0006f          	j	8020038c <kfreerange+0x50>
        kfree((void *)addr);
    80200374:	fe843503          	ld	a0,-24(s0)
    80200378:	f45ff0ef          	jal	802002bc <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    8020037c:	fe843703          	ld	a4,-24(s0)
    80200380:	000017b7          	lui	a5,0x1
    80200384:	00f707b3          	add	a5,a4,a5
    80200388:	fef43423          	sd	a5,-24(s0)
    8020038c:	fe843703          	ld	a4,-24(s0)
    80200390:	000017b7          	lui	a5,0x1
    80200394:	00f70733          	add	a4,a4,a5
    80200398:	fd043783          	ld	a5,-48(s0)
    8020039c:	fce7fce3          	bgeu	a5,a4,80200374 <kfreerange+0x38>
    }
}
    802003a0:	00000013          	nop
    802003a4:	00000013          	nop
    802003a8:	02813083          	ld	ra,40(sp)
    802003ac:	02013403          	ld	s0,32(sp)
    802003b0:	03010113          	addi	sp,sp,48
    802003b4:	00008067          	ret

00000000802003b8 <mm_init>:

void mm_init(void) {
    802003b8:	ff010113          	addi	sp,sp,-16
    802003bc:	00113423          	sd	ra,8(sp)
    802003c0:	00813023          	sd	s0,0(sp)
    802003c4:	01010413          	addi	s0,sp,16
    kfreerange(_ekernel, (char *)PHY_END);
    802003c8:	01100793          	li	a5,17
    802003cc:	01b79593          	slli	a1,a5,0x1b
    802003d0:	00004517          	auipc	a0,0x4
    802003d4:	c7053503          	ld	a0,-912(a0) # 80204040 <_GLOBAL_OFFSET_TABLE_+0x8>
    802003d8:	f65ff0ef          	jal	8020033c <kfreerange>
    printk("...mm_init done!\n");
    802003dc:	00003517          	auipc	a0,0x3
    802003e0:	c2450513          	addi	a0,a0,-988 # 80203000 <_srodata>
    802003e4:	2e1010ef          	jal	80201ec4 <printk>
}
    802003e8:	00000013          	nop
    802003ec:	00813083          	ld	ra,8(sp)
    802003f0:	00013403          	ld	s0,0(sp)
    802003f4:	01010113          	addi	sp,sp,16
    802003f8:	00008067          	ret

00000000802003fc <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
    802003fc:	fe010113          	addi	sp,sp,-32
    80200400:	00113c23          	sd	ra,24(sp)
    80200404:	00813823          	sd	s0,16(sp)
    80200408:	02010413          	addi	s0,sp,32
    srand(2024);
    8020040c:	7e800513          	li	a0,2024
    80200410:	335010ef          	jal	80201f44 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
    80200414:	e4dff0ef          	jal	80200260 <kalloc>
    80200418:	00050713          	mv	a4,a0
    8020041c:	00006797          	auipc	a5,0x6
    80200420:	bec78793          	addi	a5,a5,-1044 # 80206008 <idle>
    80200424:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
    80200428:	00006797          	auipc	a5,0x6
    8020042c:	be078793          	addi	a5,a5,-1056 # 80206008 <idle>
    80200430:	0007b783          	ld	a5,0(a5)
    80200434:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
    80200438:	00006797          	auipc	a5,0x6
    8020043c:	bd078793          	addi	a5,a5,-1072 # 80206008 <idle>
    80200440:	0007b783          	ld	a5,0(a5)
    80200444:	0007b823          	sd	zero,16(a5)
    80200448:	00006717          	auipc	a4,0x6
    8020044c:	bc070713          	addi	a4,a4,-1088 # 80206008 <idle>
    80200450:	00073703          	ld	a4,0(a4)
    80200454:	0107b783          	ld	a5,16(a5)
    80200458:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
    8020045c:	00006797          	auipc	a5,0x6
    80200460:	bac78793          	addi	a5,a5,-1108 # 80206008 <idle>
    80200464:	0007b783          	ld	a5,0(a5)
    80200468:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
    8020046c:	00006797          	auipc	a5,0x6
    80200470:	b9c78793          	addi	a5,a5,-1124 # 80206008 <idle>
    80200474:	0007b703          	ld	a4,0(a5)
    80200478:	00006797          	auipc	a5,0x6
    8020047c:	ba078793          	addi	a5,a5,-1120 # 80206018 <task>
    80200480:	00e7b023          	sd	a4,0(a5)
    80200484:	00006797          	auipc	a5,0x6
    80200488:	b9478793          	addi	a5,a5,-1132 # 80206018 <task>
    8020048c:	0007b703          	ld	a4,0(a5)
    80200490:	00006797          	auipc	a5,0x6
    80200494:	b8078793          	addi	a5,a5,-1152 # 80206010 <current>
    80200498:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
    8020049c:	00100793          	li	a5,1
    802004a0:	fef42623          	sw	a5,-20(s0)
    802004a4:	1600006f          	j	80200604 <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
    802004a8:	db9ff0ef          	jal	80200260 <kalloc>
    802004ac:	00050693          	mv	a3,a0
    802004b0:	00006717          	auipc	a4,0x6
    802004b4:	b6870713          	addi	a4,a4,-1176 # 80206018 <task>
    802004b8:	fec42783          	lw	a5,-20(s0)
    802004bc:	00379793          	slli	a5,a5,0x3
    802004c0:	00f707b3          	add	a5,a4,a5
    802004c4:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
    802004c8:	00006717          	auipc	a4,0x6
    802004cc:	b5070713          	addi	a4,a4,-1200 # 80206018 <task>
    802004d0:	fec42783          	lw	a5,-20(s0)
    802004d4:	00379793          	slli	a5,a5,0x3
    802004d8:	00f707b3          	add	a5,a4,a5
    802004dc:	0007b783          	ld	a5,0(a5)
    802004e0:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
    802004e4:	00006717          	auipc	a4,0x6
    802004e8:	b3470713          	addi	a4,a4,-1228 # 80206018 <task>
    802004ec:	fec42783          	lw	a5,-20(s0)
    802004f0:	00379793          	slli	a5,a5,0x3
    802004f4:	00f707b3          	add	a5,a4,a5
    802004f8:	0007b783          	ld	a5,0(a5)
    802004fc:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
    80200500:	291010ef          	jal	80201f90 <rand>
    80200504:	00050793          	mv	a5,a0
    80200508:	00078713          	mv	a4,a5
    8020050c:	0007069b          	sext.w	a3,a4
    80200510:	666667b7          	lui	a5,0x66666
    80200514:	66778793          	addi	a5,a5,1639 # 66666667 <_skernel-0x19b99999>
    80200518:	02f687b3          	mul	a5,a3,a5
    8020051c:	0207d793          	srli	a5,a5,0x20
    80200520:	4027d79b          	sraiw	a5,a5,0x2
    80200524:	00078693          	mv	a3,a5
    80200528:	41f7579b          	sraiw	a5,a4,0x1f
    8020052c:	40f687bb          	subw	a5,a3,a5
    80200530:	00078693          	mv	a3,a5
    80200534:	00068793          	mv	a5,a3
    80200538:	0027979b          	slliw	a5,a5,0x2
    8020053c:	00d787bb          	addw	a5,a5,a3
    80200540:	0017979b          	slliw	a5,a5,0x1
    80200544:	40f707bb          	subw	a5,a4,a5
    80200548:	0007879b          	sext.w	a5,a5
    8020054c:	0017879b          	addiw	a5,a5,1
    80200550:	0007869b          	sext.w	a3,a5
    80200554:	00006717          	auipc	a4,0x6
    80200558:	ac470713          	addi	a4,a4,-1340 # 80206018 <task>
    8020055c:	fec42783          	lw	a5,-20(s0)
    80200560:	00379793          	slli	a5,a5,0x3
    80200564:	00f707b3          	add	a5,a4,a5
    80200568:	0007b783          	ld	a5,0(a5)
    8020056c:	00068713          	mv	a4,a3
    80200570:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
    80200574:	00006717          	auipc	a4,0x6
    80200578:	aa470713          	addi	a4,a4,-1372 # 80206018 <task>
    8020057c:	fec42783          	lw	a5,-20(s0)
    80200580:	00379793          	slli	a5,a5,0x3
    80200584:	00f707b3          	add	a5,a4,a5
    80200588:	0007b783          	ld	a5,0(a5)
    8020058c:	fec42703          	lw	a4,-20(s0)
    80200590:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
    80200594:	00006717          	auipc	a4,0x6
    80200598:	a8470713          	addi	a4,a4,-1404 # 80206018 <task>
    8020059c:	fec42783          	lw	a5,-20(s0)
    802005a0:	00379793          	slli	a5,a5,0x3
    802005a4:	00f707b3          	add	a5,a4,a5
    802005a8:	0007b783          	ld	a5,0(a5)
    802005ac:	00004717          	auipc	a4,0x4
    802005b0:	a9c73703          	ld	a4,-1380(a4) # 80204048 <_GLOBAL_OFFSET_TABLE_+0x10>
    802005b4:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
    802005b8:	00006717          	auipc	a4,0x6
    802005bc:	a6070713          	addi	a4,a4,-1440 # 80206018 <task>
    802005c0:	fec42783          	lw	a5,-20(s0)
    802005c4:	00379793          	slli	a5,a5,0x3
    802005c8:	00f707b3          	add	a5,a4,a5
    802005cc:	0007b783          	ld	a5,0(a5)
    802005d0:	00078693          	mv	a3,a5
    802005d4:	00006717          	auipc	a4,0x6
    802005d8:	a4470713          	addi	a4,a4,-1468 # 80206018 <task>
    802005dc:	fec42783          	lw	a5,-20(s0)
    802005e0:	00379793          	slli	a5,a5,0x3
    802005e4:	00f707b3          	add	a5,a4,a5
    802005e8:	0007b783          	ld	a5,0(a5)
    802005ec:	00001737          	lui	a4,0x1
    802005f0:	00e68733          	add	a4,a3,a4
    802005f4:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
    802005f8:	fec42783          	lw	a5,-20(s0)
    802005fc:	0017879b          	addiw	a5,a5,1
    80200600:	fef42623          	sw	a5,-20(s0)
    80200604:	fec42783          	lw	a5,-20(s0)
    80200608:	0007871b          	sext.w	a4,a5
    8020060c:	00400793          	li	a5,4
    80200610:	e8e7dce3          	bge	a5,a4,802004a8 <task_init+0xac>
    }
    printk("...task_init done!\n");
    80200614:	00003517          	auipc	a0,0x3
    80200618:	a0450513          	addi	a0,a0,-1532 # 80203018 <_srodata+0x18>
    8020061c:	0a9010ef          	jal	80201ec4 <printk>
}
    80200620:	00000013          	nop
    80200624:	01813083          	ld	ra,24(sp)
    80200628:	01013403          	ld	s0,16(sp)
    8020062c:	02010113          	addi	sp,sp,32
    80200630:	00008067          	ret

0000000080200634 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    80200634:	fd010113          	addi	sp,sp,-48
    80200638:	02113423          	sd	ra,40(sp)
    8020063c:	02813023          	sd	s0,32(sp)
    80200640:	03010413          	addi	s0,sp,48
    uint64_t MOD = 1000000007;
    80200644:	3b9ad7b7          	lui	a5,0x3b9ad
    80200648:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <_skernel-0x448535f9>
    8020064c:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
    80200650:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
    80200654:	fff00793          	li	a5,-1
    80200658:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    8020065c:	fe442783          	lw	a5,-28(s0)
    80200660:	0007871b          	sext.w	a4,a5
    80200664:	fff00793          	li	a5,-1
    80200668:	00f70e63          	beq	a4,a5,80200684 <dummy+0x50>
    8020066c:	00006797          	auipc	a5,0x6
    80200670:	9a478793          	addi	a5,a5,-1628 # 80206010 <current>
    80200674:	0007b783          	ld	a5,0(a5)
    80200678:	0087b703          	ld	a4,8(a5)
    8020067c:	fe442783          	lw	a5,-28(s0)
    80200680:	fcf70ee3          	beq	a4,a5,8020065c <dummy+0x28>
    80200684:	00006797          	auipc	a5,0x6
    80200688:	98c78793          	addi	a5,a5,-1652 # 80206010 <current>
    8020068c:	0007b783          	ld	a5,0(a5)
    80200690:	0087b783          	ld	a5,8(a5)
    80200694:	fc0784e3          	beqz	a5,8020065c <dummy+0x28>
            if (current->counter == 1) {
    80200698:	00006797          	auipc	a5,0x6
    8020069c:	97878793          	addi	a5,a5,-1672 # 80206010 <current>
    802006a0:	0007b783          	ld	a5,0(a5)
    802006a4:	0087b703          	ld	a4,8(a5)
    802006a8:	00100793          	li	a5,1
    802006ac:	00f71e63          	bne	a4,a5,802006c8 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
    802006b0:	00006797          	auipc	a5,0x6
    802006b4:	96078793          	addi	a5,a5,-1696 # 80206010 <current>
    802006b8:	0007b783          	ld	a5,0(a5)
    802006bc:	0087b703          	ld	a4,8(a5)
    802006c0:	fff70713          	addi	a4,a4,-1 # fff <_skernel-0x801ff001>
    802006c4:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
    802006c8:	00006797          	auipc	a5,0x6
    802006cc:	94878793          	addi	a5,a5,-1720 # 80206010 <current>
    802006d0:	0007b783          	ld	a5,0(a5)
    802006d4:	0087b783          	ld	a5,8(a5)
    802006d8:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
    802006dc:	fe843783          	ld	a5,-24(s0)
    802006e0:	00178713          	addi	a4,a5,1
    802006e4:	fd843783          	ld	a5,-40(s0)
    802006e8:	02f777b3          	remu	a5,a4,a5
    802006ec:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
    802006f0:	00006797          	auipc	a5,0x6
    802006f4:	92078793          	addi	a5,a5,-1760 # 80206010 <current>
    802006f8:	0007b783          	ld	a5,0(a5)
    802006fc:	0187b783          	ld	a5,24(a5)
    80200700:	fe843603          	ld	a2,-24(s0)
    80200704:	00078593          	mv	a1,a5
    80200708:	00003517          	auipc	a0,0x3
    8020070c:	92850513          	addi	a0,a0,-1752 # 80203030 <_srodata+0x30>
    80200710:	7b4010ef          	jal	80201ec4 <printk>
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
    80200714:	00006797          	auipc	a5,0x6
    80200718:	8fc78793          	addi	a5,a5,-1796 # 80206010 <current>
    8020071c:	0007b783          	ld	a5,0(a5)
    80200720:	0187b783          	ld	a5,24(a5)
    80200724:	0ff7f713          	zext.b	a4,a5
    80200728:	00006797          	auipc	a5,0x6
    8020072c:	94078793          	addi	a5,a5,-1728 # 80206068 <tasks_output_index>
    80200730:	0007a783          	lw	a5,0(a5)
    80200734:	0017869b          	addiw	a3,a5,1
    80200738:	0006861b          	sext.w	a2,a3
    8020073c:	00006697          	auipc	a3,0x6
    80200740:	92c68693          	addi	a3,a3,-1748 # 80206068 <tasks_output_index>
    80200744:	00c6a023          	sw	a2,0(a3)
    80200748:	0307071b          	addiw	a4,a4,48
    8020074c:	0ff77713          	zext.b	a4,a4
    80200750:	00006697          	auipc	a3,0x6
    80200754:	8f068693          	addi	a3,a3,-1808 # 80206040 <tasks_output>
    80200758:	00f687b3          	add	a5,a3,a5
    8020075c:	00e78023          	sb	a4,0(a5)
            if (tasks_output_index == MAX_OUTPUT) {
    80200760:	00006797          	auipc	a5,0x6
    80200764:	90878793          	addi	a5,a5,-1784 # 80206068 <tasks_output_index>
    80200768:	0007a703          	lw	a4,0(a5)
    8020076c:	02800793          	li	a5,40
    80200770:	eef716e3          	bne	a4,a5,8020065c <dummy+0x28>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
    80200774:	fe042023          	sw	zero,-32(s0)
    80200778:	0800006f          	j	802007f8 <dummy+0x1c4>
                    if (tasks_output[i] != expected_output[i]) {
    8020077c:	00006717          	auipc	a4,0x6
    80200780:	8c470713          	addi	a4,a4,-1852 # 80206040 <tasks_output>
    80200784:	fe042783          	lw	a5,-32(s0)
    80200788:	00f707b3          	add	a5,a4,a5
    8020078c:	0007c683          	lbu	a3,0(a5)
    80200790:	00004717          	auipc	a4,0x4
    80200794:	87870713          	addi	a4,a4,-1928 # 80204008 <expected_output>
    80200798:	fe042783          	lw	a5,-32(s0)
    8020079c:	00f707b3          	add	a5,a4,a5
    802007a0:	0007c783          	lbu	a5,0(a5)
    802007a4:	00068713          	mv	a4,a3
    802007a8:	04f70263          	beq	a4,a5,802007ec <dummy+0x1b8>
                        printk("\033[31mTest failed!\033[0m\n");
    802007ac:	00003517          	auipc	a0,0x3
    802007b0:	8b450513          	addi	a0,a0,-1868 # 80203060 <_srodata+0x60>
    802007b4:	710010ef          	jal	80201ec4 <printk>
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
    802007b8:	00004597          	auipc	a1,0x4
    802007bc:	85058593          	addi	a1,a1,-1968 # 80204008 <expected_output>
    802007c0:	00003517          	auipc	a0,0x3
    802007c4:	8b850513          	addi	a0,a0,-1864 # 80203078 <_srodata+0x78>
    802007c8:	6fc010ef          	jal	80201ec4 <printk>
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
    802007cc:	00006597          	auipc	a1,0x6
    802007d0:	87458593          	addi	a1,a1,-1932 # 80206040 <tasks_output>
    802007d4:	00003517          	auipc	a0,0x3
    802007d8:	8c450513          	addi	a0,a0,-1852 # 80203098 <_srodata+0x98>
    802007dc:	6e8010ef          	jal	80201ec4 <printk>
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    802007e0:	00000593          	li	a1,0
    802007e4:	00000513          	li	a0,0
    802007e8:	478000ef          	jal	80200c60 <sbi_system_reset>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
    802007ec:	fe042783          	lw	a5,-32(s0)
    802007f0:	0017879b          	addiw	a5,a5,1
    802007f4:	fef42023          	sw	a5,-32(s0)
    802007f8:	fe042783          	lw	a5,-32(s0)
    802007fc:	0007871b          	sext.w	a4,a5
    80200800:	02700793          	li	a5,39
    80200804:	f6e7dce3          	bge	a5,a4,8020077c <dummy+0x148>
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
    80200808:	00003517          	auipc	a0,0x3
    8020080c:	8b050513          	addi	a0,a0,-1872 # 802030b8 <_srodata+0xb8>
    80200810:	6b4010ef          	jal	80201ec4 <printk>
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
    80200814:	00003597          	auipc	a1,0x3
    80200818:	7f458593          	addi	a1,a1,2036 # 80204008 <expected_output>
    8020081c:	00003517          	auipc	a0,0x3
    80200820:	8b450513          	addi	a0,a0,-1868 # 802030d0 <_srodata+0xd0>
    80200824:	6a0010ef          	jal	80201ec4 <printk>
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200828:	00000593          	li	a1,0
    8020082c:	00000513          	li	a0,0
    80200830:	430000ef          	jal	80200c60 <sbi_system_reset>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200834:	e29ff06f          	j	8020065c <dummy+0x28>

0000000080200838 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    80200838:	fd010113          	addi	sp,sp,-48
    8020083c:	02113423          	sd	ra,40(sp)
    80200840:	02813023          	sd	s0,32(sp)
    80200844:	03010413          	addi	s0,sp,48
    80200848:	fca43c23          	sd	a0,-40(s0)
    if(current->pid != next->pid) {
    8020084c:	00005797          	auipc	a5,0x5
    80200850:	7c478793          	addi	a5,a5,1988 # 80206010 <current>
    80200854:	0007b783          	ld	a5,0(a5)
    80200858:	0187b703          	ld	a4,24(a5)
    8020085c:	fd843783          	ld	a5,-40(s0)
    80200860:	0187b783          	ld	a5,24(a5)
    80200864:	06f70a63          	beq	a4,a5,802008d8 <switch_to+0xa0>
        struct task_struct *prev = current;
    80200868:	00005797          	auipc	a5,0x5
    8020086c:	7a878793          	addi	a5,a5,1960 # 80206010 <current>
    80200870:	0007b783          	ld	a5,0(a5)
    80200874:	fef43423          	sd	a5,-24(s0)
        current = next;
    80200878:	00005797          	auipc	a5,0x5
    8020087c:	79878793          	addi	a5,a5,1944 # 80206010 <current>
    80200880:	fd843703          	ld	a4,-40(s0)
    80200884:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
    80200888:	00005797          	auipc	a5,0x5
    8020088c:	78878793          	addi	a5,a5,1928 # 80206010 <current>
    80200890:	0007b783          	ld	a5,0(a5)
    80200894:	0187b703          	ld	a4,24(a5)
    80200898:	00005797          	auipc	a5,0x5
    8020089c:	77878793          	addi	a5,a5,1912 # 80206010 <current>
    802008a0:	0007b783          	ld	a5,0(a5)
    802008a4:	0107b603          	ld	a2,16(a5)
    802008a8:	00005797          	auipc	a5,0x5
    802008ac:	76878793          	addi	a5,a5,1896 # 80206010 <current>
    802008b0:	0007b783          	ld	a5,0(a5)
    802008b4:	0087b783          	ld	a5,8(a5)
    802008b8:	00078693          	mv	a3,a5
    802008bc:	00070593          	mv	a1,a4
    802008c0:	00003517          	auipc	a0,0x3
    802008c4:	83050513          	addi	a0,a0,-2000 # 802030f0 <_srodata+0xf0>
    802008c8:	5fc010ef          	jal	80201ec4 <printk>
        __switch_to(prev, next);
    802008cc:	fd843583          	ld	a1,-40(s0)
    802008d0:	fe843503          	ld	a0,-24(s0)
    802008d4:	899ff0ef          	jal	8020016c <__switch_to>
    }
}
    802008d8:	00000013          	nop
    802008dc:	02813083          	ld	ra,40(sp)
    802008e0:	02013403          	ld	s0,32(sp)
    802008e4:	03010113          	addi	sp,sp,48
    802008e8:	00008067          	ret

00000000802008ec <do_timer>:

void do_timer() {
    802008ec:	ff010113          	addi	sp,sp,-16
    802008f0:	00113423          	sd	ra,8(sp)
    802008f4:	00813023          	sd	s0,0(sp)
    802008f8:	01010413          	addi	s0,sp,16
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
    802008fc:	00005797          	auipc	a5,0x5
    80200900:	71478793          	addi	a5,a5,1812 # 80206010 <current>
    80200904:	0007b783          	ld	a5,0(a5)
    80200908:	0187b703          	ld	a4,24(a5)
    8020090c:	00005797          	auipc	a5,0x5
    80200910:	6fc78793          	addi	a5,a5,1788 # 80206008 <idle>
    80200914:	0007b783          	ld	a5,0(a5)
    80200918:	0187b783          	ld	a5,24(a5)
    8020091c:	00f70c63          	beq	a4,a5,80200934 <do_timer+0x48>
    80200920:	00005797          	auipc	a5,0x5
    80200924:	6f078793          	addi	a5,a5,1776 # 80206010 <current>
    80200928:	0007b783          	ld	a5,0(a5)
    8020092c:	0087b783          	ld	a5,8(a5)
    80200930:	00079663          	bnez	a5,8020093c <do_timer+0x50>
        schedule();
    80200934:	038000ef          	jal	8020096c <schedule>
    80200938:	0200006f          	j	80200958 <do_timer+0x6c>
    }
    else --(current->counter);
    8020093c:	00005797          	auipc	a5,0x5
    80200940:	6d478793          	addi	a5,a5,1748 # 80206010 <current>
    80200944:	0007b783          	ld	a5,0(a5)
    80200948:	0087b703          	ld	a4,8(a5)
    8020094c:	fff70713          	addi	a4,a4,-1
    80200950:	00e7b423          	sd	a4,8(a5)
}
    80200954:	00000013          	nop
    80200958:	00000013          	nop
    8020095c:	00813083          	ld	ra,8(sp)
    80200960:	00013403          	ld	s0,0(sp)
    80200964:	01010113          	addi	sp,sp,16
    80200968:	00008067          	ret

000000008020096c <schedule>:

void schedule() {
    8020096c:	fe010113          	addi	sp,sp,-32
    80200970:	00113c23          	sd	ra,24(sp)
    80200974:	00813823          	sd	s0,16(sp)
    80200978:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    struct task_struct *next = idle;
    8020097c:	00005797          	auipc	a5,0x5
    80200980:	68c78793          	addi	a5,a5,1676 # 80206008 <idle>
    80200984:	0007b783          	ld	a5,0(a5)
    80200988:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    8020098c:	00100793          	li	a5,1
    80200990:	fef42223          	sw	a5,-28(s0)
    80200994:	0540006f          	j	802009e8 <schedule+0x7c>
        if(task[i]->counter > next->counter){
    80200998:	00005717          	auipc	a4,0x5
    8020099c:	68070713          	addi	a4,a4,1664 # 80206018 <task>
    802009a0:	fe442783          	lw	a5,-28(s0)
    802009a4:	00379793          	slli	a5,a5,0x3
    802009a8:	00f707b3          	add	a5,a4,a5
    802009ac:	0007b783          	ld	a5,0(a5)
    802009b0:	0087b703          	ld	a4,8(a5)
    802009b4:	fe843783          	ld	a5,-24(s0)
    802009b8:	0087b783          	ld	a5,8(a5)
    802009bc:	02e7f063          	bgeu	a5,a4,802009dc <schedule+0x70>
            next = task[i];
    802009c0:	00005717          	auipc	a4,0x5
    802009c4:	65870713          	addi	a4,a4,1624 # 80206018 <task>
    802009c8:	fe442783          	lw	a5,-28(s0)
    802009cc:	00379793          	slli	a5,a5,0x3
    802009d0:	00f707b3          	add	a5,a4,a5
    802009d4:	0007b783          	ld	a5,0(a5)
    802009d8:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    802009dc:	fe442783          	lw	a5,-28(s0)
    802009e0:	0017879b          	addiw	a5,a5,1
    802009e4:	fef42223          	sw	a5,-28(s0)
    802009e8:	fe442783          	lw	a5,-28(s0)
    802009ec:	0007871b          	sext.w	a4,a5
    802009f0:	00400793          	li	a5,4
    802009f4:	fae7d2e3          	bge	a5,a4,80200998 <schedule+0x2c>
        }
    }

    if(next->counter == 0) {
    802009f8:	fe843783          	ld	a5,-24(s0)
    802009fc:	0087b783          	ld	a5,8(a5)
    80200a00:	0c079e63          	bnez	a5,80200adc <schedule+0x170>
        printk("\n");
    80200a04:	00002517          	auipc	a0,0x2
    80200a08:	72450513          	addi	a0,a0,1828 # 80203128 <_srodata+0x128>
    80200a0c:	4b8010ef          	jal	80201ec4 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
    80200a10:	00100793          	li	a5,1
    80200a14:	fef42023          	sw	a5,-32(s0)
    80200a18:	0ac0006f          	j	80200ac4 <schedule+0x158>
            task[i]->counter = task[i]->priority;
    80200a1c:	00005717          	auipc	a4,0x5
    80200a20:	5fc70713          	addi	a4,a4,1532 # 80206018 <task>
    80200a24:	fe042783          	lw	a5,-32(s0)
    80200a28:	00379793          	slli	a5,a5,0x3
    80200a2c:	00f707b3          	add	a5,a4,a5
    80200a30:	0007b703          	ld	a4,0(a5)
    80200a34:	00005697          	auipc	a3,0x5
    80200a38:	5e468693          	addi	a3,a3,1508 # 80206018 <task>
    80200a3c:	fe042783          	lw	a5,-32(s0)
    80200a40:	00379793          	slli	a5,a5,0x3
    80200a44:	00f687b3          	add	a5,a3,a5
    80200a48:	0007b783          	ld	a5,0(a5)
    80200a4c:	01073703          	ld	a4,16(a4)
    80200a50:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
    80200a54:	00005717          	auipc	a4,0x5
    80200a58:	5c470713          	addi	a4,a4,1476 # 80206018 <task>
    80200a5c:	fe042783          	lw	a5,-32(s0)
    80200a60:	00379793          	slli	a5,a5,0x3
    80200a64:	00f707b3          	add	a5,a4,a5
    80200a68:	0007b783          	ld	a5,0(a5)
    80200a6c:	0187b583          	ld	a1,24(a5)
    80200a70:	00005717          	auipc	a4,0x5
    80200a74:	5a870713          	addi	a4,a4,1448 # 80206018 <task>
    80200a78:	fe042783          	lw	a5,-32(s0)
    80200a7c:	00379793          	slli	a5,a5,0x3
    80200a80:	00f707b3          	add	a5,a4,a5
    80200a84:	0007b783          	ld	a5,0(a5)
    80200a88:	0107b603          	ld	a2,16(a5)
    80200a8c:	00005717          	auipc	a4,0x5
    80200a90:	58c70713          	addi	a4,a4,1420 # 80206018 <task>
    80200a94:	fe042783          	lw	a5,-32(s0)
    80200a98:	00379793          	slli	a5,a5,0x3
    80200a9c:	00f707b3          	add	a5,a4,a5
    80200aa0:	0007b783          	ld	a5,0(a5)
    80200aa4:	0087b783          	ld	a5,8(a5)
    80200aa8:	00078693          	mv	a3,a5
    80200aac:	00002517          	auipc	a0,0x2
    80200ab0:	68450513          	addi	a0,a0,1668 # 80203130 <_srodata+0x130>
    80200ab4:	410010ef          	jal	80201ec4 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
    80200ab8:	fe042783          	lw	a5,-32(s0)
    80200abc:	0017879b          	addiw	a5,a5,1
    80200ac0:	fef42023          	sw	a5,-32(s0)
    80200ac4:	fe042783          	lw	a5,-32(s0)
    80200ac8:	0007871b          	sext.w	a4,a5
    80200acc:	00400793          	li	a5,4
    80200ad0:	f4e7d6e3          	bge	a5,a4,80200a1c <schedule+0xb0>
        }
        return (void)(schedule());
    80200ad4:	e99ff0ef          	jal	8020096c <schedule>
    80200ad8:	00c0006f          	j	80200ae4 <schedule+0x178>
    }

    switch_to(next);
    80200adc:	fe843503          	ld	a0,-24(s0)
    80200ae0:	d59ff0ef          	jal	80200838 <switch_to>
    80200ae4:	01813083          	ld	ra,24(sp)
    80200ae8:	01013403          	ld	s0,16(sp)
    80200aec:	02010113          	addi	sp,sp,32
    80200af0:	00008067          	ret

0000000080200af4 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    80200af4:	f7010113          	addi	sp,sp,-144
    80200af8:	08113423          	sd	ra,136(sp)
    80200afc:	08813023          	sd	s0,128(sp)
    80200b00:	06913c23          	sd	s1,120(sp)
    80200b04:	07213823          	sd	s2,112(sp)
    80200b08:	07313423          	sd	s3,104(sp)
    80200b0c:	09010413          	addi	s0,sp,144
    80200b10:	faa43423          	sd	a0,-88(s0)
    80200b14:	fab43023          	sd	a1,-96(s0)
    80200b18:	f8c43c23          	sd	a2,-104(s0)
    80200b1c:	f8d43823          	sd	a3,-112(s0)
    80200b20:	f8e43423          	sd	a4,-120(s0)
    80200b24:	f8f43023          	sd	a5,-128(s0)
    80200b28:	f7043c23          	sd	a6,-136(s0)
    80200b2c:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    80200b30:	fa843e03          	ld	t3,-88(s0)
    80200b34:	fa043e83          	ld	t4,-96(s0)
    80200b38:	f9843f03          	ld	t5,-104(s0)
    80200b3c:	f9043f83          	ld	t6,-112(s0)
    80200b40:	f8843283          	ld	t0,-120(s0)
    80200b44:	f8043483          	ld	s1,-128(s0)
    80200b48:	f7843903          	ld	s2,-136(s0)
    80200b4c:	f7043983          	ld	s3,-144(s0)
    80200b50:	000e0893          	mv	a7,t3
    80200b54:	000e8813          	mv	a6,t4
    80200b58:	000f0513          	mv	a0,t5
    80200b5c:	000f8593          	mv	a1,t6
    80200b60:	00028613          	mv	a2,t0
    80200b64:	00048693          	mv	a3,s1
    80200b68:	00090713          	mv	a4,s2
    80200b6c:	00098793          	mv	a5,s3
    80200b70:	00000073          	ecall
    80200b74:	00050e93          	mv	t4,a0
    80200b78:	00058e13          	mv	t3,a1
    80200b7c:	fbd43823          	sd	t4,-80(s0)
    80200b80:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    80200b84:	fb043783          	ld	a5,-80(s0)
    80200b88:	fcf43023          	sd	a5,-64(s0)
    80200b8c:	fb843783          	ld	a5,-72(s0)
    80200b90:	fcf43423          	sd	a5,-56(s0)
    80200b94:	fc043703          	ld	a4,-64(s0)
    80200b98:	fc843783          	ld	a5,-56(s0)
    80200b9c:	00070313          	mv	t1,a4
    80200ba0:	00078393          	mv	t2,a5
    80200ba4:	00030713          	mv	a4,t1
    80200ba8:	00038793          	mv	a5,t2
}
    80200bac:	00070513          	mv	a0,a4
    80200bb0:	00078593          	mv	a1,a5
    80200bb4:	08813083          	ld	ra,136(sp)
    80200bb8:	08013403          	ld	s0,128(sp)
    80200bbc:	07813483          	ld	s1,120(sp)
    80200bc0:	07013903          	ld	s2,112(sp)
    80200bc4:	06813983          	ld	s3,104(sp)
    80200bc8:	09010113          	addi	sp,sp,144
    80200bcc:	00008067          	ret

0000000080200bd0 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    80200bd0:	fc010113          	addi	sp,sp,-64
    80200bd4:	02113c23          	sd	ra,56(sp)
    80200bd8:	02813823          	sd	s0,48(sp)
    80200bdc:	03213423          	sd	s2,40(sp)
    80200be0:	03313023          	sd	s3,32(sp)
    80200be4:	04010413          	addi	s0,sp,64
    80200be8:	00050793          	mv	a5,a0
    80200bec:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200bf0:	fcf44603          	lbu	a2,-49(s0)
    80200bf4:	00000893          	li	a7,0
    80200bf8:	00000813          	li	a6,0
    80200bfc:	00000793          	li	a5,0
    80200c00:	00000713          	li	a4,0
    80200c04:	00000693          	li	a3,0
    80200c08:	00200593          	li	a1,2
    80200c0c:	44424537          	lui	a0,0x44424
    80200c10:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200c14:	ee1ff0ef          	jal	80200af4 <sbi_ecall>
    80200c18:	00050713          	mv	a4,a0
    80200c1c:	00058793          	mv	a5,a1
    80200c20:	fce43823          	sd	a4,-48(s0)
    80200c24:	fcf43c23          	sd	a5,-40(s0)
    80200c28:	fd043703          	ld	a4,-48(s0)
    80200c2c:	fd843783          	ld	a5,-40(s0)
    80200c30:	00070913          	mv	s2,a4
    80200c34:	00078993          	mv	s3,a5
    80200c38:	00090713          	mv	a4,s2
    80200c3c:	00098793          	mv	a5,s3
}
    80200c40:	00070513          	mv	a0,a4
    80200c44:	00078593          	mv	a1,a5
    80200c48:	03813083          	ld	ra,56(sp)
    80200c4c:	03013403          	ld	s0,48(sp)
    80200c50:	02813903          	ld	s2,40(sp)
    80200c54:	02013983          	ld	s3,32(sp)
    80200c58:	04010113          	addi	sp,sp,64
    80200c5c:	00008067          	ret

0000000080200c60 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    80200c60:	fc010113          	addi	sp,sp,-64
    80200c64:	02113c23          	sd	ra,56(sp)
    80200c68:	02813823          	sd	s0,48(sp)
    80200c6c:	03213423          	sd	s2,40(sp)
    80200c70:	03313023          	sd	s3,32(sp)
    80200c74:	04010413          	addi	s0,sp,64
    80200c78:	00050793          	mv	a5,a0
    80200c7c:	00058713          	mv	a4,a1
    80200c80:	fcf42623          	sw	a5,-52(s0)
    80200c84:	00070793          	mv	a5,a4
    80200c88:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    80200c8c:	fcc46603          	lwu	a2,-52(s0)
    80200c90:	fc846683          	lwu	a3,-56(s0)
    80200c94:	00000893          	li	a7,0
    80200c98:	00000813          	li	a6,0
    80200c9c:	00000793          	li	a5,0
    80200ca0:	00000713          	li	a4,0
    80200ca4:	00000593          	li	a1,0
    80200ca8:	53525537          	lui	a0,0x53525
    80200cac:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200cb0:	e45ff0ef          	jal	80200af4 <sbi_ecall>
    80200cb4:	00050713          	mv	a4,a0
    80200cb8:	00058793          	mv	a5,a1
    80200cbc:	fce43823          	sd	a4,-48(s0)
    80200cc0:	fcf43c23          	sd	a5,-40(s0)
    80200cc4:	fd043703          	ld	a4,-48(s0)
    80200cc8:	fd843783          	ld	a5,-40(s0)
    80200ccc:	00070913          	mv	s2,a4
    80200cd0:	00078993          	mv	s3,a5
    80200cd4:	00090713          	mv	a4,s2
    80200cd8:	00098793          	mv	a5,s3
}
    80200cdc:	00070513          	mv	a0,a4
    80200ce0:	00078593          	mv	a1,a5
    80200ce4:	03813083          	ld	ra,56(sp)
    80200ce8:	03013403          	ld	s0,48(sp)
    80200cec:	02813903          	ld	s2,40(sp)
    80200cf0:	02013983          	ld	s3,32(sp)
    80200cf4:	04010113          	addi	sp,sp,64
    80200cf8:	00008067          	ret

0000000080200cfc <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    80200cfc:	fc010113          	addi	sp,sp,-64
    80200d00:	02113c23          	sd	ra,56(sp)
    80200d04:	02813823          	sd	s0,48(sp)
    80200d08:	03213423          	sd	s2,40(sp)
    80200d0c:	03313023          	sd	s3,32(sp)
    80200d10:	04010413          	addi	s0,sp,64
    80200d14:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    80200d18:	00000893          	li	a7,0
    80200d1c:	00000813          	li	a6,0
    80200d20:	00000793          	li	a5,0
    80200d24:	00000713          	li	a4,0
    80200d28:	00000693          	li	a3,0
    80200d2c:	fc843603          	ld	a2,-56(s0)
    80200d30:	00000593          	li	a1,0
    80200d34:	54495537          	lui	a0,0x54495
    80200d38:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200d3c:	db9ff0ef          	jal	80200af4 <sbi_ecall>
    80200d40:	00050713          	mv	a4,a0
    80200d44:	00058793          	mv	a5,a1
    80200d48:	fce43823          	sd	a4,-48(s0)
    80200d4c:	fcf43c23          	sd	a5,-40(s0)
    80200d50:	fd043703          	ld	a4,-48(s0)
    80200d54:	fd843783          	ld	a5,-40(s0)
    80200d58:	00070913          	mv	s2,a4
    80200d5c:	00078993          	mv	s3,a5
    80200d60:	00090713          	mv	a4,s2
    80200d64:	00098793          	mv	a5,s3
}
    80200d68:	00070513          	mv	a0,a4
    80200d6c:	00078593          	mv	a1,a5
    80200d70:	03813083          	ld	ra,56(sp)
    80200d74:	03013403          	ld	s0,48(sp)
    80200d78:	02813903          	ld	s2,40(sp)
    80200d7c:	02013983          	ld	s3,32(sp)
    80200d80:	04010113          	addi	sp,sp,64
    80200d84:	00008067          	ret

0000000080200d88 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    80200d88:	fb010113          	addi	sp,sp,-80
    80200d8c:	04113423          	sd	ra,72(sp)
    80200d90:	04813023          	sd	s0,64(sp)
    80200d94:	03213c23          	sd	s2,56(sp)
    80200d98:	03313823          	sd	s3,48(sp)
    80200d9c:	05010413          	addi	s0,sp,80
    80200da0:	fca43423          	sd	a0,-56(s0)
    80200da4:	fcb43023          	sd	a1,-64(s0)
    80200da8:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200dac:	00000893          	li	a7,0
    80200db0:	00000813          	li	a6,0
    80200db4:	00000793          	li	a5,0
    80200db8:	fb843703          	ld	a4,-72(s0)
    80200dbc:	fc043683          	ld	a3,-64(s0)
    80200dc0:	fc843603          	ld	a2,-56(s0)
    80200dc4:	00100593          	li	a1,1
    80200dc8:	44424537          	lui	a0,0x44424
    80200dcc:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200dd0:	d25ff0ef          	jal	80200af4 <sbi_ecall>
    80200dd4:	00050713          	mv	a4,a0
    80200dd8:	00058793          	mv	a5,a1
    80200ddc:	fce43823          	sd	a4,-48(s0)
    80200de0:	fcf43c23          	sd	a5,-40(s0)
    80200de4:	fd043703          	ld	a4,-48(s0)
    80200de8:	fd843783          	ld	a5,-40(s0)
    80200dec:	00070913          	mv	s2,a4
    80200df0:	00078993          	mv	s3,a5
    80200df4:	00090713          	mv	a4,s2
    80200df8:	00098793          	mv	a5,s3
}
    80200dfc:	00070513          	mv	a0,a4
    80200e00:	00078593          	mv	a1,a5
    80200e04:	04813083          	ld	ra,72(sp)
    80200e08:	04013403          	ld	s0,64(sp)
    80200e0c:	03813903          	ld	s2,56(sp)
    80200e10:	03013983          	ld	s3,48(sp)
    80200e14:	05010113          	addi	sp,sp,80
    80200e18:	00008067          	ret

0000000080200e1c <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    80200e1c:	fb010113          	addi	sp,sp,-80
    80200e20:	04113423          	sd	ra,72(sp)
    80200e24:	04813023          	sd	s0,64(sp)
    80200e28:	03213c23          	sd	s2,56(sp)
    80200e2c:	03313823          	sd	s3,48(sp)
    80200e30:	05010413          	addi	s0,sp,80
    80200e34:	fca43423          	sd	a0,-56(s0)
    80200e38:	fcb43023          	sd	a1,-64(s0)
    80200e3c:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200e40:	00000893          	li	a7,0
    80200e44:	00000813          	li	a6,0
    80200e48:	00000793          	li	a5,0
    80200e4c:	fb843703          	ld	a4,-72(s0)
    80200e50:	fc043683          	ld	a3,-64(s0)
    80200e54:	fc843603          	ld	a2,-56(s0)
    80200e58:	00000593          	li	a1,0
    80200e5c:	44424537          	lui	a0,0x44424
    80200e60:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200e64:	c91ff0ef          	jal	80200af4 <sbi_ecall>
    80200e68:	00050713          	mv	a4,a0
    80200e6c:	00058793          	mv	a5,a1
    80200e70:	fce43823          	sd	a4,-48(s0)
    80200e74:	fcf43c23          	sd	a5,-40(s0)
    80200e78:	fd043703          	ld	a4,-48(s0)
    80200e7c:	fd843783          	ld	a5,-40(s0)
    80200e80:	00070913          	mv	s2,a4
    80200e84:	00078993          	mv	s3,a5
    80200e88:	00090713          	mv	a4,s2
    80200e8c:	00098793          	mv	a5,s3
    80200e90:	00070513          	mv	a0,a4
    80200e94:	00078593          	mv	a1,a5
    80200e98:	04813083          	ld	ra,72(sp)
    80200e9c:	04013403          	ld	s0,64(sp)
    80200ea0:	03813903          	ld	s2,56(sp)
    80200ea4:	03013983          	ld	s3,48(sp)
    80200ea8:	05010113          	addi	sp,sp,80
    80200eac:	00008067          	ret

0000000080200eb0 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200eb0:	fe010113          	addi	sp,sp,-32
    80200eb4:	00113c23          	sd	ra,24(sp)
    80200eb8:	00813823          	sd	s0,16(sp)
    80200ebc:	02010413          	addi	s0,sp,32
    80200ec0:	fea43423          	sd	a0,-24(s0)
    80200ec4:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    80200ec8:	fe843783          	ld	a5,-24(s0)
    80200ecc:	0207d063          	bgez	a5,80200eec <trap_handler+0x3c>
    80200ed0:	fe843783          	ld	a5,-24(s0)
    80200ed4:	0ff7f713          	zext.b	a4,a5
    80200ed8:	00500793          	li	a5,5
    80200edc:	00f71863          	bne	a4,a5,80200eec <trap_handler+0x3c>
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mode Timer Interrupt\n");
        do_timer();
    80200ee0:	a0dff0ef          	jal	802008ec <do_timer>

        // 设置下一次时钟中断
        clock_set_next_event();
    80200ee4:	b34ff0ef          	jal	80200218 <clock_set_next_event>
    80200ee8:	01c0006f          	j	80200f04 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    80200eec:	fe043603          	ld	a2,-32(s0)
    80200ef0:	fe843583          	ld	a1,-24(s0)
    80200ef4:	00002517          	auipc	a0,0x2
    80200ef8:	27450513          	addi	a0,a0,628 # 80203168 <_srodata+0x168>
    80200efc:	7c9000ef          	jal	80201ec4 <printk>
    }
    80200f00:	00000013          	nop
    80200f04:	00000013          	nop
    80200f08:	01813083          	ld	ra,24(sp)
    80200f0c:	01013403          	ld	s0,16(sp)
    80200f10:	02010113          	addi	sp,sp,32
    80200f14:	00008067          	ret

0000000080200f18 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
    80200f18:	ff010113          	addi	sp,sp,-16
    80200f1c:	00113423          	sd	ra,8(sp)
    80200f20:	00813023          	sd	s0,0(sp)
    80200f24:	01010413          	addi	s0,sp,16
    printk("2024");
    80200f28:	00002517          	auipc	a0,0x2
    80200f2c:	28050513          	addi	a0,a0,640 # 802031a8 <_srodata+0x1a8>
    80200f30:	795000ef          	jal	80201ec4 <printk>
    printk(" ZJU Operating System\n");
    80200f34:	00002517          	auipc	a0,0x2
    80200f38:	27c50513          	addi	a0,a0,636 # 802031b0 <_srodata+0x1b0>
    80200f3c:	789000ef          	jal	80201ec4 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
    80200f40:	0b0000ef          	jal	80200ff0 <run_idle>
    return 0;
    80200f44:	00000793          	li	a5,0
}
    80200f48:	00078513          	mv	a0,a5
    80200f4c:	00813083          	ld	ra,8(sp)
    80200f50:	00013403          	ld	s0,0(sp)
    80200f54:	01010113          	addi	sp,sp,16
    80200f58:	00008067          	ret

0000000080200f5c <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    80200f5c:	ff010113          	addi	sp,sp,-16
    80200f60:	00113423          	sd	ra,8(sp)
    80200f64:	00813023          	sd	s0,0(sp)
    80200f68:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200f6c:	00000593          	li	a1,0
    80200f70:	00000513          	li	a0,0
    80200f74:	cedff0ef          	jal	80200c60 <sbi_system_reset>

0000000080200f78 <test>:
    __builtin_unreachable();
}

void test() {
    80200f78:	fe010113          	addi	sp,sp,-32
    80200f7c:	00113c23          	sd	ra,24(sp)
    80200f80:	00813823          	sd	s0,16(sp)
    80200f84:	02010413          	addi	s0,sp,32
    int i = 0;
    80200f88:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
    80200f8c:	fec42783          	lw	a5,-20(s0)
    80200f90:	0017879b          	addiw	a5,a5,1
    80200f94:	fef42623          	sw	a5,-20(s0)
    80200f98:	fec42783          	lw	a5,-20(s0)
    80200f9c:	0007869b          	sext.w	a3,a5
    80200fa0:	55e64737          	lui	a4,0x55e64
    80200fa4:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <_skernel-0x2a39c477>
    80200fa8:	02e68733          	mul	a4,a3,a4
    80200fac:	02075713          	srli	a4,a4,0x20
    80200fb0:	4197571b          	sraiw	a4,a4,0x19
    80200fb4:	00070693          	mv	a3,a4
    80200fb8:	41f7d71b          	sraiw	a4,a5,0x1f
    80200fbc:	40e6873b          	subw	a4,a3,a4
    80200fc0:	00070693          	mv	a3,a4
    80200fc4:	05f5e737          	lui	a4,0x5f5e
    80200fc8:	1007071b          	addiw	a4,a4,256 # 5f5e100 <_skernel-0x7a2a1f00>
    80200fcc:	02e6873b          	mulw	a4,a3,a4
    80200fd0:	40e787bb          	subw	a5,a5,a4
    80200fd4:	0007879b          	sext.w	a5,a5
    80200fd8:	fa079ae3          	bnez	a5,80200f8c <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
    80200fdc:	00002517          	auipc	a0,0x2
    80200fe0:	1ec50513          	addi	a0,a0,492 # 802031c8 <_srodata+0x1c8>
    80200fe4:	6e1000ef          	jal	80201ec4 <printk>
            i = 0;
    80200fe8:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
    80200fec:	fa1ff06f          	j	80200f8c <test+0x14>

0000000080200ff0 <run_idle>:
        }
    }
}

void run_idle() {
    80200ff0:	ff010113          	addi	sp,sp,-16
    80200ff4:	00113423          	sd	ra,8(sp)
    80200ff8:	00813023          	sd	s0,0(sp)
    80200ffc:	01010413          	addi	s0,sp,16
    while (1) {
    80201000:	0000006f          	j	80201000 <run_idle+0x10>

0000000080201004 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    80201004:	fe010113          	addi	sp,sp,-32
    80201008:	00113c23          	sd	ra,24(sp)
    8020100c:	00813823          	sd	s0,16(sp)
    80201010:	02010413          	addi	s0,sp,32
    80201014:	00050793          	mv	a5,a0
    80201018:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    8020101c:	fec42783          	lw	a5,-20(s0)
    80201020:	0ff7f793          	zext.b	a5,a5
    80201024:	00078513          	mv	a0,a5
    80201028:	ba9ff0ef          	jal	80200bd0 <sbi_debug_console_write_byte>
    return (char)c;
    8020102c:	fec42783          	lw	a5,-20(s0)
    80201030:	0ff7f793          	zext.b	a5,a5
    80201034:	0007879b          	sext.w	a5,a5
}
    80201038:	00078513          	mv	a0,a5
    8020103c:	01813083          	ld	ra,24(sp)
    80201040:	01013403          	ld	s0,16(sp)
    80201044:	02010113          	addi	sp,sp,32
    80201048:	00008067          	ret

000000008020104c <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    8020104c:	fe010113          	addi	sp,sp,-32
    80201050:	00113c23          	sd	ra,24(sp)
    80201054:	00813823          	sd	s0,16(sp)
    80201058:	02010413          	addi	s0,sp,32
    8020105c:	00050793          	mv	a5,a0
    80201060:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    80201064:	fec42783          	lw	a5,-20(s0)
    80201068:	0007871b          	sext.w	a4,a5
    8020106c:	02000793          	li	a5,32
    80201070:	02f70263          	beq	a4,a5,80201094 <isspace+0x48>
    80201074:	fec42783          	lw	a5,-20(s0)
    80201078:	0007871b          	sext.w	a4,a5
    8020107c:	00800793          	li	a5,8
    80201080:	00e7de63          	bge	a5,a4,8020109c <isspace+0x50>
    80201084:	fec42783          	lw	a5,-20(s0)
    80201088:	0007871b          	sext.w	a4,a5
    8020108c:	00d00793          	li	a5,13
    80201090:	00e7c663          	blt	a5,a4,8020109c <isspace+0x50>
    80201094:	00100793          	li	a5,1
    80201098:	0080006f          	j	802010a0 <isspace+0x54>
    8020109c:	00000793          	li	a5,0
}
    802010a0:	00078513          	mv	a0,a5
    802010a4:	01813083          	ld	ra,24(sp)
    802010a8:	01013403          	ld	s0,16(sp)
    802010ac:	02010113          	addi	sp,sp,32
    802010b0:	00008067          	ret

00000000802010b4 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    802010b4:	fb010113          	addi	sp,sp,-80
    802010b8:	04113423          	sd	ra,72(sp)
    802010bc:	04813023          	sd	s0,64(sp)
    802010c0:	05010413          	addi	s0,sp,80
    802010c4:	fca43423          	sd	a0,-56(s0)
    802010c8:	fcb43023          	sd	a1,-64(s0)
    802010cc:	00060793          	mv	a5,a2
    802010d0:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    802010d4:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    802010d8:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    802010dc:	fc843783          	ld	a5,-56(s0)
    802010e0:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    802010e4:	0100006f          	j	802010f4 <strtol+0x40>
        p++;
    802010e8:	fd843783          	ld	a5,-40(s0)
    802010ec:	00178793          	addi	a5,a5,1
    802010f0:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    802010f4:	fd843783          	ld	a5,-40(s0)
    802010f8:	0007c783          	lbu	a5,0(a5)
    802010fc:	0007879b          	sext.w	a5,a5
    80201100:	00078513          	mv	a0,a5
    80201104:	f49ff0ef          	jal	8020104c <isspace>
    80201108:	00050793          	mv	a5,a0
    8020110c:	fc079ee3          	bnez	a5,802010e8 <strtol+0x34>
    }

    if (*p == '-') {
    80201110:	fd843783          	ld	a5,-40(s0)
    80201114:	0007c783          	lbu	a5,0(a5)
    80201118:	00078713          	mv	a4,a5
    8020111c:	02d00793          	li	a5,45
    80201120:	00f71e63          	bne	a4,a5,8020113c <strtol+0x88>
        neg = true;
    80201124:	00100793          	li	a5,1
    80201128:	fef403a3          	sb	a5,-25(s0)
        p++;
    8020112c:	fd843783          	ld	a5,-40(s0)
    80201130:	00178793          	addi	a5,a5,1
    80201134:	fcf43c23          	sd	a5,-40(s0)
    80201138:	0240006f          	j	8020115c <strtol+0xa8>
    } else if (*p == '+') {
    8020113c:	fd843783          	ld	a5,-40(s0)
    80201140:	0007c783          	lbu	a5,0(a5)
    80201144:	00078713          	mv	a4,a5
    80201148:	02b00793          	li	a5,43
    8020114c:	00f71863          	bne	a4,a5,8020115c <strtol+0xa8>
        p++;
    80201150:	fd843783          	ld	a5,-40(s0)
    80201154:	00178793          	addi	a5,a5,1
    80201158:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    8020115c:	fbc42783          	lw	a5,-68(s0)
    80201160:	0007879b          	sext.w	a5,a5
    80201164:	06079c63          	bnez	a5,802011dc <strtol+0x128>
        if (*p == '0') {
    80201168:	fd843783          	ld	a5,-40(s0)
    8020116c:	0007c783          	lbu	a5,0(a5)
    80201170:	00078713          	mv	a4,a5
    80201174:	03000793          	li	a5,48
    80201178:	04f71e63          	bne	a4,a5,802011d4 <strtol+0x120>
            p++;
    8020117c:	fd843783          	ld	a5,-40(s0)
    80201180:	00178793          	addi	a5,a5,1
    80201184:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80201188:	fd843783          	ld	a5,-40(s0)
    8020118c:	0007c783          	lbu	a5,0(a5)
    80201190:	00078713          	mv	a4,a5
    80201194:	07800793          	li	a5,120
    80201198:	00f70c63          	beq	a4,a5,802011b0 <strtol+0xfc>
    8020119c:	fd843783          	ld	a5,-40(s0)
    802011a0:	0007c783          	lbu	a5,0(a5)
    802011a4:	00078713          	mv	a4,a5
    802011a8:	05800793          	li	a5,88
    802011ac:	00f71e63          	bne	a4,a5,802011c8 <strtol+0x114>
                base = 16;
    802011b0:	01000793          	li	a5,16
    802011b4:	faf42e23          	sw	a5,-68(s0)
                p++;
    802011b8:	fd843783          	ld	a5,-40(s0)
    802011bc:	00178793          	addi	a5,a5,1
    802011c0:	fcf43c23          	sd	a5,-40(s0)
    802011c4:	0180006f          	j	802011dc <strtol+0x128>
            } else {
                base = 8;
    802011c8:	00800793          	li	a5,8
    802011cc:	faf42e23          	sw	a5,-68(s0)
    802011d0:	00c0006f          	j	802011dc <strtol+0x128>
            }
        } else {
            base = 10;
    802011d4:	00a00793          	li	a5,10
    802011d8:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    802011dc:	fd843783          	ld	a5,-40(s0)
    802011e0:	0007c783          	lbu	a5,0(a5)
    802011e4:	00078713          	mv	a4,a5
    802011e8:	02f00793          	li	a5,47
    802011ec:	02e7f863          	bgeu	a5,a4,8020121c <strtol+0x168>
    802011f0:	fd843783          	ld	a5,-40(s0)
    802011f4:	0007c783          	lbu	a5,0(a5)
    802011f8:	00078713          	mv	a4,a5
    802011fc:	03900793          	li	a5,57
    80201200:	00e7ee63          	bltu	a5,a4,8020121c <strtol+0x168>
            digit = *p - '0';
    80201204:	fd843783          	ld	a5,-40(s0)
    80201208:	0007c783          	lbu	a5,0(a5)
    8020120c:	0007879b          	sext.w	a5,a5
    80201210:	fd07879b          	addiw	a5,a5,-48
    80201214:	fcf42a23          	sw	a5,-44(s0)
    80201218:	0800006f          	j	80201298 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    8020121c:	fd843783          	ld	a5,-40(s0)
    80201220:	0007c783          	lbu	a5,0(a5)
    80201224:	00078713          	mv	a4,a5
    80201228:	06000793          	li	a5,96
    8020122c:	02e7f863          	bgeu	a5,a4,8020125c <strtol+0x1a8>
    80201230:	fd843783          	ld	a5,-40(s0)
    80201234:	0007c783          	lbu	a5,0(a5)
    80201238:	00078713          	mv	a4,a5
    8020123c:	07a00793          	li	a5,122
    80201240:	00e7ee63          	bltu	a5,a4,8020125c <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80201244:	fd843783          	ld	a5,-40(s0)
    80201248:	0007c783          	lbu	a5,0(a5)
    8020124c:	0007879b          	sext.w	a5,a5
    80201250:	fa97879b          	addiw	a5,a5,-87
    80201254:	fcf42a23          	sw	a5,-44(s0)
    80201258:	0400006f          	j	80201298 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    8020125c:	fd843783          	ld	a5,-40(s0)
    80201260:	0007c783          	lbu	a5,0(a5)
    80201264:	00078713          	mv	a4,a5
    80201268:	04000793          	li	a5,64
    8020126c:	06e7f863          	bgeu	a5,a4,802012dc <strtol+0x228>
    80201270:	fd843783          	ld	a5,-40(s0)
    80201274:	0007c783          	lbu	a5,0(a5)
    80201278:	00078713          	mv	a4,a5
    8020127c:	05a00793          	li	a5,90
    80201280:	04e7ee63          	bltu	a5,a4,802012dc <strtol+0x228>
            digit = *p - ('A' - 10);
    80201284:	fd843783          	ld	a5,-40(s0)
    80201288:	0007c783          	lbu	a5,0(a5)
    8020128c:	0007879b          	sext.w	a5,a5
    80201290:	fc97879b          	addiw	a5,a5,-55
    80201294:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80201298:	fd442783          	lw	a5,-44(s0)
    8020129c:	00078713          	mv	a4,a5
    802012a0:	fbc42783          	lw	a5,-68(s0)
    802012a4:	0007071b          	sext.w	a4,a4
    802012a8:	0007879b          	sext.w	a5,a5
    802012ac:	02f75663          	bge	a4,a5,802012d8 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    802012b0:	fbc42703          	lw	a4,-68(s0)
    802012b4:	fe843783          	ld	a5,-24(s0)
    802012b8:	02f70733          	mul	a4,a4,a5
    802012bc:	fd442783          	lw	a5,-44(s0)
    802012c0:	00f707b3          	add	a5,a4,a5
    802012c4:	fef43423          	sd	a5,-24(s0)
        p++;
    802012c8:	fd843783          	ld	a5,-40(s0)
    802012cc:	00178793          	addi	a5,a5,1
    802012d0:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    802012d4:	f09ff06f          	j	802011dc <strtol+0x128>
            break;
    802012d8:	00000013          	nop
    }

    if (endptr) {
    802012dc:	fc043783          	ld	a5,-64(s0)
    802012e0:	00078863          	beqz	a5,802012f0 <strtol+0x23c>
        *endptr = (char *)p;
    802012e4:	fc043783          	ld	a5,-64(s0)
    802012e8:	fd843703          	ld	a4,-40(s0)
    802012ec:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    802012f0:	fe744783          	lbu	a5,-25(s0)
    802012f4:	0ff7f793          	zext.b	a5,a5
    802012f8:	00078863          	beqz	a5,80201308 <strtol+0x254>
    802012fc:	fe843783          	ld	a5,-24(s0)
    80201300:	40f007b3          	neg	a5,a5
    80201304:	0080006f          	j	8020130c <strtol+0x258>
    80201308:	fe843783          	ld	a5,-24(s0)
}
    8020130c:	00078513          	mv	a0,a5
    80201310:	04813083          	ld	ra,72(sp)
    80201314:	04013403          	ld	s0,64(sp)
    80201318:	05010113          	addi	sp,sp,80
    8020131c:	00008067          	ret

0000000080201320 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    80201320:	fd010113          	addi	sp,sp,-48
    80201324:	02113423          	sd	ra,40(sp)
    80201328:	02813023          	sd	s0,32(sp)
    8020132c:	03010413          	addi	s0,sp,48
    80201330:	fca43c23          	sd	a0,-40(s0)
    80201334:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    80201338:	fd043783          	ld	a5,-48(s0)
    8020133c:	00079863          	bnez	a5,8020134c <puts_wo_nl+0x2c>
        s = "(null)";
    80201340:	00002797          	auipc	a5,0x2
    80201344:	ea078793          	addi	a5,a5,-352 # 802031e0 <_srodata+0x1e0>
    80201348:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    8020134c:	fd043783          	ld	a5,-48(s0)
    80201350:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80201354:	0240006f          	j	80201378 <puts_wo_nl+0x58>
        putch(*p++);
    80201358:	fe843783          	ld	a5,-24(s0)
    8020135c:	00178713          	addi	a4,a5,1
    80201360:	fee43423          	sd	a4,-24(s0)
    80201364:	0007c783          	lbu	a5,0(a5)
    80201368:	0007871b          	sext.w	a4,a5
    8020136c:	fd843783          	ld	a5,-40(s0)
    80201370:	00070513          	mv	a0,a4
    80201374:	000780e7          	jalr	a5
    while (*p) {
    80201378:	fe843783          	ld	a5,-24(s0)
    8020137c:	0007c783          	lbu	a5,0(a5)
    80201380:	fc079ce3          	bnez	a5,80201358 <puts_wo_nl+0x38>
    }
    return p - s;
    80201384:	fe843703          	ld	a4,-24(s0)
    80201388:	fd043783          	ld	a5,-48(s0)
    8020138c:	40f707b3          	sub	a5,a4,a5
    80201390:	0007879b          	sext.w	a5,a5
}
    80201394:	00078513          	mv	a0,a5
    80201398:	02813083          	ld	ra,40(sp)
    8020139c:	02013403          	ld	s0,32(sp)
    802013a0:	03010113          	addi	sp,sp,48
    802013a4:	00008067          	ret

00000000802013a8 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    802013a8:	f9010113          	addi	sp,sp,-112
    802013ac:	06113423          	sd	ra,104(sp)
    802013b0:	06813023          	sd	s0,96(sp)
    802013b4:	07010413          	addi	s0,sp,112
    802013b8:	faa43423          	sd	a0,-88(s0)
    802013bc:	fab43023          	sd	a1,-96(s0)
    802013c0:	00060793          	mv	a5,a2
    802013c4:	f8d43823          	sd	a3,-112(s0)
    802013c8:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    802013cc:	f9f44783          	lbu	a5,-97(s0)
    802013d0:	0ff7f793          	zext.b	a5,a5
    802013d4:	02078663          	beqz	a5,80201400 <print_dec_int+0x58>
    802013d8:	fa043703          	ld	a4,-96(s0)
    802013dc:	fff00793          	li	a5,-1
    802013e0:	03f79793          	slli	a5,a5,0x3f
    802013e4:	00f71e63          	bne	a4,a5,80201400 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    802013e8:	00002597          	auipc	a1,0x2
    802013ec:	e0058593          	addi	a1,a1,-512 # 802031e8 <_srodata+0x1e8>
    802013f0:	fa843503          	ld	a0,-88(s0)
    802013f4:	f2dff0ef          	jal	80201320 <puts_wo_nl>
    802013f8:	00050793          	mv	a5,a0
    802013fc:	2c80006f          	j	802016c4 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    80201400:	f9043783          	ld	a5,-112(s0)
    80201404:	00c7a783          	lw	a5,12(a5)
    80201408:	00079a63          	bnez	a5,8020141c <print_dec_int+0x74>
    8020140c:	fa043783          	ld	a5,-96(s0)
    80201410:	00079663          	bnez	a5,8020141c <print_dec_int+0x74>
        return 0;
    80201414:	00000793          	li	a5,0
    80201418:	2ac0006f          	j	802016c4 <print_dec_int+0x31c>
    }

    bool neg = false;
    8020141c:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80201420:	f9f44783          	lbu	a5,-97(s0)
    80201424:	0ff7f793          	zext.b	a5,a5
    80201428:	02078063          	beqz	a5,80201448 <print_dec_int+0xa0>
    8020142c:	fa043783          	ld	a5,-96(s0)
    80201430:	0007dc63          	bgez	a5,80201448 <print_dec_int+0xa0>
        neg = true;
    80201434:	00100793          	li	a5,1
    80201438:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    8020143c:	fa043783          	ld	a5,-96(s0)
    80201440:	40f007b3          	neg	a5,a5
    80201444:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    80201448:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    8020144c:	f9f44783          	lbu	a5,-97(s0)
    80201450:	0ff7f793          	zext.b	a5,a5
    80201454:	02078863          	beqz	a5,80201484 <print_dec_int+0xdc>
    80201458:	fef44783          	lbu	a5,-17(s0)
    8020145c:	0ff7f793          	zext.b	a5,a5
    80201460:	00079e63          	bnez	a5,8020147c <print_dec_int+0xd4>
    80201464:	f9043783          	ld	a5,-112(s0)
    80201468:	0057c783          	lbu	a5,5(a5)
    8020146c:	00079863          	bnez	a5,8020147c <print_dec_int+0xd4>
    80201470:	f9043783          	ld	a5,-112(s0)
    80201474:	0047c783          	lbu	a5,4(a5)
    80201478:	00078663          	beqz	a5,80201484 <print_dec_int+0xdc>
    8020147c:	00100793          	li	a5,1
    80201480:	0080006f          	j	80201488 <print_dec_int+0xe0>
    80201484:	00000793          	li	a5,0
    80201488:	fcf40ba3          	sb	a5,-41(s0)
    8020148c:	fd744783          	lbu	a5,-41(s0)
    80201490:	0017f793          	andi	a5,a5,1
    80201494:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80201498:	fa043683          	ld	a3,-96(s0)
    8020149c:	00002797          	auipc	a5,0x2
    802014a0:	d6478793          	addi	a5,a5,-668 # 80203200 <_srodata+0x200>
    802014a4:	0007b783          	ld	a5,0(a5)
    802014a8:	02f6b7b3          	mulhu	a5,a3,a5
    802014ac:	0037d713          	srli	a4,a5,0x3
    802014b0:	00070793          	mv	a5,a4
    802014b4:	00279793          	slli	a5,a5,0x2
    802014b8:	00e787b3          	add	a5,a5,a4
    802014bc:	00179793          	slli	a5,a5,0x1
    802014c0:	40f68733          	sub	a4,a3,a5
    802014c4:	0ff77713          	zext.b	a4,a4
    802014c8:	fe842783          	lw	a5,-24(s0)
    802014cc:	0017869b          	addiw	a3,a5,1
    802014d0:	fed42423          	sw	a3,-24(s0)
    802014d4:	0307071b          	addiw	a4,a4,48
    802014d8:	0ff77713          	zext.b	a4,a4
    802014dc:	ff078793          	addi	a5,a5,-16
    802014e0:	008787b3          	add	a5,a5,s0
    802014e4:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    802014e8:	fa043703          	ld	a4,-96(s0)
    802014ec:	00002797          	auipc	a5,0x2
    802014f0:	d1478793          	addi	a5,a5,-748 # 80203200 <_srodata+0x200>
    802014f4:	0007b783          	ld	a5,0(a5)
    802014f8:	02f737b3          	mulhu	a5,a4,a5
    802014fc:	0037d793          	srli	a5,a5,0x3
    80201500:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80201504:	fa043783          	ld	a5,-96(s0)
    80201508:	f80798e3          	bnez	a5,80201498 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    8020150c:	f9043783          	ld	a5,-112(s0)
    80201510:	00c7a703          	lw	a4,12(a5)
    80201514:	fff00793          	li	a5,-1
    80201518:	02f71063          	bne	a4,a5,80201538 <print_dec_int+0x190>
    8020151c:	f9043783          	ld	a5,-112(s0)
    80201520:	0037c783          	lbu	a5,3(a5)
    80201524:	00078a63          	beqz	a5,80201538 <print_dec_int+0x190>
        flags->prec = flags->width;
    80201528:	f9043783          	ld	a5,-112(s0)
    8020152c:	0087a703          	lw	a4,8(a5)
    80201530:	f9043783          	ld	a5,-112(s0)
    80201534:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80201538:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    8020153c:	f9043783          	ld	a5,-112(s0)
    80201540:	0087a703          	lw	a4,8(a5)
    80201544:	fe842783          	lw	a5,-24(s0)
    80201548:	fcf42823          	sw	a5,-48(s0)
    8020154c:	f9043783          	ld	a5,-112(s0)
    80201550:	00c7a783          	lw	a5,12(a5)
    80201554:	fcf42623          	sw	a5,-52(s0)
    80201558:	fd042783          	lw	a5,-48(s0)
    8020155c:	00078593          	mv	a1,a5
    80201560:	fcc42783          	lw	a5,-52(s0)
    80201564:	00078613          	mv	a2,a5
    80201568:	0006069b          	sext.w	a3,a2
    8020156c:	0005879b          	sext.w	a5,a1
    80201570:	00f6d463          	bge	a3,a5,80201578 <print_dec_int+0x1d0>
    80201574:	00058613          	mv	a2,a1
    80201578:	0006079b          	sext.w	a5,a2
    8020157c:	40f707bb          	subw	a5,a4,a5
    80201580:	0007871b          	sext.w	a4,a5
    80201584:	fd744783          	lbu	a5,-41(s0)
    80201588:	0007879b          	sext.w	a5,a5
    8020158c:	40f707bb          	subw	a5,a4,a5
    80201590:	fef42023          	sw	a5,-32(s0)
    80201594:	0280006f          	j	802015bc <print_dec_int+0x214>
        putch(' ');
    80201598:	fa843783          	ld	a5,-88(s0)
    8020159c:	02000513          	li	a0,32
    802015a0:	000780e7          	jalr	a5
        ++written;
    802015a4:	fe442783          	lw	a5,-28(s0)
    802015a8:	0017879b          	addiw	a5,a5,1
    802015ac:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    802015b0:	fe042783          	lw	a5,-32(s0)
    802015b4:	fff7879b          	addiw	a5,a5,-1
    802015b8:	fef42023          	sw	a5,-32(s0)
    802015bc:	fe042783          	lw	a5,-32(s0)
    802015c0:	0007879b          	sext.w	a5,a5
    802015c4:	fcf04ae3          	bgtz	a5,80201598 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    802015c8:	fd744783          	lbu	a5,-41(s0)
    802015cc:	0ff7f793          	zext.b	a5,a5
    802015d0:	04078463          	beqz	a5,80201618 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    802015d4:	fef44783          	lbu	a5,-17(s0)
    802015d8:	0ff7f793          	zext.b	a5,a5
    802015dc:	00078663          	beqz	a5,802015e8 <print_dec_int+0x240>
    802015e0:	02d00793          	li	a5,45
    802015e4:	01c0006f          	j	80201600 <print_dec_int+0x258>
    802015e8:	f9043783          	ld	a5,-112(s0)
    802015ec:	0057c783          	lbu	a5,5(a5)
    802015f0:	00078663          	beqz	a5,802015fc <print_dec_int+0x254>
    802015f4:	02b00793          	li	a5,43
    802015f8:	0080006f          	j	80201600 <print_dec_int+0x258>
    802015fc:	02000793          	li	a5,32
    80201600:	fa843703          	ld	a4,-88(s0)
    80201604:	00078513          	mv	a0,a5
    80201608:	000700e7          	jalr	a4
        ++written;
    8020160c:	fe442783          	lw	a5,-28(s0)
    80201610:	0017879b          	addiw	a5,a5,1
    80201614:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80201618:	fe842783          	lw	a5,-24(s0)
    8020161c:	fcf42e23          	sw	a5,-36(s0)
    80201620:	0280006f          	j	80201648 <print_dec_int+0x2a0>
        putch('0');
    80201624:	fa843783          	ld	a5,-88(s0)
    80201628:	03000513          	li	a0,48
    8020162c:	000780e7          	jalr	a5
        ++written;
    80201630:	fe442783          	lw	a5,-28(s0)
    80201634:	0017879b          	addiw	a5,a5,1
    80201638:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    8020163c:	fdc42783          	lw	a5,-36(s0)
    80201640:	0017879b          	addiw	a5,a5,1
    80201644:	fcf42e23          	sw	a5,-36(s0)
    80201648:	f9043783          	ld	a5,-112(s0)
    8020164c:	00c7a703          	lw	a4,12(a5)
    80201650:	fd744783          	lbu	a5,-41(s0)
    80201654:	0007879b          	sext.w	a5,a5
    80201658:	40f707bb          	subw	a5,a4,a5
    8020165c:	0007879b          	sext.w	a5,a5
    80201660:	fdc42703          	lw	a4,-36(s0)
    80201664:	0007071b          	sext.w	a4,a4
    80201668:	faf74ee3          	blt	a4,a5,80201624 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    8020166c:	fe842783          	lw	a5,-24(s0)
    80201670:	fff7879b          	addiw	a5,a5,-1
    80201674:	fcf42c23          	sw	a5,-40(s0)
    80201678:	03c0006f          	j	802016b4 <print_dec_int+0x30c>
        putch(buf[i]);
    8020167c:	fd842783          	lw	a5,-40(s0)
    80201680:	ff078793          	addi	a5,a5,-16
    80201684:	008787b3          	add	a5,a5,s0
    80201688:	fc87c783          	lbu	a5,-56(a5)
    8020168c:	0007871b          	sext.w	a4,a5
    80201690:	fa843783          	ld	a5,-88(s0)
    80201694:	00070513          	mv	a0,a4
    80201698:	000780e7          	jalr	a5
        ++written;
    8020169c:	fe442783          	lw	a5,-28(s0)
    802016a0:	0017879b          	addiw	a5,a5,1
    802016a4:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    802016a8:	fd842783          	lw	a5,-40(s0)
    802016ac:	fff7879b          	addiw	a5,a5,-1
    802016b0:	fcf42c23          	sw	a5,-40(s0)
    802016b4:	fd842783          	lw	a5,-40(s0)
    802016b8:	0007879b          	sext.w	a5,a5
    802016bc:	fc07d0e3          	bgez	a5,8020167c <print_dec_int+0x2d4>
    }

    return written;
    802016c0:	fe442783          	lw	a5,-28(s0)
}
    802016c4:	00078513          	mv	a0,a5
    802016c8:	06813083          	ld	ra,104(sp)
    802016cc:	06013403          	ld	s0,96(sp)
    802016d0:	07010113          	addi	sp,sp,112
    802016d4:	00008067          	ret

00000000802016d8 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    802016d8:	f4010113          	addi	sp,sp,-192
    802016dc:	0a113c23          	sd	ra,184(sp)
    802016e0:	0a813823          	sd	s0,176(sp)
    802016e4:	0c010413          	addi	s0,sp,192
    802016e8:	f4a43c23          	sd	a0,-168(s0)
    802016ec:	f4b43823          	sd	a1,-176(s0)
    802016f0:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    802016f4:	f8043023          	sd	zero,-128(s0)
    802016f8:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    802016fc:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80201700:	7a00006f          	j	80201ea0 <vprintfmt+0x7c8>
        if (flags.in_format) {
    80201704:	f8044783          	lbu	a5,-128(s0)
    80201708:	72078c63          	beqz	a5,80201e40 <vprintfmt+0x768>
            if (*fmt == '#') {
    8020170c:	f5043783          	ld	a5,-176(s0)
    80201710:	0007c783          	lbu	a5,0(a5)
    80201714:	00078713          	mv	a4,a5
    80201718:	02300793          	li	a5,35
    8020171c:	00f71863          	bne	a4,a5,8020172c <vprintfmt+0x54>
                flags.sharpflag = true;
    80201720:	00100793          	li	a5,1
    80201724:	f8f40123          	sb	a5,-126(s0)
    80201728:	76c0006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    8020172c:	f5043783          	ld	a5,-176(s0)
    80201730:	0007c783          	lbu	a5,0(a5)
    80201734:	00078713          	mv	a4,a5
    80201738:	03000793          	li	a5,48
    8020173c:	00f71863          	bne	a4,a5,8020174c <vprintfmt+0x74>
                flags.zeroflag = true;
    80201740:	00100793          	li	a5,1
    80201744:	f8f401a3          	sb	a5,-125(s0)
    80201748:	74c0006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    8020174c:	f5043783          	ld	a5,-176(s0)
    80201750:	0007c783          	lbu	a5,0(a5)
    80201754:	00078713          	mv	a4,a5
    80201758:	06c00793          	li	a5,108
    8020175c:	04f70063          	beq	a4,a5,8020179c <vprintfmt+0xc4>
    80201760:	f5043783          	ld	a5,-176(s0)
    80201764:	0007c783          	lbu	a5,0(a5)
    80201768:	00078713          	mv	a4,a5
    8020176c:	07a00793          	li	a5,122
    80201770:	02f70663          	beq	a4,a5,8020179c <vprintfmt+0xc4>
    80201774:	f5043783          	ld	a5,-176(s0)
    80201778:	0007c783          	lbu	a5,0(a5)
    8020177c:	00078713          	mv	a4,a5
    80201780:	07400793          	li	a5,116
    80201784:	00f70c63          	beq	a4,a5,8020179c <vprintfmt+0xc4>
    80201788:	f5043783          	ld	a5,-176(s0)
    8020178c:	0007c783          	lbu	a5,0(a5)
    80201790:	00078713          	mv	a4,a5
    80201794:	06a00793          	li	a5,106
    80201798:	00f71863          	bne	a4,a5,802017a8 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    8020179c:	00100793          	li	a5,1
    802017a0:	f8f400a3          	sb	a5,-127(s0)
    802017a4:	6f00006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    802017a8:	f5043783          	ld	a5,-176(s0)
    802017ac:	0007c783          	lbu	a5,0(a5)
    802017b0:	00078713          	mv	a4,a5
    802017b4:	02b00793          	li	a5,43
    802017b8:	00f71863          	bne	a4,a5,802017c8 <vprintfmt+0xf0>
                flags.sign = true;
    802017bc:	00100793          	li	a5,1
    802017c0:	f8f402a3          	sb	a5,-123(s0)
    802017c4:	6d00006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    802017c8:	f5043783          	ld	a5,-176(s0)
    802017cc:	0007c783          	lbu	a5,0(a5)
    802017d0:	00078713          	mv	a4,a5
    802017d4:	02000793          	li	a5,32
    802017d8:	00f71863          	bne	a4,a5,802017e8 <vprintfmt+0x110>
                flags.spaceflag = true;
    802017dc:	00100793          	li	a5,1
    802017e0:	f8f40223          	sb	a5,-124(s0)
    802017e4:	6b00006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    802017e8:	f5043783          	ld	a5,-176(s0)
    802017ec:	0007c783          	lbu	a5,0(a5)
    802017f0:	00078713          	mv	a4,a5
    802017f4:	02a00793          	li	a5,42
    802017f8:	00f71e63          	bne	a4,a5,80201814 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    802017fc:	f4843783          	ld	a5,-184(s0)
    80201800:	00878713          	addi	a4,a5,8
    80201804:	f4e43423          	sd	a4,-184(s0)
    80201808:	0007a783          	lw	a5,0(a5)
    8020180c:	f8f42423          	sw	a5,-120(s0)
    80201810:	6840006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    80201814:	f5043783          	ld	a5,-176(s0)
    80201818:	0007c783          	lbu	a5,0(a5)
    8020181c:	00078713          	mv	a4,a5
    80201820:	03000793          	li	a5,48
    80201824:	04e7f663          	bgeu	a5,a4,80201870 <vprintfmt+0x198>
    80201828:	f5043783          	ld	a5,-176(s0)
    8020182c:	0007c783          	lbu	a5,0(a5)
    80201830:	00078713          	mv	a4,a5
    80201834:	03900793          	li	a5,57
    80201838:	02e7ec63          	bltu	a5,a4,80201870 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    8020183c:	f5043783          	ld	a5,-176(s0)
    80201840:	f5040713          	addi	a4,s0,-176
    80201844:	00a00613          	li	a2,10
    80201848:	00070593          	mv	a1,a4
    8020184c:	00078513          	mv	a0,a5
    80201850:	865ff0ef          	jal	802010b4 <strtol>
    80201854:	00050793          	mv	a5,a0
    80201858:	0007879b          	sext.w	a5,a5
    8020185c:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    80201860:	f5043783          	ld	a5,-176(s0)
    80201864:	fff78793          	addi	a5,a5,-1
    80201868:	f4f43823          	sd	a5,-176(s0)
    8020186c:	6280006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    80201870:	f5043783          	ld	a5,-176(s0)
    80201874:	0007c783          	lbu	a5,0(a5)
    80201878:	00078713          	mv	a4,a5
    8020187c:	02e00793          	li	a5,46
    80201880:	06f71863          	bne	a4,a5,802018f0 <vprintfmt+0x218>
                fmt++;
    80201884:	f5043783          	ld	a5,-176(s0)
    80201888:	00178793          	addi	a5,a5,1
    8020188c:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80201890:	f5043783          	ld	a5,-176(s0)
    80201894:	0007c783          	lbu	a5,0(a5)
    80201898:	00078713          	mv	a4,a5
    8020189c:	02a00793          	li	a5,42
    802018a0:	00f71e63          	bne	a4,a5,802018bc <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    802018a4:	f4843783          	ld	a5,-184(s0)
    802018a8:	00878713          	addi	a4,a5,8
    802018ac:	f4e43423          	sd	a4,-184(s0)
    802018b0:	0007a783          	lw	a5,0(a5)
    802018b4:	f8f42623          	sw	a5,-116(s0)
    802018b8:	5dc0006f          	j	80201e94 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    802018bc:	f5043783          	ld	a5,-176(s0)
    802018c0:	f5040713          	addi	a4,s0,-176
    802018c4:	00a00613          	li	a2,10
    802018c8:	00070593          	mv	a1,a4
    802018cc:	00078513          	mv	a0,a5
    802018d0:	fe4ff0ef          	jal	802010b4 <strtol>
    802018d4:	00050793          	mv	a5,a0
    802018d8:	0007879b          	sext.w	a5,a5
    802018dc:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    802018e0:	f5043783          	ld	a5,-176(s0)
    802018e4:	fff78793          	addi	a5,a5,-1
    802018e8:	f4f43823          	sd	a5,-176(s0)
    802018ec:	5a80006f          	j	80201e94 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802018f0:	f5043783          	ld	a5,-176(s0)
    802018f4:	0007c783          	lbu	a5,0(a5)
    802018f8:	00078713          	mv	a4,a5
    802018fc:	07800793          	li	a5,120
    80201900:	02f70663          	beq	a4,a5,8020192c <vprintfmt+0x254>
    80201904:	f5043783          	ld	a5,-176(s0)
    80201908:	0007c783          	lbu	a5,0(a5)
    8020190c:	00078713          	mv	a4,a5
    80201910:	05800793          	li	a5,88
    80201914:	00f70c63          	beq	a4,a5,8020192c <vprintfmt+0x254>
    80201918:	f5043783          	ld	a5,-176(s0)
    8020191c:	0007c783          	lbu	a5,0(a5)
    80201920:	00078713          	mv	a4,a5
    80201924:	07000793          	li	a5,112
    80201928:	30f71063          	bne	a4,a5,80201c28 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    8020192c:	f5043783          	ld	a5,-176(s0)
    80201930:	0007c783          	lbu	a5,0(a5)
    80201934:	00078713          	mv	a4,a5
    80201938:	07000793          	li	a5,112
    8020193c:	00f70663          	beq	a4,a5,80201948 <vprintfmt+0x270>
    80201940:	f8144783          	lbu	a5,-127(s0)
    80201944:	00078663          	beqz	a5,80201950 <vprintfmt+0x278>
    80201948:	00100793          	li	a5,1
    8020194c:	0080006f          	j	80201954 <vprintfmt+0x27c>
    80201950:	00000793          	li	a5,0
    80201954:	faf403a3          	sb	a5,-89(s0)
    80201958:	fa744783          	lbu	a5,-89(s0)
    8020195c:	0017f793          	andi	a5,a5,1
    80201960:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    80201964:	fa744783          	lbu	a5,-89(s0)
    80201968:	0ff7f793          	zext.b	a5,a5
    8020196c:	00078c63          	beqz	a5,80201984 <vprintfmt+0x2ac>
    80201970:	f4843783          	ld	a5,-184(s0)
    80201974:	00878713          	addi	a4,a5,8
    80201978:	f4e43423          	sd	a4,-184(s0)
    8020197c:	0007b783          	ld	a5,0(a5)
    80201980:	01c0006f          	j	8020199c <vprintfmt+0x2c4>
    80201984:	f4843783          	ld	a5,-184(s0)
    80201988:	00878713          	addi	a4,a5,8
    8020198c:	f4e43423          	sd	a4,-184(s0)
    80201990:	0007a783          	lw	a5,0(a5)
    80201994:	02079793          	slli	a5,a5,0x20
    80201998:	0207d793          	srli	a5,a5,0x20
    8020199c:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    802019a0:	f8c42783          	lw	a5,-116(s0)
    802019a4:	02079463          	bnez	a5,802019cc <vprintfmt+0x2f4>
    802019a8:	fe043783          	ld	a5,-32(s0)
    802019ac:	02079063          	bnez	a5,802019cc <vprintfmt+0x2f4>
    802019b0:	f5043783          	ld	a5,-176(s0)
    802019b4:	0007c783          	lbu	a5,0(a5)
    802019b8:	00078713          	mv	a4,a5
    802019bc:	07000793          	li	a5,112
    802019c0:	00f70663          	beq	a4,a5,802019cc <vprintfmt+0x2f4>
                    flags.in_format = false;
    802019c4:	f8040023          	sb	zero,-128(s0)
    802019c8:	4cc0006f          	j	80201e94 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    802019cc:	f5043783          	ld	a5,-176(s0)
    802019d0:	0007c783          	lbu	a5,0(a5)
    802019d4:	00078713          	mv	a4,a5
    802019d8:	07000793          	li	a5,112
    802019dc:	00f70a63          	beq	a4,a5,802019f0 <vprintfmt+0x318>
    802019e0:	f8244783          	lbu	a5,-126(s0)
    802019e4:	00078a63          	beqz	a5,802019f8 <vprintfmt+0x320>
    802019e8:	fe043783          	ld	a5,-32(s0)
    802019ec:	00078663          	beqz	a5,802019f8 <vprintfmt+0x320>
    802019f0:	00100793          	li	a5,1
    802019f4:	0080006f          	j	802019fc <vprintfmt+0x324>
    802019f8:	00000793          	li	a5,0
    802019fc:	faf40323          	sb	a5,-90(s0)
    80201a00:	fa644783          	lbu	a5,-90(s0)
    80201a04:	0017f793          	andi	a5,a5,1
    80201a08:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80201a0c:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80201a10:	f5043783          	ld	a5,-176(s0)
    80201a14:	0007c783          	lbu	a5,0(a5)
    80201a18:	00078713          	mv	a4,a5
    80201a1c:	05800793          	li	a5,88
    80201a20:	00f71863          	bne	a4,a5,80201a30 <vprintfmt+0x358>
    80201a24:	00001797          	auipc	a5,0x1
    80201a28:	7e478793          	addi	a5,a5,2020 # 80203208 <upperxdigits.1>
    80201a2c:	00c0006f          	j	80201a38 <vprintfmt+0x360>
    80201a30:	00001797          	auipc	a5,0x1
    80201a34:	7f078793          	addi	a5,a5,2032 # 80203220 <lowerxdigits.0>
    80201a38:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    80201a3c:	fe043783          	ld	a5,-32(s0)
    80201a40:	00f7f793          	andi	a5,a5,15
    80201a44:	f9843703          	ld	a4,-104(s0)
    80201a48:	00f70733          	add	a4,a4,a5
    80201a4c:	fdc42783          	lw	a5,-36(s0)
    80201a50:	0017869b          	addiw	a3,a5,1
    80201a54:	fcd42e23          	sw	a3,-36(s0)
    80201a58:	00074703          	lbu	a4,0(a4)
    80201a5c:	ff078793          	addi	a5,a5,-16
    80201a60:	008787b3          	add	a5,a5,s0
    80201a64:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    80201a68:	fe043783          	ld	a5,-32(s0)
    80201a6c:	0047d793          	srli	a5,a5,0x4
    80201a70:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80201a74:	fe043783          	ld	a5,-32(s0)
    80201a78:	fc0792e3          	bnez	a5,80201a3c <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201a7c:	f8c42703          	lw	a4,-116(s0)
    80201a80:	fff00793          	li	a5,-1
    80201a84:	02f71663          	bne	a4,a5,80201ab0 <vprintfmt+0x3d8>
    80201a88:	f8344783          	lbu	a5,-125(s0)
    80201a8c:	02078263          	beqz	a5,80201ab0 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80201a90:	f8842703          	lw	a4,-120(s0)
    80201a94:	fa644783          	lbu	a5,-90(s0)
    80201a98:	0007879b          	sext.w	a5,a5
    80201a9c:	0017979b          	slliw	a5,a5,0x1
    80201aa0:	0007879b          	sext.w	a5,a5
    80201aa4:	40f707bb          	subw	a5,a4,a5
    80201aa8:	0007879b          	sext.w	a5,a5
    80201aac:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201ab0:	f8842703          	lw	a4,-120(s0)
    80201ab4:	fa644783          	lbu	a5,-90(s0)
    80201ab8:	0007879b          	sext.w	a5,a5
    80201abc:	0017979b          	slliw	a5,a5,0x1
    80201ac0:	0007879b          	sext.w	a5,a5
    80201ac4:	40f707bb          	subw	a5,a4,a5
    80201ac8:	0007871b          	sext.w	a4,a5
    80201acc:	fdc42783          	lw	a5,-36(s0)
    80201ad0:	f8f42a23          	sw	a5,-108(s0)
    80201ad4:	f8c42783          	lw	a5,-116(s0)
    80201ad8:	f8f42823          	sw	a5,-112(s0)
    80201adc:	f9442783          	lw	a5,-108(s0)
    80201ae0:	00078593          	mv	a1,a5
    80201ae4:	f9042783          	lw	a5,-112(s0)
    80201ae8:	00078613          	mv	a2,a5
    80201aec:	0006069b          	sext.w	a3,a2
    80201af0:	0005879b          	sext.w	a5,a1
    80201af4:	00f6d463          	bge	a3,a5,80201afc <vprintfmt+0x424>
    80201af8:	00058613          	mv	a2,a1
    80201afc:	0006079b          	sext.w	a5,a2
    80201b00:	40f707bb          	subw	a5,a4,a5
    80201b04:	fcf42c23          	sw	a5,-40(s0)
    80201b08:	0280006f          	j	80201b30 <vprintfmt+0x458>
                    putch(' ');
    80201b0c:	f5843783          	ld	a5,-168(s0)
    80201b10:	02000513          	li	a0,32
    80201b14:	000780e7          	jalr	a5
                    ++written;
    80201b18:	fec42783          	lw	a5,-20(s0)
    80201b1c:	0017879b          	addiw	a5,a5,1
    80201b20:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201b24:	fd842783          	lw	a5,-40(s0)
    80201b28:	fff7879b          	addiw	a5,a5,-1
    80201b2c:	fcf42c23          	sw	a5,-40(s0)
    80201b30:	fd842783          	lw	a5,-40(s0)
    80201b34:	0007879b          	sext.w	a5,a5
    80201b38:	fcf04ae3          	bgtz	a5,80201b0c <vprintfmt+0x434>
                }

                if (prefix) {
    80201b3c:	fa644783          	lbu	a5,-90(s0)
    80201b40:	0ff7f793          	zext.b	a5,a5
    80201b44:	04078463          	beqz	a5,80201b8c <vprintfmt+0x4b4>
                    putch('0');
    80201b48:	f5843783          	ld	a5,-168(s0)
    80201b4c:	03000513          	li	a0,48
    80201b50:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    80201b54:	f5043783          	ld	a5,-176(s0)
    80201b58:	0007c783          	lbu	a5,0(a5)
    80201b5c:	00078713          	mv	a4,a5
    80201b60:	05800793          	li	a5,88
    80201b64:	00f71663          	bne	a4,a5,80201b70 <vprintfmt+0x498>
    80201b68:	05800793          	li	a5,88
    80201b6c:	0080006f          	j	80201b74 <vprintfmt+0x49c>
    80201b70:	07800793          	li	a5,120
    80201b74:	f5843703          	ld	a4,-168(s0)
    80201b78:	00078513          	mv	a0,a5
    80201b7c:	000700e7          	jalr	a4
                    written += 2;
    80201b80:	fec42783          	lw	a5,-20(s0)
    80201b84:	0027879b          	addiw	a5,a5,2
    80201b88:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201b8c:	fdc42783          	lw	a5,-36(s0)
    80201b90:	fcf42a23          	sw	a5,-44(s0)
    80201b94:	0280006f          	j	80201bbc <vprintfmt+0x4e4>
                    putch('0');
    80201b98:	f5843783          	ld	a5,-168(s0)
    80201b9c:	03000513          	li	a0,48
    80201ba0:	000780e7          	jalr	a5
                    ++written;
    80201ba4:	fec42783          	lw	a5,-20(s0)
    80201ba8:	0017879b          	addiw	a5,a5,1
    80201bac:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201bb0:	fd442783          	lw	a5,-44(s0)
    80201bb4:	0017879b          	addiw	a5,a5,1
    80201bb8:	fcf42a23          	sw	a5,-44(s0)
    80201bbc:	f8c42783          	lw	a5,-116(s0)
    80201bc0:	fd442703          	lw	a4,-44(s0)
    80201bc4:	0007071b          	sext.w	a4,a4
    80201bc8:	fcf748e3          	blt	a4,a5,80201b98 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201bcc:	fdc42783          	lw	a5,-36(s0)
    80201bd0:	fff7879b          	addiw	a5,a5,-1
    80201bd4:	fcf42823          	sw	a5,-48(s0)
    80201bd8:	03c0006f          	j	80201c14 <vprintfmt+0x53c>
                    putch(buf[i]);
    80201bdc:	fd042783          	lw	a5,-48(s0)
    80201be0:	ff078793          	addi	a5,a5,-16
    80201be4:	008787b3          	add	a5,a5,s0
    80201be8:	f807c783          	lbu	a5,-128(a5)
    80201bec:	0007871b          	sext.w	a4,a5
    80201bf0:	f5843783          	ld	a5,-168(s0)
    80201bf4:	00070513          	mv	a0,a4
    80201bf8:	000780e7          	jalr	a5
                    ++written;
    80201bfc:	fec42783          	lw	a5,-20(s0)
    80201c00:	0017879b          	addiw	a5,a5,1
    80201c04:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201c08:	fd042783          	lw	a5,-48(s0)
    80201c0c:	fff7879b          	addiw	a5,a5,-1
    80201c10:	fcf42823          	sw	a5,-48(s0)
    80201c14:	fd042783          	lw	a5,-48(s0)
    80201c18:	0007879b          	sext.w	a5,a5
    80201c1c:	fc07d0e3          	bgez	a5,80201bdc <vprintfmt+0x504>
                }

                flags.in_format = false;
    80201c20:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201c24:	2700006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201c28:	f5043783          	ld	a5,-176(s0)
    80201c2c:	0007c783          	lbu	a5,0(a5)
    80201c30:	00078713          	mv	a4,a5
    80201c34:	06400793          	li	a5,100
    80201c38:	02f70663          	beq	a4,a5,80201c64 <vprintfmt+0x58c>
    80201c3c:	f5043783          	ld	a5,-176(s0)
    80201c40:	0007c783          	lbu	a5,0(a5)
    80201c44:	00078713          	mv	a4,a5
    80201c48:	06900793          	li	a5,105
    80201c4c:	00f70c63          	beq	a4,a5,80201c64 <vprintfmt+0x58c>
    80201c50:	f5043783          	ld	a5,-176(s0)
    80201c54:	0007c783          	lbu	a5,0(a5)
    80201c58:	00078713          	mv	a4,a5
    80201c5c:	07500793          	li	a5,117
    80201c60:	08f71063          	bne	a4,a5,80201ce0 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    80201c64:	f8144783          	lbu	a5,-127(s0)
    80201c68:	00078c63          	beqz	a5,80201c80 <vprintfmt+0x5a8>
    80201c6c:	f4843783          	ld	a5,-184(s0)
    80201c70:	00878713          	addi	a4,a5,8
    80201c74:	f4e43423          	sd	a4,-184(s0)
    80201c78:	0007b783          	ld	a5,0(a5)
    80201c7c:	0140006f          	j	80201c90 <vprintfmt+0x5b8>
    80201c80:	f4843783          	ld	a5,-184(s0)
    80201c84:	00878713          	addi	a4,a5,8
    80201c88:	f4e43423          	sd	a4,-184(s0)
    80201c8c:	0007a783          	lw	a5,0(a5)
    80201c90:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201c94:	fa843583          	ld	a1,-88(s0)
    80201c98:	f5043783          	ld	a5,-176(s0)
    80201c9c:	0007c783          	lbu	a5,0(a5)
    80201ca0:	0007871b          	sext.w	a4,a5
    80201ca4:	07500793          	li	a5,117
    80201ca8:	40f707b3          	sub	a5,a4,a5
    80201cac:	00f037b3          	snez	a5,a5
    80201cb0:	0ff7f793          	zext.b	a5,a5
    80201cb4:	f8040713          	addi	a4,s0,-128
    80201cb8:	00070693          	mv	a3,a4
    80201cbc:	00078613          	mv	a2,a5
    80201cc0:	f5843503          	ld	a0,-168(s0)
    80201cc4:	ee4ff0ef          	jal	802013a8 <print_dec_int>
    80201cc8:	00050793          	mv	a5,a0
    80201ccc:	fec42703          	lw	a4,-20(s0)
    80201cd0:	00f707bb          	addw	a5,a4,a5
    80201cd4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201cd8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201cdc:	1b80006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    80201ce0:	f5043783          	ld	a5,-176(s0)
    80201ce4:	0007c783          	lbu	a5,0(a5)
    80201ce8:	00078713          	mv	a4,a5
    80201cec:	06e00793          	li	a5,110
    80201cf0:	04f71c63          	bne	a4,a5,80201d48 <vprintfmt+0x670>
                if (flags.longflag) {
    80201cf4:	f8144783          	lbu	a5,-127(s0)
    80201cf8:	02078463          	beqz	a5,80201d20 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    80201cfc:	f4843783          	ld	a5,-184(s0)
    80201d00:	00878713          	addi	a4,a5,8
    80201d04:	f4e43423          	sd	a4,-184(s0)
    80201d08:	0007b783          	ld	a5,0(a5)
    80201d0c:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201d10:	fec42703          	lw	a4,-20(s0)
    80201d14:	fb043783          	ld	a5,-80(s0)
    80201d18:	00e7b023          	sd	a4,0(a5)
    80201d1c:	0240006f          	j	80201d40 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    80201d20:	f4843783          	ld	a5,-184(s0)
    80201d24:	00878713          	addi	a4,a5,8
    80201d28:	f4e43423          	sd	a4,-184(s0)
    80201d2c:	0007b783          	ld	a5,0(a5)
    80201d30:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    80201d34:	fb843783          	ld	a5,-72(s0)
    80201d38:	fec42703          	lw	a4,-20(s0)
    80201d3c:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    80201d40:	f8040023          	sb	zero,-128(s0)
    80201d44:	1500006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    80201d48:	f5043783          	ld	a5,-176(s0)
    80201d4c:	0007c783          	lbu	a5,0(a5)
    80201d50:	00078713          	mv	a4,a5
    80201d54:	07300793          	li	a5,115
    80201d58:	02f71e63          	bne	a4,a5,80201d94 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    80201d5c:	f4843783          	ld	a5,-184(s0)
    80201d60:	00878713          	addi	a4,a5,8
    80201d64:	f4e43423          	sd	a4,-184(s0)
    80201d68:	0007b783          	ld	a5,0(a5)
    80201d6c:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    80201d70:	fc043583          	ld	a1,-64(s0)
    80201d74:	f5843503          	ld	a0,-168(s0)
    80201d78:	da8ff0ef          	jal	80201320 <puts_wo_nl>
    80201d7c:	00050793          	mv	a5,a0
    80201d80:	fec42703          	lw	a4,-20(s0)
    80201d84:	00f707bb          	addw	a5,a4,a5
    80201d88:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201d8c:	f8040023          	sb	zero,-128(s0)
    80201d90:	1040006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    80201d94:	f5043783          	ld	a5,-176(s0)
    80201d98:	0007c783          	lbu	a5,0(a5)
    80201d9c:	00078713          	mv	a4,a5
    80201da0:	06300793          	li	a5,99
    80201da4:	02f71e63          	bne	a4,a5,80201de0 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    80201da8:	f4843783          	ld	a5,-184(s0)
    80201dac:	00878713          	addi	a4,a5,8
    80201db0:	f4e43423          	sd	a4,-184(s0)
    80201db4:	0007a783          	lw	a5,0(a5)
    80201db8:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201dbc:	fcc42703          	lw	a4,-52(s0)
    80201dc0:	f5843783          	ld	a5,-168(s0)
    80201dc4:	00070513          	mv	a0,a4
    80201dc8:	000780e7          	jalr	a5
                ++written;
    80201dcc:	fec42783          	lw	a5,-20(s0)
    80201dd0:	0017879b          	addiw	a5,a5,1
    80201dd4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201dd8:	f8040023          	sb	zero,-128(s0)
    80201ddc:	0b80006f          	j	80201e94 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    80201de0:	f5043783          	ld	a5,-176(s0)
    80201de4:	0007c783          	lbu	a5,0(a5)
    80201de8:	00078713          	mv	a4,a5
    80201dec:	02500793          	li	a5,37
    80201df0:	02f71263          	bne	a4,a5,80201e14 <vprintfmt+0x73c>
                putch('%');
    80201df4:	f5843783          	ld	a5,-168(s0)
    80201df8:	02500513          	li	a0,37
    80201dfc:	000780e7          	jalr	a5
                ++written;
    80201e00:	fec42783          	lw	a5,-20(s0)
    80201e04:	0017879b          	addiw	a5,a5,1
    80201e08:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201e0c:	f8040023          	sb	zero,-128(s0)
    80201e10:	0840006f          	j	80201e94 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    80201e14:	f5043783          	ld	a5,-176(s0)
    80201e18:	0007c783          	lbu	a5,0(a5)
    80201e1c:	0007871b          	sext.w	a4,a5
    80201e20:	f5843783          	ld	a5,-168(s0)
    80201e24:	00070513          	mv	a0,a4
    80201e28:	000780e7          	jalr	a5
                ++written;
    80201e2c:	fec42783          	lw	a5,-20(s0)
    80201e30:	0017879b          	addiw	a5,a5,1
    80201e34:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201e38:	f8040023          	sb	zero,-128(s0)
    80201e3c:	0580006f          	j	80201e94 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    80201e40:	f5043783          	ld	a5,-176(s0)
    80201e44:	0007c783          	lbu	a5,0(a5)
    80201e48:	00078713          	mv	a4,a5
    80201e4c:	02500793          	li	a5,37
    80201e50:	02f71063          	bne	a4,a5,80201e70 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    80201e54:	f8043023          	sd	zero,-128(s0)
    80201e58:	f8043423          	sd	zero,-120(s0)
    80201e5c:	00100793          	li	a5,1
    80201e60:	f8f40023          	sb	a5,-128(s0)
    80201e64:	fff00793          	li	a5,-1
    80201e68:	f8f42623          	sw	a5,-116(s0)
    80201e6c:	0280006f          	j	80201e94 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    80201e70:	f5043783          	ld	a5,-176(s0)
    80201e74:	0007c783          	lbu	a5,0(a5)
    80201e78:	0007871b          	sext.w	a4,a5
    80201e7c:	f5843783          	ld	a5,-168(s0)
    80201e80:	00070513          	mv	a0,a4
    80201e84:	000780e7          	jalr	a5
            ++written;
    80201e88:	fec42783          	lw	a5,-20(s0)
    80201e8c:	0017879b          	addiw	a5,a5,1
    80201e90:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201e94:	f5043783          	ld	a5,-176(s0)
    80201e98:	00178793          	addi	a5,a5,1
    80201e9c:	f4f43823          	sd	a5,-176(s0)
    80201ea0:	f5043783          	ld	a5,-176(s0)
    80201ea4:	0007c783          	lbu	a5,0(a5)
    80201ea8:	84079ee3          	bnez	a5,80201704 <vprintfmt+0x2c>
        }
    }

    return written;
    80201eac:	fec42783          	lw	a5,-20(s0)
}
    80201eb0:	00078513          	mv	a0,a5
    80201eb4:	0b813083          	ld	ra,184(sp)
    80201eb8:	0b013403          	ld	s0,176(sp)
    80201ebc:	0c010113          	addi	sp,sp,192
    80201ec0:	00008067          	ret

0000000080201ec4 <printk>:

int printk(const char* s, ...) {
    80201ec4:	f9010113          	addi	sp,sp,-112
    80201ec8:	02113423          	sd	ra,40(sp)
    80201ecc:	02813023          	sd	s0,32(sp)
    80201ed0:	03010413          	addi	s0,sp,48
    80201ed4:	fca43c23          	sd	a0,-40(s0)
    80201ed8:	00b43423          	sd	a1,8(s0)
    80201edc:	00c43823          	sd	a2,16(s0)
    80201ee0:	00d43c23          	sd	a3,24(s0)
    80201ee4:	02e43023          	sd	a4,32(s0)
    80201ee8:	02f43423          	sd	a5,40(s0)
    80201eec:	03043823          	sd	a6,48(s0)
    80201ef0:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201ef4:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201ef8:	04040793          	addi	a5,s0,64
    80201efc:	fcf43823          	sd	a5,-48(s0)
    80201f00:	fd043783          	ld	a5,-48(s0)
    80201f04:	fc878793          	addi	a5,a5,-56
    80201f08:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201f0c:	fe043783          	ld	a5,-32(s0)
    80201f10:	00078613          	mv	a2,a5
    80201f14:	fd843583          	ld	a1,-40(s0)
    80201f18:	fffff517          	auipc	a0,0xfffff
    80201f1c:	0ec50513          	addi	a0,a0,236 # 80201004 <putc>
    80201f20:	fb8ff0ef          	jal	802016d8 <vprintfmt>
    80201f24:	00050793          	mv	a5,a0
    80201f28:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    80201f2c:	fec42783          	lw	a5,-20(s0)
}
    80201f30:	00078513          	mv	a0,a5
    80201f34:	02813083          	ld	ra,40(sp)
    80201f38:	02013403          	ld	s0,32(sp)
    80201f3c:	07010113          	addi	sp,sp,112
    80201f40:	00008067          	ret

0000000080201f44 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
    80201f44:	fe010113          	addi	sp,sp,-32
    80201f48:	00113c23          	sd	ra,24(sp)
    80201f4c:	00813823          	sd	s0,16(sp)
    80201f50:	02010413          	addi	s0,sp,32
    80201f54:	00050793          	mv	a5,a0
    80201f58:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
    80201f5c:	fec42783          	lw	a5,-20(s0)
    80201f60:	fff7879b          	addiw	a5,a5,-1
    80201f64:	0007879b          	sext.w	a5,a5
    80201f68:	02079713          	slli	a4,a5,0x20
    80201f6c:	02075713          	srli	a4,a4,0x20
    80201f70:	00004797          	auipc	a5,0x4
    80201f74:	10078793          	addi	a5,a5,256 # 80206070 <seed>
    80201f78:	00e7b023          	sd	a4,0(a5)
}
    80201f7c:	00000013          	nop
    80201f80:	01813083          	ld	ra,24(sp)
    80201f84:	01013403          	ld	s0,16(sp)
    80201f88:	02010113          	addi	sp,sp,32
    80201f8c:	00008067          	ret

0000000080201f90 <rand>:

int rand(void) {
    80201f90:	ff010113          	addi	sp,sp,-16
    80201f94:	00113423          	sd	ra,8(sp)
    80201f98:	00813023          	sd	s0,0(sp)
    80201f9c:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
    80201fa0:	00004797          	auipc	a5,0x4
    80201fa4:	0d078793          	addi	a5,a5,208 # 80206070 <seed>
    80201fa8:	0007b703          	ld	a4,0(a5)
    80201fac:	00001797          	auipc	a5,0x1
    80201fb0:	28c78793          	addi	a5,a5,652 # 80203238 <lowerxdigits.0+0x18>
    80201fb4:	0007b783          	ld	a5,0(a5)
    80201fb8:	02f707b3          	mul	a5,a4,a5
    80201fbc:	00178713          	addi	a4,a5,1
    80201fc0:	00004797          	auipc	a5,0x4
    80201fc4:	0b078793          	addi	a5,a5,176 # 80206070 <seed>
    80201fc8:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
    80201fcc:	00004797          	auipc	a5,0x4
    80201fd0:	0a478793          	addi	a5,a5,164 # 80206070 <seed>
    80201fd4:	0007b783          	ld	a5,0(a5)
    80201fd8:	0217d793          	srli	a5,a5,0x21
    80201fdc:	0007879b          	sext.w	a5,a5
}
    80201fe0:	00078513          	mv	a0,a5
    80201fe4:	00813083          	ld	ra,8(sp)
    80201fe8:	00013403          	ld	s0,0(sp)
    80201fec:	01010113          	addi	sp,sp,16
    80201ff0:	00008067          	ret

0000000080201ff4 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
    80201ff4:	fc010113          	addi	sp,sp,-64
    80201ff8:	02113c23          	sd	ra,56(sp)
    80201ffc:	02813823          	sd	s0,48(sp)
    80202000:	04010413          	addi	s0,sp,64
    80202004:	fca43c23          	sd	a0,-40(s0)
    80202008:	00058793          	mv	a5,a1
    8020200c:	fcc43423          	sd	a2,-56(s0)
    80202010:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
    80202014:	fd843783          	ld	a5,-40(s0)
    80202018:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
    8020201c:	fe043423          	sd	zero,-24(s0)
    80202020:	0280006f          	j	80202048 <memset+0x54>
        s[i] = c;
    80202024:	fe043703          	ld	a4,-32(s0)
    80202028:	fe843783          	ld	a5,-24(s0)
    8020202c:	00f707b3          	add	a5,a4,a5
    80202030:	fd442703          	lw	a4,-44(s0)
    80202034:	0ff77713          	zext.b	a4,a4
    80202038:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
    8020203c:	fe843783          	ld	a5,-24(s0)
    80202040:	00178793          	addi	a5,a5,1
    80202044:	fef43423          	sd	a5,-24(s0)
    80202048:	fe843703          	ld	a4,-24(s0)
    8020204c:	fc843783          	ld	a5,-56(s0)
    80202050:	fcf76ae3          	bltu	a4,a5,80202024 <memset+0x30>
    }
    return dest;
    80202054:	fd843783          	ld	a5,-40(s0)
}
    80202058:	00078513          	mv	a0,a5
    8020205c:	03813083          	ld	ra,56(sp)
    80202060:	03013403          	ld	s0,48(sp)
    80202064:	04010113          	addi	sp,sp,64
    80202068:	00008067          	ret
