
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:
_start:
    # ------------------
    # - your code here -
    # ------------------

    la sp, boot_stack_top
    80200000:	00003117          	auipc	sp,0x3
    80200004:	00813103          	ld	sp,8(sp) # 80203008 <_GLOBAL_OFFSET_TABLE_+0x8>
    call start_kernel
    80200008:	3ac000ef          	jal	802003b4 <start_kernel>

000000008020000c <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    8020000c:	f7010113          	addi	sp,sp,-144
    80200010:	08113423          	sd	ra,136(sp)
    80200014:	08813023          	sd	s0,128(sp)
    80200018:	06913c23          	sd	s1,120(sp)
    8020001c:	07213823          	sd	s2,112(sp)
    80200020:	07313423          	sd	s3,104(sp)
    80200024:	09010413          	addi	s0,sp,144
    80200028:	faa43423          	sd	a0,-88(s0)
    8020002c:	fab43023          	sd	a1,-96(s0)
    80200030:	f8c43c23          	sd	a2,-104(s0)
    80200034:	f8d43823          	sd	a3,-112(s0)
    80200038:	f8e43423          	sd	a4,-120(s0)
    8020003c:	f8f43023          	sd	a5,-128(s0)
    80200040:	f7043c23          	sd	a6,-136(s0)
    80200044:	f7143823          	sd	a7,-144(s0)
    struct sbiret ret;  // 返回值
    __asm__ volatile(
    80200048:	fa843e03          	ld	t3,-88(s0)
    8020004c:	fa043e83          	ld	t4,-96(s0)
    80200050:	f9843f03          	ld	t5,-104(s0)
    80200054:	f9043f83          	ld	t6,-112(s0)
    80200058:	f8843283          	ld	t0,-120(s0)
    8020005c:	f8043483          	ld	s1,-128(s0)
    80200060:	f7843903          	ld	s2,-136(s0)
    80200064:	f7043983          	ld	s3,-144(s0)
    80200068:	000e0893          	mv	a7,t3
    8020006c:	000e8813          	mv	a6,t4
    80200070:	000f0513          	mv	a0,t5
    80200074:	000f8593          	mv	a1,t6
    80200078:	00028613          	mv	a2,t0
    8020007c:	00048693          	mv	a3,s1
    80200080:	00090713          	mv	a4,s2
    80200084:	00098793          	mv	a5,s3
    80200088:	00000073          	ecall
    8020008c:	00050e93          	mv	t4,a0
    80200090:	00058e13          	mv	t3,a1
    80200094:	fbd43823          	sd	t4,-80(s0)
    80200098:	fbc43c23          	sd	t3,-72(s0)
        : [eid] "r"(eid), [fid] "r"(fid),                   // 输入绑定
          [arg0] "r"(arg0), [arg1] "r"(arg1), [arg2] "r"(arg2), [arg3] "r"(arg3), [arg4] "r"(arg4), [arg5] "r"(arg5)
          // 输入绑定
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "memory"  // 使用的寄存器及内存
    );
    return ret;
    8020009c:	fb043783          	ld	a5,-80(s0)
    802000a0:	fcf43023          	sd	a5,-64(s0)
    802000a4:	fb843783          	ld	a5,-72(s0)
    802000a8:	fcf43423          	sd	a5,-56(s0)
    802000ac:	fc043703          	ld	a4,-64(s0)
    802000b0:	fc843783          	ld	a5,-56(s0)
    802000b4:	00070313          	mv	t1,a4
    802000b8:	00078393          	mv	t2,a5
    802000bc:	00030713          	mv	a4,t1
    802000c0:	00038793          	mv	a5,t2
}
    802000c4:	00070513          	mv	a0,a4
    802000c8:	00078593          	mv	a1,a5
    802000cc:	08813083          	ld	ra,136(sp)
    802000d0:	08013403          	ld	s0,128(sp)
    802000d4:	07813483          	ld	s1,120(sp)
    802000d8:	07013903          	ld	s2,112(sp)
    802000dc:	06813983          	ld	s3,104(sp)
    802000e0:	09010113          	addi	sp,sp,144
    802000e4:	00008067          	ret

00000000802000e8 <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    802000e8:	fc010113          	addi	sp,sp,-64
    802000ec:	02113c23          	sd	ra,56(sp)
    802000f0:	02813823          	sd	s0,48(sp)
    802000f4:	03213423          	sd	s2,40(sp)
    802000f8:	03313023          	sd	s3,32(sp)
    802000fc:	04010413          	addi	s0,sp,64
    80200100:	00050793          	mv	a5,a0
    80200104:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434e, 2, (uint64_t)byte, 0, 0, 0, 0, 0);
    80200108:	fcf44603          	lbu	a2,-49(s0)
    8020010c:	00000893          	li	a7,0
    80200110:	00000813          	li	a6,0
    80200114:	00000793          	li	a5,0
    80200118:	00000713          	li	a4,0
    8020011c:	00000693          	li	a3,0
    80200120:	00200593          	li	a1,2
    80200124:	44424537          	lui	a0,0x44424
    80200128:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    8020012c:	ee1ff0ef          	jal	8020000c <sbi_ecall>
    80200130:	00050713          	mv	a4,a0
    80200134:	00058793          	mv	a5,a1
    80200138:	fce43823          	sd	a4,-48(s0)
    8020013c:	fcf43c23          	sd	a5,-40(s0)
    80200140:	fd043703          	ld	a4,-48(s0)
    80200144:	fd843783          	ld	a5,-40(s0)
    80200148:	00070913          	mv	s2,a4
    8020014c:	00078993          	mv	s3,a5
    80200150:	00090713          	mv	a4,s2
    80200154:	00098793          	mv	a5,s3
}
    80200158:	00070513          	mv	a0,a4
    8020015c:	00078593          	mv	a1,a5
    80200160:	03813083          	ld	ra,56(sp)
    80200164:	03013403          	ld	s0,48(sp)
    80200168:	02813903          	ld	s2,40(sp)
    8020016c:	02013983          	ld	s3,32(sp)
    80200170:	04010113          	addi	sp,sp,64
    80200174:	00008067          	ret

0000000080200178 <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    80200178:	fc010113          	addi	sp,sp,-64
    8020017c:	02113c23          	sd	ra,56(sp)
    80200180:	02813823          	sd	s0,48(sp)
    80200184:	03213423          	sd	s2,40(sp)
    80200188:	03313023          	sd	s3,32(sp)
    8020018c:	04010413          	addi	s0,sp,64
    80200190:	00050793          	mv	a5,a0
    80200194:	00058713          	mv	a4,a1
    80200198:	fcf42623          	sw	a5,-52(s0)
    8020019c:	00070793          	mv	a5,a4
    802001a0:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0, (uint64_t)reset_type, (uint64_t)reset_reason, 0, 0, 0, 0);
    802001a4:	fcc46603          	lwu	a2,-52(s0)
    802001a8:	fc846683          	lwu	a3,-56(s0)
    802001ac:	00000893          	li	a7,0
    802001b0:	00000813          	li	a6,0
    802001b4:	00000793          	li	a5,0
    802001b8:	00000713          	li	a4,0
    802001bc:	00000593          	li	a1,0
    802001c0:	53525537          	lui	a0,0x53525
    802001c4:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    802001c8:	e45ff0ef          	jal	8020000c <sbi_ecall>
    802001cc:	00050713          	mv	a4,a0
    802001d0:	00058793          	mv	a5,a1
    802001d4:	fce43823          	sd	a4,-48(s0)
    802001d8:	fcf43c23          	sd	a5,-40(s0)
    802001dc:	fd043703          	ld	a4,-48(s0)
    802001e0:	fd843783          	ld	a5,-40(s0)
    802001e4:	00070913          	mv	s2,a4
    802001e8:	00078993          	mv	s3,a5
    802001ec:	00090713          	mv	a4,s2
    802001f0:	00098793          	mv	a5,s3
}
    802001f4:	00070513          	mv	a0,a4
    802001f8:	00078593          	mv	a1,a5
    802001fc:	03813083          	ld	ra,56(sp)
    80200200:	03013403          	ld	s0,48(sp)
    80200204:	02813903          	ld	s2,40(sp)
    80200208:	02013983          	ld	s3,32(sp)
    8020020c:	04010113          	addi	sp,sp,64
    80200210:	00008067          	ret

0000000080200214 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    80200214:	fc010113          	addi	sp,sp,-64
    80200218:	02113c23          	sd	ra,56(sp)
    8020021c:	02813823          	sd	s0,48(sp)
    80200220:	03213423          	sd	s2,40(sp)
    80200224:	03313023          	sd	s3,32(sp)
    80200228:	04010413          	addi	s0,sp,64
    8020022c:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
    80200230:	00000893          	li	a7,0
    80200234:	00000813          	li	a6,0
    80200238:	00000793          	li	a5,0
    8020023c:	00000713          	li	a4,0
    80200240:	00000693          	li	a3,0
    80200244:	fc843603          	ld	a2,-56(s0)
    80200248:	00000593          	li	a1,0
    8020024c:	54495537          	lui	a0,0x54495
    80200250:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200254:	db9ff0ef          	jal	8020000c <sbi_ecall>
    80200258:	00050713          	mv	a4,a0
    8020025c:	00058793          	mv	a5,a1
    80200260:	fce43823          	sd	a4,-48(s0)
    80200264:	fcf43c23          	sd	a5,-40(s0)
    80200268:	fd043703          	ld	a4,-48(s0)
    8020026c:	fd843783          	ld	a5,-40(s0)
    80200270:	00070913          	mv	s2,a4
    80200274:	00078993          	mv	s3,a5
    80200278:	00090713          	mv	a4,s2
    8020027c:	00098793          	mv	a5,s3
}
    80200280:	00070513          	mv	a0,a4
    80200284:	00078593          	mv	a1,a5
    80200288:	03813083          	ld	ra,56(sp)
    8020028c:	03013403          	ld	s0,48(sp)
    80200290:	02813903          	ld	s2,40(sp)
    80200294:	02013983          	ld	s3,32(sp)
    80200298:	04010113          	addi	sp,sp,64
    8020029c:	00008067          	ret

