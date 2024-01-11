.data
    array: .space 400
    message_input_n: .asciiz "Please input an integer as the length of the sequence:\n"
    message_input_array: .asciiz "Please input an integer followed with a line break:\n"
    message_output_array: .asciiz "The sorted sequence is:\n"
    space: .asciiz " "
    stack: .space 100

# MARS中提供了在程序运行的时候就将PC定位到main的选项，配上这一句就可以使用了，但是题目的要求是不能使用
# .globl main

# 栈的使用是从高地址走向低地址的（向低地址移动）
# 栈帧的一般结构如下（从低地址向高地址：
# $a0-$a3 < 更多需要传递的参数 < $s0-$s7 < $ra < $t0-$t9

# 叶子函数的栈帧，只需要$s0-$s7部分，如果没有可不占用栈空间

# $a0-$a3及更多需要传递的参数需要传递的参数是【子过程传给子子过程的】，要在调用子过程时声明（无需初始化），在子过程中赋值，在子子过程中可以决定是否使用
# 设计栈帧结构的时候一般给$a0-$a3留空间
# $s0-$s7是用来给子过程完成它需要做的$s0-$s7维护任务用的
# $ra是调用子过程的父过程当前的$ra值，用于在调用结束后取回恢复
# $t0-$t9是用来给负过程完成它需要做的$t0-$t9维护任务用的

# $t9-$t0、$ra的保存到栈的过程：在调用一个子过程前进行
# $s7-$s0的保存到栈过程、维护栈顶指针：在一个子过程开始的时候进行
# 更多需要传递的参数、a3-$a0保存到栈的过程：在子过程调用子子过程时进行

# 按照栈的使用方式：
# 按照从高地址到低地址的顺序存入
# 按照从低地址到高地址的顺序去出

