	.text
	.comm	pgmem,216,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r8, =6
	str	r8, [r11, #136]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #136]
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r8, =num
	ldr	r8, [r8]
	str	r8, [r11, #208]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #208]
	bl	printf

	@ Assignment
	ldr	r8, [r11, #208]
	str	r8, [r11, #212]

	b	.L1_pool	@ literal pool
.ltorg

.L1_pool:
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #212]
	bl	printf

	@ Assignment
	ldr	r8, =66
	str	r8, [r11, #212]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #212]
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
