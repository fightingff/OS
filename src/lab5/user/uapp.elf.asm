
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
  64:	2b050513          	addi	a0,a0,688 # 1310 <printf+0x2c8>
  68:	7e1000ef          	jal	1048 <printf>
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
  d8:	fe010113          	addi	sp,sp,-32
  dc:	00113c23          	sd	ra,24(sp)
  e0:	00813823          	sd	s0,16(sp)
  e4:	02010413          	addi	s0,sp,32
  e8:	f51ff0ef          	jal	38 <fork>
  ec:	00050793          	mv	a5,a0
  f0:	fef42623          	sw	a5,-20(s0)
  f4:	fec42783          	lw	a5,-20(s0)
  f8:	0007879b          	sext.w	a5,a5
  fc:	04079863          	bnez	a5,14c <main+0x74>
 100:	f05ff0ef          	jal	4 <getpid>
 104:	00050593          	mv	a1,a0
 108:	00001797          	auipc	a5,0x1
 10c:	2ec78793          	addi	a5,a5,748 # 13f4 <global_variable>
 110:	0007a783          	lw	a5,0(a5)
 114:	0017871b          	addiw	a4,a5,1
 118:	0007069b          	sext.w	a3,a4
 11c:	00001717          	auipc	a4,0x1
 120:	2d870713          	addi	a4,a4,728 # 13f4 <global_variable>
 124:	00d72023          	sw	a3,0(a4)
 128:	00078613          	mv	a2,a5
 12c:	00001517          	auipc	a0,0x1
 130:	20c50513          	addi	a0,a0,524 # 1338 <printf+0x2f0>
 134:	715000ef          	jal	1048 <printf>
 138:	500007b7          	lui	a5,0x50000
 13c:	fff78513          	addi	a0,a5,-1 # 4fffffff <buffer+0x4fffebff>
 140:	f45ff0ef          	jal	84 <wait>
 144:	00000013          	nop
 148:	fb9ff06f          	j	100 <main+0x28>
 14c:	eb9ff0ef          	jal	4 <getpid>
 150:	00050593          	mv	a1,a0
 154:	00001797          	auipc	a5,0x1
 158:	2a078793          	addi	a5,a5,672 # 13f4 <global_variable>
 15c:	0007a783          	lw	a5,0(a5)
 160:	0017871b          	addiw	a4,a5,1
 164:	0007069b          	sext.w	a3,a4
 168:	00001717          	auipc	a4,0x1
 16c:	28c70713          	addi	a4,a4,652 # 13f4 <global_variable>
 170:	00d72023          	sw	a3,0(a4)
 174:	00078613          	mv	a2,a5
 178:	00001517          	auipc	a0,0x1
 17c:	1f850513          	addi	a0,a0,504 # 1370 <printf+0x328>
 180:	6c9000ef          	jal	1048 <printf>
 184:	500007b7          	lui	a5,0x50000
 188:	fff78513          	addi	a0,a5,-1 # 4fffffff <buffer+0x4fffebff>
 18c:	ef9ff0ef          	jal	84 <wait>
 190:	fbdff06f          	j	14c <main+0x74>

Disassembly of section .text.putc:

0000000000000194 <putc>:
 194:	fe010113          	addi	sp,sp,-32
 198:	00813c23          	sd	s0,24(sp)
 19c:	02010413          	addi	s0,sp,32
 1a0:	00050793          	mv	a5,a0
 1a4:	fef42623          	sw	a5,-20(s0)
 1a8:	00001797          	auipc	a5,0x1
 1ac:	25078793          	addi	a5,a5,592 # 13f8 <tail>
 1b0:	0007a783          	lw	a5,0(a5)
 1b4:	0017871b          	addiw	a4,a5,1
 1b8:	0007069b          	sext.w	a3,a4
 1bc:	00001717          	auipc	a4,0x1
 1c0:	23c70713          	addi	a4,a4,572 # 13f8 <tail>
 1c4:	00d72023          	sw	a3,0(a4)
 1c8:	fec42703          	lw	a4,-20(s0)
 1cc:	0ff77713          	zext.b	a4,a4
 1d0:	00001697          	auipc	a3,0x1
 1d4:	23068693          	addi	a3,a3,560 # 1400 <buffer>
 1d8:	00f687b3          	add	a5,a3,a5
 1dc:	00e78023          	sb	a4,0(a5)
 1e0:	fec42783          	lw	a5,-20(s0)
 1e4:	0ff7f793          	zext.b	a5,a5
 1e8:	0007879b          	sext.w	a5,a5
 1ec:	00078513          	mv	a0,a5
 1f0:	01813403          	ld	s0,24(sp)
 1f4:	02010113          	addi	sp,sp,32
 1f8:	00008067          	ret

Disassembly of section .text.isspace:

00000000000001fc <isspace>:
 1fc:	fe010113          	addi	sp,sp,-32
 200:	00813c23          	sd	s0,24(sp)
 204:	02010413          	addi	s0,sp,32
 208:	00050793          	mv	a5,a0
 20c:	fef42623          	sw	a5,-20(s0)
 210:	fec42783          	lw	a5,-20(s0)
 214:	0007871b          	sext.w	a4,a5
 218:	02000793          	li	a5,32
 21c:	02f70263          	beq	a4,a5,240 <isspace+0x44>
 220:	fec42783          	lw	a5,-20(s0)
 224:	0007871b          	sext.w	a4,a5
 228:	00800793          	li	a5,8
 22c:	00e7de63          	bge	a5,a4,248 <isspace+0x4c>
 230:	fec42783          	lw	a5,-20(s0)
 234:	0007871b          	sext.w	a4,a5
 238:	00d00793          	li	a5,13
 23c:	00e7c663          	blt	a5,a4,248 <isspace+0x4c>
 240:	00100793          	li	a5,1
 244:	0080006f          	j	24c <isspace+0x50>
 248:	00000793          	li	a5,0
 24c:	00078513          	mv	a0,a5
 250:	01813403          	ld	s0,24(sp)
 254:	02010113          	addi	sp,sp,32
 258:	00008067          	ret

Disassembly of section .text.strtol:

000000000000025c <strtol>:
 25c:	fb010113          	addi	sp,sp,-80
 260:	04113423          	sd	ra,72(sp)
 264:	04813023          	sd	s0,64(sp)
 268:	05010413          	addi	s0,sp,80
 26c:	fca43423          	sd	a0,-56(s0)
 270:	fcb43023          	sd	a1,-64(s0)
 274:	00060793          	mv	a5,a2
 278:	faf42e23          	sw	a5,-68(s0)
 27c:	fe043423          	sd	zero,-24(s0)
 280:	fe0403a3          	sb	zero,-25(s0)
 284:	fc843783          	ld	a5,-56(s0)
 288:	fcf43c23          	sd	a5,-40(s0)
 28c:	0100006f          	j	29c <strtol+0x40>
 290:	fd843783          	ld	a5,-40(s0)
 294:	00178793          	addi	a5,a5,1
 298:	fcf43c23          	sd	a5,-40(s0)
 29c:	fd843783          	ld	a5,-40(s0)
 2a0:	0007c783          	lbu	a5,0(a5)
 2a4:	0007879b          	sext.w	a5,a5
 2a8:	00078513          	mv	a0,a5
 2ac:	f51ff0ef          	jal	1fc <isspace>
 2b0:	00050793          	mv	a5,a0
 2b4:	fc079ee3          	bnez	a5,290 <strtol+0x34>
 2b8:	fd843783          	ld	a5,-40(s0)
 2bc:	0007c783          	lbu	a5,0(a5)
 2c0:	00078713          	mv	a4,a5
 2c4:	02d00793          	li	a5,45
 2c8:	00f71e63          	bne	a4,a5,2e4 <strtol+0x88>
 2cc:	00100793          	li	a5,1
 2d0:	fef403a3          	sb	a5,-25(s0)
 2d4:	fd843783          	ld	a5,-40(s0)
 2d8:	00178793          	addi	a5,a5,1
 2dc:	fcf43c23          	sd	a5,-40(s0)
 2e0:	0240006f          	j	304 <strtol+0xa8>
 2e4:	fd843783          	ld	a5,-40(s0)
 2e8:	0007c783          	lbu	a5,0(a5)
 2ec:	00078713          	mv	a4,a5
 2f0:	02b00793          	li	a5,43
 2f4:	00f71863          	bne	a4,a5,304 <strtol+0xa8>
 2f8:	fd843783          	ld	a5,-40(s0)
 2fc:	00178793          	addi	a5,a5,1
 300:	fcf43c23          	sd	a5,-40(s0)
 304:	fbc42783          	lw	a5,-68(s0)
 308:	0007879b          	sext.w	a5,a5
 30c:	06079c63          	bnez	a5,384 <strtol+0x128>
 310:	fd843783          	ld	a5,-40(s0)
 314:	0007c783          	lbu	a5,0(a5)
 318:	00078713          	mv	a4,a5
 31c:	03000793          	li	a5,48
 320:	04f71e63          	bne	a4,a5,37c <strtol+0x120>
 324:	fd843783          	ld	a5,-40(s0)
 328:	00178793          	addi	a5,a5,1
 32c:	fcf43c23          	sd	a5,-40(s0)
 330:	fd843783          	ld	a5,-40(s0)
 334:	0007c783          	lbu	a5,0(a5)
 338:	00078713          	mv	a4,a5
 33c:	07800793          	li	a5,120
 340:	00f70c63          	beq	a4,a5,358 <strtol+0xfc>
 344:	fd843783          	ld	a5,-40(s0)
 348:	0007c783          	lbu	a5,0(a5)
 34c:	00078713          	mv	a4,a5
 350:	05800793          	li	a5,88
 354:	00f71e63          	bne	a4,a5,370 <strtol+0x114>
 358:	01000793          	li	a5,16
 35c:	faf42e23          	sw	a5,-68(s0)
 360:	fd843783          	ld	a5,-40(s0)
 364:	00178793          	addi	a5,a5,1
 368:	fcf43c23          	sd	a5,-40(s0)
 36c:	0180006f          	j	384 <strtol+0x128>
 370:	00800793          	li	a5,8
 374:	faf42e23          	sw	a5,-68(s0)
 378:	00c0006f          	j	384 <strtol+0x128>
 37c:	00a00793          	li	a5,10
 380:	faf42e23          	sw	a5,-68(s0)
 384:	fd843783          	ld	a5,-40(s0)
 388:	0007c783          	lbu	a5,0(a5)
 38c:	00078713          	mv	a4,a5
 390:	02f00793          	li	a5,47
 394:	02e7f863          	bgeu	a5,a4,3c4 <strtol+0x168>
 398:	fd843783          	ld	a5,-40(s0)
 39c:	0007c783          	lbu	a5,0(a5)
 3a0:	00078713          	mv	a4,a5
 3a4:	03900793          	li	a5,57
 3a8:	00e7ee63          	bltu	a5,a4,3c4 <strtol+0x168>
 3ac:	fd843783          	ld	a5,-40(s0)
 3b0:	0007c783          	lbu	a5,0(a5)
 3b4:	0007879b          	sext.w	a5,a5
 3b8:	fd07879b          	addiw	a5,a5,-48
 3bc:	fcf42a23          	sw	a5,-44(s0)
 3c0:	0800006f          	j	440 <strtol+0x1e4>
 3c4:	fd843783          	ld	a5,-40(s0)
 3c8:	0007c783          	lbu	a5,0(a5)
 3cc:	00078713          	mv	a4,a5
 3d0:	06000793          	li	a5,96
 3d4:	02e7f863          	bgeu	a5,a4,404 <strtol+0x1a8>
 3d8:	fd843783          	ld	a5,-40(s0)
 3dc:	0007c783          	lbu	a5,0(a5)
 3e0:	00078713          	mv	a4,a5
 3e4:	07a00793          	li	a5,122
 3e8:	00e7ee63          	bltu	a5,a4,404 <strtol+0x1a8>
 3ec:	fd843783          	ld	a5,-40(s0)
 3f0:	0007c783          	lbu	a5,0(a5)
 3f4:	0007879b          	sext.w	a5,a5
 3f8:	fa97879b          	addiw	a5,a5,-87
 3fc:	fcf42a23          	sw	a5,-44(s0)
 400:	0400006f          	j	440 <strtol+0x1e4>
 404:	fd843783          	ld	a5,-40(s0)
 408:	0007c783          	lbu	a5,0(a5)
 40c:	00078713          	mv	a4,a5
 410:	04000793          	li	a5,64
 414:	06e7f863          	bgeu	a5,a4,484 <strtol+0x228>
 418:	fd843783          	ld	a5,-40(s0)
 41c:	0007c783          	lbu	a5,0(a5)
 420:	00078713          	mv	a4,a5
 424:	05a00793          	li	a5,90
 428:	04e7ee63          	bltu	a5,a4,484 <strtol+0x228>
 42c:	fd843783          	ld	a5,-40(s0)
 430:	0007c783          	lbu	a5,0(a5)
 434:	0007879b          	sext.w	a5,a5
 438:	fc97879b          	addiw	a5,a5,-55
 43c:	fcf42a23          	sw	a5,-44(s0)
 440:	fd442783          	lw	a5,-44(s0)
 444:	00078713          	mv	a4,a5
 448:	fbc42783          	lw	a5,-68(s0)
 44c:	0007071b          	sext.w	a4,a4
 450:	0007879b          	sext.w	a5,a5
 454:	02f75663          	bge	a4,a5,480 <strtol+0x224>
 458:	fbc42703          	lw	a4,-68(s0)
 45c:	fe843783          	ld	a5,-24(s0)
 460:	02f70733          	mul	a4,a4,a5
 464:	fd442783          	lw	a5,-44(s0)
 468:	00f707b3          	add	a5,a4,a5
 46c:	fef43423          	sd	a5,-24(s0)
 470:	fd843783          	ld	a5,-40(s0)
 474:	00178793          	addi	a5,a5,1
 478:	fcf43c23          	sd	a5,-40(s0)
 47c:	f09ff06f          	j	384 <strtol+0x128>
 480:	00000013          	nop
 484:	fc043783          	ld	a5,-64(s0)
 488:	00078863          	beqz	a5,498 <strtol+0x23c>
 48c:	fc043783          	ld	a5,-64(s0)
 490:	fd843703          	ld	a4,-40(s0)
 494:	00e7b023          	sd	a4,0(a5)
 498:	fe744783          	lbu	a5,-25(s0)
 49c:	0ff7f793          	zext.b	a5,a5
 4a0:	00078863          	beqz	a5,4b0 <strtol+0x254>
 4a4:	fe843783          	ld	a5,-24(s0)
 4a8:	40f007b3          	neg	a5,a5
 4ac:	0080006f          	j	4b4 <strtol+0x258>
 4b0:	fe843783          	ld	a5,-24(s0)
 4b4:	00078513          	mv	a0,a5
 4b8:	04813083          	ld	ra,72(sp)
 4bc:	04013403          	ld	s0,64(sp)
 4c0:	05010113          	addi	sp,sp,80
 4c4:	00008067          	ret

Disassembly of section .text.puts_wo_nl:

00000000000004c8 <puts_wo_nl>:
 4c8:	fd010113          	addi	sp,sp,-48
 4cc:	02113423          	sd	ra,40(sp)
 4d0:	02813023          	sd	s0,32(sp)
 4d4:	03010413          	addi	s0,sp,48
 4d8:	fca43c23          	sd	a0,-40(s0)
 4dc:	fcb43823          	sd	a1,-48(s0)
 4e0:	fd043783          	ld	a5,-48(s0)
 4e4:	00079863          	bnez	a5,4f4 <puts_wo_nl+0x2c>
 4e8:	00001797          	auipc	a5,0x1
 4ec:	ec078793          	addi	a5,a5,-320 # 13a8 <printf+0x360>
 4f0:	fcf43823          	sd	a5,-48(s0)
 4f4:	fd043783          	ld	a5,-48(s0)
 4f8:	fef43423          	sd	a5,-24(s0)
 4fc:	0240006f          	j	520 <puts_wo_nl+0x58>
 500:	fe843783          	ld	a5,-24(s0)
 504:	00178713          	addi	a4,a5,1
 508:	fee43423          	sd	a4,-24(s0)
 50c:	0007c783          	lbu	a5,0(a5)
 510:	0007871b          	sext.w	a4,a5
 514:	fd843783          	ld	a5,-40(s0)
 518:	00070513          	mv	a0,a4
 51c:	000780e7          	jalr	a5
 520:	fe843783          	ld	a5,-24(s0)
 524:	0007c783          	lbu	a5,0(a5)
 528:	fc079ce3          	bnez	a5,500 <puts_wo_nl+0x38>
 52c:	fe843703          	ld	a4,-24(s0)
 530:	fd043783          	ld	a5,-48(s0)
 534:	40f707b3          	sub	a5,a4,a5
 538:	0007879b          	sext.w	a5,a5
 53c:	00078513          	mv	a0,a5
 540:	02813083          	ld	ra,40(sp)
 544:	02013403          	ld	s0,32(sp)
 548:	03010113          	addi	sp,sp,48
 54c:	00008067          	ret

Disassembly of section .text.print_dec_int:

0000000000000550 <print_dec_int>:
 550:	f9010113          	addi	sp,sp,-112
 554:	06113423          	sd	ra,104(sp)
 558:	06813023          	sd	s0,96(sp)
 55c:	07010413          	addi	s0,sp,112
 560:	faa43423          	sd	a0,-88(s0)
 564:	fab43023          	sd	a1,-96(s0)
 568:	00060793          	mv	a5,a2
 56c:	f8d43823          	sd	a3,-112(s0)
 570:	f8f40fa3          	sb	a5,-97(s0)
 574:	f9f44783          	lbu	a5,-97(s0)
 578:	0ff7f793          	zext.b	a5,a5
 57c:	02078663          	beqz	a5,5a8 <print_dec_int+0x58>
 580:	fa043703          	ld	a4,-96(s0)
 584:	fff00793          	li	a5,-1
 588:	03f79793          	slli	a5,a5,0x3f
 58c:	00f71e63          	bne	a4,a5,5a8 <print_dec_int+0x58>
 590:	00001597          	auipc	a1,0x1
 594:	e2058593          	addi	a1,a1,-480 # 13b0 <printf+0x368>
 598:	fa843503          	ld	a0,-88(s0)
 59c:	f2dff0ef          	jal	4c8 <puts_wo_nl>
 5a0:	00050793          	mv	a5,a0
 5a4:	2a00006f          	j	844 <print_dec_int+0x2f4>
 5a8:	f9043783          	ld	a5,-112(s0)
 5ac:	00c7a783          	lw	a5,12(a5)
 5b0:	00079a63          	bnez	a5,5c4 <print_dec_int+0x74>
 5b4:	fa043783          	ld	a5,-96(s0)
 5b8:	00079663          	bnez	a5,5c4 <print_dec_int+0x74>
 5bc:	00000793          	li	a5,0
 5c0:	2840006f          	j	844 <print_dec_int+0x2f4>
 5c4:	fe0407a3          	sb	zero,-17(s0)
 5c8:	f9f44783          	lbu	a5,-97(s0)
 5cc:	0ff7f793          	zext.b	a5,a5
 5d0:	02078063          	beqz	a5,5f0 <print_dec_int+0xa0>
 5d4:	fa043783          	ld	a5,-96(s0)
 5d8:	0007dc63          	bgez	a5,5f0 <print_dec_int+0xa0>
 5dc:	00100793          	li	a5,1
 5e0:	fef407a3          	sb	a5,-17(s0)
 5e4:	fa043783          	ld	a5,-96(s0)
 5e8:	40f007b3          	neg	a5,a5
 5ec:	faf43023          	sd	a5,-96(s0)
 5f0:	fe042423          	sw	zero,-24(s0)
 5f4:	f9f44783          	lbu	a5,-97(s0)
 5f8:	0ff7f793          	zext.b	a5,a5
 5fc:	02078863          	beqz	a5,62c <print_dec_int+0xdc>
 600:	fef44783          	lbu	a5,-17(s0)
 604:	0ff7f793          	zext.b	a5,a5
 608:	00079e63          	bnez	a5,624 <print_dec_int+0xd4>
 60c:	f9043783          	ld	a5,-112(s0)
 610:	0057c783          	lbu	a5,5(a5)
 614:	00079863          	bnez	a5,624 <print_dec_int+0xd4>
 618:	f9043783          	ld	a5,-112(s0)
 61c:	0047c783          	lbu	a5,4(a5)
 620:	00078663          	beqz	a5,62c <print_dec_int+0xdc>
 624:	00100793          	li	a5,1
 628:	0080006f          	j	630 <print_dec_int+0xe0>
 62c:	00000793          	li	a5,0
 630:	fcf40ba3          	sb	a5,-41(s0)
 634:	fd744783          	lbu	a5,-41(s0)
 638:	0017f793          	andi	a5,a5,1
 63c:	fcf40ba3          	sb	a5,-41(s0)
 640:	fa043703          	ld	a4,-96(s0)
 644:	00a00793          	li	a5,10
 648:	02f777b3          	remu	a5,a4,a5
 64c:	0ff7f713          	zext.b	a4,a5
 650:	fe842783          	lw	a5,-24(s0)
 654:	0017869b          	addiw	a3,a5,1
 658:	fed42423          	sw	a3,-24(s0)
 65c:	0307071b          	addiw	a4,a4,48
 660:	0ff77713          	zext.b	a4,a4
 664:	ff078793          	addi	a5,a5,-16
 668:	008787b3          	add	a5,a5,s0
 66c:	fce78423          	sb	a4,-56(a5)
 670:	fa043703          	ld	a4,-96(s0)
 674:	00a00793          	li	a5,10
 678:	02f757b3          	divu	a5,a4,a5
 67c:	faf43023          	sd	a5,-96(s0)
 680:	fa043783          	ld	a5,-96(s0)
 684:	fa079ee3          	bnez	a5,640 <print_dec_int+0xf0>
 688:	f9043783          	ld	a5,-112(s0)
 68c:	00c7a783          	lw	a5,12(a5)
 690:	00078713          	mv	a4,a5
 694:	fff00793          	li	a5,-1
 698:	02f71063          	bne	a4,a5,6b8 <print_dec_int+0x168>
 69c:	f9043783          	ld	a5,-112(s0)
 6a0:	0037c783          	lbu	a5,3(a5)
 6a4:	00078a63          	beqz	a5,6b8 <print_dec_int+0x168>
 6a8:	f9043783          	ld	a5,-112(s0)
 6ac:	0087a703          	lw	a4,8(a5)
 6b0:	f9043783          	ld	a5,-112(s0)
 6b4:	00e7a623          	sw	a4,12(a5)
 6b8:	fe042223          	sw	zero,-28(s0)
 6bc:	f9043783          	ld	a5,-112(s0)
 6c0:	0087a703          	lw	a4,8(a5)
 6c4:	fe842783          	lw	a5,-24(s0)
 6c8:	fcf42823          	sw	a5,-48(s0)
 6cc:	f9043783          	ld	a5,-112(s0)
 6d0:	00c7a783          	lw	a5,12(a5)
 6d4:	fcf42623          	sw	a5,-52(s0)
 6d8:	fd042783          	lw	a5,-48(s0)
 6dc:	00078593          	mv	a1,a5
 6e0:	fcc42783          	lw	a5,-52(s0)
 6e4:	00078613          	mv	a2,a5
 6e8:	0006069b          	sext.w	a3,a2
 6ec:	0005879b          	sext.w	a5,a1
 6f0:	00f6d463          	bge	a3,a5,6f8 <print_dec_int+0x1a8>
 6f4:	00058613          	mv	a2,a1
 6f8:	0006079b          	sext.w	a5,a2
 6fc:	40f707bb          	subw	a5,a4,a5
 700:	0007871b          	sext.w	a4,a5
 704:	fd744783          	lbu	a5,-41(s0)
 708:	0007879b          	sext.w	a5,a5
 70c:	40f707bb          	subw	a5,a4,a5
 710:	fef42023          	sw	a5,-32(s0)
 714:	0280006f          	j	73c <print_dec_int+0x1ec>
 718:	fa843783          	ld	a5,-88(s0)
 71c:	02000513          	li	a0,32
 720:	000780e7          	jalr	a5
 724:	fe442783          	lw	a5,-28(s0)
 728:	0017879b          	addiw	a5,a5,1
 72c:	fef42223          	sw	a5,-28(s0)
 730:	fe042783          	lw	a5,-32(s0)
 734:	fff7879b          	addiw	a5,a5,-1
 738:	fef42023          	sw	a5,-32(s0)
 73c:	fe042783          	lw	a5,-32(s0)
 740:	0007879b          	sext.w	a5,a5
 744:	fcf04ae3          	bgtz	a5,718 <print_dec_int+0x1c8>
 748:	fd744783          	lbu	a5,-41(s0)
 74c:	0ff7f793          	zext.b	a5,a5
 750:	04078463          	beqz	a5,798 <print_dec_int+0x248>
 754:	fef44783          	lbu	a5,-17(s0)
 758:	0ff7f793          	zext.b	a5,a5
 75c:	00078663          	beqz	a5,768 <print_dec_int+0x218>
 760:	02d00793          	li	a5,45
 764:	01c0006f          	j	780 <print_dec_int+0x230>
 768:	f9043783          	ld	a5,-112(s0)
 76c:	0057c783          	lbu	a5,5(a5)
 770:	00078663          	beqz	a5,77c <print_dec_int+0x22c>
 774:	02b00793          	li	a5,43
 778:	0080006f          	j	780 <print_dec_int+0x230>
 77c:	02000793          	li	a5,32
 780:	fa843703          	ld	a4,-88(s0)
 784:	00078513          	mv	a0,a5
 788:	000700e7          	jalr	a4
 78c:	fe442783          	lw	a5,-28(s0)
 790:	0017879b          	addiw	a5,a5,1
 794:	fef42223          	sw	a5,-28(s0)
 798:	fe842783          	lw	a5,-24(s0)
 79c:	fcf42e23          	sw	a5,-36(s0)
 7a0:	0280006f          	j	7c8 <print_dec_int+0x278>
 7a4:	fa843783          	ld	a5,-88(s0)
 7a8:	03000513          	li	a0,48
 7ac:	000780e7          	jalr	a5
 7b0:	fe442783          	lw	a5,-28(s0)
 7b4:	0017879b          	addiw	a5,a5,1
 7b8:	fef42223          	sw	a5,-28(s0)
 7bc:	fdc42783          	lw	a5,-36(s0)
 7c0:	0017879b          	addiw	a5,a5,1
 7c4:	fcf42e23          	sw	a5,-36(s0)
 7c8:	f9043783          	ld	a5,-112(s0)
 7cc:	00c7a703          	lw	a4,12(a5)
 7d0:	fd744783          	lbu	a5,-41(s0)
 7d4:	0007879b          	sext.w	a5,a5
 7d8:	40f707bb          	subw	a5,a4,a5
 7dc:	0007871b          	sext.w	a4,a5
 7e0:	fdc42783          	lw	a5,-36(s0)
 7e4:	0007879b          	sext.w	a5,a5
 7e8:	fae7cee3          	blt	a5,a4,7a4 <print_dec_int+0x254>
 7ec:	fe842783          	lw	a5,-24(s0)
 7f0:	fff7879b          	addiw	a5,a5,-1
 7f4:	fcf42c23          	sw	a5,-40(s0)
 7f8:	03c0006f          	j	834 <print_dec_int+0x2e4>
 7fc:	fd842783          	lw	a5,-40(s0)
 800:	ff078793          	addi	a5,a5,-16
 804:	008787b3          	add	a5,a5,s0
 808:	fc87c783          	lbu	a5,-56(a5)
 80c:	0007871b          	sext.w	a4,a5
 810:	fa843783          	ld	a5,-88(s0)
 814:	00070513          	mv	a0,a4
 818:	000780e7          	jalr	a5
 81c:	fe442783          	lw	a5,-28(s0)
 820:	0017879b          	addiw	a5,a5,1
 824:	fef42223          	sw	a5,-28(s0)
 828:	fd842783          	lw	a5,-40(s0)
 82c:	fff7879b          	addiw	a5,a5,-1
 830:	fcf42c23          	sw	a5,-40(s0)
 834:	fd842783          	lw	a5,-40(s0)
 838:	0007879b          	sext.w	a5,a5
 83c:	fc07d0e3          	bgez	a5,7fc <print_dec_int+0x2ac>
 840:	fe442783          	lw	a5,-28(s0)
 844:	00078513          	mv	a0,a5
 848:	06813083          	ld	ra,104(sp)
 84c:	06013403          	ld	s0,96(sp)
 850:	07010113          	addi	sp,sp,112
 854:	00008067          	ret

