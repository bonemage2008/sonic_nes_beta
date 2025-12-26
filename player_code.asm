MD_PHYS = 0

;		org	$A000


; =============== S U B	R O U T	I N E =======================================


draw_time_and_rings:
		LDY	sprite_id
		BEQ	no_draw_ui
		LDA	Frame_Cnt
		LSR	A
		BCC	draw_in_even_frames
		CLC
		JSR	draw_lives
		JSR	draw_rings_cnt
		JSR	draw_timer
		JSR	draw_ring_icon
		STY	sprite_id
		RTS
		
draw_in_even_frames:
		JSR	draw_rings_cnt
		JSR	draw_timer
		JSR	draw_lives
		JSR	draw_ring_icon
		STY	sprite_id
no_draw_ui
		RTS
		
ring_ico_tls:
		.BYTE	$62,$61,$63,$61
ring_ico_attr:
		.BYTE	$03,$03,$03,$43

draw_ring_icon:
		LDA	#$20-2
		STA	sprites_X,Y
		LDA	#$18+9
		STA	sprites_Y,Y
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		CLC
		AND	#3
		TAX
		LDA	ring_ico_tls,X
		STA	sprites_tile,Y
		LDA	ring_ico_attr,X
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		RTS
		
		
draw_rings_cnt:	
		LDA	rings_100s
		BEQ	@no_rings_100s
		ADC	#$64
		STA	sprites_tile,Y
		LDA	#$28-2
		STA	sprites_X,Y
		LDA	#$18+9
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		LDA	rings_10s
		BCC	@draw_rings_10s ; JMP
@no_rings_100s:
		LDA	rings_10s
		BEQ	@no_rings_10s
@draw_rings_10s:
		ADC	#$64
		STA	sprites_tile,Y
		
		LDA	#$30-2
		STA	sprites_X,Y
		LDA	#$18+9
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
@no_rings_10s
		LDA	rings_1s
		ADC	#$64
		STA	sprites_tile,Y
		LDA	#$38-2
		STA	sprites_X,Y
		LDA	#$18+9
		STA	sprites_Y,Y
		LDX	#1
		LDA	Frame_Cnt
		AND	#8
		BEQ	@no_alt_attr
		LDA	rings_1s
		ORA	rings_10s
		ORA	rings_100s
		BNE	@no_alt_attr
		LDX	#3
		LDA	level_id
		EOR	#6
		BNE	@no_alt_attr
		LDX	#2
@no_alt_attr
		TXA
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		RTS
		
spr_limit:
		STY	sprite_id
		PLA
		PLA
		RTS


draw_timer:
		LDA	#$20-2
		STA	sprites_X,Y
		LDA	#$20-8
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		LDA	timer_m
		ADC	#$64
		STA	sprites_tile,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		
		LDA	#$30-2
		STA	sprites_X,Y
		LDA	#$20-8
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		LDA	timer_10s
		ADC	#$64
		STA	sprites_tile,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		
		LDA	#$38-2
		STA	sprites_X,Y
		LDA	#$20-8
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		LDA	timer_s
		ADC	#$64
		STA	sprites_tile,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		
		LDA	#$28-2
		STA	sprites_X,Y
		LDA	#$20-8
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		LDA	#$6E	; DOTS
		STA	sprites_tile,Y
		INY
		INY
		INY
		INY
		BEQ	spr_limit
		RTS
; End of function draw_time_and_rings


; =============== S U B	R O U T	I N E =======================================


draw_lives:
		LDA	player_lifes
		CMP	#10
		BCC	@lives_9_or_lower
		; lives over 9

		LDX	#0
@count10s:
		SBC	#10
		BCC	@ok
		INX
		BCS	@count10s ; JMP
@ok
		ADC	#$64+10
		STA	sprites_tile,Y
		LDA	#$30-4
		STA	sprites_X,Y
		LDA	#$C8+6
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	@spr_limit2
		CLC
		TXA

@lives_9_or_lower:
		ADC	#$64
		STA	sprites_tile,Y
		LDA	#$28-4
		STA	sprites_X,Y
		LDA	#$C8+6
		STA	sprites_Y,Y
		LDA	#1
		STA	sprites_attr,Y
		INY
		INY
		INY
		INY
		BEQ	@spr_limit2
		
		CPY	#$F4
		BCS	locret_draw_ico

		LDA	#$18-5
		STA	sprites_X,Y
		;LDA	#$18-5
		STA	sprites_X+8,Y
		LDA	#$C0+6
		STA	sprites_Y,Y
		;LDA	#$C0+6
		STA	sprites_Y+4,Y
		
		LDA	#$20-5
		STA	sprites_X+4,Y
		;LDA	#$20-5
		STA	sprites_X+12,Y
		LDA	#$C8+6
		STA	sprites_Y+8,Y
		;LDA	#$C8+6
		STA	sprites_Y+12,Y

		LDA	#$7A
		STA	sprites_tile,Y
		LDA	#$7E
		STA	sprites_tile+4,Y
		LDA	#$7B
		STA	sprites_tile+8,Y
		LDA	#$7F
		STA	sprites_tile+12,Y
		
		LDA	#1
		BIT	sonic_state
		BPL	@not_supers
		LDA	#3
@not_supers:
		STA	sprites_attr,Y
		STA	sprites_attr+4,Y
		STA	sprites_attr+8,Y
		STA	sprites_attr+12,Y
		
		TYA
		CLC
		ADC	#16
		TAY
		BNE	locret_draw_ico
@spr_limit2:
		STY	sprite_id
		PLA
		PLA
locret_draw_ico:
		CLC
		RTS
; End of function draw_lives_count


; =============== S U B	R O U T	I N E =======================================


super_sonic_check:
		BIT	sonic_state
		BPL	@not_ss
		LDA	frame_cnt_for_1sec
		BNE	@not_ss
		LDA	sonic_anim_num
		CMP	#9
		BEQ	@not_ss
		CMP	#$11
		BEQ	@not_ss
		DEC	rings_1s
		BPL	@not_ss
		LDA	#$09
		STA	rings_1s
		DEC	rings_10s
		BPL	@not_ss
		;LDA	#$09
		STA	rings_10s
		DEC	rings_100s
		BPL	@not_ss
		
		JSR	clear_all_rings
		JSR	disable_super_sonic

		LDX	level_id
		LDA	music_by_level,X
		LDY	current_music
		CPY	#$29
		BEQ	@not_ss
;		LDY	lvl_bossfunc_id
;		BEQ	@no_boss
;		LDA	#$29
;@no_boss		
		STA	music_to_play
@not_ss
;		JMP	sonic_physics


; =============== S U B	R O U T	I N E =======================================


sonic_physics:
		LDA	sonic_anim_num
		BMI	loc_B21CC
		JSR	sonic_setup_anim
		LDA	time_over_flag
		BEQ	loc_B21BF
		LDA	sonic_anim_num_old
		CMP	#9
		BEQ	loc_B21BF
		JSR	sonic_set_death

loc_B21BF:				; in water flag
		LDA	water_timer
		BEQ	loc_B21C9
		CMP	#WATER_TIMEOUT	 ; gen_bubbles
		LDA	#$FF
		BCC	@low_int
		LDA	#7
@low_int:	
		AND	Frame_Cnt
		BNE	@object_limit
	
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-4
		BCS	@object_limit
		;BCC	object_limit
	
		LDA	#$45	; small bubble
		STA	objects_type,Y
	
		LDA	#0
		STA	objects_var_cnt,Y
	
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
	
		INY
		STY	objects_cnt
@object_limit:	

		LDA	Frame_Cnt
		AND	#1
		BEQ	loc_B21CC
loc_B21C9:

		IF	(MD_PHYS=1)
		LDA	sonic_status
		BNE	sonic_MD_move
		ENDIF
		
		LDA	sonic_anim_num
		CMP	#18	; SuperS activation
		BEQ	locret_B21CF
		JSR	sonic_update_Y_speed
loc_B21CC:
		JMP	sonic_move
locret_B21CF:
		RTS
; End of function sonic_physics

		IF	(MD_PHYS=1)
sonic_MD_move:
		LDA	sonic_X_h
		STA	sonic_X_h_new
		LDA	sonic_X_l
		STA	sonic_X_l_new
		JMP	loc_B2B64
		
		include	md_phys.asm
		ENDIF


; =============== S U B	R O U T	I N E =======================================


draw_sonic:
		;LDY	sonic_anim_num in main_code.asm
		CPY	#8	; jump?
		BEQ	@no_reset_roll_st
		CPY	#$20	; spin?
		BEQ	@no_reset_roll_st
		CPY	#$1F	; spin start
		BEQ	@no_reset_roll_st
		LDA	sonic_state
		AND	#STATE_SPIN^$FF
		STA	sonic_state

@no_reset_roll_st:
		;LDA	sonic_anim_num
		TYA
		CMP	sonic_anim_num_old
		BEQ	sonic_spr_not_changed
		JSR	get_walk_spr
		JMP	write_sonic_act_spr
; ---------------------------------------------------------------------------
get_walk_spr:		
		CMP	#1
		BNE	@not_walk
		LDA	sonic_X_speed
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAX
		LDA	water_timer	; in water flag
		BEQ	@not_in_water
		LDA	water_walk_spr_tbl,X
@not_walk:
		RTS
; ---------------------------------------------------------------------------

@not_in_water:
		LDA	walk_spr_tbl,X
		CLC
		ADC	round_walk_spr_add
		RTS
; ---------------------------------------------------------------------------

sonic_spr_not_changed:
		CMP	#0
		BNE	not_idle_sprite
		LDA	sonic_X_speed
		BEQ	@idle_stand
		LDA	#1
		STA	sonic_anim_num
		BNE	not_idle_sprite ; JMP
; ---------------------------------------------------------------------------
@idle_stand:
		LDA	sonic_idle_act_cnt
		ROR	A
		ROR	A
		AND	#7
		TAX
		LDA	idle_spr_tbl,X
		CMP	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		BEQ	skip_check_upd_anim

write_sonic_act_spr:
		STA	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		LDA	#0
		STA	sonic_spr_in_anim ; sub	sprite number
		JSR	init_sonic_spr_ptr
		JMP	skip_check_upd_anim
; ---------------------------------------------------------------------------

not_idle_sprite:
		JSR	get_walk_spr
		TAY

;check_for_upd_anim:			; 8 - jump roll, $1F - spin start, $20 -spin
		CPY	sonic_act_spr
		BEQ	skip_check_upd_anim
		STY	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		JSR	init_sonic_spr_ptr

