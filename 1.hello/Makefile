MAIN=hello

all: $(MAIN)

hello.o : hello.asm
	nasm -f ELF $<

$(MAIN) : hello.o
	ld -m elf_i386 -o $@ $<

.PHONY: clean

clean:
	rm -rf hello.o hello

