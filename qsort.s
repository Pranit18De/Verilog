.data 
low: 	.word 0
high: 	.word 9
array:	.word 12, 3, 6, 18, 7, 15, 10, 9, 0, 4
newline:.asciiz "\n"
space:	.asciiz " "

.text
main:
	la $a0, array
	lw $a1, low
	lw $a2, high
	jal printArray
	
	la $a0, array
	lw $a1, low
	lw $a2, high
	jal quickSort
	
	la $a0, array
	lw $a1, low
	lw $a2, high
	jal printArray
	
	# Exit
	li $v0, 10
	syscall	

printArray:
	move $t0, $a0
	loop:
		#if($a2 < $a1) break;
		slt $t1, $a2, $a1		#$t1 = $a2 < $a1
		bne $t1, $zero, endPrinting
		mul $t1, $a1, 4
		add $t1, $t0, $t1		#$t1 = $t0 + 4*$a1
		ori $v0, $zero, 1
		lw $a0, ($t1)
		syscall
		li $v0, 4
		la $a0, space
		syscall
		addi $a1, $a1, 1
		j loop
	endPrinting:
		li $v0, 4
		la $a0, newline
		syscall
		jr $ra
	
quickSort:
	addi $sp, $sp, -20
	sw $ra, ($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	slt $t0, $a1, $a2		#$t0 = low < hihg
	beq $t0, $zero, endQuickSort
	
	jal partition
	or $s0, $zero, $v0		#$s0 = partition()
	
	or $s1, $zero, $a2		#$s1 = high
	
	addi $a2, $s0, -1		#$a2 = $s0 - 1
	jal quickSort
		
	addi $a1, $s0, 1		#$a1 = $s0 + 1
	or $a2, $zero, $s1		#$a2 = high
	jal quickSort

endQuickSort:				#end if
	lw $ra, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 20
	jr $ra
		
partition:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	mul $s0, $a1, 4			#$s0 = $a1 * 4
	add $s0, $s0, $a0		#$s0 += $a0
	lw $s0, ($s0)
	
	forLoop:
		while:
			mul $t1, $a2, 4			#$t1 = $a2 * 4
			add $t1, $t1, $a0		#$t1 += $a0
			lw $t1, ($t1)			#$t1 = T[$a2 * 4] -> T[high]
	
			slt $t2, $a1, $a2	     #$t2 = $a1 < $a2 -> $t2 = low < high
			beq $t2, $zero, endWhile   #if(low >= high) break;
			slt $t2, $t1, $s0	      #$t2 = $t1 < $s0 -> T[high] < pivot
			bne $t2, $zero, endWhile  #if(T[high] < pivot) break;
			addi $a2, $a2, -1
			j while
		endWhile:
			slt $t2, $a1, $a2
			beq $t2, $zero, endForLoop
		
			mul $t0, $a1, 4
			add $t0, $t0, $a0
			sw $t1, ($t0)
			addi $a1, $a1, 1
	
		while2:
			mul $t1, $a1, 4
			add $t1, $t1, $a0
			lw $t1, ($t1)

			slt $t2, $a1, $a2
			beq $t2, $zero, endWhile2
			slt $t2, $s0, $t1	 #$t2 = $s0 < $t1 -> pivot < T[low]
			bne $t2, $zero, endWhile2#if(pivot < T[low]) break;
			addi $a1, $a1, 1
			j while2
		endWhile2:
			slt $t2, $a1, $a2
			beq $t2, $zero, endForLoop
	
			mul $t0, $a2, 4	
			add $t0, $t0, $a0
			sw $t1, ($t0)			#T[High] = T[low]
			addi $a2, $a2, -1
		j forLoop

	endForLoop:
		mul $t0, $a2, 4
		add $t0, $t0, $a0
		sw $s0, ($t0)			#T[high] = Pivot
		lw $ra, ($sp)
		lw $a1, 4($sp)
		lw $a2, 8($sp)
		addi $sp, $sp, 12
		or $v0, $a2, $zero		#$v0 = high
		jr $ra				#return high