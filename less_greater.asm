%include "io.inc"
section .data
    msgEqual db 'The numbers are equal',0
    msgGreater db 'The biggest number is: ',0
    msgLess db 'The smaller number is: ',0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    GET_DEC 4, eax;
    GET_DEC 4, ebx;
    CMP AX, BX
    JE  EQUAL
    JG GREATER
    JL LESS
EQUAL:  
    PRINT_STRING msgEqual
    NEWLINE
    ret
GREATER:
    PRINT_STRING msgGreater
    PRINT_DEC 4,eax
    NEWLINE
    PRINT_STRING msgLess
    PRINT_DEC 4,ebx
    NEWLINE
    ret
LESS:
    PRINT_STRING msgGreater
    PRINT_DEC 4,ebx
    NEWLINE
    PRINT_STRING msgLess
    PRINT_DEC 4,eax
    NEWLINE
    ret