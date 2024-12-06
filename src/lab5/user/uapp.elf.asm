
uapp.elf:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000000000000 <_start>:
   0:	0d80006f          	j	d8 <main>

Disassembly of section .text.getpid:

0000000000000004 <getpid>:
   4:	fe010113          	addi	sp,sp,-32
   8:	00813c23          	sd	s0,24(sp)
   c:	02010413          	addi	s0,sp,32
  10:	fe843783          	ld	a5,-24(s0)
  14:	0ac00893          	li	a7,172
  18:	00000073          	ecall
  1c:	00050793          	mv	a5,a0
  20:	fef43423          	sd	a5,-24(s0)
  24:	fe843783          	ld	a5,-24(s0)
  28:	00078513          	mv	a0,a5
  2c:	01813403          	ld	s0,24(sp)
  30:	02010113          	addi	sp,sp,32
  34:	00008067          	ret

Disassembly of section .text.fork:

0000000000000038 <fork>:
  38:	fe010113          	addi	sp,sp,-32
  3c:	00113c23          	sd	ra,24(sp)
  40:	00813823          	sd	s0,16(sp)
  44:	02010413          	addi	s0,sp,32
  48:	fe843783          	ld	a5,-24(s0)
  4c:	0dc00893          	li	a7,220
  50:	00000073          	ecall
  54:	00050793          	mv	a5,a0
  58:	fef43423          	sd	a5,-24(s0)
  5c:	fe843583          	ld	a1,-24(s0)
  60:	00001517          	auipc	a0,0x1
  64:	2c850513          	addi	a0,a0,712 # 1328 <printf+0x2c4>
  68:	7fd000ef          	jal	1064 <printf>
  6c:	fe843783          	ld	a5,-24(s0)
  70:	00078513          	mv	a0,a5
  74:	01813083          	ld	ra,24(sp)
  78:	01013403          	ld	s0,16(sp)
  7c:	02010113          	addi	sp,sp,32
  80:	00008067          	ret

Disassembly of section .text.wait:

0000000000000084 <wait>:
  84:	fd010113          	addi	sp,sp,-48
  88:	02813423          	sd	s0,40(sp)
  8c:	03010413          	addi	s0,sp,48
  90:	00050793          	mv	a5,a0
  94:	fcf42e23          	sw	a5,-36(s0)
  98:	fe042623          	sw	zero,-20(s0)
  9c:	0100006f          	j	ac <wait+0x28>
  a0:	fec42783          	lw	a5,-20(s0)
  a4:	0017879b          	addiw	a5,a5,1
  a8:	fef42623          	sw	a5,-20(s0)
  ac:	fec42783          	lw	a5,-20(s0)
  b0:	00078713          	mv	a4,a5
  b4:	fdc42783          	lw	a5,-36(s0)
  b8:	0007071b          	sext.w	a4,a4
  bc:	0007879b          	sext.w	a5,a5
  c0:	fef760e3          	bltu	a4,a5,a0 <wait+0x1c>
  c4:	00000013          	nop
  c8:	00000013          	nop
  cc:	02813403          	ld	s0,40(sp)
  d0:	03010113          	addi	sp,sp,48
  d4:	00008067          	ret

Disassembly of section .text.main:

00000000000000d8 <main>:
  d8:	ff010113          	addi	sp,sp,-16
  dc:	00113423          	sd	ra,8(sp)
  e0:	00813023          	sd	s0,0(sp)
  e4:	01010413          	addi	s0,sp,16
  e8:	f1dff0ef          	jal	4 <getpid>
  ec:	00050593          	mv	a1,a0
  f0:	00001797          	auipc	a5,0x1
  f4:	2dc78793          	addi	a5,a5,732 # 13cc <global_variable>
  f8:	0007a783          	lw	a5,0(a5)
  fc:	0017871b          	addiw	a4,a5,1
 100:	0007069b          	sext.w	a3,a4
 104:	00001717          	auipc	a4,0x1
 108:	2c870713          	addi	a4,a4,712 # 13cc <global_variable>
 10c:	00d72023          	sw	a3,0(a4)
 110:	00078613          	mv	a2,a5
 114:	00001517          	auipc	a0,0x1
 118:	23c50513          	addi	a0,a0,572 # 1350 <printf+0x2ec>
 11c:	749000ef          	jal	1064 <printf>
 120:	f19ff0ef          	jal	38 <fork>
 124:	f15ff0ef          	jal	38 <fork>
 128:	eddff0ef          	jal	4 <getpid>
 12c:	00050593          	mv	a1,a0
 130:	00001797          	auipc	a5,0x1
 134:	29c78793          	addi	a5,a5,668 # 13cc <global_variable>
 138:	0007a783          	lw	a5,0(a5)
 13c:	0017871b          	addiw	a4,a5,1
 140:	0007069b          	sext.w	a3,a4
 144:	00001717          	auipc	a4,0x1
 148:	28870713          	addi	a4,a4,648 # 13cc <global_variable>
 14c:	00d72023          	sw	a3,0(a4)
 150:	00078613          	mv	a2,a5
 154:	00001517          	auipc	a0,0x1
 158:	1fc50513          	addi	a0,a0,508 # 1350 <printf+0x2ec>
 15c:	709000ef          	jal	1064 <printf>
 160:	ed9ff0ef          	jal	38 <fork>
 164:	ea1ff0ef          	jal	4 <getpid>
 168:	00050593          	mv	a1,a0
 16c:	00001797          	auipc	a5,0x1
 170:	26078793          	addi	a5,a5,608 # 13cc <global_variable>
 174:	0007a783          	lw	a5,0(a5)
 178:	0017871b          	addiw	a4,a5,1
 17c:	0007069b          	sext.w	a3,a4
 180:	00001717          	auipc	a4,0x1
 184:	24c70713          	addi	a4,a4,588 # 13cc <global_variable>
 188:	00d72023          	sw	a3,0(a4)
 18c:	00078613          	mv	a2,a5
 190:	00001517          	auipc	a0,0x1
 194:	1c050513          	addi	a0,a0,448 # 1350 <printf+0x2ec>
 198:	6cd000ef          	jal	1064 <printf>
 19c:	500007b7          	lui	a5,0x50000
 1a0:	fff78513          	addi	a0,a5,-1 # 4fffffff <buffer+0x4fffec27>
 1a4:	ee1ff0ef          	jal	84 <wait>
 1a8:	00000013          	nop
 1ac:	fb9ff06f          	j	164 <main+0x8c>

Disassembly of section .text.putc:

00000000000001b0 <putc>:
 1b0:	fe010113          	addi	sp,sp,-32
 1b4:	00813c23          	sd	s0,24(sp)
 1b8:	02010413          	addi	s0,sp,32
 1bc:	00050793          	mv	a5,a0
 1c0:	fef42623          	sw	a5,-20(s0)
 1c4:	00001797          	auipc	a5,0x1
 1c8:	20c78793          	addi	a5,a5,524 # 13d0 <tail>
 1cc:	0007a783          	lw	a5,0(a5)
 1d0:	0017871b          	addiw	a4,a5,1
 1d4:	0007069b          	sext.w	a3,a4
 1d8:	00001717          	auipc	a4,0x1
 1dc:	1f870713          	addi	a4,a4,504 # 13d0 <tail>
 1e0:	00d72023          	sw	a3,0(a4)
 1e4:	fec42703          	lw	a4,-20(s0)
 1e8:	0ff77713          	zext.b	a4,a4
 1ec:	00001697          	auipc	a3,0x1
 1f0:	1ec68693          	addi	a3,a3,492 # 13d8 <buffer>
 1f4:	00f687b3          	add	a5,a3,a5
 1f8:	00e78023          	sb	a4,0(a5)
 1fc:	fec42783          	lw	a5,-20(s0)
 200:	0ff7f793          	zext.b	a5,a5
 204:	0007879b          	sext.w	a5,a5
 208:	00078513          	mv	a0,a5
 20c:	01813403          	ld	s0,24(sp)
 210:	02010113          	addi	sp,sp,32
 214:	00008067          	ret

Disassembly of section .text.isspace:

0000000000000218 <isspace>:
 218:	fe010113          	addi	sp,sp,-32
 21c:	00813c23          	sd	s0,24(sp)
 220:	02010413          	addi	s0,sp,32
 224:	00050793          	mv	a5,a0
 228:	fef42623          	sw	a5,-20(s0)
 22c:	fec42783          	lw	a5,-20(s0)
 230:	0007871b          	sext.w	a4,a5
 234:	02000793          	li	a5,32
 238:	02f70263          	beq	a4,a5,25c <isspace+0x44>
 23c:	fec42783          	lw	a5,-20(s0)
 240:	0007871b          	sext.w	a4,a5
 244:	00800793          	li	a5,8
 248:	00e7de63          	bge	a5,a4,264 <isspace+0x4c>
 24c:	fec42783          	lw	a5,-20(s0)
 250:	0007871b          	sext.w	a4,a5
 254:	00d00793          	li	a5,13
 258:	00e7c663          	blt	a5,a4,264 <isspace+0x4c>
 25c:	00100793          	li	a5,1
 260:	0080006f          	j	268 <isspace+0x50>
 264:	00000793          	li	a5,0
 268:	00078513          	mv	a0,a5
 26c:	01813403          	ld	s0,24(sp)
 270:	02010113          	addi	sp,sp,32
 274:	00008067          	ret

Disassembly of section .text.strtol:

0000000000000278 <strtol>:
 278:	fb010113          	addi	sp,sp,-80
 27c:	04113423          	sd	ra,72(sp)
 280:	04813023          	sd	s0,64(sp)
 284:	05010413          	addi	s0,sp,80
 288:	fca43423          	sd	a0,-56(s0)
 28c:	fcb43023          	sd	a1,-64(s0)
 290:	00060793          	mv	a5,a2
 294:	faf42e23          	sw	a5,-68(s0)
 298:	fe043423          	sd	zero,-24(s0)
 29c:	fe0403a3          	sb	zero,-25(s0)
 2a0:	fc843783          	ld	a5,-56(s0)
 2a4:	fcf43c23          	sd	a5,-40(s0)
 2a8:	0100006f          	j	2b8 <strtol+0x40>
 2ac:	fd843783          	ld	a5,-40(s0)
 2b0:	00178793          	addi	a5,a5,1
 2b4:	fcf43c23          	sd	a5,-40(s0)
 2b8:	fd843783          	ld	a5,-40(s0)
 2bc:	0007c783          	lbu	a5,0(a5)
 2c0:	0007879b          	sext.w	a5,a5
 2c4:	00078513          	mv	a0,a5
 2c8:	f51ff0ef          	jal	218 <isspace>
 2cc:	00050793          	mv	a5,a0
 2d0:	fc079ee3          	bnez	a5,2ac <strtol+0x34>
 2d4:	fd843783          	ld	a5,-40(s0)
 2d8:	0007c783          	lbu	a5,0(a5)
 2dc:	00078713          	mv	a4,a5
 2e0:	02d00793          	li	a5,45
 2e4:	00f71e63          	bne	a4,a5,300 <strtol+0x88>
 2e8:	00100793          	li	a5,1
 2ec:	fef403a3          	sb	a5,-25(s0)
 2f0:	fd843783          	ld	a5,-40(s0)
 2f4:	00178793          	addi	a5,a5,1
 2f8:	fcf43c23          	sd	a5,-40(s0)
 2fc:	0240006f          	j	320 <strtol+0xa8>
 300:	fd843783          	ld	a5,-40(s0)
 304:	0007c783          	lbu	a5,0(a5)
 308:	00078713          	mv	a4,a5
 30c:	02b00793          	li	a5,43
 310:	00f71863          	bne	a4,a5,320 <strtol+0xa8>
 314:	fd843783          	ld	a5,-40(s0)
 318:	00178793          	addi	a5,a5,1
 31c:	fcf43c23          	sd	a5,-40(s0)
 320:	fbc42783          	lw	a5,-68(s0)
 324:	0007879b          	sext.w	a5,a5
 328:	06079c63          	bnez	a5,3a0 <strtol+0x128>
 32c:	fd843783          	ld	a5,-40(s0)
 330:	0007c783          	lbu	a5,0(a5)
 334:	00078713          	mv	a4,a5
 338:	03000793          	li	a5,48
 33c:	04f71e63          	bne	a4,a5,398 <strtol+0x120>
 340:	fd843783          	ld	a5,-40(s0)
 344:	00178793          	addi	a5,a5,1
 348:	fcf43c23          	sd	a5,-40(s0)
 34c:	fd843783          	ld	a5,-40(s0)
 350:	0007c783          	lbu	a5,0(a5)
 354:	00078713          	mv	a4,a5
 358:	07800793          	li	a5,120
 35c:	00f70c63          	beq	a4,a5,374 <strtol+0xfc>
 360:	fd843783          	ld	a5,-40(s0)
 364:	0007c783          	lbu	a5,0(a5)
 368:	00078713          	mv	a4,a5
 36c:	05800793          	li	a5,88
 370:	00f71e63          	bne	a4,a5,38c <strtol+0x114>
 374:	01000793          	li	a5,16
 378:	faf42e23          	sw	a5,-68(s0)
 37c:	fd843783          	ld	a5,-40(s0)
 380:	00178793          	addi	a5,a5,1
 384:	fcf43c23          	sd	a5,-40(s0)
 388:	0180006f          	j	3a0 <strtol+0x128>
 38c:	00800793          	li	a5,8
 390:	faf42e23          	sw	a5,-68(s0)
 394:	00c0006f          	j	3a0 <strtol+0x128>
 398:	00a00793          	li	a5,10
 39c:	faf42e23          	sw	a5,-68(s0)
 3a0:	fd843783          	ld	a5,-40(s0)
 3a4:	0007c783          	lbu	a5,0(a5)
 3a8:	00078713          	mv	a4,a5
 3ac:	02f00793          	li	a5,47
 3b0:	02e7f863          	bgeu	a5,a4,3e0 <strtol+0x168>
 3b4:	fd843783          	ld	a5,-40(s0)
 3b8:	0007c783          	lbu	a5,0(a5)
 3bc:	00078713          	mv	a4,a5
 3c0:	03900793          	li	a5,57
 3c4:	00e7ee63          	bltu	a5,a4,3e0 <strtol+0x168>
 3c8:	fd843783          	ld	a5,-40(s0)
 3cc:	0007c783          	lbu	a5,0(a5)
 3d0:	0007879b          	sext.w	a5,a5
 3d4:	fd07879b          	addiw	a5,a5,-48
 3d8:	fcf42a23          	sw	a5,-44(s0)
 3dc:	0800006f          	j	45c <strtol+0x1e4>
 3e0:	fd843783          	ld	a5,-40(s0)
 3e4:	0007c783          	lbu	a5,0(a5)
 3e8:	00078713          	mv	a4,a5
 3ec:	06000793          	li	a5,96
 3f0:	02e7f863          	bgeu	a5,a4,420 <strtol+0x1a8>
 3f4:	fd843783          	ld	a5,-40(s0)
 3f8:	0007c783          	lbu	a5,0(a5)
 3fc:	00078713          	mv	a4,a5
 400:	07a00793          	li	a5,122
 404:	00e7ee63          	bltu	a5,a4,420 <strtol+0x1a8>
 408:	fd843783          	ld	a5,-40(s0)
 40c:	0007c783          	lbu	a5,0(a5)
 410:	0007879b          	sext.w	a5,a5
 414:	fa97879b          	addiw	a5,a5,-87
 418:	fcf42a23          	sw	a5,-44(s0)
 41c:	0400006f          	j	45c <strtol+0x1e4>
 420:	fd843783          	ld	a5,-40(s0)
 424:	0007c783          	lbu	a5,0(a5)
 428:	00078713          	mv	a4,a5
 42c:	04000793          	li	a5,64
 430:	06e7f863          	bgeu	a5,a4,4a0 <strtol+0x228>
 434:	fd843783          	ld	a5,-40(s0)
 438:	0007c783          	lbu	a5,0(a5)
 43c:	00078713          	mv	a4,a5
 440:	05a00793          	li	a5,90
 444:	04e7ee63          	bltu	a5,a4,4a0 <strtol+0x228>
 448:	fd843783          	ld	a5,-40(s0)
 44c:	0007c783          	lbu	a5,0(a5)
 450:	0007879b          	sext.w	a5,a5
 454:	fc97879b          	addiw	a5,a5,-55
 458:	fcf42a23          	sw	a5,-44(s0)
 45c:	fd442783          	lw	a5,-44(s0)
 460:	00078713          	mv	a4,a5
 464:	fbc42783          	lw	a5,-68(s0)
 468:	0007071b          	sext.w	a4,a4
 46c:	0007879b          	sext.w	a5,a5
 470:	02f75663          	bge	a4,a5,49c <strtol+0x224>
 474:	fbc42703          	lw	a4,-68(s0)
 478:	fe843783          	ld	a5,-24(s0)
 47c:	02f70733          	mul	a4,a4,a5
 480:	fd442783          	lw	a5,-44(s0)
 484:	00f707b3          	add	a5,a4,a5
 488:	fef43423          	sd	a5,-24(s0)
 48c:	fd843783          	ld	a5,-40(s0)
 490:	00178793          	addi	a5,a5,1
 494:	fcf43c23          	sd	a5,-40(s0)
 498:	f09ff06f          	j	3a0 <strtol+0x128>
 49c:	00000013          	nop
 4a0:	fc043783          	ld	a5,-64(s0)
 4a4:	00078863          	beqz	a5,4b4 <strtol+0x23c>
 4a8:	fc043783          	ld	a5,-64(s0)
 4ac:	fd843703          	ld	a4,-40(s0)
 4b0:	00e7b023          	sd	a4,0(a5)
 4b4:	fe744783          	lbu	a5,-25(s0)
 4b8:	0ff7f793          	zext.b	a5,a5
 4bc:	00078863          	beqz	a5,4cc <strtol+0x254>
 4c0:	fe843783          	ld	a5,-24(s0)
 4c4:	40f007b3          	neg	a5,a5
 4c8:	0080006f          	j	4d0 <strtol+0x258>
 4cc:	fe843783          	ld	a5,-24(s0)
 4d0:	00078513          	mv	a0,a5
 4d4:	04813083          	ld	ra,72(sp)
 4d8:	04013403          	ld	s0,64(sp)
 4dc:	05010113          	addi	sp,sp,80
 4e0:	00008067          	ret

