	.text
.Ltext0:
	.comm	pgmem,44,4
	.global	main

main:
	push	{fp, lr}

	@ WRITE Instruction
	ldr 	r2, .MEM
	ldr 	r3, =36
	add 	r2, r2, r3
	push	{r2}
	pop 	{r1}
	ldr 	r1, [r1]
	ldr 	r0, =write
	bl  	printf

	pop 	{fp, pc}


.MEM:
	.word	pgmem

	.data
write:
	.asciz	"%d\n"
	.end
