		.pad	$EC00,$FF
		.base	$EC00

; =============== S U B	R O U T	I N E =======================================

		.align	256

write_32_tiles:
		REPT	32
		PLA
		STA	PPU_DATA
		ENDR
		
		INX
		BEQ	end_update_tilemap
		
		CPY	#$A8|4
		BNE	reset_adr_for_h
		
		LDA	tilemap_adr_h_v
		AND	#$FC
		STA	PPU_ADDRESS
		LDA	tilemap_adr_l_v	; hscroll-column
		AND	#$1F
		STA	PPU_ADDRESS
		LDA	#34*4	; update 30 tiles
		SBC	ptr_low
		STA	ptr_low
		JMP	(ptr_low)

reset_adr_for_h:
		LDA	tilemap_adr_h	; reset_vram_adress
		EOR	#4
		STA	PPU_ADDRESS
		LDA	tilemap_adr_l	; vscroll-raw
		AND	#$E0
		STA	PPU_ADDRESS
;		LDA	#31*4+1	; update 33 tiles
;		SBC	ptr_low

		LDA	#30*4+1
		SBC	ptr_low
		BPL	@ok
;		DEX
		LDA	#0	; fix for 1+32+1 tiles
@ok
		STA	ptr_low
		JMP	(ptr_low)

end_update_tilemap:
		LDX	nmi_sp_saver
		TXS
		RTS
		
; =============== S U B	R O U T	I N E =======================================


		MACRO	UPDATE_ATTRIB_SCROLL_H
		LDY	scroll_H_attrib_high
		LDA	scroll_H_attrib_low
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		LDX	attrib_Hscrl_buff+0
		STX	PPU_DATA
		LDX	attrib_Hscrl_buff+4
		STX	PPU_DATA
		EOR	#$08
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		LDX	attrib_Hscrl_buff+1
		STX	PPU_DATA
		LDX	attrib_Hscrl_buff+5
		STX	PPU_DATA
		EOR	#$18
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		LDX	attrib_Hscrl_buff+2
		STX	PPU_DATA
		LDX	attrib_Hscrl_buff+6
		STX	PPU_DATA
		EOR	#$08
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		LDX	attrib_Hscrl_buff+3
		STX	PPU_DATA
		LDX	attrib_Hscrl_buff+7
		STX	PPU_DATA
		ENDM


; =============== S U B	R O U T	I N E =======================================


		MACRO	UPDATE_ATTRIB_SCROLL_V
		LDY	#$23
		STY	PPU_ADDRESS
		LDA	scroll_V_attrib_low
		TAX
		ORA	#$C0
		STA	PPU_ADDRESS
		LDY	attributes_buff+0,X
		STY	PPU_DATA
		LDY	attributes_buff+1,X
		STY	PPU_DATA
		LDY	attributes_buff+2,X
		STY	PPU_DATA
		LDY	attributes_buff+3,X
		STY	PPU_DATA
		LDY	attributes_buff+4,X
		STY	PPU_DATA
		LDY	attributes_buff+5,X
		STY	PPU_DATA
		LDY	attributes_buff+6,X
		STY	PPU_DATA
		LDY	attributes_buff+7,X
		STY	PPU_DATA
		LDY	#$27
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		LDY	attributes_buff+$40,X
		STY	PPU_DATA
		LDY	attributes_buff+$41,X
		STY	PPU_DATA
		LDY	attributes_buff+$42,X
		STY	PPU_DATA
		LDY	attributes_buff+$43,X
		STY	PPU_DATA
		LDY	attributes_buff+$44,X
		STY	PPU_DATA
		LDY	attributes_buff+$45,X
		STY	PPU_DATA
		LDY	attributes_buff+$46,X
		STY	PPU_DATA
		LDY	attributes_buff+$47,X
		STY	PPU_DATA
		ENDM


; =============== S U B	R O U T	I N E =======================================

; somari ring block update modified
		MACRO	vram_rings_update
		
;		LDA	tilemap_adr_h
;		ORA	tilemap_adr_h_v
;		BMI	do_vram_rings_update
;		JMP	skip_vram_rings_update
do_vram_rings_update:
		LDX	tilemap_adr_blk_h
		BMI	no_update_block1_tilemap
		LDY	tilemap_tile_blk
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
no_update_block1_tilemap

		LDX	tilemap_adr_blk_h+3
		BMI	no_update_block2_tilemap
		LDY	tilemap_tile_blk+3
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l+3
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
no_update_block2_tilemap

		LDX	tilemap_adr_blk_h+6
		BMI	no_update_block3_tilemap
		LDY	tilemap_tile_blk+6
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l+6
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
no_update_block3_tilemap

		LDX	tilemap_adr_blk_h+9
		BMI	no_update_block4_tilemap
		LDY	tilemap_tile_blk+9
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l+9
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
no_update_block4_tilemap

		LDX	tilemap_adr_blk_h+12
		BMI	no_update_block5_tilemap
		LDY	tilemap_tile_blk+12
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l+12
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
no_update_block5_tilemap

		LDX	tilemap_adr_blk_h+15
		BMI	no_update_block6_tilemap
		LDY	tilemap_tile_blk+15
		STX	PPU_ADDRESS
		LDA	tilemap_adr_blk_l+15
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		STX	PPU_ADDRESS
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		STY	PPU_DATA
		STY	PPU_DATA
		;LDX	#$FF
no_update_block6_tilemap

		;STX	tilemap_adr_blk_h+00
		;STX	tilemap_adr_blk_h+03
		;STX	tilemap_adr_blk_h+06
		;STX	tilemap_adr_blk_h+09
		;STX	tilemap_adr_blk_h+12
		;STX	tilemap_adr_blk_h+15
		;LDX	#0
		;STX	blocks_to_upd_off
skip_vram_rings_update
		ENDM


; =============== S U B	R O U T	I N E =======================================


lag_nmi:
		;INC	lag_counter
		LDA	ppu_ctrl2_val
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		TXA	; save X
		PHA	; save X
		IF	(VRC7=0)
		JSR	IRQ_setup
		ENDIF
		PLA	; restore X
		TAX	; restore X
		JMP	nmi_ret_a
; ---------------------------------------------------------------------------

NMI:
		PHA
		
		IF	(VRC7=1)
		LDA	vrc7_irq_mode
		STA	VRC7_IRQ_control
		ENDIF
		
		BIT	special_flag
		BPL	@not_special_stage
		JMP	SPEC_NMI
; ---------------------------------------------------------------------------

@not_special_stage
		DEC	nmi_flag2
		BMI	lag_nmi	
		STX	nmi_xreg_saver
		STY	nmi_yreg_saver
;		LDA	skip_spr_upd	; lagged frame
;		BEQ	loc_C22D4
;		JMP	lagged_frame
; ---------------------------------------------------------------------------

;loc_C22D4:
;		LDA	#0
;		STA	PPU_CTRL_REG2
;		STA	PPU_SPR_ADDR	; SPR-RAM Address Register (W)
		LDA	#2
		STA	SPR_DMA		; Sprite DMA Register (W)

		vram_rings_update

		;LDA	#>write_32_tiles
		;STA	ptr_high
		
		LDA	tilemap_adr_h_v
		BMI	no_update_tilemap_columns
		STA	PPU_ADDRESS
		LDA	tilemap_adr_l_v
		STA	PPU_ADDRESS
		JSR	UPDATE_TILEMAP_COL1
		LDA	tilemap_adr_h_v
		STA	PPU_ADDRESS
		LDA	tilemap_adr_l_v
		ORA	#1
		STA	tilemap_adr_l_v
		STA	PPU_ADDRESS
		JSR	UPDATE_TILEMAP_COL2
		LDA	#0	; for extra 1 scanline
		STA	PPU_CTRL_REG2
		UPDATE_ATTRIB_SCROLL_H
		LDA	ppu_ctrl1_val
		AND	#$FB	; restore auto-inc 01
		STA	PPU_CTRL_REG1
;		LDA	ppu_ctrl2_val
;		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		;LDA	hscroll_val
		;STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		;LDA	vscroll_val
		;STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)	
		;JMP	update_scroll_regs

no_update_tilemap_columns:
		LDA	tilemap_adr_h
		BPL	update_tilemap_h
		JMP	no_update_tilemap_h
		
update_tilemap_h:
;		ORA	raw1_update_flag
;		BMI	no_update_tilemap_h_raw1
;		BEQ	no_update_tilemap_h_raw1
		STA	PPU_ADDRESS
		LDA	tilemap_adr_l
		STA	PPU_ADDRESS
		JSR	UPDATE_TILEMAP_RAW1
		UPDATE_ATTRIB_SCROLL_V
		JMP	loc_C230A
		
;no_update_tilemap_h_raw1:
;		LDA	tilemap_adr_h2m
;		BEQ	no_update_tilemap_h
		;LDA	tilemap_adr_h2
;		ORA	raw2_update_flag
;		BMI	no_update_tilemap_h
		;STA	tilemap_adr_h
		;STA	PPU_ADDRESS
		;LDA	tilemap_adr_l2
		;STA	tilemap_adr_l
		;STA	PPU_ADDRESS
		;JSR	UPDATE_TILEMAP_RAW2
		;JMP	loc_C230A
		
no_update_tilemap_h:

		LDX	final_boss_vram_func
		BEQ	loc_C2302
		;LDA	#$A8	; restore auto-inc 01
		;STA	PPU_CTRL_REG1
		JSR	final_boss_vram_updates

loc_C2302:
		LDA	vram_buffer_adr_h
		BEQ	loc_C230A
		JSR	vram_updates_from_buff_ ; mostly for	palettes

loc_C230A:
		LDA	ppu_ctrl2_val
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
;		LDA	ppu_ctrl1_val
;		AND	#$FC
;		ORA	ppu_tilemap_mask
;		STA	ppu_ctrl1_val
;		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		LDA	PPU_STATUS	; PPU Status Register (R)
;		STA	ppu_status_value
;		BMI	@ok
;		LDA	ppu_ctrl2_val
;		BEQ	@ok
;		LDA	sonic_anim_num
;		BEQ	@ok
;		BMI	@ok
;		LDA	#0
;		STA	PPU_CTRL_REG1
;@out_of_vbl		
;		JMP	@out_of_vbl
;@ok

