; Used for loading the save into SRAM
; We have to be in ROM0 because we are loading data from a bank that has no codespace to run
; a : Source Bank
; hl : Source Start Address
; bc : Length to copy
; de : Set destination address
SwitchBankLoadDataAndReturn::
;Switch bank 
	ldh [hLoadedROMBank], a			; Set the memory value for the current rom bank (high mem MBC3+)
	ld [MBC1RomBank], a		; execute switch to rom bank# stored in A, execution now jumps way past the next line, because we were executing from 1C and now were in 34, which explains why its switching bank after jumping to this code and not before
	.loop					; 
	ldi a, [hl]   		; Load the byte at the address stored in HL into A and increment HL
	ld [de],a			; Store the byte from A into the address at (de)
	inc de			; Increment destination SRam address
	dec bc			; Decrement bytes left
	ld a,c			; Loads C register into A
	or b				; Compares A to B and Stores result back into A
	jp nz, .loop			; jp to ROM0:00E3
;	Call CopyData 		; We can use this function already in pokemon red/blue, but then we're less portable
	jp SwitchToFlashCodeBank
	

RestoreStackRestartGame::
	pop hl
	pop de
	pop bc
	pop af
	jp $0150	; Restart game

