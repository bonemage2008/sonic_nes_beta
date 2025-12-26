		org	$8000

version_sprites:
		.BYTE	$65,$7A ; V_
		.BYTE	$6A,$70 ; 06
		.BYTE	$6A,$71 ; 07
		.BYTE	$6C,$6F ; 25

; konami-code
cheat_code:
		.byte	BUTTON_UP,BUTTON_UP,BUTTON_DOWN,BUTTON_DOWN
		.byte	BUTTON_LEFT,BUTTON_RIGHT,BUTTON_LEFT,BUTTON_RIGHT,BUTTON_B,BUTTON_A


; =============== S U B	R O U T	I N E =======================================


screen_off:
		LDA	#0
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		RTS


; =============== S U B	R O U T	I N E =======================================

; A=palette num
; X=chr banks set

unfade_menu:
		STA	palette_num
		JSR	setup_chr_banks
		LDA	#0
		STA	ppu_tilemap_mask
		JSR	enable_nmi_88
		JSR	wait_next_frame
		JMP	PALETTE_UNFADE_FULL


; =============== S U B	R O U T	I N E =======================================


menu_pos	equ	$A
menu_act	equ	$B
menu_sfx	equ	$C

cheat_pos	equ	$D
cheat_flag	equ	$E
title_mode	equ	$F
wait_timer	equ	$10

title_screen:
		LDX	#<title_map
		LDY	#>title_map
		LDA	#$20
		JSR	unpack_tilemap
		LDX	#<title_map
		LDY	#>title_map
		LDA	#$24
		JSR	unpack_tilemap
		JSR	title_bkg_anim_load
		JSR	hide_all_sprites
		JSR	title_sprites
		;LDA	#$48
		;STA	irq_val_unused
		LDA	#0
		STA	menu_pos
		STA	cheat_pos
		STA	cheat_flag
		STA	title_mode
		LDA	#$20
		STA	music_to_play
		LDA	#1
		STA	irq_func_num
		
		IF	(VRC7=1)
		LDA	#2
		STA	vrc7_irq_mode
		LDA	#132
		STA	VRC7_IRQ_latch
		ENDIF
		
		CLI
		STA	sonic_x_on_scr
		LDA	#$12
		STA	demo_timer1

		LDA	#8
		LDX	#6
		JSR	unfade_menu

title_screen_loop:
		JSR	wait_next_frame
		AND	#$1F
		BNE	loc_980AA
		LDA	title_mode
		BNE	loc_980AA
		DEC	demo_timer1
		BNE	loc_980AA
		LDA	#1
		STA	demo_func_id
		INC	demo_stage_num
		LDA	demo_stage_num
		AND	#3
		JMP	title_stage_start ; JMP
; ---------------------------------------------------------------------------

loc_980AA:
		LDX	#0
;		LDA	title_mode
;		BNE	loc_980B4
		LDA	Frame_Cnt
		AND	#$20
		BNE	loc_980B4
		INX

loc_980B4:
		STX	ppu_tilemap_mask
		
		LDA	title_mode
		BEQ	@no_cursor
		
		LDA	joy1_press
		AND	#BUTTON_SELECT|BUTTON_UP|BUTTON_DOWN
		BEQ	@no_change
		LDA	menu_pos
		EOR	#1
		STA	menu_pos
@no_change
		LDX	menu_pos
		LDY	title_cursor_Y,X
		STY	sprites_Y
		STY	sprites_Y+8
		INY
		STY	sprites_Y+4
		
@no_cursor
		LDA	joy1_press
		BEQ	title_screen_loop

		AND	#BUTTON_START
		BNE	title_pressed_start1

		LDA	cheat_flag
		ORA	title_mode
		BNE	loc_980F6
		LDA	joy1_press
		BEQ	loc_980F6
		LDX	cheat_pos
		CMP	cheat_code,X
		BNE	loc_980F1
		INC	cheat_pos
		LDA	cheat_pos
		
		IF	(TEST_MODE=1)
		CMP	#1
		ELSE
		CMP	#10
		ENDIF
		
		BCC	loc_980F6
		LDA	#0
		STA	cheat_pos
		LDA	#$80
		STA	cheat_flag
		LDA	#2
		STA	sfx_to_play
		JMP	cheat_menu
		;BNE	loc_980F6

loc_980F1:
		INC	cheat_flag

loc_980F6:
		LDA	#0
		STA	joy1_press
		JMP	title_screen_loop
; ---------------------------------------------------------------------------

title_pressed_start1:
		LDA	title_mode
		BNE	title_pressed_start2

		;LDA	#$FF
		;STA	final_boss_vram_func
		DEC	final_boss_vram_func ; $FF
		INC	title_mode
		JMP	title_screen_loop

title_pressed_start2:
		LDA	menu_pos
		BNE	cheat_menu
title_stage_start:
		TAY	; stage
		LDA	#0
		STA	menu_act
		JMP	stage_start
; ---------------------------------------------------------------------------

cheat_menu:
		JSR	PALETTE_FADE_FULL
		LDA	#0
		STA	music_to_play
		STA	sfx_to_play
		STA	menu_pos
		JSR	wait_next_frame
		
		IF	(VRC7=0)
		STA	MMC3_IRQ_disable
		ELSE
		LDA	#0
		STA	VRC7_IRQ_control
		ENDIF
		
		JSR	screen_off
		LDA	#$FF
		STA	irq_func_num
		
		BIT	cheat_flag
		BPL	@is_options
		LDX	#<cheat_menu_map
		LDY	#>cheat_menu_map
		LDA	#$20
		JSR	unpack_tilemap
		JMP	@is_cheat_menu
		
@is_options:
		LDX	#<options_menu_map
		LDY	#>options_menu_map
		JSR	unpack_file
@is_cheat_menu:
		JSR	j_sound_update
		LDA	#0
		TAX
@clr_ram_page_300
		STA	$300,X
		INX
		BNE	@clr_ram_page_300
		JSR	reset_update_flags
		JSR	hide_all_sprites
		
		BIT	cheat_flag
		BPL	@is_options_spr
		JSR	cheat_menu_sprites
@is_options_spr
		LDX	#30 ; options
		LDA	#11 ; options pal
		BIT	cheat_flag
		BPL	@is_options_menu
		LDX	#12 ; cheat
		LDA	#9  ; cheats pal
@is_options_menu
		JSR	unfade_menu

@waita
		LDA	vram_buffer_adr_h
		BNE	@waita
		STA	demo_func_id	; demo clear
		
		BIT	cheat_flag
		BPL	options_menu_loop
		JMP	cheat_menu_loop
		
options_menu_loop:
		JSR	wait_next_frame
		
		;LDA	Frame_Cnt
		AND	#3
		BNE	@skip_anim
		
		LDA	sonic_anim_num
		CLC
		ADC	#1
		AND	#7
		STA	sonic_anim_num
		ADC	#$C0
		STA	chr_bkg_bank1
@skip_anim
		LDA	joy1_press
		AND	#BUTTON_START
		BNE	options_exit

		LDA	joy1_press
		AND	#BUTTON_UP
		BEQ	@no_dec_menu_num
		DEC	menu_pos
		BPL	@set_update_attr
		LDA	#2
		STA	menu_pos
		BNE	@set_update_attr
		
@no_dec_menu_num
		LDA	joy1_press
		AND	#BUTTON_DOWN
		BEQ	@no_inc_menu_num
		LDX	menu_pos
		INX
		CPX	#3
		BNE	@next
		LDX	#0
@next		
		STX	menu_pos
@set_update_attr:
		LDA	#$80
		STA	final_boss_vram_func
		
@no_inc_menu_num

		LDA	joy1_press
		LDX	menu_pos
		BEQ	@chk_swap_duty
		DEX
		BEQ	@chk_change_snd
		TAX
		JSR	sfx_test_select
		JMP	@options_menu_next
		
@chk_swap_duty
		AND	#BUTTON_LEFT|BUTTON_RIGHT|BUTTON_B|BUTTON_A
		BEQ	@options_menu_next
		LDA	var_Channels
		EOR	#$40
		STA	var_Channels
		JMP	@options_menu_next
		
@chk_change_snd:
		AND	#BUTTON_LEFT|BUTTON_RIGHT|BUTTON_B|BUTTON_A
		BEQ	@options_menu_next
		JSR	options_change_epsm
		;JMP	@options_menu_next

@options_menu_next
		JSR	options_menu_sprites
		JMP	options_menu_loop
		
options_exit:
		JSR	PALETTE_FADE_FULL
		JSR	screen_off
		LDA	#0
		STA	sfx_to_play
		JMP	title_screen


; =============== S U B	R O U T	I N E =======================================


cheat_menu_loop:
		JSR	wait_next_frame
	
		JSR	cheat_menu_sprites
	
		LDY	menu_pos
	
		LDA	joy1_press
		TAX
		AND	#BUTTON_START
		BEQ	not_start
		;LDY	menu_pos
		CPY	#8
		;BEQ	not_stage
		BEQ	start_special2
stage_start:	
		STY	level_id
		LDA	menu_act
		CPY	#FINAL_ZONE
		BCC	write_act
		BNE	not_final_zone
		LDA	#0
		BEQ	write_act ; JMP
not_final_zone:
		LDA	emeralds_cnt
		CMP	#7
		BCC	not_new_special
start_special2:
		LDA	#7
		STA	level_id

		LDA	#$40
		STA	special_flag
		;LDA	#1
		;STA	special_or_std_lvl
		LDA	#0	; act1
		
not_new_special:
		INC	special_or_std_lvl
		AND	#7	; 8 acts
write_act:
		STA	act_id
		
		IF	(SBZ2_DISABLE>1)
		CMP	#1
		BNE	@not_sbz2
		CPY	#SCRAP_BRAIN
		BNE	@not_sbz2
		LDA	#4
		STA	sfx_to_play
		JMP	cheat_menu_loop
		
@not_sbz2
		ENDIF
		
		LDA	menu_pos
		CMP	#8
		BNE	@no_super_em
		LDA	#7
		STA	emeralds_cnt
@no_super_em

		JSR	replay_init

		LDA	#0
		STA	music_to_play
		STA	sfx_to_play
		JSR	wait_next_frame
		JSR	PALETTE_FADE_FULL
		JSR	wait_next_frame
		LDA	#$FF
		STA	irq_func_num
		RTS

not_stage:
not_start:
		CPY	#7	; 7 and 8 = special stages
		BCC	not_special_stages_test
		TXA
		AND	#BUTTON_LEFT
		BEQ	@no_l
		LDA	emeralds_cnt-7,Y
		SBC	#1
		JMP	@write_em_cnt
@no_l		
		TXA
		AND	#BUTTON_RIGHT
		BEQ	@no_r
		LDA	emeralds_cnt-7,Y
		ADC	#0
@write_em_cnt
		AND	#7
		STA	emeralds_cnt-7,Y	
@no_r

;		TXA
;		AND	#BUTTON_SELECT
;		BEQ	not_select
		
		;JSR	options_change_epsm
		
;		IF	(TEST_MODE=1)
;		LDA	emeralds_cnt
;		CMP	#7
;		BCC	@super_emeralds
;		LDA	super_em_cnt
;		CMP	#7
;		BCS	not_select
;		INC	super_em_cnt
;		BCC	@cmp_with_max
;		
;@super_emeralds:
;		INC	emeralds_cnt
;@cmp_with_max:
;		CMP	#6
;		BNE	@not_last_emerald
;		LDA	#$3F
;		STA	music_to_play
;@not_last_emerald
;		LDA	#2
;		STA	sfx_to_play
;		ENDIF

