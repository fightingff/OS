
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
ffffffe000200008:	789000ef          	jal	ffffffe000200f90 <setup_vm>
    call relocate
ffffffe00020000c:	034000ef          	jal	ffffffe000200040 <relocate>
    
    call mm_init
ffffffe000200010:	3f0000ef          	jal	ffffffe000200400 <mm_init>
    call setup_vm_final
ffffffe000200014:	048010ef          	jal	ffffffe00020105c <setup_vm_final>
    call task_init
ffffffe000200018:	438000ef          	jal	ffffffe000200450 <task_init>

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
ffffffe000200030:	230000ef          	jal	ffffffe000200260 <clock_set_next_event>
    # set first time interrupt
    # directly call clock_set_next_event to set mtimecmp
    
    li t0, 2
ffffffe000200034:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
ffffffe000200038:	1002a073          	csrs	sstatus,t0

    call start_kernel
ffffffe00020003c:	38c010ef          	jal	ffffffe0002013c8 <start_kernel>

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
    csrw stvec, ra # set stvec = va(ra)
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
ffffffe000200118:	611000ef          	jal	ffffffe000200f28 <trap_handler>
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
ffffffe0002001b0:	4a828293          	addi	t0,t0,1192 # ffffffe000200654 <dummy>
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
ffffffe00020023c:	00813c23          	sd	s0,24(sp)
ffffffe000200240:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    __asm__ __volatile__(
ffffffe000200244:	c01027f3          	rdtime	a5
ffffffe000200248:	fef43423          	sd	a5,-24(s0)
        "rdtime %[cycles]\n" 
        : [cycles]"=r"(cycles)
    );
    return cycles;
ffffffe00020024c:	fe843783          	ld	a5,-24(s0)
}
ffffffe000200250:	00078513          	mv	a0,a5
ffffffe000200254:	01813403          	ld	s0,24(sp)
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
ffffffe000200270:	fc9ff0ef          	jal	ffffffe000200238 <get_cycles>
ffffffe000200274:	00050713          	mv	a4,a0
ffffffe000200278:	00004797          	auipc	a5,0x4
ffffffe00020027c:	d8878793          	addi	a5,a5,-632 # ffffffe000204000 <TIMECLOCK>
ffffffe000200280:	0007b783          	ld	a5,0(a5)
ffffffe000200284:	00f707b3          	add	a5,a4,a5
ffffffe000200288:	fef43423          	sd	a5,-24(s0)

    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
ffffffe00020028c:	fe843503          	ld	a0,-24(s0)
ffffffe000200290:	2e5000ef          	jal	ffffffe000200d74 <sbi_set_timer>
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
ffffffe0002002e8:	158020ef          	jal	ffffffe000202440 <memset>
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

    // LOG(RED "kfree(addr: %p)" CLEAR, addr);

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
ffffffe000200340:	100020ef          	jal	ffffffe000202440 <memset>

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
    // LOG(RED "kfreerange(start: %p, end: %p)" CLEAR, start, end);
    char *addr = (char *)PGROUNDUP((uintptr_t)start);
ffffffe00020039c:	fd843703          	ld	a4,-40(s0)
ffffffe0002003a0:	000017b7          	lui	a5,0x1
ffffffe0002003a4:	fff78793          	addi	a5,a5,-1 # fff <PGSIZE-0x1>
ffffffe0002003a8:	00f70733          	add	a4,a4,a5
ffffffe0002003ac:	fffff7b7          	lui	a5,0xfffff
ffffffe0002003b0:	00f777b3          	and	a5,a4,a5
ffffffe0002003b4:	fef43423          	sd	a5,-24(s0)
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
ffffffe0002003b8:	01c0006f          	j	ffffffe0002003d4 <kfreerange+0x50>
        kfree((void *)addr);
ffffffe0002003bc:	fe843503          	ld	a0,-24(s0)
ffffffe0002003c0:	f45ff0ef          	jal	ffffffe000200304 <kfree>
    for (; (uintptr_t)(addr) + PGSIZE <= (uintptr_t)end; addr += PGSIZE) { // ? 这里改成 < 了
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
ffffffe000200414:	bf050513          	addi	a0,a0,-1040 # ffffffe000203000 <_srodata>
ffffffe000200418:	709010ef          	jal	ffffffe000202320 <printk>
    kfreerange(_ekernel, (char *)VM_END);
ffffffe00020041c:	c0100793          	li	a5,-1023
ffffffe000200420:	01b79593          	slli	a1,a5,0x1b
ffffffe000200424:	00009517          	auipc	a0,0x9
ffffffe000200428:	bdc50513          	addi	a0,a0,-1060 # ffffffe000209000 <_ebss>
ffffffe00020042c:	f59ff0ef          	jal	ffffffe000200384 <kfreerange>
    printk("...mm_init done!\n");
ffffffe000200430:	00003517          	auipc	a0,0x3
ffffffe000200434:	be850513          	addi	a0,a0,-1048 # ffffffe000203018 <_srodata+0x18>
ffffffe000200438:	6e9010ef          	jal	ffffffe000202320 <printk>
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
ffffffe000200464:	73d010ef          	jal	ffffffe0002023a0 <srand>

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
ffffffe0002004d0:	b5c78793          	addi	a5,a5,-1188 # ffffffe000206028 <task>
ffffffe0002004d4:	00e7b023          	sd	a4,0(a5)
ffffffe0002004d8:	00006797          	auipc	a5,0x6
ffffffe0002004dc:	b5078793          	addi	a5,a5,-1200 # ffffffe000206028 <task>
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
ffffffe0002004f8:	12c0006f          	j	ffffffe000200624 <task_init+0x1d4>
        task[i] = (struct task_struct *)kalloc();
ffffffe0002004fc:	dadff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe000200500:	00050693          	mv	a3,a0
ffffffe000200504:	00006717          	auipc	a4,0x6
ffffffe000200508:	b2470713          	addi	a4,a4,-1244 # ffffffe000206028 <task>
ffffffe00020050c:	fec42783          	lw	a5,-20(s0)
ffffffe000200510:	00379793          	slli	a5,a5,0x3
ffffffe000200514:	00f707b3          	add	a5,a4,a5
ffffffe000200518:	00d7b023          	sd	a3,0(a5)
        task[i]->state = TASK_RUNNING;
ffffffe00020051c:	00006717          	auipc	a4,0x6
ffffffe000200520:	b0c70713          	addi	a4,a4,-1268 # ffffffe000206028 <task>
ffffffe000200524:	fec42783          	lw	a5,-20(s0)
ffffffe000200528:	00379793          	slli	a5,a5,0x3
ffffffe00020052c:	00f707b3          	add	a5,a4,a5
ffffffe000200530:	0007b783          	ld	a5,0(a5)
ffffffe000200534:	0007b023          	sd	zero,0(a5)

        task[i]->counter = 0;
ffffffe000200538:	00006717          	auipc	a4,0x6
ffffffe00020053c:	af070713          	addi	a4,a4,-1296 # ffffffe000206028 <task>
ffffffe000200540:	fec42783          	lw	a5,-20(s0)
ffffffe000200544:	00379793          	slli	a5,a5,0x3
ffffffe000200548:	00f707b3          	add	a5,a4,a5
ffffffe00020054c:	0007b783          	ld	a5,0(a5)
ffffffe000200550:	0007b423          	sd	zero,8(a5)
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);
ffffffe000200554:	691010ef          	jal	ffffffe0002023e4 <rand>
ffffffe000200558:	00050793          	mv	a5,a0
ffffffe00020055c:	00078713          	mv	a4,a5
ffffffe000200560:	00a00793          	li	a5,10
ffffffe000200564:	02f767bb          	remw	a5,a4,a5
ffffffe000200568:	0007879b          	sext.w	a5,a5
ffffffe00020056c:	0017879b          	addiw	a5,a5,1
ffffffe000200570:	0007869b          	sext.w	a3,a5
ffffffe000200574:	00006717          	auipc	a4,0x6
ffffffe000200578:	ab470713          	addi	a4,a4,-1356 # ffffffe000206028 <task>
ffffffe00020057c:	fec42783          	lw	a5,-20(s0)
ffffffe000200580:	00379793          	slli	a5,a5,0x3
ffffffe000200584:	00f707b3          	add	a5,a4,a5
ffffffe000200588:	0007b783          	ld	a5,0(a5)
ffffffe00020058c:	00068713          	mv	a4,a3
ffffffe000200590:	00e7b823          	sd	a4,16(a5)

        task[i]->pid = i;
ffffffe000200594:	00006717          	auipc	a4,0x6
ffffffe000200598:	a9470713          	addi	a4,a4,-1388 # ffffffe000206028 <task>
ffffffe00020059c:	fec42783          	lw	a5,-20(s0)
ffffffe0002005a0:	00379793          	slli	a5,a5,0x3
ffffffe0002005a4:	00f707b3          	add	a5,a4,a5
ffffffe0002005a8:	0007b783          	ld	a5,0(a5)
ffffffe0002005ac:	fec42703          	lw	a4,-20(s0)
ffffffe0002005b0:	00e7bc23          	sd	a4,24(a5)

        task[i]->thread.ra = (uint64_t)__dummy;
ffffffe0002005b4:	00006717          	auipc	a4,0x6
ffffffe0002005b8:	a7470713          	addi	a4,a4,-1420 # ffffffe000206028 <task>
ffffffe0002005bc:	fec42783          	lw	a5,-20(s0)
ffffffe0002005c0:	00379793          	slli	a5,a5,0x3
ffffffe0002005c4:	00f707b3          	add	a5,a4,a5
ffffffe0002005c8:	0007b783          	ld	a5,0(a5)
ffffffe0002005cc:	00000717          	auipc	a4,0x0
ffffffe0002005d0:	be070713          	addi	a4,a4,-1056 # ffffffe0002001ac <__dummy>
ffffffe0002005d4:	02e7b023          	sd	a4,32(a5)
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
ffffffe0002005d8:	00006717          	auipc	a4,0x6
ffffffe0002005dc:	a5070713          	addi	a4,a4,-1456 # ffffffe000206028 <task>
ffffffe0002005e0:	fec42783          	lw	a5,-20(s0)
ffffffe0002005e4:	00379793          	slli	a5,a5,0x3
ffffffe0002005e8:	00f707b3          	add	a5,a4,a5
ffffffe0002005ec:	0007b783          	ld	a5,0(a5)
ffffffe0002005f0:	00078693          	mv	a3,a5
ffffffe0002005f4:	00006717          	auipc	a4,0x6
ffffffe0002005f8:	a3470713          	addi	a4,a4,-1484 # ffffffe000206028 <task>
ffffffe0002005fc:	fec42783          	lw	a5,-20(s0)
ffffffe000200600:	00379793          	slli	a5,a5,0x3
ffffffe000200604:	00f707b3          	add	a5,a4,a5
ffffffe000200608:	0007b783          	ld	a5,0(a5)
ffffffe00020060c:	00001737          	lui	a4,0x1
ffffffe000200610:	00e68733          	add	a4,a3,a4
ffffffe000200614:	02e7b423          	sd	a4,40(a5)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200618:	fec42783          	lw	a5,-20(s0)
ffffffe00020061c:	0017879b          	addiw	a5,a5,1
ffffffe000200620:	fef42623          	sw	a5,-20(s0)
ffffffe000200624:	fec42783          	lw	a5,-20(s0)
ffffffe000200628:	0007871b          	sext.w	a4,a5
ffffffe00020062c:	00400793          	li	a5,4
ffffffe000200630:	ece7d6e3          	bge	a5,a4,ffffffe0002004fc <task_init+0xac>
    }
    printk("...task_init done!\n");
ffffffe000200634:	00003517          	auipc	a0,0x3
ffffffe000200638:	9fc50513          	addi	a0,a0,-1540 # ffffffe000203030 <_srodata+0x30>
ffffffe00020063c:	4e5010ef          	jal	ffffffe000202320 <printk>
}
ffffffe000200640:	00000013          	nop
ffffffe000200644:	01813083          	ld	ra,24(sp)
ffffffe000200648:	01013403          	ld	s0,16(sp)
ffffffe00020064c:	02010113          	addi	sp,sp,32
ffffffe000200650:	00008067          	ret

ffffffe000200654 <dummy>:
int tasks_output_index = 0;
char expected_output[] = "2222222222111111133334222222222211111113";
#include "sbi.h"
#endif

void dummy() {
ffffffe000200654:	fd010113          	addi	sp,sp,-48
ffffffe000200658:	02113423          	sd	ra,40(sp)
ffffffe00020065c:	02813023          	sd	s0,32(sp)
ffffffe000200660:	03010413          	addi	s0,sp,48
    // LOG(RED);
    uint64_t MOD = 1000000007;
ffffffe000200664:	3b9ad7b7          	lui	a5,0x3b9ad
ffffffe000200668:	a0778793          	addi	a5,a5,-1529 # 3b9aca07 <PHY_SIZE+0x339aca07>
ffffffe00020066c:	fcf43c23          	sd	a5,-40(s0)
    uint64_t auto_inc_local_var = 0;
ffffffe000200670:	fe043423          	sd	zero,-24(s0)
    int last_counter = -1;
ffffffe000200674:	fff00793          	li	a5,-1
ffffffe000200678:	fef42223          	sw	a5,-28(s0)
    while (1) {
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe00020067c:	fe442783          	lw	a5,-28(s0)
ffffffe000200680:	0007871b          	sext.w	a4,a5
ffffffe000200684:	fff00793          	li	a5,-1
ffffffe000200688:	00f70e63          	beq	a4,a5,ffffffe0002006a4 <dummy+0x50>
ffffffe00020068c:	00006797          	auipc	a5,0x6
ffffffe000200690:	98478793          	addi	a5,a5,-1660 # ffffffe000206010 <current>
ffffffe000200694:	0007b783          	ld	a5,0(a5)
ffffffe000200698:	0087b703          	ld	a4,8(a5)
ffffffe00020069c:	fe442783          	lw	a5,-28(s0)
ffffffe0002006a0:	fcf70ee3          	beq	a4,a5,ffffffe00020067c <dummy+0x28>
ffffffe0002006a4:	00006797          	auipc	a5,0x6
ffffffe0002006a8:	96c78793          	addi	a5,a5,-1684 # ffffffe000206010 <current>
ffffffe0002006ac:	0007b783          	ld	a5,0(a5)
ffffffe0002006b0:	0087b783          	ld	a5,8(a5)
ffffffe0002006b4:	fc0784e3          	beqz	a5,ffffffe00020067c <dummy+0x28>
            if (current->counter == 1) {
ffffffe0002006b8:	00006797          	auipc	a5,0x6
ffffffe0002006bc:	95878793          	addi	a5,a5,-1704 # ffffffe000206010 <current>
ffffffe0002006c0:	0007b783          	ld	a5,0(a5)
ffffffe0002006c4:	0087b703          	ld	a4,8(a5)
ffffffe0002006c8:	00100793          	li	a5,1
ffffffe0002006cc:	00f71e63          	bne	a4,a5,ffffffe0002006e8 <dummy+0x94>
                --(current->counter);   // forced the counter to be zero if this thread is going to be scheduled
ffffffe0002006d0:	00006797          	auipc	a5,0x6
ffffffe0002006d4:	94078793          	addi	a5,a5,-1728 # ffffffe000206010 <current>
ffffffe0002006d8:	0007b783          	ld	a5,0(a5)
ffffffe0002006dc:	0087b703          	ld	a4,8(a5)
ffffffe0002006e0:	fff70713          	addi	a4,a4,-1 # fff <PGSIZE-0x1>
ffffffe0002006e4:	00e7b423          	sd	a4,8(a5)
            }                           // in case that the new counter is also 1, leading the information not printed.
            last_counter = current->counter;
ffffffe0002006e8:	00006797          	auipc	a5,0x6
ffffffe0002006ec:	92878793          	addi	a5,a5,-1752 # ffffffe000206010 <current>
ffffffe0002006f0:	0007b783          	ld	a5,0(a5)
ffffffe0002006f4:	0087b783          	ld	a5,8(a5)
ffffffe0002006f8:	fef42223          	sw	a5,-28(s0)
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;
ffffffe0002006fc:	fe843783          	ld	a5,-24(s0)
ffffffe000200700:	00178713          	addi	a4,a5,1
ffffffe000200704:	fd843783          	ld	a5,-40(s0)
ffffffe000200708:	02f777b3          	remu	a5,a4,a5
ffffffe00020070c:	fef43423          	sd	a5,-24(s0)
            printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
ffffffe000200710:	00006797          	auipc	a5,0x6
ffffffe000200714:	90078793          	addi	a5,a5,-1792 # ffffffe000206010 <current>
ffffffe000200718:	0007b783          	ld	a5,0(a5)
ffffffe00020071c:	0187b783          	ld	a5,24(a5)
ffffffe000200720:	fe843603          	ld	a2,-24(s0)
ffffffe000200724:	00078593          	mv	a1,a5
ffffffe000200728:	00003517          	auipc	a0,0x3
ffffffe00020072c:	92050513          	addi	a0,a0,-1760 # ffffffe000203048 <_srodata+0x48>
ffffffe000200730:	3f1010ef          	jal	ffffffe000202320 <printk>
            // LOG(RED "%llu\n", current->thread.ra);
            #if TEST_SCHED
            tasks_output[tasks_output_index++] = current->pid + '0';
ffffffe000200734:	00006797          	auipc	a5,0x6
ffffffe000200738:	8dc78793          	addi	a5,a5,-1828 # ffffffe000206010 <current>
ffffffe00020073c:	0007b783          	ld	a5,0(a5)
ffffffe000200740:	0187b783          	ld	a5,24(a5)
ffffffe000200744:	0ff7f713          	zext.b	a4,a5
ffffffe000200748:	00006797          	auipc	a5,0x6
ffffffe00020074c:	8d078793          	addi	a5,a5,-1840 # ffffffe000206018 <tasks_output_index>
ffffffe000200750:	0007a783          	lw	a5,0(a5)
ffffffe000200754:	0017869b          	addiw	a3,a5,1
ffffffe000200758:	0006861b          	sext.w	a2,a3
ffffffe00020075c:	00006697          	auipc	a3,0x6
ffffffe000200760:	8bc68693          	addi	a3,a3,-1860 # ffffffe000206018 <tasks_output_index>
ffffffe000200764:	00c6a023          	sw	a2,0(a3)
ffffffe000200768:	0307071b          	addiw	a4,a4,48
ffffffe00020076c:	0ff77713          	zext.b	a4,a4
ffffffe000200770:	00006697          	auipc	a3,0x6
ffffffe000200774:	8e068693          	addi	a3,a3,-1824 # ffffffe000206050 <tasks_output>
ffffffe000200778:	00f687b3          	add	a5,a3,a5
ffffffe00020077c:	00e78023          	sb	a4,0(a5)
            if (tasks_output_index == MAX_OUTPUT) {
ffffffe000200780:	00006797          	auipc	a5,0x6
ffffffe000200784:	89878793          	addi	a5,a5,-1896 # ffffffe000206018 <tasks_output_index>
ffffffe000200788:	0007a783          	lw	a5,0(a5)
ffffffe00020078c:	00078713          	mv	a4,a5
ffffffe000200790:	02800793          	li	a5,40
ffffffe000200794:	eef714e3          	bne	a4,a5,ffffffe00020067c <dummy+0x28>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
ffffffe000200798:	fe042023          	sw	zero,-32(s0)
ffffffe00020079c:	0800006f          	j	ffffffe00020081c <dummy+0x1c8>
                    if (tasks_output[i] != expected_output[i]) {
ffffffe0002007a0:	00006717          	auipc	a4,0x6
ffffffe0002007a4:	8b070713          	addi	a4,a4,-1872 # ffffffe000206050 <tasks_output>
ffffffe0002007a8:	fe042783          	lw	a5,-32(s0)
ffffffe0002007ac:	00f707b3          	add	a5,a4,a5
ffffffe0002007b0:	0007c683          	lbu	a3,0(a5)
ffffffe0002007b4:	00004717          	auipc	a4,0x4
ffffffe0002007b8:	85470713          	addi	a4,a4,-1964 # ffffffe000204008 <expected_output>
ffffffe0002007bc:	fe042783          	lw	a5,-32(s0)
ffffffe0002007c0:	00f707b3          	add	a5,a4,a5
ffffffe0002007c4:	0007c783          	lbu	a5,0(a5)
ffffffe0002007c8:	00068713          	mv	a4,a3
ffffffe0002007cc:	04f70263          	beq	a4,a5,ffffffe000200810 <dummy+0x1bc>
                        printk("\033[31mTest failed!\033[0m\n");
ffffffe0002007d0:	00003517          	auipc	a0,0x3
ffffffe0002007d4:	8a850513          	addi	a0,a0,-1880 # ffffffe000203078 <_srodata+0x78>
ffffffe0002007d8:	349010ef          	jal	ffffffe000202320 <printk>
                        printk("\033[31m    Expected: %s\033[0m\n", expected_output);
ffffffe0002007dc:	00004597          	auipc	a1,0x4
ffffffe0002007e0:	82c58593          	addi	a1,a1,-2004 # ffffffe000204008 <expected_output>
ffffffe0002007e4:	00003517          	auipc	a0,0x3
ffffffe0002007e8:	8ac50513          	addi	a0,a0,-1876 # ffffffe000203090 <_srodata+0x90>
ffffffe0002007ec:	335010ef          	jal	ffffffe000202320 <printk>
                        printk("\033[31m    Got:      %s\033[0m\n", tasks_output);
ffffffe0002007f0:	00006597          	auipc	a1,0x6
ffffffe0002007f4:	86058593          	addi	a1,a1,-1952 # ffffffe000206050 <tasks_output>
ffffffe0002007f8:	00003517          	auipc	a0,0x3
ffffffe0002007fc:	8b850513          	addi	a0,a0,-1864 # ffffffe0002030b0 <_srodata+0xb0>
ffffffe000200800:	321010ef          	jal	ffffffe000202320 <printk>
                        sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe000200804:	00000593          	li	a1,0
ffffffe000200808:	00000513          	li	a0,0
ffffffe00020080c:	4cc000ef          	jal	ffffffe000200cd8 <sbi_system_reset>
                for (int i = 0; i < MAX_OUTPUT; ++i) {
ffffffe000200810:	fe042783          	lw	a5,-32(s0)
ffffffe000200814:	0017879b          	addiw	a5,a5,1
ffffffe000200818:	fef42023          	sw	a5,-32(s0)
ffffffe00020081c:	fe042783          	lw	a5,-32(s0)
ffffffe000200820:	0007871b          	sext.w	a4,a5
ffffffe000200824:	02700793          	li	a5,39
ffffffe000200828:	f6e7dce3          	bge	a5,a4,ffffffe0002007a0 <dummy+0x14c>
                    }
                }
                printk("\033[32mTest passed!\033[0m\n");
ffffffe00020082c:	00003517          	auipc	a0,0x3
ffffffe000200830:	8a450513          	addi	a0,a0,-1884 # ffffffe0002030d0 <_srodata+0xd0>
ffffffe000200834:	2ed010ef          	jal	ffffffe000202320 <printk>
                printk("\033[32m    Output: %s\033[0m\n", expected_output);
ffffffe000200838:	00003597          	auipc	a1,0x3
ffffffe00020083c:	7d058593          	addi	a1,a1,2000 # ffffffe000204008 <expected_output>
ffffffe000200840:	00003517          	auipc	a0,0x3
ffffffe000200844:	8a850513          	addi	a0,a0,-1880 # ffffffe0002030e8 <_srodata+0xe8>
ffffffe000200848:	2d9010ef          	jal	ffffffe000202320 <printk>
                sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe00020084c:	00000593          	li	a1,0
ffffffe000200850:	00000513          	li	a0,0
ffffffe000200854:	484000ef          	jal	ffffffe000200cd8 <sbi_system_reset>
        if ((last_counter == -1 || current->counter != last_counter) && current->counter > 0) {
ffffffe000200858:	e25ff06f          	j	ffffffe00020067c <dummy+0x28>

ffffffe00020085c <switch_to>:
    }
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
ffffffe00020085c:	fd010113          	addi	sp,sp,-48
ffffffe000200860:	02113423          	sd	ra,40(sp)
ffffffe000200864:	02813023          	sd	s0,32(sp)
ffffffe000200868:	03010413          	addi	s0,sp,48
ffffffe00020086c:	fca43c23          	sd	a0,-40(s0)
    LOG(RED);
ffffffe000200870:	00003697          	auipc	a3,0x3
ffffffe000200874:	97868693          	addi	a3,a3,-1672 # ffffffe0002031e8 <__func__.0>
ffffffe000200878:	06500613          	li	a2,101
ffffffe00020087c:	00003597          	auipc	a1,0x3
ffffffe000200880:	88c58593          	addi	a1,a1,-1908 # ffffffe000203108 <_srodata+0x108>
ffffffe000200884:	00003517          	auipc	a0,0x3
ffffffe000200888:	88c50513          	addi	a0,a0,-1908 # ffffffe000203110 <_srodata+0x110>
ffffffe00020088c:	295010ef          	jal	ffffffe000202320 <printk>
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
ffffffe000200890:	00005797          	auipc	a5,0x5
ffffffe000200894:	78078793          	addi	a5,a5,1920 # ffffffe000206010 <current>
ffffffe000200898:	0007b783          	ld	a5,0(a5)
ffffffe00020089c:	0187b703          	ld	a4,24(a5)
ffffffe0002008a0:	fd843783          	ld	a5,-40(s0)
ffffffe0002008a4:	0187b783          	ld	a5,24(a5)
ffffffe0002008a8:	00003697          	auipc	a3,0x3
ffffffe0002008ac:	94068693          	addi	a3,a3,-1728 # ffffffe0002031e8 <__func__.0>
ffffffe0002008b0:	06600613          	li	a2,102
ffffffe0002008b4:	00003597          	auipc	a1,0x3
ffffffe0002008b8:	85458593          	addi	a1,a1,-1964 # ffffffe000203108 <_srodata+0x108>
ffffffe0002008bc:	00003517          	auipc	a0,0x3
ffffffe0002008c0:	87450513          	addi	a0,a0,-1932 # ffffffe000203130 <_srodata+0x130>
ffffffe0002008c4:	25d010ef          	jal	ffffffe000202320 <printk>
    if(current->pid != next->pid) {
ffffffe0002008c8:	00005797          	auipc	a5,0x5
ffffffe0002008cc:	74878793          	addi	a5,a5,1864 # ffffffe000206010 <current>
ffffffe0002008d0:	0007b783          	ld	a5,0(a5)
ffffffe0002008d4:	0187b703          	ld	a4,24(a5)
ffffffe0002008d8:	fd843783          	ld	a5,-40(s0)
ffffffe0002008dc:	0187b783          	ld	a5,24(a5)
ffffffe0002008e0:	06f70a63          	beq	a4,a5,ffffffe000200954 <switch_to+0xf8>
        struct task_struct *prev = current;
ffffffe0002008e4:	00005797          	auipc	a5,0x5
ffffffe0002008e8:	72c78793          	addi	a5,a5,1836 # ffffffe000206010 <current>
ffffffe0002008ec:	0007b783          	ld	a5,0(a5)
ffffffe0002008f0:	fef43423          	sd	a5,-24(s0)
        current = next;
ffffffe0002008f4:	00005797          	auipc	a5,0x5
ffffffe0002008f8:	71c78793          	addi	a5,a5,1820 # ffffffe000206010 <current>
ffffffe0002008fc:	fd843703          	ld	a4,-40(s0)
ffffffe000200900:	00e7b023          	sd	a4,0(a5)
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
ffffffe000200904:	00005797          	auipc	a5,0x5
ffffffe000200908:	70c78793          	addi	a5,a5,1804 # ffffffe000206010 <current>
ffffffe00020090c:	0007b783          	ld	a5,0(a5)
ffffffe000200910:	0187b703          	ld	a4,24(a5)
ffffffe000200914:	00005797          	auipc	a5,0x5
ffffffe000200918:	6fc78793          	addi	a5,a5,1788 # ffffffe000206010 <current>
ffffffe00020091c:	0007b783          	ld	a5,0(a5)
ffffffe000200920:	0107b603          	ld	a2,16(a5)
ffffffe000200924:	00005797          	auipc	a5,0x5
ffffffe000200928:	6ec78793          	addi	a5,a5,1772 # ffffffe000206010 <current>
ffffffe00020092c:	0007b783          	ld	a5,0(a5)
ffffffe000200930:	0087b783          	ld	a5,8(a5)
ffffffe000200934:	00078693          	mv	a3,a5
ffffffe000200938:	00070593          	mv	a1,a4
ffffffe00020093c:	00003517          	auipc	a0,0x3
ffffffe000200940:	83450513          	addi	a0,a0,-1996 # ffffffe000203170 <_srodata+0x170>
ffffffe000200944:	1dd010ef          	jal	ffffffe000202320 <printk>
        __switch_to(prev, next);
ffffffe000200948:	fd843583          	ld	a1,-40(s0)
ffffffe00020094c:	fe843503          	ld	a0,-24(s0)
ffffffe000200950:	86dff0ef          	jal	ffffffe0002001bc <__switch_to>
    }
}
ffffffe000200954:	00000013          	nop
ffffffe000200958:	02813083          	ld	ra,40(sp)
ffffffe00020095c:	02013403          	ld	s0,32(sp)
ffffffe000200960:	03010113          	addi	sp,sp,48
ffffffe000200964:	00008067          	ret

ffffffe000200968 <do_timer>:

void do_timer() {
ffffffe000200968:	ff010113          	addi	sp,sp,-16
ffffffe00020096c:	00113423          	sd	ra,8(sp)
ffffffe000200970:	00813023          	sd	s0,0(sp)
ffffffe000200974:	01010413          	addi	s0,sp,16
    // LOG(RED);
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
ffffffe000200978:	00005797          	auipc	a5,0x5
ffffffe00020097c:	69878793          	addi	a5,a5,1688 # ffffffe000206010 <current>
ffffffe000200980:	0007b783          	ld	a5,0(a5)
ffffffe000200984:	0187b703          	ld	a4,24(a5)
ffffffe000200988:	00005797          	auipc	a5,0x5
ffffffe00020098c:	68078793          	addi	a5,a5,1664 # ffffffe000206008 <idle>
ffffffe000200990:	0007b783          	ld	a5,0(a5)
ffffffe000200994:	0187b783          	ld	a5,24(a5)
ffffffe000200998:	00f70c63          	beq	a4,a5,ffffffe0002009b0 <do_timer+0x48>
ffffffe00020099c:	00005797          	auipc	a5,0x5
ffffffe0002009a0:	67478793          	addi	a5,a5,1652 # ffffffe000206010 <current>
ffffffe0002009a4:	0007b783          	ld	a5,0(a5)
ffffffe0002009a8:	0087b783          	ld	a5,8(a5)
ffffffe0002009ac:	00079663          	bnez	a5,ffffffe0002009b8 <do_timer+0x50>
        schedule();
ffffffe0002009b0:	038000ef          	jal	ffffffe0002009e8 <schedule>
ffffffe0002009b4:	0200006f          	j	ffffffe0002009d4 <do_timer+0x6c>
    }
    else --(current->counter);
ffffffe0002009b8:	00005797          	auipc	a5,0x5
ffffffe0002009bc:	65878793          	addi	a5,a5,1624 # ffffffe000206010 <current>
ffffffe0002009c0:	0007b783          	ld	a5,0(a5)
ffffffe0002009c4:	0087b703          	ld	a4,8(a5)
ffffffe0002009c8:	fff70713          	addi	a4,a4,-1
ffffffe0002009cc:	00e7b423          	sd	a4,8(a5)
}
ffffffe0002009d0:	00000013          	nop
ffffffe0002009d4:	00000013          	nop
ffffffe0002009d8:	00813083          	ld	ra,8(sp)
ffffffe0002009dc:	00013403          	ld	s0,0(sp)
ffffffe0002009e0:	01010113          	addi	sp,sp,16
ffffffe0002009e4:	00008067          	ret

ffffffe0002009e8 <schedule>:

void schedule() {
ffffffe0002009e8:	fe010113          	addi	sp,sp,-32
ffffffe0002009ec:	00113c23          	sd	ra,24(sp)
ffffffe0002009f0:	00813823          	sd	s0,16(sp)
ffffffe0002009f4:	02010413          	addi	s0,sp,32
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    // LOG(RED);
    struct task_struct *next = idle;
ffffffe0002009f8:	00005797          	auipc	a5,0x5
ffffffe0002009fc:	61078793          	addi	a5,a5,1552 # ffffffe000206008 <idle>
ffffffe000200a00:	0007b783          	ld	a5,0(a5)
ffffffe000200a04:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a08:	00100793          	li	a5,1
ffffffe000200a0c:	fef42223          	sw	a5,-28(s0)
ffffffe000200a10:	0540006f          	j	ffffffe000200a64 <schedule+0x7c>
        if(task[i]->counter > next->counter){
ffffffe000200a14:	00005717          	auipc	a4,0x5
ffffffe000200a18:	61470713          	addi	a4,a4,1556 # ffffffe000206028 <task>
ffffffe000200a1c:	fe442783          	lw	a5,-28(s0)
ffffffe000200a20:	00379793          	slli	a5,a5,0x3
ffffffe000200a24:	00f707b3          	add	a5,a4,a5
ffffffe000200a28:	0007b783          	ld	a5,0(a5)
ffffffe000200a2c:	0087b703          	ld	a4,8(a5)
ffffffe000200a30:	fe843783          	ld	a5,-24(s0)
ffffffe000200a34:	0087b783          	ld	a5,8(a5)
ffffffe000200a38:	02e7f063          	bgeu	a5,a4,ffffffe000200a58 <schedule+0x70>
            next = task[i];
ffffffe000200a3c:	00005717          	auipc	a4,0x5
ffffffe000200a40:	5ec70713          	addi	a4,a4,1516 # ffffffe000206028 <task>
ffffffe000200a44:	fe442783          	lw	a5,-28(s0)
ffffffe000200a48:	00379793          	slli	a5,a5,0x3
ffffffe000200a4c:	00f707b3          	add	a5,a4,a5
ffffffe000200a50:	0007b783          	ld	a5,0(a5)
ffffffe000200a54:	fef43423          	sd	a5,-24(s0)
    for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a58:	fe442783          	lw	a5,-28(s0)
ffffffe000200a5c:	0017879b          	addiw	a5,a5,1
ffffffe000200a60:	fef42223          	sw	a5,-28(s0)
ffffffe000200a64:	fe442783          	lw	a5,-28(s0)
ffffffe000200a68:	0007871b          	sext.w	a4,a5
ffffffe000200a6c:	00400793          	li	a5,4
ffffffe000200a70:	fae7d2e3          	bge	a5,a4,ffffffe000200a14 <schedule+0x2c>
        }
    }

    if(next->counter == 0) {
ffffffe000200a74:	fe843783          	ld	a5,-24(s0)
ffffffe000200a78:	0087b783          	ld	a5,8(a5)
ffffffe000200a7c:	0c079e63          	bnez	a5,ffffffe000200b58 <schedule+0x170>
        printk("\n");
ffffffe000200a80:	00002517          	auipc	a0,0x2
ffffffe000200a84:	72850513          	addi	a0,a0,1832 # ffffffe0002031a8 <_srodata+0x1a8>
ffffffe000200a88:	099010ef          	jal	ffffffe000202320 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200a8c:	00100793          	li	a5,1
ffffffe000200a90:	fef42023          	sw	a5,-32(s0)
ffffffe000200a94:	0ac0006f          	j	ffffffe000200b40 <schedule+0x158>
            task[i]->counter = task[i]->priority;
ffffffe000200a98:	00005717          	auipc	a4,0x5
ffffffe000200a9c:	59070713          	addi	a4,a4,1424 # ffffffe000206028 <task>
ffffffe000200aa0:	fe042783          	lw	a5,-32(s0)
ffffffe000200aa4:	00379793          	slli	a5,a5,0x3
ffffffe000200aa8:	00f707b3          	add	a5,a4,a5
ffffffe000200aac:	0007b703          	ld	a4,0(a5)
ffffffe000200ab0:	00005697          	auipc	a3,0x5
ffffffe000200ab4:	57868693          	addi	a3,a3,1400 # ffffffe000206028 <task>
ffffffe000200ab8:	fe042783          	lw	a5,-32(s0)
ffffffe000200abc:	00379793          	slli	a5,a5,0x3
ffffffe000200ac0:	00f687b3          	add	a5,a3,a5
ffffffe000200ac4:	0007b783          	ld	a5,0(a5)
ffffffe000200ac8:	01073703          	ld	a4,16(a4)
ffffffe000200acc:	00e7b423          	sd	a4,8(a5)
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
ffffffe000200ad0:	00005717          	auipc	a4,0x5
ffffffe000200ad4:	55870713          	addi	a4,a4,1368 # ffffffe000206028 <task>
ffffffe000200ad8:	fe042783          	lw	a5,-32(s0)
ffffffe000200adc:	00379793          	slli	a5,a5,0x3
ffffffe000200ae0:	00f707b3          	add	a5,a4,a5
ffffffe000200ae4:	0007b783          	ld	a5,0(a5)
ffffffe000200ae8:	0187b583          	ld	a1,24(a5)
ffffffe000200aec:	00005717          	auipc	a4,0x5
ffffffe000200af0:	53c70713          	addi	a4,a4,1340 # ffffffe000206028 <task>
ffffffe000200af4:	fe042783          	lw	a5,-32(s0)
ffffffe000200af8:	00379793          	slli	a5,a5,0x3
ffffffe000200afc:	00f707b3          	add	a5,a4,a5
ffffffe000200b00:	0007b783          	ld	a5,0(a5)
ffffffe000200b04:	0107b603          	ld	a2,16(a5)
ffffffe000200b08:	00005717          	auipc	a4,0x5
ffffffe000200b0c:	52070713          	addi	a4,a4,1312 # ffffffe000206028 <task>
ffffffe000200b10:	fe042783          	lw	a5,-32(s0)
ffffffe000200b14:	00379793          	slli	a5,a5,0x3
ffffffe000200b18:	00f707b3          	add	a5,a4,a5
ffffffe000200b1c:	0007b783          	ld	a5,0(a5)
ffffffe000200b20:	0087b783          	ld	a5,8(a5)
ffffffe000200b24:	00078693          	mv	a3,a5
ffffffe000200b28:	00002517          	auipc	a0,0x2
ffffffe000200b2c:	68850513          	addi	a0,a0,1672 # ffffffe0002031b0 <_srodata+0x1b0>
ffffffe000200b30:	7f0010ef          	jal	ffffffe000202320 <printk>
        for(int i = 1; i < NR_TASKS; ++i) {
ffffffe000200b34:	fe042783          	lw	a5,-32(s0)
ffffffe000200b38:	0017879b          	addiw	a5,a5,1
ffffffe000200b3c:	fef42023          	sw	a5,-32(s0)
ffffffe000200b40:	fe042783          	lw	a5,-32(s0)
ffffffe000200b44:	0007871b          	sext.w	a4,a5
ffffffe000200b48:	00400793          	li	a5,4
ffffffe000200b4c:	f4e7d6e3          	bge	a5,a4,ffffffe000200a98 <schedule+0xb0>
        }
        schedule();
ffffffe000200b50:	e99ff0ef          	jal	ffffffe0002009e8 <schedule>
    } else {
        switch_to(next);
    }
ffffffe000200b54:	00c0006f          	j	ffffffe000200b60 <schedule+0x178>
        switch_to(next);
ffffffe000200b58:	fe843503          	ld	a0,-24(s0)
ffffffe000200b5c:	d01ff0ef          	jal	ffffffe00020085c <switch_to>
ffffffe000200b60:	00000013          	nop
ffffffe000200b64:	01813083          	ld	ra,24(sp)
ffffffe000200b68:	01013403          	ld	s0,16(sp)
ffffffe000200b6c:	02010113          	addi	sp,sp,32
ffffffe000200b70:	00008067          	ret

ffffffe000200b74 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
ffffffe000200b74:	f8010113          	addi	sp,sp,-128
ffffffe000200b78:	06813c23          	sd	s0,120(sp)
ffffffe000200b7c:	06913823          	sd	s1,112(sp)
ffffffe000200b80:	07213423          	sd	s2,104(sp)
ffffffe000200b84:	07313023          	sd	s3,96(sp)
ffffffe000200b88:	08010413          	addi	s0,sp,128
ffffffe000200b8c:	faa43c23          	sd	a0,-72(s0)
ffffffe000200b90:	fab43823          	sd	a1,-80(s0)
ffffffe000200b94:	fac43423          	sd	a2,-88(s0)
ffffffe000200b98:	fad43023          	sd	a3,-96(s0)
ffffffe000200b9c:	f8e43c23          	sd	a4,-104(s0)
ffffffe000200ba0:	f8f43823          	sd	a5,-112(s0)
ffffffe000200ba4:	f9043423          	sd	a6,-120(s0)
ffffffe000200ba8:	f9143023          	sd	a7,-128(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
ffffffe000200bac:	fb843e03          	ld	t3,-72(s0)
ffffffe000200bb0:	fb043e83          	ld	t4,-80(s0)
ffffffe000200bb4:	fa843f03          	ld	t5,-88(s0)
ffffffe000200bb8:	fa043f83          	ld	t6,-96(s0)
ffffffe000200bbc:	f9843283          	ld	t0,-104(s0)
ffffffe000200bc0:	f9043483          	ld	s1,-112(s0)
ffffffe000200bc4:	f8843903          	ld	s2,-120(s0)
ffffffe000200bc8:	f8043983          	ld	s3,-128(s0)
ffffffe000200bcc:	000e0893          	mv	a7,t3
ffffffe000200bd0:	000e8813          	mv	a6,t4
ffffffe000200bd4:	000f0513          	mv	a0,t5
ffffffe000200bd8:	000f8593          	mv	a1,t6
ffffffe000200bdc:	00028613          	mv	a2,t0
ffffffe000200be0:	00048693          	mv	a3,s1
ffffffe000200be4:	00090713          	mv	a4,s2
ffffffe000200be8:	00098793          	mv	a5,s3
ffffffe000200bec:	00000073          	ecall
ffffffe000200bf0:	00050e93          	mv	t4,a0
ffffffe000200bf4:	00058e13          	mv	t3,a1
ffffffe000200bf8:	fdd43023          	sd	t4,-64(s0)
ffffffe000200bfc:	fdc43423          	sd	t3,-56(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
ffffffe000200c00:	fc043783          	ld	a5,-64(s0)
ffffffe000200c04:	fcf43823          	sd	a5,-48(s0)
ffffffe000200c08:	fc843783          	ld	a5,-56(s0)
ffffffe000200c0c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200c10:	fd043703          	ld	a4,-48(s0)
ffffffe000200c14:	fd843783          	ld	a5,-40(s0)
ffffffe000200c18:	00070313          	mv	t1,a4
ffffffe000200c1c:	00078393          	mv	t2,a5
ffffffe000200c20:	00030713          	mv	a4,t1
ffffffe000200c24:	00038793          	mv	a5,t2
}
ffffffe000200c28:	00070513          	mv	a0,a4
ffffffe000200c2c:	00078593          	mv	a1,a5
ffffffe000200c30:	07813403          	ld	s0,120(sp)
ffffffe000200c34:	07013483          	ld	s1,112(sp)
ffffffe000200c38:	06813903          	ld	s2,104(sp)
ffffffe000200c3c:	06013983          	ld	s3,96(sp)
ffffffe000200c40:	08010113          	addi	sp,sp,128
ffffffe000200c44:	00008067          	ret

ffffffe000200c48 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
ffffffe000200c48:	fc010113          	addi	sp,sp,-64
ffffffe000200c4c:	02113c23          	sd	ra,56(sp)
ffffffe000200c50:	02813823          	sd	s0,48(sp)
ffffffe000200c54:	03213423          	sd	s2,40(sp)
ffffffe000200c58:	03313023          	sd	s3,32(sp)
ffffffe000200c5c:	04010413          	addi	s0,sp,64
ffffffe000200c60:	00050793          	mv	a5,a0
ffffffe000200c64:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
ffffffe000200c68:	fcf44603          	lbu	a2,-49(s0)
ffffffe000200c6c:	00000893          	li	a7,0
ffffffe000200c70:	00000813          	li	a6,0
ffffffe000200c74:	00000793          	li	a5,0
ffffffe000200c78:	00000713          	li	a4,0
ffffffe000200c7c:	00000693          	li	a3,0
ffffffe000200c80:	00200593          	li	a1,2
ffffffe000200c84:	44424537          	lui	a0,0x44424
ffffffe000200c88:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200c8c:	ee9ff0ef          	jal	ffffffe000200b74 <sbi_ecall>
ffffffe000200c90:	00050713          	mv	a4,a0
ffffffe000200c94:	00058793          	mv	a5,a1
ffffffe000200c98:	fce43823          	sd	a4,-48(s0)
ffffffe000200c9c:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ca0:	fd043703          	ld	a4,-48(s0)
ffffffe000200ca4:	fd843783          	ld	a5,-40(s0)
ffffffe000200ca8:	00070913          	mv	s2,a4
ffffffe000200cac:	00078993          	mv	s3,a5
ffffffe000200cb0:	00090713          	mv	a4,s2
ffffffe000200cb4:	00098793          	mv	a5,s3
}
ffffffe000200cb8:	00070513          	mv	a0,a4
ffffffe000200cbc:	00078593          	mv	a1,a5
ffffffe000200cc0:	03813083          	ld	ra,56(sp)
ffffffe000200cc4:	03013403          	ld	s0,48(sp)
ffffffe000200cc8:	02813903          	ld	s2,40(sp)
ffffffe000200ccc:	02013983          	ld	s3,32(sp)
ffffffe000200cd0:	04010113          	addi	sp,sp,64
ffffffe000200cd4:	00008067          	ret

ffffffe000200cd8 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
ffffffe000200cd8:	fc010113          	addi	sp,sp,-64
ffffffe000200cdc:	02113c23          	sd	ra,56(sp)
ffffffe000200ce0:	02813823          	sd	s0,48(sp)
ffffffe000200ce4:	03213423          	sd	s2,40(sp)
ffffffe000200ce8:	03313023          	sd	s3,32(sp)
ffffffe000200cec:	04010413          	addi	s0,sp,64
ffffffe000200cf0:	00050793          	mv	a5,a0
ffffffe000200cf4:	00058713          	mv	a4,a1
ffffffe000200cf8:	fcf42623          	sw	a5,-52(s0)
ffffffe000200cfc:	00070793          	mv	a5,a4
ffffffe000200d00:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
ffffffe000200d04:	fcc46603          	lwu	a2,-52(s0)
ffffffe000200d08:	fc846683          	lwu	a3,-56(s0)
ffffffe000200d0c:	00000893          	li	a7,0
ffffffe000200d10:	00000813          	li	a6,0
ffffffe000200d14:	00000793          	li	a5,0
ffffffe000200d18:	00000713          	li	a4,0
ffffffe000200d1c:	00000593          	li	a1,0
ffffffe000200d20:	53525537          	lui	a0,0x53525
ffffffe000200d24:	35450513          	addi	a0,a0,852 # 53525354 <PHY_SIZE+0x4b525354>
ffffffe000200d28:	e4dff0ef          	jal	ffffffe000200b74 <sbi_ecall>
ffffffe000200d2c:	00050713          	mv	a4,a0
ffffffe000200d30:	00058793          	mv	a5,a1
ffffffe000200d34:	fce43823          	sd	a4,-48(s0)
ffffffe000200d38:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200d3c:	fd043703          	ld	a4,-48(s0)
ffffffe000200d40:	fd843783          	ld	a5,-40(s0)
ffffffe000200d44:	00070913          	mv	s2,a4
ffffffe000200d48:	00078993          	mv	s3,a5
ffffffe000200d4c:	00090713          	mv	a4,s2
ffffffe000200d50:	00098793          	mv	a5,s3
}
ffffffe000200d54:	00070513          	mv	a0,a4
ffffffe000200d58:	00078593          	mv	a1,a5
ffffffe000200d5c:	03813083          	ld	ra,56(sp)
ffffffe000200d60:	03013403          	ld	s0,48(sp)
ffffffe000200d64:	02813903          	ld	s2,40(sp)
ffffffe000200d68:	02013983          	ld	s3,32(sp)
ffffffe000200d6c:	04010113          	addi	sp,sp,64
ffffffe000200d70:	00008067          	ret

