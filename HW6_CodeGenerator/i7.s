	.text
	.comm	pgmem,160,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r8, =2
	str	r8, [r11, #56]

	@ Assignment
	ldr	r8, =1
	str	r8, [r11, #0]

	@ Assignment
	ldr	r8, [r11, #56]
	ldr	r10, [r11, #0]
	add	r8, r8, r10
	ldr	r10, [r11, #56]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r6, =20
	mul	r10, r10, r6	@ indexing
	add	r10, r10, #60
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, r10
	ldr	r10, =16
	str	r10, [r11, r8]

	@ WRITE Instruction
	ldr	r8, [r11, #56]
	ldr	r10, [r11, #0]
	add	r8, r8, r10
	ldr	r10, [r11, #56]
	cmp	r10, #4	@ bounds checking
	bhi	err
	ldr	r6, =20
	mul	r10, r10, r6	@ indexing
	add	r10, r10, #60
	cmp	r8, #4	@ bounds checking
	bhi	err
	ldr	r6, =4
	mul	r8, r8, r6	@ indexing
	add	r8, r8, r10
	ldr	r0, =write
	ldr	r1, [r11, r8]
	bl	printf

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #112]
	bl	printf

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
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
