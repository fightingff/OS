
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
ffffffe000200008:	7c9000ef          	jal	ffffffe000200fd0 <setup_vm>
    call relocate
ffffffe00020000c:	034000ef          	jal	ffffffe000200040 <relocate>
    
    call mm_init
ffffffe000200010:	3f8000ef          	jal	ffffffe000200408 <mm_init>
    call setup_vm_final
ffffffe000200014:	060010ef          	jal	ffffffe000201074 <setup_vm_final>
    call task_init
ffffffe000200018:	440000ef          	jal	ffffffe000200458 <task_init>

    la t0, _traps
ffffffe00020001c:	00000297          	auipc	t0,0x0
ffffffe000200020:	06828293          	addi	t0,t0,104 # ffffffe000200084 <_traps>
    csrw stvec, t0  # set stvec = _traps
ffffffe000200024:	10529073          	csrw	stvec,t0

    li t0, 32
ffffffe000200028:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
ffffffe00020002c:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
ffffffe000200030:	238000ef          	jal	ffffffe000200268 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe000200034:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200038:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe00020003c:	3a4010ef          	jal	ffffffe0002013e0 <start_kernel>

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
    csrw stvec, ra
ffffffe00020004c:	10509073          	csrw	stvec,ra
    add sp, sp, t0
ffffffe000200050:	00510133          	add	sp,sp,t0

    # need a fence to ensure the new translations are in use
    sfence.vma zero, zero
ffffffe000200054:	12000073          	sfence.vma

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    # set PPN
    la t0, early_pgtbl
ffffffe000200058:	00007297          	auipc	t0,0x7
ffffffe00020005c:	fa828293          	addi	t0,t0,-88 # ffffffe000207000 <early_pgtbl>
    srl t0, t0, 12 
ffffffe000200060:	00c2d293          	srli	t0,t0,0xc

    # set ASID
    li t1, 0
ffffffe000200064:	00000313          	li	t1,0
    sll t1, t1, 44
ffffffe000200068:	02c31313          	slli	t1,t1,0x2c

    # set mode
    li t2, 8
ffffffe00020006c:	00800393          	li	t2,8
    sll t2, t2, 60
ffffffe000200070:	03c39393          	slli	t2,t2,0x3c

    # set satp
    or t0, t0, t1
ffffffe000200074:	0062e2b3          	or	t0,t0,t1
    or t0, t0, t2
ffffffe000200078:	0072e2b3          	or	t0,t0,t2
    csrw satp, t0
ffffffe00020007c:	18029073          	csrw	satp,t0
    ret
ffffffe000200080:	00008067          	ret

ffffffe000200084 <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
ffffffe000200084:	ef810113          	addi	sp,sp,-264 # ffffffe000205ef8 <_sbss+0xef8>
    sd x0, 0(sp)
ffffffe000200088:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
ffffffe00020008c:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
ffffffe000200090:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
ffffffe000200094:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
ffffffe000200098:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
ffffffe00020009c:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
ffffffe0002000a0:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
ffffffe0002000a4:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
ffffffe0002000a8:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
ffffffe0002000ac:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
ffffffe0002000b0:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
ffffffe0002000b4:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
ffffffe0002000b8:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
ffffffe0002000bc:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
ffffffe0002000c0:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
ffffffe0002000c4:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
ffffffe0002000c8:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
ffffffe0002000cc:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
ffffffe0002000d0:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
ffffffe0002000d4:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
ffffffe0002000d8:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
ffffffe0002000dc:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
ffffffe0002000e0:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
ffffffe0002000e4:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
ffffffe0002000e8:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
ffffffe0002000ec:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
ffffffe0002000f0:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
ffffffe0002000f4:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
ffffffe0002000f8:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
ffffffe0002000fc:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
ffffffe000200100:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
ffffffe000200104:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
ffffffe000200108:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
ffffffe00020010c:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
ffffffe000200110:	14202573          	csrr	a0,scause
    csrr a1, sepc
ffffffe000200114:	141025f3          	csrr	a1,sepc
    call trap_handler
ffffffe000200118:	651000ef          	jal	ffffffe000200f68 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
ffffffe00020011c:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
ffffffe000200120:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
ffffffe000200124:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
ffffffe000200128:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
ffffffe00020012c:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
ffffffe000200130:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
ffffffe000200134:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
ffffffe000200138:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
ffffffe00020013c:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
ffffffe000200140:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
ffffffe000200144:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
ffffffe000200148:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
ffffffe00020014c:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
ffffffe000200150:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
ffffffe000200154:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
ffffffe000200158:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
ffffffe00020015c:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
ffffffe000200160:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
ffffffe000200164:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
ffffffe000200168:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
ffffffe00020016c:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
ffffffe000200170:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
ffffffe000200174:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
ffffffe000200178:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
ffffffe00020017c:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
ffffffe000200180:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
ffffffe000200184:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
ffffffe000200188:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
ffffffe00020018c:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
ffffffe000200190:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
ffffffe000200194:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
ffffffe000200198:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
ffffffe00020019c:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
ffffffe0002001a0:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
ffffffe0002001a4:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
ffffffe0002001a8:	10200073          	sret

ffffffe0002001ac <__dummy>:

    .extern dummy
    .globl __dummy
__dummy:
    # 将 sepc 设置为 dummy() 的地址，并使用 sret 从 S 模式中返回
    la t0, dummy
ffffffe0002001ac:	00000297          	auipc	t0,0x0
ffffffe0002001b0:	4e428293          	addi	t0,t0,1252 # ffffffe000200690 <dummy>
    csrw sepc, t0
ffffffe0002001b4:	14129073          	csrw	sepc,t0
    sret
ffffffe0002001b8:	10200073          	sret

ffffffe0002001bc <__switch_to>:

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
ffffffe0002001bc:	02050513          	addi	a0,a0,32
    sd ra, 0(a0)
ffffffe0002001c0:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
ffffffe0002001c4:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
ffffffe0002001c8:	00853823          	sd	s0,16(a0)
    sd s1, 24(a0)
ffffffe0002001cc:	00953c23          	sd	s1,24(a0)
    sd s2, 32(a0)
ffffffe0002001d0:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
ffffffe0002001d4:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
ffffffe0002001d8:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
ffffffe0002001dc:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
ffffffe0002001e0:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
ffffffe0002001e4:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
ffffffe0002001e8:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
ffffffe0002001ec:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
ffffffe0002001f0:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
ffffffe0002001f4:	07b53423          	sd	s11,104(a0)

    # restore state from next process
    add a1, a1, 32
ffffffe0002001f8:	02058593          	addi	a1,a1,32
    ld ra, 0(a1)
ffffffe0002001fc:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
ffffffe000200200:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
ffffffe000200204:	0105b403          	ld	s0,16(a1)
    ld s1, 24(a1)
ffffffe000200208:	0185b483          	ld	s1,24(a1)
    ld s2, 32(a1)
ffffffe00020020c:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
ffffffe000200210:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
ffffffe000200214:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
ffffffe000200218:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
ffffffe00020021c:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
ffffffe000200220:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
ffffffe000200224:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
ffffffe000200228:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
ffffffe00020022c:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
ffffffe000200230:	0685bd83          	ld	s11,104(a1)

ffffffe000200234:	00008067          	ret

ffffffe000200238 <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
ffffffe000200238:	fe010113          	addi	sp,sp,-32
ffffffe00020023c:	00113c23          	sd	ra,24(sp)
ffffffe000200240:	00813823          	sd	s0,16(sp)
ffffffe000200244:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
ffffffe000200248:	c01027f3          	rdtime	a5
ffffffe00020024c:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
ffffffe000200250:	fe843783          	ld	a5,-24(s0)
}
ffffffe000200254:	00078513          	mv	a0,a5
ffffffe000200258:	01813083          	ld	ra,24(sp)
ffffffe00020025c:	01013403          	ld	s0,16(sp)
ffffffe000200260:	02010113          	addi	sp,sp,32
ffffffe000200264:	00008067          	ret

ffffffe000200268 <clock_set_next_event>:

void clock_set_next_event() {
ffffffe000200268:	fe010113          	addi	sp,sp,-32
ffffffe00020026c:	00113c23          	sd	ra,24(sp)
ffffffe000200270:	00813823          	sd	s0,16(sp)
ffffffe000200274:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe000200278:	fc1ff0ef          	jal	ffffffe000200238 <get_cycles>
ffffffe00020027c:	00050713          	mv	a4,a0
ffffffe000200280:	00004797          	auipc	a5,0x4
ffffffe000200284:	d8078793          	addi	a5,a5,-640 # ffffffe000204000 <TIMECLOCK>
ffffffe000200288:	0007b783          	ld	a5,0(a5)
ffffffe00020028c:	00f707b3          	add	a5,a4,a5
ffffffe000200290:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe000200294:	fe843503          	ld	a0,-24(s0)
ffffffe000200298:	31d000ef          	jal	ffffffe000200db4 <sbi_set_timer>
ffffffe00020029c:	00000013          	nop
ffffffe0002002a0:	01813083          	ld	ra,24(sp)
ffffffe0002002a4:	01013403          	ld	s0,16(sp)
ffffffe0002002a8:	02010113          	addi	sp,sp,32
ffffffe0002002ac:	00008067          	ret

ffffffe0002002b0 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
ffffffe0002002b0:	fe010113          	addi	sp,sp,-32
ffffffe0002002b4:	00113c23          	sd	ra,24(sp)
ffffffe0002002b8:	00813823          	sd	s0,16(sp)
ffffffe0002002bc:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
ffffffe0002002c0:	00006797          	auipc	a5,0x6
ffffffe0002002c4:	d4078793          	addi	a5,a5,-704 # ffffffe000206000 <kmem>
ffffffe0002002c8:	0007b783          	ld	a5,0(a5)
ffffffe0002002cc:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
ffffffe0002002d0:	fe843783          	ld	a5,-24(s0)
ffffffe0002002d4:	0007b703          	ld	a4,0(a5)
ffffffe0002002d8:	00006797          	auipc	a5,0x6
ffffffe0002002dc:	d2878793          	addi	a5,a5,-728 # ffffffe000206000 <kmem>
ffffffe0002002e0:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
ffffffe0002002e4:	00001637          	lui	a2,0x1
ffffffe0002002e8:	00000593          	li	a1,0
ffffffe0002002ec:	fe843503          	ld	a0,-24(s0)
ffffffe0002002f0:	1cc020ef          	jal	ffffffe0002024bc <memset>
    return (void *)r;
ffffffe0002002f4:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002f8:	00078513          	mv	a0,a5
ffffffe0002002fc:	01813083          	ld	ra,24(sp)
ffffffe000200300:	01013403          	ld	s0,16(sp)
ffffffe000200304:	02010113          	addi	sp,sp,32
ffffffe000200308:	00008067          	ret

ffffffe00020030c <kfree>:

void kfree(void *addr) {
ffffffe00020030c:	fd010113          	addi	sp,sp,-48
ffffffe000200310:	02113423          	sd	ra,40(sp)
ffffffe000200314:	02813023          	sd	s0,32(sp)
ffffffe000200318:	03010413          	addi	s0,sp,48
ffffffe00020031c:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // LOG(RED "kfree(addr: %p)" CLEAR, addr);

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe000200320:	fd843783          	ld	a5,-40(s0)
ffffffe000200324:	00078693          	mv	a3,a5
ffffffe000200328:	fd840793          	addi	a5,s0,-40
ffffffe00020032c:	fffff737          	lui	a4,0xfffff
ffffffe000200330:	00e6f733          	and	a4,a3,a4
ffffffe000200334:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe000200338:	fd843783          	ld	a5,-40(s0)
ffffffe00020033c:	00001637          	lui	a2,0x1
ffffffe000200340:	00000593          	li	a1,0
ffffffe000200344:	00078513          	mv	a0,a5
ffffffe000200348:	174020ef          	jal	ffffffe0002024bc <memset>

    r = (struct run *)addr;
ffffffe00020034c:	fd843783          	ld	a5,-40(s0)
ffffffe000200350:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe000200354:	00006797          	auipc	a5,0x6
ffffffe000200358:	cac78793          	addi	a5,a5,-852 # ffffffe000206000 <kmem>
ffffffe00020035c:	0007b703          	ld	a4,0(a5)
ffffffe000200360:	fe843783          	ld	a5,-24(s0)
ffffffe000200364:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe000200368:	00006797          	auipc	a5,0x6
ffffffe00020036c:	c9878793          	addi	a5,a5,-872 # ffffffe000206000 <kmem>
ffffffe000200370:	fe843703          	ld	a4,-24(s0)
ffffffe000200374:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe000200378:	00000013          	nop
}
ffffffe00020037c:	02813083          	ld	ra,40(sp)
ffffffe000200380:	02013403          	ld	s0,32(sp)
ffffffe000200384:	03010113          	addi	sp,sp,48
ffffffe000200388:	00008067          	ret

ffffffe00020038c <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe00020038c:	fd010113          	addi	sp,sp,-48
ffffffe000200390:	02113423          	sd	ra,40(sp)
ffffffe000200394:	02813023          	sd	s0,32(sp)
ffffffe000200398:	03010413          	addi	s0,sp,48
ffffffe00020039c:	fca43c23          	sd	a0,-40(s0)
ffffffe0002003a0:	fcb43823          	sd	a1,-48(s0)
    // LOG(RED "kfreerange(start: %p, end: %p)" CLEAR, start, end);
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe0002003a4:	fd843703          	ld	a4,-40(s0)
ffffffe0002003a8:	000017b7          	lui	a5,0x1
ffffffe0002003ac:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003b0:	00f70733          	add	a4,a4,a5
ffffffe0002003b4:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003b8:	00f777b3          	and	a5,a4,a5
ffffffe0002003bc:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003c0:	01c0006f          	j	ffffffe0002003dc <kfreerange+0x50>
        kfree((void *)addr);
ffffffe0002003c4:	fe843503          	ld	a0,-24(s0)
ffffffe0002003c8:	f45ff0ef          	jal	ffffffe00020030c <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003cc:	fe843703          	ld	a4,-24(s0)
ffffffe0002003d0:	000017b7          	lui	a5,0x1
ffffffe0002003d4:	00f707b3          	add	a5,a4,a5
ffffffe0002003d8:	fef43423          	sd	a5,-24(s0)
ffffffe0002003dc:	fe843703          	ld	a4,-24(s0)
ffffffe0002003e0:	000017b7          	lui	a5,0x1
ffffffe0002003e4:	00f70733          	add	a4,a4,a5
ffffffe0002003e8:	fd043783          	ld	a5,-48(s0)
ffffffe0002003ec:	fce7fce3          	bgeu	a5,a4,ffffffe0002003c4 <kfreerange+0x38>
    }
}
ffffffe0002003f0:	00000013          	nop
ffffffe0002003f4:	00000013          	nop
ffffffe0002003f8:	02813083          	ld	ra,40(sp)
ffffffe0002003fc:	02013403          	ld	s0,32(sp)
ffffffe000200400:	03010113          	addi	sp,sp,48
ffffffe000200404:	00008067          	ret

ffffffe000200408 <mm_init>:

void mm_init(void) {
ffffffe000200408:	ff010113          	addi	sp,sp,-16
ffffffe00020040c:	00113423          	sd	ra,8(sp)
ffffffe000200410:	00813023          	sd	s0,0(sp)
ffffffe000200414:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200418:	00003517          	auipc	a0,0x3
ffffffe00020041c:	be850513          	addi	a0,a0,-1048 # ffffffe000203000 <_srodata>
ffffffe000200420:	76d010ef          	jal	ffffffe00020238c <printk>
    kfreerange(_ekernel, (char *)VM_END);
ffffffe000200424:	c0100793          	li	a5,-1023
ffffffe000200428:	01b79593          	slli	a1,a5,0x1b
ffffffe00020042c:	00009517          	auipc	a0,0x9
ffffffe000200430:	bd450513          	addi	a0,a0,-1068 # ffffffe000209000 <_ebss>
ffffffe000200434:	f59ff0ef          	jal	ffffffe00020038c <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200438:	00003517          	auipc	a0,0x3
ffffffe00020043c:	be050513          	addi	a0,a0,-1056 # ffffffe000203018 <_srodata+0x18>
ffffffe000200440:	74d010ef          	jal	ffffffe00020238c <printk>
}
ffffffe000200444:	00000013          	nop
ffffffe000200448:	00813083          	ld	ra,8(sp)
ffffffe00020044c:	00013403          	ld	s0,0(sp)
ffffffe000200450:	01010113          	addi	sp,sp,16
ffffffe000200454:	00008067          	ret

