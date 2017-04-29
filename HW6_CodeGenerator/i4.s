	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r9, =2
	str	r9, [r11, #20]

	@ IF Instruction
	ldr	r9, [r11, #20]
	cmp	r9, #6
	ldrle	r9, =1
	ldrgt	r9, =0
	cmp	r9, #1
	bne	.L1_skipt
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =11
	bl	printf

	b	.L2_skipf
.L1_skipt:
.L2_skipf:

	@ IF Instruction
	ldr	r9, [r11, #20]
	cmp	r9, #2
	ldrne	r9, =1
	ldreq	r9, =0
	cmp	r9, #1
	bne	.L3_skipt
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =13
	bl	printf

	b	.L4_skipf
.L3_skipt:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =54
	bl	printf

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
.L4_skipf:

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
