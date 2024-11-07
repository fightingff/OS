
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
    # call setup_vm
    # call relocate
    
    call mm_init
ffffffe000200008:	41c000ef          	jal	ffffffe000200424 <mm_init>
    call setup_vm_final
ffffffe00020000c:	048010ef          	jal	ffffffe000201054 <setup_vm_final>
    call task_init
ffffffe000200010:	464000ef          	jal	ffffffe000200474 <task_init>

    la t0, _traps
ffffffe000200014:	00000297          	auipc	t0,0x0
ffffffe000200018:	06428293          	addi	t0,t0,100 # ffffffe000200078 <_traps>
    csrw stvec, t0  # set stvec = _traps
ffffffe00020001c:	10529073          	csrw	stvec,t0

    li t0, 32
ffffffe000200020:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
ffffffe000200024:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
ffffffe000200028:	234000ef          	jal	ffffffe00020025c <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe00020002c:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200030:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe000200034:	3c0010ef          	jal	ffffffe0002013f4 <start_kernel>

ffffffe000200038 <relocate>:
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    li t0, 0xffffffe000000000 - 0x80000000
ffffffe000200038:	fbf0029b          	addiw	t0,zero,-65
ffffffe00020003c:	01f29293          	slli	t0,t0,0x1f
    add ra, ra, t0
ffffffe000200040:	005080b3          	add	ra,ra,t0
    # csrw stvec, ra
    add sp, sp, t0
ffffffe000200044:	00510133          	add	sp,sp,t0

    # need a fence to ensure the new translations are in use
    sfence.vma zero, zero
ffffffe000200048:	12000073          	sfence.vma

    ###################### 
    #   YOUR CODE HERE   #
    ######################
    # set PPN
    la t0, early_pgtbl
ffffffe00020004c:	00007297          	auipc	t0,0x7
ffffffe000200050:	fb428293          	addi	t0,t0,-76 # ffffffe000207000 <early_pgtbl>
    srl t0, t0, 12 
ffffffe000200054:	00c2d293          	srli	t0,t0,0xc

    # set ASID
    li t1, 0
ffffffe000200058:	00000313          	li	t1,0
    sll t1, t1, 44
ffffffe00020005c:	02c31313          	slli	t1,t1,0x2c

    # set mode
    li t2, 8
ffffffe000200060:	00800393          	li	t2,8
    sll t2, t2, 60
ffffffe000200064:	03c39393          	slli	t2,t2,0x3c

    # set satp
    or t0, t0, t1
ffffffe000200068:	0062e2b3          	or	t0,t0,t1
    or t0, t0, t2
ffffffe00020006c:	0072e2b3          	or	t0,t0,t2
    csrw satp, t0
ffffffe000200070:	18029073          	csrw	satp,t0
    ret
ffffffe000200074:	00008067          	ret

ffffffe000200078 <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -264   # allocate 256 bytes stack space
ffffffe000200078:	ef810113          	addi	sp,sp,-264 # ffffffe000205ef8 <_sbss+0xef8>
    sd x0, 0(sp)
ffffffe00020007c:	00013023          	sd	zero,0(sp)
    sd x1, 8(sp)
ffffffe000200080:	00113423          	sd	ra,8(sp)
    sd x2, 16(sp)
ffffffe000200084:	00213823          	sd	sp,16(sp)
    sd x3, 24(sp)
ffffffe000200088:	00313c23          	sd	gp,24(sp)
    sd x4, 32(sp)
ffffffe00020008c:	02413023          	sd	tp,32(sp)
    sd x5, 40(sp)
ffffffe000200090:	02513423          	sd	t0,40(sp)
    sd x6, 48(sp)
ffffffe000200094:	02613823          	sd	t1,48(sp)
    sd x7, 56(sp)
ffffffe000200098:	02713c23          	sd	t2,56(sp)
    sd x8, 64(sp)
ffffffe00020009c:	04813023          	sd	s0,64(sp)
    sd x9, 72(sp)
ffffffe0002000a0:	04913423          	sd	s1,72(sp)
    sd x10, 80(sp)
ffffffe0002000a4:	04a13823          	sd	a0,80(sp)
    sd x11, 88(sp)
ffffffe0002000a8:	04b13c23          	sd	a1,88(sp)
    sd x12, 96(sp)
ffffffe0002000ac:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
ffffffe0002000b0:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
ffffffe0002000b4:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
ffffffe0002000b8:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
ffffffe0002000bc:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
ffffffe0002000c0:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
ffffffe0002000c4:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
ffffffe0002000c8:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
ffffffe0002000cc:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
ffffffe0002000d0:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
ffffffe0002000d4:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
ffffffe0002000d8:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
ffffffe0002000dc:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
ffffffe0002000e0:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
ffffffe0002000e4:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
ffffffe0002000e8:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
ffffffe0002000ec:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
ffffffe0002000f0:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
ffffffe0002000f4:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
ffffffe0002000f8:	0ff13c23          	sd	t6,248(sp)
    csrr t0, sepc
ffffffe0002000fc:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp) # can't directly store sepc to stack, csrr t0 fisrt
ffffffe000200100:	10513023          	sd	t0,256(sp)
    # 1. save 32 64-registers and sepc to stack


    # function parameters: scause, sepc
    csrr a0, scause
ffffffe000200104:	14202573          	csrr	a0,scause
    csrr a1, sepc
ffffffe000200108:	141025f3          	csrr	a1,sepc
    call trap_handler
ffffffe00020010c:	5ed000ef          	jal	ffffffe000200ef8 <trap_handler>
    # 2. call trap_handler

    ld t0, 256(sp)
ffffffe000200110:	10013283          	ld	t0,256(sp)
    csrw sepc, t0   # restore sepc also can't directly load sepc from stack
ffffffe000200114:	14129073          	csrw	sepc,t0
    ld x31, 248(sp)
ffffffe000200118:	0f813f83          	ld	t6,248(sp)
    ld x30, 240(sp)
ffffffe00020011c:	0f013f03          	ld	t5,240(sp)
    ld x29, 232(sp)
ffffffe000200120:	0e813e83          	ld	t4,232(sp)
    ld x28, 224(sp)
ffffffe000200124:	0e013e03          	ld	t3,224(sp)
    ld x27, 216(sp)
ffffffe000200128:	0d813d83          	ld	s11,216(sp)
    ld x26, 208(sp)
ffffffe00020012c:	0d013d03          	ld	s10,208(sp)
    ld x25, 200(sp)
ffffffe000200130:	0c813c83          	ld	s9,200(sp)
    ld x24, 192(sp)
ffffffe000200134:	0c013c03          	ld	s8,192(sp)
    ld x23, 184(sp)
ffffffe000200138:	0b813b83          	ld	s7,184(sp)
    ld x22, 176(sp)
ffffffe00020013c:	0b013b03          	ld	s6,176(sp)
    ld x21, 168(sp)
ffffffe000200140:	0a813a83          	ld	s5,168(sp)
    ld x20, 160(sp)
ffffffe000200144:	0a013a03          	ld	s4,160(sp)
    ld x19, 152(sp)
ffffffe000200148:	09813983          	ld	s3,152(sp)
    ld x18, 144(sp)
ffffffe00020014c:	09013903          	ld	s2,144(sp)
    ld x17, 136(sp)
ffffffe000200150:	08813883          	ld	a7,136(sp)
    ld x16, 128(sp)
ffffffe000200154:	08013803          	ld	a6,128(sp)
    ld x15, 120(sp)
ffffffe000200158:	07813783          	ld	a5,120(sp)
    ld x14, 112(sp)
ffffffe00020015c:	07013703          	ld	a4,112(sp)
    ld x13, 104(sp)
ffffffe000200160:	06813683          	ld	a3,104(sp)
    ld x12, 96(sp)
ffffffe000200164:	06013603          	ld	a2,96(sp)
    ld x11, 88(sp)
ffffffe000200168:	05813583          	ld	a1,88(sp)
    ld x10, 80(sp)
ffffffe00020016c:	05013503          	ld	a0,80(sp)
    ld x9, 72(sp)
ffffffe000200170:	04813483          	ld	s1,72(sp)
    ld x8, 64(sp)
ffffffe000200174:	04013403          	ld	s0,64(sp)
    ld x7, 56(sp)
ffffffe000200178:	03813383          	ld	t2,56(sp)
    ld x6, 48(sp)
ffffffe00020017c:	03013303          	ld	t1,48(sp)
    ld x5, 40(sp)
ffffffe000200180:	02813283          	ld	t0,40(sp)
    ld x4, 32(sp)
ffffffe000200184:	02013203          	ld	tp,32(sp)
    ld x3, 24(sp)
ffffffe000200188:	01813183          	ld	gp,24(sp)
    ld x2, 16(sp)
ffffffe00020018c:	01013103          	ld	sp,16(sp)
    ld x1, 8(sp)
ffffffe000200190:	00813083          	ld	ra,8(sp)
    ld x0, 0(sp)
ffffffe000200194:	00013003          	ld	zero,0(sp)
    addi sp, sp, 264    # restore stack pointer
ffffffe000200198:	10810113          	addi	sp,sp,264
    # 3. restore sepc and 32 registers (x2(sp) should be restore last) from stack

    sret    
ffffffe00020019c:	10200073          	sret

ffffffe0002001a0 <__dummy>:

    .extern dummy
    .globl __dummy
__dummy:
    # 将 sepc 设置为 dummy() 的地址，并使用 sret 从 S 模式中返回
    la t0, dummy
ffffffe0002001a0:	00000297          	auipc	t0,0x0
ffffffe0002001a4:	50c28293          	addi	t0,t0,1292 # ffffffe0002006ac <dummy>
    csrw sepc, t0
ffffffe0002001a8:	14129073          	csrw	sepc,t0
    sret
ffffffe0002001ac:	10200073          	sret

ffffffe0002001b0 <__switch_to>:

    .globl __switch_to
__switch_to:
    # save state to prev process
    add a0, a0, 32
ffffffe0002001b0:	02050513          	addi	a0,a0,32
    sd ra, 0(a0)
ffffffe0002001b4:	00153023          	sd	ra,0(a0)
    sd sp, 8(a0)
ffffffe0002001b8:	00253423          	sd	sp,8(a0)
    sd s0, 16(a0)
ffffffe0002001bc:	00853823          	sd	s0,16(a0)
    sd s1, 24(a0)
ffffffe0002001c0:	00953c23          	sd	s1,24(a0)
    sd s2, 32(a0)
ffffffe0002001c4:	03253023          	sd	s2,32(a0)
    sd s3, 40(a0)
ffffffe0002001c8:	03353423          	sd	s3,40(a0)
    sd s4, 48(a0)
ffffffe0002001cc:	03453823          	sd	s4,48(a0)
    sd s5, 56(a0)
ffffffe0002001d0:	03553c23          	sd	s5,56(a0)
    sd s6, 64(a0)
ffffffe0002001d4:	05653023          	sd	s6,64(a0)
    sd s7, 72(a0)
ffffffe0002001d8:	05753423          	sd	s7,72(a0)
    sd s8, 80(a0)
ffffffe0002001dc:	05853823          	sd	s8,80(a0)
    sd s9, 88(a0)
ffffffe0002001e0:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
ffffffe0002001e4:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
ffffffe0002001e8:	07b53423          	sd	s11,104(a0)

    # restore state from next process
    add a1, a1, 32
ffffffe0002001ec:	02058593          	addi	a1,a1,32
    ld ra, 0(a1)
ffffffe0002001f0:	0005b083          	ld	ra,0(a1)
    ld sp, 8(a1)
ffffffe0002001f4:	0085b103          	ld	sp,8(a1)
    ld s0, 16(a1)
ffffffe0002001f8:	0105b403          	ld	s0,16(a1)
    ld s1, 24(a1)
ffffffe0002001fc:	0185b483          	ld	s1,24(a1)
    ld s2, 32(a1)
ffffffe000200200:	0205b903          	ld	s2,32(a1)
    ld s3, 40(a1)
ffffffe000200204:	0285b983          	ld	s3,40(a1)
    ld s4, 48(a1)
ffffffe000200208:	0305ba03          	ld	s4,48(a1)
    ld s5, 56(a1)
ffffffe00020020c:	0385ba83          	ld	s5,56(a1)
    ld s6, 64(a1)
ffffffe000200210:	0405bb03          	ld	s6,64(a1)
    ld s7, 72(a1)
ffffffe000200214:	0485bb83          	ld	s7,72(a1)
    ld s8, 80(a1)
ffffffe000200218:	0505bc03          	ld	s8,80(a1)
    ld s9, 88(a1)
ffffffe00020021c:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
ffffffe000200220:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
ffffffe000200224:	0685bd83          	ld	s11,104(a1)

ffffffe000200228:	00008067          	ret

ffffffe00020022c <get_cycles>:
#include "sbi.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
ffffffe00020022c:	fe010113          	addi	sp,sp,-32
ffffffe000200230:	00113c23          	sd	ra,24(sp)
ffffffe000200234:	00813823          	sd	s0,16(sp)
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
ffffffe00020024c:	01813083          	ld	ra,24(sp)
ffffffe000200250:	01013403          	ld	s0,16(sp)
ffffffe000200254:	02010113          	addi	sp,sp,32
ffffffe000200258:	00008067          	ret

ffffffe00020025c <clock_set_next_event>:

void clock_set_next_event() {
ffffffe00020025c:	fe010113          	addi	sp,sp,-32
ffffffe000200260:	00113c23          	sd	ra,24(sp)
ffffffe000200264:	00813823          	sd	s0,16(sp)
ffffffe000200268:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    uint64_t next = get_cycles() + TIMECLOCK;
ffffffe00020026c:	fc1ff0ef          	jal	ffffffe00020022c <get_cycles>
ffffffe000200270:	00050713          	mv	a4,a0
ffffffe000200274:	00004797          	auipc	a5,0x4
ffffffe000200278:	d8c78793          	addi	a5,a5,-628 # ffffffe000204000 <TIMECLOCK>
ffffffe00020027c:	0007b783          	ld	a5,0(a5)
ffffffe000200280:	00f707b3          	add	a5,a4,a5
ffffffe000200284:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe000200288:	fe843503          	ld	a0,-24(s0)
ffffffe00020028c:	2b9000ef          	jal	ffffffe000200d44 <sbi_set_timer>
ffffffe000200290:	00000013          	nop
ffffffe000200294:	01813083          	ld	ra,24(sp)
ffffffe000200298:	01013403          	ld	s0,16(sp)
ffffffe00020029c:	02010113          	addi	sp,sp,32
ffffffe0002002a0:	00008067          	ret

ffffffe0002002a4 <kalloc>:

struct {
    struct run *freelist;
} kmem;

void *kalloc() {
ffffffe0002002a4:	fe010113          	addi	sp,sp,-32
ffffffe0002002a8:	00113c23          	sd	ra,24(sp)
ffffffe0002002ac:	00813823          	sd	s0,16(sp)
ffffffe0002002b0:	02010413          	addi	s0,sp,32
    struct run *r;

    r = kmem.freelist;
ffffffe0002002b4:	00006797          	auipc	a5,0x6
ffffffe0002002b8:	d4c78793          	addi	a5,a5,-692 # ffffffe000206000 <kmem>
ffffffe0002002bc:	0007b783          	ld	a5,0(a5)
ffffffe0002002c0:	fef43423          	sd	a5,-24(s0)
    kmem.freelist = r->next;
ffffffe0002002c4:	fe843783          	ld	a5,-24(s0)
ffffffe0002002c8:	0007b703          	ld	a4,0(a5)
ffffffe0002002cc:	00006797          	auipc	a5,0x6
ffffffe0002002d0:	d3478793          	addi	a5,a5,-716 # ffffffe000206000 <kmem>
ffffffe0002002d4:	00e7b023          	sd	a4,0(a5)
    
    memset((void *)r, 0x0, PGSIZE);
ffffffe0002002d8:	00001637          	lui	a2,0x1
ffffffe0002002dc:	00000593          	li	a1,0
ffffffe0002002e0:	fe843503          	ld	a0,-24(s0)
ffffffe0002002e4:	1ec020ef          	jal	ffffffe0002024d0 <memset>
    return (void *)r;
ffffffe0002002e8:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002002ec:	00078513          	mv	a0,a5
ffffffe0002002f0:	01813083          	ld	ra,24(sp)
ffffffe0002002f4:	01013403          	ld	s0,16(sp)
ffffffe0002002f8:	02010113          	addi	sp,sp,32
ffffffe0002002fc:	00008067          	ret

ffffffe000200300 <kfree>:

void kfree(void *addr) {
ffffffe000200300:	fd010113          	addi	sp,sp,-48
ffffffe000200304:	02113423          	sd	ra,40(sp)
ffffffe000200308:	02813023          	sd	s0,32(sp)
ffffffe00020030c:	03010413          	addi	s0,sp,48
ffffffe000200310:	fca43c23          	sd	a0,-40(s0)
    struct run *r;

    // LOG(RED "kfree(addr: %p)" CLEAR, addr);

    // PGSIZE align 
    *(uintptr_t *)&addr = (uintptr_t)addr & ~(PGSIZE - 1);
ffffffe000200314:	fd843783          	ld	a5,-40(s0)
ffffffe000200318:	00078693          	mv	a3,a5
ffffffe00020031c:	fd840793          	addi	a5,s0,-40
ffffffe000200320:	fffff737          	lui	a4,0xfffff
ffffffe000200324:	00e6f733          	and	a4,a3,a4
ffffffe000200328:	00e7b023          	sd	a4,0(a5)

    memset(addr, 0x0, (uint64_t)PGSIZE);
ffffffe00020032c:	fd843783          	ld	a5,-40(s0)
ffffffe000200330:	00001637          	lui	a2,0x1
ffffffe000200334:	00000593          	li	a1,0
ffffffe000200338:	00078513          	mv	a0,a5
ffffffe00020033c:	194020ef          	jal	ffffffe0002024d0 <memset>

    r = (struct run *)addr;
ffffffe000200340:	fd843783          	ld	a5,-40(s0)
ffffffe000200344:	fef43423          	sd	a5,-24(s0)
    r->next = kmem.freelist;
ffffffe000200348:	00006797          	auipc	a5,0x6
ffffffe00020034c:	cb878793          	addi	a5,a5,-840 # ffffffe000206000 <kmem>
ffffffe000200350:	0007b703          	ld	a4,0(a5)
ffffffe000200354:	fe843783          	ld	a5,-24(s0)
ffffffe000200358:	00e7b023          	sd	a4,0(a5)
    kmem.freelist = r;
ffffffe00020035c:	00006797          	auipc	a5,0x6
ffffffe000200360:	ca478793          	addi	a5,a5,-860 # ffffffe000206000 <kmem>
ffffffe000200364:	fe843703          	ld	a4,-24(s0)
ffffffe000200368:	00e7b023          	sd	a4,0(a5)

    return;
ffffffe00020036c:	00000013          	nop
}
ffffffe000200370:	02813083          	ld	ra,40(sp)
ffffffe000200374:	02013403          	ld	s0,32(sp)
ffffffe000200378:	03010113          	addi	sp,sp,48
ffffffe00020037c:	00008067          	ret

ffffffe000200380 <kfreerange>:

void kfreerange(char *start, char *end) {
ffffffe000200380:	fd010113          	addi	sp,sp,-48
ffffffe000200384:	02113423          	sd	ra,40(sp)
ffffffe000200388:	02813023          	sd	s0,32(sp)
ffffffe00020038c:	03010413          	addi	s0,sp,48
ffffffe000200390:	fca43c23          	sd	a0,-40(s0)
ffffffe000200394:	fcb43823          	sd	a1,-48(s0)
    LOG(RED "kfreerange(start: %p, end: %p)" CLEAR, start, end);
ffffffe000200398:	fd043783          	ld	a5,-48(s0)
ffffffe00020039c:	fd843703          	ld	a4,-40(s0)
ffffffe0002003a0:	00003697          	auipc	a3,0x3
ffffffe0002003a4:	ce068693          	addi	a3,a3,-800 # ffffffe000203080 <__func__.0>
ffffffe0002003a8:	02800613          	li	a2,40
ffffffe0002003ac:	00003597          	auipc	a1,0x3
ffffffe0002003b0:	c5c58593          	addi	a1,a1,-932 # ffffffe000203008 <__func__.3+0x8>
ffffffe0002003b4:	00003517          	auipc	a0,0x3
ffffffe0002003b8:	c5c50513          	addi	a0,a0,-932 # ffffffe000203010 <__func__.3+0x10>
ffffffe0002003bc:	7e5010ef          	jal	ffffffe0002023a0 <printk>
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe0002003c0:	fd843703          	ld	a4,-40(s0)
ffffffe0002003c4:	000017b7          	lui	a5,0x1
ffffffe0002003c8:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003cc:	00f70733          	add	a4,a4,a5
ffffffe0002003d0:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003d4:	00f777b3          	and	a5,a4,a5
ffffffe0002003d8:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003dc:	01c0006f          	j	ffffffe0002003f8 <kfreerange+0x78>
        kfree((void *)addr);
ffffffe0002003e0:	fe843503          	ld	a0,-24(s0)
ffffffe0002003e4:	f1dff0ef          	jal	ffffffe000200300 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003e8:	fe843703          	ld	a4,-24(s0)
ffffffe0002003ec:	000017b7          	lui	a5,0x1
ffffffe0002003f0:	00f707b3          	add	a5,a4,a5
ffffffe0002003f4:	fef43423          	sd	a5,-24(s0)
ffffffe0002003f8:	fe843703          	ld	a4,-24(s0)
ffffffe0002003fc:	000017b7          	lui	a5,0x1
ffffffe000200400:	00f70733          	add	a4,a4,a5
ffffffe000200404:	fd043783          	ld	a5,-48(s0)
ffffffe000200408:	fce7fce3          	bgeu	a5,a4,ffffffe0002003e0 <kfreerange+0x60>
    }
}
ffffffe00020040c:	00000013          	nop
ffffffe000200410:	00000013          	nop
ffffffe000200414:	02813083          	ld	ra,40(sp)
ffffffe000200418:	02013403          	ld	s0,32(sp)
ffffffe00020041c:	03010113          	addi	sp,sp,48
ffffffe000200420:	00008067          	ret

ffffffe000200424 <mm_init>:

void mm_init(void) {
ffffffe000200424:	ff010113          	addi	sp,sp,-16
ffffffe000200428:	00113423          	sd	ra,8(sp)
ffffffe00020042c:	00813023          	sd	s0,0(sp)
ffffffe000200430:	01010413          	addi	s0,sp,16
    printk("mm_init start...\n");
ffffffe000200434:	00003517          	auipc	a0,0x3
ffffffe000200438:	c1c50513          	addi	a0,a0,-996 # ffffffe000203050 <__func__.3+0x50>
ffffffe00020043c:	765010ef          	jal	ffffffe0002023a0 <printk>
    kfreerange(_ekernel, (char *)(PHY_END + PA2VA_OFFSET));
ffffffe000200440:	c0100793          	li	a5,-1023
ffffffe000200444:	01b79593          	slli	a1,a5,0x1b
ffffffe000200448:	00009517          	auipc	a0,0x9
ffffffe00020044c:	bb850513          	addi	a0,a0,-1096 # ffffffe000209000 <_ebss>
ffffffe000200450:	f31ff0ef          	jal	ffffffe000200380 <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200454:	00003517          	auipc	a0,0x3
ffffffe000200458:	c1450513          	addi	a0,a0,-1004 # ffffffe000203068 <__func__.3+0x68>
ffffffe00020045c:	745010ef          	jal	ffffffe0002023a0 <printk>
}
ffffffe000200460:	00000013          	nop
ffffffe000200464:	00813083          	ld	ra,8(sp)
ffffffe000200468:	00013403          	ld	s0,0(sp)
ffffffe00020046c:	01010113          	addi	sp,sp,16
ffffffe000200470:	00008067          	ret

ffffffe000200474 <task_init>:

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

void task_init() {
ffffffe000200474:	fe010113          	addi	sp,sp,-32
ffffffe000200478:	00113c23          	sd	ra,24(sp)
ffffffe00020047c:	00813823          	sd	s0,16(sp)
ffffffe000200480:	02010413          	addi	s0,sp,32
    srand(2024);
ffffffe000200484:	7e800513          	li	a0,2024
ffffffe000200488:	799010ef          	jal	ffffffe000202420 <srand>

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();
ffffffe00020048c:	e19ff0ef          	jal	ffffffe0002002a4 <kalloc>
ffffffe000200490:	00050713          	mv	a4,a0
ffffffe000200494:	00006797          	auipc	a5,0x6
ffffffe000200498:	b7478793          	addi	a5,a5,-1164 # ffffffe000206008 <idle>
ffffffe00020049c:	00e7b023          	sd	a4,0(a5)

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;
ffffffe0002004a0:	00006797          	auipc	a5,0x6
ffffffe0002004a4:	b6878793          	addi	a5,a5,-1176 # ffffffe000206008 <idle>
ffffffe0002004a8:	0007b783          	ld	a5,0(a5)
ffffffe0002004ac:	0007b023          	sd	zero,0(a5)

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;
ffffffe0002004b0:	00006797          	auipc	a5,0x6
ffffffe0002004b4:	b5878793          	addi	a5,a5,-1192 # ffffffe000206008 <idle>
ffffffe0002004b8:	0007b783          	ld	a5,0(a5)
ffffffe0002004bc:	0007b823          	sd	zero,16(a5)
ffffffe0002004c0:	00006717          	auipc	a4,0x6
ffffffe0002004c4:	b4870713          	addi	a4,a4,-1208 # ffffffe000206008 <idle>
ffffffe0002004c8:	00073703          	ld	a4,0(a4)
ffffffe0002004cc:	0107b783          	ld	a5,16(a5)
ffffffe0002004d0:	00f73423          	sd	a5,8(a4)

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;
ffffffe0002004d4:	00006797          	auipc	a5,0x6
ffffffe0002004d8:	b3478793          	addi	a5,a5,-1228 # ffffffe000206008 <idle>
ffffffe0002004dc:	0007b783          	ld	a5,0(a5)
ffffffe0002004e0:	0007bc23          	sd	zero,24(a5)

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;
ffffffe0002004e4:	00006797          	auipc	a5,0x6
ffffffe0002004e8:	b2478793          	addi	a5,a5,-1244 # ffffffe000206008 <idle>
ffffffe0002004ec:	0007b703          	ld	a4,0(a5)
ffffffe0002004f0:	00006797          	auipc	a5,0x6
ffffffe0002004f4:	b3078793          	addi	a5,a5,-1232 # ffffffe000206020 <task>
ffffffe0002004f8:	00e7b023          	sd	a4,0(a5)
ffffffe0002004fc:	00006797          	auipc	a5,0x6
ffffffe000200500:	b2478793          	addi	a5,a5,-1244 # ffffffe000206020 <task>
ffffffe000200504:	0007b703          	ld	a4,0(a5)
ffffffe000200508:	00006797          	auipc	a5,0x6
ffffffe00020050c:	b0878793          	addi	a5,a5,-1272 # ffffffe000206010 <current>
ffffffe000200510:	00e7b023          	sd	a4,0(a5)
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200514:	00100793          	li	a5,1
ffffffe000200518:	fef42623          	sw	a5,-20(s0)
ffffffe00020051c:	1600006f          	j	ffffffe00020067c <task_init+0x208>
        task[i] = (struct task_struct *)kalloc();
ffffffe000200520:	d85ff0ef          	jal	ffffffe0002002a4 <kalloc>
ffffffe000200524:	00050693          	mv	a3,a0
ffffffe000200528:	00006717          	auipc	a4,0x6
ffffffe00020052c:	af870713          	addi	a4,a4,-1288 # ffffffe000206020 <task>
ffffffe000200530:	fec42783          	lw	a5,-20(s0)
ffffffe000200534:	00379793          	slli	a5,a5,0x3
ffffffe000200538:	00f707b3          	add	a5,a4,a5
ffffffe00020053c:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe000200540:	00006717          	auipc	a4,0x6
ffffffe000200544:	ae070713          	addi	a4,a4,-1312 # ffffffe000206020 <task>
ffffffe000200548:	fec42783          	lw	a5,-20(s0)
ffffffe00020054c:	00379793          	slli	a5,a5,0x3
ffffffe000200550:	00f707b3          	add	a5,a4,a5
ffffffe000200554:	0007b783          	ld	a5,0(a5)
ffffffe000200558:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe00020055c:	00006717          	auipc	a4,0x6
ffffffe000200560:	ac470713          	addi	a4,a4,-1340 # ffffffe000206020 <task>
ffffffe000200564:	fec42783          	lw	a5,-20(s0)
ffffffe000200568:	00379793          	slli	a5,a5,0x3
ffffffe00020056c:	00f707b3          	add	a5,a4,a5
ffffffe000200570:	0007b783          	ld	a5,0(a5)
ffffffe000200574:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe000200578:	6f5010ef          	jal	ffffffe00020246c <rand>
ffffffe00020057c:	00050793          	mv	a5,a0
ffffffe000200580:	00078713          	mv	a4,a5
ffffffe000200584:	0007069b          	sext.w	a3,a4
ffffffe000200588:	666667b7          	lui	a5,0x66666
ffffffe00020058c:	66778793          	addi	a5,a5,1639 # 66666667 <PHY_SIZE+0x5e666667>
ffffffe000200590:	02f687b3          	mul	a5,a3,a5
ffffffe000200594:	0207d793          	srli	a5,a5,0x20
ffffffe000200598:	4027d79b          	sraiw	a5,a5,0x2
ffffffe00020059c:	00078693          	mv	a3,a5
ffffffe0002005a0:	41f7579b          	sraiw	a5,a4,0x1f
ffffffe0002005a4:	40f687bb          	subw	a5,a3,a5
ffffffe0002005a8:	00078693          	mv	a3,a5
ffffffe0002005ac:	00068793          	mv	a5,a3
ffffffe0002005b0:	0027979b          	slliw	a5,a5,0x2
ffffffe0002005b4:	00d787bb          	addw	a5,a5,a3
ffffffe0002005b8:	0017979b          	slliw	a5,a5,0x1
ffffffe0002005bc:	40f707bb          	subw	a5,a4,a5
ffffffe0002005c0:	0007879b          	sext.w	a5,a5
ffffffe0002005c4:	0017879b          	addiw	a5,a5,1
ffffffe0002005c8:	0007869b          	sext.w	a3,a5
ffffffe0002005cc:	00006717          	auipc	a4,0x6
ffffffe0002005d0:	a5470713          	addi	a4,a4,-1452 # ffffffe000206020 <task>
ffffffe0002005d4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005d8:	00379793          	slli	a5,a5,0x3
ffffffe0002005dc:	00f707b3          	add	a5,a4,a5
ffffffe0002005e0:	0007b783          	ld	a5,0(a5)
ffffffe0002005e4:	00068713          	mv	a4,a3
ffffffe0002005e8:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe0002005ec:	00006717          	auipc	a4,0x6
ffffffe0002005f0:	a3470713          	addi	a4,a4,-1484 # ffffffe000206020 <task>
ffffffe0002005f4:	fec42783          	lw	a5,-20(s0)
ffffffe0002005f8:	00379793          	slli	a5,a5,0x3
ffffffe0002005fc:	00f707b3          	add	a5,a4,a5
ffffffe000200600:	0007b783          	ld	a5,0(a5)
ffffffe000200604:	fec42703          	lw	a4,-20(s0)
ffffffe000200608:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe00020060c:	00006717          	auipc	a4,0x6
ffffffe000200610:	a1470713          	addi	a4,a4,-1516 # ffffffe000206020 <task>
ffffffe000200614:	fec42783          	lw	a5,-20(s0)
ffffffe000200618:	00379793          	slli	a5,a5,0x3
ffffffe00020061c:	00f707b3          	add	a5,a4,a5
ffffffe000200620:	0007b783          	ld	a5,0(a5)
ffffffe000200624:	00000717          	auipc	a4,0x0
ffffffe000200628:	b7c70713          	addi	a4,a4,-1156 # ffffffe0002001a0 <__dummy>
ffffffe00020062c:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe000200630:	00006717          	auipc	a4,0x6
ffffffe000200634:	9f070713          	addi	a4,a4,-1552 # ffffffe000206020 <task>
ffffffe000200638:	fec42783          	lw	a5,-20(s0)
ffffffe00020063c:	00379793          	slli	a5,a5,0x3
ffffffe000200640:	00f707b3          	add	a5,a4,a5
ffffffe000200644:	0007b783          	ld	a5,0(a5)
ffffffe000200648:	00078693          	mv	a3,a5
ffffffe00020064c:	00006717          	auipc	a4,0x6
ffffffe000200650:	9d470713          	addi	a4,a4,-1580 # ffffffe000206020 <task>
ffffffe000200654:	fec42783          	lw	a5,-20(s0)
ffffffe000200658:	00379793          	slli	a5,a5,0x3
ffffffe00020065c:	00f707b3          	add	a5,a4,a5
ffffffe000200660:	0007b783          	ld	a5,0(a5)
ffffffe000200664:	00001737          	lui	a4,0x1
ffffffe000200668:	00e68733          	add	a4,a3,a4
ffffffe00020066c:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200670:	fec42783          	lw	a5,-20(s0)
ffffffe000200674:	0017879b          	addiw	a5,a5,1
ffffffe000200678:	fef42623          	sw	a5,-20(s0)
ffffffe00020067c:	fec42783          	lw	a5,-20(s0)
ffffffe000200680:	0007871b          	sext.w	a4,a5
ffffffe000200684:	01f00793          	li	a5,31
ffffffe000200688:	e8e7dce3          	bge	a5,a4,ffffffe000200520 <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe00020068c:	00003517          	auipc	a0,0x3
ffffffe000200690:	a0450513          	addi	a0,a0,-1532 # ffffffe000203090 <__func__.0+0x10>
ffffffe000200694:	50d010ef          	jal	ffffffe0002023a0 <printk>
}
ffffffe000200698:	00000013          	nop
ffffffe00020069c:	01813083          	ld	ra,24(sp)
ffffffe0002006a0:	01013403          	ld	s0,16(sp)
ffffffe0002006a4:	02010113          	addi	sp,sp,32
ffffffe0002006a8:	00008067          	ret

ffffffe0002006ac <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe0002006ac:	fd010113          	addi	sp,sp,-48
ffffffe0002006b0:	02113423          	sd	ra,40(sp)
ffffffe0002006b4:	02813023          	sd	s0,32(sp)
ffffffe0002006b8:	03010413          	addi	s0,sp,48
    LOG(RED);
ffffffe0002006bc:	00003697          	auipc	a3,0x3
ffffffe0002006c0:	94468693          	addi	a3,a3,-1724 # ffffffe000203000 <__func__.3>
ffffffe0002006c4:	04100613          	li	a2,65
ffffffe0002006c8:	00003597          	auipc	a1,0x3
ffffffe0002006cc:	9e058593          	addi	a1,a1,-1568 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe0002006d0:	00003517          	auipc	a0,0x3
ffffffe0002006d4:	9e050513          	addi	a0,a0,-1568 # ffffffe0002030b0 <__func__.0+0x30>
ffffffe0002006d8:	4c9010ef          	jal	ffffffe0002023a0 <printk>
    uint64_t MOD = 1000000007;
ffffffe0002006dc:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe0002006e0:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe0002006e4:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe0002006e8:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe0002006ec:	fff00793          	li	a5,-1
ffffffe0002006f0:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002006f4:	fe442783          	lw	a5,-28(s0)
ffffffe0002006f8:	0007871b          	sext.w	a4,a5
ffffffe0002006fc:	fff00793          	li	a5,-1
ffffffe000200700:	00f70e63          	beq	a4,a5,ffffffe00020071c <dummy+0x70>
ffffffe000200704:	00006797          	auipc	a5,0x6
ffffffe000200708:	90c78793          	addi	a5,a5,-1780 # ffffffe000206010 <current>
ffffffe00020070c:	0007b783          	ld	a5,0(a5)
ffffffe000200710:	0087b703          	ld	a4,8(a5)
ffffffe000200714:	fe442783          	lw	a5,-28(s0)
ffffffe000200718:	fcf70ee3          	beq	a4,a5,ffffffe0002006f4 <dummy+0x48>
ffffffe00020071c:	00006797          	auipc	a5,0x6
ffffffe000200720:	8f478793          	addi	a5,a5,-1804 # ffffffe000206010 <current>
ffffffe000200724:	0007b783          	ld	a5,0(a5)
ffffffe000200728:	0087b783          	ld	a5,8(a5)
ffffffe00020072c:	fc0784e3          	beqz	a5,ffffffe0002006f4 <dummy+0x48>
            if (current->counter == 1) {
ffffffe000200730:	00006797          	auipc	a5,0x6
ffffffe000200734:	8e078793          	addi	a5,a5,-1824 # ffffffe000206010 <current>
ffffffe000200738:	0007b783          	ld	a5,0(a5)
ffffffe00020073c:	0087b703          	ld	a4,8(a5)
ffffffe000200740:	00100793          	li	a5,1
ffffffe000200744:	00f71e63          	bne	a4,a5,ffffffe000200760 <dummy+0xb4>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe000200748:	00006797          	auipc	a5,0x6
ffffffe00020074c:	8c878793          	addi	a5,a5,-1848 # ffffffe000206010 <current>
ffffffe000200750:	0007b783          	ld	a5,0(a5)
ffffffe000200754:	0087b703          	ld	a4,8(a5)
ffffffe000200758:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe00020075c:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe000200760:	00006797          	auipc	a5,0x6
ffffffe000200764:	8b078793          	addi	a5,a5,-1872 # ffffffe000206010 <current>
ffffffe000200768:	0007b783          	ld	a5,0(a5)
ffffffe00020076c:	0087b783          	ld	a5,8(a5)
ffffffe000200770:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe000200774:	fe843783          	ld	a5,-24(s0)
ffffffe000200778:	00178713          	addi	a4,a5,1
ffffffe00020077c:	fd843783          	ld	a5,-40(s0)
ffffffe000200780:	02f777b3          	remu	a5,a4,a5
ffffffe000200784:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe000200788:	00006797          	auipc	a5,0x6
ffffffe00020078c:	88878793          	addi	a5,a5,-1912 # ffffffe000206010 <current>
ffffffe000200790:	0007b783          	ld	a5,0(a5)
ffffffe000200794:	0187b783          	ld	a5,24(a5)
ffffffe000200798:	fe843603          	ld	a2,-24(s0)
ffffffe00020079c:	00078593          	mv	a1,a5
ffffffe0002007a0:	00003517          	auipc	a0,0x3
ffffffe0002007a4:	93050513          	addi	a0,a0,-1744 # ffffffe0002030d0 <__func__.0+0x50>
ffffffe0002007a8:	3f9010ef          	jal	ffffffe0002023a0 <printk>
            LOG(RED "%llu\n", current->thread.ra);
ffffffe0002007ac:	00006797          	auipc	a5,0x6
ffffffe0002007b0:	86478793          	addi	a5,a5,-1948 # ffffffe000206010 <current>
ffffffe0002007b4:	0007b783          	ld	a5,0(a5)
ffffffe0002007b8:	0207b783          	ld	a5,32(a5)
ffffffe0002007bc:	00078713          	mv	a4,a5
ffffffe0002007c0:	00003697          	auipc	a3,0x3
ffffffe0002007c4:	84068693          	addi	a3,a3,-1984 # ffffffe000203000 <__func__.3>
ffffffe0002007c8:	04d00613          	li	a2,77
ffffffe0002007cc:	00003597          	auipc	a1,0x3
ffffffe0002007d0:	8dc58593          	addi	a1,a1,-1828 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe0002007d4:	00003517          	auipc	a0,0x3
ffffffe0002007d8:	92c50513          	addi	a0,a0,-1748 # ffffffe000203100 <__func__.0+0x80>
ffffffe0002007dc:	3c5010ef          	jal	ffffffe0002023a0 <printk>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe0002007e0:	f15ff06f          	j	ffffffe0002006f4 <dummy+0x48>

ffffffe0002007e4 <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe0002007e4:	fd010113          	addi	sp,sp,-48
ffffffe0002007e8:	02113423          	sd	ra,40(sp)
ffffffe0002007ec:	02813023          	sd	s0,32(sp)
ffffffe0002007f0:	03010413          	addi	s0,sp,48
ffffffe0002007f4:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe0002007f8:	00003697          	auipc	a3,0x3
ffffffe0002007fc:	9e868693          	addi	a3,a3,-1560 # ffffffe0002031e0 <__func__.2>
ffffffe000200800:	06500613          	li	a2,101
ffffffe000200804:	00003597          	auipc	a1,0x3
ffffffe000200808:	8a458593          	addi	a1,a1,-1884 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe00020080c:	00003517          	auipc	a0,0x3
ffffffe000200810:	8a450513          	addi	a0,a0,-1884 # ffffffe0002030b0 <__func__.0+0x30>
ffffffe000200814:	38d010ef          	jal	ffffffe0002023a0 <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe000200818:	00005797          	auipc	a5,0x5
ffffffe00020081c:	7f878793          	addi	a5,a5,2040 # ffffffe000206010 <current>
ffffffe000200820:	0007b783          	ld	a5,0(a5)
ffffffe000200824:	0187b703          	ld	a4,24(a5)
ffffffe000200828:	fd843783          	ld	a5,-40(s0)
ffffffe00020082c:	0187b783          	ld	a5,24(a5)
ffffffe000200830:	00003697          	auipc	a3,0x3
ffffffe000200834:	9b068693          	addi	a3,a3,-1616 # ffffffe0002031e0 <__func__.2>
ffffffe000200838:	06600613          	li	a2,102
ffffffe00020083c:	00003597          	auipc	a1,0x3
ffffffe000200840:	86c58593          	addi	a1,a1,-1940 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe000200844:	00003517          	auipc	a0,0x3
ffffffe000200848:	8e450513          	addi	a0,a0,-1820 # ffffffe000203128 <__func__.0+0xa8>
ffffffe00020084c:	355010ef          	jal	ffffffe0002023a0 <printk>
    if(current->pid != next->pid) {
ffffffe000200850:	00005797          	auipc	a5,0x5
ffffffe000200854:	7c078793          	addi	a5,a5,1984 # ffffffe000206010 <current>
ffffffe000200858:	0007b783          	ld	a5,0(a5)
ffffffe00020085c:	0187b703          	ld	a4,24(a5)
ffffffe000200860:	fd843783          	ld	a5,-40(s0)
ffffffe000200864:	0187b783          	ld	a5,24(a5)
ffffffe000200868:	06f70a63          	beq	a4,a5,ffffffe0002008dc <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe00020086c:	00005797          	auipc	a5,0x5
ffffffe000200870:	7a478793          	addi	a5,a5,1956 # ffffffe000206010 <current>
ffffffe000200874:	0007b783          	ld	a5,0(a5)
ffffffe000200878:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe00020087c:	00005797          	auipc	a5,0x5
ffffffe000200880:	79478793          	addi	a5,a5,1940 # ffffffe000206010 <current>
ffffffe000200884:	fd843703          	ld	a4,-40(s0)
ffffffe000200888:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe00020088c:	00005797          	auipc	a5,0x5
ffffffe000200890:	78478793          	addi	a5,a5,1924 # ffffffe000206010 <current>
ffffffe000200894:	0007b783          	ld	a5,0(a5)
ffffffe000200898:	0187b703          	ld	a4,24(a5)
ffffffe00020089c:	00005797          	auipc	a5,0x5
ffffffe0002008a0:	77478793          	addi	a5,a5,1908 # ffffffe000206010 <current>
ffffffe0002008a4:	0007b783          	ld	a5,0(a5)
ffffffe0002008a8:	0107b603          	ld	a2,16(a5)
ffffffe0002008ac:	00005797          	auipc	a5,0x5
ffffffe0002008b0:	76478793          	addi	a5,a5,1892 # ffffffe000206010 <current>
ffffffe0002008b4:	0007b783          	ld	a5,0(a5)
ffffffe0002008b8:	0087b783          	ld	a5,8(a5)
ffffffe0002008bc:	00078693          	mv	a3,a5
ffffffe0002008c0:	00070593          	mv	a1,a4
ffffffe0002008c4:	00003517          	auipc	a0,0x3
ffffffe0002008c8:	8a450513          	addi	a0,a0,-1884 # ffffffe000203168 <__func__.0+0xe8>
ffffffe0002008cc:	2d5010ef          	jal	ffffffe0002023a0 <printk>
        __switch_to(prev, next);
ffffffe0002008d0:	fd843583          	ld	a1,-40(s0)
ffffffe0002008d4:	fe843503          	ld	a0,-24(s0)
ffffffe0002008d8:	8d9ff0ef          	jal	ffffffe0002001b0 <__switch_to>
    }
}
ffffffe0002008dc:	00000013          	nop
ffffffe0002008e0:	02813083          	ld	ra,40(sp)
ffffffe0002008e4:	02013403          	ld	s0,32(sp)
ffffffe0002008e8:	03010113          	addi	sp,sp,48
ffffffe0002008ec:	00008067          	ret

ffffffe0002008f0 <do_timer>:

void do_timer() {
ffffffe0002008f0:	ff010113          	addi	sp,sp,-16
ffffffe0002008f4:	00113423          	sd	ra,8(sp)
ffffffe0002008f8:	00813023          	sd	s0,0(sp)
ffffffe0002008fc:	01010413          	addi	s0,sp,16
    LOG(RED);
ffffffe000200900:	00003697          	auipc	a3,0x3
ffffffe000200904:	8f068693          	addi	a3,a3,-1808 # ffffffe0002031f0 <__func__.1>
ffffffe000200908:	07000613          	li	a2,112
ffffffe00020090c:	00002597          	auipc	a1,0x2
ffffffe000200910:	79c58593          	addi	a1,a1,1948 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe000200914:	00002517          	auipc	a0,0x2
ffffffe000200918:	79c50513          	addi	a0,a0,1948 # ffffffe0002030b0 <__func__.0+0x30>
ffffffe00020091c:	285010ef          	jal	ffffffe0002023a0 <printk>
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe000200920:	00005797          	auipc	a5,0x5
ffffffe000200924:	6f078793          	addi	a5,a5,1776 # ffffffe000206010 <current>
ffffffe000200928:	0007b783          	ld	a5,0(a5)
ffffffe00020092c:	0187b703          	ld	a4,24(a5)
ffffffe000200930:	00005797          	auipc	a5,0x5
ffffffe000200934:	6d878793          	addi	a5,a5,1752 # ffffffe000206008 <idle>
ffffffe000200938:	0007b783          	ld	a5,0(a5)
ffffffe00020093c:	0187b783          	ld	a5,24(a5)
ffffffe000200940:	00f70c63          	beq	a4,a5,ffffffe000200958 <do_timer+0x68>
ffffffe000200944:	00005797          	auipc	a5,0x5
ffffffe000200948:	6cc78793          	addi	a5,a5,1740 # ffffffe000206010 <current>
ffffffe00020094c:	0007b783          	ld	a5,0(a5)
ffffffe000200950:	0087b783          	ld	a5,8(a5)
ffffffe000200954:	00079663          	bnez	a5,ffffffe000200960 <do_timer+0x70>
        schedule();
ffffffe000200958:	038000ef          	jal	ffffffe000200990 <schedule>
ffffffe00020095c:	0200006f          	j	ffffffe00020097c <do_timer+0x8c>
    }
    else --(current->counter);
ffffffe000200960:	00005797          	auipc	a5,0x5
ffffffe000200964:	6b078793          	addi	a5,a5,1712 # ffffffe000206010 <current>
ffffffe000200968:	0007b783          	ld	a5,0(a5)
ffffffe00020096c:	0087b703          	ld	a4,8(a5)
ffffffe000200970:	fff70713          	addi	a4,a4,-1
ffffffe000200974:	00e7b423          	sd	a4,8(a5)
}
ffffffe000200978:	00000013          	nop
ffffffe00020097c:	00000013          	nop
ffffffe000200980:	00813083          	ld	ra,8(sp)
ffffffe000200984:	00013403          	ld	s0,0(sp)
ffffffe000200988:	01010113          	addi	sp,sp,16
ffffffe00020098c:	00008067          	ret

