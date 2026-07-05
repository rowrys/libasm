bits 64
global ft_strcpy

%define lowMask 0x0101010101010101
%define highMask 0x8080808080808080

section .text
;
;rdi -> char *dst
;rsi -> char *src
;

ft_strcpy:
	mov rax, rdi
	mov r8, rsi
	mov r9, lowMask
	mov r10, highMask
.loopAlign:
	test rax, 7
	je .loopSwar
	movzx rcx, byte [r8]
	mov byte [rax], cl
	test cl, cl
	je .done
	inc rax
	inc r8
	jmp .loopAlign
.loopSwar:
	mov rcx, qword [r8]
	mov rdx, rcx
	not rdx
	sub rcx, r9
	and rcx, rdx
	test rcx, r10
	jne .loopRest
	not rdx
	mov qword [rax], rdx
	add rax, 8
	add r8, 8
	jmp .loopSwar
.loopRest:
	movzx rcx, byte [r8]
	mov byte [rax], cl
	test cl, cl
	je .done
	inc rax
	inc r8
	jmp .loopRest
.done:
	mov rax, rdi
	ret

; ft_strcpy:
; 	xor eax, eax
; .loop:
; 	mov cl, byte [rsi + rax]
; 	mov byte [rdi + rax], cl
; 	test cl, cl
; 	je .quit
; 	inc rax
; 	jmp .loop
; .quit:
; 	mov rax, rdi
; 	ret
