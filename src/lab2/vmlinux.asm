
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer
    80200000:	00003117          	auipc	sp,0x3
    80200004:	02013103          	ld	sp,32(sp) # 80203020 <_GLOBAL_OFFSET_TABLE_+0x18>

    call mm_init
    80200008:	3b0000ef          	jal	802003b8 <mm_init>
    call task_init
    8020000c:	3f0000ef          	jal	802003fc <task_init>

    la t0, _traps
    80200010:	00003297          	auipc	t0,0x3
    80200014:	0202b283          	ld	t0,32(t0) # 80203030 <_GLOBAL_OFFSET_TABLE_+0x28>
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
    80200030:	5cd000ef          	jal	80200dfc <start_kernel>

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
    802000c8:	4cd000ef          	jal	80200d94 <trap_handler>
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
    8020015c:	00003297          	auipc	t0,0x3
    80200160:	ecc2b283          	ld	t0,-308(t0) # 80203028 <_GLOBAL_OFFSET_TABLE_+0x20>
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
    80200230:	00003797          	auipc	a5,0x3
    80200234:	dd078793          	addi	a5,a5,-560 # 80203000 <TIMECLOCK>
    80200238:	0007b783          	ld	a5,0(a5)
    8020023c:	00f707b3          	add	a5,a4,a5
    80200240:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    80200244:	fe843503          	ld	a0,-24(s0)
    80200248:	199000ef          	jal	80200be0 <sbi_set_timer>
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
    80200270:	00005797          	auipc	a5,0x5
    80200274:	d9078793          	addi	a5,a5,-624 # 80205000 <kmem>
    80200278:	0007b783          	ld	a5,0(a5)
    8020027c:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
    80200280:	fe843783          	ld	a5,-24(s0)
    80200284:	0007b703          	ld	a4,0(a5)
    80200288:	00005797          	auipc	a5,0x5
    8020028c:	d7878793          	addi	a5,a5,-648 # 80205000 <kmem>
    80200290:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
    80200294:	00001637          	lui	a2,0x1
    80200298:	00000593          	li	a1,0
    8020029c:	fe843503          	ld	a0,-24(s0)
    802002a0:	439010ef          	jal	80201ed8 <memset>
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
    802002f8:	3e1010ef          	jal	80201ed8 <memset>

    r = (struct run *)addr;
    802002fc:	fd843783          	ld	a5,-40(s0)
    80200300:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
    80200304:	00005797          	auipc	a5,0x5
    80200308:	cfc78793          	addi	a5,a5,-772 # 80205000 <kmem>
    8020030c:	0007b703          	ld	a4,0(a5)
    80200310:	fe843783          	ld	a5,-24(s0)
    80200314:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
    80200318:	00005797          	auipc	a5,0x5
    8020031c:	ce878793          	addi	a5,a5,-792 # 80205000 <kmem>
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
    802003d0:	00003517          	auipc	a0,0x3
    802003d4:	c4053503          	ld	a0,-960(a0) # 80203010 <_GLOBAL_OFFSET_TABLE_+0x8>
    802003d8:	f65ff0ef          	jal	8020033c <kfreerange>
    printk("...mm_init done!\n");
    802003dc:	00002517          	auipc	a0,0x2
    802003e0:	c2450513          	addi	a0,a0,-988 # 80202000 <_srodata>
    802003e4:	1c5010ef          	jal	80201da8 <printk>
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
    80200410:	219010ef          	jal	80201e28 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
    80200414:	e4dff0ef          	jal	80200260 <kalloc>
    80200418:	00050713          	mv	a4,a0
    8020041c:	00005797          	auipc	a5,0x5
    80200420:	bec78793          	addi	a5,a5,-1044 # 80205008 <idle>
    80200424:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
    80200428:	00005797          	auipc	a5,0x5
    8020042c:	be078793          	addi	a5,a5,-1056 # 80205008 <idle>
    80200430:	0007b783          	ld	a5,0(a5)
    80200434:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
    80200438:	00005797          	auipc	a5,0x5
    8020043c:	bd078793          	addi	a5,a5,-1072 # 80205008 <idle>
    80200440:	0007b783          	ld	a5,0(a5)
    80200444:	0007b823          	sd	zero,16(a5)
    80200448:	00005717          	auipc	a4,0x5
    8020044c:	bc070713          	addi	a4,a4,-1088 # 80205008 <idle>
    80200450:	00073703          	ld	a4,0(a4)
    80200454:	0107b783          	ld	a5,16(a5)
    80200458:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
    8020045c:	00005797          	auipc	a5,0x5
    80200460:	bac78793          	addi	a5,a5,-1108 # 80205008 <idle>
    80200464:	0007b783          	ld	a5,0(a5)
    80200468:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
    8020046c:	00005797          	auipc	a5,0x5
    80200470:	b9c78793          	addi	a5,a5,-1124 # 80205008 <idle>
    80200474:	0007b703          	ld	a4,0(a5)
    80200478:	00005797          	auipc	a5,0x5
    8020047c:	ba078793          	addi	a5,a5,-1120 # 80205018 <task>
    80200480:	00e7b023          	sd	a4,0(a5)
    80200484:	00005797          	auipc	a5,0x5
    80200488:	b9478793          	addi	a5,a5,-1132 # 80205018 <task>
    8020048c:	0007b703          	ld	a4,0(a5)
    80200490:	00005797          	auipc	a5,0x5
    80200494:	b8078793          	addi	a5,a5,-1152 # 80205010 <current>
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
    802004b0:	00005717          	auipc	a4,0x5
    802004b4:	b6870713          	addi	a4,a4,-1176 # 80205018 <task>
    802004b8:	fec42783          	lw	a5,-20(s0)
    802004bc:	00379793          	slli	a5,a5,0x3
    802004c0:	00f707b3          	add	a5,a4,a5
    802004c4:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
    802004c8:	00005717          	auipc	a4,0x5
    802004cc:	b5070713          	addi	a4,a4,-1200 # 80205018 <task>
    802004d0:	fec42783          	lw	a5,-20(s0)
    802004d4:	00379793          	slli	a5,a5,0x3
    802004d8:	00f707b3          	add	a5,a4,a5
    802004dc:	0007b783          	ld	a5,0(a5)
    802004e0:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
    802004e4:	00005717          	auipc	a4,0x5
    802004e8:	b3470713          	addi	a4,a4,-1228 # 80205018 <task>
    802004ec:	fec42783          	lw	a5,-20(s0)
    802004f0:	00379793          	slli	a5,a5,0x3
    802004f4:	00f707b3          	add	a5,a4,a5
    802004f8:	0007b783          	ld	a5,0(a5)
    802004fc:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
    80200500:	175010ef          	jal	80201e74 <rand>
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
    80200554:	00005717          	auipc	a4,0x5
    80200558:	ac470713          	addi	a4,a4,-1340 # 80205018 <task>
    8020055c:	fec42783          	lw	a5,-20(s0)
    80200560:	00379793          	slli	a5,a5,0x3
    80200564:	00f707b3          	add	a5,a4,a5
    80200568:	0007b783          	ld	a5,0(a5)
    8020056c:	00068713          	mv	a4,a3
    80200570:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
    80200574:	00005717          	auipc	a4,0x5
    80200578:	aa470713          	addi	a4,a4,-1372 # 80205018 <task>
    8020057c:	fec42783          	lw	a5,-20(s0)
    80200580:	00379793          	slli	a5,a5,0x3
    80200584:	00f707b3          	add	a5,a4,a5
    80200588:	0007b783          	ld	a5,0(a5)
    8020058c:	fec42703          	lw	a4,-20(s0)
    80200590:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
    80200594:	00005717          	auipc	a4,0x5
    80200598:	a8470713          	addi	a4,a4,-1404 # 80205018 <task>
    8020059c:	fec42783          	lw	a5,-20(s0)
    802005a0:	00379793          	slli	a5,a5,0x3
    802005a4:	00f707b3          	add	a5,a4,a5
    802005a8:	0007b783          	ld	a5,0(a5)
    802005ac:	00003717          	auipc	a4,0x3
    802005b0:	a6c73703          	ld	a4,-1428(a4) # 80203018 <_GLOBAL_OFFSET_TABLE_+0x10>
    802005b4:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
    802005b8:	00005717          	auipc	a4,0x5
    802005bc:	a6070713          	addi	a4,a4,-1440 # 80205018 <task>
    802005c0:	fec42783          	lw	a5,-20(s0)
    802005c4:	00379793          	slli	a5,a5,0x3
    802005c8:	00f707b3          	add	a5,a4,a5
    802005cc:	0007b783          	ld	a5,0(a5)
    802005d0:	00078693          	mv	a3,a5
    802005d4:	00005717          	auipc	a4,0x5
    802005d8:	a4470713          	addi	a4,a4,-1468 # 80205018 <task>
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
    8020060c:	00200793          	li	a5,2
    80200610:	e8e7dce3          	bge	a5,a4,802004a8 <task_init+0xac>
    }
    printk("...task_init done!\n");
    80200614:	00002517          	auipc	a0,0x2
    80200618:	a0450513          	addi	a0,a0,-1532 # 80202018 <_srodata+0x18>
    8020061c:	78c010ef          	jal	80201da8 <printk>
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
    8020066c:	00005797          	auipc	a5,0x5
    80200670:	9a478793          	addi	a5,a5,-1628 # 80205010 <current>
    80200674:	0007b783          	ld	a5,0(a5)
    80200678:	0087b703          	ld	a4,8(a5)
    8020067c:	fe442783          	lw	a5,-28(s0)
    80200680:	fcf70ee3          	beq	a4,a5,8020065c <dummy+0x28>
    80200684:	00005797          	auipc	a5,0x5
    80200688:	98c78793          	addi	a5,a5,-1652 # 80205010 <current>
    8020068c:	0007b783          	ld	a5,0(a5)
    80200690:	0087b783          	ld	a5,8(a5)
    80200694:	fc0784e3          	beqz	a5,8020065c <dummy+0x28>
            if (current->counter == 1) {
    80200698:	00005797          	auipc	a5,0x5
    8020069c:	97878793          	addi	a5,a5,-1672 # 80205010 <current>
    802006a0:	0007b783          	ld	a5,0(a5)
    802006a4:	0087b703          	ld	a4,8(a5)
    802006a8:	00100793          	li	a5,1
    802006ac:	00f71e63          	bne	a4,a5,802006c8 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
    802006b0:	00005797          	auipc	a5,0x5
    802006b4:	96078793          	addi	a5,a5,-1696 # 80205010 <current>
    802006b8:	0007b783          	ld	a5,0(a5)
    802006bc:	0087b703          	ld	a4,8(a5)
    802006c0:	fff70713          	addi	a4,a4,-1 # fff <_skernel-0x801ff001>
    802006c4:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
    802006c8:	00005797          	auipc	a5,0x5
    802006cc:	94878793          	addi	a5,a5,-1720 # 80205010 <current>
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
    802006f0:	00005797          	auipc	a5,0x5
    802006f4:	92078793          	addi	a5,a5,-1760 # 80205010 <current>
    802006f8:	0007b783          	ld	a5,0(a5)
    802006fc:	0187b783          	ld	a5,24(a5)
    80200700:	fe843603          	ld	a2,-24(s0)
    80200704:	00078593          	mv	a1,a5
    80200708:	00002517          	auipc	a0,0x2
    8020070c:	92850513          	addi	a0,a0,-1752 # 80202030 <_srodata+0x30>
    80200710:	698010ef          	jal	80201da8 <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200714:	f49ff06f          	j	8020065c <dummy+0x28>

0000000080200718 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    80200718:	fe010113          	addi	sp,sp,-32
    8020071c:	00113c23          	sd	ra,24(sp)
    80200720:	00813823          	sd	s0,16(sp)
    80200724:	02010413          	addi	s0,sp,32
    80200728:	fea43423          	sd	a0,-24(s0)
    if(current->pid != next->pid) {
    8020072c:	00005797          	auipc	a5,0x5
    80200730:	8e478793          	addi	a5,a5,-1820 # 80205010 <current>
    80200734:	0007b783          	ld	a5,0(a5)
    80200738:	0187b703          	ld	a4,24(a5)
    8020073c:	fe843783          	ld	a5,-24(s0)
    80200740:	0187b783          	ld	a5,24(a5)
    80200744:	06f70863          	beq	a4,a5,802007b4 <switch_to+0x9c>
        __switch_to(current, next);
    80200748:	00005797          	auipc	a5,0x5
    8020074c:	8c878793          	addi	a5,a5,-1848 # 80205010 <current>
    80200750:	0007b783          	ld	a5,0(a5)
    80200754:	fe843583          	ld	a1,-24(s0)
    80200758:	00078513          	mv	a0,a5
    8020075c:	a11ff0ef          	jal	8020016c <__switch_to>
        current = next;
    80200760:	00005797          	auipc	a5,0x5
    80200764:	8b078793          	addi	a5,a5,-1872 # 80205010 <current>
    80200768:	fe843703          	ld	a4,-24(s0)
    8020076c:	00e7b023          	sd	a4,0(a5)
        printk("switch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
    80200770:	00005797          	auipc	a5,0x5
    80200774:	8a078793          	addi	a5,a5,-1888 # 80205010 <current>
    80200778:	0007b783          	ld	a5,0(a5)
    8020077c:	0187b703          	ld	a4,24(a5)
    80200780:	00005797          	auipc	a5,0x5
    80200784:	89078793          	addi	a5,a5,-1904 # 80205010 <current>
    80200788:	0007b783          	ld	a5,0(a5)
    8020078c:	0107b603          	ld	a2,16(a5)
    80200790:	00005797          	auipc	a5,0x5
    80200794:	88078793          	addi	a5,a5,-1920 # 80205010 <current>
    80200798:	0007b783          	ld	a5,0(a5)
    8020079c:	0087b783          	ld	a5,8(a5)
    802007a0:	00078693          	mv	a3,a5
    802007a4:	00070593          	mv	a1,a4
    802007a8:	00002517          	auipc	a0,0x2
    802007ac:	8b850513          	addi	a0,a0,-1864 # 80202060 <_srodata+0x60>
    802007b0:	5f8010ef          	jal	80201da8 <printk>
    }
}
    802007b4:	00000013          	nop
    802007b8:	01813083          	ld	ra,24(sp)
    802007bc:	01013403          	ld	s0,16(sp)
    802007c0:	02010113          	addi	sp,sp,32
    802007c4:	00008067          	ret

00000000802007c8 <do_timer>:

void do_timer() {
    802007c8:	ff010113          	addi	sp,sp,-16
    802007cc:	00113423          	sd	ra,8(sp)
    802007d0:	00813023          	sd	s0,0(sp)
    802007d4:	01010413          	addi	s0,sp,16
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
    802007d8:	00005797          	auipc	a5,0x5
    802007dc:	83878793          	addi	a5,a5,-1992 # 80205010 <current>
    802007e0:	0007b783          	ld	a5,0(a5)
    802007e4:	0187b703          	ld	a4,24(a5)
    802007e8:	00005797          	auipc	a5,0x5
    802007ec:	82078793          	addi	a5,a5,-2016 # 80205008 <idle>
    802007f0:	0007b783          	ld	a5,0(a5)
    802007f4:	0187b783          	ld	a5,24(a5)
    802007f8:	00f70c63          	beq	a4,a5,80200810 <do_timer+0x48>
    802007fc:	00005797          	auipc	a5,0x5
    80200800:	81478793          	addi	a5,a5,-2028 # 80205010 <current>
    80200804:	0007b783          	ld	a5,0(a5)
    80200808:	0087b783          	ld	a5,8(a5)
    8020080c:	00079663          	bnez	a5,80200818 <do_timer+0x50>
        schedule();
    80200810:	040000ef          	jal	80200850 <schedule>
    }
    else if(--(current->counter) == 0) {
        schedule();
    }
}
    80200814:	0280006f          	j	8020083c <do_timer+0x74>
    else if(--(current->counter) == 0) {
    80200818:	00004797          	auipc	a5,0x4
    8020081c:	7f878793          	addi	a5,a5,2040 # 80205010 <current>
    80200820:	0007b783          	ld	a5,0(a5)
    80200824:	0087b703          	ld	a4,8(a5)
    80200828:	fff70713          	addi	a4,a4,-1
    8020082c:	00e7b423          	sd	a4,8(a5)
    80200830:	0087b783          	ld	a5,8(a5)
    80200834:	00079463          	bnez	a5,8020083c <do_timer+0x74>
        schedule();
    80200838:	018000ef          	jal	80200850 <schedule>
}
    8020083c:	00000013          	nop
    80200840:	00813083          	ld	ra,8(sp)
    80200844:	00013403          	ld	s0,0(sp)
    80200848:	01010113          	addi	sp,sp,16
    8020084c:	00008067          	ret