update_scroll_regs:
		LDA	hscroll_val
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		LDA	vscroll_val
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		LDA	ppu_ctrl1_val
		AND	#$FC
		ORA	ppu_tilemap_mask
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STA	ppu_ctrl1_val
		
		IF	(VRC7=0)
		JSR	IRQ_setup
		ELSE
		LDA	#0
		STA	irq_cnt
		ENDIF
		
		IF	(VRC7=0)
		LDX	#$80
		LDA	chr_spr_bank1	; player sprites bank
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		INX	; LDX	#$81
		LDA	chr_spr_bank2
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		INX	; LDX	#$82
		LDA	chr_bkg_bank1
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		INX	; LDX	#$83
		LDA	chr_bkg_bank2
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		INX	; LDX	#$84
		LDA	chr_bkg_bank3
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		INX	; LDX	#$85
		LDA	chr_bkg_bank4
		STX	MMC3_bank_select
		STA	MMC3_bank_data
		
		ELSE
		LDX	chr_spr_bank1
		STX	VRC7_chr_1000
		INX
		STX	VRC7_chr_1400
		LDX	chr_spr_bank2
		STX	VRC7_chr_1800
		INX
		STX	VRC7_chr_1C00
		
		LDX	chr_bkg_bank1
		STX	VRC7_chr_0000
		LDX	chr_bkg_bank2
		STX	VRC7_chr_0400
		LDX	chr_bkg_bank3
		STX	VRC7_chr_0800
		LDX	chr_bkg_bank4
		STX	VRC7_chr_0C00
		ENDIF
		
		JSR	READ_JOYS
		CLI
		
		LDA	pause_flag
		BNE	loc_C23F7
		INC	frame_cnt_for_1sec
		LDA	frame_cnt_for_1sec
		CMP	#60
		BCC	loc_C23F7
		AND	#0
		STA	frame_cnt_for_1sec
		
		LDA	level_finish_func_num
		BNE	loc_C23F7 ; stop timer on signpost touch
		LDA	capsule_func_num
		CMP	#3
		BCS	loc_C23F7 ; stop timer on capsule touch
		
		LDA	level_id
		CMP	#SPEC_STAGE
		BNE	@not_inv_timer
		LDA	irq_func_num
		BNE	loc_C23F7
		DEC	timer_s
		BPL	loc_C23F7
		LDA	#9
		STA	timer_s
		DEC	timer_10s
		BPL	loc_C23F7
		LDA	#5
		STA	timer_10s
		DEC	timer_m
		BPL	loc_C23F7
		JMP	special_time_over
		
@not_inv_timer:
		INC	timer_s
		LDA	timer_s
		CMP	#10
		BCC	loc_C23F7
		LDA	#0
		STA	timer_s
		INC	timer_10s
		LDA	timer_10s
		CMP	#6
		BCC	loc_C23F7
		LDA	#0
		STA	timer_10s
		INC	timer_m
		LDA	timer_m
		CMP	#10
		BCC	loc_C23F7
		LDX	#9 ; 9:59
		LDA	#5 ; 9:59
		STA	time_over_flag
time_is_over:
		STX	timer_m
		STX	timer_s
		STA	timer_10s

loc_C23F7:
		LDA	#0
		STA	sprite_id	; NMI_end_flag
		INC	Frame_Cnt

		STA	blocks_to_upd_off	; $00
		
		JSR	reset_update_flags
		
		JSR	j_sound_update
;return_from_nmi:
		LDX	nmi_xreg_saver
		LDY	nmi_yreg_saver
nmi_ret_a:
		PLA
		INC	nmi_flag2
		RTI


; =============== S U B	R O U T	I N E =======================================

		IF	(VRC7=0)
IRQ_setup:
		LDX	irq_func_num
		BNE	@not_level_irq
		
		LDA	ppu_ctrl2_val
		AND	#$F7
		STA	PPU_CTRL_REG2
		LDA	#7
		BNE	@setup_irq
		
@not_level_irq:
		BMI	@disable_irq
		DEX
		BNE	@not_title_irq
		LDA	#103		; title
		BNE	@setup_irq

@not_title_irq:
		DEX
		BNE	@not_opening_irq
		LDA	#72		; opening
@setup_irq:
		STA	MMC3_IRQ_latch
		STA	MMC3_IRQ_reload
		STA	MMC3_IRQ_enable
		LDA	#0
		STA	irq_cnt
		RTS
		
@not_opening_irq:
		LDA	#71
		BNE	@setup_irq
@disable_irq:				; disable irq
		STA	MMC3_IRQ_disable
		RTS
		
		ENDIF


; =============== S U B	R O U T	I N E =======================================


j_sound_update:
		BIT	JOYPAD_PORT1	; for emulators lag detector
		
		LDX	music_to_play
		CPX	current_music
		BEQ	@no_start_music
		
		IF	(VRC7=0)
		
		LDA	epsm_flag
		BPL	@no_start_music
		BIT	special_flag ; fix - no allow chaos emerald in special
		BMI	@no_start_music
		LDA	music_table-32,X
		BPL	@start_fms_music
@stop_fms_music:
		JSR	set_bank_fms
		JSR	famistudio_music_stop
		LDA	#$80
		STA	famistudio_song_speed
		JMP	@skip_update
		
@start_fms_music
		STX	current_music
		CPX	#0
		BEQ	@stop_fms_music
		TAX
		LDA	var_Channels
		AND	#%11011111 ; 0x20 - enable/disable playback
		STA	var_Channels
		JSR	set_music_bank_fms
		TXA
		ASL
		TAX
		LDA	music_ptrs,X
		LDY	music_ptrs+1,X
		TAX
		lda	#1 ; NTSC
		bit	var_Channels
		bpl	@is_ntsc
		lda	#0 ; PAL
@is_ntsc:
		jsr	famistudio_init
		lda	#0
		jsr	famistudio_music_play
		JMP	@skip_update
		
		ELSE

		LDA	vrc7_flag
		BPL	@no_start_music
		BIT	special_flag ; fix - no allow chaos emerald in special
		BMI	@no_start_music
		LDA	music_table_vrc7-32,X
		BPL	@start_fms_music
@stop_vrc7_music:
		LDA	#0
		STA	SND_MASTERCTRL_REG
		STA	vrc7_PlayerFlags
		LDA	#$C0
		STA	VRC7_mirroring
		JMP	@skip_update
		
@start_fms_music:
		STX	current_music
		CPX	#0
		BEQ	@stop_vrc7_music
		PHA
		LDA	var_Channels
		AND	#%11011111 ; 0x20 - enable/disable playback
		STA	var_Channels
		PLA
		LDY	#$2F
		STY	VRC7_prg_A000
		JSR	ft_music_init_vrc7
		
		ENDIF
		
@no_start_music:
		LDY	current_music
		BEQ	@skip_update
;		JSR	famistudio_music_stop

		IF	(VRC7=0)
		LDA	epsm_flag
		BPL	@skip_update
		LDX	music_table-32,Y
		BMI	@skip_update
		JSR	set_music_bank_fms
;@fms_update:
		LDY	sfx_to_play
		BEQ	@no_start_fm_sfx
		BMI	@no_start_fm_sfx
		LDA	fm_sfx_table,Y
		BMI	@no_start_fm_sfx
		JSR	INIT_FM6_SFX
@no_start_fm_sfx
		JSR	famistudio_update
@skip_update:

		ELSE
		
		LDA	vrc7_flag
		BPL	@skip_update
		LDX	music_table_vrc7-32,Y
		BMI	@skip_update
		LDY	#$2F
		STY	VRC7_prg_A000
		JSR	ft_music_play_vrc7
@skip_update:
		ENDIF

		IF	(VRC7=0)
		LDA	#$86
		LDX	#$1E
		SEI
		STA	MMC3_bank_select
		STX	MMC3_bank_data
		CLI
		
		ELSE
		LDA	#$1E
		STA	VRC7_prg_8000
		ENDIF
		
		JSR	songs_to_play
		JSR	ft_music_play

		IF	(VRC7=0)
		LDX	#$86
		STX	MMC3_bank_select
		LDA	prg1_id
		STA	MMC3_bank_data
		INX	; LDX	#$87
		STX	MMC3_bank_select
		LDA	prg2_id
		STA	MMC3_bank_data
		
		ELSE
		LDA	prg1_id
		STA	VRC7_prg_8000
		LDA	prg2_id
		STA	VRC7_prg_A000
		ENDIF
		RTS
		
		IF	(VRC7=0)
set_music_bank_fms:
		LDY	#$86
		STY	MMC3_bank_select
		LDY	music_banks,X
		STY	MMC3_bank_data
set_bank_fms:
		LDY	#$87
		STY	MMC3_bank_select
		;LDY	music_banks,X
		;INY
		LDY	#$2F
		STY	MMC3_bank_data
		
;		ELSE
;		
;set_music_bank_fms:
;		LDY	music_banks,X
;		STY	VRC7_prg_8000
;set_bank_fms:
;		LDY	#$2F
;		STY	VRC7_prg_A000
		ENDIF
		
		RTS
		
		IF	(VRC7=0)
music_ptrs:
		.WORD	music_data_01_title_theme ; $00
		.WORD	music_data_02_green_hill_zone ; $01
		.WORD	music_data_03_marble_zone ; $02
		.WORD	music_data_04_spring_yard_zone ; $03
		.WORD	music_data_05_labyrinth_zone ; $04
		.WORD	music_data_06_star_light_zone ; $05
		.WORD	music_data_07_scrap_brain_zone ; $06
		.WORD	music_data_08b_special_stage_beta_s1_smsgg ; $07
		.WORD	music_data_09_robotnik ; $08
		.WORD	music_data_10_final_zone ; $09
		.WORD	music_data_11_stage_clear ; $0A
		.WORD	music_data_12_ending_theme ; $0B
		
		.WORD	music_data_13_1_up ; $0C
		.WORD	music_data_14_game_over ; $0D
		.WORD	music_data_15_chaos_emerald ; $0E
		.WORD	music_data_16_continue ; $0F
		.WORD	music_data_17_running_out_of_air_beta ; $10
		
;		.WORD	music_data_21_invincibility ; $11
		.WORD	music_data_21_invincibility_beta ; $11
		.WORD	music_data_08_special_stage ; $12
;		.WORD	music_data_18_credits_medley_dpcm_beta ; $12
		.WORD	music_data_sonic_2_super_sonic ; $13
		.WORD	music_data_s3k_invincibility ; $14
		.WORD	music_data_sonic_the_hedgehog_w_rev01_sega_genesis ; $15  music_get_cont
		
music_banks:
		.BYTE	$0C ; $00 - title
		.BYTE	$13 ; $01 - ghz
		.BYTE	$0D ; $02 - marble
		.BYTE	$25 ; $03 - spring
		
		.BYTE	$2B ; $04 - lab
		.BYTE	$2B ; $05 - starlight
		.BYTE	$2B ; $06 - scrap
		
		.BYTE	$25 ; $07 - special
		.BYTE	$0C ; $08 - boss
		.BYTE	$0E ; $09 - final zone
		.BYTE	$0E ; $0A - stage clear
		.BYTE	$0F ; $0B - game win
		
		.BYTE	$2D ; $0C - 1up
		.BYTE	$2D ; $0D - game over
		.BYTE	$2D ; $0E - chaos em.
		.BYTE	$2D ; $0F - cont
		.BYTE	$2D ; $10 - out of air
		.BYTE	$2D ; $11 - invic.
		
		.BYTE	$10 ; $12 - special stage (old)
		
		.BYTE	$2D ; $13
		.BYTE	$2D ; $14
		.BYTE	$2D ; $15
		