00000000802002a0 <sbi_debug_console_read>:

struct sbiret sbi_debug_console_read() {
    802002a0:	fd010113          	addi	sp,sp,-48
    802002a4:	02113423          	sd	ra,40(sp)
    802002a8:	02813023          	sd	s0,32(sp)
    802002ac:	01213c23          	sd	s2,24(sp)
    802002b0:	01313823          	sd	s3,16(sp)
    802002b4:	03010413          	addi	s0,sp,48
    return sbi_ecall(0x4442434e, 1, 0, 0, 0, 0, 0, 0);
    802002b8:	00000893          	li	a7,0
    802002bc:	00000813          	li	a6,0
    802002c0:	00000793          	li	a5,0
    802002c4:	00000713          	li	a4,0
    802002c8:	00000693          	li	a3,0
    802002cc:	00000613          	li	a2,0
    802002d0:	00100593          	li	a1,1
    802002d4:	44424537          	lui	a0,0x44424
    802002d8:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802002dc:	d31ff0ef          	jal	8020000c <sbi_ecall>
    802002e0:	00050713          	mv	a4,a0
    802002e4:	00058793          	mv	a5,a1
    802002e8:	fce43823          	sd	a4,-48(s0)
    802002ec:	fcf43c23          	sd	a5,-40(s0)
    802002f0:	fd043703          	ld	a4,-48(s0)
    802002f4:	fd843783          	ld	a5,-40(s0)
    802002f8:	00070913          	mv	s2,a4
    802002fc:	00078993          	mv	s3,a5
    80200300:	00090713          	mv	a4,s2
    80200304:	00098793          	mv	a5,s3
}
    80200308:	00070513          	mv	a0,a4
    8020030c:	00078593          	mv	a1,a5
    80200310:	02813083          	ld	ra,40(sp)
    80200314:	02013403          	ld	s0,32(sp)
    80200318:	01813903          	ld	s2,24(sp)
    8020031c:	01013983          	ld	s3,16(sp)
    80200320:	03010113          	addi	sp,sp,48
    80200324:	00008067          	ret

0000000080200328 <sbi_debug_console_write>:

struct sbiret sbi_debug_console_write(const char *str) {
    80200328:	fc010113          	addi	sp,sp,-64
    8020032c:	02113c23          	sd	ra,56(sp)
    80200330:	02813823          	sd	s0,48(sp)
    80200334:	03213423          	sd	s2,40(sp)
    80200338:	03313023          	sd	s3,32(sp)
    8020033c:	04010413          	addi	s0,sp,64
    80200340:	fca43423          	sd	a0,-56(s0)
    //     str++;
    // }
    // return ret;

    // 一次性写入
    return sbi_ecall(0x4442434e, 0, (uint64_t)str, 0, 0, 0, 0, 0);
    80200344:	fc843603          	ld	a2,-56(s0)
    80200348:	00000893          	li	a7,0
    8020034c:	00000813          	li	a6,0
    80200350:	00000793          	li	a5,0
    80200354:	00000713          	li	a4,0
    80200358:	00000693          	li	a3,0
    8020035c:	00000593          	li	a1,0
    80200360:	44424537          	lui	a0,0x44424
    80200364:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    80200368:	ca5ff0ef          	jal	8020000c <sbi_ecall>
    8020036c:	00050713          	mv	a4,a0
    80200370:	00058793          	mv	a5,a1
    80200374:	fce43823          	sd	a4,-48(s0)
    80200378:	fcf43c23          	sd	a5,-40(s0)
    8020037c:	fd043703          	ld	a4,-48(s0)
    80200380:	fd843783          	ld	a5,-40(s0)
    80200384:	00070913          	mv	s2,a4
    80200388:	00078993          	mv	s3,a5
    8020038c:	00090713          	mv	a4,s2
    80200390:	00098793          	mv	a5,s3
}
    80200394:	00070513          	mv	a0,a4
    80200398:	00078593          	mv	a1,a5
    8020039c:	03813083          	ld	ra,56(sp)
    802003a0:	03013403          	ld	s0,48(sp)
    802003a4:	02813903          	ld	s2,40(sp)
    802003a8:	02013983          	ld	s3,32(sp)
    802003ac:	04010113          	addi	sp,sp,64
    802003b0:	00008067          	ret

00000000802003b4 <start_kernel>:
#include "printk.h"

extern void test();

int start_kernel() {
    802003b4:	ff010113          	addi	sp,sp,-16
    802003b8:	00113423          	sd	ra,8(sp)
    802003bc:	00813023          	sd	s0,0(sp)
    802003c0:	01010413          	addi	s0,sp,16
    printk("2024");
    802003c4:	00002517          	auipc	a0,0x2
    802003c8:	c3c50513          	addi	a0,a0,-964 # 80202000 <_srodata>
    802003cc:	709000ef          	jal	802012d4 <printk>
    printk(" ZJU Operating System\n");
    802003d0:	00002517          	auipc	a0,0x2
    802003d4:	c3850513          	addi	a0,a0,-968 # 80202008 <_srodata+0x8>
    802003d8:	6fd000ef          	jal	802012d4 <printk>

    test();
    802003dc:	01c000ef          	jal	802003f8 <test>
    return 0;
    802003e0:	00000793          	li	a5,0
}
    802003e4:	00078513          	mv	a0,a5
    802003e8:	00813083          	ld	ra,8(sp)
    802003ec:	00013403          	ld	s0,0(sp)
    802003f0:	01010113          	addi	sp,sp,16
    802003f4:	00008067          	ret

00000000802003f8 <test>:
#include "sbi.h"

void test() {
    802003f8:	ff010113          	addi	sp,sp,-16
    802003fc:	00113423          	sd	ra,8(sp)
    80200400:	00813023          	sd	s0,0(sp)
    80200404:	01010413          	addi	s0,sp,16
    sbi_system_reset(SBI_SRST_RESET_TYPE_SHUTDOWN, SBI_SRST_RESET_REASON_NONE);
    80200408:	00000593          	li	a1,0
    8020040c:	00000513          	li	a0,0
    80200410:	d69ff0ef          	jal	80200178 <sbi_system_reset>

0000000080200414 <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    80200414:	fe010113          	addi	sp,sp,-32
    80200418:	00113c23          	sd	ra,24(sp)
    8020041c:	00813823          	sd	s0,16(sp)
    80200420:	02010413          	addi	s0,sp,32
    80200424:	00050793          	mv	a5,a0
    80200428:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    8020042c:	fec42783          	lw	a5,-20(s0)
    80200430:	0ff7f793          	zext.b	a5,a5
    80200434:	00078513          	mv	a0,a5
    80200438:	cb1ff0ef          	jal	802000e8 <sbi_debug_console_write_byte>
    return (char)c;
    8020043c:	fec42783          	lw	a5,-20(s0)
    80200440:	0ff7f793          	zext.b	a5,a5
    80200444:	0007879b          	sext.w	a5,a5
}
    80200448:	00078513          	mv	a0,a5
    8020044c:	01813083          	ld	ra,24(sp)
    80200450:	01013403          	ld	s0,16(sp)
    80200454:	02010113          	addi	sp,sp,32
    80200458:	00008067          	ret

000000008020045c <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    8020045c:	fe010113          	addi	sp,sp,-32
    80200460:	00113c23          	sd	ra,24(sp)
    80200464:	00813823          	sd	s0,16(sp)
    80200468:	02010413          	addi	s0,sp,32
    8020046c:	00050793          	mv	a5,a0
    80200470:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    80200474:	fec42783          	lw	a5,-20(s0)
    80200478:	0007871b          	sext.w	a4,a5
    8020047c:	02000793          	li	a5,32
    80200480:	02f70263          	beq	a4,a5,802004a4 <isspace+0x48>
    80200484:	fec42783          	lw	a5,-20(s0)
    80200488:	0007871b          	sext.w	a4,a5
    8020048c:	00800793          	li	a5,8
    80200490:	00e7de63          	bge	a5,a4,802004ac <isspace+0x50>
    80200494:	fec42783          	lw	a5,-20(s0)
    80200498:	0007871b          	sext.w	a4,a5
    8020049c:	00d00793          	li	a5,13
    802004a0:	00e7c663          	blt	a5,a4,802004ac <isspace+0x50>
    802004a4:	00100793          	li	a5,1
    802004a8:	0080006f          	j	802004b0 <isspace+0x54>
    802004ac:	00000793          	li	a5,0
}
    802004b0:	00078513          	mv	a0,a5
    802004b4:	01813083          	ld	ra,24(sp)
    802004b8:	01013403          	ld	s0,16(sp)
    802004bc:	02010113          	addi	sp,sp,32
    802004c0:	00008067          	ret

