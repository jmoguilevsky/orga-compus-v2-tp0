	.file	1 "dynamic.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	init_buffer
	.ent	init_buffer
init_buffer:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$a0,40($fp)
	lw	$a1,40($fp)
	la	$t9,calloc
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	init_buffer
	.size	init_buffer, .-init_buffer
	.align	2
	.globl	push
	.ent	push
push:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	move	$v0,$a1
	sw	$a2,64($fp)
	sw	$a3,68($fp)
	sb	$v0,24($fp)
	lw	$v1,64($fp)
	lw	$v0,64($fp)
	lw	$v0,0($v0)
	addu	$v0,$v0,1
	sw	$v0,0($v1)
	lw	$v0,64($fp)
	lw	$v1,68($fp)
	lw	$a0,0($v0)
	lw	$v0,0($v1)
	sltu	$v0,$a0,$v0
	bne	$v0,$zero,$L19
	lw	$v1,68($fp)
	lw	$v0,68($fp)
	lw	$v0,0($v0)
	sll	$v0,$v0,1
	sw	$v0,0($v1)
	lw	$v0,68($fp)
	lw	$a0,56($fp)
	lw	$a1,0($v0)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,64($fp)
	lw	$v1,28($fp)
	lw	$v0,0($v0)
	addu	$v0,$v1,$v0
	addu	$v1,$v0,-1
	lbu	$v0,24($fp)
	sb	$v0,0($v1)
	lw	$v0,28($fp)
	sw	$v0,32($fp)
	b	$L18
$L19:
	lw	$v0,64($fp)
	lw	$v1,56($fp)
	lw	$v0,0($v0)
	addu	$v0,$v1,$v0
	addu	$v1,$v0,-1
	lbu	$v0,24($fp)
	sb	$v0,0($v1)
	lw	$v0,56($fp)
	sw	$v0,32($fp)
$L18:
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	push
	.size	push, .-push
	.align	2
	.globl	create_matrix
	.ent	create_matrix
