// lab 6

.text
.global _start
.extern printf
_start:
	//loading addresses of variables
	ADR X10, i
	ADR X11, f
	ADR X12, g
	//loading values of variables
	LDUR X13, [X10, #0] // X13 = i
	LDUR X14, [X11, #0] // X14 = f
	LDUR X15, [X12, #0] // X15 = g
	//math
	SUB X13, X13, #4
	CBZ X13, Else
	
	//else (i != 4)
	SUB X15, X15, #2
	STUR X15, [X11, #0]
	//print value of f
	ADR X0, msg
	LDUR X1, [X11, #0]
	BL printf
	
	//exit call
	MOV X0, #0
	MOV W8, #93
	SVC #0
Else:
	// (i==4)
	ADD X15, X15, #1
	STUR X15, [X11, #0]
	ADR X0, msg
	LDUR X1, [X11, #0]
	BL printf
	MOV X0, #0
	MOV W8, #93
	SVC #0
		
.data
	i: .quad 4
	f: .quad 5
	g: .quad 6
	msg: .ascii "f = %d\n\0"
		
.end