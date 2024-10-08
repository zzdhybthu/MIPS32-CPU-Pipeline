.data
buffer: .space 4004
infile: .asciiz "data.bin"
.align 2
outfile: .asciiz "data.out"
.align 2

.text
la $a0, infile # infile = fopen("data.bin", "rb")
li $a1, 0
li $a2, 0
li $v0, 13
syscall

move $a0, $v0 # fread(buffer, 4, 1001, infile)
la $a1, buffer
li $a2, 4004
li $v0, 14
syscall

li $v0, 16 # fclose(infile)
syscall

li $s0, 0 # int compare_count = 0

la $s1, buffer
lw $s2, 0($s1) # int N = buffer[0]

addi $a0, $s1, 4 # binary_insertion_sort(&(buffer[1]), N)
move $a1, $s2
jal binary_insertion_sort

sw $s0, 0($s1) # buffer[0] = compare_count

la $a0, outfile # outfile = fopen("data.out", "wb")
li $a1, 1
li $a2, 0
li $v0, 13
syscall

move $a0, $v0 # fwrite(buffer, 4, N + 1, outfile)
la $a1, buffer
addi $a2, $s2, 1
mul $a2, $a2, 4
li $v0, 15
syscall

li $v0, 16 # fclose(outfile)
syscall
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
# # print \n
# li $v0, 11
# li $a0, 10
# syscall
# # print buffer
# li $t0, 0
# la $t1, buffer
# 
# loop:
# bgt $t0, $s2, end
# lw $a0, 0($t1)
# li $v0, 1
# syscall
# addi $t0, $t0, 1
# addi $t1, $t1, 4
# j loop
# end: