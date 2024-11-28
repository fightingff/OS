
uapp:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100e8 <_start>:
   100e8:	0400006f          	j	10128 <main>

00000000000100ec <getpid>:
   100ec:	fe010113          	addi	sp,sp,-32
   100f0:	00113c23          	sd	ra,24(sp)
   100f4:	00813823          	sd	s0,16(sp)
   100f8:	02010413          	addi	s0,sp,32
   100fc:	fe843783          	ld	a5,-24(s0)
   10100:	0ac00893          	li	a7,172
   10104:	00000073          	ecall
   10108:	00050793          	mv	a5,a0
   1010c:	fef43423          	sd	a5,-24(s0)
   10110:	fe843783          	ld	a5,-24(s0)
   10114:	00078513          	mv	a0,a5
   10118:	01813083          	ld	ra,24(sp)
   1011c:	01013403          	ld	s0,16(sp)
   10120:	02010113          	addi	sp,sp,32
   10124:	00008067          	ret

0000000000010128 <main>:
   10128:	fe010113          	addi	sp,sp,-32
   1012c:	00113c23          	sd	ra,24(sp)
   10130:	00813823          	sd	s0,16(sp)
   10134:	02010413          	addi	s0,sp,32
   10138:	fb5ff0ef          	jal	100ec <getpid>
   1013c:	00050593          	mv	a1,a0
   10140:	00010613          	mv	a2,sp
   10144:	00002797          	auipc	a5,0x2
   10148:	ebc78793          	addi	a5,a5,-324 # 12000 <counter>
   1014c:	0007a783          	lw	a5,0(a5)
   10150:	0017879b          	addiw	a5,a5,1
   10154:	0007871b          	sext.w	a4,a5
   10158:	00002797          	auipc	a5,0x2
   1015c:	ea878793          	addi	a5,a5,-344 # 12000 <counter>
   10160:	00e7a023          	sw	a4,0(a5)
   10164:	00002797          	auipc	a5,0x2
   10168:	e9c78793          	addi	a5,a5,-356 # 12000 <counter>
   1016c:	0007a783          	lw	a5,0(a5)
   10170:	00078693          	mv	a3,a5
   10174:	00001517          	auipc	a0,0x1
   10178:	01c50513          	addi	a0,a0,28 # 11190 <printf+0xfc>
   1017c:	719000ef          	jal	11094 <printf>
   10180:	fe042623          	sw	zero,-20(s0)
   10184:	0100006f          	j	10194 <main+0x6c>
   10188:	fec42783          	lw	a5,-20(s0)
   1018c:	0017879b          	addiw	a5,a5,1
   10190:	fef42623          	sw	a5,-20(s0)
   10194:	fec42783          	lw	a5,-20(s0)
   10198:	0007871b          	sext.w	a4,a5
   1019c:	500007b7          	lui	a5,0x50000
   101a0:	ffe78793          	addi	a5,a5,-2 # 4ffffffe <__global_pointer$+0x4ffed7fe>
   101a4:	fee7f2e3          	bgeu	a5,a4,10188 <main+0x60>
   101a8:	f91ff06f          	j	10138 <main+0x10>

00000000000101ac <putc>:
   101ac:	fe010113          	addi	sp,sp,-32
   101b0:	00113c23          	sd	ra,24(sp)
   101b4:	00813823          	sd	s0,16(sp)
   101b8:	02010413          	addi	s0,sp,32
   101bc:	00050793          	mv	a5,a0
   101c0:	fef42623          	sw	a5,-20(s0)
   101c4:	00002797          	auipc	a5,0x2
   101c8:	e4078793          	addi	a5,a5,-448 # 12004 <tail>
   101cc:	0007a783          	lw	a5,0(a5)
   101d0:	0017871b          	addiw	a4,a5,1
   101d4:	0007069b          	sext.w	a3,a4
   101d8:	00002717          	auipc	a4,0x2
   101dc:	e2c70713          	addi	a4,a4,-468 # 12004 <tail>
   101e0:	00d72023          	sw	a3,0(a4)
   101e4:	fec42703          	lw	a4,-20(s0)
   101e8:	0ff77713          	zext.b	a4,a4
   101ec:	00002697          	auipc	a3,0x2
   101f0:	e1c68693          	addi	a3,a3,-484 # 12008 <buffer>
   101f4:	00f687b3          	add	a5,a3,a5
   101f8:	00e78023          	sb	a4,0(a5)
   101fc:	fec42783          	lw	a5,-20(s0)
   10200:	0ff7f793          	zext.b	a5,a5
   10204:	0007879b          	sext.w	a5,a5
   10208:	00078513          	mv	a0,a5
   1020c:	01813083          	ld	ra,24(sp)
   10210:	01013403          	ld	s0,16(sp)
   10214:	02010113          	addi	sp,sp,32
   10218:	00008067          	ret

000000000001021c <isspace>:
   1021c:	fe010113          	addi	sp,sp,-32
   10220:	00113c23          	sd	ra,24(sp)
   10224:	00813823          	sd	s0,16(sp)
   10228:	02010413          	addi	s0,sp,32
   1022c:	00050793          	mv	a5,a0
   10230:	fef42623          	sw	a5,-20(s0)
   10234:	fec42783          	lw	a5,-20(s0)
   10238:	0007871b          	sext.w	a4,a5
   1023c:	02000793          	li	a5,32
   10240:	02f70263          	beq	a4,a5,10264 <isspace+0x48>
   10244:	fec42783          	lw	a5,-20(s0)
   10248:	0007871b          	sext.w	a4,a5
   1024c:	00800793          	li	a5,8
   10250:	00e7de63          	bge	a5,a4,1026c <isspace+0x50>
   10254:	fec42783          	lw	a5,-20(s0)
   10258:	0007871b          	sext.w	a4,a5
   1025c:	00d00793          	li	a5,13
   10260:	00e7c663          	blt	a5,a4,1026c <isspace+0x50>
   10264:	00100793          	li	a5,1
   10268:	0080006f          	j	10270 <isspace+0x54>
   1026c:	00000793          	li	a5,0
   10270:	00078513          	mv	a0,a5
   10274:	01813083          	ld	ra,24(sp)
   10278:	01013403          	ld	s0,16(sp)
   1027c:	02010113          	addi	sp,sp,32
   10280:	00008067          	ret

