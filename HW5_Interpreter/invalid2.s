	.text
	.comm	pgmem,264,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =5
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =64
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =10		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =20
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	pop 	{fp, pc}


true:
	ldr 	r0, =1
	bx  	lr

false:
	ldr 	r0, =0
	bx  	lr

err:
	ldr 	r0, =stderr
	ldr 	r0, [r0]
	ldr 	r1, =emsg
	bl  	fprintf
	ldr 	r0, =1
	bl  	exit

.MEM:
	.word	pgmem

	.data

write:
	.asciz	"%d\n"

read:
	.asciz	"%d"

emsg:
	.asciz	"error: invalid number\n"

num:
	.word	0
	.end
