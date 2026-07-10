bits 64
global ft_strlen

%include "srcs/sse2.inc"

section .text
;
;rdi -> char* str
;

ft_strlen:
	; check cross page if it cross do bytes/bytes
	mov rax, rdi
	mov rcx, rdi
	check_cross_page rcx, vecSize, .loopRest
	pxor xmm2, xmm2
	test rdi, (vecSize - 1)
	je .loopSimd
.align:
	movdqu xmm0, [rax]
	pcmpeqb xmm0, xmm2			; set all byte to NULL, except NULL byte, NULL byte is set to 0xFF
	pmovmskb ecx, xmm0
	test ecx, ecx
	jne .loopRest
	mov rcx, rdi
	and rcx, (vecSize - 1)
	mov rdx, vecSize
	sub rdx, rcx
	add rax, rdx
.loopSimd:
	movdqa xmm0, [rax]
	pcmpeqb xmm0, xmm2
	pmovmskb ecx, xmm0
	test ecx, ecx
	jne .loopRest
	add rax, vecSize
	jmp .loopSimd
.loopRest:
	movzx rcx, byte [rax]
	test cl, cl
	je .done
	inc rax
	jmp .loopRest
.done:
	sub rax, rdi
	ret