;not_select	
;		CPY	#8
;		BNE	not_sound_test

;		TXA
;		AND	#BUTTON_START
;		BEQ	@not_start
;		LDA	var_Channels
;		EOR	#$40
;		STA	var_Channels
;@not_start	
;	
;		JSR	sfx_test_select	
;	
;not_sound_test:

not_special_stages_test:
	;LDY	menu_pos
	CPY	#6
	BCS	not_pressed_right
	
	TXA
	AND	#BUTTON_LEFT
	BEQ	not_pressed_left
	DEC	menu_act
	BPL	not_pressed_left
	LDA	#2
	STA	menu_act
	
not_pressed_left
	
	TXA
	AND	#BUTTON_RIGHT
	BEQ	not_pressed_right
	LDY	menu_act
	INY
	CPY	#3
	BNE	@ok
	LDY	#0
@ok	
	STY	menu_act
	
not_pressed_right
	
	TXA
	AND	#BUTTON_DOWN
	BEQ	not_pressed_down
	JSR	clear_attr
	LDY	menu_pos
	INY
	CPY	#9
	BNE	@ok1
	LDY	#0
@ok1	
	STY	menu_pos
	JMP	cheat_menu_loop
	
not_pressed_down:
	TXA
	AND	#BUTTON_UP
	BEQ	not_pressed_up
	JSR	clear_attr
	DEC	menu_pos
	BPL	@ok
	LDA	#8
	STA	menu_pos
@ok	
	JMP	cheat_menu_loop


not_pressed_up:
	SEC
	JSR	draw_attr
	JMP	cheat_menu_loop
	
clear_attr:
	CLC
	
draw_attr:
	LDX	menu_pos
	LDY	attr_l,X
	LDA	#>cheat_menu_attr
	BCC	draw
	LDA	menu_pos
	ASL
	ASL
	ASL
	;CLC
	;ADC	#<alt_attr_low
	TAY
	LDA	#>cheat_menu_attr
	;ADC	#>alt_attr_low

draw:
	STY	tmp_var_25 ; low ptr
	STA	tmp_var_26 ; high ptr
	LDY	#7
copy:
	LDA	(tmp_var_25),Y
	STA	palette_buff,Y
	DEY
	BPL	copy

	LDX	menu_pos	; get pos X
	LDA	#$23
	STA	vram_buffer_adr_h
	LDA	attr_l,X
	STA	vram_buffer_adr_l
	LDA	#1
	STA	vram_buffer_v_length
	LDA	#8
	STA	vram_buffer_h_length
	LDA	#0
	STA	vram_buffer_ppu_mode
	RTS


attr_l:	;.BYTE	$c8,$d0,$d0,$d8,$d8,$e0,$e8,$e8,$f0

	.BYTE	$c8,$d0,$d0,$d8,$d8,$e0,$e0,$e8,$e8 ; v2


cheat_menu_sprites:
	LDA	#$58
	STA	tmp_var_26
	LDX	#64-8
	LDY	#7
@loop	
	LDA	#$d7
	STA	sprites_Y+25*4,X
	LDA	version_sprites,Y
	STA	sprites_tile+25*4,X
	LDA	#0
	STA	sprites_attr+25*4,X
	LDA	tmp_var_26
	SEC
	SBC	#8
	STA	tmp_var_26
	STA	sprites_X+25*4,X
	DEX
	DEX
	DEX
	DEX
	DEY
	BPL	@loop
	
	JSR	draw_special_num
	
	LDA	#6
	STA	tmp_var_26
	LDY	#71
	
@repeat:
	LDX	#11
@copy_s:	
	LDA	sprites_for_123,X
	STA	sprites_Y+8,Y
	DEY
	DEX
	BPL	@copy_s
	DEC	tmp_var_26
	BNE	@repeat
	
	LDY	#0
	LDX	#$2F

@adjust_y:
	TXA
	STA	sprites_Y+8,Y
	STA	sprites_Y+12,Y
	STA	sprites_Y+16,Y
	CLC
	ADC	#$10
	TAX
	TYA
	ADC	#12
	TAY
	CPY	#12*6
	BNE	@adjust_y
	
	LDX	menu_pos	; stage
	CPX	#6
	BCS	@skip	
	LDA	menu_act
	ASL
	ASL
	ADC	tbl_mult12,X
	TAX
	LDA	#1	; attr
	STA	sprites_attr+8,X
@skip
	RTS


draw_special_num:
	LDX	#0
	
	LDA	#167
	STA	sprites_Y,X
	STA	sprites_Y+248,X
	LDA	#183
	STA	sprites_Y+4,X
	STA	sprites_Y+252,X

	LDA	emeralds_cnt
	CLC
	ADC	#$6B
	STA	sprites_tile,X
	
	LDA	super_em_cnt
	CLC
	ADC	#$6B
	STA	sprites_tile+4,X
	
	LDA	#$6A
	STA	sprites_tile+248,X
	STA	sprites_tile+252,X
	
	LDA	#144
	STA	sprites_X,X
	STA	sprites_X+4,X
	LDA	#144-8
	STA	sprites_X+248,X
	STA	sprites_X+252,X
	
	LDY	menu_pos
	
	LDA	#0
	CPY	#7
	BNE	@not_spec1
	LDA	#1
@not_spec1
	STA	sprites_attr,X
	STA	sprites_attr+248,X
	
	CPY	#8
	LDA	#0
	ADC	#0
	STA	sprites_attr+4,X
	STA	sprites_attr+252,X
	RTS
	
tbl_mult12:
	.BYTE	0,12,24,36,48,60
	
sprites_for_123:
	.BYTE	$2F,$6B,$00,$90
	.BYTE	$2F,$6C,$00,$A8
	.BYTE	$2F,$6D,$00,$C0


; =============== S U B	R O U T	I N E =======================================


sfx_test_select:
		TXA
		AND	#BUTTON_LEFT
		BEQ	@not_pressed_left_sfx
		LDA	menu_sfx
		SEC
		SBC	#1
		JMP	@write_sfx_num
	
@not_pressed_left_sfx:
		TXA
		AND	#BUTTON_RIGHT
		BEQ	@not_pressed_right_sfx
		LDA	menu_sfx
		CLC
		ADC	#1
@write_sfx_num:	
		AND	#$3F
		STA	menu_sfx
	
@not_pressed_right_sfx
		TXA
		AND	#BUTTON_B|BUTTON_A
		BEQ	@ret
		LDA	menu_sfx
		CMP	#$20
		BCS	@is_music
		STA	sfx_to_play
		RTS
	
@is_music
		STA	music_to_play
	
@ret:
		RTS


; =============== S U B	R O U T	I N E =======================================


options_change_epsm:
		IF	(VRC7=0)
		LDA	#$80
		STA	MMC3_prg_ram_pr
		LDA	#$34
		STA	$63FF
		CMP	$63FF
		BNE	@no_prg_ram
		LDA	epsm_flag
		EOR	#$80
		STA	epsm_flag
		JSR	set_bank_fms
		JSR	famistudio_music_stop
		;JSR	famistudio_update
		LDA	#$80
		STA	famistudio_song_speed
		ENDIF
@no_prg_ram
		RTS


; =============== S U B	R O U T	I N E =======================================


options_menu_sprites:
		LDX	#4
		LDY	#0
		BIT	var_Channels
		BVC	@duty_swap_spr
		LDY	#12
		
@duty_swap_spr
		LDA	spr_tiles_off,Y
		INY
		STA	sprites_Y,X
		INX
		CPX	#16
		BNE	@duty_swap_spr
		
		LDY	#0
		BIT	epsm_flag
		BPL	@snd_chip_spr
		LDY	#16
		
@snd_chip_spr
		LDA	spr_tiles_2a03,Y
		INY
		STA	sprites_Y,X
		INX
		CPX	#32
		BNE	@snd_chip_spr
		
		LDA	menu_sfx
		LSR
		LSR
		LSR
		LSR
		TAY
		LDA	nums_tls,Y
		STA	sprites_tile,X
	
		LDA	menu_sfx
		AND	#$F
		TAY
		LDA	nums_tls,Y
		STA	sprites_tile+4,X
		
		LDA	#183
		STA	sprites_Y,X
		STA	sprites_Y+4,X
		
		LDA	#0
		STA	sprites_attr,X
		STA	sprites_attr+4,X
		
		LDA	#116
		STA	sprites_X,X
		LDA	#116+8
		STA	sprites_X+4,X

		RTS
		
nums_tls:
		.BYTE	$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23 ; 0-9
		.BYTE	$00,$01,$02,$03,$04,$05 ; A-F
		
		
spr_tiles_off:
		;.BYTE	$0E,$05,$05 ; OFF
		.BYTE	55,$0E,$00,112
		.BYTE	55,$05,$00,112+8
		.BYTE	55,$05,$00,112+16
		
spt_tile_on:
		;.BYTE	$0E,$0D,$FF ; ON
		.BYTE	55,$0E,$00,116
		.BYTE	55,$0D,$00,116+8
		.BYTE	55,$FF,$00,116+16
		
		
spr_tiles_2a03:
		.BYTE	119,$1C,$00,104
		.BYTE	119,$00,$00,104+8
		.BYTE	119,$1A,$00,104+16
		.BYTE	119,$1D,$00,104+24
		
spr_tiles_ymf:
		.BYTE	119,$04,$00,104
		.BYTE	119,$0F,$00,104+8
		.BYTE	119,$12,$00,104+16
		.BYTE	119,$0C,$00,104+24


; =============== S U B	R O U T	I N E =======================================


options_update_attrs:
		JSR	set_nt_attr_addr
		LDX	menu_pos
		LDY	mult_56,X
		LDX	#56/4
@loop		
		LDA	options_attribs,Y
		INY
		STA	PPU_DATA
		LDA	options_attribs,Y
		INY
		STA	PPU_DATA
		LDA	options_attribs,Y
		INY
		STA	PPU_DATA
		LDA	options_attribs,Y
		INY
		STA	PPU_DATA
		DEX
		BNE	@loop
		STX	final_boss_vram_func ; done
		RTS

mult_56:
		.BYTE	0,56,56*2


; =============== S U B	R O U T	I N E =======================================


unpack_tilemap:
		STX	temp_ptr_l
		STY	temp_ptr_l+1
		LDY	#0
		STY	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		STY	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STA	PPU_ADDRESS	; VRAM Address Register	#2 (W2)
		STY	PPU_ADDRESS	; VRAM Address Register	#2 (W2)
		JMP	UNRLE


; =============== S U B	R O U T	I N E =======================================


;hide_all_sprites:
;		LDY	#0
;		LDA	#$F8
;
;loc_98382:
;		STA	sprites_Y,Y
;		INY
;		INY
;		INY
;		INY
;		BNE	loc_98382
;		RTS
; End of function hide_all_sprites


; =============== S U B	R O U T	I N E =======================================


replay_init:
		LDA	#$64
		STA	demo_ptr1+1
		;LDA	#$61
		;STA	demo_ptr2+1
		LDX	#0
		STX	joy1_hold_demo
		LDA	#REPLAY_WRITE
		STA	demo_record_flag
		BNE	@is_replay_write
		LDA	#1
		;STA	demo_func_id
		STA	demo_cnt1
		;STA	demo_cnt2
		LDX	#$FE
		
@is_replay_write
		STX	demo_ptr1
		;STX	demo_ptr2
		RTS


; =============== S U B	R O U T	I N E =======================================