0000000080200850 <schedule>:

void schedule() {
    80200850:	fe010113          	addi	sp,sp,-32
    80200854:	00113c23          	sd	ra,24(sp)
    80200858:	00813823          	sd	s0,16(sp)
    8020085c:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    struct task_struct *next = idle;
    80200860:	00004797          	auipc	a5,0x4
    80200864:	7a878793          	addi	a5,a5,1960 # 80205008 <idle>
    80200868:	0007b783          	ld	a5,0(a5)
    8020086c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    80200870:	00100793          	li	a5,1
    80200874:	fef42223          	sw	a5,-28(s0)
    80200878:	0540006f          	j	802008cc <schedule+0x7c>
        if(task[i]->counter > next->counter){
    8020087c:	00004717          	auipc	a4,0x4
    80200880:	79c70713          	addi	a4,a4,1948 # 80205018 <task>
    80200884:	fe442783          	lw	a5,-28(s0)
    80200888:	00379793          	slli	a5,a5,0x3
    8020088c:	00f707b3          	add	a5,a4,a5
    80200890:	0007b783          	ld	a5,0(a5)
    80200894:	0087b703          	ld	a4,8(a5)
    80200898:	fe843783          	ld	a5,-24(s0)
    8020089c:	0087b783          	ld	a5,8(a5)
    802008a0:	02e7f063          	bgeu	a5,a4,802008c0 <schedule+0x70>
            next = task[i];
    802008a4:	00004717          	auipc	a4,0x4
    802008a8:	77470713          	addi	a4,a4,1908 # 80205018 <task>
    802008ac:	fe442783          	lw	a5,-28(s0)
    802008b0:	00379793          	slli	a5,a5,0x3
    802008b4:	00f707b3          	add	a5,a4,a5
    802008b8:	0007b783          	ld	a5,0(a5)
    802008bc:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    802008c0:	fe442783          	lw	a5,-28(s0)
    802008c4:	0017879b          	addiw	a5,a5,1
    802008c8:	fef42223          	sw	a5,-28(s0)
    802008cc:	fe442783          	lw	a5,-28(s0)
    802008d0:	0007871b          	sext.w	a4,a5
    802008d4:	00200793          	li	a5,2
    802008d8:	fae7d2e3          	bge	a5,a4,8020087c <schedule+0x2c>
        }
    }

    if(next->counter == 0) {
    802008dc:	fe843783          	ld	a5,-24(s0)
    802008e0:	0087b783          	ld	a5,8(a5)
    802008e4:	0c079e63          	bnez	a5,802009c0 <schedule+0x170>
        for(int i = 1; i < NR_TASKS; ++i) {
    802008e8:	00100793          	li	a5,1
    802008ec:	fef42023          	sw	a5,-32(s0)
    802008f0:	0ac0006f          	j	8020099c <schedule+0x14c>
            task[i]->counter = task[i]->priority;
    802008f4:	00004717          	auipc	a4,0x4
    802008f8:	72470713          	addi	a4,a4,1828 # 80205018 <task>
    802008fc:	fe042783          	lw	a5,-32(s0)
    80200900:	00379793          	slli	a5,a5,0x3
    80200904:	00f707b3          	add	a5,a4,a5
    80200908:	0007b703          	ld	a4,0(a5)
    8020090c:	00004697          	auipc	a3,0x4
    80200910:	70c68693          	addi	a3,a3,1804 # 80205018 <task>
    80200914:	fe042783          	lw	a5,-32(s0)
    80200918:	00379793          	slli	a5,a5,0x3
    8020091c:	00f687b3          	add	a5,a3,a5
    80200920:	0007b783          	ld	a5,0(a5)
    80200924:	01073703          	ld	a4,16(a4)
    80200928:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
    8020092c:	00004717          	auipc	a4,0x4
    80200930:	6ec70713          	addi	a4,a4,1772 # 80205018 <task>
    80200934:	fe042783          	lw	a5,-32(s0)
    80200938:	00379793          	slli	a5,a5,0x3
    8020093c:	00f707b3          	add	a5,a4,a5
    80200940:	0007b783          	ld	a5,0(a5)
    80200944:	0187b583          	ld	a1,24(a5)
    80200948:	00004717          	auipc	a4,0x4
    8020094c:	6d070713          	addi	a4,a4,1744 # 80205018 <task>
    80200950:	fe042783          	lw	a5,-32(s0)
    80200954:	00379793          	slli	a5,a5,0x3
    80200958:	00f707b3          	add	a5,a4,a5
    8020095c:	0007b783          	ld	a5,0(a5)
    80200960:	0107b603          	ld	a2,16(a5)
    80200964:	00004717          	auipc	a4,0x4
    80200968:	6b470713          	addi	a4,a4,1716 # 80205018 <task>
    8020096c:	fe042783          	lw	a5,-32(s0)
    80200970:	00379793          	slli	a5,a5,0x3
    80200974:	00f707b3          	add	a5,a4,a5
    80200978:	0007b783          	ld	a5,0(a5)
    8020097c:	0087b783          	ld	a5,8(a5)
    80200980:	00078693          	mv	a3,a5
    80200984:	00001517          	auipc	a0,0x1
    80200988:	71450513          	addi	a0,a0,1812 # 80202098 <_srodata+0x98>
    8020098c:	41c010ef          	jal	80201da8 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
    80200990:	fe042783          	lw	a5,-32(s0)
    80200994:	0017879b          	addiw	a5,a5,1
    80200998:	fef42023          	sw	a5,-32(s0)
    8020099c:	fe042783          	lw	a5,-32(s0)
    802009a0:	0007871b          	sext.w	a4,a5
    802009a4:	00200793          	li	a5,2
    802009a8:	f4e7d6e3          	bge	a5,a4,802008f4 <schedule+0xa4>
        }
        printk("\n");
    802009ac:	00001517          	auipc	a0,0x1
    802009b0:	72450513          	addi	a0,a0,1828 # 802020d0 <_srodata+0xd0>
    802009b4:	3f4010ef          	jal	80201da8 <printk>
        return (void)(schedule());
    802009b8:	e99ff0ef          	jal	80200850 <schedule>
    802009bc:	00c0006f          	j	802009c8 <schedule+0x178>
    }

    switch_to(next);
    802009c0:	fe843503          	ld	a0,-24(s0)
    802009c4:	d55ff0ef          	jal	80200718 <switch_to>
    802009c8:	01813083          	ld	ra,24(sp)
    802009cc:	01013403          	ld	s0,16(sp)
    802009d0:	02010113          	addi	sp,sp,32
    802009d4:	00008067          	ret

00000000802009d8 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    802009d8:	f7010113          	addi	sp,sp,-144
    802009dc:	08113423          	sd	ra,136(sp)
    802009e0:	08813023          	sd	s0,128(sp)
    802009e4:	06913c23          	sd	s1,120(sp)
    802009e8:	07213823          	sd	s2,112(sp)
    802009ec:	07313423          	sd	s3,104(sp)
    802009f0:	09010413          	addi	s0,sp,144
    802009f4:	faa43423          	sd	a0,-88(s0)
    802009f8:	fab43023          	sd	a1,-96(s0)
    802009fc:	f8c43c23          	sd	a2,-104(s0)
    80200a00:	f8d43823          	sd	a3,-112(s0)
    80200a04:	f8e43423          	sd	a4,-120(s0)
    80200a08:	f8f43023          	sd	a5,-128(s0)
    80200a0c:	f7043c23          	sd	a6,-136(s0)
    80200a10:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    80200a14:	fa843e03          	ld	t3,-88(s0)
    80200a18:	fa043e83          	ld	t4,-96(s0)
    80200a1c:	f9843f03          	ld	t5,-104(s0)
    80200a20:	f9043f83          	ld	t6,-112(s0)
    80200a24:	f8843283          	ld	t0,-120(s0)
    80200a28:	f8043483          	ld	s1,-128(s0)
    80200a2c:	f7843903          	ld	s2,-136(s0)
    80200a30:	f7043983          	ld	s3,-144(s0)
    80200a34:	000e0893          	mv	a7,t3
    80200a38:	000e8813          	mv	a6,t4
    80200a3c:	000f0513          	mv	a0,t5
    80200a40:	000f8593          	mv	a1,t6
    80200a44:	00028613          	mv	a2,t0
    80200a48:	00048693          	mv	a3,s1
    80200a4c:	00090713          	mv	a4,s2
    80200a50:	00098793          	mv	a5,s3
    80200a54:	00000073          	ecall
    80200a58:	00050e93          	mv	t4,a0
    80200a5c:	00058e13          	mv	t3,a1
    80200a60:	fbd43823          	sd	t4,-80(s0)
    80200a64:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    80200a68:	fb043783          	ld	a5,-80(s0)
    80200a6c:	fcf43023          	sd	a5,-64(s0)
    80200a70:	fb843783          	ld	a5,-72(s0)
    80200a74:	fcf43423          	sd	a5,-56(s0)
    80200a78:	fc043703          	ld	a4,-64(s0)
    80200a7c:	fc843783          	ld	a5,-56(s0)
    80200a80:	00070313          	mv	t1,a4
    80200a84:	00078393          	mv	t2,a5
    80200a88:	00030713          	mv	a4,t1
    80200a8c:	00038793          	mv	a5,t2
}
    80200a90:	00070513          	mv	a0,a4
    80200a94:	00078593          	mv	a1,a5
    80200a98:	08813083          	ld	ra,136(sp)
    80200a9c:	08013403          	ld	s0,128(sp)
    80200aa0:	07813483          	ld	s1,120(sp)
    80200aa4:	07013903          	ld	s2,112(sp)
    80200aa8:	06813983          	ld	s3,104(sp)
    80200aac:	09010113          	addi	sp,sp,144
    80200ab0:	00008067          	ret

