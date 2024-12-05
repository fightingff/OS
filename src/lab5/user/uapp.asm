
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
   1014c:	0e850513          	addi	a0,a0,232 # 11230 <printf+0x100>
   10150:	7e1000ef          	jal	11130 <printf>
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
   101c0:	fe010113          	addi	sp,sp,-32
   101c4:	00113c23          	sd	ra,24(sp)
   101c8:	00813823          	sd	s0,16(sp)
   101cc:	02010413          	addi	s0,sp,32
   101d0:	f51ff0ef          	jal	10120 <fork>
   101d4:	00050793          	mv	a5,a0
   101d8:	fef42623          	sw	a5,-20(s0)
   101dc:	fec42783          	lw	a5,-20(s0)
   101e0:	0007879b          	sext.w	a5,a5
   101e4:	04079863          	bnez	a5,10234 <main+0x74>
   101e8:	f05ff0ef          	jal	100ec <getpid>
   101ec:	00050593          	mv	a1,a0
   101f0:	00002797          	auipc	a5,0x2
   101f4:	e1078793          	addi	a5,a5,-496 # 12000 <global_variable>
   101f8:	0007a783          	lw	a5,0(a5)
   101fc:	0017871b          	addiw	a4,a5,1
   10200:	0007069b          	sext.w	a3,a4
   10204:	00002717          	auipc	a4,0x2
   10208:	dfc70713          	addi	a4,a4,-516 # 12000 <global_variable>
   1020c:	00d72023          	sw	a3,0(a4)
   10210:	00078613          	mv	a2,a5
   10214:	00001517          	auipc	a0,0x1
   10218:	04450513          	addi	a0,a0,68 # 11258 <printf+0x128>
   1021c:	715000ef          	jal	11130 <printf>
   10220:	500007b7          	lui	a5,0x50000
   10224:	fff78513          	addi	a0,a5,-1 # 4fffffff <__global_pointer$+0x4ffed7ff>
   10228:	f45ff0ef          	jal	1016c <wait>
   1022c:	00000013          	nop
   10230:	fb9ff06f          	j	101e8 <main+0x28>
   10234:	eb9ff0ef          	jal	100ec <getpid>
   10238:	00050593          	mv	a1,a0
   1023c:	00002797          	auipc	a5,0x2
   10240:	dc478793          	addi	a5,a5,-572 # 12000 <global_variable>
   10244:	0007a783          	lw	a5,0(a5)
   10248:	0017871b          	addiw	a4,a5,1
   1024c:	0007069b          	sext.w	a3,a4
   10250:	00002717          	auipc	a4,0x2
   10254:	db070713          	addi	a4,a4,-592 # 12000 <global_variable>
   10258:	00d72023          	sw	a3,0(a4)
   1025c:	00078613          	mv	a2,a5
   10260:	00001517          	auipc	a0,0x1
   10264:	03050513          	addi	a0,a0,48 # 11290 <printf+0x160>
   10268:	6c9000ef          	jal	11130 <printf>
   1026c:	500007b7          	lui	a5,0x50000
   10270:	fff78513          	addi	a0,a5,-1 # 4fffffff <__global_pointer$+0x4ffed7ff>
   10274:	ef9ff0ef          	jal	1016c <wait>
   10278:	fbdff06f          	j	10234 <main+0x74>

000000000001027c <putc>:
   1027c:	fe010113          	addi	sp,sp,-32
   10280:	00813c23          	sd	s0,24(sp)
   10284:	02010413          	addi	s0,sp,32
   10288:	00050793          	mv	a5,a0
   1028c:	fef42623          	sw	a5,-20(s0)
   10290:	00002797          	auipc	a5,0x2
   10294:	d7478793          	addi	a5,a5,-652 # 12004 <tail>
   10298:	0007a783          	lw	a5,0(a5)
   1029c:	0017871b          	addiw	a4,a5,1
   102a0:	0007069b          	sext.w	a3,a4
   102a4:	00002717          	auipc	a4,0x2
   102a8:	d6070713          	addi	a4,a4,-672 # 12004 <tail>
   102ac:	00d72023          	sw	a3,0(a4)
   102b0:	fec42703          	lw	a4,-20(s0)
   102b4:	0ff77713          	zext.b	a4,a4
   102b8:	00002697          	auipc	a3,0x2
   102bc:	d5068693          	addi	a3,a3,-688 # 12008 <buffer>
   102c0:	00f687b3          	add	a5,a3,a5
   102c4:	00e78023          	sb	a4,0(a5)
   102c8:	fec42783          	lw	a5,-20(s0)
   102cc:	0ff7f793          	zext.b	a5,a5
   102d0:	0007879b          	sext.w	a5,a5
   102d4:	00078513          	mv	a0,a5
   102d8:	01813403          	ld	s0,24(sp)
   102dc:	02010113          	addi	sp,sp,32
   102e0:	00008067          	ret

00000000000102e4 <isspace>:
   102e4:	fe010113          	addi	sp,sp,-32
   102e8:	00813c23          	sd	s0,24(sp)
   102ec:	02010413          	addi	s0,sp,32
   102f0:	00050793          	mv	a5,a0
   102f4:	fef42623          	sw	a5,-20(s0)
   102f8:	fec42783          	lw	a5,-20(s0)
   102fc:	0007871b          	sext.w	a4,a5
   10300:	02000793          	li	a5,32
   10304:	02f70263          	beq	a4,a5,10328 <isspace+0x44>
   10308:	fec42783          	lw	a5,-20(s0)
   1030c:	0007871b          	sext.w	a4,a5
   10310:	00800793          	li	a5,8
   10314:	00e7de63          	bge	a5,a4,10330 <isspace+0x4c>
   10318:	fec42783          	lw	a5,-20(s0)
   1031c:	0007871b          	sext.w	a4,a5
   10320:	00d00793          	li	a5,13
   10324:	00e7c663          	blt	a5,a4,10330 <isspace+0x4c>
   10328:	00100793          	li	a5,1
   1032c:	0080006f          	j	10334 <isspace+0x50>
   10330:	00000793          	li	a5,0
   10334:	00078513          	mv	a0,a5
   10338:	01813403          	ld	s0,24(sp)
   1033c:	02010113          	addi	sp,sp,32
   10340:	00008067          	ret