Disassembly of section .text.puts_wo_nl:

00000000000004e4 <puts_wo_nl>:
 4e4:	fd010113          	addi	sp,sp,-48
 4e8:	02113423          	sd	ra,40(sp)
 4ec:	02813023          	sd	s0,32(sp)
 4f0:	03010413          	addi	s0,sp,48
 4f4:	fca43c23          	sd	a0,-40(s0)
 4f8:	fcb43823          	sd	a1,-48(s0)
 4fc:	fd043783          	ld	a5,-48(s0)
 500:	00079863          	bnez	a5,510 <puts_wo_nl+0x2c>
 504:	00001797          	auipc	a5,0x1
 508:	e7c78793          	addi	a5,a5,-388 # 1380 <printf+0x31c>
 50c:	fcf43823          	sd	a5,-48(s0)
 510:	fd043783          	ld	a5,-48(s0)
 514:	fef43423          	sd	a5,-24(s0)
 518:	0240006f          	j	53c <puts_wo_nl+0x58>
 51c:	fe843783          	ld	a5,-24(s0)
 520:	00178713          	addi	a4,a5,1
 524:	fee43423          	sd	a4,-24(s0)
 528:	0007c783          	lbu	a5,0(a5)
 52c:	0007871b          	sext.w	a4,a5
 530:	fd843783          	ld	a5,-40(s0)
 534:	00070513          	mv	a0,a4
 538:	000780e7          	jalr	a5
 53c:	fe843783          	ld	a5,-24(s0)
 540:	0007c783          	lbu	a5,0(a5)
 544:	fc079ce3          	bnez	a5,51c <puts_wo_nl+0x38>
 548:	fe843703          	ld	a4,-24(s0)
 54c:	fd043783          	ld	a5,-48(s0)
 550:	40f707b3          	sub	a5,a4,a5
 554:	0007879b          	sext.w	a5,a5
 558:	00078513          	mv	a0,a5
 55c:	02813083          	ld	ra,40(sp)
 560:	02013403          	ld	s0,32(sp)
 564:	03010113          	addi	sp,sp,48
 568:	00008067          	ret

Disassembly of section .text.print_dec_int:

000000000000056c <print_dec_int>:
 56c:	f9010113          	addi	sp,sp,-112
 570:	06113423          	sd	ra,104(sp)
 574:	06813023          	sd	s0,96(sp)
 578:	07010413          	addi	s0,sp,112
 57c:	faa43423          	sd	a0,-88(s0)
 580:	fab43023          	sd	a1,-96(s0)
 584:	00060793          	mv	a5,a2
 588:	f8d43823          	sd	a3,-112(s0)
 58c:	f8f40fa3          	sb	a5,-97(s0)
 590:	f9f44783          	lbu	a5,-97(s0)
 594:	0ff7f793          	zext.b	a5,a5
 598:	02078663          	beqz	a5,5c4 <print_dec_int+0x58>
 59c:	fa043703          	ld	a4,-96(s0)
 5a0:	fff00793          	li	a5,-1
 5a4:	03f79793          	slli	a5,a5,0x3f
 5a8:	00f71e63          	bne	a4,a5,5c4 <print_dec_int+0x58>
 5ac:	00001597          	auipc	a1,0x1
 5b0:	ddc58593          	addi	a1,a1,-548 # 1388 <printf+0x324>
 5b4:	fa843503          	ld	a0,-88(s0)
 5b8:	f2dff0ef          	jal	4e4 <puts_wo_nl>
 5bc:	00050793          	mv	a5,a0
 5c0:	2a00006f          	j	860 <print_dec_int+0x2f4>
 5c4:	f9043783          	ld	a5,-112(s0)
 5c8:	00c7a783          	lw	a5,12(a5)
 5cc:	00079a63          	bnez	a5,5e0 <print_dec_int+0x74>
 5d0:	fa043783          	ld	a5,-96(s0)
 5d4:	00079663          	bnez	a5,5e0 <print_dec_int+0x74>
 5d8:	00000793          	li	a5,0
 5dc:	2840006f          	j	860 <print_dec_int+0x2f4>
 5e0:	fe0407a3          	sb	zero,-17(s0)
 5e4:	f9f44783          	lbu	a5,-97(s0)
 5e8:	0ff7f793          	zext.b	a5,a5
 5ec:	02078063          	beqz	a5,60c <print_dec_int+0xa0>
 5f0:	fa043783          	ld	a5,-96(s0)
 5f4:	0007dc63          	bgez	a5,60c <print_dec_int+0xa0>
 5f8:	00100793          	li	a5,1
 5fc:	fef407a3          	sb	a5,-17(s0)
 600:	fa043783          	ld	a5,-96(s0)
 604:	40f007b3          	neg	a5,a5
 608:	faf43023          	sd	a5,-96(s0)
 60c:	fe042423          	sw	zero,-24(s0)
 610:	f9f44783          	lbu	a5,-97(s0)
 614:	0ff7f793          	zext.b	a5,a5
 618:	02078863          	beqz	a5,648 <print_dec_int+0xdc>
 61c:	fef44783          	lbu	a5,-17(s0)
 620:	0ff7f793          	zext.b	a5,a5
 624:	00079e63          	bnez	a5,640 <print_dec_int+0xd4>
 628:	f9043783          	ld	a5,-112(s0)
 62c:	0057c783          	lbu	a5,5(a5)
 630:	00079863          	bnez	a5,640 <print_dec_int+0xd4>
 634:	f9043783          	ld	a5,-112(s0)
 638:	0047c783          	lbu	a5,4(a5)
 63c:	00078663          	beqz	a5,648 <print_dec_int+0xdc>
 640:	00100793          	li	a5,1
 644:	0080006f          	j	64c <print_dec_int+0xe0>
 648:	00000793          	li	a5,0
 64c:	fcf40ba3          	sb	a5,-41(s0)
 650:	fd744783          	lbu	a5,-41(s0)
 654:	0017f793          	andi	a5,a5,1
 658:	fcf40ba3          	sb	a5,-41(s0)
 65c:	fa043703          	ld	a4,-96(s0)
 660:	00a00793          	li	a5,10
 664:	02f777b3          	remu	a5,a4,a5
 668:	0ff7f713          	zext.b	a4,a5
 66c:	fe842783          	lw	a5,-24(s0)
 670:	0017869b          	addiw	a3,a5,1
 674:	fed42423          	sw	a3,-24(s0)
 678:	0307071b          	addiw	a4,a4,48
 67c:	0ff77713          	zext.b	a4,a4
 680:	ff078793          	addi	a5,a5,-16
 684:	008787b3          	add	a5,a5,s0
 688:	fce78423          	sb	a4,-56(a5)
 68c:	fa043703          	ld	a4,-96(s0)
 690:	00a00793          	li	a5,10
 694:	02f757b3          	divu	a5,a4,a5
 698:	faf43023          	sd	a5,-96(s0)
 69c:	fa043783          	ld	a5,-96(s0)
 6a0:	fa079ee3          	bnez	a5,65c <print_dec_int+0xf0>
 6a4:	f9043783          	ld	a5,-112(s0)
 6a8:	00c7a783          	lw	a5,12(a5)
 6ac:	00078713          	mv	a4,a5
 6b0:	fff00793          	li	a5,-1
 6b4:	02f71063          	bne	a4,a5,6d4 <print_dec_int+0x168>
 6b8:	f9043783          	ld	a5,-112(s0)
 6bc:	0037c783          	lbu	a5,3(a5)
 6c0:	00078a63          	beqz	a5,6d4 <print_dec_int+0x168>
 6c4:	f9043783          	ld	a5,-112(s0)
 6c8:	0087a703          	lw	a4,8(a5)
 6cc:	f9043783          	ld	a5,-112(s0)
 6d0:	00e7a623          	sw	a4,12(a5)
 6d4:	fe042223          	sw	zero,-28(s0)
 6d8:	f9043783          	ld	a5,-112(s0)
 6dc:	0087a703          	lw	a4,8(a5)
 6e0:	fe842783          	lw	a5,-24(s0)
 6e4:	fcf42823          	sw	a5,-48(s0)
 6e8:	f9043783          	ld	a5,-112(s0)
 6ec:	00c7a783          	lw	a5,12(a5)
 6f0:	fcf42623          	sw	a5,-52(s0)
 6f4:	fd042783          	lw	a5,-48(s0)
 6f8:	00078593          	mv	a1,a5
 6fc:	fcc42783          	lw	a5,-52(s0)
 700:	00078613          	mv	a2,a5
 704:	0006069b          	sext.w	a3,a2
 708:	0005879b          	sext.w	a5,a1
 70c:	00f6d463          	bge	a3,a5,714 <print_dec_int+0x1a8>
 710:	00058613          	mv	a2,a1
 714:	0006079b          	sext.w	a5,a2
 718:	40f707bb          	subw	a5,a4,a5
 71c:	0007871b          	sext.w	a4,a5
 720:	fd744783          	lbu	a5,-41(s0)
 724:	0007879b          	sext.w	a5,a5
 728:	40f707bb          	subw	a5,a4,a5
 72c:	fef42023          	sw	a5,-32(s0)
 730:	0280006f          	j	758 <print_dec_int+0x1ec>
 734:	fa843783          	ld	a5,-88(s0)
 738:	02000513          	li	a0,32
 73c:	000780e7          	jalr	a5
 740:	fe442783          	lw	a5,-28(s0)
 744:	0017879b          	addiw	a5,a5,1
 748:	fef42223          	sw	a5,-28(s0)
 74c:	fe042783          	lw	a5,-32(s0)
 750:	fff7879b          	addiw	a5,a5,-1
 754:	fef42023          	sw	a5,-32(s0)
 758:	fe042783          	lw	a5,-32(s0)
 75c:	0007879b          	sext.w	a5,a5
 760:	fcf04ae3          	bgtz	a5,734 <print_dec_int+0x1c8>
 764:	fd744783          	lbu	a5,-41(s0)
 768:	0ff7f793          	zext.b	a5,a5
 76c:	04078463          	beqz	a5,7b4 <print_dec_int+0x248>
 770:	fef44783          	lbu	a5,-17(s0)
 774:	0ff7f793          	zext.b	a5,a5
 778:	00078663          	beqz	a5,784 <print_dec_int+0x218>
 77c:	02d00793          	li	a5,45
 780:	01c0006f          	j	79c <print_dec_int+0x230>
 784:	f9043783          	ld	a5,-112(s0)
 788:	0057c783          	lbu	a5,5(a5)
 78c:	00078663          	beqz	a5,798 <print_dec_int+0x22c>
 790:	02b00793          	li	a5,43
 794:	0080006f          	j	79c <print_dec_int+0x230>
 798:	02000793          	li	a5,32
 79c:	fa843703          	ld	a4,-88(s0)
 7a0:	00078513          	mv	a0,a5
 7a4:	000700e7          	jalr	a4
 7a8:	fe442783          	lw	a5,-28(s0)
 7ac:	0017879b          	addiw	a5,a5,1
 7b0:	fef42223          	sw	a5,-28(s0)
 7b4:	fe842783          	lw	a5,-24(s0)
 7b8:	fcf42e23          	sw	a5,-36(s0)
 7bc:	0280006f          	j	7e4 <print_dec_int+0x278>
 7c0:	fa843783          	ld	a5,-88(s0)
 7c4:	03000513          	li	a0,48
 7c8:	000780e7          	jalr	a5
 7cc:	fe442783          	lw	a5,-28(s0)
 7d0:	0017879b          	addiw	a5,a5,1
 7d4:	fef42223          	sw	a5,-28(s0)
 7d8:	fdc42783          	lw	a5,-36(s0)
 7dc:	0017879b          	addiw	a5,a5,1
 7e0:	fcf42e23          	sw	a5,-36(s0)
 7e4:	f9043783          	ld	a5,-112(s0)
 7e8:	00c7a703          	lw	a4,12(a5)
 7ec:	fd744783          	lbu	a5,-41(s0)
 7f0:	0007879b          	sext.w	a5,a5
 7f4:	40f707bb          	subw	a5,a4,a5
 7f8:	0007871b          	sext.w	a4,a5
 7fc:	fdc42783          	lw	a5,-36(s0)
 800:	0007879b          	sext.w	a5,a5
 804:	fae7cee3          	blt	a5,a4,7c0 <print_dec_int+0x254>
 808:	fe842783          	lw	a5,-24(s0)
 80c:	fff7879b          	addiw	a5,a5,-1
 810:	fcf42c23          	sw	a5,-40(s0)
 814:	03c0006f          	j	850 <print_dec_int+0x2e4>
 818:	fd842783          	lw	a5,-40(s0)
 81c:	ff078793          	addi	a5,a5,-16
 820:	008787b3          	add	a5,a5,s0
 824:	fc87c783          	lbu	a5,-56(a5)
 828:	0007871b          	sext.w	a4,a5
 82c:	fa843783          	ld	a5,-88(s0)
 830:	00070513          	mv	a0,a4
 834:	000780e7          	jalr	a5
 838:	fe442783          	lw	a5,-28(s0)
 83c:	0017879b          	addiw	a5,a5,1
 840:	fef42223          	sw	a5,-28(s0)
 844:	fd842783          	lw	a5,-40(s0)
 848:	fff7879b          	addiw	a5,a5,-1
 84c:	fcf42c23          	sw	a5,-40(s0)
 850:	fd842783          	lw	a5,-40(s0)
 854:	0007879b          	sext.w	a5,a5
 858:	fc07d0e3          	bgez	a5,818 <print_dec_int+0x2ac>
 85c:	fe442783          	lw	a5,-28(s0)
 860:	00078513          	mv	a0,a5
 864:	06813083          	ld	ra,104(sp)
 868:	06013403          	ld	s0,96(sp)
 86c:	07010113          	addi	sp,sp,112
 870:	00008067          	ret

Disassembly of section .text.vprintfmt:

0000000000000874 <vprintfmt>:
     874:	f4010113          	addi	sp,sp,-192
     878:	0a113c23          	sd	ra,184(sp)
     87c:	0a813823          	sd	s0,176(sp)
     880:	0c010413          	addi	s0,sp,192
     884:	f4a43c23          	sd	a0,-168(s0)
     888:	f4b43823          	sd	a1,-176(s0)
     88c:	f4c43423          	sd	a2,-184(s0)
     890:	f8043023          	sd	zero,-128(s0)
     894:	f8043423          	sd	zero,-120(s0)
     898:	fe042623          	sw	zero,-20(s0)
     89c:	7a40006f          	j	1040 <vprintfmt+0x7cc>
     8a0:	f8044783          	lbu	a5,-128(s0)
     8a4:	72078e63          	beqz	a5,fe0 <vprintfmt+0x76c>
     8a8:	f5043783          	ld	a5,-176(s0)
     8ac:	0007c783          	lbu	a5,0(a5)
     8b0:	00078713          	mv	a4,a5
     8b4:	02300793          	li	a5,35
     8b8:	00f71863          	bne	a4,a5,8c8 <vprintfmt+0x54>
     8bc:	00100793          	li	a5,1
     8c0:	f8f40123          	sb	a5,-126(s0)
     8c4:	7700006f          	j	1034 <vprintfmt+0x7c0>
     8c8:	f5043783          	ld	a5,-176(s0)
     8cc:	0007c783          	lbu	a5,0(a5)
     8d0:	00078713          	mv	a4,a5
     8d4:	03000793          	li	a5,48
     8d8:	00f71863          	bne	a4,a5,8e8 <vprintfmt+0x74>
     8dc:	00100793          	li	a5,1
     8e0:	f8f401a3          	sb	a5,-125(s0)
     8e4:	7500006f          	j	1034 <vprintfmt+0x7c0>
     8e8:	f5043783          	ld	a5,-176(s0)
     8ec:	0007c783          	lbu	a5,0(a5)
     8f0:	00078713          	mv	a4,a5
     8f4:	06c00793          	li	a5,108
     8f8:	04f70063          	beq	a4,a5,938 <vprintfmt+0xc4>
     8fc:	f5043783          	ld	a5,-176(s0)
     900:	0007c783          	lbu	a5,0(a5)
     904:	00078713          	mv	a4,a5
     908:	07a00793          	li	a5,122
     90c:	02f70663          	beq	a4,a5,938 <vprintfmt+0xc4>
     910:	f5043783          	ld	a5,-176(s0)
     914:	0007c783          	lbu	a5,0(a5)
     918:	00078713          	mv	a4,a5
     91c:	07400793          	li	a5,116
     920:	00f70c63          	beq	a4,a5,938 <vprintfmt+0xc4>
     924:	f5043783          	ld	a5,-176(s0)
     928:	0007c783          	lbu	a5,0(a5)
     92c:	00078713          	mv	a4,a5
     930:	06a00793          	li	a5,106
     934:	00f71863          	bne	a4,a5,944 <vprintfmt+0xd0>
     938:	00100793          	li	a5,1
     93c:	f8f400a3          	sb	a5,-127(s0)
     940:	6f40006f          	j	1034 <vprintfmt+0x7c0>
     944:	f5043783          	ld	a5,-176(s0)
     948:	0007c783          	lbu	a5,0(a5)
     94c:	00078713          	mv	a4,a5
     950:	02b00793          	li	a5,43
     954:	00f71863          	bne	a4,a5,964 <vprintfmt+0xf0>
     958:	00100793          	li	a5,1
     95c:	f8f402a3          	sb	a5,-123(s0)
     960:	6d40006f          	j	1034 <vprintfmt+0x7c0>
     964:	f5043783          	ld	a5,-176(s0)
     968:	0007c783          	lbu	a5,0(a5)
     96c:	00078713          	mv	a4,a5
     970:	02000793          	li	a5,32
     974:	00f71863          	bne	a4,a5,984 <vprintfmt+0x110>
     978:	00100793          	li	a5,1
     97c:	f8f40223          	sb	a5,-124(s0)
     980:	6b40006f          	j	1034 <vprintfmt+0x7c0>
     984:	f5043783          	ld	a5,-176(s0)
     988:	0007c783          	lbu	a5,0(a5)
     98c:	00078713          	mv	a4,a5
     990:	02a00793          	li	a5,42
     994:	00f71e63          	bne	a4,a5,9b0 <vprintfmt+0x13c>
     998:	f4843783          	ld	a5,-184(s0)
     99c:	00878713          	addi	a4,a5,8
     9a0:	f4e43423          	sd	a4,-184(s0)
     9a4:	0007a783          	lw	a5,0(a5)
     9a8:	f8f42423          	sw	a5,-120(s0)
     9ac:	6880006f          	j	1034 <vprintfmt+0x7c0>
     9b0:	f5043783          	ld	a5,-176(s0)
     9b4:	0007c783          	lbu	a5,0(a5)
     9b8:	00078713          	mv	a4,a5
     9bc:	03000793          	li	a5,48
     9c0:	04e7f663          	bgeu	a5,a4,a0c <vprintfmt+0x198>
     9c4:	f5043783          	ld	a5,-176(s0)
     9c8:	0007c783          	lbu	a5,0(a5)
     9cc:	00078713          	mv	a4,a5
     9d0:	03900793          	li	a5,57
     9d4:	02e7ec63          	bltu	a5,a4,a0c <vprintfmt+0x198>
     9d8:	f5043783          	ld	a5,-176(s0)
     9dc:	f5040713          	addi	a4,s0,-176
     9e0:	00a00613          	li	a2,10
     9e4:	00070593          	mv	a1,a4
     9e8:	00078513          	mv	a0,a5
     9ec:	88dff0ef          	jal	278 <strtol>
     9f0:	00050793          	mv	a5,a0
     9f4:	0007879b          	sext.w	a5,a5
     9f8:	f8f42423          	sw	a5,-120(s0)
     9fc:	f5043783          	ld	a5,-176(s0)
     a00:	fff78793          	addi	a5,a5,-1
     a04:	f4f43823          	sd	a5,-176(s0)
     a08:	62c0006f          	j	1034 <vprintfmt+0x7c0>
     a0c:	f5043783          	ld	a5,-176(s0)
     a10:	0007c783          	lbu	a5,0(a5)
     a14:	00078713          	mv	a4,a5
     a18:	02e00793          	li	a5,46
     a1c:	06f71863          	bne	a4,a5,a8c <vprintfmt+0x218>
     a20:	f5043783          	ld	a5,-176(s0)
     a24:	00178793          	addi	a5,a5,1
     a28:	f4f43823          	sd	a5,-176(s0)
     a2c:	f5043783          	ld	a5,-176(s0)
     a30:	0007c783          	lbu	a5,0(a5)
     a34:	00078713          	mv	a4,a5
     a38:	02a00793          	li	a5,42
     a3c:	00f71e63          	bne	a4,a5,a58 <vprintfmt+0x1e4>
     a40:	f4843783          	ld	a5,-184(s0)
     a44:	00878713          	addi	a4,a5,8
     a48:	f4e43423          	sd	a4,-184(s0)
     a4c:	0007a783          	lw	a5,0(a5)
     a50:	f8f42623          	sw	a5,-116(s0)
     a54:	5e00006f          	j	1034 <vprintfmt+0x7c0>
     a58:	f5043783          	ld	a5,-176(s0)
     a5c:	f5040713          	addi	a4,s0,-176
     a60:	00a00613          	li	a2,10
     a64:	00070593          	mv	a1,a4
     a68:	00078513          	mv	a0,a5
     a6c:	80dff0ef          	jal	278 <strtol>
     a70:	00050793          	mv	a5,a0
     a74:	0007879b          	sext.w	a5,a5
     a78:	f8f42623          	sw	a5,-116(s0)
     a7c:	f5043783          	ld	a5,-176(s0)
     a80:	fff78793          	addi	a5,a5,-1
     a84:	f4f43823          	sd	a5,-176(s0)
     a88:	5ac0006f          	j	1034 <vprintfmt+0x7c0>
     a8c:	f5043783          	ld	a5,-176(s0)
     a90:	0007c783          	lbu	a5,0(a5)
     a94:	00078713          	mv	a4,a5
     a98:	07800793          	li	a5,120
     a9c:	02f70663          	beq	a4,a5,ac8 <vprintfmt+0x254>
     aa0:	f5043783          	ld	a5,-176(s0)
     aa4:	0007c783          	lbu	a5,0(a5)
     aa8:	00078713          	mv	a4,a5
     aac:	05800793          	li	a5,88
     ab0:	00f70c63          	beq	a4,a5,ac8 <vprintfmt+0x254>
     ab4:	f5043783          	ld	a5,-176(s0)
     ab8:	0007c783          	lbu	a5,0(a5)
     abc:	00078713          	mv	a4,a5
     ac0:	07000793          	li	a5,112
     ac4:	30f71263          	bne	a4,a5,dc8 <vprintfmt+0x554>
     ac8:	f5043783          	ld	a5,-176(s0)
     acc:	0007c783          	lbu	a5,0(a5)
     ad0:	00078713          	mv	a4,a5
     ad4:	07000793          	li	a5,112
     ad8:	00f70663          	beq	a4,a5,ae4 <vprintfmt+0x270>
     adc:	f8144783          	lbu	a5,-127(s0)
     ae0:	00078663          	beqz	a5,aec <vprintfmt+0x278>
     ae4:	00100793          	li	a5,1
     ae8:	0080006f          	j	af0 <vprintfmt+0x27c>
     aec:	00000793          	li	a5,0
     af0:	faf403a3          	sb	a5,-89(s0)
     af4:	fa744783          	lbu	a5,-89(s0)
     af8:	0017f793          	andi	a5,a5,1
     afc:	faf403a3          	sb	a5,-89(s0)
     b00:	fa744783          	lbu	a5,-89(s0)
     b04:	0ff7f793          	zext.b	a5,a5
     b08:	00078c63          	beqz	a5,b20 <vprintfmt+0x2ac>
     b0c:	f4843783          	ld	a5,-184(s0)
     b10:	00878713          	addi	a4,a5,8
     b14:	f4e43423          	sd	a4,-184(s0)
     b18:	0007b783          	ld	a5,0(a5)
     b1c:	01c0006f          	j	b38 <vprintfmt+0x2c4>
     b20:	f4843783          	ld	a5,-184(s0)
     b24:	00878713          	addi	a4,a5,8
     b28:	f4e43423          	sd	a4,-184(s0)
     b2c:	0007a783          	lw	a5,0(a5)
     b30:	02079793          	slli	a5,a5,0x20
     b34:	0207d793          	srli	a5,a5,0x20
     b38:	fef43023          	sd	a5,-32(s0)
     b3c:	f8c42783          	lw	a5,-116(s0)
     b40:	02079463          	bnez	a5,b68 <vprintfmt+0x2f4>
     b44:	fe043783          	ld	a5,-32(s0)
     b48:	02079063          	bnez	a5,b68 <vprintfmt+0x2f4>
     b4c:	f5043783          	ld	a5,-176(s0)
     b50:	0007c783          	lbu	a5,0(a5)
     b54:	00078713          	mv	a4,a5
     b58:	07000793          	li	a5,112
     b5c:	00f70663          	beq	a4,a5,b68 <vprintfmt+0x2f4>
     b60:	f8040023          	sb	zero,-128(s0)
     b64:	4d00006f          	j	1034 <vprintfmt+0x7c0>
     b68:	f5043783          	ld	a5,-176(s0)
     b6c:	0007c783          	lbu	a5,0(a5)
     b70:	00078713          	mv	a4,a5
     b74:	07000793          	li	a5,112
     b78:	00f70a63          	beq	a4,a5,b8c <vprintfmt+0x318>
     b7c:	f8244783          	lbu	a5,-126(s0)
     b80:	00078a63          	beqz	a5,b94 <vprintfmt+0x320>
     b84:	fe043783          	ld	a5,-32(s0)
     b88:	00078663          	beqz	a5,b94 <vprintfmt+0x320>
     b8c:	00100793          	li	a5,1
     b90:	0080006f          	j	b98 <vprintfmt+0x324>
     b94:	00000793          	li	a5,0
     b98:	faf40323          	sb	a5,-90(s0)
     b9c:	fa644783          	lbu	a5,-90(s0)
     ba0:	0017f793          	andi	a5,a5,1
     ba4:	faf40323          	sb	a5,-90(s0)
     ba8:	fc042e23          	sw	zero,-36(s0)
     bac:	f5043783          	ld	a5,-176(s0)
     bb0:	0007c783          	lbu	a5,0(a5)
     bb4:	00078713          	mv	a4,a5
     bb8:	05800793          	li	a5,88
     bbc:	00f71863          	bne	a4,a5,bcc <vprintfmt+0x358>
     bc0:	00000797          	auipc	a5,0x0
     bc4:	7e078793          	addi	a5,a5,2016 # 13a0 <upperxdigits.1>
     bc8:	00c0006f          	j	bd4 <vprintfmt+0x360>
     bcc:	00000797          	auipc	a5,0x0
     bd0:	7ec78793          	addi	a5,a5,2028 # 13b8 <lowerxdigits.0>
     bd4:	f8f43c23          	sd	a5,-104(s0)
     bd8:	fe043783          	ld	a5,-32(s0)
     bdc:	00f7f793          	andi	a5,a5,15
     be0:	f9843703          	ld	a4,-104(s0)
     be4:	00f70733          	add	a4,a4,a5
     be8:	fdc42783          	lw	a5,-36(s0)
     bec:	0017869b          	addiw	a3,a5,1
     bf0:	fcd42e23          	sw	a3,-36(s0)
     bf4:	00074703          	lbu	a4,0(a4)
     bf8:	ff078793          	addi	a5,a5,-16
     bfc:	008787b3          	add	a5,a5,s0
     c00:	f8e78023          	sb	a4,-128(a5)
     c04:	fe043783          	ld	a5,-32(s0)
     c08:	0047d793          	srli	a5,a5,0x4
     c0c:	fef43023          	sd	a5,-32(s0)
     c10:	fe043783          	ld	a5,-32(s0)
     c14:	fc0792e3          	bnez	a5,bd8 <vprintfmt+0x364>
     c18:	f8c42783          	lw	a5,-116(s0)
     c1c:	00078713          	mv	a4,a5
     c20:	fff00793          	li	a5,-1
     c24:	02f71663          	bne	a4,a5,c50 <vprintfmt+0x3dc>
     c28:	f8344783          	lbu	a5,-125(s0)
     c2c:	02078263          	beqz	a5,c50 <vprintfmt+0x3dc>
     c30:	f8842703          	lw	a4,-120(s0)
     c34:	fa644783          	lbu	a5,-90(s0)
     c38:	0007879b          	sext.w	a5,a5
     c3c:	0017979b          	slliw	a5,a5,0x1
     c40:	0007879b          	sext.w	a5,a5
     c44:	40f707bb          	subw	a5,a4,a5
     c48:	0007879b          	sext.w	a5,a5
     c4c:	f8f42623          	sw	a5,-116(s0)
     c50:	f8842703          	lw	a4,-120(s0)
     c54:	fa644783          	lbu	a5,-90(s0)
     c58:	0007879b          	sext.w	a5,a5
     c5c:	0017979b          	slliw	a5,a5,0x1
     c60:	0007879b          	sext.w	a5,a5
     c64:	40f707bb          	subw	a5,a4,a5
     c68:	0007871b          	sext.w	a4,a5
     c6c:	fdc42783          	lw	a5,-36(s0)
     c70:	f8f42a23          	sw	a5,-108(s0)
     c74:	f8c42783          	lw	a5,-116(s0)
     c78:	f8f42823          	sw	a5,-112(s0)
     c7c:	f9442783          	lw	a5,-108(s0)
     c80:	00078593          	mv	a1,a5
     c84:	f9042783          	lw	a5,-112(s0)
     c88:	00078613          	mv	a2,a5
     c8c:	0006069b          	sext.w	a3,a2
     c90:	0005879b          	sext.w	a5,a1
     c94:	00f6d463          	bge	a3,a5,c9c <vprintfmt+0x428>
     c98:	00058613          	mv	a2,a1
     c9c:	0006079b          	sext.w	a5,a2
     ca0:	40f707bb          	subw	a5,a4,a5
     ca4:	fcf42c23          	sw	a5,-40(s0)
     ca8:	0280006f          	j	cd0 <vprintfmt+0x45c>
     cac:	f5843783          	ld	a5,-168(s0)
     cb0:	02000513          	li	a0,32
     cb4:	000780e7          	jalr	a5
     cb8:	fec42783          	lw	a5,-20(s0)
     cbc:	0017879b          	addiw	a5,a5,1
     cc0:	fef42623          	sw	a5,-20(s0)
     cc4:	fd842783          	lw	a5,-40(s0)
     cc8:	fff7879b          	addiw	a5,a5,-1
     ccc:	fcf42c23          	sw	a5,-40(s0)
     cd0:	fd842783          	lw	a5,-40(s0)
     cd4:	0007879b          	sext.w	a5,a5
     cd8:	fcf04ae3          	bgtz	a5,cac <vprintfmt+0x438>
     cdc:	fa644783          	lbu	a5,-90(s0)
     ce0:	0ff7f793          	zext.b	a5,a5
     ce4:	04078463          	beqz	a5,d2c <vprintfmt+0x4b8>
     ce8:	f5843783          	ld	a5,-168(s0)
     cec:	03000513          	li	a0,48
     cf0:	000780e7          	jalr	a5
     cf4:	f5043783          	ld	a5,-176(s0)
     cf8:	0007c783          	lbu	a5,0(a5)
     cfc:	00078713          	mv	a4,a5
     d00:	05800793          	li	a5,88
     d04:	00f71663          	bne	a4,a5,d10 <vprintfmt+0x49c>
     d08:	05800793          	li	a5,88
     d0c:	0080006f          	j	d14 <vprintfmt+0x4a0>
     d10:	07800793          	li	a5,120
     d14:	f5843703          	ld	a4,-168(s0)
     d18:	00078513          	mv	a0,a5
     d1c:	000700e7          	jalr	a4
     d20:	fec42783          	lw	a5,-20(s0)
     d24:	0027879b          	addiw	a5,a5,2
     d28:	fef42623          	sw	a5,-20(s0)
     d2c:	fdc42783          	lw	a5,-36(s0)
     d30:	fcf42a23          	sw	a5,-44(s0)
     d34:	0280006f          	j	d5c <vprintfmt+0x4e8>
     d38:	f5843783          	ld	a5,-168(s0)
     d3c:	03000513          	li	a0,48
     d40:	000780e7          	jalr	a5
     d44:	fec42783          	lw	a5,-20(s0)
     d48:	0017879b          	addiw	a5,a5,1
     d4c:	fef42623          	sw	a5,-20(s0)
     d50:	fd442783          	lw	a5,-44(s0)
     d54:	0017879b          	addiw	a5,a5,1
     d58:	fcf42a23          	sw	a5,-44(s0)
     d5c:	f8c42703          	lw	a4,-116(s0)
     d60:	fd442783          	lw	a5,-44(s0)
     d64:	0007879b          	sext.w	a5,a5
     d68:	fce7c8e3          	blt	a5,a4,d38 <vprintfmt+0x4c4>
     d6c:	fdc42783          	lw	a5,-36(s0)
     d70:	fff7879b          	addiw	a5,a5,-1
     d74:	fcf42823          	sw	a5,-48(s0)
     d78:	03c0006f          	j	db4 <vprintfmt+0x540>
     d7c:	fd042783          	lw	a5,-48(s0)
     d80:	ff078793          	addi	a5,a5,-16
     d84:	008787b3          	add	a5,a5,s0
     d88:	f807c783          	lbu	a5,-128(a5)
     d8c:	0007871b          	sext.w	a4,a5
     d90:	f5843783          	ld	a5,-168(s0)
     d94:	00070513          	mv	a0,a4
     d98:	000780e7          	jalr	a5
     d9c:	fec42783          	lw	a5,-20(s0)
     da0:	0017879b          	addiw	a5,a5,1
     da4:	fef42623          	sw	a5,-20(s0)
     da8:	fd042783          	lw	a5,-48(s0)
     dac:	fff7879b          	addiw	a5,a5,-1
     db0:	fcf42823          	sw	a5,-48(s0)
     db4:	fd042783          	lw	a5,-48(s0)
     db8:	0007879b          	sext.w	a5,a5
     dbc:	fc07d0e3          	bgez	a5,d7c <vprintfmt+0x508>
     dc0:	f8040023          	sb	zero,-128(s0)
     dc4:	2700006f          	j	1034 <vprintfmt+0x7c0>
     dc8:	f5043783          	ld	a5,-176(s0)
     dcc:	0007c783          	lbu	a5,0(a5)
     dd0:	00078713          	mv	a4,a5
     dd4:	06400793          	li	a5,100
     dd8:	02f70663          	beq	a4,a5,e04 <vprintfmt+0x590>
     ddc:	f5043783          	ld	a5,-176(s0)
     de0:	0007c783          	lbu	a5,0(a5)
     de4:	00078713          	mv	a4,a5
     de8:	06900793          	li	a5,105
     dec:	00f70c63          	beq	a4,a5,e04 <vprintfmt+0x590>
     df0:	f5043783          	ld	a5,-176(s0)
     df4:	0007c783          	lbu	a5,0(a5)
     df8:	00078713          	mv	a4,a5
     dfc:	07500793          	li	a5,117
     e00:	08f71063          	bne	a4,a5,e80 <vprintfmt+0x60c>
     e04:	f8144783          	lbu	a5,-127(s0)
     e08:	00078c63          	beqz	a5,e20 <vprintfmt+0x5ac>
     e0c:	f4843783          	ld	a5,-184(s0)
     e10:	00878713          	addi	a4,a5,8
     e14:	f4e43423          	sd	a4,-184(s0)
     e18:	0007b783          	ld	a5,0(a5)
     e1c:	0140006f          	j	e30 <vprintfmt+0x5bc>
     e20:	f4843783          	ld	a5,-184(s0)
     e24:	00878713          	addi	a4,a5,8
     e28:	f4e43423          	sd	a4,-184(s0)
     e2c:	0007a783          	lw	a5,0(a5)
     e30:	faf43423          	sd	a5,-88(s0)
     e34:	fa843583          	ld	a1,-88(s0)
     e38:	f5043783          	ld	a5,-176(s0)
     e3c:	0007c783          	lbu	a5,0(a5)
     e40:	0007871b          	sext.w	a4,a5
     e44:	07500793          	li	a5,117
     e48:	40f707b3          	sub	a5,a4,a5
     e4c:	00f037b3          	snez	a5,a5
     e50:	0ff7f793          	zext.b	a5,a5
     e54:	f8040713          	addi	a4,s0,-128
     e58:	00070693          	mv	a3,a4
     e5c:	00078613          	mv	a2,a5
     e60:	f5843503          	ld	a0,-168(s0)
     e64:	f08ff0ef          	jal	56c <print_dec_int>
     e68:	00050793          	mv	a5,a0
     e6c:	fec42703          	lw	a4,-20(s0)
     e70:	00f707bb          	addw	a5,a4,a5
     e74:	fef42623          	sw	a5,-20(s0)
     e78:	f8040023          	sb	zero,-128(s0)
     e7c:	1b80006f          	j	1034 <vprintfmt+0x7c0>
     e80:	f5043783          	ld	a5,-176(s0)
     e84:	0007c783          	lbu	a5,0(a5)
     e88:	00078713          	mv	a4,a5
     e8c:	06e00793          	li	a5,110
     e90:	04f71c63          	bne	a4,a5,ee8 <vprintfmt+0x674>
     e94:	f8144783          	lbu	a5,-127(s0)
     e98:	02078463          	beqz	a5,ec0 <vprintfmt+0x64c>
     e9c:	f4843783          	ld	a5,-184(s0)
     ea0:	00878713          	addi	a4,a5,8
     ea4:	f4e43423          	sd	a4,-184(s0)
     ea8:	0007b783          	ld	a5,0(a5)
     eac:	faf43823          	sd	a5,-80(s0)
     eb0:	fec42703          	lw	a4,-20(s0)
     eb4:	fb043783          	ld	a5,-80(s0)
     eb8:	00e7b023          	sd	a4,0(a5)
     ebc:	0240006f          	j	ee0 <vprintfmt+0x66c>
     ec0:	f4843783          	ld	a5,-184(s0)
     ec4:	00878713          	addi	a4,a5,8
     ec8:	f4e43423          	sd	a4,-184(s0)
     ecc:	0007b783          	ld	a5,0(a5)
     ed0:	faf43c23          	sd	a5,-72(s0)
     ed4:	fb843783          	ld	a5,-72(s0)
     ed8:	fec42703          	lw	a4,-20(s0)
     edc:	00e7a023          	sw	a4,0(a5)
     ee0:	f8040023          	sb	zero,-128(s0)
     ee4:	1500006f          	j	1034 <vprintfmt+0x7c0>
     ee8:	f5043783          	ld	a5,-176(s0)
     eec:	0007c783          	lbu	a5,0(a5)
     ef0:	00078713          	mv	a4,a5
     ef4:	07300793          	li	a5,115
     ef8:	02f71e63          	bne	a4,a5,f34 <vprintfmt+0x6c0>
     efc:	f4843783          	ld	a5,-184(s0)
     f00:	00878713          	addi	a4,a5,8
     f04:	f4e43423          	sd	a4,-184(s0)
     f08:	0007b783          	ld	a5,0(a5)
     f0c:	fcf43023          	sd	a5,-64(s0)
     f10:	fc043583          	ld	a1,-64(s0)
     f14:	f5843503          	ld	a0,-168(s0)
     f18:	dccff0ef          	jal	4e4 <puts_wo_nl>
     f1c:	00050793          	mv	a5,a0
     f20:	fec42703          	lw	a4,-20(s0)
     f24:	00f707bb          	addw	a5,a4,a5
     f28:	fef42623          	sw	a5,-20(s0)
     f2c:	f8040023          	sb	zero,-128(s0)
     f30:	1040006f          	j	1034 <vprintfmt+0x7c0>
     f34:	f5043783          	ld	a5,-176(s0)
     f38:	0007c783          	lbu	a5,0(a5)
     f3c:	00078713          	mv	a4,a5
     f40:	06300793          	li	a5,99
     f44:	02f71e63          	bne	a4,a5,f80 <vprintfmt+0x70c>
     f48:	f4843783          	ld	a5,-184(s0)
     f4c:	00878713          	addi	a4,a5,8
     f50:	f4e43423          	sd	a4,-184(s0)
     f54:	0007a783          	lw	a5,0(a5)
     f58:	fcf42623          	sw	a5,-52(s0)
     f5c:	fcc42703          	lw	a4,-52(s0)
     f60:	f5843783          	ld	a5,-168(s0)
     f64:	00070513          	mv	a0,a4
     f68:	000780e7          	jalr	a5
     f6c:	fec42783          	lw	a5,-20(s0)
     f70:	0017879b          	addiw	a5,a5,1
     f74:	fef42623          	sw	a5,-20(s0)
     f78:	f8040023          	sb	zero,-128(s0)
     f7c:	0b80006f          	j	1034 <vprintfmt+0x7c0>
     f80:	f5043783          	ld	a5,-176(s0)
     f84:	0007c783          	lbu	a5,0(a5)
     f88:	00078713          	mv	a4,a5
     f8c:	02500793          	li	a5,37
     f90:	02f71263          	bne	a4,a5,fb4 <vprintfmt+0x740>
     f94:	f5843783          	ld	a5,-168(s0)
     f98:	02500513          	li	a0,37
     f9c:	000780e7          	jalr	a5
     fa0:	fec42783          	lw	a5,-20(s0)
     fa4:	0017879b          	addiw	a5,a5,1
     fa8:	fef42623          	sw	a5,-20(s0)
     fac:	f8040023          	sb	zero,-128(s0)
     fb0:	0840006f          	j	1034 <vprintfmt+0x7c0>
     fb4:	f5043783          	ld	a5,-176(s0)
     fb8:	0007c783          	lbu	a5,0(a5)
     fbc:	0007871b          	sext.w	a4,a5
     fc0:	f5843783          	ld	a5,-168(s0)
     fc4:	00070513          	mv	a0,a4
     fc8:	000780e7          	jalr	a5
     fcc:	fec42783          	lw	a5,-20(s0)
     fd0:	0017879b          	addiw	a5,a5,1
     fd4:	fef42623          	sw	a5,-20(s0)
     fd8:	f8040023          	sb	zero,-128(s0)
     fdc:	0580006f          	j	1034 <vprintfmt+0x7c0>
     fe0:	f5043783          	ld	a5,-176(s0)
     fe4:	0007c783          	lbu	a5,0(a5)
     fe8:	00078713          	mv	a4,a5
     fec:	02500793          	li	a5,37
     ff0:	02f71063          	bne	a4,a5,1010 <vprintfmt+0x79c>
     ff4:	f8043023          	sd	zero,-128(s0)
     ff8:	f8043423          	sd	zero,-120(s0)
     ffc:	00100793          	li	a5,1
    1000:	f8f40023          	sb	a5,-128(s0)
    1004:	fff00793          	li	a5,-1
    1008:	f8f42623          	sw	a5,-116(s0)
    100c:	0280006f          	j	1034 <vprintfmt+0x7c0>
    1010:	f5043783          	ld	a5,-176(s0)
    1014:	0007c783          	lbu	a5,0(a5)
    1018:	0007871b          	sext.w	a4,a5
    101c:	f5843783          	ld	a5,-168(s0)
    1020:	00070513          	mv	a0,a4
    1024:	000780e7          	jalr	a5
    1028:	fec42783          	lw	a5,-20(s0)
    102c:	0017879b          	addiw	a5,a5,1
    1030:	fef42623          	sw	a5,-20(s0)
    1034:	f5043783          	ld	a5,-176(s0)
    1038:	00178793          	addi	a5,a5,1
    103c:	f4f43823          	sd	a5,-176(s0)
    1040:	f5043783          	ld	a5,-176(s0)
    1044:	0007c783          	lbu	a5,0(a5)
    1048:	84079ce3          	bnez	a5,8a0 <vprintfmt+0x2c>
    104c:	fec42783          	lw	a5,-20(s0)
    1050:	00078513          	mv	a0,a5
    1054:	0b813083          	ld	ra,184(sp)
    1058:	0b013403          	ld	s0,176(sp)
    105c:	0c010113          	addi	sp,sp,192
    1060:	00008067          	ret