skip_check_upd_anim:
		LDA	sonic_anim_num
		STA	sonic_anim_num_old
		JSR	update_sonic_spr_ptr
		JSR	get_sonic_sprites_pos
		LDA	invicible_timer
		BEQ	@no_draw_invic
		JSR	draw_sonic_nv_shield

@no_draw_invic:
		LDA	sonic_state
		AND	#STATE_SHIELD
		BEQ	@no_draw_shield
		JSR	draw_sonic_shield

@no_draw_shield:
		LDA	water_timer
		BEQ	@no_draw_water_time
		CMP	#WATER_TIMEOUT-12
		BCC	@no_draw_water_time
		LDA	sonic_anim_num_old
		CMP	#9
		BEQ	@no_draw_water_time
		JSR	draw_water_timeout

@no_draw_water_time:
		LDA	sonic_blink_timer
		BEQ	@no_blink
		LDA	Frame_Cnt
		AND	#4
		BEQ	locret_B229B

@no_blink:
		JMP	draw_sonic_sprites

locret_B229B:
		RTS
; End of function draw_sonic

; ---------------------------------------------------------------------------

;unused_3A2AC:				; 0x4 -	up, 0x43 - left, 01-left
;		LDA	sonic_attribs
;		BPL	loc_B22AD
;		LDA	sonic_Y_speed
;		LSR	A
;		STA	tmp_var_25
;		LDA	sonic_y_on_scr
;		SEC
;		SBC	tmp_var_25
;		STA	sonic_y_on_scr
;		RTS
; ---------------------------------------------------------------------------

;loc_B22AD:
;		LDA	sonic_Y_speed
;		LSR	A
;		STA	tmp_var_25
;		LDA	sonic_y_on_scr
;		CLC
;		ADC	tmp_var_25
;		CMP	#$C0
;		BCC	loc_B22C1
;		LDA	#2
;		STA	sonic_Y_speed
;		LDA	#$C0
;
;loc_B22C1:
;		STA	sonic_y_on_scr
;		RTS

; =============== S U B	R O U T	I N E =======================================


sonic_update_Y_speed:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	loc_B22E0
		LDA	sonic_Y_speed
		SEC
		SBC	#2
		BEQ	loc_B22D5
		CMP	#$F8
		BCC	loc_B22DD

loc_B22D5:
		LDA	sonic_attribs
		AND	#$63		; remove up bit and normal jump bit
		STA	sonic_attribs
		LDA	#8

loc_B22DD:
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_B22E0:
		LDA	sonic_anim_num
		CMP	#$20
		BEQ	@skip
		LDA	sonic_attribs
		AND	#$EF		; remove normal jump bit
		STA	sonic_attribs
@skip:
		INC	sonic_Y_speed
		INC	sonic_Y_speed
		LDA	sonic_Y_speed
		CMP	#$F8
		BCC	locret_B22EE
		LDA	#$F8
		STA	sonic_Y_speed

locret_B22EE:
		RTS
; End of function sonic_update_Y_speed


; =============== S U B	R O U T	I N E =======================================


sonic_setup_anim:
		LDY	sonic_anim_num_old
		BEQ	@idle_anim
@super_no_idle:
		LDA	#0
		STA	sonic_idle_act_cnt
		BEQ	loc_B230C ; JMP

@idle_anim:
		LDA	frame_cnt_for_1sec
		BNE	loc_B230C
		LDA	sonic_state
		BMI	@super_no_idle
		
		INC	sonic_idle_act_cnt
		LDA	#$10
		CMP	sonic_idle_act_cnt
		BCS	loc_B230C
		STA	sonic_idle_act_cnt

loc_B230C:
		CPY	#7
		BNE	@not_skid
		LDA	Frame_Cnt
		AND	#1
		BEQ	@no_skid_sfx
		;LDA	#1	; skid sfx
		STA	sfx_to_play
@no_skid_sfx:
		JMP	skid_anim
; ---------------------------------------------------------------------------

@not_skid:
		CPY	#6
		BNE	@not_spring_jump
		JMP	spring_jump_anim
; ---------------------------------------------------------------------------

@not_spring_jump:
		CPY	#8
		BNE	@not_jump
		JMP	jump_anim
; ---------------------------------------------------------------------------

@not_jump:
		CPY	#$20
		BNE	@not_spin
		JMP	spin_anim
; ---------------------------------------------------------------------------

@not_spin:
		CPY	#$A
		BNE	@not_get_hit
		JMP	get_hit_anim
; ---------------------------------------------------------------------------

@not_get_hit:
		CPY	#$2B
		BNE	@not_water_slide
		JMP	water_slide_anim
; ---------------------------------------------------------------------------

@not_water_slide:
		CPY	#9
		BNE	@not_death
		JMP	sonic_death_anim
; ---------------------------------------------------------------------------

@not_death:
		CPY	#$11
		BNE	@not_death2
		JMP	sonic_death_anim2
; ---------------------------------------------------------------------------

@not_death2:
		CPY	#$2C
		BNE	@not_bubble_breath
		JMP	sonic_bubble_breath
; ---------------------------------------------------------------------------
@not_bubble_breath
		CPY	#18
		BNE	@not_supers
		DEC	sonic_air_bubble_timer
		BEQ	@super_next_anim
		LDA	sonic_air_bubble_timer
		CMP	#2
		BNE	@no_supers_activation
		LDA	sonic_state
		BMI	@no_supers_activation
		ORA	#STATE_SUPER
		STA	sonic_state
		JSR	start_supers_music
		STA	music_to_play
		LDX	#3	; SS palette index
		JMP	setup_ss_palette
; ---------------------------------------------------------------------------
@super_next_anim:
		INY	; #19
		STY	sonic_anim_num
		LDA	#20	; anim2 timer
		STA	sonic_air_bubble_timer
@no_supers_activation:
		RTS
; ---------------------------------------------------------------------------
@not_supers:
		CPY	#19
		BNE	std_anims
		LDA	sonic_Y_speed
		BEQ	@end_supers_anims
		DEC	sonic_air_bubble_timer
		BEQ	@end_supers_anims
		JSR	std_anims
		LDA	sonic_anim_num
		CMP	#6
		BCS	@not_stand
		LDY	#19
		STY	sonic_anim_num
@not_stand:
		RTS
; ---------------------------------------------------------------------------
@end_supers_anims:
		LDY	#1 ; walk
		STY	sonic_anim_num
		STY	sonic_anim_num_old

std_anims
		LDA	sonic_X_speed
		BNE	@have_x_speed

		LDA	sonic_Y_speed
		BEQ	@no_Y_speed
		JSR	reset_sit_or_look_up
@no_Y_speed:
		JMP	set_sonic_stand_anim
; ---------------------------------------------------------------------------

@have_x_speed:
		JSR	reset_sit_or_look_up
		LDA	joy1_press
		AND	#BUTTON_B|BUTTON_A
		BNE	check_for_jump
		;LDA	joy1_hold_m ; joy1_press_prev
		;AND	#BUTTON_B|BUTTON_A
		;BNE	check_for_jump
		
		LDA	joy1_press
		AND	#BUTTON_DOWN
		BEQ	sonic_check_LR

		IF	(SPIN_IN_AIR=0)
		LDA	sonic_Y_speed
		BNE	sonic_check_LR
		ENDIF

		LDA	#8	; SPIN SFX
		STA	sfx_to_play
		BNE	set_spin_anim ; JMP
; ---------------------------------------------------------------------------

sonic_check_LR:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		BEQ	@restore_old_anim
		TAX
		JMP	left_or_right_pressed
; ---------------------------------------------------------------------------

@restore_old_anim:
		LDA	sonic_anim_num_old
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

set_spin_anim:
		LDA	#$20
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

check_for_jump:
		LDA	round_walk_spr_add
		CMP	#20
		BEQ	jump_LR
		CMP	#25
		BCC	sonic_set_jump
		LDA	sonic_rwalk_attr
		BMI	small_jump

sonic_set_jump:
		IF	(MD_PHYS=1)
		JMP	Sonic_Jump
		ENDIF
		
		LDA	sonic_Y_speed
		CMP	#4
		BCS	locret_B23E4
		LDA	#8
		STA	sonic_anim_num
		LDA	#$44
		BIT	sonic_state
		BPL	@not_supers
		LDA	#$4B	; super_sonic_jump
@not_supers:
		STA	sonic_Y_speed
		LDA	sonic_attribs
		ORA	#MOVE_UP|$10 ; $10 - new attribute flag 'is normal jump'
		STA	sonic_attribs
		LDA	#3
		STA	sfx_to_play

locret_B23E4:
		RTS
; ---------------------------------------------------------------------------

small_jump:
		LDA	#8
		STA	sonic_anim_num
		LDA	#$20
		STA	sonic_Y_speed
		LDA	sonic_attribs
		AND	#$F3
		STA	sonic_attribs
		LDA	#3
		STA	sfx_to_play
		RTS
; ---------------------------------------------------------------------------

jump_LR:
		LDA	#8
		STA	sonic_anim_num
		LDA	#$30
		STA	sonic_X_speed
		LDA	sonic_rwalk_attr
		AND	#LOOK_LEFT
		BNE	loc_B240F
		LDA	sonic_attribs
		ORA	#DIR_LEFT
		STA	sonic_attribs
		JMP	loc_B2415
; ---------------------------------------------------------------------------

loc_B240F:
		LDA	sonic_attribs
		AND	#$FC
		STA	sonic_attribs

loc_B2415:
		LDA	sonic_attribs
		AND	#$F3
		STA	sonic_attribs
		LDA	#1	; $20 in original
		STA	sonic_inertia_timer ; can't skid timer
		LDA	#3
		STA	sfx_to_play
		RTS
; ---------------------------------------------------------------------------

left_or_right_pressed:
		LDA	round_walk_spr_add
		CMP	#20
		BNE	@loc_B2447
		LDA	sonic_rwalk_attr
		BNE	@loc_B2431
		JMP	sonic_inc_air_speed1
; ---------------------------------------------------------------------------

@loc_B2431:
		CMP	#$80
		BNE	@loc_B2438
		JMP	sonic_inc_air_speed2
; ---------------------------------------------------------------------------

@loc_B2438:
		CMP	#$40
		BNE	@loc_B243F
		JMP	sonic_inc_air_speed3
; ---------------------------------------------------------------------------

@loc_B243F:
		CMP	#$C0
		BNE	@locret_B2446
		JMP	sonic_inc_air_speed4
; ---------------------------------------------------------------------------

@locret_B2446:
		RTS
; ---------------------------------------------------------------------------

@loc_B2447:
		;LDA	round_walk_spr_add
		CMP	#25
		BCC	@sonic_move_L_or_R
		LDA	sonic_rwalk_attr
		BPL	@sonic_move_L_or_R
		RTS
; ---------------------------------------------------------------------------

@sonic_move_L_or_R:
		;LDA	joy1_hold
		;AND	#BUTTON_RIGHT|BUTTON_LEFT
		;TAX
		LDA	sonic_attribs
		AND	#LOOK_LEFT|MOVE_LEFT
		EOR	attrib_by_LR,X
		BNE	pressed_other_dir
		LDA	sonic_X_speed
		CLC
		LDY	sonic_Y_speed
		BEQ	@not_in_air
		
		LDY	sonic_inertia_timer
		BNE	check_speed_limit
		
		LDY	sonic_anim_num
		CPY	#$20
		BNE	@not_spin_in_air
		CLC
		ADC	#SONIC_AIR_ACC_SPIN
		JMP	@write_x_speed
; ---------------------------------------------------------------------------
@not_spin_in_air:
		CLC
		ADC	#SONIC_AIR_ACC
		JMP	@write_x_speed
; ---------------------------------------------------------------------------
@not_in_air:
		LDY	sonic_anim_num
		CPY	#$20
		BNE	@not_spin_on_gnd
		CLC
		ADC	#SONIC_SPIN_ACC
		JMP	@write_x_speed
; ---------------------------------------------------------------------------
@not_spin_on_gnd:
		CMP	#$10
		BCS	@c2
		ADC	#SONIC_ACCEL-2
		JMP	@write_x_speed
@c2
		CMP	#$20
		;CLC
		ADC	#SONIC_ACCEL-1
@write_x_speed:	
		STA	sonic_X_speed

check_speed_limit:
		LDA	#$F8
		CMP	sonic_X_speed
		BCS	locret_B2471
		STA	sonic_X_speed

locret_B2471:
		RTS
; ---------------------------------------------------------------------------

pressed_other_dir:
		IF	(AIR_SKID>0)
		JMP	not_in_air2
		ENDIF
		LDY	sonic_Y_speed
		BEQ	not_in_air2

other_dir:
		LDA	sonic_X_speed
		BEQ	@no_speed
		SEC
		SBC	#SONIC_AIR_BRK
		BCS	@ok
		LDA	#0
@ok
		STA	sonic_X_speed
		LDA	sonic_X_speed
		BNE	@have_speed
@no_speed:
		LDA	sonic_attribs
		AND	#$3C
		ORA	attrib_by_LR,X
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------
@have_speed
		LDA	sonic_attribs
		AND	#$BF
		ORA	attrib_by_LR2,X
		STA	sonic_attribs
		RTS
; ---------------------------------------------------------------------------
not_in_air2:
		LDA	sonic_inertia_timer
		BNE	locret_B2471
		LDA	#$30
		CMP	sonic_X_speed
		BCS	@no_skid_anim
		STA	sonic_X_speed
		IF	(AIR_SKID=0)
		LDA	sonic_Y_speed	; NO SKID IN AIR
		BNE	@in_water
		ENDIF
		IF	(AIR_SKID>1)
		LDA	sonic_anim_num
		EOR	#$20
		BEQ	@clear_x_speed
		ENDIF
@set_skid:
		LDA	water_timer	; NO SKID IN WATER
		BNE	@in_water
		LDA	#7		; ANIM SKID
		STA	sonic_anim_num	; set skid anim
		RTS
; ---------------------------------------------------------------------------
@in_water:
		LDA	#0
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------
@clear_x_speed:
		LDY	sonic_Y_speed
		BEQ	@set_skid
		STA	sonic_X_speed
@no_clr_spd
		RTS
; ---------------------------------------------------------------------------

@no_skid_anim:
		LDA	sonic_attribs
		PHA	; save old attr
		AND	#$BC
		ORA	attrib_by_LR,X
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_anim_num
		EOR	#$20
		BEQ	@clear_x_speed_no_skid ; no reset anim if SPIN
		LDA	#1
		STA	sonic_anim_num
		
		PLA
		EOR	sonic_attribs
		EOR	#$43
		BNE	@not_exchanged_dir
		;LDA	#0
		STA	sonic_X_speed
		
@not_exchanged_dir:
		RTS
		
@clear_x_speed_no_skid:
		LDY	sonic_Y_speed
		BEQ	@no_clr
		;LDA	#0
		STA	sonic_X_speed
@no_clr:
		PLA	; fix sp
		RTS
; ---------------------------------------------------------------------------

sonic_inc_air_speed1:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BNE	sonic_inc_air_speed1_3
;		BEQ	loc_B24A4
;		LDA	sonic_attribs
;		AND	#MOVE_UP
;		BEQ	locret_B24A3
;		INC	sonic_Y_speed
;		INC	sonic_Y_speed
;
;locret_B24A3:
;		RTS
; ---------------------------------------------------------------------------

loc_B24A4:
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BNE	sonic_set_air_speed1_3
;		BEQ	locret_B24BB
;		LDA	sonic_attribs
;		AND	#MOVE_UP
;		BEQ	locret_B24BB
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#$FC
;		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		LDA	#$10
;		STA	sonic_Y_speed

locret_B24BB:
		RTS
; ---------------------------------------------------------------------------

sonic_inc_air_speed2:
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BNE	sonic_inc_air_speed2_4
;		BEQ	locret_B24CD
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#$F3
;		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		INC	sonic_Y_speed
;		INC	sonic_Y_speed

locret_B24CD:
		RTS
; ---------------------------------------------------------------------------

sonic_inc_air_speed3:
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_B24E0
sonic_inc_air_speed1_3:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	locret_B24DF
		INC	sonic_Y_speed
		INC	sonic_Y_speed

locret_B24DF:
		RTS
; ---------------------------------------------------------------------------

loc_B24E0:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	locret_B24F7
sonic_set_air_speed1_3:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	locret_B24F7
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$10
		STA	sonic_Y_speed

locret_B24F7:
		RTS
; ---------------------------------------------------------------------------

sonic_inc_air_speed4:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	locret_B2509
sonic_inc_air_speed2_4:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$F3
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		INC	sonic_Y_speed
		INC	sonic_Y_speed

locret_B2509:
		RTS
; ---------------------------------------------------------------------------
water_walk_spr_tbl:.BYTE    1,	 1,   1,   1,	1,   1,	  1,   2,   2,	 2,   2,   2,	2,   2,	  2,   2

walk_spr_tbl:	.BYTE	 2,   2,   2,	2,   2,	  2,   2,   3,	 3,   3,   3,	3,   4,	  4,   4,   5

;		.BYTE  $15, $15, $15, $15, $15,	$15, $15, $16, $16, $16, $17, $17, $17,	$18, $18, $19
;		.BYTE  $1A, $1A, $1A, $1A, $1A,	$1A, $1A, $1B, $1B, $1B, $1C, $1C, $1C,	$1D, $1D, $1E

idle_spr_tbl:	.BYTE	 0,  $F,  $F,  $F, $10
; ---------------------------------------------------------------------------

set_sonic_stand_anim:
		LDA	sonic_anim_num_old
		CMP	#$1F
		BNE	@not_spindash
		JMP	do_spindash
; ---------------------------------------------------------------------------

@not_spindash:
		LDA	joy1_press
		AND	#BUTTON_B|BUTTON_A
		BEQ	@loc_B2562
		JMP	do_jump_or_spindash
; ---------------------------------------------------------------------------

@loc_B2562:
		LDA	joy1_hold
		TAY
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		BEQ	@loc_B256D
		TAX
;set_walk_anim:
		LDA	sonic_attribs
		AND	#$BC
		ORA	attrib_by_LR,X
		STA	sonic_attribs
		LDY	#1
		STY	sonic_anim_num
		LDA	#SONIC_INIT_ACC
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

@loc_B256D:
		TYA
		AND	#BUTTON_DOWN
		BEQ	@loc_B2577
		LDA	sonic_Y_speed
		BNE	@no_set_sit_anim
		LDA	#$B
		STA	sonic_anim_num
@no_set_sit_anim:
		RTS
; ---------------------------------------------------------------------------

@loc_B2577:
		TYA
		AND	#BUTTON_UP
		BEQ	@set_idle_anim
		LDA	sonic_Y_speed
		BNE	@no_set_up_anim
		LDA	#$C
		STA	sonic_anim_num
@no_set_up_anim:
		RTS
; ---------------------------------------------------------------------------

@set_idle_anim:
;		LDA	#0
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

reset_sit_or_look_up:
		CPY	#$B
		BEQ	@change_to_walk
		CPY	#$C
		BNE	@not_sit_or_up
@change_to_walk:
		LDY	#1 ; walk
		STY	sonic_anim_num
		STY	sonic_anim_num_old
@not_sit_or_up:
		RTS
; ---------------------------------------------------------------------------
		
do_jump_or_spindash:
		LDA	sonic_anim_num_old
		CMP	#$B
		BNE	j_sonic_set_jump
; start spindash
		LDA	#8
		STA	sfx_to_play
		LDA	#$1F
		STA	sonic_anim_num
		LDA	sonic_attribs
		AND	#LOOK_LEFT
		BNE	loc_B25A1
		LDA	sonic_attribs
		AND	#DIR_LEFT^$FF
		JMP	loc_B25A5
; ---------------------------------------------------------------------------

loc_B25A1:
		LDA	sonic_attribs
		ORA	#DIR_LEFT

loc_B25A5:
		STA	sonic_attribs
		LDA	sonic_state
		ORA	#STATE_SPIN	; spindash attack fix
		STA	sonic_state
		RTS
; ---------------------------------------------------------------------------

j_sonic_set_jump:
		JMP	sonic_set_jump
; ---------------------------------------------------------------------------

do_spindash:
		LDA	joy1_hold
		AND	#BUTTON_DOWN
		BEQ	@start_spindash_run
		LDA	#$1F
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

@start_spindash_run:
		LDA	#$20
		STA	sonic_anim_num
		LDA	#$F0+6
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

skid_anim:
		LDA	Frame_Cnt
		AND	#3
		BEQ	loc_B25F5
		RTS
; ---------------------------------------------------------------------------

loc_B25F5:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		TAX
		BEQ	loc_B2612
		CMP	#BUTTON_RIGHT|BUTTON_LEFT
		BEQ	loc_B2612
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$43
		EOR	attrib_by_LR,X
		BEQ	loc_B262B
		LDA	sonic_X_speed
		SEC
		SBC	#4
		STA	sonic_X_speed

loc_B2612:
		DEC	sonic_X_speed
		BPL	loc_B2626
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$BC
		ORA	attrib_by_LR,X
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDY	#1
		STY	sonic_anim_num
		STY	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_B2626:
		LDA	#7
		STA	sonic_anim_num_old
		RTS
; ---------------------------------------------------------------------------

loc_B262B:
		LDA	#1
		STA	sonic_anim_num
		LDA	#2
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

spring_jump_anim:
		IF	(SPRING_MODE>1)
		LDA	joy1_press
		AND	#BUTTON_DOWN
		BNE	set_jump_anim
		ENDIF
		
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	spring_jump_anim_up
		;LDA	#0
		;STA	sonic_X_speed
		IF	(SPRING_MODE=1 | SPRING_MODE=3)
		LDA	#8	; anim_jump
		ELSE
		LDA	#1	; anim_walk
		ENDIF
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

set_jump_anim:
		;LDA	sonic_attribs
		;AND	#$EF
		;STA	sonic_attribs
		LDA	#8	; anim_jump
		STA	sonic_anim_num
		RTS
; ---------------------------------------------------------------------------

spring_jump_anim_up:
		LDA	#6
		STA	sonic_anim_num
		
		;LDA	sonic_X_speed
		;CMP	#5
		;BCC	@spring_jump_LR_ctrl
		
;		JSR	@spring_jump_LR_ctrl
		
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#3
;		BNE	@loc_B265A
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#$BF
;		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		RTS
; ---------------------------------------------------------------------------

;@loc_B265A:				; 0x4 -	up, 0x43 - left, 01-left
;		LDA	sonic_attribs
;		ORA	#$40
;		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		RTS
; ---------------------------------------------------------------------------

@spring_jump_LR_ctrl:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		BEQ	locret_B2676
		TAX

		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		EOR	attrib_by_LR,X
		AND	#$43
		BNE	@not_same_dir
		
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$BC
		ORA	attrib_by_LR,X
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		;LDA	#1
		;STA	sonic_X_speed
		JMP	sonic_acc_in_jump
@not_same_dir
	;	LDA	sonic_attribs
	;	AND	#$BF
	;	ORA	attrib_by_LR2,X
	;	STA	sonic_attribs
		JMP	other_dir
locret_B2676:
		RTS
; ---------------------------------------------------------------------------

jump_anim:
		IF	(MD_PHYS=1)
		LDA	sonic_status
		BEQ	@somari_jump
		JMP	Sonic_MdJump2
@somari_jump
		ENDIF

		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	jumping_up
		LDA	sonic_Y_speed
		BEQ	loc_B268E

loc_B2681:
		LDA	#8
		STA	sonic_anim_num
		LDA	sonic_state
		;AND	#$EF
		ORA	#STATE_SPIN
		STA	sonic_state
		BNE	loc_B269D ; JMP
; ---------------------------------------------------------------------------
jumping_up:
		LDA	sonic_Y_speed
		CMP	#JUMP_MIN_SPEED
		BCC	loc_B2681
		LDA	joy1_hold
		AND	#BUTTON_A|BUTTON_B
		BNE	loc_B2681
		LDA	sonic_attribs
		AND	#$10
		BEQ	loc_B2681
		LDA	#JUMP_MIN_SPEED ; reduce jump speed/height
		STA	sonic_Y_speed
		BNE	loc_B2681
; ---------------------------------------------------------------------------

loc_B268E:
		LDA	joy1_hold
		AND	#BUTTON_DOWN
		BEQ	@no_hold_d
		LDA	#8	; SPIN SFX
		STA	sfx_to_play
		LDY	#$20	; SPIN
		BNE	loc_B269B ;JMP
; ---------------------------------------------------------------------------
@no_hold_d
		LDA	sonic_state
		AND	#STATE_SPIN^$FF
		STA	sonic_state
		LDY	#0
		LDA	sonic_X_speed
		BEQ	loc_B269B
		INY

loc_B269B:
		STY	sonic_anim_num

loc_B269D:
		JSR	SUPER_CHECK
check_move_lr_in_jump:
		LDA	joy1_hold
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		BNE	move_left_right_in_jump
		RTS
; ---------------------------------------------------------------------------

move_left_right_in_jump:
		TAX
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		EOR	attrib_by_LR,X
		AND	#$43
		BNE	not_same_dir
		
sonic_acc_in_jump:
		;LDA	sonic_attribs
		;AND	#MOVE_UP ; 0x4
		;LSR	A
		;LSR	A
		;LSR	A
		CLC
		LDA	#SONIC_JUMP_ACC
		ADC	sonic_X_speed
		CMP	#$F8
		BCC	@loc_B26BA
		LDA	#$F7

@loc_B26BA:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

not_same_dir:
		IF	(JUMP_CTRL=0)
		JMP	other_dir
		ELSE
		LDA	sonic_attribs
		AND	#$3C
		ORA	attrib_by_LR,X
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	sonic_X_speed
		RTS
		ENDIF
; ---------------------------------------------------------------------------

get_hit_anim:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$C
		BNE	loc_B26DC
		LDA	sonic_Y_speed
		BNE	loc_B26DC
		LDA	#0
		STA	sonic_X_speed
		STA	sonic_anim_num
		
		LDA	sonic_attribs
		BIT	sonic_attribs
		BVS	@c2
		AND	#$FC
		STA	sonic_attribs
		RTS
@c2
		ORA	#3
		STA	sonic_attribs
		RTS
; ---------------------------------------------------------------------------

loc_B26DC:
		LDA	#$A
		STA	sonic_anim_num
locret_B26FC:
		RTS
; ---------------------------------------------------------------------------

water_slide_anim:
		LDA	sonic_Y_speed
		CMP	#4
		BCC	@write_waterf_anim
		LDA	#1
		BNE	@write_walk_anim
@write_waterf_anim:
		LDA	#$2B
@write_walk_anim:
		STA	sonic_anim_num
		;LDA	joy1_hold_m ; joy1_press_prev
		;AND	#BUTTON_B|BUTTON_A
		;BNE	@sonic_check_jump
		LDA	joy1_press
		AND	#BUTTON_B|BUTTON_A
		BEQ	locret_B26FC
@sonic_check_jump:
		JMP	check_for_jump
; ---------------------------------------------------------------------------

spin_anim:
		;LDY	#$20
		LDA	sonic_X_speed
		ORA	sonic_Y_speed ; hack
		BNE	loc_B270E
		;LDA	#0 ; 0 = idle anim
		STA	sonic_anim_num
		LDA	sonic_state
		AND	#STATE_SPIN^$FF
		STA	sonic_state
locret_B270D:
		RTS
; ---------------------------------------------------------------------------

loc_B270E:
		STY	sonic_anim_num
		LDA	sonic_state
		ORA	#STATE_SPIN
		STA	sonic_state
		LDA	sonic_Y_speed
		BNE	@SKIP
		INC	sonic_X_speed
@SKIP:
		JSR	the_jabu_hack
		JMP	check_speed_limit
; ---------------------------------------------------------------------------
the_jabu_hack:
		LDA	sonic_attribs
		AND	#$10	; 0x10 = block control hack (for tunnels).
		BNE	locret_B270D
		;BNE	@jabu_hack2
		LDA	joy1_press
		AND	#BUTTON_A|BUTTON_B
		BEQ	@jabu_hack2
		JMP	do_jump_or_spindash	; this allows to jump while spin (n/a in somari).
; ---------------------------------------------------------------------------

@jabu_hack2:
		IF	(SPIN_CTRL=1)
		JMP	sonic_check_LR ; this hack allows to accelerate while spin.
		
		ELSE
		
		LDA	joy1_hold	; this hack version more closier to MD
		AND	#BUTTON_RIGHT|BUTTON_LEFT
		BEQ	@same_dir
		TAX
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$43
		EOR	attrib_by_LR,X
		BEQ	@same_dir
		LDA	sonic_X_speed
		BEQ	@same_dir
		SEC
		SBC	#6	; brake speed
		BCS	@ok
		LDA	#0
@ok
		STA	sonic_X_speed
@same_dir
		RTS

		ENDIF
; End of function sub_B3D80

; ---------------------------------------------------------------------------

sonic_death_anim:
		STY	sonic_anim_num
		LDA	sonic_state
		AND	#$80
		;LDA	#0
		STA	sonic_state	; 0x2- shield; 0x4 - rolling
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	locret_B275B
sonic_death_anim2:
		LDA	sonic_y_h_on_scr ; sonic-camera
		EOR	#1
		BNE	locret_B275B
		;LDA	#0		; out of screen
		STA	water_timer	; in water flag
		;LDA	#0		; stop fall
		STA	sonic_Y_speed
		STA	sonic_X_speed
		LDA	camera_X_h_old
		STA	sonic_X_h_new
		LDA	camera_X_l_old
		STA	sonic_X_l_new
		LDA	camera_Y_h_old
		STA	sonic_Y_h_new
		LDA	camera_Y_l_old
		STA	sonic_Y_l_new
		LDA	death_func_num
		BNE	locret_B275B
		INC	death_func_num
		JMP	clear_all_objects
; ---------------------------------------------------------------------------

sonic_bubble_breath:
		LDA	sonic_air_bubble_timer
		BEQ	loc_B276D
		DEC	sonic_air_bubble_timer
		LDA	#0
		STA	sonic_X_speed
		STA	sonic_Y_speed
		LDA	#$2C
		STA	sonic_anim_num
locret_B275B:
		RTS
; ---------------------------------------------------------------------------

loc_B276D:
		;LDA	#0
		STA	sonic_anim_num
		RTS
; End of function sonic_setup_anim


; =============== S U B	R O U T	I N E =======================================


SUPER_CHECK:
		BIT	sonic_state
		BMI	@no_ss
		LDA	joy1_press
		;AND	#BUTTON_B|BUTTON_A
		AND	#BUTTON_B
		BEQ	@no_ss
		LDA	emeralds_cnt
		CMP	#7
		BCC	@no_ss
		LDX	level_id
		CPX	#SPEC_STAGE
		BEQ	@no_ss
		
		LDA	rings_100s
		BNE	@enough_rings
		LDA	rings_10s
		CMP	#5
		BCC	@no_ss
@enough_rings:

		LDA	capsule_func_num ; 2
		BNE	@no_ss		; 4
		LDA	boss_func_num ; 6
		CMP	boss_killed_f_by_lvl,X		; 9	- 8 for boss 3.
		BCS	@no_ss		; B
		
		LDA	level_finish_func_num
		BNE	@no_ss
		
		LDA	pulse2_sound
		CMP	#9	; Signpost/Checkpoint
		BEQ	@no_ss
		
		LDA	invicible_timer ; no SS while invicible (matches MD)
		BNE	@no_ss

		LDA	#18
		STA	sonic_anim_num
		LDA	#16	; anim1 timer
		STA	sonic_air_bubble_timer
		
		;LDA	sonic_state
		;ORA	#STATE_SUPER
		;STA	sonic_state
		
;		LDA	#$37	; superS-S2
;		LDX	super_em_cnt
;		CPX	#7
;		BCC	@not_hypers
;		LDA	#$38	; superS-S3K
;@not_hypers
;		STA	music_to_play

		;LDX	#3	; SS palette index
		;JMP	setup_ss_palette
@no_ss:
		RTS
; ---------------------------------------------------------------------------
boss_killed_f_by_lvl:
		.BYTE	10	; ghz
		.BYTE	8	; mar
		.BYTE	8	; spr
		.BYTE	7	; lab
		.BYTE	8	; str
		.BYTE	10	; scr

; =============== S U B	R O U T	I N E =======================================


update_sonic_spr_ptr:
		LDA	sonic_spr_anim_timer
		BMI	loc_B2783
		LDA	water_timer	; in water flag
		BEQ	loc_B2780
		LDA	Frame_Cnt
		AND	#1
		BEQ	locret_B2782

loc_B2780:
		DEC	sonic_spr_anim_timer

locret_B2782:
		RTS
; ---------------------------------------------------------------------------

loc_B2783:				; sub sprite number
		INC	sonic_spr_in_anim
; End of function update_sonic_spr_ptr


; =============== S U B	R O U T	I N E =======================================


init_sonic_spr_ptr:
		LDA	sonic_spr_in_anim ; sub	sprite number
		ASL	A
		ASL	A
		TAY
		LDA	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		ASL	A
		TAX
		LDA	joy1_hold
		IF	(TEST_SONIC_SPR=1)
		AND	#BUTTON_SELECT
		ELSE
		AND	#0
		ENDIF
		BNE	@std
		BIT	sonic_state
		BPL	@not_supers
		LDA	pl_spr_cfg_ptrs_super,X
		STA	tmp_ptr_l
		LDA	pl_spr_cfg_ptrs_super+1,X
		BNE	@new ; JMP
@not_supers:
		LDA	pl_spr_cfg_ptrs_new,X
		STA	tmp_ptr_l
		LDA	pl_spr_cfg_ptrs_new+1,X
		BNE	@new ; JMP
@std:
		LDA	pl_spr_cfg_ptrs,X
		STA	tmp_ptr_l
		LDA	pl_spr_cfg_ptrs+1,X
@new:
		STA	tmp_ptr_l+1
		LDA	(tmp_ptr_l),Y
		STA	sonic_spr_cfg_ptr
		INY
		LDA	(tmp_ptr_l),Y
		STA	sonic_spr_cfg_ptr+1
		INY
		LDA	(tmp_ptr_l),Y
		BPL	@write_anim_delay
		AND	#$7F
		STA	sonic_spr_in_anim ; sub	sprite number
		JMP	init_sonic_spr_ptr
; ---------------------------------------------------------------------------

@write_anim_delay:
		STA	sonic_spr_anim_timer
		RTS
; End of function init_sonic_spr_ptr


; =============== S U B	R O U T	I N E =======================================


get_sonic_sprites_pos:
		LDX	sonic_act_spr	; 8 - jump roll, $1F - spin start, $20 -spin
		LDA	round_walk_spr_add
		BEQ	loc_B27CB
		LDA	sonic_rwalk_attr
		JMP	loc_B27CD
; ---------------------------------------------------------------------------

loc_B27CB:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs

loc_B27CD:
		AND	sonic_spr_dir,X
		STA	tmp_attr_mask
		ROL	A
		ROL	A
		ROL	A
		ROL	A
		AND	#6
		TAY
		LDA	(sonic_spr_cfg_ptr),Y
		STA	spr_cfg_tile_ptr
		INY
		LDA	(sonic_spr_cfg_ptr),Y
		STA	spr_cfg_tile_ptr_h ; 89FB
		LDY	#0
		LDA	(spr_cfg_tile_ptr),Y
		STA	spr_parts_count_X
		INY
		LDA	(spr_cfg_tile_ptr),Y
		STA	spr_parts_count_Y
		INY
		LDA	(spr_cfg_tile_ptr),Y
		INY
		ASL	A
		TAX
		STA	chr_spr_bank1	; player sprites bank
		CPX	#$44	; chr bank num
		BNE	loc_B27FC
		LDX	#$10

loc_B27FC:
		LDA	spr_bank_attr_cfg,X
		STA	spr_cfg_attr_ptr ; temp	var
		LDA	spr_bank_attr_cfg+1,X
		STA	spr_cfg_attr_ptr_h ; 84c5
		;LDA	#0
		;STA	tmp_tile_mask
		LDA	(spr_cfg_tile_ptr),Y
		STA	tmp_var_25
		CLC
		ADC	sonic_x_on_scr
		STA	spr_tmp_x_l
		LDA	tmp_var_25
		BMI	loc_B281E
		LDA	sonic_x_h_on_scr ; sonic-camera
		ADC	#0
		JMP	loc_B2822
; ---------------------------------------------------------------------------

loc_B281E:				; sonic-camera
		LDA	sonic_x_h_on_scr
		SBC	#0

loc_B2822:
		STA	spr_tmp_x_h
		INY
		LDA	(spr_cfg_tile_ptr),Y
		STA	tmp_var_25
		CLC
		ADC	sonic_y_on_scr
		STA	spr_tmp_y_l
		LDA	tmp_var_25
		BMI	loc_B2839
		LDA	sonic_y_h_on_scr ; sonic-camera
		ADC	#0
		JMP	loc_B283D
; ---------------------------------------------------------------------------

loc_B2839:				; sonic-camera
		LDA	sonic_y_h_on_scr
		SBC	#0

loc_B283D:
		STA	spr_tmp_y_h
		LDA	sonic_attribs
		AND	#$20 	; priority mask
		ORA	tmp_attr_mask
		BIT	sonic_state
		BPL	@no_supers
		ORA	#3	; super sonic use palette4
@no_supers:
		STA	tmp_attr_mask
		RTS
; End of function get_sonic_sprites_pos


; =============== S U B	R O U T	I N E =======================================


draw_sonic_sprites:
		LDA	spr_parts_count_X
		BPL	@orig_mode
		AND	#$7F
		TAX
;		LDA	round_y_hack
;		BEQ	@ok1
;		CLC	
;		ADC	sonic_y_on_scr
;		STA	sonic_y_on_scr
;		BCC	@ok1
;		INC	sonic_y_h_on_scr
;@ok1:	
		JMP	draw_sonic_sprites_new
; ---------------------------------------------------------------------------
@orig_mode:
		LDX	#0
		LDA	spr_tmp_x_l
		LDY	spr_tmp_x_h
		BMI	loc_B2858
		BNE	loc_B2866

loc_B284A:
		STA	tmp_x_positions,X
		INX
		CPX	spr_parts_count_X
		BCS	loc_B286F
		;CLC
		ADC	#8
		BCC	loc_B284A
		BCS	loc_B2866

loc_B2858:
		STY	tmp_x_positions,X
		INX
		CPX	spr_parts_count_X
		BCS	loc_B286F
		;CLC
		ADC	#8
		BCC	loc_B2858
		BCS	loc_B284A

loc_B2866:
		LDA	#$FF

loc_B2868:
		STA	tmp_x_positions,X
		INX
		CPX	spr_parts_count_X
		BCC	loc_B2868

loc_B286F:
		LDX	#0
		LDA	spr_tmp_y_l
		LDY	spr_tmp_y_h
		BMI	loc_B2887
		BNE	loc_B2895

loc_B2879:
		STA	tmp_y_positions,X
		INX
		CPX	spr_parts_count_Y
		BCS	loc_B289E
		;CLC
		ADC	#8
		BCC	loc_B2879
		BCS	loc_B2895

loc_B2887:
		STY	tmp_y_positions,X
		INX
		CPX	spr_parts_count_Y
		BCS	loc_B289E
		;CLC
		ADC	#8
		BCC	loc_B2887
		BCS	loc_B2879

loc_B2895:
		LDA	#$FF

loc_B2897:
		STA	tmp_y_positions,X
		INX
		CPX	spr_parts_count_Y
		BCC	loc_B2897

loc_B289E:				; index	to sprites buffer
		LDX	sprite_id
		LDA	#5
		STA	spr_cfg_off
		LDY	#0
		STY	spr_parts_counter
		STY	spr_parts_counter2

next_sprite:
		LDA	tmp_y_positions,Y
		CMP	#$FF
		BNE	loc_B28BB
		LDA	spr_cfg_off
		CLC
		ADC	spr_parts_count_X
		STA	spr_cfg_off
		JMP	loc_B28F4
; ---------------------------------------------------------------------------

loc_B28BB:
		STA	tmp_var_2B
		LDY	#0
		STY	spr_parts_counter

draw_spr:
		LDA	tmp_x_positions,Y
		CMP	#$FF
		BEQ	loc_B28EA
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	(spr_cfg_tile_ptr),Y ; BANKE:8A10 8A00
		CMP	#$FF
		BEQ	loc_B28EA
		TAY
		;ORA	tmp_tile_mask
		STA	sprites_tile,X
		LDA	(spr_cfg_attr_ptr),Y ; BANKE:84C5
		ORA	tmp_attr_mask
		STA	sprites_attr,X
		INX
		INX
		INX
		INX

loc_B28EA:
		INC	spr_cfg_off
		INC	spr_parts_counter
		LDY	spr_parts_counter
		CPY	spr_parts_count_X
		BCC	draw_spr

loc_B28F4:
		INC	spr_parts_counter2
		LDY	spr_parts_counter2
		CPY	spr_parts_count_Y
		BCC	next_sprite
		;LDA	#$F8
		;STA	sprites_Y,X
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_sonic_sprites


; =============== S U B	R O U T	I N E =======================================

spr_cfg_ptr_l	equ	spr_cfg_tile_ptr
spr_cfg_ptr_h	equ	spr_cfg_tile_ptr+1
x_offset	equ	spr_parts_count_Y

draw_sonic_sprites_new:
		LDA	sonic_y_h_on_scr
		BNE	@NO_DRAW
		LDA	sonic_y_on_scr
		CMP	#8
		BCC	@NO_DRAW

		LDA	spr_cfg_ptr_l
		CLC
		ADC	#5
		STA	spr_cfg_ptr_l
		BCC	@no_inc_h
		INC	spr_cfg_ptr_h
