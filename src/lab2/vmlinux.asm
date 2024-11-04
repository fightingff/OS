
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
    80200008:	3a8000ef          	jal	802003b0 <mm_init>
    call task_init
    8020000c:	3e8000ef          	jal	802003f4 <task_init>

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
    80200024:	1ec000ef          	jal	80200210 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
    80200028:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
    8020002c:	1002a073          	csrs	sstatus,t0

    call start_kernel
    80200030:	799000ef          	jal	80200fc8 <start_kernel>

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
    802000c8:	699000ef          	jal	80200f60 <trap_handler>
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
    802001ec:	00813c23          	sd	s0,24(sp)
    802001f0:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
    802001f4:	c01027f3          	rdtime	a5
    802001f8:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
    802001fc:	fe843783          	ld	a5,-24(s0)
}
    80200200:	00078513          	mv	a0,a5
    80200204:	01813403          	ld	s0,24(sp)
    80200208:	02010113          	addi	sp,sp,32
    8020020c:	00008067          	ret

0000000080200210 <clock_set_next_event>:

void clock_set_next_event() {
    80200210:	fe010113          	addi	sp,sp,-32
    80200214:	00113c23          	sd	ra,24(sp)
    80200218:	00813823          	sd	s0,16(sp)
    8020021c:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
    80200220:	fc9ff0ef          	jal	802001e8 <get_cycles>
    80200224:	00050713          	mv	a4,a0
    80200228:	00004797          	auipc	a5,0x4
    8020022c:	dd878793          	addi	a5,a5,-552 # 80204000 <TIMECLOCK>
    80200230:	0007b783          	ld	a5,0(a5)
    80200234:	00f707b3          	add	a5,a4,a5
    80200238:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    8020023c:	fe843503          	ld	a0,-24(s0)
    80200240:	36d000ef          	jal	80200dac <sbi_set_timer>
    80200244:	00000013          	nop
    80200248:	01813083          	ld	ra,24(sp)
    8020024c:	01013403          	ld	s0,16(sp)
    80200250:	02010113          	addi	sp,sp,32
    80200254:	00008067          	ret

0000000080200258 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
    80200258:	fe010113          	addi	sp,sp,-32
    8020025c:	00113c23          	sd	ra,24(sp)
    80200260:	00813823          	sd	s0,16(sp)
    80200264:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
    80200268:	00006797          	auipc	a5,0x6
    8020026c:	d9878793          	addi	a5,a5,-616 # 80206000 <kmem>
    80200270:	0007b783          	ld	a5,0(a5)
    80200274:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
    80200278:	fe843783          	ld	a5,-24(s0)
    8020027c:	0007b703          	ld	a4,0(a5)
    80200280:	00006797          	auipc	a5,0x6
    80200284:	d8078793          	addi	a5,a5,-640 # 80206000 <kmem>
    80200288:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
    8020028c:	00001637          	lui	a2,0x1
    80200290:	00000593          	li	a1,0
    80200294:	fe843503          	ld	a0,-24(s0)
    80200298:	5a9010ef          	jal	80202040 <memset>
    return (void *)r;
    8020029c:	fe843783          	ld	a5,-24(s0)
}
    802002a0:	00078513          	mv	a0,a5
    802002a4:	01813083          	ld	ra,24(sp)
    802002a8:	01013403          	ld	s0,16(sp)
    802002ac:	02010113          	addi	sp,sp,32
    802002b0:	00008067          	ret

00000000802002b4 <kfree>:

void kfree(void *addr) {
    802002b4:	fd010113          	addi	sp,sp,-48
    802002b8:	02113423          	sd	ra,40(sp)
    802002bc:	02813023          	sd	s0,32(sp)
    802002c0:	03010413          	addi	s0,sp,48
    802002c4:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
    802002c8:	fd843783          	ld	a5,-40(s0)
    802002cc:	00078693          	mv	a3,a5
    802002d0:	fd840793          	addi	a5,s0,-40
    802002d4:	fffff737          	lui	a4,0xfffff
    802002d8:	00e6f733          	and	a4,a3,a4
    802002dc:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
    802002e0:	fd843783          	ld	a5,-40(s0)
    802002e4:	00001637          	lui	a2,0x1
    802002e8:	00000593          	li	a1,0
    802002ec:	00078513          	mv	a0,a5
    802002f0:	551010ef          	jal	80202040 <memset>

    r = (struct run *)addr;
    802002f4:	fd843783          	ld	a5,-40(s0)
    802002f8:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
    802002fc:	00006797          	auipc	a5,0x6
    80200300:	d0478793          	addi	a5,a5,-764 # 80206000 <kmem>
    80200304:	0007b703          	ld	a4,0(a5)
    80200308:	fe843783          	ld	a5,-24(s0)
    8020030c:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
    80200310:	00006797          	auipc	a5,0x6
    80200314:	cf078793          	addi	a5,a5,-784 # 80206000 <kmem>
    80200318:	fe843703          	ld	a4,-24(s0)
    8020031c:	00e7b023          	sd	a4,0(a5)

    return;
    80200320:	00000013          	nop
}
    80200324:	02813083          	ld	ra,40(sp)
    80200328:	02013403          	ld	s0,32(sp)
    8020032c:	03010113          	addi	sp,sp,48
    80200330:	00008067          	ret

0000000080200334 <kfreerange>:

void kfreerange(char *start, char *end) {
    80200334:	fd010113          	addi	sp,sp,-48
    80200338:	02113423          	sd	ra,40(sp)
    8020033c:	02813023          	sd	s0,32(sp)
    80200340:	03010413          	addi	s0,sp,48
    80200344:	fca43c23          	sd	a0,-40(s0)
    80200348:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
    8020034c:	fd843703          	ld	a4,-40(s0)
    80200350:	000017b7          	lui	a5,0x1
    80200354:	fff78793          	addi	a5,a5,-1 # fff <_skernel-0x801ff001>
    80200358:	00f70733          	add	a4,a4,a5
    8020035c:	fffff7b7          	lui	a5,0xfffff
    80200360:	00f777b3          	and	a5,a4,a5
    80200364:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    80200368:	01c0006f          	j	80200384 <kfreerange+0x50>
        kfree((void *)addr);
    8020036c:	fe843503          	ld	a0,-24(s0)
    80200370:	f45ff0ef          	jal	802002b4 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    80200374:	fe843703          	ld	a4,-24(s0)
    80200378:	000017b7          	lui	a5,0x1
    8020037c:	00f707b3          	add	a5,a4,a5
    80200380:	fef43423          	sd	a5,-24(s0)
    80200384:	fe843703          	ld	a4,-24(s0)
    80200388:	000017b7          	lui	a5,0x1
    8020038c:	00f70733          	add	a4,a4,a5
    80200390:	fd043783          	ld	a5,-48(s0)
    80200394:	fce7fce3          	bgeu	a5,a4,8020036c <kfreerange+0x38>
    }
}
    80200398:	00000013          	nop
    8020039c:	00000013          	nop
    802003a0:	02813083          	ld	ra,40(sp)
    802003a4:	02013403          	ld	s0,32(sp)
    802003a8:	03010113          	addi	sp,sp,48
    802003ac:	00008067          	ret

00000000802003b0 <mm_init>:

void mm_init(void) {
    802003b0:	ff010113          	addi	sp,sp,-16
    802003b4:	00113423          	sd	ra,8(sp)
    802003b8:	00813023          	sd	s0,0(sp)
    802003bc:	01010413          	addi	s0,sp,16
    kfreerange(_ekernel, (char *)PHY_END);
    802003c0:	01100793          	li	a5,17
    802003c4:	01b79593          	slli	a1,a5,0x1b
    802003c8:	00004517          	auipc	a0,0x4
    802003cc:	c7853503          	ld	a0,-904(a0) # 80204040 <_GLOBAL_OFFSET_TABLE_+0x8>
    802003d0:	f65ff0ef          	jal	80200334 <kfreerange>
    printk("...mm_init done!\n");
    802003d4:	00003517          	auipc	a0,0x3
    802003d8:	c2c50513          	addi	a0,a0,-980 # 80203000 <_srodata>
    802003dc:	345010ef          	jal	80201f20 <printk>
}
    802003e0:	00000013          	nop
    802003e4:	00813083          	ld	ra,8(sp)
    802003e8:	00013403          	ld	s0,0(sp)
    802003ec:	01010113          	addi	sp,sp,16
    802003f0:	00008067          	ret

00000000802003f4 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
    802003f4:	fe010113          	addi	sp,sp,-32
    802003f8:	00113c23          	sd	ra,24(sp)
    802003fc:	00813823          	sd	s0,16(sp)
    80200400:	02010413          	addi	s0,sp,32
    srand(2024);
    80200404:	7e800513          	li	a0,2024
    80200408:	399010ef          	jal	80201fa0 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
    8020040c:	e4dff0ef          	jal	80200258 <kalloc>
    80200410:	00050713          	mv	a4,a0
    80200414:	00006797          	auipc	a5,0x6
    80200418:	bf478793          	addi	a5,a5,-1036 # 80206008 <idle>
    8020041c:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
    80200420:	00006797          	auipc	a5,0x6
    80200424:	be878793          	addi	a5,a5,-1048 # 80206008 <idle>
    80200428:	0007b783          	ld	a5,0(a5)
    8020042c:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
    80200430:	00006797          	auipc	a5,0x6
    80200434:	bd878793          	addi	a5,a5,-1064 # 80206008 <idle>
    80200438:	0007b783          	ld	a5,0(a5)
    8020043c:	0007b823          	sd	zero,16(a5)
    80200440:	00006717          	auipc	a4,0x6
    80200444:	bc870713          	addi	a4,a4,-1080 # 80206008 <idle>
    80200448:	00073703          	ld	a4,0(a4)
    8020044c:	0107b783          	ld	a5,16(a5)
    80200450:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
    80200454:	00006797          	auipc	a5,0x6
    80200458:	bb478793          	addi	a5,a5,-1100 # 80206008 <idle>
    8020045c:	0007b783          	ld	a5,0(a5)
    80200460:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
    80200464:	00006797          	auipc	a5,0x6
    80200468:	ba478793          	addi	a5,a5,-1116 # 80206008 <idle>
    8020046c:	0007b703          	ld	a4,0(a5)
    80200470:	00006797          	auipc	a5,0x6
    80200474:	ba878793          	addi	a5,a5,-1112 # 80206018 <task>
    80200478:	00e7b023          	sd	a4,0(a5)
    8020047c:	00006797          	auipc	a5,0x6
    80200480:	b9c78793          	addi	a5,a5,-1124 # 80206018 <task>
    80200484:	0007b703          	ld	a4,0(a5)
    80200488:	00006797          	auipc	a5,0x6
    8020048c:	b8878793          	addi	a5,a5,-1144 # 80206010 <current>
    80200490:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
    80200494:	00100793          	li	a5,1
    80200498:	fef42623          	sw	a5,-20(s0)
    8020049c:	12c0006f          	j	802005c8 <task_init+0x1d4>
        task[i] = (struct task_struct *)kalloc();
    802004a0:	db9ff0ef          	jal	80200258 <kalloc>
    802004a4:	00050693          	mv	a3,a0
    802004a8:	00006717          	auipc	a4,0x6
    802004ac:	b7070713          	addi	a4,a4,-1168 # 80206018 <task>
    802004b0:	fec42783          	lw	a5,-20(s0)
    802004b4:	00379793          	slli	a5,a5,0x3
    802004b8:	00f707b3          	add	a5,a4,a5
    802004bc:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
    802004c0:	00006717          	auipc	a4,0x6
    802004c4:	b5870713          	addi	a4,a4,-1192 # 80206018 <task>
    802004c8:	fec42783          	lw	a5,-20(s0)
    802004cc:	00379793          	slli	a5,a5,0x3
    802004d0:	00f707b3          	add	a5,a4,a5
    802004d4:	0007b783          	ld	a5,0(a5)
    802004d8:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
    802004dc:	00006717          	auipc	a4,0x6
    802004e0:	b3c70713          	addi	a4,a4,-1220 # 80206018 <task>
    802004e4:	fec42783          	lw	a5,-20(s0)
    802004e8:	00379793          	slli	a5,a5,0x3
    802004ec:	00f707b3          	add	a5,a4,a5
    802004f0:	0007b783          	ld	a5,0(a5)
    802004f4:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
    802004f8:	2ed010ef          	jal	80201fe4 <rand>
    802004fc:	00050793          	mv	a5,a0
    80200500:	00078713          	mv	a4,a5
    80200504:	00a00793          	li	a5,10
    80200508:	02f767bb          	remw	a5,a4,a5
    8020050c:	0007879b          	sext.w	a5,a5
    80200510:	0017879b          	addiw	a5,a5,1
    80200514:	0007869b          	sext.w	a3,a5
    80200518:	00006717          	auipc	a4,0x6
    8020051c:	b0070713          	addi	a4,a4,-1280 # 80206018 <task>
    80200520:	fec42783          	lw	a5,-20(s0)
    80200524:	00379793          	slli	a5,a5,0x3
    80200528:	00f707b3          	add	a5,a4,a5
    8020052c:	0007b783          	ld	a5,0(a5)
    80200530:	00068713          	mv	a4,a3
    80200534:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
    80200538:	00006717          	auipc	a4,0x6
    8020053c:	ae070713          	addi	a4,a4,-1312 # 80206018 <task>
    80200540:	fec42783          	lw	a5,-20(s0)
    80200544:	00379793          	slli	a5,a5,0x3
    80200548:	00f707b3          	add	a5,a4,a5
    8020054c:	0007b783          	ld	a5,0(a5)
    80200550:	fec42703          	lw	a4,-20(s0)
    80200554:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
    80200558:	00006717          	auipc	a4,0x6
    8020055c:	ac070713          	addi	a4,a4,-1344 # 80206018 <task>
    80200560:	fec42783          	lw	a5,-20(s0)
    80200564:	00379793          	slli	a5,a5,0x3
    80200568:	00f707b3          	add	a5,a4,a5
    8020056c:	0007b783          	ld	a5,0(a5)
    80200570:	00004717          	auipc	a4,0x4
    80200574:	ad873703          	ld	a4,-1320(a4) # 80204048 <_GLOBAL_OFFSET_TABLE_+0x10>
    80200578:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
    8020057c:	00006717          	auipc	a4,0x6
    80200580:	a9c70713          	addi	a4,a4,-1380 # 80206018 <task>
    80200584:	fec42783          	lw	a5,-20(s0)
    80200588:	00379793          	slli	a5,a5,0x3
    8020058c:	00f707b3          	add	a5,a4,a5
    80200590:	0007b783          	ld	a5,0(a5)
    80200594:	00078693          	mv	a3,a5
    80200598:	00006717          	auipc	a4,0x6
    8020059c:	a8070713          	addi	a4,a4,-1408 # 80206018 <task>
    802005a0:	fec42783          	lw	a5,-20(s0)
    802005a4:	00379793          	slli	a5,a5,0x3
    802005a8:	00f707b3          	add	a5,a4,a5
    802005ac:	0007b783          	ld	a5,0(a5)
    802005b0:	00001737          	lui	a4,0x1
    802005b4:	00e68733          	add	a4,a3,a4
    802005b8:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
    802005bc:	fec42783          	lw	a5,-20(s0)
    802005c0:	0017879b          	addiw	a5,a5,1
    802005c4:	fef42623          	sw	a5,-20(s0)
    802005c8:	fec42783          	lw	a5,-20(s0)
    802005cc:	0007871b          	sext.w	a4,a5
    802005d0:	00400793          	li	a5,4
    802005d4:	ece7d6e3          	bge	a5,a4,802004a0 <task_init+0xac>
    }
    printk("...task_init done!\n");
    802005d8:	00003517          	auipc	a0,0x3
    802005dc:	a4050513          	addi	a0,a0,-1472 # 80203018 <_srodata+0x18>
    802005e0:	141010ef          	jal	80201f20 <printk>
}
    802005e4:	00000013          	nop
    802005e8:	01813083          	ld	ra,24(sp)
    802005ec:	01013403          	ld	s0,16(sp)
    802005f0:	02010113          	addi	sp,sp,32
    802005f4:	00008067          	ret

