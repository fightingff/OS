
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top   # set the stack pointer
    80200000:	00003117          	auipc	sp,0x3
    80200004:	01013103          	ld	sp,16(sp) # 80203010 <_GLOBAL_OFFSET_TABLE_+0x8>

    la t0, _traps
    80200008:	00003297          	auipc	t0,0x3
    8020000c:	0102b283          	ld	t0,16(t0) # 80203018 <_GLOBAL_OFFSET_TABLE_+0x10>
    csrw stvec, t0  # set stvec = _traps
    80200010:	10529073          	csrw	stvec,t0

    li t0, 32
    80200014:	02000293          	li	t0,32
    csrs sie, t0    # set sie[STIE] = 1
    80200018:	1042a073          	csrs	sie,t0
   
    call clock_set_next_event
    8020001c:	168000ef          	jal	80200184 <clock_set_next_event>
    # set first time interrupt
    
    li t0, 2
    80200020:	00200293          	li	t0,2
    csrs sstatus, t0 # set sstatus[SIE] = 1
    80200024:	1002a073          	csrs	sstatus,t0

    call start_kernel
    80200028:	5d0000ef          	jal	802005f8 <start_kernel>

000000008020002c <_traps>:
    .extern trap_handler
    .section .text.entry
    .align 2
    .globl _traps 
_traps:
    addi sp, sp, -256   # allocate 256 bytes stack space
    8020002c:	f0010113          	addi	sp,sp,-256
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
    802000c0:	4c8000ef          	jal	80200588 <trap_handler>
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
    addi sp, sp, 256    # restore stack pointer
    8020014c:	10010113          	addi	sp,sp,256
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
    802001b4:	220000ef          	jal	802003d4 <sbi_set_timer>
    802001b8:	00000013          	nop
    802001bc:	01813083          	ld	ra,24(sp)
    802001c0:	01013403          	ld	s0,16(sp)
    802001c4:	02010113          	addi	sp,sp,32
    802001c8:	00008067          	ret

00000000802001cc <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    802001cc:	f7010113          	addi	sp,sp,-144
    802001d0:	08113423          	sd	ra,136(sp)
    802001d4:	08813023          	sd	s0,128(sp)
    802001d8:	06913c23          	sd	s1,120(sp)
    802001dc:	07213823          	sd	s2,112(sp)
    802001e0:	07313423          	sd	s3,104(sp)
    802001e4:	09010413          	addi	s0,sp,144
    802001e8:	faa43423          	sd	a0,-88(s0)
    802001ec:	fab43023          	sd	a1,-96(s0)
    802001f0:	f8c43c23          	sd	a2,-104(s0)
    802001f4:	f8d43823          	sd	a3,-112(s0)
    802001f8:	f8e43423          	sd	a4,-120(s0)
    802001fc:	f8f43023          	sd	a5,-128(s0)
    80200200:	f7043c23          	sd	a6,-136(s0)
    80200204:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    80200208:	fa843e03          	ld	t3,-88(s0)
    8020020c:	fa043e83          	ld	t4,-96(s0)
    80200210:	f9843f03          	ld	t5,-104(s0)
    80200214:	f9043f83          	ld	t6,-112(s0)
    80200218:	f8843283          	ld	t0,-120(s0)
    8020021c:	f8043483          	ld	s1,-128(s0)
    80200220:	f7843903          	ld	s2,-136(s0)
    80200224:	f7043983          	ld	s3,-144(s0)
    80200228:	000e0893          	mv	a7,t3
    8020022c:	000e8813          	mv	a6,t4
    80200230:	000f0513          	mv	a0,t5
    80200234:	000f8593          	mv	a1,t6
    80200238:	00028613          	mv	a2,t0
    8020023c:	00048693          	mv	a3,s1
    80200240:	00090713          	mv	a4,s2
    80200244:	00098793          	mv	a5,s3
    80200248:	00000073          	ecall
    8020024c:	00050e93          	mv	t4,a0
    80200250:	00058e13          	mv	t3,a1
    80200254:	fbd43823          	sd	t4,-80(s0)
    80200258:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    8020025c:	fb043783          	ld	a5,-80(s0)
    80200260:	fcf43023          	sd	a5,-64(s0)
    80200264:	fb843783          	ld	a5,-72(s0)
    80200268:	fcf43423          	sd	a5,-56(s0)
    8020026c:	fc043703          	ld	a4,-64(s0)
    80200270:	fc843783          	ld	a5,-56(s0)
    80200274:	00070313          	mv	t1,a4
    80200278:	00078393          	mv	t2,a5
    8020027c:	00030713          	mv	a4,t1
    80200280:	00038793          	mv	a5,t2
}
    80200284:	00070513          	mv	a0,a4
    80200288:	00078593          	mv	a1,a5
    8020028c:	08813083          	ld	ra,136(sp)
    80200290:	08013403          	ld	s0,128(sp)
    80200294:	07813483          	ld	s1,120(sp)
    80200298:	07013903          	ld	s2,112(sp)
    8020029c:	06813983          	ld	s3,104(sp)
    802002a0:	09010113          	addi	sp,sp,144
    802002a4:	00008067          	ret

00000000802002a8 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    802002a8:	fc010113          	addi	sp,sp,-64
    802002ac:	02113c23          	sd	ra,56(sp)
    802002b0:	02813823          	sd	s0,48(sp)
    802002b4:	03213423          	sd	s2,40(sp)
    802002b8:	03313023          	sd	s3,32(sp)
    802002bc:	04010413          	addi	s0,sp,64
    802002c0:	00050793          	mv	a5,a0
    802002c4:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    802002c8:	fcf44603          	lbu	a2,-49(s0)
    802002cc:	00000893          	li	a7,0
    802002d0:	00000813          	li	a6,0
    802002d4:	00000793          	li	a5,0
    802002d8:	00000713          	li	a4,0
    802002dc:	00000693          	li	a3,0
    802002e0:	00200593          	li	a1,2
    802002e4:	44424537          	lui	a0,0x44424
    802002e8:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802002ec:	ee1ff0ef          	jal	802001cc <sbi_ecall>
    802002f0:	00050713          	mv	a4,a0
    802002f4:	00058793          	mv	a5,a1
    802002f8:	fce43823          	sd	a4,-48(s0)
    802002fc:	fcf43c23          	sd	a5,-40(s0)
    80200300:	fd043703          	ld	a4,-48(s0)
    80200304:	fd843783          	ld	a5,-40(s0)
    80200308:	00070913          	mv	s2,a4
    8020030c:	00078993          	mv	s3,a5
    80200310:	00090713          	mv	a4,s2
    80200314:	00098793          	mv	a5,s3
}
    80200318:	00070513          	mv	a0,a4
    8020031c:	00078593          	mv	a1,a5
    80200320:	03813083          	ld	ra,56(sp)
    80200324:	03013403          	ld	s0,48(sp)
    80200328:	02813903          	ld	s2,40(sp)
    8020032c:	02013983          	ld	s3,32(sp)
    80200330:	04010113          	addi	sp,sp,64
    80200334:	00008067          	ret

0000000080200338 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    80200338:	fc010113          	addi	sp,sp,-64
    8020033c:	02113c23          	sd	ra,56(sp)
    80200340:	02813823          	sd	s0,48(sp)
    80200344:	03213423          	sd	s2,40(sp)
    80200348:	03313023          	sd	s3,32(sp)
    8020034c:	04010413          	addi	s0,sp,64
    80200350:	00050793          	mv	a5,a0
    80200354:	00058713          	mv	a4,a1
    80200358:	fcf42623          	sw	a5,-52(s0)
    8020035c:	00070793          	mv	a5,a4
    80200360:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    80200364:	fcc46603          	lwu	a2,-52(s0)
    80200368:	fc846683          	lwu	a3,-56(s0)
    8020036c:	00000893          	li	a7,0
    80200370:	00000813          	li	a6,0
    80200374:	00000793          	li	a5,0
    80200378:	00000713          	li	a4,0
    8020037c:	00000593          	li	a1,0
    80200380:	53525537          	lui	a0,0x53525
    80200384:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    80200388:	e45ff0ef          	jal	802001cc <sbi_ecall>
    8020038c:	00050713          	mv	a4,a0
    80200390:	00058793          	mv	a5,a1
    80200394:	fce43823          	sd	a4,-48(s0)
    80200398:	fcf43c23          	sd	a5,-40(s0)
    8020039c:	fd043703          	ld	a4,-48(s0)
    802003a0:	fd843783          	ld	a5,-40(s0)
    802003a4:	00070913          	mv	s2,a4
    802003a8:	00078993          	mv	s3,a5
    802003ac:	00090713          	mv	a4,s2
    802003b0:	00098793          	mv	a5,s3
}
    802003b4:	00070513          	mv	a0,a4
    802003b8:	00078593          	mv	a1,a5
    802003bc:	03813083          	ld	ra,56(sp)
    802003c0:	03013403          	ld	s0,48(sp)
    802003c4:	02813903          	ld	s2,40(sp)
    802003c8:	02013983          	ld	s3,32(sp)
    802003cc:	04010113          	addi	sp,sp,64
    802003d0:	00008067          	ret

00000000802003d4 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    802003d4:	fc010113          	addi	sp,sp,-64
    802003d8:	02113c23          	sd	ra,56(sp)
    802003dc:	02813823          	sd	s0,48(sp)
    802003e0:	03213423          	sd	s2,40(sp)
    802003e4:	03313023          	sd	s3,32(sp)
    802003e8:	04010413          	addi	s0,sp,64
    802003ec:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    802003f0:	00000893          	li	a7,0
    802003f4:	00000813          	li	a6,0
    802003f8:	00000793          	li	a5,0
    802003fc:	00000713          	li	a4,0
    80200400:	00000693          	li	a3,0
    80200404:	fc843603          	ld	a2,-56(s0)
    80200408:	00000593          	li	a1,0
    8020040c:	54495537          	lui	a0,0x54495
    80200410:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200414:	db9ff0ef          	jal	802001cc <sbi_ecall>
    80200418:	00050713          	mv	a4,a0
    8020041c:	00058793          	mv	a5,a1
    80200420:	fce43823          	sd	a4,-48(s0)
    80200424:	fcf43c23          	sd	a5,-40(s0)
    80200428:	fd043703          	ld	a4,-48(s0)
    8020042c:	fd843783          	ld	a5,-40(s0)
    80200430:	00070913          	mv	s2,a4
    80200434:	00078993          	mv	s3,a5
    80200438:	00090713          	mv	a4,s2
    8020043c:	00098793          	mv	a5,s3
}
    80200440:	00070513          	mv	a0,a4
    80200444:	00078593          	mv	a1,a5
    80200448:	03813083          	ld	ra,56(sp)
    8020044c:	03013403          	ld	s0,48(sp)
    80200450:	02813903          	ld	s2,40(sp)
    80200454:	02013983          	ld	s3,32(sp)
    80200458:	04010113          	addi	sp,sp,64
    8020045c:	00008067          	ret

