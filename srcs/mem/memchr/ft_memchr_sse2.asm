bits 64

global ft_simd_memchr

%include "srcs/sse2.inc"

section .text
;
; rdi -> const void *s
; rsi -> int c
; rdx -> size_t n
;
ft_simd_memchr:
	; check cross page if it cross do bytes/bytes
	xor r8, r8
	mov rax, rdi
	mov rcx, rdi
	check_cross_page rcx, vecSize, .loopRest
	movd xmm2, word esi			; set the first word of xmm2 with word of esi
	punpcklbw xmm2, xmm2		; set the seconde word to the first word
	punpcklwd xmm2, xmm2		; set the word 3 and 4 with the same value as word 1 and 2
	pshufd xmm2, xmm2, 0		; prend les 32 premiers bits et les replique dans le reste du register
	test rdi, (vecSize - 1)
	je .loopSimd
.align:
	movdqu xmm0, [rax]
	pcmpeqb xmm0, xmm2			; set all byte to NULL, except c byte value, c byte is set to 0xFF
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
	test rdx, rdx
	je .failed
	dec rdx
	movzx rcx, byte [rax]
	cmp byte sil, cl
	je .done
	inc rax
	jmp .loopRest
.failed:
	xor eax, eax
.done:
	ret
