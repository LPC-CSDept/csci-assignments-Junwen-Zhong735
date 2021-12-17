    .data
counter:    .word, 3

    .text
    .globl main 

main: 
    lui	$s0, 0xffff				# memory mapped io location
	lw	$t0, counter			# $t0 = number of digits

waiting: 
    lw	$t1, 0($s0)				# load reciever control register
	andi	$t1, $t1, 0x1		# test if reciever control register has 1 in LSB 
	beqz	$t1, waiting		# loop if LSB is 0

    lw	$s1, 4($s0)				# read from input device if LSB = 1
	sub $s1, $s1, 48			# $s1 = $v0 -48
	
	sub	$t0,$t0, 1				# increment counter
	beqz 	$t0,  transmit		# end loop after 3 digits 

    j waiting 					# continue loop 
	
    li	$t1, 1					# determine if 1st digit 
	beq	$t0, $t1, digit2		# branch if 2nd digit 

digit1: 
    li  $t1, 100                # multiply by 100 for 1st digit 
    mult	$s1, $t1 
    mflo    $s2 

digit2: 
	li 	$t1, 10 				# multiply by 10 for 2nd digit 
	mult	$s1, $t1 
	mflo	$t1 
	add 	$s2, $s2, $t1		# combine 1st digit and 2nd digit 

    j waiting 					# continue loop 

transmit: 
    add 	$a0, $s2, $s1 		# combine all 3 digits 
	li 	$v0, 1 					# print decimal (integer) 
    syscall

	li 	$v0, 10					# end program  
    syscall