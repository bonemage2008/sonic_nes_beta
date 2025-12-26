; spec chr banks
spec_main_bank1	equ	$BE ; bank with font
spec_hud_bank	equ	$B9
spec_main_bank2	equ	$BA

;stage_dir	= $80
;map_number	= 0
;WAIT_TIMER1	= 31-5 ; 22 degrees f2.asm
WAIT_TIMER1	= 2 ; 22 degrees f2.asm

;WAIT_TIMER2	= 21-2 ; 45 degrees f3.asm
WAIT_TIMER2	= 2

;WAIT_TIMER3	= 38-4 ; 66 degrees f4.asm
WAIT_TIMER3	= 18-1 ; 66 degrees f4.asm

mmc3_latch = 127-8 ;

vrc7_latch = 180

sonic_jump1_tile equ	$60
sonic_jump2_tile equ	$62
sonic_frame0_tile equ	$20
sonic_frame1_tile equ	$22
sonic_frame2_tile equ	$38


spec_stage_dir	equ	$20
spec_s_mov_dir	equ	$21

special_pos_x_l	equ	$22
special_pos_x_h equ	$23
special_pos_y_l	equ	$24
special_pos_y_h equ	$25

spec_max_rings	equ	$26
spec_rings_cnt	equ	$27

special_speed	equ	$28
special_speedn	equ	$29

spec_spd_cnt_l	equ	$2A
spec_spd_cnt_h	equ	$2B

bumper_pos_l	equ	$2C
bumper_pos_h	equ	$2D

pal_update_flag	equ	$2E
spec_rings_upd	equ	$2F
blue_spher_cnt	equ	$30
blue_spher_upd	equ	$31

spec_jump_flag	equ	$32
no_turn_flag	equ	$33
spec_turn_val	equ	$34
spec_end_flag	equ	$35

win_spec_flag	equ	$36
spec_win_cnt	equ	$37
bumper_hit_flg	equ	$38
spec_win_snd_c	equ	$39

jump_inc_l	equ	$3A
jump_inc_h	equ	$3B
jump_time_l	equ	$3C
jump_time_h	equ	$3D

_joy1_hold	equ	$3E
_joy1_press	equ	$3F

_sprite_id	equ	$40
nmi_flag	equ	$41
frame_cnt	equ	$42
scroll_pos	equ	$43
scroll_pos_new	equ	$44

spec_stage_dirn	equ	$45
load_part_flag	equ	$46
nt_mask		equ	$47
pal1		equ	$48
pal2		equ	$49
;_pause_flag	equ	$4A
_ppu_ctrl2_val	equ	$4A
game_cnt	equ	$4B

chr_bkg_bank	equ	$4C

stars_anim_bank	equ	$4D
anim_speed	equ	$4E
stars_nt_num	equ	$4F

stars_pos_l	equ	$50
stars_pos_h	equ	$51

spheres_cnt_dec	equ	$52 ; 52 53 54  55 56 57
_ppu_ctrl1_val	equ	$58
stars_mov_dir	equ	$59
last_row_fix_f	equ	$5A
anim_speed_and	equ	$5B
message_timer	equ	$5C
msg_spheres_anim_cnt equ $5D
spec_irq_cnt	equ	$5E
stars_nt_num_irq equ	$5F

stars_nt_num_x4	equ	$60
;_ppu_ctrl2_val  equ	$61
walk_frame_num	equ	$61
walk_frame_cnt	equ	$62
walk_anim_speed	equ	$63

;delay		equ	$45
;noise_timer	equ	$78C

scroll_vals	equ	$78C

max_objs	= 24

; $100-$163
;var_ch_Transpose	equ	$164
temp_obj_cnt	equ	$168
temp_obj_type	equ	$180
temp_obj_l	equ	$198
temp_obj_h	equ	$1B0
; 1c8

temp0		equ	0
temp1		equ	1
temp2		equ	2
temp3		equ	3
temp4		equ	4
temp5		equ	5
temp6		equ	6

map_ptr_l	equ	0
map_ptr_h	equ	1

map_ptr_new_l	equ	2
map_ptr_new_h	equ	3

map_ptr_tmp_l	equ	4
map_ptr_tmp_h	equ	5

d2_low		equ	4
d2_high		equ	5
d3_low		equ	6
d3_high		equ	7

;temp_low	equ	8
;temp_high	equ	9

d2_counter	equ	10
d3_counter	equ	11
d6_counter	equ	12
a5_mem_ptr	equ	13
a4_mem_ptr	equ	14

object_slot_saver equ	15

temp_ring_anim	equ	5 ; 0x40
temp_x_inv_flag equ	5 ; 0x80
draw_x_pos_ptr	equ	6
;draw_y_pos_ptr	equ	8
draw_y_pos_ptr	equ	24
draw_sp_x_ptr	equ	10
draw_sp_y_ptr	equ	12
draw_sp_tile_ptr equ	14

nmi_temp0	equ	16
nmi_temp1	equ	17
nmi_temp2	equ	18
nmi_temp3	equ	19

special_pos_y_h_tmp	equ	20
special_pos_x_h_tmp	equ	21
spec_stage_dir_and20	equ	22
odd_frame_flag		equ	23

temp_low	equ	24
temp_high	equ	25

temp_mem	equ	$206

temp_mem_bas	equ	$60


	MACRO	NEG
	EOR	#$FF
	CLC
	ADC	#1
	ENDM

.base $8000

stars_data:
		incbin	special2\stars_bkg_new.bin


;sprites_Y	equ	$200
sprites_addr	equ	$201
;sprites_attr	equ	$202
;sprites_X	equ	$203

; =============== S U B	R O U T	I N E =======================================

		;align	256
;j_spec_main:	JMP	spec_main
;j_spec_irq:	JMP	SPEC_IRQ
		
cycle_fix_table:
		.BYTE	0,1,0,1
		.BYTE	0,0,0,1
		
;inv_tbl:
;		.BYTE	1,0,0,1
;lag_nmi:
;		INC	nmi_flag
;		RTI

spec_music_update:
		JSR	j_sound_update
		JMP	IRQ_RETURN
		
SPEC_NMI:
		TXA
		PHA
		TYA
		PHA
		BVC	spec_music_update
		
		DEC	nmi_flag
		BMI	@skip_spr_upd
		LDA	#0
		STA	PPU_CTRL_REG2
		;BIT	PPU_STATUS
		;LDA	#0
		STA	PPU_SPR_ADDR
		LDA	#2
		STA	SPR_DMA
		LDA	load_part_flag
		BNE	reload_nt2

@skip_spr_upd
		LDA	stars_anim_bank
		BMI	@no_update_nt2
		ORA	#$80
		STA	stars_anim_bank
		JSR	load_stars_2_rows
		BIT	nmi_temp1
		BPL	@no_update_nt2
		JSR	reload_hud
		LDA	last_row_fix_f
		BMI	@skip_draw_msg
		LDA	blue_spher_upd
		ORA	spec_rings_upd
		BNE	@no_need_fix
@no_update_nt2
		LDX	message_timer
		BEQ	@no_draw_message
		DEC	message_timer
		JSR	draw_messages

@no_draw_message
		LDA	last_row_fix_f
		BPL	@no_need_fix
@skip_draw_msg:
		ASL	last_row_fix_f
		JSR	reload_stars_last_row
@no_need_fix
		LDX	blue_spher_upd
		BEQ	@no_upd_spheres_ui
		LDY	#$43
		STY	nmi_temp0
		JSR	draw_spheres_cnt
		LDA	#0
		STA	blue_spher_upd
		
@no_upd_spheres_ui:
		LDX	spec_rings_upd
		BEQ	@no_upd_rings_cnt
		LDY	#$57
		STY	nmi_temp0
		JSR	draw_spheres_cnt
		LDA	#0
		STA	spec_rings_upd
@no_upd_rings_cnt:

		LDX	pal_update_flag
;		BEQ	@no_chg_pal
		BEQ	no_load
		LDA	#$3F
		STA	PPU_ADDRESS
		LDA	#$19
		STA	PPU_ADDRESS
		LDA	chaos_colors1-1,X
		STA	PPU_DATA
		LDA	chaos_colors2-1,X
		STA	PPU_DATA
		LDA	#$20
		STA	PPU_DATA
		LDX	#0
		STX	pal_update_flag
		BEQ	no_load ; JMP
		
;@no_chg_pal
;		JMP	no_load
		
		;LDA	#7|$80
		;STA	MMC3_bank_select
		;LDA	#$7D	; bank 7a010
		;STA	MMC3_bank_data
		
;		LDA	load_part_flag
;		BEQ	no_load
reload_nt2:
		BPL	load_turn_gfx
		LDA	#0
		STA	nt_mask
		JSR	load_std_part
		JSR	load_std_pal
		LDX	#0
		BEQ	no_load ; JMP
load_turn_gfx:
		LDA	#1
		STA	nt_mask
		JSR	load_turn_part_new
		;dex
		;LDX	#WAIT_TIMER
@waitt
		DEX
		BNE	@waitt
;		JMP	@waiitt
;@waiitt
		NOP
		;LDX	#$00
		BIT	PPU_STATUS
		LDA	#$20
		BNE	load_done
no_load:
		LDA	#$00 ; Z=00
load_done:
		PHP
		
		IF	(VRC7=0)
		LDY	#$85
		STY	MMC3_bank_select
		LDY	stars_anim_bank
		STY	MMC3_bank_data
		
		LDY	#$83
		STY	MMC3_bank_select
		LDY	#spec_hud_bank
		STY	MMC3_bank_data
		
		ELSE
		LDY	stars_anim_bank
		STY	VRC7_chr_1C00
		LDY	#spec_hud_bank
		STY	VRC7_chr_0C00
		ENDIF
		
		;LDX	#$00
		STX	load_part_flag ; move?

		;LDX	#$00
		STX	PPU_ADDRESS
		STA	PPU_ADDRESS
		STX	PPU_SCROLL_REG
		STX	PPU_SCROLL_REG
		
		LDA	_ppu_ctrl2_val
		STA	PPU_CTRL_REG2
		LDA	_ppu_ctrl1_val
		ORA	stars_nt_num
		STA	PPU_CTRL_REG1
		
		;LDA	#0 ; ?
		
		IF	(VRC7=0)
		LDY	#spec_main_bank1
		LDX	#$82
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		LDY	#spec_main_bank2
		LDX	#$84
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		
		ELSE
		LDY	#spec_main_bank1
		STY	VRC7_chr_0800
		LDY	#spec_main_bank2
		STY	VRC7_chr_1000
		ENDIF
		
		
		IF	(VRC7=0)
		LDX	#mmc3_latch
		PLP
		BEQ	@normal
		LDA	var_Channels
		AND	#$10
		BNE	@normal
		LDX	#mmc3_latch-9
@normal
;		LDA	irq_pos
		STX	MMC3_IRQ_latch
		STX	MMC3_IRQ_reload
		STX	MMC3_IRQ_enable
		
		ELSE
		LDX	#vrc7_latch
		PLP
		BEQ	@normal
		LDA	var_Channels
		AND	#$10
		BNE	@normal
		LDX	#vrc7_latch-9
@normal
;		LDA	irq_pos
		STX	VRC7_IRQ_latch
		ENDIF
		
		CLI
		LDA	#1
		STA	spec_irq_cnt
		LDA	stars_nt_num
		STA	stars_nt_num_irq
		
		LDA	nmi_flag
		BMI	@skip_j
		JSR	READ_JOY
@skip_j
		JSR	write_scroll_vals
		
		JSR	j_sound_update
		
		LDA	nmi_flag
		BMI	nmi_return
		
		LDA	_joy1_press
		AND	#BUTTON_START
		BEQ	@not_pause
		JSR	pause_special
@not_pause
		JSR	special_main

		;LDX	#4
		JSR	draw_sonic16
		STX	_sprite_id
		
		LDA	_ppu_ctrl2_val
		BPL	@not_paused
		JSR	draw_pause_special
@not_paused
		LDA	message_timer
		CMP	#2
		BCC	@no_draw_spheres
		JSR	draw_message_spheres
@no_draw_spheres:

		JSR	draw_spheres
		
		LDX	_sprite_id
		BEQ	@no_hide
		JSR	hide_sprites
@no_hide

		LDA	special_pos_y_l
		BIT	spec_stage_dirn
		BVC	@ok1
		LDA	special_pos_x_l
@ok1		
		LSR
		LSR
		LSR
		BIT	spec_stage_dirn
		BMI	@ok3
		NEG	; bvc cleared
@ok3:
		STA	scroll_pos_new
		
		LDA	special_pos_y_h
		BIT	spec_stage_dirn
		BVC	@ok2
		LDA	special_pos_x_h
@ok2
		LSR
		BCC	@not_odd
		LDA	scroll_pos_new
		ADC	#$1F	; adc #$20
		STA	scroll_pos_new
@not_odd:
		LDA	scroll_pos_new
		AND	#$3F
		
		BIT	spec_stage_dirn
		BVC	@move_forward_check_x
		PHA
		LDA	special_pos_y_h
		LSR
		PLA
		BCS	write_scroll_pos_new
		EOR	#$20
		BCC	write_scroll_pos_new ; JMP

@move_forward_check_x
		PHA
		LDA	special_pos_x_h
		LSR
		PLA
		BCC	write_scroll_pos_new
		EOR	#$20

write_scroll_pos_new:
		STA	scroll_pos_new
		STA	scroll_pos

		LDA	win_spec_flag
		BEQ	nmi_return
		JSR	special_win_funcs

nmi_return:
		INC	nmi_flag
		JMP	IRQ_RETURN	; NMI_RET
		
		
;		align	256


; =============== S U B	R O U T	I N E =======================================


READ_JOY:
		LDX	#1
		STX	JOYPAD_PORT1
		STX	temp0
		DEX
		STX	JOYPAD_PORT1
		
@read_joy_port_loop:
		LDA	JOYPAD_PORT1
		AND	#3
		CMP	#1
		ROL	temp0
		LDA	JOYPAD_PORT1
		AND	#3
		CMP	#1
		ROL	temp0
		BCC	@read_joy_port_loop
		LDA	temp0
		TAX
		EOR	_joy1_hold
		AND	temp0
@write_joy_vals:
		STA	_joy1_press
		STX	_joy1_hold
		RTS
		
		
; =============== S U B	R O U T	I N E =======================================
		
		align	256

first_irq:
		LDA	#$88 ; 8x8 sprites
		ORA	stars_nt_num_irq
		STA	PPU_CTRL_REG1
		
		IF	(VRC7=0)
		LDA	#7
		STA	MMC3_IRQ_latch
		STA	MMC3_IRQ_reload
		STA	MMC3_IRQ_enable
		ELSE
		
		ENDIF
		
		PLA
		RTI

SPEC_IRQ:
;		STA	MMC3_IRQ_disable
		DEC	spec_irq_cnt
		BEQ	first_irq

		TXA
		PHA
		TYA
		PHA

		LDA	nt_mask
		BEQ	@not_turn_frame
		
@wait_no_spr_hit1
		BIT	PPU_STATUS
		BVS	@wait_no_spr_hit1
;@wait_spr_hit1
;		BIT	PPU_STATUS
;		BVC	@wait_spr_hit1
		LDX	#3
@waita1
		DEX
		BNE	@waita1
		
		LDA	#$89
		STA	PPU_CTRL_REG1
		
		LDY	chr_bkg_bank
		IF	(VRC7=0)
		LDX	#$82
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INX
		INY
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INX
		INY
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		INX
		INY
		STX	MMC3_bank_select
		STY	MMC3_bank_data
		
		ELSE
		STY	VRC7_chr_1000
		INY
		STY	VRC7_chr_1400
		INY
		STY	VRC7_chr_1800
		INY
		STY	VRC7_chr_1C00
		ENDIF
		
		JMP	IRQ_RETURN ; IRQ_RET
		
		
@not_turn_frame:
		;BIT	var_Channels
		;BVS	PAL_MODE_IRQ
		LDA	var_Channels
		AND	#$10
		BNE	PAL_MODE_IRQ
		
@wait_no_spr_hit
		BIT	PPU_STATUS
		BVS	@wait_no_spr_hit
		
		LDA	#$88
		STA	PPU_CTRL_REG1
		
@wait_spr_hit		
		BIT	PPU_STATUS
		BVC	@wait_spr_hit
		
		LDX	#4
@waita		
		DEX
		BNE	@waita
		
		NOP
		NOP
		NOP
		
		;LDX	#0
		;LDA	#$E0
		;LDY	#$47
		;NOP
		;STX	PPU_ADDRESS
		;STY	PPU_SCROLL_REG
		;STX	PPU_SCROLL_REG
		;STA	PPU_ADDRESS
	
		LDX	#0

update_h_scroll:
		LDA	scroll_vals,X
		STA	PPU_SCROLL_REG
		BIT	PPU_STATUS
		
		LDY	#15
@wait:		
		DEY
		BNE	@wait
		
		JMP	asd2
asd2		
		JMP	asd
asd		
		INX
		TXA
		AND	#7
		TAY
		LDA	cycle_fix_table,Y
		BEQ	waitaa
waitaa		
		
		CPX	#$3F+32+16
		BCC	update_h_scroll
		
		;LDA	#0
		;STA	PPU_SCROLL_REG
		;BIT	PPU_STATUS
		JMP	IRQ_RETURN ; IRQ_RET
		
		
PAL_MODE_IRQ:
@wait_no_spr_hit
		BIT	PPU_STATUS
		BVS	@wait_no_spr_hit
		
		LDA	#$88
		STA	PPU_CTRL_REG1
		
@wait_spr_hit		
		BIT	PPU_STATUS
		BVC	@wait_spr_hit
		
		LDX	#4
@waita		
		DEX
		BNE	@waita
		
		NOP
		NOP
		NOP
		;LDX	#0

@update_h_scroll:
		LDA	scroll_vals,X
		STA	PPU_SCROLL_REG ; scanline 128, pixel 242
		BIT	PPU_STATUS
		
		LDY	#13
