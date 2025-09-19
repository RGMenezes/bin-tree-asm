BITS 16

%include "packages/macros/index.asm"

start:
    println int, no1_val
    println int, no2_val
    println int, int_teste
    print string, msg_teste
    println string, msg_teste
    println string, msg_teste

	jmp $

    node no1, 10
    node no2, 20

    var string, msg_teste, "Apenas uma mensagem de teste."
    var int, int_teste, 43

%include "packages/functions/index.asm"

times 510-($-$$) db 0
dw 0xAA55