.text
    num1: .word 5
    num2: .word 6
.text

main:
    lw $a0,num1
    lw $a1,num2
   

    li $v0,1
    add $a0,$a0,$a1
    syscall

    li $v0,1
    sub $a0,$a0,$a1
    syscall

    # li $v0,1
    # mul $a0,$a0,$a1
    # syscall

    # mult $a0,$a1
    # mflo $s0
    # li $v0,1
    # add $a0,$zero,$s0
    # syscall

    sll $t0,$a0,2
    li $v0,1
    move $a0,$t0
    syscall
    
    

    li $v0,10
    syscall