0000000080200460 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read(unsigned long num_bytes,
                                     unsigned long base_addr_lo,
                                     unsigned long base_addr_hi){
    80200460:	fb010113          	addi	sp,sp,-80
    80200464:	04113423          	sd	ra,72(sp)
    80200468:	04813023          	sd	s0,64(sp)
    8020046c:	03213c23          	sd	s2,56(sp)
    80200470:	03313823          	sd	s3,48(sp)
    80200474:	05010413          	addi	s0,sp,80
    80200478:	fca43423          	sd	a0,-56(s0)
    8020047c:	fcb43023          	sd	a1,-64(s0)
    80200480:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 1, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200484:	00000893          	li	a7,0
    80200488:	00000813          	li	a6,0
    8020048c:	00000793          	li	a5,0
    80200490:	fb843703          	ld	a4,-72(s0)
    80200494:	fc043683          	ld	a3,-64(s0)
    80200498:	fc843603          	ld	a2,-56(s0)
    8020049c:	00100593          	li	a1,1
    802004a0:	44424537          	lui	a0,0x44424
    802004a4:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802004a8:	d25ff0ef          	jal	802001cc <sbi_ecall>
    802004ac:	00050713          	mv	a4,a0
    802004b0:	00058793          	mv	a5,a1
    802004b4:	fce43823          	sd	a4,-48(s0)
    802004b8:	fcf43c23          	sd	a5,-40(s0)
    802004bc:	fd043703          	ld	a4,-48(s0)
    802004c0:	fd843783          	ld	a5,-40(s0)
    802004c4:	00070913          	mv	s2,a4
    802004c8:	00078993          	mv	s3,a5
    802004cc:	00090713          	mv	a4,s2
    802004d0:	00098793          	mv	a5,s3
}
    802004d4:	00070513          	mv	a0,a4
    802004d8:	00078593          	mv	a1,a5
    802004dc:	04813083          	ld	ra,72(sp)
    802004e0:	04013403          	ld	s0,64(sp)
    802004e4:	03813903          	ld	s2,56(sp)
    802004e8:	03013983          	ld	s3,48(sp)
    802004ec:	05010113          	addi	sp,sp,80
    802004f0:	00008067          	ret