0000000000010284 <strtol>:
   10284:	fb010113          	addi	sp,sp,-80
   10288:	04113423          	sd	ra,72(sp)
   1028c:	04813023          	sd	s0,64(sp)
   10290:	05010413          	addi	s0,sp,80
   10294:	fca43423          	sd	a0,-56(s0)
   10298:	fcb43023          	sd	a1,-64(s0)
   1029c:	00060793          	mv	a5,a2
   102a0:	faf42e23          	sw	a5,-68(s0)
   102a4:	fe043423          	sd	zero,-24(s0)
   102a8:	fe0403a3          	sb	zero,-25(s0)
   102ac:	fc843783          	ld	a5,-56(s0)
   102b0:	fcf43c23          	sd	a5,-40(s0)
   102b4:	0100006f          	j	102c4 <strtol+0x40>
   102b8:	fd843783          	ld	a5,-40(s0)
   102bc:	00178793          	addi	a5,a5,1
   102c0:	fcf43c23          	sd	a5,-40(s0)
   102c4:	fd843783          	ld	a5,-40(s0)
   102c8:	0007c783          	lbu	a5,0(a5)
   102cc:	0007879b          	sext.w	a5,a5
   102d0:	00078513          	mv	a0,a5
   102d4:	f49ff0ef          	jal	1021c <isspace>
   102d8:	00050793          	mv	a5,a0
   102dc:	fc079ee3          	bnez	a5,102b8 <strtol+0x34>
   102e0:	fd843783          	ld	a5,-40(s0)
   102e4:	0007c783          	lbu	a5,0(a5)
   102e8:	00078713          	mv	a4,a5
   102ec:	02d00793          	li	a5,45
   102f0:	00f71e63          	bne	a4,a5,1030c <strtol+0x88>
   102f4:	00100793          	li	a5,1
   102f8:	fef403a3          	sb	a5,-25(s0)
   102fc:	fd843783          	ld	a5,-40(s0)
   10300:	00178793          	addi	a5,a5,1
   10304:	fcf43c23          	sd	a5,-40(s0)
   10308:	0240006f          	j	1032c <strtol+0xa8>
   1030c:	fd843783          	ld	a5,-40(s0)
   10310:	0007c783          	lbu	a5,0(a5)
   10314:	00078713          	mv	a4,a5
   10318:	02b00793          	li	a5,43
   1031c:	00f71863          	bne	a4,a5,1032c <strtol+0xa8>
   10320:	fd843783          	ld	a5,-40(s0)
   10324:	00178793          	addi	a5,a5,1
   10328:	fcf43c23          	sd	a5,-40(s0)
   1032c:	fbc42783          	lw	a5,-68(s0)
   10330:	0007879b          	sext.w	a5,a5
   10334:	06079c63          	bnez	a5,103ac <strtol+0x128>
   10338:	fd843783          	ld	a5,-40(s0)
   1033c:	0007c783          	lbu	a5,0(a5)
   10340:	00078713          	mv	a4,a5
   10344:	03000793          	li	a5,48
   10348:	04f71e63          	bne	a4,a5,103a4 <strtol+0x120>
   1034c:	fd843783          	ld	a5,-40(s0)
   10350:	00178793          	addi	a5,a5,1
   10354:	fcf43c23          	sd	a5,-40(s0)
   10358:	fd843783          	ld	a5,-40(s0)
   1035c:	0007c783          	lbu	a5,0(a5)
   10360:	00078713          	mv	a4,a5
   10364:	07800793          	li	a5,120
   10368:	00f70c63          	beq	a4,a5,10380 <strtol+0xfc>
   1036c:	fd843783          	ld	a5,-40(s0)
   10370:	0007c783          	lbu	a5,0(a5)
   10374:	00078713          	mv	a4,a5
   10378:	05800793          	li	a5,88
   1037c:	00f71e63          	bne	a4,a5,10398 <strtol+0x114>
   10380:	01000793          	li	a5,16
   10384:	faf42e23          	sw	a5,-68(s0)
   10388:	fd843783          	ld	a5,-40(s0)
   1038c:	00178793          	addi	a5,a5,1
   10390:	fcf43c23          	sd	a5,-40(s0)
   10394:	0180006f          	j	103ac <strtol+0x128>
   10398:	00800793          	li	a5,8
   1039c:	faf42e23          	sw	a5,-68(s0)
   103a0:	00c0006f          	j	103ac <strtol+0x128>
   103a4:	00a00793          	li	a5,10
   103a8:	faf42e23          	sw	a5,-68(s0)
   103ac:	fd843783          	ld	a5,-40(s0)
   103b0:	0007c783          	lbu	a5,0(a5)
   103b4:	00078713          	mv	a4,a5
   103b8:	02f00793          	li	a5,47
   103bc:	02e7f863          	bgeu	a5,a4,103ec <strtol+0x168>
   103c0:	fd843783          	ld	a5,-40(s0)
   103c4:	0007c783          	lbu	a5,0(a5)
   103c8:	00078713          	mv	a4,a5
   103cc:	03900793          	li	a5,57
   103d0:	00e7ee63          	bltu	a5,a4,103ec <strtol+0x168>
   103d4:	fd843783          	ld	a5,-40(s0)
   103d8:	0007c783          	lbu	a5,0(a5)
   103dc:	0007879b          	sext.w	a5,a5
   103e0:	fd07879b          	addiw	a5,a5,-48
   103e4:	fcf42a23          	sw	a5,-44(s0)
   103e8:	0800006f          	j	10468 <strtol+0x1e4>
   103ec:	fd843783          	ld	a5,-40(s0)
   103f0:	0007c783          	lbu	a5,0(a5)
   103f4:	00078713          	mv	a4,a5
   103f8:	06000793          	li	a5,96
   103fc:	02e7f863          	bgeu	a5,a4,1042c <strtol+0x1a8>
   10400:	fd843783          	ld	a5,-40(s0)
   10404:	0007c783          	lbu	a5,0(a5)
   10408:	00078713          	mv	a4,a5
   1040c:	07a00793          	li	a5,122
   10410:	00e7ee63          	bltu	a5,a4,1042c <strtol+0x1a8>
   10414:	fd843783          	ld	a5,-40(s0)
   10418:	0007c783          	lbu	a5,0(a5)
   1041c:	0007879b          	sext.w	a5,a5
   10420:	fa97879b          	addiw	a5,a5,-87
   10424:	fcf42a23          	sw	a5,-44(s0)
   10428:	0400006f          	j	10468 <strtol+0x1e4>
   1042c:	fd843783          	ld	a5,-40(s0)
   10430:	0007c783          	lbu	a5,0(a5)
   10434:	00078713          	mv	a4,a5
   10438:	04000793          	li	a5,64
   1043c:	06e7f863          	bgeu	a5,a4,104ac <strtol+0x228>
   10440:	fd843783          	ld	a5,-40(s0)
   10444:	0007c783          	lbu	a5,0(a5)
   10448:	00078713          	mv	a4,a5
   1044c:	05a00793          	li	a5,90
   10450:	04e7ee63          	bltu	a5,a4,104ac <strtol+0x228>
   10454:	fd843783          	ld	a5,-40(s0)
   10458:	0007c783          	lbu	a5,0(a5)
   1045c:	0007879b          	sext.w	a5,a5
   10460:	fc97879b          	addiw	a5,a5,-55
   10464:	fcf42a23          	sw	a5,-44(s0)
   10468:	fd442783          	lw	a5,-44(s0)
   1046c:	00078713          	mv	a4,a5
   10470:	fbc42783          	lw	a5,-68(s0)
   10474:	0007071b          	sext.w	a4,a4
   10478:	0007879b          	sext.w	a5,a5
   1047c:	02f75663          	bge	a4,a5,104a8 <strtol+0x224>
   10480:	fbc42703          	lw	a4,-68(s0)
   10484:	fe843783          	ld	a5,-24(s0)
   10488:	02f70733          	mul	a4,a4,a5
   1048c:	fd442783          	lw	a5,-44(s0)
   10490:	00f707b3          	add	a5,a4,a5
   10494:	fef43423          	sd	a5,-24(s0)
   10498:	fd843783          	ld	a5,-40(s0)
   1049c:	00178793          	addi	a5,a5,1
   104a0:	fcf43c23          	sd	a5,-40(s0)
   104a4:	f09ff06f          	j	103ac <strtol+0x128>
   104a8:	00000013          	nop
   104ac:	fc043783          	ld	a5,-64(s0)
   104b0:	00078863          	beqz	a5,104c0 <strtol+0x23c>
   104b4:	fc043783          	ld	a5,-64(s0)
   104b8:	fd843703          	ld	a4,-40(s0)
   104bc:	00e7b023          	sd	a4,0(a5)
   104c0:	fe744783          	lbu	a5,-25(s0)
   104c4:	0ff7f793          	zext.b	a5,a5
   104c8:	00078863          	beqz	a5,104d8 <strtol+0x254>
   104cc:	fe843783          	ld	a5,-24(s0)
   104d0:	40f007b3          	neg	a5,a5
   104d4:	0080006f          	j	104dc <strtol+0x258>
   104d8:	fe843783          	ld	a5,-24(s0)
   104dc:	00078513          	mv	a0,a5
   104e0:	04813083          	ld	ra,72(sp)
   104e4:	04013403          	ld	s0,64(sp)
   104e8:	05010113          	addi	sp,sp,80
   104ec:	00008067          	ret

