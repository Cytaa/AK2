SYS_EXIT = 1
EXIT_SUCCESS = 0

.code32

.data
liczba1:
	.long 0x11111111, 0x22222222, 0x33333333, 0x44444444
liczba2:
	.long 0x66666666, 0x77777777, 0x88888888, 0x99999999

.text
.global _start

_start:
	xor %eax, %eax			#zerowanie rejestrow
	xor %ebx, %ebx
	xor %ecx, %ecx
	xor %edx, %edx

	movl $4, %ecx			#wstawianie 3 do rejestru ecx jako iterator
	movl $3, %edx
	clc					#zerowanie flagi przeniesienia CF = 0
_loop_start:
	movl liczba1(, %edx, 4), %eax
	movl liczba2(, %edx, 4), %ebx
	subl $1, %edx
	adcl %eax, %ebx
	pushl %ebx
loop _loop_start

jnc _bez_przeniesienia
	pushl $1
	jmp _end
_bez_przeniesienia:
	pushl $0
	jmp _end
_end:

koniec:
	mov $SYS_EXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80
