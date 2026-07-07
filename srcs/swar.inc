
%define lowMask 0x0101010101010101
%define highMask 0x8080808080808080

;
;%1 -> first void*
;%2 -> second void*
;%3 -> scratch register
;%4 -> scratch register
;%5 -> label to jmp if it no possible to align
;
%macro can_align_both 5
	mov %3, %1
	mov %4, %2
	and %3, 7
	and %4, 7
	cmp %3, %4
	jne %5
%endmacro
