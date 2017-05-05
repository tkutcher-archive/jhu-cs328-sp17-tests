	.text
	.comm	pgmem,52,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #48]

	@ IF Instruction
	ldr	r5, [r9, #48]
	cmp	r5, #5
	ldrlt	r5, =1
	ldrge	r5, =0
	cmp	r5, #1
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
	ldr	r5, =num
	ldr	r5, [r5]
	ldr	r6, [r9, #48]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #24
	str	r5, [r9, r6]

	@ Assignment
	ldr	r5, [r9, #48]
	add	r5, r5, #1
	str	r5, [r9, #48]

	ldr	r5, [r9, #48]
	cmp	r5, #5
	ldrge	r5, =1
	ldrlt	r5, =0
	mov	r8, r5	@ result
	b	.L3_start
.L4_end:

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #48]

	@ Assignment
	ldr	r5, =5
	str	r5, [r9, #44]

	@ IF Instruction
	ldr	r5, [r9, #44]
	cmp	r5, #0
	ldrgt	r5, =1
	ldrle	r5, =0
	cmp	r5, #1
	bne	.L6_skipt
	@ Repeat Instruction
	ldr	r8, =0	@ comparison reg
.L8_start:
	cmp	r8, #0
	bne	.L9_end
	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #48]

	@ IF Instruction
	ldr	r5, [r9, #44]
	sub	r5, r5, #1
	ldr	r6, [r9, #48]
	cmp	r6, r5
	ldrlt	r6, =1
	ldrge	r6, =0
	cmp	r6, #1
	bne	.L10_skipt
	@ Repeat Instruction
	ldr	r5, =0	@ comparison reg
.L12_start:
	cmp	r5, #0
	bne	.L13_end
	@ IF Instruction
	ldr	r6, [r9, #48]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #24
	ldr	r7, [r9, #48]
	add	r7, r7, #1
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r7, r7, r10	@ indexing
	add	r7, r7, #24
	ldr	r10, [r9, r6]
	ldr	r6, [r9, r7]
	cmp	r10, r6
	ldrgt	r10, =1
	ldrle	r10, =0
	cmp	r10, #1
	bne	.L14_skipt
	@ Assignment
	ldr	r6, [r9, #48]
	add	r6, r6, #1
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #24
	ldr	r7, [r9, r6]
	str	r7, [r9, #0]

	@ Assignment
	ldr	r6, [r9, #48]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #24
	ldr	r7, [r9, #48]
	add	r7, r7, #1
	cmp	r7, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r7, r7, r10	@ indexing
	add	r7, r7, #24
	ldr	r10, [r9, r6]
	str	r10, [r9, r7]

	b	.L16_pool	@ literal pool
.ltorg

.L16_pool:
	@ Assignment
	ldr	r6, [r9, #48]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, #24
	ldr	r7, [r9, #0]
	str	r7, [r9, r6]

	b	.L15_skipf
.L14_skipt:
.L15_skipf:

	@ Assignment
	ldr	r6, [r9, #48]
	add	r6, r6, #1
	str	r6, [r9, #48]

	ldr	r5, [r9, #44]
	sub	r5, r5, #1
	ldr	r6, [r9, #48]
	cmp	r6, r5
	ldrge	r6, =1
	ldrlt	r6, =0
	mov	r5, r6	@ result
	b	.L12_start
.L13_end:

	b	.L11_skipf
.L10_skipt:
.L11_skipf:

	b	.L17_pool	@ literal pool
.ltorg

.L17_pool:
	@ Assignment
	ldr	r5, [r9, #44]
	sub	r5, r5, #1
	str	r5, [r9, #44]

	ldr	r5, [r9, #44]
	cmp	r5, #0
	ldrle	r5, =1
	ldrgt	r5, =0
	mov	r8, r5	@ result
	b	.L8_start
.L9_end:

	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #48]

	@ Assignment
	ldr	r5, =24	@ from
	ldr	r8, =4	@ to
	add	r3, r5, #20	@ stop
.L18_cpy_s:
	cmp	r5, r3
	beq	.L19_cpy_f
	ldr	r6, [r9, r5]
	str	r6, [r9, r8]
	add	r5, r5, #4	@ ++from
	add	r8, r8, #4	@ ++to
	b	.L18_cpy_s
.L19_cpy_f:

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	@ IF Instruction
	ldr	r5, [r9, #48]
	cmp	r5, #5
	ldrlt	r5, =1
	ldrge	r5, =0
	cmp	r5, #1
	bne	.L21_skipt
	@ Repeat Instruction
	ldr	r8, =0	@ comparison reg
.L23_start:
	cmp	r8, #0
	bne	.L24_end
	@ WRITE Instruction
	ldr	r5, [r9, #48]
	cmp	r5, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r5, r5, r6	@ indexing
	add	r5, r5, #4
	ldr	r1, [r9, r5]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r5, [r9, #48]
	add	r5, r5, #1
	str	r5, [r9, #48]

	ldr	r5, [r9, #48]
	cmp	r5, #5
	ldrge	r5, =1
	ldrlt	r5, =0
	mov	r8, r5	@ result
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
