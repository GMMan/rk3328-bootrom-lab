.section .text

    .word 0x32334b52 // RK32
    b start

start:
    // Change mux to JTAG
    ldr r0, =0xff770064
    ldr r1, =0x03ff02aa
    str r1, [r0]

    // Retrieve SCTLR (for reset vector)
    mrc p15, 0, r0, c1, c0, 0
    // Retrieve MIDR
    mrc p15, 0, r1, c0, c0, 0
    // Retieve REVIDR
    mrc p15, 0, r0, c0, c0, 6
    
    // Spin
    b .
