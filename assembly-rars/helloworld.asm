.data # Directive to show that the following is for memory

helloworld: .asciz "Hello World!\n"

.text # Directive that the following is instructions
.globl main # Directive for the entry point function

main:
	la a0, helloworld # Load address into a0 register
	li a7, 4 # Load 4 into a7 for the print string syscall
	ecall # Perform the syscall
	
	li a7, 10 # Load 10 for exit syscall
	ecall # perform syscall