00000000802004f4 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(unsigned long num_bytes,
                                      unsigned long base_addr_lo,
                                      unsigned long base_addr_hi){
    802004f4:	fb010113          	addi	sp,sp,-80
    802004f8:	04113423          	sd	ra,72(sp)
    802004fc:	04813023          	sd	s0,64(sp)
    80200500:	03213c23          	sd	s2,56(sp)
    80200504:	03313823          	sd	s3,48(sp)
    80200508:	05010413          	addi	s0,sp,80
    8020050c:	fca43423          	sd	a0,-56(s0)
    80200510:	fcb43023          	sd	a1,-64(s0)
    80200514:	fac43c23          	sd	a2,-72(s0)
    return sbi_ecall(0x4442434e, 0, num_bytes, base_addr_lo, base_addr_hi, 0, 0, 0);
    80200518:	00000893          	li	a7,0
    8020051c:	00000813          	li	a6,0
    80200520:	00000793          	li	a5,0
    80200524:	fb843703          	ld	a4,-72(s0)
    80200528:	fc043683          	ld	a3,-64(s0)
    8020052c:	fc843603          	ld	a2,-56(s0)
    80200530:	00000593          	li	a1,0
    80200534:	44424537          	lui	a0,0x44424
    80200538:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    8020053c:	c91ff0ef          	jal	802001cc <sbi_ecall>
    80200540:	00050713          	mv	a4,a0
    80200544:	00058793          	mv	a5,a1
    80200548:	fce43823          	sd	a4,-48(s0)
    8020054c:	fcf43c23          	sd	a5,-40(s0)
    80200550:	fd043703          	ld	a4,-48(s0)
    80200554:	fd843783          	ld	a5,-40(s0)
    80200558:	00070913          	mv	s2,a4
    8020055c:	00078993          	mv	s3,a5
    80200560:	00090713          	mv	a4,s2
    80200564:	00098793          	mv	a5,s3
    80200568:	00070513          	mv	a0,a4
    8020056c:	00078593          	mv	a1,a5
    80200570:	04813083          	ld	ra,72(sp)
    80200574:	04013403          	ld	s0,64(sp)
    80200578:	03813903          	ld	s2,56(sp)
    8020057c:	03013983          	ld	s3,48(sp)
    80200580:	05010113          	addi	sp,sp,80
    80200584:	00008067          	ret

0000000080200588 <trap_handler>:
#include "stdint.h"
#include "trap.h"
#include "printk.h"
#include "clock.h"

void trap_handler(uint64_t scause, uint64_t sepc) {
    80200588:	fe010113          	addi	sp,sp,-32
    8020058c:	00113c23          	sd	ra,24(sp)
    80200590:	00813823          	sd	s0,16(sp)
    80200594:	02010413          	addi	s0,sp,32
    80200598:	fea43423          	sd	a0,-24(s0)
    8020059c:	feb43023          	sd	a1,-32(s0)
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    if((scause & SCAUSE_INTERRUPT) && (scause & 0xff) == SCAUSE_TIMER_INT){
    802005a0:	fe843783          	ld	a5,-24(s0)
    802005a4:	0207d463          	bgez	a5,802005cc <trap_handler+0x44>
    802005a8:	fe843783          	ld	a5,-24(s0)
    802005ac:	0ff7f713          	zext.b	a4,a5
    802005b0:	00500793          	li	a5,5
    802005b4:	00f71c63          	bne	a4,a5,802005cc <trap_handler+0x44>
        // Supervisor software interrupt from a S-mode timer interrupt
        // 时钟中断
        // 打印输出相关信息
        printk("[S] Supervisor Mode Timer Interrupt\n");
    802005b8:	00002517          	auipc	a0,0x2
    802005bc:	a4850513          	addi	a0,a0,-1464 # 80202000 <_srodata>
    802005c0:	7d5000ef          	jal	80201594 <printk>
        // 设置下一次时钟中断
        clock_set_next_event();
    802005c4:	bc1ff0ef          	jal	80200184 <clock_set_next_event>
    802005c8:	01c0006f          	j	802005e4 <trap_handler+0x5c>
    }else{
        // 其他 interrupt / exception
        // 打印出来供以后调试
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    802005cc:	fe043603          	ld	a2,-32(s0)
    802005d0:	fe843583          	ld	a1,-24(s0)
    802005d4:	00002517          	auipc	a0,0x2
    802005d8:	a5450513          	addi	a0,a0,-1452 # 80202028 <_srodata+0x28>
    802005dc:	7b9000ef          	jal	80201594 <printk>
    }
    802005e0:	00000013          	nop
    802005e4:	00000013          	nop
    802005e8:	01813083          	ld	ra,24(sp)
    802005ec:	01013403          	ld	s0,16(sp)
    802005f0:	02010113          	addi	sp,sp,32
    802005f4:	00008067          	ret

00000000802005f8 <start_kernel>:
#include "printk.h"
#include "defs.h"

extern void test();

int start_kernel() {
    802005f8:	ff010113          	addi	sp,sp,-16
    802005fc:	00113423          	sd	ra,8(sp)
    80200600:	00813023          	sd	s0,0(sp)
    80200604:	01010413          	addi	s0,sp,16
    printk("2024");
    80200608:	00002517          	auipc	a0,0x2
    8020060c:	a6050513          	addi	a0,a0,-1440 # 80202068 <_srodata+0x68>
    80200610:	785000ef          	jal	80201594 <printk>
    printk(" ZJU Operating System\n");
    80200614:	00002517          	auipc	a0,0x2
    80200618:	a5c50513          	addi	a0,a0,-1444 # 80202070 <_srodata+0x70>
    8020061c:	779000ef          	jal	80201594 <printk>

    // debug for csr_read
    // uint64_t x = csr_read(sie);
    // printk("sstatus = %lx\n", x);

    test();
    80200620:	038000ef          	jal	80200658 <test>
    return 0;
    80200624:	00000793          	li	a5,0
}
    80200628:	00078513          	mv	a0,a5
    8020062c:	00813083          	ld	ra,8(sp)
    80200630:	00013403          	ld	s0,0(sp)
    80200634:	01010113          	addi	sp,sp,16
    80200638:	00008067          	ret

000000008020063c <test_reset>:
#include "sbi.h"
#include "printk.h"

void test_reset() {
    8020063c:	ff010113          	addi	sp,sp,-16
    80200640:	00113423          	sd	ra,8(sp)
    80200644:	00813023          	sd	s0,0(sp)
    80200648:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    8020064c:	00000593          	li	a1,0
    80200650:	00000513          	li	a0,0
    80200654:	ce5ff0ef          	jal	80200338 <sbi_system_reset>

0000000080200658 <test>:
    __builtin_unreachable();
}

void test() {
    80200658:	fe010113          	addi	sp,sp,-32
    8020065c:	00113c23          	sd	ra,24(sp)
    80200660:	00813823          	sd	s0,16(sp)
    80200664:	02010413          	addi	s0,sp,32
    int i = 0;
    80200668:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 300000000 == 0){        // display a message every 100000000 loops
    8020066c:	fec42783          	lw	a5,-20(s0)
    80200670:	0017879b          	addiw	a5,a5,1
    80200674:	fef42623          	sw	a5,-20(s0)
    80200678:	fec42783          	lw	a5,-20(s0)
    8020067c:	0007869b          	sext.w	a3,a5
    80200680:	e510a737          	lui	a4,0xe510a
    80200684:	ec370713          	addi	a4,a4,-317 # ffffffffe5109ec3 <_ebss+0xffffffff64f04ec3>
    80200688:	02e68733          	mul	a4,a3,a4
    8020068c:	02075713          	srli	a4,a4,0x20
    80200690:	00e7873b          	addw	a4,a5,a4
    80200694:	41c7571b          	sraiw	a4,a4,0x1c
    80200698:	00070693          	mv	a3,a4
    8020069c:	41f7d71b          	sraiw	a4,a5,0x1f
    802006a0:	40e6873b          	subw	a4,a3,a4
    802006a4:	00070693          	mv	a3,a4
    802006a8:	11e1a737          	lui	a4,0x11e1a
    802006ac:	3007071b          	addiw	a4,a4,768 # 11e1a300 <_skernel-0x6e3e5d00>
    802006b0:	02e6873b          	mulw	a4,a3,a4
    802006b4:	40e787bb          	subw	a5,a5,a4
    802006b8:	0007879b          	sext.w	a5,a5
    802006bc:	fa0798e3          	bnez	a5,8020066c <test+0x14>
            printk("kernel is running!\n");
    802006c0:	00002517          	auipc	a0,0x2
    802006c4:	9c850513          	addi	a0,a0,-1592 # 80202088 <_srodata+0x88>
    802006c8:	6cd000ef          	jal	80201594 <printk>
            i = 0;
    802006cc:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 300000000 == 0){        // display a message every 100000000 loops
    802006d0:	f9dff06f          	j	8020066c <test+0x14>

00000000802006d4 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    802006d4:	fe010113          	addi	sp,sp,-32
    802006d8:	00113c23          	sd	ra,24(sp)
    802006dc:	00813823          	sd	s0,16(sp)
    802006e0:	02010413          	addi	s0,sp,32
    802006e4:	00050793          	mv	a5,a0
    802006e8:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    802006ec:	fec42783          	lw	a5,-20(s0)
    802006f0:	0ff7f793          	zext.b	a5,a5
    802006f4:	00078513          	mv	a0,a5
    802006f8:	bb1ff0ef          	jal	802002a8 <sbi_debug_console_write_byte>
    return (char)c;
    802006fc:	fec42783          	lw	a5,-20(s0)
    80200700:	0ff7f793          	zext.b	a5,a5
    80200704:	0007879b          	sext.w	a5,a5
}
    80200708:	00078513          	mv	a0,a5
    8020070c:	01813083          	ld	ra,24(sp)
    80200710:	01013403          	ld	s0,16(sp)
    80200714:	02010113          	addi	sp,sp,32
    80200718:	00008067          	ret

000000008020071c <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    8020071c:	fe010113          	addi	sp,sp,-32
    80200720:	00113c23          	sd	ra,24(sp)
    80200724:	00813823          	sd	s0,16(sp)
    80200728:	02010413          	addi	s0,sp,32
    8020072c:	00050793          	mv	a5,a0
    80200730:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    80200734:	fec42783          	lw	a5,-20(s0)
    80200738:	0007871b          	sext.w	a4,a5
    8020073c:	02000793          	li	a5,32
    80200740:	02f70263          	beq	a4,a5,80200764 <isspace+0x48>
    80200744:	fec42783          	lw	a5,-20(s0)
    80200748:	0007871b          	sext.w	a4,a5
    8020074c:	00800793          	li	a5,8
    80200750:	00e7de63          	bge	a5,a4,8020076c <isspace+0x50>
    80200754:	fec42783          	lw	a5,-20(s0)
    80200758:	0007871b          	sext.w	a4,a5
    8020075c:	00d00793          	li	a5,13
    80200760:	00e7c663          	blt	a5,a4,8020076c <isspace+0x50>
    80200764:	00100793          	li	a5,1
    80200768:	0080006f          	j	80200770 <isspace+0x54>
    8020076c:	00000793          	li	a5,0
}
    80200770:	00078513          	mv	a0,a5
    80200774:	01813083          	ld	ra,24(sp)
    80200778:	01013403          	ld	s0,16(sp)
    8020077c:	02010113          	addi	sp,sp,32
    80200780:	00008067          	ret

0000000080200784 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80200784:	fb010113          	addi	sp,sp,-80
    80200788:	04113423          	sd	ra,72(sp)
    8020078c:	04813023          	sd	s0,64(sp)
    80200790:	05010413          	addi	s0,sp,80
    80200794:	fca43423          	sd	a0,-56(s0)
    80200798:	fcb43023          	sd	a1,-64(s0)
    8020079c:	00060793          	mv	a5,a2
    802007a0:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    802007a4:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    802007a8:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    802007ac:	fc843783          	ld	a5,-56(s0)
    802007b0:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    802007b4:	0100006f          	j	802007c4 <strtol+0x40>
        p++;
    802007b8:	fd843783          	ld	a5,-40(s0)
    802007bc:	00178793          	addi	a5,a5,1
    802007c0:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    802007c4:	fd843783          	ld	a5,-40(s0)
    802007c8:	0007c783          	lbu	a5,0(a5)
    802007cc:	0007879b          	sext.w	a5,a5
    802007d0:	00078513          	mv	a0,a5
    802007d4:	f49ff0ef          	jal	8020071c <isspace>
    802007d8:	00050793          	mv	a5,a0
    802007dc:	fc079ee3          	bnez	a5,802007b8 <strtol+0x34>
    }

    if (*p == '-') {
    802007e0:	fd843783          	ld	a5,-40(s0)
    802007e4:	0007c783          	lbu	a5,0(a5)
    802007e8:	00078713          	mv	a4,a5
    802007ec:	02d00793          	li	a5,45
    802007f0:	00f71e63          	bne	a4,a5,8020080c <strtol+0x88>
        neg = true;
    802007f4:	00100793          	li	a5,1
    802007f8:	fef403a3          	sb	a5,-25(s0)
        p++;
    802007fc:	fd843783          	ld	a5,-40(s0)
    80200800:	00178793          	addi	a5,a5,1
    80200804:	fcf43c23          	sd	a5,-40(s0)
    80200808:	0240006f          	j	8020082c <strtol+0xa8>
    } else if (*p == '+') {
    8020080c:	fd843783          	ld	a5,-40(s0)
    80200810:	0007c783          	lbu	a5,0(a5)
    80200814:	00078713          	mv	a4,a5
    80200818:	02b00793          	li	a5,43
    8020081c:	00f71863          	bne	a4,a5,8020082c <strtol+0xa8>
        p++;
    80200820:	fd843783          	ld	a5,-40(s0)
    80200824:	00178793          	addi	a5,a5,1
    80200828:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    8020082c:	fbc42783          	lw	a5,-68(s0)
    80200830:	0007879b          	sext.w	a5,a5
    80200834:	06079c63          	bnez	a5,802008ac <strtol+0x128>
        if (*p == '0') {
    80200838:	fd843783          	ld	a5,-40(s0)
    8020083c:	0007c783          	lbu	a5,0(a5)
    80200840:	00078713          	mv	a4,a5
    80200844:	03000793          	li	a5,48
    80200848:	04f71e63          	bne	a4,a5,802008a4 <strtol+0x120>
            p++;
    8020084c:	fd843783          	ld	a5,-40(s0)
    80200850:	00178793          	addi	a5,a5,1
    80200854:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80200858:	fd843783          	ld	a5,-40(s0)
    8020085c:	0007c783          	lbu	a5,0(a5)
    80200860:	00078713          	mv	a4,a5
    80200864:	07800793          	li	a5,120
    80200868:	00f70c63          	beq	a4,a5,80200880 <strtol+0xfc>
    8020086c:	fd843783          	ld	a5,-40(s0)
    80200870:	0007c783          	lbu	a5,0(a5)
    80200874:	00078713          	mv	a4,a5
    80200878:	05800793          	li	a5,88
    8020087c:	00f71e63          	bne	a4,a5,80200898 <strtol+0x114>
                base = 16;
    80200880:	01000793          	li	a5,16
    80200884:	faf42e23          	sw	a5,-68(s0)
                p++;
    80200888:	fd843783          	ld	a5,-40(s0)
    8020088c:	00178793          	addi	a5,a5,1
    80200890:	fcf43c23          	sd	a5,-40(s0)
    80200894:	0180006f          	j	802008ac <strtol+0x128>
            } else {
                base = 8;
    80200898:	00800793          	li	a5,8
    8020089c:	faf42e23          	sw	a5,-68(s0)
    802008a0:	00c0006f          	j	802008ac <strtol+0x128>
            }
        } else {
            base = 10;
    802008a4:	00a00793          	li	a5,10
    802008a8:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    802008ac:	fd843783          	ld	a5,-40(s0)
    802008b0:	0007c783          	lbu	a5,0(a5)
    802008b4:	00078713          	mv	a4,a5
    802008b8:	02f00793          	li	a5,47
    802008bc:	02e7f863          	bgeu	a5,a4,802008ec <strtol+0x168>
    802008c0:	fd843783          	ld	a5,-40(s0)
    802008c4:	0007c783          	lbu	a5,0(a5)
    802008c8:	00078713          	mv	a4,a5
    802008cc:	03900793          	li	a5,57
    802008d0:	00e7ee63          	bltu	a5,a4,802008ec <strtol+0x168>
            digit = *p - '0';
    802008d4:	fd843783          	ld	a5,-40(s0)
    802008d8:	0007c783          	lbu	a5,0(a5)
    802008dc:	0007879b          	sext.w	a5,a5
    802008e0:	fd07879b          	addiw	a5,a5,-48
    802008e4:	fcf42a23          	sw	a5,-44(s0)
    802008e8:	0800006f          	j	80200968 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    802008ec:	fd843783          	ld	a5,-40(s0)
    802008f0:	0007c783          	lbu	a5,0(a5)
    802008f4:	00078713          	mv	a4,a5
    802008f8:	06000793          	li	a5,96
    802008fc:	02e7f863          	bgeu	a5,a4,8020092c <strtol+0x1a8>
    80200900:	fd843783          	ld	a5,-40(s0)
    80200904:	0007c783          	lbu	a5,0(a5)
    80200908:	00078713          	mv	a4,a5
    8020090c:	07a00793          	li	a5,122
    80200910:	00e7ee63          	bltu	a5,a4,8020092c <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80200914:	fd843783          	ld	a5,-40(s0)
    80200918:	0007c783          	lbu	a5,0(a5)
    8020091c:	0007879b          	sext.w	a5,a5
    80200920:	fa97879b          	addiw	a5,a5,-87
    80200924:	fcf42a23          	sw	a5,-44(s0)
    80200928:	0400006f          	j	80200968 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    8020092c:	fd843783          	ld	a5,-40(s0)
    80200930:	0007c783          	lbu	a5,0(a5)
    80200934:	00078713          	mv	a4,a5
    80200938:	04000793          	li	a5,64
    8020093c:	06e7f863          	bgeu	a5,a4,802009ac <strtol+0x228>
    80200940:	fd843783          	ld	a5,-40(s0)
    80200944:	0007c783          	lbu	a5,0(a5)
    80200948:	00078713          	mv	a4,a5
    8020094c:	05a00793          	li	a5,90
    80200950:	04e7ee63          	bltu	a5,a4,802009ac <strtol+0x228>
            digit = *p - ('A' - 10);
    80200954:	fd843783          	ld	a5,-40(s0)
    80200958:	0007c783          	lbu	a5,0(a5)
    8020095c:	0007879b          	sext.w	a5,a5
    80200960:	fc97879b          	addiw	a5,a5,-55
    80200964:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80200968:	fd442783          	lw	a5,-44(s0)
    8020096c:	00078713          	mv	a4,a5
    80200970:	fbc42783          	lw	a5,-68(s0)
    80200974:	0007071b          	sext.w	a4,a4
    80200978:	0007879b          	sext.w	a5,a5
    8020097c:	02f75663          	bge	a4,a5,802009a8 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80200980:	fbc42703          	lw	a4,-68(s0)
    80200984:	fe843783          	ld	a5,-24(s0)
    80200988:	02f70733          	mul	a4,a4,a5
    8020098c:	fd442783          	lw	a5,-44(s0)
    80200990:	00f707b3          	add	a5,a4,a5
    80200994:	fef43423          	sd	a5,-24(s0)
        p++;
    80200998:	fd843783          	ld	a5,-40(s0)
    8020099c:	00178793          	addi	a5,a5,1
    802009a0:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    802009a4:	f09ff06f          	j	802008ac <strtol+0x128>
            break;
    802009a8:	00000013          	nop
    }

    if (endptr) {
    802009ac:	fc043783          	ld	a5,-64(s0)
    802009b0:	00078863          	beqz	a5,802009c0 <strtol+0x23c>
        *endptr = (char *)p;
    802009b4:	fc043783          	ld	a5,-64(s0)
    802009b8:	fd843703          	ld	a4,-40(s0)
    802009bc:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    802009c0:	fe744783          	lbu	a5,-25(s0)
    802009c4:	0ff7f793          	zext.b	a5,a5
    802009c8:	00078863          	beqz	a5,802009d8 <strtol+0x254>
    802009cc:	fe843783          	ld	a5,-24(s0)
    802009d0:	40f007b3          	neg	a5,a5
    802009d4:	0080006f          	j	802009dc <strtol+0x258>
    802009d8:	fe843783          	ld	a5,-24(s0)
}
    802009dc:	00078513          	mv	a0,a5
    802009e0:	04813083          	ld	ra,72(sp)
    802009e4:	04013403          	ld	s0,64(sp)
    802009e8:	05010113          	addi	sp,sp,80
    802009ec:	00008067          	ret

