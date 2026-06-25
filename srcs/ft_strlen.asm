bits 64
global ft_strlen

section .text
;
;rdi -> str
;
ft_strlen:
	mov rax, rdi
.loop
	mov cl, byte [rax]
	test cl, cl
	je .done
	inc rax
	jmp .loop
.done:
	sub rax, rdi
	ret