music_table:
		.BYTE  $00 ; title
		.BYTE  $11 ; inviciblity
		.BYTE  $0A ; level win
		.BYTE  $01 ; green hill
		
		.BYTE  $02 ; marble
		.BYTE  $03 ; spring
		.BYTE  $04 ; labyrinth  26
		.BYTE  $05 ; star light
		
		.BYTE  $07 ; special stage
		.BYTE  $08 ; boss  29
		.BYTE  $10 ; drowning
		.BYTE  $0F ; continue? (screen)
		
		.BYTE  $0C ; extra life
		.BYTE  $0E ; chaos emerald
		.BYTE  $06 ; scrap brain
		.BYTE  $09 ; final zone	

		.BYTE  $0B ; game win
		.BYTE  $0D ; game over
		.BYTE  $ff ; $12 ; credits
		.BYTE  $12 ; $12 special stage (old)

		.BYTE  $FF ; drowned
		.BYTE  $15 ; +1 continue
		.BYTE  $FF ; special stage (blue spheres)
		.BYTE  $13 ; $13 ; supers-s2
		
		.BYTE  $14 ; $14 ; supers-s3k
		.BYTE  $FF
		.BYTE  $FF
		.BYTE  $FF

		.BYTE  $FF
		.BYTE  $FF ; supers-s3
		.BYTE  $FF ; supers-origin
		.BYTE  $FF
		
		
fm_sfx_table:
		.BYTE	$FF ; -
		.BYTE	$FF ; skid
		.BYTE	0 ; ring
		.BYTE	$FF ; jump

		.BYTE	4 ; rings drop
		.BYTE	1 ; badnik
		.BYTE	$FF ; death
		.BYTE	$FF ; air bubble

		.BYTE	5 ; spin
		.BYTE	$FF ; boss hit
		.BYTE	$FF ; checkpoint
		.BYTE	$FF ; points

		.BYTE	3 ; spring
		.BYTE	$FF ; bumper
		.BYTE	$FF ; shield
		.BYTE	2 ; spikes

		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF

		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF

		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF

		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF
		.BYTE	$FF
		
		ELSE
		
music_table_vrc7:
		.BYTE  $01 ; title
		.BYTE  $01 ; inviciblity
		.BYTE  $01 ; level win
		.BYTE  $01 ; green hill
		
		.BYTE  $01 ; marble
		.BYTE  $01 ; spring
		.BYTE  $01 ; labyrinth  26
		.BYTE  $01 ; star light
		
		.BYTE  $01 ; special stage
		.BYTE  $01 ; boss  29
		.BYTE  $01 ; drowning
		.BYTE  $01 ; game over
		
		.BYTE  $01 ; extra life
		.BYTE  $01 ; chaos emerald
		.BYTE  $01 ; scrap brain
		.BYTE  $01 ; final zone	

		.BYTE  $01 ; game win
		.BYTE  $01 ; continue? (screen)
		.BYTE  $01 ; $12 ; credits
		.BYTE  $01 ; $12 special stage (old)

		.BYTE  $01 ; drowned
		.BYTE  $01 ; +1 continue
		.BYTE  $01 ; special stage (blue spheres)
		.BYTE  $01 ; $13 ; supers-s2
		
		.BYTE  $01 ; $14 ; supers-s3k
		.BYTE  $01
		.BYTE  $01
		.BYTE  $01

		.BYTE  $01
		.BYTE  $01 ; supers-s3
		.BYTE  $01 ; supers-origin
		.BYTE  $01		
		
		ENDIF


; =============== S U B	R O U T	I N E =======================================


special_time_over:
		LDA	level_finish_func_num
		BNE	@ok
		LDA	#2
		STA	level_finish_func_num
@ok:
		LDA	current_music
		CMP	#$28 ; ?
		BNE	@skip
		;LDA	#$22
		LDA	#$3A
		STA	music_to_play
@skip:
		LDA	#0	; timer_m,timer_s
		TAX		; timer_10s
		JMP	time_is_over ; JMP


; =============== S U B	R O U T	I N E =======================================


;Vscroll_bkg_update:
;UPDATE_TILEMAP_RAW2:
;		TSX
;		STX	nmi_sp_saver
;		LDX	#<raw_buffer2-1
;		BNE	update_tilemap_raw

UPDATE_TILEMAP_RAW1:
		TSX
		STX	nmi_sp_saver
		LDX	#$FF	; ram: $100
;update_tilemap_raw:
		TXS
		LDX	#$FE	; counter
		LDY	#$A8
		LDA	tiles_to_upd	; upd 33 tiles
		STA	ptr_low
		JMP	(ptr_low)
; End of function Vscroll_bkg_update


; =============== S U B	R O U T	I N E =======================================


;Hscroll_bkg_update:
UPDATE_TILEMAP_COL2:	; 2nd columd
		TSX
		STX	nmi_sp_saver
		LDX	#<col_buffer2-1
		BNE	update_tilemap_col

UPDATE_TILEMAP_COL1:
		TSX
		STX	nmi_sp_saver
		LDX	#<col_buffer1-1
update_tilemap_col
		TXS
		
		LDX	#$FE	; counter
		LDY	#$A8|4
;		STY	PPU_CTRL_REG1

		LDA	ppu_ctrl1_val
		ORA	#4
		STA	PPU_CTRL_REG1

		LDA	tiles_to_upd_v
		STA	ptr_low
		JMP	(ptr_low)
; End of function Hscroll_bkg_update


; =============== S U B	R O U T	I N E =======================================


IRQ:
		IF	(VRC7=0)
		STA	MMC3_IRQ_disable
		ELSE
		STA	VRC7_IRQ_ack
		ENDIF
		
		PHA
		LDA	irq_func_num
		BNE	@not_level_irq
		SEC
		LDA	irq_cnt
		BNE	@level_irq_low_border
		
		IF	(VRC7=0)
		STA	MMC3_IRQ_enable
		LDA	#224
		STA	MMC3_IRQ_latch
		ELSE
		
		LDA	#32
		STA	VRC7_IRQ_latch
		LDA	#2
		STA	VRC7_IRQ_control
		
		ENDIF
		
		LDA	#12

@wait:
		SBC	#1
		BNE	@wait
		LDA	ppu_ctrl2_val
		INC	irq_cnt
		BNE	@level_irq_nx ; JMP

@level_irq_low_border:
		IF	(VRC7=1)
		LDA	#227
		STA	VRC7_IRQ_latch
		ENDIF

		LDA	#15

@wait2:
		SBC	#1
		BNE	@wait2
		LDA	ppu_ctrl2_val
		AND	#$F7

@level_irq_nx:
		STA	PPU_CTRL_REG2
		PLA
		RTI
; ---------------------------------------------------------------------------

@not_level_irq:
		CMP	#1
		BEQ	IRQ_title_screen
		CMP	#2
		BEQ	IRQ_stage_opening
		CMP	#3
		BNE	irq_ending_scenes
		JMP	SPEC_IRQ
; ---------------------------------------------------------------------------

IRQ_stage_opening:
		LDA	irq_cnt
		BNE	irq_opening_nx
		
		IF	(VRC7=0)
		STA	MMC3_IRQ_enable
		LDA	#$20
		STA	MMC3_IRQ_latch
		
		ELSE
		
		NOP
		
		ENDIF
		
		LDA	PPU_STATUS	; PPU Status Register (R)
		LDA	irq_x_scroll
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
irq_ret1:
		INC	irq_cnt
		PLA
		RTI
; ---------------------------------------------------------------------------

irq_opening_nx:
		;LDA	PPU_STATUS	; PPU Status Register (R)
		LDA	#0
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		STA	PPU_SCROLL_REG	; VRAM Address Register	#1 (W2)
		LDA	ppu_ctrl1_val
		AND	#$F7
		STA	PPU_CTRL_REG1
irq_ret:
		PLA
		RTI
; ---------------------------------------------------------------------------

IRQ_title_screen:
		TXA
		PHA
		TYA
		PHA
		LDY	#2

@wait:
		DEY
		BNE	@wait
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAX
		LDY	title_irq_chrs,X
		;TAY
write_bkg_chrs:	
		IF	(VRC7=0)
		LDX	#$82
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INY
		INX	;LDX	#$83
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INY
		INX	;LDX	#$84
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INY
		INX	;LDX	#$85
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		
		ELSE
		STY	VRC7_chr_0000
		INY
		STY	VRC7_chr_0400
		INY
		STY	VRC7_chr_0800
		INY
		STY	VRC7_chr_0C00
		ENDIF
		
IRQ_RETURN:
		PLA
		TAY
		PLA
		TAX
		PLA
		RTI
; End of function IRQ

; ---------------------------------------------------------------------------
title_irq_chrs: .BYTE $64
		.BYTE $68
		.BYTE $6C
		.BYTE $78
		
; ---------------------------------------------------------------------------

irq_ending_scenes:
		CMP	#4
		IF	(VRC7=0)
		BNE	irq_epsm_detect
		ELSE
		BNE	unknown_irq
		ENDIF
		
		IF	(VRC7=0)
		LDA	#7	; every 8 lines
		STA	MMC3_IRQ_latch
		ENDIF		

		LDA	#9-2
@wait:
		SBC	#1
		BNE	@wait
		LDA	irq_cnt
		CMP	#10
		BEQ	@last
		
		IF	(VRC7=0)
		STA	MMC3_IRQ_enable
		ENDIF
@last:
		AND	#1	; 0/1
		ORA	ppu_ctrl1_val
		STA	PPU_CTRL_REG1
		
;		IF	(VRC7=0)
;		LDA	#7	; every 8 lines
;		STA	MMC3_IRQ_latch
;		ENDIF
		
unknown_irq:
		JMP	irq_ret1
; ---------------------------------------------------------------------------

		IF	(VRC7=0)
EPSM_ADDR0	equ	$401C
EPSM_DATA0	equ	$401D
		
irq_epsm_detect:
		CMP	#$80
		BNE	unknown_irq
		LDA	#$27        ; Acknowledge and disable IRQ
		STA	EPSM_ADDR0
		LDA	#$30
		STA	EPSM_DATA0
		LDA	#0
		STA	irq_func_num
		PLA
		RTI
		
		
; =============== S U B	R O U T	I N E =======================================


EPSM_detect:
		LDA	#$29            ; Enable Timer and IRQ
		STA	EPSM_ADDR0
		LDA	#$8F
		STA	EPSM_DATA0
@wait: 
		bit	PPU_STATUS
		bmi	@wait
		lda	#3
		ldy	#0
@delayloop:   
		CPY	#1
		DEY
		SBC	#0
		BCS	@delayloop
	
		LDA	#$25            ; Timer A Lo
		STA	EPSM_ADDR0
		LDA	#$00
		STA	EPSM_DATA0
		LDA	#$24            ; Timer A Hi
		STA	EPSM_ADDR0
		LDA	#$BF
		STA	EPSM_DATA0
		;LDA #%00111111
		;STA PPUMASK
		LDA	#$80
		STA	irq_func_num
		
		LDA	#$27            ; Enable Timer and IRQ
		CLI
		STA	EPSM_ADDR0
		LDA	#$05
		STA	EPSM_DATA0
		
		LDX	#0
		LDY	#15
