	.text
	.comm	pgmem,4,4

	.align	2
getval:
	str	fp, [sp, #-4]!	@ leaf function
	add	fp, sp, #0
	sub	sp, sp, #12	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	@ Initialize stack frame for locals
	mov	r5, #0
	str	r5, [fp, #-8]
	str	r5, [fp, #-12]
	@ begin procedure instructions
	@ Assignment
	ldr	r5, =2
	str	r5, [r9, #0]

	@ Assignment
	ldr	r5, =1
	str	r5, [fp, #-12]

	@ begin return expression
	ldr	r0, =47
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr	@ return to caller


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	bl	getval
	str	r0, [r9, #0]

	@ WRITE Instruction
	ldr	r1, [r9, #0]
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
