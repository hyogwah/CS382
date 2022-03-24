// lab 6
// question 2


.text
.global _start
.extern printf
_start:
	//load address/value
	ADR X10, a
	ADR X11, b
	ADR X12, c
	LDUR X13, [X10, #0]
	LDUR X14, [X11, #0]
	LDUR X15, [X12, #0]
	
	ADD X13, X13, X14 //should add a+b to prep for
	SUB X13, X13, #14 // a+b == 14 check
	CBZ X13, Else
	
	// when a+b != 14
	MOV X15, #-2
	STUR X15, [X12, #0]
	ADR X0, msg
	LDUR X1, [X12, #0]
	BL printf
	
	MOV X0, #0
	MOV W8, #93
	SVC #0
Else: // when a+b == 14
	//c=3
	MOV X15, #3
	STUR X15, [X12, #0]
	ADR X0, msg
	LDUR X1, [X12, #0]
	BL printf
	MOV X0, #0
	MOV W8, #93
	SVC #0
.data
	a: .quad 8
	b: .quad 7
	c: .quad 0
	msg: .ascii "c = %d\n\0"
		
.end