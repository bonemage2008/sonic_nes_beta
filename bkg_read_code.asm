		org	$A000
		
; =============== S U B	R O U T	I N E =======================================


init_level_size:
		LDA	level_id
		CLC
		ADC	level_id
		ADC	level_id
		ADC	act_id
		TAY
		LDA	levels_size_tbl,Y
		STA	level_scr_length
		LDX	#0
		STX	cam_y_mults
		INX
		STA	cam_y_mults,X
		INX

loc_9A01D:
		CLC
		ADC	level_scr_length
		STA	cam_y_mults,X
		INX
		CPX	#17
		BCC	loc_9A01D
		LDY	act_id
		LDA	#0
		STA	scr_map_ptr
		STA	ring_map_ptr
		STA	level_objs_ptr
		LDA	scr_map_by_act,Y
		STA	scr_map_ptr+1
		LDA	ring_map_by_act,Y
		STA	ring_map_ptr+1
		LDA	obj_dat_by_act,Y
		STA	level_objs_ptr+1
		RTS
; End of function init_level_size

; ---------------------------------------------------------------------------
levels_size_tbl:.BYTE	30,  29,  29	; ghz
		.BYTE	15,  21,  18	; marble
		.BYTE   30,  38,  42	; spring
		.BYTE   20,  18,  25	; lab
		.BYTE   27,  27,  29	; starl
		.BYTE   28,  26,  23	; scrap
		.BYTE	 5,   5,   5	; final
		
		.BYTE	 7,   6,   9,   4 ; sms acts 1-4
		.BYTE	10,   5,   7,   4 ; sms acts 5-8

scr_map_by_act:	.BYTE $86	; act1
		.BYTE $87	; act2
		.BYTE $88	; act3
		.BYTE $8D	; act4
		.BYTE $8E	; act5
		.BYTE $8F	; act6
		.BYTE $90	; act7
		.BYTE $91	; act8
		
ring_map_by_act:.BYTE $89	; act1
		.BYTE $8A	; act2
		.BYTE $8B	; act3
		.BYTE $89	; act4
		.BYTE $89	; act5
		.BYTE $89	; act6
		.BYTE $89	; act7
		.BYTE $89	; act8
		
obj_dat_by_act:	.BYTE $8C	; act1
		.BYTE $8D	; act2
		.BYTE $8E	; act3


; =============== S U B	R O U T	I N E =======================================


backgnd_rendering:
;		LDA	water_timer	; in water flag
;		BEQ	loc_9A071
;		LDA	Frame_Cnt
;		LSR	A
;		BCC	loc_9A0AA
;
;loc_9A071:
		LDA	lock_camera_flag
		BNE	@locked_camera
		JSR	change_camera
		JMP	loc_9A07E
; ---------------------------------------------------------------------------

@locked_camera:
		JSR	change_locked_camera

loc_9A07E:
		JSR	render_scroll_H
		JSR	render_scroll_V
		JSR	update_Hscroll_pos
		JSR	update_Vscroll_pos
		LDA	sonic_X_h_new
		STA	sonic_X_h
		LDA	sonic_X_l_new
		STA	sonic_X_l
		LDA	sonic_Y_h_new
		STA	sonic_Y_h
		LDA	sonic_Y_l_new
		STA	sonic_Y_l
		LDA	camera_X_h_new
		STA	camera_X_h_old
		LDA	camera_X_l_new
		STA	camera_X_l_old
		LDA	camera_Y_h_new
		STA	camera_Y_h_old
		LDA	camera_Y_l_new
		STA	camera_Y_l_old

loc_9A0AA:
		LDA	sonic_anim_num_old
		CMP	#9
		BEQ	chr_bank_by_camera_h
		CMP	#$11
		BEQ	chr_bank_by_camera_h
		JSR	sonic_extra_rings_collision

chr_bank_by_camera_h:
		LDA	level_id
		BNE	locret_9A0CC
		LDA	capsule_func_num
		BNE	locret_9A0CC
		LDX	act_id
		LDA	ghz_bkg3_ptrs,X
		CLC
		ADC	camera_X_h_new
		TAX
		LDA	ghz_bkg3_banks1,X
		STA	chr_bkg_bank3

locret_9A0CC:
		RTS
; End of function backgnd_rendering

; ---------------------------------------------------------------------------
ghz_bkg3_ptrs:  .BYTE	 0
		.BYTE	ghz_bkg3_banks2-ghz_bkg3_banks1
		.BYTE	ghz_bkg3_banks3-ghz_bkg3_banks1
; act1
ghz_bkg3_banks1:
		.BYTE  $12, $12, $12, $12, $12,	$12, $12, $12, $12, $12, $12, $12, $12,	$12, $12, $12
		.BYTE  $12, $12, $17, $17, $17,	$12, $12, $12, $12, $12, $12, $12, $12,	$12, $12, $12
; act2
ghz_bkg3_banks2:
		.BYTE  $12, $12, $12, $12, $12,	$12, $12, $12, $12, $12, $12, $12, $12,	$12, $12, $12
		.BYTE  $17, $17, $17, $12, $12,	$12, $12, $12, $12, $12, $12, $12, $12,	$12, $12, $12
; act3
ghz_bkg3_banks3:
		.BYTE  $12, $12, $12, $12, $12,	$12, $12, $12, $12, $12, $12, $12, $12,	$12, $12, $12
		.BYTE  $12, $12, $12, $12, $12,	$17, $17, $17, $46, $46, $46, $46, $46,	$46, $46, $46


; =============== S U B	R O U T	I N E =======================================


init_level:
		LDA	#$FF
		LDX	#0
		STX	hscroll_val

loc_9A506:
		STA	rings_memory,X
		INX
		BNE	loc_9A506
		
		STX	big_ring_flag

		LDX	level_id
		LDA	lvls_bkg_prg_ids,X
		STA	level_bkg_prg
		LDY	lvls_spr_chr2_ids,X
		STY	level_spr_chr2 ; used in draw_objs_code.asm
		INY
		INY
		STY	level_spr_chr2_nx ; used in draw_objs_code.asm
		
		LDA	act_id
		ASL
		ASL
		ADC	mult12,X
		TAX
		LDA	lvls_blk_banks,X
		STA	level_blk_bank1
		LDA	lvls_blk_banks+1,X
		STA	level_blk_bank2
		LDA	lvls_blk_banks+2,X
		STA	level_blk_bank3
		LDA	lvls_blk_banks+3,X
		STA	level_blk_bank4
		
		JSR	init_level_size
		
		LDA	level_id
		ASL	A
		TAY
		LDA	lvl_base_cam_pos,Y
		STA	tmp_ptr_l
		LDA	lvl_base_cam_pos+1,Y
		STA	tmp_ptr_l+1
		LDA	#3
		LDY	demo_func_id
		CPY	#4
		BEQ	@is_cutscene
		LDA	act_id
