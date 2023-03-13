; Store SRambank to copy from in [wBankNumToSave]
; Store RomBank# to copy to in 'a'
SaveSRamBankToFlashRoutine:
LOAD UNION "WriteFlashCodeExec", WRAM0
SaveSRamBankToFlash::
	push hl
	push de
	push bc
	ld	[MBC1RomBank+$0100],a		; Switch to Rom Bank in 'a'
	ld	hl,$A000								; SRAM_Begin, destination?
	ld	de,$6000								; ROM Location, source?
.loopDF0E
	ld a,SRAM_ENABLE					; $0A will enable reading and writing to external RAM
	ld	[MBC1SRamEnable],a			; SRam Enable
	ld a,$01									; SRam banking mode 01
	ld [MBC1SRamBankingMode],a	; SRam banking mode
	ld a,[wSRamBankNumToSave]	; SRam Bank 00
	ld [MBC1SRamBank],a				; SRam Bank 00						$4000
	ld a,[hl]									; Read SRam Value, value in SRam into A
	ld b,a										; A into B
	ld	a,$00									; Load 00 into a
	ld	[MBC1SRamBankingMode],a	; Ram Banking mode 0			$6000
	ld	[MBC1SRamEnable],a			; Ram Disable						$0000
	ld	a, $F0									; Switch SRamBank to $F0
	ld	[MBC1SRamBank],a				; Switch SRamBank to $F0		$4000
	nop
	ld	a,$A9
	ld	[$0555],a					; Load A9 into memory at 0555,  address bus
	nop
	ld	a,$56
	ld [$02AA],a					; Load 59 into memory at 02AA,  address bus
	nop
	ld	a,$A0
	ld	[$0555],a					; Load A0 into memory at 0555,  address bus
	nop
	ld	a,b							; Value from SRam into A
	ld	[de],a						; Write value from SRam into location of de 	$6000
.loopDF41
	ld	a,[de]						; Read written value back
	xor b							
	jp	z,.loopDF49				
	jp .loopDF41
.loopDF49
	inc hl
	inc de
	ld	a,h
	cp	a,$C0
	jp nz,.loopDF0E
	ld	a,$F0
	ld	[MBC1SRamBank],a		; Switch SRamBank to $F0
	pop bc
	pop de
	pop hl
	jp SwitchToFlashCodeBank
;	ret
ENDL
SaveSRamBankToFlashRoutineEnd:

