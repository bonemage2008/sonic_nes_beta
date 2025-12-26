		org	$8800
		
sega_sample:
		incbin	sega_logo\sega.snd
		dc.b	0 ; end
	
sega_logo_new:
		JSR	load_sega_palette
		JSR	hide_all_sprites
		LDA	#$00
		JSR	fill_nametable1_with_value
		JSR	detectNTSC1
		TAX
		LDA	mode,X
		STA	var_Channels
		LDA	sample_speed_tbl,X
		STA	tmp_var_27
		
		LDX	#5
@load_chr_nums:
		LDA	sega_logo_chrs,X
		STA	chr_spr_bank1,X
		DEX
		BPL	@load_chr_nums
		
		LDA	#$A8
		JSR	enable_nmi
		LDA	#$F0
		STA	sonic_X_l
		LDA	#0
		STA	sonic_X_h
		STA	Frame_Cnt
		
		LDY	#$5E
@sega_logo_loop:
		LDA	Frame_Cnt
		ASL
		STA	$4011
		JSR	wait_next_frame
		TYA
		JSR	render_sega_logo_fill
		JSR	logo_move_sonic_l
		DEY
		DEY
		CPY	#$3E
		BNE	@sega_logo_loop
		LDY	#$5E
		
@sega_logo_loop2
		LDA	Frame_Cnt
		ASL
		STA	$4011
		JSR	wait_next_frame
		TYA
		JSR	render_sega_logo_fill2
		JSR	logo_move_sonic_l
		DEY
		DEY
		CPY	#$3E
		BNE	@sega_logo_loop2
		
@sega_logo_loop3
		JSR	wait_next_frame
		LDY	#3
		JSR	sega_logo_change_pal
		;JMP	@sega_logo_loop3
		
@sega_logo_loop4
		JSR	wait_3_frames
		LDY	#7
		JSR	sega_logo_change_pal
		;JMP	@sega_logo_loop4
		
@sega_logo_loop5
		JSR	wait_3_frames
		LDY	#11
		JSR	sega_logo_change_pal
		;JMP	@sega_logo_loop5
		
@sega_logo_loop6
		JSR	wait_3_frames
		LDY	#15
		JSR	sega_logo_change_pal
		
@sega_logo_loop7
		JSR	wait_next_frame
		LDA	sonic_X_l
		CLC
		ADC	#32
		STA	sonic_X_l_new
		LDA	sonic_X_h
		ADC	#0
		STA	sonic_X_h_new
		;LDA	sonic_X_h
		BNE	@no_change_attrs
		LDA	sonic_X_l_new
		LSR
		LSR
		LSR
		LSR
		LSR
		LDX	#$33
		BCC	@ok
		LDX	#$FF
@ok:		
		CLC
		ADC	#$D0
		LDY	#$23
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		STX	PPU_DATA
		STY	PPU_ADDRESS
		CLC
		ADC	#8
		STA	PPU_ADDRESS
		STX	PPU_DATA
		STY	PPU_ADDRESS
		CLC
		ADC	#8
		STA	PPU_ADDRESS
		STX	PPU_DATA
		LDA	#$00
		STA	PPU_ADDRESS
		STA	PPU_ADDRESS
		
@no_change_attrs
		JSR	logo_move_sonic_r
		LDA	sonic_X_h
		CMP	#1
		BNE	@sega_logo_loop7
		
		LDY	#7
		LDA	#$C
		JSR	sega_logo_change_pal4
		
		JSR	wait_3_frames
		LDY	#11
		LDA	#$C
		JSR	sega_logo_change_pal4
		
		JSR	wait_3_frames
		LDY	#15
		LDA	#$C
		JSR	sega_logo_change_pal4
		
		JSR	wait_3_frames
		LDY	#19
		LDA	#$C
		JSR	sega_logo_change_pal4
		
		LDX	#$3A800/$400
		STX	chr_bkg_bank1
		INX
		STX	chr_bkg_bank2
		JSR	wait_next_frame

		LDA	#0
		STA	PPU_CTRL_REG1
		
		LDA	#<sega_sample
		STA	tmp_var_25
		LDA	#>sega_sample
		STA	tmp_var_26
		LDY	#0	; sample ptr
		
;main:
@wait_vbl
		BIT	PPU_STATUS
		BPL	@wait_vbl
@next_frame_		

@play_sega
		LDX	tmp_var_26
		CPX	#$BF
		;BCS	END_SEGA_LOGO
		
		;LDX	#40
		LDX	tmp_var_27
		PHA
		LDA	(tmp_var_25),Y
		BEQ	done_sega_logo
		LSR
		STA	$4011
		INY
		BNE	@no_inc_h
		INC	tmp_var_26
		DEX
