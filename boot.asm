BITS 16            ; set to 16-bit mode
ORG 0x7C00        ; set bios load address

start:
    mov si, message  ; load address message to SI
    call print

    jmp $           ; infinite loop (halt execution)

print:
    mov ah, 0x0E    ; bios teletype function
.loop:
    lodsb           ; load next byte from SI to AL
    cmp al, 0       ; is it null-terminated ???
    je done
    int 0x10        ; call bios
    jmp .loop
done:
    ret

message db "halo", 0

times 510-($-$$) db 0  ; fill remaining space with zeros
dw 0xAA55              ; boot signature

