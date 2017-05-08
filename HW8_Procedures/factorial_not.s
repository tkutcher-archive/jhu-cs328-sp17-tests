	.text
	.comm	pgmem,0,4

	.align	2
fact:
	stmfd	sp!, {fp, lr}	@ caller
	add	fp, sp, #4
	sub	sp, sp, #8	@ local vars and r0-r3
	stmfd	sp!, {r4-r8, r10}	@ save var registers
	str	r0, [fp, #-8]
	@ Initialize stack frame for locals
	mov	r5, #0
	str	r5, [fp, #-4]
	@ begin procedure instructions
	@ IF Instruction
	ldr	r5, [fp, #-8]
	cmp	r5, #0
	bne	.L1_skipt
	@ Assignment
	ldr	r5, =1
	str	r5, [fp, #-4]

	b	.L2_skipf
.L1_skipt:
	@ Assignment
	ldr	r5, [fp, #-8]
	sub	r5, r5, #1
	push	{r5}
	pop	{r0}
	bl	fact
	ldr	r5, [fp, #-8]
	mul	r5, r5, r0
	str	r5, [fp, #-4]

.L2_skipf:

	@ begin return expression
	ldr	r0, [fp, #-4]
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
	pop	{r0}
	bl	fact
	mov	r1, r0
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r0, =4
	push	{r0}
	pop	{r0}
	bl	fact
	mov	r1, r0
	ldr	r0, =write
	bl	printf

	b	.L3_pool	@ literal pool
.ltorg

.L3_pool:
	@ WRITE Instruction
	ldr	r0, =2
	push	{r0}
	pop	{r0}
	bl	fact
	mov	r1, r0
	ldr	r0, =write
	bl	printf

	@ WRITE Instruction
	ldr	r0, =0
	push	{r0}
	pop	{r0}
	bl	fact
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
