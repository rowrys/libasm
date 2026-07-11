bits 64
global ft_strcpy

%include "srcs/sse2.inc"

section .text
;
;rdi -> char *dst
;rsi -> char *src
;

;
;rax -> rdi -> char* dst
;rcx -> rsi -> char* src
;
ft_strcpy:
	mov rax, rdi
	mov rcx, rsi
	can_align_both rdi, rsi, rdx, r8, vecSize, .loopRest
	mov r8, rdi
	or r8, rsi
	check_cross_page r8, vecSize, .loopRest
	pxor xmm2, xmm2
	test rdi, (vecSize - 1)
	je .loopSimd
.align:
	movdqu xmm0, [rcx]
	movdqa xmm1, xmm0
	pcmpeqb xmm1, xmm2
	pmovmskb r8d, xmm1
	test r8d, r8d
	jne .loopRest
	mov r8, rcx
	and r8, (vecSize - 1)
	mov rdx, vecSize
	sub rdx, r8
	movdqu [rax], xmm0
	add rax, rdx
	add rcx, rdx
.loopSimd:
	movdqa xmm0, [rcx]
	movdqa xmm1, xmm0
	pcmpeqb xmm1, xmm2
	pmovmskb r8d, xmm1
	test r8d, r8d
	jne .loopRest
	movdqa [rax], xmm0
	add rax, vecSize
	add rcx, vecSize
	jmp .loopSimd
.loopRest:
	movzx rdx, byte [rcx]
	mov byte [rax], dl
	test dl, dl
	je .done
	inc rax
	inc rcx
	jmp .loopRest
.done:
	mov rax, rdi
	ret
