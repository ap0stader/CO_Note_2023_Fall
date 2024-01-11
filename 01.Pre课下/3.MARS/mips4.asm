.data
matrix: .space 256

str_enter: .asciiz "\n"
str_space: .asciiz " "

# 把 (%i * 8 + %j) * 4 存入 %ans 寄存器中，方便直接计算出地址
.macro getindex(%ans, %i, %j)
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
# $t0 是一个循环变量
li $t0, 0

# 第一层循环
in_i:
beq $t0, $s0, in_i_end
li $t1, 0

# 第二层循环
in_j:
beq $t1, $s1, in_j_end
li $v0, 5
syscall
getindex($t2, $t0, $t1)
sw $v0, matrix($t2)
addi $t1, $t1, 1
j in_j

in_j_end:
addi $t0, $t0, 1
j in_i

in_i_end:
#$t0重复使用，所以要恢复
li $t0, 0

out_i:
beq $t0, $s0, out_i_end
li $t1, 0

out_j:
beq $t1, $s1, out_j_end
getindex($t2, $t0, $t1)
lw $a0, matrix($t2)
li $v0, 1
syscall
la $a0, str_space
li $v0, 4
syscall
addi $t1, $t1, 1
j out_j

out_j_end:
la $a0, str_enter
li $v0, 4
syscall
addi $t0, $t0, 1
j out_i

out_i_end:
li $v0, 10
syscall
