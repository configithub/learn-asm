all: power

power.o : power.asm
	as --32 $< -o $@

power : power.o
	ld -melf_i386 $< -o $@

.PHONY: clean

clean:
	rm -rf power.o power
