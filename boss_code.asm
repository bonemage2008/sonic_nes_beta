BOSS4_SCROLL_SPEED = $58 ; $40 = 0,25 , $80 = 0,5, $FF = 0.99 pix/frame)




		MACRO	hide_obj_sprite
		LDA	#$6F	; put sprite out of screen
		STA	objects_Y_relative_h,Y	
		ENDM

; =============== S U B	R O U T	I N E =======================================

		align	256
boss_funcs:
		JSR	boss_scripts
		LDX	level_id
		CPX	#FINAL_ZONE
		BEQ	@not_boss_wpn
		JSR	boss_upd_pos
		LDA	boss_vars
		BEQ	@not_boss_wpn
		LDX	level_id
		BNE	@not_boss_wpn
		JSR	boss1_wpn_upd_pos

@not_boss_wpn:
		LDA	boss_get_hit_timer
		BEQ	locret_51617
		DEC	boss_get_hit_timer
		LDX	level_id
		CPX	#STAR_LIGHT
		BNE	@not_starl
		LDA	boss_anim_num
		CMP	#1
		BEQ	locret_51617 ; no_set_anim5 (fix-hack)
@not_starl:
		LDA	#5
		STA	boss_anim_num
locret_51617:
		RTS
; End of function boss_funcs


; =============== S U B	R O U T	I N E =======================================


boss_scripts:
		LDX	level_id
		LDA	boss_ptrs_tbl_l,X
		STA	temp_ptr_l
		;LDA	boss_ptrs_tbl_h,X
		LDA	#>(boss1_funcs_ptrs)
		STA	temp_ptr_l+1
		;LDA	boss_func_num ; in main.asm
		;ASL	A 	; in main.asm
		;TAY 		; in main.asm
		JMP	jump_from_ptr
; End of function boss_scripts
; ---------------------------------------------------------------------------

boss_ptrs_tbl_l:
		.BYTE	<boss1_funcs_ptrs-2,<boss2_funcs_ptrs-2,<boss3_funcs_ptrs-2,<boss4_funcs_ptrs-2,<boss5_funcs_ptrs-2
		.BYTE	<boss5_funcs_ptrs-2,<boss7_funcs_ptrs-2
;boss_ptrs_tbl_h:
;		.BYTE	>boss1_funcs_ptrs-2,>boss2_funcs_ptrs-2,>boss3_funcs_ptrs-2,>boss4_funcs_ptrs-2,>boss5_funcs_ptrs-2
;		.BYTE	>boss5_funcs_ptrs-2,>boss7_funcs_ptrs-2
; ---------------------------------------------------------------------------
boss1_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD boss_wait_pos	; 1
		.WORD boss_init		; 2
		.WORD boss_wait_move	; 3
		.WORD boss_move_actions	; 4
		.WORD boss1_func_05	; 5
		.WORD boss1_func_06	; 6
		.WORD boss1_func_07	; 7
		.WORD boss1_func_08	; 8
		.WORD boss_set_explode	; 9
		.WORD boss_run_exp_anim	; 10
		.WORD boss_move_actions	; 11
		.WORD boss_create_capsule ; 12
; ---------------------------------------------------------------------------
boss2_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD boss_wait_pos	; 1
		.WORD boss_init		; 2
		.WORD boss_wait_move	; 3
		.WORD boss_move_actions	; 4
		.WORD boss2_func_05	; 5
		.WORD boss2_func_06	; 6
		.WORD boss_set_explode	; 7
		.WORD boss_run_exp_anim	; 8
		.WORD boss_move_actions	; 9
		.WORD boss_create_capsule ; 10
; ---------------------------------------------------------------------------
boss3_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD boss3_init_blocks	; 1
		.WORD boss_wait_pos	; 2
		.WORD boss_init		; 3
		.WORD boss_wait_move	; 4
		.WORD boss3_init2	; 5
		.WORD boss3_func_06	; 6
		.WORD boss_set_explode	; 7
		.WORD boss_run_exp_anim	; 8
		.WORD boss_move_actions	; 9
		.WORD boss_create_capsule ; 10
; ---------------------------------------------------------------------------
boss4_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD inc_boss_func	; 1
		.WORD boss_init		; 2
		.WORD boss4_wait_pos2	; 3
		.WORD inc_boss_func	; 4
		.WORD boss4_func_05	; 5
		.WORD boss_set_explode	; 6
		.WORD boss_run_exp_anim	; 7
		.WORD boss_move_actions	; 8
		.WORD boss_create_capsule ; 9
; ---------------------------------------------------------------------------
boss5_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD boss_wait_pos	; 1
		.WORD boss_init		; 2
		.WORD boss_wait_move	; 3
		.WORD boss_move_actions	; 4
		.WORD boss5_func_05	; 5
		.WORD boss5_func_06	; 6
		.WORD boss_set_explode	; 7
		.WORD boss_run_exp_anim	; 8
		.WORD boss_move_actions	; 9
		.WORD boss_create_capsule ; 10
; ---------------------------------------------------------------------------
boss7_funcs_ptrs:;.WORD locret_51617	 ; 0
		.WORD boss7_init	; 1
		.WORD boss_wait_move	; 2
		.WORD inc_boss_func	; 3
		.WORD boss7_func_04	; 4
		.WORD boss7_func_05	; 5
		.WORD boss7_func_06	; 6
		

; =============== S U B	R O U T	I N E =======================================


boss3_init_blocks:
		INC	boss_func_num
		LDY	objects_cnt
		LDX	#0
		STX	boss_var_D1
@load:
		LDA	tbl_mult_32,X
		STA	objects_X_l,Y
		LDA	#$27
		STA	objects_X_h,Y
		LDA	#$90
		STA	objects_Y_l,Y
		LDA	#4
		STA	objects_Y_h,Y
		LDA	#$67
		STA	objects_type,Y
		TXA	; $00-07
		STA	objects_var_cnt,Y
		hide_obj_sprite
		INY
		INX
		CPX	#8
		BCC	@load
		STY	objects_cnt
		RTS
; End of function boss3_init1

; ---------------------------------------------------------------------------
tbl_mult_32:	.BYTE	 0, $20, $40, $60, $80,	$A0, $C0, $E0


; =============== S U B	R O U T	I N E =======================================


boss_init:
		LDA	#$29
		STA	music_to_play
		INC	boss_func_num
boss7_init2:
		LDX	level_id
		;LDA	boss_x_l_tbl,X
		LDA	#$00
		STA	boss_var_BE
		LDA	boss_x_h_tbl,X
		STA	boss_var_BF
		LDA	boss_y_l_tbl,X
		STA	boss_var_C0
		LDA	boss_y_h_tbl,X
		STA	boss_var_C1
		JSR	reinit_boss_pos
		LDY	#7
		LDA	#0

@clr_boss_vars:
		STA	boss_vars,Y
		DEY
		BPL	@clr_boss_vars
		LDA	boss_lives_tbl,X
		STA	boss_life
		LDA	#2
		STA	boss_anim_num
		LDA	#0
		STA	boss_invic_flag
		STA	boss_get_hit_timer
		LDA	#1
		STA	lock_camera_flag
		STA	lock_move_flag	; sonic	lock in	camera area
		RTS
; End of function boss_init

; ---------------------------------------------------------------------------
;boss_x_l_tbl:	.BYTE $00,$00,$00,$00,$00,$00,$00
boss_x_h_tbl:	.BYTE $1A,$0F,$27,$15,$1A,$1A,$02
boss_y_l_tbl:	.BYTE $00,$00,$00,$02,$E0,$E0,$00
boss_y_h_tbl:	.BYTE $03,$02,$04,$02,$01,$01,$01
boss_x_l_table:	.BYTE $68,$10,$D0,$80,$10,$90,$10
boss_x_h_table:	.BYTE $1A,$10,$27,$16,$1B,$03,$03
boss_y_l_table:	.BYTE $A0,$10,$A0,$20,$00,$80,$10
boss_y_h_table:	.BYTE $02,$02,$03,$02,$02,$01,$02

boss_lives_tbl:	.BYTE  9, 9, 9, 10, 7, 9, 10

; =============== S U B	R O U T	I N E =======================================


;boss4_wait_pos:
;		LDA	sonic_Y_h_new
;		CMP	#7
;		BEQ	inc_boss_func
;		RTS


; =============== S U B	R O U T	I N E =======================================


boss_wait_pos:
		LDA	sonic_X_h_new
		CMP	boss_x_pos_tbl,X
		BNE	locret_516B8
		LDA	sonic_X_l_new
		CMP	#$10
		BCC	locret_516B8

boss_palette_load:
		JSR	setup_palette_buff
		LDA	#$F
		STA	palette_buff+25
		LDA	#$10
		STA	palette_buff+26
		LDA	#$30
		STA	palette_buff+27

load_boss_chr:
		LDA	boss_chrs_tbl,X
		STA	chr_spr_bank2

inc_boss_func:
		INC	boss_func_num

locret_516B8:
		RTS
; End of function boss_wait_pos
; ---------------------------------------------------------------------------
boss_x_pos_tbl:
		.BYTE  $1A, $0F, $27, $15, $1A

; ---------------------------------------------------------------------------
boss_chrs_tbl:	.BYTE  $E0, $E2, $E0, $E0, $E4, $E8, $FC

; =============== S U B	R O U T	I N E =======================================


boss4_wait_pos2:
		JSR	boss4_sonic_Y_chk
; ---------------------------------------------------------------------------
		LDA	boss_flip_flag
		ADC	#BOSS4_SCROLL_SPEED
		STA	boss_flip_flag
		BCS	loc_6969A
;loc_69693:
;		LDA	Frame_Cnt
;		AND	#3
;		BEQ	loc_6969A
		RTS
; ---------------------------------------------------------------------------

loc_6969A:

boss_wait_move:
		LDY	#0
		LDA	camera_X_l_new
		SEC
		SBC	boss_var_BE
		STA	tmp_var_64
		LDA	camera_X_h_new
		SBC	boss_var_BF
		BPL	loc_516D3
		;LDY	#1
		INY
		BNE	loc_516D9 ; JMP

loc_516D3:
		LDA	tmp_var_64
		BEQ	loc_516D9
		;LDY	#$FF
		DEY

loc_516D9:
		STY	tmp_var_25
		LDY	#0
		CPX	#LAB_ZONE
		BNE	@not_lab_zone
		LDA	camera_Y_h_new
		CMP	boss_var_C1
		BNE	loc_696C6
		LDA	camera_Y_l_new
		BNE	loc_696C6
		BEQ	loc_516F4 ; JMP	
		
@not_lab_zone:
		LDA	camera_Y_l_new
		SEC
		SBC	boss_var_C0
		STA	tmp_var_66
		LDA	camera_Y_h_new
		SBC	boss_var_C1
		BPL	loc_516EE
		;LDY	#1
		INY
		BNE	loc_516F4 ; JMP

loc_516EE:
		LDA	tmp_var_66
		BEQ	loc_516F4
loc_696C6:
		;LDY	#$FF
		DEY

loc_516F4:
		STY	tmp_var_26
		
		LDA	camera_X_l_new
		CLC
		ADC	tmp_var_25
		STA	camera_X_l_new
		LDA	tmp_var_25
		BMI	loc_51708
		LDA	camera_X_h_new
		ADC	#0
		JMP	loc_5170C
; ---------------------------------------------------------------------------

loc_51708:
		LDA	camera_X_h_new
		SBC	#0

loc_5170C:
		STA	camera_X_h_new
		LDA	tmp_var_26
		CLC
		ADC	camera_Y_l_new
		STA	camera_Y_l_new
		CMP	#$F0
		BCC	loc_51738
		LDA	tmp_var_26
		BMI	loc_5172B
		LDA	camera_Y_l_new
		CLC
		ADC	#$10
		STA	camera_Y_l_new
		INC	camera_Y_h_new
		JMP	loc_51738
; ---------------------------------------------------------------------------

loc_5172B:
		LDA	camera_Y_l_new
		SEC
		SBC	#$10
		STA	camera_Y_l_new
		DEC	camera_Y_h_new

loc_51738:
		LDA	tmp_var_25
		ORA	tmp_var_26
		BNE	locret_5176A
		LDY	#0
		JSR	next_boss_anim
		CPX	#MARBLE
		BNE	@not_marble
		JSR	boss2_splash_init
@not_marble:
		CPX	#LAB_ZONE
		BNE	@not_lab
		JSR	clear_all_objects
		LDA	#1
		STA	boss_anim_num
		STA	boss_invic_flag
		JSR	boss_palette_load
@not_lab:
		LDA	#$7E
		STA	boss_X_h_relative ; hide hack (final boss fix)
reinit_boss_pos:
		LDX	level_id
load_boss_pos:
		LDA	boss_x_l_table,X
		STA	boss_x_l
		LDA	boss_x_h_table,X
		STA	boss_x_h
		LDA	boss_y_l_table,X
		STA	boss_y_l
		LDA	boss_y_h_table,X
		STA	boss_y_h
locret_5176A:
		RTS
; End of function boss_wait_move


; =============== S U B	R O U T	I N E =======================================


boss3_init2:
		LDY	#0
		STY	boss_sub_func_id
		
next_boss_anim:
		INC	boss_func_num
set_boss_anim:
		LDX	level_id
		LDA	boss_anim_ptrs_l,X
		STA	tmp_ptr_l
		LDA	boss_anim_ptrs_h,X
		STA	tmp_ptr_l+1
		
		LDA	(tmp_ptr_l),Y
		STA	boss_act_ptr_l
		INY
		LDA	(tmp_ptr_l),Y
		STA	boss_act_ptr_h
		LDA	#0
		STA	boss_act_var_cnt
		STA	boss_act_pos
		RTS
		
		
; =============== S U B	R O U T	I N E =======================================

boss5_func_05:
boss2_func_05:
		LDA	#0
		STA	boss_sub_func_id
		LDY	#1*2
		BNE	next_boss_anim
; End of function boss2_func_05


; =============== S U B	R O U T	I N E =======================================


boss2_func_06:
		LDA	boss_sub_func_id
		LSR	A
		BCS	eggman_drop_fire
		JMP	boss_move_actions
; ---------------------------------------------------------------------------

eggman_drop_fire:
		AND	#1
		TAX
		LDY	objects_cnt
		LDA	#$61		; eggman drop fire 1
		STA	objects_type,Y
		LDA	boss2_fire_x_l,X
		STA	objects_X_l,Y
		LDA	boss_x_h
		STA	objects_X_h,Y
		LDA	#$40
		STA	objects_Y_l,Y
		LDA	boss_y_h
		STA	objects_Y_h,Y
		LDA	#0
		STA	objects_var_cnt,Y ; var/counter
		LDA	#$10
		STA	sfx_to_play
		hide_obj_sprite
		INY
		STY	objects_cnt
		LDY	boss2_anim_by_dir,X
		INC	boss_sub_func_id
		JMP	set_boss_anim
; End of function boss2_func_06
; ---------------------------------------------------------------------------
boss2_fire_x_l:	.BYTE	$20
		.BYTE	$D8
boss2_anim_by_dir:.BYTE	$02*2
		.BYTE	$01*2


; =============== S U B	R O U T	I N E =======================================


boss2_splash_init:
		LDY	objects_cnt
		LDA	#$64
		STA	objects_type,Y
		LDA	#$7C
		STA	objects_X_l,Y
		LDA	#$F
		STA	objects_X_h,Y
		LDA	#$D0
		STA	objects_Y_l,Y
		LDA	#2
		STA	objects_Y_h,Y
		LDA	#0
		STA	objects_var_cnt,Y
		hide_obj_sprite
		INY
		STY	objects_cnt
		RTS
; End of function boss2_splash_init


; =============== S U B	R O U T	I N E =======================================


boss3_func_06:
		LDA	boss_sub_func_id
		JSR	jump_by_jmptable
; End of function boss3_func_06

; ---------------------------------------------------------------------------
boss3_subfuncs_ptrs:.WORD boss_move_actions
		.WORD boss3_subfunc_01
		.WORD boss_move_actions
		.WORD boss3_subfunc_03a
		.WORD boss3_subfunc_03
		.WORD boss_move_actions
		.WORD boss3_subfunc_05


; =============== S U B	R O U T	I N E =======================================


boss3_subfunc_01:
		JSR	reinit_boss_pos
		LDA	sonic_x_on_scr
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		STA	boss_vars
		TAX
		LDA	boss3_positions,X
		STA	boss_x_l
		INC	boss_sub_func_id
		LDY	#1*2
		JMP	set_boss_anim
; End of function boss3_subfunc_01

; ---------------------------------------------------------------------------

boss3_positions: .BYTE $01 ,$18, $38, $58, $78, $98, $B8, $D8


; =============== S U B	R O U T	I N E =======================================


boss3_subfunc_03a:
		LDX	boss_vars
		LDA	boss_var_D1
		AND	bitfield,X
		BNE	@skip
		LDY	objects_cnt
		LDA	#$6B
		STA	objects_type,Y
		LDA	tbl_mult_32,X
		STA	objects_X_l,Y
		LDA	#$27
		STA	objects_X_h,Y
		LDA	#$90
		STA	objects_Y_l,Y
		LDA	#4
		STA	objects_Y_h,Y
		hide_obj_sprite
		INY
		STY	objects_cnt
@skip:
		INC	boss_sub_func_id
		RTS


; =============== S U B	R O U T	I N E =======================================


boss3_subfunc_03:
		LDX	boss_vars
		LDA	boss_var_D1
		ORA	bitfield,X
		STA	boss_var_D1
		TXA
		ASL	A
		ASL	A
		ORA	#$40
		STA	blocks_vram_l
		ADC	#2
		STA	blocks_vram_l+3
		ADC	#$40
		STA	blocks_vram_l+9
		SBC	#1
		STA	blocks_vram_l+6
		LDA	#$FF
		STA	blocks_vram_m
		STA	blocks_vram_m+3
		STA	blocks_vram_m+6
		STA	blocks_vram_m+9
		LDA	#$26
		STA	blocks_vram_h
		STA	blocks_vram_h+3
		STA	blocks_vram_h+6
		STA	blocks_vram_h+9
		INC	boss_sub_func_id
		LDY	#4*2
		JMP	set_boss_anim
; End of function boss3_block_delete


; =============== S U B	R O U T	I N E =======================================


boss3_subfunc_05:
		JSR	reinit_boss_pos
		;LDA	Frame_Cnt
		;JSR	Random_256
		LDA	sonic_X_l
		AND	#1
		TAX
		LDA	boss3_new_x_l,X
		STA	boss_x_l
		LDA	#0
		STA	boss_sub_func_id
		LDY	boss3_anim_by_dir,X
		JMP	set_boss_anim
; End of function boss3_subfunc_05
; ---------------------------------------------------------------------------
boss3_new_x_l:	.BYTE	$D0
		.BYTE	$01 ; x_low left corner
		 