@no_inc_h
		LDA	tmp_attr_mask
		AND	#3
		STA	spr_cfg_attr_ptr ; for SuperS pal
		LDA	tmp_attr_mask
		;AND	#$60 ; Hmirror + priority
		AND	#$E0 ; Vmirror+ Hmirror + priority
		STA	tmp_attr_mask
		STA	tmp_var_2B
		AND	#$40 ; Hmirror
		BEQ	@no_dir_l
		INC	tmp_var_2B
		.BYTE	$2C	; BIT
@no_dir_l
		STA	x_offset ; clear if no h-mirror
@hmirror
		LDA	sprite_id
		TAY
		CLC
		EOR	#$FF
		SEC
		ADC	spr_cfg_ptr_l
		BCS	@no_dec_h
		DEC	spr_cfg_ptr_h
@no_dec_h
		STA	spr_cfg_ptr_l
		TXA
		ASL
		ASL
		ADC	sprite_id
		STA	sprite_id
		LDA	tmp_attr_mask
		BMI	draw_player_vmirror
		
@player_spr_loop:
		LDA	(spr_cfg_ptr_l),Y
		CLC
		ADC	sonic_y_on_scr
		STA	sprites_Y,Y	; write Y
		INY
		LDA	(spr_cfg_ptr_l),Y
		STA	sprites_Y,Y	; write tile
		INY
		LDA	(spr_cfg_ptr_l),Y
		EOR	tmp_attr_mask
		ORA	spr_cfg_attr_ptr	; for SuperS pal
		STA	sprites_Y,Y	; write attr
		INY
		LDA	tmp_var_2B
		LSR
		LDA	(spr_cfg_ptr_l),Y
		BCC	@no_other_dir
		EOR	#$FF
		
@no_other_dir:
		ADC	sonic_x_on_scr
		CLC
		ADC	x_offset	; TODO: add variation with check X on screen
		STA	sprites_Y,Y	; write X
		INY
		DEX
		BNE	@player_spr_loop
@NO_DRAW:
		RTS
		
		
draw_player_vmirror:
@player_spr_loop:
		LDA	tmp_var_25
		SEC
		SBC	(spr_cfg_ptr_l),Y
		CLC
		ADC	sonic_y_on_scr
		STA	sprites_Y,Y	; write Y
		INY
		LDA	(spr_cfg_ptr_l),Y
		STA	sprites_Y,Y	; write tile
		INY
		LDA	(spr_cfg_ptr_l),Y
		EOR	tmp_attr_mask
		ORA	spr_cfg_attr_ptr	; for SuperS pal
		STA	sprites_Y,Y	; write attr
		INY
		LDA	tmp_var_2B
		LSR
		LDA	(spr_cfg_ptr_l),Y
		BCC	@no_other_dir
		EOR	#$FF
		
@no_other_dir:
		ADC	sonic_x_on_scr
		CLC
		ADC	x_offset	; TODO: add variation with check X on screen
		STA	sprites_Y,Y	; write X
		INY
		DEX
		BNE	@player_spr_loop
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_sonic_nv_shield:
		LDA	sonic_anim_num
		EOR	#9
		BNE	@not_dead
		STA	invicible_timer
		RTS
@not_dead
		LDA	sonic_y_h_on_scr
		BPL	@draw_nvs
@skip_nvs
		RTS
@draw_nvs
		LDA	sonic_y_on_scr
		CMP	#$10
		BCC	@skip_nvs

		LDX	sprite_id	; index	to sprites buffer
		LDA	tmp_attr_mask
		AND	#$20
		ORA	#3
		STA	sprites_attr,X
		STA	sprites_attr+4,X
		STA	sprites_attr+8,X
		STA	sprites_attr+12,X
		LDA	#$70
		STA	sprites_tile,X
		STA	sprites_tile+4,X
		LDA	#$71
		STA	sprites_tile+8,X
		STA	sprites_tile+12,X
		
		LDA	Frame_Cnt
		AND	#$F
		TAY
		;LDA	sonic_y_on_scr
		JSR	get_y_pos_for_shield
		SEC
		SBC	#$10
		STA	tmp_var_2B
		
		;LDA	tmp_var_2B
		CLC
		ADC	byte_B2ACA,Y
		STA	sprites_Y,X
		LDA	sonic_x_on_scr
		CLC
		ADC	byte_B2ABA,Y
		STA	sprites_X,X
		
		TYA
		EOR	#8
		TAY
		
		LDA	tmp_var_2B
		CLC
		ADC	byte_B2ACA,Y
		STA	sprites_Y+4,X
		LDA	sonic_x_on_scr
		CLC
		ADC	byte_B2ABA,Y
		STA	sprites_X+4,X
		
		TYA
		LSR	A
		AND	#7
		TAY
		
		LDA	tmp_var_2B
		CLC
		ADC	byte_B2AE2,Y
		STA	sprites_Y+8,X
		LDA	sonic_x_on_scr
		CLC
		ADC	byte_B2ADA,Y
		STA	sprites_X+8,X
		
		TYA
		EOR	#4
		TAY
		
		LDA	tmp_var_2B
		CLC
		ADC	byte_B2AE2,Y
		STA	sprites_Y+12,X
		LDA	sonic_x_on_scr
		CLC
		ADC	byte_B2ADA,Y
		STA	sprites_X+12,X
		
;		LDA	sonic_y_on_scr
;		CMP	#$10
;		BCS	@ok
;		LDA	#$F0
;		STA	sprites_Y+0,X
;		STA	sprites_Y+4,X
;		
;@ok		
;		TXA
;		CLC
;		ADC	#16
;		STA	sprite_id	; index	to sprites buffer
;		RTS
		JMP	add_16_to_sprite_id

; End of function draw_sonic_nv_shield


; =============== S U B	R O U T	I N E =======================================


draw_sonic_shield:
		LDA	Frame_Cnt
		AND	#8
		BNE	ret_draw_shield
		LDA	sonic_y_h_on_scr
		BMI	ret_draw_shield
		LDA	sonic_y_on_scr
		CMP	#8
		BCC	ret_draw_shield
		
		LDA	Frame_Cnt
		ASL	A
		AND	#$C
		TAY
		LDX	sprite_id	; index	to sprites buffer
		LDA	shield_tile1,Y
		STA	sprites_tile,X
		LDA	shield_tile2,Y
		STA	sprite2_tile,X
		LDA	shield_tile3,Y
		STA	sprite3_tile,X
		LDA	shield_tile4,Y
		STA	sprite4_tile,X
		TYA
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	sonic_x_on_scr
		CLC
		ADC	shield_spr_x,Y
		STA	sprites_X,X
		STA	sprite2_X,X
		STA	sprite3_X,X
		STA	sprite4_X,X
		;LDA	sonic_y_on_scr
		JSR	get_y_pos_for_shield
		SEC
		SBC	#8
		STA	sprite4_Y,X
		SEC
		SBC	#8
		STA	sprite3_Y,X
		SEC
		SBC	#8
		STA	sprite2_Y,X
		SEC
		SBC	#8
		STA	sprites_Y,X
		LDA	tmp_attr_mask
		AND	#$20
		ORA	shield_spr_attr,Y
		STA	sprites_attr,X
		STA	sprite2_attr,X
		STA	sprite3_attr,X
		STA	sprite4_attr,X
add_16_to_sprite_id:
		TXA
		CLC
		ADC	#$10
		STA	sprite_id
ret_draw_shield:
		RTS
; End of function draw_sonic_shield


get_y_pos_for_shield:
		LDA	sonic_anim_num
		CMP	#1
		BNE	@normal

		LDA	round_walk_spr_add
		CMP	#$25
		BNE	@not_25
		BEQ	@add_20_to_y
@not_25
		CMP	#$20
		BNE	@not_20
		BIT	sonic_rwalk_attr
		BPL	@normal
@add_20_to_y:
		LDA	sonic_y_on_scr
		CLC
		ADC	#$20
		RTS
@not_20:
		CMP	#$19
		BNE	@not_19
		BIT	sonic_rwalk_attr
		BPL	@normal
		BMI	@add_20_to_y
@not_19
		CMP	#$14
		BNE	@normal
		LDA	sonic_y_on_scr
		CLC
		ADC	#$10
		RTS
@normal:
		LDA	sonic_y_on_scr
		RTS
; ---------------------------------------------------------------------------
shield_tile1:	.BYTE $78
shield_tile2:	.BYTE $79
shield_tile3:	.BYTE $7C
shield_tile4:	.BYTE $7D
		.BYTE  $72, $73, $76, $77
		.BYTE  $72, $73, $76, $77
		.BYTE  $78, $79, $7C, $7D
shield_spr_x:	.BYTE	 8,   0, $F9, $F1
shield_spr_attr:.BYTE	 3, $43,   3, $43

; =============== S U B	R O U T	I N E =======================================


draw_water_timeout:
		LDX	sprite_id	; index	to sprites buffer
		LDA	#WATER_TIMEOUT-1
		SEC
		SBC	water_timer	; in water flag
		STA	tmp_var_28
		BEQ	ret_draw_timer
;		BPL	loc_B2A39
;
;loc_B2A39:
		;LDY	sonic_state
		;BMI	locret_B238E
		LDY	music_to_play
		CPY	#$34
		BEQ	locret_B238E
		LDY	#$2A
		STY	music_to_play
		
locret_B238E:
		CMP	#6
;		BCC	draw_drowning_timer
;
;locret_B2A41:
;		RTS
		BCS	ret_draw_timer
; ---------------------------------------------------------------------------

draw_drowning_timer:
		LDA	frame_cnt_for_1sec
		CMP	#$1E
;		BCC	loc_B2A4A
;		RTS
		BCS	ret_draw_timer
; ---------------------------------------------------------------------------

loc_B2A4A:
		LDA	Frame_Cnt
		AND	#4
;		BNE	loc_B2A51
;		RTS
		BEQ	ret_draw_timer
; ---------------------------------------------------------------------------

loc_B2A51:
		LDA	tmp_var_28
		ASL	A
		TAY
		LDA	byte_B2AAE,Y
		STA	sprites_tile,X
		LDA	byte_B2AAF,Y
		STA	sprite2_tile,X
		LDA	sonic_y_on_scr
		SEC
		SBC	#$50
		STA	sprites_Y,X
		CLC
		ADC	#8
		STA	sprite2_Y,X
		LDA	sonic_x_on_scr
		SEC
		SBC	#4
		STA	sprites_X,X
		STA	sprite2_X,X
		LDA	#1
		STA	sprites_attr,X
		STA	sprite2_attr,X
		TXA
		CLC
		ADC	#8
		STA	sprite_id	; index	to sprites buffer
