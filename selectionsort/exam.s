/*
global arrary of 1,3,5,7,9 quad ==> 40 bytes
Create a procedure where I make a local copy of the array
and print all the elements of the local array
*/

.text
.global _start
.extern printf

//start of procedure (named LocalCopy)
//non-leaf proecudre, which means we need to allocate 8 bytes to store return address
//40 bytes for array, 8 bytes for return == 48 bytes
LocalCopy:
	SUB SP, SP, 48 //subtract 48 from stack pointer (SP) == allocating
	STUR LR, [SP, 40] //storing return address to start
	
	ADR X0, arr // base of global array
	MOV X1, 0   // index
L1:	LSL X2, X1, 3 //bitshift 3 to the left, (multiplying by 8) X2 == offset
	ADD X9, X0, X2 //X9 = base + offset (exact location of element == address on source)
	LDUR X10, [X9, 0] 
	ADD X11, SP, X2 // X11 = base + offset (on the stack == address on destination)
	STUR X10, [X11, 0]
	ADD X1, X1, 1
	CMP X1, 5 //compare X1 and 5 
	B.NE L1 //branch not equal
	
	ADR X0, str
	LDUR X1, [SP, 0]
	LDUR X2, [SP, 8]
	LDUR X3, [SP, 16]
	LDUR X4, [SP, 24]
	LDUR X5, [SP, 32]
	BL printf
	
	LDUR LR, [SP, 40] //loading return address to start
	ADD SP, SP, 48 //adding it back (pop) == deallocating
	BR LR // or X30
_start:

	BL LocalCopy
	// exit call
	MOV X0, 0
	MOV X8, 93
	SVC 0



.data
arr: .quad 1,3,5,7,9  // array of size 5, numbers 1-9 odds
str: .ascii "%ld %ld %ld %ld %ld\n\0" // quad, use %ld to print