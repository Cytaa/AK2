SYS_EXIT = 1
EXIT_SUCCESS = 0

.code32

.data
liczba1:
	.long 0x00000001, 0x00000002, 0x40000003, 0x00000004
liczba2:
	.long 0x00000000, 0x00000000, 0x40000001, 0x00000001
suma1:
	.long 0x00000000, 0x00000000, 0x00000000, 0x00000000
suma2:
	.long 0x00000000, 0x00000000, 0x00000000, 0x00000000
indx1:
 	.long 3
indx2:
	.long 3


.text
.global _start

_start:
	xor %eax, %eax			#zerowanie rejestrow
	xor %ebx, %ebx
	xor %ecx, %ecx
	xor %edx, %edx
	xor %esi, %esi
	clc					#zerowanie flagi przeniesienia CF = 0
	movl $4, %ecx
_fill_loop:
	pushl $0
	subl $1, %ecx
	cmp $0, %ecx
	jz _outer_loop
	jmp _fill_loop
_outer_loop:
	movl $0, %eax
	movl indx2(, %eax, 4), %ecx
	movl liczba2(, %ecx, 4), %ebx
	movl indx1(, %eax, 4), %ecx
	_inner_loop:
		movl liczba1(, %ecx, 4), %eax
		mul %ebx
		addl %esi, %eax
		movl %edx, %esi
		pushl %eax
		cmp $0, %ecx
		jz _end_inner
		subl $1, %ecx
	      jmp _inner_loop
	_end_inner:
	movl $0, %ecx
	_sum1_loop:
		pop %eax
		movl %eax, suma1(, %ecx, 4)
		cmp $3, %ecx
		jz _end_sum1_loop
		addl $1, %ecx
		jmp _sum1_loop
	_end_sum1_loop:
	movl $0, %ecx
	_sum2_loop:
		pop %eax
		movl %eax, suma2(, %ecx, 4)
		cmp $3, %ecx
		jz _end_sum2_loop
		addl $1, %ecx
		jmp _sum2_loop
	_end_sum2_loop:
		movl $3, %ecx
		clc
	_sum_all_loop:
		movl suma1(, %ecx, 4), %eax
		movl suma2(, %ecx, 4), %ebx
		addl %eax, %ebx
		pushl %ebx
		jnc _bez_przeniesienia
			movl $1, %edx
			jmp _end
		_bez_przeniesienia:
			movl $0, %edx
			jmp _end
		_end:
		cmp $0, %ecx
		jz _end_sum_all_loop
		subl $1, %ecx
		jmp _sum_all_loop
	_end_sum_all_loop:
	movl %edx, %eax
	movl %esi, %ebx
	clc
	addl %eax, %ebx
	pushl %ebx

	movl $0, %eax
	movl indx2(, %eax, 4), %ecx
	cmp $0, %ecx
	jz _end_outer
	subl $1, %ecx
	movl %ecx, indx2(, %eax, 4)
	jmp _outer_loop
_end_outer:
koniec:
	mov $SYS_EXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80
