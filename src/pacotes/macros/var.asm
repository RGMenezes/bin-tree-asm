; Padrão para declaracao de variaveis
;   %1 = tipo
;   %2 = nome da variavel
;   %3 = valor inicial

%macro var 3
    %ifidn %1, boolean
        ; Verifica se o valor e 0 ou 1.
        %if %3 == 0 | %3 == 1
            %2: db %3
        %else
            %error "O valor para o tipo 'boolean' deve ser 0 ou 1."
        %endif

    %elifidn %1, null
        %2: db 0

    %elifidn %1, int
        %2: dq %3

    %elifidn %1, double
        %2: dq _double_ %3

    %elifidn %1, string
        %2: db %3, 0

    %else
        %error "Tipo de variavel '%1' nao reconhecido. Use 'boolean', 'null', 'int', 'double' ou 'string'."
    %endif
%endmacro


; Padrão de entrada para atribuicao de valor:
;   %1 = tipo (boolean, int, double ou string)
;   %2 = nome da variavel onde o valor sera armazenado
;   %3 = valor a ser atribuido

%macro set 3
    %ifidn %1, boolean
        ; Verifica se o valor e valido para booleano
        %if %3 == 0 | %3 == 1
            mov al, %3
            mov [%2], al
        %else
            %error "O valor para o tipo 'boolean' deve ser 0 ou 1."
        %endif

    %elifidn %1, int
        mov rax, %3
        mov [%2], rax

    %elifidn %1, double
        movsd rax, __float64__(%3)
        movsd [rel %2], rax

    %elifidn %1, string
        
        mov rax, %3
        mov [%2], rax
    %else
        %error "Tipo de variavel '%1' nao suportado pela macro 'set'."
    %endif
%endmacro

; inverter booleano
%macro iboo 1
    mov al, [%1]
    xor al, 1
    mov [%1], al
%endmacro


; Padrão de entrada para operacoes aritmeticas:
;   %1 = tipo (int ou double)
;   %2 = variavel a ser modificada
;   %3 = valor a ser operado

%macro setSum 3
    fn_sum %1, %2, [%2], %3
%endmacro

%macro setSub 3
    fn_sub %1, %2, [%2], %3
%endmacro

%macro setMul 3
    fn_mul %1, %2, [%2], %3
%endmacro

%macro setDiv 3
    fn_div %1, %2, [%2], %3
%endmacro