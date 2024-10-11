
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer
    80200000:	00003117          	auipc	sp,0x3
    80200004:	01813103          	ld	sp,24(sp) # 80203018 <_GLOBAL_OFFSET_TABLE_+0x10>

    call mm_init    # ??? Why should init here
    80200008:	320000ef          	jal	80200328 <mm_init>

    la t0, _traps
    8020000c:	00003297          	auipc	t0,0x3
    80200010:	0142b283          	ld	t0,20(t0) # 80203020 <_GLOBAL_OFFSET_TABLE_+0x18>
    csrw stvec, t0  # set stvec = _traps
    80200014:	10529073          	csrw	stvec,t0

    li t0, 32
    80200018:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
    8020001c:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
    80200020:	168000ef          	jal	80200188 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
    80200024:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
    80200028:	1002a073          	csrs	sstatus,t0

    

    call start_kernel
    8020002c:	089000ef          	jal	802008b4 <start_kernel>

0000000080200030 <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
    80200030:	ef810113          	addi	sp,sp,-264
    sd x0, 0(sp)
    80200034:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
    80200038:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
    8020003c:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
    80200040:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
    80200044:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
    80200048:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
    8020004c:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
    80200050:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
    80200054:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
    80200058:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
    8020005c:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
    80200060:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
    80200064:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
    80200068:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
    8020006c:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
    80200070:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
    80200074:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
    80200078:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
    8020007c:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
    80200080:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
    80200084:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
    80200088:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
    8020008c:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
    80200090:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
    80200094:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
    80200098:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
    8020009c:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
    802000a0:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
    802000a4:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
    802000a8:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
    802000ac:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
    802000b0:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
    802000b4:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
    802000b8:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
    802000bc:	14202573          	csrr	a0,scause
    csrr a1, sepc
    802000c0:	141025f3          	csrr	a1,sepc
    call trap_handler
    802000c4:	780000ef          	jal	80200844 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
    802000c8:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
    802000cc:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
    802000d0:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
    802000d4:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
    802000d8:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
    802000dc:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
    802000e0:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
    802000e4:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
    802000e8:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
    802000ec:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
    802000f0:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
    802000f4:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
    802000f8:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
    802000fc:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
    80200100:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
    80200104:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
    80200108:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
    8020010c:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
    80200110:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
    80200114:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
    80200118:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
    8020011c:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
    80200120:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
    80200124:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
    80200128:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
    8020012c:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
    80200130:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
    80200134:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
    80200138:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
    8020013c:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
    80200140:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
    80200144:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
    80200148:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
    8020014c:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
    80200150:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
    80200154:	10200073          	sret

0000000080200158 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
    80200158:	fe010113          	addi	sp,sp,-32
    8020015c:	00113c23          	sd	ra,24(sp)
    80200160:	00813823          	sd	s0,16(sp)
    80200164:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
    80200168:	c01027f3          	rdtime	a5
    8020016c:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
    80200170:	fe843783          	ld	a5,-24(s0)
}
    80200174:	00078513          	mv	a0,a5
    80200178:	01813083          	ld	ra,24(sp)
    8020017c:	01013403          	ld	s0,16(sp)
    80200180:	02010113          	addi	sp,sp,32
    80200184:	00008067          	ret

0000000080200188 <clock_set_next_event>:

void clock_set_next_event() {
    80200188:	fe010113          	addi	sp,sp,-32
    8020018c:	00113c23          	sd	ra,24(sp)
    80200190:	00813823          	sd	s0,16(sp)
    80200194:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
    80200198:	fc1ff0ef          	jal	80200158 <get_cycles>
    8020019c:	00050713          	mv	a4,a0
    802001a0:	00003797          	auipc	a5,0x3
    802001a4:	e6078793          	addi	a5,a5,-416 # 80203000 <TIMECLOCK>
    802001a8:	0007b783          	ld	a5,0(a5)
    802001ac:	00f707b3          	add	a5,a4,a5
    802001b0:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    802001b4:	fe843503          	ld	a0,-24(s0)
    802001b8:	4d8000ef          	jal	80200690 <sbi_set_timer>
    802001bc:	00000013          	nop
    802001c0:	01813083          	ld	ra,24(sp)
    802001c4:	01013403          	ld	s0,16(sp)
    802001c8:	02010113          	addi	sp,sp,32
    802001cc:	00008067          	ret

00000000802001d0 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
    802001d0:	fe010113          	addi	sp,sp,-32
    802001d4:	00113c23          	sd	ra,24(sp)
    802001d8:	00813823          	sd	s0,16(sp)
    802001dc:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
    802001e0:	00005797          	auipc	a5,0x5
    802001e4:	e2078793          	addi	a5,a5,-480 # 80205000 <kmem>
    802001e8:	0007b783          	ld	a5,0(a5)
    802001ec:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
    802001f0:	fe843783          	ld	a5,-24(s0)
    802001f4:	0007b703          	ld	a4,0(a5)
    802001f8:	00005797          	auipc	a5,0x5
    802001fc:	e0878793          	addi	a5,a5,-504 # 80205000 <kmem>
    80200200:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
    80200204:	00001637          	lui	a2,0x1
    80200208:	00000593          	li	a1,0
    8020020c:	fe843503          	ld	a0,-24(s0)
    80200210:	76c010ef          	jal	8020197c <memset>
    return (void *)r;
    80200214:	fe843783          	ld	a5,-24(s0)
}
    80200218:	00078513          	mv	a0,a5
    8020021c:	01813083          	ld	ra,24(sp)
    80200220:	01013403          	ld	s0,16(sp)
    80200224:	02010113          	addi	sp,sp,32
    80200228:	00008067          	ret

000000008020022c <kfree>:

void kfree(void *addr) {
    8020022c:	fd010113          	addi	sp,sp,-48
    80200230:	02113423          	sd	ra,40(sp)
    80200234:	02813023          	sd	s0,32(sp)
    80200238:	03010413          	addi	s0,sp,48
    8020023c:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
    80200240:	fd843783          	ld	a5,-40(s0)
    80200244:	00078693          	mv	a3,a5
    80200248:	fd840793          	addi	a5,s0,-40
    8020024c:	fffff737          	lui	a4,0xfffff
    80200250:	00e6f733          	and	a4,a3,a4
    80200254:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
    80200258:	fd843783          	ld	a5,-40(s0)
    8020025c:	00001637          	lui	a2,0x1
    80200260:	00000593          	li	a1,0
    80200264:	00078513          	mv	a0,a5
    80200268:	714010ef          	jal	8020197c <memset>

    r = (struct run *)addr;
    8020026c:	fd843783          	ld	a5,-40(s0)
    80200270:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
    80200274:	00005797          	auipc	a5,0x5
    80200278:	d8c78793          	addi	a5,a5,-628 # 80205000 <kmem>
    8020027c:	0007b703          	ld	a4,0(a5)
    80200280:	fe843783          	ld	a5,-24(s0)
    80200284:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
    80200288:	00005797          	auipc	a5,0x5
    8020028c:	d7878793          	addi	a5,a5,-648 # 80205000 <kmem>
    80200290:	fe843703          	ld	a4,-24(s0)
    80200294:	00e7b023          	sd	a4,0(a5)

    return;
    80200298:	00000013          	nop
}
    8020029c:	02813083          	ld	ra,40(sp)
    802002a0:	02013403          	ld	s0,32(sp)
    802002a4:	03010113          	addi	sp,sp,48
    802002a8:	00008067          	ret

00000000802002ac <kfreerange>:

void kfreerange(char *start, char *end) {
    802002ac:	fd010113          	addi	sp,sp,-48
    802002b0:	02113423          	sd	ra,40(sp)
    802002b4:	02813023          	sd	s0,32(sp)
    802002b8:	03010413          	addi	s0,sp,48
    802002bc:	fca43c23          	sd	a0,-40(s0)
    802002c0:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
    802002c4:	fd843703          	ld	a4,-40(s0)
    802002c8:	000017b7          	lui	a5,0x1
    802002cc:	fff78793          	addi	a5,a5,-1 # fff <_skernel-0x801ff001>
    802002d0:	00f70733          	add	a4,a4,a5
    802002d4:	fffff7b7          	lui	a5,0xfffff
    802002d8:	00f777b3          	and	a5,a4,a5
    802002dc:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    802002e0:	01c0006f          	j	802002fc <kfreerange+0x50>
        kfree((void *)addr);
    802002e4:	fe843503          	ld	a0,-24(s0)
    802002e8:	f45ff0ef          	jal	8020022c <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    802002ec:	fe843703          	ld	a4,-24(s0)
    802002f0:	000017b7          	lui	a5,0x1
    802002f4:	00f707b3          	add	a5,a4,a5
    802002f8:	fef43423          	sd	a5,-24(s0)
    802002fc:	fe843703          	ld	a4,-24(s0)
    80200300:	000017b7          	lui	a5,0x1
    80200304:	00f70733          	add	a4,a4,a5
    80200308:	fd043783          	ld	a5,-48(s0)
    8020030c:	fce7fce3          	bgeu	a5,a4,802002e4 <kfreerange+0x38>
    }
}
    80200310:	00000013          	nop
    80200314:	00000013          	nop
    80200318:	02813083          	ld	ra,40(sp)
    8020031c:	02013403          	ld	s0,32(sp)
    80200320:	03010113          	addi	sp,sp,48
    80200324:	00008067          	ret

0000000080200328 <mm_init>:

void mm_init(void) {
    80200328:	ff010113          	addi	sp,sp,-16
    8020032c:	00113423          	sd	ra,8(sp)
    80200330:	00813023          	sd	s0,0(sp)
    80200334:	01010413          	addi	s0,sp,16
    kfreerange(_ekernel, (char *)PHY_END);
    80200338:	01100793          	li	a5,17
    8020033c:	01b79593          	slli	a1,a5,0x1b
    80200340:	00003517          	auipc	a0,0x3
    80200344:	cd053503          	ld	a0,-816(a0) # 80203010 <_GLOBAL_OFFSET_TABLE_+0x8>
    80200348:	f65ff0ef          	jal	802002ac <kfreerange>
    printk("...mm_init done!\n");
    8020034c:	00002517          	auipc	a0,0x2
    80200350:	cb450513          	addi	a0,a0,-844 # 80202000 <_srodata>
    80200354:	4f8010ef          	jal	8020184c <printk>
}
    80200358:	00000013          	nop
    8020035c:	00813083          	ld	ra,8(sp)
    80200360:	00013403          	ld	s0,0(sp)
    80200364:	01010113          	addi	sp,sp,16
    80200368:	00008067          	ret

000000008020036c <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
    8020036c:	ff010113          	addi	sp,sp,-16
    80200370:	00113423          	sd	ra,8(sp)
    80200374:	00813023          	sd	s0,0(sp)
    80200378:	01010413          	addi	s0,sp,16
    srand(2024);
    8020037c:	7e800513          	li	a0,2024
    80200380:	54c010ef          	jal	802018cc <srand>
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    printk("...task_init done!\n");
    80200384:	00002517          	auipc	a0,0x2
    80200388:	c9450513          	addi	a0,a0,-876 # 80202018 <_srodata+0x18>
    8020038c:	4c0010ef          	jal	8020184c <printk>
}
    80200390:	00000013          	nop
    80200394:	00813083          	ld	ra,8(sp)
    80200398:	00013403          	ld	s0,0(sp)
    8020039c:	01010113          	addi	sp,sp,16
    802003a0:	00008067          	ret

00000000802003a4 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    802003a4:	fd010113          	addi	sp,sp,-48
    802003a8:	02113423          	sd	ra,40(sp)
    802003ac:	02813023          	sd	s0,32(sp)
    802003b0:	03010413          	addi	s0,sp,48
    uint64_t MOD = 1000000007;
    802003b4:	3b9ad7b7          	lui	a5,0x3b9ad
    802003b8:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <_skernel-0x448535f9>
    802003bc:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
    802003c0:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
    802003c4:	fff00793          	li	a5,-1
    802003c8:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    802003cc:	fe442783          	lw	a5,-28(s0)
    802003d0:	0007871b          	sext.w	a4,a5
    802003d4:	fff00793          	li	a5,-1
    802003d8:	00f70e63          	beq	a4,a5,802003f4 <dummy+0x50>
    802003dc:	00005797          	auipc	a5,0x5
    802003e0:	c3478793          	addi	a5,a5,-972 # 80205010 <current>
    802003e4:	0007b783          	ld	a5,0(a5)
    802003e8:	0087b703          	ld	a4,8(a5)
    802003ec:	fe442783          	lw	a5,-28(s0)
    802003f0:	fcf70ee3          	beq	a4,a5,802003cc <dummy+0x28>
    802003f4:	00005797          	auipc	a5,0x5
    802003f8:	c1c78793          	addi	a5,a5,-996 # 80205010 <current>
    802003fc:	0007b783          	ld	a5,0(a5)
    80200400:	0087b783          	ld	a5,8(a5)
    80200404:	fc0784e3          	beqz	a5,802003cc <dummy+0x28>
            if (current->counter == 1) {
    80200408:	00005797          	auipc	a5,0x5
    8020040c:	c0878793          	addi	a5,a5,-1016 # 80205010 <current>
    80200410:	0007b783          	ld	a5,0(a5)
    80200414:	0087b703          	ld	a4,8(a5)
    80200418:	00100793          	li	a5,1
    8020041c:	00f71e63          	bne	a4,a5,80200438 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
    80200420:	00005797          	auipc	a5,0x5
    80200424:	bf078793          	addi	a5,a5,-1040 # 80205010 <current>
    80200428:	0007b783          	ld	a5,0(a5)
    8020042c:	0087b703          	ld	a4,8(a5)
    80200430:	fff70713          	addi	a4,a4,-1 # ffffffffffffefff <_ebss+0xffffffff7fdf9edf>
    80200434:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
    80200438:	00005797          	auipc	a5,0x5
    8020043c:	bd878793          	addi	a5,a5,-1064 # 80205010 <current>
    80200440:	0007b783          	ld	a5,0(a5)
    80200444:	0087b783          	ld	a5,8(a5)
    80200448:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
    8020044c:	fe843783          	ld	a5,-24(s0)
    80200450:	00178713          	addi	a4,a5,1
    80200454:	fd843783          	ld	a5,-40(s0)
    80200458:	02f777b3          	remu	a5,a4,a5
    8020045c:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
    80200460:	00005797          	auipc	a5,0x5
    80200464:	bb078793          	addi	a5,a5,-1104 # 80205010 <current>
    80200468:	0007b783          	ld	a5,0(a5)
    8020046c:	0187b783          	ld	a5,24(a5)
    80200470:	fe843603          	ld	a2,-24(s0)
    80200474:	00078593          	mv	a1,a5
    80200478:	00002517          	auipc	a0,0x2
    8020047c:	bb850513          	addi	a0,a0,-1096 # 80202030 <_srodata+0x30>
    80200480:	3cc010ef          	jal	8020184c <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200484:	f49ff06f          	j	802003cc <dummy+0x28>

0000000080200488 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    80200488:	f7010113          	addi	sp,sp,-144
    8020048c:	08113423          	sd	ra,136(sp)
    80200490:	08813023          	sd	s0,128(sp)
    80200494:	06913c23          	sd	s1,120(sp)
    80200498:	07213823          	sd	s2,112(sp)
    8020049c:	07313423          	sd	s3,104(sp)
    802004a0:	09010413          	addi	s0,sp,144
    802004a4:	faa43423          	sd	a0,-88(s0)
    802004a8:	fab43023          	sd	a1,-96(s0)
    802004ac:	f8c43c23          	sd	a2,-104(s0)
    802004b0:	f8d43823          	sd	a3,-112(s0)
    802004b4:	f8e43423          	sd	a4,-120(s0)
    802004b8:	f8f43023          	sd	a5,-128(s0)
    802004bc:	f7043c23          	sd	a6,-136(s0)
    802004c0:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    802004c4:	fa843e03          	ld	t3,-88(s0)
    802004c8:	fa043e83          	ld	t4,-96(s0)
    802004cc:	f9843f03          	ld	t5,-104(s0)
    802004d0:	f9043f83          	ld	t6,-112(s0)
    802004d4:	f8843283          	ld	t0,-120(s0)
    802004d8:	f8043483          	ld	s1,-128(s0)
    802004dc:	f7843903          	ld	s2,-136(s0)
    802004e0:	f7043983          	ld	s3,-144(s0)
    802004e4:	000e0893          	mv	a7,t3
    802004e8:	000e8813          	mv	a6,t4
    802004ec:	000f0513          	mv	a0,t5
    802004f0:	000f8593          	mv	a1,t6
    802004f4:	00028613          	mv	a2,t0
    802004f8:	00048693          	mv	a3,s1
    802004fc:	00090713          	mv	a4,s2
    80200500:	00098793          	mv	a5,s3
    80200504:	00000073          	ecall
    80200508:	00050e93          	mv	t4,a0
    8020050c:	00058e13          	mv	t3,a1
    80200510:	fbd43823          	sd	t4,-80(s0)
    80200514:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    80200518:	fb043783          	ld	a5,-80(s0)
    8020051c:	fcf43023          	sd	a5,-64(s0)
    80200520:	fb843783          	ld	a5,-72(s0)
    80200524:	fcf43423          	sd	a5,-56(s0)
    80200528:	fc043703          	ld	a4,-64(s0)
    8020052c:	fc843783          	ld	a5,-56(s0)
    80200530:	00070313          	mv	t1,a4
    80200534:	00078393          	mv	t2,a5
    80200538:	00030713          	mv	a4,t1
    8020053c:	00038793          	mv	a5,t2
}
    80200540:	00070513          	mv	a0,a4
    80200544:	00078593          	mv	a1,a5
    80200548:	08813083          	ld	ra,136(sp)
    8020054c:	08013403          	ld	s0,128(sp)
    80200550:	07813483          	ld	s1,120(sp)
    80200554:	07013903          	ld	s2,112(sp)
    80200558:	06813983          	ld	s3,104(sp)
    8020055c:	09010113          	addi	sp,sp,144
    80200560:	00008067          	ret

0000000080200564 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    80200564:	fc010113          	addi	sp,sp,-64
    80200568:	02113c23          	sd	ra,56(sp)
    8020056c:	02813823          	sd	s0,48(sp)
    80200570:	03213423          	sd	s2,40(sp)
    80200574:	03313023          	sd	s3,32(sp)
    80200578:	04010413          	addi	s0,sp,64
    8020057c:	00050793          	mv	a5,a0
    80200580:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200584:	fcf44603          	lbu	a2,-49(s0)
    80200588:	00000893          	li	a7,0
    8020058c:	00000813          	li	a6,0
    80200590:	00000793          	li	a5,0
    80200594:	00000713          	li	a4,0
    80200598:	00000693          	li	a3,0
    8020059c:	00200593          	li	a1,2
    802005a0:	44424537          	lui	a0,0x44424
    802005a4:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802005a8:	ee1ff0ef          	jal	80200488 <sbi_ecall>
    802005ac:	00050713          	mv	a4,a0
    802005b0:	00058793          	mv	a5,a1
    802005b4:	fce43823          	sd	a4,-48(s0)
    802005b8:	fcf43c23          	sd	a5,-40(s0)
    802005bc:	fd043703          	ld	a4,-48(s0)
    802005c0:	fd843783          	ld	a5,-40(s0)
    802005c4:	00070913          	mv	s2,a4
    802005c8:	00078993          	mv	s3,a5
    802005cc:	00090713          	mv	a4,s2
    802005d0:	00098793          	mv	a5,s3
}
    802005d4:	00070513          	mv	a0,a4
    802005d8:	00078593          	mv	a1,a5
    802005dc:	03813083          	ld	ra,56(sp)
    802005e0:	03013403          	ld	s0,48(sp)
    802005e4:	02813903          	ld	s2,40(sp)
    802005e8:	02013983          	ld	s3,32(sp)
    802005ec:	04010113          	addi	sp,sp,64
    802005f0:	00008067          	ret

00000000802005f4 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    802005f4:	fc010113          	addi	sp,sp,-64
    802005f8:	02113c23          	sd	ra,56(sp)
    802005fc:	02813823          	sd	s0,48(sp)
    80200600:	03213423          	sd	s2,40(sp)
    80200604:	03313023          	sd	s3,32(sp)
    80200608:	04010413          	addi	s0,sp,64
    8020060c:	00050793          	mv	a5,a0
    80200610:	00058713          	mv	a4,a1
    80200614:	fcf42623          	sw	a5,-52(s0)
    80200618:	00070793          	mv	a5,a4
    8020061c:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    80200620:	fcc46603          	lwu	a2,-52(s0)
    80200624:	fc846683          	lwu	a3,-56(s0)
    80200628:	00000893          	li	a7,0
    8020062c:	00000813          	li	a6,0
    80200630:	00000793          	li	a5,0
    80200634:	00000713          	li	a4,0
    80200638:	00000593          	li	a1,0
    8020063c:	53525537          	lui	a0,0x53525
    80200640:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200644:	e45ff0ef          	jal	80200488 <sbi_ecall>
    80200648:	00050713          	mv	a4,a0
    8020064c:	00058793          	mv	a5,a1
    80200650:	fce43823          	sd	a4,-48(s0)
    80200654:	fcf43c23          	sd	a5,-40(s0)
    80200658:	fd043703          	ld	a4,-48(s0)
    8020065c:	fd843783          	ld	a5,-40(s0)
    80200660:	00070913          	mv	s2,a4
    80200664:	00078993          	mv	s3,a5
    80200668:	00090713          	mv	a4,s2
    8020066c:	00098793          	mv	a5,s3
}
    80200670:	00070513          	mv	a0,a4
    80200674:	00078593          	mv	a1,a5
    80200678:	03813083          	ld	ra,56(sp)
    8020067c:	03013403          	ld	s0,48(sp)
    80200680:	02813903          	ld	s2,40(sp)
    80200684:	02013983          	ld	s3,32(sp)
    80200688:	04010113          	addi	sp,sp,64
    8020068c:	00008067          	ret

0000000080200690 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    80200690:	fc010113          	addi	sp,sp,-64
    80200694:	02113c23          	sd	ra,56(sp)
    80200698:	02813823          	sd	s0,48(sp)
    8020069c:	03213423          	sd	s2,40(sp)
    802006a0:	03313023          	sd	s3,32(sp)
    802006a4:	04010413          	addi	s0,sp,64
    802006a8:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    802006ac:	00000893          	li	a7,0
    802006b0:	00000813          	li	a6,0
    802006b4:	00000793          	li	a5,0
    802006b8:	00000713          	li	a4,0
    802006bc:	00000693          	li	a3,0
    802006c0:	fc843603          	ld	a2,-56(s0)
    802006c4:	00000593          	li	a1,0
    802006c8:	54495537          	lui	a0,0x54495
    802006cc:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    802006d0:	db9ff0ef          	jal	80200488 <sbi_ecall>
    802006d4:	00050713          	mv	a4,a0
    802006d8:	00058793          	mv	a5,a1
    802006dc:	fce43823          	sd	a4,-48(s0)
    802006e0:	fcf43c23          	sd	a5,-40(s0)
    802006e4:	fd043703          	ld	a4,-48(s0)
    802006e8:	fd843783          	ld	a5,-40(s0)
    802006ec:	00070913          	mv	s2,a4
    802006f0:	00078993          	mv	s3,a5
    802006f4:	00090713          	mv	a4,s2
    802006f8:	00098793          	mv	a5,s3
}
    802006fc:	00070513          	mv	a0,a4
    80200700:	00078593          	mv	a1,a5
    80200704:	03813083          	ld	ra,56(sp)
    80200708:	03013403          	ld	s0,48(sp)
    8020070c:	02813903          	ld	s2,40(sp)
    80200710:	02013983          	ld	s3,32(sp)
    80200714:	04010113          	addi	sp,sp,64
    80200718:	00008067          	ret

000000008020071c <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    8020071c:	fb010113          	addi	sp,sp,-80
    80200720:	04113423          	sd	ra,72(sp)
    80200724:	04813023          	sd	s0,64(sp)
    80200728:	03213c23          	sd	s2,56(sp)
    8020072c:	03313823          	sd	s3,48(sp)
    80200730:	05010413          	addi	s0,sp,80
    80200734:	fca43423          	sd	a0,-56(s0)
    80200738:	fcb43023          	sd	a1,-64(s0)
    8020073c:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200740:	00000893          	li	a7,0
    80200744:	00000813          	li	a6,0
    80200748:	00000793          	li	a5,0
    8020074c:	fb843703          	ld	a4,-72(s0)
    80200750:	fc043683          	ld	a3,-64(s0)
    80200754:	fc843603          	ld	a2,-56(s0)
    80200758:	00100593          	li	a1,1
    8020075c:	44424537          	lui	a0,0x44424
    80200760:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200764:	d25ff0ef          	jal	80200488 <sbi_ecall>
    80200768:	00050713          	mv	a4,a0
    8020076c:	00058793          	mv	a5,a1
    80200770:	fce43823          	sd	a4,-48(s0)
    80200774:	fcf43c23          	sd	a5,-40(s0)
    80200778:	fd043703          	ld	a4,-48(s0)
    8020077c:	fd843783          	ld	a5,-40(s0)
    80200780:	00070913          	mv	s2,a4
    80200784:	00078993          	mv	s3,a5
    80200788:	00090713          	mv	a4,s2
    8020078c:	00098793          	mv	a5,s3
}
    80200790:	00070513          	mv	a0,a4
    80200794:	00078593          	mv	a1,a5
    80200798:	04813083          	ld	ra,72(sp)
    8020079c:	04013403          	ld	s0,64(sp)
    802007a0:	03813903          	ld	s2,56(sp)
    802007a4:	03013983          	ld	s3,48(sp)
    802007a8:	05010113          	addi	sp,sp,80
    802007ac:	00008067          	ret

00000000802007b0 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    802007b0:	fb010113          	addi	sp,sp,-80
    802007b4:	04113423          	sd	ra,72(sp)
    802007b8:	04813023          	sd	s0,64(sp)
    802007bc:	03213c23          	sd	s2,56(sp)
    802007c0:	03313823          	sd	s3,48(sp)
    802007c4:	05010413          	addi	s0,sp,80
    802007c8:	fca43423          	sd	a0,-56(s0)
    802007cc:	fcb43023          	sd	a1,-64(s0)
    802007d0:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    802007d4:	00000893          	li	a7,0
    802007d8:	00000813          	li	a6,0
    802007dc:	00000793          	li	a5,0
    802007e0:	fb843703          	ld	a4,-72(s0)
    802007e4:	fc043683          	ld	a3,-64(s0)
    802007e8:	fc843603          	ld	a2,-56(s0)
    802007ec:	00000593          	li	a1,0
    802007f0:	44424537          	lui	a0,0x44424
    802007f4:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802007f8:	c91ff0ef          	jal	80200488 <sbi_ecall>
    802007fc:	00050713          	mv	a4,a0
    80200800:	00058793          	mv	a5,a1
    80200804:	fce43823          	sd	a4,-48(s0)
    80200808:	fcf43c23          	sd	a5,-40(s0)
    8020080c:	fd043703          	ld	a4,-48(s0)
    80200810:	fd843783          	ld	a5,-40(s0)
    80200814:	00070913          	mv	s2,a4
    80200818:	00078993          	mv	s3,a5
    8020081c:	00090713          	mv	a4,s2
    80200820:	00098793          	mv	a5,s3
    80200824:	00070513          	mv	a0,a4
    80200828:	00078593          	mv	a1,a5
    8020082c:	04813083          	ld	ra,72(sp)
    80200830:	04013403          	ld	s0,64(sp)
    80200834:	03813903          	ld	s2,56(sp)
    80200838:	03013983          	ld	s3,48(sp)
    8020083c:	05010113          	addi	sp,sp,80
    80200840:	00008067          	ret

0000000080200844 <trap_handler>:
#include "stdint.h"
#include "trap.h"
#include "printk.h"
#include "clock.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200844:	fe010113          	addi	sp,sp,-32
    80200848:	00113c23          	sd	ra,24(sp)
    8020084c:	00813823          	sd	s0,16(sp)
    80200850:	02010413          	addi	s0,sp,32
    80200854:	fea43423          	sd	a0,-24(s0)
    80200858:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    8020085c:	fe843783          	ld	a5,-24(s0)
    80200860:	0207d463          	bgez	a5,80200888 <trap_handler+0x44>
    80200864:	fe843783          	ld	a5,-24(s0)
    80200868:	0ff7f713          	zext.b	a4,a5
    8020086c:	00500793          	li	a5,5
    80200870:	00f71c63          	bne	a4,a5,80200888 <trap_handler+0x44>
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        printk("[S] Supervisor Mode Timer Interrupt\n");
    80200874:	00001517          	auipc	a0,0x1
    80200878:	7ec50513          	addi	a0,a0,2028 # 80202060 <_srodata+0x60>
    8020087c:	7d1000ef          	jal	8020184c <printk>
        // 设置下一次时钟中断
        clock_set_next_event();
    80200880:	909ff0ef          	jal	80200188 <clock_set_next_event>
    80200884:	01c0006f          	j	802008a0 <trap_handler+0x5c>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    80200888:	fe043603          	ld	a2,-32(s0)
    8020088c:	fe843583          	ld	a1,-24(s0)
    80200890:	00001517          	auipc	a0,0x1
    80200894:	7f850513          	addi	a0,a0,2040 # 80202088 <_srodata+0x88>
    80200898:	7b5000ef          	jal	8020184c <printk>
    }
    8020089c:	00000013          	nop
    802008a0:	00000013          	nop
    802008a4:	01813083          	ld	ra,24(sp)
    802008a8:	01013403          	ld	s0,16(sp)
    802008ac:	02010113          	addi	sp,sp,32
    802008b0:	00008067          	ret

00000000802008b4 <start_kernel>:
#include "printk.h"
#include "defs.h"

extern void test();

int start_kernel() {
    802008b4:	ff010113          	addi	sp,sp,-16
    802008b8:	00113423          	sd	ra,8(sp)
    802008bc:	00813023          	sd	s0,0(sp)
    802008c0:	01010413          	addi	s0,sp,16
    printk("2024");
    802008c4:	00002517          	auipc	a0,0x2
    802008c8:	80450513          	addi	a0,a0,-2044 # 802020c8 <_srodata+0xc8>
    802008cc:	781000ef          	jal	8020184c <printk>
    printk(" ZJU Operating System\n");
    802008d0:	00002517          	auipc	a0,0x2
    802008d4:	80050513          	addi	a0,a0,-2048 # 802020d0 <_srodata+0xd0>
    802008d8:	775000ef          	jal	8020184c <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    test();
    802008dc:	038000ef          	jal	80200914 <test>
    return 0;
    802008e0:	00000793          	li	a5,0
}
    802008e4:	00078513          	mv	a0,a5
    802008e8:	00813083          	ld	ra,8(sp)
    802008ec:	00013403          	ld	s0,0(sp)
    802008f0:	01010113          	addi	sp,sp,16
    802008f4:	00008067          	ret

00000000802008f8 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    802008f8:	ff010113          	addi	sp,sp,-16
    802008fc:	00113423          	sd	ra,8(sp)
    80200900:	00813023          	sd	s0,0(sp)
    80200904:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200908:	00000593          	li	a1,0
    8020090c:	00000513          	li	a0,0
    80200910:	ce5ff0ef          	jal	802005f4 <sbi_system_reset>

0000000080200914 <test>:
    __builtin_unreachable();
}

void test() {
    80200914:	fe010113          	addi	sp,sp,-32
    80200918:	00113c23          	sd	ra,24(sp)
    8020091c:	00813823          	sd	s0,16(sp)
    80200920:	02010413          	addi	s0,sp,32
    int i = 0;
    80200924:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
    80200928:	fec42783          	lw	a5,-20(s0)
    8020092c:	0017879b          	addiw	a5,a5,1
    80200930:	fef42623          	sw	a5,-20(s0)
    80200934:	fec42783          	lw	a5,-20(s0)
    80200938:	0007869b          	sext.w	a3,a5
    8020093c:	55e64737          	lui	a4,0x55e64
    80200940:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <_skernel-0x2a39c477>
    80200944:	02e68733          	mul	a4,a3,a4
    80200948:	02075713          	srli	a4,a4,0x20
    8020094c:	4197571b          	sraiw	a4,a4,0x19
    80200950:	00070693          	mv	a3,a4
    80200954:	41f7d71b          	sraiw	a4,a5,0x1f
    80200958:	40e6873b          	subw	a4,a3,a4
    8020095c:	00070693          	mv	a3,a4
    80200960:	05f5e737          	lui	a4,0x5f5e
    80200964:	1007071b          	addiw	a4,a4,256 # 5f5e100 <_skernel-0x7a2a1f00>
    80200968:	02e6873b          	mulw	a4,a3,a4
    8020096c:	40e787bb          	subw	a5,a5,a4
    80200970:	0007879b          	sext.w	a5,a5
    80200974:	fa079ae3          	bnez	a5,80200928 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
    80200978:	00001517          	auipc	a0,0x1
    8020097c:	77050513          	addi	a0,a0,1904 # 802020e8 <_srodata+0xe8>
    80200980:	6cd000ef          	jal	8020184c <printk>
            i = 0;
    80200984:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
    80200988:	fa1ff06f          	j	80200928 <test+0x14>

000000008020098c <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    8020098c:	fe010113          	addi	sp,sp,-32
    80200990:	00113c23          	sd	ra,24(sp)
    80200994:	00813823          	sd	s0,16(sp)
    80200998:	02010413          	addi	s0,sp,32
    8020099c:	00050793          	mv	a5,a0
    802009a0:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    802009a4:	fec42783          	lw	a5,-20(s0)
    802009a8:	0ff7f793          	zext.b	a5,a5
    802009ac:	00078513          	mv	a0,a5
    802009b0:	bb5ff0ef          	jal	80200564 <sbi_debug_console_write_byte>
    return (char)c;
    802009b4:	fec42783          	lw	a5,-20(s0)
    802009b8:	0ff7f793          	zext.b	a5,a5
    802009bc:	0007879b          	sext.w	a5,a5
}
    802009c0:	00078513          	mv	a0,a5
    802009c4:	01813083          	ld	ra,24(sp)
    802009c8:	01013403          	ld	s0,16(sp)
    802009cc:	02010113          	addi	sp,sp,32
    802009d0:	00008067          	ret

00000000802009d4 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    802009d4:	fe010113          	addi	sp,sp,-32
    802009d8:	00113c23          	sd	ra,24(sp)
    802009dc:	00813823          	sd	s0,16(sp)
    802009e0:	02010413          	addi	s0,sp,32
    802009e4:	00050793          	mv	a5,a0
    802009e8:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    802009ec:	fec42783          	lw	a5,-20(s0)
    802009f0:	0007871b          	sext.w	a4,a5
    802009f4:	02000793          	li	a5,32
    802009f8:	02f70263          	beq	a4,a5,80200a1c <isspace+0x48>
    802009fc:	fec42783          	lw	a5,-20(s0)
    80200a00:	0007871b          	sext.w	a4,a5
    80200a04:	00800793          	li	a5,8
    80200a08:	00e7de63          	bge	a5,a4,80200a24 <isspace+0x50>
    80200a0c:	fec42783          	lw	a5,-20(s0)
    80200a10:	0007871b          	sext.w	a4,a5
    80200a14:	00d00793          	li	a5,13
    80200a18:	00e7c663          	blt	a5,a4,80200a24 <isspace+0x50>
    80200a1c:	00100793          	li	a5,1
    80200a20:	0080006f          	j	80200a28 <isspace+0x54>
    80200a24:	00000793          	li	a5,0
}
    80200a28:	00078513          	mv	a0,a5
    80200a2c:	01813083          	ld	ra,24(sp)
    80200a30:	01013403          	ld	s0,16(sp)
    80200a34:	02010113          	addi	sp,sp,32
    80200a38:	00008067          	ret