ffffffe000200990 <schedule>:

void schedule() {
ffffffe000200990:	fe010113          	addi	sp,sp,-32
ffffffe000200994:	00113c23          	sd	ra,24(sp)
ffffffe000200998:	00813823          	sd	s0,16(sp)
ffffffe00020099c:	02010413          	addi	s0,sp,32
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    LOG(RED);
ffffffe0002009a0:	00003697          	auipc	a3,0x3
ffffffe0002009a4:	86068693          	addi	a3,a3,-1952 # ffffffe000203200 <__func__.0>
ffffffe0002009a8:	07f00613          	li	a2,127
ffffffe0002009ac:	00002597          	auipc	a1,0x2
ffffffe0002009b0:	6fc58593          	addi	a1,a1,1788 # ffffffe0002030a8 <__func__.0+0x28>
ffffffe0002009b4:	00002517          	auipc	a0,0x2
ffffffe0002009b8:	6fc50513          	addi	a0,a0,1788 # ffffffe0002030b0 <__func__.0+0x30>
ffffffe0002009bc:	1e5010ef          	jal	ffffffe0002023a0 <printk>
    struct task_struct *next = idle;
ffffffe0002009c0:	00005797          	auipc	a5,0x5
ffffffe0002009c4:	64878793          	addi	a5,a5,1608 # ffffffe000206008 <idle>
ffffffe0002009c8:	0007b783          	ld	a5,0(a5)
ffffffe0002009cc:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe0002009d0:	00100793          	li	a5,1
ffffffe0002009d4:	fef42223          	sw	a5,-28(s0)
ffffffe0002009d8:	0540006f          	j	ffffffe000200a2c <schedule+0x9c>
        if(task[i]->counter > next->counter){
ffffffe0002009dc:	00005717          	auipc	a4,0x5
ffffffe0002009e0:	64470713          	addi	a4,a4,1604 # ffffffe000206020 <task>
ffffffe0002009e4:	fe442783          	lw	a5,-28(s0)
ffffffe0002009e8:	00379793          	slli	a5,a5,0x3
ffffffe0002009ec:	00f707b3          	add	a5,a4,a5
ffffffe0002009f0:	0007b783          	ld	a5,0(a5)
ffffffe0002009f4:	0087b703          	ld	a4,8(a5)
ffffffe0002009f8:	fe843783          	ld	a5,-24(s0)
ffffffe0002009fc:	0087b783          	ld	a5,8(a5)
ffffffe000200a00:	02e7f063          	bgeu	a5,a4,ffffffe000200a20 <schedule+0x90>
            next = task[i];
ffffffe000200a04:	00005717          	auipc	a4,0x5
ffffffe000200a08:	61c70713          	addi	a4,a4,1564 # ffffffe000206020 <task>
ffffffe000200a0c:	fe442783          	lw	a5,-28(s0)
ffffffe000200a10:	00379793          	slli	a5,a5,0x3
ffffffe000200a14:	00f707b3          	add	a5,a4,a5
ffffffe000200a18:	0007b783          	ld	a5,0(a5)
ffffffe000200a1c:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a20:	fe442783          	lw	a5,-28(s0)
ffffffe000200a24:	0017879b          	addiw	a5,a5,1
ffffffe000200a28:	fef42223          	sw	a5,-28(s0)
ffffffe000200a2c:	fe442783          	lw	a5,-28(s0)
ffffffe000200a30:	0007871b          	sext.w	a4,a5
ffffffe000200a34:	01f00793          	li	a5,31
ffffffe000200a38:	fae7d2e3          	bge	a5,a4,ffffffe0002009dc <schedule+0x4c>
        }
    }

    if(next->counter == 0) {
ffffffe000200a3c:	fe843783          	ld	a5,-24(s0)
ffffffe000200a40:	0087b783          	ld	a5,8(a5)
ffffffe000200a44:	0c079e63          	bnez	a5,ffffffe000200b20 <schedule+0x190>
        printk("\n");
ffffffe000200a48:	00002517          	auipc	a0,0x2
ffffffe000200a4c:	75850513          	addi	a0,a0,1880 # ffffffe0002031a0 <__func__.0+0x120>
ffffffe000200a50:	151010ef          	jal	ffffffe0002023a0 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a54:	00100793          	li	a5,1
ffffffe000200a58:	fef42023          	sw	a5,-32(s0)
ffffffe000200a5c:	0ac0006f          	j	ffffffe000200b08 <schedule+0x178>
            task[i]->counter = task[i]->priority;
ffffffe000200a60:	00005717          	auipc	a4,0x5
ffffffe000200a64:	5c070713          	addi	a4,a4,1472 # ffffffe000206020 <task>
ffffffe000200a68:	fe042783          	lw	a5,-32(s0)
ffffffe000200a6c:	00379793          	slli	a5,a5,0x3
ffffffe000200a70:	00f707b3          	add	a5,a4,a5
ffffffe000200a74:	0007b703          	ld	a4,0(a5)
ffffffe000200a78:	00005697          	auipc	a3,0x5
ffffffe000200a7c:	5a868693          	addi	a3,a3,1448 # ffffffe000206020 <task>
ffffffe000200a80:	fe042783          	lw	a5,-32(s0)
ffffffe000200a84:	00379793          	slli	a5,a5,0x3
ffffffe000200a88:	00f687b3          	add	a5,a3,a5
ffffffe000200a8c:	0007b783          	ld	a5,0(a5)
ffffffe000200a90:	01073703          	ld	a4,16(a4)
ffffffe000200a94:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200a98:	00005717          	auipc	a4,0x5
ffffffe000200a9c:	58870713          	addi	a4,a4,1416 # ffffffe000206020 <task>
ffffffe000200aa0:	fe042783          	lw	a5,-32(s0)
ffffffe000200aa4:	00379793          	slli	a5,a5,0x3
ffffffe000200aa8:	00f707b3          	add	a5,a4,a5
ffffffe000200aac:	0007b783          	ld	a5,0(a5)
ffffffe000200ab0:	0187b583          	ld	a1,24(a5)
ffffffe000200ab4:	00005717          	auipc	a4,0x5
ffffffe000200ab8:	56c70713          	addi	a4,a4,1388 # ffffffe000206020 <task>
ffffffe000200abc:	fe042783          	lw	a5,-32(s0)
ffffffe000200ac0:	00379793          	slli	a5,a5,0x3
ffffffe000200ac4:	00f707b3          	add	a5,a4,a5
ffffffe000200ac8:	0007b783          	ld	a5,0(a5)
ffffffe000200acc:	0107b603          	ld	a2,16(a5)
ffffffe000200ad0:	00005717          	auipc	a4,0x5
ffffffe000200ad4:	55070713          	addi	a4,a4,1360 # ffffffe000206020 <task>
ffffffe000200ad8:	fe042783          	lw	a5,-32(s0)
ffffffe000200adc:	00379793          	slli	a5,a5,0x3
ffffffe000200ae0:	00f707b3          	add	a5,a4,a5
ffffffe000200ae4:	0007b783          	ld	a5,0(a5)
ffffffe000200ae8:	0087b783          	ld	a5,8(a5)
ffffffe000200aec:	00078693          	mv	a3,a5
ffffffe000200af0:	00002517          	auipc	a0,0x2
ffffffe000200af4:	6b850513          	addi	a0,a0,1720 # ffffffe0002031a8 <__func__.0+0x128>
ffffffe000200af8:	0a9010ef          	jal	ffffffe0002023a0 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200afc:	fe042783          	lw	a5,-32(s0)
ffffffe000200b00:	0017879b          	addiw	a5,a5,1
ffffffe000200b04:	fef42023          	sw	a5,-32(s0)
ffffffe000200b08:	fe042783          	lw	a5,-32(s0)
ffffffe000200b0c:	0007871b          	sext.w	a4,a5
ffffffe000200b10:	01f00793          	li	a5,31
ffffffe000200b14:	f4e7d6e3          	bge	a5,a4,ffffffe000200a60 <schedule+0xd0>
        }
        schedule();
ffffffe000200b18:	e79ff0ef          	jal	ffffffe000200990 <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200b1c:	00c0006f          	j	ffffffe000200b28 <schedule+0x198>
        switch_to(next);
ffffffe000200b20:	fe843503          	ld	a0,-24(s0)
ffffffe000200b24:	cc1ff0ef          	jal	ffffffe0002007e4 <switch_to>
ffffffe000200b28:	00000013          	nop
ffffffe000200b2c:	01813083          	ld	ra,24(sp)
ffffffe000200b30:	01013403          	ld	s0,16(sp)
ffffffe000200b34:	02010113          	addi	sp,sp,32
ffffffe000200b38:	00008067          	ret

ffffffe000200b3c <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200b3c:	f7010113          	addi	sp,sp,-144
ffffffe000200b40:	08113423          	sd	ra,136(sp)
ffffffe000200b44:	08813023          	sd	s0,128(sp)
ffffffe000200b48:	06913c23          	sd	s1,120(sp)
ffffffe000200b4c:	07213823          	sd	s2,112(sp)
ffffffe000200b50:	07313423          	sd	s3,104(sp)
ffffffe000200b54:	09010413          	addi	s0,sp,144
ffffffe000200b58:	faa43423          	sd	a0,-88(s0)
ffffffe000200b5c:	fab43023          	sd	a1,-96(s0)
ffffffe000200b60:	f8c43c23          	sd	a2,-104(s0)
ffffffe000200b64:	f8d43823          	sd	a3,-112(s0)
ffffffe000200b68:	f8e43423          	sd	a4,-120(s0)
ffffffe000200b6c:	f8f43023          	sd	a5,-128(s0)
ffffffe000200b70:	f7043c23          	sd	a6,-136(s0)
ffffffe000200b74:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200b78:	fa843e03          	ld	t3,-88(s0)
ffffffe000200b7c:	fa043e83          	ld	t4,-96(s0)
ffffffe000200b80:	f9843f03          	ld	t5,-104(s0)
ffffffe000200b84:	f9043f83          	ld	t6,-112(s0)
ffffffe000200b88:	f8843283          	ld	t0,-120(s0)
ffffffe000200b8c:	f8043483          	ld	s1,-128(s0)
ffffffe000200b90:	f7843903          	ld	s2,-136(s0)
ffffffe000200b94:	f7043983          	ld	s3,-144(s0)
ffffffe000200b98:	000e0893          	mv	a7,t3
ffffffe000200b9c:	000e8813          	mv	a6,t4
ffffffe000200ba0:	000f0513          	mv	a0,t5
ffffffe000200ba4:	000f8593          	mv	a1,t6
ffffffe000200ba8:	00028613          	mv	a2,t0
ffffffe000200bac:	00048693          	mv	a3,s1
ffffffe000200bb0:	00090713          	mv	a4,s2
ffffffe000200bb4:	00098793          	mv	a5,s3
ffffffe000200bb8:	00000073          	ecall
ffffffe000200bbc:	00050e93          	mv	t4,a0
ffffffe000200bc0:	00058e13          	mv	t3,a1
ffffffe000200bc4:	fbd43823          	sd	t4,-80(s0)
ffffffe000200bc8:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200bcc:	fb043783          	ld	a5,-80(s0)
ffffffe000200bd0:	fcf43023          	sd	a5,-64(s0)
ffffffe000200bd4:	fb843783          	ld	a5,-72(s0)
ffffffe000200bd8:	fcf43423          	sd	a5,-56(s0)
ffffffe000200bdc:	fc043703          	ld	a4,-64(s0)
ffffffe000200be0:	fc843783          	ld	a5,-56(s0)
ffffffe000200be4:	00070313          	mv	t1,a4
ffffffe000200be8:	00078393          	mv	t2,a5
ffffffe000200bec:	00030713          	mv	a4,t1
ffffffe000200bf0:	00038793          	mv	a5,t2
}
ffffffe000200bf4:	00070513          	mv	a0,a4
ffffffe000200bf8:	00078593          	mv	a1,a5
ffffffe000200bfc:	08813083          	ld	ra,136(sp)
ffffffe000200c00:	08013403          	ld	s0,128(sp)
ffffffe000200c04:	07813483          	ld	s1,120(sp)
ffffffe000200c08:	07013903          	ld	s2,112(sp)
ffffffe000200c0c:	06813983          	ld	s3,104(sp)
ffffffe000200c10:	09010113          	addi	sp,sp,144
ffffffe000200c14:	00008067          	ret

ffffffe000200c18 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200c18:	fc010113          	addi	sp,sp,-64
ffffffe000200c1c:	02113c23          	sd	ra,56(sp)
ffffffe000200c20:	02813823          	sd	s0,48(sp)
ffffffe000200c24:	03213423          	sd	s2,40(sp)
ffffffe000200c28:	03313023          	sd	s3,32(sp)
ffffffe000200c2c:	04010413          	addi	s0,sp,64
ffffffe000200c30:	00050793          	mv	a5,a0
ffffffe000200c34:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200c38:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200c3c:	00000893          	li	a7,0
ffffffe000200c40:	00000813          	li	a6,0
ffffffe000200c44:	00000793          	li	a5,0
ffffffe000200c48:	00000713          	li	a4,0
ffffffe000200c4c:	00000693          	li	a3,0
ffffffe000200c50:	00200593          	li	a1,2
ffffffe000200c54:	44424537          	lui	a0,0x44424
ffffffe000200c58:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200c5c:	ee1ff0ef          	jal	ffffffe000200b3c <sbi_ecall>
ffffffe000200c60:	00050713          	mv	a4,a0
ffffffe000200c64:	00058793          	mv	a5,a1
ffffffe000200c68:	fce43823          	sd	a4,-48(s0)
ffffffe000200c6c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c70:	fd043703          	ld	a4,-48(s0)
ffffffe000200c74:	fd843783          	ld	a5,-40(s0)
ffffffe000200c78:	00070913          	mv	s2,a4
ffffffe000200c7c:	00078993          	mv	s3,a5
ffffffe000200c80:	00090713          	mv	a4,s2
ffffffe000200c84:	00098793          	mv	a5,s3
}
ffffffe000200c88:	00070513          	mv	a0,a4
ffffffe000200c8c:	00078593          	mv	a1,a5
ffffffe000200c90:	03813083          	ld	ra,56(sp)
ffffffe000200c94:	03013403          	ld	s0,48(sp)
ffffffe000200c98:	02813903          	ld	s2,40(sp)
ffffffe000200c9c:	02013983          	ld	s3,32(sp)
ffffffe000200ca0:	04010113          	addi	sp,sp,64
ffffffe000200ca4:	00008067          	ret

ffffffe000200ca8 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200ca8:	fc010113          	addi	sp,sp,-64
ffffffe000200cac:	02113c23          	sd	ra,56(sp)
ffffffe000200cb0:	02813823          	sd	s0,48(sp)
ffffffe000200cb4:	03213423          	sd	s2,40(sp)
ffffffe000200cb8:	03313023          	sd	s3,32(sp)
ffffffe000200cbc:	04010413          	addi	s0,sp,64
ffffffe000200cc0:	00050793          	mv	a5,a0
ffffffe000200cc4:	00058713          	mv	a4,a1
ffffffe000200cc8:	fcf42623          	sw	a5,-52(s0)
ffffffe000200ccc:	00070793          	mv	a5,a4
ffffffe000200cd0:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200cd4:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200cd8:	fc846683          	lwu	a3,-56(s0)
ffffffe000200cdc:	00000893          	li	a7,0
ffffffe000200ce0:	00000813          	li	a6,0
ffffffe000200ce4:	00000793          	li	a5,0
ffffffe000200ce8:	00000713          	li	a4,0
ffffffe000200cec:	00000593          	li	a1,0
ffffffe000200cf0:	53525537          	lui	a0,0x53525
ffffffe000200cf4:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200cf8:	e45ff0ef          	jal	ffffffe000200b3c <sbi_ecall>
ffffffe000200cfc:	00050713          	mv	a4,a0
ffffffe000200d00:	00058793          	mv	a5,a1
ffffffe000200d04:	fce43823          	sd	a4,-48(s0)
ffffffe000200d08:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d0c:	fd043703          	ld	a4,-48(s0)
ffffffe000200d10:	fd843783          	ld	a5,-40(s0)
ffffffe000200d14:	00070913          	mv	s2,a4
ffffffe000200d18:	00078993          	mv	s3,a5
ffffffe000200d1c:	00090713          	mv	a4,s2
ffffffe000200d20:	00098793          	mv	a5,s3
}
ffffffe000200d24:	00070513          	mv	a0,a4
ffffffe000200d28:	00078593          	mv	a1,a5
ffffffe000200d2c:	03813083          	ld	ra,56(sp)
ffffffe000200d30:	03013403          	ld	s0,48(sp)
ffffffe000200d34:	02813903          	ld	s2,40(sp)
ffffffe000200d38:	02013983          	ld	s3,32(sp)
ffffffe000200d3c:	04010113          	addi	sp,sp,64
ffffffe000200d40:	00008067          	ret

