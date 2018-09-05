;Nick Mancuso
;CIS130
;
;This is a short program to reverse a string and print it to console,
;employing several PROCs

title Hello World Program (hello7.asm)

.model small

.data

message db "Hello, DOS Here!",0

revmessage db ?						;variable to store reversed string

messagesize = SIZEOF message 		;variable to hold size of string


.code

main proc

	mov ax,@data					;move data into ax
	mov ds,ax						;move data from ax into data segment
	
	;set up call to copyStr
	mov cx, messagesize				;variable for counters, size of string
	mov si, OFFSET message-1		;offset of original message
	;offset of destination string, points to last index
	mov di, OFFSET revmessage + messagesize
	
call copyStr						;takes CX,SI,DI

	;set up call to prnStr
	mov cx, messagesize				;set loop counter	
	mov bx, OFFSET revmessage+2		;point to index 0 of revmessage

call prnStr							;takes BX, CX

call prnCrLf						;takes nothing

	;exit
	mov ax,4c00h
	int 21h

main endp

;-----------------------------------------------------------------------
copyStr PROC
;-----------------------------------------------------------------------
;Copies string of chars into a variable, pointed to by di
;Receives:
;CX = counter, set to string size
;SI = source of string to be reversed, pointing to index 0
;DI = destination of reversed string (variable), pointing to last 
;	index(use size of string + offset of new string to calculate)
;Returns: nothing
;-----------------------------------------------------------------------

loop1:

	mov ax, [si]					;move value at source index to ax
	mov [di], ax					;move data at ax to destination index
	dec di							;decrement destination index
	inc si							;increment source index	
	loop loop1
	
	ret								;return to main

copyStr ENDP


;-----------------------------------------------------------------------
prnStr PROC
;-----------------------------------------------------------------------
;Uses DOS func 2h from INT21h to print one char to the console 
;Receives:
;CX = loop counter, set to string size
;BX = index 0 of string to print
;Returns: Nothing
;-----------------------------------------------------------------------

textprinter:

	mov dx, [bx]					;move value in bx into dx
	mov ah,2h						;move 2h into ah to print to STDOUT
	int 21h							;call INT21
	inc bx							;increment bx to point to next letter
	loop textprinter
	
	ret								;return to main
	
prnStr ENDP

;-----------------------------------------------------------------------
prnCrLf PROC
;-----------------------------------------------------------------------
;Simply prints a carriage return and line feed, using
;INT21h and DOS func 2h
;Receives: Nothing
;Returns: Nothing
;-----------------------------------------------------------------------
	
	mov dl, 0ah						;line feed char into dl
	mov ah,2h						;move 2h into ah to print to STDOUT
	int 21h							;call INT21
	
	mov dl, 0dh						;carriage return char into dl
	mov ah,2h						;move 2h into ah to print to STDOUT
	int 21h							;call INT21
	
	ret								;return to main

prnCrLf ENDP
	
	
	

end main

	