ffffffe000200458 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe000200458:	fe010113          	addi	sp,sp,-32
ffffffe00020045c:	00113c23          	sd	ra,24(sp)
ffffffe000200460:	00813823          	sd	s0,16(sp)
ffffffe000200464:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe000200468:	7e800513          	li	a0,2024
ffffffe00020046c:	7a1010ef          	jal	ffffffe00020240c <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe000200470:	e41ff0ef          	jal	ffffffe0002002b0 <kalloc>
ffffffe000200474:	00050713          	mv	a4,a0
ffffffe000200478:	00006797          	auipc	a5,0x6
ffffffe00020047c:	b9078793          	addi	a5,a5,-1136 # ffffffe000206008 <idle>
ffffffe000200480:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe000200484:	00006797          	auipc	a5,0x6
ffffffe000200488:	b8478793          	addi	a5,a5,-1148 # ffffffe000206008 <idle>
ffffffe00020048c:	0007b783          	ld	a5,0(a5)
ffffffe000200490:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe000200494:	00006797          	auipc	a5,0x6
ffffffe000200498:	b7478793          	addi	a5,a5,-1164 # ffffffe000206008 <idle>
ffffffe00020049c:	0007b783          	ld	a5,0(a5)
ffffffe0002004a0:	0007b823          	sd	zero,16(a5)
ffffffe0002004a4:	00006717          	auipc	a4,0x6
ffffffe0002004a8:	b6470713          	addi	a4,a4,-1180 # ffffffe000206008 <idle>
ffffffe0002004ac:	00073703          	ld	a4,0(a4)
ffffffe0002004b0:	0107b783          	ld	a5,16(a5)
ffffffe0002004b4:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe0002004b8:	00006797          	auipc	a5,0x6
ffffffe0002004bc:	b5078793          	addi	a5,a5,-1200 # ffffffe000206008 <idle>
ffffffe0002004c0:	0007b783          	ld	a5,0(a5)
ffffffe0002004c4:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe0002004c8:	00006797          	auipc	a5,0x6
ffffffe0002004cc:	b4078793          	addi	a5,a5,-1216 # ffffffe000206008 <idle>
ffffffe0002004d0:	0007b703          	ld	a4,0(a5)
ffffffe0002004d4:	00006797          	auipc	a5,0x6
ffffffe0002004d8:	b5478793          	addi	a5,a5,-1196 # ffffffe000206028 <task>
ffffffe0002004dc:	00e7b023          	sd	a4,0(a5)
ffffffe0002004e0:	00006797          	auipc	a5,0x6
ffffffe0002004e4:	b4878793          	addi	a5,a5,-1208 # ffffffe000206028 <task>
ffffffe0002004e8:	0007b703          	ld	a4,0(a5)
ffffffe0002004ec:	00006797          	auipc	a5,0x6
ffffffe0002004f0:	b2478793          	addi	a5,a5,-1244 # ffffffe000206010 <current>
ffffffe0002004f4:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002004f8:	00100793          	li	a5,1
ffffffe0002004fc:	fef42623          	sw	a5,-20(s0)
ffffffe000200500:	1600006f          	j	ffffffe000200660 <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
ffffffe000200504:	dadff0ef          	jal	ffffffe0002002b0 <kalloc>
ffffffe000200508:	00050693          	mv	a3,a0
ffffffe00020050c:	00006717          	auipc	a4,0x6
ffffffe000200510:	b1c70713          	addi	a4,a4,-1252 # ffffffe000206028 <task>
ffffffe000200514:	fec42783          	lw	a5,-20(s0)
ffffffe000200518:	00379793          	slli	a5,a5,0x3
ffffffe00020051c:	00f707b3          	add	a5,a4,a5
ffffffe000200520:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe000200524:	00006717          	auipc	a4,0x6
ffffffe000200528:	b0470713          	addi	a4,a4,-1276 # ffffffe000206028 <task>
ffffffe00020052c:	fec42783          	lw	a5,-20(s0)
ffffffe000200530:	00379793          	slli	a5,a5,0x3
ffffffe000200534:	00f707b3          	add	a5,a4,a5
ffffffe000200538:	0007b783          	ld	a5,0(a5)
ffffffe00020053c:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe000200540:	00006717          	auipc	a4,0x6
ffffffe000200544:	ae870713          	addi	a4,a4,-1304 # ffffffe000206028 <task>
ffffffe000200548:	fec42783          	lw	a5,-20(s0)
ffffffe00020054c:	00379793          	slli	a5,a5,0x3
ffffffe000200550:	00f707b3          	add	a5,a4,a5
ffffffe000200554:	0007b783          	ld	a5,0(a5)
ffffffe000200558:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe00020055c:	6fd010ef          	jal	ffffffe000202458 <rand>
ffffffe000200560:	00050793          	mv	a5,a0
ffffffe000200564:	00078713          	mv	a4,a5
ffffffe000200568:	0007069b          	sext.w	a3,a4
ffffffe00020056c:	666667b7          	lui	a5,0x66666
ffffffe000200570:	66778793          	addi	a5,a5,1639 # 66666667 <PHY_SIZE+0x5e666667>
ffffffe000200574:	02f687b3          	mul	a5,a3,a5
ffffffe000200578:	0207d793          	srli	a5,a5,0x20
ffffffe00020057c:	4027d79b          	sraiw	a5,a5,0x2
ffffffe000200580:	00078693          	mv	a3,a5
ffffffe000200584:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe000200588:	40f687bb          	subw	a5,a3,a5
ffffffe00020058c:	00078693          	mv	a3,a5
ffffffe000200590:	00068793          	mv	a5,a3
ffffffe000200594:	0027979b          	slliw	a5,a5,0x2
ffffffe000200598:	00d787bb          	addw	a5,a5,a3
ffffffe00020059c:	0017979b          	slliw	a5,a5,0x1
ffffffe0002005a0:	40f707bb          	subw	a5,a4,a5
ffffffe0002005a4:	0007879b          	sext.w	a5,a5
ffffffe0002005a8:	0017879b          	addiw	a5,a5,1
ffffffe0002005ac:	0007869b          	sext.w	a3,a5
ffffffe0002005b0:	00006717          	auipc	a4,0x6
ffffffe0002005b4:	a7870713          	addi	a4,a4,-1416 # ffffffe000206028 <task>
ffffffe0002005b8:	fec42783          	lw	a5,-20(s0)
ffffffe0002005bc:	00379793          	slli	a5,a5,0x3
ffffffe0002005c0:	00f707b3          	add	a5,a4,a5
ffffffe0002005c4:	0007b783          	ld	a5,0(a5)
ffffffe0002005c8:	00068713          	mv	a4,a3
ffffffe0002005cc:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe0002005d0:	00006717          	auipc	a4,0x6
ffffffe0002005d4:	a5870713          	addi	a4,a4,-1448 # ffffffe000206028 <task>
ffffffe0002005d8:	fec42783          	lw	a5,-20(s0)
ffffffe0002005dc:	00379793          	slli	a5,a5,0x3
ffffffe0002005e0:	00f707b3          	add	a5,a4,a5
ffffffe0002005e4:	0007b783          	ld	a5,0(a5)
ffffffe0002005e8:	fec42703          	lw	a4,-20(s0)
ffffffe0002005ec:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe0002005f0:	00006717          	auipc	a4,0x6
ffffffe0002005f4:	a3870713          	addi	a4,a4,-1480 # ffffffe000206028 <task>
ffffffe0002005f8:	fec42783          	lw	a5,-20(s0)
ffffffe0002005fc:	00379793          	slli	a5,a5,0x3
ffffffe000200600:	00f707b3          	add	a5,a4,a5
ffffffe000200604:	0007b783          	ld	a5,0(a5)
ffffffe000200608:	00000717          	auipc	a4,0x0
ffffffe00020060c:	ba470713          	addi	a4,a4,-1116 # ffffffe0002001ac <__dummy>
ffffffe000200610:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe000200614:	00006717          	auipc	a4,0x6
ffffffe000200618:	a1470713          	addi	a4,a4,-1516 # ffffffe000206028 <task>
ffffffe00020061c:	fec42783          	lw	a5,-20(s0)
ffffffe000200620:	00379793          	slli	a5,a5,0x3
ffffffe000200624:	00f707b3          	add	a5,a4,a5
ffffffe000200628:	0007b783          	ld	a5,0(a5)
ffffffe00020062c:	00078693          	mv	a3,a5
ffffffe000200630:	00006717          	auipc	a4,0x6
ffffffe000200634:	9f870713          	addi	a4,a4,-1544 # ffffffe000206028 <task>
ffffffe000200638:	fec42783          	lw	a5,-20(s0)
ffffffe00020063c:	00379793          	slli	a5,a5,0x3
ffffffe000200640:	00f707b3          	add	a5,a4,a5
ffffffe000200644:	0007b783          	ld	a5,0(a5)
ffffffe000200648:	00001737          	lui	a4,0x1
ffffffe00020064c:	00e68733          	add	a4,a3,a4
ffffffe000200650:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200654:	fec42783          	lw	a5,-20(s0)
ffffffe000200658:	0017879b          	addiw	a5,a5,1
ffffffe00020065c:	fef42623          	sw	a5,-20(s0)
ffffffe000200660:	fec42783          	lw	a5,-20(s0)
ffffffe000200664:	0007871b          	sext.w	a4,a5
ffffffe000200668:	00400793          	li	a5,4
ffffffe00020066c:	e8e7dce3          	bge	a5,a4,ffffffe000200504 <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe000200670:	00003517          	auipc	a0,0x3
ffffffe000200674:	9c050513          	addi	a0,a0,-1600 # ffffffe000203030 <_srodata+0x30>
ffffffe000200678:	515010ef          	jal	ffffffe00020238c <printk>
}
ffffffe00020067c:	00000013          	nop
ffffffe000200680:	01813083          	ld	ra,24(sp)
ffffffe000200684:	01013403          	ld	s0,16(sp)
ffffffe000200688:	02010113          	addi	sp,sp,32
ffffffe00020068c:	00008067          	ret

ffffffe000200690 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe000200690:	fd010113          	addi	sp,sp,-48
ffffffe000200694:	02113423          	sd	ra,40(sp)
ffffffe000200698:	02813023          	sd	s0,32(sp)
ffffffe00020069c:	03010413          	addi	s0,sp,48
    // LOG(RED);
    uint64_t MOD = 1000000007;
