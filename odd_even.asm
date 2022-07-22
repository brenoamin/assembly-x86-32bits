%include "io.inc"
section .data
    msgEven db 'Even',0
    msgOdd db 'Odd ',0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_DEC 4, eax;
    mov ecx,2;
    mov edx,0;
    div ecx;
    cmp edx,0;
    JE  EVEN;
    JNE ODD;
EVEN:  
    PRINT_STRING msgEven
    NEWLINE
    ret
ODD:
    PRINT_STRING msgOdd
    NEWLINE
    ret