	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r5, =num
	ldr	r5, [r5]
	str	r5, [r11, #40]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #40]
	bl	printf

	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r5, =num
	ldr	r5, [r5]
	str	r5, [r11, #36]

	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #36]
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
