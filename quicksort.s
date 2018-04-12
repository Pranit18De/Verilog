.data 
 msg1: .asciiz "Sorted array is \n"
 array: .word 5, 2, 3, 4, 1
 line: .asciiz "\n"

.text
 main:
 li $a0,0 #low
 li $a1,4 #high
#  jal q_sort
 jal partition
 jal print

 li $v0, 10
 syscall

 

 partition:
 add $s0,$a0,$zero #i = low
 add $s2,$a0, $zero # j= low
 sll $s6,$a1,2 #high*4
 lw $s1,array($s6) #pivot = arr[high]
 for1:
 slt $t1, $s2, $s6  #for loop check j < high
 beq $t1, $zero, L2
 sll $s5,$s2,2
 lw $t2,array($s5) 
 slt $t3, $t2, $s1 #if arr[j]<=pivot
 beq $t3, $zero, L3
 
 sll $t8,$s0,2
 

 addi $s2,$s2,1 #j++
 j for1

 L2:
 lw $t4, array($t8) #swap arr[i] and arr[high]
 lw $t5, array($s6)
 sw $t4, array($s6) 
 sw $t5, array($t8)

 add $v0, $s0, $zero
 jr $ra

 L3:
 addi $s2,$s2,1 #j++
 j for1


 q_sort:
 addi $sp,$sp,-12
 sw $a0, 8($sp)
 sw $a1, 4($sp)
 sw $ra, 0($sp)

 slt $t0, $a0, $a1 #checking if low < high
 beq $t0, $zero,L1

 jal partition
 move $s4, $v0 # p = partition()
 addi $t6, $s4,-1

 move $a1,$t6
 jal q_sort

 lw $ra, 0($sp)
 lw $a1, 4($sp)
 lw $a0, 8($sp)
 addi $sp, $sp, 12

 addi $sp,$sp,-12
 sw $a0, 8($sp)
 sw $a1, 4($sp)
 sw $ra, 0($sp)

 addi $t6, $s4,1
 move $a0, $t6

 jal q_sort

 lw $ra, 0($sp)
 lw $a1, 4($sp)
 lw $a0, 8($sp)
 addi $sp, $sp, 12

 L1: 
 jr $ra
 
 print:
 
 li $v0, 4
 la $a0, msg1
 syscall

 addi $t7, $zero,0 
 while:
 beq $t7, 20, exit
 li $v0,1
 lw $a0, array($t7)
 syscall

 addi $t7,$t7,4
 li $v0, 4
 la $a0, line
 syscall

 j while
 exit:
 jr $ra