ret_draw_timer:
		RTS
; End of function draw_water_timeout

; ---------------------------------------------------------------------------

;unused_3AA99:
;		LDA	#9
;		CMP	sonic_anim_num
;		BEQ	locret_B2AAD
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
;		LDA	#5
;		STA	sfx_to_play
;		LDA	#0
;		STA	sonic_blink_timer
;		STA	invicible_timer
;
;locret_B2AAD:
;		RTS
; ---------------------------------------------------------------------------
byte_B2AAE:	.BYTE 0
byte_B2AAF:	.BYTE 0
		.BYTE  $CE, $CF, $CC, $CD, $CA,	$CB, $C8, $C9, $C6, $C7
byte_B2ABA:	.BYTE  $EA, $EC, $F0, $F6, $FC,	  2,   8,  $C,	$E,  $C,   8,	2, $FC,	$F6, $F0, $EC
byte_B2ACA:	.BYTE  $FC, $F6, $F0, $EC, $EA,	$EC, $F0, $F6, $FC,   2,   8,  $C,  $E,	 $C,   8,   2
byte_B2ADA:	.BYTE  $F2, $F5, $FC,	3,   6,	  3, $FC, $F5
byte_B2AE2:	.BYTE  $FC,   3,   6,	3, $FC,	$F5, $F2, $F5
attrib_by_LR:	.BYTE	 0,   0, $43,	0
attrib_by_LR2:	.BYTE	 0,   0, $40,	0

; =============== S U B	R O U T	I N E =======================================


sonic_move:
		LDA	sonic_anim_num
		;BPL	loc_B2AF3
		;RTS
		BMI	ret_draw_timer
; ---------------------------------------------------------------------------

loc_B2AF3:
		LDA	#0
		STA	tmp_var_2B
		LDA	sonic_X_speed
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		JSR	X_speed_hack
		STA	tmp_var_28
		LDA	sonic_X_speed
		BNE	loc_B2B07
		LDA	#0
		STA	tmp_var_28

loc_B2B07:				; in water flag
		LDA	water_timer
		BEQ	loc_B2B18
		JSR	X_speed_hack_water
		STA	tmp_var_28
		LDA	sonic_X_speed
		BNE	loc_B2B18
		LDA	#0
		STA	tmp_var_28

loc_B2B18:
		LDA	tmp_var_28
		BNE	@sonic_move_LR
		LDA	sonic_X_h
		STA	sonic_X_h_new
		LDA	sonic_X_l
		STA	sonic_X_l_new
		JMP	loc_B2B4A
; ---------------------------------------------------------------------------

@sonic_move_LR:
		LDA	sonic_attribs
		AND	#1
		BEQ	@sonic_move_right

@sonic_move_left:
		LDA	sonic_X_sub
		SEC
		SBC	tmp_var_2B
		STA	sonic_X_sub

		LDA	sonic_X_l
		;SEC
		SBC	tmp_var_28
		STA	sonic_X_l_new
		LDA	sonic_X_h
		SBC	#0
		STA	sonic_X_h_new
		JMP	loc_B2B4A
; ---------------------------------------------------------------------------

@sonic_move_right:
		LDA	sonic_X_sub
		CLC
		ADC	tmp_var_2B
		STA	sonic_X_sub

		LDA	sonic_X_l
		;CLC
		ADC	tmp_var_28
		STA	sonic_X_l_new
		LDA	sonic_X_h
		ADC	#0
		STA	sonic_X_h_new

loc_B2B4A:
		LDA	sonic_Y_speed
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAX
		LDA	m_pixels_by_Y_spd,X
		STA	tmp_var_2B
		LDA	water_timer	; in water flag
		BEQ	loc_B2B60
		LDA	Frame_Cnt
		AND	#1
		BEQ	loc_B2B64

loc_B2B60:
		LDA	tmp_var_2B
		BNE	sonic_move_UD

loc_B2B64:
		LDA	sonic_Y_h
		STA	sonic_Y_h_new
		LDA	sonic_Y_l
		STA	sonic_Y_l_new
		JMP	loc_B2BAA
; ---------------------------------------------------------------------------

sonic_move_UD:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	loc_B2B90
		LDA	sonic_Y_l
		SEC
		SBC	tmp_var_2B
		STA	sonic_Y_l_new
		LDA	sonic_Y_h
		SBC	#0
		STA	sonic_Y_h_new
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	loc_B2BAA
		SBC	#16
		STA	sonic_Y_l_new
		JMP	loc_B2BAA
; ---------------------------------------------------------------------------

loc_B2B90:
		LDA	sonic_Y_l
		CLC
		ADC	tmp_var_2B
		STA	sonic_Y_l_new
		LDA	sonic_Y_h
		ADC	#0
		STA	sonic_Y_h_new
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	loc_B2BAA
		ADC	#15
		STA	sonic_Y_l_new
		INC	sonic_Y_h_new

loc_B2BAA:
		LDA	sonic_anim_num
		CMP	#9
		BEQ	@chek_move_limits_X
		CMP	#$11
		BEQ	@chek_move_limits_X
		JSR	check_collision_with_bkg

@chek_move_limits_X:
		LDA	sonic_X_l_new
		SEC
		SBC	sonic_X_l
		STA	tmp_var_28
		LDA	sonic_X_h_new
		SBC	sonic_X_h
		BPL	loc_B2BDB
		LDA	tmp_var_28
		EOR	#$FF
		SEC
		ADC	#0
		CMP	#$F
		BCC	loc_B2BD8
		LDA	sonic_X_l
		SEC
		SBC	#$F
		STA	sonic_X_l_new
		LDA	sonic_X_h
		SBC	#0
		STA	sonic_X_h_new

loc_B2BD8:
		JMP	chek_move_limits_Y
; ---------------------------------------------------------------------------

loc_B2BDB:
		LDA	tmp_var_28
		CMP	#$F
		BCC	chek_move_limits_Y
		LDA	sonic_X_l
		CLC
		ADC	#$F
		STA	sonic_X_l_new
		LDA	sonic_X_h
		ADC	#0
		STA	sonic_X_h_new

chek_move_limits_Y:
		LDA	sonic_Y_l_new
		SEC
		SBC	sonic_Y_l
		STA	tmp_var_28
		LDA	sonic_Y_h_new
		SBC	sonic_Y_h
		BPL	loc_B2C21
		LDA	tmp_var_28
		EOR	#$FF
		SEC
		ADC	#0
		CMP	#7
		BCC	loc_B2C1E
		CMP	#17
		BCC	@check_y_lim
		LDA	sonic_Y_l_new
		CMP	#$E0
		BCC	@check_y_lim
		LDA	sonic_Y_l
		CMP	#$10
		BCC	locret_B2C41
@check_y_lim:
		LDA	sonic_Y_l
		SEC
		SBC	#7		; Y speed max
		STA	sonic_Y_l_new
		LDA	sonic_Y_h
		SBC	#0
		STA	sonic_Y_h_new
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	loc_B2C1E
		SEC
		SBC	#$10
		STA	sonic_Y_l_new

loc_B2C1E:
		RTS
; ---------------------------------------------------------------------------

loc_B2C21:
		LDA	tmp_var_28
		CMP	#7
		BCC	locret_B2C41
		CMP	#17
		BCC	@check_y_lim
		LDA	sonic_Y_l_new
		CMP	#$10
		BCS	@check_y_lim
		LDA	sonic_Y_l
		CMP	#$E0
		BCS	locret_B2C41
@check_y_lim:		
		LDA	sonic_Y_l
		CLC
		ADC	#7		; Y speed max
		STA	sonic_Y_l_new
		LDA	sonic_Y_h
		ADC	#0
		STA	sonic_Y_h_new
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	locret_B2C41
		CLC
		ADC	#$10		; fix sonic Y
		STA	sonic_Y_l_new
		INC	sonic_Y_h_new

locret_B2C41:
		RTS
; End of function sonic_move

; ---------------------------------------------------------------------------

m_pixels_by_X_spd_water:.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 2,   2,   2,	2,   2,	  2,   2,   2

m_pixels_by_X_spd:.BYTE	   1,	1,   2,	  2,   2,   3,	 3,   3,   3,	3,   3,	  3,   3,   4,	 4,   5
m_pixels_by_X_sub:.BYTE    0, $80,   0,	$40, $80,   0,	 0,   0,   0, $40, $40,	$80, $80,   0, $40,   0

m_pixels_by_Y_spd:.BYTE	   1,	2,   3,	  4,   5,   6,	 7,   7,   7,	7,   7,	  7,   7,   7,	 7,   7

m_pixels_by_X_spd_faster:
		.BYTE    2,   3,   4,   5,   5,   5,   5,   5,   6,   6,   6,   6,   6,   7,   7,   7

fastest_speed_tbl:
		.BYTE	 2,   3,   4,   5,   5,   6,   6,   6,   7,   7,   7,   7,   7,   8,   8,  10   ; test33 - X2


; =============== S U B	R O U T	I N E =======================================


get_block_behind_Sonic:
		STA	tmp_var_25
		LDA	sonic_X_l
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		LDA	sonic_Y_l
		SEC
		SBC	tmp_var_25
		STA	temp_y_l
		LDA	sonic_Y_h
		SBC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	@ok
		SBC	#$10
		STA	temp_y_l
@ok:
		JMP	get_block_number


; =============== S U B	R O U T	I N E =======================================


check_collision_with_bkg:
		LDA	level_id
		CMP	#MARBLE
		BNE	@not_marble_zone
		LDA	#1
		JSR	get_block_behind_Sonic
		CMP	#$C
		BNE	@clr_mask_20
		LDA	sonic_attribs
		ORA	#$20
		BNE	@set_mask_20 ; JMP
@clr_mask_20:
		CMP	#$52
		BEQ	@not_marble_zone
		AND	#$FE	; 50-51
		CMP	#$50
		BEQ	@not_marble_zone
		LDA	sonic_attribs
		AND	#$DF
@set_mask_20:
		STA	sonic_attribs
@not_marble_zone:
		
		LDA	#7
		CLC
		ADC	sonic_X_l_new
		STA	temp_x_l
		LDA	sonic_X_h_new
		ADC	#0
		STA	temp_x_h
		LDA	sonic_Y_h_new
		STA	temp_y_h
		LDA	sonic_Y_l_new
		STA	temp_y_l

retry_coll1:
		JSR	sonic_bkg_coll
		STA	last_block1 ; for blocks phys hacks (1)
		JSR	blocks_000_127_phys ; /blocks_128_255_phys
		LDA	tmp_var_26
		BNE	retry_coll1