ffffffe0002006a0:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe0002006a4:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe0002006a8:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe0002006ac:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe0002006b0:	fff00793          	li	a5,-1
ffffffe0002006b4:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002006b8:	fe442783          	lw	a5,-28(s0)
ffffffe0002006bc:	0007871b          	sext.w	a4,a5
ffffffe0002006c0:	fff00793          	li	a5,-1
ffffffe0002006c4:	00f70e63          	beq	a4,a5,ffffffe0002006e0 <dummy+0x50>
ffffffe0002006c8:	00006797          	auipc	a5,0x6
ffffffe0002006cc:	94878793          	addi	a5,a5,-1720 # ffffffe000206010 <current>
ffffffe0002006d0:	0007b783          	ld	a5,0(a5)
ffffffe0002006d4:	0087b703          	ld	a4,8(a5)
ffffffe0002006d8:	fe442783          	lw	a5,-28(s0)
ffffffe0002006dc:	fcf70ee3          	beq	a4,a5,ffffffe0002006b8 <dummy+0x28>
ffffffe0002006e0:	00006797          	auipc	a5,0x6
ffffffe0002006e4:	93078793          	addi	a5,a5,-1744 # ffffffe000206010 <current>
ffffffe0002006e8:	0007b783          	ld	a5,0(a5)
ffffffe0002006ec:	0087b783          	ld	a5,8(a5)
ffffffe0002006f0:	fc0784e3          	beqz	a5,ffffffe0002006b8 <dummy+0x28>
            if (current->counter == 1) {
ffffffe0002006f4:	00006797          	auipc	a5,0x6
ffffffe0002006f8:	91c78793          	addi	a5,a5,-1764 # ffffffe000206010 <current>
ffffffe0002006fc:	0007b783          	ld	a5,0(a5)
ffffffe000200700:	0087b703          	ld	a4,8(a5)
ffffffe000200704:	00100793          	li	a5,1
ffffffe000200708:	00f71e63          	bne	a4,a5,ffffffe000200724 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe00020070c:	00006797          	auipc	a5,0x6
ffffffe000200710:	90478793          	addi	a5,a5,-1788 # ffffffe000206010 <current>
ffffffe000200714:	0007b783          	ld	a5,0(a5)
ffffffe000200718:	0087b703          	ld	a4,8(a5)
ffffffe00020071c:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe000200720:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe000200724:	00006797          	auipc	a5,0x6
ffffffe000200728:	8ec78793          	addi	a5,a5,-1812 # ffffffe000206010 <current>
ffffffe00020072c:	0007b783          	ld	a5,0(a5)
ffffffe000200730:	0087b783          	ld	a5,8(a5)
ffffffe000200734:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe000200738:	fe843783          	ld	a5,-24(s0)
ffffffe00020073c:	00178713          	addi	a4,a5,1
ffffffe000200740:	fd843783          	ld	a5,-40(s0)
ffffffe000200744:	02f777b3          	remu	a5,a4,a5
ffffffe000200748:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe00020074c:	00006797          	auipc	a5,0x6
ffffffe000200750:	8c478793          	addi	a5,a5,-1852 # ffffffe000206010 <current>
ffffffe000200754:	0007b783          	ld	a5,0(a5)
ffffffe000200758:	0187b783          	ld	a5,24(a5)
ffffffe00020075c:	fe843603          	ld	a2,-24(s0)
ffffffe000200760:	00078593          	mv	a1,a5
ffffffe000200764:	00003517          	auipc	a0,0x3
ffffffe000200768:	8e450513          	addi	a0,a0,-1820 # ffffffe000203048 <_srodata+0x48>
ffffffe00020076c:	421010ef          	jal	ffffffe00020238c <printk>
            // LOG(RED "%llu\n", current->thread.ra);
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
ffffffe000200770:	00006797          	auipc	a5,0x6
ffffffe000200774:	8a078793          	addi	a5,a5,-1888 # ffffffe000206010 <current>
ffffffe000200778:	0007b783          	ld	a5,0(a5)
ffffffe00020077c:	0187b783          	ld	a5,24(a5)
ffffffe000200780:	0ff7f713          	zext.b	a4,a5
ffffffe000200784:	00006797          	auipc	a5,0x6
ffffffe000200788:	89478793          	addi	a5,a5,-1900 # ffffffe000206018 <tasks_output_index>
ffffffe00020078c:	0007a783          	lw	a5,0(a5)
ffffffe000200790:	0017869b          	addiw	a3,a5,1
ffffffe000200794:	0006861b          	sext.w	a2,a3
ffffffe000200798:	00006697          	auipc	a3,0x6
ffffffe00020079c:	88068693          	addi	a3,a3,-1920 # ffffffe000206018 <tasks_output_index>
ffffffe0002007a0:	00c6a023          	sw	a2,0(a3)
ffffffe0002007a4:	0307071b          	addiw	a4,a4,48
ffffffe0002007a8:	0ff77713          	zext.b	a4,a4
ffffffe0002007ac:	00006697          	auipc	a3,0x6
ffffffe0002007b0:	8a468693          	addi	a3,a3,-1884 # ffffffe000206050 <tasks_output>
ffffffe0002007b4:	00f687b3          	add	a5,a3,a5
ffffffe0002007b8:	00e78023          	sb	a4,0(a5)
            if (tasks_output_index == MAX_OUTPUT) {
ffffffe0002007bc:	00006797          	auipc	a5,0x6
ffffffe0002007c0:	85c78793          	addi	a5,a5,-1956 # ffffffe000206018 <tasks_output_index>
ffffffe0002007c4:	0007a703          	lw	a4,0(a5)
ffffffe0002007c8:	02800793          	li	a5,40
ffffffe0002007cc:	eef716e3          	bne	a4,a5,ffffffe0002006b8 <dummy+0x28>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
ffffffe0002007d0:	fe042023          	sw	zero,-32(s0)
ffffffe0002007d4:	0800006f          	j	ffffffe000200854 <dummy+0x1c4>
                    if (tasks_output[i] != expected_output[i]) {
ffffffe0002007d8:	00006717          	auipc	a4,0x6
ffffffe0002007dc:	87870713          	addi	a4,a4,-1928 # ffffffe000206050 <tasks_output>
ffffffe0002007e0:	fe042783          	lw	a5,-32(s0)
ffffffe0002007e4:	00f707b3          	add	a5,a4,a5
ffffffe0002007e8:	0007c683          	lbu	a3,0(a5)
ffffffe0002007ec:	00004717          	auipc	a4,0x4
ffffffe0002007f0:	81c70713          	addi	a4,a4,-2020 # ffffffe000204008 <expected_output>
ffffffe0002007f4:	fe042783          	lw	a5,-32(s0)
ffffffe0002007f8:	00f707b3          	add	a5,a4,a5
ffffffe0002007fc:	0007c783          	lbu	a5,0(a5)
ffffffe000200800:	00068713          	mv	a4,a3
ffffffe000200804:	04f70263          	beq	a4,a5,ffffffe000200848 <dummy+0x1b8>
                        printk("\033[31mTest failed!\033[0m\n");
ffffffe000200808:	00003517          	auipc	a0,0x3
ffffffe00020080c:	87050513          	addi	a0,a0,-1936 # ffffffe000203078 <_srodata+0x78>
ffffffe000200810:	37d010ef          	jal	ffffffe00020238c <printk>
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
ffffffe000200814:	00003597          	auipc	a1,0x3
ffffffe000200818:	7f458593          	addi	a1,a1,2036 # ffffffe000204008 <expected_output>
ffffffe00020081c:	00003517          	auipc	a0,0x3
ffffffe000200820:	87450513          	addi	a0,a0,-1932 # ffffffe000203090 <_srodata+0x90>
ffffffe000200824:	369010ef          	jal	ffffffe00020238c <printk>
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
ffffffe000200828:	00006597          	auipc	a1,0x6
ffffffe00020082c:	82858593          	addi	a1,a1,-2008 # ffffffe000206050 <tasks_output>
ffffffe000200830:	00003517          	auipc	a0,0x3
ffffffe000200834:	88050513          	addi	a0,a0,-1920 # ffffffe0002030b0 <_srodata+0xb0>
ffffffe000200838:	355010ef          	jal	ffffffe00020238c <printk>
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe00020083c:	00000593          	li	a1,0
ffffffe000200840:	00000513          	li	a0,0
ffffffe000200844:	4d4000ef          	jal	ffffffe000200d18 <sbi_system_reset>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
ffffffe000200848:	fe042783          	lw	a5,-32(s0)
ffffffe00020084c:	0017879b          	addiw	a5,a5,1
ffffffe000200850:	fef42023          	sw	a5,-32(s0)
ffffffe000200854:	fe042783          	lw	a5,-32(s0)
ffffffe000200858:	0007871b          	sext.w	a4,a5
ffffffe00020085c:	02700793          	li	a5,39
ffffffe000200860:	f6e7dce3          	bge	a5,a4,ffffffe0002007d8 <dummy+0x148>
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
ffffffe000200864:	00003517          	auipc	a0,0x3
ffffffe000200868:	86c50513          	addi	a0,a0,-1940 # ffffffe0002030d0 <_srodata+0xd0>
ffffffe00020086c:	321010ef          	jal	ffffffe00020238c <printk>
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
ffffffe000200870:	00003597          	auipc	a1,0x3
ffffffe000200874:	79858593          	addi	a1,a1,1944 # ffffffe000204008 <expected_output>
ffffffe000200878:	00003517          	auipc	a0,0x3
ffffffe00020087c:	87050513          	addi	a0,a0,-1936 # ffffffe0002030e8 <_srodata+0xe8>
ffffffe000200880:	30d010ef          	jal	ffffffe00020238c <printk>
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe000200884:	00000593          	li	a1,0
ffffffe000200888:	00000513          	li	a0,0
ffffffe00020088c:	48c000ef          	jal	ffffffe000200d18 <sbi_system_reset>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000200890:	e29ff06f          	j	ffffffe0002006b8 <dummy+0x28>

ffffffe000200894 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe000200894:	fd010113          	addi	sp,sp,-48
ffffffe000200898:	02113423          	sd	ra,40(sp)
ffffffe00020089c:	02813023          	sd	s0,32(sp)
ffffffe0002008a0:	03010413          	addi	s0,sp,48
ffffffe0002008a4:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe0002008a8:	00003697          	auipc	a3,0x3
ffffffe0002008ac:	94068693          	addi	a3,a3,-1728 # ffffffe0002031e8 <__func__.0>
ffffffe0002008b0:	06500613          	li	a2,101
ffffffe0002008b4:	00003597          	auipc	a1,0x3
ffffffe0002008b8:	85458593          	addi	a1,a1,-1964 # ffffffe000203108 <_srodata+0x108>
ffffffe0002008bc:	00003517          	auipc	a0,0x3
ffffffe0002008c0:	85450513          	addi	a0,a0,-1964 # ffffffe000203110 <_srodata+0x110>
ffffffe0002008c4:	2c9010ef          	jal	ffffffe00020238c <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe0002008c8:	00005797          	auipc	a5,0x5
ffffffe0002008cc:	74878793          	addi	a5,a5,1864 # ffffffe000206010 <current>
ffffffe0002008d0:	0007b783          	ld	a5,0(a5)
ffffffe0002008d4:	0187b703          	ld	a4,24(a5)
ffffffe0002008d8:	fd843783          	ld	a5,-40(s0)
ffffffe0002008dc:	0187b783          	ld	a5,24(a5)
ffffffe0002008e0:	00003697          	auipc	a3,0x3
ffffffe0002008e4:	90868693          	addi	a3,a3,-1784 # ffffffe0002031e8 <__func__.0>
ffffffe0002008e8:	06600613          	li	a2,102
ffffffe0002008ec:	00003597          	auipc	a1,0x3
ffffffe0002008f0:	81c58593          	addi	a1,a1,-2020 # ffffffe000203108 <_srodata+0x108>
ffffffe0002008f4:	00003517          	auipc	a0,0x3
ffffffe0002008f8:	83c50513          	addi	a0,a0,-1988 # ffffffe000203130 <_srodata+0x130>
ffffffe0002008fc:	291010ef          	jal	ffffffe00020238c <printk>
    if(current->pid != next->pid) {
ffffffe000200900:	00005797          	auipc	a5,0x5
ffffffe000200904:	71078793          	addi	a5,a5,1808 # ffffffe000206010 <current>
ffffffe000200908:	0007b783          	ld	a5,0(a5)
ffffffe00020090c:	0187b703          	ld	a4,24(a5)
ffffffe000200910:	fd843783          	ld	a5,-40(s0)
ffffffe000200914:	0187b783          	ld	a5,24(a5)
ffffffe000200918:	06f70a63          	beq	a4,a5,ffffffe00020098c <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe00020091c:	00005797          	auipc	a5,0x5
ffffffe000200920:	6f478793          	addi	a5,a5,1780 # ffffffe000206010 <current>
ffffffe000200924:	0007b783          	ld	a5,0(a5)
ffffffe000200928:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe00020092c:	00005797          	auipc	a5,0x5
ffffffe000200930:	6e478793          	addi	a5,a5,1764 # ffffffe000206010 <current>
ffffffe000200934:	fd843703          	ld	a4,-40(s0)
ffffffe000200938:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe00020093c:	00005797          	auipc	a5,0x5
ffffffe000200940:	6d478793          	addi	a5,a5,1748 # ffffffe000206010 <current>
ffffffe000200944:	0007b783          	ld	a5,0(a5)
ffffffe000200948:	0187b703          	ld	a4,24(a5)
ffffffe00020094c:	00005797          	auipc	a5,0x5
ffffffe000200950:	6c478793          	addi	a5,a5,1732 # ffffffe000206010 <current>
ffffffe000200954:	0007b783          	ld	a5,0(a5)
ffffffe000200958:	0107b603          	ld	a2,16(a5)
ffffffe00020095c:	00005797          	auipc	a5,0x5
ffffffe000200960:	6b478793          	addi	a5,a5,1716 # ffffffe000206010 <current>
ffffffe000200964:	0007b783          	ld	a5,0(a5)
ffffffe000200968:	0087b783          	ld	a5,8(a5)
ffffffe00020096c:	00078693          	mv	a3,a5
ffffffe000200970:	00070593          	mv	a1,a4
ffffffe000200974:	00002517          	auipc	a0,0x2
ffffffe000200978:	7fc50513          	addi	a0,a0,2044 # ffffffe000203170 <_srodata+0x170>
ffffffe00020097c:	211010ef          	jal	ffffffe00020238c <printk>
        __switch_to(prev, next);
ffffffe000200980:	fd843583          	ld	a1,-40(s0)
ffffffe000200984:	fe843503          	ld	a0,-24(s0)
ffffffe000200988:	835ff0ef          	jal	ffffffe0002001bc <__switch_to>
    }
}
ffffffe00020098c:	00000013          	nop
ffffffe000200990:	02813083          	ld	ra,40(sp)
ffffffe000200994:	02013403          	ld	s0,32(sp)
ffffffe000200998:	03010113          	addi	sp,sp,48
ffffffe00020099c:	00008067          	ret

ffffffe0002009a0 <do_timer>:

void do_timer() {
ffffffe0002009a0:	ff010113          	addi	sp,sp,-16
ffffffe0002009a4:	00113423          	sd	ra,8(sp)
ffffffe0002009a8:	00813023          	sd	s0,0(sp)
ffffffe0002009ac:	01010413          	addi	s0,sp,16
    // LOG(RED);
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe0002009b0:	00005797          	auipc	a5,0x5
ffffffe0002009b4:	66078793          	addi	a5,a5,1632 # ffffffe000206010 <current>
ffffffe0002009b8:	0007b783          	ld	a5,0(a5)
ffffffe0002009bc:	0187b703          	ld	a4,24(a5)
ffffffe0002009c0:	00005797          	auipc	a5,0x5
ffffffe0002009c4:	64878793          	addi	a5,a5,1608 # ffffffe000206008 <idle>
ffffffe0002009c8:	0007b783          	ld	a5,0(a5)
ffffffe0002009cc:	0187b783          	ld	a5,24(a5)
ffffffe0002009d0:	00f70c63          	beq	a4,a5,ffffffe0002009e8 <do_timer+0x48>
ffffffe0002009d4:	00005797          	auipc	a5,0x5
ffffffe0002009d8:	63c78793          	addi	a5,a5,1596 # ffffffe000206010 <current>
ffffffe0002009dc:	0007b783          	ld	a5,0(a5)
ffffffe0002009e0:	0087b783          	ld	a5,8(a5)
ffffffe0002009e4:	00079663          	bnez	a5,ffffffe0002009f0 <do_timer+0x50>
        schedule();
ffffffe0002009e8:	038000ef          	jal	ffffffe000200a20 <schedule>
ffffffe0002009ec:	0200006f          	j	ffffffe000200a0c <do_timer+0x6c>
    }
    else --(current->counter);
ffffffe0002009f0:	00005797          	auipc	a5,0x5
ffffffe0002009f4:	62078793          	addi	a5,a5,1568 # ffffffe000206010 <current>
ffffffe0002009f8:	0007b783          	ld	a5,0(a5)
ffffffe0002009fc:	0087b703          	ld	a4,8(a5)
ffffffe000200a00:	fff70713          	addi	a4,a4,-1
ffffffe000200a04:	00e7b423          	sd	a4,8(a5)
}
ffffffe000200a08:	00000013          	nop
ffffffe000200a0c:	00000013          	nop
ffffffe000200a10:	00813083          	ld	ra,8(sp)
ffffffe000200a14:	00013403          	ld	s0,0(sp)
ffffffe000200a18:	01010113          	addi	sp,sp,16
ffffffe000200a1c:	00008067          	ret

ffffffe000200a20 <schedule>:

void schedule() {
ffffffe000200a20:	fe010113          	addi	sp,sp,-32
ffffffe000200a24:	00113c23          	sd	ra,24(sp)
ffffffe000200a28:	00813823          	sd	s0,16(sp)
ffffffe000200a2c:	02010413          	addi	s0,sp,32
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    // LOG(RED);
    struct task_struct *next = idle;
ffffffe000200a30:	00005797          	auipc	a5,0x5
ffffffe000200a34:	5d878793          	addi	a5,a5,1496 # ffffffe000206008 <idle>
ffffffe000200a38:	0007b783          	ld	a5,0(a5)
ffffffe000200a3c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a40:	00100793          	li	a5,1
ffffffe000200a44:	fef42223          	sw	a5,-28(s0)
ffffffe000200a48:	0540006f          	j	ffffffe000200a9c <schedule+0x7c>
        if(task[i]->counter > next->counter){
ffffffe000200a4c:	00005717          	auipc	a4,0x5
ffffffe000200a50:	5dc70713          	addi	a4,a4,1500 # ffffffe000206028 <task>
ffffffe000200a54:	fe442783          	lw	a5,-28(s0)
ffffffe000200a58:	00379793          	slli	a5,a5,0x3
ffffffe000200a5c:	00f707b3          	add	a5,a4,a5
ffffffe000200a60:	0007b783          	ld	a5,0(a5)
ffffffe000200a64:	0087b703          	ld	a4,8(a5)
ffffffe000200a68:	fe843783          	ld	a5,-24(s0)
ffffffe000200a6c:	0087b783          	ld	a5,8(a5)
ffffffe000200a70:	02e7f063          	bgeu	a5,a4,ffffffe000200a90 <schedule+0x70>
            next = task[i];
ffffffe000200a74:	00005717          	auipc	a4,0x5
ffffffe000200a78:	5b470713          	addi	a4,a4,1460 # ffffffe000206028 <task>
ffffffe000200a7c:	fe442783          	lw	a5,-28(s0)
ffffffe000200a80:	00379793          	slli	a5,a5,0x3
ffffffe000200a84:	00f707b3          	add	a5,a4,a5
ffffffe000200a88:	0007b783          	ld	a5,0(a5)
ffffffe000200a8c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a90:	fe442783          	lw	a5,-28(s0)
ffffffe000200a94:	0017879b          	addiw	a5,a5,1
ffffffe000200a98:	fef42223          	sw	a5,-28(s0)
ffffffe000200a9c:	fe442783          	lw	a5,-28(s0)
ffffffe000200aa0:	0007871b          	sext.w	a4,a5
ffffffe000200aa4:	00400793          	li	a5,4
ffffffe000200aa8:	fae7d2e3          	bge	a5,a4,ffffffe000200a4c <schedule+0x2c>
        }
    }

    if(next->counter == 0) {
ffffffe000200aac:	fe843783          	ld	a5,-24(s0)
ffffffe000200ab0:	0087b783          	ld	a5,8(a5)
ffffffe000200ab4:	0c079e63          	bnez	a5,ffffffe000200b90 <schedule+0x170>
        printk("\n");
ffffffe000200ab8:	00002517          	auipc	a0,0x2
ffffffe000200abc:	6f050513          	addi	a0,a0,1776 # ffffffe0002031a8 <_srodata+0x1a8>
ffffffe000200ac0:	0cd010ef          	jal	ffffffe00020238c <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200ac4:	00100793          	li	a5,1
ffffffe000200ac8:	fef42023          	sw	a5,-32(s0)
ffffffe000200acc:	0ac0006f          	j	ffffffe000200b78 <schedule+0x158>
            task[i]->counter = task[i]->priority;
ffffffe000200ad0:	00005717          	auipc	a4,0x5
ffffffe000200ad4:	55870713          	addi	a4,a4,1368 # ffffffe000206028 <task>
ffffffe000200ad8:	fe042783          	lw	a5,-32(s0)
ffffffe000200adc:	00379793          	slli	a5,a5,0x3
ffffffe000200ae0:	00f707b3          	add	a5,a4,a5
ffffffe000200ae4:	0007b703          	ld	a4,0(a5)
ffffffe000200ae8:	00005697          	auipc	a3,0x5
ffffffe000200aec:	54068693          	addi	a3,a3,1344 # ffffffe000206028 <task>
ffffffe000200af0:	fe042783          	lw	a5,-32(s0)
ffffffe000200af4:	00379793          	slli	a5,a5,0x3
ffffffe000200af8:	00f687b3          	add	a5,a3,a5
ffffffe000200afc:	0007b783          	ld	a5,0(a5)
ffffffe000200b00:	01073703          	ld	a4,16(a4)
ffffffe000200b04:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200b08:	00005717          	auipc	a4,0x5
ffffffe000200b0c:	52070713          	addi	a4,a4,1312 # ffffffe000206028 <task>
ffffffe000200b10:	fe042783          	lw	a5,-32(s0)
ffffffe000200b14:	00379793          	slli	a5,a5,0x3
ffffffe000200b18:	00f707b3          	add	a5,a4,a5
ffffffe000200b1c:	0007b783          	ld	a5,0(a5)
ffffffe000200b20:	0187b583          	ld	a1,24(a5)
ffffffe000200b24:	00005717          	auipc	a4,0x5
ffffffe000200b28:	50470713          	addi	a4,a4,1284 # ffffffe000206028 <task>
ffffffe000200b2c:	fe042783          	lw	a5,-32(s0)
ffffffe000200b30:	00379793          	slli	a5,a5,0x3
ffffffe000200b34:	00f707b3          	add	a5,a4,a5
ffffffe000200b38:	0007b783          	ld	a5,0(a5)
ffffffe000200b3c:	0107b603          	ld	a2,16(a5)
ffffffe000200b40:	00005717          	auipc	a4,0x5
ffffffe000200b44:	4e870713          	addi	a4,a4,1256 # ffffffe000206028 <task>
ffffffe000200b48:	fe042783          	lw	a5,-32(s0)
ffffffe000200b4c:	00379793          	slli	a5,a5,0x3
ffffffe000200b50:	00f707b3          	add	a5,a4,a5
ffffffe000200b54:	0007b783          	ld	a5,0(a5)
ffffffe000200b58:	0087b783          	ld	a5,8(a5)
ffffffe000200b5c:	00078693          	mv	a3,a5
ffffffe000200b60:	00002517          	auipc	a0,0x2
ffffffe000200b64:	65050513          	addi	a0,a0,1616 # ffffffe0002031b0 <_srodata+0x1b0>
ffffffe000200b68:	025010ef          	jal	ffffffe00020238c <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200b6c:	fe042783          	lw	a5,-32(s0)
ffffffe000200b70:	0017879b          	addiw	a5,a5,1
ffffffe000200b74:	fef42023          	sw	a5,-32(s0)
ffffffe000200b78:	fe042783          	lw	a5,-32(s0)
ffffffe000200b7c:	0007871b          	sext.w	a4,a5
ffffffe000200b80:	00400793          	li	a5,4
ffffffe000200b84:	f4e7d6e3          	bge	a5,a4,ffffffe000200ad0 <schedule+0xb0>
        }
        schedule();
ffffffe000200b88:	e99ff0ef          	jal	ffffffe000200a20 <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200b8c:	00c0006f          	j	ffffffe000200b98 <schedule+0x178>
        switch_to(next);
ffffffe000200b90:	fe843503          	ld	a0,-24(s0)
ffffffe000200b94:	d01ff0ef          	jal	ffffffe000200894 <switch_to>
ffffffe000200b98:	00000013          	nop
ffffffe000200b9c:	01813083          	ld	ra,24(sp)
ffffffe000200ba0:	01013403          	ld	s0,16(sp)
ffffffe000200ba4:	02010113          	addi	sp,sp,32
ffffffe000200ba8:	00008067          	ret

ffffffe000200bac <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200bac:	f7010113          	addi	sp,sp,-144
ffffffe000200bb0:	08113423          	sd	ra,136(sp)
ffffffe000200bb4:	08813023          	sd	s0,128(sp)
ffffffe000200bb8:	06913c23          	sd	s1,120(sp)
ffffffe000200bbc:	07213823          	sd	s2,112(sp)
ffffffe000200bc0:	07313423          	sd	s3,104(sp)
ffffffe000200bc4:	09010413          	addi	s0,sp,144
ffffffe000200bc8:	faa43423          	sd	a0,-88(s0)
ffffffe000200bcc:	fab43023          	sd	a1,-96(s0)
ffffffe000200bd0:	f8c43c23          	sd	a2,-104(s0)
ffffffe000200bd4:	f8d43823          	sd	a3,-112(s0)
ffffffe000200bd8:	f8e43423          	sd	a4,-120(s0)
ffffffe000200bdc:	f8f43023          	sd	a5,-128(s0)
ffffffe000200be0:	f7043c23          	sd	a6,-136(s0)
ffffffe000200be4:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200be8:	fa843e03          	ld	t3,-88(s0)
ffffffe000200bec:	fa043e83          	ld	t4,-96(s0)
ffffffe000200bf0:	f9843f03          	ld	t5,-104(s0)
ffffffe000200bf4:	f9043f83          	ld	t6,-112(s0)
ffffffe000200bf8:	f8843283          	ld	t0,-120(s0)
ffffffe000200bfc:	f8043483          	ld	s1,-128(s0)
ffffffe000200c00:	f7843903          	ld	s2,-136(s0)
ffffffe000200c04:	f7043983          	ld	s3,-144(s0)
ffffffe000200c08:	000e0893          	mv	a7,t3
ffffffe000200c0c:	000e8813          	mv	a6,t4
ffffffe000200c10:	000f0513          	mv	a0,t5
ffffffe000200c14:	000f8593          	mv	a1,t6
ffffffe000200c18:	00028613          	mv	a2,t0
ffffffe000200c1c:	00048693          	mv	a3,s1
ffffffe000200c20:	00090713          	mv	a4,s2
ffffffe000200c24:	00098793          	mv	a5,s3
ffffffe000200c28:	00000073          	ecall
ffffffe000200c2c:	00050e93          	mv	t4,a0
ffffffe000200c30:	00058e13          	mv	t3,a1
ffffffe000200c34:	fbd43823          	sd	t4,-80(s0)
ffffffe000200c38:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200c3c:	fb043783          	ld	a5,-80(s0)
ffffffe000200c40:	fcf43023          	sd	a5,-64(s0)
ffffffe000200c44:	fb843783          	ld	a5,-72(s0)
ffffffe000200c48:	fcf43423          	sd	a5,-56(s0)
ffffffe000200c4c:	fc043703          	ld	a4,-64(s0)
ffffffe000200c50:	fc843783          	ld	a5,-56(s0)
ffffffe000200c54:	00070313          	mv	t1,a4
ffffffe000200c58:	00078393          	mv	t2,a5
ffffffe000200c5c:	00030713          	mv	a4,t1
ffffffe000200c60:	00038793          	mv	a5,t2
}
ffffffe000200c64:	00070513          	mv	a0,a4
ffffffe000200c68:	00078593          	mv	a1,a5
ffffffe000200c6c:	08813083          	ld	ra,136(sp)
ffffffe000200c70:	08013403          	ld	s0,128(sp)
ffffffe000200c74:	07813483          	ld	s1,120(sp)
ffffffe000200c78:	07013903          	ld	s2,112(sp)
ffffffe000200c7c:	06813983          	ld	s3,104(sp)
ffffffe000200c80:	09010113          	addi	sp,sp,144
ffffffe000200c84:	00008067          	ret

ffffffe000200c88 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200c88:	fc010113          	addi	sp,sp,-64
ffffffe000200c8c:	02113c23          	sd	ra,56(sp)
ffffffe000200c90:	02813823          	sd	s0,48(sp)
ffffffe000200c94:	03213423          	sd	s2,40(sp)
ffffffe000200c98:	03313023          	sd	s3,32(sp)
ffffffe000200c9c:	04010413          	addi	s0,sp,64
ffffffe000200ca0:	00050793          	mv	a5,a0
ffffffe000200ca4:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200ca8:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200cac:	00000893          	li	a7,0
ffffffe000200cb0:	00000813          	li	a6,0
ffffffe000200cb4:	00000793          	li	a5,0
ffffffe000200cb8:	00000713          	li	a4,0
ffffffe000200cbc:	00000693          	li	a3,0
ffffffe000200cc0:	00200593          	li	a1,2
ffffffe000200cc4:	44424537          	lui	a0,0x44424
ffffffe000200cc8:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200ccc:	ee1ff0ef          	jal	ffffffe000200bac <sbi_ecall>
ffffffe000200cd0:	00050713          	mv	a4,a0
ffffffe000200cd4:	00058793          	mv	a5,a1
ffffffe000200cd8:	fce43823          	sd	a4,-48(s0)
ffffffe000200cdc:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ce0:	fd043703          	ld	a4,-48(s0)
ffffffe000200ce4:	fd843783          	ld	a5,-40(s0)
ffffffe000200ce8:	00070913          	mv	s2,a4
ffffffe000200cec:	00078993          	mv	s3,a5
ffffffe000200cf0:	00090713          	mv	a4,s2
ffffffe000200cf4:	00098793          	mv	a5,s3
}
ffffffe000200cf8:	00070513          	mv	a0,a4
ffffffe000200cfc:	00078593          	mv	a1,a5
ffffffe000200d00:	03813083          	ld	ra,56(sp)
ffffffe000200d04:	03013403          	ld	s0,48(sp)
ffffffe000200d08:	02813903          	ld	s2,40(sp)
ffffffe000200d0c:	02013983          	ld	s3,32(sp)
ffffffe000200d10:	04010113          	addi	sp,sp,64
ffffffe000200d14:	00008067          	ret

ffffffe000200d18 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200d18:	fc010113          	addi	sp,sp,-64
ffffffe000200d1c:	02113c23          	sd	ra,56(sp)
ffffffe000200d20:	02813823          	sd	s0,48(sp)
ffffffe000200d24:	03213423          	sd	s2,40(sp)
ffffffe000200d28:	03313023          	sd	s3,32(sp)
ffffffe000200d2c:	04010413          	addi	s0,sp,64
ffffffe000200d30:	00050793          	mv	a5,a0
ffffffe000200d34:	00058713          	mv	a4,a1
ffffffe000200d38:	fcf42623          	sw	a5,-52(s0)
ffffffe000200d3c:	00070793          	mv	a5,a4
ffffffe000200d40:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200d44:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200d48:	fc846683          	lwu	a3,-56(s0)
ffffffe000200d4c:	00000893          	li	a7,0
ffffffe000200d50:	00000813          	li	a6,0
ffffffe000200d54:	00000793          	li	a5,0
ffffffe000200d58:	00000713          	li	a4,0
ffffffe000200d5c:	00000593          	li	a1,0
ffffffe000200d60:	53525537          	lui	a0,0x53525
ffffffe000200d64:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200d68:	e45ff0ef          	jal	ffffffe000200bac <sbi_ecall>
ffffffe000200d6c:	00050713          	mv	a4,a0
ffffffe000200d70:	00058793          	mv	a5,a1
ffffffe000200d74:	fce43823          	sd	a4,-48(s0)
ffffffe000200d78:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d7c:	fd043703          	ld	a4,-48(s0)
ffffffe000200d80:	fd843783          	ld	a5,-40(s0)
ffffffe000200d84:	00070913          	mv	s2,a4
ffffffe000200d88:	00078993          	mv	s3,a5
ffffffe000200d8c:	00090713          	mv	a4,s2
ffffffe000200d90:	00098793          	mv	a5,s3
}
ffffffe000200d94:	00070513          	mv	a0,a4
ffffffe000200d98:	00078593          	mv	a1,a5
ffffffe000200d9c:	03813083          	ld	ra,56(sp)
ffffffe000200da0:	03013403          	ld	s0,48(sp)
ffffffe000200da4:	02813903          	ld	s2,40(sp)
ffffffe000200da8:	02013983          	ld	s3,32(sp)
ffffffe000200dac:	04010113          	addi	sp,sp,64
ffffffe000200db0:	00008067          	ret

ffffffe000200db4 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200db4:	fc010113          	addi	sp,sp,-64
ffffffe000200db8:	02113c23          	sd	ra,56(sp)
ffffffe000200dbc:	02813823          	sd	s0,48(sp)
ffffffe000200dc0:	03213423          	sd	s2,40(sp)
ffffffe000200dc4:	03313023          	sd	s3,32(sp)
ffffffe000200dc8:	04010413          	addi	s0,sp,64
ffffffe000200dcc:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200dd0:	00000893          	li	a7,0
ffffffe000200dd4:	00000813          	li	a6,0
ffffffe000200dd8:	00000793          	li	a5,0
ffffffe000200ddc:	00000713          	li	a4,0
ffffffe000200de0:	00000693          	li	a3,0
ffffffe000200de4:	fc843603          	ld	a2,-56(s0)
ffffffe000200de8:	00000593          	li	a1,0
ffffffe000200dec:	54495537          	lui	a0,0x54495
ffffffe000200df0:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200df4:	db9ff0ef          	jal	ffffffe000200bac <sbi_ecall>
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
ffffffe000200e28:	03813083          	ld	ra,56(sp)
ffffffe000200e2c:	03013403          	ld	s0,48(sp)
ffffffe000200e30:	02813903          	ld	s2,40(sp)
ffffffe000200e34:	02013983          	ld	s3,32(sp)
ffffffe000200e38:	04010113          	addi	sp,sp,64
ffffffe000200e3c:	00008067          	ret