00000000802004c4 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    802004c4:	fb010113          	addi	sp,sp,-80
    802004c8:	04113423          	sd	ra,72(sp)
    802004cc:	04813023          	sd	s0,64(sp)
    802004d0:	05010413          	addi	s0,sp,80
    802004d4:	fca43423          	sd	a0,-56(s0)
    802004d8:	fcb43023          	sd	a1,-64(s0)
    802004dc:	00060793          	mv	a5,a2
    802004e0:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    802004e4:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    802004e8:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    802004ec:	fc843783          	ld	a5,-56(s0)
    802004f0:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    802004f4:	0100006f          	j	80200504 <strtol+0x40>
        p++;
    802004f8:	fd843783          	ld	a5,-40(s0)
    802004fc:	00178793          	addi	a5,a5,1
    80200500:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    80200504:	fd843783          	ld	a5,-40(s0)
    80200508:	0007c783          	lbu	a5,0(a5)
    8020050c:	0007879b          	sext.w	a5,a5
    80200510:	00078513          	mv	a0,a5
    80200514:	f49ff0ef          	jal	8020045c <isspace>
    80200518:	00050793          	mv	a5,a0
    8020051c:	fc079ee3          	bnez	a5,802004f8 <strtol+0x34>
    }

    if (*p == '-') {
    80200520:	fd843783          	ld	a5,-40(s0)
    80200524:	0007c783          	lbu	a5,0(a5)
    80200528:	00078713          	mv	a4,a5
    8020052c:	02d00793          	li	a5,45
    80200530:	00f71e63          	bne	a4,a5,8020054c <strtol+0x88>
        neg = true;
    80200534:	00100793          	li	a5,1
    80200538:	fef403a3          	sb	a5,-25(s0)
        p++;
    8020053c:	fd843783          	ld	a5,-40(s0)
    80200540:	00178793          	addi	a5,a5,1
    80200544:	fcf43c23          	sd	a5,-40(s0)
    80200548:	0240006f          	j	8020056c <strtol+0xa8>
    } else if (*p == '+') {
    8020054c:	fd843783          	ld	a5,-40(s0)
    80200550:	0007c783          	lbu	a5,0(a5)
    80200554:	00078713          	mv	a4,a5
    80200558:	02b00793          	li	a5,43
    8020055c:	00f71863          	bne	a4,a5,8020056c <strtol+0xa8>
        p++;
    80200560:	fd843783          	ld	a5,-40(s0)
    80200564:	00178793          	addi	a5,a5,1
    80200568:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    8020056c:	fbc42783          	lw	a5,-68(s0)
    80200570:	0007879b          	sext.w	a5,a5
    80200574:	06079c63          	bnez	a5,802005ec <strtol+0x128>
        if (*p == '0') {
    80200578:	fd843783          	ld	a5,-40(s0)
    8020057c:	0007c783          	lbu	a5,0(a5)
    80200580:	00078713          	mv	a4,a5
    80200584:	03000793          	li	a5,48
    80200588:	04f71e63          	bne	a4,a5,802005e4 <strtol+0x120>
            p++;
    8020058c:	fd843783          	ld	a5,-40(s0)
    80200590:	00178793          	addi	a5,a5,1
    80200594:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80200598:	fd843783          	ld	a5,-40(s0)
    8020059c:	0007c783          	lbu	a5,0(a5)
    802005a0:	00078713          	mv	a4,a5
    802005a4:	07800793          	li	a5,120
    802005a8:	00f70c63          	beq	a4,a5,802005c0 <strtol+0xfc>
    802005ac:	fd843783          	ld	a5,-40(s0)
    802005b0:	0007c783          	lbu	a5,0(a5)
    802005b4:	00078713          	mv	a4,a5
    802005b8:	05800793          	li	a5,88
    802005bc:	00f71e63          	bne	a4,a5,802005d8 <strtol+0x114>
                base = 16;
    802005c0:	01000793          	li	a5,16
    802005c4:	faf42e23          	sw	a5,-68(s0)
                p++;
    802005c8:	fd843783          	ld	a5,-40(s0)
    802005cc:	00178793          	addi	a5,a5,1
    802005d0:	fcf43c23          	sd	a5,-40(s0)
    802005d4:	0180006f          	j	802005ec <strtol+0x128>
            } else {
                base = 8;
    802005d8:	00800793          	li	a5,8
    802005dc:	faf42e23          	sw	a5,-68(s0)
    802005e0:	00c0006f          	j	802005ec <strtol+0x128>
            }
        } else {
            base = 10;
    802005e4:	00a00793          	li	a5,10
    802005e8:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    802005ec:	fd843783          	ld	a5,-40(s0)
    802005f0:	0007c783          	lbu	a5,0(a5)
    802005f4:	00078713          	mv	a4,a5
    802005f8:	02f00793          	li	a5,47
    802005fc:	02e7f863          	bgeu	a5,a4,8020062c <strtol+0x168>
    80200600:	fd843783          	ld	a5,-40(s0)
    80200604:	0007c783          	lbu	a5,0(a5)
    80200608:	00078713          	mv	a4,a5
    8020060c:	03900793          	li	a5,57
    80200610:	00e7ee63          	bltu	a5,a4,8020062c <strtol+0x168>
            digit = *p - '0';
    80200614:	fd843783          	ld	a5,-40(s0)
    80200618:	0007c783          	lbu	a5,0(a5)
    8020061c:	0007879b          	sext.w	a5,a5
    80200620:	fd07879b          	addiw	a5,a5,-48
    80200624:	fcf42a23          	sw	a5,-44(s0)
    80200628:	0800006f          	j	802006a8 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    8020062c:	fd843783          	ld	a5,-40(s0)
    80200630:	0007c783          	lbu	a5,0(a5)
    80200634:	00078713          	mv	a4,a5
    80200638:	06000793          	li	a5,96
    8020063c:	02e7f863          	bgeu	a5,a4,8020066c <strtol+0x1a8>
    80200640:	fd843783          	ld	a5,-40(s0)
    80200644:	0007c783          	lbu	a5,0(a5)
    80200648:	00078713          	mv	a4,a5
    8020064c:	07a00793          	li	a5,122
    80200650:	00e7ee63          	bltu	a5,a4,8020066c <strtol+0x1a8>
            digit = *p - ('a' - 10);
    80200654:	fd843783          	ld	a5,-40(s0)
    80200658:	0007c783          	lbu	a5,0(a5)
    8020065c:	0007879b          	sext.w	a5,a5
    80200660:	fa97879b          	addiw	a5,a5,-87
    80200664:	fcf42a23          	sw	a5,-44(s0)
    80200668:	0400006f          	j	802006a8 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    8020066c:	fd843783          	ld	a5,-40(s0)
    80200670:	0007c783          	lbu	a5,0(a5)
    80200674:	00078713          	mv	a4,a5
    80200678:	04000793          	li	a5,64
    8020067c:	06e7f863          	bgeu	a5,a4,802006ec <strtol+0x228>
    80200680:	fd843783          	ld	a5,-40(s0)
    80200684:	0007c783          	lbu	a5,0(a5)
    80200688:	00078713          	mv	a4,a5
    8020068c:	05a00793          	li	a5,90
    80200690:	04e7ee63          	bltu	a5,a4,802006ec <strtol+0x228>
            digit = *p - ('A' - 10);
    80200694:	fd843783          	ld	a5,-40(s0)
    80200698:	0007c783          	lbu	a5,0(a5)
    8020069c:	0007879b          	sext.w	a5,a5
    802006a0:	fc97879b          	addiw	a5,a5,-55
    802006a4:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    802006a8:	fd442783          	lw	a5,-44(s0)
    802006ac:	00078713          	mv	a4,a5
    802006b0:	fbc42783          	lw	a5,-68(s0)
    802006b4:	0007071b          	sext.w	a4,a4
    802006b8:	0007879b          	sext.w	a5,a5
    802006bc:	02f75663          	bge	a4,a5,802006e8 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    802006c0:	fbc42703          	lw	a4,-68(s0)
    802006c4:	fe843783          	ld	a5,-24(s0)
    802006c8:	02f70733          	mul	a4,a4,a5
    802006cc:	fd442783          	lw	a5,-44(s0)
    802006d0:	00f707b3          	add	a5,a4,a5
    802006d4:	fef43423          	sd	a5,-24(s0)
        p++;
    802006d8:	fd843783          	ld	a5,-40(s0)
    802006dc:	00178793          	addi	a5,a5,1
    802006e0:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    802006e4:	f09ff06f          	j	802005ec <strtol+0x128>
            break;
    802006e8:	00000013          	nop
    }

    if (endptr) {
    802006ec:	fc043783          	ld	a5,-64(s0)
    802006f0:	00078863          	beqz	a5,80200700 <strtol+0x23c>
        *endptr = (char *)p;
    802006f4:	fc043783          	ld	a5,-64(s0)
    802006f8:	fd843703          	ld	a4,-40(s0)
    802006fc:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    80200700:	fe744783          	lbu	a5,-25(s0)
    80200704:	0ff7f793          	zext.b	a5,a5
    80200708:	00078863          	beqz	a5,80200718 <strtol+0x254>
    8020070c:	fe843783          	ld	a5,-24(s0)
    80200710:	40f007b3          	neg	a5,a5
    80200714:	0080006f          	j	8020071c <strtol+0x258>
    80200718:	fe843783          	ld	a5,-24(s0)
}
    8020071c:	00078513          	mv	a0,a5
    80200720:	04813083          	ld	ra,72(sp)
    80200724:	04013403          	ld	s0,64(sp)
    80200728:	05010113          	addi	sp,sp,80
    8020072c:	00008067          	ret