ffffffe000200d74 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
ffffffe000200d74:	fc010113          	addi	sp,sp,-64
ffffffe000200d78:	02113c23          	sd	ra,56(sp)
ffffffe000200d7c:	02813823          	sd	s0,48(sp)
ffffffe000200d80:	03213423          	sd	s2,40(sp)
ffffffe000200d84:	03313023          	sd	s3,32(sp)
ffffffe000200d88:	04010413          	addi	s0,sp,64
ffffffe000200d8c:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
ffffffe000200d90:	00000893          	li	a7,0
ffffffe000200d94:	00000813          	li	a6,0
ffffffe000200d98:	00000793          	li	a5,0
ffffffe000200d9c:	00000713          	li	a4,0
ffffffe000200da0:	00000693          	li	a3,0
ffffffe000200da4:	fc843603          	ld	a2,-56(s0)
ffffffe000200da8:	00000593          	li	a1,0
ffffffe000200dac:	54495537          	lui	a0,0x54495
ffffffe000200db0:	d4550513          	addi	a0,a0,-699 # 54494d45 <PHY_SIZE+0x4c494d45>
ffffffe000200db4:	dc1ff0ef          	jal	ffffffe000200b74 <sbi_ecall>
ffffffe000200db8:	00050713          	mv	a4,a0
ffffffe000200dbc:	00058793          	mv	a5,a1
ffffffe000200dc0:	fce43823          	sd	a4,-48(s0)
ffffffe000200dc4:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200dc8:	fd043703          	ld	a4,-48(s0)
ffffffe000200dcc:	fd843783          	ld	a5,-40(s0)
ffffffe000200dd0:	00070913          	mv	s2,a4
ffffffe000200dd4:	00078993          	mv	s3,a5
ffffffe000200dd8:	00090713          	mv	a4,s2
ffffffe000200ddc:	00098793          	mv	a5,s3
}
ffffffe000200de0:	00070513          	mv	a0,a4
ffffffe000200de4:	00078593          	mv	a1,a5
ffffffe000200de8:	03813083          	ld	ra,56(sp)
ffffffe000200dec:	03013403          	ld	s0,48(sp)
ffffffe000200df0:	02813903          	ld	s2,40(sp)
ffffffe000200df4:	02013983          	ld	s3,32(sp)
ffffffe000200df8:	04010113          	addi	sp,sp,64
ffffffe000200dfc:	00008067          	ret

ffffffe000200e00 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
ffffffe000200e00:	fb010113          	addi	sp,sp,-80
ffffffe000200e04:	04113423          	sd	ra,72(sp)
ffffffe000200e08:	04813023          	sd	s0,64(sp)
ffffffe000200e0c:	03213c23          	sd	s2,56(sp)
ffffffe000200e10:	03313823          	sd	s3,48(sp)
ffffffe000200e14:	05010413          	addi	s0,sp,80
ffffffe000200e18:	fca43423          	sd	a0,-56(s0)
ffffffe000200e1c:	fcb43023          	sd	a1,-64(s0)
ffffffe000200e20:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200e24:	00000893          	li	a7,0
ffffffe000200e28:	00000813          	li	a6,0
ffffffe000200e2c:	00000793          	li	a5,0
ffffffe000200e30:	fb843703          	ld	a4,-72(s0)
ffffffe000200e34:	fc043683          	ld	a3,-64(s0)
ffffffe000200e38:	fc843603          	ld	a2,-56(s0)
ffffffe000200e3c:	00100593          	li	a1,1
ffffffe000200e40:	44424537          	lui	a0,0x44424
ffffffe000200e44:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200e48:	d2dff0ef          	jal	ffffffe000200b74 <sbi_ecall>
ffffffe000200e4c:	00050713          	mv	a4,a0
ffffffe000200e50:	00058793          	mv	a5,a1
ffffffe000200e54:	fce43823          	sd	a4,-48(s0)
ffffffe000200e58:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200e5c:	fd043703          	ld	a4,-48(s0)
ffffffe000200e60:	fd843783          	ld	a5,-40(s0)
ffffffe000200e64:	00070913          	mv	s2,a4
ffffffe000200e68:	00078993          	mv	s3,a5
ffffffe000200e6c:	00090713          	mv	a4,s2
ffffffe000200e70:	00098793          	mv	a5,s3
}
ffffffe000200e74:	00070513          	mv	a0,a4
ffffffe000200e78:	00078593          	mv	a1,a5
ffffffe000200e7c:	04813083          	ld	ra,72(sp)
ffffffe000200e80:	04013403          	ld	s0,64(sp)
ffffffe000200e84:	03813903          	ld	s2,56(sp)
ffffffe000200e88:	03013983          	ld	s3,48(sp)
ffffffe000200e8c:	05010113          	addi	sp,sp,80
ffffffe000200e90:	00008067          	ret

ffffffe000200e94 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
ffffffe000200e94:	fb010113          	addi	sp,sp,-80
ffffffe000200e98:	04113423          	sd	ra,72(sp)
ffffffe000200e9c:	04813023          	sd	s0,64(sp)
ffffffe000200ea0:	03213c23          	sd	s2,56(sp)
ffffffe000200ea4:	03313823          	sd	s3,48(sp)
ffffffe000200ea8:	05010413          	addi	s0,sp,80
ffffffe000200eac:	fca43423          	sd	a0,-56(s0)
ffffffe000200eb0:	fcb43023          	sd	a1,-64(s0)
ffffffe000200eb4:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
ffffffe000200eb8:	00000893          	li	a7,0
ffffffe000200ebc:	00000813          	li	a6,0
ffffffe000200ec0:	00000793          	li	a5,0
ffffffe000200ec4:	fb843703          	ld	a4,-72(s0)
ffffffe000200ec8:	fc043683          	ld	a3,-64(s0)
ffffffe000200ecc:	fc843603          	ld	a2,-56(s0)
ffffffe000200ed0:	00000593          	li	a1,0
ffffffe000200ed4:	44424537          	lui	a0,0x44424
ffffffe000200ed8:	34e50513          	addi	a0,a0,846 # 4442434e <PHY_SIZE+0x3c42434e>
ffffffe000200edc:	c99ff0ef          	jal	ffffffe000200b74 <sbi_ecall>
ffffffe000200ee0:	00050713          	mv	a4,a0
ffffffe000200ee4:	00058793          	mv	a5,a1
ffffffe000200ee8:	fce43823          	sd	a4,-48(s0)
ffffffe000200eec:	fcf43c23          	sd	a5,-40(s0)
ffffffe000200ef0:	fd043703          	ld	a4,-48(s0)
ffffffe000200ef4:	fd843783          	ld	a5,-40(s0)
ffffffe000200ef8:	00070913          	mv	s2,a4
ffffffe000200efc:	00078993          	mv	s3,a5
ffffffe000200f00:	00090713          	mv	a4,s2
ffffffe000200f04:	00098793          	mv	a5,s3
ffffffe000200f08:	00070513          	mv	a0,a4
ffffffe000200f0c:	00078593          	mv	a1,a5
ffffffe000200f10:	04813083          	ld	ra,72(sp)
ffffffe000200f14:	04013403          	ld	s0,64(sp)
ffffffe000200f18:	03813903          	ld	s2,56(sp)
ffffffe000200f1c:	03013983          	ld	s3,48(sp)
ffffffe000200f20:	05010113          	addi	sp,sp,80
ffffffe000200f24:	00008067          	ret

ffffffe000200f28 <trap_handler>:
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
ffffffe000200f28:	fe010113          	addi	sp,sp,-32
ffffffe000200f2c:	00113c23          	sd	ra,24(sp)
ffffffe000200f30:	00813823          	sd	s0,16(sp)
ffffffe000200f34:	02010413          	addi	s0,sp,32
ffffffe000200f38:	fea43423          	sd	a0,-24(s0)
ffffffe000200f3c:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
ffffffe000200f40:	fe843783          	ld	a5,-24(s0)
ffffffe000200f44:	0207d063          	bgez	a5,ffffffe000200f64 <trap_handler+0x3c>
ffffffe000200f48:	fe843783          	ld	a5,-24(s0)
ffffffe000200f4c:	0ff7f713          	zext.b	a4,a5
ffffffe000200f50:	00500793          	li	a5,5
ffffffe000200f54:	00f71863          	bne	a4,a5,ffffffe000200f64 <trap_handler+0x3c>
        // 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");

        // 设置下一次时钟中断
        clock_set_next_event();
ffffffe000200f58:	b08ff0ef          	jal	ffffffe000200260 <clock_set_next_event>

        // schedule
        do_timer();
ffffffe000200f5c:	a0dff0ef          	jal	ffffffe000200968 <do_timer>
ffffffe000200f60:	01c0006f          	j	ffffffe000200f7c <trap_handler+0x54>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
ffffffe000200f64:	fe043603          	ld	a2,-32(s0)
ffffffe000200f68:	fe843583          	ld	a1,-24(s0)
ffffffe000200f6c:	00002517          	auipc	a0,0x2
ffffffe000200f70:	28c50513          	addi	a0,a0,652 # ffffffe0002031f8 <__func__.0+0x10>
ffffffe000200f74:	3ac010ef          	jal	ffffffe000202320 <printk>
    }
ffffffe000200f78:	00000013          	nop
ffffffe000200f7c:	00000013          	nop
ffffffe000200f80:	01813083          	ld	ra,24(sp)
ffffffe000200f84:	01013403          	ld	s0,16(sp)
ffffffe000200f88:	02010113          	addi	sp,sp,32
ffffffe000200f8c:	00008067          	ret

ffffffe000200f90 <setup_vm>:
                     | OpenSBI | Kernel |                                | OpenSBI | Kernel |
-----------------------------------------------------------------------------------------------
                     ↑                                                   ↑
                0x80000000                                       0xffffffe000000000
*/
void setup_vm() {
ffffffe000200f90:	fe010113          	addi	sp,sp,-32
ffffffe000200f94:	00113c23          	sd	ra,24(sp)
ffffffe000200f98:	00813823          	sd	s0,16(sp)
ffffffe000200f9c:	02010413          	addi	s0,sp,32
                                                        │   │ └──────────────── A - Accessed
                                                        │   └────────────────── D - Dirty (0 in page directory)
                                                        └────────────────────── Reserved for supervisor software
    */

    memset(early_pgtbl, 0x00, sizeof early_pgtbl);
ffffffe000200fa0:	00001637          	lui	a2,0x1
ffffffe000200fa4:	00000593          	li	a1,0
ffffffe000200fa8:	00006517          	auipc	a0,0x6
ffffffe000200fac:	05850513          	addi	a0,a0,88 # ffffffe000207000 <early_pgtbl>
ffffffe000200fb0:	490010ef          	jal	ffffffe000202440 <memset>

    // 等值映射
    uint64_t index = (PHY_START >> 30) & 0x1ff; // 9-bit index
ffffffe000200fb4:	00200793          	li	a5,2
ffffffe000200fb8:	fef43423          	sd	a5,-24(s0)
    // early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN还是4KiB页
    // early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X


    // 二次映射
    index = (VM_START >> 30) & 0x1ff;   // 9-bit index
ffffffe000200fbc:	18000793          	li	a5,384
ffffffe000200fc0:	fef43423          	sd	a5,-24(s0)
    early_pgtbl[index] = (PHY_START >> 12) << 10; // PPN
ffffffe000200fc4:	00006717          	auipc	a4,0x6
ffffffe000200fc8:	03c70713          	addi	a4,a4,60 # ffffffe000207000 <early_pgtbl>
ffffffe000200fcc:	fe843783          	ld	a5,-24(s0)
ffffffe000200fd0:	00379793          	slli	a5,a5,0x3
ffffffe000200fd4:	00f707b3          	add	a5,a4,a5
ffffffe000200fd8:	20000737          	lui	a4,0x20000
ffffffe000200fdc:	00e7b023          	sd	a4,0(a5)
    early_pgtbl[index] |= ((1 << 4) - 1);   // V | R | W | X
ffffffe000200fe0:	00006717          	auipc	a4,0x6
ffffffe000200fe4:	02070713          	addi	a4,a4,32 # ffffffe000207000 <early_pgtbl>
ffffffe000200fe8:	fe843783          	ld	a5,-24(s0)
ffffffe000200fec:	00379793          	slli	a5,a5,0x3
ffffffe000200ff0:	00f707b3          	add	a5,a4,a5
ffffffe000200ff4:	0007b783          	ld	a5,0(a5)
ffffffe000200ff8:	00f7e713          	ori	a4,a5,15
ffffffe000200ffc:	00006697          	auipc	a3,0x6
ffffffe000201000:	00468693          	addi	a3,a3,4 # ffffffe000207000 <early_pgtbl>
ffffffe000201004:	fe843783          	ld	a5,-24(s0)
ffffffe000201008:	00379793          	slli	a5,a5,0x3
ffffffe00020100c:	00f687b3          	add	a5,a3,a5
ffffffe000201010:	00e7b023          	sd	a4,0(a5)

    LOG(RED "text: %p" CLEAR, _stext);
ffffffe000201014:	fffff717          	auipc	a4,0xfffff
ffffffe000201018:	fec70713          	addi	a4,a4,-20 # ffffffe000200000 <_skernel>
ffffffe00020101c:	00002697          	auipc	a3,0x2
ffffffe000201020:	30468693          	addi	a3,a3,772 # ffffffe000203320 <__func__.1>
ffffffe000201024:	04600613          	li	a2,70
ffffffe000201028:	00002597          	auipc	a1,0x2
ffffffe00020102c:	21058593          	addi	a1,a1,528 # ffffffe000203238 <__func__.0+0x50>
ffffffe000201030:	00002517          	auipc	a0,0x2
ffffffe000201034:	21050513          	addi	a0,a0,528 # ffffffe000203240 <__func__.0+0x58>
ffffffe000201038:	2e8010ef          	jal	ffffffe000202320 <printk>
    printk("...setup_vm done!\n");
ffffffe00020103c:	00002517          	auipc	a0,0x2
ffffffe000201040:	23450513          	addi	a0,a0,564 # ffffffe000203270 <__func__.0+0x88>
ffffffe000201044:	2dc010ef          	jal	ffffffe000202320 <printk>
}
ffffffe000201048:	00000013          	nop
ffffffe00020104c:	01813083          	ld	ra,24(sp)
ffffffe000201050:	01013403          	ld	s0,16(sp)
ffffffe000201054:	02010113          	addi	sp,sp,32
ffffffe000201058:	00008067          	ret