@no_inc_h
		PLA
		
@wait_samp:
		DEX
		BNE	@wait_samp
		BIT	PPU_STATUS
		BMI	@next_frame_
		JMP	@play_sega

done_sega_logo:
		PLA
;END_SEGA_LOGO:
@wait_vbl2
		BIT	PPU_STATUS
		BPL	@wait_vbl2
		
		LDA	#$A8
		JSR	enable_nmi
		LDX	#60
@wait_1_sec
		JSR	wait_next_frame
		DEX
		STX	$4011
		BNE	@wait_1_sec
		
		LDA	#10
		STA	palette_num
		JSR	PALETTE_FADE_FULL
		JMP	wait_next_frame
		
wait_3_frames:
		JSR	wait_next_frame
		JSR	wait_next_frame
		JMP	wait_next_frame
		
		
sega_logo_change_pal:
		LDA	#$00
sega_logo_change_pal4:
		LDX	#$3F
		STX	vram_buffer_adr_h
		STA	vram_buffer_adr_l
		LDA	#1
		STA	vram_buffer_ppu_mode
		LDX	#4
		STX	vram_buffer_h_length
		LDA	#1
		STA	vram_buffer_v_length
		DEX
@copy_to_buff:
		LDA	sega_logo_pal2,Y
		DEY
		STA	palette_buff,X
		DEX
		BPL	@copy_to_buff
		RTS

sega_logo_pal2:
		.BYTE	$30,$11,$01,$11 ; 3
		
sega_logo_pal3:
		.BYTE	$30,$21,$11,$21 ; 7
		
sega_logo_pal4:
		.BYTE	$30,$31,$11,$30 ; 11
		
sega_logo_pal5:
		.BYTE	$30,$30,$11,$30 ; 15

sega_logo_pal6:
		;.BYTE	$30,$30,$11,$11 ; 19
		.BYTE	$30,$31,$21,$11 ; 19
		
		
render_sega_logo_fill:
		LDX	#$21
		STX	vram_buffer_adr_h
		STA	vram_buffer_adr_l
		LDA	#4
		STA	vram_buffer_ppu_mode
		LDX	#10
		STX	vram_buffer_h_length
		LDA	#2
		STA	vram_buffer_v_length
		DEX
@copy_to_buff:
		LDA	sega_fill_data,X
		STA	palette_buff,X
		STA	palette_buff+10,X
		DEX
		BPL	@copy_to_buff
		RTS
		
		
render_sega_logo_fill2:
		LDX	#$21
		STX	vram_buffer_adr_h
		CLC
		ADC	#$20
		STA	vram_buffer_adr_l
		LDA	#4
		STA	vram_buffer_ppu_mode
		LDX	#8
		STX	vram_buffer_h_length
		LDA	#2
		STA	vram_buffer_v_length
		DEX
		
		JSR	set_prg_menus2
		
		TYA
		CLC
		ADC	#$A0
		TAY
		
@copy_to_buff2:
		LDA	sega_nt,Y
		STA	palette_buff,X
		LDA	sega_nt+1,Y
		STA	palette_buff+8,X
		TYA
		SEC
		SBC	#$20
		TAY
		DEX
		BPL	@copy_to_buff2
		
		TYA
		SEC
		SBC	#$A0
		TAY
		
		RTS

sega_fill_data:
		.BYTE	$51
		.BYTE	$61,$61,$61,$61,$61,$61,$61,$61
		.BYTE	$71
		
		
load_sega_palette:
		JSR	wait_vbl
		JSR	set_pal_addr
@load_pal:
		LDA	sega_sonic_pal,X
		STA	PPU_DATA
		INX
		CPX	#32
		BNE	@load_pal
		RTS
		
sega_sonic_pal:
		;.BYTE	$30,$21,$11,$01
		.BYTE	$30,$11,$30,$30
		.BYTE	$30,$11,$11,$11
		.BYTE	$30,$11,$11,$11
		.BYTE	$30,$11,$11,$11

		.BYTE	$30,$0F,$11,$30
		.BYTE	$30,$01,$11,$36
		.BYTE	$30,$01,$16,$36
		.BYTE	$30,$0F,$16,$36
		
sega_logo_chrs:
		.BYTE	$DC,$DE ; spr
		.BYTE	$CA,$CB,$DE,$DF ; bkg
		

;set_prg_menus2:
;		LDA	#$87
;		STA	MMC3_bank_select
;		LDA	#$32000/$2000
;		STA	MMC3_bank_data
;		RTS