00000000802005f8 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    802005f8:	fd010113          	addi	sp,sp,-48
    802005fc:	02113423          	sd	ra,40(sp)
    80200600:	02813023          	sd	s0,32(sp)
    80200604:	03010413          	addi	s0,sp,48
    LOG(RED);
    80200608:	00003697          	auipc	a3,0x3
    8020060c:	bf068693          	addi	a3,a3,-1040 # 802031f8 <__func__.3>
    80200610:	04100613          	li	a2,65
    80200614:	00003597          	auipc	a1,0x3
    80200618:	a1c58593          	addi	a1,a1,-1508 # 80203030 <_srodata+0x30>
    8020061c:	00003517          	auipc	a0,0x3
    80200620:	a1c50513          	addi	a0,a0,-1508 # 80203038 <_srodata+0x38>
    80200624:	0fd010ef          	jal	80201f20 <printk>
    uint64_t MOD = 1000000007;
    80200628:	3b9ad7b7          	lui	a5,0x3b9ad
    8020062c:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <_skernel-0x448535f9>
    80200630:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
    80200634:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
    80200638:	fff00793          	li	a5,-1
    8020063c:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200640:	fe442783          	lw	a5,-28(s0)
    80200644:	0007871b          	sext.w	a4,a5
    80200648:	fff00793          	li	a5,-1
    8020064c:	00f70e63          	beq	a4,a5,80200668 <dummy+0x70>
    80200650:	00006797          	auipc	a5,0x6
    80200654:	9c078793          	addi	a5,a5,-1600 # 80206010 <current>
    80200658:	0007b783          	ld	a5,0(a5)
    8020065c:	0087b703          	ld	a4,8(a5)
    80200660:	fe442783          	lw	a5,-28(s0)
    80200664:	fcf70ee3          	beq	a4,a5,80200640 <dummy+0x48>
    80200668:	00006797          	auipc	a5,0x6
    8020066c:	9a878793          	addi	a5,a5,-1624 # 80206010 <current>
    80200670:	0007b783          	ld	a5,0(a5)
    80200674:	0087b783          	ld	a5,8(a5)
    80200678:	fc0784e3          	beqz	a5,80200640 <dummy+0x48>
            if (current->counter == 1) {
    8020067c:	00006797          	auipc	a5,0x6
    80200680:	99478793          	addi	a5,a5,-1644 # 80206010 <current>
    80200684:	0007b783          	ld	a5,0(a5)
    80200688:	0087b703          	ld	a4,8(a5)
    8020068c:	00100793          	li	a5,1
    80200690:	00f71e63          	bne	a4,a5,802006ac <dummy+0xb4>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
    80200694:	00006797          	auipc	a5,0x6
    80200698:	97c78793          	addi	a5,a5,-1668 # 80206010 <current>
    8020069c:	0007b783          	ld	a5,0(a5)
    802006a0:	0087b703          	ld	a4,8(a5)
    802006a4:	fff70713          	addi	a4,a4,-1 # fff <_skernel-0x801ff001>
    802006a8:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
    802006ac:	00006797          	auipc	a5,0x6
    802006b0:	96478793          	addi	a5,a5,-1692 # 80206010 <current>
    802006b4:	0007b783          	ld	a5,0(a5)
    802006b8:	0087b783          	ld	a5,8(a5)
    802006bc:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
    802006c0:	fe843783          	ld	a5,-24(s0)
    802006c4:	00178713          	addi	a4,a5,1
    802006c8:	fd843783          	ld	a5,-40(s0)
    802006cc:	02f777b3          	remu	a5,a4,a5
    802006d0:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
    802006d4:	00006797          	auipc	a5,0x6
    802006d8:	93c78793          	addi	a5,a5,-1732 # 80206010 <current>
    802006dc:	0007b783          	ld	a5,0(a5)
    802006e0:	0187b783          	ld	a5,24(a5)
    802006e4:	fe843603          	ld	a2,-24(s0)
    802006e8:	00078593          	mv	a1,a5
    802006ec:	00003517          	auipc	a0,0x3
    802006f0:	96c50513          	addi	a0,a0,-1684 # 80203058 <_srodata+0x58>
    802006f4:	02d010ef          	jal	80201f20 <printk>
            LOG(RED "%llu\n", current->thread.ra);
    802006f8:	00006797          	auipc	a5,0x6
    802006fc:	91878793          	addi	a5,a5,-1768 # 80206010 <current>
    80200700:	0007b783          	ld	a5,0(a5)
    80200704:	0207b783          	ld	a5,32(a5)
    80200708:	00078713          	mv	a4,a5
    8020070c:	00003697          	auipc	a3,0x3
    80200710:	aec68693          	addi	a3,a3,-1300 # 802031f8 <__func__.3>
    80200714:	04d00613          	li	a2,77
    80200718:	00003597          	auipc	a1,0x3
    8020071c:	91858593          	addi	a1,a1,-1768 # 80203030 <_srodata+0x30>
    80200720:	00003517          	auipc	a0,0x3
    80200724:	96850513          	addi	a0,a0,-1688 # 80203088 <_srodata+0x88>
    80200728:	7f8010ef          	jal	80201f20 <printk>
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
    8020072c:	00006797          	auipc	a5,0x6
    80200730:	8e478793          	addi	a5,a5,-1820 # 80206010 <current>
    80200734:	0007b783          	ld	a5,0(a5)
    80200738:	0187b783          	ld	a5,24(a5)
    8020073c:	0ff7f713          	zext.b	a4,a5
    80200740:	00006797          	auipc	a5,0x6
    80200744:	92878793          	addi	a5,a5,-1752 # 80206068 <tasks_output_index>
    80200748:	0007a783          	lw	a5,0(a5)
    8020074c:	0017869b          	addiw	a3,a5,1
    80200750:	0006861b          	sext.w	a2,a3
    80200754:	00006697          	auipc	a3,0x6
    80200758:	91468693          	addi	a3,a3,-1772 # 80206068 <tasks_output_index>
    8020075c:	00c6a023          	sw	a2,0(a3)
    80200760:	0307071b          	addiw	a4,a4,48
    80200764:	0ff77713          	zext.b	a4,a4
    80200768:	00006697          	auipc	a3,0x6
    8020076c:	8d868693          	addi	a3,a3,-1832 # 80206040 <tasks_output>
    80200770:	00f687b3          	add	a5,a3,a5
    80200774:	00e78023          	sb	a4,0(a5)
            if (tasks_output_index == MAX_OUTPUT) {
    80200778:	00006797          	auipc	a5,0x6
    8020077c:	8f078793          	addi	a5,a5,-1808 # 80206068 <tasks_output_index>
    80200780:	0007a783          	lw	a5,0(a5)
    80200784:	00078713          	mv	a4,a5
    80200788:	02800793          	li	a5,40
    8020078c:	eaf71ae3          	bne	a4,a5,80200640 <dummy+0x48>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
    80200790:	fe042023          	sw	zero,-32(s0)
    80200794:	0800006f          	j	80200814 <dummy+0x21c>
                    if (tasks_output[i] != expected_output[i]) {
    80200798:	00006717          	auipc	a4,0x6
    8020079c:	8a870713          	addi	a4,a4,-1880 # 80206040 <tasks_output>
    802007a0:	fe042783          	lw	a5,-32(s0)
    802007a4:	00f707b3          	add	a5,a4,a5
    802007a8:	0007c683          	lbu	a3,0(a5)
    802007ac:	00004717          	auipc	a4,0x4
    802007b0:	85c70713          	addi	a4,a4,-1956 # 80204008 <expected_output>
    802007b4:	fe042783          	lw	a5,-32(s0)
    802007b8:	00f707b3          	add	a5,a4,a5
    802007bc:	0007c783          	lbu	a5,0(a5)
    802007c0:	00068713          	mv	a4,a3
    802007c4:	04f70263          	beq	a4,a5,80200808 <dummy+0x210>
                        printk("\033[31mTest failed!\033[0m\n");
    802007c8:	00003517          	auipc	a0,0x3
    802007cc:	8e850513          	addi	a0,a0,-1816 # 802030b0 <_srodata+0xb0>
    802007d0:	750010ef          	jal	80201f20 <printk>
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
    802007d4:	00004597          	auipc	a1,0x4
    802007d8:	83458593          	addi	a1,a1,-1996 # 80204008 <expected_output>
    802007dc:	00003517          	auipc	a0,0x3
    802007e0:	8ec50513          	addi	a0,a0,-1812 # 802030c8 <_srodata+0xc8>
    802007e4:	73c010ef          	jal	80201f20 <printk>
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
    802007e8:	00006597          	auipc	a1,0x6
    802007ec:	85858593          	addi	a1,a1,-1960 # 80206040 <tasks_output>
    802007f0:	00003517          	auipc	a0,0x3
    802007f4:	8f850513          	addi	a0,a0,-1800 # 802030e8 <_srodata+0xe8>
    802007f8:	728010ef          	jal	80201f20 <printk>
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    802007fc:	00000593          	li	a1,0
    80200800:	00000513          	li	a0,0
    80200804:	50c000ef          	jal	80200d10 <sbi_system_reset>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
    80200808:	fe042783          	lw	a5,-32(s0)
    8020080c:	0017879b          	addiw	a5,a5,1
    80200810:	fef42023          	sw	a5,-32(s0)
    80200814:	fe042783          	lw	a5,-32(s0)
    80200818:	0007871b          	sext.w	a4,a5
    8020081c:	02700793          	li	a5,39
    80200820:	f6e7dce3          	bge	a5,a4,80200798 <dummy+0x1a0>
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
    80200824:	00003517          	auipc	a0,0x3
    80200828:	8e450513          	addi	a0,a0,-1820 # 80203108 <_srodata+0x108>
    8020082c:	6f4010ef          	jal	80201f20 <printk>
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
    80200830:	00003597          	auipc	a1,0x3
    80200834:	7d858593          	addi	a1,a1,2008 # 80204008 <expected_output>
    80200838:	00003517          	auipc	a0,0x3
    8020083c:	8e850513          	addi	a0,a0,-1816 # 80203120 <_srodata+0x120>
    80200840:	6e0010ef          	jal	80201f20 <printk>
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200844:	00000593          	li	a1,0
    80200848:	00000513          	li	a0,0
    8020084c:	4c4000ef          	jal	80200d10 <sbi_system_reset>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200850:	df1ff06f          	j	80200640 <dummy+0x48>

0000000080200854 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    80200854:	fd010113          	addi	sp,sp,-48
    80200858:	02113423          	sd	ra,40(sp)
    8020085c:	02813023          	sd	s0,32(sp)
    80200860:	03010413          	addi	s0,sp,48
    80200864:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
    80200868:	00003697          	auipc	a3,0x3
    8020086c:	99868693          	addi	a3,a3,-1640 # 80203200 <__func__.2>
    80200870:	06500613          	li	a2,101
    80200874:	00002597          	auipc	a1,0x2
    80200878:	7bc58593          	addi	a1,a1,1980 # 80203030 <_srodata+0x30>
    8020087c:	00002517          	auipc	a0,0x2
    80200880:	7bc50513          	addi	a0,a0,1980 # 80203038 <_srodata+0x38>
    80200884:	69c010ef          	jal	80201f20 <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
    80200888:	00005797          	auipc	a5,0x5
    8020088c:	78878793          	addi	a5,a5,1928 # 80206010 <current>
    80200890:	0007b783          	ld	a5,0(a5)
    80200894:	0187b703          	ld	a4,24(a5)
    80200898:	fd843783          	ld	a5,-40(s0)
    8020089c:	0187b783          	ld	a5,24(a5)
    802008a0:	00003697          	auipc	a3,0x3
    802008a4:	96068693          	addi	a3,a3,-1696 # 80203200 <__func__.2>
    802008a8:	06600613          	li	a2,102
    802008ac:	00002597          	auipc	a1,0x2
    802008b0:	78458593          	addi	a1,a1,1924 # 80203030 <_srodata+0x30>
    802008b4:	00003517          	auipc	a0,0x3
    802008b8:	88c50513          	addi	a0,a0,-1908 # 80203140 <_srodata+0x140>
    802008bc:	664010ef          	jal	80201f20 <printk>
    if(current->pid != next->pid) {
    802008c0:	00005797          	auipc	a5,0x5
    802008c4:	75078793          	addi	a5,a5,1872 # 80206010 <current>
    802008c8:	0007b783          	ld	a5,0(a5)
    802008cc:	0187b703          	ld	a4,24(a5)
    802008d0:	fd843783          	ld	a5,-40(s0)
    802008d4:	0187b783          	ld	a5,24(a5)
    802008d8:	06f70a63          	beq	a4,a5,8020094c <switch_to+0xf8>
        struct task_struct *prev = current;
    802008dc:	00005797          	auipc	a5,0x5
    802008e0:	73478793          	addi	a5,a5,1844 # 80206010 <current>
    802008e4:	0007b783          	ld	a5,0(a5)
    802008e8:	fef43423          	sd	a5,-24(s0)
        current = next;
    802008ec:	00005797          	auipc	a5,0x5
    802008f0:	72478793          	addi	a5,a5,1828 # 80206010 <current>
    802008f4:	fd843703          	ld	a4,-40(s0)
    802008f8:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
    802008fc:	00005797          	auipc	a5,0x5
    80200900:	71478793          	addi	a5,a5,1812 # 80206010 <current>
    80200904:	0007b783          	ld	a5,0(a5)
    80200908:	0187b703          	ld	a4,24(a5)
    8020090c:	00005797          	auipc	a5,0x5
    80200910:	70478793          	addi	a5,a5,1796 # 80206010 <current>
    80200914:	0007b783          	ld	a5,0(a5)
    80200918:	0107b603          	ld	a2,16(a5)
    8020091c:	00005797          	auipc	a5,0x5
    80200920:	6f478793          	addi	a5,a5,1780 # 80206010 <current>
    80200924:	0007b783          	ld	a5,0(a5)
    80200928:	0087b783          	ld	a5,8(a5)
    8020092c:	00078693          	mv	a3,a5
    80200930:	00070593          	mv	a1,a4
    80200934:	00003517          	auipc	a0,0x3
    80200938:	84c50513          	addi	a0,a0,-1972 # 80203180 <_srodata+0x180>
    8020093c:	5e4010ef          	jal	80201f20 <printk>
        __switch_to(prev, next);
    80200940:	fd843583          	ld	a1,-40(s0)
    80200944:	fe843503          	ld	a0,-24(s0)
    80200948:	825ff0ef          	jal	8020016c <__switch_to>
    }
}
    8020094c:	00000013          	nop
    80200950:	02813083          	ld	ra,40(sp)
    80200954:	02013403          	ld	s0,32(sp)
    80200958:	03010113          	addi	sp,sp,48
    8020095c:	00008067          	ret

0000000080200960 <do_timer>:

void do_timer() {
    80200960:	ff010113          	addi	sp,sp,-16
    80200964:	00113423          	sd	ra,8(sp)
    80200968:	00813023          	sd	s0,0(sp)
    8020096c:	01010413          	addi	s0,sp,16
    LOG(RED);
    80200970:	00003697          	auipc	a3,0x3
    80200974:	8a068693          	addi	a3,a3,-1888 # 80203210 <__func__.1>
    80200978:	07000613          	li	a2,112
    8020097c:	00002597          	auipc	a1,0x2
    80200980:	6b458593          	addi	a1,a1,1716 # 80203030 <_srodata+0x30>
    80200984:	00002517          	auipc	a0,0x2
    80200988:	6b450513          	addi	a0,a0,1716 # 80203038 <_srodata+0x38>
    8020098c:	594010ef          	jal	80201f20 <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
    80200990:	00005797          	auipc	a5,0x5
    80200994:	68078793          	addi	a5,a5,1664 # 80206010 <current>
    80200998:	0007b783          	ld	a5,0(a5)
    8020099c:	0187b703          	ld	a4,24(a5)
    802009a0:	00005797          	auipc	a5,0x5
    802009a4:	66878793          	addi	a5,a5,1640 # 80206008 <idle>
    802009a8:	0007b783          	ld	a5,0(a5)
    802009ac:	0187b783          	ld	a5,24(a5)
    802009b0:	00f70c63          	beq	a4,a5,802009c8 <do_timer+0x68>
    802009b4:	00005797          	auipc	a5,0x5
    802009b8:	65c78793          	addi	a5,a5,1628 # 80206010 <current>
    802009bc:	0007b783          	ld	a5,0(a5)
    802009c0:	0087b783          	ld	a5,8(a5)
    802009c4:	00079663          	bnez	a5,802009d0 <do_timer+0x70>
        schedule();
    802009c8:	038000ef          	jal	80200a00 <schedule>
    802009cc:	0200006f          	j	802009ec <do_timer+0x8c>
    }
    else --(current->counter);
    802009d0:	00005797          	auipc	a5,0x5
    802009d4:	64078793          	addi	a5,a5,1600 # 80206010 <current>
    802009d8:	0007b783          	ld	a5,0(a5)
    802009dc:	0087b703          	ld	a4,8(a5)
    802009e0:	fff70713          	addi	a4,a4,-1
    802009e4:	00e7b423          	sd	a4,8(a5)
}
    802009e8:	00000013          	nop
    802009ec:	00000013          	nop
    802009f0:	00813083          	ld	ra,8(sp)
    802009f4:	00013403          	ld	s0,0(sp)
    802009f8:	01010113          	addi	sp,sp,16
    802009fc:	00008067          	ret

0000000080200a00 <schedule>:

void schedule() {
    80200a00:	fe010113          	addi	sp,sp,-32
    80200a04:	00113c23          	sd	ra,24(sp)
    80200a08:	00813823          	sd	s0,16(sp)
    80200a0c:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    LOG(RED);
    80200a10:	00003697          	auipc	a3,0x3
    80200a14:	81068693          	addi	a3,a3,-2032 # 80203220 <__func__.0>
    80200a18:	07f00613          	li	a2,127
    80200a1c:	00002597          	auipc	a1,0x2
    80200a20:	61458593          	addi	a1,a1,1556 # 80203030 <_srodata+0x30>
    80200a24:	00002517          	auipc	a0,0x2
    80200a28:	61450513          	addi	a0,a0,1556 # 80203038 <_srodata+0x38>
    80200a2c:	4f4010ef          	jal	80201f20 <printk>
    struct task_struct *next = idle;
    80200a30:	00005797          	auipc	a5,0x5
    80200a34:	5d878793          	addi	a5,a5,1496 # 80206008 <idle>
    80200a38:	0007b783          	ld	a5,0(a5)
    80200a3c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    80200a40:	00100793          	li	a5,1
    80200a44:	fef42223          	sw	a5,-28(s0)
    80200a48:	0540006f          	j	80200a9c <schedule+0x9c>
        if(task[i]->counter > next->counter){
    80200a4c:	00005717          	auipc	a4,0x5
    80200a50:	5cc70713          	addi	a4,a4,1484 # 80206018 <task>
    80200a54:	fe442783          	lw	a5,-28(s0)
    80200a58:	00379793          	slli	a5,a5,0x3
    80200a5c:	00f707b3          	add	a5,a4,a5
    80200a60:	0007b783          	ld	a5,0(a5)
    80200a64:	0087b703          	ld	a4,8(a5)
    80200a68:	fe843783          	ld	a5,-24(s0)
    80200a6c:	0087b783          	ld	a5,8(a5)
    80200a70:	02e7f063          	bgeu	a5,a4,80200a90 <schedule+0x90>
            next = task[i];
    80200a74:	00005717          	auipc	a4,0x5
    80200a78:	5a470713          	addi	a4,a4,1444 # 80206018 <task>
    80200a7c:	fe442783          	lw	a5,-28(s0)
    80200a80:	00379793          	slli	a5,a5,0x3
    80200a84:	00f707b3          	add	a5,a4,a5
    80200a88:	0007b783          	ld	a5,0(a5)
    80200a8c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
    80200a90:	fe442783          	lw	a5,-28(s0)
    80200a94:	0017879b          	addiw	a5,a5,1
    80200a98:	fef42223          	sw	a5,-28(s0)
    80200a9c:	fe442783          	lw	a5,-28(s0)
    80200aa0:	0007871b          	sext.w	a4,a5
    80200aa4:	00400793          	li	a5,4
    80200aa8:	fae7d2e3          	bge	a5,a4,80200a4c <schedule+0x4c>
        }
    }

    if(next->counter == 0) {
    80200aac:	fe843783          	ld	a5,-24(s0)
    80200ab0:	0087b783          	ld	a5,8(a5)
    80200ab4:	0c079e63          	bnez	a5,80200b90 <schedule+0x190>
        printk("\n");
    80200ab8:	00002517          	auipc	a0,0x2
    80200abc:	70050513          	addi	a0,a0,1792 # 802031b8 <_srodata+0x1b8>
    80200ac0:	460010ef          	jal	80201f20 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
    80200ac4:	00100793          	li	a5,1
    80200ac8:	fef42023          	sw	a5,-32(s0)
    80200acc:	0ac0006f          	j	80200b78 <schedule+0x178>
            task[i]->counter = task[i]->priority;
    80200ad0:	00005717          	auipc	a4,0x5
    80200ad4:	54870713          	addi	a4,a4,1352 # 80206018 <task>
    80200ad8:	fe042783          	lw	a5,-32(s0)
    80200adc:	00379793          	slli	a5,a5,0x3
    80200ae0:	00f707b3          	add	a5,a4,a5
    80200ae4:	0007b703          	ld	a4,0(a5)
    80200ae8:	00005697          	auipc	a3,0x5
    80200aec:	53068693          	addi	a3,a3,1328 # 80206018 <task>
    80200af0:	fe042783          	lw	a5,-32(s0)
    80200af4:	00379793          	slli	a5,a5,0x3
    80200af8:	00f687b3          	add	a5,a3,a5
    80200afc:	0007b783          	ld	a5,0(a5)
    80200b00:	01073703          	ld	a4,16(a4)
    80200b04:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
    80200b08:	00005717          	auipc	a4,0x5
    80200b0c:	51070713          	addi	a4,a4,1296 # 80206018 <task>
    80200b10:	fe042783          	lw	a5,-32(s0)
    80200b14:	00379793          	slli	a5,a5,0x3
    80200b18:	00f707b3          	add	a5,a4,a5
    80200b1c:	0007b783          	ld	a5,0(a5)
    80200b20:	0187b583          	ld	a1,24(a5)
    80200b24:	00005717          	auipc	a4,0x5
    80200b28:	4f470713          	addi	a4,a4,1268 # 80206018 <task>
    80200b2c:	fe042783          	lw	a5,-32(s0)
    80200b30:	00379793          	slli	a5,a5,0x3
    80200b34:	00f707b3          	add	a5,a4,a5
    80200b38:	0007b783          	ld	a5,0(a5)
    80200b3c:	0107b603          	ld	a2,16(a5)
    80200b40:	00005717          	auipc	a4,0x5
    80200b44:	4d870713          	addi	a4,a4,1240 # 80206018 <task>
    80200b48:	fe042783          	lw	a5,-32(s0)
    80200b4c:	00379793          	slli	a5,a5,0x3
    80200b50:	00f707b3          	add	a5,a4,a5
    80200b54:	0007b783          	ld	a5,0(a5)
    80200b58:	0087b783          	ld	a5,8(a5)
    80200b5c:	00078693          	mv	a3,a5
    80200b60:	00002517          	auipc	a0,0x2
    80200b64:	66050513          	addi	a0,a0,1632 # 802031c0 <_srodata+0x1c0>
    80200b68:	3b8010ef          	jal	80201f20 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
    80200b6c:	fe042783          	lw	a5,-32(s0)
    80200b70:	0017879b          	addiw	a5,a5,1
    80200b74:	fef42023          	sw	a5,-32(s0)
    80200b78:	fe042783          	lw	a5,-32(s0)
    80200b7c:	0007871b          	sext.w	a4,a5
    80200b80:	00400793          	li	a5,4
    80200b84:	f4e7d6e3          	bge	a5,a4,80200ad0 <schedule+0xd0>
        }
        schedule();
    80200b88:	e79ff0ef          	jal	80200a00 <schedule>
    } else {
        switch_to(next);
    }
    80200b8c:	00c0006f          	j	80200b98 <schedule+0x198>
        switch_to(next);
    80200b90:	fe843503          	ld	a0,-24(s0)
    80200b94:	cc1ff0ef          	jal	80200854 <switch_to>
    80200b98:	00000013          	nop
    80200b9c:	01813083          	ld	ra,24(sp)
    80200ba0:	01013403          	ld	s0,16(sp)
    80200ba4:	02010113          	addi	sp,sp,32
    80200ba8:	00008067          	ret

