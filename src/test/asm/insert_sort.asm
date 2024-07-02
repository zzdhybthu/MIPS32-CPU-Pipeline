.text

li $s0, 0 # int compare_count = 0

li $s1, 0
lw $s2, 0($s1) # int N = buffer[0]

addi $a1, $s1, 4 # insertion_sort(&(buffer[1]), N)
move $a2, $s2
jal insertion_sort

sw $s0, 0($s1) # buffer[0] = compare_count

j final


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



final:
