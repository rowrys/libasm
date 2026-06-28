bits 64

global ft_strdup

extern ft_strlen
extern ft_strcpy
extern malloc

section .text
;
; rdi -> char const *str
;
ft_strdup:
	push rbx
	mov rbx, rdi
	call ft_strlen
	mov rdi, rax
	inc rdi
	call malloc wrt ..plt
	test rax, rax
	je .alloc_failed
	mov rdi, rax
	mov rsi, rbx
	pop rbx
	jmp ft_strcpy
.alloc_failed:
	pop rbx
	ret
