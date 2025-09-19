section .bss
buffer resb 6       ; reserva 6 bytes para conversão de inteiro

section .text

printInt:
    push ax
    push bx
    push cx
    push dx
    push si

    mov si, buffer          ; ponteiro pro início do buffer
    add si, 6               ; ponteiro pro final do buffer (vamos preencher de trás pra frente)
    mov cx, 0               ; flag negativo

    cmp ax, 0
    jge pi_convert
    neg ax                  ; torna positivo
    mov cx, 1               ; indica que era negativo

pi_convert:
    mov dx, 0
    mov bx, 10

pi_loop:
    mov dx, 0
    div bx                  ; AX / 10 → quociente em AX, resto em DX
    add dl, '0'             ; converte resto para ASCII
    dec si
    mov [si], dl
    cmp ax, 0
    jne pi_loop

    cmp cx, 0
    je pi_print
    dec si
    mov byte [si], '-'      ; adiciona sinal negativo

pi_print:
.repeat:
    lodsb                   ; carrega [SI] em AL e incrementa SI
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp .repeat

.done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret