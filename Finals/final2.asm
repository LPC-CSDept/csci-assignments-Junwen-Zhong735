
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