0000000080200bac <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    80200bac:	f8010113          	addi	sp,sp,-128
    80200bb0:	06813c23          	sd	s0,120(sp)
    80200bb4:	06913823          	sd	s1,112(sp)
    80200bb8:	07213423          	sd	s2,104(sp)
    80200bbc:	07313023          	sd	s3,96(sp)
    80200bc0:	08010413          	addi	s0,sp,128
    80200bc4:	faa43c23          	sd	a0,-72(s0)
    80200bc8:	fab43823          	sd	a1,-80(s0)
    80200bcc:	fac43423          	sd	a2,-88(s0)
    80200bd0:	fad43023          	sd	a3,-96(s0)
    80200bd4:	f8e43c23          	sd	a4,-104(s0)
    80200bd8:	f8f43823          	sd	a5,-112(s0)
    80200bdc:	f9043423          	sd	a6,-120(s0)
    80200be0:	f9143023          	sd	a7,-128(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    80200be4:	fb843e03          	ld	t3,-72(s0)
    80200be8:	fb043e83          	ld	t4,-80(s0)
    80200bec:	fa843f03          	ld	t5,-88(s0)
    80200bf0:	fa043f83          	ld	t6,-96(s0)
    80200bf4:	f9843283          	ld	t0,-104(s0)
    80200bf8:	f9043483          	ld	s1,-112(s0)
    80200bfc:	f8843903          	ld	s2,-120(s0)
    80200c00:	f8043983          	ld	s3,-128(s0)
    80200c04:	000e0893          	mv	a7,t3
    80200c08:	000e8813          	mv	a6,t4
    80200c0c:	000f0513          	mv	a0,t5
    80200c10:	000f8593          	mv	a1,t6
    80200c14:	00028613          	mv	a2,t0
    80200c18:	00048693          	mv	a3,s1
    80200c1c:	00090713          	mv	a4,s2
    80200c20:	00098793          	mv	a5,s3
    80200c24:	00000073          	ecall
    80200c28:	00050e93          	mv	t4,a0
    80200c2c:	00058e13          	mv	t3,a1
    80200c30:	fdd43023          	sd	t4,-64(s0)
    80200c34:	fdc43423          	sd	t3,-56(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    80200c38:	fc043783          	ld	a5,-64(s0)
    80200c3c:	fcf43823          	sd	a5,-48(s0)
    80200c40:	fc843783          	ld	a5,-56(s0)
    80200c44:	fcf43c23          	sd	a5,-40(s0)
    80200c48:	fd043703          	ld	a4,-48(s0)
    80200c4c:	fd843783          	ld	a5,-40(s0)
    80200c50:	00070313          	mv	t1,a4
    80200c54:	00078393          	mv	t2,a5
    80200c58:	00030713          	mv	a4,t1
    80200c5c:	00038793          	mv	a5,t2
}
    80200c60:	00070513          	mv	a0,a4
    80200c64:	00078593          	mv	a1,a5
    80200c68:	07813403          	ld	s0,120(sp)
    80200c6c:	07013483          	ld	s1,112(sp)
    80200c70:	06813903          	ld	s2,104(sp)
    80200c74:	06013983          	ld	s3,96(sp)
    80200c78:	08010113          	addi	sp,sp,128
    80200c7c:	00008067          	ret

0000000080200c80 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    80200c80:	fc010113          	addi	sp,sp,-64
    80200c84:	02113c23          	sd	ra,56(sp)
    80200c88:	02813823          	sd	s0,48(sp)
    80200c8c:	03213423          	sd	s2,40(sp)
    80200c90:	03313023          	sd	s3,32(sp)
    80200c94:	04010413          	addi	s0,sp,64
    80200c98:	00050793          	mv	a5,a0
    80200c9c:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200ca0:	fcf44603          	lbu	a2,-49(s0)
    80200ca4:	00000893          	li	a7,0
    80200ca8:	00000813          	li	a6,0
    80200cac:	00000793          	li	a5,0
    80200cb0:	00000713          	li	a4,0
    80200cb4:	00000693          	li	a3,0
    80200cb8:	00200593          	li	a1,2
    80200cbc:	44424537          	lui	a0,0x44424
    80200cc0:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200cc4:	ee9ff0ef          	jal	80200bac <sbi_ecall>
    80200cc8:	00050713          	mv	a4,a0
    80200ccc:	00058793          	mv	a5,a1
    80200cd0:	fce43823          	sd	a4,-48(s0)
    80200cd4:	fcf43c23          	sd	a5,-40(s0)
    80200cd8:	fd043703          	ld	a4,-48(s0)
    80200cdc:	fd843783          	ld	a5,-40(s0)
    80200ce0:	00070913          	mv	s2,a4
    80200ce4:	00078993          	mv	s3,a5
    80200ce8:	00090713          	mv	a4,s2
    80200cec:	00098793          	mv	a5,s3
}
    80200cf0:	00070513          	mv	a0,a4
    80200cf4:	00078593          	mv	a1,a5
    80200cf8:	03813083          	ld	ra,56(sp)
    80200cfc:	03013403          	ld	s0,48(sp)
    80200d00:	02813903          	ld	s2,40(sp)
    80200d04:	02013983          	ld	s3,32(sp)
    80200d08:	04010113          	addi	sp,sp,64
    80200d0c:	00008067          	ret