boss3_anim_by_dir:.BYTE	$00
		  .BYTE	$03*2


; =============== S U B	R O U T	I N E =======================================


boss4_func_05:
		JSR	boss4_camera_move
		LDA	sonic_X_h_new
		CMP	boss_x_h
		BNE	locret_69767
		LDA	sonic_X_l_new
		CMP	#$20
		BCC	locret_69767
		LDA	camera_X_l_new
		CMP	#$E0
		BCC	locret_69767
		LDA	#1
		STA	lock_move_flag	; sonic	lock in	camera area
		INC	boss_func_num

locret_69767:
		RTS
; End of function boss4_func_05


; =============== S U B	R O U T	I N E =======================================


boss5_func_06:
		LDA	boss_sub_func_id
		JSR	jump_by_jmptable
; End of function boss3_func_06

; ---------------------------------------------------------------------------
boss5_subfuncs_ptrs:.WORD boss_move_actions
		.WORD boss5_subfunc_01
		.WORD boss_move_actions
		.WORD boss5_subfunc_03
		.WORD boss_move_actions
		.WORD boss5_subfunc_05
		.WORD boss_move_actions
		.WORD boss5_subfunc_07
; ---------------------------------------------------------------------------

boss5_subfunc_01:
		LDX	#0
		JSR	boss5_shoot
		LDY	#5*2
set_boss5_anim:
		INC	boss_sub_func_id
		JMP	set_boss_anim
; ---------------------------------------------------------------------------

boss5_subfunc_03:
		LDX	#1
		JSR	boss5_shoot
		LDY	#2*2
		BNE	set_boss5_anim
; ---------------------------------------------------------------------------

boss5_subfunc_05:
		;LDX	#2
		;JSR	boss5_shoot
		LDY	#3*2
		BNE	set_boss5_anim
; ---------------------------------------------------------------------------

boss5_subfunc_07:
		LDA	#0
		STA	boss_sub_func_id
		LDY	#1*2
		JMP	set_boss_anim
; End of function boss5_func_06


; =============== S U B	R O U T	I N E =======================================


boss5_shoot:
		LDA	#$16
		STA	sfx_to_play
		
		LDY	objects_cnt
		LDA	#$8E
		STA	objects_var_cnt,Y
		STA	objects_var_cnt+2,Y
		LDA	#$E
		STA	objects_var_cnt+1,Y
		STA	objects_var_cnt+3,Y
		LDA	boss5_fire1_x_l,X
		STA	objects_X_l,Y
		STA	objects_X_l+2,Y
		LDA	boss5_fire2_x_l,X
		STA	objects_X_l+1,Y
		STA	objects_X_l+3,Y
		TXA
		BNE	@skip
		LDA	#$65
		STA	objects_type,Y
		STA	objects_type+1,Y
@skip:
		LDA	#$66
		STA	objects_type+2,Y
		STA	objects_type+3,Y
		
		LDX	#3
@create_boss5_wpn:
		LDA	#$1A
		STA	objects_X_h,Y
		LDA	#$40
		STA	objects_Y_l,Y
		LDA	#2
		STA	objects_Y_h,Y
		hide_obj_sprite
		INY
		DEX
		BPL	@create_boss5_wpn
		STY	objects_cnt
		RTS
; End of function boss5_shoot
; ---------------------------------------------------------------------------
boss5_fire1_x_l:.BYTE	$98,$58
boss5_fire2_x_l:.BYTE	$A0,$60


; =============== S U B	R O U T	I N E =======================================


boss_set_explode:
		INC	boss_func_num
		LDA	#2
		STA	level_finish_func_cnt
		LDX	level_id
		LDA	music_by_level,X
		STA	music_to_play

boss_explosion:
		LDY	objects_cnt
		LDA	boss_x_l
		STA	objects_X_l,Y
		LDA	boss_x_h
		STA	objects_X_h,Y
		LDA	boss_y_l
		CLC
		ADC	#8
		STA	objects_Y_l,Y
		LDA	boss_y_h
		JMP	explosion_create ; in obj_code.asm
; End of function boss_set_explode


; =============== S U B	R O U T	I N E =======================================


boss_run_exp_anim:
		LDA	frame_cnt_for_1sec
		BNE	locret_517BC
		DEC	level_finish_func_cnt
		BNE	locret_517BC
		LDX	level_id
		LDY	exp_anim_by_lvl,X
		JMP	next_boss_anim
; End of function boss_run_exp_anim

; ---------------------------------------------------------------------------
exp_anim_by_lvl:
		.BYTE	$04*2
		.BYTE	$03*2
		.BYTE	$02*2
		.BYTE	$03*2
		.BYTE	$04*2


; =============== S U B	R O U T	I N E =======================================


boss_create_capsule:
		LDA	#0
		STA	boss_func_num
		STA	lock_move_flag	; sonic	lock in	camera area
		INC	capsule_func_num ; 1
		LDX	level_id
		;LDA	music_by_level,X
		;STA	music_to_play
		LDA	#$7C
		STA	capsule_pos_x_l
		LDA	capsule_x_h_tbl,X
		STA	capsule_pos_x_h
		LDA	capsule_y_l_tbl,X
		STA	capsule_pos_y_l
		LDA	capsule_y_h_tbl,X
		STA	capsule_pos_y_h
		
		LDA	big_ring_flag
		BNE	@no_big_ring

;		LDA	level_id
;		CMP	#SPEC_STAGE
;		BEQ	@no_big_ring

		LDA	rings_100s
		BNE	@ok
		LDA	rings_10s
		CMP	#5		; compare for 50 rings
		BCC	@no_big_ring

@ok:
		LDY	objects_cnt
;		CPY	#$17	; fix - check obj limit
;		BCS	@no_big_ring
		
		LDA	capsule_pos_x_l
		SEC
		SBC	#72
		STA	objects_X_l,Y
		LDA	capsule_pos_x_h
		SBC	#0
		STA	objects_X_h,Y
		
		LDA	capsule_pos_y_l
		SEC
		SBC	#32
		STA	objects_Y_l,Y
		
		LDA	capsule_pos_y_h
		SBC	#0
		STA	objects_Y_h,Y
		
		LDA	#$7A
		STA	objects_type,Y
		INC	big_ring_flag

		LDA	#0
		STA	objects_var_cnt,Y ; var/counter
		hide_obj_sprite
		INY
		STY	objects_cnt
