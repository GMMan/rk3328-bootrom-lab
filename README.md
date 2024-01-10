Rockchip RK3326 Bootrom Lab
===========================

This repo is for experimenting with Rockchip RK3326's bootrom.

How to build
------------
Update the `BINPATH` in the `Makefile` with path to your Cortex-A toolchain,
then run `make`. Be sure to init submodules when you clone, since this uses
`boot_merger` from Rockchip's `rkbin` repo to generate a loadable boot file
that you can upload with various `rockusb`-compatible tools.

You can check your work by disassembling the built binary with `make disasm`.

Current experiment
------------------
Just enabling JTAG and dumping the bootrom (via UART).

Findings
--------
Code 471 is the DRAM init program that gets loaded into SRAM at `0xff0e1000`.
It has the four characters `RK33` as a magic number, followed by a jump
instruction to the code's entry point.

It's more of the same as before, except JTAG doesn't actually seem to work. I
could get a connection in OpenOCD, but when it tries to examine, it fails. So
I think there's a lockout again, so I need to go find it. In the meantime, just
dumping things through UART until I get JTAG working.