0000000080200730 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    80200730:	fd010113          	addi	sp,sp,-48
    80200734:	02113423          	sd	ra,40(sp)
    80200738:	02813023          	sd	s0,32(sp)
    8020073c:	03010413          	addi	s0,sp,48
    80200740:	fca43c23          	sd	a0,-40(s0)
    80200744:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    80200748:	fd043783          	ld	a5,-48(s0)
    8020074c:	00079863          	bnez	a5,8020075c <puts_wo_nl+0x2c>
        s = "(null)";
    80200750:	00002797          	auipc	a5,0x2
    80200754:	8d078793          	addi	a5,a5,-1840 # 80202020 <_srodata+0x20>
    80200758:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    8020075c:	fd043783          	ld	a5,-48(s0)
    80200760:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80200764:	0240006f          	j	80200788 <puts_wo_nl+0x58>
        putch(*p++);
    80200768:	fe843783          	ld	a5,-24(s0)
    8020076c:	00178713          	addi	a4,a5,1
    80200770:	fee43423          	sd	a4,-24(s0)
    80200774:	0007c783          	lbu	a5,0(a5)
    80200778:	0007871b          	sext.w	a4,a5
    8020077c:	fd843783          	ld	a5,-40(s0)
    80200780:	00070513          	mv	a0,a4
    80200784:	000780e7          	jalr	a5
    while (*p) {
    80200788:	fe843783          	ld	a5,-24(s0)
    8020078c:	0007c783          	lbu	a5,0(a5)
    80200790:	fc079ce3          	bnez	a5,80200768 <puts_wo_nl+0x38>
    }
    return p - s;
    80200794:	fe843703          	ld	a4,-24(s0)
    80200798:	fd043783          	ld	a5,-48(s0)
    8020079c:	40f707b3          	sub	a5,a4,a5
    802007a0:	0007879b          	sext.w	a5,a5
}
    802007a4:	00078513          	mv	a0,a5
    802007a8:	02813083          	ld	ra,40(sp)
    802007ac:	02013403          	ld	s0,32(sp)
    802007b0:	03010113          	addi	sp,sp,48
    802007b4:	00008067          	ret

00000000802007b8 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    802007b8:	f9010113          	addi	sp,sp,-112
    802007bc:	06113423          	sd	ra,104(sp)
    802007c0:	06813023          	sd	s0,96(sp)
    802007c4:	07010413          	addi	s0,sp,112
    802007c8:	faa43423          	sd	a0,-88(s0)
    802007cc:	fab43023          	sd	a1,-96(s0)
    802007d0:	00060793          	mv	a5,a2
    802007d4:	f8d43823          	sd	a3,-112(s0)
    802007d8:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    802007dc:	f9f44783          	lbu	a5,-97(s0)
    802007e0:	0ff7f793          	zext.b	a5,a5
    802007e4:	02078663          	beqz	a5,80200810 <print_dec_int+0x58>
    802007e8:	fa043703          	ld	a4,-96(s0)
    802007ec:	fff00793          	li	a5,-1
    802007f0:	03f79793          	slli	a5,a5,0x3f
    802007f4:	00f71e63          	bne	a4,a5,80200810 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    802007f8:	00002597          	auipc	a1,0x2
    802007fc:	83058593          	addi	a1,a1,-2000 # 80202028 <_srodata+0x28>
    80200800:	fa843503          	ld	a0,-88(s0)
    80200804:	f2dff0ef          	jal	80200730 <puts_wo_nl>
    80200808:	00050793          	mv	a5,a0
    8020080c:	2c80006f          	j	80200ad4 <print_dec_int+0x31c>
    }

    if (flags->prec == 0 && num == 0) {
    80200810:	f9043783          	ld	a5,-112(s0)
    80200814:	00c7a783          	lw	a5,12(a5)
    80200818:	00079a63          	bnez	a5,8020082c <print_dec_int+0x74>
    8020081c:	fa043783          	ld	a5,-96(s0)
    80200820:	00079663          	bnez	a5,8020082c <print_dec_int+0x74>
        return 0;
    80200824:	00000793          	li	a5,0
    80200828:	2ac0006f          	j	80200ad4 <print_dec_int+0x31c>
    }

    bool neg = false;
    8020082c:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    80200830:	f9f44783          	lbu	a5,-97(s0)
    80200834:	0ff7f793          	zext.b	a5,a5
    80200838:	02078063          	beqz	a5,80200858 <print_dec_int+0xa0>
    8020083c:	fa043783          	ld	a5,-96(s0)
    80200840:	0007dc63          	bgez	a5,80200858 <print_dec_int+0xa0>
        neg = true;
    80200844:	00100793          	li	a5,1
    80200848:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    8020084c:	fa043783          	ld	a5,-96(s0)
    80200850:	40f007b3          	neg	a5,a5
    80200854:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    80200858:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    8020085c:	f9f44783          	lbu	a5,-97(s0)
    80200860:	0ff7f793          	zext.b	a5,a5
    80200864:	02078863          	beqz	a5,80200894 <print_dec_int+0xdc>
    80200868:	fef44783          	lbu	a5,-17(s0)
    8020086c:	0ff7f793          	zext.b	a5,a5
    80200870:	00079e63          	bnez	a5,8020088c <print_dec_int+0xd4>
    80200874:	f9043783          	ld	a5,-112(s0)
    80200878:	0057c783          	lbu	a5,5(a5)
    8020087c:	00079863          	bnez	a5,8020088c <print_dec_int+0xd4>
    80200880:	f9043783          	ld	a5,-112(s0)
    80200884:	0047c783          	lbu	a5,4(a5)
    80200888:	00078663          	beqz	a5,80200894 <print_dec_int+0xdc>
    8020088c:	00100793          	li	a5,1
    80200890:	0080006f          	j	80200898 <print_dec_int+0xe0>
    80200894:	00000793          	li	a5,0
    80200898:	fcf40ba3          	sb	a5,-41(s0)
    8020089c:	fd744783          	lbu	a5,-41(s0)
    802008a0:	0017f793          	andi	a5,a5,1
    802008a4:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    802008a8:	fa043683          	ld	a3,-96(s0)
    802008ac:	00001797          	auipc	a5,0x1
    802008b0:	79478793          	addi	a5,a5,1940 # 80202040 <_srodata+0x40>
    802008b4:	0007b783          	ld	a5,0(a5)
    802008b8:	02f6b7b3          	mulhu	a5,a3,a5
    802008bc:	0037d713          	srli	a4,a5,0x3
    802008c0:	00070793          	mv	a5,a4
    802008c4:	00279793          	slli	a5,a5,0x2
    802008c8:	00e787b3          	add	a5,a5,a4
    802008cc:	00179793          	slli	a5,a5,0x1
    802008d0:	40f68733          	sub	a4,a3,a5
    802008d4:	0ff77713          	zext.b	a4,a4
    802008d8:	fe842783          	lw	a5,-24(s0)
    802008dc:	0017869b          	addiw	a3,a5,1
    802008e0:	fed42423          	sw	a3,-24(s0)
    802008e4:	0307071b          	addiw	a4,a4,48
    802008e8:	0ff77713          	zext.b	a4,a4
    802008ec:	ff078793          	addi	a5,a5,-16
    802008f0:	008787b3          	add	a5,a5,s0
    802008f4:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    802008f8:	fa043703          	ld	a4,-96(s0)
    802008fc:	00001797          	auipc	a5,0x1
    80200900:	74478793          	addi	a5,a5,1860 # 80202040 <_srodata+0x40>
    80200904:	0007b783          	ld	a5,0(a5)
    80200908:	02f737b3          	mulhu	a5,a4,a5
    8020090c:	0037d793          	srli	a5,a5,0x3
    80200910:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80200914:	fa043783          	ld	a5,-96(s0)
    80200918:	f80798e3          	bnez	a5,802008a8 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    8020091c:	f9043783          	ld	a5,-112(s0)
    80200920:	00c7a703          	lw	a4,12(a5)
    80200924:	fff00793          	li	a5,-1
    80200928:	02f71063          	bne	a4,a5,80200948 <print_dec_int+0x190>
    8020092c:	f9043783          	ld	a5,-112(s0)
    80200930:	0037c783          	lbu	a5,3(a5)
    80200934:	00078a63          	beqz	a5,80200948 <print_dec_int+0x190>
        flags->prec = flags->width;
    80200938:	f9043783          	ld	a5,-112(s0)
    8020093c:	0087a703          	lw	a4,8(a5)
    80200940:	f9043783          	ld	a5,-112(s0)
    80200944:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80200948:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    8020094c:	f9043783          	ld	a5,-112(s0)
    80200950:	0087a703          	lw	a4,8(a5)
    80200954:	fe842783          	lw	a5,-24(s0)
    80200958:	fcf42823          	sw	a5,-48(s0)
    8020095c:	f9043783          	ld	a5,-112(s0)
    80200960:	00c7a783          	lw	a5,12(a5)
    80200964:	fcf42623          	sw	a5,-52(s0)
    80200968:	fd042783          	lw	a5,-48(s0)
    8020096c:	00078593          	mv	a1,a5
    80200970:	fcc42783          	lw	a5,-52(s0)
    80200974:	00078613          	mv	a2,a5
    80200978:	0006069b          	sext.w	a3,a2
    8020097c:	0005879b          	sext.w	a5,a1
    80200980:	00f6d463          	bge	a3,a5,80200988 <print_dec_int+0x1d0>
    80200984:	00058613          	mv	a2,a1
    80200988:	0006079b          	sext.w	a5,a2
    8020098c:	40f707bb          	subw	a5,a4,a5
    80200990:	0007871b          	sext.w	a4,a5
    80200994:	fd744783          	lbu	a5,-41(s0)
    80200998:	0007879b          	sext.w	a5,a5
    8020099c:	40f707bb          	subw	a5,a4,a5
    802009a0:	fef42023          	sw	a5,-32(s0)
    802009a4:	0280006f          	j	802009cc <print_dec_int+0x214>
        putch(' ');
    802009a8:	fa843783          	ld	a5,-88(s0)
    802009ac:	02000513          	li	a0,32
    802009b0:	000780e7          	jalr	a5
        ++written;
    802009b4:	fe442783          	lw	a5,-28(s0)
    802009b8:	0017879b          	addiw	a5,a5,1
    802009bc:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    802009c0:	fe042783          	lw	a5,-32(s0)
    802009c4:	fff7879b          	addiw	a5,a5,-1
    802009c8:	fef42023          	sw	a5,-32(s0)
    802009cc:	fe042783          	lw	a5,-32(s0)
    802009d0:	0007879b          	sext.w	a5,a5
    802009d4:	fcf04ae3          	bgtz	a5,802009a8 <print_dec_int+0x1f0>
    }

    if (has_sign_char) {
    802009d8:	fd744783          	lbu	a5,-41(s0)
    802009dc:	0ff7f793          	zext.b	a5,a5
    802009e0:	04078463          	beqz	a5,80200a28 <print_dec_int+0x270>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    802009e4:	fef44783          	lbu	a5,-17(s0)
    802009e8:	0ff7f793          	zext.b	a5,a5
    802009ec:	00078663          	beqz	a5,802009f8 <print_dec_int+0x240>
    802009f0:	02d00793          	li	a5,45
    802009f4:	01c0006f          	j	80200a10 <print_dec_int+0x258>
    802009f8:	f9043783          	ld	a5,-112(s0)
    802009fc:	0057c783          	lbu	a5,5(a5)
    80200a00:	00078663          	beqz	a5,80200a0c <print_dec_int+0x254>
    80200a04:	02b00793          	li	a5,43
    80200a08:	0080006f          	j	80200a10 <print_dec_int+0x258>
    80200a0c:	02000793          	li	a5,32
    80200a10:	fa843703          	ld	a4,-88(s0)
    80200a14:	00078513          	mv	a0,a5
    80200a18:	000700e7          	jalr	a4
        ++written;
    80200a1c:	fe442783          	lw	a5,-28(s0)
    80200a20:	0017879b          	addiw	a5,a5,1
    80200a24:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200a28:	fe842783          	lw	a5,-24(s0)
    80200a2c:	fcf42e23          	sw	a5,-36(s0)
    80200a30:	0280006f          	j	80200a58 <print_dec_int+0x2a0>
        putch('0');
    80200a34:	fa843783          	ld	a5,-88(s0)
    80200a38:	03000513          	li	a0,48
    80200a3c:	000780e7          	jalr	a5
        ++written;
    80200a40:	fe442783          	lw	a5,-28(s0)
    80200a44:	0017879b          	addiw	a5,a5,1
    80200a48:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200a4c:	fdc42783          	lw	a5,-36(s0)
    80200a50:	0017879b          	addiw	a5,a5,1
    80200a54:	fcf42e23          	sw	a5,-36(s0)
    80200a58:	f9043783          	ld	a5,-112(s0)
    80200a5c:	00c7a703          	lw	a4,12(a5)
    80200a60:	fd744783          	lbu	a5,-41(s0)
    80200a64:	0007879b          	sext.w	a5,a5
    80200a68:	40f707bb          	subw	a5,a4,a5
    80200a6c:	0007879b          	sext.w	a5,a5
    80200a70:	fdc42703          	lw	a4,-36(s0)
    80200a74:	0007071b          	sext.w	a4,a4
    80200a78:	faf74ee3          	blt	a4,a5,80200a34 <print_dec_int+0x27c>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80200a7c:	fe842783          	lw	a5,-24(s0)
    80200a80:	fff7879b          	addiw	a5,a5,-1
    80200a84:	fcf42c23          	sw	a5,-40(s0)
    80200a88:	03c0006f          	j	80200ac4 <print_dec_int+0x30c>
        putch(buf[i]);
    80200a8c:	fd842783          	lw	a5,-40(s0)
    80200a90:	ff078793          	addi	a5,a5,-16
    80200a94:	008787b3          	add	a5,a5,s0
    80200a98:	fc87c783          	lbu	a5,-56(a5)
    80200a9c:	0007871b          	sext.w	a4,a5
    80200aa0:	fa843783          	ld	a5,-88(s0)
    80200aa4:	00070513          	mv	a0,a4
    80200aa8:	000780e7          	jalr	a5
        ++written;
    80200aac:	fe442783          	lw	a5,-28(s0)
    80200ab0:	0017879b          	addiw	a5,a5,1
    80200ab4:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    80200ab8:	fd842783          	lw	a5,-40(s0)
    80200abc:	fff7879b          	addiw	a5,a5,-1
    80200ac0:	fcf42c23          	sw	a5,-40(s0)
    80200ac4:	fd842783          	lw	a5,-40(s0)
    80200ac8:	0007879b          	sext.w	a5,a5
    80200acc:	fc07d0e3          	bgez	a5,80200a8c <print_dec_int+0x2d4>
    }

    return written;
    80200ad0:	fe442783          	lw	a5,-28(s0)
}
    80200ad4:	00078513          	mv	a0,a5
    80200ad8:	06813083          	ld	ra,104(sp)
    80200adc:	06013403          	ld	s0,96(sp)
    80200ae0:	07010113          	addi	sp,sp,112
    80200ae4:	00008067          	ret

