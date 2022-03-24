/*     0  1  2  3  4
A = [-13, 1, 3, 4, 5]
function binary_search(A, 5, 1)
L = 0
R = 4
while (1 <= 1)
	m = 1
	if A[1] < 1 
		L = 1
	if  3 > 1
		R = 2-1 =1
	return 1:
function binary_search(A, n, T) is
    L := 0
    R := n − 1
    while L ≤ R do
        m := floor((L + R) / 2)
        if A[m] < T then
            L := m + 1
        else if A[m] > T then
            R := m − 1
        else:
            return m
    return unsuccessful

*/

// Eric Song
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf
.extern scanf

/*
void selection_sort(int array[], const int length) {
    for(int i = 0; i < length - 1; i++) {
        int min_j = i;
        for(int j = i + 1; j < length; j++) {
            if(array[j] < array[min_j]) {
                min_j = j;
            }
        }     
        if(min_j != i) {
            swap(array, i, min_j);
        }
    }
}
*/

/*
X20 base address of array
X21 size
X22 i
X23 min_j
X24 j
X25 value of array[j]
X26 value of array[min_j]
X27 length-1
X28 i+1
X29 print index
 */

SelectionSort:
    ADR X20, arr //loads base address of array
    LDR X21, size
    MOV X27, X21
    SUB X27, X27, 1 // length - 1
    // for(int i = 0; i < length - 1; i++)
    MOV X22, 0
OUTER:
    MOV X23, X22 //int min_j = i;
    
    MOV X28, X22 // x28 = i
    ADD X28, X28, 1 // x28 = i+1
    MOV X24, X28
INNER:
    LSL X1, X24, 3 // this offset of j * 8
    ADD X9, X20, X1 // base + offset of array
    LDUR X10, [X9, 0] // value of A[j] inside X10
    LSL X2, X23, 3 // this offset of min_j * 8
    ADD X11, X20, X2 // base + offset of array
    LDUR X12, [X11, 0] // value of A[min_j] inside X12

    CMP X12, X10 
    B.GT IFMINJGREATERTHANJ // if X12 > X10
    ADD X24, X24, 1
    CMP X24, X21
    B.NE INNER
    B AFTERINNER

IFMINJGREATERTHANJ: 
    MOV X23, X24
    ADD X24, X24, 1
    CMP X24, X21
    B.NE INNER
    B AFTERINNER

// end of inner loop
AFTERINNER:
    CMP X23, X22
    B.NE pleaseSwap
    B DONE

pleaseSwap:
    BL SWAP

DONE:
    ADD X22, X22, 1
    CMP X22, X27 //compares i and (length-1)
    B.NE OUTER // if i != length-1
    B startofsearch

SWAP: 
    SUB SP, SP, 8
    STUR LR, [SP, 0]

    LSL X13, X22, 3
    ADD X14, X20, X13
    LDUR X15, [X14, 0]
    
    LSL X16, X23, 3
    ADD X17, X20, X16
    LDUR X18, [X17, 0]
    MOV X3, X15
    MOV X15, X18
    MOV X18, X3

    STUR X15, [X14, 0]
    STUR X18, [X17, 0]

    LDUR LR, [SP, 0] //loading return address to start
    ADD SP, SP, 8 //adding it back (pop) == deallocating
    BR LR // or X30
/////////////////////////////////////////////////////////////////////////////////

binaryserach:
    LDR X28, size
    MOV X23, 0       // L = 0
    SUB X27, X28, 1   // X27 = n - 1
    MOV X24, X27     // R := n − 1

L1: // while L ≤ R do
    
    ADD X27, X23, X24 // L + R
    LSR X27, X27, 1       // m := floor((L + R) / 2)
    MOV X25, X27     // X25(m) = floor(L+R) /2)

    MOV X29, X25     // X29 = m
    LSL X29, X29, 3       // m * 8 for index
    ADD X15, X20, X29 // address + index into X15
    LDUR X19, [X15, 0] // X27 = A[m]

    CMP X19, X22
    B.LT ifAmlessthanT // if (X27 < X22)
    CMP X19, X22
    B.GT ifAmgreaterthanT
    B EXITT //return m at exit1


    ifAmlessthanT: // L = m+1
    ADD X27, X25, 1
    MOV X23, X27
    
    CMP X23, X24 // while L ≤ R do
    B.GT unsuccessful
    B L1

    ifAmgreaterthanT: // R = m-1
    SUB X27, X25, 1
    MOV X24, X27
    
    CMP X23, X24 // while L ≤ R do
    B.GT unsuccessful
    B L1

unsuccessful:
    ADR X0, bad
    MOV X1, X22
    BL printf
    B EXIT      

EXITT: //success
    ADR X0, good
    MOV X1, X22
    BL printf

    ADR X0, index
    MOV X1, X25
    BL printf

    B EXIT     

_start:
	LDR X21, size
	CBZ X21, EXIT
	B SelectionSort

startofsearch:
    ADR X0, target
    ADR X1, input
    BL scanf
    LDR X22, input
    B binaryserach
	// exit call
    
EXIT:
	MOV X0, 0
	MOV W8, 93
	SVC 0
/*
X20 base address of array
X21 size (n)
X22 target (T)
X23 L
X24 R
X25 m
X26 counter for while loop
X27 temp
X28 temp (size)
X29 index i
 */

.data
target: .ascii "%ld\0"
input: .quad 0
size: .quad 5
arr: .quad 5, 3, 4, -13, 1
str: .ascii "%ld\n\0" // quad, use %ld to print
bad: .ascii "Not found in the array: %ld\n\0" // quad, use %ld to print
good: .ascii "Found in the array: %ld\n\0" // quad, use %ld to print
index: .ascii "At index: %ld\n\0" // quad, use %ld to print
.end

