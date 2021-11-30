
# 
# Quiz 1 #1
# Junwen Zhong
# 11/23/21
# convert single-precision temperatures from Fahrenheit to Celsius
# celsius = (Fahrenheit-32.0) × 5.0 / 9.0
#

	.data 
prompt1:	.asciiz, "Enter an integer tempeture in Celsius: "
str1:	.asciiz, "The tempeture in Fahrenheit is: "
str2:	.asciiz, "\n"
	
	.text
	.globl main
	
main: 
	la	$a0, prompt1			# cout << prompt1;
	li	$v0, 4		
	syscall 
	
	li	$v0, 5					# cin >> $f0;
	syscall
	mtc1	$v0, $f0
	cvt.s.w	$f0, $f0 
	
	li.s	$f1, 5.0			# $f1 = 5/9;
	li.s	$f2, 9.0			
	div.s	$f1, $f1, $f2
	
	li.s	$f2, 32.0			# $f2 = $f0 - 32;
	sub.s 	$f2, $f0, $f2
	
	mul.s 	$f12, $f1, $f2 		# $f12 = $f1 * $f2;
	
	la	$a0, str2				# cout << str2;
	li	$v0, 4 
	syscall 
	
	li	$v0, 2					# cout << $f12;
	syscall 
	
	li	$v0, 10
	syscall 
