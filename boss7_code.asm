; =============== S U B	R O U T	I N E =======================================

rnd_vals	equ	$F0

boss7_init:
		LDA	sonic_X_h_new
		CMP	#2
		BNE	locret_6906C
		LDA	sonic_X_l_new
		CMP	#$60
		BCC	locret_6906C
		JSR	boss7_init2
;		LDA	#0
;		STA	boss_anim_num
		JSR	setup_palette_buff
		LDA	#$06
		STA	palette_buff+13
		LDA	#$16
		STA	palette_buff+14
		LDA	#$30
		STA	palette_buff+15
		;LDX	level_id
		JSR	load_boss_chr
Random_init:
		LDA	continues
		STA	rnd_vals+1
		LDA	player_lifes
		STA	rnd_vals+2
		LDA	Frame_Cnt
		STA	rnd_vals+3

locret_6906C:
		RTS
; End of function boss7_init


; =============== S U B	R O U T	I N E =======================================


boss7_func_04:
		JSR	boss7_sub_funcs
		JSR	boss7_count_pos
		JMP	sub_6959A
; End of function boss7_func_04


; =============== S U B	R O U T	I N E =======================================


boss7_sub_funcs:
		LDA	boss_sub_func_id
		JSR	jump_by_jmptable
; End of function boss7_sub_funcs

; ---------------------------------------------------------------------------
boss7_sub_f_ptrs:.WORD boss7_subfunc_00	 ; 0
		.WORD boss7_subfunc_01	; 1
		.WORD boss7_subfunc_02	; 2
		.WORD boss7_subfunc_03	; 3
		.WORD boss7_subfunc_04	; 4
		.WORD boss7_subfunc_05	; 5
		.WORD boss7_subfunc_06	; 6
		.WORD boss7_subfunc_07	; 7
		.WORD boss7_subfunc_08	; 8
		.WORD boss7_subfunc_09	; 9
		.WORD boss7_subfunc_06	; 10
		.WORD boss7_subfunc_0B	; 11
		.WORD boss7_subfunc_0C	; 12
		.WORD boss7_subfunc_0D	; 13
		.WORD boss7_subfunc_08	; 14
		.WORD boss7_subfunc_09	; 15
		.WORD boss7_subfunc_10	; 16

; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_00:
		LDY	objects_cnt
		LDA	#$5C
		STA	objects_type,Y
		LDA	#$E8
		STA	objects_X_l,Y
		LDA	#2
		STA	objects_X_h,Y
		LDA	#$40
		STA	objects_Y_l,Y
		LDA	#1
		STA	objects_Y_h,Y
		LDA	#0
		STA	objects_var_cnt,Y ; var/counter
		hide_obj_sprite
		INY
		STY	objects_cnt
		INC	boss_sub_func_id
		LDA	#5
		STA	some_timer
		RTS
; End of function boss7_subfunc_00


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_01:
		LDA	frame_cnt_for_1sec
		BNE	locret_691CF
		DEC	some_timer
		BNE	locret_691CF
		INC	boss_sub_func_id
		LDA	#$15
		STA	sfx_to_play

locret_691CF:
		RTS
; End of function boss7_subfunc_01


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_06:
		DEC	some_timer
		BEQ	locret_691D6
		INC	boss_sub_func_id

locret_691D6:
		RTS
; End of function boss7_subfunc_06


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_0B:
		LDA	#0
		STA	boss_sub_func_id
		RTS
; End of function boss7_subfunc_0B


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_02:
		;LDA	Frame_Cnt
		JSR	Random_256
		ASL	A
		AND	#$1F
		TAY
		LDA	byte_6921B,Y
		STA	final_boss_vars
		LDA	byte_6921C,Y
		STA	boss_var_db
		LDX	final_boss_vars
		LDA	byte_6923B,X
		STA	boss_vars
		LDA	#2
		STA	boss_var_d4
		LDA	byte_6923F,X
		STA	boss_var_d5
		LDA	#1
		STA	boss_var_d6
		LDA	#0
		STA	boss_var_D1
		LDX	boss_var_db
		LDA	byte_6923B,X
		STA	boss_var_dc
		LDA	#2
		STA	boss_var_dd
		LDA	byte_6923F,X
		STA	boss_var_de
		LDA	#1
		STA	boss_var_df
		INC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_02

