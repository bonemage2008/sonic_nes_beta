; =============== S U B	R O U T	I N E =======================================


continue_screen:
		LDA	vram_buffer_adr_h
		BNE	continue_screen
		JSR	wait_vbl
		LDA	#0
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STA	ppu_ctrl2_val
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STA	ppu_tilemap_mask
		JSR	fill_nametable1_with_FFs
		LDX	#$FF
		STX	irq_func_num
		JSR	hide_all_sprites
		JSR	load_cont_scr_vram
		LDA	#$2B
		STA	music_to_play
		
		LDA	#$BF
		STA	sprite2_Y
		LDA	#$48
		STA	sprite2_X
		LDA	#$68
		STA	sprite2_tile
		LDA	#3
		STA	sprite2_attr
		
		LDX	#24
		JSR	setup_chr_banks
		JSR	load_cont_sprites
		;JSR	cont_sprites_anim
		
		LDA	#$80
		JSR	enable_nmi

cont_scr_loop:
		JSR	wait_next_frame
		JSR	cont_sprites_anim
		LDA	joy1_press
		LSR	A	; BUTTON_RIGHT
		BCC	loc_182D63
		LDA	#$98
		BNE	loc_182D68
		
loc_182D63:
		LSR	A	; BUTTON_LEFT
		BCC	loc_182D6B
		LDA	#$48
		
loc_182D68:
		STA	sprite2_X

loc_182D6B:
		LDA	joy1_press
		AND	#BUTTON_B|BUTTON_A|BUTTON_START
		BEQ	cont_scr_loop
		LDA	sprite2_X
		BPL	loc_C2D86
		JMP	RESET
; ---------------------------------------------------------------------------

loc_C2D86:
		DEC	continues
		;LDA	#0
		;STA	act_id
		LDA	#3
		STA	player_lifes
		JMP	clr_and_go_main
; End of function continue_screen


; =============== S U B	R O U T	I N E =======================================


load_cont_scr_vram:
		LDX	#$FF

@nxt:
		INX
		LDA	cont_scr_vram,X
		BEQ	@done
		STA	PPU_ADDRESS
		INX
		LDA	cont_scr_vram,X
		STA	PPU_ADDRESS
		INX

@l1:
		LDA	cont_scr_vram,X
		BEQ	@nxt
		STA	PPU_DATA
		INX
		BNE	@l1
@done:
		RTS
; End of function load_cont_scr_vram

; ---------------------------------------------------------------------------
cont_scr_vram:	.BYTE	$3F	; palette
		.BYTE   $00
		.BYTE	$F,  $F, $10, $20
		.BYTE	$F,  $F, $18, $38
		.BYTE	$F,   4, $38, $25
		.BYTE	$F, $11, $1A, $30
		.BYTE	$F, $11, $1A, $30
		.BYTE	$F,   1, $11, $36
		.BYTE	$F,   1, $16, $36
		.BYTE	$F,   1, $11, $26
		.BYTE $00
		
cont_scr_vram1:	.BYTE  $20
		.BYTE  $C9
		.BYTE	 6,   7,   6,	8, $22,	$23, $26, $27,	 9, $22, $23,	9, $77,	  2,   3, $00
		
cont_scr_vram2:	.BYTE $20
		.BYTE $E9
		.BYTE  $16,  $A, $16, $18, $32,	$33, $36, $37, $1D, $32, $33, $75, $76,	$12, $13, $00
		
cont_scr_vram3:	.BYTE $23
		.BYTE $B
		.BYTE  $98, $84, $92, $00
		
cont_scr_vram4:	.BYTE $23
		.BYTE $15
		.BYTE  $8D, $8E, $00
		.BYTE	$00


; =============== S U B	R O U T	I N E =======================================


cont_sprites_anim:
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAY
		LSR	A
		TAX
		LDA	anim_tile1,X
		STA	sprites_tile+31*4
		LDA	anim_tile2,X
		STA	sprites_tile+33*4
		
		LDA	anim_tile3,Y
		STA	sprites_tile+9*4
;		LDA	anim_tile4,Y
;		STA	sprites_tile+10*4
		LDA	anim_tile5,Y
		STA	sprites_tile+14*4
		LDA	anim_tile6,Y
		STA	sprites_tile+15*4
		LDA	anim_tile7,Y
		STA	sprites_tile+19*4
		LDA	anim_tile8,Y
		STA	sprites_tile+20*4
		RTS
		
anim_tile1:
		.BYTE	$E7,$F8
anim_tile2:
		.BYTE	$F7,$F9
anim_tile3:
		.BYTE	$D2,$C8,$D2,$D2
;anim_tile4:
;		.BYTE	$D3,$00,$00,$D3
anim_tile5:
		.BYTE	$E2,$D8,$DA,$E2
anim_tile6:
		.BYTE	$E3,$D9,$DB,$E3
anim_tile7:
		.BYTE	$F2,$E8,$EA,$F2
anim_tile8:
		.BYTE	$F3,$E9,$EB,$F3


; =============== S U B	R O U T	I N E =======================================


load_cont_sprites:
		;LDX	#(cont_scr_spr_e-cont_scr_spr)-1
		LDX	#0
@copy_l
		LDA	cont_scr_spr,X
		STA	sprites_Y+8,X
		INX
		CPX	#(cont_scr_spr_e-cont_scr_spr)
		BNE	@copy_l
		LDY	#0
		LDA	continues
@loop
		CMP	#10
		BCC	@ok
		SBC	#10
		INY
		BNE	@loop
@ok
		ADC	#$9A
		STA	sprites_tile+35*4
		TYA
		ADC	#$9A
		STA	sprites_tile+34*4
		RTS
; ---------------------------------------------------------------------------

cont_scr_spr:
		.BYTE	$92,$C0,$02,$78
		.BYTE	$92,$C1,$01,$80
		.BYTE	$92,$C2,$01,$88
		.BYTE	$92,$C3,$01,$90
		.BYTE	$92,$C4,$01,$98
		
		.BYTE	$9A,$D0,$02,$78
		.BYTE	$9A,$D1,$01,$80
		.BYTE	$9A,$D2,$01,$88
		.BYTE	$9A,$D3,$01,$90
		.BYTE	$9A,$D4,$01,$98
		
		.BYTE	$A2,$E0,$01,$78
		.BYTE	$A2,$E1,$01,$80
		.BYTE	$A2,$E2,$01,$88
		.BYTE	$A2,$E3,$03,$90
		.BYTE	$A2,$E4,$01,$98
		
		.BYTE	$AA,$F0,$01,$78
		.BYTE	$AA,$F1,$01,$80
		.BYTE	$AA,$F2,$01,$88
		.BYTE	$AA,$F3,$01,$90
		.BYTE	$AA,$F4,$01,$98

		.BYTE	138,$C5,$01,140
		.BYTE	$A3,$D5,$01,$70
		.BYTE	$99,$E5,$01,$A0
		.BYTE	$A1,$F5,$01,$A0

; small
		.BYTE	072,$C6,$01,128
		.BYTE	072,$C7,$01,136
		
		.BYTE	080,$D6,$01,128
		.BYTE	080,$D7,$01,136
		
		.BYTE	088,$E6,$01,128
		.BYTE	088,$E7,$01,136
		
		.BYTE	096,$F6,$02,128
		.BYTE	096,$F7,$02,136
		
		.BYTE	104,$9A,$00,129
		.BYTE	104,$9B,$00,137
cont_scr_spr_e:
