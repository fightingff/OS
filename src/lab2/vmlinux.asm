
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

    la t0, _traps
    80200008:	00003297          	auipc	t0,0x3
    8020000c:	0182b283          	ld	t0,24(t0) # 80203020 <_GLOBAL_OFFSET_TABLE_+0x18>
    csrw stvec, t0  # set stvec = _traps
    80200010:	10529073          	csrw	stvec,t0

    li t0, 32
    80200014:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
    80200018:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
    8020001c:	168000ef          	jal	80200184 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
    80200020:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
    80200024:	1002a073          	csrs	sstatus,t0

    call start_kernel
    80200028:	089000ef          	jal	802008b0 <start_kernel>

000000008020002c <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
    8020002c:	ef810113          	addi	sp,sp,-264
    sd x0, 0(sp)
    80200030:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
    80200034:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
    80200038:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
    8020003c:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
    80200040:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
    80200044:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
    80200048:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
    8020004c:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
    80200050:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
    80200054:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
    80200058:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
    8020005c:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
    80200060:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
    80200064:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
    80200068:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
    8020006c:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
    80200070:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
    80200074:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
    80200078:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
    8020007c:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
    80200080:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
    80200084:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
    80200088:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
    8020008c:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
    80200090:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
    80200094:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
    80200098:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
    8020009c:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
    802000a0:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
    802000a4:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
    802000a8:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
    802000ac:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
    802000b0:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
    802000b4:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
    802000b8:	14202573          	csrr	a0,scause
    csrr a1, sepc
    802000bc:	141025f3          	csrr	a1,sepc
    call trap_handler
    802000c0:	780000ef          	jal	80200840 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
    802000c4:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
    802000c8:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
    802000cc:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
    802000d0:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
    802000d4:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
    802000d8:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
    802000dc:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
    802000e0:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
    802000e4:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
    802000e8:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
    802000ec:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
    802000f0:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
    802000f4:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
    802000f8:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
    802000fc:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
    80200100:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
    80200104:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
    80200108:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
    8020010c:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
    80200110:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
    80200114:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
    80200118:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
    8020011c:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
    80200120:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
    80200124:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
    80200128:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
    8020012c:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
    80200130:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
    80200134:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
    80200138:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
    8020013c:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
    80200140:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
    80200144:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
    80200148:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
    8020014c:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
    80200150:	10200073          	sret

0000000080200154 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
    80200154:	fe010113          	addi	sp,sp,-32
    80200158:	00113c23          	sd	ra,24(sp)
    8020015c:	00813823          	sd	s0,16(sp)
    80200160:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
    80200164:	c01027f3          	rdtime	a5
    80200168:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
    8020016c:	fe843783          	ld	a5,-24(s0)
}
    80200170:	00078513          	mv	a0,a5
    80200174:	01813083          	ld	ra,24(sp)
    80200178:	01013403          	ld	s0,16(sp)
    8020017c:	02010113          	addi	sp,sp,32
    80200180:	00008067          	ret

0000000080200184 <clock_set_next_event>:

void clock_set_next_event() {
    80200184:	fe010113          	addi	sp,sp,-32
    80200188:	00113c23          	sd	ra,24(sp)
    8020018c:	00813823          	sd	s0,16(sp)
    80200190:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
    80200194:	fc1ff0ef          	jal	80200154 <get_cycles>
    80200198:	00050713          	mv	a4,a0
    8020019c:	00003797          	auipc	a5,0x3
    802001a0:	e6478793          	addi	a5,a5,-412 # 80203000 <TIMECLOCK>
    802001a4:	0007b783          	ld	a5,0(a5)
    802001a8:	00f707b3          	add	a5,a4,a5
    802001ac:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    802001b0:	fe843503          	ld	a0,-24(s0)
    802001b4:	4d8000ef          	jal	8020068c <sbi_set_timer>
    802001b8:	00000013          	nop
    802001bc:	01813083          	ld	ra,24(sp)
    802001c0:	01013403          	ld	s0,16(sp)
    802001c4:	02010113          	addi	sp,sp,32
    802001c8:	00008067          	ret

00000000802001cc <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
    802001cc:	fe010113          	addi	sp,sp,-32
    802001d0:	00113c23          	sd	ra,24(sp)
    802001d4:	00813823          	sd	s0,16(sp)
    802001d8:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
    802001dc:	00005797          	auipc	a5,0x5
    802001e0:	e2478793          	addi	a5,a5,-476 # 80205000 <kmem>
    802001e4:	0007b783          	ld	a5,0(a5)
    802001e8:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
    802001ec:	fe843783          	ld	a5,-24(s0)
    802001f0:	0007b703          	ld	a4,0(a5)
    802001f4:	00005797          	auipc	a5,0x5
    802001f8:	e0c78793          	addi	a5,a5,-500 # 80205000 <kmem>
    802001fc:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
    80200200:	00001637          	lui	a2,0x1
    80200204:	00000593          	li	a1,0
    80200208:	fe843503          	ld	a0,-24(s0)
    8020020c:	76c010ef          	jal	80201978 <memset>
    return (void *)r;
    80200210:	fe843783          	ld	a5,-24(s0)
}
    80200214:	00078513          	mv	a0,a5
    80200218:	01813083          	ld	ra,24(sp)
    8020021c:	01013403          	ld	s0,16(sp)
    80200220:	02010113          	addi	sp,sp,32
    80200224:	00008067          	ret

0000000080200228 <kfree>:

void kfree(void *addr) {
    80200228:	fd010113          	addi	sp,sp,-48
    8020022c:	02113423          	sd	ra,40(sp)
    80200230:	02813023          	sd	s0,32(sp)
    80200234:	03010413          	addi	s0,sp,48
    80200238:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
    8020023c:	fd843783          	ld	a5,-40(s0)
    80200240:	00078693          	mv	a3,a5
    80200244:	fd840793          	addi	a5,s0,-40
    80200248:	fffff737          	lui	a4,0xfffff
    8020024c:	00e6f733          	and	a4,a3,a4
    80200250:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
    80200254:	fd843783          	ld	a5,-40(s0)
    80200258:	00001637          	lui	a2,0x1
    8020025c:	00000593          	li	a1,0
    80200260:	00078513          	mv	a0,a5
    80200264:	714010ef          	jal	80201978 <memset>

    r = (struct run *)addr;
    80200268:	fd843783          	ld	a5,-40(s0)
    8020026c:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
    80200270:	00005797          	auipc	a5,0x5
    80200274:	d9078793          	addi	a5,a5,-624 # 80205000 <kmem>
    80200278:	0007b703          	ld	a4,0(a5)
    8020027c:	fe843783          	ld	a5,-24(s0)
    80200280:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
    80200284:	00005797          	auipc	a5,0x5
    80200288:	d7c78793          	addi	a5,a5,-644 # 80205000 <kmem>
    8020028c:	fe843703          	ld	a4,-24(s0)
    80200290:	00e7b023          	sd	a4,0(a5)

    return;
    80200294:	00000013          	nop
}
    80200298:	02813083          	ld	ra,40(sp)
    8020029c:	02013403          	ld	s0,32(sp)
    802002a0:	03010113          	addi	sp,sp,48
    802002a4:	00008067          	ret

00000000802002a8 <kfreerange>:

void kfreerange(char *start, char *end) {
    802002a8:	fd010113          	addi	sp,sp,-48
    802002ac:	02113423          	sd	ra,40(sp)
    802002b0:	02813023          	sd	s0,32(sp)
    802002b4:	03010413          	addi	s0,sp,48
    802002b8:	fca43c23          	sd	a0,-40(s0)
    802002bc:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
    802002c0:	fd843703          	ld	a4,-40(s0)
    802002c4:	000017b7          	lui	a5,0x1
    802002c8:	fff78793          	addi	a5,a5,-1 # fff <_skernel-0x801ff001>
    802002cc:	00f70733          	add	a4,a4,a5
    802002d0:	fffff7b7          	lui	a5,0xfffff
    802002d4:	00f777b3          	and	a5,a4,a5
    802002d8:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    802002dc:	01c0006f          	j	802002f8 <kfreerange+0x50>
        kfree((void *)addr);
    802002e0:	fe843503          	ld	a0,-24(s0)
    802002e4:	f45ff0ef          	jal	80200228 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
    802002e8:	fe843703          	ld	a4,-24(s0)
    802002ec:	000017b7          	lui	a5,0x1
    802002f0:	00f707b3          	add	a5,a4,a5
    802002f4:	fef43423          	sd	a5,-24(s0)
    802002f8:	fe843703          	ld	a4,-24(s0)
    802002fc:	000017b7          	lui	a5,0x1
    80200300:	00f70733          	add	a4,a4,a5
    80200304:	fd043783          	ld	a5,-48(s0)
    80200308:	fce7fce3          	bgeu	a5,a4,802002e0 <kfreerange+0x38>
    }
}
    8020030c:	00000013          	nop
    80200310:	00000013          	nop
    80200314:	02813083          	ld	ra,40(sp)
    80200318:	02013403          	ld	s0,32(sp)
    8020031c:	03010113          	addi	sp,sp,48
    80200320:	00008067          	ret

0000000080200324 <mm_init>:

void mm_init(void) {
    80200324:	ff010113          	addi	sp,sp,-16
    80200328:	00113423          	sd	ra,8(sp)
    8020032c:	00813023          	sd	s0,0(sp)
    80200330:	01010413          	addi	s0,sp,16
    kfreerange(_ekernel, (char *)PHY_END);
    80200334:	01100793          	li	a5,17
    80200338:	01b79593          	slli	a1,a5,0x1b
    8020033c:	00003517          	auipc	a0,0x3
    80200340:	cd453503          	ld	a0,-812(a0) # 80203010 <_GLOBAL_OFFSET_TABLE_+0x8>
    80200344:	f65ff0ef          	jal	802002a8 <kfreerange>
    printk("...mm_init done!\n");
    80200348:	00002517          	auipc	a0,0x2
    8020034c:	cb850513          	addi	a0,a0,-840 # 80202000 <_srodata>
    80200350:	4f8010ef          	jal	80201848 <printk>
}
    80200354:	00000013          	nop
    80200358:	00813083          	ld	ra,8(sp)
    8020035c:	00013403          	ld	s0,0(sp)
    80200360:	01010113          	addi	sp,sp,16
    80200364:	00008067          	ret

0000000080200368 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
    80200368:	ff010113          	addi	sp,sp,-16
    8020036c:	00113423          	sd	ra,8(sp)
    80200370:	00813023          	sd	s0,0(sp)
    80200374:	01010413          	addi	s0,sp,16
    srand(2024);
    80200378:	7e800513          	li	a0,2024
    8020037c:	54c010ef          	jal	802018c8 <srand>
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    printk("...task_init done!\n");
    80200380:	00002517          	auipc	a0,0x2
    80200384:	c9850513          	addi	a0,a0,-872 # 80202018 <_srodata+0x18>
    80200388:	4c0010ef          	jal	80201848 <printk>
}
    8020038c:	00000013          	nop
    80200390:	00813083          	ld	ra,8(sp)
    80200394:	00013403          	ld	s0,0(sp)
    80200398:	01010113          	addi	sp,sp,16
    8020039c:	00008067          	ret

00000000802003a0 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
    802003a0:	fd010113          	addi	sp,sp,-48
    802003a4:	02113423          	sd	ra,40(sp)
    802003a8:	02813023          	sd	s0,32(sp)
    802003ac:	03010413          	addi	s0,sp,48
    uint64_t MOD = 1000000007;
    802003b0:	3b9ad7b7          	lui	a5,0x3b9ad
    802003b4:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <_skernel-0x448535f9>
    802003b8:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
    802003bc:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
    802003c0:	fff00793          	li	a5,-1
    802003c4:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    802003c8:	fe442783          	lw	a5,-28(s0)
    802003cc:	0007871b          	sext.w	a4,a5
    802003d0:	fff00793          	li	a5,-1
    802003d4:	00f70e63          	beq	a4,a5,802003f0 <dummy+0x50>
    802003d8:	00005797          	auipc	a5,0x5
    802003dc:	c3878793          	addi	a5,a5,-968 # 80205010 <current>
    802003e0:	0007b783          	ld	a5,0(a5)
    802003e4:	0087b703          	ld	a4,8(a5)
    802003e8:	fe442783          	lw	a5,-28(s0)
    802003ec:	fcf70ee3          	beq	a4,a5,802003c8 <dummy+0x28>
    802003f0:	00005797          	auipc	a5,0x5
    802003f4:	c2078793          	addi	a5,a5,-992 # 80205010 <current>
    802003f8:	0007b783          	ld	a5,0(a5)
    802003fc:	0087b783          	ld	a5,8(a5)
    80200400:	fc0784e3          	beqz	a5,802003c8 <dummy+0x28>
            if (current->counter == 1) {
    80200404:	00005797          	auipc	a5,0x5
    80200408:	c0c78793          	addi	a5,a5,-1012 # 80205010 <current>
    8020040c:	0007b783          	ld	a5,0(a5)
    80200410:	0087b703          	ld	a4,8(a5)
    80200414:	00100793          	li	a5,1
    80200418:	00f71e63          	bne	a4,a5,80200434 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
    8020041c:	00005797          	auipc	a5,0x5
    80200420:	bf478793          	addi	a5,a5,-1036 # 80205010 <current>
    80200424:	0007b783          	ld	a5,0(a5)
    80200428:	0087b703          	ld	a4,8(a5)
    8020042c:	fff70713          	addi	a4,a4,-1 # ffffffffffffefff <_ebss+0xffffffff7fdf9edf>
    80200430:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
    80200434:	00005797          	auipc	a5,0x5
    80200438:	bdc78793          	addi	a5,a5,-1060 # 80205010 <current>
    8020043c:	0007b783          	ld	a5,0(a5)
    80200440:	0087b783          	ld	a5,8(a5)
    80200444:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
    80200448:	fe843783          	ld	a5,-24(s0)
    8020044c:	00178713          	addi	a4,a5,1
    80200450:	fd843783          	ld	a5,-40(s0)
    80200454:	02f777b3          	remu	a5,a4,a5
    80200458:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
    8020045c:	00005797          	auipc	a5,0x5
    80200460:	bb478793          	addi	a5,a5,-1100 # 80205010 <current>
    80200464:	0007b783          	ld	a5,0(a5)
    80200468:	0187b783          	ld	a5,24(a5)
    8020046c:	fe843603          	ld	a2,-24(s0)
    80200470:	00078593          	mv	a1,a5
    80200474:	00002517          	auipc	a0,0x2
    80200478:	bbc50513          	addi	a0,a0,-1092 # 80202030 <_srodata+0x30>
    8020047c:	3cc010ef          	jal	80201848 <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
    80200480:	f49ff06f          	j	802003c8 <dummy+0x28>

0000000080200484 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    80200484:	f7010113          	addi	sp,sp,-144
    80200488:	08113423          	sd	ra,136(sp)
    8020048c:	08813023          	sd	s0,128(sp)
    80200490:	06913c23          	sd	s1,120(sp)
    80200494:	07213823          	sd	s2,112(sp)
    80200498:	07313423          	sd	s3,104(sp)
    8020049c:	09010413          	addi	s0,sp,144
    802004a0:	faa43423          	sd	a0,-88(s0)
    802004a4:	fab43023          	sd	a1,-96(s0)
    802004a8:	f8c43c23          	sd	a2,-104(s0)
    802004ac:	f8d43823          	sd	a3,-112(s0)
    802004b0:	f8e43423          	sd	a4,-120(s0)
    802004b4:	f8f43023          	sd	a5,-128(s0)
    802004b8:	f7043c23          	sd	a6,-136(s0)
    802004bc:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    802004c0:	fa843e03          	ld	t3,-88(s0)
    802004c4:	fa043e83          	ld	t4,-96(s0)
    802004c8:	f9843f03          	ld	t5,-104(s0)
    802004cc:	f9043f83          	ld	t6,-112(s0)
    802004d0:	f8843283          	ld	t0,-120(s0)
    802004d4:	f8043483          	ld	s1,-128(s0)
    802004d8:	f7843903          	ld	s2,-136(s0)
    802004dc:	f7043983          	ld	s3,-144(s0)
    802004e0:	000e0893          	mv	a7,t3
    802004e4:	000e8813          	mv	a6,t4
    802004e8:	000f0513          	mv	a0,t5
    802004ec:	000f8593          	mv	a1,t6
    802004f0:	00028613          	mv	a2,t0
    802004f4:	00048693          	mv	a3,s1
    802004f8:	00090713          	mv	a4,s2
    802004fc:	00098793          	mv	a5,s3
    80200500:	00000073          	ecall
    80200504:	00050e93          	mv	t4,a0
    80200508:	00058e13          	mv	t3,a1
    8020050c:	fbd43823          	sd	t4,-80(s0)
    80200510:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    80200514:	fb043783          	ld	a5,-80(s0)
    80200518:	fcf43023          	sd	a5,-64(s0)
    8020051c:	fb843783          	ld	a5,-72(s0)
    80200520:	fcf43423          	sd	a5,-56(s0)
    80200524:	fc043703          	ld	a4,-64(s0)
    80200528:	fc843783          	ld	a5,-56(s0)
    8020052c:	00070313          	mv	t1,a4
    80200530:	00078393          	mv	t2,a5
    80200534:	00030713          	mv	a4,t1
    80200538:	00038793          	mv	a5,t2
}
    8020053c:	00070513          	mv	a0,a4
    80200540:	00078593          	mv	a1,a5
    80200544:	08813083          	ld	ra,136(sp)
    80200548:	08013403          	ld	s0,128(sp)
    8020054c:	07813483          	ld	s1,120(sp)
    80200550:	07013903          	ld	s2,112(sp)
    80200554:	06813983          	ld	s3,104(sp)
    80200558:	09010113          	addi	sp,sp,144
    8020055c:	00008067          	ret

0000000080200560 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    80200560:	fc010113          	addi	sp,sp,-64
    80200564:	02113c23          	sd	ra,56(sp)
    80200568:	02813823          	sd	s0,48(sp)
    8020056c:	03213423          	sd	s2,40(sp)
    80200570:	03313023          	sd	s3,32(sp)
    80200574:	04010413          	addi	s0,sp,64
    80200578:	00050793          	mv	a5,a0
    8020057c:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200580:	fcf44603          	lbu	a2,-49(s0)
    80200584:	00000893          	li	a7,0
    80200588:	00000813          	li	a6,0
    8020058c:	00000793          	li	a5,0
    80200590:	00000713          	li	a4,0
    80200594:	00000693          	li	a3,0
    80200598:	00200593          	li	a1,2
    8020059c:	44424537          	lui	a0,0x44424
    802005a0:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802005a4:	ee1ff0ef          	jal	80200484 <sbi_ecall>
    802005a8:	00050713          	mv	a4,a0
    802005ac:	00058793          	mv	a5,a1
    802005b0:	fce43823          	sd	a4,-48(s0)
    802005b4:	fcf43c23          	sd	a5,-40(s0)
    802005b8:	fd043703          	ld	a4,-48(s0)
    802005bc:	fd843783          	ld	a5,-40(s0)
    802005c0:	00070913          	mv	s2,a4
    802005c4:	00078993          	mv	s3,a5
    802005c8:	00090713          	mv	a4,s2
    802005cc:	00098793          	mv	a5,s3
}
    802005d0:	00070513          	mv	a0,a4
    802005d4:	00078593          	mv	a1,a5
    802005d8:	03813083          	ld	ra,56(sp)
    802005dc:	03013403          	ld	s0,48(sp)
    802005e0:	02813903          	ld	s2,40(sp)
    802005e4:	02013983          	ld	s3,32(sp)
    802005e8:	04010113          	addi	sp,sp,64
    802005ec:	00008067          	ret

00000000802005f0 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    802005f0:	fc010113          	addi	sp,sp,-64
    802005f4:	02113c23          	sd	ra,56(sp)
    802005f8:	02813823          	sd	s0,48(sp)
    802005fc:	03213423          	sd	s2,40(sp)
    80200600:	03313023          	sd	s3,32(sp)
    80200604:	04010413          	addi	s0,sp,64
    80200608:	00050793          	mv	a5,a0
    8020060c:	00058713          	mv	a4,a1
    80200610:	fcf42623          	sw	a5,-52(s0)
    80200614:	00070793          	mv	a5,a4
    80200618:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    8020061c:	fcc46603          	lwu	a2,-52(s0)
    80200620:	fc846683          	lwu	a3,-56(s0)
    80200624:	00000893          	li	a7,0
    80200628:	00000813          	li	a6,0
    8020062c:	00000793          	li	a5,0
    80200630:	00000713          	li	a4,0
    80200634:	00000593          	li	a1,0
    80200638:	53525537          	lui	a0,0x53525
    8020063c:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200640:	e45ff0ef          	jal	80200484 <sbi_ecall>
    80200644:	00050713          	mv	a4,a0
    80200648:	00058793          	mv	a5,a1
    8020064c:	fce43823          	sd	a4,-48(s0)
    80200650:	fcf43c23          	sd	a5,-40(s0)
    80200654:	fd043703          	ld	a4,-48(s0)
    80200658:	fd843783          	ld	a5,-40(s0)
    8020065c:	00070913          	mv	s2,a4
    80200660:	00078993          	mv	s3,a5
    80200664:	00090713          	mv	a4,s2
    80200668:	00098793          	mv	a5,s3
}
    8020066c:	00070513          	mv	a0,a4
    80200670:	00078593          	mv	a1,a5
    80200674:	03813083          	ld	ra,56(sp)
    80200678:	03013403          	ld	s0,48(sp)
    8020067c:	02813903          	ld	s2,40(sp)
    80200680:	02013983          	ld	s3,32(sp)
    80200684:	04010113          	addi	sp,sp,64
    80200688:	00008067          	ret

000000008020068c <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    8020068c:	fc010113          	addi	sp,sp,-64
    80200690:	02113c23          	sd	ra,56(sp)
    80200694:	02813823          	sd	s0,48(sp)
    80200698:	03213423          	sd	s2,40(sp)
    8020069c:	03313023          	sd	s3,32(sp)
    802006a0:	04010413          	addi	s0,sp,64
    802006a4:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    802006a8:	00000893          	li	a7,0
    802006ac:	00000813          	li	a6,0
    802006b0:	00000793          	li	a5,0
    802006b4:	00000713          	li	a4,0
    802006b8:	00000693          	li	a3,0
    802006bc:	fc843603          	ld	a2,-56(s0)
    802006c0:	00000593          	li	a1,0
    802006c4:	54495537          	lui	a0,0x54495
    802006c8:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    802006cc:	db9ff0ef          	jal	80200484 <sbi_ecall>
    802006d0:	00050713          	mv	a4,a0
    802006d4:	00058793          	mv	a5,a1
    802006d8:	fce43823          	sd	a4,-48(s0)
    802006dc:	fcf43c23          	sd	a5,-40(s0)
    802006e0:	fd043703          	ld	a4,-48(s0)
    802006e4:	fd843783          	ld	a5,-40(s0)
    802006e8:	00070913          	mv	s2,a4
    802006ec:	00078993          	mv	s3,a5
    802006f0:	00090713          	mv	a4,s2
    802006f4:	00098793          	mv	a5,s3
}
    802006f8:	00070513          	mv	a0,a4
    802006fc:	00078593          	mv	a1,a5
    80200700:	03813083          	ld	ra,56(sp)
    80200704:	03013403          	ld	s0,48(sp)
    80200708:	02813903          	ld	s2,40(sp)
    8020070c:	02013983          	ld	s3,32(sp)
    80200710:	04010113          	addi	sp,sp,64
    80200714:	00008067          	ret

