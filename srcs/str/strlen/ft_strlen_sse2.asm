bits 64
global ft_strlen

%define pageSize 4096
%define vecSize 16

section .text
;
;rdi -> char* str
;

ft_strlen:
	; check cross page if it cross do bytes/bytes
	mov rax, rdi
	mov rcx, rdi
	and rcx, (pageSize - 1)
	add rcx, vecSize
	cmp rcx, pageSize
	ja .loopRest
.align:
	; set mask vec
	pxor xmm2, xmm2				; disable all bits of xmm2
	; make the first read, unalign to align it.
	movdqu xmm0, [rax]
	pcmpeqb xmm0, xmm2			; set all byte to NULL, except NULL byte, NULL byte is set to 0xFF
	pmovmskb ecx, xmm0
	test ecx, ecx
	jne .loopRest
	mov rcx, rdi
	and rcx, (vecSize - 1)
	mov rdx, 16
	sub rdx, rcx
	add rax, rdx
.loopSimd:
	movdqa xmm0, [rax]
	pcmpeqb xmm0, xmm2			; set all byte to NULL, except NULL byte, NULL byte is set to 0xFF
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
