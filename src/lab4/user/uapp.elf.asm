
uapp.elf:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000000000000 <_start>:
   0:	0400006f          	j	40 <main>

Disassembly of section .text.getpid:

0000000000000004 <getpid>:
   4:	fe010113          	addi	sp,sp,-32
   8:	00113c23          	sd	ra,24(sp)
   c:	00813823          	sd	s0,16(sp)
  10:	02010413          	addi	s0,sp,32
  14:	fe843783          	ld	a5,-24(s0)
  18:	0ac00893          	li	a7,172
  1c:	00000073          	ecall
  20:	00050793          	mv	a5,a0
  24:	fef43423          	sd	a5,-24(s0)
  28:	fe843783          	ld	a5,-24(s0)
  2c:	00078513          	mv	a0,a5
  30:	01813083          	ld	ra,24(sp)
  34:	01013403          	ld	s0,16(sp)
  38:	02010113          	addi	sp,sp,32
  3c:	00008067          	ret

Disassembly of section .text.main:

0000000000000040 <main>:
  40:	fe010113          	addi	sp,sp,-32
  44:	00113c23          	sd	ra,24(sp)
  48:	00813823          	sd	s0,16(sp)
  4c:	02010413          	addi	s0,sp,32
  50:	fb5ff0ef          	jal	4 <getpid>
  54:	00050593          	mv	a1,a0
  58:	00010613          	mv	a2,sp
  5c:	00001797          	auipc	a5,0x1
  60:	26078793          	addi	a5,a5,608 # 12bc <counter>
  64:	0007a783          	lw	a5,0(a5)
  68:	0017879b          	addiw	a5,a5,1
  6c:	0007871b          	sext.w	a4,a5
  70:	00001797          	auipc	a5,0x1
  74:	24c78793          	addi	a5,a5,588 # 12bc <counter>
  78:	00e7a023          	sw	a4,0(a5)
  7c:	00001797          	auipc	a5,0x1
  80:	24078793          	addi	a5,a5,576 # 12bc <counter>
  84:	0007a783          	lw	a5,0(a5)
  88:	00078693          	mv	a3,a5
  8c:	00001517          	auipc	a0,0x1
  90:	1a450513          	addi	a0,a0,420 # 1230 <printf+0x284>
  94:	719000ef          	jal	fac <printf>
  98:	fe042623          	sw	zero,-20(s0)
  9c:	0100006f          	j	ac <main+0x6c>
  a0:	fec42783          	lw	a5,-20(s0)
  a4:	0017879b          	addiw	a5,a5,1
  a8:	fef42623          	sw	a5,-20(s0)
  ac:	fec42783          	lw	a5,-20(s0)
  b0:	0007871b          	sext.w	a4,a5
  b4:	500007b7          	lui	a5,0x50000
  b8:	ffe78793          	addi	a5,a5,-2 # 4ffffffe <buffer+0x4fffed36>
  bc:	fee7f2e3          	bgeu	a5,a4,a0 <main+0x60>
  c0:	f91ff06f          	j	50 <main+0x10>

Disassembly of section .text.putc:

00000000000000c4 <putc>:
  c4:	fe010113          	addi	sp,sp,-32
  c8:	00113c23          	sd	ra,24(sp)
  cc:	00813823          	sd	s0,16(sp)
  d0:	02010413          	addi	s0,sp,32
  d4:	00050793          	mv	a5,a0
  d8:	fef42623          	sw	a5,-20(s0)
  dc:	00001797          	auipc	a5,0x1
  e0:	1e478793          	addi	a5,a5,484 # 12c0 <tail>
  e4:	0007a783          	lw	a5,0(a5)
  e8:	0017871b          	addiw	a4,a5,1
  ec:	0007069b          	sext.w	a3,a4
  f0:	00001717          	auipc	a4,0x1
  f4:	1d070713          	addi	a4,a4,464 # 12c0 <tail>
  f8:	00d72023          	sw	a3,0(a4)
  fc:	fec42703          	lw	a4,-20(s0)
 100:	0ff77713          	zext.b	a4,a4
 104:	00001697          	auipc	a3,0x1
 108:	1c468693          	addi	a3,a3,452 # 12c8 <buffer>
 10c:	00f687b3          	add	a5,a3,a5
 110:	00e78023          	sb	a4,0(a5)
 114:	fec42783          	lw	a5,-20(s0)
 118:	0ff7f793          	zext.b	a5,a5
 11c:	0007879b          	sext.w	a5,a5
 120:	00078513          	mv	a0,a5
 124:	01813083          	ld	ra,24(sp)
 128:	01013403          	ld	s0,16(sp)
 12c:	02010113          	addi	sp,sp,32
 130:	00008067          	ret

Disassembly of section .text.isspace:

0000000000000134 <isspace>:
 134:	fe010113          	addi	sp,sp,-32
 138:	00113c23          	sd	ra,24(sp)
 13c:	00813823          	sd	s0,16(sp)
 140:	02010413          	addi	s0,sp,32
 144:	00050793          	mv	a5,a0
 148:	fef42623          	sw	a5,-20(s0)
 14c:	fec42783          	lw	a5,-20(s0)
 150:	0007871b          	sext.w	a4,a5
 154:	02000793          	li	a5,32
 158:	02f70263          	beq	a4,a5,17c <isspace+0x48>
 15c:	fec42783          	lw	a5,-20(s0)
 160:	0007871b          	sext.w	a4,a5
 164:	00800793          	li	a5,8
 168:	00e7de63          	bge	a5,a4,184 <isspace+0x50>
 16c:	fec42783          	lw	a5,-20(s0)
 170:	0007871b          	sext.w	a4,a5
 174:	00d00793          	li	a5,13
 178:	00e7c663          	blt	a5,a4,184 <isspace+0x50>
 17c:	00100793          	li	a5,1
 180:	0080006f          	j	188 <isspace+0x54>
 184:	00000793          	li	a5,0
 188:	00078513          	mv	a0,a5
 18c:	01813083          	ld	ra,24(sp)
 190:	01013403          	ld	s0,16(sp)
 194:	02010113          	addi	sp,sp,32
 198:	00008067          	ret

Disassembly of section .text.strtol:

000000000000019c <strtol>:
 19c:	fb010113          	addi	sp,sp,-80
 1a0:	04113423          	sd	ra,72(sp)
 1a4:	04813023          	sd	s0,64(sp)
 1a8:	05010413          	addi	s0,sp,80
 1ac:	fca43423          	sd	a0,-56(s0)
 1b0:	fcb43023          	sd	a1,-64(s0)
 1b4:	00060793          	mv	a5,a2
 1b8:	faf42e23          	sw	a5,-68(s0)
 1bc:	fe043423          	sd	zero,-24(s0)
 1c0:	fe0403a3          	sb	zero,-25(s0)
 1c4:	fc843783          	ld	a5,-56(s0)
 1c8:	fcf43c23          	sd	a5,-40(s0)
 1cc:	0100006f          	j	1dc <strtol+0x40>
 1d0:	fd843783          	ld	a5,-40(s0)
 1d4:	00178793          	addi	a5,a5,1
 1d8:	fcf43c23          	sd	a5,-40(s0)
 1dc:	fd843783          	ld	a5,-40(s0)
 1e0:	0007c783          	lbu	a5,0(a5)
 1e4:	0007879b          	sext.w	a5,a5
 1e8:	00078513          	mv	a0,a5
 1ec:	f49ff0ef          	jal	134 <isspace>
 1f0:	00050793          	mv	a5,a0
 1f4:	fc079ee3          	bnez	a5,1d0 <strtol+0x34>
 1f8:	fd843783          	ld	a5,-40(s0)
 1fc:	0007c783          	lbu	a5,0(a5)
 200:	00078713          	mv	a4,a5
 204:	02d00793          	li	a5,45
 208:	00f71e63          	bne	a4,a5,224 <strtol+0x88>
 20c:	00100793          	li	a5,1
 210:	fef403a3          	sb	a5,-25(s0)
 214:	fd843783          	ld	a5,-40(s0)
 218:	00178793          	addi	a5,a5,1
 21c:	fcf43c23          	sd	a5,-40(s0)
 220:	0240006f          	j	244 <strtol+0xa8>
 224:	fd843783          	ld	a5,-40(s0)
 228:	0007c783          	lbu	a5,0(a5)
 22c:	00078713          	mv	a4,a5
 230:	02b00793          	li	a5,43
 234:	00f71863          	bne	a4,a5,244 <strtol+0xa8>
 238:	fd843783          	ld	a5,-40(s0)
 23c:	00178793          	addi	a5,a5,1
 240:	fcf43c23          	sd	a5,-40(s0)
 244:	fbc42783          	lw	a5,-68(s0)
 248:	0007879b          	sext.w	a5,a5
 24c:	06079c63          	bnez	a5,2c4 <strtol+0x128>
 250:	fd843783          	ld	a5,-40(s0)
 254:	0007c783          	lbu	a5,0(a5)
 258:	00078713          	mv	a4,a5
 25c:	03000793          	li	a5,48
 260:	04f71e63          	bne	a4,a5,2bc <strtol+0x120>
 264:	fd843783          	ld	a5,-40(s0)
 268:	00178793          	addi	a5,a5,1
 26c:	fcf43c23          	sd	a5,-40(s0)
 270:	fd843783          	ld	a5,-40(s0)
 274:	0007c783          	lbu	a5,0(a5)
 278:	00078713          	mv	a4,a5
 27c:	07800793          	li	a5,120
 280:	00f70c63          	beq	a4,a5,298 <strtol+0xfc>
 284:	fd843783          	ld	a5,-40(s0)
 288:	0007c783          	lbu	a5,0(a5)
 28c:	00078713          	mv	a4,a5
 290:	05800793          	li	a5,88
 294:	00f71e63          	bne	a4,a5,2b0 <strtol+0x114>
 298:	01000793          	li	a5,16
 29c:	faf42e23          	sw	a5,-68(s0)
 2a0:	fd843783          	ld	a5,-40(s0)
 2a4:	00178793          	addi	a5,a5,1
 2a8:	fcf43c23          	sd	a5,-40(s0)
 2ac:	0180006f          	j	2c4 <strtol+0x128>
 2b0:	00800793          	li	a5,8
 2b4:	faf42e23          	sw	a5,-68(s0)
 2b8:	00c0006f          	j	2c4 <strtol+0x128>
 2bc:	00a00793          	li	a5,10
 2c0:	faf42e23          	sw	a5,-68(s0)
 2c4:	fd843783          	ld	a5,-40(s0)
 2c8:	0007c783          	lbu	a5,0(a5)
 2cc:	00078713          	mv	a4,a5
 2d0:	02f00793          	li	a5,47
 2d4:	02e7f863          	bgeu	a5,a4,304 <strtol+0x168>
 2d8:	fd843783          	ld	a5,-40(s0)
 2dc:	0007c783          	lbu	a5,0(a5)
 2e0:	00078713          	mv	a4,a5
 2e4:	03900793          	li	a5,57
 2e8:	00e7ee63          	bltu	a5,a4,304 <strtol+0x168>
 2ec:	fd843783          	ld	a5,-40(s0)
 2f0:	0007c783          	lbu	a5,0(a5)
 2f4:	0007879b          	sext.w	a5,a5
 2f8:	fd07879b          	addiw	a5,a5,-48
 2fc:	fcf42a23          	sw	a5,-44(s0)
 300:	0800006f          	j	380 <strtol+0x1e4>
 304:	fd843783          	ld	a5,-40(s0)
 308:	0007c783          	lbu	a5,0(a5)
 30c:	00078713          	mv	a4,a5
 310:	06000793          	li	a5,96
 314:	02e7f863          	bgeu	a5,a4,344 <strtol+0x1a8>
 318:	fd843783          	ld	a5,-40(s0)
 31c:	0007c783          	lbu	a5,0(a5)
 320:	00078713          	mv	a4,a5
 324:	07a00793          	li	a5,122
 328:	00e7ee63          	bltu	a5,a4,344 <strtol+0x1a8>
 32c:	fd843783          	ld	a5,-40(s0)
 330:	0007c783          	lbu	a5,0(a5)
 334:	0007879b          	sext.w	a5,a5
 338:	fa97879b          	addiw	a5,a5,-87
 33c:	fcf42a23          	sw	a5,-44(s0)
 340:	0400006f          	j	380 <strtol+0x1e4>
 344:	fd843783          	ld	a5,-40(s0)
 348:	0007c783          	lbu	a5,0(a5)
 34c:	00078713          	mv	a4,a5
 350:	04000793          	li	a5,64
 354:	06e7f863          	bgeu	a5,a4,3c4 <strtol+0x228>
 358:	fd843783          	ld	a5,-40(s0)
 35c:	0007c783          	lbu	a5,0(a5)
 360:	00078713          	mv	a4,a5
 364:	05a00793          	li	a5,90
 368:	04e7ee63          	bltu	a5,a4,3c4 <strtol+0x228>
 36c:	fd843783          	ld	a5,-40(s0)
 370:	0007c783          	lbu	a5,0(a5)
 374:	0007879b          	sext.w	a5,a5
 378:	fc97879b          	addiw	a5,a5,-55
 37c:	fcf42a23          	sw	a5,-44(s0)
 380:	fd442783          	lw	a5,-44(s0)
 384:	00078713          	mv	a4,a5
 388:	fbc42783          	lw	a5,-68(s0)
 38c:	0007071b          	sext.w	a4,a4
 390:	0007879b          	sext.w	a5,a5
 394:	02f75663          	bge	a4,a5,3c0 <strtol+0x224>
 398:	fbc42703          	lw	a4,-68(s0)
 39c:	fe843783          	ld	a5,-24(s0)
 3a0:	02f70733          	mul	a4,a4,a5
 3a4:	fd442783          	lw	a5,-44(s0)
 3a8:	00f707b3          	add	a5,a4,a5
 3ac:	fef43423          	sd	a5,-24(s0)
 3b0:	fd843783          	ld	a5,-40(s0)
 3b4:	00178793          	addi	a5,a5,1
 3b8:	fcf43c23          	sd	a5,-40(s0)
 3bc:	f09ff06f          	j	2c4 <strtol+0x128>
 3c0:	00000013          	nop
 3c4:	fc043783          	ld	a5,-64(s0)
 3c8:	00078863          	beqz	a5,3d8 <strtol+0x23c>
 3cc:	fc043783          	ld	a5,-64(s0)
 3d0:	fd843703          	ld	a4,-40(s0)
 3d4:	00e7b023          	sd	a4,0(a5)
 3d8:	fe744783          	lbu	a5,-25(s0)
 3dc:	0ff7f793          	zext.b	a5,a5
 3e0:	00078863          	beqz	a5,3f0 <strtol+0x254>
 3e4:	fe843783          	ld	a5,-24(s0)
 3e8:	40f007b3          	neg	a5,a5
 3ec:	0080006f          	j	3f4 <strtol+0x258>
 3f0:	fe843783          	ld	a5,-24(s0)
 3f4:	00078513          	mv	a0,a5
 3f8:	04813083          	ld	ra,72(sp)
 3fc:	04013403          	ld	s0,64(sp)
 400:	05010113          	addi	sp,sp,80
 404:	00008067          	ret

Disassembly of section .text.puts_wo_nl:

0000000000000408 <puts_wo_nl>:
 408:	fd010113          	addi	sp,sp,-48
 40c:	02113423          	sd	ra,40(sp)
 410:	02813023          	sd	s0,32(sp)
 414:	03010413          	addi	s0,sp,48
 418:	fca43c23          	sd	a0,-40(s0)
 41c:	fcb43823          	sd	a1,-48(s0)
 420:	fd043783          	ld	a5,-48(s0)
 424:	00079863          	bnez	a5,434 <puts_wo_nl+0x2c>
 428:	00001797          	auipc	a5,0x1
 42c:	e4078793          	addi	a5,a5,-448 # 1268 <printf+0x2bc>
 430:	fcf43823          	sd	a5,-48(s0)
 434:	fd043783          	ld	a5,-48(s0)
 438:	fef43423          	sd	a5,-24(s0)
 43c:	0240006f          	j	460 <puts_wo_nl+0x58>
 440:	fe843783          	ld	a5,-24(s0)
 444:	00178713          	addi	a4,a5,1
 448:	fee43423          	sd	a4,-24(s0)
 44c:	0007c783          	lbu	a5,0(a5)
 450:	0007871b          	sext.w	a4,a5
 454:	fd843783          	ld	a5,-40(s0)
 458:	00070513          	mv	a0,a4
 45c:	000780e7          	jalr	a5
 460:	fe843783          	ld	a5,-24(s0)
 464:	0007c783          	lbu	a5,0(a5)
 468:	fc079ce3          	bnez	a5,440 <puts_wo_nl+0x38>
 46c:	fe843703          	ld	a4,-24(s0)
 470:	fd043783          	ld	a5,-48(s0)
 474:	40f707b3          	sub	a5,a4,a5
 478:	0007879b          	sext.w	a5,a5
 47c:	00078513          	mv	a0,a5
 480:	02813083          	ld	ra,40(sp)
 484:	02013403          	ld	s0,32(sp)
 488:	03010113          	addi	sp,sp,48
 48c:	00008067          	ret

Disassembly of section .text.print_dec_int:

0000000000000490 <print_dec_int>:
 490:	f9010113          	addi	sp,sp,-112
 494:	06113423          	sd	ra,104(sp)
 498:	06813023          	sd	s0,96(sp)
 49c:	07010413          	addi	s0,sp,112
 4a0:	faa43423          	sd	a0,-88(s0)
 4a4:	fab43023          	sd	a1,-96(s0)
 4a8:	00060793          	mv	a5,a2
 4ac:	f8d43823          	sd	a3,-112(s0)
 4b0:	f8f40fa3          	sb	a5,-97(s0)
 4b4:	f9f44783          	lbu	a5,-97(s0)
 4b8:	0ff7f793          	zext.b	a5,a5
 4bc:	02078663          	beqz	a5,4e8 <print_dec_int+0x58>
 4c0:	fa043703          	ld	a4,-96(s0)
 4c4:	fff00793          	li	a5,-1
 4c8:	03f79793          	slli	a5,a5,0x3f
 4cc:	00f71e63          	bne	a4,a5,4e8 <print_dec_int+0x58>
 4d0:	00001597          	auipc	a1,0x1
 4d4:	da058593          	addi	a1,a1,-608 # 1270 <printf+0x2c4>
 4d8:	fa843503          	ld	a0,-88(s0)
 4dc:	f2dff0ef          	jal	408 <puts_wo_nl>
 4e0:	00050793          	mv	a5,a0
 4e4:	2c80006f          	j	7ac <print_dec_int+0x31c>
 4e8:	f9043783          	ld	a5,-112(s0)
 4ec:	00c7a783          	lw	a5,12(a5)
 4f0:	00079a63          	bnez	a5,504 <print_dec_int+0x74>
 4f4:	fa043783          	ld	a5,-96(s0)
 4f8:	00079663          	bnez	a5,504 <print_dec_int+0x74>
 4fc:	00000793          	li	a5,0
 500:	2ac0006f          	j	7ac <print_dec_int+0x31c>
 504:	fe0407a3          	sb	zero,-17(s0)
 508:	f9f44783          	lbu	a5,-97(s0)
 50c:	0ff7f793          	zext.b	a5,a5
 510:	02078063          	beqz	a5,530 <print_dec_int+0xa0>
 514:	fa043783          	ld	a5,-96(s0)
 518:	0007dc63          	bgez	a5,530 <print_dec_int+0xa0>
 51c:	00100793          	li	a5,1
 520:	fef407a3          	sb	a5,-17(s0)
 524:	fa043783          	ld	a5,-96(s0)
 528:	40f007b3          	neg	a5,a5
 52c:	faf43023          	sd	a5,-96(s0)
 530:	fe042423          	sw	zero,-24(s0)
 534:	f9f44783          	lbu	a5,-97(s0)
 538:	0ff7f793          	zext.b	a5,a5
 53c:	02078863          	beqz	a5,56c <print_dec_int+0xdc>
 540:	fef44783          	lbu	a5,-17(s0)
 544:	0ff7f793          	zext.b	a5,a5
 548:	00079e63          	bnez	a5,564 <print_dec_int+0xd4>
 54c:	f9043783          	ld	a5,-112(s0)
 550:	0057c783          	lbu	a5,5(a5)
 554:	00079863          	bnez	a5,564 <print_dec_int+0xd4>
 558:	f9043783          	ld	a5,-112(s0)
 55c:	0047c783          	lbu	a5,4(a5)
 560:	00078663          	beqz	a5,56c <print_dec_int+0xdc>
 564:	00100793          	li	a5,1
 568:	0080006f          	j	570 <print_dec_int+0xe0>
 56c:	00000793          	li	a5,0
 570:	fcf40ba3          	sb	a5,-41(s0)
 574:	fd744783          	lbu	a5,-41(s0)
 578:	0017f793          	andi	a5,a5,1
 57c:	fcf40ba3          	sb	a5,-41(s0)
 580:	fa043683          	ld	a3,-96(s0)
 584:	00001797          	auipc	a5,0x1
 588:	d0478793          	addi	a5,a5,-764 # 1288 <printf+0x2dc>
 58c:	0007b783          	ld	a5,0(a5)
 590:	02f6b7b3          	mulhu	a5,a3,a5
 594:	0037d713          	srli	a4,a5,0x3
 598:	00070793          	mv	a5,a4
 59c:	00279793          	slli	a5,a5,0x2
 5a0:	00e787b3          	add	a5,a5,a4
 5a4:	00179793          	slli	a5,a5,0x1
 5a8:	40f68733          	sub	a4,a3,a5
 5ac:	0ff77713          	zext.b	a4,a4
 5b0:	fe842783          	lw	a5,-24(s0)
 5b4:	0017869b          	addiw	a3,a5,1
 5b8:	fed42423          	sw	a3,-24(s0)
 5bc:	0307071b          	addiw	a4,a4,48
 5c0:	0ff77713          	zext.b	a4,a4
 5c4:	ff078793          	addi	a5,a5,-16
 5c8:	008787b3          	add	a5,a5,s0
 5cc:	fce78423          	sb	a4,-56(a5)
 5d0:	fa043703          	ld	a4,-96(s0)
 5d4:	00001797          	auipc	a5,0x1
 5d8:	cb478793          	addi	a5,a5,-844 # 1288 <printf+0x2dc>
 5dc:	0007b783          	ld	a5,0(a5)
 5e0:	02f737b3          	mulhu	a5,a4,a5
 5e4:	0037d793          	srli	a5,a5,0x3
 5e8:	faf43023          	sd	a5,-96(s0)
 5ec:	fa043783          	ld	a5,-96(s0)
 5f0:	f80798e3          	bnez	a5,580 <print_dec_int+0xf0>
 5f4:	f9043783          	ld	a5,-112(s0)
 5f8:	00c7a703          	lw	a4,12(a5)
 5fc:	fff00793          	li	a5,-1
 600:	02f71063          	bne	a4,a5,620 <print_dec_int+0x190>
 604:	f9043783          	ld	a5,-112(s0)
 608:	0037c783          	lbu	a5,3(a5)
 60c:	00078a63          	beqz	a5,620 <print_dec_int+0x190>
 610:	f9043783          	ld	a5,-112(s0)
 614:	0087a703          	lw	a4,8(a5)
 618:	f9043783          	ld	a5,-112(s0)
 61c:	00e7a623          	sw	a4,12(a5)
 620:	fe042223          	sw	zero,-28(s0)
 624:	f9043783          	ld	a5,-112(s0)
 628:	0087a703          	lw	a4,8(a5)
 62c:	fe842783          	lw	a5,-24(s0)
 630:	fcf42823          	sw	a5,-48(s0)
 634:	f9043783          	ld	a5,-112(s0)
 638:	00c7a783          	lw	a5,12(a5)
 63c:	fcf42623          	sw	a5,-52(s0)
 640:	fd042783          	lw	a5,-48(s0)
 644:	00078593          	mv	a1,a5
 648:	fcc42783          	lw	a5,-52(s0)
 64c:	00078613          	mv	a2,a5
 650:	0006069b          	sext.w	a3,a2
 654:	0005879b          	sext.w	a5,a1
 658:	00f6d463          	bge	a3,a5,660 <print_dec_int+0x1d0>
 65c:	00058613          	mv	a2,a1
 660:	0006079b          	sext.w	a5,a2
 664:	40f707bb          	subw	a5,a4,a5
 668:	0007871b          	sext.w	a4,a5
 66c:	fd744783          	lbu	a5,-41(s0)
 670:	0007879b          	sext.w	a5,a5
 674:	40f707bb          	subw	a5,a4,a5
 678:	fef42023          	sw	a5,-32(s0)
 67c:	0280006f          	j	6a4 <print_dec_int+0x214>
 680:	fa843783          	ld	a5,-88(s0)
 684:	02000513          	li	a0,32
 688:	000780e7          	jalr	a5
 68c:	fe442783          	lw	a5,-28(s0)
 690:	0017879b          	addiw	a5,a5,1
 694:	fef42223          	sw	a5,-28(s0)
 698:	fe042783          	lw	a5,-32(s0)
 69c:	fff7879b          	addiw	a5,a5,-1
 6a0:	fef42023          	sw	a5,-32(s0)
 6a4:	fe042783          	lw	a5,-32(s0)
 6a8:	0007879b          	sext.w	a5,a5
 6ac:	fcf04ae3          	bgtz	a5,680 <print_dec_int+0x1f0>
 6b0:	fd744783          	lbu	a5,-41(s0)
 6b4:	0ff7f793          	zext.b	a5,a5
 6b8:	04078463          	beqz	a5,700 <print_dec_int+0x270>
 6bc:	fef44783          	lbu	a5,-17(s0)
 6c0:	0ff7f793          	zext.b	a5,a5
 6c4:	00078663          	beqz	a5,6d0 <print_dec_int+0x240>
 6c8:	02d00793          	li	a5,45
 6cc:	01c0006f          	j	6e8 <print_dec_int+0x258>
 6d0:	f9043783          	ld	a5,-112(s0)
 6d4:	0057c783          	lbu	a5,5(a5)
 6d8:	00078663          	beqz	a5,6e4 <print_dec_int+0x254>
 6dc:	02b00793          	li	a5,43
 6e0:	0080006f          	j	6e8 <print_dec_int+0x258>
 6e4:	02000793          	li	a5,32
 6e8:	fa843703          	ld	a4,-88(s0)
 6ec:	00078513          	mv	a0,a5
 6f0:	000700e7          	jalr	a4
 6f4:	fe442783          	lw	a5,-28(s0)
 6f8:	0017879b          	addiw	a5,a5,1
 6fc:	fef42223          	sw	a5,-28(s0)
 700:	fe842783          	lw	a5,-24(s0)
 704:	fcf42e23          	sw	a5,-36(s0)
 708:	0280006f          	j	730 <print_dec_int+0x2a0>
 70c:	fa843783          	ld	a5,-88(s0)
 710:	03000513          	li	a0,48
 714:	000780e7          	jalr	a5
 718:	fe442783          	lw	a5,-28(s0)
 71c:	0017879b          	addiw	a5,a5,1
 720:	fef42223          	sw	a5,-28(s0)
 724:	fdc42783          	lw	a5,-36(s0)
 728:	0017879b          	addiw	a5,a5,1
 72c:	fcf42e23          	sw	a5,-36(s0)
 730:	f9043783          	ld	a5,-112(s0)
 734:	00c7a703          	lw	a4,12(a5)
 738:	fd744783          	lbu	a5,-41(s0)
 73c:	0007879b          	sext.w	a5,a5
 740:	40f707bb          	subw	a5,a4,a5
 744:	0007879b          	sext.w	a5,a5
 748:	fdc42703          	lw	a4,-36(s0)
 74c:	0007071b          	sext.w	a4,a4
 750:	faf74ee3          	blt	a4,a5,70c <print_dec_int+0x27c>
 754:	fe842783          	lw	a5,-24(s0)
 758:	fff7879b          	addiw	a5,a5,-1
 75c:	fcf42c23          	sw	a5,-40(s0)
 760:	03c0006f          	j	79c <print_dec_int+0x30c>
 764:	fd842783          	lw	a5,-40(s0)
 768:	ff078793          	addi	a5,a5,-16
 76c:	008787b3          	add	a5,a5,s0
 770:	fc87c783          	lbu	a5,-56(a5)
 774:	0007871b          	sext.w	a4,a5
 778:	fa843783          	ld	a5,-88(s0)
 77c:	00070513          	mv	a0,a4
 780:	000780e7          	jalr	a5
 784:	fe442783          	lw	a5,-28(s0)
 788:	0017879b          	addiw	a5,a5,1
 78c:	fef42223          	sw	a5,-28(s0)
 790:	fd842783          	lw	a5,-40(s0)
 794:	fff7879b          	addiw	a5,a5,-1
 798:	fcf42c23          	sw	a5,-40(s0)
 79c:	fd842783          	lw	a5,-40(s0)
 7a0:	0007879b          	sext.w	a5,a5
 7a4:	fc07d0e3          	bgez	a5,764 <print_dec_int+0x2d4>
 7a8:	fe442783          	lw	a5,-28(s0)
 7ac:	00078513          	mv	a0,a5
 7b0:	06813083          	ld	ra,104(sp)
 7b4:	06013403          	ld	s0,96(sp)
 7b8:	07010113          	addi	sp,sp,112
 7bc:	00008067          	ret

