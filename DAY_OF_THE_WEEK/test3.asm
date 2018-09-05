so
;CIS130-401
;
;This is short program to convert a hex number to an ASCII char
;and print it to the console.
;***********************************************************************


.model small

.code

main proc

	mov bl, 9ch
	and bl, 0f0h
	mov cx, 4

	loop1:
		shr bl,1
		loop loop1

	mov ah,02h
	mov dl,bl
	add dl,30h
	cmp dl,3ah
	jl print

	add dl,7

	print:
		int 21h

	mov dl, 9ch
	and dl,0fh
	add dl,30h
	cmp dl,3ah
	jl print2

	dd dl,7h

	print2:
		int 21h

	mov ah, 4ch
	int 21h

	main endp
end main