0000000080200718 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    80200718:	fb010113          	addi	sp,sp,-80
    8020071c:	04113423          	sd	ra,72(sp)
    80200720:	04813023          	sd	s0,64(sp)
    80200724:	03213c23          	sd	s2,56(sp)
    80200728:	03313823          	sd	s3,48(sp)
    8020072c:	05010413          	addi	s0,sp,80
    80200730:	fca43423          	sd	a0,-56(s0)
    80200734:	fcb43023          	sd	a1,-64(s0)
    80200738:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    8020073c:	00000893          	li	a7,0
    80200740:	00000813          	li	a6,0
    80200744:	00000793          	li	a5,0
    80200748:	fb843703          	ld	a4,-72(s0)
    8020074c:	fc043683          	ld	a3,-64(s0)
    80200750:	fc843603          	ld	a2,-56(s0)
    80200754:	00100593          	li	a1,1
    80200758:	44424537          	lui	a0,0x44424
    8020075c:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200760:	d25ff0ef          	jal	80200484 <sbi_ecall>
    80200764:	00050713          	mv	a4,a0
    80200768:	00058793          	mv	a5,a1
    8020076c:	fce43823          	sd	a4,-48(s0)
    80200770:	fcf43c23          	sd	a5,-40(s0)
    80200774:	fd043703          	ld	a4,-48(s0)
    80200778:	fd843783          	ld	a5,-40(s0)
    8020077c:	00070913          	mv	s2,a4
    80200780:	00078993          	mv	s3,a5
    80200784:	00090713          	mv	a4,s2
    80200788:	00098793          	mv	a5,s3
}
    8020078c:	00070513          	mv	a0,a4
    80200790:	00078593          	mv	a1,a5
    80200794:	04813083          	ld	ra,72(sp)
    80200798:	04013403          	ld	s0,64(sp)
    8020079c:	03813903          	ld	s2,56(sp)
    802007a0:	03013983          	ld	s3,48(sp)
    802007a4:	05010113          	addi	sp,sp,80
    802007a8:	00008067          	ret

00000000802007ac <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    802007ac:	fb010113          	addi	sp,sp,-80
    802007b0:	04113423          	sd	ra,72(sp)
    802007b4:	04813023          	sd	s0,64(sp)
    802007b8:	03213c23          	sd	s2,56(sp)
    802007bc:	03313823          	sd	s3,48(sp)
    802007c0:	05010413          	addi	s0,sp,80
    802007c4:	fca43423          	sd	a0,-56(s0)
    802007c8:	fcb43023          	sd	a1,-64(s0)
    802007cc:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    802007d0:	00000893          	li	a7,0
    802007d4:	00000813          	li	a6,0
    802007d8:	00000793          	li	a5,0
    802007dc:	fb843703          	ld	a4,-72(s0)
    802007e0:	fc043683          	ld	a3,-64(s0)
    802007e4:	fc843603          	ld	a2,-56(s0)
    802007e8:	00000593          	li	a1,0
    802007ec:	44424537          	lui	a0,0x44424
    802007f0:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802007f4:	c91ff0ef          	jal	80200484 <sbi_ecall>
    802007f8:	00050713          	mv	a4,a0
    802007fc:	00058793          	mv	a5,a1
    80200800:	fce43823          	sd	a4,-48(s0)
    80200804:	fcf43c23          	sd	a5,-40(s0)
    80200808:	fd043703          	ld	a4,-48(s0)
    8020080c:	fd843783          	ld	a5,-40(s0)
    80200810:	00070913          	mv	s2,a4
    80200814:	00078993          	mv	s3,a5
    80200818:	00090713          	mv	a4,s2
    8020081c:	00098793          	mv	a5,s3
    80200820:	00070513          	mv	a0,a4
    80200824:	00078593          	mv	a1,a5
    80200828:	04813083          	ld	ra,72(sp)
    8020082c:	04013403          	ld	s0,64(sp)
    80200830:	03813903          	ld	s2,56(sp)
    80200834:	03013983          	ld	s3,48(sp)
    80200838:	05010113          	addi	sp,sp,80
    8020083c:	00008067          	ret

0000000080200840 <trap_handler>:
#include "stdint.h"
#include "trap.h"
#include "printk.h"
#include "clock.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200840:	fe010113          	addi	sp,sp,-32
    80200844:	00113c23          	sd	ra,24(sp)
    80200848:	00813823          	sd	s0,16(sp)
    8020084c:	02010413          	addi	s0,sp,32
    80200850:	fea43423          	sd	a0,-24(s0)
    80200854:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    80200858:	fe843783          	ld	a5,-24(s0)
    8020085c:	0207d463          	bgez	a5,80200884 <trap_handler+0x44>
    80200860:	fe843783          	ld	a5,-24(s0)
    80200864:	0ff7f713          	zext.b	a4,a5
    80200868:	00500793          	li	a5,5
    8020086c:	00f71c63          	bne	a4,a5,80200884 <trap_handler+0x44>
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        printk("[S] Supervisor Mode Timer Interrupt\n");
    80200870:	00001517          	auipc	a0,0x1
    80200874:	7f050513          	addi	a0,a0,2032 # 80202060 <_srodata+0x60>
    80200878:	7d1000ef          	jal	80201848 <printk>
        // 设置下一次时钟中断
        clock_set_next_event();
    8020087c:	909ff0ef          	jal	80200184 <clock_set_next_event>
    80200880:	01c0006f          	j	8020089c <trap_handler+0x5c>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    80200884:	fe043603          	ld	a2,-32(s0)
    80200888:	fe843583          	ld	a1,-24(s0)
    8020088c:	00001517          	auipc	a0,0x1
    80200890:	7fc50513          	addi	a0,a0,2044 # 80202088 <_srodata+0x88>
    80200894:	7b5000ef          	jal	80201848 <printk>
    }
    80200898:	00000013          	nop
    8020089c:	00000013          	nop
    802008a0:	01813083          	ld	ra,24(sp)
    802008a4:	01013403          	ld	s0,16(sp)
    802008a8:	02010113          	addi	sp,sp,32
    802008ac:	00008067          	ret

00000000802008b0 <start_kernel>:
#include "printk.h"
#include "defs.h"

extern void test();

int start_kernel() {
    802008b0:	ff010113          	addi	sp,sp,-16
    802008b4:	00113423          	sd	ra,8(sp)
    802008b8:	00813023          	sd	s0,0(sp)
    802008bc:	01010413          	addi	s0,sp,16
    printk("2024");
    802008c0:	00002517          	auipc	a0,0x2
    802008c4:	80850513          	addi	a0,a0,-2040 # 802020c8 <_srodata+0xc8>
    802008c8:	781000ef          	jal	80201848 <printk>
    printk(" ZJU Operating System\n");
    802008cc:	00002517          	auipc	a0,0x2
    802008d0:	80450513          	addi	a0,a0,-2044 # 802020d0 <_srodata+0xd0>
    802008d4:	775000ef          	jal	80201848 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    test();
    802008d8:	038000ef          	jal	80200910 <test>
    return 0;
    802008dc:	00000793          	li	a5,0
}
    802008e0:	00078513          	mv	a0,a5
    802008e4:	00813083          	ld	ra,8(sp)
    802008e8:	00013403          	ld	s0,0(sp)
    802008ec:	01010113          	addi	sp,sp,16
    802008f0:	00008067          	ret

00000000802008f4 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
    802008f4:	ff010113          	addi	sp,sp,-16
    802008f8:	00113423          	sd	ra,8(sp)
    802008fc:	00813023          	sd	s0,0(sp)
    80200900:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200904:	00000593          	li	a1,0
    80200908:	00000513          	li	a0,0
    8020090c:	ce5ff0ef          	jal	802005f0 <sbi_system_reset>

0000000080200910 <test>:
    __builtin_unreachable();
}

void test() {
    80200910:	fe010113          	addi	sp,sp,-32
    80200914:	00113c23          	sd	ra,24(sp)
    80200918:	00813823          	sd	s0,16(sp)
    8020091c:	02010413          	addi	s0,sp,32
    int i = 0;
    80200920:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
    80200924:	fec42783          	lw	a5,-20(s0)
    80200928:	0017879b          	addiw	a5,a5,1
    8020092c:	fef42623          	sw	a5,-20(s0)
    80200930:	fec42783          	lw	a5,-20(s0)
    80200934:	0007869b          	sext.w	a3,a5
    80200938:	55e64737          	lui	a4,0x55e64
    8020093c:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <_skernel-0x2a39c477>
    80200940:	02e68733          	mul	a4,a3,a4
    80200944:	02075713          	srli	a4,a4,0x20
    80200948:	4197571b          	sraiw	a4,a4,0x19
    8020094c:	00070693          	mv	a3,a4
    80200950:	41f7d71b          	sraiw	a4,a5,0x1f
    80200954:	40e6873b          	subw	a4,a3,a4
    80200958:	00070693          	mv	a3,a4
    8020095c:	05f5e737          	lui	a4,0x5f5e
    80200960:	1007071b          	addiw	a4,a4,256 # 5f5e100 <_skernel-0x7a2a1f00>
    80200964:	02e6873b          	mulw	a4,a3,a4
    80200968:	40e787bb          	subw	a5,a5,a4
    8020096c:	0007879b          	sext.w	a5,a5
    80200970:	fa079ae3          	bnez	a5,80200924 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
    80200974:	00001517          	auipc	a0,0x1
    80200978:	77450513          	addi	a0,a0,1908 # 802020e8 <_srodata+0xe8>
    8020097c:	6cd000ef          	jal	80201848 <printk>
            i = 0;
    80200980:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
    80200984:	fa1ff06f          	j	80200924 <test+0x14>

0000000080200988 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    80200988:	fe010113          	addi	sp,sp,-32
    8020098c:	00113c23          	sd	ra,24(sp)
    80200990:	00813823          	sd	s0,16(sp)
    80200994:	02010413          	addi	s0,sp,32
    80200998:	00050793          	mv	a5,a0
    8020099c:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    802009a0:	fec42783          	lw	a5,-20(s0)
    802009a4:	0ff7f793          	zext.b	a5,a5
    802009a8:	00078513          	mv	a0,a5
    802009ac:	bb5ff0ef          	jal	80200560 <sbi_debug_console_write_byte>
    return (char)c;
    802009b0:	fec42783          	lw	a5,-20(s0)
    802009b4:	0ff7f793          	zext.b	a5,a5
    802009b8:	0007879b          	sext.w	a5,a5
}
    802009bc:	00078513          	mv	a0,a5
    802009c0:	01813083          	ld	ra,24(sp)
    802009c4:	01013403          	ld	s0,16(sp)
    802009c8:	02010113          	addi	sp,sp,32
    802009cc:	00008067          	ret

00000000802009d0 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    802009d0:	fe010113          	addi	sp,sp,-32
    802009d4:	00113c23          	sd	ra,24(sp)
    802009d8:	00813823          	sd	s0,16(sp)
    802009dc:	02010413          	addi	s0,sp,32
    802009e0:	00050793          	mv	a5,a0
    802009e4:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    802009e8:	fec42783          	lw	a5,-20(s0)
    802009ec:	0007871b          	sext.w	a4,a5
    802009f0:	02000793          	li	a5,32
    802009f4:	02f70263          	beq	a4,a5,80200a18 <isspace+0x48>
    802009f8:	fec42783          	lw	a5,-20(s0)
    802009fc:	0007871b          	sext.w	a4,a5
    80200a00:	00800793          	li	a5,8
    80200a04:	00e7de63          	bge	a5,a4,80200a20 <isspace+0x50>
    80200a08:	fec42783          	lw	a5,-20(s0)
    80200a0c:	0007871b          	sext.w	a4,a5
    80200a10:	00d00793          	li	a5,13
    80200a14:	00e7c663          	blt	a5,a4,80200a20 <isspace+0x50>
    80200a18:	00100793          	li	a5,1
    80200a1c:	0080006f          	j	80200a24 <isspace+0x54>
    80200a20:	00000793          	li	a5,0
}
    80200a24:	00078513          	mv	a0,a5
    80200a28:	01813083          	ld	ra,24(sp)
    80200a2c:	01013403          	ld	s0,16(sp)
    80200a30:	02010113          	addi	sp,sp,32
    80200a34:	00008067          	ret

