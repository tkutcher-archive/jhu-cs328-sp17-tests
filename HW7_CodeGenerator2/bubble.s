	.text
	.comm	pgmem,52,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #4]

	@ IF Instruction
	ldr	r8, [r9, #4]
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
	ldr	r10, [r9, #4]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, #12
	str	r8, [r9, r10]

	@ Assignment
	ldr	r8, [r9, #4]
	add	r8, r8, #1
	str	r8, [r9, #4]

	ldr	r8, [r9, #4]
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
	str	r8, [r9, #4]

	@ Assignment
	ldr	r8, =5
	str	r8, [r9, #8]

	@ IF Instruction
	ldr	r8, [r9, #8]
	cmp	r8, #0
	ble	.L6_skipt
	@ Repeat Instruction
.L8_start:
	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #4]

	@ IF Instruction
	ldr	r8, [r9, #8]
	sub	r8, r8, #1
	ldr	r10, [r9, #4]
	cmp	r10, r8
	bge	.L10_skipt
	@ Repeat Instruction
.L12_start:
	@ IF Instruction
	ldr	r8, [r9, #4]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #12
	ldr	r10, [r9, #4]
	add	r10, r10, #1
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, #12
	ldr	r4, [r9, r8]
	ldr	r8, [r9, r10]
	cmp	r4, r8
	ble	.L14_skipt
	@ Assignment
	ldr	r8, [r9, #4]
	add	r8, r8, #1
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #12
	ldr	r10, [r9, r8]
	str	r10, [r9, #0]

	@ Assignment
	ldr	r8, [r9, #4]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #12
	ldr	r10, [r9, #4]
	add	r10, r10, #1
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, #12
	ldr	r4, [r9, r8]
	str	r4, [r9, r10]

	b	.L16_pool	@ literal pool
.ltorg

.L16_pool:
	@ Assignment
	ldr	r8, [r9, #4]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #12
	ldr	r10, [r9, #0]
	str	r10, [r9, r8]

	b	.L15_skipf
.L14_skipt:
.L15_skipf:

	@ Assignment
	ldr	r8, [r9, #4]
	add	r8, r8, #1
	str	r8, [r9, #4]

	ldr	r8, [r9, #8]
	sub	r8, r8, #1
	ldr	r10, [r9, #4]
	cmp	r10, r8
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
	ldr	r8, [r9, #8]
	sub	r8, r8, #1
	str	r8, [r9, #8]

	ldr	r8, [r9, #8]
	cmp	r8, #0
	ble	.L9_end	@ comparison
	b	.L8_start	@ repeat
.L9_end:

	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	@ Assignment
	ldr	r8, =0
	str	r8, [r9, #4]

	@ Assignment
	ldr	r8, =12	@ from
	ldr	r10, =32	@ to
	add	r3, r8, #20	@ stop
.L18_cpy_s:
	cmp	r8, r3
	beq	.L19_cpy_f
	ldr	r4, [r9, r8]
	str	r4, [r9, r10]
	add	r8, r8, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L18_cpy_s
.L19_cpy_f:

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	@ IF Instruction
	ldr	r8, [r9, #4]
	cmp	r8, #5
	bge	.L21_skipt
	@ Repeat Instruction
.L23_start:
	@ WRITE Instruction
	ldr	r8, [r9, #4]
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #32
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r8, [r9, #4]
	add	r8, r8, #1
	str	r8, [r9, #4]

	ldr	r8, [r9, #4]
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
