	.text
	.thumb
	.align 2
	.global buttonS2Init

	; init button 2 using GPIO-port 1.4
buttonS2Init: .asmfunc

	push {r4-r11,lr}
	ldr r0, GPIOAddress

	; bitmask not bit 5
	mvn r2, #16

	; bitmask bit 5
	mov r3, #16

	; reset sel0
	ldrb r1, [r0, #0xA]
	and r1, r1, r2
	strb r1, [r0, #0xA]

	; reset sel1
	ldrb r1, [r0, #0xC]
	and r1, r1, r2
	strb r1, [r0, #0xC]

	; reset dir
	ldrb r1, [r0, #0x4]
	and r1, r1, r2
	strb r1, [r0, #0x4]

	; set ren
	ldrb r1, [r0, #0x6]
	orr r1, r1, r3
	strb r1, [r0, #0x6]

	; set out
	ldrb r1, [r0, #0x2]
	orr r1, r1, r3
	strb r1, [r0, #0x2]

	pop {r4-r11,pc}
	.endasmfunc

GPIOAddress: .int 0x40004C00
