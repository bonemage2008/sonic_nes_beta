palette_ram	equ	palette_buff ; 30B
pal_unfade_value equ	fade_index ; 333
;palette2_ram	equ	$381

str_buff_ptr	equ	tmp_var_29
str_buff	equ	palette_buff ; 30B

credits_cnt_tmp	equ	$2B

credits_ptr_l	equ	$E0
credits_ptr_h	equ	$E1
credits_ptr_pos equ	$E2
scene_num	equ	$E3

show_pic_timer	equ	$E0
scene_temp	equ	$E2
pos_y		equ	$E1
pos_x		equ	$E2
fade_index2	equ	$E2


good_ending:
	JSR	init_NT2

	LDA	emeralds_cnt
	CMP	#7
	BCS	good_ending_scenes
	JMP	bad_ending_scenes
good_ending_scenes:
	LDX	#0
	JSR	load_scene_pic
	
	;LDA	#$32
	LDA	#$30
	STA	music_to_play
	
	JSR	screen_unfade_and_show
	LDX	#2
	JSR	wait_X_seconds
	JSR	screen_fagind_and_off
	LDX	#3
	JSR	load_scene_pic
	JSR	screen_unfade_and_show
	
	LDA	palette_buff
	PHA
	LDA	palette_buff+1
	PHA
	
	LDA	#120*2
	STA	show_pic_timer
	
@pic_4_loop:
	LDX	#1
	LDY	#$2E
	LDA	show_pic_timer
	CMP	#121
	BEQ	@chg1
	CMP	#120
	BNE	@no_chg_to_5
	LDX	#$32
	LDY	#$8F
@chg1:
	LDA	#$F8
	STA	sprites_Y+pic_04_spr-pic_01_spr+4
	LDA	#$21
	STA	vram_buffer_adr_h
	STY	vram_buffer_adr_l
	LDA	#2
	STA	vram_buffer_h_length
	LDA	#1
	STA	vram_buffer_v_length
	STX	palette_buff
	INX
	STX	palette_buff+1
	
@no_chg_to_5
	LDX	#0
	LDA	#$70
	LDY	#$68
	STA	pos_x
	LDA	Frame_Cnt
	AND	#4
	BEQ	@pos1
@copy:
	LDA	emerald_shine_cfg,X
	STA	sprites_Y,X
	INX
	CPX	#emerald_shine_cfg_end-emerald_shine_cfg
	BNE	@copy
	BEQ	@done ; JMP
@pos1	
	STY	pos_y
	JSR	draw_1_emerald_pal4
	LDA	#$F8
@hide:	
	STA	sprites_Y,X
	INX
	INX
	INX
	INX
	CPX	#emerald_shine_cfg_end-emerald_shine_cfg
	BNE	@hide

@done:
	LDY	#1
	JSR	_wait_next_frame
	DEC	show_pic_timer
	BNE	@pic_4_loop
	
	PLA
	STA	palette_buff+1
	PLA
	STA	palette_buff
	
	JSR	screen_fagind_and_off
	LDX	#5
	JSR	load_scene_pic
	JSR	screen_unfade_and_show
	
	LDA	#120*2
	STA	show_pic_timer
	
@pic_6_loop:
	LDA	show_pic_timer
	LSR	A
	LSR	A
	LSR	A
	CMP	#8
	BCS	@ok
	LDA	#8 ; min 8
@ok:	
	STA	tmp_var_2B

	LDX	#0
	LDY	#6	; 7 emeralds
	STY	tmp_var_25
	
@draw_emeralds:
	LDA	Frame_Cnt
	CLC
	LDY	tmp_var_25
	ADC	emeralds_pos,Y
	ASL	A
	ASL	A
	STA	tmp_var_26
	
	JSR	get_sine
	LDY	tmp_var_2B
	JSR	_udivide_8_8
	BIT	tmp_var_26
	BPL	@plus
	EOR	#$FF
	CLC
	ADC	#1
@plus
	CLC
	ADC	#$78
	STA	pos_x
	LDA	tmp_var_26
	JSR	get_cosine
	LDY	tmp_var_2B
	JSR	_udivide_8_8
	LDY	tmp_var_26
	CPY	#$C0
	BCS	@neg_y
	CPY	#$40
	BCS	@no_neg
@neg_y:
	EOR	#$FF
	CLC
	ADC	#1
@no_neg:
	CLC
	ADC	#$60
	STA	pos_y
	LDY	tmp_var_25
	LDA	Frame_Cnt
	LSR	A
	LDA	emeralds_attr1,Y
	BCC	@evenf
	LDA	emeralds_attr2,Y
@evenf:
	JSR	draw_1_emerald
	DEC	tmp_var_25
	BPL	@draw_emeralds
	
	LDY	#1
	JSR	_wait_next_frame
	DEC	show_pic_timer
	BNE	@pic_6_loop
	
	; FADE TO WHITE
	LDA	#4
	STA	fade_index2
@pic_6_fade:
	LDY	#1
	JSR	fade_to_white
	LDY	#3
	JSR	start_wait_next_frame ;	input -	A - frames count to wait
	DEC	fade_index2
	BNE	@pic_6_fade
	JSR	ending_scr_off
	
	LDX	#6
	JSR	load_scene_pic
	
	JSR	dislay_show
	LDY	#4
	STY	fade_index2