0000000080200ab4 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    80200ab4:	fc010113          	addi	sp,sp,-64
    80200ab8:	02113c23          	sd	ra,56(sp)
    80200abc:	02813823          	sd	s0,48(sp)
    80200ac0:	03213423          	sd	s2,40(sp)
    80200ac4:	03313023          	sd	s3,32(sp)
    80200ac8:	04010413          	addi	s0,sp,64
    80200acc:	00050793          	mv	a5,a0
    80200ad0:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200ad4:	fcf44603          	lbu	a2,-49(s0)
    80200ad8:	00000893          	li	a7,0
    80200adc:	00000813          	li	a6,0
    80200ae0:	00000793          	li	a5,0
    80200ae4:	00000713          	li	a4,0
    80200ae8:	00000693          	li	a3,0
    80200aec:	00200593          	li	a1,2
    80200af0:	44424537          	lui	a0,0x44424
    80200af4:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200af8:	ee1ff0ef          	jal	802009d8 <sbi_ecall>
    80200afc:	00050713          	mv	a4,a0
    80200b00:	00058793          	mv	a5,a1
    80200b04:	fce43823          	sd	a4,-48(s0)
    80200b08:	fcf43c23          	sd	a5,-40(s0)
    80200b0c:	fd043703          	ld	a4,-48(s0)
    80200b10:	fd843783          	ld	a5,-40(s0)
    80200b14:	00070913          	mv	s2,a4
    80200b18:	00078993          	mv	s3,a5
    80200b1c:	00090713          	mv	a4,s2
    80200b20:	00098793          	mv	a5,s3
}
    80200b24:	00070513          	mv	a0,a4
    80200b28:	00078593          	mv	a1,a5
    80200b2c:	03813083          	ld	ra,56(sp)
    80200b30:	03013403          	ld	s0,48(sp)
    80200b34:	02813903          	ld	s2,40(sp)
    80200b38:	02013983          	ld	s3,32(sp)
    80200b3c:	04010113          	addi	sp,sp,64
    80200b40:	00008067          	ret

0000000080200b44 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    80200b44:	fc010113          	addi	sp,sp,-64
    80200b48:	02113c23          	sd	ra,56(sp)
    80200b4c:	02813823          	sd	s0,48(sp)
    80200b50:	03213423          	sd	s2,40(sp)
    80200b54:	03313023          	sd	s3,32(sp)
    80200b58:	04010413          	addi	s0,sp,64
    80200b5c:	00050793          	mv	a5,a0
    80200b60:	00058713          	mv	a4,a1
    80200b64:	fcf42623          	sw	a5,-52(s0)
    80200b68:	00070793          	mv	a5,a4
    80200b6c:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    80200b70:	fcc46603          	lwu	a2,-52(s0)
    80200b74:	fc846683          	lwu	a3,-56(s0)
    80200b78:	00000893          	li	a7,0
    80200b7c:	00000813          	li	a6,0
    80200b80:	00000793          	li	a5,0
    80200b84:	00000713          	li	a4,0
    80200b88:	00000593          	li	a1,0
    80200b8c:	53525537          	lui	a0,0x53525
    80200b90:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200b94:	e45ff0ef          	jal	802009d8 <sbi_ecall>
    80200b98:	00050713          	mv	a4,a0
    80200b9c:	00058793          	mv	a5,a1
    80200ba0:	fce43823          	sd	a4,-48(s0)
    80200ba4:	fcf43c23          	sd	a5,-40(s0)
    80200ba8:	fd043703          	ld	a4,-48(s0)
    80200bac:	fd843783          	ld	a5,-40(s0)
    80200bb0:	00070913          	mv	s2,a4
    80200bb4:	00078993          	mv	s3,a5
    80200bb8:	00090713          	mv	a4,s2
    80200bbc:	00098793          	mv	a5,s3
}
    80200bc0:	00070513          	mv	a0,a4
    80200bc4:	00078593          	mv	a1,a5
    80200bc8:	03813083          	ld	ra,56(sp)
    80200bcc:	03013403          	ld	s0,48(sp)
    80200bd0:	02813903          	ld	s2,40(sp)
    80200bd4:	02013983          	ld	s3,32(sp)
    80200bd8:	04010113          	addi	sp,sp,64
    80200bdc:	00008067          	ret

0000000080200be0 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    80200be0:	fc010113          	addi	sp,sp,-64
    80200be4:	02113c23          	sd	ra,56(sp)
    80200be8:	02813823          	sd	s0,48(sp)
    80200bec:	03213423          	sd	s2,40(sp)
    80200bf0:	03313023          	sd	s3,32(sp)
    80200bf4:	04010413          	addi	s0,sp,64
    80200bf8:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    80200bfc:	00000893          	li	a7,0
    80200c00:	00000813          	li	a6,0
    80200c04:	00000793          	li	a5,0
    80200c08:	00000713          	li	a4,0
    80200c0c:	00000693          	li	a3,0
    80200c10:	fc843603          	ld	a2,-56(s0)
    80200c14:	00000593          	li	a1,0
    80200c18:	54495537          	lui	a0,0x54495
    80200c1c:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200c20:	db9ff0ef          	jal	802009d8 <sbi_ecall>
    80200c24:	00050713          	mv	a4,a0
    80200c28:	00058793          	mv	a5,a1
    80200c2c:	fce43823          	sd	a4,-48(s0)
    80200c30:	fcf43c23          	sd	a5,-40(s0)
    80200c34:	fd043703          	ld	a4,-48(s0)
    80200c38:	fd843783          	ld	a5,-40(s0)
    80200c3c:	00070913          	mv	s2,a4
    80200c40:	00078993          	mv	s3,a5
    80200c44:	00090713          	mv	a4,s2
    80200c48:	00098793          	mv	a5,s3
}
    80200c4c:	00070513          	mv	a0,a4
    80200c50:	00078593          	mv	a1,a5
    80200c54:	03813083          	ld	ra,56(sp)
    80200c58:	03013403          	ld	s0,48(sp)
    80200c5c:	02813903          	ld	s2,40(sp)
    80200c60:	02013983          	ld	s3,32(sp)
    80200c64:	04010113          	addi	sp,sp,64
    80200c68:	00008067          	ret

0000000080200c6c <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    80200c6c:	fb010113          	addi	sp,sp,-80
    80200c70:	04113423          	sd	ra,72(sp)
    80200c74:	04813023          	sd	s0,64(sp)
    80200c78:	03213c23          	sd	s2,56(sp)
    80200c7c:	03313823          	sd	s3,48(sp)
    80200c80:	05010413          	addi	s0,sp,80
    80200c84:	fca43423          	sd	a0,-56(s0)
    80200c88:	fcb43023          	sd	a1,-64(s0)
    80200c8c:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200c90:	00000893          	li	a7,0
    80200c94:	00000813          	li	a6,0
    80200c98:	00000793          	li	a5,0
    80200c9c:	fb843703          	ld	a4,-72(s0)
    80200ca0:	fc043683          	ld	a3,-64(s0)
    80200ca4:	fc843603          	ld	a2,-56(s0)
    80200ca8:	00100593          	li	a1,1
    80200cac:	44424537          	lui	a0,0x44424
    80200cb0:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200cb4:	d25ff0ef          	jal	802009d8 <sbi_ecall>
    80200cb8:	00050713          	mv	a4,a0
    80200cbc:	00058793          	mv	a5,a1
    80200cc0:	fce43823          	sd	a4,-48(s0)
    80200cc4:	fcf43c23          	sd	a5,-40(s0)
    80200cc8:	fd043703          	ld	a4,-48(s0)
    80200ccc:	fd843783          	ld	a5,-40(s0)
    80200cd0:	00070913          	mv	s2,a4
    80200cd4:	00078993          	mv	s3,a5
    80200cd8:	00090713          	mv	a4,s2
    80200cdc:	00098793          	mv	a5,s3
}
    80200ce0:	00070513          	mv	a0,a4
    80200ce4:	00078593          	mv	a1,a5
    80200ce8:	04813083          	ld	ra,72(sp)
    80200cec:	04013403          	ld	s0,64(sp)
    80200cf0:	03813903          	ld	s2,56(sp)
    80200cf4:	03013983          	ld	s3,48(sp)
    80200cf8:	05010113          	addi	sp,sp,80
    80200cfc:	00008067          	ret

0000000080200d00 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    80200d00:	fb010113          	addi	sp,sp,-80
    80200d04:	04113423          	sd	ra,72(sp)
    80200d08:	04813023          	sd	s0,64(sp)
    80200d0c:	03213c23          	sd	s2,56(sp)
    80200d10:	03313823          	sd	s3,48(sp)
    80200d14:	05010413          	addi	s0,sp,80
    80200d18:	fca43423          	sd	a0,-56(s0)
    80200d1c:	fcb43023          	sd	a1,-64(s0)
    80200d20:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200d24:	00000893          	li	a7,0
    80200d28:	00000813          	li	a6,0
    80200d2c:	00000793          	li	a5,0
    80200d30:	fb843703          	ld	a4,-72(s0)
    80200d34:	fc043683          	ld	a3,-64(s0)
    80200d38:	fc843603          	ld	a2,-56(s0)
    80200d3c:	00000593          	li	a1,0
    80200d40:	44424537          	lui	a0,0x44424
    80200d44:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200d48:	c91ff0ef          	jal	802009d8 <sbi_ecall>
    80200d4c:	00050713          	mv	a4,a0
    80200d50:	00058793          	mv	a5,a1
    80200d54:	fce43823          	sd	a4,-48(s0)
    80200d58:	fcf43c23          	sd	a5,-40(s0)
    80200d5c:	fd043703          	ld	a4,-48(s0)
    80200d60:	fd843783          	ld	a5,-40(s0)
    80200d64:	00070913          	mv	s2,a4
    80200d68:	00078993          	mv	s3,a5
    80200d6c:	00090713          	mv	a4,s2
    80200d70:	00098793          	mv	a5,s3
    80200d74:	00070513          	mv	a0,a4
    80200d78:	00078593          	mv	a1,a5
    80200d7c:	04813083          	ld	ra,72(sp)
    80200d80:	04013403          	ld	s0,64(sp)
    80200d84:	03813903          	ld	s2,56(sp)
    80200d88:	03013983          	ld	s3,48(sp)
    80200d8c:	05010113          	addi	sp,sp,80
    80200d90:	00008067          	ret

0000000080200d94 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200d94:	fe010113          	addi	sp,sp,-32
    80200d98:	00113c23          	sd	ra,24(sp)
    80200d9c:	00813823          	sd	s0,16(sp)
    80200da0:	02010413          	addi	s0,sp,32
    80200da4:	fea43423          	sd	a0,-24(s0)
    80200da8:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    80200dac:	fe843783          	ld	a5,-24(s0)
    80200db0:	0207d063          	bgez	a5,80200dd0 <trap_handler+0x3c>
    80200db4:	fe843783          	ld	a5,-24(s0)
    80200db8:	0ff7f713          	zext.b	a4,a5
    80200dbc:	00500793          	li	a5,5
    80200dc0:	00f71863          	bne	a4,a5,80200dd0 <trap_handler+0x3c>
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mode Timer Interrupt\n");
        do_timer();
    80200dc4:	a05ff0ef          	jal	802007c8 <do_timer>

        // 设置下一次时钟中断
        clock_set_next_event();
    80200dc8:	c50ff0ef          	jal	80200218 <clock_set_next_event>
    80200dcc:	01c0006f          	j	80200de8 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    80200dd0:	fe043603          	ld	a2,-32(s0)
    80200dd4:	fe843583          	ld	a1,-24(s0)
    80200dd8:	00001517          	auipc	a0,0x1
    80200ddc:	30050513          	addi	a0,a0,768 # 802020d8 <_srodata+0xd8>
    80200de0:	7c9000ef          	jal	80201da8 <printk>
    }
    80200de4:	00000013          	nop
    80200de8:	00000013          	nop
    80200dec:	01813083          	ld	ra,24(sp)
    80200df0:	01013403          	ld	s0,16(sp)
    80200df4:	02010113          	addi	sp,sp,32
    80200df8:	00008067          	ret

0000000080200dfc <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
    80200dfc:	ff010113          	addi	sp,sp,-16
    80200e00:	00113423          	sd	ra,8(sp)
    80200e04:	00813023          	sd	s0,0(sp)
    80200e08:	01010413          	addi	s0,sp,16
    printk("2024");
    80200e0c:	00001517          	auipc	a0,0x1
    80200e10:	30c50513          	addi	a0,a0,780 # 80202118 <_srodata+0x118>
    80200e14:	795000ef          	jal	80201da8 <printk>
    printk(" ZJU Operating System\n");
    80200e18:	00001517          	auipc	a0,0x1
    80200e1c:	30850513          	addi	a0,a0,776 # 80202120 <_srodata+0x120>
    80200e20:	789000ef          	jal	80201da8 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
    80200e24:	0b0000ef          	jal	80200ed4 <run_idle>
    return 0;
    80200e28:	00000793          	li	a5,0
}
    80200e2c:	00078513          	mv	a0,a5
    80200e30:	00813083          	ld	ra,8(sp)
    80200e34:	00013403          	ld	s0,0(sp)
    80200e38:	01010113          	addi	sp,sp,16
    80200e3c:	00008067          	ret

0000000080200e40 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    80200e40:	ff010113          	addi	sp,sp,-16
    80200e44:	00113423          	sd	ra,8(sp)
    80200e48:	00813023          	sd	s0,0(sp)
    80200e4c:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200e50:	00000593          	li	a1,0
    80200e54:	00000513          	li	a0,0
    80200e58:	cedff0ef          	jal	80200b44 <sbi_system_reset>

0000000080200e5c <test>:
    __builtin_unreachable();
}

void test() {
    80200e5c:	fe010113          	addi	sp,sp,-32
    80200e60:	00113c23          	sd	ra,24(sp)
    80200e64:	00813823          	sd	s0,16(sp)
    80200e68:	02010413          	addi	s0,sp,32
    int i = 0;
    80200e6c:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
    80200e70:	fec42783          	lw	a5,-20(s0)
    80200e74:	0017879b          	addiw	a5,a5,1
    80200e78:	fef42623          	sw	a5,-20(s0)
    80200e7c:	fec42783          	lw	a5,-20(s0)
    80200e80:	0007869b          	sext.w	a3,a5
    80200e84:	55e64737          	lui	a4,0x55e64
    80200e88:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <_skernel-0x2a39c477>
    80200e8c:	02e68733          	mul	a4,a3,a4
    80200e90:	02075713          	srli	a4,a4,0x20
    80200e94:	4197571b          	sraiw	a4,a4,0x19
    80200e98:	00070693          	mv	a3,a4
    80200e9c:	41f7d71b          	sraiw	a4,a5,0x1f
    80200ea0:	40e6873b          	subw	a4,a3,a4
    80200ea4:	00070693          	mv	a3,a4
    80200ea8:	05f5e737          	lui	a4,0x5f5e
    80200eac:	1007071b          	addiw	a4,a4,256 # 5f5e100 <_skernel-0x7a2a1f00>
    80200eb0:	02e6873b          	mulw	a4,a3,a4
    80200eb4:	40e787bb          	subw	a5,a5,a4
    80200eb8:	0007879b          	sext.w	a5,a5
    80200ebc:	fa079ae3          	bnez	a5,80200e70 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
    80200ec0:	00001517          	auipc	a0,0x1
    80200ec4:	27850513          	addi	a0,a0,632 # 80202138 <_srodata+0x138>
    80200ec8:	6e1000ef          	jal	80201da8 <printk>
            i = 0;
    80200ecc:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
    80200ed0:	fa1ff06f          	j	80200e70 <test+0x14>

0000000080200ed4 <run_idle>:
        }
    }
}

void run_idle() {
    80200ed4:	ff010113          	addi	sp,sp,-16
    80200ed8:	00113423          	sd	ra,8(sp)
    80200edc:	00813023          	sd	s0,0(sp)
    80200ee0:	01010413          	addi	s0,sp,16
    while (1) {
    80200ee4:	0000006f          	j	80200ee4 <run_idle+0x10>

0000000080200ee8 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    80200ee8:	fe010113          	addi	sp,sp,-32
    80200eec:	00113c23          	sd	ra,24(sp)
    80200ef0:	00813823          	sd	s0,16(sp)
    80200ef4:	02010413          	addi	s0,sp,32
    80200ef8:	00050793          	mv	a5,a0
    80200efc:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    80200f00:	fec42783          	lw	a5,-20(s0)
    80200f04:	0ff7f793          	zext.b	a5,a5
    80200f08:	00078513          	mv	a0,a5
    80200f0c:	ba9ff0ef          	jal	80200ab4 <sbi_debug_console_write_byte>
    return (char)c;
    80200f10:	fec42783          	lw	a5,-20(s0)
    80200f14:	0ff7f793          	zext.b	a5,a5
    80200f18:	0007879b          	sext.w	a5,a5
}
    80200f1c:	00078513          	mv	a0,a5
    80200f20:	01813083          	ld	ra,24(sp)
    80200f24:	01013403          	ld	s0,16(sp)
    80200f28:	02010113          	addi	sp,sp,32
    80200f2c:	00008067          	ret

0000000080200f30 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    80200f30:	fe010113          	addi	sp,sp,-32
    80200f34:	00113c23          	sd	ra,24(sp)
    80200f38:	00813823          	sd	s0,16(sp)
    80200f3c:	02010413          	addi	s0,sp,32
    80200f40:	00050793          	mv	a5,a0
    80200f44:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    80200f48:	fec42783          	lw	a5,-20(s0)
    80200f4c:	0007871b          	sext.w	a4,a5
    80200f50:	02000793          	li	a5,32
    80200f54:	02f70263          	beq	a4,a5,80200f78 <isspace+0x48>
    80200f58:	fec42783          	lw	a5,-20(s0)
    80200f5c:	0007871b          	sext.w	a4,a5
    80200f60:	00800793          	li	a5,8
    80200f64:	00e7de63          	bge	a5,a4,80200f80 <isspace+0x50>
    80200f68:	fec42783          	lw	a5,-20(s0)
    80200f6c:	0007871b          	sext.w	a4,a5
    80200f70:	00d00793          	li	a5,13
    80200f74:	00e7c663          	blt	a5,a4,80200f80 <isspace+0x50>
    80200f78:	00100793          	li	a5,1
    80200f7c:	0080006f          	j	80200f84 <isspace+0x54>
    80200f80:	00000793          	li	a5,0
}
    80200f84:	00078513          	mv	a0,a5
    80200f88:	01813083          	ld	ra,24(sp)
    80200f8c:	01013403          	ld	s0,16(sp)
    80200f90:	02010113          	addi	sp,sp,32
    80200f94:	00008067          	ret

0000000080200f98 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80200f98:	fb010113          	addi	sp,sp,-80
    80200f9c:	04113423          	sd	ra,72(sp)
    80200fa0:	04813023          	sd	s0,64(sp)
    80200fa4:	05010413          	addi	s0,sp,80
    80200fa8:	fca43423          	sd	a0,-56(s0)
    80200fac:	fcb43023          	sd	a1,-64(s0)
    80200fb0:	00060793          	mv	a5,a2
    80200fb4:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    80200fb8:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    80200fbc:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    80200fc0:	fc843783          	ld	a5,-56(s0)
    80200fc4:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    80200fc8:	0100006f          	j	80200fd8 <strtol+0x40>
        p++;
    80200fcc:	fd843783          	ld	a5,-40(s0)
    80200fd0:	00178793          	addi	a5,a5,1
    80200fd4:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    80200fd8:	fd843783          	ld	a5,-40(s0)
    80200fdc:	0007c783          	lbu	a5,0(a5)
    80200fe0:	0007879b          	sext.w	a5,a5
    80200fe4:	00078513          	mv	a0,a5
    80200fe8:	f49ff0ef          	jal	80200f30 <isspace>
    80200fec:	00050793          	mv	a5,a0
    80200ff0:	fc079ee3          	bnez	a5,80200fcc <strtol+0x34>
    }

    if (*p == '-') {
    80200ff4:	fd843783          	ld	a5,-40(s0)
    80200ff8:	0007c783          	lbu	a5,0(a5)
    80200ffc:	00078713          	mv	a4,a5
    80201000:	02d00793          	li	a5,45
    80201004:	00f71e63          	bne	a4,a5,80201020 <strtol+0x88>
        neg = true;
    80201008:	00100793          	li	a5,1
    8020100c:	fef403a3          	sb	a5,-25(s0)
        p++;
    80201010:	fd843783          	ld	a5,-40(s0)
    80201014:	00178793          	addi	a5,a5,1
    80201018:	fcf43c23          	sd	a5,-40(s0)
    8020101c:	0240006f          	j	80201040 <strtol+0xa8>
    } else if (*p == '+') {
    80201020:	fd843783          	ld	a5,-40(s0)
    80201024:	0007c783          	lbu	a5,0(a5)
    80201028:	00078713          	mv	a4,a5
    8020102c:	02b00793          	li	a5,43
    80201030:	00f71863          	bne	a4,a5,80201040 <strtol+0xa8>
        p++;
    80201034:	fd843783          	ld	a5,-40(s0)
    80201038:	00178793          	addi	a5,a5,1
    8020103c:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    80201040:	fbc42783          	lw	a5,-68(s0)
    80201044:	0007879b          	sext.w	a5,a5
    80201048:	06079c63          	bnez	a5,802010c0 <strtol+0x128>
        if (*p == '0') {
    8020104c:	fd843783          	ld	a5,-40(s0)
    80201050:	0007c783          	lbu	a5,0(a5)
    80201054:	00078713          	mv	a4,a5
    80201058:	03000793          	li	a5,48
    8020105c:	04f71e63          	bne	a4,a5,802010b8 <strtol+0x120>
            p++;
    80201060:	fd843783          	ld	a5,-40(s0)
    80201064:	00178793          	addi	a5,a5,1
    80201068:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    8020106c:	fd843783          	ld	a5,-40(s0)
    80201070:	0007c783          	lbu	a5,0(a5)
    80201074:	00078713          	mv	a4,a5
    80201078:	07800793          	li	a5,120
    8020107c:	00f70c63          	beq	a4,a5,80201094 <strtol+0xfc>
    80201080:	fd843783          	ld	a5,-40(s0)
    80201084:	0007c783          	lbu	a5,0(a5)
    80201088:	00078713          	mv	a4,a5
    8020108c:	05800793          	li	a5,88
    80201090:	00f71e63          	bne	a4,a5,802010ac <strtol+0x114>
                base = 16;
    80201094:	01000793          	li	a5,16
    80201098:	faf42e23          	sw	a5,-68(s0)
                p++;
    8020109c:	fd843783          	ld	a5,-40(s0)
    802010a0:	00178793          	addi	a5,a5,1
    802010a4:	fcf43c23          	sd	a5,-40(s0)
    802010a8:	0180006f          	j	802010c0 <strtol+0x128>
            } else {
                base = 8;
    802010ac:	00800793          	li	a5,8
    802010b0:	faf42e23          	sw	a5,-68(s0)
    802010b4:	00c0006f          	j	802010c0 <strtol+0x128>
            }
        } else {
            base = 10;
    802010b8:	00a00793          	li	a5,10
    802010bc:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    802010c0:	fd843783          	ld	a5,-40(s0)
    802010c4:	0007c783          	lbu	a5,0(a5)
    802010c8:	00078713          	mv	a4,a5
    802010cc:	02f00793          	li	a5,47
    802010d0:	02e7f863          	bgeu	a5,a4,80201100 <strtol+0x168>
    802010d4:	fd843783          	ld	a5,-40(s0)
    802010d8:	0007c783          	lbu	a5,0(a5)
    802010dc:	00078713          	mv	a4,a5
    802010e0:	03900793          	li	a5,57
    802010e4:	00e7ee63          	bltu	a5,a4,80201100 <strtol+0x168>
            digit = *p - '0';
    802010e8:	fd843783          	ld	a5,-40(s0)
    802010ec:	0007c783          	lbu	a5,0(a5)
    802010f0:	0007879b          	sext.w	a5,a5
    802010f4:	fd07879b          	addiw	a5,a5,-48
    802010f8:	fcf42a23          	sw	a5,-44(s0)
    802010fc:	0800006f          	j	8020117c <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    80201100:	fd843783          	ld	a5,-40(s0)
    80201104:	0007c783          	lbu	a5,0(a5)
    80201108:	00078713          	mv	a4,a5
    8020110c:	06000793          	li	a5,96
    80201110:	02e7f863          	bgeu	a5,a4,80201140 <strtol+0x1a8>
    80201114:	fd843783          	ld	a5,-40(s0)
    80201118:	0007c783          	lbu	a5,0(a5)
    8020111c:	00078713          	mv	a4,a5
    80201120:	07a00793          	li	a5,122
    80201124:	00e7ee63          	bltu	a5,a4,80201140 <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80201128:	fd843783          	ld	a5,-40(s0)
    8020112c:	0007c783          	lbu	a5,0(a5)
    80201130:	0007879b          	sext.w	a5,a5
    80201134:	fa97879b          	addiw	a5,a5,-87
    80201138:	fcf42a23          	sw	a5,-44(s0)
    8020113c:	0400006f          	j	8020117c <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    80201140:	fd843783          	ld	a5,-40(s0)
    80201144:	0007c783          	lbu	a5,0(a5)
    80201148:	00078713          	mv	a4,a5
    8020114c:	04000793          	li	a5,64
    80201150:	06e7f863          	bgeu	a5,a4,802011c0 <strtol+0x228>
    80201154:	fd843783          	ld	a5,-40(s0)
    80201158:	0007c783          	lbu	a5,0(a5)
    8020115c:	00078713          	mv	a4,a5
    80201160:	05a00793          	li	a5,90
    80201164:	04e7ee63          	bltu	a5,a4,802011c0 <strtol+0x228>
            digit = *p - ('A' - 10);
    80201168:	fd843783          	ld	a5,-40(s0)
    8020116c:	0007c783          	lbu	a5,0(a5)
    80201170:	0007879b          	sext.w	a5,a5
    80201174:	fc97879b          	addiw	a5,a5,-55
    80201178:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    8020117c:	fd442783          	lw	a5,-44(s0)
    80201180:	00078713          	mv	a4,a5
    80201184:	fbc42783          	lw	a5,-68(s0)
    80201188:	0007071b          	sext.w	a4,a4
    8020118c:	0007879b          	sext.w	a5,a5
    80201190:	02f75663          	bge	a4,a5,802011bc <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80201194:	fbc42703          	lw	a4,-68(s0)
    80201198:	fe843783          	ld	a5,-24(s0)
    8020119c:	02f70733          	mul	a4,a4,a5
    802011a0:	fd442783          	lw	a5,-44(s0)
    802011a4:	00f707b3          	add	a5,a4,a5
    802011a8:	fef43423          	sd	a5,-24(s0)
        p++;
    802011ac:	fd843783          	ld	a5,-40(s0)
    802011b0:	00178793          	addi	a5,a5,1
    802011b4:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    802011b8:	f09ff06f          	j	802010c0 <strtol+0x128>
            break;
    802011bc:	00000013          	nop
    }

    if (endptr) {
    802011c0:	fc043783          	ld	a5,-64(s0)
    802011c4:	00078863          	beqz	a5,802011d4 <strtol+0x23c>
        *endptr = (char *)p;
    802011c8:	fc043783          	ld	a5,-64(s0)
    802011cc:	fd843703          	ld	a4,-40(s0)
    802011d0:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    802011d4:	fe744783          	lbu	a5,-25(s0)
    802011d8:	0ff7f793          	zext.b	a5,a5
    802011dc:	00078863          	beqz	a5,802011ec <strtol+0x254>
    802011e0:	fe843783          	ld	a5,-24(s0)
    802011e4:	40f007b3          	neg	a5,a5
    802011e8:	0080006f          	j	802011f0 <strtol+0x258>
    802011ec:	fe843783          	ld	a5,-24(s0)
}
    802011f0:	00078513          	mv	a0,a5
    802011f4:	04813083          	ld	ra,72(sp)
    802011f8:	04013403          	ld	s0,64(sp)
    802011fc:	05010113          	addi	sp,sp,80
    80201200:	00008067          	ret

0000000080201204 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    80201204:	fd010113          	addi	sp,sp,-48
    80201208:	02113423          	sd	ra,40(sp)
    8020120c:	02813023          	sd	s0,32(sp)
    80201210:	03010413          	addi	s0,sp,48
    80201214:	fca43c23          	sd	a0,-40(s0)
    80201218:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    8020121c:	fd043783          	ld	a5,-48(s0)
    80201220:	00079863          	bnez	a5,80201230 <puts_wo_nl+0x2c>
        s = "(null)";
    80201224:	00001797          	auipc	a5,0x1
    80201228:	f2c78793          	addi	a5,a5,-212 # 80202150 <_srodata+0x150>
    8020122c:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    80201230:	fd043783          	ld	a5,-48(s0)
    80201234:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80201238:	0240006f          	j	8020125c <puts_wo_nl+0x58>
        putch(*p++);
    8020123c:	fe843783          	ld	a5,-24(s0)
    80201240:	00178713          	addi	a4,a5,1
    80201244:	fee43423          	sd	a4,-24(s0)
    80201248:	0007c783          	lbu	a5,0(a5)
    8020124c:	0007871b          	sext.w	a4,a5
    80201250:	fd843783          	ld	a5,-40(s0)
    80201254:	00070513          	mv	a0,a4
    80201258:	000780e7          	jalr	a5
    while (*p) {
    8020125c:	fe843783          	ld	a5,-24(s0)
    80201260:	0007c783          	lbu	a5,0(a5)
    80201264:	fc079ce3          	bnez	a5,8020123c <puts_wo_nl+0x38>
    }
    return p - s;
    80201268:	fe843703          	ld	a4,-24(s0)
    8020126c:	fd043783          	ld	a5,-48(s0)
    80201270:	40f707b3          	sub	a5,a4,a5
    80201274:	0007879b          	sext.w	a5,a5
}
    80201278:	00078513          	mv	a0,a5
    8020127c:	02813083          	ld	ra,40(sp)
    80201280:	02013403          	ld	s0,32(sp)
    80201284:	03010113          	addi	sp,sp,48
    80201288:	00008067          	ret

000000008020128c <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    8020128c:	f9010113          	addi	sp,sp,-112
    80201290:	06113423          	sd	ra,104(sp)
    80201294:	06813023          	sd	s0,96(sp)
    80201298:	07010413          	addi	s0,sp,112
    8020129c:	faa43423          	sd	a0,-88(s0)
    802012a0:	fab43023          	sd	a1,-96(s0)
    802012a4:	00060793          	mv	a5,a2
    802012a8:	f8d43823          	sd	a3,-112(s0)
    802012ac:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    802012b0:	f9f44783          	lbu	a5,-97(s0)
    802012b4:	0ff7f793          	zext.b	a5,a5
    802012b8:	02078663          	beqz	a5,802012e4 <print_dec_int+0x58>
    802012bc:	fa043703          	ld	a4,-96(s0)
    802012c0:	fff00793          	li	a5,-1
    802012c4:	03f79793          	slli	a5,a5,0x3f
    802012c8:	00f71e63          	bne	a4,a5,802012e4 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    802012cc:	00001597          	auipc	a1,0x1
    802012d0:	e8c58593          	addi	a1,a1,-372 # 80202158 <_srodata+0x158>
    802012d4:	fa843503          	ld	a0,-88(s0)
    802012d8:	f2dff0ef          	jal	80201204 <puts_wo_nl>
    802012dc:	00050793          	mv	a5,a0
    802012e0:	2c80006f          	j	802015a8 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    802012e4:	f9043783          	ld	a5,-112(s0)
    802012e8:	00c7a783          	lw	a5,12(a5)
    802012ec:	00079a63          	bnez	a5,80201300 <print_dec_int+0x74>
    802012f0:	fa043783          	ld	a5,-96(s0)
    802012f4:	00079663          	bnez	a5,80201300 <print_dec_int+0x74>
        return 0;
    802012f8:	00000793          	li	a5,0
    802012fc:	2ac0006f          	j	802015a8 <print_dec_int+0x31c>
    }

    bool neg = false;
    80201300:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80201304:	f9f44783          	lbu	a5,-97(s0)
    80201308:	0ff7f793          	zext.b	a5,a5
    8020130c:	02078063          	beqz	a5,8020132c <print_dec_int+0xa0>
    80201310:	fa043783          	ld	a5,-96(s0)
    80201314:	0007dc63          	bgez	a5,8020132c <print_dec_int+0xa0>
        neg = true;
    80201318:	00100793          	li	a5,1
    8020131c:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    80201320:	fa043783          	ld	a5,-96(s0)
    80201324:	40f007b3          	neg	a5,a5
    80201328:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    8020132c:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    80201330:	f9f44783          	lbu	a5,-97(s0)
    80201334:	0ff7f793          	zext.b	a5,a5
    80201338:	02078863          	beqz	a5,80201368 <print_dec_int+0xdc>
    8020133c:	fef44783          	lbu	a5,-17(s0)
    80201340:	0ff7f793          	zext.b	a5,a5
    80201344:	00079e63          	bnez	a5,80201360 <print_dec_int+0xd4>
    80201348:	f9043783          	ld	a5,-112(s0)
    8020134c:	0057c783          	lbu	a5,5(a5)
    80201350:	00079863          	bnez	a5,80201360 <print_dec_int+0xd4>
    80201354:	f9043783          	ld	a5,-112(s0)
    80201358:	0047c783          	lbu	a5,4(a5)
    8020135c:	00078663          	beqz	a5,80201368 <print_dec_int+0xdc>
    80201360:	00100793          	li	a5,1
    80201364:	0080006f          	j	8020136c <print_dec_int+0xe0>
    80201368:	00000793          	li	a5,0
    8020136c:	fcf40ba3          	sb	a5,-41(s0)
    80201370:	fd744783          	lbu	a5,-41(s0)
    80201374:	0017f793          	andi	a5,a5,1
    80201378:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    8020137c:	fa043683          	ld	a3,-96(s0)
    80201380:	00001797          	auipc	a5,0x1
    80201384:	df078793          	addi	a5,a5,-528 # 80202170 <_srodata+0x170>
    80201388:	0007b783          	ld	a5,0(a5)
    8020138c:	02f6b7b3          	mulhu	a5,a3,a5
    80201390:	0037d713          	srli	a4,a5,0x3
    80201394:	00070793          	mv	a5,a4
    80201398:	00279793          	slli	a5,a5,0x2
    8020139c:	00e787b3          	add	a5,a5,a4
    802013a0:	00179793          	slli	a5,a5,0x1
    802013a4:	40f68733          	sub	a4,a3,a5
    802013a8:	0ff77713          	zext.b	a4,a4
    802013ac:	fe842783          	lw	a5,-24(s0)
    802013b0:	0017869b          	addiw	a3,a5,1
    802013b4:	fed42423          	sw	a3,-24(s0)
    802013b8:	0307071b          	addiw	a4,a4,48
    802013bc:	0ff77713          	zext.b	a4,a4
    802013c0:	ff078793          	addi	a5,a5,-16
    802013c4:	008787b3          	add	a5,a5,s0
    802013c8:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    802013cc:	fa043703          	ld	a4,-96(s0)
    802013d0:	00001797          	auipc	a5,0x1
    802013d4:	da078793          	addi	a5,a5,-608 # 80202170 <_srodata+0x170>
    802013d8:	0007b783          	ld	a5,0(a5)
    802013dc:	02f737b3          	mulhu	a5,a4,a5
    802013e0:	0037d793          	srli	a5,a5,0x3
    802013e4:	faf43023          	sd	a5,-96(s0)
    } while (num);
    802013e8:	fa043783          	ld	a5,-96(s0)
    802013ec:	f80798e3          	bnez	a5,8020137c <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    802013f0:	f9043783          	ld	a5,-112(s0)
    802013f4:	00c7a703          	lw	a4,12(a5)
    802013f8:	fff00793          	li	a5,-1
    802013fc:	02f71063          	bne	a4,a5,8020141c <print_dec_int+0x190>
    80201400:	f9043783          	ld	a5,-112(s0)
    80201404:	0037c783          	lbu	a5,3(a5)
    80201408:	00078a63          	beqz	a5,8020141c <print_dec_int+0x190>
        flags->prec = flags->width;
    8020140c:	f9043783          	ld	a5,-112(s0)
    80201410:	0087a703          	lw	a4,8(a5)
    80201414:	f9043783          	ld	a5,-112(s0)
    80201418:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    8020141c:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80201420:	f9043783          	ld	a5,-112(s0)
    80201424:	0087a703          	lw	a4,8(a5)
    80201428:	fe842783          	lw	a5,-24(s0)
    8020142c:	fcf42823          	sw	a5,-48(s0)
    80201430:	f9043783          	ld	a5,-112(s0)
    80201434:	00c7a783          	lw	a5,12(a5)
    80201438:	fcf42623          	sw	a5,-52(s0)
    8020143c:	fd042783          	lw	a5,-48(s0)
    80201440:	00078593          	mv	a1,a5
    80201444:	fcc42783          	lw	a5,-52(s0)
    80201448:	00078613          	mv	a2,a5
    8020144c:	0006069b          	sext.w	a3,a2
    80201450:	0005879b          	sext.w	a5,a1
    80201454:	00f6d463          	bge	a3,a5,8020145c <print_dec_int+0x1d0>
    80201458:	00058613          	mv	a2,a1
    8020145c:	0006079b          	sext.w	a5,a2
    80201460:	40f707bb          	subw	a5,a4,a5
    80201464:	0007871b          	sext.w	a4,a5
    80201468:	fd744783          	lbu	a5,-41(s0)
    8020146c:	0007879b          	sext.w	a5,a5
    80201470:	40f707bb          	subw	a5,a4,a5
    80201474:	fef42023          	sw	a5,-32(s0)
    80201478:	0280006f          	j	802014a0 <print_dec_int+0x214>
        putch(' ');
    8020147c:	fa843783          	ld	a5,-88(s0)
    80201480:	02000513          	li	a0,32
    80201484:	000780e7          	jalr	a5
        ++written;
    80201488:	fe442783          	lw	a5,-28(s0)
    8020148c:	0017879b          	addiw	a5,a5,1
    80201490:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80201494:	fe042783          	lw	a5,-32(s0)
    80201498:	fff7879b          	addiw	a5,a5,-1
    8020149c:	fef42023          	sw	a5,-32(s0)
    802014a0:	fe042783          	lw	a5,-32(s0)
    802014a4:	0007879b          	sext.w	a5,a5
    802014a8:	fcf04ae3          	bgtz	a5,8020147c <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    802014ac:	fd744783          	lbu	a5,-41(s0)
    802014b0:	0ff7f793          	zext.b	a5,a5
    802014b4:	04078463          	beqz	a5,802014fc <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    802014b8:	fef44783          	lbu	a5,-17(s0)
    802014bc:	0ff7f793          	zext.b	a5,a5
    802014c0:	00078663          	beqz	a5,802014cc <print_dec_int+0x240>
    802014c4:	02d00793          	li	a5,45
    802014c8:	01c0006f          	j	802014e4 <print_dec_int+0x258>
    802014cc:	f9043783          	ld	a5,-112(s0)
    802014d0:	0057c783          	lbu	a5,5(a5)
    802014d4:	00078663          	beqz	a5,802014e0 <print_dec_int+0x254>
    802014d8:	02b00793          	li	a5,43
    802014dc:	0080006f          	j	802014e4 <print_dec_int+0x258>
    802014e0:	02000793          	li	a5,32
    802014e4:	fa843703          	ld	a4,-88(s0)
    802014e8:	00078513          	mv	a0,a5
    802014ec:	000700e7          	jalr	a4
        ++written;
    802014f0:	fe442783          	lw	a5,-28(s0)
    802014f4:	0017879b          	addiw	a5,a5,1
    802014f8:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    802014fc:	fe842783          	lw	a5,-24(s0)
    80201500:	fcf42e23          	sw	a5,-36(s0)
    80201504:	0280006f          	j	8020152c <print_dec_int+0x2a0>
        putch('0');
    80201508:	fa843783          	ld	a5,-88(s0)
    8020150c:	03000513          	li	a0,48
    80201510:	000780e7          	jalr	a5
        ++written;
    80201514:	fe442783          	lw	a5,-28(s0)
    80201518:	0017879b          	addiw	a5,a5,1
    8020151c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80201520:	fdc42783          	lw	a5,-36(s0)
    80201524:	0017879b          	addiw	a5,a5,1
    80201528:	fcf42e23          	sw	a5,-36(s0)
    8020152c:	f9043783          	ld	a5,-112(s0)
    80201530:	00c7a703          	lw	a4,12(a5)
    80201534:	fd744783          	lbu	a5,-41(s0)
    80201538:	0007879b          	sext.w	a5,a5
    8020153c:	40f707bb          	subw	a5,a4,a5
    80201540:	0007879b          	sext.w	a5,a5
    80201544:	fdc42703          	lw	a4,-36(s0)
    80201548:	0007071b          	sext.w	a4,a4
    8020154c:	faf74ee3          	blt	a4,a5,80201508 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80201550:	fe842783          	lw	a5,-24(s0)
    80201554:	fff7879b          	addiw	a5,a5,-1
    80201558:	fcf42c23          	sw	a5,-40(s0)
    8020155c:	03c0006f          	j	80201598 <print_dec_int+0x30c>
        putch(buf[i]);
    80201560:	fd842783          	lw	a5,-40(s0)
    80201564:	ff078793          	addi	a5,a5,-16
    80201568:	008787b3          	add	a5,a5,s0
    8020156c:	fc87c783          	lbu	a5,-56(a5)
    80201570:	0007871b          	sext.w	a4,a5
    80201574:	fa843783          	ld	a5,-88(s0)
    80201578:	00070513          	mv	a0,a4
    8020157c:	000780e7          	jalr	a5
        ++written;
    80201580:	fe442783          	lw	a5,-28(s0)
    80201584:	0017879b          	addiw	a5,a5,1
    80201588:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    8020158c:	fd842783          	lw	a5,-40(s0)
    80201590:	fff7879b          	addiw	a5,a5,-1
    80201594:	fcf42c23          	sw	a5,-40(s0)
    80201598:	fd842783          	lw	a5,-40(s0)
    8020159c:	0007879b          	sext.w	a5,a5
    802015a0:	fc07d0e3          	bgez	a5,80201560 <print_dec_int+0x2d4>
    }

    return written;
    802015a4:	fe442783          	lw	a5,-28(s0)
}
    802015a8:	00078513          	mv	a0,a5
    802015ac:	06813083          	ld	ra,104(sp)
    802015b0:	06013403          	ld	s0,96(sp)
    802015b4:	07010113          	addi	sp,sp,112
    802015b8:	00008067          	ret

00000000802015bc <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    802015bc:	f4010113          	addi	sp,sp,-192
    802015c0:	0a113c23          	sd	ra,184(sp)
    802015c4:	0a813823          	sd	s0,176(sp)
    802015c8:	0c010413          	addi	s0,sp,192
    802015cc:	f4a43c23          	sd	a0,-168(s0)
    802015d0:	f4b43823          	sd	a1,-176(s0)
    802015d4:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    802015d8:	f8043023          	sd	zero,-128(s0)
    802015dc:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    802015e0:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    802015e4:	7a00006f          	j	80201d84 <vprintfmt+0x7c8>
        if (flags.in_format) {
    802015e8:	f8044783          	lbu	a5,-128(s0)
    802015ec:	72078c63          	beqz	a5,80201d24 <vprintfmt+0x768>
            if (*fmt == '#') {
    802015f0:	f5043783          	ld	a5,-176(s0)
    802015f4:	0007c783          	lbu	a5,0(a5)
    802015f8:	00078713          	mv	a4,a5
    802015fc:	02300793          	li	a5,35
    80201600:	00f71863          	bne	a4,a5,80201610 <vprintfmt+0x54>
                flags.sharpflag = true;
    80201604:	00100793          	li	a5,1
    80201608:	f8f40123          	sb	a5,-126(s0)
    8020160c:	76c0006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    80201610:	f5043783          	ld	a5,-176(s0)
    80201614:	0007c783          	lbu	a5,0(a5)
    80201618:	00078713          	mv	a4,a5
    8020161c:	03000793          	li	a5,48
    80201620:	00f71863          	bne	a4,a5,80201630 <vprintfmt+0x74>
                flags.zeroflag = true;
    80201624:	00100793          	li	a5,1
    80201628:	f8f401a3          	sb	a5,-125(s0)
    8020162c:	74c0006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    80201630:	f5043783          	ld	a5,-176(s0)
    80201634:	0007c783          	lbu	a5,0(a5)
    80201638:	00078713          	mv	a4,a5
    8020163c:	06c00793          	li	a5,108
    80201640:	04f70063          	beq	a4,a5,80201680 <vprintfmt+0xc4>
    80201644:	f5043783          	ld	a5,-176(s0)
    80201648:	0007c783          	lbu	a5,0(a5)
    8020164c:	00078713          	mv	a4,a5
    80201650:	07a00793          	li	a5,122
    80201654:	02f70663          	beq	a4,a5,80201680 <vprintfmt+0xc4>
    80201658:	f5043783          	ld	a5,-176(s0)
    8020165c:	0007c783          	lbu	a5,0(a5)
    80201660:	00078713          	mv	a4,a5
    80201664:	07400793          	li	a5,116
    80201668:	00f70c63          	beq	a4,a5,80201680 <vprintfmt+0xc4>
    8020166c:	f5043783          	ld	a5,-176(s0)
    80201670:	0007c783          	lbu	a5,0(a5)
    80201674:	00078713          	mv	a4,a5
    80201678:	06a00793          	li	a5,106
    8020167c:	00f71863          	bne	a4,a5,8020168c <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80201680:	00100793          	li	a5,1
    80201684:	f8f400a3          	sb	a5,-127(s0)
    80201688:	6f00006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    8020168c:	f5043783          	ld	a5,-176(s0)
    80201690:	0007c783          	lbu	a5,0(a5)
    80201694:	00078713          	mv	a4,a5
    80201698:	02b00793          	li	a5,43
    8020169c:	00f71863          	bne	a4,a5,802016ac <vprintfmt+0xf0>
                flags.sign = true;
    802016a0:	00100793          	li	a5,1
    802016a4:	f8f402a3          	sb	a5,-123(s0)
    802016a8:	6d00006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    802016ac:	f5043783          	ld	a5,-176(s0)
    802016b0:	0007c783          	lbu	a5,0(a5)
    802016b4:	00078713          	mv	a4,a5
    802016b8:	02000793          	li	a5,32
    802016bc:	00f71863          	bne	a4,a5,802016cc <vprintfmt+0x110>
                flags.spaceflag = true;
    802016c0:	00100793          	li	a5,1
    802016c4:	f8f40223          	sb	a5,-124(s0)
    802016c8:	6b00006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    802016cc:	f5043783          	ld	a5,-176(s0)
    802016d0:	0007c783          	lbu	a5,0(a5)
    802016d4:	00078713          	mv	a4,a5
    802016d8:	02a00793          	li	a5,42
    802016dc:	00f71e63          	bne	a4,a5,802016f8 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    802016e0:	f4843783          	ld	a5,-184(s0)
    802016e4:	00878713          	addi	a4,a5,8
    802016e8:	f4e43423          	sd	a4,-184(s0)
    802016ec:	0007a783          	lw	a5,0(a5)
    802016f0:	f8f42423          	sw	a5,-120(s0)
    802016f4:	6840006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    802016f8:	f5043783          	ld	a5,-176(s0)
    802016fc:	0007c783          	lbu	a5,0(a5)
    80201700:	00078713          	mv	a4,a5
    80201704:	03000793          	li	a5,48
    80201708:	04e7f663          	bgeu	a5,a4,80201754 <vprintfmt+0x198>
    8020170c:	f5043783          	ld	a5,-176(s0)
    80201710:	0007c783          	lbu	a5,0(a5)
    80201714:	00078713          	mv	a4,a5
    80201718:	03900793          	li	a5,57
    8020171c:	02e7ec63          	bltu	a5,a4,80201754 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    80201720:	f5043783          	ld	a5,-176(s0)
    80201724:	f5040713          	addi	a4,s0,-176
    80201728:	00a00613          	li	a2,10
    8020172c:	00070593          	mv	a1,a4
    80201730:	00078513          	mv	a0,a5
    80201734:	865ff0ef          	jal	80200f98 <strtol>
    80201738:	00050793          	mv	a5,a0
    8020173c:	0007879b          	sext.w	a5,a5
    80201740:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    80201744:	f5043783          	ld	a5,-176(s0)
    80201748:	fff78793          	addi	a5,a5,-1
    8020174c:	f4f43823          	sd	a5,-176(s0)
    80201750:	6280006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    80201754:	f5043783          	ld	a5,-176(s0)
    80201758:	0007c783          	lbu	a5,0(a5)
    8020175c:	00078713          	mv	a4,a5
    80201760:	02e00793          	li	a5,46
    80201764:	06f71863          	bne	a4,a5,802017d4 <vprintfmt+0x218>
                fmt++;
    80201768:	f5043783          	ld	a5,-176(s0)
    8020176c:	00178793          	addi	a5,a5,1
    80201770:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80201774:	f5043783          	ld	a5,-176(s0)
    80201778:	0007c783          	lbu	a5,0(a5)
    8020177c:	00078713          	mv	a4,a5
    80201780:	02a00793          	li	a5,42
    80201784:	00f71e63          	bne	a4,a5,802017a0 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    80201788:	f4843783          	ld	a5,-184(s0)
    8020178c:	00878713          	addi	a4,a5,8
    80201790:	f4e43423          	sd	a4,-184(s0)
    80201794:	0007a783          	lw	a5,0(a5)
    80201798:	f8f42623          	sw	a5,-116(s0)
    8020179c:	5dc0006f          	j	80201d78 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    802017a0:	f5043783          	ld	a5,-176(s0)
    802017a4:	f5040713          	addi	a4,s0,-176
    802017a8:	00a00613          	li	a2,10
    802017ac:	00070593          	mv	a1,a4
    802017b0:	00078513          	mv	a0,a5
    802017b4:	fe4ff0ef          	jal	80200f98 <strtol>
    802017b8:	00050793          	mv	a5,a0
    802017bc:	0007879b          	sext.w	a5,a5
    802017c0:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    802017c4:	f5043783          	ld	a5,-176(s0)
    802017c8:	fff78793          	addi	a5,a5,-1
    802017cc:	f4f43823          	sd	a5,-176(s0)
    802017d0:	5a80006f          	j	80201d78 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802017d4:	f5043783          	ld	a5,-176(s0)
    802017d8:	0007c783          	lbu	a5,0(a5)
    802017dc:	00078713          	mv	a4,a5
    802017e0:	07800793          	li	a5,120
    802017e4:	02f70663          	beq	a4,a5,80201810 <vprintfmt+0x254>
    802017e8:	f5043783          	ld	a5,-176(s0)
    802017ec:	0007c783          	lbu	a5,0(a5)
    802017f0:	00078713          	mv	a4,a5
    802017f4:	05800793          	li	a5,88
    802017f8:	00f70c63          	beq	a4,a5,80201810 <vprintfmt+0x254>
    802017fc:	f5043783          	ld	a5,-176(s0)
    80201800:	0007c783          	lbu	a5,0(a5)
    80201804:	00078713          	mv	a4,a5
    80201808:	07000793          	li	a5,112
    8020180c:	30f71063          	bne	a4,a5,80201b0c <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    80201810:	f5043783          	ld	a5,-176(s0)
    80201814:	0007c783          	lbu	a5,0(a5)
    80201818:	00078713          	mv	a4,a5
    8020181c:	07000793          	li	a5,112
    80201820:	00f70663          	beq	a4,a5,8020182c <vprintfmt+0x270>
    80201824:	f8144783          	lbu	a5,-127(s0)
    80201828:	00078663          	beqz	a5,80201834 <vprintfmt+0x278>
    8020182c:	00100793          	li	a5,1
    80201830:	0080006f          	j	80201838 <vprintfmt+0x27c>
    80201834:	00000793          	li	a5,0
    80201838:	faf403a3          	sb	a5,-89(s0)
    8020183c:	fa744783          	lbu	a5,-89(s0)
    80201840:	0017f793          	andi	a5,a5,1
    80201844:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    80201848:	fa744783          	lbu	a5,-89(s0)
    8020184c:	0ff7f793          	zext.b	a5,a5
    80201850:	00078c63          	beqz	a5,80201868 <vprintfmt+0x2ac>
    80201854:	f4843783          	ld	a5,-184(s0)
    80201858:	00878713          	addi	a4,a5,8
    8020185c:	f4e43423          	sd	a4,-184(s0)
    80201860:	0007b783          	ld	a5,0(a5)
    80201864:	01c0006f          	j	80201880 <vprintfmt+0x2c4>
    80201868:	f4843783          	ld	a5,-184(s0)
    8020186c:	00878713          	addi	a4,a5,8
    80201870:	f4e43423          	sd	a4,-184(s0)
    80201874:	0007a783          	lw	a5,0(a5)
    80201878:	02079793          	slli	a5,a5,0x20
    8020187c:	0207d793          	srli	a5,a5,0x20
    80201880:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80201884:	f8c42783          	lw	a5,-116(s0)
    80201888:	02079463          	bnez	a5,802018b0 <vprintfmt+0x2f4>
    8020188c:	fe043783          	ld	a5,-32(s0)
    80201890:	02079063          	bnez	a5,802018b0 <vprintfmt+0x2f4>
    80201894:	f5043783          	ld	a5,-176(s0)
    80201898:	0007c783          	lbu	a5,0(a5)
    8020189c:	00078713          	mv	a4,a5
    802018a0:	07000793          	li	a5,112
    802018a4:	00f70663          	beq	a4,a5,802018b0 <vprintfmt+0x2f4>
                    flags.in_format = false;
    802018a8:	f8040023          	sb	zero,-128(s0)
    802018ac:	4cc0006f          	j	80201d78 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    802018b0:	f5043783          	ld	a5,-176(s0)
    802018b4:	0007c783          	lbu	a5,0(a5)
    802018b8:	00078713          	mv	a4,a5
    802018bc:	07000793          	li	a5,112
    802018c0:	00f70a63          	beq	a4,a5,802018d4 <vprintfmt+0x318>
    802018c4:	f8244783          	lbu	a5,-126(s0)
    802018c8:	00078a63          	beqz	a5,802018dc <vprintfmt+0x320>
    802018cc:	fe043783          	ld	a5,-32(s0)
    802018d0:	00078663          	beqz	a5,802018dc <vprintfmt+0x320>
    802018d4:	00100793          	li	a5,1
    802018d8:	0080006f          	j	802018e0 <vprintfmt+0x324>
    802018dc:	00000793          	li	a5,0
    802018e0:	faf40323          	sb	a5,-90(s0)
    802018e4:	fa644783          	lbu	a5,-90(s0)
    802018e8:	0017f793          	andi	a5,a5,1
    802018ec:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    802018f0:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    802018f4:	f5043783          	ld	a5,-176(s0)
    802018f8:	0007c783          	lbu	a5,0(a5)
    802018fc:	00078713          	mv	a4,a5
    80201900:	05800793          	li	a5,88
    80201904:	00f71863          	bne	a4,a5,80201914 <vprintfmt+0x358>
    80201908:	00001797          	auipc	a5,0x1
    8020190c:	87078793          	addi	a5,a5,-1936 # 80202178 <upperxdigits.1>
    80201910:	00c0006f          	j	8020191c <vprintfmt+0x360>
    80201914:	00001797          	auipc	a5,0x1
    80201918:	87c78793          	addi	a5,a5,-1924 # 80202190 <lowerxdigits.0>
    8020191c:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    80201920:	fe043783          	ld	a5,-32(s0)
    80201924:	00f7f793          	andi	a5,a5,15
    80201928:	f9843703          	ld	a4,-104(s0)
    8020192c:	00f70733          	add	a4,a4,a5
    80201930:	fdc42783          	lw	a5,-36(s0)
    80201934:	0017869b          	addiw	a3,a5,1
    80201938:	fcd42e23          	sw	a3,-36(s0)
    8020193c:	00074703          	lbu	a4,0(a4)
    80201940:	ff078793          	addi	a5,a5,-16
    80201944:	008787b3          	add	a5,a5,s0
    80201948:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    8020194c:	fe043783          	ld	a5,-32(s0)
    80201950:	0047d793          	srli	a5,a5,0x4
    80201954:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80201958:	fe043783          	ld	a5,-32(s0)
    8020195c:	fc0792e3          	bnez	a5,80201920 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201960:	f8c42703          	lw	a4,-116(s0)
    80201964:	fff00793          	li	a5,-1
    80201968:	02f71663          	bne	a4,a5,80201994 <vprintfmt+0x3d8>
    8020196c:	f8344783          	lbu	a5,-125(s0)
    80201970:	02078263          	beqz	a5,80201994 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80201974:	f8842703          	lw	a4,-120(s0)
    80201978:	fa644783          	lbu	a5,-90(s0)
    8020197c:	0007879b          	sext.w	a5,a5
    80201980:	0017979b          	slliw	a5,a5,0x1
    80201984:	0007879b          	sext.w	a5,a5
    80201988:	40f707bb          	subw	a5,a4,a5
    8020198c:	0007879b          	sext.w	a5,a5
    80201990:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201994:	f8842703          	lw	a4,-120(s0)
    80201998:	fa644783          	lbu	a5,-90(s0)
    8020199c:	0007879b          	sext.w	a5,a5
    802019a0:	0017979b          	slliw	a5,a5,0x1
    802019a4:	0007879b          	sext.w	a5,a5
    802019a8:	40f707bb          	subw	a5,a4,a5
    802019ac:	0007871b          	sext.w	a4,a5
    802019b0:	fdc42783          	lw	a5,-36(s0)
    802019b4:	f8f42a23          	sw	a5,-108(s0)
    802019b8:	f8c42783          	lw	a5,-116(s0)
    802019bc:	f8f42823          	sw	a5,-112(s0)
    802019c0:	f9442783          	lw	a5,-108(s0)
    802019c4:	00078593          	mv	a1,a5
    802019c8:	f9042783          	lw	a5,-112(s0)
    802019cc:	00078613          	mv	a2,a5
    802019d0:	0006069b          	sext.w	a3,a2
    802019d4:	0005879b          	sext.w	a5,a1
    802019d8:	00f6d463          	bge	a3,a5,802019e0 <vprintfmt+0x424>
    802019dc:	00058613          	mv	a2,a1
    802019e0:	0006079b          	sext.w	a5,a2
    802019e4:	40f707bb          	subw	a5,a4,a5
    802019e8:	fcf42c23          	sw	a5,-40(s0)
    802019ec:	0280006f          	j	80201a14 <vprintfmt+0x458>
                    putch(' ');
    802019f0:	f5843783          	ld	a5,-168(s0)
    802019f4:	02000513          	li	a0,32
    802019f8:	000780e7          	jalr	a5
                    ++written;
    802019fc:	fec42783          	lw	a5,-20(s0)
    80201a00:	0017879b          	addiw	a5,a5,1
    80201a04:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201a08:	fd842783          	lw	a5,-40(s0)
    80201a0c:	fff7879b          	addiw	a5,a5,-1
    80201a10:	fcf42c23          	sw	a5,-40(s0)
    80201a14:	fd842783          	lw	a5,-40(s0)
    80201a18:	0007879b          	sext.w	a5,a5
    80201a1c:	fcf04ae3          	bgtz	a5,802019f0 <vprintfmt+0x434>
                }

                if (prefix) {
    80201a20:	fa644783          	lbu	a5,-90(s0)
    80201a24:	0ff7f793          	zext.b	a5,a5
    80201a28:	04078463          	beqz	a5,80201a70 <vprintfmt+0x4b4>
                    putch('0');
    80201a2c:	f5843783          	ld	a5,-168(s0)
    80201a30:	03000513          	li	a0,48
    80201a34:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    80201a38:	f5043783          	ld	a5,-176(s0)
    80201a3c:	0007c783          	lbu	a5,0(a5)
    80201a40:	00078713          	mv	a4,a5
    80201a44:	05800793          	li	a5,88
    80201a48:	00f71663          	bne	a4,a5,80201a54 <vprintfmt+0x498>
    80201a4c:	05800793          	li	a5,88
    80201a50:	0080006f          	j	80201a58 <vprintfmt+0x49c>
    80201a54:	07800793          	li	a5,120
    80201a58:	f5843703          	ld	a4,-168(s0)
    80201a5c:	00078513          	mv	a0,a5
    80201a60:	000700e7          	jalr	a4
                    written += 2;
    80201a64:	fec42783          	lw	a5,-20(s0)
    80201a68:	0027879b          	addiw	a5,a5,2
    80201a6c:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201a70:	fdc42783          	lw	a5,-36(s0)
    80201a74:	fcf42a23          	sw	a5,-44(s0)
    80201a78:	0280006f          	j	80201aa0 <vprintfmt+0x4e4>
                    putch('0');
    80201a7c:	f5843783          	ld	a5,-168(s0)
    80201a80:	03000513          	li	a0,48
    80201a84:	000780e7          	jalr	a5
                    ++written;
    80201a88:	fec42783          	lw	a5,-20(s0)
    80201a8c:	0017879b          	addiw	a5,a5,1
    80201a90:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201a94:	fd442783          	lw	a5,-44(s0)
    80201a98:	0017879b          	addiw	a5,a5,1
    80201a9c:	fcf42a23          	sw	a5,-44(s0)
    80201aa0:	f8c42783          	lw	a5,-116(s0)
    80201aa4:	fd442703          	lw	a4,-44(s0)
    80201aa8:	0007071b          	sext.w	a4,a4
    80201aac:	fcf748e3          	blt	a4,a5,80201a7c <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201ab0:	fdc42783          	lw	a5,-36(s0)
    80201ab4:	fff7879b          	addiw	a5,a5,-1
    80201ab8:	fcf42823          	sw	a5,-48(s0)
    80201abc:	03c0006f          	j	80201af8 <vprintfmt+0x53c>
                    putch(buf[i]);
    80201ac0:	fd042783          	lw	a5,-48(s0)
    80201ac4:	ff078793          	addi	a5,a5,-16
    80201ac8:	008787b3          	add	a5,a5,s0
    80201acc:	f807c783          	lbu	a5,-128(a5)
    80201ad0:	0007871b          	sext.w	a4,a5
    80201ad4:	f5843783          	ld	a5,-168(s0)
    80201ad8:	00070513          	mv	a0,a4
    80201adc:	000780e7          	jalr	a5
                    ++written;
    80201ae0:	fec42783          	lw	a5,-20(s0)
    80201ae4:	0017879b          	addiw	a5,a5,1
    80201ae8:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201aec:	fd042783          	lw	a5,-48(s0)
    80201af0:	fff7879b          	addiw	a5,a5,-1
    80201af4:	fcf42823          	sw	a5,-48(s0)
    80201af8:	fd042783          	lw	a5,-48(s0)
    80201afc:	0007879b          	sext.w	a5,a5
    80201b00:	fc07d0e3          	bgez	a5,80201ac0 <vprintfmt+0x504>
                }

                flags.in_format = false;
    80201b04:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201b08:	2700006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201b0c:	f5043783          	ld	a5,-176(s0)
    80201b10:	0007c783          	lbu	a5,0(a5)
    80201b14:	00078713          	mv	a4,a5
    80201b18:	06400793          	li	a5,100
    80201b1c:	02f70663          	beq	a4,a5,80201b48 <vprintfmt+0x58c>
    80201b20:	f5043783          	ld	a5,-176(s0)
    80201b24:	0007c783          	lbu	a5,0(a5)
    80201b28:	00078713          	mv	a4,a5
    80201b2c:	06900793          	li	a5,105
    80201b30:	00f70c63          	beq	a4,a5,80201b48 <vprintfmt+0x58c>
    80201b34:	f5043783          	ld	a5,-176(s0)
    80201b38:	0007c783          	lbu	a5,0(a5)
    80201b3c:	00078713          	mv	a4,a5
    80201b40:	07500793          	li	a5,117
    80201b44:	08f71063          	bne	a4,a5,80201bc4 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    80201b48:	f8144783          	lbu	a5,-127(s0)
    80201b4c:	00078c63          	beqz	a5,80201b64 <vprintfmt+0x5a8>
    80201b50:	f4843783          	ld	a5,-184(s0)
    80201b54:	00878713          	addi	a4,a5,8
    80201b58:	f4e43423          	sd	a4,-184(s0)
    80201b5c:	0007b783          	ld	a5,0(a5)
    80201b60:	0140006f          	j	80201b74 <vprintfmt+0x5b8>
    80201b64:	f4843783          	ld	a5,-184(s0)
    80201b68:	00878713          	addi	a4,a5,8
    80201b6c:	f4e43423          	sd	a4,-184(s0)
    80201b70:	0007a783          	lw	a5,0(a5)
    80201b74:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201b78:	fa843583          	ld	a1,-88(s0)
    80201b7c:	f5043783          	ld	a5,-176(s0)
    80201b80:	0007c783          	lbu	a5,0(a5)
    80201b84:	0007871b          	sext.w	a4,a5
    80201b88:	07500793          	li	a5,117
    80201b8c:	40f707b3          	sub	a5,a4,a5
    80201b90:	00f037b3          	snez	a5,a5
    80201b94:	0ff7f793          	zext.b	a5,a5
    80201b98:	f8040713          	addi	a4,s0,-128
    80201b9c:	00070693          	mv	a3,a4
    80201ba0:	00078613          	mv	a2,a5
    80201ba4:	f5843503          	ld	a0,-168(s0)
    80201ba8:	ee4ff0ef          	jal	8020128c <print_dec_int>
    80201bac:	00050793          	mv	a5,a0
    80201bb0:	fec42703          	lw	a4,-20(s0)
    80201bb4:	00f707bb          	addw	a5,a4,a5
    80201bb8:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201bbc:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201bc0:	1b80006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    80201bc4:	f5043783          	ld	a5,-176(s0)
    80201bc8:	0007c783          	lbu	a5,0(a5)
    80201bcc:	00078713          	mv	a4,a5
    80201bd0:	06e00793          	li	a5,110
    80201bd4:	04f71c63          	bne	a4,a5,80201c2c <vprintfmt+0x670>
                if (flags.longflag) {
    80201bd8:	f8144783          	lbu	a5,-127(s0)
    80201bdc:	02078463          	beqz	a5,80201c04 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    80201be0:	f4843783          	ld	a5,-184(s0)
    80201be4:	00878713          	addi	a4,a5,8
    80201be8:	f4e43423          	sd	a4,-184(s0)
    80201bec:	0007b783          	ld	a5,0(a5)
    80201bf0:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201bf4:	fec42703          	lw	a4,-20(s0)
    80201bf8:	fb043783          	ld	a5,-80(s0)
    80201bfc:	00e7b023          	sd	a4,0(a5)
    80201c00:	0240006f          	j	80201c24 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    80201c04:	f4843783          	ld	a5,-184(s0)
    80201c08:	00878713          	addi	a4,a5,8
    80201c0c:	f4e43423          	sd	a4,-184(s0)
    80201c10:	0007b783          	ld	a5,0(a5)
    80201c14:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    80201c18:	fb843783          	ld	a5,-72(s0)
    80201c1c:	fec42703          	lw	a4,-20(s0)
    80201c20:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    80201c24:	f8040023          	sb	zero,-128(s0)
    80201c28:	1500006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    80201c2c:	f5043783          	ld	a5,-176(s0)
    80201c30:	0007c783          	lbu	a5,0(a5)
    80201c34:	00078713          	mv	a4,a5
    80201c38:	07300793          	li	a5,115
    80201c3c:	02f71e63          	bne	a4,a5,80201c78 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    80201c40:	f4843783          	ld	a5,-184(s0)
    80201c44:	00878713          	addi	a4,a5,8
    80201c48:	f4e43423          	sd	a4,-184(s0)
    80201c4c:	0007b783          	ld	a5,0(a5)
    80201c50:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    80201c54:	fc043583          	ld	a1,-64(s0)
    80201c58:	f5843503          	ld	a0,-168(s0)
    80201c5c:	da8ff0ef          	jal	80201204 <puts_wo_nl>
    80201c60:	00050793          	mv	a5,a0
    80201c64:	fec42703          	lw	a4,-20(s0)
    80201c68:	00f707bb          	addw	a5,a4,a5
    80201c6c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201c70:	f8040023          	sb	zero,-128(s0)
    80201c74:	1040006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    80201c78:	f5043783          	ld	a5,-176(s0)
    80201c7c:	0007c783          	lbu	a5,0(a5)
    80201c80:	00078713          	mv	a4,a5
    80201c84:	06300793          	li	a5,99
    80201c88:	02f71e63          	bne	a4,a5,80201cc4 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    80201c8c:	f4843783          	ld	a5,-184(s0)
    80201c90:	00878713          	addi	a4,a5,8
    80201c94:	f4e43423          	sd	a4,-184(s0)
    80201c98:	0007a783          	lw	a5,0(a5)
    80201c9c:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201ca0:	fcc42703          	lw	a4,-52(s0)
    80201ca4:	f5843783          	ld	a5,-168(s0)
    80201ca8:	00070513          	mv	a0,a4
    80201cac:	000780e7          	jalr	a5
                ++written;
    80201cb0:	fec42783          	lw	a5,-20(s0)
    80201cb4:	0017879b          	addiw	a5,a5,1
    80201cb8:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201cbc:	f8040023          	sb	zero,-128(s0)
    80201cc0:	0b80006f          	j	80201d78 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    80201cc4:	f5043783          	ld	a5,-176(s0)
    80201cc8:	0007c783          	lbu	a5,0(a5)
    80201ccc:	00078713          	mv	a4,a5
    80201cd0:	02500793          	li	a5,37
    80201cd4:	02f71263          	bne	a4,a5,80201cf8 <vprintfmt+0x73c>
                putch('%');
    80201cd8:	f5843783          	ld	a5,-168(s0)
    80201cdc:	02500513          	li	a0,37
    80201ce0:	000780e7          	jalr	a5
                ++written;
    80201ce4:	fec42783          	lw	a5,-20(s0)
    80201ce8:	0017879b          	addiw	a5,a5,1
    80201cec:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201cf0:	f8040023          	sb	zero,-128(s0)
    80201cf4:	0840006f          	j	80201d78 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    80201cf8:	f5043783          	ld	a5,-176(s0)
    80201cfc:	0007c783          	lbu	a5,0(a5)
    80201d00:	0007871b          	sext.w	a4,a5
    80201d04:	f5843783          	ld	a5,-168(s0)
    80201d08:	00070513          	mv	a0,a4
    80201d0c:	000780e7          	jalr	a5
                ++written;
    80201d10:	fec42783          	lw	a5,-20(s0)
    80201d14:	0017879b          	addiw	a5,a5,1
    80201d18:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201d1c:	f8040023          	sb	zero,-128(s0)
    80201d20:	0580006f          	j	80201d78 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    80201d24:	f5043783          	ld	a5,-176(s0)
    80201d28:	0007c783          	lbu	a5,0(a5)
    80201d2c:	00078713          	mv	a4,a5
    80201d30:	02500793          	li	a5,37
    80201d34:	02f71063          	bne	a4,a5,80201d54 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    80201d38:	f8043023          	sd	zero,-128(s0)
    80201d3c:	f8043423          	sd	zero,-120(s0)
    80201d40:	00100793          	li	a5,1
    80201d44:	f8f40023          	sb	a5,-128(s0)
    80201d48:	fff00793          	li	a5,-1
    80201d4c:	f8f42623          	sw	a5,-116(s0)
    80201d50:	0280006f          	j	80201d78 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    80201d54:	f5043783          	ld	a5,-176(s0)
    80201d58:	0007c783          	lbu	a5,0(a5)
    80201d5c:	0007871b          	sext.w	a4,a5
    80201d60:	f5843783          	ld	a5,-168(s0)
    80201d64:	00070513          	mv	a0,a4
    80201d68:	000780e7          	jalr	a5
            ++written;
    80201d6c:	fec42783          	lw	a5,-20(s0)
    80201d70:	0017879b          	addiw	a5,a5,1
    80201d74:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201d78:	f5043783          	ld	a5,-176(s0)
    80201d7c:	00178793          	addi	a5,a5,1
    80201d80:	f4f43823          	sd	a5,-176(s0)
    80201d84:	f5043783          	ld	a5,-176(s0)
    80201d88:	0007c783          	lbu	a5,0(a5)
    80201d8c:	84079ee3          	bnez	a5,802015e8 <vprintfmt+0x2c>
        }
    }

    return written;
    80201d90:	fec42783          	lw	a5,-20(s0)
}
    80201d94:	00078513          	mv	a0,a5
    80201d98:	0b813083          	ld	ra,184(sp)
    80201d9c:	0b013403          	ld	s0,176(sp)
    80201da0:	0c010113          	addi	sp,sp,192
    80201da4:	00008067          	ret

