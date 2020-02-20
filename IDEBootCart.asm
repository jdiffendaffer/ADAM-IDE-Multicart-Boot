;*****************************************************************
;* IDE Boot Cart.asm
;*****************************************************************
;* Coleco Adam code to boot the MICRO-INNOVATIONS IDE board 
;* from a game cart instead of the rare parallel card, or tape.
;* Loads he driver, and launches it from intrinsic RAM.
;* This does not include the driver code, as I do not own the
;* copyright to that.
;* This approach could be used to load other programs or drivers 
;* that were not designed to run from a game cart.
;*****************************************************************


;*****************************************************************
;* test cart header
;*****************************************************************
	org	8000H	; start of cart memory
	
	DCB	55H,0AAH	; test cart ID
	DCB	00,00,00,00,00,00,00,00	; filler, we don't use this
;	org	800AH		; location of cart start address
	DCW	CARTSTART	; cart start address, used to execute cart code
;*****************************************************************

;*****************************************************************
;* the first code executed in the cart	
;* Steps match the post where I listed them on Atariage.
;*****************************************************************
CARTSTART:

; Step 1, copy from cart to OS7/24k intrinsic RAM
	di			; interrupts would be bad durring this process

	; copy code from cart into 24K intrinsic RAM
	ld	hl,LOWRAMCODE			; start
	ld	de,2000H				; destination... start of RAM
	ld	bc,ENDCODE - LOWRAMCODE	; length
	ldir
	jp	2000H					; call code in 24K intrinsic RAM

; code from here on to be copied	
LOWRAMCODE:
; Step 2, copy from OS7/24K intrinsic RAM bank to high intrinsic RAM bank
	org	2000H		; start of 24K Intrinsic RAM
	ld	a,9H
	out	(03H),a	; Select intrinsic RAM in upper bank and OS7/24K intrinsic RAM in lower bank

	; copy startup code from lower RAM into intrinsic RAM
	ld	hl,BOOTCODE		; start
	ld	de,8000H		; destination
	ld	bc,ENDCODE - BOOTCODE	; length
	ldir
	
	ld	a,01h		; to patch ROM to use intrinsic RAM upper and lower 
	ld	(8004h),a	; patch 05h to 01h
	
	jp	8002h			; call boot ROM code in high RAM

BOOTCODE:
;IDE driver we want to load goes here. 
	dcb		66h,99h,0F3h,3Eh,05h,0D3h,7Fh,21h,0EDh,45h,22h,66h,00h,21h,1Bh,80h
;... most of driver deleted
	dcb		0C2h,3Ch,0E8h,0C3h,4Fh,0E8h,00h
ENDCODE:
	end
	