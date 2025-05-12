; datos.asm
section .data
    linea1 db "Nombre: Alexis Torres Mejia", 10, 0
    linea2 db "No. Control: 23140719", 10, 0
    linea3 db "Grupo: 6X", 10, 0

section .text
    global _start

_start:
    mov ecx, linea1
    call print
    mov ecx, linea2
    call print
    mov ecx, linea3
    call print
    call exit

print:
    mov eax, 4
    mov ebx, 1
    mov edx, 100
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