@is_cutscene
		ASL	A
		ASL	A
		TAY
		
		LDA	checkpoint_x_h
		BEQ	@no_checkpoint
		LDA	#<checkpoint_x_h
		STA	tmp_ptr_l
		LDA	#>checkpoint_x_h
		STA	tmp_ptr_l+1
		LDY	#0
		
@no_checkpoint
		LDA	(tmp_ptr_l),Y
		STA	camera_X_h_old
		STA	camera_X_h_new
		STA	sonic_X_h
		STA	sonic_X_h_new
		
		LDA	#8
		STA	camera_X_l_old
		STA	camera_X_l_new
		
		INY
		LDA	(tmp_ptr_l),Y
		STA	sonic_x_on_scr
		CMP	#$78
		BCS	@alt_cam_pos
		LDX	sonic_X_h_new
		BEQ	@no_chg_x_l
@alt_cam_pos:
		LDX	#$80
		STX	sonic_x_on_scr
		STA	camera_X_l_old
		STA	camera_X_l_new
		STA	hscroll_val
		CLC
		ADC	#$80
@no_chg_x_l:
		STA	sonic_X_l
		STA	sonic_X_l_new
		BCC	@no_inc_sh
		INC	sonic_X_h
		INC	sonic_X_h_new
@no_inc_sh
		INY
		LDA	(tmp_ptr_l),Y
		STA	camera_Y_h_old
		STA	camera_Y_h_new
		STA	sonic_Y_h
		STA	sonic_Y_h_new
		INY
		LDA	(tmp_ptr_l),Y
		STA	camera_Y_l_old
		STA	camera_Y_l_new
		STA	vscroll_val
		CLC
		ADC	#$A0
		BCC	@no_inc_h
		ADC	#$F
		INC	sonic_Y_h
		INC	sonic_Y_h_new
@no_inc_h
		LDX	level_id
		CPX	#FINAL_ZONE
		BNE	@not_final_level
		ADC	#$1F
@not_final_level
		STA	sonic_Y_l
		STA	sonic_Y_l_new

		;LDX	level_id
		CPX	#SCRAP_BRAIN
		BNE	@not_sbz3
		LDA	act_id
		CMP	#1
		BNE	@not_act2
		;LDA	#$87
		;STA	scr_map_ptr+1
		LDA	#$86
		STA	ring_map_ptr+1
		LDA	#$70000/$2000
		BNE	@write_alt_bkg_prg
@not_act2
		CMP	#2
		BNE	@not_sbz3
		LDX	#LAB_ZONE
		LDA	#$78000/$2000
@write_alt_bkg_prg:
		STA	level_bkg_prg
		
@not_sbz3
		LDY	lvls_bkg_chr_ids,X
		STY	chr_bkg_bank1
		INY
		STY	chr_bkg_bank2
		INY
		STY	chr_bkg_bank3
		INY
		STY	chr_bkg_bank4	; bkg level animation bank
		
		STY	chr_anim_b1 ; anim bank1
		INY
		STY	chr_anim_b2 ; anim bank2
		INY
		STY	chr_anim_b3 ; anim bank3
		INY
		STY	chr_anim_b4 ; anim bank4
		
		CPY	#$92
		BNE	@not_sbz_a2
		LDA	act_id
		CMP	#1
		BNE	@not_sbz_a2
		INY	; $93
		STY	chr_bkg_bank3 ; alt chr bkg bank for sbz-2
@not_sbz_a2

		;TXA
		LDA	level_id
		ASL	A
		TAX
		LDA	lvls_cam_limits_ptrs,X
		STA	tmp_ptr_l
		LDA	lvls_cam_limits_ptrs+1,X
		STA	tmp_ptr_l+1
		LDA	act_id
		ASL	A
		ASL	A
		TAY
		LDA	(tmp_ptr_l),Y
		STA	cam_x_h_limit_l
		INY
		LDA	(tmp_ptr_l),Y
		STA	cam_x_h_limit_r
		INY
		LDA	(tmp_ptr_l),Y
		STA	cam_Y_h_limit_up
		INY
		LDA	(tmp_ptr_l),Y
		STA	cam_Y_h_limit_down
		CMP	camera_Y_h_new
		BNE	@no_need_fix
		LDA	#0
		STA	camera_Y_l_new
		STA	camera_Y_l_old
		STA	vscroll_val
		LDA	sonic_Y_l_new
		JMP	@write_sonic_y_on_scr
		
@no_need_fix
		lda	#$A0	; pos
		ldx	level_id
		cpx	#FINAL_ZONE
		bne	@write_sonic_y_on_scr
		lda	#$C0	; alt. pos
@write_sonic_y_on_scr:
		sta	sonic_y_on_scr
		
		LDA	sonic_X_l
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		LDY	sonic_Y_l
		DEY
		STY	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h
		JSR	get_block_number
		TAY
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	level_bkg_prg
		STA	MMC3_bank_data
		ELSE
		LDA	level_bkg_prg
		STA	VRC7_prg_8000
		ENDIF
		
		LDA	$8500,Y
		CMP	#$98
		BNE	@not_water
		INC	water_timer
@not_water

		LDA	sonic_X_l_new
		LSR	A
		BCC	@not_left
		LDA	#$43
		STA	sonic_attribs
@not_left

		LDA	PPU_STATUS	; PPU Status Register (R)
		LDA	ppu_ctrl1_val
		AND	#$7F
		STA	PPU_CTRL_REG1	; PPU Control Register #1 (W)
		LDA	#0
		STA	PPU_CTRL_REG2	; PPU Control Register #2 (W)
		STA	ppu_ctrl2_val
		STA	camera_X_scroll_value
		LDA	#34/2	; columns cnt
		STA	tmp_var_26
		DEC	Camera_X_h_new
		LDA	Camera_X_l_new
		SEC
		SBC	#8
		STA	Camera_X_l_new
		;STA	hscroll_val
		BCS	init_level_screen
		DEC	Camera_X_h_new

init_level_screen:
		JSR	render_scroll_LR_X2
		JSR	update_column_vram

		LDA	Camera_X_l_new
		CLC
		ADC	#8*2
		STA	Camera_X_l_new
		BCC	@no_inc_h
		INC	Camera_X_h_new
@no_inc_h
		LDA	tmp_var_26
		CMP	#7
		BEQ	@upd_snd
		CMP	#14
		BNE	@no_upd_snd
@upd_snd:
		JSR	j_sound_update
		;nop
		;nop
		;nop
@no_upd_snd:
		DEC	tmp_var_26
		BNE	init_level_screen
		
		;LDA	camera_X_l_old
		;STA	Camera_X_l_new

		LDA	camera_X_h_old
		;STA	Camera_X_h_new
		AND	#1
		STA	ppu_tilemap_mask

		LDA	ppu_ctrl1_val
		AND	#$FB	; restore auto-inc 01
		STA	PPU_CTRL_REG1

		LDA	#$FF
		STA	hscr_map_adr1_h ; flag-done
		STA	level_blk_tile1 ; $FF ring_del_tile1
		LDX	level_id
		CPX	#MARBLE
		BNE	@not_marble
		LDA	#$45
