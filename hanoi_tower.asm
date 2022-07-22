;***************************
;Student: Breno Amin
;Subject: Basic Software Programming 22.1
;Exercise 2: Write code in Assembly to move disks (4) from A to B and from B to C, where a larger disk can never be on top of a smaller one.
%include "io.inc"


section .data


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    %macro hanoiArguments 4 ;macro created to prepare the right parameters to be passed to hanoi function
    dec %1
    mov ebx, %2
    mov ecx, %3
    mov edx, %4
    %endmacro
    call initialize
    ;HanoiAlgorithm(disk, source, dest, spare)
    hanoiFunction:
    push ebp ; save the old ebp's value
    mov ebp,esp ; point ebp to the same adress as esp
    push eax ;push eax in the stack
    push ebx ;push ebx in the stack
    push ecx ;push ecx in the stack 
    mov edx,6 ;calculate aux pole
    sub edx,ebx ;calculate aux pole
    sub edx,ecx ;calculate aux pole
    push edx ; push edx in the stack
    cmp eax,0 ;number of disks is equal to zero?
    je CLEAN_HANOI 
    ;HanoiAlgorithm(disk - 1, source, spare, dest)
    hanoiArguments eax, [ebp-8],[ebp-16],[ebp-12] ; preparing the right parameters before call the hanoi function
    call hanoiFunction ;call hanoi
    ;move disk from source to dest
    PRINT_STRING "Move o disco "
    mov eax,[ebp-4] 
    PRINT_DEC 1, eax
    PRINT_STRING " da torre "
        
    mov eax,[ebp-8]
    call hanoi_convert
    PRINT_STRING " para a torre "
        
    mov eax,[ebp-12]
    call hanoi_convert
    NEWLINE
    ;HanoiAlgorithm(disk - 1, spare, dest, source)
    mov eax,[ebp-4]
    hanoiArguments eax, [ebp-16],[ebp-12],[ebp-8] ; preparing the right parameters before call the hanoi function
    call hanoiFunction
    CLEAN_HANOI: ;clean the stack
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop ebp
    ret
    
    
    ;utils
    initialize: ;clean some registers, 
    xor eax, eax ;clean eax
    xor ebx, ebx ;clean ebx
    xor ecx, ecx ;clean ecx
    xor edx, edx ;clean edx (spare)
    GET_DEC 1, eax ; number of disks
    mov ebx, 1 ; start
    mov ecx, 3 ; end
    ret
    
    hanoi_convert: ;convert the tower's number into his respective letter (1->A, 2->B, 3->C)
    cmp eax,1   
    je tower_A
    cmp eax,2
    je tower_B
    cmp eax,3
    je tower_C
    tower_A:
    PRINT_STRING 'A'
    ret
    tower_B:
    PRINT_STRING 'B'
    ret
    tower_C:
    PRINT_STRING 'C'
    ret
    

    
    
    