0000000080200ae8 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    80200ae8:	f4010113          	addi	sp,sp,-192
    80200aec:	0a113c23          	sd	ra,184(sp)
    80200af0:	0a813823          	sd	s0,176(sp)
    80200af4:	0c010413          	addi	s0,sp,192
    80200af8:	f4a43c23          	sd	a0,-168(s0)
    80200afc:	f4b43823          	sd	a1,-176(s0)
    80200b00:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    80200b04:	f8043023          	sd	zero,-128(s0)
    80200b08:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80200b0c:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80200b10:	7a00006f          	j	802012b0 <vprintfmt+0x7c8>
        if (flags.in_format) {
    80200b14:	f8044783          	lbu	a5,-128(s0)
    80200b18:	72078c63          	beqz	a5,80201250 <vprintfmt+0x768>
            if (*fmt == '#') {
    80200b1c:	f5043783          	ld	a5,-176(s0)
    80200b20:	0007c783          	lbu	a5,0(a5)
    80200b24:	00078713          	mv	a4,a5
    80200b28:	02300793          	li	a5,35
    80200b2c:	00f71863          	bne	a4,a5,80200b3c <vprintfmt+0x54>
                flags.sharpflag = true;
    80200b30:	00100793          	li	a5,1
    80200b34:	f8f40123          	sb	a5,-126(s0)
    80200b38:	76c0006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == '0') {
    80200b3c:	f5043783          	ld	a5,-176(s0)
    80200b40:	0007c783          	lbu	a5,0(a5)
    80200b44:	00078713          	mv	a4,a5
    80200b48:	03000793          	li	a5,48
    80200b4c:	00f71863          	bne	a4,a5,80200b5c <vprintfmt+0x74>
                flags.zeroflag = true;
    80200b50:	00100793          	li	a5,1
    80200b54:	f8f401a3          	sb	a5,-125(s0)
    80200b58:	74c0006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    80200b5c:	f5043783          	ld	a5,-176(s0)
    80200b60:	0007c783          	lbu	a5,0(a5)
    80200b64:	00078713          	mv	a4,a5
    80200b68:	06c00793          	li	a5,108
    80200b6c:	04f70063          	beq	a4,a5,80200bac <vprintfmt+0xc4>
    80200b70:	f5043783          	ld	a5,-176(s0)
    80200b74:	0007c783          	lbu	a5,0(a5)
    80200b78:	00078713          	mv	a4,a5
    80200b7c:	07a00793          	li	a5,122
    80200b80:	02f70663          	beq	a4,a5,80200bac <vprintfmt+0xc4>
    80200b84:	f5043783          	ld	a5,-176(s0)
    80200b88:	0007c783          	lbu	a5,0(a5)
    80200b8c:	00078713          	mv	a4,a5
    80200b90:	07400793          	li	a5,116
    80200b94:	00f70c63          	beq	a4,a5,80200bac <vprintfmt+0xc4>
    80200b98:	f5043783          	ld	a5,-176(s0)
    80200b9c:	0007c783          	lbu	a5,0(a5)
    80200ba0:	00078713          	mv	a4,a5
    80200ba4:	06a00793          	li	a5,106
    80200ba8:	00f71863          	bne	a4,a5,80200bb8 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80200bac:	00100793          	li	a5,1
    80200bb0:	f8f400a3          	sb	a5,-127(s0)
    80200bb4:	6f00006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == '+') {
    80200bb8:	f5043783          	ld	a5,-176(s0)
    80200bbc:	0007c783          	lbu	a5,0(a5)
    80200bc0:	00078713          	mv	a4,a5
    80200bc4:	02b00793          	li	a5,43
    80200bc8:	00f71863          	bne	a4,a5,80200bd8 <vprintfmt+0xf0>
                flags.sign = true;
    80200bcc:	00100793          	li	a5,1
    80200bd0:	f8f402a3          	sb	a5,-123(s0)
    80200bd4:	6d00006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == ' ') {
    80200bd8:	f5043783          	ld	a5,-176(s0)
    80200bdc:	0007c783          	lbu	a5,0(a5)
    80200be0:	00078713          	mv	a4,a5
    80200be4:	02000793          	li	a5,32
    80200be8:	00f71863          	bne	a4,a5,80200bf8 <vprintfmt+0x110>
                flags.spaceflag = true;
    80200bec:	00100793          	li	a5,1
    80200bf0:	f8f40223          	sb	a5,-124(s0)
    80200bf4:	6b00006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == '*') {
    80200bf8:	f5043783          	ld	a5,-176(s0)
    80200bfc:	0007c783          	lbu	a5,0(a5)
    80200c00:	00078713          	mv	a4,a5
    80200c04:	02a00793          	li	a5,42
    80200c08:	00f71e63          	bne	a4,a5,80200c24 <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80200c0c:	f4843783          	ld	a5,-184(s0)
    80200c10:	00878713          	addi	a4,a5,8
    80200c14:	f4e43423          	sd	a4,-184(s0)
    80200c18:	0007a783          	lw	a5,0(a5)
    80200c1c:	f8f42423          	sw	a5,-120(s0)
    80200c20:	6840006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt >= '1' && *fmt <= '9') {
    80200c24:	f5043783          	ld	a5,-176(s0)
    80200c28:	0007c783          	lbu	a5,0(a5)
    80200c2c:	00078713          	mv	a4,a5
    80200c30:	03000793          	li	a5,48
    80200c34:	04e7f663          	bgeu	a5,a4,80200c80 <vprintfmt+0x198>
    80200c38:	f5043783          	ld	a5,-176(s0)
    80200c3c:	0007c783          	lbu	a5,0(a5)
    80200c40:	00078713          	mv	a4,a5
    80200c44:	03900793          	li	a5,57
    80200c48:	02e7ec63          	bltu	a5,a4,80200c80 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    80200c4c:	f5043783          	ld	a5,-176(s0)
    80200c50:	f5040713          	addi	a4,s0,-176
    80200c54:	00a00613          	li	a2,10
    80200c58:	00070593          	mv	a1,a4
    80200c5c:	00078513          	mv	a0,a5
    80200c60:	865ff0ef          	jal	802004c4 <strtol>
    80200c64:	00050793          	mv	a5,a0
    80200c68:	0007879b          	sext.w	a5,a5
    80200c6c:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    80200c70:	f5043783          	ld	a5,-176(s0)
    80200c74:	fff78793          	addi	a5,a5,-1
    80200c78:	f4f43823          	sd	a5,-176(s0)
    80200c7c:	6280006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == '.') {
    80200c80:	f5043783          	ld	a5,-176(s0)
    80200c84:	0007c783          	lbu	a5,0(a5)
    80200c88:	00078713          	mv	a4,a5
    80200c8c:	02e00793          	li	a5,46
    80200c90:	06f71863          	bne	a4,a5,80200d00 <vprintfmt+0x218>
                fmt++;
    80200c94:	f5043783          	ld	a5,-176(s0)
    80200c98:	00178793          	addi	a5,a5,1
    80200c9c:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80200ca0:	f5043783          	ld	a5,-176(s0)
    80200ca4:	0007c783          	lbu	a5,0(a5)
    80200ca8:	00078713          	mv	a4,a5
    80200cac:	02a00793          	li	a5,42
    80200cb0:	00f71e63          	bne	a4,a5,80200ccc <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    80200cb4:	f4843783          	ld	a5,-184(s0)
    80200cb8:	00878713          	addi	a4,a5,8
    80200cbc:	f4e43423          	sd	a4,-184(s0)
    80200cc0:	0007a783          	lw	a5,0(a5)
    80200cc4:	f8f42623          	sw	a5,-116(s0)
    80200cc8:	5dc0006f          	j	802012a4 <vprintfmt+0x7bc>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80200ccc:	f5043783          	ld	a5,-176(s0)
    80200cd0:	f5040713          	addi	a4,s0,-176
    80200cd4:	00a00613          	li	a2,10
    80200cd8:	00070593          	mv	a1,a4
    80200cdc:	00078513          	mv	a0,a5
    80200ce0:	fe4ff0ef          	jal	802004c4 <strtol>
    80200ce4:	00050793          	mv	a5,a0
    80200ce8:	0007879b          	sext.w	a5,a5
    80200cec:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80200cf0:	f5043783          	ld	a5,-176(s0)
    80200cf4:	fff78793          	addi	a5,a5,-1
    80200cf8:	f4f43823          	sd	a5,-176(s0)
    80200cfc:	5a80006f          	j	802012a4 <vprintfmt+0x7bc>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80200d00:	f5043783          	ld	a5,-176(s0)
    80200d04:	0007c783          	lbu	a5,0(a5)
    80200d08:	00078713          	mv	a4,a5
    80200d0c:	07800793          	li	a5,120
    80200d10:	02f70663          	beq	a4,a5,80200d3c <vprintfmt+0x254>
    80200d14:	f5043783          	ld	a5,-176(s0)
    80200d18:	0007c783          	lbu	a5,0(a5)
    80200d1c:	00078713          	mv	a4,a5
    80200d20:	05800793          	li	a5,88
    80200d24:	00f70c63          	beq	a4,a5,80200d3c <vprintfmt+0x254>
    80200d28:	f5043783          	ld	a5,-176(s0)
    80200d2c:	0007c783          	lbu	a5,0(a5)
    80200d30:	00078713          	mv	a4,a5
    80200d34:	07000793          	li	a5,112
    80200d38:	30f71063          	bne	a4,a5,80201038 <vprintfmt+0x550>
                bool is_long = *fmt == 'p' || flags.longflag;
    80200d3c:	f5043783          	ld	a5,-176(s0)
    80200d40:	0007c783          	lbu	a5,0(a5)
    80200d44:	00078713          	mv	a4,a5
    80200d48:	07000793          	li	a5,112
    80200d4c:	00f70663          	beq	a4,a5,80200d58 <vprintfmt+0x270>
    80200d50:	f8144783          	lbu	a5,-127(s0)
    80200d54:	00078663          	beqz	a5,80200d60 <vprintfmt+0x278>
    80200d58:	00100793          	li	a5,1
    80200d5c:	0080006f          	j	80200d64 <vprintfmt+0x27c>
    80200d60:	00000793          	li	a5,0
    80200d64:	faf403a3          	sb	a5,-89(s0)
    80200d68:	fa744783          	lbu	a5,-89(s0)
    80200d6c:	0017f793          	andi	a5,a5,1
    80200d70:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    80200d74:	fa744783          	lbu	a5,-89(s0)
    80200d78:	0ff7f793          	zext.b	a5,a5
    80200d7c:	00078c63          	beqz	a5,80200d94 <vprintfmt+0x2ac>
    80200d80:	f4843783          	ld	a5,-184(s0)
    80200d84:	00878713          	addi	a4,a5,8
    80200d88:	f4e43423          	sd	a4,-184(s0)
    80200d8c:	0007b783          	ld	a5,0(a5)
    80200d90:	01c0006f          	j	80200dac <vprintfmt+0x2c4>
    80200d94:	f4843783          	ld	a5,-184(s0)
    80200d98:	00878713          	addi	a4,a5,8
    80200d9c:	f4e43423          	sd	a4,-184(s0)
    80200da0:	0007a783          	lw	a5,0(a5)
    80200da4:	02079793          	slli	a5,a5,0x20
    80200da8:	0207d793          	srli	a5,a5,0x20
    80200dac:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80200db0:	f8c42783          	lw	a5,-116(s0)
    80200db4:	02079463          	bnez	a5,80200ddc <vprintfmt+0x2f4>
    80200db8:	fe043783          	ld	a5,-32(s0)
    80200dbc:	02079063          	bnez	a5,80200ddc <vprintfmt+0x2f4>
    80200dc0:	f5043783          	ld	a5,-176(s0)
    80200dc4:	0007c783          	lbu	a5,0(a5)
    80200dc8:	00078713          	mv	a4,a5
    80200dcc:	07000793          	li	a5,112
    80200dd0:	00f70663          	beq	a4,a5,80200ddc <vprintfmt+0x2f4>
                    flags.in_format = false;
    80200dd4:	f8040023          	sb	zero,-128(s0)
    80200dd8:	4cc0006f          	j	802012a4 <vprintfmt+0x7bc>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    80200ddc:	f5043783          	ld	a5,-176(s0)
    80200de0:	0007c783          	lbu	a5,0(a5)
    80200de4:	00078713          	mv	a4,a5
    80200de8:	07000793          	li	a5,112
    80200dec:	00f70a63          	beq	a4,a5,80200e00 <vprintfmt+0x318>
    80200df0:	f8244783          	lbu	a5,-126(s0)
    80200df4:	00078a63          	beqz	a5,80200e08 <vprintfmt+0x320>
    80200df8:	fe043783          	ld	a5,-32(s0)
    80200dfc:	00078663          	beqz	a5,80200e08 <vprintfmt+0x320>
    80200e00:	00100793          	li	a5,1
    80200e04:	0080006f          	j	80200e0c <vprintfmt+0x324>
    80200e08:	00000793          	li	a5,0
    80200e0c:	faf40323          	sb	a5,-90(s0)
    80200e10:	fa644783          	lbu	a5,-90(s0)
    80200e14:	0017f793          	andi	a5,a5,1
    80200e18:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80200e1c:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80200e20:	f5043783          	ld	a5,-176(s0)
    80200e24:	0007c783          	lbu	a5,0(a5)
    80200e28:	00078713          	mv	a4,a5
    80200e2c:	05800793          	li	a5,88
    80200e30:	00f71863          	bne	a4,a5,80200e40 <vprintfmt+0x358>
    80200e34:	00001797          	auipc	a5,0x1
    80200e38:	21478793          	addi	a5,a5,532 # 80202048 <upperxdigits.1>
    80200e3c:	00c0006f          	j	80200e48 <vprintfmt+0x360>
    80200e40:	00001797          	auipc	a5,0x1
    80200e44:	22078793          	addi	a5,a5,544 # 80202060 <lowerxdigits.0>
    80200e48:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    80200e4c:	fe043783          	ld	a5,-32(s0)
    80200e50:	00f7f793          	andi	a5,a5,15
    80200e54:	f9843703          	ld	a4,-104(s0)
    80200e58:	00f70733          	add	a4,a4,a5
    80200e5c:	fdc42783          	lw	a5,-36(s0)
    80200e60:	0017869b          	addiw	a3,a5,1
    80200e64:	fcd42e23          	sw	a3,-36(s0)
    80200e68:	00074703          	lbu	a4,0(a4)
    80200e6c:	ff078793          	addi	a5,a5,-16
    80200e70:	008787b3          	add	a5,a5,s0
    80200e74:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    80200e78:	fe043783          	ld	a5,-32(s0)
    80200e7c:	0047d793          	srli	a5,a5,0x4
    80200e80:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80200e84:	fe043783          	ld	a5,-32(s0)
    80200e88:	fc0792e3          	bnez	a5,80200e4c <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80200e8c:	f8c42703          	lw	a4,-116(s0)
    80200e90:	fff00793          	li	a5,-1
    80200e94:	02f71663          	bne	a4,a5,80200ec0 <vprintfmt+0x3d8>
    80200e98:	f8344783          	lbu	a5,-125(s0)
    80200e9c:	02078263          	beqz	a5,80200ec0 <vprintfmt+0x3d8>
                    flags.prec = flags.width - 2 * prefix;
    80200ea0:	f8842703          	lw	a4,-120(s0)
    80200ea4:	fa644783          	lbu	a5,-90(s0)
    80200ea8:	0007879b          	sext.w	a5,a5
    80200eac:	0017979b          	slliw	a5,a5,0x1
    80200eb0:	0007879b          	sext.w	a5,a5
    80200eb4:	40f707bb          	subw	a5,a4,a5
    80200eb8:	0007879b          	sext.w	a5,a5
    80200ebc:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80200ec0:	f8842703          	lw	a4,-120(s0)
    80200ec4:	fa644783          	lbu	a5,-90(s0)
    80200ec8:	0007879b          	sext.w	a5,a5
    80200ecc:	0017979b          	slliw	a5,a5,0x1
    80200ed0:	0007879b          	sext.w	a5,a5
    80200ed4:	40f707bb          	subw	a5,a4,a5
    80200ed8:	0007871b          	sext.w	a4,a5
    80200edc:	fdc42783          	lw	a5,-36(s0)
    80200ee0:	f8f42a23          	sw	a5,-108(s0)
    80200ee4:	f8c42783          	lw	a5,-116(s0)
    80200ee8:	f8f42823          	sw	a5,-112(s0)
    80200eec:	f9442783          	lw	a5,-108(s0)
    80200ef0:	00078593          	mv	a1,a5
    80200ef4:	f9042783          	lw	a5,-112(s0)
    80200ef8:	00078613          	mv	a2,a5
    80200efc:	0006069b          	sext.w	a3,a2
    80200f00:	0005879b          	sext.w	a5,a1
    80200f04:	00f6d463          	bge	a3,a5,80200f0c <vprintfmt+0x424>
    80200f08:	00058613          	mv	a2,a1
    80200f0c:	0006079b          	sext.w	a5,a2
    80200f10:	40f707bb          	subw	a5,a4,a5
    80200f14:	fcf42c23          	sw	a5,-40(s0)
    80200f18:	0280006f          	j	80200f40 <vprintfmt+0x458>
                    putch(' ');
    80200f1c:	f5843783          	ld	a5,-168(s0)
    80200f20:	02000513          	li	a0,32
    80200f24:	000780e7          	jalr	a5
                    ++written;
    80200f28:	fec42783          	lw	a5,-20(s0)
    80200f2c:	0017879b          	addiw	a5,a5,1
    80200f30:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    80200f34:	fd842783          	lw	a5,-40(s0)
    80200f38:	fff7879b          	addiw	a5,a5,-1
    80200f3c:	fcf42c23          	sw	a5,-40(s0)
    80200f40:	fd842783          	lw	a5,-40(s0)
    80200f44:	0007879b          	sext.w	a5,a5
    80200f48:	fcf04ae3          	bgtz	a5,80200f1c <vprintfmt+0x434>
                }

                if (prefix) {
    80200f4c:	fa644783          	lbu	a5,-90(s0)
    80200f50:	0ff7f793          	zext.b	a5,a5
    80200f54:	04078463          	beqz	a5,80200f9c <vprintfmt+0x4b4>
                    putch('0');
    80200f58:	f5843783          	ld	a5,-168(s0)
    80200f5c:	03000513          	li	a0,48
    80200f60:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    80200f64:	f5043783          	ld	a5,-176(s0)
    80200f68:	0007c783          	lbu	a5,0(a5)
    80200f6c:	00078713          	mv	a4,a5
    80200f70:	05800793          	li	a5,88
    80200f74:	00f71663          	bne	a4,a5,80200f80 <vprintfmt+0x498>
    80200f78:	05800793          	li	a5,88
    80200f7c:	0080006f          	j	80200f84 <vprintfmt+0x49c>
    80200f80:	07800793          	li	a5,120
    80200f84:	f5843703          	ld	a4,-168(s0)
    80200f88:	00078513          	mv	a0,a5
    80200f8c:	000700e7          	jalr	a4
                    written += 2;
    80200f90:	fec42783          	lw	a5,-20(s0)
    80200f94:	0027879b          	addiw	a5,a5,2
    80200f98:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80200f9c:	fdc42783          	lw	a5,-36(s0)
    80200fa0:	fcf42a23          	sw	a5,-44(s0)
    80200fa4:	0280006f          	j	80200fcc <vprintfmt+0x4e4>
                    putch('0');
    80200fa8:	f5843783          	ld	a5,-168(s0)
    80200fac:	03000513          	li	a0,48
    80200fb0:	000780e7          	jalr	a5
                    ++written;
    80200fb4:	fec42783          	lw	a5,-20(s0)
    80200fb8:	0017879b          	addiw	a5,a5,1
    80200fbc:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    80200fc0:	fd442783          	lw	a5,-44(s0)
    80200fc4:	0017879b          	addiw	a5,a5,1
    80200fc8:	fcf42a23          	sw	a5,-44(s0)
    80200fcc:	f8c42783          	lw	a5,-116(s0)
    80200fd0:	fd442703          	lw	a4,-44(s0)
    80200fd4:	0007071b          	sext.w	a4,a4
    80200fd8:	fcf748e3          	blt	a4,a5,80200fa8 <vprintfmt+0x4c0>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80200fdc:	fdc42783          	lw	a5,-36(s0)
    80200fe0:	fff7879b          	addiw	a5,a5,-1
    80200fe4:	fcf42823          	sw	a5,-48(s0)
    80200fe8:	03c0006f          	j	80201024 <vprintfmt+0x53c>
                    putch(buf[i]);
    80200fec:	fd042783          	lw	a5,-48(s0)
    80200ff0:	ff078793          	addi	a5,a5,-16
    80200ff4:	008787b3          	add	a5,a5,s0
    80200ff8:	f807c783          	lbu	a5,-128(a5)
    80200ffc:	0007871b          	sext.w	a4,a5
    80201000:	f5843783          	ld	a5,-168(s0)
    80201004:	00070513          	mv	a0,a4
    80201008:	000780e7          	jalr	a5
                    ++written;
    8020100c:	fec42783          	lw	a5,-20(s0)
    80201010:	0017879b          	addiw	a5,a5,1
    80201014:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201018:	fd042783          	lw	a5,-48(s0)
    8020101c:	fff7879b          	addiw	a5,a5,-1
    80201020:	fcf42823          	sw	a5,-48(s0)
    80201024:	fd042783          	lw	a5,-48(s0)
    80201028:	0007879b          	sext.w	a5,a5
    8020102c:	fc07d0e3          	bgez	a5,80200fec <vprintfmt+0x504>
                }

                flags.in_format = false;
    80201030:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80201034:	2700006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201038:	f5043783          	ld	a5,-176(s0)
    8020103c:	0007c783          	lbu	a5,0(a5)
    80201040:	00078713          	mv	a4,a5
    80201044:	06400793          	li	a5,100
    80201048:	02f70663          	beq	a4,a5,80201074 <vprintfmt+0x58c>
    8020104c:	f5043783          	ld	a5,-176(s0)
    80201050:	0007c783          	lbu	a5,0(a5)
    80201054:	00078713          	mv	a4,a5
    80201058:	06900793          	li	a5,105
    8020105c:	00f70c63          	beq	a4,a5,80201074 <vprintfmt+0x58c>
    80201060:	f5043783          	ld	a5,-176(s0)
    80201064:	0007c783          	lbu	a5,0(a5)
    80201068:	00078713          	mv	a4,a5
    8020106c:	07500793          	li	a5,117
    80201070:	08f71063          	bne	a4,a5,802010f0 <vprintfmt+0x608>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    80201074:	f8144783          	lbu	a5,-127(s0)
    80201078:	00078c63          	beqz	a5,80201090 <vprintfmt+0x5a8>
    8020107c:	f4843783          	ld	a5,-184(s0)
    80201080:	00878713          	addi	a4,a5,8
    80201084:	f4e43423          	sd	a4,-184(s0)
    80201088:	0007b783          	ld	a5,0(a5)
    8020108c:	0140006f          	j	802010a0 <vprintfmt+0x5b8>
    80201090:	f4843783          	ld	a5,-184(s0)
    80201094:	00878713          	addi	a4,a5,8
    80201098:	f4e43423          	sd	a4,-184(s0)
    8020109c:	0007a783          	lw	a5,0(a5)
    802010a0:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    802010a4:	fa843583          	ld	a1,-88(s0)
    802010a8:	f5043783          	ld	a5,-176(s0)
    802010ac:	0007c783          	lbu	a5,0(a5)
    802010b0:	0007871b          	sext.w	a4,a5
    802010b4:	07500793          	li	a5,117
    802010b8:	40f707b3          	sub	a5,a4,a5
    802010bc:	00f037b3          	snez	a5,a5
    802010c0:	0ff7f793          	zext.b	a5,a5
    802010c4:	f8040713          	addi	a4,s0,-128
    802010c8:	00070693          	mv	a3,a4
    802010cc:	00078613          	mv	a2,a5
    802010d0:	f5843503          	ld	a0,-168(s0)
    802010d4:	ee4ff0ef          	jal	802007b8 <print_dec_int>
    802010d8:	00050793          	mv	a5,a0
    802010dc:	fec42703          	lw	a4,-20(s0)
    802010e0:	00f707bb          	addw	a5,a4,a5
    802010e4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802010e8:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802010ec:	1b80006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == 'n') {
    802010f0:	f5043783          	ld	a5,-176(s0)
    802010f4:	0007c783          	lbu	a5,0(a5)
    802010f8:	00078713          	mv	a4,a5
    802010fc:	06e00793          	li	a5,110
    80201100:	04f71c63          	bne	a4,a5,80201158 <vprintfmt+0x670>
                if (flags.longflag) {
    80201104:	f8144783          	lbu	a5,-127(s0)
    80201108:	02078463          	beqz	a5,80201130 <vprintfmt+0x648>
                    long *n = va_arg(vl, long *);
    8020110c:	f4843783          	ld	a5,-184(s0)
    80201110:	00878713          	addi	a4,a5,8
    80201114:	f4e43423          	sd	a4,-184(s0)
    80201118:	0007b783          	ld	a5,0(a5)
    8020111c:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    80201120:	fec42703          	lw	a4,-20(s0)
    80201124:	fb043783          	ld	a5,-80(s0)
    80201128:	00e7b023          	sd	a4,0(a5)
    8020112c:	0240006f          	j	80201150 <vprintfmt+0x668>
                } else {
                    int *n = va_arg(vl, int *);
    80201130:	f4843783          	ld	a5,-184(s0)
    80201134:	00878713          	addi	a4,a5,8
    80201138:	f4e43423          	sd	a4,-184(s0)
    8020113c:	0007b783          	ld	a5,0(a5)
    80201140:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    80201144:	fb843783          	ld	a5,-72(s0)
    80201148:	fec42703          	lw	a4,-20(s0)
    8020114c:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    80201150:	f8040023          	sb	zero,-128(s0)
    80201154:	1500006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == 's') {
    80201158:	f5043783          	ld	a5,-176(s0)
    8020115c:	0007c783          	lbu	a5,0(a5)
    80201160:	00078713          	mv	a4,a5
    80201164:	07300793          	li	a5,115
    80201168:	02f71e63          	bne	a4,a5,802011a4 <vprintfmt+0x6bc>
                const char *s = va_arg(vl, const char *);
    8020116c:	f4843783          	ld	a5,-184(s0)
    80201170:	00878713          	addi	a4,a5,8
    80201174:	f4e43423          	sd	a4,-184(s0)
    80201178:	0007b783          	ld	a5,0(a5)
    8020117c:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    80201180:	fc043583          	ld	a1,-64(s0)
    80201184:	f5843503          	ld	a0,-168(s0)
    80201188:	da8ff0ef          	jal	80200730 <puts_wo_nl>
    8020118c:	00050793          	mv	a5,a0
    80201190:	fec42703          	lw	a4,-20(s0)
    80201194:	00f707bb          	addw	a5,a4,a5
    80201198:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    8020119c:	f8040023          	sb	zero,-128(s0)
    802011a0:	1040006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == 'c') {
    802011a4:	f5043783          	ld	a5,-176(s0)
    802011a8:	0007c783          	lbu	a5,0(a5)
    802011ac:	00078713          	mv	a4,a5
    802011b0:	06300793          	li	a5,99
    802011b4:	02f71e63          	bne	a4,a5,802011f0 <vprintfmt+0x708>
                int ch = va_arg(vl, int);
    802011b8:	f4843783          	ld	a5,-184(s0)
    802011bc:	00878713          	addi	a4,a5,8
    802011c0:	f4e43423          	sd	a4,-184(s0)
    802011c4:	0007a783          	lw	a5,0(a5)
    802011c8:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    802011cc:	fcc42703          	lw	a4,-52(s0)
    802011d0:	f5843783          	ld	a5,-168(s0)
    802011d4:	00070513          	mv	a0,a4
    802011d8:	000780e7          	jalr	a5
                ++written;
    802011dc:	fec42783          	lw	a5,-20(s0)
    802011e0:	0017879b          	addiw	a5,a5,1
    802011e4:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802011e8:	f8040023          	sb	zero,-128(s0)
    802011ec:	0b80006f          	j	802012a4 <vprintfmt+0x7bc>
            } else if (*fmt == '%') {
    802011f0:	f5043783          	ld	a5,-176(s0)
    802011f4:	0007c783          	lbu	a5,0(a5)
    802011f8:	00078713          	mv	a4,a5
    802011fc:	02500793          	li	a5,37
    80201200:	02f71263          	bne	a4,a5,80201224 <vprintfmt+0x73c>
                putch('%');
    80201204:	f5843783          	ld	a5,-168(s0)
    80201208:	02500513          	li	a0,37
    8020120c:	000780e7          	jalr	a5
                ++written;
    80201210:	fec42783          	lw	a5,-20(s0)
    80201214:	0017879b          	addiw	a5,a5,1
    80201218:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    8020121c:	f8040023          	sb	zero,-128(s0)
    80201220:	0840006f          	j	802012a4 <vprintfmt+0x7bc>
            } else {
                putch(*fmt);
    80201224:	f5043783          	ld	a5,-176(s0)
    80201228:	0007c783          	lbu	a5,0(a5)
    8020122c:	0007871b          	sext.w	a4,a5
    80201230:	f5843783          	ld	a5,-168(s0)
    80201234:	00070513          	mv	a0,a4
    80201238:	000780e7          	jalr	a5
                ++written;
    8020123c:	fec42783          	lw	a5,-20(s0)
    80201240:	0017879b          	addiw	a5,a5,1
    80201244:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201248:	f8040023          	sb	zero,-128(s0)
    8020124c:	0580006f          	j	802012a4 <vprintfmt+0x7bc>
            }
        } else if (*fmt == '%') {
    80201250:	f5043783          	ld	a5,-176(s0)
    80201254:	0007c783          	lbu	a5,0(a5)
    80201258:	00078713          	mv	a4,a5
    8020125c:	02500793          	li	a5,37
    80201260:	02f71063          	bne	a4,a5,80201280 <vprintfmt+0x798>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    80201264:	f8043023          	sd	zero,-128(s0)
    80201268:	f8043423          	sd	zero,-120(s0)
    8020126c:	00100793          	li	a5,1
    80201270:	f8f40023          	sb	a5,-128(s0)
    80201274:	fff00793          	li	a5,-1
    80201278:	f8f42623          	sw	a5,-116(s0)
    8020127c:	0280006f          	j	802012a4 <vprintfmt+0x7bc>
        } else {
            putch(*fmt);
    80201280:	f5043783          	ld	a5,-176(s0)
    80201284:	0007c783          	lbu	a5,0(a5)
    80201288:	0007871b          	sext.w	a4,a5
    8020128c:	f5843783          	ld	a5,-168(s0)
    80201290:	00070513          	mv	a0,a4
    80201294:	000780e7          	jalr	a5
            ++written;
    80201298:	fec42783          	lw	a5,-20(s0)
    8020129c:	0017879b          	addiw	a5,a5,1
    802012a0:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    802012a4:	f5043783          	ld	a5,-176(s0)
    802012a8:	00178793          	addi	a5,a5,1
    802012ac:	f4f43823          	sd	a5,-176(s0)
    802012b0:	f5043783          	ld	a5,-176(s0)
    802012b4:	0007c783          	lbu	a5,0(a5)
    802012b8:	84079ee3          	bnez	a5,80200b14 <vprintfmt+0x2c>
        }
    }

    return written;
    802012bc:	fec42783          	lw	a5,-20(s0)
}
    802012c0:	00078513          	mv	a0,a5
    802012c4:	0b813083          	ld	ra,184(sp)
    802012c8:	0b013403          	ld	s0,176(sp)
    802012cc:	0c010113          	addi	sp,sp,192
    802012d0:	00008067          	ret