@pic_7_unfade:
	LDY	fade_index2
	JSR	unfade_from_white
	LDY	#3
	JSR	start_wait_next_frame ;	input -	A - frames count to wait
	DEC	fade_index2
	BPL	@pic_7_unfade
	LDX	#2
	JSR	wait_X_seconds
	JSR	screen_fagind_and_off
	
	;JSR	load_good_ending_new
	;JSR	screen_unfade_and_show
	;JMP	wait_music_end	; best ending pic first show (good ending)
	
	JSR	load_ending_pic
	JSR	load_good_ending_new
	JSR	ending_load_animals
	LDX	#1
	JSR	load_good_sprites
	
	JSR	screen_unfade_and_show
	LDA	#90
	STA	tmp_var_25
	
good_ending_new_anim:
		LDA	Frame_Cnt
@same_frame
		CMP	Frame_Cnt
		BEQ	@same_frame
		LSR	A
		LSR	A
		LSR	A
		AND	#1
		TAX
		INX
		JSR	load_good_sprites
		JSR	j_ending_move_animals
		DEC	tmp_var_25
		BNE	good_ending_new_anim
	
	LDX	#3
	JSR	load_good_sprites
	;LDY	#10
	;JSR	_wait_next_frame

		LDA	#10
		STA	tmp_var_25
@good_wait2
		LDA	Frame_Cnt
@same_frame2
		CMP	Frame_Cnt
		BEQ	@same_frame2
		JSR	j_ending_move_animals
		DEC	tmp_var_25
		BNE	@good_wait2
	
	LDX	#0
	JSR	load_good_sprites
	LDY	#10
	JSR	_wait_next_frame
	;LDX	#2
	;JSR	wait_X_seconds
	JSR	best_ending_banks_and_spr
	LDY	#31
@copy_palette:
	LDA	best_end_pal,Y
	STA	palette_ram,Y
	DEY
	BPL	@copy_palette
	LDA	#0
	STA	ppu_tilemap_mask
	LDA	#1
	JSR	start_wait_next_frame
	
	JMP	wait_music_end	; best ending pic first show (good ending)
	
	
unfade_from_white:
	LDX	#$1F
@reload_pal:
	LDA	palette2_ram,X
	STA	palette_ram,X
	DEX
	BPL	@reload_pal
	TYA
	BEQ	ret_fade
	
fade_to_white:
	LDX	#31
@next_c	
	LDA	palette_buff,X
	BNE	@not_gray
	LDA	#$10
	BNE	@write_c ; JMP
@not_gray	
	CMP	#$F
	BNE	@not_black
	LDA	#$2D
	BNE	@write_c ; JMP
@not_black
	CMP	#$2D
	BNE	@not_dgray
	LDA	#$00
	BEQ	@write_c ; JMP
@not_dgray
	CLC
	ADC	#$10
	CMP	#$40
	BCC	@write_c
	LDA	#$30
@write_c:
	STA	palette_buff,X
	DEX
	BPL	@next_c
	DEY
	BNE	fade_to_white
ret_fade:
	RTS
	
	
draw_1_emerald_pal4:
	LDA	#$03
draw_1_emerald:
	STA	sprites_attr,X
	STA	sprites_attr+4,X
	STA	sprites_attr+8,X
	STA	sprites_attr+12,X
	
	LDA	#$C2
	STA	sprites_tile,X
	LDA	#$C3
	STA	sprites_tile+4,X
	LDA	#$D2
	STA	sprites_tile+8,X
	LDA	#$D3
	STA	sprites_tile+12,X
	
	LDA	pos_y
	STA	sprites_Y,X
	STA	sprites_Y+4,X
	CLC
	ADC	#8
	STA	sprites_Y+8,X
	STA	sprites_Y+12,X
	
	LDA	pos_x
	STA	sprites_X,X
	STA	sprites_X+8,X
	CLC
	ADC	#8
	STA	sprites_X+4,X
	STA	sprites_X+12,X
	TXA
	CLC
	ADC	#16
	TAX
	RTS
	
emerald_shine_cfg:
	.BYTE	$68,$0B,$03,$68
	.BYTE	$68,$14,$03,$70
	.BYTE	$68,$14,$43,$78
	.BYTE	$68,$17,$03,$80
	
	.BYTE	$70,$27,$03,$68
	.BYTE	$70,$29,$03,$70
	.BYTE	$70,$29,$43,$78
	.BYTE	$70,$43,$03,$80
	
	.BYTE	$78,$48,$03,$70
	.BYTE	$78,$48,$43,$78
emerald_shine_cfg_end:
	
	
emeralds_pos:
	.BYTE	000
	.BYTE	036
	.BYTE	072
	.BYTE	109
	.BYTE	145
	.BYTE	182
	.BYTE	219
	
emeralds_attr1:
	.BYTE	00 ; 0+1 (rose)
	.BYTE	00 ; 0+2 (yellow)
	.BYTE	00 ; blue+red = gray?
	.BYTE	00 ; red-orange
	.BYTE	01 ; purple
	.BYTE	02 ; green
	.BYTE	03 ; blue
	
emeralds_attr2:
	.BYTE	01 ; 0+1 (rose)
	.BYTE	02 ; 0+2 (yellow)
	.BYTE	03 ; blue+red = gray?
	.BYTE	00 ; red-orange
	.BYTE	01 ; purple
	.BYTE	02 ; green
	.BYTE	03 ; blue
	
	
;pic2_anim1:
;	.BYTE	$73,$74,$82,$83,$84,$85,$96
pic2_anim2:
	.BYTE	$A9,$AA,$82,$B9,$BA,$BB,$86
	