@wait:
		DEY
		BNE	@wait
		
		JMP	@asd3
@asd3		
		JMP	@asd2
@asd2
		JMP	@asd
@asd		
		INX
		TXA
		AND	#7
		TAY
		LDA	cycle_fix_table_pal,Y
		BEQ	@waitaa
@waitaa		
		
		CPX	#$3F+32+16
		BCC	@update_h_scroll
		
		;LDA	#0
		;STA	PPU_SCROLL_REG
		;BIT	PPU_STATUS
		JMP	IRQ_RETURN ; IRQ_RET
		
cycle_fix_table_pal:
		.BYTE	0,1,0,1
		.BYTE	0,1,0,1


; =============== S U B	R O U T	I N E =======================================


lives_sav	equ	$F4

save_g_vars:
		LDY	#7
save_score:
		LDA	score,Y
		STA	$EC,Y
		DEY
		BPL	save_score
		
		LDA	player_lifes
		STA	lives_sav
		RTS
		
		
load_g_vars:
		LDY	#7
load_score:
		LDA	$EC,Y
		STA	score,Y
		DEY
		BPL	load_score
		
		LDA	lives_sav
		STA	player_lifes
		RTS


; =============== S U B	R O U T	I N E =======================================

		IF	(VRC7=0)
mmc3_spec_banks:
		.BYTE	$BC ; chr1 spr
		.BYTE	$BE ; chr2 spr
		.BYTE	spec_main_bank1
		.BYTE	spec_hud_bank
		.BYTE	spec_main_bank2
		.BYTE	$BB ; chr6 bkg
spec_main:

		LDA	#$88|$20 ; 8x16 sprites
		STA	special_flag
		BIT	PPU_STATUS
		STA	PPU_CTRL_REG1

		JSR	save_g_vars
		
		LDX	#5
@init_mmc3_banks
		STX	MMC3_bank_select
		LDA	mmc3_spec_banks,X
		STA	MMC3_bank_data
		DEX
		BPL	@init_mmc3_banks
		;INX
		;STX	_ppu_ctrl1_val
	
		LDX	#$88|$20 ; 8x16 sprites
		STX	_ppu_ctrl1_val	
		
		ELSE
		
spec_main:

		LDA	#$80
		STA	special_flag
		BIT	PPU_STATUS
		STA	PPU_CTRL_REG1
		
		JSR	save_g_vars

		LDX	#$BC
		STX	VRC7_chr_0000
		INX
		STX	VRC7_chr_0400
		INX
		STX	VRC7_chr_0800
		INX
		STX	VRC7_chr_0C00
		
		LDX	#spec_main_bank1
		STX	VRC7_chr_1000
		LDX	#spec_hud_bank
		STX	VRC7_chr_1400
		LDX	#spec_main_bank2
		STX	VRC7_chr_1800
		LDX	#$BB
		STX	VRC7_chr_1C00
		
		LDX	#$88|$20 ; 8x16 sprites
		STX	_ppu_ctrl1_val
		ENDIF
		
		;LDA	#$1E
		;STA	_ppu_ctrl2_val
		
		;JSR	_load_palette
		;LDA	#7|$80
		;STA	MMC3_bank_select
		;LDA	#$7D	; bank 7a010
		;STA	MMC3_bank_data
		
		LDX	#<map1
		LDY	#>map1
		LDA	#$20
		JSR	load_bkg
		LDX	#<map1
		LDY	#>map1
		LDA	#$24
		JSR	load_bkg
		JSR	load_stars
		LDA	#$20
		LDY	#0
		JSR	_set_ppu_addr
		JSR	fill_1_line
		LDA	#$24
		LDY	#0
		JSR	_set_ppu_addr
		JSR	fill_1_line
		
		LDA	#$78
		STA	sprites_Y
		LDA	#$01 ; 8x16
		STA	sprites_addr
		LDA	#$20
		STA	sprites_attr
		LDA	#$68
		STA	sprites_X
		
		LDX	#4
		JSR	hide_sprites
		
		LDA	#0
		STA	scroll_pos
		;STA	scroll_pos_new
		JSR	write_scroll_vals
		
		JSR	load_map
		;LDA	#4
		JSR	load_std_part
		LDA	#0
		;STA	PPU_CTRL_REG1
		STA	nt_mask
		STA	load_part_flag
		LDA	#$1E
		STA	_ppu_ctrl2_val

		LDA	#3
		STA	irq_func_num
		LDA	#1
		STA	nmi_flag
		;LDA	PPU_STATUS
		JSR	wait_vbl
		JSR	_load_palette
		
		LDA	#$36	; special_stage_blue_spheres
		STA	music_to_play
		
		LDA	#$C0
		STA	special_flag
		;LDA	#$88|$20 ; 8x16 sprites
		;STA	_ppu_ctrl1_val
		;STA	PPU_CTRL_REG1
main_loop:

		LDA	spec_end_flag
		CMP	#$61
		BCC	main_loop
		;JMP	end
		
		
special_end:
		LDA	#0
		;STA	MMC3_IRQ_disable
		STA	PPU_CTRL_REG1
		STA	PPU_CTRL_REG2
		STA	ppu_ctrl1_val
		;STA	special_flag
		STA	music_to_play ; fix for add score sfx
		STA	current_music ; fix for add score sfx
		
		LDX	#$FF
		STX	tilemap_adr_blk_h+00
		STX	tilemap_adr_blk_h+03
		STX	tilemap_adr_blk_h+06
		STX	tilemap_adr_blk_h+09
		STX	tilemap_adr_blk_h+12
		STX	tilemap_adr_blk_h+15
		STX	tilemap_adr_h   ; updated
		STX	tilemap_adr_h_v ; updated
		
		LDA	#8
		STA	level_id
		JSR	load_g_vars
	
		LDX	#0
		STX	rings_100s	; #$00 rings
		STX	rings_10s	; #$00 rings
		;STX	rings_1s	; #$00 rings
		
		DEX	; #$FF
		LDA	spec_max_rings  ; 0 = perfect
		BEQ	@perfect
		LDX	#$7F	; 127 minutes (no bonus)
		
@perfect:
		STX	timer_m
		
		LDA	spec_rings_cnt
		CMP	#100
		BCC	no_100s
		SBC	#100
		INC	rings_100s

no_100s:
		CMP	#10
		BCC	no_10s
		SBC	#10
		INC	rings_10s
		BNE	no_100s
		
no_10s		
		STA	rings_1s
		
		JMP	act_win
		
		
; =============== S U B	R O U T	I N E =======================================


load_map:
;		LDA	#<map
;		STA	temp0
;		LDA	#>map
;		STA	temp1
;		LDA	#0
;		STA	temp2
;		LDA	#3
;		STA	temp3
		
;		LDY	#0
;		LDX	#4
;		
;copymap		
;		LDA	(temp0),Y
;		STA	(temp2),Y
;		INY
;		BNE	copymap
;		INC	temp1
;		INC	temp3
;		
;		DEX
;		BNE	copymap

		LDA	super_em_cnt	; #map_number
		ASL
		TAY
		LDA	maps,Y
		STA	byte_0_1A
		LDA	maps+1,Y
		STA	byte_0_1B
		LDA	#0
		STA	blue_spher_cnt
		STA	spec_rings_cnt
		STA	byte_0_1C
		LDA	#3
		STA	byte_0_1D
		JSR	unpack
		
		;LDA	#stage_dir
		;STA	spec_stage_dir
		
		LDY	super_em_cnt	; #map_number
		LDA	maps_start_dir,Y
		STA	spec_stage_dir
		STA	spec_stage_dirn
		LDA	maps_start_x,Y
		STA	special_pos_x_h
		LDA	maps_start_y,Y
		STA	special_pos_y_h
		LDA	maps_max_rings,Y
		STA	spec_max_rings
		
		LDA	#3
		STA	walk_anim_speed
		LDA	#$10
		STA	special_speed
		LDA	#0
		STA	walk_frame_num
		STA	walk_frame_cnt
		;STA	blue_spher_upd
		;STA	spec_rings_upd
		STA	anim_speed
		STA	anim_speed_and
		INC	anim_speed_and

		STA	stars_mov_dir
		STA	last_row_fix_f
		STA	stars_nt_num
		STA	stars_pos_h
		LDA	#64
		STA	stars_pos_l
		LDA	#120 ; get blue spheres
		STA	message_timer
		LDA	#$C0
		STA	stars_anim_bank
		LDA	#$20
		STA	stars_nt_num_x4
		JSR	init_load_stars
		;JSR	init_ui
		
		LDA	#0
		STA	pal_update_flag
		STA	special_pos_x_l
		STA	special_pos_y_l
		STA	special_speedn
		STA	spec_s_mov_dir
		STA	spec_jump_flag
		STA	spec_turn_val
		STA	win_spec_flag
		STA	spec_win_cnt
		STA	bumper_hit_flg
		STA	no_turn_flag
		STA	spec_end_flag
		;STA	delay
		STA	jump_inc_h
		
		LDX	#max_objs-1
clear_objs:
		STA	temp_obj_cnt,X
		STA	temp_obj_type,X
		DEX
		BPL	clear_objs
		
		LDA	#<(3600+600)
		STA	spec_spd_cnt_l
		LDA	#>(3600+600)
		STA	spec_spd_cnt_h
		
		RTS
	
;unpack:	
;		include	 unpack.asm
		
maps_start_dir:
		.BYTE	$80,$40,$80,$40,$00,$00,$80
		.BYTE	$80 ; map8
maps_start_x:
		.BYTE	$02,$10,$01,$0D,$0F,$03,$10
		.BYTE	$10 ; map8
maps_start_y:
		.BYTE	$02,$1B,$01,$06,$01,$01,$14
		.BYTE	$14 ; map8
maps_max_rings:
		.BYTE	064,111,080,080,054,064,074
		.BYTE	074 ; map8

maps:
		.WORD	level1_map
		.WORD	level2_map
		.WORD	level3_map
		.WORD	level4_map
		.WORD	level5_map
		.WORD	level6_map
		.WORD	level7_map
		.WORD	level7_map

level1_map:
		incbin	special2\spec_map1.pck
level2_map:
		incbin	special2\spec_map2.pck
level3_map:
		incbin	special2\spec_map3.pck
level4_map:
		incbin	special2\spec_map4.pck
level5_map:
		incbin	special2\spec_map5.pck
level6_map:
		incbin	special2\spec_map6.pck
level7_map:
		incbin	special2\spec_map7.pck
;level8_map:
;		incbin	special2\spec_map8.pck


; =============== S U B	R O U T	I N E =======================================


write_scroll_vals:
		LDA	scroll_pos
		AND	#$20
		BEQ	@and0
		LDA	#$FF
@and0:		
		STA	nmi_temp0
		LDA	scroll_pos
		AND	#$1F
		STA	nmi_temp1
		LDY	#7
		LDA	#64
		STA	nmi_temp2 ; initial last pos

loc_50419:
		LDA	byte_50300,Y ; base pos index
		CLC
		ADC	nmi_temp1 ; +to base pos
		STA	nmi_temp3 ; base pos
		TAX

loc_50422:
		TXA
		;CLC
		ADC	#$20	; base pos +20
		AND	nmi_temp0
		STA	scroll_vals,X
		INX
		CPX	nmi_temp2	; last pos
		BCC	loc_50422
		LDA	nmi_temp3
		STA	nmi_temp2	; update last base
		LDA	nmi_temp0
		EOR	#$FF	; inversion light/dark
		STA	nmi_temp0
		LSR	nmi_temp1
		DEY
		BNE	loc_50419
		;RTS
		
		LDA	scroll_pos
		AND	#$1F
		ASL
		TAX
		STX	nmi_temp2
		LDA	scroll_pos
		AND	#$20
		BNE	@case2
		LDX	#47
		CPX	nmi_temp2
		BCC	@clear_all
		
		LDA	#$90
		SEC
		
@load_loop:
		SBC	#1
		STA	scroll_vals+$40,X
		DEX
		CPX	nmi_temp2
		BPL	@load_loop
@clear_all
		LDA	#0
@clr_loop
		STA	scroll_vals+$40,X
		DEX
		BPL	@clr_loop
		RTS
		
@case2:
		CPX	#48
		BCC	@lim_ok
		LDX	#48
		STX	nmi_temp2
@lim_ok		
		
		LDX	#0
		LDA	#$5F
		CLC
		BCC	@start_fill	; JMP
		
@load_loop2:
		ADC	#1
		STA	scroll_vals+$40,X
		INX
@start_fill:
		CPX	nmi_temp2
		BMI	@load_loop2
		CPX	#48
		BCS	@end_l
		
		LDA	#0
@clr_loop2
		STA	scroll_vals+$40,X
		INX
		CPX	#48
		BNE	@clr_loop2
@end_l		
		RTS
; End of function write_scroll_vals


byte_50300:     .BYTE 0, 0, 1, 2, 4, 8, $10, $20
	

; =============== S U B	R O U T	I N E =======================================	
		

_load_palette:
		LDY	#0
		JSR	_set_pal_addr

@load_pal		
		LDA	spec_palettes,Y
		STA	PPU_DATA
		INY
		CPY	#32
		BNE	@load_pal
		LDX	super_em_cnt
		LDY	night_pals_table,X
		BNE	@not_night
		JSR	_set_pal_addr
@load_pal_night
		LDA	spec_palette_night,Y
		STA	PPU_DATA
		INY
		CPY	#8
		BNE	@load_pal_night	
@not_night:
		LDY	#2
		JSR	_set_pal_addr
		LDA	super_em_cnt
		ASL
		TAY
		LDA	by_lvl_pals,Y
		STA	PPU_DATA
		STA	pal1
		LDA	by_lvl_pals+1,Y
		STA	PPU_DATA
		STA	pal2
		RTS
		
_set_pal_addr
		LDA	#$3F
_set_ppu_addr		
		STA	PPU_ADDRESS
		STY	PPU_ADDRESS
		RTS
		
spec_palettes:
		.BYTE	$0F,$11,$27,$17
		.BYTE	$0F,$11,$21,$20
		.BYTE	$0F,$11,$21,$20 ; sphere (bkg)
		.BYTE	$0F,$17,$37,$20 ; ring (bkg)
		
		.BYTE	$0F,$02,$12,$20
		.BYTE	$0F,$06,$16,$20
		.BYTE	$0F,$28,$38,$20
		.BYTE	$0F,$02,$16,$20
		
spec_palette_night:
		.BYTE	$0F,$13,$27,$17
		.BYTE	$0F,$13,$23,$20
		
night_pals_table:
		.BYTE	$01,$00,$01,$01,$00,$00,$01,$00
		
by_lvl_pals:
		.BYTE	$27,$17
		.BYTE	$19,$2C
		;.BYTE	$38,$27 ; stage3 org
		;.BYTE	$37,$26 ; stage3 v2
		.BYTE	$10,$00 ; stage3 gray
		;.BYTE	$16,$36
		.BYTE	$24,$34 ; stage4 new
		.BYTE	$17,$03
		.BYTE	$31,$11
		.BYTE	$27,$13
		;.BYTE	$27,$17
		.BYTE	$23,$03
		
chaos_colors1:
		.BYTE	$01
		.BYTE	$18
		.BYTE	$14
		.BYTE	$1A
		.BYTE	$05
		.BYTE	$00
		.BYTE	$03
		.BYTE	$0C
		
chaos_colors2:
		.BYTE	$22-$10
		.BYTE	$28
		.BYTE	$24
		.BYTE	$29
		.BYTE	$16
		.BYTE	$10
		.BYTE	$13
		.BYTE	$1C
		

; =============== S U B	R O U T	I N E =======================================


load_bkg:
		STX	temp0
		STY	temp1
		LDY	#0
		JSR	_set_ppu_addr
;		LDX	#4
;		
;@load_bkg:
;		LDA	(temp0),Y
;		STA	PPU_DATA
;		INY
;		BNE	@load_bkg
;		INC	temp1
;		DEX
;		BNE	@load_bkg
;		RTS		


; --------------------------------------
_src	equ	0
_tag1	equ	2
_tag2	equ	3
_tag3	equ	4

_UNRLE:
	LDY	#0
	JSR	@get_src_byte1
	TAX
	STX	_tag1	; rle tag
	INX
	STX	_tag2	; rle tag2
	INX
	STX	_tag3	; rle tag3
	
@unrle_plus:
	JSR	@get_src_byte1
	CMP	_tag1
	BEQ	@write_repeated
	CMP	_tag2
	BEQ	@write_repeated_plus
	CMP	_tag3
	BEQ	@write_zeros
	STA	PPU_DATA
	BNE	@unrle_plus
; --------------------------------------
@write_zeros:
	JSR	@get_src_byte1
	TAX
	LDA	#0
	BEQ	@fill_zeros
; --------------------------------------
	
@write_repeated_plus:
	JSR	@get_src_byte1
	TAX
	JSR	@get_src_byte1
	CLC
@loop1	
	STA	PPU_DATA
	ADC	#1
	DEX
	BNE	@loop1
	BEQ	@unrle_plus
; --------------------------------------
	
@write_repeated:
	JSR	@get_src_byte1
	TAX
	BEQ	@end_unpack_plus
	JSR	@get_src_byte1
@fill_zeros:	
@loop2	
	STA	PPU_DATA
	DEX
	BNE	@loop2
	BEQ	@unrle_plus
; --------------------------------------

@get_src_byte1:
	LDA	(_src),Y
	INY
	BNE	@no_inc_h
	INC	_src+1
@no_inc_h
@end_unpack_plus:
	RTS
; --------------------------------------



;invert_x_y_flag:
;		.BYTE	$00	; $00
;		.BYTE	$80	; $40
;		.BYTE	$00	; $80
;		.BYTE	$80	; $C0
inv_tbl:
invert_x_flag:
		.BYTE	$80	; $00
		.BYTE	$00
		.BYTE	$00
		.BYTE	$80	; $C0
;invert_y_flag
;		.BYTE	$80	; $00
;		.BYTE	$80	; $40
;		.BYTE	$00
;		.BYTE	$00
		


