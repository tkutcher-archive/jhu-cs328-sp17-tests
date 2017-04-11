	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =2048
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
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
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	mul 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =2048
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =40
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
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
