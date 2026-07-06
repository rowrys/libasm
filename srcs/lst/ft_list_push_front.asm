bits 64
global ft_list_push_front

%include "srcs/lst/lst.inc"

extern malloc

section .text
;
;rdi -> t_list** begin_list
;rsi -> void* data
;

ft_list_push_front:
	push rbp
	mov rbp, rsp
	test rdi, rdi
	je .done
	push rdi
	push rsi
	mov rdi, t_lstSize
	call malloc wrt ..plt
	test rax, rax
	je .done
	pop rsi
	pop rdi
	mov qword [rax + t_lst.data], rsi
	mov rdx, [rdi]
	mov qword [rax + t_lst.next], rdx
	mov [rdi], rax
.done:
	mov rsp, rbp
	pop rbp
	ret
