# A program used to find the max number in an array

.data

arr: .word 12, 45, 23, 67, 34, 89, 21
len: .word 7

.text
main:
	la t0, arr	# Load address for array into t0
	lw t1, len	# Load word value of length into t1
	lw t2, 0(t0)	# Start value of the array (0 offset)
	
	# Next step allows us to avoid comparing the first element to itself
	addi t0, t0, 4	# Since a word is 4 bytes, add 4 to t0 to "move to the next index"
	
	# Next step allows us to use branch if equal in the first line of the loop function.
	addi t3, x0, 1	# Index (equivalent to: t3 = 0 + 1)
	
loop:
	beq t3, t1, done # end condition; (t3 = index and t1 = length) 
	
	lw t4, 0(t0)	# load the next value
	ble t4, t2, skip	# compare; branch to skip if t4 <= t2
	mv t2, t4	# Move current value(t4) to temporary max(t2)
	
skip:
	addi t0, t0, 4 # Since a word is 4 bytes, add 4 to index to the next value in array
	addi t3, t3, 1 # Increment the index by 1
	j loop	# jump back to the loop function
	
done:
	mv a0, t2	# move temporary max to a0 for the print syscall
	li a7, 1	# syscall service number for printing a number
	ecall
	
	li a7, 10	# syscall service for exit
	ecall