level_opening_screen:
		JSR	wait_next_frame
		JSR	screen_off
		JSR	fill_nametables_with_FFs
		
		JSR	level_opening_vram
		JSR	hide_all_sprites
		JSR	level_opening_spr_init
		LDA	#2
		STA	irq_func_num
		LDA	#240
		STA	hscroll_val
		STA	irq_x_scroll
		LDA	#0
		STA	menu_func_num
		STA	ppu_tilemap_mask
		LDX	#18
		JSR	setup_chr_banks
		LDX	level_id
		LDA	music_by_level,X
		BIT	special_flag
		BVC	@no_new_special
		LDA	#$36
@no_new_special	
		STA	music_to_play

		JSR	enable_nmi_88

next_frame:
		JSR	wait_next_frame
		JSR	level_opening_funcs
		JSR	hide_all_sprites
		LDA	#0
		STA	sprite_id	; index	to sprites buffer
		JSR	pro_sprites_lopen1
		JSR	pro_sprites_lopen2
		JSR	pro_sprites_lopen3
		LDA	menu_func_num
		CMP	#5
		BCC	next_frame
		LDA	#0
		STA	irq_func_num	; level_irq
		;LDA	#0
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STA	ppu_ctrl2_val
		RTS
; End of function level_opening_screen
; ---------------------------------------------------------------------------

level_opening_funcs:
		LDA	menu_func_num
		JSR	jump_by_jmptable
; ---------------------------------------------------------------------------
		.WORD menu_change_1st_scroll
		.WORD menu_change_2nd_scroll
		.WORD sub_98476
		.WORD score_screen_wait
		.WORD score_screen_scroll_out

; =============== S U B	R O U T	I N E =======================================


menu_change_1st_scroll:
		LDA	hscroll_val
		SEC
		SBC	#$10
		STA	hscroll_val
		BCS	loc_98446
		LDA	#0
		STA	hscroll_val

loc_98446:
		LDA	byte_606
		SEC
		SBC	#$10
		STA	byte_606
		BCS	loc_98454
		DEC	byte_607

loc_98454:
		LDA	byte_607
		BNE	locret_98462
		LDA	byte_606
		CMP	#$B0
		BCS	locret_98462
		INC	menu_func_num

locret_98462:
		RTS
; End of function menu_change_1st_scroll


; =============== S U B	R O U T	I N E =======================================


menu_change_2nd_scroll:
		LDA	irq_x_scroll
		SEC
		SBC	#$10
		STA	irq_x_scroll
		BCS	locret_98475
		LDA	#0
		STA	irq_x_scroll
		INC	menu_func_num

locret_98475:
		RTS
; End of function menu_change_2nd_scroll


; =============== S U B	R O U T	I N E =======================================


sub_98476:
		LDA	byte_60A
		SEC
		SBC	#$10
		STA	byte_60A
		BCS	loc_98484
		DEC	byte_60B

loc_98484:
		LDA	byte_60B
		BNE	loc_98497
		LDA	byte_60A
		CMP	#$B0
		BCS	loc_98497
		INC	menu_func_num
		LDA	#1
		STA	wait_timer	; score	screen wait timer

loc_98497:
		LDA	byte_60A
		CLC
		ADC	#$20
		STA	byte_60E
		LDA	byte_60B
		ADC	#0
		STA	byte_60F
		RTS
; End of function sub_98476


; =============== S U B	R O U T	I N E =======================================


score_screen_wait:
		LDA	frame_cnt_for_1sec
		BNE	locret_984B5
		DEC	wait_timer	; score	screen wait timer
		BPL	locret_984B5
		INC	menu_func_num

locret_984B5:
		RTS
; End of function score_screen_wait


; =============== S U B	R O U T	I N E =======================================


score_screen_scroll_out:
		LDA	irq_x_scroll
		CLC
		ADC	#$10
		STA	irq_x_scroll
		BCC	loc_984C6
		LDA	#$F0
		STA	irq_x_scroll

loc_984C6:
		LDA	hscroll_val
		CLC
		ADC	#$10
		STA	hscroll_val
		BCC	loc_984D3
		LDA	#$F0
		STA	hscroll_val

loc_984D3:
		LDA	byte_606
		CLC
		ADC	#$10
		STA	byte_606
		LDA	byte_607
		ADC	#0
		STA	byte_607
		LDA	byte_60A
		CLC
		ADC	#$10
		STA	byte_60A
		LDA	byte_60B
		ADC	#0
		STA	byte_60B
		LDA	byte_60A
		CLC
		ADC	#$20
		STA	byte_60E
		LDA	byte_60B
		ADC	#0
		STA	byte_60F
		LDA	#$F0
		CMP	hscroll_val
		BNE	locret_9852A
		CMP	irq_x_scroll
		BNE	locret_9852A
		LDA	#1
		CMP	byte_607
		BNE	locret_9852A
		CMP	byte_60B
		BNE	locret_9852A
		INC	menu_func_num
		LDA	#$F8
		STA	byte_60C
		STA	byte_608
		STA	byte_610

locret_9852A:
		RTS
; End of function score_screen_scroll_out


; =============== S U B	R O U T	I N E =======================================


level_opening_vram:
		LDA	level_id
		ASL	A
		TAY
		JSR	print_text_line1
		
		LDY	#$18 ; zone_str
		LDA	level_id
		CMP	#SPEC_STAGE
		BNE	@not_special
		LDY	#$1A ; stage_str
@not_special:
		JSR	print_text_line2
		LDY	#32	; level_opening_pal
		JSR	load_menu_pal
		JSR	set_nt_attr_addr
		LDX	#64
		LDA	#0

@clr_attr:
		STA	PPU_DATA
		DEX
		BNE	@clr_attr
		RTS
; End of function level_opening_vram

; =============== S U B	R O U T	I N E =======================================


set_nt_attr_addr:
		LDA	#$23
		STA	PPU_ADDRESS
		LDA	#$C0
		STA	PPU_ADDRESS
		RTS

; =============== S U B	R O U T	I N E =======================================


print_text_line1:
		JSR	get_menu_text_ptr
		LDA	#$20
		LDX	#$C4
		JSR	write_22_bytes_to_vram
		LDA	#$20
		LDX	#$E4
		JMP	write_22_bytes_to_vram

print_text_line2:
		JSR	get_menu_text_ptr
		LDA	#$21
		LDX	#$24
		JSR	write_22_bytes_to_vram
		LDA	#$21
		LDX	#$44
		JSR	write_22_bytes_to_vram


; =============== S U B	R O U T	I N E =======================================


level_opening_spr_init:
		LDX	#11
@loop		
		LDA	byte_98627,X
		STA	byte_606,X
		DEX
		BPL	@loop
		RTS
; End of function level_opening_spr_init
; ---------------------------------------------------------------------------
byte_98627:	.BYTE $B0
byte_98628:	.BYTE 1
byte_98629:	.BYTE $20
byte_9862A:	.BYTE 0
byte_9862B:	.BYTE $B0
byte_9862C:	.BYTE 1
byte_9862D:	.BYTE $60
byte_9862E:	.BYTE 0
byte_9862F:	.BYTE $D0
byte_98630:	.BYTE 1
byte_98631:	.BYTE $50
byte_98632:	.BYTE 0

; =============== S U B	R O U T	I N E =======================================


pro_sprites_lopen3:
		LDA	byte_606
		STA	spr_tmp_x_l
		LDA	byte_607
		STA	spr_tmp_x_h
		LDA	byte_608
		STA	spr_tmp_y_l
		LDA	byte_609
		STA	spr_tmp_y_h
		LDA	#7
		STA	spr_parts_count_X
		LDA	#8
		STA	spr_parts_count_Y

		LDA	#<opening_spr_tls
		LDY	#>opening_spr_tls
		JMP	pro_sprites_level_opening
; End of function pro_sprites_lopen3


; =============== S U B	R O U T	I N E =======================================


pro_sprites_lopen1:
		LDA	level_id
		CMP	#FINAL_ZONE
		BCC	loc_9867A
		RTS
; ---------------------------------------------------------------------------

loc_9867A:
		LDA	byte_60A
		STA	spr_tmp_x_l
		LDA	byte_60B
		STA	spr_tmp_x_h
		LDA	byte_60C
		STA	spr_tmp_y_l
		LDA	byte_60D
		STA	spr_tmp_y_h
		LDA	#3
		STA	spr_parts_count_X
		LDA	#1
		STA	spr_parts_count_Y

		LDA	#<opening_spr_tls2
		LDY	#>opening_spr_tls2
		JMP	pro_sprites_level_opening
; End of function pro_sprites_lopen1


; =============== S U B	R O U T	I N E =======================================


pro_sprites_lopen2:
		LDA	level_id
		CMP	#FINAL_ZONE
		BCC	loc_986C1
		RTS
; ---------------------------------------------------------------------------

loc_986C1:
		LDA	byte_60E
		STA	spr_tmp_x_l
		LDA	byte_60F
		STA	spr_tmp_x_h
		LDA	byte_610
		STA	spr_tmp_y_l
		LDA	byte_611
		STA	spr_tmp_y_h
		LDA	#2
		STA	spr_parts_count_X
		LDA	#3
		STA	spr_parts_count_Y
		
		LDX	act_id
		LDA	opening_sprd_ptrs_l,X
		LDY	opening_sprd_ptrs_h,X
		JMP	pro_sprites_level_opening
; End of function pro_sprites_lopen2


; =============== S U B	R O U T	I N E =======================================


title_bkg_anim_load:
		LDA	#7
		STA	tmp_var_28
		LDX	#0
		LDY	#$24
		LDA	#$91

@next_raw:
		STY	PPU_ADDRESS
		STA	PPU_ADDRESS
		CLC
		ADC	#$20
		BCC	@no_inc_h
		INY
@no_inc_h:
		PHA
		LDA	#5
		STA	tmp_var_25

@copy:
		LDA	title_anim_map,X
		STA	PPU_DATA
		INX
		DEC	tmp_var_25
		BNE	@copy
		PLA
		DEC	tmp_var_28
		BNE	@next_raw
		RTS
; End of function title_bkg_load

; ---------------------------------------------------------------------------
title_anim_map:	.BYTE $2B, $99, $2D, $2E, $9A
		.BYTE $3B, $B6, $B7, $B8, $B9
		.BYTE $4B, $C6, $4D, $C8, $C9
		.BYTE $D5, $D6, $D7, $D8, $D9
		.BYTE $E5, $E6, $E7, $E8, $E9
		.BYTE $F5, $F6, $F7, $F8, $F9
		.BYTE $8B, $BD, $BE, $BF, $8F
;		.BYTE $9B, $9C, $9D, $9E, $9F


; =============== S U B	R O U T	I N E =======================================

; game start and options texts
title_bkg_anim_load2:
		STX	final_boss_vram_func ; done
		STX	tmp_var_25
		LDA	#<title_anim2
		LDY	#>title_anim2
		JSR	@load_data_to_nt1
		LDA	#4
		STA	tmp_var_25 ; 2nd nt
@load_data_to_nt1:
		LDX	#0
@l2:
		LDA	title_anim2,X
		BEQ	@done
		ORA	tmp_var_25 ; nt mask
		STA	PPU_ADDRESS
		INX
		LDA	title_anim2,X
		STA	PPU_ADDRESS
		INX
		;LDY	title_anim2,X
		;INX
		LDY	#8
@l1:
		LDA	title_anim2,X
		STA	PPU_DATA
		INX
		LDA	title_anim2,X
		STA	PPU_DATA
		INX
		DEY
		BNE	@l1
		BEQ	@l2
@done:
		RTS

