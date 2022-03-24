

MOV     X9, 1 // i =1
L1:
LSL     X10, X9, 3 // i left shift i *8
ADD     X2, X0, X10 // base address of A + offset
SUB     X2, X2, 8  // base address of A + offset - 1*8
LDUR    X3, [X2, 0] // load A[i-1]
ADD     X5, X1, X10 // base address of B + offset
ADD     X5, X1, 16 // bas address of B + offset + 2*8
LDUR    X6, [X5, 0] // load B[i+2]
MOV     X3, X6
STUR    X3, [X2, 0]
ADD     X9, X9, 1
CMP     X9, 100
B.GE    exit
B       L1

/*
for (i = 1; i < 100; i++)
    A[i-1] = B[i+2];

 */