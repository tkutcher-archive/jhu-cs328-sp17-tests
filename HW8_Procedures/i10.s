	.text
	.comm	pgmem,80,4

	.align	2
blah:
	stmfd	sp!, {fp, lr}	@ caller
	add	fp, sp, #4
	sub	sp, sp, #8	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	@ begin procedure instructions
	@ Assignment
	ldr	r7, =3
	str	r7, [r9, #56]

	@ WRITE Instruction
	ldr	r7, [fp, #-8]
	ldr	r6, [r9, #56]
	cmp	r6, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r6, r6, r4	@ indexing
	add	r6, r6, r7
	ldr	r1, [r9, r6]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r7, [fp, #-8]
	add	r7, r7, #12
	ldr	r1, [r9, r7]
	ldr	r0, =write
	bl	printf

	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}	@ return


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r7, =13
	str	r7, [r9, #60]

	@ Assignment
	ldr	r7, =14
	str	r7, [r9, #64]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ Assignment
	ldr	r7, =14
	str	r7, [r9, #68]

	@ Assignment
	ldr	r7, =14
	str	r7, [r9, #72]

	@ Assignment
	ldr	r7, =14
	str	r7, [r9, #76]

	ldr	r0, =60	@ load address
	push	{r0}
	pop	{r0}
	bl	blah
	@ WRITE Instruction
	ldr	r1, [r9, #72]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =14
	ldr	r0, =write
	bl	printf

	b	.L2_pool	@ literal pool
.ltorg

.L2_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #56]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =3
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
