.section .text

    .word 0x32334b52 // RK32
    b start

start:
    // Enable JTAG
    ldr x0, =0xff10040c
    ldr w1, [x0]
    orr w1, w1, #0x1000
    str w1, [x0]
    // Retrieve reset vector
    mrs x1, RVBAR_EL3
    // Spin
    b .
