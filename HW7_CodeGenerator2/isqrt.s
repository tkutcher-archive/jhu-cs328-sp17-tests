	.text
	.comm	pgmem,16,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r6, =num
	ldr	r6, [r6]
	str	r6, [r11, #12]

	@ IF Instruction
	ldr	r6, [r11, #12]
	cmp	r6, #0
	ldrle	r6, =1
	ldrgt	r6, =0
	cmp	r6, #1
	bne	.L1_skipt
	@ IF Instruction
	ldr	r6, [r11, #12]
	cmp	r6, #0
	ldreq	r6, =1
	ldrne	r6, =0
	cmp	r6, #1
	bne	.L3_skipt
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =0
	bl	printf

	b	.L4_skipf
.L3_skipt:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =-1
	bl	printf

.L4_skipf:

	b	.L2_skipf
.L1_skipt:
	@ Assignment
	ldr	r6, =1
	str	r6, [r11, #4]

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Repeat Instruction
	ldr	r5, =0	@ comparison reg
.L6_start:
	cmp	r5, #0
	bne	.L7_end
	@ Assignment
	ldr	r6, [r11, #4]
	str	r6, [r11, #0]

	@ Assignment
	ldr	r6, [r11, #12]
	ldr	r8, [r11, #0]
	mov	r0, r6
	mov	r1, r8
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r6, r0
	ldr	r8, [r11, #0]
	add	r8, r8, r6
	ldr	r1, =2
	mov	r0, r8
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r8, r0
	str	r8, [r11, #4]

	@ Assignment
	ldr	r6, [r11, #4]
	ldr	r8, [r11, #0]
	sub	r6, r6, r8
	str	r6, [r11, #8]

	@ IF Instruction
	ldr	r6, [r11, #8]
	cmp	r6, #1
	ldreq	r6, =1
	ldrne	r6, =0
	cmp	r6, #1
	bne	.L8_skipt
	@ IF Instruction
	ldr	r6, [r11, #12]
	cmp	r6, #4
	ldrgt	r6, =1
	ldrle	r6, =0
	cmp	r6, #1
	bne	.L10_skipt
	@ Assignment
	ldr	r6, =0
	str	r6, [r11, #8]

	@ Assignment
	ldr	r6, [r11, #0]
	str	r6, [r11, #4]

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	b	.L11_skipf
.L10_skipt:
	@ IF Instruction
	ldr	r6, [r11, #12]
	cmp	r6, #3
	ldreq	r6, =1
	ldrne	r6, =0
	cmp	r6, #1
	bne	.L13_skipt
	@ Assignment
	ldr	r6, =0
	str	r6, [r11, #8]

	@ Assignment
	ldr	r6, =1
	str	r6, [r11, #4]

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
	ldr	r6, [r11, #8]
	cmp	r6, #0
	ldreq	r6, =1
	ldrne	r6, =0
	mov	r5, r6	@ result
	b	.L6_start
.L7_end:

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #4]
	bl	printf

.L2_skipf:

	ldr	r0, =0
	pop	{fp, pc}	@ end main

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