0000000000010344 <strtol>:
   10344:	fb010113          	addi	sp,sp,-80
   10348:	04113423          	sd	ra,72(sp)
   1034c:	04813023          	sd	s0,64(sp)
   10350:	05010413          	addi	s0,sp,80
   10354:	fca43423          	sd	a0,-56(s0)
   10358:	fcb43023          	sd	a1,-64(s0)
   1035c:	00060793          	mv	a5,a2
   10360:	faf42e23          	sw	a5,-68(s0)
   10364:	fe043423          	sd	zero,-24(s0)
   10368:	fe0403a3          	sb	zero,-25(s0)
   1036c:	fc843783          	ld	a5,-56(s0)
   10370:	fcf43c23          	sd	a5,-40(s0)
   10374:	0100006f          	j	10384 <strtol+0x40>
   10378:	fd843783          	ld	a5,-40(s0)
   1037c:	00178793          	addi	a5,a5,1
   10380:	fcf43c23          	sd	a5,-40(s0)
   10384:	fd843783          	ld	a5,-40(s0)
   10388:	0007c783          	lbu	a5,0(a5)
   1038c:	0007879b          	sext.w	a5,a5
   10390:	00078513          	mv	a0,a5
   10394:	f51ff0ef          	jal	102e4 <isspace>
   10398:	00050793          	mv	a5,a0
   1039c:	fc079ee3          	bnez	a5,10378 <strtol+0x34>
   103a0:	fd843783          	ld	a5,-40(s0)
   103a4:	0007c783          	lbu	a5,0(a5)
   103a8:	00078713          	mv	a4,a5
   103ac:	02d00793          	li	a5,45
   103b0:	00f71e63          	bne	a4,a5,103cc <strtol+0x88>
   103b4:	00100793          	li	a5,1
   103b8:	fef403a3          	sb	a5,-25(s0)
   103bc:	fd843783          	ld	a5,-40(s0)
   103c0:	00178793          	addi	a5,a5,1
   103c4:	fcf43c23          	sd	a5,-40(s0)
   103c8:	0240006f          	j	103ec <strtol+0xa8>
   103cc:	fd843783          	ld	a5,-40(s0)
   103d0:	0007c783          	lbu	a5,0(a5)
   103d4:	00078713          	mv	a4,a5
   103d8:	02b00793          	li	a5,43
   103dc:	00f71863          	bne	a4,a5,103ec <strtol+0xa8>
   103e0:	fd843783          	ld	a5,-40(s0)
   103e4:	00178793          	addi	a5,a5,1
   103e8:	fcf43c23          	sd	a5,-40(s0)
   103ec:	fbc42783          	lw	a5,-68(s0)
   103f0:	0007879b          	sext.w	a5,a5
   103f4:	06079c63          	bnez	a5,1046c <strtol+0x128>
   103f8:	fd843783          	ld	a5,-40(s0)
   103fc:	0007c783          	lbu	a5,0(a5)
   10400:	00078713          	mv	a4,a5
   10404:	03000793          	li	a5,48
   10408:	04f71e63          	bne	a4,a5,10464 <strtol+0x120>
   1040c:	fd843783          	ld	a5,-40(s0)
   10410:	00178793          	addi	a5,a5,1
   10414:	fcf43c23          	sd	a5,-40(s0)
   10418:	fd843783          	ld	a5,-40(s0)
   1041c:	0007c783          	lbu	a5,0(a5)
   10420:	00078713          	mv	a4,a5
   10424:	07800793          	li	a5,120
   10428:	00f70c63          	beq	a4,a5,10440 <strtol+0xfc>
   1042c:	fd843783          	ld	a5,-40(s0)
   10430:	0007c783          	lbu	a5,0(a5)
   10434:	00078713          	mv	a4,a5
   10438:	05800793          	li	a5,88
   1043c:	00f71e63          	bne	a4,a5,10458 <strtol+0x114>
   10440:	01000793          	li	a5,16
   10444:	faf42e23          	sw	a5,-68(s0)
   10448:	fd843783          	ld	a5,-40(s0)
   1044c:	00178793          	addi	a5,a5,1
   10450:	fcf43c23          	sd	a5,-40(s0)
   10454:	0180006f          	j	1046c <strtol+0x128>
   10458:	00800793          	li	a5,8
   1045c:	faf42e23          	sw	a5,-68(s0)
   10460:	00c0006f          	j	1046c <strtol+0x128>
   10464:	00a00793          	li	a5,10
   10468:	faf42e23          	sw	a5,-68(s0)
   1046c:	fd843783          	ld	a5,-40(s0)
   10470:	0007c783          	lbu	a5,0(a5)
   10474:	00078713          	mv	a4,a5
   10478:	02f00793          	li	a5,47
   1047c:	02e7f863          	bgeu	a5,a4,104ac <strtol+0x168>
   10480:	fd843783          	ld	a5,-40(s0)
   10484:	0007c783          	lbu	a5,0(a5)
   10488:	00078713          	mv	a4,a5
   1048c:	03900793          	li	a5,57
   10490:	00e7ee63          	bltu	a5,a4,104ac <strtol+0x168>
   10494:	fd843783          	ld	a5,-40(s0)
   10498:	0007c783          	lbu	a5,0(a5)
   1049c:	0007879b          	sext.w	a5,a5
   104a0:	fd07879b          	addiw	a5,a5,-48
   104a4:	fcf42a23          	sw	a5,-44(s0)
   104a8:	0800006f          	j	10528 <strtol+0x1e4>
   104ac:	fd843783          	ld	a5,-40(s0)
   104b0:	0007c783          	lbu	a5,0(a5)
   104b4:	00078713          	mv	a4,a5
   104b8:	06000793          	li	a5,96
   104bc:	02e7f863          	bgeu	a5,a4,104ec <strtol+0x1a8>
   104c0:	fd843783          	ld	a5,-40(s0)
   104c4:	0007c783          	lbu	a5,0(a5)
   104c8:	00078713          	mv	a4,a5
   104cc:	07a00793          	li	a5,122
   104d0:	00e7ee63          	bltu	a5,a4,104ec <strtol+0x1a8>
   104d4:	fd843783          	ld	a5,-40(s0)
   104d8:	0007c783          	lbu	a5,0(a5)
   104dc:	0007879b          	sext.w	a5,a5
   104e0:	fa97879b          	addiw	a5,a5,-87
   104e4:	fcf42a23          	sw	a5,-44(s0)
   104e8:	0400006f          	j	10528 <strtol+0x1e4>
   104ec:	fd843783          	ld	a5,-40(s0)
   104f0:	0007c783          	lbu	a5,0(a5)
   104f4:	00078713          	mv	a4,a5
   104f8:	04000793          	li	a5,64
   104fc:	06e7f863          	bgeu	a5,a4,1056c <strtol+0x228>
   10500:	fd843783          	ld	a5,-40(s0)
   10504:	0007c783          	lbu	a5,0(a5)
   10508:	00078713          	mv	a4,a5
   1050c:	05a00793          	li	a5,90
   10510:	04e7ee63          	bltu	a5,a4,1056c <strtol+0x228>
   10514:	fd843783          	ld	a5,-40(s0)
   10518:	0007c783          	lbu	a5,0(a5)
   1051c:	0007879b          	sext.w	a5,a5
   10520:	fc97879b          	addiw	a5,a5,-55
   10524:	fcf42a23          	sw	a5,-44(s0)
   10528:	fd442783          	lw	a5,-44(s0)
   1052c:	00078713          	mv	a4,a5
   10530:	fbc42783          	lw	a5,-68(s0)
   10534:	0007071b          	sext.w	a4,a4
   10538:	0007879b          	sext.w	a5,a5
   1053c:	02f75663          	bge	a4,a5,10568 <strtol+0x224>
   10540:	fbc42703          	lw	a4,-68(s0)
   10544:	fe843783          	ld	a5,-24(s0)
   10548:	02f70733          	mul	a4,a4,a5
   1054c:	fd442783          	lw	a5,-44(s0)
   10550:	00f707b3          	add	a5,a4,a5
   10554:	fef43423          	sd	a5,-24(s0)
   10558:	fd843783          	ld	a5,-40(s0)
   1055c:	00178793          	addi	a5,a5,1
   10560:	fcf43c23          	sd	a5,-40(s0)
   10564:	f09ff06f          	j	1046c <strtol+0x128>
   10568:	00000013          	nop
   1056c:	fc043783          	ld	a5,-64(s0)
   10570:	00078863          	beqz	a5,10580 <strtol+0x23c>
   10574:	fc043783          	ld	a5,-64(s0)
   10578:	fd843703          	ld	a4,-40(s0)
   1057c:	00e7b023          	sd	a4,0(a5)
   10580:	fe744783          	lbu	a5,-25(s0)
   10584:	0ff7f793          	zext.b	a5,a5
   10588:	00078863          	beqz	a5,10598 <strtol+0x254>
   1058c:	fe843783          	ld	a5,-24(s0)
   10590:	40f007b3          	neg	a5,a5
   10594:	0080006f          	j	1059c <strtol+0x258>
   10598:	fe843783          	ld	a5,-24(s0)
   1059c:	00078513          	mv	a0,a5
   105a0:	04813083          	ld	ra,72(sp)
   105a4:	04013403          	ld	s0,64(sp)
   105a8:	05010113          	addi	sp,sp,80
   105ac:	00008067          	ret

