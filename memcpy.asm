; .asm
; author: clyne
;
; void *memcpy(void *dest, const void *src, size_t n);
;
; The memcpy() function copies n bytes from memory area src to memory
; area dest.  The memory areas must not overlap.  Use memmove(3) if the
; memory areas do overlap.

global _start

section .text

_start:
	
	push 12
	push message
	push dest
	call memcpy
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

memcpy:
	; prologue
	push ebp
	mov ebp, esp

        mov edi, [ebp+8]        ; store pointer in edi (1st arg)
	mov edx, [ebp+0xC]	; arg 2 src

	; if src + n < dest
	mov eax, esi
	add eax, [ebp+0x10]	; src + n
	cmp edi, eax
	jge copybytes

	; else if src > dest + n
	mov eax, edi
	add eax, [ebp+0x10]
	cmp esi, eax
	jge copybytes

done:
	int 0x3	
	; epilogue
	mov esp, ebp
	pop ebp
	ret

copybytes:
	mov ecx, [ebp+0x10]	; n

copybyte:
	; copy the bytes
	int 0x3
	mov eax, [edx]
	mov [edi], al
	inc edi
	inc edx
	loop copybyte
	jmp done

section .data

	message: db "Hello World!"
	dest:	 db "AAAAAAAAAAAA"
