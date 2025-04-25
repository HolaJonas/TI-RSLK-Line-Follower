    .text
    .thumb
    .align 2
    .global reflectanceInit, reflectanceRead, SysTick_var, SysTick_05s, SysTick_05s_var

reflectanceInit: .asmfunc
    push {lr}

    ; load base and create bitmasks using bit 3 for port 5 (IR LED)
    ldr r0, GPIOAddress
    mov r1, #8
    mvn r2, #8

    ; reset sel0
    ldrb r3, [r0, #0x04A]
    and r3, r3, r2
    strb r3, [r0, #0x04A]

    ; reset sel1
    ldrb r3, [r0, #0x04C]
    and r3, r3, r2
    strb r3, [r0, #0x04C]

    ; set dir
    ldrb r3, [r0, #0x044]
    orr r3, r3, r1
    strb r3, [r0, #0x044]

    ; create bitmasks using bit 2 for port 9 (IR LED)
    mov r1, #4
    mvn r2, #4

    ; reset sel0
    ldrb r3, [r0, #0x08A]
    and r3, r3, r2
    strb r3, [r0, #0x08A]

    ; reset sel1
    ldrb r3, [r0, #0x08C]
    and r3, r3, r2
    strb r3, [r0, #0x08C]

    ; set dir
    ldrb r3, [r0, #0x084]
    orr r3, r3, r1
    strb r3, [r0, #0x084]

    ; create bitmaks using bit 0 for port 7 (capacitors / reflectance sensors)
    mov r1, #0
    mov r2, #0xFF

    ; reset sel0
    ldrb r3, [r0, #0x06A]
    and r3, r3, r2
    strb r3, [r0, #0x06A]

    ; reset sel1
    ldrb r3, [r0, #0x06C]
    and r3, r3, r2
    strb r3, [r0, #0x06C]

    ; set dir
    ldrb r3, [r0, #0x064]
    orr r3, r3, r1
    strb r3, [r0, #0x064]

    pop {pc}
    .endasmfunc

reflectanceRead: .asmfunc

    push {lr}

    ldr r0, GPIOAddress
    mov r1, #8

    ; activate IR LED 1
    ldrb r3, [r0, #0x042]
    orr r3, r3, r1
    strb r3, [r0, #0x042]

    mov r1, #4

    ; activate IR LED 2
    ldrb r3, [r0, #0x082]
    orr r3, r3, r1
    strb r3, [r0, #0x082]

    ; set p7 to out
    mov r1, #0xFF

    ldrb r3, [r0, #0x064]
    orr r3, r3, r1
    strb r3, [r0, #0x064]

    ldrb r3, [r0, #0x062]
    orr r3, r3, r1
    strb r3, [r0, #0x062]

    ; wait 10us
    mov r0, #480
    bl SysTick_var

    ldr r0, GPIOAddress

    ; get reflectance output from p7
    mov r1, #0

    ; set p7 to out
    ldrb r3, [r0, #0x064]
    and r3, r3, r1
    strb r3, [r0, #0x064]

    ; wait 10ms
    mov r0, #48000
    bl SysTick_var

    ldr r0, GPIOAddress

    ; get reflectance output
    ldrb r2, [r0, #0x060]

    ; deactivate IR LEDs
    mvn r1, #8

    ldrb r3, [r0, #0x042]
    and r3, r3, r1
    strb r3, [r0, #0x042]

    mvn r1, #4
    ldrb r3, [r0, #0x082]
    and r3, r3, r1
    strb r3, [r0, #0x082]


    mov r0, r2

    pop {pc}
    .endasmfunc


SysTick_var: .asmfunc
    ; load peripheral base
    ldr r1, peripheralBase

    ; reset counter register
    mov r2, #0
    str r2, [r1, #0x18]

    ; set timer maximum
    str r0, [r1, #0x14]

    ; enable interrupts and start timer
    mov r0, #5
    str r0, [r1, #0x10]

    ; wait for bit 16 to be set (counted flag)
    mov r3, #1
    lsl r3, r3, #16
loop:
    ldr r0, [r1, #0x10]
    lsr r0, r0, #16
    cmp r0, #1
    bne loop

    mov r2, #4
    str r2, [r1, #0x10]

    bx lr
    .endasmfunc



SysTick_05s: .asmfunc
    push {r4, lr}
    ; execute 100ms waiting 5 times
    mov r4, #5
loop1:
    ldr r0, delay_100ms
    bl SysTick_var
    sub r4, r4, #1
    cmp r4, #0
    bne loop1

    pop {r4, pc}
    .endasmfunc


SysTick_05s_var: .asmfunc
    push {r5,lr}
    mov r5,r0
SysTick_05s_var_loop:
    bl SysTick_05s
    subs r5, r5, #1
    bne SysTick_05s_var_loop

    pop {r5,pc}
    .endasmfunc



GPIOAddress: .int 0x40004C00
peripheralBase: .int 0xE000E000
delay_100ms: .int 4799999