0000000080200d10 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    80200d10:	fc010113          	addi	sp,sp,-64
    80200d14:	02113c23          	sd	ra,56(sp)
    80200d18:	02813823          	sd	s0,48(sp)
    80200d1c:	03213423          	sd	s2,40(sp)
    80200d20:	03313023          	sd	s3,32(sp)
    80200d24:	04010413          	addi	s0,sp,64
    80200d28:	00050793          	mv	a5,a0
    80200d2c:	00058713          	mv	a4,a1
    80200d30:	fcf42623          	sw	a5,-52(s0)
    80200d34:	00070793          	mv	a5,a4
    80200d38:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    80200d3c:	fcc46603          	lwu	a2,-52(s0)
    80200d40:	fc846683          	lwu	a3,-56(s0)
    80200d44:	00000893          	li	a7,0
    80200d48:	00000813          	li	a6,0
    80200d4c:	00000793          	li	a5,0
    80200d50:	00000713          	li	a4,0
    80200d54:	00000593          	li	a1,0
    80200d58:	53525537          	lui	a0,0x53525
    80200d5c:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200d60:	e4dff0ef          	jal	80200bac <sbi_ecall>
    80200d64:	00050713          	mv	a4,a0
    80200d68:	00058793          	mv	a5,a1
    80200d6c:	fce43823          	sd	a4,-48(s0)
    80200d70:	fcf43c23          	sd	a5,-40(s0)
    80200d74:	fd043703          	ld	a4,-48(s0)
    80200d78:	fd843783          	ld	a5,-40(s0)
    80200d7c:	00070913          	mv	s2,a4
    80200d80:	00078993          	mv	s3,a5
    80200d84:	00090713          	mv	a4,s2
    80200d88:	00098793          	mv	a5,s3
}
    80200d8c:	00070513          	mv	a0,a4
    80200d90:	00078593          	mv	a1,a5
    80200d94:	03813083          	ld	ra,56(sp)
    80200d98:	03013403          	ld	s0,48(sp)
    80200d9c:	02813903          	ld	s2,40(sp)
    80200da0:	02013983          	ld	s3,32(sp)
    80200da4:	04010113          	addi	sp,sp,64
    80200da8:	00008067          	ret

0000000080200dac <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    80200dac:	fc010113          	addi	sp,sp,-64
    80200db0:	02113c23          	sd	ra,56(sp)
    80200db4:	02813823          	sd	s0,48(sp)
    80200db8:	03213423          	sd	s2,40(sp)
    80200dbc:	03313023          	sd	s3,32(sp)
    80200dc0:	04010413          	addi	s0,sp,64
    80200dc4:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    80200dc8:	00000893          	li	a7,0
    80200dcc:	00000813          	li	a6,0
    80200dd0:	00000793          	li	a5,0
    80200dd4:	00000713          	li	a4,0
    80200dd8:	00000693          	li	a3,0
    80200ddc:	fc843603          	ld	a2,-56(s0)
    80200de0:	00000593          	li	a1,0
    80200de4:	54495537          	lui	a0,0x54495
    80200de8:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200dec:	dc1ff0ef          	jal	80200bac <sbi_ecall>
    80200df0:	00050713          	mv	a4,a0
    80200df4:	00058793          	mv	a5,a1
    80200df8:	fce43823          	sd	a4,-48(s0)
    80200dfc:	fcf43c23          	sd	a5,-40(s0)
    80200e00:	fd043703          	ld	a4,-48(s0)
    80200e04:	fd843783          	ld	a5,-40(s0)
    80200e08:	00070913          	mv	s2,a4
    80200e0c:	00078993          	mv	s3,a5
    80200e10:	00090713          	mv	a4,s2
    80200e14:	00098793          	mv	a5,s3
}
    80200e18:	00070513          	mv	a0,a4
    80200e1c:	00078593          	mv	a1,a5
    80200e20:	03813083          	ld	ra,56(sp)
    80200e24:	03013403          	ld	s0,48(sp)
    80200e28:	02813903          	ld	s2,40(sp)
    80200e2c:	02013983          	ld	s3,32(sp)
    80200e30:	04010113          	addi	sp,sp,64
    80200e34:	00008067          	ret

0000000080200e38 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    80200e38:	fb010113          	addi	sp,sp,-80
    80200e3c:	04113423          	sd	ra,72(sp)
    80200e40:	04813023          	sd	s0,64(sp)
    80200e44:	03213c23          	sd	s2,56(sp)
    80200e48:	03313823          	sd	s3,48(sp)
    80200e4c:	05010413          	addi	s0,sp,80
    80200e50:	fca43423          	sd	a0,-56(s0)
    80200e54:	fcb43023          	sd	a1,-64(s0)
    80200e58:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200e5c:	00000893          	li	a7,0
    80200e60:	00000813          	li	a6,0
    80200e64:	00000793          	li	a5,0
    80200e68:	fb843703          	ld	a4,-72(s0)
    80200e6c:	fc043683          	ld	a3,-64(s0)
    80200e70:	fc843603          	ld	a2,-56(s0)
    80200e74:	00100593          	li	a1,1
    80200e78:	44424537          	lui	a0,0x44424
    80200e7c:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200e80:	d2dff0ef          	jal	80200bac <sbi_ecall>
    80200e84:	00050713          	mv	a4,a0
    80200e88:	00058793          	mv	a5,a1
    80200e8c:	fce43823          	sd	a4,-48(s0)
    80200e90:	fcf43c23          	sd	a5,-40(s0)
    80200e94:	fd043703          	ld	a4,-48(s0)
    80200e98:	fd843783          	ld	a5,-40(s0)
    80200e9c:	00070913          	mv	s2,a4
    80200ea0:	00078993          	mv	s3,a5
    80200ea4:	00090713          	mv	a4,s2
    80200ea8:	00098793          	mv	a5,s3
}
    80200eac:	00070513          	mv	a0,a4
    80200eb0:	00078593          	mv	a1,a5
    80200eb4:	04813083          	ld	ra,72(sp)
    80200eb8:	04013403          	ld	s0,64(sp)
    80200ebc:	03813903          	ld	s2,56(sp)
    80200ec0:	03013983          	ld	s3,48(sp)
    80200ec4:	05010113          	addi	sp,sp,80
    80200ec8:	00008067          	ret

0000000080200ecc <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    80200ecc:	fb010113          	addi	sp,sp,-80
    80200ed0:	04113423          	sd	ra,72(sp)
    80200ed4:	04813023          	sd	s0,64(sp)
    80200ed8:	03213c23          	sd	s2,56(sp)
    80200edc:	03313823          	sd	s3,48(sp)
    80200ee0:	05010413          	addi	s0,sp,80
    80200ee4:	fca43423          	sd	a0,-56(s0)
    80200ee8:	fcb43023          	sd	a1,-64(s0)
    80200eec:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200ef0:	00000893          	li	a7,0
    80200ef4:	00000813          	li	a6,0
    80200ef8:	00000793          	li	a5,0
    80200efc:	fb843703          	ld	a4,-72(s0)
    80200f00:	fc043683          	ld	a3,-64(s0)
    80200f04:	fc843603          	ld	a2,-56(s0)
    80200f08:	00000593          	li	a1,0
    80200f0c:	44424537          	lui	a0,0x44424
    80200f10:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200f14:	c99ff0ef          	jal	80200bac <sbi_ecall>
    80200f18:	00050713          	mv	a4,a0
    80200f1c:	00058793          	mv	a5,a1
    80200f20:	fce43823          	sd	a4,-48(s0)
    80200f24:	fcf43c23          	sd	a5,-40(s0)
    80200f28:	fd043703          	ld	a4,-48(s0)
    80200f2c:	fd843783          	ld	a5,-40(s0)
    80200f30:	00070913          	mv	s2,a4
    80200f34:	00078993          	mv	s3,a5
    80200f38:	00090713          	mv	a4,s2
    80200f3c:	00098793          	mv	a5,s3
    80200f40:	00070513          	mv	a0,a4
    80200f44:	00078593          	mv	a1,a5
    80200f48:	04813083          	ld	ra,72(sp)
    80200f4c:	04013403          	ld	s0,64(sp)
    80200f50:	03813903          	ld	s2,56(sp)
    80200f54:	03013983          	ld	s3,48(sp)
    80200f58:	05010113          	addi	sp,sp,80
    80200f5c:	00008067          	ret

0000000080200f60 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200f60:	fe010113          	addi	sp,sp,-32
    80200f64:	00113c23          	sd	ra,24(sp)
    80200f68:	00813823          	sd	s0,16(sp)
    80200f6c:	02010413          	addi	s0,sp,32
    80200f70:	fea43423          	sd	a0,-24(s0)
    80200f74:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    80200f78:	fe843783          	ld	a5,-24(s0)
    80200f7c:	0207d063          	bgez	a5,80200f9c <trap_handler+0x3c>
    80200f80:	fe843783          	ld	a5,-24(s0)
    80200f84:	0ff7f713          	zext.b	a4,a5
    80200f88:	00500793          	li	a5,5
    80200f8c:	00f71863          	bne	a4,a5,80200f9c <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
    80200f90:	a80ff0ef          	jal	80200210 <clock_set_next_event>

        // schedule
        do_timer();
    80200f94:	9cdff0ef          	jal	80200960 <do_timer>
    80200f98:	01c0006f          	j	80200fb4 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    80200f9c:	fe043603          	ld	a2,-32(s0)
    80200fa0:	fe843583          	ld	a1,-24(s0)
    80200fa4:	00002517          	auipc	a0,0x2
    80200fa8:	28c50513          	addi	a0,a0,652 # 80203230 <__func__.0+0x10>
    80200fac:	775000ef          	jal	80201f20 <printk>
    }
    80200fb0:	00000013          	nop
    80200fb4:	00000013          	nop
    80200fb8:	01813083          	ld	ra,24(sp)
    80200fbc:	01013403          	ld	s0,16(sp)
    80200fc0:	02010113          	addi	sp,sp,32
    80200fc4:	00008067          	ret

0000000080200fc8 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
    80200fc8:	ff010113          	addi	sp,sp,-16
    80200fcc:	00113423          	sd	ra,8(sp)
    80200fd0:	00813023          	sd	s0,0(sp)
    80200fd4:	01010413          	addi	s0,sp,16
    printk("2024");
    80200fd8:	00002517          	auipc	a0,0x2
    80200fdc:	29850513          	addi	a0,a0,664 # 80203270 <__func__.0+0x50>
    80200fe0:	741000ef          	jal	80201f20 <printk>
    printk(" ZJU Operating System\n");
    80200fe4:	00002517          	auipc	a0,0x2
    80200fe8:	29450513          	addi	a0,a0,660 # 80203278 <__func__.0+0x58>
    80200fec:	735000ef          	jal	80201f20 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
    80200ff0:	088000ef          	jal	80201078 <run_idle>
    return 0;
    80200ff4:	00000793          	li	a5,0
}
    80200ff8:	00078513          	mv	a0,a5
    80200ffc:	00813083          	ld	ra,8(sp)
    80201000:	00013403          	ld	s0,0(sp)
    80201004:	01010113          	addi	sp,sp,16
    80201008:	00008067          	ret

000000008020100c <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    8020100c:	ff010113          	addi	sp,sp,-16
    80201010:	00113423          	sd	ra,8(sp)
    80201014:	00813023          	sd	s0,0(sp)
    80201018:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    8020101c:	00000593          	li	a1,0
    80201020:	00000513          	li	a0,0
    80201024:	cedff0ef          	jal	80200d10 <sbi_system_reset>

0000000080201028 <test>:
    __builtin_unreachable();
}

void test() {
    80201028:	fe010113          	addi	sp,sp,-32
    8020102c:	00113c23          	sd	ra,24(sp)
    80201030:	00813823          	sd	s0,16(sp)
    80201034:	02010413          	addi	s0,sp,32
    int i = 0;
    80201038:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
    8020103c:	fec42783          	lw	a5,-20(s0)
    80201040:	0017879b          	addiw	a5,a5,1
    80201044:	fef42623          	sw	a5,-20(s0)
    80201048:	fec42783          	lw	a5,-20(s0)
    8020104c:	00078713          	mv	a4,a5
    80201050:	05f5e7b7          	lui	a5,0x5f5e
    80201054:	1007879b          	addiw	a5,a5,256 # 5f5e100 <_skernel-0x7a2a1f00>
    80201058:	02f767bb          	remw	a5,a4,a5
    8020105c:	0007879b          	sext.w	a5,a5
    80201060:	fc079ee3          	bnez	a5,8020103c <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
    80201064:	00002517          	auipc	a0,0x2
    80201068:	22c50513          	addi	a0,a0,556 # 80203290 <__func__.0+0x70>
    8020106c:	6b5000ef          	jal	80201f20 <printk>
            i = 0;
    80201070:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
    80201074:	fc9ff06f          	j	8020103c <test+0x14>

0000000080201078 <run_idle>:
        }
    }
}

void run_idle() {
    80201078:	ff010113          	addi	sp,sp,-16
    8020107c:	00813423          	sd	s0,8(sp)
    80201080:	01010413          	addi	s0,sp,16
    while (1) {
    80201084:	00000013          	nop
    80201088:	ffdff06f          	j	80201084 <run_idle+0xc>

000000008020108c <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    8020108c:	fe010113          	addi	sp,sp,-32
    80201090:	00113c23          	sd	ra,24(sp)
    80201094:	00813823          	sd	s0,16(sp)
    80201098:	02010413          	addi	s0,sp,32
    8020109c:	00050793          	mv	a5,a0
    802010a0:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    802010a4:	fec42783          	lw	a5,-20(s0)
    802010a8:	0ff7f793          	zext.b	a5,a5
    802010ac:	00078513          	mv	a0,a5
    802010b0:	bd1ff0ef          	jal	80200c80 <sbi_debug_console_write_byte>
    return (char)c;
    802010b4:	fec42783          	lw	a5,-20(s0)
    802010b8:	0ff7f793          	zext.b	a5,a5
    802010bc:	0007879b          	sext.w	a5,a5
}
    802010c0:	00078513          	mv	a0,a5
    802010c4:	01813083          	ld	ra,24(sp)
    802010c8:	01013403          	ld	s0,16(sp)
    802010cc:	02010113          	addi	sp,sp,32
    802010d0:	00008067          	ret

00000000802010d4 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    802010d4:	fe010113          	addi	sp,sp,-32
    802010d8:	00813c23          	sd	s0,24(sp)
    802010dc:	02010413          	addi	s0,sp,32
    802010e0:	00050793          	mv	a5,a0
    802010e4:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    802010e8:	fec42783          	lw	a5,-20(s0)
    802010ec:	0007871b          	sext.w	a4,a5
    802010f0:	02000793          	li	a5,32
    802010f4:	02f70263          	beq	a4,a5,80201118 <isspace+0x44>
    802010f8:	fec42783          	lw	a5,-20(s0)
    802010fc:	0007871b          	sext.w	a4,a5
    80201100:	00800793          	li	a5,8
    80201104:	00e7de63          	bge	a5,a4,80201120 <isspace+0x4c>
    80201108:	fec42783          	lw	a5,-20(s0)
    8020110c:	0007871b          	sext.w	a4,a5
    80201110:	00d00793          	li	a5,13
    80201114:	00e7c663          	blt	a5,a4,80201120 <isspace+0x4c>
    80201118:	00100793          	li	a5,1
    8020111c:	0080006f          	j	80201124 <isspace+0x50>
    80201120:	00000793          	li	a5,0
}
    80201124:	00078513          	mv	a0,a5
    80201128:	01813403          	ld	s0,24(sp)
    8020112c:	02010113          	addi	sp,sp,32
    80201130:	00008067          	ret

