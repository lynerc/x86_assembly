; strchr.asm
; author: clyne

; The strchr() function returns a pointer to the
; first occurrence of the character c in the string s.
; char *strchr(const char *s, int c);

global _start

section .text

_start:
	push 0x6F	; 'o'		2nd arg
	push message	; string,	1st arg
	call strchr
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

strchr:
	; prologue
	push ebp
	mov ebp, esp
	
	mov edi, [ebp+0x8]	; 1st arg (pointer to string)
        mov eax, [ebp+0xc]      ; 2nd arg (character int)
        mov ecx, 0xFFFFFFFF     ; -1
        repne scasb             ; scan string until byte == eax
	dec edi			; edi will be one past first occurrence
	mov eax, edi		; points to first occurrence of eax
	
	; epilogue
	mov esp, ebp
	pop ebp
	ret

section .data

	message: db "Hello World!"
