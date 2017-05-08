	.text
	.comm	pgmem,44,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	ldr	r6, =4
	str	r6, [r9, #40]

	@ WRITE Instruction
	ldr	r0, =6
	ldr	r6, [r9, #40]
	mov	r1, r6
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idivmod
	mov	r6, r1
	mov	r1, r6
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =2
	ldr	r0, =write
	bl	printf

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