0000000080200a38 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80200a38:	fb010113          	addi	sp,sp,-80
    80200a3c:	04113423          	sd	ra,72(sp)
    80200a40:	04813023          	sd	s0,64(sp)
    80200a44:	05010413          	addi	s0,sp,80
    80200a48:	fca43423          	sd	a0,-56(s0)
    80200a4c:	fcb43023          	sd	a1,-64(s0)
    80200a50:	00060793          	mv	a5,a2
    80200a54:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    80200a58:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    80200a5c:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    80200a60:	fc843783          	ld	a5,-56(s0)
    80200a64:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    80200a68:	0100006f          	j	80200a78 <strtol+0x40>
        p++;
    80200a6c:	fd843783          	ld	a5,-40(s0)
    80200a70:	00178793          	addi	a5,a5,1
    80200a74:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    80200a78:	fd843783          	ld	a5,-40(s0)
    80200a7c:	0007c783          	lbu	a5,0(a5)
    80200a80:	0007879b          	sext.w	a5,a5
    80200a84:	00078513          	mv	a0,a5
    80200a88:	f49ff0ef          	jal	802009d0 <isspace>
    80200a8c:	00050793          	mv	a5,a0
    80200a90:	fc079ee3          	bnez	a5,80200a6c <strtol+0x34>
    }

    if (*p == '-') {
    80200a94:	fd843783          	ld	a5,-40(s0)
    80200a98:	0007c783          	lbu	a5,0(a5)
    80200a9c:	00078713          	mv	a4,a5
    80200aa0:	02d00793          	li	a5,45
    80200aa4:	00f71e63          	bne	a4,a5,80200ac0 <strtol+0x88>
        neg = true;
    80200aa8:	00100793          	li	a5,1
    80200aac:	fef403a3          	sb	a5,-25(s0)
        p++;
    80200ab0:	fd843783          	ld	a5,-40(s0)
    80200ab4:	00178793          	addi	a5,a5,1
    80200ab8:	fcf43c23          	sd	a5,-40(s0)
    80200abc:	0240006f          	j	80200ae0 <strtol+0xa8>
    } else if (*p == '+') {
    80200ac0:	fd843783          	ld	a5,-40(s0)
    80200ac4:	0007c783          	lbu	a5,0(a5)
    80200ac8:	00078713          	mv	a4,a5
    80200acc:	02b00793          	li	a5,43
    80200ad0:	00f71863          	bne	a4,a5,80200ae0 <strtol+0xa8>
        p++;
    80200ad4:	fd843783          	ld	a5,-40(s0)
    80200ad8:	00178793          	addi	a5,a5,1
    80200adc:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    80200ae0:	fbc42783          	lw	a5,-68(s0)
    80200ae4:	0007879b          	sext.w	a5,a5
    80200ae8:	06079c63          	bnez	a5,80200b60 <strtol+0x128>
        if (*p == '0') {
    80200aec:	fd843783          	ld	a5,-40(s0)
    80200af0:	0007c783          	lbu	a5,0(a5)
    80200af4:	00078713          	mv	a4,a5
    80200af8:	03000793          	li	a5,48
    80200afc:	04f71e63          	bne	a4,a5,80200b58 <strtol+0x120>
            p++;
    80200b00:	fd843783          	ld	a5,-40(s0)
    80200b04:	00178793          	addi	a5,a5,1
    80200b08:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80200b0c:	fd843783          	ld	a5,-40(s0)
    80200b10:	0007c783          	lbu	a5,0(a5)
    80200b14:	00078713          	mv	a4,a5
    80200b18:	07800793          	li	a5,120
    80200b1c:	00f70c63          	beq	a4,a5,80200b34 <strtol+0xfc>
    80200b20:	fd843783          	ld	a5,-40(s0)
    80200b24:	0007c783          	lbu	a5,0(a5)
    80200b28:	00078713          	mv	a4,a5
    80200b2c:	05800793          	li	a5,88
    80200b30:	00f71e63          	bne	a4,a5,80200b4c <strtol+0x114>
                base = 16;
    80200b34:	01000793          	li	a5,16
    80200b38:	faf42e23          	sw	a5,-68(s0)
                p++;
    80200b3c:	fd843783          	ld	a5,-40(s0)
    80200b40:	00178793          	addi	a5,a5,1
    80200b44:	fcf43c23          	sd	a5,-40(s0)
    80200b48:	0180006f          	j	80200b60 <strtol+0x128>
            } else {
                base = 8;
    80200b4c:	00800793          	li	a5,8
    80200b50:	faf42e23          	sw	a5,-68(s0)
    80200b54:	00c0006f          	j	80200b60 <strtol+0x128>
            }
        } else {
            base = 10;
    80200b58:	00a00793          	li	a5,10
    80200b5c:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    80200b60:	fd843783          	ld	a5,-40(s0)
    80200b64:	0007c783          	lbu	a5,0(a5)
    80200b68:	00078713          	mv	a4,a5
    80200b6c:	02f00793          	li	a5,47
    80200b70:	02e7f863          	bgeu	a5,a4,80200ba0 <strtol+0x168>
    80200b74:	fd843783          	ld	a5,-40(s0)
    80200b78:	0007c783          	lbu	a5,0(a5)
    80200b7c:	00078713          	mv	a4,a5
    80200b80:	03900793          	li	a5,57
    80200b84:	00e7ee63          	bltu	a5,a4,80200ba0 <strtol+0x168>
            digit = *p - '0';
    80200b88:	fd843783          	ld	a5,-40(s0)
    80200b8c:	0007c783          	lbu	a5,0(a5)
    80200b90:	0007879b          	sext.w	a5,a5
    80200b94:	fd07879b          	addiw	a5,a5,-48
    80200b98:	fcf42a23          	sw	a5,-44(s0)
    80200b9c:	0800006f          	j	80200c1c <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    80200ba0:	fd843783          	ld	a5,-40(s0)
    80200ba4:	0007c783          	lbu	a5,0(a5)
    80200ba8:	00078713          	mv	a4,a5
    80200bac:	06000793          	li	a5,96
    80200bb0:	02e7f863          	bgeu	a5,a4,80200be0 <strtol+0x1a8>
    80200bb4:	fd843783          	ld	a5,-40(s0)
    80200bb8:	0007c783          	lbu	a5,0(a5)
    80200bbc:	00078713          	mv	a4,a5
    80200bc0:	07a00793          	li	a5,122
    80200bc4:	00e7ee63          	bltu	a5,a4,80200be0 <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80200bc8:	fd843783          	ld	a5,-40(s0)
    80200bcc:	0007c783          	lbu	a5,0(a5)
    80200bd0:	0007879b          	sext.w	a5,a5
    80200bd4:	fa97879b          	addiw	a5,a5,-87
    80200bd8:	fcf42a23          	sw	a5,-44(s0)
    80200bdc:	0400006f          	j	80200c1c <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    80200be0:	fd843783          	ld	a5,-40(s0)
    80200be4:	0007c783          	lbu	a5,0(a5)
    80200be8:	00078713          	mv	a4,a5
    80200bec:	04000793          	li	a5,64
    80200bf0:	06e7f863          	bgeu	a5,a4,80200c60 <strtol+0x228>
    80200bf4:	fd843783          	ld	a5,-40(s0)
    80200bf8:	0007c783          	lbu	a5,0(a5)
    80200bfc:	00078713          	mv	a4,a5
    80200c00:	05a00793          	li	a5,90
    80200c04:	04e7ee63          	bltu	a5,a4,80200c60 <strtol+0x228>
            digit = *p - ('A' - 10);
    80200c08:	fd843783          	ld	a5,-40(s0)
    80200c0c:	0007c783          	lbu	a5,0(a5)
    80200c10:	0007879b          	sext.w	a5,a5
    80200c14:	fc97879b          	addiw	a5,a5,-55
    80200c18:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80200c1c:	fd442783          	lw	a5,-44(s0)
    80200c20:	00078713          	mv	a4,a5
    80200c24:	fbc42783          	lw	a5,-68(s0)
    80200c28:	0007071b          	sext.w	a4,a4
    80200c2c:	0007879b          	sext.w	a5,a5
    80200c30:	02f75663          	bge	a4,a5,80200c5c <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80200c34:	fbc42703          	lw	a4,-68(s0)
    80200c38:	fe843783          	ld	a5,-24(s0)
    80200c3c:	02f70733          	mul	a4,a4,a5
    80200c40:	fd442783          	lw	a5,-44(s0)
    80200c44:	00f707b3          	add	a5,a4,a5
    80200c48:	fef43423          	sd	a5,-24(s0)
        p++;
    80200c4c:	fd843783          	ld	a5,-40(s0)
    80200c50:	00178793          	addi	a5,a5,1
    80200c54:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    80200c58:	f09ff06f          	j	80200b60 <strtol+0x128>
            break;
    80200c5c:	00000013          	nop
    }

    if (endptr) {
    80200c60:	fc043783          	ld	a5,-64(s0)
    80200c64:	00078863          	beqz	a5,80200c74 <strtol+0x23c>
        *endptr = (char *)p;
    80200c68:	fc043783          	ld	a5,-64(s0)
    80200c6c:	fd843703          	ld	a4,-40(s0)
    80200c70:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    80200c74:	fe744783          	lbu	a5,-25(s0)
    80200c78:	0ff7f793          	zext.b	a5,a5
    80200c7c:	00078863          	beqz	a5,80200c8c <strtol+0x254>
    80200c80:	fe843783          	ld	a5,-24(s0)
    80200c84:	40f007b3          	neg	a5,a5
    80200c88:	0080006f          	j	80200c90 <strtol+0x258>
    80200c8c:	fe843783          	ld	a5,-24(s0)
}
    80200c90:	00078513          	mv	a0,a5
    80200c94:	04813083          	ld	ra,72(sp)
    80200c98:	04013403          	ld	s0,64(sp)
    80200c9c:	05010113          	addi	sp,sp,80
    80200ca0:	00008067          	ret

0000000080200ca4 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    80200ca4:	fd010113          	addi	sp,sp,-48
    80200ca8:	02113423          	sd	ra,40(sp)
    80200cac:	02813023          	sd	s0,32(sp)
    80200cb0:	03010413          	addi	s0,sp,48
    80200cb4:	fca43c23          	sd	a0,-40(s0)
    80200cb8:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    80200cbc:	fd043783          	ld	a5,-48(s0)
    80200cc0:	00079863          	bnez	a5,80200cd0 <puts_wo_nl+0x2c>
        s = "(null)";
    80200cc4:	00001797          	auipc	a5,0x1
    80200cc8:	43c78793          	addi	a5,a5,1084 # 80202100 <_srodata+0x100>
    80200ccc:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    80200cd0:	fd043783          	ld	a5,-48(s0)
    80200cd4:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80200cd8:	0240006f          	j	80200cfc <puts_wo_nl+0x58>
        putch(*p++);
    80200cdc:	fe843783          	ld	a5,-24(s0)
    80200ce0:	00178713          	addi	a4,a5,1
    80200ce4:	fee43423          	sd	a4,-24(s0)
    80200ce8:	0007c783          	lbu	a5,0(a5)
    80200cec:	0007871b          	sext.w	a4,a5
    80200cf0:	fd843783          	ld	a5,-40(s0)
    80200cf4:	00070513          	mv	a0,a4
    80200cf8:	000780e7          	jalr	a5
    while (*p) {
    80200cfc:	fe843783          	ld	a5,-24(s0)
    80200d00:	0007c783          	lbu	a5,0(a5)
    80200d04:	fc079ce3          	bnez	a5,80200cdc <puts_wo_nl+0x38>
    }
    return p - s;
    80200d08:	fe843703          	ld	a4,-24(s0)
    80200d0c:	fd043783          	ld	a5,-48(s0)
    80200d10:	40f707b3          	sub	a5,a4,a5
    80200d14:	0007879b          	sext.w	a5,a5
}
    80200d18:	00078513          	mv	a0,a5
    80200d1c:	02813083          	ld	ra,40(sp)
    80200d20:	02013403          	ld	s0,32(sp)
    80200d24:	03010113          	addi	sp,sp,48
    80200d28:	00008067          	ret

0000000080200d2c <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    80200d2c:	f9010113          	addi	sp,sp,-112
    80200d30:	06113423          	sd	ra,104(sp)
    80200d34:	06813023          	sd	s0,96(sp)
    80200d38:	07010413          	addi	s0,sp,112
    80200d3c:	faa43423          	sd	a0,-88(s0)
    80200d40:	fab43023          	sd	a1,-96(s0)
    80200d44:	00060793          	mv	a5,a2
    80200d48:	f8d43823          	sd	a3,-112(s0)
    80200d4c:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    80200d50:	f9f44783          	lbu	a5,-97(s0)
    80200d54:	0ff7f793          	zext.b	a5,a5
    80200d58:	02078663          	beqz	a5,80200d84 <print_dec_int+0x58>
    80200d5c:	fa043703          	ld	a4,-96(s0)
    80200d60:	fff00793          	li	a5,-1
    80200d64:	03f79793          	slli	a5,a5,0x3f
    80200d68:	00f71e63          	bne	a4,a5,80200d84 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    80200d6c:	00001597          	auipc	a1,0x1
    80200d70:	39c58593          	addi	a1,a1,924 # 80202108 <_srodata+0x108>
    80200d74:	fa843503          	ld	a0,-88(s0)
    80200d78:	f2dff0ef          	jal	80200ca4 <puts_wo_nl>
    80200d7c:	00050793          	mv	a5,a0
    80200d80:	2c80006f          	j	80201048 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    80200d84:	f9043783          	ld	a5,-112(s0)
    80200d88:	00c7a783          	lw	a5,12(a5)
    80200d8c:	00079a63          	bnez	a5,80200da0 <print_dec_int+0x74>
    80200d90:	fa043783          	ld	a5,-96(s0)
    80200d94:	00079663          	bnez	a5,80200da0 <print_dec_int+0x74>
        return 0;
    80200d98:	00000793          	li	a5,0
    80200d9c:	2ac0006f          	j	80201048 <print_dec_int+0x31c>
    }

    bool neg = false;
    80200da0:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80200da4:	f9f44783          	lbu	a5,-97(s0)
    80200da8:	0ff7f793          	zext.b	a5,a5
    80200dac:	02078063          	beqz	a5,80200dcc <print_dec_int+0xa0>
    80200db0:	fa043783          	ld	a5,-96(s0)
    80200db4:	0007dc63          	bgez	a5,80200dcc <print_dec_int+0xa0>
        neg = true;
    80200db8:	00100793          	li	a5,1
    80200dbc:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    80200dc0:	fa043783          	ld	a5,-96(s0)
    80200dc4:	40f007b3          	neg	a5,a5
    80200dc8:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    80200dcc:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    80200dd0:	f9f44783          	lbu	a5,-97(s0)
    80200dd4:	0ff7f793          	zext.b	a5,a5
    80200dd8:	02078863          	beqz	a5,80200e08 <print_dec_int+0xdc>
    80200ddc:	fef44783          	lbu	a5,-17(s0)
    80200de0:	0ff7f793          	zext.b	a5,a5
    80200de4:	00079e63          	bnez	a5,80200e00 <print_dec_int+0xd4>
    80200de8:	f9043783          	ld	a5,-112(s0)
    80200dec:	0057c783          	lbu	a5,5(a5)
    80200df0:	00079863          	bnez	a5,80200e00 <print_dec_int+0xd4>
    80200df4:	f9043783          	ld	a5,-112(s0)
    80200df8:	0047c783          	lbu	a5,4(a5)
    80200dfc:	00078663          	beqz	a5,80200e08 <print_dec_int+0xdc>
    80200e00:	00100793          	li	a5,1
    80200e04:	0080006f          	j	80200e0c <print_dec_int+0xe0>
    80200e08:	00000793          	li	a5,0
    80200e0c:	fcf40ba3          	sb	a5,-41(s0)
    80200e10:	fd744783          	lbu	a5,-41(s0)
    80200e14:	0017f793          	andi	a5,a5,1
    80200e18:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80200e1c:	fa043683          	ld	a3,-96(s0)
    80200e20:	00001797          	auipc	a5,0x1
    80200e24:	30078793          	addi	a5,a5,768 # 80202120 <_srodata+0x120>
    80200e28:	0007b783          	ld	a5,0(a5)
    80200e2c:	02f6b7b3          	mulhu	a5,a3,a5
    80200e30:	0037d713          	srli	a4,a5,0x3
    80200e34:	00070793          	mv	a5,a4
    80200e38:	00279793          	slli	a5,a5,0x2
    80200e3c:	00e787b3          	add	a5,a5,a4
    80200e40:	00179793          	slli	a5,a5,0x1
    80200e44:	40f68733          	sub	a4,a3,a5
    80200e48:	0ff77713          	zext.b	a4,a4
    80200e4c:	fe842783          	lw	a5,-24(s0)
    80200e50:	0017869b          	addiw	a3,a5,1
    80200e54:	fed42423          	sw	a3,-24(s0)
    80200e58:	0307071b          	addiw	a4,a4,48
    80200e5c:	0ff77713          	zext.b	a4,a4
    80200e60:	ff078793          	addi	a5,a5,-16
    80200e64:	008787b3          	add	a5,a5,s0
    80200e68:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    80200e6c:	fa043703          	ld	a4,-96(s0)
    80200e70:	00001797          	auipc	a5,0x1
    80200e74:	2b078793          	addi	a5,a5,688 # 80202120 <_srodata+0x120>
    80200e78:	0007b783          	ld	a5,0(a5)
    80200e7c:	02f737b3          	mulhu	a5,a4,a5
    80200e80:	0037d793          	srli	a5,a5,0x3
    80200e84:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80200e88:	fa043783          	ld	a5,-96(s0)
    80200e8c:	f80798e3          	bnez	a5,80200e1c <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    80200e90:	f9043783          	ld	a5,-112(s0)
    80200e94:	00c7a703          	lw	a4,12(a5)
    80200e98:	fff00793          	li	a5,-1
    80200e9c:	02f71063          	bne	a4,a5,80200ebc <print_dec_int+0x190>
    80200ea0:	f9043783          	ld	a5,-112(s0)
    80200ea4:	0037c783          	lbu	a5,3(a5)
    80200ea8:	00078a63          	beqz	a5,80200ebc <print_dec_int+0x190>
        flags->prec = flags->width;
    80200eac:	f9043783          	ld	a5,-112(s0)
    80200eb0:	0087a703          	lw	a4,8(a5)
    80200eb4:	f9043783          	ld	a5,-112(s0)
    80200eb8:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80200ebc:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200ec0:	f9043783          	ld	a5,-112(s0)
    80200ec4:	0087a703          	lw	a4,8(a5)
    80200ec8:	fe842783          	lw	a5,-24(s0)
    80200ecc:	fcf42823          	sw	a5,-48(s0)
    80200ed0:	f9043783          	ld	a5,-112(s0)
    80200ed4:	00c7a783          	lw	a5,12(a5)
    80200ed8:	fcf42623          	sw	a5,-52(s0)
    80200edc:	fd042783          	lw	a5,-48(s0)
    80200ee0:	00078593          	mv	a1,a5
    80200ee4:	fcc42783          	lw	a5,-52(s0)
    80200ee8:	00078613          	mv	a2,a5
    80200eec:	0006069b          	sext.w	a3,a2
    80200ef0:	0005879b          	sext.w	a5,a1
    80200ef4:	00f6d463          	bge	a3,a5,80200efc <print_dec_int+0x1d0>
    80200ef8:	00058613          	mv	a2,a1
    80200efc:	0006079b          	sext.w	a5,a2
    80200f00:	40f707bb          	subw	a5,a4,a5
    80200f04:	0007871b          	sext.w	a4,a5
    80200f08:	fd744783          	lbu	a5,-41(s0)
    80200f0c:	0007879b          	sext.w	a5,a5
    80200f10:	40f707bb          	subw	a5,a4,a5
    80200f14:	fef42023          	sw	a5,-32(s0)
    80200f18:	0280006f          	j	80200f40 <print_dec_int+0x214>
        putch(' ');
    80200f1c:	fa843783          	ld	a5,-88(s0)
    80200f20:	02000513          	li	a0,32
    80200f24:	000780e7          	jalr	a5
        ++written;
    80200f28:	fe442783          	lw	a5,-28(s0)
    80200f2c:	0017879b          	addiw	a5,a5,1
    80200f30:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200f34:	fe042783          	lw	a5,-32(s0)
    80200f38:	fff7879b          	addiw	a5,a5,-1
    80200f3c:	fef42023          	sw	a5,-32(s0)
    80200f40:	fe042783          	lw	a5,-32(s0)
    80200f44:	0007879b          	sext.w	a5,a5
    80200f48:	fcf04ae3          	bgtz	a5,80200f1c <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    80200f4c:	fd744783          	lbu	a5,-41(s0)
    80200f50:	0ff7f793          	zext.b	a5,a5
    80200f54:	04078463          	beqz	a5,80200f9c <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    80200f58:	fef44783          	lbu	a5,-17(s0)
    80200f5c:	0ff7f793          	zext.b	a5,a5
    80200f60:	00078663          	beqz	a5,80200f6c <print_dec_int+0x240>
    80200f64:	02d00793          	li	a5,45
    80200f68:	01c0006f          	j	80200f84 <print_dec_int+0x258>
    80200f6c:	f9043783          	ld	a5,-112(s0)
    80200f70:	0057c783          	lbu	a5,5(a5)
    80200f74:	00078663          	beqz	a5,80200f80 <print_dec_int+0x254>
    80200f78:	02b00793          	li	a5,43
    80200f7c:	0080006f          	j	80200f84 <print_dec_int+0x258>
    80200f80:	02000793          	li	a5,32
    80200f84:	fa843703          	ld	a4,-88(s0)
    80200f88:	00078513          	mv	a0,a5
    80200f8c:	000700e7          	jalr	a4
        ++written;
    80200f90:	fe442783          	lw	a5,-28(s0)
    80200f94:	0017879b          	addiw	a5,a5,1
    80200f98:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200f9c:	fe842783          	lw	a5,-24(s0)
    80200fa0:	fcf42e23          	sw	a5,-36(s0)
    80200fa4:	0280006f          	j	80200fcc <print_dec_int+0x2a0>
        putch('0');
    80200fa8:	fa843783          	ld	a5,-88(s0)
    80200fac:	03000513          	li	a0,48
    80200fb0:	000780e7          	jalr	a5
        ++written;
    80200fb4:	fe442783          	lw	a5,-28(s0)
    80200fb8:	0017879b          	addiw	a5,a5,1
    80200fbc:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200fc0:	fdc42783          	lw	a5,-36(s0)
    80200fc4:	0017879b          	addiw	a5,a5,1
    80200fc8:	fcf42e23          	sw	a5,-36(s0)
    80200fcc:	f9043783          	ld	a5,-112(s0)
    80200fd0:	00c7a703          	lw	a4,12(a5)
    80200fd4:	fd744783          	lbu	a5,-41(s0)
    80200fd8:	0007879b          	sext.w	a5,a5
    80200fdc:	40f707bb          	subw	a5,a4,a5
    80200fe0:	0007879b          	sext.w	a5,a5
    80200fe4:	fdc42703          	lw	a4,-36(s0)
    80200fe8:	0007071b          	sext.w	a4,a4
    80200fec:	faf74ee3          	blt	a4,a5,80200fa8 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80200ff0:	fe842783          	lw	a5,-24(s0)
    80200ff4:	fff7879b          	addiw	a5,a5,-1
    80200ff8:	fcf42c23          	sw	a5,-40(s0)
    80200ffc:	03c0006f          	j	80201038 <print_dec_int+0x30c>
        putch(buf[i]);
    80201000:	fd842783          	lw	a5,-40(s0)
    80201004:	ff078793          	addi	a5,a5,-16
    80201008:	008787b3          	add	a5,a5,s0
    8020100c:	fc87c783          	lbu	a5,-56(a5)
    80201010:	0007871b          	sext.w	a4,a5
    80201014:	fa843783          	ld	a5,-88(s0)
    80201018:	00070513          	mv	a0,a4
    8020101c:	000780e7          	jalr	a5
        ++written;
    80201020:	fe442783          	lw	a5,-28(s0)
    80201024:	0017879b          	addiw	a5,a5,1
    80201028:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    8020102c:	fd842783          	lw	a5,-40(s0)
    80201030:	fff7879b          	addiw	a5,a5,-1
    80201034:	fcf42c23          	sw	a5,-40(s0)
    80201038:	fd842783          	lw	a5,-40(s0)
    8020103c:	0007879b          	sext.w	a5,a5
    80201040:	fc07d0e3          	bgez	a5,80201000 <print_dec_int+0x2d4>
    }

    return written;
    80201044:	fe442783          	lw	a5,-28(s0)
}
    80201048:	00078513          	mv	a0,a5
    8020104c:	06813083          	ld	ra,104(sp)
    80201050:	06013403          	ld	s0,96(sp)
    80201054:	07010113          	addi	sp,sp,112
    80201058:	00008067          	ret

