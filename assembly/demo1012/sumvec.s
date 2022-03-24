.text
.global _start
.extern printf

/*
	X0: vec1
	X1: vec2
	X2: rest_len

	int sumvec(int* vec1, int* vec2, int rest_len) {
		if (rest_len == 0) return 0;
		else {
			return vec1[0]*vec2[0] + sumvec(vec1+1, vec2+1, rest_len-1);
		}
	}

int main() {
	int vec1[4] = {1, 3, 1, 13};
	int vec2[4] = {2, 6, 1, 0};
	int result = sumvec(vec1, vec2);
	printf("%d\n", result);
	return 0;
}

*/
sumvec:
	SUB		SP, SP, 16
	STUR	X30, [SP, 8]
	CBZ 	X2, Base

	LDUR 	X9, [X0, 0] // vec1[0]
	LDUR 	X10, [X1, 0] // vec2[0]
	MUL 	X11, X9, X10 // vec1[0] * vec2[0]
	STUR 	X11, [SP, 0]

	ADD 	X0, X0, 8
	ADD 	X1, X1, 8
	SUB		X2, X2, 1
	BL		sumvec

	LDUR 	X11, [SP, 0]
	ADD		X0, X0, X11
	B 		Done
	
Base:
	MOV		X0, 0

	LDUR 	X30, [SP, 8]
	ADD		SP, SP, 16
	BR		X30


_start:

	ADR		X0, vec1
	ADR 	X1, vec2
	MOV 	X2, 4
	BL 		sumvec

	MOV 	X1, X0
	ADR 	X0, out
	BL 		printf

	MOV		X0, 0
	MOV		X8, 93
	SVC  	0

.data
vec1: 	.quad 1, 	3, 	1, 	13
vec2: 	.quad 2, 	6,	1, 	0
out:	.ascii 	"%ld\n\0"
