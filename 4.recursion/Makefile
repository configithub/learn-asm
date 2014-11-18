all: factorial

factorial.o : factorial.asm
	as --32 $< -o $@

factorial : factorial.o
	ld -melf_i386 $< -o $@

.PHONY: clean

clean:
	rm -rf factorial.o factorial
