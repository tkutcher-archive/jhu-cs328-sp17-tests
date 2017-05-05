	.text
	.comm	pgmem,16,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r7, =num
	ldr	r7, [r7]
	str	r7, [r9, #12]

	@ IF Instruction
	ldr	r7, [r9, #12]
	cmp	r7, #0
	ldrle	r7, =1
	ldrgt	r7, =0
	cmp	r7, #1
	bne	.L1_skipt
	@ IF Instruction
	ldr	r7, [r9, #12]
	cmp	r7, #0
	ldreq	r7, =1
	ldrne	r7, =0
	cmp	r7, #1
	bne	.L3_skipt
	@ WRITE Instruction
	ldr	r1, =0
	ldr	r0, =write
	bl	printf

	b	.L4_skipf
.L3_skipt:
	@ WRITE Instruction
	ldr	r1, =-1
	ldr	r0, =write
	bl	printf

.L4_skipf:

	b	.L2_skipf
.L1_skipt:
	@ Assignment
	ldr	r7, =1
	str	r7, [r9, #0]

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Repeat Instruction
	ldr	r5, =0	@ comparison reg
.L6_start:
	cmp	r5, #0
	bne	.L7_end
	@ Assignment
	ldr	r7, [r9, #0]
	str	r7, [r9, #4]

	@ Assignment
	ldr	r7, [r9, #12]
	ldr	r8, [r9, #4]
	mov	r0, r7
	mov	r1, r8
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r7, r0
	ldr	r8, [r9, #4]
	add	r8, r8, r7
	ldr	r1, =2
	mov	r0, r8
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r8, r0
	str	r8, [r9, #0]

	@ Assignment
	ldr	r7, [r9, #0]
	ldr	r8, [r9, #4]
	sub	r7, r7, r8
	str	r7, [r9, #8]

	@ IF Instruction
	ldr	r7, [r9, #8]
	cmp	r7, #1
	ldreq	r7, =1
	ldrne	r7, =0
	cmp	r7, #1
	bne	.L8_skipt
	@ IF Instruction
	ldr	r7, [r9, #12]
	cmp	r7, #4
	ldrgt	r7, =1
	ldrle	r7, =0
	cmp	r7, #1
	bne	.L10_skipt
	@ Assignment
	ldr	r7, =0
	str	r7, [r9, #8]

	@ Assignment
	ldr	r7, [r9, #4]
	str	r7, [r9, #0]

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	b	.L11_skipf
.L10_skipt:
	@ IF Instruction
	ldr	r7, [r9, #12]
	cmp	r7, #3
	ldreq	r7, =1
	ldrne	r7, =0
	cmp	r7, #1
	bne	.L13_skipt
	@ Assignment
	ldr	r7, =0
	str	r7, [r9, #8]

	@ Assignment
	ldr	r7, =1
	str	r7, [r9, #0]

	b	.L14_skipf
.L13_skipt:
.L14_skipf:

.L11_skipf:

	b	.L9_skipf
.L8_skipt:
.L9_skipf:

	b	.L15_pool	@ literal pool
.ltorg

.L15_pool:
	ldr	r7, [r9, #8]
	cmp	r7, #0
	ldreq	r7, =1
	ldrne	r7, =0
	mov	r5, r7	@ result
	b	.L6_start
.L7_end:

	@ WRITE Instruction
	ldr	r1, [r9, #0]
	ldr	r0, =write
	bl	printf

.L2_skipf:

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
