
uapp.elf:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000000000000 <_start>:
   0:	1b50006f          	j	9b4 <main>

Disassembly of section .text.atoi:

0000000000000004 <atoi>:
   4:	fd010113          	addi	sp,sp,-48
   8:	02113423          	sd	ra,40(sp)
   c:	02813023          	sd	s0,32(sp)
  10:	03010413          	addi	s0,sp,48
  14:	fca43c23          	sd	a0,-40(s0)
  18:	fe042623          	sw	zero,-20(s0)
  1c:	fd843503          	ld	a0,-40(s0)
  20:	2c1010ef          	jal	1ae0 <strlen>
  24:	00050793          	mv	a5,a0
  28:	fef42223          	sw	a5,-28(s0)
  2c:	fe042423          	sw	zero,-24(s0)
  30:	0500006f          	j	80 <atoi+0x7c>
  34:	fec42783          	lw	a5,-20(s0)
  38:	00078713          	mv	a4,a5
  3c:	00070793          	mv	a5,a4
  40:	0027979b          	slliw	a5,a5,0x2
  44:	00e787bb          	addw	a5,a5,a4
  48:	0017979b          	slliw	a5,a5,0x1
  4c:	0007871b          	sext.w	a4,a5
  50:	fe842783          	lw	a5,-24(s0)
  54:	fd843683          	ld	a3,-40(s0)
  58:	00f687b3          	add	a5,a3,a5
  5c:	0007c783          	lbu	a5,0(a5)
  60:	0007879b          	sext.w	a5,a5
  64:	00f707bb          	addw	a5,a4,a5
  68:	0007879b          	sext.w	a5,a5
  6c:	fd07879b          	addiw	a5,a5,-48
  70:	fef42623          	sw	a5,-20(s0)
  74:	fe842783          	lw	a5,-24(s0)
  78:	0017879b          	addiw	a5,a5,1
  7c:	fef42423          	sw	a5,-24(s0)
  80:	fe842783          	lw	a5,-24(s0)
  84:	00078713          	mv	a4,a5
  88:	fe442783          	lw	a5,-28(s0)
  8c:	0007071b          	sext.w	a4,a4
  90:	0007879b          	sext.w	a5,a5
  94:	faf740e3          	blt	a4,a5,34 <atoi+0x30>
  98:	fec42783          	lw	a5,-20(s0)
  9c:	00078513          	mv	a0,a5
  a0:	02813083          	ld	ra,40(sp)
  a4:	02013403          	ld	s0,32(sp)
  a8:	03010113          	addi	sp,sp,48
  ac:	00008067          	ret

Disassembly of section .text.get_param:

00000000000000b0 <get_param>:
  b0:	fd010113          	addi	sp,sp,-48
  b4:	02113423          	sd	ra,40(sp)
  b8:	02813023          	sd	s0,32(sp)
  bc:	03010413          	addi	s0,sp,48
  c0:	fca43c23          	sd	a0,-40(s0)
  c4:	0100006f          	j	d4 <get_param+0x24>
  c8:	fd843783          	ld	a5,-40(s0)
  cc:	00178793          	addi	a5,a5,1
  d0:	fcf43c23          	sd	a5,-40(s0)
  d4:	fd843783          	ld	a5,-40(s0)
  d8:	0007c783          	lbu	a5,0(a5)
  dc:	00078713          	mv	a4,a5
  e0:	02000793          	li	a5,32
  e4:	fef702e3          	beq	a4,a5,c8 <get_param+0x18>
  e8:	fe042623          	sw	zero,-20(s0)
  ec:	0300006f          	j	11c <get_param+0x6c>
  f0:	fd843703          	ld	a4,-40(s0)
  f4:	00170793          	addi	a5,a4,1
  f8:	fcf43c23          	sd	a5,-40(s0)
  fc:	fec42783          	lw	a5,-20(s0)
 100:	0017869b          	addiw	a3,a5,1
 104:	fed42623          	sw	a3,-20(s0)
 108:	00074703          	lbu	a4,0(a4)
 10c:	00002697          	auipc	a3,0x2
 110:	16468693          	addi	a3,a3,356 # 2270 <string_buf>
 114:	00f687b3          	add	a5,a3,a5
 118:	00e78023          	sb	a4,0(a5)
 11c:	fd843783          	ld	a5,-40(s0)
 120:	0007c783          	lbu	a5,0(a5)
 124:	00078c63          	beqz	a5,13c <get_param+0x8c>
 128:	fd843783          	ld	a5,-40(s0)
 12c:	0007c783          	lbu	a5,0(a5)
 130:	00078713          	mv	a4,a5
 134:	02000793          	li	a5,32
 138:	faf71ce3          	bne	a4,a5,f0 <get_param+0x40>
 13c:	00002717          	auipc	a4,0x2
 140:	13470713          	addi	a4,a4,308 # 2270 <string_buf>
 144:	fec42783          	lw	a5,-20(s0)
 148:	00f707b3          	add	a5,a4,a5
 14c:	00078023          	sb	zero,0(a5)
 150:	00002797          	auipc	a5,0x2
 154:	12078793          	addi	a5,a5,288 # 2270 <string_buf>
 158:	00078513          	mv	a0,a5
 15c:	02813083          	ld	ra,40(sp)
 160:	02013403          	ld	s0,32(sp)
 164:	03010113          	addi	sp,sp,48
 168:	00008067          	ret

Disassembly of section .text.get_string:

000000000000016c <get_string>:
 16c:	fd010113          	addi	sp,sp,-48
 170:	02113423          	sd	ra,40(sp)
 174:	02813023          	sd	s0,32(sp)
 178:	03010413          	addi	s0,sp,48
 17c:	fca43c23          	sd	a0,-40(s0)
 180:	0100006f          	j	190 <get_string+0x24>
 184:	fd843783          	ld	a5,-40(s0)
 188:	00178793          	addi	a5,a5,1
 18c:	fcf43c23          	sd	a5,-40(s0)
 190:	fd843783          	ld	a5,-40(s0)
 194:	0007c783          	lbu	a5,0(a5)
 198:	00078713          	mv	a4,a5
 19c:	02000793          	li	a5,32
 1a0:	fef702e3          	beq	a4,a5,184 <get_string+0x18>
 1a4:	fd843783          	ld	a5,-40(s0)
 1a8:	0007c783          	lbu	a5,0(a5)
 1ac:	00078713          	mv	a4,a5
 1b0:	02200793          	li	a5,34
 1b4:	06f71c63          	bne	a4,a5,22c <get_string+0xc0>
 1b8:	fd843783          	ld	a5,-40(s0)
 1bc:	00178793          	addi	a5,a5,1
 1c0:	fcf43c23          	sd	a5,-40(s0)
 1c4:	fe042623          	sw	zero,-20(s0)
 1c8:	0300006f          	j	1f8 <get_string+0x8c>
 1cc:	fd843703          	ld	a4,-40(s0)
 1d0:	00170793          	addi	a5,a4,1
 1d4:	fcf43c23          	sd	a5,-40(s0)
 1d8:	fec42783          	lw	a5,-20(s0)
 1dc:	0017869b          	addiw	a3,a5,1
 1e0:	fed42623          	sw	a3,-20(s0)
 1e4:	00074703          	lbu	a4,0(a4)
 1e8:	00002697          	auipc	a3,0x2
 1ec:	08868693          	addi	a3,a3,136 # 2270 <string_buf>
 1f0:	00f687b3          	add	a5,a3,a5
 1f4:	00e78023          	sb	a4,0(a5)
 1f8:	fd843783          	ld	a5,-40(s0)
 1fc:	0007c783          	lbu	a5,0(a5)
 200:	00078713          	mv	a4,a5
 204:	02200793          	li	a5,34
 208:	fcf712e3          	bne	a4,a5,1cc <get_string+0x60>
 20c:	00002717          	auipc	a4,0x2
 210:	06470713          	addi	a4,a4,100 # 2270 <string_buf>
 214:	fec42783          	lw	a5,-20(s0)
 218:	00f707b3          	add	a5,a4,a5
 21c:	00078023          	sb	zero,0(a5)
 220:	00002797          	auipc	a5,0x2
 224:	05078793          	addi	a5,a5,80 # 2270 <string_buf>
 228:	0100006f          	j	238 <get_string+0xcc>
 22c:	fd843503          	ld	a0,-40(s0)
 230:	e81ff0ef          	jal	b0 <get_param>
 234:	00050793          	mv	a5,a0
 238:	00078513          	mv	a0,a5
 23c:	02813083          	ld	ra,40(sp)
 240:	02013403          	ld	s0,32(sp)
 244:	03010113          	addi	sp,sp,48
 248:	00008067          	ret

Disassembly of section .text.parse_cmd:

000000000000024c <parse_cmd>:
 24c:	c9010113          	addi	sp,sp,-880
 250:	36113423          	sd	ra,872(sp)
 254:	36813023          	sd	s0,864(sp)
 258:	34913c23          	sd	s1,856(sp)
 25c:	35213823          	sd	s2,848(sp)
 260:	35313423          	sd	s3,840(sp)
 264:	35413023          	sd	s4,832(sp)
 268:	33513c23          	sd	s5,824(sp)
 26c:	33613823          	sd	s6,816(sp)
 270:	33713423          	sd	s7,808(sp)
 274:	33813023          	sd	s8,800(sp)
 278:	31913c23          	sd	s9,792(sp)
 27c:	31a13823          	sd	s10,784(sp)
 280:	31b13423          	sd	s11,776(sp)
 284:	37010413          	addi	s0,sp,880
 288:	d0a43423          	sd	a0,-760(s0)
 28c:	00058793          	mv	a5,a1
 290:	d0f42223          	sw	a5,-764(s0)
 294:	d0843783          	ld	a5,-760(s0)
 298:	0007c783          	lbu	a5,0(a5)
 29c:	00078713          	mv	a4,a5
 2a0:	06500793          	li	a5,101
 2a4:	0af71863          	bne	a4,a5,354 <parse_cmd+0x108>
 2a8:	d0843783          	ld	a5,-760(s0)
 2ac:	00178793          	addi	a5,a5,1
 2b0:	0007c783          	lbu	a5,0(a5)
 2b4:	00078713          	mv	a4,a5
 2b8:	06300793          	li	a5,99
 2bc:	08f71c63          	bne	a4,a5,354 <parse_cmd+0x108>
 2c0:	d0843783          	ld	a5,-760(s0)
 2c4:	00278793          	addi	a5,a5,2
 2c8:	0007c783          	lbu	a5,0(a5)
 2cc:	00078713          	mv	a4,a5
 2d0:	06800793          	li	a5,104
 2d4:	08f71063          	bne	a4,a5,354 <parse_cmd+0x108>
 2d8:	d0843783          	ld	a5,-760(s0)
 2dc:	00378793          	addi	a5,a5,3
 2e0:	0007c783          	lbu	a5,0(a5)
 2e4:	00078713          	mv	a4,a5
 2e8:	06f00793          	li	a5,111
 2ec:	06f71463          	bne	a4,a5,354 <parse_cmd+0x108>
 2f0:	d0843783          	ld	a5,-760(s0)
 2f4:	00478793          	addi	a5,a5,4
 2f8:	d0f43423          	sd	a5,-760(s0)
 2fc:	d0843503          	ld	a0,-760(s0)
 300:	e6dff0ef          	jal	16c <get_string>
 304:	f6a43823          	sd	a0,-144(s0)
 308:	f7043503          	ld	a0,-144(s0)
 30c:	7d4010ef          	jal	1ae0 <strlen>
 310:	00050793          	mv	a5,a0
 314:	d0f42223          	sw	a5,-764(s0)
 318:	d0442783          	lw	a5,-764(s0)
 31c:	d0843703          	ld	a4,-760(s0)
 320:	00f707b3          	add	a5,a4,a5
 324:	d0f43423          	sd	a5,-760(s0)
 328:	d0442783          	lw	a5,-764(s0)
 32c:	00078613          	mv	a2,a5
 330:	f7043583          	ld	a1,-144(s0)
 334:	00100513          	li	a0,1
 338:	7fc010ef          	jal	1b34 <write>
 33c:	00100613          	li	a2,1
 340:	00002597          	auipc	a1,0x2
 344:	b0058593          	addi	a1,a1,-1280 # 1e40 <lseek+0x78>
 348:	00100513          	li	a0,1
 34c:	7e8010ef          	jal	1b34 <write>
 350:	6240006f          	j	974 <parse_cmd+0x728>
 354:	d0843783          	ld	a5,-760(s0)
 358:	0007c783          	lbu	a5,0(a5)
 35c:	00078713          	mv	a4,a5
 360:	06300793          	li	a5,99
 364:	16f71663          	bne	a4,a5,4d0 <parse_cmd+0x284>
 368:	d0843783          	ld	a5,-760(s0)
 36c:	00178793          	addi	a5,a5,1
 370:	0007c783          	lbu	a5,0(a5)
 374:	00078713          	mv	a4,a5
 378:	06100793          	li	a5,97
 37c:	14f71a63          	bne	a4,a5,4d0 <parse_cmd+0x284>
 380:	d0843783          	ld	a5,-760(s0)
 384:	00278793          	addi	a5,a5,2
 388:	0007c783          	lbu	a5,0(a5)
 38c:	00078713          	mv	a4,a5
 390:	07400793          	li	a5,116
 394:	12f71e63          	bne	a4,a5,4d0 <parse_cmd+0x284>
 398:	d0843783          	ld	a5,-760(s0)
 39c:	00378793          	addi	a5,a5,3
 3a0:	00078513          	mv	a0,a5
 3a4:	d0dff0ef          	jal	b0 <get_param>
 3a8:	f6a43423          	sd	a0,-152(s0)
 3ac:	00100593          	li	a1,1
 3b0:	f6843503          	ld	a0,-152(s0)
 3b4:	17d010ef          	jal	1d30 <open>
 3b8:	00050793          	mv	a5,a0
 3bc:	f6f42223          	sw	a5,-156(s0)
 3c0:	f6442783          	lw	a5,-156(s0)
 3c4:	0007871b          	sext.w	a4,a5
 3c8:	fff00793          	li	a5,-1
 3cc:	00f71c63          	bne	a4,a5,3e4 <parse_cmd+0x198>
 3d0:	f6843583          	ld	a1,-152(s0)
 3d4:	00002517          	auipc	a0,0x2
 3d8:	a7450513          	addi	a0,a0,-1420 # 1e48 <lseek+0x80>
 3dc:	608010ef          	jal	19e4 <printf>
 3e0:	5940006f          	j	974 <parse_cmd+0x728>
 3e4:	d1840713          	addi	a4,s0,-744
 3e8:	f6442783          	lw	a5,-156(s0)
 3ec:	1fd00613          	li	a2,509
 3f0:	00070593          	mv	a1,a4
 3f4:	00078513          	mv	a0,a5
 3f8:	061010ef          	jal	1c58 <read>
 3fc:	00050793          	mv	a5,a0
 400:	f6f42023          	sw	a5,-160(s0)
 404:	f6042783          	lw	a5,-160(s0)
 408:	0007879b          	sext.w	a5,a5
 40c:	02079263          	bnez	a5,430 <parse_cmd+0x1e4>
 410:	f8f44783          	lbu	a5,-113(s0)
 414:	0ff7f713          	zext.b	a4,a5
 418:	00a00793          	li	a5,10
 41c:	0af70063          	beq	a4,a5,4bc <parse_cmd+0x270>
 420:	00002517          	auipc	a0,0x2
 424:	a4050513          	addi	a0,a0,-1472 # 1e60 <lseek+0x98>
 428:	5bc010ef          	jal	19e4 <printf>
 42c:	0900006f          	j	4bc <parse_cmd+0x270>
 430:	f8042423          	sw	zero,-120(s0)
 434:	06c0006f          	j	4a0 <parse_cmd+0x254>
 438:	f8842783          	lw	a5,-120(s0)
 43c:	f9078793          	addi	a5,a5,-112
 440:	008787b3          	add	a5,a5,s0
 444:	d887c783          	lbu	a5,-632(a5)
 448:	00079e63          	bnez	a5,464 <parse_cmd+0x218>
 44c:	00100613          	li	a2,1
 450:	00002597          	auipc	a1,0x2
 454:	a1858593          	addi	a1,a1,-1512 # 1e68 <lseek+0xa0>
 458:	00100513          	li	a0,1
 45c:	6d8010ef          	jal	1b34 <write>
 460:	0200006f          	j	480 <parse_cmd+0x234>
 464:	d1840713          	addi	a4,s0,-744
 468:	f8842783          	lw	a5,-120(s0)
 46c:	00f707b3          	add	a5,a4,a5
 470:	00100613          	li	a2,1
 474:	00078593          	mv	a1,a5
 478:	00100513          	li	a0,1
 47c:	6b8010ef          	jal	1b34 <write>
 480:	f8842783          	lw	a5,-120(s0)
 484:	f9078793          	addi	a5,a5,-112
 488:	008787b3          	add	a5,a5,s0
 48c:	d887c783          	lbu	a5,-632(a5)
 490:	f8f407a3          	sb	a5,-113(s0)
 494:	f8842783          	lw	a5,-120(s0)
 498:	0017879b          	addiw	a5,a5,1
 49c:	f8f42423          	sw	a5,-120(s0)
 4a0:	f8842783          	lw	a5,-120(s0)
 4a4:	00078713          	mv	a4,a5
 4a8:	f6042783          	lw	a5,-160(s0)
 4ac:	0007071b          	sext.w	a4,a4
 4b0:	0007879b          	sext.w	a5,a5
 4b4:	f8f742e3          	blt	a4,a5,438 <parse_cmd+0x1ec>
 4b8:	f2dff06f          	j	3e4 <parse_cmd+0x198>
 4bc:	00000013          	nop
 4c0:	f6442783          	lw	a5,-156(s0)
 4c4:	00078513          	mv	a0,a5
 4c8:	0b1010ef          	jal	1d78 <close>
 4cc:	4a80006f          	j	974 <parse_cmd+0x728>
 4d0:	d0843783          	ld	a5,-760(s0)
 4d4:	0007c783          	lbu	a5,0(a5)
 4d8:	00078713          	mv	a4,a5
 4dc:	06500793          	li	a5,101
 4e0:	48f71263          	bne	a4,a5,964 <parse_cmd+0x718>
 4e4:	d0843783          	ld	a5,-760(s0)
 4e8:	00178793          	addi	a5,a5,1
 4ec:	0007c783          	lbu	a5,0(a5)
 4f0:	00078713          	mv	a4,a5
 4f4:	06400793          	li	a5,100
 4f8:	46f71663          	bne	a4,a5,964 <parse_cmd+0x718>
 4fc:	d0843783          	ld	a5,-760(s0)
 500:	00278793          	addi	a5,a5,2
 504:	0007c783          	lbu	a5,0(a5)
 508:	00078713          	mv	a4,a5
 50c:	06900793          	li	a5,105
 510:	44f71a63          	bne	a4,a5,964 <parse_cmd+0x718>
 514:	d0843783          	ld	a5,-760(s0)
 518:	00378793          	addi	a5,a5,3
 51c:	0007c783          	lbu	a5,0(a5)
 520:	00078713          	mv	a4,a5
 524:	07400793          	li	a5,116
 528:	42f71e63          	bne	a4,a5,964 <parse_cmd+0x718>
 52c:	00010793          	mv	a5,sp
 530:	00078493          	mv	s1,a5
 534:	d0843783          	ld	a5,-760(s0)
 538:	00478793          	addi	a5,a5,4
 53c:	d0f43423          	sd	a5,-760(s0)
 540:	0100006f          	j	550 <parse_cmd+0x304>
 544:	d0843783          	ld	a5,-760(s0)
 548:	00178793          	addi	a5,a5,1
 54c:	d0f43423          	sd	a5,-760(s0)
 550:	d0843783          	ld	a5,-760(s0)
 554:	0007c783          	lbu	a5,0(a5)
 558:	00078713          	mv	a4,a5
 55c:	02000793          	li	a5,32
 560:	00f71863          	bne	a4,a5,570 <parse_cmd+0x324>
 564:	d0843783          	ld	a5,-760(s0)
 568:	0007c783          	lbu	a5,0(a5)
 56c:	fc079ce3          	bnez	a5,544 <parse_cmd+0x2f8>
 570:	d0843503          	ld	a0,-760(s0)
 574:	b3dff0ef          	jal	b0 <get_param>
 578:	f4a43c23          	sd	a0,-168(s0)
 57c:	f5843503          	ld	a0,-168(s0)
 580:	560010ef          	jal	1ae0 <strlen>
 584:	00050793          	mv	a5,a0
 588:	f4f42a23          	sw	a5,-172(s0)
 58c:	f5442783          	lw	a5,-172(s0)
 590:	0017879b          	addiw	a5,a5,1
 594:	0007871b          	sext.w	a4,a5
 598:	00070793          	mv	a5,a4
 59c:	fff78793          	addi	a5,a5,-1
 5a0:	f4f43423          	sd	a5,-184(s0)
 5a4:	00070793          	mv	a5,a4
 5a8:	cef43823          	sd	a5,-784(s0)
 5ac:	ce043c23          	sd	zero,-776(s0)
 5b0:	cf043783          	ld	a5,-784(s0)
 5b4:	03d7d793          	srli	a5,a5,0x3d
 5b8:	cf843683          	ld	a3,-776(s0)
 5bc:	00369693          	slli	a3,a3,0x3
 5c0:	c8d43c23          	sd	a3,-872(s0)
 5c4:	c9843683          	ld	a3,-872(s0)
 5c8:	00d7e7b3          	or	a5,a5,a3
 5cc:	c8f43c23          	sd	a5,-872(s0)
 5d0:	cf043783          	ld	a5,-784(s0)
 5d4:	00379793          	slli	a5,a5,0x3
 5d8:	c8f43823          	sd	a5,-880(s0)
 5dc:	00070793          	mv	a5,a4
 5e0:	cef43023          	sd	a5,-800(s0)
 5e4:	ce043423          	sd	zero,-792(s0)
 5e8:	ce043783          	ld	a5,-800(s0)
 5ec:	03d7d793          	srli	a5,a5,0x3d
 5f0:	ce843683          	ld	a3,-792(s0)
 5f4:	00369d93          	slli	s11,a3,0x3
 5f8:	01b7edb3          	or	s11,a5,s11
 5fc:	ce043783          	ld	a5,-800(s0)
 600:	00379d13          	slli	s10,a5,0x3
 604:	00070793          	mv	a5,a4
 608:	00f78793          	addi	a5,a5,15
 60c:	0047d793          	srli	a5,a5,0x4
 610:	00479793          	slli	a5,a5,0x4
 614:	40f10133          	sub	sp,sp,a5
 618:	00010793          	mv	a5,sp
 61c:	f4f43023          	sd	a5,-192(s0)
 620:	f8042223          	sw	zero,-124(s0)
 624:	0300006f          	j	654 <parse_cmd+0x408>
 628:	f8442783          	lw	a5,-124(s0)
 62c:	f5843703          	ld	a4,-168(s0)
 630:	00f707b3          	add	a5,a4,a5
 634:	0007c703          	lbu	a4,0(a5)
 638:	f4043683          	ld	a3,-192(s0)
 63c:	f8442783          	lw	a5,-124(s0)
 640:	00f687b3          	add	a5,a3,a5
 644:	00e78023          	sb	a4,0(a5)
 648:	f8442783          	lw	a5,-124(s0)
 64c:	0017879b          	addiw	a5,a5,1
 650:	f8f42223          	sw	a5,-124(s0)
 654:	f8442783          	lw	a5,-124(s0)
 658:	00078713          	mv	a4,a5
 65c:	f5442783          	lw	a5,-172(s0)
 660:	0007071b          	sext.w	a4,a4
 664:	0007879b          	sext.w	a5,a5
 668:	fcf740e3          	blt	a4,a5,628 <parse_cmd+0x3dc>
 66c:	f4043703          	ld	a4,-192(s0)
 670:	f5442783          	lw	a5,-172(s0)
 674:	00f707b3          	add	a5,a4,a5
 678:	00078023          	sb	zero,0(a5)
 67c:	f5442783          	lw	a5,-172(s0)
 680:	d0843703          	ld	a4,-760(s0)
 684:	00f707b3          	add	a5,a4,a5
 688:	d0f43423          	sd	a5,-760(s0)
 68c:	0100006f          	j	69c <parse_cmd+0x450>
 690:	d0843783          	ld	a5,-760(s0)
 694:	00178793          	addi	a5,a5,1
 698:	d0f43423          	sd	a5,-760(s0)
 69c:	d0843783          	ld	a5,-760(s0)
 6a0:	0007c783          	lbu	a5,0(a5)
 6a4:	00078713          	mv	a4,a5
 6a8:	02000793          	li	a5,32
 6ac:	00f71863          	bne	a4,a5,6bc <parse_cmd+0x470>
 6b0:	d0843783          	ld	a5,-760(s0)
 6b4:	0007c783          	lbu	a5,0(a5)
 6b8:	fc079ce3          	bnez	a5,690 <parse_cmd+0x444>
 6bc:	d0843503          	ld	a0,-760(s0)
 6c0:	9f1ff0ef          	jal	b0 <get_param>
 6c4:	f4a43c23          	sd	a0,-168(s0)
 6c8:	f5843503          	ld	a0,-168(s0)
 6cc:	414010ef          	jal	1ae0 <strlen>
 6d0:	00050793          	mv	a5,a0
 6d4:	f4f42a23          	sw	a5,-172(s0)
 6d8:	f5442783          	lw	a5,-172(s0)
 6dc:	0017879b          	addiw	a5,a5,1
 6e0:	0007879b          	sext.w	a5,a5
 6e4:	00078713          	mv	a4,a5
 6e8:	fff70713          	addi	a4,a4,-1
 6ec:	f2e43c23          	sd	a4,-200(s0)
 6f0:	00078713          	mv	a4,a5
 6f4:	cce43823          	sd	a4,-816(s0)
 6f8:	cc043c23          	sd	zero,-808(s0)
 6fc:	cd043703          	ld	a4,-816(s0)
 700:	03d75713          	srli	a4,a4,0x3d
 704:	cd843683          	ld	a3,-808(s0)
 708:	00369c93          	slli	s9,a3,0x3
 70c:	01976cb3          	or	s9,a4,s9
 710:	cd043703          	ld	a4,-816(s0)
 714:	00371c13          	slli	s8,a4,0x3
 718:	00078713          	mv	a4,a5
 71c:	cce43023          	sd	a4,-832(s0)
 720:	cc043423          	sd	zero,-824(s0)
 724:	cc043703          	ld	a4,-832(s0)
 728:	03d75713          	srli	a4,a4,0x3d
 72c:	cc843683          	ld	a3,-824(s0)
 730:	00369b93          	slli	s7,a3,0x3
 734:	01776bb3          	or	s7,a4,s7
 738:	cc043703          	ld	a4,-832(s0)
 73c:	00371b13          	slli	s6,a4,0x3
 740:	00f78793          	addi	a5,a5,15
 744:	0047d793          	srli	a5,a5,0x4
 748:	00479793          	slli	a5,a5,0x4
 74c:	40f10133          	sub	sp,sp,a5
 750:	00010793          	mv	a5,sp
 754:	f2f43823          	sd	a5,-208(s0)
 758:	f8042023          	sw	zero,-128(s0)
 75c:	0300006f          	j	78c <parse_cmd+0x540>
 760:	f8042783          	lw	a5,-128(s0)
 764:	f5843703          	ld	a4,-168(s0)
 768:	00f707b3          	add	a5,a4,a5
 76c:	0007c703          	lbu	a4,0(a5)
 770:	f3043683          	ld	a3,-208(s0)
 774:	f8042783          	lw	a5,-128(s0)
 778:	00f687b3          	add	a5,a3,a5
 77c:	00e78023          	sb	a4,0(a5)
 780:	f8042783          	lw	a5,-128(s0)
 784:	0017879b          	addiw	a5,a5,1
 788:	f8f42023          	sw	a5,-128(s0)
 78c:	f8042783          	lw	a5,-128(s0)
 790:	00078713          	mv	a4,a5
 794:	f5442783          	lw	a5,-172(s0)
 798:	0007071b          	sext.w	a4,a4
 79c:	0007879b          	sext.w	a5,a5
 7a0:	fcf740e3          	blt	a4,a5,760 <parse_cmd+0x514>
 7a4:	f3043703          	ld	a4,-208(s0)
 7a8:	f5442783          	lw	a5,-172(s0)
 7ac:	00f707b3          	add	a5,a4,a5
 7b0:	00078023          	sb	zero,0(a5)
 7b4:	f5442783          	lw	a5,-172(s0)
 7b8:	d0843703          	ld	a4,-760(s0)
 7bc:	00f707b3          	add	a5,a4,a5
 7c0:	d0f43423          	sd	a5,-760(s0)
 7c4:	0100006f          	j	7d4 <parse_cmd+0x588>
 7c8:	d0843783          	ld	a5,-760(s0)
 7cc:	00178793          	addi	a5,a5,1
 7d0:	d0f43423          	sd	a5,-760(s0)
 7d4:	d0843783          	ld	a5,-760(s0)
 7d8:	0007c783          	lbu	a5,0(a5)
 7dc:	00078713          	mv	a4,a5
 7e0:	02000793          	li	a5,32
 7e4:	00f71863          	bne	a4,a5,7f4 <parse_cmd+0x5a8>
 7e8:	d0843783          	ld	a5,-760(s0)
 7ec:	0007c783          	lbu	a5,0(a5)
 7f0:	fc079ce3          	bnez	a5,7c8 <parse_cmd+0x57c>
 7f4:	d0843503          	ld	a0,-760(s0)
 7f8:	975ff0ef          	jal	16c <get_string>
 7fc:	f4a43c23          	sd	a0,-168(s0)
 800:	f5843503          	ld	a0,-168(s0)
 804:	2dc010ef          	jal	1ae0 <strlen>
 808:	00050793          	mv	a5,a0
 80c:	f4f42a23          	sw	a5,-172(s0)
 810:	f5442783          	lw	a5,-172(s0)
 814:	0017879b          	addiw	a5,a5,1
 818:	0007879b          	sext.w	a5,a5
 81c:	00078713          	mv	a4,a5
 820:	fff70713          	addi	a4,a4,-1
 824:	f2e43423          	sd	a4,-216(s0)
 828:	00078713          	mv	a4,a5
 82c:	cae43823          	sd	a4,-848(s0)
 830:	ca043c23          	sd	zero,-840(s0)
 834:	cb043703          	ld	a4,-848(s0)
 838:	03d75713          	srli	a4,a4,0x3d
 83c:	cb843683          	ld	a3,-840(s0)
 840:	00369a93          	slli	s5,a3,0x3
 844:	01576ab3          	or	s5,a4,s5
 848:	cb043703          	ld	a4,-848(s0)
 84c:	00371a13          	slli	s4,a4,0x3
 850:	00078713          	mv	a4,a5
 854:	cae43023          	sd	a4,-864(s0)
 858:	ca043423          	sd	zero,-856(s0)
 85c:	ca043703          	ld	a4,-864(s0)
 860:	03d75713          	srli	a4,a4,0x3d
 864:	ca843683          	ld	a3,-856(s0)
 868:	00369993          	slli	s3,a3,0x3
 86c:	013769b3          	or	s3,a4,s3
 870:	ca043703          	ld	a4,-864(s0)
 874:	00371913          	slli	s2,a4,0x3
 878:	00f78793          	addi	a5,a5,15
 87c:	0047d793          	srli	a5,a5,0x4
 880:	00479793          	slli	a5,a5,0x4
 884:	40f10133          	sub	sp,sp,a5
 888:	00010793          	mv	a5,sp
 88c:	f2f43023          	sd	a5,-224(s0)
 890:	f6042e23          	sw	zero,-132(s0)
 894:	0300006f          	j	8c4 <parse_cmd+0x678>
 898:	f7c42783          	lw	a5,-132(s0)
 89c:	f5843703          	ld	a4,-168(s0)
 8a0:	00f707b3          	add	a5,a4,a5
 8a4:	0007c703          	lbu	a4,0(a5)
 8a8:	f2043683          	ld	a3,-224(s0)
 8ac:	f7c42783          	lw	a5,-132(s0)
 8b0:	00f687b3          	add	a5,a3,a5
 8b4:	00e78023          	sb	a4,0(a5)
 8b8:	f7c42783          	lw	a5,-132(s0)
 8bc:	0017879b          	addiw	a5,a5,1
 8c0:	f6f42e23          	sw	a5,-132(s0)
 8c4:	f7c42783          	lw	a5,-132(s0)
 8c8:	00078713          	mv	a4,a5
 8cc:	f5442783          	lw	a5,-172(s0)
 8d0:	0007071b          	sext.w	a4,a4
 8d4:	0007879b          	sext.w	a5,a5
 8d8:	fcf740e3          	blt	a4,a5,898 <parse_cmd+0x64c>
 8dc:	f2043703          	ld	a4,-224(s0)
 8e0:	f5442783          	lw	a5,-172(s0)
 8e4:	00f707b3          	add	a5,a4,a5
 8e8:	00078023          	sb	zero,0(a5)
 8ec:	f5442783          	lw	a5,-172(s0)
 8f0:	d0843703          	ld	a4,-760(s0)
 8f4:	00f707b3          	add	a5,a4,a5
 8f8:	d0f43423          	sd	a5,-760(s0)
 8fc:	f3043503          	ld	a0,-208(s0)
 900:	f04ff0ef          	jal	4 <atoi>
 904:	00050793          	mv	a5,a0
 908:	f0f42e23          	sw	a5,-228(s0)
 90c:	00300593          	li	a1,3
 910:	f4043503          	ld	a0,-192(s0)
 914:	41c010ef          	jal	1d30 <open>
 918:	00050793          	mv	a5,a0
 91c:	f0f42c23          	sw	a5,-232(s0)
 920:	f1c42703          	lw	a4,-228(s0)
 924:	f1842783          	lw	a5,-232(s0)
 928:	00000613          	li	a2,0
 92c:	00070593          	mv	a1,a4
 930:	00078513          	mv	a0,a5
 934:	494010ef          	jal	1dc8 <lseek>
 938:	f5442703          	lw	a4,-172(s0)
 93c:	f1842783          	lw	a5,-232(s0)
 940:	00070613          	mv	a2,a4
 944:	f2043583          	ld	a1,-224(s0)
 948:	00078513          	mv	a0,a5
 94c:	1e8010ef          	jal	1b34 <write>
 950:	f1842783          	lw	a5,-232(s0)
 954:	00078513          	mv	a0,a5
 958:	420010ef          	jal	1d78 <close>
 95c:	00048113          	mv	sp,s1
 960:	0140006f          	j	974 <parse_cmd+0x728>
 964:	d0843583          	ld	a1,-760(s0)
 968:	00001517          	auipc	a0,0x1
 96c:	50850513          	addi	a0,a0,1288 # 1e70 <lseek+0xa8>
 970:	074010ef          	jal	19e4 <printf>
 974:	c9040113          	addi	sp,s0,-880
 978:	36813083          	ld	ra,872(sp)
 97c:	36013403          	ld	s0,864(sp)
 980:	35813483          	ld	s1,856(sp)
 984:	35013903          	ld	s2,848(sp)
 988:	34813983          	ld	s3,840(sp)
 98c:	34013a03          	ld	s4,832(sp)
 990:	33813a83          	ld	s5,824(sp)
 994:	33013b03          	ld	s6,816(sp)
 998:	32813b83          	ld	s7,808(sp)
 99c:	32013c03          	ld	s8,800(sp)
 9a0:	31813c83          	ld	s9,792(sp)
 9a4:	31013d03          	ld	s10,784(sp)
 9a8:	30813d83          	ld	s11,776(sp)
 9ac:	37010113          	addi	sp,sp,880
 9b0:	00008067          	ret

