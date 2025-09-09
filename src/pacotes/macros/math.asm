; Padrão de entrada para operações matemáticas (macros)
;   %1 = tipo (int ou double)
;   %2 = nome da variavel de destino
;   %3 = primeiro valor
;   %4 = segundo valor

; data_ops.asm (para 16 bits)

%macro fn_sum 4
    %ifidn %1, int
        mov eax, %3
        mov ebx, %4
        call sum_int
        mov [%2], eax
    %else
        %error "Tipo de variavel '%1' nao suportado para a operacao 'fn_sum' em 16 bits."
    %endif
%endmacro

%macro fn_sub 4
    %ifidn %1, int
        mov eax, %3
        mov ebx, %4
        call sub_int
        mov [%2], eax
    %else
        %error "Tipo de variavel '%1' nao suportado para a operacao 'fn_sub' em 16 bits."
    %endif
%endmacro

%macro fn_mul 4
    %ifidn %1, int
        mov eax, %3
        mov ebx, %4
        call multiplicacao_int
        mov [%2], eax
    %else
        %error "Tipo de variavel '%1' nao suportado para a operacao 'fn_mul' em 16 bits."
    %endif
%endmacro

%macro fn_div 4
    %ifidn %1, int
        mov eax, %3
        mov ebx, %4
        call divisao_int
        mov [%2], eax
    %else
        %error "Tipo de variavel '%1' nao suportado para a operacao 'fn_div' em 16 bits."
    %endif
%endmacro