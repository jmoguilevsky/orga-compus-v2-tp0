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
    .align 2
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

    move t0, zero
    sw t0, 16($fp)   #i


first_for:
    lw t0, 16($fp)      #t0 = i
    lw t1, 56($fp)      #matrix1
    lw t2, 0(t1)        #t2 = matrix1->rows, es neceisario esto???

    slt t3, t0, t2      #i < rows?
    beq t3, zero, fin

    li t1, 0            #j
    sw t1, 20($fp)

second_for:
    lw t0, 20($fp)      #t0 = j
    lw t1, 60($fp)      #matrix2
    lw t2, 4(t1)        #t2 = matrix2->cols

    slt t3, t0, t2
    beq t3, zero, end_second_for

    l.d $f4, double_zero  #f4=0.0
    s.d $f4, 28($fp)      #acum=0.0

    li t1, 0
    sw t1, 24($fp)      #k=0

third_for:
    lw t0, 16($fp)  #i
    lw t1, 20($fp)  #j
    lw t2, 24($fp)  #k

    lw t3, 56($fp)  #matrix1
    lw t4, 60($fp)  #matrix2

    lw t5, 4(t4)    #matrix2->cols

    slt t7, t2, t5  #k < cols??
    beq t7, zero, end_third_for

    lw t5, 4(t3)    #matrix1->cols
    mul t5, t5, t0  #matrix1->cols * i
    addu t5, t5, t2 #matrix1->cols * i + k

    #matrix->array[cols * i + k]
    la t6, 8(t3)
    add t7, t5, t5
    add t7, t7, t7
    addu t7, t7, t6
    l.d $f4, 0(t7)

    lw t5, 4(t4)    #matrix2->cols
    mul t5, t5, t2  #cols * k
    addu t5, t5, t1 #cols * k + j

    #matrix->array[cols * k + j]
    la t6, 8(t4)
    add t7, t5, t5
    add t7, t7, t7
    addu t7, t7, t6
    l.d $f6, 0(t7)

    mul.d $f4, $f4, $f6

    l.d $f8, 28($fp)    #load acum

    add.d $f4, $f8, $f4 #acum + matrix2->array[cols * k + j] * matrix1->array[cols*i + k]
    s.d $f4, 28($fp)

    #k++
    addi t2, t2, 1
    sw t2, 24($fp)

    b third_for

end_third_for:
    lw t8, 36($fp)  #result
    lw t1, 4(t8)    #result->cols
    lw t2, 16($fp)  #i
    lw t3, 20($fp)  #j

    mul t1, t1, t2
    addu t1, t1, t3 #t1 = cols * i + j

    l.d $f4, 28($fp) #$f4 = acum

    la t4, 8(t8)
    add t1, t1, t1
    add t1, t1, t1
    addu t1, t1, t4
    la t5, 0(t1)  #result->array[cols * i + j] = acum

    s.d $f4, 0(t5)

    #j++
    lw t0, 20($fp)
    addi t0, t0, 1
    sw t0, 20($fp)

    b second_for

end_second_for:
    #i++
    lw t0, 16($fp)
    addi t0, t0, 1
    sw t0, 16($fp)
    b first_for

fin:
    lw v0, 36($fp)
    lw gp, OFFSET_GP(sp)
    lw $fp, OFFSET_FP(sp)
    lw ra, OFFSET_RA(sp)

    addu sp,sp, STACK_SIZE

    jr  ra

    .end matrix_multiply_2