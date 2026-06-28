bits 64
global ft_atoi_base
global _start

; extern ft_bzero
%include "ft_bzero.asm"

%define BUFFER_SIZE 256

section .rodata
	strr db "100", 0
	base db "0123456789ABCDEF", 0
;
;r8 -> 	param 0
;r9 -> 	param 1
;r10 ->	sign
;r11 ->
;rdx
;rcx
;
section .text


;
;rdi -> str
;rsi -> base
;
ft_atoi_base:
	push rbp
	mov rbp, rsp
	sub rsp, BUFFER_SIZE
	push rdi
	push rsi
.initBuffer:
	lea rdi, [rsp + 16]		; lea buffer
	mov rsi, BUFFER_SIZE
	call ft_bzero
	mov rsi, [rsp]			; mov second param
	mov rdi, [rsp + 8]		; mov first param
	xor ecx, ecx
.loopInitBuffer:
	mov al, byte [rsi + rcx]
	test al, al
	je .endLoopInitBuffer

	; check whitespace
	cmp al, ' '
	je .error
	sub al, 9		; 9 <= whitespace <= 13
	cmp al, 13
	jbe .error

	; check sign
	sub al, 34		; '+' == 43 == (9 + 34)
	test al, al
	je .error
	cmp al, 2		; '-' = 45; 45 - 43 = 2
	je .error
	add al, 43		; restore al
	
	;check doublon
	lea r8, [rsp + 16]	; lea buffer
	add r8b, al
	mov dl, byte [r8]
	test dl, dl
	jne .error
	
	mov byte [r8], al	; put in buffer base[i]

	inc rcx
	jmp .loopInitBuffer
.endLoopInitBuffer:
	cmp rcx, 2
	jb .error
	xor eax, eax
	jmp .done
.error:
	mov rax, 1
.done:
	mov rsp, rbp
	pop rbp
	ret

_start:
	lea rdi, strr
	lea rsi, base
	call ft_atoi_base

	mov rdi, rax
	mov rax, 60
	syscall