; ---------------------------------------------------------------------------
byte_6921B:	.BYTE 0
byte_6921C:	.BYTE 3
		.BYTE	 1,   2,   1,	3,   0,	  2,   2,   3,	 0,   1
		.BYTE	 1,   0,   0,	1,   2,	  3,   3,   2,	 2,   0
		.BYTE	 3,   1,   2,	1,   3,	  0,   2,   0,	 2,   3
byte_6923B:	.BYTE  $20, $80, $50, $B0
byte_6923F:	.BYTE	 0,   0, $C0, $C0

; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_03:
		LDA	boss_life
		BNE	loc_69272
		LDA	#$C
		STA	boss_sub_func_id
		INC	boss_var_D1
		RTS
; ---------------------------------------------------------------------------

loc_69272:
		INC	boss_var_D1
		JSR	sub_697BA
		LDA	boss_var_D1
		CMP	#$13
		BCC	loc_69285
		INC	boss_sub_func_id
		INC	boss_sub_func_id
		LDA	#$20
		STA	some_timer

loc_69285:
		INC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_03


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_04:
		JSR	sub_697BA_part2
		LDA	final_boss_vars
		AND	#2
		BNE	loc_69298

		LDA	boss_y_l
		CLC
		ADC	#8
		STA	boss_y_l		
		
		LDX	boss_var_D1
		LDA	byte_69381,X
		STA	tmp_var_66
		JMP	loc_692A1
; ---------------------------------------------------------------------------

loc_69298:

		LDA	boss_y_l
		SEC
		SBC	#8
		STA	boss_y_l

		LDX	boss_var_D1
		LDA	byte_6936E,X
		STA	boss_var_d5
		STA	tmp_var_66

loc_692A1:
		LDA	boss_var_d6
		STA	tmp_var_65
		LDA	boss_vars
		STA	tmp_var_64
		JSR	sub_6953B
		LDX	final_boss_vars
		LDA	byte_69366,X
		STA	final_boss_vram_func
		INC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_04


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_05:
		LDX	boss_var_D1
		LDA	boss_var_db
		AND	#2
		BNE	loc_692C6
		LDA	byte_69381,X
		STA	tmp_var_66
		JMP	loc_692CD
; ---------------------------------------------------------------------------

loc_692C6:
		LDA	byte_6936E,X
		STA	tmp_var_66
		STA	boss_var_de

loc_692CD:
		LDA	boss_var_df
		STA	tmp_var_65
		LDA	boss_var_dc
		STA	tmp_var_64
		JSR	sub_6953B
		LDX	boss_var_db
		LDA	byte_69366,X
		STA	final_boss_vram_func
		DEC	boss_sub_func_id
		DEC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_05


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_07:
		LDA	boss_life
		BNE	loc_692ED
		LDA	#$C
		STA	boss_sub_func_id
		RTS
; ---------------------------------------------------------------------------

loc_692ED:
		INC	boss_sub_func_id
		JSR	sub_697BA
		DEC	boss_var_D1
		BPL	locret_692FE
		INC	boss_sub_func_id
		INC	boss_sub_func_id
		LDA	#$20
		STA	some_timer

locret_692FE:
		RTS
; End of function boss7_subfunc_07


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_08:
		JSR	sub_697BA_part2
		LDA	final_boss_vars
		AND	#2
		BNE	loc_6930F
		LDX	boss_var_D1
		LDA	byte_69381,X
		STA	tmp_var_66
		JMP	loc_69318
; ---------------------------------------------------------------------------

loc_6930F:
		LDX	boss_var_D1
		LDA	byte_6936E,X
		STA	boss_var_d5
		STA	tmp_var_66

loc_69318:
		LDA	boss_var_D1
		BEQ	loc_6932E
		LDA	boss_var_d6
		STA	tmp_var_65
		LDA	boss_vars
		STA	tmp_var_64
		JSR	sub_6953B
		LDX	final_boss_vars
		LDA	byte_6936A,X
		STA	final_boss_vram_func

loc_6932E:
		INC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_08


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_09:
		LDX	boss_var_D1
		LDA	boss_var_db
		AND	#2
		BNE	loc_69341
		LDA	byte_69381,X
		STA	tmp_var_66
		JMP	loc_69348
; ---------------------------------------------------------------------------

loc_69341:
		LDA	byte_6936E,X
		STA	tmp_var_66
		STA	boss_var_de