@no_big_ring:		
		
locret_517BC:
		RTS
; End of function boss_create_capsule

; ---------------------------------------------------------------------------
;capsule_x_l_tbl:.BYTE $7C,$7C,$7C,$7C,$7C
capsule_x_h_tbl:.BYTE $1B,$10,$28,$17,$1B
capsule_y_l_tbl:.BYTE $80,$60,$40,$30,$60
capsule_y_h_tbl:.BYTE $03,$02,$04,$02,$02


; =============== S U B	R O U T	I N E =======================================


boss4_camera_move:
		JSR	boss4_sonic_Y_chk
; ---------------------------------------------------------------------------
		LDA	#$40
boss_camera_move:
		STA	tmp_var_63
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_old
		STA	tmp_var_64
		LDA	sonic_X_h_new
		SBC	camera_X_h_old
		BNE	loc_69872
		LDA	tmp_var_64
		SEC
		SBC	tmp_var_63
		BCS	loc_6986E
		LDA	camera_X_l_old
		STA	camera_X_l_new
		LDA	camera_X_h_old
		STA	camera_X_h_new
		RTS
; ---------------------------------------------------------------------------

loc_6986E:
		CMP	#8
		BCC	loc_69874

loc_69872:
		LDA	#8

loc_69874:
		CLC
		ADC	camera_X_l_old
		STA	camera_X_l_new
		LDA	camera_X_h_old
		ADC	#0
		STA	camera_X_h_new
		RTS
; End of function boss4_move_act


; =============== S U B	R O U T	I N E =======================================


boss4_sonic_Y_chk:
		LDA	sonic_y_on_scr
		CMP	#248 ; 224 in orig.
		BCC	locret_6984A
		LDA	sonic_y_h_on_scr ; sonic-camera
		BNE	locret_6984A
		LDA	sonic_anim_num
		CMP	#9
		BEQ	@already
		CMP	#$11
		BEQ	@already
		JSR	sonic_set_death ; labyrinth death by camera
@already
		PLA
		PLA
		LDA	#0
		STA	boss_func_num
locret_6984A:
		RTS


; =============== S U B	R O U T	I N E =======================================


boss_move_actions:
		LDA	boss_act_var_cnt
;		BEQ	@start_read_anim
		BNE	move_boss
; ---------------------------------------------------------------------------

@start_read_anim:
		LDY	boss_act_pos

@read_boss_anim:
		LDA	(boss_act_ptr_l),Y
		STA	boss_act_var_X
		INY
		LDA	(boss_act_ptr_l),Y
		STA	boss_act_var_Y
		INY
		LDA	(boss_act_ptr_l),Y
		BPL	@is_anim_cnt
; ---------------------------------------------------------------------------

@not_anim_cnt:
		CMP	#$FF
		BEQ	@inc_boss_func
		CMP	#$FE
		BEQ	@inc_boss_subfunc
		AND	#$7F
		STA	boss_act_pos
		TAY
		JMP	@read_boss_anim
; ---------------------------------------------------------------------------

@inc_boss_func:
		INC	boss_func_num
		RTS
; ---------------------------------------------------------------------------

@inc_boss_subfunc:
		INC	boss_sub_func_id
		RTS
; End of function boss_move_actions
; ---------------------------------------------------------------------------
@is_anim_cnt
		STA	boss_act_var_cnt
		INY
		LDA	(boss_act_ptr_l),Y
		STA	boss_anim_num
		INY
		STY	boss_act_pos
		;JMP	move_boss

; =============== S U B	R O U T	I N E =======================================


move_boss:
		DEC	boss_act_var_cnt
		LDA	boss_act_var_X
		CLC
		ADC	boss_x_l
		STA	boss_x_l
		LDA	boss_act_var_X
		BMI	loc_51880
		LDA	boss_x_h
		ADC	#0
		JMP	loc_51884
; ---------------------------------------------------------------------------

loc_51880:
		LDA	boss_x_h
		SBC	#0

loc_51884:
		STA	boss_x_h
		LDA	boss_act_var_Y
		CLC
		ADC	boss_y_l
		STA	boss_y_l
		CMP	#$F0
		BCC	loc_518AA
		BIT	boss_act_var_Y
		BMI	loc_518A1
		;LDA	boss_y_l
		CLC
		ADC	#$10
		STA	boss_y_l
		INC	boss_y_h
		RTS
; ---------------------------------------------------------------------------

loc_518A1:
		;LDA	boss_y_l
		SEC
		SBC	#$10
		STA	boss_y_l
		DEC	boss_y_h

loc_518AA:
		RTS
; End of function sub_5186E


; =============== S U B	R O U T	I N E =======================================


boss1_wpn_upd_pos:
		LDA	boss_vars
		SEC
		SBC	sonic_X_l_new
		STA	boss1_wpn_x_l
		LDA	boss_var_d4
		SBC	sonic_X_h_new
		STA	boss1_wpn_x_h
		BEQ	loc_518C1
		CMP	#$FF
		BEQ	loc_518C1
		RTS
; ---------------------------------------------------------------------------

loc_518C1:
		LDA	boss_var_d5
		SEC
		SBC	sonic_Y_l_new
		STA	boss1_wpn_y_l
		LDA	boss_var_d6
		SBC	sonic_Y_h_new
		STA	boss1_wpn_y_h
		BEQ	loc_518D5
		CMP	#$FF
		BEQ	loc_518D9
no_collision_with_boss_weapon:
		RTS
; ---------------------------------------------------------------------------

loc_518D5:
		LDA	#$F0
		BNE	loc_518DB

loc_518D9:
		LDA	#$10

loc_518DB:
		STA	tmp_var_25
		LDA	boss_var_d6
		CMP	sonic_Y_h_new
		BEQ	loc_518FB
		LDA	tmp_var_25
		CLC
		ADC	boss1_wpn_y_l
		STA	boss1_wpn_y_l
		LDA	tmp_var_25
		BMI	loc_518F5
		LDA	boss1_wpn_y_h
		ADC	#0
		JMP	loc_518F9
; ---------------------------------------------------------------------------

loc_518F5:
		LDA	boss1_wpn_y_h
		SBC	#0

loc_518F9:
		STA	boss1_wpn_y_h

