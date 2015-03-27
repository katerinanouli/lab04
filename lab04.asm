# Calculates gcd of 2 numbers
# lab04 of Computer Architecture course
#  at CSE.UoI.gr 

        .data
n1:
        .word  462
n2:
        .word  1071
result:
        .word 0

        .globl main

        .text
main:   
        
        la   $s0, n1       # Get address of n1
        lw   $a0, 0($s0)   # Get n1

        lw   $a1, 4($s0)   # Get n2

        jal  gcd	   

        la   $t0, result  # Address where the result should go to
        sw   $v0, 0($t0)

        # end the program
        li   $v0, 10
        syscall

############################################################################
        # Write your code here for mod and gcd
mod:

loop:
	slt $t0 , $a0 ,	 $a1   		# t0 = a0 < a1
      	bne $t0 , $zero, return_value 	# if(t0 ! = 0) goto return_value
	sub $a0 , $a0 , $a1		# a0 = a0 - a1 
	j loop				# goto loop
return_value:				
	add $v0 , $a0 , $zero		# store the return value
	jr $ra				# jump to $ra address

############################################################################
gcd:
	addi $sp , $sp ,-4 		# get space on stuck
	sw   $ra,0($sp)			# store $ra on stuck 

        slt $t0 , $a1 ,	 $a0   		# t0 = a1 < a0
      	bne $t0 , $zero, least 		# if t0 != 0 goto least
     	add $t1 , $a0 ,  $zero		# t1 = a0
     	add $a0 , $a1 ,  $zero		# a0 = a1 
      	add $a1 , $t1 ,  $zero 		# a1 = t1
least:
      	beq $a1 , $zero, return 	# b == 0 goto return 
	jal  mod			# call mod
	add $a0 , $a1 , $zero		# a0 = a1
	add $a1 , $v0 , $zero		# a1 = mod(a,b);
	jal gcd				# jump and link to gcd
return:

	lw   $ra,0($sp)			# load ra from stuck 
			
 	addi $sp ,$sp,4			# free space from stuck
	add  $v0 , $a0 , $zero		# store the return value $a0
      	jr $ra				# jump to $ra 
