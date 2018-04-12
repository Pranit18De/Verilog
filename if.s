.data
    msg1: .asciiz "greater than"
    msg2: .asciiz "less than"

.text

    main:
    addi $t0,$zero,5
    addi $t1,$zero,6

    slt $t2,$t0,$t1
    beq $t2,$zero,else
    li $v0,4
    la $a0,msg2
    syscall
    li $v0,10
    syscall

    else:
         li $v0,4
         la $a0,msg1
         syscall
        li $v0,10
        syscall
    