draw_spheres:
		INC	frame_cnt
		LDA	frame_cnt
		ASL	A
		ASL	A
		AND	#$40
		;ORA	temp_ring_anim
		STA	temp_ring_anim ; also temp_x_inv_flag
		
		LDA	frame_cnt
		LSR	A
		ROR	odd_frame_flag

		LDA	spec_stage_dirn
		AND	#$30
		STA	spec_stage_dir_and20
		BEQ	@ok
		JMP	draw_diagonal_spheres

@ok
		LDA	special_pos_y_h
		STA	special_pos_y_h_tmp
		LDA	special_pos_x_h
		STA	special_pos_x_h_tmp

		LDA	special_pos_y_l
		BIT	spec_stage_dirn
		BVC	@ok1
		LDA	special_pos_x_l
@ok1	
		LSR
		LSR
		LSR
		;LSR
		BIT	spec_stage_dirn
		BMI	@ok2
		NEG
		AND	#$1F
		BNE	@ok2
		BIT	spec_stage_dirn
		BVS	@ok0
		DEC	special_pos_y_h_tmp
		BVC	@ok2
@ok0		
		DEC	special_pos_x_h_tmp
		;EOR	#$F
@ok2		
		
		TAY
	;LDY	#0
		LDA	#25+7
		STA	temp3
		TYA
		ASL
		TAY
		
		LDA	spec_stage_dirn
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		TAX
		LDA	invert_x_flag,X
		ORA	temp_ring_anim ; temp_x_inv_flag
		STA	temp_x_inv_flag ; temp_ring_anim
;		LDA	invert_y_flag,X
;		STA	11
;		LDA	invert_x_y_flag,X
;		BEQ	@c1
		BIT	spec_stage_dirn
		BVC	@c1
		;LDA	draw_x_table
		LDA	#<draw_positions_x
		STA	draw_y_pos_ptr
		;LDA	draw_x_table+1
		LDA	#>draw_positions_x
		STA	draw_y_pos_ptr+1
		
		BIT	spec_stage_dirn
		BMI	@ok3
		LDA	#<draw_positions_y1
		STA	draw_x_pos_ptr
		LDA	#>draw_positions_y1
		STA	draw_x_pos_ptr+1
		JMP	@c2
		
@ok3		
		;LDA	draw_y_table
		LDA	#<draw_positions_y
		STA	draw_x_pos_ptr
		;LDA	draw_y_table+1
		LDA	#>draw_positions_y
		STA	draw_x_pos_ptr+1
		JMP	@c2
		
@c1		
		;LDA	draw_x_table
		LDA	#<draw_positions_x
		STA	draw_x_pos_ptr
		;LDA	draw_x_table+1
		LDA	#>draw_positions_x
		STA	draw_x_pos_ptr+1
		
		BIT	spec_stage_dirn
		BMI	@ok4
		LDA	#<draw_positions_y1
		STA	draw_y_pos_ptr
		LDA	#>draw_positions_y1
		STA	draw_y_pos_ptr+1
		JMP	@c2
		
@ok4		
		;LDA	draw_y_table
		LDA	#<draw_positions_y
		STA	draw_y_pos_ptr
		;LDA	draw_y_table+1
		LDA	#>draw_positions_y
		STA	draw_y_pos_ptr+1
@c2
		LDA	draw_sp_x_table,Y
		STA	draw_sp_x_ptr
		LDA	draw_sp_x_table+1,Y
		STA	draw_sp_x_ptr+1

		LDA	draw_sp_y_table,Y
		STA	draw_sp_y_ptr
		LDA	draw_sp_y_table+1,Y
		STA	draw_sp_y_ptr+1

		;LDA	draw_sp_tile_table
		LDA	#<draw_sp_tile
		STA	draw_sp_tile_ptr
		;LDA	draw_sp_tile_table+1
		LDA	#>draw_sp_tile
		STA	draw_sp_tile_ptr+1

		LDX	_sprite_id
		LDY	#0
		STY	temp4
		
check_next:
	;	LDY	temp4
	;	LDA	frame_cnt
	;	LSR	A
		BIT	odd_frame_flag
		BMI	@odd_order
		LDA	draw_order_even,Y
		BPL	@even_order
@odd_order:
		LDA	draw_order_odd,Y
@even_order:
		TAY

		;LDA	draw_positions_y,X
		LDA	(draw_y_pos_ptr),Y
;		BIT	spec_stage_dirn
;		BVC	@no_negy
		BIT	temp_x_inv_flag
		BPL	@no_negy
		NEG
@no_negy
		CLC
		ADC	special_pos_y_h_tmp
		AND	#$1F
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		STA	map_ptr_l
		LDA	map_ptr_h
		AND	#3
		CLC
		ADC	#3	; $300 - RAM_MAP
		STA	map_ptr_h
		
		;LDA	draw_positions_x,X
		LDA	(draw_x_pos_ptr),Y
		BIT	spec_stage_dirn
		BMI	@no_negx
;		BIT	11
;		BPL	@no_negx
		NEG
@no_negx	
		CLC
		ADC	special_pos_x_h_tmp
		AND	#$1F
		ORA	map_ptr_l
		STA	map_ptr_l
		STY	temp2
		
		LDY	#0
		LDA	(map_ptr_l),Y
	;LDA	#1
		BNE	do_draw
		JMP	_no_draw
		
do_draw		
		AND	#$F
		TAY
		LDA	attrib_tbl,Y
		LDY	temp2	; restore y
		STA	temp2

		LDA	(draw_sp_x_ptr),Y
		CMP	#$FF
		BNE	on_screen
		JMP	_no_draw
on_screen		
		STA	sprites_X,X
		;LDA	draw_sp_y,X
		LDA	(draw_sp_y_ptr),Y
		SEC
		SBC	spec_win_cnt
		BCC	_no_draw
		STA	sprites_Y,X
		;LDA	draw_sp_x,X
		LDA	temp2
		AND	#$7F
		STA	sprites_attr,X
		CMP	#$10
		LDA	(draw_sp_tile_ptr),Y
		BCC	@not_ring
		BIT	temp2
		BPL	@is_ring ; 8fa1
		ADC	#$20-1	; emerald
		JMP	@not_ring
		;NOP
		
@is_ring:
		ADC	#$40-1
		BIT	temp_ring_anim
		BVC	@not_ring
		ADC	#$20
		
@not_ring:
		STA	sprites_addr,X
		AND	#$1F
		CMP	#$12	; >=12 -> single sprites
		BCS	@next_spr
		
		CPX	#$F4
		BCS	@next_spr
		LDA	sprites_addr,X
		ADC	#1
		STA	sprites_addr+4,X
		ADC	#1
		STA	sprites_addr+8,X
		ADC	#1
		STA	sprites_addr+12,X
		LDA	temp2
		AND	#3
		STA	sprites_attr+4,X
		STA	sprites_attr+8,X
		STA	sprites_attr+12,X
		
		;LDA	draw_sp_y,X
		LDA	(draw_sp_y_ptr),Y
		SEC
		SBC	spec_win_cnt
		BCC	_no_draw
		STA	sprites_Y+8,X
		CLC
		ADC	#8
		STA	sprites_Y+4,X
		STA	sprites_Y+12,X
		
		;LDA	draw_sp_x,X
		LDA	(draw_sp_x_ptr),Y
		STA	sprites_X+4,X
		CLC
		ADC	#8
		STA	sprites_X+8,X
		STA	sprites_X+12,X
		
		TXA
		CLC
		ADC	#16
		BCC	@next
		LDX	#$FC	; check
		
@next_spr:
		TXA
		CLC
		ADC	#4
@next:		
		TAX
		BEQ	end_draw
		
_no_draw:
		INC	temp4
		LDY	temp4
		CPY	temp3
		BEQ	end_draw
		;JMP	check_next
		; test for diagonal
		LDA	spec_stage_dir_and20
;		AND	#$20
		BNE	next_diagonal
		JMP	check_next
end_draw

		STX	_sprite_id
		RTS


draw_diagonal_spheres:
		LDA	spec_stage_dirn
		LSR
		LSR
		LSR
		LSR
		LSR
		AND	#6
		TAX
		JSR	load_diagonals_ptrs
	
draw_diagonal_spheres_:	
		LDY	#42 ; total spheres
		STY	temp3
		
		LDX	_sprite_id
		LDY	#0
		STY	temp4
		
next_diagonal:
		;LDY	temp4
		;LDA	frame_cnt
		;LSR	A
		BIT	odd_frame_flag
		BMI	@odd_order
		LDA	draw_order_diag_even,Y
		BPL	@even_order ; JMP
@odd_order:
		LDA	draw_order_diag_odd,Y
@even_order:
		TAY
		
		LDA	(draw_y_pos_ptr),Y
		CLC
		ADC	special_pos_y_h
		AND	#$1F
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		STA	map_ptr_l
		LDA	map_ptr_h
		AND	#3
		CLC
		ADC	#3	; $300 - RAM_MAP
		STA	map_ptr_h
		
		LDA	(draw_x_pos_ptr),Y
		CLC
		ADC	special_pos_x_h
		AND	#$1F
		ORA	map_ptr_l
		STA	map_ptr_l
		STY	temp2
		
		LDY	#0
		LDA	(map_ptr_l),Y
	;LDA	#1
		BNE	do_draw_diag
		JMP	_no_draw
		
do_draw_diag	
		JMP	do_draw
; --------------------------------------

load_diagonals_ptrs:
		LDA	spec_stage_dir_and20
		CMP	#$20
		BEQ	diagonal_45
		
		LDA	#<draw_sp_diag_tile_22_67
		STA	draw_sp_tile_ptr
		LDA	#>draw_sp_diag_tile_22_67
		STA	draw_sp_tile_ptr+1
		
		BCC	diagonal_22
diagonal_67:		; #$30
		LDA	diag_pos_x_ptrs_67,X
		STA	draw_x_pos_ptr
		LDA	diag_pos_x_ptrs_67+1,X
		STA	draw_x_pos_ptr+1
		
		LDA	diag_pos_y_ptrs_67,X
		STA	draw_y_pos_ptr
		LDA	diag_pos_y_ptrs_67+1,X
		STA	draw_y_pos_ptr+1

		LDA	#<draw_sp_diag_x_67
		STA	draw_sp_x_ptr
		LDA	#>draw_sp_diag_x_67
		STA	draw_sp_x_ptr+1

		LDA	#<draw_sp_diag_y_67
		STA	draw_sp_y_ptr
		LDA	#>draw_sp_diag_y_67
		STA	draw_sp_y_ptr+1
		RTS
diagonal_22:		; #$10
		LDA	diag_pos_x_ptrs_22,X
		STA	draw_x_pos_ptr
		LDA	diag_pos_x_ptrs_22+1,X
		STA	draw_x_pos_ptr+1
		
		LDA	diag_pos_y_ptrs_22,X
		STA	draw_y_pos_ptr
		LDA	diag_pos_y_ptrs_22+1,X
		STA	draw_y_pos_ptr+1

		LDA	#<draw_sp_diag_x_22
		STA	draw_sp_x_ptr
		LDA	#>draw_sp_diag_x_22
		STA	draw_sp_x_ptr+1

		LDA	#<draw_sp_diag_y_22
		STA	draw_sp_y_ptr
		LDA	#>draw_sp_diag_y_22
		STA	draw_sp_y_ptr+1
		RTS
diagonal_45:		; #$20
		LDA	diag_pos_x_ptrs,X
		STA	draw_x_pos_ptr
		LDA	diag_pos_x_ptrs+1,X
		STA	draw_x_pos_ptr+1
		
		LDA	diag_pos_y_ptrs,X
		STA	draw_y_pos_ptr
		LDA	diag_pos_y_ptrs+1,X
		STA	draw_y_pos_ptr+1

		LDA	#<draw_sp_diag_x
		STA	draw_sp_x_ptr
		LDA	#>draw_sp_diag_x
		STA	draw_sp_x_ptr+1

		LDA	#<draw_sp_diag_y
		STA	draw_sp_y_ptr
		LDA	#>draw_sp_diag_y
		STA	draw_sp_y_ptr+1
		
		LDA	#<draw_sp_diag_tile
		STA	draw_sp_tile_ptr
		LDA	#>draw_sp_diag_tile
		STA	draw_sp_tile_ptr+1
		RTS
; --------------------------------------
		
diag_pos_x_ptrs:
		.WORD	draw_pos_diag_x20 ; 20
		.WORD	draw_pos_diag_x60 ; 60 ok
		.WORD	draw_pos_diag_y60 ; A0 ok
		.WORD	draw_pos_diag_yA0 ; E0 ok
diag_pos_y_ptrs:
		.WORD	draw_pos_diag_x60 ; 20
		.WORD	draw_pos_diag_y60 ; 60 ok
		.WORD	draw_pos_diag_yA0 ; A0 ok
		.WORD	draw_pos_diag_x20 ; E0 ok
		
diag_pos_x_ptrs_22:
		.WORD	draw_pos_diag_D0_Y ; $10
		.WORD	draw_pos_diag_F0_X ; $50
		.WORD	draw_pos_diag_90_X ; $90
		.WORD	draw_pos_diag_90_Y ; $D0

diag_pos_y_ptrs_22:
		.WORD	draw_pos_diag_F0_X ; $10
		.WORD	draw_pos_diag_90_X ; $50
		.WORD	draw_pos_diag_90_Y ; $90
		.WORD	draw_pos_diag_D0_Y ; $D0

diag_pos_x_ptrs_67:
		.WORD	draw_pos_diag_F0_X ; $30
		.WORD	draw_pos_diag_D0_Y ; $70
		.WORD	draw_pos_diag_90_Y ; $B0
		.WORD	draw_pos_diag_90_X ; $F0
		
diag_pos_y_ptrs_67:
		.WORD	draw_pos_diag_D0_Y ; $30
		.WORD	draw_pos_diag_90_Y ; $70
		.WORD	draw_pos_diag_90_X ; $B0
		.WORD	draw_pos_diag_F0_X ; $F0
		
; 90_X, 90_Y, D0_Y, F0_X
		
;diag_sp_x_ptrs:
;		.WORD	draw_sp_diag_x
;		.WORD	draw_sp_diag_x
;		.WORD	draw_sp_diag_x
;		.WORD	draw_sp_diag_x
;diag_sp_y_ptrs:
;		.WORD	draw_sp_diag_y
;		.WORD	draw_sp_diag_y
;		.WORD	draw_sp_diag_y
;		.WORD	draw_sp_diag_y
;		
;diag_sp_tile_ptrs:
;		.WORD	draw_sp_diag_tile
;		.WORD	draw_sp_diag_tile
;		.WORD	draw_sp_diag_tile
;		.WORD	draw_sp_diag_tile
		
draw_order_diag_even:
		.BYTE	$00,$02,$05,$09,$0C,$10,$15,$1B
		.BYTE	$01,$03,$06,$0A,$0D,$11,$16,$1C
		.BYTE	    $04,$07,$0B,$0E,$12,$17,$1D
		.BYTE           $08,    $0F,$13,$18,$1E
		.BYTE                       $14,$19,$1F
		.BYTE                           $1A,$20
		.BYTE                               $21
		.BYTE	$22,$23,$24,$25,$26,$27,$28,$29

draw_order_diag_odd:
		.BYTE	$01,$04,$08,$0B,$0F,$14,$1A,$21
		.BYTE	$00,$03,$07,$0A,$0E,$13,$19,$20
		.BYTE       $02,$06,$09,$0D,$12,$18,$1F
		.BYTE           $05,    $0C,$11,$17,$1E
		.BYTE                       $10,$16,$1D
		.BYTE                           $15,$1C
		.BYTE                               $1B
		.BYTE	$29,$28,$27,$26,$25,$24,$23,$22
		
draw_pos_diag_x60:
		.BYTE	$01,$00 ; 2
		.BYTE	$01,$00,$ff ; 5
		.BYTE	$01,$00,$ff,$fe ; 9
		.BYTE	$00,$ff,$fe ; 12
		.BYTE	$00,$ff,$fe,$fd ; 16
		.BYTE	$00,$ff,$fe,$fd,$fc ; 21
		.BYTE	$00,$ff,$fe,$fd,$fc,$fb ; 27
		.BYTE	$00,$ff,$fe,$fd,$fc,$fb,$fa ; 34
		.BYTE	$00,$ff,$fe,$fd,$fc,$fb,$fa,$f9 ; 42
		
draw_pos_diag_x20:
		.BYTE	$00,$01 ; 2
		.BYTE	$ff,$00,$01 ; 5
		.BYTE	$fe,$ff,$00,$01 ; 9
		.BYTE	$fe,$ff,$00 ; 12
		.BYTE	$fd,$fe,$ff,$00 ; 16
		.BYTE	$fc,$fd,$fe,$ff,$00 ; 21
		.BYTE	$fb,$fc,$fd,$fe,$ff,$00 ; 27
		.BYTE	$fa,$fb,$fc,$fd,$fe,$ff,$00 ; 34
		.BYTE	$f9,$fa,$fb,$fc,$fd,$fe,$ff,$00 ; 42
		

draw_pos_diag_y60:
		.BYTE	$00,$ff
		.BYTE	$01,$00,$ff
		.BYTE	$02,$01,$00,$ff
		.BYTE	$02,$01,$00
		.BYTE	$03,$02,$01,$00
		.BYTE	$04,$03,$02,$01,$00
		.BYTE	$05,$04,$03,$02,$01,$00
		.BYTE	$06,$05,$04,$03,$02,$01,$00
		.BYTE	$07,$06,$05,$04,$03,$02,$01,$00

draw_pos_diag_yA0:
		.BYTE	$ff,$00
		.BYTE	$ff,$00,$01
		.BYTE	$ff,$00,$01,$02
		.BYTE	$00,$01,$02
		.BYTE	$00,$01,$02,$03
		.BYTE	$00,$01,$02,$03,$04
		.BYTE	$00,$01,$02,$03,$04,$05
		.BYTE	$00,$01,$02,$03,$04,$05,$06
		.BYTE	$00,$01,$02,$03,$04,$05,$06,$07
		