create_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	li	$a0,12			# 0xc
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v1,52($fp)
	lw	$v0,48($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v1,24($fp)
	lw	$v0,28($fp)
	sw	$v0,8($v1)
	lw	$v1,24($fp)
	lw	$v0,52($fp)
	sw	$v0,4($v1)
	lw	$v1,24($fp)
	lw	$v0,48($fp)
	sw	$v0,0($v1)
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	create_matrix
	.size	create_matrix, .-create_matrix
	.rdata
	.align	2
$LC0:
	.ascii	"%.10g\n\000"
	.align	2
$LC1:
	.ascii	"%.10g \000"
	.align	2
$LC2:
	.ascii	"Error writing to file\n\000"
	.text
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	lw	$v0,68($fp)
	lw	$v1,68($fp)
	lw	$a0,0($v0)
	lw	$v0,4($v1)
	mult	$a0,$v0
	mflo	$v0
	sw	$v0,24($fp)
	sw	$zero,28($fp)
$L22:
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L25
	b	$L23
$L25:
	lw	$v0,24($fp)
	addu	$v1,$v0,-1
	lw	$v0,28($fp)
	bne	$v0,$v1,$L26
	la	$v0,$LC0
	sw	$v0,44($fp)
	b	$L27
$L26:
	la	$v0,$LC1
	sw	$v0,44($fp)
$L27:
	lw	$v0,44($fp)
	sw	$v0,32($fp)
	lw	$a0,68($fp)
	lw	$v0,28($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	lw	$a0,64($fp)
	lw	$a1,32($fp)
	lw	$a2,0($v0)
	lw	$a3,4($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bgez	$v0,$L24
	la	$a0,__sF+176
	la	$a1,$LC2
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$v0,36($fp)
	sw	$v0,40($fp)
	b	$L21
$L24:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L22
$L23:
	lw	$v0,24($fp)
	sw	$v0,40($fp)
$L21:
	lw	$v0,40($fp)
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	print_matrix
	.size	print_matrix, .-print_matrix
	.align	2
	.globl	matrix_multiply
	.ent	matrix_multiply
matrix_multiply:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	lw	$v0,72($fp)
	lw	$v1,76($fp)
	lw	$a0,0($v0)
	lw	$a1,4($v1)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,24($fp)
	sw	$zero,28($fp)
$L30:
	lw	$v0,72($fp)
	lw	$v1,28($fp)
	lw	$v0,0($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L33
	b	$L31
$L33:
	sw	$zero,32($fp)
$L34:
	lw	$v0,76($fp)
	lw	$v1,32($fp)
	lw	$v0,4($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L37
	b	$L32
$L37:
	sw	$zero,40($fp)
	sw	$zero,44($fp)
	sw	$zero,48($fp)
$L38:
	lw	$v0,72($fp)
	lw	$v1,48($fp)
	lw	$v0,4($v0)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L41
	b	$L39
$L41:
	lw	$a0,72($fp)
	lw	$v0,72($fp)
	lw	$v1,4($v0)
	lw	$v0,28($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,48($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$a1,$v1,$v0
	lw	$a0,76($fp)
	lw	$v0,76($fp)
	lw	$v1,4($v0)
	lw	$v0,48($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,32($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f2,0($a1)
	l.d	$f0,0($v0)
	mul.d	$f2,$f2,$f0
	l.d	$f0,40($fp)
	add.d	$f0,$f0,$f2
	s.d	$f0,40($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L38
$L39:
	lw	$a0,24($fp)
	lw	$v0,24($fp)
	lw	$v1,4($v0)
	lw	$v0,28($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,32($fp)
	addu	$v0,$v1,$v0
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,40($fp)
	s.d	$f0,0($v0)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L34
$L32:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L30
$L31:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	matrix_multiply
	.size	matrix_multiply, .-matrix_multiply
	.align	2
	.globl	destroy_matrix
	.ent	destroy_matrix
destroy_matrix:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	destroy_matrix
	.size	destroy_matrix, .-destroy_matrix
	.rdata
	.align	2
$LC3:
	.ascii	"%lG\000"
	.text
	.align	2
	.globl	get_value
	.ent	get_value
get_value:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	sw	$a2,80($fp)
	sb	$zero,25($fp)
	sw	$zero,28($fp)
	li	$v0,2			# 0x2
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,init_buffer
	jal	$ra,$t9
	sw	$v0,36($fp)
$L44:
	lbu	$v0,25($fp)
	beq	$v0,$zero,$L46
	b	$L45
$L46:
	lw	$v0,__sF+4
	addu	$v0,$v0,-1
	sw	$v0,__sF+4
	bgez	$v0,$L47
	la	$a0,__sF
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,48($fp)
	b	$L48
$L47:
	la	$v0,__sF
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,48($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L48:
	lbu	$v0,48($fp)
	sb	$v0,24($fp)
	lb	$v1,24($fp)
	li	$v0,32			# 0x20
	beq	$v1,$v0,$L50
	lb	$v1,24($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L50
	lb	$v1,24($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L50
	b	$L49
$L50:
	lw	$v1,76($fp)
	lb	$v0,24($fp)
	xori	$v0,$v0,0xa
	sltu	$v0,$v0,1
	sb	$v0,0($v1)
	lw	$a0,80($fp)
	lb	$v1,24($fp)
	li	$v0,-1			# 0xffffffffffffffff
	xor	$v0,$v1,$v0
	sltu	$v0,$v0,1
	sb	$v0,0($a0)
	li	$v0,1			# 0x1
	sb	$v0,25($fp)
	b	$L44
$L49:
	lb	$v0,24($fp)
	addu	$v1,$fp,28
	addu	$a3,$fp,32
	lw	$a0,36($fp)
	move	$a1,$v0
	move	$a2,$v1
	la	$t9,push
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	sw	$v0,36($fp)
	b	$L44
$L45:
	lw	$v0,28($fp)
	beq	$v0,$zero,$L52
	lw	$v1,36($fp)
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$a0,36($fp)
	la	$a1,$LC3
	lw	$a2,72($fp)
	la	$t9,sscanf
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L52
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,44($fp)
	b	$L43
$L52:
	lw	$a0,36($fp)
	la	$t9,free
	jal	$ra,$t9
	lw	$v0,28($fp)
	sw	$v0,44($fp)
$L43:
	lw	$v0,44($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	get_value
	.size	get_value, .-get_value
	.rdata
	.align	2
$LC4:
	.ascii	"Invalid format, cannot read matrix\n\000"
	.text
	.align	2
	.globl	read_matrix
	.ent	read_matrix
read_matrix:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$a2,72($fp)
	sw	$a3,76($fp)
	sw	$zero,40($fp)
$L55:
	lw	$v1,68($fp)
	lw	$v0,68($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,40($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L58
	b	$L56
$L58:
	addu	$v0,$fp,32
	move	$a0,$v0
	lw	$a1,72($fp)
	lw	$a2,76($fp)
	la	$t9,get_value
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bltz	$v0,$L60
	lw	$v0,24($fp)
	bne	$v0,$zero,$L59
	lw	$v0,72($fp)
	lbu	$v0,0($v0)
	bne	$v0,$zero,$L60
	lw	$v0,76($fp)
	lbu	$v0,0($v0)
	bne	$v0,$zero,$L60
	b	$L59
$L60:
	la	$a0,__sF+176
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,44($fp)
	b	$L54
$L59:
	lw	$a0,64($fp)
	lw	$v0,40($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	l.d	$f0,32($fp)
	s.d	$f0,0($v0)
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	b	$L55
$L56:
	sw	$zero,44($fp)
$L54:
	lw	$v0,44($fp)
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	read_matrix
	.size	read_matrix, .-read_matrix
	.rdata
	.align	2
$LC6:
	.ascii	"%zu \000"
	.align	3
$LC5:
	.word	0
	.word	1105199104
	.text
	.align	2
	.globl	process_line
	.ent	process_line
process_line:
	.frame	$fp,104,$ra		# vars= 64, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,104
	.cprestore 16
	sw	$ra,96($sp)
	sw	$fp,92($sp)
	sw	$gp,88($sp)
	move	$fp,$sp
	sb	$zero,40($fp)
	sb	$zero,41($fp)
	addu	$v0,$fp,40
	addu	$v1,$fp,41
	addu	$a0,$fp,24
	move	$a1,$v0
	move	$a2,$v1
	la	$t9,get_value
	jal	$ra,$t9
	sw	$v0,32($fp)
	lbu	$v0,41($fp)
	beq	$v0,$zero,$L63
	la	$a0,__sF+176
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,2			# 0x2
	sw	$v0,60($fp)
	b	$L62
$L63:
	lbu	$v0,40($fp)
	beq	$v0,$zero,$L64
	la	$a0,__sF+176
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v1,2			# 0x2
	sw	$v1,60($fp)
	b	$L62
$L64:
	lw	$v0,32($fp)
	bgtz	$v0,$L65
	la	$a0,__sF+176
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,2			# 0x2
	sw	$a0,60($fp)
	b	$L62
$L65:
	l.d	$f0,24($fp)
	s.d	$f0,64($fp)
	l.d	$f2,$LC5
	s.d	$f2,80($fp)
	l.d	$f4,64($fp)
	l.d	$f0,80($fp)
	c.le.d	$f0,$f4
	bc1t	$L66
	l.d	$f0,64($fp)
	trunc.w.d $f0,$f0,$v0
	s.s	$f0,72($fp)
	b	$L67
$L66:
	l.d	$f2,64($fp)
	l.d	$f4,80($fp)
	sub.d	$f0,$f2,$f4
	li	$v0,-2147483648			# 0xffffffff80000000
	trunc.w.d $f2,$f0,$a0
	s.s	$f2,72($fp)
	lw	$v1,72($fp)
	or	$v1,$v1,$v0
	sw	$v1,72($fp)
$L67:
	lw	$a0,72($fp)
	sw	$a0,36($fp)
	lw	$a0,36($fp)
	lw	$a1,36($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,48($fp)
	addu	$v0,$fp,40
	addu	$v1,$fp,41
	lw	$a0,48($fp)
	lw	$a1,36($fp)
	move	$a2,$v0
	move	$a3,$v1
	la	$t9,read_matrix
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v1,44($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L68
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	li	$a1,2			# 0x2
	sw	$a1,60($fp)
	b	$L62
$L68:
	lw	$a0,36($fp)
	lw	$a1,36($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,52($fp)
	addu	$v0,$fp,40
	addu	$v1,$fp,41
	lw	$a0,52($fp)
	lw	$a1,36($fp)
	move	$a2,$v0
	move	$a3,$v1
	la	$t9,read_matrix
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v1,44($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L69
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,52($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	li	$v0,2			# 0x2
	sw	$v0,60($fp)
	b	$L62
$L69:
	lbu	$v0,40($fp)
	bne	$v0,$zero,$L70
	lbu	$v0,41($fp)
	bne	$v0,$zero,$L70
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,52($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC4
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v1,2			# 0x2
	sw	$v1,60($fp)
	b	$L62
$L70:
	lw	$a0,48($fp)
	lw	$a1,52($fp)
	la	$t9,matrix_multiply
	jal	$ra,$t9
	sw	$v0,56($fp)
	la	$a0,$LC6
	lw	$a1,36($fp)
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,__sF+88
	lw	$a1,56($fp)
	la	$t9,print_matrix
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,52($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,56($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	sw	$zero,60($fp)
$L62:
	lw	$v0,60($fp)
	move	$sp,$fp
	lw	$ra,96($sp)
	lw	$fp,92($sp)
	addu	$sp,$sp,104
	j	$ra
	.end	process_line
	.size	process_line, .-process_line
	.rdata
	.align	2
$LC10:
	.ascii	" -V\000"
	.align	2
$LC11:
	.ascii	" < in_file > out_file\000"
	.align	2
$LC7:
	.ascii	"%s\n"
	.ascii	"\t%s%s\n"
	.ascii	"\t%s%s\n"
	.ascii	"\t%s%s\n\000"
	.align	2
$LC8:
	.ascii	"Usage:\000"
	.align	2
$LC9:
	.ascii	" -h\000"
	.text
	.align	2
	.ent	print_usage
print_usage:
	.frame	$fp,56,$ra		# vars= 0, regs= 3/0, args= 32, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 32
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	lw	$v0,56($fp)
	sw	$v0,16($sp)
	la	$v0,$LC10
	sw	$v0,20($sp)
	lw	$v0,56($fp)
	sw	$v0,24($sp)
	la	$v0,$LC11
	sw	$v0,28($sp)
	la	$a0,$LC7
	la	$a1,$LC8
	lw	$a2,56($fp)
	la	$a3,$LC9
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	print_usage
	.size	print_usage, .-print_usage
	.rdata
	.align	2
$LC16:
	.ascii	"Examples:\000"
	.align	2
$LC17:
	.ascii	"\t\000"
	.align	2
$LC18:
	.ascii	"tp0 < in.txt > out.txt\000"
	.align	2
$LC19:
	.ascii	"\tcat in.txt \000"
	.align	2
$LC20:
	.ascii	" | tp0 > out.txt\000"
	.align	2
$LC12:
	.ascii	"%s\n"
	.ascii	"%s\n"
	.ascii	"%s\n"
	.ascii	"%s\n"
	.ascii	"%s%s\t%s\n"
	.ascii	"%s%s%s\n\000"
	.align	2
$LC13:
	.ascii	"Options:\000"
	.align	2
$LC14:
	.ascii	"\t-V, --version\tProgram version.\000"
	.align	2
$LC15:
	.ascii	"\t-h, --help\tPrint help.\000"
	.text
	.align	2
	.ent	print_options
print_options:
	.frame	$fp,72,$ra		# vars= 0, regs= 3/0, args= 48, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 48
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	la	$v0,$LC16
	sw	$v0,16($sp)
	la	$v0,$LC17
	sw	$v0,20($sp)
	lw	$v0,72($fp)
	sw	$v0,24($sp)
	la	$v0,$LC18
	sw	$v0,28($sp)
	la	$v0,$LC19
	sw	$v0,32($sp)
	lw	$v0,72($fp)
	sw	$v0,36($sp)
	la	$v0,$LC20
	sw	$v0,40($sp)
	la	$a0,$LC12
	la	$a1,$LC13
	la	$a2,$LC14
	la	$a3,$LC15
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	print_options
	.size	print_options, .-print_options
	.align	2
	.ent	print_help
print_help:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$a0,40($fp)
	la	$t9,print_usage
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,print_options
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	print_help
	.size	print_help, .-print_help
	.rdata
	.align	2
$LC21:
	.ascii	"Version %s\n\000"
	.align	2
$LC22:
	.ascii	"1.0.0\000"
	.text
	.align	2
	.ent	print_version
print_version:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC21
	la	$a1,$LC22
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	print_version
	.size	print_version, .-print_version
	.rdata
	.align	2
$LC24:
	.ascii	"help\000"
	.align	2
$LC25:
	.ascii	"version\000"
	.data
	.align	2
	.type	long_options.0, @object
	.size	long_options.0, 48
long_options.0:
	.word	$LC24
	.word	0
	.word	0
	.word	104
	.word	$LC25
	.word	0
	.word	0
	.word	86
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC23:
	.ascii	"hV\000"
	.align	2
$LC26:
	.ascii	"Unrecognized options: \000"
	.align	2
$LC27:
	.ascii	"%s \000"
	.align	2
$LC28:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	argsHandler_parse_arguments
	.ent	argsHandler_parse_arguments
argsHandler_parse_arguments:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 24
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$zero,36($fp)
	la	$v0,$LC23
	sw	$v0,40($fp)
$L76:
	addu	$v0,$fp,36
	sw	$v0,16($sp)
	lw	$a0,64($fp)
	lw	$a1,68($fp)
	lw	$a2,40($fp)
	la	$a3,long_options.0
	la	$t9,getopt_long
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L78
	b	$L77
$L78:
	lw	$v0,32($fp)
	sw	$v0,44($fp)
	li	$v0,86			# 0x56
	lw	$v1,44($fp)
	beq	$v1,$v0,$L81
	lw	$v1,44($fp)
	slt	$v0,$v1,87
	beq	$v0,$zero,$L85
	li	$v0,63			# 0x3f
	lw	$v1,44($fp)
	beq	$v1,$v0,$L82
	b	$L76
$L85:
	li	$v0,104			# 0x68
	lw	$v1,44($fp)
	beq	$v1,$v0,$L80
	b	$L76
$L80:
	lw	$v0,68($fp)
	lw	$a0,0($v0)
	la	$t9,print_help
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L81:
	la	$t9,print_version
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L82:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L77:
	lw	$v0,optind
	lw	$v1,64($fp)
	slt	$v0,$v0,$v1
	beq	$v0,$zero,$L86
	la	$a0,__sF+176
	la	$a1,$LC26
	la	$t9,fprintf
	jal	$ra,$t9
$L87:
	lw	$v0,optind
	lw	$v1,64($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L89
	b	$L88
$L89:
	la	$a1,optind
	lw	$v1,0($a1)
	move	$v0,$v1
	sll	$a0,$v0,2
	lw	$v0,68($fp)
	addu	$v0,$a0,$v0
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	la	$a0,__sF+176
	la	$a1,$LC27
	lw	$a2,0($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L87
$L88:
	la	$a0,__sF+176
	la	$a1,$LC28
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L86:
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	argsHandler_parse_arguments
	.size	argsHandler_parse_arguments, .-argsHandler_parse_arguments
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$a0,48($fp)
	lw	$a1,52($fp)
	la	$t9,argsHandler_parse_arguments
	jal	$ra,$t9
$L91:
	la	$t9,process_line
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L92
	lw	$v1,24($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L91
$L92:
	lw	$v1,24($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L96
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,28($fp)
	b	$L90
$L96:
	sw	$zero,28($fp)
$L90:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