ffffffe000200e40 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
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
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e64:	00000893          	li	a7,0
ffffffe000200e68:	00000813          	li	a6,0
ffffffe000200e6c:	00000793          	li	a5,0
ffffffe000200e70:	fb843703          	ld	a4,-72(s0)
ffffffe000200e74:	fc043683          	ld	a3,-64(s0)
ffffffe000200e78:	fc843603          	ld	a2,-56(s0)
ffffffe000200e7c:	00100593          	li	a1,1
ffffffe000200e80:	44424537          	lui	a0,0x44424
ffffffe000200e84:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e88:	d25ff0ef          	jal	ffffffe000200bac <sbi_ecall>
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
}
ffffffe000200eb4:	00070513          	mv	a0,a4
ffffffe000200eb8:	00078593          	mv	a1,a5
ffffffe000200ebc:	04813083          	ld	ra,72(sp)
ffffffe000200ec0:	04013403          	ld	s0,64(sp)
ffffffe000200ec4:	03813903          	ld	s2,56(sp)
ffffffe000200ec8:	03013983          	ld	s3,48(sp)
ffffffe000200ecc:	05010113          	addi	sp,sp,80
ffffffe000200ed0:	00008067          	ret

ffffffe000200ed4 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200ed4:	fb010113          	addi	sp,sp,-80
ffffffe000200ed8:	04113423          	sd	ra,72(sp)
ffffffe000200edc:	04813023          	sd	s0,64(sp)
ffffffe000200ee0:	03213c23          	sd	s2,56(sp)
ffffffe000200ee4:	03313823          	sd	s3,48(sp)
ffffffe000200ee8:	05010413          	addi	s0,sp,80
ffffffe000200eec:	fca43423          	sd	a0,-56(s0)
ffffffe000200ef0:	fcb43023          	sd	a1,-64(s0)
ffffffe000200ef4:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200ef8:	00000893          	li	a7,0
ffffffe000200efc:	00000813          	li	a6,0
ffffffe000200f00:	00000793          	li	a5,0
ffffffe000200f04:	fb843703          	ld	a4,-72(s0)
ffffffe000200f08:	fc043683          	ld	a3,-64(s0)
ffffffe000200f0c:	fc843603          	ld	a2,-56(s0)
ffffffe000200f10:	00000593          	li	a1,0
ffffffe000200f14:	44424537          	lui	a0,0x44424
ffffffe000200f18:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200f1c:	c91ff0ef          	jal	ffffffe000200bac <sbi_ecall>
ffffffe000200f20:	00050713          	mv	a4,a0
ffffffe000200f24:	00058793          	mv	a5,a1
ffffffe000200f28:	fce43823          	sd	a4,-48(s0)
ffffffe000200f2c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200f30:	fd043703          	ld	a4,-48(s0)
ffffffe000200f34:	fd843783          	ld	a5,-40(s0)
ffffffe000200f38:	00070913          	mv	s2,a4
ffffffe000200f3c:	00078993          	mv	s3,a5
ffffffe000200f40:	00090713          	mv	a4,s2
ffffffe000200f44:	00098793          	mv	a5,s3
ffffffe000200f48:	00070513          	mv	a0,a4
ffffffe000200f4c:	00078593          	mv	a1,a5
ffffffe000200f50:	04813083          	ld	ra,72(sp)
ffffffe000200f54:	04013403          	ld	s0,64(sp)
ffffffe000200f58:	03813903          	ld	s2,56(sp)
ffffffe000200f5c:	03013983          	ld	s3,48(sp)
ffffffe000200f60:	05010113          	addi	sp,sp,80
ffffffe000200f64:	00008067          	ret

ffffffe000200f68 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200f68:	fe010113          	addi	sp,sp,-32
ffffffe000200f6c:	00113c23          	sd	ra,24(sp)
ffffffe000200f70:	00813823          	sd	s0,16(sp)
ffffffe000200f74:	02010413          	addi	s0,sp,32
ffffffe000200f78:	fea43423          	sd	a0,-24(s0)
ffffffe000200f7c:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200f80:	fe843783          	ld	a5,-24(s0)
ffffffe000200f84:	0207d063          	bgez	a5,ffffffe000200fa4 <trap_handler+0x3c>
ffffffe000200f88:	fe843783          	ld	a5,-24(s0)
ffffffe000200f8c:	0ff7f713          	zext.b	a4,a5
ffffffe000200f90:	00500793          	li	a5,5
ffffffe000200f94:	00f71863          	bne	a4,a5,ffffffe000200fa4 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200f98:	ad0ff0ef          	jal	ffffffe000200268 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200f9c:	a05ff0ef          	jal	ffffffe0002009a0 <do_timer>
ffffffe000200fa0:	01c0006f          	j	ffffffe000200fbc <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200fa4:	fe043603          	ld	a2,-32(s0)
ffffffe000200fa8:	fe843583          	ld	a1,-24(s0)
ffffffe000200fac:	00002517          	auipc	a0,0x2
ffffffe000200fb0:	24c50513          	addi	a0,a0,588 # ffffffe0002031f8 <__func__.0+0x10>
ffffffe000200fb4:	3d8010ef          	jal	ffffffe00020238c <printk>
    }
ffffffe000200fb8:	00000013          	nop
ffffffe000200fbc:	00000013          	nop
ffffffe000200fc0:	01813083          	ld	ra,24(sp)
ffffffe000200fc4:	01013403          	ld	s0,16(sp)
ffffffe000200fc8:	02010113          	addi	sp,sp,32
ffffffe000200fcc:	00008067          	ret

ffffffe000200fd0 <setup_vm>:
                     | OpenSBI | Kernel |                                | OpenSBI | Kernel |
-----------------------------------------------------------------------------------------------
                     ↑                                                   ↑
                0x80000000                                       0xffffffe000000000
*/
void setup_vm() {
ffffffe000200fd0:	fe010113          	addi	sp,sp,-32
ffffffe000200fd4:	00113c23          	sd	ra,24(sp)
ffffffe000200fd8:	00813823          	sd	s0,16(sp)
ffffffe000200fdc:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200fe0:	00001637          	lui	a2,0x1
ffffffe000200fe4:	00000593          	li	a1,0
ffffffe000200fe8:	00006517          	auipc	a0,0x6
ffffffe000200fec:	01850513          	addi	a0,a0,24 # ffffffe000207000 <early_pgtbl>
ffffffe000200ff0:	4cc010ef          	jal	ffffffe0002024bc <memset>

    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff; // 9-bit index
ffffffe000200ff4:	00200793          	li	a5,2
ffffffe000200ff8:	fef43423          	sd	a5,-24(s0)
    // early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN还是4KiB页
    // early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;   // 9-bit index
ffffffe000200ffc:	18000793          	li	a5,384
ffffffe000201000:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN
ffffffe000201004:	00006717          	auipc	a4,0x6
ffffffe000201008:	ffc70713          	addi	a4,a4,-4 # ffffffe000207000 <early_pgtbl>
ffffffe00020100c:	fe843783          	ld	a5,-24(s0)
ffffffe000201010:	00379793          	slli	a5,a5,0x3
ffffffe000201014:	00f707b3          	add	a5,a4,a5
ffffffe000201018:	20000737          	lui	a4,0x20000
ffffffe00020101c:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X
ffffffe000201020:	00006717          	auipc	a4,0x6
ffffffe000201024:	fe070713          	addi	a4,a4,-32 # ffffffe000207000 <early_pgtbl>
ffffffe000201028:	fe843783          	ld	a5,-24(s0)
ffffffe00020102c:	00379793          	slli	a5,a5,0x3
ffffffe000201030:	00f707b3          	add	a5,a4,a5
ffffffe000201034:	0007b783          	ld	a5,0(a5)
ffffffe000201038:	00f7e713          	ori	a4,a5,15
ffffffe00020103c:	00006697          	auipc	a3,0x6
ffffffe000201040:	fc468693          	addi	a3,a3,-60 # ffffffe000207000 <early_pgtbl>
ffffffe000201044:	fe843783          	ld	a5,-24(s0)
ffffffe000201048:	00379793          	slli	a5,a5,0x3
ffffffe00020104c:	00f687b3          	add	a5,a3,a5
ffffffe000201050:	00e7b023          	sd	a4,0(a5)

    printk("...setup_vm done!\n");
ffffffe000201054:	00002517          	auipc	a0,0x2
ffffffe000201058:	1e450513          	addi	a0,a0,484 # ffffffe000203238 <__func__.0+0x50>
ffffffe00020105c:	330010ef          	jal	ffffffe00020238c <printk>
}
ffffffe000201060:	00000013          	nop
ffffffe000201064:	01813083          	ld	ra,24(sp)
ffffffe000201068:	01013403          	ld	s0,16(sp)
ffffffe00020106c:	02010113          	addi	sp,sp,32
ffffffe000201070:	00008067          	ret

ffffffe000201074 <setup_vm_final>:

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
ffffffe000201074:	fe010113          	addi	sp,sp,-32
ffffffe000201078:	00113c23          	sd	ra,24(sp)
ffffffe00020107c:	00813823          	sd	s0,16(sp)
ffffffe000201080:	02010413          	addi	s0,sp,32
    memset(swapper_pg_dir, 0x0, PGSIZE);
ffffffe000201084:	00001637          	lui	a2,0x1
ffffffe000201088:	00000593          	li	a1,0
ffffffe00020108c:	00007517          	auipc	a0,0x7
ffffffe000201090:	f7450513          	addi	a0,a0,-140 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201094:	428010ef          	jal	ffffffe0002024bc <memset>

    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);
ffffffe000201098:	fffff597          	auipc	a1,0xfffff
ffffffe00020109c:	f6858593          	addi	a1,a1,-152 # ffffffe000200000 <_skernel>
ffffffe0002010a0:	fffff717          	auipc	a4,0xfffff
ffffffe0002010a4:	f6070713          	addi	a4,a4,-160 # ffffffe000200000 <_skernel>
ffffffe0002010a8:	04100793          	li	a5,65
ffffffe0002010ac:	01f79793          	slli	a5,a5,0x1f
ffffffe0002010b0:	00f70633          	add	a2,a4,a5
ffffffe0002010b4:	00001717          	auipc	a4,0x1
ffffffe0002010b8:	48070713          	addi	a4,a4,1152 # ffffffe000202534 <_etext>
ffffffe0002010bc:	fffff797          	auipc	a5,0xfffff
ffffffe0002010c0:	f4478793          	addi	a5,a5,-188 # ffffffe000200000 <_skernel>
ffffffe0002010c4:	40f707b3          	sub	a5,a4,a5
ffffffe0002010c8:	00b00713          	li	a4,11
ffffffe0002010cc:	00078693          	mv	a3,a5
ffffffe0002010d0:	00007517          	auipc	a0,0x7
ffffffe0002010d4:	f3050513          	addi	a0,a0,-208 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002010d8:	0f0000ef          	jal	ffffffe0002011c8 <create_mapping>

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);
ffffffe0002010dc:	00002597          	auipc	a1,0x2
ffffffe0002010e0:	f2458593          	addi	a1,a1,-220 # ffffffe000203000 <_srodata>
ffffffe0002010e4:	00002717          	auipc	a4,0x2
ffffffe0002010e8:	f1c70713          	addi	a4,a4,-228 # ffffffe000203000 <_srodata>
ffffffe0002010ec:	04100793          	li	a5,65
ffffffe0002010f0:	01f79793          	slli	a5,a5,0x1f
ffffffe0002010f4:	00f70633          	add	a2,a4,a5
ffffffe0002010f8:	00002717          	auipc	a4,0x2
ffffffe0002010fc:	2a070713          	addi	a4,a4,672 # ffffffe000203398 <_erodata>
ffffffe000201100:	00002797          	auipc	a5,0x2
ffffffe000201104:	f0078793          	addi	a5,a5,-256 # ffffffe000203000 <_srodata>
ffffffe000201108:	40f707b3          	sub	a5,a4,a5
ffffffe00020110c:	00300713          	li	a4,3
ffffffe000201110:	00078693          	mv	a3,a5
ffffffe000201114:	00007517          	auipc	a0,0x7
ffffffe000201118:	eec50513          	addi	a0,a0,-276 # ffffffe000208000 <swapper_pg_dir>
ffffffe00020111c:	0ac000ef          	jal	ffffffe0002011c8 <create_mapping>

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_sdata, (uint64_t)_sdata - PA2VA_OFFSET, VM_END -(uint64_t)_sdata, 0b0111);
ffffffe000201120:	00003597          	auipc	a1,0x3
ffffffe000201124:	ee058593          	addi	a1,a1,-288 # ffffffe000204000 <TIMECLOCK>
ffffffe000201128:	00003717          	auipc	a4,0x3
ffffffe00020112c:	ed870713          	addi	a4,a4,-296 # ffffffe000204000 <TIMECLOCK>
ffffffe000201130:	04100793          	li	a5,65
ffffffe000201134:	01f79793          	slli	a5,a5,0x1f
ffffffe000201138:	00f70633          	add	a2,a4,a5
ffffffe00020113c:	00003797          	auipc	a5,0x3
ffffffe000201140:	ec478793          	addi	a5,a5,-316 # ffffffe000204000 <TIMECLOCK>
ffffffe000201144:	c0100713          	li	a4,-1023
ffffffe000201148:	01b71713          	slli	a4,a4,0x1b
ffffffe00020114c:	40f707b3          	sub	a5,a4,a5
ffffffe000201150:	00700713          	li	a4,7
ffffffe000201154:	00078693          	mv	a3,a5
ffffffe000201158:	00007517          	auipc	a0,0x7
ffffffe00020115c:	ea850513          	addi	a0,a0,-344 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201160:	068000ef          	jal	ffffffe0002011c8 <create_mapping>

    printk("...create_mapping done!\n");
ffffffe000201164:	00002517          	auipc	a0,0x2
ffffffe000201168:	0ec50513          	addi	a0,a0,236 # ffffffe000203250 <__func__.0+0x68>
ffffffe00020116c:	220010ef          	jal	ffffffe00020238c <printk>
    // set satp with swapper_pg_dir
    csr_write(satp, ((uint64_t)swapper_pg_dir - PA2VA_OFFSET) >> 12 | (8llu << 60));
ffffffe000201170:	00007717          	auipc	a4,0x7
ffffffe000201174:	e9070713          	addi	a4,a4,-368 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201178:	04100793          	li	a5,65
ffffffe00020117c:	01f79793          	slli	a5,a5,0x1f
ffffffe000201180:	00f707b3          	add	a5,a4,a5
ffffffe000201184:	00c7d713          	srli	a4,a5,0xc
ffffffe000201188:	fff00793          	li	a5,-1
ffffffe00020118c:	03f79793          	slli	a5,a5,0x3f
ffffffe000201190:	00f767b3          	or	a5,a4,a5
ffffffe000201194:	fef43423          	sd	a5,-24(s0)
ffffffe000201198:	fe843783          	ld	a5,-24(s0)
ffffffe00020119c:	18079073          	csrw	satp,a5

    // flush TLB
    asm volatile("sfence.vma zero, zero");
ffffffe0002011a0:	12000073          	sfence.vma

    // flush icache
    asm volatile("fence.i");
ffffffe0002011a4:	0000100f          	fence.i

    printk("...setup_vm_final done!\n");
ffffffe0002011a8:	00002517          	auipc	a0,0x2
ffffffe0002011ac:	0c850513          	addi	a0,a0,200 # ffffffe000203270 <__func__.0+0x88>
ffffffe0002011b0:	1dc010ef          	jal	ffffffe00020238c <printk>
    return;
ffffffe0002011b4:	00000013          	nop
}
ffffffe0002011b8:	01813083          	ld	ra,24(sp)
ffffffe0002011bc:	01013403          	ld	s0,16(sp)
ffffffe0002011c0:	02010113          	addi	sp,sp,32
ffffffe0002011c4:	00008067          	ret

ffffffe0002011c8 <create_mapping>:
     │                               │                     │                 │
 ┌───┴────┐                          │                   0 │                 │
 │  satp  │                          └────────────────────►└─────────────────┘
 └────────┘
*/
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
ffffffe0002011c8:	f8010113          	addi	sp,sp,-128
ffffffe0002011cc:	06113c23          	sd	ra,120(sp)
ffffffe0002011d0:	06813823          	sd	s0,112(sp)
ffffffe0002011d4:	08010413          	addi	s0,sp,128
ffffffe0002011d8:	faa43423          	sd	a0,-88(s0)
ffffffe0002011dc:	fab43023          	sd	a1,-96(s0)
ffffffe0002011e0:	f8c43c23          	sd	a2,-104(s0)
ffffffe0002011e4:	f8d43823          	sd	a3,-112(s0)
ffffffe0002011e8:	f8e43423          	sd	a4,-120(s0)
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe0002011ec:	fe043423          	sd	zero,-24(s0)
ffffffe0002011f0:	1a00006f          	j	ffffffe000201390 <create_mapping+0x1c8>
        // 分别获取三级索引 index2, index1, index0
        uint64_t va_s = va + i;
ffffffe0002011f4:	fa043703          	ld	a4,-96(s0)
ffffffe0002011f8:	fe843783          	ld	a5,-24(s0)
ffffffe0002011fc:	00f707b3          	add	a5,a4,a5
ffffffe000201200:	fef43023          	sd	a5,-32(s0)
        uint64_t index2 = (va_s >> 30) & 0x1ff;
ffffffe000201204:	fe043783          	ld	a5,-32(s0)
ffffffe000201208:	01e7d793          	srli	a5,a5,0x1e
ffffffe00020120c:	1ff7f793          	andi	a5,a5,511
ffffffe000201210:	fcf43c23          	sd	a5,-40(s0)
        uint64_t index1 = (va_s >> 21) & 0x1ff;
ffffffe000201214:	fe043783          	ld	a5,-32(s0)
ffffffe000201218:	0157d793          	srli	a5,a5,0x15
ffffffe00020121c:	1ff7f793          	andi	a5,a5,511
ffffffe000201220:	fcf43823          	sd	a5,-48(s0)
        uint64_t index0 = (va_s >> 12) & 0x1ff;
ffffffe000201224:	fe043783          	ld	a5,-32(s0)
ffffffe000201228:	00c7d793          	srli	a5,a5,0xc
ffffffe00020122c:	1ff7f793          	andi	a5,a5,511
ffffffe000201230:	fcf43423          	sd	a5,-56(s0)

        // 根页表
        if(!(pgtbl[index2] & 1)) {  // 根据 V bit 判断页表项是否存在
ffffffe000201234:	fd843783          	ld	a5,-40(s0)
ffffffe000201238:	00379793          	slli	a5,a5,0x3
ffffffe00020123c:	fa843703          	ld	a4,-88(s0)
ffffffe000201240:	00f707b3          	add	a5,a4,a5
ffffffe000201244:	0007b783          	ld	a5,0(a5)
ffffffe000201248:	0017f793          	andi	a5,a5,1
ffffffe00020124c:	02079e63          	bnez	a5,ffffffe000201288 <create_mapping+0xc0>
            // 先减去 PA2VA_OFFSET转换为物理地址，然后右移12位转换为PPN ，最后左移10位或上权限为转换为页表项
            pgtbl[index2] = ((uint64_t)kalloc() - PA2VA_OFFSET >> 12 << 10) | 1;
ffffffe000201250:	860ff0ef          	jal	ffffffe0002002b0 <kalloc>
ffffffe000201254:	00050793          	mv	a5,a0
ffffffe000201258:	00078713          	mv	a4,a5
ffffffe00020125c:	04100793          	li	a5,65
ffffffe000201260:	01f79793          	slli	a5,a5,0x1f
ffffffe000201264:	00f707b3          	add	a5,a4,a5
ffffffe000201268:	00c7d793          	srli	a5,a5,0xc
ffffffe00020126c:	00a79713          	slli	a4,a5,0xa
ffffffe000201270:	fd843783          	ld	a5,-40(s0)
ffffffe000201274:	00379793          	slli	a5,a5,0x3
ffffffe000201278:	fa843683          	ld	a3,-88(s0)
ffffffe00020127c:	00f687b3          	add	a5,a3,a5
ffffffe000201280:	00176713          	ori	a4,a4,1
ffffffe000201284:	00e7b023          	sd	a4,0(a5)
        }

        // 二级页表
        uint64_t *pgtbl1 = (uint64_t *)((pgtbl[index2] >> 10 << 12) + PA2VA_OFFSET);
