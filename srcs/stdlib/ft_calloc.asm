bits 64

global ft_calloc

extern malloc
extern ft_bzero

section .text
;
;rdi -> size_t nmemb
;rsi -> size_t size_t size
;
ft_calloc:
	push rbx
	mov rax, rsi
	mul rdi
	jo .failed
	mov rbx, rax
	mov rdi, rax
	call malloc wrt ..plt
	test rax, rax
	je .failed
	mov rdi, rax
	mov rsi, rbx
	mov rbx, rax
	call ft_bzero
	mov rax, rbx
	pop rbx
	ret
.failed:
	pop rbx
	xor eax, eax
	ret