@wait_irq
		DEX
		BNE	@wait_irq
		DEY
		BNE	@wait_irq
		
		SEI
		LDA	#$27        ; Acknowledge and disable IRQ
		STA	EPSM_ADDR0
		LDA	#$30
		STA	EPSM_DATA0
		LDA	irq_func_num
		EOR	#$80
		STA	epsm_flag
		BEQ	@ret
		;LDA	#$80	; MMC3 PRG-RAM ENABLE
		STA	MMC3_prg_ram_pr	; MMC3 PRG-RAM ENABLE
		LDA	#$34
		STA	$63FF
		CMP	$63FF
		BEQ	@epsm_ok
		LDA	#0
		STA	epsm_flag
@ret
		RTS

@epsm_ok
		JSR	set_bank_fms
		JMP	famistudio_music_stop
		
		ENDIF


; =============== S U B	R O U T	I N E =======================================

;		align	256
wait_next_frame:
		LDA	Frame_Cnt
@wait_nf:
		CMP	Frame_Cnt
		BEQ	@wait_nf
		RTS


; =============== S U B	R O U T	I N E =======================================


reset_update_flags:
		LDX	#$FF
		STX	tilemap_adr_blk_h+00
		STX	tilemap_adr_blk_h+03
		STX	tilemap_adr_blk_h+06
		STX	tilemap_adr_blk_h+09
		STX	tilemap_adr_blk_h+12
		STX	tilemap_adr_blk_h+15
		
		STX	tilemap_adr_h   ; updated
;		STA	tilemap_adr_h2	; updated
		STX	tilemap_adr_h_v ; updated
;		STA	raw1_update_flag ; updated
;		STA	raw2_update_flag ; updated
		RTS


; =============== S U B	R O U T	I N E =======================================


RESET:
		SEI
		LDX	#0
		STX	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STX	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STX	SND_MASTERCTRL_REG ; pAPU Sound/Vertical Clock Signal Register (R)
		DEX
		TXS
		LDX	#2

@wait1:
		BIT	PPU_STATUS	; PPU Status Register (R)
		BPL	@wait1

@wait2:
		BIT	PPU_STATUS	; PPU Status Register (R)
		BMI	@wait2
		DEX
		BNE	@wait1
		
		STX	PPU_CTRL_REG1	; PPU Control Register #2 (W)
		STX	PPU_CTRL_REG2	; PPU Control Register #1 (W)
		STX	SND_MASTERCTRL_REG ; pAPU Sound/Vertical Clock Signal Register (R)
		LDY	#$40
		STY	JOYPAD_PORT2	; Joypad #2/SOFTCLK (RW)
		STX	PPU_SPR_ADDR
		
		IF	(VRC7=0)
		STX	MMC3_mirroring	; Vertical Mirroring
		
		STX	epsm_flag
		INX
		STX	nmi_flag2
		
		JSR	EPSM_detect
		
		ELSE
		
		STX	VRC7_IRQ_control
		LDA	#$C0
		STA	VRC7_mirroring
		LDA	#$80
		STA	vrc7_flag
		LDA	#$3E
		STA	VRC7_prg_C000
		
		INX
		STX	nmi_flag2
		ENDIF
		
		LDA	#0
		TAX

@clr_ram:
		STA	0,X
		STA	$200,X
		STA	$300,X
		STA	$400,X
		STA	$500,X
		STA	$600,X
		STA	$700,X
		INX
		CPX	#$FE
		BCC	@clr_ram
		
		JSR	reset_update_flags
		LDA	#>write_32_tiles
		STA	ptr_high

		LDX	#$F8
		JSR	set_prg_banks
		JSR	sega_logo_new
		
;		LDA	#$A5
;		CMP	first_boot
;		BEQ	@not_cold_boot
;		STA	first_boot
;		LDA	#0
;		STA	demo_lvl_num
;
;@not_cold_boot:
		JSR	fill_nametable1_with_FFs

		JSR	set_menu_prg_banks
		JSR	title_screen
		LDA	#3
		STA	player_lifes
		LDA	#0
		STA	checkpoint_x_h

g_main:
		JSR	init_objects_vars
		LDA	#0
		STA	pause_flag
		
		LDA	demo_func_id
		CMP	#4
		BCS	skip_lvl_opening
		JSR	set_menu_prg_banks
		JSR	level_opening_screen
skip_lvl_opening:
		LDA	#6
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		LDA	#$28
		STA	ppu_ctrl1_val
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)

		LDA	special_flag
		BEQ	@not_bonus
		LDX	#$1A	; 34010
		JSR	set_prg_banks
		JMP	spec_main
	
@not_bonus:
		STA	irq_func_num ; level_irq
		
		IF	(VRC7=1)
		STA	VRC7_IRQ_control
		LDA	#227
		STA	VRC7_IRQ_latch
		ENDIF
		
;		LDA	#$87
;		STA	MMC3_bank_select
;		LDA	#$19
;		STA	MMC3_bank_data
		JSR	init_level
		
		INC	sonic_Y_h
		LDX	#$14
		JSR	set_prg_banks
		JSR	read_lvl_objects
		DEC	sonic_Y_h
		
		LDX	#$1C
		JSR	set_prg_banks
		JSR	init_sonic_spr_ptr
		JSR	get_sonic_sprites_pos
		JSR	draw_sonic_sprites
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz3
		LDX	act_id
		CPX	#2
		BNE	@not_sbz3
		LDA	#12
@not_sbz3
		STA	palette_num
;		LDA	#0
;		STA	fade_index
		JSR	wait_vbl
		LDA	#$1E
		STA	ppu_ctrl2_val
		LDA	#$88
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STA	ppu_ctrl1_val
		JSR	j_sound_update
	;	nop
	;	nop
	;	nop

;level_fade_out:
		JSR	PALETTE_UNFADE_FULL
		
		IF	(TEST_SPR=1)
		LDA	joy1_hold
		AND	#BUTTON_SELECT
		BEQ	no_test_spr_mode
test_mode_loop:
		JSR	wait_next_frame
		LDX	#$14
		JSR	set_prg_banks
		JMP	test_sprites_mode
no_test_spr_mode:
		ENDIF

		lda	level_id	; load_chaos_emeralds_pal
		cmp	#SPEC_STAGE
		BNE	@not_bonus_level
		lda	emeralds_cnt
		and	#7
		asl
		tay
		lda	emeralds_pal,Y
		STA	palette_buff+9+16 ; spr
		lda	emeralds_pal+1,y
		STA	palette_buff+10+16 ; spr
@not_bonus_level
		
		LDA	hscroll_val
		STA	camera_X_l_old
		LDA	level_spr_chr2
		STA	chr_spr_bank2	; enemy	sprites	bank

game_loop:
		LDA	Frame_Cnt
		CMP	Current_Frame
		BEQ	game_loop
		STA	Current_Frame
		CLI
		DEC	nmi_flag2
		LDA	ppu_ctrl1_val
		ORA	#$80
		STA	ppu_ctrl1_val
		;LDX	#$1C
		;JSR	set_prg_banks
		LDX	#$15 ; obj_code.asm
		JSR	set_prg_bank_a000
		JSR	hide_all_sprites_fast
		LDX	#$1C
		JSR	set_prg_banks
		LDX	#0
		STX	sprite_id
		
		LDA	demo_func_id
		BEQ	@not_demoplay
		
		IF	(REPLAY_WRITE=1)
		CMP	#4
		BEQ	@write_replay
		ENDIF
		LDX	#$15 ; obj_code.asm
		JSR	set_prg_bank_a000
		JSR	DEMO_PLAY
		LDX	#$1D ; player_code.asm
		JSR	set_prg_bank_a000
		JMP	@not_paused
; ---------------------------------------------------------------------------

@not_demoplay:
		LDA	demo_record_flag
		BEQ	@no_record
@write_replay:
		JSR	DEMO_SAVE
@no_record:
		LDA	joy1_press
		AND	#BUTTON_START
		BEQ	@not_pressed_pause
		
		LDA	death_func_num
		BNE	@not_pressed_pause
		
		LDX	#%1100
		LDA	pause_flag
		EOR	#$E0
		STA	pause_flag
		BNE	@paused
		STA	chr_spr_bank1 ; fix if Sonic out of screen (act3)
		LDX	#%1111
		LDA	#$FF
		STA	var_ch_PrevFreqHigh
		STA	var_ch_PrevFreqHigh+1
@paused
		STX	SND_MASTERCTRL_REG
		LDA	ppu_ctrl2_val
		AND	#%00011111
		ORA	pause_flag
		STA	ppu_ctrl2_val

@not_pressed_pause:
		LDA	pause_flag
		BEQ	@not_paused
		JSR	draw_pause_sprites
		JMP	skip_draw
; ---------------------------------------------------------------------------

@not_paused:
		LDA	frame_cnt_for_1sec
		BNE	@skip_upd_timers
		JSR	update_sonic_timers

@skip_upd_timers:
		;LDX	#$1C
		;JSR	set_prg_banks
		JSR	super_sonic_check
		LDX	#$14
		JSR	set_prg_banks
		JSR	pro_level_objects
		LDA	boss_func_num
		BEQ	@skip_boss_funcs
		ASL	A
		TAY
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$11
		STA	MMC3_bank_data
		
		ELSE
		LDA	#$11
		STA	VRC7_prg_8000
		ENDIF
		
		JSR	boss_funcs
@skip_boss_funcs:

		IF	(VRC7=0)
		LDA	#$87
		STA	MMC3_bank_select
		LDA	#$19
		STA	MMC3_bank_data
		
		ELSE
		LDA	#$19
		STA	VRC7_prg_A000
		ENDIF
		
		JSR	backgnd_rendering

		LDY	sonic_anim_num
		BMI	@skip_draw_sonic
		LDX	#$1C
		JSR	set_prg_banks
		JSR	draw_sonic
@skip_draw_sonic:
		LDA	sprite_id
		BNE	@have_spr
		LDA	#4
		STA	sprite_id
@have_spr
		LDX	#$12
		JSR	set_prg_banks
		JSR	draw_objects_sprites
		LDA	capsule_func_num
		BEQ	@skip_draw_capsule
		JSR	draw_capsule_sprites

@skip_draw_capsule:
		LDA	boss_func_num
		CMP	#4
		BCC	@skip_draw_boss
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$11
		STA	MMC3_bank_data
		
		ELSE
		LDA	#$11
		STA	VRC7_prg_8000
		ENDIF
		
		JSR	draw_boss

@skip_draw_boss:

		LDA	demo_func_id
		CMP	#4
		BCS	skip_draw
		LDX	#$1C
		JSR	set_prg_banks
		JSR	draw_time_and_rings

skip_draw:
		LDA	Frame_Cnt
		ROR	A
		ROR	A
		ROR	A
		AND	#3
		TAX
		LDA	chr_anim_b1,X
		STA	chr_bkg_bank4	; bkg level animation bank

		LDA	demo_func_id
		BEQ	@skip_demo_funcs
		INC	nmi_flag2
		JMP	demo_functions

@skip_demo_funcs:
		LDA	death_func_num
		BEQ	@skip_death_f
		JSR	death_functions

@skip_death_f:
		LDA	level_finish_func_num
		BEQ	@skip_finish_f
		JSR	level_finish_funcs

