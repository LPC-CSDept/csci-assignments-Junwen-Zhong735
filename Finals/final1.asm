    .data
counter:    .word, 3

    .text
    .globl main 

main: 
    lui	$s0, 0xffff				# memory mapped io location
	lw	$t0, counter			# $t0 = number of digits

waiting: 

    j waiting 					# continue loop 