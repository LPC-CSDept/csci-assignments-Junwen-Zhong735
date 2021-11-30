
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
	la $a0, prompt1			# print prompt for tempeture
	li $v0, 4
	syscall 
	
	li $v0, 5				# $f0 = temp
	