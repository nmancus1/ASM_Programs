;Nick Mancuso
;CIS130
;
;This is a short program to convert a hex number to decimal and
;print it to the console, using procedures.

title Print Decimal From Hex (u2Prn10b.asm)

.model small

.code

main proc

	mov bx, 0h						;zero out bx, it is used as counter
	mov ax, 7fffh					;mov number to be converted to AX

	call hexToDec 					;call hextoDec procedure
	
	;hexToDec returns bx as a counter, mov to cx for print from stack
	mov cx, bx						
	
	call printFromStack				;call printFromStack procedure
		
	mov ah,4ch						;mov 4ch to ah for int21 call
	int 21h							;call int21 to exit
	
main endp

;-----------------------------------------------------------------------
hexToDec Proc
;
;Procedure to convert a hex number to decimal and push it to the stack.
;It also returns a counter value in BX for other procedures to use.  It
;employs a while loop construct to repeatedly divide AX by CX and 
;push the resulting remainder (DX) to the stack, while incrementing the
;counter return value (BX).
;
;Receives:
;AX = hex value to convert, dividend
;BX = zero'd out counter
;
;Returns:
;BX = counter for other procs to use
;-----------------------------------------------------------------------

		pop es						;pops main return address from stack

	L1:								
		cmp ax, 0h					;ax == 0?
		jz label1					;if true, jump to label1
	
		mov dx,0h					;zero out dx(remainder)
		mov cx, 0ah					;mov 0ah to cx to become divisor
		div cx						;divide ax/cx
		push dx						;push remainder to stack
		inc bx						;increment bx
		loop L1
		
	label1:
	
	push es							;push return value back to stack
	
	ret								;return
	
	hexToDec endp
;-----------------------------------------------------------------------	
;-----------------------------------------------------------------------	
printFromStack PROC
;
;Procedure to print numerical ASCII chars from values in the stack. Uses 
;DOS interrupt 21's 2h function to print to console. 30h is added to the 
;values in the stack to acheive the corresponding ASCII char before 
;printing.
;
;Receives:
;CX = counter for loop
;
;Returns: Nothing
;-----------------------------------------------------------------------	
	pop es							;pop main return address from stack
	
	mov ah, 02h						;mov 2h to ah for int21 call to print
	
	L2:	
		pop dx						;pop value from stack
		add dx, 30h					;add 30h to get correct char
		int 21h						;call int21 to print
		loop L2
		
	push es							;push return value back to stack
		
	ret								;return to main
		
	printFromStack endp
;-----------------------------------------------------------------------	
				



end main
