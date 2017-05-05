	.text
	.comm	pgmem,44,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ WRITE Instruction
	ldr	r1, [r9, #36]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r10, =18
	str	r10, [r9, #40]

	@ Assignment
	ldr	r10, [r9, #40]
	str	r10, [r9, #32]

	@ WRITE Instruction
	ldr	r10, [r9, #36]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #16
	ldr	r1, [r9, r10]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #40]
	ldr	r0, =write
	bl	printf

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ Assignment
	ldr	r10, [r9, #36]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #16
	ldr	r5, [r9, #32]
	str	r5, [r9, r10]

	@ WRITE Instruction
	ldr	r1, [r9, #32]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r10, [r9, #36]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #16
	ldr	r1, [r9, r10]
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
