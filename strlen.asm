; helloworld.asm
; author: clyne

global _start

section .text

_start:
	push message
	call strlen
	int 0x3

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

strlen:
	; prologue
	push ebp
	mov ebp, esp

        mov edi, [ebp+8]        ; store pointer in edi (1st arg)
        xor eax, eax            ; eax = 0
        mov ecx, 0xFFFFFFFF     ; -1
        repne scasb             ; scan string until byte == 0x00 (eax)
        sub eax, ecx            ; 0 - ecx
        sub eax, 2              ; eax - 2
	
	; epilogue
	mov esp, ebp
	pop ebp
	ret

section .data

	message: db "Hello World!"