loc_518FB:
		LDA	boss_invic_flag
		BNE	no_collision_with_boss_weapon
		LDA	#$FF
		CMP	boss1_wpn_x_h
		BNE	no_collision_with_boss_weapon
		CMP	boss1_wpn_y_h
		BNE	no_collision_with_boss_weapon
		LDA	#$D8
		CMP	boss1_wpn_x_l
		BCS	no_collision_with_boss_weapon
		LDA	#$C0
		CMP	boss1_wpn_y_l
		BCS	no_collision_with_boss_weapon
		;JMP	sonic_get_hit_from_boss
		JMP	sonic_get_hit_from_obj
; End of function boss1_wpn_upd_pos


; =============== S U B	R O U T	I N E =======================================


boss_update_position:
		LDA	boss_x_l
		SEC
		SBC	sonic_X_l_new
		STA	boss_X_l_relative
		LDA	boss_x_h
		SBC	sonic_X_h_new
		STA	boss_X_h_relative
		BEQ	loc_51933
		CMP	#$FE
		BCS	loc_51933
		RTS
; ---------------------------------------------------------------------------

loc_51933:
		LDA	boss_y_l
		SEC
		SBC	sonic_Y_l_new
		STA	boss_Y_l_relative
		LDA	boss_y_h
		SBC	sonic_Y_h_new
		STA	boss_Y_h_relative
		BEQ	loc_51947
		CMP	#$FF
		BEQ	loc_5194B
		RTS
; ---------------------------------------------------------------------------

loc_51947:
		LDA	#$F0
		BNE	loc_5194D

loc_5194B:
		LDA	#$10

loc_5194D:
		STA	tmp_var_25
		LDA	boss_y_h
		CMP	sonic_Y_h_new
		BEQ	loc_5196D
		LDA	tmp_var_25
		CLC
		ADC	boss_Y_l_relative
		STA	boss_Y_l_relative
		LDA	tmp_var_25
		BMI	loc_51967
		LDA	boss_Y_h_relative
		ADC	#0
		JMP	loc_5196B
; ---------------------------------------------------------------------------

loc_51967:
		LDA	boss_Y_h_relative
		SBC	#0

loc_5196B:
		STA	boss_Y_h_relative

loc_5196D:
no_collision_with_boss:
		RTS


; =============== S U B	R O U T	I N E =======================================


boss_upd_pos:
		JSR	boss_update_position
		LDA	boss_invic_flag
		BNE	no_collision_with_boss
; ---------------------------------------------------------------------------

boss_check_collision:
		LDX	level_id
		CPX	#SPRING_YARD
		BNE	loc_5DA45
		LDA	boss_anim_num
		CMP	#6
		BCC	loc_5DA45
		LDA	#$FF
		CMP	boss_X_h_relative
		BNE	loc_5DA45
		CMP	boss_Y_h_relative
		BNE	loc_5DA45
		LDA	boss_X_l_relative
		CMP	#$E3
		BCC	loc_5DA45
		CMP	#$F5
		BCS	loc_5DA45
		LDA	boss_Y_l_relative
		CMP	#$D0
		BCS	loc_5DA45
		CMP	#$A0
		BCC	loc_5DA45
		;JMP	sonic_get_hit_from_boss
sonic_get_hit_from_boss:
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

loc_5DA45:
		LDA	boss_get_hit_timer
		BNE	no_collision_with_boss
		LDA	#$FF
		CMP	boss_X_h_relative
		BNE	no_collision_with_boss
		CMP	boss_Y_h_relative
		BNE	no_collision_with_boss
		LDA	#$D0 ; boss1-3 X_hitbox
		LDY	#$C8 ; boss5
		CPX	#STAR_LIGHT
		BNE	@not_starl
		LDA	#$C8 ; boss1-3 Y_hitbox
		LDY	#$B8 ; boss5
@not_starl
		CMP	boss_X_l_relative
		BCS	no_collision_with_boss
		CPY	boss_Y_l_relative
		BCS	no_collision_with_boss

		LDA	invicible_timer
		BNE	@damage_to_boss
		LDA	sonic_state ; 0x2- shield; 0x4 - rolling
		CMP	#4
		BCC	sonic_get_hit_from_boss
		
@damage_to_boss:
		LDA	#9
		STA	sfx_to_play
		
		LDY	#5
		CPX	#SPRING_YARD
		BEQ	is_spring_yard
		LDA	#50
		STA	boss_get_hit_timer
		BNE	loc_5DA7A ; JMP

is_spring_yard:
		LDA	#40
		STA	boss_get_hit_timer
		LDA	boss_anim_num
		CMP	#6
		BCC	loc_5DA7A
		LDY	#7

loc_5DA7A:
		STY	boss_anim_num

		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDY	boss_Y_l_relative
		CPY	#$E8
		BCS	@boss_collision_from_up
@collision_from_down:
		LDY	#$10
		AND	#$F3
		JMP	@write_Y_spd ; JMP
; ---------------------------------------------------------------------------

@boss_collision_from_up:
		CPX	#GHZ
		BEQ	@collision_from_down
		LDY	#$30
		ORA	#$C
@write_Y_spd:
		STY	sonic_Y_speed
		
		LDY	boss_X_l_relative
		CPY	#$F0
		BCC	@from_right
		ORA	#3
		BNE	@set_X_spd_30 ; JMP
; ---------------------------------------------------------------------------

@from_right:
		CPY	#$E0
		BCS	@clr_x_spd
		AND	#$FC
		BCC	@set_X_spd_30 ; JMP
; ---------------------------------------------------------------------------

@clr_x_spd:
		LDY	#0
		BEQ	@write_X_spd ; JMP
@set_X_spd_30:
		LDY	#$30
@write_X_spd:
		STY	sonic_X_speed
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		DEC	boss_life
		BPL	locret_519E7
		INC	boss_func_num
		LDA	#1
		STA	boss_invic_flag
		LDA	#0
		STA	boss_vars

locret_519E7:
		RTS
; End of function boss_upd_pos


; =============== S U B	R O U T	I N E =======================================


boss1_func_05:
		LDA	#$70-6
		STA	boss_vars
		LDA	boss_x_h
		STA	boss_var_d4
		LDA	#$20+6
		STA	boss_var_d5
		LDA	boss_y_h
		STA	boss_var_d6
		LDA	#$70
		STA	boss_var_D1
		INC	boss_func_num
		RTS
; End of function boss1_func_05


; =============== S U B	R O U T	I N E =======================================


