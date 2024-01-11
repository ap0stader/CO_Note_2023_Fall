.data
str: .asciiz  "Hello World"

.text
la $s0, str
li $v0, 4
syscall

li $v0, 10
syscall
