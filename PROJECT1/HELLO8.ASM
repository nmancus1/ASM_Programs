title Hello World Program (hello1.asm)

.model small

.data

message db "Hello, DOS Here!",0

revmessage db ?

messagesize = SIZEOF message 


.code

main proc

	mov ax,@data
	mov ds,ax	
	mov cx, messagesize
	mov si, OFFSET message-1
	mov di, OFFSET revmessage + messagesize
	
	call copyStr

mov cx, messagesize
mov bx, OFFSET revmessage+2

call prnStr

call prnCrLf

mov ax,4c00h
int 21h

main endp


copyStr PROC
loop1:

	mov ax, [si]
	mov [di], ax
	dec di
	inc si
	loop loop1
	ret
	
copyStr ENDP



prnStr PROC

textprinter:

	mov dx, [bx]
	mov ah,2h
	int 21h
	inc bx
	loop textprinter
	ret
	
prnStr ENDP

prnCrLf PROC

	mov dl, 13
	mov ah,2h
	int 21h
	mov dl, 10
	mov ah,2h
	int 21h
	ret

prnCrLf ENDP
	
	
	

end main

	

