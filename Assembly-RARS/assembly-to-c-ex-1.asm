.data

A: .word 1, 5, 3, 4
B: .word 0, 0, 0, 0

.text
.globl main

main:
	la x10, A		# Load address of the first element of A to x10
	la x11, B		# Load address of the first element of B to x11
	li x5, 0		# Register holds the value of 'f'
	li x6, 2		# Register holds the value of 'g'

	# Logic from question 1 of classwork 3
	slli x30, x5, 2		# x30 = f * 4
	add x30, x10, x30	# x30 = &A[f]
	slli x31, x6, 2		# x31 = g * 4
	add x31, x11, x31	# x31 = &B[g]
	lw x5, 0(x30)		# f = A[f]	
	addi x12, x30, 4	# x12 = &A[f+1]
	lw x30, 0(x12)		# x30 = A[f+1]
	add x30, x30, x5	# x30 = A[f+1] + A[f]
	sw x30, 0(x31)		# B[g] = A[f+1] + A[f]
	# End of logic from classwork 3
	
	# Print result
	mv a0, x30
	li a7, 1
	ecall
	
	# Exit
	li a7, 10
	ecall