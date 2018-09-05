title Hello World Program (hello1.asm)



;

;This is the sample program on page 572 of your text with little modification

;It utilizes DOS service 40h.

;



.model small

.data

message db "Hello, DOS Here!",0dh,0ah,'$'



.code

main proc

	mov ax,@data

	mov ds,ax



	mov ah,40h

	mov bx,1

	mov cx,SIZEOF message

	mov dx,OFFSET message

	int 21h

	mov ax,4c00h
	
	int 21h

main endp



end main
