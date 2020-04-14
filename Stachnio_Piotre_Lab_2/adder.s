SYS_EXIT = 1
EXIT_SUCCESS = 0

.code32

.data
liczba1:
    	.long 0x10304008, 0x701100FF, 0x45100020, 0x08570030
liczba2:
    	.long 0xF040500C, 0x00220026, 0x321000CB, 0x04520031

.text
.global _start

_start:
		
	movl $4, %ecx    # licznik petli, musi byc w ecx poniewaz wracam do _loopo_start za pomoca loop
	clc					# resetowanie flagi carry do wartosci 0
_loop_start:
	movl liczba1(, %ecx, 4), %eax # skopiowanie pojedynczgo slowa liczby 1 do eax
	movl liczba2(, %ecx, 4), %ebx # skopiowanie pojedynczego slowa liczby 2 do ebx

	decl %ecx # dekrementujemy nasz iterator
	adcl %eax, %ebx # dodajemy z przeniesieniem do eax ebx
	pushl %ebx # wynik zapisuje na stosie
	loop _loop_start

jnc _bez_przeniesienia # jezeli cf = 0 idziemy do _bez_przeniesienia, w przeciwnym wypadku to pushujemy na stos 1
	pushl $1
	jmp _end # skok do end
_bez_przeniesienia:
	pushl $0
	jmp _end
_end:
	mov $SYS_EXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80  # wywolanie funkcji systemowej o parametrach SYS_EXIT, EXIT_SUCCESS, jest to funkcja odpowiadająca za kończenie programu