Disassembly of section .text.vprintfmt:

0000000000000858 <vprintfmt>:
     858:	f4010113          	addi	sp,sp,-192
     85c:	0a113c23          	sd	ra,184(sp)
     860:	0a813823          	sd	s0,176(sp)
     864:	0c010413          	addi	s0,sp,192
     868:	f4a43c23          	sd	a0,-168(s0)
     86c:	f4b43823          	sd	a1,-176(s0)
     870:	f4c43423          	sd	a2,-184(s0)
     874:	f8043023          	sd	zero,-128(s0)
     878:	f8043423          	sd	zero,-120(s0)
     87c:	fe042623          	sw	zero,-20(s0)
     880:	7a40006f          	j	1024 <vprintfmt+0x7cc>
     884:	f8044783          	lbu	a5,-128(s0)
     888:	72078e63          	beqz	a5,fc4 <vprintfmt+0x76c>
     88c:	f5043783          	ld	a5,-176(s0)
     890:	0007c783          	lbu	a5,0(a5)
     894:	00078713          	mv	a4,a5
     898:	02300793          	li	a5,35
     89c:	00f71863          	bne	a4,a5,8ac <vprintfmt+0x54>
     8a0:	00100793          	li	a5,1
     8a4:	f8f40123          	sb	a5,-126(s0)
     8a8:	7700006f          	j	1018 <vprintfmt+0x7c0>
     8ac:	f5043783          	ld	a5,-176(s0)
     8b0:	0007c783          	lbu	a5,0(a5)
     8b4:	00078713          	mv	a4,a5
     8b8:	03000793          	li	a5,48
     8bc:	00f71863          	bne	a4,a5,8cc <vprintfmt+0x74>
     8c0:	00100793          	li	a5,1
     8c4:	f8f401a3          	sb	a5,-125(s0)
     8c8:	7500006f          	j	1018 <vprintfmt+0x7c0>
     8cc:	f5043783          	ld	a5,-176(s0)
     8d0:	0007c783          	lbu	a5,0(a5)
     8d4:	00078713          	mv	a4,a5
     8d8:	06c00793          	li	a5,108
     8dc:	04f70063          	beq	a4,a5,91c <vprintfmt+0xc4>
     8e0:	f5043783          	ld	a5,-176(s0)
     8e4:	0007c783          	lbu	a5,0(a5)
     8e8:	00078713          	mv	a4,a5
     8ec:	07a00793          	li	a5,122
     8f0:	02f70663          	beq	a4,a5,91c <vprintfmt+0xc4>
     8f4:	f5043783          	ld	a5,-176(s0)
     8f8:	0007c783          	lbu	a5,0(a5)
     8fc:	00078713          	mv	a4,a5
     900:	07400793          	li	a5,116
     904:	00f70c63          	beq	a4,a5,91c <vprintfmt+0xc4>
     908:	f5043783          	ld	a5,-176(s0)
     90c:	0007c783          	lbu	a5,0(a5)
     910:	00078713          	mv	a4,a5
     914:	06a00793          	li	a5,106
     918:	00f71863          	bne	a4,a5,928 <vprintfmt+0xd0>
     91c:	00100793          	li	a5,1
     920:	f8f400a3          	sb	a5,-127(s0)
     924:	6f40006f          	j	1018 <vprintfmt+0x7c0>
     928:	f5043783          	ld	a5,-176(s0)
     92c:	0007c783          	lbu	a5,0(a5)
     930:	00078713          	mv	a4,a5
     934:	02b00793          	li	a5,43
     938:	00f71863          	bne	a4,a5,948 <vprintfmt+0xf0>
     93c:	00100793          	li	a5,1
     940:	f8f402a3          	sb	a5,-123(s0)
     944:	6d40006f          	j	1018 <vprintfmt+0x7c0>
     948:	f5043783          	ld	a5,-176(s0)
     94c:	0007c783          	lbu	a5,0(a5)
     950:	00078713          	mv	a4,a5
     954:	02000793          	li	a5,32
     958:	00f71863          	bne	a4,a5,968 <vprintfmt+0x110>
     95c:	00100793          	li	a5,1
     960:	f8f40223          	sb	a5,-124(s0)
     964:	6b40006f          	j	1018 <vprintfmt+0x7c0>
     968:	f5043783          	ld	a5,-176(s0)
     96c:	0007c783          	lbu	a5,0(a5)
     970:	00078713          	mv	a4,a5
     974:	02a00793          	li	a5,42
     978:	00f71e63          	bne	a4,a5,994 <vprintfmt+0x13c>
     97c:	f4843783          	ld	a5,-184(s0)
     980:	00878713          	addi	a4,a5,8
     984:	f4e43423          	sd	a4,-184(s0)
     988:	0007a783          	lw	a5,0(a5)
     98c:	f8f42423          	sw	a5,-120(s0)
     990:	6880006f          	j	1018 <vprintfmt+0x7c0>
     994:	f5043783          	ld	a5,-176(s0)
     998:	0007c783          	lbu	a5,0(a5)
     99c:	00078713          	mv	a4,a5
     9a0:	03000793          	li	a5,48
     9a4:	04e7f663          	bgeu	a5,a4,9f0 <vprintfmt+0x198>
     9a8:	f5043783          	ld	a5,-176(s0)
     9ac:	0007c783          	lbu	a5,0(a5)
     9b0:	00078713          	mv	a4,a5
     9b4:	03900793          	li	a5,57
     9b8:	02e7ec63          	bltu	a5,a4,9f0 <vprintfmt+0x198>
     9bc:	f5043783          	ld	a5,-176(s0)
     9c0:	f5040713          	addi	a4,s0,-176
     9c4:	00a00613          	li	a2,10
     9c8:	00070593          	mv	a1,a4
     9cc:	00078513          	mv	a0,a5
     9d0:	88dff0ef          	jal	25c <strtol>
     9d4:	00050793          	mv	a5,a0
     9d8:	0007879b          	sext.w	a5,a5
     9dc:	f8f42423          	sw	a5,-120(s0)
     9e0:	f5043783          	ld	a5,-176(s0)
     9e4:	fff78793          	addi	a5,a5,-1
     9e8:	f4f43823          	sd	a5,-176(s0)
     9ec:	62c0006f          	j	1018 <vprintfmt+0x7c0>
     9f0:	f5043783          	ld	a5,-176(s0)
     9f4:	0007c783          	lbu	a5,0(a5)
     9f8:	00078713          	mv	a4,a5
     9fc:	02e00793          	li	a5,46
     a00:	06f71863          	bne	a4,a5,a70 <vprintfmt+0x218>
     a04:	f5043783          	ld	a5,-176(s0)
     a08:	00178793          	addi	a5,a5,1
     a0c:	f4f43823          	sd	a5,-176(s0)
     a10:	f5043783          	ld	a5,-176(s0)
     a14:	0007c783          	lbu	a5,0(a5)
     a18:	00078713          	mv	a4,a5
     a1c:	02a00793          	li	a5,42
     a20:	00f71e63          	bne	a4,a5,a3c <vprintfmt+0x1e4>
     a24:	f4843783          	ld	a5,-184(s0)
     a28:	00878713          	addi	a4,a5,8
     a2c:	f4e43423          	sd	a4,-184(s0)
     a30:	0007a783          	lw	a5,0(a5)
     a34:	f8f42623          	sw	a5,-116(s0)
     a38:	5e00006f          	j	1018 <vprintfmt+0x7c0>
     a3c:	f5043783          	ld	a5,-176(s0)
     a40:	f5040713          	addi	a4,s0,-176
     a44:	00a00613          	li	a2,10
     a48:	00070593          	mv	a1,a4
     a4c:	00078513          	mv	a0,a5
     a50:	80dff0ef          	jal	25c <strtol>
     a54:	00050793          	mv	a5,a0
     a58:	0007879b          	sext.w	a5,a5
     a5c:	f8f42623          	sw	a5,-116(s0)
     a60:	f5043783          	ld	a5,-176(s0)
     a64:	fff78793          	addi	a5,a5,-1
     a68:	f4f43823          	sd	a5,-176(s0)
     a6c:	5ac0006f          	j	1018 <vprintfmt+0x7c0>
     a70:	f5043783          	ld	a5,-176(s0)
     a74:	0007c783          	lbu	a5,0(a5)
     a78:	00078713          	mv	a4,a5
     a7c:	07800793          	li	a5,120
     a80:	02f70663          	beq	a4,a5,aac <vprintfmt+0x254>
     a84:	f5043783          	ld	a5,-176(s0)
     a88:	0007c783          	lbu	a5,0(a5)
     a8c:	00078713          	mv	a4,a5
     a90:	05800793          	li	a5,88
     a94:	00f70c63          	beq	a4,a5,aac <vprintfmt+0x254>
     a98:	f5043783          	ld	a5,-176(s0)
     a9c:	0007c783          	lbu	a5,0(a5)
     aa0:	00078713          	mv	a4,a5
     aa4:	07000793          	li	a5,112
     aa8:	30f71263          	bne	a4,a5,dac <vprintfmt+0x554>
     aac:	f5043783          	ld	a5,-176(s0)
     ab0:	0007c783          	lbu	a5,0(a5)
     ab4:	00078713          	mv	a4,a5
     ab8:	07000793          	li	a5,112
     abc:	00f70663          	beq	a4,a5,ac8 <vprintfmt+0x270>
     ac0:	f8144783          	lbu	a5,-127(s0)
     ac4:	00078663          	beqz	a5,ad0 <vprintfmt+0x278>
     ac8:	00100793          	li	a5,1
     acc:	0080006f          	j	ad4 <vprintfmt+0x27c>
     ad0:	00000793          	li	a5,0
     ad4:	faf403a3          	sb	a5,-89(s0)
     ad8:	fa744783          	lbu	a5,-89(s0)
     adc:	0017f793          	andi	a5,a5,1
     ae0:	faf403a3          	sb	a5,-89(s0)
     ae4:	fa744783          	lbu	a5,-89(s0)
     ae8:	0ff7f793          	zext.b	a5,a5
     aec:	00078c63          	beqz	a5,b04 <vprintfmt+0x2ac>
     af0:	f4843783          	ld	a5,-184(s0)
     af4:	00878713          	addi	a4,a5,8
     af8:	f4e43423          	sd	a4,-184(s0)
     afc:	0007b783          	ld	a5,0(a5)
     b00:	01c0006f          	j	b1c <vprintfmt+0x2c4>
     b04:	f4843783          	ld	a5,-184(s0)
     b08:	00878713          	addi	a4,a5,8
     b0c:	f4e43423          	sd	a4,-184(s0)
     b10:	0007a783          	lw	a5,0(a5)
     b14:	02079793          	slli	a5,a5,0x20
     b18:	0207d793          	srli	a5,a5,0x20
     b1c:	fef43023          	sd	a5,-32(s0)
     b20:	f8c42783          	lw	a5,-116(s0)
     b24:	02079463          	bnez	a5,b4c <vprintfmt+0x2f4>
     b28:	fe043783          	ld	a5,-32(s0)
     b2c:	02079063          	bnez	a5,b4c <vprintfmt+0x2f4>
     b30:	f5043783          	ld	a5,-176(s0)
     b34:	0007c783          	lbu	a5,0(a5)
     b38:	00078713          	mv	a4,a5
     b3c:	07000793          	li	a5,112
     b40:	00f70663          	beq	a4,a5,b4c <vprintfmt+0x2f4>
     b44:	f8040023          	sb	zero,-128(s0)
     b48:	4d00006f          	j	1018 <vprintfmt+0x7c0>
     b4c:	f5043783          	ld	a5,-176(s0)
     b50:	0007c783          	lbu	a5,0(a5)
     b54:	00078713          	mv	a4,a5
     b58:	07000793          	li	a5,112
     b5c:	00f70a63          	beq	a4,a5,b70 <vprintfmt+0x318>
     b60:	f8244783          	lbu	a5,-126(s0)
     b64:	00078a63          	beqz	a5,b78 <vprintfmt+0x320>
     b68:	fe043783          	ld	a5,-32(s0)
     b6c:	00078663          	beqz	a5,b78 <vprintfmt+0x320>
     b70:	00100793          	li	a5,1
     b74:	0080006f          	j	b7c <vprintfmt+0x324>
     b78:	00000793          	li	a5,0
     b7c:	faf40323          	sb	a5,-90(s0)
     b80:	fa644783          	lbu	a5,-90(s0)
     b84:	0017f793          	andi	a5,a5,1
     b88:	faf40323          	sb	a5,-90(s0)
     b8c:	fc042e23          	sw	zero,-36(s0)
     b90:	f5043783          	ld	a5,-176(s0)
     b94:	0007c783          	lbu	a5,0(a5)
     b98:	00078713          	mv	a4,a5
     b9c:	05800793          	li	a5,88
     ba0:	00f71863          	bne	a4,a5,bb0 <vprintfmt+0x358>
     ba4:	00001797          	auipc	a5,0x1
     ba8:	82478793          	addi	a5,a5,-2012 # 13c8 <upperxdigits.1>
     bac:	00c0006f          	j	bb8 <vprintfmt+0x360>
     bb0:	00001797          	auipc	a5,0x1
     bb4:	83078793          	addi	a5,a5,-2000 # 13e0 <lowerxdigits.0>
     bb8:	f8f43c23          	sd	a5,-104(s0)
     bbc:	fe043783          	ld	a5,-32(s0)
     bc0:	00f7f793          	andi	a5,a5,15
     bc4:	f9843703          	ld	a4,-104(s0)
     bc8:	00f70733          	add	a4,a4,a5
     bcc:	fdc42783          	lw	a5,-36(s0)
     bd0:	0017869b          	addiw	a3,a5,1
     bd4:	fcd42e23          	sw	a3,-36(s0)
     bd8:	00074703          	lbu	a4,0(a4)
     bdc:	ff078793          	addi	a5,a5,-16
     be0:	008787b3          	add	a5,a5,s0
     be4:	f8e78023          	sb	a4,-128(a5)
     be8:	fe043783          	ld	a5,-32(s0)
     bec:	0047d793          	srli	a5,a5,0x4
     bf0:	fef43023          	sd	a5,-32(s0)
     bf4:	fe043783          	ld	a5,-32(s0)
     bf8:	fc0792e3          	bnez	a5,bbc <vprintfmt+0x364>
     bfc:	f8c42783          	lw	a5,-116(s0)
     c00:	00078713          	mv	a4,a5
     c04:	fff00793          	li	a5,-1
     c08:	02f71663          	bne	a4,a5,c34 <vprintfmt+0x3dc>
     c0c:	f8344783          	lbu	a5,-125(s0)
     c10:	02078263          	beqz	a5,c34 <vprintfmt+0x3dc>
     c14:	f8842703          	lw	a4,-120(s0)
     c18:	fa644783          	lbu	a5,-90(s0)
     c1c:	0007879b          	sext.w	a5,a5
     c20:	0017979b          	slliw	a5,a5,0x1
     c24:	0007879b          	sext.w	a5,a5
     c28:	40f707bb          	subw	a5,a4,a5
     c2c:	0007879b          	sext.w	a5,a5
     c30:	f8f42623          	sw	a5,-116(s0)
     c34:	f8842703          	lw	a4,-120(s0)
     c38:	fa644783          	lbu	a5,-90(s0)
     c3c:	0007879b          	sext.w	a5,a5
     c40:	0017979b          	slliw	a5,a5,0x1
     c44:	0007879b          	sext.w	a5,a5
     c48:	40f707bb          	subw	a5,a4,a5
     c4c:	0007871b          	sext.w	a4,a5
     c50:	fdc42783          	lw	a5,-36(s0)
     c54:	f8f42a23          	sw	a5,-108(s0)
     c58:	f8c42783          	lw	a5,-116(s0)
     c5c:	f8f42823          	sw	a5,-112(s0)
     c60:	f9442783          	lw	a5,-108(s0)
     c64:	00078593          	mv	a1,a5
     c68:	f9042783          	lw	a5,-112(s0)
     c6c:	00078613          	mv	a2,a5
     c70:	0006069b          	sext.w	a3,a2
     c74:	0005879b          	sext.w	a5,a1
     c78:	00f6d463          	bge	a3,a5,c80 <vprintfmt+0x428>
     c7c:	00058613          	mv	a2,a1
     c80:	0006079b          	sext.w	a5,a2
     c84:	40f707bb          	subw	a5,a4,a5
     c88:	fcf42c23          	sw	a5,-40(s0)
     c8c:	0280006f          	j	cb4 <vprintfmt+0x45c>
     c90:	f5843783          	ld	a5,-168(s0)
     c94:	02000513          	li	a0,32
     c98:	000780e7          	jalr	a5
     c9c:	fec42783          	lw	a5,-20(s0)
     ca0:	0017879b          	addiw	a5,a5,1
     ca4:	fef42623          	sw	a5,-20(s0)
     ca8:	fd842783          	lw	a5,-40(s0)
     cac:	fff7879b          	addiw	a5,a5,-1
     cb0:	fcf42c23          	sw	a5,-40(s0)
     cb4:	fd842783          	lw	a5,-40(s0)
     cb8:	0007879b          	sext.w	a5,a5
     cbc:	fcf04ae3          	bgtz	a5,c90 <vprintfmt+0x438>
     cc0:	fa644783          	lbu	a5,-90(s0)
     cc4:	0ff7f793          	zext.b	a5,a5
     cc8:	04078463          	beqz	a5,d10 <vprintfmt+0x4b8>
     ccc:	f5843783          	ld	a5,-168(s0)
     cd0:	03000513          	li	a0,48
     cd4:	000780e7          	jalr	a5
     cd8:	f5043783          	ld	a5,-176(s0)
     cdc:	0007c783          	lbu	a5,0(a5)
     ce0:	00078713          	mv	a4,a5
     ce4:	05800793          	li	a5,88
     ce8:	00f71663          	bne	a4,a5,cf4 <vprintfmt+0x49c>
     cec:	05800793          	li	a5,88
     cf0:	0080006f          	j	cf8 <vprintfmt+0x4a0>
     cf4:	07800793          	li	a5,120
     cf8:	f5843703          	ld	a4,-168(s0)
     cfc:	00078513          	mv	a0,a5
     d00:	000700e7          	jalr	a4
     d04:	fec42783          	lw	a5,-20(s0)
     d08:	0027879b          	addiw	a5,a5,2
     d0c:	fef42623          	sw	a5,-20(s0)
     d10:	fdc42783          	lw	a5,-36(s0)
     d14:	fcf42a23          	sw	a5,-44(s0)
     d18:	0280006f          	j	d40 <vprintfmt+0x4e8>
     d1c:	f5843783          	ld	a5,-168(s0)
     d20:	03000513          	li	a0,48
     d24:	000780e7          	jalr	a5
     d28:	fec42783          	lw	a5,-20(s0)
     d2c:	0017879b          	addiw	a5,a5,1
     d30:	fef42623          	sw	a5,-20(s0)
     d34:	fd442783          	lw	a5,-44(s0)
     d38:	0017879b          	addiw	a5,a5,1
     d3c:	fcf42a23          	sw	a5,-44(s0)
     d40:	f8c42703          	lw	a4,-116(s0)
     d44:	fd442783          	lw	a5,-44(s0)
     d48:	0007879b          	sext.w	a5,a5
     d4c:	fce7c8e3          	blt	a5,a4,d1c <vprintfmt+0x4c4>
     d50:	fdc42783          	lw	a5,-36(s0)
     d54:	fff7879b          	addiw	a5,a5,-1
     d58:	fcf42823          	sw	a5,-48(s0)
     d5c:	03c0006f          	j	d98 <vprintfmt+0x540>
     d60:	fd042783          	lw	a5,-48(s0)
     d64:	ff078793          	addi	a5,a5,-16
     d68:	008787b3          	add	a5,a5,s0
     d6c:	f807c783          	lbu	a5,-128(a5)
     d70:	0007871b          	sext.w	a4,a5
     d74:	f5843783          	ld	a5,-168(s0)
     d78:	00070513          	mv	a0,a4
     d7c:	000780e7          	jalr	a5
     d80:	fec42783          	lw	a5,-20(s0)
     d84:	0017879b          	addiw	a5,a5,1
     d88:	fef42623          	sw	a5,-20(s0)
     d8c:	fd042783          	lw	a5,-48(s0)
     d90:	fff7879b          	addiw	a5,a5,-1
     d94:	fcf42823          	sw	a5,-48(s0)
     d98:	fd042783          	lw	a5,-48(s0)
     d9c:	0007879b          	sext.w	a5,a5
     da0:	fc07d0e3          	bgez	a5,d60 <vprintfmt+0x508>
     da4:	f8040023          	sb	zero,-128(s0)
     da8:	2700006f          	j	1018 <vprintfmt+0x7c0>
     dac:	f5043783          	ld	a5,-176(s0)
     db0:	0007c783          	lbu	a5,0(a5)
     db4:	00078713          	mv	a4,a5
     db8:	06400793          	li	a5,100
     dbc:	02f70663          	beq	a4,a5,de8 <vprintfmt+0x590>
     dc0:	f5043783          	ld	a5,-176(s0)
     dc4:	0007c783          	lbu	a5,0(a5)
     dc8:	00078713          	mv	a4,a5
     dcc:	06900793          	li	a5,105
     dd0:	00f70c63          	beq	a4,a5,de8 <vprintfmt+0x590>
     dd4:	f5043783          	ld	a5,-176(s0)
     dd8:	0007c783          	lbu	a5,0(a5)
     ddc:	00078713          	mv	a4,a5
     de0:	07500793          	li	a5,117
     de4:	08f71063          	bne	a4,a5,e64 <vprintfmt+0x60c>
     de8:	f8144783          	lbu	a5,-127(s0)
     dec:	00078c63          	beqz	a5,e04 <vprintfmt+0x5ac>
     df0:	f4843783          	ld	a5,-184(s0)
     df4:	00878713          	addi	a4,a5,8
     df8:	f4e43423          	sd	a4,-184(s0)
     dfc:	0007b783          	ld	a5,0(a5)
     e00:	0140006f          	j	e14 <vprintfmt+0x5bc>
     e04:	f4843783          	ld	a5,-184(s0)
     e08:	00878713          	addi	a4,a5,8
     e0c:	f4e43423          	sd	a4,-184(s0)
     e10:	0007a783          	lw	a5,0(a5)
     e14:	faf43423          	sd	a5,-88(s0)
     e18:	fa843583          	ld	a1,-88(s0)
     e1c:	f5043783          	ld	a5,-176(s0)
     e20:	0007c783          	lbu	a5,0(a5)
     e24:	0007871b          	sext.w	a4,a5
     e28:	07500793          	li	a5,117
     e2c:	40f707b3          	sub	a5,a4,a5
     e30:	00f037b3          	snez	a5,a5
     e34:	0ff7f793          	zext.b	a5,a5
     e38:	f8040713          	addi	a4,s0,-128
     e3c:	00070693          	mv	a3,a4
     e40:	00078613          	mv	a2,a5
     e44:	f5843503          	ld	a0,-168(s0)
     e48:	f08ff0ef          	jal	550 <print_dec_int>
     e4c:	00050793          	mv	a5,a0
     e50:	fec42703          	lw	a4,-20(s0)
     e54:	00f707bb          	addw	a5,a4,a5
     e58:	fef42623          	sw	a5,-20(s0)
     e5c:	f8040023          	sb	zero,-128(s0)
     e60:	1b80006f          	j	1018 <vprintfmt+0x7c0>
     e64:	f5043783          	ld	a5,-176(s0)
     e68:	0007c783          	lbu	a5,0(a5)
     e6c:	00078713          	mv	a4,a5
     e70:	06e00793          	li	a5,110
     e74:	04f71c63          	bne	a4,a5,ecc <vprintfmt+0x674>
     e78:	f8144783          	lbu	a5,-127(s0)
     e7c:	02078463          	beqz	a5,ea4 <vprintfmt+0x64c>
     e80:	f4843783          	ld	a5,-184(s0)
     e84:	00878713          	addi	a4,a5,8
     e88:	f4e43423          	sd	a4,-184(s0)
     e8c:	0007b783          	ld	a5,0(a5)
     e90:	faf43823          	sd	a5,-80(s0)
     e94:	fec42703          	lw	a4,-20(s0)
     e98:	fb043783          	ld	a5,-80(s0)
     e9c:	00e7b023          	sd	a4,0(a5)
     ea0:	0240006f          	j	ec4 <vprintfmt+0x66c>
     ea4:	f4843783          	ld	a5,-184(s0)
     ea8:	00878713          	addi	a4,a5,8
     eac:	f4e43423          	sd	a4,-184(s0)
     eb0:	0007b783          	ld	a5,0(a5)
     eb4:	faf43c23          	sd	a5,-72(s0)
     eb8:	fb843783          	ld	a5,-72(s0)
     ebc:	fec42703          	lw	a4,-20(s0)
     ec0:	00e7a023          	sw	a4,0(a5)
     ec4:	f8040023          	sb	zero,-128(s0)
     ec8:	1500006f          	j	1018 <vprintfmt+0x7c0>
     ecc:	f5043783          	ld	a5,-176(s0)
     ed0:	0007c783          	lbu	a5,0(a5)
     ed4:	00078713          	mv	a4,a5
     ed8:	07300793          	li	a5,115
     edc:	02f71e63          	bne	a4,a5,f18 <vprintfmt+0x6c0>
     ee0:	f4843783          	ld	a5,-184(s0)
     ee4:	00878713          	addi	a4,a5,8
     ee8:	f4e43423          	sd	a4,-184(s0)
     eec:	0007b783          	ld	a5,0(a5)
     ef0:	fcf43023          	sd	a5,-64(s0)
     ef4:	fc043583          	ld	a1,-64(s0)
     ef8:	f5843503          	ld	a0,-168(s0)
     efc:	dccff0ef          	jal	4c8 <puts_wo_nl>
     f00:	00050793          	mv	a5,a0
     f04:	fec42703          	lw	a4,-20(s0)
     f08:	00f707bb          	addw	a5,a4,a5
     f0c:	fef42623          	sw	a5,-20(s0)
     f10:	f8040023          	sb	zero,-128(s0)
     f14:	1040006f          	j	1018 <vprintfmt+0x7c0>
     f18:	f5043783          	ld	a5,-176(s0)
     f1c:	0007c783          	lbu	a5,0(a5)
     f20:	00078713          	mv	a4,a5
     f24:	06300793          	li	a5,99
     f28:	02f71e63          	bne	a4,a5,f64 <vprintfmt+0x70c>
     f2c:	f4843783          	ld	a5,-184(s0)
     f30:	00878713          	addi	a4,a5,8
     f34:	f4e43423          	sd	a4,-184(s0)
     f38:	0007a783          	lw	a5,0(a5)
     f3c:	fcf42623          	sw	a5,-52(s0)
     f40:	fcc42703          	lw	a4,-52(s0)
     f44:	f5843783          	ld	a5,-168(s0)
     f48:	00070513          	mv	a0,a4
     f4c:	000780e7          	jalr	a5
     f50:	fec42783          	lw	a5,-20(s0)
     f54:	0017879b          	addiw	a5,a5,1
     f58:	fef42623          	sw	a5,-20(s0)
     f5c:	f8040023          	sb	zero,-128(s0)
     f60:	0b80006f          	j	1018 <vprintfmt+0x7c0>
     f64:	f5043783          	ld	a5,-176(s0)
     f68:	0007c783          	lbu	a5,0(a5)
     f6c:	00078713          	mv	a4,a5
     f70:	02500793          	li	a5,37
     f74:	02f71263          	bne	a4,a5,f98 <vprintfmt+0x740>
     f78:	f5843783          	ld	a5,-168(s0)
     f7c:	02500513          	li	a0,37
     f80:	000780e7          	jalr	a5
     f84:	fec42783          	lw	a5,-20(s0)
     f88:	0017879b          	addiw	a5,a5,1
     f8c:	fef42623          	sw	a5,-20(s0)
     f90:	f8040023          	sb	zero,-128(s0)
     f94:	0840006f          	j	1018 <vprintfmt+0x7c0>
     f98:	f5043783          	ld	a5,-176(s0)
     f9c:	0007c783          	lbu	a5,0(a5)
     fa0:	0007871b          	sext.w	a4,a5
     fa4:	f5843783          	ld	a5,-168(s0)
     fa8:	00070513          	mv	a0,a4
     fac:	000780e7          	jalr	a5
     fb0:	fec42783          	lw	a5,-20(s0)
     fb4:	0017879b          	addiw	a5,a5,1
     fb8:	fef42623          	sw	a5,-20(s0)
     fbc:	f8040023          	sb	zero,-128(s0)
     fc0:	0580006f          	j	1018 <vprintfmt+0x7c0>
     fc4:	f5043783          	ld	a5,-176(s0)
     fc8:	0007c783          	lbu	a5,0(a5)
     fcc:	00078713          	mv	a4,a5
     fd0:	02500793          	li	a5,37
     fd4:	02f71063          	bne	a4,a5,ff4 <vprintfmt+0x79c>
     fd8:	f8043023          	sd	zero,-128(s0)
     fdc:	f8043423          	sd	zero,-120(s0)
     fe0:	00100793          	li	a5,1
     fe4:	f8f40023          	sb	a5,-128(s0)
     fe8:	fff00793          	li	a5,-1
     fec:	f8f42623          	sw	a5,-116(s0)
     ff0:	0280006f          	j	1018 <vprintfmt+0x7c0>
     ff4:	f5043783          	ld	a5,-176(s0)
     ff8:	0007c783          	lbu	a5,0(a5)
     ffc:	0007871b          	sext.w	a4,a5
    1000:	f5843783          	ld	a5,-168(s0)
    1004:	00070513          	mv	a0,a4
    1008:	000780e7          	jalr	a5
    100c:	fec42783          	lw	a5,-20(s0)
    1010:	0017879b          	addiw	a5,a5,1
    1014:	fef42623          	sw	a5,-20(s0)
    1018:	f5043783          	ld	a5,-176(s0)
    101c:	00178793          	addi	a5,a5,1
    1020:	f4f43823          	sd	a5,-176(s0)
    1024:	f5043783          	ld	a5,-176(s0)
    1028:	0007c783          	lbu	a5,0(a5)
    102c:	84079ce3          	bnez	a5,884 <vprintfmt+0x2c>
    1030:	fec42783          	lw	a5,-20(s0)
    1034:	00078513          	mv	a0,a5
    1038:	0b813083          	ld	ra,184(sp)
    103c:	0b013403          	ld	s0,176(sp)
    1040:	0c010113          	addi	sp,sp,192
    1044:	00008067          	ret

