bits 64
global ft_atoi_base
global _start

; extern ft_bzero
%include "ft_bzero.asm"

%define BUFFER_SIZE 256

section .rodata
	strr db "     -100", 0
	base db "0123456789ABCDEF", 0
;
;on the stack:
;	[rsp] = rsi
;	[rsp + 8] = rdi
;	[rsp + 16] = buffer[256]
;	buffer[0] = sign
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
	cmp rcx, 2			; check if lenght of base is greater than 1 otherwise jmp .error
	jb .error
.loopSkipWhiteSpace:
	mov al, byte [rdi]

	; check whitespace
	cmp al, ' '
	je .loopSkipWhiteSpaceInc
	sub al, 9		; 9 <= whitespace <= 13
	cmp al, 13
	ja .setSignRestorAl
.loopSkipWhiteSpaceInc:
	inc rdi
	jmp .loopSkipWhiteSpace
.setSignRestorAl:
	add al, 9
.setSign:
	mov byte [rsp + 16], 1
	cmp al, '-'
	jne .skipPositifChar
	mov byte [rsp + 16], -1
	inc rdi
	jmp .getLenOfBase
.skipPositifChar:
	cmp al, '+'
	jne .getLenOfBase
	inc rdi
.getLenOfBase:
	int 0x30
	jmp .done
.error:
	mov rax, 0
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
