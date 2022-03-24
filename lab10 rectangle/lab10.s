// Eric Song
// I pledge my honor that I have abided by the Stevens Honor System
// Lab 10

.text
.global _start
.extern printf

/*
y = 2.5x^3 − 15.5x^2 + 20x + 15, [-0.5, 5] == 74.1068
Integrate[2.5x^3-15.5x^2+20x+15, {x, -0.5, 5}]

double a, b, w, sum, x; int i, n;
a = -0.5; b = 5; n = 100

w = (b-a)/n;
sum = 0;

for (i=1; i<n; i++) {
    x = a + (i-1)*w;
    sum = sum + (w * f(x))
    }

for (i=1; i<n; i++) {
    x = a + [(D16)*w;]==D17
    sum = sum + (w * f(x))
    }

print res

D8: a
D9: b
D10: n
D11: w
D12: sum
D13: i
D14: x
D15: y

D30: the number 1
D16-D31: temps
 */

forloop:
    FSUB D16, D13, D30 // i-1
    FMUL D17, D16, D11 // (i-1)*w
    FADD D14, D8, D17  // x = a + (i-1)*w
    B function
comeback:
    FMUL D29, D11, D15
    FADD D12, D12, D29
    FADD D13, D13, D30
    FCMP D13, D10 // compares i and n
    B.NE forloop
    B printplease 

function: //y = 2.5x^3 − 15.5x^2 + 20x + 15 == 2.5*x*x*x - 15.5*x*x + 20*x + 15 = y
    FMOV D29, 2.5
    FMOV D25, D14
    FMUL D25, D25, D25 // X = X*X
    FMUL D25, D25, D14 // X = X * X^2
    FMUL D15, D29, D25 // Y = 2.5X^3

    FMOV D29, 15.5
    FMOV D25, D14
    FMUL D25, D25, D25
    FMUL D25, D25, D29 // D25 = X^2 * 15.5
    FSUB D15, D15, D25 // Y = 2.5X^3 - 15.5X^2

    FMOV D29, 20
    FMOV D25, D14
    FMUL D25, D25, D29 // Y = 20*x
    FADD D15, D15, D25

    FMOV D29, 15
    FADD D15, D15, D29
    B comeback

printplease:
    LDR D29, diff
    LDR D28, actual
    FSUB D29, D12, D28 
    ADR X0, str
    FMOV D0, D12
    FMOV D1, D29 
    BL printf
    B EXIT


_start:
    LDR D8, a
    LDR D9, b
    LDR D10, n
    LDR D11, w
    LDR D12, sum
    FMOV D13, 1.0
    FMOV D30, 1.0
    FSUB D20, D9, D8
    FDIV D11, D20, D10 // D21 holds w

    B forloop

EXIT:
	MOV X0, 0
	MOV W8, 93
	SVC 0

.data
a: .double -0.5        // left limit = 0
b: .double 5        // right limit = 2
n: .double 100000         // number of rect = 10
w: .double 0
diff: .double 0
actual: .double 74.106771

sum: .double 0.0
str: .ascii "The approximation is %lf. The actual value is 74.1068. The difference is %lf\n\0." // quad, use %ld to print

result: .skip 8       // result of integral
.end

