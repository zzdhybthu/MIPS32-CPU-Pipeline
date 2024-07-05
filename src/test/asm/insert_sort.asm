.text

# receive data

li $s0, 1073741848  # 0x40000018, UART_TXD
                    # 0x4000001C, UART_RXD
                    # 0x40000020, UART_CONFIG
li $a0, 0
li $a1, -4
receive_loop:
beq $a0, $a1, receive_done
jal receive_wait_loop
lw $t1, 4($s0)
sll $t1, $t1, 24
jal receive_wait_loop
lw $t2, 4($s0)
sll $t2, $t2, 16
or $t2, $t1, $t2
jal receive_wait_loop
lw $t3, 4($s0)
sll $t3, $t3, 8
or $t3, $t2, $t3
jal receive_wait_loop
lw $t4, 4($s0)
or $t0, $t3, $t4

sw $t0, 0($a0)
addi $a0, $a0, 4
bne $a0, 0, receive_loop
mul $a1, $t0, 4
addi $a1, $a1, 4
sw $a1, -4($s0)  # store n in 0x40000014
j receive_loop


receive_wait_loop:
lw $t0, 8($s0)
sll $t0, $t0, 28  # RxDone
srl $t0, $t0, 31
beq $t0, $zero, receive_wait_loop
jr $ra





receive_done:

# insert sort

li $s0, 0 # int compare_count = 0

li $s1, 0
lw $s2, 0($s1) # int N = buffer[0]

addi $a1, $s1, 4 # insertion_sort(&(buffer[1]), N)
move $a2, $s2
jal insertion_sort

sw $s0, 0($s1) # buffer[0] = compare_count

j sort_done


# a1: v, a2: k, a3: n
insert:
mul $t1, $a3, 4 # int tmp = v[n]
add $t2, $a1, $t1
lw $t5, 0($t2)

subi $t0, $a3, 1 # i = n - 1
subi $t3, $t2, 4

insert_loop:
blt $t0, $a2, insert_final # if (i < k) goto insert_final
lw $t4, 0($t3) # v[i + 1] = v[i]
sw $t4, 0($t2)
subi $t2, $t2, 4
subi $t3, $t3, 4
subi $t0, $t0, 1
j insert_loop

insert_final:
mul $t1, $a2, 4 # v[k] = tmp
add $t2, $a1, $t1
sw $t5, 0($t2)
jr $ra



# a1: v, a2: n
search:
mul $t1, $a2, 4 # int tmp = v[n]
add $t2, $a1, $t1
lw $t3, 0($t2)

subi $t0, $a2, 1 # i = n - 1
subi $t1, $t2, 4

search_loop:
blt $t0, 0, search_final # if (i < 0) goto search_final
addi $s0, $s0, 1 # compare_count++
lw $t2, 0($t1) # if (v[i] <= tmp) goto search_final
ble $t2, $t3, search_final
subi $t1, $t1, 4
subi $t0, $t0, 1
j search_loop

search_final:
addi $v0, $t0, 1 # return i + 1
jr $ra



# a1: v, a2: n
insertion_sort:
move $s5, $ra # store ra
move $s7, $a2 # store n
li $s6, 1 # int i = 1

insertion_sort_loop:
bge $s6, $s7, insertion_sort_final # if (i >= n) goto insertion_sort_final
move $a2, $s6 # int place = search(v, i)
jal search
move $a2, $v0 # insert(v, place, i)
move $a3, $s6
jal insert
addi $s6, $s6, 1
j insertion_sort_loop

insertion_sort_final:
jr $s5





sort_done:

# send data

li $s0, 1073741848  # 0x40000018, UART_TXD
                    # 0x4000001C, UART_RXD
                    # 0x40000020, UART_CONFIG
lw $a1, -4($s0)  # n
li $a0, 0
send_loop:
beq $a0, $a1, send_done
lw $t0, 0($a0)
srl $t1, $t0, 24  # $t1 = $t0[31:24]
sll $t2, $t0, 8  # $t2 = $t0[23:16]
srl $t2, $t2, 24
sll $t3, $t0, 16  # $t3 = $t0[15:8]
srl $t3, $t3, 24
sll $t4, $t0, 24  # $t4 = $t0[7:0]
srl $t4, $t4, 24
sw $t1, 0($s0)
jal send_wait_loop
sw $t2, 0($s0)
jal send_wait_loop
sw $t3, 0($s0)
jal send_wait_loop
sw $t4, 0($s0)
jal send_wait_loop
addi $a0, $a0, 4
j send_loop


send_wait_loop:
lw $t0, 8($s0)
sll $t0, $t0, 29  # TxDone
srl $t0, $t0, 31
beq $t0, $zero, send_wait_loop
jr $ra





send_done:

# show result using led

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

show_loop:
bgt $t0, $s2, show_end
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

show_stall_loop:
beq $t1, $zero, show_stall_end
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
j show_stall_loop

show_stall_end:
addi $t0, $t0, 4
j show_loop


# stall, f0=70MHz, f=1KHz, stall=70KT, 5T per loop
stall_10k:
li $t2, 14000
stall_10k_loop:
subi $t2, $t2, 1
bne $t2, $zero, stall_10k_loop
jr $ra





show_end:

j show_end