@skip_finish_f:
		LDA	level_end_func_num
		BNE	@go_level_end_f
		INC	nmi_flag2
		JMP	game_loop
; ---------------------------------------------------------------------------

@go_level_end_f:
		LDX	#0
		STX	hscroll_val
		STX	vscroll_val
		JSR	set_menu_prg_banks
		INC	nmi_flag2
		LDA	level_end_func_num
		JSR	jump_by_jmptable
; ---------------------------------------------------------------------------
		.WORD locret_C2B4B
		.WORD continue_screen
		.WORD clr_and_go_main
		.WORD RESET	; game_reset
		.WORD act_win
		.WORD ending_screen


; =============== S U B	R O U T	I N E =======================================


wait_vbl:
		LDA	PPU_STATUS	; PPU Status Register (R)
		BPL	wait_vbl

loc_C24E1:				; PPU Status Register (R)
		LDA	PPU_STATUS
		BMI	loc_C24E1
		RTS
; End of function wait_vbl


; =============== S U B	R O U T	I N E =======================================


jump_by_jmptable:
		ASL	A
		TAY
		PLA
		STA	temp_ptr_l
		PLA
		STA	temp_ptr_l+1
		INY
jump_from_ptr:	LDA	(temp_ptr_l),Y
		STA	tmp_ptr_l
		INY
		LDA	(temp_ptr_l),Y
		STA	tmp_ptr_l+1
		JMP	(tmp_ptr_l)
; End of function jump_by_jmptable


; =============== S U B	R O U T	I N E =======================================


hide_all_sprites:
		LDX	#0
hide_sprites:
		LDA	#$F8

@hide_unused_spr:
		STA	sprites_Y,X
		INX
		INX
		INX
		INX
		BNE	@hide_unused_spr
		RTS
; End of function hide_all_sprites


; =============== S U B	R O U T	I N E =======================================


fill_nametables_with_FFs:
		LDY	#0
		LDA	#$FF
		BNE	fill_2nt ; JMP

fill_nametable1_with_FFs:
		LDA	#$FF
fill_nametable1_with_value:
		LDY	#$80
fill_2nt:
		LDX	#$20
fill_nt:
		STX	PPU_ADDRESS
		LDX	#0
		STX	PPU_ADDRESS

@fill_nt:
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		DEY
		BNE	@fill_nt
		RTS
; End of function fill_nametable_with_FFs


; =============== S U B	R O U T	I N E =======================================


enable_nmi_88:
		LDA	#$88
enable_nmi:
		PHA
		LDA	#$1E
		STA	ppu_ctrl2_val
		BIT	PPU_STATUS
		LDA	#$00
		STA	PPU_SPR_ADDR
		PLA
		STA	ppu_ctrl1_val
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		RTS


; =============== S U B	R O U T	I N E =======================================

;dmc_timer	equ	var_ch_VolColumn+4 ; dpcm joy safe reads timer

READ_JOYS:
		;lda	joy1_press
		;sta	joy1_hold_m ; joy1_press_prev

		lda	ending_joy_val
		tax
		bne	@write_joy_vals
		INX
		;LDX	#1
		LDA	SND_MASTERCTRL_REG
		AND	#$10
		PHP
		LDY	#0
		JSR	@joy_read_port
		PLP
		BEQ	@save_buttons
		STA	tmp_var_28
		JSR	@joy_read_port
		CMP	tmp_var_28
		BEQ	@save_buttons
		STA	tmp_var_26
		JSR	@joy_read_port
		CMP	tmp_var_26
		BEQ	@save_buttons
		LDA	tmp_var_28
		STA	tmp_var_25

@save_buttons:
		TAX
		EOR	joy1_hold
		AND	tmp_var_25
@write_joy_vals:
		STX	joy1_hold
		STA	joy1_press
		RTS

@joy_read_port:
		STX	JOYPAD_PORT1 ; 1
		;STX	tmp_var_25
		STY	JOYPAD_PORT1 ; 0
		REPT	8
@j_port_read:
		LDA	JOYPAD_PORT1
		AND	#3
		CMP	#1
		ROL	tmp_var_25
		ENDR
		;BCC	@j_port_read
		LDA	tmp_var_25
		RTS


; =============== S U B	R O U T	I N E =======================================

; mostly for palettes

vram_updates_from_buff:
		LDA	vram_buffer_adr_h
		BEQ	locret_C25D7
vram_updates_from_buff_:
		BMI	vram_updates_type2
		LDA	vram_buffer_ppu_mode
		ORA	ppu_ctrl1_val
		AND	#$7F
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		LDX	#0

loc_C25A1:
		LDY	vram_buffer_h_length
		LDA	PPU_STATUS
		LDA	vram_buffer_adr_h
		STA	PPU_ADDRESS	; VRAM Address Register	#2 (W2)
		LDA	vram_buffer_adr_l
		STA	PPU_ADDRESS	; VRAM Address Register	#2 (W2)

loc_C25B0:				; also various NT data
		LDA	palette_buff,X
		STA	PPU_DATA	; VRAM I/O Register (RW)
		INX
		DEY
		BNE	loc_C25B0
		LDA	vram_buffer_adr_l
		CLC
		LDY	vram_buffer_ppu_mode
		ADC	vram_inc_by_mode,Y
		STA	vram_buffer_adr_l
		BCC	loc_C25CB
		INC	vram_buffer_adr_h

loc_C25CB:
		DEC	vram_buffer_v_length
		BNE	loc_C25A1
		LDA	#0		; done!
		STA	vram_buffer_adr_h

locret_C25D7:
		RTS
		
vram_inc_by_mode:
		.BYTE	$20,$00,$00,$00
		.BYTE	$01
		
		
vram_updates_type2:
		AND	#$7F
		STA	tmp_var_25
		LDA	ppu_ctrl1_val
		AND	#$7F
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		LDX	#0
		STX	vram_buffer_adr_h ; done!
@next:		
		;LDA	palette_buff,X
		LDA	#$22		; high ptr
		STA	PPU_ADDRESS
		LDA	palette_buff,X ; low ptr
		INX
		STA	PPU_ADDRESS
		LDY	#8	; length
		
@copy		LDA	palette_buff,X
		STA	PPU_DATA
		INX
		DEY
		BNE	@copy
		INX	; skip 9th byte
		DEC	tmp_var_25
		BNE	@next
		RTS
; End of function vram_updates_from_buff


; =============== S U B	R O U T	I N E =======================================


act_win:
		JSR	set_menu_prg_banks
		JSR	level_win_screen
		JMP	clr_and_go_main
; End of function level_end_funcs


; =============== S U B	R O U T	I N E =======================================


;game_win:
;		JSR	set_menu_prg_banks
;		JMP	ending_screen
; End of function game_win


; =============== S U B	R O U T	I N E =======================================


set_menu_prg_banks:
		LDX	#$18
set_prg_banks:
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		STX	MMC3_bank_data
		STX	prg1_id
		INX
set_prg_bank_a000:
		LDA	#$87
		STA	MMC3_bank_select
		STX	MMC3_bank_data
		STX	prg2_id

		ELSE
		
		STX	prg1_id
		STX	VRC7_prg_8000
		INX
set_prg_bank_a000:
		STX	prg2_id
		STX	VRC7_prg_A000
		ENDIF
		
		RTS


; =============== S U B	R O U T	I N E =======================================


death_functions:
		JSR	jump_by_jmptable
; End of function death_functions

; ---------------------------------------------------------------------------
death_f_ptrs:	.WORD locret_C2B4B
		.WORD death_func_01
		.WORD death_func_02
		.WORD death_func_03
		.WORD game_over
; ---------------------------------------------------------------------------

deathf_game_x_l	equ	$5F
deathf_game_x_h	equ	$60
deathf_over_x_l	equ	$61
deathf_over_x_h	equ	$62

deathf_timer	equ	$604
deathf_txt_base	equ	$605

; =============== S U B	R O U T	I N E =======================================


death_func_01:
		DEC	player_lifes
		LDA	#$FF
		STA	deathf_game_x_h
		LDA	#$D8
		STA	deathf_game_x_l
		LDA	#1
		STA	deathf_over_x_h
		LDA	#8
		STA	deathf_over_x_l
		LDA	#$20
		STA	deathf_timer
		INC	death_func_num
		LDA	player_lifes
		BNE	have_lives

set_game_over_music:
		LDA	#8	; GAME
set_time_over_music:
		STA	deathf_txt_base
write_game_over_music:
		LDA	#$31
		STA	music_to_play
locret_C2B4B:
		RTS
; ---------------------------------------------------------------------------

have_lives:
		LDA	time_over_flag
		BEQ	@not_time_over
		LDA	#16	; TIME
		BNE	set_time_over_music ; JMP
; ---------------------------------------------------------------------------

@not_time_over:
		STA	deathf_txt_base
		LDA	#2
		STA	level_finish_func_cnt
		INC	death_func_num
		RTS
; End of function death_func_01


; =============== S U B	R O U T	I N E =======================================


death_func_03:
		JSR	game_over_sprites

		LDA	current_music
		CMP	#$31
		BNE	@have_lives
		
		LDA	var_Channels
		AND	#$20
		BNE	locret_C2BA7
	
		IF	(VRC7=0)
		LDA	epsm_flag
		BPL	@no_lives
		LDA	famistudio_song_speed
		BEQ	@no_lives
		BMI	@no_lives
		RTS
		ENDIF
		
@have_lives:
		LDA	frame_cnt_for_1sec
		BNE	locret_C2BA7
		DEC	level_finish_func_cnt
		BPL	locret_C2BA7
@no_lives:
		INC	death_func_num
		LDA	#5
		STA	fade_index

locret_C2BA7:
		RTS
; End of function death_func_03


; =============== S U B	R O U T	I N E =======================================


game_over:
		JSR	game_over_sprites
		JSR	PALETTE_FADE_1
		BNE	locret_C2BCA
		LDA	#0
		STA	death_func_num
		LDY	#2
		LDA	player_lifes
		BNE	loc_C2BC8
		STA	checkpoint_x_h
		LDY	#3
		LDA	continues
		BEQ	loc_C2BC8
		LDY	#1

loc_C2BC8:
		STY	level_end_func_num

locret_C2BCA:
		RTS
; End of function game_over


; =============== S U B	R O U T	I N E =======================================


clr_and_go_main:
		LDA	#0
		STA	music_to_play
		STA	hscroll_val
		STA	vscroll_val
		LDA	#2
		STA	irq_func_num
		JMP	g_main
; End of function clr_and_go_main


; =============== S U B	R O U T	I N E =======================================


death_func_02:
		JSR	game_over_sprites
		LDA	deathf_game_x_l
		CLC
		ADC	#4
		STA	deathf_game_x_l
		BCC	@no_inc_h
		INC	deathf_game_x_h
@no_inc_h:
		LDA	deathf_over_x_l
		SEC
		SBC	#4
		STA	deathf_over_x_l
		BCS	@no_dec_h
		DEC	deathf_over_x_h
