.text
# 考虑了延迟槽（使用了nop）
# 初始化测试数据
li $t1, 100
li $t2, 200

# $t3保存 $t1是否小于$2的结果（1位布尔型）
# if判断的表达式
slt $t3, $t1, $t2

# 跳转指令：如果$t3的判断结果是0，跳转到else，否则继续执行if本身的语句快
beq $t3, $0, if_1_else
nop

#do something

# if本身的语句块执行完成，直接跳转到结束语句块，不能继续执行else的语句块
j if_1_end
nop

if_1_else:
#do something else

if_1_end:
li $v0, 10
syscall
