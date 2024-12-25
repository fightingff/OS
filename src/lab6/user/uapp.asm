
uapp:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <_start>:
   100e8:	1b50006f          	j	10a9c <main>

00000000000100ec <atoi>:
   100ec:	fd010113          	addi	sp,sp,-48
   100f0:	02113423          	sd	ra,40(sp)
   100f4:	02813023          	sd	s0,32(sp)
   100f8:	03010413          	addi	s0,sp,48
   100fc:	fca43c23          	sd	a0,-40(s0)
   10100:	fe042623          	sw	zero,-20(s0)
   10104:	fd843503          	ld	a0,-40(s0)
   10108:	2c1010ef          	jal	11bc8 <strlen>
   1010c:	00050793          	mv	a5,a0
   10110:	fef42223          	sw	a5,-28(s0)
   10114:	fe042423          	sw	zero,-24(s0)
   10118:	0500006f          	j	10168 <atoi+0x7c>
   1011c:	fec42783          	lw	a5,-20(s0)
   10120:	00078713          	mv	a4,a5
   10124:	00070793          	mv	a5,a4
   10128:	0027979b          	slliw	a5,a5,0x2
   1012c:	00e787bb          	addw	a5,a5,a4
   10130:	0017979b          	slliw	a5,a5,0x1
   10134:	0007871b          	sext.w	a4,a5
   10138:	fe842783          	lw	a5,-24(s0)
   1013c:	fd843683          	ld	a3,-40(s0)
   10140:	00f687b3          	add	a5,a3,a5
   10144:	0007c783          	lbu	a5,0(a5)
   10148:	0007879b          	sext.w	a5,a5
   1014c:	00f707bb          	addw	a5,a4,a5
   10150:	0007879b          	sext.w	a5,a5
   10154:	fd07879b          	addiw	a5,a5,-48
   10158:	fef42623          	sw	a5,-20(s0)
   1015c:	fe842783          	lw	a5,-24(s0)
   10160:	0017879b          	addiw	a5,a5,1
   10164:	fef42423          	sw	a5,-24(s0)
   10168:	fe842783          	lw	a5,-24(s0)
   1016c:	00078713          	mv	a4,a5
   10170:	fe442783          	lw	a5,-28(s0)
   10174:	0007071b          	sext.w	a4,a4
   10178:	0007879b          	sext.w	a5,a5
   1017c:	faf740e3          	blt	a4,a5,1011c <atoi+0x30>
   10180:	fec42783          	lw	a5,-20(s0)
   10184:	00078513          	mv	a0,a5
   10188:	02813083          	ld	ra,40(sp)
   1018c:	02013403          	ld	s0,32(sp)
   10190:	03010113          	addi	sp,sp,48
   10194:	00008067          	ret

0000000000010198 <get_param>:
   10198:	fd010113          	addi	sp,sp,-48
   1019c:	02113423          	sd	ra,40(sp)
   101a0:	02813023          	sd	s0,32(sp)
   101a4:	03010413          	addi	s0,sp,48
   101a8:	fca43c23          	sd	a0,-40(s0)
   101ac:	0100006f          	j	101bc <get_param+0x24>
   101b0:	fd843783          	ld	a5,-40(s0)
   101b4:	00178793          	addi	a5,a5,1
   101b8:	fcf43c23          	sd	a5,-40(s0)
   101bc:	fd843783          	ld	a5,-40(s0)
   101c0:	0007c783          	lbu	a5,0(a5)
   101c4:	00078713          	mv	a4,a5
   101c8:	02000793          	li	a5,32
   101cc:	fef702e3          	beq	a4,a5,101b0 <get_param+0x18>
   101d0:	fe042623          	sw	zero,-20(s0)
   101d4:	0300006f          	j	10204 <get_param+0x6c>
   101d8:	fd843703          	ld	a4,-40(s0)
   101dc:	00170793          	addi	a5,a4,1
   101e0:	fcf43c23          	sd	a5,-40(s0)
   101e4:	fec42783          	lw	a5,-20(s0)
   101e8:	0017869b          	addiw	a3,a5,1
   101ec:	fed42623          	sw	a3,-20(s0)
   101f0:	00074703          	lbu	a4,0(a4)
   101f4:	00003697          	auipc	a3,0x3
   101f8:	e0c68693          	addi	a3,a3,-500 # 13000 <string_buf>
   101fc:	00f687b3          	add	a5,a3,a5
   10200:	00e78023          	sb	a4,0(a5)
   10204:	fd843783          	ld	a5,-40(s0)
   10208:	0007c783          	lbu	a5,0(a5)
   1020c:	00078c63          	beqz	a5,10224 <get_param+0x8c>
   10210:	fd843783          	ld	a5,-40(s0)
   10214:	0007c783          	lbu	a5,0(a5)
   10218:	00078713          	mv	a4,a5
   1021c:	02000793          	li	a5,32
   10220:	faf71ce3          	bne	a4,a5,101d8 <get_param+0x40>
   10224:	00003717          	auipc	a4,0x3
   10228:	ddc70713          	addi	a4,a4,-548 # 13000 <string_buf>
   1022c:	fec42783          	lw	a5,-20(s0)
   10230:	00f707b3          	add	a5,a4,a5
   10234:	00078023          	sb	zero,0(a5)
   10238:	00003797          	auipc	a5,0x3
   1023c:	dc878793          	addi	a5,a5,-568 # 13000 <string_buf>
   10240:	00078513          	mv	a0,a5
   10244:	02813083          	ld	ra,40(sp)
   10248:	02013403          	ld	s0,32(sp)
   1024c:	03010113          	addi	sp,sp,48
   10250:	00008067          	ret

0000000000010254 <get_string>:
   10254:	fd010113          	addi	sp,sp,-48
   10258:	02113423          	sd	ra,40(sp)
   1025c:	02813023          	sd	s0,32(sp)
   10260:	03010413          	addi	s0,sp,48
   10264:	fca43c23          	sd	a0,-40(s0)
   10268:	0100006f          	j	10278 <get_string+0x24>
   1026c:	fd843783          	ld	a5,-40(s0)
   10270:	00178793          	addi	a5,a5,1
   10274:	fcf43c23          	sd	a5,-40(s0)
   10278:	fd843783          	ld	a5,-40(s0)
   1027c:	0007c783          	lbu	a5,0(a5)
   10280:	00078713          	mv	a4,a5
   10284:	02000793          	li	a5,32
   10288:	fef702e3          	beq	a4,a5,1026c <get_string+0x18>
   1028c:	fd843783          	ld	a5,-40(s0)
   10290:	0007c783          	lbu	a5,0(a5)
   10294:	00078713          	mv	a4,a5
   10298:	02200793          	li	a5,34
   1029c:	06f71c63          	bne	a4,a5,10314 <get_string+0xc0>
   102a0:	fd843783          	ld	a5,-40(s0)
   102a4:	00178793          	addi	a5,a5,1
   102a8:	fcf43c23          	sd	a5,-40(s0)
   102ac:	fe042623          	sw	zero,-20(s0)
   102b0:	0300006f          	j	102e0 <get_string+0x8c>
   102b4:	fd843703          	ld	a4,-40(s0)
   102b8:	00170793          	addi	a5,a4,1
   102bc:	fcf43c23          	sd	a5,-40(s0)
   102c0:	fec42783          	lw	a5,-20(s0)
   102c4:	0017869b          	addiw	a3,a5,1
   102c8:	fed42623          	sw	a3,-20(s0)
   102cc:	00074703          	lbu	a4,0(a4)
   102d0:	00003697          	auipc	a3,0x3
   102d4:	d3068693          	addi	a3,a3,-720 # 13000 <string_buf>
   102d8:	00f687b3          	add	a5,a3,a5
   102dc:	00e78023          	sb	a4,0(a5)
   102e0:	fd843783          	ld	a5,-40(s0)
   102e4:	0007c783          	lbu	a5,0(a5)
   102e8:	00078713          	mv	a4,a5
   102ec:	02200793          	li	a5,34
   102f0:	fcf712e3          	bne	a4,a5,102b4 <get_string+0x60>
   102f4:	00003717          	auipc	a4,0x3
   102f8:	d0c70713          	addi	a4,a4,-756 # 13000 <string_buf>
   102fc:	fec42783          	lw	a5,-20(s0)
   10300:	00f707b3          	add	a5,a4,a5
   10304:	00078023          	sb	zero,0(a5)
   10308:	00003797          	auipc	a5,0x3
   1030c:	cf878793          	addi	a5,a5,-776 # 13000 <string_buf>
   10310:	0100006f          	j	10320 <get_string+0xcc>
   10314:	fd843503          	ld	a0,-40(s0)
   10318:	e81ff0ef          	jal	10198 <get_param>
   1031c:	00050793          	mv	a5,a0
   10320:	00078513          	mv	a0,a5
   10324:	02813083          	ld	ra,40(sp)
   10328:	02013403          	ld	s0,32(sp)
   1032c:	03010113          	addi	sp,sp,48
   10330:	00008067          	ret