ffffffe000201288:	fd843783          	ld	a5,-40(s0)
ffffffe00020128c:	00379793          	slli	a5,a5,0x3
ffffffe000201290:	fa843703          	ld	a4,-88(s0)
ffffffe000201294:	00f707b3          	add	a5,a4,a5
ffffffe000201298:	0007b783          	ld	a5,0(a5)
ffffffe00020129c:	00a7d793          	srli	a5,a5,0xa
ffffffe0002012a0:	00c79713          	slli	a4,a5,0xc
ffffffe0002012a4:	fbf00793          	li	a5,-65
ffffffe0002012a8:	01f79793          	slli	a5,a5,0x1f
ffffffe0002012ac:	00f707b3          	add	a5,a4,a5
ffffffe0002012b0:	fcf43023          	sd	a5,-64(s0)
        if(!(pgtbl1[index1] & 1)) {
ffffffe0002012b4:	fd043783          	ld	a5,-48(s0)
ffffffe0002012b8:	00379793          	slli	a5,a5,0x3
ffffffe0002012bc:	fc043703          	ld	a4,-64(s0)
ffffffe0002012c0:	00f707b3          	add	a5,a4,a5
ffffffe0002012c4:	0007b783          	ld	a5,0(a5)
ffffffe0002012c8:	0017f793          	andi	a5,a5,1
ffffffe0002012cc:	02079e63          	bnez	a5,ffffffe000201308 <create_mapping+0x140>
            pgtbl1[index1] = ((uint64_t)kalloc() - PA2VA_OFFSET>> 12 << 10) | 1;
ffffffe0002012d0:	fe1fe0ef          	jal	ffffffe0002002b0 <kalloc>
ffffffe0002012d4:	00050793          	mv	a5,a0
ffffffe0002012d8:	00078713          	mv	a4,a5
ffffffe0002012dc:	04100793          	li	a5,65
ffffffe0002012e0:	01f79793          	slli	a5,a5,0x1f
ffffffe0002012e4:	00f707b3          	add	a5,a4,a5
ffffffe0002012e8:	00c7d793          	srli	a5,a5,0xc
ffffffe0002012ec:	00a79713          	slli	a4,a5,0xa
ffffffe0002012f0:	fd043783          	ld	a5,-48(s0)
ffffffe0002012f4:	00379793          	slli	a5,a5,0x3
ffffffe0002012f8:	fc043683          	ld	a3,-64(s0)
ffffffe0002012fc:	00f687b3          	add	a5,a3,a5
ffffffe000201300:	00176713          	ori	a4,a4,1
ffffffe000201304:	00e7b023          	sd	a4,0(a5)
        }

        // 叶子页表
        uint64_t *pgtbl0 = (uint64_t *)((pgtbl1[index1] >> 10 << 12) + PA2VA_OFFSET);
ffffffe000201308:	fd043783          	ld	a5,-48(s0)
ffffffe00020130c:	00379793          	slli	a5,a5,0x3
ffffffe000201310:	fc043703          	ld	a4,-64(s0)
ffffffe000201314:	00f707b3          	add	a5,a4,a5
ffffffe000201318:	0007b783          	ld	a5,0(a5)
ffffffe00020131c:	00a7d793          	srli	a5,a5,0xa
ffffffe000201320:	00c79713          	slli	a4,a5,0xc
ffffffe000201324:	fbf00793          	li	a5,-65
ffffffe000201328:	01f79793          	slli	a5,a5,0x1f
ffffffe00020132c:	00f707b3          	add	a5,a4,a5
ffffffe000201330:	faf43c23          	sd	a5,-72(s0)
        if(!(pgtbl0[index0] & 1)) {
ffffffe000201334:	fc843783          	ld	a5,-56(s0)
ffffffe000201338:	00379793          	slli	a5,a5,0x3
ffffffe00020133c:	fb843703          	ld	a4,-72(s0)
ffffffe000201340:	00f707b3          	add	a5,a4,a5
ffffffe000201344:	0007b783          	ld	a5,0(a5)
ffffffe000201348:	0017f793          	andi	a5,a5,1
ffffffe00020134c:	02079a63          	bnez	a5,ffffffe000201380 <create_mapping+0x1b8>
            // 此时正确设置页表项的 PPN 和权限
            pgtbl0[index0] = ((pa + i >> 12) << 10) | perm;
ffffffe000201350:	f9843703          	ld	a4,-104(s0)
ffffffe000201354:	fe843783          	ld	a5,-24(s0)
ffffffe000201358:	00f707b3          	add	a5,a4,a5
ffffffe00020135c:	00c7d793          	srli	a5,a5,0xc
ffffffe000201360:	00a79693          	slli	a3,a5,0xa
ffffffe000201364:	fc843783          	ld	a5,-56(s0)
ffffffe000201368:	00379793          	slli	a5,a5,0x3
ffffffe00020136c:	fb843703          	ld	a4,-72(s0)
ffffffe000201370:	00f707b3          	add	a5,a4,a5
ffffffe000201374:	f8843703          	ld	a4,-120(s0)
ffffffe000201378:	00e6e733          	or	a4,a3,a4
ffffffe00020137c:	00e7b023          	sd	a4,0(a5)
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe000201380:	fe843703          	ld	a4,-24(s0)
ffffffe000201384:	000017b7          	lui	a5,0x1
ffffffe000201388:	00f707b3          	add	a5,a4,a5
ffffffe00020138c:	fef43423          	sd	a5,-24(s0)
ffffffe000201390:	fe843703          	ld	a4,-24(s0)
ffffffe000201394:	f9043783          	ld	a5,-112(s0)
ffffffe000201398:	e4f76ee3          	bltu	a4,a5,ffffffe0002011f4 <create_mapping+0x2c>
        }
    }
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
ffffffe00020139c:	f8843883          	ld	a7,-120(s0)
ffffffe0002013a0:	f9043803          	ld	a6,-112(s0)
ffffffe0002013a4:	f9843783          	ld	a5,-104(s0)
ffffffe0002013a8:	fa043703          	ld	a4,-96(s0)
ffffffe0002013ac:	00002697          	auipc	a3,0x2
ffffffe0002013b0:	f4468693          	addi	a3,a3,-188 # ffffffe0002032f0 <__func__.0>
ffffffe0002013b4:	0b700613          	li	a2,183
ffffffe0002013b8:	00002597          	auipc	a1,0x2
ffffffe0002013bc:	ed858593          	addi	a1,a1,-296 # ffffffe000203290 <__func__.0+0xa8>
ffffffe0002013c0:	00002517          	auipc	a0,0x2
ffffffe0002013c4:	ed850513          	addi	a0,a0,-296 # ffffffe000203298 <__func__.0+0xb0>
ffffffe0002013c8:	7c5000ef          	jal	ffffffe00020238c <printk>
ffffffe0002013cc:	00000013          	nop
ffffffe0002013d0:	07813083          	ld	ra,120(sp)
ffffffe0002013d4:	07013403          	ld	s0,112(sp)
ffffffe0002013d8:	08010113          	addi	sp,sp,128
ffffffe0002013dc:	00008067          	ret

ffffffe0002013e0 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe0002013e0:	ff010113          	addi	sp,sp,-16
ffffffe0002013e4:	00113423          	sd	ra,8(sp)
ffffffe0002013e8:	00813023          	sd	s0,0(sp)
ffffffe0002013ec:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe0002013f0:	00002517          	auipc	a0,0x2
ffffffe0002013f4:	f1050513          	addi	a0,a0,-240 # ffffffe000203300 <__func__.0+0x10>
ffffffe0002013f8:	795000ef          	jal	ffffffe00020238c <printk>
    printk(" ZJU Operating System\n");
ffffffe0002013fc:	00002517          	auipc	a0,0x2
ffffffe000201400:	f0c50513          	addi	a0,a0,-244 # ffffffe000203308 <__func__.0+0x18>
ffffffe000201404:	789000ef          	jal	ffffffe00020238c <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe000201408:	0b0000ef          	jal	ffffffe0002014b8 <run_idle>
    return 0;
ffffffe00020140c:	00000793          	li	a5,0
}
ffffffe000201410:	00078513          	mv	a0,a5
ffffffe000201414:	00813083          	ld	ra,8(sp)
ffffffe000201418:	00013403          	ld	s0,0(sp)
ffffffe00020141c:	01010113          	addi	sp,sp,16
ffffffe000201420:	00008067          	ret

ffffffe000201424 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe000201424:	ff010113          	addi	sp,sp,-16
ffffffe000201428:	00113423          	sd	ra,8(sp)
ffffffe00020142c:	00813023          	sd	s0,0(sp)
ffffffe000201430:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe000201434:	00000593          	li	a1,0
ffffffe000201438:	00000513          	li	a0,0
ffffffe00020143c:	8ddff0ef          	jal	ffffffe000200d18 <sbi_system_reset>

ffffffe000201440 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe000201440:	fe010113          	addi	sp,sp,-32
ffffffe000201444:	00113c23          	sd	ra,24(sp)
ffffffe000201448:	00813823          	sd	s0,16(sp)
ffffffe00020144c:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe000201450:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe000201454:	fec42783          	lw	a5,-20(s0)
ffffffe000201458:	0017879b          	addiw	a5,a5,1 # 1001 <PGSIZE+0x1>
ffffffe00020145c:	fef42623          	sw	a5,-20(s0)
ffffffe000201460:	fec42783          	lw	a5,-20(s0)
ffffffe000201464:	0007869b          	sext.w	a3,a5
ffffffe000201468:	55e64737          	lui	a4,0x55e64
ffffffe00020146c:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <PHY_SIZE+0x4de63b89>
ffffffe000201470:	02e68733          	mul	a4,a3,a4
ffffffe000201474:	02075713          	srli	a4,a4,0x20
ffffffe000201478:	4197571b          	sraiw	a4,a4,0x19
ffffffe00020147c:	00070693          	mv	a3,a4
ffffffe000201480:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffe000201484:	40e6873b          	subw	a4,a3,a4
ffffffe000201488:	00070693          	mv	a3,a4
ffffffe00020148c:	05f5e737          	lui	a4,0x5f5e
ffffffe000201490:	1007071b          	addiw	a4,a4,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe000201494:	02e6873b          	mulw	a4,a3,a4
ffffffe000201498:	40e787bb          	subw	a5,a5,a4
ffffffe00020149c:	0007879b          	sext.w	a5,a5
ffffffe0002014a0:	fa079ae3          	bnez	a5,ffffffe000201454 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe0002014a4:	00002517          	auipc	a0,0x2
ffffffe0002014a8:	e7c50513          	addi	a0,a0,-388 # ffffffe000203320 <__func__.0+0x30>
ffffffe0002014ac:	6e1000ef          	jal	ffffffe00020238c <printk>
            i = 0;
ffffffe0002014b0:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe0002014b4:	fa1ff06f          	j	ffffffe000201454 <test+0x14>

ffffffe0002014b8 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe0002014b8:	ff010113          	addi	sp,sp,-16
ffffffe0002014bc:	00113423          	sd	ra,8(sp)
ffffffe0002014c0:	00813023          	sd	s0,0(sp)
ffffffe0002014c4:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe0002014c8:	0000006f          	j	ffffffe0002014c8 <run_idle+0x10>

ffffffe0002014cc <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe0002014cc:	fe010113          	addi	sp,sp,-32
ffffffe0002014d0:	00113c23          	sd	ra,24(sp)
ffffffe0002014d4:	00813823          	sd	s0,16(sp)
ffffffe0002014d8:	02010413          	addi	s0,sp,32
ffffffe0002014dc:	00050793          	mv	a5,a0
ffffffe0002014e0:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe0002014e4:	fec42783          	lw	a5,-20(s0)
ffffffe0002014e8:	0ff7f793          	zext.b	a5,a5
ffffffe0002014ec:	00078513          	mv	a0,a5
ffffffe0002014f0:	f98ff0ef          	jal	ffffffe000200c88 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe0002014f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002014f8:	0ff7f793          	zext.b	a5,a5
ffffffe0002014fc:	0007879b          	sext.w	a5,a5
}
ffffffe000201500:	00078513          	mv	a0,a5
ffffffe000201504:	01813083          	ld	ra,24(sp)
ffffffe000201508:	01013403          	ld	s0,16(sp)
ffffffe00020150c:	02010113          	addi	sp,sp,32
ffffffe000201510:	00008067          	ret

ffffffe000201514 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe000201514:	fe010113          	addi	sp,sp,-32
ffffffe000201518:	00113c23          	sd	ra,24(sp)
ffffffe00020151c:	00813823          	sd	s0,16(sp)
ffffffe000201520:	02010413          	addi	s0,sp,32
ffffffe000201524:	00050793          	mv	a5,a0
ffffffe000201528:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe00020152c:	fec42783          	lw	a5,-20(s0)
ffffffe000201530:	0007871b          	sext.w	a4,a5
ffffffe000201534:	02000793          	li	a5,32
ffffffe000201538:	02f70263          	beq	a4,a5,ffffffe00020155c <isspace+0x48>
ffffffe00020153c:	fec42783          	lw	a5,-20(s0)
ffffffe000201540:	0007871b          	sext.w	a4,a5
ffffffe000201544:	00800793          	li	a5,8
ffffffe000201548:	00e7de63          	bge	a5,a4,ffffffe000201564 <isspace+0x50>
ffffffe00020154c:	fec42783          	lw	a5,-20(s0)
ffffffe000201550:	0007871b          	sext.w	a4,a5
ffffffe000201554:	00d00793          	li	a5,13
ffffffe000201558:	00e7c663          	blt	a5,a4,ffffffe000201564 <isspace+0x50>
ffffffe00020155c:	00100793          	li	a5,1
ffffffe000201560:	0080006f          	j	ffffffe000201568 <isspace+0x54>
ffffffe000201564:	00000793          	li	a5,0
}
ffffffe000201568:	00078513          	mv	a0,a5
ffffffe00020156c:	01813083          	ld	ra,24(sp)
ffffffe000201570:	01013403          	ld	s0,16(sp)
ffffffe000201574:	02010113          	addi	sp,sp,32
ffffffe000201578:	00008067          	ret

ffffffe00020157c <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe00020157c:	fb010113          	addi	sp,sp,-80
ffffffe000201580:	04113423          	sd	ra,72(sp)
ffffffe000201584:	04813023          	sd	s0,64(sp)
ffffffe000201588:	05010413          	addi	s0,sp,80
ffffffe00020158c:	fca43423          	sd	a0,-56(s0)
ffffffe000201590:	fcb43023          	sd	a1,-64(s0)
ffffffe000201594:	00060793          	mv	a5,a2
ffffffe000201598:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe00020159c:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe0002015a0:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe0002015a4:	fc843783          	ld	a5,-56(s0)
ffffffe0002015a8:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe0002015ac:	0100006f          	j	ffffffe0002015bc <strtol+0x40>
        p++;
ffffffe0002015b0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015b4:	00178793          	addi	a5,a5,1
ffffffe0002015b8:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe0002015bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002015c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002015c4:	0007879b          	sext.w	a5,a5
ffffffe0002015c8:	00078513          	mv	a0,a5
ffffffe0002015cc:	f49ff0ef          	jal	ffffffe000201514 <isspace>
ffffffe0002015d0:	00050793          	mv	a5,a0
ffffffe0002015d4:	fc079ee3          	bnez	a5,ffffffe0002015b0 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe0002015d8:	fd843783          	ld	a5,-40(s0)
ffffffe0002015dc:	0007c783          	lbu	a5,0(a5)
ffffffe0002015e0:	00078713          	mv	a4,a5
ffffffe0002015e4:	02d00793          	li	a5,45
ffffffe0002015e8:	00f71e63          	bne	a4,a5,ffffffe000201604 <strtol+0x88>
        neg = true;
ffffffe0002015ec:	00100793          	li	a5,1
ffffffe0002015f0:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe0002015f4:	fd843783          	ld	a5,-40(s0)
ffffffe0002015f8:	00178793          	addi	a5,a5,1
ffffffe0002015fc:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201600:	0240006f          	j	ffffffe000201624 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe000201604:	fd843783          	ld	a5,-40(s0)
ffffffe000201608:	0007c783          	lbu	a5,0(a5)
ffffffe00020160c:	00078713          	mv	a4,a5
ffffffe000201610:	02b00793          	li	a5,43
ffffffe000201614:	00f71863          	bne	a4,a5,ffffffe000201624 <strtol+0xa8>
        p++;