0000000080201134 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80201134:	fb010113          	addi	sp,sp,-80
    80201138:	04113423          	sd	ra,72(sp)
    8020113c:	04813023          	sd	s0,64(sp)
    80201140:	05010413          	addi	s0,sp,80
    80201144:	fca43423          	sd	a0,-56(s0)
    80201148:	fcb43023          	sd	a1,-64(s0)
    8020114c:	00060793          	mv	a5,a2
    80201150:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    80201154:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    80201158:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    8020115c:	fc843783          	ld	a5,-56(s0)
    80201160:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    80201164:	0100006f          	j	80201174 <strtol+0x40>
        p++;
    80201168:	fd843783          	ld	a5,-40(s0)
    8020116c:	00178793          	addi	a5,a5,1
    80201170:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    80201174:	fd843783          	ld	a5,-40(s0)
    80201178:	0007c783          	lbu	a5,0(a5)
    8020117c:	0007879b          	sext.w	a5,a5
    80201180:	00078513          	mv	a0,a5
    80201184:	f51ff0ef          	jal	802010d4 <isspace>
    80201188:	00050793          	mv	a5,a0
    8020118c:	fc079ee3          	bnez	a5,80201168 <strtol+0x34>
    }

    if (*p == '-') {
    80201190:	fd843783          	ld	a5,-40(s0)
    80201194:	0007c783          	lbu	a5,0(a5)
    80201198:	00078713          	mv	a4,a5
    8020119c:	02d00793          	li	a5,45
    802011a0:	00f71e63          	bne	a4,a5,802011bc <strtol+0x88>
        neg = true;
    802011a4:	00100793          	li	a5,1
    802011a8:	fef403a3          	sb	a5,-25(s0)
        p++;
    802011ac:	fd843783          	ld	a5,-40(s0)
    802011b0:	00178793          	addi	a5,a5,1
    802011b4:	fcf43c23          	sd	a5,-40(s0)
    802011b8:	0240006f          	j	802011dc <strtol+0xa8>
    } else if (*p == '+') {
    802011bc:	fd843783          	ld	a5,-40(s0)
    802011c0:	0007c783          	lbu	a5,0(a5)
    802011c4:	00078713          	mv	a4,a5
    802011c8:	02b00793          	li	a5,43
    802011cc:	00f71863          	bne	a4,a5,802011dc <strtol+0xa8>
        p++;
    802011d0:	fd843783          	ld	a5,-40(s0)
    802011d4:	00178793          	addi	a5,a5,1
    802011d8:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    802011dc:	fbc42783          	lw	a5,-68(s0)
    802011e0:	0007879b          	sext.w	a5,a5
    802011e4:	06079c63          	bnez	a5,8020125c <strtol+0x128>
        if (*p == '0') {
    802011e8:	fd843783          	ld	a5,-40(s0)
    802011ec:	0007c783          	lbu	a5,0(a5)
    802011f0:	00078713          	mv	a4,a5
    802011f4:	03000793          	li	a5,48
    802011f8:	04f71e63          	bne	a4,a5,80201254 <strtol+0x120>
            p++;
    802011fc:	fd843783          	ld	a5,-40(s0)
    80201200:	00178793          	addi	a5,a5,1
    80201204:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80201208:	fd843783          	ld	a5,-40(s0)
    8020120c:	0007c783          	lbu	a5,0(a5)
    80201210:	00078713          	mv	a4,a5
    80201214:	07800793          	li	a5,120
    80201218:	00f70c63          	beq	a4,a5,80201230 <strtol+0xfc>
    8020121c:	fd843783          	ld	a5,-40(s0)
    80201220:	0007c783          	lbu	a5,0(a5)
    80201224:	00078713          	mv	a4,a5
    80201228:	05800793          	li	a5,88
    8020122c:	00f71e63          	bne	a4,a5,80201248 <strtol+0x114>
                base = 16;
    80201230:	01000793          	li	a5,16
    80201234:	faf42e23          	sw	a5,-68(s0)
                p++;
    80201238:	fd843783          	ld	a5,-40(s0)
    8020123c:	00178793          	addi	a5,a5,1
    80201240:	fcf43c23          	sd	a5,-40(s0)
    80201244:	0180006f          	j	8020125c <strtol+0x128>
            } else {
                base = 8;
    80201248:	00800793          	li	a5,8
    8020124c:	faf42e23          	sw	a5,-68(s0)
    80201250:	00c0006f          	j	8020125c <strtol+0x128>
            }
        } else {
            base = 10;
    80201254:	00a00793          	li	a5,10
    80201258:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    8020125c:	fd843783          	ld	a5,-40(s0)
    80201260:	0007c783          	lbu	a5,0(a5)
    80201264:	00078713          	mv	a4,a5
    80201268:	02f00793          	li	a5,47
    8020126c:	02e7f863          	bgeu	a5,a4,8020129c <strtol+0x168>
    80201270:	fd843783          	ld	a5,-40(s0)
    80201274:	0007c783          	lbu	a5,0(a5)
    80201278:	00078713          	mv	a4,a5
    8020127c:	03900793          	li	a5,57
    80201280:	00e7ee63          	bltu	a5,a4,8020129c <strtol+0x168>
            digit = *p - '0';
    80201284:	fd843783          	ld	a5,-40(s0)
    80201288:	0007c783          	lbu	a5,0(a5)
    8020128c:	0007879b          	sext.w	a5,a5
    80201290:	fd07879b          	addiw	a5,a5,-48
    80201294:	fcf42a23          	sw	a5,-44(s0)
    80201298:	0800006f          	j	80201318 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    8020129c:	fd843783          	ld	a5,-40(s0)
    802012a0:	0007c783          	lbu	a5,0(a5)
    802012a4:	00078713          	mv	a4,a5
    802012a8:	06000793          	li	a5,96
    802012ac:	02e7f863          	bgeu	a5,a4,802012dc <strtol+0x1a8>
    802012b0:	fd843783          	ld	a5,-40(s0)
    802012b4:	0007c783          	lbu	a5,0(a5)
    802012b8:	00078713          	mv	a4,a5
    802012bc:	07a00793          	li	a5,122
    802012c0:	00e7ee63          	bltu	a5,a4,802012dc <strtol+0x1a8>
            digit = *p - ('a' - 10);
    802012c4:	fd843783          	ld	a5,-40(s0)
    802012c8:	0007c783          	lbu	a5,0(a5)
    802012cc:	0007879b          	sext.w	a5,a5
    802012d0:	fa97879b          	addiw	a5,a5,-87
    802012d4:	fcf42a23          	sw	a5,-44(s0)
    802012d8:	0400006f          	j	80201318 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    802012dc:	fd843783          	ld	a5,-40(s0)
    802012e0:	0007c783          	lbu	a5,0(a5)
    802012e4:	00078713          	mv	a4,a5
    802012e8:	04000793          	li	a5,64
    802012ec:	06e7f863          	bgeu	a5,a4,8020135c <strtol+0x228>
    802012f0:	fd843783          	ld	a5,-40(s0)
    802012f4:	0007c783          	lbu	a5,0(a5)
    802012f8:	00078713          	mv	a4,a5
    802012fc:	05a00793          	li	a5,90
    80201300:	04e7ee63          	bltu	a5,a4,8020135c <strtol+0x228>
            digit = *p - ('A' - 10);
    80201304:	fd843783          	ld	a5,-40(s0)
    80201308:	0007c783          	lbu	a5,0(a5)
    8020130c:	0007879b          	sext.w	a5,a5
    80201310:	fc97879b          	addiw	a5,a5,-55
    80201314:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80201318:	fd442783          	lw	a5,-44(s0)
    8020131c:	00078713          	mv	a4,a5
    80201320:	fbc42783          	lw	a5,-68(s0)
    80201324:	0007071b          	sext.w	a4,a4
    80201328:	0007879b          	sext.w	a5,a5
    8020132c:	02f75663          	bge	a4,a5,80201358 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80201330:	fbc42703          	lw	a4,-68(s0)
    80201334:	fe843783          	ld	a5,-24(s0)
    80201338:	02f70733          	mul	a4,a4,a5
    8020133c:	fd442783          	lw	a5,-44(s0)
    80201340:	00f707b3          	add	a5,a4,a5
    80201344:	fef43423          	sd	a5,-24(s0)
        p++;
    80201348:	fd843783          	ld	a5,-40(s0)
    8020134c:	00178793          	addi	a5,a5,1
    80201350:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    80201354:	f09ff06f          	j	8020125c <strtol+0x128>
            break;
    80201358:	00000013          	nop
    }

    if (endptr) {
    8020135c:	fc043783          	ld	a5,-64(s0)
    80201360:	00078863          	beqz	a5,80201370 <strtol+0x23c>
        *endptr = (char *)p;
    80201364:	fc043783          	ld	a5,-64(s0)
    80201368:	fd843703          	ld	a4,-40(s0)
    8020136c:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    80201370:	fe744783          	lbu	a5,-25(s0)
    80201374:	0ff7f793          	zext.b	a5,a5
    80201378:	00078863          	beqz	a5,80201388 <strtol+0x254>
    8020137c:	fe843783          	ld	a5,-24(s0)
    80201380:	40f007b3          	neg	a5,a5
    80201384:	0080006f          	j	8020138c <strtol+0x258>
    80201388:	fe843783          	ld	a5,-24(s0)
}
    8020138c:	00078513          	mv	a0,a5
    80201390:	04813083          	ld	ra,72(sp)
    80201394:	04013403          	ld	s0,64(sp)
    80201398:	05010113          	addi	sp,sp,80
    8020139c:	00008067          	ret

00000000802013a0 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    802013a0:	fd010113          	addi	sp,sp,-48
    802013a4:	02113423          	sd	ra,40(sp)
    802013a8:	02813023          	sd	s0,32(sp)
    802013ac:	03010413          	addi	s0,sp,48
    802013b0:	fca43c23          	sd	a0,-40(s0)
    802013b4:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    802013b8:	fd043783          	ld	a5,-48(s0)
    802013bc:	00079863          	bnez	a5,802013cc <puts_wo_nl+0x2c>
        s = "(null)";
    802013c0:	00002797          	auipc	a5,0x2
    802013c4:	ee878793          	addi	a5,a5,-280 # 802032a8 <__func__.0+0x88>
    802013c8:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    802013cc:	fd043783          	ld	a5,-48(s0)
    802013d0:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    802013d4:	0240006f          	j	802013f8 <puts_wo_nl+0x58>
        putch(*p++);
    802013d8:	fe843783          	ld	a5,-24(s0)
    802013dc:	00178713          	addi	a4,a5,1
    802013e0:	fee43423          	sd	a4,-24(s0)
    802013e4:	0007c783          	lbu	a5,0(a5)
    802013e8:	0007871b          	sext.w	a4,a5
    802013ec:	fd843783          	ld	a5,-40(s0)
    802013f0:	00070513          	mv	a0,a4
    802013f4:	000780e7          	jalr	a5
    while (*p) {
    802013f8:	fe843783          	ld	a5,-24(s0)
    802013fc:	0007c783          	lbu	a5,0(a5)
    80201400:	fc079ce3          	bnez	a5,802013d8 <puts_wo_nl+0x38>
    }
    return p - s;
    80201404:	fe843703          	ld	a4,-24(s0)
    80201408:	fd043783          	ld	a5,-48(s0)
    8020140c:	40f707b3          	sub	a5,a4,a5
    80201410:	0007879b          	sext.w	a5,a5
}
    80201414:	00078513          	mv	a0,a5
    80201418:	02813083          	ld	ra,40(sp)
    8020141c:	02013403          	ld	s0,32(sp)
    80201420:	03010113          	addi	sp,sp,48
    80201424:	00008067          	ret

