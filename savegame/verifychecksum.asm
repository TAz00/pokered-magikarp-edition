; May be comparing rom checksom to manufacturer and device id code
; This verifies the regular checksum location, 0x014E + 0x014F against something on the chip
; The checksum must be 0x04 + 0xC7 for the verification to work
; Moved chip id and manufacturer id to header
VerifyChecksumFlashAgainstFlashRoutine:
LOAD UNION "WriteFlashCodeExec", WRAM0
VerifyChecksumFlashAgainstFlash::
;	ld a,[$014E]					; First value of global rom checksum, '0x04' in bootleg rom
	ld a,[$0019]					; Moved chipID and ManufacturerID to header
	ld	h,a
;	ld a,[$014F]					; Second value of global rom checksum '0xC7' in bootleg rom
	ld a,[$001A]					; Moved chipID and ManufacturerID to header
	ld	l,a
	ld	a,$F0
	ld	[MBC1SRamBank],a		; Switch SRamBank to $F0
	nop
	ld	a,$A9
	ld	[$0555],a					; Load A9 into memory at 0555,  address bus
	nop
	ld	a,$56
	ld [$02AA],a					; Load 59 into memory at 02AA,  address bus
	nop
	ld	a,$90
	ld	[$0555],a					; Load 90 into memory at 0555,  address bus
	nop
	ld	a,[$0000]					; Chip/Manufacturer ID,  Load the value from 0xF0 memory at 0000, MBC1SRamEnable
	cp	h								; Compare h to a
	jp	nz,RestoreStackRestartGame					; Jump to gamestart (probably not good as we're trying to save)
	ld	a,[$0002]					; Chip/Manufacturer ID, Load the value from memory at 0002
	cpl								; Compare A to L
	jp	nz,RestoreStackRestartGame				; Jump to gamestart (probably not good as we're trying to save)
	ld	a,$F0
	ld	[MBC1SRamBank],a		; Switch SRamBank to $F0, we could probably un-hardcode this
	nop
	ret
ENDL
VerifyChecksumFlashAgainstFlashRoutineEnd:

