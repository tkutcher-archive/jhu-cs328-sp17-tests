	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #40]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =0
	bl	printf

	@ Assignment
	ldr	r7, =9
	str	r7, [r11, #40]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #40]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =9
	bl	printf

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ WRITE Instruction
	ldr	r7, [r11, #40]
	add	r7, r7, #4
	ldr	r0, =write
	mov	r1, r7
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =13
	bl	printf

	@ Assignment
	ldr	r7, =47
	str	r7, [r11, #40]

	@ WRITE Instruction
	ldr	r7, [r11, #40]
	sub	r7, r7, #2
	add	r7, r7, #1
	ldr	r0, =write
	mov	r1, r7
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =46
	bl	printf

	b	.L2_pool	@ literal pool
.ltorg

.L2_pool:
	@ Assignment
	ldr	r7, =2
	str	r7, [r11, #40]

	@ Assignment
	ldr	r7, [r11, #40]
	ldr	r9, =11
	mul	r7, r7, r9
	add	r7, r7, #1
	str	r7, [r11, #0]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #0]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =23
	bl	printf

	@ Assignment
	ldr	r7, =5
	str	r7, [r11, #0]

	b	.L3_pool	@ literal pool
.ltorg

.L3_pool:
	@ Assignment
	ldr	r7, =27
	str	r7, [r11, #40]

	@ WRITE Instruction
	ldr	r7, [r11, #40]
	ldr	r9, [r11, #0]
	mov	r0, r7
	mov	r1, r9
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idiv
	mov	r7, r0
	ldr	r0, =write
	mov	r1, r7
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =5
	bl	printf

	@ WRITE Instruction
	ldr	r7, [r11, #40]
	ldr	r9, [r11, #0]
	mov	r0, r7
	mov	r1, r9
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idivmod
	mov	r7, r1
	ldr	r0, =write
	mov	r1, r7
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =2
	bl	printf

	b	.L4_pool	@ literal pool
.ltorg

.L4_pool:
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
