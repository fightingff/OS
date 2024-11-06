
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
ffffffe000200008:	6f1000ef          	jal	ffffffe000200ef8 <setup_vm>
    call relocate
ffffffe00020000c:	030000ef          	jal	ffffffe00020003c <relocate>
    
    call mm_init
ffffffe000200010:	3e8000ef          	jal	ffffffe0002003f8 <mm_init>
    call task_init
ffffffe000200014:	434000ef          	jal	ffffffe000200448 <task_init>

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
ffffffe00020002c:	22c000ef          	jal	ffffffe000200258 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe000200030:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200034:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe000200038:	7f1000ef          	jal	ffffffe000201028 <start_kernel>

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
ffffffe000200110:	581000ef          	jal	ffffffe000200e90 <trap_handler>
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
ffffffe0002001a8:	4a828293          	addi	t0,t0,1192 # ffffffe00020064c <dummy>
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
ffffffe000200234:	00813c23          	sd	s0,24(sp)
ffffffe000200238:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
ffffffe00020023c:	c01027f3          	rdtime	a5
ffffffe000200240:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
ffffffe000200244:	fe843783          	ld	a5,-24(s0)
}
ffffffe000200248:	00078513          	mv	a0,a5
ffffffe00020024c:	01813403          	ld	s0,24(sp)
ffffffe000200250:	02010113          	addi	sp,sp,32
ffffffe000200254:	00008067          	ret

ffffffe000200258 <clock_set_next_event>:

void clock_set_next_event() {
ffffffe000200258:	fe010113          	addi	sp,sp,-32
ffffffe00020025c:	00113c23          	sd	ra,24(sp)
ffffffe000200260:	00813823          	sd	s0,16(sp)
ffffffe000200264:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe000200268:	fc9ff0ef          	jal	ffffffe000200230 <get_cycles>
ffffffe00020026c:	00050713          	mv	a4,a0
ffffffe000200270:	00004797          	auipc	a5,0x4
ffffffe000200274:	d9078793          	addi	a5,a5,-624 # ffffffe000204000 <TIMECLOCK>
ffffffe000200278:	0007b783          	ld	a5,0(a5)
ffffffe00020027c:	00f707b3          	add	a5,a4,a5
ffffffe000200280:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe000200284:	fe843503          	ld	a0,-24(s0)
ffffffe000200288:	255000ef          	jal	ffffffe000200cdc <sbi_set_timer>
ffffffe00020028c:	00000013          	nop
ffffffe000200290:	01813083          	ld	ra,24(sp)
ffffffe000200294:	01013403          	ld	s0,16(sp)
ffffffe000200298:	02010113          	addi	sp,sp,32
ffffffe00020029c:	00008067          	ret

ffffffe0002002a0 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
ffffffe0002002a0:	fe010113          	addi	sp,sp,-32
ffffffe0002002a4:	00113c23          	sd	ra,24(sp)
ffffffe0002002a8:	00813823          	sd	s0,16(sp)
ffffffe0002002ac:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
ffffffe0002002b0:	00006797          	auipc	a5,0x6
ffffffe0002002b4:	d5078793          	addi	a5,a5,-688 # ffffffe000206000 <kmem>
ffffffe0002002b8:	0007b783          	ld	a5,0(a5)
ffffffe0002002bc:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
ffffffe0002002c0:	fe843783          	ld	a5,-24(s0)
ffffffe0002002c4:	0007b703          	ld	a4,0(a5)
ffffffe0002002c8:	00006797          	auipc	a5,0x6
ffffffe0002002cc:	d3878793          	addi	a5,a5,-712 # ffffffe000206000 <kmem>
ffffffe0002002d0:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
ffffffe0002002d4:	00001637          	lui	a2,0x1
ffffffe0002002d8:	00000593          	li	a1,0
ffffffe0002002dc:	fe843503          	ld	a0,-24(s0)
ffffffe0002002e0:	5c1010ef          	jal	ffffffe0002020a0 <memset>
    return (void *)r;
ffffffe0002002e4:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002e8:	00078513          	mv	a0,a5
ffffffe0002002ec:	01813083          	ld	ra,24(sp)
ffffffe0002002f0:	01013403          	ld	s0,16(sp)
ffffffe0002002f4:	02010113          	addi	sp,sp,32
ffffffe0002002f8:	00008067          	ret

ffffffe0002002fc <kfree>:

void kfree(void *addr) {
ffffffe0002002fc:	fd010113          	addi	sp,sp,-48
ffffffe000200300:	02113423          	sd	ra,40(sp)
ffffffe000200304:	02813023          	sd	s0,32(sp)
ffffffe000200308:	03010413          	addi	s0,sp,48
ffffffe00020030c:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe000200310:	fd843783          	ld	a5,-40(s0)
ffffffe000200314:	00078693          	mv	a3,a5
ffffffe000200318:	fd840793          	addi	a5,s0,-40
ffffffe00020031c:	fffff737          	lui	a4,0xfffff
ffffffe000200320:	00e6f733          	and	a4,a3,a4
ffffffe000200324:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe000200328:	fd843783          	ld	a5,-40(s0)
ffffffe00020032c:	00001637          	lui	a2,0x1
ffffffe000200330:	00000593          	li	a1,0
ffffffe000200334:	00078513          	mv	a0,a5
ffffffe000200338:	569010ef          	jal	ffffffe0002020a0 <memset>

    r = (struct run *)addr;
ffffffe00020033c:	fd843783          	ld	a5,-40(s0)
ffffffe000200340:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe000200344:	00006797          	auipc	a5,0x6
ffffffe000200348:	cbc78793          	addi	a5,a5,-836 # ffffffe000206000 <kmem>
ffffffe00020034c:	0007b703          	ld	a4,0(a5)
ffffffe000200350:	fe843783          	ld	a5,-24(s0)
ffffffe000200354:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe000200358:	00006797          	auipc	a5,0x6
ffffffe00020035c:	ca878793          	addi	a5,a5,-856 # ffffffe000206000 <kmem>
ffffffe000200360:	fe843703          	ld	a4,-24(s0)
ffffffe000200364:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe000200368:	00000013          	nop
}
ffffffe00020036c:	02813083          	ld	ra,40(sp)
ffffffe000200370:	02013403          	ld	s0,32(sp)
ffffffe000200374:	03010113          	addi	sp,sp,48
ffffffe000200378:	00008067          	ret

ffffffe00020037c <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe00020037c:	fd010113          	addi	sp,sp,-48
ffffffe000200380:	02113423          	sd	ra,40(sp)
ffffffe000200384:	02813023          	sd	s0,32(sp)
ffffffe000200388:	03010413          	addi	s0,sp,48
ffffffe00020038c:	fca43c23          	sd	a0,-40(s0)
ffffffe000200390:	fcb43823          	sd	a1,-48(s0)
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe000200394:	fd843703          	ld	a4,-40(s0)
ffffffe000200398:	000017b7          	lui	a5,0x1
ffffffe00020039c:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003a0:	00f70733          	add	a4,a4,a5
ffffffe0002003a4:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003a8:	00f777b3          	and	a5,a4,a5
ffffffe0002003ac:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe0002003b0:	01c0006f          	j	ffffffe0002003cc <kfreerange+0x50>
        kfree((void *)addr);
ffffffe0002003b4:	fe843503          	ld	a0,-24(s0)
ffffffe0002003b8:	f45ff0ef          	jal	ffffffe0002002fc <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) {
ffffffe0002003bc:	fe843703          	ld	a4,-24(s0)
ffffffe0002003c0:	000017b7          	lui	a5,0x1
ffffffe0002003c4:	00f707b3          	add	a5,a4,a5
ffffffe0002003c8:	fef43423          	sd	a5,-24(s0)
ffffffe0002003cc:	fe843703          	ld	a4,-24(s0)
ffffffe0002003d0:	000017b7          	lui	a5,0x1
ffffffe0002003d4:	00f70733          	add	a4,a4,a5
ffffffe0002003d8:	fd043783          	ld	a5,-48(s0)
ffffffe0002003dc:	fce7fce3          	bgeu	a5,a4,ffffffe0002003b4 <kfreerange+0x38>
    }
}
ffffffe0002003e0:	00000013          	nop
ffffffe0002003e4:	00000013          	nop
ffffffe0002003e8:	02813083          	ld	ra,40(sp)
ffffffe0002003ec:	02013403          	ld	s0,32(sp)
ffffffe0002003f0:	03010113          	addi	sp,sp,48
ffffffe0002003f4:	00008067          	ret

ffffffe0002003f8 <mm_init>:

void mm_init(void) {
ffffffe0002003f8:	ff010113          	addi	sp,sp,-16
ffffffe0002003fc:	00113423          	sd	ra,8(sp)
ffffffe000200400:	00813023          	sd	s0,0(sp)
ffffffe000200404:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200408:	00003517          	auipc	a0,0x3
ffffffe00020040c:	c0050513          	addi	a0,a0,-1024 # ffffffe000203008 <__func__.3+0x8>
ffffffe000200410:	371010ef          	jal	ffffffe000201f80 <printk>
    kfreerange(_ekernel, (char *)PHY_END);
ffffffe000200414:	01100793          	li	a5,17
ffffffe000200418:	01b79593          	slli	a1,a5,0x1b
ffffffe00020041c:	00008517          	auipc	a0,0x8
ffffffe000200420:	be450513          	addi	a0,a0,-1052 # ffffffe000208000 <_ebss>
ffffffe000200424:	f59ff0ef          	jal	ffffffe00020037c <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200428:	00003517          	auipc	a0,0x3
ffffffe00020042c:	bf850513          	addi	a0,a0,-1032 # ffffffe000203020 <__func__.3+0x20>
ffffffe000200430:	351010ef          	jal	ffffffe000201f80 <printk>
}
ffffffe000200434:	00000013          	nop
ffffffe000200438:	00813083          	ld	ra,8(sp)
ffffffe00020043c:	00013403          	ld	s0,0(sp)
ffffffe000200440:	01010113          	addi	sp,sp,16
ffffffe000200444:	00008067          	ret

ffffffe000200448 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe000200448:	fe010113          	addi	sp,sp,-32
ffffffe00020044c:	00113c23          	sd	ra,24(sp)
ffffffe000200450:	00813823          	sd	s0,16(sp)
ffffffe000200454:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe000200458:	7e800513          	li	a0,2024
ffffffe00020045c:	3a5010ef          	jal	ffffffe000202000 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe000200460:	e41ff0ef          	jal	ffffffe0002002a0 <kalloc>
ffffffe000200464:	00050713          	mv	a4,a0
ffffffe000200468:	00006797          	auipc	a5,0x6
ffffffe00020046c:	ba078793          	addi	a5,a5,-1120 # ffffffe000206008 <idle>
ffffffe000200470:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe000200474:	00006797          	auipc	a5,0x6
ffffffe000200478:	b9478793          	addi	a5,a5,-1132 # ffffffe000206008 <idle>
ffffffe00020047c:	0007b783          	ld	a5,0(a5)
ffffffe000200480:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe000200484:	00006797          	auipc	a5,0x6
ffffffe000200488:	b8478793          	addi	a5,a5,-1148 # ffffffe000206008 <idle>
ffffffe00020048c:	0007b783          	ld	a5,0(a5)
ffffffe000200490:	0007b823          	sd	zero,16(a5)
ffffffe000200494:	00006717          	auipc	a4,0x6
ffffffe000200498:	b7470713          	addi	a4,a4,-1164 # ffffffe000206008 <idle>
ffffffe00020049c:	00073703          	ld	a4,0(a4)
ffffffe0002004a0:	0107b783          	ld	a5,16(a5)
ffffffe0002004a4:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe0002004a8:	00006797          	auipc	a5,0x6
ffffffe0002004ac:	b6078793          	addi	a5,a5,-1184 # ffffffe000206008 <idle>
ffffffe0002004b0:	0007b783          	ld	a5,0(a5)
ffffffe0002004b4:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe0002004b8:	00006797          	auipc	a5,0x6
ffffffe0002004bc:	b5078793          	addi	a5,a5,-1200 # ffffffe000206008 <idle>
ffffffe0002004c0:	0007b703          	ld	a4,0(a5)
ffffffe0002004c4:	00006797          	auipc	a5,0x6
ffffffe0002004c8:	b5c78793          	addi	a5,a5,-1188 # ffffffe000206020 <task>
ffffffe0002004cc:	00e7b023          	sd	a4,0(a5)
ffffffe0002004d0:	00006797          	auipc	a5,0x6
ffffffe0002004d4:	b5078793          	addi	a5,a5,-1200 # ffffffe000206020 <task>
ffffffe0002004d8:	0007b703          	ld	a4,0(a5)
ffffffe0002004dc:	00006797          	auipc	a5,0x6
ffffffe0002004e0:	b3478793          	addi	a5,a5,-1228 # ffffffe000206010 <current>
ffffffe0002004e4:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002004e8:	00100793          	li	a5,1
ffffffe0002004ec:	fef42623          	sw	a5,-20(s0)
ffffffe0002004f0:	12c0006f          	j	ffffffe00020061c <task_init+0x1d4>
        task[i] = (struct task_struct *)kalloc();
ffffffe0002004f4:	dadff0ef          	jal	ffffffe0002002a0 <kalloc>
ffffffe0002004f8:	00050693          	mv	a3,a0
ffffffe0002004fc:	00006717          	auipc	a4,0x6
ffffffe000200500:	b2470713          	addi	a4,a4,-1244 # ffffffe000206020 <task>
ffffffe000200504:	fec42783          	lw	a5,-20(s0)
ffffffe000200508:	00379793          	slli	a5,a5,0x3
ffffffe00020050c:	00f707b3          	add	a5,a4,a5
ffffffe000200510:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe000200514:	00006717          	auipc	a4,0x6
ffffffe000200518:	b0c70713          	addi	a4,a4,-1268 # ffffffe000206020 <task>
ffffffe00020051c:	fec42783          	lw	a5,-20(s0)
ffffffe000200520:	00379793          	slli	a5,a5,0x3
ffffffe000200524:	00f707b3          	add	a5,a4,a5
ffffffe000200528:	0007b783          	ld	a5,0(a5)
ffffffe00020052c:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe000200530:	00006717          	auipc	a4,0x6
ffffffe000200534:	af070713          	addi	a4,a4,-1296 # ffffffe000206020 <task>
ffffffe000200538:	fec42783          	lw	a5,-20(s0)
ffffffe00020053c:	00379793          	slli	a5,a5,0x3
ffffffe000200540:	00f707b3          	add	a5,a4,a5
ffffffe000200544:	0007b783          	ld	a5,0(a5)
ffffffe000200548:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe00020054c:	2f9010ef          	jal	ffffffe000202044 <rand>
ffffffe000200550:	00050793          	mv	a5,a0
ffffffe000200554:	00078713          	mv	a4,a5
ffffffe000200558:	00a00793          	li	a5,10
ffffffe00020055c:	02f767bb          	remw	a5,a4,a5
ffffffe000200560:	0007879b          	sext.w	a5,a5
ffffffe000200564:	0017879b          	addiw	a5,a5,1
ffffffe000200568:	0007869b          	sext.w	a3,a5
ffffffe00020056c:	00006717          	auipc	a4,0x6
ffffffe000200570:	ab470713          	addi	a4,a4,-1356 # ffffffe000206020 <task>
ffffffe000200574:	fec42783          	lw	a5,-20(s0)
ffffffe000200578:	00379793          	slli	a5,a5,0x3
ffffffe00020057c:	00f707b3          	add	a5,a4,a5
ffffffe000200580:	0007b783          	ld	a5,0(a5)
ffffffe000200584:	00068713          	mv	a4,a3
ffffffe000200588:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe00020058c:	00006717          	auipc	a4,0x6
ffffffe000200590:	a9470713          	addi	a4,a4,-1388 # ffffffe000206020 <task>
ffffffe000200594:	fec42783          	lw	a5,-20(s0)
ffffffe000200598:	00379793          	slli	a5,a5,0x3
ffffffe00020059c:	00f707b3          	add	a5,a4,a5
ffffffe0002005a0:	0007b783          	ld	a5,0(a5)
ffffffe0002005a4:	fec42703          	lw	a4,-20(s0)
ffffffe0002005a8:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe0002005ac:	00006717          	auipc	a4,0x6
ffffffe0002005b0:	a7470713          	addi	a4,a4,-1420 # ffffffe000206020 <task>
ffffffe0002005b4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005b8:	00379793          	slli	a5,a5,0x3
ffffffe0002005bc:	00f707b3          	add	a5,a4,a5
ffffffe0002005c0:	0007b783          	ld	a5,0(a5)
ffffffe0002005c4:	00000717          	auipc	a4,0x0
ffffffe0002005c8:	be070713          	addi	a4,a4,-1056 # ffffffe0002001a4 <__dummy>
ffffffe0002005cc:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe0002005d0:	00006717          	auipc	a4,0x6
ffffffe0002005d4:	a5070713          	addi	a4,a4,-1456 # ffffffe000206020 <task>
ffffffe0002005d8:	fec42783          	lw	a5,-20(s0)
ffffffe0002005dc:	00379793          	slli	a5,a5,0x3
ffffffe0002005e0:	00f707b3          	add	a5,a4,a5
ffffffe0002005e4:	0007b783          	ld	a5,0(a5)
ffffffe0002005e8:	00078693          	mv	a3,a5
ffffffe0002005ec:	00006717          	auipc	a4,0x6
ffffffe0002005f0:	a3470713          	addi	a4,a4,-1484 # ffffffe000206020 <task>
ffffffe0002005f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005f8:	00379793          	slli	a5,a5,0x3
ffffffe0002005fc:	00f707b3          	add	a5,a4,a5
ffffffe000200600:	0007b783          	ld	a5,0(a5)
ffffffe000200604:	00001737          	lui	a4,0x1
ffffffe000200608:	00e68733          	add	a4,a3,a4
ffffffe00020060c:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200610:	fec42783          	lw	a5,-20(s0)
ffffffe000200614:	0017879b          	addiw	a5,a5,1
ffffffe000200618:	fef42623          	sw	a5,-20(s0)
ffffffe00020061c:	fec42783          	lw	a5,-20(s0)
ffffffe000200620:	0007871b          	sext.w	a4,a5
ffffffe000200624:	01f00793          	li	a5,31
ffffffe000200628:	ece7d6e3          	bge	a5,a4,ffffffe0002004f4 <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe00020062c:	00003517          	auipc	a0,0x3
ffffffe000200630:	a0c50513          	addi	a0,a0,-1524 # ffffffe000203038 <__func__.3+0x38>
ffffffe000200634:	14d010ef          	jal	ffffffe000201f80 <printk>
}
ffffffe000200638:	00000013          	nop
ffffffe00020063c:	01813083          	ld	ra,24(sp)
ffffffe000200640:	01013403          	ld	s0,16(sp)
ffffffe000200644:	02010113          	addi	sp,sp,32
ffffffe000200648:	00008067          	ret