Disassembly of section .text.printf:

0000000000001064 <printf>:
    1064:	f8010113          	addi	sp,sp,-128
    1068:	02113c23          	sd	ra,56(sp)
    106c:	02813823          	sd	s0,48(sp)
    1070:	04010413          	addi	s0,sp,64
    1074:	fca43423          	sd	a0,-56(s0)
    1078:	00b43423          	sd	a1,8(s0)
    107c:	00c43823          	sd	a2,16(s0)
    1080:	00d43c23          	sd	a3,24(s0)
    1084:	02e43023          	sd	a4,32(s0)
    1088:	02f43423          	sd	a5,40(s0)
    108c:	03043823          	sd	a6,48(s0)
    1090:	03143c23          	sd	a7,56(s0)
    1094:	fe042623          	sw	zero,-20(s0)
    1098:	04040793          	addi	a5,s0,64
    109c:	fcf43023          	sd	a5,-64(s0)
    10a0:	fc043783          	ld	a5,-64(s0)
    10a4:	fc878793          	addi	a5,a5,-56
    10a8:	fcf43823          	sd	a5,-48(s0)
    10ac:	fd043783          	ld	a5,-48(s0)
    10b0:	00078613          	mv	a2,a5
    10b4:	fc843583          	ld	a1,-56(s0)
    10b8:	fffff517          	auipc	a0,0xfffff
    10bc:	0f850513          	addi	a0,a0,248 # 1b0 <putc>
    10c0:	fb4ff0ef          	jal	874 <vprintfmt>
    10c4:	00050793          	mv	a5,a0
    10c8:	fef42623          	sw	a5,-20(s0)
    10cc:	00100793          	li	a5,1
    10d0:	fef43023          	sd	a5,-32(s0)
    10d4:	00000797          	auipc	a5,0x0
    10d8:	2fc78793          	addi	a5,a5,764 # 13d0 <tail>
    10dc:	0007a783          	lw	a5,0(a5)
    10e0:	0017871b          	addiw	a4,a5,1
    10e4:	0007069b          	sext.w	a3,a4
    10e8:	00000717          	auipc	a4,0x0
    10ec:	2e870713          	addi	a4,a4,744 # 13d0 <tail>
    10f0:	00d72023          	sw	a3,0(a4)
    10f4:	00000717          	auipc	a4,0x0
    10f8:	2e470713          	addi	a4,a4,740 # 13d8 <buffer>
    10fc:	00f707b3          	add	a5,a4,a5
    1100:	00078023          	sb	zero,0(a5)
    1104:	00000797          	auipc	a5,0x0
    1108:	2cc78793          	addi	a5,a5,716 # 13d0 <tail>
    110c:	0007a603          	lw	a2,0(a5)
    1110:	fe043703          	ld	a4,-32(s0)
    1114:	00000697          	auipc	a3,0x0
    1118:	2c468693          	addi	a3,a3,708 # 13d8 <buffer>
    111c:	fd843783          	ld	a5,-40(s0)
    1120:	04000893          	li	a7,64
    1124:	00070513          	mv	a0,a4
    1128:	00068593          	mv	a1,a3
    112c:	00060613          	mv	a2,a2
    1130:	00000073          	ecall
    1134:	00050793          	mv	a5,a0
    1138:	fcf43c23          	sd	a5,-40(s0)
    113c:	00000797          	auipc	a5,0x0
    1140:	29478793          	addi	a5,a5,660 # 13d0 <tail>
    1144:	0007a023          	sw	zero,0(a5)
    1148:	fec42783          	lw	a5,-20(s0)
    114c:	00078513          	mv	a0,a5
    1150:	03813083          	ld	ra,56(sp)
    1154:	03013403          	ld	s0,48(sp)
    1158:	08010113          	addi	sp,sp,128
    115c:	00008067          	ret
