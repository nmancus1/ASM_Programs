;Nick Mancuso
;CIS130
;This is a short program to print a string to the console using DOS
;function 9h

title Hello World Program (hello2.asm)

.model small

.data

message db "Hello, DOS Here!$"		;string terminated with '$' for func 9h 

.code

main proc

	mov ax,@data		 			;mov data to ax

	mov ds,ax						;mov data from ax to data segment


	;set up call to INT21
	mov ah,9h						;mov 9h to ah for INT21 call

	mov dx,OFFSET message			;set starting point for func 9h

	int 21h							;call 21h

	;end program
	mov ax,4c00h					;mov 4c00h into ax			
	
	int 21h							;call INT21h to exit

main endp



end main