bad_ending_scenes:
	LDX	#1
	JSR	load_scene_pic
	
	;LDA	#$32
	LDA	#$30
	STA	music_to_play
	
	JSR	screen_unfade_and_show
	LDA	#<150 ; 5 sec
	STA	show_pic_timer
	LDA	#0
	STA	scene_temp
	
@pic_2_loop:
	LDX	#pic_02_spr-pic_01_spr
@pic_2_reload_spr:
	LDA	pic_01_spr,X
	STA	sprites_Y,X
	LDA	pic_01_spr+1,X
	STA	sprites_tile,X
	LDA	pic_01_spr+2,X
	STA	sprites_attr,X
	LDA	pic_01_spr+3,X
	SEC
	SBC	scene_temp
	STA	sprites_X,X
	INX
	INX
	INX
	INX
	CPX	#pic_03_spr-pic_01_spr
	BNE	@pic_2_reload_spr
	LDA	show_pic_timer
	CMP	#120
	BCS	@skip_inc
	LDA	scene_temp
	CMP	#64
	BCS	@skip_inc
	INC	scene_temp
@skip_inc:

	LDA	Frame_Cnt
	AND	#8
	TAY
	BNE	@no_anim
	
	LDX	#pic_02_spr-pic_01_spr
@pic_2_load_spr:
	LDA	pic2_anim2,Y
	STA	sprites_tile,X
	INX
	INX
	INX
	INX
	INY
	CPY	#7
	BNE	@pic_2_load_spr
@no_anim:
	
	LDY	#2
	JSR	_wait_next_frame
	DEC	show_pic_timer
	BNE	@pic_2_loop
	
	JSR	screen_fagind_and_off
	LDX	#2
	JSR	load_scene_pic
	JSR	screen_unfade_and_show
	
	JSR	wait_5_seconds
	JSR	screen_fagind_and_off
	LDX	#7
	JSR	load_scene_pic
	JSR	screen_unfade_and_show

wait_music_end:
@wait
	LDA	var_Channels
	AND	#$20
	BNE	@wait
	
	IF	(VRC7=0)
	LDA	epsm_flag
	BPL	@epsm_song_end
@epsm_song_wait	
	LDA	famistudio_song_speed
	BEQ	@epsm_song_end
	BPL	@epsm_song_wait
@epsm_song_end
	ENDIF

	JSR	screen_fagind_and_off
	JSR	hide_all_sprites
;	LDA	emeralds_cnt
;	CMP	#7
;	BCS	@good_credits
;	JMP	bad_ending
;@good_credits:
	;JSR	hide_all_sprites
	
	LDA	#1
	STA	ppu_tilemap_mask ; NT $2400
	LDX	#$FA
	JSR	bkg_banks
	
	LDA	#<text_ptrs
	STA	credits_ptr_l
	LDA	#>text_ptrs
	STA	credits_ptr_h
	LDY	#0
	STY	credits_ptr_pos
	
	JSR	next_strs
	
	LDA	#$32
	STA	music_to_play
	
cont_read_titles:
	;LDA	#$FF
	;STA	irq_func_num
	JSR	load_best_ending_pal
	LDA	#1
	STA	palette2_ram+1
	LDA	#$11
	STA	palette2_ram+2
	JSR	screen_unfade_and_show
	JSR	wait_5_seconds	
	JSR	screen_fagind_and_off

good_ending_next:
	JSR	next_strs
	JMP	cont_read_titles

	
wait_5_seconds:	
	LDX	#5
wait_X_seconds
	LDY	#60
	JSR	_wait_next_frame
	DEX
	BNE	wait_X_seconds
	RTS
	
	
all_credits_done:
	STA	demo_func_id
	STA	act_id
	PLA
	PLA
	
	LDY	#1
	JSR	_wait_next_frame
	
	LDA	emeralds_cnt
	CMP	#7
	BCS	@good_credits
	JMP	bad_ending
@good_credits:	
	
	;JSR	best_ending_banks_and_spr
	;JSR	load_best_ending_pal
	JSR	load_ending_pic	; best ending pic second show (good ending)
	;LDA	#0
	;STA	ppu_tilemap_mask	; NT $2000
	JSR	screen_unfade_and_show
;endloop

@wait_music
	LDA	var_Channels
	AND	#$20
	BNE	@wait_music
	STA	level_id
	;STA	act_id
	JSR	screen_fagind_and_off
	;JMP	clr_and_go_main
	JMP	best_ending2
	;JMP	endloop

best_ending_banks_and_spr:
	;LDX	#$C8
	LDX	#$CC
	STX	chr_spr_bank1
	LDX	#$70
	STX	chr_spr_bank2
	JSR	hide_all_sprites
	LDX	#(best_end_pal-best_end_oam-1)
@c1
	LDA	best_end_oam,X
	STA	sprites_Y,X
	DEX
	BPL	@c1
	LDX	#$CC
 
bkg_banks:
	STX	chr_bkg_bank1
	INX
	STX	chr_bkg_bank2
	INX
	STX	chr_bkg_bank3
	INX
	STX	chr_bkg_bank4
	
end_strs:
	RTS
	
	
run_level_scene:
	PLA
	PLA
	INY
	LDA	(credits_ptr_l),Y
	STA	level_id
	INY
	LDA	(credits_ptr_l),Y
	STA	act_id
	INY
	STY	credits_ptr_pos
	
	JSR	replay_init
	LDA	#4
	STA	demo_func_id
	LDA	#0
	STA	Frame_Cnt
	
	JMP	g_main
	
	
next_strs:
	LDY	credits_ptr_pos
	LDA	(credits_ptr_l),Y
	BEQ	all_credits_done
	BMI	run_level_scene
	STA	credits_cnt_tmp
	INY
	STY	credits_ptr_pos
	
next_str:
	DEC	credits_cnt_tmp
	BEQ	end_strs
	LDY	credits_ptr_pos
	LDA	(credits_ptr_l),Y
	PHA
	INY
	LDA	(credits_ptr_l),Y
	INY
	STY	credits_ptr_pos
	TAY
	PLA
	
make_str:
	STA	tmp_var_25
	STY	tmp_var_26
	LDY	#0
	STY	str_buff_ptr
	JSR	str_get_byte
	STA	tmp_var_27
	JSR	str_get_byte
	STA	tmp_var_28

print_str:
	JSR	str_get_byte
	TAY
	BEQ	end_str
	CMP	#$20
	BNE	@not_space
	LDA	#$5B
	
@not_space
	CMP	#$41
	BCS	@not_numbers
	ADC	#$40+$2C
@not_numbers
	SEC
	SBC	#$41
	ASL
	ASL
	TAX
	LDY	str_buff_ptr
	LDA	letters,X
	STA	str_buff,Y
	LDA	letters+2,X
	STA	str_buff+$10,Y
	CPX	#$74	; ^ - M part
	BEQ	@skip
	CPX	#$78	; _ - M part
	BEQ	@skip
	LDA	letters+1,X
	STA	str_buff+1,Y
	LDA	letters+3,X
	STA	str_buff+$11,Y
	INY
@skip:	
	INY
	STY	str_buff_ptr
	JMP	print_str
	
end_str:
	LDY	str_buff_ptr
clr_str	
	CPY	#16
	BEQ	@done
	LDA	#$FF	; clear rest str
	STA	str_buff,Y
	STA	str_buff+$10,Y
	INY
	BNE	clr_str
	
@done:	
	LDA	tmp_var_27
	STA	vram_buffer_adr_h
	LDA	tmp_var_28
	STA	vram_buffer_adr_l
	LDA	#0
	STA	vram_buffer_ppu_mode
;	LDA	#16
	STY	vram_buffer_h_length
	LDA	#2
	STA	vram_buffer_v_length
	LDY	#1
	JSR	_wait_next_frame
	JMP	next_str
	;RTS
	
	
str_get_byte:
	LDY	#0
	LDA	(tmp_var_25),Y
	INC	tmp_var_25
	BNE	@no_inc_h
	INC	tmp_var_26
@no_inc_h
	RTS


text_ptrs:
	.BYTE	3
	.WORD	asc_rom,asc_staff
	.BYTE	$FF,GHZ,$00
	
	.BYTE	3
	.WORD	asc_prd,asc_ter
	.BYTE	$FF,MARBLE,$01
	
	.BYTE	3
	.WORD	asc_prg,asc_ti
	.BYTE	$FF,SPRING_YARD,$02
	
	.BYTE	7
	.WORD	asc_gfx,asc_fur,asc_fur2,asc_pac1,asc_pac2,asc_ter2
	.BYTE	$FF,LAB_ZONE,$01
	
	.BYTE	4
	.WORD	asc_mus,asc_sfx,asc_ami
	.BYTE	$FF,STAR_LIGHT,$01
	
	.BYTE	5
	.WORD	asc_snd,asc_snd2,asc_jsr,asc_ti2
	.BYTE	$FF,SCRAP_BRAIN,$02
	
	.BYTE	4
	.WORD	asc_levels,asc_woring2,asc_ter3
	
	.BYTE	7
	.WORD	asc_mus1,asc_mus2,asc_How2bBoss,asc_How2bBoss2,asc_inno1,asc_inno2 ; asc_DFS
	
	.BYTE	8
	.WORD	asc_ext,asc_ext2,asc_tor1,asc_tor2,asc_rushjet1,asc_mac
	.WORD	asc_leo
	
	;.BYTE	4
	;.WORD	asc_log1,asc_log2,asc_mac
	.BYTE	5
	.WORD	asc_orig,asc_hack,asc_hack2,asc_jabu
	.BYTE	5
	.WORD	asc_ded1,asc_ded2,asc_ris1,asc_ris2
	.BYTE	5
	.WORD	asc_pre1,asc_pre2,asc_seg1,asc_seg2
	.BYTE	0
	
asc_rom:
	dc.b	$25
	dc.b	2+$A0
	dc.b	'ROM^HAC',0
asc_staff:
	dc.b	$25
	dc.b	15+$A0
	dc.b	'K STAFF',0
	
asc_prd:
	dc.b	$25
	dc.b	5+$40
	dc.b	'DIRECTED',0
	
asc_ter:
	dc.b	$26
	dc.b	12+$00
	dc.b	'TERW_ILF',0
asc_prg:
	
	dc.b	$25
	dc.b	5+$40
	dc.b	'PROGRAM^',0
	
asc_ti:
	dc.b	$26
	dc.b	18+$00
	dc.b	'TI',0
	
asc_gfx:
	dc.b	$25
	dc.b	2+$00
	dc.b	'GRAPHICS',0
	
asc_fur:
	dc.b	$25
	dc.b	7+$A0
	dc.b	'FURI',0
asc_fur2:
	dc.b	$25
	dc.b	15+$A0
	dc.b	'OUSTH',0
	
asc_pac1:
	dc.b	$26
	dc.b	5+$20
	dc.b	'PACM^AN',0
	
asc_pac2:
	dc.b	$26
	dc.b	18+$20
	dc.b	'FAN64',0
	
asc_ter2:
	dc.b	$26
	dc.b	9+$A0
	dc.b	'TERW_ILF',0
	
asc_ter3:
	dc.b	$26
	dc.b	13+$40
	dc.b	'TERW_ILF',0
	
asc_mus:
	dc.b	$25
	dc.b	2+$60
	dc.b	'M^USIC',0
asc_sfx:
	dc.b	$25
	dc.b	15+$60
	dc.b	'AND SFX',0
	
asc_ami:
	dc.b	$26
	dc.b	8+$20
	dc.b	' AM^ILGI',0
	
	
asc_snd:
	dc.b	$25
	dc.b	3+$20
	dc.b	'SOUND',0
	
asc_snd2:
	dc.b	$25
	dc.b	14+$20
	dc.b	'PROGRAM^',0
	
asc_levels:
	dc.b	$25
	dc.b	4+$20
	dc.b	'LEVELS',0	
	
asc_jsr:
	dc.b	$26
	dc.b	13+$40
	dc.b	'JSR',0
	
asc_ti2:
	dc.b	$25
	dc.b	14+$C0
	dc.b	'TI',0
	
asc_mus1:
	dc.b	$25
	dc.b	2+$20
	dc.b	'M^USIC',0	
	
asc_mus2:
	dc.b	$25
	dc.b	15+$20
	dc.b	'EPSM^',0
	
	
asc_How2bBoss:
	dc.b	$25
	dc.b	11+$C0
	dc.b	'HOW_',0

asc_How2bBoss2:
	dc.b	$25
	dc.b	18+$C0
	dc.b	'5BBOSS',0
	
;asc_DFS:
;	dc.b	$26
;	dc.b	17+$40
;	dc.b	'DFS',0	

asc_inno1:
	dc.b	$26
	dc.b	10+$40
	dc.b	'INNOS',0
asc_inno2:	
	dc.b	$26
	dc.b	20+$40
	dc.b	'PHERE',0
	
asc_ext:
	dc.b	$24
	dc.b	6+$A0
	;dc.b	'FIXES',0
	dc.b	'THANKS',0
asc_ext2:
	dc.b	$24
	dc.b	6+$A5+9
	dc.b	'TO    ',0
	
asc_tor1:
	dc.b	$25
	dc.b	3+$C0
	dc.b	'TORRID',0
asc_tor2:	
	dc.b	$25
	dc.b	15+$C0
	dc.b	'GRISTLE',0
	
asc_rushjet1:	
	dc.b	$25
	dc.b	8+$40
	dc.b	'RUSHJET7',0
	;dc.b	'RUSHJET',0
	
;asc_woring:
;	dc.b	$26
;	dc.b	9+$40
;	dc.b	'W_ORING',0
	
asc_woring2:
	dc.b	$25
	dc.b	13+$C0
	dc.b	'W_ORING',0
	
;asc_log1:
;	dc.b	$25
;	dc.b	3+$60
;	dc.b	'SEGA LOG',0
	
;asc_log2:	
;	dc.b	$25
;	dc.b	19+$60
;	dc.b	'O GFX',0

asc_leo:
	dc.b	$26
	dc.b	9+$40
	dc.b	'LEONARD',0
	
asc_mac:
	dc.b	$26
	dc.b	10+$C0
	dc.b	'M^ACBEE',0	
	
asc_orig:
	dc.b	$25
	dc.b	2+$40
	dc.b	'ORIGINAL',0
	
asc_hack:
	dc.b	$25
	dc.b	7+$A0
	dc.b	'ROM^HAC',0
asc_hack2:
	dc.b	$25
	dc.b	20+$A0
	dc.b	'K',0
	
asc_jabu:
	dc.b	$26
	dc.b	13+$20
	dc.b	'THE JABU',0
	
asc_ded1:
	dc.b	$25
	dc.b	2+$60
	dc.b	'DEDICATE',0
asc_ded2:
	dc.b	$25
	dc.b	18+$60
	dc.b	'D TO',0
	
asc_ris1:
	dc.b	$26
	dc.b	10+$20
	dc.b	'RISTEING',0
asc_ris2:
	dc.b	$26
	dc.b	26+$20
	dc.b	'TV',0
	
	
asc_pre1:
	dc.b	$25
	dc.b	3+$60
	dc.b	'PRESEN',0
asc_pre2:
	dc.b	$25
	dc.b	15+$60
	dc.b	'TED',0
	
asc_seg1:
	dc.b	$26
	dc.b	16+$20
	dc.b	'BY',0
asc_seg2:
	dc.b	$26
	dc.b	21+$20
	dc.b	'SEGA',0
	
letters:
	;.HEX	00 01 10 11 ; A
	.HEX	6C 6D 7C 7D ; A
	.HEX	02 03 12 13 ; B
	.HEX	04 05 14 15 ; C
	.HEX	06 07 16 17 ; D
	.HEX	08 09 18 19 ; E
	.HEX	0A 0B 1A 1B ; F
	.HEX	0C 0D 1C 1D ; G
	.HEX	0E 0F 1E 1F ; H
	
	.HEX	20 21 30 31 ; I