00000000802009f0 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    802009f0:	fd010113          	addi	sp,sp,-48
    802009f4:	02113423          	sd	ra,40(sp)
    802009f8:	02813023          	sd	s0,32(sp)
    802009fc:	03010413          	addi	s0,sp,48
    80200a00:	fca43c23          	sd	a0,-40(s0)
    80200a04:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    80200a08:	fd043783          	ld	a5,-48(s0)
    80200a0c:	00079863          	bnez	a5,80200a1c <puts_wo_nl+0x2c>
        s = "(null)";
    80200a10:	00001797          	auipc	a5,0x1
    80200a14:	69078793          	addi	a5,a5,1680 # 802020a0 <_srodata+0xa0>
    80200a18:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    80200a1c:	fd043783          	ld	a5,-48(s0)
    80200a20:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80200a24:	0240006f          	j	80200a48 <puts_wo_nl+0x58>
        putch(*p++);
    80200a28:	fe843783          	ld	a5,-24(s0)
    80200a2c:	00178713          	addi	a4,a5,1
    80200a30:	fee43423          	sd	a4,-24(s0)
    80200a34:	0007c783          	lbu	a5,0(a5)
    80200a38:	0007871b          	sext.w	a4,a5
    80200a3c:	fd843783          	ld	a5,-40(s0)
    80200a40:	00070513          	mv	a0,a4
    80200a44:	000780e7          	jalr	a5
    while (*p) {
    80200a48:	fe843783          	ld	a5,-24(s0)
    80200a4c:	0007c783          	lbu	a5,0(a5)
    80200a50:	fc079ce3          	bnez	a5,80200a28 <puts_wo_nl+0x38>
    }
    return p - s;
    80200a54:	fe843703          	ld	a4,-24(s0)
    80200a58:	fd043783          	ld	a5,-48(s0)
    80200a5c:	40f707b3          	sub	a5,a4,a5
    80200a60:	0007879b          	sext.w	a5,a5
}
    80200a64:	00078513          	mv	a0,a5
    80200a68:	02813083          	ld	ra,40(sp)
    80200a6c:	02013403          	ld	s0,32(sp)
    80200a70:	03010113          	addi	sp,sp,48
    80200a74:	00008067          	ret

