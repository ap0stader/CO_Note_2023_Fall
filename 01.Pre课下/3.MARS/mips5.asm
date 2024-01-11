.data
# 求前12个斐波那契数
# 数组的大小是 12*4 = 48
fibs: .space 48
# 使用.word表示按照字大小来存储，实现解决对其的问题
size: .word 12
space: .asciiz " "
head: .asciiz "The Fibonacci numbers, are:\n"

.text
# 数组的指针
la $t0, fibs
# 求解多少个斐波那契数
# 先加载的是地址，然后加载的是值
la $t5, size
lw $t5, 0($t5)
# 初始化第1和第2个斐波那契数
li $t2, 1
sw $t2, 0($t0)
sw $t2, 4($t0)
# 循环的次数，因为前面两个已经初始化了，故减少两次循环次数
addi $t1, $t5, -2

loop:
# t3表示的是F(n)
lw $t3, 0($t0)
# t4表示的是F(n+1)
lw $t4, 4($t0)
# t2表示加和后的F(n+2)
add $t2, $t3, $t4
# 存储F(n+2)
sw $t2, 8($t0)
# 数组的指针往后移动一个数字
addi $t0, $t0, 4
# 循环次数减少一次
addi $t1, $t1, -1
# Branch if greater than zero
bgtz $t1, loop

# $a0存储为为数组的头
# la $a0, fibs
# $a1存储求解的数量
# add $a1, $zero, $t5
# 跳转到打印部分，并且将下一条指令的地址保存
jal print
li $v0, 10
syscall

print:
# 将$a0和$a1的值转移到$t0和$t1中
# add $t0, $zero, $a0
# add $t1, $zero, $a1
# 实例代码次数借用了$a0和$a1并没有必要
la $t0, fibs
add $t1, $zero, $t5
# 打印开头的提示语
la $a0, head
li $v0, 4
syscall

out:
# 当前的这一个数字
lw $a0, 0($t0)
# 打印数字和空格
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
# 移动指针，减少循环次数
addi $t0, $t0, 4
addi $t1, $t1, -1
bgtz $t1, out

# 如果打印完成，则跳转回去，执行结束的指令
jr $ra