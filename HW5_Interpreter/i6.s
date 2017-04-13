	.text
	.comm	pgmem,0,4
	.global	main

main:
	push	{fp, lr}


	@ IF Instruction
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	blle	true
	blgt	false
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
	b   	.L2_skipf
.L1_skipt:

	@ WRITE Instruction
	ldr 	r2, =0
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
.L2_skipf:

	@ IF Instruction
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	blne	true
	bleq	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L3_skipt

	@ WRITE Instruction
	ldr 	r2, =0
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L4_skipf
.L3_skipt:

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
.L4_skipf:

	@ IF Instruction
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	bleq	true
	blne	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L5_skipt

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L6_skipf
.L5_skipt:
.L6_skipf:

	@ IF Instruction
	ldr 	r2, =11
	push	{r2}
	ldr 	r2, =12
	push	{r2}
	pop 	{r2, r3}
	cmp 	r2, r3
	blgt	true
	blle	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L7_skipt

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
	b   	.L8_skipf
.L7_skipt:

	@ WRITE Instruction
	ldr 	r2, =0
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf
.L8_skipf:

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
