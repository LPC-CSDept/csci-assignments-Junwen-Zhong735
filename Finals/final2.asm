
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