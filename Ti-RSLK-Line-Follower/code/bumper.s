	.text
	.thumb
	.align 2
	.global bumpersInit


	; init bumpers using port 4
bumpersInit: .asmfunc

	push {r4-r11,lr}
	ldr r0, GPIOAddress

	; bitmask not bit 0,2,3,5,6,7
	mvn r2, #237

	; bitmask bit 0,2,3,5,6,7
	mov r3, #237

	; reset sel0
	ldrb r1, [r0, #0x2B]
	and r1, r1, r2
	strb r1, [r0, #0x2B]

	; reset sel1
	ldrb r1, [r0, #0x2D]
	and r1, r1, r2
	strb r1, [r0, #0x2D]

	; reset dir
	ldrb r1, [r0, #0x25]
	and r1, r1, r2
	strb r1, [r0, #0x25]

	; set ren
	ldrb r1, [r0, #0x27]
	orr r1, r1, r3
	strb r1, [r0, #0x27]

	; set out
	ldrb r1, [r0, #0x23]
	orr r1, r1, r3
	strb r1, [r0, #0x23]

	; reset ifg
	ldrb r1, [r0, #0x03D]
	and r1, r1, r2
	strb r1, [r0, #0x03D]

	; set ies
	ldrb r1, [r0, #0x39]
	orr r1, r1, r3
	strb r1, [r0, #0x39]

	; set ie
	ldrb r1, [r0, #0x03B]
	orr r1, r1, r3
	strb r1, [r0, #0x03B]

	ldr r0, peripheralBase

	; set iser1
	ldrb r1, [r0, #0x104]
	mov r4, #1
	lsl r4, #6
	orr r1, r1, r4
	strb r1, [r0, #0x104]

	; set ipr9
	ldrb r1, [r0, #0x424]
	mvn r5, #15
	ror r5, r5, #11
	and r1, r1, r5
	strb r1, [r0, #0x424]

	pop {r4-r11,pc}
	.endasmfunc

GPIOAddress: .int 0x40004C00
peripheralBase: .int 0xE000E000
