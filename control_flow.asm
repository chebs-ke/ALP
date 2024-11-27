section .data
    prompt db "Enter a number: ", 0
    posMsg db "POSITIVE", 0
    negMsg db "NEGATIVE", 0
    zeroMsg db "ZERO", 0

section .bss
    num resb 4

section .text
    global _start

_start:
    ; Input a number
    mov eax, 4                ; syscall: sys_write
    mov ebx, 1                ; file descriptor: stdout
    mov ecx, prompt
    mov edx, 15
    int 0x80

    ; Read the number
    mov eax, 3                ; syscall: sys_read
    mov ebx, 0                ; file descriptor: stdin
    mov ecx, num
    mov edx, 4
    int 0x80

    ; Convert input to integer (simple)
    mov eax, [num]
    cmp eax, 0
    je isZero
    jl isNegative
    jmp isPositive

isPositive:
    mov eax, 4
    mov ebx, 1
    mov ecx, posMsg
    mov edx, 8
    int 0x80
    jmp exit

isNegative:
    mov eax, 4
    mov ebx, 1
    mov ecx, negMsg
    mov edx, 8
    int 0x80
    jmp exit

isZero:
    mov eax, 4
    mov ebx, 1
    mov ecx, zeroMsg
    mov edx, 4
    int 0x80

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