ffffffe000201618:	fd843783          	ld	a5,-40(s0)
ffffffe00020161c:	00178793          	addi	a5,a5,1
ffffffe000201620:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe000201624:	fbc42783          	lw	a5,-68(s0)
ffffffe000201628:	0007879b          	sext.w	a5,a5
ffffffe00020162c:	06079c63          	bnez	a5,ffffffe0002016a4 <strtol+0x128>
        if (*p == '0') {
ffffffe000201630:	fd843783          	ld	a5,-40(s0)
ffffffe000201634:	0007c783          	lbu	a5,0(a5)
ffffffe000201638:	00078713          	mv	a4,a5
ffffffe00020163c:	03000793          	li	a5,48
ffffffe000201640:	04f71e63          	bne	a4,a5,ffffffe00020169c <strtol+0x120>
            p++;
ffffffe000201644:	fd843783          	ld	a5,-40(s0)
ffffffe000201648:	00178793          	addi	a5,a5,1
ffffffe00020164c:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe000201650:	fd843783          	ld	a5,-40(s0)
ffffffe000201654:	0007c783          	lbu	a5,0(a5)
ffffffe000201658:	00078713          	mv	a4,a5
ffffffe00020165c:	07800793          	li	a5,120
ffffffe000201660:	00f70c63          	beq	a4,a5,ffffffe000201678 <strtol+0xfc>
ffffffe000201664:	fd843783          	ld	a5,-40(s0)
ffffffe000201668:	0007c783          	lbu	a5,0(a5)
ffffffe00020166c:	00078713          	mv	a4,a5
ffffffe000201670:	05800793          	li	a5,88
ffffffe000201674:	00f71e63          	bne	a4,a5,ffffffe000201690 <strtol+0x114>
                base = 16;
ffffffe000201678:	01000793          	li	a5,16
ffffffe00020167c:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000201680:	fd843783          	ld	a5,-40(s0)
ffffffe000201684:	00178793          	addi	a5,a5,1
ffffffe000201688:	fcf43c23          	sd	a5,-40(s0)
ffffffe00020168c:	0180006f          	j	ffffffe0002016a4 <strtol+0x128>
            } else {
                base = 8;
ffffffe000201690:	00800793          	li	a5,8
ffffffe000201694:	faf42e23          	sw	a5,-68(s0)
ffffffe000201698:	00c0006f          	j	ffffffe0002016a4 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe00020169c:	00a00793          	li	a5,10
ffffffe0002016a0:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe0002016a4:	fd843783          	ld	a5,-40(s0)
ffffffe0002016a8:	0007c783          	lbu	a5,0(a5)
ffffffe0002016ac:	00078713          	mv	a4,a5
ffffffe0002016b0:	02f00793          	li	a5,47
ffffffe0002016b4:	02e7f863          	bgeu	a5,a4,ffffffe0002016e4 <strtol+0x168>
ffffffe0002016b8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016bc:	0007c783          	lbu	a5,0(a5)
ffffffe0002016c0:	00078713          	mv	a4,a5
ffffffe0002016c4:	03900793          	li	a5,57
ffffffe0002016c8:	00e7ee63          	bltu	a5,a4,ffffffe0002016e4 <strtol+0x168>
            digit = *p - '0';
ffffffe0002016cc:	fd843783          	ld	a5,-40(s0)
ffffffe0002016d0:	0007c783          	lbu	a5,0(a5)
ffffffe0002016d4:	0007879b          	sext.w	a5,a5
ffffffe0002016d8:	fd07879b          	addiw	a5,a5,-48
ffffffe0002016dc:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002016e0:	0800006f          	j	ffffffe000201760 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe0002016e4:	fd843783          	ld	a5,-40(s0)
ffffffe0002016e8:	0007c783          	lbu	a5,0(a5)
ffffffe0002016ec:	00078713          	mv	a4,a5
ffffffe0002016f0:	06000793          	li	a5,96
ffffffe0002016f4:	02e7f863          	bgeu	a5,a4,ffffffe000201724 <strtol+0x1a8>
ffffffe0002016f8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016fc:	0007c783          	lbu	a5,0(a5)
ffffffe000201700:	00078713          	mv	a4,a5
ffffffe000201704:	07a00793          	li	a5,122
ffffffe000201708:	00e7ee63          	bltu	a5,a4,ffffffe000201724 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe00020170c:	fd843783          	ld	a5,-40(s0)
ffffffe000201710:	0007c783          	lbu	a5,0(a5)
ffffffe000201714:	0007879b          	sext.w	a5,a5
ffffffe000201718:	fa97879b          	addiw	a5,a5,-87
ffffffe00020171c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201720:	0400006f          	j	ffffffe000201760 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe000201724:	fd843783          	ld	a5,-40(s0)
ffffffe000201728:	0007c783          	lbu	a5,0(a5)
ffffffe00020172c:	00078713          	mv	a4,a5
ffffffe000201730:	04000793          	li	a5,64
ffffffe000201734:	06e7f863          	bgeu	a5,a4,ffffffe0002017a4 <strtol+0x228>
ffffffe000201738:	fd843783          	ld	a5,-40(s0)
ffffffe00020173c:	0007c783          	lbu	a5,0(a5)
ffffffe000201740:	00078713          	mv	a4,a5
ffffffe000201744:	05a00793          	li	a5,90
ffffffe000201748:	04e7ee63          	bltu	a5,a4,ffffffe0002017a4 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe00020174c:	fd843783          	ld	a5,-40(s0)
ffffffe000201750:	0007c783          	lbu	a5,0(a5)
ffffffe000201754:	0007879b          	sext.w	a5,a5
ffffffe000201758:	fc97879b          	addiw	a5,a5,-55
ffffffe00020175c:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000201760:	fd442783          	lw	a5,-44(s0)
ffffffe000201764:	00078713          	mv	a4,a5
ffffffe000201768:	fbc42783          	lw	a5,-68(s0)
ffffffe00020176c:	0007071b          	sext.w	a4,a4
ffffffe000201770:	0007879b          	sext.w	a5,a5
ffffffe000201774:	02f75663          	bge	a4,a5,ffffffe0002017a0 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe000201778:	fbc42703          	lw	a4,-68(s0)
ffffffe00020177c:	fe843783          	ld	a5,-24(s0)
ffffffe000201780:	02f70733          	mul	a4,a4,a5
ffffffe000201784:	fd442783          	lw	a5,-44(s0)
ffffffe000201788:	00f707b3          	add	a5,a4,a5
ffffffe00020178c:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe000201790:	fd843783          	ld	a5,-40(s0)
ffffffe000201794:	00178793          	addi	a5,a5,1
ffffffe000201798:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe00020179c:	f09ff06f          	j	ffffffe0002016a4 <strtol+0x128>
            break;
ffffffe0002017a0:	00000013          	nop
    }

    if (endptr) {
ffffffe0002017a4:	fc043783          	ld	a5,-64(s0)
ffffffe0002017a8:	00078863          	beqz	a5,ffffffe0002017b8 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe0002017ac:	fc043783          	ld	a5,-64(s0)
ffffffe0002017b0:	fd843703          	ld	a4,-40(s0)
ffffffe0002017b4:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe0002017b8:	fe744783          	lbu	a5,-25(s0)
ffffffe0002017bc:	0ff7f793          	zext.b	a5,a5
ffffffe0002017c0:	00078863          	beqz	a5,ffffffe0002017d0 <strtol+0x254>
ffffffe0002017c4:	fe843783          	ld	a5,-24(s0)
ffffffe0002017c8:	40f007b3          	neg	a5,a5
ffffffe0002017cc:	0080006f          	j	ffffffe0002017d4 <strtol+0x258>
ffffffe0002017d0:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002017d4:	00078513          	mv	a0,a5
ffffffe0002017d8:	04813083          	ld	ra,72(sp)
ffffffe0002017dc:	04013403          	ld	s0,64(sp)
ffffffe0002017e0:	05010113          	addi	sp,sp,80
ffffffe0002017e4:	00008067          	ret

ffffffe0002017e8 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe0002017e8:	fd010113          	addi	sp,sp,-48
ffffffe0002017ec:	02113423          	sd	ra,40(sp)
ffffffe0002017f0:	02813023          	sd	s0,32(sp)
ffffffe0002017f4:	03010413          	addi	s0,sp,48
ffffffe0002017f8:	fca43c23          	sd	a0,-40(s0)
ffffffe0002017fc:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe000201800:	fd043783          	ld	a5,-48(s0)
ffffffe000201804:	00079863          	bnez	a5,ffffffe000201814 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe000201808:	00002797          	auipc	a5,0x2
ffffffe00020180c:	b3078793          	addi	a5,a5,-1232 # ffffffe000203338 <__func__.0+0x48>
ffffffe000201810:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe000201814:	fd043783          	ld	a5,-48(s0)
ffffffe000201818:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe00020181c:	0240006f          	j	ffffffe000201840 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe000201820:	fe843783          	ld	a5,-24(s0)
ffffffe000201824:	00178713          	addi	a4,a5,1
ffffffe000201828:	fee43423          	sd	a4,-24(s0)
ffffffe00020182c:	0007c783          	lbu	a5,0(a5)
ffffffe000201830:	0007871b          	sext.w	a4,a5
ffffffe000201834:	fd843783          	ld	a5,-40(s0)
ffffffe000201838:	00070513          	mv	a0,a4
ffffffe00020183c:	000780e7          	jalr	a5
    while (*p) {
ffffffe000201840:	fe843783          	ld	a5,-24(s0)
ffffffe000201844:	0007c783          	lbu	a5,0(a5)
ffffffe000201848:	fc079ce3          	bnez	a5,ffffffe000201820 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe00020184c:	fe843703          	ld	a4,-24(s0)
ffffffe000201850:	fd043783          	ld	a5,-48(s0)
ffffffe000201854:	40f707b3          	sub	a5,a4,a5
ffffffe000201858:	0007879b          	sext.w	a5,a5
}
ffffffe00020185c:	00078513          	mv	a0,a5
ffffffe000201860:	02813083          	ld	ra,40(sp)
ffffffe000201864:	02013403          	ld	s0,32(sp)
ffffffe000201868:	03010113          	addi	sp,sp,48
ffffffe00020186c:	00008067          	ret

ffffffe000201870 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000201870:	f9010113          	addi	sp,sp,-112
ffffffe000201874:	06113423          	sd	ra,104(sp)
ffffffe000201878:	06813023          	sd	s0,96(sp)
ffffffe00020187c:	07010413          	addi	s0,sp,112
ffffffe000201880:	faa43423          	sd	a0,-88(s0)
ffffffe000201884:	fab43023          	sd	a1,-96(s0)
ffffffe000201888:	00060793          	mv	a5,a2
ffffffe00020188c:	f8d43823          	sd	a3,-112(s0)
ffffffe000201890:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe000201894:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201898:	0ff7f793          	zext.b	a5,a5
ffffffe00020189c:	02078663          	beqz	a5,ffffffe0002018c8 <print_dec_int+0x58>
ffffffe0002018a0:	fa043703          	ld	a4,-96(s0)
ffffffe0002018a4:	fff00793          	li	a5,-1
ffffffe0002018a8:	03f79793          	slli	a5,a5,0x3f
ffffffe0002018ac:	00f71e63          	bne	a4,a5,ffffffe0002018c8 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe0002018b0:	00002597          	auipc	a1,0x2
ffffffe0002018b4:	a9058593          	addi	a1,a1,-1392 # ffffffe000203340 <__func__.0+0x50>
ffffffe0002018b8:	fa843503          	ld	a0,-88(s0)
ffffffe0002018bc:	f2dff0ef          	jal	ffffffe0002017e8 <puts_wo_nl>
ffffffe0002018c0:	00050793          	mv	a5,a0
ffffffe0002018c4:	2c80006f          	j	ffffffe000201b8c <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe0002018c8:	f9043783          	ld	a5,-112(s0)
ffffffe0002018cc:	00c7a783          	lw	a5,12(a5)
ffffffe0002018d0:	00079a63          	bnez	a5,ffffffe0002018e4 <print_dec_int+0x74>
ffffffe0002018d4:	fa043783          	ld	a5,-96(s0)
ffffffe0002018d8:	00079663          	bnez	a5,ffffffe0002018e4 <print_dec_int+0x74>
        return 0;
ffffffe0002018dc:	00000793          	li	a5,0
ffffffe0002018e0:	2ac0006f          	j	ffffffe000201b8c <print_dec_int+0x31c>
    }

    bool neg = false;
ffffffe0002018e4:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe0002018e8:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002018ec:	0ff7f793          	zext.b	a5,a5
ffffffe0002018f0:	02078063          	beqz	a5,ffffffe000201910 <print_dec_int+0xa0>
ffffffe0002018f4:	fa043783          	ld	a5,-96(s0)
ffffffe0002018f8:	0007dc63          	bgez	a5,ffffffe000201910 <print_dec_int+0xa0>
        neg = true;
ffffffe0002018fc:	00100793          	li	a5,1
ffffffe000201900:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe000201904:	fa043783          	ld	a5,-96(s0)
ffffffe000201908:	40f007b3          	neg	a5,a5
ffffffe00020190c:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe000201910:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe000201914:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201918:	0ff7f793          	zext.b	a5,a5
ffffffe00020191c:	02078863          	beqz	a5,ffffffe00020194c <print_dec_int+0xdc>
ffffffe000201920:	fef44783          	lbu	a5,-17(s0)
ffffffe000201924:	0ff7f793          	zext.b	a5,a5
ffffffe000201928:	00079e63          	bnez	a5,ffffffe000201944 <print_dec_int+0xd4>
ffffffe00020192c:	f9043783          	ld	a5,-112(s0)
ffffffe000201930:	0057c783          	lbu	a5,5(a5)
ffffffe000201934:	00079863          	bnez	a5,ffffffe000201944 <print_dec_int+0xd4>
ffffffe000201938:	f9043783          	ld	a5,-112(s0)
ffffffe00020193c:	0047c783          	lbu	a5,4(a5)
ffffffe000201940:	00078663          	beqz	a5,ffffffe00020194c <print_dec_int+0xdc>
ffffffe000201944:	00100793          	li	a5,1
ffffffe000201948:	0080006f          	j	ffffffe000201950 <print_dec_int+0xe0>
ffffffe00020194c:	00000793          	li	a5,0
ffffffe000201950:	fcf40ba3          	sb	a5,-41(s0)
ffffffe000201954:	fd744783          	lbu	a5,-41(s0)
ffffffe000201958:	0017f793          	andi	a5,a5,1
ffffffe00020195c:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000201960:	fa043683          	ld	a3,-96(s0)
ffffffe000201964:	00002797          	auipc	a5,0x2
ffffffe000201968:	9f478793          	addi	a5,a5,-1548 # ffffffe000203358 <__func__.0+0x68>
ffffffe00020196c:	0007b783          	ld	a5,0(a5)
ffffffe000201970:	02f6b7b3          	mulhu	a5,a3,a5
ffffffe000201974:	0037d713          	srli	a4,a5,0x3
ffffffe000201978:	00070793          	mv	a5,a4
ffffffe00020197c:	00279793          	slli	a5,a5,0x2
ffffffe000201980:	00e787b3          	add	a5,a5,a4
ffffffe000201984:	00179793          	slli	a5,a5,0x1
ffffffe000201988:	40f68733          	sub	a4,a3,a5
ffffffe00020198c:	0ff77713          	zext.b	a4,a4
ffffffe000201990:	fe842783          	lw	a5,-24(s0)
ffffffe000201994:	0017869b          	addiw	a3,a5,1
ffffffe000201998:	fed42423          	sw	a3,-24(s0)
ffffffe00020199c:	0307071b          	addiw	a4,a4,48
ffffffe0002019a0:	0ff77713          	zext.b	a4,a4
ffffffe0002019a4:	ff078793          	addi	a5,a5,-16
ffffffe0002019a8:	008787b3          	add	a5,a5,s0
ffffffe0002019ac:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe0002019b0:	fa043703          	ld	a4,-96(s0)
ffffffe0002019b4:	00002797          	auipc	a5,0x2
ffffffe0002019b8:	9a478793          	addi	a5,a5,-1628 # ffffffe000203358 <__func__.0+0x68>
ffffffe0002019bc:	0007b783          	ld	a5,0(a5)
ffffffe0002019c0:	02f737b3          	mulhu	a5,a4,a5
ffffffe0002019c4:	0037d793          	srli	a5,a5,0x3
ffffffe0002019c8:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe0002019cc:	fa043783          	ld	a5,-96(s0)
ffffffe0002019d0:	f80798e3          	bnez	a5,ffffffe000201960 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe0002019d4:	f9043783          	ld	a5,-112(s0)
ffffffe0002019d8:	00c7a703          	lw	a4,12(a5)
ffffffe0002019dc:	fff00793          	li	a5,-1
ffffffe0002019e0:	02f71063          	bne	a4,a5,ffffffe000201a00 <print_dec_int+0x190>
ffffffe0002019e4:	f9043783          	ld	a5,-112(s0)
ffffffe0002019e8:	0037c783          	lbu	a5,3(a5)
ffffffe0002019ec:	00078a63          	beqz	a5,ffffffe000201a00 <print_dec_int+0x190>
        flags->prec = flags->width;
ffffffe0002019f0:	f9043783          	ld	a5,-112(s0)
ffffffe0002019f4:	0087a703          	lw	a4,8(a5)
ffffffe0002019f8:	f9043783          	ld	a5,-112(s0)
ffffffe0002019fc:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe000201a00:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a04:	f9043783          	ld	a5,-112(s0)
ffffffe000201a08:	0087a703          	lw	a4,8(a5)
ffffffe000201a0c:	fe842783          	lw	a5,-24(s0)
ffffffe000201a10:	fcf42823          	sw	a5,-48(s0)
ffffffe000201a14:	f9043783          	ld	a5,-112(s0)
ffffffe000201a18:	00c7a783          	lw	a5,12(a5)
ffffffe000201a1c:	fcf42623          	sw	a5,-52(s0)
ffffffe000201a20:	fd042783          	lw	a5,-48(s0)
ffffffe000201a24:	00078593          	mv	a1,a5
ffffffe000201a28:	fcc42783          	lw	a5,-52(s0)
ffffffe000201a2c:	00078613          	mv	a2,a5
ffffffe000201a30:	0006069b          	sext.w	a3,a2
ffffffe000201a34:	0005879b          	sext.w	a5,a1
ffffffe000201a38:	00f6d463          	bge	a3,a5,ffffffe000201a40 <print_dec_int+0x1d0>
ffffffe000201a3c:	00058613          	mv	a2,a1
ffffffe000201a40:	0006079b          	sext.w	a5,a2
ffffffe000201a44:	40f707bb          	subw	a5,a4,a5
ffffffe000201a48:	0007871b          	sext.w	a4,a5
ffffffe000201a4c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201a50:	0007879b          	sext.w	a5,a5
ffffffe000201a54:	40f707bb          	subw	a5,a4,a5
ffffffe000201a58:	fef42023          	sw	a5,-32(s0)
ffffffe000201a5c:	0280006f          	j	ffffffe000201a84 <print_dec_int+0x214>
        putch(' ');
ffffffe000201a60:	fa843783          	ld	a5,-88(s0)
ffffffe000201a64:	02000513          	li	a0,32
ffffffe000201a68:	000780e7          	jalr	a5
        ++written;
ffffffe000201a6c:	fe442783          	lw	a5,-28(s0)
ffffffe000201a70:	0017879b          	addiw	a5,a5,1
ffffffe000201a74:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a78:	fe042783          	lw	a5,-32(s0)
ffffffe000201a7c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201a80:	fef42023          	sw	a5,-32(s0)
ffffffe000201a84:	fe042783          	lw	a5,-32(s0)
ffffffe000201a88:	0007879b          	sext.w	a5,a5
ffffffe000201a8c:	fcf04ae3          	bgtz	a5,ffffffe000201a60 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
ffffffe000201a90:	fd744783          	lbu	a5,-41(s0)
ffffffe000201a94:	0ff7f793          	zext.b	a5,a5
ffffffe000201a98:	04078463          	beqz	a5,ffffffe000201ae0 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe000201a9c:	fef44783          	lbu	a5,-17(s0)
ffffffe000201aa0:	0ff7f793          	zext.b	a5,a5
ffffffe000201aa4:	00078663          	beqz	a5,ffffffe000201ab0 <print_dec_int+0x240>
ffffffe000201aa8:	02d00793          	li	a5,45
ffffffe000201aac:	01c0006f          	j	ffffffe000201ac8 <print_dec_int+0x258>
ffffffe000201ab0:	f9043783          	ld	a5,-112(s0)
ffffffe000201ab4:	0057c783          	lbu	a5,5(a5)
ffffffe000201ab8:	00078663          	beqz	a5,ffffffe000201ac4 <print_dec_int+0x254>
ffffffe000201abc:	02b00793          	li	a5,43
ffffffe000201ac0:	0080006f          	j	ffffffe000201ac8 <print_dec_int+0x258>
ffffffe000201ac4:	02000793          	li	a5,32
ffffffe000201ac8:	fa843703          	ld	a4,-88(s0)
ffffffe000201acc:	00078513          	mv	a0,a5
ffffffe000201ad0:	000700e7          	jalr	a4
        ++written;
ffffffe000201ad4:	fe442783          	lw	a5,-28(s0)
ffffffe000201ad8:	0017879b          	addiw	a5,a5,1
ffffffe000201adc:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201ae0:	fe842783          	lw	a5,-24(s0)
ffffffe000201ae4:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201ae8:	0280006f          	j	ffffffe000201b10 <print_dec_int+0x2a0>
        putch('0');
ffffffe000201aec:	fa843783          	ld	a5,-88(s0)
ffffffe000201af0:	03000513          	li	a0,48
ffffffe000201af4:	000780e7          	jalr	a5
        ++written;
ffffffe000201af8:	fe442783          	lw	a5,-28(s0)
ffffffe000201afc:	0017879b          	addiw	a5,a5,1
ffffffe000201b00:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201b04:	fdc42783          	lw	a5,-36(s0)
ffffffe000201b08:	0017879b          	addiw	a5,a5,1
ffffffe000201b0c:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201b10:	f9043783          	ld	a5,-112(s0)
ffffffe000201b14:	00c7a703          	lw	a4,12(a5)
ffffffe000201b18:	fd744783          	lbu	a5,-41(s0)
ffffffe000201b1c:	0007879b          	sext.w	a5,a5
ffffffe000201b20:	40f707bb          	subw	a5,a4,a5
ffffffe000201b24:	0007879b          	sext.w	a5,a5
ffffffe000201b28:	fdc42703          	lw	a4,-36(s0)
ffffffe000201b2c:	0007071b          	sext.w	a4,a4
ffffffe000201b30:	faf74ee3          	blt	a4,a5,ffffffe000201aec <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b34:	fe842783          	lw	a5,-24(s0)
ffffffe000201b38:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b3c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b40:	03c0006f          	j	ffffffe000201b7c <print_dec_int+0x30c>
        putch(buf[i]);
ffffffe000201b44:	fd842783          	lw	a5,-40(s0)
ffffffe000201b48:	ff078793          	addi	a5,a5,-16
ffffffe000201b4c:	008787b3          	add	a5,a5,s0
ffffffe000201b50:	fc87c783          	lbu	a5,-56(a5)
ffffffe000201b54:	0007871b          	sext.w	a4,a5
ffffffe000201b58:	fa843783          	ld	a5,-88(s0)
ffffffe000201b5c:	00070513          	mv	a0,a4
ffffffe000201b60:	000780e7          	jalr	a5
        ++written;
ffffffe000201b64:	fe442783          	lw	a5,-28(s0)
ffffffe000201b68:	0017879b          	addiw	a5,a5,1
ffffffe000201b6c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b70:	fd842783          	lw	a5,-40(s0)
ffffffe000201b74:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b78:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b7c:	fd842783          	lw	a5,-40(s0)
ffffffe000201b80:	0007879b          	sext.w	a5,a5
ffffffe000201b84:	fc07d0e3          	bgez	a5,ffffffe000201b44 <print_dec_int+0x2d4>
    }

    return written;
ffffffe000201b88:	fe442783          	lw	a5,-28(s0)
}
ffffffe000201b8c:	00078513          	mv	a0,a5
ffffffe000201b90:	06813083          	ld	ra,104(sp)
ffffffe000201b94:	06013403          	ld	s0,96(sp)
ffffffe000201b98:	07010113          	addi	sp,sp,112
ffffffe000201b9c:	00008067          	ret

