
uapp:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <_start>:
   100e8:	0d80006f          	j	101c0 <main>

00000000000100ec <getpid>:
   100ec:	fe010113          	addi	sp,sp,-32
   100f0:	00813c23          	sd	s0,24(sp)
   100f4:	02010413          	addi	s0,sp,32
   100f8:	fe843783          	ld	a5,-24(s0)
   100fc:	0ac00893          	li	a7,172
   10100:	00000073          	ecall
   10104:	00050793          	mv	a5,a0
   10108:	fef43423          	sd	a5,-24(s0)
   1010c:	fe843783          	ld	a5,-24(s0)
   10110:	00078513          	mv	a0,a5
   10114:	01813403          	ld	s0,24(sp)
   10118:	02010113          	addi	sp,sp,32
   1011c:	00008067          	ret

0000000000010120 <fork>:
   10120:	fe010113          	addi	sp,sp,-32
   10124:	00113c23          	sd	ra,24(sp)
   10128:	00813823          	sd	s0,16(sp)
   1012c:	02010413          	addi	s0,sp,32
   10130:	fe843783          	ld	a5,-24(s0)
   10134:	0dc00893          	li	a7,220
   10138:	00000073          	ecall
   1013c:	00050793          	mv	a5,a0
   10140:	fef43423          	sd	a5,-24(s0)
   10144:	fe843583          	ld	a1,-24(s0)
   10148:	00001517          	auipc	a0,0x1
   1014c:	10050513          	addi	a0,a0,256 # 11248 <printf+0xfc>
   10150:	7fd000ef          	jal	1114c <printf>
   10154:	fe843783          	ld	a5,-24(s0)
   10158:	00078513          	mv	a0,a5
   1015c:	01813083          	ld	ra,24(sp)
   10160:	01013403          	ld	s0,16(sp)
   10164:	02010113          	addi	sp,sp,32
   10168:	00008067          	ret

000000000001016c <wait>:
   1016c:	fd010113          	addi	sp,sp,-48
   10170:	02813423          	sd	s0,40(sp)
   10174:	03010413          	addi	s0,sp,48
   10178:	00050793          	mv	a5,a0
   1017c:	fcf42e23          	sw	a5,-36(s0)
   10180:	fe042623          	sw	zero,-20(s0)
   10184:	0100006f          	j	10194 <wait+0x28>
   10188:	fec42783          	lw	a5,-20(s0)
   1018c:	0017879b          	addiw	a5,a5,1
   10190:	fef42623          	sw	a5,-20(s0)
   10194:	fec42783          	lw	a5,-20(s0)
   10198:	00078713          	mv	a4,a5
   1019c:	fdc42783          	lw	a5,-36(s0)
   101a0:	0007071b          	sext.w	a4,a4
   101a4:	0007879b          	sext.w	a5,a5
   101a8:	fef760e3          	bltu	a4,a5,10188 <wait+0x1c>
   101ac:	00000013          	nop
   101b0:	00000013          	nop
   101b4:	02813403          	ld	s0,40(sp)
   101b8:	03010113          	addi	sp,sp,48
   101bc:	00008067          	ret

00000000000101c0 <main>:
   101c0:	ff010113          	addi	sp,sp,-16
   101c4:	00113423          	sd	ra,8(sp)
   101c8:	00813023          	sd	s0,0(sp)
   101cc:	01010413          	addi	s0,sp,16
   101d0:	f1dff0ef          	jal	100ec <getpid>
   101d4:	00050593          	mv	a1,a0
   101d8:	00002797          	auipc	a5,0x2
   101dc:	e2878793          	addi	a5,a5,-472 # 12000 <global_variable>
   101e0:	0007a783          	lw	a5,0(a5)
   101e4:	0017871b          	addiw	a4,a5,1
   101e8:	0007069b          	sext.w	a3,a4
   101ec:	00002717          	auipc	a4,0x2
   101f0:	e1470713          	addi	a4,a4,-492 # 12000 <global_variable>
   101f4:	00d72023          	sw	a3,0(a4)
   101f8:	00078613          	mv	a2,a5
   101fc:	00001517          	auipc	a0,0x1
   10200:	07450513          	addi	a0,a0,116 # 11270 <printf+0x124>
   10204:	749000ef          	jal	1114c <printf>
   10208:	f19ff0ef          	jal	10120 <fork>
   1020c:	f15ff0ef          	jal	10120 <fork>
   10210:	eddff0ef          	jal	100ec <getpid>
   10214:	00050593          	mv	a1,a0
   10218:	00002797          	auipc	a5,0x2
   1021c:	de878793          	addi	a5,a5,-536 # 12000 <global_variable>
   10220:	0007a783          	lw	a5,0(a5)
   10224:	0017871b          	addiw	a4,a5,1
   10228:	0007069b          	sext.w	a3,a4
   1022c:	00002717          	auipc	a4,0x2
   10230:	dd470713          	addi	a4,a4,-556 # 12000 <global_variable>
   10234:	00d72023          	sw	a3,0(a4)
   10238:	00078613          	mv	a2,a5
   1023c:	00001517          	auipc	a0,0x1
   10240:	03450513          	addi	a0,a0,52 # 11270 <printf+0x124>
   10244:	709000ef          	jal	1114c <printf>
   10248:	ed9ff0ef          	jal	10120 <fork>
   1024c:	ea1ff0ef          	jal	100ec <getpid>
   10250:	00050593          	mv	a1,a0
   10254:	00002797          	auipc	a5,0x2
   10258:	dac78793          	addi	a5,a5,-596 # 12000 <global_variable>
   1025c:	0007a783          	lw	a5,0(a5)
   10260:	0017871b          	addiw	a4,a5,1
   10264:	0007069b          	sext.w	a3,a4
   10268:	00002717          	auipc	a4,0x2
   1026c:	d9870713          	addi	a4,a4,-616 # 12000 <global_variable>
   10270:	00d72023          	sw	a3,0(a4)
   10274:	00078613          	mv	a2,a5
   10278:	00001517          	auipc	a0,0x1
   1027c:	ff850513          	addi	a0,a0,-8 # 11270 <printf+0x124>
   10280:	6cd000ef          	jal	1114c <printf>
   10284:	500007b7          	lui	a5,0x50000
   10288:	fff78513          	addi	a0,a5,-1 # 4fffffff <__global_pointer$+0x4ffed7ff>
   1028c:	ee1ff0ef          	jal	1016c <wait>
   10290:	00000013          	nop
   10294:	fb9ff06f          	j	1024c <main+0x8c>

0000000000010298 <putc>:
   10298:	fe010113          	addi	sp,sp,-32
   1029c:	00813c23          	sd	s0,24(sp)
   102a0:	02010413          	addi	s0,sp,32
   102a4:	00050793          	mv	a5,a0
   102a8:	fef42623          	sw	a5,-20(s0)
   102ac:	00002797          	auipc	a5,0x2
   102b0:	d5878793          	addi	a5,a5,-680 # 12004 <tail>
   102b4:	0007a783          	lw	a5,0(a5)
   102b8:	0017871b          	addiw	a4,a5,1
   102bc:	0007069b          	sext.w	a3,a4
   102c0:	00002717          	auipc	a4,0x2
   102c4:	d4470713          	addi	a4,a4,-700 # 12004 <tail>
   102c8:	00d72023          	sw	a3,0(a4)
   102cc:	fec42703          	lw	a4,-20(s0)
   102d0:	0ff77713          	zext.b	a4,a4
   102d4:	00002697          	auipc	a3,0x2
   102d8:	d3468693          	addi	a3,a3,-716 # 12008 <buffer>
   102dc:	00f687b3          	add	a5,a3,a5
   102e0:	00e78023          	sb	a4,0(a5)
   102e4:	fec42783          	lw	a5,-20(s0)
   102e8:	0ff7f793          	zext.b	a5,a5
   102ec:	0007879b          	sext.w	a5,a5
   102f0:	00078513          	mv	a0,a5
   102f4:	01813403          	ld	s0,24(sp)
   102f8:	02010113          	addi	sp,sp,32
   102fc:	00008067          	ret

