SYS_EXIT = 1
EXIT_SUCCESS = 0
STDOUT = 1
SYSWRITE = 4


.code32

.data
liczba1:
	.long 0x80000000, 0x00000100, 0x00000001, 0x00000000
liczba2:
	.long 0x80000010, 0x00000010, 0x00000000, 0x80000000

len = .-liczba1

.text
.global _start

_start:
	xor %eax, %eax		#zerowanie rejestrow
	xor %ebx, %ebx
	xor %ecx, %ecx
	xor %edx, %edx

movl $4, %ecx	#wstawianie 4 do rejestru ecx jako porownywator"
movl $3, %edx

	clc			#zerowanie flagi przeniesienia CF = 0

_loop_start:

	movl liczba1(,%edx, 4), %eax
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

