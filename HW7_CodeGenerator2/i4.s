	.text
	.comm	pgmem,1164,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ WRITE Instruction
	ldr	r1, =2
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =5
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =1
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r8, =412
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	ldr	r5, =1156
	str	r8, [r9, r5]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	ldr	r5, =576
	str	r8, [r9, r5]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	ldr	r5, =1160
	str	r8, [r9, r5]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	ldr	r7, =1156
	ldr	r5, [r9, r7]
	cmp	r5, #3	@ bounds checking
	bhi	err
	ldr	r7, =144
	mul	r5, r5, r7	@ indexing
	add	r5, r5, #0
	ldr	r6, =576
	ldr	r7, [r9, r6]
	cmp	r7, #5	@ bounds checking
	bhi	err
	ldr	r6, =24
	mul	r7, r7, r6	@ indexing
	add	r7, r7, r5
	ldr	r6, =1160
	ldr	r5, [r9, r6]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r5, r5, r6	@ indexing
	add	r5, r5, r7
	str	r8, [r9, r5]

	@ WRITE Instruction
	ldr	r8, =412
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r8, =0	@ from
	ldr	r5, =580	@ to
	ldr	r3, =576
	add	r3, r8, r3	@ stop
.L2_cpy_s:
	cmp	r8, r3
	beq	.L3_cpy_f
	ldr	r7, [r9, r8]
	str	r7, [r9, r5]
	add	r8, r8, #4	@ ++from
	add	r5, r5, #4	@ ++to
	b	.L2_cpy_s
.L3_cpy_f:

	b	.L4_pool	@ literal pool
.ltorg

.L4_pool:
	@ WRITE Instruction
	ldr	r5, =1156
	ldr	r8, [r9, r5]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r5, =144
	mul	r8, r8, r5	@ indexing
	add	r8, r8, #580
	ldr	r7, =576
	ldr	r5, [r9, r7]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r7, =24
	mul	r5, r5, r7	@ indexing
	add	r5, r5, r8
	ldr	r7, =1160
	ldr	r8, [r9, r7]
	cmp	r8, #5	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, r5
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r5, =1156
	ldr	r8, [r9, r5]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r5, =144
	mul	r8, r8, r5	@ indexing
	add	r8, r8, #0
	ldr	r7, =576
	ldr	r5, [r9, r7]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r7, =24
	mul	r5, r5, r7	@ indexing
	add	r5, r5, r8
	ldr	r7, =1160
	ldr	r8, [r9, r7]
	cmp	r8, #5	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, r5
	ldr	r1, [r9, r8]
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
