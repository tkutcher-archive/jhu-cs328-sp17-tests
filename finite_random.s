	.text
	.comm	pgmem,16,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =0
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ READ Instruction
	ldr 	r0, =read
	ldr 	r1, =num
	bl  	scanf
	ldr 	r2, =num
	ldr 	r2, [r2]
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r3, [r2]

	@ IF Instruction
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
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
	bne 	.L1_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L3_start:
	cmp 	r2, #0
	bne 	.L4_end

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =127773
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	mov 	r0, r2
	mov 	r1, r3
	bl  	__aeabi_idiv
	mov 	r2, r0
	push	{r2}
	ldr 	r2, =2836
	push	{r2}
	pop 	{r2, r3}
	mul 	r2, r2, r3
	push	{r2}
	ldr 	r2, =127773
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	mov 	r0, r2
	mov 	r1, r3
	bl  	__aeabi_idivmod
	mov 	r2, r1
	push	{r2}
	ldr 	r2, =16807
	push	{r2}
	pop 	{r2, r3}
	mul 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	sub 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
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
	bne 	.L5_skipt

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]
	b   	.L6_skipf
.L5_skipt:

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2147483647
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
.L6_skipf:

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =12
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
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
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
	b   	.L3_start
.L4_end:
	b   	.L2_skipf
.L1_skipt:
.L2_skipf:

	pop 	{fp, pc}


true:
	ldr 	r0, =1
	bx  	lr

false:
	ldr 	r0, =0
	bx  	lr

.MEM:
	.word	pgmem

	.data
write:
	.asciz	"%d\n"

read:
	.asciz	"%d"

num:
	.word	0
	.end