ffffffe00020064c <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe00020064c:	fd010113          	addi	sp,sp,-48
ffffffe000200650:	02113423          	sd	ra,40(sp)
ffffffe000200654:	02813023          	sd	s0,32(sp)
ffffffe000200658:	03010413          	addi	s0,sp,48
    LOG(RED);
ffffffe00020065c:	00003697          	auipc	a3,0x3
ffffffe000200660:	9a468693          	addi	a3,a3,-1628 # ffffffe000203000 <__func__.3>
ffffffe000200664:	04100613          	li	a2,65
ffffffe000200668:	00003597          	auipc	a1,0x3
ffffffe00020066c:	9e858593          	addi	a1,a1,-1560 # ffffffe000203050 <__func__.3+0x50>
ffffffe000200670:	00003517          	auipc	a0,0x3
ffffffe000200674:	9e850513          	addi	a0,a0,-1560 # ffffffe000203058 <__func__.3+0x58>
ffffffe000200678:	109010ef          	jal	ffffffe000201f80 <printk>
    uint64_t MOD = 1000000007;
ffffffe00020067c:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe000200680:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe000200684:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe000200688:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe00020068c:	fff00793          	li	a5,-1
ffffffe000200690:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000200694:	fe442783          	lw	a5,-28(s0)
ffffffe000200698:	0007871b          	sext.w	a4,a5
ffffffe00020069c:	fff00793          	li	a5,-1
ffffffe0002006a0:	00f70e63          	beq	a4,a5,ffffffe0002006bc <dummy+0x70>
ffffffe0002006a4:	00006797          	auipc	a5,0x6
ffffffe0002006a8:	96c78793          	addi	a5,a5,-1684 # ffffffe000206010 <current>
ffffffe0002006ac:	0007b783          	ld	a5,0(a5)
ffffffe0002006b0:	0087b703          	ld	a4,8(a5)
ffffffe0002006b4:	fe442783          	lw	a5,-28(s0)
ffffffe0002006b8:	fcf70ee3          	beq	a4,a5,ffffffe000200694 <dummy+0x48>
ffffffe0002006bc:	00006797          	auipc	a5,0x6
ffffffe0002006c0:	95478793          	addi	a5,a5,-1708 # ffffffe000206010 <current>
ffffffe0002006c4:	0007b783          	ld	a5,0(a5)
ffffffe0002006c8:	0087b783          	ld	a5,8(a5)
ffffffe0002006cc:	fc0784e3          	beqz	a5,ffffffe000200694 <dummy+0x48>
            if (current->counter == 1) {
ffffffe0002006d0:	00006797          	auipc	a5,0x6
ffffffe0002006d4:	94078793          	addi	a5,a5,-1728 # ffffffe000206010 <current>
ffffffe0002006d8:	0007b783          	ld	a5,0(a5)
ffffffe0002006dc:	0087b703          	ld	a4,8(a5)
ffffffe0002006e0:	00100793          	li	a5,1
ffffffe0002006e4:	00f71e63          	bne	a4,a5,ffffffe000200700 <dummy+0xb4>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe0002006e8:	00006797          	auipc	a5,0x6
ffffffe0002006ec:	92878793          	addi	a5,a5,-1752 # ffffffe000206010 <current>
ffffffe0002006f0:	0007b783          	ld	a5,0(a5)
ffffffe0002006f4:	0087b703          	ld	a4,8(a5)
ffffffe0002006f8:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe0002006fc:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe000200700:	00006797          	auipc	a5,0x6
ffffffe000200704:	91078793          	addi	a5,a5,-1776 # ffffffe000206010 <current>
ffffffe000200708:	0007b783          	ld	a5,0(a5)
ffffffe00020070c:	0087b783          	ld	a5,8(a5)
ffffffe000200710:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe000200714:	fe843783          	ld	a5,-24(s0)
ffffffe000200718:	00178713          	addi	a4,a5,1
ffffffe00020071c:	fd843783          	ld	a5,-40(s0)
ffffffe000200720:	02f777b3          	remu	a5,a4,a5
ffffffe000200724:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe000200728:	00006797          	auipc	a5,0x6
ffffffe00020072c:	8e878793          	addi	a5,a5,-1816 # ffffffe000206010 <current>
ffffffe000200730:	0007b783          	ld	a5,0(a5)
ffffffe000200734:	0187b783          	ld	a5,24(a5)
ffffffe000200738:	fe843603          	ld	a2,-24(s0)
ffffffe00020073c:	00078593          	mv	a1,a5
ffffffe000200740:	00003517          	auipc	a0,0x3
ffffffe000200744:	93850513          	addi	a0,a0,-1736 # ffffffe000203078 <__func__.3+0x78>
ffffffe000200748:	039010ef          	jal	ffffffe000201f80 <printk>
            LOG(RED "%llu\n", current->thread.ra);
ffffffe00020074c:	00006797          	auipc	a5,0x6
ffffffe000200750:	8c478793          	addi	a5,a5,-1852 # ffffffe000206010 <current>
ffffffe000200754:	0007b783          	ld	a5,0(a5)
ffffffe000200758:	0207b783          	ld	a5,32(a5)
ffffffe00020075c:	00078713          	mv	a4,a5
ffffffe000200760:	00003697          	auipc	a3,0x3
ffffffe000200764:	8a068693          	addi	a3,a3,-1888 # ffffffe000203000 <__func__.3>
ffffffe000200768:	04d00613          	li	a2,77
ffffffe00020076c:	00003597          	auipc	a1,0x3
ffffffe000200770:	8e458593          	addi	a1,a1,-1820 # ffffffe000203050 <__func__.3+0x50>
ffffffe000200774:	00003517          	auipc	a0,0x3
ffffffe000200778:	93450513          	addi	a0,a0,-1740 # ffffffe0002030a8 <__func__.3+0xa8>
ffffffe00020077c:	005010ef          	jal	ffffffe000201f80 <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000200780:	f15ff06f          	j	ffffffe000200694 <dummy+0x48>

ffffffe000200784 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe000200784:	fd010113          	addi	sp,sp,-48
ffffffe000200788:	02113423          	sd	ra,40(sp)
ffffffe00020078c:	02813023          	sd	s0,32(sp)
ffffffe000200790:	03010413          	addi	s0,sp,48
ffffffe000200794:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe000200798:	00003697          	auipc	a3,0x3
ffffffe00020079c:	9f068693          	addi	a3,a3,-1552 # ffffffe000203188 <__func__.2>
ffffffe0002007a0:	06500613          	li	a2,101
ffffffe0002007a4:	00003597          	auipc	a1,0x3
ffffffe0002007a8:	8ac58593          	addi	a1,a1,-1876 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002007ac:	00003517          	auipc	a0,0x3
ffffffe0002007b0:	8ac50513          	addi	a0,a0,-1876 # ffffffe000203058 <__func__.3+0x58>
ffffffe0002007b4:	7cc010ef          	jal	ffffffe000201f80 <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe0002007b8:	00006797          	auipc	a5,0x6
ffffffe0002007bc:	85878793          	addi	a5,a5,-1960 # ffffffe000206010 <current>
ffffffe0002007c0:	0007b783          	ld	a5,0(a5)
ffffffe0002007c4:	0187b703          	ld	a4,24(a5)
ffffffe0002007c8:	fd843783          	ld	a5,-40(s0)
ffffffe0002007cc:	0187b783          	ld	a5,24(a5)
ffffffe0002007d0:	00003697          	auipc	a3,0x3
ffffffe0002007d4:	9b868693          	addi	a3,a3,-1608 # ffffffe000203188 <__func__.2>
ffffffe0002007d8:	06600613          	li	a2,102
ffffffe0002007dc:	00003597          	auipc	a1,0x3
ffffffe0002007e0:	87458593          	addi	a1,a1,-1932 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002007e4:	00003517          	auipc	a0,0x3
ffffffe0002007e8:	8ec50513          	addi	a0,a0,-1812 # ffffffe0002030d0 <__func__.3+0xd0>
ffffffe0002007ec:	794010ef          	jal	ffffffe000201f80 <printk>
    if(current->pid != next->pid) {
ffffffe0002007f0:	00006797          	auipc	a5,0x6
ffffffe0002007f4:	82078793          	addi	a5,a5,-2016 # ffffffe000206010 <current>
ffffffe0002007f8:	0007b783          	ld	a5,0(a5)
ffffffe0002007fc:	0187b703          	ld	a4,24(a5)
ffffffe000200800:	fd843783          	ld	a5,-40(s0)
ffffffe000200804:	0187b783          	ld	a5,24(a5)
ffffffe000200808:	06f70a63          	beq	a4,a5,ffffffe00020087c <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe00020080c:	00006797          	auipc	a5,0x6
ffffffe000200810:	80478793          	addi	a5,a5,-2044 # ffffffe000206010 <current>
ffffffe000200814:	0007b783          	ld	a5,0(a5)
ffffffe000200818:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe00020081c:	00005797          	auipc	a5,0x5
ffffffe000200820:	7f478793          	addi	a5,a5,2036 # ffffffe000206010 <current>
ffffffe000200824:	fd843703          	ld	a4,-40(s0)
ffffffe000200828:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe00020082c:	00005797          	auipc	a5,0x5
ffffffe000200830:	7e478793          	addi	a5,a5,2020 # ffffffe000206010 <current>
ffffffe000200834:	0007b783          	ld	a5,0(a5)
ffffffe000200838:	0187b703          	ld	a4,24(a5)
ffffffe00020083c:	00005797          	auipc	a5,0x5
ffffffe000200840:	7d478793          	addi	a5,a5,2004 # ffffffe000206010 <current>
ffffffe000200844:	0007b783          	ld	a5,0(a5)
ffffffe000200848:	0107b603          	ld	a2,16(a5)
ffffffe00020084c:	00005797          	auipc	a5,0x5
ffffffe000200850:	7c478793          	addi	a5,a5,1988 # ffffffe000206010 <current>
ffffffe000200854:	0007b783          	ld	a5,0(a5)
ffffffe000200858:	0087b783          	ld	a5,8(a5)
ffffffe00020085c:	00078693          	mv	a3,a5
ffffffe000200860:	00070593          	mv	a1,a4
ffffffe000200864:	00003517          	auipc	a0,0x3
ffffffe000200868:	8ac50513          	addi	a0,a0,-1876 # ffffffe000203110 <__func__.3+0x110>
ffffffe00020086c:	714010ef          	jal	ffffffe000201f80 <printk>
        __switch_to(prev, next);
ffffffe000200870:	fd843583          	ld	a1,-40(s0)
ffffffe000200874:	fe843503          	ld	a0,-24(s0)
ffffffe000200878:	93dff0ef          	jal	ffffffe0002001b4 <__switch_to>
    }
}
ffffffe00020087c:	00000013          	nop
ffffffe000200880:	02813083          	ld	ra,40(sp)
ffffffe000200884:	02013403          	ld	s0,32(sp)
ffffffe000200888:	03010113          	addi	sp,sp,48
ffffffe00020088c:	00008067          	ret

ffffffe000200890 <do_timer>:

void do_timer() {
ffffffe000200890:	ff010113          	addi	sp,sp,-16
ffffffe000200894:	00113423          	sd	ra,8(sp)
ffffffe000200898:	00813023          	sd	s0,0(sp)
ffffffe00020089c:	01010413          	addi	s0,sp,16
    LOG(RED);
ffffffe0002008a0:	00003697          	auipc	a3,0x3
ffffffe0002008a4:	8f868693          	addi	a3,a3,-1800 # ffffffe000203198 <__func__.1>
ffffffe0002008a8:	07000613          	li	a2,112
ffffffe0002008ac:	00002597          	auipc	a1,0x2
ffffffe0002008b0:	7a458593          	addi	a1,a1,1956 # ffffffe000203050 <__func__.3+0x50>
ffffffe0002008b4:	00002517          	auipc	a0,0x2
ffffffe0002008b8:	7a450513          	addi	a0,a0,1956 # ffffffe000203058 <__func__.3+0x58>
ffffffe0002008bc:	6c4010ef          	jal	ffffffe000201f80 <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe0002008c0:	00005797          	auipc	a5,0x5
ffffffe0002008c4:	75078793          	addi	a5,a5,1872 # ffffffe000206010 <current>
ffffffe0002008c8:	0007b783          	ld	a5,0(a5)
ffffffe0002008cc:	0187b703          	ld	a4,24(a5)
ffffffe0002008d0:	00005797          	auipc	a5,0x5
ffffffe0002008d4:	73878793          	addi	a5,a5,1848 # ffffffe000206008 <idle>
ffffffe0002008d8:	0007b783          	ld	a5,0(a5)
ffffffe0002008dc:	0187b783          	ld	a5,24(a5)
ffffffe0002008e0:	00f70c63          	beq	a4,a5,ffffffe0002008f8 <do_timer+0x68>
ffffffe0002008e4:	00005797          	auipc	a5,0x5
ffffffe0002008e8:	72c78793          	addi	a5,a5,1836 # ffffffe000206010 <current>
ffffffe0002008ec:	0007b783          	ld	a5,0(a5)
ffffffe0002008f0:	0087b783          	ld	a5,8(a5)
ffffffe0002008f4:	00079663          	bnez	a5,ffffffe000200900 <do_timer+0x70>
        schedule();
ffffffe0002008f8:	038000ef          	jal	ffffffe000200930 <schedule>
ffffffe0002008fc:	0200006f          	j	ffffffe00020091c <do_timer+0x8c>
    }
    else --(current->counter);
ffffffe000200900:	00005797          	auipc	a5,0x5
ffffffe000200904:	71078793          	addi	a5,a5,1808 # ffffffe000206010 <current>
ffffffe000200908:	0007b783          	ld	a5,0(a5)
ffffffe00020090c:	0087b703          	ld	a4,8(a5)
ffffffe000200910:	fff70713          	addi	a4,a4,-1
ffffffe000200914:	00e7b423          	sd	a4,8(a5)
}
ffffffe000200918:	00000013          	nop
ffffffe00020091c:	00000013          	nop
ffffffe000200920:	00813083          	ld	ra,8(sp)
ffffffe000200924:	00013403          	ld	s0,0(sp)
ffffffe000200928:	01010113          	addi	sp,sp,16
ffffffe00020092c:	00008067          	ret

