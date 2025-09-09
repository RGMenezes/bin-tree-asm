%macro print 1
	mov ax, 07C0h
	add ax, 288		; (4096 + 512) / 16 bytes por parágrafo
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h
	mov ds, ax

    mov si, %1
    call print_string
%endmacro