00000000000104f0 <puts_wo_nl>:
   104f0:	fd010113          	addi	sp,sp,-48
   104f4:	02113423          	sd	ra,40(sp)
   104f8:	02813023          	sd	s0,32(sp)
   104fc:	03010413          	addi	s0,sp,48
   10500:	fca43c23          	sd	a0,-40(s0)
   10504:	fcb43823          	sd	a1,-48(s0)
   10508:	fd043783          	ld	a5,-48(s0)
   1050c:	00079863          	bnez	a5,1051c <puts_wo_nl+0x2c>
   10510:	00001797          	auipc	a5,0x1
   10514:	cb878793          	addi	a5,a5,-840 # 111c8 <printf+0x134>
   10518:	fcf43823          	sd	a5,-48(s0)
   1051c:	fd043783          	ld	a5,-48(s0)
   10520:	fef43423          	sd	a5,-24(s0)
   10524:	0240006f          	j	10548 <puts_wo_nl+0x58>
   10528:	fe843783          	ld	a5,-24(s0)
   1052c:	00178713          	addi	a4,a5,1
   10530:	fee43423          	sd	a4,-24(s0)
   10534:	0007c783          	lbu	a5,0(a5)
   10538:	0007871b          	sext.w	a4,a5
   1053c:	fd843783          	ld	a5,-40(s0)
   10540:	00070513          	mv	a0,a4
   10544:	000780e7          	jalr	a5
   10548:	fe843783          	ld	a5,-24(s0)
   1054c:	0007c783          	lbu	a5,0(a5)
   10550:	fc079ce3          	bnez	a5,10528 <puts_wo_nl+0x38>
   10554:	fe843703          	ld	a4,-24(s0)
   10558:	fd043783          	ld	a5,-48(s0)
   1055c:	40f707b3          	sub	a5,a4,a5
   10560:	0007879b          	sext.w	a5,a5
   10564:	00078513          	mv	a0,a5
   10568:	02813083          	ld	ra,40(sp)
   1056c:	02013403          	ld	s0,32(sp)
   10570:	03010113          	addi	sp,sp,48
   10574:	00008067          	ret

0000000000010578 <print_dec_int>:
   10578:	f9010113          	addi	sp,sp,-112
   1057c:	06113423          	sd	ra,104(sp)
   10580:	06813023          	sd	s0,96(sp)
   10584:	07010413          	addi	s0,sp,112
   10588:	faa43423          	sd	a0,-88(s0)
   1058c:	fab43023          	sd	a1,-96(s0)
   10590:	00060793          	mv	a5,a2
   10594:	f8d43823          	sd	a3,-112(s0)
   10598:	f8f40fa3          	sb	a5,-97(s0)
   1059c:	f9f44783          	lbu	a5,-97(s0)
   105a0:	0ff7f793          	zext.b	a5,a5
   105a4:	02078663          	beqz	a5,105d0 <print_dec_int+0x58>
   105a8:	fa043703          	ld	a4,-96(s0)
   105ac:	fff00793          	li	a5,-1
   105b0:	03f79793          	slli	a5,a5,0x3f
   105b4:	00f71e63          	bne	a4,a5,105d0 <print_dec_int+0x58>
   105b8:	00001597          	auipc	a1,0x1
   105bc:	c1858593          	addi	a1,a1,-1000 # 111d0 <printf+0x13c>
   105c0:	fa843503          	ld	a0,-88(s0)
   105c4:	f2dff0ef          	jal	104f0 <puts_wo_nl>
   105c8:	00050793          	mv	a5,a0
   105cc:	2c80006f          	j	10894 <print_dec_int+0x31c>
   105d0:	f9043783          	ld	a5,-112(s0)
   105d4:	00c7a783          	lw	a5,12(a5)
   105d8:	00079a63          	bnez	a5,105ec <print_dec_int+0x74>
   105dc:	fa043783          	ld	a5,-96(s0)
   105e0:	00079663          	bnez	a5,105ec <print_dec_int+0x74>
   105e4:	00000793          	li	a5,0
   105e8:	2ac0006f          	j	10894 <print_dec_int+0x31c>
   105ec:	fe0407a3          	sb	zero,-17(s0)
   105f0:	f9f44783          	lbu	a5,-97(s0)
   105f4:	0ff7f793          	zext.b	a5,a5
   105f8:	02078063          	beqz	a5,10618 <print_dec_int+0xa0>
   105fc:	fa043783          	ld	a5,-96(s0)
   10600:	0007dc63          	bgez	a5,10618 <print_dec_int+0xa0>
   10604:	00100793          	li	a5,1
   10608:	fef407a3          	sb	a5,-17(s0)
   1060c:	fa043783          	ld	a5,-96(s0)
   10610:	40f007b3          	neg	a5,a5
   10614:	faf43023          	sd	a5,-96(s0)
   10618:	fe042423          	sw	zero,-24(s0)
   1061c:	f9f44783          	lbu	a5,-97(s0)
   10620:	0ff7f793          	zext.b	a5,a5
   10624:	02078863          	beqz	a5,10654 <print_dec_int+0xdc>
   10628:	fef44783          	lbu	a5,-17(s0)
   1062c:	0ff7f793          	zext.b	a5,a5
   10630:	00079e63          	bnez	a5,1064c <print_dec_int+0xd4>
   10634:	f9043783          	ld	a5,-112(s0)
   10638:	0057c783          	lbu	a5,5(a5)
   1063c:	00079863          	bnez	a5,1064c <print_dec_int+0xd4>
   10640:	f9043783          	ld	a5,-112(s0)
   10644:	0047c783          	lbu	a5,4(a5)
   10648:	00078663          	beqz	a5,10654 <print_dec_int+0xdc>
   1064c:	00100793          	li	a5,1
   10650:	0080006f          	j	10658 <print_dec_int+0xe0>
   10654:	00000793          	li	a5,0
   10658:	fcf40ba3          	sb	a5,-41(s0)
   1065c:	fd744783          	lbu	a5,-41(s0)
   10660:	0017f793          	andi	a5,a5,1
   10664:	fcf40ba3          	sb	a5,-41(s0)
   10668:	fa043683          	ld	a3,-96(s0)
   1066c:	00001797          	auipc	a5,0x1
   10670:	b7c78793          	addi	a5,a5,-1156 # 111e8 <printf+0x154>
   10674:	0007b783          	ld	a5,0(a5)
   10678:	02f6b7b3          	mulhu	a5,a3,a5
   1067c:	0037d713          	srli	a4,a5,0x3
   10680:	00070793          	mv	a5,a4
   10684:	00279793          	slli	a5,a5,0x2
   10688:	00e787b3          	add	a5,a5,a4
   1068c:	00179793          	slli	a5,a5,0x1
   10690:	40f68733          	sub	a4,a3,a5
   10694:	0ff77713          	zext.b	a4,a4
   10698:	fe842783          	lw	a5,-24(s0)
   1069c:	0017869b          	addiw	a3,a5,1
   106a0:	fed42423          	sw	a3,-24(s0)
   106a4:	0307071b          	addiw	a4,a4,48
   106a8:	0ff77713          	zext.b	a4,a4
   106ac:	ff078793          	addi	a5,a5,-16
   106b0:	008787b3          	add	a5,a5,s0
   106b4:	fce78423          	sb	a4,-56(a5)
   106b8:	fa043703          	ld	a4,-96(s0)
   106bc:	00001797          	auipc	a5,0x1
   106c0:	b2c78793          	addi	a5,a5,-1236 # 111e8 <printf+0x154>
   106c4:	0007b783          	ld	a5,0(a5)
   106c8:	02f737b3          	mulhu	a5,a4,a5
   106cc:	0037d793          	srli	a5,a5,0x3
   106d0:	faf43023          	sd	a5,-96(s0)
   106d4:	fa043783          	ld	a5,-96(s0)
   106d8:	f80798e3          	bnez	a5,10668 <print_dec_int+0xf0>
   106dc:	f9043783          	ld	a5,-112(s0)
   106e0:	00c7a703          	lw	a4,12(a5)
   106e4:	fff00793          	li	a5,-1
   106e8:	02f71063          	bne	a4,a5,10708 <print_dec_int+0x190>
   106ec:	f9043783          	ld	a5,-112(s0)
   106f0:	0037c783          	lbu	a5,3(a5)
   106f4:	00078a63          	beqz	a5,10708 <print_dec_int+0x190>
   106f8:	f9043783          	ld	a5,-112(s0)
   106fc:	0087a703          	lw	a4,8(a5)
   10700:	f9043783          	ld	a5,-112(s0)
   10704:	00e7a623          	sw	a4,12(a5)
   10708:	fe042223          	sw	zero,-28(s0)
   1070c:	f9043783          	ld	a5,-112(s0)
   10710:	0087a703          	lw	a4,8(a5)
   10714:	fe842783          	lw	a5,-24(s0)
   10718:	fcf42823          	sw	a5,-48(s0)
   1071c:	f9043783          	ld	a5,-112(s0)
   10720:	00c7a783          	lw	a5,12(a5)
   10724:	fcf42623          	sw	a5,-52(s0)
   10728:	fd042783          	lw	a5,-48(s0)
   1072c:	00078593          	mv	a1,a5
   10730:	fcc42783          	lw	a5,-52(s0)
   10734:	00078613          	mv	a2,a5
   10738:	0006069b          	sext.w	a3,a2
   1073c:	0005879b          	sext.w	a5,a1
   10740:	00f6d463          	bge	a3,a5,10748 <print_dec_int+0x1d0>
   10744:	00058613          	mv	a2,a1
   10748:	0006079b          	sext.w	a5,a2
   1074c:	40f707bb          	subw	a5,a4,a5
   10750:	0007871b          	sext.w	a4,a5
   10754:	fd744783          	lbu	a5,-41(s0)
   10758:	0007879b          	sext.w	a5,a5
   1075c:	40f707bb          	subw	a5,a4,a5
   10760:	fef42023          	sw	a5,-32(s0)
   10764:	0280006f          	j	1078c <print_dec_int+0x214>
   10768:	fa843783          	ld	a5,-88(s0)
   1076c:	02000513          	li	a0,32
   10770:	000780e7          	jalr	a5
   10774:	fe442783          	lw	a5,-28(s0)
   10778:	0017879b          	addiw	a5,a5,1
   1077c:	fef42223          	sw	a5,-28(s0)
   10780:	fe042783          	lw	a5,-32(s0)
   10784:	fff7879b          	addiw	a5,a5,-1
   10788:	fef42023          	sw	a5,-32(s0)
   1078c:	fe042783          	lw	a5,-32(s0)
   10790:	0007879b          	sext.w	a5,a5
   10794:	fcf04ae3          	bgtz	a5,10768 <print_dec_int+0x1f0>
   10798:	fd744783          	lbu	a5,-41(s0)
   1079c:	0ff7f793          	zext.b	a5,a5
   107a0:	04078463          	beqz	a5,107e8 <print_dec_int+0x270>
   107a4:	fef44783          	lbu	a5,-17(s0)
   107a8:	0ff7f793          	zext.b	a5,a5
   107ac:	00078663          	beqz	a5,107b8 <print_dec_int+0x240>
   107b0:	02d00793          	li	a5,45
   107b4:	01c0006f          	j	107d0 <print_dec_int+0x258>
   107b8:	f9043783          	ld	a5,-112(s0)
   107bc:	0057c783          	lbu	a5,5(a5)
   107c0:	00078663          	beqz	a5,107cc <print_dec_int+0x254>
   107c4:	02b00793          	li	a5,43
   107c8:	0080006f          	j	107d0 <print_dec_int+0x258>
   107cc:	02000793          	li	a5,32
   107d0:	fa843703          	ld	a4,-88(s0)
   107d4:	00078513          	mv	a0,a5
   107d8:	000700e7          	jalr	a4
   107dc:	fe442783          	lw	a5,-28(s0)
   107e0:	0017879b          	addiw	a5,a5,1
   107e4:	fef42223          	sw	a5,-28(s0)
   107e8:	fe842783          	lw	a5,-24(s0)
   107ec:	fcf42e23          	sw	a5,-36(s0)
   107f0:	0280006f          	j	10818 <print_dec_int+0x2a0>
   107f4:	fa843783          	ld	a5,-88(s0)
   107f8:	03000513          	li	a0,48
   107fc:	000780e7          	jalr	a5
   10800:	fe442783          	lw	a5,-28(s0)
   10804:	0017879b          	addiw	a5,a5,1
   10808:	fef42223          	sw	a5,-28(s0)
   1080c:	fdc42783          	lw	a5,-36(s0)
   10810:	0017879b          	addiw	a5,a5,1
   10814:	fcf42e23          	sw	a5,-36(s0)
   10818:	f9043783          	ld	a5,-112(s0)
   1081c:	00c7a703          	lw	a4,12(a5)
   10820:	fd744783          	lbu	a5,-41(s0)
   10824:	0007879b          	sext.w	a5,a5
   10828:	40f707bb          	subw	a5,a4,a5
   1082c:	0007879b          	sext.w	a5,a5
   10830:	fdc42703          	lw	a4,-36(s0)
   10834:	0007071b          	sext.w	a4,a4
   10838:	faf74ee3          	blt	a4,a5,107f4 <print_dec_int+0x27c>
   1083c:	fe842783          	lw	a5,-24(s0)
   10840:	fff7879b          	addiw	a5,a5,-1
   10844:	fcf42c23          	sw	a5,-40(s0)
   10848:	03c0006f          	j	10884 <print_dec_int+0x30c>
   1084c:	fd842783          	lw	a5,-40(s0)
   10850:	ff078793          	addi	a5,a5,-16
   10854:	008787b3          	add	a5,a5,s0
   10858:	fc87c783          	lbu	a5,-56(a5)
   1085c:	0007871b          	sext.w	a4,a5
   10860:	fa843783          	ld	a5,-88(s0)
   10864:	00070513          	mv	a0,a4
   10868:	000780e7          	jalr	a5
   1086c:	fe442783          	lw	a5,-28(s0)
   10870:	0017879b          	addiw	a5,a5,1
   10874:	fef42223          	sw	a5,-28(s0)
   10878:	fd842783          	lw	a5,-40(s0)
   1087c:	fff7879b          	addiw	a5,a5,-1
   10880:	fcf42c23          	sw	a5,-40(s0)
   10884:	fd842783          	lw	a5,-40(s0)
   10888:	0007879b          	sext.w	a5,a5
   1088c:	fc07d0e3          	bgez	a5,1084c <print_dec_int+0x2d4>
   10890:	fe442783          	lw	a5,-28(s0)
   10894:	00078513          	mv	a0,a5
   10898:	06813083          	ld	ra,104(sp)
   1089c:	06013403          	ld	s0,96(sp)
   108a0:	07010113          	addi	sp,sp,112
   108a4:	00008067          	ret

