; factorial.asm
section .data
    msg1 db "Ingresa un numero (1-9): ", 0
    msg2 db "Factorial: ", 0
    salto db 10
    buffer db 0

section .bss
    num resb 1
    fact resb 1

section .text
    global _start

_start:
    mov ecx, msg1
    call print
    call read_char
    sub al, '0'
    mov [num], al

    mov al, [num]
    cmp al, 1
    jb fin
    cmp al, 9
    ja fin

    mov bl, al      ; contador
    mov al, 1       ; acumulador (factorial base)
.factorial_loop:
    mul bl          ; AL *= BL
    dec bl
    cmp bl, 1
    jge .factorial_loop

    add al, '0'
    mov [buffer], al

    mov ecx, msg2
    call print
    mov ecx, buffer
    mov edx, 1
    call print_buffer
    call salto_linea
fin:
    call exit

; Funciones
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

print_buffer:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret

salto_linea:
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

