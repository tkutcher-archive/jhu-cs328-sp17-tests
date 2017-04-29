	.text
	.comm	pgmem,216,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r7, =60
	str	r7, [r11, #136]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #136]
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r7, =num
	ldr	r7, [r7]
	str	r7, [r11, #212]

	@ Assignment
	ldr	r7, [r11, #136]
	str	r7, [r11, #168]

	@ Assignment
	ldr	r7, [r11, #212]
	ldr	r6, [r11, #168]
	sub	r7, r7, r6
	str	r7, [r11, #124]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #124]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #44]
	bl	printf

	@ Assignment
	ldr	r7, =168	@ from
	ldr	r6, =0	@ to
	add	r3, r7, #48	@ stop
.L2_cpy_s:
	cmp	r7, r3
	beq	.L3_cpy_f
	ldr	r9, [r11, r7]
	str	r9, [r11, r6]
	add	r7, r7, #4	@ ++from
	add	r6, r6, #4	@ ++to
	b	.L2_cpy_s
.L3_cpy_f:

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #44]
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
