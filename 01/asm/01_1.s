.section .data
fname: .asciz "input"
readmode: .asciz "r"
fmt: .asciz "%d\n"

.section .bss
.lcomm scan, 4
.lcomm fp, 8

.section .text
.globl main

main:

    # open input file
    movq $fname, %rdi
    movq $readmode, %rsi
    call fopen
    movq %rax, fp

    # %ebx is an accumulator that tracks the total
    xorl %ebx, %ebx

scanloop:

    # read a line
    xorl %eax, %eax
    movq fp, %rdi
    movq $fmt, %rsi
    movq $scan, %rdx
    call fscanf

    # check if we've reached end of input
    cmpl $0, %eax
    jle done

    # divide by 3, subtract 2
    movl scan, %eax
    movl $1431655766, %edx
    imull %edx
    subl $2, %edx

    # add to accumulator
    addl %edx, %ebx

    jmp scanloop

done:

    # output answer
    xorl %eax, %eax
    movq $fmt, %rdi
    movl %ebx, %esi
    call printf

    # close file
    movq fp, %rdi
    call fclose

    # sys_exit
    movl $60, %eax
    xorl %edi, %edi
    syscall
