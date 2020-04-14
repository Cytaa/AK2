all: calc

calc: calc.o
	ld -m elf_i386 -o calc calc.o

calc.o: calc.s
	as --32 --gstabs -o calc.o calc.s

clean:
	rm -rf calc.o calc
