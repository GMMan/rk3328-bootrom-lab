BINPATH	:= ../linux-sdk/prebuilts/gcc/linux-x86/arm/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/bin

CC	= ${BINPATH}/arm-linux-gnueabihf-gcc
CFLAGS	+= -g -mcpu=cortex-a17 -ffreestanding

LD	= ${BINPATH}/arm-linux-gnueabihf-ld
OBJCOPY	= ${BINPATH}/arm-linux-gnueabihf-objcopy
OBJDUMP = ${BINPATH}/arm-linux-gnueabihf-objdump

.PHONY: all clean disasm

all: rk3288_loader_v1.10.263.bin

%.bin: %.elf
		$(OBJCOPY) -O binary $< $@

payload.elf: rk3288.ld payload.o
		$(LD) -T rk3288.ld payload.o -o $@

%.o: %.S
		$(CC) -o $@ $(CFLAGS) -c $<

clean:
		$(RM) *.o *.bin *.elf

disasm: payload.bin
		$(OBJDUMP) -D -m arm -b binary --adjust-vma=0xff704000 $<

rk3288_loader_v1.10.263.bin: payload.bin CONFIG.ini
		rkbin/tools/boot_merger CONFIG.ini