@no_dec_h:
		DEC	deathf_timer
		BPL	locret_C2C18
		INC	death_func_num
		LDA	deathf_txt_base
		CMP	#8
		LDA	#6
		BCC	@write_cnt
		LDA	#8
@write_cnt:
		STA	level_finish_func_cnt

locret_C2C18:
		RTS
; End of function sub_C2BDD


; =============== S U B	R O U T	I N E =======================================


game_over_sprites:
		LDA	deathf_txt_base ; GAME/TIME  (8/16)
		BEQ	locret_C2C18
		LDX	deathf_game_x_l
		LDY	deathf_game_x_h
		JSR	game_over_spr_pos
		LDA	#$84
		STA	chr_spr_bank1
		LDA	#0	; OVER
		LDX	deathf_over_x_l
		LDY	deathf_over_x_h

; End of function game_over_sprites
; =============== S U B	R O U T	I N E =======================================

game_over_spr_pos:
		STA	spr_cfg_off
		STX	tmp_var_28
		LDX	#0
		TYA
		BMI	loc_C2C6A
		BNE	loc_C2C7E

loc_C2C5A:
		LDA	tmp_var_28

loc_C2C5C:
		STA	tmp_x_positions,X
		INX
		CPX	#4
		BCS	loc_C2C87
		;CLC
		ADC	#8
		BCC	loc_C2C5C
		BCS	loc_C2C7E

loc_C2C6A:
		LDA	#0
		STA	tmp_x_positions,X
		INX
		CPX	#4
		BCS	loc_C2C87
		LDA	tmp_var_28
		;CLC
		ADC	#8
		STA	tmp_var_28
		BCC	loc_C2C6A
		BCS	loc_C2C5C

loc_C2C7E:
		LDA	#0

loc_C2C80:
		STA	tmp_x_positions,X
		INX
		CPX	#4
		BCC	loc_C2C80

loc_C2C87:
		LDA	#$70
		STA	tmp_y_positions
		LDA	#$78
		STA	tmp_y_positions+1

; End of function game_over_spr_pos
; =============== S U B	R O U T	I N E =======================================

;game_over_spr_draw:
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_C2C94:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		STA	tmp_var_2B
		LDY	#0

loc_C2C9D:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_C2CBE
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	game_over_tls,Y
		STA	sprites_tile,X
		LDA	#1
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX

loc_C2CBE:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_C2C9D
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_C2C94
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function game_over_spr_draw

; ---------------------------------------------------------------------------
game_over_tls:	.BYTE $22, $20, $16, $24 ; OVER
		.BYTE $23, $21, $17, $25 ; over

		.BYTE $10, $14, $12, $16 ; GAME
		.BYTE $11, $15, $13, $17 ; game

		.BYTE $1A, $18, $12, $16 ; TIME
		.BYTE $1B, $19, $13, $17 ; time

; =============== S U B	R O U T	I N E =======================================


init_objects_vars:
		LDA	#0
		STA	sonic_X_speed
		STA	sonic_Y_speed
		INC	sonic_Y_speed	; FIX for bonus levels
		STA	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		STA	sonic_spr_in_anim ; sub	sprite number
		STA	sonic_spr_anim_timer
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		STA	sonic_state	; 0x2- shield; 0x4 - rolling
		STA	sonic_spr_cfg_ptr+1
		STA	sonic_spr_cfg_ptr
		STA	sonic_anim_num
		STA	sonic_anim_num_old
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		STA	invicible_timer
		STA	water_timer	; in water flag
		STA	sonic_blink_timer
		STA	speed_shoes_timer
		STA	sonic_inertia_timer ; can't skid timer
		STA	sonic_x_h_on_scr ; sonic-camera
		STA	sonic_y_h_on_scr ; sonic-camera
		STA	sonic_idle_act_cnt
		STA	timer_m
		STA	timer_10s
		STA	timer_s
		;STA	rings_100s
		;STA	rings_10s
		;STA	rings_1s
		;STA	lifes_for_rings_mask
		JSR	clear_all_rings
		
		STA	lock_camera_flag
		STA	lock_move_flag	; sonic	lock in	camera area
		STA	time_over_flag
		STA	death_func_num
		STA	level_finish_func_cnt
		STA	level_end_func_num
		STA	level_finish_func_num
		STA	capsule_func_num
		STA	ending_joy_val
		JSR	clear_all_objects
		;LDA	#0
		LDY	#$F
@clr_killed_objs:
		STA	killed_objs_bits,Y
		DEY
		BPL	@clr_killed_objs
		;LDA	#0
		LDY	#$2B-4
@clear_boss_vars:
		STA	boss_func_num,Y
		DEY
		BPL	@clear_boss_vars
			
		LDA	level_id
		CMP	#SPEC_STAGE
		BNE	@not_bonus_level
		LDX	act_id
		LDA	spec_init_anim,X
		STA	sonic_anim_num
		STA	sonic_anim_num_old
		STA	sonic_act_spr
		;LDA	sonic_attribs
		;ORA	#MOVE_UP
		;STA	sonic_attribs
		
@not_bonus_level
		RTS
; End of function init_objects_vars

spec_init_anim:
		.BYTE	8
		.BYTE	0
		.BYTE	8
		.BYTE	8
		.BYTE	0
		.BYTE	0
		.BYTE	0
		.BYTE	0

; =============== S U B	R O U T	I N E =======================================


clear_all_objects:
		LDY	#OBJECTS_SLOTS-1
@clr_objs:
		hide_obj_sprite
		LDA	#0
		STA	objects_type,Y
		DEY
		BPL	@clr_objs
		STA	objects_cnt
		RTS


; =============== S U B	R O U T	I N E =======================================


level_finish_funcs:
		JSR	jump_by_jmptable
; End of function level_finish_funcs

; ---------------------------------------------------------------------------
lvl_finish_f_ptrs:.WORD	locret_C2B4B
		.WORD lvl_finish_f_01
		.WORD lvl_finish_f_02
		.WORD lvl_finish_f_03
		.WORD lvl_finish_f_01
		.WORD lvl_finish_f_02
		.WORD lvl_finish_f_06

; =============== S U B	R O U T	I N E =======================================


lvl_finish_f_01:
		LDA	#6
		STA	level_finish_func_cnt
		INC	level_finish_func_num
		RTS
; End of function lvl_finish_f_01


; =============== S U B	R O U T	I N E =======================================


lvl_finish_f_02:
		LDA	frame_cnt_for_1sec
		BNE	locret_C2ED9
		DEC	level_finish_func_cnt
		BPL	locret_C2ED9
		INC	level_finish_func_num
		LDA	#5
		STA	fade_index

locret_C2ED9:
		RTS
; End of function lvl_finish_f_02


; =============== S U B	R O U T	I N E =======================================


lvl_finish_f_03:
		JSR	PALETTE_FADE_2
		BNE	locret_C2F07
		;INC	level_finish_func_num
		LDA	#0
		STA	level_finish_func_num
		LDA	#4
		STA	level_end_func_num
		RTS
; End of function lvl_finish_f_03


; =============== S U B	R O U T	I N E =======================================


lvl_finish_f_06:
		JSR	PALETTE_FADE_1
		BNE	locret_C2F07
		LDA	#0
		STA	music_to_play
		STA	level_finish_func_num
		STA	boss_sub_func_id
		STA	boss_func_num
		LDA	#5
		STA	level_end_func_num
		LDA	#$FF
		STA	irq_func_num

locret_C2F07:
		RTS
; End of function lvl_finish_f_06


; =============== S U B	R O U T	I N E =======================================


options_vram_writes:
		INX
		BEQ	@title_vram_write
		;LDA	#$87
		;STA	MMC3_bank_select
		;LDA	#$3A010/$2000
		;STA	MMC3_bank_data
		JMP	options_update_attrs
@title_vram_write:
		JMP	title_bkg_anim_load2


final_boss_vram_updates:
		BMI	options_vram_writes
		LDA	final_vram_tbl-1,X
		TAX
		CLC
		ADC	#$2A
		STA	tmp_var_25
		
		LDA	vram_buffer_adr_h
		LDY	vram_buffer_adr_l

@next_line:
		STA	PPU_ADDRESS
		STY	PPU_ADDRESS
		LDY	#6

@write_line:
		LDA	final_boss_vram1,X
		STA	PPU_DATA
		INX
		DEY
		BNE	@write_line
		CPX	tmp_var_25
		BCS	@done
		LDA	vram_buffer_adr_l
		;CLC
		ADC	#$20
		STA	vram_buffer_adr_l
		TAY
		LDA	vram_buffer_adr_h
		ADC	#0
		STA	vram_buffer_adr_h
		JMP	@next_line
; ---------------------------------------------------------------------------

@done:
		LDA	#0
		STA	vram_buffer_adr_h
		STA	final_boss_vram_func
		RTS
; End of function final_boss_vram_updates
; ---------------------------------------------------------------------------
final_vram_tbl:
		.BYTE	0
		.BYTE	6
		.BYTE	54
		.BYTE	48

; ---------------------------------------------------------------------------
final_boss_vram1:.BYTE	$A6, $A7, $EA, $EB, $A8, $A9
final_boss_vram2:.BYTE  $B6, $B7, $FA, $FB, $B8, $B9
		.BYTE  $80, $81, $82, $83, $84,	$85
		.BYTE  $90, $91, $92, $93, $94,	$95
		.BYTE  $86, $87, $88, $89, $8A,	$8B
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF
final_boss_vram3:.BYTE	$FF, $FF, $FF, $FF, $FF, $FF
final_boss_vram4:.BYTE  $80, $81, $82, $83, $84, $85
		.BYTE  $90, $91, $92, $93, $94,	$95
		.BYTE  $86, $87, $88, $89, $8A,	$8B
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $96, $97, $FA, $FB, $98,	$99
		.BYTE  $A6, $A7, $EA, $EB, $A8,	$A9

; =============== S U B	R O U T	I N E =======================================


demo_functions:
		JSR	jump_by_jmptable
; End of function demo_functions

; ---------------------------------------------------------------------------
demo_f_ptrs:	.WORD locret_C2B4B
		.WORD demo_func_01
		.WORD demo_func_02
		.WORD RESET ; demo_func_03
		.WORD demo_func_04
		.WORD demo_func_05
		.WORD demo_func_06

; =============== S U B	R O U T	I N E =======================================


demo_func_01:
		LDA	demo_reset_f
		BNE	inc_demo_func
demo_func_04:
		LDA	demo_cnt1
		BEQ	inc_demo_func
;		LDA	demo_cnt2
;		BEQ	inc_demo_func
;		LDA	demo_nx_read_timer
;		CMP	#$FF
;		BEQ	inc_demo_func
;		DEC	demo_nx_read_timer
		JMP	game_loop
; ---------------------------------------------------------------------------

inc_demo_func:
		INC	demo_func_id

loc_C31B0:
		JMP	game_loop
; End of function demo_func_01


; =============== S U B	R O U T	I N E =======================================


demo_func_02:
		JSR	PALETTE_FADE_1
		BNE	loc_C31B0
		LDA	#0
		STA	music_to_play
		JMP	inc_demo_func
