Rockchip RK3328 Bootrom Lab
===========================

This repo is for experimenting with Rockchip RK3328's bootrom.

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
Code 471 is the DRAM init program that gets loaded into SRAM at `0xff091000`.
It has the four characters `RK32` as a magic number, followed by a jump
instruction to the code's entry point. The DRAM init program appears to read
values from `0xff090010` as some sort of parameters. For example, if it does
not equal `5`, pinmux is changed to enable JTAG. So Code 471 is the earliest
you can execute your own code unless you write stuff to another boot medium.