@not_marble:
		STA	level_blk_tile5 ; $FF/$45 ring_del_tile2
		
		CPX	#7
		BNE	@not_special
		LDA	#1
		STA	timer_m
@not_special
		RTS
; End of function init_level
; ---------------------------------------------------------------------------

update_column_vram:
		LDA	tilemap_adr_h_v
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

;update_attributes_column:
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
		RTS
; ---------------------------------------------------------------------------

lvls_bkg_prg_ids:
		.BYTE $D ; GHZ ; $1A000
		.BYTE $E ; MAR ; $1C000
		.BYTE $F ; SPR ; $1E000
		.BYTE $10 ; LAB ; $20000
		.BYTE $C ; STAR ; $18000
		.BYTE $3D ; SCRAP ; $7A000
		.BYTE $B ; FINAL ; $16000
		.BYTE $A ; SPECIAL ; $14000
		
lvls_spr_chr2_ids:
		.BYTE $40 ; GHZ
		.BYTE $48 ; MAR
		.BYTE $4C ; SPR
		.BYTE $50 ; LAB
		.BYTE $52 ; STAR
		.BYTE $54 ; SCRAP
		.BYTE 5 ; FINAL
		.BYTE 5 ; SPECIAL
		
lvls_bkg_chr_ids:
		.BYTE $10 ; GHZ
		.BYTE $18 ; MAR
		.BYTE $20 ; SPR
		.BYTE $28 ; LAB
		.BYTE $30 ; STAR
		.BYTE $8C ; SCRAP
		.BYTE $58 ; FINAL
		.BYTE $38 ; SPECIAL
; ---------------------------------------------------------------------------

mult12:
	.BYTE	0,12,24,36,48,60,72,84
	.BYTE	96,108,120

; ROM = NUM*$2000 + $10
	
lvls_blk_banks
	.BYTE	$00,$01,$2A,$2B ; ghz-a1
	.BYTE	$00,$01,$2A,$2B	; ghz-a2
	.BYTE	$00,$01,$2A,$2B	; ghz-a3
	
	.BYTE	$02,$03,$2C,$2D ; marb-a1
	.BYTE	$02,$03,$2C,$2D ; marb-a2
	.BYTE	$02,$03,$2C,$2D ; marb-a3
	
	.BYTE	$04,$05,$2E,$2F ; spr-a1
	.BYTE	$04,$05,$2E,$2F ; spr-a2
	.BYTE	$04,$05,$2E,$2F ; spr-a3
	
	.BYTE	$06,$07,$30,$31 ; lab-a1
	.BYTE	$06,$07,$30,$31 ; lab-a2
	.BYTE	$06,$07,$30,$31 ; lab-a3
	
	.BYTE	$08,$09,$32,$33 ; sta-a1
	.BYTE	$08,$09,$32,$33 ; sta-a2
	.BYTE	$08,$09,$32,$33 ; sta-a3

	.BYTE	$3A,$3B,$34,$35 ; scr-a1
	.BYTE	$34,$35,$3A,$3B ; scr-a2
	.BYTE	$36,$37,$30,$31 ; scr-a3

	.BYTE	$0B,$0B,$0B,$0B ; final
	.BYTE	$0B,$0B,$0B,$0B ; final
	.BYTE	$0B,$0B,$0B,$0B ; final

	.BYTE	$26,$27,$28,$29 ; bonus act1
	.BYTE	$26,$27,$28,$29 ; bonus act2
	.BYTE	$26,$27,$28,$29 ; bonus act3
	.BYTE	$26,$27,$28,$29 ; bonus act4
	.BYTE	$26,$27,$28,$29 ; bonus act5
	.BYTE	$26,$27,$28,$29 ; bonus act6
	.BYTE	$26,$27,$28,$29 ; bonus act7
	.BYTE	$26,$27,$28,$29 ; bonus act8

; ---------------------------------------------------------------------------
lvl_base_cam_pos:.WORD ghz_start_pos	; 0
		.WORD mar_start_pos	; 1
		.WORD spr_start_pos	; 2
		.WORD lab_start_pos	; 3
		.WORD slz_start_pos	; 4
		.WORD sbz_start_pos	; 5
		.WORD final_start_pos	; 6
		.WORD sms_start_pos	; 7

ghz_start_pos:
		.BYTE    0, $40,   2, $2F ; ghz1
		.BYTE    0, $40,   3, $2F ; ghz2
		.BYTE    0, $40,   2, $2B ; ghz3
		
		.BYTE    0, $40,   2, $2F ; ghz (cutscene)

mar_start_pos:
		.BYTE    0, $40,   1, $2F ; mar1
		.BYTE    0, $30,   0, $DF ; mar2
		.BYTE    0, $40,   0, $EF ; mar3
		
		.BYTE    4, $F8,   3, $00 ; mar (cutscene)

spr_start_pos:
		.BYTE    0, $40,   3, $CF ; spr1
		.BYTE    0, $40,   0, $DF ; spr2
		.BYTE    0, $20,   0, $DF ; spr3
		
		.BYTE    4, $E8,   3, $AF ; spr (cutscene)

lab_start_pos:
		;.BYTE    0, $50,   0, $20 ; lab1
		.BYTE    0, $78,   0, $10 ; lab1
		.BYTE    0, $30,   0, $90 ; lab2
		.BYTE    0, $30,   0, $90 ; lab3
		
		.BYTE    2, $F8,   0, $A0 ; lab (cutscene)

slz_start_pos:
		.BYTE    0, $30,   1, $DF ; starl1
		.BYTE    0, $40,   1, $2F ; starl2
		.BYTE    0, $40,   1, $0F ; starl3
		
		.BYTE    4, $F8,   2, $7F ; slz (cutscene)

sbz_start_pos:
		.BYTE    0, $14,   4, $1F ; scrap1
		.BYTE    0, $14,   3, $AF ; scrap2
		.BYTE   $A, $F9,   0, $00 ; scrap3
		
		.BYTE   13, $D8,   4, $A0 ; sbz (cutscene)

sms_start_pos:
		.BYTE    0, $98,   0,$80 ; sms1
		.BYTE    0, $40,   0,$80 ; sms2
		.BYTE    0, $E8,   0,$BF ; sms3
		.BYTE    0, $98,   1,$00 ; sms4
		
		.BYTE    0, $B8,   2,$1F ; sms5
		.BYTE    0, $70,   1,$20 ; sms6
		.BYTE    0, $70,   1,$8F ; sms7
		.BYTE    0, $98,   1,$00 ; sms8

final_start_pos
		.BYTE    0, $40,   1,$00 ; final


lvls_cam_limits_ptrs:.WORD ghz_cam_limits ; 0
		.WORD mar_cam_limits	; 1
		.WORD spr_cam_limits	; 2
		.WORD lab_cam_limits	; 3
		.WORD slz_cam_limits	; 4
		.WORD sbz_cam_limits	; 5
		.WORD final_cam_limits	; 6
		.WORD sms_cam_limits	; 7
		
