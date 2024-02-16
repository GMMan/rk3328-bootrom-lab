BINPATH	:= ../linux-sdk/prebuilts/gcc/linux-x86/arm/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/bin

CC	= ${BINPATH}/arm-linux-gnueabihf-gcc
CFLAGS	+= -g -mcpu=cortex-a7 -ffreestanding

LD	= ${BINPATH}/arm-linux-gnueabihf-ld
OBJCOPY	= ${BINPATH}/arm-linux-gnueabihf-objcopy
OBJDUMP = ${BINPATH}/arm-linux-gnueabihf-objdump

.PHONY: all clean disasm

all: rk3032_loader_v1.09.260.bin

%.bin: %.elf
		$(OBJCOPY) -O binary $< $@

payload.elf: rk3032.ld payload.o
		$(LD) -T rk3032.ld payload.o -o $@

%.o: %.S
		$(CC) -o $@ $(CFLAGS) -c $<

clean:
		$(RM) *.o *.bin *.elf

disasm: payload.bin
		$(OBJDUMP) -D -m arm -b binary --adjust-vma=0x10081000 $<

rk3032_loader_v1.09.260.bin: payload.bin CONFIG.ini
		rkbin/tools/boot_merger CONFIG.ini