000000008020105c <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    8020105c:	f4010113          	addi	sp,sp,-192
    80201060:	0a113c23          	sd	ra,184(sp)
    80201064:	0a813823          	sd	s0,176(sp)
    80201068:	0c010413          	addi	s0,sp,192
    8020106c:	f4a43c23          	sd	a0,-168(s0)
    80201070:	f4b43823          	sd	a1,-176(s0)
    80201074:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    80201078:	f8043023          	sd	zero,-128(s0)
    8020107c:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80201080:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80201084:	7a00006f          	j	80201824 <vprintfmt+0x7c8>
        if (flags.in_format) {
    80201088:	f8044783          	lbu	a5,-128(s0)
    8020108c:	72078c63          	beqz	a5,802017c4 <vprintfmt+0x768>
            if (*fmt == '#') {
    80201090:	f5043783          	ld	a5,-176(s0)
    80201094:	0007c783          	lbu	a5,0(a5)
    80201098:	00078713          	mv	a4,a5
    8020109c:	02300793          	li	a5,35
    802010a0:	00f71863          	bne	a4,a5,802010b0 <vprintfmt+0x54>
                flags.sharpflag = true;
    802010a4:	00100793          	li	a5,1
    802010a8:	f8f40123          	sb	a5,-126(s0)
    802010ac:	76c0006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    802010b0:	f5043783          	ld	a5,-176(s0)
    802010b4:	0007c783          	lbu	a5,0(a5)
    802010b8:	00078713          	mv	a4,a5
    802010bc:	03000793          	li	a5,48
    802010c0:	00f71863          	bne	a4,a5,802010d0 <vprintfmt+0x74>
                flags.zeroflag = true;
    802010c4:	00100793          	li	a5,1
    802010c8:	f8f401a3          	sb	a5,-125(s0)
    802010cc:	74c0006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    802010d0:	f5043783          	ld	a5,-176(s0)
    802010d4:	0007c783          	lbu	a5,0(a5)
    802010d8:	00078713          	mv	a4,a5
    802010dc:	06c00793          	li	a5,108
    802010e0:	04f70063          	beq	a4,a5,80201120 <vprintfmt+0xc4>
    802010e4:	f5043783          	ld	a5,-176(s0)
    802010e8:	0007c783          	lbu	a5,0(a5)
    802010ec:	00078713          	mv	a4,a5
    802010f0:	07a00793          	li	a5,122
    802010f4:	02f70663          	beq	a4,a5,80201120 <vprintfmt+0xc4>
    802010f8:	f5043783          	ld	a5,-176(s0)
    802010fc:	0007c783          	lbu	a5,0(a5)
    80201100:	00078713          	mv	a4,a5
    80201104:	07400793          	li	a5,116
    80201108:	00f70c63          	beq	a4,a5,80201120 <vprintfmt+0xc4>
    8020110c:	f5043783          	ld	a5,-176(s0)
    80201110:	0007c783          	lbu	a5,0(a5)
    80201114:	00078713          	mv	a4,a5
    80201118:	06a00793          	li	a5,106
    8020111c:	00f71863          	bne	a4,a5,8020112c <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80201120:	00100793          	li	a5,1
    80201124:	f8f400a3          	sb	a5,-127(s0)
    80201128:	6f00006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    8020112c:	f5043783          	ld	a5,-176(s0)
    80201130:	0007c783          	lbu	a5,0(a5)
    80201134:	00078713          	mv	a4,a5
    80201138:	02b00793          	li	a5,43
    8020113c:	00f71863          	bne	a4,a5,8020114c <vprintfmt+0xf0>
                flags.sign = true;
    80201140:	00100793          	li	a5,1
    80201144:	f8f402a3          	sb	a5,-123(s0)
    80201148:	6d00006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    8020114c:	f5043783          	ld	a5,-176(s0)
    80201150:	0007c783          	lbu	a5,0(a5)
    80201154:	00078713          	mv	a4,a5
    80201158:	02000793          	li	a5,32
    8020115c:	00f71863          	bne	a4,a5,8020116c <vprintfmt+0x110>
                flags.spaceflag = true;
    80201160:	00100793          	li	a5,1
    80201164:	f8f40223          	sb	a5,-124(s0)
    80201168:	6b00006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    8020116c:	f5043783          	ld	a5,-176(s0)
    80201170:	0007c783          	lbu	a5,0(a5)
    80201174:	00078713          	mv	a4,a5
    80201178:	02a00793          	li	a5,42
    8020117c:	00f71e63          	bne	a4,a5,80201198 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80201180:	f4843783          	ld	a5,-184(s0)
    80201184:	00878713          	addi	a4,a5,8
    80201188:	f4e43423          	sd	a4,-184(s0)
    8020118c:	0007a783          	lw	a5,0(a5)
    80201190:	f8f42423          	sw	a5,-120(s0)
    80201194:	6840006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    80201198:	f5043783          	ld	a5,-176(s0)
    8020119c:	0007c783          	lbu	a5,0(a5)
    802011a0:	00078713          	mv	a4,a5
    802011a4:	03000793          	li	a5,48
    802011a8:	04e7f663          	bgeu	a5,a4,802011f4 <vprintfmt+0x198>
    802011ac:	f5043783          	ld	a5,-176(s0)
    802011b0:	0007c783          	lbu	a5,0(a5)
    802011b4:	00078713          	mv	a4,a5
    802011b8:	03900793          	li	a5,57
    802011bc:	02e7ec63          	bltu	a5,a4,802011f4 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    802011c0:	f5043783          	ld	a5,-176(s0)
    802011c4:	f5040713          	addi	a4,s0,-176
    802011c8:	00a00613          	li	a2,10
    802011cc:	00070593          	mv	a1,a4
    802011d0:	00078513          	mv	a0,a5
    802011d4:	865ff0ef          	jal	80200a38 <strtol>
    802011d8:	00050793          	mv	a5,a0
    802011dc:	0007879b          	sext.w	a5,a5
    802011e0:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    802011e4:	f5043783          	ld	a5,-176(s0)
    802011e8:	fff78793          	addi	a5,a5,-1
    802011ec:	f4f43823          	sd	a5,-176(s0)
    802011f0:	6280006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    802011f4:	f5043783          	ld	a5,-176(s0)
    802011f8:	0007c783          	lbu	a5,0(a5)
    802011fc:	00078713          	mv	a4,a5
    80201200:	02e00793          	li	a5,46
    80201204:	06f71863          	bne	a4,a5,80201274 <vprintfmt+0x218>
                fmt++;
    80201208:	f5043783          	ld	a5,-176(s0)
    8020120c:	00178793          	addi	a5,a5,1
    80201210:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80201214:	f5043783          	ld	a5,-176(s0)
    80201218:	0007c783          	lbu	a5,0(a5)
    8020121c:	00078713          	mv	a4,a5
    80201220:	02a00793          	li	a5,42
    80201224:	00f71e63          	bne	a4,a5,80201240 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    80201228:	f4843783          	ld	a5,-184(s0)
    8020122c:	00878713          	addi	a4,a5,8
    80201230:	f4e43423          	sd	a4,-184(s0)
    80201234:	0007a783          	lw	a5,0(a5)
    80201238:	f8f42623          	sw	a5,-116(s0)
    8020123c:	5dc0006f          	j	80201818 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80201240:	f5043783          	ld	a5,-176(s0)
    80201244:	f5040713          	addi	a4,s0,-176
    80201248:	00a00613          	li	a2,10
    8020124c:	00070593          	mv	a1,a4
    80201250:	00078513          	mv	a0,a5
    80201254:	fe4ff0ef          	jal	80200a38 <strtol>
    80201258:	00050793          	mv	a5,a0
    8020125c:	0007879b          	sext.w	a5,a5
    80201260:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80201264:	f5043783          	ld	a5,-176(s0)
    80201268:	fff78793          	addi	a5,a5,-1
    8020126c:	f4f43823          	sd	a5,-176(s0)
    80201270:	5a80006f          	j	80201818 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201274:	f5043783          	ld	a5,-176(s0)
    80201278:	0007c783          	lbu	a5,0(a5)
    8020127c:	00078713          	mv	a4,a5
    80201280:	07800793          	li	a5,120
    80201284:	02f70663          	beq	a4,a5,802012b0 <vprintfmt+0x254>
    80201288:	f5043783          	ld	a5,-176(s0)
    8020128c:	0007c783          	lbu	a5,0(a5)
    80201290:	00078713          	mv	a4,a5
    80201294:	05800793          	li	a5,88
    80201298:	00f70c63          	beq	a4,a5,802012b0 <vprintfmt+0x254>
    8020129c:	f5043783          	ld	a5,-176(s0)
    802012a0:	0007c783          	lbu	a5,0(a5)
    802012a4:	00078713          	mv	a4,a5
    802012a8:	07000793          	li	a5,112
    802012ac:	30f71063          	bne	a4,a5,802015ac <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    802012b0:	f5043783          	ld	a5,-176(s0)
    802012b4:	0007c783          	lbu	a5,0(a5)
    802012b8:	00078713          	mv	a4,a5
    802012bc:	07000793          	li	a5,112
    802012c0:	00f70663          	beq	a4,a5,802012cc <vprintfmt+0x270>
    802012c4:	f8144783          	lbu	a5,-127(s0)
    802012c8:	00078663          	beqz	a5,802012d4 <vprintfmt+0x278>
    802012cc:	00100793          	li	a5,1
    802012d0:	0080006f          	j	802012d8 <vprintfmt+0x27c>
    802012d4:	00000793          	li	a5,0
    802012d8:	faf403a3          	sb	a5,-89(s0)
    802012dc:	fa744783          	lbu	a5,-89(s0)
    802012e0:	0017f793          	andi	a5,a5,1
    802012e4:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    802012e8:	fa744783          	lbu	a5,-89(s0)
    802012ec:	0ff7f793          	zext.b	a5,a5
    802012f0:	00078c63          	beqz	a5,80201308 <vprintfmt+0x2ac>
    802012f4:	f4843783          	ld	a5,-184(s0)
    802012f8:	00878713          	addi	a4,a5,8
    802012fc:	f4e43423          	sd	a4,-184(s0)
    80201300:	0007b783          	ld	a5,0(a5)
    80201304:	01c0006f          	j	80201320 <vprintfmt+0x2c4>
    80201308:	f4843783          	ld	a5,-184(s0)
    8020130c:	00878713          	addi	a4,a5,8
    80201310:	f4e43423          	sd	a4,-184(s0)
    80201314:	0007a783          	lw	a5,0(a5)
    80201318:	02079793          	slli	a5,a5,0x20
    8020131c:	0207d793          	srli	a5,a5,0x20
    80201320:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80201324:	f8c42783          	lw	a5,-116(s0)
    80201328:	02079463          	bnez	a5,80201350 <vprintfmt+0x2f4>
    8020132c:	fe043783          	ld	a5,-32(s0)
    80201330:	02079063          	bnez	a5,80201350 <vprintfmt+0x2f4>
    80201334:	f5043783          	ld	a5,-176(s0)
    80201338:	0007c783          	lbu	a5,0(a5)
    8020133c:	00078713          	mv	a4,a5
    80201340:	07000793          	li	a5,112
    80201344:	00f70663          	beq	a4,a5,80201350 <vprintfmt+0x2f4>
                    flags.in_format = false;
    80201348:	f8040023          	sb	zero,-128(s0)
    8020134c:	4cc0006f          	j	80201818 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    80201350:	f5043783          	ld	a5,-176(s0)
    80201354:	0007c783          	lbu	a5,0(a5)
    80201358:	00078713          	mv	a4,a5
    8020135c:	07000793          	li	a5,112
    80201360:	00f70a63          	beq	a4,a5,80201374 <vprintfmt+0x318>
    80201364:	f8244783          	lbu	a5,-126(s0)
    80201368:	00078a63          	beqz	a5,8020137c <vprintfmt+0x320>
    8020136c:	fe043783          	ld	a5,-32(s0)
    80201370:	00078663          	beqz	a5,8020137c <vprintfmt+0x320>
    80201374:	00100793          	li	a5,1
    80201378:	0080006f          	j	80201380 <vprintfmt+0x324>
    8020137c:	00000793          	li	a5,0
    80201380:	faf40323          	sb	a5,-90(s0)
    80201384:	fa644783          	lbu	a5,-90(s0)
    80201388:	0017f793          	andi	a5,a5,1
    8020138c:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80201390:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80201394:	f5043783          	ld	a5,-176(s0)
    80201398:	0007c783          	lbu	a5,0(a5)
    8020139c:	00078713          	mv	a4,a5
    802013a0:	05800793          	li	a5,88
    802013a4:	00f71863          	bne	a4,a5,802013b4 <vprintfmt+0x358>
    802013a8:	00001797          	auipc	a5,0x1
    802013ac:	d8078793          	addi	a5,a5,-640 # 80202128 <upperxdigits.1>
    802013b0:	00c0006f          	j	802013bc <vprintfmt+0x360>
    802013b4:	00001797          	auipc	a5,0x1
    802013b8:	d8c78793          	addi	a5,a5,-628 # 80202140 <lowerxdigits.0>
    802013bc:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    802013c0:	fe043783          	ld	a5,-32(s0)
    802013c4:	00f7f793          	andi	a5,a5,15
    802013c8:	f9843703          	ld	a4,-104(s0)
    802013cc:	00f70733          	add	a4,a4,a5
    802013d0:	fdc42783          	lw	a5,-36(s0)
    802013d4:	0017869b          	addiw	a3,a5,1
    802013d8:	fcd42e23          	sw	a3,-36(s0)
    802013dc:	00074703          	lbu	a4,0(a4)
    802013e0:	ff078793          	addi	a5,a5,-16
    802013e4:	008787b3          	add	a5,a5,s0
    802013e8:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    802013ec:	fe043783          	ld	a5,-32(s0)
    802013f0:	0047d793          	srli	a5,a5,0x4
    802013f4:	fef43023          	sd	a5,-32(s0)
                } while (num);
    802013f8:	fe043783          	ld	a5,-32(s0)
    802013fc:	fc0792e3          	bnez	a5,802013c0 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201400:	f8c42703          	lw	a4,-116(s0)
    80201404:	fff00793          	li	a5,-1
    80201408:	02f71663          	bne	a4,a5,80201434 <vprintfmt+0x3d8>
    8020140c:	f8344783          	lbu	a5,-125(s0)
    80201410:	02078263          	beqz	a5,80201434 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80201414:	f8842703          	lw	a4,-120(s0)
    80201418:	fa644783          	lbu	a5,-90(s0)
    8020141c:	0007879b          	sext.w	a5,a5
    80201420:	0017979b          	slliw	a5,a5,0x1
    80201424:	0007879b          	sext.w	a5,a5
    80201428:	40f707bb          	subw	a5,a4,a5
    8020142c:	0007879b          	sext.w	a5,a5
    80201430:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201434:	f8842703          	lw	a4,-120(s0)
    80201438:	fa644783          	lbu	a5,-90(s0)
    8020143c:	0007879b          	sext.w	a5,a5
    80201440:	0017979b          	slliw	a5,a5,0x1
    80201444:	0007879b          	sext.w	a5,a5
    80201448:	40f707bb          	subw	a5,a4,a5
    8020144c:	0007871b          	sext.w	a4,a5
    80201450:	fdc42783          	lw	a5,-36(s0)
    80201454:	f8f42a23          	sw	a5,-108(s0)
    80201458:	f8c42783          	lw	a5,-116(s0)
    8020145c:	f8f42823          	sw	a5,-112(s0)
    80201460:	f9442783          	lw	a5,-108(s0)
    80201464:	00078593          	mv	a1,a5
    80201468:	f9042783          	lw	a5,-112(s0)
    8020146c:	00078613          	mv	a2,a5
    80201470:	0006069b          	sext.w	a3,a2
    80201474:	0005879b          	sext.w	a5,a1
    80201478:	00f6d463          	bge	a3,a5,80201480 <vprintfmt+0x424>
    8020147c:	00058613          	mv	a2,a1
    80201480:	0006079b          	sext.w	a5,a2
    80201484:	40f707bb          	subw	a5,a4,a5
    80201488:	fcf42c23          	sw	a5,-40(s0)
    8020148c:	0280006f          	j	802014b4 <vprintfmt+0x458>
                    putch(' ');
    80201490:	f5843783          	ld	a5,-168(s0)
    80201494:	02000513          	li	a0,32
    80201498:	000780e7          	jalr	a5
                    ++written;
    8020149c:	fec42783          	lw	a5,-20(s0)
    802014a0:	0017879b          	addiw	a5,a5,1
    802014a4:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    802014a8:	fd842783          	lw	a5,-40(s0)
    802014ac:	fff7879b          	addiw	a5,a5,-1
    802014b0:	fcf42c23          	sw	a5,-40(s0)
    802014b4:	fd842783          	lw	a5,-40(s0)
    802014b8:	0007879b          	sext.w	a5,a5
    802014bc:	fcf04ae3          	bgtz	a5,80201490 <vprintfmt+0x434>
                }

                if (prefix) {
    802014c0:	fa644783          	lbu	a5,-90(s0)
    802014c4:	0ff7f793          	zext.b	a5,a5
    802014c8:	04078463          	beqz	a5,80201510 <vprintfmt+0x4b4>
                    putch('0');
    802014cc:	f5843783          	ld	a5,-168(s0)
    802014d0:	03000513          	li	a0,48
    802014d4:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    802014d8:	f5043783          	ld	a5,-176(s0)
    802014dc:	0007c783          	lbu	a5,0(a5)
    802014e0:	00078713          	mv	a4,a5
    802014e4:	05800793          	li	a5,88
    802014e8:	00f71663          	bne	a4,a5,802014f4 <vprintfmt+0x498>
    802014ec:	05800793          	li	a5,88
    802014f0:	0080006f          	j	802014f8 <vprintfmt+0x49c>
    802014f4:	07800793          	li	a5,120
    802014f8:	f5843703          	ld	a4,-168(s0)
    802014fc:	00078513          	mv	a0,a5
    80201500:	000700e7          	jalr	a4
                    written += 2;
    80201504:	fec42783          	lw	a5,-20(s0)
    80201508:	0027879b          	addiw	a5,a5,2
    8020150c:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201510:	fdc42783          	lw	a5,-36(s0)
    80201514:	fcf42a23          	sw	a5,-44(s0)
    80201518:	0280006f          	j	80201540 <vprintfmt+0x4e4>
                    putch('0');
    8020151c:	f5843783          	ld	a5,-168(s0)
    80201520:	03000513          	li	a0,48
    80201524:	000780e7          	jalr	a5
                    ++written;
    80201528:	fec42783          	lw	a5,-20(s0)
    8020152c:	0017879b          	addiw	a5,a5,1
    80201530:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201534:	fd442783          	lw	a5,-44(s0)
    80201538:	0017879b          	addiw	a5,a5,1
    8020153c:	fcf42a23          	sw	a5,-44(s0)
    80201540:	f8c42783          	lw	a5,-116(s0)
    80201544:	fd442703          	lw	a4,-44(s0)
    80201548:	0007071b          	sext.w	a4,a4
    8020154c:	fcf748e3          	blt	a4,a5,8020151c <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201550:	fdc42783          	lw	a5,-36(s0)
    80201554:	fff7879b          	addiw	a5,a5,-1
    80201558:	fcf42823          	sw	a5,-48(s0)
    8020155c:	03c0006f          	j	80201598 <vprintfmt+0x53c>
                    putch(buf[i]);
    80201560:	fd042783          	lw	a5,-48(s0)
    80201564:	ff078793          	addi	a5,a5,-16
    80201568:	008787b3          	add	a5,a5,s0
    8020156c:	f807c783          	lbu	a5,-128(a5)
    80201570:	0007871b          	sext.w	a4,a5
    80201574:	f5843783          	ld	a5,-168(s0)
    80201578:	00070513          	mv	a0,a4
    8020157c:	000780e7          	jalr	a5
                    ++written;
    80201580:	fec42783          	lw	a5,-20(s0)
    80201584:	0017879b          	addiw	a5,a5,1
    80201588:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    8020158c:	fd042783          	lw	a5,-48(s0)
    80201590:	fff7879b          	addiw	a5,a5,-1
    80201594:	fcf42823          	sw	a5,-48(s0)
    80201598:	fd042783          	lw	a5,-48(s0)
    8020159c:	0007879b          	sext.w	a5,a5
    802015a0:	fc07d0e3          	bgez	a5,80201560 <vprintfmt+0x504>
                }

                flags.in_format = false;
    802015a4:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802015a8:	2700006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802015ac:	f5043783          	ld	a5,-176(s0)
    802015b0:	0007c783          	lbu	a5,0(a5)
    802015b4:	00078713          	mv	a4,a5
    802015b8:	06400793          	li	a5,100
    802015bc:	02f70663          	beq	a4,a5,802015e8 <vprintfmt+0x58c>
    802015c0:	f5043783          	ld	a5,-176(s0)
    802015c4:	0007c783          	lbu	a5,0(a5)
    802015c8:	00078713          	mv	a4,a5
    802015cc:	06900793          	li	a5,105
    802015d0:	00f70c63          	beq	a4,a5,802015e8 <vprintfmt+0x58c>
    802015d4:	f5043783          	ld	a5,-176(s0)
    802015d8:	0007c783          	lbu	a5,0(a5)
    802015dc:	00078713          	mv	a4,a5
    802015e0:	07500793          	li	a5,117
    802015e4:	08f71063          	bne	a4,a5,80201664 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    802015e8:	f8144783          	lbu	a5,-127(s0)
    802015ec:	00078c63          	beqz	a5,80201604 <vprintfmt+0x5a8>
    802015f0:	f4843783          	ld	a5,-184(s0)
    802015f4:	00878713          	addi	a4,a5,8
    802015f8:	f4e43423          	sd	a4,-184(s0)
    802015fc:	0007b783          	ld	a5,0(a5)
    80201600:	0140006f          	j	80201614 <vprintfmt+0x5b8>
    80201604:	f4843783          	ld	a5,-184(s0)
    80201608:	00878713          	addi	a4,a5,8
    8020160c:	f4e43423          	sd	a4,-184(s0)
    80201610:	0007a783          	lw	a5,0(a5)
    80201614:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201618:	fa843583          	ld	a1,-88(s0)
    8020161c:	f5043783          	ld	a5,-176(s0)
    80201620:	0007c783          	lbu	a5,0(a5)
    80201624:	0007871b          	sext.w	a4,a5
    80201628:	07500793          	li	a5,117
    8020162c:	40f707b3          	sub	a5,a4,a5
    80201630:	00f037b3          	snez	a5,a5
    80201634:	0ff7f793          	zext.b	a5,a5
    80201638:	f8040713          	addi	a4,s0,-128
    8020163c:	00070693          	mv	a3,a4
    80201640:	00078613          	mv	a2,a5
    80201644:	f5843503          	ld	a0,-168(s0)
    80201648:	ee4ff0ef          	jal	80200d2c <print_dec_int>
    8020164c:	00050793          	mv	a5,a0
    80201650:	fec42703          	lw	a4,-20(s0)
    80201654:	00f707bb          	addw	a5,a4,a5
    80201658:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    8020165c:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201660:	1b80006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    80201664:	f5043783          	ld	a5,-176(s0)
    80201668:	0007c783          	lbu	a5,0(a5)
    8020166c:	00078713          	mv	a4,a5
    80201670:	06e00793          	li	a5,110
    80201674:	04f71c63          	bne	a4,a5,802016cc <vprintfmt+0x670>
                if (flags.longflag) {
    80201678:	f8144783          	lbu	a5,-127(s0)
    8020167c:	02078463          	beqz	a5,802016a4 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    80201680:	f4843783          	ld	a5,-184(s0)
    80201684:	00878713          	addi	a4,a5,8
    80201688:	f4e43423          	sd	a4,-184(s0)
    8020168c:	0007b783          	ld	a5,0(a5)
    80201690:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201694:	fec42703          	lw	a4,-20(s0)
    80201698:	fb043783          	ld	a5,-80(s0)
    8020169c:	00e7b023          	sd	a4,0(a5)
    802016a0:	0240006f          	j	802016c4 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    802016a4:	f4843783          	ld	a5,-184(s0)
    802016a8:	00878713          	addi	a4,a5,8
    802016ac:	f4e43423          	sd	a4,-184(s0)
    802016b0:	0007b783          	ld	a5,0(a5)
    802016b4:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    802016b8:	fb843783          	ld	a5,-72(s0)
    802016bc:	fec42703          	lw	a4,-20(s0)
    802016c0:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    802016c4:	f8040023          	sb	zero,-128(s0)
    802016c8:	1500006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    802016cc:	f5043783          	ld	a5,-176(s0)
    802016d0:	0007c783          	lbu	a5,0(a5)
    802016d4:	00078713          	mv	a4,a5
    802016d8:	07300793          	li	a5,115
    802016dc:	02f71e63          	bne	a4,a5,80201718 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    802016e0:	f4843783          	ld	a5,-184(s0)
    802016e4:	00878713          	addi	a4,a5,8
    802016e8:	f4e43423          	sd	a4,-184(s0)
    802016ec:	0007b783          	ld	a5,0(a5)
    802016f0:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    802016f4:	fc043583          	ld	a1,-64(s0)
    802016f8:	f5843503          	ld	a0,-168(s0)
    802016fc:	da8ff0ef          	jal	80200ca4 <puts_wo_nl>
    80201700:	00050793          	mv	a5,a0
    80201704:	fec42703          	lw	a4,-20(s0)
    80201708:	00f707bb          	addw	a5,a4,a5
    8020170c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201710:	f8040023          	sb	zero,-128(s0)
    80201714:	1040006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    80201718:	f5043783          	ld	a5,-176(s0)
    8020171c:	0007c783          	lbu	a5,0(a5)
    80201720:	00078713          	mv	a4,a5
    80201724:	06300793          	li	a5,99
    80201728:	02f71e63          	bne	a4,a5,80201764 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    8020172c:	f4843783          	ld	a5,-184(s0)
    80201730:	00878713          	addi	a4,a5,8
    80201734:	f4e43423          	sd	a4,-184(s0)
    80201738:	0007a783          	lw	a5,0(a5)
    8020173c:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201740:	fcc42703          	lw	a4,-52(s0)
    80201744:	f5843783          	ld	a5,-168(s0)
    80201748:	00070513          	mv	a0,a4
    8020174c:	000780e7          	jalr	a5
                ++written;
    80201750:	fec42783          	lw	a5,-20(s0)
    80201754:	0017879b          	addiw	a5,a5,1
    80201758:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    8020175c:	f8040023          	sb	zero,-128(s0)
    80201760:	0b80006f          	j	80201818 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    80201764:	f5043783          	ld	a5,-176(s0)
    80201768:	0007c783          	lbu	a5,0(a5)
    8020176c:	00078713          	mv	a4,a5
    80201770:	02500793          	li	a5,37
    80201774:	02f71263          	bne	a4,a5,80201798 <vprintfmt+0x73c>
                putch('%');
    80201778:	f5843783          	ld	a5,-168(s0)
    8020177c:	02500513          	li	a0,37
    80201780:	000780e7          	jalr	a5
                ++written;
    80201784:	fec42783          	lw	a5,-20(s0)
    80201788:	0017879b          	addiw	a5,a5,1
    8020178c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201790:	f8040023          	sb	zero,-128(s0)
    80201794:	0840006f          	j	80201818 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    80201798:	f5043783          	ld	a5,-176(s0)
    8020179c:	0007c783          	lbu	a5,0(a5)
    802017a0:	0007871b          	sext.w	a4,a5
    802017a4:	f5843783          	ld	a5,-168(s0)
    802017a8:	00070513          	mv	a0,a4
    802017ac:	000780e7          	jalr	a5
                ++written;
    802017b0:	fec42783          	lw	a5,-20(s0)
    802017b4:	0017879b          	addiw	a5,a5,1
    802017b8:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802017bc:	f8040023          	sb	zero,-128(s0)
    802017c0:	0580006f          	j	80201818 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    802017c4:	f5043783          	ld	a5,-176(s0)
    802017c8:	0007c783          	lbu	a5,0(a5)
    802017cc:	00078713          	mv	a4,a5
    802017d0:	02500793          	li	a5,37
    802017d4:	02f71063          	bne	a4,a5,802017f4 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    802017d8:	f8043023          	sd	zero,-128(s0)
    802017dc:	f8043423          	sd	zero,-120(s0)
    802017e0:	00100793          	li	a5,1
    802017e4:	f8f40023          	sb	a5,-128(s0)
    802017e8:	fff00793          	li	a5,-1
    802017ec:	f8f42623          	sw	a5,-116(s0)
    802017f0:	0280006f          	j	80201818 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    802017f4:	f5043783          	ld	a5,-176(s0)
    802017f8:	0007c783          	lbu	a5,0(a5)
    802017fc:	0007871b          	sext.w	a4,a5
    80201800:	f5843783          	ld	a5,-168(s0)
    80201804:	00070513          	mv	a0,a4
    80201808:	000780e7          	jalr	a5
            ++written;
    8020180c:	fec42783          	lw	a5,-20(s0)
    80201810:	0017879b          	addiw	a5,a5,1
    80201814:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201818:	f5043783          	ld	a5,-176(s0)
    8020181c:	00178793          	addi	a5,a5,1
    80201820:	f4f43823          	sd	a5,-176(s0)
    80201824:	f5043783          	ld	a5,-176(s0)
    80201828:	0007c783          	lbu	a5,0(a5)
    8020182c:	84079ee3          	bnez	a5,80201088 <vprintfmt+0x2c>
        }
    }

    return written;
    80201830:	fec42783          	lw	a5,-20(s0)
}
    80201834:	00078513          	mv	a0,a5
    80201838:	0b813083          	ld	ra,184(sp)
    8020183c:	0b013403          	ld	s0,176(sp)
    80201840:	0c010113          	addi	sp,sp,192
    80201844:	00008067          	ret