ghz_cam_limits:	.BYTE  $FF, $1D, $FF,	4 ; ghz1
		.BYTE  $FF, $1C, $FF,	5 ; ghz2
		.BYTE  $FF, $1B, $FF,	4 ; ghz3
		
mar_cam_limits:	.BYTE  $FF,  $E, $FF,	5 ; mar1
		.BYTE  $FF, $14, $FF,	5 ; mar2
		.BYTE  $FF, $10, $FF,	6 ; mar3
		
spr_cam_limits:	.BYTE  $FF, $1D, $FF,	5 ; spr1
		.BYTE  $FF, $25, $FF,	5 ; spr2
		.BYTE  $FF, $28, $FF,	5 ; spr3
		
lab_cam_limits:	.BYTE  $FF, $12, $FF,	6 ; lab1
		.BYTE  $FF, $11, $FF,	8 ; lab2
		.BYTE  $FF, $17, $FF,   9 ; lab3
		
slz_cam_limits:	.BYTE  $FF, $1A, $FF,	7 ; starl1
		.BYTE  $FF, $1A, $FF,	7 ; starl2
		.BYTE  $FF, $1B, $FF,	7 ; starl3
sbz_cam_limits:
		.BYTE  $FF, $1A, $FF,	6 ; scrap1
		.BYTE  $FF, $19, $FF,	8 ; scrap2
		.BYTE  $FF, $16, $FF,	8 ; scrap3
		
sms_cam_limits:	.BYTE  $FF,   6, $FF,	3 ; sms1
		.BYTE  $FF,   5, $FF,	4 ; sms2
		.BYTE  $FF,   8, $FF,	2 ; sms3
		.BYTE  $FF,   3, $FF,  14 ; sms4
		
		.BYTE  $FF,   9, $FF,	3 ; sms5
		.BYTE  $FF,   4, $FF,	5 ; sms6
		.BYTE  $FF,   6, $FF,	3 ; sms7
		.BYTE  $FF,   3, $FF,  14 ; sms8
		
final_cam_limits: .BYTE  $FF,   4,   1,	  1 ; final


; =============== S U B	R O U T	I N E =======================================


ring_block_read:
		STY	tmp_var_2B
		STA	tmp_var_25
		AND	#$1F
		TAY
		LDA	ring_bit_mask,Y ; ring bit mask
		STA	tmp_ring_mask
		LDA	ring_byte_base,Y	; ring byte mask
		CLC
		ADC	ring_map_id
		TAY
		LDA	rings_memory,Y
		LDY	tmp_var_2B
		AND	tmp_ring_mask
		BNE	@nc
		LDA	tmp_var_25
		AND	#$10
		RTS

@nc
		LDA	tmp_var_25
ret_no_scroll:
		RTS


; =============== S U B	R O U T	I N E =======================================


render_scroll_H:
		SEC
		LDA	camera_X_l_new
		SBC	camera_X_l_old
		STA	camera_X_scroll_value
		LDA	camera_X_h_new
		SBC	camera_X_h_old
		BPL	loc_9AB27
		LDA	camera_X_scroll_value
		EOR	#$FF
		SEC
		ADC	#0
		ORA	#$80
		STA	camera_X_scroll_value

loc_9AB27:
		LDA	camera_X_scroll_value
		BEQ	ret_no_scroll
		LDA	camera_X_l_old
		EOR	camera_X_l_new
		AND	#$F8
		BEQ	ret_no_scroll
		;LDA	camera_X_h_old
		;STA	tmp_var_63
		;LDA	camera_X_l_old
		;STA	tmp_var_64
		;LDA	camera_Y_h_old
		;STA	tmp_var_65
		;LDA	camera_Y_l_old
		;STA	tmp_var_66
;		JMP	render_scroll_LR
; End of function render_scroll_H
; =============== S U B	R O U T	I N E =======================================


;render_scroll_LR:
;RENDER_TILEMAP_H:
		LDA	camera_X_scroll_value
		BMI	@scroll_L
		LDA	camera_X_l_old
		EOR	camera_X_l_new
		AND	#$F0
		BEQ	ret_no_scroll

@scroll_L:

render_scroll_LR_X2:
		LDA	camera_X_l_new
		AND	#$F0
		LSR	A
		LSR	A
		LSR	A
		STA	tmp_var_64
		LSR	A
		STA	tmp_var_63

		LDA	VScroll_pos_h
		STA	camera_Y_h_tmp
		LDA	VScroll_pos
		STA	camera_Y_l_tmp
		LDX	#0
		STX	ptr_to_blocks_l
		
@read_blocks_next_scr:		; read 16 blocks
		LDY	camera_Y_h_tmp
		LDA	cam_y_mults,Y	; multiply
		CLC
		ADC	camera_X_h_new
		CLC
;		ADC	scroll_dir_h
		TAY
		BIT	camera_X_scroll_value
		BMI	@scroll_left
		INY
@scroll_left
		JSR	set_screen_bank
		LDA	camera_Y_l_tmp
		AND	#$F0
		ORA	tmp_var_63
		TAY

@read_blocks:
		LDA	(ptr_to_blocks_l),Y
		CMP	#$E0
		BCC	@not_ring
		JSR	ring_block_read

@not_ring:
		STA	blocks_buff,X
		INX
		CPX	#16
		BCS	@end_read_blocks
		TYA
;		CLC
		ADC	#16
		TAY
		CMP	#240
		BCC	@read_blocks
		INC	camera_Y_h_tmp
		LDA	#0
		STA	camera_Y_l_tmp
		JMP	@read_blocks_next_scr ; JMP
		
@end_read_blocks

		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	level_bkg_prg
		STA	MMC3_bank_data
		
		ELSE
		LDA	level_bkg_prg
		STA	VRC7_prg_8000
		ENDIF

		LDX	#0
		STX	buffer_ptr
		STX	blocks_ptr
		
;raw1_and_attributes:
		LDA	VScroll_pos
		AND	#8
		BEQ	@not_last_block
		LDY	blocks_buff,X
		JMP	@start_from_low_part ; JMP
		
@not_last_block
		LDY	blocks_buff,X
		LDX	buffer_ptr
		LDA	$8000,Y
		STA	col_buffer1,X
		LDA	$8000+$100,Y
		STA	col_buffer2,X
		INX
@start_from_low_part
		LDA	$8000+$200,Y
		STA	col_buffer1,X
		LDA	$8000+$300,Y
		STA	col_buffer2,X
		INX
		STX	buffer_ptr
		INC	blocks_ptr
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr-1,X
		CPX	#15
		BNE	@not_last_block
		LDY	blocks_buff,X
		LDX	buffer_ptr
		CPX	#29
		BNE	@hs_render_attributes
		LDA	$8000,Y
		STA	col_buffer1,X
		LDA	$8000+$100,Y
		STA	col_buffer2,X
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr,X


@hs_render_attributes

		LDA	camera_X_h_new
		AND	#1
		STA	ppu_tilemap_mask
		
		EOR	#$20/4
;		EOR	scroll_dir_h
		BIT	camera_X_scroll_value
		BMI	@scroll_left2
		EOR	#1
@scroll_left2
		STA	tilemap_adr_h_v
		
		LDA	VScroll_pos
		AND	#$F8	; 8->32
		PHA
		ASL	A
		ROL	tilemap_adr_h_v
		ASL	A
		ROL	tilemap_adr_h_v
		ORA	tmp_var_64
		STA	tilemap_adr_l_v
		PLA
		LSR
		ADC	#8
		STA	tiles_to_upd_v

		LDA	tilemap_adr_h_v
		STA	tmp_var_63
		AND	#$24	; 20 or 24
		ORA	#3	; 23 or 27
		STA	scroll_H_attrib_high
		
		LDA	tilemap_adr_l_v
		LSR	tmp_var_63
		ROR	A
		LSR	tmp_var_63
		ROR	A
		AND	#7
		STA	tmp_var_64
		ORA	#$C0	; 23CX or 27CX
		STA	scroll_H_attrib_low
		
		LDA	#%11001100
		STA	attr_mask3
		LDX	#%00000011 ; left up 16x16
		LDY	#%00110000 ; left down 16x16
		LDA	camera_X_l_new
		AND	#$10
		BEQ	@other_attr_mask
		LDA	#%00110011
		STA	attr_mask3
		LDX	#%00001100 ; right up 16x16
		LDY	#%11000000 ; right down 16x16
@other_attr_mask
		STX	attr_mask1
		STY	attr_mask2
		
		LDX	#0
		STX	tmp_var_65
		LDA	tilemap_adr_h_v
		AND	#4
		BEQ	@attr_map1
		LDX	#$40
@attr_map1
		TXA
		CLC
		ADC	tmp_var_64	; 0-7 | $00-$40
		TAX
		STX	tmp_var_25
		
		LDX	#15
		LDA	VScroll_pos
		LSR
		LSR
		LSR
		LSR
		PHP
		BEQ	@ok
		STA	tmp_var_64
		TXA
		SEC
		SBC	tmp_var_64
@ok
		TAY

		PLP
		BCC	@vs_not_8
		CPY	#0
		BNE	@not_0
		LDY	#15
@not_0		
		INC	tmp_var_65
		INX
@vs_not_8
		STX	tmp_var_66 ; 15->0  | 16->1


@next_block_attribs:
		LDA	blocks_attr,Y
		INY
		CPY	tmp_var_66
		BNE	@no_res	
		LDY	tmp_var_65
@no_res
		AND	attr_mask1
		STA	tmp_var_63
		
		LDA	blocks_attr,Y
		INY
		CPY	tmp_var_66
		BNE	@no_res2
		LDY	tmp_var_65
@no_res2	
		AND	attr_mask2
		ORA	tmp_var_63
		STA	tmp_var_63
		
		LDX	tmp_var_25
		LDA	attributes_buff,X
		AND	attr_mask3
		ORA	tmp_var_63
		STA	attributes_buff,X
		PHA
		TXA
		CLC
		ADC	#8
		STA	tmp_var_25
		
		TXA
		LSR
		LSR
		LSR
		AND	#7
		TAX
		PLA
		STA	attrib_Hscrl_buff,X
		
		CPX	#7
		BNE	@next_block_attribs
		RTS


; =============== S U B	R O U T	I N E =======================================


update_Hscroll_pos:
		LDA	camera_X_scroll_value
		BMI	loc_9AB71
		CLC
		ADC	hscroll_val
write_hscroll_val:
		STA	hscroll_val
locret_9AB5D:
		RTS
; ---------------------------------------------------------------------------

loc_9AB71:
		AND	#$7F
		STA	camera_X_scroll_value
		LDA	hscroll_val
		SEC
		SBC	camera_X_scroll_value
		JMP	write_hscroll_val
; End of function update_Hscroll_pos


; =============== S U B	R O U T	I N E =======================================


render_scroll_V:
		SEC
		LDA	camera_Y_l_new
		SBC	camera_Y_l_old
		STA	camera_Y_scroll_value
		LDA	camera_Y_h_new
		SBC	camera_Y_h_old
		BPL	loc_9ABF2
		LDA	camera_Y_scroll_value
		EOR	#$FF
		SEC
		ADC	#0
		ORA	#$80
		STA	camera_Y_scroll_value

loc_9ABF2:
		LDA	camera_Y_h_new
		CMP	camera_Y_h_old
		BEQ	loc_9AC00
		LDA	camera_Y_scroll_value
		AND	#$9F
		STA	camera_Y_scroll_value

loc_9AC00:
		LDA	camera_Y_scroll_value
		BEQ	locret_9AC0D
		LDA	camera_Y_l_old
		EOR	camera_Y_l_new
		AND	#$F8
		BNE	loc_9AC0E

locret_9AC0D:
		RTS
; ---------------------------------------------------------------------------

loc_9AC0E:
;		JMP	render_scroll_UD
; =============== S U B	R O U T	I N E =======================================

;render_scroll_UD:
		LDA	Camera_X_l_new
		LSR
		AND	#$FC
		STA	tiles_to_upd	; tiles count
		LSR
		LSR
		STA	tmp_var_64
		LSR	A
		PHA	; X var for attributes
		PHP
		STA	camera_X_l_tmp
		
		LDA	Camera_X_h_new
		STA	camera_X_h_tmp

		LDA	#8		; -> $20
		STA	tmp_var_63
		LDA	VScroll_pos_old ; OLD $00-$EF
		AND	#$F8
		ASL
		ROL	tmp_var_63
		ASL
		ROL	tmp_var_63
		CLC
		ADC	tmp_var_64
		STA	tilemap_adr_l

		LDA	camera_X_h_tmp ; Camera_X_h_new
		AND	#1
		ASL
		ASL
		EOR	tmp_var_63
		STA	tilemap_adr_h
		
		LDX	#0
		STX	ptr_to_blocks_l
		
read_blocks_next_scr_v:		; read 16 blocks
;		LDA	VScroll_pos_h_old	; OLD
;		CLC
;		ADC	scroll_dir_v
;		TAY

		LDY	VScroll_pos_h_old
		BIT	camera_Y_scroll_value
		BMI	@scroll_up
		INY
@scroll_up
		
		LDA	cam_y_mults,Y	; multiply
		CLC
		ADC	camera_X_h_tmp
		TAY
		JSR	set_screen_bank
		LDA	VScroll_pos_old	; OLD
		AND	#$F0
		ORA	camera_X_l_tmp
		TAY

read_blocks_v:
		LDA	(ptr_to_blocks_l),Y
		CMP	#$E0
		BCC	@not_ring
		JSR	ring_block_read

