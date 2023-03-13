; Assumes a save stored from 0x6000 in chunks of 0x2000 in 4 ROM banks
;                BANK#                    BIN Location   ROM Location
; ex. RO38 : 0x38 * 4000 + 2000 = 0xE2000  @  RO38:6000
; ex. RO39 : 0x39 * 4000 + 2000 = 0xE6000  @  RO39:6000
; ex. RO3A : 0x3A * 4000 + 2000 = 0xEA000  @  RO3A:6000
; ex. RO3B : 0x3B * 4000 + 2000 = 0xEE000  @  RO3B:6000
;
LoadSRamFromFlash:
; Store the values of existing registers we are going to make use of
	push af
	push hl
	push de
	push bc

	ld hl,.JumpDisableInterruptsReturn
	jp SaveAndDisableInterrupts						; ; Not exactly needed, dosnt do anyting except store ram settings for us
.JumpDisableInterruptsReturn

	ld b, $0 														; SRam Bank#0, destination	
	call SelectSRamBankAndEnableSRam
	ld a, BL_FLASHBANK_0									; ROM Bank #38, 2nd 8k save bank, source
	call SetDestinationAndLength
	call SwitchBankLoadDataAndReturn

	ld b, $1															; SRam Bank#1, destination	
	call SelectSRamBankAndEnableSRam
	ld a, BL_FLASHBANK_1									; ROM Bank #39, 2nd 8k save bank, source
	call SetDestinationAndLength
	call SwitchBankLoadDataAndReturn
	xor a

	ld b, $2															; SRam Bank#2, destination	
	call SelectSRamBankAndEnableSRam
	ld a, BL_FLASHBANK_2									; ROM Bank #3A, 2nd 8k save bank, source
	call SetDestinationAndLength
	call SwitchBankLoadDataAndReturn
	xor a

	ld b, $3															; SRam Bank#3, destination	
	call SelectSRamBankAndEnableSRam
	ld a, BL_FLASHBANK_3									; ROM Bank #3B, 2nd 8k save bank, source
	call SetDestinationAndLength
	call SwitchBankLoadDataAndReturn
	; At this point, we have disabled SRAM, and we are in block 03

	ld hl,.JumpRestoreInterruptsReturn
	jp RestoreInterrupts										; Restore ram settings, interrupts are just a sideeffect
.JumpRestoreInterruptsReturn

	pop bc
	pop de
	pop hl
	pop af
	ret

; Disable SRam
; Enable SRam
; Set SRam banking mode 0A
; Set SRam bank# in b
SelectSRamBankAndEnableSRam:
	xor a
	ld [MBC1SRamBankingMode], a 	; Set MBC1SRamBankingMode 0
	ld [MBC1SRamEnable], a				; MBC1SRamEnable = 0
	ld a, SRAM_ENABLE						; Load the sram_enable value into A
	ld [MBC1SRamEnable], a       		; Set the memory location for sram enable to A
	ld a, $1										; Store 1 into a
	ld [MBC1SRamBankingMode], a		; Set MBC1SRamBankingMode 1	$6000
	ld a, b										; SRam Bank#a, 	Store 1 into a, <- its 01
	ld [MBC1SRamBank], a				; SRam Bank#a
	ret

; Switches to ROM# in a, 
; Sets source location in ROM# to 0x6000 (0x2000 bytes before end of 0x4000),
; Sets a length to copy of 0x2000, to the end of the ROM#
SetDestinationAndLength:
	ld hl,$6000								; Source start location 0x6000 in rombank, Rombank Starts at 0x4000
	ld de, SRAM_Begin						; Destination SRAM Begin, $A000; Source Address
	ld bc, SRAM_End - SRAM_Begin  ; Length = 2000
	ret

