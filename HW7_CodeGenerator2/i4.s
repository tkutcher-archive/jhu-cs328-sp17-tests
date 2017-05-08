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
	ldr	r6, =996
	ldr	r1, [r9, r6]
	ldr	r0, =write
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	ldr	r4, =1160
	str	r6, [r9, r4]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	ldr	r4, =580
	str	r6, [r9, r4]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	str	r6, [r9, #0]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	ldr	r7, =1160
	ldr	r4, [r9, r7]
	cmp	r4, #3	@ bounds checking
	bhi	err
	ldr	r7, =144
	mul	r4, r4, r7	@ indexing
	add	r4, r4, #584
	ldr	r10, =580
	ldr	r7, [r9, r10]
	cmp	r7, #5	@ bounds checking
	bhi	err
	ldr	r10, =24
	mul	r7, r7, r10	@ indexing
	add	r7, r7, r4
	ldr	r4, [r9, #0]
	cmp	r4, #5	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r4, r4, r10	@ indexing
	add	r4, r4, r7
	str	r6, [r9, r4]

	@ WRITE Instruction
	ldr	r6, =996
	ldr	r1, [r9, r6]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r6, =584	@ from
	ldr	r4, =4	@ to
	ldr	r3, =576
	add	r3, r6, r3	@ stop
.L2_cpy_s:
	cmp	r6, r3
	beq	.L3_cpy_f
	ldr	r7, [r9, r6]
	str	r7, [r9, r4]
	add	r6, r6, #4	@ ++from
	add	r4, r4, #4	@ ++to
	b	.L2_cpy_s
.L3_cpy_f:

	b	.L4_pool	@ literal pool
.ltorg

.L4_pool:
	@ WRITE Instruction
	ldr	r4, =1160
	ldr	r6, [r9, r4]
	cmp	r6, #3	@ bounds checking
	bhi	err
	ldr	r4, =144
	mul	r6, r6, r4	@ indexing
	add	r6, r6, #4
	ldr	r7, =580
	ldr	r4, [r9, r7]
	cmp	r4, #5	@ bounds checking
	bhi	err
	ldr	r7, =24
	mul	r4, r4, r7	@ indexing
	add	r4, r4, r6
	ldr	r6, [r9, #0]
	cmp	r6, #5	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, r4
	ldr	r1, [r9, r6]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r4, =1160
	ldr	r6, [r9, r4]
	cmp	r6, #3	@ bounds checking
	bhi	err
	ldr	r4, =144
	mul	r6, r6, r4	@ indexing
	add	r6, r6, #584
	ldr	r7, =580
	ldr	r4, [r9, r7]
	cmp	r4, #5	@ bounds checking
	bhi	err
	ldr	r7, =24
	mul	r4, r4, r7	@ indexing
	add	r4, r4, r6
	ldr	r6, [r9, #0]
	cmp	r6, #5	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r6, r6, r7	@ indexing
	add	r6, r6, r4
	ldr	r1, [r9, r6]
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
