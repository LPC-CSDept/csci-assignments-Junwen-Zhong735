
# 
# Quiz 1 #3
# Junwen Zhong
# 11/23/21
# calculate Netwon's Method
# x' = (x + n/x)/2
#

	.data
str1:	.asciiz, "Enter a number for n: "
str2:	.asciiz, "Square root is: "

	.text
	.globl main
	
main: 
	la	$a0, str1			# cout << str1 
	li	$v0, 4 
	syscall 
	
	li	$v0, 6				# cin >> n 
	
	li	$f1, 1				# $f1 = x = 1
	li 	$f2, 2				# $f2 = 2
	li	$f3, 0.00001			# $f3 = 0.00001
	
loop: 
	div.s	$f4, $f0, $f1			# $f4 = n/x
	nop 
	nop 
	add.s	$f4,$f0, $f4 			# $f4 = x + n/x
	div.s	$f4, $f4, $f2			# $f4 = (x + n/x)/2 = x'
	nop 
	nop 
	sub.s 	$f5, $f4, $f1			# $f5 = x' - x
	abs.s 	$f5, $f5			# $f5 = | x' - x |
	c.lt.s	$f5, $f3			# | x' - x | < 0.00001
	bf1f.s	loop 
	nop 
	
exit: 
	la	$a0, str2			# cout << str2
	li 	$v0, 4
	syscall
	
	mov.s 	$f12, $f4			# cout << x'
	li 	$v0, 6 
	syscall
	
	li $v0, 10 
	syscall 
	
	
	
	
