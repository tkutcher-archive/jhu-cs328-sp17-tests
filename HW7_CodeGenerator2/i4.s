	.text
	.comm	pgmem,1164,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =2
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =5
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =1
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r10, =992
	ldr	r1, [r11, r10]
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r10, =num
	ldr	r10, [r10]
	ldr	r5, =1160
	str	r10, [r11, r5]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r10, =num
	ldr	r10, [r10]
	str	r10, [r11, #0]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r10, =num
	ldr	r10, [r10]
	ldr	r5, =1156
	str	r10, [r11, r5]

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r10, =num
	ldr	r10, [r10]
	ldr	r6, =1160
	ldr	r5, [r11, r6]
	cmp	r5, #3	@ bounds checking
	bhi	err
	ldr	r6, =144
	mul	r5, r5, r6	@ indexing
	add	r5, r5, #580
	ldr	r6, [r11, #0]
	cmp	r6, #5	@ bounds checking
	bhi	err
	ldr	r8, =24
	mul	r6, r6, r8	@ indexing
	add	r6, r6, r5
	ldr	r8, =1156
	ldr	r5, [r11, r8]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r8, =4
	mul	r5, r5, r8	@ indexing
	add	r5, r5, r6
	str	r10, [r11, r5]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r10, =992
	ldr	r1, [r11, r10]
	bl	printf

	@ Assignment
	ldr	r10, =580	@ from
	ldr	r5, =4	@ to
	ldrr3, =576	
	add	r3, r10, r3	@ stop
.L2_cpy_s:
	cmp	r10, r3
	beq	.L3_cpy_f
	ldr	r6, [r11, r10]
	str	r6, [r11, r5]
	add	r10, r10, #4	@ ++from
	add	r5, r5, #4	@ ++to
	b	.L2_cpy_s
.L3_cpy_f:

	b	.L4_pool	@ literal pool
.ltorg

.L4_pool:
	@ WRITE Instruction
	ldr	r5, =1160
	ldr	r10, [r11, r5]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r5, =144
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #4
	ldr	r5, [r11, #0]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r6, =24
	mul	r5, r5, r6	@ indexing
	add	r5, r5, r10
	ldr	r6, =1156
	ldr	r10, [r11, r6]
	cmp	r10, #5	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r10, r10, r6	@ indexing
	add	r10, r10, r5
	ldr	r0, =write
	ldr	r1, [r11, r10]
	bl	printf

	@ WRITE Instruction
	ldr	r5, =1160
	ldr	r10, [r11, r5]
	cmp	r10, #3	@ bounds checking
	bhi	err
	ldr	r5, =144
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #580
	ldr	r5, [r11, #0]
	cmp	r5, #5	@ bounds checking
	bhi	err
	ldr	r6, =24
	mul	r5, r5, r6	@ indexing
	add	r5, r5, r10
	ldr	r6, =1156
	ldr	r10, [r11, r6]
	cmp	r10, #5	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r10, r10, r6	@ indexing
	add	r10, r10, r5
	ldr	r0, =write
	ldr	r1, [r11, r10]
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
