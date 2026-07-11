bits 64
global ft_strcmp

%include "srcs/sse2.inc"

section .text
;
;rdi -> char *s1
;rsi -> char *s2
;

ft_strcmp:
	can_align_both rdi, rsi, rcx, rax, vecSize, .loopRest
	mov rcx, rdi
	or rcx, rsi
	check_cross_page rcx, vecSize, .loopRest
	pxor xmm3, xmm3
	test rdi, (vecSize - 1)
	je .loopSimd
.align:
	movdqu xmm0, [rdi]
	movdqa xmm2, xmm0
	pcmpeqb xmm2, xmm3		; check for null byte in rdi
	pmovmskb ecx, xmm2
	test ecx, ecx
	jne .loopRest
	movdqu xmm1, [rsi]
	pcmpeqb xmm0, xmm1		; check for diff  between s1 and s2
	pmovmskb ecx, xmm0
	cmp cx, -1
	jne .loopRest
	mov rcx, rdi
	and rcx, (vecSize - 1)
	mov rdx, vecSize
	sub rdx, rcx
	add rdi, rdx
	add rsi, rdx
.loopSimd:
	movdqa xmm0, [rdi]
	movdqa xmm2, xmm0
	pcmpeqb xmm2, xmm3		; check for null byte in rdi
	pmovmskb ecx, xmm2
	test ecx, ecx
	jne .loopRest
	pcmpeqb xmm0, [rsi]		; check for diff  between s1 and s2
	pmovmskb ecx, xmm0
	cmp cx, -1
	jne .loopRest
	add rdi, vecSize
	add rsi, vecSize
	jmp .loopSimd
.loopRest:
	movzx rax, byte [rdi]
	test al, al
	je .done
	movzx rdx, byte [rsi]
	cmp al, dl
	jne .done
	inc rdi
	inc rsi
	jmp .loopRest
.done:
	movzx rdx, byte [rsi]
	sub eax, edx
	ret
