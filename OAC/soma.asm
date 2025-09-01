org 0x7c00

    mov al, 5
    mov bl, 1
    call sum

    add al, '0'      
    mov ah, 0x0F    
    mov di, 2080
    call print

    mov al, 1
    mov bl, 2
    call sum

    add al, '0'      
    mov ah, 0x0F    
    mov di, 2240
    call print

loop:
    jmp loop

sum:
    add al, bl
    ret

print:
    push ax
    push bx
    push es

    mov bx, 0xB800
    mov es, bx
    pop bx
    mov [es:di], ax

    pop bx
    pop ax
    ret 

times 510-($-$$) db 0
dw 0xAA55