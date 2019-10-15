#include <mips/regdef.h>
#include <sys/syscall.h>

#define STACK_SIZE 56
#define OFFSET_RA 48
#define OFFSET_GP 44
#define OFFSET_FP 40

/*
   56+-------------+
     | ----------- |
   52+-------------*
     |     ra      |
   48+-------------+
     |     gp      |
   44+-------------+
     |     fp      |
   40+-------------+
     |   result    |
   36+-------------+
     |   acum(2)   |
   32+-------------+
     |    acum     |
   28+-------------+
     |      k      |
   24+-------------+
     |      j      |
   20+-------------+
     |      i      |
   16+-------------+
     |             |
   12+-------------+
     |             |
    8+-------------+
     |             |
    4+-------------+
     |             |
    0+-------------+
*/

.data
    double_zero:   .double 0.0

    .text
    .abicalls
    .align 2

    .globl matrix_multiply_2
    .ent matrix_multiply_2

matrix_multiply_2:
    .frame $fp, STACK_SIZE, ra
    .set    noreorder
    .cpload t9
    .set    reorder

    subu sp, sp, STACK_SIZE     #construccion stack

    .cprestore OFFSET_GP        #guardo gp en el stack
    sw $fp, OFFSET_FP(sp)       #guardo fp en el stack
    sw ra, OFFSET_RA(sp)        #guardo ra en el stack, esto tal vez no sea necesario

    move $fp, sp

    sw a0, 56($fp)
    sw a1, 60($fp)

    lw t0, 56($fp)       #matrix 1->t0
    lw t1, 60($fp)       #matrix 2->t1

    lw t2, 0(t0)        #matrix_1->rows -> t2
    lw t3, 4(t1)        #matrix_2->cols -> t3

    move a0, t2
    move a1, t3
    jal create_matrix

    sw v0, 36($fp)   #result
    sw t0, 16($fp)   #i

first_for:
    lw t0, 16($fp)      #t0 = i
    lw t1, 56($fp)
    lw t2, 0(t1)        #t2 = matrix1->rows, es neceisario esto???
    bge t2, t0, fin

    li t1, 0            #j
    sw t1, 20($fp)

second_for:
    lw t0, 20($fp)      #t0 = j
    lw t1, 60($fp)
    lw t2, 4(t1)        #t2 = matrix2->cols
    bge t2, t0, first_for

    l.d $f4, double_zero
    s.d $f4, 28($fp)      #acum

    li t1, 0
    sw t1, 24($fp)      #k

third_for:
    lw t0, 16($fp)  #i
    lw t1, 20($fp)  #j
    lw t2, 24($fp)  #k


    lw t3, 56($fp)  #matrix1
    lw t4, 60($fp)  #matrix2

    lw t5, 4(t3)    #matrix1->cols
    mul t5, t5, t0  #matrix1->cols * i
    addu t5, t5, t2 #matrix1->cols * i + k

    #matrix->array[cols * i + k]
    addi t6, t3, 8
    addu t6, t6, t5
    l.d $f4, 0(t6)

    lw t5, 4(t4)    #matrix2->cols
    mul t5, t5, t2  #cols * k
    addu t5, t5, t1 #cols * k + j

    #matrix->array[cols * k + j]
    addi t6, t4, 8
    addu t6, t6, t5
    l.d $f6, 0(t6)

    mul.d $f4, $f4, $f6

    l.d $f8, 28($fp)    #acum

    add.d $f4, $f8, $f4 #acum + matrix2->array[cols * k + j] * matrix1->array[cols*i + k]
    s.d $f4, 28($fp)

    lw t0, 24($fp)
    addi t0, t0, 1 #k + 1
    sw t0, 24($fp)

    lw t1, 54($fp)
    lw t1, 4(t1)    #matrix1->cols
    bge t1, t0, third_for

    lw t0, 36($fp)  #result
    lw t1, 4(t0)    #result->cols
    lw t2, 16($fp)  #i
    lw t3, 20($fp)  #j
    mul t1, t1, t2
    addu t1, t1, t3

    #addi t0, 8(t0)
    #addu t0, 0(t1) #result->array[cols * i + j]
    l.d $f4, 28($fp)
    s.d $f4, 0(t0)
    b second_for

fin:
    lw v0, 36($fp)
    lw gp, OFFSET_GP(sp)
    lw $fp, OFFSET_FP(sp)
    lw ra, OFFSET_RA(sp)

    addu sp,sp, STACK_SIZE

    jr  ra

    .end matrix_multiply_2