.text
    main:
        # 初始化栈顶指针
        la $sp, stack
        addiu $sp, $sp, 100
        
        # 维护栈顶指针：占用空间
        # 栈帧结构如下
        # +16-+19 $t0
        # +12-+15 $a3
        # +8-+11 $a2
        # +4-+7 $a1
        # main.$sp-+3 $a0
        # 使用的是“无符号加法”，主要的目的是不用处理符号溢出的异常
        addiu $sp, $sp, -20
        
        # input函数，不传入参数，返回一个值：输入的数字的数量
        jal input
        nop
        # 将函数的返回值保存到$t寄存器中，释放的寄存器供下一个调用的函数来使用
        move $t0, $v0

        # sort函数，传入一个参数：输入的数字的数量，没有返回值
        move $a0, $t0
        # 调用前做好$t寄存器的维护
        sw $t0, 16($sp)
        jal sort
        nop
        # 恢复$t寄存器
        lw $t0, 16($sp)

        # output函数，传入一个参数：输入的数字的数量，没有返回值
        # $t0寄存器不再使用，故不再维护
        move $a0, $t0
        jal output
        nop
        
        # 维护栈顶指针：释放空间
        addiu $sp, $sp, 20

        # 退出程序
        li $v0, 10
        syscall


    # 输入函数
    input:
        # 这是个叶子函数，而且没有$s寄存器需要保存，故不占用栈空间

        la $a0, message_input_n
        li $v0, 4
        syscall

        # 读取输入数字的个数
        li $v0, 5
        syscall
        # 将数据存储到$t0中
        move $t0, $v0

        # $t1作为循环变量，表达式1
        li $t1, 0
        for_1_begin:
            # 判断条件，表达式2
            slt $t2, $t1, $t0
            beq $t2, $zero, for_1_end
            nop

            # 复用$t2，此处是取数组首地址
            la $t2, array
            li $t3, 4
            # HI和LO保存乘法的结果
            mult $t3, $t1
            # 将LO的结果保存到$t3中，之所以只使用LO，是因为数据的区段（0x00000000-0x00003000）乘4（0x00000000-0x0000c000）也不会超过LO的表示范围
            mflo $t3
            # 将数组的指针移动到正确的位置
            addu $t2, $t2, $t3

            la $a0, message_input_array
            li $v0, 4
            syscall

            # 读取一个数字
            li $v0, 5
            syscall
            # 将数据存储到内存
            sw $v0, 0($t2)

            addi $t1, $t1, 1
            j for_1_begin
            nop

        for_1_end:
            # 元素的个数是在本函数输入的，返回供其他函数使用
            move $v0, $t0
            jr $ra
            nop


    # 输出函数
    output:
        # 这是个叶子函数，而且没有$s寄存器需要保存，故不占用栈空间
        
        # 将传递的参数值保存到$t寄存器中，释放的寄存器供调用下一个函数时使用
        move $t0, $a0,
        
        la $a0, message_output_array
        li $v0, 4
        syscall

        li $t1, 0
        for_2_begin:
            # 类似输入部分，逐个打印排序好后的数字
            slt $t2, $t1, $t0
            beq $t2, $zero, for_2_end
            nop

            la $t2, array
            li $t3, 4
            mult $t3, $t1
            mflo $t3
            addu $t2, $t2, $t3

            lw $a0, 0($t2)
            li $v0, 1
            syscall
            
            la $a0, space
            li $v0, 4
            syscall
            
            addi $t1, $t1, 1
            j for_2_begin
            nop

        for_2_end:
            jr $ra
            nop


    # 排序函数
    sort:
        # 维护栈顶指针：占用空间
        # 栈帧结构如下
        # +28-+31 $t2
        # +24-+27 $t1
        # +20-+23 $t0
        # +16-+19 $ra
        # +12-+15 $a3
        # +8-+11 $a2
        # +4-+7 $a1
        # sort.$sp-+3 $a
        addiu $sp, $sp, -32

        move $t0, $a0
        
        li $t1, 0
        for_4_begin:
            slt $t2, $t1, $t0
            beq $t2, $zero, for_4_end
            nop

            la $t2, array
            li $t3, 4
            mult $t3, $t1
            mflo $t3
            addu $t2, $t2, $t3

            # 传递元素的总个数
            move $a0, $t0
            # 传递从哪里开始进行查找
            move $a1, $t1

            # 在父过程的栈帧上保存$a1-$a0（栈的地址是连续的）
            sw $a1, 36($sp)
            sw $a0, 32($sp)
            # 这些t寄存器的数据之后还要使用的，而且t寄存器是调用者进行维护的
            sw $t2, 28($sp)
            sw $t1, 24($sp)
            sw $t0, 20($sp)
            sw $ra, 16($sp)

            # find返回最小值（含当前值）的地址
            jal findmin
            nop

            lw $ra, 16($sp)
            lw $t0, 20($sp)
            lw $t1, 24($sp)
            lw $t2, 28($sp)

            # v0是函数返回的最小值的地址
            lw $t3, 0($v0)
            # t2是计算出的当前元素的地址
            lw $t4, 0($t2)
            
            # 进行交换
            sw $t3, 0($t2)
            sw $t4, 0($v0)

            addi $t1, $t1, 1
            j for_4_begin
            nop
        
        for_4_end:
            # 维护栈顶指针：释放空间
            addiu $sp, $sp, 32
            jr $ra
            nop


    # 查找最小值函数
    findmin:
        # 选取最后一个数字，从后往前查找

        # 这是个叶子函数，而且没有$s寄存器需要保存，故不占用栈空间

        # 子子过程并没有选择使用子过程在父过程的栈中保存的值，而是直接使用了寄存器中的值
        # $a0是元素的总个数，$a1是从哪里开始查找

        # 大量的重复计算，可以优化
        # 计算得到数组结束的内存地址
        la $t0, array
        # 数字的数量x4
        sll $a0, $a0, 2
        # 再-4（数组从0开始）
        subi $a0, $a0, 4
        addu $t0, $t0, $a0

        # $t1保存当前查找到的最小值，初始化为数组结束处的值
        lw $t1, 0($t0)

        # $t2保存当前查找到的最小值的内存地址，初始化为数组结束处的内存地址
        move $t2, $t0

        # $t3作为循环变量，初始化为数组结束处的内存地址
        move $t3, $t0

        # 计算得到开始查找处的内存地址
        la $t0, array
        sll $a1, $a1, 2
        # $t0保存计算得到的开始查找处的内存地址
        addu $t0, $t0, $a1

        for_3_begin:
            # 判断条件：当前查找的地址大于等于开始查找处的内存地址
            # 此处是有符号的比较，减到了负数也能正常得到结果
            sge $t4, $t3, $t0
            beq $t4, $zero, for_3_end
            nop

            # 读取当前位置的值
            lw $t5, 0($t3)

            # 如果小于当前查找到的最小值，那么替换查找到的最小值及其内存地址
            slt $t6, $t5, $t1
            # 此处是为了保持if_else语句的固定模板，可优化
            beq $t6, $zero, if_1_else
            nop
            move $t1, $t5
            move $t2, $t3
            j if_1_end
            nop

            if_1_else:
            if_1_end:
                # 当前位置的地址-4
                subi $t3, $t3, 4
                j for_3_begin
                nop
        
        for_3_end:
            # 返回查找到的最小值的内存地址
            move $v0, $t2
            jr $ra
            nop