;	.HEX	20 21 30 6E ; I_ (1)
;	.HEX	FF FF 7E 7F ; I_ (2)
	.HEX	22 23 32 33 ; J
	.HEX	24 25 34 35 ; K
	.HEX	26 27 36 37 ; L
	.HEX	28 29 38 39 ; M
	.HEX	2B 2C 3B 3C ; N
	.HEX	2D 2E 3D 3E ; O
	.HEX	40 41 50 51 ; P
	.HEX	2D 2E 3D 6F ; Q *
	.HEX	42 43 52 53 ; R
	.HEX	44 45 54 55 ; S
	.HEX	46 47 56 57 ; T
	.HEX	48 49 58 59 ; U

	.HEX	4A 4B 5A 5B ; V
	.HEX	4C 4D 5C 5D ; W
	.HEX	4E 4F 5E 5F ; X
	.HEX	60 61 70 71; Y
	.HEX	62 63 72 73 ; Z

	.HEX	FF FF FF FF ; space
	
	.HEX	FF FF FF FF ; 
	.HEX	54 55 FF FF ; S-fix
	.HEX	2A FF 3A FF ; M-^
	.HEX	2F FF 3F FF ; W-_
	
	.HEX	66 67 76 77 ; 4
	.HEX	64 65 74 75 ; 2 (5)
	.HEX	68 69 78 79 ; 6
	.HEX	6B 67 7B 77 ; 1 (7)
	
	
; =============== S U B	R O U T	I N E =======================================
	
	
start_wait_next_frame:
		JSR	setup_palette_buff

_wait_next_frame
		LDA	Frame_Cnt
same_frame
		CMP	Frame_Cnt
		BEQ	same_frame
		DEY
		BNE	_wait_next_frame
		RTS


; =============== S U B	R O U T	I N E =======================================


screen_unfade_and_show:
		LDY	#$1F
		LDA	#$F

loc_5400_C7E7:
		STA	palette_ram,Y
		DEY
		BPL	loc_5400_C7E7
		JSR	dislay_show
		LDY	#2
		JSR	start_wait_next_frame ;	input -	A - frames count to wait
		LDA	#$30
		STA	pal_unfade_value

loc_5400_C7FA:
		LDX	#0
		LDY	#0

loc_5400_C7FE:				; saved	palette	for fade/unfade
		LDA	palette2_ram,Y
		AND	#$30
		CMP	pal_unfade_value
		BCC	loc_5400_C824
		BNE	loc_5400_C815
		LDA	palette2_ram,Y	; saved	palette	for fade/unfade
		AND	#$F
		STA	palette_ram,Y
		JMP	loc_5400_C81E
; ---------------------------------------------------------------------------

loc_5400_C815:
		CLC
		LDA	palette_ram,Y
		ADC	#$10
		STA	palette_ram,Y

loc_5400_C81E:				; saved	palette	for fade/unfade
		CMP	palette2_ram,Y
		BNE	loc_5400_C824
		INX

loc_5400_C824:
		INY
		CPY	#$20
		BCC	loc_5400_C7FE
		LDY	#2
		JSR	start_wait_next_frame ;	input -	A - frames count to wait
		SEC
		LDA	pal_unfade_value
		SBC	#$10
		AND	#$30
		STA	pal_unfade_value
		CPX	#$20
		BNE	loc_5400_C7FA
		RTS
; End of function screen_unfade_and_show


; =============== S U B	R O U T	I N E =======================================


screen_fagind_and_off:
		LDY	#$1F

loc_5400_C840:
		LDA	palette_ram,Y
		STA	palette2_ram,Y	; saved	palette	for fade/unfade
		DEY
		BPL	loc_5400_C840

loc_5400_C849:
		LDX	#0
		LDY	#0

loc_5400_C84D:
		INX
		LDA	palette_ram,Y
		CMP	#$F
		BEQ	loc_5400_C860
		DEX
		SEC
		SBC	#$10
		BCS	loc_5400_C85D
		LDA	#$F

loc_5400_C85D:
		STA	palette_ram,Y

loc_5400_C860:
		INY
		CPY	#$20
		BCC	loc_5400_C84D
		LDY	#2
		JSR	start_wait_next_frame ;	input -	A - frames count to wait
		CPX	#$20
		BNE	loc_5400_C849
		LDY	#8
		JSR	start_wait_next_frame ;	input -	A - frames count to wait
		
ending_scr_off:
		LDA	#0
		STA	ppu_ctrl2_val
		STA	PPU_CTRL_REG2

init_NT2:
		LDA	#$00
		LDX	#$24
		LDY	#$80
		JMP	fill_nt	; clear NT
		;JMP	dislay_off
; End of function screen_fagind_and_off


; =============== S U B	R O U T	I N E =======================================


load_ending_pic:
	JSR	best_ending_banks_and_spr
	JSR	load_best_ending_pal
	LDA	#<best_tilemap
	LDY	#>best_tilemap
	STA	temp_ptr_l
	STY	temp_ptr_l+1
	
	LDA	#$20
	LDY	#0
 	STY	PPU_CTRL_REG2 
	STY	ppu_tilemap_mask ; NT $2000
unpack_to_nt:
	STA	PPU_ADDRESS
	STY	PPU_ADDRESS
	JMP	UNRLE


load_scene_pic:
	STX	scene_num
	LDY	scenes_pals,X
	LDA	scenes_spr_pals,X
	PHA
	LDX	#0
@copy_pal:
	LDA	scene1_pal,Y
	STA	palette2_ram,X
	INY
	INX
	CPX	#16
	BNE	@copy_pal
	
	PLA
	TAY