Disassembly of section .text.printf:

0000000000001048 <printf>:
    1048:	f8010113          	addi	sp,sp,-128
    104c:	02113c23          	sd	ra,56(sp)
    1050:	02813823          	sd	s0,48(sp)
    1054:	04010413          	addi	s0,sp,64
    1058:	fca43423          	sd	a0,-56(s0)
    105c:	00b43423          	sd	a1,8(s0)
    1060:	00c43823          	sd	a2,16(s0)
    1064:	00d43c23          	sd	a3,24(s0)
    1068:	02e43023          	sd	a4,32(s0)
    106c:	02f43423          	sd	a5,40(s0)
    1070:	03043823          	sd	a6,48(s0)
    1074:	03143c23          	sd	a7,56(s0)
    1078:	fe042623          	sw	zero,-20(s0)
    107c:	04040793          	addi	a5,s0,64
    1080:	fcf43023          	sd	a5,-64(s0)
    1084:	fc043783          	ld	a5,-64(s0)
    1088:	fc878793          	addi	a5,a5,-56
    108c:	fcf43823          	sd	a5,-48(s0)
    1090:	fd043783          	ld	a5,-48(s0)
    1094:	00078613          	mv	a2,a5
    1098:	fc843583          	ld	a1,-56(s0)
    109c:	fffff517          	auipc	a0,0xfffff
    10a0:	0f850513          	addi	a0,a0,248 # 194 <putc>
    10a4:	fb4ff0ef          	jal	858 <vprintfmt>
    10a8:	00050793          	mv	a5,a0
    10ac:	fef42623          	sw	a5,-20(s0)
    10b0:	00100793          	li	a5,1
    10b4:	fef43023          	sd	a5,-32(s0)
    10b8:	00000797          	auipc	a5,0x0
    10bc:	34078793          	addi	a5,a5,832 # 13f8 <tail>
    10c0:	0007a783          	lw	a5,0(a5)
    10c4:	0017871b          	addiw	a4,a5,1
    10c8:	0007069b          	sext.w	a3,a4
    10cc:	00000717          	auipc	a4,0x0
    10d0:	32c70713          	addi	a4,a4,812 # 13f8 <tail>
    10d4:	00d72023          	sw	a3,0(a4)
    10d8:	00000717          	auipc	a4,0x0
    10dc:	32870713          	addi	a4,a4,808 # 1400 <buffer>
    10e0:	00f707b3          	add	a5,a4,a5
    10e4:	00078023          	sb	zero,0(a5)
    10e8:	00000797          	auipc	a5,0x0
    10ec:	31078793          	addi	a5,a5,784 # 13f8 <tail>
    10f0:	0007a603          	lw	a2,0(a5)
    10f4:	fe043703          	ld	a4,-32(s0)
    10f8:	00000697          	auipc	a3,0x0
    10fc:	30868693          	addi	a3,a3,776 # 1400 <buffer>
    1100:	fd843783          	ld	a5,-40(s0)
    1104:	04000893          	li	a7,64
    1108:	00070513          	mv	a0,a4
    110c:	00068593          	mv	a1,a3
    1110:	00060613          	mv	a2,a2
    1114:	00000073          	ecall
    1118:	00050793          	mv	a5,a0
    111c:	fcf43c23          	sd	a5,-40(s0)
    1120:	00000797          	auipc	a5,0x0
    1124:	2d878793          	addi	a5,a5,728 # 13f8 <tail>
    1128:	0007a023          	sw	zero,0(a5)
    112c:	fec42783          	lw	a5,-20(s0)
    1130:	00078513          	mv	a0,a5
    1134:	03813083          	ld	ra,56(sp)
    1138:	03013403          	ld	s0,48(sp)
    113c:	08010113          	addi	sp,sp,128
    1140:	00008067          	ret
