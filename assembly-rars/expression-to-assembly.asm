# This is assembly code to see how few registers can be used to solve:
# (a - b) + [e - (c + d)]
.data
	A: .word 1
	B: .word 1
	C: .word 1
	D: .word 1
	E: .word 1
	
.text
.globl main

main:
	# Perform (c + d) and store in t2
	lw t0, C
	lw t1, D
	add t2, t0, t1
	
	# Perform [e - (c + d)] and store in t2
	lw t0, E
	sub t2, t0, t2
	
	# Perform (a - b) and store in t0
	lw t0, A
	lw t1, B
	sub t0, t0, t1
	
	# Perform [(a-b) + (e - (c + d))] and store in t0
	add t2, t0, t2
	
	mv a0, t2
	li a7, 1
	ecall
	
	li a7, 10
	ecall
	