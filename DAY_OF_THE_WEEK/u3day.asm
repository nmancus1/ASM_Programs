;
;Nick Mancuso
;CIS130
;
;This program prompts the user to input a char, and prints 
;the corresponding day of the week to the console, and repeats
;until 'enter' is pressed to exit. This program checks for 
;valid input, and will print an error msg if input is not valid.
;*******************************************************************************

title Days of Week (u3day.asm)

.model small

.data

;declare and init all char arrays, terminated 
;with '$' for int21h f9 printing to console
greeting db 0dh,0ah,	"Please enter a number between 0 and 6 (Enter to stop): $"
outputString db 0ah,0dh,	"The day of the week is $"
errorMsg db 0ah, 0dh, "Input invalid", 0ah,"$"
testMsg db "Testing$"
goodBye db "Goodbye!$"

;declare variable to store user input
userInput db ?

;declare and init individual char arrays, terminated 
;in $ for int21h f9 printing to console
sun db "Sunday$"
mon db "Monday$"
tue db "Tuesday$"
wed db "Wednesday$"
thur db "Thursday$"
fri db "Friday$"
sat db "Saturday$"

;create WORD array, and initialize it with above char arrays
weekDayArray dw sun, mon, tue, wed, thur, fri, sat

;create variable based on size of element in WORD array
;used for multiplication (with user input) to determine location of correct
;char array to print
sizeOfElements = type weekDayArray

.code

main proc

		;move data address into data segment
		mov ax, @data
		mov ds,ax
			
	MENULOOP:
	
			;set up call to INT21 to print message to console
			mov userInput, 0h							;zero out userInput
			
			mov ah,9h									;mov 9h to ah for INT21 call
			mov dx,OFFSET greeting				;set starting point for func 9h
			int 21h											;call 21h
		
			mov ax, 0h									;zero out ax
			mov ah, 1h									;mov 1h to ah for INT21 call to accept input
			mov dl, 0ffh									;mov 0ffh to dl for INT21 call to accept input
			int 21h											;call INT21 to accept single digit of input
			
			;sentinel value is carriage return, if entered, jump to PRNT_GOODBYE_EXIT
			mov userInput, al							;move input into userInput
			cmp userInput, 0dh						;if userInput == enter (carriage return),
			je PRNT_GOODBYE_EXIT					;jump to PRNT_GOODBYE_EXIT to exit
			
			
			;if userInput is not valid (userInput < 30h || userInput > 36h)
			;jump to error message
			cmp userInput, 30h						;compare input to 30h
			jl PRINT_ERR_MSG							;if less, jump to err message
			
			cmp userInput, 36h     					;compare input to 36h
			jg PRINT_ERR_MSG						;if more, jump to err message
			
			;else, input is good, jump to PRNT_DAY_OF_WEEK						
			jmp	PRNT_DAY_OF_WEEK					
											
		;error message							
		PRINT_ERR_MSG:
				mov ah, 9h								;set up f9
				mov dx, OFFSET errorMsg			;point to errorMsg
				int 21h										;call int21h to print
				jmp MENULOOP							;continue looping menu
			
			
		PRNT_DAY_OF_WEEK:
				mov ah,9h								;mov 9h to ah for INT21 call
				mov dx,OFFSET outputString		;set starting point for func 9h
				int 21h										;call 21h
				
				sub userInput, 30h					;subtract 30h because userInput is read as ASCII
																;makes for easier calculations later
												
				mov bx, offset weekDayArray	;mov address of array to bx
				mov ax, 0h								;zero out ax
				mov al, userInput						;move user input value into al(ax)
				mov cx, sizeOfElements			;set up mul call to set position in array
				mul cx										;userInput * 2
				mov si, ax									;move result into source index
				mov dx, [bx + si]						;move pointer to array element into dx for printing

				mov ah, 9h								;set up int21 call to print to console
				int 21h										;print to console

	jmp MENULOOP										;loop menu again

		PRNT_GOODBYE_EXIT:
			mov ah,9h									;mov 9h to ah for INT21 call
			mov dx,OFFSET goodBye				;set starting point for func 9h
			int 21h											;call 21h
			
			mov ah,4ch									;mov 4ch to ah for int21 call
			int 21h											;call int21 to exit
		
	main endp
end main
	
