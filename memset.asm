; memset.asm
; author: clyne

; void *memset(void *s, int c, size_t n);
; The memset() function fills the first n bytes of the memory area
; pointed to by s with the constant byte c.
;
;The memset() function returns a pointer to the memory area s.

global _start

section .text

_start:
	push 0xC	; n=12
	push 0x42	; c='B'
	push overwrite	; s -> overwrite
	call memset	; all of the 'A's will be overwritten
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

memset:
	; prologue
	push ebp
	mov ebp, esp

        mov edi, [ebp+0x8]      ; s
	mov al, [ebp+0xC]	; char
	mov ecx, [ebp+0x10]	; n bytes

	cld			; write in forward direction
        rep stosb		; copy al ecx times to edi 
	
	mov eax, [ebp+0x8]	; return s
		
	; epilogue
	mov esp, ebp
	pop ebp
	ret

section .data

	overwrite: db "AAAAAAAAAAAAZZZZ"	; 12 A 4 Z
