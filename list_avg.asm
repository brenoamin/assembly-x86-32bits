%include "io.inc"
section .text


global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor edx, edx
    %macro media 3
    mov eax, %1
    mov ebx, %2
    add eax, ebx
    add eax, ecx
    mov ebx, 3
    div ebx
    PRINT_DEC 4, eax
    %endmacro
    GET_DEC 4, eax
    GET_DEC 4, ebx
    GET_DEC 4, ecx
    call media eax,ebx,ecx
    ret