0000000080201428 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    80201428:	f9010113          	addi	sp,sp,-112
    8020142c:	06113423          	sd	ra,104(sp)
    80201430:	06813023          	sd	s0,96(sp)
    80201434:	07010413          	addi	s0,sp,112
    80201438:	faa43423          	sd	a0,-88(s0)
    8020143c:	fab43023          	sd	a1,-96(s0)
    80201440:	00060793          	mv	a5,a2
    80201444:	f8d43823          	sd	a3,-112(s0)
    80201448:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    8020144c:	f9f44783          	lbu	a5,-97(s0)
    80201450:	0ff7f793          	zext.b	a5,a5
    80201454:	02078663          	beqz	a5,80201480 <print_dec_int+0x58>
    80201458:	fa043703          	ld	a4,-96(s0)
    8020145c:	fff00793          	li	a5,-1
    80201460:	03f79793          	slli	a5,a5,0x3f
    80201464:	00f71e63          	bne	a4,a5,80201480 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    80201468:	00002597          	auipc	a1,0x2
    8020146c:	e4858593          	addi	a1,a1,-440 # 802032b0 <__func__.0+0x90>
    80201470:	fa843503          	ld	a0,-88(s0)
    80201474:	f2dff0ef          	jal	802013a0 <puts_wo_nl>
    80201478:	00050793          	mv	a5,a0
    8020147c:	2a00006f          	j	8020171c <print_dec_int+0x2f4>
    }

    if (flags->prec == 0 && num == 0) {
    80201480:	f9043783          	ld	a5,-112(s0)
    80201484:	00c7a783          	lw	a5,12(a5)
    80201488:	00079a63          	bnez	a5,8020149c <print_dec_int+0x74>
    8020148c:	fa043783          	ld	a5,-96(s0)
    80201490:	00079663          	bnez	a5,8020149c <print_dec_int+0x74>
        return 0;
    80201494:	00000793          	li	a5,0
    80201498:	2840006f          	j	8020171c <print_dec_int+0x2f4>
    }

    bool neg = false;
    8020149c:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    802014a0:	f9f44783          	lbu	a5,-97(s0)
    802014a4:	0ff7f793          	zext.b	a5,a5
    802014a8:	02078063          	beqz	a5,802014c8 <print_dec_int+0xa0>
    802014ac:	fa043783          	ld	a5,-96(s0)
    802014b0:	0007dc63          	bgez	a5,802014c8 <print_dec_int+0xa0>
        neg = true;
    802014b4:	00100793          	li	a5,1
    802014b8:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    802014bc:	fa043783          	ld	a5,-96(s0)
    802014c0:	40f007b3          	neg	a5,a5
    802014c4:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    802014c8:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    802014cc:	f9f44783          	lbu	a5,-97(s0)
    802014d0:	0ff7f793          	zext.b	a5,a5
    802014d4:	02078863          	beqz	a5,80201504 <print_dec_int+0xdc>
    802014d8:	fef44783          	lbu	a5,-17(s0)
    802014dc:	0ff7f793          	zext.b	a5,a5
    802014e0:	00079e63          	bnez	a5,802014fc <print_dec_int+0xd4>
    802014e4:	f9043783          	ld	a5,-112(s0)
    802014e8:	0057c783          	lbu	a5,5(a5)
    802014ec:	00079863          	bnez	a5,802014fc <print_dec_int+0xd4>
    802014f0:	f9043783          	ld	a5,-112(s0)
    802014f4:	0047c783          	lbu	a5,4(a5)
    802014f8:	00078663          	beqz	a5,80201504 <print_dec_int+0xdc>
    802014fc:	00100793          	li	a5,1
    80201500:	0080006f          	j	80201508 <print_dec_int+0xe0>
    80201504:	00000793          	li	a5,0
    80201508:	fcf40ba3          	sb	a5,-41(s0)
    8020150c:	fd744783          	lbu	a5,-41(s0)
    80201510:	0017f793          	andi	a5,a5,1
    80201514:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80201518:	fa043703          	ld	a4,-96(s0)
    8020151c:	00a00793          	li	a5,10
    80201520:	02f777b3          	remu	a5,a4,a5
    80201524:	0ff7f713          	zext.b	a4,a5
    80201528:	fe842783          	lw	a5,-24(s0)
    8020152c:	0017869b          	addiw	a3,a5,1
    80201530:	fed42423          	sw	a3,-24(s0)
    80201534:	0307071b          	addiw	a4,a4,48
    80201538:	0ff77713          	zext.b	a4,a4
    8020153c:	ff078793          	addi	a5,a5,-16
    80201540:	008787b3          	add	a5,a5,s0
    80201544:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    80201548:	fa043703          	ld	a4,-96(s0)
    8020154c:	00a00793          	li	a5,10
    80201550:	02f757b3          	divu	a5,a4,a5
    80201554:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80201558:	fa043783          	ld	a5,-96(s0)
    8020155c:	fa079ee3          	bnez	a5,80201518 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    80201560:	f9043783          	ld	a5,-112(s0)
    80201564:	00c7a783          	lw	a5,12(a5)
    80201568:	00078713          	mv	a4,a5
    8020156c:	fff00793          	li	a5,-1
    80201570:	02f71063          	bne	a4,a5,80201590 <print_dec_int+0x168>
    80201574:	f9043783          	ld	a5,-112(s0)
    80201578:	0037c783          	lbu	a5,3(a5)
    8020157c:	00078a63          	beqz	a5,80201590 <print_dec_int+0x168>
        flags->prec = flags->width;
    80201580:	f9043783          	ld	a5,-112(s0)
    80201584:	0087a703          	lw	a4,8(a5)
    80201588:	f9043783          	ld	a5,-112(s0)
    8020158c:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80201590:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80201594:	f9043783          	ld	a5,-112(s0)
    80201598:	0087a703          	lw	a4,8(a5)
    8020159c:	fe842783          	lw	a5,-24(s0)
    802015a0:	fcf42823          	sw	a5,-48(s0)
    802015a4:	f9043783          	ld	a5,-112(s0)
    802015a8:	00c7a783          	lw	a5,12(a5)
    802015ac:	fcf42623          	sw	a5,-52(s0)
    802015b0:	fd042783          	lw	a5,-48(s0)
    802015b4:	00078593          	mv	a1,a5
    802015b8:	fcc42783          	lw	a5,-52(s0)
    802015bc:	00078613          	mv	a2,a5
    802015c0:	0006069b          	sext.w	a3,a2
    802015c4:	0005879b          	sext.w	a5,a1
    802015c8:	00f6d463          	bge	a3,a5,802015d0 <print_dec_int+0x1a8>
    802015cc:	00058613          	mv	a2,a1
    802015d0:	0006079b          	sext.w	a5,a2
    802015d4:	40f707bb          	subw	a5,a4,a5
    802015d8:	0007871b          	sext.w	a4,a5
    802015dc:	fd744783          	lbu	a5,-41(s0)
    802015e0:	0007879b          	sext.w	a5,a5
    802015e4:	40f707bb          	subw	a5,a4,a5
    802015e8:	fef42023          	sw	a5,-32(s0)
    802015ec:	0280006f          	j	80201614 <print_dec_int+0x1ec>
        putch(' ');
    802015f0:	fa843783          	ld	a5,-88(s0)
    802015f4:	02000513          	li	a0,32
    802015f8:	000780e7          	jalr	a5
        ++written;
    802015fc:	fe442783          	lw	a5,-28(s0)
    80201600:	0017879b          	addiw	a5,a5,1
    80201604:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80201608:	fe042783          	lw	a5,-32(s0)
    8020160c:	fff7879b          	addiw	a5,a5,-1
    80201610:	fef42023          	sw	a5,-32(s0)
    80201614:	fe042783          	lw	a5,-32(s0)
    80201618:	0007879b          	sext.w	a5,a5
    8020161c:	fcf04ae3          	bgtz	a5,802015f0 <print_dec_int+0x1c8>
    }

    if (has_sign_char) {
    80201620:	fd744783          	lbu	a5,-41(s0)
    80201624:	0ff7f793          	zext.b	a5,a5
    80201628:	04078463          	beqz	a5,80201670 <print_dec_int+0x248>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    8020162c:	fef44783          	lbu	a5,-17(s0)
    80201630:	0ff7f793          	zext.b	a5,a5
    80201634:	00078663          	beqz	a5,80201640 <print_dec_int+0x218>
    80201638:	02d00793          	li	a5,45
    8020163c:	01c0006f          	j	80201658 <print_dec_int+0x230>
    80201640:	f9043783          	ld	a5,-112(s0)
    80201644:	0057c783          	lbu	a5,5(a5)
    80201648:	00078663          	beqz	a5,80201654 <print_dec_int+0x22c>
    8020164c:	02b00793          	li	a5,43
    80201650:	0080006f          	j	80201658 <print_dec_int+0x230>
    80201654:	02000793          	li	a5,32
    80201658:	fa843703          	ld	a4,-88(s0)
    8020165c:	00078513          	mv	a0,a5
    80201660:	000700e7          	jalr	a4
        ++written;
    80201664:	fe442783          	lw	a5,-28(s0)
    80201668:	0017879b          	addiw	a5,a5,1
    8020166c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80201670:	fe842783          	lw	a5,-24(s0)
    80201674:	fcf42e23          	sw	a5,-36(s0)
    80201678:	0280006f          	j	802016a0 <print_dec_int+0x278>
        putch('0');
    8020167c:	fa843783          	ld	a5,-88(s0)
    80201680:	03000513          	li	a0,48
    80201684:	000780e7          	jalr	a5
        ++written;
    80201688:	fe442783          	lw	a5,-28(s0)
    8020168c:	0017879b          	addiw	a5,a5,1
    80201690:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80201694:	fdc42783          	lw	a5,-36(s0)
    80201698:	0017879b          	addiw	a5,a5,1
    8020169c:	fcf42e23          	sw	a5,-36(s0)
    802016a0:	f9043783          	ld	a5,-112(s0)
    802016a4:	00c7a703          	lw	a4,12(a5)
    802016a8:	fd744783          	lbu	a5,-41(s0)
    802016ac:	0007879b          	sext.w	a5,a5
    802016b0:	40f707bb          	subw	a5,a4,a5
    802016b4:	0007871b          	sext.w	a4,a5
    802016b8:	fdc42783          	lw	a5,-36(s0)
    802016bc:	0007879b          	sext.w	a5,a5
    802016c0:	fae7cee3          	blt	a5,a4,8020167c <print_dec_int+0x254>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    802016c4:	fe842783          	lw	a5,-24(s0)
    802016c8:	fff7879b          	addiw	a5,a5,-1
    802016cc:	fcf42c23          	sw	a5,-40(s0)
    802016d0:	03c0006f          	j	8020170c <print_dec_int+0x2e4>
        putch(buf[i]);
    802016d4:	fd842783          	lw	a5,-40(s0)
    802016d8:	ff078793          	addi	a5,a5,-16
    802016dc:	008787b3          	add	a5,a5,s0
    802016e0:	fc87c783          	lbu	a5,-56(a5)
    802016e4:	0007871b          	sext.w	a4,a5
    802016e8:	fa843783          	ld	a5,-88(s0)
    802016ec:	00070513          	mv	a0,a4
    802016f0:	000780e7          	jalr	a5
        ++written;
    802016f4:	fe442783          	lw	a5,-28(s0)
    802016f8:	0017879b          	addiw	a5,a5,1
    802016fc:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    80201700:	fd842783          	lw	a5,-40(s0)
    80201704:	fff7879b          	addiw	a5,a5,-1
    80201708:	fcf42c23          	sw	a5,-40(s0)
    8020170c:	fd842783          	lw	a5,-40(s0)
    80201710:	0007879b          	sext.w	a5,a5
    80201714:	fc07d0e3          	bgez	a5,802016d4 <print_dec_int+0x2ac>
    }

    return written;
    80201718:	fe442783          	lw	a5,-28(s0)
}
    8020171c:	00078513          	mv	a0,a5
    80201720:	06813083          	ld	ra,104(sp)
    80201724:	06013403          	ld	s0,96(sp)
    80201728:	07010113          	addi	sp,sp,112
    8020172c:	00008067          	ret

