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
	mov	r8, #0
	str	r8, [fp, #-8]
	str	r8, [fp, #-12]
	str	r8, [fp, #-16]
	str	r8, [fp, #-20]
	@ begin procedure instructions
	@ IF Instruction
	ldr	r8, [fp, #-16]
	cmp	r8, #3
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L1_skipt
	@ Repeat Instruction
	ldr	r10, =0	@ comparison reg
.L3_start:
	cmp	r10, #0
	bne	.L4_end
	@ Assignment
	ldr	r8, [fp, #-16]
	str	r8, [fp, #-20]

	@ Assignment
	ldr	r8, [fp, #-16]
	add	r8, r8, #1
	str	r8, [fp, #-8]

	@ IF Instruction
	ldr	r8, [fp, #-8]
	cmp	r8, #4
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L5_skipt
	@ Repeat Instruction
	ldr	r4, =0	@ comparison reg
.L7_start:
	cmp	r4, #0
	bne	.L8_end
	@ IF Instruction
	ldr	r8, [fp, #-24]
	ldr	r7, [fp, #-8]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, r8
	ldr	r8, [fp, #-24]
	ldr	r5, [fp, #-20]
	cmp	r5, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r5, r5, r6	@ indexing
	add	r5, r5, r8
	ldr	r8, [r9, r7]
	ldr	r7, [r9, r5]
	cmp	r8, r7
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L9_skipt
	@ Assignment
	ldr	r8, [fp, #-8]
	str	r8, [fp, #-20]

	b	.L10_skipf
.L9_skipt:
.L10_skipf:

	@ Assignment
	ldr	r8, [fp, #-8]
	add	r8, r8, #1
	str	r8, [fp, #-8]

	b	.L11_pool	@ literal pool
.ltorg

.L11_pool:
	ldr	r8, [fp, #-8]
	cmp	r8, #4
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r4, r8	@ result
	b	.L7_start
.L8_end:

	b	.L6_skipf
.L5_skipt:
.L6_skipf:

	@ IF Instruction
	ldr	r8, [fp, #-20]
	ldr	r4, [fp, #-16]
	cmp	r8, r4
	ldrne	r8, =1
	ldreq	r8, =0
	cmp	r8, #1
	bne	.L12_skipt
	@ Assignment
	ldr	r8, [fp, #-24]
	ldr	r4, [fp, #-16]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r4, r4, r7	@ indexing
	add	r4, r4, r8
	ldr	r8, [r9, r4]
	str	r8, [fp, #-12]

	@ Assignment
	ldr	r8, [fp, #-24]
	ldr	r4, [fp, #-20]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r4, r4, r7	@ indexing
	add	r4, r4, r8
	ldr	r8, [fp, #-24]
	ldr	r7, [fp, #-16]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, r8
	ldr	r8, [r9, r4]
	str	r8, [r9, r7]

	@ Assignment
	ldr	r8, [fp, #-24]
	ldr	r4, [fp, #-20]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r4, r4, r7	@ indexing
	add	r4, r4, r8
	ldr	r8, [fp, #-12]
	str	r8, [r9, r4]

	b	.L14_pool	@ literal pool
.ltorg

.L14_pool:
	b	.L13_skipf
.L12_skipt:
.L13_skipf:

	@ Assignment
	ldr	r8, [fp, #-16]
	add	r8, r8, #1
	str	r8, [fp, #-16]

	ldr	r8, [fp, #-16]
	cmp	r8, #3
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r10, r8	@ result
	b	.L3_start
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
	ldr	r8, =3
	str	r8, [r9, #4]

	b	.L15_pool	@ literal pool
.ltorg

.L15_pool:
	@ Assignment
	ldr	r8, =1
	str	r8, [r9, #8]

	@ Assignment
	ldr	r8, =4
	str	r8, [r9, #12]

	@ Assignment
	ldr	r8, =2
	str	r8, [r9, #16]

	ldr	r0, =4	@ load address
	push	{r0}
	pop	{r0}
	bl	sortProc
	@ IF Instruction
	ldr	r8, [r9, #0]
	cmp	r8, #4
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L16_skipt
	@ Repeat Instruction
	ldr	r10, =0	@ comparison reg
.L18_start:
	cmp	r10, #0
	bne	.L19_end
	@ WRITE Instruction
	ldr	r8, [r9, #0]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r8, r8, r4	@ indexing
	add	r8, r8, #4
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r8, [r9, #0]
	add	r8, r8, #1
	str	r8, [r9, #0]

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	ldr	r8, [r9, #0]
	cmp	r8, #4
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r10, r8	@ result
	b	.L18_start
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
