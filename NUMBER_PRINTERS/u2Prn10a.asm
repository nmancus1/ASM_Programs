;Nick Mancuso
;CIS130
;
;This is a short program to convert a hex number to decimal and
;print it to the console.
;-----------------------------------------------------------------------

title Print Decimal From Hex (u2Prn10a.asm)

.model small

.data

message db "HEX = 7FFF", 0dh, 0ah, "Decimal = $"

.code

main proc

	mov ax,@data					;mov data to ax
	mov ds,ax						;mov data from ax to data segment

	;set up message print
	mov ah,9h						;mov 9h to ah for INT21 call to print
								;	a '$' terminated string

	mov bx, 0h						;zero out bx
	mov ax, 7fffh					;mov value to convert into ax
	
	;loop 1 repeatedly divides the value in ax by cx, and pushes the
	;remainder to the stack
	L1:
		cmp ax, 0h					;ax == 0?
		jz label1					;if true, jump to label1
	
		mov dx,0h					;zero out dx(remainder)
		mov cx, 0ah					;mov 0ah to cx for divisor
		div cx						;divide ax/cx
		push dx						;push remainder to stack
		inc bx						;increment bx to return as counter
		loop L1
		
	label1:
	
	;set up call to INT21 to print message to console
	mov ah,9h						;mov 9h to ah for INT21 call
	mov dx,OFFSET message			;set starting point for func 9h
	int 21h							;call 21h
	
	;set up counter for loop to print decimal number and mov 02h 
	;to ah for single char printing 			
	mov cx, bx						;cx to become counter for loop
	mov ah, 02h						;02h to ah for int21 call to print
	
	
	
	;loop 2 repeatedly pops values from the stack, adds 30h to get
	;corresponding ASCII value, and prints it to the console.
	L2:	
		pop dx						;pop value from stack
		add dx, 30h					;add 30h to get corresponing ASCII
		int 21h						;call int21 to print
		loop L2
		
	mov ah,4ch						;set up 4ch in ah for exit
	int 21h							;call 21h to exit
	
main endp

end main
