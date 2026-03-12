.data

n: .word 5	# Compute 5!

.text
main:
	lw t0, n	# t0 = n
	li t1, 1	# result = 1
	
loop:
	beqz t0, done	# Branch to done if n(t0) is equal to 0
	mul t1, t1, t0	# Multiply result by n
	addi t0, t0, -1	# Decrement the n value
	j loop # Recurse back to loop function

done:
	mv a0, t1
	li a7, 1
	ecall
	
	li a7, 10
	ecall