.data
    num: .word 0

.text
    main:
    lw $t0,num
    jal while
    li $v0,10
    syscall
        while:
        slti $t3,$t0,10
        beq $t3,$zero,L1
        addi $t0,$t0,1
        li $v0,1
        move $a0,$t0
        syscall
        
        jal while
        
        L1:
            jr $ra

            