draw_sp_diag_x:
		.BYTE	56,184
		.BYTE	24,120,216 ; ok
		.BYTE	4,82,158,238 ; ok
		.BYTE	58,120,182 ; ok 
		.BYTE	42,94,148,206 ; ok
		.BYTE	31,74,124,174,217
		.BYTE	20,60,100,148,188,228
		.BYTE	13,50,87,124,165,200,238
		.BYTE	06,40,74,108,142,176,210,244
		
draw_sp_diag_y:
		.BYTE	$D6,$D6
		.BYTE	$B6,$B6,$B6
		.BYTE	$A6,$A6,$A6,$A6
		.BYTE	$99,$98,$99
		.BYTE	$91,$91,$91,$91
		.BYTE	$8A,$8A,$8A,$8A,$8A
		.BYTE	$84,$84,$84,$84,$84,$84
		.BYTE	$80,$80,$80,$80,$80,$80,$80
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D
		
draw_sp_diag_x_22:
		.BYTE	10 ; 0
		.BYTE	196 ; 1
		.BYTE	120 ; 2
		.BYTE	64 ; 3
		.BYTE	196 ; 4
		.BYTE	24 ; 5
		.BYTE	140 ; 6
		.BYTE	94 ; 7
		.BYTE	196 ; 8
		.BYTE	60 ; 9
		
		.BYTE	152 ; 10
		.BYTE	240 ; 11
		.BYTE	32 ; 12
		.BYTE	120 ; 13
		.BYTE	200 ; 14
		.BYTE	6   ; 15
		.BYTE	88  ; 16
		.BYTE	164 ; 17
		.BYTE	236 ; 18
		.BYTE	62 ; 19
		.BYTE	132 ; 20
		.BYTE	200 ; 21
		.BYTE	36 ; 22
		.BYTE	104 ; 23
		.BYTE	170 ; 24
		.BYTE	230 ; 25

		.BYTE	16 ; 26
		.BYTE	80 ; 27
		.BYTE	140 ; 28
		.BYTE	200 ; 29
		
		.BYTE	60 ; 30
		.BYTE	118 ; 31
		.BYTE	174 ; 32
		.BYTE	226 ; 33
		.BYTE	38 ; 34
		.BYTE	94 ; 35
		.BYTE	150 ; 36
		.BYTE	200 ; 37
		.BYTE	22 ; 38
		.BYTE	76 ; 39
		.BYTE	126 ; 40
		.BYTE	176 ; 41
		
draw_sp_diag_y_22:
draw_sp_diag_y_67:	; same as draw_sp_diag_y_22
		.BYTE	$D0
		.BYTE	$C8
		.BYTE	$B6
		.BYTE	$AC
		.BYTE	$A8
		.BYTE	$A4
		.BYTE	$A0
		.BYTE	$9C
		.BYTE	$98
		.BYTE	$96
		
		.BYTE	$95
		.BYTE	$94
		.BYTE	$94
		.BYTE	$93
		.BYTE	$92
		.BYTE	$91
		.BYTE	$90
		.BYTE	$8F
		.BYTE	$8E
		.BYTE	$8D
		.BYTE	$8B
		.BYTE	$89
		.BYTE	$88
		.BYTE	$87
		.BYTE	$86
		.BYTE	$85

		.BYTE	$84
		.BYTE	$84
		.BYTE	$84
		.BYTE	$83
		.BYTE	$83
		.BYTE	$82
		.BYTE	$82
		.BYTE	$82
		.BYTE	$81
		.BYTE	$80
		.BYTE	$7F
		.BYTE	$7E
		.BYTE	$7D
		.BYTE	$7E
		.BYTE	$7E
		.BYTE	$7D

draw_sp_diag_x_67:	; H-mirrored to draw_sp_diag_x_22
		.BYTE	240-10
		.BYTE	240-196
		.BYTE	240-120
		.BYTE	240-64
		.BYTE	240-196
		.BYTE	240-24
		.BYTE	240-140
		.BYTE	240-94
		.BYTE	240-196
		.BYTE	240-60
		
		.BYTE	240-152
		.BYTE	240-240
		.BYTE	248-32
		.BYTE	248-120
		.BYTE	248-200
		.BYTE	248-6
		.BYTE	248-88
		.BYTE	248-164
		.BYTE	248-236
		.BYTE	248-62
		.BYTE	248-132
		.BYTE	248-200
		.BYTE	248-36
		.BYTE	248-104
		.BYTE	248-170
		.BYTE	248-230

		.BYTE	248-16
		.BYTE	248-80
		.BYTE	248-140
		.BYTE	248-200
		.BYTE	248-60
		.BYTE	248-118
		.BYTE	248-174
		.BYTE	248-226
		.BYTE	248-38
		.BYTE	248-94
		.BYTE	248-150
		.BYTE	248-200
		.BYTE	248-22
		.BYTE	248-76
		.BYTE	248-126
		.BYTE	248-176

draw_pos_diag_90_X:
		.BYTE	$01 ; x+1,y-1
		.BYTE	$FF ; x-1,y+0
; 2
		.BYTE	$00 ; x+0,y+0
; 3
		.BYTE	$01 ; x+1,y+0
		.BYTE	$FF ; x-1,y+1
; 5
		.BYTE	$02 ; x+2,y+0
		.BYTE	$00 ; x+0,y+1
; 7
		.BYTE	$01 ; x+1,y+1
		.BYTE	$FF ; x-1,y+2
; 9
		.BYTE	$02 ; x+2,y+1
		.BYTE	$00 ; x+0,y+2
		.BYTE	$FE ; x-2,y+3
; 12
		.BYTE	$03 ; x+3,y+1
		.BYTE	$01 ; x+1,y+2
		.BYTE	$FF ; x-1,y+3
; 15
		.BYTE	$04 ; x+4,y+1
		.BYTE	$02 ; x+2,y+2
		.BYTE	$00 ; x+0,y+3
		.BYTE	$FE ; x-2,y+4
; 19
		.BYTE	$03 ; x+3,y+2
		.BYTE	$01 ; x+1,y+3
		.BYTE	$FF ; x-1,y+4
; 22
		.BYTE	$04 ; x+4,y+2
		.BYTE	$02 ; x+2,y+3
		.BYTE	$00 ; x+0,y+4
		.BYTE	$FE ; x-2,y+5
; 26
		.BYTE	$05 ; x+5,y+2
		.BYTE	$03 ; x+3,y+3
		.BYTE	$01 ; x+1,y+4
		.BYTE	$FF ; x-1,y+5
; 30
		.BYTE	$04 ; x+4,y+3
		.BYTE	$02 ; x+2,y+4
		.BYTE	$00 ; x+0,y+5
		.BYTE	$FE ; x-2,y+6
; 34
		.BYTE	$05 ; x+5,y+3
		.BYTE	$03 ; x+3,y+4
		.BYTE	$01 ; x+1,y+5
		.BYTE	$FF ; x-1,y+6
; 38
		.BYTE	$06 ; x+6,y+3
		.BYTE	$04 ; x+4,y+4
		.BYTE	$02 ; x+2,y+5
		.BYTE	$00 ; x+0,y+6
		
draw_pos_diag_90_Y:
		.BYTE	$FF ; x+1,y-1
		.BYTE	$00 ; x-1,y+0
; 2
		.BYTE	$00 ; x+0,y+0
; 3
		.BYTE	$00 ; x+1,y+0
		.BYTE	$01 ; x-1,y+1
; 5
		.BYTE	$00 ; x+2,y+0
		.BYTE	$01 ; x+0,y+1
; 7
		.BYTE	$01 ; x+1,y+1
		.BYTE	$02 ; x-1,y+2
; 9
		.BYTE	$01 ; x+2,y+1
		.BYTE	$02 ; x+0,y+2
		.BYTE	$03 ; x-2,y+3
; 12
		.BYTE	$01 ; x+3,y+1
		.BYTE	$02 ; x+1,y+2
		.BYTE	$03 ; x-1,y+3
; 15
		.BYTE	$01 ; x+4,y+1
		.BYTE	$02 ; x+2,y+2
		.BYTE	$03 ; x+0,y+3
		.BYTE	$04 ; x-2,y+4
; 19
		.BYTE	$02 ; x+3,y+2
		.BYTE	$03 ; x+1,y+3
		.BYTE	$04 ; x-1,y+4
; 22
		.BYTE	$02 ; x+4,y+2
		.BYTE	$03 ; x+2,y+3
		.BYTE	$04 ; x+0,y+4
		.BYTE	$05 ; x-2,y+5
; 26
		.BYTE	$02 ; x+5,y+2
		.BYTE	$03 ; x+3,y+3
		.BYTE	$04 ; x+1,y+4
		.BYTE	$05 ; x-1,y+5
; 30
		.BYTE	$03 ; x+4,y+3
		.BYTE	$04 ; x+2,y+4
		.BYTE	$05 ; x+0,y+5
		.BYTE	$06 ; x-2,y+6
; 34
		.BYTE	$03 ; x+5,y+3
		.BYTE	$04 ; x+3,y+4
		.BYTE	$05 ; x+1,y+5
		.BYTE	$06 ; x-1,y+6
; 38
		.BYTE	$03 ; x+6,y+3
		.BYTE	$04 ; x+4,y+4
		.BYTE	$05 ; x+2,y+5
		.BYTE	$06 ; x+0,y+6

draw_pos_diag_F0_X:
		.BYTE	+1
		.BYTE	00
; 2
		.BYTE	00
; 3
		.BYTE	00
		.BYTE	-1
; 5
		.BYTE	00
		.BYTE	-1
; 7
		.BYTE	-1
		.BYTE	-2
; 9
		.BYTE	-1
		.BYTE	-2
		.BYTE	-3
; 12
		.BYTE	-1
		.BYTE	-2
		.BYTE	-3
; 15
		.BYTE	-1
		.BYTE	-2
		.BYTE	-3
		.BYTE	-4
; 19
		.BYTE	-2
		.BYTE	-3
		.BYTE	-4
; 22
		.BYTE	-2
		.BYTE	-3
		.BYTE	-4
		.BYTE	-5
; 26
		.BYTE	-2
		.BYTE	-3
		.BYTE	-4
		.BYTE	-5
; 30
		.BYTE	-3
		.BYTE	-4
		.BYTE	-5
		.BYTE	-6
; 34
		.BYTE	-3
		.BYTE	-4
		.BYTE	-5
		.BYTE	-6
; 38
		.BYTE	-3
		.BYTE	-4
		.BYTE	-5
		.BYTE	-6

draw_pos_diag_D0_Y:
		.BYTE	-1
		.BYTE	+1
; 2
		.BYTE	00
; 3
		.BYTE	-1
		.BYTE	+1
; 5
		.BYTE	-2
		.BYTE	00
; 7
		.BYTE	-1
		.BYTE	+1
; 9
		.BYTE	-2
		.BYTE	00
		.BYTE	+2
; 12
		.BYTE	-3
		.BYTE	-1
		.BYTE	+1
; 15
		.BYTE	-4
		.BYTE	-2
		.BYTE	00
		.BYTE	+2
; 19
		.BYTE	-3
		.BYTE	-1
		.BYTE	+1
; 22
		.BYTE	-4
		.BYTE	-2
		.BYTE	00
		.BYTE	+2
; 26
		.BYTE	-5
		.BYTE   -3
		.BYTE	-1
		.BYTE	+1
; 30
		.BYTE	-4
		.BYTE	-2
		.BYTE	00
		.BYTE	+2
; 34
		.BYTE	-5
		.BYTE	-3
		.BYTE	-1
		.BYTE	+1
; 38
		.BYTE	-6
		.BYTE	-4
		.BYTE	-2
		.BYTE	00
		
draw_sp_diag_tile:
		.BYTE	$06,$06   ; 2
		.BYTE	$06,$06,$06 ; 5 
		.BYTE	$0A,$0A,$0A,$0A ; 9  16x16
		.BYTE	$0E,$0A,$0E ; 3   16x16
		.BYTE	$13,$0E,$0E,$13 ; 4    8x8
		.BYTE	$15,$13,$13,$13,$15 ; 5  8x8
		.BYTE	$15,$15,$15,$15,$15,$15 ; 6
		.BYTE	$15,$15,$15,$15,$15,$15,$15 ; 7
		.BYTE	$17,$17,$17,$17,$17,$17,$17,$17 ; 8
		
draw_sp_diag_tile_22_67:
		.BYTE	$06,$06   ; 2
		.BYTE	$06,$06,$06 ; 5 
		.BYTE	$0A,$0A,$0A,$0A ; 9  16x16
		.BYTE	$0E,$0E,$0E ; 3   16x16
		.BYTE	$13,$13,$13,$13 ; 4    8x8
		.BYTE	$13,$13,$13,$13,$15 ; 5  8x8
		.BYTE	$15,$15,$15,$15,$15,$15 ; 6
		.BYTE	$15,$15,$15,$15,$15,$15,$15 ; 7
		.BYTE	$15,$17,$17,$17,$17,$17,$17,$17 ; 8
	
; 06,0A,0E - 16x16
; 13,15,17 - 8x8


;draw_x_table:
;		.WORD	draw_positions_x


;draw_y_table:
;		.WORD	draw_positions_y

		
draw_sp_x_table:
		.WORD	draw_sp_x00
		.WORD	draw_sp_x08
		.WORD	draw_sp_x10
		.WORD	draw_sp_x18
		.WORD	draw_sp_x20
		.WORD	draw_sp_x28
		.WORD	draw_sp_x30
		.WORD	draw_sp_x38
		
		.WORD	draw_sp_x40
		.WORD	draw_sp_x48
		.WORD	draw_sp_x50
		.WORD	draw_sp_x58
		.WORD	draw_sp_x60
		.WORD	draw_sp_x68
		.WORD	draw_sp_x70
		.WORD	draw_sp_x78
		
		.WORD	draw_sp_x80
		.WORD	draw_sp_x88
		.WORD	draw_sp_x90
		.WORD	draw_sp_x98
		.WORD	draw_sp_xA0
		.WORD	draw_sp_xA8
		.WORD	draw_sp_xB0
		.WORD	draw_sp_xB8

		.WORD	draw_sp_xC0
		.WORD	draw_sp_xC8
		.WORD	draw_sp_xD0
		.WORD	draw_sp_xD8
		.WORD	draw_sp_xE0
		.WORD	draw_sp_xE8
		.WORD	draw_sp_xF0
		.WORD	draw_sp_xF8

draw_sp_y_table:
		.WORD	draw_sp_y00
		.WORD	draw_sp_y08
		.WORD	draw_sp_y10
		.WORD	draw_sp_y18
		.WORD	draw_sp_y20
		.WORD	draw_sp_y28
		.WORD	draw_sp_y30
		.WORD	draw_sp_y38
		
		.WORD	draw_sp_y40
		.WORD	draw_sp_y48
		.WORD	draw_sp_y50
		.WORD	draw_sp_y58
		.WORD	draw_sp_y60
		.WORD	draw_sp_y68
		.WORD	draw_sp_y70
		.WORD	draw_sp_y78
		
		.WORD	draw_sp_y80
		.WORD	draw_sp_y88
		.WORD	draw_sp_y90
		.WORD	draw_sp_y98
		.WORD	draw_sp_yA0
		.WORD	draw_sp_yA8
		.WORD	draw_sp_yB0
		.WORD	draw_sp_yB8
		
		.WORD	draw_sp_yC0
		.WORD	draw_sp_yC8
		.WORD	draw_sp_yD0
		.WORD	draw_sp_yD8
		.WORD	draw_sp_yE0
		.WORD	draw_sp_yE8
		.WORD	draw_sp_yF0
		.WORD	draw_sp_yF8


draw_order_even:
		.BYTE	$00,$03,$06,$0B,$12
		.BYTE	$01,$04,$07,$0C,$13
		.BYTE	$02,$05,$08,$0D,$14
		.BYTE           $09,$0E,$15
		.BYTE           $0A,$0F,$16
		.BYTE               $10,$17
		.BYTE               $11,$18
	;.BYTE	$19,$1A,$1B,$1C,$1D,$1E,$1F
	.BYTE	$1A,$1B,$1C,$1D,$1E,$19,$1F
		
draw_order_odd:
		.BYTE	$02,$05,$0A,$11,$18
		.BYTE	$01,$04,$09,$10,$17
		.BYTE	$00,$03,$08,$0F,$16
		.BYTE           $07,$0E,$15
		.BYTE           $06,$0D,$14
		.BYTE               $0C,$13
		.BYTE               $0B,$12
	;.BYTE	$1F,$1E,$1D,$1C,$1B,$1A,$19
	.BYTE	$1E,$1D,$1C,$1B,$1A,$1F,$19
		
draw_positions_x:
		.BYTE	$01,$00,$FF
		.BYTE	$01,$00,$FF
		.BYTE	$02,$01,$00,$FF,$FE
		.BYTE	$03,$02,$01,$00,$FF,$FE,$FD
		.BYTE	$03,$02,$01,$00,$FF,$FE,$FD
	.BYTE	$03,$02,$01,$00,$FF,$FE,$FD
		
draw_positions_y1:
		.BYTE	$ff,$ff,$ff
		.BYTE	$00,$00,$00
		.BYTE	$01,$01,$01,$01,$01
		.BYTE	$02,$02,$02,$02,$02,$02,$02
		.BYTE	$03,$03,$03,$03,$03,$03,$03
	.BYTE	$04,$04,$04,$04,$04,$04,$04

draw_positions_y:
		.BYTE	$00,$00,$00
		.BYTE	$01,$01,$01
		.BYTE	$02,$02,$02,$02,$02
		.BYTE	$03,$03,$03,$03,$03,$03,$03
		.BYTE	$04,$04,$04,$04,$04,$04,$04
	.BYTE	$05,$05,$05,$05,$05,$05,$05



