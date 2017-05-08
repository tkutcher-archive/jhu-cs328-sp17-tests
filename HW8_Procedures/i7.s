	.text
	.comm	pgmem,4,4

	.align	2
add:
	str	fp, [sp, #-4]!	@ leaf function
	add	fp, sp, #0
	sub	sp, sp, #12	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	@ begin return expression
	ldr	r5, [fp, #-8]
	ldr	r7, [fp, #-12]
	add	r5, r5, r7
	mov	r0, r5
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #0
	ldr	fp, [sp], #4
	bx	lr	@ return to caller

	.align	2
addthree:
	stmfd	sp!, {fp, lr}	@ caller
	add	fp, sp, #4
	sub	sp, sp, #20	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-12]
	str	r1, [fp, #-16]
	str	r2, [fp, #-20]
	@ Initialize stack frame for locals
	mov	r7, #0
	str	r7, [fp, #-8]
	@ begin procedure instructions
	@ Assignment
	ldr	r0, [fp, #-16]
	push	{r0}
	ldr	r0, [fp, #-12]
	push	{r0}
	pop	{r0, r1}
	bl	add
	str	r0, [fp, #-8]

	@ Assignment
	ldr	r7, [fp, #-8]
	ldr	r8, [fp, #-20]
	add	r7, r7, r8
	str	r7, [fp, #-8]

	@ begin return expression
	ldr	r0, [fp, #-8]
	ldmfd	sp!, {r4-r8, r10}	@ restore var registers
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}	@ return


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ WRITE Instruction
	ldr	r0, =6
	push	{r0}
	ldr	r0, =5
	push	{r0}
	ldr	r0, =4
	push	{r0}
	pop	{r0, r1, r2}
	bl	addthree
	mov	r1, r0
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
