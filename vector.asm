%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ebx,8;
    mov ecx,0;
    mov edx,0;
    lp:
    PRINT_DEC 2,[vector1+ebx];
    mov eax,[vector1+ebx];
    mov [vector2+edx],eax;
    mov cl, byte [vector2]
    add edx,2
    sub ebx,2
    cmp ebx,-2
    jne lp;
    ret;
Section .bss
vector2 resw 5;

Section .data
vector1 dw 1,2,3,4,5;