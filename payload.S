.section .text

    .word 0x32334b52 // RK32
    b start

start:
    // Enable JTAG
    ldr x0, =0xff100010
    ldr w1, =0x00f000a0
    str w1, [x0]
    // Retrieve reset vector
    mrs x0, RVBAR_EL3
    // Spin
    b .
