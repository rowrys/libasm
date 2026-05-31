bits 64

global ft_strdup

extern ft_strlen
extern ft_strcpy
extern malloc

section .text
ft_strdup:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov [rsp], rdi
	call ft_strlen
	mov rdi, rax
	inc rdi
	call malloc wrt ..plt
	test rax, rax
	jz .quit
	mov rdi, rax
	mov rsi, [rsp]
	call ft_strcpy
.quit:
	add rsp, 8
	pop rbp
	ret