00000000000105b0 <puts_wo_nl>:
   105b0:	fd010113          	addi	sp,sp,-48
   105b4:	02113423          	sd	ra,40(sp)
   105b8:	02813023          	sd	s0,32(sp)
   105bc:	03010413          	addi	s0,sp,48
   105c0:	fca43c23          	sd	a0,-40(s0)
   105c4:	fcb43823          	sd	a1,-48(s0)
   105c8:	fd043783          	ld	a5,-48(s0)
   105cc:	00079863          	bnez	a5,105dc <puts_wo_nl+0x2c>
   105d0:	00001797          	auipc	a5,0x1
   105d4:	cf878793          	addi	a5,a5,-776 # 112c8 <printf+0x198>
   105d8:	fcf43823          	sd	a5,-48(s0)
   105dc:	fd043783          	ld	a5,-48(s0)
   105e0:	fef43423          	sd	a5,-24(s0)
   105e4:	0240006f          	j	10608 <puts_wo_nl+0x58>
   105e8:	fe843783          	ld	a5,-24(s0)
   105ec:	00178713          	addi	a4,a5,1
   105f0:	fee43423          	sd	a4,-24(s0)
   105f4:	0007c783          	lbu	a5,0(a5)
   105f8:	0007871b          	sext.w	a4,a5
   105fc:	fd843783          	ld	a5,-40(s0)
   10600:	00070513          	mv	a0,a4
   10604:	000780e7          	jalr	a5
   10608:	fe843783          	ld	a5,-24(s0)
   1060c:	0007c783          	lbu	a5,0(a5)
   10610:	fc079ce3          	bnez	a5,105e8 <puts_wo_nl+0x38>
   10614:	fe843703          	ld	a4,-24(s0)
   10618:	fd043783          	ld	a5,-48(s0)
   1061c:	40f707b3          	sub	a5,a4,a5
   10620:	0007879b          	sext.w	a5,a5
   10624:	00078513          	mv	a0,a5
   10628:	02813083          	ld	ra,40(sp)
   1062c:	02013403          	ld	s0,32(sp)
   10630:	03010113          	addi	sp,sp,48
   10634:	00008067          	ret

0000000000010638 <print_dec_int>:
   10638:	f9010113          	addi	sp,sp,-112
   1063c:	06113423          	sd	ra,104(sp)
   10640:	06813023          	sd	s0,96(sp)
   10644:	07010413          	addi	s0,sp,112
   10648:	faa43423          	sd	a0,-88(s0)
   1064c:	fab43023          	sd	a1,-96(s0)
   10650:	00060793          	mv	a5,a2
   10654:	f8d43823          	sd	a3,-112(s0)
   10658:	f8f40fa3          	sb	a5,-97(s0)
   1065c:	f9f44783          	lbu	a5,-97(s0)
   10660:	0ff7f793          	zext.b	a5,a5
   10664:	02078663          	beqz	a5,10690 <print_dec_int+0x58>
   10668:	fa043703          	ld	a4,-96(s0)
   1066c:	fff00793          	li	a5,-1
   10670:	03f79793          	slli	a5,a5,0x3f
   10674:	00f71e63          	bne	a4,a5,10690 <print_dec_int+0x58>
   10678:	00001597          	auipc	a1,0x1
   1067c:	c5858593          	addi	a1,a1,-936 # 112d0 <printf+0x1a0>
   10680:	fa843503          	ld	a0,-88(s0)
   10684:	f2dff0ef          	jal	105b0 <puts_wo_nl>
   10688:	00050793          	mv	a5,a0
   1068c:	2a00006f          	j	1092c <print_dec_int+0x2f4>
   10690:	f9043783          	ld	a5,-112(s0)
   10694:	00c7a783          	lw	a5,12(a5)
   10698:	00079a63          	bnez	a5,106ac <print_dec_int+0x74>
   1069c:	fa043783          	ld	a5,-96(s0)
   106a0:	00079663          	bnez	a5,106ac <print_dec_int+0x74>
   106a4:	00000793          	li	a5,0
   106a8:	2840006f          	j	1092c <print_dec_int+0x2f4>
   106ac:	fe0407a3          	sb	zero,-17(s0)
   106b0:	f9f44783          	lbu	a5,-97(s0)
   106b4:	0ff7f793          	zext.b	a5,a5
   106b8:	02078063          	beqz	a5,106d8 <print_dec_int+0xa0>
   106bc:	fa043783          	ld	a5,-96(s0)
   106c0:	0007dc63          	bgez	a5,106d8 <print_dec_int+0xa0>
   106c4:	00100793          	li	a5,1
   106c8:	fef407a3          	sb	a5,-17(s0)
   106cc:	fa043783          	ld	a5,-96(s0)
   106d0:	40f007b3          	neg	a5,a5
   106d4:	faf43023          	sd	a5,-96(s0)
   106d8:	fe042423          	sw	zero,-24(s0)
   106dc:	f9f44783          	lbu	a5,-97(s0)
   106e0:	0ff7f793          	zext.b	a5,a5
   106e4:	02078863          	beqz	a5,10714 <print_dec_int+0xdc>
   106e8:	fef44783          	lbu	a5,-17(s0)
   106ec:	0ff7f793          	zext.b	a5,a5
   106f0:	00079e63          	bnez	a5,1070c <print_dec_int+0xd4>
   106f4:	f9043783          	ld	a5,-112(s0)
   106f8:	0057c783          	lbu	a5,5(a5)
   106fc:	00079863          	bnez	a5,1070c <print_dec_int+0xd4>
   10700:	f9043783          	ld	a5,-112(s0)
   10704:	0047c783          	lbu	a5,4(a5)
   10708:	00078663          	beqz	a5,10714 <print_dec_int+0xdc>
   1070c:	00100793          	li	a5,1
   10710:	0080006f          	j	10718 <print_dec_int+0xe0>
   10714:	00000793          	li	a5,0
   10718:	fcf40ba3          	sb	a5,-41(s0)
   1071c:	fd744783          	lbu	a5,-41(s0)
   10720:	0017f793          	andi	a5,a5,1
   10724:	fcf40ba3          	sb	a5,-41(s0)
   10728:	fa043703          	ld	a4,-96(s0)
   1072c:	00a00793          	li	a5,10
   10730:	02f777b3          	remu	a5,a4,a5
   10734:	0ff7f713          	zext.b	a4,a5
   10738:	fe842783          	lw	a5,-24(s0)
   1073c:	0017869b          	addiw	a3,a5,1
   10740:	fed42423          	sw	a3,-24(s0)
   10744:	0307071b          	addiw	a4,a4,48
   10748:	0ff77713          	zext.b	a4,a4
   1074c:	ff078793          	addi	a5,a5,-16
   10750:	008787b3          	add	a5,a5,s0
   10754:	fce78423          	sb	a4,-56(a5)
   10758:	fa043703          	ld	a4,-96(s0)
   1075c:	00a00793          	li	a5,10
   10760:	02f757b3          	divu	a5,a4,a5
   10764:	faf43023          	sd	a5,-96(s0)
   10768:	fa043783          	ld	a5,-96(s0)
   1076c:	fa079ee3          	bnez	a5,10728 <print_dec_int+0xf0>
   10770:	f9043783          	ld	a5,-112(s0)
   10774:	00c7a783          	lw	a5,12(a5)
   10778:	00078713          	mv	a4,a5
   1077c:	fff00793          	li	a5,-1
   10780:	02f71063          	bne	a4,a5,107a0 <print_dec_int+0x168>
   10784:	f9043783          	ld	a5,-112(s0)
   10788:	0037c783          	lbu	a5,3(a5)
   1078c:	00078a63          	beqz	a5,107a0 <print_dec_int+0x168>
   10790:	f9043783          	ld	a5,-112(s0)
   10794:	0087a703          	lw	a4,8(a5)
   10798:	f9043783          	ld	a5,-112(s0)
   1079c:	00e7a623          	sw	a4,12(a5)
   107a0:	fe042223          	sw	zero,-28(s0)
   107a4:	f9043783          	ld	a5,-112(s0)
   107a8:	0087a703          	lw	a4,8(a5)
   107ac:	fe842783          	lw	a5,-24(s0)
   107b0:	fcf42823          	sw	a5,-48(s0)
   107b4:	f9043783          	ld	a5,-112(s0)
   107b8:	00c7a783          	lw	a5,12(a5)
   107bc:	fcf42623          	sw	a5,-52(s0)
   107c0:	fd042783          	lw	a5,-48(s0)
   107c4:	00078593          	mv	a1,a5
   107c8:	fcc42783          	lw	a5,-52(s0)
   107cc:	00078613          	mv	a2,a5
   107d0:	0006069b          	sext.w	a3,a2
   107d4:	0005879b          	sext.w	a5,a1
   107d8:	00f6d463          	bge	a3,a5,107e0 <print_dec_int+0x1a8>
   107dc:	00058613          	mv	a2,a1
   107e0:	0006079b          	sext.w	a5,a2
   107e4:	40f707bb          	subw	a5,a4,a5
   107e8:	0007871b          	sext.w	a4,a5
   107ec:	fd744783          	lbu	a5,-41(s0)
   107f0:	0007879b          	sext.w	a5,a5
   107f4:	40f707bb          	subw	a5,a4,a5
   107f8:	fef42023          	sw	a5,-32(s0)
   107fc:	0280006f          	j	10824 <print_dec_int+0x1ec>
   10800:	fa843783          	ld	a5,-88(s0)
   10804:	02000513          	li	a0,32
   10808:	000780e7          	jalr	a5
   1080c:	fe442783          	lw	a5,-28(s0)
   10810:	0017879b          	addiw	a5,a5,1
   10814:	fef42223          	sw	a5,-28(s0)
   10818:	fe042783          	lw	a5,-32(s0)
   1081c:	fff7879b          	addiw	a5,a5,-1
   10820:	fef42023          	sw	a5,-32(s0)
   10824:	fe042783          	lw	a5,-32(s0)
   10828:	0007879b          	sext.w	a5,a5
   1082c:	fcf04ae3          	bgtz	a5,10800 <print_dec_int+0x1c8>
   10830:	fd744783          	lbu	a5,-41(s0)
   10834:	0ff7f793          	zext.b	a5,a5
   10838:	04078463          	beqz	a5,10880 <print_dec_int+0x248>
   1083c:	fef44783          	lbu	a5,-17(s0)
   10840:	0ff7f793          	zext.b	a5,a5
   10844:	00078663          	beqz	a5,10850 <print_dec_int+0x218>
   10848:	02d00793          	li	a5,45
   1084c:	01c0006f          	j	10868 <print_dec_int+0x230>
   10850:	f9043783          	ld	a5,-112(s0)
   10854:	0057c783          	lbu	a5,5(a5)
   10858:	00078663          	beqz	a5,10864 <print_dec_int+0x22c>
   1085c:	02b00793          	li	a5,43
   10860:	0080006f          	j	10868 <print_dec_int+0x230>
   10864:	02000793          	li	a5,32
   10868:	fa843703          	ld	a4,-88(s0)
   1086c:	00078513          	mv	a0,a5
   10870:	000700e7          	jalr	a4
   10874:	fe442783          	lw	a5,-28(s0)
   10878:	0017879b          	addiw	a5,a5,1
   1087c:	fef42223          	sw	a5,-28(s0)
   10880:	fe842783          	lw	a5,-24(s0)
   10884:	fcf42e23          	sw	a5,-36(s0)
   10888:	0280006f          	j	108b0 <print_dec_int+0x278>
   1088c:	fa843783          	ld	a5,-88(s0)
   10890:	03000513          	li	a0,48
   10894:	000780e7          	jalr	a5
   10898:	fe442783          	lw	a5,-28(s0)
   1089c:	0017879b          	addiw	a5,a5,1
   108a0:	fef42223          	sw	a5,-28(s0)
   108a4:	fdc42783          	lw	a5,-36(s0)
   108a8:	0017879b          	addiw	a5,a5,1
   108ac:	fcf42e23          	sw	a5,-36(s0)
   108b0:	f9043783          	ld	a5,-112(s0)
   108b4:	00c7a703          	lw	a4,12(a5)
   108b8:	fd744783          	lbu	a5,-41(s0)
   108bc:	0007879b          	sext.w	a5,a5
   108c0:	40f707bb          	subw	a5,a4,a5
   108c4:	0007871b          	sext.w	a4,a5
   108c8:	fdc42783          	lw	a5,-36(s0)
   108cc:	0007879b          	sext.w	a5,a5
   108d0:	fae7cee3          	blt	a5,a4,1088c <print_dec_int+0x254>
   108d4:	fe842783          	lw	a5,-24(s0)
   108d8:	fff7879b          	addiw	a5,a5,-1
   108dc:	fcf42c23          	sw	a5,-40(s0)
   108e0:	03c0006f          	j	1091c <print_dec_int+0x2e4>
   108e4:	fd842783          	lw	a5,-40(s0)
   108e8:	ff078793          	addi	a5,a5,-16
   108ec:	008787b3          	add	a5,a5,s0
   108f0:	fc87c783          	lbu	a5,-56(a5)
   108f4:	0007871b          	sext.w	a4,a5
   108f8:	fa843783          	ld	a5,-88(s0)
   108fc:	00070513          	mv	a0,a4
   10900:	000780e7          	jalr	a5
   10904:	fe442783          	lw	a5,-28(s0)
   10908:	0017879b          	addiw	a5,a5,1
   1090c:	fef42223          	sw	a5,-28(s0)
   10910:	fd842783          	lw	a5,-40(s0)
   10914:	fff7879b          	addiw	a5,a5,-1
   10918:	fcf42c23          	sw	a5,-40(s0)
   1091c:	fd842783          	lw	a5,-40(s0)
   10920:	0007879b          	sext.w	a5,a5
   10924:	fc07d0e3          	bgez	a5,108e4 <print_dec_int+0x2ac>
   10928:	fe442783          	lw	a5,-28(s0)
   1092c:	00078513          	mv	a0,a5
   10930:	06813083          	ld	ra,104(sp)
   10934:	06013403          	ld	s0,96(sp)
   10938:	07010113          	addi	sp,sp,112
   1093c:	00008067          	ret