0000000080200a78 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    80200a78:	f9010113          	addi	sp,sp,-112
    80200a7c:	06113423          	sd	ra,104(sp)
    80200a80:	06813023          	sd	s0,96(sp)
    80200a84:	07010413          	addi	s0,sp,112
    80200a88:	faa43423          	sd	a0,-88(s0)
    80200a8c:	fab43023          	sd	a1,-96(s0)
    80200a90:	00060793          	mv	a5,a2
    80200a94:	f8d43823          	sd	a3,-112(s0)
    80200a98:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    80200a9c:	f9f44783          	lbu	a5,-97(s0)
    80200aa0:	0ff7f793          	zext.b	a5,a5
    80200aa4:	02078663          	beqz	a5,80200ad0 <print_dec_int+0x58>
    80200aa8:	fa043703          	ld	a4,-96(s0)
    80200aac:	fff00793          	li	a5,-1
    80200ab0:	03f79793          	slli	a5,a5,0x3f
    80200ab4:	00f71e63          	bne	a4,a5,80200ad0 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    80200ab8:	00001597          	auipc	a1,0x1
    80200abc:	5f058593          	addi	a1,a1,1520 # 802020a8 <_srodata+0xa8>
    80200ac0:	fa843503          	ld	a0,-88(s0)
    80200ac4:	f2dff0ef          	jal	802009f0 <puts_wo_nl>
    80200ac8:	00050793          	mv	a5,a0
    80200acc:	2c80006f          	j	80200d94 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    80200ad0:	f9043783          	ld	a5,-112(s0)
    80200ad4:	00c7a783          	lw	a5,12(a5)
    80200ad8:	00079a63          	bnez	a5,80200aec <print_dec_int+0x74>
    80200adc:	fa043783          	ld	a5,-96(s0)
    80200ae0:	00079663          	bnez	a5,80200aec <print_dec_int+0x74>
        return 0;
    80200ae4:	00000793          	li	a5,0
    80200ae8:	2ac0006f          	j	80200d94 <print_dec_int+0x31c>
    }

    bool neg = false;
    80200aec:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80200af0:	f9f44783          	lbu	a5,-97(s0)
    80200af4:	0ff7f793          	zext.b	a5,a5
    80200af8:	02078063          	beqz	a5,80200b18 <print_dec_int+0xa0>
    80200afc:	fa043783          	ld	a5,-96(s0)
    80200b00:	0007dc63          	bgez	a5,80200b18 <print_dec_int+0xa0>
        neg = true;
    80200b04:	00100793          	li	a5,1
    80200b08:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    80200b0c:	fa043783          	ld	a5,-96(s0)
    80200b10:	40f007b3          	neg	a5,a5
    80200b14:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    80200b18:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    80200b1c:	f9f44783          	lbu	a5,-97(s0)
    80200b20:	0ff7f793          	zext.b	a5,a5
    80200b24:	02078863          	beqz	a5,80200b54 <print_dec_int+0xdc>
    80200b28:	fef44783          	lbu	a5,-17(s0)
    80200b2c:	0ff7f793          	zext.b	a5,a5
    80200b30:	00079e63          	bnez	a5,80200b4c <print_dec_int+0xd4>
    80200b34:	f9043783          	ld	a5,-112(s0)
    80200b38:	0057c783          	lbu	a5,5(a5)
    80200b3c:	00079863          	bnez	a5,80200b4c <print_dec_int+0xd4>
    80200b40:	f9043783          	ld	a5,-112(s0)
    80200b44:	0047c783          	lbu	a5,4(a5)
    80200b48:	00078663          	beqz	a5,80200b54 <print_dec_int+0xdc>
    80200b4c:	00100793          	li	a5,1
    80200b50:	0080006f          	j	80200b58 <print_dec_int+0xe0>
    80200b54:	00000793          	li	a5,0
    80200b58:	fcf40ba3          	sb	a5,-41(s0)
    80200b5c:	fd744783          	lbu	a5,-41(s0)
    80200b60:	0017f793          	andi	a5,a5,1
    80200b64:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80200b68:	fa043683          	ld	a3,-96(s0)
    80200b6c:	00001797          	auipc	a5,0x1
    80200b70:	55478793          	addi	a5,a5,1364 # 802020c0 <_srodata+0xc0>
    80200b74:	0007b783          	ld	a5,0(a5)
    80200b78:	02f6b7b3          	mulhu	a5,a3,a5
    80200b7c:	0037d713          	srli	a4,a5,0x3
    80200b80:	00070793          	mv	a5,a4
    80200b84:	00279793          	slli	a5,a5,0x2
    80200b88:	00e787b3          	add	a5,a5,a4
    80200b8c:	00179793          	slli	a5,a5,0x1
    80200b90:	40f68733          	sub	a4,a3,a5
    80200b94:	0ff77713          	zext.b	a4,a4
    80200b98:	fe842783          	lw	a5,-24(s0)
    80200b9c:	0017869b          	addiw	a3,a5,1
    80200ba0:	fed42423          	sw	a3,-24(s0)
    80200ba4:	0307071b          	addiw	a4,a4,48
    80200ba8:	0ff77713          	zext.b	a4,a4
    80200bac:	ff078793          	addi	a5,a5,-16
    80200bb0:	008787b3          	add	a5,a5,s0
    80200bb4:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    80200bb8:	fa043703          	ld	a4,-96(s0)
    80200bbc:	00001797          	auipc	a5,0x1
    80200bc0:	50478793          	addi	a5,a5,1284 # 802020c0 <_srodata+0xc0>
    80200bc4:	0007b783          	ld	a5,0(a5)
    80200bc8:	02f737b3          	mulhu	a5,a4,a5
    80200bcc:	0037d793          	srli	a5,a5,0x3
    80200bd0:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80200bd4:	fa043783          	ld	a5,-96(s0)
    80200bd8:	f80798e3          	bnez	a5,80200b68 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    80200bdc:	f9043783          	ld	a5,-112(s0)
    80200be0:	00c7a703          	lw	a4,12(a5)
    80200be4:	fff00793          	li	a5,-1
    80200be8:	02f71063          	bne	a4,a5,80200c08 <print_dec_int+0x190>
    80200bec:	f9043783          	ld	a5,-112(s0)
    80200bf0:	0037c783          	lbu	a5,3(a5)
    80200bf4:	00078a63          	beqz	a5,80200c08 <print_dec_int+0x190>
        flags->prec = flags->width;
    80200bf8:	f9043783          	ld	a5,-112(s0)
    80200bfc:	0087a703          	lw	a4,8(a5)
    80200c00:	f9043783          	ld	a5,-112(s0)
    80200c04:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80200c08:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200c0c:	f9043783          	ld	a5,-112(s0)
    80200c10:	0087a703          	lw	a4,8(a5)
    80200c14:	fe842783          	lw	a5,-24(s0)
    80200c18:	fcf42823          	sw	a5,-48(s0)
    80200c1c:	f9043783          	ld	a5,-112(s0)
    80200c20:	00c7a783          	lw	a5,12(a5)
    80200c24:	fcf42623          	sw	a5,-52(s0)
    80200c28:	fd042783          	lw	a5,-48(s0)
    80200c2c:	00078593          	mv	a1,a5
    80200c30:	fcc42783          	lw	a5,-52(s0)
    80200c34:	00078613          	mv	a2,a5
    80200c38:	0006069b          	sext.w	a3,a2
    80200c3c:	0005879b          	sext.w	a5,a1
    80200c40:	00f6d463          	bge	a3,a5,80200c48 <print_dec_int+0x1d0>
    80200c44:	00058613          	mv	a2,a1
    80200c48:	0006079b          	sext.w	a5,a2
    80200c4c:	40f707bb          	subw	a5,a4,a5
    80200c50:	0007871b          	sext.w	a4,a5
    80200c54:	fd744783          	lbu	a5,-41(s0)
    80200c58:	0007879b          	sext.w	a5,a5
    80200c5c:	40f707bb          	subw	a5,a4,a5
    80200c60:	fef42023          	sw	a5,-32(s0)
    80200c64:	0280006f          	j	80200c8c <print_dec_int+0x214>
        putch(' ');
    80200c68:	fa843783          	ld	a5,-88(s0)
    80200c6c:	02000513          	li	a0,32
    80200c70:	000780e7          	jalr	a5
        ++written;
    80200c74:	fe442783          	lw	a5,-28(s0)
    80200c78:	0017879b          	addiw	a5,a5,1
    80200c7c:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200c80:	fe042783          	lw	a5,-32(s0)
    80200c84:	fff7879b          	addiw	a5,a5,-1
    80200c88:	fef42023          	sw	a5,-32(s0)
    80200c8c:	fe042783          	lw	a5,-32(s0)
    80200c90:	0007879b          	sext.w	a5,a5
    80200c94:	fcf04ae3          	bgtz	a5,80200c68 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    80200c98:	fd744783          	lbu	a5,-41(s0)
    80200c9c:	0ff7f793          	zext.b	a5,a5
    80200ca0:	04078463          	beqz	a5,80200ce8 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    80200ca4:	fef44783          	lbu	a5,-17(s0)
    80200ca8:	0ff7f793          	zext.b	a5,a5
    80200cac:	00078663          	beqz	a5,80200cb8 <print_dec_int+0x240>
    80200cb0:	02d00793          	li	a5,45
    80200cb4:	01c0006f          	j	80200cd0 <print_dec_int+0x258>
    80200cb8:	f9043783          	ld	a5,-112(s0)
    80200cbc:	0057c783          	lbu	a5,5(a5)
    80200cc0:	00078663          	beqz	a5,80200ccc <print_dec_int+0x254>
    80200cc4:	02b00793          	li	a5,43
    80200cc8:	0080006f          	j	80200cd0 <print_dec_int+0x258>
    80200ccc:	02000793          	li	a5,32
    80200cd0:	fa843703          	ld	a4,-88(s0)
    80200cd4:	00078513          	mv	a0,a5
    80200cd8:	000700e7          	jalr	a4
        ++written;
    80200cdc:	fe442783          	lw	a5,-28(s0)
    80200ce0:	0017879b          	addiw	a5,a5,1
    80200ce4:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200ce8:	fe842783          	lw	a5,-24(s0)
    80200cec:	fcf42e23          	sw	a5,-36(s0)
    80200cf0:	0280006f          	j	80200d18 <print_dec_int+0x2a0>
        putch('0');
    80200cf4:	fa843783          	ld	a5,-88(s0)
    80200cf8:	03000513          	li	a0,48
    80200cfc:	000780e7          	jalr	a5
        ++written;
    80200d00:	fe442783          	lw	a5,-28(s0)
    80200d04:	0017879b          	addiw	a5,a5,1
    80200d08:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200d0c:	fdc42783          	lw	a5,-36(s0)
    80200d10:	0017879b          	addiw	a5,a5,1
    80200d14:	fcf42e23          	sw	a5,-36(s0)
    80200d18:	f9043783          	ld	a5,-112(s0)
    80200d1c:	00c7a703          	lw	a4,12(a5)
    80200d20:	fd744783          	lbu	a5,-41(s0)
    80200d24:	0007879b          	sext.w	a5,a5
    80200d28:	40f707bb          	subw	a5,a4,a5
    80200d2c:	0007879b          	sext.w	a5,a5
    80200d30:	fdc42703          	lw	a4,-36(s0)
    80200d34:	0007071b          	sext.w	a4,a4
    80200d38:	faf74ee3          	blt	a4,a5,80200cf4 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80200d3c:	fe842783          	lw	a5,-24(s0)
    80200d40:	fff7879b          	addiw	a5,a5,-1
    80200d44:	fcf42c23          	sw	a5,-40(s0)
    80200d48:	03c0006f          	j	80200d84 <print_dec_int+0x30c>
        putch(buf[i]);
    80200d4c:	fd842783          	lw	a5,-40(s0)
    80200d50:	ff078793          	addi	a5,a5,-16
    80200d54:	008787b3          	add	a5,a5,s0
    80200d58:	fc87c783          	lbu	a5,-56(a5)
    80200d5c:	0007871b          	sext.w	a4,a5
    80200d60:	fa843783          	ld	a5,-88(s0)
    80200d64:	00070513          	mv	a0,a4
    80200d68:	000780e7          	jalr	a5
        ++written;
    80200d6c:	fe442783          	lw	a5,-28(s0)
    80200d70:	0017879b          	addiw	a5,a5,1
    80200d74:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    80200d78:	fd842783          	lw	a5,-40(s0)
    80200d7c:	fff7879b          	addiw	a5,a5,-1
    80200d80:	fcf42c23          	sw	a5,-40(s0)
    80200d84:	fd842783          	lw	a5,-40(s0)
    80200d88:	0007879b          	sext.w	a5,a5
    80200d8c:	fc07d0e3          	bgez	a5,80200d4c <print_dec_int+0x2d4>
    }

    return written;
    80200d90:	fe442783          	lw	a5,-28(s0)
}
    80200d94:	00078513          	mv	a0,a5
    80200d98:	06813083          	ld	ra,104(sp)
    80200d9c:	06013403          	ld	s0,96(sp)
    80200da0:	07010113          	addi	sp,sp,112
    80200da4:	00008067          	ret

