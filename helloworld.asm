; helloworld.asm
; author: clyne

global _start

section .text

_start:
	; print hello world to the screen
	mov eax, 0x4	; syscall 4 = write
	mov ebx, 0x1	; stdout
	mov ecx, message ; ptr to message
	mov edx, mlen ; strlen
	int 0x80

	; exit
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

section .data

	message: db "Hello World!"
	mlen equ $-message
