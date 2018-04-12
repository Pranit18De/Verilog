.data
 array: .word 3, 5, 4, 1, 0
 p1: .asciiz "Sorted list is\n"
 line: .asciiz "\n"

.text
 main:
 la $a0,array #passing arguement to bubblesort
 li $a1,5
 jal bubbleSort

 jal print

 li $v0, 10 # Syscall to end the program
 syscall

 print:
 li $v0, 4
 la $a0, p1
 syscall

 addi $t0, $zero,0 # initialize t0 to 0

 while:
 
 beq $t0, 20, exit
 li $v0,1
 lw $a0, array($t0)
 syscall

 addi $t0,$t0,4
 li $v0, 4
 la $a0, line
 syscall

 j while

 exit:
 jr $ra

 swap:
 
 sll $t1, $a1, 2 
 add $t1, $a0, $t1 
 
 lw $t0, 0($t1) 
 lw $t2, 4($t1) 
 sw $t2, 0($t1) 
 sw $t0, 4($t1)

 jr $ra

 bubbleSort:
 addi $sp, $sp, -20
 sw $ra, 16($sp)
 sw $s0, 12($sp)
 sw $s1, 8($sp)
 sw $s2, 4($sp)
 sw $s3, 0($sp)

 add $s2, $a0, $zero #s2 has base address
 add $s3, $a1, $zero #s3 has 5(size)
 add $s0, $zero, $zero #s0 has i=0

 L1:
 slt $t0,$s0,$s3
 beq $t0, $zero, End1 #i++

 add $s1, $zero, $zero #s1 has j=0

 sub $t7, $s3, $s0
 addi $t7, $t7, -1 # t7=n-i-1

 L2:
 slt $t0, $s1, $t7      #j<n-1-i
 beq $t0, $zero, End2   #j++
 
 sll $t2, $s1, 2    #j+1
 add $t2, $s2, $t2  # to access arr[j+1]
 
 lw $t3, 0($t2)
 lw $t4, 4($t2)

 slt $t5, $t4, $t3
 beq $t5, $zero, End3

 add $a0, $s2,$zero
 add $a1,$s1,$zero

 jal swap #calling swap function to swap the value
 addi $s1,$s1,1
 j L2

 End3:
 addi $s1,$s1,1
 j L2

 End2:
 addi $s0, $s0,1
 j L1

 End1:
 lw $s3 0($sp)
 lw $s2 4($sp)
 lw $s1 8($sp)
 lw $s0 12($sp)
 lw $ra 16($sp)
 addi $sp, $sp, 20
 
 jr $ra