0000000080201730 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    80201730:	f4010113          	addi	sp,sp,-192
    80201734:	0a113c23          	sd	ra,184(sp)
    80201738:	0a813823          	sd	s0,176(sp)
    8020173c:	0c010413          	addi	s0,sp,192
    80201740:	f4a43c23          	sd	a0,-168(s0)
    80201744:	f4b43823          	sd	a1,-176(s0)
    80201748:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    8020174c:	f8043023          	sd	zero,-128(s0)
    80201750:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80201754:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80201758:	7a40006f          	j	80201efc <vprintfmt+0x7cc>
        if (flags.in_format) {
    8020175c:	f8044783          	lbu	a5,-128(s0)
    80201760:	72078e63          	beqz	a5,80201e9c <vprintfmt+0x76c>
            if (*fmt == '#') {
    80201764:	f5043783          	ld	a5,-176(s0)
    80201768:	0007c783          	lbu	a5,0(a5)
    8020176c:	00078713          	mv	a4,a5
    80201770:	02300793          	li	a5,35
    80201774:	00f71863          	bne	a4,a5,80201784 <vprintfmt+0x54>
                flags.sharpflag = true;
    80201778:	00100793          	li	a5,1
    8020177c:	f8f40123          	sb	a5,-126(s0)
    80201780:	7700006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == '0') {
    80201784:	f5043783          	ld	a5,-176(s0)
    80201788:	0007c783          	lbu	a5,0(a5)
    8020178c:	00078713          	mv	a4,a5
    80201790:	03000793          	li	a5,48
    80201794:	00f71863          	bne	a4,a5,802017a4 <vprintfmt+0x74>
                flags.zeroflag = true;
    80201798:	00100793          	li	a5,1
    8020179c:	f8f401a3          	sb	a5,-125(s0)
    802017a0:	7500006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    802017a4:	f5043783          	ld	a5,-176(s0)
    802017a8:	0007c783          	lbu	a5,0(a5)
    802017ac:	00078713          	mv	a4,a5
    802017b0:	06c00793          	li	a5,108
    802017b4:	04f70063          	beq	a4,a5,802017f4 <vprintfmt+0xc4>
    802017b8:	f5043783          	ld	a5,-176(s0)
    802017bc:	0007c783          	lbu	a5,0(a5)
    802017c0:	00078713          	mv	a4,a5
    802017c4:	07a00793          	li	a5,122
    802017c8:	02f70663          	beq	a4,a5,802017f4 <vprintfmt+0xc4>
    802017cc:	f5043783          	ld	a5,-176(s0)
    802017d0:	0007c783          	lbu	a5,0(a5)
    802017d4:	00078713          	mv	a4,a5
    802017d8:	07400793          	li	a5,116
    802017dc:	00f70c63          	beq	a4,a5,802017f4 <vprintfmt+0xc4>
    802017e0:	f5043783          	ld	a5,-176(s0)
    802017e4:	0007c783          	lbu	a5,0(a5)
    802017e8:	00078713          	mv	a4,a5
    802017ec:	06a00793          	li	a5,106
    802017f0:	00f71863          	bne	a4,a5,80201800 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    802017f4:	00100793          	li	a5,1
    802017f8:	f8f400a3          	sb	a5,-127(s0)
    802017fc:	6f40006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == '+') {
    80201800:	f5043783          	ld	a5,-176(s0)
    80201804:	0007c783          	lbu	a5,0(a5)
    80201808:	00078713          	mv	a4,a5
    8020180c:	02b00793          	li	a5,43
    80201810:	00f71863          	bne	a4,a5,80201820 <vprintfmt+0xf0>
                flags.sign = true;
    80201814:	00100793          	li	a5,1
    80201818:	f8f402a3          	sb	a5,-123(s0)
    8020181c:	6d40006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == ' ') {
    80201820:	f5043783          	ld	a5,-176(s0)
    80201824:	0007c783          	lbu	a5,0(a5)
    80201828:	00078713          	mv	a4,a5
    8020182c:	02000793          	li	a5,32
    80201830:	00f71863          	bne	a4,a5,80201840 <vprintfmt+0x110>
                flags.spaceflag = true;
    80201834:	00100793          	li	a5,1
    80201838:	f8f40223          	sb	a5,-124(s0)
    8020183c:	6b40006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == '*') {
    80201840:	f5043783          	ld	a5,-176(s0)
    80201844:	0007c783          	lbu	a5,0(a5)
    80201848:	00078713          	mv	a4,a5
    8020184c:	02a00793          	li	a5,42
    80201850:	00f71e63          	bne	a4,a5,8020186c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80201854:	f4843783          	ld	a5,-184(s0)
    80201858:	00878713          	addi	a4,a5,8
    8020185c:	f4e43423          	sd	a4,-184(s0)
    80201860:	0007a783          	lw	a5,0(a5)
    80201864:	f8f42423          	sw	a5,-120(s0)
    80201868:	6880006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt >= '1' && *fmt <= '9') {
    8020186c:	f5043783          	ld	a5,-176(s0)
    80201870:	0007c783          	lbu	a5,0(a5)
    80201874:	00078713          	mv	a4,a5
    80201878:	03000793          	li	a5,48
    8020187c:	04e7f663          	bgeu	a5,a4,802018c8 <vprintfmt+0x198>
    80201880:	f5043783          	ld	a5,-176(s0)
    80201884:	0007c783          	lbu	a5,0(a5)
    80201888:	00078713          	mv	a4,a5
    8020188c:	03900793          	li	a5,57
    80201890:	02e7ec63          	bltu	a5,a4,802018c8 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    80201894:	f5043783          	ld	a5,-176(s0)
    80201898:	f5040713          	addi	a4,s0,-176
    8020189c:	00a00613          	li	a2,10
    802018a0:	00070593          	mv	a1,a4
    802018a4:	00078513          	mv	a0,a5
    802018a8:	88dff0ef          	jal	80201134 <strtol>
    802018ac:	00050793          	mv	a5,a0
    802018b0:	0007879b          	sext.w	a5,a5
    802018b4:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    802018b8:	f5043783          	ld	a5,-176(s0)
    802018bc:	fff78793          	addi	a5,a5,-1
    802018c0:	f4f43823          	sd	a5,-176(s0)
    802018c4:	62c0006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == '.') {
    802018c8:	f5043783          	ld	a5,-176(s0)
    802018cc:	0007c783          	lbu	a5,0(a5)
    802018d0:	00078713          	mv	a4,a5
    802018d4:	02e00793          	li	a5,46
    802018d8:	06f71863          	bne	a4,a5,80201948 <vprintfmt+0x218>
                fmt++;
    802018dc:	f5043783          	ld	a5,-176(s0)
    802018e0:	00178793          	addi	a5,a5,1
    802018e4:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    802018e8:	f5043783          	ld	a5,-176(s0)
    802018ec:	0007c783          	lbu	a5,0(a5)
    802018f0:	00078713          	mv	a4,a5
    802018f4:	02a00793          	li	a5,42
    802018f8:	00f71e63          	bne	a4,a5,80201914 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    802018fc:	f4843783          	ld	a5,-184(s0)
    80201900:	00878713          	addi	a4,a5,8
    80201904:	f4e43423          	sd	a4,-184(s0)
    80201908:	0007a783          	lw	a5,0(a5)
    8020190c:	f8f42623          	sw	a5,-116(s0)
    80201910:	5e00006f          	j	80201ef0 <vprintfmt+0x7c0>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80201914:	f5043783          	ld	a5,-176(s0)
    80201918:	f5040713          	addi	a4,s0,-176
    8020191c:	00a00613          	li	a2,10
    80201920:	00070593          	mv	a1,a4
    80201924:	00078513          	mv	a0,a5
    80201928:	80dff0ef          	jal	80201134 <strtol>
    8020192c:	00050793          	mv	a5,a0
    80201930:	0007879b          	sext.w	a5,a5
    80201934:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80201938:	f5043783          	ld	a5,-176(s0)
    8020193c:	fff78793          	addi	a5,a5,-1
    80201940:	f4f43823          	sd	a5,-176(s0)
    80201944:	5ac0006f          	j	80201ef0 <vprintfmt+0x7c0>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201948:	f5043783          	ld	a5,-176(s0)
    8020194c:	0007c783          	lbu	a5,0(a5)
    80201950:	00078713          	mv	a4,a5
    80201954:	07800793          	li	a5,120
    80201958:	02f70663          	beq	a4,a5,80201984 <vprintfmt+0x254>
    8020195c:	f5043783          	ld	a5,-176(s0)
    80201960:	0007c783          	lbu	a5,0(a5)
    80201964:	00078713          	mv	a4,a5
    80201968:	05800793          	li	a5,88
    8020196c:	00f70c63          	beq	a4,a5,80201984 <vprintfmt+0x254>
    80201970:	f5043783          	ld	a5,-176(s0)
    80201974:	0007c783          	lbu	a5,0(a5)
    80201978:	00078713          	mv	a4,a5
    8020197c:	07000793          	li	a5,112
    80201980:	30f71263          	bne	a4,a5,80201c84 <vprintfmt+0x554>
                bool is_long = *fmt == 'p' || flags.longflag;
    80201984:	f5043783          	ld	a5,-176(s0)
    80201988:	0007c783          	lbu	a5,0(a5)
    8020198c:	00078713          	mv	a4,a5
    80201990:	07000793          	li	a5,112
    80201994:	00f70663          	beq	a4,a5,802019a0 <vprintfmt+0x270>
    80201998:	f8144783          	lbu	a5,-127(s0)
    8020199c:	00078663          	beqz	a5,802019a8 <vprintfmt+0x278>
    802019a0:	00100793          	li	a5,1
    802019a4:	0080006f          	j	802019ac <vprintfmt+0x27c>
    802019a8:	00000793          	li	a5,0
    802019ac:	faf403a3          	sb	a5,-89(s0)
    802019b0:	fa744783          	lbu	a5,-89(s0)
    802019b4:	0017f793          	andi	a5,a5,1
    802019b8:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    802019bc:	fa744783          	lbu	a5,-89(s0)
    802019c0:	0ff7f793          	zext.b	a5,a5
    802019c4:	00078c63          	beqz	a5,802019dc <vprintfmt+0x2ac>
    802019c8:	f4843783          	ld	a5,-184(s0)
    802019cc:	00878713          	addi	a4,a5,8
    802019d0:	f4e43423          	sd	a4,-184(s0)
    802019d4:	0007b783          	ld	a5,0(a5)
    802019d8:	01c0006f          	j	802019f4 <vprintfmt+0x2c4>
    802019dc:	f4843783          	ld	a5,-184(s0)
    802019e0:	00878713          	addi	a4,a5,8
    802019e4:	f4e43423          	sd	a4,-184(s0)
    802019e8:	0007a783          	lw	a5,0(a5)
    802019ec:	02079793          	slli	a5,a5,0x20
    802019f0:	0207d793          	srli	a5,a5,0x20
    802019f4:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    802019f8:	f8c42783          	lw	a5,-116(s0)
    802019fc:	02079463          	bnez	a5,80201a24 <vprintfmt+0x2f4>
    80201a00:	fe043783          	ld	a5,-32(s0)
    80201a04:	02079063          	bnez	a5,80201a24 <vprintfmt+0x2f4>
    80201a08:	f5043783          	ld	a5,-176(s0)
    80201a0c:	0007c783          	lbu	a5,0(a5)
    80201a10:	00078713          	mv	a4,a5
    80201a14:	07000793          	li	a5,112
    80201a18:	00f70663          	beq	a4,a5,80201a24 <vprintfmt+0x2f4>
                    flags.in_format = false;
    80201a1c:	f8040023          	sb	zero,-128(s0)
    80201a20:	4d00006f          	j	80201ef0 <vprintfmt+0x7c0>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    80201a24:	f5043783          	ld	a5,-176(s0)
    80201a28:	0007c783          	lbu	a5,0(a5)
    80201a2c:	00078713          	mv	a4,a5
    80201a30:	07000793          	li	a5,112
    80201a34:	00f70a63          	beq	a4,a5,80201a48 <vprintfmt+0x318>
    80201a38:	f8244783          	lbu	a5,-126(s0)
    80201a3c:	00078a63          	beqz	a5,80201a50 <vprintfmt+0x320>
    80201a40:	fe043783          	ld	a5,-32(s0)
    80201a44:	00078663          	beqz	a5,80201a50 <vprintfmt+0x320>
    80201a48:	00100793          	li	a5,1
    80201a4c:	0080006f          	j	80201a54 <vprintfmt+0x324>
    80201a50:	00000793          	li	a5,0
    80201a54:	faf40323          	sb	a5,-90(s0)
    80201a58:	fa644783          	lbu	a5,-90(s0)
    80201a5c:	0017f793          	andi	a5,a5,1
    80201a60:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80201a64:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80201a68:	f5043783          	ld	a5,-176(s0)
    80201a6c:	0007c783          	lbu	a5,0(a5)
    80201a70:	00078713          	mv	a4,a5
    80201a74:	05800793          	li	a5,88
    80201a78:	00f71863          	bne	a4,a5,80201a88 <vprintfmt+0x358>
    80201a7c:	00002797          	auipc	a5,0x2
    80201a80:	84c78793          	addi	a5,a5,-1972 # 802032c8 <upperxdigits.1>
    80201a84:	00c0006f          	j	80201a90 <vprintfmt+0x360>
    80201a88:	00002797          	auipc	a5,0x2
    80201a8c:	85878793          	addi	a5,a5,-1960 # 802032e0 <lowerxdigits.0>
    80201a90:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    80201a94:	fe043783          	ld	a5,-32(s0)
    80201a98:	00f7f793          	andi	a5,a5,15
    80201a9c:	f9843703          	ld	a4,-104(s0)
    80201aa0:	00f70733          	add	a4,a4,a5
    80201aa4:	fdc42783          	lw	a5,-36(s0)
    80201aa8:	0017869b          	addiw	a3,a5,1
    80201aac:	fcd42e23          	sw	a3,-36(s0)
    80201ab0:	00074703          	lbu	a4,0(a4)
    80201ab4:	ff078793          	addi	a5,a5,-16
    80201ab8:	008787b3          	add	a5,a5,s0
    80201abc:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    80201ac0:	fe043783          	ld	a5,-32(s0)
    80201ac4:	0047d793          	srli	a5,a5,0x4
    80201ac8:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80201acc:	fe043783          	ld	a5,-32(s0)
    80201ad0:	fc0792e3          	bnez	a5,80201a94 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201ad4:	f8c42783          	lw	a5,-116(s0)
    80201ad8:	00078713          	mv	a4,a5
    80201adc:	fff00793          	li	a5,-1
    80201ae0:	02f71663          	bne	a4,a5,80201b0c <vprintfmt+0x3dc>
    80201ae4:	f8344783          	lbu	a5,-125(s0)
    80201ae8:	02078263          	beqz	a5,80201b0c <vprintfmt+0x3dc>
                    flags.prec = flags.width - 2 * prefix;
    80201aec:	f8842703          	lw	a4,-120(s0)
    80201af0:	fa644783          	lbu	a5,-90(s0)
    80201af4:	0007879b          	sext.w	a5,a5
    80201af8:	0017979b          	slliw	a5,a5,0x1
    80201afc:	0007879b          	sext.w	a5,a5
    80201b00:	40f707bb          	subw	a5,a4,a5
    80201b04:	0007879b          	sext.w	a5,a5
    80201b08:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201b0c:	f8842703          	lw	a4,-120(s0)
    80201b10:	fa644783          	lbu	a5,-90(s0)
    80201b14:	0007879b          	sext.w	a5,a5
    80201b18:	0017979b          	slliw	a5,a5,0x1
    80201b1c:	0007879b          	sext.w	a5,a5
    80201b20:	40f707bb          	subw	a5,a4,a5
    80201b24:	0007871b          	sext.w	a4,a5
    80201b28:	fdc42783          	lw	a5,-36(s0)
    80201b2c:	f8f42a23          	sw	a5,-108(s0)
    80201b30:	f8c42783          	lw	a5,-116(s0)
    80201b34:	f8f42823          	sw	a5,-112(s0)
    80201b38:	f9442783          	lw	a5,-108(s0)
    80201b3c:	00078593          	mv	a1,a5
    80201b40:	f9042783          	lw	a5,-112(s0)
    80201b44:	00078613          	mv	a2,a5
    80201b48:	0006069b          	sext.w	a3,a2
    80201b4c:	0005879b          	sext.w	a5,a1
    80201b50:	00f6d463          	bge	a3,a5,80201b58 <vprintfmt+0x428>
    80201b54:	00058613          	mv	a2,a1
    80201b58:	0006079b          	sext.w	a5,a2
    80201b5c:	40f707bb          	subw	a5,a4,a5
    80201b60:	fcf42c23          	sw	a5,-40(s0)
    80201b64:	0280006f          	j	80201b8c <vprintfmt+0x45c>
                    putch(' ');
    80201b68:	f5843783          	ld	a5,-168(s0)
    80201b6c:	02000513          	li	a0,32
    80201b70:	000780e7          	jalr	a5
                    ++written;
    80201b74:	fec42783          	lw	a5,-20(s0)
    80201b78:	0017879b          	addiw	a5,a5,1
    80201b7c:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201b80:	fd842783          	lw	a5,-40(s0)
    80201b84:	fff7879b          	addiw	a5,a5,-1
    80201b88:	fcf42c23          	sw	a5,-40(s0)
    80201b8c:	fd842783          	lw	a5,-40(s0)
    80201b90:	0007879b          	sext.w	a5,a5
    80201b94:	fcf04ae3          	bgtz	a5,80201b68 <vprintfmt+0x438>
                }

                if (prefix) {
    80201b98:	fa644783          	lbu	a5,-90(s0)
    80201b9c:	0ff7f793          	zext.b	a5,a5
    80201ba0:	04078463          	beqz	a5,80201be8 <vprintfmt+0x4b8>
                    putch('0');
    80201ba4:	f5843783          	ld	a5,-168(s0)
    80201ba8:	03000513          	li	a0,48
    80201bac:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    80201bb0:	f5043783          	ld	a5,-176(s0)
    80201bb4:	0007c783          	lbu	a5,0(a5)
    80201bb8:	00078713          	mv	a4,a5
    80201bbc:	05800793          	li	a5,88
    80201bc0:	00f71663          	bne	a4,a5,80201bcc <vprintfmt+0x49c>
    80201bc4:	05800793          	li	a5,88
    80201bc8:	0080006f          	j	80201bd0 <vprintfmt+0x4a0>
    80201bcc:	07800793          	li	a5,120
    80201bd0:	f5843703          	ld	a4,-168(s0)
    80201bd4:	00078513          	mv	a0,a5
    80201bd8:	000700e7          	jalr	a4
                    written += 2;
    80201bdc:	fec42783          	lw	a5,-20(s0)
    80201be0:	0027879b          	addiw	a5,a5,2
    80201be4:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201be8:	fdc42783          	lw	a5,-36(s0)
    80201bec:	fcf42a23          	sw	a5,-44(s0)
    80201bf0:	0280006f          	j	80201c18 <vprintfmt+0x4e8>
                    putch('0');
    80201bf4:	f5843783          	ld	a5,-168(s0)
    80201bf8:	03000513          	li	a0,48
    80201bfc:	000780e7          	jalr	a5
                    ++written;
    80201c00:	fec42783          	lw	a5,-20(s0)
    80201c04:	0017879b          	addiw	a5,a5,1
    80201c08:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201c0c:	fd442783          	lw	a5,-44(s0)
    80201c10:	0017879b          	addiw	a5,a5,1
    80201c14:	fcf42a23          	sw	a5,-44(s0)
    80201c18:	f8c42703          	lw	a4,-116(s0)
    80201c1c:	fd442783          	lw	a5,-44(s0)
    80201c20:	0007879b          	sext.w	a5,a5
    80201c24:	fce7c8e3          	blt	a5,a4,80201bf4 <vprintfmt+0x4c4>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201c28:	fdc42783          	lw	a5,-36(s0)
    80201c2c:	fff7879b          	addiw	a5,a5,-1
    80201c30:	fcf42823          	sw	a5,-48(s0)
    80201c34:	03c0006f          	j	80201c70 <vprintfmt+0x540>
                    putch(buf[i]);
    80201c38:	fd042783          	lw	a5,-48(s0)
    80201c3c:	ff078793          	addi	a5,a5,-16
    80201c40:	008787b3          	add	a5,a5,s0
    80201c44:	f807c783          	lbu	a5,-128(a5)
    80201c48:	0007871b          	sext.w	a4,a5
    80201c4c:	f5843783          	ld	a5,-168(s0)
    80201c50:	00070513          	mv	a0,a4
    80201c54:	000780e7          	jalr	a5
                    ++written;
    80201c58:	fec42783          	lw	a5,-20(s0)
    80201c5c:	0017879b          	addiw	a5,a5,1
    80201c60:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201c64:	fd042783          	lw	a5,-48(s0)
    80201c68:	fff7879b          	addiw	a5,a5,-1
    80201c6c:	fcf42823          	sw	a5,-48(s0)
    80201c70:	fd042783          	lw	a5,-48(s0)
    80201c74:	0007879b          	sext.w	a5,a5
    80201c78:	fc07d0e3          	bgez	a5,80201c38 <vprintfmt+0x508>
                }

                flags.in_format = false;
    80201c7c:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201c80:	2700006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201c84:	f5043783          	ld	a5,-176(s0)
    80201c88:	0007c783          	lbu	a5,0(a5)
    80201c8c:	00078713          	mv	a4,a5
    80201c90:	06400793          	li	a5,100
    80201c94:	02f70663          	beq	a4,a5,80201cc0 <vprintfmt+0x590>
    80201c98:	f5043783          	ld	a5,-176(s0)
    80201c9c:	0007c783          	lbu	a5,0(a5)
    80201ca0:	00078713          	mv	a4,a5
    80201ca4:	06900793          	li	a5,105
    80201ca8:	00f70c63          	beq	a4,a5,80201cc0 <vprintfmt+0x590>
    80201cac:	f5043783          	ld	a5,-176(s0)
    80201cb0:	0007c783          	lbu	a5,0(a5)
    80201cb4:	00078713          	mv	a4,a5
    80201cb8:	07500793          	li	a5,117
    80201cbc:	08f71063          	bne	a4,a5,80201d3c <vprintfmt+0x60c>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    80201cc0:	f8144783          	lbu	a5,-127(s0)
    80201cc4:	00078c63          	beqz	a5,80201cdc <vprintfmt+0x5ac>
    80201cc8:	f4843783          	ld	a5,-184(s0)
    80201ccc:	00878713          	addi	a4,a5,8
    80201cd0:	f4e43423          	sd	a4,-184(s0)
    80201cd4:	0007b783          	ld	a5,0(a5)
    80201cd8:	0140006f          	j	80201cec <vprintfmt+0x5bc>
    80201cdc:	f4843783          	ld	a5,-184(s0)
    80201ce0:	00878713          	addi	a4,a5,8
    80201ce4:	f4e43423          	sd	a4,-184(s0)
    80201ce8:	0007a783          	lw	a5,0(a5)
    80201cec:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201cf0:	fa843583          	ld	a1,-88(s0)
    80201cf4:	f5043783          	ld	a5,-176(s0)
    80201cf8:	0007c783          	lbu	a5,0(a5)
    80201cfc:	0007871b          	sext.w	a4,a5
    80201d00:	07500793          	li	a5,117
    80201d04:	40f707b3          	sub	a5,a4,a5
    80201d08:	00f037b3          	snez	a5,a5
    80201d0c:	0ff7f793          	zext.b	a5,a5
    80201d10:	f8040713          	addi	a4,s0,-128
    80201d14:	00070693          	mv	a3,a4
    80201d18:	00078613          	mv	a2,a5
    80201d1c:	f5843503          	ld	a0,-168(s0)
    80201d20:	f08ff0ef          	jal	80201428 <print_dec_int>
    80201d24:	00050793          	mv	a5,a0
    80201d28:	fec42703          	lw	a4,-20(s0)
    80201d2c:	00f707bb          	addw	a5,a4,a5
    80201d30:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201d34:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201d38:	1b80006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == 'n') {
    80201d3c:	f5043783          	ld	a5,-176(s0)
    80201d40:	0007c783          	lbu	a5,0(a5)
    80201d44:	00078713          	mv	a4,a5
    80201d48:	06e00793          	li	a5,110
    80201d4c:	04f71c63          	bne	a4,a5,80201da4 <vprintfmt+0x674>
                if (flags.longflag) {
    80201d50:	f8144783          	lbu	a5,-127(s0)
    80201d54:	02078463          	beqz	a5,80201d7c <vprintfmt+0x64c>
                    long *n = va_arg(vl, long *);
    80201d58:	f4843783          	ld	a5,-184(s0)
    80201d5c:	00878713          	addi	a4,a5,8
    80201d60:	f4e43423          	sd	a4,-184(s0)
    80201d64:	0007b783          	ld	a5,0(a5)
    80201d68:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201d6c:	fec42703          	lw	a4,-20(s0)
    80201d70:	fb043783          	ld	a5,-80(s0)
    80201d74:	00e7b023          	sd	a4,0(a5)
    80201d78:	0240006f          	j	80201d9c <vprintfmt+0x66c>
                } else {
                    int *n = va_arg(vl, int *);
    80201d7c:	f4843783          	ld	a5,-184(s0)
    80201d80:	00878713          	addi	a4,a5,8
    80201d84:	f4e43423          	sd	a4,-184(s0)
    80201d88:	0007b783          	ld	a5,0(a5)
    80201d8c:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    80201d90:	fb843783          	ld	a5,-72(s0)
    80201d94:	fec42703          	lw	a4,-20(s0)
    80201d98:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    80201d9c:	f8040023          	sb	zero,-128(s0)
    80201da0:	1500006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == 's') {
    80201da4:	f5043783          	ld	a5,-176(s0)
    80201da8:	0007c783          	lbu	a5,0(a5)
    80201dac:	00078713          	mv	a4,a5
    80201db0:	07300793          	li	a5,115
    80201db4:	02f71e63          	bne	a4,a5,80201df0 <vprintfmt+0x6c0>
                const char *s = va_arg(vl, const char *);
    80201db8:	f4843783          	ld	a5,-184(s0)
    80201dbc:	00878713          	addi	a4,a5,8
    80201dc0:	f4e43423          	sd	a4,-184(s0)
    80201dc4:	0007b783          	ld	a5,0(a5)
    80201dc8:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    80201dcc:	fc043583          	ld	a1,-64(s0)
    80201dd0:	f5843503          	ld	a0,-168(s0)
    80201dd4:	dccff0ef          	jal	802013a0 <puts_wo_nl>
    80201dd8:	00050793          	mv	a5,a0
    80201ddc:	fec42703          	lw	a4,-20(s0)
    80201de0:	00f707bb          	addw	a5,a4,a5
    80201de4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201de8:	f8040023          	sb	zero,-128(s0)
    80201dec:	1040006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == 'c') {
    80201df0:	f5043783          	ld	a5,-176(s0)
    80201df4:	0007c783          	lbu	a5,0(a5)
    80201df8:	00078713          	mv	a4,a5
    80201dfc:	06300793          	li	a5,99
    80201e00:	02f71e63          	bne	a4,a5,80201e3c <vprintfmt+0x70c>
                int ch = va_arg(vl, int);
    80201e04:	f4843783          	ld	a5,-184(s0)
    80201e08:	00878713          	addi	a4,a5,8
    80201e0c:	f4e43423          	sd	a4,-184(s0)
    80201e10:	0007a783          	lw	a5,0(a5)
    80201e14:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201e18:	fcc42703          	lw	a4,-52(s0)
    80201e1c:	f5843783          	ld	a5,-168(s0)
    80201e20:	00070513          	mv	a0,a4
    80201e24:	000780e7          	jalr	a5
                ++written;
    80201e28:	fec42783          	lw	a5,-20(s0)
    80201e2c:	0017879b          	addiw	a5,a5,1
    80201e30:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201e34:	f8040023          	sb	zero,-128(s0)
    80201e38:	0b80006f          	j	80201ef0 <vprintfmt+0x7c0>
            } else if (*fmt == '%') {
    80201e3c:	f5043783          	ld	a5,-176(s0)
    80201e40:	0007c783          	lbu	a5,0(a5)
    80201e44:	00078713          	mv	a4,a5
    80201e48:	02500793          	li	a5,37
    80201e4c:	02f71263          	bne	a4,a5,80201e70 <vprintfmt+0x740>
                putch('%');
    80201e50:	f5843783          	ld	a5,-168(s0)
    80201e54:	02500513          	li	a0,37
    80201e58:	000780e7          	jalr	a5
                ++written;
    80201e5c:	fec42783          	lw	a5,-20(s0)
    80201e60:	0017879b          	addiw	a5,a5,1
    80201e64:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201e68:	f8040023          	sb	zero,-128(s0)
    80201e6c:	0840006f          	j	80201ef0 <vprintfmt+0x7c0>
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
                flags.in_format = false;
    80201e94:	f8040023          	sb	zero,-128(s0)
    80201e98:	0580006f          	j	80201ef0 <vprintfmt+0x7c0>
            }
        } else if (*fmt == '%') {
    80201e9c:	f5043783          	ld	a5,-176(s0)
    80201ea0:	0007c783          	lbu	a5,0(a5)
    80201ea4:	00078713          	mv	a4,a5
    80201ea8:	02500793          	li	a5,37
    80201eac:	02f71063          	bne	a4,a5,80201ecc <vprintfmt+0x79c>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    80201eb0:	f8043023          	sd	zero,-128(s0)
    80201eb4:	f8043423          	sd	zero,-120(s0)
    80201eb8:	00100793          	li	a5,1
    80201ebc:	f8f40023          	sb	a5,-128(s0)
    80201ec0:	fff00793          	li	a5,-1
    80201ec4:	f8f42623          	sw	a5,-116(s0)
    80201ec8:	0280006f          	j	80201ef0 <vprintfmt+0x7c0>
        } else {
            putch(*fmt);
    80201ecc:	f5043783          	ld	a5,-176(s0)
    80201ed0:	0007c783          	lbu	a5,0(a5)
    80201ed4:	0007871b          	sext.w	a4,a5
    80201ed8:	f5843783          	ld	a5,-168(s0)
    80201edc:	00070513          	mv	a0,a4
    80201ee0:	000780e7          	jalr	a5
            ++written;
    80201ee4:	fec42783          	lw	a5,-20(s0)
    80201ee8:	0017879b          	addiw	a5,a5,1
    80201eec:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201ef0:	f5043783          	ld	a5,-176(s0)
    80201ef4:	00178793          	addi	a5,a5,1
    80201ef8:	f4f43823          	sd	a5,-176(s0)
    80201efc:	f5043783          	ld	a5,-176(s0)
    80201f00:	0007c783          	lbu	a5,0(a5)
    80201f04:	84079ce3          	bnez	a5,8020175c <vprintfmt+0x2c>
        }
    }

    return written;
    80201f08:	fec42783          	lw	a5,-20(s0)
}
    80201f0c:	00078513          	mv	a0,a5
    80201f10:	0b813083          	ld	ra,184(sp)
    80201f14:	0b013403          	ld	s0,176(sp)
    80201f18:	0c010113          	addi	sp,sp,192
    80201f1c:	00008067          	ret

