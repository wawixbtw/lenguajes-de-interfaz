; contador.asm
section .data
    msg db "Contador: ", 0
    salto db 10
    num db '1'

section .text
    global _start

_start:
    mov ecx, msg
    call print

    mov cl, '1'
.loop:
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    mov ecx, num
    int 0x80

    call salto_linea
    inc byte [num]
    mov al, [num]
    cmp al, '9'+1
    jg fin
    jmp .loop

print:
    mov eax, 4
    mov ebx, 1
    mov edx, 100
    int 0x80
    ret

salto_linea:
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80
    ret

fin:
    call exit

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