0000000080200da8 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    80200da8:	f4010113          	addi	sp,sp,-192
    80200dac:	0a113c23          	sd	ra,184(sp)
    80200db0:	0a813823          	sd	s0,176(sp)
    80200db4:	0c010413          	addi	s0,sp,192
    80200db8:	f4a43c23          	sd	a0,-168(s0)
    80200dbc:	f4b43823          	sd	a1,-176(s0)
    80200dc0:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    80200dc4:	f8043023          	sd	zero,-128(s0)
    80200dc8:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80200dcc:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80200dd0:	7a00006f          	j	80201570 <vprintfmt+0x7c8>
        if (flags.in_format) {
    80200dd4:	f8044783          	lbu	a5,-128(s0)
    80200dd8:	72078c63          	beqz	a5,80201510 <vprintfmt+0x768>
            if (*fmt == '#') {
    80200ddc:	f5043783          	ld	a5,-176(s0)
    80200de0:	0007c783          	lbu	a5,0(a5)
    80200de4:	00078713          	mv	a4,a5
    80200de8:	02300793          	li	a5,35
    80200dec:	00f71863          	bne	a4,a5,80200dfc <vprintfmt+0x54>
                flags.sharpflag = true;
    80200df0:	00100793          	li	a5,1
    80200df4:	f8f40123          	sb	a5,-126(s0)
    80200df8:	76c0006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    80200dfc:	f5043783          	ld	a5,-176(s0)
    80200e00:	0007c783          	lbu	a5,0(a5)
    80200e04:	00078713          	mv	a4,a5
    80200e08:	03000793          	li	a5,48
    80200e0c:	00f71863          	bne	a4,a5,80200e1c <vprintfmt+0x74>
                flags.zeroflag = true;
    80200e10:	00100793          	li	a5,1
    80200e14:	f8f401a3          	sb	a5,-125(s0)
    80200e18:	74c0006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    80200e1c:	f5043783          	ld	a5,-176(s0)
    80200e20:	0007c783          	lbu	a5,0(a5)
    80200e24:	00078713          	mv	a4,a5
    80200e28:	06c00793          	li	a5,108
    80200e2c:	04f70063          	beq	a4,a5,80200e6c <vprintfmt+0xc4>
    80200e30:	f5043783          	ld	a5,-176(s0)
    80200e34:	0007c783          	lbu	a5,0(a5)
    80200e38:	00078713          	mv	a4,a5
    80200e3c:	07a00793          	li	a5,122
    80200e40:	02f70663          	beq	a4,a5,80200e6c <vprintfmt+0xc4>
    80200e44:	f5043783          	ld	a5,-176(s0)
    80200e48:	0007c783          	lbu	a5,0(a5)
    80200e4c:	00078713          	mv	a4,a5
    80200e50:	07400793          	li	a5,116
    80200e54:	00f70c63          	beq	a4,a5,80200e6c <vprintfmt+0xc4>
    80200e58:	f5043783          	ld	a5,-176(s0)
    80200e5c:	0007c783          	lbu	a5,0(a5)
    80200e60:	00078713          	mv	a4,a5
    80200e64:	06a00793          	li	a5,106
    80200e68:	00f71863          	bne	a4,a5,80200e78 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80200e6c:	00100793          	li	a5,1
    80200e70:	f8f400a3          	sb	a5,-127(s0)
    80200e74:	6f00006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    80200e78:	f5043783          	ld	a5,-176(s0)
    80200e7c:	0007c783          	lbu	a5,0(a5)
    80200e80:	00078713          	mv	a4,a5
    80200e84:	02b00793          	li	a5,43
    80200e88:	00f71863          	bne	a4,a5,80200e98 <vprintfmt+0xf0>
                flags.sign = true;
    80200e8c:	00100793          	li	a5,1
    80200e90:	f8f402a3          	sb	a5,-123(s0)
    80200e94:	6d00006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    80200e98:	f5043783          	ld	a5,-176(s0)
    80200e9c:	0007c783          	lbu	a5,0(a5)
    80200ea0:	00078713          	mv	a4,a5
    80200ea4:	02000793          	li	a5,32
    80200ea8:	00f71863          	bne	a4,a5,80200eb8 <vprintfmt+0x110>
                flags.spaceflag = true;
    80200eac:	00100793          	li	a5,1
    80200eb0:	f8f40223          	sb	a5,-124(s0)
    80200eb4:	6b00006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    80200eb8:	f5043783          	ld	a5,-176(s0)
    80200ebc:	0007c783          	lbu	a5,0(a5)
    80200ec0:	00078713          	mv	a4,a5
    80200ec4:	02a00793          	li	a5,42
    80200ec8:	00f71e63          	bne	a4,a5,80200ee4 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80200ecc:	f4843783          	ld	a5,-184(s0)
    80200ed0:	00878713          	addi	a4,a5,8
    80200ed4:	f4e43423          	sd	a4,-184(s0)
    80200ed8:	0007a783          	lw	a5,0(a5)
    80200edc:	f8f42423          	sw	a5,-120(s0)
    80200ee0:	6840006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    80200ee4:	f5043783          	ld	a5,-176(s0)
    80200ee8:	0007c783          	lbu	a5,0(a5)
    80200eec:	00078713          	mv	a4,a5
    80200ef0:	03000793          	li	a5,48
    80200ef4:	04e7f663          	bgeu	a5,a4,80200f40 <vprintfmt+0x198>
    80200ef8:	f5043783          	ld	a5,-176(s0)
    80200efc:	0007c783          	lbu	a5,0(a5)
    80200f00:	00078713          	mv	a4,a5
    80200f04:	03900793          	li	a5,57
    80200f08:	02e7ec63          	bltu	a5,a4,80200f40 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    80200f0c:	f5043783          	ld	a5,-176(s0)
    80200f10:	f5040713          	addi	a4,s0,-176
    80200f14:	00a00613          	li	a2,10
    80200f18:	00070593          	mv	a1,a4
    80200f1c:	00078513          	mv	a0,a5
    80200f20:	865ff0ef          	jal	80200784 <strtol>
    80200f24:	00050793          	mv	a5,a0
    80200f28:	0007879b          	sext.w	a5,a5
    80200f2c:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    80200f30:	f5043783          	ld	a5,-176(s0)
    80200f34:	fff78793          	addi	a5,a5,-1
    80200f38:	f4f43823          	sd	a5,-176(s0)
    80200f3c:	6280006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    80200f40:	f5043783          	ld	a5,-176(s0)
    80200f44:	0007c783          	lbu	a5,0(a5)
    80200f48:	00078713          	mv	a4,a5
    80200f4c:	02e00793          	li	a5,46
    80200f50:	06f71863          	bne	a4,a5,80200fc0 <vprintfmt+0x218>
                fmt++;
    80200f54:	f5043783          	ld	a5,-176(s0)
    80200f58:	00178793          	addi	a5,a5,1
    80200f5c:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80200f60:	f5043783          	ld	a5,-176(s0)
    80200f64:	0007c783          	lbu	a5,0(a5)
    80200f68:	00078713          	mv	a4,a5
    80200f6c:	02a00793          	li	a5,42
    80200f70:	00f71e63          	bne	a4,a5,80200f8c <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    80200f74:	f4843783          	ld	a5,-184(s0)
    80200f78:	00878713          	addi	a4,a5,8
    80200f7c:	f4e43423          	sd	a4,-184(s0)
    80200f80:	0007a783          	lw	a5,0(a5)
    80200f84:	f8f42623          	sw	a5,-116(s0)
    80200f88:	5dc0006f          	j	80201564 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80200f8c:	f5043783          	ld	a5,-176(s0)
    80200f90:	f5040713          	addi	a4,s0,-176
    80200f94:	00a00613          	li	a2,10
    80200f98:	00070593          	mv	a1,a4
    80200f9c:	00078513          	mv	a0,a5
    80200fa0:	fe4ff0ef          	jal	80200784 <strtol>
    80200fa4:	00050793          	mv	a5,a0
    80200fa8:	0007879b          	sext.w	a5,a5
    80200fac:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80200fb0:	f5043783          	ld	a5,-176(s0)
    80200fb4:	fff78793          	addi	a5,a5,-1
    80200fb8:	f4f43823          	sd	a5,-176(s0)
    80200fbc:	5a80006f          	j	80201564 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80200fc0:	f5043783          	ld	a5,-176(s0)
    80200fc4:	0007c783          	lbu	a5,0(a5)
    80200fc8:	00078713          	mv	a4,a5
    80200fcc:	07800793          	li	a5,120
    80200fd0:	02f70663          	beq	a4,a5,80200ffc <vprintfmt+0x254>
    80200fd4:	f5043783          	ld	a5,-176(s0)
    80200fd8:	0007c783          	lbu	a5,0(a5)
    80200fdc:	00078713          	mv	a4,a5
    80200fe0:	05800793          	li	a5,88
    80200fe4:	00f70c63          	beq	a4,a5,80200ffc <vprintfmt+0x254>
    80200fe8:	f5043783          	ld	a5,-176(s0)
    80200fec:	0007c783          	lbu	a5,0(a5)
    80200ff0:	00078713          	mv	a4,a5
    80200ff4:	07000793          	li	a5,112
    80200ff8:	30f71063          	bne	a4,a5,802012f8 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    80200ffc:	f5043783          	ld	a5,-176(s0)
    80201000:	0007c783          	lbu	a5,0(a5)
    80201004:	00078713          	mv	a4,a5
    80201008:	07000793          	li	a5,112
    8020100c:	00f70663          	beq	a4,a5,80201018 <vprintfmt+0x270>
    80201010:	f8144783          	lbu	a5,-127(s0)
    80201014:	00078663          	beqz	a5,80201020 <vprintfmt+0x278>
    80201018:	00100793          	li	a5,1
    8020101c:	0080006f          	j	80201024 <vprintfmt+0x27c>
    80201020:	00000793          	li	a5,0
    80201024:	faf403a3          	sb	a5,-89(s0)
    80201028:	fa744783          	lbu	a5,-89(s0)
    8020102c:	0017f793          	andi	a5,a5,1
    80201030:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    80201034:	fa744783          	lbu	a5,-89(s0)
    80201038:	0ff7f793          	zext.b	a5,a5
    8020103c:	00078c63          	beqz	a5,80201054 <vprintfmt+0x2ac>
    80201040:	f4843783          	ld	a5,-184(s0)
    80201044:	00878713          	addi	a4,a5,8
    80201048:	f4e43423          	sd	a4,-184(s0)
    8020104c:	0007b783          	ld	a5,0(a5)
    80201050:	01c0006f          	j	8020106c <vprintfmt+0x2c4>
    80201054:	f4843783          	ld	a5,-184(s0)
    80201058:	00878713          	addi	a4,a5,8
    8020105c:	f4e43423          	sd	a4,-184(s0)
    80201060:	0007a783          	lw	a5,0(a5)
    80201064:	02079793          	slli	a5,a5,0x20
    80201068:	0207d793          	srli	a5,a5,0x20
    8020106c:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80201070:	f8c42783          	lw	a5,-116(s0)
    80201074:	02079463          	bnez	a5,8020109c <vprintfmt+0x2f4>
    80201078:	fe043783          	ld	a5,-32(s0)
    8020107c:	02079063          	bnez	a5,8020109c <vprintfmt+0x2f4>
    80201080:	f5043783          	ld	a5,-176(s0)
    80201084:	0007c783          	lbu	a5,0(a5)
    80201088:	00078713          	mv	a4,a5
    8020108c:	07000793          	li	a5,112
    80201090:	00f70663          	beq	a4,a5,8020109c <vprintfmt+0x2f4>
                    flags.in_format = false;
    80201094:	f8040023          	sb	zero,-128(s0)
    80201098:	4cc0006f          	j	80201564 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    8020109c:	f5043783          	ld	a5,-176(s0)
    802010a0:	0007c783          	lbu	a5,0(a5)
    802010a4:	00078713          	mv	a4,a5
    802010a8:	07000793          	li	a5,112
    802010ac:	00f70a63          	beq	a4,a5,802010c0 <vprintfmt+0x318>
    802010b0:	f8244783          	lbu	a5,-126(s0)
    802010b4:	00078a63          	beqz	a5,802010c8 <vprintfmt+0x320>
    802010b8:	fe043783          	ld	a5,-32(s0)
    802010bc:	00078663          	beqz	a5,802010c8 <vprintfmt+0x320>
    802010c0:	00100793          	li	a5,1
    802010c4:	0080006f          	j	802010cc <vprintfmt+0x324>
    802010c8:	00000793          	li	a5,0
    802010cc:	faf40323          	sb	a5,-90(s0)
    802010d0:	fa644783          	lbu	a5,-90(s0)
    802010d4:	0017f793          	andi	a5,a5,1
    802010d8:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    802010dc:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    802010e0:	f5043783          	ld	a5,-176(s0)
    802010e4:	0007c783          	lbu	a5,0(a5)
    802010e8:	00078713          	mv	a4,a5
    802010ec:	05800793          	li	a5,88
    802010f0:	00f71863          	bne	a4,a5,80201100 <vprintfmt+0x358>
    802010f4:	00001797          	auipc	a5,0x1
    802010f8:	fd478793          	addi	a5,a5,-44 # 802020c8 <upperxdigits.1>
    802010fc:	00c0006f          	j	80201108 <vprintfmt+0x360>
    80201100:	00001797          	auipc	a5,0x1
    80201104:	fe078793          	addi	a5,a5,-32 # 802020e0 <lowerxdigits.0>
    80201108:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    8020110c:	fe043783          	ld	a5,-32(s0)
    80201110:	00f7f793          	andi	a5,a5,15
    80201114:	f9843703          	ld	a4,-104(s0)
    80201118:	00f70733          	add	a4,a4,a5
    8020111c:	fdc42783          	lw	a5,-36(s0)
    80201120:	0017869b          	addiw	a3,a5,1
    80201124:	fcd42e23          	sw	a3,-36(s0)
    80201128:	00074703          	lbu	a4,0(a4)
    8020112c:	ff078793          	addi	a5,a5,-16
    80201130:	008787b3          	add	a5,a5,s0
    80201134:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    80201138:	fe043783          	ld	a5,-32(s0)
    8020113c:	0047d793          	srli	a5,a5,0x4
    80201140:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80201144:	fe043783          	ld	a5,-32(s0)
    80201148:	fc0792e3          	bnez	a5,8020110c <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    8020114c:	f8c42703          	lw	a4,-116(s0)
    80201150:	fff00793          	li	a5,-1
    80201154:	02f71663          	bne	a4,a5,80201180 <vprintfmt+0x3d8>
    80201158:	f8344783          	lbu	a5,-125(s0)
    8020115c:	02078263          	beqz	a5,80201180 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80201160:	f8842703          	lw	a4,-120(s0)
    80201164:	fa644783          	lbu	a5,-90(s0)
    80201168:	0007879b          	sext.w	a5,a5
    8020116c:	0017979b          	slliw	a5,a5,0x1
    80201170:	0007879b          	sext.w	a5,a5
    80201174:	40f707bb          	subw	a5,a4,a5
    80201178:	0007879b          	sext.w	a5,a5
    8020117c:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80201180:	f8842703          	lw	a4,-120(s0)
    80201184:	fa644783          	lbu	a5,-90(s0)
    80201188:	0007879b          	sext.w	a5,a5
    8020118c:	0017979b          	slliw	a5,a5,0x1
    80201190:	0007879b          	sext.w	a5,a5
    80201194:	40f707bb          	subw	a5,a4,a5
    80201198:	0007871b          	sext.w	a4,a5
    8020119c:	fdc42783          	lw	a5,-36(s0)
    802011a0:	f8f42a23          	sw	a5,-108(s0)
    802011a4:	f8c42783          	lw	a5,-116(s0)
    802011a8:	f8f42823          	sw	a5,-112(s0)
    802011ac:	f9442783          	lw	a5,-108(s0)
    802011b0:	00078593          	mv	a1,a5
    802011b4:	f9042783          	lw	a5,-112(s0)
    802011b8:	00078613          	mv	a2,a5
    802011bc:	0006069b          	sext.w	a3,a2
    802011c0:	0005879b          	sext.w	a5,a1
    802011c4:	00f6d463          	bge	a3,a5,802011cc <vprintfmt+0x424>
    802011c8:	00058613          	mv	a2,a1
    802011cc:	0006079b          	sext.w	a5,a2
    802011d0:	40f707bb          	subw	a5,a4,a5
    802011d4:	fcf42c23          	sw	a5,-40(s0)
    802011d8:	0280006f          	j	80201200 <vprintfmt+0x458>
                    putch(' ');
    802011dc:	f5843783          	ld	a5,-168(s0)
    802011e0:	02000513          	li	a0,32
    802011e4:	000780e7          	jalr	a5
                    ++written;
    802011e8:	fec42783          	lw	a5,-20(s0)
    802011ec:	0017879b          	addiw	a5,a5,1
    802011f0:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    802011f4:	fd842783          	lw	a5,-40(s0)
    802011f8:	fff7879b          	addiw	a5,a5,-1
    802011fc:	fcf42c23          	sw	a5,-40(s0)
    80201200:	fd842783          	lw	a5,-40(s0)
    80201204:	0007879b          	sext.w	a5,a5
    80201208:	fcf04ae3          	bgtz	a5,802011dc <vprintfmt+0x434>
                }

                if (prefix) {
    8020120c:	fa644783          	lbu	a5,-90(s0)
    80201210:	0ff7f793          	zext.b	a5,a5
    80201214:	04078463          	beqz	a5,8020125c <vprintfmt+0x4b4>
                    putch('0');
    80201218:	f5843783          	ld	a5,-168(s0)
    8020121c:	03000513          	li	a0,48
    80201220:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    80201224:	f5043783          	ld	a5,-176(s0)
    80201228:	0007c783          	lbu	a5,0(a5)
    8020122c:	00078713          	mv	a4,a5
    80201230:	05800793          	li	a5,88
    80201234:	00f71663          	bne	a4,a5,80201240 <vprintfmt+0x498>
    80201238:	05800793          	li	a5,88
    8020123c:	0080006f          	j	80201244 <vprintfmt+0x49c>
    80201240:	07800793          	li	a5,120
    80201244:	f5843703          	ld	a4,-168(s0)
    80201248:	00078513          	mv	a0,a5
    8020124c:	000700e7          	jalr	a4
                    written += 2;
    80201250:	fec42783          	lw	a5,-20(s0)
    80201254:	0027879b          	addiw	a5,a5,2
    80201258:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    8020125c:	fdc42783          	lw	a5,-36(s0)
    80201260:	fcf42a23          	sw	a5,-44(s0)
    80201264:	0280006f          	j	8020128c <vprintfmt+0x4e4>
                    putch('0');
    80201268:	f5843783          	ld	a5,-168(s0)
    8020126c:	03000513          	li	a0,48
    80201270:	000780e7          	jalr	a5
                    ++written;
    80201274:	fec42783          	lw	a5,-20(s0)
    80201278:	0017879b          	addiw	a5,a5,1
    8020127c:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80201280:	fd442783          	lw	a5,-44(s0)
    80201284:	0017879b          	addiw	a5,a5,1
    80201288:	fcf42a23          	sw	a5,-44(s0)
    8020128c:	f8c42783          	lw	a5,-116(s0)
    80201290:	fd442703          	lw	a4,-44(s0)
    80201294:	0007071b          	sext.w	a4,a4
    80201298:	fcf748e3          	blt	a4,a5,80201268 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    8020129c:	fdc42783          	lw	a5,-36(s0)
    802012a0:	fff7879b          	addiw	a5,a5,-1
    802012a4:	fcf42823          	sw	a5,-48(s0)
    802012a8:	03c0006f          	j	802012e4 <vprintfmt+0x53c>
                    putch(buf[i]);
    802012ac:	fd042783          	lw	a5,-48(s0)
    802012b0:	ff078793          	addi	a5,a5,-16
    802012b4:	008787b3          	add	a5,a5,s0
    802012b8:	f807c783          	lbu	a5,-128(a5)
    802012bc:	0007871b          	sext.w	a4,a5
    802012c0:	f5843783          	ld	a5,-168(s0)
    802012c4:	00070513          	mv	a0,a4
    802012c8:	000780e7          	jalr	a5
                    ++written;
    802012cc:	fec42783          	lw	a5,-20(s0)
    802012d0:	0017879b          	addiw	a5,a5,1
    802012d4:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    802012d8:	fd042783          	lw	a5,-48(s0)
    802012dc:	fff7879b          	addiw	a5,a5,-1
    802012e0:	fcf42823          	sw	a5,-48(s0)
    802012e4:	fd042783          	lw	a5,-48(s0)
    802012e8:	0007879b          	sext.w	a5,a5
    802012ec:	fc07d0e3          	bgez	a5,802012ac <vprintfmt+0x504>
                }

                flags.in_format = false;
    802012f0:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802012f4:	2700006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802012f8:	f5043783          	ld	a5,-176(s0)
    802012fc:	0007c783          	lbu	a5,0(a5)
    80201300:	00078713          	mv	a4,a5
    80201304:	06400793          	li	a5,100
    80201308:	02f70663          	beq	a4,a5,80201334 <vprintfmt+0x58c>
    8020130c:	f5043783          	ld	a5,-176(s0)
    80201310:	0007c783          	lbu	a5,0(a5)
    80201314:	00078713          	mv	a4,a5
    80201318:	06900793          	li	a5,105
    8020131c:	00f70c63          	beq	a4,a5,80201334 <vprintfmt+0x58c>
    80201320:	f5043783          	ld	a5,-176(s0)
    80201324:	0007c783          	lbu	a5,0(a5)
    80201328:	00078713          	mv	a4,a5
    8020132c:	07500793          	li	a5,117
    80201330:	08f71063          	bne	a4,a5,802013b0 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    80201334:	f8144783          	lbu	a5,-127(s0)
    80201338:	00078c63          	beqz	a5,80201350 <vprintfmt+0x5a8>
    8020133c:	f4843783          	ld	a5,-184(s0)
    80201340:	00878713          	addi	a4,a5,8
    80201344:	f4e43423          	sd	a4,-184(s0)
    80201348:	0007b783          	ld	a5,0(a5)
    8020134c:	0140006f          	j	80201360 <vprintfmt+0x5b8>
    80201350:	f4843783          	ld	a5,-184(s0)
    80201354:	00878713          	addi	a4,a5,8
    80201358:	f4e43423          	sd	a4,-184(s0)
    8020135c:	0007a783          	lw	a5,0(a5)
    80201360:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201364:	fa843583          	ld	a1,-88(s0)
    80201368:	f5043783          	ld	a5,-176(s0)
    8020136c:	0007c783          	lbu	a5,0(a5)
    80201370:	0007871b          	sext.w	a4,a5
    80201374:	07500793          	li	a5,117
    80201378:	40f707b3          	sub	a5,a4,a5
    8020137c:	00f037b3          	snez	a5,a5
    80201380:	0ff7f793          	zext.b	a5,a5
    80201384:	f8040713          	addi	a4,s0,-128
    80201388:	00070693          	mv	a3,a4
    8020138c:	00078613          	mv	a2,a5
    80201390:	f5843503          	ld	a0,-168(s0)
    80201394:	ee4ff0ef          	jal	80200a78 <print_dec_int>
    80201398:	00050793          	mv	a5,a0
    8020139c:	fec42703          	lw	a4,-20(s0)
    802013a0:	00f707bb          	addw	a5,a4,a5
    802013a4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802013a8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802013ac:	1b80006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    802013b0:	f5043783          	ld	a5,-176(s0)
    802013b4:	0007c783          	lbu	a5,0(a5)
    802013b8:	00078713          	mv	a4,a5
    802013bc:	06e00793          	li	a5,110
    802013c0:	04f71c63          	bne	a4,a5,80201418 <vprintfmt+0x670>
                if (flags.longflag) {
    802013c4:	f8144783          	lbu	a5,-127(s0)
    802013c8:	02078463          	beqz	a5,802013f0 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    802013cc:	f4843783          	ld	a5,-184(s0)
    802013d0:	00878713          	addi	a4,a5,8
    802013d4:	f4e43423          	sd	a4,-184(s0)
    802013d8:	0007b783          	ld	a5,0(a5)
    802013dc:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    802013e0:	fec42703          	lw	a4,-20(s0)
    802013e4:	fb043783          	ld	a5,-80(s0)
    802013e8:	00e7b023          	sd	a4,0(a5)
    802013ec:	0240006f          	j	80201410 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    802013f0:	f4843783          	ld	a5,-184(s0)
    802013f4:	00878713          	addi	a4,a5,8
    802013f8:	f4e43423          	sd	a4,-184(s0)
    802013fc:	0007b783          	ld	a5,0(a5)
    80201400:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    80201404:	fb843783          	ld	a5,-72(s0)
    80201408:	fec42703          	lw	a4,-20(s0)
    8020140c:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    80201410:	f8040023          	sb	zero,-128(s0)
    80201414:	1500006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    80201418:	f5043783          	ld	a5,-176(s0)
    8020141c:	0007c783          	lbu	a5,0(a5)
    80201420:	00078713          	mv	a4,a5
    80201424:	07300793          	li	a5,115
    80201428:	02f71e63          	bne	a4,a5,80201464 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    8020142c:	f4843783          	ld	a5,-184(s0)
    80201430:	00878713          	addi	a4,a5,8
    80201434:	f4e43423          	sd	a4,-184(s0)
    80201438:	0007b783          	ld	a5,0(a5)
    8020143c:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    80201440:	fc043583          	ld	a1,-64(s0)
    80201444:	f5843503          	ld	a0,-168(s0)
    80201448:	da8ff0ef          	jal	802009f0 <puts_wo_nl>
    8020144c:	00050793          	mv	a5,a0
    80201450:	fec42703          	lw	a4,-20(s0)
    80201454:	00f707bb          	addw	a5,a4,a5
    80201458:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    8020145c:	f8040023          	sb	zero,-128(s0)
    80201460:	1040006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    80201464:	f5043783          	ld	a5,-176(s0)
    80201468:	0007c783          	lbu	a5,0(a5)
    8020146c:	00078713          	mv	a4,a5
    80201470:	06300793          	li	a5,99
    80201474:	02f71e63          	bne	a4,a5,802014b0 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    80201478:	f4843783          	ld	a5,-184(s0)
    8020147c:	00878713          	addi	a4,a5,8
    80201480:	f4e43423          	sd	a4,-184(s0)
    80201484:	0007a783          	lw	a5,0(a5)
    80201488:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    8020148c:	fcc42703          	lw	a4,-52(s0)
    80201490:	f5843783          	ld	a5,-168(s0)
    80201494:	00070513          	mv	a0,a4
    80201498:	000780e7          	jalr	a5
                ++written;
    8020149c:	fec42783          	lw	a5,-20(s0)
    802014a0:	0017879b          	addiw	a5,a5,1
    802014a4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802014a8:	f8040023          	sb	zero,-128(s0)
    802014ac:	0b80006f          	j	80201564 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    802014b0:	f5043783          	ld	a5,-176(s0)
    802014b4:	0007c783          	lbu	a5,0(a5)
    802014b8:	00078713          	mv	a4,a5
    802014bc:	02500793          	li	a5,37
    802014c0:	02f71263          	bne	a4,a5,802014e4 <vprintfmt+0x73c>
                putch('%');
    802014c4:	f5843783          	ld	a5,-168(s0)
    802014c8:	02500513          	li	a0,37
    802014cc:	000780e7          	jalr	a5
                ++written;
    802014d0:	fec42783          	lw	a5,-20(s0)
    802014d4:	0017879b          	addiw	a5,a5,1
    802014d8:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802014dc:	f8040023          	sb	zero,-128(s0)
    802014e0:	0840006f          	j	80201564 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    802014e4:	f5043783          	ld	a5,-176(s0)
    802014e8:	0007c783          	lbu	a5,0(a5)
    802014ec:	0007871b          	sext.w	a4,a5
    802014f0:	f5843783          	ld	a5,-168(s0)
    802014f4:	00070513          	mv	a0,a4
    802014f8:	000780e7          	jalr	a5
                ++written;
    802014fc:	fec42783          	lw	a5,-20(s0)
    80201500:	0017879b          	addiw	a5,a5,1
    80201504:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201508:	f8040023          	sb	zero,-128(s0)
    8020150c:	0580006f          	j	80201564 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    80201510:	f5043783          	ld	a5,-176(s0)
    80201514:	0007c783          	lbu	a5,0(a5)
    80201518:	00078713          	mv	a4,a5
    8020151c:	02500793          	li	a5,37
    80201520:	02f71063          	bne	a4,a5,80201540 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    80201524:	f8043023          	sd	zero,-128(s0)
    80201528:	f8043423          	sd	zero,-120(s0)
    8020152c:	00100793          	li	a5,1
    80201530:	f8f40023          	sb	a5,-128(s0)
    80201534:	fff00793          	li	a5,-1
    80201538:	f8f42623          	sw	a5,-116(s0)
    8020153c:	0280006f          	j	80201564 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    80201540:	f5043783          	ld	a5,-176(s0)
    80201544:	0007c783          	lbu	a5,0(a5)
    80201548:	0007871b          	sext.w	a4,a5
    8020154c:	f5843783          	ld	a5,-168(s0)
    80201550:	00070513          	mv	a0,a4
    80201554:	000780e7          	jalr	a5
            ++written;
    80201558:	fec42783          	lw	a5,-20(s0)
    8020155c:	0017879b          	addiw	a5,a5,1
    80201560:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201564:	f5043783          	ld	a5,-176(s0)
    80201568:	00178793          	addi	a5,a5,1
    8020156c:	f4f43823          	sd	a5,-176(s0)
    80201570:	f5043783          	ld	a5,-176(s0)
    80201574:	0007c783          	lbu	a5,0(a5)
    80201578:	84079ee3          	bnez	a5,80200dd4 <vprintfmt+0x2c>
        }
    }

    return written;
    8020157c:	fec42783          	lw	a5,-20(s0)
}
    80201580:	00078513          	mv	a0,a5
    80201584:	0b813083          	ld	ra,184(sp)
    80201588:	0b013403          	ld	s0,176(sp)
    8020158c:	0c010113          	addi	sp,sp,192
    80201590:	00008067          	ret

