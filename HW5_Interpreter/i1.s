	.text
	.comm	pgmem,96,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r8, =84
	str	r8, [r11, #88]

	@ Assignment
	ldr	r8, [r11, #88]
	str	r8, [r11, #72]

	@ Assignment
	ldr	r8, =-3
	str	r8, [r11, #64]

	@ Assignment
	ldr	r8, =68	@ from
	ldr	r10, =60	@ to
	add	r3, r8, #8	@ stop
.L1_cpy_s:
	cmp	r8, r3
	beq	.L2_cpy_f
	ldr	r7, [r11, r8]
	str	r7, [r11, r10]
	add	r8, r8, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L1_cpy_s
.L2_cpy_f:

	@ Assignment
	ldr	r8, =76	@ from
	ldr	r10, =40	@ to
	add	r3, r8, #20	@ stop
.L3_cpy_s:
	cmp	r8, r3
	beq	.L4_cpy_f
	ldr	r7, [r11, r8]
	str	r7, [r11, r10]
	add	r8, r8, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L3_cpy_s
.L4_cpy_f:

	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Assignment
	ldr	r8, =40	@ from
	ldr	r10, =0	@ to
	add	r3, r8, #20	@ stop
.L6_cpy_s:
	cmp	r8, r3
	beq	.L7_cpy_f
	ldr	r7, [r11, r8]
	str	r7, [r11, r10]
	add	r8, r8, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L6_cpy_s
.L7_cpy_f:

	@ Assignment
	ldr	r8, =0	@ from
	ldr	r10, =20	@ to
	add	r3, r8, #20	@ stop
.L8_cpy_s:
	cmp	r8, r3
	beq	.L9_cpy_f
	ldr	r7, [r11, r8]
	str	r7, [r11, r10]
	add	r8, r8, #4	@ ++from
	add	r10, r10, #4	@ ++to
	b	.L8_cpy_s
.L9_cpy_f:

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #4]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #12]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #32]
	bl	printf

	b	.L10_pool	@ literal pool
.ltorg

.L10_pool:
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
