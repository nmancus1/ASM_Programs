;Nick Mancuso
;CIS130
;This is a short program to print a string to the console, one 
;char at a time, using dos function 2h


title Hello World Program (hello3.asm)

.model small

.data

message db "Hello, DOS Here!"

.code

main proc

	mov ax,@data				;move data to ax

	mov ds,ax					;move data from ax to data segment
	
	;set up textprinter loop
	mov cx, SIZEOF message		;move sizeof message to loop counter
	
	;move location of message to bx and increment 
	;within loop to iterate through string
	mov bx, OFFSET message		
	
;textprinter loop
textprinter:

	mov dl, [bx]				;move value of data in bx to dl

	mov ah,2h					;move 2h to ah to set up char print from INT21

	int 21h						;call INT21
	
	inc bx						;increment bx to point at next letter
	
	loop textprinter			
	
	

	;exit
	mov ax,4c00h				;move 4c00h to ax 
	
	int 21h						;call INT21 to exit

main endp



end main
