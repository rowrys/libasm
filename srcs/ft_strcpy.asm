bits 64
global ft_strcpy

section .text
;
;rdi -> char *dst
;rsi -> char *src
;
ft_strcpy:
	xor eax, eax
.loop:
	mov cl, byte [rsi + rax]
	mov byte [rdi + rax], cl
	test cl, cl
	je .quit
	inc rax
	jmp .loop
.quit:
	mov rax, rdi
	ret
