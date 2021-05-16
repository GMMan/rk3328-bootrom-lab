BINPATH	:= ../linux-sdk/prebuilts/gcc/linux-x86/aarch64/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/bin

CC	= ${BINPATH}/aarch64-linux-gnu-gcc
CFLAGS	+= -g -mcpu=cortex-a53 -ffreestanding

LD	= ${BINPATH}/aarch64-linux-gnu-ld
OBJCOPY	= ${BINPATH}/aarch64-linux-gnu-objcopy
OBJDUMP = ${BINPATH}/aarch64-linux-gnu-objdump

.PHONY: all clean disasm

all: rk3328_loader_v1.16.250.bin

%.bin: %.elf
		$(OBJCOPY) -O binary $< $@

payload.elf: rk3328.ld payload.o
		$(LD) -T rk3328.ld payload.o -o $@

%.o: %.S
		$(CC) -o $@ $(CFLAGS) -c $<

clean:
		$(RM) *.o *.bin *.elf

disasm: payload.bin
		$(OBJDUMP) -D -m aarch64 -b binary --adjust-vma=0xff091000 $<

rk3328_loader_v1.16.250.bin: payload.bin CONFIG.ini
		rkbin/tools/boot_merger CONFIG.ini