0000000080201848 <printk>:

int printk(const char* s, ...) {
    80201848:	f9010113          	addi	sp,sp,-112
    8020184c:	02113423          	sd	ra,40(sp)
    80201850:	02813023          	sd	s0,32(sp)
    80201854:	03010413          	addi	s0,sp,48
    80201858:	fca43c23          	sd	a0,-40(s0)
    8020185c:	00b43423          	sd	a1,8(s0)
    80201860:	00c43823          	sd	a2,16(s0)
    80201864:	00d43c23          	sd	a3,24(s0)
    80201868:	02e43023          	sd	a4,32(s0)
    8020186c:	02f43423          	sd	a5,40(s0)
    80201870:	03043823          	sd	a6,48(s0)
    80201874:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201878:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    8020187c:	04040793          	addi	a5,s0,64
    80201880:	fcf43823          	sd	a5,-48(s0)
    80201884:	fd043783          	ld	a5,-48(s0)
    80201888:	fc878793          	addi	a5,a5,-56
    8020188c:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201890:	fe043783          	ld	a5,-32(s0)
    80201894:	00078613          	mv	a2,a5
    80201898:	fd843583          	ld	a1,-40(s0)
    8020189c:	fffff517          	auipc	a0,0xfffff
    802018a0:	0ec50513          	addi	a0,a0,236 # 80200988 <putc>
    802018a4:	fb8ff0ef          	jal	8020105c <vprintfmt>
    802018a8:	00050793          	mv	a5,a0
    802018ac:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    802018b0:	fec42783          	lw	a5,-20(s0)
}
    802018b4:	00078513          	mv	a0,a5
    802018b8:	02813083          	ld	ra,40(sp)
    802018bc:	02013403          	ld	s0,32(sp)
    802018c0:	07010113          	addi	sp,sp,112
    802018c4:	00008067          	ret