00000000000108a8 <vprintfmt>:
   108a8:	f4010113          	addi	sp,sp,-192
   108ac:	0a113c23          	sd	ra,184(sp)
   108b0:	0a813823          	sd	s0,176(sp)
   108b4:	0c010413          	addi	s0,sp,192
   108b8:	f4a43c23          	sd	a0,-168(s0)
   108bc:	f4b43823          	sd	a1,-176(s0)
   108c0:	f4c43423          	sd	a2,-184(s0)
   108c4:	f8043023          	sd	zero,-128(s0)
   108c8:	f8043423          	sd	zero,-120(s0)
   108cc:	fe042623          	sw	zero,-20(s0)
   108d0:	7a00006f          	j	11070 <vprintfmt+0x7c8>
   108d4:	f8044783          	lbu	a5,-128(s0)
   108d8:	72078c63          	beqz	a5,11010 <vprintfmt+0x768>
   108dc:	f5043783          	ld	a5,-176(s0)
   108e0:	0007c783          	lbu	a5,0(a5)
   108e4:	00078713          	mv	a4,a5
   108e8:	02300793          	li	a5,35
   108ec:	00f71863          	bne	a4,a5,108fc <vprintfmt+0x54>
   108f0:	00100793          	li	a5,1
   108f4:	f8f40123          	sb	a5,-126(s0)
   108f8:	76c0006f          	j	11064 <vprintfmt+0x7bc>
   108fc:	f5043783          	ld	a5,-176(s0)
   10900:	0007c783          	lbu	a5,0(a5)
   10904:	00078713          	mv	a4,a5
   10908:	03000793          	li	a5,48
   1090c:	00f71863          	bne	a4,a5,1091c <vprintfmt+0x74>
   10910:	00100793          	li	a5,1
   10914:	f8f401a3          	sb	a5,-125(s0)
   10918:	74c0006f          	j	11064 <vprintfmt+0x7bc>
   1091c:	f5043783          	ld	a5,-176(s0)
   10920:	0007c783          	lbu	a5,0(a5)
   10924:	00078713          	mv	a4,a5
   10928:	06c00793          	li	a5,108
   1092c:	04f70063          	beq	a4,a5,1096c <vprintfmt+0xc4>
   10930:	f5043783          	ld	a5,-176(s0)
   10934:	0007c783          	lbu	a5,0(a5)
   10938:	00078713          	mv	a4,a5
   1093c:	07a00793          	li	a5,122
   10940:	02f70663          	beq	a4,a5,1096c <vprintfmt+0xc4>
   10944:	f5043783          	ld	a5,-176(s0)
   10948:	0007c783          	lbu	a5,0(a5)
   1094c:	00078713          	mv	a4,a5
   10950:	07400793          	li	a5,116
   10954:	00f70c63          	beq	a4,a5,1096c <vprintfmt+0xc4>
   10958:	f5043783          	ld	a5,-176(s0)
   1095c:	0007c783          	lbu	a5,0(a5)
   10960:	00078713          	mv	a4,a5
   10964:	06a00793          	li	a5,106
   10968:	00f71863          	bne	a4,a5,10978 <vprintfmt+0xd0>
   1096c:	00100793          	li	a5,1
   10970:	f8f400a3          	sb	a5,-127(s0)
   10974:	6f00006f          	j	11064 <vprintfmt+0x7bc>
   10978:	f5043783          	ld	a5,-176(s0)
   1097c:	0007c783          	lbu	a5,0(a5)
   10980:	00078713          	mv	a4,a5
   10984:	02b00793          	li	a5,43
   10988:	00f71863          	bne	a4,a5,10998 <vprintfmt+0xf0>
   1098c:	00100793          	li	a5,1
   10990:	f8f402a3          	sb	a5,-123(s0)
   10994:	6d00006f          	j	11064 <vprintfmt+0x7bc>
   10998:	f5043783          	ld	a5,-176(s0)
   1099c:	0007c783          	lbu	a5,0(a5)
   109a0:	00078713          	mv	a4,a5
   109a4:	02000793          	li	a5,32
   109a8:	00f71863          	bne	a4,a5,109b8 <vprintfmt+0x110>
   109ac:	00100793          	li	a5,1
   109b0:	f8f40223          	sb	a5,-124(s0)
   109b4:	6b00006f          	j	11064 <vprintfmt+0x7bc>
   109b8:	f5043783          	ld	a5,-176(s0)
   109bc:	0007c783          	lbu	a5,0(a5)
   109c0:	00078713          	mv	a4,a5
   109c4:	02a00793          	li	a5,42
   109c8:	00f71e63          	bne	a4,a5,109e4 <vprintfmt+0x13c>
   109cc:	f4843783          	ld	a5,-184(s0)
   109d0:	00878713          	addi	a4,a5,8
   109d4:	f4e43423          	sd	a4,-184(s0)
   109d8:	0007a783          	lw	a5,0(a5)
   109dc:	f8f42423          	sw	a5,-120(s0)
   109e0:	6840006f          	j	11064 <vprintfmt+0x7bc>
   109e4:	f5043783          	ld	a5,-176(s0)
   109e8:	0007c783          	lbu	a5,0(a5)
   109ec:	00078713          	mv	a4,a5
   109f0:	03000793          	li	a5,48
   109f4:	04e7f663          	bgeu	a5,a4,10a40 <vprintfmt+0x198>
   109f8:	f5043783          	ld	a5,-176(s0)
   109fc:	0007c783          	lbu	a5,0(a5)
   10a00:	00078713          	mv	a4,a5
   10a04:	03900793          	li	a5,57
   10a08:	02e7ec63          	bltu	a5,a4,10a40 <vprintfmt+0x198>
   10a0c:	f5043783          	ld	a5,-176(s0)
   10a10:	f5040713          	addi	a4,s0,-176
   10a14:	00a00613          	li	a2,10
   10a18:	00070593          	mv	a1,a4
   10a1c:	00078513          	mv	a0,a5
   10a20:	865ff0ef          	jal	10284 <strtol>
   10a24:	00050793          	mv	a5,a0
   10a28:	0007879b          	sext.w	a5,a5
   10a2c:	f8f42423          	sw	a5,-120(s0)
   10a30:	f5043783          	ld	a5,-176(s0)
   10a34:	fff78793          	addi	a5,a5,-1
   10a38:	f4f43823          	sd	a5,-176(s0)
   10a3c:	6280006f          	j	11064 <vprintfmt+0x7bc>
   10a40:	f5043783          	ld	a5,-176(s0)
   10a44:	0007c783          	lbu	a5,0(a5)
   10a48:	00078713          	mv	a4,a5
   10a4c:	02e00793          	li	a5,46
   10a50:	06f71863          	bne	a4,a5,10ac0 <vprintfmt+0x218>
   10a54:	f5043783          	ld	a5,-176(s0)
   10a58:	00178793          	addi	a5,a5,1
   10a5c:	f4f43823          	sd	a5,-176(s0)
   10a60:	f5043783          	ld	a5,-176(s0)
   10a64:	0007c783          	lbu	a5,0(a5)
   10a68:	00078713          	mv	a4,a5
   10a6c:	02a00793          	li	a5,42
   10a70:	00f71e63          	bne	a4,a5,10a8c <vprintfmt+0x1e4>
   10a74:	f4843783          	ld	a5,-184(s0)
   10a78:	00878713          	addi	a4,a5,8
   10a7c:	f4e43423          	sd	a4,-184(s0)
   10a80:	0007a783          	lw	a5,0(a5)
   10a84:	f8f42623          	sw	a5,-116(s0)
   10a88:	5dc0006f          	j	11064 <vprintfmt+0x7bc>
   10a8c:	f5043783          	ld	a5,-176(s0)
   10a90:	f5040713          	addi	a4,s0,-176
   10a94:	00a00613          	li	a2,10
   10a98:	00070593          	mv	a1,a4
   10a9c:	00078513          	mv	a0,a5
   10aa0:	fe4ff0ef          	jal	10284 <strtol>
   10aa4:	00050793          	mv	a5,a0
   10aa8:	0007879b          	sext.w	a5,a5
   10aac:	f8f42623          	sw	a5,-116(s0)
   10ab0:	f5043783          	ld	a5,-176(s0)
   10ab4:	fff78793          	addi	a5,a5,-1
   10ab8:	f4f43823          	sd	a5,-176(s0)
   10abc:	5a80006f          	j	11064 <vprintfmt+0x7bc>
   10ac0:	f5043783          	ld	a5,-176(s0)
   10ac4:	0007c783          	lbu	a5,0(a5)
   10ac8:	00078713          	mv	a4,a5
   10acc:	07800793          	li	a5,120
   10ad0:	02f70663          	beq	a4,a5,10afc <vprintfmt+0x254>
   10ad4:	f5043783          	ld	a5,-176(s0)
   10ad8:	0007c783          	lbu	a5,0(a5)
   10adc:	00078713          	mv	a4,a5
   10ae0:	05800793          	li	a5,88
   10ae4:	00f70c63          	beq	a4,a5,10afc <vprintfmt+0x254>
   10ae8:	f5043783          	ld	a5,-176(s0)
   10aec:	0007c783          	lbu	a5,0(a5)
   10af0:	00078713          	mv	a4,a5
   10af4:	07000793          	li	a5,112
   10af8:	30f71063          	bne	a4,a5,10df8 <vprintfmt+0x550>
   10afc:	f5043783          	ld	a5,-176(s0)
   10b00:	0007c783          	lbu	a5,0(a5)
   10b04:	00078713          	mv	a4,a5
   10b08:	07000793          	li	a5,112
   10b0c:	00f70663          	beq	a4,a5,10b18 <vprintfmt+0x270>
   10b10:	f8144783          	lbu	a5,-127(s0)
   10b14:	00078663          	beqz	a5,10b20 <vprintfmt+0x278>
   10b18:	00100793          	li	a5,1
   10b1c:	0080006f          	j	10b24 <vprintfmt+0x27c>
   10b20:	00000793          	li	a5,0
   10b24:	faf403a3          	sb	a5,-89(s0)
   10b28:	fa744783          	lbu	a5,-89(s0)
   10b2c:	0017f793          	andi	a5,a5,1
   10b30:	faf403a3          	sb	a5,-89(s0)
   10b34:	fa744783          	lbu	a5,-89(s0)
   10b38:	0ff7f793          	zext.b	a5,a5
   10b3c:	00078c63          	beqz	a5,10b54 <vprintfmt+0x2ac>
   10b40:	f4843783          	ld	a5,-184(s0)
   10b44:	00878713          	addi	a4,a5,8
   10b48:	f4e43423          	sd	a4,-184(s0)
   10b4c:	0007b783          	ld	a5,0(a5)
   10b50:	01c0006f          	j	10b6c <vprintfmt+0x2c4>
   10b54:	f4843783          	ld	a5,-184(s0)
   10b58:	00878713          	addi	a4,a5,8
   10b5c:	f4e43423          	sd	a4,-184(s0)
   10b60:	0007a783          	lw	a5,0(a5)
   10b64:	02079793          	slli	a5,a5,0x20
   10b68:	0207d793          	srli	a5,a5,0x20
   10b6c:	fef43023          	sd	a5,-32(s0)
   10b70:	f8c42783          	lw	a5,-116(s0)
   10b74:	02079463          	bnez	a5,10b9c <vprintfmt+0x2f4>
   10b78:	fe043783          	ld	a5,-32(s0)
   10b7c:	02079063          	bnez	a5,10b9c <vprintfmt+0x2f4>
   10b80:	f5043783          	ld	a5,-176(s0)
   10b84:	0007c783          	lbu	a5,0(a5)
   10b88:	00078713          	mv	a4,a5
   10b8c:	07000793          	li	a5,112
   10b90:	00f70663          	beq	a4,a5,10b9c <vprintfmt+0x2f4>
   10b94:	f8040023          	sb	zero,-128(s0)
   10b98:	4cc0006f          	j	11064 <vprintfmt+0x7bc>
   10b9c:	f5043783          	ld	a5,-176(s0)
   10ba0:	0007c783          	lbu	a5,0(a5)
   10ba4:	00078713          	mv	a4,a5
   10ba8:	07000793          	li	a5,112
   10bac:	00f70a63          	beq	a4,a5,10bc0 <vprintfmt+0x318>
   10bb0:	f8244783          	lbu	a5,-126(s0)
   10bb4:	00078a63          	beqz	a5,10bc8 <vprintfmt+0x320>
   10bb8:	fe043783          	ld	a5,-32(s0)
   10bbc:	00078663          	beqz	a5,10bc8 <vprintfmt+0x320>
   10bc0:	00100793          	li	a5,1
   10bc4:	0080006f          	j	10bcc <vprintfmt+0x324>
   10bc8:	00000793          	li	a5,0
   10bcc:	faf40323          	sb	a5,-90(s0)
   10bd0:	fa644783          	lbu	a5,-90(s0)
   10bd4:	0017f793          	andi	a5,a5,1
   10bd8:	faf40323          	sb	a5,-90(s0)
   10bdc:	fc042e23          	sw	zero,-36(s0)
   10be0:	f5043783          	ld	a5,-176(s0)
   10be4:	0007c783          	lbu	a5,0(a5)
   10be8:	00078713          	mv	a4,a5
   10bec:	05800793          	li	a5,88
   10bf0:	00f71863          	bne	a4,a5,10c00 <vprintfmt+0x358>
   10bf4:	00000797          	auipc	a5,0x0
   10bf8:	5fc78793          	addi	a5,a5,1532 # 111f0 <upperxdigits.1>
   10bfc:	00c0006f          	j	10c08 <vprintfmt+0x360>
   10c00:	00000797          	auipc	a5,0x0
   10c04:	60878793          	addi	a5,a5,1544 # 11208 <lowerxdigits.0>
   10c08:	f8f43c23          	sd	a5,-104(s0)
   10c0c:	fe043783          	ld	a5,-32(s0)
   10c10:	00f7f793          	andi	a5,a5,15
   10c14:	f9843703          	ld	a4,-104(s0)
   10c18:	00f70733          	add	a4,a4,a5
   10c1c:	fdc42783          	lw	a5,-36(s0)
   10c20:	0017869b          	addiw	a3,a5,1
   10c24:	fcd42e23          	sw	a3,-36(s0)
   10c28:	00074703          	lbu	a4,0(a4)
   10c2c:	ff078793          	addi	a5,a5,-16
   10c30:	008787b3          	add	a5,a5,s0
   10c34:	f8e78023          	sb	a4,-128(a5)
   10c38:	fe043783          	ld	a5,-32(s0)
   10c3c:	0047d793          	srli	a5,a5,0x4
   10c40:	fef43023          	sd	a5,-32(s0)
   10c44:	fe043783          	ld	a5,-32(s0)
   10c48:	fc0792e3          	bnez	a5,10c0c <vprintfmt+0x364>
   10c4c:	f8c42703          	lw	a4,-116(s0)
   10c50:	fff00793          	li	a5,-1
   10c54:	02f71663          	bne	a4,a5,10c80 <vprintfmt+0x3d8>
   10c58:	f8344783          	lbu	a5,-125(s0)
   10c5c:	02078263          	beqz	a5,10c80 <vprintfmt+0x3d8>
   10c60:	f8842703          	lw	a4,-120(s0)
   10c64:	fa644783          	lbu	a5,-90(s0)
   10c68:	0007879b          	sext.w	a5,a5
   10c6c:	0017979b          	slliw	a5,a5,0x1
   10c70:	0007879b          	sext.w	a5,a5
   10c74:	40f707bb          	subw	a5,a4,a5
   10c78:	0007879b          	sext.w	a5,a5
   10c7c:	f8f42623          	sw	a5,-116(s0)
   10c80:	f8842703          	lw	a4,-120(s0)
   10c84:	fa644783          	lbu	a5,-90(s0)
   10c88:	0007879b          	sext.w	a5,a5
   10c8c:	0017979b          	slliw	a5,a5,0x1
   10c90:	0007879b          	sext.w	a5,a5
   10c94:	40f707bb          	subw	a5,a4,a5
   10c98:	0007871b          	sext.w	a4,a5
   10c9c:	fdc42783          	lw	a5,-36(s0)
   10ca0:	f8f42a23          	sw	a5,-108(s0)
   10ca4:	f8c42783          	lw	a5,-116(s0)
   10ca8:	f8f42823          	sw	a5,-112(s0)
   10cac:	f9442783          	lw	a5,-108(s0)
   10cb0:	00078593          	mv	a1,a5
   10cb4:	f9042783          	lw	a5,-112(s0)
   10cb8:	00078613          	mv	a2,a5
   10cbc:	0006069b          	sext.w	a3,a2
   10cc0:	0005879b          	sext.w	a5,a1
   10cc4:	00f6d463          	bge	a3,a5,10ccc <vprintfmt+0x424>
   10cc8:	00058613          	mv	a2,a1
   10ccc:	0006079b          	sext.w	a5,a2
   10cd0:	40f707bb          	subw	a5,a4,a5
   10cd4:	fcf42c23          	sw	a5,-40(s0)
   10cd8:	0280006f          	j	10d00 <vprintfmt+0x458>
   10cdc:	f5843783          	ld	a5,-168(s0)
   10ce0:	02000513          	li	a0,32
   10ce4:	000780e7          	jalr	a5
   10ce8:	fec42783          	lw	a5,-20(s0)
   10cec:	0017879b          	addiw	a5,a5,1
   10cf0:	fef42623          	sw	a5,-20(s0)
   10cf4:	fd842783          	lw	a5,-40(s0)
   10cf8:	fff7879b          	addiw	a5,a5,-1
   10cfc:	fcf42c23          	sw	a5,-40(s0)
   10d00:	fd842783          	lw	a5,-40(s0)
   10d04:	0007879b          	sext.w	a5,a5
   10d08:	fcf04ae3          	bgtz	a5,10cdc <vprintfmt+0x434>
   10d0c:	fa644783          	lbu	a5,-90(s0)
   10d10:	0ff7f793          	zext.b	a5,a5
   10d14:	04078463          	beqz	a5,10d5c <vprintfmt+0x4b4>
   10d18:	f5843783          	ld	a5,-168(s0)
   10d1c:	03000513          	li	a0,48
   10d20:	000780e7          	jalr	a5
   10d24:	f5043783          	ld	a5,-176(s0)
   10d28:	0007c783          	lbu	a5,0(a5)
   10d2c:	00078713          	mv	a4,a5
   10d30:	05800793          	li	a5,88
   10d34:	00f71663          	bne	a4,a5,10d40 <vprintfmt+0x498>
   10d38:	05800793          	li	a5,88
   10d3c:	0080006f          	j	10d44 <vprintfmt+0x49c>
   10d40:	07800793          	li	a5,120
   10d44:	f5843703          	ld	a4,-168(s0)
   10d48:	00078513          	mv	a0,a5
   10d4c:	000700e7          	jalr	a4
   10d50:	fec42783          	lw	a5,-20(s0)
   10d54:	0027879b          	addiw	a5,a5,2
   10d58:	fef42623          	sw	a5,-20(s0)
   10d5c:	fdc42783          	lw	a5,-36(s0)
   10d60:	fcf42a23          	sw	a5,-44(s0)
   10d64:	0280006f          	j	10d8c <vprintfmt+0x4e4>
   10d68:	f5843783          	ld	a5,-168(s0)
   10d6c:	03000513          	li	a0,48
   10d70:	000780e7          	jalr	a5
   10d74:	fec42783          	lw	a5,-20(s0)
   10d78:	0017879b          	addiw	a5,a5,1
   10d7c:	fef42623          	sw	a5,-20(s0)
   10d80:	fd442783          	lw	a5,-44(s0)
   10d84:	0017879b          	addiw	a5,a5,1
   10d88:	fcf42a23          	sw	a5,-44(s0)
   10d8c:	f8c42783          	lw	a5,-116(s0)
   10d90:	fd442703          	lw	a4,-44(s0)
   10d94:	0007071b          	sext.w	a4,a4
   10d98:	fcf748e3          	blt	a4,a5,10d68 <vprintfmt+0x4c0>
   10d9c:	fdc42783          	lw	a5,-36(s0)
   10da0:	fff7879b          	addiw	a5,a5,-1
   10da4:	fcf42823          	sw	a5,-48(s0)
   10da8:	03c0006f          	j	10de4 <vprintfmt+0x53c>
   10dac:	fd042783          	lw	a5,-48(s0)
   10db0:	ff078793          	addi	a5,a5,-16
   10db4:	008787b3          	add	a5,a5,s0
   10db8:	f807c783          	lbu	a5,-128(a5)
   10dbc:	0007871b          	sext.w	a4,a5
   10dc0:	f5843783          	ld	a5,-168(s0)
   10dc4:	00070513          	mv	a0,a4
   10dc8:	000780e7          	jalr	a5
   10dcc:	fec42783          	lw	a5,-20(s0)
   10dd0:	0017879b          	addiw	a5,a5,1
   10dd4:	fef42623          	sw	a5,-20(s0)
   10dd8:	fd042783          	lw	a5,-48(s0)
   10ddc:	fff7879b          	addiw	a5,a5,-1
   10de0:	fcf42823          	sw	a5,-48(s0)
   10de4:	fd042783          	lw	a5,-48(s0)
   10de8:	0007879b          	sext.w	a5,a5
   10dec:	fc07d0e3          	bgez	a5,10dac <vprintfmt+0x504>
   10df0:	f8040023          	sb	zero,-128(s0)
   10df4:	2700006f          	j	11064 <vprintfmt+0x7bc>
   10df8:	f5043783          	ld	a5,-176(s0)
   10dfc:	0007c783          	lbu	a5,0(a5)
   10e00:	00078713          	mv	a4,a5
   10e04:	06400793          	li	a5,100
   10e08:	02f70663          	beq	a4,a5,10e34 <vprintfmt+0x58c>
   10e0c:	f5043783          	ld	a5,-176(s0)
   10e10:	0007c783          	lbu	a5,0(a5)
   10e14:	00078713          	mv	a4,a5
   10e18:	06900793          	li	a5,105
   10e1c:	00f70c63          	beq	a4,a5,10e34 <vprintfmt+0x58c>
   10e20:	f5043783          	ld	a5,-176(s0)
   10e24:	0007c783          	lbu	a5,0(a5)
   10e28:	00078713          	mv	a4,a5
   10e2c:	07500793          	li	a5,117
   10e30:	08f71063          	bne	a4,a5,10eb0 <vprintfmt+0x608>
   10e34:	f8144783          	lbu	a5,-127(s0)
   10e38:	00078c63          	beqz	a5,10e50 <vprintfmt+0x5a8>
   10e3c:	f4843783          	ld	a5,-184(s0)
   10e40:	00878713          	addi	a4,a5,8
   10e44:	f4e43423          	sd	a4,-184(s0)
   10e48:	0007b783          	ld	a5,0(a5)
   10e4c:	0140006f          	j	10e60 <vprintfmt+0x5b8>
   10e50:	f4843783          	ld	a5,-184(s0)
   10e54:	00878713          	addi	a4,a5,8
   10e58:	f4e43423          	sd	a4,-184(s0)
   10e5c:	0007a783          	lw	a5,0(a5)
   10e60:	faf43423          	sd	a5,-88(s0)
   10e64:	fa843583          	ld	a1,-88(s0)
   10e68:	f5043783          	ld	a5,-176(s0)
   10e6c:	0007c783          	lbu	a5,0(a5)
   10e70:	0007871b          	sext.w	a4,a5
   10e74:	07500793          	li	a5,117
   10e78:	40f707b3          	sub	a5,a4,a5
   10e7c:	00f037b3          	snez	a5,a5
   10e80:	0ff7f793          	zext.b	a5,a5
   10e84:	f8040713          	addi	a4,s0,-128
   10e88:	00070693          	mv	a3,a4
   10e8c:	00078613          	mv	a2,a5
   10e90:	f5843503          	ld	a0,-168(s0)
   10e94:	ee4ff0ef          	jal	10578 <print_dec_int>
   10e98:	00050793          	mv	a5,a0
   10e9c:	fec42703          	lw	a4,-20(s0)
   10ea0:	00f707bb          	addw	a5,a4,a5
   10ea4:	fef42623          	sw	a5,-20(s0)
   10ea8:	f8040023          	sb	zero,-128(s0)
   10eac:	1b80006f          	j	11064 <vprintfmt+0x7bc>
   10eb0:	f5043783          	ld	a5,-176(s0)
   10eb4:	0007c783          	lbu	a5,0(a5)
   10eb8:	00078713          	mv	a4,a5
   10ebc:	06e00793          	li	a5,110
   10ec0:	04f71c63          	bne	a4,a5,10f18 <vprintfmt+0x670>
   10ec4:	f8144783          	lbu	a5,-127(s0)
   10ec8:	02078463          	beqz	a5,10ef0 <vprintfmt+0x648>
   10ecc:	f4843783          	ld	a5,-184(s0)
   10ed0:	00878713          	addi	a4,a5,8
   10ed4:	f4e43423          	sd	a4,-184(s0)
   10ed8:	0007b783          	ld	a5,0(a5)
   10edc:	faf43823          	sd	a5,-80(s0)
   10ee0:	fec42703          	lw	a4,-20(s0)
   10ee4:	fb043783          	ld	a5,-80(s0)
   10ee8:	00e7b023          	sd	a4,0(a5)
   10eec:	0240006f          	j	10f10 <vprintfmt+0x668>
   10ef0:	f4843783          	ld	a5,-184(s0)
   10ef4:	00878713          	addi	a4,a5,8
   10ef8:	f4e43423          	sd	a4,-184(s0)
   10efc:	0007b783          	ld	a5,0(a5)
   10f00:	faf43c23          	sd	a5,-72(s0)
   10f04:	fb843783          	ld	a5,-72(s0)
   10f08:	fec42703          	lw	a4,-20(s0)
   10f0c:	00e7a023          	sw	a4,0(a5)
   10f10:	f8040023          	sb	zero,-128(s0)
   10f14:	1500006f          	j	11064 <vprintfmt+0x7bc>
   10f18:	f5043783          	ld	a5,-176(s0)
   10f1c:	0007c783          	lbu	a5,0(a5)
   10f20:	00078713          	mv	a4,a5
   10f24:	07300793          	li	a5,115
   10f28:	02f71e63          	bne	a4,a5,10f64 <vprintfmt+0x6bc>
   10f2c:	f4843783          	ld	a5,-184(s0)
   10f30:	00878713          	addi	a4,a5,8
   10f34:	f4e43423          	sd	a4,-184(s0)
   10f38:	0007b783          	ld	a5,0(a5)
   10f3c:	fcf43023          	sd	a5,-64(s0)
   10f40:	fc043583          	ld	a1,-64(s0)
   10f44:	f5843503          	ld	a0,-168(s0)
   10f48:	da8ff0ef          	jal	104f0 <puts_wo_nl>
   10f4c:	00050793          	mv	a5,a0
   10f50:	fec42703          	lw	a4,-20(s0)
   10f54:	00f707bb          	addw	a5,a4,a5
   10f58:	fef42623          	sw	a5,-20(s0)
   10f5c:	f8040023          	sb	zero,-128(s0)
   10f60:	1040006f          	j	11064 <vprintfmt+0x7bc>
   10f64:	f5043783          	ld	a5,-176(s0)
   10f68:	0007c783          	lbu	a5,0(a5)
   10f6c:	00078713          	mv	a4,a5
   10f70:	06300793          	li	a5,99
   10f74:	02f71e63          	bne	a4,a5,10fb0 <vprintfmt+0x708>
   10f78:	f4843783          	ld	a5,-184(s0)
   10f7c:	00878713          	addi	a4,a5,8
   10f80:	f4e43423          	sd	a4,-184(s0)
   10f84:	0007a783          	lw	a5,0(a5)
   10f88:	fcf42623          	sw	a5,-52(s0)
   10f8c:	fcc42703          	lw	a4,-52(s0)
   10f90:	f5843783          	ld	a5,-168(s0)
   10f94:	00070513          	mv	a0,a4
   10f98:	000780e7          	jalr	a5
   10f9c:	fec42783          	lw	a5,-20(s0)
   10fa0:	0017879b          	addiw	a5,a5,1
   10fa4:	fef42623          	sw	a5,-20(s0)
   10fa8:	f8040023          	sb	zero,-128(s0)
   10fac:	0b80006f          	j	11064 <vprintfmt+0x7bc>
   10fb0:	f5043783          	ld	a5,-176(s0)
   10fb4:	0007c783          	lbu	a5,0(a5)
   10fb8:	00078713          	mv	a4,a5
   10fbc:	02500793          	li	a5,37
   10fc0:	02f71263          	bne	a4,a5,10fe4 <vprintfmt+0x73c>
   10fc4:	f5843783          	ld	a5,-168(s0)
   10fc8:	02500513          	li	a0,37
   10fcc:	000780e7          	jalr	a5
   10fd0:	fec42783          	lw	a5,-20(s0)
   10fd4:	0017879b          	addiw	a5,a5,1
   10fd8:	fef42623          	sw	a5,-20(s0)
   10fdc:	f8040023          	sb	zero,-128(s0)
   10fe0:	0840006f          	j	11064 <vprintfmt+0x7bc>
   10fe4:	f5043783          	ld	a5,-176(s0)
   10fe8:	0007c783          	lbu	a5,0(a5)
   10fec:	0007871b          	sext.w	a4,a5
   10ff0:	f5843783          	ld	a5,-168(s0)
   10ff4:	00070513          	mv	a0,a4
   10ff8:	000780e7          	jalr	a5
   10ffc:	fec42783          	lw	a5,-20(s0)
   11000:	0017879b          	addiw	a5,a5,1
   11004:	fef42623          	sw	a5,-20(s0)
   11008:	f8040023          	sb	zero,-128(s0)
   1100c:	0580006f          	j	11064 <vprintfmt+0x7bc>
   11010:	f5043783          	ld	a5,-176(s0)
   11014:	0007c783          	lbu	a5,0(a5)
   11018:	00078713          	mv	a4,a5
   1101c:	02500793          	li	a5,37
   11020:	02f71063          	bne	a4,a5,11040 <vprintfmt+0x798>
   11024:	f8043023          	sd	zero,-128(s0)
   11028:	f8043423          	sd	zero,-120(s0)
   1102c:	00100793          	li	a5,1
   11030:	f8f40023          	sb	a5,-128(s0)
   11034:	fff00793          	li	a5,-1
   11038:	f8f42623          	sw	a5,-116(s0)
   1103c:	0280006f          	j	11064 <vprintfmt+0x7bc>
   11040:	f5043783          	ld	a5,-176(s0)
   11044:	0007c783          	lbu	a5,0(a5)
   11048:	0007871b          	sext.w	a4,a5
   1104c:	f5843783          	ld	a5,-168(s0)
   11050:	00070513          	mv	a0,a4
   11054:	000780e7          	jalr	a5
   11058:	fec42783          	lw	a5,-20(s0)
   1105c:	0017879b          	addiw	a5,a5,1
   11060:	fef42623          	sw	a5,-20(s0)
   11064:	f5043783          	ld	a5,-176(s0)
   11068:	00178793          	addi	a5,a5,1
   1106c:	f4f43823          	sd	a5,-176(s0)
   11070:	f5043783          	ld	a5,-176(s0)
   11074:	0007c783          	lbu	a5,0(a5)
   11078:	84079ee3          	bnez	a5,108d4 <vprintfmt+0x2c>
   1107c:	fec42783          	lw	a5,-20(s0)
   11080:	00078513          	mv	a0,a5
   11084:	0b813083          	ld	ra,184(sp)
   11088:	0b013403          	ld	s0,176(sp)
   1108c:	0c010113          	addi	sp,sp,192
   11090:	00008067          	ret