0000000080201da8 <printk>:

int printk(const char* s, ...) {
    80201da8:	f9010113          	addi	sp,sp,-112
    80201dac:	02113423          	sd	ra,40(sp)
    80201db0:	02813023          	sd	s0,32(sp)
    80201db4:	03010413          	addi	s0,sp,48
    80201db8:	fca43c23          	sd	a0,-40(s0)
    80201dbc:	00b43423          	sd	a1,8(s0)
    80201dc0:	00c43823          	sd	a2,16(s0)
    80201dc4:	00d43c23          	sd	a3,24(s0)
    80201dc8:	02e43023          	sd	a4,32(s0)
    80201dcc:	02f43423          	sd	a5,40(s0)
    80201dd0:	03043823          	sd	a6,48(s0)
    80201dd4:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201dd8:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201ddc:	04040793          	addi	a5,s0,64
    80201de0:	fcf43823          	sd	a5,-48(s0)
    80201de4:	fd043783          	ld	a5,-48(s0)
    80201de8:	fc878793          	addi	a5,a5,-56
    80201dec:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201df0:	fe043783          	ld	a5,-32(s0)
    80201df4:	00078613          	mv	a2,a5
    80201df8:	fd843583          	ld	a1,-40(s0)
    80201dfc:	fffff517          	auipc	a0,0xfffff
    80201e00:	0ec50513          	addi	a0,a0,236 # 80200ee8 <putc>
    80201e04:	fb8ff0ef          	jal	802015bc <vprintfmt>
    80201e08:	00050793          	mv	a5,a0
    80201e0c:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    80201e10:	fec42783          	lw	a5,-20(s0)
}
    80201e14:	00078513          	mv	a0,a5
    80201e18:	02813083          	ld	ra,40(sp)
    80201e1c:	02013403          	ld	s0,32(sp)
    80201e20:	07010113          	addi	sp,sp,112
    80201e24:	00008067          	ret

