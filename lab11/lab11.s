/*Lab 11 Solution
Eric Song
I pledge my honor that I have abided by the Stevens Honor system*/


.text
.global _start
.extern printf

_start:
	mov 	x8,  #0  /* outer index i*/
	mov	x9,  #0	 /* inner index j*/
	adr	x0, max
	ldur	d10, [x0]
	fmov	d9, d10  	/*load max to d9*/
	ldr     d15, min // load min to d15
	adr x0, x
	adr	x2, y
	mov	x3, #0
	mov	x4, #1
       LDR X20, N
	b 	inner

outer:
    add x8, x8, #1
    cmp x8, X20
    bge exit
    mov x9, 0
    b inner
    
inner:
	cmp 	X8, X9
	beq	innerindex
	mov	x11, #8
	mul	x10, x8, x11
	ldr	d10, [x0, x10] /* load xi*/
	ldr	d11, [x2, x10] /* load yi*/
	
	mul	x10, x9,x11
	ldr	d12, [x0, x10] /* load xj*/
	ldr	d13, [x2, x10] /* load yi*/
	cmp	x9, X20
	bge	outer
	b 	distance

innerindex:
	add	x9, x9, #1
	b 	inner


distance:
	fsub	d10, d10, d12
	fmul	d10, d10, d10
	fsub	d11, d11, d13
	fmul	d11, d11, d11
	fadd 	d11, d10, d11
	fcmp	d11, d9
	bge	updatemax
	fcmp	d11, d15
	blt 	updatemin
	b	innerindex

updatemin:
	fmov d15, d11
	mov	x21, x8
	mov 	x22, x9
	b 	innerindex
updatemax:
	fmov 	d9, d11
	mov	x3, x8
	mov	x4, x9
	b	innerindex
    
exit:
   ldr x0, =printmax
    mov x1, X3
    mov x2, X4
	bl printf
	adr x0, printmin
	mov x1, x21
	mov x2, x22
	bl printf
	mov x0, 0
	mov x8, 93
	svc 0
	
.data
N:
.dword 8
max: 
	.double 0.0
min:
	.double 100000000.0

x:
	.double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
y:
	.double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196

printmax:
	.ascii "The index of the two points with the largest distance is (%d, %d). \n\0"
printmin:
	.ascii "The index of the two points with the smallest distance is: (%d, %d) \n\0"

.end
