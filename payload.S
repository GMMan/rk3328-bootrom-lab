.section .text

    .word 0x30334b52 // RK30
    b start

start:
    // Change mux to JTAG
    ldr r0, =0x200080c0
    ldr r1, =0x0f000a00
    str r1, [r0]

    // Retrieve SCTLR (for reset vector)
    mrc p15, 0, r0, c1, c0, 0
    // Retrieve MIDR
    mrc p15, 0, r1, c0, c0, 0
    // Retieve REVIDR
    mrc p15, 0, r2, c0, c0, 6
    // Retrieve VBAR
    mrc p15, 0, r3, c12, c0, 0
    
    // Spin
    b .