; End of function demo_func_02


; =============== S U B	R O U T	I N E =======================================


demo_func_05:
		JSR	PALETTE_FADE_1
		BNE	loc_C31B0
		BEQ	inc_demo_func
		
; =============== S U B	R O U T	I N E =======================================


demo_func_06:
		JSR	set_menu_prg_banks
		JSR	hide_all_sprites
		;STX	PPU_CTRL_REG1 ; disable nmi
		JSR	ending_scr_off
		LDX	#$FA
		JSR	bkg_banks
		LDA	#1
		STA	ppu_tilemap_mask ; NT $2400
		LDA	#0
		STA	hscroll_val
		STA	vscroll_val
		LDX	#$FF
		;STX	tilemap_adr_blk_h+00
		;STX	tilemap_adr_blk_h+03
		;STX	tilemap_adr_blk_h+06
		;STX	tilemap_adr_blk_h+09
		;STX	tilemap_adr_blk_h+12
		;STX	tilemap_adr_blk_h+15
		STX	tilemap_adr_h   ; updated
		STX	tilemap_adr_h_v ; updated
		STX	irq_func_num ; disable IRQ
		JSR	wait_vbl
		JMP	good_ending_next


; =============== S U B	R O U T	I N E =======================================


PALETTE_FADE_FULL:
		LDA	#5
		.BYTE	$2C

PALETTE_UNFADE_FULL:
		LDA	#0
		STA	fade_index
		JSR	load_palette_ptrs
		LDA	vram_buffer_adr_h
		BEQ	@start_fade

@fade_loop:
		LDA	vram_buffer_adr_h
		BNE	@fade_loop
		LDA	Frame_Cnt
		AND	#3
		BNE	@fade_loop
@start_fade:
		JSR	palette_fade
		BEQ	@end_fade
		CMP	#5
		BNE	@fade_loop

@end_fade:
		RTS
; End of function PALETTE_FADE_FULL


; =============== S U B	R O U T	I N E =======================================


PALETTE_FADE_2:
		LDA	level_id
		CMP	#SPEC_STAGE
		BNE	PALETTE_FADE_1
		LDA	#<palette_buff
		STA	tmp_ptr_l
		LDA	#>palette_buff
		STA	tmp_ptr_l+1
		JMP	palette_fade_

PALETTE_FADE_1:
		JSR	load_palette_ptrs
palette_fade_:
		LDA	vram_buffer_adr_h
		BNE	locret_C33F1
		LDA	Frame_Cnt
		AND	#3
		BNE	locret_C33F1

palette_fade:
		LDX	fade_index
		LDY	#31 ; 32 colors

@fade_pal:
		LDA	(tmp_ptr_l),Y
		SEC
		SBC	fade_values,X
		BPL	@no_black
		LDA	#$F ; black color

@no_black:
		STA	palette_buff,Y
		DEY
		BPL	@fade_pal
		INC	fade_index
		JSR	setup_palette_buff
		LDA	fade_index
		CMP	#9
locret_C33F1:
		RTS
; End of function PALETTE_FADE_1


; =============== S U B	R O U T	I N E =======================================


load_palette_ptrs:
		LDA	palette_num
		ASL	A
		TAY
		LDA	palettes,Y
		STA	tmp_ptr_l
		LDA	palettes+1,Y
		STA	tmp_ptr_l+1
		RTS
; ---------------------------------------------------------------------------
fade_values:	.BYTE $40
		.BYTE $30
		.BYTE $20
		.BYTE $10
		.BYTE 0
		.BYTE $10
		.BYTE $20
		.BYTE $30
		.BYTE $40

palettes:	.WORD GHZ_PAL		; 0
		.WORD marble_pal	; 1
		.WORD spring_pal	; 2
		.WORD lab_pal		; 3
		.WORD star_pal		; 4
		.WORD scrap_brain_pal	; 5
		.WORD final_zone_pal	; 6
		.WORD bonus_st_pal	; 7
		.WORD title_scr_pal	; 8
		.WORD cheat_menu_pal	; 9
		.WORD sega_logo_pal	; 10
		.WORD options_menu_pal  ; 11
		.WORD scrap_brain_pal2  ; 12
		
GHZ_PAL:	.BYTE  $21,   7, $15, $28, $21,	  3, $11, $30, $21, $17, $27, $37, $21,	  7, $1A, $2A
		.BYTE  $21,   1, $16, $36, $21,	  1, $11, $36, $21,  $F, $29, $30, $21,	  7, $27, $30
		
marble_pal:	.BYTE	 3,  $F,   0, $36,   3,	  6, $16, $27,	 3, $14, $24, $30,   3,	  9, $19, $2A
		.BYTE	 3,   1, $16, $36,   3,	  1, $11, $36,	 3,   4, $24, $30,   3,	  7, $27, $30
		
spring_pal:	.BYTE	 4,   7, $17, $38,   4,	 $F, $1B, $37,	 4, $14, $24, $20,   4,	$17, $27, $37
		.BYTE	 4,   1, $16, $36,   4,	  1, $11, $36,	 4,   8, $24, $30,   4,	  7, $27, $30
		
lab_pal:	.BYTE	$F, $17, $27, $37,  $F,	 $C, $19, $39,	$F, $15, $25, $35,  $F,	$12, $22, $32
		.BYTE	$F,   1, $16, $36,  $F,	  1, $11, $36,	$F,   4, $14, $36,  $F,	  7, $27, $30
		
star_pal:	.BYTE	$F, $12, $22, $30,  $F,	  7,   6, $18,	$F,  $A, $19, $30,  $F,	$17, $28, $38
		.BYTE	$F,   1, $16, $36, $10,	  1, $11, $36, $10,   4, $24, $30, $10,	  7, $27, $30
		
final_zone_pal:	.BYTE	$F,  $0, $10, $30,  $F,	$1C, $10, $3C,	$F,  $B, $1B, $28,  $F,	  4, $24, $34
		.BYTE	$F,   1, $16, $36, $10,	  1, $11, $36, $0F,  $F, $00, $10, $0F,	$16, $36, $0F

bonus_st_pal:	.BYTE	$F, $17, $27, $30 ; bkg
		.BYTE	$F, $05, $15, $30 ; bkg
		.BYTE	$F, $11, $21, $30 ; bkg
		.BYTE	$F, $03, $27, $15 ; bkg
		.BYTE	$F,   1, $16, $36 ; spr
		.BYTE   $F,   1, $11, $36 ; spr
		.BYTE   $F,   7, $22, $30 ; spr ; 1/22
		.BYTE   $F,   8, $27, $30 ; spr

title_scr_pal:	incbin	menu\title.pal

cheat_menu_pal:	incbin	menu\cheat_menu.pal

scrap_brain_pal:
		.BYTE	$F, $17, $27, $37
		.BYTE	$F, $14, $24, $34
		.BYTE	$F,  $B, $1B, $2B
		.BYTE	$F,   0, $10, $37
		.BYTE	$F,   1, $16, $36
		.BYTE	$F,   1, $11, $36
		.BYTE	$F,  $4, $24, $30
		.BYTE	$F,   7, $27, $30
		
scrap_brain_pal2:
		.BYTE	$F, $17, $27, $37
		.BYTE	$F, $14, $24, $34
		.BYTE	$F,  $B, $1B, $2B
		.BYTE	$F,   0, $10, $37
		.BYTE	$F,   1, $16, $36
		.BYTE	$F,   1, $11, $36
		.BYTE	$F,  $5, $15, $35
		.BYTE	$F,   7, $27, $30
		
sega_logo_pal:
		.BYTE	$30,$30,$11,$11
		.BYTE	$30,$30,$11,$11
		.BYTE	$30,$30,$11,$11
		.BYTE	$30,$30,$11,$11
		.BYTE	$30,$0F,$11,$30
		.BYTE	$30,$01,$11,$36
		.BYTE	$30,$01,$16,$36
		.BYTE	$30,$0F,$16,$36
		
options_menu_pal:
		.BYTE	$0F,$02,$30,$12
		.BYTE	$0F,$02,$27,$37
		.BYTE	$0F,$02,$12,$31
		.BYTE	$0F,$0F,$0F,$0F
		.BYTE	$0F,$11,$0F,$30
		.BYTE	$0F,$01,$11,$36
		.BYTE	$0F,$01,$16,$36
		.BYTE	$0F,$0F,$16,$36		
		

emeralds_pal:
		.BYTE	$01,$22 ; BLUE EMERALD (V1.5)
		.BYTE	$18,$28 ; YELLOW
		.BYTE	$14,$24 ; ROSE (PINK)
		.BYTE	$1A,$29 ; GREEN
		.BYTE	$05,$16 ; RED
		.BYTE	$00,$10	; GRAY (WHITE)
		.BYTE	$03,$13 ; PURPLE (7th)
		.BYTE	$0c,$1c ; LIGHTBLUE (8th unused)


; =============== S U B	R O U T	I N E =======================================


disable_super_sonic:
		LDA	sonic_state
		BPL	no_need_ss_remove
		AND	#$7F
		STA	sonic_state ; remove_SS
		LDA	#2
		STA	sonic_blink_timer
		LDX	#0 ; restore sonic palette
setup_ss_palette:
		LDA	normal_colors,X
		STA	palette_buff+$1D
		LDA	normal_colors+1,X
		STA	palette_buff+$1E
		LDA	normal_colors+2,X
		STA	palette_buff+$1F
;		RTS
;		
setup_palette_buff:
		LDA	#$3F
		STA	vram_buffer_adr_h
		LDA	#0
		STA	vram_buffer_adr_l
		STA	vram_buffer_ppu_mode
		LDA	#32
		STA	vram_buffer_h_length
		LDA	#1
		STA	vram_buffer_v_length
no_need_ss_remove:
		RTS
; ---------------------------------------------------------------------------
normal_colors:
		.BYTE	$07,$27,$30
super_colors:
		.BYTE	$17,$27,$37


; =============== S U B	R O U T	I N E =======================================


set_supers_music:
		LDA	#$37	; superS-S2
		LDY	super_em_cnt
		CPY	#7
		BCC	@not_hypers
		LDA	#$38	; superS-S3K
@not_hypers
;		LDY	invicible_timer
;		BEQ	@no_invicible
;		LDA	#$21	; inviciblity
;@no_invicible:
		RTS


; =============== S U B	R O U T	I N E =======================================


start_supers_music:
		LDA	#$3B	; superS-S2-init
		LDY	super_em_cnt
		CPY	#7
		BCC	@not_hypers
		LDA	#$3C	; superS-S3K-init
@not_hypers
;		LDY	invicible_timer
;		BEQ	@no_invicible
;		LDA	#$21	; inviciblity
;@no_invicible:
		RTS

; ---------------------------------------------------------------------------
music_by_level:.BYTE $23, $24, $25, $26, $27, $2E, $2F, $28


; =============== S U B	R O U T	I N E =======================================


