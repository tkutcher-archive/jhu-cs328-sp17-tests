	.text
	.comm	pgmem,44,4
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
	ldr 	r4, =4		@ Bounds checking
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

	@ IF Instruction
	ldr 	r2, =6
	push	{r2}
	ldr 	r2, =6
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	bleq	true
	blne	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L1_skipt

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ IF Instruction
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, =4
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	blge	true
	bllt	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L3_skipt

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L4_skipf
.L3_skipt:
.L4_skipf:
	b   	.L2_skipf
.L1_skipt:

	@ WRITE Instruction
	ldr 	r2, =-1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
.L2_skipf:

	@ READ Instruction
	ldr 	r0, =read
	ldr 	r1, =num
	bl  	scanf
	ldr 	r2, =num
	ldr 	r2, [r2]
	push	{r2}
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r3, [r2]

	@ IF Instruction
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	ldr 	r3, [r3]
	cmp 	r2, r3
	bllt	true
	blge	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L5_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L7_start:
	cmp 	r2, #0
	bne 	.L8_end

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =10
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blgt	true
	blle	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L9_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L11_start:
	cmp 	r2, #0
	bne 	.L12_end

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
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
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	mul 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	sub 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blle	true
	blgt	false
	push	{r0}
	pop 	{r2}
	b   	.L11_start
.L12_end:
	b   	.L10_skipf
.L9_skipt:
.L10_skipf:

	@ Assignment
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =20
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	ldr 	r3, [r3]
	cmp 	r2, r3
	blge	true
	bllt	false
	push	{r0}
	pop 	{r2}
	b   	.L7_start
.L8_end:
	b   	.L6_skipf
.L5_skipt:
.L6_skipf:

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
