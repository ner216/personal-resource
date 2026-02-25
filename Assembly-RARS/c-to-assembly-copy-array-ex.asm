.data
# Reserve space for an array of 200 elements
A: .space 800	# (200 integers) * (4 bytes) = 800

B: .word 10,20,30,40,50,60,70,80
.space 768 # remaining space for the rest of the 200 elements.

.text
.globl main

main: 
	la t1, A	# Load address of A into t1
	la t2, B
	li t0, 0
	li t3, 200
	
loop:
	bge t0, t3, done
	
	slli t4, t0, 2
	
	add t5, t2, t4
	lw t6, 0(t5)
	
	add t5, t1, t4
	sw t6, 0(t5)
	
	addi t0, t0, 1
	j loop
	
done:
	li a7, 10
	ecall