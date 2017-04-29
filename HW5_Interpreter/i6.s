	.text
	.comm	pgmem,0,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ IF Instruction
	@ constant condition, true insts only
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =1
	bl	printf


	@ IF Instruction
	@ constant condition, false insts only
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =1
	bl	printf


	@ IF Instruction
	@ constant condition, true insts only
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =1
	bl	printf

	b	.L7_pool	@ literal pool
.ltorg

.L7_pool:

	@ IF Instruction
	@ constant condition, true insts only
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, =1
	bl	printf


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