0000000080201594 <printk>:

int printk(const char* s, ...) {
    80201594:	f9010113          	addi	sp,sp,-112
    80201598:	02113423          	sd	ra,40(sp)
    8020159c:	02813023          	sd	s0,32(sp)
    802015a0:	03010413          	addi	s0,sp,48
    802015a4:	fca43c23          	sd	a0,-40(s0)
    802015a8:	00b43423          	sd	a1,8(s0)
    802015ac:	00c43823          	sd	a2,16(s0)
    802015b0:	00d43c23          	sd	a3,24(s0)
    802015b4:	02e43023          	sd	a4,32(s0)
    802015b8:	02f43423          	sd	a5,40(s0)
    802015bc:	03043823          	sd	a6,48(s0)
    802015c0:	03143c23          	sd	a7,56(s0)
    int res = 0;
    802015c4:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    802015c8:	04040793          	addi	a5,s0,64
    802015cc:	fcf43823          	sd	a5,-48(s0)
    802015d0:	fd043783          	ld	a5,-48(s0)
    802015d4:	fc878793          	addi	a5,a5,-56
    802015d8:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    802015dc:	fe043783          	ld	a5,-32(s0)
    802015e0:	00078613          	mv	a2,a5
    802015e4:	fd843583          	ld	a1,-40(s0)
    802015e8:	fffff517          	auipc	a0,0xfffff
    802015ec:	0ec50513          	addi	a0,a0,236 # 802006d4 <putc>
    802015f0:	fb8ff0ef          	jal	80200da8 <vprintfmt>
    802015f4:	00050793          	mv	a5,a0
    802015f8:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    802015fc:	fec42783          	lw	a5,-20(s0)
}
    80201600:	00078513          	mv	a0,a5
    80201604:	02813083          	ld	ra,40(sp)
    80201608:	02013403          	ld	s0,32(sp)
    8020160c:	07010113          	addi	sp,sp,112
    80201610:	00008067          	ret
