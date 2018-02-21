#!/bin/bash

# if file is strlen.asm... pass "strlen" as arg

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $1.o $1.asm

echo '[+] Linking ...'
ld -z execstack -o $1 $1.o

echo '[+] Done!'



