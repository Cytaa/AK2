.code32

SYSEXIT = 1;
EXIT_SUCCESS = 0;

.data

zeroF: .float 0.0
liczbaDF: .float 1.1
liczbaUF: .float -2.2

zeroD: .double 0.0
liczbaDD: .double 1.1
liczbaUD: .double -2.2

.text

.global _start
_start:

    finit		

_calc:			
    # floaty
    fld liczbaDF	# laduje liczbe do st0
    fadd liczbaUF	# dodaje liczbe do st0

    fld liczbaDF
    fsub liczbaUF   # rozkaz analogiczny do fadd	

    fld liczbaDF
    fmul liczbaUF	

    fld liczbaDF
    fdiv liczbaUF	

    # double

    fld liczbaDD	# operacje analogicznie do wczesniejszych ale dla double
    fadd liczbaUD	

    fld liczbaDD
    fsub liczbaUD   	

    fld liczbaDD
    fmul liczbaUD	

    fld liczbaDD
    fdiv liczbaUD	

_exc:
    finit
    # flaot exceptions
    fld zeroF
    fmul liczbaDF	

    fld zeroF
    fmul liczbaUF	

    fld liczbaDF
    fdiv zeroF		

    fld liczbaUF
    fdiv zeroF	

    fld zeroF
    fdiv zeroF		

    # double exceptions
    fld zeroD
    fmul liczbaDD	

    fld zeroD
    fmul liczbaUD	

    fld liczbaDD
    fdiv zeroD		

    fld liczbaUD
    fdiv zeroD		

    fld zeroD
    fdiv zeroD		


end:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80
