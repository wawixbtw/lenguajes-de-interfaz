; suma.asm
section .data
    msg1 db "Ingresa primer numero: ", 0
    msg2 db "Ingresa segundo numero: ", 0
    resultado_msg db "Resultado: ", 0
    buffer db 0

section .bss
    num1 resb 1
    num2 resb 1

section .text
    global _start

_start:
    ; Primer número
    mov ecx, msg1
    call print
    call read_char
    sub al, '0'
    mov [num1], al

    ; Segundo número
    mov ecx, msg2
    call print
    call read_char
    sub al, '0'
    mov [num2], al

    ; Suma
    mov al, [num1]
    add al, [num2]
    add al, '0' ; ASCII
    mov [buffer], al

    ; Mostrar resultado
    mov ecx, resultado_msg
    call print
    mov ecx, buffer
    mov edx, 1
    call print_buffer

    call exit

; Funciones auxiliares
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

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