0000000000011094 <printf>:
   11094:	f8010113          	addi	sp,sp,-128
   11098:	02113c23          	sd	ra,56(sp)
   1109c:	02813823          	sd	s0,48(sp)
   110a0:	04010413          	addi	s0,sp,64
   110a4:	fca43423          	sd	a0,-56(s0)
   110a8:	00b43423          	sd	a1,8(s0)
   110ac:	00c43823          	sd	a2,16(s0)
   110b0:	00d43c23          	sd	a3,24(s0)
   110b4:	02e43023          	sd	a4,32(s0)
   110b8:	02f43423          	sd	a5,40(s0)
   110bc:	03043823          	sd	a6,48(s0)
   110c0:	03143c23          	sd	a7,56(s0)
   110c4:	fe042623          	sw	zero,-20(s0)
   110c8:	04040793          	addi	a5,s0,64
   110cc:	fcf43023          	sd	a5,-64(s0)
   110d0:	fc043783          	ld	a5,-64(s0)
   110d4:	fc878793          	addi	a5,a5,-56
   110d8:	fcf43823          	sd	a5,-48(s0)
   110dc:	fd043783          	ld	a5,-48(s0)
   110e0:	00078613          	mv	a2,a5
   110e4:	fc843583          	ld	a1,-56(s0)
   110e8:	fffff517          	auipc	a0,0xfffff
   110ec:	0c450513          	addi	a0,a0,196 # 101ac <putc>
   110f0:	fb8ff0ef          	jal	108a8 <vprintfmt>
   110f4:	00050793          	mv	a5,a0
   110f8:	fef42623          	sw	a5,-20(s0)
   110fc:	00100793          	li	a5,1
   11100:	fef43023          	sd	a5,-32(s0)
   11104:	00001797          	auipc	a5,0x1
   11108:	f0078793          	addi	a5,a5,-256 # 12004 <tail>
   1110c:	0007a783          	lw	a5,0(a5)
   11110:	0017871b          	addiw	a4,a5,1
   11114:	0007069b          	sext.w	a3,a4
   11118:	00001717          	auipc	a4,0x1
   1111c:	eec70713          	addi	a4,a4,-276 # 12004 <tail>
   11120:	00d72023          	sw	a3,0(a4)
   11124:	00001717          	auipc	a4,0x1
   11128:	ee470713          	addi	a4,a4,-284 # 12008 <buffer>
   1112c:	00f707b3          	add	a5,a4,a5
   11130:	00078023          	sb	zero,0(a5)
   11134:	00001797          	auipc	a5,0x1
   11138:	ed078793          	addi	a5,a5,-304 # 12004 <tail>
   1113c:	0007a603          	lw	a2,0(a5)
   11140:	fe043703          	ld	a4,-32(s0)
   11144:	00001697          	auipc	a3,0x1
   11148:	ec468693          	addi	a3,a3,-316 # 12008 <buffer>
   1114c:	fd843783          	ld	a5,-40(s0)
   11150:	04000893          	li	a7,64
   11154:	00070513          	mv	a0,a4
   11158:	00068593          	mv	a1,a3
   1115c:	00060613          	mv	a2,a2
   11160:	00000073          	ecall
   11164:	00050793          	mv	a5,a0
   11168:	fcf43c23          	sd	a5,-40(s0)
   1116c:	00001797          	auipc	a5,0x1
   11170:	e9878793          	addi	a5,a5,-360 # 12004 <tail>
   11174:	0007a023          	sw	zero,0(a5)
   11178:	fec42783          	lw	a5,-20(s0)
   1117c:	00078513          	mv	a0,a5
   11180:	03813083          	ld	ra,56(sp)
   11184:	03013403          	ld	s0,48(sp)
   11188:	08010113          	addi	sp,sp,128
   1118c:	00008067          	ret
