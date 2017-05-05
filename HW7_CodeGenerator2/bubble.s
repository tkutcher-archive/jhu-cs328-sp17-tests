	.text
	.comm	pgmem,52,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r6, =0
	str	r6, [r9, #20]

	@ IF Instruction
	ldr	r6, [r9, #20]
	cmp	r6, #5
	ldrlt	r6, =1
	ldrge	r6, =0
	cmp	r6, #1
	bne	.L1_skipt
	@ Repeat Instruction
	ldr	r8, =0	@ comparison reg
.L3_start:
	cmp	r8, #0
	bne	.L4_end
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	ldr	r7, [r9, #20]
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, #32
	str	r6, [r9, r7]

	@ Assignment
	ldr	r6, [r9, #20]
	add	r6, r6, #1
	str	r6, [r9, #20]

	ldr	r6, [r9, #20]
	cmp	r6, #5
	ldrge	r6, =1
	ldrlt	r6, =0
	mov	r8, r6	@ result
	b	.L3_start
.L4_end:

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r6, =0
	str	r6, [r9, #20]

	@ Assignment
	ldr	r6, =5
	str	r6, [r9, #28]

	@ IF Instruction
	ldr	r6, [r9, #28]
	cmp	r6, #0
	ldrgt	r6, =1
	ldrle	r6, =0
	cmp	r6, #1
	bne	.L6_skipt
	@ Repeat Instruction
	ldr	r8, =0	@ comparison reg
.L8_start:
	cmp	r8, #0
	bne	.L9_end
	@ Assignment
	ldr	r6, =0
	str	r6, [r9, #20]

	@ IF Instruction
	ldr	r6, [r9, #28]
	sub	r6, r6, #1
	ldr	r7, [r9, #20]
	cmp	r7, r6
	ldrlt	r7, =1
	ldrge	r7, =0
	cmp	r7, #1
	bne	.L10_skipt
	@ Repeat Instruction
	ldr	r6, =0	@ comparison reg
.L12_start:
	cmp	r6, #0
	bne	.L13_end
	@ IF Instruction
	ldr	r7, [r9, #20]
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, #32
	ldr	r5, [r9, #20]
	add	r5, r5, #1
	cmp	r5, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r5, r5, r10	@ indexing
	add	r5, r5, #32
	ldr	r10, [r9, r7]
	ldr	r7, [r9, r5]
	cmp	r10, r7
	ldrgt	r10, =1
	ldrle	r10, =0
	cmp	r10, #1
	bne	.L14_skipt
	@ Assignment
	ldr	r7, [r9, #20]
	add	r7, r7, #1
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, #32
	ldr	r5, [r9, r7]
	str	r5, [r9, #24]

	@ Assignment
	ldr	r7, [r9, #20]
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, #32
	ldr	r5, [r9, #20]
	add	r5, r5, #1
	cmp	r5, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r5, r5, r10	@ indexing
	add	r5, r5, #32
	ldr	r10, [r9, r7]
	str	r10, [r9, r5]

	b	.L16_pool	@ literal pool
.ltorg

.L16_pool:
	@ Assignment
	ldr	r7, [r9, #20]
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r7, r7, r5	@ indexing
	add	r7, r7, #32
	ldr	r5, [r9, #24]
	str	r5, [r9, r7]

	b	.L15_skipf
.L14_skipt:
.L15_skipf:

	@ Assignment
	ldr	r7, [r9, #20]
	add	r7, r7, #1
	str	r7, [r9, #20]

	ldr	r6, [r9, #28]
	sub	r6, r6, #1
	ldr	r7, [r9, #20]
	cmp	r7, r6
	ldrge	r7, =1
	ldrlt	r7, =0
	mov	r6, r7	@ result
	b	.L12_start
.L13_end:

	b	.L11_skipf
.L10_skipt:
.L11_skipf:

	b	.L17_pool	@ literal pool
.ltorg

.L17_pool:
	@ Assignment
	ldr	r6, [r9, #28]
	sub	r6, r6, #1
	str	r6, [r9, #28]

	ldr	r6, [r9, #28]
	cmp	r6, #0
	ldrle	r6, =1
	ldrgt	r6, =0
	mov	r8, r6	@ result
	b	.L8_start
.L9_end:

	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	@ Assignment
	ldr	r6, =0
	str	r6, [r9, #20]

	@ Assignment
	ldr	r6, =32	@ from
	ldr	r8, =0	@ to
	add	r3, r6, #20	@ stop
.L18_cpy_s:
	cmp	r6, r3
	beq	.L19_cpy_f
	ldr	r7, [r9, r6]
	str	r7, [r9, r8]
	add	r6, r6, #4	@ ++from
	add	r8, r8, #4	@ ++to
	b	.L18_cpy_s
.L19_cpy_f:

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	@ IF Instruction
	ldr	r6, [r9, #20]
	cmp	r6, #5
	ldrlt	r6, =1
	ldrge	r6, =0
	cmp	r6, #1
	bne	.L21_skipt
	@ Repeat Instruction
	ldr	r8, =0	@ comparison reg
.L23_start:
	cmp	r8, #0
	bne	.L24_end
	@ WRITE Instruction
	ldr	r6, [r9, #20]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #0
	ldr	r1, [r9, r6]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r6, [r9, #20]
	add	r6, r6, #1
	str	r6, [r9, #20]

	ldr	r6, [r9, #20]
	cmp	r6, #5
	ldrge	r6, =1
	ldrlt	r6, =0
	mov	r8, r6	@ result
	b	.L23_start
.L24_end:

	b	.L22_skipf
.L21_skipt:
.L22_skipf:

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
