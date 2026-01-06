bits 64
global _ft_strcmp

section .text
;
;rdi -> char *s1
;rsi -> char *s2
;
_ft_strcmp:
	xor ecx, ecx
	xor eax, eax
.loop:
	mov al, byte [rdi + rcx]
	cmp al, byte [rsi + rcx]
	jne .quit
	test al, al
	je .quit
	inc rcx
	jmp .loop
.quit:
	sub al, byte [rsi + rcx]
	ret