set_prg_menus2:
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$2E000/$2000
		STA	MMC3_bank_data
		
		ELSE
		LDA	#$2E000/$2000
		STA	VRC7_prg_8000
		ENDIF
		
		RTS
		
	
sonic_logo_spr_cfg_ptrs_l:
		.BYTE	<sonic_logo_sprites_frame1
		.BYTE	<sonic_logo_sprites_frame2
		.BYTE	<sonic_logo_sprites_frame3
		.BYTE	<sonic_logo_sprites_frame4
		
sonic_logo_spr_cfg_ptrs_h:
		.BYTE	>sonic_logo_sprites_frame1
		.BYTE	>sonic_logo_sprites_frame2
		.BYTE	>sonic_logo_sprites_frame3
		.BYTE	>sonic_logo_sprites_frame4
		
sonic_logo_spr_cfg_size:
		.BYTE	(sonic_logo_sprites_frame1_end-sonic_logo_sprites_frame1)/4
		.BYTE	(sonic_logo_sprites_frame2_end-sonic_logo_sprites_frame2)/4
		.BYTE	(sonic_logo_sprites_frame3_end-sonic_logo_sprites_frame3)/4
		.BYTE	(sonic_logo_sprites_frame4_end-sonic_logo_sprites_frame4)/4
		
		
logo_move_sonic_r:
		LDX	#0
		LDA	sonic_X_l
		CLC
		ADC	#16
		STA	sonic_X_l
		BCC	load_sonic_logo_sprites
		INC	sonic_X_h
		BCS	load_sonic_logo_sprites
		
		
logo_move_sonic_l:
		LDX	#$40
		LDA	sonic_X_l
		SEC
		SBC	#16
		STA	sonic_X_l
		BCS	@no_dec_x_h
		DEC	sonic_X_h
@no_dec_x_h

load_sonic_logo_sprites:
		STX	sonic_attribs
		JSR	set_prg_menus2
		
		TYA
		PHA
		LDA	Frame_Cnt
		AND	#3
		TAY
		LDX	sonic_logo_spr_cfg_size,Y
		LDA	sonic_logo_spr_cfg_ptrs_l,Y
		STA	tmp_var_25
		LDA	sonic_logo_spr_cfg_ptrs_h,Y
		STA	tmp_var_26
		LDY	#0
		
@l
		LDA	(tmp_var_25),Y
		STA	sprites_Y,Y
		INY
		LDA	(tmp_var_25),Y
		;ORA	#$01
		STA	sprites_Y,Y
		INY
		LDA	(tmp_var_25),Y
		EOR	sonic_attribs
		STA	sprites_Y,Y
		INY
		LDA	sonic_attribs
		BNE	@left
		LDA	(tmp_var_25),Y
		JMP	@right
@left:
		LDA	#$38
		SEC
		SBC	(tmp_var_25),Y
@right:
		CLC
		ADC	sonic_X_l
		STA	sprites_Y,Y
		LDA	#0
		ADC	sonic_X_h
		BEQ	@ok
		LDA	#$F0
		STA	sprites_Y-3,Y
@ok		
		INY
		DEX
		BNE	@l
		
		TYA
		TAX
		PLA
		TAY
		JMP	hide_sprites


; =============== S U B	R O U T	I N E =======================================


;		align	128

detectNTSC1:	; 0 = ntsc; 1 = pal; 2 = dendy
		bit PPU_STATUS
@wait_vbl
		bit PPU_STATUS
		bpl @wait_vbl
		ldx #0
		ldy #24
		jsr wait1284y
		bpl not_ntsc
		tya	; 0-ntsc
		rts
not_ntsc:
		lda #1	; 1-pal
		ldy #3
		jsr wait1284y
		bmi not_dendy
		asl a	; 2-dendy
		JSR	set_pal_addr
		LDX	PPU_DATA
		CPX	#$30
		BEQ	not_dendy
		LDA	#3 ; 3-dendy HW
		
not_dendy:
		rts

wait1284y
		dex
		bne wait1284y
		dey
		bne wait1284y
		bit PPU_STATUS
		rts

set_pal_addr:
		LDY #$3F
		LDX #$00
set_ppu_addr:
		STY PPU_ADDRESS
		STX PPU_ADDRESS
		RTS

sample_speed_tbl:
		.BYTE	38,35,38,38

mode:
		.BYTE	$00 ; ntsc
		.BYTE	$90 ; pal
		.BYTE	$80 ; dendy
		.BYTE	$C0 ; dendy (HW)

		.pad	$C000,$80