loc_69348:
		LDA	boss_var_D1
		BEQ	loc_69363
		LDA	boss_var_df
		STA	tmp_var_65
		LDA	boss_var_dc
		STA	tmp_var_64
		JSR	sub_6953B
		LDX	boss_var_db
		LDA	byte_6936A,X
		STA	final_boss_vram_func
		DEC	boss_sub_func_id
		DEC	boss_sub_func_id
		RTS
; ---------------------------------------------------------------------------

loc_69363:
		INC	boss_sub_func_id
		RTS
; End of function boss7_subfunc_09

; ---------------------------------------------------------------------------
byte_69366:	.BYTE	 1,   1,   3,	3
byte_6936A:	.BYTE	 2,   2,   4,	4
byte_6936E:	.BYTE  $C0, $B8, $B0, $A8, $A0,	$98, $90, $88, $80, $78
		.BYTE  $70, $68, $60, $58, $50,	$48, $40, $38, $30
byte_69381:	.BYTE	 0,   0,   8, $10, $18,	$20, $28, $30, $38, $40
		.BYTE  $48, $50, $58, $60, $68,	$70, $78, $80, $88

; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_0C:
		JSR	boss_explosion
		LDY	objects_cnt
		LDA	boss_var_dc
		STA	objects_X_l,Y
		LDA	boss_var_dd
		STA	objects_X_h,Y
		LDX	#$30
		LDA	boss_var_db
		CMP	#2
		BCC	loc_693AD
		LDX	#$90

loc_693AD:
		TXA
		STA	objects_Y_l,Y
		LDA	#1		; explosion for tube
		CLC
		JSR	explosion_create ; in obj_code.asm
		INC	boss_sub_func_id
		LDA	#1
		STA	boss_invic_flag
		LDA	#0
		STA	boss_get_hit_timer
		RTS
; End of function boss7_subfunc_0C


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_0D:
		LDA	Frame_Cnt
		AND	#7
		BNE	locret_693D7
		JMP	loc_692ED
; ---------------------------------------------------------------------------

locret_693D7:
		RTS
; End of function boss7_subfunc_0D


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc_10:
		LDA	#0
		STA	boss_sub_func_id
		INC	boss_func_num
		;LDA	#0
		STA	lock_move_flag	; sonic	lock in	camera area
		RTS
; End of function boss7_subfunc_10


; =============== S U B	R O U T	I N E =======================================


boss7_count_pos:
		LDA	boss_x_l
		SEC
		SBC	sonic_X_l_new
		STA	boss_X_l_relative
		LDA	boss_x_h
		SBC	sonic_X_h_new
		STA	boss_X_h_relative
		BEQ	loc_69470
		CMP	#$FF
		BEQ	loc_69470
		RTS
; ---------------------------------------------------------------------------

loc_69470:
		LDA	boss_y_l
		SEC
		SBC	sonic_Y_l_new
		STA	boss_Y_l_relative
		LDA	boss_y_h
		SBC	sonic_Y_h_new
		STA	boss_Y_h_relative
		BEQ	loc_69484
		CMP	#$FF
		BEQ	loc_69488
		RTS
; ---------------------------------------------------------------------------

loc_69484:
		LDA	#$F0
		BNE	loc_6948A

loc_69488:
		LDA	#$10

loc_6948A:
		STA	tmp_var_25
		LDA	boss_y_h
		CMP	sonic_Y_h_new
		BEQ	loc_694AA
		LDA	tmp_var_25
		CLC
		ADC	boss_Y_l_relative
		STA	boss_Y_l_relative
		LDA	tmp_var_25
		BMI	loc_694A4
		LDA	boss_Y_h_relative
		ADC	#0
		JMP	loc_694A8
; ---------------------------------------------------------------------------

loc_694A4:
		LDA	boss_Y_h_relative
		SBC	#0

loc_694A8:
		STA	boss_Y_h_relative

loc_694AA:
		LDA	boss_invic_flag
		BEQ	loc_694AF
		RTS
; ---------------------------------------------------------------------------

loc_694AF:
		LDA	boss_get_hit_timer
		BEQ	loc_694B4
		RTS
; ---------------------------------------------------------------------------

loc_694B4:
		LDA	boss_X_h_relative
		BEQ	loc_694BD
		CMP	#$FF
		BEQ	loc_694C4
		RTS
; ---------------------------------------------------------------------------

loc_694BD:
		LDA	boss_X_l_relative
		CMP	#8
		BCC	loc_694CB
		RTS
; ---------------------------------------------------------------------------

loc_694C4:
		LDA	boss_X_l_relative
		CMP	#$C8
		BCS	loc_694CB
		RTS
; ---------------------------------------------------------------------------

loc_694CB:
		LDA	boss_Y_h_relative
		CMP	#$FF
		BEQ	loc_694D2
		RTS
; ---------------------------------------------------------------------------

loc_694D2:
		LDA	boss_Y_l_relative
		CMP	#$B8
		BCS	loc_694D9
		RTS
; ---------------------------------------------------------------------------

loc_694D9:				; 0x2- shield; 0x4 - rolling
		LDA	sonic_state
		CMP	#4
		BCS	loc_694E0
		RTS
; ---------------------------------------------------------------------------

loc_694E0:
		LDA	#$28
		STA	boss_get_hit_timer
		LDY	#5
		LDA	boss_anim_num
		CMP	#6
		BCC	loc_694EE
		LDY	#7

loc_694EE:
		STY	boss_anim_num
		LDA	#9
		STA	sfx_to_play
		LDA	boss_X_h_relative
		BMI	loc_69501
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#3
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		JMP	loc_69507
; ---------------------------------------------------------------------------

loc_69501:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_69507:
		LDA	#$50
		STA	sonic_X_speed
		DEC	boss_life
		BPL	loc_69513
		LDA	#1
		STA	boss_invic_flag

loc_69513:
		LDA	#2	; $80 in original
		STA	sonic_inertia_timer
		RTS
; End of function boss7_count_pos


; =============== S U B	R O U T	I N E =======================================


boss7_kill_sonic:
		LDA	#9
		CMP	sonic_anim_num_old
		BEQ	locret_6953A
		JMP	sonic_set_death_bankA ; in obj_code.asm
;		STA	sonic_anim_num
;		LDA	#$50
;		STA	sonic_Y_speed
;		LDA	#0
;		STA	sonic_X_speed
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		ORA	#4
;		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		LDA	#1
;		STA	lock_camera_flag
;		LDA	#6
;		STA	sfx_to_play
;		LDA	#0
;		STA	sonic_blink_timer
;
locret_6953A:
		RTS
; End of function boss7_kill_sonic


; =============== S U B	R O U T	I N E =======================================


sub_6953B:
		LDA	tmp_var_64
		SEC
		SBC	camera_X_l_old
		STA	tmp_var_28
		LDA	tmp_var_66
		SEC
		SBC	camera_Y_l_old
		TAX
		LDA	tmp_var_65
		CMP	camera_Y_h_old
		BEQ	loc_69553
		TXA
		SEC
		SBC	#$10
		TAX

loc_69553:
		STX	tmp_var_2B
		LDA	hscroll_val
		CLC
		ADC	tmp_var_28
		AND	#$F0
		STA	tmp_var_28
		LDA	vscroll_val
		CLC
		ADC	tmp_var_2B
		BCS	loc_69573
		CMP	#$F0
		BCS	loc_69573
		AND	#$F8
		STA	tmp_var_2B
		LDA	ppu_tilemap_mask
		STA	tmp_var_25
		BPL	loc_69580

loc_69573:
		CLC
		ADC	#$10
		AND	#$F8
		STA	tmp_var_2B
		LDA	ppu_tilemap_mask
		EOR	#2
		STA	tmp_var_25

loc_69580:
		LDA	tmp_var_28
		LSR	A
		LSR	A
		LSR	A
		STA	tmp_var_28
		
		LDA	tmp_var_2B
		ASL	A
		ROL	tmp_var_2B
		ASL	A
		ROL	tmp_var_2B
		AND	#$E0
		ORA	tmp_var_28
		STA	vram_buffer_adr_l
		
		;LDA	tmp_var_66
		;AND	#$F0
		;ASL	A
		;ROL	tmp_var_2B
		;ASL	A
		;ROL	tmp_var_2B
		;ORA	tmp_var_25
		
		LDA	tmp_var_2B
		AND	#3
		ORA	#$20 ; $20-23

;		LDY	tmp_var_25
;		BEQ	loc_69596
;		ORA	#8
;		LSR	tmp_var_63
;		BCC	loc_69596
;		ORA	#4
;
;loc_69596:
		STA	vram_buffer_adr_h
		RTS
; End of function sub_6953B


; =============== S U B	R O U T	I N E =======================================