draw_sp_tile:
		.BYTE	$06,$06,$06
		.BYTE	$0A,$0A,$0A
		.BYTE	$0E,$0E,$0E,$0E,$0E
		.BYTE	$13,$13,$13,$13,$13,$13,$13
		.BYTE	$15,$15,$15,$15,$15,$15,$15
	.BYTE	$17,$17,$17,$17,$17,$17,$17
		
;draw_sp_tile9:
;		.BYTE	$02,$02,$02
;		.BYTE	$06,$06,$06
;		.BYTE	$0A,$0A,$0A,$0A,$0A
;		.BYTE	$0E,$0E,$0E,$0E,$0E,$0E,$0E
;		.BYTE	$13,$13,$13,$13,$13,$13,$13


attrib_tbl:
		.BYTE	$00,$01,$00,$02,$12,$12,$12,$12
		.BYTE	$12,$00,$92,$12,$12,$12,$12,$12


; =============== S U B	R O U T	I N E =======================================


bas_spr_id	= 4	; ,X

draw_sonic16:
		;LDA	spec_jump_flag
		LDA	jump_inc_h
		BEQ	draw_sonic_walk
		;LDA	frame_cnt
		;LSR	A
		;AND	#1
		;TAY
		
		LDA	#0
		STA	sprites_attr+bas_spr_id
		STA	sprites_attr+8+bas_spr_id
		EOR	#$40
		STA	sprites_attr+4+bas_spr_id
		STA	sprites_attr+12+bas_spr_id
		LDA	#120
		STA	sprites_X+bas_spr_id
		STA	sprites_X+8+bas_spr_id
		LDA	#128
		STA	sprites_X+4+bas_spr_id
		STA	sprites_X+12+bas_spr_id
		LDA	jump_inc_h
		ASL
		;STA	temp0
		
		;LDA	#168
		;CLC
		;ADC	temp0
		CLC
		ADC	#168+3
		STA	sprites_Y+bas_spr_id
		STA	sprites_Y+4+bas_spr_id
		
		;LDA	#176+3
		;CLC
		;ADC	temp0
		CLC
		ADC	#8
		STA	sprites_Y+8+bas_spr_id
		STA	sprites_Y+12+bas_spr_id
		
		LDA	game_cnt
		AND	#2
		BEQ	jump_frame0
		LDA	#sonic_jump2_tile
		STA	sprites_addr+bas_spr_id
		LDA	#sonic_jump2_tile+2
		STA	sprites_addr+4+bas_spr_id
		LDA	#sonic_jump2_tile+1
		STA	sprites_addr+8+bas_spr_id
		LDA	#sonic_jump2_tile+3
		STA	sprites_addr+12+bas_spr_id
;		JMP	end_draw_sonic_jump
		LDX	#16+4
		RTS
		
jump_frame0:
		LDA	#sonic_jump1_tile
		STA	sprites_addr+bas_spr_id
		STA	sprites_addr+4+bas_spr_id
		LDA	#sonic_jump1_tile+1
		STA	sprites_addr+8+bas_spr_id
		STA	sprites_addr+12+bas_spr_id
end_draw_sonic_jump:
		LDX	#16+4
		RTS

		
walk_frames_sequence:
		.BYTE	0 ; 001/005
		.BYTE	1 ; 002
		.BYTE	2 ; 003
		.BYTE	3 ; 004
		.BYTE	2 ; 003
		.BYTE	1 ; 002	
		
		.BYTE	0 ; 001/005
		.BYTE	1 ; 006
		.BYTE	2 ; 007
		.BYTE	3 ; 008
		.BYTE	2 ; 007
		.BYTE	1 ; 006		

draw_sonic_walk:
		LDX	special_speedn
		BEQ	@stand

		DEC	walk_frame_cnt
		BPL	@ok
		LDA	walk_anim_speed
		STA	walk_frame_cnt
		LDX	walk_frame_num
		INX
		CPX	#12
		BNE	@not_last
		LDX	#0
@not_last:
		STX	walk_frame_num
@ok:
		LDX	walk_frame_num
@stand:
		LDY	walk_frames_sequence,X
		LDA	#0
		CPX	#6
		BCC	@not_mirr
		LDA	#$40
@not_mirr
		STA	temp0

		STA	sprites_attr+bas_spr_id
		STA	sprites_attr+16+bas_spr_id
		STA	sprites_attr+24+bas_spr_id
		ORA	#3
		STA	sprites_attr+8+bas_spr_id
		
		LDA	#$40
		EOR	temp0
		STA	sprites_attr+4+bas_spr_id
		STA	sprites_attr+12+bas_spr_id
		STA	sprites_attr+20+bas_spr_id
		ORA	#3
		STA	sprites_attr+28+bas_spr_id
	
		LDA	frames_Y_pos1,Y
		STA	sprites_Y+bas_spr_id
		STA	sprites_Y+4+bas_spr_id
		
		LDA	frames_Y_pos2,Y
		STA	sprites_Y+16+bas_spr_id
		STA	sprites_Y+12+bas_spr_id
		
		LDA	frames_Y_pos3,Y
		STA	sprites_Y+24+bas_spr_id
		STA	sprites_Y+20+bas_spr_id
		
		LDA	frames_Y_pos4,Y
		BIT	temp0	; BVC/BVS - hflip
		CPY	#1
		BCC	frame_0
		BEQ	frame_1
		CPY	#2
		BEQ	frame_2
		JMP	frame_3

frame_2:
		STA	sprites_Y+28+bas_spr_id
		LDA	#$B4+1
		STA	sprites_Y+8+bas_spr_id
		
		LDA	#$38
		STA	sprites_addr+bas_spr_id
		LDA	#$3A
		STA	sprites_addr+4+bas_spr_id
		LDA	#$39
		STA	sprites_addr+16+bas_spr_id
		LDA	#$3B
		STA	sprites_addr+12+bas_spr_id
		LDA	#$58
		STA	sprites_addr+24+bas_spr_id
		LDA	#$5A
		STA	sprites_addr+20+bas_spr_id
		LDA	#$59	; high priority
		STA	sprites_addr+8+bas_spr_id
		LDA	#$5B
		STA	sprites_addr+28+bas_spr_id

		LDA	#$78
		BVC	frame_0_write_sprX
		LDA	#$80+1
		BNE	frame_0_write_sprX ; JMP
		
frame_1:
		STA	sprites_Y+28+bas_spr_id
		LDA	#$B6+1
		STA	sprites_Y+8+bas_spr_id
		
		LDA	#sonic_frame1_tile
		STA	sprites_addr+bas_spr_id
		LDA	#sonic_frame1_tile+2
		STA	sprites_addr+4+bas_spr_id
		LDA	#sonic_frame1_tile+1
		STA	sprites_addr+16+bas_spr_id
		LDA	#sonic_frame1_tile+3
		STA	sprites_addr+12+bas_spr_id
		LDA	#sonic_frame1_tile+$20
		STA	sprites_addr+24+bas_spr_id
		LDA	#sonic_frame1_tile+$22
		STA	sprites_addr+20+bas_spr_id
		LDA	#sonic_frame1_tile+$21
		STA	sprites_addr+8+bas_spr_id
		LDA	#sonic_frame1_tile+$23
		STA	sprites_addr+28+bas_spr_id

		LDA	#$77
		BVC	frame_0_write_sprX
		LDA	#$7F+2
		BNE	frame_0_write_sprX ; JMP
		
frame_0:
		STA	sprites_Y+08+bas_spr_id
		STA	sprites_Y+28+bas_spr_id
		
		LDA	#sonic_frame0_tile
		STA	sprites_addr+bas_spr_id
		STA	sprites_addr+4+bas_spr_id
		
		LDA	#sonic_frame0_tile+1
		STA	sprites_addr+16+bas_spr_id
		STA	sprites_addr+12+bas_spr_id
		
		LDA	#sonic_frame0_tile+$20
		STA	sprites_addr+24+bas_spr_id
		STA	sprites_addr+20+bas_spr_id
		
		LDA	#sonic_frame0_tile+$21
		STA	sprites_addr+08+bas_spr_id
		STA	sprites_addr+28+bas_spr_id

		LDA	#$79
		BVC	no_hflip0
		LDA	#$80
no_hflip0:
frame_0_write_sprX:
		LDX	#32+4	; 8 sprites
		STA	sprites_X+bas_spr_id
		STA	sprites_X+16+bas_spr_id
		STA	sprites_X+24+bas_spr_id
		STA	sprites_X+08+bas_spr_id
		
		BVC	@c1
		EOR	frames_X_xor+4,Y
		BVS	@c2
@c1		
		EOR	frames_X_xor,Y
@c2
		STA	sprites_X+4+bas_spr_id
		STA	sprites_X+12+bas_spr_id
		STA	sprites_X+20+bas_spr_id
		STA	sprites_X+28+bas_spr_id
		CPY	#2
		BEQ	frame2_fix
		RTS

frame2_fix:
		BVC	no_hflip2
		INC	sprites_X+28+bas_spr_id ; $78->$79
		RTS
		
no_hflip2:
		DEC	sprites_X+28+bas_spr_id ; $80->$7F
		RTS

frames_X_xor:
		.BYTE	$F9	; $79 <-> $80
		.BYTE	$08	; $77 <-> $7F
		.BYTE	$F8	; $78 <-> $80
		.BYTE	$F8	; $78 <-> $80

		.BYTE	$F9
		.BYTE	$F8
		.BYTE	$F8
		.BYTE	$F8

frames_Y_pos1:
		.BYTE	$A7+1 ; frame1
		.BYTE	$A6+1 ; frame2
		.BYTE	$A5+1 ; frame3
		.BYTE	$A5+1 ; frame4
frames_Y_pos2:
		.BYTE	$AF+1 ; frame1
		.BYTE	$AE+1 ; frame2
		.BYTE	$AD+1 ; frame3
		.BYTE	$AD+1 ; frame4
frames_Y_pos3:
		.BYTE	$B7+1 ; frame1
		.BYTE	$B6+1 ; frame2
		.BYTE	$B5+1 ; frame3
		.BYTE	$B5+1 ; frame4
frames_Y_pos4:
		.BYTE	$BF+1 ; frame1
		.BYTE	$BE+1 ; frame2
		.BYTE	$BD+1 ; frame3
		.BYTE	$BD+1 ; frame4

frame_3:
		;STA	sprites_Y+28+bas_spr_id	; 7 sprites
		STA	sprites_Y+08+bas_spr_id
		
		LDA	#$78
		BVC	@no_flip3
		LDA	#$7F+2
@no_flip3
		STA	sprites_X+bas_spr_id
		STA	sprites_X+16+bas_spr_id
		
		LDA	#$80
		BVC	@no_flip3a
		LDA	#$77+2
@no_flip3a:
		STA	sprites_X+4+bas_spr_id
		STA	sprites_X+12+bas_spr_id
	
		BVC	@no_hflip
		LDA	#$80+2+2
		STA	sprites_X+24+bas_spr_id
		LDA	#$78+2+2
		BNE	@hflip ; JMP
		
@no_hflip:
		LDA	#$75
		STA	sprites_X+24+bas_spr_id
		LDA	#$7D
@hflip:		
		STA	sprites_X+08+bas_spr_id
		STA	sprites_X+20+bas_spr_id
		
		LDA	#$02
		STA	sprites_addr+bas_spr_id
		LDA	#$04
		STA	sprites_addr+4+bas_spr_id
		LDA	#$03
		STA	sprites_addr+16+bas_spr_id
		LDA	#$05
		STA	sprites_addr+12+bas_spr_id
		LDA	#$12
		STA	sprites_addr+24+bas_spr_id
		LDA	#$14
		STA	sprites_addr+20+bas_spr_id
		LDA	#$16
		STA	sprites_addr+08+bas_spr_id
		;LDA	#$16
		;STA	sprites_addr+28+bas_spr_id ; 7 sprites
		LDX	#32	; 7 sprites
		RTS


; =============== S U B	R O U T	I N E =======================================


		MACRO	UPDATE_BLUE_SPHERES_CNT
		STA	blue_spher_upd ; update flag
		DEC	blue_spher_cnt
		BNE	@loc_8CD8
		STA	win_spec_flag
@loc_8CD8:

		ENDM


; =============== S U B	R O U T	I N E =======================================


conv_rings_cnt:
		LDA	spec_rings_cnt
		LDX	#2+3
		STX	spec_rings_upd
		BNE	convert_to_dec ; JMP
conv_spheres_cnt:
		LDA	blue_spher_cnt
		LDX	#2
		STX	blue_spher_upd
		BNE	convert_to_dec ; JMP
conv_to_dec_loop:
		CPX	#2
		BEQ	done_conv_to_10
convert_to_dec		
		LDY	#0
		SEC
@loc_7BE6:
		SBC	hex_to_dec_tbl,X
		BCC	@loc_7BEE
		INY
		BNE	@loc_7BE6
		
@loc_7BEE:
		ADC	hex_to_dec_tbl,X
		STY	spheres_cnt_dec,X
		DEX
		BPL	conv_to_dec_loop
done_conv_to_10:
		RTS
		
hex_to_dec_tbl:
		.BYTE	1,10,100
		.BYTE	1,10,100


; =============== S U B	R O U T	I N E =======================================


draw_num_loop:
		CPX	#2
		BEQ	done_draw_spheres
		LDY	nmi_temp0
draw_spheres_cnt:
		LDA	stars_nt_num_x4
		STA	PPU_ADDRESS
		STY	PPU_ADDRESS
		LDY	spheres_cnt_dec,X
		LDA	num_tiles+00,Y
		STA	PPU_DATA
		LDA	num_tiles+10,Y
		STA	PPU_DATA
		LDA	stars_nt_num_x4
		STA	PPU_ADDRESS
		LDA	nmi_temp0
		CLC
		ADC	#$20
		STA	PPU_ADDRESS
		ADC	#$E2 ; -$20 + 2
		STA	nmi_temp0
		LDA	num_tiles+20,Y
		STA	PPU_DATA
		LDA	num_tiles+30,Y
		STA	PPU_DATA
		DEX
		BPL	draw_num_loop
done_draw_spheres:
		RTS

num_tiles:
		.BYTE	$40,$42,$44,$46,$48,$4A,$4C,$4E,$60,$62
		.BYTE	$41,$43,$45,$47,$49,$4B,$4D,$4F,$61,$63
		.BYTE	$50,$52,$54,$56,$58,$5A,$5C,$5E,$70,$72
		.BYTE	$51,$53,$55,$57,$59,$5B,$5D,$5F,$71,$73


; =============== S U B	R O U T	I N E =======================================


init_hud_nt1:
		LDX	#$20
		BNE	upper_part_or_lower_part
reload_hud:
		LDA	stars_nt_num_x4
		EOR	#4 ; 20<->24
		TAX
upper_part_or_lower_part:
		STX	PPU_ADDRESS
		BVC	upper_part
		JMP	lower_part
upper_part:
		LDA	#$21+1
		STA	PPU_ADDRESS
		LDA	#$68
		STA	PPU_DATA
		LDA	#$6C
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		LDA	#$69
		STA	PPU_DATA

		STX	PPU_ADDRESS
		LDA	#$34-1
		STA	PPU_ADDRESS
		LDA	#$68
		STA	PPU_DATA
		LDA	#$6C
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		LDA	#$6A
		STA	PPU_DATA
		
		STX	PPU_ADDRESS
		LDA	#$28+$20+1
		STA	PPU_ADDRESS
		LDA	#$6D
		STA	PPU_DATA
		LDA	#$64
		STA	PPU_DATA
		LDA	#$65
		STA	PPU_DATA
		LDA	#$6F
		STA	PPU_DATA

		STX	PPU_ADDRESS
		LDA	#$34+$20-1
		STA	PPU_ADDRESS
		LDA	#$7B
		STA	PPU_DATA
		LDA	#$66
		STA	PPU_DATA
		LDA	#$67
		;STA	PPU_DATA
		;LDA	#$7D
		;STA	PPU_DATA
		JMP	both_parts
		
lower_part:
		LDA	#$21+$60+1
		STA	PPU_ADDRESS
		LDA	#$78
		STA	PPU_DATA
		LDA	#$7C
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		LDA	#$79
		STA	PPU_DATA

		STX	PPU_ADDRESS
		LDA	#$34+$60-1
		STA	PPU_ADDRESS
		LDA	#$78
		STA	PPU_DATA
		LDA	#$7C
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		STA	PPU_DATA
		LDA	#$7A
		STA	PPU_DATA

		STX	PPU_ADDRESS
		LDA	#$28+$40+1
		STA	PPU_ADDRESS
		LDA	#$6D
		STA	PPU_DATA
		LDA	#$74
		STA	PPU_DATA
		LDA	#$75
		STA	PPU_DATA
		LDA	#$6F
		STA	PPU_DATA

		STX	PPU_ADDRESS
		LDA	#$34+$40-1
		STA	PPU_ADDRESS
		LDA	#$7B
		STA	PPU_DATA
		LDA	#$76
		STA	PPU_DATA
		LDA	#$77
both_parts:
		STA	PPU_DATA
		LDA	#$7D
		STA	PPU_DATA

		LDA	_ppu_ctrl1_val
		ORA	#4
		STA	PPU_CTRL_REG1
		STX	PPU_ADDRESS
		LDA	#$21+$20+1
		STA	PPU_ADDRESS
		LDA	#$6B
		STA	PPU_DATA
		STA	PPU_DATA
		
		STX	PPU_ADDRESS
		LDA	#$3E+$20-1
		STA	PPU_ADDRESS
		LDA	#$6E
		STA	PPU_DATA
		LDA	#$7E
		STA	PPU_DATA
		
		LDA	_ppu_ctrl1_val
		ORA	stars_nt_num
		STA	PPU_CTRL_REG1
		RTS


; =============== S U B	R O U T	I N E =======================================