0000000080201e28 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
    80201e28:	fe010113          	addi	sp,sp,-32
    80201e2c:	00113c23          	sd	ra,24(sp)
    80201e30:	00813823          	sd	s0,16(sp)
    80201e34:	02010413          	addi	s0,sp,32
    80201e38:	00050793          	mv	a5,a0
    80201e3c:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
    80201e40:	fec42783          	lw	a5,-20(s0)
    80201e44:	fff7879b          	addiw	a5,a5,-1
    80201e48:	0007879b          	sext.w	a5,a5
    80201e4c:	02079713          	slli	a4,a5,0x20
    80201e50:	02075713          	srli	a4,a4,0x20
    80201e54:	00003797          	auipc	a5,0x3
    80201e58:	1dc78793          	addi	a5,a5,476 # 80205030 <seed>
    80201e5c:	00e7b023          	sd	a4,0(a5)
}
    80201e60:	00000013          	nop
    80201e64:	01813083          	ld	ra,24(sp)
    80201e68:	01013403          	ld	s0,16(sp)
    80201e6c:	02010113          	addi	sp,sp,32
    80201e70:	00008067          	ret

0000000080201e74 <rand>:

int rand(void) {
    80201e74:	ff010113          	addi	sp,sp,-16
    80201e78:	00113423          	sd	ra,8(sp)
    80201e7c:	00813023          	sd	s0,0(sp)
    80201e80:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
    80201e84:	00003797          	auipc	a5,0x3
    80201e88:	1ac78793          	addi	a5,a5,428 # 80205030 <seed>
    80201e8c:	0007b703          	ld	a4,0(a5)
    80201e90:	00000797          	auipc	a5,0x0
    80201e94:	31878793          	addi	a5,a5,792 # 802021a8 <lowerxdigits.0+0x18>
    80201e98:	0007b783          	ld	a5,0(a5)
    80201e9c:	02f707b3          	mul	a5,a4,a5
    80201ea0:	00178713          	addi	a4,a5,1
    80201ea4:	00003797          	auipc	a5,0x3
    80201ea8:	18c78793          	addi	a5,a5,396 # 80205030 <seed>
    80201eac:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
    80201eb0:	00003797          	auipc	a5,0x3
    80201eb4:	18078793          	addi	a5,a5,384 # 80205030 <seed>
    80201eb8:	0007b783          	ld	a5,0(a5)
    80201ebc:	0217d793          	srli	a5,a5,0x21
    80201ec0:	0007879b          	sext.w	a5,a5
}
    80201ec4:	00078513          	mv	a0,a5
    80201ec8:	00813083          	ld	ra,8(sp)
    80201ecc:	00013403          	ld	s0,0(sp)
    80201ed0:	01010113          	addi	sp,sp,16
    80201ed4:	00008067          	ret

0000000080201ed8 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
    80201ed8:	fc010113          	addi	sp,sp,-64
    80201edc:	02113c23          	sd	ra,56(sp)
    80201ee0:	02813823          	sd	s0,48(sp)
    80201ee4:	04010413          	addi	s0,sp,64
    80201ee8:	fca43c23          	sd	a0,-40(s0)
    80201eec:	00058793          	mv	a5,a1
    80201ef0:	fcc43423          	sd	a2,-56(s0)
    80201ef4:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
    80201ef8:	fd843783          	ld	a5,-40(s0)
    80201efc:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
    80201f00:	fe043423          	sd	zero,-24(s0)
    80201f04:	0280006f          	j	80201f2c <memset+0x54>
        s[i] = c;
    80201f08:	fe043703          	ld	a4,-32(s0)
    80201f0c:	fe843783          	ld	a5,-24(s0)
    80201f10:	00f707b3          	add	a5,a4,a5
    80201f14:	fd442703          	lw	a4,-44(s0)
    80201f18:	0ff77713          	zext.b	a4,a4
    80201f1c:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
    80201f20:	fe843783          	ld	a5,-24(s0)
    80201f24:	00178793          	addi	a5,a5,1
    80201f28:	fef43423          	sd	a5,-24(s0)
    80201f2c:	fe843703          	ld	a4,-24(s0)
    80201f30:	fc843783          	ld	a5,-56(s0)
    80201f34:	fcf76ae3          	bltu	a4,a5,80201f08 <memset+0x30>
    }
    return dest;
    80201f38:	fd843783          	ld	a5,-40(s0)
}
    80201f3c:	00078513          	mv	a0,a5
    80201f40:	03813083          	ld	ra,56(sp)
    80201f44:	03013403          	ld	s0,48(sp)
    80201f48:	04010113          	addi	sp,sp,64
    80201f4c:	00008067          	ret
