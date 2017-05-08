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
	ldr	r5, =num
	ldr	r5, [r5]
	str	r5, [r9, #0]

	@ IF Instruction
	ldr	r5, [r9, #4]
	ldr	r4, [r9, #0]
	cmp	r5, r4
	bge	.L5_skipt
	@ Repeat Instruction
.L7_start:
	@ WRITE Instruction
	ldr	r1, [r9, #4]
	ldr	r0, =write
	bl	printf

	b	.L9_pool	@ literal pool
.ltorg

.L9_pool:
	@ Assignment
	ldr	r5, [r9, #4]
	add	r5, r5, #1
	str	r5, [r9, #4]

	ldr	r5, [r9, #4]
	ldr	r4, [r9, #0]
	cmp	r5, r4
	bge	.L8_end	@ comparison
	b	.L7_start	@ repeat
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