ffffffe000200930 <schedule>:

void schedule() {
ffffffe000200930:	fe010113          	addi	sp,sp,-32
ffffffe000200934:	00113c23          	sd	ra,24(sp)
ffffffe000200938:	00813823          	sd	s0,16(sp)
ffffffe00020093c:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    LOG(RED);
ffffffe000200940:	00003697          	auipc	a3,0x3
ffffffe000200944:	86868693          	addi	a3,a3,-1944 # ffffffe0002031a8 <__func__.0>
ffffffe000200948:	07f00613          	li	a2,127
ffffffe00020094c:	00002597          	auipc	a1,0x2
ffffffe000200950:	70458593          	addi	a1,a1,1796 # ffffffe000203050 <__func__.3+0x50>
ffffffe000200954:	00002517          	auipc	a0,0x2
ffffffe000200958:	70450513          	addi	a0,a0,1796 # ffffffe000203058 <__func__.3+0x58>
ffffffe00020095c:	624010ef          	jal	ffffffe000201f80 <printk>
    struct task_struct *next = idle;
ffffffe000200960:	00005797          	auipc	a5,0x5
ffffffe000200964:	6a878793          	addi	a5,a5,1704 # ffffffe000206008 <idle>
ffffffe000200968:	0007b783          	ld	a5,0(a5)
ffffffe00020096c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200970:	00100793          	li	a5,1
ffffffe000200974:	fef42223          	sw	a5,-28(s0)
ffffffe000200978:	0540006f          	j	ffffffe0002009cc <schedule+0x9c>
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
ffffffe0002009a0:	02e7f063          	bgeu	a5,a4,ffffffe0002009c0 <schedule+0x90>
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
ffffffe0002009d8:	fae7d2e3          	bge	a5,a4,ffffffe00020097c <schedule+0x4c>
        }
    }

    if(next->counter == 0) {
ffffffe0002009dc:	fe843783          	ld	a5,-24(s0)
ffffffe0002009e0:	0087b783          	ld	a5,8(a5)
ffffffe0002009e4:	0c079e63          	bnez	a5,ffffffe000200ac0 <schedule+0x190>
        printk("\n");
ffffffe0002009e8:	00002517          	auipc	a0,0x2
ffffffe0002009ec:	76050513          	addi	a0,a0,1888 # ffffffe000203148 <__func__.3+0x148>
ffffffe0002009f0:	590010ef          	jal	ffffffe000201f80 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009f4:	00100793          	li	a5,1
ffffffe0002009f8:	fef42023          	sw	a5,-32(s0)
ffffffe0002009fc:	0ac0006f          	j	ffffffe000200aa8 <schedule+0x178>
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
ffffffe000200a94:	6c050513          	addi	a0,a0,1728 # ffffffe000203150 <__func__.3+0x150>
ffffffe000200a98:	4e8010ef          	jal	ffffffe000201f80 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a9c:	fe042783          	lw	a5,-32(s0)
ffffffe000200aa0:	0017879b          	addiw	a5,a5,1
ffffffe000200aa4:	fef42023          	sw	a5,-32(s0)
ffffffe000200aa8:	fe042783          	lw	a5,-32(s0)
ffffffe000200aac:	0007871b          	sext.w	a4,a5
ffffffe000200ab0:	01f00793          	li	a5,31
ffffffe000200ab4:	f4e7d6e3          	bge	a5,a4,ffffffe000200a00 <schedule+0xd0>
        }
        schedule();
ffffffe000200ab8:	e79ff0ef          	jal	ffffffe000200930 <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200abc:	00c0006f          	j	ffffffe000200ac8 <schedule+0x198>
        switch_to(next);
ffffffe000200ac0:	fe843503          	ld	a0,-24(s0)
ffffffe000200ac4:	cc1ff0ef          	jal	ffffffe000200784 <switch_to>
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
ffffffe000200adc:	f8010113          	addi	sp,sp,-128
ffffffe000200ae0:	06813c23          	sd	s0,120(sp)
ffffffe000200ae4:	06913823          	sd	s1,112(sp)
ffffffe000200ae8:	07213423          	sd	s2,104(sp)
ffffffe000200aec:	07313023          	sd	s3,96(sp)
ffffffe000200af0:	08010413          	addi	s0,sp,128
ffffffe000200af4:	faa43c23          	sd	a0,-72(s0)
ffffffe000200af8:	fab43823          	sd	a1,-80(s0)
ffffffe000200afc:	fac43423          	sd	a2,-88(s0)
ffffffe000200b00:	fad43023          	sd	a3,-96(s0)
ffffffe000200b04:	f8e43c23          	sd	a4,-104(s0)
ffffffe000200b08:	f8f43823          	sd	a5,-112(s0)
ffffffe000200b0c:	f9043423          	sd	a6,-120(s0)
ffffffe000200b10:	f9143023          	sd	a7,-128(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200b14:	fb843e03          	ld	t3,-72(s0)
ffffffe000200b18:	fb043e83          	ld	t4,-80(s0)
ffffffe000200b1c:	fa843f03          	ld	t5,-88(s0)
ffffffe000200b20:	fa043f83          	ld	t6,-96(s0)
ffffffe000200b24:	f9843283          	ld	t0,-104(s0)
ffffffe000200b28:	f9043483          	ld	s1,-112(s0)
ffffffe000200b2c:	f8843903          	ld	s2,-120(s0)
ffffffe000200b30:	f8043983          	ld	s3,-128(s0)
ffffffe000200b34:	000e0893          	mv	a7,t3
ffffffe000200b38:	000e8813          	mv	a6,t4
ffffffe000200b3c:	000f0513          	mv	a0,t5
ffffffe000200b40:	000f8593          	mv	a1,t6
ffffffe000200b44:	00028613          	mv	a2,t0
ffffffe000200b48:	00048693          	mv	a3,s1
ffffffe000200b4c:	00090713          	mv	a4,s2
ffffffe000200b50:	00098793          	mv	a5,s3
ffffffe000200b54:	00000073          	ecall
ffffffe000200b58:	00050e93          	mv	t4,a0
ffffffe000200b5c:	00058e13          	mv	t3,a1
ffffffe000200b60:	fdd43023          	sd	t4,-64(s0)
ffffffe000200b64:	fdc43423          	sd	t3,-56(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200b68:	fc043783          	ld	a5,-64(s0)
ffffffe000200b6c:	fcf43823          	sd	a5,-48(s0)
ffffffe000200b70:	fc843783          	ld	a5,-56(s0)
ffffffe000200b74:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200b78:	fd043703          	ld	a4,-48(s0)
ffffffe000200b7c:	fd843783          	ld	a5,-40(s0)
ffffffe000200b80:	00070313          	mv	t1,a4
ffffffe000200b84:	00078393          	mv	t2,a5
ffffffe000200b88:	00030713          	mv	a4,t1
ffffffe000200b8c:	00038793          	mv	a5,t2
}
ffffffe000200b90:	00070513          	mv	a0,a4
ffffffe000200b94:	00078593          	mv	a1,a5
ffffffe000200b98:	07813403          	ld	s0,120(sp)
ffffffe000200b9c:	07013483          	ld	s1,112(sp)
ffffffe000200ba0:	06813903          	ld	s2,104(sp)
ffffffe000200ba4:	06013983          	ld	s3,96(sp)
ffffffe000200ba8:	08010113          	addi	sp,sp,128
ffffffe000200bac:	00008067          	ret

ffffffe000200bb0 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200bb0:	fc010113          	addi	sp,sp,-64
ffffffe000200bb4:	02113c23          	sd	ra,56(sp)
ffffffe000200bb8:	02813823          	sd	s0,48(sp)
ffffffe000200bbc:	03213423          	sd	s2,40(sp)
ffffffe000200bc0:	03313023          	sd	s3,32(sp)
ffffffe000200bc4:	04010413          	addi	s0,sp,64
ffffffe000200bc8:	00050793          	mv	a5,a0
ffffffe000200bcc:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200bd0:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200bd4:	00000893          	li	a7,0
ffffffe000200bd8:	00000813          	li	a6,0
ffffffe000200bdc:	00000793          	li	a5,0
ffffffe000200be0:	00000713          	li	a4,0
ffffffe000200be4:	00000693          	li	a3,0
ffffffe000200be8:	00200593          	li	a1,2
ffffffe000200bec:	44424537          	lui	a0,0x44424
ffffffe000200bf0:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200bf4:	ee9ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200bf8:	00050713          	mv	a4,a0
ffffffe000200bfc:	00058793          	mv	a5,a1
ffffffe000200c00:	fce43823          	sd	a4,-48(s0)
ffffffe000200c04:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c08:	fd043703          	ld	a4,-48(s0)
ffffffe000200c0c:	fd843783          	ld	a5,-40(s0)
ffffffe000200c10:	00070913          	mv	s2,a4
ffffffe000200c14:	00078993          	mv	s3,a5
ffffffe000200c18:	00090713          	mv	a4,s2
ffffffe000200c1c:	00098793          	mv	a5,s3
}
ffffffe000200c20:	00070513          	mv	a0,a4
ffffffe000200c24:	00078593          	mv	a1,a5
ffffffe000200c28:	03813083          	ld	ra,56(sp)
ffffffe000200c2c:	03013403          	ld	s0,48(sp)
ffffffe000200c30:	02813903          	ld	s2,40(sp)
ffffffe000200c34:	02013983          	ld	s3,32(sp)
ffffffe000200c38:	04010113          	addi	sp,sp,64
ffffffe000200c3c:	00008067          	ret

ffffffe000200c40 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200c40:	fc010113          	addi	sp,sp,-64
ffffffe000200c44:	02113c23          	sd	ra,56(sp)
ffffffe000200c48:	02813823          	sd	s0,48(sp)
ffffffe000200c4c:	03213423          	sd	s2,40(sp)
ffffffe000200c50:	03313023          	sd	s3,32(sp)
ffffffe000200c54:	04010413          	addi	s0,sp,64
ffffffe000200c58:	00050793          	mv	a5,a0
ffffffe000200c5c:	00058713          	mv	a4,a1
ffffffe000200c60:	fcf42623          	sw	a5,-52(s0)
ffffffe000200c64:	00070793          	mv	a5,a4
ffffffe000200c68:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200c6c:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200c70:	fc846683          	lwu	a3,-56(s0)
ffffffe000200c74:	00000893          	li	a7,0
ffffffe000200c78:	00000813          	li	a6,0
ffffffe000200c7c:	00000793          	li	a5,0
ffffffe000200c80:	00000713          	li	a4,0
ffffffe000200c84:	00000593          	li	a1,0
ffffffe000200c88:	53525537          	lui	a0,0x53525
ffffffe000200c8c:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200c90:	e4dff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200c94:	00050713          	mv	a4,a0
ffffffe000200c98:	00058793          	mv	a5,a1
ffffffe000200c9c:	fce43823          	sd	a4,-48(s0)
ffffffe000200ca0:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ca4:	fd043703          	ld	a4,-48(s0)
ffffffe000200ca8:	fd843783          	ld	a5,-40(s0)
ffffffe000200cac:	00070913          	mv	s2,a4
ffffffe000200cb0:	00078993          	mv	s3,a5
ffffffe000200cb4:	00090713          	mv	a4,s2
ffffffe000200cb8:	00098793          	mv	a5,s3
}
ffffffe000200cbc:	00070513          	mv	a0,a4
ffffffe000200cc0:	00078593          	mv	a1,a5
ffffffe000200cc4:	03813083          	ld	ra,56(sp)
ffffffe000200cc8:	03013403          	ld	s0,48(sp)
ffffffe000200ccc:	02813903          	ld	s2,40(sp)
ffffffe000200cd0:	02013983          	ld	s3,32(sp)
ffffffe000200cd4:	04010113          	addi	sp,sp,64
ffffffe000200cd8:	00008067          	ret

ffffffe000200cdc <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200cdc:	fc010113          	addi	sp,sp,-64
ffffffe000200ce0:	02113c23          	sd	ra,56(sp)
ffffffe000200ce4:	02813823          	sd	s0,48(sp)
ffffffe000200ce8:	03213423          	sd	s2,40(sp)
ffffffe000200cec:	03313023          	sd	s3,32(sp)
ffffffe000200cf0:	04010413          	addi	s0,sp,64
ffffffe000200cf4:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200cf8:	00000893          	li	a7,0
ffffffe000200cfc:	00000813          	li	a6,0
ffffffe000200d00:	00000793          	li	a5,0
ffffffe000200d04:	00000713          	li	a4,0
ffffffe000200d08:	00000693          	li	a3,0
ffffffe000200d0c:	fc843603          	ld	a2,-56(s0)
ffffffe000200d10:	00000593          	li	a1,0
ffffffe000200d14:	54495537          	lui	a0,0x54495
ffffffe000200d18:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200d1c:	dc1ff0ef          	jal	ffffffe000200adc <sbi_ecall>
ffffffe000200d20:	00050713          	mv	a4,a0
ffffffe000200d24:	00058793          	mv	a5,a1
ffffffe000200d28:	fce43823          	sd	a4,-48(s0)
ffffffe000200d2c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d30:	fd043703          	ld	a4,-48(s0)
ffffffe000200d34:	fd843783          	ld	a5,-40(s0)
ffffffe000200d38:	00070913          	mv	s2,a4
ffffffe000200d3c:	00078993          	mv	s3,a5
ffffffe000200d40:	00090713          	mv	a4,s2
ffffffe000200d44:	00098793          	mv	a5,s3
}
ffffffe000200d48:	00070513          	mv	a0,a4
ffffffe000200d4c:	00078593          	mv	a1,a5
ffffffe000200d50:	03813083          	ld	ra,56(sp)
ffffffe000200d54:	03013403          	ld	s0,48(sp)
ffffffe000200d58:	02813903          	ld	s2,40(sp)
ffffffe000200d5c:	02013983          	ld	s3,32(sp)
ffffffe000200d60:	04010113          	addi	sp,sp,64
ffffffe000200d64:	00008067          	ret

ffffffe000200d68 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200d68:	fb010113          	addi	sp,sp,-80
ffffffe000200d6c:	04113423          	sd	ra,72(sp)
ffffffe000200d70:	04813023          	sd	s0,64(sp)
ffffffe000200d74:	03213c23          	sd	s2,56(sp)
ffffffe000200d78:	03313823          	sd	s3,48(sp)
ffffffe000200d7c:	05010413          	addi	s0,sp,80
ffffffe000200d80:	fca43423          	sd	a0,-56(s0)
ffffffe000200d84:	fcb43023          	sd	a1,-64(s0)
ffffffe000200d88:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200d8c:	00000893          	li	a7,0
ffffffe000200d90:	00000813          	li	a6,0
ffffffe000200d94:	00000793          	li	a5,0
ffffffe000200d98:	fb843703          	ld	a4,-72(s0)
ffffffe000200d9c:	fc043683          	ld	a3,-64(s0)
ffffffe000200da0:	fc843603          	ld	a2,-56(s0)
ffffffe000200da4:	00100593          	li	a1,1
ffffffe000200da8:	44424537          	lui	a0,0x44424
ffffffe000200dac:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200db0:	d2dff0ef          	jal	ffffffe000200adc <sbi_ecall>
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
ffffffe000200de4:	04813083          	ld	ra,72(sp)
ffffffe000200de8:	04013403          	ld	s0,64(sp)
ffffffe000200dec:	03813903          	ld	s2,56(sp)
ffffffe000200df0:	03013983          	ld	s3,48(sp)
ffffffe000200df4:	05010113          	addi	sp,sp,80
ffffffe000200df8:	00008067          	ret

ffffffe000200dfc <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
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
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e20:	00000893          	li	a7,0
ffffffe000200e24:	00000813          	li	a6,0
ffffffe000200e28:	00000793          	li	a5,0
ffffffe000200e2c:	fb843703          	ld	a4,-72(s0)
ffffffe000200e30:	fc043683          	ld	a3,-64(s0)
ffffffe000200e34:	fc843603          	ld	a2,-56(s0)
ffffffe000200e38:	00000593          	li	a1,0
ffffffe000200e3c:	44424537          	lui	a0,0x44424
ffffffe000200e40:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e44:	c99ff0ef          	jal	ffffffe000200adc <sbi_ecall>
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
ffffffe000200e70:	00070513          	mv	a0,a4
ffffffe000200e74:	00078593          	mv	a1,a5
ffffffe000200e78:	04813083          	ld	ra,72(sp)
ffffffe000200e7c:	04013403          	ld	s0,64(sp)
ffffffe000200e80:	03813903          	ld	s2,56(sp)
ffffffe000200e84:	03013983          	ld	s3,48(sp)
ffffffe000200e88:	05010113          	addi	sp,sp,80
ffffffe000200e8c:	00008067          	ret