title_anim2:
		.byte $22
		.byte $c8
		;.byte 16
		.byte $e8,$ea,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$7b,$7c,$7d,$a5,$e8,$e9
		.byte $22
		.byte $e8
		;.byte 16
		.byte $fa,$fb,$fa,$fb,$fa,$fb,$fa,$fb,$fa,$fb,$fa,$fb,$f8,$f9,$f8,$f9
		.byte $23
		.byte $08
		;.byte 16
		.byte $ec,$ed,$ec,$ed,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$ec,$ed,$ec,$ed
		.byte 00


; =============== S U B	R O U T	I N E =======================================


pro_sprites_level_opening:
		STA	spr_cfg_tile_ptr
		STY	spr_cfg_tile_ptr_h
		
		LDA	spr_tmp_x_l
		LDX	#0
		BEQ	loc_987FA

loc_987F3:
		CLC
		ADC	#8
		BCC	loc_987FA
		INC	spr_tmp_x_h

loc_987FA:
		LDY	spr_tmp_x_h
		BEQ	loc_98804
		LDY	#$FF
		STY	tmp_x_positions,X
		BMI	loc_98806

loc_98804:
		STA	tmp_x_positions,X

loc_98806:
		INX
		CPX	spr_parts_count_X
		BCC	loc_987F3
		LDA	spr_tmp_y_l
		LDX	#0
		BEQ	loc_98818

loc_98811:
		CLC
		ADC	#8
		BCC	loc_98818
		INC	spr_tmp_y_h

loc_98818:
		LDY	spr_tmp_y_h
		BEQ	loc_98822
		LDY	#$FF
		STY	tmp_y_positions,X
		BMI	loc_98824

loc_98822:
		STA	tmp_y_positions,X

loc_98824:
		INX
		CPX	spr_parts_count_Y
		BCC	loc_98811
		LDA	#0
		STA	spr_parts_counter
		STA	spr_parts_counter2
		STA	spr_cfg_off
		TAX

loc_98832:
		LDA	tmp_y_positions,X
		CMP	#$FF
		BNE	loc_98842
		LDA	spr_cfg_off
		CLC
		ADC	spr_parts_count_X
		STA	spr_cfg_off
		JMP	loc_98881
; ---------------------------------------------------------------------------

loc_98842:
		STA	tmp_var_2B
		LDA	#0
		STA	spr_parts_counter
		TAX

loc_98849:
		LDA	tmp_x_positions,X
		CMP	#$FF
		BEQ	loc_98877
		STA	tmp_var_28
		LDA	sprite_id	; index	to sprites buffer
		ASL	A
		ASL	A
		TAX
		LDY	spr_cfg_off
		LDA	(spr_cfg_tile_ptr),Y
		CMP	#$FF
		BEQ	loc_98877
		;TAY
		;ORA	tmp_tile_mask
		STA	sprites_tile,X
		;LDA	(spr_cfg_attr_ptr),Y ; temp var
		;ORA	tmp_attr_mask
		LDA	#$22
		STA	sprites_attr,X
		LDA	tmp_var_28
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INC	sprite_id	; index	to sprites buffer

loc_98877:
		INC	spr_cfg_off
		INC	spr_parts_counter
		LDX	spr_parts_counter
		CPX	spr_parts_count_X
		BCC	loc_98849

loc_98881:
		INC	spr_parts_counter2
		LDX	spr_parts_counter2
		CPX	spr_parts_count_Y
		BCC	loc_98832
		RTS
; End of function pro_sprites_level_opening


; =============== S U B	R O U T	I N E =======================================


title_sprites:
		LDX	#0
@load_title_spr:
		LDA	title_oam_dat,X
		STA	sprites_Y,X
		INX
		CPX	#title_oam_end-title_oam_dat
		BNE	@load_title_spr
		STX	sprite_id
		RTS
; End of function title_sprites

; ---------------------------------------------------------------------------
title_cursor_Y:
		.BYTE	175,191

title_oam_dat:
		.byte	$F0,$09,$01,$3C ; title cursor tile1
		.byte	$F0,$0A,$02,$3C+8 ; title cursor tile2
		.byte	$F0,$09,$41,$3C+16 ; title cursor tile3
		incbin	menu\title_oam.bin
title_oam_end:


opening_sprd_ptrs_l:
		.BYTE #<opening_spr_tls_act1
		.BYTE #<opening_spr_tls_act2
		.BYTE #<opening_spr_tls_act3
opening_sprd_ptrs_h:
		.BYTE #>opening_spr_tls_act1
		.BYTE #>opening_spr_tls_act2
		.BYTE #>opening_spr_tls_act3
		
opening_spr_tls:.BYTE  $FF, $FF, $42, $43, $44,	$45, $FF, $FF, $51, $52, $67, $67, $67,	$47, $60, $61
		.BYTE  $67, $67, $67, $67, $57,	$46, $67, $67, $67, $67, $67, $67, $56,	$67, $67, $67
		.BYTE  $67, $67, $48, $66, $67,	$67, $67, $67, $67, $58, $41, $40, $67,	$67, $67, $62
		.BYTE  $FF, $FF, $50, $63, $64,	$65, $FF, $FF
		
opening_spr_tls2:.BYTE	$53, $54, $55

opening_spr_tls_act1:.BYTE  $49, $FF, $59, $FF,	$69, $FF

opening_spr_tls_act2:.BYTE  $4A, $4B, $5A, $5B,	$6A, $6B

opening_spr_tls_act3:.BYTE  $4C, $4D, $5C, $5D,	$6C, $6D


; =============== S U B	R O U T	I N E =======================================


get_menu_text_ptr:
		LDA	menu_text_ptrs,Y
		STA	tmp_ptr_l
		LDA	menu_text_ptrs+1,Y
		STA	tmp_ptr_l+1
		LDY	#0
		RTS
; ---------------------------------------------------------------------------
act_win_str1_id:.BYTE  $14  ; sonic has 
		.BYTE  $10  ; special
		.BYTE  $1C  ; sonic got
		
act_win_str2_id:.BYTE  $16  ; passed
		.BYTE  $12  ; stage
		.BYTE  $1E  ; them all
; ---------------------------------------------------------------------------
		
menu_text_ptrs:	.WORD green_hill_str	; 00
		.WORD marble_str	; 02
		.WORD spring_str	; 04
		.WORD labyrinth_str	; 06
		.WORD star_light_str	; 08
		.WORD scrapbrain_str	; 0A
		.WORD final_str		; 0C
		.WORD special_str	; 0E special (start)
		.WORD special_str_win	; 10 special (win)
		.WORD stage_str		; 12
		.WORD sonic_has_str	; 14
		.WORD passed_str	; 16
		.WORD zone_str		; 18
		.WORD stage_str		; 1A special stage (start)
		.WORD sonic_got_str	; 1C
		.WORD them_all_str	; 1E
	
sonic_got_str:  .BYTE  $24,$25,$06,$08,$22,$23,$09,$06,$07,$FF,$FF,$06,$07,$06,$08,$26,$27,$FF,$FF,$FF,$FF,$FF ; SONIC GOT
		.BYTE  $34,$35,$16,$18,$32,$33,$1D,$16,$0A,$FF,$FF,$16,$17,$16,$18,$36,$37,$FF,$FF,$FF,$FF,$FF ; SONIC GOT
		
them_all_str:	.BYTE  $FF,$FF,$FF,$FF,$FF,$FF,$ff,$26,$27,$0b,$0c,$02,$03,$20,$21,$ff,$00,$01,$09,$ff,$09,$ff ; THEM ALL
		.BYTE  $FF,$FF,$FF,$FF,$FF,$FF,$ff,$36,$37,$1b,$1c,$12,$13,$30,$31,$ff,$10,$11,$19,$1a,$19,$1a ; THEM ALL

green_hill_str: .BYTE  $FF,$FF,$06,$07,$02,$04,$02,$03,$02,$03,$22,$23,$FF,$FF,$0B,$0C,$09,$09,$FF,$09,$FF,$FF ; GREEN HILL
		.BYTE  $FF,$FF,$16,$17,$1B,$05,$12,$13,$12,$13,$32,$33,$FF,$FF,$1B,$1C,$1D,$19,$1A,$19,$1A,$FF ; GREEN HILL
		
marble_str:     .BYTE  $FF, $FF,$FF,$FF,$FF,$FF,$20,$21,$00,$01,$02,$04,$02,$04,$09,$FF,$02,$03,$FF,$FF,$FF,$FF ; MARBLE
		.BYTE  $FF, $FF,$FF,$FF,$FF,$FF,$30,$31,$10,$11,$1B,$05,$12,$15,$19,$1A,$12,$13,$FF,$FF,$FF,$FF ; MARBLE
		
spring_str:	.BYTE  $24, $25,   2,	4,   2,	  4,   9, $22, $23,   6
		.BYTE	 7, $FF, $FF, $FF, $2A,	$2B,   0,   1,	 2,   4
		.BYTE  $28,   8, $34, $35, $1B,	$14, $1B,   5, $1D, $32
		.BYTE  $33, $16, $17, $FF, $FF,	$FF, $3A, $3B, $10, $11
		.BYTE  $1B,   5, $19, $18
		
labyrinth_str:	.BYTE  $FF, $FF,   9, $FF,   0,	  1,   2,   4, $2A, $2B
		.BYTE	 2,   4,   9, $22, $23,	$26, $27,  $B,	$C, $FF
		.BYTE  $FF, $FF, $FF, $FF, $19,	$1A, $10, $11, $12, $15
		.BYTE  $3A, $3B, $1B,	5, $1D,	$32, $33, $36, $37, $1B
		.BYTE  $1C, $FF, $FF, $FF
		
star_light_str:	.BYTE  $FF, $FF, $24, $25, $26,	$27,   0,   1,	 2,   4
		.BYTE  $FF, $FF,   9, $FF,   9,	  6,   7,  $B,	$C, $26
		.BYTE  $27, $FF, $FF, $FF, $34,	$35, $36, $37, $10, $11
		.BYTE  $1B,   5, $FF, $FF, $19,	$1A, $1D, $16, $17, $1B
		.BYTE  $1C, $36, $37, $FF
		
scrapbrain_str:	.BYTE  $24, $25,   6,	7,   2,	  4,   0,   1,	 2,   4
		.BYTE  $FF, $FF,   2,	4,   2,	  4,   0,   1,	 9, $22
		.BYTE  $23, $FF, $34, $35, $16,	 $A, $1B,   5, $10, $11
		.BYTE  $1B, $14, $FF, $FF, $12,	$15, $1B,   5, $10, $11
		.BYTE  $1D, $32, $33, $FF
		
final_str:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	 2,   3
		.BYTE	 9, $22, $23,	0,   1,	  9, $FF, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF
		.BYTE  $1B,  $D, $1D, $32, $33,	$10, $11, $19, $1A, $FF
		.BYTE  $FF, $FF, $FF, $FF
		
special_str:
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$24, $25,   2,	 4,   2
		.BYTE	 3,   6,   7,	9,   0,	  1,   9, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $34, $35, $1B
		.BYTE  $14, $12, $13, $16,  $A,	$1D, $10, $11, $19, $1A
		.BYTE  $FF, $FF, $FF, $FF

zone_str:	.BYTE  $FF, $FF, $FF, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $2C, $2D,	 6,   8
		.BYTE  $22, $23,   2,	3, $FF,	$FF, $FF, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $3C, $3D
		.BYTE  $16, $18, $32, $33, $12,	$13, $FF, $FF
		
special_str_win:
		.BYTE  $FF, $FF, $FF, $24, $25,	  2,   4,   2,	 3,   6
		.BYTE	 7,   9,   0,	1,   9,	$FF, $FF, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$34, $35, $1B, $14, $12
		.BYTE  $13, $16,  $A, $1D, $10,	$11, $19, $1A, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF
		