ffffffe000200d44 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200d44:	fc010113          	addi	sp,sp,-64
ffffffe000200d48:	02113c23          	sd	ra,56(sp)
ffffffe000200d4c:	02813823          	sd	s0,48(sp)
ffffffe000200d50:	03213423          	sd	s2,40(sp)
ffffffe000200d54:	03313023          	sd	s3,32(sp)
ffffffe000200d58:	04010413          	addi	s0,sp,64
ffffffe000200d5c:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200d60:	00000893          	li	a7,0
ffffffe000200d64:	00000813          	li	a6,0
ffffffe000200d68:	00000793          	li	a5,0
ffffffe000200d6c:	00000713          	li	a4,0
ffffffe000200d70:	00000693          	li	a3,0
ffffffe000200d74:	fc843603          	ld	a2,-56(s0)
ffffffe000200d78:	00000593          	li	a1,0
ffffffe000200d7c:	54495537          	lui	a0,0x54495
ffffffe000200d80:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200d84:	db9ff0ef          	jal	ffffffe000200b3c <sbi_ecall>
ffffffe000200d88:	00050713          	mv	a4,a0
ffffffe000200d8c:	00058793          	mv	a5,a1
ffffffe000200d90:	fce43823          	sd	a4,-48(s0)
ffffffe000200d94:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d98:	fd043703          	ld	a4,-48(s0)
ffffffe000200d9c:	fd843783          	ld	a5,-40(s0)
ffffffe000200da0:	00070913          	mv	s2,a4
ffffffe000200da4:	00078993          	mv	s3,a5
ffffffe000200da8:	00090713          	mv	a4,s2
ffffffe000200dac:	00098793          	mv	a5,s3
}
ffffffe000200db0:	00070513          	mv	a0,a4
ffffffe000200db4:	00078593          	mv	a1,a5
ffffffe000200db8:	03813083          	ld	ra,56(sp)
ffffffe000200dbc:	03013403          	ld	s0,48(sp)
ffffffe000200dc0:	02813903          	ld	s2,40(sp)
ffffffe000200dc4:	02013983          	ld	s3,32(sp)
ffffffe000200dc8:	04010113          	addi	sp,sp,64
ffffffe000200dcc:	00008067          	ret

ffffffe000200dd0 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200dd0:	fb010113          	addi	sp,sp,-80
ffffffe000200dd4:	04113423          	sd	ra,72(sp)
ffffffe000200dd8:	04813023          	sd	s0,64(sp)
ffffffe000200ddc:	03213c23          	sd	s2,56(sp)
ffffffe000200de0:	03313823          	sd	s3,48(sp)
ffffffe000200de4:	05010413          	addi	s0,sp,80
ffffffe000200de8:	fca43423          	sd	a0,-56(s0)
ffffffe000200dec:	fcb43023          	sd	a1,-64(s0)
ffffffe000200df0:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200df4:	00000893          	li	a7,0
ffffffe000200df8:	00000813          	li	a6,0
ffffffe000200dfc:	00000793          	li	a5,0
ffffffe000200e00:	fb843703          	ld	a4,-72(s0)
ffffffe000200e04:	fc043683          	ld	a3,-64(s0)
ffffffe000200e08:	fc843603          	ld	a2,-56(s0)
ffffffe000200e0c:	00100593          	li	a1,1
ffffffe000200e10:	44424537          	lui	a0,0x44424
ffffffe000200e14:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e18:	d25ff0ef          	jal	ffffffe000200b3c <sbi_ecall>
ffffffe000200e1c:	00050713          	mv	a4,a0
ffffffe000200e20:	00058793          	mv	a5,a1
ffffffe000200e24:	fce43823          	sd	a4,-48(s0)
ffffffe000200e28:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e2c:	fd043703          	ld	a4,-48(s0)
ffffffe000200e30:	fd843783          	ld	a5,-40(s0)
ffffffe000200e34:	00070913          	mv	s2,a4
ffffffe000200e38:	00078993          	mv	s3,a5
ffffffe000200e3c:	00090713          	mv	a4,s2
ffffffe000200e40:	00098793          	mv	a5,s3
}
ffffffe000200e44:	00070513          	mv	a0,a4
ffffffe000200e48:	00078593          	mv	a1,a5
ffffffe000200e4c:	04813083          	ld	ra,72(sp)
ffffffe000200e50:	04013403          	ld	s0,64(sp)
ffffffe000200e54:	03813903          	ld	s2,56(sp)
ffffffe000200e58:	03013983          	ld	s3,48(sp)
ffffffe000200e5c:	05010113          	addi	sp,sp,80
ffffffe000200e60:	00008067          	ret

ffffffe000200e64 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200e64:	fb010113          	addi	sp,sp,-80
ffffffe000200e68:	04113423          	sd	ra,72(sp)
ffffffe000200e6c:	04813023          	sd	s0,64(sp)
ffffffe000200e70:	03213c23          	sd	s2,56(sp)
ffffffe000200e74:	03313823          	sd	s3,48(sp)
ffffffe000200e78:	05010413          	addi	s0,sp,80
ffffffe000200e7c:	fca43423          	sd	a0,-56(s0)
ffffffe000200e80:	fcb43023          	sd	a1,-64(s0)
ffffffe000200e84:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e88:	00000893          	li	a7,0
ffffffe000200e8c:	00000813          	li	a6,0
ffffffe000200e90:	00000793          	li	a5,0
ffffffe000200e94:	fb843703          	ld	a4,-72(s0)
ffffffe000200e98:	fc043683          	ld	a3,-64(s0)
ffffffe000200e9c:	fc843603          	ld	a2,-56(s0)
ffffffe000200ea0:	00000593          	li	a1,0
ffffffe000200ea4:	44424537          	lui	a0,0x44424
ffffffe000200ea8:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200eac:	c91ff0ef          	jal	ffffffe000200b3c <sbi_ecall>
ffffffe000200eb0:	00050713          	mv	a4,a0
ffffffe000200eb4:	00058793          	mv	a5,a1
ffffffe000200eb8:	fce43823          	sd	a4,-48(s0)
ffffffe000200ebc:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ec0:	fd043703          	ld	a4,-48(s0)
ffffffe000200ec4:	fd843783          	ld	a5,-40(s0)
ffffffe000200ec8:	00070913          	mv	s2,a4
ffffffe000200ecc:	00078993          	mv	s3,a5
ffffffe000200ed0:	00090713          	mv	a4,s2
ffffffe000200ed4:	00098793          	mv	a5,s3
ffffffe000200ed8:	00070513          	mv	a0,a4
ffffffe000200edc:	00078593          	mv	a1,a5
ffffffe000200ee0:	04813083          	ld	ra,72(sp)
ffffffe000200ee4:	04013403          	ld	s0,64(sp)
ffffffe000200ee8:	03813903          	ld	s2,56(sp)
ffffffe000200eec:	03013983          	ld	s3,48(sp)
ffffffe000200ef0:	05010113          	addi	sp,sp,80
ffffffe000200ef4:	00008067          	ret

ffffffe000200ef8 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200ef8:	fe010113          	addi	sp,sp,-32
ffffffe000200efc:	00113c23          	sd	ra,24(sp)
ffffffe000200f00:	00813823          	sd	s0,16(sp)
ffffffe000200f04:	02010413          	addi	s0,sp,32
ffffffe000200f08:	fea43423          	sd	a0,-24(s0)
ffffffe000200f0c:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200f10:	fe843783          	ld	a5,-24(s0)
ffffffe000200f14:	0207d063          	bgez	a5,ffffffe000200f34 <trap_handler+0x3c>
ffffffe000200f18:	fe843783          	ld	a5,-24(s0)
ffffffe000200f1c:	0ff7f713          	zext.b	a4,a5
ffffffe000200f20:	00500793          	li	a5,5
ffffffe000200f24:	00f71863          	bne	a4,a5,ffffffe000200f34 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200f28:	b34ff0ef          	jal	ffffffe00020025c <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200f2c:	9c5ff0ef          	jal	ffffffe0002008f0 <do_timer>
ffffffe000200f30:	01c0006f          	j	ffffffe000200f4c <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200f34:	fe043603          	ld	a2,-32(s0)
ffffffe000200f38:	fe843583          	ld	a1,-24(s0)
ffffffe000200f3c:	00002517          	auipc	a0,0x2
ffffffe000200f40:	2d450513          	addi	a0,a0,724 # ffffffe000203210 <__func__.0+0x10>
ffffffe000200f44:	45c010ef          	jal	ffffffe0002023a0 <printk>
    }
ffffffe000200f48:	00000013          	nop
ffffffe000200f4c:	00000013          	nop
ffffffe000200f50:	01813083          	ld	ra,24(sp)
ffffffe000200f54:	01013403          	ld	s0,16(sp)
ffffffe000200f58:	02010113          	addi	sp,sp,32
ffffffe000200f5c:	00008067          	ret

ffffffe000200f60 <setup_vm>:
extern char _srodata[], _erodata[];

/* early_pgtbl: 用于 setup_vm 进行 1GiB 的映射 */
uint64_t early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm() {
ffffffe000200f60:	fe010113          	addi	sp,sp,-32
ffffffe000200f64:	00113c23          	sd	ra,24(sp)
ffffffe000200f68:	00813823          	sd	s0,16(sp)
ffffffe000200f6c:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200f70:	00001637          	lui	a2,0x1
ffffffe000200f74:	00000593          	li	a1,0
ffffffe000200f78:	00006517          	auipc	a0,0x6
ffffffe000200f7c:	08850513          	addi	a0,a0,136 # ffffffe000207000 <early_pgtbl>
ffffffe000200f80:	550010ef          	jal	ffffffe0002024d0 <memset>
    //     early_pgtbl[i] |= ((1 << 4) - 1);
    // }


    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff;
ffffffe000200f84:	00200793          	li	a5,2
ffffffe000200f88:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200f8c:	00006717          	auipc	a4,0x6
ffffffe000200f90:	07470713          	addi	a4,a4,116 # ffffffe000207000 <early_pgtbl>
ffffffe000200f94:	fe843783          	ld	a5,-24(s0)
ffffffe000200f98:	00379793          	slli	a5,a5,0x3
ffffffe000200f9c:	00f707b3          	add	a5,a4,a5
ffffffe000200fa0:	20000737          	lui	a4,0x20000
ffffffe000200fa4:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000200fa8:	00006717          	auipc	a4,0x6
ffffffe000200fac:	05870713          	addi	a4,a4,88 # ffffffe000207000 <early_pgtbl>
ffffffe000200fb0:	fe843783          	ld	a5,-24(s0)
ffffffe000200fb4:	00379793          	slli	a5,a5,0x3
ffffffe000200fb8:	00f707b3          	add	a5,a4,a5
ffffffe000200fbc:	0007b783          	ld	a5,0(a5)
ffffffe000200fc0:	00f7e713          	ori	a4,a5,15
ffffffe000200fc4:	00006697          	auipc	a3,0x6
ffffffe000200fc8:	03c68693          	addi	a3,a3,60 # ffffffe000207000 <early_pgtbl>
ffffffe000200fcc:	fe843783          	ld	a5,-24(s0)
ffffffe000200fd0:	00379793          	slli	a5,a5,0x3
ffffffe000200fd4:	00f687b3          	add	a5,a3,a5
ffffffe000200fd8:	00e7b023          	sd	a4,0(a5)


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;
ffffffe000200fdc:	18000793          	li	a5,384
ffffffe000200fe0:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10;
ffffffe000200fe4:	00006717          	auipc	a4,0x6
ffffffe000200fe8:	01c70713          	addi	a4,a4,28 # ffffffe000207000 <early_pgtbl>
ffffffe000200fec:	fe843783          	ld	a5,-24(s0)
ffffffe000200ff0:	00379793          	slli	a5,a5,0x3
ffffffe000200ff4:	00f707b3          	add	a5,a4,a5
ffffffe000200ff8:	20000737          	lui	a4,0x20000
ffffffe000200ffc:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);
ffffffe000201000:	00006717          	auipc	a4,0x6
ffffffe000201004:	00070713          	mv	a4,a4
ffffffe000201008:	fe843783          	ld	a5,-24(s0)
ffffffe00020100c:	00379793          	slli	a5,a5,0x3
ffffffe000201010:	00f707b3          	add	a5,a4,a5
ffffffe000201014:	0007b783          	ld	a5,0(a5)
ffffffe000201018:	00f7e713          	ori	a4,a5,15
ffffffe00020101c:	00006697          	auipc	a3,0x6
ffffffe000201020:	fe468693          	addi	a3,a3,-28 # ffffffe000207000 <early_pgtbl>
ffffffe000201024:	fe843783          	ld	a5,-24(s0)
ffffffe000201028:	00379793          	slli	a5,a5,0x3
ffffffe00020102c:	00f687b3          	add	a5,a3,a5
ffffffe000201030:	00e7b023          	sd	a4,0(a5)

    printk("...setup_vm done!\n");
ffffffe000201034:	00002517          	auipc	a0,0x2
ffffffe000201038:	21c50513          	addi	a0,a0,540 # ffffffe000203250 <__func__.0+0x50>
ffffffe00020103c:	364010ef          	jal	ffffffe0002023a0 <printk>
}
ffffffe000201040:	00000013          	nop
ffffffe000201044:	01813083          	ld	ra,24(sp)
ffffffe000201048:	01013403          	ld	s0,16(sp)
ffffffe00020104c:	02010113          	addi	sp,sp,32
ffffffe000201050:	00008067          	ret

ffffffe000201054 <setup_vm_final>:

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
ffffffe000201054:	ff010113          	addi	sp,sp,-16
ffffffe000201058:	00113423          	sd	ra,8(sp)
ffffffe00020105c:	00813023          	sd	s0,0(sp)
ffffffe000201060:	01010413          	addi	s0,sp,16
    memset(swapper_pg_dir, 0x0, PGSIZE);
ffffffe000201064:	00001637          	lui	a2,0x1
ffffffe000201068:	00000593          	li	a1,0
ffffffe00020106c:	00007517          	auipc	a0,0x7
ffffffe000201070:	f9450513          	addi	a0,a0,-108 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201074:	45c010ef          	jal	ffffffe0002024d0 <memset>

    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    LOG(BLUE "_stext: %p, _etext: %p" CLEAR, _stext, _etext);
ffffffe000201078:	00001797          	auipc	a5,0x1
ffffffe00020107c:	4d078793          	addi	a5,a5,1232 # ffffffe000202548 <_etext>
ffffffe000201080:	fffff717          	auipc	a4,0xfffff
ffffffe000201084:	f8070713          	addi	a4,a4,-128 # ffffffe000200000 <_skernel>
ffffffe000201088:	00002697          	auipc	a3,0x2
ffffffe00020108c:	2d868693          	addi	a3,a3,728 # ffffffe000203360 <__func__.1>
ffffffe000201090:	04f00613          	li	a2,79
ffffffe000201094:	00002597          	auipc	a1,0x2
ffffffe000201098:	1d458593          	addi	a1,a1,468 # ffffffe000203268 <__func__.0+0x68>
ffffffe00020109c:	00002517          	auipc	a0,0x2
ffffffe0002010a0:	1d450513          	addi	a0,a0,468 # ffffffe000203270 <__func__.0+0x70>
ffffffe0002010a4:	2fc010ef          	jal	ffffffe0002023a0 <printk>
    LOG(BLUE "_srodata: %p, _erodata: %p" CLEAR, _srodata, _erodata);
ffffffe0002010a8:	00002797          	auipc	a5,0x2
ffffffe0002010ac:	37078793          	addi	a5,a5,880 # ffffffe000203418 <_erodata>
ffffffe0002010b0:	00002717          	auipc	a4,0x2
ffffffe0002010b4:	f5070713          	addi	a4,a4,-176 # ffffffe000203000 <__func__.3>
ffffffe0002010b8:	00002697          	auipc	a3,0x2
ffffffe0002010bc:	2a868693          	addi	a3,a3,680 # ffffffe000203360 <__func__.1>
ffffffe0002010c0:	05000613          	li	a2,80
ffffffe0002010c4:	00002597          	auipc	a1,0x2
ffffffe0002010c8:	1a458593          	addi	a1,a1,420 # ffffffe000203268 <__func__.0+0x68>
ffffffe0002010cc:	00002517          	auipc	a0,0x2
ffffffe0002010d0:	1dc50513          	addi	a0,a0,476 # ffffffe0002032a8 <__func__.0+0xa8>
ffffffe0002010d4:	2cc010ef          	jal	ffffffe0002023a0 <printk>
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);
ffffffe0002010d8:	fffff597          	auipc	a1,0xfffff
ffffffe0002010dc:	f2858593          	addi	a1,a1,-216 # ffffffe000200000 <_skernel>
ffffffe0002010e0:	fffff717          	auipc	a4,0xfffff
ffffffe0002010e4:	f2070713          	addi	a4,a4,-224 # ffffffe000200000 <_skernel>
ffffffe0002010e8:	04100793          	li	a5,65
ffffffe0002010ec:	01f79793          	slli	a5,a5,0x1f
ffffffe0002010f0:	00f70633          	add	a2,a4,a5
ffffffe0002010f4:	00001717          	auipc	a4,0x1
ffffffe0002010f8:	45470713          	addi	a4,a4,1108 # ffffffe000202548 <_etext>
ffffffe0002010fc:	fffff797          	auipc	a5,0xfffff
ffffffe000201100:	f0478793          	addi	a5,a5,-252 # ffffffe000200000 <_skernel>
ffffffe000201104:	40f707b3          	sub	a5,a4,a5
ffffffe000201108:	00b00713          	li	a4,11
ffffffe00020110c:	00078693          	mv	a3,a5
ffffffe000201110:	00007517          	auipc	a0,0x7
ffffffe000201114:	ef050513          	addi	a0,a0,-272 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201118:	108000ef          	jal	ffffffe000201220 <create_mapping>

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);
ffffffe00020111c:	00002597          	auipc	a1,0x2
ffffffe000201120:	ee458593          	addi	a1,a1,-284 # ffffffe000203000 <__func__.3>
ffffffe000201124:	00002717          	auipc	a4,0x2
ffffffe000201128:	edc70713          	addi	a4,a4,-292 # ffffffe000203000 <__func__.3>
ffffffe00020112c:	04100793          	li	a5,65
ffffffe000201130:	01f79793          	slli	a5,a5,0x1f
ffffffe000201134:	00f70633          	add	a2,a4,a5
ffffffe000201138:	00002717          	auipc	a4,0x2
ffffffe00020113c:	2e070713          	addi	a4,a4,736 # ffffffe000203418 <_erodata>
ffffffe000201140:	00002797          	auipc	a5,0x2
ffffffe000201144:	ec078793          	addi	a5,a5,-320 # ffffffe000203000 <__func__.3>
ffffffe000201148:	40f707b3          	sub	a5,a4,a5
ffffffe00020114c:	00300713          	li	a4,3
ffffffe000201150:	00078693          	mv	a3,a5
ffffffe000201154:	00007517          	auipc	a0,0x7
ffffffe000201158:	eac50513          	addi	a0,a0,-340 # ffffffe000208000 <swapper_pg_dir>
ffffffe00020115c:	0c4000ef          	jal	ffffffe000201220 <create_mapping>

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, PGROUNDUP((uint64_t)_erodata), PGROUNDUP((uint64_t)_erodata) - PA2VA_OFFSET, VM_END - PGROUNDUP((uint64_t)_erodata), 0b0111);
ffffffe000201160:	00002717          	auipc	a4,0x2
ffffffe000201164:	2b870713          	addi	a4,a4,696 # ffffffe000203418 <_erodata>
ffffffe000201168:	000017b7          	lui	a5,0x1
ffffffe00020116c:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe000201170:	00f70733          	add	a4,a4,a5
ffffffe000201174:	fffff7b7          	lui	a5,0xfffff
ffffffe000201178:	00f775b3          	and	a1,a4,a5
ffffffe00020117c:	00002717          	auipc	a4,0x2
ffffffe000201180:	29c70713          	addi	a4,a4,668 # ffffffe000203418 <_erodata>
ffffffe000201184:	000017b7          	lui	a5,0x1
ffffffe000201188:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe00020118c:	00f70733          	add	a4,a4,a5
ffffffe000201190:	fffff7b7          	lui	a5,0xfffff
ffffffe000201194:	00f77733          	and	a4,a4,a5
ffffffe000201198:	04100793          	li	a5,65
ffffffe00020119c:	01f79793          	slli	a5,a5,0x1f
ffffffe0002011a0:	00f70633          	add	a2,a4,a5
ffffffe0002011a4:	00002717          	auipc	a4,0x2
ffffffe0002011a8:	27470713          	addi	a4,a4,628 # ffffffe000203418 <_erodata>
ffffffe0002011ac:	000017b7          	lui	a5,0x1
ffffffe0002011b0:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002011b4:	00f70733          	add	a4,a4,a5
ffffffe0002011b8:	fffff7b7          	lui	a5,0xfffff
ffffffe0002011bc:	00f777b3          	and	a5,a4,a5
ffffffe0002011c0:	fff00713          	li	a4,-1
ffffffe0002011c4:	02071713          	slli	a4,a4,0x20
ffffffe0002011c8:	40f707b3          	sub	a5,a4,a5
ffffffe0002011cc:	00700713          	li	a4,7
ffffffe0002011d0:	00078693          	mv	a3,a5
ffffffe0002011d4:	00007517          	auipc	a0,0x7
ffffffe0002011d8:	e2c50513          	addi	a0,a0,-468 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002011dc:	044000ef          	jal	ffffffe000201220 <create_mapping>

    printk("...create_mapping done!\n");
