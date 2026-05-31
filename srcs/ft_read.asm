bits 64
global ft_read

extern __errno_location

section .text
;
;rdi -> int		fd
;rsi -> char	*buffer
;rdx -> size_t	size
;
ft_read:
	xor eax, eax	;set rax to 0
	syscall
	test rax, rax
	jge .quit
	neg rax
	mov rdi, rax
	call __errno_location wrt ..plt
    mov [rax], rdi
	mov rax, -1
.quit:
	ret