0000000000010940 <vprintfmt>:
   10940:	f4010113          	addi	sp,sp,-192
   10944:	0a113c23          	sd	ra,184(sp)
   10948:	0a813823          	sd	s0,176(sp)
   1094c:	0c010413          	addi	s0,sp,192
   10950:	f4a43c23          	sd	a0,-168(s0)
   10954:	f4b43823          	sd	a1,-176(s0)
   10958:	f4c43423          	sd	a2,-184(s0)
   1095c:	f8043023          	sd	zero,-128(s0)
   10960:	f8043423          	sd	zero,-120(s0)
   10964:	fe042623          	sw	zero,-20(s0)
   10968:	7a40006f          	j	1110c <vprintfmt+0x7cc>
   1096c:	f8044783          	lbu	a5,-128(s0)
   10970:	72078e63          	beqz	a5,110ac <vprintfmt+0x76c>
   10974:	f5043783          	ld	a5,-176(s0)
   10978:	0007c783          	lbu	a5,0(a5)
   1097c:	00078713          	mv	a4,a5
   10980:	02300793          	li	a5,35
   10984:	00f71863          	bne	a4,a5,10994 <vprintfmt+0x54>
   10988:	00100793          	li	a5,1
   1098c:	f8f40123          	sb	a5,-126(s0)
   10990:	7700006f          	j	11100 <vprintfmt+0x7c0>
   10994:	f5043783          	ld	a5,-176(s0)
   10998:	0007c783          	lbu	a5,0(a5)
   1099c:	00078713          	mv	a4,a5
   109a0:	03000793          	li	a5,48
   109a4:	00f71863          	bne	a4,a5,109b4 <vprintfmt+0x74>
   109a8:	00100793          	li	a5,1
   109ac:	f8f401a3          	sb	a5,-125(s0)
   109b0:	7500006f          	j	11100 <vprintfmt+0x7c0>
   109b4:	f5043783          	ld	a5,-176(s0)
   109b8:	0007c783          	lbu	a5,0(a5)
   109bc:	00078713          	mv	a4,a5
   109c0:	06c00793          	li	a5,108
   109c4:	04f70063          	beq	a4,a5,10a04 <vprintfmt+0xc4>
   109c8:	f5043783          	ld	a5,-176(s0)
   109cc:	0007c783          	lbu	a5,0(a5)
   109d0:	00078713          	mv	a4,a5
   109d4:	07a00793          	li	a5,122
   109d8:	02f70663          	beq	a4,a5,10a04 <vprintfmt+0xc4>
   109dc:	f5043783          	ld	a5,-176(s0)
   109e0:	0007c783          	lbu	a5,0(a5)
   109e4:	00078713          	mv	a4,a5
   109e8:	07400793          	li	a5,116
   109ec:	00f70c63          	beq	a4,a5,10a04 <vprintfmt+0xc4>
   109f0:	f5043783          	ld	a5,-176(s0)
   109f4:	0007c783          	lbu	a5,0(a5)
   109f8:	00078713          	mv	a4,a5
   109fc:	06a00793          	li	a5,106
   10a00:	00f71863          	bne	a4,a5,10a10 <vprintfmt+0xd0>
   10a04:	00100793          	li	a5,1
   10a08:	f8f400a3          	sb	a5,-127(s0)
   10a0c:	6f40006f          	j	11100 <vprintfmt+0x7c0>
   10a10:	f5043783          	ld	a5,-176(s0)
   10a14:	0007c783          	lbu	a5,0(a5)
   10a18:	00078713          	mv	a4,a5
   10a1c:	02b00793          	li	a5,43
   10a20:	00f71863          	bne	a4,a5,10a30 <vprintfmt+0xf0>
   10a24:	00100793          	li	a5,1
   10a28:	f8f402a3          	sb	a5,-123(s0)
   10a2c:	6d40006f          	j	11100 <vprintfmt+0x7c0>
   10a30:	f5043783          	ld	a5,-176(s0)
   10a34:	0007c783          	lbu	a5,0(a5)
   10a38:	00078713          	mv	a4,a5
   10a3c:	02000793          	li	a5,32
   10a40:	00f71863          	bne	a4,a5,10a50 <vprintfmt+0x110>
   10a44:	00100793          	li	a5,1
   10a48:	f8f40223          	sb	a5,-124(s0)
   10a4c:	6b40006f          	j	11100 <vprintfmt+0x7c0>
   10a50:	f5043783          	ld	a5,-176(s0)
   10a54:	0007c783          	lbu	a5,0(a5)
   10a58:	00078713          	mv	a4,a5
   10a5c:	02a00793          	li	a5,42
   10a60:	00f71e63          	bne	a4,a5,10a7c <vprintfmt+0x13c>
   10a64:	f4843783          	ld	a5,-184(s0)
   10a68:	00878713          	addi	a4,a5,8
   10a6c:	f4e43423          	sd	a4,-184(s0)
   10a70:	0007a783          	lw	a5,0(a5)
   10a74:	f8f42423          	sw	a5,-120(s0)
   10a78:	6880006f          	j	11100 <vprintfmt+0x7c0>
   10a7c:	f5043783          	ld	a5,-176(s0)
   10a80:	0007c783          	lbu	a5,0(a5)
   10a84:	00078713          	mv	a4,a5
   10a88:	03000793          	li	a5,48
   10a8c:	04e7f663          	bgeu	a5,a4,10ad8 <vprintfmt+0x198>
   10a90:	f5043783          	ld	a5,-176(s0)
   10a94:	0007c783          	lbu	a5,0(a5)
   10a98:	00078713          	mv	a4,a5
   10a9c:	03900793          	li	a5,57
   10aa0:	02e7ec63          	bltu	a5,a4,10ad8 <vprintfmt+0x198>
   10aa4:	f5043783          	ld	a5,-176(s0)
   10aa8:	f5040713          	addi	a4,s0,-176
   10aac:	00a00613          	li	a2,10
   10ab0:	00070593          	mv	a1,a4
   10ab4:	00078513          	mv	a0,a5
   10ab8:	88dff0ef          	jal	10344 <strtol>
   10abc:	00050793          	mv	a5,a0
   10ac0:	0007879b          	sext.w	a5,a5
   10ac4:	f8f42423          	sw	a5,-120(s0)
   10ac8:	f5043783          	ld	a5,-176(s0)
   10acc:	fff78793          	addi	a5,a5,-1
   10ad0:	f4f43823          	sd	a5,-176(s0)
   10ad4:	62c0006f          	j	11100 <vprintfmt+0x7c0>
   10ad8:	f5043783          	ld	a5,-176(s0)
   10adc:	0007c783          	lbu	a5,0(a5)
   10ae0:	00078713          	mv	a4,a5
   10ae4:	02e00793          	li	a5,46
   10ae8:	06f71863          	bne	a4,a5,10b58 <vprintfmt+0x218>
   10aec:	f5043783          	ld	a5,-176(s0)
   10af0:	00178793          	addi	a5,a5,1
   10af4:	f4f43823          	sd	a5,-176(s0)
   10af8:	f5043783          	ld	a5,-176(s0)
   10afc:	0007c783          	lbu	a5,0(a5)
   10b00:	00078713          	mv	a4,a5
   10b04:	02a00793          	li	a5,42
   10b08:	00f71e63          	bne	a4,a5,10b24 <vprintfmt+0x1e4>
   10b0c:	f4843783          	ld	a5,-184(s0)
   10b10:	00878713          	addi	a4,a5,8
   10b14:	f4e43423          	sd	a4,-184(s0)
   10b18:	0007a783          	lw	a5,0(a5)
   10b1c:	f8f42623          	sw	a5,-116(s0)
   10b20:	5e00006f          	j	11100 <vprintfmt+0x7c0>
   10b24:	f5043783          	ld	a5,-176(s0)
   10b28:	f5040713          	addi	a4,s0,-176
   10b2c:	00a00613          	li	a2,10
   10b30:	00070593          	mv	a1,a4
   10b34:	00078513          	mv	a0,a5
   10b38:	80dff0ef          	jal	10344 <strtol>
   10b3c:	00050793          	mv	a5,a0
   10b40:	0007879b          	sext.w	a5,a5
   10b44:	f8f42623          	sw	a5,-116(s0)
   10b48:	f5043783          	ld	a5,-176(s0)
   10b4c:	fff78793          	addi	a5,a5,-1
   10b50:	f4f43823          	sd	a5,-176(s0)
   10b54:	5ac0006f          	j	11100 <vprintfmt+0x7c0>
   10b58:	f5043783          	ld	a5,-176(s0)
   10b5c:	0007c783          	lbu	a5,0(a5)
   10b60:	00078713          	mv	a4,a5
   10b64:	07800793          	li	a5,120
   10b68:	02f70663          	beq	a4,a5,10b94 <vprintfmt+0x254>
   10b6c:	f5043783          	ld	a5,-176(s0)
   10b70:	0007c783          	lbu	a5,0(a5)
   10b74:	00078713          	mv	a4,a5
   10b78:	05800793          	li	a5,88
   10b7c:	00f70c63          	beq	a4,a5,10b94 <vprintfmt+0x254>
   10b80:	f5043783          	ld	a5,-176(s0)
   10b84:	0007c783          	lbu	a5,0(a5)
   10b88:	00078713          	mv	a4,a5
   10b8c:	07000793          	li	a5,112
   10b90:	30f71263          	bne	a4,a5,10e94 <vprintfmt+0x554>
   10b94:	f5043783          	ld	a5,-176(s0)
   10b98:	0007c783          	lbu	a5,0(a5)
   10b9c:	00078713          	mv	a4,a5
   10ba0:	07000793          	li	a5,112
   10ba4:	00f70663          	beq	a4,a5,10bb0 <vprintfmt+0x270>
   10ba8:	f8144783          	lbu	a5,-127(s0)
   10bac:	00078663          	beqz	a5,10bb8 <vprintfmt+0x278>
   10bb0:	00100793          	li	a5,1
   10bb4:	0080006f          	j	10bbc <vprintfmt+0x27c>
   10bb8:	00000793          	li	a5,0
   10bbc:	faf403a3          	sb	a5,-89(s0)
   10bc0:	fa744783          	lbu	a5,-89(s0)
   10bc4:	0017f793          	andi	a5,a5,1
   10bc8:	faf403a3          	sb	a5,-89(s0)
   10bcc:	fa744783          	lbu	a5,-89(s0)
   10bd0:	0ff7f793          	zext.b	a5,a5
   10bd4:	00078c63          	beqz	a5,10bec <vprintfmt+0x2ac>
   10bd8:	f4843783          	ld	a5,-184(s0)
   10bdc:	00878713          	addi	a4,a5,8
   10be0:	f4e43423          	sd	a4,-184(s0)
   10be4:	0007b783          	ld	a5,0(a5)
   10be8:	01c0006f          	j	10c04 <vprintfmt+0x2c4>
   10bec:	f4843783          	ld	a5,-184(s0)
   10bf0:	00878713          	addi	a4,a5,8
   10bf4:	f4e43423          	sd	a4,-184(s0)
   10bf8:	0007a783          	lw	a5,0(a5)
   10bfc:	02079793          	slli	a5,a5,0x20
   10c00:	0207d793          	srli	a5,a5,0x20
   10c04:	fef43023          	sd	a5,-32(s0)
   10c08:	f8c42783          	lw	a5,-116(s0)
   10c0c:	02079463          	bnez	a5,10c34 <vprintfmt+0x2f4>
   10c10:	fe043783          	ld	a5,-32(s0)
   10c14:	02079063          	bnez	a5,10c34 <vprintfmt+0x2f4>
   10c18:	f5043783          	ld	a5,-176(s0)
   10c1c:	0007c783          	lbu	a5,0(a5)
   10c20:	00078713          	mv	a4,a5
   10c24:	07000793          	li	a5,112
   10c28:	00f70663          	beq	a4,a5,10c34 <vprintfmt+0x2f4>
   10c2c:	f8040023          	sb	zero,-128(s0)
   10c30:	4d00006f          	j	11100 <vprintfmt+0x7c0>
   10c34:	f5043783          	ld	a5,-176(s0)
   10c38:	0007c783          	lbu	a5,0(a5)
   10c3c:	00078713          	mv	a4,a5
   10c40:	07000793          	li	a5,112
   10c44:	00f70a63          	beq	a4,a5,10c58 <vprintfmt+0x318>
   10c48:	f8244783          	lbu	a5,-126(s0)
   10c4c:	00078a63          	beqz	a5,10c60 <vprintfmt+0x320>
   10c50:	fe043783          	ld	a5,-32(s0)
   10c54:	00078663          	beqz	a5,10c60 <vprintfmt+0x320>
   10c58:	00100793          	li	a5,1
   10c5c:	0080006f          	j	10c64 <vprintfmt+0x324>
   10c60:	00000793          	li	a5,0
   10c64:	faf40323          	sb	a5,-90(s0)
   10c68:	fa644783          	lbu	a5,-90(s0)
   10c6c:	0017f793          	andi	a5,a5,1
   10c70:	faf40323          	sb	a5,-90(s0)
   10c74:	fc042e23          	sw	zero,-36(s0)
   10c78:	f5043783          	ld	a5,-176(s0)
   10c7c:	0007c783          	lbu	a5,0(a5)
   10c80:	00078713          	mv	a4,a5
   10c84:	05800793          	li	a5,88
   10c88:	00f71863          	bne	a4,a5,10c98 <vprintfmt+0x358>
   10c8c:	00000797          	auipc	a5,0x0
   10c90:	65c78793          	addi	a5,a5,1628 # 112e8 <upperxdigits.1>
   10c94:	00c0006f          	j	10ca0 <vprintfmt+0x360>
   10c98:	00000797          	auipc	a5,0x0
   10c9c:	66878793          	addi	a5,a5,1640 # 11300 <lowerxdigits.0>
   10ca0:	f8f43c23          	sd	a5,-104(s0)
   10ca4:	fe043783          	ld	a5,-32(s0)
   10ca8:	00f7f793          	andi	a5,a5,15
   10cac:	f9843703          	ld	a4,-104(s0)
   10cb0:	00f70733          	add	a4,a4,a5
   10cb4:	fdc42783          	lw	a5,-36(s0)
   10cb8:	0017869b          	addiw	a3,a5,1
   10cbc:	fcd42e23          	sw	a3,-36(s0)
   10cc0:	00074703          	lbu	a4,0(a4)
   10cc4:	ff078793          	addi	a5,a5,-16
   10cc8:	008787b3          	add	a5,a5,s0
   10ccc:	f8e78023          	sb	a4,-128(a5)
   10cd0:	fe043783          	ld	a5,-32(s0)
   10cd4:	0047d793          	srli	a5,a5,0x4
   10cd8:	fef43023          	sd	a5,-32(s0)
   10cdc:	fe043783          	ld	a5,-32(s0)
   10ce0:	fc0792e3          	bnez	a5,10ca4 <vprintfmt+0x364>
   10ce4:	f8c42783          	lw	a5,-116(s0)
   10ce8:	00078713          	mv	a4,a5
   10cec:	fff00793          	li	a5,-1
   10cf0:	02f71663          	bne	a4,a5,10d1c <vprintfmt+0x3dc>
   10cf4:	f8344783          	lbu	a5,-125(s0)
   10cf8:	02078263          	beqz	a5,10d1c <vprintfmt+0x3dc>
   10cfc:	f8842703          	lw	a4,-120(s0)
   10d00:	fa644783          	lbu	a5,-90(s0)
   10d04:	0007879b          	sext.w	a5,a5
   10d08:	0017979b          	slliw	a5,a5,0x1
   10d0c:	0007879b          	sext.w	a5,a5
   10d10:	40f707bb          	subw	a5,a4,a5
   10d14:	0007879b          	sext.w	a5,a5
   10d18:	f8f42623          	sw	a5,-116(s0)
   10d1c:	f8842703          	lw	a4,-120(s0)
   10d20:	fa644783          	lbu	a5,-90(s0)
   10d24:	0007879b          	sext.w	a5,a5
   10d28:	0017979b          	slliw	a5,a5,0x1
   10d2c:	0007879b          	sext.w	a5,a5
   10d30:	40f707bb          	subw	a5,a4,a5
   10d34:	0007871b          	sext.w	a4,a5
   10d38:	fdc42783          	lw	a5,-36(s0)
   10d3c:	f8f42a23          	sw	a5,-108(s0)
   10d40:	f8c42783          	lw	a5,-116(s0)
   10d44:	f8f42823          	sw	a5,-112(s0)
   10d48:	f9442783          	lw	a5,-108(s0)
   10d4c:	00078593          	mv	a1,a5
   10d50:	f9042783          	lw	a5,-112(s0)
   10d54:	00078613          	mv	a2,a5
   10d58:	0006069b          	sext.w	a3,a2
   10d5c:	0005879b          	sext.w	a5,a1
   10d60:	00f6d463          	bge	a3,a5,10d68 <vprintfmt+0x428>
   10d64:	00058613          	mv	a2,a1
   10d68:	0006079b          	sext.w	a5,a2
   10d6c:	40f707bb          	subw	a5,a4,a5
   10d70:	fcf42c23          	sw	a5,-40(s0)
   10d74:	0280006f          	j	10d9c <vprintfmt+0x45c>
   10d78:	f5843783          	ld	a5,-168(s0)
   10d7c:	02000513          	li	a0,32
   10d80:	000780e7          	jalr	a5
   10d84:	fec42783          	lw	a5,-20(s0)
   10d88:	0017879b          	addiw	a5,a5,1
   10d8c:	fef42623          	sw	a5,-20(s0)
   10d90:	fd842783          	lw	a5,-40(s0)
   10d94:	fff7879b          	addiw	a5,a5,-1
   10d98:	fcf42c23          	sw	a5,-40(s0)
   10d9c:	fd842783          	lw	a5,-40(s0)
   10da0:	0007879b          	sext.w	a5,a5
   10da4:	fcf04ae3          	bgtz	a5,10d78 <vprintfmt+0x438>
   10da8:	fa644783          	lbu	a5,-90(s0)
   10dac:	0ff7f793          	zext.b	a5,a5
   10db0:	04078463          	beqz	a5,10df8 <vprintfmt+0x4b8>
   10db4:	f5843783          	ld	a5,-168(s0)
   10db8:	03000513          	li	a0,48
   10dbc:	000780e7          	jalr	a5
   10dc0:	f5043783          	ld	a5,-176(s0)
   10dc4:	0007c783          	lbu	a5,0(a5)
   10dc8:	00078713          	mv	a4,a5
   10dcc:	05800793          	li	a5,88
   10dd0:	00f71663          	bne	a4,a5,10ddc <vprintfmt+0x49c>
   10dd4:	05800793          	li	a5,88
   10dd8:	0080006f          	j	10de0 <vprintfmt+0x4a0>
   10ddc:	07800793          	li	a5,120
   10de0:	f5843703          	ld	a4,-168(s0)
   10de4:	00078513          	mv	a0,a5
   10de8:	000700e7          	jalr	a4
   10dec:	fec42783          	lw	a5,-20(s0)
   10df0:	0027879b          	addiw	a5,a5,2
   10df4:	fef42623          	sw	a5,-20(s0)
   10df8:	fdc42783          	lw	a5,-36(s0)
   10dfc:	fcf42a23          	sw	a5,-44(s0)
   10e00:	0280006f          	j	10e28 <vprintfmt+0x4e8>
   10e04:	f5843783          	ld	a5,-168(s0)
   10e08:	03000513          	li	a0,48
   10e0c:	000780e7          	jalr	a5
   10e10:	fec42783          	lw	a5,-20(s0)
   10e14:	0017879b          	addiw	a5,a5,1
   10e18:	fef42623          	sw	a5,-20(s0)
   10e1c:	fd442783          	lw	a5,-44(s0)
   10e20:	0017879b          	addiw	a5,a5,1
   10e24:	fcf42a23          	sw	a5,-44(s0)
   10e28:	f8c42703          	lw	a4,-116(s0)
   10e2c:	fd442783          	lw	a5,-44(s0)
   10e30:	0007879b          	sext.w	a5,a5
   10e34:	fce7c8e3          	blt	a5,a4,10e04 <vprintfmt+0x4c4>
   10e38:	fdc42783          	lw	a5,-36(s0)
   10e3c:	fff7879b          	addiw	a5,a5,-1
   10e40:	fcf42823          	sw	a5,-48(s0)
   10e44:	03c0006f          	j	10e80 <vprintfmt+0x540>
   10e48:	fd042783          	lw	a5,-48(s0)
   10e4c:	ff078793          	addi	a5,a5,-16
   10e50:	008787b3          	add	a5,a5,s0
   10e54:	f807c783          	lbu	a5,-128(a5)
   10e58:	0007871b          	sext.w	a4,a5
   10e5c:	f5843783          	ld	a5,-168(s0)
   10e60:	00070513          	mv	a0,a4
   10e64:	000780e7          	jalr	a5
   10e68:	fec42783          	lw	a5,-20(s0)
   10e6c:	0017879b          	addiw	a5,a5,1
   10e70:	fef42623          	sw	a5,-20(s0)
   10e74:	fd042783          	lw	a5,-48(s0)
   10e78:	fff7879b          	addiw	a5,a5,-1
   10e7c:	fcf42823          	sw	a5,-48(s0)
   10e80:	fd042783          	lw	a5,-48(s0)
   10e84:	0007879b          	sext.w	a5,a5
   10e88:	fc07d0e3          	bgez	a5,10e48 <vprintfmt+0x508>
   10e8c:	f8040023          	sb	zero,-128(s0)
   10e90:	2700006f          	j	11100 <vprintfmt+0x7c0>
   10e94:	f5043783          	ld	a5,-176(s0)
   10e98:	0007c783          	lbu	a5,0(a5)
   10e9c:	00078713          	mv	a4,a5
   10ea0:	06400793          	li	a5,100
   10ea4:	02f70663          	beq	a4,a5,10ed0 <vprintfmt+0x590>
   10ea8:	f5043783          	ld	a5,-176(s0)
   10eac:	0007c783          	lbu	a5,0(a5)
   10eb0:	00078713          	mv	a4,a5
   10eb4:	06900793          	li	a5,105
   10eb8:	00f70c63          	beq	a4,a5,10ed0 <vprintfmt+0x590>
   10ebc:	f5043783          	ld	a5,-176(s0)
   10ec0:	0007c783          	lbu	a5,0(a5)
   10ec4:	00078713          	mv	a4,a5
   10ec8:	07500793          	li	a5,117
   10ecc:	08f71063          	bne	a4,a5,10f4c <vprintfmt+0x60c>
   10ed0:	f8144783          	lbu	a5,-127(s0)
   10ed4:	00078c63          	beqz	a5,10eec <vprintfmt+0x5ac>
   10ed8:	f4843783          	ld	a5,-184(s0)
   10edc:	00878713          	addi	a4,a5,8
   10ee0:	f4e43423          	sd	a4,-184(s0)
   10ee4:	0007b783          	ld	a5,0(a5)
   10ee8:	0140006f          	j	10efc <vprintfmt+0x5bc>
   10eec:	f4843783          	ld	a5,-184(s0)
   10ef0:	00878713          	addi	a4,a5,8
   10ef4:	f4e43423          	sd	a4,-184(s0)
   10ef8:	0007a783          	lw	a5,0(a5)
   10efc:	faf43423          	sd	a5,-88(s0)
   10f00:	fa843583          	ld	a1,-88(s0)
   10f04:	f5043783          	ld	a5,-176(s0)
   10f08:	0007c783          	lbu	a5,0(a5)
   10f0c:	0007871b          	sext.w	a4,a5
   10f10:	07500793          	li	a5,117
   10f14:	40f707b3          	sub	a5,a4,a5
   10f18:	00f037b3          	snez	a5,a5
   10f1c:	0ff7f793          	zext.b	a5,a5
   10f20:	f8040713          	addi	a4,s0,-128
   10f24:	00070693          	mv	a3,a4
   10f28:	00078613          	mv	a2,a5
   10f2c:	f5843503          	ld	a0,-168(s0)
   10f30:	f08ff0ef          	jal	10638 <print_dec_int>
   10f34:	00050793          	mv	a5,a0
   10f38:	fec42703          	lw	a4,-20(s0)
   10f3c:	00f707bb          	addw	a5,a4,a5
   10f40:	fef42623          	sw	a5,-20(s0)
   10f44:	f8040023          	sb	zero,-128(s0)
   10f48:	1b80006f          	j	11100 <vprintfmt+0x7c0>
   10f4c:	f5043783          	ld	a5,-176(s0)
   10f50:	0007c783          	lbu	a5,0(a5)
   10f54:	00078713          	mv	a4,a5
   10f58:	06e00793          	li	a5,110
   10f5c:	04f71c63          	bne	a4,a5,10fb4 <vprintfmt+0x674>
   10f60:	f8144783          	lbu	a5,-127(s0)
   10f64:	02078463          	beqz	a5,10f8c <vprintfmt+0x64c>
   10f68:	f4843783          	ld	a5,-184(s0)
   10f6c:	00878713          	addi	a4,a5,8
   10f70:	f4e43423          	sd	a4,-184(s0)
   10f74:	0007b783          	ld	a5,0(a5)
   10f78:	faf43823          	sd	a5,-80(s0)
   10f7c:	fec42703          	lw	a4,-20(s0)
   10f80:	fb043783          	ld	a5,-80(s0)
   10f84:	00e7b023          	sd	a4,0(a5)
   10f88:	0240006f          	j	10fac <vprintfmt+0x66c>
   10f8c:	f4843783          	ld	a5,-184(s0)
   10f90:	00878713          	addi	a4,a5,8
   10f94:	f4e43423          	sd	a4,-184(s0)
   10f98:	0007b783          	ld	a5,0(a5)
   10f9c:	faf43c23          	sd	a5,-72(s0)
   10fa0:	fb843783          	ld	a5,-72(s0)
   10fa4:	fec42703          	lw	a4,-20(s0)
   10fa8:	00e7a023          	sw	a4,0(a5)
   10fac:	f8040023          	sb	zero,-128(s0)
   10fb0:	1500006f          	j	11100 <vprintfmt+0x7c0>
   10fb4:	f5043783          	ld	a5,-176(s0)
   10fb8:	0007c783          	lbu	a5,0(a5)
   10fbc:	00078713          	mv	a4,a5
   10fc0:	07300793          	li	a5,115
   10fc4:	02f71e63          	bne	a4,a5,11000 <vprintfmt+0x6c0>
   10fc8:	f4843783          	ld	a5,-184(s0)
   10fcc:	00878713          	addi	a4,a5,8
   10fd0:	f4e43423          	sd	a4,-184(s0)
   10fd4:	0007b783          	ld	a5,0(a5)
   10fd8:	fcf43023          	sd	a5,-64(s0)
   10fdc:	fc043583          	ld	a1,-64(s0)
   10fe0:	f5843503          	ld	a0,-168(s0)
   10fe4:	dccff0ef          	jal	105b0 <puts_wo_nl>
   10fe8:	00050793          	mv	a5,a0
   10fec:	fec42703          	lw	a4,-20(s0)
   10ff0:	00f707bb          	addw	a5,a4,a5
   10ff4:	fef42623          	sw	a5,-20(s0)
   10ff8:	f8040023          	sb	zero,-128(s0)
   10ffc:	1040006f          	j	11100 <vprintfmt+0x7c0>
   11000:	f5043783          	ld	a5,-176(s0)
   11004:	0007c783          	lbu	a5,0(a5)
   11008:	00078713          	mv	a4,a5
   1100c:	06300793          	li	a5,99
   11010:	02f71e63          	bne	a4,a5,1104c <vprintfmt+0x70c>
   11014:	f4843783          	ld	a5,-184(s0)
   11018:	00878713          	addi	a4,a5,8
   1101c:	f4e43423          	sd	a4,-184(s0)
   11020:	0007a783          	lw	a5,0(a5)
   11024:	fcf42623          	sw	a5,-52(s0)
   11028:	fcc42703          	lw	a4,-52(s0)
   1102c:	f5843783          	ld	a5,-168(s0)
   11030:	00070513          	mv	a0,a4
   11034:	000780e7          	jalr	a5
   11038:	fec42783          	lw	a5,-20(s0)
   1103c:	0017879b          	addiw	a5,a5,1
   11040:	fef42623          	sw	a5,-20(s0)
   11044:	f8040023          	sb	zero,-128(s0)
   11048:	0b80006f          	j	11100 <vprintfmt+0x7c0>
   1104c:	f5043783          	ld	a5,-176(s0)
   11050:	0007c783          	lbu	a5,0(a5)
   11054:	00078713          	mv	a4,a5
   11058:	02500793          	li	a5,37
   1105c:	02f71263          	bne	a4,a5,11080 <vprintfmt+0x740>
   11060:	f5843783          	ld	a5,-168(s0)
   11064:	02500513          	li	a0,37
   11068:	000780e7          	jalr	a5
   1106c:	fec42783          	lw	a5,-20(s0)
   11070:	0017879b          	addiw	a5,a5,1
   11074:	fef42623          	sw	a5,-20(s0)
   11078:	f8040023          	sb	zero,-128(s0)
   1107c:	0840006f          	j	11100 <vprintfmt+0x7c0>
   11080:	f5043783          	ld	a5,-176(s0)
   11084:	0007c783          	lbu	a5,0(a5)
   11088:	0007871b          	sext.w	a4,a5
   1108c:	f5843783          	ld	a5,-168(s0)
   11090:	00070513          	mv	a0,a4
   11094:	000780e7          	jalr	a5
   11098:	fec42783          	lw	a5,-20(s0)
   1109c:	0017879b          	addiw	a5,a5,1
   110a0:	fef42623          	sw	a5,-20(s0)
   110a4:	f8040023          	sb	zero,-128(s0)
   110a8:	0580006f          	j	11100 <vprintfmt+0x7c0>
   110ac:	f5043783          	ld	a5,-176(s0)
   110b0:	0007c783          	lbu	a5,0(a5)
   110b4:	00078713          	mv	a4,a5
   110b8:	02500793          	li	a5,37
   110bc:	02f71063          	bne	a4,a5,110dc <vprintfmt+0x79c>
   110c0:	f8043023          	sd	zero,-128(s0)
   110c4:	f8043423          	sd	zero,-120(s0)
   110c8:	00100793          	li	a5,1
   110cc:	f8f40023          	sb	a5,-128(s0)
   110d0:	fff00793          	li	a5,-1
   110d4:	f8f42623          	sw	a5,-116(s0)
   110d8:	0280006f          	j	11100 <vprintfmt+0x7c0>
   110dc:	f5043783          	ld	a5,-176(s0)
   110e0:	0007c783          	lbu	a5,0(a5)
   110e4:	0007871b          	sext.w	a4,a5
   110e8:	f5843783          	ld	a5,-168(s0)
   110ec:	00070513          	mv	a0,a4
   110f0:	000780e7          	jalr	a5
   110f4:	fec42783          	lw	a5,-20(s0)
   110f8:	0017879b          	addiw	a5,a5,1
   110fc:	fef42623          	sw	a5,-20(s0)
   11100:	f5043783          	ld	a5,-176(s0)
   11104:	00178793          	addi	a5,a5,1
   11108:	f4f43823          	sd	a5,-176(s0)
   1110c:	f5043783          	ld	a5,-176(s0)
   11110:	0007c783          	lbu	a5,0(a5)
   11114:	84079ce3          	bnez	a5,1096c <vprintfmt+0x2c>
   11118:	fec42783          	lw	a5,-20(s0)
   1111c:	00078513          	mv	a0,a5
   11120:	0b813083          	ld	ra,184(sp)
   11124:	0b013403          	ld	s0,176(sp)
   11128:	0c010113          	addi	sp,sp,192
   1112c:	00008067          	ret

