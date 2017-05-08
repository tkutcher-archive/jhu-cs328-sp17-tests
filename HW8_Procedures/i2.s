	.text
	.comm	pgmem,44,4

	.align	2
blah:
	stmfd	sp!, {fp, lr}	@ caller
	add	fp, sp, #4
	sub	sp, sp, #8	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	@ Initialize stack frame for locals
	mov	r8, #0
	str	r8, [fp, #-8]
	@ begin procedure instructions
	@ Assignment
	ldr	r8, =16
	str	r8, [fp, #-8]

	@ Assignment
	ldr	r8, [fp, #-8]
	ldr	r1, =9
	mov	r0, r8
	cmp	r1, #0
	beq	err	@ division by zero
	bl	__aeabi_idivmod
	mov	r8, r1
	str	r8, [fp, #-8]

	@ begin return expression
	ldr	r8, [fp, #-8]
	ldr	r10, =2
	mul	r8, r8, r10
	mov	r0, r8
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}	@ return


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ Assignment
	bl	blah
	str	r0, [r9, #0]

	@ WRITE Instruction
	ldr	r1, [r9, #0]
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r1, =14
	ldr	r0, =write
	bl	printf

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
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