boss1_func_06:
		INC	boss_var_d5
		DEC	boss_var_D1
		BNE	locret_51B0F
		INC	boss_func_num
		LDA	#$80
		STA	boss_var_D1
		LDA	#0
		STA	boss_sub_func_id

locret_51B0F:
		RTS
; End of function boss1_func_06


; =============== S U B	R O U T	I N E =======================================


boss1_func_07:
		JSR	sub_51BF7
		LDA	boss_var_D1
		CMP	#$E0
		BCC	locret_51B0F
		LDA	#1
		STA	boss_sub_func_id
		LDA	#$F8
		STA	boss_var_D1
		LDY	#1*2
		JMP	next_boss_anim
; End of function boss1_func_07


; =============== S U B	R O U T	I N E =======================================


boss1_func_08:
		LDA	boss_sub_func_id
		LSR	A
		LDA	boss_var_D1
		BCS	loc_51B44
		JSR	sub_51B9C
		JMP	loc_51B47
; ---------------------------------------------------------------------------

loc_51B44:
		JSR	sub_51BC4

loc_51B47:
		JSR	boss_move_actions
		JSR	move_boss
		JMP	boss_update_position
; End of function boss1_func_08


; =============== S U B	R O U T	I N E =======================================


sub_51B9C:
		CMP	#$21
		BCS	sub_51BF7
		INC	boss_var_D1
		LDA	#1
		
boss1_change_var_d4:
		PHA
		CLC
		ADC	boss_vars
		STA	boss_vars
		PLA
		BMI	loc_51BB8
		LDA	boss_var_d4
		ADC	#0
		JMP	loc_51BBC
; ---------------------------------------------------------------------------

loc_51BB8:
		LDA	boss_var_d4
		SBC	#0

loc_51BBC:
		STA	boss_var_d4
		RTS


; =============== S U B	R O U T	I N E =======================================


sub_51BC4:
		CMP	#$E0
		BCC	loc_51BE9
		DEC	boss_var_D1
		LDA	#$FF
		BNE	boss1_change_var_d4 ; JMP
; ---------------------------------------------------------------------------

loc_51BE9:
		JSR	sub_51BF7
		LDA	boss_var_D1
		EOR	#$20 ; CMP
		BNE	locret_51BF6
		;LDA	#0
		STA	boss_sub_func_id

locret_51BF6:
		RTS
; End of function sub_51BC4


; =============== S U B	R O U T	I N E =======================================


sub_51BF7:
		LDX	boss_sub_func_id
		LDA	boss1_wpn_X_tbl,X
		JSR	boss1_change_var_d4
		
		LDA	boss_var_D1
		LSR	A
		LSR	A
		TAY

		LDA	boss1_wpn_Y_tbl,Y
		CPX	#1
		BCC	@no_negate
		EOR	#$FF
		ADC	#0
@no_negate:
		;STA	tmp_var_25
		;LDA	tmp_var_25
		CLC
		ADC	boss_var_d5
		STA	boss_var_d5
;		CMP	#$F0
;		BCC	loc_51C4E
;		LDA	tmp_var_25
;		BMI	loc_51C45
;		LDA	boss_var_d5
;		CLC
;		ADC	#$10
;		STA	boss_var_d5
;		INC	boss_var_d6
;		JMP	loc_51C4E
; ---------------------------------------------------------------------------
;
;loc_51C45:
;		LDA	boss_var_d5
;		SEC
;		SBC	#$10
;		STA	boss_var_d5
;		DEC	boss_var_d6
;
;loc_51C4E:
		LDX	boss_sub_func_id
		BNE	loc_51C7B
		INC	boss_var_D1
		INC	boss_var_D1
		LDA	boss_var_D1
		CMP	#$E0
		BCC	locret_51CA1
		LDA	#1
		STA	boss_sub_func_id
		LDA	#$F8
		STA	boss_var_D1
		LDY	#3*2
		JMP	set_boss_anim
; ---------------------------------------------------------------------------

loc_51C7B:
		DEC	boss_var_D1
		DEC	boss_var_D1
		LDA	boss_var_D1
		CMP	#$21
		BCS	locret_51CA1
		LDA	#0
		STA	boss_sub_func_id
		LDA	#8
		STA	boss_var_D1
		LDY	#2*2
		JMP	set_boss_anim

locret_51CA1:
		RTS
; End of function sub_51BF7

; ---------------------------------------------------------------------------
boss1_wpn_X_tbl:.BYTE 2
		.BYTE $FE
boss1_wpn_Y_tbl:.BYTE	 0,   0,   0,	0,   0,	  3,   3,   3,	 3,   3,   3,	3,   3,	  2,   2,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1,   1,	1,   1,	  0,   0,   0
		.BYTE	 0,   0,   0, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $FF, $FE, $FE, $FD, $FD,	$FD, $FD, $FD, $FD, $FD, $FD,	0,   0,	  0,   0,   0
		
;boss1_wpn_Y_tbr:.BYTE	 0,   0,   0,	0,   0,	$FD, $FD, $FD, $FD, $FD, $FD, $FD, $FD,	$FE, $FE, $FF
;		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	  0,   0,   0
;		.BYTE	 0,   0,   0,	1,   1,	  1,   1,   1,	 1,   1,   1,	1,   1,	  1,   1,   1
;		.BYTE	 1,   2,   2,	3,   3,	  3,   3,   3,	 3,   3,   3,	0,   0,	  0,   0,   0
; ---------------------------------------------------------------------------
boss_anim_ptrs_l:
		.BYTE <boss1_act_ptrs,<boss2_act_ptrs,<boss3_act_ptrs,<boss4_act_ptrs,<boss5_act_ptrs
		.BYTE <boss5_act_ptrs,<boss7_act_ptrs
boss_anim_ptrs_h:
		.BYTE >boss1_act_ptrs,>boss2_act_ptrs,>boss3_act_ptrs,>boss4_act_ptrs,>boss5_act_ptrs
		.BYTE >boss5_act_ptrs,>boss7_act_ptrs
; ---------------------------------------------------------------------------
boss1_act_ptrs:	.WORD boss1_move_act_00
		.WORD boss1_move_act_01
		.WORD boss1_move_act_02
		.WORD boss1_move_act_03
		.WORD boss1_move_act_04
