SaveAndDisableInterrupts:
	di						; Disable Interupts, prevents the Game Boy from responding to interrupts
	ldh a,[rIE]			; Store Interrupt Enable (R/W)
	push af				; Save to Stack
	ldh a,[rIF]			; Store Interrupt Flag (R/W)
	push af				; Save to Stack
	ldh a,[rTAC]		; Store Timer Control (R/W)
	push af				; Save to Stack
	ldh a,[rSTAT]		; Store LCDC Status (R/W)
	push af				; Save to Stack
	ldh a,[rNR50]	; Store Channel control / ON-OFF / Volume (R/W)
	push af				; Save to Stack
	halt					; Wait for interupt
;	nop					; GBZ Quirk, halt with no interrupts skips the next command, its ok tho, cuz we've only stored them so far

	xor a				; A = 0, incorrect, xors the value currently in register A
	ldh [rIE],a			; Zero Interrupt Enable
	ldh [rIF],a			; Zero Interrupt Flag
	ldh [rTAC],a		; Zero Timer Control
	ldh [rSTAT],a		; Zero LCDC Status
	ldh [rNR50],a	; Zero Channel control / ON-OFF / Volume (R/W)

	ld a, [MBC1SRamBank]
	push	af			; Store SRamBank# on the stack
	ld a,[MBC1SRamBankingMode]
	push	af			; Store SRam banking mode# on the stack
	ld a, [MBC1SRamEnable]
	push	af			; Store SRamBank# on the stack

	jp hl

RestoreInterrupts:
	xor a										; Zero SRam
	ld [MBC1SRamBankingMode], a 	; Set MBC1SRamBankingMode 0
	ld [MBC1SRamEnable], a			; MBC1SRamEnable = 0

	pop af										; Load the sram_enable value into A
	ld [MBC1SRamEnable], a			; Set the memory location for sram enable to A
	pop	af										
	ld [MBC1SRamBankingMode], a 	; Set MBC1SRamBankingMode
	pop	af										; Restore RamBank#
	ld [MBC1SRamBank],a				; Switch back to correct ram bank, 

	pop	af
	ldh [rNR50],a
	pop	af
	ldh [rSTAT],a
	pop	af
	ldh [rTAC],a
	pop	af
	ldh [rIF],a
	pop	af
	ldh [rIE],a
	ei
	jp hl

