all: maximum

maximum.o : maximum.asm
	as $< -o $@

maximum : maximum.o
	ld $< -o $@

.PHONY: clean

clean:
	rm -rf maximum.o maximum
