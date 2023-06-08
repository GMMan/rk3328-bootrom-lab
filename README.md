Rockchip RK3126C Bootrom Lab
============================

This repo is for experimenting with Rockchip RK3126C's bootrom.

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
One of the very first things the bootrom does after it establishes it is the
primary core is disable debugging by disabling access from APB-AP. It does
this by resetting bit 15 of the register at `0x20010000` in regular Rockchip
fashion. This bit needs to be set for debugging to work, presumably while the
CPU is in some low privilege level.

Code 471 is the DRAM init program that gets loaded into SRAM at `0x10081000`.
It has the four characters `RK31` as a magic number, followed by a jump
instruction to the code's entry point.