sub_6959A:
		LDA	boss_vars
		SEC
		SBC	sonic_X_l_new
		STA	boss1_wpn_x_l
		LDA	boss_var_d4
		SBC	sonic_X_h_new
		STA	boss1_wpn_x_h
		LDA	boss_var_d5
		SEC
		SBC	sonic_Y_l_new
		STA	boss1_wpn_y_l
		LDA	boss_var_d6
		SBC	sonic_Y_h_new
		STA	boss1_wpn_y_h
		BMI	loc_695BA
		LDA	#$F0
		BNE	loc_695BC

loc_695BA:
		LDA	#$10

loc_695BC:
		STA	tmp_var_25
		LDA	boss_var_d6
		CMP	sonic_Y_h_new
		BEQ	loc_695DC
		LDA	tmp_var_25
		CLC
		ADC	boss1_wpn_y_l
		STA	boss1_wpn_y_l
		LDA	tmp_var_25
		BMI	loc_695D6
		LDA	boss1_wpn_y_h
		ADC	#0
		JMP	loc_695DA
; ---------------------------------------------------------------------------

loc_695D6:
		LDA	boss1_wpn_y_h
		SBC	#0

loc_695DA:
		STA	boss1_wpn_y_h

loc_695DC:
		LDA	boss_var_dc
		SEC
		SBC	sonic_X_l_new
		STA	boss_tmp_e0
		LDA	boss_var_dd
		SBC	sonic_X_h_new
		STA	boss_tmp_e1
		LDA	boss_var_de
		SEC
		SBC	sonic_Y_l_new
		STA	boss_tmp_e2
		LDA	boss_var_df
		SBC	sonic_Y_h_new
		STA	boss_tmp_e3
		BMI	loc_695FC
		LDA	#$F0
		BNE	loc_695FE

loc_695FC:
		LDA	#$10

loc_695FE:
		STA	tmp_var_25
		LDA	boss_var_df
		CMP	sonic_Y_h_new
		BEQ	loc_6961E
		LDA	tmp_var_25
		CLC
		ADC	boss_tmp_e2
		STA	boss_tmp_e2
		LDA	tmp_var_25
		BMI	loc_69618

loc_69611:
		LDA	boss_tmp_e3
		ADC	#0
		JMP	loc_6961C
; ---------------------------------------------------------------------------

loc_69618:
		LDA	boss_tmp_e3
		SBC	#0

loc_6961C:
		STA	boss_tmp_e3

loc_6961E:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	loc_69625
		RTS
; ---------------------------------------------------------------------------

loc_69625:
		LDA	#0
		STA	boss_act_var_X
		LDX	#0
		LDA	final_boss_vars,X
		CMP	#2
		BCC	loc_69637
		JSR	sub_6965B
		JMP	loc_6963A
; ---------------------------------------------------------------------------

loc_69637:
		JSR	sub_69733

loc_6963A:
		LDA	#0
		STA	boss_act_var_Y
		LDX	#9
		LDA	final_boss_vars,X
		CMP	#2
		BCC	loc_6964C
		JSR	sub_6965B
		JMP	loc_6964F
; ---------------------------------------------------------------------------

loc_6964C:
		JSR	sub_69733

loc_6964F:
		LDA	boss_act_var_X
		BEQ	locret_6965A
		LDA	boss_act_var_Y
		BEQ	locret_6965A
		JMP	boss7_kill_sonic
; ---------------------------------------------------------------------------

locret_6965A:
		RTS
; End of function sub_6959A


; =============== S U B	R O U T	I N E =======================================


sub_6965B:
		LDA	boss1_wpn_y_h,X
		BMI	loc_69660
		RTS
; ---------------------------------------------------------------------------

loc_69660:
		LDY	#0
		LDA	boss1_wpn_y_l,X
		CMP	#$F0	; #$F6->#$F0 bugfix
		BCS	loc_6966A
		LDY	#1

loc_6966A:
		STY	obj_collision_flag
		LDA	boss1_wpn_x_h,X
		BMI	loc_69677
		LDA	boss1_wpn_x_l,X
		CMP	#8
		BCC	loc_6967E
		RTS
; ---------------------------------------------------------------------------

loc_69677:
		LDA	boss1_wpn_x_l,X
		CMP	#$C8
		BCS	loc_6967E
		RTS
; ---------------------------------------------------------------------------

loc_6967E:
		LDA	obj_collision_flag
		BNE	loc_69685
		JMP	loc_69703
; ---------------------------------------------------------------------------

loc_69685:
		JMP	loc_69688

loc_69688:
		LDA	boss1_wpn_x_h,X
		BMI	loc_696AA
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$F
		BNE	loc_696A7
		LDA	sonic_anim_num_old
		CMP	#8
		BEQ	loc_696A7
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	loc_696A7
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_696A7:
		JMP	loc_696C7
; ---------------------------------------------------------------------------

loc_696AA:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$F
		CMP	#3
		BNE	loc_696C7
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_696C7
		LDA	sonic_anim_num_old
		CMP	#8
		BEQ	loc_696C7
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_696C7:
		LDA	boss1_wpn_x_h,X

loc_696C9:
		BMI	loc_696DB
		LDA	boss_vars,X
		SEC
		SBC	#7
		STA	sonic_X_l_new
		LDA	boss_var_d4,X
		SBC	#0
		STA	sonic_X_h_new
		LDA	#$40
		BNE	loc_696E7 ; JMP
; ---------------------------------------------------------------------------

loc_696DB:
		LDA	#$37
		CLC
		ADC	boss_vars,X
		STA	sonic_X_l_new
		LDA	boss_var_d4,X
		ADC	#0
		STA	sonic_X_h_new
		LDA	#3
loc_696E7:
		EOR	sonic_attribs
		BNE	loc_696E8
		STA	sonic_X_speed

loc_696E8:
		LDA	boss_vars,X
		SEC
		SBC	sonic_X_l_new
		STA	boss1_wpn_x_l,X
		LDA	boss_var_d4,X
		SBC	sonic_X_h_new
		STA	boss1_wpn_x_h,X
		LDA	#1
		CPX	#0
		BEQ	loc_69700
		STA	boss_act_var_Y
		JMP	locret_69702
; ---------------------------------------------------------------------------

loc_69700:
		STA	boss_act_var_X

locret_69702:
		RTS
; ---------------------------------------------------------------------------

loc_69703:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs

loc_69705:
		AND	#$C
		BEQ	loc_6970C
		JMP	loc_696C7
; ---------------------------------------------------------------------------

loc_6970C:
		LDA	boss_var_d5,X
		STA	sonic_Y_l_new
		LDA	boss_var_d6,X
		STA	sonic_Y_h_new
		LDA	#0
		STA	boss1_wpn_y_h,X
		STA	boss1_wpn_y_l,X
		STA	sonic_Y_speed
		LDA	#1
		CPX	#0
		BEQ	loc_69727
		STA	boss_act_var_Y
		JMP	loc_69729
; ---------------------------------------------------------------------------

loc_69727:
		STA	boss_act_var_X

loc_69729:
		LDA	boss_var_D1
		CMP	#$F
		BCC	locret_69732
		JMP	boss7_kill_sonic
; ---------------------------------------------------------------------------

locret_69732:
		RTS
; End of function sub_6965B


; =============== S U B	R O U T	I N E =======================================


sub_69733:
		LDY	boss_var_D1
		LDA	byte_697A6,Y
		STA	tmp_var_28
		LDY	#1
		LDA	boss1_wpn_x_h,X
		BMI	loc_69747
		LDA	boss1_wpn_x_l,X
		CMP	#8
		BCC	loc_69754
		RTS
; ---------------------------------------------------------------------------

loc_69747:
		LDA	boss1_wpn_x_l,X
		CMP	#$C8
		BCS	loc_6974E
		RTS
; ---------------------------------------------------------------------------

loc_6974E:
		CMP	#$D0
		BCC	loc_69754
		LDY	#0

loc_69754:
		STY	obj_collision_flag
		LDA	boss1_wpn_y_h,X
		BMI	loc_6975B
		RTS
; ---------------------------------------------------------------------------

loc_6975B:
		LDA	boss1_wpn_y_l,X
		CLC
		ADC	tmp_var_28
		BCS	loc_69767
		CMP	#$E8
		BCS	loc_69767
		RTS
; ---------------------------------------------------------------------------

loc_69767:
		LDA	obj_collision_flag
		BNE	loc_6976E
		JMP	loc_69771
; ---------------------------------------------------------------------------

loc_6976E:
		JMP	loc_69688
; ---------------------------------------------------------------------------

loc_69771:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$C
		BEQ	loc_69781
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$F3
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$10
		STA	sonic_Y_speed