ffffffe000200e90 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200e90:	fe010113          	addi	sp,sp,-32
ffffffe000200e94:	00113c23          	sd	ra,24(sp)
ffffffe000200e98:	00813823          	sd	s0,16(sp)
ffffffe000200e9c:	02010413          	addi	s0,sp,32
ffffffe000200ea0:	fea43423          	sd	a0,-24(s0)
ffffffe000200ea4:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200ea8:	fe843783          	ld	a5,-24(s0)
ffffffe000200eac:	0207d063          	bgez	a5,ffffffe000200ecc <trap_handler+0x3c>
ffffffe000200eb0:	fe843783          	ld	a5,-24(s0)
ffffffe000200eb4:	0ff7f713          	zext.b	a4,a5
ffffffe000200eb8:	00500793          	li	a5,5
ffffffe000200ebc:	00f71863          	bne	a4,a5,ffffffe000200ecc <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200ec0:	b98ff0ef          	jal	ffffffe000200258 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200ec4:	9cdff0ef          	jal	ffffffe000200890 <do_timer>
ffffffe000200ec8:	01c0006f          	j	ffffffe000200ee4 <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200ecc:	fe043603          	ld	a2,-32(s0)
ffffffe000200ed0:	fe843583          	ld	a1,-24(s0)
ffffffe000200ed4:	00002517          	auipc	a0,0x2
ffffffe000200ed8:	2e450513          	addi	a0,a0,740 # ffffffe0002031b8 <__func__.0+0x10>
ffffffe000200edc:	0a4010ef          	jal	ffffffe000201f80 <printk>
    }
ffffffe000200ee0:	00000013          	nop
ffffffe000200ee4:	00000013          	nop
ffffffe000200ee8:	01813083          	ld	ra,24(sp)
ffffffe000200eec:	01013403          	ld	s0,16(sp)
ffffffe000200ef0:	02010113          	addi	sp,sp,32
ffffffe000200ef4:	00008067          	ret

ffffffe000200ef8 <setup_vm>:
#include "string.h"

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000200ef8:	fd010113          	addi	sp,sp,-48
ffffffe000200efc:	02113423          	sd	ra,40(sp)
ffffffe000200f00:	02813023          	sd	s0,32(sp)
ffffffe000200f04:	03010413          	addi	s0,sp,48
                                                     │   │ └──────────────── A - Accessed
                                                     │   └────────────────── D - Dirty (0 in page directory)
                                                     └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200f08:	00001637          	lui	a2,0x1
ffffffe000200f0c:	00000593          	li	a1,0
ffffffe000200f10:	00006517          	auipc	a0,0x6
ffffffe000200f14:	0f050513          	addi	a0,a0,240 # ffffffe000207000 <early_pgtbl>
ffffffe000200f18:	188010ef          	jal	ffffffe0002020a0 <memset>

    for(uint64_t i = 0; i < (1 << 9); i++) {
ffffffe000200f1c:	fe043423          	sd	zero,-24(s0)
ffffffe000200f20:	0dc0006f          	j	ffffffe000200ffc <setup_vm+0x104>
        uint64_t virtual_page_number = (i << 18); // 大页的开头的第一个小页页号
ffffffe000200f24:	fe843783          	ld	a5,-24(s0)
ffffffe000200f28:	01279793          	slli	a5,a5,0x12
ffffffe000200f2c:	fcf43c23          	sd	a5,-40(s0)
        uint64_t physical_page_number = 0;
ffffffe000200f30:	fe043023          	sd	zero,-32(s0)
        if(virtual_page_number == (PHY_START >> 12) || virtual_page_number == (VM_START >> 12)) {
ffffffe000200f34:	fd843703          	ld	a4,-40(s0)
ffffffe000200f38:	000807b7          	lui	a5,0x80
ffffffe000200f3c:	00f70c63          	beq	a4,a5,ffffffe000200f54 <setup_vm+0x5c>
ffffffe000200f40:	fd843703          	ld	a4,-40(s0)
ffffffe000200f44:	080007b7          	lui	a5,0x8000
ffffffe000200f48:	fff78793          	addi	a5,a5,-1 # 7ffffff <OPENSBI_SIZE+0x7dfffff>
ffffffe000200f4c:	01979793          	slli	a5,a5,0x19
ffffffe000200f50:	02f71863          	bne	a4,a5,ffffffe000200f80 <setup_vm+0x88>
            LOG(RED "%lx\n", (PHY_START >> 12));
ffffffe000200f54:	00080737          	lui	a4,0x80
ffffffe000200f58:	00002697          	auipc	a3,0x2
ffffffe000200f5c:	2e868693          	addi	a3,a3,744 # ffffffe000203240 <__func__.0>
ffffffe000200f60:	02900613          	li	a2,41
ffffffe000200f64:	00002597          	auipc	a1,0x2
ffffffe000200f68:	29458593          	addi	a1,a1,660 # ffffffe0002031f8 <__func__.0+0x50>
ffffffe000200f6c:	00002517          	auipc	a0,0x2
ffffffe000200f70:	29450513          	addi	a0,a0,660 # ffffffe000203200 <__func__.0+0x58>
ffffffe000200f74:	00c010ef          	jal	ffffffe000201f80 <printk>
            physical_page_number = (PHY_START >> 12);
ffffffe000200f78:	000807b7          	lui	a5,0x80
ffffffe000200f7c:	fef43023          	sd	a5,-32(s0)
        }
        
        // 设置 PPN
        early_pgtbl[i] |= (physical_page_number << 10);
ffffffe000200f80:	00006717          	auipc	a4,0x6
ffffffe000200f84:	08070713          	addi	a4,a4,128 # ffffffe000207000 <early_pgtbl>
ffffffe000200f88:	fe843783          	ld	a5,-24(s0)
ffffffe000200f8c:	00379793          	slli	a5,a5,0x3
ffffffe000200f90:	00f707b3          	add	a5,a4,a5
ffffffe000200f94:	0007b703          	ld	a4,0(a5) # 80000 <PGSIZE+0x7f000>
ffffffe000200f98:	fe043783          	ld	a5,-32(s0)
ffffffe000200f9c:	00a79793          	slli	a5,a5,0xa
ffffffe000200fa0:	00f76733          	or	a4,a4,a5
ffffffe000200fa4:	00006697          	auipc	a3,0x6
ffffffe000200fa8:	05c68693          	addi	a3,a3,92 # ffffffe000207000 <early_pgtbl>
ffffffe000200fac:	fe843783          	ld	a5,-24(s0)
ffffffe000200fb0:	00379793          	slli	a5,a5,0x3
ffffffe000200fb4:	00f687b3          	add	a5,a3,a5
ffffffe000200fb8:	00e7b023          	sd	a4,0(a5)
        // V | R | W | X 设置为 1
        early_pgtbl[i] |= ((1 << 4) - 1);
ffffffe000200fbc:	00006717          	auipc	a4,0x6
ffffffe000200fc0:	04470713          	addi	a4,a4,68 # ffffffe000207000 <early_pgtbl>
ffffffe000200fc4:	fe843783          	ld	a5,-24(s0)
ffffffe000200fc8:	00379793          	slli	a5,a5,0x3
ffffffe000200fcc:	00f707b3          	add	a5,a4,a5
ffffffe000200fd0:	0007b783          	ld	a5,0(a5)
ffffffe000200fd4:	00f7e713          	ori	a4,a5,15
ffffffe000200fd8:	00006697          	auipc	a3,0x6
ffffffe000200fdc:	02868693          	addi	a3,a3,40 # ffffffe000207000 <early_pgtbl>
ffffffe000200fe0:	fe843783          	ld	a5,-24(s0)
ffffffe000200fe4:	00379793          	slli	a5,a5,0x3
ffffffe000200fe8:	00f687b3          	add	a5,a3,a5
ffffffe000200fec:	00e7b023          	sd	a4,0(a5)
    for(uint64_t i = 0; i < (1 << 9); i++) {
ffffffe000200ff0:	fe843783          	ld	a5,-24(s0)
ffffffe000200ff4:	00178793          	addi	a5,a5,1
ffffffe000200ff8:	fef43423          	sd	a5,-24(s0)
ffffffe000200ffc:	fe843703          	ld	a4,-24(s0)
ffffffe000201000:	1ff00793          	li	a5,511
ffffffe000201004:	f2e7f0e3          	bgeu	a5,a4,ffffffe000200f24 <setup_vm+0x2c>
    }

    printk("...setup_vm done!\n");
ffffffe000201008:	00002517          	auipc	a0,0x2
ffffffe00020100c:	22050513          	addi	a0,a0,544 # ffffffe000203228 <__func__.0+0x80>
ffffffe000201010:	771000ef          	jal	ffffffe000201f80 <printk>
ffffffe000201014:	00000013          	nop
ffffffe000201018:	02813083          	ld	ra,40(sp)
ffffffe00020101c:	02013403          	ld	s0,32(sp)
ffffffe000201020:	03010113          	addi	sp,sp,48
ffffffe000201024:	00008067          	ret

ffffffe000201028 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe000201028:	ff010113          	addi	sp,sp,-16
ffffffe00020102c:	00113423          	sd	ra,8(sp)
ffffffe000201030:	00813023          	sd	s0,0(sp)
ffffffe000201034:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe000201038:	00002517          	auipc	a0,0x2
ffffffe00020103c:	21850513          	addi	a0,a0,536 # ffffffe000203250 <__func__.0+0x10>
ffffffe000201040:	741000ef          	jal	ffffffe000201f80 <printk>
    printk(" ZJU Operating System\n");
ffffffe000201044:	00002517          	auipc	a0,0x2
ffffffe000201048:	21450513          	addi	a0,a0,532 # ffffffe000203258 <__func__.0+0x18>
ffffffe00020104c:	735000ef          	jal	ffffffe000201f80 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe000201050:	088000ef          	jal	ffffffe0002010d8 <run_idle>
    return 0;
ffffffe000201054:	00000793          	li	a5,0
}
ffffffe000201058:	00078513          	mv	a0,a5
ffffffe00020105c:	00813083          	ld	ra,8(sp)
ffffffe000201060:	00013403          	ld	s0,0(sp)
ffffffe000201064:	01010113          	addi	sp,sp,16
ffffffe000201068:	00008067          	ret

ffffffe00020106c <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe00020106c:	ff010113          	addi	sp,sp,-16
ffffffe000201070:	00113423          	sd	ra,8(sp)
ffffffe000201074:	00813023          	sd	s0,0(sp)
ffffffe000201078:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe00020107c:	00000593          	li	a1,0
ffffffe000201080:	00000513          	li	a0,0
ffffffe000201084:	bbdff0ef          	jal	ffffffe000200c40 <sbi_system_reset>

ffffffe000201088 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe000201088:	fe010113          	addi	sp,sp,-32
ffffffe00020108c:	00113c23          	sd	ra,24(sp)
ffffffe000201090:	00813823          	sd	s0,16(sp)
ffffffe000201094:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe000201098:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe00020109c:	fec42783          	lw	a5,-20(s0)
ffffffe0002010a0:	0017879b          	addiw	a5,a5,1
ffffffe0002010a4:	fef42623          	sw	a5,-20(s0)
ffffffe0002010a8:	fec42783          	lw	a5,-20(s0)
ffffffe0002010ac:	00078713          	mv	a4,a5
ffffffe0002010b0:	05f5e7b7          	lui	a5,0x5f5e
ffffffe0002010b4:	1007879b          	addiw	a5,a5,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe0002010b8:	02f767bb          	remw	a5,a4,a5
ffffffe0002010bc:	0007879b          	sext.w	a5,a5
ffffffe0002010c0:	fc079ee3          	bnez	a5,ffffffe00020109c <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe0002010c4:	00002517          	auipc	a0,0x2
ffffffe0002010c8:	1ac50513          	addi	a0,a0,428 # ffffffe000203270 <__func__.0+0x30>
ffffffe0002010cc:	6b5000ef          	jal	ffffffe000201f80 <printk>
            i = 0;
ffffffe0002010d0:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe0002010d4:	fc9ff06f          	j	ffffffe00020109c <test+0x14>

ffffffe0002010d8 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe0002010d8:	ff010113          	addi	sp,sp,-16
ffffffe0002010dc:	00813423          	sd	s0,8(sp)
ffffffe0002010e0:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe0002010e4:	00000013          	nop
ffffffe0002010e8:	ffdff06f          	j	ffffffe0002010e4 <run_idle+0xc>

ffffffe0002010ec <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe0002010ec:	fe010113          	addi	sp,sp,-32
ffffffe0002010f0:	00113c23          	sd	ra,24(sp)
ffffffe0002010f4:	00813823          	sd	s0,16(sp)
ffffffe0002010f8:	02010413          	addi	s0,sp,32
ffffffe0002010fc:	00050793          	mv	a5,a0
ffffffe000201100:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe000201104:	fec42783          	lw	a5,-20(s0)
ffffffe000201108:	0ff7f793          	zext.b	a5,a5
ffffffe00020110c:	00078513          	mv	a0,a5
ffffffe000201110:	aa1ff0ef          	jal	ffffffe000200bb0 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe000201114:	fec42783          	lw	a5,-20(s0)
ffffffe000201118:	0ff7f793          	zext.b	a5,a5
ffffffe00020111c:	0007879b          	sext.w	a5,a5
}
ffffffe000201120:	00078513          	mv	a0,a5
ffffffe000201124:	01813083          	ld	ra,24(sp)
ffffffe000201128:	01013403          	ld	s0,16(sp)
ffffffe00020112c:	02010113          	addi	sp,sp,32
ffffffe000201130:	00008067          	ret

ffffffe000201134 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe000201134:	fe010113          	addi	sp,sp,-32
ffffffe000201138:	00813c23          	sd	s0,24(sp)
ffffffe00020113c:	02010413          	addi	s0,sp,32
ffffffe000201140:	00050793          	mv	a5,a0
ffffffe000201144:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe000201148:	fec42783          	lw	a5,-20(s0)
ffffffe00020114c:	0007871b          	sext.w	a4,a5
ffffffe000201150:	02000793          	li	a5,32
ffffffe000201154:	02f70263          	beq	a4,a5,ffffffe000201178 <isspace+0x44>
ffffffe000201158:	fec42783          	lw	a5,-20(s0)
ffffffe00020115c:	0007871b          	sext.w	a4,a5
ffffffe000201160:	00800793          	li	a5,8
ffffffe000201164:	00e7de63          	bge	a5,a4,ffffffe000201180 <isspace+0x4c>
ffffffe000201168:	fec42783          	lw	a5,-20(s0)
ffffffe00020116c:	0007871b          	sext.w	a4,a5
ffffffe000201170:	00d00793          	li	a5,13
ffffffe000201174:	00e7c663          	blt	a5,a4,ffffffe000201180 <isspace+0x4c>
ffffffe000201178:	00100793          	li	a5,1
ffffffe00020117c:	0080006f          	j	ffffffe000201184 <isspace+0x50>
ffffffe000201180:	00000793          	li	a5,0
}
ffffffe000201184:	00078513          	mv	a0,a5
ffffffe000201188:	01813403          	ld	s0,24(sp)
ffffffe00020118c:	02010113          	addi	sp,sp,32
ffffffe000201190:	00008067          	ret

ffffffe000201194 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe000201194:	fb010113          	addi	sp,sp,-80
ffffffe000201198:	04113423          	sd	ra,72(sp)
ffffffe00020119c:	04813023          	sd	s0,64(sp)
ffffffe0002011a0:	05010413          	addi	s0,sp,80
ffffffe0002011a4:	fca43423          	sd	a0,-56(s0)
ffffffe0002011a8:	fcb43023          	sd	a1,-64(s0)
ffffffe0002011ac:	00060793          	mv	a5,a2
ffffffe0002011b0:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe0002011b4:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe0002011b8:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe0002011bc:	fc843783          	ld	a5,-56(s0)
ffffffe0002011c0:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe0002011c4:	0100006f          	j	ffffffe0002011d4 <strtol+0x40>
        p++;
