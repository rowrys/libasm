bits 64
global ft_atoi_base
global _start

extern ft_strlen
extern ft_bzero

%define BUFFER_SIZE 256

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
;r10 -> len of base
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
	mov rdi, [rsp]			; get len of base an stor it into r10 for later
	call ft_strlen
	mov r10, rax
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
	
	lea rdx, [rcx + 1]
	mov byte [r8], dl	; put in buffer[str[i]] = i + 1

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
	xor eax, eax	; reste rax to only use al
	xor edx, edx	; store the result of the main loop
.mainLoop:
	mov al, byte [rdi]		; load in al str[i]
	test al, al
	je .endMainLoop

	lea rcx, [rsp + 16]		; load in cl buffer[str[i]]
	add rcx, rax
	movzx rcx, byte [rcx]
	test cl, cl
	je .error				; if cl == 0, the current char str[i] isnt present in the base

	mov rax, r10
	mul edx					; result * r8 (str lenght)
	mov rdx, rax

	dec ecx					; dec buffer[str[i]] because we store i + 1
	add edx, ecx

	inc rdi
	jmp .mainLoop
.endMainLoop:
	mov rax, rdx
	jmp .done
.error:
	mov rax, 0
.done:
	mov rcx, rax
	neg rcx
	cmp byte [rsp + 16], -1
	cmove rax, rcx
	mov rsp, rbp
	pop rbp
	ret
