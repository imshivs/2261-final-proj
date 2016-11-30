	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.arm
	.syntax divided
	.file	"main.c"
	.text
	.align	2
	.global	interruptHandler
	.type	interruptHandler, %function
interruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L11
	ldrh	r2, [r3, #2]
	tst	r2, #1
	mov	r1, #0
	beq	.L9
	ldr	ip, .L11+4
	ldr	r3, .L11+8
	ldr	r2, [ip]
	str	lr, [sp, #-4]!
	ldr	lr, [r3, #20]
	add	r2, r2, #1
	cmp	r2, lr
	str	r2, [ip]
	ldrgt	r2, .L11+12
	ldrgt	r2, [r2]
	ldr	r0, .L11+16
	strgt	r1, [r2, #20]
	ldr	r2, .L11+20
	ldr	r3, [r0]
	ldr	r2, [r2, #20]
	add	r3, r3, #1
	cmp	r3, r2
	movgt	r2, #0
	str	r3, [r0]
	ldrgt	r3, .L11+12
	ldrgt	r3, [r3]
	strgt	r2, [r3, #32]
	mov	r2, #1
	ldr	r3, .L11
	strh	r2, [r3, #2]	@ movhi
	mov	r2, #1
	ldr	r3, .L11
	ldr	lr, [sp], #4
	strh	r2, [r3, #8]	@ movhi
	bx	lr
.L9:
	mov	r2, #1
	ldr	r3, .L11
	strh	r2, [r3, #8]	@ movhi
	bx	lr
.L12:
	.align	2
.L11:
	.word	67109376
	.word	vbCountA
	.word	soundA
	.word	dma
	.word	vbCountB
	.word	soundB
	.size	interruptHandler, .-interruptHandler
	.align	2
	.global	win
	.type	win, %function
win:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r4, #67108864
	ldr	r3, .L20
	ldr	r0, .L20+4
	strh	r3, [r4]	@ movhi
	ldr	r3, .L20+8
	mov	lr, pc
	bx	r3
	ldr	r0, .L20+12
	ldr	r3, .L20+16
	mov	lr, pc
	bx	r3
	mov	r2, #35
	ldr	r1, .L20+20
	ldr	r3, .L20+24
	ldr	r0, .L20+28
	mov	lr, pc
	bx	r3
	ldr	r5, .L20+32
	ldr	r2, .L20+28
	mov	r1, #20
	mov	r0, #55
	mov	r3, #250
	mov	lr, pc
	bx	r5
	ldr	r3, .L20+36
	mov	lr, pc
	bx	r3
	ldr	r0, .L20+40
	mov	r1, r4
	ldr	r2, [r0]
	ldr	ip, .L20+44
	b	.L14
.L15:
	mov	r2, r3
.L14:
	str	r2, [ip]
	ldr	r3, [r1, #304]
	tst	r2, #8
	str	r3, [r0]
	beq	.L15
	ands	r2, r3, #8
	bne	.L15
	ldr	r3, .L20+48
	ldmfd	sp!, {r4, r5, r6, lr}
	str	r2, [r3]
	bx	lr
.L21:
	.align	2
.L20:
	.word	1028
	.word	winPal
	.word	loadPalette
	.word	winBitmap
	.word	drawBackgroundImage4
	.word	.LC0
	.word	memcpy
	.word	buffer
	.word	drawString4
	.word	flipPage
	.word	buttons
	.word	oldButtons
	.word	.LANCHOR0
	.size	win, .-win
	.align	2
	.global	lose
	.type	lose, %function
lose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L29
	stmfd	sp!, {r4, lr}
	ldr	r3, .L29+4
	mov	lr, pc
	bx	r3
	ldr	r3, .L29+8
	mov	lr, pc
	bx	r3
	ldr	r1, .L29+12
	ldr	ip, .L29+16
	ldr	r2, [r1]
	mov	r0, #67108864
	b	.L23
.L24:
	mov	r2, r3
.L23:
	str	r2, [ip]
	ldr	r3, [r0, #304]
	tst	r2, #8
	str	r3, [r1]
	beq	.L24
	ands	r2, r3, #8
	bne	.L24
	ldr	r3, .L29+20
	ldmfd	sp!, {r4, lr}
	str	r2, [r3]
	bx	lr
.L30:
	.align	2
.L29:
	.word	loseBitmap
	.word	drawBackgroundImage4
	.word	flipPage
	.word	buttons
	.word	oldButtons
	.word	.LANCHOR0
	.size	lose, .-lose
	.align	2
	.global	pause
	.type	pause, %function
pause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r8, #67108864
	ldr	r7, .L43
	ldr	r6, .L43+4
	ldr	r4, .L43+8
	ldr	r5, .L43+12
.L38:
	ldr	r0, .L43+16
	mov	lr, pc
	bx	r7
	mov	lr, pc
	bx	r6
	ldr	r2, [r4]
	str	r2, [r5]
	ldr	r3, [r8, #304]
	tst	r2, #8
	str	r3, [r4]
	beq	.L32
	tst	r3, #8
	beq	.L42
.L32:
	tst	r2, #4
	beq	.L38
	ands	r3, r3, #4
	bne	.L38
	ldr	r2, .L43+20
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	str	r3, [r2]
	bx	lr
.L42:
	mov	r3, #1
	mov	r1, #128
	ldr	r2, .L43+24
	ldr	lr, .L43+28
	ldr	ip, .L43+32
	ldr	r0, .L43+20
	strh	r1, [r2, #2]	@ movhi
	str	r3, [lr, #12]
	strh	r1, [r2, #6]	@ movhi
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	str	r3, [ip, #12]
	str	r3, [r0]
	bx	lr
.L44:
	.align	2
.L43:
	.word	drawBackgroundImage4
	.word	flipPage
	.word	buttons
	.word	oldButtons
	.word	pauseBitmap
	.word	.LANCHOR0
	.word	67109120
	.word	soundA
	.word	soundB
	.size	pause, .-pause
	.global	__aeabi_i2f
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r3, #0
	mov	r5, #4
	mov	r9, r3
	mov	r6, r5
	mov	r7, #0
	ldr	r0, .L49
	ldr	r1, .L49+4
	ldr	r2, .L49+8
	str	r3, [r0]
	str	r3, [r1]
	str	r3, [r2]
	ldr	r4, .L49+12
	ldr	r8, .L49+16
.L46:
	mov	r0, r5
	str	r6, [r4, #24]
	str	r6, [r4, #28]
	str	r7, [r4, #8]	@ float
	str	r9, [r4, #12]
	mov	lr, pc
	bx	r8
	add	r5, r5, #4
	cmp	r5, #44
	str	r0, [r4]	@ float
	str	r6, [r4, #4]
	mov	r1, #0
	add	r4, r4, #56
	mov	r3, #0
	bne	.L46
	mov	r6, #230
	mov	r5, #16
	ldr	r0, .L49+20
	mov	r2, #8
	str	r1, [r0, #8]	@ float
	str	r1, [r0]	@ float
	ldr	r1, .L49+24
	str	r6, [r0, #12]
	str	r6, [r0, #4]
	add	r6, r6, #180
	str	r6, [r1, #68]
	ldr	r6, .L49+28
	mov	r4, #1
	str	r5, [r6, #24]
	str	r5, [r6, #28]
	mov	r5, #1065353216
	mov	lr, #360
	mov	fp, #200
	mov	r10, #2
	str	r2, [r0, #24]
	str	r2, [r0, #28]
	ldr	r0, .L49+32
	str	r0, [r1, #8]	@ float
	ldr	r0, .L49+36
	str	r5, [r6, #16]	@ float
	str	r0, [r1, #64]	@ float
	str	r4, [r6, #20]
	ldr	r0, .L49+40
	str	r4, [r6, #4]
	ldr	r5, .L49+44
	ldr	r4, .L49+48
	str	r2, [r1, #24]
	str	r2, [r1, #28]
	str	r3, [r1, #52]
	str	r2, [r1, #80]
	str	r2, [r1, #84]
	str	r3, [r1, #108]
	str	r2, [r1, #136]
	str	r2, [r1, #140]
	str	r3, [r1, #164]
	str	r2, [r1, #192]
	str	r2, [r1, #196]
	str	fp, [r1, #124]
	str	lr, [r1, #12]
	str	r0, [r1, #120]	@ float
	str	r3, [r6, #32]
	str	r3, [r6, #44]
	str	r10, [r6, #36]
	str	r5, [r6]	@ float
	str	r4, [r1, #176]	@ float
	str	lr, [r1, #404]
	ldr	lr, .L49+52
	mov	r9, #100
	str	lr, [r1, #400]	@ float
	mov	r8, #250
	mov	r7, #80
	mov	ip, #500
	mov	lr, #400
	str	r2, [r1, #248]
	str	r2, [r1, #252]
	str	r2, [r1, #304]
	str	r2, [r1, #308]
	str	r0, [r1, #288]	@ float
	str	r2, [r1, #360]
	str	r2, [r1, #364]
	str	r2, [r1, #416]
	str	r2, [r1, #420]
	str	r2, [r1, #472]
	str	r2, [r1, #476]
	str	r2, [r1, #528]
	str	r2, [r1, #532]
	ldr	r0, .L49+56
	ldr	r2, .L49+60
	str	r3, [r1, #220]
	str	r4, [r1, #232]	@ float
	str	r3, [r1, #276]
	str	r3, [r1, #332]
	str	r3, [r1, #388]
	str	r3, [r1, #444]
	str	r3, [r1, #500]
	str	r3, [r1, #556]
	str	r9, [r1, #180]
	str	r8, [r1, #236]
	str	r7, [r1, #292]
	str	r2, [r1, #344]	@ float
	str	lr, [r1, #460]
	str	ip, [r1, #348]
	str	ip, [r1, #516]
	str	r0, [r1, #456]	@ float
	str	r0, [r1, #512]	@ float
	mov	r1, #96
	ldr	r2, .L49+64
	stmib	r2, {r1, r3}
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L50:
	.align	2
.L49:
	.word	cheeseCount
	.word	timer
	.word	cheat
	.word	score
	.word	__aeabi_i2f
	.word	clock
	.word	cheese
	.word	mouse
	.word	1127481344
	.word	1126170624
	.word	1128792064
	.word	1124204544
	.word	1121845248
	.word	1114636288
	.word	1120403456
	.word	1131085824
	.word	.LANCHOR0
	.size	initialize, .-initialize
	.align	2
	.global	splash
	.type	splash, %function
splash:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r4, #67108864
	ldr	r3, .L64
	ldr	r6, .L64+4
	strh	r3, [r4]	@ movhi
	mov	lr, pc
	bx	r6
	ldr	r3, .L64+8
	ldr	r0, .L64+12
	mov	lr, pc
	bx	r3
	ldr	r5, .L64+16
	ldr	r0, .L64+20
	mov	lr, pc
	bx	r5
	ldr	r3, .L64+24
	mov	lr, pc
	bx	r3
	mov	lr, pc
	bx	r6
	ldr	r0, .L64+20
	mov	lr, pc
	bx	r5
	ldr	r0, .L64+28
	mov	r1, r4
	ldr	r3, [r0]
	ldr	ip, .L64+32
	b	.L52
.L53:
	tst	r3, #4
	beq	.L55
	tst	r2, #4
	beq	.L63
.L55:
	mov	r3, r2
.L52:
	str	r3, [ip]
	ldr	r2, [r1, #304]
	tst	r3, #8
	str	r2, [r0]
	beq	.L53
	tst	r2, #8
	bne	.L53
	bl	initialize
	mov	r2, #1
	ldr	r3, .L64+36
	ldmfd	sp!, {r4, r5, r6, lr}
	str	r2, [r3]
	bx	lr
.L63:
	mov	r2, #5
	ldr	r3, .L64+36
	ldmfd	sp!, {r4, r5, r6, lr}
	str	r2, [r3]
	bx	lr
.L65:
	.align	2
.L64:
	.word	1028
	.word	flipPage
	.word	loadPalette
	.word	menuPal
	.word	drawBackgroundImage4
	.word	menuBitmap
	.word	waitForVblank
	.word	buttons
	.word	oldButtons
	.word	.LANCHOR0
	.size	splash, .-splash
	.align	2
	.global	instruct
	.type	instruct, %function
instruct:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, #67108864
	ldr	r3, .L79
	ldr	r0, .L79+4
	strh	r3, [r4]	@ movhi
	ldr	r3, .L79+8
	mov	lr, pc
	bx	r3
	ldr	r0, .L79+12
	ldr	r3, .L79+16
	mov	lr, pc
	bx	r3
	ldr	r3, .L79+20
	mov	lr, pc
	bx	r3
	ldr	r3, .L79+24
	mov	lr, pc
	bx	r3
	ldr	r0, .L79+28
	mov	r1, r4
	ldr	r2, [r0]
	ldr	ip, .L79+32
	b	.L67
.L68:
	tst	r2, #8
	beq	.L70
	tst	r3, #8
	beq	.L78
.L70:
	mov	r2, r3
.L67:
	str	r2, [ip]
	ldr	r3, [r1, #304]
	tst	r2, #4
	str	r3, [r0]
	beq	.L68
	ands	lr, r3, #4
	bne	.L68
	ldr	r3, .L79+36
	str	lr, [r3]
	ldmfd	sp!, {r4, lr}
	bx	lr
.L78:
	bl	initialize
	mov	r2, #1
	ldr	r3, .L79+36
	ldmfd	sp!, {r4, lr}
	str	r2, [r3]
	bx	lr
.L80:
	.align	2
.L79:
	.word	1028
	.word	instructionsPal
	.word	loadPalette
	.word	instructionsBitmap
	.word	drawBackgroundImage4
	.word	waitForVblank
	.word	flipPage
	.word	buttons
	.word	oldButtons
	.word	.LANCHOR0
	.size	instruct, .-instruct
	.align	2
	.global	hideSprites
	.type	hideSprites, %function
hideSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	mov	r1, #512
	ldr	r2, .L84
.L82:
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L82
	bx	lr
.L85:
	.align	2
.L84:
	.word	shadowOAM
	.size	hideSprites, .-hideSprites
	.global	__aeabi_fsub
	.global	__aeabi_f2iz
	.align	2
	.global	updateOAM
	.type	updateOAM, %function
updateOAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r4, .L105
	ldr	r3, [r4, #36]
	cmp	r3, #3
	ldrls	pc, [pc, r3, asl #2]
	b	.L101
.L89:
	.word	.L88
	.word	.L90
	.word	.L91
	.word	.L92
.L92:
	mov	r1, #1090519040
	ldr	r3, .L105+4
	ldr	r0, [r4]	@ float
	mov	lr, pc
	bx	r3
	ldr	r3, .L105+8
	mov	lr, pc
	bx	r3
	ldr	r3, [r4, #4]
	sub	r3, r3, #8
	mov	r3, r3, asl #23
	ldr	r1, [r4, #44]
	ldr	r2, .L105+12
	ldr	r6, .L105+16
	mov	r3, r3, lsr #23
	and	r0, r0, #255
	mov	r1, r1, asl #2
	orr	r2, r3, r2
	strh	r0, [r6]	@ movhi
	strh	r1, [r6, #4]	@ movhi
	strh	r2, [r6, #2]	@ movhi
.L87:
	mov	r4, #4
	mov	fp, #1
	mov	r7, #512
	mov	r9, #128
	ldr	r10, .L105+20
	ldr	r5, .L105+16
.L95:
	ldr	r8, [r10]
	cmp	r8, #0
	strneh	r7, [r5, #8]	@ movhi
	strneh	r7, [r5, #88]	@ movhi
	bne	.L94
	ldr	r3, .L105+8
	ldr	r0, [r10, #-52]	@ float
	mov	lr, pc
	bx	r3
	mov	r3, #132	@ movhi
	ldr	r1, [r10, #-48]
	and	r0, r0, #255
	bic	r1, r1, #65024
	strh	r0, [r5, #8]	@ movhi
	strh	r9, [r5, #12]	@ movhi
	strh	r8, [r5, #88]	@ movhi
	strh	r4, [r5, #90]	@ movhi
	strh	r3, [r5, #92]	@ movhi
	strh	r1, [r5, #10]	@ movhi
.L94:
	add	r4, r4, #8
	add	fp, fp, #1
	mov	r4, r4, asl #16
	cmp	fp, #11
	mov	r4, r4, lsr #16
	add	r10, r10, #56
	add	r5, r5, #8
	bne	.L95
	ldr	r3, .L105+24
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L96
	ldr	r2, .L105+28
	ldr	r2, [r2]
	cmp	r2, #500
	blt	.L96
	cmp	r2, #1000
	blt	.L104
	ldr	r1, .L105+32
	cmp	r2, r1
	movle	r1, #144
	movgt	r1, #148
	ldr	r2, .L105+36
	strh	r3, [r6, #168]	@ movhi
	strh	r1, [r6, #172]	@ movhi
	strh	r2, [r6, #170]	@ movhi
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L91:
	ldr	r3, .L105+4
	mov	r1, #1090519040
	ldr	r0, [r4]	@ float
	mov	lr, pc
	bx	r3
	ldr	r3, .L105+8
	mov	lr, pc
	bx	r3
	ldr	r3, [r4, #4]
	sub	r3, r3, #8
	mov	r3, r3, asl #23
	mvn	r3, r3, lsr #6
	mvn	r3, r3, lsr #17
	ldr	r2, [r4, #44]
	ldr	r6, .L105+16
	and	r0, r0, #255
	mov	r2, r2, asl #2
	strh	r0, [r6]	@ movhi
	strh	r3, [r6, #2]	@ movhi
	strh	r2, [r6, #4]	@ movhi
	b	.L87
.L88:
	mov	r1, #1090519040
	ldr	r3, .L105+4
	ldr	r0, [r4]	@ float
	mov	lr, pc
	bx	r3
	ldr	r3, .L105+8
	mov	lr, pc
	bx	r3
	mov	r1, #8
	ldr	r3, [r4, #4]
	sub	r3, r3, #8
	mov	r3, r3, asl #23
	ldr	r2, .L105+40
	ldr	r6, .L105+16
	mov	r3, r3, lsr #23
	and	r0, r0, #255
	orr	r2, r3, r2
	strh	r2, [r6, #2]	@ movhi
	strh	r0, [r6]	@ movhi
	strh	r1, [r6, #4]	@ movhi
	b	.L87
.L90:
	ldr	r3, .L105+4
	mov	r1, #1090519040
	ldr	r0, [r4]	@ float
	mov	lr, pc
	bx	r3
	ldr	r3, .L105+8
	mov	lr, pc
	bx	r3
	ldr	r3, [r4, #4]
	sub	r3, r3, #8
	mov	r3, r3, asl #23
	mvn	r3, r3, lsr #6
	mov	r2, #8
	mvn	r3, r3, lsr #17
	ldr	r6, .L105+16
	and	r0, r0, #255
	strh	r3, [r6, #2]	@ movhi
	strh	r0, [r6]	@ movhi
	strh	r2, [r6, #4]	@ movhi
	b	.L87
.L96:
	mov	r1, #0
	mov	r2, #136
	ldr	r3, .L105+36
	strh	r1, [r6, #168]	@ movhi
	strh	r2, [r6, #172]	@ movhi
	strh	r3, [r6, #170]	@ movhi
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L104:
	mov	r1, #140
	ldr	r2, .L105+36
	strh	r3, [r6, #168]	@ movhi
	strh	r1, [r6, #172]	@ movhi
	strh	r2, [r6, #170]	@ movhi
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L101:
	ldr	r6, .L105+16
	b	.L87
.L106:
	.align	2
.L105:
	.word	mouse
	.word	__aeabi_fsub
	.word	__aeabi_f2iz
	.word	-28672
	.word	shadowOAM
	.word	cheese+52
	.word	cheat
	.word	timer
	.word	1499
	.word	-32548
	.word	-24576
	.size	updateOAM, .-updateOAM
	.global	__aeabi_fadd
	.global	__aeabi_f2d
	.global	__aeabi_dadd
	.global	__aeabi_d2f
	.global	__aeabi_fcmpgt
	.global	__aeabi_fcmplt
	.align	2
	.global	game
	.type	game, %function
game:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	mov	r1, #4352
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r2, .L295+8
	sub	sp, sp, #36
	strh	r1, [r3]	@ movhi
	strh	r2, [r3, #8]	@ movhi
	ldr	r0, .L295+12
	ldr	r3, .L295+108
	mov	lr, pc
	bx	r3
	mov	r3, #576
	mov	r2, #100663296
	ldr	r1, .L295+16
	mov	r0, #3
	ldr	ip, .L295+80
	mov	lr, pc
	bx	ip
	mov	r3, #2048
	ldr	r2, .L295+20
	ldr	r1, .L295+24
	mov	r0, #3
	ldr	ip, .L295+80
	mov	lr, pc
	bx	ip
	mov	r3, #256
	ldr	r2, .L295+28
	ldr	r1, .L295+32
	mov	r0, #3
	ldr	ip, .L295+80
	mov	lr, pc
	bx	ip
	mov	r3, #16384
	ldr	r2, .L295+36
	ldr	r1, .L295+40
	mov	r0, #3
	ldr	ip, .L295+80
	mov	lr, pc
	bx	ip
	mov	r3, #0
	mov	r1, #512
	ldr	r2, .L295+76
.L108:
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L108
	mov	r2, #67108864
	ldr	r3, .L295+92
	ldr	r1, [r3]
	ldr	r3, .L295+88
	str	r1, [r3]
	ldr	r3, .L295+96
	ldr	r2, [r2, #304]
	ldr	r0, .L295+92
	ldr	r3, [r3]
	str	r2, [r0]
	ldr	r0, .L295+96
	add	r3, r3, #1
	cmp	r3, #2000
	str	r3, [r0]
	ldr	r3, .L295+144
	str	r3, [sp, #8]
	bgt	.L218
.L219:
	tst	r1, #8
	beq	.L111
	ands	r2, r2, #8
	beq	.L279
.L111:
	ldr	r5, [sp, #8]
	ldr	r3, [r5, #4]
	str	r3, [sp, #16]
	mov	r0, r3
	ldr	r3, .L295+124
	mov	lr, pc
	bx	r3
	ldr	r6, .L295+128
	ldr	r3, [r6]	@ float
	mov	r1, r0
	mov	r4, r0
	str	r3, [sp, #12]	@ float
	mov	r0, r3
	ldr	fp, .L295+68
	mov	lr, pc
	bx	fp
	mov	ip, r0
	ldr	r8, [r5, #8]
	ldr	r3, [r6, #4]
	ldr	r5, .L295+44
	add	r3, r8, r3
	str	r0, [sp, #4]	@ float
	str	r3, [sp, #20]
	ldr	r0, [r5, #8]	@ float
	str	r3, [r6, #12]
	mov	r1, r4
	str	ip, [r6, #8]	@ float
	mov	lr, pc
	bx	fp
	ldr	r3, [r5, #12]
	ldr	r10, .L295+48
	add	r3, r3, r8
	str	r0, [r5, #8]	@ float
	str	r3, [r5, #12]
	ldr	r7, .L295+52
	ldr	r5, .L295+56
	add	r9, r10, #560
.L112:
	mov	r1, r4
	ldr	r0, [r7]	@ float
	mov	lr, pc
	bx	r5
	ldr	r3, [r7, #4]
	rsb	r3, r8, r3
	str	r0, [r7, #-8]	@ float
	str	r3, [r7, #-4]
	ldr	r0, [r10, #8]	@ float
	mov	r1, r4
	mov	lr, pc
	bx	fp
	ldr	r3, [r10, #12]
	add	r3, r3, r8
	str	r0, [r10, #8]	@ float
	str	r3, [r10, #12]
	add	r10, r10, #56
	cmp	r9, r10
	add	r7, r7, #56
	bne	.L112
	ldr	r3, [r6, #48]
	cmp	r3, #0
	ldr	r8, .L295+128
	beq	.L113
	ldr	r3, .L295+152
	ldr	r0, [r8, #16]	@ float
	mov	lr, pc
	bx	r3
	ldr	r5, .L295+156
	adr	r3, .L295
	ldmia	r3, {r2-r3}
	mov	lr, pc
	bx	r5
	ldr	r3, .L295+60
	mov	lr, pc
	bx	r3
	ldr	r10, .L295+148
	mov	r1, #1073741824
	str	r0, [r8, #16]	@ float
	mov	r5, r0
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	beq	.L260
	mov	r3, #1073741824
	mov	r5, r3
	str	r3, [r8, #16]	@ float
.L116:
	ldr	r7, [sp, #4]	@ float
	mov	r1, #0
	mov	r0, r7
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	ldr	r8, .L295+148
	beq	.L261
	ldr	r9, .L295+136
	mov	r0, r7
	mov	lr, pc
	bx	r9
	mov	r8, r0
	mov	r0, r5
	mov	lr, pc
	bx	r9
	ldr	r2, [sp, #20]
	rsb	r0, r0, r8
	mov	r0, r0, asl #9
	ldr	r3, .L295+140
	add	r2, r2, r0
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	ldr	r1, .L295+132
	cmp	r2, r1
	beq	.L280
.L121:
	cmp	r2, #31744
	beq	.L281
.L126:
	cmp	r2, #31
	bne	.L122
	ldr	r2, [r6, #24]
	ldr	r1, [sp, #20]
	add	r2, r1, r2
	add	r0, r2, r0
	add	r3, r3, r0, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, #31
	beq	.L127
.L122:
	ldr	r5, [r6, #16]	@ float
.L123:
	ldr	r3, [sp, #16]
	cmp	r3, #95
	bgt	.L129
	ldr	r3, [r6, #28]
	add	r3, r3, r3, lsr #31
	mov	r0, r3, asr #1
	rsb	r0, r0, #80
	ldr	r3, .L295+124
	mov	lr, pc
	bx	r3
	mov	r1, r0
	ldr	r0, [sp, #12]	@ float
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	beq	.L129
	mov	r1, r5
	mov	r0, r4
	mov	lr, pc
	bx	fp
	ldr	r3, .L295+136
	mov	lr, pc
	bx	r3
	ldr	r2, [sp, #8]
	str	r0, [sp, #16]
	str	r0, [r2, #4]
.L131:
	ldr	r0, [sp, #4]	@ float
	mov	r1, r5
	mov	lr, pc
	bx	fp
	str	r0, [sp, #4]	@ float
.L117:
	ldr	r4, [sp, #16]
	cmp	r4, #0
	ble	.L132
	ldr	r0, [r6, #28]
	add	r0, r0, r0, lsr #31
	mov	r0, r0, asr #1
	ldr	r3, .L295+124
	rsb	r0, r0, #80
	mov	lr, pc
	bx	r3
	ldr	r1, [sp, #12]	@ float
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	ldr	r3, .L295+124
	beq	.L132
	mov	r0, r4
	mov	lr, pc
	bx	r3
	mov	r1, r5
	mov	lr, pc
	bx	fp
	ldr	r3, .L295+136
	mov	lr, pc
	bx	r3
	ldr	r3, [sp, #8]
	str	r0, [r3, #4]
.L134:
	ldr	r1, [sp, #4]	@ float
	mov	r0, r5
	mov	lr, pc
	bx	fp
	str	r0, [r6, #8]	@ float
.L135:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #128
	bne	.L159
	mov	r3, #0
	ldr	r5, [r6, #28]
	str	r3, [r6, #36]
	rsb	r0, r5, #256
	ldr	r3, .L295+124
	mov	lr, pc
	bx	r3
	ldr	r4, [r6, #8]	@ float
	mov	r1, r0
	mov	r10, r0
	ldr	r9, .L295+120
	mov	r0, r4
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	ldr	r7, .L295+128
	ldr	r8, .L295+124
	beq	.L264
	ldr	r9, .L295+136
	mov	r0, r4
	mov	lr, pc
	bx	r9
	add	r10, r0, r5
	ldr	r0, [r7, #16]	@ float
	mov	lr, pc
	bx	r9
	ldr	r1, [r7, #12]
	add	r0, r10, r0
	mov	r0, r0, asl #9
	ldr	r3, .L295+140
	add	r2, r0, r1
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	ldr	ip, .L295+132
	cmp	r2, ip
	beq	.L282
	cmp	r2, #31744
	beq	.L283
.L159:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	bne	.L174
	mov	r3, #3
	ldr	r2, [r6, #48]
	cmp	r2, #0
	str	r3, [r6, #36]
	ldr	r4, .L295+128
	beq	.L175
	mvn	r3, #0
	ldr	r2, [sp, #8]
	ldr	r1, [r2, #8]
	cmp	r1, #0
	str	r3, [r4, #20]
	ldr	r0, .L295+144
	ble	.L176
	ldr	r3, [r4, #24]
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	ldr	r2, [r4, #4]
	rsb	r3, r3, #119
	cmp	r3, r2
	subge	r1, r1, #1
	strge	r1, [r0, #8]
	bge	.L178
.L177:
	sub	r2, r2, #1
	str	r2, [r6, #4]
.L178:
	ldr	r3, [r6, #12]
	sub	r3, r3, #1
	str	r3, [r6, #12]
.L174:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #16
	bne	.L192
	mov	r3, #2
	ldr	r2, [r6, #48]
	cmp	r2, #0
	str	r3, [r6, #36]
	ldr	r4, .L295+128
	beq	.L193
	mov	r3, #1
	ldr	r2, [sp, #8]
	ldr	r1, [r2, #8]
	cmp	r1, #272
	str	r3, [r4, #20]
	ldr	r0, .L295+144
	bge	.L194
	ldr	r3, [r4, #24]
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	ldr	r2, [r4, #4]
	rsb	r3, r3, #120
	cmp	r2, r3
	addgt	r1, r1, #1
	strgt	r1, [r0, #8]
	bgt	.L196
.L195:
	add	r2, r2, #1
	str	r2, [r6, #4]
.L196:
	ldr	r3, [r6, #12]
	add	r3, r3, #1
	str	r3, [r6, #12]
.L192:
	ldr	r3, .L295+88
	ldr	r3, [r3]
	tst	r3, #1
	beq	.L209
	ldr	r3, .L295+92
	ldr	r3, [r3]
	tst	r3, #1
	bne	.L209
	b	.L296
.L297:
	.align	3
.L295:
	.word	858993459
	.word	1069757235
	.word	23424
	.word	kitchenPal
	.word	kitchenTiles
	.word	100718592
	.word	kitchenMap
	.word	83886592
	.word	spritesPal
	.word	100728832
	.word	spritesTiles
	.word	clock
	.word	score
	.word	cheese+8
	.word	__aeabi_fsub
	.word	__aeabi_d2f
	.word	cheese
	.word	__aeabi_fadd
	.word	cheeseCount
	.word	shadowOAM
	.word	DMANow
	.word	waitForVblank
	.word	oldButtons
	.word	buttons
	.word	timer
	.word	1028
	.word	losePal
	.word	loadPalette
	.word	dma
	.word	-1082130432
	.word	__aeabi_fcmplt
	.word	__aeabi_i2f
	.word	mouse
	.word	32767
	.word	__aeabi_f2iz
	.word	collisionmapTempBitmap
	.word	.LANCHOR0
	.word	__aeabi_fcmpgt
	.word	__aeabi_f2d
	.word	__aeabi_dadd
.L296:
	ldr	r3, [r6, #48]
	cmp	r3, #0
	ldr	r4, .L295+128
	bne	.L209
	ldr	r5, [r4, #8]	@ float
	ldr	r3, .L295+148
	mov	r0, r5
	mov	r1, #0
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	beq	.L209
	mov	r0, r5
	ldr	r5, .L295+136
	mov	lr, pc
	bx	r5
	mov	r7, r0
	ldr	r0, [r4, #16]	@ float
	mov	lr, pc
	bx	r5
	ldr	r2, [r4, #12]
	rsb	r0, r0, r7
	ldr	r1, .L295+140
	add	r3, r2, r0, lsl #9
	add	r0, r1, r3, lsl #1
	ldrh	lr, [r0, #2]
	ldr	r0, .L295+132
	cmp	lr, r0
	beq	.L284
.L209:
	mov	r3, #0
	str	r3, [sp, #12]
	ldr	r3, .L295+72
	ldr	r3, [r3]
	str	r3, [sp, #4]
	ldr	r3, [r6, #28]
	ldr	r9, [r6, #12]
	ldr	r5, [r6, #24]
	ldr	r4, .L295+64
	ldr	r8, [r6, #8]	@ float
	str	r3, [sp, #16]
	ldr	r7, .L295+120
	add	r5, r9, r5
	add	r10, r4, #560
.L215:
	ldr	r3, [r4, #52]
	cmp	r3, #0
	bne	.L212
	ldr	r2, [r4, #12]
	ldr	r3, [r4, #24]
	add	r3, r2, r3
	cmp	r9, r3
	bge	.L212
	cmp	r2, r5
	bge	.L212
	ldr	r6, [r4, #8]	@ float
	ldr	r3, .L295+124
	ldr	r0, [r4, #28]
	mov	lr, pc
	bx	r3
	mov	r1, r6
	mov	lr, pc
	bx	fp
	mov	r1, r0
	mov	r0, r8
	mov	lr, pc
	bx	r7
	cmp	r0, #0
	beq	.L212
	ldr	r3, .L295+124
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r3
	mov	r1, r8
	ldr	r3, .L295+68
	mov	lr, pc
	bx	r3
	mov	r1, r0
	mov	r0, r6
	mov	lr, pc
	bx	r7
	cmp	r0, #0
	beq	.L212
	mov	r3, #1
	str	r3, [sp, #12]
	str	r3, [r4, #52]
	ldr	r3, [sp, #4]
	add	r3, r3, #1
	str	r3, [sp, #4]
.L212:
	add	r4, r4, #56
	cmp	r4, r10
	bne	.L215
	ldr	r3, [sp, #12]
	cmp	r3, #0
	ldrne	r3, .L295+72
	ldrne	r2, [sp, #4]
	strne	r2, [r3]
	ldr	r3, [sp, #4]
	cmp	r3, #10
	beq	.L285
	mov	r4, #67108864
	ldr	r3, [sp, #8]
	ldrh	r2, [r3, #8]
	ldrh	r3, [r3, #4]
	strh	r2, [r4, #16]	@ movhi
	strh	r3, [r4, #18]	@ movhi
	bl	updateOAM
	mov	r2, #117440512
	ldr	r1, .L295+76
	mov	r0, #3
	mov	r3, #512
	ldr	ip, .L295+80
	mov	lr, pc
	bx	ip
	ldr	r3, .L295+84
	mov	lr, pc
	bx	r3
	ldr	r3, .L295+92
	ldr	r2, .L295+88
	ldr	r1, [r3]
	ldr	r3, .L295+96
	str	r1, [r2]
	ldr	r3, [r3]
	ldr	r2, [r4, #304]
	ldr	r0, .L295+92
	add	r3, r3, #1
	str	r2, [r0]
	ldr	r0, .L295+96
	cmp	r3, #2000
	str	r3, [r0]
	ble	.L219
.L218:
	mov	r3, #67108864
	ldr	r2, .L295+100
	ldr	r0, .L295+104
	strh	r2, [r3]	@ movhi
	ldr	r3, .L295+108
	mov	lr, pc
	bx	r3
	mov	r2, #0
	mov	r1, #2
.L266:
	ldr	r3, .L295+112
	ldr	r0, [sp, #8]
	ldr	r3, [r3]
	str	r1, [r0]
	str	r2, [r3, #20]
	add	sp, sp, #36
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L113:
	ldr	r3, [r8, #28]
	str	r3, [sp, #24]
	rsb	r0, r3, #256
	ldr	r3, .L295+124
	mov	lr, pc
	bx	r3
	ldr	r7, [sp, #4]	@ float
	mov	r1, r0
	ldr	r3, .L295+120
	mov	r0, r7
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	beq	.L136
	ldr	r9, .L295+136
	mov	r0, r7
	mov	lr, pc
	bx	r9
	ldr	r10, [r8, #16]	@ float
	str	r0, [sp, #28]
	mov	r0, r10
	mov	lr, pc
	bx	r9
	ldr	r3, [sp, #28]
	add	r0, r3, r0
	ldr	r3, [sp, #20]
	mov	r0, r0, asl #9
	ldr	r2, .L295+140
	add	r3, r3, r0
	add	r3, r2, r3, lsl #1
	ldrh	r3, [r3, #2]
	cmp	r3, #31
	beq	.L286
.L136:
	mov	r3, #0
	str	r3, [r6, #16]	@ float
.L143:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #64
	bne	.L135
	mov	r3, #1
	ldr	r4, [r6, #8]	@ float
	ldr	r8, .L295+148
	mov	r0, r4
	mov	r1, #0
	str	r3, [r6, #36]
	mov	lr, pc
	bx	r8
	cmp	r0, #0
	ldr	r7, .L295+128
	beq	.L263
	ldr	r9, .L295+136
	mov	r0, r4
	mov	lr, pc
	bx	r9
	mov	r8, r0
	ldr	r0, [r7, #16]	@ float
	mov	lr, pc
	bx	r9
	ldr	r1, [r7, #12]
	rsb	r0, r0, r8
	mov	r0, r0, asl #9
	ldr	r3, .L295+140
	add	r2, r1, r0
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	ldr	ip, .L295+132
	cmp	r2, ip
	beq	.L287
.L147:
	cmp	r2, #31744
	bne	.L135
	ldr	r2, [r6, #24]
	add	r2, r1, r2
	add	r0, r2, r0
	add	r3, r3, r0, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, #31744
	ldr	r3, .L295+128
	bne	.L135
	ldr	r2, [sp, #8]
	ldr	r8, [r2, #4]
	ldr	r2, .L295+116
	cmp	r8, #0
	str	r2, [r3, #16]	@ float
	ldr	r7, .L295+144
	ble	.L154
	ldr	r2, [r3, #28]
	add	r2, r2, r2, lsr #31
	mov	r0, r2, asr #1
	ldr	r10, [r3]	@ float
	rsb	r0, r0, #80
	ldr	r3, .L295+124
	mov	lr, pc
	bx	r3
	ldr	r3, .L295+120
	mov	r1, r0
	mov	r0, r10
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	ldr	r3, .L295+124
	beq	.L155
	mov	r0, r8
	mov	lr, pc
	bx	r3
	mov	r1, #1065353216
	mov	lr, pc
	bx	r5
	mov	lr, pc
	bx	r9
	str	r0, [r7, #4]
	b	.L157
.L132:
	ldr	r0, [sp, #12]	@ float
	mov	r1, r5
	mov	lr, pc
	bx	fp
	str	r0, [r6]	@ float
	b	.L134
.L129:
	ldr	r0, [sp, #12]	@ float
	mov	r1, r5
	mov	lr, pc
	bx	fp
	str	r0, [sp, #12]	@ float
	str	r0, [r6]	@ float
	b	.L131
.L260:
	mov	r1, #0
	mov	r0, r5
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	beq	.L117
	b	.L116
.L264:
	mov	r1, r10
	mov	r0, r4
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	beq	.L159
	ldr	r9, .L295+136
	mov	r0, r4
	mov	lr, pc
	bx	r9
	add	r8, r0, r5
	ldr	r0, [r7, #16]	@ float
	mov	lr, pc
	bx	r9
	ldr	r1, [r7, #12]
	add	r0, r8, r0
	mov	r0, r0, asl #9
	ldr	r3, .L295+140
	add	r2, r0, r1
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	cmp	r2, #31744
	bne	.L159
.L283:
	ldr	r2, [r6, #24]
	add	r0, r0, r2
	add	r1, r0, r1
	add	r3, r3, r1, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, #31744
	ldr	r3, .L295+128
	bne	.L159
	ldr	r2, [sp, #8]
	ldr	r8, [r2, #4]
	mov	r2, #1065353216
	cmp	r8, #95
	str	r2, [r3, #16]	@ float
	ldr	r7, .L295+144
	ble	.L288
	ldr	r5, [r3]	@ float
.L170:
	mov	r0, r5
	mov	r1, #1065353216
	mov	lr, pc
	bx	fp
	str	r0, [r6]	@ float
.L172:
	mov	r0, r4
	mov	r1, #1065353216
	mov	lr, pc
	bx	fp
	str	r0, [r6, #8]	@ float
	b	.L159
.L193:
	ldr	r7, [r4, #24]
	ldr	r5, [r4, #12]
	rsb	r3, r7, #512
	cmp	r5, r3
	bge	.L192
	ldr	r3, .L295+136
	ldr	r0, [r4, #8]	@ float
	mov	lr, pc
	bx	r3
	ldr	r1, [r4, #20]
	add	r3, r5, r7
	add	r3, r3, r1
	add	r2, r0, #1
	add	r2, r3, r2, lsl #9
	ldr	r1, .L295+140
	mov	r2, r2, asl #1
	ldrh	r2, [r1, r2]
	ldr	ip, .L295+132
	cmp	r2, ip
	beq	.L289
	cmp	r2, #31
	beq	.L290
	cmp	r2, #31744
	bne	.L192
	ldr	r2, [r4, #28]
	add	r2, r0, r2
	sub	r2, r2, #1
	add	r3, r3, r2, lsl #9
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, #31744
	bne	.L192
	mov	r3, #1
	ldr	r2, [sp, #8]
	ldr	r1, [r2, #8]
	cmp	r1, #272
	str	r3, [r4, #20]
	ldr	r0, .L295+144
	bge	.L206
	add	r3, r7, r7, lsr #31
	mov	r3, r3, asr #1
	ldr	r2, [r4, #4]
	rsb	r3, r3, #120
	cmp	r2, r3
	bgt	.L268
.L207:
	add	r2, r2, #1
	str	r2, [r6, #4]
	b	.L208
.L175:
	ldr	r5, [r4, #12]
	cmp	r5, #0
	ble	.L174
	ldr	r3, .L295+136
	ldr	r0, [r4, #8]	@ float
	mov	lr, pc
	bx	r3
	ldr	r2, [r4, #20]
	add	r3, r0, #1
	rsb	r2, r2, r5
	add	r3, r2, r3, lsl #9
	ldr	r1, .L295+140
	mov	r3, r3, asl #1
	ldrh	ip, [r1, r3]
	ldr	r3, .L295+132
	cmp	ip, r3
	beq	.L291
	cmp	ip, #31
	beq	.L292
	cmp	ip, #31744
	bne	.L174
	ldr	r3, [r4, #28]
	add	r3, r0, r3
	sub	r3, r3, #1
	add	r2, r2, r3, lsl #9
	mov	r2, r2, asl #1
	ldrh	r3, [r1, r2]
	cmp	r3, #31744
	bne	.L174
.L275:
	mvn	r3, #0
	ldr	r2, [sp, #8]
	ldr	r1, [r2, #8]
	cmp	r1, #0
	str	r3, [r4, #20]
	ldr	r0, .L295+144
	ble	.L188
	ldr	r3, [r4, #24]
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1
	ldr	r2, [r4, #4]
	rsb	r3, r3, #119
	cmp	r3, r2
	subge	r1, r1, #1
	strge	r1, [r0, #8]
	sublt	r2, r2, #1
	strlt	r2, [r6, #4]
.L190:
	sub	r3, r5, #1
	str	r3, [r6, #12]
	b	.L174
.L194:
	ldr	r2, [r4, #4]
	b	.L195
.L261:
	mov	r1, #0
	ldr	r0, [sp, #4]	@ float
	mov	lr, pc
	bx	r8
	cmp	r0, #0
	bne	.L293
	mov	r1, #0
	ldr	r0, [sp, #4]	@ float
	mov	lr, pc
	bx	r8
	cmp	r0, #0
	beq	.L122
	ldr	r9, .L295+136
	ldr	r0, [sp, #4]	@ float
	mov	lr, pc
	bx	r9
	mov	r8, r0
	mov	r0, r5
	mov	lr, pc
	bx	r9
	ldr	r2, [sp, #20]
	rsb	r0, r0, r8
	mov	r0, r0, asl #9
	ldr	r3, .L295+140
	add	r2, r2, r0
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	b	.L126
.L280:
	ldr	r1, [r6, #24]
	ldr	ip, [sp, #20]
	add	r1, ip, r1
	add	r0, r1, r0
	add	r3, r3, r0, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, r2
	bne	.L122
.L127:
	mov	r2, #0
	mov	r3, #0
	str	r2, [r6, #16]	@ float
	str	r3, [r6, #48]
	mov	r5, r2
	b	.L123
.L281:
	ldr	r2, [r6, #24]
	ldr	r1, [sp, #20]
	add	r2, r1, r2
	add	r0, r2, r0
	add	r3, r3, r0, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, #31744
	bne	.L122
	b	.L127
.L282:
	ldr	ip, [r7, #24]
	add	r0, r0, ip
	add	r1, r0, r1
	add	r3, r3, r1, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, r2
	bne	.L159
	ldr	r3, [sp, #8]
	ldr	r2, [r3, #4]
	mov	r3, #1065353216
	cmp	r2, #95
	str	r2, [sp, #4]
	str	r3, [r7, #16]	@ float
	ldr	r10, .L295+144
	bgt	.L164
	add	r5, r5, r5, lsr #31
	mov	r0, r5, asr #1
	rsb	r0, r0, #80
	mov	lr, pc
	bx	r8
	ldr	r5, [r7]	@ float
	mov	r1, r0
	ldr	r3, .L295+148
	mov	r0, r5
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	beq	.L170
	ldr	r2, [sp, #4]
	mov	r0, r2
	mov	lr, pc
	bx	r8
	mov	r1, #1065353216
	mov	lr, pc
	bx	fp
	mov	lr, pc
	bx	r9
	str	r0, [r10, #4]
	b	.L172
.L286:
	ldr	r3, [r8, #24]
	ldr	r1, [sp, #20]
	add	r3, r1, r3
	add	r3, r3, r0
	add	r3, r2, r3, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, #31
	bne	.L136
	mov	r0, r10
	ldr	r3, .L295+152
	mov	lr, pc
	bx	r3
	ldr	r10, .L295+156
	adr	r3, .L298
	ldmia	r3, {r2-r3}
	mov	lr, pc
	bx	r10
	ldr	r3, .L298+8
	mov	lr, pc
	bx	r3
	ldr	r10, .L298+56
	mov	r1, #1073741824
	mov	r7, r0
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	movne	r3, #1073741824
	strne	r3, [r8, #16]	@ float
	movne	r7, r3
	ldr	r3, [sp, #16]
	streq	r7, [r8, #16]	@ float
	cmp	r3, #95
	bgt	.L140
	ldr	r3, [sp, #24]
	add	r3, r3, r3, lsr #31
	mov	r0, r3, asr #1
	rsb	r0, r0, #80
	ldr	r3, .L298+60
	mov	lr, pc
	bx	r3
	mov	r1, r0
	ldr	r0, [sp, #12]	@ float
	mov	lr, pc
	bx	r10
	cmp	r0, #0
	beq	.L140
	mov	r1, r7
	mov	r0, r4
	mov	lr, pc
	bx	fp
	mov	lr, pc
	bx	r9
	ldr	r3, [sp, #8]
	str	r0, [r3, #4]
	b	.L142
.L263:
	mov	r1, #0
	mov	r0, r4
	mov	lr, pc
	bx	r8
	cmp	r0, #0
	beq	.L135
	ldr	r9, .L298+64
	mov	r0, r4
	mov	lr, pc
	bx	r9
	mov	r8, r0
	ldr	r0, [r7, #16]	@ float
	mov	lr, pc
	bx	r9
	ldr	r1, [r7, #12]
	rsb	r0, r0, r8
	mov	r0, r0, asl #9
	ldr	r3, .L298+68
	add	r2, r1, r0
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	b	.L147
.L176:
	ldr	r2, [r4, #4]
	b	.L177
.L291:
	ldr	r3, [r4, #28]
	add	r3, r0, r3
	sub	r3, r3, #1
	add	r3, r2, r3, lsl #9
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, ip
	bne	.L174
	b	.L275
.L287:
	ldr	ip, [r7, #24]
	add	r1, r1, ip
	add	r0, r1, r0
	add	r3, r3, r0, lsl #1
	ldrh	r3, [r3, #-2]
	cmp	r3, r2
	bne	.L135
	ldr	r3, [sp, #8]
	ldr	r10, [r3, #4]
	ldr	r3, .L298+12
	cmp	r10, #0
	str	r3, [r7, #16]	@ float
	ldr	r8, .L298+16
	ble	.L149
	ldr	r3, [r7, #28]
	add	r3, r3, r3, lsr #31
	mov	r0, r3, asr #1
	rsb	r0, r0, #80
	ldr	r3, .L298+60
	mov	lr, pc
	bx	r3
	ldr	r7, [r7]	@ float
	mov	r1, r0
	ldr	r3, .L298+20
	mov	r0, r7
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	ldr	r3, .L298+60
	beq	.L150
	mov	r0, r10
	mov	lr, pc
	bx	r3
	mov	r1, #1065353216
	mov	lr, pc
	bx	r5
	mov	lr, pc
	bx	r9
	str	r0, [r8, #4]
.L157:
	mov	r0, r4
	mov	r1, #1065353216
	mov	lr, pc
	bx	r5
	str	r0, [r6, #8]	@ float
	b	.L135
.L292:
	ldr	r3, [r4, #28]
	add	r3, r0, r3
	sub	r3, r3, #1
	add	r3, r2, r3, lsl #9
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, #31
	bne	.L174
	b	.L275
.L289:
	ldr	ip, [r4, #28]
	add	r0, r0, ip
	sub	r0, r0, #1
	add	r3, r3, r0, lsl #9
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, r2
	bne	.L192
.L278:
	mov	r3, #1
	ldr	r2, [sp, #8]
	ldr	r1, [r2, #8]
	cmp	r1, #272
	str	r3, [r4, #20]
	ldr	r0, .L298+16
	blt	.L294
	ldr	r3, [r4, #4]
.L204:
	add	r3, r3, #1
	str	r3, [r6, #4]
.L208:
	add	r5, r5, #1
	str	r5, [r6, #12]
	b	.L192
.L290:
	ldr	r2, [r4, #28]
	add	r2, r0, r2
	sub	r2, r2, #1
	add	r3, r3, r2, lsl #9
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, #31
	bne	.L192
	b	.L278
.L285:
	mov	r3, #67108864
	ldr	r2, .L298+24
	ldr	r0, .L298+28
	strh	r2, [r3]	@ movhi
	ldr	r3, .L298+32
	mov	lr, pc
	bx	r3
	mov	r2, #0
	mov	r1, #3
	b	.L266
.L284:
	ldr	r0, [r4, #24]
	add	r3, r3, r0
	add	r3, r1, r3, lsl #1
	ldrh	ip, [r3, #-2]
	cmp	ip, lr
	bne	.L209
	ldr	r3, [r4, #28]
	add	r3, r3, r3, lsr #31
	add	r7, r7, r3, asr #1
	add	r2, r2, r7, lsl #9
	add	r3, r0, r0, lsr #31
	add	r3, r2, r3, asr #1
	mov	r3, r3, asl #1
	ldrh	r3, [r1, r3]
	cmp	r3, ip
	moveq	r3, #1
	ldreq	r2, .L298+36
	streq	r3, [r4, #48]
	streq	r2, [r4, #16]	@ float
	b	.L209
.L279:
	mov	r3, #67108864
	mov	r4, r2
	ldr	r2, .L298+24
	ldr	r0, .L298+40
	strh	r2, [r3]	@ movhi
	ldr	r3, .L298+32
	mov	lr, pc
	bx	r3
	mov	r2, #4
	ldr	r3, .L298+44
	ldr	r0, .L298+48
	strh	r4, [r3, #2]	@ movhi
	ldr	r1, .L298+52
	str	r4, [r0, #12]
	strh	r4, [r3, #6]	@ movhi
	ldr	r3, [sp, #8]
	str	r4, [r1, #12]
	str	r2, [r3]
	add	sp, sp, #36
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L188:
	ldr	r2, [r4, #4]
	sub	r2, r2, #1
	str	r2, [r6, #4]
	b	.L190
.L140:
	ldr	r0, [sp, #12]	@ float
	mov	r1, r7
	mov	lr, pc
	bx	fp
	str	r0, [r6]	@ float
.L142:
	mov	r1, r7
	ldr	r0, [sp, #4]	@ float
	mov	lr, pc
	bx	fp
	str	r0, [r6, #8]	@ float
	b	.L143
.L299:
	.align	3
.L298:
	.word	858993459
	.word	1069757235
	.word	__aeabi_d2f
	.word	-1082130432
	.word	.LANCHOR0
	.word	__aeabi_fcmplt
	.word	1028
	.word	winPal
	.word	loadPalette
	.word	-1065353216
	.word	pausePal
	.word	67109120
	.word	soundA
	.word	soundB
	.word	__aeabi_fcmpgt
	.word	__aeabi_i2f
	.word	__aeabi_f2iz
	.word	collisionmapTempBitmap
.L288:
	add	r5, r5, r5, lsr #31
	mov	r0, r5, asr #1
	rsb	r0, r0, #80
	ldr	r5, [r3]	@ float
	ldr	r3, .L298+60
	mov	lr, pc
	bx	r3
	ldr	r3, .L298+56
	mov	r1, r0
	mov	r0, r5
	mov	lr, pc
	bx	r3
	cmp	r0, #0
	ldr	r3, .L298+60
	beq	.L170
	mov	r0, r8
	mov	lr, pc
	bx	r3
	mov	r1, #1065353216
	mov	lr, pc
	bx	fp
	mov	lr, pc
	bx	r9
	str	r0, [r7, #4]
	b	.L172
.L164:
	ldr	r5, [r7]	@ float
	b	.L170
.L294:
	add	r3, r7, r7, lsr #31
	mov	r2, r3, asr #1
	ldr	r3, [r4, #4]
	rsb	r2, r2, #120
	cmp	r3, r2
	ble	.L204
.L268:
	add	r1, r1, #1
	str	r1, [r0, #8]
	b	.L208
.L154:
	ldr	r10, [r3]	@ float
.L155:
	mov	r0, r10
	mov	r1, #1065353216
	mov	lr, pc
	bx	r5
	str	r0, [r6]	@ float
	b	.L157
.L149:
	ldr	r7, [r7]	@ float
.L150:
	mov	r0, r7
	mov	r1, #1065353216
	mov	lr, pc
	bx	r5
	str	r0, [r6]	@ float
	b	.L157
.L293:
	ldr	r9, .L298+64
	ldr	r0, [sp, #4]	@ float
	mov	lr, pc
	bx	r9
	mov	r8, r0
	mov	r0, r5
	mov	lr, pc
	bx	r9
	ldr	r2, [sp, #20]
	rsb	r0, r0, r8
	mov	r0, r0, asl #9
	ldr	r3, .L298+68
	add	r2, r2, r0
	add	r2, r3, r2, lsl #1
	ldrh	r2, [r2, #2]
	b	.L121
.L206:
	ldr	r2, [r4, #4]
	b	.L207
	.size	game, .-game
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	mov	ip, #128
	stmfd	sp!, {r7, lr}
	mov	lr, #1
	mov	r4, #0
	ldrh	r0, [r3, #4]
	ldr	r2, .L313
	orr	r0, r0, #8
	ldrh	r1, [r2]
	ldr	r5, .L313+4
	strh	ip, [r3, #132]	@ movhi
	strh	r0, [r3, #4]	@ movhi
	ldr	ip, .L313+8
	ldr	r0, .L313+12
	orr	r1, r1, lr
	strh	r5, [r3, #130]	@ movhi
	strh	r4, [r3, #128]	@ movhi
	ldr	r10, .L313+16
	strh	r1, [r2]	@ movhi
	strh	lr, [r2, #8]	@ movhi
	ldr	r4, .L313+20
	str	r0, [ip, #4092]
	ldr	r9, .L313+24
	ldr	r8, .L313+28
	ldr	r7, .L313+32
	ldr	r6, .L313+36
	ldr	r5, .L313+40
.L301:
	ldr	r3, [r4]
.L302:
	cmp	r3, #5
	ldrls	pc, [pc, r3, asl #2]
	b	.L302
.L304:
	.word	.L303
	.word	.L305
	.word	.L306
	.word	.L307
	.word	.L308
	.word	.L309
.L309:
	mov	lr, pc
	bx	r9
	b	.L301
.L308:
	mov	lr, pc
	bx	r7
	b	.L301
.L307:
	mov	lr, pc
	bx	r6
	b	.L301
.L306:
	mov	lr, pc
	bx	r5
	b	.L301
.L305:
	mov	lr, pc
	bx	r8
	b	.L301
.L303:
	mov	lr, pc
	bx	r10
	b	.L301
.L314:
	.align	2
.L313:
	.word	67109376
	.word	-1266
	.word	50360320
	.word	interruptHandler
	.word	splash
	.word	.LANCHOR0
	.word	instruct
	.word	game
	.word	pause
	.word	win
	.word	lose
	.size	main, .-main
	.text
	.align	2
	.global	setupSounds
	.type	setupSounds, %function
setupSounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	mov	r0, #128
	mov	r1, #0
	ldr	r2, .L316
	strh	r0, [r3, #132]	@ movhi
	strh	r1, [r3, #128]	@ movhi
	strh	r2, [r3, #130]	@ movhi
	bx	lr
.L317:
	.align	2
.L316:
	.word	-1266
	.size	setupSounds, .-setupSounds
	.global	__aeabi_idiv
	.align	2
	.global	playSoundA
	.type	playSoundA, %function
playSoundA:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, #0
	mov	r7, r2
	ldr	r2, .L320
	ldr	r2, [r2]
	ldr	ip, .L320+4
	ldr	r5, .L320+8
	mov	r6, r1
	mov	r8, r0
	mov	r9, r3
	str	r4, [r2, #20]
	mov	r1, r0
	mov	r3, #910163968
	ldr	r2, .L320+12
	mov	r0, #1
	ldr	r10, .L320+16
	str	r4, [ip]
	mov	lr, pc
	bx	r10
	ldr	r10, .L320+20
	strh	r4, [r5, #2]	@ movhi
	mov	r1, r7
	mov	r0, #16777216
	mov	lr, pc
	bx	r10
	mov	r2, #1
	mov	r1, #128
	rsb	r0, r0, #0
	ldr	r4, .L320+24
	mov	r3, r0, asl #16
	mov	r3, r3, lsr #16
	rsb	r0, r6, r6, lsl #4
	strh	r3, [r5]	@ movhi
	mov	r0, r0, asl #2
	strh	r1, [r5, #2]	@ movhi
	mov	r1, r7
	str	r2, [r4, #12]
	str	r9, [r4, #16]
	stmib	r4, {r6, r7}
	str	r8, [r4]
	mov	lr, pc
	bx	r10
	mov	r1, r7
	mov	r5, r0
	mov	r0, r6
	mov	lr, pc
	bx	r10
	sub	r0, r0, r0, asl #2
	add	r5, r5, r0
	sub	r5, r5, #1
	str	r5, [r4, #20]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L321:
	.align	2
.L320:
	.word	dma
	.word	vbCountA
	.word	67109120
	.word	67109024
	.word	DMANow
	.word	__aeabi_idiv
	.word	soundA
	.size	playSoundA, .-playSoundA
	.align	2
	.global	playSoundB
	.type	playSoundB, %function
playSoundB:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, #0
	mov	r7, r2
	ldr	r2, .L324
	ldr	r2, [r2]
	ldr	ip, .L324+4
	ldr	r5, .L324+8
	mov	r6, r1
	mov	r8, r0
	mov	r9, r3
	str	r4, [r2, #32]
	mov	r1, r0
	mov	r3, #910163968
	ldr	r2, .L324+12
	mov	r0, #2
	ldr	r10, .L324+16
	str	r4, [ip]
	mov	lr, pc
	bx	r10
	ldr	r10, .L324+20
	strh	r4, [r5, #6]	@ movhi
	mov	r1, r7
	mov	r0, #16777216
	mov	lr, pc
	bx	r10
	mov	r2, #1
	mov	r1, #128
	rsb	r0, r0, #0
	ldr	r4, .L324+24
	mov	r3, r0, asl #16
	mov	r3, r3, lsr #16
	rsb	r0, r6, r6, lsl #4
	strh	r3, [r5, #4]	@ movhi
	mov	r0, r0, asl #2
	strh	r1, [r5, #6]	@ movhi
	mov	r1, r7
	str	r2, [r4, #12]
	str	r9, [r4, #16]
	stmib	r4, {r6, r7}
	str	r8, [r4]
	mov	lr, pc
	bx	r10
	mov	r1, r7
	mov	r5, r0
	mov	r0, r6
	mov	lr, pc
	bx	r10
	sub	r0, r0, r0, asl #2
	add	r5, r5, r0
	sub	r5, r5, #1
	str	r5, [r4, #20]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L325:
	.align	2
.L324:
	.word	dma
	.word	vbCountB
	.word	67109120
	.word	67109028
	.word	DMANow
	.word	__aeabi_idiv
	.word	soundB
	.size	playSoundB, .-playSoundB
	.align	2
	.global	setupInterrupts
	.type	setupInterrupts, %function
setupInterrupts:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r0, #67108864
	stmfd	sp!, {r4, lr}
	mov	r4, #1
	ldr	r3, .L328
	ldrh	r1, [r0, #4]
	ldrh	r2, [r3]
	ldr	lr, .L328+4
	ldr	ip, .L328+8
	orr	r2, r2, r4
	orr	r1, r1, #8
	strh	r1, [r0, #4]	@ movhi
	strh	r4, [r3, #8]	@ movhi
	strh	r2, [r3]	@ movhi
	str	lr, [ip, #4092]
	ldmfd	sp!, {r4, lr}
	bx	lr
.L329:
	.align	2
.L328:
	.word	67109376
	.word	interruptHandler
	.word	50360320
	.size	setupInterrupts, .-setupInterrupts
	.align	2
	.global	muteSound
	.type	muteSound, %function
muteSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	ldr	r2, .L331
	ldr	r0, .L331+4
	ldr	r1, .L331+8
	str	r3, [r0, #12]
	str	r3, [r1, #12]
	strh	r3, [r2, #2]	@ movhi
	strh	r3, [r2, #6]	@ movhi
	bx	lr
.L332:
	.align	2
.L331:
	.word	67109120
	.word	soundA
	.word	soundB
	.size	muteSound, .-muteSound
	.align	2
	.global	unmuteSound
	.type	unmuteSound, %function
unmuteSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #128
	mov	r3, #1
	ldr	r2, .L334
	ldr	ip, .L334+4
	ldr	r0, .L334+8
	strh	r1, [r2, #2]	@ movhi
	str	r3, [ip, #12]
	strh	r1, [r2, #6]	@ movhi
	str	r3, [r0, #12]
	bx	lr
.L335:
	.align	2
.L334:
	.word	67109120
	.word	soundA
	.word	soundB
	.size	unmuteSound, .-unmuteSound
	.align	2
	.global	stopSounds
	.type	stopSounds, %function
stopSounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #0
	ldr	r3, .L337
	ldr	r3, [r3]
	str	r2, [r3, #20]
	bx	lr
.L338:
	.align	2
.L337:
	.word	dma
	.size	stopSounds, .-stopSounds
	.comm	vbCountB,4,4
	.comm	vbCountA,4,4
	.comm	soundB,24,4
	.comm	soundA,24,4
	.comm	cheat,4,4
	.comm	timer,4,4
	.comm	cheeseCount,4,4
	.comm	buffer,41,4
	.global	state
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.comm	shadowOAM,1024,4
	.global	vOff
	.global	hOff
	.comm	score,560,4
	.comm	cheese,560,4
	.comm	clock,56,4
	.comm	mouse,56,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Press START return to start screen\000"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	state, %object
	.size	state, 4
state:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.ident	"GCC: (devkitARM release 45) 5.3.0"
