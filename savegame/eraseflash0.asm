; Probably need to expand this to 4 blocks
EraseFlashBlockRoutine:
LOAD UNION "WriteFlashCodeExec", WRAM0
EraseFlashBlock::
	push	hl
	push	de
	push	bc
	ld	[MBC1RomBank+$0100],a		; Set $2100 RomBank Address to 'a'
	nop
	ld	a,$F0
	ld	[MBC1SRamBank],a		; Switch SRamBank to $F0
	nop
	ld	a,$A9
	ld	[$0555],a					; Load A9 into memory at 0555,  address bus
	nop
	ld	a,$56
	ld	[$02AA],a					; Load 56 into memory at 02AA,  address bus
	nop
	ld	a,$80
	ld	[$0555],a					; Load 80 into memory at 0555,  address bus, might be start position
	nop
	ld	a,$A9
	ld	[$0555],a					; Load A9 into memory at 0555,  address bus
	nop
	ld	a,$56
	ld	[$02AA],a					; Load 56 into memory at 02AA,  address bus
	nop
	ld	a,$30
	ld	[MBC1SRamBank],a		; Switch SRamBank to $30
	nop
.loopDF33
	ld	a,[MBC1SRamBank]		; Read SRamBank value
	cp	a,$FF		
	jp	z,.loopDF3E	
	jp	.loopDF33	
.loopDF3E
	nop		
	ld	a,$F0
	ld	[MBC1SRamBank],a		; Switch SRamBank to $F0
	pop bc
	pop de
	pop hl
	jp SwitchToFlashCodeBank
; Continue in writeflash1 function
; should be ok, because we are writing the last half of the bank, dno if it erases full bank tho
ENDL
EraseFlashBlockRoutineEnd:

