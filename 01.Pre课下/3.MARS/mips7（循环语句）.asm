.text
# 考虑了延迟槽（使用了nop）
# 初始化测试数据
# 类似于for循环的表达式1
# $t1是要循环的次数
li $t1, 100
# $t2是已经循环了的次数
li $t2, 0

for_begin_1:
# $t3保存 $t1是否小于$2的结果（1位布尔型）
slt $t3, $t2, $t1
# 跳转指令：如果$t3的判断结果是0，说明循环次数已到，跳转执行结束语句块
# 类似于for循环的表达式2
beq $t3, $0, for_end_1
nop

# do something

# 增加已经循环了的次数
# 类似于for循环的表达式3
addi $t2, $t2, 1
# 跳转回循环开始的地方
j for_begin_1
nop

for_end_1:
li $v0, 10
syscall
