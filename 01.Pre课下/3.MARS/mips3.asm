.data
array: .space 40
# 存储这些数需要用到数组，数组需要使用 10 * 4 = 40 字节
# 因此，array[0] 的地址为 0x00，array[1] 的地址为 0x04,以此类推。

str: .asciiz "The number are:\n"
space: .asciiz " "

.text
li $v0, 5
syscall
move $s0, $v0
li $t0, 0

loop_in:
beq $t0, $s0, loop_in_end
li $v0, 5
syscall
sll $t1, $t0, 2
sw $v0, array($t1)
addi $t0, $t0, 1
j loop_in

loop_in_end:
la $a0, str
li $v0, 4
syscall
li $t0, 0

loop_out:
beq $t0, $s0, loop_out_end
sll $t1, $t0, 2
lw $a0, array($t1)
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $t0, $t0, 1
j loop_out

loop_out_end:
li $v0, 10
syscall
