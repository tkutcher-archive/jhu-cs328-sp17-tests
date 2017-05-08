	.text
	.comm	pgmem,80,4

	.align	2
swapRecord:
	str	fp, [sp, #-4]!	@ leaf function
	add	fp, sp, #0
	sub	sp, sp, #16	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	@ begin procedure instructions
	@ Assignment
	ldr	r6, [fp, #-12]
	ldr	r8, [fp, #-8]
	add	r3, r6, #28	@ stop
.L1_cpy_s:
	cmp	r6, r3
	beq	.L2_cpy_f
	ldr	r7, [r9, r6]
	str	r7, [r9, r8]
	add	r6, r6, #4	@ ++from
	add	r8, r8, #4	@ ++to
	b	.L1_cpy_s
.L2_cpy_f:

	@ Assignment
	ldr	r6, [fp, #-16]
	ldr	r8, [fp, #-12]
	add	r8, r8, #4
	add	r3, r6, #20	@ stop
.L3_cpy_s:
	cmp	r6, r3
	beq	.L4_cpy_f
	ldr	r7, [r9, r6]
	str	r7, [r9, r8]
	add	r6, r6, #4	@ ++from
	add	r8, r8, #4	@ ++to
	b	.L3_cpy_s
.L4_cpy_f:

	@ begin return expression
	ldr	r6, [fp, #-12]
	add	r6, r6, #4
	add	r6, r6, #12
	ldr	r0, [r9, r6]
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr	@ return to caller


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r6, =47
	str	r6, [r9, #52]

	@ Assignment
	ldr	r6, =13
	str	r6, [r9, #76]

	@ Assignment
	ldr	r6, =23
	str	r6, [r9, #56]

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r6, =23
	str	r6, [r9, #60]

	@ Assignment
	ldr	r6, =99
	str	r6, [r9, #24]

	@ Assignment
	ldr	r6, =157
	str	r6, [r9, #48]

	@ Assignment
	ldr	r6, =999
	str	r6, [r9, #28]

	@ Assignment
	ldr	r6, =998
	str	r6, [r9, #32]

	b	.L6_pool	@ literal pool
.ltorg

.L6_pool:
	@ Assignment
	ldr	r6, =997
	str	r6, [r9, #36]

	@ Assignment
	ldr	r6, =996
	str	r6, [r9, #40]

	@ Assignment
	ldr	r6, =995
	str	r6, [r9, #44]

	@ Assignment
	ldr	r6, =-12
	str	r6, [r9, #0]

	@ Assignment
	ldr	r6, =-13
	str	r6, [r9, #4]

	b	.L7_pool	@ literal pool
.ltorg

.L7_pool:
	@ Assignment
	ldr	r6, =-14
	str	r6, [r9, #8]

	@ Assignment
	ldr	r6, =-15
	str	r6, [r9, #12]

	@ Assignment
	ldr	r6, =-16
	str	r6, [r9, #16]

	@ WRITE Instruction
	ldr	r0, =0	@ load address
	push	{r0}
	ldr	r0, =24	@ load address
	push	{r0}
	ldr	r0, =52	@ load address
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

	b	.L8_pool	@ literal pool
.ltorg

.L8_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #52]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =99
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #76]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =157
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #24]
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
	ldr	r1, [r9, #48]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =157
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #56]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =999
	ldr	r0, =write
	bl	printf

	b	.L10_pool	@ literal pool
.ltorg

.L10_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #60]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =998
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #64]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =997
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #68]
	ldr	r0, =write
	bl	printf

	b	.L11_pool	@ literal pool
.ltorg

.L11_pool:
	@ WRITE Instruction
	ldr	r1, =996
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #72]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =995
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #28]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-12
	ldr	r0, =write
	bl	printf

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	@ WRITE Instruction
	ldr	r1, [r9, #32]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-13
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #36]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =-14
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
	ldr	r1, =-15
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, [r9, #44]
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