ffffffe00020105c <setup_vm_final>:

/* swapper_pg_dir: kernel pagetable 根目录，在 setup_vm_final 进行映射 */
uint64_t swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

void setup_vm_final() {
ffffffe00020105c:	fe010113          	addi	sp,sp,-32
ffffffe000201060:	00113c23          	sd	ra,24(sp)
ffffffe000201064:	00813823          	sd	s0,16(sp)
ffffffe000201068:	02010413          	addi	s0,sp,32
    memset(swapper_pg_dir, 0x0, PGSIZE);
ffffffe00020106c:	00001637          	lui	a2,0x1
ffffffe000201070:	00000593          	li	a1,0
ffffffe000201074:	00007517          	auipc	a0,0x7
ffffffe000201078:	f8c50513          	addi	a0,a0,-116 # ffffffe000208000 <swapper_pg_dir>
ffffffe00020107c:	3c4010ef          	jal	ffffffe000202440 <memset>

    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_stext, (uint64_t)_stext - PA2VA_OFFSET, (uint64_t)_etext - (uint64_t)_stext, 0b1011);
ffffffe000201080:	fffff597          	auipc	a1,0xfffff
ffffffe000201084:	f8058593          	addi	a1,a1,-128 # ffffffe000200000 <_skernel>
ffffffe000201088:	fffff717          	auipc	a4,0xfffff
ffffffe00020108c:	f7870713          	addi	a4,a4,-136 # ffffffe000200000 <_skernel>
ffffffe000201090:	04100793          	li	a5,65
ffffffe000201094:	01f79793          	slli	a5,a5,0x1f
ffffffe000201098:	00f70633          	add	a2,a4,a5
ffffffe00020109c:	00001717          	auipc	a4,0x1
ffffffe0002010a0:	41470713          	addi	a4,a4,1044 # ffffffe0002024b0 <_etext>
ffffffe0002010a4:	fffff797          	auipc	a5,0xfffff
ffffffe0002010a8:	f5c78793          	addi	a5,a5,-164 # ffffffe000200000 <_skernel>
ffffffe0002010ac:	40f707b3          	sub	a5,a4,a5
ffffffe0002010b0:	00b00713          	li	a4,11
ffffffe0002010b4:	00078693          	mv	a3,a5
ffffffe0002010b8:	00007517          	auipc	a0,0x7
ffffffe0002010bc:	f4850513          	addi	a0,a0,-184 # ffffffe000208000 <swapper_pg_dir>
ffffffe0002010c0:	0f0000ef          	jal	ffffffe0002011b0 <create_mapping>

    // mapping kernel rodata -|-|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_srodata, (uint64_t)_srodata - PA2VA_OFFSET, (uint64_t)_erodata - (uint64_t)_srodata, 0b0011);
ffffffe0002010c4:	00002597          	auipc	a1,0x2
ffffffe0002010c8:	f3c58593          	addi	a1,a1,-196 # ffffffe000203000 <_srodata>
ffffffe0002010cc:	00002717          	auipc	a4,0x2
ffffffe0002010d0:	f3470713          	addi	a4,a4,-204 # ffffffe000203000 <_srodata>
ffffffe0002010d4:	04100793          	li	a5,65
ffffffe0002010d8:	01f79793          	slli	a5,a5,0x1f
ffffffe0002010dc:	00f70633          	add	a2,a4,a5
ffffffe0002010e0:	00002717          	auipc	a4,0x2
ffffffe0002010e4:	2f070713          	addi	a4,a4,752 # ffffffe0002033d0 <_erodata>
ffffffe0002010e8:	00002797          	auipc	a5,0x2
ffffffe0002010ec:	f1878793          	addi	a5,a5,-232 # ffffffe000203000 <_srodata>
ffffffe0002010f0:	40f707b3          	sub	a5,a4,a5
ffffffe0002010f4:	00300713          	li	a4,3
ffffffe0002010f8:	00078693          	mv	a3,a5
ffffffe0002010fc:	00007517          	auipc	a0,0x7
ffffffe000201100:	f0450513          	addi	a0,a0,-252 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201104:	0ac000ef          	jal	ffffffe0002011b0 <create_mapping>

    // mapping other memory -|W|R|V
    create_mapping(swapper_pg_dir, (uint64_t)_sdata, (uint64_t)_sdata - PA2VA_OFFSET, VM_END -(uint64_t)_sdata, 0b0111);
ffffffe000201108:	00003597          	auipc	a1,0x3
ffffffe00020110c:	ef858593          	addi	a1,a1,-264 # ffffffe000204000 <TIMECLOCK>
ffffffe000201110:	00003717          	auipc	a4,0x3
ffffffe000201114:	ef070713          	addi	a4,a4,-272 # ffffffe000204000 <TIMECLOCK>
ffffffe000201118:	04100793          	li	a5,65
ffffffe00020111c:	01f79793          	slli	a5,a5,0x1f
ffffffe000201120:	00f70633          	add	a2,a4,a5
ffffffe000201124:	00003797          	auipc	a5,0x3
ffffffe000201128:	edc78793          	addi	a5,a5,-292 # ffffffe000204000 <TIMECLOCK>
ffffffe00020112c:	c0100713          	li	a4,-1023
ffffffe000201130:	01b71713          	slli	a4,a4,0x1b
ffffffe000201134:	40f707b3          	sub	a5,a4,a5
ffffffe000201138:	00700713          	li	a4,7
ffffffe00020113c:	00078693          	mv	a3,a5
ffffffe000201140:	00007517          	auipc	a0,0x7
ffffffe000201144:	ec050513          	addi	a0,a0,-320 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201148:	068000ef          	jal	ffffffe0002011b0 <create_mapping>

    printk("...create_mapping done!\n");
ffffffe00020114c:	00002517          	auipc	a0,0x2
ffffffe000201150:	13c50513          	addi	a0,a0,316 # ffffffe000203288 <__func__.0+0xa0>
ffffffe000201154:	1cc010ef          	jal	ffffffe000202320 <printk>
    // set satp with swapper_pg_dir
    csr_write(satp, ((uint64_t)swapper_pg_dir - PA2VA_OFFSET) >> 12 | (8llu << 60));
ffffffe000201158:	00007717          	auipc	a4,0x7
ffffffe00020115c:	ea870713          	addi	a4,a4,-344 # ffffffe000208000 <swapper_pg_dir>
ffffffe000201160:	04100793          	li	a5,65
ffffffe000201164:	01f79793          	slli	a5,a5,0x1f
ffffffe000201168:	00f707b3          	add	a5,a4,a5
ffffffe00020116c:	00c7d713          	srli	a4,a5,0xc
ffffffe000201170:	fff00793          	li	a5,-1
ffffffe000201174:	03f79793          	slli	a5,a5,0x3f
ffffffe000201178:	00f767b3          	or	a5,a4,a5
ffffffe00020117c:	fef43423          	sd	a5,-24(s0)
ffffffe000201180:	fe843783          	ld	a5,-24(s0)
ffffffe000201184:	18079073          	csrw	satp,a5

    // flush TLB
    asm volatile("sfence.vma zero, zero");
ffffffe000201188:	12000073          	sfence.vma

    // flush icache
    asm volatile("fence.i");
ffffffe00020118c:	0000100f          	fence.i

    printk("...setup_vm_final done!\n");
ffffffe000201190:	00002517          	auipc	a0,0x2
ffffffe000201194:	11850513          	addi	a0,a0,280 # ffffffe0002032a8 <__func__.0+0xc0>
ffffffe000201198:	188010ef          	jal	ffffffe000202320 <printk>
    return;
ffffffe00020119c:	00000013          	nop
}
ffffffe0002011a0:	01813083          	ld	ra,24(sp)
ffffffe0002011a4:	01013403          	ld	s0,16(sp)
ffffffe0002011a8:	02010113          	addi	sp,sp,32
ffffffe0002011ac:	00008067          	ret

ffffffe0002011b0 <create_mapping>:
     │                               │                     │                 │
 ┌───┴────┐                          │                   0 │                 │
 │  satp  │                          └────────────────────►└─────────────────┘
 └────────┘
*/
void create_mapping(uint64_t *pgtbl, uint64_t va, uint64_t pa, uint64_t sz, uint64_t perm) {
ffffffe0002011b0:	f8010113          	addi	sp,sp,-128
ffffffe0002011b4:	06113c23          	sd	ra,120(sp)
ffffffe0002011b8:	06813823          	sd	s0,112(sp)
ffffffe0002011bc:	08010413          	addi	s0,sp,128
ffffffe0002011c0:	faa43423          	sd	a0,-88(s0)
ffffffe0002011c4:	fab43023          	sd	a1,-96(s0)
ffffffe0002011c8:	f8c43c23          	sd	a2,-104(s0)
ffffffe0002011cc:	f8d43823          	sd	a3,-112(s0)
ffffffe0002011d0:	f8e43423          	sd	a4,-120(s0)
     * perm 为映射的权限（即页表项的低 8 位）
     * 
     * 创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
     * 可以使用 V bit 来判断页表项是否存在
    **/
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe0002011d4:	fe043423          	sd	zero,-24(s0)
ffffffe0002011d8:	1a00006f          	j	ffffffe000201378 <create_mapping+0x1c8>
        // 分别获取三级索引 index2, index1, index0
        uint64_t va_s = va + i;
ffffffe0002011dc:	fa043703          	ld	a4,-96(s0)
ffffffe0002011e0:	fe843783          	ld	a5,-24(s0)
ffffffe0002011e4:	00f707b3          	add	a5,a4,a5
ffffffe0002011e8:	fef43023          	sd	a5,-32(s0)
        uint64_t index2 = (va_s >> 30) & 0x1ff;
ffffffe0002011ec:	fe043783          	ld	a5,-32(s0)
ffffffe0002011f0:	01e7d793          	srli	a5,a5,0x1e
ffffffe0002011f4:	1ff7f793          	andi	a5,a5,511
ffffffe0002011f8:	fcf43c23          	sd	a5,-40(s0)
        uint64_t index1 = (va_s >> 21) & 0x1ff;
ffffffe0002011fc:	fe043783          	ld	a5,-32(s0)
ffffffe000201200:	0157d793          	srli	a5,a5,0x15
ffffffe000201204:	1ff7f793          	andi	a5,a5,511
ffffffe000201208:	fcf43823          	sd	a5,-48(s0)
        uint64_t index0 = (va_s >> 12) & 0x1ff;
ffffffe00020120c:	fe043783          	ld	a5,-32(s0)
ffffffe000201210:	00c7d793          	srli	a5,a5,0xc
ffffffe000201214:	1ff7f793          	andi	a5,a5,511
ffffffe000201218:	fcf43423          	sd	a5,-56(s0)

        // 根页表
        if(!(pgtbl[index2] & 1)) {  // 根据 V bit 判断页表项是否存在
ffffffe00020121c:	fd843783          	ld	a5,-40(s0)
ffffffe000201220:	00379793          	slli	a5,a5,0x3
ffffffe000201224:	fa843703          	ld	a4,-88(s0)
ffffffe000201228:	00f707b3          	add	a5,a4,a5
ffffffe00020122c:	0007b783          	ld	a5,0(a5)
ffffffe000201230:	0017f793          	andi	a5,a5,1
ffffffe000201234:	02079e63          	bnez	a5,ffffffe000201270 <create_mapping+0xc0>
            // 先减去 PA2VA_OFFSET转换为物理地址，然后右移12位转换为PPN ，最后左移10位或上权限为转换为页表项
            pgtbl[index2] = ((uint64_t)kalloc() - PA2VA_OFFSET >> 12 << 10) | 1;
ffffffe000201238:	870ff0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe00020123c:	00050793          	mv	a5,a0
ffffffe000201240:	00078713          	mv	a4,a5
ffffffe000201244:	04100793          	li	a5,65
ffffffe000201248:	01f79793          	slli	a5,a5,0x1f
ffffffe00020124c:	00f707b3          	add	a5,a4,a5
ffffffe000201250:	00c7d793          	srli	a5,a5,0xc
ffffffe000201254:	00a79713          	slli	a4,a5,0xa
ffffffe000201258:	fd843783          	ld	a5,-40(s0)
ffffffe00020125c:	00379793          	slli	a5,a5,0x3
ffffffe000201260:	fa843683          	ld	a3,-88(s0)
ffffffe000201264:	00f687b3          	add	a5,a3,a5
ffffffe000201268:	00176713          	ori	a4,a4,1
ffffffe00020126c:	00e7b023          	sd	a4,0(a5)
        }

        // 二级页表
        uint64_t *pgtbl1 = (uint64_t *)((pgtbl[index2] >> 10 << 12) + PA2VA_OFFSET);
ffffffe000201270:	fd843783          	ld	a5,-40(s0)
ffffffe000201274:	00379793          	slli	a5,a5,0x3
ffffffe000201278:	fa843703          	ld	a4,-88(s0)
ffffffe00020127c:	00f707b3          	add	a5,a4,a5
ffffffe000201280:	0007b783          	ld	a5,0(a5)
ffffffe000201284:	00a7d793          	srli	a5,a5,0xa
ffffffe000201288:	00c79713          	slli	a4,a5,0xc
ffffffe00020128c:	fbf00793          	li	a5,-65
ffffffe000201290:	01f79793          	slli	a5,a5,0x1f
ffffffe000201294:	00f707b3          	add	a5,a4,a5
ffffffe000201298:	fcf43023          	sd	a5,-64(s0)
        if(!(pgtbl1[index1] & 1)) {
ffffffe00020129c:	fd043783          	ld	a5,-48(s0)
ffffffe0002012a0:	00379793          	slli	a5,a5,0x3
ffffffe0002012a4:	fc043703          	ld	a4,-64(s0)
ffffffe0002012a8:	00f707b3          	add	a5,a4,a5
ffffffe0002012ac:	0007b783          	ld	a5,0(a5)
ffffffe0002012b0:	0017f793          	andi	a5,a5,1
ffffffe0002012b4:	02079e63          	bnez	a5,ffffffe0002012f0 <create_mapping+0x140>
            pgtbl1[index1] = ((uint64_t)kalloc() - PA2VA_OFFSET>> 12 << 10) | 1;
ffffffe0002012b8:	ff1fe0ef          	jal	ffffffe0002002a8 <kalloc>
ffffffe0002012bc:	00050793          	mv	a5,a0
ffffffe0002012c0:	00078713          	mv	a4,a5
ffffffe0002012c4:	04100793          	li	a5,65
ffffffe0002012c8:	01f79793          	slli	a5,a5,0x1f
ffffffe0002012cc:	00f707b3          	add	a5,a4,a5
ffffffe0002012d0:	00c7d793          	srli	a5,a5,0xc
ffffffe0002012d4:	00a79713          	slli	a4,a5,0xa
ffffffe0002012d8:	fd043783          	ld	a5,-48(s0)
ffffffe0002012dc:	00379793          	slli	a5,a5,0x3
ffffffe0002012e0:	fc043683          	ld	a3,-64(s0)
ffffffe0002012e4:	00f687b3          	add	a5,a3,a5
ffffffe0002012e8:	00176713          	ori	a4,a4,1
ffffffe0002012ec:	00e7b023          	sd	a4,0(a5)
        }

        // 叶子页表
        uint64_t *pgtbl0 = (uint64_t *)((pgtbl1[index1] >> 10 << 12) + PA2VA_OFFSET);
ffffffe0002012f0:	fd043783          	ld	a5,-48(s0)
ffffffe0002012f4:	00379793          	slli	a5,a5,0x3
ffffffe0002012f8:	fc043703          	ld	a4,-64(s0)
ffffffe0002012fc:	00f707b3          	add	a5,a4,a5
ffffffe000201300:	0007b783          	ld	a5,0(a5)
ffffffe000201304:	00a7d793          	srli	a5,a5,0xa
ffffffe000201308:	00c79713          	slli	a4,a5,0xc
ffffffe00020130c:	fbf00793          	li	a5,-65
ffffffe000201310:	01f79793          	slli	a5,a5,0x1f
ffffffe000201314:	00f707b3          	add	a5,a4,a5
ffffffe000201318:	faf43c23          	sd	a5,-72(s0)
        if(!(pgtbl0[index0] & 1)) {
ffffffe00020131c:	fc843783          	ld	a5,-56(s0)
ffffffe000201320:	00379793          	slli	a5,a5,0x3
ffffffe000201324:	fb843703          	ld	a4,-72(s0)
ffffffe000201328:	00f707b3          	add	a5,a4,a5
ffffffe00020132c:	0007b783          	ld	a5,0(a5)
ffffffe000201330:	0017f793          	andi	a5,a5,1
ffffffe000201334:	02079a63          	bnez	a5,ffffffe000201368 <create_mapping+0x1b8>
            // 此时正确设置页表项的 PPN 和权限
            pgtbl0[index0] = ((pa + i >> 12) << 10) | perm;
ffffffe000201338:	f9843703          	ld	a4,-104(s0)
ffffffe00020133c:	fe843783          	ld	a5,-24(s0)
ffffffe000201340:	00f707b3          	add	a5,a4,a5
ffffffe000201344:	00c7d793          	srli	a5,a5,0xc
ffffffe000201348:	00a79693          	slli	a3,a5,0xa
ffffffe00020134c:	fc843783          	ld	a5,-56(s0)
ffffffe000201350:	00379793          	slli	a5,a5,0x3
ffffffe000201354:	fb843703          	ld	a4,-72(s0)
ffffffe000201358:	00f707b3          	add	a5,a4,a5
ffffffe00020135c:	f8843703          	ld	a4,-120(s0)
ffffffe000201360:	00e6e733          	or	a4,a3,a4
ffffffe000201364:	00e7b023          	sd	a4,0(a5)
    for (uint64_t i = 0; i < sz; i += PGSIZE) {
ffffffe000201368:	fe843703          	ld	a4,-24(s0)
ffffffe00020136c:	000017b7          	lui	a5,0x1
ffffffe000201370:	00f707b3          	add	a5,a4,a5
ffffffe000201374:	fef43423          	sd	a5,-24(s0)
ffffffe000201378:	fe843703          	ld	a4,-24(s0)
ffffffe00020137c:	f9043783          	ld	a5,-112(s0)
ffffffe000201380:	e4f76ee3          	bltu	a4,a5,ffffffe0002011dc <create_mapping+0x2c>
        }
    }
    LOG(RED "create_mapping(va: %p, pa: %p, sz: %p, perm: %p)" CLEAR, va, pa, sz, perm);
ffffffe000201384:	f8843883          	ld	a7,-120(s0)
ffffffe000201388:	f9043803          	ld	a6,-112(s0)
ffffffe00020138c:	f9843783          	ld	a5,-104(s0)
ffffffe000201390:	fa043703          	ld	a4,-96(s0)
ffffffe000201394:	00002697          	auipc	a3,0x2
ffffffe000201398:	f9c68693          	addi	a3,a3,-100 # ffffffe000203330 <__func__.0>
ffffffe00020139c:	0b800613          	li	a2,184
ffffffe0002013a0:	00002597          	auipc	a1,0x2
ffffffe0002013a4:	e9858593          	addi	a1,a1,-360 # ffffffe000203238 <__func__.0+0x50>
ffffffe0002013a8:	00002517          	auipc	a0,0x2
ffffffe0002013ac:	f2050513          	addi	a0,a0,-224 # ffffffe0002032c8 <__func__.0+0xe0>
ffffffe0002013b0:	771000ef          	jal	ffffffe000202320 <printk>
ffffffe0002013b4:	00000013          	nop
ffffffe0002013b8:	07813083          	ld	ra,120(sp)
ffffffe0002013bc:	07013403          	ld	s0,112(sp)
ffffffe0002013c0:	08010113          	addi	sp,sp,128
ffffffe0002013c4:	00008067          	ret

ffffffe0002013c8 <start_kernel>:
#include "proc.h"

extern void test();
extern void run_idle();

int start_kernel() {
ffffffe0002013c8:	ff010113          	addi	sp,sp,-16
ffffffe0002013cc:	00113423          	sd	ra,8(sp)
ffffffe0002013d0:	00813023          	sd	s0,0(sp)
ffffffe0002013d4:	01010413          	addi	s0,sp,16
    printk("2024");
ffffffe0002013d8:	00002517          	auipc	a0,0x2
ffffffe0002013dc:	f6850513          	addi	a0,a0,-152 # ffffffe000203340 <__func__.0+0x10>
ffffffe0002013e0:	741000ef          	jal	ffffffe000202320 <printk>
    printk(" ZJU Operating System\n");
ffffffe0002013e4:	00002517          	auipc	a0,0x2
ffffffe0002013e8:	f6450513          	addi	a0,a0,-156 # ffffffe000203348 <__func__.0+0x18>
ffffffe0002013ec:	735000ef          	jal	ffffffe000202320 <printk>
    // x = 0x12345678;
    // csr_write(sscratch, x);
    // x = csr_read(sscratch);
    // printk("written: sscratch = 0x%lx\n", x);   // print written value

    run_idle();
ffffffe0002013f0:	088000ef          	jal	ffffffe000201478 <run_idle>
    return 0;
ffffffe0002013f4:	00000793          	li	a5,0
}
ffffffe0002013f8:	00078513          	mv	a0,a5
ffffffe0002013fc:	00813083          	ld	ra,8(sp)
ffffffe000201400:	00013403          	ld	s0,0(sp)
ffffffe000201404:	01010113          	addi	sp,sp,16
ffffffe000201408:	00008067          	ret

ffffffe00020140c <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() { //直接调用SBI系统调用进行关机
ffffffe00020140c:	ff010113          	addi	sp,sp,-16
ffffffe000201410:	00113423          	sd	ra,8(sp)
ffffffe000201414:	00813023          	sd	s0,0(sp)
ffffffe000201418:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
ffffffe00020141c:	00000593          	li	a1,0
ffffffe000201420:	00000513          	li	a0,0
ffffffe000201424:	8b5ff0ef          	jal	ffffffe000200cd8 <sbi_system_reset>

ffffffe000201428 <test>:
    __builtin_unreachable();
}

void test() {
ffffffe000201428:	fe010113          	addi	sp,sp,-32
ffffffe00020142c:	00113c23          	sd	ra,24(sp)
ffffffe000201430:	00813823          	sd	s0,16(sp)
ffffffe000201434:	02010413          	addi	s0,sp,32
    int i = 0;
ffffffe000201438:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 100000000 == 0){        
ffffffe00020143c:	fec42783          	lw	a5,-20(s0)
ffffffe000201440:	0017879b          	addiw	a5,a5,1 # 1001 <PGSIZE+0x1>
ffffffe000201444:	fef42623          	sw	a5,-20(s0)
ffffffe000201448:	fec42783          	lw	a5,-20(s0)
ffffffe00020144c:	00078713          	mv	a4,a5
ffffffe000201450:	05f5e7b7          	lui	a5,0x5f5e
ffffffe000201454:	1007879b          	addiw	a5,a5,256 # 5f5e100 <OPENSBI_SIZE+0x5d5e100>
ffffffe000201458:	02f767bb          	remw	a5,a4,a5
ffffffe00020145c:	0007879b          	sext.w	a5,a5
ffffffe000201460:	fc079ee3          	bnez	a5,ffffffe00020143c <test+0x14>
            // display a message every 100000000 loops, in my machine, it takes about 1/3 second
            printk("kernel is running!\n");
ffffffe000201464:	00002517          	auipc	a0,0x2
ffffffe000201468:	efc50513          	addi	a0,a0,-260 # ffffffe000203360 <__func__.0+0x30>
ffffffe00020146c:	6b5000ef          	jal	ffffffe000202320 <printk>
            i = 0;
ffffffe000201470:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 100000000 == 0){        
ffffffe000201474:	fc9ff06f          	j	ffffffe00020143c <test+0x14>

ffffffe000201478 <run_idle>:
        }
    }
}

