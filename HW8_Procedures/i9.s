	.text
	.comm	pgmem,80,4

	.align	2
swapRecord:
	stmfd	sp!, {fp, lr}	@ caller
	add	fp, sp, #4
	sub	sp, sp, #16	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	@ begin procedure instructions
	@ Assignment
	ldr	r7, [fp, #-12]
	ldr	r10, [fp, #-8]
	add	r3, r7, #28	@ stop
.L1_cpy_s:
	cmp	r7, r3
	beq	.L2_cpy_f
	ldr	r4, [r9, r7]
	str	r4, [r9, r10]
	add	r7, r7, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L1_cpy_s
.L2_cpy_f:

	@ Assignment
	ldr	r7, [fp, #-16]
	ldr	r10, [fp, #-12]
	add	r10, r10, #8
	add	r3, r7, #20	@ stop
.L3_cpy_s:
	cmp	r7, r3
	beq	.L4_cpy_f
	ldr	r4, [r9, r7]
	str	r4, [r9, r10]
	add	r7, r7, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L3_cpy_s
.L4_cpy_f:

	@ Assignment
	ldr	r7, =3
	str	r7, [r9, #56]

	@ WRITE Instruction
	ldr	r7, [fp, #-16]
	ldr	r10, [r9, #56]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, r7
	ldr	r1, [r9, r10]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r7, [fp, #-12]
	add	r7, r7, #4
	ldr	r1, [r9, r7]
	ldr	r0, =write
	bl	printf

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ WRITE Instruction
	ldr	r7, [fp, #-12]
	add	r7, r7, #8
	ldr	r10, [r9, #56]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, r7
	ldr	r1, [r9, r10]
	ldr	r0, =write
	bl	printf

	@ begin return expression
	ldr	r7, [fp, #-12]
	add	r7, r7, #8
	ldr	r10, [r9, #56]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, r7
	ldr	r0, [r9, r10]
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}	@ return


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r7, =47
	str	r7, [r9, #4]

	@ Assignment
	ldr	r7, =13
	str	r7, [r9, #0]

	@ Assignment
	ldr	r7, =23
	str	r7, [r9, #8]

	@ Assignment
	ldr	r7, =23
	str	r7, [r9, #12]

	b	.L6_pool	@ literal pool
.ltorg

.L6_pool:
	@ Assignment
	ldr	r7, =99
	str	r7, [r9, #32]

	@ Assignment
	ldr	r7, =157
	str	r7, [r9, #28]

	@ Assignment
	ldr	r7, =999
	str	r7, [r9, #36]

	@ Assignment
	ldr	r7, =998
	str	r7, [r9, #40]

	@ Assignment
	ldr	r7, =997
	str	r7, [r9, #44]

	b	.L7_pool	@ literal pool
.ltorg

.L7_pool:
	@ Assignment
	ldr	r7, =996
	str	r7, [r9, #48]

	@ Assignment
	ldr	r7, =995
	str	r7, [r9, #52]

	@ Assignment
	ldr	r7, =-12
	str	r7, [r9, #60]

	@ Assignment
	ldr	r7, =-13
	str	r7, [r9, #64]

	@ Assignment
	ldr	r7, =-14
	str	r7, [r9, #68]

	b	.L8_pool	@ literal pool
.ltorg

.L8_pool:
	@ Assignment
	ldr	r7, =-15
	str	r7, [r9, #72]

	@ Assignment
	ldr	r7, =-16
	str	r7, [r9, #76]

	@ WRITE Instruction
	ldr	r0, =60	@ load address
	push	{r0}
	ldr	r0, =28	@ load address
	push	{r0}
	ldr	r0, =0	@ load address
	push	{r0}
	pop	{r0, r1, r2}
	bl	swapRecord
	mov	r1, r0
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-15
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #4]
	ldr	r0, =write
	bl	printf

	b	.L9_pool	@ literal pool
.ltorg

.L9_pool:
	@ WRITE Instruction
	ldr	r1, =99
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #0]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =157
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #32]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =99
	ldr	r0, =write
	bl	printf

	b	.L10_pool	@ literal pool
.ltorg

.L10_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #28]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =157
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #8]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =999
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #12]
	ldr	r0, =write
	bl	printf

	b	.L11_pool	@ literal pool
.ltorg

.L11_pool:
	@ WRITE Instruction
	ldr	r1, =998
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #16]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =997
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #20]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =996
	ldr	r0, =write
	bl	printf

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #24]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =995
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #36]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-12
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #40]
	ldr	r0, =write
	bl	printf

	b	.L13_pool	@ literal pool
.ltorg

.L13_pool:
	@ WRITE Instruction
	ldr	r1, =-13
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #44]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-14
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #48]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-15
	ldr	r0, =write
	bl	printf

	b	.L14_pool	@ literal pool
.ltorg

.L14_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #52]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-16
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
