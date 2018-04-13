.data
   


.text
    main:
        addi $a2,$zero,5
        addi $a1,$zero,6
        jal addno

        li $v0,1
        addi $a0,$v1,0
        syscall

        
        li $v0,10
        syscall






    addno:
        add $v1,$a1,$a2
        jr $ra