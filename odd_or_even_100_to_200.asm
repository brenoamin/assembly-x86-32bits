%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ebx, 100;
    mov ecx,2;
    FOR_ONE:
        cmp ebx,200;
        jg END;
        PRINT_DEC 4,ebx;
        PRINT_STRING msg;
        NEWLINE
        ADD EBX,2; 
        jmp FOR_ONE
    END:
        ret
   
section .data
msg db ' IS EVEN ',0