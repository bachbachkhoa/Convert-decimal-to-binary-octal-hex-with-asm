global _start
section .data
	NhapSo db "Nhap so thap phan: "
	len_Nhapso equ $-NhapSo

	NhapCoSo db "Nhap co so: "
	len_NhapCoSo equ $-NhapCoSo

	Alphabet db "0123456789ABCDEF"

	ketQua times 32 db '0'

	xuongDong db 0xA
	len_xuongDong equ $-xuongDong

section .bss
	chuoi_n resb 10
	chuoi_coso resb 10
	n resb 4
	coso resb 4
section .text
_start:
;in ra man hinh
	%macro print 2
		mov eax, 4
		mov ebx, 1
		mov ecx, %1
		mov edx, %2
		int 0x80
	%endmacro

;nhap tu man hinh
	%macro scan 2
		mov eax, 3
		mov ebx, 2
		mov ecx, %1
		mov edx, %2
		int 0x80
	%endmacro
print NhapSo, len_Nhapso
scan chuoi_n, 10
print NhapCoSo, len_NhapCoSo
scan chuoi_coso, 10

;Chuyen chuoi decimal vua nhap thanh so
mov esi, chuoi_n
mov ebx, 0
mov eax, 10
loop1:
	xor ecx, ecx	;Lam rong thanh ghi ecx
	mov cl, [esi]	;chuyen 1 ky tu dau tien o esi vao ecx
	sub ecx, '0'	;tru ecx di ascii cua '0' de doi ve dang so
	mul ebx			;Nhan eax va ebx
	mov ebx, eax
	add ebx, ecx
	inc esi			;tang esi len 1 don vi de thuc hien voi ky tu tiep theo
	mov eax, 10
	cmp [esi], al	;neu du lieu o esi bang al thi ket thuc vong lap
	jne loop1
	mov [n], ebx
mov esi, chuoi_coso
mov ebx, 0
mov eax, 10
;Chuyen co so vua nhap thanh so
loop2:
	xor ecx, ecx
	mov cl, [esi]
	sub ecx, '0'
	mul ebx
	mov ebx, eax
	add ebx, ecx
	inc esi
	mov eax, 10
	cmp [esi], al
	jne loop2
	mov [coso], ebx
mov eax, [n]
mov ebx, [coso]
mov edi, ketQua
;Chuyen so decimal thanh so moi theo co so
loop3:
	mov esi, Alphabet	;Tro esi vao cac chu so
	xor edx, edx
	div ebx			;Chia cho co so
	add esi, edx	;Cong phan du voi chu so tuong ung de co the in ra man hinh
	mov cl, [esi]
	mov [edi], cl  
	inc edi
	cmp eax, 0
	jne loop3
;Lat nguoc chuoi ket qua
loop4:
	dec edi
	print edi, 1
	cmp edi, ketQua
	jne loop4
print xuongDong, len_xuongDong

exit:
	mov eax, 1
	int 0x80