void run_idle() {
ffffffe000201478:	ff010113          	addi	sp,sp,-16
ffffffe00020147c:	00813423          	sd	s0,8(sp)
ffffffe000201480:	01010413          	addi	s0,sp,16
    while (1) {
ffffffe000201484:	00000013          	nop
ffffffe000201488:	ffdff06f          	j	ffffffe000201484 <run_idle+0xc>

ffffffe00020148c <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
ffffffe00020148c:	fe010113          	addi	sp,sp,-32
ffffffe000201490:	00113c23          	sd	ra,24(sp)
ffffffe000201494:	00813823          	sd	s0,16(sp)
ffffffe000201498:	02010413          	addi	s0,sp,32
ffffffe00020149c:	00050793          	mv	a5,a0
ffffffe0002014a0:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
ffffffe0002014a4:	fec42783          	lw	a5,-20(s0)
ffffffe0002014a8:	0ff7f793          	zext.b	a5,a5
ffffffe0002014ac:	00078513          	mv	a0,a5
ffffffe0002014b0:	f98ff0ef          	jal	ffffffe000200c48 <sbi_debug_console_write_byte>
    return (char)c;
ffffffe0002014b4:	fec42783          	lw	a5,-20(s0)
ffffffe0002014b8:	0ff7f793          	zext.b	a5,a5
ffffffe0002014bc:	0007879b          	sext.w	a5,a5
}
ffffffe0002014c0:	00078513          	mv	a0,a5
ffffffe0002014c4:	01813083          	ld	ra,24(sp)
ffffffe0002014c8:	01013403          	ld	s0,16(sp)
ffffffe0002014cc:	02010113          	addi	sp,sp,32
ffffffe0002014d0:	00008067          	ret

ffffffe0002014d4 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
ffffffe0002014d4:	fe010113          	addi	sp,sp,-32
ffffffe0002014d8:	00813c23          	sd	s0,24(sp)
ffffffe0002014dc:	02010413          	addi	s0,sp,32
ffffffe0002014e0:	00050793          	mv	a5,a0
ffffffe0002014e4:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
ffffffe0002014e8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014ec:	0007871b          	sext.w	a4,a5
ffffffe0002014f0:	02000793          	li	a5,32
ffffffe0002014f4:	02f70263          	beq	a4,a5,ffffffe000201518 <isspace+0x44>
ffffffe0002014f8:	fec42783          	lw	a5,-20(s0)
ffffffe0002014fc:	0007871b          	sext.w	a4,a5
ffffffe000201500:	00800793          	li	a5,8
ffffffe000201504:	00e7de63          	bge	a5,a4,ffffffe000201520 <isspace+0x4c>
ffffffe000201508:	fec42783          	lw	a5,-20(s0)
ffffffe00020150c:	0007871b          	sext.w	a4,a5
ffffffe000201510:	00d00793          	li	a5,13
ffffffe000201514:	00e7c663          	blt	a5,a4,ffffffe000201520 <isspace+0x4c>
ffffffe000201518:	00100793          	li	a5,1
ffffffe00020151c:	0080006f          	j	ffffffe000201524 <isspace+0x50>
ffffffe000201520:	00000793          	li	a5,0
}
ffffffe000201524:	00078513          	mv	a0,a5
ffffffe000201528:	01813403          	ld	s0,24(sp)
ffffffe00020152c:	02010113          	addi	sp,sp,32
ffffffe000201530:	00008067          	ret

ffffffe000201534 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
ffffffe000201534:	fb010113          	addi	sp,sp,-80
ffffffe000201538:	04113423          	sd	ra,72(sp)
ffffffe00020153c:	04813023          	sd	s0,64(sp)
ffffffe000201540:	05010413          	addi	s0,sp,80
ffffffe000201544:	fca43423          	sd	a0,-56(s0)
ffffffe000201548:	fcb43023          	sd	a1,-64(s0)
ffffffe00020154c:	00060793          	mv	a5,a2
ffffffe000201550:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
ffffffe000201554:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
ffffffe000201558:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
ffffffe00020155c:	fc843783          	ld	a5,-56(s0)
ffffffe000201560:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
ffffffe000201564:	0100006f          	j	ffffffe000201574 <strtol+0x40>
        p++;
ffffffe000201568:	fd843783          	ld	a5,-40(s0)
ffffffe00020156c:	00178793          	addi	a5,a5,1
ffffffe000201570:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
ffffffe000201574:	fd843783          	ld	a5,-40(s0)
ffffffe000201578:	0007c783          	lbu	a5,0(a5)
ffffffe00020157c:	0007879b          	sext.w	a5,a5
ffffffe000201580:	00078513          	mv	a0,a5
ffffffe000201584:	f51ff0ef          	jal	ffffffe0002014d4 <isspace>
ffffffe000201588:	00050793          	mv	a5,a0
ffffffe00020158c:	fc079ee3          	bnez	a5,ffffffe000201568 <strtol+0x34>
    }

    if (*p == '-') {
ffffffe000201590:	fd843783          	ld	a5,-40(s0)
ffffffe000201594:	0007c783          	lbu	a5,0(a5)
ffffffe000201598:	00078713          	mv	a4,a5
ffffffe00020159c:	02d00793          	li	a5,45
ffffffe0002015a0:	00f71e63          	bne	a4,a5,ffffffe0002015bc <strtol+0x88>
        neg = true;
ffffffe0002015a4:	00100793          	li	a5,1
ffffffe0002015a8:	fef403a3          	sb	a5,-25(s0)
        p++;
ffffffe0002015ac:	fd843783          	ld	a5,-40(s0)
ffffffe0002015b0:	00178793          	addi	a5,a5,1
ffffffe0002015b4:	fcf43c23          	sd	a5,-40(s0)
ffffffe0002015b8:	0240006f          	j	ffffffe0002015dc <strtol+0xa8>
    } else if (*p == '+') {
ffffffe0002015bc:	fd843783          	ld	a5,-40(s0)
ffffffe0002015c0:	0007c783          	lbu	a5,0(a5)
ffffffe0002015c4:	00078713          	mv	a4,a5
ffffffe0002015c8:	02b00793          	li	a5,43
ffffffe0002015cc:	00f71863          	bne	a4,a5,ffffffe0002015dc <strtol+0xa8>
        p++;
ffffffe0002015d0:	fd843783          	ld	a5,-40(s0)
ffffffe0002015d4:	00178793          	addi	a5,a5,1
ffffffe0002015d8:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
ffffffe0002015dc:	fbc42783          	lw	a5,-68(s0)
ffffffe0002015e0:	0007879b          	sext.w	a5,a5
ffffffe0002015e4:	06079c63          	bnez	a5,ffffffe00020165c <strtol+0x128>
        if (*p == '0') {
ffffffe0002015e8:	fd843783          	ld	a5,-40(s0)
ffffffe0002015ec:	0007c783          	lbu	a5,0(a5)
ffffffe0002015f0:	00078713          	mv	a4,a5
ffffffe0002015f4:	03000793          	li	a5,48
ffffffe0002015f8:	04f71e63          	bne	a4,a5,ffffffe000201654 <strtol+0x120>
            p++;
ffffffe0002015fc:	fd843783          	ld	a5,-40(s0)
ffffffe000201600:	00178793          	addi	a5,a5,1
ffffffe000201604:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
ffffffe000201608:	fd843783          	ld	a5,-40(s0)
ffffffe00020160c:	0007c783          	lbu	a5,0(a5)
ffffffe000201610:	00078713          	mv	a4,a5
ffffffe000201614:	07800793          	li	a5,120
ffffffe000201618:	00f70c63          	beq	a4,a5,ffffffe000201630 <strtol+0xfc>
ffffffe00020161c:	fd843783          	ld	a5,-40(s0)
ffffffe000201620:	0007c783          	lbu	a5,0(a5)
ffffffe000201624:	00078713          	mv	a4,a5
ffffffe000201628:	05800793          	li	a5,88
ffffffe00020162c:	00f71e63          	bne	a4,a5,ffffffe000201648 <strtol+0x114>
                base = 16;
ffffffe000201630:	01000793          	li	a5,16
ffffffe000201634:	faf42e23          	sw	a5,-68(s0)
                p++;
ffffffe000201638:	fd843783          	ld	a5,-40(s0)
ffffffe00020163c:	00178793          	addi	a5,a5,1
ffffffe000201640:	fcf43c23          	sd	a5,-40(s0)
ffffffe000201644:	0180006f          	j	ffffffe00020165c <strtol+0x128>
            } else {
                base = 8;
ffffffe000201648:	00800793          	li	a5,8
ffffffe00020164c:	faf42e23          	sw	a5,-68(s0)
ffffffe000201650:	00c0006f          	j	ffffffe00020165c <strtol+0x128>
            }
        } else {
            base = 10;
ffffffe000201654:	00a00793          	li	a5,10
ffffffe000201658:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
ffffffe00020165c:	fd843783          	ld	a5,-40(s0)
ffffffe000201660:	0007c783          	lbu	a5,0(a5)
ffffffe000201664:	00078713          	mv	a4,a5
ffffffe000201668:	02f00793          	li	a5,47
ffffffe00020166c:	02e7f863          	bgeu	a5,a4,ffffffe00020169c <strtol+0x168>
ffffffe000201670:	fd843783          	ld	a5,-40(s0)
ffffffe000201674:	0007c783          	lbu	a5,0(a5)
ffffffe000201678:	00078713          	mv	a4,a5
ffffffe00020167c:	03900793          	li	a5,57
ffffffe000201680:	00e7ee63          	bltu	a5,a4,ffffffe00020169c <strtol+0x168>
            digit = *p - '0';
ffffffe000201684:	fd843783          	ld	a5,-40(s0)
ffffffe000201688:	0007c783          	lbu	a5,0(a5)
ffffffe00020168c:	0007879b          	sext.w	a5,a5
ffffffe000201690:	fd07879b          	addiw	a5,a5,-48
ffffffe000201694:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201698:	0800006f          	j	ffffffe000201718 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
ffffffe00020169c:	fd843783          	ld	a5,-40(s0)
ffffffe0002016a0:	0007c783          	lbu	a5,0(a5)
ffffffe0002016a4:	00078713          	mv	a4,a5
ffffffe0002016a8:	06000793          	li	a5,96
ffffffe0002016ac:	02e7f863          	bgeu	a5,a4,ffffffe0002016dc <strtol+0x1a8>
ffffffe0002016b0:	fd843783          	ld	a5,-40(s0)
ffffffe0002016b4:	0007c783          	lbu	a5,0(a5)
ffffffe0002016b8:	00078713          	mv	a4,a5
ffffffe0002016bc:	07a00793          	li	a5,122
ffffffe0002016c0:	00e7ee63          	bltu	a5,a4,ffffffe0002016dc <strtol+0x1a8>
            digit = *p - ('a' - 10);
ffffffe0002016c4:	fd843783          	ld	a5,-40(s0)
ffffffe0002016c8:	0007c783          	lbu	a5,0(a5)
ffffffe0002016cc:	0007879b          	sext.w	a5,a5
ffffffe0002016d0:	fa97879b          	addiw	a5,a5,-87
ffffffe0002016d4:	fcf42a23          	sw	a5,-44(s0)
ffffffe0002016d8:	0400006f          	j	ffffffe000201718 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
ffffffe0002016dc:	fd843783          	ld	a5,-40(s0)
ffffffe0002016e0:	0007c783          	lbu	a5,0(a5)
ffffffe0002016e4:	00078713          	mv	a4,a5
ffffffe0002016e8:	04000793          	li	a5,64
ffffffe0002016ec:	06e7f863          	bgeu	a5,a4,ffffffe00020175c <strtol+0x228>
ffffffe0002016f0:	fd843783          	ld	a5,-40(s0)
ffffffe0002016f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002016f8:	00078713          	mv	a4,a5
ffffffe0002016fc:	05a00793          	li	a5,90
ffffffe000201700:	04e7ee63          	bltu	a5,a4,ffffffe00020175c <strtol+0x228>
            digit = *p - ('A' - 10);
ffffffe000201704:	fd843783          	ld	a5,-40(s0)
ffffffe000201708:	0007c783          	lbu	a5,0(a5)
ffffffe00020170c:	0007879b          	sext.w	a5,a5
ffffffe000201710:	fc97879b          	addiw	a5,a5,-55
ffffffe000201714:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
ffffffe000201718:	fd442783          	lw	a5,-44(s0)
ffffffe00020171c:	00078713          	mv	a4,a5
ffffffe000201720:	fbc42783          	lw	a5,-68(s0)
ffffffe000201724:	0007071b          	sext.w	a4,a4
ffffffe000201728:	0007879b          	sext.w	a5,a5
ffffffe00020172c:	02f75663          	bge	a4,a5,ffffffe000201758 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
ffffffe000201730:	fbc42703          	lw	a4,-68(s0)
ffffffe000201734:	fe843783          	ld	a5,-24(s0)
ffffffe000201738:	02f70733          	mul	a4,a4,a5
ffffffe00020173c:	fd442783          	lw	a5,-44(s0)
ffffffe000201740:	00f707b3          	add	a5,a4,a5
ffffffe000201744:	fef43423          	sd	a5,-24(s0)
        p++;
ffffffe000201748:	fd843783          	ld	a5,-40(s0)
ffffffe00020174c:	00178793          	addi	a5,a5,1
ffffffe000201750:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
ffffffe000201754:	f09ff06f          	j	ffffffe00020165c <strtol+0x128>
            break;
ffffffe000201758:	00000013          	nop
    }

    if (endptr) {
ffffffe00020175c:	fc043783          	ld	a5,-64(s0)
ffffffe000201760:	00078863          	beqz	a5,ffffffe000201770 <strtol+0x23c>
        *endptr = (char *)p;
ffffffe000201764:	fc043783          	ld	a5,-64(s0)
ffffffe000201768:	fd843703          	ld	a4,-40(s0)
ffffffe00020176c:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
ffffffe000201770:	fe744783          	lbu	a5,-25(s0)
ffffffe000201774:	0ff7f793          	zext.b	a5,a5
ffffffe000201778:	00078863          	beqz	a5,ffffffe000201788 <strtol+0x254>
ffffffe00020177c:	fe843783          	ld	a5,-24(s0)
ffffffe000201780:	40f007b3          	neg	a5,a5
ffffffe000201784:	0080006f          	j	ffffffe00020178c <strtol+0x258>
ffffffe000201788:	fe843783          	ld	a5,-24(s0)
}
ffffffe00020178c:	00078513          	mv	a0,a5
ffffffe000201790:	04813083          	ld	ra,72(sp)
ffffffe000201794:	04013403          	ld	s0,64(sp)
ffffffe000201798:	05010113          	addi	sp,sp,80
ffffffe00020179c:	00008067          	ret

ffffffe0002017a0 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
ffffffe0002017a0:	fd010113          	addi	sp,sp,-48
ffffffe0002017a4:	02113423          	sd	ra,40(sp)
ffffffe0002017a8:	02813023          	sd	s0,32(sp)
ffffffe0002017ac:	03010413          	addi	s0,sp,48
ffffffe0002017b0:	fca43c23          	sd	a0,-40(s0)
ffffffe0002017b4:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
ffffffe0002017b8:	fd043783          	ld	a5,-48(s0)
ffffffe0002017bc:	00079863          	bnez	a5,ffffffe0002017cc <puts_wo_nl+0x2c>
        s = "(null)";