ffffffe000201ba0 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201ba0:	f4010113          	addi	sp,sp,-192
ffffffe000201ba4:	0a113c23          	sd	ra,184(sp)
ffffffe000201ba8:	0a813823          	sd	s0,176(sp)
ffffffe000201bac:	0c010413          	addi	s0,sp,192
ffffffe000201bb0:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201bb4:	f4b43823          	sd	a1,-176(s0)
ffffffe000201bb8:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe000201bbc:	f8043023          	sd	zero,-128(s0)
ffffffe000201bc0:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201bc4:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201bc8:	7a00006f          	j	ffffffe000202368 <vprintfmt+0x7c8>
        if (flags.in_format) {
ffffffe000201bcc:	f8044783          	lbu	a5,-128(s0)
ffffffe000201bd0:	72078c63          	beqz	a5,ffffffe000202308 <vprintfmt+0x768>
            if (*fmt == '#') {
ffffffe000201bd4:	f5043783          	ld	a5,-176(s0)
ffffffe000201bd8:	0007c783          	lbu	a5,0(a5)
ffffffe000201bdc:	00078713          	mv	a4,a5
ffffffe000201be0:	02300793          	li	a5,35
ffffffe000201be4:	00f71863          	bne	a4,a5,ffffffe000201bf4 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201be8:	00100793          	li	a5,1
ffffffe000201bec:	f8f40123          	sb	a5,-126(s0)
ffffffe000201bf0:	76c0006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
ffffffe000201bf4:	f5043783          	ld	a5,-176(s0)
ffffffe000201bf8:	0007c783          	lbu	a5,0(a5)
ffffffe000201bfc:	00078713          	mv	a4,a5
ffffffe000201c00:	03000793          	li	a5,48
ffffffe000201c04:	00f71863          	bne	a4,a5,ffffffe000201c14 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe000201c08:	00100793          	li	a5,1
ffffffe000201c0c:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201c10:	74c0006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201c14:	f5043783          	ld	a5,-176(s0)
ffffffe000201c18:	0007c783          	lbu	a5,0(a5)
ffffffe000201c1c:	00078713          	mv	a4,a5
ffffffe000201c20:	06c00793          	li	a5,108
ffffffe000201c24:	04f70063          	beq	a4,a5,ffffffe000201c64 <vprintfmt+0xc4>
ffffffe000201c28:	f5043783          	ld	a5,-176(s0)
ffffffe000201c2c:	0007c783          	lbu	a5,0(a5)
ffffffe000201c30:	00078713          	mv	a4,a5
ffffffe000201c34:	07a00793          	li	a5,122
ffffffe000201c38:	02f70663          	beq	a4,a5,ffffffe000201c64 <vprintfmt+0xc4>
ffffffe000201c3c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c40:	0007c783          	lbu	a5,0(a5)
ffffffe000201c44:	00078713          	mv	a4,a5
ffffffe000201c48:	07400793          	li	a5,116
ffffffe000201c4c:	00f70c63          	beq	a4,a5,ffffffe000201c64 <vprintfmt+0xc4>
ffffffe000201c50:	f5043783          	ld	a5,-176(s0)
ffffffe000201c54:	0007c783          	lbu	a5,0(a5)
ffffffe000201c58:	00078713          	mv	a4,a5
ffffffe000201c5c:	06a00793          	li	a5,106
ffffffe000201c60:	00f71863          	bne	a4,a5,ffffffe000201c70 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201c64:	00100793          	li	a5,1
ffffffe000201c68:	f8f400a3          	sb	a5,-127(s0)
ffffffe000201c6c:	6f00006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
ffffffe000201c70:	f5043783          	ld	a5,-176(s0)
ffffffe000201c74:	0007c783          	lbu	a5,0(a5)
ffffffe000201c78:	00078713          	mv	a4,a5
ffffffe000201c7c:	02b00793          	li	a5,43
ffffffe000201c80:	00f71863          	bne	a4,a5,ffffffe000201c90 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201c84:	00100793          	li	a5,1
ffffffe000201c88:	f8f402a3          	sb	a5,-123(s0)
ffffffe000201c8c:	6d00006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
ffffffe000201c90:	f5043783          	ld	a5,-176(s0)
ffffffe000201c94:	0007c783          	lbu	a5,0(a5)
ffffffe000201c98:	00078713          	mv	a4,a5
ffffffe000201c9c:	02000793          	li	a5,32
ffffffe000201ca0:	00f71863          	bne	a4,a5,ffffffe000201cb0 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201ca4:	00100793          	li	a5,1
ffffffe000201ca8:	f8f40223          	sb	a5,-124(s0)
ffffffe000201cac:	6b00006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
ffffffe000201cb0:	f5043783          	ld	a5,-176(s0)
ffffffe000201cb4:	0007c783          	lbu	a5,0(a5)
ffffffe000201cb8:	00078713          	mv	a4,a5
ffffffe000201cbc:	02a00793          	li	a5,42
ffffffe000201cc0:	00f71e63          	bne	a4,a5,ffffffe000201cdc <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201cc4:	f4843783          	ld	a5,-184(s0)
ffffffe000201cc8:	00878713          	addi	a4,a5,8
ffffffe000201ccc:	f4e43423          	sd	a4,-184(s0)
ffffffe000201cd0:	0007a783          	lw	a5,0(a5)
ffffffe000201cd4:	f8f42423          	sw	a5,-120(s0)
ffffffe000201cd8:	6840006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe000201cdc:	f5043783          	ld	a5,-176(s0)
ffffffe000201ce0:	0007c783          	lbu	a5,0(a5)
ffffffe000201ce4:	00078713          	mv	a4,a5
ffffffe000201ce8:	03000793          	li	a5,48
ffffffe000201cec:	04e7f663          	bgeu	a5,a4,ffffffe000201d38 <vprintfmt+0x198>
ffffffe000201cf0:	f5043783          	ld	a5,-176(s0)
ffffffe000201cf4:	0007c783          	lbu	a5,0(a5)
ffffffe000201cf8:	00078713          	mv	a4,a5
ffffffe000201cfc:	03900793          	li	a5,57
ffffffe000201d00:	02e7ec63          	bltu	a5,a4,ffffffe000201d38 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d04:	f5043783          	ld	a5,-176(s0)
ffffffe000201d08:	f5040713          	addi	a4,s0,-176
ffffffe000201d0c:	00a00613          	li	a2,10
ffffffe000201d10:	00070593          	mv	a1,a4
ffffffe000201d14:	00078513          	mv	a0,a5
ffffffe000201d18:	865ff0ef          	jal	ffffffe00020157c <strtol>
ffffffe000201d1c:	00050793          	mv	a5,a0
ffffffe000201d20:	0007879b          	sext.w	a5,a5
ffffffe000201d24:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201d28:	f5043783          	ld	a5,-176(s0)
ffffffe000201d2c:	fff78793          	addi	a5,a5,-1
ffffffe000201d30:	f4f43823          	sd	a5,-176(s0)
ffffffe000201d34:	6280006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
ffffffe000201d38:	f5043783          	ld	a5,-176(s0)
ffffffe000201d3c:	0007c783          	lbu	a5,0(a5)
ffffffe000201d40:	00078713          	mv	a4,a5
ffffffe000201d44:	02e00793          	li	a5,46
ffffffe000201d48:	06f71863          	bne	a4,a5,ffffffe000201db8 <vprintfmt+0x218>
                fmt++;
ffffffe000201d4c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d50:	00178793          	addi	a5,a5,1
ffffffe000201d54:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000201d58:	f5043783          	ld	a5,-176(s0)
ffffffe000201d5c:	0007c783          	lbu	a5,0(a5)
ffffffe000201d60:	00078713          	mv	a4,a5
ffffffe000201d64:	02a00793          	li	a5,42
ffffffe000201d68:	00f71e63          	bne	a4,a5,ffffffe000201d84 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000201d6c:	f4843783          	ld	a5,-184(s0)
ffffffe000201d70:	00878713          	addi	a4,a5,8
ffffffe000201d74:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d78:	0007a783          	lw	a5,0(a5)
ffffffe000201d7c:	f8f42623          	sw	a5,-116(s0)
ffffffe000201d80:	5dc0006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d84:	f5043783          	ld	a5,-176(s0)
ffffffe000201d88:	f5040713          	addi	a4,s0,-176
ffffffe000201d8c:	00a00613          	li	a2,10
ffffffe000201d90:	00070593          	mv	a1,a4
ffffffe000201d94:	00078513          	mv	a0,a5
ffffffe000201d98:	fe4ff0ef          	jal	ffffffe00020157c <strtol>
ffffffe000201d9c:	00050793          	mv	a5,a0
ffffffe000201da0:	0007879b          	sext.w	a5,a5
ffffffe000201da4:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201da8:	f5043783          	ld	a5,-176(s0)
ffffffe000201dac:	fff78793          	addi	a5,a5,-1
ffffffe000201db0:	f4f43823          	sd	a5,-176(s0)
ffffffe000201db4:	5a80006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201db8:	f5043783          	ld	a5,-176(s0)
ffffffe000201dbc:	0007c783          	lbu	a5,0(a5)
ffffffe000201dc0:	00078713          	mv	a4,a5
ffffffe000201dc4:	07800793          	li	a5,120
ffffffe000201dc8:	02f70663          	beq	a4,a5,ffffffe000201df4 <vprintfmt+0x254>
ffffffe000201dcc:	f5043783          	ld	a5,-176(s0)
ffffffe000201dd0:	0007c783          	lbu	a5,0(a5)
ffffffe000201dd4:	00078713          	mv	a4,a5
ffffffe000201dd8:	05800793          	li	a5,88
ffffffe000201ddc:	00f70c63          	beq	a4,a5,ffffffe000201df4 <vprintfmt+0x254>
ffffffe000201de0:	f5043783          	ld	a5,-176(s0)
ffffffe000201de4:	0007c783          	lbu	a5,0(a5)
ffffffe000201de8:	00078713          	mv	a4,a5
ffffffe000201dec:	07000793          	li	a5,112
ffffffe000201df0:	30f71063          	bne	a4,a5,ffffffe0002020f0 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201df4:	f5043783          	ld	a5,-176(s0)
ffffffe000201df8:	0007c783          	lbu	a5,0(a5)
ffffffe000201dfc:	00078713          	mv	a4,a5
ffffffe000201e00:	07000793          	li	a5,112
ffffffe000201e04:	00f70663          	beq	a4,a5,ffffffe000201e10 <vprintfmt+0x270>
ffffffe000201e08:	f8144783          	lbu	a5,-127(s0)
ffffffe000201e0c:	00078663          	beqz	a5,ffffffe000201e18 <vprintfmt+0x278>
ffffffe000201e10:	00100793          	li	a5,1
ffffffe000201e14:	0080006f          	j	ffffffe000201e1c <vprintfmt+0x27c>
ffffffe000201e18:	00000793          	li	a5,0
ffffffe000201e1c:	faf403a3          	sb	a5,-89(s0)
ffffffe000201e20:	fa744783          	lbu	a5,-89(s0)
ffffffe000201e24:	0017f793          	andi	a5,a5,1
ffffffe000201e28:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201e2c:	fa744783          	lbu	a5,-89(s0)
ffffffe000201e30:	0ff7f793          	zext.b	a5,a5
ffffffe000201e34:	00078c63          	beqz	a5,ffffffe000201e4c <vprintfmt+0x2ac>
ffffffe000201e38:	f4843783          	ld	a5,-184(s0)
ffffffe000201e3c:	00878713          	addi	a4,a5,8
ffffffe000201e40:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e44:	0007b783          	ld	a5,0(a5)
ffffffe000201e48:	01c0006f          	j	ffffffe000201e64 <vprintfmt+0x2c4>
ffffffe000201e4c:	f4843783          	ld	a5,-184(s0)
ffffffe000201e50:	00878713          	addi	a4,a5,8
ffffffe000201e54:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e58:	0007a783          	lw	a5,0(a5)
ffffffe000201e5c:	02079793          	slli	a5,a5,0x20
ffffffe000201e60:	0207d793          	srli	a5,a5,0x20
ffffffe000201e64:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201e68:	f8c42783          	lw	a5,-116(s0)
ffffffe000201e6c:	02079463          	bnez	a5,ffffffe000201e94 <vprintfmt+0x2f4>
ffffffe000201e70:	fe043783          	ld	a5,-32(s0)
ffffffe000201e74:	02079063          	bnez	a5,ffffffe000201e94 <vprintfmt+0x2f4>
ffffffe000201e78:	f5043783          	ld	a5,-176(s0)
ffffffe000201e7c:	0007c783          	lbu	a5,0(a5)
ffffffe000201e80:	00078713          	mv	a4,a5
ffffffe000201e84:	07000793          	li	a5,112
ffffffe000201e88:	00f70663          	beq	a4,a5,ffffffe000201e94 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201e8c:	f8040023          	sb	zero,-128(s0)
ffffffe000201e90:	4cc0006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201e94:	f5043783          	ld	a5,-176(s0)
ffffffe000201e98:	0007c783          	lbu	a5,0(a5)
ffffffe000201e9c:	00078713          	mv	a4,a5
ffffffe000201ea0:	07000793          	li	a5,112
ffffffe000201ea4:	00f70a63          	beq	a4,a5,ffffffe000201eb8 <vprintfmt+0x318>
ffffffe000201ea8:	f8244783          	lbu	a5,-126(s0)
ffffffe000201eac:	00078a63          	beqz	a5,ffffffe000201ec0 <vprintfmt+0x320>
ffffffe000201eb0:	fe043783          	ld	a5,-32(s0)
ffffffe000201eb4:	00078663          	beqz	a5,ffffffe000201ec0 <vprintfmt+0x320>
ffffffe000201eb8:	00100793          	li	a5,1
ffffffe000201ebc:	0080006f          	j	ffffffe000201ec4 <vprintfmt+0x324>
ffffffe000201ec0:	00000793          	li	a5,0
ffffffe000201ec4:	faf40323          	sb	a5,-90(s0)
ffffffe000201ec8:	fa644783          	lbu	a5,-90(s0)
ffffffe000201ecc:	0017f793          	andi	a5,a5,1
ffffffe000201ed0:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201ed4:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201ed8:	f5043783          	ld	a5,-176(s0)
ffffffe000201edc:	0007c783          	lbu	a5,0(a5)
ffffffe000201ee0:	00078713          	mv	a4,a5
ffffffe000201ee4:	05800793          	li	a5,88
ffffffe000201ee8:	00f71863          	bne	a4,a5,ffffffe000201ef8 <vprintfmt+0x358>
ffffffe000201eec:	00001797          	auipc	a5,0x1
ffffffe000201ef0:	47478793          	addi	a5,a5,1140 # ffffffe000203360 <upperxdigits.1>
ffffffe000201ef4:	00c0006f          	j	ffffffe000201f00 <vprintfmt+0x360>
ffffffe000201ef8:	00001797          	auipc	a5,0x1
ffffffe000201efc:	48078793          	addi	a5,a5,1152 # ffffffe000203378 <lowerxdigits.0>
ffffffe000201f00:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201f04:	fe043783          	ld	a5,-32(s0)
ffffffe000201f08:	00f7f793          	andi	a5,a5,15
ffffffe000201f0c:	f9843703          	ld	a4,-104(s0)
ffffffe000201f10:	00f70733          	add	a4,a4,a5
ffffffe000201f14:	fdc42783          	lw	a5,-36(s0)
ffffffe000201f18:	0017869b          	addiw	a3,a5,1
ffffffe000201f1c:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201f20:	00074703          	lbu	a4,0(a4)
ffffffe000201f24:	ff078793          	addi	a5,a5,-16
ffffffe000201f28:	008787b3          	add	a5,a5,s0
ffffffe000201f2c:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201f30:	fe043783          	ld	a5,-32(s0)
ffffffe000201f34:	0047d793          	srli	a5,a5,0x4
ffffffe000201f38:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201f3c:	fe043783          	ld	a5,-32(s0)
ffffffe000201f40:	fc0792e3          	bnez	a5,ffffffe000201f04 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201f44:	f8c42703          	lw	a4,-116(s0)
ffffffe000201f48:	fff00793          	li	a5,-1
ffffffe000201f4c:	02f71663          	bne	a4,a5,ffffffe000201f78 <vprintfmt+0x3d8>
ffffffe000201f50:	f8344783          	lbu	a5,-125(s0)
ffffffe000201f54:	02078263          	beqz	a5,ffffffe000201f78 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201f58:	f8842703          	lw	a4,-120(s0)
ffffffe000201f5c:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f60:	0007879b          	sext.w	a5,a5
ffffffe000201f64:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f68:	0007879b          	sext.w	a5,a5
ffffffe000201f6c:	40f707bb          	subw	a5,a4,a5
ffffffe000201f70:	0007879b          	sext.w	a5,a5
ffffffe000201f74:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f78:	f8842703          	lw	a4,-120(s0)
ffffffe000201f7c:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f80:	0007879b          	sext.w	a5,a5
ffffffe000201f84:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f88:	0007879b          	sext.w	a5,a5
ffffffe000201f8c:	40f707bb          	subw	a5,a4,a5
ffffffe000201f90:	0007871b          	sext.w	a4,a5
ffffffe000201f94:	fdc42783          	lw	a5,-36(s0)
ffffffe000201f98:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201f9c:	f8c42783          	lw	a5,-116(s0)
ffffffe000201fa0:	f8f42823          	sw	a5,-112(s0)
ffffffe000201fa4:	f9442783          	lw	a5,-108(s0)
ffffffe000201fa8:	00078593          	mv	a1,a5
ffffffe000201fac:	f9042783          	lw	a5,-112(s0)
ffffffe000201fb0:	00078613          	mv	a2,a5
ffffffe000201fb4:	0006069b          	sext.w	a3,a2
ffffffe000201fb8:	0005879b          	sext.w	a5,a1
ffffffe000201fbc:	00f6d463          	bge	a3,a5,ffffffe000201fc4 <vprintfmt+0x424>
ffffffe000201fc0:	00058613          	mv	a2,a1
ffffffe000201fc4:	0006079b          	sext.w	a5,a2
ffffffe000201fc8:	40f707bb          	subw	a5,a4,a5
ffffffe000201fcc:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201fd0:	0280006f          	j	ffffffe000201ff8 <vprintfmt+0x458>
                    putch(' ');
ffffffe000201fd4:	f5843783          	ld	a5,-168(s0)
ffffffe000201fd8:	02000513          	li	a0,32
ffffffe000201fdc:	000780e7          	jalr	a5
                    ++written;
ffffffe000201fe0:	fec42783          	lw	a5,-20(s0)
ffffffe000201fe4:	0017879b          	addiw	a5,a5,1
ffffffe000201fe8:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201fec:	fd842783          	lw	a5,-40(s0)
ffffffe000201ff0:	fff7879b          	addiw	a5,a5,-1
ffffffe000201ff4:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201ff8:	fd842783          	lw	a5,-40(s0)
ffffffe000201ffc:	0007879b          	sext.w	a5,a5
ffffffe000202000:	fcf04ae3          	bgtz	a5,ffffffe000201fd4 <vprintfmt+0x434>
                }

                if (prefix) {
ffffffe000202004:	fa644783          	lbu	a5,-90(s0)
ffffffe000202008:	0ff7f793          	zext.b	a5,a5
ffffffe00020200c:	04078463          	beqz	a5,ffffffe000202054 <vprintfmt+0x4b4>
                    putch('0');
ffffffe000202010:	f5843783          	ld	a5,-168(s0)
ffffffe000202014:	03000513          	li	a0,48
ffffffe000202018:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe00020201c:	f5043783          	ld	a5,-176(s0)
ffffffe000202020:	0007c783          	lbu	a5,0(a5)
ffffffe000202024:	00078713          	mv	a4,a5
ffffffe000202028:	05800793          	li	a5,88
ffffffe00020202c:	00f71663          	bne	a4,a5,ffffffe000202038 <vprintfmt+0x498>
ffffffe000202030:	05800793          	li	a5,88
ffffffe000202034:	0080006f          	j	ffffffe00020203c <vprintfmt+0x49c>
ffffffe000202038:	07800793          	li	a5,120
ffffffe00020203c:	f5843703          	ld	a4,-168(s0)
ffffffe000202040:	00078513          	mv	a0,a5
ffffffe000202044:	000700e7          	jalr	a4
                    written += 2;
ffffffe000202048:	fec42783          	lw	a5,-20(s0)
ffffffe00020204c:	0027879b          	addiw	a5,a5,2
ffffffe000202050:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202054:	fdc42783          	lw	a5,-36(s0)
ffffffe000202058:	fcf42a23          	sw	a5,-44(s0)
ffffffe00020205c:	0280006f          	j	ffffffe000202084 <vprintfmt+0x4e4>
                    putch('0');
ffffffe000202060:	f5843783          	ld	a5,-168(s0)
ffffffe000202064:	03000513          	li	a0,48
ffffffe000202068:	000780e7          	jalr	a5
                    ++written;
ffffffe00020206c:	fec42783          	lw	a5,-20(s0)
ffffffe000202070:	0017879b          	addiw	a5,a5,1
ffffffe000202074:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202078:	fd442783          	lw	a5,-44(s0)
ffffffe00020207c:	0017879b          	addiw	a5,a5,1
ffffffe000202080:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202084:	f8c42783          	lw	a5,-116(s0)
ffffffe000202088:	fd442703          	lw	a4,-44(s0)
ffffffe00020208c:	0007071b          	sext.w	a4,a4
ffffffe000202090:	fcf748e3          	blt	a4,a5,ffffffe000202060 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202094:	fdc42783          	lw	a5,-36(s0)
ffffffe000202098:	fff7879b          	addiw	a5,a5,-1
ffffffe00020209c:	fcf42823          	sw	a5,-48(s0)
ffffffe0002020a0:	03c0006f          	j	ffffffe0002020dc <vprintfmt+0x53c>
                    putch(buf[i]);
ffffffe0002020a4:	fd042783          	lw	a5,-48(s0)
ffffffe0002020a8:	ff078793          	addi	a5,a5,-16
ffffffe0002020ac:	008787b3          	add	a5,a5,s0
ffffffe0002020b0:	f807c783          	lbu	a5,-128(a5)
ffffffe0002020b4:	0007871b          	sext.w	a4,a5
ffffffe0002020b8:	f5843783          	ld	a5,-168(s0)
ffffffe0002020bc:	00070513          	mv	a0,a4
ffffffe0002020c0:	000780e7          	jalr	a5
                    ++written;
ffffffe0002020c4:	fec42783          	lw	a5,-20(s0)
ffffffe0002020c8:	0017879b          	addiw	a5,a5,1
ffffffe0002020cc:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe0002020d0:	fd042783          	lw	a5,-48(s0)
ffffffe0002020d4:	fff7879b          	addiw	a5,a5,-1
ffffffe0002020d8:	fcf42823          	sw	a5,-48(s0)
ffffffe0002020dc:	fd042783          	lw	a5,-48(s0)
ffffffe0002020e0:	0007879b          	sext.w	a5,a5
ffffffe0002020e4:	fc07d0e3          	bgez	a5,ffffffe0002020a4 <vprintfmt+0x504>
                }

                flags.in_format = false;
ffffffe0002020e8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe0002020ec:	2700006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe0002020f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002020f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002020f8:	00078713          	mv	a4,a5
ffffffe0002020fc:	06400793          	li	a5,100
ffffffe000202100:	02f70663          	beq	a4,a5,ffffffe00020212c <vprintfmt+0x58c>
ffffffe000202104:	f5043783          	ld	a5,-176(s0)
ffffffe000202108:	0007c783          	lbu	a5,0(a5)
ffffffe00020210c:	00078713          	mv	a4,a5
ffffffe000202110:	06900793          	li	a5,105
ffffffe000202114:	00f70c63          	beq	a4,a5,ffffffe00020212c <vprintfmt+0x58c>
ffffffe000202118:	f5043783          	ld	a5,-176(s0)
ffffffe00020211c:	0007c783          	lbu	a5,0(a5)
ffffffe000202120:	00078713          	mv	a4,a5
ffffffe000202124:	07500793          	li	a5,117
ffffffe000202128:	08f71063          	bne	a4,a5,ffffffe0002021a8 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe00020212c:	f8144783          	lbu	a5,-127(s0)
ffffffe000202130:	00078c63          	beqz	a5,ffffffe000202148 <vprintfmt+0x5a8>
ffffffe000202134:	f4843783          	ld	a5,-184(s0)
ffffffe000202138:	00878713          	addi	a4,a5,8
ffffffe00020213c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202140:	0007b783          	ld	a5,0(a5)
ffffffe000202144:	0140006f          	j	ffffffe000202158 <vprintfmt+0x5b8>
ffffffe000202148:	f4843783          	ld	a5,-184(s0)
ffffffe00020214c:	00878713          	addi	a4,a5,8
ffffffe000202150:	f4e43423          	sd	a4,-184(s0)
ffffffe000202154:	0007a783          	lw	a5,0(a5)
ffffffe000202158:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe00020215c:	fa843583          	ld	a1,-88(s0)
ffffffe000202160:	f5043783          	ld	a5,-176(s0)
ffffffe000202164:	0007c783          	lbu	a5,0(a5)
ffffffe000202168:	0007871b          	sext.w	a4,a5
ffffffe00020216c:	07500793          	li	a5,117
ffffffe000202170:	40f707b3          	sub	a5,a4,a5
ffffffe000202174:	00f037b3          	snez	a5,a5
ffffffe000202178:	0ff7f793          	zext.b	a5,a5
ffffffe00020217c:	f8040713          	addi	a4,s0,-128
ffffffe000202180:	00070693          	mv	a3,a4
ffffffe000202184:	00078613          	mv	a2,a5
ffffffe000202188:	f5843503          	ld	a0,-168(s0)
ffffffe00020218c:	ee4ff0ef          	jal	ffffffe000201870 <print_dec_int>
ffffffe000202190:	00050793          	mv	a5,a0
ffffffe000202194:	fec42703          	lw	a4,-20(s0)
ffffffe000202198:	00f707bb          	addw	a5,a4,a5
ffffffe00020219c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002021a0:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe0002021a4:	1b80006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
ffffffe0002021a8:	f5043783          	ld	a5,-176(s0)
ffffffe0002021ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002021b0:	00078713          	mv	a4,a5
ffffffe0002021b4:	06e00793          	li	a5,110
ffffffe0002021b8:	04f71c63          	bne	a4,a5,ffffffe000202210 <vprintfmt+0x670>
                if (flags.longflag) {
ffffffe0002021bc:	f8144783          	lbu	a5,-127(s0)
ffffffe0002021c0:	02078463          	beqz	a5,ffffffe0002021e8 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
ffffffe0002021c4:	f4843783          	ld	a5,-184(s0)
ffffffe0002021c8:	00878713          	addi	a4,a5,8
ffffffe0002021cc:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021d0:	0007b783          	ld	a5,0(a5)
ffffffe0002021d4:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe0002021d8:	fec42703          	lw	a4,-20(s0)
ffffffe0002021dc:	fb043783          	ld	a5,-80(s0)
ffffffe0002021e0:	00e7b023          	sd	a4,0(a5)
ffffffe0002021e4:	0240006f          	j	ffffffe000202208 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe0002021e8:	f4843783          	ld	a5,-184(s0)
ffffffe0002021ec:	00878713          	addi	a4,a5,8
ffffffe0002021f0:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021f4:	0007b783          	ld	a5,0(a5)
ffffffe0002021f8:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe0002021fc:	fb843783          	ld	a5,-72(s0)
ffffffe000202200:	fec42703          	lw	a4,-20(s0)
ffffffe000202204:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe000202208:	f8040023          	sb	zero,-128(s0)
ffffffe00020220c:	1500006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
ffffffe000202210:	f5043783          	ld	a5,-176(s0)
ffffffe000202214:	0007c783          	lbu	a5,0(a5)
ffffffe000202218:	00078713          	mv	a4,a5
ffffffe00020221c:	07300793          	li	a5,115
ffffffe000202220:	02f71e63          	bne	a4,a5,ffffffe00020225c <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
ffffffe000202224:	f4843783          	ld	a5,-184(s0)
ffffffe000202228:	00878713          	addi	a4,a5,8
ffffffe00020222c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202230:	0007b783          	ld	a5,0(a5)
ffffffe000202234:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe000202238:	fc043583          	ld	a1,-64(s0)
ffffffe00020223c:	f5843503          	ld	a0,-168(s0)
ffffffe000202240:	da8ff0ef          	jal	ffffffe0002017e8 <puts_wo_nl>
ffffffe000202244:	00050793          	mv	a5,a0
ffffffe000202248:	fec42703          	lw	a4,-20(s0)
ffffffe00020224c:	00f707bb          	addw	a5,a4,a5
ffffffe000202250:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202254:	f8040023          	sb	zero,-128(s0)
ffffffe000202258:	1040006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
ffffffe00020225c:	f5043783          	ld	a5,-176(s0)
ffffffe000202260:	0007c783          	lbu	a5,0(a5)
ffffffe000202264:	00078713          	mv	a4,a5
ffffffe000202268:	06300793          	li	a5,99
ffffffe00020226c:	02f71e63          	bne	a4,a5,ffffffe0002022a8 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
ffffffe000202270:	f4843783          	ld	a5,-184(s0)
ffffffe000202274:	00878713          	addi	a4,a5,8
ffffffe000202278:	f4e43423          	sd	a4,-184(s0)
ffffffe00020227c:	0007a783          	lw	a5,0(a5)
ffffffe000202280:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000202284:	fcc42703          	lw	a4,-52(s0)
ffffffe000202288:	f5843783          	ld	a5,-168(s0)
ffffffe00020228c:	00070513          	mv	a0,a4
ffffffe000202290:	000780e7          	jalr	a5
                ++written;
ffffffe000202294:	fec42783          	lw	a5,-20(s0)
ffffffe000202298:	0017879b          	addiw	a5,a5,1
ffffffe00020229c:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002022a0:	f8040023          	sb	zero,-128(s0)
ffffffe0002022a4:	0b80006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
ffffffe0002022a8:	f5043783          	ld	a5,-176(s0)
ffffffe0002022ac:	0007c783          	lbu	a5,0(a5)
ffffffe0002022b0:	00078713          	mv	a4,a5
ffffffe0002022b4:	02500793          	li	a5,37
ffffffe0002022b8:	02f71263          	bne	a4,a5,ffffffe0002022dc <vprintfmt+0x73c>
                putch('%');
ffffffe0002022bc:	f5843783          	ld	a5,-168(s0)
ffffffe0002022c0:	02500513          	li	a0,37
ffffffe0002022c4:	000780e7          	jalr	a5
                ++written;
ffffffe0002022c8:	fec42783          	lw	a5,-20(s0)
ffffffe0002022cc:	0017879b          	addiw	a5,a5,1
ffffffe0002022d0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002022d4:	f8040023          	sb	zero,-128(s0)
ffffffe0002022d8:	0840006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
ffffffe0002022dc:	f5043783          	ld	a5,-176(s0)
ffffffe0002022e0:	0007c783          	lbu	a5,0(a5)
ffffffe0002022e4:	0007871b          	sext.w	a4,a5
ffffffe0002022e8:	f5843783          	ld	a5,-168(s0)
ffffffe0002022ec:	00070513          	mv	a0,a4
ffffffe0002022f0:	000780e7          	jalr	a5
                ++written;
ffffffe0002022f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002022f8:	0017879b          	addiw	a5,a5,1
ffffffe0002022fc:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202300:	f8040023          	sb	zero,-128(s0)
ffffffe000202304:	0580006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
ffffffe000202308:	f5043783          	ld	a5,-176(s0)
ffffffe00020230c:	0007c783          	lbu	a5,0(a5)
ffffffe000202310:	00078713          	mv	a4,a5
ffffffe000202314:	02500793          	li	a5,37
ffffffe000202318:	02f71063          	bne	a4,a5,ffffffe000202338 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe00020231c:	f8043023          	sd	zero,-128(s0)
ffffffe000202320:	f8043423          	sd	zero,-120(s0)
ffffffe000202324:	00100793          	li	a5,1
ffffffe000202328:	f8f40023          	sb	a5,-128(s0)
ffffffe00020232c:	fff00793          	li	a5,-1
ffffffe000202330:	f8f42623          	sw	a5,-116(s0)
ffffffe000202334:	0280006f          	j	ffffffe00020235c <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
ffffffe000202338:	f5043783          	ld	a5,-176(s0)
ffffffe00020233c:	0007c783          	lbu	a5,0(a5)
ffffffe000202340:	0007871b          	sext.w	a4,a5
ffffffe000202344:	f5843783          	ld	a5,-168(s0)
ffffffe000202348:	00070513          	mv	a0,a4
ffffffe00020234c:	000780e7          	jalr	a5
            ++written;
ffffffe000202350:	fec42783          	lw	a5,-20(s0)
ffffffe000202354:	0017879b          	addiw	a5,a5,1
ffffffe000202358:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe00020235c:	f5043783          	ld	a5,-176(s0)
ffffffe000202360:	00178793          	addi	a5,a5,1
ffffffe000202364:	f4f43823          	sd	a5,-176(s0)
ffffffe000202368:	f5043783          	ld	a5,-176(s0)
ffffffe00020236c:	0007c783          	lbu	a5,0(a5)
ffffffe000202370:	84079ee3          	bnez	a5,ffffffe000201bcc <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202374:	fec42783          	lw	a5,-20(s0)
}
ffffffe000202378:	00078513          	mv	a0,a5
ffffffe00020237c:	0b813083          	ld	ra,184(sp)
ffffffe000202380:	0b013403          	ld	s0,176(sp)
ffffffe000202384:	0c010113          	addi	sp,sp,192
ffffffe000202388:	00008067          	ret

ffffffe00020238c <printk>:

int printk(const char* s, ...) {
ffffffe00020238c:	f9010113          	addi	sp,sp,-112
ffffffe000202390:	02113423          	sd	ra,40(sp)
ffffffe000202394:	02813023          	sd	s0,32(sp)
ffffffe000202398:	03010413          	addi	s0,sp,48
ffffffe00020239c:	fca43c23          	sd	a0,-40(s0)
ffffffe0002023a0:	00b43423          	sd	a1,8(s0)
ffffffe0002023a4:	00c43823          	sd	a2,16(s0)
ffffffe0002023a8:	00d43c23          	sd	a3,24(s0)
ffffffe0002023ac:	02e43023          	sd	a4,32(s0)
ffffffe0002023b0:	02f43423          	sd	a5,40(s0)
ffffffe0002023b4:	03043823          	sd	a6,48(s0)
ffffffe0002023b8:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe0002023bc:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe0002023c0:	04040793          	addi	a5,s0,64
ffffffe0002023c4:	fcf43823          	sd	a5,-48(s0)
ffffffe0002023c8:	fd043783          	ld	a5,-48(s0)
ffffffe0002023cc:	fc878793          	addi	a5,a5,-56
ffffffe0002023d0:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe0002023d4:	fe043783          	ld	a5,-32(s0)
ffffffe0002023d8:	00078613          	mv	a2,a5
ffffffe0002023dc:	fd843583          	ld	a1,-40(s0)
ffffffe0002023e0:	fffff517          	auipc	a0,0xfffff
ffffffe0002023e4:	0ec50513          	addi	a0,a0,236 # ffffffe0002014cc <putc>
ffffffe0002023e8:	fb8ff0ef          	jal	ffffffe000201ba0 <vprintfmt>
ffffffe0002023ec:	00050793          	mv	a5,a0
ffffffe0002023f0:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe0002023f4:	fec42783          	lw	a5,-20(s0)
}
ffffffe0002023f8:	00078513          	mv	a0,a5
ffffffe0002023fc:	02813083          	ld	ra,40(sp)
ffffffe000202400:	02013403          	ld	s0,32(sp)
ffffffe000202404:	07010113          	addi	sp,sp,112
ffffffe000202408:	00008067          	ret

ffffffe00020240c <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe00020240c:	fe010113          	addi	sp,sp,-32
ffffffe000202410:	00113c23          	sd	ra,24(sp)
ffffffe000202414:	00813823          	sd	s0,16(sp)
ffffffe000202418:	02010413          	addi	s0,sp,32
ffffffe00020241c:	00050793          	mv	a5,a0
ffffffe000202420:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe000202424:	fec42783          	lw	a5,-20(s0)
ffffffe000202428:	fff7879b          	addiw	a5,a5,-1
ffffffe00020242c:	0007879b          	sext.w	a5,a5
ffffffe000202430:	02079713          	slli	a4,a5,0x20
ffffffe000202434:	02075713          	srli	a4,a4,0x20
ffffffe000202438:	00004797          	auipc	a5,0x4
ffffffe00020243c:	be878793          	addi	a5,a5,-1048 # ffffffe000206020 <seed>
ffffffe000202440:	00e7b023          	sd	a4,0(a5)
}
ffffffe000202444:	00000013          	nop
ffffffe000202448:	01813083          	ld	ra,24(sp)
ffffffe00020244c:	01013403          	ld	s0,16(sp)
ffffffe000202450:	02010113          	addi	sp,sp,32
ffffffe000202454:	00008067          	ret