0000000000010300 <isspace>:
   10300:	fe010113          	addi	sp,sp,-32
   10304:	00813c23          	sd	s0,24(sp)
   10308:	02010413          	addi	s0,sp,32
   1030c:	00050793          	mv	a5,a0
   10310:	fef42623          	sw	a5,-20(s0)
   10314:	fec42783          	lw	a5,-20(s0)
   10318:	0007871b          	sext.w	a4,a5
   1031c:	02000793          	li	a5,32
   10320:	02f70263          	beq	a4,a5,10344 <isspace+0x44>
   10324:	fec42783          	lw	a5,-20(s0)
   10328:	0007871b          	sext.w	a4,a5
   1032c:	00800793          	li	a5,8
   10330:	00e7de63          	bge	a5,a4,1034c <isspace+0x4c>
   10334:	fec42783          	lw	a5,-20(s0)
   10338:	0007871b          	sext.w	a4,a5
   1033c:	00d00793          	li	a5,13
   10340:	00e7c663          	blt	a5,a4,1034c <isspace+0x4c>
   10344:	00100793          	li	a5,1
   10348:	0080006f          	j	10350 <isspace+0x50>
   1034c:	00000793          	li	a5,0
   10350:	00078513          	mv	a0,a5
   10354:	01813403          	ld	s0,24(sp)
   10358:	02010113          	addi	sp,sp,32
   1035c:	00008067          	ret

0000000000010360 <strtol>:
   10360:	fb010113          	addi	sp,sp,-80
   10364:	04113423          	sd	ra,72(sp)
   10368:	04813023          	sd	s0,64(sp)
   1036c:	05010413          	addi	s0,sp,80
   10370:	fca43423          	sd	a0,-56(s0)
   10374:	fcb43023          	sd	a1,-64(s0)
   10378:	00060793          	mv	a5,a2
   1037c:	faf42e23          	sw	a5,-68(s0)
   10380:	fe043423          	sd	zero,-24(s0)
   10384:	fe0403a3          	sb	zero,-25(s0)
   10388:	fc843783          	ld	a5,-56(s0)
   1038c:	fcf43c23          	sd	a5,-40(s0)
   10390:	0100006f          	j	103a0 <strtol+0x40>
   10394:	fd843783          	ld	a5,-40(s0)
   10398:	00178793          	addi	a5,a5,1
   1039c:	fcf43c23          	sd	a5,-40(s0)
   103a0:	fd843783          	ld	a5,-40(s0)
   103a4:	0007c783          	lbu	a5,0(a5)
   103a8:	0007879b          	sext.w	a5,a5
   103ac:	00078513          	mv	a0,a5
   103b0:	f51ff0ef          	jal	10300 <isspace>
   103b4:	00050793          	mv	a5,a0
   103b8:	fc079ee3          	bnez	a5,10394 <strtol+0x34>
   103bc:	fd843783          	ld	a5,-40(s0)
   103c0:	0007c783          	lbu	a5,0(a5)
   103c4:	00078713          	mv	a4,a5
   103c8:	02d00793          	li	a5,45
   103cc:	00f71e63          	bne	a4,a5,103e8 <strtol+0x88>
   103d0:	00100793          	li	a5,1
   103d4:	fef403a3          	sb	a5,-25(s0)
   103d8:	fd843783          	ld	a5,-40(s0)
   103dc:	00178793          	addi	a5,a5,1
   103e0:	fcf43c23          	sd	a5,-40(s0)
   103e4:	0240006f          	j	10408 <strtol+0xa8>
   103e8:	fd843783          	ld	a5,-40(s0)
   103ec:	0007c783          	lbu	a5,0(a5)
   103f0:	00078713          	mv	a4,a5
   103f4:	02b00793          	li	a5,43
   103f8:	00f71863          	bne	a4,a5,10408 <strtol+0xa8>
   103fc:	fd843783          	ld	a5,-40(s0)
   10400:	00178793          	addi	a5,a5,1
   10404:	fcf43c23          	sd	a5,-40(s0)
   10408:	fbc42783          	lw	a5,-68(s0)
   1040c:	0007879b          	sext.w	a5,a5
   10410:	06079c63          	bnez	a5,10488 <strtol+0x128>
   10414:	fd843783          	ld	a5,-40(s0)
   10418:	0007c783          	lbu	a5,0(a5)
   1041c:	00078713          	mv	a4,a5
   10420:	03000793          	li	a5,48
   10424:	04f71e63          	bne	a4,a5,10480 <strtol+0x120>
   10428:	fd843783          	ld	a5,-40(s0)
   1042c:	00178793          	addi	a5,a5,1
   10430:	fcf43c23          	sd	a5,-40(s0)
   10434:	fd843783          	ld	a5,-40(s0)
   10438:	0007c783          	lbu	a5,0(a5)
   1043c:	00078713          	mv	a4,a5
   10440:	07800793          	li	a5,120
   10444:	00f70c63          	beq	a4,a5,1045c <strtol+0xfc>
   10448:	fd843783          	ld	a5,-40(s0)
   1044c:	0007c783          	lbu	a5,0(a5)
   10450:	00078713          	mv	a4,a5
   10454:	05800793          	li	a5,88
   10458:	00f71e63          	bne	a4,a5,10474 <strtol+0x114>
   1045c:	01000793          	li	a5,16
   10460:	faf42e23          	sw	a5,-68(s0)
   10464:	fd843783          	ld	a5,-40(s0)
   10468:	00178793          	addi	a5,a5,1
   1046c:	fcf43c23          	sd	a5,-40(s0)
   10470:	0180006f          	j	10488 <strtol+0x128>
   10474:	00800793          	li	a5,8
   10478:	faf42e23          	sw	a5,-68(s0)
   1047c:	00c0006f          	j	10488 <strtol+0x128>
   10480:	00a00793          	li	a5,10
   10484:	faf42e23          	sw	a5,-68(s0)
   10488:	fd843783          	ld	a5,-40(s0)
   1048c:	0007c783          	lbu	a5,0(a5)
   10490:	00078713          	mv	a4,a5
   10494:	02f00793          	li	a5,47
   10498:	02e7f863          	bgeu	a5,a4,104c8 <strtol+0x168>
   1049c:	fd843783          	ld	a5,-40(s0)
   104a0:	0007c783          	lbu	a5,0(a5)
   104a4:	00078713          	mv	a4,a5
   104a8:	03900793          	li	a5,57
   104ac:	00e7ee63          	bltu	a5,a4,104c8 <strtol+0x168>
   104b0:	fd843783          	ld	a5,-40(s0)
   104b4:	0007c783          	lbu	a5,0(a5)
   104b8:	0007879b          	sext.w	a5,a5
   104bc:	fd07879b          	addiw	a5,a5,-48
   104c0:	fcf42a23          	sw	a5,-44(s0)
   104c4:	0800006f          	j	10544 <strtol+0x1e4>
   104c8:	fd843783          	ld	a5,-40(s0)
   104cc:	0007c783          	lbu	a5,0(a5)
   104d0:	00078713          	mv	a4,a5
   104d4:	06000793          	li	a5,96
   104d8:	02e7f863          	bgeu	a5,a4,10508 <strtol+0x1a8>
   104dc:	fd843783          	ld	a5,-40(s0)
   104e0:	0007c783          	lbu	a5,0(a5)
   104e4:	00078713          	mv	a4,a5
   104e8:	07a00793          	li	a5,122
   104ec:	00e7ee63          	bltu	a5,a4,10508 <strtol+0x1a8>
   104f0:	fd843783          	ld	a5,-40(s0)
   104f4:	0007c783          	lbu	a5,0(a5)
   104f8:	0007879b          	sext.w	a5,a5
   104fc:	fa97879b          	addiw	a5,a5,-87
   10500:	fcf42a23          	sw	a5,-44(s0)
   10504:	0400006f          	j	10544 <strtol+0x1e4>
   10508:	fd843783          	ld	a5,-40(s0)
   1050c:	0007c783          	lbu	a5,0(a5)
   10510:	00078713          	mv	a4,a5
   10514:	04000793          	li	a5,64
   10518:	06e7f863          	bgeu	a5,a4,10588 <strtol+0x228>
   1051c:	fd843783          	ld	a5,-40(s0)
   10520:	0007c783          	lbu	a5,0(a5)
   10524:	00078713          	mv	a4,a5
   10528:	05a00793          	li	a5,90
   1052c:	04e7ee63          	bltu	a5,a4,10588 <strtol+0x228>
   10530:	fd843783          	ld	a5,-40(s0)
   10534:	0007c783          	lbu	a5,0(a5)
   10538:	0007879b          	sext.w	a5,a5
   1053c:	fc97879b          	addiw	a5,a5,-55
   10540:	fcf42a23          	sw	a5,-44(s0)
   10544:	fd442783          	lw	a5,-44(s0)
   10548:	00078713          	mv	a4,a5
   1054c:	fbc42783          	lw	a5,-68(s0)
   10550:	0007071b          	sext.w	a4,a4
   10554:	0007879b          	sext.w	a5,a5
   10558:	02f75663          	bge	a4,a5,10584 <strtol+0x224>
   1055c:	fbc42703          	lw	a4,-68(s0)
   10560:	fe843783          	ld	a5,-24(s0)
   10564:	02f70733          	mul	a4,a4,a5
   10568:	fd442783          	lw	a5,-44(s0)
   1056c:	00f707b3          	add	a5,a4,a5
   10570:	fef43423          	sd	a5,-24(s0)
   10574:	fd843783          	ld	a5,-40(s0)
   10578:	00178793          	addi	a5,a5,1
   1057c:	fcf43c23          	sd	a5,-40(s0)
   10580:	f09ff06f          	j	10488 <strtol+0x128>
   10584:	00000013          	nop
   10588:	fc043783          	ld	a5,-64(s0)
   1058c:	00078863          	beqz	a5,1059c <strtol+0x23c>
   10590:	fc043783          	ld	a5,-64(s0)
   10594:	fd843703          	ld	a4,-40(s0)
   10598:	00e7b023          	sd	a4,0(a5)
   1059c:	fe744783          	lbu	a5,-25(s0)
   105a0:	0ff7f793          	zext.b	a5,a5
   105a4:	00078863          	beqz	a5,105b4 <strtol+0x254>
   105a8:	fe843783          	ld	a5,-24(s0)
   105ac:	40f007b3          	neg	a5,a5
   105b0:	0080006f          	j	105b8 <strtol+0x258>
   105b4:	fe843783          	ld	a5,-24(s0)
   105b8:	00078513          	mv	a0,a5
   105bc:	04813083          	ld	ra,72(sp)
   105c0:	04013403          	ld	s0,64(sp)
   105c4:	05010113          	addi	sp,sp,80
   105c8:	00008067          	ret

