; tiny BST demo boot sector with working insert + fixed simplified delete
; nasm -f bin tree.asm -o tree.img
; qemu-system-i386 -fda tree.img
BITS 16
ORG 0x7C00

; --- constants ---
NODE_VALUE equ 0
NODE_LEFT  equ 2
NODE_RIGHT equ 4
NODE_SIZE  equ 6   ; 2 bytes value + 2 left + 2 right

; ---------------------------
; start: entry point
; ---------------------------
start:
    cli
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax

    mov ax, 0x0000
    mov ss, ax
    mov sp, 0x8000

    mov ax, heap
    mov [heap_ptr], ax

    ; --- demo insert ---
    mov ax, 10
    call insert
    mov ax, 5
    call insert
    mov ax, 15
    call insert
    mov ax, 12
    call insert

    ; --- demo delete 5 ---
    mov ax, 5
    call delete

    ; --- print in-order ---
    mov si, [root]
    call in_order

hang:   jmp hang

; ---------------------------
; allocate a new node
; input: AX = value
; output: SI = node offset
; ---------------------------
new_node:
    push bx
    push dx

    mov si, [heap_ptr]
    add si, 0
    mov bx, si
    add bx, NODE_SIZE
    mov [heap_ptr], bx

    mov [si+NODE_VALUE], ax
    mov word [si+NODE_LEFT], 0
    mov word [si+NODE_RIGHT], 0

    pop dx
    pop bx
    ret

; ---------------------------
; insert AX into BST
; ---------------------------
insert:
    push ax
    cmp word [root], 0
    jne not_empty
    call new_node
    mov [root], si
    pop ax
    ret

not_empty:
    mov bx, [root]    ; current node
insert_loop:
    mov dx, [bx+NODE_VALUE]
    cmp ax, dx
    je done_insert
    jb go_left

    ; go right
    mov dx, [bx+NODE_RIGHT]
    cmp dx, 0
    jne descend_right
    call new_node
    mov [bx+NODE_RIGHT], si
    jmp done_insert

descend_right:
    mov bx, [bx+NODE_RIGHT]
    jmp insert_loop

go_left:
    mov dx, [bx+NODE_LEFT]
    cmp dx, 0
    jne descend_left
    call new_node
    mov [bx+NODE_LEFT], si
    jmp done_insert

descend_left:
    mov bx, [bx+NODE_LEFT]
    jmp insert_loop

done_insert:
    pop ax
    ret

; ---------------------------
; delete AX from BST (simplified)
; ---------------------------
delete:
    push ax
    cmp word [root], 0
    je d_done
    mov bx, [root]    ; current node
    xor cx, cx        ; parent

find_node:
    cmp bx, 0
    je d_done
    mov dx, [bx+NODE_VALUE]
    cmp ax, dx
    je found_node
    jb go_left_d
    mov cx, bx
    mov bx, [bx+NODE_RIGHT]
    jmp find_node

go_left_d:
    mov cx, bx
    mov bx, [bx+NODE_LEFT]
    jmp find_node

found_node:
    ; BX = node to delete
    ; CX = parent
    ; delete children first recursively
    mov si, [bx+NODE_LEFT]
    cmp si, 0
    je skip_left
    mov ax, si
    call delete
skip_left:
    mov si, [bx+NODE_RIGHT]
    cmp si, 0
    je skip_right
    mov ax, si
    call delete
skip_right:
    ; now unlink this node
    mov si, bx    ; SI = node
    mov bx, cx    ; BX = parent
    call unlink_node
    jmp d_done

unlink_node:
    cmp bx, 0
    je unlink_root
    mov ax, [bx+NODE_LEFT]
    cmp ax, si
    je unlink_left
    mov word [bx+NODE_RIGHT], 0
    ret

unlink_left:
    mov word [bx+NODE_LEFT], 0
    ret

unlink_root:
    mov word [root], 0
    ret

d_done:
    pop ax
    ret

; ---------------------------
; in-order traversal
; input: SI = node
; ---------------------------
in_order:
    cmp si, 0
    je i_done
    push si
    mov si, [si+NODE_LEFT]
    call in_order
    pop si
    mov ax, [si+NODE_VALUE]
    call print_number
    mov al, ' '
    call print_char
    mov si, [si+NODE_RIGHT]
    call in_order
i_done:
    ret

; ---------------------------
; print_char
; ---------------------------
print_char:
    mov ah, 0x0E
    mov bh, 0
    mov bl, 7
    int 0x10
    ret

; ---------------------------
; print_number
; ---------------------------
print_number:
    push ax
    push bx
    push cx
    push dx
    xor cx, cx
    cmp ax, 0
    jne pn_loop
    mov al, '0'
    call print_char
    jmp pn_end
pn_loop:
    xor dx, dx
    mov bx, 10
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne pn_loop
pn_print:
    pop dx
    add dl, '0'
    mov al, dl
    call print_char
    loop pn_print
pn_end:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ---------------------------
; data
; ---------------------------
root:       dw 0
heap_ptr:   dw 0
heap:       times 48 db 0  ; 8 nodes max

; pad to 510 bytes
times 510-($-$$) db 0
dw 0xAA55
