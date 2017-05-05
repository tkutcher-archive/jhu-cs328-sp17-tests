	.text
	.comm	pgmem,312,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r5, =308
	ldr	r10, [r9, r5]
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #268
	ldr	r5, =3
	str	r5, [r9, r10]

	@ Assignment
	ldr	r5, =308
	ldr	r10, [r9, r5]
	add	r10, r10, #1
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r5, =4
	mul	r10, r10, r5	@ indexing
	add	r10, r10, #268
	ldr	r5, [r9, r10]
	str	r5, [r9, #0]

	ldr	r0, =0
	ldmfd	sp!, {fp, pc}	@ end main

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