stage_str:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $24, $25
		.BYTE  $26, $27,   0,	1,   6,	  7,   2,   3, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF
		.BYTE  $34, $35, $36, $37, $10,	$11, $16, $17, $12, $13
		.BYTE  $FF, $FF, $FF, $FF
		
sonic_has_str:  .BYTE  $24,$25,$06,$08,$22,$23,$09,$06,$07,$FF,$FF,$0B,$0C,$00,$01,$24,$25,$FF,$FF,$FF,$FF,$FF ; SONIC HAS
		.BYTE  $34,$35,$16,$18,$32,$33,$1D,$16,$0A,$FF,$FF,$1B,$1C,$10,$11,$34,$35,$FF,$FF,$FF,$FF,$FF ; SONIC HAS
		
passed_str:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $78, $79, $7A, $7B
		.BYTE  $24, $25, $24, $25,   2,	  3, $28,   8, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $7C, $7D
		.BYTE  $7E, $7F, $34, $35, $34,	$35, $12, $13, $19, $18
		.BYTE  $FF, $FF, $FF, $FF
		
		
;blank_str:     .BYTE  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 
;		.BYTE  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;
		
		
title_map:	incbin	menu\title.rle

cheat_menu_map:	;incbin	menu\cheat_menu.rle
		incbin	menu\cheat_menu_v2.rle

level_win_map:	incbin	menu\level_win.rle


unpack_file:
		STX	$1A
		STY	$1B
		
		LDX	#$1B
		JSR	set_prg_A000
		
		LDA	#$20
		STA	PPU_ADDRESS
		LDA	#0
		STA	PPU_ADDRESS
		;LDA	#0
		STA	$1C
		LDA	#2
		STA	$1D
		JSR	unpack
		LDX	#0
@l1
		LDA	$200,X
		STA	PPU_DATA
		INX
		BNE	@l1
@l2
		LDA	$300,X
		STA	PPU_DATA
		INX
		BNE	@l2
@l3
		LDA	$400,X
		STA	PPU_DATA
		INX
		BNE	@l3
@l4
		LDA	$500,X
		STA	PPU_DATA
		INX
		BNE	@l4
		;RTS
		
		LDX	#$19
		
set_prg_A000:
		IF	(VRC7=0)
		LDA	#$87
		STA	MMC3_bank_select
		STX	MMC3_bank_data
		ELSE
		STX	VRC7_prg_A000
		ENDIF
		STX	prg2_id
		RTS

;AP_Unpack:
;		include	menu\unpack.asm


options_menu_map:
		incbin	menu\options.apck


; =============== S U B	R O U T	I N E =======================================


level_win_screen:
		LDA	ppu_ctrl1_val
		AND	#$7F
		STA	PPU_CTRL_REG1
@wait_vbl
		BIT	PPU_STATUS
		BPL	@wait_vbl
		
		IF	(VRC7=0)
		STA	MMC3_IRQ_disable
		ELSE
		LDA	#0
		STA	VRC7_IRQ_control
		ENDIF
		
		JSR	level_win_check_special
		JSR	screen_off
		STA	checkpoint_x_h
		STA	pause_flag
		STA	ppu_tilemap_mask
		LDX	#$FF
		STX	tilemap_adr_h   ; updated
		STX	tilemap_adr_h_v ; updated
		JSR	fill_nametables_with_FFs
		LDX	#<level_win_map
		LDY	#>level_win_map
		LDA	#$20
		JSR	unpack_tilemap
		JSR	level_win_bkg_load
		JSR	hide_all_sprites
		JSR	level_opening_spr_init
		LDA	#2
		STA	irq_func_num
		LDA	#$F0
		STA	hscroll_val
		STA	irq_x_scroll
		LDA	#0
		STA	vscroll_val
		STA	menu_func_num
		JSR	print_continues
		LDX	#18
		JSR	setup_chr_banks
		JSR	draw_chaos_emeralds

		JSR	enable_nmi_88

loc_99281:
		JSR	wait_next_frame
		JSR	level_win_funcs
		JSR	hide_all_sprites
		LDA	#0
		STA	sprite_id	; index	to sprites buffer
		JSR	pro_sprites_lopen1 ; ; 'ACT' sprite
		JSR	pro_sprites_lopen2 ; act #  SPRITE
		;JSR	pro_sprites_lopen3 ; ; sphere sprite
		JSR	chaos_emeralds_sprite
		LDA	menu_func_num
		CMP	#6
		BCC	loc_99281
		JSR	set_next_level
		LDA	#0
		STA	irq_func_num
		;LDA	#0
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STA	ppu_ctrl2_val
		RTS
; End of function level_win_screen


; =============== S U B	R O U T	I N E =======================================


level_win_check_special:
		LDA	special_flag	; blue spheres
		BNE	@clear_blue_spheres_flag
		LDA	special_or_std_lvl
		BNE	@win_sms_special ; sms - no bonus

		STA	special_stage_flag ; clear
;		LDA	act_id
;		CMP	#2
;		BEQ	@act3
		BIT	big_ring_flag
		BPL	@lower
		INC	special_stage_flag
;		JMP	@done
;@act3		
;		LDA	rings_100s
;		STA	special_stage_flag	; special_flag 0/1
;		BNE	@done
;		LDA	rings_10s
;		CMP	#5
;		BCC	@lower
;		STA	special_stage_flag
;@done:
		LDA	emeralds_cnt
		CMP	#7
		BNE	@lower
		;LDY	special_or_std_lvl	; current special stage
		;BNE	@lower
		EOR	super_em_cnt
		BEQ	@clear_sms_flag
	
		;LDA	super_em_cnt
		;CMP	#7
		;BEQ	@lower
		;LDA	act_id
		;CMP	#2
		;BEQ	@lower
		LDA	#$40 	; set new special flag
		STA	special_flag
@lower:	
		RTS
	
@clear_sms_flag:
		STA	special_stage_flag
	
@clear_blue_spheres_flag:
		LDA	#0
		STA	special_flag
		RTS
		
@win_sms_special:
		LDA	#9
		STA	timer_m ; no time bonus
		RTS


; =============== S U B	R O U T	I N E =======================================


print_continues:
		LDX	#$FF

loc_9B942:
		INX
		LDY	byte_9B973,X
		BEQ	loc_9B954
		BPL	loc_9B94F
		STY	PPU_DATA
		BNE	loc_9B942

loc_9B94F:
		STY	PPU_ADDRESS
		BNE	loc_9B942

loc_9B954:
		LDA	continues
		AND	#$7F

loc_9B958:
		CMP	#$A
		BCC	loc_9B961
		SBC	#$A
		INY
		BNE	loc_9B958

loc_9B961:
		PHA
		TYA
		BNE	loc_9B967
		LDA	#$65

loc_9B967:
		ADC	#$9A
		STA	PPU_DATA
		PLA
		ADC	#$9A
		STA	PPU_DATA
		RTS
; End of function sub_9B940

; ---------------------------------------------------------------------------
byte_9B973:	.BYTE $23
		.BYTE $26
		.BYTE $82
		.BYTE $8E
		.BYTE $8D
		.BYTE $93
		.BYTE $88
		.BYTE $8D
		.BYTE $A4
		.BYTE $A7
		.BYTE $A8
		.BYTE $23
		.BYTE $D
		.BYTE $AE
		.BYTE $B0
		.BYTE $23
		.BYTE $4C
		.BYTE $AB
		.BYTE $AC
		.BYTE $AD
		.BYTE $23
		.BYTE $38
		.BYTE 0	


; =============== S U B	R O U T	I N E =======================================


fast_score_flag		equ	$A
time_bonus_100s		equ	$B
time_bonus_10s		equ	$C
time_bonus_1s		equ	$D
time_bonus_00s		equ	$E
time_bonus_0s		equ	$F


level_win_funcs:
		LDA	menu_func_num
		JSR	jump_by_jmptable
; End of function level_win_funcs

; ---------------------------------------------------------------------------
		.WORD menu_change_1st_scroll
		.WORD menu_change_2nd_scroll
		.WORD sub_98476
		.WORD sub_992C2
		.WORD score_screen_wait
		.WORD score_screen_scroll_out

; =============== S U B	R O U T	I N E =======================================


sub_992C2:
		JSR	dec_rings_cnt
		JSR	score_to_buff
		LDA	rings_100s
		ORA	rings_10s
		ORA	rings_1s
		ORA	time_bonus_100s	; time bns 100s
		ORA	time_bonus_10s	; time bns 10s
		ORA	time_bonus_1s	; time bns 1s
		BNE	locret_992FC
		INC	menu_func_num
		LDA	#3
		STA	wait_timer
		LDA	continues
		BPL	@no_em
		AND	#$7F
		STA	continues
		LDA	#$35		; continue sfx
		STA	music_to_play
		INC	wait_timer	; score	screen wait timer
@no_em
locret_992FC:
		RTS
; End of function sub_992C2


; =============== S U B	R O U T	I N E =======================================


level_win_bkg_load:
		LDX	special_or_std_lvl
		LDY	act_win_str1_id,X
		JSR	print_text_line1
		LDX	special_or_std_lvl
		LDY	act_win_str2_id,X
		JSR	print_text_line2
		LDY	#64	; level_win_pal
		JSR	load_menu_pal
		JSR	init_time_bonus_value
		JSR	score_to_buff
		JMP	vram_updates_from_buff
; End of function level_win_bkg_load


; =============== S U B	R O U T	I N E =======================================


write_22_bytes_to_vram:
		STA	PPU_ADDRESS
		STX	PPU_ADDRESS

		LDX	#22

@l:
		LDA	(tmp_ptr_l),Y
		STA	PPU_DATA
		INY
		DEX
		BNE	@l
		RTS


; =============== S U B	R O U T	I N E =======================================


init_time_bonus_value:
		LDA	#0
		STA	fast_score_flag
		STA	time_bonus_100s
		;STA	time_bonus_10s
		STA	time_bonus_1s
		STA	time_bonus_00s
		STA	time_bonus_0s
		LDY	timer_m	; minutes
		BMI	bonus_50k
		BNE	loc_993CB
		LDA	#5	; 5000 bns (<1 min)
		BNE	write_1000s

loc_993CB:
		LDA	timer_10s
		CMP	#3
		DEY
		BNE	loc_993DD
		LDY	#4	; 4000
		BCC	loc_993D9
		DEY	; LDY #3
loc_993D9:
		STY	time_bonus_10s ; 4000/3000 bns
		RTS
	
loc_993DD:
		DEY
		BNE	no_time_bonus
		BCS	no_time_bonus
		LDA	#2	; 2000 bns
		BNE	write_1000s

bonus_50k:
		LDA	#5	; 50000 bns
		STA	time_bonus_100s
	
no_time_bonus:
		LDA	#0
write_1000s:	
		STA	time_bonus_10s
		RTS
; End of function init_time_bonus_value


; =============== S U B	R O U T	I N E =======================================


dec_rings_cnt:
		LDA	fast_score_flag
		BNE	@fast_score
		LDA	joy1_hold
		AND	#BUTTON_A|BUTTON_B|BUTTON_SELECT|BUTTON_START
		BEQ	@dec_rings_cnt_
		INC	fast_score_flag
@fast_score
		JSR	@dec_rings_cnt_
		JSR	@dec_rings_cnt_
		JSR	@dec_rings_cnt_

@dec_rings_cnt_:
		JSR	@dec_time_bns
		DEC	rings_1s
		BPL	@add_score
		LDA	#9
		STA	rings_1s
		DEC	rings_10s
		BPL	@add_score
		LDA	#9
		STA	rings_10s
		DEC	rings_100s
		BPL	@add_score
		LDA	#0
		STA	rings_100s
		STA	rings_10s
		STA	rings_1s
		RTS
