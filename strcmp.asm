; strcmp.asm
; author: clyne
;
; int strcmp(const char *s1, const char *s2);
;
; The strcmp() function compares the two strings s1 and s2. 
; It returns an integer less than, equal to, or greater than 
; zero if s1 is found, respectively, to be less than, to match, 
; or be greater than s2.
;
; The sign of a non-zero return value shall be determined by the
; sign of the difference between the values of the first pair of
; bytes (both interpreted as type unsigned char) that differ in
; the strings being compared

global _start

section .text

_start:
	push s2
	push s1
	call strcmp
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

strcmp:
	; prologue
	push ebp
	mov ebp, esp

        mov esi, [ebp+8]        ; s1
	mov edi, [ebp+0xC]	; s2	
	xor eax, eax	; 0
while:
	mov dl, [esi]
	mov bl, [edi]
	cmp bl, dl
	; unsigned comparison
	ja greater
	jb less
	; equal
	cmp bl, 0x00
	je done
	inc esi
	inc edi
	loop while
	 
done:
	; epilogue
	mov esp, ebp
	pop ebp
	ret

greater:
	inc eax
	jmp done

less:
	dec eax
	jmp done

section .data

	s1: db "ABCDEF", 0x00
	s2: db "ABCDE", 0x00