ffffffe0002017c0:	00002797          	auipc	a5,0x2
ffffffe0002017c4:	bb878793          	addi	a5,a5,-1096 # ffffffe000203378 <__func__.0+0x48>
ffffffe0002017c8:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
ffffffe0002017cc:	fd043783          	ld	a5,-48(s0)
ffffffe0002017d0:	fef43423          	sd	a5,-24(s0)
    while (*p) {
ffffffe0002017d4:	0240006f          	j	ffffffe0002017f8 <puts_wo_nl+0x58>
        putch(*p++);
ffffffe0002017d8:	fe843783          	ld	a5,-24(s0)
ffffffe0002017dc:	00178713          	addi	a4,a5,1
ffffffe0002017e0:	fee43423          	sd	a4,-24(s0)
ffffffe0002017e4:	0007c783          	lbu	a5,0(a5)
ffffffe0002017e8:	0007871b          	sext.w	a4,a5
ffffffe0002017ec:	fd843783          	ld	a5,-40(s0)
ffffffe0002017f0:	00070513          	mv	a0,a4
ffffffe0002017f4:	000780e7          	jalr	a5
    while (*p) {
ffffffe0002017f8:	fe843783          	ld	a5,-24(s0)
ffffffe0002017fc:	0007c783          	lbu	a5,0(a5)
ffffffe000201800:	fc079ce3          	bnez	a5,ffffffe0002017d8 <puts_wo_nl+0x38>
    }
    return p - s;
ffffffe000201804:	fe843703          	ld	a4,-24(s0)
ffffffe000201808:	fd043783          	ld	a5,-48(s0)
ffffffe00020180c:	40f707b3          	sub	a5,a4,a5
ffffffe000201810:	0007879b          	sext.w	a5,a5
}
ffffffe000201814:	00078513          	mv	a0,a5
ffffffe000201818:	02813083          	ld	ra,40(sp)
ffffffe00020181c:	02013403          	ld	s0,32(sp)
ffffffe000201820:	03010113          	addi	sp,sp,48
ffffffe000201824:	00008067          	ret

ffffffe000201828 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
ffffffe000201828:	f9010113          	addi	sp,sp,-112
ffffffe00020182c:	06113423          	sd	ra,104(sp)
ffffffe000201830:	06813023          	sd	s0,96(sp)
ffffffe000201834:	07010413          	addi	s0,sp,112
ffffffe000201838:	faa43423          	sd	a0,-88(s0)
ffffffe00020183c:	fab43023          	sd	a1,-96(s0)
ffffffe000201840:	00060793          	mv	a5,a2
ffffffe000201844:	f8d43823          	sd	a3,-112(s0)
ffffffe000201848:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
ffffffe00020184c:	f9f44783          	lbu	a5,-97(s0)
ffffffe000201850:	0ff7f793          	zext.b	a5,a5
ffffffe000201854:	02078663          	beqz	a5,ffffffe000201880 <print_dec_int+0x58>
ffffffe000201858:	fa043703          	ld	a4,-96(s0)
ffffffe00020185c:	fff00793          	li	a5,-1
ffffffe000201860:	03f79793          	slli	a5,a5,0x3f
ffffffe000201864:	00f71e63          	bne	a4,a5,ffffffe000201880 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
ffffffe000201868:	00002597          	auipc	a1,0x2
ffffffe00020186c:	b1858593          	addi	a1,a1,-1256 # ffffffe000203380 <__func__.0+0x50>
ffffffe000201870:	fa843503          	ld	a0,-88(s0)
ffffffe000201874:	f2dff0ef          	jal	ffffffe0002017a0 <puts_wo_nl>
ffffffe000201878:	00050793          	mv	a5,a0
ffffffe00020187c:	2a00006f          	j	ffffffe000201b1c <print_dec_int+0x2f4>
    }

    if (flags->prec == 0 && num == 0) {
ffffffe000201880:	f9043783          	ld	a5,-112(s0)
ffffffe000201884:	00c7a783          	lw	a5,12(a5)
ffffffe000201888:	00079a63          	bnez	a5,ffffffe00020189c <print_dec_int+0x74>
ffffffe00020188c:	fa043783          	ld	a5,-96(s0)
ffffffe000201890:	00079663          	bnez	a5,ffffffe00020189c <print_dec_int+0x74>
        return 0;
ffffffe000201894:	00000793          	li	a5,0
ffffffe000201898:	2840006f          	j	ffffffe000201b1c <print_dec_int+0x2f4>
    }

    bool neg = false;
ffffffe00020189c:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
ffffffe0002018a0:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002018a4:	0ff7f793          	zext.b	a5,a5
ffffffe0002018a8:	02078063          	beqz	a5,ffffffe0002018c8 <print_dec_int+0xa0>
ffffffe0002018ac:	fa043783          	ld	a5,-96(s0)
ffffffe0002018b0:	0007dc63          	bgez	a5,ffffffe0002018c8 <print_dec_int+0xa0>
        neg = true;
ffffffe0002018b4:	00100793          	li	a5,1
ffffffe0002018b8:	fef407a3          	sb	a5,-17(s0)
        num = -num;
ffffffe0002018bc:	fa043783          	ld	a5,-96(s0)
ffffffe0002018c0:	40f007b3          	neg	a5,a5
ffffffe0002018c4:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
ffffffe0002018c8:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
ffffffe0002018cc:	f9f44783          	lbu	a5,-97(s0)
ffffffe0002018d0:	0ff7f793          	zext.b	a5,a5
ffffffe0002018d4:	02078863          	beqz	a5,ffffffe000201904 <print_dec_int+0xdc>
ffffffe0002018d8:	fef44783          	lbu	a5,-17(s0)
ffffffe0002018dc:	0ff7f793          	zext.b	a5,a5
ffffffe0002018e0:	00079e63          	bnez	a5,ffffffe0002018fc <print_dec_int+0xd4>
ffffffe0002018e4:	f9043783          	ld	a5,-112(s0)
ffffffe0002018e8:	0057c783          	lbu	a5,5(a5)
ffffffe0002018ec:	00079863          	bnez	a5,ffffffe0002018fc <print_dec_int+0xd4>
ffffffe0002018f0:	f9043783          	ld	a5,-112(s0)
ffffffe0002018f4:	0047c783          	lbu	a5,4(a5)
ffffffe0002018f8:	00078663          	beqz	a5,ffffffe000201904 <print_dec_int+0xdc>
ffffffe0002018fc:	00100793          	li	a5,1
ffffffe000201900:	0080006f          	j	ffffffe000201908 <print_dec_int+0xe0>
ffffffe000201904:	00000793          	li	a5,0
ffffffe000201908:	fcf40ba3          	sb	a5,-41(s0)
ffffffe00020190c:	fd744783          	lbu	a5,-41(s0)
ffffffe000201910:	0017f793          	andi	a5,a5,1
ffffffe000201914:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
ffffffe000201918:	fa043703          	ld	a4,-96(s0)
ffffffe00020191c:	00a00793          	li	a5,10
ffffffe000201920:	02f777b3          	remu	a5,a4,a5
ffffffe000201924:	0ff7f713          	zext.b	a4,a5
ffffffe000201928:	fe842783          	lw	a5,-24(s0)
ffffffe00020192c:	0017869b          	addiw	a3,a5,1
ffffffe000201930:	fed42423          	sw	a3,-24(s0)
ffffffe000201934:	0307071b          	addiw	a4,a4,48
ffffffe000201938:	0ff77713          	zext.b	a4,a4
ffffffe00020193c:	ff078793          	addi	a5,a5,-16
ffffffe000201940:	008787b3          	add	a5,a5,s0
ffffffe000201944:	fce78423          	sb	a4,-56(a5)
        num /= 10;
ffffffe000201948:	fa043703          	ld	a4,-96(s0)
ffffffe00020194c:	00a00793          	li	a5,10
ffffffe000201950:	02f757b3          	divu	a5,a4,a5
ffffffe000201954:	faf43023          	sd	a5,-96(s0)
    } while (num);
ffffffe000201958:	fa043783          	ld	a5,-96(s0)
ffffffe00020195c:	fa079ee3          	bnez	a5,ffffffe000201918 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
ffffffe000201960:	f9043783          	ld	a5,-112(s0)
ffffffe000201964:	00c7a783          	lw	a5,12(a5)
ffffffe000201968:	00078713          	mv	a4,a5
ffffffe00020196c:	fff00793          	li	a5,-1
ffffffe000201970:	02f71063          	bne	a4,a5,ffffffe000201990 <print_dec_int+0x168>
ffffffe000201974:	f9043783          	ld	a5,-112(s0)
ffffffe000201978:	0037c783          	lbu	a5,3(a5)
ffffffe00020197c:	00078a63          	beqz	a5,ffffffe000201990 <print_dec_int+0x168>
        flags->prec = flags->width;
ffffffe000201980:	f9043783          	ld	a5,-112(s0)
ffffffe000201984:	0087a703          	lw	a4,8(a5)
ffffffe000201988:	f9043783          	ld	a5,-112(s0)
ffffffe00020198c:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
ffffffe000201990:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201994:	f9043783          	ld	a5,-112(s0)
ffffffe000201998:	0087a703          	lw	a4,8(a5)
ffffffe00020199c:	fe842783          	lw	a5,-24(s0)
ffffffe0002019a0:	fcf42823          	sw	a5,-48(s0)
ffffffe0002019a4:	f9043783          	ld	a5,-112(s0)
ffffffe0002019a8:	00c7a783          	lw	a5,12(a5)
ffffffe0002019ac:	fcf42623          	sw	a5,-52(s0)
ffffffe0002019b0:	fd042783          	lw	a5,-48(s0)
ffffffe0002019b4:	00078593          	mv	a1,a5
ffffffe0002019b8:	fcc42783          	lw	a5,-52(s0)
ffffffe0002019bc:	00078613          	mv	a2,a5
ffffffe0002019c0:	0006069b          	sext.w	a3,a2
ffffffe0002019c4:	0005879b          	sext.w	a5,a1
ffffffe0002019c8:	00f6d463          	bge	a3,a5,ffffffe0002019d0 <print_dec_int+0x1a8>
ffffffe0002019cc:	00058613          	mv	a2,a1
ffffffe0002019d0:	0006079b          	sext.w	a5,a2
ffffffe0002019d4:	40f707bb          	subw	a5,a4,a5
ffffffe0002019d8:	0007871b          	sext.w	a4,a5
ffffffe0002019dc:	fd744783          	lbu	a5,-41(s0)
ffffffe0002019e0:	0007879b          	sext.w	a5,a5
ffffffe0002019e4:	40f707bb          	subw	a5,a4,a5
ffffffe0002019e8:	fef42023          	sw	a5,-32(s0)
ffffffe0002019ec:	0280006f          	j	ffffffe000201a14 <print_dec_int+0x1ec>
        putch(' ');
ffffffe0002019f0:	fa843783          	ld	a5,-88(s0)
ffffffe0002019f4:	02000513          	li	a0,32
ffffffe0002019f8:	000780e7          	jalr	a5
        ++written;
ffffffe0002019fc:	fe442783          	lw	a5,-28(s0)
ffffffe000201a00:	0017879b          	addiw	a5,a5,1
ffffffe000201a04:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
ffffffe000201a08:	fe042783          	lw	a5,-32(s0)
ffffffe000201a0c:	fff7879b          	addiw	a5,a5,-1
ffffffe000201a10:	fef42023          	sw	a5,-32(s0)
ffffffe000201a14:	fe042783          	lw	a5,-32(s0)
ffffffe000201a18:	0007879b          	sext.w	a5,a5
ffffffe000201a1c:	fcf04ae3          	bgtz	a5,ffffffe0002019f0 <print_dec_int+0x1c8>
    }

    if (has_sign_char) {
ffffffe000201a20:	fd744783          	lbu	a5,-41(s0)
ffffffe000201a24:	0ff7f793          	zext.b	a5,a5
ffffffe000201a28:	04078463          	beqz	a5,ffffffe000201a70 <print_dec_int+0x248>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
ffffffe000201a2c:	fef44783          	lbu	a5,-17(s0)
ffffffe000201a30:	0ff7f793          	zext.b	a5,a5
ffffffe000201a34:	00078663          	beqz	a5,ffffffe000201a40 <print_dec_int+0x218>
ffffffe000201a38:	02d00793          	li	a5,45
ffffffe000201a3c:	01c0006f          	j	ffffffe000201a58 <print_dec_int+0x230>
ffffffe000201a40:	f9043783          	ld	a5,-112(s0)
ffffffe000201a44:	0057c783          	lbu	a5,5(a5)
ffffffe000201a48:	00078663          	beqz	a5,ffffffe000201a54 <print_dec_int+0x22c>
ffffffe000201a4c:	02b00793          	li	a5,43
ffffffe000201a50:	0080006f          	j	ffffffe000201a58 <print_dec_int+0x230>
ffffffe000201a54:	02000793          	li	a5,32
ffffffe000201a58:	fa843703          	ld	a4,-88(s0)
ffffffe000201a5c:	00078513          	mv	a0,a5
ffffffe000201a60:	000700e7          	jalr	a4
        ++written;
ffffffe000201a64:	fe442783          	lw	a5,-28(s0)
ffffffe000201a68:	0017879b          	addiw	a5,a5,1
ffffffe000201a6c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201a70:	fe842783          	lw	a5,-24(s0)
ffffffe000201a74:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201a78:	0280006f          	j	ffffffe000201aa0 <print_dec_int+0x278>
        putch('0');
ffffffe000201a7c:	fa843783          	ld	a5,-88(s0)
ffffffe000201a80:	03000513          	li	a0,48
ffffffe000201a84:	000780e7          	jalr	a5
        ++written;
ffffffe000201a88:	fe442783          	lw	a5,-28(s0)
ffffffe000201a8c:	0017879b          	addiw	a5,a5,1
ffffffe000201a90:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
ffffffe000201a94:	fdc42783          	lw	a5,-36(s0)
ffffffe000201a98:	0017879b          	addiw	a5,a5,1
ffffffe000201a9c:	fcf42e23          	sw	a5,-36(s0)
ffffffe000201aa0:	f9043783          	ld	a5,-112(s0)
ffffffe000201aa4:	00c7a703          	lw	a4,12(a5)
ffffffe000201aa8:	fd744783          	lbu	a5,-41(s0)
ffffffe000201aac:	0007879b          	sext.w	a5,a5
ffffffe000201ab0:	40f707bb          	subw	a5,a4,a5
ffffffe000201ab4:	0007871b          	sext.w	a4,a5
ffffffe000201ab8:	fdc42783          	lw	a5,-36(s0)
ffffffe000201abc:	0007879b          	sext.w	a5,a5
ffffffe000201ac0:	fae7cee3          	blt	a5,a4,ffffffe000201a7c <print_dec_int+0x254>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201ac4:	fe842783          	lw	a5,-24(s0)
ffffffe000201ac8:	fff7879b          	addiw	a5,a5,-1
ffffffe000201acc:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201ad0:	03c0006f          	j	ffffffe000201b0c <print_dec_int+0x2e4>
        putch(buf[i]);
ffffffe000201ad4:	fd842783          	lw	a5,-40(s0)
ffffffe000201ad8:	ff078793          	addi	a5,a5,-16
ffffffe000201adc:	008787b3          	add	a5,a5,s0
ffffffe000201ae0:	fc87c783          	lbu	a5,-56(a5)
ffffffe000201ae4:	0007871b          	sext.w	a4,a5
ffffffe000201ae8:	fa843783          	ld	a5,-88(s0)
ffffffe000201aec:	00070513          	mv	a0,a4
ffffffe000201af0:	000780e7          	jalr	a5
        ++written;
ffffffe000201af4:	fe442783          	lw	a5,-28(s0)
ffffffe000201af8:	0017879b          	addiw	a5,a5,1
ffffffe000201afc:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
ffffffe000201b00:	fd842783          	lw	a5,-40(s0)
ffffffe000201b04:	fff7879b          	addiw	a5,a5,-1
ffffffe000201b08:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201b0c:	fd842783          	lw	a5,-40(s0)
ffffffe000201b10:	0007879b          	sext.w	a5,a5
ffffffe000201b14:	fc07d0e3          	bgez	a5,ffffffe000201ad4 <print_dec_int+0x2ac>
    }

    return written;
ffffffe000201b18:	fe442783          	lw	a5,-28(s0)
}
ffffffe000201b1c:	00078513          	mv	a0,a5
ffffffe000201b20:	06813083          	ld	ra,104(sp)
ffffffe000201b24:	06013403          	ld	s0,96(sp)
ffffffe000201b28:	07010113          	addi	sp,sp,112
ffffffe000201b2c:	00008067          	ret

ffffffe000201b30 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
ffffffe000201b30:	f4010113          	addi	sp,sp,-192
ffffffe000201b34:	0a113c23          	sd	ra,184(sp)
ffffffe000201b38:	0a813823          	sd	s0,176(sp)
ffffffe000201b3c:	0c010413          	addi	s0,sp,192
ffffffe000201b40:	f4a43c23          	sd	a0,-168(s0)
ffffffe000201b44:	f4b43823          	sd	a1,-176(s0)
ffffffe000201b48:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
ffffffe000201b4c:	f8043023          	sd	zero,-128(s0)
ffffffe000201b50:	f8043423          	sd	zero,-120(s0)

    int written = 0;
