%macro println 2
    print %1, %2
    mov ah, 0Eh         
    mov al, 0Dh         
    int 10h
    mov al, 0Ah         
    int 10h
%endmacro
