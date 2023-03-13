ClearSRamFromFlash:
	push	af														; store original af value, just in case
	push	hl
	push	de
	push	bc
	
	ld hl,.JumpDisableInterruptsReturn
	jp SaveAndDisableInterrupts						; Interrupts disabled
.JumpDisableInterruptsReturn

	ld a,BANK(VerifyChecksumFlashAgainstFlashRoutine)		; Bank of VerifyChecksumFlashAgainstFlashRoutine
	ld hl,VerifyChecksumFlashAgainstFlashRoutine				; Bank of VerifyChecksumFlashAgainstFlashRoutine
	ld	bc,VerifyChecksumFlashAgainstFlashRoutineEnd - VerifyChecksumFlashAgainstFlashRoutine  ; Length to Copy
	ld	de,wWriteFlashCodeExecStart 						; Set WRAM destination
	call SwitchBankLoadDataAndReturn				; EraseFlashBlock
	call VerifyChecksumFlashAgainstFlash				; We can run this directly from 1C

	ld a,BANK(EraseFlashBlockRoutine)					; Bank of EraseFlashBlock
	ld hl,EraseFlashBlockRoutine							; EraseFlashBlock
	ld	bc,EraseFlashBlockRoutineEnd - EraseFlashBlockRoutine  ; Length to Copy
	ld	de,wWriteFlashCodeExecStart 						; Set WRAM destination
	call SwitchBankLoadDataAndReturn				; EraseFlashBlock
	ld	a,BL_FLASHBANK_0									; Block to start from
	call EraseFlashBlock										; EraseFlashBlock
	ld	a,BL_FLASHBANK_1									; Block to start from
	call EraseFlashBlock										; EraseFlashBlock
	ld	a,BL_FLASHBANK_2									; Block to start from
	call EraseFlashBlock										; EraseFlashBlock
	ld	a,BL_FLASHBANK_3									; Block to start from
	call EraseFlashBlock										; EraseFlashBlock
;
; Restore interrupts
;	
	ld hl,.JumpRestoreInterruptsReturn
	jp RestoreInterrupts
.JumpRestoreInterruptsReturn

	pop	bc
	pop	de
	pop	hl
	pop af															; Restore original af value, just in case
	ret