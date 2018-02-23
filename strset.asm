; strset.asm
; author: clyne

; char *strset(char *string, int c);
; strset sets all characters of string, except the ending null
; character (\0), to c (converted to a char)
;
; Returns a pointer to the altered string

global _start

section .text

_start:
	push 0x42	; c = 'B'
	push overwrite	; s -> overwrite
	call strset	; all of the 'A's will be overwritten
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

strset:
	; prologue
	push ebp
	mov ebp, esp

        mov edi, [ebp+0x8]      ; s
	mov eax, [ebp+0xC]	; char
	xor ebx, ebx
while:
	cmp [edi], bl
	jz done		; done when we hit null-byte
	
	mov [edi], al ; copy byte
	inc edi
	loop while	
done:
	int 0x3	
	mov eax, [ebp+0x8]      ; return s
	; epilogue
	mov esp, ebp
	pop ebp
	ret

section .data

	overwrite: db "AAAAAAAAAAAA", 0x00
