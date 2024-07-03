.text

li $t0, 20
sw $t0, 0($zero)
li $t0, 16808
sw $t0, 4($zero)
li $t0, 15090
sw $t0, 8($zero)
li $t0, 44250
sw $t0, 12($zero)
li $t0, 3115
sw $t0, 16($zero)
li $t0, 46979
sw $t0, 20($zero)
li $t0, 56009
sw $t0, 24($zero)
li $t0, 36569
sw $t0, 28($zero)
li $t0, 2559
sw $t0, 32($zero)
li $t0, 12100
sw $t0, 36($zero)
li $t0, 1102
sw $t0, 40($zero)
li $t0, 39065
sw $t0, 44($zero)
li $t0, 15446
sw $t0, 48($zero)
li $t0, 4749
sw $t0, 52($zero)
li $t0, 56291
sw $t0, 56($zero)
li $t0, 54452
sw $t0, 60($zero)
li $t0, 14152
sw $t0, 64($zero)
li $t0, 14616
sw $t0, 68($zero)
li $t0, 16658
sw $t0, 72($zero)
li $t0, 50073
sw $t0, 76($zero)
li $t0, 18773
sw $t0, 80($zero)




li $s0, 0 # int compare_count = 0

li $s1, 0
lw $s2, 0($s1) # int N = buffer[0]

addi $a0, $s1, 4 # binary_insertion_sort(&(buffer[1]), N)
move $a1, $s2
jal binary_insertion_sort

sw $s0, 0($s1) # buffer[0] = compare_count

j final


# a0: v, a1: k, a2: n
insert:
mul $t1, $a2, 4 # int tmp = v[n]
add $t2, $a0, $t1
lw $t5, 0($t2)

subi $t0, $a2, 1 # i = n - 1
subi $t3, $t2, 4

insert_loop:
blt $t0, $a1, insert_final # if (i < k) goto insert_final
lw $t4, 0($t3) # v[i + 1] = v[i]
sw $t4, 0($t2)
subi $t2, $t2, 4
subi $t3, $t3, 4
subi $t0, $t0, 1
j insert_loop

insert_final:
mul $t1, $a1, 4 # v[k] = tmp
add $t2, $a0, $t1
sw $t5, 0($t2)
jr $ra


# a0: v, a1: left, a2: right, a3: n
binary_search:
subi $sp, $sp, 16
sw $ra, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $a3, 12($sp)

bgt $a1, $a2, binary_search_first

add $t0, $a1, $a2 # int mid = (left + right) / 2
sra $t0, $t0, 1
addi $s0, $s0, 1 # compare_count++

mul $t1, $a3, 4 # if (v[mid] > v[n])
add $t2, $a0, $t1
lw $t3, 0($t2)
mul $t1, $t0, 4
add $t2, $a0, $t1
lw $t4, 0($t2)
blt $t3, $t4, binary_search_left
j binary_search_right

binary_search_left:
subi $a2, $t0, 1 # return binary_search(v, left, mid - 1, n)
jal binary_search
j binary_search_final

binary_search_right:
addi $a1, $t0, 1 # return binary_search(v, mid + 1, right, n)
jal binary_search
j binary_search_final

binary_search_first:
move $v0, $a1 # return left

binary_search_final:
lw $ra, 0($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
lw $a3, 12($sp)
addi $sp, $sp, 16
jr $ra



# a0: v, a1: n
binary_insertion_sort:
move $s5, $ra # store ra
move $s7, $a1 # store n
li $s6, 1 # int i = 1

binary_insertion_sort_loop:
bge $s6, $s7, binary_insertion_sort_final # if (i >= n) goto insertion_sort_final
move $a1, $zero # int place = binary_search(v, 0, i - 1, i)
subi $a2, $s6, 1
move $a3, $s6
jal binary_search
move $a1, $v0 # insert(v, place, i)
move $a2, $s6
jal insert
addi $s6, $s6, 1
j binary_insertion_sort_loop

binary_insertion_sort_final:
jr $s5






final:

li $s0, 2047  # 0x000007FF
li $t0, 63
sw $t0, 0($s0)
li $t0, 6
sw $t0, -4($s0)
li $t0, 91
sw $t0, -8($s0)
li $t0, 79
sw $t0, -12($s0)
li $t0, 102
sw $t0, -16($s0)
li $t0, 109
sw $t0, -20($s0)
li $t0, 125
sw $t0, -24($s0)
li $t0, 7
sw $t0, -28($s0)
li $t0, 127
sw $t0, -32($s0)
li $t0, 111
sw $t0, -36($s0)
li $t0, 119
sw $t0, -40($s0)
li $t0, 124
sw $t0, -44($s0)
li $t0, 57
sw $t0, -48($s0)
li $t0, 94
sw $t0, -52($s0)
li $t0, 121
sw $t0, -56($s0)
li $t0, 113
sw $t0, -60($s0)


li $s1, 1073741840  # 0x40000010
li $t0, 4
mul $s2, $s2, 4

begin_1:
bgt $t0, $s2, end_1
lw $t3, 0($t0)  # $t3 = buffer[i]

sll $a0, $t3, 28  # $a0 = $t3[3:0]
srl $a0, $a0, 28
mul $a0, $a0, 4  # $a0 *= 4
sub $a0, $s0, $a0  # $a0 = 0x000007FF - $a0
lw $a0, 0($a0)  # $a0 = buffer[$a0]
addi $a0, $a0, 256  # $a0 += 2^8

sll $a1, $t3, 24  # $a1 = $t3[7:4]
srl $a1, $a1, 28
mul $a1, $a1, 4  # $a1 *= 4
sub $a1, $s0, $a1  # $a1 = 0x000007FF - $a1
lw $a1, 0($a1)  # $a1 = buffer[$a1]
addi $a1, $a1, 512  # $a1 += 2^9

sll $a2, $t3, 20  # $a2 = $t3[11:8]
srl $a2, $a2, 28
mul $a2, $a2, 4  # $a2 *= 4
sub $a2, $s0, $a2  # $a2 = 0x000007FF - $a2
lw $a2, 0($a2)  # $a2 = buffer[$a2]
addi $a2, $a2, 1024  # $a2 += 2^10

sll $a3, $t3, 16  # $a3 = $t3[15:12]
srl $a3, $a3, 28
mul $a3, $a3, 4  # $a3 *= 4
sub $a3, $s0, $a3  # $a3 = 0x000007FF - $a3
lw $a3, 0($a3)  # $a3 = buffer[$a3]
addi $a3, $a3, 2048  # $a3 += 2^11

# loop for 1s/4ms = 250
li $t1, 250

begin_2:
beq $t1, $zero, end_2
sw $a0, 0($s1)  # buffer[0x40000010] = digi
jal stall_10k
sw $a1, 0($s1)  # buffer[0x40000010] = digi
jal stall_10k
sw $a2, 0($s1)  # buffer[0x40000010] = digi
jal stall_10k
sw $a3, 0($s1)  # buffer[0x40000010] = digi
jal stall_10k

sw $zero, 0($s1)  # buffer[0x40000010] = 0
subi $t1, $t1, 1
j begin_2

end_2:
addi $t0, $t0, 4
j begin_1


# stall, f0=10MHz, f=1KHz, stall=10K
stall_10k:
li $t2, 2500
stall_10k_loop:
subi $t2, $t2, 1
bne $t2, $zero, stall_10k_loop
jr $ra

end_1:
j end_1