0000000000010334 <parse_cmd>:
   10334:	c9010113          	addi	sp,sp,-880
   10338:	36113423          	sd	ra,872(sp)
   1033c:	36813023          	sd	s0,864(sp)
   10340:	34913c23          	sd	s1,856(sp)
   10344:	35213823          	sd	s2,848(sp)
   10348:	35313423          	sd	s3,840(sp)
   1034c:	35413023          	sd	s4,832(sp)
   10350:	33513c23          	sd	s5,824(sp)
   10354:	33613823          	sd	s6,816(sp)
   10358:	33713423          	sd	s7,808(sp)
   1035c:	33813023          	sd	s8,800(sp)
   10360:	31913c23          	sd	s9,792(sp)
   10364:	31a13823          	sd	s10,784(sp)
   10368:	31b13423          	sd	s11,776(sp)
   1036c:	37010413          	addi	s0,sp,880
   10370:	d0a43423          	sd	a0,-760(s0)
   10374:	00058793          	mv	a5,a1
   10378:	d0f42223          	sw	a5,-764(s0)
   1037c:	d0843783          	ld	a5,-760(s0)
   10380:	0007c783          	lbu	a5,0(a5)
   10384:	00078713          	mv	a4,a5
   10388:	06500793          	li	a5,101
   1038c:	0af71863          	bne	a4,a5,1043c <parse_cmd+0x108>
   10390:	d0843783          	ld	a5,-760(s0)
   10394:	00178793          	addi	a5,a5,1
   10398:	0007c783          	lbu	a5,0(a5)
   1039c:	00078713          	mv	a4,a5
   103a0:	06300793          	li	a5,99
   103a4:	08f71c63          	bne	a4,a5,1043c <parse_cmd+0x108>
   103a8:	d0843783          	ld	a5,-760(s0)
   103ac:	00278793          	addi	a5,a5,2
   103b0:	0007c783          	lbu	a5,0(a5)
   103b4:	00078713          	mv	a4,a5
   103b8:	06800793          	li	a5,104
   103bc:	08f71063          	bne	a4,a5,1043c <parse_cmd+0x108>
   103c0:	d0843783          	ld	a5,-760(s0)
   103c4:	00378793          	addi	a5,a5,3
   103c8:	0007c783          	lbu	a5,0(a5)
   103cc:	00078713          	mv	a4,a5
   103d0:	06f00793          	li	a5,111
   103d4:	06f71463          	bne	a4,a5,1043c <parse_cmd+0x108>
   103d8:	d0843783          	ld	a5,-760(s0)
   103dc:	00478793          	addi	a5,a5,4
   103e0:	d0f43423          	sd	a5,-760(s0)
   103e4:	d0843503          	ld	a0,-760(s0)
   103e8:	e6dff0ef          	jal	10254 <get_string>
   103ec:	f6a43823          	sd	a0,-144(s0)
   103f0:	f7043503          	ld	a0,-144(s0)
   103f4:	7d4010ef          	jal	11bc8 <strlen>
   103f8:	00050793          	mv	a5,a0
   103fc:	d0f42223          	sw	a5,-764(s0)
   10400:	d0442783          	lw	a5,-764(s0)
   10404:	d0843703          	ld	a4,-760(s0)
   10408:	00f707b3          	add	a5,a4,a5
   1040c:	d0f43423          	sd	a5,-760(s0)
   10410:	d0442783          	lw	a5,-764(s0)
   10414:	00078613          	mv	a2,a5
   10418:	f7043583          	ld	a1,-144(s0)
   1041c:	00100513          	li	a0,1
   10420:	7fc010ef          	jal	11c1c <write>
   10424:	00100613          	li	a2,1
   10428:	00002597          	auipc	a1,0x2
   1042c:	b0058593          	addi	a1,a1,-1280 # 11f28 <lseek+0x78>
   10430:	00100513          	li	a0,1
   10434:	7e8010ef          	jal	11c1c <write>
   10438:	6240006f          	j	10a5c <parse_cmd+0x728>
   1043c:	d0843783          	ld	a5,-760(s0)
   10440:	0007c783          	lbu	a5,0(a5)
   10444:	00078713          	mv	a4,a5
   10448:	06300793          	li	a5,99
   1044c:	16f71663          	bne	a4,a5,105b8 <parse_cmd+0x284>
   10450:	d0843783          	ld	a5,-760(s0)
   10454:	00178793          	addi	a5,a5,1
   10458:	0007c783          	lbu	a5,0(a5)
   1045c:	00078713          	mv	a4,a5
   10460:	06100793          	li	a5,97
   10464:	14f71a63          	bne	a4,a5,105b8 <parse_cmd+0x284>
   10468:	d0843783          	ld	a5,-760(s0)
   1046c:	00278793          	addi	a5,a5,2
   10470:	0007c783          	lbu	a5,0(a5)
   10474:	00078713          	mv	a4,a5
   10478:	07400793          	li	a5,116
   1047c:	12f71e63          	bne	a4,a5,105b8 <parse_cmd+0x284>
   10480:	d0843783          	ld	a5,-760(s0)
   10484:	00378793          	addi	a5,a5,3
   10488:	00078513          	mv	a0,a5
   1048c:	d0dff0ef          	jal	10198 <get_param>
   10490:	f6a43423          	sd	a0,-152(s0)
   10494:	00100593          	li	a1,1
   10498:	f6843503          	ld	a0,-152(s0)
   1049c:	17d010ef          	jal	11e18 <open>
   104a0:	00050793          	mv	a5,a0
   104a4:	f6f42223          	sw	a5,-156(s0)
   104a8:	f6442783          	lw	a5,-156(s0)
   104ac:	0007871b          	sext.w	a4,a5
   104b0:	fff00793          	li	a5,-1
   104b4:	00f71c63          	bne	a4,a5,104cc <parse_cmd+0x198>
   104b8:	f6843583          	ld	a1,-152(s0)
   104bc:	00002517          	auipc	a0,0x2
   104c0:	a7450513          	addi	a0,a0,-1420 # 11f30 <lseek+0x80>
   104c4:	608010ef          	jal	11acc <printf>
   104c8:	5940006f          	j	10a5c <parse_cmd+0x728>
   104cc:	d1840713          	addi	a4,s0,-744
   104d0:	f6442783          	lw	a5,-156(s0)
   104d4:	1fd00613          	li	a2,509
   104d8:	00070593          	mv	a1,a4
   104dc:	00078513          	mv	a0,a5
   104e0:	061010ef          	jal	11d40 <read>
   104e4:	00050793          	mv	a5,a0
   104e8:	f6f42023          	sw	a5,-160(s0)
   104ec:	f6042783          	lw	a5,-160(s0)
   104f0:	0007879b          	sext.w	a5,a5
   104f4:	02079263          	bnez	a5,10518 <parse_cmd+0x1e4>
   104f8:	f8f44783          	lbu	a5,-113(s0)
   104fc:	0ff7f713          	zext.b	a4,a5
   10500:	00a00793          	li	a5,10
   10504:	0af70063          	beq	a4,a5,105a4 <parse_cmd+0x270>
   10508:	00002517          	auipc	a0,0x2
   1050c:	a4050513          	addi	a0,a0,-1472 # 11f48 <lseek+0x98>
   10510:	5bc010ef          	jal	11acc <printf>
   10514:	0900006f          	j	105a4 <parse_cmd+0x270>
   10518:	f8042423          	sw	zero,-120(s0)
   1051c:	06c0006f          	j	10588 <parse_cmd+0x254>
   10520:	f8842783          	lw	a5,-120(s0)
   10524:	f9078793          	addi	a5,a5,-112
   10528:	008787b3          	add	a5,a5,s0
   1052c:	d887c783          	lbu	a5,-632(a5)
   10530:	00079e63          	bnez	a5,1054c <parse_cmd+0x218>
   10534:	00100613          	li	a2,1
   10538:	00002597          	auipc	a1,0x2
   1053c:	a1858593          	addi	a1,a1,-1512 # 11f50 <lseek+0xa0>
   10540:	00100513          	li	a0,1
   10544:	6d8010ef          	jal	11c1c <write>
   10548:	0200006f          	j	10568 <parse_cmd+0x234>
   1054c:	d1840713          	addi	a4,s0,-744
   10550:	f8842783          	lw	a5,-120(s0)
   10554:	00f707b3          	add	a5,a4,a5
   10558:	00100613          	li	a2,1
   1055c:	00078593          	mv	a1,a5
   10560:	00100513          	li	a0,1
   10564:	6b8010ef          	jal	11c1c <write>
   10568:	f8842783          	lw	a5,-120(s0)
   1056c:	f9078793          	addi	a5,a5,-112
   10570:	008787b3          	add	a5,a5,s0
   10574:	d887c783          	lbu	a5,-632(a5)
   10578:	f8f407a3          	sb	a5,-113(s0)
   1057c:	f8842783          	lw	a5,-120(s0)
   10580:	0017879b          	addiw	a5,a5,1
   10584:	f8f42423          	sw	a5,-120(s0)
   10588:	f8842783          	lw	a5,-120(s0)
   1058c:	00078713          	mv	a4,a5
   10590:	f6042783          	lw	a5,-160(s0)
   10594:	0007071b          	sext.w	a4,a4
   10598:	0007879b          	sext.w	a5,a5
   1059c:	f8f742e3          	blt	a4,a5,10520 <parse_cmd+0x1ec>
   105a0:	f2dff06f          	j	104cc <parse_cmd+0x198>
   105a4:	00000013          	nop
   105a8:	f6442783          	lw	a5,-156(s0)
   105ac:	00078513          	mv	a0,a5
   105b0:	0b1010ef          	jal	11e60 <close>
   105b4:	4a80006f          	j	10a5c <parse_cmd+0x728>
   105b8:	d0843783          	ld	a5,-760(s0)
   105bc:	0007c783          	lbu	a5,0(a5)
   105c0:	00078713          	mv	a4,a5
   105c4:	06500793          	li	a5,101
   105c8:	48f71263          	bne	a4,a5,10a4c <parse_cmd+0x718>
   105cc:	d0843783          	ld	a5,-760(s0)
   105d0:	00178793          	addi	a5,a5,1
   105d4:	0007c783          	lbu	a5,0(a5)
   105d8:	00078713          	mv	a4,a5
   105dc:	06400793          	li	a5,100
   105e0:	46f71663          	bne	a4,a5,10a4c <parse_cmd+0x718>
   105e4:	d0843783          	ld	a5,-760(s0)
   105e8:	00278793          	addi	a5,a5,2
   105ec:	0007c783          	lbu	a5,0(a5)
   105f0:	00078713          	mv	a4,a5
   105f4:	06900793          	li	a5,105
   105f8:	44f71a63          	bne	a4,a5,10a4c <parse_cmd+0x718>
   105fc:	d0843783          	ld	a5,-760(s0)
   10600:	00378793          	addi	a5,a5,3
   10604:	0007c783          	lbu	a5,0(a5)
   10608:	00078713          	mv	a4,a5
   1060c:	07400793          	li	a5,116
   10610:	42f71e63          	bne	a4,a5,10a4c <parse_cmd+0x718>
   10614:	00010793          	mv	a5,sp
   10618:	00078493          	mv	s1,a5
   1061c:	d0843783          	ld	a5,-760(s0)
   10620:	00478793          	addi	a5,a5,4
   10624:	d0f43423          	sd	a5,-760(s0)
   10628:	0100006f          	j	10638 <parse_cmd+0x304>
   1062c:	d0843783          	ld	a5,-760(s0)
   10630:	00178793          	addi	a5,a5,1
   10634:	d0f43423          	sd	a5,-760(s0)
   10638:	d0843783          	ld	a5,-760(s0)
   1063c:	0007c783          	lbu	a5,0(a5)
   10640:	00078713          	mv	a4,a5
   10644:	02000793          	li	a5,32
   10648:	00f71863          	bne	a4,a5,10658 <parse_cmd+0x324>
   1064c:	d0843783          	ld	a5,-760(s0)
   10650:	0007c783          	lbu	a5,0(a5)
   10654:	fc079ce3          	bnez	a5,1062c <parse_cmd+0x2f8>
   10658:	d0843503          	ld	a0,-760(s0)
   1065c:	b3dff0ef          	jal	10198 <get_param>
   10660:	f4a43c23          	sd	a0,-168(s0)
   10664:	f5843503          	ld	a0,-168(s0)
   10668:	560010ef          	jal	11bc8 <strlen>
   1066c:	00050793          	mv	a5,a0
   10670:	f4f42a23          	sw	a5,-172(s0)
   10674:	f5442783          	lw	a5,-172(s0)
   10678:	0017879b          	addiw	a5,a5,1
   1067c:	0007871b          	sext.w	a4,a5
   10680:	00070793          	mv	a5,a4
   10684:	fff78793          	addi	a5,a5,-1
   10688:	f4f43423          	sd	a5,-184(s0)
   1068c:	00070793          	mv	a5,a4
   10690:	cef43823          	sd	a5,-784(s0)
   10694:	ce043c23          	sd	zero,-776(s0)
   10698:	cf043783          	ld	a5,-784(s0)
   1069c:	03d7d793          	srli	a5,a5,0x3d
   106a0:	cf843683          	ld	a3,-776(s0)
   106a4:	00369693          	slli	a3,a3,0x3
   106a8:	c8d43c23          	sd	a3,-872(s0)
   106ac:	c9843683          	ld	a3,-872(s0)
   106b0:	00d7e7b3          	or	a5,a5,a3
   106b4:	c8f43c23          	sd	a5,-872(s0)
   106b8:	cf043783          	ld	a5,-784(s0)
   106bc:	00379793          	slli	a5,a5,0x3
   106c0:	c8f43823          	sd	a5,-880(s0)
   106c4:	00070793          	mv	a5,a4
   106c8:	cef43023          	sd	a5,-800(s0)
   106cc:	ce043423          	sd	zero,-792(s0)
   106d0:	ce043783          	ld	a5,-800(s0)
   106d4:	03d7d793          	srli	a5,a5,0x3d
   106d8:	ce843683          	ld	a3,-792(s0)
   106dc:	00369d93          	slli	s11,a3,0x3
   106e0:	01b7edb3          	or	s11,a5,s11
   106e4:	ce043783          	ld	a5,-800(s0)
   106e8:	00379d13          	slli	s10,a5,0x3
   106ec:	00070793          	mv	a5,a4
   106f0:	00f78793          	addi	a5,a5,15
   106f4:	0047d793          	srli	a5,a5,0x4
   106f8:	00479793          	slli	a5,a5,0x4
   106fc:	40f10133          	sub	sp,sp,a5
   10700:	00010793          	mv	a5,sp
   10704:	f4f43023          	sd	a5,-192(s0)
   10708:	f8042223          	sw	zero,-124(s0)
   1070c:	0300006f          	j	1073c <parse_cmd+0x408>
   10710:	f8442783          	lw	a5,-124(s0)
   10714:	f5843703          	ld	a4,-168(s0)
   10718:	00f707b3          	add	a5,a4,a5
   1071c:	0007c703          	lbu	a4,0(a5)
   10720:	f4043683          	ld	a3,-192(s0)
   10724:	f8442783          	lw	a5,-124(s0)
   10728:	00f687b3          	add	a5,a3,a5
   1072c:	00e78023          	sb	a4,0(a5)
   10730:	f8442783          	lw	a5,-124(s0)
   10734:	0017879b          	addiw	a5,a5,1
   10738:	f8f42223          	sw	a5,-124(s0)
   1073c:	f8442783          	lw	a5,-124(s0)
   10740:	00078713          	mv	a4,a5
   10744:	f5442783          	lw	a5,-172(s0)
   10748:	0007071b          	sext.w	a4,a4
   1074c:	0007879b          	sext.w	a5,a5
   10750:	fcf740e3          	blt	a4,a5,10710 <parse_cmd+0x3dc>
   10754:	f4043703          	ld	a4,-192(s0)
   10758:	f5442783          	lw	a5,-172(s0)
   1075c:	00f707b3          	add	a5,a4,a5
   10760:	00078023          	sb	zero,0(a5)
   10764:	f5442783          	lw	a5,-172(s0)
   10768:	d0843703          	ld	a4,-760(s0)
   1076c:	00f707b3          	add	a5,a4,a5
   10770:	d0f43423          	sd	a5,-760(s0)
   10774:	0100006f          	j	10784 <parse_cmd+0x450>
   10778:	d0843783          	ld	a5,-760(s0)
   1077c:	00178793          	addi	a5,a5,1
   10780:	d0f43423          	sd	a5,-760(s0)
   10784:	d0843783          	ld	a5,-760(s0)
   10788:	0007c783          	lbu	a5,0(a5)
   1078c:	00078713          	mv	a4,a5
   10790:	02000793          	li	a5,32
   10794:	00f71863          	bne	a4,a5,107a4 <parse_cmd+0x470>
   10798:	d0843783          	ld	a5,-760(s0)
   1079c:	0007c783          	lbu	a5,0(a5)
   107a0:	fc079ce3          	bnez	a5,10778 <parse_cmd+0x444>
   107a4:	d0843503          	ld	a0,-760(s0)
   107a8:	9f1ff0ef          	jal	10198 <get_param>
   107ac:	f4a43c23          	sd	a0,-168(s0)
   107b0:	f5843503          	ld	a0,-168(s0)
   107b4:	414010ef          	jal	11bc8 <strlen>
   107b8:	00050793          	mv	a5,a0
   107bc:	f4f42a23          	sw	a5,-172(s0)
   107c0:	f5442783          	lw	a5,-172(s0)
   107c4:	0017879b          	addiw	a5,a5,1
   107c8:	0007879b          	sext.w	a5,a5
   107cc:	00078713          	mv	a4,a5
   107d0:	fff70713          	addi	a4,a4,-1
   107d4:	f2e43c23          	sd	a4,-200(s0)
   107d8:	00078713          	mv	a4,a5
   107dc:	cce43823          	sd	a4,-816(s0)
   107e0:	cc043c23          	sd	zero,-808(s0)
   107e4:	cd043703          	ld	a4,-816(s0)
   107e8:	03d75713          	srli	a4,a4,0x3d
   107ec:	cd843683          	ld	a3,-808(s0)
   107f0:	00369c93          	slli	s9,a3,0x3
   107f4:	01976cb3          	or	s9,a4,s9
   107f8:	cd043703          	ld	a4,-816(s0)
   107fc:	00371c13          	slli	s8,a4,0x3
   10800:	00078713          	mv	a4,a5
   10804:	cce43023          	sd	a4,-832(s0)
   10808:	cc043423          	sd	zero,-824(s0)
   1080c:	cc043703          	ld	a4,-832(s0)
   10810:	03d75713          	srli	a4,a4,0x3d
   10814:	cc843683          	ld	a3,-824(s0)
   10818:	00369b93          	slli	s7,a3,0x3
   1081c:	01776bb3          	or	s7,a4,s7
   10820:	cc043703          	ld	a4,-832(s0)
   10824:	00371b13          	slli	s6,a4,0x3
   10828:	00f78793          	addi	a5,a5,15
   1082c:	0047d793          	srli	a5,a5,0x4
   10830:	00479793          	slli	a5,a5,0x4
   10834:	40f10133          	sub	sp,sp,a5
   10838:	00010793          	mv	a5,sp
   1083c:	f2f43823          	sd	a5,-208(s0)
   10840:	f8042023          	sw	zero,-128(s0)
   10844:	0300006f          	j	10874 <parse_cmd+0x540>
   10848:	f8042783          	lw	a5,-128(s0)
   1084c:	f5843703          	ld	a4,-168(s0)
   10850:	00f707b3          	add	a5,a4,a5
   10854:	0007c703          	lbu	a4,0(a5)
   10858:	f3043683          	ld	a3,-208(s0)
   1085c:	f8042783          	lw	a5,-128(s0)
   10860:	00f687b3          	add	a5,a3,a5
   10864:	00e78023          	sb	a4,0(a5)
   10868:	f8042783          	lw	a5,-128(s0)
   1086c:	0017879b          	addiw	a5,a5,1
   10870:	f8f42023          	sw	a5,-128(s0)
   10874:	f8042783          	lw	a5,-128(s0)
   10878:	00078713          	mv	a4,a5
   1087c:	f5442783          	lw	a5,-172(s0)
   10880:	0007071b          	sext.w	a4,a4
   10884:	0007879b          	sext.w	a5,a5
   10888:	fcf740e3          	blt	a4,a5,10848 <parse_cmd+0x514>
   1088c:	f3043703          	ld	a4,-208(s0)
   10890:	f5442783          	lw	a5,-172(s0)
   10894:	00f707b3          	add	a5,a4,a5
   10898:	00078023          	sb	zero,0(a5)
   1089c:	f5442783          	lw	a5,-172(s0)
   108a0:	d0843703          	ld	a4,-760(s0)
   108a4:	00f707b3          	add	a5,a4,a5
   108a8:	d0f43423          	sd	a5,-760(s0)
   108ac:	0100006f          	j	108bc <parse_cmd+0x588>
   108b0:	d0843783          	ld	a5,-760(s0)
   108b4:	00178793          	addi	a5,a5,1
   108b8:	d0f43423          	sd	a5,-760(s0)
   108bc:	d0843783          	ld	a5,-760(s0)
   108c0:	0007c783          	lbu	a5,0(a5)
   108c4:	00078713          	mv	a4,a5
   108c8:	02000793          	li	a5,32
   108cc:	00f71863          	bne	a4,a5,108dc <parse_cmd+0x5a8>
   108d0:	d0843783          	ld	a5,-760(s0)
   108d4:	0007c783          	lbu	a5,0(a5)
   108d8:	fc079ce3          	bnez	a5,108b0 <parse_cmd+0x57c>
   108dc:	d0843503          	ld	a0,-760(s0)
   108e0:	975ff0ef          	jal	10254 <get_string>
   108e4:	f4a43c23          	sd	a0,-168(s0)
   108e8:	f5843503          	ld	a0,-168(s0)
   108ec:	2dc010ef          	jal	11bc8 <strlen>
   108f0:	00050793          	mv	a5,a0
   108f4:	f4f42a23          	sw	a5,-172(s0)
   108f8:	f5442783          	lw	a5,-172(s0)
   108fc:	0017879b          	addiw	a5,a5,1
   10900:	0007879b          	sext.w	a5,a5
   10904:	00078713          	mv	a4,a5
   10908:	fff70713          	addi	a4,a4,-1
   1090c:	f2e43423          	sd	a4,-216(s0)
   10910:	00078713          	mv	a4,a5
   10914:	cae43823          	sd	a4,-848(s0)
   10918:	ca043c23          	sd	zero,-840(s0)
   1091c:	cb043703          	ld	a4,-848(s0)
   10920:	03d75713          	srli	a4,a4,0x3d
   10924:	cb843683          	ld	a3,-840(s0)
   10928:	00369a93          	slli	s5,a3,0x3
   1092c:	01576ab3          	or	s5,a4,s5
   10930:	cb043703          	ld	a4,-848(s0)
   10934:	00371a13          	slli	s4,a4,0x3
   10938:	00078713          	mv	a4,a5
   1093c:	cae43023          	sd	a4,-864(s0)
   10940:	ca043423          	sd	zero,-856(s0)
   10944:	ca043703          	ld	a4,-864(s0)
   10948:	03d75713          	srli	a4,a4,0x3d
   1094c:	ca843683          	ld	a3,-856(s0)
   10950:	00369993          	slli	s3,a3,0x3
   10954:	013769b3          	or	s3,a4,s3
   10958:	ca043703          	ld	a4,-864(s0)
   1095c:	00371913          	slli	s2,a4,0x3
   10960:	00f78793          	addi	a5,a5,15
   10964:	0047d793          	srli	a5,a5,0x4
   10968:	00479793          	slli	a5,a5,0x4
   1096c:	40f10133          	sub	sp,sp,a5
   10970:	00010793          	mv	a5,sp
   10974:	f2f43023          	sd	a5,-224(s0)
   10978:	f6042e23          	sw	zero,-132(s0)
   1097c:	0300006f          	j	109ac <parse_cmd+0x678>
   10980:	f7c42783          	lw	a5,-132(s0)
   10984:	f5843703          	ld	a4,-168(s0)
   10988:	00f707b3          	add	a5,a4,a5
   1098c:	0007c703          	lbu	a4,0(a5)
   10990:	f2043683          	ld	a3,-224(s0)
   10994:	f7c42783          	lw	a5,-132(s0)
   10998:	00f687b3          	add	a5,a3,a5
   1099c:	00e78023          	sb	a4,0(a5)
   109a0:	f7c42783          	lw	a5,-132(s0)
   109a4:	0017879b          	addiw	a5,a5,1
   109a8:	f6f42e23          	sw	a5,-132(s0)
   109ac:	f7c42783          	lw	a5,-132(s0)
   109b0:	00078713          	mv	a4,a5
   109b4:	f5442783          	lw	a5,-172(s0)
   109b8:	0007071b          	sext.w	a4,a4
   109bc:	0007879b          	sext.w	a5,a5
   109c0:	fcf740e3          	blt	a4,a5,10980 <parse_cmd+0x64c>
   109c4:	f2043703          	ld	a4,-224(s0)
   109c8:	f5442783          	lw	a5,-172(s0)
   109cc:	00f707b3          	add	a5,a4,a5
   109d0:	00078023          	sb	zero,0(a5)
   109d4:	f5442783          	lw	a5,-172(s0)
   109d8:	d0843703          	ld	a4,-760(s0)
   109dc:	00f707b3          	add	a5,a4,a5
   109e0:	d0f43423          	sd	a5,-760(s0)
   109e4:	f3043503          	ld	a0,-208(s0)
   109e8:	f04ff0ef          	jal	100ec <atoi>
   109ec:	00050793          	mv	a5,a0
   109f0:	f0f42e23          	sw	a5,-228(s0)
   109f4:	00300593          	li	a1,3
   109f8:	f4043503          	ld	a0,-192(s0)
   109fc:	41c010ef          	jal	11e18 <open>
   10a00:	00050793          	mv	a5,a0
   10a04:	f0f42c23          	sw	a5,-232(s0)
   10a08:	f1c42703          	lw	a4,-228(s0)
   10a0c:	f1842783          	lw	a5,-232(s0)
   10a10:	00000613          	li	a2,0
   10a14:	00070593          	mv	a1,a4
   10a18:	00078513          	mv	a0,a5
   10a1c:	494010ef          	jal	11eb0 <lseek>
   10a20:	f5442703          	lw	a4,-172(s0)
   10a24:	f1842783          	lw	a5,-232(s0)
   10a28:	00070613          	mv	a2,a4
   10a2c:	f2043583          	ld	a1,-224(s0)
   10a30:	00078513          	mv	a0,a5
   10a34:	1e8010ef          	jal	11c1c <write>
   10a38:	f1842783          	lw	a5,-232(s0)
   10a3c:	00078513          	mv	a0,a5
   10a40:	420010ef          	jal	11e60 <close>
   10a44:	00048113          	mv	sp,s1
   10a48:	0140006f          	j	10a5c <parse_cmd+0x728>
   10a4c:	d0843583          	ld	a1,-760(s0)
   10a50:	00001517          	auipc	a0,0x1
   10a54:	50850513          	addi	a0,a0,1288 # 11f58 <lseek+0xa8>
   10a58:	074010ef          	jal	11acc <printf>
   10a5c:	c9040113          	addi	sp,s0,-880
   10a60:	36813083          	ld	ra,872(sp)
   10a64:	36013403          	ld	s0,864(sp)
   10a68:	35813483          	ld	s1,856(sp)
   10a6c:	35013903          	ld	s2,848(sp)
   10a70:	34813983          	ld	s3,840(sp)
   10a74:	34013a03          	ld	s4,832(sp)
   10a78:	33813a83          	ld	s5,824(sp)
   10a7c:	33013b03          	ld	s6,816(sp)
   10a80:	32813b83          	ld	s7,808(sp)
   10a84:	32013c03          	ld	s8,800(sp)
   10a88:	31813c83          	ld	s9,792(sp)
   10a8c:	31013d03          	ld	s10,784(sp)
   10a90:	30813d83          	ld	s11,776(sp)
   10a94:	37010113          	addi	sp,sp,880
   10a98:	00008067          	ret