0000000080200a3c <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80200a3c:	fb010113          	addi	sp,sp,-80
    80200a40:	04113423          	sd	ra,72(sp)
    80200a44:	04813023          	sd	s0,64(sp)
    80200a48:	05010413          	addi	s0,sp,80
    80200a4c:	fca43423          	sd	a0,-56(s0)
    80200a50:	fcb43023          	sd	a1,-64(s0)
    80200a54:	00060793          	mv	a5,a2
    80200a58:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    80200a5c:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    80200a60:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    80200a64:	fc843783          	ld	a5,-56(s0)
    80200a68:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    80200a6c:	0100006f          	j	80200a7c <strtol+0x40>
        p++;
    80200a70:	fd843783          	ld	a5,-40(s0)
    80200a74:	00178793          	addi	a5,a5,1
    80200a78:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    80200a7c:	fd843783          	ld	a5,-40(s0)
    80200a80:	0007c783          	lbu	a5,0(a5)
    80200a84:	0007879b          	sext.w	a5,a5
    80200a88:	00078513          	mv	a0,a5
    80200a8c:	f49ff0ef          	jal	802009d4 <isspace>
    80200a90:	00050793          	mv	a5,a0
    80200a94:	fc079ee3          	bnez	a5,80200a70 <strtol+0x34>
    }

    if (*p == '-') {
    80200a98:	fd843783          	ld	a5,-40(s0)
    80200a9c:	0007c783          	lbu	a5,0(a5)
    80200aa0:	00078713          	mv	a4,a5
    80200aa4:	02d00793          	li	a5,45
    80200aa8:	00f71e63          	bne	a4,a5,80200ac4 <strtol+0x88>
        neg = true;
    80200aac:	00100793          	li	a5,1
    80200ab0:	fef403a3          	sb	a5,-25(s0)
        p++;
    80200ab4:	fd843783          	ld	a5,-40(s0)
    80200ab8:	00178793          	addi	a5,a5,1
    80200abc:	fcf43c23          	sd	a5,-40(s0)
    80200ac0:	0240006f          	j	80200ae4 <strtol+0xa8>
    } else if (*p == '+') {
    80200ac4:	fd843783          	ld	a5,-40(s0)
    80200ac8:	0007c783          	lbu	a5,0(a5)
    80200acc:	00078713          	mv	a4,a5
    80200ad0:	02b00793          	li	a5,43
    80200ad4:	00f71863          	bne	a4,a5,80200ae4 <strtol+0xa8>
        p++;
    80200ad8:	fd843783          	ld	a5,-40(s0)
    80200adc:	00178793          	addi	a5,a5,1
    80200ae0:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    80200ae4:	fbc42783          	lw	a5,-68(s0)
    80200ae8:	0007879b          	sext.w	a5,a5
    80200aec:	06079c63          	bnez	a5,80200b64 <strtol+0x128>
        if (*p == '0') {
    80200af0:	fd843783          	ld	a5,-40(s0)
    80200af4:	0007c783          	lbu	a5,0(a5)
    80200af8:	00078713          	mv	a4,a5
    80200afc:	03000793          	li	a5,48
    80200b00:	04f71e63          	bne	a4,a5,80200b5c <strtol+0x120>
            p++;
    80200b04:	fd843783          	ld	a5,-40(s0)
    80200b08:	00178793          	addi	a5,a5,1
    80200b0c:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80200b10:	fd843783          	ld	a5,-40(s0)
    80200b14:	0007c783          	lbu	a5,0(a5)
    80200b18:	00078713          	mv	a4,a5
    80200b1c:	07800793          	li	a5,120
    80200b20:	00f70c63          	beq	a4,a5,80200b38 <strtol+0xfc>
    80200b24:	fd843783          	ld	a5,-40(s0)
    80200b28:	0007c783          	lbu	a5,0(a5)
    80200b2c:	00078713          	mv	a4,a5
    80200b30:	05800793          	li	a5,88
    80200b34:	00f71e63          	bne	a4,a5,80200b50 <strtol+0x114>
                base = 16;
    80200b38:	01000793          	li	a5,16
    80200b3c:	faf42e23          	sw	a5,-68(s0)
                p++;
    80200b40:	fd843783          	ld	a5,-40(s0)
    80200b44:	00178793          	addi	a5,a5,1
    80200b48:	fcf43c23          	sd	a5,-40(s0)
    80200b4c:	0180006f          	j	80200b64 <strtol+0x128>
            } else {
                base = 8;
    80200b50:	00800793          	li	a5,8
    80200b54:	faf42e23          	sw	a5,-68(s0)
    80200b58:	00c0006f          	j	80200b64 <strtol+0x128>
            }
        } else {
            base = 10;
    80200b5c:	00a00793          	li	a5,10
    80200b60:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    80200b64:	fd843783          	ld	a5,-40(s0)
    80200b68:	0007c783          	lbu	a5,0(a5)
    80200b6c:	00078713          	mv	a4,a5
    80200b70:	02f00793          	li	a5,47
    80200b74:	02e7f863          	bgeu	a5,a4,80200ba4 <strtol+0x168>
    80200b78:	fd843783          	ld	a5,-40(s0)
    80200b7c:	0007c783          	lbu	a5,0(a5)
    80200b80:	00078713          	mv	a4,a5
    80200b84:	03900793          	li	a5,57
    80200b88:	00e7ee63          	bltu	a5,a4,80200ba4 <strtol+0x168>
            digit = *p - '0';
    80200b8c:	fd843783          	ld	a5,-40(s0)
    80200b90:	0007c783          	lbu	a5,0(a5)
    80200b94:	0007879b          	sext.w	a5,a5
    80200b98:	fd07879b          	addiw	a5,a5,-48
    80200b9c:	fcf42a23          	sw	a5,-44(s0)
    80200ba0:	0800006f          	j	80200c20 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    80200ba4:	fd843783          	ld	a5,-40(s0)
    80200ba8:	0007c783          	lbu	a5,0(a5)
    80200bac:	00078713          	mv	a4,a5
    80200bb0:	06000793          	li	a5,96
    80200bb4:	02e7f863          	bgeu	a5,a4,80200be4 <strtol+0x1a8>
    80200bb8:	fd843783          	ld	a5,-40(s0)
    80200bbc:	0007c783          	lbu	a5,0(a5)
    80200bc0:	00078713          	mv	a4,a5
    80200bc4:	07a00793          	li	a5,122
    80200bc8:	00e7ee63          	bltu	a5,a4,80200be4 <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80200bcc:	fd843783          	ld	a5,-40(s0)
    80200bd0:	0007c783          	lbu	a5,0(a5)
    80200bd4:	0007879b          	sext.w	a5,a5
    80200bd8:	fa97879b          	addiw	a5,a5,-87
    80200bdc:	fcf42a23          	sw	a5,-44(s0)
    80200be0:	0400006f          	j	80200c20 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    80200be4:	fd843783          	ld	a5,-40(s0)
    80200be8:	0007c783          	lbu	a5,0(a5)
    80200bec:	00078713          	mv	a4,a5
    80200bf0:	04000793          	li	a5,64
    80200bf4:	06e7f863          	bgeu	a5,a4,80200c64 <strtol+0x228>
    80200bf8:	fd843783          	ld	a5,-40(s0)
    80200bfc:	0007c783          	lbu	a5,0(a5)
    80200c00:	00078713          	mv	a4,a5
    80200c04:	05a00793          	li	a5,90
    80200c08:	04e7ee63          	bltu	a5,a4,80200c64 <strtol+0x228>
            digit = *p - ('A' - 10);
    80200c0c:	fd843783          	ld	a5,-40(s0)
    80200c10:	0007c783          	lbu	a5,0(a5)
    80200c14:	0007879b          	sext.w	a5,a5
    80200c18:	fc97879b          	addiw	a5,a5,-55
    80200c1c:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80200c20:	fd442783          	lw	a5,-44(s0)
    80200c24:	00078713          	mv	a4,a5
    80200c28:	fbc42783          	lw	a5,-68(s0)
    80200c2c:	0007071b          	sext.w	a4,a4
    80200c30:	0007879b          	sext.w	a5,a5
    80200c34:	02f75663          	bge	a4,a5,80200c60 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80200c38:	fbc42703          	lw	a4,-68(s0)
    80200c3c:	fe843783          	ld	a5,-24(s0)
    80200c40:	02f70733          	mul	a4,a4,a5
    80200c44:	fd442783          	lw	a5,-44(s0)
    80200c48:	00f707b3          	add	a5,a4,a5
    80200c4c:	fef43423          	sd	a5,-24(s0)
        p++;
    80200c50:	fd843783          	ld	a5,-40(s0)
    80200c54:	00178793          	addi	a5,a5,1
    80200c58:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    80200c5c:	f09ff06f          	j	80200b64 <strtol+0x128>
            break;
    80200c60:	00000013          	nop
    }

    if (endptr) {
    80200c64:	fc043783          	ld	a5,-64(s0)
    80200c68:	00078863          	beqz	a5,80200c78 <strtol+0x23c>
        *endptr = (char *)p;
    80200c6c:	fc043783          	ld	a5,-64(s0)
    80200c70:	fd843703          	ld	a4,-40(s0)
    80200c74:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    80200c78:	fe744783          	lbu	a5,-25(s0)
    80200c7c:	0ff7f793          	zext.b	a5,a5
    80200c80:	00078863          	beqz	a5,80200c90 <strtol+0x254>
    80200c84:	fe843783          	ld	a5,-24(s0)
    80200c88:	40f007b3          	neg	a5,a5
    80200c8c:	0080006f          	j	80200c94 <strtol+0x258>
    80200c90:	fe843783          	ld	a5,-24(s0)
}
    80200c94:	00078513          	mv	a0,a5
    80200c98:	04813083          	ld	ra,72(sp)
    80200c9c:	04013403          	ld	s0,64(sp)
    80200ca0:	05010113          	addi	sp,sp,80
    80200ca4:	00008067          	ret

0000000080200ca8 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    80200ca8:	fd010113          	addi	sp,sp,-48
    80200cac:	02113423          	sd	ra,40(sp)
    80200cb0:	02813023          	sd	s0,32(sp)
    80200cb4:	03010413          	addi	s0,sp,48
    80200cb8:	fca43c23          	sd	a0,-40(s0)
    80200cbc:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    80200cc0:	fd043783          	ld	a5,-48(s0)
    80200cc4:	00079863          	bnez	a5,80200cd4 <puts_wo_nl+0x2c>
        s = "(null)";
    80200cc8:	00001797          	auipc	a5,0x1
    80200ccc:	43878793          	addi	a5,a5,1080 # 80202100 <_srodata+0x100>
    80200cd0:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    80200cd4:	fd043783          	ld	a5,-48(s0)
    80200cd8:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80200cdc:	0240006f          	j	80200d00 <puts_wo_nl+0x58>
        putch(*p++);
    80200ce0:	fe843783          	ld	a5,-24(s0)
    80200ce4:	00178713          	addi	a4,a5,1
    80200ce8:	fee43423          	sd	a4,-24(s0)
    80200cec:	0007c783          	lbu	a5,0(a5)
    80200cf0:	0007871b          	sext.w	a4,a5
    80200cf4:	fd843783          	ld	a5,-40(s0)
    80200cf8:	00070513          	mv	a0,a4
    80200cfc:	000780e7          	jalr	a5
    while (*p) {
    80200d00:	fe843783          	ld	a5,-24(s0)
    80200d04:	0007c783          	lbu	a5,0(a5)
    80200d08:	fc079ce3          	bnez	a5,80200ce0 <puts_wo_nl+0x38>
    }
    return p - s;
    80200d0c:	fe843703          	ld	a4,-24(s0)
    80200d10:	fd043783          	ld	a5,-48(s0)
    80200d14:	40f707b3          	sub	a5,a4,a5
    80200d18:	0007879b          	sext.w	a5,a5
}
    80200d1c:	00078513          	mv	a0,a5
    80200d20:	02813083          	ld	ra,40(sp)
    80200d24:	02013403          	ld	s0,32(sp)
    80200d28:	03010113          	addi	sp,sp,48
    80200d2c:	00008067          	ret

0000000080200d30 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    80200d30:	f9010113          	addi	sp,sp,-112
    80200d34:	06113423          	sd	ra,104(sp)
    80200d38:	06813023          	sd	s0,96(sp)
    80200d3c:	07010413          	addi	s0,sp,112
    80200d40:	faa43423          	sd	a0,-88(s0)
    80200d44:	fab43023          	sd	a1,-96(s0)
    80200d48:	00060793          	mv	a5,a2
    80200d4c:	f8d43823          	sd	a3,-112(s0)
    80200d50:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    80200d54:	f9f44783          	lbu	a5,-97(s0)
    80200d58:	0ff7f793          	zext.b	a5,a5
    80200d5c:	02078663          	beqz	a5,80200d88 <print_dec_int+0x58>
    80200d60:	fa043703          	ld	a4,-96(s0)
    80200d64:	fff00793          	li	a5,-1
    80200d68:	03f79793          	slli	a5,a5,0x3f
    80200d6c:	00f71e63          	bne	a4,a5,80200d88 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    80200d70:	00001597          	auipc	a1,0x1
    80200d74:	39858593          	addi	a1,a1,920 # 80202108 <_srodata+0x108>
    80200d78:	fa843503          	ld	a0,-88(s0)
    80200d7c:	f2dff0ef          	jal	80200ca8 <puts_wo_nl>
    80200d80:	00050793          	mv	a5,a0
    80200d84:	2c80006f          	j	8020104c <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    80200d88:	f9043783          	ld	a5,-112(s0)
    80200d8c:	00c7a783          	lw	a5,12(a5)
    80200d90:	00079a63          	bnez	a5,80200da4 <print_dec_int+0x74>
    80200d94:	fa043783          	ld	a5,-96(s0)
    80200d98:	00079663          	bnez	a5,80200da4 <print_dec_int+0x74>
        return 0;
    80200d9c:	00000793          	li	a5,0
    80200da0:	2ac0006f          	j	8020104c <print_dec_int+0x31c>
    }

    bool neg = false;
    80200da4:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80200da8:	f9f44783          	lbu	a5,-97(s0)
    80200dac:	0ff7f793          	zext.b	a5,a5
    80200db0:	02078063          	beqz	a5,80200dd0 <print_dec_int+0xa0>
    80200db4:	fa043783          	ld	a5,-96(s0)
    80200db8:	0007dc63          	bgez	a5,80200dd0 <print_dec_int+0xa0>
        neg = true;
    80200dbc:	00100793          	li	a5,1
    80200dc0:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    80200dc4:	fa043783          	ld	a5,-96(s0)
    80200dc8:	40f007b3          	neg	a5,a5
    80200dcc:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    80200dd0:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    80200dd4:	f9f44783          	lbu	a5,-97(s0)
    80200dd8:	0ff7f793          	zext.b	a5,a5
    80200ddc:	02078863          	beqz	a5,80200e0c <print_dec_int+0xdc>
    80200de0:	fef44783          	lbu	a5,-17(s0)
    80200de4:	0ff7f793          	zext.b	a5,a5
    80200de8:	00079e63          	bnez	a5,80200e04 <print_dec_int+0xd4>
    80200dec:	f9043783          	ld	a5,-112(s0)
    80200df0:	0057c783          	lbu	a5,5(a5)
    80200df4:	00079863          	bnez	a5,80200e04 <print_dec_int+0xd4>
    80200df8:	f9043783          	ld	a5,-112(s0)
    80200dfc:	0047c783          	lbu	a5,4(a5)
    80200e00:	00078663          	beqz	a5,80200e0c <print_dec_int+0xdc>
    80200e04:	00100793          	li	a5,1
    80200e08:	0080006f          	j	80200e10 <print_dec_int+0xe0>
    80200e0c:	00000793          	li	a5,0
    80200e10:	fcf40ba3          	sb	a5,-41(s0)
    80200e14:	fd744783          	lbu	a5,-41(s0)
    80200e18:	0017f793          	andi	a5,a5,1
    80200e1c:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80200e20:	fa043683          	ld	a3,-96(s0)
    80200e24:	00001797          	auipc	a5,0x1
    80200e28:	2fc78793          	addi	a5,a5,764 # 80202120 <_srodata+0x120>
    80200e2c:	0007b783          	ld	a5,0(a5)
    80200e30:	02f6b7b3          	mulhu	a5,a3,a5
    80200e34:	0037d713          	srli	a4,a5,0x3
    80200e38:	00070793          	mv	a5,a4
    80200e3c:	00279793          	slli	a5,a5,0x2
    80200e40:	00e787b3          	add	a5,a5,a4
    80200e44:	00179793          	slli	a5,a5,0x1
    80200e48:	40f68733          	sub	a4,a3,a5
    80200e4c:	0ff77713          	zext.b	a4,a4
    80200e50:	fe842783          	lw	a5,-24(s0)
    80200e54:	0017869b          	addiw	a3,a5,1
    80200e58:	fed42423          	sw	a3,-24(s0)
    80200e5c:	0307071b          	addiw	a4,a4,48
    80200e60:	0ff77713          	zext.b	a4,a4
    80200e64:	ff078793          	addi	a5,a5,-16
    80200e68:	008787b3          	add	a5,a5,s0
    80200e6c:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    80200e70:	fa043703          	ld	a4,-96(s0)
    80200e74:	00001797          	auipc	a5,0x1
    80200e78:	2ac78793          	addi	a5,a5,684 # 80202120 <_srodata+0x120>
    80200e7c:	0007b783          	ld	a5,0(a5)
    80200e80:	02f737b3          	mulhu	a5,a4,a5
    80200e84:	0037d793          	srli	a5,a5,0x3
    80200e88:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80200e8c:	fa043783          	ld	a5,-96(s0)
    80200e90:	f80798e3          	bnez	a5,80200e20 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    80200e94:	f9043783          	ld	a5,-112(s0)
    80200e98:	00c7a703          	lw	a4,12(a5)
    80200e9c:	fff00793          	li	a5,-1
    80200ea0:	02f71063          	bne	a4,a5,80200ec0 <print_dec_int+0x190>
    80200ea4:	f9043783          	ld	a5,-112(s0)
    80200ea8:	0037c783          	lbu	a5,3(a5)
    80200eac:	00078a63          	beqz	a5,80200ec0 <print_dec_int+0x190>
        flags->prec = flags->width;
    80200eb0:	f9043783          	ld	a5,-112(s0)
    80200eb4:	0087a703          	lw	a4,8(a5)
    80200eb8:	f9043783          	ld	a5,-112(s0)
    80200ebc:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80200ec0:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200ec4:	f9043783          	ld	a5,-112(s0)
    80200ec8:	0087a703          	lw	a4,8(a5)
    80200ecc:	fe842783          	lw	a5,-24(s0)
    80200ed0:	fcf42823          	sw	a5,-48(s0)
    80200ed4:	f9043783          	ld	a5,-112(s0)
    80200ed8:	00c7a783          	lw	a5,12(a5)
    80200edc:	fcf42623          	sw	a5,-52(s0)
    80200ee0:	fd042783          	lw	a5,-48(s0)
    80200ee4:	00078593          	mv	a1,a5
    80200ee8:	fcc42783          	lw	a5,-52(s0)
    80200eec:	00078613          	mv	a2,a5
    80200ef0:	0006069b          	sext.w	a3,a2
    80200ef4:	0005879b          	sext.w	a5,a1
    80200ef8:	00f6d463          	bge	a3,a5,80200f00 <print_dec_int+0x1d0>
    80200efc:	00058613          	mv	a2,a1
    80200f00:	0006079b          	sext.w	a5,a2
    80200f04:	40f707bb          	subw	a5,a4,a5
    80200f08:	0007871b          	sext.w	a4,a5
    80200f0c:	fd744783          	lbu	a5,-41(s0)
    80200f10:	0007879b          	sext.w	a5,a5
    80200f14:	40f707bb          	subw	a5,a4,a5
    80200f18:	fef42023          	sw	a5,-32(s0)
    80200f1c:	0280006f          	j	80200f44 <print_dec_int+0x214>
        putch(' ');
    80200f20:	fa843783          	ld	a5,-88(s0)
    80200f24:	02000513          	li	a0,32
    80200f28:	000780e7          	jalr	a5
        ++written;
    80200f2c:	fe442783          	lw	a5,-28(s0)
    80200f30:	0017879b          	addiw	a5,a5,1
    80200f34:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200f38:	fe042783          	lw	a5,-32(s0)
    80200f3c:	fff7879b          	addiw	a5,a5,-1
    80200f40:	fef42023          	sw	a5,-32(s0)
    80200f44:	fe042783          	lw	a5,-32(s0)
    80200f48:	0007879b          	sext.w	a5,a5
    80200f4c:	fcf04ae3          	bgtz	a5,80200f20 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    80200f50:	fd744783          	lbu	a5,-41(s0)
    80200f54:	0ff7f793          	zext.b	a5,a5
    80200f58:	04078463          	beqz	a5,80200fa0 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    80200f5c:	fef44783          	lbu	a5,-17(s0)
    80200f60:	0ff7f793          	zext.b	a5,a5
    80200f64:	00078663          	beqz	a5,80200f70 <print_dec_int+0x240>
    80200f68:	02d00793          	li	a5,45
    80200f6c:	01c0006f          	j	80200f88 <print_dec_int+0x258>
    80200f70:	f9043783          	ld	a5,-112(s0)
    80200f74:	0057c783          	lbu	a5,5(a5)
    80200f78:	00078663          	beqz	a5,80200f84 <print_dec_int+0x254>
    80200f7c:	02b00793          	li	a5,43
    80200f80:	0080006f          	j	80200f88 <print_dec_int+0x258>
    80200f84:	02000793          	li	a5,32
    80200f88:	fa843703          	ld	a4,-88(s0)
    80200f8c:	00078513          	mv	a0,a5
    80200f90:	000700e7          	jalr	a4
        ++written;
    80200f94:	fe442783          	lw	a5,-28(s0)
    80200f98:	0017879b          	addiw	a5,a5,1
    80200f9c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200fa0:	fe842783          	lw	a5,-24(s0)
    80200fa4:	fcf42e23          	sw	a5,-36(s0)
    80200fa8:	0280006f          	j	80200fd0 <print_dec_int+0x2a0>
        putch('0');
    80200fac:	fa843783          	ld	a5,-88(s0)
    80200fb0:	03000513          	li	a0,48
    80200fb4:	000780e7          	jalr	a5
        ++written;
    80200fb8:	fe442783          	lw	a5,-28(s0)
    80200fbc:	0017879b          	addiw	a5,a5,1
    80200fc0:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200fc4:	fdc42783          	lw	a5,-36(s0)
    80200fc8:	0017879b          	addiw	a5,a5,1
    80200fcc:	fcf42e23          	sw	a5,-36(s0)
    80200fd0:	f9043783          	ld	a5,-112(s0)
    80200fd4:	00c7a703          	lw	a4,12(a5)
    80200fd8:	fd744783          	lbu	a5,-41(s0)
    80200fdc:	0007879b          	sext.w	a5,a5
    80200fe0:	40f707bb          	subw	a5,a4,a5
    80200fe4:	0007879b          	sext.w	a5,a5
    80200fe8:	fdc42703          	lw	a4,-36(s0)
    80200fec:	0007071b          	sext.w	a4,a4
    80200ff0:	faf74ee3          	blt	a4,a5,80200fac <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80200ff4:	fe842783          	lw	a5,-24(s0)
    80200ff8:	fff7879b          	addiw	a5,a5,-1
    80200ffc:	fcf42c23          	sw	a5,-40(s0)
    80201000:	03c0006f          	j	8020103c <print_dec_int+0x30c>
        putch(buf[i]);
    80201004:	fd842783          	lw	a5,-40(s0)
    80201008:	ff078793          	addi	a5,a5,-16
    8020100c:	008787b3          	add	a5,a5,s0
    80201010:	fc87c783          	lbu	a5,-56(a5)
    80201014:	0007871b          	sext.w	a4,a5
    80201018:	fa843783          	ld	a5,-88(s0)
    8020101c:	00070513          	mv	a0,a4
    80201020:	000780e7          	jalr	a5
        ++written;
    80201024:	fe442783          	lw	a5,-28(s0)
    80201028:	0017879b          	addiw	a5,a5,1
    8020102c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    80201030:	fd842783          	lw	a5,-40(s0)
    80201034:	fff7879b          	addiw	a5,a5,-1
    80201038:	fcf42c23          	sw	a5,-40(s0)
    8020103c:	fd842783          	lw	a5,-40(s0)
    80201040:	0007879b          	sext.w	a5,a5
    80201044:	fc07d0e3          	bgez	a5,80201004 <print_dec_int+0x2d4>
    }

    return written;
    80201048:	fe442783          	lw	a5,-28(s0)
}
    8020104c:	00078513          	mv	a0,a5
    80201050:	06813083          	ld	ra,104(sp)
    80201054:	06013403          	ld	s0,96(sp)
    80201058:	07010113          	addi	sp,sp,112
    8020105c:	00008067          	ret

0000000080201060 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    80201060:	f4010113          	addi	sp,sp,-192
    80201064:	0a113c23          	sd	ra,184(sp)
    80201068:	0a813823          	sd	s0,176(sp)
    8020106c:	0c010413          	addi	s0,sp,192
    80201070:	f4a43c23          	sd	a0,-168(s0)
    80201074:	f4b43823          	sd	a1,-176(s0)
    80201078:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    8020107c:	f8043023          	sd	zero,-128(s0)
    80201080:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80201084:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80201088:	7a00006f          	j	80201828 <vprintfmt+0x7c8>
        if (flags.in_format) {
    8020108c:	f8044783          	lbu	a5,-128(s0)
    80201090:	72078c63          	beqz	a5,802017c8 <vprintfmt+0x768>
            if (*fmt == '#') {
    80201094:	f5043783          	ld	a5,-176(s0)
    80201098:	0007c783          	lbu	a5,0(a5)
    8020109c:	00078713          	mv	a4,a5
    802010a0:	02300793          	li	a5,35
    802010a4:	00f71863          	bne	a4,a5,802010b4 <vprintfmt+0x54>
                flags.sharpflag = true;
    802010a8:	00100793          	li	a5,1
    802010ac:	f8f40123          	sb	a5,-126(s0)
    802010b0:	76c0006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    802010b4:	f5043783          	ld	a5,-176(s0)
    802010b8:	0007c783          	lbu	a5,0(a5)
    802010bc:	00078713          	mv	a4,a5
    802010c0:	03000793          	li	a5,48
    802010c4:	00f71863          	bne	a4,a5,802010d4 <vprintfmt+0x74>
                flags.zeroflag = true;
    802010c8:	00100793          	li	a5,1
    802010cc:	f8f401a3          	sb	a5,-125(s0)
    802010d0:	74c0006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    802010d4:	f5043783          	ld	a5,-176(s0)
    802010d8:	0007c783          	lbu	a5,0(a5)
    802010dc:	00078713          	mv	a4,a5
    802010e0:	06c00793          	li	a5,108
    802010e4:	04f70063          	beq	a4,a5,80201124 <vprintfmt+0xc4>
    802010e8:	f5043783          	ld	a5,-176(s0)
    802010ec:	0007c783          	lbu	a5,0(a5)
    802010f0:	00078713          	mv	a4,a5
    802010f4:	07a00793          	li	a5,122
    802010f8:	02f70663          	beq	a4,a5,80201124 <vprintfmt+0xc4>
    802010fc:	f5043783          	ld	a5,-176(s0)
    80201100:	0007c783          	lbu	a5,0(a5)
    80201104:	00078713          	mv	a4,a5
    80201108:	07400793          	li	a5,116
    8020110c:	00f70c63          	beq	a4,a5,80201124 <vprintfmt+0xc4>
    80201110:	f5043783          	ld	a5,-176(s0)
    80201114:	0007c783          	lbu	a5,0(a5)
    80201118:	00078713          	mv	a4,a5
    8020111c:	06a00793          	li	a5,106
    80201120:	00f71863          	bne	a4,a5,80201130 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80201124:	00100793          	li	a5,1
    80201128:	f8f400a3          	sb	a5,-127(s0)
    8020112c:	6f00006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    80201130:	f5043783          	ld	a5,-176(s0)
    80201134:	0007c783          	lbu	a5,0(a5)
    80201138:	00078713          	mv	a4,a5
    8020113c:	02b00793          	li	a5,43
    80201140:	00f71863          	bne	a4,a5,80201150 <vprintfmt+0xf0>
                flags.sign = true;
    80201144:	00100793          	li	a5,1
    80201148:	f8f402a3          	sb	a5,-123(s0)
    8020114c:	6d00006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    80201150:	f5043783          	ld	a5,-176(s0)
    80201154:	0007c783          	lbu	a5,0(a5)
    80201158:	00078713          	mv	a4,a5
    8020115c:	02000793          	li	a5,32
    80201160:	00f71863          	bne	a4,a5,80201170 <vprintfmt+0x110>
                flags.spaceflag = true;
    80201164:	00100793          	li	a5,1
    80201168:	f8f40223          	sb	a5,-124(s0)
    8020116c:	6b00006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    80201170:	f5043783          	ld	a5,-176(s0)
    80201174:	0007c783          	lbu	a5,0(a5)
    80201178:	00078713          	mv	a4,a5
    8020117c:	02a00793          	li	a5,42
    80201180:	00f71e63          	bne	a4,a5,8020119c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80201184:	f4843783          	ld	a5,-184(s0)
    80201188:	00878713          	addi	a4,a5,8
    8020118c:	f4e43423          	sd	a4,-184(s0)
    80201190:	0007a783          	lw	a5,0(a5)
    80201194:	f8f42423          	sw	a5,-120(s0)
    80201198:	6840006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    8020119c:	f5043783          	ld	a5,-176(s0)
    802011a0:	0007c783          	lbu	a5,0(a5)
    802011a4:	00078713          	mv	a4,a5
    802011a8:	03000793          	li	a5,48
    802011ac:	04e7f663          	bgeu	a5,a4,802011f8 <vprintfmt+0x198>
    802011b0:	f5043783          	ld	a5,-176(s0)
    802011b4:	0007c783          	lbu	a5,0(a5)
    802011b8:	00078713          	mv	a4,a5
    802011bc:	03900793          	li	a5,57
    802011c0:	02e7ec63          	bltu	a5,a4,802011f8 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    802011c4:	f5043783          	ld	a5,-176(s0)
    802011c8:	f5040713          	addi	a4,s0,-176
    802011cc:	00a00613          	li	a2,10
    802011d0:	00070593          	mv	a1,a4
    802011d4:	00078513          	mv	a0,a5
    802011d8:	865ff0ef          	jal	80200a3c <strtol>
    802011dc:	00050793          	mv	a5,a0
    802011e0:	0007879b          	sext.w	a5,a5
    802011e4:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    802011e8:	f5043783          	ld	a5,-176(s0)
    802011ec:	fff78793          	addi	a5,a5,-1
    802011f0:	f4f43823          	sd	a5,-176(s0)
    802011f4:	6280006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    802011f8:	f5043783          	ld	a5,-176(s0)
    802011fc:	0007c783          	lbu	a5,0(a5)
    80201200:	00078713          	mv	a4,a5
    80201204:	02e00793          	li	a5,46
    80201208:	06f71863          	bne	a4,a5,80201278 <vprintfmt+0x218>
                fmt++;
    8020120c:	f5043783          	ld	a5,-176(s0)
    80201210:	00178793          	addi	a5,a5,1
    80201214:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80201218:	f5043783          	ld	a5,-176(s0)
    8020121c:	0007c783          	lbu	a5,0(a5)
    80201220:	00078713          	mv	a4,a5
    80201224:	02a00793          	li	a5,42
    80201228:	00f71e63          	bne	a4,a5,80201244 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    8020122c:	f4843783          	ld	a5,-184(s0)
    80201230:	00878713          	addi	a4,a5,8
    80201234:	f4e43423          	sd	a4,-184(s0)
    80201238:	0007a783          	lw	a5,0(a5)
    8020123c:	f8f42623          	sw	a5,-116(s0)
    80201240:	5dc0006f          	j	8020181c <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80201244:	f5043783          	ld	a5,-176(s0)
    80201248:	f5040713          	addi	a4,s0,-176
    8020124c:	00a00613          	li	a2,10
    80201250:	00070593          	mv	a1,a4
    80201254:	00078513          	mv	a0,a5
    80201258:	fe4ff0ef          	jal	80200a3c <strtol>
    8020125c:	00050793          	mv	a5,a0
    80201260:	0007879b          	sext.w	a5,a5
    80201264:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80201268:	f5043783          	ld	a5,-176(s0)
    8020126c:	fff78793          	addi	a5,a5,-1
    80201270:	f4f43823          	sd	a5,-176(s0)
    80201274:	5a80006f          	j	8020181c <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201278:	f5043783          	ld	a5,-176(s0)
    8020127c:	0007c783          	lbu	a5,0(a5)
    80201280:	00078713          	mv	a4,a5
    80201284:	07800793          	li	a5,120
    80201288:	02f70663          	beq	a4,a5,802012b4 <vprintfmt+0x254>
    8020128c:	f5043783          	ld	a5,-176(s0)
    80201290:	0007c783          	lbu	a5,0(a5)
    80201294:	00078713          	mv	a4,a5
    80201298:	05800793          	li	a5,88
    8020129c:	00f70c63          	beq	a4,a5,802012b4 <vprintfmt+0x254>
    802012a0:	f5043783          	ld	a5,-176(s0)
    802012a4:	0007c783          	lbu	a5,0(a5)
    802012a8:	00078713          	mv	a4,a5
    802012ac:	07000793          	li	a5,112
    802012b0:	30f71063          	bne	a4,a5,802015b0 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    802012b4:	f5043783          	ld	a5,-176(s0)
    802012b8:	0007c783          	lbu	a5,0(a5)
    802012bc:	00078713          	mv	a4,a5
    802012c0:	07000793          	li	a5,112
    802012c4:	00f70663          	beq	a4,a5,802012d0 <vprintfmt+0x270>
    802012c8:	f8144783          	lbu	a5,-127(s0)
    802012cc:	00078663          	beqz	a5,802012d8 <vprintfmt+0x278>
    802012d0:	00100793          	li	a5,1
    802012d4:	0080006f          	j	802012dc <vprintfmt+0x27c>
    802012d8:	00000793          	li	a5,0
    802012dc:	faf403a3          	sb	a5,-89(s0)
    802012e0:	fa744783          	lbu	a5,-89(s0)
    802012e4:	0017f793          	andi	a5,a5,1
    802012e8:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    802012ec:	fa744783          	lbu	a5,-89(s0)
    802012f0:	0ff7f793          	zext.b	a5,a5
    802012f4:	00078c63          	beqz	a5,8020130c <vprintfmt+0x2ac>
    802012f8:	f4843783          	ld	a5,-184(s0)
    802012fc:	00878713          	addi	a4,a5,8
    80201300:	f4e43423          	sd	a4,-184(s0)
    80201304:	0007b783          	ld	a5,0(a5)
    80201308:	01c0006f          	j	80201324 <vprintfmt+0x2c4>
    8020130c:	f4843783          	ld	a5,-184(s0)
    80201310:	00878713          	addi	a4,a5,8
    80201314:	f4e43423          	sd	a4,-184(s0)
    80201318:	0007a783          	lw	a5,0(a5)
    8020131c:	02079793          	slli	a5,a5,0x20
    80201320:	0207d793          	srli	a5,a5,0x20
    80201324:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80201328:	f8c42783          	lw	a5,-116(s0)
    8020132c:	02079463          	bnez	a5,80201354 <vprintfmt+0x2f4>
    80201330:	fe043783          	ld	a5,-32(s0)
    80201334:	02079063          	bnez	a5,80201354 <vprintfmt+0x2f4>
    80201338:	f5043783          	ld	a5,-176(s0)
    8020133c:	0007c783          	lbu	a5,0(a5)
    80201340:	00078713          	mv	a4,a5
    80201344:	07000793          	li	a5,112
    80201348:	00f70663          	beq	a4,a5,80201354 <vprintfmt+0x2f4>
                    flags.in_format = false;
    8020134c:	f8040023          	sb	zero,-128(s0)
    80201350:	4cc0006f          	j	8020181c <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    80201354:	f5043783          	ld	a5,-176(s0)
    80201358:	0007c783          	lbu	a5,0(a5)
    8020135c:	00078713          	mv	a4,a5
    80201360:	07000793          	li	a5,112
    80201364:	00f70a63          	beq	a4,a5,80201378 <vprintfmt+0x318>
    80201368:	f8244783          	lbu	a5,-126(s0)
    8020136c:	00078a63          	beqz	a5,80201380 <vprintfmt+0x320>
    80201370:	fe043783          	ld	a5,-32(s0)
    80201374:	00078663          	beqz	a5,80201380 <vprintfmt+0x320>
    80201378:	00100793          	li	a5,1
    8020137c:	0080006f          	j	80201384 <vprintfmt+0x324>
    80201380:	00000793          	li	a5,0
    80201384:	faf40323          	sb	a5,-90(s0)
    80201388:	fa644783          	lbu	a5,-90(s0)
    8020138c:	0017f793          	andi	a5,a5,1
    80201390:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80201394:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80201398:	f5043783          	ld	a5,-176(s0)
    8020139c:	0007c783          	lbu	a5,0(a5)
    802013a0:	00078713          	mv	a4,a5
    802013a4:	05800793          	li	a5,88
    802013a8:	00f71863          	bne	a4,a5,802013b8 <vprintfmt+0x358>
    802013ac:	00001797          	auipc	a5,0x1
    802013b0:	d7c78793          	addi	a5,a5,-644 # 80202128 <upperxdigits.1>
    802013b4:	00c0006f          	j	802013c0 <vprintfmt+0x360>
    802013b8:	00001797          	auipc	a5,0x1
    802013bc:	d8878793          	addi	a5,a5,-632 # 80202140 <lowerxdigits.0>
    802013c0:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    802013c4:	fe043783          	ld	a5,-32(s0)
    802013c8:	00f7f793          	andi	a5,a5,15
    802013cc:	f9843703          	ld	a4,-104(s0)
    802013d0:	00f70733          	add	a4,a4,a5
    802013d4:	fdc42783          	lw	a5,-36(s0)
    802013d8:	0017869b          	addiw	a3,a5,1
    802013dc:	fcd42e23          	sw	a3,-36(s0)
    802013e0:	00074703          	lbu	a4,0(a4)
    802013e4:	ff078793          	addi	a5,a5,-16
    802013e8:	008787b3          	add	a5,a5,s0
    802013ec:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    802013f0:	fe043783          	ld	a5,-32(s0)
    802013f4:	0047d793          	srli	a5,a5,0x4
    802013f8:	fef43023          	sd	a5,-32(s0)
                } while (num);
    802013fc:	fe043783          	ld	a5,-32(s0)
    80201400:	fc0792e3          	bnez	a5,802013c4 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201404:	f8c42703          	lw	a4,-116(s0)
    80201408:	fff00793          	li	a5,-1
    8020140c:	02f71663          	bne	a4,a5,80201438 <vprintfmt+0x3d8>
    80201410:	f8344783          	lbu	a5,-125(s0)
    80201414:	02078263          	beqz	a5,80201438 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80201418:	f8842703          	lw	a4,-120(s0)
    8020141c:	fa644783          	lbu	a5,-90(s0)
    80201420:	0007879b          	sext.w	a5,a5
    80201424:	0017979b          	slliw	a5,a5,0x1
    80201428:	0007879b          	sext.w	a5,a5
    8020142c:	40f707bb          	subw	a5,a4,a5
    80201430:	0007879b          	sext.w	a5,a5
    80201434:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201438:	f8842703          	lw	a4,-120(s0)
    8020143c:	fa644783          	lbu	a5,-90(s0)
    80201440:	0007879b          	sext.w	a5,a5
    80201444:	0017979b          	slliw	a5,a5,0x1
    80201448:	0007879b          	sext.w	a5,a5
    8020144c:	40f707bb          	subw	a5,a4,a5
    80201450:	0007871b          	sext.w	a4,a5
    80201454:	fdc42783          	lw	a5,-36(s0)
    80201458:	f8f42a23          	sw	a5,-108(s0)
    8020145c:	f8c42783          	lw	a5,-116(s0)
    80201460:	f8f42823          	sw	a5,-112(s0)
    80201464:	f9442783          	lw	a5,-108(s0)
    80201468:	00078593          	mv	a1,a5
    8020146c:	f9042783          	lw	a5,-112(s0)
    80201470:	00078613          	mv	a2,a5
    80201474:	0006069b          	sext.w	a3,a2
    80201478:	0005879b          	sext.w	a5,a1
    8020147c:	00f6d463          	bge	a3,a5,80201484 <vprintfmt+0x424>
    80201480:	00058613          	mv	a2,a1
    80201484:	0006079b          	sext.w	a5,a2
    80201488:	40f707bb          	subw	a5,a4,a5
    8020148c:	fcf42c23          	sw	a5,-40(s0)
    80201490:	0280006f          	j	802014b8 <vprintfmt+0x458>
                    putch(' ');
    80201494:	f5843783          	ld	a5,-168(s0)
    80201498:	02000513          	li	a0,32
    8020149c:	000780e7          	jalr	a5
                    ++written;
    802014a0:	fec42783          	lw	a5,-20(s0)
    802014a4:	0017879b          	addiw	a5,a5,1
    802014a8:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    802014ac:	fd842783          	lw	a5,-40(s0)
    802014b0:	fff7879b          	addiw	a5,a5,-1
    802014b4:	fcf42c23          	sw	a5,-40(s0)
    802014b8:	fd842783          	lw	a5,-40(s0)
    802014bc:	0007879b          	sext.w	a5,a5
    802014c0:	fcf04ae3          	bgtz	a5,80201494 <vprintfmt+0x434>
                }

                if (prefix) {
    802014c4:	fa644783          	lbu	a5,-90(s0)
    802014c8:	0ff7f793          	zext.b	a5,a5
    802014cc:	04078463          	beqz	a5,80201514 <vprintfmt+0x4b4>
                    putch('0');
    802014d0:	f5843783          	ld	a5,-168(s0)
    802014d4:	03000513          	li	a0,48
    802014d8:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    802014dc:	f5043783          	ld	a5,-176(s0)
    802014e0:	0007c783          	lbu	a5,0(a5)
    802014e4:	00078713          	mv	a4,a5
    802014e8:	05800793          	li	a5,88
    802014ec:	00f71663          	bne	a4,a5,802014f8 <vprintfmt+0x498>
    802014f0:	05800793          	li	a5,88
    802014f4:	0080006f          	j	802014fc <vprintfmt+0x49c>
    802014f8:	07800793          	li	a5,120
    802014fc:	f5843703          	ld	a4,-168(s0)
    80201500:	00078513          	mv	a0,a5
    80201504:	000700e7          	jalr	a4
                    written += 2;
    80201508:	fec42783          	lw	a5,-20(s0)
    8020150c:	0027879b          	addiw	a5,a5,2
    80201510:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201514:	fdc42783          	lw	a5,-36(s0)
    80201518:	fcf42a23          	sw	a5,-44(s0)
    8020151c:	0280006f          	j	80201544 <vprintfmt+0x4e4>
                    putch('0');
    80201520:	f5843783          	ld	a5,-168(s0)
    80201524:	03000513          	li	a0,48
    80201528:	000780e7          	jalr	a5
                    ++written;
    8020152c:	fec42783          	lw	a5,-20(s0)
    80201530:	0017879b          	addiw	a5,a5,1
    80201534:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201538:	fd442783          	lw	a5,-44(s0)
    8020153c:	0017879b          	addiw	a5,a5,1
    80201540:	fcf42a23          	sw	a5,-44(s0)
    80201544:	f8c42783          	lw	a5,-116(s0)
    80201548:	fd442703          	lw	a4,-44(s0)
    8020154c:	0007071b          	sext.w	a4,a4
    80201550:	fcf748e3          	blt	a4,a5,80201520 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201554:	fdc42783          	lw	a5,-36(s0)
    80201558:	fff7879b          	addiw	a5,a5,-1
    8020155c:	fcf42823          	sw	a5,-48(s0)
    80201560:	03c0006f          	j	8020159c <vprintfmt+0x53c>
                    putch(buf[i]);
    80201564:	fd042783          	lw	a5,-48(s0)
    80201568:	ff078793          	addi	a5,a5,-16
    8020156c:	008787b3          	add	a5,a5,s0
    80201570:	f807c783          	lbu	a5,-128(a5)
    80201574:	0007871b          	sext.w	a4,a5
    80201578:	f5843783          	ld	a5,-168(s0)
    8020157c:	00070513          	mv	a0,a4
    80201580:	000780e7          	jalr	a5
                    ++written;
    80201584:	fec42783          	lw	a5,-20(s0)
    80201588:	0017879b          	addiw	a5,a5,1
    8020158c:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201590:	fd042783          	lw	a5,-48(s0)
    80201594:	fff7879b          	addiw	a5,a5,-1
    80201598:	fcf42823          	sw	a5,-48(s0)
    8020159c:	fd042783          	lw	a5,-48(s0)
    802015a0:	0007879b          	sext.w	a5,a5
    802015a4:	fc07d0e3          	bgez	a5,80201564 <vprintfmt+0x504>
                }

                flags.in_format = false;
    802015a8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802015ac:	2700006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802015b0:	f5043783          	ld	a5,-176(s0)
    802015b4:	0007c783          	lbu	a5,0(a5)
    802015b8:	00078713          	mv	a4,a5
    802015bc:	06400793          	li	a5,100
    802015c0:	02f70663          	beq	a4,a5,802015ec <vprintfmt+0x58c>
    802015c4:	f5043783          	ld	a5,-176(s0)
    802015c8:	0007c783          	lbu	a5,0(a5)
    802015cc:	00078713          	mv	a4,a5
    802015d0:	06900793          	li	a5,105
    802015d4:	00f70c63          	beq	a4,a5,802015ec <vprintfmt+0x58c>
    802015d8:	f5043783          	ld	a5,-176(s0)
    802015dc:	0007c783          	lbu	a5,0(a5)
    802015e0:	00078713          	mv	a4,a5
    802015e4:	07500793          	li	a5,117
    802015e8:	08f71063          	bne	a4,a5,80201668 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    802015ec:	f8144783          	lbu	a5,-127(s0)
    802015f0:	00078c63          	beqz	a5,80201608 <vprintfmt+0x5a8>
    802015f4:	f4843783          	ld	a5,-184(s0)
    802015f8:	00878713          	addi	a4,a5,8
    802015fc:	f4e43423          	sd	a4,-184(s0)
    80201600:	0007b783          	ld	a5,0(a5)
    80201604:	0140006f          	j	80201618 <vprintfmt+0x5b8>
    80201608:	f4843783          	ld	a5,-184(s0)
    8020160c:	00878713          	addi	a4,a5,8
    80201610:	f4e43423          	sd	a4,-184(s0)
    80201614:	0007a783          	lw	a5,0(a5)
    80201618:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    8020161c:	fa843583          	ld	a1,-88(s0)
    80201620:	f5043783          	ld	a5,-176(s0)
    80201624:	0007c783          	lbu	a5,0(a5)
    80201628:	0007871b          	sext.w	a4,a5
    8020162c:	07500793          	li	a5,117
    80201630:	40f707b3          	sub	a5,a4,a5
    80201634:	00f037b3          	snez	a5,a5
    80201638:	0ff7f793          	zext.b	a5,a5
    8020163c:	f8040713          	addi	a4,s0,-128
    80201640:	00070693          	mv	a3,a4
    80201644:	00078613          	mv	a2,a5
    80201648:	f5843503          	ld	a0,-168(s0)
    8020164c:	ee4ff0ef          	jal	80200d30 <print_dec_int>
    80201650:	00050793          	mv	a5,a0
    80201654:	fec42703          	lw	a4,-20(s0)
    80201658:	00f707bb          	addw	a5,a4,a5
    8020165c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201660:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201664:	1b80006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    80201668:	f5043783          	ld	a5,-176(s0)
    8020166c:	0007c783          	lbu	a5,0(a5)
    80201670:	00078713          	mv	a4,a5
    80201674:	06e00793          	li	a5,110
    80201678:	04f71c63          	bne	a4,a5,802016d0 <vprintfmt+0x670>
                if (flags.longflag) {
    8020167c:	f8144783          	lbu	a5,-127(s0)
    80201680:	02078463          	beqz	a5,802016a8 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    80201684:	f4843783          	ld	a5,-184(s0)
    80201688:	00878713          	addi	a4,a5,8
    8020168c:	f4e43423          	sd	a4,-184(s0)
    80201690:	0007b783          	ld	a5,0(a5)
    80201694:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201698:	fec42703          	lw	a4,-20(s0)
    8020169c:	fb043783          	ld	a5,-80(s0)
    802016a0:	00e7b023          	sd	a4,0(a5)
    802016a4:	0240006f          	j	802016c8 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    802016a8:	f4843783          	ld	a5,-184(s0)
    802016ac:	00878713          	addi	a4,a5,8
    802016b0:	f4e43423          	sd	a4,-184(s0)
    802016b4:	0007b783          	ld	a5,0(a5)
    802016b8:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    802016bc:	fb843783          	ld	a5,-72(s0)
    802016c0:	fec42703          	lw	a4,-20(s0)
    802016c4:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    802016c8:	f8040023          	sb	zero,-128(s0)
    802016cc:	1500006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    802016d0:	f5043783          	ld	a5,-176(s0)
    802016d4:	0007c783          	lbu	a5,0(a5)
    802016d8:	00078713          	mv	a4,a5
    802016dc:	07300793          	li	a5,115
    802016e0:	02f71e63          	bne	a4,a5,8020171c <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    802016e4:	f4843783          	ld	a5,-184(s0)
    802016e8:	00878713          	addi	a4,a5,8
    802016ec:	f4e43423          	sd	a4,-184(s0)
    802016f0:	0007b783          	ld	a5,0(a5)
    802016f4:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    802016f8:	fc043583          	ld	a1,-64(s0)
    802016fc:	f5843503          	ld	a0,-168(s0)
    80201700:	da8ff0ef          	jal	80200ca8 <puts_wo_nl>
    80201704:	00050793          	mv	a5,a0
    80201708:	fec42703          	lw	a4,-20(s0)
    8020170c:	00f707bb          	addw	a5,a4,a5
    80201710:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201714:	f8040023          	sb	zero,-128(s0)
    80201718:	1040006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    8020171c:	f5043783          	ld	a5,-176(s0)
    80201720:	0007c783          	lbu	a5,0(a5)
    80201724:	00078713          	mv	a4,a5
    80201728:	06300793          	li	a5,99
    8020172c:	02f71e63          	bne	a4,a5,80201768 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    80201730:	f4843783          	ld	a5,-184(s0)
    80201734:	00878713          	addi	a4,a5,8
    80201738:	f4e43423          	sd	a4,-184(s0)
    8020173c:	0007a783          	lw	a5,0(a5)
    80201740:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201744:	fcc42703          	lw	a4,-52(s0)
    80201748:	f5843783          	ld	a5,-168(s0)
    8020174c:	00070513          	mv	a0,a4
    80201750:	000780e7          	jalr	a5
                ++written;
    80201754:	fec42783          	lw	a5,-20(s0)
    80201758:	0017879b          	addiw	a5,a5,1
    8020175c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201760:	f8040023          	sb	zero,-128(s0)
    80201764:	0b80006f          	j	8020181c <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    80201768:	f5043783          	ld	a5,-176(s0)
    8020176c:	0007c783          	lbu	a5,0(a5)
    80201770:	00078713          	mv	a4,a5
    80201774:	02500793          	li	a5,37
    80201778:	02f71263          	bne	a4,a5,8020179c <vprintfmt+0x73c>
                putch('%');
    8020177c:	f5843783          	ld	a5,-168(s0)
    80201780:	02500513          	li	a0,37
    80201784:	000780e7          	jalr	a5
                ++written;
    80201788:	fec42783          	lw	a5,-20(s0)
    8020178c:	0017879b          	addiw	a5,a5,1
    80201790:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201794:	f8040023          	sb	zero,-128(s0)
    80201798:	0840006f          	j	8020181c <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    8020179c:	f5043783          	ld	a5,-176(s0)
    802017a0:	0007c783          	lbu	a5,0(a5)
    802017a4:	0007871b          	sext.w	a4,a5
    802017a8:	f5843783          	ld	a5,-168(s0)
    802017ac:	00070513          	mv	a0,a4
    802017b0:	000780e7          	jalr	a5
                ++written;
    802017b4:	fec42783          	lw	a5,-20(s0)
    802017b8:	0017879b          	addiw	a5,a5,1
    802017bc:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802017c0:	f8040023          	sb	zero,-128(s0)
    802017c4:	0580006f          	j	8020181c <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    802017c8:	f5043783          	ld	a5,-176(s0)
    802017cc:	0007c783          	lbu	a5,0(a5)
    802017d0:	00078713          	mv	a4,a5
    802017d4:	02500793          	li	a5,37
    802017d8:	02f71063          	bne	a4,a5,802017f8 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    802017dc:	f8043023          	sd	zero,-128(s0)
    802017e0:	f8043423          	sd	zero,-120(s0)
    802017e4:	00100793          	li	a5,1
    802017e8:	f8f40023          	sb	a5,-128(s0)
    802017ec:	fff00793          	li	a5,-1
    802017f0:	f8f42623          	sw	a5,-116(s0)
    802017f4:	0280006f          	j	8020181c <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    802017f8:	f5043783          	ld	a5,-176(s0)
    802017fc:	0007c783          	lbu	a5,0(a5)
    80201800:	0007871b          	sext.w	a4,a5
    80201804:	f5843783          	ld	a5,-168(s0)
    80201808:	00070513          	mv	a0,a4
    8020180c:	000780e7          	jalr	a5
            ++written;
    80201810:	fec42783          	lw	a5,-20(s0)
    80201814:	0017879b          	addiw	a5,a5,1
    80201818:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    8020181c:	f5043783          	ld	a5,-176(s0)
    80201820:	00178793          	addi	a5,a5,1
    80201824:	f4f43823          	sd	a5,-176(s0)
    80201828:	f5043783          	ld	a5,-176(s0)
    8020182c:	0007c783          	lbu	a5,0(a5)
    80201830:	84079ee3          	bnez	a5,8020108c <vprintfmt+0x2c>
        }
    }

    return written;
    80201834:	fec42783          	lw	a5,-20(s0)
}
    80201838:	00078513          	mv	a0,a5
    8020183c:	0b813083          	ld	ra,184(sp)
    80201840:	0b013403          	ld	s0,176(sp)
    80201844:	0c010113          	addi	sp,sp,192
    80201848:	00008067          	ret

