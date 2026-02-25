.data # Direct that the following is for memory

answer: .asciz "Answer: "

.text # Direct that the following is instructions
.globl main # Direct for entry point

main: 
	# Numbers to be added
	li t0, 10
	li t1, 10
	
	add t2, t0, t1
	
	la a0, answer	# Load answer text into a0
	li a7, 4	# service number for print text syscall
	ecall
	
	mv a0, t2	# move answer in t2 into a0 to be printed
	li a7, 1	# service number To pirnt a number with syscall
	ecall
	
	li a7, 10	# load exit service syscall
	ecall
	