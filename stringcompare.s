.data
    msg1: .asciiz  "Enter the first string\n"
    msg2: .asciiz "Enter the second string\n"
    msg3: .asciiz "Strings are not equal"
    msg4: .asciiz "Strings are equal"

    str1 : .space 100
    str2 : .space 100

.text

main:    
    la $a0,msg1
    li $v0,4
    syscall

    la $s1,str1
    move $t1,$s1
    jal inputstr

    la $a0,msg2
    li $v0,4
    syscall

    la $s2,str2
    move $t1,$s2
    jal inputstr

    jal compare

    li $v0,10
    syscall

    inputstr:
    move $a0,$t1
    li $a1,99
    li $v0,8
    syscall
    jr $ra

    compare:
    lb $t2,($s1)
    lb $t3,($s2)
    bne $t2,$t3,ne
    beq $t2,$zero,e

    addi $s1,$s1,1
    addi $s2,$s2,1

    j compare

    e:
        la $a0,msg4
        li $v0,4
        syscall
        jr $ra

    ne:
        la $a0,msg3
        li $v0,4
        syscall
        jr $ra


    
        

    

    
    