0000000000010a9c <main>:
   10a9c:	f6010113          	addi	sp,sp,-160
   10aa0:	08113c23          	sd	ra,152(sp)
   10aa4:	08813823          	sd	s0,144(sp)
   10aa8:	0a010413          	addi	s0,sp,160
   10aac:	00f00613          	li	a2,15
   10ab0:	00001597          	auipc	a1,0x1
   10ab4:	4c058593          	addi	a1,a1,1216 # 11f70 <lseek+0xc0>
   10ab8:	00100513          	li	a0,1
   10abc:	160010ef          	jal	11c1c <write>
   10ac0:	00f00613          	li	a2,15
   10ac4:	00001597          	auipc	a1,0x1
   10ac8:	4bc58593          	addi	a1,a1,1212 # 11f80 <lseek+0xd0>
   10acc:	00200513          	li	a0,2
   10ad0:	14c010ef          	jal	11c1c <write>
   10ad4:	fe042623          	sw	zero,-20(s0)
   10ad8:	00001517          	auipc	a0,0x1
   10adc:	4b850513          	addi	a0,a0,1208 # 11f90 <lseek+0xe0>
   10ae0:	7ed000ef          	jal	11acc <printf>
   10ae4:	fe840793          	addi	a5,s0,-24
   10ae8:	00100613          	li	a2,1
   10aec:	00078593          	mv	a1,a5
   10af0:	00000513          	li	a0,0
   10af4:	24c010ef          	jal	11d40 <read>
   10af8:	fe844783          	lbu	a5,-24(s0)
   10afc:	00078713          	mv	a4,a5
   10b00:	00d00793          	li	a5,13
   10b04:	00f71e63          	bne	a4,a5,10b20 <main+0x84>
   10b08:	00100613          	li	a2,1
   10b0c:	00001597          	auipc	a1,0x1
   10b10:	41c58593          	addi	a1,a1,1052 # 11f28 <lseek+0x78>
   10b14:	00100513          	li	a0,1
   10b18:	104010ef          	jal	11c1c <write>
   10b1c:	0440006f          	j	10b60 <main+0xc4>
   10b20:	fe844783          	lbu	a5,-24(s0)
   10b24:	00078713          	mv	a4,a5
   10b28:	07f00793          	li	a5,127
   10b2c:	02f71a63          	bne	a4,a5,10b60 <main+0xc4>
   10b30:	fec42783          	lw	a5,-20(s0)
   10b34:	0007879b          	sext.w	a5,a5
   10b38:	0af05263          	blez	a5,10bdc <main+0x140>
   10b3c:	00300613          	li	a2,3
   10b40:	00001597          	auipc	a1,0x1
   10b44:	46858593          	addi	a1,a1,1128 # 11fa8 <lseek+0xf8>
   10b48:	00100513          	li	a0,1
   10b4c:	0d0010ef          	jal	11c1c <write>
   10b50:	fec42783          	lw	a5,-20(s0)
   10b54:	fff7879b          	addiw	a5,a5,-1
   10b58:	fef42623          	sw	a5,-20(s0)
   10b5c:	0800006f          	j	10bdc <main+0x140>
   10b60:	fe840793          	addi	a5,s0,-24
   10b64:	00100613          	li	a2,1
   10b68:	00078593          	mv	a1,a5
   10b6c:	00100513          	li	a0,1
   10b70:	0ac010ef          	jal	11c1c <write>
   10b74:	fe844783          	lbu	a5,-24(s0)
   10b78:	00078713          	mv	a4,a5
   10b7c:	00d00793          	li	a5,13
   10b80:	02f71e63          	bne	a4,a5,10bbc <main+0x120>
   10b84:	fec42783          	lw	a5,-20(s0)
   10b88:	ff078793          	addi	a5,a5,-16
   10b8c:	008787b3          	add	a5,a5,s0
   10b90:	f6078c23          	sb	zero,-136(a5)
   10b94:	fec42703          	lw	a4,-20(s0)
   10b98:	f6840793          	addi	a5,s0,-152
   10b9c:	00070593          	mv	a1,a4
   10ba0:	00078513          	mv	a0,a5
   10ba4:	f90ff0ef          	jal	10334 <parse_cmd>
   10ba8:	fe042623          	sw	zero,-20(s0)
   10bac:	00001517          	auipc	a0,0x1
   10bb0:	3e450513          	addi	a0,a0,996 # 11f90 <lseek+0xe0>
   10bb4:	719000ef          	jal	11acc <printf>
   10bb8:	f2dff06f          	j	10ae4 <main+0x48>
   10bbc:	fec42783          	lw	a5,-20(s0)
   10bc0:	0017871b          	addiw	a4,a5,1
   10bc4:	fee42623          	sw	a4,-20(s0)
   10bc8:	fe844703          	lbu	a4,-24(s0)
   10bcc:	ff078793          	addi	a5,a5,-16
   10bd0:	008787b3          	add	a5,a5,s0
   10bd4:	f6e78c23          	sb	a4,-136(a5)
   10bd8:	f0dff06f          	j	10ae4 <main+0x48>
   10bdc:	00000013          	nop
   10be0:	f05ff06f          	j	10ae4 <main+0x48>

0000000000010be4 <putc>:
   10be4:	fe010113          	addi	sp,sp,-32
   10be8:	00113c23          	sd	ra,24(sp)
   10bec:	00813823          	sd	s0,16(sp)
   10bf0:	02010413          	addi	s0,sp,32
   10bf4:	00050793          	mv	a5,a0
   10bf8:	fef42623          	sw	a5,-20(s0)
   10bfc:	00003797          	auipc	a5,0x3
   10c00:	40478793          	addi	a5,a5,1028 # 14000 <tail>
   10c04:	0007a783          	lw	a5,0(a5)
   10c08:	0017871b          	addiw	a4,a5,1
   10c0c:	0007069b          	sext.w	a3,a4
   10c10:	00003717          	auipc	a4,0x3
   10c14:	3f070713          	addi	a4,a4,1008 # 14000 <tail>
   10c18:	00d72023          	sw	a3,0(a4)
   10c1c:	fec42703          	lw	a4,-20(s0)
   10c20:	0ff77713          	zext.b	a4,a4
   10c24:	00003697          	auipc	a3,0x3
   10c28:	3e468693          	addi	a3,a3,996 # 14008 <buffer>
   10c2c:	00f687b3          	add	a5,a3,a5
   10c30:	00e78023          	sb	a4,0(a5)
   10c34:	fec42783          	lw	a5,-20(s0)
   10c38:	0ff7f793          	zext.b	a5,a5
   10c3c:	0007879b          	sext.w	a5,a5
   10c40:	00078513          	mv	a0,a5
   10c44:	01813083          	ld	ra,24(sp)
   10c48:	01013403          	ld	s0,16(sp)
   10c4c:	02010113          	addi	sp,sp,32
   10c50:	00008067          	ret