boss1_move_act_00:.BYTE	   0,	1, $70,	  0,   0,   0, $FF,   0
boss1_move_act_01:.BYTE	 $FF,	0, $18,	  2,   0,   0,	 1,   1,   0,	0, $84,	  1
boss1_move_act_02:.BYTE	   1,	0, $30,	  1,   0,   0,	 1,   2,   0,	0,   1,	  0,   0,   0, $88,   0
boss1_move_act_03:.BYTE	 $FF,	0, $30,	  2,   0,   0,	 1,   1,   0,	0,   1,	  0,   0,   0, $88,   0
boss1_move_act_04:.BYTE	   0,	3, $10,	  3,   0, $FF,	$A,   3,   2,	0, $7F,	  4,   2,   0, $FF,   4

; ---------------------------------------------------------------------------
boss2_act_ptrs:	.WORD boss2_move_act_00
		.WORD boss2_move_act_01
		.WORD boss2_move_act_02
		.WORD boss2_move_act_03
boss2_move_act_00:.BYTE	 $FF,	0, $48,	  2,   0,   0, $32,   0,   0,	0, $FF,	  0
boss2_move_act_01:.BYTE	   0,	0, $10,	  2, $FE,   0, $18,   2, $FE,	1, $30,	  2, $FE,   0, $18,   2
		.BYTE	 0,   0,  $F,	0,   0,	$FF, $30,   6,	 0,   0,   1,	1,   0,	  0,  $F,   6
		.BYTE	 0,   0, $FE,	6
boss2_move_act_02:.BYTE	   0,	0, $10,	  6,   2,   0, $18,   1,   2,	1, $30,	  1,   2,   0, $18,   1
		.BYTE	 0,   0,  $F,	0,   0,	$FF, $30,   6,	 0,   0,   1,	2,   0,	  0,  $F,   6
		.BYTE	 0,   0, $FE,	6
boss2_move_act_03:.BYTE	   0,	3, $10,	  3,   0, $FF,	$A,   3,   2,	0, $7F,	  4,   2,   0, $FF,   4

; ---------------------------------------------------------------------------
boss3_act_ptrs:	.WORD boss3_move_act_00
		.WORD boss3_move_act_01
		.WORD boss3_move_act_02
		.WORD boss3_move_act_03
		.WORD boss3_move_act_04
boss3_move_act_00:.BYTE	   0,	1, $60,	  2, $FE,   0, $67,   2,   0, $FE
		.BYTE  $60,   0,   0,	0, $FE,	  0
boss3_move_act_03:.BYTE	   0,	1, $60,	  1,   2,   0, $67,   1,   0, $FE
		.BYTE  $60,   0,   0,	0, $FE,	  0
boss3_move_act_01:.BYTE	   0,	2, $5C,	  6,   0,   4,	 1,   6,   0, $FC
		.BYTE	 1,   6,   0,	4,   1,	  6,   0, $FC,	 1,   6
		.BYTE	 0,   4,   1,	6,   0,	$FC,   1,   6,	 0,   0
		.BYTE  $FE,   6
boss3_move_act_04:.BYTE	   0, $FC, $17,	  6,   0, $FE, $2E,   6,   0,	0
		.BYTE  $60,   6,   0,	0, $FE,	  6
boss3_move_act_02:.BYTE	   0,	0, $10,	  3,   0, $FF,	$A,   3,   2,	0
		.BYTE  $7F,   4,   2,	0, $FF,	  4
		
; ---------------------------------------------------------------------------
boss4_act_ptrs:	.WORD boss4_move_act_00
		.WORD boss4_move_act_01
		.WORD boss4_move_act_02
		.WORD boss4_move_act_03
boss4_move_act_00:.BYTE	 $FF,	0, $48,	  2,   0,   0, $32,   0,   0,	0, $FF,	  0
boss4_move_act_01:.BYTE	   0,	0, $10,	  2, $FE,   0, $18,   2, $FE,	1, $30,	  2, $FE,   0, $18,   2
		.BYTE	 0,   0,  $F,	0,   0,	$FF, $30,   6,	 0,   0,   1,	1,   0,	  0,  $F,   6
		.BYTE	 0,   0, $FE,	6
boss4_move_act_02:.BYTE	   0,	0, $10,	  6,   2,   0, $18,   1,   2,	1, $30,	  1,   2,   0, $18,   1
		.BYTE	 0,   0,  $F,	0,   0,	$FF, $30,   6,	 0,   0,   1,	2,   0,	  0,  $F,   6
		.BYTE	 0,   0, $FE,	6
boss4_move_act_03:.BYTE	   0,	3, $10,	  3,   0, $FF,	$A,   3,   2,	0, $7F,	  4,   2,   0, $FF,   4

; ---------------------------------------------------------------------------
boss5_act_ptrs:	.WORD boss5_move_act_00
		.WORD boss5_move_act_01
		.WORD boss5_move_act_02
		.WORD boss5_move_act_03
		.WORD boss5_move_act_04
		.WORD boss5_move_act_05
boss5_move_act_00:.BYTE	 $FF,	0, $10,	  2,   0,   0, $FF,   0
boss5_move_act_01:.BYTE	 $FE,	0, $3C,	  2,   0,   0,	 8,   6,   0,	0, $FE,	  6
boss5_move_act_05:.BYTE	 $FE,	0, $20,	  2,   0,   0,	 8,   6,   0,	0, $FE,	  6
boss5_move_act_02:.BYTE	 $FE,	0, $44,	  2,   0,   1, $70,   1,   4,	0, $2A,	  6,   0,   0, $FE,   6
boss5_move_act_03:.BYTE	4		; x
		.BYTE 0			; y
		.BYTE 38		; timer
		.BYTE 6			; anim num
		.BYTE 0
		.BYTE $FF
		.BYTE 112
		.BYTE 6
		.BYTE 0
		.BYTE 0
		.BYTE $FE
		.BYTE 2
boss5_move_act_04:.BYTE	0
		.BYTE 0
		.BYTE $10		; timer
		.BYTE 3			; anim
		.BYTE 0
		.BYTE $FF
		.BYTE $A
		.BYTE 3			; anim
		.BYTE 2
		.BYTE 0
		.BYTE $7F
		.BYTE 4			; anim
		.BYTE 2
		.BYTE 0
		.BYTE $1F
		.BYTE 4			; anim
		
		.BYTE 2
		.BYTE 0
		.BYTE $FF
		.BYTE 4			; anim

;		.pad	$A000,$00