@not_ring:
		STA	blocks_buff,X
		INX
		CPX	#16+1
		BCS	end_read_blocks_v
		INY
		TYA
		AND	#$F
		BNE	read_blocks_v
;		LDA	#0
		STA	camera_X_l_tmp
		INC	camera_X_h_tmp
		JMP	read_blocks_next_scr_v ; JMP
		
end_read_blocks_v

		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	level_bkg_prg
		STA	MMC3_bank_data
		ELSE
		LDA	level_bkg_prg
		STA	VRC7_prg_8000
		ENDIF
		
		LDX	#0
		STX	buffer_ptr
		STX	blocks_ptr
		
		LDA	VScroll_pos_old
		AND	#8
		BEQ	col1_and_attributes
		
		PLP
		BCC	@not_last_block_v
		LDY	blocks_buff,X
		BCS	@start_from_right_part ; JMP
		
@not_last_block_v
		LDY	blocks_buff,X
		LDX	buffer_ptr
		LDA	$8000+$200,Y
		STA	raw_buffer1,X
		INX
@start_from_right_part
		LDA	$8000+$100+$200,Y
		STA	raw_buffer1,X
		INX
		STX	buffer_ptr
		INC	blocks_ptr
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr-1,X
		CPX	#15+2
		BNE	@not_last_block_v
		LDY	blocks_buff,X
		LDX	buffer_ptr
		CPX	#29+4
		BNE	check_for_render_attributes
; BUG!		LDA	$8000,Y
; BUG!		STA	raw_buffer1+$200,X
		LDA	$8000+$200,Y
		STA	raw_buffer1,X
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr,X
		
check_for_render_attributes:
		BIT	camera_Y_scroll_value
		BMI	vs_render_attributes
		PLA	; X var for attributes
		RTS
		
		
col1_and_attributes
		PLP
		BCC	@not_last_block_v
		LDY	blocks_buff,X
		BCS	@start_from_right_part ; JMP
		
@not_last_block_v
		LDY	blocks_buff,X
		LDX	buffer_ptr
		LDA	$8000,Y
		STA	raw_buffer1,X
		INX
@start_from_right_part
		LDA	$8000+$100,Y
		STA	raw_buffer1,X
		INX
		STX	buffer_ptr
		INC	blocks_ptr
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr-1,X
		CPX	#15+2
		BNE	@not_last_block_v
		LDY	blocks_buff,X
		LDX	buffer_ptr
		CPX	#29+4
		BNE	vs_render_attributes
		LDA	$8000,Y
		STA	raw_buffer1,X
		LDX	blocks_ptr
		LDA	$8000+$400,Y
		STA	blocks_attr,X
		
		
vs_render_attributes
		LDA	#%11110000
		STA	attr_mask3
		LDX	#%00000011 ; left up 16x16
		LDY	#%00001100 ; right up 16x16
		LDA	VScroll_pos_old ; OLD
		AND	#$10
		BEQ	other_attr_mask_v
		LDA	#%00001111
		STA	attr_mask3
		LDX	#%00110000 ; left down 16x16
		LDY	#%11000000 ; right down 16x16
other_attr_mask_v
		STX	attr_mask1
		STY	attr_mask2
		
		LDA	VScroll_pos_old ; OLD
		LSR
		LSR
		AND	#$38
		STA	scroll_V_attrib_low
		
		LDA	tilemap_adr_h
		AND	#4
		BEQ	attr_map1_v
		LDA	#$40
attr_map1_v
		CLC
		ADC	scroll_V_attrib_low	; $8-$38 by VS | $00-$40
		STA	tmp_var_63
		
chg_cnt	= tmp_var_64
		
		PLA	; X var for attributes
		LSR
		PHP
		AND	#7		; attribute byte 0-7
		STA	chg_cnt
		CLC
		ADC	tmp_var_63
		TAX
		
		LDA	#8
		SEC
		SBC	chg_cnt
		STA	chg_cnt

		LDY	#0
		STY	tmp_var_63 ; clear attr
		PLP
		BCS	start_from_other_attr
		DEX
		
next_block_attribs_v:
		INX
		LDA	blocks_attr,Y
		INY
		AND	attr_mask1
		STA	tmp_var_63
		CPY	#17
		BEQ	skip_attr
		
start_from_other_attr:
		LDA	blocks_attr,Y
		INY
		AND	attr_mask2
		ORA	tmp_var_63
		STA	tmp_var_63
		
skip_attr:
		LDA	attributes_buff,X
		AND	attr_mask3
		ORA	tmp_var_63
		STA	attributes_buff,X
		
		CPY	#17
		BCS	end_render_attr_v
		
		DEC	chg_cnt
		BNE	next_block_attribs_v
		TXA
		EOR	#$40	; change attr buff
		SEC
		SBC	#8
		TAX
		JMP	next_block_attribs_v
		
end_render_attr_v
		RTS


; =============== S U B	R O U T	I N E =======================================


update_Vscroll_pos:
		LDA	camera_Y_scroll_value
		BMI	loc_9ACB3
		CLC
		ADC	vscroll_val
		STA	vscroll_val
		BCS	locret_9ACAA
		CMP	#$F0
		BCC	locret_9ACAA
		CLC
		ADC	#$10
loc_9ACA8:
		STA	vscroll_val
locret_9ACAA:
		RTS
; ---------------------------------------------------------------------------

loc_9ACB3:
		AND	#$1F
		STA	tmp_var_25
		LDA	vscroll_val
		SEC
		SBC	tmp_var_25
		STA	vscroll_val
		BCC	locret_9ACAA
		CMP	#$F0
		BCC	locret_9ACAA
		SEC
		SBC	#$10
		JMP	loc_9ACA8
; End of function update_Vscroll_pos


; =============== S U B	R O U T	I N E =======================================


change_camera:
		LDA	#0
		STA	sonic_x_h_on_scr
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_old
		STA	tmp_var_28
		LDA	sonic_X_h_new
		SBC	camera_X_h_old
		BPL	@no_neg
		LDA	tmp_var_28
		EOR	#$FF
		SEC
		ADC	#0
		STA	tmp_var_28

@no_neg:
		LDA	tmp_var_28
		CMP	#$70
		BCS	loc_9AD42
		LDA	#$70
		STA	sonic_x_on_scr
		LDA	sonic_X_l_new
		SEC
		SBC	sonic_x_on_scr
		STA	camera_X_l_new
		LDA	sonic_X_h_new
		SBC	#0
		STA	camera_X_h_new
		BPL	@plus
		LDA	camera_X_l_new
		EOR	#$FF
		SEC
		ADC	#0
		STA	camera_X_l_new

