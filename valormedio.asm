; valor_medio.asm
section .data
    msg0 db 0xA,"Actividad 2",0xA,"$"
    msg1 db "Alexis Torres Mejia",0xA,"$"
    msg2 db "Numero de control 23140719  Grupo 6X",0xA,"$"
    msg3 db "Numero #1 => $"
    msg4 db "Numero #2 => $"
    msg5 db "Numero #3 => $"
    msg6 db 0xA,"Valor medio => $"
    salto db 0xA
    buffer db 0

section .text
    global _start

_start:
    ; Mostrar encabezado
    mov ecx, msg0
    call print_string
    mov ecx, msg1
    call print_string
    mov ecx, msg2
    call print_string

captura:
    mov ecx, msg3
    call print_string
    call read_char
    mov bl, al ; ch

    mov ecx, msg4
    call print_string
    call read_char
    mov bh, al ; cl

    mov ecx, msg5
    call print_string
    call read_char
    mov dl, al ; bl

    ; Validar valores (0-9 en ASCII)
    cmp bl, '0'
    jb captura
    cmp bl, '9'
    ja captura

    cmp bh, '0'
    jb captura
    cmp bh, '9'
    ja captura

    cmp dl, '0'
    jb captura
    cmp dl, '9'
    ja captura

    ; Evitar repeticiones
    cmp bl, bh
    je captura
    cmp bl, dl
    je captura
    cmp bh, dl
    je captura

    ; Ordenar
    call ordenar
    ; Mostrar valor medio
    mov ecx, msg6
    call print_string
    mov al, bh
    call print_char

    ; Salir
    call exit

; ----------------------------
; FUNCIONES AUXILIARES
; ----------------------------
print_string:
    pusha
    mov eax, 4
    mov ebx, 1
    mov edx, 100
    int 0x80
    popa
    ret

print_char:
    pusha
    mov [buffer], al
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 0x80
    popa
    ret

read_char:
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 1
    int 0x80
    mov al, [buffer]
    ret

ordenar:
    ; ordenar bl, bh, dl => bh será el del medio
    ; primer paso: bl > bh ?
    cmp bl, bh
    jle .ok1
    xchg bl, bh
.ok1:
    cmp bh, dl
    jle .ok2
    xchg bh, dl
.ok2:
    cmp bl, bh
    jle .fin
    xchg bl, bh
.fin:
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
