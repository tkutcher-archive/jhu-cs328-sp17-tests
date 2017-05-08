	.text
	.comm	pgmem,44,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ WRITE Instruction
	ldr	r1, [r9, #16]
	ldr	r0, =write
	bl	printf

	@ Assignment
	ldr	r7, =18
	str	r7, [r9, #40]

	@ Assignment
	ldr	r7, [r9, #40]
	str	r7, [r9, #36]

	@ WRITE Instruction
	ldr	r7, [r9, #16]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r7, r7, r6	@ indexing
	add	r7, r7, #20
	ldr	r1, [r9, r7]
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
	ldr	r7, [r9, #16]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r7, r7, r6	@ indexing
	add	r7, r7, #20
	ldr	r6, [r9, #36]
	str	r6, [r9, r7]

	@ WRITE Instruction
	ldr	r1, [r9, #36]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r7, [r9, #16]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r7, r7, r6	@ indexing
	add	r7, r7, #20
	ldr	r1, [r9, r7]
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