clear_text:
		TXA	; $00
		LDY	#$21
		STY	PPU_ADDRESS
		LDX	#$88
		STX	PPU_ADDRESS
		JSR	sta16
		STY	PPU_ADDRESS
		LDX	#$A8
		STX	PPU_ADDRESS
		JSR	sta16
		LDY	#$25
		STY	PPU_ADDRESS
		LDX	#$88
		STX	PPU_ADDRESS
		JSR	sta16
		STY	PPU_ADDRESS
		LDX	#$A8
		STX	PPU_ADDRESS
		JMP	sta16

; perfect message
draw_messages:
		DEX
		BEQ	clear_text
		LDA	stars_nt_num_x4
		ORA	#1 ; $21/$25
		STA	PPU_ADDRESS
		
		LDX	spec_max_rings
		BNE	draw_msg_get_blue_spheres
		
		LDX	#$8C
		STX	PPU_ADDRESS
		
		LDX	#$20	; 'P'
		STX	PPU_DATA
		LDY	#$05	; 'E'
		STY	PPU_DATA
		LDX	#$22	; 'R'
		STX	PPU_DATA
		LDX	#$06	; 'F'
		STX	PPU_DATA
		;LDY	#$05	; 'E'
		STY	PPU_DATA
		LDX	#$03	; 'C'
		STX	PPU_DATA
		LDX	#$24	; 'T'
		STX	PPU_DATA
		
		STA	PPU_ADDRESS
		LDX	#$AC
		STX	PPU_ADDRESS
		
		LDX	#$20+$10 ; 'P'
		STX	PPU_DATA
		LDY	#$05+$10 ; 'E'
		STY	PPU_DATA
		LDX	#$22+$10 ; 'R'
		STX	PPU_DATA
		LDX	#$06+$10 ; 'F'
		STX	PPU_DATA
		;LDY	#$05+$10 ; 'E'
		STY	PPU_DATA
		LDX	#$03+$10 ; 'C'
		STX	PPU_DATA
		LDX	#$24+$10 ; 'T'
		STX	PPU_DATA
		RTS
		
		
draw_msg_get_blue_spheres:
		LDX	#$88
		STX	PPU_ADDRESS
		
		LDX	#$07
		STX	PPU_DATA
		LDY	#$05
		STY	PPU_DATA
		LDX	#$24
		STX	PPU_DATA
		BIT	PPU_DATA
		LDX	#$02
		STX	PPU_DATA
		LDX	#$0C
		STX	PPU_DATA
		LDX	#$25
		STX	PPU_DATA
		STY	PPU_DATA
		BIT	PPU_DATA
		LDX	#$23
		STX	PPU_DATA
		LDX	#$20
		STX	PPU_DATA
		LDX	#$08
		STX	PPU_DATA
		STY	PPU_DATA
		LDX	#$22
		STX	PPU_DATA
		STY	PPU_DATA
		INX
		STX	PPU_DATA
		
		STA	PPU_ADDRESS
		LDX	#$A8
		STX	PPU_ADDRESS
		LDX	#$07+$10
		STX	PPU_DATA
		LDY	#$05+$10
		STY	PPU_DATA
		LDX	#$24+$10
		STX	PPU_DATA
		BIT	PPU_DATA
		LDX	#$02+$10
		STX	PPU_DATA
		LDX	#$0C+$10
		STX	PPU_DATA
		LDX	#$25+$10
		STX	PPU_DATA
		STY	PPU_DATA
		BIT	PPU_DATA
		LDX	#$23+$10
		STX	PPU_DATA
		LDX	#$20+$10
		STX	PPU_DATA
		LDX	#$08+$10
		STX	PPU_DATA
		STY	PPU_DATA
		LDX	#$22+$10
		STX	PPU_DATA
		STY	PPU_DATA
		INX
		STX	PPU_DATA
		
		RTS
		
		
;		LDX	#15
;@copy_str_h
;		LDY	get_blue_spheres_text,X
;		STY	PPU_DATA
;		DEX
;		BPL	@copy_str_h
;		STA	PPU_ADDRESS
;		LDX	#$A8
;		STX	PPU_ADDRESS
;		LDX	#15
;@copy_str_l
;		LDA	get_blue_spheres_text_low,X
;		STA	PPU_DATA
;		DEX
;		BPL	@copy_str_l
;		RTS
		
;get_blue_spheres_text:
;		.BYTE	$23 ; S
;		.BYTE	$05 ; E
;		.BYTE	$22 ; R
;		.BYTE	$05 ; E
;		.BYTE	$08 ; H
;		.BYTE	$20 ; P
;		.BYTE	$23 ; S
;		.BYTE	$00 
;		.BYTE	$05 ; E
;		.BYTE	$25 ; U
;		.BYTE	$0C ; L
;		.BYTE	$02 ; B
;		.BYTE	$00
;		.BYTE	$24 ; T
;		.BYTE	$05 ; E
;		.BYTE	$07 ; G
;		
;get_blue_spheres_text_low:
;		.BYTE	$23+$10 ; S
;		.BYTE	$05+$10 ; E
;		.BYTE	$22+$10 ; R
;		.BYTE	$05+$10 ; E
;		.BYTE	$08+$10 ; H
;		.BYTE	$20+$10 ; P
;		.BYTE	$23+$10 ; S
;		.BYTE	$00+$10 
;		.BYTE	$05+$10 ; E
;		.BYTE	$25+$10 ; U
;		.BYTE	$0C+$10 ; L
;		.BYTE	$02+$10 ; B
;		.BYTE	$00+$10
;		.BYTE	$24+$10 ; T
;		.BYTE	$05+$10 ; E
;		.BYTE	$07+$10 ; G		


; =============== S U B	R O U T	I N E =======================================

; X = sprite id off
draw_message_spheres:
		LDA	#$5F
		STA	sprites_Y,X
		STA	sprites_Y+4,X
		STA	sprites_Y+8,X
		STA	sprites_Y+12,X
		
		LDA	spec_max_rings
		BEQ	@perfect_spheres_pos
		LDA	#$28
		STA	sprites_X,X
		LDA	#$30
		STA	sprites_X+4,X
		LDA	#$C8
		STA	sprites_X+8,X
		LDA	#$D0
		;BNE	@get_spheres_pos ; blue spheres
		
		STA	sprites_X+12,X ; red arrows
		LDA	#$7D
		STA	sprites_addr+0,X
		STA	sprites_addr+12,X
		EOR	#2
		STA	sprites_addr+4,X
		STA	sprites_addr+8,X
		LDA	#1
		BNE	write_attr ; JMP
		
@perfect_spheres_pos:
		LDA	#$48
		STA	sprites_X,X
		LDA	#$50
		STA	sprites_X+4,X
		LDA	#$A0
		STA	sprites_X+8,X
		LDA	#$A8
@get_spheres_pos:
		STA	sprites_X+12,X

		LDA	frame_cnt
		AND	#3
		BNE	@ok
		
		DEC	msg_spheres_anim_cnt
		BPL	@ok
		LDA	#7
		STA	msg_spheres_anim_cnt
@ok		
		LDY	msg_spheres_anim_cnt
		LDA	msg_spheres_addr,Y
		STA	sprites_addr+0,X
		STA	sprites_addr+12,X
		EOR	#2
		STA	sprites_addr+4,X
		STA	sprites_addr+8,X
		LDA	#0 ; spheres attr
		CPY	#5
		BCC	write_attr
		EOR	#$40 ; mirrored
write_attr:
		STA	sprites_attr+0,X
		STA	sprites_attr+4,X
		EOR	#$40
		STA	sprites_attr+8,X
		STA	sprites_attr+12,X
		
		TXA
		CLC
		ADC	#4*4 ; 4 sprites 8x16
		STA	_sprite_id
		RTS

msg_spheres_addr:
		.BYTE	$19,$1D,$3D
		.BYTE	$5D,$79
		.BYTE	$5D^2,$3D^2,$1D^2
		
		
; =============== S U B	R O U T	I N E =======================================
		
		
draw_pause_special:
		LDX	_sprite_id
		LDY	#0
@load_pause_text
		LDA	pause_sprites_special,Y
		BEQ	@done
		STA	sprites_Y,X
		INY
		INX
		JMP	@load_pause_text
@done:
		STX	_sprite_id
spec_paused_ret:
		RTS
		
pause_sprites_special:
		.BYTE	$6F+8,$AB,$03,$70 ; P
		.BYTE	$77+8,$BB,$03,$70 ; P
		
		.BYTE	$6F+8,$AC,$03,$78 ; A
		.BYTE	$77+8,$BC,$03,$78 ; A
		
		.BYTE	$6F+8,$AD,$03,$80 ; U
		.BYTE	$77+8,$BD,$03,$80 ; U
		
		.BYTE	$6F+8,$AE,$03,$88 ; S
		.BYTE	$77+8,$BE,$03,$88 ; S

		.BYTE	$6F+8,$AF,$03,$90 ; E
		.BYTE	$77+8,$BF,$03,$90 ; E
		
		.BYTE	$00
		

; =============== S U B	R O U T	I N E =======================================


pause_special:
		LDX	#%1100
		LDA	_ppu_ctrl2_val
		EOR	#$E0
		STA	_ppu_ctrl2_val
		BMI	@paused
		LDX	#%1111
		LDA	#$FF
		STA	var_ch_PrevFreqHigh
		STA	var_ch_PrevFreqHigh+1
@paused
		STX	SND_MASTERCTRL_REG
		RTS


; =============== S U B	R O U T	I N E =======================================


special_main:
		LDA	_ppu_ctrl2_val
		BMI	spec_paused_ret
		INC	game_cnt
		
;		LDA	delay
;		BEQ	no_delay
;		DEC	delay
;check_for_jump:
;		RTS
;
;no_delay:
		LDA	spec_spd_cnt_l
		ORA	spec_spd_cnt_h
		BEQ	loc_7FCE
		DEC	spec_spd_cnt_l
		BNE	loc_7FCE
		DEC	spec_spd_cnt_h
		BNE	loc_7FCE
		LDA	#<3600
		STA	spec_spd_cnt_l
		LDA	#>3600
		STA	spec_spd_cnt_h
		
		LDA	special_speed
		CMP	#$14
		BEQ	loc_7FCE
		CLC
		ADC	#4
		STA	special_speed
		INC	speed_shoes_timer ; inc music speed
		DEC	walk_anim_speed
		LDA	#0
		STA	anim_speed_and ; inc anim speed
		
		;move.b	(special_speed).w,d0
		;subi.b	#$20,d0
		;neg.b	d0
		;add.b	d0,d0
		;addq.b	#8,d0
		;jsr	(update_music_speed).l

loc_7FCE:
		JSR	special_work_sub
		
;		JSR	check_for_jump
		LDA	win_spec_flag
		BNE	loc_803E
		LDA	_joy1_hold
		AND	#BUTTON_A|BUTTON_B
		BEQ	loc_803E
		LDA	spec_jump_flag
		BMI	loc_803E
		LDA	#1
		STA	spec_jump_flag
loc_803E:

		LDA	spec_stage_dir
		AND	#$3F
		BNE	loc_80A2
		LDA	spec_jump_flag
		EOR	#1	; CMP #1
		BNE	loc_806E
		STA	jump_time_l ; $00
		STA	spec_turn_val ; $00
		LDA	#$FF
		STA	jump_time_h
		;LDA	#$80
		STA	spec_jump_flag
		;NOP	; play SFX
		LDA	#3
		STA	sfx_to_play
	
loc_806E:	
		LDA	spec_jump_flag
		BPL	loc_80A2
		LDA	jump_inc_l
		CLC
		ADC	jump_time_l
		STA	temp0
		LDA	jump_inc_h
		ADC	jump_time_h
		BMI	loc_8088
		LDA	#0
		STA	jump_inc_l
		STA	jump_inc_h
		STA	spec_jump_flag
		BEQ	loc_80A2 ; JMP
		
loc_8088:
		; d0->jump_inc
		STA	jump_inc_h
		LDA	temp0
		STA	jump_inc_l

		LDA	special_speed
		CLC
		ADC	jump_time_l
		STA	jump_time_l
		BCC	@no_inc_h
		INC	jump_time_h
@no_inc_h:
	
loc_80A2:
		
		LDX	#max_objs-1
@no_tmp_obj
		LDA	temp_obj_type,X
		BEQ	@no_spc_obj
		JSR	blue_sphere_action
@no_spc_obj
		DEX
		BPL	@no_tmp_obj

		LDA	var_Channels
		AND	#$20
		BNE	@have_music
		LDA	current_music
		CMP	#$39	; perfect song
		BEQ	@restart_music
		CMP	#$35	; cont song
		BEQ	@restart_music
		CMP	#$2C	; life song
		BNE	@have_music
@restart_music:
		LDA	#$36	; special_stage_blue_spheres
		STA	music_to_play
		LDA	special_speed
		CMP	#$14
		BCC	@have_music
		INC	speed_shoes_timer ; inc music speed
		
@have_music
		RTS
		

; =============== S U B	R O U T	I N E =======================================
		
		
ring_action:
		LDA	#5
		STA	temp_obj_cnt,X
		;LDA	#0
		
		LDA	temp_obj_l,X
		STA	map_ptr_l
		LDA	temp_obj_h,X
		STA	map_ptr_h
		
		LDY	#0
		LDA	#0
		STA	(map_ptr_l),Y
		BNE	no_clr_ring
		JMP	loc_8CBC

no_clr_ring
		RTS
		
		
; =============== S U B	R O U T	I N E =======================================
	

blue_sphere_action:
		DEC	temp_obj_cnt,X
		BPL	locret_8C9C
		CMP	#1
		BEQ	ring_action
		
		LDA	#9
		STA	temp_obj_cnt,X
		LDA	temp_obj_l,X
		STA	map_ptr_l
		LDA	temp_obj_h,X
		STA	map_ptr_h
		
		LDY	#0
		LDA	(map_ptr_l),Y
		CMP	#2
		BNE	check_change_to_red
		UPDATE_BLUE_SPHERES_CNT
		LDA	#9
		STA	(map_ptr_l),Y
		STX	object_slot_saver
		JSR	analyze_for_create_ring
		BEQ	@restore_obj_slot
		LDX	object_slot_saver
		LDY	#0
		LDA	#4	; ring
		STA	(map_ptr_l),Y
		JMP	loc_8CBC
@restore_obj_slot:
		LDX	object_slot_saver
locret_8C9C:
		RTS


check_change_to_red:
		LDA	#0
		STA	temp_obj_cnt,X
		LDA	special_pos_x_l
		ORA	special_pos_y_l
		AND	#$E0
		BEQ	locret_8CC2
		LDA	(map_ptr_l),Y
		CMP	#9
		BNE	loc_8CBC
		LDA	#1
		STA	(map_ptr_l),Y

loc_8CBC:
		LDA	#0
		STA	temp_obj_cnt,X
		STA	temp_obj_type,X
		
locret_8CC2:
		RTS
		

analyze_for_create_ring:
		JSR	sub_8D78
		LDA	a5_mem_ptr
		BEQ	locret_8CC2	; return BEQ
		LSR	A
		STA	d6_counter
		LDY	#0	; init for a5 , new ptr
		STY	a4_mem_ptr
		
loc_8D0E:
		LDY	a4_mem_ptr
		LDA	temp_mem,Y
		STA	map_ptr_tmp_l
		INY
		LDA	temp_mem,Y
		STA	map_ptr_tmp_h
		INY
		STY	a4_mem_ptr
		
		LDY	#0
		LDX	#7	; d0
		
loc_8D1A:
		LDA	map_ptr_tmp_l
		CLC
		ADC	near_pos_l,X
		STA	map_ptr_new_l
		LDA	map_ptr_tmp_h
		ADC	near_pos_h,X
		STA	map_ptr_new_h
		LDA	(map_ptr_new_l),Y
		CMP	#2
		BNE	loc_8D34
		UPDATE_BLUE_SPHERES_CNT
		LDA	#4
		STA	(map_ptr_new_l),Y
		
		LDY	a5_mem_ptr
		LDA	map_ptr_new_l
		STA	temp_mem,Y
		INY
		LDA	map_ptr_new_h
		STA	temp_mem,Y
		INY
		STY	a5_mem_ptr
		INC	d6_counter
		LDY	#0	; fix Y
		
loc_8D34:
		DEX
		BPL	loc_8D1A
		DEC	d6_counter
		BNE	loc_8D0E
		
		LDA	a5_mem_ptr
		BEQ	locret_8D76
		LSR
		STA	d6_counter
		LDY	#0	; init for a5 , new ptr
		STY	a4_mem_ptr
		
loc_8D46:
		LDY	a4_mem_ptr
		LDA	temp_mem,Y
		STA	map_ptr_tmp_l
		INY
		LDA	temp_mem,Y
		STA	map_ptr_tmp_h
		INY
		STY	a4_mem_ptr
		
		LDY	#0
		LDX	#7	; d0
		
loc_8D52:
		LDA	map_ptr_tmp_l
		CLC
		ADC	near_pos_l,X
		STA	map_ptr_new_l
		LDA	map_ptr_tmp_h
		ADC	near_pos_h,X
		STA	map_ptr_new_h
		LDA	(map_ptr_new_l),Y
		CMP	#1
		BNE	loc_8D64
		LDA	#4
		STA	(map_ptr_new_l),Y

loc_8D64:
		DEX
		BPL	loc_8D52
		DEC	d6_counter
		BNE	loc_8D46
		;NOP	; SFX
		LDA	#4
		STA	sfx_to_play
		LDA	#1	; RETURN BNE
		
locret_8D76:
		RTS
	


sub_8D78:
		LDY	#0
		STY	a5_mem_ptr
		STY	d2_counter
		LDX	#7

loc_8D88:
		LDA	map_ptr_l
		CLC
		ADC	near_pos_l,X
		STA	map_ptr_new_l
		LDA	map_ptr_h
		ADC	near_pos_h,X
		STA	map_ptr_new_h
		
		LDA	(map_ptr_new_l),Y
		CMP	#9
		BNE	loc_8D9A
		LDA	#1
		STA	(map_ptr_new_l),Y
		