ffffffe000201b54:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
ffffffe000201b58:	7a40006f          	j	ffffffe0002022fc <vprintfmt+0x7cc>
        if (flags.in_format) {
ffffffe000201b5c:	f8044783          	lbu	a5,-128(s0)
ffffffe000201b60:	72078e63          	beqz	a5,ffffffe00020229c <vprintfmt+0x76c>
            if (*fmt == '#') {
ffffffe000201b64:	f5043783          	ld	a5,-176(s0)
ffffffe000201b68:	0007c783          	lbu	a5,0(a5)
ffffffe000201b6c:	00078713          	mv	a4,a5
ffffffe000201b70:	02300793          	li	a5,35
ffffffe000201b74:	00f71863          	bne	a4,a5,ffffffe000201b84 <vprintfmt+0x54>
                flags.sharpflag = true;
ffffffe000201b78:	00100793          	li	a5,1
ffffffe000201b7c:	f8f40123          	sb	a5,-126(s0)
ffffffe000201b80:	7700006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == '0') {
ffffffe000201b84:	f5043783          	ld	a5,-176(s0)
ffffffe000201b88:	0007c783          	lbu	a5,0(a5)
ffffffe000201b8c:	00078713          	mv	a4,a5
ffffffe000201b90:	03000793          	li	a5,48
ffffffe000201b94:	00f71863          	bne	a4,a5,ffffffe000201ba4 <vprintfmt+0x74>
                flags.zeroflag = true;
ffffffe000201b98:	00100793          	li	a5,1
ffffffe000201b9c:	f8f401a3          	sb	a5,-125(s0)
ffffffe000201ba0:	7500006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
ffffffe000201ba4:	f5043783          	ld	a5,-176(s0)
ffffffe000201ba8:	0007c783          	lbu	a5,0(a5)
ffffffe000201bac:	00078713          	mv	a4,a5
ffffffe000201bb0:	06c00793          	li	a5,108
ffffffe000201bb4:	04f70063          	beq	a4,a5,ffffffe000201bf4 <vprintfmt+0xc4>
ffffffe000201bb8:	f5043783          	ld	a5,-176(s0)
ffffffe000201bbc:	0007c783          	lbu	a5,0(a5)
ffffffe000201bc0:	00078713          	mv	a4,a5
ffffffe000201bc4:	07a00793          	li	a5,122
ffffffe000201bc8:	02f70663          	beq	a4,a5,ffffffe000201bf4 <vprintfmt+0xc4>
ffffffe000201bcc:	f5043783          	ld	a5,-176(s0)
ffffffe000201bd0:	0007c783          	lbu	a5,0(a5)
ffffffe000201bd4:	00078713          	mv	a4,a5
ffffffe000201bd8:	07400793          	li	a5,116
ffffffe000201bdc:	00f70c63          	beq	a4,a5,ffffffe000201bf4 <vprintfmt+0xc4>
ffffffe000201be0:	f5043783          	ld	a5,-176(s0)
ffffffe000201be4:	0007c783          	lbu	a5,0(a5)
ffffffe000201be8:	00078713          	mv	a4,a5
ffffffe000201bec:	06a00793          	li	a5,106
ffffffe000201bf0:	00f71863          	bne	a4,a5,ffffffe000201c00 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
ffffffe000201bf4:	00100793          	li	a5,1
ffffffe000201bf8:	f8f400a3          	sb	a5,-127(s0)
ffffffe000201bfc:	6f40006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == '+') {
ffffffe000201c00:	f5043783          	ld	a5,-176(s0)
ffffffe000201c04:	0007c783          	lbu	a5,0(a5)
ffffffe000201c08:	00078713          	mv	a4,a5
ffffffe000201c0c:	02b00793          	li	a5,43
ffffffe000201c10:	00f71863          	bne	a4,a5,ffffffe000201c20 <vprintfmt+0xf0>
                flags.sign = true;
ffffffe000201c14:	00100793          	li	a5,1
ffffffe000201c18:	f8f402a3          	sb	a5,-123(s0)
ffffffe000201c1c:	6d40006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == ' ') {
ffffffe000201c20:	f5043783          	ld	a5,-176(s0)
ffffffe000201c24:	0007c783          	lbu	a5,0(a5)
ffffffe000201c28:	00078713          	mv	a4,a5
ffffffe000201c2c:	02000793          	li	a5,32
ffffffe000201c30:	00f71863          	bne	a4,a5,ffffffe000201c40 <vprintfmt+0x110>
                flags.spaceflag = true;
ffffffe000201c34:	00100793          	li	a5,1
ffffffe000201c38:	f8f40223          	sb	a5,-124(s0)
ffffffe000201c3c:	6b40006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == '*') {
ffffffe000201c40:	f5043783          	ld	a5,-176(s0)
ffffffe000201c44:	0007c783          	lbu	a5,0(a5)
ffffffe000201c48:	00078713          	mv	a4,a5
ffffffe000201c4c:	02a00793          	li	a5,42
ffffffe000201c50:	00f71e63          	bne	a4,a5,ffffffe000201c6c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
ffffffe000201c54:	f4843783          	ld	a5,-184(s0)
ffffffe000201c58:	00878713          	addi	a4,a5,8
ffffffe000201c5c:	f4e43423          	sd	a4,-184(s0)
ffffffe000201c60:	0007a783          	lw	a5,0(a5)
ffffffe000201c64:	f8f42423          	sw	a5,-120(s0)
ffffffe000201c68:	6880006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt >= '1' && *fmt <= '9') {
ffffffe000201c6c:	f5043783          	ld	a5,-176(s0)
ffffffe000201c70:	0007c783          	lbu	a5,0(a5)
ffffffe000201c74:	00078713          	mv	a4,a5
ffffffe000201c78:	03000793          	li	a5,48
ffffffe000201c7c:	04e7f663          	bgeu	a5,a4,ffffffe000201cc8 <vprintfmt+0x198>
ffffffe000201c80:	f5043783          	ld	a5,-176(s0)
ffffffe000201c84:	0007c783          	lbu	a5,0(a5)
ffffffe000201c88:	00078713          	mv	a4,a5
ffffffe000201c8c:	03900793          	li	a5,57
ffffffe000201c90:	02e7ec63          	bltu	a5,a4,ffffffe000201cc8 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
ffffffe000201c94:	f5043783          	ld	a5,-176(s0)
ffffffe000201c98:	f5040713          	addi	a4,s0,-176
ffffffe000201c9c:	00a00613          	li	a2,10
ffffffe000201ca0:	00070593          	mv	a1,a4
ffffffe000201ca4:	00078513          	mv	a0,a5
ffffffe000201ca8:	88dff0ef          	jal	ffffffe000201534 <strtol>
ffffffe000201cac:	00050793          	mv	a5,a0
ffffffe000201cb0:	0007879b          	sext.w	a5,a5
ffffffe000201cb4:	f8f42423          	sw	a5,-120(s0)
                fmt--;
ffffffe000201cb8:	f5043783          	ld	a5,-176(s0)
ffffffe000201cbc:	fff78793          	addi	a5,a5,-1
ffffffe000201cc0:	f4f43823          	sd	a5,-176(s0)
ffffffe000201cc4:	62c0006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == '.') {
ffffffe000201cc8:	f5043783          	ld	a5,-176(s0)
ffffffe000201ccc:	0007c783          	lbu	a5,0(a5)
ffffffe000201cd0:	00078713          	mv	a4,a5
ffffffe000201cd4:	02e00793          	li	a5,46
ffffffe000201cd8:	06f71863          	bne	a4,a5,ffffffe000201d48 <vprintfmt+0x218>
                fmt++;
ffffffe000201cdc:	f5043783          	ld	a5,-176(s0)
ffffffe000201ce0:	00178793          	addi	a5,a5,1
ffffffe000201ce4:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
ffffffe000201ce8:	f5043783          	ld	a5,-176(s0)
ffffffe000201cec:	0007c783          	lbu	a5,0(a5)
ffffffe000201cf0:	00078713          	mv	a4,a5
ffffffe000201cf4:	02a00793          	li	a5,42
ffffffe000201cf8:	00f71e63          	bne	a4,a5,ffffffe000201d14 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
ffffffe000201cfc:	f4843783          	ld	a5,-184(s0)
ffffffe000201d00:	00878713          	addi	a4,a5,8
ffffffe000201d04:	f4e43423          	sd	a4,-184(s0)
ffffffe000201d08:	0007a783          	lw	a5,0(a5)
ffffffe000201d0c:	f8f42623          	sw	a5,-116(s0)
ffffffe000201d10:	5e00006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
ffffffe000201d14:	f5043783          	ld	a5,-176(s0)
ffffffe000201d18:	f5040713          	addi	a4,s0,-176
ffffffe000201d1c:	00a00613          	li	a2,10
ffffffe000201d20:	00070593          	mv	a1,a4
ffffffe000201d24:	00078513          	mv	a0,a5
ffffffe000201d28:	80dff0ef          	jal	ffffffe000201534 <strtol>
ffffffe000201d2c:	00050793          	mv	a5,a0
ffffffe000201d30:	0007879b          	sext.w	a5,a5
ffffffe000201d34:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
ffffffe000201d38:	f5043783          	ld	a5,-176(s0)
ffffffe000201d3c:	fff78793          	addi	a5,a5,-1
ffffffe000201d40:	f4f43823          	sd	a5,-176(s0)
ffffffe000201d44:	5ac0006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000201d48:	f5043783          	ld	a5,-176(s0)
ffffffe000201d4c:	0007c783          	lbu	a5,0(a5)
ffffffe000201d50:	00078713          	mv	a4,a5
ffffffe000201d54:	07800793          	li	a5,120
ffffffe000201d58:	02f70663          	beq	a4,a5,ffffffe000201d84 <vprintfmt+0x254>
ffffffe000201d5c:	f5043783          	ld	a5,-176(s0)
ffffffe000201d60:	0007c783          	lbu	a5,0(a5)
ffffffe000201d64:	00078713          	mv	a4,a5
ffffffe000201d68:	05800793          	li	a5,88
ffffffe000201d6c:	00f70c63          	beq	a4,a5,ffffffe000201d84 <vprintfmt+0x254>
ffffffe000201d70:	f5043783          	ld	a5,-176(s0)
ffffffe000201d74:	0007c783          	lbu	a5,0(a5)
ffffffe000201d78:	00078713          	mv	a4,a5
ffffffe000201d7c:	07000793          	li	a5,112
ffffffe000201d80:	30f71263          	bne	a4,a5,ffffffe000202084 <vprintfmt+0x554>
                bool is_long = *fmt == 'p' || flags.longflag;
ffffffe000201d84:	f5043783          	ld	a5,-176(s0)
ffffffe000201d88:	0007c783          	lbu	a5,0(a5)
ffffffe000201d8c:	00078713          	mv	a4,a5
ffffffe000201d90:	07000793          	li	a5,112
ffffffe000201d94:	00f70663          	beq	a4,a5,ffffffe000201da0 <vprintfmt+0x270>
ffffffe000201d98:	f8144783          	lbu	a5,-127(s0)
ffffffe000201d9c:	00078663          	beqz	a5,ffffffe000201da8 <vprintfmt+0x278>
ffffffe000201da0:	00100793          	li	a5,1
ffffffe000201da4:	0080006f          	j	ffffffe000201dac <vprintfmt+0x27c>
ffffffe000201da8:	00000793          	li	a5,0
ffffffe000201dac:	faf403a3          	sb	a5,-89(s0)
ffffffe000201db0:	fa744783          	lbu	a5,-89(s0)
ffffffe000201db4:	0017f793          	andi	a5,a5,1
ffffffe000201db8:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
ffffffe000201dbc:	fa744783          	lbu	a5,-89(s0)
ffffffe000201dc0:	0ff7f793          	zext.b	a5,a5
ffffffe000201dc4:	00078c63          	beqz	a5,ffffffe000201ddc <vprintfmt+0x2ac>
ffffffe000201dc8:	f4843783          	ld	a5,-184(s0)
ffffffe000201dcc:	00878713          	addi	a4,a5,8
ffffffe000201dd0:	f4e43423          	sd	a4,-184(s0)
ffffffe000201dd4:	0007b783          	ld	a5,0(a5)
ffffffe000201dd8:	01c0006f          	j	ffffffe000201df4 <vprintfmt+0x2c4>
ffffffe000201ddc:	f4843783          	ld	a5,-184(s0)
ffffffe000201de0:	00878713          	addi	a4,a5,8
ffffffe000201de4:	f4e43423          	sd	a4,-184(s0)
ffffffe000201de8:	0007a783          	lw	a5,0(a5)
ffffffe000201dec:	02079793          	slli	a5,a5,0x20
ffffffe000201df0:	0207d793          	srli	a5,a5,0x20
ffffffe000201df4:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
ffffffe000201df8:	f8c42783          	lw	a5,-116(s0)
ffffffe000201dfc:	02079463          	bnez	a5,ffffffe000201e24 <vprintfmt+0x2f4>
ffffffe000201e00:	fe043783          	ld	a5,-32(s0)
ffffffe000201e04:	02079063          	bnez	a5,ffffffe000201e24 <vprintfmt+0x2f4>
ffffffe000201e08:	f5043783          	ld	a5,-176(s0)
ffffffe000201e0c:	0007c783          	lbu	a5,0(a5)
ffffffe000201e10:	00078713          	mv	a4,a5
ffffffe000201e14:	07000793          	li	a5,112
ffffffe000201e18:	00f70663          	beq	a4,a5,ffffffe000201e24 <vprintfmt+0x2f4>
                    flags.in_format = false;
ffffffe000201e1c:	f8040023          	sb	zero,-128(s0)
ffffffe000201e20:	4d00006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
ffffffe000201e24:	f5043783          	ld	a5,-176(s0)
ffffffe000201e28:	0007c783          	lbu	a5,0(a5)
ffffffe000201e2c:	00078713          	mv	a4,a5
ffffffe000201e30:	07000793          	li	a5,112
ffffffe000201e34:	00f70a63          	beq	a4,a5,ffffffe000201e48 <vprintfmt+0x318>
ffffffe000201e38:	f8244783          	lbu	a5,-126(s0)
ffffffe000201e3c:	00078a63          	beqz	a5,ffffffe000201e50 <vprintfmt+0x320>
ffffffe000201e40:	fe043783          	ld	a5,-32(s0)
ffffffe000201e44:	00078663          	beqz	a5,ffffffe000201e50 <vprintfmt+0x320>
ffffffe000201e48:	00100793          	li	a5,1
ffffffe000201e4c:	0080006f          	j	ffffffe000201e54 <vprintfmt+0x324>
ffffffe000201e50:	00000793          	li	a5,0
ffffffe000201e54:	faf40323          	sb	a5,-90(s0)
ffffffe000201e58:	fa644783          	lbu	a5,-90(s0)
ffffffe000201e5c:	0017f793          	andi	a5,a5,1
ffffffe000201e60:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
ffffffe000201e64:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
ffffffe000201e68:	f5043783          	ld	a5,-176(s0)
ffffffe000201e6c:	0007c783          	lbu	a5,0(a5)
ffffffe000201e70:	00078713          	mv	a4,a5
ffffffe000201e74:	05800793          	li	a5,88
ffffffe000201e78:	00f71863          	bne	a4,a5,ffffffe000201e88 <vprintfmt+0x358>
ffffffe000201e7c:	00001797          	auipc	a5,0x1
ffffffe000201e80:	51c78793          	addi	a5,a5,1308 # ffffffe000203398 <upperxdigits.1>
ffffffe000201e84:	00c0006f          	j	ffffffe000201e90 <vprintfmt+0x360>
ffffffe000201e88:	00001797          	auipc	a5,0x1
ffffffe000201e8c:	52878793          	addi	a5,a5,1320 # ffffffe0002033b0 <lowerxdigits.0>
ffffffe000201e90:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
ffffffe000201e94:	fe043783          	ld	a5,-32(s0)
ffffffe000201e98:	00f7f793          	andi	a5,a5,15
ffffffe000201e9c:	f9843703          	ld	a4,-104(s0)
ffffffe000201ea0:	00f70733          	add	a4,a4,a5
ffffffe000201ea4:	fdc42783          	lw	a5,-36(s0)
ffffffe000201ea8:	0017869b          	addiw	a3,a5,1
ffffffe000201eac:	fcd42e23          	sw	a3,-36(s0)
ffffffe000201eb0:	00074703          	lbu	a4,0(a4)
ffffffe000201eb4:	ff078793          	addi	a5,a5,-16
ffffffe000201eb8:	008787b3          	add	a5,a5,s0
ffffffe000201ebc:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
ffffffe000201ec0:	fe043783          	ld	a5,-32(s0)
ffffffe000201ec4:	0047d793          	srli	a5,a5,0x4
ffffffe000201ec8:	fef43023          	sd	a5,-32(s0)
                } while (num);
ffffffe000201ecc:	fe043783          	ld	a5,-32(s0)
ffffffe000201ed0:	fc0792e3          	bnez	a5,ffffffe000201e94 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
ffffffe000201ed4:	f8c42783          	lw	a5,-116(s0)
ffffffe000201ed8:	00078713          	mv	a4,a5
ffffffe000201edc:	fff00793          	li	a5,-1
ffffffe000201ee0:	02f71663          	bne	a4,a5,ffffffe000201f0c <vprintfmt+0x3dc>
ffffffe000201ee4:	f8344783          	lbu	a5,-125(s0)
ffffffe000201ee8:	02078263          	beqz	a5,ffffffe000201f0c <vprintfmt+0x3dc>
                    flags.prec = flags.width - 2 * prefix;
ffffffe000201eec:	f8842703          	lw	a4,-120(s0)
ffffffe000201ef0:	fa644783          	lbu	a5,-90(s0)
ffffffe000201ef4:	0007879b          	sext.w	a5,a5
ffffffe000201ef8:	0017979b          	slliw	a5,a5,0x1
ffffffe000201efc:	0007879b          	sext.w	a5,a5
ffffffe000201f00:	40f707bb          	subw	a5,a4,a5
ffffffe000201f04:	0007879b          	sext.w	a5,a5
ffffffe000201f08:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f0c:	f8842703          	lw	a4,-120(s0)
ffffffe000201f10:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f14:	0007879b          	sext.w	a5,a5
ffffffe000201f18:	0017979b          	slliw	a5,a5,0x1
ffffffe000201f1c:	0007879b          	sext.w	a5,a5
ffffffe000201f20:	40f707bb          	subw	a5,a4,a5
ffffffe000201f24:	0007871b          	sext.w	a4,a5
ffffffe000201f28:	fdc42783          	lw	a5,-36(s0)
ffffffe000201f2c:	f8f42a23          	sw	a5,-108(s0)
ffffffe000201f30:	f8c42783          	lw	a5,-116(s0)
ffffffe000201f34:	f8f42823          	sw	a5,-112(s0)
ffffffe000201f38:	f9442783          	lw	a5,-108(s0)
ffffffe000201f3c:	00078593          	mv	a1,a5
ffffffe000201f40:	f9042783          	lw	a5,-112(s0)
ffffffe000201f44:	00078613          	mv	a2,a5
ffffffe000201f48:	0006069b          	sext.w	a3,a2
ffffffe000201f4c:	0005879b          	sext.w	a5,a1
ffffffe000201f50:	00f6d463          	bge	a3,a5,ffffffe000201f58 <vprintfmt+0x428>
ffffffe000201f54:	00058613          	mv	a2,a1
ffffffe000201f58:	0006079b          	sext.w	a5,a2
ffffffe000201f5c:	40f707bb          	subw	a5,a4,a5
ffffffe000201f60:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201f64:	0280006f          	j	ffffffe000201f8c <vprintfmt+0x45c>
                    putch(' ');
ffffffe000201f68:	f5843783          	ld	a5,-168(s0)
ffffffe000201f6c:	02000513          	li	a0,32
ffffffe000201f70:	000780e7          	jalr	a5
                    ++written;
ffffffe000201f74:	fec42783          	lw	a5,-20(s0)
ffffffe000201f78:	0017879b          	addiw	a5,a5,1
ffffffe000201f7c:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
ffffffe000201f80:	fd842783          	lw	a5,-40(s0)
ffffffe000201f84:	fff7879b          	addiw	a5,a5,-1
ffffffe000201f88:	fcf42c23          	sw	a5,-40(s0)
ffffffe000201f8c:	fd842783          	lw	a5,-40(s0)
ffffffe000201f90:	0007879b          	sext.w	a5,a5
ffffffe000201f94:	fcf04ae3          	bgtz	a5,ffffffe000201f68 <vprintfmt+0x438>
                }

                if (prefix) {
ffffffe000201f98:	fa644783          	lbu	a5,-90(s0)
ffffffe000201f9c:	0ff7f793          	zext.b	a5,a5
ffffffe000201fa0:	04078463          	beqz	a5,ffffffe000201fe8 <vprintfmt+0x4b8>
                    putch('0');
ffffffe000201fa4:	f5843783          	ld	a5,-168(s0)
ffffffe000201fa8:	03000513          	li	a0,48
ffffffe000201fac:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
ffffffe000201fb0:	f5043783          	ld	a5,-176(s0)
ffffffe000201fb4:	0007c783          	lbu	a5,0(a5)
ffffffe000201fb8:	00078713          	mv	a4,a5
ffffffe000201fbc:	05800793          	li	a5,88
ffffffe000201fc0:	00f71663          	bne	a4,a5,ffffffe000201fcc <vprintfmt+0x49c>
ffffffe000201fc4:	05800793          	li	a5,88
ffffffe000201fc8:	0080006f          	j	ffffffe000201fd0 <vprintfmt+0x4a0>
ffffffe000201fcc:	07800793          	li	a5,120
ffffffe000201fd0:	f5843703          	ld	a4,-168(s0)
ffffffe000201fd4:	00078513          	mv	a0,a5
ffffffe000201fd8:	000700e7          	jalr	a4
                    written += 2;
ffffffe000201fdc:	fec42783          	lw	a5,-20(s0)
ffffffe000201fe0:	0027879b          	addiw	a5,a5,2
ffffffe000201fe4:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe000201fe8:	fdc42783          	lw	a5,-36(s0)
ffffffe000201fec:	fcf42a23          	sw	a5,-44(s0)
ffffffe000201ff0:	0280006f          	j	ffffffe000202018 <vprintfmt+0x4e8>
                    putch('0');
ffffffe000201ff4:	f5843783          	ld	a5,-168(s0)
ffffffe000201ff8:	03000513          	li	a0,48
ffffffe000201ffc:	000780e7          	jalr	a5
                    ++written;
ffffffe000202000:	fec42783          	lw	a5,-20(s0)
ffffffe000202004:	0017879b          	addiw	a5,a5,1
ffffffe000202008:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
ffffffe00020200c:	fd442783          	lw	a5,-44(s0)
ffffffe000202010:	0017879b          	addiw	a5,a5,1
ffffffe000202014:	fcf42a23          	sw	a5,-44(s0)
ffffffe000202018:	f8c42703          	lw	a4,-116(s0)
ffffffe00020201c:	fd442783          	lw	a5,-44(s0)
ffffffe000202020:	0007879b          	sext.w	a5,a5
ffffffe000202024:	fce7c8e3          	blt	a5,a4,ffffffe000201ff4 <vprintfmt+0x4c4>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202028:	fdc42783          	lw	a5,-36(s0)
ffffffe00020202c:	fff7879b          	addiw	a5,a5,-1
ffffffe000202030:	fcf42823          	sw	a5,-48(s0)
ffffffe000202034:	03c0006f          	j	ffffffe000202070 <vprintfmt+0x540>
                    putch(buf[i]);
ffffffe000202038:	fd042783          	lw	a5,-48(s0)
ffffffe00020203c:	ff078793          	addi	a5,a5,-16
ffffffe000202040:	008787b3          	add	a5,a5,s0
ffffffe000202044:	f807c783          	lbu	a5,-128(a5)
ffffffe000202048:	0007871b          	sext.w	a4,a5
ffffffe00020204c:	f5843783          	ld	a5,-168(s0)
ffffffe000202050:	00070513          	mv	a0,a4
ffffffe000202054:	000780e7          	jalr	a5
                    ++written;
ffffffe000202058:	fec42783          	lw	a5,-20(s0)
ffffffe00020205c:	0017879b          	addiw	a5,a5,1
ffffffe000202060:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
ffffffe000202064:	fd042783          	lw	a5,-48(s0)
ffffffe000202068:	fff7879b          	addiw	a5,a5,-1
ffffffe00020206c:	fcf42823          	sw	a5,-48(s0)
ffffffe000202070:	fd042783          	lw	a5,-48(s0)
ffffffe000202074:	0007879b          	sext.w	a5,a5
ffffffe000202078:	fc07d0e3          	bgez	a5,ffffffe000202038 <vprintfmt+0x508>
                }

                flags.in_format = false;
