	.text
	.comm	pgmem,20,4

	.align	2
sortProc:
	str	fp, [sp, #-4]!	@ leaf function
	add	fp, sp, #0
	sub	sp, sp, #24	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-24]
	@ Initialize stack frame for locals
	mov	r10, #0
	str	r10, [fp, #-8]
	str	r10, [fp, #-12]
	str	r10, [fp, #-16]
	str	r10, [fp, #-20]
	@ begin procedure instructions
	@ IF Instruction
	ldr	r10, [fp, #-20]
	cmp	r10, #3
	bge	.L1_skipt
	@ Repeat Instruction
.L3_start:
	@ Assignment
	ldr	r10, [fp, #-20]
	str	r10, [fp, #-8]

	@ Assignment
	ldr	r10, [fp, #-20]
	add	r10, r10, #1
	str	r10, [fp, #-12]

	@ IF Instruction
	ldr	r10, [fp, #-12]
	cmp	r10, #4
	bge	.L5_skipt
	@ Repeat Instruction
.L7_start:
	@ IF Instruction
	ldr	r10, [fp, #-24]
	ldr	r7, [fp, #-12]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r7, r7, r4	@ indexing
	add	r7, r7, r10
	ldr	r10, [fp, #-24]
	ldr	r4, [fp, #-8]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r4, r4, r6	@ indexing
	add	r4, r4, r10
	ldr	r10, [r9, r7]
	ldr	r7, [r9, r4]
	cmp	r10, r7
	bge	.L9_skipt
	@ Assignment
	ldr	r10, [fp, #-12]
	str	r10, [fp, #-8]

	b	.L10_skipf
.L9_skipt:
.L10_skipf:

	@ Assignment
	ldr	r10, [fp, #-12]
	add	r10, r10, #1
	str	r10, [fp, #-12]

	b	.L11_pool	@ literal pool
.ltorg

.L11_pool:
	ldr	r10, [fp, #-12]
	cmp	r10, #4
	bge	.L8_end	@ comparison
	b	.L7_start	@ repeat
.L8_end:

	b	.L6_skipf
.L5_skipt:
.L6_skipf:

	@ IF Instruction
	ldr	r10, [fp, #-8]
	ldr	r7, [fp, #-20]
	cmp	r10, r7
	beq	.L12_skipt
	@ Assignment
	ldr	r10, [fp, #-24]
	ldr	r7, [fp, #-20]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r7, r7, r4	@ indexing
	add	r7, r7, r10
	ldr	r10, [r9, r7]
	str	r10, [fp, #-16]

	@ Assignment
	ldr	r10, [fp, #-24]
	ldr	r7, [fp, #-8]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r7, r7, r4	@ indexing
	add	r7, r7, r10
	ldr	r10, [fp, #-24]
	ldr	r4, [fp, #-20]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r4, r4, r6	@ indexing
	add	r4, r4, r10
	ldr	r10, [r9, r7]
	str	r10, [r9, r4]

	@ Assignment
	ldr	r10, [fp, #-24]
	ldr	r7, [fp, #-8]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r7, r7, r4	@ indexing
	add	r7, r7, r10
	ldr	r10, [fp, #-16]
	str	r10, [r9, r7]

	b	.L14_pool	@ literal pool
.ltorg

.L14_pool:
	b	.L13_skipf
.L12_skipt:
.L13_skipf:

	@ Assignment
	ldr	r10, [fp, #-20]
	add	r10, r10, #1
	str	r10, [fp, #-20]

	ldr	r10, [fp, #-20]
	cmp	r10, #3
	bge	.L4_end	@ comparison
	b	.L3_start	@ repeat
.L4_end:

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr	@ return to caller


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r10, =3
	str	r10, [r9, #0]

	b	.L15_pool	@ literal pool
.ltorg

.L15_pool:
	@ Assignment
	ldr	r10, =1
	str	r10, [r9, #4]

	@ Assignment
	ldr	r10, =4
	str	r10, [r9, #8]

	@ Assignment
	ldr	r10, =2
	str	r10, [r9, #12]

	ldr	r0, =0	@ load address
	push	{r0}
	pop	{r0}
	bl	sortProc
	@ IF Instruction
	ldr	r10, [r9, #16]
	cmp	r10, #4
	bge	.L16_skipt
	@ Repeat Instruction
.L18_start:
	@ WRITE Instruction
	ldr	r10, [r9, #16]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r10, r10, r7	@ indexing
	add	r10, r10, #0
	ldr	r1, [r9, r10]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r10, [r9, #16]
	add	r10, r10, #1
	str	r10, [r9, #16]

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	ldr	r10, [r9, #16]
	cmp	r10, #4
	bge	.L19_end	@ comparison
	b	.L18_start	@ repeat
.L19_end:

	b	.L17_skipf
.L16_skipt:
.L17_skipf:

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
