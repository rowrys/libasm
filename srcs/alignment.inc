
%define pageSize 4096

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

;
;%1 -> void*
;%2 -> scratch register
;%3 -> vecSize
;%4 -> label to jmp if cross page can occur
;
%macro check_cross_page 4
	mov %2, %1
	and %2, (pageSize - 1)
	add %2, $3
	cmp %2, pageSize
	ja %4
%endmacro
