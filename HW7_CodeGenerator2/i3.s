	.text
	.comm	pgmem,52,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #28]

	@ IF Instruction
	ldr	r8, [r9, #28]
	cmp	r8, #5
	bge	.L1_skipt
	@ Repeat Instruction
.L3_start:
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	ldr	r6, [r9, #28]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r6, r6, r5	@ indexing
	add	r6, r6, #4
	str	r8, [r9, r6]

	@ Assignment
	ldr	r8, [r9, #28]
	add	r8, r8, #1
	str	r8, [r9, #28]

	ldr	r8, [r9, #28]
	cmp	r8, #5
	bge	.L4_end	@ comparison
	b	.L3_start	@ repeat
.L4_end:

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #28]

	@ Assignment
	ldr	r8, =5
	str	r8, [r9, #24]

	@ IF Instruction
	ldr	r8, [r9, #24]
	cmp	r8, #0
	ble	.L6_skipt
	@ Repeat Instruction
.L8_start:
	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #28]

	@ IF Instruction
	ldr	r8, [r9, #24]
	sub	r8, r8, #1
	ldr	r6, [r9, #28]
	cmp	r6, r8
	bge	.L10_skipt
	@ Repeat Instruction
.L12_start:
	@ IF Instruction
	ldr	r8, [r9, #28]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, #4
	ldr	r6, [r9, #28]
	add	r6, r6, #1
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r6, r6, r5	@ indexing
	add	r6, r6, #4
	ldr	r5, [r9, r8]
	ldr	r8, [r9, r6]
	cmp	r5, r8
	ble	.L14_skipt
	@ Assignment
	ldr	r8, [r9, #28]
	add	r8, r8, #1
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, #4
	ldr	r6, [r9, r8]
	str	r6, [r9, #0]

	@ Assignment
	ldr	r8, [r9, #28]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, #4
	ldr	r6, [r9, #28]
	add	r6, r6, #1
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r6, r6, r5	@ indexing
	add	r6, r6, #4
	ldr	r5, [r9, r8]
	str	r5, [r9, r6]

	b	.L16_pool	@ literal pool
.ltorg

.L16_pool:
	@ Assignment
	ldr	r8, [r9, #28]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, #4
	ldr	r6, [r9, #0]
	str	r6, [r9, r8]

	b	.L15_skipf
.L14_skipt:
.L15_skipf:

	@ Assignment
	ldr	r8, [r9, #28]
	add	r8, r8, #1
	str	r8, [r9, #28]

	ldr	r8, [r9, #24]
	sub	r8, r8, #1
	ldr	r6, [r9, #28]
	cmp	r6, r8
	bge	.L13_end	@ comparison
	b	.L12_start	@ repeat
.L13_end:

	b	.L11_skipf
.L10_skipt:
.L11_skipf:

	b	.L17_pool	@ literal pool
.ltorg

.L17_pool:
	@ Assignment
	ldr	r8, [r9, #24]
	sub	r8, r8, #1
	str	r8, [r9, #24]

	ldr	r8, [r9, #24]
	cmp	r8, #0
	ble	.L9_end	@ comparison
	b	.L8_start	@ repeat
.L9_end:

	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #28]

	@ Assignment
	ldr	r8, =4	@ from
	ldr	r6, =32	@ to
	add	r3, r8, #20	@ stop
.L18_cpy_s:
	cmp	r8, r3
	beq	.L19_cpy_f
	ldr	r5, [r9, r8]
	str	r5, [r9, r6]
	add	r8, r8, #4	@ ++from
	add	r6, r6, #4	@ ++to
	b	.L18_cpy_s
.L19_cpy_f:

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	@ IF Instruction
	ldr	r8, [r9, #28]
	cmp	r8, #5
	bge	.L21_skipt
	@ Repeat Instruction
.L23_start:
	@ WRITE Instruction
	ldr	r8, [r9, #28]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, #32
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r8, [r9, #28]
	add	r8, r8, #1
	str	r8, [r9, #28]

	ldr	r8, [r9, #28]
	cmp	r8, #5
	bge	.L24_end	@ comparison
	b	.L23_start	@ repeat
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
