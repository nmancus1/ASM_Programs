;Nick Mancuso
;CIS130
;
;This is a short program to push and pop a string from the the stack, 
;reversed, into a variable and print to console


title Hello World Program (hello5.asm)

.model small

.data

message db "Hello, DOS Here!",0

revmessage db ?						;variable for reversed string

messagesize = SIZEOF message 		;variable for size of message


.code

main proc

	mov ax,@data					;move data to ax
	mov ds,ax						;move data from ax to data segment
	mov cx, messagesize 			;set up loop counter
	mov si, OFFSET message			;set up source index for message

;loop1 pushes string to stack
loop1:

	mov ax, [si]					;move value at source index to ax
	push ax							;push value at ax to stack
	inc si							;increment source index
	loop loop1
	
mov cx, messagesize					;set up loop counter

;set destination index to location of revmessage var
mov di, OFFSET revmessage 			

;loop2 pops string from stack 	
loop2:

	pop ax							;pop value in stack to ax
	mov [di],ax						;move data in ax into destination index 
	inc di							;increment destination index
	loop loop2
	
mov cx, messagesize 				;set up loop counter

;move location of revmessage to bx for printing 
mov bx, OFFSET revmessage 

;textprinter loop sets up INT21 for func 2 call to print to console
textprinter:

	mov dl, [bx]					;move value at bx into dl
	mov ah,2h						;move 2h into ah for STDOUT
	int 21h							;call INT21
	inc bx							;increment bx to point at next letter
	loop textprinter
	
;exit
mov ax,4c00h
int 21h

main endp

end main
