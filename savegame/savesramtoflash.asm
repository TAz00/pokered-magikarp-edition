SaveSRamToFlash::
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
	call VerifyChecksumFlashAgainstFlash				; We could run this directly from 1C

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

; Copies 'SaveSRamBankToFlash' routine to memory
	ld a,BANK(SaveSRamBankToFlashRoutine)		; Bank of SaveSRamBank0ToFlashRoutine
	ld hl,SaveSRamBankToFlashRoutine
	ld	bc,SaveSRamBankToFlashRoutineEnd - SaveSRamBankToFlashRoutine  ; Length to Copy
	ld	de,wWriteFlashCodeExecStart 						; Set WRAM destination
	call SwitchBankLoadDataAndReturn
	
; Calls 'SaveSRamBankToFlash' in memory, copy SRam 0, to Flash 0
	ld a,$00
	ld [wSRamBankNumToSave],a
	ld	a,BL_FLASHBANK_0
	call SaveSRamBankToFlash

; Calls 'SaveSRamBankToFlash' in memory, copy SRam 1, to Flash 1
	ld a,$01
	ld [wSRamBankNumToSave],a
	ld	a,BL_FLASHBANK_1
	call SaveSRamBankToFlash

; Calls 'SaveSRamBankToFlash' in memory, copy SRam 2, to Flash 2
	ld a,$02
	ld [wSRamBankNumToSave],a
	ld	a,BL_FLASHBANK_2
	call SaveSRamBankToFlash

; Calls 'SaveSRamBankToFlash' in memory, copy SRam 3, to Flash 3
	ld a,$03
	ld [wSRamBankNumToSave],a
	ld	a,BL_FLASHBANK_3
	call SaveSRamBankToFlash

	ld hl,.JumpRestoreInterruptsReturn
	jp RestoreInterrupts
.JumpRestoreInterruptsReturn

	pop	bc
	pop	de
	pop	hl
	pop af															; Restore original af value, just in case
	ret