; ---------------------------------------------------------------------------

@dec_time_bns:
		DEC	time_bonus_1s
		BPL	@add_score
		LDA	#9
		STA	time_bonus_1s
		DEC	time_bonus_10s
		BPL	@add_score
		LDA	#9
		STA	time_bonus_10s
		DEC	time_bonus_100s
		BPL	@add_score
		LDA	#0
		STA	time_bonus_100s
		STA	time_bonus_10s
		STA	time_bonus_1s
		RTS
; ---------------------------------------------------------------------------

@add_score:
		INC	score_l
		LDA	score_l
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score_l
		INC	score____
		LDA	score____
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score____
loc_9944D:	INC	score___
		LDA	score___
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score___
loc_9945C:
		INC	score__
		LDA	score__
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score__
		INC	score_
		LDA	score_
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score_
		INC	score
		LDA	score
		CMP	#$A
		BCC	loc_99489
		LDA	#0
		STA	score

loc_99489:
		LDA	Frame_Cnt
		AND	#3
		BNE	@no_score_sfx
		LDA	#11
		STA	sfx_to_play
@no_score_sfx:
		RTS
; End of function dec_rings_cnt


; =============== S U B	R O U T	I N E =======================================


score_to_buff:
		LDX	#8
		LDY	#0

loc_99492:
		LDA	score,Y
		BNE	loc_994AB
		LDA	#$FF
		STA	palette_buff+1,Y	; also various NT data
		INY
		DEX
		BNE	loc_99492
		LDA	#$9A
		STA	vram_buffer_h_length+1,Y
		JMP	loc_994B5
; ---------------------------------------------------------------------------

loc_994A8:
		LDA	score,Y

loc_994AB:
		CLC
		ADC	#$9A
		STA	palette_buff+1,Y	; also various NT data
		INY
		DEX
		BNE	loc_994A8

loc_994B5:
		LDA	#$72
		STA	palette_buff
; End of function score_to_buff
; =============== S U B	R O U T	I N E =======================================
;rings_to_buff:
		LDY	#0
		STY	timer_m ; fix 00
		STY	timer_10s ; fix 0
		LDA	#$FF

loc_994D3:				; also various NT data
		STA	palette_buff+11,Y
		INY
		CPY	#3
		BCC	loc_994D3
		LDX	#0

loc_994DD:
		LDA	rings_100s,X
		BNE	loc_994F8
		LDA	#$FF
		STA	palette_buff+11,Y	; also various NT data
		INY
		INX
		CPX	#5
		BCC	loc_994DD
		LDA	#$9A
		STA	vram_buffer_h_length+11,Y
		JMP	loc_99504
; ---------------------------------------------------------------------------

loc_994F5:
		LDA	rings_100s,X

loc_994F8:
		CLC
		ADC	#$9A
		STA	palette_buff+11,Y	; also various NT data
		INY
		INX
		CPX	#5
		BCC	loc_994F5

loc_99504:
		LDA	#$B2
		STA	palette_buff+10
; End of function rings_to_buff
; =============== S U B	R O U T	I N E =======================================
;time_bonus_to_buff:
		LDY	#0
		LDA	#$FF

loc_99522:				; also various NT data
		STA	palette_buff+21,Y
		INY
		CPY	#3
		BCC	loc_99522
		LDX	#0

loc_9952C:				; time bonus value
		LDA	time_bonus_100s,X
		BNE	loc_99547
		LDA	#$FF
		STA	palette_buff+21,Y	; also various NT data
		INY
		INX
		CPX	#5
		BCC	loc_9952C
		LDA	#$9A
		STA	vram_buffer_h_length+21,Y
		JMP	loc_99553
; ---------------------------------------------------------------------------

loc_99544:				; time bonus value
		LDA	time_bonus_100s,X

loc_99547:
		CLC
		ADC	#$9A
		STA	palette_buff+21,Y	; also various NT data
		INY
		INX
		CPX	#5
		BCC	loc_99544

loc_99553:
		LDA	#$F2
		STA	palette_buff+20
		
		LDA	#$83
		STA	vram_buffer_adr_h
		RTS
; End of function time_bonus_to_buff


; =============== S U B	R O U T	I N E =======================================


set_next_level:
		LDA	special_or_std_lvl
		BNE	clr_special_stage
;		LDA	act_id
;		CMP	#2
;		BEQ	@skip_if_act3
		LDA	special_stage_flag ; flag - enable special after level win
		BNE	next_with_special

;@skip_if_act3:
;		LDA	#0
inc_to_next_level:
		STA	special_or_std_lvl
@skip_act2
		INC	act_id
		LDA	act_id
		
		IF	(SBZ2_DISABLE=1)
		CMP	#1
		BNE	@not_sbz2
		LDY	level_id
		CPY	#SCRAP_BRAIN
		BEQ	@skip_act2
		
@not_sbz2
		ENDIF
	
		CMP	#3
		BCC	locret_995BE
		LDA	#0
		STA	act_id
		INC	level_id

locret_995BE:
		RTS
; ---------------------------------------------------------------------------

next_with_special:
		LDA	#0
		STA	special_stage_flag ; flag - enable special after level win
		LDA	#1
		JSR	inc_to_next_level

		LDA	act_id
		STA	act_id_sav
		LDA	level_id
		STA	level_id_sav
		LDA	#SPEC_STAGE
		STA	level_id
		LDA	emeralds_cnt
		AND	#7
		STA	act_id ; 8 acts
		RTS
; ---------------------------------------------------------------------------

clr_special_stage:
		LDA	#0
		STA	special_or_std_lvl
		STA	special_stage_flag ; flag - enable special after level win
		LDA	level_id_sav
		STA	level_id
		LDA	act_id_sav
		STA	act_id
		;LDA	#0
		;STA	act_id_sav
		;STA	level_id_sav
		RTS
; End of function set_next_level


; =============== S U B	R O U T	I N E =======================================


ending_screen:
		JSR	wait_vbl
		JSR	screen_off
		STA	ppu_ctrl2_val
		STA	hscroll_val
		STA	vscroll_val
		STA	music_to_play
		JMP	good_ending
; ---------------------------------------------------------------------------

bad_ending:
		LDX	#$FF
		STX	irq_func_num
		LDY	#0	; ending pal
		JSR	load_menu_pal
		LDA	#$00
		JSR	fill_nametable1_with_value
		LDA	#<try_again_data
		LDY	#>try_again_data
		JSR	load_data_to_vram	; try again
		LDA	#0
		STA	ppu_tilemap_mask
		STA	boss_var_D1
		STA	boss_anim_num
		STA	boss_sub_func_id
		JSR	pro_ending_spr2	; emeralds
		JSR	pro_ending_spr1	; eggman
		JSR	setup_chr_banks_ending
		LDA	#$30
		STA	music_to_play
		;LDA	#$80
		;STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		;STA	ppu_ctrl1_val
		JSR	wait_vbl
		LDA	#$1E
		STA	ppu_ctrl2_val

bad_ending_loop:
		JSR	wait_next_frame
		JSR	hide_all_sprites
		JSR	ending_funcs
		LDA	var_Channels
		AND	#$20
		BNE	bad_ending_loop
		LDA	joy1_press
		BNE	@j_reset
		JMP	bad_ending_loop
@j_reset:
		JMP	RESET
; End of function ending_screen


; =============== S U B	R O U T	I N E =======================================


load_menu_pal:
		JSR	wait_vbl
		LDA	#$3F
		STA	PPU_ADDRESS	; VRAM Address Register	#2 (W2)
		LDX	#0
		STX	PPU_ADDRESS	; VRAM Address Register	#2 (W2)
		LDX	#32
		
@load_pal:
		LDA	ending_palette,Y
		STA	PPU_DATA	; VRAM I/O Register (RW)
		INY
		DEX
		BNE	@load_pal
		RTS
; End of function load_menu_pal


; =============== S U B	R O U T	I N E =======================================


ending_funcs:
		LDA	boss_sub_func_id
		JSR	jump_by_jmptable
; End of function ending_funcs

; ---------------------------------------------------------------------------
end_f_ptrs:	.WORD ending_func_00
		.WORD ending_func_01
		.WORD ending_func_00
		.WORD ending_func_03

; =============== S U B	R O U T	I N E =======================================


ending_func_00:
		LDA	boss_sub_func_id
		AND	#3
		STA	boss_anim_num
		LDA	Frame_Cnt
		LDY	emeralds_cnt
		AND	emeralds_roll_speed,Y
		BNE	loc_996C4
		INC	boss_var_D1
		LDA	#2
		STA	sfx_to_play

loc_996C4:
		LDA	boss_var_D1
		CMP	#9
		BCC	loc_996D0
		INC	boss_sub_func_id
		LDA	#$28
		STA	level_finish_func_cnt

loc_996D0:				; eggman
		JSR	pro_ending_spr1
		JMP	pro_ending_spr2	; emeralds
; End of function ending_func_00


; =============== S U B	R O U T	I N E =======================================


ending_func_01:
		DEC	level_finish_func_cnt
		BNE	loc_996E0
		INC	boss_sub_func_id
		LDA	#0
		STA	boss_var_D1

loc_996E0:
		LDA	#1
		STA	boss_anim_num
		JSR	pro_ending_spr1	; eggman
		JMP	pro_ending_spr2	; emeralds
; End of function ending_func_01


; =============== S U B	R O U T	I N E =======================================


ending_func_03:
		DEC	level_finish_func_cnt
		BNE	loc_996F4
		LDA	#0
		STA	boss_sub_func_id
		STA	boss_var_D1

loc_996F4:
		LDA	#3
		STA	boss_anim_num
		JSR	pro_ending_spr1	; eggman
		JMP	pro_ending_spr2
; End of function ending_func_03


; =============== S U B	R O U T	I N E =======================================

; emeralds

pro_ending_spr2:
		;rts
		LDY	boss_var_D1
		STY	boss_var_dd
		LDA	emeralds_by_frame,Y
		STA	boss_var_dc
		LDA	#5
		SEC	
		SBC	emeralds_by_frame,Y
		CLC
		ADC	boss_var_dd
		STA	boss_var_dd
		;LDA	#0
		;STA	spr_cfg_off
		LDY	emeralds_cnt
		LDA	spr_cfg_by_emeralds,Y
		STA	spr_cfg_off
loc_99706:
		LDA	boss_sub_func_id
		CMP	#2
		BCS	loc_99721
		LDY	boss_var_dd
		LDA	#$68-2
		CLC
		ADC	end_emerld_x,Y
		STA	tmp_x_positions
		LDA	#$4F-1
		CLC
		ADC	end_emerld_y,Y
		STA	tmp_y_positions
		JMP	loc_99733
; ---------------------------------------------------------------------------

loc_99721:
		LDY	boss_var_dd
		LDA	#$68-2
		CLC
		ADC	end_emerld_x2,Y
		STA	tmp_x_positions
		LDA	#$4F-1
		CLC
		ADC	end_emerld_y2,Y
		STA	tmp_y_positions

loc_99733:
		LDA	tmp_x_positions
		CLC
		ADC	#8
		STA	tmp_x_positions+1
		LDA	tmp_y_positions
		CLC
		ADC	#8
		STA	tmp_y_positions+1
;		LDA	#0
;		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_99749:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		STA	tmp_var_2B
		LDY	#0

