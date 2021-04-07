; programa texto rebotando en eje X y eje Y final

.model small
.stack
.data
    msg db 'hola mundo', '$'
    x db 0, '$'
    y db 0, '$'
    boolVertical db 1, '$'
    boolHorizontal db 1, '$'
.code

    setup:
        mov ax, @data
        mov ds, ax
        mov es, ax

        mov ah, 00h ; establecer modo de video
        mov al, 02h
        int 10h

        inicio:
            mov ah, 06h ; funcion desplazar lineas de texto hacia arriba (limpiar pantalla)
            mov bh, 14
            mov cx, 0000h
            mov dx, 184fh
            int 10h

            mov ah, 02h ; funcion: posicionar el cursor
            mov bh, 0
            mov dh, y ; numero de linea
            mov dl, x ; numero de columna
            int 10h

            mov ah, 09h ; funcion: visualizacion de una cadena de caracteres
            mov dx, Offset msg
            int 21h

            mov ah, 00h ; funcion: pausa en segundos
            int 1ah
            add dx, 1
            mov bx, dx
            pausa:
                int 1ah
                cmp dx, bx
                jbe pausa

            verificarX:
                cmp boolHorizontal, 1
                je incrementarX

                decrementarX:
                    sub x, 2
                    cmp x, 0
                    jne verificarY
                    mov boolHorizontal, 1
                    jmp verificarY
                    
                incrementarX:
                    add x, 2
                    cmp x, 68
                    jne verificarY
                    mov boolHorizontal, 0

            verificarY:
                cmp boolVertical, 1
                je incrementarY

                decrementarY:
                    dec y
                    cmp y, 0
                    jne inicio
                    mov boolVertical, 1
                    jmp inicio
                    
                incrementarY:
                    inc y
                    cmp y, 24
                    jne inicio
                    mov boolVertical, 0
                    jmp inicio                 

    end setup