00000000802012d4 <printk>:

int printk(const char* s, ...) {
    802012d4:	f9010113          	addi	sp,sp,-112
    802012d8:	02113423          	sd	ra,40(sp)
    802012dc:	02813023          	sd	s0,32(sp)
    802012e0:	03010413          	addi	s0,sp,48
    802012e4:	fca43c23          	sd	a0,-40(s0)
    802012e8:	00b43423          	sd	a1,8(s0)
    802012ec:	00c43823          	sd	a2,16(s0)
    802012f0:	00d43c23          	sd	a3,24(s0)
    802012f4:	02e43023          	sd	a4,32(s0)
    802012f8:	02f43423          	sd	a5,40(s0)
    802012fc:	03043823          	sd	a6,48(s0)
    80201300:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201304:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201308:	04040793          	addi	a5,s0,64
    8020130c:	fcf43823          	sd	a5,-48(s0)
    80201310:	fd043783          	ld	a5,-48(s0)
    80201314:	fc878793          	addi	a5,a5,-56
    80201318:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    8020131c:	fe043783          	ld	a5,-32(s0)
    80201320:	00078613          	mv	a2,a5
    80201324:	fd843583          	ld	a1,-40(s0)
    80201328:	fffff517          	auipc	a0,0xfffff
    8020132c:	0ec50513          	addi	a0,a0,236 # 80200414 <putc>
    80201330:	fb8ff0ef          	jal	80200ae8 <vprintfmt>
    80201334:	00050793          	mv	a5,a0
    80201338:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    8020133c:	fec42783          	lw	a5,-20(s0)
}
    80201340:	00078513          	mv	a0,a5
    80201344:	02813083          	ld	ra,40(sp)
    80201348:	02013403          	ld	s0,32(sp)
    8020134c:	07010113          	addi	sp,sp,112
    80201350:	00008067          	ret
