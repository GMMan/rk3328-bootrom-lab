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
Just enabling JTAG and dumping the bootrom.

Findings
--------
Code 471 is the DRAM init program that gets loaded into SRAM at `0xff0e1000`.
It has the four characters `RK33` as a magic number, followed by a jump
instruction to the code's entry point. This is the earliest code you can
send over USB and execute.