ffffffe00020207c:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
ffffffe000202080:	2700006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202084:	f5043783          	ld	a5,-176(s0)
ffffffe000202088:	0007c783          	lbu	a5,0(a5)
ffffffe00020208c:	00078713          	mv	a4,a5
ffffffe000202090:	06400793          	li	a5,100
ffffffe000202094:	02f70663          	beq	a4,a5,ffffffe0002020c0 <vprintfmt+0x590>
ffffffe000202098:	f5043783          	ld	a5,-176(s0)
ffffffe00020209c:	0007c783          	lbu	a5,0(a5)
ffffffe0002020a0:	00078713          	mv	a4,a5
ffffffe0002020a4:	06900793          	li	a5,105
ffffffe0002020a8:	00f70c63          	beq	a4,a5,ffffffe0002020c0 <vprintfmt+0x590>
ffffffe0002020ac:	f5043783          	ld	a5,-176(s0)
ffffffe0002020b0:	0007c783          	lbu	a5,0(a5)
ffffffe0002020b4:	00078713          	mv	a4,a5
ffffffe0002020b8:	07500793          	li	a5,117
ffffffe0002020bc:	08f71063          	bne	a4,a5,ffffffe00020213c <vprintfmt+0x60c>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
ffffffe0002020c0:	f8144783          	lbu	a5,-127(s0)
ffffffe0002020c4:	00078c63          	beqz	a5,ffffffe0002020dc <vprintfmt+0x5ac>
ffffffe0002020c8:	f4843783          	ld	a5,-184(s0)
ffffffe0002020cc:	00878713          	addi	a4,a5,8
ffffffe0002020d0:	f4e43423          	sd	a4,-184(s0)
ffffffe0002020d4:	0007b783          	ld	a5,0(a5)
ffffffe0002020d8:	0140006f          	j	ffffffe0002020ec <vprintfmt+0x5bc>
ffffffe0002020dc:	f4843783          	ld	a5,-184(s0)
ffffffe0002020e0:	00878713          	addi	a4,a5,8
ffffffe0002020e4:	f4e43423          	sd	a4,-184(s0)
ffffffe0002020e8:	0007a783          	lw	a5,0(a5)
ffffffe0002020ec:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
ffffffe0002020f0:	fa843583          	ld	a1,-88(s0)
ffffffe0002020f4:	f5043783          	ld	a5,-176(s0)
ffffffe0002020f8:	0007c783          	lbu	a5,0(a5)
ffffffe0002020fc:	0007871b          	sext.w	a4,a5
ffffffe000202100:	07500793          	li	a5,117
ffffffe000202104:	40f707b3          	sub	a5,a4,a5
ffffffe000202108:	00f037b3          	snez	a5,a5
ffffffe00020210c:	0ff7f793          	zext.b	a5,a5
ffffffe000202110:	f8040713          	addi	a4,s0,-128
ffffffe000202114:	00070693          	mv	a3,a4
ffffffe000202118:	00078613          	mv	a2,a5
ffffffe00020211c:	f5843503          	ld	a0,-168(s0)
ffffffe000202120:	f08ff0ef          	jal	ffffffe000201828 <print_dec_int>
ffffffe000202124:	00050793          	mv	a5,a0
ffffffe000202128:	fec42703          	lw	a4,-20(s0)
ffffffe00020212c:	00f707bb          	addw	a5,a4,a5
ffffffe000202130:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202134:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
ffffffe000202138:	1b80006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == 'n') {
ffffffe00020213c:	f5043783          	ld	a5,-176(s0)
ffffffe000202140:	0007c783          	lbu	a5,0(a5)
ffffffe000202144:	00078713          	mv	a4,a5
ffffffe000202148:	06e00793          	li	a5,110
ffffffe00020214c:	04f71c63          	bne	a4,a5,ffffffe0002021a4 <vprintfmt+0x674>
                if (flags.longflag) {
ffffffe000202150:	f8144783          	lbu	a5,-127(s0)
ffffffe000202154:	02078463          	beqz	a5,ffffffe00020217c <vprintfmt+0x64c>
                    long *n = va_arg(vl, long *);
ffffffe000202158:	f4843783          	ld	a5,-184(s0)
ffffffe00020215c:	00878713          	addi	a4,a5,8
ffffffe000202160:	f4e43423          	sd	a4,-184(s0)
ffffffe000202164:	0007b783          	ld	a5,0(a5)
ffffffe000202168:	faf43823          	sd	a5,-80(s0)
                    *n = written;
ffffffe00020216c:	fec42703          	lw	a4,-20(s0)
ffffffe000202170:	fb043783          	ld	a5,-80(s0)
ffffffe000202174:	00e7b023          	sd	a4,0(a5)
ffffffe000202178:	0240006f          	j	ffffffe00020219c <vprintfmt+0x66c>
                } else {
                    int *n = va_arg(vl, int *);
ffffffe00020217c:	f4843783          	ld	a5,-184(s0)
ffffffe000202180:	00878713          	addi	a4,a5,8
ffffffe000202184:	f4e43423          	sd	a4,-184(s0)
ffffffe000202188:	0007b783          	ld	a5,0(a5)
ffffffe00020218c:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
ffffffe000202190:	fb843783          	ld	a5,-72(s0)
ffffffe000202194:	fec42703          	lw	a4,-20(s0)
ffffffe000202198:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
ffffffe00020219c:	f8040023          	sb	zero,-128(s0)
ffffffe0002021a0:	1500006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == 's') {
ffffffe0002021a4:	f5043783          	ld	a5,-176(s0)
ffffffe0002021a8:	0007c783          	lbu	a5,0(a5)
ffffffe0002021ac:	00078713          	mv	a4,a5
ffffffe0002021b0:	07300793          	li	a5,115
ffffffe0002021b4:	02f71e63          	bne	a4,a5,ffffffe0002021f0 <vprintfmt+0x6c0>
                const char *s = va_arg(vl, const char *);
ffffffe0002021b8:	f4843783          	ld	a5,-184(s0)
ffffffe0002021bc:	00878713          	addi	a4,a5,8
ffffffe0002021c0:	f4e43423          	sd	a4,-184(s0)
ffffffe0002021c4:	0007b783          	ld	a5,0(a5)
ffffffe0002021c8:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
ffffffe0002021cc:	fc043583          	ld	a1,-64(s0)
ffffffe0002021d0:	f5843503          	ld	a0,-168(s0)
ffffffe0002021d4:	dccff0ef          	jal	ffffffe0002017a0 <puts_wo_nl>
ffffffe0002021d8:	00050793          	mv	a5,a0
ffffffe0002021dc:	fec42703          	lw	a4,-20(s0)
ffffffe0002021e0:	00f707bb          	addw	a5,a4,a5
ffffffe0002021e4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe0002021e8:	f8040023          	sb	zero,-128(s0)
ffffffe0002021ec:	1040006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == 'c') {
ffffffe0002021f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002021f4:	0007c783          	lbu	a5,0(a5)
ffffffe0002021f8:	00078713          	mv	a4,a5
ffffffe0002021fc:	06300793          	li	a5,99
ffffffe000202200:	02f71e63          	bne	a4,a5,ffffffe00020223c <vprintfmt+0x70c>
                int ch = va_arg(vl, int);
ffffffe000202204:	f4843783          	ld	a5,-184(s0)
ffffffe000202208:	00878713          	addi	a4,a5,8
ffffffe00020220c:	f4e43423          	sd	a4,-184(s0)
ffffffe000202210:	0007a783          	lw	a5,0(a5)
ffffffe000202214:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
ffffffe000202218:	fcc42703          	lw	a4,-52(s0)
ffffffe00020221c:	f5843783          	ld	a5,-168(s0)
ffffffe000202220:	00070513          	mv	a0,a4
ffffffe000202224:	000780e7          	jalr	a5
                ++written;
ffffffe000202228:	fec42783          	lw	a5,-20(s0)
ffffffe00020222c:	0017879b          	addiw	a5,a5,1
ffffffe000202230:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202234:	f8040023          	sb	zero,-128(s0)
ffffffe000202238:	0b80006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else if (*fmt == '%') {
ffffffe00020223c:	f5043783          	ld	a5,-176(s0)
ffffffe000202240:	0007c783          	lbu	a5,0(a5)
ffffffe000202244:	00078713          	mv	a4,a5
ffffffe000202248:	02500793          	li	a5,37
ffffffe00020224c:	02f71263          	bne	a4,a5,ffffffe000202270 <vprintfmt+0x740>
                putch('%');
ffffffe000202250:	f5843783          	ld	a5,-168(s0)
ffffffe000202254:	02500513          	li	a0,37
ffffffe000202258:	000780e7          	jalr	a5
                ++written;
ffffffe00020225c:	fec42783          	lw	a5,-20(s0)
ffffffe000202260:	0017879b          	addiw	a5,a5,1
ffffffe000202264:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202268:	f8040023          	sb	zero,-128(s0)
ffffffe00020226c:	0840006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            } else {
                putch(*fmt);
ffffffe000202270:	f5043783          	ld	a5,-176(s0)
ffffffe000202274:	0007c783          	lbu	a5,0(a5)
ffffffe000202278:	0007871b          	sext.w	a4,a5
ffffffe00020227c:	f5843783          	ld	a5,-168(s0)
ffffffe000202280:	00070513          	mv	a0,a4
ffffffe000202284:	000780e7          	jalr	a5
                ++written;
ffffffe000202288:	fec42783          	lw	a5,-20(s0)
ffffffe00020228c:	0017879b          	addiw	a5,a5,1
ffffffe000202290:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
ffffffe000202294:	f8040023          	sb	zero,-128(s0)
ffffffe000202298:	0580006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
            }
        } else if (*fmt == '%') {
ffffffe00020229c:	f5043783          	ld	a5,-176(s0)
ffffffe0002022a0:	0007c783          	lbu	a5,0(a5)
ffffffe0002022a4:	00078713          	mv	a4,a5
ffffffe0002022a8:	02500793          	li	a5,37
ffffffe0002022ac:	02f71063          	bne	a4,a5,ffffffe0002022cc <vprintfmt+0x79c>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
ffffffe0002022b0:	f8043023          	sd	zero,-128(s0)
ffffffe0002022b4:	f8043423          	sd	zero,-120(s0)
ffffffe0002022b8:	00100793          	li	a5,1
ffffffe0002022bc:	f8f40023          	sb	a5,-128(s0)
ffffffe0002022c0:	fff00793          	li	a5,-1
ffffffe0002022c4:	f8f42623          	sw	a5,-116(s0)
ffffffe0002022c8:	0280006f          	j	ffffffe0002022f0 <vprintfmt+0x7c0>
        } else {
            putch(*fmt);
ffffffe0002022cc:	f5043783          	ld	a5,-176(s0)
ffffffe0002022d0:	0007c783          	lbu	a5,0(a5)
ffffffe0002022d4:	0007871b          	sext.w	a4,a5
ffffffe0002022d8:	f5843783          	ld	a5,-168(s0)
ffffffe0002022dc:	00070513          	mv	a0,a4
ffffffe0002022e0:	000780e7          	jalr	a5
            ++written;
ffffffe0002022e4:	fec42783          	lw	a5,-20(s0)
ffffffe0002022e8:	0017879b          	addiw	a5,a5,1
ffffffe0002022ec:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
ffffffe0002022f0:	f5043783          	ld	a5,-176(s0)
ffffffe0002022f4:	00178793          	addi	a5,a5,1
ffffffe0002022f8:	f4f43823          	sd	a5,-176(s0)
ffffffe0002022fc:	f5043783          	ld	a5,-176(s0)
ffffffe000202300:	0007c783          	lbu	a5,0(a5)
ffffffe000202304:	84079ce3          	bnez	a5,ffffffe000201b5c <vprintfmt+0x2c>
        }
    }

    return written;
ffffffe000202308:	fec42783          	lw	a5,-20(s0)
}
ffffffe00020230c:	00078513          	mv	a0,a5
ffffffe000202310:	0b813083          	ld	ra,184(sp)
ffffffe000202314:	0b013403          	ld	s0,176(sp)
ffffffe000202318:	0c010113          	addi	sp,sp,192
ffffffe00020231c:	00008067          	ret

ffffffe000202320 <printk>:

int printk(const char* s, ...) {
ffffffe000202320:	f9010113          	addi	sp,sp,-112
ffffffe000202324:	02113423          	sd	ra,40(sp)
ffffffe000202328:	02813023          	sd	s0,32(sp)
ffffffe00020232c:	03010413          	addi	s0,sp,48
ffffffe000202330:	fca43c23          	sd	a0,-40(s0)
ffffffe000202334:	00b43423          	sd	a1,8(s0)
ffffffe000202338:	00c43823          	sd	a2,16(s0)
ffffffe00020233c:	00d43c23          	sd	a3,24(s0)
ffffffe000202340:	02e43023          	sd	a4,32(s0)
ffffffe000202344:	02f43423          	sd	a5,40(s0)
ffffffe000202348:	03043823          	sd	a6,48(s0)
ffffffe00020234c:	03143c23          	sd	a7,56(s0)
    int res = 0;
ffffffe000202350:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
ffffffe000202354:	04040793          	addi	a5,s0,64
ffffffe000202358:	fcf43823          	sd	a5,-48(s0)
ffffffe00020235c:	fd043783          	ld	a5,-48(s0)
ffffffe000202360:	fc878793          	addi	a5,a5,-56
ffffffe000202364:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
ffffffe000202368:	fe043783          	ld	a5,-32(s0)
ffffffe00020236c:	00078613          	mv	a2,a5
ffffffe000202370:	fd843583          	ld	a1,-40(s0)
ffffffe000202374:	fffff517          	auipc	a0,0xfffff
ffffffe000202378:	11850513          	addi	a0,a0,280 # ffffffe00020148c <putc>
ffffffe00020237c:	fb4ff0ef          	jal	ffffffe000201b30 <vprintfmt>
ffffffe000202380:	00050793          	mv	a5,a0
ffffffe000202384:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
ffffffe000202388:	fec42783          	lw	a5,-20(s0)
}
ffffffe00020238c:	00078513          	mv	a0,a5
ffffffe000202390:	02813083          	ld	ra,40(sp)
ffffffe000202394:	02013403          	ld	s0,32(sp)
ffffffe000202398:	07010113          	addi	sp,sp,112
ffffffe00020239c:	00008067          	ret

ffffffe0002023a0 <srand>:
#include "stdint.h"
#include "stdlib.h"

static uint64_t seed;

void srand(unsigned s) {
ffffffe0002023a0:	fe010113          	addi	sp,sp,-32
ffffffe0002023a4:	00813c23          	sd	s0,24(sp)
ffffffe0002023a8:	02010413          	addi	s0,sp,32
ffffffe0002023ac:	00050793          	mv	a5,a0
ffffffe0002023b0:	fef42623          	sw	a5,-20(s0)
    seed = s - 1;
ffffffe0002023b4:	fec42783          	lw	a5,-20(s0)
ffffffe0002023b8:	fff7879b          	addiw	a5,a5,-1
ffffffe0002023bc:	0007879b          	sext.w	a5,a5
ffffffe0002023c0:	02079713          	slli	a4,a5,0x20
ffffffe0002023c4:	02075713          	srli	a4,a4,0x20
ffffffe0002023c8:	00004797          	auipc	a5,0x4
ffffffe0002023cc:	c5878793          	addi	a5,a5,-936 # ffffffe000206020 <seed>
ffffffe0002023d0:	00e7b023          	sd	a4,0(a5)
}
ffffffe0002023d4:	00000013          	nop
ffffffe0002023d8:	01813403          	ld	s0,24(sp)
ffffffe0002023dc:	02010113          	addi	sp,sp,32
ffffffe0002023e0:	00008067          	ret

ffffffe0002023e4 <rand>:

int rand(void) {
ffffffe0002023e4:	ff010113          	addi	sp,sp,-16
ffffffe0002023e8:	00813423          	sd	s0,8(sp)
ffffffe0002023ec:	01010413          	addi	s0,sp,16
    seed = 6364136223846793005ULL * seed + 1;
ffffffe0002023f0:	00004797          	auipc	a5,0x4
ffffffe0002023f4:	c3078793          	addi	a5,a5,-976 # ffffffe000206020 <seed>
ffffffe0002023f8:	0007b703          	ld	a4,0(a5)
ffffffe0002023fc:	00001797          	auipc	a5,0x1
ffffffe000202400:	fcc78793          	addi	a5,a5,-52 # ffffffe0002033c8 <lowerxdigits.0+0x18>
ffffffe000202404:	0007b783          	ld	a5,0(a5)
ffffffe000202408:	02f707b3          	mul	a5,a4,a5
ffffffe00020240c:	00178713          	addi	a4,a5,1
ffffffe000202410:	00004797          	auipc	a5,0x4
ffffffe000202414:	c1078793          	addi	a5,a5,-1008 # ffffffe000206020 <seed>
ffffffe000202418:	00e7b023          	sd	a4,0(a5)
    return seed >> 33;
ffffffe00020241c:	00004797          	auipc	a5,0x4
ffffffe000202420:	c0478793          	addi	a5,a5,-1020 # ffffffe000206020 <seed>
ffffffe000202424:	0007b783          	ld	a5,0(a5)
ffffffe000202428:	0217d793          	srli	a5,a5,0x21
ffffffe00020242c:	0007879b          	sext.w	a5,a5
}
ffffffe000202430:	00078513          	mv	a0,a5
ffffffe000202434:	00813403          	ld	s0,8(sp)
ffffffe000202438:	01010113          	addi	sp,sp,16
ffffffe00020243c:	00008067          	ret

ffffffe000202440 <memset>:
#include "string.h"
#include "stdint.h"

void *memset(void *dest, int c, uint64_t n) {
ffffffe000202440:	fc010113          	addi	sp,sp,-64
ffffffe000202444:	02813c23          	sd	s0,56(sp)
ffffffe000202448:	04010413          	addi	s0,sp,64
ffffffe00020244c:	fca43c23          	sd	a0,-40(s0)
ffffffe000202450:	00058793          	mv	a5,a1
ffffffe000202454:	fcc43423          	sd	a2,-56(s0)
ffffffe000202458:	fcf42a23          	sw	a5,-44(s0)
    char *s = (char *)dest;
ffffffe00020245c:	fd843783          	ld	a5,-40(s0)
ffffffe000202460:	fef43023          	sd	a5,-32(s0)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202464:	fe043423          	sd	zero,-24(s0)
ffffffe000202468:	0280006f          	j	ffffffe000202490 <memset+0x50>
        s[i] = c;
ffffffe00020246c:	fe043703          	ld	a4,-32(s0)
ffffffe000202470:	fe843783          	ld	a5,-24(s0)
ffffffe000202474:	00f707b3          	add	a5,a4,a5
ffffffe000202478:	fd442703          	lw	a4,-44(s0)
ffffffe00020247c:	0ff77713          	zext.b	a4,a4
ffffffe000202480:	00e78023          	sb	a4,0(a5)
    for (uint64_t i = 0; i < n; ++i) {
ffffffe000202484:	fe843783          	ld	a5,-24(s0)
ffffffe000202488:	00178793          	addi	a5,a5,1
ffffffe00020248c:	fef43423          	sd	a5,-24(s0)
ffffffe000202490:	fe843703          	ld	a4,-24(s0)
ffffffe000202494:	fc843783          	ld	a5,-56(s0)
ffffffe000202498:	fcf76ae3          	bltu	a4,a5,ffffffe00020246c <memset+0x2c>
    }
    return dest;
ffffffe00020249c:	fd843783          	ld	a5,-40(s0)
}
ffffffe0002024a0:	00078513          	mv	a0,a5
ffffffe0002024a4:	03813403          	ld	s0,56(sp)
ffffffe0002024a8:	04010113          	addi	sp,sp,64
ffffffe0002024ac:	00008067          	ret