ffffffe0002011e0:	00002517          	auipc	a0,0x2
ffffffe0002011e4:	10850513          	addi	a0,a0,264 # ffffffe0002032e8 <__func__.0+0xe8>
ffffffe0002011e8:	1b8010ef          	jal	ffffffe0002023a0 <printk>
    // set satp with swapper_pg_dir
    asm volatile("csrw satp, %0" :: "r"(((uint64_t)swapper_pg_dir >> 12) | (8llu << 60)));
ffffffe0002011ec:	00007797          	auipc	a5,0x7
ffffffe0002011f0:	e1478793          	addi	a5,a5,-492 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002011f4:	00c7d713          	srli	a4,a5,0xc
ffffffe0002011f8:	fff00793          	li	a5,-1
ffffffe0002011fc:	03f79793          	slli	a5,a5,0x3f
ffffffe000201200:	00f767b3          	or	a5,a4,a5
ffffffe000201204:	18079073          	csrw	satp,a5

    // YOUR CODE HERE

    // flush TLB
    asm volatile("sfence.vma zero, zero");
ffffffe000201208:	12000073          	sfence.vma

    // flush icache
    // asm volatile("fence.i");
    return;
ffffffe00020120c:	00000013          	nop
}
ffffffe000201210:	00813083          	ld	ra,8(sp)
ffffffe000201214:	00013403          	ld	s0,0(sp)
ffffffe000201218:	01010113          	addi	sp,sp,16
ffffffe00020121c:	00008067          	ret

ffffffe000201220 <create_mapping>:


/* 创建多级页表映射关系 */
/* 不要修改该接口的参数和返回值 */
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
ffffffe000201220:	f8010113          	addi	sp,sp,-128
ffffffe000201224:	06113c23          	sd	ra,120(sp)
ffffffe000201228:	06813823          	sd	s0,112(sp)
ffffffe00020122c:	08010413          	addi	s0,sp,128
ffffffe000201230:	faa43423          	sd	a0,-88(s0)
ffffffe000201234:	fab43023          	sd	a1,-96(s0)
ffffffe000201238:	f8c43c23          	sd	a2,-104(s0)
ffffffe00020123c:	f8d43823          	sd	a3,-112(s0)
ffffffe000201240:	f8e43423          	sd	a4,-120(s0)
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
ffffffe000201244:	f8843883          	ld	a7,-120(s0)
ffffffe000201248:	f9043803          	ld	a6,-112(s0)
ffffffe00020124c:	f9843783          	ld	a5,-104(s0)
ffffffe000201250:	fa043703          	ld	a4,-96(s0)
ffffffe000201254:	00002697          	auipc	a3,0x2
ffffffe000201258:	11c68693          	addi	a3,a3,284 # ffffffe000203370 <__func__.0>
ffffffe00020125c:	07400613          	li	a2,116
ffffffe000201260:	00002597          	auipc	a1,0x2
ffffffe000201264:	00858593          	addi	a1,a1,8 # ffffffe000203268 <__func__.0+0x68>
ffffffe000201268:	00002517          	auipc	a0,0x2
ffffffe00020126c:	0a050513          	addi	a0,a0,160 # ffffffe000203308 <__func__.0+0x108>
ffffffe000201270:	130010ef          	jal	ffffffe0002023a0 <printk>
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe000201274:	fe043423          	sd	zero,-24(s0)
ffffffe000201278:	1580006f          	j	ffffffe0002013d0 <create_mapping+0x1b0>
        uint64_t va_s = va + i;
ffffffe00020127c:	fa043703          	ld	a4,-96(s0)
ffffffe000201280:	fe843783          	ld	a5,-24(s0)
ffffffe000201284:	00f707b3          	add	a5,a4,a5
ffffffe000201288:	fef43023          	sd	a5,-32(s0)
        uint64_t index2 = (va_s >> 30) & 0x1ff;
ffffffe00020128c:	fe043783          	ld	a5,-32(s0)
ffffffe000201290:	01e7d793          	srli	a5,a5,0x1e
ffffffe000201294:	1ff7f793          	andi	a5,a5,511
ffffffe000201298:	fcf43c23          	sd	a5,-40(s0)
        uint64_t index1 = (va_s >> 21) & 0x1ff;
ffffffe00020129c:	fe043783          	ld	a5,-32(s0)
ffffffe0002012a0:	0157d793          	srli	a5,a5,0x15
ffffffe0002012a4:	1ff7f793          	andi	a5,a5,511
ffffffe0002012a8:	fcf43823          	sd	a5,-48(s0)
        uint64_t index0 = (va_s >> 12) & 0x1ff;
ffffffe0002012ac:	fe043783          	ld	a5,-32(s0)
ffffffe0002012b0:	00c7d793          	srli	a5,a5,0xc
ffffffe0002012b4:	1ff7f793          	andi	a5,a5,511
ffffffe0002012b8:	fcf43423          	sd	a5,-56(s0)

        if(!(pgtbl[index2] & 1)) {
ffffffe0002012bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002012c0:	00379793          	slli	a5,a5,0x3
ffffffe0002012c4:	fa843703          	ld	a4,-88(s0)
ffffffe0002012c8:	00f707b3          	add	a5,a4,a5
ffffffe0002012cc:	0007b783          	ld	a5,0(a5)
ffffffe0002012d0:	0017f793          	andi	a5,a5,1
ffffffe0002012d4:	02079663          	bnez	a5,ffffffe000201300 <create_mapping+0xe0>
            pgtbl[index2] = ((uint64_t)kalloc() << 10) | perm;
ffffffe0002012d8:	fcdfe0ef          	jal	ffffffe0002002a4 <kalloc>
ffffffe0002012dc:	00050793          	mv	a5,a0
ffffffe0002012e0:	00a79693          	slli	a3,a5,0xa
ffffffe0002012e4:	fd843783          	ld	a5,-40(s0)
ffffffe0002012e8:	00379793          	slli	a5,a5,0x3
ffffffe0002012ec:	fa843703          	ld	a4,-88(s0)
ffffffe0002012f0:	00f707b3          	add	a5,a4,a5
ffffffe0002012f4:	f8843703          	ld	a4,-120(s0)
ffffffe0002012f8:	00e6e733          	or	a4,a3,a4
ffffffe0002012fc:	00e7b023          	sd	a4,0(a5)
        }

        uint64_t *pgtbl1 = (uint64_t *)(pgtbl[index2] >> 10);
ffffffe000201300:	fd843783          	ld	a5,-40(s0)
ffffffe000201304:	00379793          	slli	a5,a5,0x3
ffffffe000201308:	fa843703          	ld	a4,-88(s0)
ffffffe00020130c:	00f707b3          	add	a5,a4,a5
ffffffe000201310:	0007b783          	ld	a5,0(a5)
ffffffe000201314:	00a7d793          	srli	a5,a5,0xa
ffffffe000201318:	fcf43023          	sd	a5,-64(s0)
        if(!(pgtbl1[index1] & 1)) {
ffffffe00020131c:	fd043783          	ld	a5,-48(s0)
ffffffe000201320:	00379793          	slli	a5,a5,0x3
ffffffe000201324:	fc043703          	ld	a4,-64(s0)
ffffffe000201328:	00f707b3          	add	a5,a4,a5
ffffffe00020132c:	0007b783          	ld	a5,0(a5)
ffffffe000201330:	0017f793          	andi	a5,a5,1
ffffffe000201334:	02079663          	bnez	a5,ffffffe000201360 <create_mapping+0x140>
            pgtbl1[index1] = ((uint64_t)kalloc() << 10) | perm;
ffffffe000201338:	f6dfe0ef          	jal	ffffffe0002002a4 <kalloc>
ffffffe00020133c:	00050793          	mv	a5,a0
ffffffe000201340:	00a79693          	slli	a3,a5,0xa
ffffffe000201344:	fd043783          	ld	a5,-48(s0)
ffffffe000201348:	00379793          	slli	a5,a5,0x3
ffffffe00020134c:	fc043703          	ld	a4,-64(s0)
ffffffe000201350:	00f707b3          	add	a5,a4,a5
ffffffe000201354:	f8843703          	ld	a4,-120(s0)
ffffffe000201358:	00e6e733          	or	a4,a3,a4
ffffffe00020135c:	00e7b023          	sd	a4,0(a5)
        }

        uint64_t *pgtbl0 = (uint64_t *)(pgtbl1[index1] >> 10);
ffffffe000201360:	fd043783          	ld	a5,-48(s0)
ffffffe000201364:	00379793          	slli	a5,a5,0x3
ffffffe000201368:	fc043703          	ld	a4,-64(s0)
ffffffe00020136c:	00f707b3          	add	a5,a4,a5
ffffffe000201370:	0007b783          	ld	a5,0(a5)
ffffffe000201374:	00a7d793          	srli	a5,a5,0xa
ffffffe000201378:	faf43c23          	sd	a5,-72(s0)
        if(!(pgtbl0[index0] & 1)) {
ffffffe00020137c:	fc843783          	ld	a5,-56(s0)
ffffffe000201380:	00379793          	slli	a5,a5,0x3
ffffffe000201384:	fb843703          	ld	a4,-72(s0)
ffffffe000201388:	00f707b3          	add	a5,a4,a5
ffffffe00020138c:	0007b783          	ld	a5,0(a5)
ffffffe000201390:	0017f793          	andi	a5,a5,1
ffffffe000201394:	02079663          	bnez	a5,ffffffe0002013c0 <create_mapping+0x1a0>
            pgtbl0[index0] = ((pa >> 12) << 10) | perm;
ffffffe000201398:	f9843783          	ld	a5,-104(s0)
ffffffe00020139c:	00c7d793          	srli	a5,a5,0xc
ffffffe0002013a0:	00a79693          	slli	a3,a5,0xa
ffffffe0002013a4:	fc843783          	ld	a5,-56(s0)
ffffffe0002013a8:	00379793          	slli	a5,a5,0x3
ffffffe0002013ac:	fb843703          	ld	a4,-72(s0)
ffffffe0002013b0:	00f707b3          	add	a5,a4,a5
ffffffe0002013b4:	f8843703          	ld	a4,-120(s0)
ffffffe0002013b8:	00e6e733          	or	a4,a3,a4
ffffffe0002013bc:	00e7b023          	sd	a4,0(a5)
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe0002013c0:	fe843703          	ld	a4,-24(s0)
ffffffe0002013c4:	000017b7          	lui	a5,0x1
ffffffe0002013c8:	00f707b3          	add	a5,a4,a5
ffffffe0002013cc:	fef43423          	sd	a5,-24(s0)
ffffffe0002013d0:	fe843703          	ld	a4,-24(s0)
ffffffe0002013d4:	f9043783          	ld	a5,-112(s0)
ffffffe0002013d8:	eaf762e3          	bltu	a4,a5,ffffffe00020127c <create_mapping+0x5c>
        }
    }
   
ffffffe0002013dc:	00000013          	nop
ffffffe0002013e0:	00000013          	nop
ffffffe0002013e4:	07813083          	ld	ra,120(sp)
ffffffe0002013e8:	07013403          	ld	s0,112(sp)
ffffffe0002013ec:	08010113          	addi	sp,sp,128
ffffffe0002013f0:	00008067          	ret

ffffffe0002013f4 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe0002013f4:	ff010113          	addi	sp,sp,-16
ffffffe0002013f8:	00113423          	sd	ra,8(sp)
ffffffe0002013fc:	00813023          	sd	s0,0(sp)
ffffffe000201400:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe000201404:	00002517          	auipc	a0,0x2
ffffffe000201408:	f7c50513          	addi	a0,a0,-132 # ffffffe000203380 <__func__.0+0x10>
ffffffe00020140c:	795000ef          	jal	ffffffe0002023a0 <printk>
    printk(" ZJU Operating System\n");
ffffffe000201410:	00002517          	auipc	a0,0x2
ffffffe000201414:	f7850513          	addi	a0,a0,-136 # ffffffe000203388 <__func__.0+0x18>
ffffffe000201418:	789000ef          	jal	ffffffe0002023a0 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe00020141c:	0b0000ef          	jal	ffffffe0002014cc <run_idle>
    return 0;
ffffffe000201420:	00000793          	li	a5,0
}
ffffffe000201424:	00078513          	mv	a0,a5
ffffffe000201428:	00813083          	ld	ra,8(sp)
ffffffe00020142c:	00013403          	ld	s0,0(sp)
ffffffe000201430:	01010113          	addi	sp,sp,16
ffffffe000201434:	00008067          	ret

ffffffe000201438 <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe000201438:	ff010113          	addi	sp,sp,-16
ffffffe00020143c:	00113423          	sd	ra,8(sp)
ffffffe000201440:	00813023          	sd	s0,0(sp)
ffffffe000201444:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe000201448:	00000593          	li	a1,0
ffffffe00020144c:	00000513          	li	a0,0
ffffffe000201450:	859ff0ef          	jal	ffffffe000200ca8 <sbi_system_reset>

ffffffe000201454 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe000201454:	fe010113          	addi	sp,sp,-32
ffffffe000201458:	00113c23          	sd	ra,24(sp)
ffffffe00020145c:	00813823          	sd	s0,16(sp)
ffffffe000201460:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe000201464:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe000201468:	fec42783          	lw	a5,-20(s0)
ffffffe00020146c:	0017879b          	addiw	a5,a5,1 # 1001 <PGSIZE+0x1>
ffffffe000201470:	fef42623          	sw	a5,-20(s0)
ffffffe000201474:	fec42783          	lw	a5,-20(s0)
ffffffe000201478:	0007869b          	sext.w	a3,a5
ffffffe00020147c:	55e64737          	lui	a4,0x55e64
ffffffe000201480:	b8970713          	addi	a4,a4,-1143 # 55e63b89 <PHY_SIZE+0x4de63b89>
ffffffe000201484:	02e68733          	mul	a4,a3,a4
ffffffe000201488:	02075713          	srli	a4,a4,0x20
ffffffe00020148c:	4197571b          	sraiw	a4,a4,0x19
ffffffe000201490:	00070693          	mv	a3,a4
ffffffe000201494:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffe000201498:	40e6873b          	subw	a4,a3,a4
ffffffe00020149c:	00070693          	mv	a3,a4
ffffffe0002014a0:	05f5e737          	lui	a4,0x5f5e
ffffffe0002014a4:	1007071b          	addiw	a4,a4,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe0002014a8:	02e6873b          	mulw	a4,a3,a4
ffffffe0002014ac:	40e787bb          	subw	a5,a5,a4
ffffffe0002014b0:	0007879b          	sext.w	a5,a5
ffffffe0002014b4:	fa079ae3          	bnez	a5,ffffffe000201468 <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe0002014b8:	00002517          	auipc	a0,0x2
ffffffe0002014bc:	ee850513          	addi	a0,a0,-280 # ffffffe0002033a0 <__func__.0+0x30>
ffffffe0002014c0:	6e1000ef          	jal	ffffffe0002023a0 <printk>
            i = 0;
ffffffe0002014c4:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe0002014c8:	fa1ff06f          	j	ffffffe000201468 <test+0x14>

ffffffe0002014cc <run_idle>:
        }
    }
}

void run_idle() {
ffffffe0002014cc:	ff010113          	addi	sp,sp,-16
ffffffe0002014d0:	00113423          	sd	ra,8(sp)
ffffffe0002014d4:	00813023          	sd	s0,0(sp)
ffffffe0002014d8:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe0002014dc:	0000006f          	j	ffffffe0002014dc <run_idle+0x10>

ffffffe0002014e0 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe0002014e0:	fe010113          	addi	sp,sp,-32
ffffffe0002014e4:	00113c23          	sd	ra,24(sp)
ffffffe0002014e8:	00813823          	sd	s0,16(sp)
ffffffe0002014ec:	02010413          	addi	s0,sp,32
ffffffe0002014f0:	00050793          	mv	a5,a0
ffffffe0002014f4:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe0002014f8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014fc:	0ff7f793          	zext.b	a5,a5
ffffffe000201500:	00078513          	mv	a0,a5
ffffffe000201504:	f14ff0ef          	jal	ffffffe000200c18 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe000201508:	fec42783          	lw	a5,-20(s0)
ffffffe00020150c:	0ff7f793          	zext.b	a5,a5
ffffffe000201510:	0007879b          	sext.w	a5,a5
}
ffffffe000201514:	00078513          	mv	a0,a5
ffffffe000201518:	01813083          	ld	ra,24(sp)
ffffffe00020151c:	01013403          	ld	s0,16(sp)
ffffffe000201520:	02010113          	addi	sp,sp,32
ffffffe000201524:	00008067          	ret

ffffffe000201528 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe000201528:	fe010113          	addi	sp,sp,-32
ffffffe00020152c:	00113c23          	sd	ra,24(sp)
ffffffe000201530:	00813823          	sd	s0,16(sp)
ffffffe000201534:	02010413          	addi	s0,sp,32
ffffffe000201538:	00050793          	mv	a5,a0
ffffffe00020153c:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe000201540:	fec42783          	lw	a5,-20(s0)
ffffffe000201544:	0007871b          	sext.w	a4,a5
ffffffe000201548:	02000793          	li	a5,32
ffffffe00020154c:	02f70263          	beq	a4,a5,ffffffe000201570 <isspace+0x48>
ffffffe000201550:	fec42783          	lw	a5,-20(s0)
ffffffe000201554:	0007871b          	sext.w	a4,a5
ffffffe000201558:	00800793          	li	a5,8
ffffffe00020155c:	00e7de63          	bge	a5,a4,ffffffe000201578 <isspace+0x50>
ffffffe000201560:	fec42783          	lw	a5,-20(s0)
ffffffe000201564:	0007871b          	sext.w	a4,a5
ffffffe000201568:	00d00793          	li	a5,13
ffffffe00020156c:	00e7c663          	blt	a5,a4,ffffffe000201578 <isspace+0x50>
ffffffe000201570:	00100793          	li	a5,1
ffffffe000201574:	0080006f          	j	ffffffe00020157c <isspace+0x54>
ffffffe000201578:	00000793          	li	a5,0
}
ffffffe00020157c:	00078513          	mv	a0,a5
ffffffe000201580:	01813083          	ld	ra,24(sp)
ffffffe000201584:	01013403          	ld	s0,16(sp)
ffffffe000201588:	02010113          	addi	sp,sp,32
ffffffe00020158c:	00008067          	ret

ffffffe000201590 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe000201590:	fb010113          	addi	sp,sp,-80
ffffffe000201594:	04113423          	sd	ra,72(sp)
ffffffe000201598:	04813023          	sd	s0,64(sp)
ffffffe00020159c:	05010413          	addi	s0,sp,80
ffffffe0002015a0:	fca43423          	sd	a0,-56(s0)
ffffffe0002015a4:	fcb43023          	sd	a1,-64(s0)
ffffffe0002015a8:	00060793          	mv	a5,a2
ffffffe0002015ac:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe0002015b0:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe0002015b4:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe0002015b8:	fc843783          	ld	a5,-56(s0)
ffffffe0002015bc:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe0002015c0:	0100006f          	j	ffffffe0002015d0 <strtol+0x40>
        p++;
ffffffe0002015c4:	fd843783          	ld	a5,-40(s0)
ffffffe0002015c8:	00178793          	addi	a5,a5,1
ffffffe0002015cc:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe0002015d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015d4:	0007c783          	lbu	a5,0(a5)
ffffffe0002015d8:	0007879b          	sext.w	a5,a5
ffffffe0002015dc:	00078513          	mv	a0,a5
ffffffe0002015e0:	f49ff0ef          	jal	ffffffe000201528 <isspace>
ffffffe0002015e4:	00050793          	mv	a5,a0
ffffffe0002015e8:	fc079ee3          	bnez	a5,ffffffe0002015c4 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe0002015ec:	fd843783          	ld	a5,-40(s0)
ffffffe0002015f0:	0007c783          	lbu	a5,0(a5)
ffffffe0002015f4:	00078713          	mv	a4,a5
ffffffe0002015f8:	02d00793          	li	a5,45
ffffffe0002015fc:	00f71e63          	bne	a4,a5,ffffffe000201618 <strtol+0x88>
        neg = true;
