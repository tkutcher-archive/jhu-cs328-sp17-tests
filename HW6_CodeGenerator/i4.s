	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =6
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blle	true
	blgt	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L1_skipt

	@ WRITE Instruction
	ldr 	r2, =11
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L2_skipf
.L1_skipt:
.L2_skipf:

	@ IF Instruction
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blne	true
	bleq	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L3_skipt

	@ WRITE Instruction
	ldr 	r2, =13
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L4_skipf
.L3_skipt:

	@ WRITE Instruction
	ldr 	r2, =54
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
.L4_skipf:

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
