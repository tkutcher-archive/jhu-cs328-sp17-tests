	.text
	.comm	pgmem,40,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =100
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	mov 	r1, r2			@ tracks memory address
	ldr 	r0, =20			@ address to stop copying
	add 	r0, r0, r1
.L1_start:
	cmp 	r0, r1
	beq 	.L2_end
	ldr 	r2, [r1]
	str 	r2, [r3]
	add 	r3, r3, #4		@ next address to copy to
	add 	r1, r1, #4		@ next address to copy from
	b    	.L1_start
.L2_end:

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =42
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

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
	.asciz	"error: index out of bounds\n"

num:
	.word	0
	.end
