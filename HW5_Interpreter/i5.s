	.text
	.comm	pgmem,32,4
	.global	main

main:
	push	{fp, lr}


	@ Assignment
	ldr 	r2, =0
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =4
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	bllt	true
	blge	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L1_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L3_start:
	cmp 	r2, #0
	bne 	.L4_end

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	bllt	true
	blge	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L5_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L7_start:
	cmp 	r2, #0
	bne 	.L8_end

	@ IF Instruction
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	ldr 	r3, [r3]
	cmp 	r2, r3
	bllt	true
	blge	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L9_skipt

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]
	b   	.L10_skipf
.L9_skipt:
.L10_skipf:

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blge	true
	bllt	false
	push	{r0}
	pop 	{r2}
	b   	.L7_start
.L8_end:
	b   	.L6_skipf
.L5_skipt:
.L6_skipf:

	@ IF Instruction
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	ldr 	r3, [r3]
	cmp 	r2, r3
	blne	true
	bleq	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L11_skipt

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =28
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =28
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	str 	r2, [r3]
	b   	.L12_skipf
.L11_skipt:
.L12_skipf:

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =8
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blge	true
	bllt	false
	push	{r0}
	pop 	{r2}
	b   	.L3_start
.L4_end:
	b   	.L2_skipf
.L1_skipt:
.L2_skipf:

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =0
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ IF Instruction
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	bllt	true
	blge	false
	push	{r0}
	pop 	{r2}
	cmp 	r2, #1
	bne 	.L13_skipt

	@ REPEAT Instruction
	ldr 	r2, =0
.L15_start:
	cmp 	r2, #0
	bne 	.L16_end

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =12
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r3, [r3]
	ldr 	r4, =4		@ Bounds checking
	cmp 	r3, r4
	bhi 	err
	beq 	err
	ldr 	r4, =4
	mul 	r3, r3, r4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	cmp 	r2, r3
	blge	true
	bllt	false
	push	{r0}
	pop 	{r2}
	b   	.L15_start
.L16_end:
	b   	.L14_skipf
.L13_skipt:
.L14_skipf:

	pop 	{fp, pc}


true:
	ldr 	r0, =1
	bx  	lr

false:
	ldr 	r0, =0
	bx  	lr

err:
	ldr 	r0, =stderr
	ldr 	r0, [r0]
	ldr 	r1, =emsg
	bl  	fprintf
	ldr 	r0, =1
	bl  	exit

.MEM:
	.word	pgmem

	.data

write:
	.asciz	"%d\n"

read:
	.asciz	"%d"

emsg:
	.asciz	"error: index out of bounds\n"

num:
	.word	0
	.end