00000000000105cc <puts_wo_nl>:
   105cc:	fd010113          	addi	sp,sp,-48
   105d0:	02113423          	sd	ra,40(sp)
   105d4:	02813023          	sd	s0,32(sp)
   105d8:	03010413          	addi	s0,sp,48
   105dc:	fca43c23          	sd	a0,-40(s0)
   105e0:	fcb43823          	sd	a1,-48(s0)
   105e4:	fd043783          	ld	a5,-48(s0)
   105e8:	00079863          	bnez	a5,105f8 <puts_wo_nl+0x2c>
   105ec:	00001797          	auipc	a5,0x1
   105f0:	cb478793          	addi	a5,a5,-844 # 112a0 <printf+0x154>
   105f4:	fcf43823          	sd	a5,-48(s0)
   105f8:	fd043783          	ld	a5,-48(s0)
   105fc:	fef43423          	sd	a5,-24(s0)
   10600:	0240006f          	j	10624 <puts_wo_nl+0x58>
   10604:	fe843783          	ld	a5,-24(s0)
   10608:	00178713          	addi	a4,a5,1
   1060c:	fee43423          	sd	a4,-24(s0)
   10610:	0007c783          	lbu	a5,0(a5)
   10614:	0007871b          	sext.w	a4,a5
   10618:	fd843783          	ld	a5,-40(s0)
   1061c:	00070513          	mv	a0,a4
   10620:	000780e7          	jalr	a5
   10624:	fe843783          	ld	a5,-24(s0)
   10628:	0007c783          	lbu	a5,0(a5)
   1062c:	fc079ce3          	bnez	a5,10604 <puts_wo_nl+0x38>
   10630:	fe843703          	ld	a4,-24(s0)
   10634:	fd043783          	ld	a5,-48(s0)
   10638:	40f707b3          	sub	a5,a4,a5
   1063c:	0007879b          	sext.w	a5,a5
   10640:	00078513          	mv	a0,a5
   10644:	02813083          	ld	ra,40(sp)
   10648:	02013403          	ld	s0,32(sp)
   1064c:	03010113          	addi	sp,sp,48
   10650:	00008067          	ret

