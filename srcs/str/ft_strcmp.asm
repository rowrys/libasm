bits 64
global ft_strcmp

%include "srcs/swar.inc"

section .text
;
;rdi -> char *s1
;rsi -> char *s2
;

ft_strcmp:
	can_align_both rdi, rsi, rax, rcx, .loopRest
	mov r9, lowMask
	mov r10, highMask
.loopAlign:
	test rdi, 7
	je .loopSwar
	movzx rax, byte [rdi]
	test al, al
	je .done
	cmp al, byte [rsi]
	jne .done
	inc rdi
	inc rsi
	jmp .loopAlign
.loopSwar:
	mov rdx, qword [rdi]
	mov rax, rdx
	not rax
	sub rdx, r9
	and rdx, rax
	test rdx, r10
	jne .loopRest
	not rax
	cmp rax, qword [rsi]
	jne .loopRest
	add rdi, 8
	add rsi, 8
	jmp .loopSwar
.loopRest:
	movzx rax, byte [rdi]
	test al, al
	je .done
	cmp al, byte [rsi]
	jne .done
	inc rdi
	inc rsi
	jmp .loopRest
.done:
	movzx rsi, byte [rsi] 
	sub eax, esi
	ret

; ft_strcmp:
; 	xor ecx, ecx
; 	xor eax, eax
; .loop:
; 	mov al, byte [rdi + rcx]
; 	cmp al, byte [rsi + rcx]
; 	jne .quit
; 	test al, al
; 	je .quit
; 	inc rcx
; 	jmp .loop
; .quit:
; 	movzx ecx, byte [rsi + rcx]
; 	sub eax, ecx
; 	ret
