	.text
	.comm	pgmem,84,4

	.align	2
set:
	str	fp, [sp, #-4]!	@ leaf function
	add	fp, sp, #0
	sub	sp, sp, #20	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	str	r3, [fp, #-20]
	@ begin procedure instructions
	@ Assignment
	ldr	r4, [fp, #-8]
	ldr	r5, [fp, #-16]
	cmp	r5, #9	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r5, r5, r7	@ indexing
	add	r5, r5, r4
	ldr	r4, [fp, #-20]
	str	r4, [r9, r5]

	@ Assignment
	ldr	r4, [fp, #-12]
	ldr	r5, [fp, #-16]
	cmp	r5, #9	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r5, r5, r7	@ indexing
	add	r5, r5, r4
	ldr	r4, [fp, #-20]
	str	r4, [r9, r5]

	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr	@ return to caller


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r4, =num
	ldr	r4, [r4]
	str	r4, [r9, #0]

	ldr	r0, [r9, #0]
	push	{r0}
	ldr	r0, =1
	push	{r0}
	ldr	r0, =44	@ load address
	push	{r0}
	ldr	r0, =4	@ load address
	push	{r0}
	pop	{r0, r1, r2, r3}
	bl	set
	@ WRITE Instruction
	ldr	r1, [r9, #4]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #8]
	ldr	r0, =write
	bl	printf

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #12]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #16]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #20]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #44]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #48]
	ldr	r0, =write
	bl	printf

	b	.L2_pool	@ literal pool
.ltorg

.L2_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #52]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #56]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #60]
	ldr	r0, =write
	bl	printf

	ldr	r0, =0
	ldmfd	sp!, {fp, pc}	@ end main

err:
	ldr	r0, =stderr
	ldr	r0, [r0]
	ldr	r1, =emsg
	bl	fprintf
	ldr	r0, =1
	bl	exit	@ quit

.MEM:
	.word	pgmem	@ program memory

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
