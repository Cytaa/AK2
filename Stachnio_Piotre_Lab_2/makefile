all: adder subtractor
	

adder: adder.s
	as adder.s -o adder.o
	ld adder.o -o adder

clean:
	rm -rf adder.o adder
	rm -rf subtractor.o subtractor

subtractor: subtractor.s
	as subtractor.s -o subtractor.o
	ld subtractor.o -o subtractor