loc_69781:
		LDA	tmp_var_28
		CLC
		ADC	#$18
		CLC
		ADC	boss_var_d5,X
		STA	sonic_Y_l_new
		LDA	boss_var_d6,X
		STA	sonic_Y_h_new
		LDA	#1
		CPX	#0
		BEQ	loc_6979A
		STA	boss_act_var_Y
		JMP	loc_6979C
; ---------------------------------------------------------------------------

loc_6979A:
		STA	boss_act_var_X

loc_6979C:
		LDA	boss_var_D1
		CMP	#$F
		BCC	locret_697A5
		JMP	boss7_kill_sonic
; ---------------------------------------------------------------------------

locret_697A5:
		RTS
; End of function sub_69733

; ---------------------------------------------------------------------------
byte_697A6:	.BYTE  $30, $30, $38, $40, $48,	$50, $58, $60
		.BYTE  $68, $70, $78, $80, $88,	$90, $98, $A0
		.BYTE  $A8, $B0, $B8, $C0

; =============== S U B	R O U T	I N E =======================================


sub_697BA:
		LDA	#0
		STA	boss_invic_flag
		LDA	#0
		STA	boss_anim_num
		LDA	boss_vars
		STA	boss_x_l
		LDA	boss_var_d4
		STA	boss_x_h
		RTS
sub_697BA_part2:
		LDX	boss_var_D1
		LDA	final_boss_vars
		CMP	#2
		BCS	loc_697DF
		LDA	byte_697EA,X
		STA	boss_y_h
		LDA	byte_697FE,X
		STA	boss_y_l
		RTS
; ---------------------------------------------------------------------------

loc_697DF:
		LDA	byte_69812,X
		STA	boss_y_h
		LDA	byte_69826,X
		STA	boss_y_l
		RTS
; End of function sub_697BA

; ---------------------------------------------------------------------------
byte_697EA:	.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 1,   1,   1,	1
byte_697FE:	.BYTE  $B8, $B8, $C0, $C8, $D0,	$D8, $E0, $E8
		.BYTE	 0,   8, $10, $18, $20,	$28, $30, $38
		.BYTE  $40, $48, $50, $58
byte_69812:	.BYTE	 2,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 1,   1,   1,	1
byte_69826:	.BYTE	 0, $E8, $E0, $D8, $D0,	$C8, $C0, $B8
		.BYTE  $B0, $A8, $A0, $98, $90,	$88, $80, $78
		.BYTE  $70, $68, $60, $60


; =============== S U B	R O U T	I N E =======================================


boss7_func_05:
		LDX	#5
		JSR	load_boss_pos
		LDA	#8
		STA	boss_anim_num
		STA	boss_invic_flag
		JSR	setup_palette_buff
		LDY	#7

@copy_pal:
		LDA	boss7_palette2,Y
		STA	palette_buff+$18,Y
		DEY
		BPL	@copy_pal
		JMP	load_boss_chr
; End of function boss7_func_05

; ---------------------------------------------------------------------------
boss7_palette2:	.BYTE	$F,  $F, $10, $20
		.BYTE	$F,   4, $27, $16


; =============== S U B	R O U T	I N E =======================================


boss7_func_06:
		LDA	camera_X_h_old
		CMP	#4
		BEQ	loc_69BAE
		LDA	#$80
		JSR	boss_camera_move

loc_69BAE:
		JSR	sub_69C31
		JSR	boss7_sub_funcs2
		JMP	boss7_count_pos
; End of function boss7_func_06


; =============== S U B	R O U T	I N E =======================================


boss7_sub_funcs2:
		LDA	boss_sub_func_id
		JSR	jump_by_jmptable
; End of function boss7_sub_funcs2

; ---------------------------------------------------------------------------
boss7_sub_f2_ptrs:.WORD	boss7_subfunc2_00 ; 0
		.WORD boss_move_actions	; 1
		.WORD boss7_subfunc2_02	; 2
		.WORD boss_move_actions	; 3
		.WORD boss7_subfunc2_04	; 4
		.WORD boss_move_actions	; 5
		.WORD boss7_subfunc2_06	; 6
		.WORD boss7_subfunc2_07	; 7

; =============== S U B	R O U T	I N E =======================================


