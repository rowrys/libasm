
%define pageSize 4096

;
;%1 -> first void*
;%2 -> second void*
;%3 -> scratch register
;%4 -> scratch register
;%5 -> alignement require
;%6 -> label to jmp if it no possible to align
;
%macro can_align_both 6
	mov %3, %1
	mov %4, %2
	and %3, (%5 - 1)
	and %4, (%5 - 1)
	cmp %3, %4
	jne %6
%endmacro

;
;%1 -> scratch register
;%2 -> vecSize
;%3 -> label to jmp if cross page can occur
;
%macro check_cross_page 3
	and %1, (pageSize - 1)
	cmp %1, pageSize - %2
	ja %3
%endmacro
