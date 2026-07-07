bits 64
global ft_strlen

%include "srcs/swar.inc"

section .text
;
;rax -> ptr
;rdi -> str
;rcx -> scratch reg
;r8  -> calcul
;r9  -> lowMask
;r10 -> highMask
;

ft_strlen:
	mov rax, rdi
	mov r9, lowMask
	mov r10, highMask
.loopAlign:
	test rax, 7
	je .loopSwar
	movzx rcx, byte [rax]
	test cl, cl
	je .done
	inc rax
	jmp .loopAlign
.loopSwar:
	mov rcx, qword [rax]
	mov r8, rcx
	not r8
	sub rcx, r9
	and rcx, r8
	test rcx, r10
	jne .loopRest
	add rax, 8
	jmp .loopSwar
.loopRest:
	movzx rcx, byte [rax]
	test cl, cl
	je .done
	inc rax
	jmp .loopRest
.done:
	sub rax, rdi
	ret

; ft_strlen:
; 	mov rax, rdi
; .loop
; 	mov cl, byte [rax]
; 	test cl, cl
; 	je .done
; 	inc rax
; 	jmp .loop
; .done:
; 	sub rax, rdi
; 	ret
