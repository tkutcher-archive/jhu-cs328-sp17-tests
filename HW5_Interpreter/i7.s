	.text
	.comm	pgmem,216,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =96
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =24
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =6		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =6
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =96
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =5		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =24
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =6		@ Bounds checking
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

	@ READ Instruction
	ldr 	r0, =read
	ldr 	r1, =num
	bl  	scanf
	ldr 	r2, =num
	ldr 	r2, [r2]
	push	{r2}
	ldr 	r2, =10
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =11		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r3, [r2]

	@ WRITE Instruction
	ldr 	r2, =10
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =11		@ Bounds checking
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
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =44
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =10
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =11		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =44
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =44
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =66
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =48
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2}
	ldr 	r3, =44
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