ffffffe0002011c8:	fd843783          	ld	a5,-40(s0)
ffffffe0002011cc:	00178793          	addi	a5,a5,1
ffffffe0002011d0:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe0002011d4:	fd843783          	ld	a5,-40(s0)
ffffffe0002011d8:	0007c783          	lbu	a5,0(a5)
ffffffe0002011dc:	0007879b          	sext.w	a5,a5
ffffffe0002011e0:	00078513          	mv	a0,a5
ffffffe0002011e4:	f51ff0ef          	jal	ffffffe000201134 <isspace>
ffffffe0002011e8:	00050793          	mv	a5,a0
ffffffe0002011ec:	fc079ee3          	bnez	a5,ffffffe0002011c8 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe0002011f0:	fd843783          	ld	a5,-40(s0)
ffffffe0002011f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002011f8:	00078713          	mv	a4,a5
ffffffe0002011fc:	02d00793          	li	a5,45
ffffffe000201200:	00f71e63          	bne	a4,a5,ffffffe00020121c <strtol+0x88>
        neg = true;
ffffffe000201204:	00100793          	li	a5,1
ffffffe000201208:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe00020120c:	fd843783          	ld	a5,-40(s0)
ffffffe000201210:	00178793          	addi	a5,a5,1
ffffffe000201214:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201218:	0240006f          	j	ffffffe00020123c <strtol+0xa8>
    } else if (*p == '+') {
ffffffe00020121c:	fd843783          	ld	a5,-40(s0)
ffffffe000201220:	0007c783          	lbu	a5,0(a5)
ffffffe000201224:	00078713          	mv	a4,a5
ffffffe000201228:	02b00793          	li	a5,43
ffffffe00020122c:	00f71863          	bne	a4,a5,ffffffe00020123c <strtol+0xa8>
        p++;
ffffffe000201230:	fd843783          	ld	a5,-40(s0)
ffffffe000201234:	00178793          	addi	a5,a5,1
ffffffe000201238:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe00020123c:	fbc42783          	lw	a5,-68(s0)
ffffffe000201240:	0007879b          	sext.w	a5,a5
ffffffe000201244:	06079c63          	bnez	a5,ffffffe0002012bc <strtol+0x128>
        if (*p == '0') {
ffffffe000201248:	fd843783          	ld	a5,-40(s0)
ffffffe00020124c:	0007c783          	lbu	a5,0(a5)
ffffffe000201250:	00078713          	mv	a4,a5
ffffffe000201254:	03000793          	li	a5,48
ffffffe000201258:	04f71e63          	bne	a4,a5,ffffffe0002012b4 <strtol+0x120>
            p++;
ffffffe00020125c:	fd843783          	ld	a5,-40(s0)
ffffffe000201260:	00178793          	addi	a5,a5,1
ffffffe000201264:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe000201268:	fd843783          	ld	a5,-40(s0)
ffffffe00020126c:	0007c783          	lbu	a5,0(a5)
ffffffe000201270:	00078713          	mv	a4,a5
ffffffe000201274:	07800793          	li	a5,120
ffffffe000201278:	00f70c63          	beq	a4,a5,ffffffe000201290 <strtol+0xfc>
ffffffe00020127c:	fd843783          	ld	a5,-40(s0)
ffffffe000201280:	0007c783          	lbu	a5,0(a5)
ffffffe000201284:	00078713          	mv	a4,a5
ffffffe000201288:	05800793          	li	a5,88
ffffffe00020128c:	00f71e63          	bne	a4,a5,ffffffe0002012a8 <strtol+0x114>
                base = 16;
ffffffe000201290:	01000793          	li	a5,16
ffffffe000201294:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000201298:	fd843783          	ld	a5,-40(s0)
ffffffe00020129c:	00178793          	addi	a5,a5,1
ffffffe0002012a0:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002012a4:	0180006f          	j	ffffffe0002012bc <strtol+0x128>
            } else {
                base = 8;
ffffffe0002012a8:	00800793          	li	a5,8
ffffffe0002012ac:	faf42e23          	sw	a5,-68(s0)
ffffffe0002012b0:	00c0006f          	j	ffffffe0002012bc <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe0002012b4:	00a00793          	li	a5,10
ffffffe0002012b8:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe0002012bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002012c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002012c4:	00078713          	mv	a4,a5
ffffffe0002012c8:	02f00793          	li	a5,47
ffffffe0002012cc:	02e7f863          	bgeu	a5,a4,ffffffe0002012fc <strtol+0x168>
ffffffe0002012d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002012d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002012d8:	00078713          	mv	a4,a5
ffffffe0002012dc:	03900793          	li	a5,57
ffffffe0002012e0:	00e7ee63          	bltu	a5,a4,ffffffe0002012fc <strtol+0x168>
            digit = *p - '0';
ffffffe0002012e4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002012ec:	0007879b          	sext.w	a5,a5
ffffffe0002012f0:	fd07879b          	addiw	a5,a5,-48
ffffffe0002012f4:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002012f8:	0800006f          	j	ffffffe000201378 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe0002012fc:	fd843783          	ld	a5,-40(s0)
ffffffe000201300:	0007c783          	lbu	a5,0(a5)
ffffffe000201304:	00078713          	mv	a4,a5
ffffffe000201308:	06000793          	li	a5,96
ffffffe00020130c:	02e7f863          	bgeu	a5,a4,ffffffe00020133c <strtol+0x1a8>
ffffffe000201310:	fd843783          	ld	a5,-40(s0)
ffffffe000201314:	0007c783          	lbu	a5,0(a5)
ffffffe000201318:	00078713          	mv	a4,a5
ffffffe00020131c:	07a00793          	li	a5,122
ffffffe000201320:	00e7ee63          	bltu	a5,a4,ffffffe00020133c <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe000201324:	fd843783          	ld	a5,-40(s0)
ffffffe000201328:	0007c783          	lbu	a5,0(a5)
ffffffe00020132c:	0007879b          	sext.w	a5,a5
ffffffe000201330:	fa97879b          	addiw	a5,a5,-87
ffffffe000201334:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201338:	0400006f          	j	ffffffe000201378 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe00020133c:	fd843783          	ld	a5,-40(s0)
ffffffe000201340:	0007c783          	lbu	a5,0(a5)
ffffffe000201344:	00078713          	mv	a4,a5
ffffffe000201348:	04000793          	li	a5,64
ffffffe00020134c:	06e7f863          	bgeu	a5,a4,ffffffe0002013bc <strtol+0x228>
ffffffe000201350:	fd843783          	ld	a5,-40(s0)
ffffffe000201354:	0007c783          	lbu	a5,0(a5)
ffffffe000201358:	00078713          	mv	a4,a5
ffffffe00020135c:	05a00793          	li	a5,90
ffffffe000201360:	04e7ee63          	bltu	a5,a4,ffffffe0002013bc <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe000201364:	fd843783          	ld	a5,-40(s0)
ffffffe000201368:	0007c783          	lbu	a5,0(a5)
ffffffe00020136c:	0007879b          	sext.w	a5,a5
ffffffe000201370:	fc97879b          	addiw	a5,a5,-55
ffffffe000201374:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000201378:	fd442783          	lw	a5,-44(s0)
ffffffe00020137c:	00078713          	mv	a4,a5
ffffffe000201380:	fbc42783          	lw	a5,-68(s0)
ffffffe000201384:	0007071b          	sext.w	a4,a4
ffffffe000201388:	0007879b          	sext.w	a5,a5
ffffffe00020138c:	02f75663          	bge	a4,a5,ffffffe0002013b8 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe000201390:	fbc42703          	lw	a4,-68(s0)
ffffffe000201394:	fe843783          	ld	a5,-24(s0)
ffffffe000201398:	02f70733          	mul	a4,a4,a5
ffffffe00020139c:	fd442783          	lw	a5,-44(s0)
ffffffe0002013a0:	00f707b3          	add	a5,a4,a5
ffffffe0002013a4:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe0002013a8:	fd843783          	ld	a5,-40(s0)
ffffffe0002013ac:	00178793          	addi	a5,a5,1
ffffffe0002013b0:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe0002013b4:	f09ff06f          	j	ffffffe0002012bc <strtol+0x128>
            break;
ffffffe0002013b8:	00000013          	nop
    }

    if (endptr) {
ffffffe0002013bc:	fc043783          	ld	a5,-64(s0)
ffffffe0002013c0:	00078863          	beqz	a5,ffffffe0002013d0 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe0002013c4:	fc043783          	ld	a5,-64(s0)
ffffffe0002013c8:	fd843703          	ld	a4,-40(s0)
ffffffe0002013cc:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe0002013d0:	fe744783          	lbu	a5,-25(s0)
ffffffe0002013d4:	0ff7f793          	zext.b	a5,a5
ffffffe0002013d8:	00078863          	beqz	a5,ffffffe0002013e8 <strtol+0x254>
ffffffe0002013dc:	fe843783          	ld	a5,-24(s0)
ffffffe0002013e0:	40f007b3          	neg	a5,a5
ffffffe0002013e4:	0080006f          	j	ffffffe0002013ec <strtol+0x258>
ffffffe0002013e8:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002013ec:	00078513          	mv	a0,a5
ffffffe0002013f0:	04813083          	ld	ra,72(sp)
ffffffe0002013f4:	04013403          	ld	s0,64(sp)
ffffffe0002013f8:	05010113          	addi	sp,sp,80
ffffffe0002013fc:	00008067          	ret

ffffffe000201400 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe000201400:	fd010113          	addi	sp,sp,-48
ffffffe000201404:	02113423          	sd	ra,40(sp)
ffffffe000201408:	02813023          	sd	s0,32(sp)
ffffffe00020140c:	03010413          	addi	s0,sp,48
ffffffe000201410:	fca43c23          	sd	a0,-40(s0)
ffffffe000201414:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe000201418:	fd043783          	ld	a5,-48(s0)
ffffffe00020141c:	00079863          	bnez	a5,ffffffe00020142c <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe000201420:	00002797          	auipc	a5,0x2
ffffffe000201424:	e6878793          	addi	a5,a5,-408 # ffffffe000203288 <__func__.0+0x48>
ffffffe000201428:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe00020142c:	fd043783          	ld	a5,-48(s0)
ffffffe000201430:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe000201434:	0240006f          	j	ffffffe000201458 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe000201438:	fe843783          	ld	a5,-24(s0)
ffffffe00020143c:	00178713          	addi	a4,a5,1
ffffffe000201440:	fee43423          	sd	a4,-24(s0)
ffffffe000201444:	0007c783          	lbu	a5,0(a5)
ffffffe000201448:	0007871b          	sext.w	a4,a5
ffffffe00020144c:	fd843783          	ld	a5,-40(s0)
ffffffe000201450:	00070513          	mv	a0,a4
ffffffe000201454:	000780e7          	jalr	a5
    while (*p) {
ffffffe000201458:	fe843783          	ld	a5,-24(s0)
ffffffe00020145c:	0007c783          	lbu	a5,0(a5)
ffffffe000201460:	fc079ce3          	bnez	a5,ffffffe000201438 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe000201464:	fe843703          	ld	a4,-24(s0)
ffffffe000201468:	fd043783          	ld	a5,-48(s0)
ffffffe00020146c:	40f707b3          	sub	a5,a4,a5
ffffffe000201470:	0007879b          	sext.w	a5,a5
}
ffffffe000201474:	00078513          	mv	a0,a5
ffffffe000201478:	02813083          	ld	ra,40(sp)
ffffffe00020147c:	02013403          	ld	s0,32(sp)
ffffffe000201480:	03010113          	addi	sp,sp,48
ffffffe000201484:	00008067          	ret

ffffffe000201488 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000201488:	f9010113          	addi	sp,sp,-112
ffffffe00020148c:	06113423          	sd	ra,104(sp)
ffffffe000201490:	06813023          	sd	s0,96(sp)
ffffffe000201494:	07010413          	addi	s0,sp,112
ffffffe000201498:	faa43423          	sd	a0,-88(s0)
ffffffe00020149c:	fab43023          	sd	a1,-96(s0)
ffffffe0002014a0:	00060793          	mv	a5,a2
ffffffe0002014a4:	f8d43823          	sd	a3,-112(s0)
ffffffe0002014a8:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe0002014ac:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002014b0:	0ff7f793          	zext.b	a5,a5
ffffffe0002014b4:	02078663          	beqz	a5,ffffffe0002014e0 <print_dec_int+0x58>
ffffffe0002014b8:	fa043703          	ld	a4,-96(s0)
ffffffe0002014bc:	fff00793          	li	a5,-1
ffffffe0002014c0:	03f79793          	slli	a5,a5,0x3f
ffffffe0002014c4:	00f71e63          	bne	a4,a5,ffffffe0002014e0 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe0002014c8:	00002597          	auipc	a1,0x2
ffffffe0002014cc:	dc858593          	addi	a1,a1,-568 # ffffffe000203290 <__func__.0+0x50>
ffffffe0002014d0:	fa843503          	ld	a0,-88(s0)
ffffffe0002014d4:	f2dff0ef          	jal	ffffffe000201400 <puts_wo_nl>
ffffffe0002014d8:	00050793          	mv	a5,a0
ffffffe0002014dc:	2a00006f          	j	ffffffe00020177c <print_dec_int+0x2f4>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe0002014e0:	f9043783          	ld	a5,-112(s0)
ffffffe0002014e4:	00c7a783          	lw	a5,12(a5)
ffffffe0002014e8:	00079a63          	bnez	a5,ffffffe0002014fc <print_dec_int+0x74>
ffffffe0002014ec:	fa043783          	ld	a5,-96(s0)
ffffffe0002014f0:	00079663          	bnez	a5,ffffffe0002014fc <print_dec_int+0x74>
        return 0;
ffffffe0002014f4:	00000793          	li	a5,0
ffffffe0002014f8:	2840006f          	j	ffffffe00020177c <print_dec_int+0x2f4>
    }

    bool neg = false;
ffffffe0002014fc:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe000201500:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201504:	0ff7f793          	zext.b	a5,a5
ffffffe000201508:	02078063          	beqz	a5,ffffffe000201528 <print_dec_int+0xa0>
ffffffe00020150c:	fa043783          	ld	a5,-96(s0)
ffffffe000201510:	0007dc63          	bgez	a5,ffffffe000201528 <print_dec_int+0xa0>
        neg = true;
ffffffe000201514:	00100793          	li	a5,1
ffffffe000201518:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe00020151c:	fa043783          	ld	a5,-96(s0)
ffffffe000201520:	40f007b3          	neg	a5,a5
ffffffe000201524:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe000201528:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe00020152c:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201530:	0ff7f793          	zext.b	a5,a5
ffffffe000201534:	02078863          	beqz	a5,ffffffe000201564 <print_dec_int+0xdc>
ffffffe000201538:	fef44783          	lbu	a5,-17(s0)
ffffffe00020153c:	0ff7f793          	zext.b	a5,a5
ffffffe000201540:	00079e63          	bnez	a5,ffffffe00020155c <print_dec_int+0xd4>
ffffffe000201544:	f9043783          	ld	a5,-112(s0)
ffffffe000201548:	0057c783          	lbu	a5,5(a5)
ffffffe00020154c:	00079863          	bnez	a5,ffffffe00020155c <print_dec_int+0xd4>
ffffffe000201550:	f9043783          	ld	a5,-112(s0)
ffffffe000201554:	0047c783          	lbu	a5,4(a5)
ffffffe000201558:	00078663          	beqz	a5,ffffffe000201564 <print_dec_int+0xdc>
ffffffe00020155c:	00100793          	li	a5,1
ffffffe000201560:	0080006f          	j	ffffffe000201568 <print_dec_int+0xe0>
ffffffe000201564:	00000793          	li	a5,0
ffffffe000201568:	fcf40ba3          	sb	a5,-41(s0)
ffffffe00020156c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201570:	0017f793          	andi	a5,a5,1
ffffffe000201574:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000201578:	fa043703          	ld	a4,-96(s0)
ffffffe00020157c:	00a00793          	li	a5,10
ffffffe000201580:	02f777b3          	remu	a5,a4,a5
ffffffe000201584:	0ff7f713          	zext.b	a4,a5
ffffffe000201588:	fe842783          	lw	a5,-24(s0)
ffffffe00020158c:	0017869b          	addiw	a3,a5,1
ffffffe000201590:	fed42423          	sw	a3,-24(s0)
ffffffe000201594:	0307071b          	addiw	a4,a4,48
ffffffe000201598:	0ff77713          	zext.b	a4,a4
ffffffe00020159c:	ff078793          	addi	a5,a5,-16
ffffffe0002015a0:	008787b3          	add	a5,a5,s0
ffffffe0002015a4:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe0002015a8:	fa043703          	ld	a4,-96(s0)
ffffffe0002015ac:	00a00793          	li	a5,10
ffffffe0002015b0:	02f757b3          	divu	a5,a4,a5
ffffffe0002015b4:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe0002015b8:	fa043783          	ld	a5,-96(s0)
ffffffe0002015bc:	fa079ee3          	bnez	a5,ffffffe000201578 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe0002015c0:	f9043783          	ld	a5,-112(s0)
ffffffe0002015c4:	00c7a783          	lw	a5,12(a5)
ffffffe0002015c8:	00078713          	mv	a4,a5
ffffffe0002015cc:	fff00793          	li	a5,-1
ffffffe0002015d0:	02f71063          	bne	a4,a5,ffffffe0002015f0 <print_dec_int+0x168>
ffffffe0002015d4:	f9043783          	ld	a5,-112(s0)
ffffffe0002015d8:	0037c783          	lbu	a5,3(a5)
ffffffe0002015dc:	00078a63          	beqz	a5,ffffffe0002015f0 <print_dec_int+0x168>
        flags->prec = flags->width;
ffffffe0002015e0:	f9043783          	ld	a5,-112(s0)
ffffffe0002015e4:	0087a703          	lw	a4,8(a5)
ffffffe0002015e8:	f9043783          	ld	a5,-112(s0)
ffffffe0002015ec:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe0002015f0:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe0002015f4:	f9043783          	ld	a5,-112(s0)
ffffffe0002015f8:	0087a703          	lw	a4,8(a5)
ffffffe0002015fc:	fe842783          	lw	a5,-24(s0)
ffffffe000201600:	fcf42823          	sw	a5,-48(s0)
ffffffe000201604:	f9043783          	ld	a5,-112(s0)
ffffffe000201608:	00c7a783          	lw	a5,12(a5)
ffffffe00020160c:	fcf42623          	sw	a5,-52(s0)
ffffffe000201610:	fd042783          	lw	a5,-48(s0)
ffffffe000201614:	00078593          	mv	a1,a5
ffffffe000201618:	fcc42783          	lw	a5,-52(s0)
ffffffe00020161c:	00078613          	mv	a2,a5
ffffffe000201620:	0006069b          	sext.w	a3,a2
ffffffe000201624:	0005879b          	sext.w	a5,a1
ffffffe000201628:	00f6d463          	bge	a3,a5,ffffffe000201630 <print_dec_int+0x1a8>
ffffffe00020162c:	00058613          	mv	a2,a1
ffffffe000201630:	0006079b          	sext.w	a5,a2
ffffffe000201634:	40f707bb          	subw	a5,a4,a5
ffffffe000201638:	0007871b          	sext.w	a4,a5
ffffffe00020163c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201640:	0007879b          	sext.w	a5,a5
ffffffe000201644:	40f707bb          	subw	a5,a4,a5
ffffffe000201648:	fef42023          	sw	a5,-32(s0)
ffffffe00020164c:	0280006f          	j	ffffffe000201674 <print_dec_int+0x1ec>
        putch(' ');
ffffffe000201650:	fa843783          	ld	a5,-88(s0)
ffffffe000201654:	02000513          	li	a0,32
ffffffe000201658:	000780e7          	jalr	a5
        ++written;
ffffffe00020165c:	fe442783          	lw	a5,-28(s0)
ffffffe000201660:	0017879b          	addiw	a5,a5,1
ffffffe000201664:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201668:	fe042783          	lw	a5,-32(s0)
ffffffe00020166c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201670:	fef42023          	sw	a5,-32(s0)
ffffffe000201674:	fe042783          	lw	a5,-32(s0)
ffffffe000201678:	0007879b          	sext.w	a5,a5
ffffffe00020167c:	fcf04ae3          	bgtz	a5,ffffffe000201650 <print_dec_int+0x1c8>
    }

    if (has_sign_char) {
ffffffe000201680:	fd744783          	lbu	a5,-41(s0)
ffffffe000201684:	0ff7f793          	zext.b	a5,a5
ffffffe000201688:	04078463          	beqz	a5,ffffffe0002016d0 <print_dec_int+0x248>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe00020168c:	fef44783          	lbu	a5,-17(s0)
ffffffe000201690:	0ff7f793          	zext.b	a5,a5
ffffffe000201694:	00078663          	beqz	a5,ffffffe0002016a0 <print_dec_int+0x218>
ffffffe000201698:	02d00793          	li	a5,45
ffffffe00020169c:	01c0006f          	j	ffffffe0002016b8 <print_dec_int+0x230>
ffffffe0002016a0:	f9043783          	ld	a5,-112(s0)
ffffffe0002016a4:	0057c783          	lbu	a5,5(a5)
ffffffe0002016a8:	00078663          	beqz	a5,ffffffe0002016b4 <print_dec_int+0x22c>
ffffffe0002016ac:	02b00793          	li	a5,43
ffffffe0002016b0:	0080006f          	j	ffffffe0002016b8 <print_dec_int+0x230>
ffffffe0002016b4:	02000793          	li	a5,32
ffffffe0002016b8:	fa843703          	ld	a4,-88(s0)
ffffffe0002016bc:	00078513          	mv	a0,a5
ffffffe0002016c0:	000700e7          	jalr	a4
        ++written;
ffffffe0002016c4:	fe442783          	lw	a5,-28(s0)
ffffffe0002016c8:	0017879b          	addiw	a5,a5,1
ffffffe0002016cc:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe0002016d0:	fe842783          	lw	a5,-24(s0)
ffffffe0002016d4:	fcf42e23          	sw	a5,-36(s0)
ffffffe0002016d8:	0280006f          	j	ffffffe000201700 <print_dec_int+0x278>
        putch('0');
ffffffe0002016dc:	fa843783          	ld	a5,-88(s0)
ffffffe0002016e0:	03000513          	li	a0,48
ffffffe0002016e4:	000780e7          	jalr	a5
        ++written;
ffffffe0002016e8:	fe442783          	lw	a5,-28(s0)
ffffffe0002016ec:	0017879b          	addiw	a5,a5,1
ffffffe0002016f0:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe0002016f4:	fdc42783          	lw	a5,-36(s0)
ffffffe0002016f8:	0017879b          	addiw	a5,a5,1
ffffffe0002016fc:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201700:	f9043783          	ld	a5,-112(s0)
ffffffe000201704:	00c7a703          	lw	a4,12(a5)
ffffffe000201708:	fd744783          	lbu	a5,-41(s0)
ffffffe00020170c:	0007879b          	sext.w	a5,a5
ffffffe000201710:	40f707bb          	subw	a5,a4,a5
ffffffe000201714:	0007871b          	sext.w	a4,a5
ffffffe000201718:	fdc42783          	lw	a5,-36(s0)
ffffffe00020171c:	0007879b          	sext.w	a5,a5
ffffffe000201720:	fae7cee3          	blt	a5,a4,ffffffe0002016dc <print_dec_int+0x254>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201724:	fe842783          	lw	a5,-24(s0)
ffffffe000201728:	fff7879b          	addiw	a5,a5,-1
ffffffe00020172c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201730:	03c0006f          	j	ffffffe00020176c <print_dec_int+0x2e4>
        putch(buf[i]);
ffffffe000201734:	fd842783          	lw	a5,-40(s0)
ffffffe000201738:	ff078793          	addi	a5,a5,-16
ffffffe00020173c:	008787b3          	add	a5,a5,s0
ffffffe000201740:	fc87c783          	lbu	a5,-56(a5)
ffffffe000201744:	0007871b          	sext.w	a4,a5
ffffffe000201748:	fa843783          	ld	a5,-88(s0)
ffffffe00020174c:	00070513          	mv	a0,a4
ffffffe000201750:	000780e7          	jalr	a5
        ++written;
ffffffe000201754:	fe442783          	lw	a5,-28(s0)
ffffffe000201758:	0017879b          	addiw	a5,a5,1
ffffffe00020175c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201760:	fd842783          	lw	a5,-40(s0)
ffffffe000201764:	fff7879b          	addiw	a5,a5,-1
ffffffe000201768:	fcf42c23          	sw	a5,-40(s0)
ffffffe00020176c:	fd842783          	lw	a5,-40(s0)
ffffffe000201770:	0007879b          	sext.w	a5,a5
ffffffe000201774:	fc07d0e3          	bgez	a5,ffffffe000201734 <print_dec_int+0x2ac>
    }

    return written;
ffffffe000201778:	fe442783          	lw	a5,-28(s0)
}
ffffffe00020177c:	00078513          	mv	a0,a5
ffffffe000201780:	06813083          	ld	ra,104(sp)
ffffffe000201784:	06013403          	ld	s0,96(sp)
ffffffe000201788:	07010113          	addi	sp,sp,112
ffffffe00020178c:	00008067          	ret

ffffffe000201790 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201790:	f4010113          	addi	sp,sp,-192
ffffffe000201794:	0a113c23          	sd	ra,184(sp)
ffffffe000201798:	0a813823          	sd	s0,176(sp)
ffffffe00020179c:	0c010413          	addi	s0,sp,192
ffffffe0002017a0:	f4a43c23          	sd	a0,-168(s0)
ffffffe0002017a4:	f4b43823          	sd	a1,-176(s0)
ffffffe0002017a8:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe0002017ac:	f8043023          	sd	zero,-128(s0)
ffffffe0002017b0:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe0002017b4:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe0002017b8:	7a40006f          	j	ffffffe000201f5c <vprintfmt+0x7cc>
        if (flags.in_format) {
ffffffe0002017bc:	f8044783          	lbu	a5,-128(s0)
ffffffe0002017c0:	72078e63          	beqz	a5,ffffffe000201efc <vprintfmt+0x76c>
            if (*fmt == '#') {
ffffffe0002017c4:	f5043783          	ld	a5,-176(s0)
ffffffe0002017c8:	0007c783          	lbu	a5,0(a5)
ffffffe0002017cc:	00078713          	mv	a4,a5
ffffffe0002017d0:	02300793          	li	a5,35
ffffffe0002017d4:	00f71863          	bne	a4,a5,ffffffe0002017e4 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe0002017d8:	00100793          	li	a5,1
ffffffe0002017dc:	f8f40123          	sb	a5,-126(s0)
ffffffe0002017e0:	7700006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == '0') {
ffffffe0002017e4:	f5043783          	ld	a5,-176(s0)
ffffffe0002017e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002017ec:	00078713          	mv	a4,a5
ffffffe0002017f0:	03000793          	li	a5,48
ffffffe0002017f4:	00f71863          	bne	a4,a5,ffffffe000201804 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe0002017f8:	00100793          	li	a5,1
ffffffe0002017fc:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201800:	7500006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201804:	f5043783          	ld	a5,-176(s0)
ffffffe000201808:	0007c783          	lbu	a5,0(a5)
ffffffe00020180c:	00078713          	mv	a4,a5
ffffffe000201810:	06c00793          	li	a5,108
ffffffe000201814:	04f70063          	beq	a4,a5,ffffffe000201854 <vprintfmt+0xc4>
ffffffe000201818:	f5043783          	ld	a5,-176(s0)
ffffffe00020181c:	0007c783          	lbu	a5,0(a5)
ffffffe000201820:	00078713          	mv	a4,a5
ffffffe000201824:	07a00793          	li	a5,122
ffffffe000201828:	02f70663          	beq	a4,a5,ffffffe000201854 <vprintfmt+0xc4>
ffffffe00020182c:	f5043783          	ld	a5,-176(s0)
ffffffe000201830:	0007c783          	lbu	a5,0(a5)
ffffffe000201834:	00078713          	mv	a4,a5
ffffffe000201838:	07400793          	li	a5,116
ffffffe00020183c:	00f70c63          	beq	a4,a5,ffffffe000201854 <vprintfmt+0xc4>
ffffffe000201840:	f5043783          	ld	a5,-176(s0)
ffffffe000201844:	0007c783          	lbu	a5,0(a5)
ffffffe000201848:	00078713          	mv	a4,a5
ffffffe00020184c:	06a00793          	li	a5,106
ffffffe000201850:	00f71863          	bne	a4,a5,ffffffe000201860 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201854:	00100793          	li	a5,1
ffffffe000201858:	f8f400a3          	sb	a5,-127(s0)
ffffffe00020185c:	6f40006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == '+') {
ffffffe000201860:	f5043783          	ld	a5,-176(s0)
ffffffe000201864:	0007c783          	lbu	a5,0(a5)
ffffffe000201868:	00078713          	mv	a4,a5
ffffffe00020186c:	02b00793          	li	a5,43
ffffffe000201870:	00f71863          	bne	a4,a5,ffffffe000201880 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201874:	00100793          	li	a5,1
ffffffe000201878:	f8f402a3          	sb	a5,-123(s0)
ffffffe00020187c:	6d40006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == ' ') {
ffffffe000201880:	f5043783          	ld	a5,-176(s0)
ffffffe000201884:	0007c783          	lbu	a5,0(a5)
ffffffe000201888:	00078713          	mv	a4,a5
ffffffe00020188c:	02000793          	li	a5,32
ffffffe000201890:	00f71863          	bne	a4,a5,ffffffe0002018a0 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201894:	00100793          	li	a5,1
ffffffe000201898:	f8f40223          	sb	a5,-124(s0)
ffffffe00020189c:	6b40006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == '*') {
ffffffe0002018a0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018a4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018a8:	00078713          	mv	a4,a5
ffffffe0002018ac:	02a00793          	li	a5,42
ffffffe0002018b0:	00f71e63          	bne	a4,a5,ffffffe0002018cc <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe0002018b4:	f4843783          	ld	a5,-184(s0)
ffffffe0002018b8:	00878713          	addi	a4,a5,8
ffffffe0002018bc:	f4e43423          	sd	a4,-184(s0)
ffffffe0002018c0:	0007a783          	lw	a5,0(a5)
ffffffe0002018c4:	f8f42423          	sw	a5,-120(s0)
ffffffe0002018c8:	6880006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe0002018cc:	f5043783          	ld	a5,-176(s0)
ffffffe0002018d0:	0007c783          	lbu	a5,0(a5)
ffffffe0002018d4:	00078713          	mv	a4,a5
ffffffe0002018d8:	03000793          	li	a5,48
ffffffe0002018dc:	04e7f663          	bgeu	a5,a4,ffffffe000201928 <vprintfmt+0x198>
ffffffe0002018e0:	f5043783          	ld	a5,-176(s0)
ffffffe0002018e4:	0007c783          	lbu	a5,0(a5)
ffffffe0002018e8:	00078713          	mv	a4,a5
ffffffe0002018ec:	03900793          	li	a5,57
ffffffe0002018f0:	02e7ec63          	bltu	a5,a4,ffffffe000201928 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe0002018f4:	f5043783          	ld	a5,-176(s0)
ffffffe0002018f8:	f5040713          	addi	a4,s0,-176
ffffffe0002018fc:	00a00613          	li	a2,10
ffffffe000201900:	00070593          	mv	a1,a4
ffffffe000201904:	00078513          	mv	a0,a5
ffffffe000201908:	88dff0ef          	jal	ffffffe000201194 <strtol>
ffffffe00020190c:	00050793          	mv	a5,a0
ffffffe000201910:	0007879b          	sext.w	a5,a5
ffffffe000201914:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201918:	f5043783          	ld	a5,-176(s0)
ffffffe00020191c:	fff78793          	addi	a5,a5,-1
ffffffe000201920:	f4f43823          	sd	a5,-176(s0)
ffffffe000201924:	62c0006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == '.') {
ffffffe000201928:	f5043783          	ld	a5,-176(s0)
ffffffe00020192c:	0007c783          	lbu	a5,0(a5)
ffffffe000201930:	00078713          	mv	a4,a5
ffffffe000201934:	02e00793          	li	a5,46
ffffffe000201938:	06f71863          	bne	a4,a5,ffffffe0002019a8 <vprintfmt+0x218>
                fmt++;
ffffffe00020193c:	f5043783          	ld	a5,-176(s0)
ffffffe000201940:	00178793          	addi	a5,a5,1
ffffffe000201944:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000201948:	f5043783          	ld	a5,-176(s0)
ffffffe00020194c:	0007c783          	lbu	a5,0(a5)
ffffffe000201950:	00078713          	mv	a4,a5
ffffffe000201954:	02a00793          	li	a5,42
ffffffe000201958:	00f71e63          	bne	a4,a5,ffffffe000201974 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe00020195c:	f4843783          	ld	a5,-184(s0)
ffffffe000201960:	00878713          	addi	a4,a5,8
ffffffe000201964:	f4e43423          	sd	a4,-184(s0)
ffffffe000201968:	0007a783          	lw	a5,0(a5)
ffffffe00020196c:	f8f42623          	sw	a5,-116(s0)
ffffffe000201970:	5e00006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201974:	f5043783          	ld	a5,-176(s0)
ffffffe000201978:	f5040713          	addi	a4,s0,-176
ffffffe00020197c:	00a00613          	li	a2,10
ffffffe000201980:	00070593          	mv	a1,a4
ffffffe000201984:	00078513          	mv	a0,a5
ffffffe000201988:	80dff0ef          	jal	ffffffe000201194 <strtol>
ffffffe00020198c:	00050793          	mv	a5,a0
ffffffe000201990:	0007879b          	sext.w	a5,a5
ffffffe000201994:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201998:	f5043783          	ld	a5,-176(s0)
ffffffe00020199c:	fff78793          	addi	a5,a5,-1
ffffffe0002019a0:	f4f43823          	sd	a5,-176(s0)
ffffffe0002019a4:	5ac0006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe0002019a8:	f5043783          	ld	a5,-176(s0)
ffffffe0002019ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002019b0:	00078713          	mv	a4,a5
ffffffe0002019b4:	07800793          	li	a5,120
ffffffe0002019b8:	02f70663          	beq	a4,a5,ffffffe0002019e4 <vprintfmt+0x254>
ffffffe0002019bc:	f5043783          	ld	a5,-176(s0)
ffffffe0002019c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002019c4:	00078713          	mv	a4,a5
ffffffe0002019c8:	05800793          	li	a5,88
ffffffe0002019cc:	00f70c63          	beq	a4,a5,ffffffe0002019e4 <vprintfmt+0x254>
ffffffe0002019d0:	f5043783          	ld	a5,-176(s0)
ffffffe0002019d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002019d8:	00078713          	mv	a4,a5
ffffffe0002019dc:	07000793          	li	a5,112
ffffffe0002019e0:	30f71263          	bne	a4,a5,ffffffe000201ce4 <vprintfmt+0x554>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe0002019e4:	f5043783          	ld	a5,-176(s0)
ffffffe0002019e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002019ec:	00078713          	mv	a4,a5
ffffffe0002019f0:	07000793          	li	a5,112
ffffffe0002019f4:	00f70663          	beq	a4,a5,ffffffe000201a00 <vprintfmt+0x270>
ffffffe0002019f8:	f8144783          	lbu	a5,-127(s0)
ffffffe0002019fc:	00078663          	beqz	a5,ffffffe000201a08 <vprintfmt+0x278>
ffffffe000201a00:	00100793          	li	a5,1
ffffffe000201a04:	0080006f          	j	ffffffe000201a0c <vprintfmt+0x27c>
ffffffe000201a08:	00000793          	li	a5,0
ffffffe000201a0c:	faf403a3          	sb	a5,-89(s0)
ffffffe000201a10:	fa744783          	lbu	a5,-89(s0)
ffffffe000201a14:	0017f793          	andi	a5,a5,1
ffffffe000201a18:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201a1c:	fa744783          	lbu	a5,-89(s0)
ffffffe000201a20:	0ff7f793          	zext.b	a5,a5
ffffffe000201a24:	00078c63          	beqz	a5,ffffffe000201a3c <vprintfmt+0x2ac>
ffffffe000201a28:	f4843783          	ld	a5,-184(s0)
ffffffe000201a2c:	00878713          	addi	a4,a5,8
ffffffe000201a30:	f4e43423          	sd	a4,-184(s0)
ffffffe000201a34:	0007b783          	ld	a5,0(a5)
ffffffe000201a38:	01c0006f          	j	ffffffe000201a54 <vprintfmt+0x2c4>
ffffffe000201a3c:	f4843783          	ld	a5,-184(s0)
ffffffe000201a40:	00878713          	addi	a4,a5,8
ffffffe000201a44:	f4e43423          	sd	a4,-184(s0)
ffffffe000201a48:	0007a783          	lw	a5,0(a5)
ffffffe000201a4c:	02079793          	slli	a5,a5,0x20
ffffffe000201a50:	0207d793          	srli	a5,a5,0x20
ffffffe000201a54:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201a58:	f8c42783          	lw	a5,-116(s0)
ffffffe000201a5c:	02079463          	bnez	a5,ffffffe000201a84 <vprintfmt+0x2f4>
ffffffe000201a60:	fe043783          	ld	a5,-32(s0)
ffffffe000201a64:	02079063          	bnez	a5,ffffffe000201a84 <vprintfmt+0x2f4>
ffffffe000201a68:	f5043783          	ld	a5,-176(s0)
ffffffe000201a6c:	0007c783          	lbu	a5,0(a5)
ffffffe000201a70:	00078713          	mv	a4,a5
ffffffe000201a74:	07000793          	li	a5,112
ffffffe000201a78:	00f70663          	beq	a4,a5,ffffffe000201a84 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201a7c:	f8040023          	sb	zero,-128(s0)
ffffffe000201a80:	4d00006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201a84:	f5043783          	ld	a5,-176(s0)
ffffffe000201a88:	0007c783          	lbu	a5,0(a5)
ffffffe000201a8c:	00078713          	mv	a4,a5
ffffffe000201a90:	07000793          	li	a5,112
ffffffe000201a94:	00f70a63          	beq	a4,a5,ffffffe000201aa8 <vprintfmt+0x318>
ffffffe000201a98:	f8244783          	lbu	a5,-126(s0)
ffffffe000201a9c:	00078a63          	beqz	a5,ffffffe000201ab0 <vprintfmt+0x320>
ffffffe000201aa0:	fe043783          	ld	a5,-32(s0)
ffffffe000201aa4:	00078663          	beqz	a5,ffffffe000201ab0 <vprintfmt+0x320>
ffffffe000201aa8:	00100793          	li	a5,1
ffffffe000201aac:	0080006f          	j	ffffffe000201ab4 <vprintfmt+0x324>
ffffffe000201ab0:	00000793          	li	a5,0
ffffffe000201ab4:	faf40323          	sb	a5,-90(s0)
ffffffe000201ab8:	fa644783          	lbu	a5,-90(s0)
ffffffe000201abc:	0017f793          	andi	a5,a5,1
ffffffe000201ac0:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201ac4:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201ac8:	f5043783          	ld	a5,-176(s0)
ffffffe000201acc:	0007c783          	lbu	a5,0(a5)
ffffffe000201ad0:	00078713          	mv	a4,a5
ffffffe000201ad4:	05800793          	li	a5,88
ffffffe000201ad8:	00f71863          	bne	a4,a5,ffffffe000201ae8 <vprintfmt+0x358>
ffffffe000201adc:	00001797          	auipc	a5,0x1
ffffffe000201ae0:	7cc78793          	addi	a5,a5,1996 # ffffffe0002032a8 <upperxdigits.1>
ffffffe000201ae4:	00c0006f          	j	ffffffe000201af0 <vprintfmt+0x360>
ffffffe000201ae8:	00001797          	auipc	a5,0x1
ffffffe000201aec:	7d878793          	addi	a5,a5,2008 # ffffffe0002032c0 <lowerxdigits.0>
ffffffe000201af0:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201af4:	fe043783          	ld	a5,-32(s0)
ffffffe000201af8:	00f7f793          	andi	a5,a5,15
ffffffe000201afc:	f9843703          	ld	a4,-104(s0)
ffffffe000201b00:	00f70733          	add	a4,a4,a5
ffffffe000201b04:	fdc42783          	lw	a5,-36(s0)
ffffffe000201b08:	0017869b          	addiw	a3,a5,1
ffffffe000201b0c:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201b10:	00074703          	lbu	a4,0(a4)
ffffffe000201b14:	ff078793          	addi	a5,a5,-16
ffffffe000201b18:	008787b3          	add	a5,a5,s0
ffffffe000201b1c:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201b20:	fe043783          	ld	a5,-32(s0)
ffffffe000201b24:	0047d793          	srli	a5,a5,0x4
ffffffe000201b28:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201b2c:	fe043783          	ld	a5,-32(s0)
ffffffe000201b30:	fc0792e3          	bnez	a5,ffffffe000201af4 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201b34:	f8c42783          	lw	a5,-116(s0)
ffffffe000201b38:	00078713          	mv	a4,a5
ffffffe000201b3c:	fff00793          	li	a5,-1
ffffffe000201b40:	02f71663          	bne	a4,a5,ffffffe000201b6c <vprintfmt+0x3dc>
ffffffe000201b44:	f8344783          	lbu	a5,-125(s0)
ffffffe000201b48:	02078263          	beqz	a5,ffffffe000201b6c <vprintfmt+0x3dc>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201b4c:	f8842703          	lw	a4,-120(s0)
ffffffe000201b50:	fa644783          	lbu	a5,-90(s0)
ffffffe000201b54:	0007879b          	sext.w	a5,a5
ffffffe000201b58:	0017979b          	slliw	a5,a5,0x1
ffffffe000201b5c:	0007879b          	sext.w	a5,a5
ffffffe000201b60:	40f707bb          	subw	a5,a4,a5
ffffffe000201b64:	0007879b          	sext.w	a5,a5
ffffffe000201b68:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201b6c:	f8842703          	lw	a4,-120(s0)
ffffffe000201b70:	fa644783          	lbu	a5,-90(s0)
ffffffe000201b74:	0007879b          	sext.w	a5,a5
ffffffe000201b78:	0017979b          	slliw	a5,a5,0x1
ffffffe000201b7c:	0007879b          	sext.w	a5,a5
ffffffe000201b80:	40f707bb          	subw	a5,a4,a5
ffffffe000201b84:	0007871b          	sext.w	a4,a5
ffffffe000201b88:	fdc42783          	lw	a5,-36(s0)
ffffffe000201b8c:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201b90:	f8c42783          	lw	a5,-116(s0)
ffffffe000201b94:	f8f42823          	sw	a5,-112(s0)
ffffffe000201b98:	f9442783          	lw	a5,-108(s0)
ffffffe000201b9c:	00078593          	mv	a1,a5
ffffffe000201ba0:	f9042783          	lw	a5,-112(s0)
ffffffe000201ba4:	00078613          	mv	a2,a5
ffffffe000201ba8:	0006069b          	sext.w	a3,a2
ffffffe000201bac:	0005879b          	sext.w	a5,a1
ffffffe000201bb0:	00f6d463          	bge	a3,a5,ffffffe000201bb8 <vprintfmt+0x428>
ffffffe000201bb4:	00058613          	mv	a2,a1
ffffffe000201bb8:	0006079b          	sext.w	a5,a2
ffffffe000201bbc:	40f707bb          	subw	a5,a4,a5
ffffffe000201bc0:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201bc4:	0280006f          	j	ffffffe000201bec <vprintfmt+0x45c>
                    putch(' ');
ffffffe000201bc8:	f5843783          	ld	a5,-168(s0)
ffffffe000201bcc:	02000513          	li	a0,32
ffffffe000201bd0:	000780e7          	jalr	a5
                    ++written;
ffffffe000201bd4:	fec42783          	lw	a5,-20(s0)
ffffffe000201bd8:	0017879b          	addiw	a5,a5,1
ffffffe000201bdc:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201be0:	fd842783          	lw	a5,-40(s0)
ffffffe000201be4:	fff7879b          	addiw	a5,a5,-1
ffffffe000201be8:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201bec:	fd842783          	lw	a5,-40(s0)
ffffffe000201bf0:	0007879b          	sext.w	a5,a5
ffffffe000201bf4:	fcf04ae3          	bgtz	a5,ffffffe000201bc8 <vprintfmt+0x438>
                }

                if (prefix) {
ffffffe000201bf8:	fa644783          	lbu	a5,-90(s0)
ffffffe000201bfc:	0ff7f793          	zext.b	a5,a5
ffffffe000201c00:	04078463          	beqz	a5,ffffffe000201c48 <vprintfmt+0x4b8>
                    putch('0');
ffffffe000201c04:	f5843783          	ld	a5,-168(s0)
ffffffe000201c08:	03000513          	li	a0,48
ffffffe000201c0c:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000201c10:	f5043783          	ld	a5,-176(s0)
ffffffe000201c14:	0007c783          	lbu	a5,0(a5)
ffffffe000201c18:	00078713          	mv	a4,a5
ffffffe000201c1c:	05800793          	li	a5,88
ffffffe000201c20:	00f71663          	bne	a4,a5,ffffffe000201c2c <vprintfmt+0x49c>
ffffffe000201c24:	05800793          	li	a5,88
ffffffe000201c28:	0080006f          	j	ffffffe000201c30 <vprintfmt+0x4a0>
ffffffe000201c2c:	07800793          	li	a5,120
ffffffe000201c30:	f5843703          	ld	a4,-168(s0)
ffffffe000201c34:	00078513          	mv	a0,a5
ffffffe000201c38:	000700e7          	jalr	a4
                    written += 2;
ffffffe000201c3c:	fec42783          	lw	a5,-20(s0)
ffffffe000201c40:	0027879b          	addiw	a5,a5,2
ffffffe000201c44:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201c48:	fdc42783          	lw	a5,-36(s0)
ffffffe000201c4c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201c50:	0280006f          	j	ffffffe000201c78 <vprintfmt+0x4e8>
                    putch('0');
ffffffe000201c54:	f5843783          	ld	a5,-168(s0)
ffffffe000201c58:	03000513          	li	a0,48
ffffffe000201c5c:	000780e7          	jalr	a5
                    ++written;
ffffffe000201c60:	fec42783          	lw	a5,-20(s0)
ffffffe000201c64:	0017879b          	addiw	a5,a5,1
ffffffe000201c68:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201c6c:	fd442783          	lw	a5,-44(s0)
ffffffe000201c70:	0017879b          	addiw	a5,a5,1
ffffffe000201c74:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201c78:	f8c42703          	lw	a4,-116(s0)
ffffffe000201c7c:	fd442783          	lw	a5,-44(s0)
ffffffe000201c80:	0007879b          	sext.w	a5,a5
ffffffe000201c84:	fce7c8e3          	blt	a5,a4,ffffffe000201c54 <vprintfmt+0x4c4>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201c88:	fdc42783          	lw	a5,-36(s0)
ffffffe000201c8c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201c90:	fcf42823          	sw	a5,-48(s0)
ffffffe000201c94:	03c0006f          	j	ffffffe000201cd0 <vprintfmt+0x540>
                    putch(buf[i]);
ffffffe000201c98:	fd042783          	lw	a5,-48(s0)
ffffffe000201c9c:	ff078793          	addi	a5,a5,-16
ffffffe000201ca0:	008787b3          	add	a5,a5,s0
ffffffe000201ca4:	f807c783          	lbu	a5,-128(a5)
ffffffe000201ca8:	0007871b          	sext.w	a4,a5
ffffffe000201cac:	f5843783          	ld	a5,-168(s0)
ffffffe000201cb0:	00070513          	mv	a0,a4
ffffffe000201cb4:	000780e7          	jalr	a5
                    ++written;
ffffffe000201cb8:	fec42783          	lw	a5,-20(s0)
ffffffe000201cbc:	0017879b          	addiw	a5,a5,1
ffffffe000201cc0:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000201cc4:	fd042783          	lw	a5,-48(s0)
ffffffe000201cc8:	fff7879b          	addiw	a5,a5,-1
ffffffe000201ccc:	fcf42823          	sw	a5,-48(s0)
ffffffe000201cd0:	fd042783          	lw	a5,-48(s0)
ffffffe000201cd4:	0007879b          	sext.w	a5,a5
ffffffe000201cd8:	fc07d0e3          	bgez	a5,ffffffe000201c98 <vprintfmt+0x508>
                }

                flags.in_format = false;
ffffffe000201cdc:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201ce0:	2700006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201ce4:	f5043783          	ld	a5,-176(s0)
ffffffe000201ce8:	0007c783          	lbu	a5,0(a5)
ffffffe000201cec:	00078713          	mv	a4,a5
ffffffe000201cf0:	06400793          	li	a5,100
ffffffe000201cf4:	02f70663          	beq	a4,a5,ffffffe000201d20 <vprintfmt+0x590>
ffffffe000201cf8:	f5043783          	ld	a5,-176(s0)
ffffffe000201cfc:	0007c783          	lbu	a5,0(a5)
ffffffe000201d00:	00078713          	mv	a4,a5
ffffffe000201d04:	06900793          	li	a5,105
ffffffe000201d08:	00f70c63          	beq	a4,a5,ffffffe000201d20 <vprintfmt+0x590>
ffffffe000201d0c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d10:	0007c783          	lbu	a5,0(a5)
ffffffe000201d14:	00078713          	mv	a4,a5
ffffffe000201d18:	07500793          	li	a5,117
ffffffe000201d1c:	08f71063          	bne	a4,a5,ffffffe000201d9c <vprintfmt+0x60c>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe000201d20:	f8144783          	lbu	a5,-127(s0)
ffffffe000201d24:	00078c63          	beqz	a5,ffffffe000201d3c <vprintfmt+0x5ac>
ffffffe000201d28:	f4843783          	ld	a5,-184(s0)
ffffffe000201d2c:	00878713          	addi	a4,a5,8
ffffffe000201d30:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d34:	0007b783          	ld	a5,0(a5)
ffffffe000201d38:	0140006f          	j	ffffffe000201d4c <vprintfmt+0x5bc>
ffffffe000201d3c:	f4843783          	ld	a5,-184(s0)
ffffffe000201d40:	00878713          	addi	a4,a5,8
ffffffe000201d44:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d48:	0007a783          	lw	a5,0(a5)
ffffffe000201d4c:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000201d50:	fa843583          	ld	a1,-88(s0)
ffffffe000201d54:	f5043783          	ld	a5,-176(s0)
ffffffe000201d58:	0007c783          	lbu	a5,0(a5)
ffffffe000201d5c:	0007871b          	sext.w	a4,a5
ffffffe000201d60:	07500793          	li	a5,117
ffffffe000201d64:	40f707b3          	sub	a5,a4,a5
ffffffe000201d68:	00f037b3          	snez	a5,a5
ffffffe000201d6c:	0ff7f793          	zext.b	a5,a5
ffffffe000201d70:	f8040713          	addi	a4,s0,-128
ffffffe000201d74:	00070693          	mv	a3,a4
ffffffe000201d78:	00078613          	mv	a2,a5
ffffffe000201d7c:	f5843503          	ld	a0,-168(s0)
ffffffe000201d80:	f08ff0ef          	jal	ffffffe000201488 <print_dec_int>
ffffffe000201d84:	00050793          	mv	a5,a0
ffffffe000201d88:	fec42703          	lw	a4,-20(s0)
ffffffe000201d8c:	00f707bb          	addw	a5,a4,a5
ffffffe000201d90:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201d94:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000201d98:	1b80006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == 'n') {
ffffffe000201d9c:	f5043783          	ld	a5,-176(s0)
ffffffe000201da0:	0007c783          	lbu	a5,0(a5)
ffffffe000201da4:	00078713          	mv	a4,a5
ffffffe000201da8:	06e00793          	li	a5,110
ffffffe000201dac:	04f71c63          	bne	a4,a5,ffffffe000201e04 <vprintfmt+0x674>
                if (flags.longflag) {
ffffffe000201db0:	f8144783          	lbu	a5,-127(s0)
ffffffe000201db4:	02078463          	beqz	a5,ffffffe000201ddc <vprintfmt+0x64c>
                    long *n = va_arg(vl, long *);
ffffffe000201db8:	f4843783          	ld	a5,-184(s0)
ffffffe000201dbc:	00878713          	addi	a4,a5,8
ffffffe000201dc0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201dc4:	0007b783          	ld	a5,0(a5)
ffffffe000201dc8:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe000201dcc:	fec42703          	lw	a4,-20(s0)
ffffffe000201dd0:	fb043783          	ld	a5,-80(s0)
ffffffe000201dd4:	00e7b023          	sd	a4,0(a5)
ffffffe000201dd8:	0240006f          	j	ffffffe000201dfc <vprintfmt+0x66c>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe000201ddc:	f4843783          	ld	a5,-184(s0)
ffffffe000201de0:	00878713          	addi	a4,a5,8
ffffffe000201de4:	f4e43423          	sd	a4,-184(s0)
ffffffe000201de8:	0007b783          	ld	a5,0(a5)
ffffffe000201dec:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000201df0:	fb843783          	ld	a5,-72(s0)
ffffffe000201df4:	fec42703          	lw	a4,-20(s0)
ffffffe000201df8:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe000201dfc:	f8040023          	sb	zero,-128(s0)
ffffffe000201e00:	1500006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == 's') {
ffffffe000201e04:	f5043783          	ld	a5,-176(s0)
ffffffe000201e08:	0007c783          	lbu	a5,0(a5)
ffffffe000201e0c:	00078713          	mv	a4,a5
ffffffe000201e10:	07300793          	li	a5,115
ffffffe000201e14:	02f71e63          	bne	a4,a5,ffffffe000201e50 <vprintfmt+0x6c0>
                const char *s = va_arg(vl, const char *);
ffffffe000201e18:	f4843783          	ld	a5,-184(s0)
ffffffe000201e1c:	00878713          	addi	a4,a5,8
ffffffe000201e20:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e24:	0007b783          	ld	a5,0(a5)
ffffffe000201e28:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe000201e2c:	fc043583          	ld	a1,-64(s0)
ffffffe000201e30:	f5843503          	ld	a0,-168(s0)
ffffffe000201e34:	dccff0ef          	jal	ffffffe000201400 <puts_wo_nl>
ffffffe000201e38:	00050793          	mv	a5,a0
ffffffe000201e3c:	fec42703          	lw	a4,-20(s0)
ffffffe000201e40:	00f707bb          	addw	a5,a4,a5
ffffffe000201e44:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201e48:	f8040023          	sb	zero,-128(s0)
ffffffe000201e4c:	1040006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == 'c') {
ffffffe000201e50:	f5043783          	ld	a5,-176(s0)
ffffffe000201e54:	0007c783          	lbu	a5,0(a5)
ffffffe000201e58:	00078713          	mv	a4,a5
ffffffe000201e5c:	06300793          	li	a5,99
ffffffe000201e60:	02f71e63          	bne	a4,a5,ffffffe000201e9c <vprintfmt+0x70c>
                int ch = va_arg(vl, int);
ffffffe000201e64:	f4843783          	ld	a5,-184(s0)
ffffffe000201e68:	00878713          	addi	a4,a5,8
ffffffe000201e6c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e70:	0007a783          	lw	a5,0(a5)
ffffffe000201e74:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000201e78:	fcc42703          	lw	a4,-52(s0)
ffffffe000201e7c:	f5843783          	ld	a5,-168(s0)
ffffffe000201e80:	00070513          	mv	a0,a4
ffffffe000201e84:	000780e7          	jalr	a5
                ++written;
ffffffe000201e88:	fec42783          	lw	a5,-20(s0)
ffffffe000201e8c:	0017879b          	addiw	a5,a5,1
ffffffe000201e90:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201e94:	f8040023          	sb	zero,-128(s0)
ffffffe000201e98:	0b80006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else if (*fmt == '%') {
ffffffe000201e9c:	f5043783          	ld	a5,-176(s0)
ffffffe000201ea0:	0007c783          	lbu	a5,0(a5)
ffffffe000201ea4:	00078713          	mv	a4,a5
ffffffe000201ea8:	02500793          	li	a5,37
ffffffe000201eac:	02f71263          	bne	a4,a5,ffffffe000201ed0 <vprintfmt+0x740>
                putch('%');
ffffffe000201eb0:	f5843783          	ld	a5,-168(s0)
ffffffe000201eb4:	02500513          	li	a0,37
ffffffe000201eb8:	000780e7          	jalr	a5
                ++written;
ffffffe000201ebc:	fec42783          	lw	a5,-20(s0)
ffffffe000201ec0:	0017879b          	addiw	a5,a5,1
ffffffe000201ec4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201ec8:	f8040023          	sb	zero,-128(s0)
ffffffe000201ecc:	0840006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            } else {
                putch(*fmt);
ffffffe000201ed0:	f5043783          	ld	a5,-176(s0)
ffffffe000201ed4:	0007c783          	lbu	a5,0(a5)
ffffffe000201ed8:	0007871b          	sext.w	a4,a5
ffffffe000201edc:	f5843783          	ld	a5,-168(s0)
ffffffe000201ee0:	00070513          	mv	a0,a4
ffffffe000201ee4:	000780e7          	jalr	a5
                ++written;
ffffffe000201ee8:	fec42783          	lw	a5,-20(s0)
ffffffe000201eec:	0017879b          	addiw	a5,a5,1
ffffffe000201ef0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000201ef4:	f8040023          	sb	zero,-128(s0)
ffffffe000201ef8:	0580006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
            }
        } else if (*fmt == '%') {
ffffffe000201efc:	f5043783          	ld	a5,-176(s0)
ffffffe000201f00:	0007c783          	lbu	a5,0(a5)
ffffffe000201f04:	00078713          	mv	a4,a5
ffffffe000201f08:	02500793          	li	a5,37
ffffffe000201f0c:	02f71063          	bne	a4,a5,ffffffe000201f2c <vprintfmt+0x79c>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe000201f10:	f8043023          	sd	zero,-128(s0)
ffffffe000201f14:	f8043423          	sd	zero,-120(s0)
ffffffe000201f18:	00100793          	li	a5,1
ffffffe000201f1c:	f8f40023          	sb	a5,-128(s0)
ffffffe000201f20:	fff00793          	li	a5,-1
ffffffe000201f24:	f8f42623          	sw	a5,-116(s0)
ffffffe000201f28:	0280006f          	j	ffffffe000201f50 <vprintfmt+0x7c0>
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
    for (; *fmt; fmt++) {
ffffffe000201f50:	f5043783          	ld	a5,-176(s0)
ffffffe000201f54:	00178793          	addi	a5,a5,1
ffffffe000201f58:	f4f43823          	sd	a5,-176(s0)
ffffffe000201f5c:	f5043783          	ld	a5,-176(s0)
ffffffe000201f60:	0007c783          	lbu	a5,0(a5)
ffffffe000201f64:	84079ce3          	bnez	a5,ffffffe0002017bc <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000201f68:	fec42783          	lw	a5,-20(s0)
}
ffffffe000201f6c:	00078513          	mv	a0,a5
ffffffe000201f70:	0b813083          	ld	ra,184(sp)
ffffffe000201f74:	0b013403          	ld	s0,176(sp)
ffffffe000201f78:	0c010113          	addi	sp,sp,192
ffffffe000201f7c:	00008067          	ret

ffffffe000201f80 <printk>:

int printk(const char* s, ...) {
ffffffe000201f80:	f9010113          	addi	sp,sp,-112
ffffffe000201f84:	02113423          	sd	ra,40(sp)
ffffffe000201f88:	02813023          	sd	s0,32(sp)
ffffffe000201f8c:	03010413          	addi	s0,sp,48
ffffffe000201f90:	fca43c23          	sd	a0,-40(s0)
ffffffe000201f94:	00b43423          	sd	a1,8(s0)
ffffffe000201f98:	00c43823          	sd	a2,16(s0)
ffffffe000201f9c:	00d43c23          	sd	a3,24(s0)
ffffffe000201fa0:	02e43023          	sd	a4,32(s0)
ffffffe000201fa4:	02f43423          	sd	a5,40(s0)
ffffffe000201fa8:	03043823          	sd	a6,48(s0)
ffffffe000201fac:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe000201fb0:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe000201fb4:	04040793          	addi	a5,s0,64
ffffffe000201fb8:	fcf43823          	sd	a5,-48(s0)
ffffffe000201fbc:	fd043783          	ld	a5,-48(s0)
ffffffe000201fc0:	fc878793          	addi	a5,a5,-56
ffffffe000201fc4:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000201fc8:	fe043783          	ld	a5,-32(s0)
ffffffe000201fcc:	00078613          	mv	a2,a5
ffffffe000201fd0:	fd843583          	ld	a1,-40(s0)
ffffffe000201fd4:	fffff517          	auipc	a0,0xfffff
ffffffe000201fd8:	11850513          	addi	a0,a0,280 # ffffffe0002010ec <putc>
ffffffe000201fdc:	fb4ff0ef          	jal	ffffffe000201790 <vprintfmt>
ffffffe000201fe0:	00050793          	mv	a5,a0
ffffffe000201fe4:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000201fe8:	fec42783          	lw	a5,-20(s0)
}
ffffffe000201fec:	00078513          	mv	a0,a5
ffffffe000201ff0:	02813083          	ld	ra,40(sp)
ffffffe000201ff4:	02013403          	ld	s0,32(sp)
ffffffe000201ff8:	07010113          	addi	sp,sp,112
ffffffe000201ffc:	00008067          	ret

ffffffe000202000 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe000202000:	fe010113          	addi	sp,sp,-32
ffffffe000202004:	00813c23          	sd	s0,24(sp)
ffffffe000202008:	02010413          	addi	s0,sp,32
ffffffe00020200c:	00050793          	mv	a5,a0
ffffffe000202010:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe000202014:	fec42783          	lw	a5,-20(s0)
ffffffe000202018:	fff7879b          	addiw	a5,a5,-1
ffffffe00020201c:	0007879b          	sext.w	a5,a5
ffffffe000202020:	02079713          	slli	a4,a5,0x20
ffffffe000202024:	02075713          	srli	a4,a4,0x20
ffffffe000202028:	00004797          	auipc	a5,0x4
ffffffe00020202c:	ff078793          	addi	a5,a5,-16 # ffffffe000206018 <seed>
ffffffe000202030:	00e7b023          	sd	a4,0(a5)
}
ffffffe000202034:	00000013          	nop
ffffffe000202038:	01813403          	ld	s0,24(sp)
ffffffe00020203c:	02010113          	addi	sp,sp,32
ffffffe000202040:	00008067          	ret

ffffffe000202044 <rand>:

int rand(void) {
ffffffe000202044:	ff010113          	addi	sp,sp,-16
ffffffe000202048:	00813423          	sd	s0,8(sp)
ffffffe00020204c:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe000202050:	00004797          	auipc	a5,0x4
ffffffe000202054:	fc878793          	addi	a5,a5,-56 # ffffffe000206018 <seed>
ffffffe000202058:	0007b703          	ld	a4,0(a5)
ffffffe00020205c:	00001797          	auipc	a5,0x1
ffffffe000202060:	27c78793          	addi	a5,a5,636 # ffffffe0002032d8 <lowerxdigits.0+0x18>
ffffffe000202064:	0007b783          	ld	a5,0(a5)
ffffffe000202068:	02f707b3          	mul	a5,a4,a5
ffffffe00020206c:	00178713          	addi	a4,a5,1
ffffffe000202070:	00004797          	auipc	a5,0x4
ffffffe000202074:	fa878793          	addi	a5,a5,-88 # ffffffe000206018 <seed>
ffffffe000202078:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe00020207c:	00004797          	auipc	a5,0x4
ffffffe000202080:	f9c78793          	addi	a5,a5,-100 # ffffffe000206018 <seed>
ffffffe000202084:	0007b783          	ld	a5,0(a5)
ffffffe000202088:	0217d793          	srli	a5,a5,0x21
ffffffe00020208c:	0007879b          	sext.w	a5,a5
}
ffffffe000202090:	00078513          	mv	a0,a5
ffffffe000202094:	00813403          	ld	s0,8(sp)
ffffffe000202098:	01010113          	addi	sp,sp,16
ffffffe00020209c:	00008067          	ret

ffffffe0002020a0 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe0002020a0:	fc010113          	addi	sp,sp,-64
ffffffe0002020a4:	02813c23          	sd	s0,56(sp)
ffffffe0002020a8:	04010413          	addi	s0,sp,64
ffffffe0002020ac:	fca43c23          	sd	a0,-40(s0)
ffffffe0002020b0:	00058793          	mv	a5,a1
ffffffe0002020b4:	fcc43423          	sd	a2,-56(s0)
ffffffe0002020b8:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe0002020bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002020c0:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002020c4:	fe043423          	sd	zero,-24(s0)
ffffffe0002020c8:	0280006f          	j	ffffffe0002020f0 <memset+0x50>
        s[i] = c;
ffffffe0002020cc:	fe043703          	ld	a4,-32(s0)
ffffffe0002020d0:	fe843783          	ld	a5,-24(s0)
ffffffe0002020d4:	00f707b3          	add	a5,a4,a5
ffffffe0002020d8:	fd442703          	lw	a4,-44(s0)
ffffffe0002020dc:	0ff77713          	zext.b	a4,a4
ffffffe0002020e0:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002020e4:	fe843783          	ld	a5,-24(s0)
ffffffe0002020e8:	00178793          	addi	a5,a5,1
ffffffe0002020ec:	fef43423          	sd	a5,-24(s0)
ffffffe0002020f0:	fe843703          	ld	a4,-24(s0)
ffffffe0002020f4:	fc843783          	ld	a5,-56(s0)
ffffffe0002020f8:	fcf76ae3          	bltu	a4,a5,ffffffe0002020cc <memset+0x2c>
    }
    return dest;
ffffffe0002020fc:	fd843783          	ld	a5,-40(s0)
}
ffffffe000202100:	00078513          	mv	a0,a5
ffffffe000202104:	03813403          	ld	s0,56(sp)
ffffffe000202108:	04010113          	addi	sp,sp,64
ffffffe00020210c:	00008067          	ret
