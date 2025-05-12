; mayuscula.asm
section .data
    msg db "Ingresa una letra minuscula: ", 0
    resultado db "Letra mayuscula: ", 0
    salto db 10
    buffer db 0

section .text
    global _start

_start:
    mov ecx, msg
    call print
    call read_char

    ; convertir: restar 32
    sub al, 32
    mov [buffer], al

    mov ecx, resultado
    call print
    mov ecx, buffer
    mov edx, 1
    call print_buffer
    call salto_linea
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
