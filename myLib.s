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
	.file	"myLib.c"
	.text
	.align	2
	.global	setPixel3
	.type	setPixel3, %function
setPixel3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L2
	rsb	r0, r0, r0, lsl #4
	add	r1, r1, r0, lsl #4
	ldr	r3, [r3]
	mov	r1, r1, asl #1
	strh	r2, [r3, r1]	@ movhi
	bx	lr
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.size	setPixel3, .-setPixel3
	.align	2
	.global	drawRect3
	.type	drawRect3, %function
drawRect3:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r2, #0
	bxle	lr
	stmfd	sp!, {r4, lr}
	ldr	r4, .L12
	add	r2, r0, r2
	rsb	r2, r2, r2, lsl #4
	rsb	r0, r0, r0, lsl #4
	ldr	ip, [r4]
	add	lr, r1, r2, lsl #4
	sub	sp, sp, #8
	add	r1, r1, r0, lsl #4
	ldr	r2, [r4, #4]
	orr	r3, r3, #-2130706432
	add	lr, ip, lr, lsl #1
	add	r1, ip, r1, lsl #1
	add	r0, sp, #6
.L6:
	str	r0, [r2, #36]
	str	r1, [r2, #40]
	add	r1, r1, #480
	cmp	lr, r1
	str	r3, [r2, #44]
	bne	.L6
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, lr}
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LANCHOR0
	.size	drawRect3, .-drawRect3
	.align	2
	.global	fillScreen3
	.type	fillScreen3, %function
fillScreen3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L16
	sub	sp, sp, #8
	ldmia	r2, {r2, r3}
	ldr	r1, .L16+4
	add	r0, sp, #6
	str	r0, [r3, #36]
	str	r2, [r3, #40]
	str	r1, [r3, #44]
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L17:
	.align	2
.L16:
	.word	.LANCHOR0
	.word	-2130668032
	.size	fillScreen3, .-fillScreen3
	.align	2
	.global	setPixel4
	.type	setPixel4, %function
setPixel4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	ip, .L21
	add	r3, r1, r1, lsr #31
	mov	r3, r3, asr #1
	rsb	r0, r0, r0, lsl #4
	ldr	ip, [ip]
	add	r0, r3, r0, lsl #3
	mov	r0, r0, asl #1
	ldrh	r3, [ip, r0]
	tst	r1, #1
	biceq	r3, r3, #255
	andne	r3, r3, #255
	orreq	r3, r3, r2
	orrne	r2, r3, r2, asl #8
	streqh	r3, [ip, r0]	@ movhi
	strneh	r2, [ip, r0]	@ movhi
	bx	lr
.L22:
	.align	2
.L21:
	.word	.LANCHOR0
	.size	setPixel4, .-setPixel4
	.align	2
	.global	drawRect4
	.type	drawRect4, %function
drawRect4:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #28
	ldrb	ip, [sp, #64]	@ zero_extendqisi2
	mov	r8, ip, asl #8
	str	ip, [sp, #12]
	cmp	r2, #0
	orr	ip, ip, r8
	strh	ip, [sp, #22]	@ movhi
	ble	.L23
	add	r10, r3, r1
	sub	r10, r10, #1
	ldr	lr, .L38
	add	r9, r3, r3, lsr #31
	mov	fp, r3, lsr #31
	add	r6, r10, r10, lsr #31
	add	r5, r1, r1, lsr #31
	mov	r9, r9, asr #1
	ldr	r7, [lr]
	add	r3, r3, fp
	sub	r4, r9, #1
	bic	r6, r6, #1
	bic	r5, r5, #1
	rsb	r6, r1, r6
	rsb	r5, r1, r5
	orr	r4, r4, #-2130706432
	rsb	r0, r0, r0, lsl #4
	and	r3, r3, #1
	and	r10, r10, #1
	add	r0, r1, r0, lsl #4
	str	r4, [sp, #8]
	mov	ip, #0
	rsb	r4, fp, r3
	ldr	lr, [lr, #4]
	add	r6, r7, r6
	orr	r9, r9, #-2130706432
	add	r5, r7, r5
	and	r1, r1, #1
	add	fp, sp, #22
	str	r10, [sp, #4]
	b	.L30
.L36:
	add	r3, r0, r0, lsr #31
	bic	r3, r3, #1
	add	r3, r7, r3
	cmp	r4, #1
	str	fp, [lr, #36]
	str	r3, [lr, #40]
	str	r9, [lr, #44]
	beq	.L35
.L26:
	add	ip, ip, #1
	cmp	r2, ip
	add	r0, r0, #240
	beq	.L23
.L30:
	cmp	r1, #0
	beq	.L36
	ldrb	r3, [r5, r0]	@ zero_extendqisi2
	orr	r3, r3, r8
	strh	r3, [r5, r0]	@ movhi
	add	r3, r0, #1
	add	r3, r3, r3, lsr #31
	cmp	r4, #1
	bic	r3, r3, #1
	beq	.L37
	ldr	r10, [sp, #4]
	cmp	r10, #0
	ldr	r10, [sp, #8]
	add	r3, r7, r3
	str	fp, [lr, #36]
	str	r3, [lr, #40]
	ldrh	r3, [r6, r0]
	str	r10, [lr, #44]
	bne	.L29
.L34:
	ldr	r10, [sp, #12]
	bic	r3, r3, #255
	add	ip, ip, #1
	orr	r3, r3, r10
	cmp	r2, ip
	strh	r3, [r6, r0]	@ movhi
	add	r0, r0, #240
	bne	.L30
.L23:
	add	sp, sp, #28
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L35:
	ldr	r3, [sp, #4]
	cmp	r3, #0
	ldrh	r3, [r6, r0]
	beq	.L34
.L29:
	and	r3, r3, #255
	orr	r3, r8, r3
	strh	r3, [r6, r0]	@ movhi
	b	.L26
.L37:
	add	r3, r7, r3
	str	fp, [lr, #36]
	str	r3, [lr, #40]
	str	r9, [lr, #44]
	b	.L26
.L39:
	.align	2
.L38:
	.word	.LANCHOR0
	.size	drawRect4, .-drawRect4
	.align	2
	.global	fillScreen4
	.type	fillScreen4, %function
fillScreen4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
	ldr	r1, .L42
	add	r2, sp, #8
	orr	r0, r0, r0, asl #8
	strh	r0, [r2, #-2]!	@ movhi
	ldmia	r1, {r0, r3}
	ldr	r1, .L42+4
	str	r2, [r3, #36]
	str	r0, [r3, #40]
	str	r1, [r3, #44]
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L43:
	.align	2
.L42:
	.word	.LANCHOR0
	.word	-2130687232
	.size	fillScreen4, .-fillScreen4
	.align	2
	.global	drawBackgroundImage4
	.type	drawBackgroundImage4, %function
drawBackgroundImage4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L45
	ldr	r1, .L45+4
	ldmia	r2, {r2, r3}
	str	r0, [r3, #36]
	str	r2, [r3, #40]
	str	r1, [r3, #44]
	bx	lr
.L46:
	.align	2
.L45:
	.word	.LANCHOR0
	.word	-2147464448
	.size	drawBackgroundImage4, .-drawBackgroundImage4
	.align	2
	.global	drawImage4
	.type	drawImage4, %function
drawImage4:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	cmp	r3, #0
	ldr	r6, [sp, #20]
	ble	.L47
	mov	ip, r1
	mov	lr, #0
	ldr	r7, .L53
	add	r5, r1, r3
	add	r1, r6, r6, lsr #31
	rsb	r5, r5, r5, lsl #4
	rsb	ip, ip, ip, lsl #4
	mov	r1, r1, asr #1
	ldr	r4, [r7, #4]
	ldr	r7, [r7]
	add	r5, r2, r5, lsl #4
	orr	r1, r1, #-2147483648
	add	r2, r2, ip, lsl #4
.L49:
	add	ip, lr, lr, lsr #31
	add	r3, r2, r2, lsr #31
	bic	ip, ip, #1
	bic	r3, r3, #1
	add	r2, r2, #240
	add	ip, r0, ip
	add	r3, r7, r3
	cmp	r5, r2
	str	ip, [r4, #36]
	add	lr, lr, r6
	str	r3, [r4, #40]
	str	r1, [r4, #44]
	bne	.L49
.L47:
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L54:
	.align	2
.L53:
	.word	.LANCHOR0
	.size	drawImage4, .-drawImage4
	.align	2
	.global	drawSubImage4
	.type	drawSubImage4, %function
drawSubImage4:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	ldr	r5, [sp, #28]
	add	r4, sp, #20
	cmp	r5, #0
	ldmia	r4, {r4, ip}
	ldr	r6, [sp, #32]
	ble	.L55
	ldr	lr, .L61
	add	r5, r4, r5
	add	r6, r6, r6, lsr #31
	mla	r2, r3, r1, r2
	mov	r6, r6, asr #1
	rsb	r5, r5, r5, lsl #4
	rsb	r4, r4, r4, lsl #4
	ldr	r1, [lr, #4]
	ldr	r7, [lr]
	orr	r6, r6, #-2147483648
	add	r5, ip, r5, lsl #4
	add	r4, ip, r4, lsl #4
.L57:
	add	lr, r2, r2, lsr #31
	add	ip, r4, r4, lsr #31
	bic	lr, lr, #1
	bic	ip, ip, #1
	add	r4, r4, #240
	add	lr, r0, lr
	add	ip, r7, ip
	cmp	r5, r4
	str	lr, [r1, #36]
	add	r2, r2, r3
	str	ip, [r1, #40]
	str	r6, [r1, #44]
	bne	.L57
.L55:
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L62:
	.align	2
.L61:
	.word	.LANCHOR0
	.size	drawSubImage4, .-drawSubImage4
	.align	2
	.global	loadPalette
	.type	loadPalette, %function
loadPalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	mov	ip, #0
	mov	r5, #83886080
	mvn	lr, #32768
	mov	r1, #31
	ldr	r3, .L65
	ldr	r4, .L65+4
	ldr	r2, [r3, #4]
	ldr	r3, .L65+8
	str	r0, [r2, #36]
	str	r5, [r2, #40]
	str	r4, [r2, #44]
	strh	lr, [r3, #244]	@ movhi
	strh	ip, [r3, #246]	@ movhi
	strh	r1, [r3, #248]	@ movhi
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L66:
	.align	2
.L65:
	.word	.LANCHOR0
	.word	-2147483392
	.word	83886336
	.size	loadPalette, .-loadPalette
	.align	2
	.global	DMANow
	.type	DMANow, %function
DMANow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L69
	str	lr, [sp, #-4]!
	add	r0, r0, r0, lsl #1
	ldr	lr, [ip, #4]
	mov	r0, r0, asl #2
	add	ip, lr, r0
	orr	r3, r3, #-2147483648
	str	r1, [lr, r0]
	str	r2, [ip, #4]
	ldr	lr, [sp], #4
	str	r3, [ip, #8]
	bx	lr
.L70:
	.align	2
.L69:
	.word	.LANCHOR0
	.size	DMANow, .-DMANow
	.align	2
	.global	waitForVblank
	.type	waitForVblank, %function
waitForVblank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
.L72:
	ldrh	r3, [r2, #6]
	cmp	r3, #160
	bhi	.L72
	mov	r2, #67108864
.L74:
	ldrh	r3, [r2, #6]
	cmp	r3, #159
	bls	.L74
	bx	lr
	.size	waitForVblank, .-waitForVblank
	.align	2
	.global	flipPage
	.type	flipPage, %function
flipPage:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	ldrh	r3, [r2]
	ldr	r1, .L80
	tst	r3, #16
	ldrne	r0, [r1, #8]
	ldreq	r0, [r1, #12]
	bicne	r3, r3, #16
	orreq	r3, r3, #16
	strh	r3, [r2]	@ movhi
	str	r0, [r1]
	bx	lr
.L81:
	.align	2
.L80:
	.word	.LANCHOR0
	.size	flipPage, .-flipPage
	.align	2
	.global	drawBackgroundImage3
	.type	drawBackgroundImage3, %function
drawBackgroundImage3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L83
	ldr	r1, .L83+4
	ldmia	r2, {r2, r3}
	str	r0, [r3, #36]
	str	r2, [r3, #40]
	str	r1, [r3, #44]
	bx	lr
.L84:
	.align	2
.L83:
	.word	.LANCHOR0
	.word	-2147445248
	.size	drawBackgroundImage3, .-drawBackgroundImage3
	.global	dma
	.global	backBuffer
	.global	frontBuffer
	.global	videoBuffer
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.type	dma, %object
	.size	dma, 4
dma:
	.word	67109040
	.type	backBuffer, %object
	.size	backBuffer, 4
backBuffer:
	.word	100704256
	.type	frontBuffer, %object
	.size	frontBuffer, 4
frontBuffer:
	.word	100663296
	.ident	"GCC: (devkitARM release 45) 5.3.0"
