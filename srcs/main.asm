bits 64
global main

extern _ft_strlen
extern _ft_strcpy
extern _ft_strcmp
extern _ft_strdup
extern _ft_write
extern _ft_read

%define size_dangerous_buffer 1

section .rodata
	str_test_back db "test", 10, 0
	str_test_back_len equ $-str_test_back
	str_test db "test", 0
	str_empty db 0

section .data
	dst_strcpy db "0123456789", 0

section .bss
	dangerous_buffer resb size_dangerous_buffer
 
section .text

main:
	; mov rdi, str_test
	; call _ft_strlen

	; mov rdi, dst_strcpy
	; mov rsi, str_test
	; call _ft_strcpy
	
	; mov rdi, str_test_back
	; mov rsi, str_test
	; call _ft_strcmp
	
	; mov rdi, 1
	; mov rsi, str_test_back
	; mov rdx, str_test_back_len
	; call _ft_write

	; mov rdi, 0
	; mov rsi, dangerous_buffer
	; mov rdx, size_dangerous_buffer
	; call _ft_read

	; mov rdi, str_test_back
	; call _ft_strdup
	jmp .exit

.exit:
	mov rax, 60
	xor rdi, rdi
	syscall