loc_99752:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	end_emerld_tile_n,Y
		STA	sprites_tile,X
		LDA	end_emerld_attr_n,Y
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_99752
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_99749
		STX	sprite_id	; index	to sprites buffer
		INC	boss_var_dd
		DEC	boss_var_dc
		BEQ	locret_9978D
		JMP	loc_99706
; ---------------------------------------------------------------------------

locret_9978D:
		RTS
; End of function pro_ending_spr2

; ---------------------------------------------------------------------------
;end_emerld_tile:.BYTE  $05, $06, $35, $36
;end_emerld_attr:.BYTE	 2,   2,   2,	2

emeralds_by_frame:
		.BYTE	1,2,3,4,5
		.BYTE	5,4,3,2,1
		
spr_cfg_by_emeralds:
		.BYTE	$00,$04,$04,$08,$0C,$10,$10
emeralds_roll_speed:
		.BYTE	$07,$07,$07,$03,$03,$01,$01
		

end_emerld_x:	.BYTE	 0,   0,   0,	0,   0,	  8, $14, $20, $28, $28
		.BYTE  $28, $28, $28, $28, $28
		
end_emerld_y:	.BYTE  $F8, $F8, $F8, $F8, $F8,	$F0, $EC, $F0, $F8,   8
		.BYTE	 8,   8,   8,	8,   8
		
end_emerld_x2:	.BYTE  $28, $28, $28, $28, $28,	$20, $14,   8,	 0,   0
		.BYTE	 0,   0,   0,	0,   0
		
end_emerld_y2:	.BYTE  $F8, $F8, $F8, $F8, $F8,	$F0, $EC, $F0, $F8,   8
		.BYTE	 8,   8,   8,	8,   8
		
end_emerld_tile_n:
		HEX	05063536 ; blue
		HEX	05063536 ; rose
		HEX	10165354 ; green
		HEX	10165354 ; red
		HEX	05063536 ; purple
		HEX	FFFFFFFF ; unused
		HEX	FFFFFFFF ; unused
		HEX	FFFFFFFF ; unused
		HEX	FFFFFFFF ; unused
		
end_emerld_attr_n:
		HEX	01010101
		HEX	00000000
		HEX	02020202
		HEX	01010101
		HEX	02020202


; =============== S U B	R O U T	I N E =======================================

; eggman

pro_ending_spr1:
		LDX	#0
		LDY	#6
		LDA	#$68
		STA	tmp_x_positions,X

loc_997DA:
		INX
		CLC
		ADC	#8
		STA	tmp_x_positions,X
		DEY
		BNE	loc_997DA
		LDX	#0
		LDY	#7
		LDA	#$4F
		STA	tmp_y_positions,X

loc_997EB:
		INX
		CLC
		ADC	#8
		STA	tmp_y_positions,X
		DEY
		BNE	loc_997EB
		LDY	boss_anim_num
		LDA	ending_spr_offs,Y
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_997FF:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		STA	tmp_var_2B
		LDY	#0

loc_99808:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	ending_spr_tile,Y
		BNE	loc_99823
		LDA	#$F8
		STA	sprites_Y,X
		BMI	loc_99831

loc_99823:
		STA	sprites_tile,X
		LDA	ending_spr_attr,Y
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX

loc_99831:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#6
		BCC	loc_99808
		LDY	spr_parts_counter2
		INY
		CPY	#7
		BCC	loc_997FF
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function pro_ending_spr1

; ---------------------------------------------------------------------------

try_again_data:
		.byte	$22 ; vram h
		.byte	$68 ; vram l
		.byte	16 ; size
		
		.BYTE  $C6, $C7, $C2, $C3
		.BYTE  $E0, $E1,   0, $EC
		.BYTE  $ED, $8C, $8D, $EC
		.BYTE  $ED, $EA, $AB, $AC
		
		.byte	$22 ; vram h
		.byte	$88 ; vram l
		.byte	16 ; size
		
		.BYTE  $D6, $D7, $D2, $D3
		.BYTE  $F0, $F1,   0, $FC
		.BYTE  $FD, $9C, $9D, $FC
		.BYTE  $FD, $FA, $BB, $BC
		
		;.byte	$22 ; vram h
		;.byte	$A9 ; vram l
		;.byte	10 ; size
		
		;.BYTE	 0,   0,   0,	0
		;.BYTE	 0,   0,   0,	0
		;.BYTE	 0,   0
		
		.byte	0 ; end
		
ending_spr_offs:.BYTE	 0
		.BYTE	ending_spr_tile2-ending_spr_tile
		.BYTE	ending_spr_tile3-ending_spr_tile
		.BYTE	ending_spr_tile4-ending_spr_tile

ending_spr_tile:.BYTE  $00, $00,   3,	2, $00,	$00 ; bad ending - eggman frame1
		.BYTE  $15, $14, $13, $12, $11,	$00
		.BYTE  $25, $24, $23, $22, $21,	$20
		.BYTE  $00, $34, $33, $32, $31,	$30
		.BYTE  $00,   4, $00, $00,   1,	$00
		.BYTE  $00,  $F,  $E,  $D,  $C,	$00
		.BYTE  $00, $1F, $1E, $1D, $1C,	$00
		
ending_spr_tile2:
		.BYTE  $00, $00, $00, $00, $00,	$00 ; bad ending - eggman frame2
		.BYTE	$B,  $A,   9,	8,   7,	$00
		.BYTE  $1B, $1A, $19, $18, $17,	$00
		.BYTE  $00, $2A, $29, $28, $27,	$26
		.BYTE  $00, $3A, $00, $00, $37,	$00
		.BYTE  $00, $2F, $2E, $2D, $2C,	$00
		.BYTE  $00, $3F, $3E, $3D, $3C,	$00
		
ending_spr_tile3:
		.BYTE  $00, $00,   2,	3, $00,	$00 ; bad ending - eggman frame3
		.BYTE  $00, $11, $12, $13, $14,	$15
		.BYTE  $20, $21, $22, $23, $24,	$25
		.BYTE  $30, $31, $32, $33, $34,	$00
		.BYTE  $00,   1, $00, $00,   4,	$00
		.BYTE  $00,  $C,  $D,  $E,  $F,	$00
		.BYTE  $00, $1C, $1D, $1E, $1F,	$00
		
ending_spr_tile4:
		.BYTE  $00, $00, $00, $00, $00,	$00 ; bad ending - eggman frame4
		.BYTE  $00,   7,   8,	9,  $A,	 $B
		.BYTE  $00, $17, $18, $19, $1A,	$1B
		.BYTE  $26, $27, $28, $29, $2A,	$00
		.BYTE  $00, $37, $00, $00, $3A,	$00
		.BYTE  $00, $2C, $2D, $2E, $2F,	$00
		.BYTE  $00, $3C, $3D, $3E, $3F,	$00
		
ending_spr_attr:.BYTE  $40, $40, $40, $40, $40,	$40
		.BYTE  $41, $40, $40, $40, $40,	$40
		.BYTE  $40, $43, $43, $43, $43,	$41
		.BYTE  $40, $40, $43, $43, $40,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE  $40, $40, $40, $40, $40,	$40
		.BYTE  $41, $40, $40, $40, $40,	$40
		.BYTE  $41, $43, $43, $43, $43,	$40
		.BYTE  $40, $40, $43, $43, $40,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE  $41, $41, $41, $41, $41,	$41
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  1
		.BYTE	 1,   3,   3,	3,   3,	  0
		.BYTE	 1,   0,   3,	3,   0,	  0
		.BYTE	 1,   1,   1,	1,   1,	  1
		.BYTE	 1,   1,   1,	1,   1,	  1
		.BYTE	 1,   1,   1,	1,   1,	  1
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  1
		.BYTE	 1,   3,   3,	3,   3,	  1
		.BYTE	 1,   0,   3,	3,   0,	  0
		.BYTE	 1,   1,   1,	1,   1,	  1
		.BYTE	 1,   1,   1,	1,   1,	  1
		.BYTE	 1,   1,   1,	1,   1,	  0
		
ending_palette:	.BYTE	$F,   1, $11, $30
		.BYTE	$F,   2, $16, $30
		.BYTE	$F,   2, $16, $30
		.BYTE	$F,   1, $11, $30
		.BYTE	$F,   4, $16, $37
		.BYTE	$F, $11, $16, $30
		.BYTE	$F,   1, $1A, $20
		.BYTE	$F,   4, $16, $28

level_opening_pal:.BYTE	  $F,	0, $10,	$20
		.BYTE	$F,  $F, $18, $38
		.BYTE	$F,   4, $38, $25
		.BYTE	$F,   5, $1A, $24
		.BYTE	$F,  $F, $10, $20
		.BYTE	$F,  $F, $18, $38
		.BYTE	$F,   4, $28, $22
		.BYTE	$F,   5, $1A, $24

level_win_pal:	.BYTE	$F,   5, $16, $25
		.BYTE	$F,   1, $22, $32
		.BYTE	$F,   0, $10, $20
		.BYTE	$F, $14, $24, $34
		.BYTE	$F, $1A, $29, $39
		.BYTE	$F, $18, $28, $38
		.BYTE	$F,   4, $28, $22
		.BYTE   $F,   3, $13, $23
		
;demo_levels:	.BYTE	 0,   1,   2,	3


; =============== S U B	R O U T	I N E =======================================


best_ending2:
		JSR	setup_chr_banks_ending
		LDA	#1
		STA	ppu_tilemap_mask
		LDA	#0
		STA	ending_joy_val	; enable joy ctrl
		STA	PPU_CTRL_REG2 ; disable screen for ppu writes
		JSR	load_ending_map_
		
		LDY	#31
copy_palette:
		LDA	ending_palette,Y
		STA	palette2_ram,Y
		DEY
		BPL	copy_palette
		JSR	hide_all_sprites
		JSR	ending_funcs2

		JSR	screen_unfade_and_show ; best_ending.asm

@ending_loop:
		JSR	wait_next_frame
		
		LDA	boss_sub_func_id
		ORA	level_finish_func_cnt
		BNE	@no_eggman_jump_sfx
		LDA	#$18
		STA	sfx_to_play
@no_eggman_jump_sfx
		
		LDA	joy1_press
		AND	#BUTTON_START
		BNE	j_new_game
		
		JSR	hide_all_sprites
		JSR	ending_funcs2
		JMP	@ending_loop
		
j_new_game:
		JSR	hide_all_sprites
		LDA	#0
		STA	PPU_CTRL_REG2
		STA	PPU_SPR_ADDR
		JSR	fill_nametable1_with_FFs	; clear NT
		JMP	clr_and_go_main	; clear and go main


; =============== S U B	R O U T	I N E =======================================


ending_funcs2:
		LDX	boss_sub_func_id
		DEC	level_finish_func_cnt
		BPL	@no_change_f
		INX
		TXA
		AND	#3
		TAX
		STX	boss_sub_func_id
		LDA	frame_time,X
		STA	level_finish_func_cnt
@no_change_f
		LDA	frame_num,X
		STA	boss_anim_num
		LDA	frame_y_pos,X
		PHA


; =============== S U B	R O U T	I N E =======================================

; eggman

pro_ending_spr1_:
		LDX	#0
		LDY	#6
		LDA	#$68
		STA	tmp_x_positions,X ; temp

@loc_997DA:
		INX
		CLC
		ADC	#8
		STA	tmp_x_positions,X ; temp
		DEY
		BNE	@loc_997DA
		LDX	#0
		LDY	#7
		PLA
		;LDA	#$4F
		STA	tmp_y_positions,X ; temp

@loc_997EB:
		INX
		CLC
		ADC	#8
		STA	tmp_y_positions,X ; temp
		DEY
		BNE	@loc_997EB
		LDY	boss_anim_num	; boss sprite index?
		LDA	ending_spr_pts,Y
		STA	spr_cfg_off
		LDX	sprite_id
		LDY	#0

