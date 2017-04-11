	.text
.Ltext0:
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =0
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =9
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =9
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =4
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =13
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =47
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	sub 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =46
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =2
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =1
	push	{r2}
	ldr 	r2, =11
	push	{r2}
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	ldr 	r2, [r2]
	mul 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	add 	r2, r2, r3
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =23
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =0
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =5
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ Assignment
	ldr 	r2, .MEM
	ldr 	r3, =4
	add 	r2, r2, r3
	push	{r2}
	ldr 	r2, =27
	push	{r2}
	pop 	{r2, r3}
	str 	r2, [r3]

	@ WRITE Instruction
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
	ldr 	r3, [r3]
	mov 	r0, r2
	mov 	r1, r3
	bl  	__aeabi_idiv
	mov 	r2, r0
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =5
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
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
	ldr 	r3, [r3]
	mov 	r0, r2
	mov 	r1, r3
	bl  	__aeabi_idivmod
	mov 	r2, r1
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	@ WRITE Instruction
	ldr 	r2, =2
	push	{r2}
	pop 	{r1}
	ldr 	r0, =write
	bl  	printf

	pop 	{fp, pc}


.MEM:
	.word	pgmem

	.data
write:
	.asciz	"%d\n"
	.end
