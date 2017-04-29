	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r8, =2
	str	r8, [r11, #20]

	@ IF Instruction
	ldr	r8, [r11, #20]
	ldr	r10, =2048
	cmp	r8, r10
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L1_skipt
	@ Repeat Instruction
	ldr	r10, =0	@ comparison reg
.L3_start:
	cmp	r10, #0
	bne	.L4_end
	@ Assignment
	ldr	r8, [r11, #20]
	ldr	r9, =2
	mul	r8, r8, r9
	str	r8, [r11, #20]

	ldr	r8, [r11, #20]
	ldr	r10, =2048
	cmp	r8, r10
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r10, r8	@ result
	b	.L3_start
.L4_end:

	b	.L2_skipf
.L1_skipt:
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