@loc_997FF:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y ; temp
		STA	tmp_var_2B	; temp
		LDY	#0

@loc_99808:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y ; temp
		STA	sprites_X,X
		LDA	tmp_var_2B	; temp
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	ending_spr_tile_,Y
		BNE	@loc_99823
		LDA	#$F8
		STA	sprites_Y,X
		BMI	@loc_99831

@loc_99823:
		STA	sprites_tile,X
		LDA	ending_spr_attr_,Y
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX

@loc_99831:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#6
		BCC	@loc_99808
		LDY	spr_parts_counter2
		INY
		CPY	#7
		BCC	@loc_997FF
		STX	sprite_id
		RTS
; End of function pro_ending_spr1


; =============== S U B	R O U T	I N E =======================================

; try again (good ending)

load_ending_map_:
		LDA	#<ending2_data
		LDY	#>ending2_data
		;JMP	load_data_to_vram
		
load_data_to_vram:
		STA	tmp_var_25
		STY	tmp_var_26
		LDY	#0
@l2:
		LDA	(tmp_var_25),Y
		BEQ	@done
		INY
		STA	PPU_ADDRESS
		LDA	(tmp_var_25),Y
		INY
		STA	PPU_ADDRESS
		LDA	(tmp_var_25),Y
		INY
		TAX
@l1:
		LDA	(tmp_var_25),Y
		INY
		STA	PPU_DATA
		DEX
		BNE	@l1
		BEQ	@l2
@done:
		RTS
; End of function load_ending_map

; ---------------------------------------------------------------------------

;Text,$(END)
ending2_data:
 .byte $26 ; vram h
 .byte $2C ; vram l
 .byte 8 ; size

.byte $00,$88,$89,$ab,$ac,$86,$87,$00

 .byte $26 ; vram h
 .byte $4C ; vram l
 .byte 8 ; size

.byte $6b,$98,$99,$bb,$bc,$96,$97,$6e

 .byte $26 ; vram h
 .byte $6C ; vram l
 .byte 8 ; size

.byte $7b,$7c,$5c,$5d,$5e,$5f,$7d,$7e

 .byte 0 ; end

ending_spr_pts:	.BYTE	 0, $2A, $54, $7E
 
ending_spr_tile_:
.byte $00,$00,$00,$00,$00,$00 ;Eggman, Frame 1 (sec 10)
.byte $00,$00,$00,$00,$00,$00
.byte $40,$41,$42,$42,$41,$40
.byte $50,$51,$52,$52,$51,$50
.byte $60,$61,$62,$62,$61,$60
.byte $70,$71,$72,$72,$71,$70
.byte $43,$44,$45,$45,$44,$43

.byte $00,$00,$55,$55,$00,$00 ;Eggman, Frame 2, 4 (sec 14, 10)
.byte $63,$64,$65,$65,$64,$63
.byte $73,$74,$75,$75,$74,$73
.byte $00,$49,$78,$78,$49,$00
.byte $00,$59,$5a,$5a,$59,$00
.byte $00,$69,$6a,$6a,$69,$00
.byte $00,$79,$7a,$7a,$79,$00

.byte $00,$00,$00,$00,$00,$00 ;Eggman, Frame 3 (sec 18)
.byte $46,$47,$55,$55,$47,$46
.byte $56,$57,$58,$58,$57,$56
.byte $00,$67,$68,$68,$67,$00
.byte $00,$77,$78,$78,$77,$00
.byte $4a,$4b,$4c,$4c,$4b,$4a
.byte $00,$5b,$00,$00,$5b,$00

ending_spr_attr_:
.byte $00,$00,$00,$40,$40,$40 ;Eggman,$Atributes,$1
.byte $00,$00,$00,$40,$40,$40
.byte $00,$00,$00,$40,$40,$40
.byte $01,$00,$00,$40,$40,$41
.byte $00,$00,$03,$43,$40,$40
.byte $01,$01,$03,$43,$41,$41
.byte $01,$01,$01,$41,$41,$41

.byte $00,$00,$00,$40,$40,$40 ;Eggman,$Atributes,$2
.byte $00,$00,$00,$40,$40,$40
.byte $00,$01,$03,$43,$41,$40
.byte $00,$01,$03,$43,$41,$40
.byte $00,$01,$01,$41,$41,$40
.byte $00,$01,$01,$41,$41,$40
.byte $00,$01,$01,$41,$41,$40

.byte $00,$00,$00,$40,$40,$40 ;Eggman,$Atributes,$3
.byte $00,$01,$00,$40,$41,$40
.byte $00,$00,$00,$40,$40,$40
.byte $00,$00,$03,$43,$40,$40
.byte $01,$01,$03,$43,$41,$41
.byte $01,$01,$01,$41,$41,$41
.byte $00,$01,$01,$41,$41,$40


frame_num:
 .byte  0,  1,  2,  1
frame_time:
 .byte  8,  8,  8,  8
frame_y_pos:
 .BYTE $4F,$4F,$2F,$4F
 
; ---------------------------------------------------------------------------

em_val		equ	tmp_var_25
em_type		equ	tmp_var_26

draw_chaos_emeralds:
		jsr	wait_vbl
		ldx	emeralds_cnt
		beq	no_draw_emeralds
		lda	special_or_std_lvl
		beq	no_draw_emeralds
		
;		jsr	wait_vbl
		
		LDA	#$3b
		STA	chr_bkg_bank4
		
		lda	#$3A
		sta	chr_spr_bank2
		
		lda	#$23
		sta	PPU_ADDRESS
		lda	#$D9
		sta	PPU_ADDRESS
		
		ldy	#0
@copy		
		lda	attr,y
		sta	PPU_DATA
		iny
		cpy	#6
		bne	@copy
		
		;LDA	#6
		;sta	em_val	; BLUE - 1st
		ldy	#0
		jsr	draw_bkg_emerald
		
		CPX	#3
		BCC	no_draw_emeralds
		
		;LDA	#3
		;sta	em_val	; ROSE - 3rd
		ldy	#2
		jsr	draw_bkg_emerald
		
		CPX	#5
		BCC	no_draw_emeralds
		
		;LDA	#0
		;sta	em_val	; RED - 5th
		ldy	#4
		jsr	draw_bkg_emerald
		
		CPX	#6
		BCC	no_draw_emeralds
		
		;LDA	#15
		;sta	em_val	; GRAY - 6th
		ldy	#5
		jsr	draw_bkg_emerald

;		dex

;@loop
;		lda	em_tabl,X
;		sta	em_val
;		jsr	draw_bkg_emerald
;		dex	
;		bpl	@loop
		
no_draw_emeralds:
		jmp	wait_vbl
		
;em_tabl:
;		.byte	$09,$06,$0C,$03,$0F,$00,$12,$12
attr:
		.byte	$00,$ff,$55,$AA,$AA,$AA
table:
		.byte	6,1,3,$00,$00,15,3
		
draw_bkg_emerald
		lda	table,y
		sta	em_val
		
		cpy	super_em_cnt
		ldy	#0
		bcs	@not_new_type
		ldy	#4
@not_new_type
		
		LDA	#$C6
		JSR	set_addr
		
		LDA	em_tile_nums,y
		STA	PPU_DATA
		LDA	em_tile_nums+1,y
		STA	PPU_DATA
		
		LDA	#$E6
		JSR	set_addr
		
		LDA	em_tile_nums+2,y
		STA	PPU_DATA
		LDA	em_tile_nums+3,y
		STA	PPU_DATA
ret_no_special
		rts
		
		
set_addr	
		PHA
		LDA	#$21
		STA	PPU_ADDRESS
		PLA
		CLC
		ADC	em_val
		STA	PPU_ADDRESS
		RTS
		
em_tile_nums:
		.byte	$e0,$e1,$f0,$f1
		.byte	$c9,$ca,$d9,$da
		
		
chaos_emeralds_sprite:
		jsr	pro_sprites_lopen3
		
		lda	special_or_std_lvl
		beq	ret_no_special
		
		lda	#$88
		sta	ppu_ctrl1_val	; spr and bkg from left window
		
		lda	Frame_Cnt
		lsr
		lsr
		lsr
		and	#3
		clc
		adc	#$3b
		sta	chr_bkg_bank4
		
;		LDx	#$3b
;		ldy	#$3A
;		lda	6
;		and	#1
;		beq	write_banks
;		LDx	#$f6
;		LDY	#$f6
;write_banks:
;		STx	chr_bkg_bank4
;		sty	chr_spr_bank2
		
		ldy	emeralds_cnt
		cpy	#2
		BCC	no_special

		;LDA	#1
		;STA	$21
		LDA	#120
		ldx	#1
		jsr	draw_emerald
		
		cpy	#4
		BCC	no_special

		;LDA	#0
		;STA	$21
		LDA	#120+24
		ldx	#3
		jsr	draw_emerald
		
		cpy	#7
		BCC	no_special

		;LDA	#3
		;STA	$21
		LDA	#120+24+48
		ldx	#6
		
draw_emerald
		STA	$22
		lda	table,x
		sta	$21
		lda	#111
		sta	$1F
;get_em_type:
		cpx	super_em_cnt
		ldx	#0
		bcs	@not_new_type
		ldx	#4
@not_new_type
		
		LDA	em_tile_nums,x
		jsr	draw_em_part
		lda	$22
		clc
		adc	#8
		sta	$22	; +x
		LDA	em_tile_nums+1,x
		jsr	draw_em_part
		
		lda	$1f
		clc
		adc	#8
		sta	$1f	; +y
		LDA	em_tile_nums+3,x
		jsr	draw_em_part

		lda	$22
		sec
		sbc	#8
		sta	$22	; -y
		LDA	em_tile_nums+2,x
;		jsr	draw_em_part
		
draw_em_part:
		pha
		stx	$20
		lda	sprite_id
		asl
		asl
		tax
		lda	$1F
		sta	sprites_Y,X
		pla
		sta	sprites_tile,X
		lda	$21
		sta	sprites_attr,X
		lda	$22
		sta	sprites_X,X
		inc	sprite_id
		ldx	$20
no_special:
		rts
; ---------------------------------------------------------------------------


setup_chr_banks_ending:
		LDX	#0
setup_chr_banks:
		LDA	chrs_ending,X
		STA	chr_spr_bank1	; player sprites bank
		LDA	chrs_ending+1,X
		STA	chr_spr_bank2	; enemy	sprites	bank
		LDA	chrs_ending+2,X
		STA	chr_bkg_bank1
		LDA	chrs_ending+3,X
		STA	chr_bkg_bank2
		LDA	chrs_ending+4,X
		STA	chr_bkg_bank3
		LDA	chrs_ending+5,X
		STA	chr_bkg_bank4
		RTS

chrs_ending:
		.BYTE	$F8,$FA,$F8,$F9,$FA,$FB ; ending 0
		
		.BYTE	$C8,$C9,$60,$61,$62,$63 ; title 6
		
		.BYTE	$72,$72,$7C,$7D,$7E,$7F ; cheat 12
		
		.BYTE	$70,$72,$70,$71,$72,$73 ; level opening 18
		
		.BYTE	$70,$72,$70,$71,$72,$C9 ; cont screen 24
		
		.BYTE	$72,$72,$C0,$C0,$C0,$C0	; options 30


		.pad	$9F00
cheat_menu_attr:
		incbin	menu\cheat_menu_attrs_v2.bin
		
		.pad	$9FC0
		incbin	menu\cheat_menu_attrs1_v2.bin


		.pad	$A000,$FF
