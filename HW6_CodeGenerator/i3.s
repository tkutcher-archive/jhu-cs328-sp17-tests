	.text
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	ldr	r11, .MEM	@ base register

	@ Assignment
	ldr	r10, =2
	str	r10, [r11, #4]

	@ IF Instruction
	@ constant condition, true insts only
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



	b	.L5_pool	@ literal pool
.ltorg

.L5_pool:
	@ Read
	ldr	r0, =read
	ldr	r1, =num
	bl	scanf
	ldr	r10, =num
	ldr	r10, [r10]
	str	r10, [r11, #12]

	@ IF Instruction
	ldr	r10, [r11, #0]
	ldr	r5, [r11, #12]
	cmp	r10, r5
	ldrlt	r10, =1
	ldrge	r10, =0
	cmp	r10, #1
	bne	.L6_skipt
	@ Repeat Instruction
	ldr	r5, =0	@ comparison reg
.L8_start:
	cmp	r5, #0
	bne	.L9_end
	@ Assignment
	ldr	r10, =10
	str	r10, [r11, #40]

	@ IF Instruction
	ldr	r10, [r11, #40]
	cmp	r10, #0
	ldrgt	r10, =1
	ldrle	r10, =0
	cmp	r10, #1
	bne	.L10_skipt
	@ Repeat Instruction
	ldr	r6, =0	@ comparison reg
.L12_start:
	cmp	r6, #0
	bne	.L13_end
	@ WRITE Instruction
	ldr	r0, =write
	ldr	r1, [r11, #4]
	bl	printf

	@ Assignment
	ldr	r10, [r11, #4]
	ldr	r7, =2
	mul	r10, r10, r7
	str	r10, [r11, #4]

	@ Assignment
	ldr	r10, [r11, #40]
	sub	r10, r10, #1
	str	r10, [r11, #40]

	b	.L14_pool	@ literal pool
.ltorg

.L14_pool:
	ldr	r10, [r11, #40]
	cmp	r10, #0
	ldrle	r10, =1
	ldrgt	r10, =0
	mov	r6, r10	@ result
	b	.L12_start
.L13_end:

	b	.L11_skipf
.L10_skipt:
.L11_skipf:

	@ Assignment
	ldr	r10, [r11, #0]
	add	r10, r10, #1
	str	r10, [r11, #0]

	ldr	r10, [r11, #0]
	ldr	r5, [r11, #12]
	cmp	r10, r5
	ldrge	r10, =1
	ldrlt	r10, =0
	mov	r5, r10	@ result
	b	.L8_start
.L9_end:

	b	.L7_skipf
.L6_skipt:
.L7_skipf:

	b	.L15_pool	@ literal pool
.ltorg

.L15_pool:
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