get_block_number:
		LDY	tmp_var_65
		LDA	cam_y_mults,Y
		CLC
		ADC	tmp_var_63
		JSR	LOAD_BLOCKS_ROOM
		LDA	tmp_var_64
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		STA	tmp_var_25
		LDA	tmp_var_66
		AND	#$F0
		ORA	tmp_var_25
		TAY
		LDA	(tmp_ptr_l),Y ; temp
		RTS


; =============== S U B	R O U T	I N E =======================================


LOAD_BLOCKS_ROOM:
		TAY
		LDA	#0
		STA	tmp_ptr_l	; temp

set_screen_bank:
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	level_bkg_prg
		STA	MMC3_bank_data
		
		ELSE
		LDA	level_bkg_prg
		STA	VRC7_prg_8000
		ENDIF
		
		
		LDA	(ring_map_ptr),Y
		STA	ring_map_id
		LDA	(scr_map_ptr),Y
		STA	screen_number
		TAY
		
		AND	#$1F
		ORA	#$80
		STA	tmp_ptr_l+1
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		ENDIF
		
		TYA
		ASL	A	; $80->C
		ASL	A	; $40->C
		BCS	@rooms_64_to_127
		BMI	@rooms_32_to_63
		LDA	level_blk_bank1
		BCC	@write_rooms_bank ; JMP
; ---------------------------------------------------------------------------
@rooms_64_to_127:
		BMI	@rooms_96_to_127
		LDA	level_blk_bank3
		BCS	@write_rooms_bank ; JMP
; ---------------------------------------------------------------------------
@rooms_96_to_127:
		LDA	level_blk_bank4
		BCS	@write_rooms_bank ; JMP
; ---------------------------------------------------------------------------

@rooms_32_to_63:
		LDA	level_blk_bank2

@write_rooms_bank:

		IF	(VRC7=0)
		STA	MMC3_bank_data
		ELSE
		STA	VRC7_prg_8000
		ENDIF
		
		RTS


; =============== S U B	R O U T	I N E =======================================

; jump from blk_phys2_code
ring_block:
		LDA	sonic_X_speed
		BEQ	@ok
		DEC	sonic_X_speed
@ok

		LDA	block_number

; jump from bkg_read_code
check_ring_collected:
		AND	#$1F
		TAX
		LDA	ring_byte_base,X
		CLC
		ADC	ring_map_id
		TAY
		LDA	rings_memory,Y
		AND	ring_bit_mask,X
		BNE	pick_ring
		RTS
; ---------------------------------------------------------------------------

pick_ring:
		LDA	rings_memory,Y
		AND	rings_bit_mask,X
		STA	rings_memory,Y
		
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS
		BCS	@no_create_anim
		LDA	#$7D	; object_pick_ring_anim
		STA	objects_type,Y	
		LDA	#0
		STA	objects_var_cnt,Y ; var/counter	
		LDA	temp_x_l
		AND	#$F0
		STA	objects_X_l,Y
		LDA	temp_x_h
		STA	objects_X_h,Y
		LDA	temp_y_l
		AND	#$F0
		STA	objects_Y_l,Y
		LDA	temp_y_h
		STA	objects_Y_h,Y
		hide_obj_sprite
		INY
		STY	objects_cnt
@no_create_anim:
		
		LDA	#2
		STA	sfx_to_play
		LDY	#0
		LDX	rings_1s
		INX
		CPX	#$A
		BCS	loc_9AFB3
		STX	rings_1s
		BCC	loc_9AFC9

loc_9AFB3:
		STY	rings_1s
		LDX	rings_10s
		INX
		CPX	#$A
		BCS	loc_9AFC3
		STX	rings_10s
		BCC	loc_9AFC9

loc_9AFC3:
		JSR	life_for_rings

loc_9AFC9:
		LDA	tmp_var_64
		AND	#$F0
		LSR	A
		LSR	A
		LSR	A
		STA	tmp_var_25
		LDA	tmp_var_63
		AND	#1
		EOR	#8
		STA	tmp_var_2B
		LDA	tmp_var_66
		AND	#$F0
		ASL	A
		ROL	tmp_var_2B
		ASL	A
		ROL	tmp_var_2B
		ORA	tmp_var_25
		LDX	blocks_to_upd_off
		STA	blocks_vram_l,X
		LDA	block_number
		CMP	#$F0
		BCS	block_over_240
		LDA	level_blk_tile1
		BCC	block_lower_240

block_over_240:
		LDA	level_blk_tile5

block_lower_240:
		STA	blocks_vram_m,X
		LDA	tmp_var_2B
		STA	blocks_vram_h,X
		INX
		INX
		INX
		STX	blocks_to_upd_off
		LDA	#0
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------
life_for_100_rings_hack: ; jump from rings monitor
life_for_rings:		; from normal rings
		STY	rings_10s
		LDY	rings_100s
		LDA	ring_bit_mask,Y
		AND	lifes_for_rings_mask
		BNE	@no_add_life ; no lifes twice for same count
		LDA	ring_bit_mask,Y
		ORA	lifes_for_rings_mask
		STA	lifes_for_rings_mask
		
;		LDA	sonic_state
;		BMI	@no_add_life ; no lifes if supersonic
		LDA	player_lifes
		CMP	#99	; max 99 lives
		BCS	@no_add_life
		INC	player_lifes
		LDA	#$2C
		STA	music_to_play
@no_add_life:
		INC	rings_100s
		RTS


; =============== S U B	R O U T	I N E =======================================


sonic_get_dmg:	
		STA	sonic_blink_timer
		LDA	#$A
		STA	sonic_anim_num
		LDA	#$30
		STA	sonic_X_speed
		STA	sonic_Y_speed
		LDA	sonic_attribs
		EOR	#3
		ORA	#$C
		STA	sonic_attribs
		LDA	sonic_state
		TAY
		AND	#2	; shield
		BEQ	drop_rings_bank
		TYA
		AND	#$FD
		STA	sonic_state
		LDA	#6	; get hit sfx
		STA	sfx_to_play
		RTS
; ---------------------------------------------------------------------------

drop_rings_bank:			; from enemies
		LDA	#RINGS_DROP
		STA	tmp_var_28
		LDA	rings_100s
		BNE	@drop_rings
		LDA	rings_10s
		BNE	@drop_rings
		LDA	rings_1s
		BEQ	sonic_set_death
		CMP	#RINGS_DROP
		BCS	@drop_rings
		STA	tmp_var_28

@drop_rings:
		LDY	objects_cnt
@create_rings_loop:
		CPY	#OBJECTS_SLOTS
		BCS	@clear_rings_cnt
		LDA	#$16	; object_ring
		STA	objects_type,Y	
		LDY	tmp_var_28
		LDA	drop_rings_tbl,Y
		LDY	objects_cnt
		STA	objects_var_cnt,Y ; var/counter	
		LDA	sonic_X_l
		STA	objects_X_l,Y
		LDA	sonic_X_h
		STA	objects_X_h,Y
		LDA	sonic_Y_l
		SEC
		SBC	#24
		STA	objects_Y_l,Y
		LDA	sonic_Y_h
		SBC	#0
		STA	objects_Y_h,Y
		hide_obj_sprite
		INY
		STY	objects_cnt
		DEC	tmp_var_28
		BNE	@create_rings_loop

@clear_rings_cnt:
		LDA	#4		; drop rings sfx
		STA	sfx_to_play
		
clear_all_rings:
		LDA	#0
		STA	rings_100s
		STA	rings_10s
		STA	rings_1s
		STA	lifes_for_rings_mask
		RTS
; ---------------------------------------------------------------------------
drop_rings_tbl:
		.BYTE	$01,$91,$13,$83,$26,$A6,$38,$B8
; ---------------------------------------------------------------------------
sonic_set_death_bankA:
sonic_set_death:
		LDA	#$50
		STA	sonic_Y_speed
		LDA	#9
sonic_set_death_drowning:
		STA	sonic_anim_num
		STA	lock_camera_flag
		LDA	#0
		STA	sonic_X_speed
		LDY	sonic_blink_timer
		STA	sonic_blink_timer
		STA	invicible_timer
		LDA	sonic_attribs
		ORA	#4	; 0x4 - up
		STA	sonic_attribs
		LDA	#6	; death	sfx num
		CPY	#6	; timer = 6 = dmg from block
		BNE	@not_spikes_death
		LDY	block_number
		CPY	#$B8	; lava_block
		BEQ	@not_spikes_death
		LDA	#$F	; death sfx spikes block
		
@not_spikes_death
		STA	sfx_to_play
		RTS

; --------------------------------------
src	equ	$34
tag1	equ	$25
tag2	equ	$26
tag3	equ	$27

UNRLE:
	LDY	#0
	JSR	get_src_byte1
	TAX
	STX	tag1	; rle tag
	INX
	STX	tag2	; rle tag2
	INX
	STX	tag3	; rle tag3
	
unrle_plus:
	JSR	get_src_byte1
	CMP	tag1
	BEQ	write_repeated
	CMP	tag2
	BEQ	write_repeated_plus
	CMP	tag3
	BEQ	write_zeros
	STA	PPU_DATA
	BNE	unrle_plus
; --------------------------------------
write_zeros:
	JSR	get_src_byte1
	TAX
	LDA	#0
	BEQ	fill_zeros
; --------------------------------------
	
write_repeated_plus:
	JSR	get_src_byte1
	TAX
	JSR	get_src_byte1
	CLC
@loop1	
	STA	PPU_DATA
	ADC	#1
	DEX
	BNE	@loop1
	BEQ	unrle_plus
; --------------------------------------
	
write_repeated:
	JSR	get_src_byte1
	TAX
	BEQ	end_unpack_plus
	JSR	get_src_byte1
fill_zeros:
@loop2	
	STA	PPU_DATA
	DEX
	BNE	@loop2
	BEQ	unrle_plus
; --------------------------------------

get_src_byte1:
	LDA	(src),Y
	INY
	BNE	@no_inc_h
	INC	src+1
@no_inc_h
end_unpack_plus:
	RTS
; --------------------------------------

	IF	(TEST_SPR=1)
j_draw_sonic:
		LDX	#$1C
		JSR	set_prg_banks
		JSR	get_sonic_sprites_pos
		JSR	draw_sonic_sprites
		LDX	#$14
		JMP	set_prg_banks
	ENDIF


		.PAD	$FF80,$FF
ring_byte_base:	.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2,	 3,   3,   3,	3,   3,	  3,   3,   3
bitfield:
ring_bit_mask:	.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80,	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80,	 1,   2,   4,	8, $10,	$20, $40, $80
rings_bit_mask:	.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F, $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F, $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F

; nintendo header
		.PAD	$FFE0,$FF ; name
		.BYTE	'SONIC THE HEDGEH'
		.pad	$FFF0,$20
prg_summ:	.WORD	$0000	; prg checksum
		.WORD	$0000	; chr checksum
		.BYTE	$F7	; 512+256
		.BYTE	$84	; MMC3
		.BYTE	$01	; title in ASCII
		.BYTE	$0F	; title length
		.BYTE	$00	; unl
		.BYTE	$100-($F7+$84+$01+$0F)&$FF	; header checksum
; vectors
		.PAD	$FFFA,$FF
		.WORD	NMI
		.WORD	RESET
		.WORD	IRQ