0000000000011130 <printf>:
   11130:	f8010113          	addi	sp,sp,-128
   11134:	02113c23          	sd	ra,56(sp)
   11138:	02813823          	sd	s0,48(sp)
   1113c:	04010413          	addi	s0,sp,64
   11140:	fca43423          	sd	a0,-56(s0)
   11144:	00b43423          	sd	a1,8(s0)
   11148:	00c43823          	sd	a2,16(s0)
   1114c:	00d43c23          	sd	a3,24(s0)
   11150:	02e43023          	sd	a4,32(s0)
   11154:	02f43423          	sd	a5,40(s0)
   11158:	03043823          	sd	a6,48(s0)
   1115c:	03143c23          	sd	a7,56(s0)
   11160:	fe042623          	sw	zero,-20(s0)
   11164:	04040793          	addi	a5,s0,64
   11168:	fcf43023          	sd	a5,-64(s0)
   1116c:	fc043783          	ld	a5,-64(s0)
   11170:	fc878793          	addi	a5,a5,-56
   11174:	fcf43823          	sd	a5,-48(s0)
   11178:	fd043783          	ld	a5,-48(s0)
   1117c:	00078613          	mv	a2,a5
   11180:	fc843583          	ld	a1,-56(s0)
   11184:	fffff517          	auipc	a0,0xfffff
   11188:	0f850513          	addi	a0,a0,248 # 1027c <putc>
   1118c:	fb4ff0ef          	jal	10940 <vprintfmt>
   11190:	00050793          	mv	a5,a0
   11194:	fef42623          	sw	a5,-20(s0)
   11198:	00100793          	li	a5,1
   1119c:	fef43023          	sd	a5,-32(s0)
   111a0:	00001797          	auipc	a5,0x1
   111a4:	e6478793          	addi	a5,a5,-412 # 12004 <tail>
   111a8:	0007a783          	lw	a5,0(a5)
   111ac:	0017871b          	addiw	a4,a5,1
   111b0:	0007069b          	sext.w	a3,a4
   111b4:	00001717          	auipc	a4,0x1
   111b8:	e5070713          	addi	a4,a4,-432 # 12004 <tail>
   111bc:	00d72023          	sw	a3,0(a4)
   111c0:	00001717          	auipc	a4,0x1
   111c4:	e4870713          	addi	a4,a4,-440 # 12008 <buffer>
   111c8:	00f707b3          	add	a5,a4,a5
   111cc:	00078023          	sb	zero,0(a5)
   111d0:	00001797          	auipc	a5,0x1
   111d4:	e3478793          	addi	a5,a5,-460 # 12004 <tail>
   111d8:	0007a603          	lw	a2,0(a5)
   111dc:	fe043703          	ld	a4,-32(s0)
   111e0:	00001697          	auipc	a3,0x1
   111e4:	e2868693          	addi	a3,a3,-472 # 12008 <buffer>
   111e8:	fd843783          	ld	a5,-40(s0)
   111ec:	04000893          	li	a7,64
   111f0:	00070513          	mv	a0,a4
   111f4:	00068593          	mv	a1,a3
   111f8:	00060613          	mv	a2,a2
   111fc:	00000073          	ecall
   11200:	00050793          	mv	a5,a0
   11204:	fcf43c23          	sd	a5,-40(s0)
   11208:	00001797          	auipc	a5,0x1
   1120c:	dfc78793          	addi	a5,a5,-516 # 12004 <tail>
   11210:	0007a023          	sw	zero,0(a5)
   11214:	fec42783          	lw	a5,-20(s0)
   11218:	00078513          	mv	a0,a5
   1121c:	03813083          	ld	ra,56(sp)
   11220:	03013403          	ld	s0,48(sp)
   11224:	08010113          	addi	sp,sp,128
   11228:	00008067          	ret
