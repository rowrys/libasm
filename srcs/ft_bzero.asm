bits 64
global ft_bzero

;
; for the moment a assume you have ERMSB in you processor.
;
section .text
;
;rdi -> ptr
;rsi -> n byte
;

ft_bzero:
	mov rcx, rsi
	xor eax, eax
	rep stosb
	ret
