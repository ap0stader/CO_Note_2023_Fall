.text
li $v0, 5
syscall
move $s0, $v0
li $s1, 0
li $t0, 1

loop:
bgt $t0, $s0 loop_end
add $s1, $s1, $t0
addi $t0, $t0, 1
j loop

loop_end:
move $a0, $s1
li $v0, 1
syscall
li $v0, 10
syscall
