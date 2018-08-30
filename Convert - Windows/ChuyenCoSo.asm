extern _printf
extern _scanf
extern _puts

global _main

section .data
    NhapSo db "Nhap so thap phan: ", 0
    n times 4 dd 0
    NhapCoSo db "Nhap co so: ", 0
    coso times 2 dd 0
    Alphabet db "0123456789ABCDEF", 0
    ketQua db "00000000000000000000000000000000", 0
    formatIN db "%d", 0

section .text

;in ra man hinh
%macro print 1
    push  dword %1
    call _printf
    add esp, 4
%endmacro

;nhap tu man hinh
%macro scan 1
    push %1
    push formatIN
    call _scanf
    add esp, 8
%endmacro
_main:
print NhapSo
scan n
print NhapCoSo
scan coso

mov eax,  dword [n]
mov ebx, [coso]
mov esi, 0

loop1:
    xor edi, edi
    xor edx, edx
    div ebx
    mov dl, [Alphabet + edx]
    mov edi, ketQua
    add edi, 31
    sub edi, esi
    mov [edi], dl
    inc esi
    cmp eax, 0
    jne loop1
push ketQua
call _puts
add esp, 4