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