ffffffe000201600:	00100793          	li	a5,1
ffffffe000201604:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe000201608:	fd843783          	ld	a5,-40(s0)
ffffffe00020160c:	00178793          	addi	a5,a5,1
ffffffe000201610:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201614:	0240006f          	j	ffffffe000201638 <strtol+0xa8>
    } else if (*p == '+') {
ffffffe000201618:	fd843783          	ld	a5,-40(s0)
ffffffe00020161c:	0007c783          	lbu	a5,0(a5)
ffffffe000201620:	00078713          	mv	a4,a5
ffffffe000201624:	02b00793          	li	a5,43
ffffffe000201628:	00f71863          	bne	a4,a5,ffffffe000201638 <strtol+0xa8>
        p++;
ffffffe00020162c:	fd843783          	ld	a5,-40(s0)
ffffffe000201630:	00178793          	addi	a5,a5,1
ffffffe000201634:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe000201638:	fbc42783          	lw	a5,-68(s0)
ffffffe00020163c:	0007879b          	sext.w	a5,a5
ffffffe000201640:	06079c63          	bnez	a5,ffffffe0002016b8 <strtol+0x128>
        if (*p == '0') {
ffffffe000201644:	fd843783          	ld	a5,-40(s0)
ffffffe000201648:	0007c783          	lbu	a5,0(a5)
ffffffe00020164c:	00078713          	mv	a4,a5
ffffffe000201650:	03000793          	li	a5,48
ffffffe000201654:	04f71e63          	bne	a4,a5,ffffffe0002016b0 <strtol+0x120>
            p++;
ffffffe000201658:	fd843783          	ld	a5,-40(s0)
ffffffe00020165c:	00178793          	addi	a5,a5,1
ffffffe000201660:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe000201664:	fd843783          	ld	a5,-40(s0)
ffffffe000201668:	0007c783          	lbu	a5,0(a5)
ffffffe00020166c:	00078713          	mv	a4,a5
ffffffe000201670:	07800793          	li	a5,120
ffffffe000201674:	00f70c63          	beq	a4,a5,ffffffe00020168c <strtol+0xfc>
ffffffe000201678:	fd843783          	ld	a5,-40(s0)
ffffffe00020167c:	0007c783          	lbu	a5,0(a5)
ffffffe000201680:	00078713          	mv	a4,a5
ffffffe000201684:	05800793          	li	a5,88
ffffffe000201688:	00f71e63          	bne	a4,a5,ffffffe0002016a4 <strtol+0x114>
                base = 16;
ffffffe00020168c:	01000793          	li	a5,16
ffffffe000201690:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000201694:	fd843783          	ld	a5,-40(s0)
ffffffe000201698:	00178793          	addi	a5,a5,1
ffffffe00020169c:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002016a0:	0180006f          	j	ffffffe0002016b8 <strtol+0x128>
            } else {
                base = 8;
ffffffe0002016a4:	00800793          	li	a5,8
ffffffe0002016a8:	faf42e23          	sw	a5,-68(s0)
ffffffe0002016ac:	00c0006f          	j	ffffffe0002016b8 <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe0002016b0:	00a00793          	li	a5,10
ffffffe0002016b4:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe0002016b8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016bc:	0007c783          	lbu	a5,0(a5)
ffffffe0002016c0:	00078713          	mv	a4,a5
ffffffe0002016c4:	02f00793          	li	a5,47
ffffffe0002016c8:	02e7f863          	bgeu	a5,a4,ffffffe0002016f8 <strtol+0x168>
ffffffe0002016cc:	fd843783          	ld	a5,-40(s0)
ffffffe0002016d0:	0007c783          	lbu	a5,0(a5)
ffffffe0002016d4:	00078713          	mv	a4,a5
ffffffe0002016d8:	03900793          	li	a5,57
ffffffe0002016dc:	00e7ee63          	bltu	a5,a4,ffffffe0002016f8 <strtol+0x168>
            digit = *p - '0';
ffffffe0002016e0:	fd843783          	ld	a5,-40(s0)
ffffffe0002016e4:	0007c783          	lbu	a5,0(a5)
ffffffe0002016e8:	0007879b          	sext.w	a5,a5
ffffffe0002016ec:	fd07879b          	addiw	a5,a5,-48
ffffffe0002016f0:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002016f4:	0800006f          	j	ffffffe000201774 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe0002016f8:	fd843783          	ld	a5,-40(s0)
ffffffe0002016fc:	0007c783          	lbu	a5,0(a5)
ffffffe000201700:	00078713          	mv	a4,a5
ffffffe000201704:	06000793          	li	a5,96
ffffffe000201708:	02e7f863          	bgeu	a5,a4,ffffffe000201738 <strtol+0x1a8>
ffffffe00020170c:	fd843783          	ld	a5,-40(s0)
ffffffe000201710:	0007c783          	lbu	a5,0(a5)
ffffffe000201714:	00078713          	mv	a4,a5
ffffffe000201718:	07a00793          	li	a5,122
ffffffe00020171c:	00e7ee63          	bltu	a5,a4,ffffffe000201738 <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe000201720:	fd843783          	ld	a5,-40(s0)
ffffffe000201724:	0007c783          	lbu	a5,0(a5)
ffffffe000201728:	0007879b          	sext.w	a5,a5
ffffffe00020172c:	fa97879b          	addiw	a5,a5,-87
ffffffe000201730:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201734:	0400006f          	j	ffffffe000201774 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe000201738:	fd843783          	ld	a5,-40(s0)
ffffffe00020173c:	0007c783          	lbu	a5,0(a5)
ffffffe000201740:	00078713          	mv	a4,a5
ffffffe000201744:	04000793          	li	a5,64
ffffffe000201748:	06e7f863          	bgeu	a5,a4,ffffffe0002017b8 <strtol+0x228>
ffffffe00020174c:	fd843783          	ld	a5,-40(s0)
ffffffe000201750:	0007c783          	lbu	a5,0(a5)
ffffffe000201754:	00078713          	mv	a4,a5
ffffffe000201758:	05a00793          	li	a5,90
ffffffe00020175c:	04e7ee63          	bltu	a5,a4,ffffffe0002017b8 <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe000201760:	fd843783          	ld	a5,-40(s0)
ffffffe000201764:	0007c783          	lbu	a5,0(a5)
ffffffe000201768:	0007879b          	sext.w	a5,a5
ffffffe00020176c:	fc97879b          	addiw	a5,a5,-55
ffffffe000201770:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000201774:	fd442783          	lw	a5,-44(s0)
ffffffe000201778:	00078713          	mv	a4,a5
ffffffe00020177c:	fbc42783          	lw	a5,-68(s0)
ffffffe000201780:	0007071b          	sext.w	a4,a4
ffffffe000201784:	0007879b          	sext.w	a5,a5
ffffffe000201788:	02f75663          	bge	a4,a5,ffffffe0002017b4 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe00020178c:	fbc42703          	lw	a4,-68(s0)
ffffffe000201790:	fe843783          	ld	a5,-24(s0)
ffffffe000201794:	02f70733          	mul	a4,a4,a5
ffffffe000201798:	fd442783          	lw	a5,-44(s0)
ffffffe00020179c:	00f707b3          	add	a5,a4,a5
ffffffe0002017a0:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe0002017a4:	fd843783          	ld	a5,-40(s0)
ffffffe0002017a8:	00178793          	addi	a5,a5,1
ffffffe0002017ac:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe0002017b0:	f09ff06f          	j	ffffffe0002016b8 <strtol+0x128>
            break;
ffffffe0002017b4:	00000013          	nop
    }

    if (endptr) {
ffffffe0002017b8:	fc043783          	ld	a5,-64(s0)
ffffffe0002017bc:	00078863          	beqz	a5,ffffffe0002017cc <strtol+0x23c>
        *endptr = (char *)p;
ffffffe0002017c0:	fc043783          	ld	a5,-64(s0)
ffffffe0002017c4:	fd843703          	ld	a4,-40(s0)
ffffffe0002017c8:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe0002017cc:	fe744783          	lbu	a5,-25(s0)
ffffffe0002017d0:	0ff7f793          	zext.b	a5,a5
ffffffe0002017d4:	00078863          	beqz	a5,ffffffe0002017e4 <strtol+0x254>
ffffffe0002017d8:	fe843783          	ld	a5,-24(s0)
ffffffe0002017dc:	40f007b3          	neg	a5,a5
ffffffe0002017e0:	0080006f          	j	ffffffe0002017e8 <strtol+0x258>
ffffffe0002017e4:	fe843783          	ld	a5,-24(s0)
}
ffffffe0002017e8:	00078513          	mv	a0,a5
ffffffe0002017ec:	04813083          	ld	ra,72(sp)
ffffffe0002017f0:	04013403          	ld	s0,64(sp)
ffffffe0002017f4:	05010113          	addi	sp,sp,80
ffffffe0002017f8:	00008067          	ret

ffffffe0002017fc <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe0002017fc:	fd010113          	addi	sp,sp,-48
ffffffe000201800:	02113423          	sd	ra,40(sp)
ffffffe000201804:	02813023          	sd	s0,32(sp)
ffffffe000201808:	03010413          	addi	s0,sp,48
ffffffe00020180c:	fca43c23          	sd	a0,-40(s0)
ffffffe000201810:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe000201814:	fd043783          	ld	a5,-48(s0)
ffffffe000201818:	00079863          	bnez	a5,ffffffe000201828 <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe00020181c:	00002797          	auipc	a5,0x2
ffffffe000201820:	b9c78793          	addi	a5,a5,-1124 # ffffffe0002033b8 <__func__.0+0x48>
ffffffe000201824:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe000201828:	fd043783          	ld	a5,-48(s0)
ffffffe00020182c:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe000201830:	0240006f          	j	ffffffe000201854 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe000201834:	fe843783          	ld	a5,-24(s0)
ffffffe000201838:	00178713          	addi	a4,a5,1
ffffffe00020183c:	fee43423          	sd	a4,-24(s0)
ffffffe000201840:	0007c783          	lbu	a5,0(a5)
ffffffe000201844:	0007871b          	sext.w	a4,a5
ffffffe000201848:	fd843783          	ld	a5,-40(s0)
ffffffe00020184c:	00070513          	mv	a0,a4
ffffffe000201850:	000780e7          	jalr	a5
    while (*p) {
ffffffe000201854:	fe843783          	ld	a5,-24(s0)
ffffffe000201858:	0007c783          	lbu	a5,0(a5)
ffffffe00020185c:	fc079ce3          	bnez	a5,ffffffe000201834 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe000201860:	fe843703          	ld	a4,-24(s0)
ffffffe000201864:	fd043783          	ld	a5,-48(s0)
ffffffe000201868:	40f707b3          	sub	a5,a4,a5
ffffffe00020186c:	0007879b          	sext.w	a5,a5
}
ffffffe000201870:	00078513          	mv	a0,a5
ffffffe000201874:	02813083          	ld	ra,40(sp)
ffffffe000201878:	02013403          	ld	s0,32(sp)
ffffffe00020187c:	03010113          	addi	sp,sp,48
ffffffe000201880:	00008067          	ret

ffffffe000201884 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000201884:	f9010113          	addi	sp,sp,-112
ffffffe000201888:	06113423          	sd	ra,104(sp)
ffffffe00020188c:	06813023          	sd	s0,96(sp)
ffffffe000201890:	07010413          	addi	s0,sp,112
ffffffe000201894:	faa43423          	sd	a0,-88(s0)
ffffffe000201898:	fab43023          	sd	a1,-96(s0)
ffffffe00020189c:	00060793          	mv	a5,a2
ffffffe0002018a0:	f8d43823          	sd	a3,-112(s0)
ffffffe0002018a4:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe0002018a8:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002018ac:	0ff7f793          	zext.b	a5,a5
ffffffe0002018b0:	02078663          	beqz	a5,ffffffe0002018dc <print_dec_int+0x58>
ffffffe0002018b4:	fa043703          	ld	a4,-96(s0)
ffffffe0002018b8:	fff00793          	li	a5,-1
ffffffe0002018bc:	03f79793          	slli	a5,a5,0x3f
ffffffe0002018c0:	00f71e63          	bne	a4,a5,ffffffe0002018dc <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe0002018c4:	00002597          	auipc	a1,0x2
ffffffe0002018c8:	afc58593          	addi	a1,a1,-1284 # ffffffe0002033c0 <__func__.0+0x50>
ffffffe0002018cc:	fa843503          	ld	a0,-88(s0)
ffffffe0002018d0:	f2dff0ef          	jal	ffffffe0002017fc <puts_wo_nl>
ffffffe0002018d4:	00050793          	mv	a5,a0
ffffffe0002018d8:	2c80006f          	j	ffffffe000201ba0 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe0002018dc:	f9043783          	ld	a5,-112(s0)
ffffffe0002018e0:	00c7a783          	lw	a5,12(a5)
ffffffe0002018e4:	00079a63          	bnez	a5,ffffffe0002018f8 <print_dec_int+0x74>
ffffffe0002018e8:	fa043783          	ld	a5,-96(s0)
ffffffe0002018ec:	00079663          	bnez	a5,ffffffe0002018f8 <print_dec_int+0x74>
        return 0;
ffffffe0002018f0:	00000793          	li	a5,0
ffffffe0002018f4:	2ac0006f          	j	ffffffe000201ba0 <print_dec_int+0x31c>
    }

    bool neg = false;
ffffffe0002018f8:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe0002018fc:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201900:	0ff7f793          	zext.b	a5,a5
ffffffe000201904:	02078063          	beqz	a5,ffffffe000201924 <print_dec_int+0xa0>
ffffffe000201908:	fa043783          	ld	a5,-96(s0)
ffffffe00020190c:	0007dc63          	bgez	a5,ffffffe000201924 <print_dec_int+0xa0>
        neg = true;
ffffffe000201910:	00100793          	li	a5,1
ffffffe000201914:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe000201918:	fa043783          	ld	a5,-96(s0)
ffffffe00020191c:	40f007b3          	neg	a5,a5
ffffffe000201920:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe000201924:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe000201928:	f9f44783          	lbu	a5,-97(s0)
ffffffe00020192c:	0ff7f793          	zext.b	a5,a5
ffffffe000201930:	02078863          	beqz	a5,ffffffe000201960 <print_dec_int+0xdc>
ffffffe000201934:	fef44783          	lbu	a5,-17(s0)
ffffffe000201938:	0ff7f793          	zext.b	a5,a5
ffffffe00020193c:	00079e63          	bnez	a5,ffffffe000201958 <print_dec_int+0xd4>
ffffffe000201940:	f9043783          	ld	a5,-112(s0)
ffffffe000201944:	0057c783          	lbu	a5,5(a5)
ffffffe000201948:	00079863          	bnez	a5,ffffffe000201958 <print_dec_int+0xd4>
ffffffe00020194c:	f9043783          	ld	a5,-112(s0)
ffffffe000201950:	0047c783          	lbu	a5,4(a5)
ffffffe000201954:	00078663          	beqz	a5,ffffffe000201960 <print_dec_int+0xdc>
ffffffe000201958:	00100793          	li	a5,1
ffffffe00020195c:	0080006f          	j	ffffffe000201964 <print_dec_int+0xe0>
ffffffe000201960:	00000793          	li	a5,0
ffffffe000201964:	fcf40ba3          	sb	a5,-41(s0)
ffffffe000201968:	fd744783          	lbu	a5,-41(s0)
ffffffe00020196c:	0017f793          	andi	a5,a5,1
ffffffe000201970:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000201974:	fa043683          	ld	a3,-96(s0)
ffffffe000201978:	00002797          	auipc	a5,0x2
ffffffe00020197c:	a6078793          	addi	a5,a5,-1440 # ffffffe0002033d8 <__func__.0+0x68>
ffffffe000201980:	0007b783          	ld	a5,0(a5)
ffffffe000201984:	02f6b7b3          	mulhu	a5,a3,a5
ffffffe000201988:	0037d713          	srli	a4,a5,0x3
ffffffe00020198c:	00070793          	mv	a5,a4
ffffffe000201990:	00279793          	slli	a5,a5,0x2
ffffffe000201994:	00e787b3          	add	a5,a5,a4
ffffffe000201998:	00179793          	slli	a5,a5,0x1
ffffffe00020199c:	40f68733          	sub	a4,a3,a5
ffffffe0002019a0:	0ff77713          	zext.b	a4,a4
ffffffe0002019a4:	fe842783          	lw	a5,-24(s0)
ffffffe0002019a8:	0017869b          	addiw	a3,a5,1
ffffffe0002019ac:	fed42423          	sw	a3,-24(s0)
ffffffe0002019b0:	0307071b          	addiw	a4,a4,48
ffffffe0002019b4:	0ff77713          	zext.b	a4,a4
ffffffe0002019b8:	ff078793          	addi	a5,a5,-16
ffffffe0002019bc:	008787b3          	add	a5,a5,s0
ffffffe0002019c0:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe0002019c4:	fa043703          	ld	a4,-96(s0)
ffffffe0002019c8:	00002797          	auipc	a5,0x2
ffffffe0002019cc:	a1078793          	addi	a5,a5,-1520 # ffffffe0002033d8 <__func__.0+0x68>
ffffffe0002019d0:	0007b783          	ld	a5,0(a5)
ffffffe0002019d4:	02f737b3          	mulhu	a5,a4,a5
ffffffe0002019d8:	0037d793          	srli	a5,a5,0x3
ffffffe0002019dc:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe0002019e0:	fa043783          	ld	a5,-96(s0)
ffffffe0002019e4:	f80798e3          	bnez	a5,ffffffe000201974 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe0002019e8:	f9043783          	ld	a5,-112(s0)
ffffffe0002019ec:	00c7a703          	lw	a4,12(a5)
ffffffe0002019f0:	fff00793          	li	a5,-1
ffffffe0002019f4:	02f71063          	bne	a4,a5,ffffffe000201a14 <print_dec_int+0x190>
ffffffe0002019f8:	f9043783          	ld	a5,-112(s0)
ffffffe0002019fc:	0037c783          	lbu	a5,3(a5)
ffffffe000201a00:	00078a63          	beqz	a5,ffffffe000201a14 <print_dec_int+0x190>
        flags->prec = flags->width;
ffffffe000201a04:	f9043783          	ld	a5,-112(s0)
ffffffe000201a08:	0087a703          	lw	a4,8(a5)
ffffffe000201a0c:	f9043783          	ld	a5,-112(s0)
ffffffe000201a10:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe000201a14:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a18:	f9043783          	ld	a5,-112(s0)
ffffffe000201a1c:	0087a703          	lw	a4,8(a5)
ffffffe000201a20:	fe842783          	lw	a5,-24(s0)
ffffffe000201a24:	fcf42823          	sw	a5,-48(s0)
ffffffe000201a28:	f9043783          	ld	a5,-112(s0)
ffffffe000201a2c:	00c7a783          	lw	a5,12(a5)
ffffffe000201a30:	fcf42623          	sw	a5,-52(s0)
ffffffe000201a34:	fd042783          	lw	a5,-48(s0)
ffffffe000201a38:	00078593          	mv	a1,a5
ffffffe000201a3c:	fcc42783          	lw	a5,-52(s0)
ffffffe000201a40:	00078613          	mv	a2,a5
ffffffe000201a44:	0006069b          	sext.w	a3,a2
ffffffe000201a48:	0005879b          	sext.w	a5,a1
ffffffe000201a4c:	00f6d463          	bge	a3,a5,ffffffe000201a54 <print_dec_int+0x1d0>
ffffffe000201a50:	00058613          	mv	a2,a1
ffffffe000201a54:	0006079b          	sext.w	a5,a2
ffffffe000201a58:	40f707bb          	subw	a5,a4,a5
ffffffe000201a5c:	0007871b          	sext.w	a4,a5
ffffffe000201a60:	fd744783          	lbu	a5,-41(s0)
ffffffe000201a64:	0007879b          	sext.w	a5,a5
ffffffe000201a68:	40f707bb          	subw	a5,a4,a5
ffffffe000201a6c:	fef42023          	sw	a5,-32(s0)
ffffffe000201a70:	0280006f          	j	ffffffe000201a98 <print_dec_int+0x214>
        putch(' ');
ffffffe000201a74:	fa843783          	ld	a5,-88(s0)
ffffffe000201a78:	02000513          	li	a0,32
ffffffe000201a7c:	000780e7          	jalr	a5
        ++written;
ffffffe000201a80:	fe442783          	lw	a5,-28(s0)
ffffffe000201a84:	0017879b          	addiw	a5,a5,1
ffffffe000201a88:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a8c:	fe042783          	lw	a5,-32(s0)
ffffffe000201a90:	fff7879b          	addiw	a5,a5,-1
ffffffe000201a94:	fef42023          	sw	a5,-32(s0)
ffffffe000201a98:	fe042783          	lw	a5,-32(s0)
ffffffe000201a9c:	0007879b          	sext.w	a5,a5
ffffffe000201aa0:	fcf04ae3          	bgtz	a5,ffffffe000201a74 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
ffffffe000201aa4:	fd744783          	lbu	a5,-41(s0)
ffffffe000201aa8:	0ff7f793          	zext.b	a5,a5
ffffffe000201aac:	04078463          	beqz	a5,ffffffe000201af4 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe000201ab0:	fef44783          	lbu	a5,-17(s0)
ffffffe000201ab4:	0ff7f793          	zext.b	a5,a5
ffffffe000201ab8:	00078663          	beqz	a5,ffffffe000201ac4 <print_dec_int+0x240>
ffffffe000201abc:	02d00793          	li	a5,45
ffffffe000201ac0:	01c0006f          	j	ffffffe000201adc <print_dec_int+0x258>
ffffffe000201ac4:	f9043783          	ld	a5,-112(s0)
ffffffe000201ac8:	0057c783          	lbu	a5,5(a5)
ffffffe000201acc:	00078663          	beqz	a5,ffffffe000201ad8 <print_dec_int+0x254>
ffffffe000201ad0:	02b00793          	li	a5,43
ffffffe000201ad4:	0080006f          	j	ffffffe000201adc <print_dec_int+0x258>
ffffffe000201ad8:	02000793          	li	a5,32
ffffffe000201adc:	fa843703          	ld	a4,-88(s0)
ffffffe000201ae0:	00078513          	mv	a0,a5
ffffffe000201ae4:	000700e7          	jalr	a4
        ++written;
ffffffe000201ae8:	fe442783          	lw	a5,-28(s0)
ffffffe000201aec:	0017879b          	addiw	a5,a5,1
ffffffe000201af0:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201af4:	fe842783          	lw	a5,-24(s0)
ffffffe000201af8:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201afc:	0280006f          	j	ffffffe000201b24 <print_dec_int+0x2a0>
        putch('0');
ffffffe000201b00:	fa843783          	ld	a5,-88(s0)
ffffffe000201b04:	03000513          	li	a0,48
ffffffe000201b08:	000780e7          	jalr	a5
        ++written;
