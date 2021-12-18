
	.kdata 
data1:	.word, 1
data2:	.word, 2
	
	.text
	.globl main 
	
main: 
	mfc0	$s0, $12 			# read status register
	ori	$s0, $s0, 0xff11		# enable all interrupts 
	mtc0	$12, $s0			# update status register 
	
	lui 	$t0, 0xffff 		# $t0 = 0xffff0000, memory address of reciever control register 
	ori 	$s0, 2				# enable keyboard interrupts 
	sw 	$s0, 0($t0) 			# update reciever control register

loop: 
	j	loop 					# endless loop 
	
exit: 
	li 	$v0, 10 				# end program 
	syscall 

# kernel text 
	.ktext 0x80000180     		# kernel code starts here
	
	sw	$v0, data1     			# save registers that will be used to memory     
	sw	$a0, data2
	
	mfc0	$k0, $13     		# Cause register     
	srl	$a0, $k0, 2     		# Extract ExcCode Field     
	andi	$a0, $a0, 0x1f  	# Get the exception code     
	bne	$a0, $zero, kdone   	# Exception Code 0 is I/O.

    lui	$k0, 0xffff    			# $v0 = 0xffff0000     
	lbu	$a0, 4($k0)   			# get the input key 
	
	li 	$v0, 113				# $v0 = q, ascii code for q is 113
	beq 	$v0, $a0, kend 		# branch if input is 'q'
	
	sb 	$a0, 12($k0) 			# print the char 
	
	j 	kdone 					# prevents program from ending if input isn't 'q'
	
kend: 
	li 	$v0, 10 				# end program if input is 'q'
	syscall

kdone:     
	lw	$v0, data1     			# Restore saved registers     
	lw	$a0, data2     
	mtc0	$0, $13     		# Clear Cause register     
	mfc0	$k0, $12     		# Set Status register     
	andi	$k0, 0xfffd  		# clear EXL bit d = 1101   
	ori	$k0, 0x11     			# Interrupts enabled     
	mtc0	$k0, $12     		# write back to status     
	eret    			 		# return to EPC 