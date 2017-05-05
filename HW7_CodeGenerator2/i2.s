	.text
	.comm	pgmem,312,4


	.global	main

main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4

	ldr	r9, .MEM	@ base register

	@ IF Instruction
	@ constant condition, true insts only
	@ WRITE Instruction
	ldr	r1, =16
	ldr	r0, =write
	bl	printf


	@ IF Instruction
	@ constant condition, no insts

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	str	r8, [r9, #44]

	@ IF Instruction
	ldr	r5, =308
	ldr	r8, [r9, r5]
	ldr	r5, [r9, #44]
	cmp	r8, r5
	ldrlt	r8, =1
	ldrge	r8, =0
	cmp	r8, #1
	bne	.L5_skipt
	@ Repeat Instruction
	ldr	r5, =0	@ comparison reg
.L7_start:
	cmp	r5, #0
	bne	.L8_end
	@ WRITE Instruction
	ldr	r8, =308
	ldr	r1, [r9, r8]
	ldr	r0, =write
	bl	printf

	b	.L9_pool	@ literal pool
.ltorg

.L9_pool:
	@ Assignment
	ldr	r10, =308
	ldr	r8, [r9, r10]
	add	r8, r8, #1
	ldr	r10, =308
	str	r8, [r9, r10]

	ldr	r5, =308
	ldr	r8, [r9, r5]
	ldr	r5, [r9, #44]
	cmp	r8, r5
	ldrge	r8, =1
	ldrlt	r8, =0
	mov	r5, r8	@ result
	b	.L7_start
.L8_end:

	b	.L6_skipf
.L5_skipt:
.L6_skipf:

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
