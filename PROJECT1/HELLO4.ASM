;Nick Macuso
;CIS130
;
;This is a short program to push a string to the stack, pop it out,
;and print it to the console in reverse


title Hello World Program (hello4.asm)

.model small

.data

message db "Hello, DOS Here!",0

messagesize = SIZEOF message 		;variable to store size of message

.code

main proc

	mov ax,@data					;move data to ax
	mov ds,ax						;move data from ax to data segment
	mov cx, messagesize 			;move messagesize var to loop counter
	mov si, OFFSET message			;move location of message to source index

;loop to push value at source index to stack
loop1:

	mov ax, [si]					;move value at source index to ax
	push ax							;push value to stack
	inc si							;increment source index
	loop loop1
	
mov cx, messagesize					;set up counter again

;loop to pop value from stack into dx for printing, char by char	
loop2:

	pop dx							;pop value from stack into dx for
	mov ah,2h						;DOS func 2 call from
	int 21h							;INT21
	loop loop2
	
;exit
mov ax,4c00h						
int 21h
	
main endp

end main
