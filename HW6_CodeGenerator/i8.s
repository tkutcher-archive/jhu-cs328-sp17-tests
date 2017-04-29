	.text
	.comm	pgmem,60,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r9, =num
	ldr	r9, [r9]
	str	r9, [r11, #24]

	@ WRITE Instruction
	ldr	r9, [r11, #24]
	cmp	r9, #5	@ bounds checking
	bhi	err
	ldr	r8, =4
	mul	r9, r9, r8	@ indexing
	add	r9, r9, #36
	ldr	r0, =write
	ldr	r1, [r11, r9]
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
