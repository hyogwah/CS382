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

// Eric Song
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf
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
    B printarr

SWAP: // swap(array, i, min_j); swap array[i] with array[min_j]
/*
X13 = i * 8
X14 = X20 + X13 ==> base + offset
X15 load from X14 ==> array[i]
X16 = min_j * 8
X17 = X20 + X16
X18 load from X17 ==> array[min_j]
X3 = X15
X15 = X18
X18 = X3
STUR X15, [X14, 0]
STUR X18, [X17, 0]

 */
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



printarr:
    //ideally print array
    ADR X0, str
    LDUR X1, [X20, 0]
    BL printf
    SUB X21, X21, 1
    ADD X20, X20, 8
    CBNZ X21, printarr
    B EXIT

_start:
	LDR X21, size
	CBZ X21, EXIT
	B SelectionSort
	// exit call
EXIT:
	MOV X0, 0
	MOV W8, 93
	SVC 0

.data
size: .quad 10
arr: .quad 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
str: .ascii "%d\n\0" // quad, use %ld to print

.end

