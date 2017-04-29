	.text
	.comm	pgmem,40,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r5, =100
	str	r5, [r11, #24]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #24]
	bl	printf

	@ Assignment
	ldr	r5, =20	@ from
	ldr	r9, =0	@ to
	add	r3, r5, #20	@ stop
.L1_cpy_s:
	cmp	r5, r3
	beq	.L2_cpy_f
	ldr	r7, [r11, r5]
	str	r7, [r11, r9]
	add	r5, r5, #4	@ ++from
	add	r9, r9, #4	@ ++to
	b	.L1_cpy_s
.L2_cpy_f:

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #4]
	bl	printf

	@ Assignment
	ldr	r5, =42
	str	r5, [r11, #0]

	b	.L3_pool	@ literal pool
.ltorg

.L3_pool:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #20]
	bl	printf

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