Disassembly of section .text.vprintfmt:

00000000000007c0 <vprintfmt>:
 7c0:	f4010113          	addi	sp,sp,-192
 7c4:	0a113c23          	sd	ra,184(sp)
 7c8:	0a813823          	sd	s0,176(sp)
 7cc:	0c010413          	addi	s0,sp,192
 7d0:	f4a43c23          	sd	a0,-168(s0)
 7d4:	f4b43823          	sd	a1,-176(s0)
 7d8:	f4c43423          	sd	a2,-184(s0)
 7dc:	f8043023          	sd	zero,-128(s0)
 7e0:	f8043423          	sd	zero,-120(s0)
 7e4:	fe042623          	sw	zero,-20(s0)
 7e8:	7a00006f          	j	f88 <vprintfmt+0x7c8>
 7ec:	f8044783          	lbu	a5,-128(s0)
 7f0:	72078c63          	beqz	a5,f28 <vprintfmt+0x768>
 7f4:	f5043783          	ld	a5,-176(s0)
 7f8:	0007c783          	lbu	a5,0(a5)
 7fc:	00078713          	mv	a4,a5
 800:	02300793          	li	a5,35
 804:	00f71863          	bne	a4,a5,814 <vprintfmt+0x54>
 808:	00100793          	li	a5,1
 80c:	f8f40123          	sb	a5,-126(s0)
 810:	76c0006f          	j	f7c <vprintfmt+0x7bc>
 814:	f5043783          	ld	a5,-176(s0)
 818:	0007c783          	lbu	a5,0(a5)
 81c:	00078713          	mv	a4,a5
 820:	03000793          	li	a5,48
 824:	00f71863          	bne	a4,a5,834 <vprintfmt+0x74>
 828:	00100793          	li	a5,1
 82c:	f8f401a3          	sb	a5,-125(s0)
 830:	74c0006f          	j	f7c <vprintfmt+0x7bc>
 834:	f5043783          	ld	a5,-176(s0)
 838:	0007c783          	lbu	a5,0(a5)
 83c:	00078713          	mv	a4,a5
 840:	06c00793          	li	a5,108
 844:	04f70063          	beq	a4,a5,884 <vprintfmt+0xc4>
 848:	f5043783          	ld	a5,-176(s0)
 84c:	0007c783          	lbu	a5,0(a5)
 850:	00078713          	mv	a4,a5
 854:	07a00793          	li	a5,122
 858:	02f70663          	beq	a4,a5,884 <vprintfmt+0xc4>
 85c:	f5043783          	ld	a5,-176(s0)
 860:	0007c783          	lbu	a5,0(a5)
 864:	00078713          	mv	a4,a5
 868:	07400793          	li	a5,116
 86c:	00f70c63          	beq	a4,a5,884 <vprintfmt+0xc4>
 870:	f5043783          	ld	a5,-176(s0)
 874:	0007c783          	lbu	a5,0(a5)
 878:	00078713          	mv	a4,a5
 87c:	06a00793          	li	a5,106
 880:	00f71863          	bne	a4,a5,890 <vprintfmt+0xd0>
 884:	00100793          	li	a5,1
 888:	f8f400a3          	sb	a5,-127(s0)
 88c:	6f00006f          	j	f7c <vprintfmt+0x7bc>
 890:	f5043783          	ld	a5,-176(s0)
 894:	0007c783          	lbu	a5,0(a5)
 898:	00078713          	mv	a4,a5
 89c:	02b00793          	li	a5,43
 8a0:	00f71863          	bne	a4,a5,8b0 <vprintfmt+0xf0>
 8a4:	00100793          	li	a5,1
 8a8:	f8f402a3          	sb	a5,-123(s0)
 8ac:	6d00006f          	j	f7c <vprintfmt+0x7bc>
 8b0:	f5043783          	ld	a5,-176(s0)
 8b4:	0007c783          	lbu	a5,0(a5)
 8b8:	00078713          	mv	a4,a5
 8bc:	02000793          	li	a5,32
 8c0:	00f71863          	bne	a4,a5,8d0 <vprintfmt+0x110>
 8c4:	00100793          	li	a5,1
 8c8:	f8f40223          	sb	a5,-124(s0)
 8cc:	6b00006f          	j	f7c <vprintfmt+0x7bc>
 8d0:	f5043783          	ld	a5,-176(s0)
 8d4:	0007c783          	lbu	a5,0(a5)
 8d8:	00078713          	mv	a4,a5
 8dc:	02a00793          	li	a5,42
 8e0:	00f71e63          	bne	a4,a5,8fc <vprintfmt+0x13c>
 8e4:	f4843783          	ld	a5,-184(s0)
 8e8:	00878713          	addi	a4,a5,8
 8ec:	f4e43423          	sd	a4,-184(s0)
 8f0:	0007a783          	lw	a5,0(a5)
 8f4:	f8f42423          	sw	a5,-120(s0)
 8f8:	6840006f          	j	f7c <vprintfmt+0x7bc>
 8fc:	f5043783          	ld	a5,-176(s0)
 900:	0007c783          	lbu	a5,0(a5)
 904:	00078713          	mv	a4,a5
 908:	03000793          	li	a5,48
 90c:	04e7f663          	bgeu	a5,a4,958 <vprintfmt+0x198>
 910:	f5043783          	ld	a5,-176(s0)
 914:	0007c783          	lbu	a5,0(a5)
 918:	00078713          	mv	a4,a5
 91c:	03900793          	li	a5,57
 920:	02e7ec63          	bltu	a5,a4,958 <vprintfmt+0x198>
 924:	f5043783          	ld	a5,-176(s0)
 928:	f5040713          	addi	a4,s0,-176
 92c:	00a00613          	li	a2,10
 930:	00070593          	mv	a1,a4
 934:	00078513          	mv	a0,a5
 938:	865ff0ef          	jal	19c <strtol>
 93c:	00050793          	mv	a5,a0
 940:	0007879b          	sext.w	a5,a5
 944:	f8f42423          	sw	a5,-120(s0)
 948:	f5043783          	ld	a5,-176(s0)
 94c:	fff78793          	addi	a5,a5,-1
 950:	f4f43823          	sd	a5,-176(s0)
 954:	6280006f          	j	f7c <vprintfmt+0x7bc>
 958:	f5043783          	ld	a5,-176(s0)
 95c:	0007c783          	lbu	a5,0(a5)
 960:	00078713          	mv	a4,a5
 964:	02e00793          	li	a5,46
 968:	06f71863          	bne	a4,a5,9d8 <vprintfmt+0x218>
 96c:	f5043783          	ld	a5,-176(s0)
 970:	00178793          	addi	a5,a5,1
 974:	f4f43823          	sd	a5,-176(s0)
 978:	f5043783          	ld	a5,-176(s0)
 97c:	0007c783          	lbu	a5,0(a5)
 980:	00078713          	mv	a4,a5
 984:	02a00793          	li	a5,42
 988:	00f71e63          	bne	a4,a5,9a4 <vprintfmt+0x1e4>
 98c:	f4843783          	ld	a5,-184(s0)
 990:	00878713          	addi	a4,a5,8
 994:	f4e43423          	sd	a4,-184(s0)
 998:	0007a783          	lw	a5,0(a5)
 99c:	f8f42623          	sw	a5,-116(s0)
 9a0:	5dc0006f          	j	f7c <vprintfmt+0x7bc>
 9a4:	f5043783          	ld	a5,-176(s0)
 9a8:	f5040713          	addi	a4,s0,-176
 9ac:	00a00613          	li	a2,10
 9b0:	00070593          	mv	a1,a4
 9b4:	00078513          	mv	a0,a5
 9b8:	fe4ff0ef          	jal	19c <strtol>
 9bc:	00050793          	mv	a5,a0
 9c0:	0007879b          	sext.w	a5,a5
 9c4:	f8f42623          	sw	a5,-116(s0)
 9c8:	f5043783          	ld	a5,-176(s0)
 9cc:	fff78793          	addi	a5,a5,-1
 9d0:	f4f43823          	sd	a5,-176(s0)
 9d4:	5a80006f          	j	f7c <vprintfmt+0x7bc>
 9d8:	f5043783          	ld	a5,-176(s0)
 9dc:	0007c783          	lbu	a5,0(a5)
 9e0:	00078713          	mv	a4,a5
 9e4:	07800793          	li	a5,120
 9e8:	02f70663          	beq	a4,a5,a14 <vprintfmt+0x254>
 9ec:	f5043783          	ld	a5,-176(s0)
 9f0:	0007c783          	lbu	a5,0(a5)
 9f4:	00078713          	mv	a4,a5
 9f8:	05800793          	li	a5,88
 9fc:	00f70c63          	beq	a4,a5,a14 <vprintfmt+0x254>
 a00:	f5043783          	ld	a5,-176(s0)
 a04:	0007c783          	lbu	a5,0(a5)
 a08:	00078713          	mv	a4,a5
 a0c:	07000793          	li	a5,112
 a10:	30f71063          	bne	a4,a5,d10 <vprintfmt+0x550>
 a14:	f5043783          	ld	a5,-176(s0)
 a18:	0007c783          	lbu	a5,0(a5)
 a1c:	00078713          	mv	a4,a5
 a20:	07000793          	li	a5,112
 a24:	00f70663          	beq	a4,a5,a30 <vprintfmt+0x270>
 a28:	f8144783          	lbu	a5,-127(s0)
 a2c:	00078663          	beqz	a5,a38 <vprintfmt+0x278>
 a30:	00100793          	li	a5,1
 a34:	0080006f          	j	a3c <vprintfmt+0x27c>
 a38:	00000793          	li	a5,0
 a3c:	faf403a3          	sb	a5,-89(s0)
 a40:	fa744783          	lbu	a5,-89(s0)
 a44:	0017f793          	andi	a5,a5,1
 a48:	faf403a3          	sb	a5,-89(s0)
 a4c:	fa744783          	lbu	a5,-89(s0)
 a50:	0ff7f793          	zext.b	a5,a5
 a54:	00078c63          	beqz	a5,a6c <vprintfmt+0x2ac>
 a58:	f4843783          	ld	a5,-184(s0)
 a5c:	00878713          	addi	a4,a5,8
 a60:	f4e43423          	sd	a4,-184(s0)
 a64:	0007b783          	ld	a5,0(a5)
 a68:	01c0006f          	j	a84 <vprintfmt+0x2c4>
 a6c:	f4843783          	ld	a5,-184(s0)
 a70:	00878713          	addi	a4,a5,8
 a74:	f4e43423          	sd	a4,-184(s0)
 a78:	0007a783          	lw	a5,0(a5)
 a7c:	02079793          	slli	a5,a5,0x20
 a80:	0207d793          	srli	a5,a5,0x20
 a84:	fef43023          	sd	a5,-32(s0)
 a88:	f8c42783          	lw	a5,-116(s0)
 a8c:	02079463          	bnez	a5,ab4 <vprintfmt+0x2f4>
 a90:	fe043783          	ld	a5,-32(s0)
 a94:	02079063          	bnez	a5,ab4 <vprintfmt+0x2f4>
 a98:	f5043783          	ld	a5,-176(s0)
 a9c:	0007c783          	lbu	a5,0(a5)
 aa0:	00078713          	mv	a4,a5
 aa4:	07000793          	li	a5,112
 aa8:	00f70663          	beq	a4,a5,ab4 <vprintfmt+0x2f4>
 aac:	f8040023          	sb	zero,-128(s0)
 ab0:	4cc0006f          	j	f7c <vprintfmt+0x7bc>
 ab4:	f5043783          	ld	a5,-176(s0)
 ab8:	0007c783          	lbu	a5,0(a5)
 abc:	00078713          	mv	a4,a5
 ac0:	07000793          	li	a5,112
 ac4:	00f70a63          	beq	a4,a5,ad8 <vprintfmt+0x318>
 ac8:	f8244783          	lbu	a5,-126(s0)
 acc:	00078a63          	beqz	a5,ae0 <vprintfmt+0x320>
 ad0:	fe043783          	ld	a5,-32(s0)
 ad4:	00078663          	beqz	a5,ae0 <vprintfmt+0x320>
 ad8:	00100793          	li	a5,1
 adc:	0080006f          	j	ae4 <vprintfmt+0x324>
 ae0:	00000793          	li	a5,0
 ae4:	faf40323          	sb	a5,-90(s0)
 ae8:	fa644783          	lbu	a5,-90(s0)
 aec:	0017f793          	andi	a5,a5,1
 af0:	faf40323          	sb	a5,-90(s0)
 af4:	fc042e23          	sw	zero,-36(s0)
 af8:	f5043783          	ld	a5,-176(s0)
 afc:	0007c783          	lbu	a5,0(a5)
 b00:	00078713          	mv	a4,a5
 b04:	05800793          	li	a5,88
 b08:	00f71863          	bne	a4,a5,b18 <vprintfmt+0x358>
 b0c:	00000797          	auipc	a5,0x0
 b10:	78478793          	addi	a5,a5,1924 # 1290 <upperxdigits.1>
 b14:	00c0006f          	j	b20 <vprintfmt+0x360>
 b18:	00000797          	auipc	a5,0x0
 b1c:	79078793          	addi	a5,a5,1936 # 12a8 <lowerxdigits.0>
 b20:	f8f43c23          	sd	a5,-104(s0)
 b24:	fe043783          	ld	a5,-32(s0)
 b28:	00f7f793          	andi	a5,a5,15
 b2c:	f9843703          	ld	a4,-104(s0)
 b30:	00f70733          	add	a4,a4,a5
 b34:	fdc42783          	lw	a5,-36(s0)
 b38:	0017869b          	addiw	a3,a5,1
 b3c:	fcd42e23          	sw	a3,-36(s0)
 b40:	00074703          	lbu	a4,0(a4)
 b44:	ff078793          	addi	a5,a5,-16
 b48:	008787b3          	add	a5,a5,s0
 b4c:	f8e78023          	sb	a4,-128(a5)
 b50:	fe043783          	ld	a5,-32(s0)
 b54:	0047d793          	srli	a5,a5,0x4
 b58:	fef43023          	sd	a5,-32(s0)
 b5c:	fe043783          	ld	a5,-32(s0)
 b60:	fc0792e3          	bnez	a5,b24 <vprintfmt+0x364>
 b64:	f8c42703          	lw	a4,-116(s0)
 b68:	fff00793          	li	a5,-1
 b6c:	02f71663          	bne	a4,a5,b98 <vprintfmt+0x3d8>
 b70:	f8344783          	lbu	a5,-125(s0)
 b74:	02078263          	beqz	a5,b98 <vprintfmt+0x3d8>
 b78:	f8842703          	lw	a4,-120(s0)
 b7c:	fa644783          	lbu	a5,-90(s0)
 b80:	0007879b          	sext.w	a5,a5
 b84:	0017979b          	slliw	a5,a5,0x1
 b88:	0007879b          	sext.w	a5,a5
 b8c:	40f707bb          	subw	a5,a4,a5
 b90:	0007879b          	sext.w	a5,a5
 b94:	f8f42623          	sw	a5,-116(s0)
 b98:	f8842703          	lw	a4,-120(s0)
 b9c:	fa644783          	lbu	a5,-90(s0)
 ba0:	0007879b          	sext.w	a5,a5
 ba4:	0017979b          	slliw	a5,a5,0x1
 ba8:	0007879b          	sext.w	a5,a5
 bac:	40f707bb          	subw	a5,a4,a5
 bb0:	0007871b          	sext.w	a4,a5
 bb4:	fdc42783          	lw	a5,-36(s0)
 bb8:	f8f42a23          	sw	a5,-108(s0)
 bbc:	f8c42783          	lw	a5,-116(s0)
 bc0:	f8f42823          	sw	a5,-112(s0)
 bc4:	f9442783          	lw	a5,-108(s0)
 bc8:	00078593          	mv	a1,a5
 bcc:	f9042783          	lw	a5,-112(s0)
 bd0:	00078613          	mv	a2,a5
 bd4:	0006069b          	sext.w	a3,a2
 bd8:	0005879b          	sext.w	a5,a1
 bdc:	00f6d463          	bge	a3,a5,be4 <vprintfmt+0x424>
 be0:	00058613          	mv	a2,a1
 be4:	0006079b          	sext.w	a5,a2
 be8:	40f707bb          	subw	a5,a4,a5
 bec:	fcf42c23          	sw	a5,-40(s0)
 bf0:	0280006f          	j	c18 <vprintfmt+0x458>
 bf4:	f5843783          	ld	a5,-168(s0)
 bf8:	02000513          	li	a0,32
 bfc:	000780e7          	jalr	a5
 c00:	fec42783          	lw	a5,-20(s0)
 c04:	0017879b          	addiw	a5,a5,1
 c08:	fef42623          	sw	a5,-20(s0)
 c0c:	fd842783          	lw	a5,-40(s0)
 c10:	fff7879b          	addiw	a5,a5,-1
 c14:	fcf42c23          	sw	a5,-40(s0)
 c18:	fd842783          	lw	a5,-40(s0)
 c1c:	0007879b          	sext.w	a5,a5
 c20:	fcf04ae3          	bgtz	a5,bf4 <vprintfmt+0x434>
 c24:	fa644783          	lbu	a5,-90(s0)
 c28:	0ff7f793          	zext.b	a5,a5
 c2c:	04078463          	beqz	a5,c74 <vprintfmt+0x4b4>
 c30:	f5843783          	ld	a5,-168(s0)
 c34:	03000513          	li	a0,48
 c38:	000780e7          	jalr	a5
 c3c:	f5043783          	ld	a5,-176(s0)
 c40:	0007c783          	lbu	a5,0(a5)
 c44:	00078713          	mv	a4,a5
 c48:	05800793          	li	a5,88
 c4c:	00f71663          	bne	a4,a5,c58 <vprintfmt+0x498>
 c50:	05800793          	li	a5,88
 c54:	0080006f          	j	c5c <vprintfmt+0x49c>
 c58:	07800793          	li	a5,120
 c5c:	f5843703          	ld	a4,-168(s0)
 c60:	00078513          	mv	a0,a5
 c64:	000700e7          	jalr	a4
 c68:	fec42783          	lw	a5,-20(s0)
 c6c:	0027879b          	addiw	a5,a5,2
 c70:	fef42623          	sw	a5,-20(s0)
 c74:	fdc42783          	lw	a5,-36(s0)
 c78:	fcf42a23          	sw	a5,-44(s0)
 c7c:	0280006f          	j	ca4 <vprintfmt+0x4e4>
 c80:	f5843783          	ld	a5,-168(s0)
 c84:	03000513          	li	a0,48
 c88:	000780e7          	jalr	a5
 c8c:	fec42783          	lw	a5,-20(s0)
 c90:	0017879b          	addiw	a5,a5,1
 c94:	fef42623          	sw	a5,-20(s0)
 c98:	fd442783          	lw	a5,-44(s0)
 c9c:	0017879b          	addiw	a5,a5,1
 ca0:	fcf42a23          	sw	a5,-44(s0)
 ca4:	f8c42783          	lw	a5,-116(s0)
 ca8:	fd442703          	lw	a4,-44(s0)
 cac:	0007071b          	sext.w	a4,a4
 cb0:	fcf748e3          	blt	a4,a5,c80 <vprintfmt+0x4c0>
 cb4:	fdc42783          	lw	a5,-36(s0)
 cb8:	fff7879b          	addiw	a5,a5,-1
 cbc:	fcf42823          	sw	a5,-48(s0)
 cc0:	03c0006f          	j	cfc <vprintfmt+0x53c>
 cc4:	fd042783          	lw	a5,-48(s0)
 cc8:	ff078793          	addi	a5,a5,-16
 ccc:	008787b3          	add	a5,a5,s0
 cd0:	f807c783          	lbu	a5,-128(a5)
 cd4:	0007871b          	sext.w	a4,a5
 cd8:	f5843783          	ld	a5,-168(s0)
 cdc:	00070513          	mv	a0,a4
 ce0:	000780e7          	jalr	a5
 ce4:	fec42783          	lw	a5,-20(s0)
 ce8:	0017879b          	addiw	a5,a5,1
 cec:	fef42623          	sw	a5,-20(s0)
 cf0:	fd042783          	lw	a5,-48(s0)
 cf4:	fff7879b          	addiw	a5,a5,-1
 cf8:	fcf42823          	sw	a5,-48(s0)
 cfc:	fd042783          	lw	a5,-48(s0)
 d00:	0007879b          	sext.w	a5,a5
 d04:	fc07d0e3          	bgez	a5,cc4 <vprintfmt+0x504>
 d08:	f8040023          	sb	zero,-128(s0)
 d0c:	2700006f          	j	f7c <vprintfmt+0x7bc>
 d10:	f5043783          	ld	a5,-176(s0)
 d14:	0007c783          	lbu	a5,0(a5)
 d18:	00078713          	mv	a4,a5
 d1c:	06400793          	li	a5,100
 d20:	02f70663          	beq	a4,a5,d4c <vprintfmt+0x58c>
 d24:	f5043783          	ld	a5,-176(s0)
 d28:	0007c783          	lbu	a5,0(a5)
 d2c:	00078713          	mv	a4,a5
 d30:	06900793          	li	a5,105
 d34:	00f70c63          	beq	a4,a5,d4c <vprintfmt+0x58c>
 d38:	f5043783          	ld	a5,-176(s0)
 d3c:	0007c783          	lbu	a5,0(a5)
 d40:	00078713          	mv	a4,a5
 d44:	07500793          	li	a5,117
 d48:	08f71063          	bne	a4,a5,dc8 <vprintfmt+0x608>
 d4c:	f8144783          	lbu	a5,-127(s0)
 d50:	00078c63          	beqz	a5,d68 <vprintfmt+0x5a8>
 d54:	f4843783          	ld	a5,-184(s0)
 d58:	00878713          	addi	a4,a5,8
 d5c:	f4e43423          	sd	a4,-184(s0)
 d60:	0007b783          	ld	a5,0(a5)
 d64:	0140006f          	j	d78 <vprintfmt+0x5b8>
 d68:	f4843783          	ld	a5,-184(s0)
 d6c:	00878713          	addi	a4,a5,8
 d70:	f4e43423          	sd	a4,-184(s0)
 d74:	0007a783          	lw	a5,0(a5)
 d78:	faf43423          	sd	a5,-88(s0)
 d7c:	fa843583          	ld	a1,-88(s0)
 d80:	f5043783          	ld	a5,-176(s0)
 d84:	0007c783          	lbu	a5,0(a5)
 d88:	0007871b          	sext.w	a4,a5
 d8c:	07500793          	li	a5,117
 d90:	40f707b3          	sub	a5,a4,a5
 d94:	00f037b3          	snez	a5,a5
 d98:	0ff7f793          	zext.b	a5,a5
 d9c:	f8040713          	addi	a4,s0,-128
 da0:	00070693          	mv	a3,a4
 da4:	00078613          	mv	a2,a5
 da8:	f5843503          	ld	a0,-168(s0)
 dac:	ee4ff0ef          	jal	490 <print_dec_int>
 db0:	00050793          	mv	a5,a0
 db4:	fec42703          	lw	a4,-20(s0)
 db8:	00f707bb          	addw	a5,a4,a5
 dbc:	fef42623          	sw	a5,-20(s0)
 dc0:	f8040023          	sb	zero,-128(s0)
 dc4:	1b80006f          	j	f7c <vprintfmt+0x7bc>
 dc8:	f5043783          	ld	a5,-176(s0)
 dcc:	0007c783          	lbu	a5,0(a5)
 dd0:	00078713          	mv	a4,a5
 dd4:	06e00793          	li	a5,110
 dd8:	04f71c63          	bne	a4,a5,e30 <vprintfmt+0x670>
 ddc:	f8144783          	lbu	a5,-127(s0)
 de0:	02078463          	beqz	a5,e08 <vprintfmt+0x648>
 de4:	f4843783          	ld	a5,-184(s0)
 de8:	00878713          	addi	a4,a5,8
 dec:	f4e43423          	sd	a4,-184(s0)
 df0:	0007b783          	ld	a5,0(a5)
 df4:	faf43823          	sd	a5,-80(s0)
 df8:	fec42703          	lw	a4,-20(s0)
 dfc:	fb043783          	ld	a5,-80(s0)
 e00:	00e7b023          	sd	a4,0(a5)
 e04:	0240006f          	j	e28 <vprintfmt+0x668>
 e08:	f4843783          	ld	a5,-184(s0)
 e0c:	00878713          	addi	a4,a5,8
 e10:	f4e43423          	sd	a4,-184(s0)
 e14:	0007b783          	ld	a5,0(a5)
 e18:	faf43c23          	sd	a5,-72(s0)
 e1c:	fb843783          	ld	a5,-72(s0)
 e20:	fec42703          	lw	a4,-20(s0)
 e24:	00e7a023          	sw	a4,0(a5)
 e28:	f8040023          	sb	zero,-128(s0)
 e2c:	1500006f          	j	f7c <vprintfmt+0x7bc>
 e30:	f5043783          	ld	a5,-176(s0)
 e34:	0007c783          	lbu	a5,0(a5)
 e38:	00078713          	mv	a4,a5
 e3c:	07300793          	li	a5,115
 e40:	02f71e63          	bne	a4,a5,e7c <vprintfmt+0x6bc>
 e44:	f4843783          	ld	a5,-184(s0)
 e48:	00878713          	addi	a4,a5,8
 e4c:	f4e43423          	sd	a4,-184(s0)
 e50:	0007b783          	ld	a5,0(a5)
 e54:	fcf43023          	sd	a5,-64(s0)
 e58:	fc043583          	ld	a1,-64(s0)
 e5c:	f5843503          	ld	a0,-168(s0)
 e60:	da8ff0ef          	jal	408 <puts_wo_nl>
 e64:	00050793          	mv	a5,a0
 e68:	fec42703          	lw	a4,-20(s0)
 e6c:	00f707bb          	addw	a5,a4,a5
 e70:	fef42623          	sw	a5,-20(s0)
 e74:	f8040023          	sb	zero,-128(s0)
 e78:	1040006f          	j	f7c <vprintfmt+0x7bc>
 e7c:	f5043783          	ld	a5,-176(s0)
 e80:	0007c783          	lbu	a5,0(a5)
 e84:	00078713          	mv	a4,a5
 e88:	06300793          	li	a5,99
 e8c:	02f71e63          	bne	a4,a5,ec8 <vprintfmt+0x708>
 e90:	f4843783          	ld	a5,-184(s0)
 e94:	00878713          	addi	a4,a5,8
 e98:	f4e43423          	sd	a4,-184(s0)
 e9c:	0007a783          	lw	a5,0(a5)
 ea0:	fcf42623          	sw	a5,-52(s0)
 ea4:	fcc42703          	lw	a4,-52(s0)
 ea8:	f5843783          	ld	a5,-168(s0)
 eac:	00070513          	mv	a0,a4
 eb0:	000780e7          	jalr	a5
 eb4:	fec42783          	lw	a5,-20(s0)
 eb8:	0017879b          	addiw	a5,a5,1
 ebc:	fef42623          	sw	a5,-20(s0)
 ec0:	f8040023          	sb	zero,-128(s0)
 ec4:	0b80006f          	j	f7c <vprintfmt+0x7bc>
 ec8:	f5043783          	ld	a5,-176(s0)
 ecc:	0007c783          	lbu	a5,0(a5)
 ed0:	00078713          	mv	a4,a5
 ed4:	02500793          	li	a5,37
 ed8:	02f71263          	bne	a4,a5,efc <vprintfmt+0x73c>
 edc:	f5843783          	ld	a5,-168(s0)
 ee0:	02500513          	li	a0,37
 ee4:	000780e7          	jalr	a5
 ee8:	fec42783          	lw	a5,-20(s0)
 eec:	0017879b          	addiw	a5,a5,1
 ef0:	fef42623          	sw	a5,-20(s0)
 ef4:	f8040023          	sb	zero,-128(s0)
 ef8:	0840006f          	j	f7c <vprintfmt+0x7bc>
 efc:	f5043783          	ld	a5,-176(s0)
 f00:	0007c783          	lbu	a5,0(a5)
 f04:	0007871b          	sext.w	a4,a5
 f08:	f5843783          	ld	a5,-168(s0)
 f0c:	00070513          	mv	a0,a4
 f10:	000780e7          	jalr	a5
 f14:	fec42783          	lw	a5,-20(s0)
 f18:	0017879b          	addiw	a5,a5,1
 f1c:	fef42623          	sw	a5,-20(s0)
 f20:	f8040023          	sb	zero,-128(s0)
 f24:	0580006f          	j	f7c <vprintfmt+0x7bc>
 f28:	f5043783          	ld	a5,-176(s0)
 f2c:	0007c783          	lbu	a5,0(a5)
 f30:	00078713          	mv	a4,a5
 f34:	02500793          	li	a5,37
 f38:	02f71063          	bne	a4,a5,f58 <vprintfmt+0x798>
 f3c:	f8043023          	sd	zero,-128(s0)
 f40:	f8043423          	sd	zero,-120(s0)
 f44:	00100793          	li	a5,1
 f48:	f8f40023          	sb	a5,-128(s0)
 f4c:	fff00793          	li	a5,-1
 f50:	f8f42623          	sw	a5,-116(s0)
 f54:	0280006f          	j	f7c <vprintfmt+0x7bc>
 f58:	f5043783          	ld	a5,-176(s0)
 f5c:	0007c783          	lbu	a5,0(a5)
 f60:	0007871b          	sext.w	a4,a5
 f64:	f5843783          	ld	a5,-168(s0)
 f68:	00070513          	mv	a0,a4
 f6c:	000780e7          	jalr	a5
 f70:	fec42783          	lw	a5,-20(s0)
 f74:	0017879b          	addiw	a5,a5,1
 f78:	fef42623          	sw	a5,-20(s0)
 f7c:	f5043783          	ld	a5,-176(s0)
 f80:	00178793          	addi	a5,a5,1
 f84:	f4f43823          	sd	a5,-176(s0)
 f88:	f5043783          	ld	a5,-176(s0)
 f8c:	0007c783          	lbu	a5,0(a5)
 f90:	84079ee3          	bnez	a5,7ec <vprintfmt+0x2c>
 f94:	fec42783          	lw	a5,-20(s0)
 f98:	00078513          	mv	a0,a5
 f9c:	0b813083          	ld	ra,184(sp)
 fa0:	0b013403          	ld	s0,176(sp)
 fa4:	0c010113          	addi	sp,sp,192
 fa8:	00008067          	ret