ffffffe000201b0c:	fe442783          	lw	a5,-28(s0)
ffffffe000201b10:	0017879b          	addiw	a5,a5,1
ffffffe000201b14:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201b18:	fdc42783          	lw	a5,-36(s0)
ffffffe000201b1c:	0017879b          	addiw	a5,a5,1
ffffffe000201b20:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201b24:	f9043783          	ld	a5,-112(s0)
ffffffe000201b28:	00c7a703          	lw	a4,12(a5)
ffffffe000201b2c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201b30:	0007879b          	sext.w	a5,a5
ffffffe000201b34:	40f707bb          	subw	a5,a4,a5
ffffffe000201b38:	0007879b          	sext.w	a5,a5
ffffffe000201b3c:	fdc42703          	lw	a4,-36(s0)
ffffffe000201b40:	0007071b          	sext.w	a4,a4
ffffffe000201b44:	faf74ee3          	blt	a4,a5,ffffffe000201b00 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b48:	fe842783          	lw	a5,-24(s0)
ffffffe000201b4c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b50:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b54:	03c0006f          	j	ffffffe000201b90 <print_dec_int+0x30c>
        putch(buf[i]);
ffffffe000201b58:	fd842783          	lw	a5,-40(s0)
ffffffe000201b5c:	ff078793          	addi	a5,a5,-16
ffffffe000201b60:	008787b3          	add	a5,a5,s0
ffffffe000201b64:	fc87c783          	lbu	a5,-56(a5)
ffffffe000201b68:	0007871b          	sext.w	a4,a5
ffffffe000201b6c:	fa843783          	ld	a5,-88(s0)
ffffffe000201b70:	00070513          	mv	a0,a4
ffffffe000201b74:	000780e7          	jalr	a5
        ++written;
ffffffe000201b78:	fe442783          	lw	a5,-28(s0)
ffffffe000201b7c:	0017879b          	addiw	a5,a5,1
ffffffe000201b80:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b84:	fd842783          	lw	a5,-40(s0)
ffffffe000201b88:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b8c:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b90:	fd842783          	lw	a5,-40(s0)
ffffffe000201b94:	0007879b          	sext.w	a5,a5
ffffffe000201b98:	fc07d0e3          	bgez	a5,ffffffe000201b58 <print_dec_int+0x2d4>
    }

    return written;
ffffffe000201b9c:	fe442783          	lw	a5,-28(s0)
}
ffffffe000201ba0:	00078513          	mv	a0,a5
ffffffe000201ba4:	06813083          	ld	ra,104(sp)
ffffffe000201ba8:	06013403          	ld	s0,96(sp)
ffffffe000201bac:	07010113          	addi	sp,sp,112
ffffffe000201bb0:	00008067          	ret

ffffffe000201bb4 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201bb4:	f4010113          	addi	sp,sp,-192
ffffffe000201bb8:	0a113c23          	sd	ra,184(sp)
ffffffe000201bbc:	0a813823          	sd	s0,176(sp)
ffffffe000201bc0:	0c010413          	addi	s0,sp,192
ffffffe000201bc4:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201bc8:	f4b43823          	sd	a1,-176(s0)
ffffffe000201bcc:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe000201bd0:	f8043023          	sd	zero,-128(s0)
ffffffe000201bd4:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201bd8:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201bdc:	7a00006f          	j	ffffffe00020237c <vprintfmt+0x7c8>
        if (flags.in_format) {
ffffffe000201be0:	f8044783          	lbu	a5,-128(s0)
ffffffe000201be4:	72078c63          	beqz	a5,ffffffe00020231c <vprintfmt+0x768>
            if (*fmt == '#') {
ffffffe000201be8:	f5043783          	ld	a5,-176(s0)
ffffffe000201bec:	0007c783          	lbu	a5,0(a5)
ffffffe000201bf0:	00078713          	mv	a4,a5
ffffffe000201bf4:	02300793          	li	a5,35
ffffffe000201bf8:	00f71863          	bne	a4,a5,ffffffe000201c08 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201bfc:	00100793          	li	a5,1
ffffffe000201c00:	f8f40123          	sb	a5,-126(s0)
ffffffe000201c04:	76c0006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
ffffffe000201c08:	f5043783          	ld	a5,-176(s0)
ffffffe000201c0c:	0007c783          	lbu	a5,0(a5)
ffffffe000201c10:	00078713          	mv	a4,a5
ffffffe000201c14:	03000793          	li	a5,48
ffffffe000201c18:	00f71863          	bne	a4,a5,ffffffe000201c28 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe000201c1c:	00100793          	li	a5,1
ffffffe000201c20:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201c24:	74c0006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201c28:	f5043783          	ld	a5,-176(s0)
ffffffe000201c2c:	0007c783          	lbu	a5,0(a5)
ffffffe000201c30:	00078713          	mv	a4,a5
ffffffe000201c34:	06c00793          	li	a5,108
ffffffe000201c38:	04f70063          	beq	a4,a5,ffffffe000201c78 <vprintfmt+0xc4>
ffffffe000201c3c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c40:	0007c783          	lbu	a5,0(a5)
ffffffe000201c44:	00078713          	mv	a4,a5
ffffffe000201c48:	07a00793          	li	a5,122
ffffffe000201c4c:	02f70663          	beq	a4,a5,ffffffe000201c78 <vprintfmt+0xc4>
ffffffe000201c50:	f5043783          	ld	a5,-176(s0)
ffffffe000201c54:	0007c783          	lbu	a5,0(a5)
ffffffe000201c58:	00078713          	mv	a4,a5
ffffffe000201c5c:	07400793          	li	a5,116
ffffffe000201c60:	00f70c63          	beq	a4,a5,ffffffe000201c78 <vprintfmt+0xc4>
ffffffe000201c64:	f5043783          	ld	a5,-176(s0)
ffffffe000201c68:	0007c783          	lbu	a5,0(a5)
ffffffe000201c6c:	00078713          	mv	a4,a5
ffffffe000201c70:	06a00793          	li	a5,106
ffffffe000201c74:	00f71863          	bne	a4,a5,ffffffe000201c84 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201c78:	00100793          	li	a5,1
ffffffe000201c7c:	f8f400a3          	sb	a5,-127(s0)
ffffffe000201c80:	6f00006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
ffffffe000201c84:	f5043783          	ld	a5,-176(s0)
ffffffe000201c88:	0007c783          	lbu	a5,0(a5)
ffffffe000201c8c:	00078713          	mv	a4,a5
ffffffe000201c90:	02b00793          	li	a5,43
ffffffe000201c94:	00f71863          	bne	a4,a5,ffffffe000201ca4 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201c98:	00100793          	li	a5,1
ffffffe000201c9c:	f8f402a3          	sb	a5,-123(s0)
ffffffe000201ca0:	6d00006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
ffffffe000201ca4:	f5043783          	ld	a5,-176(s0)
ffffffe000201ca8:	0007c783          	lbu	a5,0(a5)
ffffffe000201cac:	00078713          	mv	a4,a5
ffffffe000201cb0:	02000793          	li	a5,32
ffffffe000201cb4:	00f71863          	bne	a4,a5,ffffffe000201cc4 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201cb8:	00100793          	li	a5,1
ffffffe000201cbc:	f8f40223          	sb	a5,-124(s0)
ffffffe000201cc0:	6b00006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
ffffffe000201cc4:	f5043783          	ld	a5,-176(s0)
ffffffe000201cc8:	0007c783          	lbu	a5,0(a5)
ffffffe000201ccc:	00078713          	mv	a4,a5
ffffffe000201cd0:	02a00793          	li	a5,42
ffffffe000201cd4:	00f71e63          	bne	a4,a5,ffffffe000201cf0 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201cd8:	f4843783          	ld	a5,-184(s0)
ffffffe000201cdc:	00878713          	addi	a4,a5,8
ffffffe000201ce0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201ce4:	0007a783          	lw	a5,0(a5)
ffffffe000201ce8:	f8f42423          	sw	a5,-120(s0)
ffffffe000201cec:	6840006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe000201cf0:	f5043783          	ld	a5,-176(s0)
ffffffe000201cf4:	0007c783          	lbu	a5,0(a5)
ffffffe000201cf8:	00078713          	mv	a4,a5
ffffffe000201cfc:	03000793          	li	a5,48
ffffffe000201d00:	04e7f663          	bgeu	a5,a4,ffffffe000201d4c <vprintfmt+0x198>
ffffffe000201d04:	f5043783          	ld	a5,-176(s0)
ffffffe000201d08:	0007c783          	lbu	a5,0(a5)
ffffffe000201d0c:	00078713          	mv	a4,a5
ffffffe000201d10:	03900793          	li	a5,57
ffffffe000201d14:	02e7ec63          	bltu	a5,a4,ffffffe000201d4c <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d18:	f5043783          	ld	a5,-176(s0)
ffffffe000201d1c:	f5040713          	addi	a4,s0,-176
ffffffe000201d20:	00a00613          	li	a2,10
ffffffe000201d24:	00070593          	mv	a1,a4
ffffffe000201d28:	00078513          	mv	a0,a5
ffffffe000201d2c:	865ff0ef          	jal	ffffffe000201590 <strtol>
ffffffe000201d30:	00050793          	mv	a5,a0
ffffffe000201d34:	0007879b          	sext.w	a5,a5
ffffffe000201d38:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201d3c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d40:	fff78793          	addi	a5,a5,-1
ffffffe000201d44:	f4f43823          	sd	a5,-176(s0)
ffffffe000201d48:	6280006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
ffffffe000201d4c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d50:	0007c783          	lbu	a5,0(a5)
ffffffe000201d54:	00078713          	mv	a4,a5
ffffffe000201d58:	02e00793          	li	a5,46
ffffffe000201d5c:	06f71863          	bne	a4,a5,ffffffe000201dcc <vprintfmt+0x218>
                fmt++;
ffffffe000201d60:	f5043783          	ld	a5,-176(s0)
ffffffe000201d64:	00178793          	addi	a5,a5,1
ffffffe000201d68:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000201d6c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d70:	0007c783          	lbu	a5,0(a5)
ffffffe000201d74:	00078713          	mv	a4,a5
ffffffe000201d78:	02a00793          	li	a5,42
ffffffe000201d7c:	00f71e63          	bne	a4,a5,ffffffe000201d98 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000201d80:	f4843783          	ld	a5,-184(s0)
ffffffe000201d84:	00878713          	addi	a4,a5,8
ffffffe000201d88:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d8c:	0007a783          	lw	a5,0(a5)
ffffffe000201d90:	f8f42623          	sw	a5,-116(s0)
ffffffe000201d94:	5dc0006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d98:	f5043783          	ld	a5,-176(s0)
ffffffe000201d9c:	f5040713          	addi	a4,s0,-176
ffffffe000201da0:	00a00613          	li	a2,10
ffffffe000201da4:	00070593          	mv	a1,a4
ffffffe000201da8:	00078513          	mv	a0,a5
ffffffe000201dac:	fe4ff0ef          	jal	ffffffe000201590 <strtol>
ffffffe000201db0:	00050793          	mv	a5,a0
ffffffe000201db4:	0007879b          	sext.w	a5,a5
ffffffe000201db8:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201dbc:	f5043783          	ld	a5,-176(s0)
ffffffe000201dc0:	fff78793          	addi	a5,a5,-1
ffffffe000201dc4:	f4f43823          	sd	a5,-176(s0)
ffffffe000201dc8:	5a80006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201dcc:	f5043783          	ld	a5,-176(s0)
ffffffe000201dd0:	0007c783          	lbu	a5,0(a5)
ffffffe000201dd4:	00078713          	mv	a4,a5
ffffffe000201dd8:	07800793          	li	a5,120
ffffffe000201ddc:	02f70663          	beq	a4,a5,ffffffe000201e08 <vprintfmt+0x254>
ffffffe000201de0:	f5043783          	ld	a5,-176(s0)
ffffffe000201de4:	0007c783          	lbu	a5,0(a5)
ffffffe000201de8:	00078713          	mv	a4,a5
ffffffe000201dec:	05800793          	li	a5,88
ffffffe000201df0:	00f70c63          	beq	a4,a5,ffffffe000201e08 <vprintfmt+0x254>
ffffffe000201df4:	f5043783          	ld	a5,-176(s0)
ffffffe000201df8:	0007c783          	lbu	a5,0(a5)
ffffffe000201dfc:	00078713          	mv	a4,a5
ffffffe000201e00:	07000793          	li	a5,112
ffffffe000201e04:	30f71063          	bne	a4,a5,ffffffe000202104 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201e08:	f5043783          	ld	a5,-176(s0)
ffffffe000201e0c:	0007c783          	lbu	a5,0(a5)
ffffffe000201e10:	00078713          	mv	a4,a5
ffffffe000201e14:	07000793          	li	a5,112
ffffffe000201e18:	00f70663          	beq	a4,a5,ffffffe000201e24 <vprintfmt+0x270>
ffffffe000201e1c:	f8144783          	lbu	a5,-127(s0)
ffffffe000201e20:	00078663          	beqz	a5,ffffffe000201e2c <vprintfmt+0x278>
ffffffe000201e24:	00100793          	li	a5,1
ffffffe000201e28:	0080006f          	j	ffffffe000201e30 <vprintfmt+0x27c>
ffffffe000201e2c:	00000793          	li	a5,0
ffffffe000201e30:	faf403a3          	sb	a5,-89(s0)
ffffffe000201e34:	fa744783          	lbu	a5,-89(s0)
ffffffe000201e38:	0017f793          	andi	a5,a5,1
ffffffe000201e3c:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201e40:	fa744783          	lbu	a5,-89(s0)
ffffffe000201e44:	0ff7f793          	zext.b	a5,a5
ffffffe000201e48:	00078c63          	beqz	a5,ffffffe000201e60 <vprintfmt+0x2ac>
ffffffe000201e4c:	f4843783          	ld	a5,-184(s0)
ffffffe000201e50:	00878713          	addi	a4,a5,8
ffffffe000201e54:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e58:	0007b783          	ld	a5,0(a5)
ffffffe000201e5c:	01c0006f          	j	ffffffe000201e78 <vprintfmt+0x2c4>
ffffffe000201e60:	f4843783          	ld	a5,-184(s0)
ffffffe000201e64:	00878713          	addi	a4,a5,8
ffffffe000201e68:	f4e43423          	sd	a4,-184(s0)
ffffffe000201e6c:	0007a783          	lw	a5,0(a5)
ffffffe000201e70:	02079793          	slli	a5,a5,0x20
ffffffe000201e74:	0207d793          	srli	a5,a5,0x20
ffffffe000201e78:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201e7c:	f8c42783          	lw	a5,-116(s0)
ffffffe000201e80:	02079463          	bnez	a5,ffffffe000201ea8 <vprintfmt+0x2f4>
ffffffe000201e84:	fe043783          	ld	a5,-32(s0)
ffffffe000201e88:	02079063          	bnez	a5,ffffffe000201ea8 <vprintfmt+0x2f4>
ffffffe000201e8c:	f5043783          	ld	a5,-176(s0)
ffffffe000201e90:	0007c783          	lbu	a5,0(a5)
ffffffe000201e94:	00078713          	mv	a4,a5
ffffffe000201e98:	07000793          	li	a5,112
ffffffe000201e9c:	00f70663          	beq	a4,a5,ffffffe000201ea8 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201ea0:	f8040023          	sb	zero,-128(s0)
ffffffe000201ea4:	4cc0006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201ea8:	f5043783          	ld	a5,-176(s0)
ffffffe000201eac:	0007c783          	lbu	a5,0(a5)
ffffffe000201eb0:	00078713          	mv	a4,a5
ffffffe000201eb4:	07000793          	li	a5,112
ffffffe000201eb8:	00f70a63          	beq	a4,a5,ffffffe000201ecc <vprintfmt+0x318>
ffffffe000201ebc:	f8244783          	lbu	a5,-126(s0)
ffffffe000201ec0:	00078a63          	beqz	a5,ffffffe000201ed4 <vprintfmt+0x320>
ffffffe000201ec4:	fe043783          	ld	a5,-32(s0)
ffffffe000201ec8:	00078663          	beqz	a5,ffffffe000201ed4 <vprintfmt+0x320>
ffffffe000201ecc:	00100793          	li	a5,1
ffffffe000201ed0:	0080006f          	j	ffffffe000201ed8 <vprintfmt+0x324>
ffffffe000201ed4:	00000793          	li	a5,0
ffffffe000201ed8:	faf40323          	sb	a5,-90(s0)
ffffffe000201edc:	fa644783          	lbu	a5,-90(s0)
ffffffe000201ee0:	0017f793          	andi	a5,a5,1
ffffffe000201ee4:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201ee8:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201eec:	f5043783          	ld	a5,-176(s0)
ffffffe000201ef0:	0007c783          	lbu	a5,0(a5)
ffffffe000201ef4:	00078713          	mv	a4,a5
ffffffe000201ef8:	05800793          	li	a5,88
ffffffe000201efc:	00f71863          	bne	a4,a5,ffffffe000201f0c <vprintfmt+0x358>
ffffffe000201f00:	00001797          	auipc	a5,0x1
ffffffe000201f04:	4e078793          	addi	a5,a5,1248 # ffffffe0002033e0 <upperxdigits.1>
ffffffe000201f08:	00c0006f          	j	ffffffe000201f14 <vprintfmt+0x360>
ffffffe000201f0c:	00001797          	auipc	a5,0x1
ffffffe000201f10:	4ec78793          	addi	a5,a5,1260 # ffffffe0002033f8 <lowerxdigits.0>
ffffffe000201f14:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201f18:	fe043783          	ld	a5,-32(s0)
ffffffe000201f1c:	00f7f793          	andi	a5,a5,15
ffffffe000201f20:	f9843703          	ld	a4,-104(s0)
ffffffe000201f24:	00f70733          	add	a4,a4,a5
ffffffe000201f28:	fdc42783          	lw	a5,-36(s0)
ffffffe000201f2c:	0017869b          	addiw	a3,a5,1
ffffffe000201f30:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201f34:	00074703          	lbu	a4,0(a4)
ffffffe000201f38:	ff078793          	addi	a5,a5,-16
ffffffe000201f3c:	008787b3          	add	a5,a5,s0
ffffffe000201f40:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201f44:	fe043783          	ld	a5,-32(s0)
ffffffe000201f48:	0047d793          	srli	a5,a5,0x4
ffffffe000201f4c:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201f50:	fe043783          	ld	a5,-32(s0)
ffffffe000201f54:	fc0792e3          	bnez	a5,ffffffe000201f18 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201f58:	f8c42703          	lw	a4,-116(s0)
ffffffe000201f5c:	fff00793          	li	a5,-1
ffffffe000201f60:	02f71663          	bne	a4,a5,ffffffe000201f8c <vprintfmt+0x3d8>
ffffffe000201f64:	f8344783          	lbu	a5,-125(s0)
ffffffe000201f68:	02078263          	beqz	a5,ffffffe000201f8c <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201f6c:	f8842703          	lw	a4,-120(s0)
ffffffe000201f70:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f74:	0007879b          	sext.w	a5,a5
ffffffe000201f78:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f7c:	0007879b          	sext.w	a5,a5
ffffffe000201f80:	40f707bb          	subw	a5,a4,a5
ffffffe000201f84:	0007879b          	sext.w	a5,a5
ffffffe000201f88:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f8c:	f8842703          	lw	a4,-120(s0)
ffffffe000201f90:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f94:	0007879b          	sext.w	a5,a5
ffffffe000201f98:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f9c:	0007879b          	sext.w	a5,a5
ffffffe000201fa0:	40f707bb          	subw	a5,a4,a5
ffffffe000201fa4:	0007871b          	sext.w	a4,a5
ffffffe000201fa8:	fdc42783          	lw	a5,-36(s0)
ffffffe000201fac:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201fb0:	f8c42783          	lw	a5,-116(s0)
ffffffe000201fb4:	f8f42823          	sw	a5,-112(s0)
ffffffe000201fb8:	f9442783          	lw	a5,-108(s0)
ffffffe000201fbc:	00078593          	mv	a1,a5
ffffffe000201fc0:	f9042783          	lw	a5,-112(s0)
ffffffe000201fc4:	00078613          	mv	a2,a5
ffffffe000201fc8:	0006069b          	sext.w	a3,a2
ffffffe000201fcc:	0005879b          	sext.w	a5,a1
ffffffe000201fd0:	00f6d463          	bge	a3,a5,ffffffe000201fd8 <vprintfmt+0x424>
ffffffe000201fd4:	00058613          	mv	a2,a1
ffffffe000201fd8:	0006079b          	sext.w	a5,a2
ffffffe000201fdc:	40f707bb          	subw	a5,a4,a5
ffffffe000201fe0:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201fe4:	0280006f          	j	ffffffe00020200c <vprintfmt+0x458>
                    putch(' ');
ffffffe000201fe8:	f5843783          	ld	a5,-168(s0)
ffffffe000201fec:	02000513          	li	a0,32
ffffffe000201ff0:	000780e7          	jalr	a5
                    ++written;
ffffffe000201ff4:	fec42783          	lw	a5,-20(s0)
ffffffe000201ff8:	0017879b          	addiw	a5,a5,1
ffffffe000201ffc:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000202000:	fd842783          	lw	a5,-40(s0)
ffffffe000202004:	fff7879b          	addiw	a5,a5,-1
ffffffe000202008:	fcf42c23          	sw	a5,-40(s0)
ffffffe00020200c:	fd842783          	lw	a5,-40(s0)
ffffffe000202010:	0007879b          	sext.w	a5,a5
ffffffe000202014:	fcf04ae3          	bgtz	a5,ffffffe000201fe8 <vprintfmt+0x434>
                }

                if (prefix) {
ffffffe000202018:	fa644783          	lbu	a5,-90(s0)
ffffffe00020201c:	0ff7f793          	zext.b	a5,a5
ffffffe000202020:	04078463          	beqz	a5,ffffffe000202068 <vprintfmt+0x4b4>
                    putch('0');
ffffffe000202024:	f5843783          	ld	a5,-168(s0)
ffffffe000202028:	03000513          	li	a0,48
ffffffe00020202c:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000202030:	f5043783          	ld	a5,-176(s0)
ffffffe000202034:	0007c783          	lbu	a5,0(a5)
ffffffe000202038:	00078713          	mv	a4,a5
ffffffe00020203c:	05800793          	li	a5,88
ffffffe000202040:	00f71663          	bne	a4,a5,ffffffe00020204c <vprintfmt+0x498>
ffffffe000202044:	05800793          	li	a5,88
ffffffe000202048:	0080006f          	j	ffffffe000202050 <vprintfmt+0x49c>
ffffffe00020204c:	07800793          	li	a5,120
ffffffe000202050:	f5843703          	ld	a4,-168(s0)
ffffffe000202054:	00078513          	mv	a0,a5
ffffffe000202058:	000700e7          	jalr	a4
                    written += 2;
ffffffe00020205c:	fec42783          	lw	a5,-20(s0)
ffffffe000202060:	0027879b          	addiw	a5,a5,2
ffffffe000202064:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000202068:	fdc42783          	lw	a5,-36(s0)
ffffffe00020206c:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202070:	0280006f          	j	ffffffe000202098 <vprintfmt+0x4e4>
                    putch('0');
ffffffe000202074:	f5843783          	ld	a5,-168(s0)
ffffffe000202078:	03000513          	li	a0,48
ffffffe00020207c:	000780e7          	jalr	a5
                    ++written;
ffffffe000202080:	fec42783          	lw	a5,-20(s0)
ffffffe000202084:	0017879b          	addiw	a5,a5,1
ffffffe000202088:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe00020208c:	fd442783          	lw	a5,-44(s0)
ffffffe000202090:	0017879b          	addiw	a5,a5,1
ffffffe000202094:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202098:	f8c42783          	lw	a5,-116(s0)
ffffffe00020209c:	fd442703          	lw	a4,-44(s0)
ffffffe0002020a0:	0007071b          	sext.w	a4,a4
ffffffe0002020a4:	fcf748e3          	blt	a4,a5,ffffffe000202074 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe0002020a8:	fdc42783          	lw	a5,-36(s0)
ffffffe0002020ac:	fff7879b          	addiw	a5,a5,-1
ffffffe0002020b0:	fcf42823          	sw	a5,-48(s0)
ffffffe0002020b4:	03c0006f          	j	ffffffe0002020f0 <vprintfmt+0x53c>
                    putch(buf[i]);
ffffffe0002020b8:	fd042783          	lw	a5,-48(s0)
ffffffe0002020bc:	ff078793          	addi	a5,a5,-16
ffffffe0002020c0:	008787b3          	add	a5,a5,s0
ffffffe0002020c4:	f807c783          	lbu	a5,-128(a5)
ffffffe0002020c8:	0007871b          	sext.w	a4,a5
ffffffe0002020cc:	f5843783          	ld	a5,-168(s0)
ffffffe0002020d0:	00070513          	mv	a0,a4
ffffffe0002020d4:	000780e7          	jalr	a5
                    ++written;
ffffffe0002020d8:	fec42783          	lw	a5,-20(s0)
ffffffe0002020dc:	0017879b          	addiw	a5,a5,1
ffffffe0002020e0:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe0002020e4:	fd042783          	lw	a5,-48(s0)
ffffffe0002020e8:	fff7879b          	addiw	a5,a5,-1
ffffffe0002020ec:	fcf42823          	sw	a5,-48(s0)
ffffffe0002020f0:	fd042783          	lw	a5,-48(s0)
ffffffe0002020f4:	0007879b          	sext.w	a5,a5
ffffffe0002020f8:	fc07d0e3          	bgez	a5,ffffffe0002020b8 <vprintfmt+0x504>
                }

                flags.in_format = false;
ffffffe0002020fc:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000202100:	2700006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202104:	f5043783          	ld	a5,-176(s0)
ffffffe000202108:	0007c783          	lbu	a5,0(a5)
ffffffe00020210c:	00078713          	mv	a4,a5
ffffffe000202110:	06400793          	li	a5,100
ffffffe000202114:	02f70663          	beq	a4,a5,ffffffe000202140 <vprintfmt+0x58c>
ffffffe000202118:	f5043783          	ld	a5,-176(s0)
ffffffe00020211c:	0007c783          	lbu	a5,0(a5)
ffffffe000202120:	00078713          	mv	a4,a5
ffffffe000202124:	06900793          	li	a5,105
ffffffe000202128:	00f70c63          	beq	a4,a5,ffffffe000202140 <vprintfmt+0x58c>
ffffffe00020212c:	f5043783          	ld	a5,-176(s0)
ffffffe000202130:	0007c783          	lbu	a5,0(a5)
ffffffe000202134:	00078713          	mv	a4,a5
ffffffe000202138:	07500793          	li	a5,117
ffffffe00020213c:	08f71063          	bne	a4,a5,ffffffe0002021bc <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe000202140:	f8144783          	lbu	a5,-127(s0)
ffffffe000202144:	00078c63          	beqz	a5,ffffffe00020215c <vprintfmt+0x5a8>
ffffffe000202148:	f4843783          	ld	a5,-184(s0)
ffffffe00020214c:	00878713          	addi	a4,a5,8
ffffffe000202150:	f4e43423          	sd	a4,-184(s0)
ffffffe000202154:	0007b783          	ld	a5,0(a5)
ffffffe000202158:	0140006f          	j	ffffffe00020216c <vprintfmt+0x5b8>
ffffffe00020215c:	f4843783          	ld	a5,-184(s0)
ffffffe000202160:	00878713          	addi	a4,a5,8
ffffffe000202164:	f4e43423          	sd	a4,-184(s0)
ffffffe000202168:	0007a783          	lw	a5,0(a5)
ffffffe00020216c:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe000202170:	fa843583          	ld	a1,-88(s0)
ffffffe000202174:	f5043783          	ld	a5,-176(s0)
ffffffe000202178:	0007c783          	lbu	a5,0(a5)
ffffffe00020217c:	0007871b          	sext.w	a4,a5
ffffffe000202180:	07500793          	li	a5,117
ffffffe000202184:	40f707b3          	sub	a5,a4,a5
ffffffe000202188:	00f037b3          	snez	a5,a5
ffffffe00020218c:	0ff7f793          	zext.b	a5,a5
ffffffe000202190:	f8040713          	addi	a4,s0,-128
ffffffe000202194:	00070693          	mv	a3,a4
ffffffe000202198:	00078613          	mv	a2,a5
ffffffe00020219c:	f5843503          	ld	a0,-168(s0)
ffffffe0002021a0:	ee4ff0ef          	jal	ffffffe000201884 <print_dec_int>
ffffffe0002021a4:	00050793          	mv	a5,a0
ffffffe0002021a8:	fec42703          	lw	a4,-20(s0)
ffffffe0002021ac:	00f707bb          	addw	a5,a4,a5
ffffffe0002021b0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002021b4:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe0002021b8:	1b80006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
ffffffe0002021bc:	f5043783          	ld	a5,-176(s0)
ffffffe0002021c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002021c4:	00078713          	mv	a4,a5
ffffffe0002021c8:	06e00793          	li	a5,110
ffffffe0002021cc:	04f71c63          	bne	a4,a5,ffffffe000202224 <vprintfmt+0x670>
                if (flags.longflag) {
ffffffe0002021d0:	f8144783          	lbu	a5,-127(s0)
ffffffe0002021d4:	02078463          	beqz	a5,ffffffe0002021fc <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
ffffffe0002021d8:	f4843783          	ld	a5,-184(s0)
ffffffe0002021dc:	00878713          	addi	a4,a5,8
ffffffe0002021e0:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021e4:	0007b783          	ld	a5,0(a5)
ffffffe0002021e8:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe0002021ec:	fec42703          	lw	a4,-20(s0)
ffffffe0002021f0:	fb043783          	ld	a5,-80(s0)
ffffffe0002021f4:	00e7b023          	sd	a4,0(a5)
ffffffe0002021f8:	0240006f          	j	ffffffe00020221c <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe0002021fc:	f4843783          	ld	a5,-184(s0)
ffffffe000202200:	00878713          	addi	a4,a5,8
ffffffe000202204:	f4e43423          	sd	a4,-184(s0)
ffffffe000202208:	0007b783          	ld	a5,0(a5)
ffffffe00020220c:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000202210:	fb843783          	ld	a5,-72(s0)
ffffffe000202214:	fec42703          	lw	a4,-20(s0)
ffffffe000202218:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe00020221c:	f8040023          	sb	zero,-128(s0)
ffffffe000202220:	1500006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
ffffffe000202224:	f5043783          	ld	a5,-176(s0)
ffffffe000202228:	0007c783          	lbu	a5,0(a5)
ffffffe00020222c:	00078713          	mv	a4,a5
ffffffe000202230:	07300793          	li	a5,115
ffffffe000202234:	02f71e63          	bne	a4,a5,ffffffe000202270 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
ffffffe000202238:	f4843783          	ld	a5,-184(s0)
ffffffe00020223c:	00878713          	addi	a4,a5,8
ffffffe000202240:	f4e43423          	sd	a4,-184(s0)
ffffffe000202244:	0007b783          	ld	a5,0(a5)
ffffffe000202248:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe00020224c:	fc043583          	ld	a1,-64(s0)
ffffffe000202250:	f5843503          	ld	a0,-168(s0)
ffffffe000202254:	da8ff0ef          	jal	ffffffe0002017fc <puts_wo_nl>
ffffffe000202258:	00050793          	mv	a5,a0
ffffffe00020225c:	fec42703          	lw	a4,-20(s0)
ffffffe000202260:	00f707bb          	addw	a5,a4,a5
ffffffe000202264:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202268:	f8040023          	sb	zero,-128(s0)
ffffffe00020226c:	1040006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
ffffffe000202270:	f5043783          	ld	a5,-176(s0)
ffffffe000202274:	0007c783          	lbu	a5,0(a5)
ffffffe000202278:	00078713          	mv	a4,a5
ffffffe00020227c:	06300793          	li	a5,99
ffffffe000202280:	02f71e63          	bne	a4,a5,ffffffe0002022bc <vprintfmt+0x708>
                int ch = va_arg(vl, int);
ffffffe000202284:	f4843783          	ld	a5,-184(s0)
ffffffe000202288:	00878713          	addi	a4,a5,8
ffffffe00020228c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202290:	0007a783          	lw	a5,0(a5)
ffffffe000202294:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000202298:	fcc42703          	lw	a4,-52(s0)
ffffffe00020229c:	f5843783          	ld	a5,-168(s0)
ffffffe0002022a0:	00070513          	mv	a0,a4
ffffffe0002022a4:	000780e7          	jalr	a5
                ++written;
ffffffe0002022a8:	fec42783          	lw	a5,-20(s0)
ffffffe0002022ac:	0017879b          	addiw	a5,a5,1
ffffffe0002022b0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002022b4:	f8040023          	sb	zero,-128(s0)
ffffffe0002022b8:	0b80006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
ffffffe0002022bc:	f5043783          	ld	a5,-176(s0)
ffffffe0002022c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002022c4:	00078713          	mv	a4,a5
ffffffe0002022c8:	02500793          	li	a5,37
ffffffe0002022cc:	02f71263          	bne	a4,a5,ffffffe0002022f0 <vprintfmt+0x73c>
                putch('%');
ffffffe0002022d0:	f5843783          	ld	a5,-168(s0)
ffffffe0002022d4:	02500513          	li	a0,37
ffffffe0002022d8:	000780e7          	jalr	a5
                ++written;
ffffffe0002022dc:	fec42783          	lw	a5,-20(s0)
ffffffe0002022e0:	0017879b          	addiw	a5,a5,1
ffffffe0002022e4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002022e8:	f8040023          	sb	zero,-128(s0)
ffffffe0002022ec:	0840006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
ffffffe0002022f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002022f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002022f8:	0007871b          	sext.w	a4,a5
ffffffe0002022fc:	f5843783          	ld	a5,-168(s0)
ffffffe000202300:	00070513          	mv	a0,a4
ffffffe000202304:	000780e7          	jalr	a5
                ++written;
ffffffe000202308:	fec42783          	lw	a5,-20(s0)
ffffffe00020230c:	0017879b          	addiw	a5,a5,1
ffffffe000202310:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202314:	f8040023          	sb	zero,-128(s0)
ffffffe000202318:	0580006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
ffffffe00020231c:	f5043783          	ld	a5,-176(s0)
ffffffe000202320:	0007c783          	lbu	a5,0(a5)
ffffffe000202324:	00078713          	mv	a4,a5
ffffffe000202328:	02500793          	li	a5,37
ffffffe00020232c:	02f71063          	bne	a4,a5,ffffffe00020234c <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe000202330:	f8043023          	sd	zero,-128(s0)
ffffffe000202334:	f8043423          	sd	zero,-120(s0)
ffffffe000202338:	00100793          	li	a5,1
ffffffe00020233c:	f8f40023          	sb	a5,-128(s0)
ffffffe000202340:	fff00793          	li	a5,-1
ffffffe000202344:	f8f42623          	sw	a5,-116(s0)
ffffffe000202348:	0280006f          	j	ffffffe000202370 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
ffffffe00020234c:	f5043783          	ld	a5,-176(s0)
ffffffe000202350:	0007c783          	lbu	a5,0(a5)
ffffffe000202354:	0007871b          	sext.w	a4,a5
ffffffe000202358:	f5843783          	ld	a5,-168(s0)
ffffffe00020235c:	00070513          	mv	a0,a4
ffffffe000202360:	000780e7          	jalr	a5
            ++written;
ffffffe000202364:	fec42783          	lw	a5,-20(s0)
ffffffe000202368:	0017879b          	addiw	a5,a5,1
ffffffe00020236c:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe000202370:	f5043783          	ld	a5,-176(s0)
ffffffe000202374:	00178793          	addi	a5,a5,1
ffffffe000202378:	f4f43823          	sd	a5,-176(s0)
ffffffe00020237c:	f5043783          	ld	a5,-176(s0)
ffffffe000202380:	0007c783          	lbu	a5,0(a5)
ffffffe000202384:	84079ee3          	bnez	a5,ffffffe000201be0 <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202388:	fec42783          	lw	a5,-20(s0)
}
ffffffe00020238c:	00078513          	mv	a0,a5
ffffffe000202390:	0b813083          	ld	ra,184(sp)
ffffffe000202394:	0b013403          	ld	s0,176(sp)
ffffffe000202398:	0c010113          	addi	sp,sp,192
ffffffe00020239c:	00008067          	ret

ffffffe0002023a0 <printk>:

int printk(const char* s, ...) {
ffffffe0002023a0:	f9010113          	addi	sp,sp,-112
ffffffe0002023a4:	02113423          	sd	ra,40(sp)
ffffffe0002023a8:	02813023          	sd	s0,32(sp)
ffffffe0002023ac:	03010413          	addi	s0,sp,48
ffffffe0002023b0:	fca43c23          	sd	a0,-40(s0)
ffffffe0002023b4:	00b43423          	sd	a1,8(s0)
ffffffe0002023b8:	00c43823          	sd	a2,16(s0)
ffffffe0002023bc:	00d43c23          	sd	a3,24(s0)
ffffffe0002023c0:	02e43023          	sd	a4,32(s0)
ffffffe0002023c4:	02f43423          	sd	a5,40(s0)
ffffffe0002023c8:	03043823          	sd	a6,48(s0)
ffffffe0002023cc:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe0002023d0:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe0002023d4:	04040793          	addi	a5,s0,64
ffffffe0002023d8:	fcf43823          	sd	a5,-48(s0)
ffffffe0002023dc:	fd043783          	ld	a5,-48(s0)
ffffffe0002023e0:	fc878793          	addi	a5,a5,-56
ffffffe0002023e4:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe0002023e8:	fe043783          	ld	a5,-32(s0)
ffffffe0002023ec:	00078613          	mv	a2,a5
ffffffe0002023f0:	fd843583          	ld	a1,-40(s0)
ffffffe0002023f4:	fffff517          	auipc	a0,0xfffff
ffffffe0002023f8:	0ec50513          	addi	a0,a0,236 # ffffffe0002014e0 <putc>
ffffffe0002023fc:	fb8ff0ef          	jal	ffffffe000201bb4 <vprintfmt>
ffffffe000202400:	00050793          	mv	a5,a0
ffffffe000202404:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000202408:	fec42783          	lw	a5,-20(s0)
}
ffffffe00020240c:	00078513          	mv	a0,a5
ffffffe000202410:	02813083          	ld	ra,40(sp)
ffffffe000202414:	02013403          	ld	s0,32(sp)
ffffffe000202418:	07010113          	addi	sp,sp,112
ffffffe00020241c:	00008067          	ret

ffffffe000202420 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe000202420:	fe010113          	addi	sp,sp,-32
ffffffe000202424:	00113c23          	sd	ra,24(sp)
ffffffe000202428:	00813823          	sd	s0,16(sp)
ffffffe00020242c:	02010413          	addi	s0,sp,32
ffffffe000202430:	00050793          	mv	a5,a0
ffffffe000202434:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe000202438:	fec42783          	lw	a5,-20(s0)
ffffffe00020243c:	fff7879b          	addiw	a5,a5,-1
ffffffe000202440:	0007879b          	sext.w	a5,a5
ffffffe000202444:	02079713          	slli	a4,a5,0x20
ffffffe000202448:	02075713          	srli	a4,a4,0x20
ffffffe00020244c:	00004797          	auipc	a5,0x4
ffffffe000202450:	bcc78793          	addi	a5,a5,-1076 # ffffffe000206018 <seed>
ffffffe000202454:	00e7b023          	sd	a4,0(a5)
}
ffffffe000202458:	00000013          	nop
ffffffe00020245c:	01813083          	ld	ra,24(sp)
ffffffe000202460:	01013403          	ld	s0,16(sp)
ffffffe000202464:	02010113          	addi	sp,sp,32
ffffffe000202468:	00008067          	ret

