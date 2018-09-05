;Nick Mancuso
;CIS130-401
;
;This is short program to convert an 8-bit hex number to an ASCII char
;and print it to the console.
;***********************************************************************


.model small

.data

message db "The hex number is $"

myNum byte 9ch

.code

main proc

	mov ax, @data					;mov data to ax
	mov ds, ax						;mov ax to data segment
	
	mov ah,9h						;set up INT21 call for '$' term string
	mov dx,OFFSET message			;set starting point for func 9h
	int 21h							;call INT21 to print to console	

	mov dl, myNum					;mov variable into bl
	and dl, 0f0h					;mask lower 4 bits
	
	;loop to shift four bits to the right
	mov cx, 4						;loop counter for 4 bits to shift
	loop1:
		shr dl,1
		loop loop1
	
	call hexToAsciiPrint

	mov dl, myNum					;mov myNum back into dl
	and dl,0fh						;mask upper 4 bits now
	
	call hexToAsciiPrint
	
	;set up exit
	mov ah, 4ch
	int 21h

	main endp
	
;-----------------------------------------------------------------------	
hexToAsciiPrint PROC 
;-----------------------------------------------------------------------
;
;Accepts a nibble, converts it to a ASCII char, and prints it to the
;console. To convert, it adds 30h to gets around to where we need to be 
;on the ASCII table. Then it compares the value to see if it is a letter
;or number (N<L), then either jumps to INT21 to print (Number), or adds
;7 (to bypass the punctuation on the ASCII table)(letter).
;
;Receives:
; DL = Nibble to be converted and printed
;
;Returns: Nothing
;-----------------------------------------------------------------------
	mov ah, 02h
	add dl, 30h						;add 30h to dl value to get correct ASCII char
	cmp dl, 3ah						;see if value == number or letter (N<L)
	jl print						;if number, jump to INT21 to print

		;if letter, add 7 to skip punctuation in ASCII table
		add dl,7						

		;call INT21 to print first char to console
		print:				
			int 21h
			
	ret
			
hexToAsciiPrint endp


end main