000000008020184c <printk>:

int printk(const char* s, ...) {
    8020184c:	f9010113          	addi	sp,sp,-112
    80201850:	02113423          	sd	ra,40(sp)
    80201854:	02813023          	sd	s0,32(sp)
    80201858:	03010413          	addi	s0,sp,48
    8020185c:	fca43c23          	sd	a0,-40(s0)
    80201860:	00b43423          	sd	a1,8(s0)
    80201864:	00c43823          	sd	a2,16(s0)
    80201868:	00d43c23          	sd	a3,24(s0)
    8020186c:	02e43023          	sd	a4,32(s0)
    80201870:	02f43423          	sd	a5,40(s0)
    80201874:	03043823          	sd	a6,48(s0)
    80201878:	03143c23          	sd	a7,56(s0)
    int res = 0;
    8020187c:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201880:	04040793          	addi	a5,s0,64
    80201884:	fcf43823          	sd	a5,-48(s0)
    80201888:	fd043783          	ld	a5,-48(s0)
    8020188c:	fc878793          	addi	a5,a5,-56
    80201890:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201894:	fe043783          	ld	a5,-32(s0)
    80201898:	00078613          	mv	a2,a5
    8020189c:	fd843583          	ld	a1,-40(s0)
    802018a0:	fffff517          	auipc	a0,0xfffff
    802018a4:	0ec50513          	addi	a0,a0,236 # 8020098c <putc>
    802018a8:	fb8ff0ef          	jal	80201060 <vprintfmt>
    802018ac:	00050793          	mv	a5,a0
    802018b0:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    802018b4:	fec42783          	lw	a5,-20(s0)
}
    802018b8:	00078513          	mv	a0,a5
    802018bc:	02813083          	ld	ra,40(sp)
    802018c0:	02013403          	ld	s0,32(sp)
    802018c4:	07010113          	addi	sp,sp,112
    802018c8:	00008067          	ret

