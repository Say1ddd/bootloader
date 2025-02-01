BITS 16            ; set to 16-bit mode
ORG 0x7C00        ; set bios load address

start:
    mov si, message  ; load address message to SI
    call print

    mov ah, 0x02
    mov al, 1     ; read 1 sector
    mov ch, 0     ; cylinder 0
    mov cl, 2     ; sector 2
    mov dh, 0     ; head 0
    mov dl, 0x00  ; boot drive
    mov bx, 0x9000  ; load address 0x9000:0x0000
    mov es, bx
    mov bx, 0
    int 0x13      ; call bios interrupt to read sector
    jc error

    ; jump to second-stage loader
    jmp 0x9000:0x0000

;    jmp $           ; infinite loop (halt execution)

error:
    mov si, err_msg
    call print
    jmp $

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

message db "Booting Stage 2...", 0
err_msg db "Disk read error!", 0

times 510-($-$$) db 0  ; fill remaining space with zeros
dw 0xAA55              ; boot signature