; ---------------------------------------------------------------------------
collision2_pos2:
		LDA	temp_x_l
		SEC
		SBC	#14
		STA	temp_x_l
		BCS	retry_coll2
		DEC	temp_x_h
; ---------------------------------------------------------------------------

retry_coll2:
		JSR	sonic_bkg_coll
		STA	last_block2 ; for blocks phys hacks (2)
		JSR	blocks_000_127_phys ; /blocks_128_255_phys
		LDA	tmp_var_26
		BNE	retry_coll2
; ---------------------------------------------------------------------------
set_new_sonic_x_y:
		LDA	temp_x_l
		CLC
		ADC	#7
		STA	sonic_X_l_new
		LDA	temp_x_h
		ADC	#0
		STA	sonic_X_h_new
		LDA	temp_y_h
		STA	sonic_Y_h_new
		LDA	temp_y_l
		STA	sonic_Y_l_new
		;RTS
		
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz
		LDA	act_id
		CMP	#2
		BEQ	@not_sbz
		LDA	#16
		JSR	get_block_behind_Sonic
		CMP	#$5A
		BEQ	@damage_sonic
		CMP	#$59
		BEQ	@damage_sonic
		CMP	#$58
		BNE	@check_conveyor
@damage_sonic:
		LDA	sonic_state
		BMI	@not_sbz
		LDA	sonic_blink_timer
		ORA	invicible_timer
		BNE	@not_sbz
		LDA	#6	; blink timer and flag obj/bkg
		JMP	sonic_get_dmg ; to main.asm

@not_sbz:
		RTS
; ---------------------------------------------------------------------------

@check_conveyor:
		LDA	act_id
		CMP	#1	; act2
		BNE	@not_sbz
		
		LDA	sonic_Y_l
		AND	#$F
		CMP	#$F
		BNE	@not_sbz
		
		LDA	sonic_X_l
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		LDX	sonic_Y_l
		INX
		STX	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h
		JSR	get_block_number
		CMP	#$5E
		BEQ	@move_left
		CMP	#$5F
		BEQ	@move_right
		RTS

@move_left:
		LDA	sonic_X_l_new
		BNE	@no_dec_h
		DEC	sonic_X_h_new
@no_dec_h:
		DEC	sonic_X_l_new
		RTS
@move_right:
		INC	sonic_X_l_new
		BNE	@no_inc_h
		INC	sonic_X_h_new
@no_inc_h:
		RTS
; ---------------------------------------------------------------------------

sonic_bkg_coll:
		LDA	#0
		STA	tmp_var_26
		JSR	get_block_number
		TAY
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	level_bkg_prg
		STA	MMC3_bank_data
		LDA	$8500,Y
		STA	block_number
;		BMI	loc_B2D0E
		LDY	#$86
		STY	MMC3_bank_select
		LDY	#$16
;		BNE	loc_B2D15	; JMP
; ---------------------------------------------------------------------------

;loc_B2D0E:
;		LDY	#$86
;		STY	MMC3_bank_select
;		LDY	#$17
;loc_B2D15:
		STY	MMC3_bank_data
		
		ELSE
		LDA	level_bkg_prg
		STA	VRC7_prg_8000
		LDA	$8500,Y
		STA	block_number
		LDY	#$16
		STY	VRC7_prg_8000
		ENDIF
		
		RTS

; ---------------------------------------------------------------------------


X_speed_hack:
		JSR	get_speed_index
		BMI	normal_speed
		BEQ	faster_speed
		LDA	fastest_speed_tbl,Y
		BNE	check_limits
normal_speed:
;		LDA	sonic_X_speed
;		CMP	#8
;		BCC	@lowest_speed
		LDA	m_pixels_by_X_sub,Y
		STA	tmp_var_2B
		LDA	m_pixels_by_X_spd,Y ; original
		RTS
;@lowest_speed:
;		LDA	#$C0	; 0,75 pix/sec
;		STA	tmp_var_2B
;		LDA	#0
;		RTS
		
faster_speed:
		LDA	m_pixels_by_X_spd_faster,Y ; faster speed

check_limits:
		CMP	#6
		BCC	@ok1
		LDX	last_block1
		JSR	@check_limited_block
		LDX	last_block2
		
@check_limited_block:
		CPX	#$7A	; spring yard fix near h-springs
		BEQ	@limit_to_5
		;CPX	#$7B
		;BEQ	@limit_to_4
		;CPX	#$83
		;BEQ	@limit_to_4
		CPX	#$84	; spring yard fix near h-springs
		BEQ	@limit_to_3
		CPX	#$81	; spring yard fix near h-springs (left)
		BEQ	@limit_to_3
		
		;CPX	#$4F	; star light fix
		;BEQ	@limit_to_5
		;CPX	#$51	; star light fix
		;BEQ	@limit_to_5
		
		CPX	#$10
		BCC	@ok1
		CPX	#$55
		BCS	@ok1
		PHA
		LDA	blocks_limit_tab,X
		EOR	sonic_attribs
		AND	#1	; left-right movement
		BEQ	@restore_A
		LDA	blocks_limit_tab,X
		ASL		; limit 5/7 flag
		PLA

;		CPX	#$44
;		BCS	@ok1
;		CPX	#$30	; 30-44
		BCS	@limit_to_5
@chk_lim7:		
		CMP	#7	; 10-2F
		BCC	@limit_to_7
		LDA	#7
@limit_to_7:
		RTS

@limit_to_5:
		LDA	#5	; limit to 5
@ok1
		RTS
		
@restore_A:
		PLA
		RTS
		
@limit_to_3:
		LDA	#3
		RTS
; ---------------------------------------------------------------------------

get_speed_index:
		LDX	#0
		LDA	speed_shoes_timer ; speed shoes
		BEQ	@no_spd_up1
		INX	; 1
		
@no_spd_up1:
		BIT	sonic_state
		BPL	@no_spd_up2
		INX	; 1/2
		LDA	super_em_cnt
		CMP	#7	; 7 super emeralds
		BCC	@no_spd_up2
		LDX	#2 ; 2

@no_spd_up2
		DEX	; test BMI/BEQ/BPL
		RTS
; ---------------------------------------------------------------------------
		
X_speed_hack_water:
		JSR	get_speed_index
		BMI	normal_speed_water
		BEQ	normal_speed	; faster_speed_water
		JMP	faster_speed	; fastest_speed_water
		
normal_speed_water:
		LDA	m_pixels_by_X_spd_water,Y
		RTS


; =============== S U B	R O U T	I N E =======================================


update_sonic_timers:
		LDA	sonic_inertia_timer ; can't skid timer
		BEQ	@loc_C2AB3
		DEC	sonic_inertia_timer ; can't skid timer

@loc_C2AB3:
		LDA	invicible_timer
		BEQ	@loc_C2AC3
		DEC	invicible_timer
		BNE	@loc_C2AC3
		LDX	level_id
		LDA	sonic_state
		BMI	@supers
		LDA	boss_func_num
		BEQ	@no_boss
		LDA	#$29	; boss song
		BNE	@set_lvl_music
	
@no_boss
		LDA	music_to_play
		CMP	#$22
		BEQ	@loc_C2AC3
		LDA	music_by_level,X
		BNE	@set_lvl_music ; JMP
@supers
		LDA	music_to_play
		CMP	#$29	; boss song
		BEQ	@loc_C2AC3
		JSR	set_supers_music
@set_lvl_music:
		STA	music_to_play

@loc_C2AC3:				; in water flag
		LDA	water_timer
		BEQ	@loc_C2ACD
		CMP	#WATER_TIMEOUT+1
		BCS	@loc_C2ACD
		INC	water_timer	; in water flag
		LDA	sonic_state
		BPL	@loc_C2ACD
		LDA	super_em_cnt
		CMP	#7	; 7 super emeralds
		BCC	@loc_C2ACD
		STA	water_timer

@loc_C2ACD:
		LDA	sonic_blink_timer
		BEQ	@loc_C2AD5
		DEC	sonic_blink_timer

@loc_C2AD5:
		LDA	speed_shoes_timer
		BEQ	@locret_C2ADD
		DEC	speed_shoes_timer

@locret_C2ADD:
		RTS
; End of function update_sonic_timers



; =============== S U B	R O U T	I N E =======================================


draw_pause_sprites:
		LDX	#pause_sprites_data_end-pause_sprites_data
		STX	sprite_id
		DEX

@load_pause_text
		LDA	pause_sprites_data,X
		STA	sprites_Y,X
		DEX
		BPL	@load_pause_text
		LDA	#$2F800/$400
		STA	chr_spr_bank1
		RTS
		
pause_sprites_data:
		.BYTE	$6F,$2B,$03,$70 ; P
		.BYTE	$77,$3B,$03,$70 ; P
		
		.BYTE	$6F,$2C,$03,$78 ; A
		.BYTE	$77,$3C,$03,$78 ; A
		
		.BYTE	$6F,$2D,$03,$80 ; U
		.BYTE	$77,$3D,$03,$80 ; U
		
		.BYTE	$6F,$2E,$03,$88 ; S
		.BYTE	$77,$3E,$03,$88 ; S

		.BYTE	$6F,$2F,$03,$90 ; E
		.BYTE	$77,$3F,$03,$90 ; E
		
pause_sprites_data_end:


; =============== S U B	R O U T	I N E =======================================


;hide_all_sprites_fast:
;		LDA	#$F8
;var1 = 0
;		REPT	64
;		STA	sprites_Y+var1
;var1 = var1+4
;		ENDR
;		RTS


; =============== S U B	R O U T	I N E =======================================

		IF	(REPLAY_WRITE=1)
DEMO_SAVE:
		LDY	#0
		LDA	joy1_hold
		CMP	(demo_ptr1),Y
		BNE	@new_value_press
		INY
		CLC
		LDA	(demo_ptr1),Y
		ADC	#1
		BCS	@new_value_press
		STA	(demo_ptr1),Y
		RTS

@new_value_press:
		INC	demo_ptr1
		INC	demo_ptr1
		BEQ	@stop_record

		LDY	#0
		LDA	joy1_hold
		STA	(demo_ptr1),Y
		;TYA	; A=00 (clear rep. timer)
		INY
		TYA	; A=01 (init rep. timer)
		STA	(demo_ptr1),Y
		RTS

; stop if record hold or press > 256 bytes.
@stop_record:
		LDA	#0
		STA	demo_record_flag
		RTS
		
		ELSE
DEMO_SAVE:
		RTS
		ENDIF

; ---------------------------------------------------------------------------
		align	256
blocks_limit_tab:
		incbin	blocks_speed_limit.bin
		
		;.pad	$C000,$FF
