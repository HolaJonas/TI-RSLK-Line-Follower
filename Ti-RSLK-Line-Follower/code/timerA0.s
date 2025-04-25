	.text
	.thumb
	.align 2
	.global timerA0Init, setMotorActivation, setLeftMotorSpeed, setRightMotorSpeed, setMotorDirection, pinInit


timerA0Init: .asmfunc
	push{lr}

	ldr r0, timerBase

	; ctl
	mov r1, #512
	strh r1, [r0]

	; cctl0
	mov r1, #128
	strh r1, [r0, #0x2]

	; cctl1
	mov r1, #64
	strh r1, [r0, #0x4]

	; cctl3
	mov r1, #64
	strh r1, [r0, #0x8]

	; cctl4
	mov r1, #64
	strh r1, [r0, #0xA]


	; ccr0
	mov r1, #15000
	strh r1, [r0, #0x12]

	; ccr1
	mov r1, #0x00FF
	strh r1, [r0, #0x14]

	; ccr2
	mov r1, #0x00FF
	strh r1, [r0, #0x16]

	; ccr3
	mov r1, #0x0
	strh r1, [r0, #0x18]

	; ccr4
	mov r1, #0x0
	strh r1, [r0, #0x1A]

	; ex0
	mov r1, #0x0
	strh r1, [r0, #0x20]

	; activate timer in up-down mode
	mov r1, #752
	ldrh r2, [r0]
	orr r2, r2, r1
	strh r2, [r0]

	pop {pc}
	.endasmfunc


; store r0 in ccr3
setLeftMotorSpeed: .asmfunc
	push {lr}
	ldr r1, timerBase
	ldrh r2, [r1, #0x12]
	cmp r0, r2
	IT lt
	strhlt r0, [r1, #0x18]

	pop {pc}
	.endasmfunc

; store r0 in ccr4
setRightMotorSpeed: .asmfunc
	push {lr}
	ldr r1, timerBase
	ldrh r2, [r1, #0x12]
	cmp r0, r2
	IT lt
	strhlt r0, [r1, #0x1A]

	pop {pc}
	.endasmfunc

; store r0 in 3.6,7 out
setMotorActivation: .asmfunc
	push {lr}

	ldr r1, GPIOBase
	ldrb r2, [r1, #0x22]
	cmp r0, #0
	ITTEE eq
	mvneq r3, #208
	andeq r2, r2, r3
	movne r3, #208
	orrne r2, r2, r3
	strb r2, [r1, #0x22]

	pop {pc}
	.endasmfunc

; store r0 in 5.4,5 out
setMotorDirection: .asmfunc
	push {lr}

	ldr r1, GPIOBase
	ldrb r2, [r1, #0x42]
	cmp r0, #0
	ITTEE eq
	mvneq r3, #48
	andeq r2, r2, r3
	movne r3, #48
	orrne r2, r2, r3
	strb r2, [r1, #0x42]

	pop {pc}
	.endasmfunc



; initialize all pins using timers. IMPORTANT: Call initialization before timers
pinInit: .asmfunc
	push {lr}

	ldr r0, GPIOBase
	; port 2.4,6,7 init
	mov r2, #208
	mvn r3, #208

	; set sel0
	ldrb r1, [r0, #0xB]
	orr r1, r1, r2
	strb r1, [r0, #0xB]

	; reset sel1
	ldrb r1, [r0, #0xD]
	and r1, r1, r3
	strb r1, [r0, #0xD]

	; set dir
	ldrb r1, [r0, #0x5]
	orr r1, r1, r2
	strb r1, [r0, #0x5]


	; port 3.6,7
	mov r2, #192
	mvn r3, #192

	; reset sel0
	ldrb r1, [r0, #0x2A]
	and r1, r1, r3
	strb r1, [r0, #0x2A]

	; reset sel1
	ldrb r1, [r0, #0x2C]
	and r1, r1, r3
	strb r1, [r0, #0x2C]

	; set dir
	ldrb r1, [r0, #0x24]
	orr r1, r1, r2
	strb r1, [r0, #0x24]

	; reset out
	ldrb r1, [r0, #0x22]
	and r1, r1, r3
	strb r1, [r0, #0x22]


	; port 5.4,5
	mov r2, #48
	mvn r3, #48

	; reset sel0
	ldrb r1, [r0, #0x4A]
	and r1, r1, r3
	strb r1, [r0, #0x4A]

	; reset sel1
	ldrb r1, [r0, #0x4C]
	and r1, r1, r3
	strb r1, [r0, #0x4C]

	; set dir
	ldrb r1, [r0, #0x44]
	orr r1, r1, r2
	strb r1, [r0, #0x44]

	; reset out
	ldrb r1, [r0, #0x42]
	and r1, r1, r3
	strb r1, [r0, #0x42]


	pop {pc}
	.endasmfunc

GPIOBase: .int 0x40004C00
timerBase: .int 0x40000000
peripheralBase: .int 0xE000E000