@copy_spr_pal:
	LDA	scene1_spr_pal,Y
	STA	palette2_ram,X
	INY
	INX
	CPX	#16+16
	BNE	@copy_spr_pal
	
	;LDA	#$12
	;STA	palette2_ram,X
	;LDA	#$22
	;STA	palette2_ram,X
	;LDA	#$32
	;STA	palette2_ram,X

	LDY	scene_num
	LDX	scenes_chrs,Y
	JSR	bkg_banks
	LDX	chr_bkg_bank1
	STX	chr_spr_bank1
	LDX	chr_bkg_bank3
	STX	chr_spr_bank2
	
	;LDX	#$CF
	;STX	chr_bkg_bank4
	LDX	scene_num
	LDA	scenes_ptrs_l,X
	LDY	scenes_ptrs_h,X
	STA	temp_ptr_l
	STY	temp_ptr_l+1
	
	;LDA	#$25
	;LDY	#$20
	LDA	#$20
	LDY	#$00
	JSR	unpack_to_nt ; JMP
	LDY	scene_num
	LDX	scenes_nt2_attrs,Y
	STX	irq_func_num
	BMI	load_scenes_sprites
	LDA	#4
	STA	irq_func_num
	
	LDX	scene_num
	LDA	scenes_ptrs_l,X
	LDY	scenes_ptrs_h,X
	STA	temp_ptr_l
	STY	temp_ptr_l+1
	LDA	#$24
	LDY	#$00
	JSR	unpack_to_nt ; JMP

	LDY	scene_num
	LDX	scenes_nt2_attrs,Y
	
	LDA	#$23
	LDY	#$D0
	STA	PPU_ADDRESS
	STY	PPU_ADDRESS
	LDY	#0
@load_alt_attrs
	LDA	scene6_nt2_attrs,X
	STA	PPU_DATA
	INX
	INY
	CPY	#24
	BNE	@load_alt_attrs
	
load_scenes_sprites:
	JSR	hide_all_sprites
	
	LDY	scene_num
	LDA	scenes_sprites+1,Y
	SEC
	SBC	scenes_sprites,Y
	TAX	; size
	LDA	scenes_sprites,Y
	TAY	; base ptr
@load_scn_spr:
	LDA	good_pic1_sprites,Y
	STA	sprites_Y,Y
	INY
	DEX
	BNE	@load_scn_spr
	RTS
	
scenes_chrs:
	.byte	$D4,$D4,$D4,$D8,$D8,$D8,$D8,$D8
	
scenes_pals:
	.byte	$00,$10,$20,$30,$30,$40,$40,$50
	
scene1_pal:
	incbin	menu\sonic_01.pal
	incbin	menu\sonic_02.pal
	incbin	menu\sonic_03.pal
	incbin	menu\sonic_04.pal
	incbin	menu\sonic_06.pal
	incbin	menu\sonic_08.pal
	
scenes_spr_pals:
	.BYTE	$00,$10,$00,$30,$30,$20,$20,$40

scene1_spr_pal:
	.BYTE	$21,$0f,$16,$30, $21,$16,$36,$30, $21,$01,$16,$30, $21,$29,$19,$36 ; scenes 1,3
	.BYTE	$21,$01,$27,$30, $21,$01,$16,$36, $21,$01,$36,$30, $21,$12,$22,$32 ; scene2
	;.BYTE	$0F,$28,$16,$27, $0F,$21,$03,$34, $0F,$19,$29,$30, $0F,$12,$22,$32 ; scenes 6,7
	.BYTE	$0F,$16,$27,$30, $0F,$03,$23,$30, $0F,$19,$29,$30, $0F,$12,$22,$30 ; scenes 6,7
	
	.BYTE	$0f,$0f,$16,$30, $0f,$16,$36,$30, $0f,$01,$16,$30, $0F,$12,$22,$32 ; scenes 4,5
	.BYTE	$21,$28,$16,$27, $21,$21,$03,$24, $21,$19,$29,$30, $21,$12,$22,$32 ; scenes 8

	
; Sonic 01 --------------------------------------
; (21) 0f 16 30 | (21) 16 36 30 |(21) 01 16 30
; Sonic 02 --------------------------------------
; (21) 01 27 30 | (21) 01 16 36 |(21) 01 36 30

; Sonic 06 --------------------------------------
; (0F) 28 16 27 |  (0F) 21 03 24|  (0F) 19 29 30
	
scenes_ptrs_l:
	.byte	<scene_pic1
	.byte	<scene_pic2
	.byte	<scene_pic3
	.byte	<scene_pic4
	.byte	<scene_pic5
	.byte	<scene_pic6
	.byte	<scene_pic7
	.byte	<scene_pic8
scenes_ptrs_h:	
	.byte	>scene_pic1
	.byte	>scene_pic2
	.byte	>scene_pic3
	.byte	>scene_pic4
	.byte	>scene_pic5
	.byte	>scene_pic6
	.byte	>scene_pic7
	.byte	>scene_pic8
	
scenes_nt2_attrs:
	.BYTE	$FF,$FF,$FF,$FF,$FF,00,24,$FF
	
scene6_nt2_attrs:
	HEX	0000CCFFFF33000000000C130D0300000000000901000000
scene7_nt2_attrs:
	HEX	0000CCFFFF33000000000C130D0300000000000901000000
	
scenes_sprites:
	.byte	pic_01_spr-pic_01_spr
	.byte	pic_02_spr-pic_01_spr
	.byte	pic_03_spr-pic_01_spr
	.byte	pic_04_spr-pic_01_spr
	
	.byte	pic_05_spr-pic_01_spr
	.byte	pic_06_spr-pic_01_spr
	.byte	pic_07_spr-pic_01_spr
	.byte	pic_08_spr-pic_01_spr
	.byte	pic_09_spr-pic_01_spr
	
good_pic1_sprites:
	include	menu\good_pic1_spr.asm
	
	
; =============== S U B	R O U T	I N E =======================================

num	equ	tmp_var_27
denom	equ	tmp_var_28