0000000000010c54 <isspace>:
   10c54:	fe010113          	addi	sp,sp,-32
   10c58:	00113c23          	sd	ra,24(sp)
   10c5c:	00813823          	sd	s0,16(sp)
   10c60:	02010413          	addi	s0,sp,32
   10c64:	00050793          	mv	a5,a0
   10c68:	fef42623          	sw	a5,-20(s0)
   10c6c:	fec42783          	lw	a5,-20(s0)
   10c70:	0007871b          	sext.w	a4,a5
   10c74:	02000793          	li	a5,32
   10c78:	02f70263          	beq	a4,a5,10c9c <isspace+0x48>
   10c7c:	fec42783          	lw	a5,-20(s0)
   10c80:	0007871b          	sext.w	a4,a5
   10c84:	00800793          	li	a5,8
   10c88:	00e7de63          	bge	a5,a4,10ca4 <isspace+0x50>
   10c8c:	fec42783          	lw	a5,-20(s0)
   10c90:	0007871b          	sext.w	a4,a5
   10c94:	00d00793          	li	a5,13
   10c98:	00e7c663          	blt	a5,a4,10ca4 <isspace+0x50>
   10c9c:	00100793          	li	a5,1
   10ca0:	0080006f          	j	10ca8 <isspace+0x54>
   10ca4:	00000793          	li	a5,0
   10ca8:	00078513          	mv	a0,a5
   10cac:	01813083          	ld	ra,24(sp)
   10cb0:	01013403          	ld	s0,16(sp)
   10cb4:	02010113          	addi	sp,sp,32
   10cb8:	00008067          	ret

0000000000010cbc <strtol>:
   10cbc:	fb010113          	addi	sp,sp,-80
   10cc0:	04113423          	sd	ra,72(sp)
   10cc4:	04813023          	sd	s0,64(sp)
   10cc8:	05010413          	addi	s0,sp,80
   10ccc:	fca43423          	sd	a0,-56(s0)
   10cd0:	fcb43023          	sd	a1,-64(s0)
   10cd4:	00060793          	mv	a5,a2
   10cd8:	faf42e23          	sw	a5,-68(s0)
   10cdc:	fe043423          	sd	zero,-24(s0)
   10ce0:	fe0403a3          	sb	zero,-25(s0)
   10ce4:	fc843783          	ld	a5,-56(s0)
   10ce8:	fcf43c23          	sd	a5,-40(s0)
   10cec:	0100006f          	j	10cfc <strtol+0x40>
   10cf0:	fd843783          	ld	a5,-40(s0)
   10cf4:	00178793          	addi	a5,a5,1
   10cf8:	fcf43c23          	sd	a5,-40(s0)
   10cfc:	fd843783          	ld	a5,-40(s0)
   10d00:	0007c783          	lbu	a5,0(a5)
   10d04:	0007879b          	sext.w	a5,a5
   10d08:	00078513          	mv	a0,a5
   10d0c:	f49ff0ef          	jal	10c54 <isspace>
   10d10:	00050793          	mv	a5,a0
   10d14:	fc079ee3          	bnez	a5,10cf0 <strtol+0x34>
   10d18:	fd843783          	ld	a5,-40(s0)
   10d1c:	0007c783          	lbu	a5,0(a5)
   10d20:	00078713          	mv	a4,a5
   10d24:	02d00793          	li	a5,45
   10d28:	00f71e63          	bne	a4,a5,10d44 <strtol+0x88>
   10d2c:	00100793          	li	a5,1
   10d30:	fef403a3          	sb	a5,-25(s0)
   10d34:	fd843783          	ld	a5,-40(s0)
   10d38:	00178793          	addi	a5,a5,1
   10d3c:	fcf43c23          	sd	a5,-40(s0)
   10d40:	0240006f          	j	10d64 <strtol+0xa8>
   10d44:	fd843783          	ld	a5,-40(s0)
   10d48:	0007c783          	lbu	a5,0(a5)
   10d4c:	00078713          	mv	a4,a5
   10d50:	02b00793          	li	a5,43
   10d54:	00f71863          	bne	a4,a5,10d64 <strtol+0xa8>
   10d58:	fd843783          	ld	a5,-40(s0)
   10d5c:	00178793          	addi	a5,a5,1
   10d60:	fcf43c23          	sd	a5,-40(s0)
   10d64:	fbc42783          	lw	a5,-68(s0)
   10d68:	0007879b          	sext.w	a5,a5
   10d6c:	06079c63          	bnez	a5,10de4 <strtol+0x128>
   10d70:	fd843783          	ld	a5,-40(s0)
   10d74:	0007c783          	lbu	a5,0(a5)
   10d78:	00078713          	mv	a4,a5
   10d7c:	03000793          	li	a5,48
   10d80:	04f71e63          	bne	a4,a5,10ddc <strtol+0x120>
   10d84:	fd843783          	ld	a5,-40(s0)
   10d88:	00178793          	addi	a5,a5,1
   10d8c:	fcf43c23          	sd	a5,-40(s0)
   10d90:	fd843783          	ld	a5,-40(s0)
   10d94:	0007c783          	lbu	a5,0(a5)
   10d98:	00078713          	mv	a4,a5
   10d9c:	07800793          	li	a5,120
   10da0:	00f70c63          	beq	a4,a5,10db8 <strtol+0xfc>
   10da4:	fd843783          	ld	a5,-40(s0)
   10da8:	0007c783          	lbu	a5,0(a5)
   10dac:	00078713          	mv	a4,a5
   10db0:	05800793          	li	a5,88
   10db4:	00f71e63          	bne	a4,a5,10dd0 <strtol+0x114>
   10db8:	01000793          	li	a5,16
   10dbc:	faf42e23          	sw	a5,-68(s0)
   10dc0:	fd843783          	ld	a5,-40(s0)
   10dc4:	00178793          	addi	a5,a5,1
   10dc8:	fcf43c23          	sd	a5,-40(s0)
   10dcc:	0180006f          	j	10de4 <strtol+0x128>
   10dd0:	00800793          	li	a5,8
   10dd4:	faf42e23          	sw	a5,-68(s0)
   10dd8:	00c0006f          	j	10de4 <strtol+0x128>
   10ddc:	00a00793          	li	a5,10
   10de0:	faf42e23          	sw	a5,-68(s0)
   10de4:	fd843783          	ld	a5,-40(s0)
   10de8:	0007c783          	lbu	a5,0(a5)
   10dec:	00078713          	mv	a4,a5
   10df0:	02f00793          	li	a5,47
   10df4:	02e7f863          	bgeu	a5,a4,10e24 <strtol+0x168>
   10df8:	fd843783          	ld	a5,-40(s0)
   10dfc:	0007c783          	lbu	a5,0(a5)
   10e00:	00078713          	mv	a4,a5
   10e04:	03900793          	li	a5,57
   10e08:	00e7ee63          	bltu	a5,a4,10e24 <strtol+0x168>
   10e0c:	fd843783          	ld	a5,-40(s0)
   10e10:	0007c783          	lbu	a5,0(a5)
   10e14:	0007879b          	sext.w	a5,a5
   10e18:	fd07879b          	addiw	a5,a5,-48
   10e1c:	fcf42a23          	sw	a5,-44(s0)
   10e20:	0800006f          	j	10ea0 <strtol+0x1e4>
   10e24:	fd843783          	ld	a5,-40(s0)
   10e28:	0007c783          	lbu	a5,0(a5)
   10e2c:	00078713          	mv	a4,a5
   10e30:	06000793          	li	a5,96
   10e34:	02e7f863          	bgeu	a5,a4,10e64 <strtol+0x1a8>
   10e38:	fd843783          	ld	a5,-40(s0)
   10e3c:	0007c783          	lbu	a5,0(a5)
   10e40:	00078713          	mv	a4,a5
   10e44:	07a00793          	li	a5,122
   10e48:	00e7ee63          	bltu	a5,a4,10e64 <strtol+0x1a8>
   10e4c:	fd843783          	ld	a5,-40(s0)
   10e50:	0007c783          	lbu	a5,0(a5)
   10e54:	0007879b          	sext.w	a5,a5
   10e58:	fa97879b          	addiw	a5,a5,-87
   10e5c:	fcf42a23          	sw	a5,-44(s0)
   10e60:	0400006f          	j	10ea0 <strtol+0x1e4>
   10e64:	fd843783          	ld	a5,-40(s0)
   10e68:	0007c783          	lbu	a5,0(a5)
   10e6c:	00078713          	mv	a4,a5
   10e70:	04000793          	li	a5,64
   10e74:	06e7f863          	bgeu	a5,a4,10ee4 <strtol+0x228>
   10e78:	fd843783          	ld	a5,-40(s0)
   10e7c:	0007c783          	lbu	a5,0(a5)
   10e80:	00078713          	mv	a4,a5
   10e84:	05a00793          	li	a5,90
   10e88:	04e7ee63          	bltu	a5,a4,10ee4 <strtol+0x228>
   10e8c:	fd843783          	ld	a5,-40(s0)
   10e90:	0007c783          	lbu	a5,0(a5)
   10e94:	0007879b          	sext.w	a5,a5
   10e98:	fc97879b          	addiw	a5,a5,-55
   10e9c:	fcf42a23          	sw	a5,-44(s0)
   10ea0:	fd442783          	lw	a5,-44(s0)
   10ea4:	00078713          	mv	a4,a5
   10ea8:	fbc42783          	lw	a5,-68(s0)
   10eac:	0007071b          	sext.w	a4,a4
   10eb0:	0007879b          	sext.w	a5,a5
   10eb4:	02f75663          	bge	a4,a5,10ee0 <strtol+0x224>
   10eb8:	fbc42703          	lw	a4,-68(s0)
   10ebc:	fe843783          	ld	a5,-24(s0)
   10ec0:	02f70733          	mul	a4,a4,a5
   10ec4:	fd442783          	lw	a5,-44(s0)
   10ec8:	00f707b3          	add	a5,a4,a5
   10ecc:	fef43423          	sd	a5,-24(s0)
   10ed0:	fd843783          	ld	a5,-40(s0)
   10ed4:	00178793          	addi	a5,a5,1
   10ed8:	fcf43c23          	sd	a5,-40(s0)
   10edc:	f09ff06f          	j	10de4 <strtol+0x128>
   10ee0:	00000013          	nop
   10ee4:	fc043783          	ld	a5,-64(s0)
   10ee8:	00078863          	beqz	a5,10ef8 <strtol+0x23c>
   10eec:	fc043783          	ld	a5,-64(s0)
   10ef0:	fd843703          	ld	a4,-40(s0)
   10ef4:	00e7b023          	sd	a4,0(a5)
   10ef8:	fe744783          	lbu	a5,-25(s0)
   10efc:	0ff7f793          	zext.b	a5,a5
   10f00:	00078863          	beqz	a5,10f10 <strtol+0x254>
   10f04:	fe843783          	ld	a5,-24(s0)
   10f08:	40f007b3          	neg	a5,a5
   10f0c:	0080006f          	j	10f14 <strtol+0x258>
   10f10:	fe843783          	ld	a5,-24(s0)
   10f14:	00078513          	mv	a0,a5
   10f18:	04813083          	ld	ra,72(sp)
   10f1c:	04013403          	ld	s0,64(sp)
   10f20:	05010113          	addi	sp,sp,80
   10f24:	00008067          	ret

0000000000010f28 <puts_wo_nl>:
   10f28:	fd010113          	addi	sp,sp,-48
   10f2c:	02113423          	sd	ra,40(sp)
   10f30:	02813023          	sd	s0,32(sp)
   10f34:	03010413          	addi	s0,sp,48
   10f38:	fca43c23          	sd	a0,-40(s0)
   10f3c:	fcb43823          	sd	a1,-48(s0)
   10f40:	fd043783          	ld	a5,-48(s0)
   10f44:	00079863          	bnez	a5,10f54 <puts_wo_nl+0x2c>
   10f48:	00001797          	auipc	a5,0x1
   10f4c:	06878793          	addi	a5,a5,104 # 11fb0 <lseek+0x100>
   10f50:	fcf43823          	sd	a5,-48(s0)
   10f54:	fd043783          	ld	a5,-48(s0)
   10f58:	fef43423          	sd	a5,-24(s0)
   10f5c:	0240006f          	j	10f80 <puts_wo_nl+0x58>
   10f60:	fe843783          	ld	a5,-24(s0)
   10f64:	00178713          	addi	a4,a5,1
   10f68:	fee43423          	sd	a4,-24(s0)
   10f6c:	0007c783          	lbu	a5,0(a5)
   10f70:	0007871b          	sext.w	a4,a5
   10f74:	fd843783          	ld	a5,-40(s0)
   10f78:	00070513          	mv	a0,a4
   10f7c:	000780e7          	jalr	a5
   10f80:	fe843783          	ld	a5,-24(s0)
   10f84:	0007c783          	lbu	a5,0(a5)
   10f88:	fc079ce3          	bnez	a5,10f60 <puts_wo_nl+0x38>
   10f8c:	fe843703          	ld	a4,-24(s0)
   10f90:	fd043783          	ld	a5,-48(s0)
   10f94:	40f707b3          	sub	a5,a4,a5
   10f98:	0007879b          	sext.w	a5,a5
   10f9c:	00078513          	mv	a0,a5
   10fa0:	02813083          	ld	ra,40(sp)
   10fa4:	02013403          	ld	s0,32(sp)
   10fa8:	03010113          	addi	sp,sp,48
   10fac:	00008067          	ret