@plus:
		LDA	cam_x_h_limit_l
		CMP	camera_X_h_new
		BNE	loc_9AD92
		LDY	cam_x_h_limit_l
		INY
		STY	camera_X_h_new
		LDA	#0
		STA	camera_X_l_new
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_new
		STA	sonic_x_on_scr
		CMP	#$10
		BCS	loc_9AD92
		LDA	#$10
		STA	sonic_X_l_new
		STA	sonic_x_on_scr
		LDY	cam_x_h_limit_l
		INY
		STY	sonic_X_h_new
		LDA	#0
		STA	sonic_X_speed
		BEQ	loc_9AD92 ; JMP
; ---------------------------------------------------------------------------

loc_9AD42:
		CMP	#$80
		BCC	no_change_cam_X
		LDA	#$80
		STA	sonic_x_on_scr
		LDA	sonic_X_l_new
		SEC
		SBC	sonic_x_on_scr
		STA	camera_X_l_new
		LDA	sonic_X_h_new
		SBC	#0
		STA	camera_X_h_new
		BPL	@plus
		LDA	camera_X_l_new
		EOR	#$FF
		SEC
		ADC	#0
		STA	camera_X_l_new

@plus:
		LDA	cam_x_h_limit_r
		CMP	camera_X_h_new
		BNE	loc_9AD92
		STA	camera_X_h_new
		LDA	#0
		STA	camera_X_l_new
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_new
		STA	sonic_x_on_scr
		CMP	#$F0
		BCC	loc_9AD92
		LDA	#$F0
		STA	sonic_X_l_new
		STA	sonic_x_on_scr
		LDA	#0
		STA	sonic_X_speed
		BEQ	loc_9AD92 ; JMP
; ---------------------------------------------------------------------------

no_change_cam_X:
		STA	sonic_x_on_scr
		LDA	camera_X_h_old
		STA	camera_X_h_new
		LDA	camera_X_l_old
		STA	camera_X_l_new

loc_9AD92:
		LDA	joy1_hold
		AND	#BUTTON_UP
		BEQ	no_move_cam_up
		LDA	sonic_anim_num
		CMP	#$C
		BNE	no_move_cam_up
		LDA	move_cam_delay
		CMP	#30
		BCC	skip_cam_move
		LDY	#$EE
		LDA	sonic_Y_l_new
		CMP	#$E0
		BCC	@ok
		LDY	#$DE
@ok
		STY	tmp_var_2B
		SEC
		SBC	camera_Y_l_old
		CMP	tmp_var_2B
		BCS	ret_no_move
		
		LDA	camera_Y_l_old
		SEC
		SBC	#2
		STA	tmp_var_2B
		LDA	camera_Y_h_old
		SBC	#0
		CMP	cam_Y_h_limit_up
		BEQ	ret_no_move
		STA	camera_Y_h_new
		LDA	tmp_var_2B
		CMP	#$F0
		BCC	@no_fix_y
		SBC	#$10
@no_fix_y:

set_new_cam_Y:
		STA	camera_Y_l_new
		LDA	sonic_Y_h_new
		CMP	camera_Y_h_old
		BEQ	@no_fix_Y_l
		LDA	tmp_var_2B
		CLC
		ADC	#$10
		STA	tmp_var_2B
@no_fix_Y_l:
		LDA	sonic_Y_l_new
		SEC
		SBC	tmp_var_2B
		STA	sonic_y_on_scr
		LDA	sonic_Y_h_new
		SBC	camera_Y_h_new
		STA	sonic_y_h_on_scr
ret_no_move:
		INC	move_cam_delay
		BNE	@no_lim
		DEC	move_cam_delay
@no_lim
		RTS
; ---------------------------------------------------------------------------

skip_cam_move:
		INC	move_cam_delay
		BNE	@no_lim
		DEC	move_cam_delay
@no_lim
		JMP	move_cam_Y_normal
; ---------------------------------------------------------------------------

no_move_cam_up:
		LDA	joy1_hold
		AND	#BUTTON_DOWN
		BEQ	no_move_cam_down
		LDA	sonic_anim_num
		CMP	#$B
		BNE	no_move_cam_down
		LDA	move_cam_delay
		CMP	#40
		BCC	skip_cam_move
		LDA	sonic_Y_l_new
		;SEC
		SBC	camera_Y_l_old
		CMP	#$24
		BCC	ret_no_move
		
		LDA	camera_Y_l_old
		CLC
		ADC	#2
		STA	tmp_var_2B
		LDA	camera_Y_h_old
		ADC	#0
		CMP	cam_Y_h_limit_down
		BEQ	ret_no_move
		
		STA	camera_Y_h_new
		LDA	tmp_var_2B
		CMP	#$F0
		BCC	@no_fix_y
		INC	camera_Y_h_new
		ADC	#$F
@no_fix_y:
		;STA	camera_Y_l_new
		JMP	set_new_cam_Y
; ---------------------------------------------------------------------------

no_move_cam_down:
		LDA	#0
		STA	move_cam_delay

move_cam_Y_normal:
		LDA	sonic_Y_l_new
		SEC
		SBC	camera_Y_l_old
		STA	tmp_var_2B
		LDA	sonic_Y_h_new
		SBC	camera_Y_h_old
		BPL	@no_neg
		LDA	tmp_var_2B
		EOR	#$FF
		SEC
		ADC	#0
		STA	tmp_var_2B

@no_neg:
		LDA	sonic_Y_h_new
		CMP	camera_Y_h_old
		BEQ	@no_fix_Y_l
		LDA	tmp_var_2B
		SEC
		SBC	#$10
		STA	tmp_var_2B

@no_fix_Y_l:
		LDA	tmp_var_2B
		CMP	#$70
		BCS	loc_9ADF3
		STA	sonic_y_on_scr
		LDA	#$70
		SEC
		SBC	sonic_y_on_scr
		BEQ	@ok
		CMP	#7
		BCC	@no_limit
		LDA	#7
@no_limit:
		STA	tmp_var_2B
		
		LDA	sonic_y_on_scr
		CLC
		ADC	tmp_var_2B
		STA	sonic_y_on_scr
@ok		
		;LDA	#$70
		;STA	sonic_y_on_scr
		LDA	sonic_Y_l_new
		SEC
		SBC	sonic_y_on_scr
		STA	camera_Y_l_new
		LDA	sonic_Y_h_new
		SBC	#0
		STA	camera_Y_h_new
		BPL	@plus
		LDA	camera_Y_l_new
		EOR	#$FF
		SEC
		ADC	#0
		STA	camera_Y_l_new

@plus:
		LDA	cam_Y_h_limit_up
		CMP	camera_Y_h_new
		BNE	fix_camera_Y_to_240
		LDA	#0
		STA	camera_Y_h_new
		STA	camera_Y_l_new
		LDA	sonic_Y_l_new
		SEC
		SBC	camera_Y_l_new
		STA	sonic_y_on_scr
		LDA	sonic_Y_h_new
		SBC	camera_Y_h_new
		BMI	locret_9AE5D

fix_camera_Y_to_240:
		LDA	camera_Y_h_new
		CMP	sonic_Y_h_new
		BEQ	locret_9AE5D
		LDA	camera_Y_l_new
		SEC
		SBC	#$10
		STA	camera_Y_l_new

