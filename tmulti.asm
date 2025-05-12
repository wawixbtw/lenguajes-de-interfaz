; tabla.asm
section .data
    msg db "Ingresa un numero (1-9): ", 0
    salto db 10
    buffer db 0

section .bss
    num resb 1

section .text
    global _start

_start:
    mov ecx, msg
    call print
    call read_char
    sub al, '0'
    mov [num], al

    mov cl, 1
.loop:
    mov al, [num]
    mul cl         ; AL = num * cl
    add al, '0'
    mov [buffer], al

    call print_buffer
    call salto_linea

    inc cl
    cmp cl, 10
    jle .loop

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

print_buffer:
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
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