00000000802018cc <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
    802018cc:	fe010113          	addi	sp,sp,-32
    802018d0:	00113c23          	sd	ra,24(sp)
    802018d4:	00813823          	sd	s0,16(sp)
    802018d8:	02010413          	addi	s0,sp,32
    802018dc:	00050793          	mv	a5,a0
    802018e0:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
    802018e4:	fec42783          	lw	a5,-20(s0)
    802018e8:	fff7879b          	addiw	a5,a5,-1
    802018ec:	0007879b          	sext.w	a5,a5
    802018f0:	02079713          	slli	a4,a5,0x20
    802018f4:	02075713          	srli	a4,a4,0x20
    802018f8:	00004797          	auipc	a5,0x4
    802018fc:	82078793          	addi	a5,a5,-2016 # 80205118 <seed>
    80201900:	00e7b023          	sd	a4,0(a5)
}
    80201904:	00000013          	nop
    80201908:	01813083          	ld	ra,24(sp)
    8020190c:	01013403          	ld	s0,16(sp)
    80201910:	02010113          	addi	sp,sp,32
    80201914:	00008067          	ret

0000000080201918 <rand>:

int rand(void) {
    80201918:	ff010113          	addi	sp,sp,-16
    8020191c:	00113423          	sd	ra,8(sp)
    80201920:	00813023          	sd	s0,0(sp)
    80201924:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
    80201928:	00003797          	auipc	a5,0x3
    8020192c:	7f078793          	addi	a5,a5,2032 # 80205118 <seed>
    80201930:	0007b703          	ld	a4,0(a5)
    80201934:	00001797          	auipc	a5,0x1
    80201938:	82478793          	addi	a5,a5,-2012 # 80202158 <lowerxdigits.0+0x18>
    8020193c:	0007b783          	ld	a5,0(a5)
    80201940:	02f707b3          	mul	a5,a4,a5
    80201944:	00178713          	addi	a4,a5,1
    80201948:	00003797          	auipc	a5,0x3
    8020194c:	7d078793          	addi	a5,a5,2000 # 80205118 <seed>
    80201950:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
    80201954:	00003797          	auipc	a5,0x3
    80201958:	7c478793          	addi	a5,a5,1988 # 80205118 <seed>
    8020195c:	0007b783          	ld	a5,0(a5)
    80201960:	0217d793          	srli	a5,a5,0x21
    80201964:	0007879b          	sext.w	a5,a5
}
    80201968:	00078513          	mv	a0,a5
    8020196c:	00813083          	ld	ra,8(sp)
    80201970:	00013403          	ld	s0,0(sp)
    80201974:	01010113          	addi	sp,sp,16
    80201978:	00008067          	ret

000000008020197c <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
    8020197c:	fc010113          	addi	sp,sp,-64
    80201980:	02113c23          	sd	ra,56(sp)
    80201984:	02813823          	sd	s0,48(sp)
    80201988:	04010413          	addi	s0,sp,64
    8020198c:	fca43c23          	sd	a0,-40(s0)
    80201990:	00058793          	mv	a5,a1
    80201994:	fcc43423          	sd	a2,-56(s0)
    80201998:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
    8020199c:	fd843783          	ld	a5,-40(s0)
    802019a0:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
    802019a4:	fe043423          	sd	zero,-24(s0)
    802019a8:	0280006f          	j	802019d0 <memset+0x54>
        s[i] = c;
    802019ac:	fe043703          	ld	a4,-32(s0)
    802019b0:	fe843783          	ld	a5,-24(s0)
    802019b4:	00f707b3          	add	a5,a4,a5
    802019b8:	fd442703          	lw	a4,-44(s0)
    802019bc:	0ff77713          	zext.b	a4,a4
    802019c0:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
    802019c4:	fe843783          	ld	a5,-24(s0)
    802019c8:	00178793          	addi	a5,a5,1
    802019cc:	fef43423          	sd	a5,-24(s0)
    802019d0:	fe843703          	ld	a4,-24(s0)
    802019d4:	fc843783          	ld	a5,-56(s0)
    802019d8:	fcf76ae3          	bltu	a4,a5,802019ac <memset+0x30>
    }
    return dest;
    802019dc:	fd843783          	ld	a5,-40(s0)
}
    802019e0:	00078513          	mv	a0,a5
    802019e4:	03813083          	ld	ra,56(sp)
    802019e8:	03013403          	ld	s0,48(sp)
    802019ec:	04010113          	addi	sp,sp,64
    802019f0:	00008067          	ret
