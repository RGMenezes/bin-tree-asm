; print genérico: %1 = tipo (string/int), %2 = valor
%macro print 2
    mov ax, 07C0h
    add ax, 288        ; stack: (4096 + 512) / 16
    mov ss, ax
    mov sp, 4096

    mov ax, 07C0h
    mov ds, ax

    %ifidn %1, string
        mov si, %2
        call printString
    %elifidn %1, int
        mov ax, [%2]
        call printInt
    %else
        %error "Type invalid to print!"
    %endif
%endmacro