boss7_subfunc2_00:
		LDA	sonic_X_h_new
		CMP	#2
		BEQ	locret_69BF8

		LDA	boss_X_h_relative
		BNE	locret_69BF8
		LDA	boss_X_l_relative
		CMP	#$C0
		BCS	locret_69BF8
		INC	boss_sub_func_id
		LDY	#0*2
		JMP	set_boss_anim

locret_69BF8:
		RTS
; End of function boss7_subfunc2_00


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc2_02:
		LDA	#$E
		STA	boss_anim_num
		INC	boss_sub_func_id
		LDY	#2*2
		JMP	set_boss_anim
; End of function boss7_subfunc2_02

; ---------------------------------------------------------------------------

;boss7_subfunc2_01:
;		JMP	boss7_move_actions

; =============== S U B	R O U T	I N E =======================================


boss7_subfunc2_04:
		JSR	boss_explosion
		INC	boss_sub_func_id
		LDY	#1*2
		JMP	set_boss_anim
; End of function boss7_subfunc2_04


; =============== S U B	R O U T	I N E =======================================


sub_69C31:
		LDA	boss_sub_func_id
		BEQ	locret_69C51
		LDA	#BUTTON_RIGHT|BUTTON_A
		STA	ending_joy_val
		LDA	#$18
		STA	sonic_X_speed
		LDA	sonic_X_h_new
		CMP	#4
		BNE	locret_69C51
		LDA	sonic_X_l_new
		CMP	#$B0
		BCC	locret_69C51
		LDA	#BUTTON_UP
		STA	ending_joy_val
		LDA	#0
		STA	sonic_X_speed

locret_69C51:
		RTS
; End of function sub_69C31


; =============== S U B	R O U T	I N E =======================================


boss7_subfunc2_06:
		LDA	#4
		STA	level_finish_func_num
		INC	boss_sub_func_id

boss7_subfunc2_07:
		RTS
; End of function boss7_subfunc2_06


; =============== S U B	R O U T	I N E =======================================


;boss7_camera_move:
;		LDA	sonic_X_l_new
;		SEC
;		SBC	camera_X_l_old
;		STA	tmp_var_64
;		LDA	sonic_X_h_new
;		SBC	camera_X_h_old
;		STA	tmp_var_63
;		BNE	loc_69C80
;		LDA	tmp_var_64
;		SEC
;		SBC	#$80
;		BCS	loc_69C7C
;		LDA	camera_X_l_old
;		STA	camera_X_l_new
;		LDA	camera_X_h_old
;		STA	camera_X_h_new
;		RTS
; ---------------------------------------------------------------------------
;
;loc_69C7C:
;		CMP	#8
;		BCC	loc_69C82
;
;loc_69C80:
;		LDA	#8
;
;loc_69C82:
;		CLC
;		ADC	camera_X_l_old
;		STA	camera_X_l_new
;		LDA	camera_X_h_old
;		ADC	#0
;		STA	camera_X_h_new
;
;locret_69C8D:
;		RTS
; End of function sub_69C59


; =============== S U B	R O U T	I N E =======================================


Random_256:
		LDA	rnd_vals+3
		LSR
		LSR
		STA	rnd_vals
		LDA	rnd_vals+1
		ROL
		STA	rnd_vals+1
		LDA	rnd_vals+2
		ROL
		STA	rnd_vals+2
		LDA	rnd_vals+3
		SBC	rnd_vals
		LSR
		LDA	rnd_vals+3
		ROR
		STA	rnd_vals+3
		EOR	rnd_vals+2
		RTS
; ---------------------------------------------------------------------------

boss7_act_ptrs:	.WORD boss7_move_act_00
		.WORD boss7_move_act_01
		.WORD boss7_move_act_02
boss7_move_act_00:.BYTE	   0,	0,  $A,	  8,   0,   0,	$A,   9
		.BYTE	 0,   0,  $A,  $A,   0,	  0,  $A,  $B
		.BYTE	 0,   0, $FE,  $B
boss7_move_act_02:.BYTE	   0,	0,  $A,	 $D,   2, $FF, $48,  $D
		.BYTE	 0,   0,   4,  $C,   0,	  0, $FE,  $C
boss7_move_act_01:.BYTE	   0,	0, $30,	 $C,   0,   0, $18,  $C
		.BYTE	 0,   0, $10,  $D,   1,	  0, $70,  $D
		.BYTE	 1,   0, $70,  $D,   1,	  0, $70,  $D
		.BYTE	 0,   0, $FE,  $D