Disassembly of section .text.printf:

0000000000000fac <printf>:
     fac:	f8010113          	addi	sp,sp,-128
     fb0:	02113c23          	sd	ra,56(sp)
     fb4:	02813823          	sd	s0,48(sp)
     fb8:	04010413          	addi	s0,sp,64
     fbc:	fca43423          	sd	a0,-56(s0)
     fc0:	00b43423          	sd	a1,8(s0)
     fc4:	00c43823          	sd	a2,16(s0)
     fc8:	00d43c23          	sd	a3,24(s0)
     fcc:	02e43023          	sd	a4,32(s0)
     fd0:	02f43423          	sd	a5,40(s0)
     fd4:	03043823          	sd	a6,48(s0)
     fd8:	03143c23          	sd	a7,56(s0)
     fdc:	fe042623          	sw	zero,-20(s0)
     fe0:	04040793          	addi	a5,s0,64
     fe4:	fcf43023          	sd	a5,-64(s0)
     fe8:	fc043783          	ld	a5,-64(s0)
     fec:	fc878793          	addi	a5,a5,-56
     ff0:	fcf43823          	sd	a5,-48(s0)
     ff4:	fd043783          	ld	a5,-48(s0)
     ff8:	00078613          	mv	a2,a5
     ffc:	fc843583          	ld	a1,-56(s0)
    1000:	fffff517          	auipc	a0,0xfffff
    1004:	0c450513          	addi	a0,a0,196 # c4 <putc>
    1008:	fb8ff0ef          	jal	7c0 <vprintfmt>
    100c:	00050793          	mv	a5,a0
    1010:	fef42623          	sw	a5,-20(s0)
    1014:	00100793          	li	a5,1
    1018:	fef43023          	sd	a5,-32(s0)
    101c:	00000797          	auipc	a5,0x0
    1020:	2a478793          	addi	a5,a5,676 # 12c0 <tail>
    1024:	0007a783          	lw	a5,0(a5)
    1028:	0017871b          	addiw	a4,a5,1
    102c:	0007069b          	sext.w	a3,a4
    1030:	00000717          	auipc	a4,0x0
    1034:	29070713          	addi	a4,a4,656 # 12c0 <tail>
    1038:	00d72023          	sw	a3,0(a4)
    103c:	00000717          	auipc	a4,0x0
    1040:	28c70713          	addi	a4,a4,652 # 12c8 <buffer>
    1044:	00f707b3          	add	a5,a4,a5
    1048:	00078023          	sb	zero,0(a5)
    104c:	00000797          	auipc	a5,0x0
    1050:	27478793          	addi	a5,a5,628 # 12c0 <tail>
    1054:	0007a603          	lw	a2,0(a5)
    1058:	fe043703          	ld	a4,-32(s0)
    105c:	00000697          	auipc	a3,0x0
    1060:	26c68693          	addi	a3,a3,620 # 12c8 <buffer>
    1064:	fd843783          	ld	a5,-40(s0)
    1068:	04000893          	li	a7,64
    106c:	00070513          	mv	a0,a4
    1070:	00068593          	mv	a1,a3
    1074:	00060613          	mv	a2,a2
    1078:	00000073          	ecall
    107c:	00050793          	mv	a5,a0
    1080:	fcf43c23          	sd	a5,-40(s0)
    1084:	00000797          	auipc	a5,0x0
    1088:	23c78793          	addi	a5,a5,572 # 12c0 <tail>
    108c:	0007a023          	sw	zero,0(a5)
    1090:	fec42783          	lw	a5,-20(s0)
    1094:	00078513          	mv	a0,a5
    1098:	03813083          	ld	ra,56(sp)
    109c:	03013403          	ld	s0,48(sp)
    10a0:	08010113          	addi	sp,sp,128
    10a4:	00008067          	ret