locret_9AE5D:
		RTS
; ---------------------------------------------------------------------------

loc_9ADF3:
		CMP	#$A0
		BCC	no_change_cam_Y
		STA	sonic_y_on_scr
		SBC	#$A0
		BEQ	@ok
		CMP	#7
		BCC	@no_limit
		LDA	#7
@no_limit:
		STA	tmp_var_2B
		
		LDA	sonic_y_on_scr
		SEC
		SBC	tmp_var_2B
		STA	sonic_y_on_scr
@ok
		LDA	sonic_Y_l_new
		SEC
		SBC	sonic_y_on_scr
		STA	camera_Y_l_new
		LDA	sonic_Y_h_new
		SBC	#0
		STA	camera_Y_h_new
		BPL	@plus
		LDA	camera_Y_l_new
		EOR	#$FF
		SEC
		ADC	#0
		STA	camera_Y_l_new
		LDA	camera_Y_h_new
		EOR	#$FF
		SEC
		ADC	#0
		STA	camera_Y_h_new

@plus:
		LDA	cam_Y_h_limit_down
		CMP	camera_Y_h_new
		BNE	fix_camera_Y_to_240
		STA	camera_Y_h_new
		LDA	#0
		STA	camera_Y_l_new
		LDA	sonic_Y_l_new
		SEC
		SBC	camera_Y_l_new
		STA	sonic_y_on_scr
		LDA	sonic_Y_h_new
		SBC	camera_Y_h_new
		STA	sonic_y_h_on_scr
		BNE	loc_9AE3F
		LDA	sonic_y_on_scr
		CMP	#$F0
		BCC	fix_camera_Y_to_240

loc_9AE3F:
		LDA	sonic_y_on_scr
		SEC
		SBC	#$10
		STA	sonic_y_on_scr
		BCS	@no_dec_h
		DEC	sonic_y_h_on_scr
@no_dec_h
		JMP	ouf_of_screen
; ---------------------------------------------------------------------------

no_change_cam_Y:
		STA	sonic_y_on_scr
		LDA	camera_Y_h_old
		STA	camera_Y_h_new
		LDA	camera_Y_l_old
		STA	camera_Y_l_new
		RTS
; End of function change_camera


; =============== S U B	R O U T	I N E =======================================


change_locked_camera:
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_new
		STA	sonic_x_on_scr
		LDA	sonic_X_h_new
		SBC	camera_X_h_new
		STA	sonic_x_h_on_scr ; sonic-camera
		BNE	loc_9AE99
		LDA	sonic_x_on_scr
		CMP	#$10
		BCS	loc_9AE7A
		LDA	#$10
		BNE	loc_9AE86 ; JMP
; ---------------------------------------------------------------------------

loc_9AE7A:				; sonic	lock in	camera area
		LDA	lock_move_flag
		BEQ	loc_9AE99
		LDA	sonic_x_on_scr
		CMP	#$F0
		BCC	loc_9AE99
		LDA	#$F0

loc_9AE86:
		STA	sonic_x_on_scr

		LDA	camera_X_l_new
		CLC
		ADC	sonic_x_on_scr
		STA	sonic_X_l_new
		LDA	camera_X_h_new
		ADC	#0
		STA	sonic_X_h_new
		LDA	#0
		STA	sonic_X_speed

loc_9AE99:
		LDA	sonic_Y_l_new
		SEC
		SBC	camera_Y_l_new
		STA	sonic_y_on_scr
		LDA	sonic_Y_h_new
		SBC	camera_Y_h_new
		STA	sonic_y_h_on_scr ; sonic-camera
		LDA	sonic_Y_h_new
		CMP	camera_Y_h_new
		BEQ	@loc_9AEB9

		LDA	sonic_y_h_on_scr
		BPL	@loc_9B672
		LDA	sonic_y_on_scr
		CLC
		ADC	#$10
		STA	sonic_y_on_scr
		BCC	@locret_9B671
		INC	sonic_y_h_on_scr

@locret_9B671:
		RTS
; ---------------------------------------------------------------------------

@loc_9B672:
		LDA	sonic_y_on_scr
		SEC
		SBC	#$10
		STA	sonic_y_on_scr
		LDA	sonic_y_h_on_scr
		SBC	#0
		STA	sonic_y_h_on_scr
		EOR	#1
		BNE	@locret_9B671
		;LDA	#0
		LDX	level_id
		CPX	#FINAL_ZONE
		BEQ	@sonic_death_cam_hack
		STA	capsule_func_num		
		STA	boss_func_num
		BNE	@sonic_death_cam_hack ; JMP
; ---------------------------------------------------------------------------

@loc_9AEB9:				; sonic-camera
		LDA	sonic_y_h_on_scr
		EOR	#1
		BNE	locret_9AEE7

@sonic_death_cam_hack:
		JSR	clear_all_objects
		LDA	sonic_anim_num_old
		CMP	#$11	; drowning anim
		BEQ	locret_9AEE7

ouf_of_screen:
		LDA	#9	; death anim
		CMP	sonic_anim_num_old
		BEQ	locret_9AEE7
		JMP	sonic_set_death ; in main_code.asm
locret_9AEE7:
		RTS
; End of function change_locked_camera


; =============== S U B	R O U T	I N E =======================================


sonic_extra_rings_collision:
		LDA	sonic_X_l_new
		STA	tmp_var_64
		LDA	sonic_X_h_new
		STA	tmp_var_63
		LDA	round_walk_spr_add
		CMP	#$25
		BEQ	@inverted_v
		CMP	#$19
		BNE	loc_9AF11
		LDA	sonic_rwalk_attr
		BPL	loc_9AF11
@inverted_v:
		LDA	sonic_Y_h_new
		STA	tmp_var_65
		LDA	sonic_Y_l_new
		CLC
		ADC	#$10
		STA	tmp_var_66
		CMP	#$F0
		BCC	loc_9AF29
		;LDA	sonic_Y_l_new
		;CLC
		ADC	#$F	; check
		STA	tmp_var_66
		INC	tmp_var_65
		JMP	loc_9AF29
; ---------------------------------------------------------------------------

loc_9AF11:
		LDA	Frame_Cnt
		LSR	A	; 50/50 CLC/SEC	- fix for Lab zone & Marble zone
		LDA	sonic_Y_l_new
		;SEC
		SBC	#$10
		STA	tmp_var_66
		LDA	sonic_Y_h_new
		SBC	#0
		STA	tmp_var_65
		CMP	sonic_Y_h_new
		BEQ	loc_9AF29
		LDA	tmp_var_66	; check
		SEC
		SBC	#$10
		STA	tmp_var_66

loc_9AF29:
		JSR	get_block_number
		CMP	#$E0
		BCC	locret_9AEE7
		STA	block_number
		JMP	check_ring_collected
; End of function sonic_extra_rings_collision
; ---------------------------------------------------------------------------
