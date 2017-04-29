	.text
	.comm	pgmem,48,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r5, =3
	str	r5, [r11, #8]

	@ Assignment
	ldr	r5, =8
	str	r5, [r11, #0]

	@ Assignment
	ldr	r5, =7
	str	r5, [r11, #4]

	@ Assignment
	ldr	r5, =0	@ from
	ldr	r9, =24	@ to
	add	r3, r5, #24	@ stop
.L1_cpy_s:
	cmp	r5, r3
	beq	.L2_cpy_f
	ldr	r6, [r11, r5]
	str	r6, [r11, r9]
	add	r5, r5, #4	@ ++from
	add	r9, r9, #4	@ ++to
	b	.L1_cpy_s
.L2_cpy_f:

	@ Assignment
	ldr	r5, =13
	str	r5, [r11, #4]

	b	.L3_pool	@ literal pool
.ltorg

.L3_pool:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #8]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #0]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #28]
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
