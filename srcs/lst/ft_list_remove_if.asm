bits 64

global ft_list_remove_if

%include "srcs/lst/lst.inc"

%macro prolog 0
	push r12		; current_lst
	push r13		; data ref
	push r14		; int (*cmp)()
	push r15		; void (*free_fct)(void *)
	push rbx		; prev_lst
	mov r12, qword [rdi]
	mov r13, rsi
	mov r14, rdx
	mov r15, rcx
	mov rbx, r12
%endmacro

%macro epilog 0
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
%endmacro


section .text
;
;rdi -> t_list **begin_list
;rsi -> void *data_ref
;rdx -> int (*cmp)()
;rcx -> void (*free_fct)(void *)
;
; r12 -> current_lst
; r13 -> data ref
; r14 -> int (*cmp)()
; r15 -> void (*free_fct)(void *)
; rbx -> prev_lst
;

ft_list_remove_if:
	test rdi, rdi
	je .done
	test rdx, rdx
	je .done
	test rcx, rcx
	je .done
	prolog
.loop:
	test r12, r12
	je .quit
	mov rdi, qword [r12 + t_lst.data]
	mov rsi, r13
	call r14
	test rax, rax
	jne .skip
	mov rcx, qword [r12 + t_lst.next]
	mov qword [rbx + t_lst.next], rcx
	mov rdi, r12
	mov r12, rcx
	call r15
	jmp .loop
.skip:
	mov rbx, r12
	mov r12, qword [r12 + t_lst.next]
	jmp .loop
.quit:
	epilog
.done:
	ret
