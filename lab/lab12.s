// Eric Song 
// I pledge my honor that I have abided by the Stevens Honor System

.text
.global _start

_start:
    mov x19, -1
    mov x8, 63
    mov x18, -1

loop:
    /*
    1) load the data
    2) set the nbyte number
    3) systemcall
    4) compare the input character
    Branch back to loop if the character is not '\n' 
    (use ASCII value to do the comparison) */

    add x19, x19, 1
    mov x0, 0
    adr x1, buf
    add x1, x1, x19
    mov x2, 1
    svc 0
    ldr x4, [x1, 0]
    cmp x4, 10
    bne loop
    adr x1, buf

print:
    // print and then exit
    add x18, x18, 1
    adr x1, buf
    add x1, x1, x18
    mov x8, 64
    mov x0, 1
    mov x2, 1
    svc 0
    ldr x4, [x1, 0]
    cmp x4, 10
    bne print

exit:
    mov x0, 0
    mov x8, 93
    svc 0
.bss
buf: .skip 1000

.end