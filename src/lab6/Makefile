export
CROSS_=riscv64-linux-gnu-
GCC=${CROSS_}gcc
LD=${CROSS_}ld
OBJCOPY=${CROSS_}objcopy
OBJDUMP=${CROSS_}objdump

ISA=rv64imafdzifencei
ABI=lp64

DEBUG := 1

INCLUDE = -I $(shell pwd)/include -I $(shell pwd)/arch/riscv/include
CF = -march=$(ISA) -mabi=$(ABI) -mcmodel=medany -fno-builtin -fno-pie -ffunction-sections -fdata-sections -nostartfiles -nostdlib -nostdinc -static -lgcc -Wl,--nmagic -Wl,--gc-sections -g 
TEST_SCHED := 0
CFLAG := $(CF) $(INCLUDE) -DTEST_SCHED=$(TEST_SCHED) -DDEBUG=$(DEBUG)

.PHONY:all run debug clean
all: clean
	${MAKE} -C user all
	${MAKE} -C lib all
	${MAKE} -C init all
	${MAKE} -C fs all
	${MAKE} -C arch/riscv all
	
	@echo -e '\n'Build Finished OK

# run: all
# 	@echo Launch the qemu ......
# 	@qemu-system-riscv64 -nographic -machine virt -kernel vmlinux -bios default 

# debug: all
# 	@echo Launch the qemu for debug ......
# 	@qemu-system-riscv64 -nographic -machine virt -kernel vmlinux -bios default -S -s

# FAT32
run: all
    @echo Launch qemu...
    @qemu-system-riscv64 -nographic -machine virt -kernel vmlinux -bios default \
        -global virtio-mmio.force-legacy=false \
        -drive file=disk.img,if=none,format=raw,id=hd0 \
        -device virtio-blk-device,drive=hd0

debug: all
    @echo Launch qemu for debug...
    @qemu-system-riscv64 -nographic -machine virt -kernel vmlinux -bios default \
        -global virtio-mmio.force-legacy=false \
        -drive file=disk.img,if=none,format=raw,id=hd0 \
        -device virtio-blk-device,drive=hd0 -S -s

clean:
	${MAKE} -C lib clean
	${MAKE} -C init clean
	${MAKE} -C arch/riscv clean
	${MAKE} -C user clean
	${MAKE} -C fs clean
	$(shell test -f vmlinux && rm vmlinux)
	$(shell test -f System.map && rm System.map)
	@echo -e '\n'Clean Finished