00000000802018c8 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
    802018c8:	fe010113          	addi	sp,sp,-32
    802018cc:	00113c23          	sd	ra,24(sp)
    802018d0:	00813823          	sd	s0,16(sp)
    802018d4:	02010413          	addi	s0,sp,32
    802018d8:	00050793          	mv	a5,a0
    802018dc:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
    802018e0:	fec42783          	lw	a5,-20(s0)
    802018e4:	fff7879b          	addiw	a5,a5,-1
    802018e8:	0007879b          	sext.w	a5,a5
    802018ec:	02079713          	slli	a4,a5,0x20
    802018f0:	02075713          	srli	a4,a4,0x20
    802018f4:	00004797          	auipc	a5,0x4
    802018f8:	82478793          	addi	a5,a5,-2012 # 80205118 <seed>
    802018fc:	00e7b023          	sd	a4,0(a5)
}
    80201900:	00000013          	nop
    80201904:	01813083          	ld	ra,24(sp)
    80201908:	01013403          	ld	s0,16(sp)
    8020190c:	02010113          	addi	sp,sp,32
    80201910:	00008067          	ret

0000000080201914 <rand>:

int rand(void) {
    80201914:	ff010113          	addi	sp,sp,-16
    80201918:	00113423          	sd	ra,8(sp)
    8020191c:	00813023          	sd	s0,0(sp)
    80201920:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
    80201924:	00003797          	auipc	a5,0x3
    80201928:	7f478793          	addi	a5,a5,2036 # 80205118 <seed>
    8020192c:	0007b703          	ld	a4,0(a5)
    80201930:	00001797          	auipc	a5,0x1
    80201934:	82878793          	addi	a5,a5,-2008 # 80202158 <lowerxdigits.0+0x18>
    80201938:	0007b783          	ld	a5,0(a5)
    8020193c:	02f707b3          	mul	a5,a4,a5
    80201940:	00178713          	addi	a4,a5,1
    80201944:	00003797          	auipc	a5,0x3
    80201948:	7d478793          	addi	a5,a5,2004 # 80205118 <seed>
    8020194c:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
    80201950:	00003797          	auipc	a5,0x3
    80201954:	7c878793          	addi	a5,a5,1992 # 80205118 <seed>
    80201958:	0007b783          	ld	a5,0(a5)
    8020195c:	0217d793          	srli	a5,a5,0x21
    80201960:	0007879b          	sext.w	a5,a5
}
    80201964:	00078513          	mv	a0,a5
    80201968:	00813083          	ld	ra,8(sp)
    8020196c:	00013403          	ld	s0,0(sp)
    80201970:	01010113          	addi	sp,sp,16
    80201974:	00008067          	ret

0000000080201978 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
    80201978:	fc010113          	addi	sp,sp,-64
    8020197c:	02113c23          	sd	ra,56(sp)
    80201980:	02813823          	sd	s0,48(sp)
    80201984:	04010413          	addi	s0,sp,64
    80201988:	fca43c23          	sd	a0,-40(s0)
    8020198c:	00058793          	mv	a5,a1
    80201990:	fcc43423          	sd	a2,-56(s0)
    80201994:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
    80201998:	fd843783          	ld	a5,-40(s0)
    8020199c:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
    802019a0:	fe043423          	sd	zero,-24(s0)
    802019a4:	0280006f          	j	802019cc <memset+0x54>
        s[i] = c;
    802019a8:	fe043703          	ld	a4,-32(s0)
    802019ac:	fe843783          	ld	a5,-24(s0)
    802019b0:	00f707b3          	add	a5,a4,a5
    802019b4:	fd442703          	lw	a4,-44(s0)
    802019b8:	0ff77713          	zext.b	a4,a4
    802019bc:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
    802019c0:	fe843783          	ld	a5,-24(s0)
    802019c4:	00178793          	addi	a5,a5,1
    802019c8:	fef43423          	sd	a5,-24(s0)
    802019cc:	fe843703          	ld	a4,-24(s0)
    802019d0:	fc843783          	ld	a5,-56(s0)
    802019d4:	fcf76ae3          	bltu	a4,a5,802019a8 <memset+0x30>
    }
    return dest;
    802019d8:	fd843783          	ld	a5,-40(s0)
}
    802019dc:	00078513          	mv	a0,a5
    802019e0:	03813083          	ld	ra,56(sp)
    802019e4:	03013403          	ld	s0,48(sp)
    802019e8:	04010113          	addi	sp,sp,64
    802019ec:	00008067          	ret
