.text
.global _start
.extern printf

LocalCopy:
	SUB SP, SP, 40 //subtract 48 from stack pointer (SP) == allocating
	STUR LR, [SP, 32] //storing return address to start
	
	ADR X0, arr // base of global array
	MOV X1, 0   // index
L1:	LSL X2, X1, 3 //bitshift 3 to the left, (multiplying by 8) X2 == offset
	ADD X9, X0, X2 //X9 = base + offset (exact location of element == address on source)
	LDUR X10, [X9, 0] 
	ADD X11, SP, X2 // X11 = base + offset (on the stack == address on destination)
	STUR X10, [X11, 0]
	ADD X1, X1, 1
	CMP X1, 4 //compare X1 and 5 
	B.NE L1 //branch not equal
	
	ADR X0, str
	LDUR X1, [SP, 24]
	LDUR X2, [SP, 16]
	LDUR X3, [SP, 8]
	LDUR X4, [SP, 0]
	BL printf
	
	LDUR LR, [SP, 32] //loading return address to start
	ADD SP, SP, 40 //adding it back (pop) == deallocating
	BR LR // or X30
_start:

	BL LocalCopy
	// exit call
	MOV X0, 0
	MOV X8, 93
	SVC 0



.data
arr: .quad 12, 34, 56, 78
str: .ascii "%ld %ld %ld %ld\n\0" // quad, use %ld to print