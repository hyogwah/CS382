//lab 6
.text
.global _start
.extern printf


AddArray:
	ADR X0, arr // base of global array
	MOV X1, 0   // index
	ADR X12, val
	
L1:	LSL X2, X1, #3 //bitshift 3 to the left, (multiplying by 8) X2 == offset
	ADD X9, X0, X2 //X9 = base + offset (exact location of element == address on source)
	LDUR X10, [X9, 0] //load value of X9 = arr[i]
	ADD X12, X10, X12 
	
	ADD X1, X1, 1
	CMP X1, 10 //compare X1 and 10 
	B.NE L1 //branch not equal
	
	ADR X0, str
	LDUR X1, [X12, 0]
	BL printf
	MOV X0, 0
	MOV W8, 93
	SVC 0
	
_start:

	BL AddArray
	// exit call
	MOV X0, 0
	MOV W8, 93
	SVC 0



.data
val: .quad 0
arr: .quad 1,2,3,4,5,6,7,8,9,10
str: .ascii "%d\n\0" // quad, use %ld to print

.end
