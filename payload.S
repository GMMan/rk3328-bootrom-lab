.section .text

    .word 0x31334b52 // RK31
    b start

start:
    // Change mux to JTAG
    ldr r0, =0x200080c0
    ldr r1, =0x0f000a00
    str r1, [r0]

    // Enable APB-AP debug access
    ldr r0, =0x20010000
    ldr r1, =0x80008000
    str r1, [r0]

    // Retrieve SCTLR (for reset vector)
    mrc p15, 0, r0, c1, c0, 0
    // Retrieve MIDR
    mrc p15, 0, r1, c0, c0, 0
    
    // Spin
    b .
