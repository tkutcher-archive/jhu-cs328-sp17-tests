	.text
	.comm	pgmem,312,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r10, [r11, #0]
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r10, r10, r7	@ indexing
	add	r10, r10, #52
	ldr	r7, =3
	str	r7, [r11, r10]

	@ Assignment
	ldr	r10, [r11, #0]
	add	r10, r10, #1
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r7, =4
	mul	r10, r10, r7	@ indexing
	add	r10, r10, #52
	ldr	r7, [r11, r10]
	str	r7, [r11, #4]

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
