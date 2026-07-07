bits 64
global ft_write

extern __errno_location

section .text
;
;rdi -> int		fd
;rsi -> char	*str
;rdx -> size_t	size
;
ft_write:
	mov rax, 1
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