_udivide_8_8:
	sty denom
	sta num

	lda #$00
	ldy #$07
	clc
@div_l	rol num
	rol
	cmp denom
	bcc @nx
	sbc denom
@nx	dey
	bpl @div_l
	rol num
	lda num
	RTS


; =============== S U B	R O U T	I N E =======================================


get_sine:
		CMP	#$C0
		BCS	loc_7D0E0
		CMP	#$80
		BCS	loc_7D0C9
		CMP	#$40
		BCS	loc_7D0DD

loc_7D0C6:
		CLC
		BCC	loc_7D0CA

loc_7D0C9:
		SEC

loc_7D0CA:
		AND	#$3F
		TAY
		LDA	sine_tab,Y
		RTS
; ---------------------------------------------------------------------------

get_cosine:
		CMP	#$C0
		BCS	loc_7D0C6
		CMP	#$80
		BCS	loc_7D0E0
		CMP	#$40
		BCS	loc_7D0C9

loc_7D0DD:
		CLC
		BCC	loc_7D0E1

loc_7D0E0:
		SEC

loc_7D0E1:
		EOR	#$3F
		AND	#$3F
		TAY
		LDA	sine_tab,Y
		RTS
; End of function get_sine

; ---------------------------------------------------------------------------
sine_tab:	.BYTE	 0,   6,  $C, $12, $19,	$1F, $25, $2B, $31, $38, $3E, $44, $4A,	$50, $56, $5C
		.BYTE  $61, $67, $6D, $73, $78,	$7E, $83, $88, $8E, $93, $98, $9D, $A2,	$A7, $AB, $B0
		.BYTE  $B5, $B9, $BD, $C1, $C5,	$C9, $CD, $D1, $D4, $D8, $DB, $DE, $E1,	$E4, $E7, $EA
		.BYTE  $EC, $EE, $F1, $F3, $F4,	$F6, $F8, $F9, $FB, $FC, $FD, $FE, $FE,	$FF, $FF, $FF

; =============== S U B	R O U T	I N E =======================================


load_best_ending_pal:
	LDA	#$FF
	STA	irq_func_num
	LDY	#31
@copy_palette:
	LDA	best_end_pal,Y
	STA	palette2_ram,Y
	DEY
	BPL	@copy_palette
	RTS


; =============== S U B	R O U T	I N E =======================================


dislay_show:
	LDA	#$88
	STA	ppu_ctrl1_val
	STA	PPU_CTRL_REG1
	JSR	wait_vbl
	LDA	#$1E
	STA	ppu_ctrl2_val
	RTS

; ---------------------------------------------------------------------------
best_end_oam:
		incbin	menu\ending_oam.bin
best_end_pal:
		incbin	menu\ending.pal
best_tilemap:
		incbin	menu\ending.rle
scene_pic1:
		incbin	menu\sonic_01.rle
scene_pic2:
		incbin	menu\sonic_02.rle
scene_pic3:
		incbin	menu\sonic_03.rle
scene_pic4:
scene_pic5:
		incbin	menu\sonic_04.rle
		;incbin	menu\sonic_05.rle
scene_pic6:
		incbin	menu\sonic_06.rle
scene_pic7:
		incbin	menu\sonic_07.rle
scene_pic8:
		incbin	menu\sonic_08.rle
		
		
load_good_ending_new:
		JSR	set_bank_17
		LDA	#<good2
		LDY	#>good2
		STA	temp_ptr_l
		STY	temp_ptr_l+1
		
		LDA	#$24
		LDY	#0
		;STY	PPU_CTRL_REG2 
		;STY	ppu_tilemap_mask ; NT $2000
		STA	PPU_ADDRESS
		STY	PPU_ADDRESS
		
		;LDY	#0
		LDX	#4
@loop		
		LDA	(temp_ptr_l),Y
		STA	PPU_DATA
		INY
		BNE	@loop
		INC	temp_ptr_l+1
		DEX
		BNE	@loop
		
		;JSR	set_menu_prg_banks ; $18, $19
		LDX	#$10
		JSR	bkg_banks
		LDA	#$82
		STA	chr_spr_bank1
		LDA	#$4C
		STA	chr_spr_bank2
		LDA	#1
		STA	ppu_tilemap_mask ; NT $2400
		
load_best_ending_pal2:
		LDA	#$FF
		STA	irq_func_num
		LDY	#31
@copy_palette:
		LDA	best_end_pal2,Y
		STA	palette2_ram,Y
		DEY
		BPL	@copy_palette
		RTS
	
best_end_pal2:
		incbin	menu\good.bin


load_good_sprites:
		JSR	set_bank_17
		TXA
		BEQ	load_good_anim3
		LDY	good_spr_ptrs_off-1,X
		LDX	#0
@copy
		LDA	good_frame_00,Y
		STA	sprites_Y,X
		INY
		INX
		CPX	#18*4	; 18 sprites
		BNE	@copy
		JMP	set_menu_prg_banks
		
good_spr_ptrs_off:
		.BYTE	0
		.BYTE	good_frame_01-good_frame_00
		.BYTE	good_frame_02-good_frame_00

load_good_anim3:
		LDX	#0
@load_spr:
		LDA	good_spr,X
		STA	sprites_Y,X
		INX
		BNE	@load_spr
		JMP	set_menu_prg_banks
		
j_ending_move_animals:
		JSR	set_bank_17
		JSR	ending_move_animals
		JMP	set_menu_prg_banks

set_bank_17:
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$17
		STA	prg1_id
		STA	MMC3_bank_data
		RTS