ffffffe000202458 <rand>:

int rand(void) {
ffffffe000202458:	ff010113          	addi	sp,sp,-16
ffffffe00020245c:	00113423          	sd	ra,8(sp)
ffffffe000202460:	00813023          	sd	s0,0(sp)
ffffffe000202464:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe000202468:	00004797          	auipc	a5,0x4
ffffffe00020246c:	bb878793          	addi	a5,a5,-1096 # ffffffe000206020 <seed>
ffffffe000202470:	0007b703          	ld	a4,0(a5)
ffffffe000202474:	00001797          	auipc	a5,0x1
ffffffe000202478:	f1c78793          	addi	a5,a5,-228 # ffffffe000203390 <lowerxdigits.0+0x18>
ffffffe00020247c:	0007b783          	ld	a5,0(a5)
ffffffe000202480:	02f707b3          	mul	a5,a4,a5
ffffffe000202484:	00178713          	addi	a4,a5,1
ffffffe000202488:	00004797          	auipc	a5,0x4
ffffffe00020248c:	b9878793          	addi	a5,a5,-1128 # ffffffe000206020 <seed>
ffffffe000202490:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe000202494:	00004797          	auipc	a5,0x4
ffffffe000202498:	b8c78793          	addi	a5,a5,-1140 # ffffffe000206020 <seed>
ffffffe00020249c:	0007b783          	ld	a5,0(a5)
ffffffe0002024a0:	0217d793          	srli	a5,a5,0x21
ffffffe0002024a4:	0007879b          	sext.w	a5,a5
}
ffffffe0002024a8:	00078513          	mv	a0,a5
ffffffe0002024ac:	00813083          	ld	ra,8(sp)
ffffffe0002024b0:	00013403          	ld	s0,0(sp)
ffffffe0002024b4:	01010113          	addi	sp,sp,16
ffffffe0002024b8:	00008067          	ret

ffffffe0002024bc <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe0002024bc:	fc010113          	addi	sp,sp,-64
ffffffe0002024c0:	02113c23          	sd	ra,56(sp)
ffffffe0002024c4:	02813823          	sd	s0,48(sp)
ffffffe0002024c8:	04010413          	addi	s0,sp,64
ffffffe0002024cc:	fca43c23          	sd	a0,-40(s0)
ffffffe0002024d0:	00058793          	mv	a5,a1
ffffffe0002024d4:	fcc43423          	sd	a2,-56(s0)
ffffffe0002024d8:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe0002024dc:	fd843783          	ld	a5,-40(s0)
ffffffe0002024e0:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002024e4:	fe043423          	sd	zero,-24(s0)
ffffffe0002024e8:	0280006f          	j	ffffffe000202510 <memset+0x54>
        s[i] = c;
ffffffe0002024ec:	fe043703          	ld	a4,-32(s0)
ffffffe0002024f0:	fe843783          	ld	a5,-24(s0)
ffffffe0002024f4:	00f707b3          	add	a5,a4,a5
ffffffe0002024f8:	fd442703          	lw	a4,-44(s0)
ffffffe0002024fc:	0ff77713          	zext.b	a4,a4
ffffffe000202500:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202504:	fe843783          	ld	a5,-24(s0)
ffffffe000202508:	00178793          	addi	a5,a5,1
ffffffe00020250c:	fef43423          	sd	a5,-24(s0)
ffffffe000202510:	fe843703          	ld	a4,-24(s0)
ffffffe000202514:	fc843783          	ld	a5,-56(s0)
ffffffe000202518:	fcf76ae3          	bltu	a4,a5,ffffffe0002024ec <memset+0x30>
    }
    return dest;
ffffffe00020251c:	fd843783          	ld	a5,-40(s0)
}
ffffffe000202520:	00078513          	mv	a0,a5
ffffffe000202524:	03813083          	ld	ra,56(sp)
ffffffe000202528:	03013403          	ld	s0,48(sp)
ffffffe00020252c:	04010113          	addi	sp,sp,64
ffffffe000202530:	00008067          	ret