0000000000010fb0 <print_dec_int>:
   10fb0:	f9010113          	addi	sp,sp,-112
   10fb4:	06113423          	sd	ra,104(sp)
   10fb8:	06813023          	sd	s0,96(sp)
   10fbc:	07010413          	addi	s0,sp,112
   10fc0:	faa43423          	sd	a0,-88(s0)
   10fc4:	fab43023          	sd	a1,-96(s0)
   10fc8:	00060793          	mv	a5,a2
   10fcc:	f8d43823          	sd	a3,-112(s0)
   10fd0:	f8f40fa3          	sb	a5,-97(s0)
   10fd4:	f9f44783          	lbu	a5,-97(s0)
   10fd8:	0ff7f793          	zext.b	a5,a5
   10fdc:	02078663          	beqz	a5,11008 <print_dec_int+0x58>
   10fe0:	fa043703          	ld	a4,-96(s0)
   10fe4:	fff00793          	li	a5,-1
   10fe8:	03f79793          	slli	a5,a5,0x3f
   10fec:	00f71e63          	bne	a4,a5,11008 <print_dec_int+0x58>
   10ff0:	00001597          	auipc	a1,0x1
   10ff4:	fc858593          	addi	a1,a1,-56 # 11fb8 <lseek+0x108>
   10ff8:	fa843503          	ld	a0,-88(s0)
   10ffc:	f2dff0ef          	jal	10f28 <puts_wo_nl>
   11000:	00050793          	mv	a5,a0
   11004:	2c80006f          	j	112cc <print_dec_int+0x31c>
   11008:	f9043783          	ld	a5,-112(s0)
   1100c:	00c7a783          	lw	a5,12(a5)
   11010:	00079a63          	bnez	a5,11024 <print_dec_int+0x74>
   11014:	fa043783          	ld	a5,-96(s0)
   11018:	00079663          	bnez	a5,11024 <print_dec_int+0x74>
   1101c:	00000793          	li	a5,0
   11020:	2ac0006f          	j	112cc <print_dec_int+0x31c>
   11024:	fe0407a3          	sb	zero,-17(s0)
   11028:	f9f44783          	lbu	a5,-97(s0)
   1102c:	0ff7f793          	zext.b	a5,a5
   11030:	02078063          	beqz	a5,11050 <print_dec_int+0xa0>
   11034:	fa043783          	ld	a5,-96(s0)
   11038:	0007dc63          	bgez	a5,11050 <print_dec_int+0xa0>
   1103c:	00100793          	li	a5,1
   11040:	fef407a3          	sb	a5,-17(s0)
   11044:	fa043783          	ld	a5,-96(s0)
   11048:	40f007b3          	neg	a5,a5
   1104c:	faf43023          	sd	a5,-96(s0)
   11050:	fe042423          	sw	zero,-24(s0)
   11054:	f9f44783          	lbu	a5,-97(s0)
   11058:	0ff7f793          	zext.b	a5,a5
   1105c:	02078863          	beqz	a5,1108c <print_dec_int+0xdc>
   11060:	fef44783          	lbu	a5,-17(s0)
   11064:	0ff7f793          	zext.b	a5,a5
   11068:	00079e63          	bnez	a5,11084 <print_dec_int+0xd4>
   1106c:	f9043783          	ld	a5,-112(s0)
   11070:	0057c783          	lbu	a5,5(a5)
   11074:	00079863          	bnez	a5,11084 <print_dec_int+0xd4>
   11078:	f9043783          	ld	a5,-112(s0)
   1107c:	0047c783          	lbu	a5,4(a5)
   11080:	00078663          	beqz	a5,1108c <print_dec_int+0xdc>
   11084:	00100793          	li	a5,1
   11088:	0080006f          	j	11090 <print_dec_int+0xe0>
   1108c:	00000793          	li	a5,0
   11090:	fcf40ba3          	sb	a5,-41(s0)
   11094:	fd744783          	lbu	a5,-41(s0)
   11098:	0017f793          	andi	a5,a5,1
   1109c:	fcf40ba3          	sb	a5,-41(s0)
   110a0:	fa043683          	ld	a3,-96(s0)
   110a4:	00001797          	auipc	a5,0x1
   110a8:	f2c78793          	addi	a5,a5,-212 # 11fd0 <lseek+0x120>
   110ac:	0007b783          	ld	a5,0(a5)
   110b0:	02f6b7b3          	mulhu	a5,a3,a5
   110b4:	0037d713          	srli	a4,a5,0x3
   110b8:	00070793          	mv	a5,a4
   110bc:	00279793          	slli	a5,a5,0x2
   110c0:	00e787b3          	add	a5,a5,a4
   110c4:	00179793          	slli	a5,a5,0x1
   110c8:	40f68733          	sub	a4,a3,a5
   110cc:	0ff77713          	zext.b	a4,a4
   110d0:	fe842783          	lw	a5,-24(s0)
   110d4:	0017869b          	addiw	a3,a5,1
   110d8:	fed42423          	sw	a3,-24(s0)
   110dc:	0307071b          	addiw	a4,a4,48
   110e0:	0ff77713          	zext.b	a4,a4
   110e4:	ff078793          	addi	a5,a5,-16
   110e8:	008787b3          	add	a5,a5,s0
   110ec:	fce78423          	sb	a4,-56(a5)
   110f0:	fa043703          	ld	a4,-96(s0)
   110f4:	00001797          	auipc	a5,0x1
   110f8:	edc78793          	addi	a5,a5,-292 # 11fd0 <lseek+0x120>
   110fc:	0007b783          	ld	a5,0(a5)
   11100:	02f737b3          	mulhu	a5,a4,a5
   11104:	0037d793          	srli	a5,a5,0x3
   11108:	faf43023          	sd	a5,-96(s0)
   1110c:	fa043783          	ld	a5,-96(s0)
   11110:	f80798e3          	bnez	a5,110a0 <print_dec_int+0xf0>
   11114:	f9043783          	ld	a5,-112(s0)
   11118:	00c7a703          	lw	a4,12(a5)
   1111c:	fff00793          	li	a5,-1
   11120:	02f71063          	bne	a4,a5,11140 <print_dec_int+0x190>
   11124:	f9043783          	ld	a5,-112(s0)
   11128:	0037c783          	lbu	a5,3(a5)
   1112c:	00078a63          	beqz	a5,11140 <print_dec_int+0x190>
   11130:	f9043783          	ld	a5,-112(s0)
   11134:	0087a703          	lw	a4,8(a5)
   11138:	f9043783          	ld	a5,-112(s0)
   1113c:	00e7a623          	sw	a4,12(a5)
   11140:	fe042223          	sw	zero,-28(s0)
   11144:	f9043783          	ld	a5,-112(s0)
   11148:	0087a703          	lw	a4,8(a5)
   1114c:	fe842783          	lw	a5,-24(s0)
   11150:	fcf42823          	sw	a5,-48(s0)
   11154:	f9043783          	ld	a5,-112(s0)
   11158:	00c7a783          	lw	a5,12(a5)
   1115c:	fcf42623          	sw	a5,-52(s0)
   11160:	fd042783          	lw	a5,-48(s0)
   11164:	00078593          	mv	a1,a5
   11168:	fcc42783          	lw	a5,-52(s0)
   1116c:	00078613          	mv	a2,a5
   11170:	0006069b          	sext.w	a3,a2
   11174:	0005879b          	sext.w	a5,a1
   11178:	00f6d463          	bge	a3,a5,11180 <print_dec_int+0x1d0>
   1117c:	00058613          	mv	a2,a1
   11180:	0006079b          	sext.w	a5,a2
   11184:	40f707bb          	subw	a5,a4,a5
   11188:	0007871b          	sext.w	a4,a5
   1118c:	fd744783          	lbu	a5,-41(s0)
   11190:	0007879b          	sext.w	a5,a5
   11194:	40f707bb          	subw	a5,a4,a5
   11198:	fef42023          	sw	a5,-32(s0)
   1119c:	0280006f          	j	111c4 <print_dec_int+0x214>
   111a0:	fa843783          	ld	a5,-88(s0)
   111a4:	02000513          	li	a0,32
   111a8:	000780e7          	jalr	a5
   111ac:	fe442783          	lw	a5,-28(s0)
   111b0:	0017879b          	addiw	a5,a5,1
   111b4:	fef42223          	sw	a5,-28(s0)
   111b8:	fe042783          	lw	a5,-32(s0)
   111bc:	fff7879b          	addiw	a5,a5,-1
   111c0:	fef42023          	sw	a5,-32(s0)
   111c4:	fe042783          	lw	a5,-32(s0)
   111c8:	0007879b          	sext.w	a5,a5
   111cc:	fcf04ae3          	bgtz	a5,111a0 <print_dec_int+0x1f0>
   111d0:	fd744783          	lbu	a5,-41(s0)
   111d4:	0ff7f793          	zext.b	a5,a5
   111d8:	04078463          	beqz	a5,11220 <print_dec_int+0x270>
   111dc:	fef44783          	lbu	a5,-17(s0)
   111e0:	0ff7f793          	zext.b	a5,a5
   111e4:	00078663          	beqz	a5,111f0 <print_dec_int+0x240>
   111e8:	02d00793          	li	a5,45
   111ec:	01c0006f          	j	11208 <print_dec_int+0x258>
   111f0:	f9043783          	ld	a5,-112(s0)
   111f4:	0057c783          	lbu	a5,5(a5)
   111f8:	00078663          	beqz	a5,11204 <print_dec_int+0x254>
   111fc:	02b00793          	li	a5,43
   11200:	0080006f          	j	11208 <print_dec_int+0x258>
   11204:	02000793          	li	a5,32
   11208:	fa843703          	ld	a4,-88(s0)
   1120c:	00078513          	mv	a0,a5
   11210:	000700e7          	jalr	a4
   11214:	fe442783          	lw	a5,-28(s0)
   11218:	0017879b          	addiw	a5,a5,1
   1121c:	fef42223          	sw	a5,-28(s0)
   11220:	fe842783          	lw	a5,-24(s0)
   11224:	fcf42e23          	sw	a5,-36(s0)
   11228:	0280006f          	j	11250 <print_dec_int+0x2a0>
   1122c:	fa843783          	ld	a5,-88(s0)
   11230:	03000513          	li	a0,48
   11234:	000780e7          	jalr	a5
   11238:	fe442783          	lw	a5,-28(s0)
   1123c:	0017879b          	addiw	a5,a5,1
   11240:	fef42223          	sw	a5,-28(s0)
   11244:	fdc42783          	lw	a5,-36(s0)
   11248:	0017879b          	addiw	a5,a5,1
   1124c:	fcf42e23          	sw	a5,-36(s0)
   11250:	f9043783          	ld	a5,-112(s0)
   11254:	00c7a703          	lw	a4,12(a5)
   11258:	fd744783          	lbu	a5,-41(s0)
   1125c:	0007879b          	sext.w	a5,a5
   11260:	40f707bb          	subw	a5,a4,a5
   11264:	0007879b          	sext.w	a5,a5
   11268:	fdc42703          	lw	a4,-36(s0)
   1126c:	0007071b          	sext.w	a4,a4
   11270:	faf74ee3          	blt	a4,a5,1122c <print_dec_int+0x27c>
   11274:	fe842783          	lw	a5,-24(s0)
   11278:	fff7879b          	addiw	a5,a5,-1
   1127c:	fcf42c23          	sw	a5,-40(s0)
   11280:	03c0006f          	j	112bc <print_dec_int+0x30c>
   11284:	fd842783          	lw	a5,-40(s0)
   11288:	ff078793          	addi	a5,a5,-16
   1128c:	008787b3          	add	a5,a5,s0
   11290:	fc87c783          	lbu	a5,-56(a5)
   11294:	0007871b          	sext.w	a4,a5
   11298:	fa843783          	ld	a5,-88(s0)
   1129c:	00070513          	mv	a0,a4
   112a0:	000780e7          	jalr	a5
   112a4:	fe442783          	lw	a5,-28(s0)
   112a8:	0017879b          	addiw	a5,a5,1
   112ac:	fef42223          	sw	a5,-28(s0)
   112b0:	fd842783          	lw	a5,-40(s0)
   112b4:	fff7879b          	addiw	a5,a5,-1
   112b8:	fcf42c23          	sw	a5,-40(s0)
   112bc:	fd842783          	lw	a5,-40(s0)
   112c0:	0007879b          	sext.w	a5,a5
   112c4:	fc07d0e3          	bgez	a5,11284 <print_dec_int+0x2d4>
   112c8:	fe442783          	lw	a5,-28(s0)
   112cc:	00078513          	mv	a0,a5
   112d0:	06813083          	ld	ra,104(sp)
   112d4:	06013403          	ld	s0,96(sp)
   112d8:	07010113          	addi	sp,sp,112
   112dc:	00008067          	ret

