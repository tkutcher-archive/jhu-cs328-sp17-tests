	.text
	.comm	pgmem,312,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r4, =264
	ldr	r10, [r9, r4]
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, #0
	ldr	r4, =3
	str	r4, [r9, r10]

	@ Assignment
	ldr	r4, =264
	ldr	r10, [r9, r4]
	add	r10, r10, #1
	cmp	r10, #9	@ bounds checking
	bhi	err
	ldr	r4, =4
	mul	r10, r10, r4	@ indexing
	add	r10, r10, #0
	ldr	r4, [r9, r10]
	ldr	r10, =260
	str	r4, [r9, r10]

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
