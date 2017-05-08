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
	ldr	r5, =num
	ldr	r5, [r5]
	str	r5, [r9, #8]

	@ IF Instruction
	ldr	r5, [r9, #8]
	cmp	r5, #0
	bgt	.L1_skipt
	@ IF Instruction
	ldr	r5, [r9, #8]
	cmp	r5, #0
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
	ldr	r5, =1
	str	r5, [r9, #0]

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Repeat Instruction
.L6_start:
	@ Assignment
	ldr	r5, [r9, #0]
	str	r5, [r9, #12]

	@ Assignment
	ldr	r5, [r9, #8]
	ldr	r4, [r9, #12]
	mov	r0, r5
	mov	r1, r4
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r5, r0
	ldr	r4, [r9, #12]
	add	r4, r4, r5
	ldr	r1, =2
	mov	r0, r4
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r4, r0
	str	r4, [r9, #0]

	@ Assignment
	ldr	r5, [r9, #0]
	ldr	r4, [r9, #12]
	sub	r5, r5, r4
	str	r5, [r9, #4]

	@ IF Instruction
	ldr	r5, [r9, #4]
	cmp	r5, #1
	bne	.L8_skipt
	@ IF Instruction
	ldr	r5, [r9, #8]
	cmp	r5, #4
	ble	.L10_skipt
	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #4]

	@ Assignment
	ldr	r5, [r9, #12]
	str	r5, [r9, #0]

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	b	.L11_skipf
.L10_skipt:
	@ IF Instruction
	ldr	r5, [r9, #8]
	cmp	r5, #3
	bne	.L13_skipt
	@ Assignment
	ldr	r5, =0
	str	r5, [r9, #4]

	@ Assignment
	ldr	r5, =1
	str	r5, [r9, #0]

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
	ldr	r5, [r9, #4]
	cmp	r5, #0
	beq	.L7_end	@ comparison
	b	.L6_start	@ repeat
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