0000000000010654 <print_dec_int>:
   10654:	f9010113          	addi	sp,sp,-112
   10658:	06113423          	sd	ra,104(sp)
   1065c:	06813023          	sd	s0,96(sp)
   10660:	07010413          	addi	s0,sp,112
   10664:	faa43423          	sd	a0,-88(s0)
   10668:	fab43023          	sd	a1,-96(s0)
   1066c:	00060793          	mv	a5,a2
   10670:	f8d43823          	sd	a3,-112(s0)
   10674:	f8f40fa3          	sb	a5,-97(s0)
   10678:	f9f44783          	lbu	a5,-97(s0)
   1067c:	0ff7f793          	zext.b	a5,a5
   10680:	02078663          	beqz	a5,106ac <print_dec_int+0x58>
   10684:	fa043703          	ld	a4,-96(s0)
   10688:	fff00793          	li	a5,-1
   1068c:	03f79793          	slli	a5,a5,0x3f
   10690:	00f71e63          	bne	a4,a5,106ac <print_dec_int+0x58>
   10694:	00001597          	auipc	a1,0x1
   10698:	c1458593          	addi	a1,a1,-1004 # 112a8 <printf+0x15c>
   1069c:	fa843503          	ld	a0,-88(s0)
   106a0:	f2dff0ef          	jal	105cc <puts_wo_nl>
   106a4:	00050793          	mv	a5,a0
   106a8:	2a00006f          	j	10948 <print_dec_int+0x2f4>
   106ac:	f9043783          	ld	a5,-112(s0)
   106b0:	00c7a783          	lw	a5,12(a5)
   106b4:	00079a63          	bnez	a5,106c8 <print_dec_int+0x74>
   106b8:	fa043783          	ld	a5,-96(s0)
   106bc:	00079663          	bnez	a5,106c8 <print_dec_int+0x74>
   106c0:	00000793          	li	a5,0
   106c4:	2840006f          	j	10948 <print_dec_int+0x2f4>
   106c8:	fe0407a3          	sb	zero,-17(s0)
   106cc:	f9f44783          	lbu	a5,-97(s0)
   106d0:	0ff7f793          	zext.b	a5,a5
   106d4:	02078063          	beqz	a5,106f4 <print_dec_int+0xa0>
   106d8:	fa043783          	ld	a5,-96(s0)
   106dc:	0007dc63          	bgez	a5,106f4 <print_dec_int+0xa0>
   106e0:	00100793          	li	a5,1
   106e4:	fef407a3          	sb	a5,-17(s0)
   106e8:	fa043783          	ld	a5,-96(s0)
   106ec:	40f007b3          	neg	a5,a5
   106f0:	faf43023          	sd	a5,-96(s0)
   106f4:	fe042423          	sw	zero,-24(s0)
   106f8:	f9f44783          	lbu	a5,-97(s0)
   106fc:	0ff7f793          	zext.b	a5,a5
   10700:	02078863          	beqz	a5,10730 <print_dec_int+0xdc>
   10704:	fef44783          	lbu	a5,-17(s0)
   10708:	0ff7f793          	zext.b	a5,a5
   1070c:	00079e63          	bnez	a5,10728 <print_dec_int+0xd4>
   10710:	f9043783          	ld	a5,-112(s0)
   10714:	0057c783          	lbu	a5,5(a5)
   10718:	00079863          	bnez	a5,10728 <print_dec_int+0xd4>
   1071c:	f9043783          	ld	a5,-112(s0)
   10720:	0047c783          	lbu	a5,4(a5)
   10724:	00078663          	beqz	a5,10730 <print_dec_int+0xdc>
   10728:	00100793          	li	a5,1
   1072c:	0080006f          	j	10734 <print_dec_int+0xe0>
   10730:	00000793          	li	a5,0
   10734:	fcf40ba3          	sb	a5,-41(s0)
   10738:	fd744783          	lbu	a5,-41(s0)
   1073c:	0017f793          	andi	a5,a5,1
   10740:	fcf40ba3          	sb	a5,-41(s0)
   10744:	fa043703          	ld	a4,-96(s0)
   10748:	00a00793          	li	a5,10
   1074c:	02f777b3          	remu	a5,a4,a5
   10750:	0ff7f713          	zext.b	a4,a5
   10754:	fe842783          	lw	a5,-24(s0)
   10758:	0017869b          	addiw	a3,a5,1
   1075c:	fed42423          	sw	a3,-24(s0)
   10760:	0307071b          	addiw	a4,a4,48
   10764:	0ff77713          	zext.b	a4,a4
   10768:	ff078793          	addi	a5,a5,-16
   1076c:	008787b3          	add	a5,a5,s0
   10770:	fce78423          	sb	a4,-56(a5)
   10774:	fa043703          	ld	a4,-96(s0)
   10778:	00a00793          	li	a5,10
   1077c:	02f757b3          	divu	a5,a4,a5
   10780:	faf43023          	sd	a5,-96(s0)
   10784:	fa043783          	ld	a5,-96(s0)
   10788:	fa079ee3          	bnez	a5,10744 <print_dec_int+0xf0>
   1078c:	f9043783          	ld	a5,-112(s0)
   10790:	00c7a783          	lw	a5,12(a5)
   10794:	00078713          	mv	a4,a5
   10798:	fff00793          	li	a5,-1
   1079c:	02f71063          	bne	a4,a5,107bc <print_dec_int+0x168>
   107a0:	f9043783          	ld	a5,-112(s0)
   107a4:	0037c783          	lbu	a5,3(a5)
   107a8:	00078a63          	beqz	a5,107bc <print_dec_int+0x168>
   107ac:	f9043783          	ld	a5,-112(s0)
   107b0:	0087a703          	lw	a4,8(a5)
   107b4:	f9043783          	ld	a5,-112(s0)
   107b8:	00e7a623          	sw	a4,12(a5)
   107bc:	fe042223          	sw	zero,-28(s0)
   107c0:	f9043783          	ld	a5,-112(s0)
   107c4:	0087a703          	lw	a4,8(a5)
   107c8:	fe842783          	lw	a5,-24(s0)
   107cc:	fcf42823          	sw	a5,-48(s0)
   107d0:	f9043783          	ld	a5,-112(s0)
   107d4:	00c7a783          	lw	a5,12(a5)
   107d8:	fcf42623          	sw	a5,-52(s0)
   107dc:	fd042783          	lw	a5,-48(s0)
   107e0:	00078593          	mv	a1,a5
   107e4:	fcc42783          	lw	a5,-52(s0)
   107e8:	00078613          	mv	a2,a5
   107ec:	0006069b          	sext.w	a3,a2
   107f0:	0005879b          	sext.w	a5,a1
   107f4:	00f6d463          	bge	a3,a5,107fc <print_dec_int+0x1a8>
   107f8:	00058613          	mv	a2,a1
   107fc:	0006079b          	sext.w	a5,a2
   10800:	40f707bb          	subw	a5,a4,a5
   10804:	0007871b          	sext.w	a4,a5
   10808:	fd744783          	lbu	a5,-41(s0)
   1080c:	0007879b          	sext.w	a5,a5
   10810:	40f707bb          	subw	a5,a4,a5
   10814:	fef42023          	sw	a5,-32(s0)
   10818:	0280006f          	j	10840 <print_dec_int+0x1ec>
   1081c:	fa843783          	ld	a5,-88(s0)
   10820:	02000513          	li	a0,32
   10824:	000780e7          	jalr	a5
   10828:	fe442783          	lw	a5,-28(s0)
   1082c:	0017879b          	addiw	a5,a5,1
   10830:	fef42223          	sw	a5,-28(s0)
   10834:	fe042783          	lw	a5,-32(s0)
   10838:	fff7879b          	addiw	a5,a5,-1
   1083c:	fef42023          	sw	a5,-32(s0)
   10840:	fe042783          	lw	a5,-32(s0)
   10844:	0007879b          	sext.w	a5,a5
   10848:	fcf04ae3          	bgtz	a5,1081c <print_dec_int+0x1c8>
   1084c:	fd744783          	lbu	a5,-41(s0)
   10850:	0ff7f793          	zext.b	a5,a5
   10854:	04078463          	beqz	a5,1089c <print_dec_int+0x248>
   10858:	fef44783          	lbu	a5,-17(s0)
   1085c:	0ff7f793          	zext.b	a5,a5
   10860:	00078663          	beqz	a5,1086c <print_dec_int+0x218>
   10864:	02d00793          	li	a5,45
   10868:	01c0006f          	j	10884 <print_dec_int+0x230>
   1086c:	f9043783          	ld	a5,-112(s0)
   10870:	0057c783          	lbu	a5,5(a5)
   10874:	00078663          	beqz	a5,10880 <print_dec_int+0x22c>
   10878:	02b00793          	li	a5,43
   1087c:	0080006f          	j	10884 <print_dec_int+0x230>
   10880:	02000793          	li	a5,32
   10884:	fa843703          	ld	a4,-88(s0)
   10888:	00078513          	mv	a0,a5
   1088c:	000700e7          	jalr	a4
   10890:	fe442783          	lw	a5,-28(s0)
   10894:	0017879b          	addiw	a5,a5,1
   10898:	fef42223          	sw	a5,-28(s0)
   1089c:	fe842783          	lw	a5,-24(s0)
   108a0:	fcf42e23          	sw	a5,-36(s0)
   108a4:	0280006f          	j	108cc <print_dec_int+0x278>
   108a8:	fa843783          	ld	a5,-88(s0)
   108ac:	03000513          	li	a0,48
   108b0:	000780e7          	jalr	a5
   108b4:	fe442783          	lw	a5,-28(s0)
   108b8:	0017879b          	addiw	a5,a5,1
   108bc:	fef42223          	sw	a5,-28(s0)
   108c0:	fdc42783          	lw	a5,-36(s0)
   108c4:	0017879b          	addiw	a5,a5,1
   108c8:	fcf42e23          	sw	a5,-36(s0)
   108cc:	f9043783          	ld	a5,-112(s0)
   108d0:	00c7a703          	lw	a4,12(a5)
   108d4:	fd744783          	lbu	a5,-41(s0)
   108d8:	0007879b          	sext.w	a5,a5
   108dc:	40f707bb          	subw	a5,a4,a5
   108e0:	0007871b          	sext.w	a4,a5
   108e4:	fdc42783          	lw	a5,-36(s0)
   108e8:	0007879b          	sext.w	a5,a5
   108ec:	fae7cee3          	blt	a5,a4,108a8 <print_dec_int+0x254>
   108f0:	fe842783          	lw	a5,-24(s0)
   108f4:	fff7879b          	addiw	a5,a5,-1
   108f8:	fcf42c23          	sw	a5,-40(s0)
   108fc:	03c0006f          	j	10938 <print_dec_int+0x2e4>
   10900:	fd842783          	lw	a5,-40(s0)
   10904:	ff078793          	addi	a5,a5,-16
   10908:	008787b3          	add	a5,a5,s0
   1090c:	fc87c783          	lbu	a5,-56(a5)
   10910:	0007871b          	sext.w	a4,a5
   10914:	fa843783          	ld	a5,-88(s0)
   10918:	00070513          	mv	a0,a4
   1091c:	000780e7          	jalr	a5
   10920:	fe442783          	lw	a5,-28(s0)
   10924:	0017879b          	addiw	a5,a5,1
   10928:	fef42223          	sw	a5,-28(s0)
   1092c:	fd842783          	lw	a5,-40(s0)
   10930:	fff7879b          	addiw	a5,a5,-1
   10934:	fcf42c23          	sw	a5,-40(s0)
   10938:	fd842783          	lw	a5,-40(s0)
   1093c:	0007879b          	sext.w	a5,a5
   10940:	fc07d0e3          	bgez	a5,10900 <print_dec_int+0x2ac>
   10944:	fe442783          	lw	a5,-28(s0)
   10948:	00078513          	mv	a0,a5
   1094c:	06813083          	ld	ra,104(sp)
   10950:	06013403          	ld	s0,96(sp)
   10954:	07010113          	addi	sp,sp,112
   10958:	00008067          	ret

