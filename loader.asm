BITS 16
ORG 0x0000  ; loaded at 0x9000:0x0000

start:
    mov si, message
    call print

    jmp $

print:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je done
    int 0x10
    jmp .loop
done:
    ret

message db "Second Stage Loaded Successfully!", 0

times 512-($-$$) db 0  ; fill to 512 bytes