0000000080201f20 <printk>:

int printk(const char* s, ...) {
    80201f20:	f9010113          	addi	sp,sp,-112
    80201f24:	02113423          	sd	ra,40(sp)
    80201f28:	02813023          	sd	s0,32(sp)
    80201f2c:	03010413          	addi	s0,sp,48
    80201f30:	fca43c23          	sd	a0,-40(s0)
    80201f34:	00b43423          	sd	a1,8(s0)
    80201f38:	00c43823          	sd	a2,16(s0)
    80201f3c:	00d43c23          	sd	a3,24(s0)
    80201f40:	02e43023          	sd	a4,32(s0)
    80201f44:	02f43423          	sd	a5,40(s0)
    80201f48:	03043823          	sd	a6,48(s0)
    80201f4c:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201f50:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201f54:	04040793          	addi	a5,s0,64
    80201f58:	fcf43823          	sd	a5,-48(s0)
    80201f5c:	fd043783          	ld	a5,-48(s0)
    80201f60:	fc878793          	addi	a5,a5,-56
    80201f64:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201f68:	fe043783          	ld	a5,-32(s0)
    80201f6c:	00078613          	mv	a2,a5
    80201f70:	fd843583          	ld	a1,-40(s0)
    80201f74:	fffff517          	auipc	a0,0xfffff
    80201f78:	11850513          	addi	a0,a0,280 # 8020108c <putc>
    80201f7c:	fb4ff0ef          	jal	80201730 <vprintfmt>
    80201f80:	00050793          	mv	a5,a0
    80201f84:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    80201f88:	fec42783          	lw	a5,-20(s0)
}
    80201f8c:	00078513          	mv	a0,a5
    80201f90:	02813083          	ld	ra,40(sp)
    80201f94:	02013403          	ld	s0,32(sp)
    80201f98:	07010113          	addi	sp,sp,112
    80201f9c:	00008067          	ret

0000000080201fa0 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
    80201fa0:	fe010113          	addi	sp,sp,-32
    80201fa4:	00813c23          	sd	s0,24(sp)
    80201fa8:	02010413          	addi	s0,sp,32
    80201fac:	00050793          	mv	a5,a0
    80201fb0:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
    80201fb4:	fec42783          	lw	a5,-20(s0)
    80201fb8:	fff7879b          	addiw	a5,a5,-1
    80201fbc:	0007879b          	sext.w	a5,a5
    80201fc0:	02079713          	slli	a4,a5,0x20
    80201fc4:	02075713          	srli	a4,a4,0x20
    80201fc8:	00004797          	auipc	a5,0x4
    80201fcc:	0a878793          	addi	a5,a5,168 # 80206070 <seed>
    80201fd0:	00e7b023          	sd	a4,0(a5)
}
    80201fd4:	00000013          	nop
    80201fd8:	01813403          	ld	s0,24(sp)
    80201fdc:	02010113          	addi	sp,sp,32
    80201fe0:	00008067          	ret

0000000080201fe4 <rand>:

int rand(void) {
    80201fe4:	ff010113          	addi	sp,sp,-16
    80201fe8:	00813423          	sd	s0,8(sp)
    80201fec:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
    80201ff0:	00004797          	auipc	a5,0x4
    80201ff4:	08078793          	addi	a5,a5,128 # 80206070 <seed>
    80201ff8:	0007b703          	ld	a4,0(a5)
    80201ffc:	00001797          	auipc	a5,0x1
    80202000:	2fc78793          	addi	a5,a5,764 # 802032f8 <lowerxdigits.0+0x18>
    80202004:	0007b783          	ld	a5,0(a5)
    80202008:	02f707b3          	mul	a5,a4,a5
    8020200c:	00178713          	addi	a4,a5,1
    80202010:	00004797          	auipc	a5,0x4
    80202014:	06078793          	addi	a5,a5,96 # 80206070 <seed>
    80202018:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
    8020201c:	00004797          	auipc	a5,0x4
    80202020:	05478793          	addi	a5,a5,84 # 80206070 <seed>
    80202024:	0007b783          	ld	a5,0(a5)
    80202028:	0217d793          	srli	a5,a5,0x21
    8020202c:	0007879b          	sext.w	a5,a5
}
    80202030:	00078513          	mv	a0,a5
    80202034:	00813403          	ld	s0,8(sp)
    80202038:	01010113          	addi	sp,sp,16
    8020203c:	00008067          	ret

0000000080202040 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
    80202040:	fc010113          	addi	sp,sp,-64
    80202044:	02813c23          	sd	s0,56(sp)
    80202048:	04010413          	addi	s0,sp,64
    8020204c:	fca43c23          	sd	a0,-40(s0)
    80202050:	00058793          	mv	a5,a1
    80202054:	fcc43423          	sd	a2,-56(s0)
    80202058:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
    8020205c:	fd843783          	ld	a5,-40(s0)
    80202060:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
    80202064:	fe043423          	sd	zero,-24(s0)
    80202068:	0280006f          	j	80202090 <memset+0x50>
        s[i] = c;
    8020206c:	fe043703          	ld	a4,-32(s0)
    80202070:	fe843783          	ld	a5,-24(s0)
    80202074:	00f707b3          	add	a5,a4,a5
    80202078:	fd442703          	lw	a4,-44(s0)
    8020207c:	0ff77713          	zext.b	a4,a4
    80202080:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
    80202084:	fe843783          	ld	a5,-24(s0)
    80202088:	00178793          	addi	a5,a5,1
    8020208c:	fef43423          	sd	a5,-24(s0)
    80202090:	fe843703          	ld	a4,-24(s0)
    80202094:	fc843783          	ld	a5,-56(s0)
    80202098:	fcf76ae3          	bltu	a4,a5,8020206c <memset+0x2c>
    }
    return dest;
    8020209c:	fd843783          	ld	a5,-40(s0)
}
    802020a0:	00078513          	mv	a0,a5
    802020a4:	03813403          	ld	s0,56(sp)
    802020a8:	04010113          	addi	sp,sp,64
    802020ac:	00008067          	ret
