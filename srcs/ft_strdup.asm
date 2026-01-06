bits 64

global _ft_strdup

extern _ft_strlen
extern _ft_strcpy
extern malloc

section .text
_ft_strdup:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov [rsp], rdi
	call _ft_strlen
	mov rdi, rax
	inc rdi
	call malloc
	test rax, rax
	jz .quit
	mov rdi, rax
	mov rsi, [rsp]
	call _ft_strcpy
.quit:
	add rsp, 8
	pop rbp
	ret