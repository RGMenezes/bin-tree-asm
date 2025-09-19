sum_int:
    add eax, ebx
    ret

sub_int:
    sub eax, ebx
    ret

mul_int:
    imul ebx
    ret

div_int:
    xor edx, edx
    idiv ebx
    ret