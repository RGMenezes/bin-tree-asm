org 0x7c00

    mov al, 5
    mov bl, 1

    call sum
    add al, '0'      
    mov ah, 0x0F    
    mov di, 2080
    call print

    mov al, 5
    mov bl, 1

    call subtr
    add al, '0'     
    mov ah, 0x0F    
    mov di, 2120
    call print


    mov al, 1
    mov bl, 2

    call sum
    add al, '0'  
    mov ah, 0x0F    
    mov di, 2240
    call print

    mov al, 1
    mov bl, 2

    call subtr
    add al, '0'
    mov ah, 0x0F    
    mov di, 2280
    call print

loop:
    jmp loop

sum:
    add al, bl
    ret

subtr:
    sub al, bl
    cmp al, 0
    jge continue_subtr 
    neg al             
    call print_negative
continue_subtr:
    ret

print_negative:
    push ax
    push di
    mov al, '-'       
    mov ah, 0x0F
    mov di, 2278      
    call print        
    pop di
    pop ax
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