Disassembly of section .text.main:

00000000000009b4 <main>:
 9b4:	f6010113          	addi	sp,sp,-160
 9b8:	08113c23          	sd	ra,152(sp)
 9bc:	08813823          	sd	s0,144(sp)
 9c0:	0a010413          	addi	s0,sp,160
 9c4:	00f00613          	li	a2,15
 9c8:	00001597          	auipc	a1,0x1
 9cc:	4c058593          	addi	a1,a1,1216 # 1e88 <lseek+0xc0>
 9d0:	00100513          	li	a0,1
 9d4:	160010ef          	jal	1b34 <write>
 9d8:	00f00613          	li	a2,15
 9dc:	00001597          	auipc	a1,0x1
 9e0:	4bc58593          	addi	a1,a1,1212 # 1e98 <lseek+0xd0>
 9e4:	00200513          	li	a0,2
 9e8:	14c010ef          	jal	1b34 <write>
 9ec:	fe042623          	sw	zero,-20(s0)
 9f0:	00001517          	auipc	a0,0x1
 9f4:	4b850513          	addi	a0,a0,1208 # 1ea8 <lseek+0xe0>
 9f8:	7ed000ef          	jal	19e4 <printf>
 9fc:	fe840793          	addi	a5,s0,-24
 a00:	00100613          	li	a2,1
 a04:	00078593          	mv	a1,a5
 a08:	00000513          	li	a0,0
 a0c:	24c010ef          	jal	1c58 <read>
 a10:	fe844783          	lbu	a5,-24(s0)
 a14:	00078713          	mv	a4,a5
 a18:	00d00793          	li	a5,13
 a1c:	00f71e63          	bne	a4,a5,a38 <main+0x84>
 a20:	00100613          	li	a2,1
 a24:	00001597          	auipc	a1,0x1
 a28:	41c58593          	addi	a1,a1,1052 # 1e40 <lseek+0x78>
 a2c:	00100513          	li	a0,1
 a30:	104010ef          	jal	1b34 <write>
 a34:	0440006f          	j	a78 <main+0xc4>
 a38:	fe844783          	lbu	a5,-24(s0)
 a3c:	00078713          	mv	a4,a5
 a40:	07f00793          	li	a5,127
 a44:	02f71a63          	bne	a4,a5,a78 <main+0xc4>
 a48:	fec42783          	lw	a5,-20(s0)
 a4c:	0007879b          	sext.w	a5,a5
 a50:	0af05263          	blez	a5,af4 <main+0x140>
 a54:	00300613          	li	a2,3
 a58:	00001597          	auipc	a1,0x1
 a5c:	46858593          	addi	a1,a1,1128 # 1ec0 <lseek+0xf8>
 a60:	00100513          	li	a0,1
 a64:	0d0010ef          	jal	1b34 <write>
 a68:	fec42783          	lw	a5,-20(s0)
 a6c:	fff7879b          	addiw	a5,a5,-1
 a70:	fef42623          	sw	a5,-20(s0)
 a74:	0800006f          	j	af4 <main+0x140>
 a78:	fe840793          	addi	a5,s0,-24
 a7c:	00100613          	li	a2,1
 a80:	00078593          	mv	a1,a5
 a84:	00100513          	li	a0,1
 a88:	0ac010ef          	jal	1b34 <write>
 a8c:	fe844783          	lbu	a5,-24(s0)
 a90:	00078713          	mv	a4,a5
 a94:	00d00793          	li	a5,13
 a98:	02f71e63          	bne	a4,a5,ad4 <main+0x120>
 a9c:	fec42783          	lw	a5,-20(s0)
 aa0:	ff078793          	addi	a5,a5,-16
 aa4:	008787b3          	add	a5,a5,s0
 aa8:	f6078c23          	sb	zero,-136(a5)
 aac:	fec42703          	lw	a4,-20(s0)
 ab0:	f6840793          	addi	a5,s0,-152
 ab4:	00070593          	mv	a1,a4
 ab8:	00078513          	mv	a0,a5
 abc:	f90ff0ef          	jal	24c <parse_cmd>
 ac0:	fe042623          	sw	zero,-20(s0)
 ac4:	00001517          	auipc	a0,0x1
 ac8:	3e450513          	addi	a0,a0,996 # 1ea8 <lseek+0xe0>
 acc:	719000ef          	jal	19e4 <printf>
 ad0:	f2dff06f          	j	9fc <main+0x48>
 ad4:	fec42783          	lw	a5,-20(s0)
 ad8:	0017871b          	addiw	a4,a5,1
 adc:	fee42623          	sw	a4,-20(s0)
 ae0:	fe844703          	lbu	a4,-24(s0)
 ae4:	ff078793          	addi	a5,a5,-16
 ae8:	008787b3          	add	a5,a5,s0
 aec:	f6e78c23          	sb	a4,-136(a5)
 af0:	f0dff06f          	j	9fc <main+0x48>
 af4:	00000013          	nop
 af8:	f05ff06f          	j	9fc <main+0x48>

Disassembly of section .text.putc:

0000000000000afc <putc>:
 afc:	fe010113          	addi	sp,sp,-32
 b00:	00113c23          	sd	ra,24(sp)
 b04:	00813823          	sd	s0,16(sp)
 b08:	02010413          	addi	s0,sp,32
 b0c:	00050793          	mv	a5,a0
 b10:	fef42623          	sw	a5,-20(s0)
 b14:	00002797          	auipc	a5,0x2
 b18:	75c78793          	addi	a5,a5,1884 # 3270 <tail>
 b1c:	0007a783          	lw	a5,0(a5)
 b20:	0017871b          	addiw	a4,a5,1
 b24:	0007069b          	sext.w	a3,a4
 b28:	00002717          	auipc	a4,0x2
 b2c:	74870713          	addi	a4,a4,1864 # 3270 <tail>
 b30:	00d72023          	sw	a3,0(a4)
 b34:	fec42703          	lw	a4,-20(s0)
 b38:	0ff77713          	zext.b	a4,a4
 b3c:	00002697          	auipc	a3,0x2
 b40:	73c68693          	addi	a3,a3,1852 # 3278 <buffer>
 b44:	00f687b3          	add	a5,a3,a5
 b48:	00e78023          	sb	a4,0(a5)
 b4c:	fec42783          	lw	a5,-20(s0)
 b50:	0ff7f793          	zext.b	a5,a5
 b54:	0007879b          	sext.w	a5,a5
 b58:	00078513          	mv	a0,a5
 b5c:	01813083          	ld	ra,24(sp)
 b60:	01013403          	ld	s0,16(sp)
 b64:	02010113          	addi	sp,sp,32
 b68:	00008067          	ret

Disassembly of section .text.isspace:

0000000000000b6c <isspace>:
 b6c:	fe010113          	addi	sp,sp,-32
 b70:	00113c23          	sd	ra,24(sp)
 b74:	00813823          	sd	s0,16(sp)
 b78:	02010413          	addi	s0,sp,32
 b7c:	00050793          	mv	a5,a0
 b80:	fef42623          	sw	a5,-20(s0)
 b84:	fec42783          	lw	a5,-20(s0)
 b88:	0007871b          	sext.w	a4,a5
 b8c:	02000793          	li	a5,32
 b90:	02f70263          	beq	a4,a5,bb4 <isspace+0x48>
 b94:	fec42783          	lw	a5,-20(s0)
 b98:	0007871b          	sext.w	a4,a5
 b9c:	00800793          	li	a5,8
 ba0:	00e7de63          	bge	a5,a4,bbc <isspace+0x50>
 ba4:	fec42783          	lw	a5,-20(s0)
 ba8:	0007871b          	sext.w	a4,a5
 bac:	00d00793          	li	a5,13
 bb0:	00e7c663          	blt	a5,a4,bbc <isspace+0x50>
 bb4:	00100793          	li	a5,1
 bb8:	0080006f          	j	bc0 <isspace+0x54>
 bbc:	00000793          	li	a5,0
 bc0:	00078513          	mv	a0,a5
 bc4:	01813083          	ld	ra,24(sp)
 bc8:	01013403          	ld	s0,16(sp)
 bcc:	02010113          	addi	sp,sp,32
 bd0:	00008067          	ret

Disassembly of section .text.strtol:

0000000000000bd4 <strtol>:
 bd4:	fb010113          	addi	sp,sp,-80
 bd8:	04113423          	sd	ra,72(sp)
 bdc:	04813023          	sd	s0,64(sp)
 be0:	05010413          	addi	s0,sp,80
 be4:	fca43423          	sd	a0,-56(s0)
 be8:	fcb43023          	sd	a1,-64(s0)
 bec:	00060793          	mv	a5,a2
 bf0:	faf42e23          	sw	a5,-68(s0)
 bf4:	fe043423          	sd	zero,-24(s0)
 bf8:	fe0403a3          	sb	zero,-25(s0)
 bfc:	fc843783          	ld	a5,-56(s0)
 c00:	fcf43c23          	sd	a5,-40(s0)
 c04:	0100006f          	j	c14 <strtol+0x40>
 c08:	fd843783          	ld	a5,-40(s0)
 c0c:	00178793          	addi	a5,a5,1
 c10:	fcf43c23          	sd	a5,-40(s0)
 c14:	fd843783          	ld	a5,-40(s0)
 c18:	0007c783          	lbu	a5,0(a5)
 c1c:	0007879b          	sext.w	a5,a5
 c20:	00078513          	mv	a0,a5
 c24:	f49ff0ef          	jal	b6c <isspace>
 c28:	00050793          	mv	a5,a0
 c2c:	fc079ee3          	bnez	a5,c08 <strtol+0x34>
 c30:	fd843783          	ld	a5,-40(s0)
 c34:	0007c783          	lbu	a5,0(a5)
 c38:	00078713          	mv	a4,a5
 c3c:	02d00793          	li	a5,45
 c40:	00f71e63          	bne	a4,a5,c5c <strtol+0x88>
 c44:	00100793          	li	a5,1
 c48:	fef403a3          	sb	a5,-25(s0)
 c4c:	fd843783          	ld	a5,-40(s0)
 c50:	00178793          	addi	a5,a5,1
 c54:	fcf43c23          	sd	a5,-40(s0)
 c58:	0240006f          	j	c7c <strtol+0xa8>
 c5c:	fd843783          	ld	a5,-40(s0)
 c60:	0007c783          	lbu	a5,0(a5)
 c64:	00078713          	mv	a4,a5
 c68:	02b00793          	li	a5,43
 c6c:	00f71863          	bne	a4,a5,c7c <strtol+0xa8>
 c70:	fd843783          	ld	a5,-40(s0)
 c74:	00178793          	addi	a5,a5,1
 c78:	fcf43c23          	sd	a5,-40(s0)
 c7c:	fbc42783          	lw	a5,-68(s0)
 c80:	0007879b          	sext.w	a5,a5
 c84:	06079c63          	bnez	a5,cfc <strtol+0x128>
 c88:	fd843783          	ld	a5,-40(s0)
 c8c:	0007c783          	lbu	a5,0(a5)
 c90:	00078713          	mv	a4,a5
 c94:	03000793          	li	a5,48
 c98:	04f71e63          	bne	a4,a5,cf4 <strtol+0x120>
 c9c:	fd843783          	ld	a5,-40(s0)
 ca0:	00178793          	addi	a5,a5,1
 ca4:	fcf43c23          	sd	a5,-40(s0)
 ca8:	fd843783          	ld	a5,-40(s0)
 cac:	0007c783          	lbu	a5,0(a5)
 cb0:	00078713          	mv	a4,a5
 cb4:	07800793          	li	a5,120
 cb8:	00f70c63          	beq	a4,a5,cd0 <strtol+0xfc>
 cbc:	fd843783          	ld	a5,-40(s0)
 cc0:	0007c783          	lbu	a5,0(a5)
 cc4:	00078713          	mv	a4,a5
 cc8:	05800793          	li	a5,88
 ccc:	00f71e63          	bne	a4,a5,ce8 <strtol+0x114>
 cd0:	01000793          	li	a5,16
 cd4:	faf42e23          	sw	a5,-68(s0)
 cd8:	fd843783          	ld	a5,-40(s0)
 cdc:	00178793          	addi	a5,a5,1
 ce0:	fcf43c23          	sd	a5,-40(s0)
 ce4:	0180006f          	j	cfc <strtol+0x128>
 ce8:	00800793          	li	a5,8
 cec:	faf42e23          	sw	a5,-68(s0)
 cf0:	00c0006f          	j	cfc <strtol+0x128>
 cf4:	00a00793          	li	a5,10
 cf8:	faf42e23          	sw	a5,-68(s0)
 cfc:	fd843783          	ld	a5,-40(s0)
 d00:	0007c783          	lbu	a5,0(a5)
 d04:	00078713          	mv	a4,a5
 d08:	02f00793          	li	a5,47
 d0c:	02e7f863          	bgeu	a5,a4,d3c <strtol+0x168>
 d10:	fd843783          	ld	a5,-40(s0)
 d14:	0007c783          	lbu	a5,0(a5)
 d18:	00078713          	mv	a4,a5
 d1c:	03900793          	li	a5,57
 d20:	00e7ee63          	bltu	a5,a4,d3c <strtol+0x168>
 d24:	fd843783          	ld	a5,-40(s0)
 d28:	0007c783          	lbu	a5,0(a5)
 d2c:	0007879b          	sext.w	a5,a5
 d30:	fd07879b          	addiw	a5,a5,-48
 d34:	fcf42a23          	sw	a5,-44(s0)
 d38:	0800006f          	j	db8 <strtol+0x1e4>
 d3c:	fd843783          	ld	a5,-40(s0)
 d40:	0007c783          	lbu	a5,0(a5)
 d44:	00078713          	mv	a4,a5
 d48:	06000793          	li	a5,96
 d4c:	02e7f863          	bgeu	a5,a4,d7c <strtol+0x1a8>
 d50:	fd843783          	ld	a5,-40(s0)
 d54:	0007c783          	lbu	a5,0(a5)
 d58:	00078713          	mv	a4,a5
 d5c:	07a00793          	li	a5,122
 d60:	00e7ee63          	bltu	a5,a4,d7c <strtol+0x1a8>
 d64:	fd843783          	ld	a5,-40(s0)
 d68:	0007c783          	lbu	a5,0(a5)
 d6c:	0007879b          	sext.w	a5,a5
 d70:	fa97879b          	addiw	a5,a5,-87
 d74:	fcf42a23          	sw	a5,-44(s0)
 d78:	0400006f          	j	db8 <strtol+0x1e4>
 d7c:	fd843783          	ld	a5,-40(s0)
 d80:	0007c783          	lbu	a5,0(a5)
 d84:	00078713          	mv	a4,a5
 d88:	04000793          	li	a5,64
 d8c:	06e7f863          	bgeu	a5,a4,dfc <strtol+0x228>
 d90:	fd843783          	ld	a5,-40(s0)
 d94:	0007c783          	lbu	a5,0(a5)
 d98:	00078713          	mv	a4,a5
 d9c:	05a00793          	li	a5,90
 da0:	04e7ee63          	bltu	a5,a4,dfc <strtol+0x228>
 da4:	fd843783          	ld	a5,-40(s0)
 da8:	0007c783          	lbu	a5,0(a5)
 dac:	0007879b          	sext.w	a5,a5
 db0:	fc97879b          	addiw	a5,a5,-55
 db4:	fcf42a23          	sw	a5,-44(s0)
 db8:	fd442783          	lw	a5,-44(s0)
 dbc:	00078713          	mv	a4,a5
 dc0:	fbc42783          	lw	a5,-68(s0)
 dc4:	0007071b          	sext.w	a4,a4
 dc8:	0007879b          	sext.w	a5,a5
 dcc:	02f75663          	bge	a4,a5,df8 <strtol+0x224>
 dd0:	fbc42703          	lw	a4,-68(s0)
 dd4:	fe843783          	ld	a5,-24(s0)
 dd8:	02f70733          	mul	a4,a4,a5
 ddc:	fd442783          	lw	a5,-44(s0)
 de0:	00f707b3          	add	a5,a4,a5
 de4:	fef43423          	sd	a5,-24(s0)
 de8:	fd843783          	ld	a5,-40(s0)
 dec:	00178793          	addi	a5,a5,1
 df0:	fcf43c23          	sd	a5,-40(s0)
 df4:	f09ff06f          	j	cfc <strtol+0x128>
 df8:	00000013          	nop
 dfc:	fc043783          	ld	a5,-64(s0)
 e00:	00078863          	beqz	a5,e10 <strtol+0x23c>
 e04:	fc043783          	ld	a5,-64(s0)
 e08:	fd843703          	ld	a4,-40(s0)
 e0c:	00e7b023          	sd	a4,0(a5)
 e10:	fe744783          	lbu	a5,-25(s0)
 e14:	0ff7f793          	zext.b	a5,a5
 e18:	00078863          	beqz	a5,e28 <strtol+0x254>
 e1c:	fe843783          	ld	a5,-24(s0)
 e20:	40f007b3          	neg	a5,a5
 e24:	0080006f          	j	e2c <strtol+0x258>
 e28:	fe843783          	ld	a5,-24(s0)
 e2c:	00078513          	mv	a0,a5
 e30:	04813083          	ld	ra,72(sp)
 e34:	04013403          	ld	s0,64(sp)
 e38:	05010113          	addi	sp,sp,80
 e3c:	00008067          	ret

Disassembly of section .text.puts_wo_nl:

0000000000000e40 <puts_wo_nl>:
 e40:	fd010113          	addi	sp,sp,-48
 e44:	02113423          	sd	ra,40(sp)
 e48:	02813023          	sd	s0,32(sp)
 e4c:	03010413          	addi	s0,sp,48
 e50:	fca43c23          	sd	a0,-40(s0)
 e54:	fcb43823          	sd	a1,-48(s0)
 e58:	fd043783          	ld	a5,-48(s0)
 e5c:	00079863          	bnez	a5,e6c <puts_wo_nl+0x2c>
 e60:	00001797          	auipc	a5,0x1
 e64:	06878793          	addi	a5,a5,104 # 1ec8 <lseek+0x100>
 e68:	fcf43823          	sd	a5,-48(s0)
 e6c:	fd043783          	ld	a5,-48(s0)
 e70:	fef43423          	sd	a5,-24(s0)
 e74:	0240006f          	j	e98 <puts_wo_nl+0x58>
 e78:	fe843783          	ld	a5,-24(s0)
 e7c:	00178713          	addi	a4,a5,1
 e80:	fee43423          	sd	a4,-24(s0)
 e84:	0007c783          	lbu	a5,0(a5)
 e88:	0007871b          	sext.w	a4,a5
 e8c:	fd843783          	ld	a5,-40(s0)
 e90:	00070513          	mv	a0,a4
 e94:	000780e7          	jalr	a5
 e98:	fe843783          	ld	a5,-24(s0)
 e9c:	0007c783          	lbu	a5,0(a5)
 ea0:	fc079ce3          	bnez	a5,e78 <puts_wo_nl+0x38>
 ea4:	fe843703          	ld	a4,-24(s0)
 ea8:	fd043783          	ld	a5,-48(s0)
 eac:	40f707b3          	sub	a5,a4,a5
 eb0:	0007879b          	sext.w	a5,a5
 eb4:	00078513          	mv	a0,a5
 eb8:	02813083          	ld	ra,40(sp)
 ebc:	02013403          	ld	s0,32(sp)
 ec0:	03010113          	addi	sp,sp,48
 ec4:	00008067          	ret

Disassembly of section .text.print_dec_int:

0000000000000ec8 <print_dec_int>:
     ec8:	f9010113          	addi	sp,sp,-112
     ecc:	06113423          	sd	ra,104(sp)
     ed0:	06813023          	sd	s0,96(sp)
     ed4:	07010413          	addi	s0,sp,112
     ed8:	faa43423          	sd	a0,-88(s0)
     edc:	fab43023          	sd	a1,-96(s0)
     ee0:	00060793          	mv	a5,a2
     ee4:	f8d43823          	sd	a3,-112(s0)
     ee8:	f8f40fa3          	sb	a5,-97(s0)
     eec:	f9f44783          	lbu	a5,-97(s0)
     ef0:	0ff7f793          	zext.b	a5,a5
     ef4:	02078663          	beqz	a5,f20 <print_dec_int+0x58>
     ef8:	fa043703          	ld	a4,-96(s0)
     efc:	fff00793          	li	a5,-1
     f00:	03f79793          	slli	a5,a5,0x3f
     f04:	00f71e63          	bne	a4,a5,f20 <print_dec_int+0x58>
     f08:	00001597          	auipc	a1,0x1
     f0c:	fc858593          	addi	a1,a1,-56 # 1ed0 <lseek+0x108>
     f10:	fa843503          	ld	a0,-88(s0)
     f14:	f2dff0ef          	jal	e40 <puts_wo_nl>
     f18:	00050793          	mv	a5,a0
     f1c:	2c80006f          	j	11e4 <print_dec_int+0x31c>
     f20:	f9043783          	ld	a5,-112(s0)
     f24:	00c7a783          	lw	a5,12(a5)
     f28:	00079a63          	bnez	a5,f3c <print_dec_int+0x74>
     f2c:	fa043783          	ld	a5,-96(s0)
     f30:	00079663          	bnez	a5,f3c <print_dec_int+0x74>
     f34:	00000793          	li	a5,0
     f38:	2ac0006f          	j	11e4 <print_dec_int+0x31c>
     f3c:	fe0407a3          	sb	zero,-17(s0)
     f40:	f9f44783          	lbu	a5,-97(s0)
     f44:	0ff7f793          	zext.b	a5,a5
     f48:	02078063          	beqz	a5,f68 <print_dec_int+0xa0>
     f4c:	fa043783          	ld	a5,-96(s0)
     f50:	0007dc63          	bgez	a5,f68 <print_dec_int+0xa0>
     f54:	00100793          	li	a5,1
     f58:	fef407a3          	sb	a5,-17(s0)
     f5c:	fa043783          	ld	a5,-96(s0)
     f60:	40f007b3          	neg	a5,a5
     f64:	faf43023          	sd	a5,-96(s0)
     f68:	fe042423          	sw	zero,-24(s0)
     f6c:	f9f44783          	lbu	a5,-97(s0)
     f70:	0ff7f793          	zext.b	a5,a5
     f74:	02078863          	beqz	a5,fa4 <print_dec_int+0xdc>
     f78:	fef44783          	lbu	a5,-17(s0)
     f7c:	0ff7f793          	zext.b	a5,a5
     f80:	00079e63          	bnez	a5,f9c <print_dec_int+0xd4>
     f84:	f9043783          	ld	a5,-112(s0)
     f88:	0057c783          	lbu	a5,5(a5)
     f8c:	00079863          	bnez	a5,f9c <print_dec_int+0xd4>
     f90:	f9043783          	ld	a5,-112(s0)
     f94:	0047c783          	lbu	a5,4(a5)
     f98:	00078663          	beqz	a5,fa4 <print_dec_int+0xdc>
     f9c:	00100793          	li	a5,1
     fa0:	0080006f          	j	fa8 <print_dec_int+0xe0>
     fa4:	00000793          	li	a5,0
     fa8:	fcf40ba3          	sb	a5,-41(s0)
     fac:	fd744783          	lbu	a5,-41(s0)
     fb0:	0017f793          	andi	a5,a5,1
     fb4:	fcf40ba3          	sb	a5,-41(s0)
     fb8:	fa043683          	ld	a3,-96(s0)
     fbc:	00001797          	auipc	a5,0x1
     fc0:	f2c78793          	addi	a5,a5,-212 # 1ee8 <lseek+0x120>
     fc4:	0007b783          	ld	a5,0(a5)
     fc8:	02f6b7b3          	mulhu	a5,a3,a5
     fcc:	0037d713          	srli	a4,a5,0x3
     fd0:	00070793          	mv	a5,a4
     fd4:	00279793          	slli	a5,a5,0x2
     fd8:	00e787b3          	add	a5,a5,a4
     fdc:	00179793          	slli	a5,a5,0x1
     fe0:	40f68733          	sub	a4,a3,a5
     fe4:	0ff77713          	zext.b	a4,a4
     fe8:	fe842783          	lw	a5,-24(s0)
     fec:	0017869b          	addiw	a3,a5,1
     ff0:	fed42423          	sw	a3,-24(s0)
     ff4:	0307071b          	addiw	a4,a4,48
     ff8:	0ff77713          	zext.b	a4,a4
     ffc:	ff078793          	addi	a5,a5,-16
    1000:	008787b3          	add	a5,a5,s0
    1004:	fce78423          	sb	a4,-56(a5)
    1008:	fa043703          	ld	a4,-96(s0)
    100c:	00001797          	auipc	a5,0x1
    1010:	edc78793          	addi	a5,a5,-292 # 1ee8 <lseek+0x120>
    1014:	0007b783          	ld	a5,0(a5)
    1018:	02f737b3          	mulhu	a5,a4,a5
    101c:	0037d793          	srli	a5,a5,0x3
    1020:	faf43023          	sd	a5,-96(s0)
    1024:	fa043783          	ld	a5,-96(s0)
    1028:	f80798e3          	bnez	a5,fb8 <print_dec_int+0xf0>
    102c:	f9043783          	ld	a5,-112(s0)
    1030:	00c7a703          	lw	a4,12(a5)
    1034:	fff00793          	li	a5,-1
    1038:	02f71063          	bne	a4,a5,1058 <print_dec_int+0x190>
    103c:	f9043783          	ld	a5,-112(s0)
    1040:	0037c783          	lbu	a5,3(a5)
    1044:	00078a63          	beqz	a5,1058 <print_dec_int+0x190>
    1048:	f9043783          	ld	a5,-112(s0)
    104c:	0087a703          	lw	a4,8(a5)
    1050:	f9043783          	ld	a5,-112(s0)
    1054:	00e7a623          	sw	a4,12(a5)
    1058:	fe042223          	sw	zero,-28(s0)
    105c:	f9043783          	ld	a5,-112(s0)
    1060:	0087a703          	lw	a4,8(a5)
    1064:	fe842783          	lw	a5,-24(s0)
    1068:	fcf42823          	sw	a5,-48(s0)
    106c:	f9043783          	ld	a5,-112(s0)
    1070:	00c7a783          	lw	a5,12(a5)
    1074:	fcf42623          	sw	a5,-52(s0)
    1078:	fd042783          	lw	a5,-48(s0)
    107c:	00078593          	mv	a1,a5
    1080:	fcc42783          	lw	a5,-52(s0)
    1084:	00078613          	mv	a2,a5
    1088:	0006069b          	sext.w	a3,a2
    108c:	0005879b          	sext.w	a5,a1
    1090:	00f6d463          	bge	a3,a5,1098 <print_dec_int+0x1d0>
    1094:	00058613          	mv	a2,a1
    1098:	0006079b          	sext.w	a5,a2
    109c:	40f707bb          	subw	a5,a4,a5
    10a0:	0007871b          	sext.w	a4,a5
    10a4:	fd744783          	lbu	a5,-41(s0)
    10a8:	0007879b          	sext.w	a5,a5
    10ac:	40f707bb          	subw	a5,a4,a5
    10b0:	fef42023          	sw	a5,-32(s0)
    10b4:	0280006f          	j	10dc <print_dec_int+0x214>
    10b8:	fa843783          	ld	a5,-88(s0)
    10bc:	02000513          	li	a0,32
    10c0:	000780e7          	jalr	a5
    10c4:	fe442783          	lw	a5,-28(s0)
    10c8:	0017879b          	addiw	a5,a5,1
    10cc:	fef42223          	sw	a5,-28(s0)
    10d0:	fe042783          	lw	a5,-32(s0)
    10d4:	fff7879b          	addiw	a5,a5,-1
    10d8:	fef42023          	sw	a5,-32(s0)
    10dc:	fe042783          	lw	a5,-32(s0)
    10e0:	0007879b          	sext.w	a5,a5
    10e4:	fcf04ae3          	bgtz	a5,10b8 <print_dec_int+0x1f0>
    10e8:	fd744783          	lbu	a5,-41(s0)
    10ec:	0ff7f793          	zext.b	a5,a5
    10f0:	04078463          	beqz	a5,1138 <print_dec_int+0x270>
    10f4:	fef44783          	lbu	a5,-17(s0)
    10f8:	0ff7f793          	zext.b	a5,a5
    10fc:	00078663          	beqz	a5,1108 <print_dec_int+0x240>
    1100:	02d00793          	li	a5,45
    1104:	01c0006f          	j	1120 <print_dec_int+0x258>
    1108:	f9043783          	ld	a5,-112(s0)
    110c:	0057c783          	lbu	a5,5(a5)
    1110:	00078663          	beqz	a5,111c <print_dec_int+0x254>
    1114:	02b00793          	li	a5,43
    1118:	0080006f          	j	1120 <print_dec_int+0x258>
    111c:	02000793          	li	a5,32
    1120:	fa843703          	ld	a4,-88(s0)
    1124:	00078513          	mv	a0,a5
    1128:	000700e7          	jalr	a4
    112c:	fe442783          	lw	a5,-28(s0)
    1130:	0017879b          	addiw	a5,a5,1
    1134:	fef42223          	sw	a5,-28(s0)
    1138:	fe842783          	lw	a5,-24(s0)
    113c:	fcf42e23          	sw	a5,-36(s0)
    1140:	0280006f          	j	1168 <print_dec_int+0x2a0>
    1144:	fa843783          	ld	a5,-88(s0)
    1148:	03000513          	li	a0,48
    114c:	000780e7          	jalr	a5
    1150:	fe442783          	lw	a5,-28(s0)
    1154:	0017879b          	addiw	a5,a5,1
    1158:	fef42223          	sw	a5,-28(s0)
    115c:	fdc42783          	lw	a5,-36(s0)
    1160:	0017879b          	addiw	a5,a5,1
    1164:	fcf42e23          	sw	a5,-36(s0)
    1168:	f9043783          	ld	a5,-112(s0)
    116c:	00c7a703          	lw	a4,12(a5)
    1170:	fd744783          	lbu	a5,-41(s0)
    1174:	0007879b          	sext.w	a5,a5
    1178:	40f707bb          	subw	a5,a4,a5
    117c:	0007879b          	sext.w	a5,a5
    1180:	fdc42703          	lw	a4,-36(s0)
    1184:	0007071b          	sext.w	a4,a4
    1188:	faf74ee3          	blt	a4,a5,1144 <print_dec_int+0x27c>
    118c:	fe842783          	lw	a5,-24(s0)
    1190:	fff7879b          	addiw	a5,a5,-1
    1194:	fcf42c23          	sw	a5,-40(s0)
    1198:	03c0006f          	j	11d4 <print_dec_int+0x30c>
    119c:	fd842783          	lw	a5,-40(s0)
    11a0:	ff078793          	addi	a5,a5,-16
    11a4:	008787b3          	add	a5,a5,s0
    11a8:	fc87c783          	lbu	a5,-56(a5)
    11ac:	0007871b          	sext.w	a4,a5
    11b0:	fa843783          	ld	a5,-88(s0)
    11b4:	00070513          	mv	a0,a4
    11b8:	000780e7          	jalr	a5
    11bc:	fe442783          	lw	a5,-28(s0)
    11c0:	0017879b          	addiw	a5,a5,1
    11c4:	fef42223          	sw	a5,-28(s0)
    11c8:	fd842783          	lw	a5,-40(s0)
    11cc:	fff7879b          	addiw	a5,a5,-1
    11d0:	fcf42c23          	sw	a5,-40(s0)
    11d4:	fd842783          	lw	a5,-40(s0)
    11d8:	0007879b          	sext.w	a5,a5
    11dc:	fc07d0e3          	bgez	a5,119c <print_dec_int+0x2d4>
    11e0:	fe442783          	lw	a5,-28(s0)
    11e4:	00078513          	mv	a0,a5
    11e8:	06813083          	ld	ra,104(sp)
    11ec:	06013403          	ld	s0,96(sp)
    11f0:	07010113          	addi	sp,sp,112
    11f4:	00008067          	ret

Disassembly of section .text.vprintfmt:

00000000000011f8 <vprintfmt>:
    11f8:	f4010113          	addi	sp,sp,-192
    11fc:	0a113c23          	sd	ra,184(sp)
    1200:	0a813823          	sd	s0,176(sp)
    1204:	0c010413          	addi	s0,sp,192
    1208:	f4a43c23          	sd	a0,-168(s0)
    120c:	f4b43823          	sd	a1,-176(s0)
    1210:	f4c43423          	sd	a2,-184(s0)
    1214:	f8043023          	sd	zero,-128(s0)
    1218:	f8043423          	sd	zero,-120(s0)
    121c:	fe042623          	sw	zero,-20(s0)
    1220:	7a00006f          	j	19c0 <vprintfmt+0x7c8>
    1224:	f8044783          	lbu	a5,-128(s0)
    1228:	72078c63          	beqz	a5,1960 <vprintfmt+0x768>
    122c:	f5043783          	ld	a5,-176(s0)
    1230:	0007c783          	lbu	a5,0(a5)
    1234:	00078713          	mv	a4,a5
    1238:	02300793          	li	a5,35
    123c:	00f71863          	bne	a4,a5,124c <vprintfmt+0x54>
    1240:	00100793          	li	a5,1
    1244:	f8f40123          	sb	a5,-126(s0)
    1248:	76c0006f          	j	19b4 <vprintfmt+0x7bc>
    124c:	f5043783          	ld	a5,-176(s0)
    1250:	0007c783          	lbu	a5,0(a5)
    1254:	00078713          	mv	a4,a5
    1258:	03000793          	li	a5,48
    125c:	00f71863          	bne	a4,a5,126c <vprintfmt+0x74>
    1260:	00100793          	li	a5,1
    1264:	f8f401a3          	sb	a5,-125(s0)
    1268:	74c0006f          	j	19b4 <vprintfmt+0x7bc>
    126c:	f5043783          	ld	a5,-176(s0)
    1270:	0007c783          	lbu	a5,0(a5)
    1274:	00078713          	mv	a4,a5
    1278:	06c00793          	li	a5,108
    127c:	04f70063          	beq	a4,a5,12bc <vprintfmt+0xc4>
    1280:	f5043783          	ld	a5,-176(s0)
    1284:	0007c783          	lbu	a5,0(a5)
    1288:	00078713          	mv	a4,a5
    128c:	07a00793          	li	a5,122
    1290:	02f70663          	beq	a4,a5,12bc <vprintfmt+0xc4>
    1294:	f5043783          	ld	a5,-176(s0)
    1298:	0007c783          	lbu	a5,0(a5)
    129c:	00078713          	mv	a4,a5
    12a0:	07400793          	li	a5,116
    12a4:	00f70c63          	beq	a4,a5,12bc <vprintfmt+0xc4>
    12a8:	f5043783          	ld	a5,-176(s0)
    12ac:	0007c783          	lbu	a5,0(a5)
    12b0:	00078713          	mv	a4,a5
    12b4:	06a00793          	li	a5,106
    12b8:	00f71863          	bne	a4,a5,12c8 <vprintfmt+0xd0>
    12bc:	00100793          	li	a5,1
    12c0:	f8f400a3          	sb	a5,-127(s0)
    12c4:	6f00006f          	j	19b4 <vprintfmt+0x7bc>
    12c8:	f5043783          	ld	a5,-176(s0)
    12cc:	0007c783          	lbu	a5,0(a5)
    12d0:	00078713          	mv	a4,a5
    12d4:	02b00793          	li	a5,43
    12d8:	00f71863          	bne	a4,a5,12e8 <vprintfmt+0xf0>
    12dc:	00100793          	li	a5,1
    12e0:	f8f402a3          	sb	a5,-123(s0)
    12e4:	6d00006f          	j	19b4 <vprintfmt+0x7bc>
    12e8:	f5043783          	ld	a5,-176(s0)
    12ec:	0007c783          	lbu	a5,0(a5)
    12f0:	00078713          	mv	a4,a5
    12f4:	02000793          	li	a5,32
    12f8:	00f71863          	bne	a4,a5,1308 <vprintfmt+0x110>
    12fc:	00100793          	li	a5,1
    1300:	f8f40223          	sb	a5,-124(s0)
    1304:	6b00006f          	j	19b4 <vprintfmt+0x7bc>
    1308:	f5043783          	ld	a5,-176(s0)
    130c:	0007c783          	lbu	a5,0(a5)
    1310:	00078713          	mv	a4,a5
    1314:	02a00793          	li	a5,42
    1318:	00f71e63          	bne	a4,a5,1334 <vprintfmt+0x13c>
    131c:	f4843783          	ld	a5,-184(s0)
    1320:	00878713          	addi	a4,a5,8
    1324:	f4e43423          	sd	a4,-184(s0)
    1328:	0007a783          	lw	a5,0(a5)
    132c:	f8f42423          	sw	a5,-120(s0)
    1330:	6840006f          	j	19b4 <vprintfmt+0x7bc>
    1334:	f5043783          	ld	a5,-176(s0)
    1338:	0007c783          	lbu	a5,0(a5)
    133c:	00078713          	mv	a4,a5
    1340:	03000793          	li	a5,48
    1344:	04e7f663          	bgeu	a5,a4,1390 <vprintfmt+0x198>
    1348:	f5043783          	ld	a5,-176(s0)
    134c:	0007c783          	lbu	a5,0(a5)
    1350:	00078713          	mv	a4,a5
    1354:	03900793          	li	a5,57
    1358:	02e7ec63          	bltu	a5,a4,1390 <vprintfmt+0x198>
    135c:	f5043783          	ld	a5,-176(s0)
    1360:	f5040713          	addi	a4,s0,-176
    1364:	00a00613          	li	a2,10
    1368:	00070593          	mv	a1,a4
    136c:	00078513          	mv	a0,a5
    1370:	865ff0ef          	jal	bd4 <strtol>
    1374:	00050793          	mv	a5,a0
    1378:	0007879b          	sext.w	a5,a5
    137c:	f8f42423          	sw	a5,-120(s0)
    1380:	f5043783          	ld	a5,-176(s0)
    1384:	fff78793          	addi	a5,a5,-1
    1388:	f4f43823          	sd	a5,-176(s0)
    138c:	6280006f          	j	19b4 <vprintfmt+0x7bc>
    1390:	f5043783          	ld	a5,-176(s0)
    1394:	0007c783          	lbu	a5,0(a5)
    1398:	00078713          	mv	a4,a5
    139c:	02e00793          	li	a5,46
    13a0:	06f71863          	bne	a4,a5,1410 <vprintfmt+0x218>
    13a4:	f5043783          	ld	a5,-176(s0)
    13a8:	00178793          	addi	a5,a5,1
    13ac:	f4f43823          	sd	a5,-176(s0)
    13b0:	f5043783          	ld	a5,-176(s0)
    13b4:	0007c783          	lbu	a5,0(a5)
    13b8:	00078713          	mv	a4,a5
    13bc:	02a00793          	li	a5,42
    13c0:	00f71e63          	bne	a4,a5,13dc <vprintfmt+0x1e4>
    13c4:	f4843783          	ld	a5,-184(s0)
    13c8:	00878713          	addi	a4,a5,8
    13cc:	f4e43423          	sd	a4,-184(s0)
    13d0:	0007a783          	lw	a5,0(a5)
    13d4:	f8f42623          	sw	a5,-116(s0)
    13d8:	5dc0006f          	j	19b4 <vprintfmt+0x7bc>
    13dc:	f5043783          	ld	a5,-176(s0)
    13e0:	f5040713          	addi	a4,s0,-176
    13e4:	00a00613          	li	a2,10
    13e8:	00070593          	mv	a1,a4
    13ec:	00078513          	mv	a0,a5
    13f0:	fe4ff0ef          	jal	bd4 <strtol>
    13f4:	00050793          	mv	a5,a0
    13f8:	0007879b          	sext.w	a5,a5
    13fc:	f8f42623          	sw	a5,-116(s0)
    1400:	f5043783          	ld	a5,-176(s0)
    1404:	fff78793          	addi	a5,a5,-1
    1408:	f4f43823          	sd	a5,-176(s0)
    140c:	5a80006f          	j	19b4 <vprintfmt+0x7bc>
    1410:	f5043783          	ld	a5,-176(s0)
    1414:	0007c783          	lbu	a5,0(a5)
    1418:	00078713          	mv	a4,a5
    141c:	07800793          	li	a5,120
    1420:	02f70663          	beq	a4,a5,144c <vprintfmt+0x254>
    1424:	f5043783          	ld	a5,-176(s0)
    1428:	0007c783          	lbu	a5,0(a5)
    142c:	00078713          	mv	a4,a5
    1430:	05800793          	li	a5,88
    1434:	00f70c63          	beq	a4,a5,144c <vprintfmt+0x254>
    1438:	f5043783          	ld	a5,-176(s0)
    143c:	0007c783          	lbu	a5,0(a5)
    1440:	00078713          	mv	a4,a5
    1444:	07000793          	li	a5,112
    1448:	30f71063          	bne	a4,a5,1748 <vprintfmt+0x550>
    144c:	f5043783          	ld	a5,-176(s0)
    1450:	0007c783          	lbu	a5,0(a5)
    1454:	00078713          	mv	a4,a5
    1458:	07000793          	li	a5,112
    145c:	00f70663          	beq	a4,a5,1468 <vprintfmt+0x270>
    1460:	f8144783          	lbu	a5,-127(s0)
    1464:	00078663          	beqz	a5,1470 <vprintfmt+0x278>
    1468:	00100793          	li	a5,1
    146c:	0080006f          	j	1474 <vprintfmt+0x27c>
    1470:	00000793          	li	a5,0
    1474:	faf403a3          	sb	a5,-89(s0)
    1478:	fa744783          	lbu	a5,-89(s0)
    147c:	0017f793          	andi	a5,a5,1
    1480:	faf403a3          	sb	a5,-89(s0)
    1484:	fa744783          	lbu	a5,-89(s0)
    1488:	0ff7f793          	zext.b	a5,a5
    148c:	00078c63          	beqz	a5,14a4 <vprintfmt+0x2ac>
    1490:	f4843783          	ld	a5,-184(s0)
    1494:	00878713          	addi	a4,a5,8
    1498:	f4e43423          	sd	a4,-184(s0)
    149c:	0007b783          	ld	a5,0(a5)
    14a0:	01c0006f          	j	14bc <vprintfmt+0x2c4>
    14a4:	f4843783          	ld	a5,-184(s0)
    14a8:	00878713          	addi	a4,a5,8
    14ac:	f4e43423          	sd	a4,-184(s0)
    14b0:	0007a783          	lw	a5,0(a5)
    14b4:	02079793          	slli	a5,a5,0x20
    14b8:	0207d793          	srli	a5,a5,0x20
    14bc:	fef43023          	sd	a5,-32(s0)
    14c0:	f8c42783          	lw	a5,-116(s0)
    14c4:	02079463          	bnez	a5,14ec <vprintfmt+0x2f4>
    14c8:	fe043783          	ld	a5,-32(s0)
    14cc:	02079063          	bnez	a5,14ec <vprintfmt+0x2f4>
    14d0:	f5043783          	ld	a5,-176(s0)
    14d4:	0007c783          	lbu	a5,0(a5)
    14d8:	00078713          	mv	a4,a5
    14dc:	07000793          	li	a5,112
    14e0:	00f70663          	beq	a4,a5,14ec <vprintfmt+0x2f4>
    14e4:	f8040023          	sb	zero,-128(s0)
    14e8:	4cc0006f          	j	19b4 <vprintfmt+0x7bc>
    14ec:	f5043783          	ld	a5,-176(s0)
    14f0:	0007c783          	lbu	a5,0(a5)
    14f4:	00078713          	mv	a4,a5
    14f8:	07000793          	li	a5,112
    14fc:	00f70a63          	beq	a4,a5,1510 <vprintfmt+0x318>
    1500:	f8244783          	lbu	a5,-126(s0)
    1504:	00078a63          	beqz	a5,1518 <vprintfmt+0x320>
    1508:	fe043783          	ld	a5,-32(s0)
    150c:	00078663          	beqz	a5,1518 <vprintfmt+0x320>
    1510:	00100793          	li	a5,1
    1514:	0080006f          	j	151c <vprintfmt+0x324>
    1518:	00000793          	li	a5,0
    151c:	faf40323          	sb	a5,-90(s0)
    1520:	fa644783          	lbu	a5,-90(s0)
    1524:	0017f793          	andi	a5,a5,1
    1528:	faf40323          	sb	a5,-90(s0)
    152c:	fc042e23          	sw	zero,-36(s0)
    1530:	f5043783          	ld	a5,-176(s0)
    1534:	0007c783          	lbu	a5,0(a5)
    1538:	00078713          	mv	a4,a5
    153c:	05800793          	li	a5,88
    1540:	00f71863          	bne	a4,a5,1550 <vprintfmt+0x358>
    1544:	00001797          	auipc	a5,0x1
    1548:	cfc78793          	addi	a5,a5,-772 # 2240 <upperxdigits.1>
    154c:	00c0006f          	j	1558 <vprintfmt+0x360>
    1550:	00001797          	auipc	a5,0x1
    1554:	d0878793          	addi	a5,a5,-760 # 2258 <lowerxdigits.0>
    1558:	f8f43c23          	sd	a5,-104(s0)
    155c:	fe043783          	ld	a5,-32(s0)
    1560:	00f7f793          	andi	a5,a5,15
    1564:	f9843703          	ld	a4,-104(s0)
    1568:	00f70733          	add	a4,a4,a5
    156c:	fdc42783          	lw	a5,-36(s0)
    1570:	0017869b          	addiw	a3,a5,1
    1574:	fcd42e23          	sw	a3,-36(s0)
    1578:	00074703          	lbu	a4,0(a4)
    157c:	ff078793          	addi	a5,a5,-16
    1580:	008787b3          	add	a5,a5,s0
    1584:	f8e78023          	sb	a4,-128(a5)
    1588:	fe043783          	ld	a5,-32(s0)
    158c:	0047d793          	srli	a5,a5,0x4
    1590:	fef43023          	sd	a5,-32(s0)
    1594:	fe043783          	ld	a5,-32(s0)
    1598:	fc0792e3          	bnez	a5,155c <vprintfmt+0x364>
    159c:	f8c42703          	lw	a4,-116(s0)
    15a0:	fff00793          	li	a5,-1
    15a4:	02f71663          	bne	a4,a5,15d0 <vprintfmt+0x3d8>
    15a8:	f8344783          	lbu	a5,-125(s0)
    15ac:	02078263          	beqz	a5,15d0 <vprintfmt+0x3d8>
    15b0:	f8842703          	lw	a4,-120(s0)
    15b4:	fa644783          	lbu	a5,-90(s0)
    15b8:	0007879b          	sext.w	a5,a5
    15bc:	0017979b          	slliw	a5,a5,0x1
    15c0:	0007879b          	sext.w	a5,a5
    15c4:	40f707bb          	subw	a5,a4,a5
    15c8:	0007879b          	sext.w	a5,a5
    15cc:	f8f42623          	sw	a5,-116(s0)
    15d0:	f8842703          	lw	a4,-120(s0)
    15d4:	fa644783          	lbu	a5,-90(s0)
    15d8:	0007879b          	sext.w	a5,a5
    15dc:	0017979b          	slliw	a5,a5,0x1
    15e0:	0007879b          	sext.w	a5,a5
    15e4:	40f707bb          	subw	a5,a4,a5
    15e8:	0007871b          	sext.w	a4,a5
    15ec:	fdc42783          	lw	a5,-36(s0)
    15f0:	f8f42a23          	sw	a5,-108(s0)
    15f4:	f8c42783          	lw	a5,-116(s0)
    15f8:	f8f42823          	sw	a5,-112(s0)
    15fc:	f9442783          	lw	a5,-108(s0)
    1600:	00078593          	mv	a1,a5
    1604:	f9042783          	lw	a5,-112(s0)
    1608:	00078613          	mv	a2,a5
    160c:	0006069b          	sext.w	a3,a2
    1610:	0005879b          	sext.w	a5,a1
    1614:	00f6d463          	bge	a3,a5,161c <vprintfmt+0x424>
    1618:	00058613          	mv	a2,a1
    161c:	0006079b          	sext.w	a5,a2
    1620:	40f707bb          	subw	a5,a4,a5
    1624:	fcf42c23          	sw	a5,-40(s0)
    1628:	0280006f          	j	1650 <vprintfmt+0x458>
    162c:	f5843783          	ld	a5,-168(s0)
    1630:	02000513          	li	a0,32
    1634:	000780e7          	jalr	a5
    1638:	fec42783          	lw	a5,-20(s0)
    163c:	0017879b          	addiw	a5,a5,1
    1640:	fef42623          	sw	a5,-20(s0)
    1644:	fd842783          	lw	a5,-40(s0)
    1648:	fff7879b          	addiw	a5,a5,-1
    164c:	fcf42c23          	sw	a5,-40(s0)
    1650:	fd842783          	lw	a5,-40(s0)
    1654:	0007879b          	sext.w	a5,a5
    1658:	fcf04ae3          	bgtz	a5,162c <vprintfmt+0x434>
    165c:	fa644783          	lbu	a5,-90(s0)
    1660:	0ff7f793          	zext.b	a5,a5
    1664:	04078463          	beqz	a5,16ac <vprintfmt+0x4b4>
    1668:	f5843783          	ld	a5,-168(s0)
    166c:	03000513          	li	a0,48
    1670:	000780e7          	jalr	a5
    1674:	f5043783          	ld	a5,-176(s0)
    1678:	0007c783          	lbu	a5,0(a5)
    167c:	00078713          	mv	a4,a5
    1680:	05800793          	li	a5,88
    1684:	00f71663          	bne	a4,a5,1690 <vprintfmt+0x498>
    1688:	05800793          	li	a5,88
    168c:	0080006f          	j	1694 <vprintfmt+0x49c>
    1690:	07800793          	li	a5,120
    1694:	f5843703          	ld	a4,-168(s0)
    1698:	00078513          	mv	a0,a5
    169c:	000700e7          	jalr	a4
    16a0:	fec42783          	lw	a5,-20(s0)
    16a4:	0027879b          	addiw	a5,a5,2
    16a8:	fef42623          	sw	a5,-20(s0)
    16ac:	fdc42783          	lw	a5,-36(s0)
    16b0:	fcf42a23          	sw	a5,-44(s0)
    16b4:	0280006f          	j	16dc <vprintfmt+0x4e4>
    16b8:	f5843783          	ld	a5,-168(s0)
    16bc:	03000513          	li	a0,48
    16c0:	000780e7          	jalr	a5
    16c4:	fec42783          	lw	a5,-20(s0)
    16c8:	0017879b          	addiw	a5,a5,1
    16cc:	fef42623          	sw	a5,-20(s0)
    16d0:	fd442783          	lw	a5,-44(s0)
    16d4:	0017879b          	addiw	a5,a5,1
    16d8:	fcf42a23          	sw	a5,-44(s0)
    16dc:	f8c42783          	lw	a5,-116(s0)
    16e0:	fd442703          	lw	a4,-44(s0)
    16e4:	0007071b          	sext.w	a4,a4
    16e8:	fcf748e3          	blt	a4,a5,16b8 <vprintfmt+0x4c0>
    16ec:	fdc42783          	lw	a5,-36(s0)
    16f0:	fff7879b          	addiw	a5,a5,-1
    16f4:	fcf42823          	sw	a5,-48(s0)
    16f8:	03c0006f          	j	1734 <vprintfmt+0x53c>
    16fc:	fd042783          	lw	a5,-48(s0)
    1700:	ff078793          	addi	a5,a5,-16
    1704:	008787b3          	add	a5,a5,s0
    1708:	f807c783          	lbu	a5,-128(a5)
    170c:	0007871b          	sext.w	a4,a5
    1710:	f5843783          	ld	a5,-168(s0)
    1714:	00070513          	mv	a0,a4
    1718:	000780e7          	jalr	a5
    171c:	fec42783          	lw	a5,-20(s0)
    1720:	0017879b          	addiw	a5,a5,1
    1724:	fef42623          	sw	a5,-20(s0)
    1728:	fd042783          	lw	a5,-48(s0)
    172c:	fff7879b          	addiw	a5,a5,-1
    1730:	fcf42823          	sw	a5,-48(s0)
    1734:	fd042783          	lw	a5,-48(s0)
    1738:	0007879b          	sext.w	a5,a5
    173c:	fc07d0e3          	bgez	a5,16fc <vprintfmt+0x504>
    1740:	f8040023          	sb	zero,-128(s0)
    1744:	2700006f          	j	19b4 <vprintfmt+0x7bc>
    1748:	f5043783          	ld	a5,-176(s0)
    174c:	0007c783          	lbu	a5,0(a5)
    1750:	00078713          	mv	a4,a5
    1754:	06400793          	li	a5,100
    1758:	02f70663          	beq	a4,a5,1784 <vprintfmt+0x58c>
    175c:	f5043783          	ld	a5,-176(s0)
    1760:	0007c783          	lbu	a5,0(a5)
    1764:	00078713          	mv	a4,a5
    1768:	06900793          	li	a5,105
    176c:	00f70c63          	beq	a4,a5,1784 <vprintfmt+0x58c>
    1770:	f5043783          	ld	a5,-176(s0)
    1774:	0007c783          	lbu	a5,0(a5)
    1778:	00078713          	mv	a4,a5
    177c:	07500793          	li	a5,117
    1780:	08f71063          	bne	a4,a5,1800 <vprintfmt+0x608>
    1784:	f8144783          	lbu	a5,-127(s0)
    1788:	00078c63          	beqz	a5,17a0 <vprintfmt+0x5a8>
    178c:	f4843783          	ld	a5,-184(s0)
    1790:	00878713          	addi	a4,a5,8
    1794:	f4e43423          	sd	a4,-184(s0)
    1798:	0007b783          	ld	a5,0(a5)
    179c:	0140006f          	j	17b0 <vprintfmt+0x5b8>
    17a0:	f4843783          	ld	a5,-184(s0)
    17a4:	00878713          	addi	a4,a5,8
    17a8:	f4e43423          	sd	a4,-184(s0)
    17ac:	0007a783          	lw	a5,0(a5)
    17b0:	faf43423          	sd	a5,-88(s0)
    17b4:	fa843583          	ld	a1,-88(s0)
    17b8:	f5043783          	ld	a5,-176(s0)
    17bc:	0007c783          	lbu	a5,0(a5)
    17c0:	0007871b          	sext.w	a4,a5
    17c4:	07500793          	li	a5,117
    17c8:	40f707b3          	sub	a5,a4,a5
    17cc:	00f037b3          	snez	a5,a5
    17d0:	0ff7f793          	zext.b	a5,a5
    17d4:	f8040713          	addi	a4,s0,-128
    17d8:	00070693          	mv	a3,a4
    17dc:	00078613          	mv	a2,a5
    17e0:	f5843503          	ld	a0,-168(s0)
    17e4:	ee4ff0ef          	jal	ec8 <print_dec_int>
    17e8:	00050793          	mv	a5,a0
    17ec:	fec42703          	lw	a4,-20(s0)
    17f0:	00f707bb          	addw	a5,a4,a5
    17f4:	fef42623          	sw	a5,-20(s0)
    17f8:	f8040023          	sb	zero,-128(s0)
    17fc:	1b80006f          	j	19b4 <vprintfmt+0x7bc>
    1800:	f5043783          	ld	a5,-176(s0)
    1804:	0007c783          	lbu	a5,0(a5)
    1808:	00078713          	mv	a4,a5
    180c:	06e00793          	li	a5,110
    1810:	04f71c63          	bne	a4,a5,1868 <vprintfmt+0x670>
    1814:	f8144783          	lbu	a5,-127(s0)
    1818:	02078463          	beqz	a5,1840 <vprintfmt+0x648>
    181c:	f4843783          	ld	a5,-184(s0)
    1820:	00878713          	addi	a4,a5,8
    1824:	f4e43423          	sd	a4,-184(s0)
    1828:	0007b783          	ld	a5,0(a5)
    182c:	faf43823          	sd	a5,-80(s0)
    1830:	fec42703          	lw	a4,-20(s0)
    1834:	fb043783          	ld	a5,-80(s0)
    1838:	00e7b023          	sd	a4,0(a5)
    183c:	0240006f          	j	1860 <vprintfmt+0x668>
    1840:	f4843783          	ld	a5,-184(s0)
    1844:	00878713          	addi	a4,a5,8
    1848:	f4e43423          	sd	a4,-184(s0)
    184c:	0007b783          	ld	a5,0(a5)
    1850:	faf43c23          	sd	a5,-72(s0)
    1854:	fb843783          	ld	a5,-72(s0)
    1858:	fec42703          	lw	a4,-20(s0)
    185c:	00e7a023          	sw	a4,0(a5)
    1860:	f8040023          	sb	zero,-128(s0)
    1864:	1500006f          	j	19b4 <vprintfmt+0x7bc>
    1868:	f5043783          	ld	a5,-176(s0)
    186c:	0007c783          	lbu	a5,0(a5)
    1870:	00078713          	mv	a4,a5
    1874:	07300793          	li	a5,115
    1878:	02f71e63          	bne	a4,a5,18b4 <vprintfmt+0x6bc>
    187c:	f4843783          	ld	a5,-184(s0)
    1880:	00878713          	addi	a4,a5,8
    1884:	f4e43423          	sd	a4,-184(s0)
    1888:	0007b783          	ld	a5,0(a5)
    188c:	fcf43023          	sd	a5,-64(s0)
    1890:	fc043583          	ld	a1,-64(s0)
    1894:	f5843503          	ld	a0,-168(s0)
    1898:	da8ff0ef          	jal	e40 <puts_wo_nl>
    189c:	00050793          	mv	a5,a0
    18a0:	fec42703          	lw	a4,-20(s0)
    18a4:	00f707bb          	addw	a5,a4,a5
    18a8:	fef42623          	sw	a5,-20(s0)
    18ac:	f8040023          	sb	zero,-128(s0)
    18b0:	1040006f          	j	19b4 <vprintfmt+0x7bc>
    18b4:	f5043783          	ld	a5,-176(s0)
    18b8:	0007c783          	lbu	a5,0(a5)
    18bc:	00078713          	mv	a4,a5
    18c0:	06300793          	li	a5,99
    18c4:	02f71e63          	bne	a4,a5,1900 <vprintfmt+0x708>
    18c8:	f4843783          	ld	a5,-184(s0)
    18cc:	00878713          	addi	a4,a5,8
    18d0:	f4e43423          	sd	a4,-184(s0)
    18d4:	0007a783          	lw	a5,0(a5)
    18d8:	fcf42623          	sw	a5,-52(s0)
    18dc:	fcc42703          	lw	a4,-52(s0)
    18e0:	f5843783          	ld	a5,-168(s0)
    18e4:	00070513          	mv	a0,a4
    18e8:	000780e7          	jalr	a5
    18ec:	fec42783          	lw	a5,-20(s0)
    18f0:	0017879b          	addiw	a5,a5,1
    18f4:	fef42623          	sw	a5,-20(s0)
    18f8:	f8040023          	sb	zero,-128(s0)
    18fc:	0b80006f          	j	19b4 <vprintfmt+0x7bc>
    1900:	f5043783          	ld	a5,-176(s0)
    1904:	0007c783          	lbu	a5,0(a5)
    1908:	00078713          	mv	a4,a5
    190c:	02500793          	li	a5,37
    1910:	02f71263          	bne	a4,a5,1934 <vprintfmt+0x73c>
    1914:	f5843783          	ld	a5,-168(s0)
    1918:	02500513          	li	a0,37
    191c:	000780e7          	jalr	a5
    1920:	fec42783          	lw	a5,-20(s0)
    1924:	0017879b          	addiw	a5,a5,1
    1928:	fef42623          	sw	a5,-20(s0)
    192c:	f8040023          	sb	zero,-128(s0)
    1930:	0840006f          	j	19b4 <vprintfmt+0x7bc>
    1934:	f5043783          	ld	a5,-176(s0)
    1938:	0007c783          	lbu	a5,0(a5)
    193c:	0007871b          	sext.w	a4,a5
    1940:	f5843783          	ld	a5,-168(s0)
    1944:	00070513          	mv	a0,a4
    1948:	000780e7          	jalr	a5
    194c:	fec42783          	lw	a5,-20(s0)
    1950:	0017879b          	addiw	a5,a5,1
    1954:	fef42623          	sw	a5,-20(s0)
    1958:	f8040023          	sb	zero,-128(s0)
    195c:	0580006f          	j	19b4 <vprintfmt+0x7bc>
    1960:	f5043783          	ld	a5,-176(s0)
    1964:	0007c783          	lbu	a5,0(a5)
    1968:	00078713          	mv	a4,a5
    196c:	02500793          	li	a5,37
    1970:	02f71063          	bne	a4,a5,1990 <vprintfmt+0x798>
    1974:	f8043023          	sd	zero,-128(s0)
    1978:	f8043423          	sd	zero,-120(s0)
    197c:	00100793          	li	a5,1
    1980:	f8f40023          	sb	a5,-128(s0)
    1984:	fff00793          	li	a5,-1
    1988:	f8f42623          	sw	a5,-116(s0)
    198c:	0280006f          	j	19b4 <vprintfmt+0x7bc>
    1990:	f5043783          	ld	a5,-176(s0)
    1994:	0007c783          	lbu	a5,0(a5)
    1998:	0007871b          	sext.w	a4,a5
    199c:	f5843783          	ld	a5,-168(s0)
    19a0:	00070513          	mv	a0,a4
    19a4:	000780e7          	jalr	a5
    19a8:	fec42783          	lw	a5,-20(s0)
    19ac:	0017879b          	addiw	a5,a5,1
    19b0:	fef42623          	sw	a5,-20(s0)
    19b4:	f5043783          	ld	a5,-176(s0)
    19b8:	00178793          	addi	a5,a5,1
    19bc:	f4f43823          	sd	a5,-176(s0)
    19c0:	f5043783          	ld	a5,-176(s0)
    19c4:	0007c783          	lbu	a5,0(a5)
    19c8:	84079ee3          	bnez	a5,1224 <vprintfmt+0x2c>
    19cc:	fec42783          	lw	a5,-20(s0)
    19d0:	00078513          	mv	a0,a5
    19d4:	0b813083          	ld	ra,184(sp)
    19d8:	0b013403          	ld	s0,176(sp)
    19dc:	0c010113          	addi	sp,sp,192
    19e0:	00008067          	ret

