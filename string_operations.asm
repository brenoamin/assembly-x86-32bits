
;***************************
;Student: Breno Amin
;Subject: Basic Software Programming
;Atividade I: Make a program in Assembly language that reads a String as input:
;“A figura anterior mostra os objetos e os morfismos identificados”

%include "io.inc"

section .data
stringSize equ 32 ;reserve initialized space
lowerCase equ 1 ;reserve initialized space
upperCase equ 2 ;reserve initialized space


sliceOption equ 1 ;reserve initialized space
revertOption equ 2 ;reserve initialized space
concatenateOption equ 3 ;reserve initialized space
alternateOption equ 4 ;reserve initialized space

section .bss ;reserve space (without initializing)
input resb 64  ; reserve 64 bytes
revertedString resb 64 ; reserve 64 bytes
slicedString resb 64 ; reserve 64 bytes
concatenatedString resb 64 ; reserve 64 bytes
alternatedString resb 64 ; reserve 64 bytes

section .text
global CMAIN
CMAIN:
 mov ebp, esp; for correct debugging
 PRINT_STRING "Received string: "
 GET_STRING input,65 ;store the input in input variable
 PRINT_STRING input ;print the input string
 NEWLINE
SLICE_STRING:
    call initialize ;call the initialize function
    mov ebx,input ;load input in ebx
    add ebx,18 ;add 18 to ebx, making it appointing to the 18 character
    SLICE_INPUT_STRING:
    cmp ecx,stringSize ;compare ecx with the final sliced string (32 characters)
    je END_SLICE_STRING
    mov al, byte[ebx] ;move each character to al (why al? I'm moving 1 byte wich is the same as 8 bits and al is a 8 bits register)
    mov [slicedString+ecx],al ;storing al in slicedString
    inc ebx ;advance pointer to next cell to write
    inc ecx ; counter who will help in the sliced string size
    jmp SLICE_INPUT_STRING
END_SLICE_STRING:
    mov ecx, sliceOption ;pass the sliceOption as parameter in ecx
    call finalize ;call the finalize function
    
    
    

REVERT_STRING:
    call initialize ;call the initialize function
START_FROM_END_REVERT:
    mov ecx,stringSize ;move the sliced string
    add ebx,ecx ;advance pointer to end+1 cell to write 
    sub ebx, 1 ;advance pointer to end cell to write
FOR_REVERT_CHAR:
    mov al, byte[ebx] ;move each character to al (why al? I'm moving 1 byte wich is the same as 8 bits and al is a 8 bits register)
    cmp al,0 ; compare al with 0 character
    je END_REVERT_STRING
    mov [revertedString+edx],al ;store each byte in revertedString
    dec ebx ;retreat pointer to next cell to write
    inc edx ;counter who will help in the store process
    jmp FOR_REVERT_CHAR  
END_REVERT_STRING:
    mov ecx, revertOption ;pass the revertOption as parameter in ecx
    call finalize ;call the finalize function ; finalize(revertOption)
    
    
 
       
CONCATENATE_STRING:
    call initialize ;call the initialize function
    
FOR_CONCATENATE_CHAR:
    mov al, byte[ebx] ;move each character to al (why al? I'm moving 1 byte wich is the same as 8 bits and al is a 8 bits register)
    cmp al,0 ; compare al with 0 character
    je END_CONCATENATE_STRING;
    cmp byte[ebx]," ";compare each character with space character
    je JUMP_EMPTY_CHAR
    mov [concatenatedString+edx],al ;store each byte in concatenatedString
    inc edx ;counter who will help in the store process
    inc ebx ;advance pointer to next cell to write
    jmp FOR_CONCATENATE_CHAR
JUMP_EMPTY_CHAR:
    inc ebx ;advance pointer to next cell to write
    jmp FOR_CONCATENATE_CHAR
END_CONCATENATE_STRING:
    mov ecx, concatenateOption ;pass the concatenateOption as parameter in ecx
    call finalize ;call the finalize function




ALTERNATE_UPPER_LOWER_CASE_STRING:
    call initialize ;call the initialize function
    mov ecx,upperCase; the first letter must be a upper case letter as shown in the example
    
FOR_UPPER_LOWER_CHAR:
    mov al,byte[ebx] ;move each character to al (why al? I'm moving 1 byte wich is the same as 8 bits and al is a 8 bits register)
    cmp al,0 ; compare al with 0 character
    je END_ALTERNATE_UPPER_LOWER_CASE_STRING;
    cmp al," " ; compare al with space character
    je ADD_CHAR_UPPER_LOWER_CASE_CHAR
    cmp ecx,lowerCase;compare al with lowerCase character
    je ADD_LOWER_CASE_CHAR
    jmp ADD_UPPER_CASE_CHAR

ADD_UPPER_CASE_CHAR:
    mov ecx,lowerCase ;makes the next character a lowerCase character
    sub al, 'a' ;convert lowerCase into upperCase character
    add al,'A';convert lowerCase into upperCase character
    jmp ADD_CHAR_UPPER_LOWER_CASE_CHAR

ADD_LOWER_CASE_CHAR:
    mov ecx,upperCase; makes the next character a upperCase character
    jmp ADD_CHAR_UPPER_LOWER_CASE_CHAR
    
ADD_CHAR_UPPER_LOWER_CASE_CHAR:
    mov [alternatedString+edx], al ;store al into alternatedString
    inc edx ;counter who will help in the store process
    inc ebx ;advance pointer to next cell to write
    jmp FOR_UPPER_LOWER_CHAR;
END_ALTERNATE_UPPER_LOWER_CASE_STRING:
    mov ecx, alternateOption ;pass the alternateOption as parameter in ecx
    call finalize ;call the finalize function
    
    
    
    
ALPHABETICAL_ORDER_STRING:
    call initialize ;call the initialize function
    NEWLINE
    PRINT_STRING "e) String ASCII: " ;a simple print string
FOR_ALPHABETICAL_ORDER_CHAR:
    mov al,byte[ebx] ;move each character to al (why al? I'm moving 1 byte wich is the same as 8 bits and al is a 8 bits register)
    cmp al,0; compare al with 0 character
    je END_ALPHABETICAL_ORDER_CHAR
    cmp al," " ; compare al with space character
    je JMP_EMPTY_CHAR
    sub al,96 ;convert into alphabetical order according to the ASCII table
    PRINT_DEC 1, al ;print the converted string
    inc ebx ;advance pointer to next cell to write
    jmp FOR_ALPHABETICAL_ORDER_CHAR
JMP_EMPTY_CHAR:
     PRINT_CHAR al ;a simple print of space character
     inc ebx ;advance pointer to next cell to write
     jmp FOR_ALPHABETICAL_ORDER_CHAR
END_ALPHABETICAL_ORDER_CHAR:
    ret ;the end of the process
    
;utils functions
initialize:
    mov ebp, esp ;ebp and esp points to the same address
    xor eax, eax ;clean eax
    xor ebx,ebx ;clean ebx
    xor ecx,ecx;clean ecx
    xor edx,edx;clean edx
    mov ebx,slicedString;store the sliced string in ebx
    ret

finalize:
    cmp ecx,sliceOption ;compare ecx with sliceOption
    je FINALIZE_SLICE ;jump to FINALIZE_SLICE if equal
    cmp ecx, revertOption ;compare ecx with revertOption
    je FINALIZE_REVERT;jump to FINALIZE_REVERT if equal
    cmp ecx, concatenateOption ;compare ecx with concatenateOption
    je FINALIZE_CONCATANATE ;jump to FINALIZE_CONCATENATE if equal
    cmp ecx, alternateOption ;compare ecx with alternateOption
    je FINALIZE_ALTERNATE ;jump to FINALIZE_ALTERNATE if equal
    FINALIZE_SLICE: ;FINALIZE_SLICE label. The main purpose is print a specific string about slicedString
    NEWLINE
    PRINT_STRING "a) Sliced String: "; print the specific text
    PRINT_STRING slicedString ;print the variable that stores the sliced string
    ret
    FINALIZE_REVERT: ;FINALIZE_REVERT label. The main purpose is print a specific string about revertedString
    NEWLINE
    PRINT_STRING "b) Reverted String: "; print the specific text
    PRINT_STRING revertedString ;print the variable that stores the reverted string
    ret
    FINALIZE_CONCATANATE: ;FINALIZE_CONCATENATE label. The main purpose is print a specific string about concatenatedString
    NEWLINE
    PRINT_STRING "c) Concatenated String: "; print the specific text
    PRINT_STRING concatenatedString ;print the variable that stores the concatenated string
    ret
    FINALIZE_ALTERNATE: ;FINALIZE_ALTERNATE label. The main purpose is print a specific string about alternatedString
    NEWLINE
    PRINT_STRING "d) AlTeRnAtEd String: "; print the specific text
    PRINT_STRING alternatedString ;print the variable that stores the alternated string
    ret
    