000000000001095c <vprintfmt>:
   1095c:	f4010113          	addi	sp,sp,-192
   10960:	0a113c23          	sd	ra,184(sp)
   10964:	0a813823          	sd	s0,176(sp)
   10968:	0c010413          	addi	s0,sp,192
   1096c:	f4a43c23          	sd	a0,-168(s0)
   10970:	f4b43823          	sd	a1,-176(s0)
   10974:	f4c43423          	sd	a2,-184(s0)
   10978:	f8043023          	sd	zero,-128(s0)
   1097c:	f8043423          	sd	zero,-120(s0)
   10980:	fe042623          	sw	zero,-20(s0)
   10984:	7a40006f          	j	11128 <vprintfmt+0x7cc>
   10988:	f8044783          	lbu	a5,-128(s0)
   1098c:	72078e63          	beqz	a5,110c8 <vprintfmt+0x76c>
   10990:	f5043783          	ld	a5,-176(s0)
   10994:	0007c783          	lbu	a5,0(a5)
   10998:	00078713          	mv	a4,a5
   1099c:	02300793          	li	a5,35
   109a0:	00f71863          	bne	a4,a5,109b0 <vprintfmt+0x54>
   109a4:	00100793          	li	a5,1
   109a8:	f8f40123          	sb	a5,-126(s0)
   109ac:	7700006f          	j	1111c <vprintfmt+0x7c0>
   109b0:	f5043783          	ld	a5,-176(s0)
   109b4:	0007c783          	lbu	a5,0(a5)
   109b8:	00078713          	mv	a4,a5
   109bc:	03000793          	li	a5,48
   109c0:	00f71863          	bne	a4,a5,109d0 <vprintfmt+0x74>
   109c4:	00100793          	li	a5,1
   109c8:	f8f401a3          	sb	a5,-125(s0)
   109cc:	7500006f          	j	1111c <vprintfmt+0x7c0>
   109d0:	f5043783          	ld	a5,-176(s0)
   109d4:	0007c783          	lbu	a5,0(a5)
   109d8:	00078713          	mv	a4,a5
   109dc:	06c00793          	li	a5,108
   109e0:	04f70063          	beq	a4,a5,10a20 <vprintfmt+0xc4>
   109e4:	f5043783          	ld	a5,-176(s0)
   109e8:	0007c783          	lbu	a5,0(a5)
   109ec:	00078713          	mv	a4,a5
   109f0:	07a00793          	li	a5,122
   109f4:	02f70663          	beq	a4,a5,10a20 <vprintfmt+0xc4>
   109f8:	f5043783          	ld	a5,-176(s0)
   109fc:	0007c783          	lbu	a5,0(a5)
   10a00:	00078713          	mv	a4,a5
   10a04:	07400793          	li	a5,116
   10a08:	00f70c63          	beq	a4,a5,10a20 <vprintfmt+0xc4>
   10a0c:	f5043783          	ld	a5,-176(s0)
   10a10:	0007c783          	lbu	a5,0(a5)
   10a14:	00078713          	mv	a4,a5
   10a18:	06a00793          	li	a5,106
   10a1c:	00f71863          	bne	a4,a5,10a2c <vprintfmt+0xd0>
   10a20:	00100793          	li	a5,1
   10a24:	f8f400a3          	sb	a5,-127(s0)
   10a28:	6f40006f          	j	1111c <vprintfmt+0x7c0>
   10a2c:	f5043783          	ld	a5,-176(s0)
   10a30:	0007c783          	lbu	a5,0(a5)
   10a34:	00078713          	mv	a4,a5
   10a38:	02b00793          	li	a5,43
   10a3c:	00f71863          	bne	a4,a5,10a4c <vprintfmt+0xf0>
   10a40:	00100793          	li	a5,1
   10a44:	f8f402a3          	sb	a5,-123(s0)
   10a48:	6d40006f          	j	1111c <vprintfmt+0x7c0>
   10a4c:	f5043783          	ld	a5,-176(s0)
   10a50:	0007c783          	lbu	a5,0(a5)
   10a54:	00078713          	mv	a4,a5
   10a58:	02000793          	li	a5,32
   10a5c:	00f71863          	bne	a4,a5,10a6c <vprintfmt+0x110>
   10a60:	00100793          	li	a5,1
   10a64:	f8f40223          	sb	a5,-124(s0)
   10a68:	6b40006f          	j	1111c <vprintfmt+0x7c0>
   10a6c:	f5043783          	ld	a5,-176(s0)
   10a70:	0007c783          	lbu	a5,0(a5)
   10a74:	00078713          	mv	a4,a5
   10a78:	02a00793          	li	a5,42
   10a7c:	00f71e63          	bne	a4,a5,10a98 <vprintfmt+0x13c>
   10a80:	f4843783          	ld	a5,-184(s0)
   10a84:	00878713          	addi	a4,a5,8
   10a88:	f4e43423          	sd	a4,-184(s0)
   10a8c:	0007a783          	lw	a5,0(a5)
   10a90:	f8f42423          	sw	a5,-120(s0)
   10a94:	6880006f          	j	1111c <vprintfmt+0x7c0>
   10a98:	f5043783          	ld	a5,-176(s0)
   10a9c:	0007c783          	lbu	a5,0(a5)
   10aa0:	00078713          	mv	a4,a5
   10aa4:	03000793          	li	a5,48
   10aa8:	04e7f663          	bgeu	a5,a4,10af4 <vprintfmt+0x198>
   10aac:	f5043783          	ld	a5,-176(s0)
   10ab0:	0007c783          	lbu	a5,0(a5)
   10ab4:	00078713          	mv	a4,a5
   10ab8:	03900793          	li	a5,57
   10abc:	02e7ec63          	bltu	a5,a4,10af4 <vprintfmt+0x198>
   10ac0:	f5043783          	ld	a5,-176(s0)
   10ac4:	f5040713          	addi	a4,s0,-176
   10ac8:	00a00613          	li	a2,10
   10acc:	00070593          	mv	a1,a4
   10ad0:	00078513          	mv	a0,a5
   10ad4:	88dff0ef          	jal	10360 <strtol>
   10ad8:	00050793          	mv	a5,a0
   10adc:	0007879b          	sext.w	a5,a5
   10ae0:	f8f42423          	sw	a5,-120(s0)
   10ae4:	f5043783          	ld	a5,-176(s0)
   10ae8:	fff78793          	addi	a5,a5,-1
   10aec:	f4f43823          	sd	a5,-176(s0)
   10af0:	62c0006f          	j	1111c <vprintfmt+0x7c0>
   10af4:	f5043783          	ld	a5,-176(s0)
   10af8:	0007c783          	lbu	a5,0(a5)
   10afc:	00078713          	mv	a4,a5
   10b00:	02e00793          	li	a5,46
   10b04:	06f71863          	bne	a4,a5,10b74 <vprintfmt+0x218>
   10b08:	f5043783          	ld	a5,-176(s0)
   10b0c:	00178793          	addi	a5,a5,1
   10b10:	f4f43823          	sd	a5,-176(s0)
   10b14:	f5043783          	ld	a5,-176(s0)
   10b18:	0007c783          	lbu	a5,0(a5)
   10b1c:	00078713          	mv	a4,a5
   10b20:	02a00793          	li	a5,42
   10b24:	00f71e63          	bne	a4,a5,10b40 <vprintfmt+0x1e4>
   10b28:	f4843783          	ld	a5,-184(s0)
   10b2c:	00878713          	addi	a4,a5,8
   10b30:	f4e43423          	sd	a4,-184(s0)
   10b34:	0007a783          	lw	a5,0(a5)
   10b38:	f8f42623          	sw	a5,-116(s0)
   10b3c:	5e00006f          	j	1111c <vprintfmt+0x7c0>
   10b40:	f5043783          	ld	a5,-176(s0)
   10b44:	f5040713          	addi	a4,s0,-176
   10b48:	00a00613          	li	a2,10
   10b4c:	00070593          	mv	a1,a4
   10b50:	00078513          	mv	a0,a5
   10b54:	80dff0ef          	jal	10360 <strtol>
   10b58:	00050793          	mv	a5,a0
   10b5c:	0007879b          	sext.w	a5,a5
   10b60:	f8f42623          	sw	a5,-116(s0)
   10b64:	f5043783          	ld	a5,-176(s0)
   10b68:	fff78793          	addi	a5,a5,-1
   10b6c:	f4f43823          	sd	a5,-176(s0)
   10b70:	5ac0006f          	j	1111c <vprintfmt+0x7c0>
   10b74:	f5043783          	ld	a5,-176(s0)
   10b78:	0007c783          	lbu	a5,0(a5)
   10b7c:	00078713          	mv	a4,a5
   10b80:	07800793          	li	a5,120
   10b84:	02f70663          	beq	a4,a5,10bb0 <vprintfmt+0x254>
   10b88:	f5043783          	ld	a5,-176(s0)
   10b8c:	0007c783          	lbu	a5,0(a5)
   10b90:	00078713          	mv	a4,a5
   10b94:	05800793          	li	a5,88
   10b98:	00f70c63          	beq	a4,a5,10bb0 <vprintfmt+0x254>
   10b9c:	f5043783          	ld	a5,-176(s0)
   10ba0:	0007c783          	lbu	a5,0(a5)
   10ba4:	00078713          	mv	a4,a5
   10ba8:	07000793          	li	a5,112
   10bac:	30f71263          	bne	a4,a5,10eb0 <vprintfmt+0x554>
   10bb0:	f5043783          	ld	a5,-176(s0)
   10bb4:	0007c783          	lbu	a5,0(a5)
   10bb8:	00078713          	mv	a4,a5
   10bbc:	07000793          	li	a5,112
   10bc0:	00f70663          	beq	a4,a5,10bcc <vprintfmt+0x270>
   10bc4:	f8144783          	lbu	a5,-127(s0)
   10bc8:	00078663          	beqz	a5,10bd4 <vprintfmt+0x278>
   10bcc:	00100793          	li	a5,1
   10bd0:	0080006f          	j	10bd8 <vprintfmt+0x27c>
   10bd4:	00000793          	li	a5,0
   10bd8:	faf403a3          	sb	a5,-89(s0)
   10bdc:	fa744783          	lbu	a5,-89(s0)
   10be0:	0017f793          	andi	a5,a5,1
   10be4:	faf403a3          	sb	a5,-89(s0)
   10be8:	fa744783          	lbu	a5,-89(s0)
   10bec:	0ff7f793          	zext.b	a5,a5
   10bf0:	00078c63          	beqz	a5,10c08 <vprintfmt+0x2ac>
   10bf4:	f4843783          	ld	a5,-184(s0)
   10bf8:	00878713          	addi	a4,a5,8
   10bfc:	f4e43423          	sd	a4,-184(s0)
   10c00:	0007b783          	ld	a5,0(a5)
   10c04:	01c0006f          	j	10c20 <vprintfmt+0x2c4>
   10c08:	f4843783          	ld	a5,-184(s0)
   10c0c:	00878713          	addi	a4,a5,8
   10c10:	f4e43423          	sd	a4,-184(s0)
   10c14:	0007a783          	lw	a5,0(a5)
   10c18:	02079793          	slli	a5,a5,0x20
   10c1c:	0207d793          	srli	a5,a5,0x20
   10c20:	fef43023          	sd	a5,-32(s0)
   10c24:	f8c42783          	lw	a5,-116(s0)
   10c28:	02079463          	bnez	a5,10c50 <vprintfmt+0x2f4>
   10c2c:	fe043783          	ld	a5,-32(s0)
   10c30:	02079063          	bnez	a5,10c50 <vprintfmt+0x2f4>
   10c34:	f5043783          	ld	a5,-176(s0)
   10c38:	0007c783          	lbu	a5,0(a5)
   10c3c:	00078713          	mv	a4,a5
   10c40:	07000793          	li	a5,112
   10c44:	00f70663          	beq	a4,a5,10c50 <vprintfmt+0x2f4>
   10c48:	f8040023          	sb	zero,-128(s0)
   10c4c:	4d00006f          	j	1111c <vprintfmt+0x7c0>
   10c50:	f5043783          	ld	a5,-176(s0)
   10c54:	0007c783          	lbu	a5,0(a5)
   10c58:	00078713          	mv	a4,a5
   10c5c:	07000793          	li	a5,112
   10c60:	00f70a63          	beq	a4,a5,10c74 <vprintfmt+0x318>
   10c64:	f8244783          	lbu	a5,-126(s0)
   10c68:	00078a63          	beqz	a5,10c7c <vprintfmt+0x320>
   10c6c:	fe043783          	ld	a5,-32(s0)
   10c70:	00078663          	beqz	a5,10c7c <vprintfmt+0x320>
   10c74:	00100793          	li	a5,1
   10c78:	0080006f          	j	10c80 <vprintfmt+0x324>
   10c7c:	00000793          	li	a5,0
   10c80:	faf40323          	sb	a5,-90(s0)
   10c84:	fa644783          	lbu	a5,-90(s0)
   10c88:	0017f793          	andi	a5,a5,1
   10c8c:	faf40323          	sb	a5,-90(s0)
   10c90:	fc042e23          	sw	zero,-36(s0)
   10c94:	f5043783          	ld	a5,-176(s0)
   10c98:	0007c783          	lbu	a5,0(a5)
   10c9c:	00078713          	mv	a4,a5
   10ca0:	05800793          	li	a5,88
   10ca4:	00f71863          	bne	a4,a5,10cb4 <vprintfmt+0x358>
   10ca8:	00000797          	auipc	a5,0x0
   10cac:	61878793          	addi	a5,a5,1560 # 112c0 <upperxdigits.1>
   10cb0:	00c0006f          	j	10cbc <vprintfmt+0x360>
   10cb4:	00000797          	auipc	a5,0x0
   10cb8:	62478793          	addi	a5,a5,1572 # 112d8 <lowerxdigits.0>
   10cbc:	f8f43c23          	sd	a5,-104(s0)
   10cc0:	fe043783          	ld	a5,-32(s0)
   10cc4:	00f7f793          	andi	a5,a5,15
   10cc8:	f9843703          	ld	a4,-104(s0)
   10ccc:	00f70733          	add	a4,a4,a5
   10cd0:	fdc42783          	lw	a5,-36(s0)
   10cd4:	0017869b          	addiw	a3,a5,1
   10cd8:	fcd42e23          	sw	a3,-36(s0)
   10cdc:	00074703          	lbu	a4,0(a4)
   10ce0:	ff078793          	addi	a5,a5,-16
   10ce4:	008787b3          	add	a5,a5,s0
   10ce8:	f8e78023          	sb	a4,-128(a5)
   10cec:	fe043783          	ld	a5,-32(s0)
   10cf0:	0047d793          	srli	a5,a5,0x4
   10cf4:	fef43023          	sd	a5,-32(s0)
   10cf8:	fe043783          	ld	a5,-32(s0)
   10cfc:	fc0792e3          	bnez	a5,10cc0 <vprintfmt+0x364>
   10d00:	f8c42783          	lw	a5,-116(s0)
   10d04:	00078713          	mv	a4,a5
   10d08:	fff00793          	li	a5,-1
   10d0c:	02f71663          	bne	a4,a5,10d38 <vprintfmt+0x3dc>
   10d10:	f8344783          	lbu	a5,-125(s0)
   10d14:	02078263          	beqz	a5,10d38 <vprintfmt+0x3dc>
   10d18:	f8842703          	lw	a4,-120(s0)
   10d1c:	fa644783          	lbu	a5,-90(s0)
   10d20:	0007879b          	sext.w	a5,a5
   10d24:	0017979b          	slliw	a5,a5,0x1
   10d28:	0007879b          	sext.w	a5,a5
   10d2c:	40f707bb          	subw	a5,a4,a5
   10d30:	0007879b          	sext.w	a5,a5
   10d34:	f8f42623          	sw	a5,-116(s0)
   10d38:	f8842703          	lw	a4,-120(s0)
   10d3c:	fa644783          	lbu	a5,-90(s0)
   10d40:	0007879b          	sext.w	a5,a5
   10d44:	0017979b          	slliw	a5,a5,0x1
   10d48:	0007879b          	sext.w	a5,a5
   10d4c:	40f707bb          	subw	a5,a4,a5
   10d50:	0007871b          	sext.w	a4,a5
   10d54:	fdc42783          	lw	a5,-36(s0)
   10d58:	f8f42a23          	sw	a5,-108(s0)
   10d5c:	f8c42783          	lw	a5,-116(s0)
   10d60:	f8f42823          	sw	a5,-112(s0)
   10d64:	f9442783          	lw	a5,-108(s0)
   10d68:	00078593          	mv	a1,a5
   10d6c:	f9042783          	lw	a5,-112(s0)
   10d70:	00078613          	mv	a2,a5
   10d74:	0006069b          	sext.w	a3,a2
   10d78:	0005879b          	sext.w	a5,a1
   10d7c:	00f6d463          	bge	a3,a5,10d84 <vprintfmt+0x428>
   10d80:	00058613          	mv	a2,a1
   10d84:	0006079b          	sext.w	a5,a2
   10d88:	40f707bb          	subw	a5,a4,a5
   10d8c:	fcf42c23          	sw	a5,-40(s0)
   10d90:	0280006f          	j	10db8 <vprintfmt+0x45c>
   10d94:	f5843783          	ld	a5,-168(s0)
   10d98:	02000513          	li	a0,32
   10d9c:	000780e7          	jalr	a5
   10da0:	fec42783          	lw	a5,-20(s0)
   10da4:	0017879b          	addiw	a5,a5,1
   10da8:	fef42623          	sw	a5,-20(s0)
   10dac:	fd842783          	lw	a5,-40(s0)
   10db0:	fff7879b          	addiw	a5,a5,-1
   10db4:	fcf42c23          	sw	a5,-40(s0)
   10db8:	fd842783          	lw	a5,-40(s0)
   10dbc:	0007879b          	sext.w	a5,a5
   10dc0:	fcf04ae3          	bgtz	a5,10d94 <vprintfmt+0x438>
   10dc4:	fa644783          	lbu	a5,-90(s0)
   10dc8:	0ff7f793          	zext.b	a5,a5
   10dcc:	04078463          	beqz	a5,10e14 <vprintfmt+0x4b8>
   10dd0:	f5843783          	ld	a5,-168(s0)
   10dd4:	03000513          	li	a0,48
   10dd8:	000780e7          	jalr	a5
   10ddc:	f5043783          	ld	a5,-176(s0)
   10de0:	0007c783          	lbu	a5,0(a5)
   10de4:	00078713          	mv	a4,a5
   10de8:	05800793          	li	a5,88
   10dec:	00f71663          	bne	a4,a5,10df8 <vprintfmt+0x49c>
   10df0:	05800793          	li	a5,88
   10df4:	0080006f          	j	10dfc <vprintfmt+0x4a0>
   10df8:	07800793          	li	a5,120
   10dfc:	f5843703          	ld	a4,-168(s0)
   10e00:	00078513          	mv	a0,a5
   10e04:	000700e7          	jalr	a4
   10e08:	fec42783          	lw	a5,-20(s0)
   10e0c:	0027879b          	addiw	a5,a5,2
   10e10:	fef42623          	sw	a5,-20(s0)
   10e14:	fdc42783          	lw	a5,-36(s0)
   10e18:	fcf42a23          	sw	a5,-44(s0)
   10e1c:	0280006f          	j	10e44 <vprintfmt+0x4e8>
   10e20:	f5843783          	ld	a5,-168(s0)
   10e24:	03000513          	li	a0,48
   10e28:	000780e7          	jalr	a5
   10e2c:	fec42783          	lw	a5,-20(s0)
   10e30:	0017879b          	addiw	a5,a5,1
   10e34:	fef42623          	sw	a5,-20(s0)
   10e38:	fd442783          	lw	a5,-44(s0)
   10e3c:	0017879b          	addiw	a5,a5,1
   10e40:	fcf42a23          	sw	a5,-44(s0)
   10e44:	f8c42703          	lw	a4,-116(s0)
   10e48:	fd442783          	lw	a5,-44(s0)
   10e4c:	0007879b          	sext.w	a5,a5
   10e50:	fce7c8e3          	blt	a5,a4,10e20 <vprintfmt+0x4c4>
   10e54:	fdc42783          	lw	a5,-36(s0)
   10e58:	fff7879b          	addiw	a5,a5,-1
   10e5c:	fcf42823          	sw	a5,-48(s0)
   10e60:	03c0006f          	j	10e9c <vprintfmt+0x540>
   10e64:	fd042783          	lw	a5,-48(s0)
   10e68:	ff078793          	addi	a5,a5,-16
   10e6c:	008787b3          	add	a5,a5,s0
   10e70:	f807c783          	lbu	a5,-128(a5)
   10e74:	0007871b          	sext.w	a4,a5
   10e78:	f5843783          	ld	a5,-168(s0)
   10e7c:	00070513          	mv	a0,a4
   10e80:	000780e7          	jalr	a5
   10e84:	fec42783          	lw	a5,-20(s0)
   10e88:	0017879b          	addiw	a5,a5,1
   10e8c:	fef42623          	sw	a5,-20(s0)
   10e90:	fd042783          	lw	a5,-48(s0)
   10e94:	fff7879b          	addiw	a5,a5,-1
   10e98:	fcf42823          	sw	a5,-48(s0)
   10e9c:	fd042783          	lw	a5,-48(s0)
   10ea0:	0007879b          	sext.w	a5,a5
   10ea4:	fc07d0e3          	bgez	a5,10e64 <vprintfmt+0x508>
   10ea8:	f8040023          	sb	zero,-128(s0)
   10eac:	2700006f          	j	1111c <vprintfmt+0x7c0>
   10eb0:	f5043783          	ld	a5,-176(s0)
   10eb4:	0007c783          	lbu	a5,0(a5)
   10eb8:	00078713          	mv	a4,a5
   10ebc:	06400793          	li	a5,100
   10ec0:	02f70663          	beq	a4,a5,10eec <vprintfmt+0x590>
   10ec4:	f5043783          	ld	a5,-176(s0)
   10ec8:	0007c783          	lbu	a5,0(a5)
   10ecc:	00078713          	mv	a4,a5
   10ed0:	06900793          	li	a5,105
   10ed4:	00f70c63          	beq	a4,a5,10eec <vprintfmt+0x590>
   10ed8:	f5043783          	ld	a5,-176(s0)
   10edc:	0007c783          	lbu	a5,0(a5)
   10ee0:	00078713          	mv	a4,a5
   10ee4:	07500793          	li	a5,117
   10ee8:	08f71063          	bne	a4,a5,10f68 <vprintfmt+0x60c>
   10eec:	f8144783          	lbu	a5,-127(s0)
   10ef0:	00078c63          	beqz	a5,10f08 <vprintfmt+0x5ac>
   10ef4:	f4843783          	ld	a5,-184(s0)
   10ef8:	00878713          	addi	a4,a5,8
   10efc:	f4e43423          	sd	a4,-184(s0)
   10f00:	0007b783          	ld	a5,0(a5)
   10f04:	0140006f          	j	10f18 <vprintfmt+0x5bc>
   10f08:	f4843783          	ld	a5,-184(s0)
   10f0c:	00878713          	addi	a4,a5,8
   10f10:	f4e43423          	sd	a4,-184(s0)
   10f14:	0007a783          	lw	a5,0(a5)
   10f18:	faf43423          	sd	a5,-88(s0)
   10f1c:	fa843583          	ld	a1,-88(s0)
   10f20:	f5043783          	ld	a5,-176(s0)
   10f24:	0007c783          	lbu	a5,0(a5)
   10f28:	0007871b          	sext.w	a4,a5
   10f2c:	07500793          	li	a5,117
   10f30:	40f707b3          	sub	a5,a4,a5
   10f34:	00f037b3          	snez	a5,a5
   10f38:	0ff7f793          	zext.b	a5,a5
   10f3c:	f8040713          	addi	a4,s0,-128
   10f40:	00070693          	mv	a3,a4
   10f44:	00078613          	mv	a2,a5
   10f48:	f5843503          	ld	a0,-168(s0)
   10f4c:	f08ff0ef          	jal	10654 <print_dec_int>
   10f50:	00050793          	mv	a5,a0
   10f54:	fec42703          	lw	a4,-20(s0)
   10f58:	00f707bb          	addw	a5,a4,a5
   10f5c:	fef42623          	sw	a5,-20(s0)
   10f60:	f8040023          	sb	zero,-128(s0)
   10f64:	1b80006f          	j	1111c <vprintfmt+0x7c0>
   10f68:	f5043783          	ld	a5,-176(s0)
   10f6c:	0007c783          	lbu	a5,0(a5)
   10f70:	00078713          	mv	a4,a5
   10f74:	06e00793          	li	a5,110
   10f78:	04f71c63          	bne	a4,a5,10fd0 <vprintfmt+0x674>
   10f7c:	f8144783          	lbu	a5,-127(s0)
   10f80:	02078463          	beqz	a5,10fa8 <vprintfmt+0x64c>
   10f84:	f4843783          	ld	a5,-184(s0)
   10f88:	00878713          	addi	a4,a5,8
   10f8c:	f4e43423          	sd	a4,-184(s0)
   10f90:	0007b783          	ld	a5,0(a5)
   10f94:	faf43823          	sd	a5,-80(s0)
   10f98:	fec42703          	lw	a4,-20(s0)
   10f9c:	fb043783          	ld	a5,-80(s0)
   10fa0:	00e7b023          	sd	a4,0(a5)
   10fa4:	0240006f          	j	10fc8 <vprintfmt+0x66c>
   10fa8:	f4843783          	ld	a5,-184(s0)
   10fac:	00878713          	addi	a4,a5,8
   10fb0:	f4e43423          	sd	a4,-184(s0)
   10fb4:	0007b783          	ld	a5,0(a5)
   10fb8:	faf43c23          	sd	a5,-72(s0)
   10fbc:	fb843783          	ld	a5,-72(s0)
   10fc0:	fec42703          	lw	a4,-20(s0)
   10fc4:	00e7a023          	sw	a4,0(a5)
   10fc8:	f8040023          	sb	zero,-128(s0)
   10fcc:	1500006f          	j	1111c <vprintfmt+0x7c0>
   10fd0:	f5043783          	ld	a5,-176(s0)
   10fd4:	0007c783          	lbu	a5,0(a5)
   10fd8:	00078713          	mv	a4,a5
   10fdc:	07300793          	li	a5,115
   10fe0:	02f71e63          	bne	a4,a5,1101c <vprintfmt+0x6c0>
   10fe4:	f4843783          	ld	a5,-184(s0)
   10fe8:	00878713          	addi	a4,a5,8
   10fec:	f4e43423          	sd	a4,-184(s0)
   10ff0:	0007b783          	ld	a5,0(a5)
   10ff4:	fcf43023          	sd	a5,-64(s0)
   10ff8:	fc043583          	ld	a1,-64(s0)
   10ffc:	f5843503          	ld	a0,-168(s0)
   11000:	dccff0ef          	jal	105cc <puts_wo_nl>
   11004:	00050793          	mv	a5,a0
   11008:	fec42703          	lw	a4,-20(s0)
   1100c:	00f707bb          	addw	a5,a4,a5
   11010:	fef42623          	sw	a5,-20(s0)
   11014:	f8040023          	sb	zero,-128(s0)
   11018:	1040006f          	j	1111c <vprintfmt+0x7c0>
   1101c:	f5043783          	ld	a5,-176(s0)
   11020:	0007c783          	lbu	a5,0(a5)
   11024:	00078713          	mv	a4,a5
   11028:	06300793          	li	a5,99
   1102c:	02f71e63          	bne	a4,a5,11068 <vprintfmt+0x70c>
   11030:	f4843783          	ld	a5,-184(s0)
   11034:	00878713          	addi	a4,a5,8
   11038:	f4e43423          	sd	a4,-184(s0)
   1103c:	0007a783          	lw	a5,0(a5)
   11040:	fcf42623          	sw	a5,-52(s0)
   11044:	fcc42703          	lw	a4,-52(s0)
   11048:	f5843783          	ld	a5,-168(s0)
   1104c:	00070513          	mv	a0,a4
   11050:	000780e7          	jalr	a5
   11054:	fec42783          	lw	a5,-20(s0)
   11058:	0017879b          	addiw	a5,a5,1
   1105c:	fef42623          	sw	a5,-20(s0)
   11060:	f8040023          	sb	zero,-128(s0)
   11064:	0b80006f          	j	1111c <vprintfmt+0x7c0>
   11068:	f5043783          	ld	a5,-176(s0)
   1106c:	0007c783          	lbu	a5,0(a5)
   11070:	00078713          	mv	a4,a5
   11074:	02500793          	li	a5,37
   11078:	02f71263          	bne	a4,a5,1109c <vprintfmt+0x740>
   1107c:	f5843783          	ld	a5,-168(s0)
   11080:	02500513          	li	a0,37
   11084:	000780e7          	jalr	a5
   11088:	fec42783          	lw	a5,-20(s0)
   1108c:	0017879b          	addiw	a5,a5,1
   11090:	fef42623          	sw	a5,-20(s0)
   11094:	f8040023          	sb	zero,-128(s0)
   11098:	0840006f          	j	1111c <vprintfmt+0x7c0>
   1109c:	f5043783          	ld	a5,-176(s0)
   110a0:	0007c783          	lbu	a5,0(a5)
   110a4:	0007871b          	sext.w	a4,a5
   110a8:	f5843783          	ld	a5,-168(s0)
   110ac:	00070513          	mv	a0,a4
   110b0:	000780e7          	jalr	a5
   110b4:	fec42783          	lw	a5,-20(s0)
   110b8:	0017879b          	addiw	a5,a5,1
   110bc:	fef42623          	sw	a5,-20(s0)
   110c0:	f8040023          	sb	zero,-128(s0)
   110c4:	0580006f          	j	1111c <vprintfmt+0x7c0>
   110c8:	f5043783          	ld	a5,-176(s0)
   110cc:	0007c783          	lbu	a5,0(a5)
   110d0:	00078713          	mv	a4,a5
   110d4:	02500793          	li	a5,37
   110d8:	02f71063          	bne	a4,a5,110f8 <vprintfmt+0x79c>
   110dc:	f8043023          	sd	zero,-128(s0)
   110e0:	f8043423          	sd	zero,-120(s0)
   110e4:	00100793          	li	a5,1
   110e8:	f8f40023          	sb	a5,-128(s0)
   110ec:	fff00793          	li	a5,-1
   110f0:	f8f42623          	sw	a5,-116(s0)
   110f4:	0280006f          	j	1111c <vprintfmt+0x7c0>
   110f8:	f5043783          	ld	a5,-176(s0)
   110fc:	0007c783          	lbu	a5,0(a5)
   11100:	0007871b          	sext.w	a4,a5
   11104:	f5843783          	ld	a5,-168(s0)
   11108:	00070513          	mv	a0,a4
   1110c:	000780e7          	jalr	a5
   11110:	fec42783          	lw	a5,-20(s0)
   11114:	0017879b          	addiw	a5,a5,1
   11118:	fef42623          	sw	a5,-20(s0)
   1111c:	f5043783          	ld	a5,-176(s0)
   11120:	00178793          	addi	a5,a5,1
   11124:	f4f43823          	sd	a5,-176(s0)
   11128:	f5043783          	ld	a5,-176(s0)
   1112c:	0007c783          	lbu	a5,0(a5)
   11130:	84079ce3          	bnez	a5,10988 <vprintfmt+0x2c>
   11134:	fec42783          	lw	a5,-20(s0)
   11138:	00078513          	mv	a0,a5
   1113c:	0b813083          	ld	ra,184(sp)
   11140:	0b013403          	ld	s0,176(sp)
   11144:	0c010113          	addi	sp,sp,192
   11148:	00008067          	ret

000000000001114c <printf>:
   1114c:	f8010113          	addi	sp,sp,-128
   11150:	02113c23          	sd	ra,56(sp)
   11154:	02813823          	sd	s0,48(sp)
   11158:	04010413          	addi	s0,sp,64
   1115c:	fca43423          	sd	a0,-56(s0)
   11160:	00b43423          	sd	a1,8(s0)
   11164:	00c43823          	sd	a2,16(s0)
   11168:	00d43c23          	sd	a3,24(s0)
   1116c:	02e43023          	sd	a4,32(s0)
   11170:	02f43423          	sd	a5,40(s0)
   11174:	03043823          	sd	a6,48(s0)
   11178:	03143c23          	sd	a7,56(s0)
   1117c:	fe042623          	sw	zero,-20(s0)
   11180:	04040793          	addi	a5,s0,64
   11184:	fcf43023          	sd	a5,-64(s0)
   11188:	fc043783          	ld	a5,-64(s0)
   1118c:	fc878793          	addi	a5,a5,-56
   11190:	fcf43823          	sd	a5,-48(s0)
   11194:	fd043783          	ld	a5,-48(s0)
   11198:	00078613          	mv	a2,a5
   1119c:	fc843583          	ld	a1,-56(s0)
   111a0:	fffff517          	auipc	a0,0xfffff
   111a4:	0f850513          	addi	a0,a0,248 # 10298 <putc>
   111a8:	fb4ff0ef          	jal	1095c <vprintfmt>
   111ac:	00050793          	mv	a5,a0
   111b0:	fef42623          	sw	a5,-20(s0)
   111b4:	00100793          	li	a5,1
   111b8:	fef43023          	sd	a5,-32(s0)
   111bc:	00001797          	auipc	a5,0x1
   111c0:	e4878793          	addi	a5,a5,-440 # 12004 <tail>
   111c4:	0007a783          	lw	a5,0(a5)
   111c8:	0017871b          	addiw	a4,a5,1
   111cc:	0007069b          	sext.w	a3,a4
   111d0:	00001717          	auipc	a4,0x1
   111d4:	e3470713          	addi	a4,a4,-460 # 12004 <tail>
   111d8:	00d72023          	sw	a3,0(a4)
   111dc:	00001717          	auipc	a4,0x1
   111e0:	e2c70713          	addi	a4,a4,-468 # 12008 <buffer>
   111e4:	00f707b3          	add	a5,a4,a5
   111e8:	00078023          	sb	zero,0(a5)
   111ec:	00001797          	auipc	a5,0x1
   111f0:	e1878793          	addi	a5,a5,-488 # 12004 <tail>
   111f4:	0007a603          	lw	a2,0(a5)
   111f8:	fe043703          	ld	a4,-32(s0)
   111fc:	00001697          	auipc	a3,0x1
   11200:	e0c68693          	addi	a3,a3,-500 # 12008 <buffer>
   11204:	fd843783          	ld	a5,-40(s0)
   11208:	04000893          	li	a7,64
   1120c:	00070513          	mv	a0,a4
   11210:	00068593          	mv	a1,a3
   11214:	00060613          	mv	a2,a2
   11218:	00000073          	ecall
   1121c:	00050793          	mv	a5,a0
   11220:	fcf43c23          	sd	a5,-40(s0)
   11224:	00001797          	auipc	a5,0x1
   11228:	de078793          	addi	a5,a5,-544 # 12004 <tail>
   1122c:	0007a023          	sw	zero,0(a5)
   11230:	fec42783          	lw	a5,-20(s0)
   11234:	00078513          	mv	a0,a5
   11238:	03813083          	ld	ra,56(sp)
   1123c:	03013403          	ld	s0,48(sp)
   11240:	08010113          	addi	sp,sp,128
   11244:	00008067          	ret
