org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

;Prints a string to the screen
;Params:
;    -ds:si points to the string
puts:
    push si 
    push ax
.loop:
    lodsb  ;loads next character in al
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0  ;cannot write to ds or es directly
    mov ds, ax
    mov es, ax 

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00 ;stack grows downward from where we are in memory

    ; print message
    mov si, msg_hello_world
    call puts
    hlt

.halt:
    jmp .halt


msg_hello_world: db 'Hello from SKD !', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h

