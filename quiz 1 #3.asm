
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
	mov.s	$f1, $f0 		# $f1 = n 
	
	li	$f2, 1				# $f2 = x = 1
	
while: 
	