ffffffe00020246c <rand>:

int rand(void) {
ffffffe00020246c:	ff010113          	addi	sp,sp,-16
ffffffe000202470:	00113423          	sd	ra,8(sp)
ffffffe000202474:	00813023          	sd	s0,0(sp)
ffffffe000202478:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe00020247c:	00004797          	auipc	a5,0x4
ffffffe000202480:	b9c78793          	addi	a5,a5,-1124 # ffffffe000206018 <seed>
ffffffe000202484:	0007b703          	ld	a4,0(a5)
ffffffe000202488:	00001797          	auipc	a5,0x1
ffffffe00020248c:	f8878793          	addi	a5,a5,-120 # ffffffe000203410 <lowerxdigits.0+0x18>
ffffffe000202490:	0007b783          	ld	a5,0(a5)
ffffffe000202494:	02f707b3          	mul	a5,a4,a5
ffffffe000202498:	00178713          	addi	a4,a5,1
ffffffe00020249c:	00004797          	auipc	a5,0x4
ffffffe0002024a0:	b7c78793          	addi	a5,a5,-1156 # ffffffe000206018 <seed>
ffffffe0002024a4:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe0002024a8:	00004797          	auipc	a5,0x4
ffffffe0002024ac:	b7078793          	addi	a5,a5,-1168 # ffffffe000206018 <seed>
ffffffe0002024b0:	0007b783          	ld	a5,0(a5)
ffffffe0002024b4:	0217d793          	srli	a5,a5,0x21
ffffffe0002024b8:	0007879b          	sext.w	a5,a5
}
ffffffe0002024bc:	00078513          	mv	a0,a5
ffffffe0002024c0:	00813083          	ld	ra,8(sp)
ffffffe0002024c4:	00013403          	ld	s0,0(sp)
ffffffe0002024c8:	01010113          	addi	sp,sp,16
ffffffe0002024cc:	00008067          	ret

ffffffe0002024d0 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe0002024d0:	fc010113          	addi	sp,sp,-64
ffffffe0002024d4:	02113c23          	sd	ra,56(sp)
ffffffe0002024d8:	02813823          	sd	s0,48(sp)
ffffffe0002024dc:	04010413          	addi	s0,sp,64
ffffffe0002024e0:	fca43c23          	sd	a0,-40(s0)
ffffffe0002024e4:	00058793          	mv	a5,a1
ffffffe0002024e8:	fcc43423          	sd	a2,-56(s0)
ffffffe0002024ec:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe0002024f0:	fd843783          	ld	a5,-40(s0)
ffffffe0002024f4:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe0002024f8:	fe043423          	sd	zero,-24(s0)
ffffffe0002024fc:	0280006f          	j	ffffffe000202524 <memset+0x54>
        s[i] = c;
ffffffe000202500:	fe043703          	ld	a4,-32(s0)
ffffffe000202504:	fe843783          	ld	a5,-24(s0)
ffffffe000202508:	00f707b3          	add	a5,a4,a5
ffffffe00020250c:	fd442703          	lw	a4,-44(s0)
ffffffe000202510:	0ff77713          	zext.b	a4,a4
ffffffe000202514:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202518:	fe843783          	ld	a5,-24(s0)
ffffffe00020251c:	00178793          	addi	a5,a5,1
ffffffe000202520:	fef43423          	sd	a5,-24(s0)
ffffffe000202524:	fe843703          	ld	a4,-24(s0)
ffffffe000202528:	fc843783          	ld	a5,-56(s0)
ffffffe00020252c:	fcf76ae3          	bltu	a4,a5,ffffffe000202500 <memset+0x30>
    }
    return dest;
ffffffe000202530:	fd843783          	ld	a5,-40(s0)
}
ffffffe000202534:	00078513          	mv	a0,a5
ffffffe000202538:	03813083          	ld	ra,56(sp)
ffffffe00020253c:	03013403          	ld	s0,48(sp)
ffffffe000202540:	04010113          	addi	sp,sp,64
ffffffe000202544:	00008067          	ret
