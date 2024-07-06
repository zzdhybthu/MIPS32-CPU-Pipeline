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
