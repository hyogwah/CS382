/*
Eric Song
I pledge my honor that I have abided by the Stevens Honor system

int main() {
    double epsilon = LOAD;
    double a, b, m, y_m, y_a, n;
    a = LOAD;
    b = LOAD;
    n = LOAD;
    array = LOAD;

    f(x) =
    while ( (b-a) > epsilon) {
        m = (a+b)/2;

        y_m = m*m*m + m - 3; // this is literally y_m = f(m)
        y_a = a*a*a + a - 3; // y_a = f(a)


        D9 = arr[i]
        while (count < n) { (i = 1)
            D8 = arr[i] * m
            D9 = D9 + D8
            i++
            m = m * M (M is strictly A never changing)

        while (count < n) {
            D8 = arr[i] * a
            D9 = D9 + D8
            i++
            a= a * A (A is strictly A never changing)

        if ((y_m > 0 && y_a < 0) || (y_m < 0 && y_a > 0)) { // f(a) and f(m) have different signs move b
            b = m;
        } else {
            a = m;
        }
    }
    return (a+b)/2 ;
}

D8 : epsilon
D9 : a
D10: b
D11: m
D12: y_m
D13: y_a
D14: arr[i]
D15: solution 
X15: N
X16: array (address)
X17: count
X18: i
X19: 8
X20:
*/

.text
.global _start
.extern printf

loading:
    SUB SP, SP, 8
    STUR LR, [SP, 0]

    LDR D8, epsilon
    LDR D9, a
    LDR D20, a
    LDR D10, b
    LDR X15, N
    ADR X16, coeff

    LDUR LR, [SP, 0] //loading return address to start
    ADD SP, SP, 8 //adding it back (pop) == deallocating
    BR LR // or X30

embody: // while ( (b-a) > epsilon)
    FSUB D5, D10, D9 // D5 = b-a
    FCMP D5, D8      // while D5 is greater than D8
    B.GT whileloop
    B gottaprint 

whileloop:
    FSUB D6, D9, D10 // D6 = a+b
    LDR D7, two // D7 = 2
    FDIV D11, D6, D7 // (a+b)/2 == m
    FMOV D21, D11
    MOV X17, 0 // count
    MOV X18, 0 // i
    LSL X19, X18, 3 // migos - quavo - takeoff = offset

    LDUR D14, [X16, 0] // D14 = arr[0]
    FMOV D12, D14
whileMMM:
    ADD X18, X18, 1
    LSL X19, X18, 3 // migos - quavo - takeoff = offset
    CMP X17, X15
    B.LT whileM
    B prewhileAAA
whileM:
    ADD X20, X16, X19 // X20 = address + offset
    LDUR D14, [X20, 0] 
    FMUL D14, D14, D21
    FADD D12, D12, D14
    ADD X17, X17, 1
    FMUL D21, D21, D11
    B whileMMM

prewhileAAA:
    MOV X17, 0 // count
    MOV X18, 0 // i
    LSL X19, X18, 3 // migos - quavo - takeoff = offset

    LDUR D14, [X16, 0] // D14 = arr[0]
    FMOV D13, D14

whileAAA:
    ADD X18, X18, 1
    LSL X19, X18, 3 // migos - quavo - takeoff = offset
    CMP X17, X15
    B.LT whileA
    B IFSTATE
whileA:
    ADD X20, X16, X19 // X20 = address + offset
    LDUR D14, [X20, 0] 
    FMUL D14, D14, D20
    FADD D13, D13, D14
    ADD X17, X17, 1
    FMUL D20, D20, D9
    B whileAAA
    
IFSTATE:
    LDR D18, zero
    FCMP D12, D18
    B.GT checkltyA
    B checkgtyA

checkltyA:
    FCMP D13, D18
    B.LT bequalsm
    B aequalsm
checkgtyA:
    FCMP D13, D18
    B.GT bequalsm
    B aequalsm
bequalsm:
    FMOV D10, D11
    B embody
aequalsm:
    FMOV D9, D11
    B embody

    
gottaprint:
    FSUB D6, D9, D10 // D6 = a+b
    LDR D7, two // D7 = 2
    FDIV D11, D6, D7 // (a+b)/2 == m
    ADR X0, str
    FMOV D0, D11
    BL printf
    B EXIT
_start:
    BL loading
    B embody
EXIT:
	MOV X0, 0
	MOV W8, 93
	SVC 0

.data
a: .double -1
b: .double 1
m: .double 0
epsilon: .double 0.0001

zero: .double 0
two: .double 2
N: .quad 4
coeff: .double 0.2, 3.1, -0.3, 1.9, 0.2

str: .ascii "%d\n\0" // quad, use %ld to print

.end