loc_8D9A:
		CMP	#2
		BNE	loc_8DA4
		INC	d2_counter
loc_8DA4:

		DEX
		BPL	loc_8D88
		
		LDA	d2_counter
		BEQ	locret_8D76
		
		LDY	#0
		STY	d2_counter
		DEC	map_ptr_h	; -$100
loc_8DB2
		INC	d2_counter
		DEY		; +$FF
		LDA	(map_ptr_l),Y
		BNE	loc_8DB2
		INC	map_ptr_h
		
		LDY	#0
loc_8DC0
		INC	d2_counter
		INY		; +$FF
		LDA	(map_ptr_l),Y
		BNE	loc_8DC0
		
		LDA	d2_counter
		CMP	#4
		BCC	locret_8D76
		
		LDY	#0
		STY	d2_counter
		LDA	map_ptr_l
		STA	map_ptr_new_l
		LDA	map_ptr_h
		STA	map_ptr_new_h
		
count_left
		INC	d2_counter
		LDA	map_ptr_new_l
		SEC
		SBC	#$20
		STA	map_ptr_new_l
		BCS	@no_dec_h
		DEC	map_ptr_new_h
@no_dec_h		
		LDA	(map_ptr_new_l),Y
		BNE	count_left
		
		LDA	map_ptr_l
		STA	map_ptr_new_l
		LDA	map_ptr_h
		STA	map_ptr_new_h
		
count_right
		INC	d2_counter
		LDA	map_ptr_new_l
		CLC
		ADC	#$20
		STA	map_ptr_new_l
		BCC	@no_inc_h
		INC	map_ptr_new_h
@no_inc_h		
		LDA	(map_ptr_new_l),Y
		BNE	count_right
		
		LDA	d2_counter
		CMP	#4
		BCS	loc_8DFA
		RTS

loc_8DFA:
		LDY	#temp_mem_bas
		STY	a4_mem_ptr
		
		LDY	#0
		STY	d3_counter
		STY	d6_counter
		
		LDX	#3	; d4
		LDA	map_ptr_l
		STA	map_ptr_new_l
		LDA	map_ptr_h
		STA	map_ptr_new_h
		
loc_8E0E:
		LDA	six_near_pos_l,X
		CLC
		ADC	map_ptr_new_l
		STA	map_ptr_tmp_l
		LDA	six_near_pos_h,X
		ADC	map_ptr_new_h
		STA	map_ptr_tmp_h
		
		LDY	#0
		LDA	(map_ptr_tmp_l),Y
		CMP	#$89
		;BEQ	loc_8E8C
		BNE	@not_89
		JMP	loc_8E8C
		
@not_89:
		CMP	#1
		BNE	loc_8E68
		LDA	d6_counter
		CMP	#2
		BCC	loc_8E48
		
		LDY	a4_mem_ptr
		LDA	map_ptr_tmp_l
		SEC
		SBC	temp_mem-6,Y
		STA	temp6
		LDA	map_ptr_tmp_h
		SBC	temp_mem-5,Y
		BEQ	compare_1_20
		CMP	#$FF
		BNE	loc_8E48
		LDA	temp6
		CMP	#$FF
		BEQ	loc_8E68
		CMP	#$E0
		BEQ	loc_8E68
		BNE	loc_8E48
compare_1_20:
		LDA	temp6
		CMP	#1
		BEQ	loc_8E68
		CMP	#$20
		BEQ	loc_8E68

loc_8E48:
		LDY	#0
		LDA	(map_ptr_new_l),Y
		ORA	#$80
		STA	(map_ptr_new_l),Y
		LDY	a4_mem_ptr
		LDA	d3_counter
		STA	temp_mem,Y
		INY
		TXA	; d4 counter
		STA	temp_mem,Y
		INY
		LDA	map_ptr_new_l
		STA	temp_mem,Y
		INY
		LDA	map_ptr_new_h
		STA	temp_mem,Y
		INY
		STY	a4_mem_ptr
		
		INC	d6_counter
		
		TXA	; d4->d3
		SEC
		SBC	#1
		AND	#3		; d3
		STA	d3_counter	; save d3
		CLC
		ADC	#2
		TAX	; d4=d3+2

		; move.w d1->d0
		LDA	map_ptr_tmp_l
		STA	map_ptr_new_l
		LDA	map_ptr_tmp_h
		STA	map_ptr_new_h
		JMP	loc_8E0E
		

loc_8E68:
		DEX
		CPX	d3_counter
		;BPL	loc_8E0E
		BMI	loc_8E6E
		JMP	loc_8E0E
		
loc_8E6E:
		LDY	a4_mem_ptr
		DEY
		LDA	temp_mem,Y
		STA	map_ptr_new_h
		DEY
		LDA	temp_mem,Y
		STA	map_ptr_new_l
		DEY
		LDA	temp_mem,Y
		TAX	; d4_counter
		DEY
		LDA	temp_mem,Y
		STA	d3_counter
		STY	a4_mem_ptr

		DEC	d6_counter
		BMI	locret_8E8A
		
		LDY	#0
		LDA	(map_ptr_new_l),Y
		AND	#$7F
		STA	(map_ptr_new_l),Y
		JMP	loc_8E68
		
locret_8E8A:
		RTS
		
loc_8E8C:
		LDA	map_ptr_l
		STA	d3_low
		SEC
		SBC	map_ptr_new_l
		STA	d2_low
		LDA	map_ptr_h
		STA	d3_high
		SBC	map_ptr_new_h
		STA	d2_high
		
		LDY	#temp_mem_bas+6
		
loc_8E9C:
		LDA	temp_mem,Y
		SEC
		SBC	d3_low
		STA	temp_low
		LDA	temp_mem+1,Y
		SBC	d3_high
		STA	temp_high
		CMP	d2_high
		BNE	loc_8EAA
		LDA	temp_low
		CMP	d2_low
		BNE	loc_8EAA
		CLC		; d3 = d3+d0
		ADC	d3_low
		STA	d3_low
		LDA	temp_high
		ADC	d3_high
		STA	d3_high
		INY
		INY
		INY
		INY
		JMP	loc_8E9C

loc_8EAA:
		LDA	temp_low
		CLC
		ADC	map_ptr_l
		STA	temp_low
		LDA	temp_high
		ADC	map_ptr_h
		STA	temp_high
		
		LDY	#0
		LDA	(temp_low),Y
		CMP	#2
		BEQ	loc_8EC8
		CMP	#4
		BEQ	loc_8ED4
			; temp_low = temp_low -d2
		LDA	temp_low
		SEC
		SBC	d2_low
		STA	temp_low
		LDA	temp_high
		SBC	d2_high
		STA	temp_high
		
		LDA	(temp_low),Y
		CMP	#2
		BNE	loc_8ED4
		
loc_8EC8:
		UPDATE_BLUE_SPHERES_CNT
		LDA	#4
		STA	(temp_low),Y
		LDY	a5_mem_ptr
		LDA	temp_low
		STA	temp_mem,Y
		INY
		LDA	temp_high
		STA	temp_mem,Y
		INY
		STY	a5_mem_ptr
loc_8ED4:		
		JMP	loc_8E68


near_pos_l:
		.BYTE	$21,$20,$1F,$01,$FF,$E1,$E0,$DF
near_pos_h:		
		.BYTE	$00,$00,$00,$00,$FF,$FF,$FF,$FF
		
		
six_near_pos_l:
		.BYTE	$FF,$E0,$01,$20,$FF,$E0
		
six_near_pos_h:
		.BYTE	$FF,$FF,$00,$00,$FF,$FF
		
	
; =============== S U B	R O U T	I N E =======================================

	
spec_dir_set:
		BIT	spec_turn_val
		BMI	turn_right
turn_left		
		CLC
		ADC	#4
		JMP	write_new_st_dir
turn_right
		SEC
		SBC	#4
write_new_st_dir:
		STA	temp0
		AND	#$F
		BNE	@chk_end
		LDA	temp0
		STA	spec_stage_dir
		STA	spec_stage_dirn
		AND	#$30
		BNE	@c1
		LDA	#$80
		STA	load_part_flag
		RTS
@c1		
		STA	load_part_flag
@chk_end
		RTS
	

; =============== S U B	R O U T	I N E =======================================


special_work_sub:
		LDA	spec_end_flag
		BEQ	loc_84A4
		CMP	#$61
		BCS	loc_8490_
		;BCC	loc_8490
		LDA	spec_stage_dir
		ADC	#4
		STA	spec_stage_dir
		INC	spec_end_flag
		JSR	turn_left
set_message_clr:
		LDA	message_timer ; clear text on special exit
		BEQ	@no_need_clr
		LDA	#1
		STA	message_timer
@no_need_clr:
		;RTS
loc_848F:
		RTS

loc_8490_:
		LDA	special_pos_x_l
		ORA	special_pos_y_l
		AND	#$E0
		BEQ	loc_84A4
		LDA	#0
		STA	spec_end_flag

loc_84A4:
		BIT	spec_stage_dir
		BVC	read_y
		LDA	special_pos_x_l
		BVS	read_x
read_y:
		LDA	special_pos_y_l
read_x:
		LDX	spec_turn_val
		BEQ	loc_84F0
		AND	#$E0
		BNE	loc_84F0
		BIT	spec_jump_flag
		BMI	loc_84FC
		TAY	; save A
		TXA
		CLC
		ADC	spec_stage_dir
		STA	spec_stage_dir
		JSR	spec_dir_set
		LDA	spec_stage_dir
		AND	#$3F
		BNE	loc_848F
		STA	spec_turn_val ; write 00
	;;	STA	bumper_hit_flg ; write 00  (no write - S3K case)
		;LDA	#20
		;STA	delay
		LDA	special_speedn
		BEQ	loc_84F0s
		LDA	#1
		STA	no_turn_flag
loc_84F0s:
		TYA	; load A
		;RTS
		
loc_84F0:
		AND	#$E0
		BEQ	loc_84FC
		LDA	#0
		STA	no_turn_flag
		
loc_84FC:
		
		LDA	special_speedn
		STA	temp0
		LDA	win_spec_flag
		BEQ	@no_win
		JMP	loc_85D4
		
@no_win		
		LDA	bumper_hit_flg
		BNE	loc_8532
		LDA	_joy1_hold
		AND	#BUTTON_UP
		BEQ	loc_851E
		STA	spec_s_mov_dir
		
loc_851E:	
		LDA	spec_s_mov_dir
		BEQ	loc_8532

		LDA	temp0
		CLC
		ADC	#2
		CMP	special_speed
		BCC	@ok
		LDA	special_speed
@ok
		STA	temp0


loc_8532:
		LDA	no_turn_flag
		BNE	loc_8550
		LDA	_joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_8544
		LDA	#4
		BNE	write_turn_val
		
loc_8544:	
		LDA	_joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	loc_8550
		LDA	#$FC
write_turn_val:
		STA	spec_turn_val

loc_8550:
		LDA	temp0
		STA	special_speedn
		LDA	bumper_hit_flg
		BEQ	loc_85D4
		LDA	special_pos_x_l
		BIT	spec_stage_dir
		BVS	loc_856A
		LDA	special_pos_y_l

loc_856A:
		AND	#$E0
		BNE	loc_85AE
		JSR	get_map_pos
		CMP	bumper_pos_h
		BNE	other_bumper
		LDA	temp0
		CMP	bumper_pos_l
		BEQ	loc_85AE
		
other_bumper:
		LDA	#0
		STA	bumper_hit_flg
		LDA	special_speed
		BIT	special_speedn
		BMI	loc_85A8
		NEG
		
loc_85A8:
		STA	special_speedn
		RTS
		
		
loc_85AE:
		LDA	special_speedn
		BNE	loc_85D2
		LDA	#1
		STA	spec_s_mov_dir
		JSR	other_bumper
		JMP	loc_85D4

loc_85D2:
		NEG
		STA	temp0
		
loc_85D4:
		LDA	temp0
		BPL	@plus
		LDA	#$FF
		BNE	@minus
@plus		
		LDA	#0
@minus		
		STA	temp1

		BIT	spec_stage_dir
		BMI	@no_sub
		BVS	@sub_X_pos
		LDA	special_pos_y_l
		SEC
		SBC	temp0
		STA	special_pos_y_l
		LDA	special_pos_y_h
		SBC	temp1
		STA	special_pos_y_h
		JMP	done_upd_pos
		
@sub_X_pos:
		LDA	special_pos_x_l
		SEC
		SBC	temp0
		STA	special_pos_x_l
		LDA	special_pos_x_h
		SBC	temp1
		STA	special_pos_x_h
		JMP	done_upd_pos
		
@no_sub
;		BIT	spec_stage_dir
		BVS	add_X_pos
		LDA	special_pos_y_l
		CLC
		ADC	temp0
		STA	special_pos_y_l
		LDA	special_pos_y_h
		ADC	temp1
		STA	special_pos_y_h
		JMP	done_upd_pos
		
add_X_pos:
		LDA	special_pos_x_l
		CLC
		ADC	temp0
		STA	special_pos_x_l
		LDA	special_pos_x_h
		ADC	temp1
		STA	special_pos_x_h

done_upd_pos:
		LDA	temp0
		ORA	temp1
		BEQ	@skipanim
		
		LDA	load_part_flag
		BNE	@skipanim
		
		INC	anim_speed
		LDA	anim_speed
		AND	anim_speed_and
		BNE	@skipanim
		LDX	temp1
		CPX	stars_mov_dir
		BEQ	@same_dir
		LDA	#$80
		STA	last_row_fix_f
		STX	stars_mov_dir
@same_dir
		LDA	stars_anim_bank
		CPX	#0
		BMI	@no_scroll
		;CLC
		ADC	#0
		AND	#$07
		BNE	@no_swap_nt
		PHA
		JSR	change_stars_pos
		JMP	@stars_nt_swapped
@no_scroll:
		;SEC
		SBC	#1
		AND	#$07
		CMP	#$07
		BNE	@no_swap_nt
		PHA
		JSR	sub_stars_pos
@stars_nt_swapped:
		JSR	swap_stars_nt
		PLA
@no_swap_nt
		ORA	#$40 ; update flag + bank $C0
		STA	stars_anim_bank
		
@skipanim	
		BIT	spec_jump_flag
		BMI	locret_866C
		LDA	win_spec_flag
		BNE	locret_866C
;		JMP	special_collisions

;locret_85FC:
;		RTS

		
; =============== S U B	R O U T	I N E =======================================


special_collisions:
		JSR	get_map_pos
		
		LDY	#0
		LDA	(map_ptr_l),Y	; get block under sonic
		BEQ	locret_866C
		;STA	temp2		; save?
		CMP	#1		; red sphere
		BNE	not_red_sphere
		LDA	special_pos_x_l
		ORA	special_pos_y_l
		AND	#$E0
		BNE	locret_866C
		LDA	spec_end_flag
		BNE	locret_866C
play_warp_music:
		INC	spec_end_flag
		LDA	#$3A	; Warp (s3) 
		STA	music_to_play
		
locret_866C
		RTS


		
not_red_sphere:
		CMP	#2
		BNE	not_blue_sphere
		JSR	get_tmp_spec_obj_adr
		BNE	@loc_8682
		LDA	#2
		STA	temp_obj_type,X
		LDA	#0
		STA	temp_obj_cnt,X
		LDA	map_ptr_l
		STA	temp_obj_l,X
		LDA	map_ptr_h
		STA	temp_obj_h,X
		
@loc_8682:
		LDA	#$12
		STA	sfx_to_play	; play sfx (blue_sphere)
		RTS
		
		
not_blue_sphere:
		CMP	#3
		BNE	not_bumper
		LDA	bumper_hit_flg
		BNE	not_a_ring
		INC	bumper_hit_flg
		LDA	map_ptr_l
		STA	bumper_pos_l
		LDA	map_ptr_h
		STA	bumper_pos_h
		LDA	#0
		STA	spec_s_mov_dir
		LDA	#$D
		STA	sfx_to_play	; play sfx (bumper)
		RTS
		
not_bumper:
		CMP	#4
		BNE	not_a_ring
		JSR	get_tmp_spec_obj_adr
		BNE	loc_86C6
		LDA	#1
		STA	temp_obj_type,X
		LDA	#0
		STA	temp_obj_cnt,X
		LDA	map_ptr_l
		STA	temp_obj_l,X
		LDA	map_ptr_h
		STA	temp_obj_h,X
		
loc_86C6:
		DEC	spec_max_rings
		BNE	loc_86D4
		LDA	#180
		STA	message_timer
		LDA	#$39	; perfect
		JSR	set_music
		
loc_86D4:
		INC	spec_rings_cnt
		LDA	#2+3
		STA	spec_rings_upd ; set update ring ui flag
		LDA	spec_rings_cnt
		CMP	#50
		BNE	not_50_rings
		INC	continues
		LDA	#$35	; continue song
		BNE	set_music
		
not_50_rings:
		CMP	#100
		BEQ	add_life
		CMP	#200
		BNE	not_200_rings
		
add_life:
		LDA	lives_sav ; player_lives
		CMP	#99
		BEQ	no_add_life
		INC	lives_sav ; player_lives
		LDA	#$2C	; extra life song
set_music:
		STA	music_to_play
		LDA	#0
		STA	speed_shoes_timer ; music speed
		RTS
		
not_200_rings:
		LDA	pulse2_sound
		CMP	#3	; ring drop sfx played
		BEQ	skip_play_ring
no_add_life:
		LDA	#2	; play sfx
		STA	sfx_to_play
skip_play_ring:
		RTS

not_a_ring:	
		RTS
		
		
; =============== S U B	R O U T	I N E =======================================

		
get_tmp_spec_obj_adr:
		LDX	#max_objs-1
@check_nx:
		LDA	temp_obj_type,X
		BEQ	@empty
		DEX
		BPL	@check_nx

@empty:
		RTS


