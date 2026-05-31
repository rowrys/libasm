bits 64
global ft_strlen

section .text
;
;rdi -> str
;
ft_strlen:
	xor eax, eax
.loop:
	mov cl, byte [rdi + rax]
	test cl, cl
	je .quit
	inc rax
	jmp .loop
.quit:
	ret
