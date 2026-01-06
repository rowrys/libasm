bits 64
global _ft_strlen

section .text
;
;rdi -> str
;
_ft_strlen:
	xor eax, eax
.loop:
	mov cl, byte [rdi + rax]
	test cl, cl
	je .quit
	inc rax
	jmp .loop
.quit:
	ret