; =============== S U B	R O U T	I N E =======================================
		
		
get_map_pos:
		LDA	special_pos_x_l
		CLC
		ADC	#$80	; get carry
		LDA	special_pos_x_h
		ADC	#0
		AND	#$1F	; get X
		STA	map_ptr_l

		LDA	special_pos_y_l
		CLC
		ADC	#$80	; get carry
		LDA	special_pos_y_h
		ADC	#0
get_map_ptr:
		AND	#$1F	; get Y
		
; Y=Y*32
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ASL	A
		ROL	map_ptr_h
		ORA	map_ptr_l	; +X
		STA	map_ptr_l	; write low byte
		
		LDA	map_ptr_h
fix_map_ptr:		
		AND	#3
		CLC
		ADC	#3		; RAM:$300
		STA	map_ptr_h	; write hi byte
		RTS
		

; =============== S U B	R O U T	I N E =======================================
		

special_win_funcs:
		CMP	#3
		BCS	loc_8AB6
		LDA	spec_win_cnt
		BNE	@no_sfx
		JSR	set_message_clr ; clear perfect msg
		LDA	#$88
		STA	_ppu_ctrl1_val ; 8x8 sprites only
		LDA	#10
		STA	sfx_to_play
@no_sfx
		CMP	#$FC
		BCS	spec_win_create_em
		INC	spec_win_cnt
		INC	spec_win_cnt
		CMP	#$3E
		BCC	locret_8A24
		INC	spec_win_cnt
		CMP	#$7F
		BCC	locret_8A24
		INC	spec_win_cnt
locret_8A24:
		RTS
		
spec_win_create_em:
		INC	win_spec_flag
		
		LDA	spec_stage_dir
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		TAX
		
		LDA	special_pos_x_h
		PHA
		CLC
		ADC	map_add_tbl_x,X
		AND	#$1F
		STA	special_pos_x_h
		
		LDA	special_pos_y_h
		PHA
		CLC
		ADC	map_add_tbl_y,X
		AND	#$1F
		STA	special_pos_y_h
		
		JSR	get_map_pos
		STA	bumper_pos_h
		LDA	map_ptr_l
		STA	bumper_pos_l
		
		PLA
		STA	special_pos_y_h
		PLA
		STA	special_pos_x_h
		
		LDA	#8
		STA	special_speedn
		LDA	#3
		STA	anim_speed_and
		LDA	#4
		STA	walk_anim_speed
		LDA	#120
		STA	spec_win_snd_c
		
		LDA	#0
		TAX
@clear_map
		STA	$300,X
		STA	$400,X
		STA	$500,X
		STA	$600,X
		INX
		BNE	@clear_map
		
		LDY	#0
		LDA	#$A
		STA	(bumper_pos_l),Y
		RTS
		
		
loc_8AB6:
		CMP	#4
		BCS	loc_8ADA
		
		LDA	#0
		STA	spec_win_cnt
		DEC	spec_win_snd_c
		BNE	locret_8AD8
		LDA	super_em_cnt
		STA	pal_update_flag
		INC	pal_update_flag
		INC	win_spec_flag
		LDA	#$2D	; chaos emerald
		STA	music_to_play

locret_8AD8:
		RTS
		
		
loc_8ADA:
		CMP	#5
		BCS	locret_8B58
		JSR	get_map_pos
		CMP	bumper_pos_h
		BNE	locret_8B58
		LDA	temp0
		CMP	bumper_pos_l
		BNE	locret_8B58
		LDA	special_pos_x_l
		ORA	special_pos_y_l
		AND	#$E0
		BNE	locret_8B58
		LDA	#7
		CMP	super_em_cnt
		BCC	@not_7_emeralds
		INC	super_em_cnt
		CMP	super_em_cnt
		BNE	@not_7_emeralds
		INC	special_or_std_lvl
@not_7_emeralds:

		INC	win_spec_flag
		;INC	spec_end_flag
		JMP	play_warp_music
		
locret_8B58:
		RTS
		
map_add_tbl_x:
		.BYTE	0
		.BYTE	$F6
		.BYTE	0
		.BYTE	10

map_add_tbl_y:		
		.BYTE	$F6
		.BYTE	0
		.BYTE	10
		.BYTE	0
		
		include	special2\draw_pos.asm
		
map1:
		incbin	special2\map_NEW_update.rle

;map2:
;		incbin	special2\turn_bkg.rle


fill_1_line:
		LDX	#32
		LDA	#$FF
@fill_ffs
		STA	PPU_DATA
		DEX
		BNE	@fill_ffs
		RTS
		
		
;load_turn_part:
		;include	special2\turn_bkg_p1_h.asm
load_turn_part_new:
		JSR	check_pal_swap
		LDA	#$26
		STA	PPU_ADDRESS
		LDA	#$00
		STA	PPU_ADDRESS

		LDA	load_part_flag
		CMP	#$20
		BCC	load_nt_22
		BNE	load_nt_67
		LDA	#$B8
		STA	chr_bkg_bank
		JMP	nametable_45
load_nt_22:
		LDA	#$B0
		STA	chr_bkg_bank
		JMP	nametable_22
load_nt_67:
		LDA	#$B4
		STA	chr_bkg_bank
		JMP	nametable_67
		
check_pal_swap:		
		LDA	spec_stage_dir
		;LDA	spec_stage_dirn
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAX
		LDA	special_pos_x_h
		EOR	special_pos_y_h
		LSR	A
		BCC	@no_tbl2
		LDA	pal_exg_tbl2,X
		BNE	@swap_pal
		BEQ	@std_pal
@no_tbl2		
		LDA	pal_exg_tbl1,X
		BEQ	@std_pal
@swap_pal:
		LDX	pal2
		LDY	pal1
		JMP	write_pal
@std_pal:
load_std_pal:
		LDX	pal1
		LDY	pal2
write_pal:
	;	LDA	#$88
	;	STA	PPU_CTRL_REG1
		LDA	#$3F
		STA	PPU_ADDRESS
		LDA	#$02
		STA	PPU_ADDRESS
		STX	PPU_DATA
		STY	PPU_DATA
		RTS

pal_exg_tbl1:
		.BYTE	$00 ; $00
		.BYTE	$00 ; $10
		.BYTE	$00 ; $20
		.BYTE	$FF ; $30
		.BYTE	$00 ; $40
		.BYTE	$FF ; $50
		.BYTE	$FF ; $60
		.BYTE	$00 ; $70
		.BYTE	$00 ; $80
		.BYTE	$00 ; $90
		.BYTE	$00 ; $A0
		.BYTE	$FF ; $B0
		.BYTE	$00 ; $C0
		.BYTE	$FF ; $D0
		.BYTE	$FF ; $E0
		.BYTE	$00 ; $F0
pal_exg_tbl2:
		.BYTE	$00 ; $00
		.BYTE	$FF ; $10
		.BYTE	$FF ; $20
		.BYTE	$00 ; $30
		.BYTE	$00 ; $40
		.BYTE	$00 ; $50
		.BYTE	$00 ; $60
		.BYTE	$FF ; $70
		.BYTE	$00 ; $80
		.BYTE	$FF ; $90
		.BYTE	$FF ; $A0
		.BYTE	$00 ; $B0
		.BYTE	$00 ; $C0
		.BYTE	$00 ; $D0
		.BYTE	$00 ; $E0
		.BYTE	$FF ; $F0
		
load_std_part:
		include	special2\map2_NEW_out_h.asm

unpack:	
		include	 special2\unpack.asm

nametable_45:
		include	special2\f3.asm
		LDX	#WAIT_TIMER2
		RTS

nametable_22:
		include	special2\f2.asm
		LDX	#WAIT_TIMER1
		RTS

nametable_67:
		include	special2\f4.asm
		LDX	#WAIT_TIMER3
		RTS
		
ldy1_sty_iny_16_bytes:
		LDY	#1
sty_iny_16_bytes:
		STY	PPU_DATA
		INY
		STY	PPU_DATA
		INY
sty_iny_14_bytes:
		REPT	14
		STY	PPU_DATA
		INY
		ENDR
		RTS

stxinx9:
		STX	PPU_DATA
		INX
stxinx8:
		STX	PPU_DATA
		INX
stxinx7:
		STX	PPU_DATA
		INX
stxinx6:
		STX	PPU_DATA
		INX
stxinx5:
		STX	PPU_DATA
		INX
		STX	PPU_DATA
		INX
		STX	PPU_DATA
		INX
		STX	PPU_DATA
		INX
		STX	PPU_DATA
		RTS

sty10:
		STY	PPU_DATA
sty9:
		STY	PPU_DATA
sty8:
		STY	PPU_DATA
sty7:
		STY	PPU_DATA
sty6:
		STY	PPU_DATA
		STY	PPU_DATA
		STY	PPU_DATA
		STY	PPU_DATA
		STY	PPU_DATA
		STY	PPU_DATA
		RTS


swap_stars_nt:
		LDA	stars_nt_num
		EOR	#1
		STA	stars_nt_num
		LDA	stars_nt_num_x4
		EOR	#4 ; $20<->24
		STA	stars_nt_num_x4
		LDA	last_row_fix_f
		ORA	#$40
		STA	last_row_fix_f
conv_rings_and_spheres_cnt:
		JSR	conv_spheres_cnt
		JMP	conv_rings_cnt
		
change_stars_pos:
		LDA	stars_pos_l
		CLC
		ADC	#32
		STA	stars_pos_l
		BCC	@no_inc_h
		INC	stars_pos_h
@no_inc_h
		RTS
		
sub_stars_pos:
		LDA	stars_pos_l
		SEC
		SBC	#32
		STA	stars_pos_l
		BCS	@no_dec_h
		DEC	stars_pos_h
@no_dec_h:
		RTS
	
init_load_stars:
		LDA	#0
		STA	1
@load_next
		JSR	load_stars_2_rows
		LDA	1
		CLC
		ADC	#1
		AND	#7
		STA	1
		BNE	@load_next
		CLV
		JSR	reload_hud
		JSR	init_hud_nt1
		LDA	#$40
		ADC	#$41
		JSR	reload_hud
		JSR	init_hud_nt1
		JMP	conv_rings_and_spheres_cnt

load_stars:
		LDA	#$20 ; base pos write
		STA	PPU_ADDRESS
		;LDA	#$20
		STA	PPU_ADDRESS
		LDA	#30 ; 15 raws
		STA	nmi_temp0 ; raws to write
		LDA	#32 ; base pos read
		TAX
		BNE	load_nx1 ; JMP
		
		
reload_stars_last_row:
		LDX	#0
		ASL	last_row_fix_f
		BCC	reload_stars_row
		LDA	stars_nt_num_x4
		BIT	stars_mov_dir
		BMI	@ok
		LDX	#8
@ok
		LDY	#32
		BNE	reload_stars_row_fix ; JMP
		
load_stars_2_rows:
		AND	#7
		BIT	stars_mov_dir
		BPL	@forward
		CLC
		ADC	#1
		AND	#7
@forward
		TAX
		LDA	update_hud_f,X
		STA	nmi_temp1
reload_stars_row:
		LDY	#64
		LDA	stars_nt_num_x4
		EOR	#4
reload_stars_row_fix:
		STY	nmi_temp2
		ORA	vram_table_h,X
		STA	PPU_ADDRESS
		LDA	vram_table_l,X
		STA	PPU_ADDRESS
		LDA	stars_rows_cnt,X
		STA	nmi_temp0
		LDA	stars_table_l,X
		CLC
		ADC	stars_pos_l
		TAY
		LDA	stars_table_h,X
		ADC	stars_pos_h
		AND	#3
		BIT	stars_mov_dir
		BPL	@forward
		PHA	; save h
		TYA
		SEC
		SBC	nmi_temp2
		TAY
		PLA	; Carry not changed
		SBC	#0
		AND	#3
@forward
		TAX
		LDA	load_nx_ptrs_l,X
		STA	nmi_temp2
		LDA	load_nx_ptrs_h,X
		STA	nmi_temp3
		TYA
		TAX ;LDA	#32 ; base pos read ; 00-512
		JMP	(nmi_temp2)
load_nx1
		CLC
		LDY	stars_data+0,X
		STY	PPU_DATA
		LDY	stars_data+1,X
		STY	PPU_DATA
		LDY	stars_data+2,X
		STY	PPU_DATA
		LDY	stars_data+3,X
		STY	PPU_DATA
		LDY	stars_data+4,X
		STY	PPU_DATA
		LDY	stars_data+5,X
		STY	PPU_DATA
		LDY	stars_data+6,X
		STY	PPU_DATA
		LDY	stars_data+7,X
		STY	PPU_DATA
		LDY	stars_data+8,X
		STY	PPU_DATA
		LDY	stars_data+9,X
		STY	PPU_DATA
		LDY	stars_data+10,X
		STY	PPU_DATA
		LDY	stars_data+11,X
		STY	PPU_DATA
		LDY	stars_data+12,X
		STY	PPU_DATA
		LDY	stars_data+13,X
		STY	PPU_DATA
		LDY	stars_data+14,X
		STY	PPU_DATA
		LDY	stars_data+15,X
		STY	PPU_DATA
		DEC	nmi_temp0
		BEQ	load_stars_done1
		ADC	#16
		TAX
		BCC	load_nx1
		
load_from2:
		CLC
load_nx2
		LDY	stars_data+0+256,X
		STY	PPU_DATA
		LDY	stars_data+1+256,X
		STY	PPU_DATA
		LDY	stars_data+2+256,X
		STY	PPU_DATA
		LDY	stars_data+3+256,X
		STY	PPU_DATA
		LDY	stars_data+4+256,X
		STY	PPU_DATA
		LDY	stars_data+5+256,X
		STY	PPU_DATA
		LDY	stars_data+6+256,X
		STY	PPU_DATA
		LDY	stars_data+7+256,X
		STY	PPU_DATA
		LDY	stars_data+8+256,X
		STY	PPU_DATA
		LDY	stars_data+9+256,X
		STY	PPU_DATA
		LDY	stars_data+10+256,X
		STY	PPU_DATA
		LDY	stars_data+11+256,X
		STY	PPU_DATA
		LDY	stars_data+12+256,X
		STY	PPU_DATA
		LDY	stars_data+13+256,X
		STY	PPU_DATA
		LDY	stars_data+14+256,X
		STY	PPU_DATA
		LDY	stars_data+15+256,X
		STY	PPU_DATA
		DEC	nmi_temp0
		BEQ	load_stars_done1
		ADC	#16
		TAX
		BCC	load_nx2
		BCS	load_from3
load_stars_done1:
		RTS
		
load_from3:
		CLC
load_nx3
		LDY	stars_data+0+512,X
		STY	PPU_DATA
		LDY	stars_data+1+512,X
		STY	PPU_DATA
		LDY	stars_data+2+512,X
		STY	PPU_DATA
		LDY	stars_data+3+512,X
		STY	PPU_DATA
		LDY	stars_data+4+512,X
		STY	PPU_DATA
		LDY	stars_data+5+512,X
		STY	PPU_DATA
		LDY	stars_data+6+512,X
		STY	PPU_DATA
		LDY	stars_data+7+512,X
		STY	PPU_DATA
		LDY	stars_data+8+512,X
		STY	PPU_DATA
		LDY	stars_data+9+512,X
		STY	PPU_DATA
		LDY	stars_data+10+512,X
		STY	PPU_DATA
		LDY	stars_data+11+512,X
		STY	PPU_DATA
		LDY	stars_data+12+512,X
		STY	PPU_DATA
		LDY	stars_data+13+512,X
		STY	PPU_DATA
		LDY	stars_data+14+512,X
		STY	PPU_DATA
		LDY	stars_data+15+512,X
		STY	PPU_DATA
		DEC	nmi_temp0
		BEQ	load_stars_done
		ADC	#16
		TAX
		BCC	load_nx3
		
load_from4:
		CLC
load_nx4
		LDY	stars_data+0+768,X
		STY	PPU_DATA
		LDY	stars_data+1+768,X
		STY	PPU_DATA
		LDY	stars_data+2+768,X
		STY	PPU_DATA
		LDY	stars_data+3+768,X
		STY	PPU_DATA
		LDY	stars_data+4+768,X
		STY	PPU_DATA
		LDY	stars_data+5+768,X
		STY	PPU_DATA
		LDY	stars_data+6+768,X
		STY	PPU_DATA
		LDY	stars_data+7+768,X
		STY	PPU_DATA
		LDY	stars_data+8+768,X
		STY	PPU_DATA
		LDY	stars_data+9+768,X
		STY	PPU_DATA
		LDY	stars_data+10+768,X
		STY	PPU_DATA
		LDY	stars_data+11+768,X
		STY	PPU_DATA
		LDY	stars_data+12+768,X
		STY	PPU_DATA
		LDY	stars_data+13+768,X
		STY	PPU_DATA
		LDY	stars_data+14+768,X
		STY	PPU_DATA
		LDY	stars_data+15+768,X
		STY	PPU_DATA
		DEC	nmi_temp0
		BEQ	load_stars_done
		ADC	#16
		TAX
		BCC	load_nx4
		JMP	load_nx1
		
load_stars_done:
		RTS
		
load_nx_ptrs_l:	.BYTE	#<load_nx1,#<load_from2,#<load_from3,#<load_from4

load_nx_ptrs_h:	.BYTE	#>load_nx1,#>load_from2,#>load_from3,#>load_from4
		
vram_table_h:
		.BYTE	$21,$20,$20,$20,$20
		.BYTE	$21,$21,$21
		.BYTE	$21
vram_table_l:
		.BYTE	$E0,$20,$60,$A0,$E0
		.BYTE	$20,$60,$A0
		.BYTE	$E0
		
stars_table_l:
		.BYTE	$C0,$00,$40,$80
		.BYTE	$C0,$00,$40,$80,$A0
stars_table_h:		
		.BYTE	$01,$00,$00,$00
		.BYTE	$00,$01,$01,$01,$01
update_hud_f:
		.BYTE	$00,$80,$C0,$00
		.BYTE	$00,$00,$00,$00,$00
stars_rows_cnt:
		.BYTE	$02,$04,$04,$04
		.BYTE	$04,$04,$04,$04,$02		
