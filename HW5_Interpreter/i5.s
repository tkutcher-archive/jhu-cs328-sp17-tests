	.text
	.comm	pgmem,32,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r8, =3
	str	r8, [r11, #8]

	@ Assignment
	ldr	r8, =1
	str	r8, [r11, #12]

	@ Assignment
	ldr	r8, =4
	str	r8, [r11, #16]

	@ Assignment
	ldr	r8, =2
	str	r8, [r11, #20]

	@ IF Instruction
	ldr	r8, [r11, #28]
	cmp	r8, #3
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L1_skipt
	@ Repeat Instruction
	ldr	r6, =0	@ comparison reg
.L3_start:
	cmp	r6, #0
	bne	.L4_end
	@ Assignment
	ldr	r8, [r11, #28]
	str	r8, [r11, #4]

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r8, [r11, #28]
	add	r8, r8, #1
	str	r8, [r11, #0]

	@ IF Instruction
	ldr	r8, [r11, #0]
	cmp	r8, #4
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L6_skipt
	@ Repeat Instruction
	ldr	r7, =0	@ comparison reg
.L8_start:
	cmp	r7, #0
	bne	.L9_end
	@ IF Instruction
	ldr	r8, [r11, #0]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r8, r8, r10	@ indexing
	add	r8, r8, #8
	ldr	r10, [r11, #4]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r9, =4
	mul	r10, r10, r9	@ indexing
	add	r10, r10, #8
	ldr	r9, [r11, r8]
	ldr	r8, [r11, r10]
	cmp	r9, r8
	ldrlt	r9, =1
	ldrge	r9, =0
	cmp	r9, #1
	bne	.L10_skipt
	@ Assignment
	ldr	r8, [r11, #0]
	str	r8, [r11, #4]

	b	.L11_skipf
.L10_skipt:
.L11_skipf:

	@ Assignment
	ldr	r8, [r11, #0]
	add	r8, r8, #1
	str	r8, [r11, #0]

	ldr	r8, [r11, #0]
	cmp	r8, #4
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r7, r8	@ result
	b	.L8_start
.L9_end:

	b	.L12_pool	@ literal pool
.ltorg

.L12_pool:
	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	@ IF Instruction
	ldr	r8, [r11, #4]
	ldr	r7, [r11, #28]
	cmp	r8, r7
	ldrne	r8, =1
	ldreq	r8, =0
	cmp	r8, #1
	bne	.L13_skipt
	@ Assignment
	ldr	r8, [r11, #28]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, #8
	ldr	r7, [r11, r8]
	str	r7, [r11, #24]

	@ Assignment
	ldr	r8, [r11, #4]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, #8
	ldr	r7, [r11, #28]
	cmp	r7, #3	@ bounds checking
	bhi	err
	ldr	r10, =4
	mul	r7, r7, r10	@ indexing
	add	r7, r7, #8
	ldr	r10, [r11, r8]
	str	r10, [r11, r7]

	@ Assignment
	ldr	r8, [r11, #4]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, #8
	ldr	r7, [r11, #24]
	str	r7, [r11, r8]

	b	.L14_skipf
.L13_skipt:
.L14_skipf:

	b	.L15_pool	@ literal pool
.ltorg

.L15_pool:
	@ Assignment
	ldr	r8, [r11, #28]
	add	r8, r8, #1
	str	r8, [r11, #28]

	ldr	r8, [r11, #28]
	cmp	r8, #3
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r6, r8	@ result
	b	.L3_start
.L4_end:

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	@ Assignment
	ldr	r8, =0
	str	r8, [r11, #0]

	@ IF Instruction
	ldr	r8, [r11, #0]
	cmp	r8, #4
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L16_skipt
	@ Repeat Instruction
	ldr	r6, =0	@ comparison reg
.L18_start:
	cmp	r6, #0
	bne	.L19_end
	@ WRITE Instruction
	ldr	r8, [r11, #0]
	cmp	r8, #3	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r8, r8, r7	@ indexing
	add	r8, r8, #8
	ldr	r0, =write
	ldr	r1, [r11, r8]
	bl	printf

	b	.L20_pool	@ literal pool
.ltorg

.L20_pool:
	@ Assignment
	ldr	r8, [r11, #0]
	add	r8, r8, #1
	str	r8, [r11, #0]

	ldr	r8, [r11, #0]
	cmp	r8, #4
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r6, r8	@ result
	b	.L18_start
.L19_end:

	b	.L17_skipf
.L16_skipt:
.L17_skipf:

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
