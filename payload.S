.section .text

    .word 0x33334b52 // RK33
    b start

start:
    // Disable security
    ldr x0, =0xff050000 // PMUSGRF_SOC_CON0
    ldr w1, =0x001f001f
    str w1, [x0]
    // Mux to JTAG
    ldr x0, =0xff14001c
    ldr w1, =0x00ff0033
    str w1, [x0]

    // Retrieve main and revision ID registers
    mrs x0, MIDR_EL1
    mrs x1, REVIDR_EL1
    // Retrieve reset vector
    mrs x2, RVBAR_EL3

    // Spin
    b .