00000000000112e0 <vprintfmt>:
   112e0:	f4010113          	addi	sp,sp,-192
   112e4:	0a113c23          	sd	ra,184(sp)
   112e8:	0a813823          	sd	s0,176(sp)
   112ec:	0c010413          	addi	s0,sp,192
   112f0:	f4a43c23          	sd	a0,-168(s0)
   112f4:	f4b43823          	sd	a1,-176(s0)
   112f8:	f4c43423          	sd	a2,-184(s0)
   112fc:	f8043023          	sd	zero,-128(s0)
   11300:	f8043423          	sd	zero,-120(s0)
   11304:	fe042623          	sw	zero,-20(s0)
   11308:	7a00006f          	j	11aa8 <vprintfmt+0x7c8>
   1130c:	f8044783          	lbu	a5,-128(s0)
   11310:	72078c63          	beqz	a5,11a48 <vprintfmt+0x768>
   11314:	f5043783          	ld	a5,-176(s0)
   11318:	0007c783          	lbu	a5,0(a5)
   1131c:	00078713          	mv	a4,a5
   11320:	02300793          	li	a5,35
   11324:	00f71863          	bne	a4,a5,11334 <vprintfmt+0x54>
   11328:	00100793          	li	a5,1
   1132c:	f8f40123          	sb	a5,-126(s0)
   11330:	76c0006f          	j	11a9c <vprintfmt+0x7bc>
   11334:	f5043783          	ld	a5,-176(s0)
   11338:	0007c783          	lbu	a5,0(a5)
   1133c:	00078713          	mv	a4,a5
   11340:	03000793          	li	a5,48
   11344:	00f71863          	bne	a4,a5,11354 <vprintfmt+0x74>
   11348:	00100793          	li	a5,1
   1134c:	f8f401a3          	sb	a5,-125(s0)
   11350:	74c0006f          	j	11a9c <vprintfmt+0x7bc>
   11354:	f5043783          	ld	a5,-176(s0)
   11358:	0007c783          	lbu	a5,0(a5)
   1135c:	00078713          	mv	a4,a5
   11360:	06c00793          	li	a5,108
   11364:	04f70063          	beq	a4,a5,113a4 <vprintfmt+0xc4>
   11368:	f5043783          	ld	a5,-176(s0)
   1136c:	0007c783          	lbu	a5,0(a5)
   11370:	00078713          	mv	a4,a5
   11374:	07a00793          	li	a5,122
   11378:	02f70663          	beq	a4,a5,113a4 <vprintfmt+0xc4>
   1137c:	f5043783          	ld	a5,-176(s0)
   11380:	0007c783          	lbu	a5,0(a5)
   11384:	00078713          	mv	a4,a5
   11388:	07400793          	li	a5,116
   1138c:	00f70c63          	beq	a4,a5,113a4 <vprintfmt+0xc4>
   11390:	f5043783          	ld	a5,-176(s0)
   11394:	0007c783          	lbu	a5,0(a5)
   11398:	00078713          	mv	a4,a5
   1139c:	06a00793          	li	a5,106
   113a0:	00f71863          	bne	a4,a5,113b0 <vprintfmt+0xd0>
   113a4:	00100793          	li	a5,1
   113a8:	f8f400a3          	sb	a5,-127(s0)
   113ac:	6f00006f          	j	11a9c <vprintfmt+0x7bc>
   113b0:	f5043783          	ld	a5,-176(s0)
   113b4:	0007c783          	lbu	a5,0(a5)
   113b8:	00078713          	mv	a4,a5
   113bc:	02b00793          	li	a5,43
   113c0:	00f71863          	bne	a4,a5,113d0 <vprintfmt+0xf0>
   113c4:	00100793          	li	a5,1
   113c8:	f8f402a3          	sb	a5,-123(s0)
   113cc:	6d00006f          	j	11a9c <vprintfmt+0x7bc>
   113d0:	f5043783          	ld	a5,-176(s0)
   113d4:	0007c783          	lbu	a5,0(a5)
   113d8:	00078713          	mv	a4,a5
   113dc:	02000793          	li	a5,32
   113e0:	00f71863          	bne	a4,a5,113f0 <vprintfmt+0x110>
   113e4:	00100793          	li	a5,1
   113e8:	f8f40223          	sb	a5,-124(s0)
   113ec:	6b00006f          	j	11a9c <vprintfmt+0x7bc>
   113f0:	f5043783          	ld	a5,-176(s0)
   113f4:	0007c783          	lbu	a5,0(a5)
   113f8:	00078713          	mv	a4,a5
   113fc:	02a00793          	li	a5,42
   11400:	00f71e63          	bne	a4,a5,1141c <vprintfmt+0x13c>
   11404:	f4843783          	ld	a5,-184(s0)
   11408:	00878713          	addi	a4,a5,8
   1140c:	f4e43423          	sd	a4,-184(s0)
   11410:	0007a783          	lw	a5,0(a5)
   11414:	f8f42423          	sw	a5,-120(s0)
   11418:	6840006f          	j	11a9c <vprintfmt+0x7bc>
   1141c:	f5043783          	ld	a5,-176(s0)
   11420:	0007c783          	lbu	a5,0(a5)
   11424:	00078713          	mv	a4,a5
   11428:	03000793          	li	a5,48
   1142c:	04e7f663          	bgeu	a5,a4,11478 <vprintfmt+0x198>
   11430:	f5043783          	ld	a5,-176(s0)
   11434:	0007c783          	lbu	a5,0(a5)
   11438:	00078713          	mv	a4,a5
   1143c:	03900793          	li	a5,57
   11440:	02e7ec63          	bltu	a5,a4,11478 <vprintfmt+0x198>
   11444:	f5043783          	ld	a5,-176(s0)
   11448:	f5040713          	addi	a4,s0,-176
   1144c:	00a00613          	li	a2,10
   11450:	00070593          	mv	a1,a4
   11454:	00078513          	mv	a0,a5
   11458:	865ff0ef          	jal	10cbc <strtol>
   1145c:	00050793          	mv	a5,a0
   11460:	0007879b          	sext.w	a5,a5
   11464:	f8f42423          	sw	a5,-120(s0)
   11468:	f5043783          	ld	a5,-176(s0)
   1146c:	fff78793          	addi	a5,a5,-1
   11470:	f4f43823          	sd	a5,-176(s0)
   11474:	6280006f          	j	11a9c <vprintfmt+0x7bc>
   11478:	f5043783          	ld	a5,-176(s0)
   1147c:	0007c783          	lbu	a5,0(a5)
   11480:	00078713          	mv	a4,a5
   11484:	02e00793          	li	a5,46
   11488:	06f71863          	bne	a4,a5,114f8 <vprintfmt+0x218>
   1148c:	f5043783          	ld	a5,-176(s0)
   11490:	00178793          	addi	a5,a5,1
   11494:	f4f43823          	sd	a5,-176(s0)
   11498:	f5043783          	ld	a5,-176(s0)
   1149c:	0007c783          	lbu	a5,0(a5)
   114a0:	00078713          	mv	a4,a5
   114a4:	02a00793          	li	a5,42
   114a8:	00f71e63          	bne	a4,a5,114c4 <vprintfmt+0x1e4>
   114ac:	f4843783          	ld	a5,-184(s0)
   114b0:	00878713          	addi	a4,a5,8
   114b4:	f4e43423          	sd	a4,-184(s0)
   114b8:	0007a783          	lw	a5,0(a5)
   114bc:	f8f42623          	sw	a5,-116(s0)
   114c0:	5dc0006f          	j	11a9c <vprintfmt+0x7bc>
   114c4:	f5043783          	ld	a5,-176(s0)
   114c8:	f5040713          	addi	a4,s0,-176
   114cc:	00a00613          	li	a2,10
   114d0:	00070593          	mv	a1,a4
   114d4:	00078513          	mv	a0,a5
   114d8:	fe4ff0ef          	jal	10cbc <strtol>
   114dc:	00050793          	mv	a5,a0
   114e0:	0007879b          	sext.w	a5,a5
   114e4:	f8f42623          	sw	a5,-116(s0)
   114e8:	f5043783          	ld	a5,-176(s0)
   114ec:	fff78793          	addi	a5,a5,-1
   114f0:	f4f43823          	sd	a5,-176(s0)
   114f4:	5a80006f          	j	11a9c <vprintfmt+0x7bc>
   114f8:	f5043783          	ld	a5,-176(s0)
   114fc:	0007c783          	lbu	a5,0(a5)
   11500:	00078713          	mv	a4,a5
   11504:	07800793          	li	a5,120
   11508:	02f70663          	beq	a4,a5,11534 <vprintfmt+0x254>
   1150c:	f5043783          	ld	a5,-176(s0)
   11510:	0007c783          	lbu	a5,0(a5)
   11514:	00078713          	mv	a4,a5
   11518:	05800793          	li	a5,88
   1151c:	00f70c63          	beq	a4,a5,11534 <vprintfmt+0x254>
   11520:	f5043783          	ld	a5,-176(s0)
   11524:	0007c783          	lbu	a5,0(a5)
   11528:	00078713          	mv	a4,a5
   1152c:	07000793          	li	a5,112
   11530:	30f71063          	bne	a4,a5,11830 <vprintfmt+0x550>
   11534:	f5043783          	ld	a5,-176(s0)
   11538:	0007c783          	lbu	a5,0(a5)
   1153c:	00078713          	mv	a4,a5
   11540:	07000793          	li	a5,112
   11544:	00f70663          	beq	a4,a5,11550 <vprintfmt+0x270>
   11548:	f8144783          	lbu	a5,-127(s0)
   1154c:	00078663          	beqz	a5,11558 <vprintfmt+0x278>
   11550:	00100793          	li	a5,1
   11554:	0080006f          	j	1155c <vprintfmt+0x27c>
   11558:	00000793          	li	a5,0
   1155c:	faf403a3          	sb	a5,-89(s0)
   11560:	fa744783          	lbu	a5,-89(s0)
   11564:	0017f793          	andi	a5,a5,1
   11568:	faf403a3          	sb	a5,-89(s0)
   1156c:	fa744783          	lbu	a5,-89(s0)
   11570:	0ff7f793          	zext.b	a5,a5
   11574:	00078c63          	beqz	a5,1158c <vprintfmt+0x2ac>
   11578:	f4843783          	ld	a5,-184(s0)
   1157c:	00878713          	addi	a4,a5,8
   11580:	f4e43423          	sd	a4,-184(s0)
   11584:	0007b783          	ld	a5,0(a5)
   11588:	01c0006f          	j	115a4 <vprintfmt+0x2c4>
   1158c:	f4843783          	ld	a5,-184(s0)
   11590:	00878713          	addi	a4,a5,8
   11594:	f4e43423          	sd	a4,-184(s0)
   11598:	0007a783          	lw	a5,0(a5)
   1159c:	02079793          	slli	a5,a5,0x20
   115a0:	0207d793          	srli	a5,a5,0x20
   115a4:	fef43023          	sd	a5,-32(s0)
   115a8:	f8c42783          	lw	a5,-116(s0)
   115ac:	02079463          	bnez	a5,115d4 <vprintfmt+0x2f4>
   115b0:	fe043783          	ld	a5,-32(s0)
   115b4:	02079063          	bnez	a5,115d4 <vprintfmt+0x2f4>
   115b8:	f5043783          	ld	a5,-176(s0)
   115bc:	0007c783          	lbu	a5,0(a5)
   115c0:	00078713          	mv	a4,a5
   115c4:	07000793          	li	a5,112
   115c8:	00f70663          	beq	a4,a5,115d4 <vprintfmt+0x2f4>
   115cc:	f8040023          	sb	zero,-128(s0)
   115d0:	4cc0006f          	j	11a9c <vprintfmt+0x7bc>
   115d4:	f5043783          	ld	a5,-176(s0)
   115d8:	0007c783          	lbu	a5,0(a5)
   115dc:	00078713          	mv	a4,a5
   115e0:	07000793          	li	a5,112
   115e4:	00f70a63          	beq	a4,a5,115f8 <vprintfmt+0x318>
   115e8:	f8244783          	lbu	a5,-126(s0)
   115ec:	00078a63          	beqz	a5,11600 <vprintfmt+0x320>
   115f0:	fe043783          	ld	a5,-32(s0)
   115f4:	00078663          	beqz	a5,11600 <vprintfmt+0x320>
   115f8:	00100793          	li	a5,1
   115fc:	0080006f          	j	11604 <vprintfmt+0x324>
   11600:	00000793          	li	a5,0
   11604:	faf40323          	sb	a5,-90(s0)
   11608:	fa644783          	lbu	a5,-90(s0)
   1160c:	0017f793          	andi	a5,a5,1
   11610:	faf40323          	sb	a5,-90(s0)
   11614:	fc042e23          	sw	zero,-36(s0)
   11618:	f5043783          	ld	a5,-176(s0)
   1161c:	0007c783          	lbu	a5,0(a5)
   11620:	00078713          	mv	a4,a5
   11624:	05800793          	li	a5,88
   11628:	00f71863          	bne	a4,a5,11638 <vprintfmt+0x358>
   1162c:	00001797          	auipc	a5,0x1
   11630:	9ac78793          	addi	a5,a5,-1620 # 11fd8 <upperxdigits.1>
   11634:	00c0006f          	j	11640 <vprintfmt+0x360>
   11638:	00001797          	auipc	a5,0x1
   1163c:	9b878793          	addi	a5,a5,-1608 # 11ff0 <lowerxdigits.0>
   11640:	f8f43c23          	sd	a5,-104(s0)
   11644:	fe043783          	ld	a5,-32(s0)
   11648:	00f7f793          	andi	a5,a5,15
   1164c:	f9843703          	ld	a4,-104(s0)
   11650:	00f70733          	add	a4,a4,a5
   11654:	fdc42783          	lw	a5,-36(s0)
   11658:	0017869b          	addiw	a3,a5,1
   1165c:	fcd42e23          	sw	a3,-36(s0)
   11660:	00074703          	lbu	a4,0(a4)
   11664:	ff078793          	addi	a5,a5,-16
   11668:	008787b3          	add	a5,a5,s0
   1166c:	f8e78023          	sb	a4,-128(a5)
   11670:	fe043783          	ld	a5,-32(s0)
   11674:	0047d793          	srli	a5,a5,0x4
   11678:	fef43023          	sd	a5,-32(s0)
   1167c:	fe043783          	ld	a5,-32(s0)
   11680:	fc0792e3          	bnez	a5,11644 <vprintfmt+0x364>
   11684:	f8c42703          	lw	a4,-116(s0)
   11688:	fff00793          	li	a5,-1
   1168c:	02f71663          	bne	a4,a5,116b8 <vprintfmt+0x3d8>
   11690:	f8344783          	lbu	a5,-125(s0)
   11694:	02078263          	beqz	a5,116b8 <vprintfmt+0x3d8>
   11698:	f8842703          	lw	a4,-120(s0)
   1169c:	fa644783          	lbu	a5,-90(s0)
   116a0:	0007879b          	sext.w	a5,a5
   116a4:	0017979b          	slliw	a5,a5,0x1
   116a8:	0007879b          	sext.w	a5,a5
   116ac:	40f707bb          	subw	a5,a4,a5
   116b0:	0007879b          	sext.w	a5,a5
   116b4:	f8f42623          	sw	a5,-116(s0)
   116b8:	f8842703          	lw	a4,-120(s0)
   116bc:	fa644783          	lbu	a5,-90(s0)
   116c0:	0007879b          	sext.w	a5,a5
   116c4:	0017979b          	slliw	a5,a5,0x1
   116c8:	0007879b          	sext.w	a5,a5
   116cc:	40f707bb          	subw	a5,a4,a5
   116d0:	0007871b          	sext.w	a4,a5
   116d4:	fdc42783          	lw	a5,-36(s0)
   116d8:	f8f42a23          	sw	a5,-108(s0)
   116dc:	f8c42783          	lw	a5,-116(s0)
   116e0:	f8f42823          	sw	a5,-112(s0)
   116e4:	f9442783          	lw	a5,-108(s0)
   116e8:	00078593          	mv	a1,a5
   116ec:	f9042783          	lw	a5,-112(s0)
   116f0:	00078613          	mv	a2,a5
   116f4:	0006069b          	sext.w	a3,a2
   116f8:	0005879b          	sext.w	a5,a1
   116fc:	00f6d463          	bge	a3,a5,11704 <vprintfmt+0x424>
   11700:	00058613          	mv	a2,a1
   11704:	0006079b          	sext.w	a5,a2
   11708:	40f707bb          	subw	a5,a4,a5
   1170c:	fcf42c23          	sw	a5,-40(s0)
   11710:	0280006f          	j	11738 <vprintfmt+0x458>
   11714:	f5843783          	ld	a5,-168(s0)
   11718:	02000513          	li	a0,32
   1171c:	000780e7          	jalr	a5
   11720:	fec42783          	lw	a5,-20(s0)
   11724:	0017879b          	addiw	a5,a5,1
   11728:	fef42623          	sw	a5,-20(s0)
   1172c:	fd842783          	lw	a5,-40(s0)
   11730:	fff7879b          	addiw	a5,a5,-1
   11734:	fcf42c23          	sw	a5,-40(s0)
   11738:	fd842783          	lw	a5,-40(s0)
   1173c:	0007879b          	sext.w	a5,a5
   11740:	fcf04ae3          	bgtz	a5,11714 <vprintfmt+0x434>
   11744:	fa644783          	lbu	a5,-90(s0)
   11748:	0ff7f793          	zext.b	a5,a5
   1174c:	04078463          	beqz	a5,11794 <vprintfmt+0x4b4>
   11750:	f5843783          	ld	a5,-168(s0)
   11754:	03000513          	li	a0,48
   11758:	000780e7          	jalr	a5
   1175c:	f5043783          	ld	a5,-176(s0)
   11760:	0007c783          	lbu	a5,0(a5)
   11764:	00078713          	mv	a4,a5
   11768:	05800793          	li	a5,88
   1176c:	00f71663          	bne	a4,a5,11778 <vprintfmt+0x498>
   11770:	05800793          	li	a5,88
   11774:	0080006f          	j	1177c <vprintfmt+0x49c>
   11778:	07800793          	li	a5,120
   1177c:	f5843703          	ld	a4,-168(s0)
   11780:	00078513          	mv	a0,a5
   11784:	000700e7          	jalr	a4
   11788:	fec42783          	lw	a5,-20(s0)
   1178c:	0027879b          	addiw	a5,a5,2
   11790:	fef42623          	sw	a5,-20(s0)
   11794:	fdc42783          	lw	a5,-36(s0)
   11798:	fcf42a23          	sw	a5,-44(s0)
   1179c:	0280006f          	j	117c4 <vprintfmt+0x4e4>
   117a0:	f5843783          	ld	a5,-168(s0)
   117a4:	03000513          	li	a0,48
   117a8:	000780e7          	jalr	a5
   117ac:	fec42783          	lw	a5,-20(s0)
   117b0:	0017879b          	addiw	a5,a5,1
   117b4:	fef42623          	sw	a5,-20(s0)
   117b8:	fd442783          	lw	a5,-44(s0)
   117bc:	0017879b          	addiw	a5,a5,1
   117c0:	fcf42a23          	sw	a5,-44(s0)
   117c4:	f8c42783          	lw	a5,-116(s0)
   117c8:	fd442703          	lw	a4,-44(s0)
   117cc:	0007071b          	sext.w	a4,a4
   117d0:	fcf748e3          	blt	a4,a5,117a0 <vprintfmt+0x4c0>
   117d4:	fdc42783          	lw	a5,-36(s0)
   117d8:	fff7879b          	addiw	a5,a5,-1
   117dc:	fcf42823          	sw	a5,-48(s0)
   117e0:	03c0006f          	j	1181c <vprintfmt+0x53c>
   117e4:	fd042783          	lw	a5,-48(s0)
   117e8:	ff078793          	addi	a5,a5,-16
   117ec:	008787b3          	add	a5,a5,s0
   117f0:	f807c783          	lbu	a5,-128(a5)
   117f4:	0007871b          	sext.w	a4,a5
   117f8:	f5843783          	ld	a5,-168(s0)
   117fc:	00070513          	mv	a0,a4
   11800:	000780e7          	jalr	a5
   11804:	fec42783          	lw	a5,-20(s0)
   11808:	0017879b          	addiw	a5,a5,1
   1180c:	fef42623          	sw	a5,-20(s0)
   11810:	fd042783          	lw	a5,-48(s0)
   11814:	fff7879b          	addiw	a5,a5,-1
   11818:	fcf42823          	sw	a5,-48(s0)
   1181c:	fd042783          	lw	a5,-48(s0)
   11820:	0007879b          	sext.w	a5,a5
   11824:	fc07d0e3          	bgez	a5,117e4 <vprintfmt+0x504>
   11828:	f8040023          	sb	zero,-128(s0)
   1182c:	2700006f          	j	11a9c <vprintfmt+0x7bc>
   11830:	f5043783          	ld	a5,-176(s0)
   11834:	0007c783          	lbu	a5,0(a5)
   11838:	00078713          	mv	a4,a5
   1183c:	06400793          	li	a5,100
   11840:	02f70663          	beq	a4,a5,1186c <vprintfmt+0x58c>
   11844:	f5043783          	ld	a5,-176(s0)
   11848:	0007c783          	lbu	a5,0(a5)
   1184c:	00078713          	mv	a4,a5
   11850:	06900793          	li	a5,105
   11854:	00f70c63          	beq	a4,a5,1186c <vprintfmt+0x58c>
   11858:	f5043783          	ld	a5,-176(s0)
   1185c:	0007c783          	lbu	a5,0(a5)
   11860:	00078713          	mv	a4,a5
   11864:	07500793          	li	a5,117
   11868:	08f71063          	bne	a4,a5,118e8 <vprintfmt+0x608>
   1186c:	f8144783          	lbu	a5,-127(s0)
   11870:	00078c63          	beqz	a5,11888 <vprintfmt+0x5a8>
   11874:	f4843783          	ld	a5,-184(s0)
   11878:	00878713          	addi	a4,a5,8
   1187c:	f4e43423          	sd	a4,-184(s0)
   11880:	0007b783          	ld	a5,0(a5)
   11884:	0140006f          	j	11898 <vprintfmt+0x5b8>
   11888:	f4843783          	ld	a5,-184(s0)
   1188c:	00878713          	addi	a4,a5,8
   11890:	f4e43423          	sd	a4,-184(s0)
   11894:	0007a783          	lw	a5,0(a5)
   11898:	faf43423          	sd	a5,-88(s0)
   1189c:	fa843583          	ld	a1,-88(s0)
   118a0:	f5043783          	ld	a5,-176(s0)
   118a4:	0007c783          	lbu	a5,0(a5)
   118a8:	0007871b          	sext.w	a4,a5
   118ac:	07500793          	li	a5,117
   118b0:	40f707b3          	sub	a5,a4,a5
   118b4:	00f037b3          	snez	a5,a5
   118b8:	0ff7f793          	zext.b	a5,a5
   118bc:	f8040713          	addi	a4,s0,-128
   118c0:	00070693          	mv	a3,a4
   118c4:	00078613          	mv	a2,a5
   118c8:	f5843503          	ld	a0,-168(s0)
   118cc:	ee4ff0ef          	jal	10fb0 <print_dec_int>
   118d0:	00050793          	mv	a5,a0
   118d4:	fec42703          	lw	a4,-20(s0)
   118d8:	00f707bb          	addw	a5,a4,a5
   118dc:	fef42623          	sw	a5,-20(s0)
   118e0:	f8040023          	sb	zero,-128(s0)
   118e4:	1b80006f          	j	11a9c <vprintfmt+0x7bc>
   118e8:	f5043783          	ld	a5,-176(s0)
   118ec:	0007c783          	lbu	a5,0(a5)
   118f0:	00078713          	mv	a4,a5
   118f4:	06e00793          	li	a5,110
   118f8:	04f71c63          	bne	a4,a5,11950 <vprintfmt+0x670>
   118fc:	f8144783          	lbu	a5,-127(s0)
   11900:	02078463          	beqz	a5,11928 <vprintfmt+0x648>
   11904:	f4843783          	ld	a5,-184(s0)
   11908:	00878713          	addi	a4,a5,8
   1190c:	f4e43423          	sd	a4,-184(s0)
   11910:	0007b783          	ld	a5,0(a5)
   11914:	faf43823          	sd	a5,-80(s0)
   11918:	fec42703          	lw	a4,-20(s0)
   1191c:	fb043783          	ld	a5,-80(s0)
   11920:	00e7b023          	sd	a4,0(a5)
   11924:	0240006f          	j	11948 <vprintfmt+0x668>
   11928:	f4843783          	ld	a5,-184(s0)
   1192c:	00878713          	addi	a4,a5,8
   11930:	f4e43423          	sd	a4,-184(s0)
   11934:	0007b783          	ld	a5,0(a5)
   11938:	faf43c23          	sd	a5,-72(s0)
   1193c:	fb843783          	ld	a5,-72(s0)
   11940:	fec42703          	lw	a4,-20(s0)
   11944:	00e7a023          	sw	a4,0(a5)
   11948:	f8040023          	sb	zero,-128(s0)
   1194c:	1500006f          	j	11a9c <vprintfmt+0x7bc>
   11950:	f5043783          	ld	a5,-176(s0)
   11954:	0007c783          	lbu	a5,0(a5)
   11958:	00078713          	mv	a4,a5
   1195c:	07300793          	li	a5,115
   11960:	02f71e63          	bne	a4,a5,1199c <vprintfmt+0x6bc>
   11964:	f4843783          	ld	a5,-184(s0)
   11968:	00878713          	addi	a4,a5,8
   1196c:	f4e43423          	sd	a4,-184(s0)
   11970:	0007b783          	ld	a5,0(a5)
   11974:	fcf43023          	sd	a5,-64(s0)
   11978:	fc043583          	ld	a1,-64(s0)
   1197c:	f5843503          	ld	a0,-168(s0)
   11980:	da8ff0ef          	jal	10f28 <puts_wo_nl>
   11984:	00050793          	mv	a5,a0
   11988:	fec42703          	lw	a4,-20(s0)
   1198c:	00f707bb          	addw	a5,a4,a5
   11990:	fef42623          	sw	a5,-20(s0)
   11994:	f8040023          	sb	zero,-128(s0)
   11998:	1040006f          	j	11a9c <vprintfmt+0x7bc>
   1199c:	f5043783          	ld	a5,-176(s0)
   119a0:	0007c783          	lbu	a5,0(a5)
   119a4:	00078713          	mv	a4,a5
   119a8:	06300793          	li	a5,99
   119ac:	02f71e63          	bne	a4,a5,119e8 <vprintfmt+0x708>
   119b0:	f4843783          	ld	a5,-184(s0)
   119b4:	00878713          	addi	a4,a5,8
   119b8:	f4e43423          	sd	a4,-184(s0)
   119bc:	0007a783          	lw	a5,0(a5)
   119c0:	fcf42623          	sw	a5,-52(s0)
   119c4:	fcc42703          	lw	a4,-52(s0)
   119c8:	f5843783          	ld	a5,-168(s0)
   119cc:	00070513          	mv	a0,a4
   119d0:	000780e7          	jalr	a5
   119d4:	fec42783          	lw	a5,-20(s0)
   119d8:	0017879b          	addiw	a5,a5,1
   119dc:	fef42623          	sw	a5,-20(s0)
   119e0:	f8040023          	sb	zero,-128(s0)
   119e4:	0b80006f          	j	11a9c <vprintfmt+0x7bc>
   119e8:	f5043783          	ld	a5,-176(s0)
   119ec:	0007c783          	lbu	a5,0(a5)
   119f0:	00078713          	mv	a4,a5
   119f4:	02500793          	li	a5,37
   119f8:	02f71263          	bne	a4,a5,11a1c <vprintfmt+0x73c>
   119fc:	f5843783          	ld	a5,-168(s0)
   11a00:	02500513          	li	a0,37
   11a04:	000780e7          	jalr	a5
   11a08:	fec42783          	lw	a5,-20(s0)
   11a0c:	0017879b          	addiw	a5,a5,1
   11a10:	fef42623          	sw	a5,-20(s0)
   11a14:	f8040023          	sb	zero,-128(s0)
   11a18:	0840006f          	j	11a9c <vprintfmt+0x7bc>
   11a1c:	f5043783          	ld	a5,-176(s0)
   11a20:	0007c783          	lbu	a5,0(a5)
   11a24:	0007871b          	sext.w	a4,a5
   11a28:	f5843783          	ld	a5,-168(s0)
   11a2c:	00070513          	mv	a0,a4
   11a30:	000780e7          	jalr	a5
   11a34:	fec42783          	lw	a5,-20(s0)
   11a38:	0017879b          	addiw	a5,a5,1
   11a3c:	fef42623          	sw	a5,-20(s0)
   11a40:	f8040023          	sb	zero,-128(s0)
   11a44:	0580006f          	j	11a9c <vprintfmt+0x7bc>
   11a48:	f5043783          	ld	a5,-176(s0)
   11a4c:	0007c783          	lbu	a5,0(a5)
   11a50:	00078713          	mv	a4,a5
   11a54:	02500793          	li	a5,37
   11a58:	02f71063          	bne	a4,a5,11a78 <vprintfmt+0x798>
   11a5c:	f8043023          	sd	zero,-128(s0)
   11a60:	f8043423          	sd	zero,-120(s0)
   11a64:	00100793          	li	a5,1
   11a68:	f8f40023          	sb	a5,-128(s0)
   11a6c:	fff00793          	li	a5,-1
   11a70:	f8f42623          	sw	a5,-116(s0)
   11a74:	0280006f          	j	11a9c <vprintfmt+0x7bc>
   11a78:	f5043783          	ld	a5,-176(s0)
   11a7c:	0007c783          	lbu	a5,0(a5)
   11a80:	0007871b          	sext.w	a4,a5
   11a84:	f5843783          	ld	a5,-168(s0)
   11a88:	00070513          	mv	a0,a4
   11a8c:	000780e7          	jalr	a5
   11a90:	fec42783          	lw	a5,-20(s0)
   11a94:	0017879b          	addiw	a5,a5,1
   11a98:	fef42623          	sw	a5,-20(s0)
   11a9c:	f5043783          	ld	a5,-176(s0)
   11aa0:	00178793          	addi	a5,a5,1
   11aa4:	f4f43823          	sd	a5,-176(s0)
   11aa8:	f5043783          	ld	a5,-176(s0)
   11aac:	0007c783          	lbu	a5,0(a5)
   11ab0:	84079ee3          	bnez	a5,1130c <vprintfmt+0x2c>
   11ab4:	fec42783          	lw	a5,-20(s0)
   11ab8:	00078513          	mv	a0,a5
   11abc:	0b813083          	ld	ra,184(sp)
   11ac0:	0b013403          	ld	s0,176(sp)
   11ac4:	0c010113          	addi	sp,sp,192
   11ac8:	00008067          	ret

0000000000011acc <printf>:
   11acc:	f8010113          	addi	sp,sp,-128
   11ad0:	02113c23          	sd	ra,56(sp)
   11ad4:	02813823          	sd	s0,48(sp)
   11ad8:	04010413          	addi	s0,sp,64
   11adc:	fca43423          	sd	a0,-56(s0)
   11ae0:	00b43423          	sd	a1,8(s0)
   11ae4:	00c43823          	sd	a2,16(s0)
   11ae8:	00d43c23          	sd	a3,24(s0)
   11aec:	02e43023          	sd	a4,32(s0)
   11af0:	02f43423          	sd	a5,40(s0)
   11af4:	03043823          	sd	a6,48(s0)
   11af8:	03143c23          	sd	a7,56(s0)
   11afc:	fe042623          	sw	zero,-20(s0)
   11b00:	04040793          	addi	a5,s0,64
   11b04:	fcf43023          	sd	a5,-64(s0)
   11b08:	fc043783          	ld	a5,-64(s0)
   11b0c:	fc878793          	addi	a5,a5,-56
   11b10:	fcf43823          	sd	a5,-48(s0)
   11b14:	fd043783          	ld	a5,-48(s0)
   11b18:	00078613          	mv	a2,a5
   11b1c:	fc843583          	ld	a1,-56(s0)
   11b20:	fffff517          	auipc	a0,0xfffff
   11b24:	0c450513          	addi	a0,a0,196 # 10be4 <putc>
   11b28:	fb8ff0ef          	jal	112e0 <vprintfmt>
   11b2c:	00050793          	mv	a5,a0
   11b30:	fef42623          	sw	a5,-20(s0)
   11b34:	00100793          	li	a5,1
   11b38:	fef43023          	sd	a5,-32(s0)
   11b3c:	00002797          	auipc	a5,0x2
   11b40:	4c478793          	addi	a5,a5,1220 # 14000 <tail>
   11b44:	0007a783          	lw	a5,0(a5)
   11b48:	0017871b          	addiw	a4,a5,1
   11b4c:	0007069b          	sext.w	a3,a4
   11b50:	00002717          	auipc	a4,0x2
   11b54:	4b070713          	addi	a4,a4,1200 # 14000 <tail>
   11b58:	00d72023          	sw	a3,0(a4)
   11b5c:	00002717          	auipc	a4,0x2
   11b60:	4ac70713          	addi	a4,a4,1196 # 14008 <buffer>
   11b64:	00f707b3          	add	a5,a4,a5
   11b68:	00078023          	sb	zero,0(a5)
   11b6c:	00002797          	auipc	a5,0x2
   11b70:	49478793          	addi	a5,a5,1172 # 14000 <tail>
   11b74:	0007a603          	lw	a2,0(a5)
   11b78:	fe043703          	ld	a4,-32(s0)
   11b7c:	00002697          	auipc	a3,0x2
   11b80:	48c68693          	addi	a3,a3,1164 # 14008 <buffer>
   11b84:	fd843783          	ld	a5,-40(s0)
   11b88:	04000893          	li	a7,64
   11b8c:	00070513          	mv	a0,a4
   11b90:	00068593          	mv	a1,a3
   11b94:	00060613          	mv	a2,a2
   11b98:	00000073          	ecall
   11b9c:	00050793          	mv	a5,a0
   11ba0:	fcf43c23          	sd	a5,-40(s0)
   11ba4:	00002797          	auipc	a5,0x2
   11ba8:	45c78793          	addi	a5,a5,1116 # 14000 <tail>
   11bac:	0007a023          	sw	zero,0(a5)
   11bb0:	fec42783          	lw	a5,-20(s0)
   11bb4:	00078513          	mv	a0,a5
   11bb8:	03813083          	ld	ra,56(sp)
   11bbc:	03013403          	ld	s0,48(sp)
   11bc0:	08010113          	addi	sp,sp,128
   11bc4:	00008067          	ret

