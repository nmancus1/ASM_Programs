;Nick Mancuso
;CIS130
;
;This is a short program to reverse and print a string to the console 
;using MOV and a variable

title Hello World Program (hello6.asm)

.model small

.data

message db "Hello, DOS Here!",0

revmessage db ?						;variable for reversed string

messagesize = SIZEOF message 		;variable for size of message


.code

main proc

	mov ax,@data					;move data to ax
	mov ds,ax						;move data from ax to data segment
	mov cx, messagesize				;set up loop counter
	mov si, OFFSET message-1		;set source index for copying string
	
	;set destination index for reversed string to last position in variable
	mov di, OFFSET revmessage + messagesize	

;loop1 moves the values at si and di to the correct locations
;then, incremnting si, and decrementing di
loop1:

	mov ax, [si]					;move value at source index to ax
	mov [di], ax					;move value at ax into destination index
	dec di							;decrement destination index
	inc si							;incremnt source index
	loop loop1
				
mov cx, messagesize					;set up loop counter

;set bx to location of reversed message for printing to console
mov bx, OFFSET revmessage+2

;prints reversed string to console, one char at a time
textprinter:

	mov dx, [bx]					;move value at bx into dx
	mov ah,2h						;move 2h to ah for func call
	int 21h							;call INT21, printing char
	inc bx							;increment bx to point to next char
	loop textprinter
	
;exit	
mov ax,4c00h
int 21h

main endp

end main
