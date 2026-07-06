bits 64
global ft_list_size

%include "srcs/lst/lst.inc"

section .text
;
;rdi -> t_list* begin_list
;

ft_list_size:
	xor eax, eax
.loop:
	test rdi, rdi
	je .done
	inc rax
	mov rdi, qword [rdi + t_lst.next]
	jmp .loop
.done:
	ret
