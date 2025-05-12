; par_impar.asm
section .data
    msg1 db "Ingresa un numero (0-9): ", 0
    msg2 db "Es PAR", 10, 0
    msg3 db "Es IMPAR", 10, 0
    buffer db 0

section .text
    global _start

_start:
    mov ecx, msg1
    call print
    call read_char
    sub al, '0'

    mov ah, 0
    mov bl, 2
    div bl        ; AL / 2

    cmp ah, 0
    je .es_par
    mov ecx, msg3
    call print
    jmp fin
.es_par:
    mov ecx, msg2
    call print
fin:
    call exit

print:
    mov eax, 4
    mov ebx, 1
    mov edx, 100
    int 0x80
    ret

read_char:
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 1
    int 0x80
    mov al, [buffer]
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