Disassembly of section .text.printf:

00000000000019e4 <printf>:
    19e4:	f8010113          	addi	sp,sp,-128
    19e8:	02113c23          	sd	ra,56(sp)
    19ec:	02813823          	sd	s0,48(sp)
    19f0:	04010413          	addi	s0,sp,64
    19f4:	fca43423          	sd	a0,-56(s0)
    19f8:	00b43423          	sd	a1,8(s0)
    19fc:	00c43823          	sd	a2,16(s0)
    1a00:	00d43c23          	sd	a3,24(s0)
    1a04:	02e43023          	sd	a4,32(s0)
    1a08:	02f43423          	sd	a5,40(s0)
    1a0c:	03043823          	sd	a6,48(s0)
    1a10:	03143c23          	sd	a7,56(s0)
    1a14:	fe042623          	sw	zero,-20(s0)
    1a18:	04040793          	addi	a5,s0,64
    1a1c:	fcf43023          	sd	a5,-64(s0)
    1a20:	fc043783          	ld	a5,-64(s0)
    1a24:	fc878793          	addi	a5,a5,-56
    1a28:	fcf43823          	sd	a5,-48(s0)
    1a2c:	fd043783          	ld	a5,-48(s0)
    1a30:	00078613          	mv	a2,a5
    1a34:	fc843583          	ld	a1,-56(s0)
    1a38:	fffff517          	auipc	a0,0xfffff
    1a3c:	0c450513          	addi	a0,a0,196 # afc <putc>
    1a40:	fb8ff0ef          	jal	11f8 <vprintfmt>
    1a44:	00050793          	mv	a5,a0
    1a48:	fef42623          	sw	a5,-20(s0)
    1a4c:	00100793          	li	a5,1
    1a50:	fef43023          	sd	a5,-32(s0)
    1a54:	00002797          	auipc	a5,0x2
    1a58:	81c78793          	addi	a5,a5,-2020 # 3270 <tail>
    1a5c:	0007a783          	lw	a5,0(a5)
    1a60:	0017871b          	addiw	a4,a5,1
    1a64:	0007069b          	sext.w	a3,a4
    1a68:	00002717          	auipc	a4,0x2
    1a6c:	80870713          	addi	a4,a4,-2040 # 3270 <tail>
    1a70:	00d72023          	sw	a3,0(a4)
    1a74:	00002717          	auipc	a4,0x2
    1a78:	80470713          	addi	a4,a4,-2044 # 3278 <buffer>
    1a7c:	00f707b3          	add	a5,a4,a5
    1a80:	00078023          	sb	zero,0(a5)
    1a84:	00001797          	auipc	a5,0x1
    1a88:	7ec78793          	addi	a5,a5,2028 # 3270 <tail>
    1a8c:	0007a603          	lw	a2,0(a5)
    1a90:	fe043703          	ld	a4,-32(s0)
    1a94:	00001697          	auipc	a3,0x1
    1a98:	7e468693          	addi	a3,a3,2020 # 3278 <buffer>
    1a9c:	fd843783          	ld	a5,-40(s0)
    1aa0:	04000893          	li	a7,64
    1aa4:	00070513          	mv	a0,a4
    1aa8:	00068593          	mv	a1,a3
    1aac:	00060613          	mv	a2,a2
    1ab0:	00000073          	ecall
    1ab4:	00050793          	mv	a5,a0
    1ab8:	fcf43c23          	sd	a5,-40(s0)
    1abc:	00001797          	auipc	a5,0x1
    1ac0:	7b478793          	addi	a5,a5,1972 # 3270 <tail>
    1ac4:	0007a023          	sw	zero,0(a5)
    1ac8:	fec42783          	lw	a5,-20(s0)
    1acc:	00078513          	mv	a0,a5
    1ad0:	03813083          	ld	ra,56(sp)
    1ad4:	03013403          	ld	s0,48(sp)
    1ad8:	08010113          	addi	sp,sp,128
    1adc:	00008067          	ret

Disassembly of section .text.strlen:

0000000000001ae0 <strlen>:
    1ae0:	fd010113          	addi	sp,sp,-48
    1ae4:	02113423          	sd	ra,40(sp)
    1ae8:	02813023          	sd	s0,32(sp)
    1aec:	03010413          	addi	s0,sp,48
    1af0:	fca43c23          	sd	a0,-40(s0)
    1af4:	fe042623          	sw	zero,-20(s0)
    1af8:	0100006f          	j	1b08 <strlen+0x28>
    1afc:	fec42783          	lw	a5,-20(s0)
    1b00:	0017879b          	addiw	a5,a5,1
    1b04:	fef42623          	sw	a5,-20(s0)
    1b08:	fd843783          	ld	a5,-40(s0)
    1b0c:	00178713          	addi	a4,a5,1
    1b10:	fce43c23          	sd	a4,-40(s0)
    1b14:	0007c783          	lbu	a5,0(a5)
    1b18:	fe0792e3          	bnez	a5,1afc <strlen+0x1c>
    1b1c:	fec42783          	lw	a5,-20(s0)
    1b20:	00078513          	mv	a0,a5
    1b24:	02813083          	ld	ra,40(sp)
    1b28:	02013403          	ld	s0,32(sp)
    1b2c:	03010113          	addi	sp,sp,48
    1b30:	00008067          	ret

Disassembly of section .text.write:

0000000000001b34 <write>:
    1b34:	fb010113          	addi	sp,sp,-80
    1b38:	04113423          	sd	ra,72(sp)
    1b3c:	04813023          	sd	s0,64(sp)
    1b40:	05010413          	addi	s0,sp,80
    1b44:	00050693          	mv	a3,a0
    1b48:	fcb43023          	sd	a1,-64(s0)
    1b4c:	fac43c23          	sd	a2,-72(s0)
    1b50:	fcd42623          	sw	a3,-52(s0)
    1b54:	00010693          	mv	a3,sp
    1b58:	00068593          	mv	a1,a3
    1b5c:	fb843683          	ld	a3,-72(s0)
    1b60:	00168693          	addi	a3,a3,1
    1b64:	00068613          	mv	a2,a3
    1b68:	fff60613          	addi	a2,a2,-1
    1b6c:	fec43023          	sd	a2,-32(s0)
    1b70:	00068e13          	mv	t3,a3
    1b74:	00000e93          	li	t4,0
    1b78:	03de5613          	srli	a2,t3,0x3d
    1b7c:	003e9893          	slli	a7,t4,0x3
    1b80:	011668b3          	or	a7,a2,a7
    1b84:	003e1813          	slli	a6,t3,0x3
    1b88:	00068313          	mv	t1,a3
    1b8c:	00000393          	li	t2,0
    1b90:	03d35613          	srli	a2,t1,0x3d
    1b94:	00339793          	slli	a5,t2,0x3
    1b98:	00f667b3          	or	a5,a2,a5
    1b9c:	00331713          	slli	a4,t1,0x3
    1ba0:	00f68793          	addi	a5,a3,15
    1ba4:	0047d793          	srli	a5,a5,0x4
    1ba8:	00479793          	slli	a5,a5,0x4
    1bac:	40f10133          	sub	sp,sp,a5
    1bb0:	00010793          	mv	a5,sp
    1bb4:	fcf43c23          	sd	a5,-40(s0)
    1bb8:	fe042623          	sw	zero,-20(s0)
    1bbc:	0300006f          	j	1bec <write+0xb8>
    1bc0:	fec42783          	lw	a5,-20(s0)
    1bc4:	fc043703          	ld	a4,-64(s0)
    1bc8:	00f707b3          	add	a5,a4,a5
    1bcc:	0007c703          	lbu	a4,0(a5)
    1bd0:	fd843683          	ld	a3,-40(s0)
    1bd4:	fec42783          	lw	a5,-20(s0)
    1bd8:	00f687b3          	add	a5,a3,a5
    1bdc:	00e78023          	sb	a4,0(a5)
    1be0:	fec42783          	lw	a5,-20(s0)
    1be4:	0017879b          	addiw	a5,a5,1
    1be8:	fef42623          	sw	a5,-20(s0)
    1bec:	fec42783          	lw	a5,-20(s0)
    1bf0:	fb843703          	ld	a4,-72(s0)
    1bf4:	fce7e6e3          	bltu	a5,a4,1bc0 <write+0x8c>
    1bf8:	fd843703          	ld	a4,-40(s0)
    1bfc:	fb843783          	ld	a5,-72(s0)
    1c00:	00f707b3          	add	a5,a4,a5
    1c04:	00078023          	sb	zero,0(a5)
    1c08:	fcc42703          	lw	a4,-52(s0)
    1c0c:	fd843683          	ld	a3,-40(s0)
    1c10:	fb843603          	ld	a2,-72(s0)
    1c14:	fd043783          	ld	a5,-48(s0)
    1c18:	04000893          	li	a7,64
    1c1c:	00070513          	mv	a0,a4
    1c20:	00068593          	mv	a1,a3
    1c24:	00060613          	mv	a2,a2
    1c28:	00000073          	ecall
    1c2c:	00050793          	mv	a5,a0
    1c30:	fcf43823          	sd	a5,-48(s0)
    1c34:	fd043783          	ld	a5,-48(s0)
    1c38:	0007879b          	sext.w	a5,a5
    1c3c:	00058113          	mv	sp,a1
    1c40:	00078513          	mv	a0,a5
    1c44:	fb040113          	addi	sp,s0,-80
    1c48:	04813083          	ld	ra,72(sp)
    1c4c:	04013403          	ld	s0,64(sp)
    1c50:	05010113          	addi	sp,sp,80
    1c54:	00008067          	ret

Disassembly of section .text.read:

0000000000001c58 <read>:
    1c58:	fc010113          	addi	sp,sp,-64
    1c5c:	02113c23          	sd	ra,56(sp)
    1c60:	02813823          	sd	s0,48(sp)
    1c64:	04010413          	addi	s0,sp,64
    1c68:	00050793          	mv	a5,a0
    1c6c:	fcb43823          	sd	a1,-48(s0)
    1c70:	fcc43423          	sd	a2,-56(s0)
    1c74:	fcf42e23          	sw	a5,-36(s0)
    1c78:	fdc42703          	lw	a4,-36(s0)
    1c7c:	fd043683          	ld	a3,-48(s0)
    1c80:	fc843603          	ld	a2,-56(s0)
    1c84:	fe843783          	ld	a5,-24(s0)
    1c88:	03f00893          	li	a7,63
    1c8c:	00070513          	mv	a0,a4
    1c90:	00068593          	mv	a1,a3
    1c94:	00060613          	mv	a2,a2
    1c98:	00000073          	ecall
    1c9c:	00050793          	mv	a5,a0
    1ca0:	fef43423          	sd	a5,-24(s0)
    1ca4:	fe843783          	ld	a5,-24(s0)
    1ca8:	0007879b          	sext.w	a5,a5
    1cac:	00078513          	mv	a0,a5
    1cb0:	03813083          	ld	ra,56(sp)
    1cb4:	03013403          	ld	s0,48(sp)
    1cb8:	04010113          	addi	sp,sp,64
    1cbc:	00008067          	ret

Disassembly of section .text.sys_openat:

0000000000001cc0 <sys_openat>:
    1cc0:	fd010113          	addi	sp,sp,-48
    1cc4:	02113423          	sd	ra,40(sp)
    1cc8:	02813023          	sd	s0,32(sp)
    1ccc:	03010413          	addi	s0,sp,48
    1cd0:	00050793          	mv	a5,a0
    1cd4:	fcb43823          	sd	a1,-48(s0)
    1cd8:	00060713          	mv	a4,a2
    1cdc:	fcf42e23          	sw	a5,-36(s0)
    1ce0:	00070793          	mv	a5,a4
    1ce4:	fcf42c23          	sw	a5,-40(s0)
    1ce8:	fdc42703          	lw	a4,-36(s0)
    1cec:	fd842603          	lw	a2,-40(s0)
    1cf0:	fd043683          	ld	a3,-48(s0)
    1cf4:	fe843783          	ld	a5,-24(s0)
    1cf8:	03800893          	li	a7,56
    1cfc:	00070513          	mv	a0,a4
    1d00:	00068593          	mv	a1,a3
    1d04:	00060613          	mv	a2,a2
    1d08:	00000073          	ecall
    1d0c:	00050793          	mv	a5,a0
    1d10:	fef43423          	sd	a5,-24(s0)
    1d14:	fe843783          	ld	a5,-24(s0)
    1d18:	0007879b          	sext.w	a5,a5
    1d1c:	00078513          	mv	a0,a5
    1d20:	02813083          	ld	ra,40(sp)
    1d24:	02013403          	ld	s0,32(sp)
    1d28:	03010113          	addi	sp,sp,48
    1d2c:	00008067          	ret

Disassembly of section .text.open:

0000000000001d30 <open>:
    1d30:	fe010113          	addi	sp,sp,-32
    1d34:	00113c23          	sd	ra,24(sp)
    1d38:	00813823          	sd	s0,16(sp)
    1d3c:	02010413          	addi	s0,sp,32
    1d40:	fea43423          	sd	a0,-24(s0)
    1d44:	00058793          	mv	a5,a1
    1d48:	fef42223          	sw	a5,-28(s0)
    1d4c:	fe442783          	lw	a5,-28(s0)
    1d50:	00078613          	mv	a2,a5
    1d54:	fe843583          	ld	a1,-24(s0)
    1d58:	f9c00513          	li	a0,-100
    1d5c:	f65ff0ef          	jal	1cc0 <sys_openat>
    1d60:	00050793          	mv	a5,a0
    1d64:	00078513          	mv	a0,a5
    1d68:	01813083          	ld	ra,24(sp)
    1d6c:	01013403          	ld	s0,16(sp)
    1d70:	02010113          	addi	sp,sp,32
    1d74:	00008067          	ret

Disassembly of section .text.close:

0000000000001d78 <close>:
    1d78:	fd010113          	addi	sp,sp,-48
    1d7c:	02113423          	sd	ra,40(sp)
    1d80:	02813023          	sd	s0,32(sp)
    1d84:	03010413          	addi	s0,sp,48
    1d88:	00050793          	mv	a5,a0
    1d8c:	fcf42e23          	sw	a5,-36(s0)
    1d90:	fdc42703          	lw	a4,-36(s0)
    1d94:	fe843783          	ld	a5,-24(s0)
    1d98:	03900893          	li	a7,57
    1d9c:	00070513          	mv	a0,a4
    1da0:	00000073          	ecall
    1da4:	00050793          	mv	a5,a0
    1da8:	fef43423          	sd	a5,-24(s0)
    1dac:	fe843783          	ld	a5,-24(s0)
    1db0:	0007879b          	sext.w	a5,a5
    1db4:	00078513          	mv	a0,a5
    1db8:	02813083          	ld	ra,40(sp)
    1dbc:	02013403          	ld	s0,32(sp)
    1dc0:	03010113          	addi	sp,sp,48
    1dc4:	00008067          	ret

Disassembly of section .text.lseek:

0000000000001dc8 <lseek>:
    1dc8:	fd010113          	addi	sp,sp,-48
    1dcc:	02113423          	sd	ra,40(sp)
    1dd0:	02813023          	sd	s0,32(sp)
    1dd4:	03010413          	addi	s0,sp,48
    1dd8:	00050793          	mv	a5,a0
    1ddc:	00058693          	mv	a3,a1
    1de0:	00060713          	mv	a4,a2
    1de4:	fcf42e23          	sw	a5,-36(s0)
    1de8:	00068793          	mv	a5,a3
    1dec:	fcf42c23          	sw	a5,-40(s0)
    1df0:	00070793          	mv	a5,a4
    1df4:	fcf42a23          	sw	a5,-44(s0)
    1df8:	fdc42703          	lw	a4,-36(s0)
    1dfc:	fd842683          	lw	a3,-40(s0)
    1e00:	fd442603          	lw	a2,-44(s0)
    1e04:	fe843783          	ld	a5,-24(s0)
    1e08:	03e00893          	li	a7,62
    1e0c:	00070513          	mv	a0,a4
    1e10:	00068593          	mv	a1,a3
    1e14:	00060613          	mv	a2,a2
    1e18:	00000073          	ecall
    1e1c:	00050793          	mv	a5,a0
    1e20:	fef43423          	sd	a5,-24(s0)
    1e24:	fe843783          	ld	a5,-24(s0)
    1e28:	0007879b          	sext.w	a5,a5
    1e2c:	00078513          	mv	a0,a5
    1e30:	02813083          	ld	ra,40(sp)
    1e34:	02013403          	ld	s0,32(sp)
    1e38:	03010113          	addi	sp,sp,48
    1e3c:	00008067          	ret