0000000000011bc8 <strlen>:
   11bc8:	fd010113          	addi	sp,sp,-48
   11bcc:	02113423          	sd	ra,40(sp)
   11bd0:	02813023          	sd	s0,32(sp)
   11bd4:	03010413          	addi	s0,sp,48
   11bd8:	fca43c23          	sd	a0,-40(s0)
   11bdc:	fe042623          	sw	zero,-20(s0)
   11be0:	0100006f          	j	11bf0 <strlen+0x28>
   11be4:	fec42783          	lw	a5,-20(s0)
   11be8:	0017879b          	addiw	a5,a5,1
   11bec:	fef42623          	sw	a5,-20(s0)
   11bf0:	fd843783          	ld	a5,-40(s0)
   11bf4:	00178713          	addi	a4,a5,1
   11bf8:	fce43c23          	sd	a4,-40(s0)
   11bfc:	0007c783          	lbu	a5,0(a5)
   11c00:	fe0792e3          	bnez	a5,11be4 <strlen+0x1c>
   11c04:	fec42783          	lw	a5,-20(s0)
   11c08:	00078513          	mv	a0,a5
   11c0c:	02813083          	ld	ra,40(sp)
   11c10:	02013403          	ld	s0,32(sp)
   11c14:	03010113          	addi	sp,sp,48
   11c18:	00008067          	ret

0000000000011c1c <write>:
   11c1c:	fb010113          	addi	sp,sp,-80
   11c20:	04113423          	sd	ra,72(sp)
   11c24:	04813023          	sd	s0,64(sp)
   11c28:	05010413          	addi	s0,sp,80
   11c2c:	00050693          	mv	a3,a0
   11c30:	fcb43023          	sd	a1,-64(s0)
   11c34:	fac43c23          	sd	a2,-72(s0)
   11c38:	fcd42623          	sw	a3,-52(s0)
   11c3c:	00010693          	mv	a3,sp
   11c40:	00068593          	mv	a1,a3
   11c44:	fb843683          	ld	a3,-72(s0)
   11c48:	00168693          	addi	a3,a3,1
   11c4c:	00068613          	mv	a2,a3
   11c50:	fff60613          	addi	a2,a2,-1
   11c54:	fec43023          	sd	a2,-32(s0)
   11c58:	00068e13          	mv	t3,a3
   11c5c:	00000e93          	li	t4,0
   11c60:	03de5613          	srli	a2,t3,0x3d
   11c64:	003e9893          	slli	a7,t4,0x3
   11c68:	011668b3          	or	a7,a2,a7
   11c6c:	003e1813          	slli	a6,t3,0x3
   11c70:	00068313          	mv	t1,a3
   11c74:	00000393          	li	t2,0
   11c78:	03d35613          	srli	a2,t1,0x3d
   11c7c:	00339793          	slli	a5,t2,0x3
   11c80:	00f667b3          	or	a5,a2,a5
   11c84:	00331713          	slli	a4,t1,0x3
   11c88:	00f68793          	addi	a5,a3,15
   11c8c:	0047d793          	srli	a5,a5,0x4
   11c90:	00479793          	slli	a5,a5,0x4
   11c94:	40f10133          	sub	sp,sp,a5
   11c98:	00010793          	mv	a5,sp
   11c9c:	fcf43c23          	sd	a5,-40(s0)
   11ca0:	fe042623          	sw	zero,-20(s0)
   11ca4:	0300006f          	j	11cd4 <write+0xb8>
   11ca8:	fec42783          	lw	a5,-20(s0)
   11cac:	fc043703          	ld	a4,-64(s0)
   11cb0:	00f707b3          	add	a5,a4,a5
   11cb4:	0007c703          	lbu	a4,0(a5)
   11cb8:	fd843683          	ld	a3,-40(s0)
   11cbc:	fec42783          	lw	a5,-20(s0)
   11cc0:	00f687b3          	add	a5,a3,a5
   11cc4:	00e78023          	sb	a4,0(a5)
   11cc8:	fec42783          	lw	a5,-20(s0)
   11ccc:	0017879b          	addiw	a5,a5,1
   11cd0:	fef42623          	sw	a5,-20(s0)
   11cd4:	fec42783          	lw	a5,-20(s0)
   11cd8:	fb843703          	ld	a4,-72(s0)
   11cdc:	fce7e6e3          	bltu	a5,a4,11ca8 <write+0x8c>
   11ce0:	fd843703          	ld	a4,-40(s0)
   11ce4:	fb843783          	ld	a5,-72(s0)
   11ce8:	00f707b3          	add	a5,a4,a5
   11cec:	00078023          	sb	zero,0(a5)
   11cf0:	fcc42703          	lw	a4,-52(s0)
   11cf4:	fd843683          	ld	a3,-40(s0)
   11cf8:	fb843603          	ld	a2,-72(s0)
   11cfc:	fd043783          	ld	a5,-48(s0)
   11d00:	04000893          	li	a7,64
   11d04:	00070513          	mv	a0,a4
   11d08:	00068593          	mv	a1,a3
   11d0c:	00060613          	mv	a2,a2
   11d10:	00000073          	ecall
   11d14:	00050793          	mv	a5,a0
   11d18:	fcf43823          	sd	a5,-48(s0)
   11d1c:	fd043783          	ld	a5,-48(s0)
   11d20:	0007879b          	sext.w	a5,a5
   11d24:	00058113          	mv	sp,a1
   11d28:	00078513          	mv	a0,a5
   11d2c:	fb040113          	addi	sp,s0,-80
   11d30:	04813083          	ld	ra,72(sp)
   11d34:	04013403          	ld	s0,64(sp)
   11d38:	05010113          	addi	sp,sp,80
   11d3c:	00008067          	ret

0000000000011d40 <read>:
   11d40:	fc010113          	addi	sp,sp,-64
   11d44:	02113c23          	sd	ra,56(sp)
   11d48:	02813823          	sd	s0,48(sp)
   11d4c:	04010413          	addi	s0,sp,64
   11d50:	00050793          	mv	a5,a0
   11d54:	fcb43823          	sd	a1,-48(s0)
   11d58:	fcc43423          	sd	a2,-56(s0)
   11d5c:	fcf42e23          	sw	a5,-36(s0)
   11d60:	fdc42703          	lw	a4,-36(s0)
   11d64:	fd043683          	ld	a3,-48(s0)
   11d68:	fc843603          	ld	a2,-56(s0)
   11d6c:	fe843783          	ld	a5,-24(s0)
   11d70:	03f00893          	li	a7,63
   11d74:	00070513          	mv	a0,a4
   11d78:	00068593          	mv	a1,a3
   11d7c:	00060613          	mv	a2,a2
   11d80:	00000073          	ecall
   11d84:	00050793          	mv	a5,a0
   11d88:	fef43423          	sd	a5,-24(s0)
   11d8c:	fe843783          	ld	a5,-24(s0)
   11d90:	0007879b          	sext.w	a5,a5
   11d94:	00078513          	mv	a0,a5
   11d98:	03813083          	ld	ra,56(sp)
   11d9c:	03013403          	ld	s0,48(sp)
   11da0:	04010113          	addi	sp,sp,64
   11da4:	00008067          	ret

0000000000011da8 <sys_openat>:
   11da8:	fd010113          	addi	sp,sp,-48
   11dac:	02113423          	sd	ra,40(sp)
   11db0:	02813023          	sd	s0,32(sp)
   11db4:	03010413          	addi	s0,sp,48
   11db8:	00050793          	mv	a5,a0
   11dbc:	fcb43823          	sd	a1,-48(s0)
   11dc0:	00060713          	mv	a4,a2
   11dc4:	fcf42e23          	sw	a5,-36(s0)
   11dc8:	00070793          	mv	a5,a4
   11dcc:	fcf42c23          	sw	a5,-40(s0)
   11dd0:	fdc42703          	lw	a4,-36(s0)
   11dd4:	fd842603          	lw	a2,-40(s0)
   11dd8:	fd043683          	ld	a3,-48(s0)
   11ddc:	fe843783          	ld	a5,-24(s0)
   11de0:	03800893          	li	a7,56
   11de4:	00070513          	mv	a0,a4
   11de8:	00068593          	mv	a1,a3
   11dec:	00060613          	mv	a2,a2
   11df0:	00000073          	ecall
   11df4:	00050793          	mv	a5,a0
   11df8:	fef43423          	sd	a5,-24(s0)
   11dfc:	fe843783          	ld	a5,-24(s0)
   11e00:	0007879b          	sext.w	a5,a5
   11e04:	00078513          	mv	a0,a5
   11e08:	02813083          	ld	ra,40(sp)
   11e0c:	02013403          	ld	s0,32(sp)
   11e10:	03010113          	addi	sp,sp,48
   11e14:	00008067          	ret

0000000000011e18 <open>:
   11e18:	fe010113          	addi	sp,sp,-32
   11e1c:	00113c23          	sd	ra,24(sp)
   11e20:	00813823          	sd	s0,16(sp)
   11e24:	02010413          	addi	s0,sp,32
   11e28:	fea43423          	sd	a0,-24(s0)
   11e2c:	00058793          	mv	a5,a1
   11e30:	fef42223          	sw	a5,-28(s0)
   11e34:	fe442783          	lw	a5,-28(s0)
   11e38:	00078613          	mv	a2,a5
   11e3c:	fe843583          	ld	a1,-24(s0)
   11e40:	f9c00513          	li	a0,-100
   11e44:	f65ff0ef          	jal	11da8 <sys_openat>
   11e48:	00050793          	mv	a5,a0
   11e4c:	00078513          	mv	a0,a5
   11e50:	01813083          	ld	ra,24(sp)
   11e54:	01013403          	ld	s0,16(sp)
   11e58:	02010113          	addi	sp,sp,32
   11e5c:	00008067          	ret

0000000000011e60 <close>:
   11e60:	fd010113          	addi	sp,sp,-48
   11e64:	02113423          	sd	ra,40(sp)
   11e68:	02813023          	sd	s0,32(sp)
   11e6c:	03010413          	addi	s0,sp,48
   11e70:	00050793          	mv	a5,a0
   11e74:	fcf42e23          	sw	a5,-36(s0)
   11e78:	fdc42703          	lw	a4,-36(s0)
   11e7c:	fe843783          	ld	a5,-24(s0)
   11e80:	03900893          	li	a7,57
   11e84:	00070513          	mv	a0,a4
   11e88:	00000073          	ecall
   11e8c:	00050793          	mv	a5,a0
   11e90:	fef43423          	sd	a5,-24(s0)
   11e94:	fe843783          	ld	a5,-24(s0)
   11e98:	0007879b          	sext.w	a5,a5
   11e9c:	00078513          	mv	a0,a5
   11ea0:	02813083          	ld	ra,40(sp)
   11ea4:	02013403          	ld	s0,32(sp)
   11ea8:	03010113          	addi	sp,sp,48
   11eac:	00008067          	ret

0000000000011eb0 <lseek>:
   11eb0:	fd010113          	addi	sp,sp,-48
   11eb4:	02113423          	sd	ra,40(sp)
   11eb8:	02813023          	sd	s0,32(sp)
   11ebc:	03010413          	addi	s0,sp,48
   11ec0:	00050793          	mv	a5,a0
   11ec4:	00058693          	mv	a3,a1
   11ec8:	00060713          	mv	a4,a2
   11ecc:	fcf42e23          	sw	a5,-36(s0)
   11ed0:	00068793          	mv	a5,a3
   11ed4:	fcf42c23          	sw	a5,-40(s0)
   11ed8:	00070793          	mv	a5,a4
   11edc:	fcf42a23          	sw	a5,-44(s0)
   11ee0:	fdc42703          	lw	a4,-36(s0)
   11ee4:	fd842683          	lw	a3,-40(s0)
   11ee8:	fd442603          	lw	a2,-44(s0)
   11eec:	fe843783          	ld	a5,-24(s0)
   11ef0:	03e00893          	li	a7,62
   11ef4:	00070513          	mv	a0,a4
   11ef8:	00068593          	mv	a1,a3
   11efc:	00060613          	mv	a2,a2
   11f00:	00000073          	ecall
   11f04:	00050793          	mv	a5,a0
   11f08:	fef43423          	sd	a5,-24(s0)
   11f0c:	fe843783          	ld	a5,-24(s0)
   11f10:	0007879b          	sext.w	a5,a5
   11f14:	00078513          	mv	a0,a5
   11f18:	02813083          	ld	ra,40(sp)
   11f1c:	02013403          	ld	s0,32(sp)
   11f20:	03010113          	addi	sp,sp,48
   11f24:	00008067          	ret
