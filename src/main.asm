BITS 16

%include "pacotes/macros/index.asm"

start:
	print msg_ola

	jmp $


    var string, msg_ola, "Ola, mundo!"
    var string, msg_soma, "A soma de 10 e 20 e: "
    var string, msg_sub, "A subtracao de 30 e 15 e: "

    var int, num_a, 10
    var int, num_b, 20
    var int, resultado, 0

%include "pacotes/functions/index.asm"

times 510-($-$$) db 0
dw 0xAA55