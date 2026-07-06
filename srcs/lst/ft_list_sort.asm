bits 64
global ft_list_sort

%include "srcs/lst/lst.inc"

%macro prolog 0
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8
%endmacro

%macro epilog 0
	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
%endmacro

section .text
;
;rdi -> t_list **begin_list
;rsi -> int (*cmp)()
;r12 -> lst
;r13 -> lst2
;r14 -> lst_min
;r15 -> cmp
;

ft_list_sort:
	test rdi, rdi
	je .done
	test rsi, rsi
	je .done
	prolog
	mov r15, rsi
	mov r12, qword [rdi]
.loop:
	test r12, r12
	je .quit
	mov r14, r12
	mov r13, qword [r12 + t_lst.next]
.internalLoop:
	test r13, r13
	je .endInternalLoop
	mov rdi, qword [r14 + t_lst.data]
	mov rsi, qword [r13 + t_lst.data]
	call r15
	cmp eax, 0
	jle .nextInternalLoop
	mov r14, r13
.nextInternalLoop:
	mov r13, qword [r13 + t_lst.next]
	jmp .internalLoop
.endInternalLoop:
	mov rdi, qword [r12 + t_lst.data]
	mov rsi, qword [r14 + t_lst.data]
	mov qword [r12 + t_lst.data], rsi
	mov qword [r14 + t_lst.data], rdi
	mov r12, qword [r12 + t_lst.next]
	jmp .loop
.quit:
	epilog
.done:
	ret
