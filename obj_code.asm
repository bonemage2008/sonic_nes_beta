		org	$8000	; 28010
		
;		MACRO	hide_obj_sprite
;		LDA	#$6F	; put sprite out of screen
;		STA	objects_Y_relative_h,Y	
;		ENDM


; =============== S U B	R O U T	I N E =======================================


object_wasp:
		LDA	#2
		LDY	objects_var_cnt,X ; var/counter
		BMI	loc_8001B
		JSR	object_sub_X
		JMP	loc_8002C
; ---------------------------------------------------------------------------

loc_8001B:
		JSR	object_add_X

loc_8002C:
		LDA	objects_X_l,X
		AND	#$F
		BNE	loc_8004C
		LDA	objects_var_cnt,X ; var/counter
		STA	tmp_var_25
		CLC
		ADC	#8
		STA	objects_var_cnt,X ; var/counter
		EOR	tmp_var_25
		AND	#$80
		BEQ	loc_8004C
		LDA	objects_var_cnt,X ; var/counter
		AND	#$FE
		STA	objects_var_cnt,X ; var/counter

loc_8004C:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_800AE
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_800AE:
		LDA	objects_Y_relative_h,X
		BEQ	@skip_check_dist
		LDA	objects_Y_relative_l,X
		CMP	#$70	; out of screen (Y)
		BCC	collision0_with_box32x24
		
@skip_check_dist
		LDY	objects_X_relative_l,X
		LDA	objects_X_relative_h,X
		BMI	@from_left
		CPY	#$78	; lower - closier
		BCC	@wasp_attack
		BCS	collision0_with_box32x24

@from_left:
		CPY	#$80	; greater - closier
		BCC	collision0_with_box32x24

@wasp_attack:
		LDA	objects_var_cnt,X
		TAY
		AND	#1
		BNE	collision0_with_box32x24
		LDA	objects_X_relative_l,X
		EOR	objects_Y_relative_l,X
		AND	#$F0
		BEQ	@set_wasp_attack
		CMP	#$F0
		BNE	collision0_with_box32x24

@set_wasp_attack:
		INC	objects_type,X
		TYA
		ORA	#1
		STA	objects_var_cnt,X ; var/counter
		LDA	#32	; wasp shoot delay
		STA	objects_delay,X

collision0_with_box32x24:
		LDA	#32
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		JMP	check_collision_both_hitbox_type0
; End of function object_wasp


; =============== S U B	R O U T	I N E =======================================


object_wasp_shooting:
;		LDA	Frame_Cnt
;		AND	#$1F
		LDA	objects_delay,X
		BEQ	@wasp_shoot
		DEC	objects_delay,X
		JMP	loc_80157
; ---------------------------------------------------------------------------

@wasp_shoot:				; var/counter
		LDA	objects_var_cnt,X
		CLC
		ADC	#2
		STA	tmp_var_25
		AND	#6
		BNE	loc_80105
		LDA	objects_var_cnt,X ; var/counter
		LSR	A
		BCS	set_after_shot_delay
		LDA	objects_var_cnt,X ; var/counter
		AND	#$F9
		ORA	#1
		STA	objects_var_cnt,X ; var/counter
		DEC	objects_type,X	; restore normal wasp
		JMP	loc_80157
; ---------------------------------------------------------------------------
		
set_after_shot_delay:
		ASL	A
		STA	objects_var_cnt,X ; var/counter
		LDA	#16	; wasp delay after shooting
		STA	objects_delay,X
		JMP	loc_80157
; ---------------------------------------------------------------------------

loc_80105:
		CMP	#2
		BNE	loc_80157
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS	; fix - check obj limit
		BCS	loc_80157
		LDA	tmp_var_25
		ORA	#4
		STA	objects_var_cnt,X ; var/counter
		AND	#$80
		STA	objects_var_cnt,Y ; var/counter
		BMI	loc_8012D
		LDA	#4
		BNE	wasp_set_bullet_x
; ---------------------------------------------------------------------------

loc_8012D:
		LDA	#$14
wasp_set_bullet_x:
		CLC
		ADC	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,Y

loc_8013E:
		LDA	objects_Y_l,X
		CMP	#$F0-$1C
		BCC	@ok1
		ADC	#$F+$1C ; fix for projectile pos on screens crossing
		SEC		; +1 to h
		BCS	@ok2	; JMP
@ok1
		ADC	#$1C
@ok2
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		ADC	#0
		STA	objects_Y_h,Y
		LDA	#$1A
		STA	objects_type,Y
		hide_obj_sprite
		INY
		STY	objects_cnt

loc_80157:
		LDA	#32
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#0
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_wasp_shooting


; =============== S U B	R O U T	I N E =======================================


object_monitor:
		JSR	obj_update_rel_pos_and_test
		BNE	object_remove
		LDA	#25
		STA	hitbox_h
		;LDA	#25
		STA	hitbox_v
		JMP	collision_vs_monitor
; End of function object_monitor


; =============== S U B	R O U T	I N E =======================================


object_remove:
		LDX	object_slot
		LDA	#$6F	; put sprite out of screen
		STA	objects_Y_relative_h,X
		LDA	#0
		STA	objects_type,X
		STA	objects_delay,X
		LDA	objects_sav_slot,X
		TAY
		LDX	killed_objs_tbl,Y
		LDA	killed_objs_mem,X
		AND	killed_objs_mask,Y
		STA	killed_objs_mem,X
		LDX	object_slot ; fix
		RTS
; End of function object_remove


; =============== S U B	R O U T	I N E =======================================


object_jumping_fish:
		LDA	objects_var_cnt,X
		CLC
		ADC	#2
		STA	objects_var_cnt,X
		PHP
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	fish_Y_spd_tbl,Y
		PLP
		BMI	@fish_move_down
		JSR	object_sub_Y
		JMP	@fish_check_coll
; ---------------------------------------------------------------------------

@fish_move_down:
		JSR	object_add_Y

@fish_check_coll:
		LDA	#24	; fix jumping fish hitbox
		STA	hitbox_h
		;LDA	#24
		STA	hitbox_v
		LDA	#0
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_jumping_fish

; ---------------------------------------------------------------------------
fish_Y_spd_tbl:	.BYTE	 4,   4,   4,	4
		.BYTE	 4,   4,   2,	1
		.BYTE	 1,   2,   4,	4
		.BYTE	 4,   4,   4,	4

; =============== S U B	R O U T	I N E =======================================


object_wasp_projectile:
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_8027D
		CMP	#$10
		BCS	loc_80269
		CLC
		ADC	#1
		STA	objects_var_cnt,X ; var/counter
		BNE	loc_802AB

loc_80269:
		LDA	#2
		JSR	object_sub_X
		JMP	loc_8029A
; ---------------------------------------------------------------------------

loc_8027D:
		CMP	#$90
		BCS	loc_80289
		CLC
		ADC	#1
		STA	objects_var_cnt,X ; var/counter
		BNE	loc_802AB

loc_80289:
		LDA	#2
		JSR	object_add_X

loc_8029A:
		LDA	#2
		JSR	object_add_Y

loc_802AB:
		LDA	#8
		STA	hitbox_h
		;LDA	#8
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_wasp_projectile


; =============== S U B	R O U T	I N E =======================================

; $04

object_crabmeat:
;		JMP	object_crabmeat
		LDA	objects_delay,X
		BEQ	@ok
		DEC	objects_delay,X
		JMP	crabmeat_std

@ok:
		LDA	Frame_Cnt
		LSR	A
		BCS	crabmeat_std
		LDA	objects_var_cnt,X
		;CLC
		ADC	#2
		STA	objects_var_cnt,X
		BPL	@move_left
		JSR	object_inc_X
		JMP	@nx
@move_left:
		JSR	object_dec_X

@nx:
		LDA	objects_var_cnt,X
		AND	#$7E
		CMP	#$7E
		BNE	@no_attack
@attack:
		LDA	#5	; object_crabmeat_shooting
		STA	objects_type,X
		LDA	#60	; crab shoot delay
		STA	objects_delay,X

@no_attack:
crabmeat_std:
		JSR	obj_update_rel_pos_and_test
		BEQ	@ok
		JMP	object_remove
@ok
		LDA	#24	; crabmeat correct size = 24x24
		STA	hitbox_h
		;LDA	#24
		STA	hitbox_v
		JMP	check_collision_both_hitbox_type0


; =============== S U B	R O U T	I N E =======================================

; $05

object_crabmeat_shooting:
		LDA	objects_delay,X
		BEQ	@crabmeat_shoot
		DEC	objects_delay,X
		JMP	crabmeat_std
; ---------------------------------------------------------------------------

@crabmeat_shoot:
		LDA	#4	; object_crabmeat
		STA	objects_type,X
		
		LDA	objects_var_cnt,X
		LSR	A
		BCS	@ok
		LDA	objects_var_cnt,X
		ORA	#1	; skip first attack flag
		STA	objects_var_cnt,X
		JMP	crabmeat_std
@ok
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-1	; check obj limit
		BCS	crabmeat_std
		
		LDA	#60	; delay
		STA	objects_delay,X
		
		LDA	#$80
		STA	objects_var_cnt,Y
		LDA	#0
		STA	objects_var_cnt+1,Y
		
		LDA	objects_X_l,X
		SEC
		SBC	#2
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		SBC	#0
		STA	objects_X_h,Y
		
		LDA	objects_X_l,X
		CLC
		ADC	#$12
		STA	objects_X_l+1,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h+1,Y
		
		LDA	objects_Y_l,X
		STA	objects_Y_l,Y
		STA	objects_Y_l+1,Y
		LDA	objects_Y_h,X
		STA	objects_Y_h,Y
		STA	objects_Y_h+1,Y
		LDA	#$1B
		STA	objects_type,Y
		STA	objects_type+1,Y
		hide_obj_sprite
		INY
		hide_obj_sprite
		INY
		STY	objects_cnt
		JMP	crabmeat_std


; =============== S U B	R O U T	I N E =======================================


object_crabmeat_projectile:
;		JMP	object_crabmeat_projectile
		LDA	objects_var_cnt,X
		AND	#$80
		STA	tmp_var_25
		BMI	@move_left
		JSR	object_inc_X
		JMP	@nx
@move_left:
		JSR	object_dec_X
@nx:
		LDA	objects_var_cnt,X
		AND	#$7F
		TAY
		CMP	#41
		BCS	@limit
		;CLC
		ADC	#1
@limit:
		ORA	tmp_var_25
		STA	objects_var_cnt,X
		LDA	crabmeat_bullet_Y_table,Y
		BEQ	@skip_y
		BPL	@sub_y
		EOR	#$FF
		CLC
		ADC	#1
		JSR	object_add_Y
		JMP	projectile_std

@sub_y:
		JSR	object_sub_Y
@skip_y:
		JMP	projectile_std

crabmeat_bullet_Y_table:
		.BYTE	0
		
		.BYTE	4 ; 41
		.BYTE	4 ; 37
		.BYTE	3 ; 33
		.BYTE	3 ; 30
		.BYTE	3 ; 27
		.BYTE	3 ; 24
		.BYTE	2 ; 21
		.BYTE	3 ; 19
		
		.BYTE	2 ; 16
		.BYTE	2 ; 14
		.BYTE	1 ; 13
		.BYTE	2 ; 11
		.BYTE	1 ; 10
		.BYTE	2 ; 08
		.BYTE	1 ; 07
		.BYTE	0 ; 07
		
		.BYTE	1 ; 06
		.BYTE	0 ; 06
		.BYTE	0 ; 06
		.BYTE	0 ; 06
		.BYTE	0 ; 06
		.BYTE	-1 ; 07
		.BYTE	-1 ; 08
		.BYTE	-1 ; 09
		
		.BYTE	-1 ; 10
		.BYTE	-2 ; 12
		.BYTE	-1 ; 13
		.BYTE	-2 ; 15
		.BYTE	-2 ; 17
		.BYTE	-3 ; 20
		.BYTE	-2 ; 22
		.BYTE	-3 ; 25
		
		.BYTE	-3 ; 28
		.BYTE	-3 ; 31
		.BYTE	-4 ; 35
		.BYTE	-3 ; 38
		.BYTE	-4 ; 42
		.BYTE	-4 ; 46
		.BYTE	-5 ; 51
		.BYTE	-4 ; 55
		
		.BYTE	-5 ; ??
		

; =============== S U B	R O U T	I N E =======================================


object_projectile:
		LDY	#1
		LDA	objects_type,X
		CMP	#$1B
		BEQ	loc_8043F
		LDY	#2

loc_8043F:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_8045A
		LDA	tmp_var_25
		JSR	object_sub_X
		JMP	loc_8046B
; ---------------------------------------------------------------------------

loc_8045A:
		LDA	tmp_var_25
		JSR	object_add_X

loc_8046B:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$1F
		STA	tmp_var_25
		TAY
		LDA	objects_type,X
		CMP	#$1B
		BEQ	loc_8047E
		TYA
		ORA	#$20
		TAY

loc_8047E:
		LDA	tmp_var_25
		JSR	projectile_change_Y
		LDA	Frame_Cnt
		AND	#1
		BNE	projectile_std
		LDA	tmp_var_25
		AND	#$1F
		TAY
		INY
		CPY	#$1F
		BCC	loc_804BD
		LDY	#$1E

loc_804BD:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		AND	#$E0
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter

projectile_std:
		LDA	#8
		STA	hitbox_h
		;LDA	#8
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_projectile
; ---------------------------------------------------------------------------

projectile_change_Y:
		CMP	#$10
		LDA	objs_Y_spd_tbl,Y
		BCS	@proj_move_down
		JMP	object_sub_Y
; ---------------------------------------------------------------------------

@proj_move_down:
		JMP	object_add_Y
; ---------------------------------------------------------------------------
objs_Y_spd_tbl:	.BYTE	 5,   4,   4,	4,   4,	  3,   3,   3,	 3,   3,   2,	2,   2,	  1,   1,   0
		.BYTE	 0,   1,   1,	2,   2,	  2,   3,   3,	 3,   3,   4,	4,   4,	  4,   5,   5
		.BYTE	 4,   4,   4,	4,   3,	  3,   3,   3,	 3,   2,   2,	2,   2,	  1,   1,   0
		.BYTE	 0,   1,   1,	1,   2,	  2,   2,   3,	 3,   3,   3,	4,   4,	  4,   4,   4

; =============== S U B	R O U T	I N E =======================================


object_chameleon:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_8057A
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_8057A:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$7F
		BNE	loc_805AD
		LDA	objects_X_relative_h,X
		BMI	loc_80594
		LDA	objects_X_relative_l,X
		CMP	#$90
		BCS	loc_805A0
		LDA	#4
		STA	objects_var_cnt,X ; var/counter
		BNE	loc_805A0

loc_80594:
		LDA	objects_X_relative_l,X
		CMP	#$60
		BCC	loc_805A0
		LDA	#$84
		STA	objects_var_cnt,X ; var/counter

loc_805A0:
		LDA	objects_type,X
		CMP	#6
		BEQ	locret_805AC
		LDA	#8
		STA	objects_type,X

locret_805AC:
		RTS
; ---------------------------------------------------------------------------

loc_805AD:
		TAY
		LDA	Frame_Cnt
		AND	#$F
		BNE	loc_805B5
		INY

loc_805B5:
		STY	tmp_var_25
		CPY	#$C
		BEQ	chameleon_shoot
		CPY	#$1C
		BCC	chameleon_upd_dir
		JMP	object_remove
; ---------------------------------------------------------------------------
;		LDA	#0
;		STA	objects_type,X
; ---------------------------------------------------------------------------

chameleon_shoot:
		TYA
		CLC
		ADC	#4
		STA	tmp_var_25
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS	; fix - check obj limit
		BCS	chameleon_upd_dir
		LDA	objects_var_cnt,X ; var/counter
		STA	objects_var_cnt,Y ; var/counter
		BMI	loc_805FB
		LDA	#$10
		CLC
		ADC	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,Y
		JMP	loc_80607
; ---------------------------------------------------------------------------

loc_805FB:
		LDA	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		STA	objects_X_h,Y

loc_80607:
		LDA	objects_Y_l,X
		CLC
		ADC	#$10
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		ADC	#0
		STA	objects_Y_h,Y
		LDA	#$1C
		STA	objects_type,Y
		hide_obj_sprite
		INY
		STY	objects_cnt

chameleon_upd_dir:
		LDA	objects_X_relative_h,X
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X
		;RTS
		LSR	A
		LSR	A
		AND	#7
		TAY
		LDA	byte_748E6_bank9,Y
		BPL	chameleon_hitbox1
		RTS
; End of function object_chameleon

byte_748E6_bank9:     .BYTE  $FF, $F0,   0,   0,  $C,   0, $F0, $FF


; =============== S U B	R O U T	I N E =======================================


object_08:
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		TAY
		LDA	Frame_Cnt
		AND	#7
		BNE	loc_8063F
		INY

loc_8063F:
		STY	tmp_var_25
		CPY	#8
		BCC	loc_80660
		CPY	#$10
		BCS	loc_80675
		LDA	Frame_Cnt
		AND	#2
		BNE	loc_80660
		JSR	object_inc_Y

loc_80660:
		LDA	objects_X_relative_h,X
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter
chameleon_hitbox1:
		LDA	#24
		STA	hitbox_h
		LDA	#32
		STA	hitbox_v
		JMP	loc_806B1
; ---------------------------------------------------------------------------

loc_80675:
		LDA	#32
		STA	hitbox_h
		LDA	#16
		STA	hitbox_v
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_8069B
		LDA	#2
		JSR	object_sub_X
		LDA	#$11
		STA	objects_var_cnt,X ; var/counter
		JMP	loc_806B1
; ---------------------------------------------------------------------------

loc_8069B:
		LDA	#2
		JSR	object_add_X
		LDA	#$91
		STA	objects_var_cnt,X ; var/counter

loc_806B1:
		LDA	#0
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_08


; =============== S U B	R O U T	I N E =======================================


object_small_blue_spike:
		LDA	#2
		LDY	objects_var_cnt,X ; var/counter
		BMI	loc_806D3
		JSR	object_sub_X
		JMP	loc_806E4
; ---------------------------------------------------------------------------

loc_806D3:
		JSR	object_add_X

loc_806E4:
		LDA	#8
		STA	hitbox_h
		;LDA	#8
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_small_blue_spike


; =============== S U B	R O U T	I N E =======================================


object_animal:
		LDA	objects_var_cnt,X ; var/counter
		STA	tmp_var_25
		AND	#$10
		BEQ	loc_80707
		JSR	check_for_solid_block ;	block number in	Y, solid flag in A (BEQ/BNE)
		BEQ	loc_80707
		LDA	#$80
		STA	tmp_var_25

loc_80707:
		LDA	tmp_var_25
		BPL	loc_8071E
		LDA	#2
		JSR	object_sub_X
		LDA	tmp_var_25

loc_8071E:
		AND	#$1F
		TAY
		JSR	projectile_change_Y
		LDA	Frame_Cnt
		AND	#1
		BEQ	loc_80761
		INY

loc_80761:
		CPY	#$1E
		BCC	loc_80767
		LDY	#$1E

loc_80767:
		STY	tmp_var_26
		LDA	tmp_var_25
		AND	#$80
		ORA	tmp_var_26
		STA	objects_var_cnt,X ; var/counter
		JSR	obj_update_rel_pos_and_test
		BEQ	locret_8077C
		JMP	remove_temp_obj

locret_8077C:
		RTS
; End of function object_animal


; =============== S U B	R O U T	I N E =======================================


object_ring:
		LDA	Frame_Cnt
		LSR	A
		BCC	loc_80788
		JMP	ring_check_coll
; ---------------------------------------------------------------------------

loc_80788:
		LDA	objects_var_cnt,X
		STA	tmp_var_25
		BMI	loc_807A3
		LDA	#3
		JSR	object_add_X
		JMP	loc_807B4
; ---------------------------------------------------------------------------

loc_807A3:
		LDA	#3
		JSR	object_sub_X

loc_807B4:
		LDA	tmp_var_25
		AND	#$F
		TAY
		CMP	#8
		LDA	ring_y_shake_tbl,Y
		BCS	loc_807DD
		JSR	object_sub_Y
		JSR	check_for_solid_block ;	block number in	Y, solid flag in A (BEQ/BNE)
		BEQ	loc_8080D
		LDA	tmp_var_25
		EOR	#$80
		STA	tmp_var_25
		JMP	loc_8080D
; ---------------------------------------------------------------------------

loc_807DD:
		JSR	object_add_Y
		JSR	check_for_solid_block ;	block number in	Y, solid flag in A (BEQ/BNE)
		BEQ	loc_8080D
		LDA	tmp_var_25
		CLC
		ADC	#$10
		STA	tmp_var_25
		AND	#$70
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	ring_cnt_tbl,Y
		BPL	loc_80820
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_8080D:
		LDA	Frame_Cnt
		AND	#3
		BNE	ring_check_coll
		LDA	tmp_var_25
		AND	#$F
		CLC
		ADC	#1
		CMP	#$10
		BCC	loc_80820
		LDA	#$F

loc_80820:
		STA	tmp_var_26
		LDA	tmp_var_25
		AND	#$F0
		ORA	tmp_var_26
		STA	objects_var_cnt,X ; var/counter

ring_check_coll:
		LDA	#16
		STA	hitbox_h
		;LDA	#16
		STA	hitbox_v
		LDA	#1
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_ring

; ---------------------------------------------------------------------------
ring_cnt_tbl:	.BYTE 0
		.BYTE 1
		.BYTE 1
		.BYTE 2
		.BYTE 2
		.BYTE 3
		.BYTE 3
		.BYTE $FF
ring_y_shake_tbl:.BYTE 6
		.BYTE 6
		.BYTE 6
		.BYTE 4
		.BYTE 4
		.BYTE 2
		.BYTE 1
		.BYTE 0
		.BYTE 1
		.BYTE 2
		.BYTE 4
		.BYTE 4
		.BYTE 6
		.BYTE 6
		.BYTE 6
		.BYTE 7


; =============== S U B	R O U T	I N E =======================================

; $7D
object_pick_ring_anim:
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		CMP	#16
		BCS	@del_ring_anim

		JSR	obj_update_rel_pos_and_test
		BEQ	@ret
@del_ring_anim:
		JMP	remove_temp_obj
@ret:
		RTS


; =============== S U B	R O U T	I N E =======================================

; 1d

object_explode:
		INC	objects_var_cnt,X ; var/counter
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		TAY
		LSR	A
		TYA
		BCS	@not_odd
		CMP	#$20
		BCC	@exp_wait
		BCS	@skip_create_animal
@not_odd:
		CMP	#$30
		BCC	@exp_wait
		LDA	objects_var_cnt,X ; var/counter
		BMI	@skip_create_animal
		LDA	Frame_Cnt
		AND	#1
		ORA	#$18
		STA	objects_type,X
		LDA	#0
		STA	objects_var_cnt,X ; var/counter

@exp_wait:
		JSR	obj_update_rel_pos_and_test
		BEQ	locret_8087C
@skip_create_animal:
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

locret_8087C:
		RTS
; End of function object_explode


; =============== S U B	R O U T	I N E =======================================


check_kill_obj:
		LDA	invicible_timer
		BNE	loc_80887
		LDA	sonic_state	; 0x2- shield; 0x4 - rolling
		CMP	#4
		BCC	loc_8088A

loc_80887:
		JMP	sonic_kill_obj
; ---------------------------------------------------------------------------

loc_8088A:
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

check_get_hit:
		LDA	invicible_timer
		BEQ	loc_80892
		RTS
; ---------------------------------------------------------------------------

loc_80892:				; 0x2- shield; 0x4 - rolling
		LDA	sonic_state
		CMP	#8
		BCC	loc_80899
		RTS
; ---------------------------------------------------------------------------

loc_80899:
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

sonic_kill_obj:
		LDA	Frame_Cnt
		AND	#1
		ORA	#$18
		LDA	#$1D
		STA	objects_type,X
		LDA	#5		; init cnt
		STA	objects_var_cnt,X
		LDA	sonic_attribs
		AND	#$C
		BNE	loc_808C0
		;LDA	invicible_timer
		;BNE	loc_808C0
		LDA	sonic_Y_speed
		BEQ	@skip_bounce
		JSR	sonic_enemy_bounce
@skip_bounce:
		LDA	sonic_attribs
		ORA	#$C
		STA	sonic_attribs

loc_808C0:
		INC	score_l
		LDA	score_l
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score_l
		INC	score____
		LDA	score____
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score____
		INC	score___
		LDA	score___
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score___
		INC	score__
		LDA	score__
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score__
		INC	score_
		LDA	score_
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score_
		INC	score
		LDA	score
		CMP	#$A
		BCC	loc_8091A
		LDA	#0
		STA	score

loc_8091A:
		LDA	#5
		STA	sfx_to_play
		RTS
; End of function check_kill_obj


; =============== S U B	R O U T	I N E =======================================


pick_obj_ring:
		LDA	sonic_anim_num
		CMP	#$A
		BEQ	locret_80A30
		INC	rings_1s
		LDA	#2
		STA	sfx_to_play
		
		LDA	#$7D ; object_pick_ring_anim
		STA	objects_type,X
		LDA	#0
		STA	objects_var_cnt,X
		
		;JMP	remove_temp_obj

locret_80A30:
		RTS
; End of function pick_obj_ring


; =============== S U B	R O U T	I N E =======================================


check_collision_both_hitbox_type0:
		LDA	#0
		STA	obj_collision_flag

check_collision_both_hitbox:
		LDA	objects_X_relative_h,X
		BMI	loc_80A3E
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_80A4B
		RTS
; ---------------------------------------------------------------------------

loc_80A3E:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	loc_80A4B
		ADC	#8
		BCS	loc_80A4B
		RTS
; ---------------------------------------------------------------------------

loc_80A4B:
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	no_coll_y
		LDA	objects_Y_relative_l,X
coll_check_Y:
		CLC
		ADC	hitbox_v
		BCS	loc_80A65
		;LDY	sonic_anim_num
		LDY	sonic_act_spr
		ADC	sonic_hitbox_Y_by_anim,Y
		;ADC	#24
		BCS	loc_80A65
no_coll_y:
		RTS
; ---------------------------------------------------------------------------

loc_80A65:
		LDY	obj_collision_flag
		BEQ	loc_80A85
;		BNE	loc_80A6C
;		JMP	check_kill_obj
; ---------------------------------------------------------------------------

;loc_80A6C:
		DEY
		BNE	loc_80A73
		JMP	pick_obj_ring
; ---------------------------------------------------------------------------

loc_80A73:
		DEY
		BEQ	j_check_get_hit
;		BNE	loc_80A7A
;		JMP	check_get_hit
; ---------------------------------------------------------------------------

;loc_80A7A:
		DEY
		BNE	collision_type4
		LDA	invicible_timer
		BNE	loc_80A85
		LDA	sonic_state
		BMI	loc_80A85
		
j_check_get_hit:
		JMP	check_get_hit
; ---------------------------------------------------------------------------

loc_80A85:
		JMP	check_kill_obj
; ---------------------------------------------------------------------------

collision_type4:
		DEY
		BNE	collision_type5

		LDA	invicible_timer
		BNE	@j_sonic_kill_obj
		LDA	sonic_state	; 0x2- shield; 0x4 - rolling
		CMP	#4
		BCC	@j_loc_8088A
		LDA	sonic_anim_num
		CMP	#8
		BEQ	@j_loc_8088A
		; rolling, but not jump

@j_sonic_kill_obj:
		JMP	sonic_kill_obj
; ---------------------------------------------------------------------------

@j_loc_8088A:
		JMP	sonic_get_hit_from_obj
; End of function check_collision_both_hitbox
; ---------------------------------------------------------------------------


; with chaos emerald
collision_type5:
		LDA	level_id
		CMP	#SPEC_STAGE
		BEQ	@emerald
		LDA	#$80
		STA	big_ring_flag
		LDA	#$40	; SFX: BIG RING
		STA	sfx_to_play
		LDA	super_em_cnt
		CMP	#7
		BNE	@all_emeralds
		INC	rings_100s ; add 100 rings for big ring

@all_emeralds:
		LDA	#210-16-1
		STA	objects_var_cnt,X
		RTS
		;JMP	remove_temp_obj

@emerald:
		LDA	#7
		CMP	emeralds_cnt
		BCC	@not_7_emeralds
		INC	emeralds_cnt
		CMP	emeralds_cnt
		BNE	@not_7_emeralds
		INC	special_or_std_lvl
@not_7_emeralds:

;		LDA	continues
;		CMP	#9
;		BCS	@max_conts
		INC	continues
;@max_conts
		LDA	continues
		ORA	#$80	; flag for music
		STA	continues

		LDA	#$2D	; music - chaos emerald
		STA	music_to_play
		JMP	remove_temp_obj ; delete emerald obj


; =============== S U B	R O U T	I N E =======================================


collision_vs_monitor:
		LDA	objects_Y_relative_h,X
		BMI	loc_80A8F
		RTS
; ---------------------------------------------------------------------------

loc_80A8F:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$F9
		BCS	loc_80A9F
		CMP	#$D8	; #$E8
		BCS	loc_80A9D
		RTS
; ---------------------------------------------------------------------------

loc_80A9D:
		LDY	#1

loc_80A9F:
		STY	obj_collision_flag
		LDA	objects_X_relative_h,X
		BMI	loc_80AAE
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_80ABB
		RTS
; ---------------------------------------------------------------------------

loc_80AAE:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	loc_80ABB
		ADC	#8
		BCS	loc_80ABB
locret_80ABA:
		RTS
; ---------------------------------------------------------------------------

loc_80ABB:				; 8 - jump roll, $1F - spin start, $20 -spin
		LDA	sonic_act_spr
		CMP	#8	; jump roll
		BEQ	@jump_roll	; std_destroy
		CMP	#9	; dead
		BEQ	locret_80ABA
		CMP	#$20	; side roll
		BEQ	destroy_monitor_from_side
		CMP	#$1F	; spin start
		BNE	@monitor_chk_coll
		LDA	sonic_X_speed
		BNE	destroy_monitor_from_side
		
@monitor_chk_coll:
		LDA	obj_collision_flag
		BNE	@not_on_monitor
		JMP	sonic_stand_on_monitor
; ---------------------------------------------------------------------------

@not_on_monitor:
		LDA	#$20
		JMP	sonic_side_collision
; ---------------------------------------------------------------------------

@jump_roll:
		JSR	monitor_destroy_from_up_check
		BCC	@ret
				; 896B
		LDA	sonic_state	; superS
		BPL	@ret
		LDA	obj_collision_flag
		BEQ	@ret
		LDA	objects_type,X
		CMP	#$1D	; object_explode
		BNE	destroy_monitor	; always destroy monitor
@ret
		RTS
; ---------------------------------------------------------------------------

destroy_monitor:
		;LDA	sonic_attribs
		;ORA	#$1C
		;STA	sonic_attribs
destroy_monitor_from_side:
		LDA	#5		; monitor destroy sfx
		STA	sfx_to_play
		LDA	objects_type,X
		PHA
		LDA	#$1D	; object_explode
		STA	objects_type,X
		LDA	#$85	; ?
		STA	objects_var_cnt,X
		PLA
		CMP	#$10
		BNE	@not_rings_monitor
		LDA	rings_10s
		CLC
		ADC	#1
		CMP	#$A
		BCC	@add_10_rings
		LDY	#0
		JMP	life_for_100_rings_hack	; the jabu hack
; ---------------------------------------------------------------------------

@add_10_rings:
		STA	rings_10s
		RTS
; ---------------------------------------------------------------------------

@not_rings_monitor:
		CMP	#$11
		BNE	@not_eggman_monitor
		JMP	sonic_set_death
; ---------------------------------------------------------------------------

@not_eggman_monitor:
		CMP	#$12
		BNE	@not_life_monitor
		JMP	add_life_by_monitor
; ---------------------------------------------------------------------------

@not_life_monitor:
		CMP	#$13
		BNE	@not_speed_shoes_monitor
		LDA	#SHOES_TIMER
		STA	speed_shoes_timer
		RTS
; ---------------------------------------------------------------------------

@not_speed_shoes_monitor:
		CMP	#$14	; NV monitor
		BNE	@not_nv_monitor
		LDA	#INVIC_TIMER
		STA	invicible_timer
		LDA	#$21	; invicibity music
		LDY	current_music
		CPY	#$2A	; drowning music
		BEQ	@is_drowning_music
		CMP	current_music
		BEQ	@is_drowning_music
		STA	music_to_play
		LDA	#0	; clear current sfx to play
		STA	sfx_to_play
@is_drowning_music:
		RTS
; ---------------------------------------------------------------------------

@not_nv_monitor:
		CMP	#$15
		BNE	@not_shield_monitor
		LDA	sonic_state	; 0x2- shield; 0x4 - rolling
		ORA	#2
		STA	sonic_state	; 0x2- shield; 0x4 - rolling
		LDA	#$E	; get shield sfx
		STA	sfx_to_play
@not_shield_monitor:
		RTS
; ---------------------------------------------------------------------------

sonic_side_collision:
		STA	tmp_var_25
		LDA	objects_X_relative_h,X
		BMI	@loc_80B5B
@mon_move_s_to_left:
		LDA	sonic_X_speed
		BEQ	@loc_80B49
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#3
		BNE	@loc_80B49
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

@loc_80B49:
		LDA	objects_X_l,X
		SEC
		SBC	#8
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		SBC	#0
		JMP	@rewrite_relative_X
; ---------------------------------------------------------------------------

@loc_80B5B:
		LDA	objects_X_relative_l,X
		CMP	#$F9
		BCS	@mon_move_s_to_left
;mon_move_s_to_right:
		LDA	sonic_X_speed
		BEQ	@loc_80B6D
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#3
		BEQ	@loc_80B6D
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

@loc_80B6D:
		LDA	objects_X_l,X
		CLC
		;ADC	#$20
		ADC	tmp_var_25
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		ADC	#0
@rewrite_relative_X:
		STA	sonic_X_h_new

		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		RTS
; ---------------------------------------------------------------------------

monitor_destroy_from_up_check:
		LDA	objects_Y_relative_l,X
		CMP	#$E8	; for BCC/BCS
		LDA	sonic_attribs
		AND	#$C
		BEQ	@ckh_lim
		BCS	@ret1	; here
@reta:	
		LDA	#0
		STA	sonic_Y_speed
@ret1:
		RTS
	
@ckh_lim:
		BCC	@reta	; and here
		JSR	limit_Y_speed
		LDA	sonic_attribs
		ORA	#$1C ; ($10 - normal jump flag)
		STA	sonic_attribs
		JMP	destroy_monitor
; ---------------------------------------------------------------------------

limit_Y_speed:
sonic_enemy_bounce:
		LDA	#100	; max bounce speed with button
		LDY	joy1_hold
		CPY	#BUTTON_B ; B or A
		BCS	@set_Y_speed
		LDA	#48	; max bounce speed without button

@set_Y_speed:
		CMP	sonic_Y_speed
		BCC	@low_air_speed
		LDA	sonic_Y_speed ; max = current, inverted
@low_air_speed
		STA	sonic_Y_speed
		
		LDA	sonic_anim_num
		CMP	#$20
		BNE	@spin
		LDA	#8
		STA	sonic_anim_num
@spin
		RTS
; ---------------------------------------------------------------------------

sonic_stand_on_spikes:
		LDA	sonic_X_speed
		SEC
		SBC	#2
		BCS	@no_clr
		LDA	#0
@no_clr:
		STA	sonic_X_speed

sonic_stand_on_monitor:
		LDA	objects_Y_l,X
		CLC
		ADC	#1
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		STA	sonic_Y_h_new
		LDA	#$FF
		STA	objects_Y_relative_h,X
		;LDA	#0
		STA	objects_Y_relative_l,X
clear_sonic_Y_speed:
		LDA	#0
		STA	sonic_Y_speed
		RTS
; End of function collision_vs_monitor


; =============== S U B	R O U T	I N E =======================================


object_3C:
		LDA	#40
		BNE	loc_80BDB
; End of function object_3C


; =============== S U B	R O U T	I N E =======================================


object_3D:
;		LDA	#32
;		BNE	loc_80BDB
; End of function object_3D


; =============== S U B	R O U T	I N E =======================================


object_2B:
		LDA	#32


loc_80BDB:
		STA	hitbox_h
		JSR	obj_get_relative_pos
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_80C0C
		INC	objects_X_l,X
		BNE	@no_inc_h
		INC	objects_X_h,X
@no_inc_h:
		
		LDA	objects_X_l,X
		CLC
		ADC	hitbox_h
		STA	tmp_result_x_l
		LDA	objects_X_h,X
		ADC	#0
		STA	tmp_result_x_h
		LDA	#0
		STA	tmp_x_positions
		JMP	loc_80C25
; ---------------------------------------------------------------------------

loc_80C0C:
		LDA	objects_X_l,X
		SEC
		SBC	#1
		STA	objects_X_l,X
		STA	tmp_result_x_l
		LDA	objects_X_h,X
		SBC	#0
		STA	objects_X_h,X
		STA	tmp_result_x_h
		LDA	#1
		STA	tmp_x_positions

loc_80C25:
		LDA	#1
		STA	tmp_x_positions+1
		LDA	#0
		STA	tmp_y_positions
		STA	tmp_y_positions+1
		LDA	objects_Y_l,X
		STA	tmp_result_y_l
		LDA	objects_Y_h,X
		STA	tmp_result_y_h
		JSR	check_for_solid_block_tmp
		BEQ	loc_80C46
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		STA	objects_var_cnt,X ; var/counter

loc_80C46:
		JMP	platforms_update_sonic_X_Y
; End of function object_2B


; =============== S U B	R O U T	I N E =======================================


object_ending_point:
		JSR	sonic_pos_fix
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_80C51
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_80C51:
		LDA	big_ring_flag
		BNE	@no_big_ring

		LDA	level_id
		CMP	#SPEC_STAGE
		BEQ	@no_big_ring

		LDA	rings_100s
		BNE	@ok
		LDA	rings_10s
		CMP	#5		; compare for 50 rings
		BCC	@no_big_ring

@ok:
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS	; fix - check obj limit
		BCC	@have_slots
		DEY	; use last obj slot
@have_slots:
		LDA	objects_X_l,X
		ADC	#64
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,Y
		
		LDA	objects_Y_l,X
		SEC
		SBC	#48
		STA	objects_Y_l,Y
		
		LDA	objects_Y_h,X
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

		LDA	objects_var_cnt,X
		BEQ	loc_80C7E
		CMP	#2
		BNE	@not_1
		LDA	#$1F ; sound35:	; SFX: Signpost (Rushjet1 version)
		STA	sfx_to_play
@not_1
		;LDA	#$A
		;STA	sfx_to_play
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		CMP	#120	; 2 seconds
		BCC	locret_80CA2
		LDA	#$2F
		STA	objects_type,X
		LDY	#0
		LDA	level_id
		CMP	#SPEC_STAGE
		BNE	@normal
		BIT	continues
		BPL	@special
		BMI	@loc_80C79
@normal:
;		LDA	rings_100s
;		BNE	@loc_80C79
;		LDA	rings_10s
;		CMP	#5		; compare for 50 rings
;		BCS	@loc_80C79
		LDA	big_ring_flag
		BNE	@loc_80C79

@special:
		LDY	#$80

@loc_80C79:
		TYA
		STA	objects_var_cnt,X ; var/counter
		BMI	@ok1
		LDA	#8
		JSR	object_sub_Y
		JSR	obj_update_rel_pos_and_test
@ok1
		RTS
; ---------------------------------------------------------------------------

loc_80C7E:
		LDA	objects_X_relative_h,X
		BEQ	loc_80C89
		CMP	#$FF
		BEQ	loc_80C94
		BNE	locret_80CA2

loc_80C89:
		LDA	objects_X_h,X
		STA	cam_x_h_limit_r
		SEC
		SBC	#2
		STA	cam_x_h_limit_l
		RTS
; ---------------------------------------------------------------------------

loc_80C94:
		LDA	objects_X_relative_l,X
		CMP	#$E8
		BCS	locret_80CA2
		LDA	#1
		STA	objects_var_cnt,X ; var/counter
		INC	cam_x_h_limit_l
		;LDA	#$A
		;STA	sfx_to_play		

locret_80CA2:
		RTS
; End of function object_ending_point


; =============== S U B	R O U T	I N E =======================================


object_ending_point2:
		JSR	sonic_pos_fix
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_80CAB
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_80CAB:
		LDA	level_finish_func_num
		BNE	locret_80CB7
		LDA	#$22
		STA	music_to_play
		LDA	#1
		STA	level_finish_func_num
		JMP	disable_super_sonic

locret_80CB7:
		RTS
; End of function object_ending_point2


; =============== S U B	R O U T	I N E =======================================


sonic_pos_fix:
		LDA	cam_x_h_limit_r
		CMP	camera_X_h_new
		BNE	@no_fix_sonic_x
		LDA	#$F0
		CMP	sonic_X_l_new
		BCC	@fix_pos
;		BCS	@ok1
;		STA	sonic_X_l_new
;@ok1
		LDA	#$10
		CMP	sonic_X_l_new
		BCC	@no_fix_sonic_x
@fix_pos:
		STA	sonic_X_l_new
		LDA	#0
		STA	sonic_X_speed
@no_fix_sonic_x:
		RTS


; =============== S U B	R O U T	I N E =======================================


object_explosions:
		JSR	obj_update_rel_pos_and_test
		JSR	loc_81FB0	; fix for explosions on boss5
		LDX	object_slot
		INC	objects_var_cnt,X ; var/counter
		BPL	locret_80CB7
; End of function object_explosions
		;JMP	remove_temp_obj

; =============== S U B	R O U T	I N E =======================================


remove_temp_obj:
		LDA	#$6F	; put sprite out of screen
		STA	objects_Y_relative_h,X
		LDA	#0
		STA	objects_type,X
		STA	objects_delay,X
		RTS
; End of function remove_temp_obj


; =============== S U B	R O U T	I N E =======================================


object_weapon_spawner:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_80CD6
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_80CD6:
		LDA	Frame_Cnt
		BNE	locret_80D01
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-4	; skip if current obj cnt >18
		BCS	check_for_bubbles
replace_bubble:
		LDA	objects_var_cnt,X ; var/counter
		STA	objects_type,Y
		JSR	obj_copy_pos
		JMP	play_fire_sfx ; fireballs shoot sfx

locret_80D01:
		RTS
; End of function object_weapon_spawner


check_for_bubbles:
		CPY	#OBJECTS_SLOTS-1
		BCS	locret_80D01
		STY	tmp_var_25 ; save obj cnt
		
@search_bubbles:
		LDA	objects_type,Y
		CMP	#$45 ; small bubble
		BEQ	@is_bubble
		CMP	#$46 ; medium bubble
		BEQ	@is_bubble
		DEY
		BPL	@search_bubbles
		RTS
		
@is_bubble:
		JSR	replace_bubble
		LDY	tmp_var_25 ; restore obj cnt
		STY	objects_cnt ; restore obj cnt
		RTS


; =============== S U B	R O U T	I N E =======================================


object_fire_move_r:
		LDA	Frame_Cnt
		LSR	A	; +0/+1 (CLC/SEC)
		LDA	objects_X_l,X
		ADC	#1	; +1/+2
		STA	objects_X_l,X
		BCC	@no_inc_h1
		INC	objects_X_h,X
@no_inc_h1
;		JMP	object_fire_projectile_H

		LDA	objects_X_h,X
		PHA
		LDA	objects_X_l,X
		PHA
		;CLC
		ADC	#16
		STA	objects_X_l,X
		BCC	@no_inc_h2
		INC	objects_X_h,X
@no_inc_h2
		JSR	check_for_solid_block
		TAY
		PLA
		STA	objects_X_l,X
		PLA
		STA	objects_X_h,X
		TYA
		BEQ	object_fire_projectile_H
j_remove_temp_obj:
		JMP	remove_temp_obj


; =============== S U B	R O U T	I N E =======================================


object_fire_move_d:
		LDA	Frame_Cnt
		LSR	A
		LDA	#1
		ADC	#0
		JSR	object_add_Y
		LDA	objects_Y_h,X
		PHA
		LDA	objects_Y_l,X
		PHA
		LDA	#15
		JSR	object_add_Y
		JSR	check_for_solid_block
		TAY
		PLA
		STA	objects_Y_l,X
		PLA
		STA	objects_Y_h,X
		TYA
		BNE	j_remove_temp_obj
		LDA	#8
		LDY	#24
		BNE	object_fire_projectile ; JMP
; End of function object_fire_move_d


; =============== S U B	R O U T	I N E =======================================


object_fire_move_l:
		LDA	Frame_Cnt
		LSR	A	; +0/+1 (CLC/SEC)
		LDA	objects_X_l,X
		SBC	#1	; -1/-2
		STA	objects_X_l,X
		BCS	@no_dec_h
		DEC	objects_X_h,X
@no_dec_h

		JSR	check_for_solid_block ;	block number in	Y, solid flag in A (BEQ/BNE)
		BNE	j_remove_temp_obj

object_fire_projectile_H:
		LDA	#24
		LDY	#8

object_fire_projectile:
		STA	hitbox_h
		STY	hitbox_v
;		JSR	check_for_solid_block ;	block number in	Y, solid flag in A (BEQ/BNE)
;		BEQ	@ok
;		JMP	remove_temp_obj
; ---------------------------------------------------------------------------
;@ok		
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_fire_move_r
; End of function object_fire_move_l


; =============== S U B	R O U T	I N E =======================================


object_bat:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_80D8E
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_80D8E:
		JSR	bat_movement
		LDA	#24	; fix
		STA	hitbox_h
		;LDA	#24	; fix
		STA	hitbox_v
		;LDA	#0
		;STA	obj_collision_flag
		JMP	check_collision_both_hitbox_type0
; End of function object_bat


; =============== S U B	R O U T	I N E =======================================


bat_movement:
		LDA	objects_var_cnt,X ; var/counter
		AND	#3
		BNE	loc_80DD0
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	locret_80DCF
		LDA	objects_X_relative_h,X
		BEQ	loc_80DC3
		CMP	#$FF
		BEQ	loc_80DB8
		RTS
; ---------------------------------------------------------------------------

loc_80DB8:
		LDA	objects_X_relative_l,X
		CMP	#$B0
		BCC	locret_80DCF
		LDA	#1
		BNE	loc_80DCC

loc_80DC3:
		LDA	objects_X_relative_l,X
		CMP	#$50
		BCS	locret_80DCF
		LDA	#$81

loc_80DCC:				; var/counter
		STA	objects_var_cnt,X

locret_80DCF:
		RTS
; ---------------------------------------------------------------------------

loc_80DD0:
		PHA
		LDA	Frame_Cnt
		AND	#$F
		BNE	@no_bat_sfx
		LDA	#$19
		STA	sfx_to_play
@no_bat_sfx
		PLA
		CMP	#1
		BNE	loc_80DF7
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	loc_80DE2
		LDA	objects_Y_relative_l,X
		CMP	#$E0
		BCC	loc_80DE5

loc_80DE2:				; var/counter
		INC	objects_var_cnt,X

loc_80DE5:
		LDA	#2
		JMP	object_add_Y
; ---------------------------------------------------------------------------

loc_80DF7:
		CMP	#2
		BNE	loc_80E44
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_80E21
		INC	objects_X_l,X
		BNE	@no_inc_h
		INC	objects_X_h,X
@no_inc_h:		
		
		LDA	objects_X_relative_h,X
		BNE	locret_80E20
		LDA	objects_X_relative_l,X
		CMP	#$60
		BCC	locret_80E20
		INC	objects_var_cnt,X ; var/counter

locret_80E20:
		RTS
; ---------------------------------------------------------------------------

loc_80E21:
		JSR	object_dec_X
		LDA	objects_X_relative_h,X
		CMP	#$FF
		BNE	locret_80E43
		LDA	objects_X_relative_l,X
		CMP	#$A0
		BCS	locret_80E43
		INC	objects_var_cnt,X ; var/counter

locret_80E43:
		RTS
; ---------------------------------------------------------------------------

loc_80E44:
		LDA	#2
		JSR	object_sub_Y
		LDA	Frame_Cnt
		AND	#7
		BNE	loc_80E85
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_80E74
		INC	objects_X_l,X
		BNE	@no_inc_h
		INC	objects_X_h,X
@no_inc_h:		
		
		JMP	loc_80E85
; ---------------------------------------------------------------------------

loc_80E74:
		JSR	object_dec_X

loc_80E85:				; block	number in Y, solid flag	in A (BEQ/BNE)
		JSR	check_for_solid_block
		BEQ	locret_80E8F
		LDA	#0
		STA	objects_var_cnt,X ; var/counter

locret_80E8F:
		RTS
; End of function sub_80DA0


; =============== S U B	R O U T	I N E =======================================

; decrement obj X pos by 1
object_dec_X:
		LDA	objects_X_l,X
		BNE	@no_dec_h
		DEC	objects_X_h,X
@no_dec_h
		DEC	objects_X_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================

; increment obj X pos by 1
object_inc_X:
		INC	objects_X_l,X
		BNE	@no_inc_h
		INC	objects_X_h,X
@no_inc_h
		RTS


; =============== S U B	R O U T	I N E =======================================

; add to obj X pos
object_add_X:
		CLC
		ADC	objects_X_l,X
		BCC	@no_inc_h
		INC	objects_X_h,X
@no_inc_h:
		STA	objects_X_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================

; sub obj X pos
object_sub_X:
		STA	tmp_var_26
		LDA	objects_X_l,X
		SEC
		SBC	tmp_var_26
		BCS	@no_dec_h
		DEC	objects_X_h,X
@no_dec_h:
		STA	objects_X_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================


object_0E:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_80E98
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_80E98:
		LDA	Frame_Cnt
		AND	#$40
		BNE	loc_80EA2
		STA	objects_var_cnt,X ; var/counter
		RTS
; ---------------------------------------------------------------------------

loc_80EA2:				; var/counter
		STA	objects_var_cnt,X
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BEQ	loc_80EAD
		RTS
; ---------------------------------------------------------------------------

loc_80EAD:
		LDA	objects_Y_relative_l,X
		CMP	#$E8
		BCS	loc_80EB5
		RTS
; ---------------------------------------------------------------------------

loc_80EB5:
		LDA	objects_X_relative_h,X
		BEQ	loc_80F00
		CMP	#$FF
		BEQ	loc_80EBF
		RTS
; ---------------------------------------------------------------------------

loc_80EBF:
		LDA	objects_X_relative_l,X
		CLC
		ADC	#$20
		BCC	loc_80ECA
		JMP	check_get_hit
; ---------------------------------------------------------------------------

loc_80ECA:
		ADC	#8
		BCS	loc_80ECF
		RTS
; ---------------------------------------------------------------------------

loc_80ECF:
		LDA	#$20
		CLC
		ADC	#8
		STA	tmp_var_25
		LDA	tmp_var_25
		CLC
		ADC	objects_X_l,X
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		ADC	#0
		STA	sonic_X_h_new
		LDA	#0
		SEC
		SBC	tmp_var_25
		STA	objects_X_relative_l,X
		LDA	#$FF
		STA	objects_X_relative_h,X
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_80EFD
		LDA	#$D
		STA	sonic_anim_num

loc_80EFD:
		JMP	loc_80F2C
; ---------------------------------------------------------------------------

loc_80F00:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_80F08
		RTS
; ---------------------------------------------------------------------------

loc_80F08:
		LDA	objects_X_l,X
		SEC
		SBC	#8
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		SBC	#0
		STA	sonic_X_h_new
		LDA	#0
		STA	objects_X_relative_h,X
		LDA	#8
		STA	objects_X_relative_l,X
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	loc_80F2C
		LDA	#$D
		STA	sonic_anim_num

loc_80F2C:
		LDA	#0
		STA	sonic_X_speed
		RTS
; End of function object_0E


; =============== S U B	R O U T	I N E =======================================


object_lava_fire_splash:
		LDA	objects_var_cnt,X ; var/counter
		BPL	fire_splash_move_ud
		INC	objects_var_cnt,X ; var/counter
;		CMP	#$80	; when fall down back
;		BNE	@no_fire_sfx
;		JSR	play_fire_sfx
;
;@no_fire_sfx:
		JMP	loc_80F67
; ---------------------------------------------------------------------------

fire_splash_move_ud:
;		CMP	#2	; at splash start
;		BNE	@no_fire_sfx
;		JSR	play_fire_sfx ; moved to draw_objs_code.asm
;
;@no_fire_sfx:
		LDA	objects_type,X
		CMP	#$1F
		BCS	@is_high_splash
		INC	objects_var_cnt,X
@is_high_splash
		; BCC/BCS
;		LDY	#$FE
;		BCC	@not_1F
;		DEY	; $FD
;@not_1F		
;		LDA	objects_var_cnt,X ; var/counter
;		AND	#$40
;		BEQ	loc_80F49
;		LDY	#2
;		BCC	loc_80F49
;		INY	; 3

		LDA	objects_var_cnt,X
		ASL	A
		PHP
		LSR	A
		AND	#$3F
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	fire_splash_move_tab1,Y
		PLP
		BPL	loc_80F49
		LDA	fire_splash_move_tab2,Y
		
loc_80F49:
		STA	tmp_var_25
;		STY	tmp_var_25
;		TYA
		CLC
		ADC	objects_Y_l,X
		STA	objects_Y_l,X
		LDA	tmp_var_25
		BMI	loc_80F5F
		LDA	objects_Y_h,X
		ADC	#0
		JMP	loc_80F64
; ---------------------------------------------------------------------------

loc_80F5F:
		LDA	objects_Y_h,X
		SBC	#0

loc_80F64:
		STA	objects_Y_h,X

loc_80F67:				; var/counter
		INC	objects_var_cnt,X
		LDA	#8
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_lava_fire_splash

fire_splash_move_tab1:
		.BYTE	-4,-3,-3,-2,-2,-2,-1,0
		
fire_splash_move_tab2:
		.BYTE	0,1,2,2,2,3,3,4


; =============== S U B	R O U T	I N E =======================================


play_fire_sfx:
		LDY	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		BMI	@up
		BNE	@no_fire_sfx
		CPY	#$70
		BCC	@check_x
		BCS	@no_fire_sfx

@up
		CMP	#$FF
		BCC	@no_fire_sfx
		CPY	#$70
		BCC	@no_fire_sfx

@check_x:
		LDY	objects_X_relative_l,X
		LDA	objects_X_relative_h,X
		BMI	@left
		BNE	@no_fire_sfx
		CPY	#$80+$10	; lower - closier
		BCC	@play
		BCS	@no_fire_sfx

@left:
		CMP	#$FF
		BCC	@no_fire_sfx
		CPY	#$80-$10	; greater - closier
		BCC	@no_fire_sfx

@play:
		LDA	#$10	; sfx: fire shot
		STA	sfx_to_play
@no_fire_sfx:
		RTS


; =============== S U B	R O U T	I N E =======================================

; 33

object_small_spike:
		LDA	Frame_Cnt
		AND	#3
		BNE	@no_inc_cnt
		INC	objects_var_cnt,X

@no_inc_cnt:
		LDA	Frame_Cnt
		AND	#1
		BEQ	loc_81004
		LDA	objects_var_cnt,X
		AND	#$F
		TAY
		LDA	spikes_move_tbl,Y
		JSR	spikes_Y_movement
		LDA	objects_var_cnt,X
		CLC
		ADC	#8
		STA	tmp_var_26
		AND	#$F
		TAY
		LDA	tmp_var_26
		AND	#$10
		BNE	loc_80FF2
		LDA	spikes_move_tbl,Y
		JSR	object_add_X
		JMP	loc_81004
; ---------------------------------------------------------------------------

loc_80FF2:
		LDA	spikes_move_tbl,Y
		JSR	object_sub_X

loc_81004:
		LDA	#8
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_small_spike


; =============== S U B	R O U T	I N E =======================================


spikes_Y_movement:
		TAY
		LDA	objects_var_cnt,X ; var/counter
		AND	#$10
spikes_Y_movement_sbz:
		BNE	@loc_80FBA
		TYA
		JMP	object_add_Y
; ---------------------------------------------------------------------------

@loc_80FBA:
		TYA
		JMP	object_sub_Y


; =============== S U B	R O U T	I N E =======================================

; 31

object_big_fast_rotating_spike:
		LDA	Frame_Cnt
		AND	#1
		BEQ	@no_inc_cnt
		INC	objects_var_cnt,X

@no_inc_cnt:
		LDA	objects_var_cnt,X
		AND	#$F
		TAY
		LDA	spikes_move_tbl,Y
		ASL	A
		JSR	spikes_Y_movement
		LDA	objects_var_cnt,X
		CLC
		ADC	#8
		STA	tmp_var_26
		AND	#$F
		TAY
		LDA	spikes_move_tbl,Y
		ASL	A
		STA	tmp_var_25
		LDA	tmp_var_26
		AND	#$10
		BNE	loc_81087
		LDA	tmp_var_25
		JSR	object_add_X
		JMP	big_spikes_check_collision
; ---------------------------------------------------------------------------

loc_81087:
		JSR	object_sub_X

big_spikes_check_collision:
		LDA	#24	; big spikes hitbox fix
		STA	hitbox_h
		;LDA	#24
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_big_fast_rotating_spike


; =============== S U B	R O U T	I N E =======================================

; 32

object_big_rotating_spike:
		LDA	Frame_Cnt
		AND	#3
		BNE	@no_inc_cnt
		INC	objects_var_cnt,X

@no_inc_cnt:
		LDA	objects_var_cnt,X
		STA	tmp_var_25
		LDY	level_id
		CPY	#SCRAP_BRAIN
		BNE	@not_sbz
		CLC
		ADC	#8
		AND	#$F
		TAY
		LDA	spikes_move_tbl,Y
		TAY
		LDA	objects_var_cnt,X
		AND	#8
		JSR	spikes_Y_movement_sbz
		JMP	@next
@not_sbz:
		AND	#$F
		TAY
		LDA	spikes_move_tbl,Y
		JSR	spikes_Y_movement
@next:
		LDA	tmp_var_25
		LDY	level_id
		CPY	#SCRAP_BRAIN
		BNE	@not_sbz2
		CLC
		ADC	#8
@not_sbz2:
		CLC
		ADC	#8
		STA	tmp_var_26
		AND	#$F
		TAY
		LDA	tmp_var_26
		AND	#$10
		BNE	loc_81112
		LDA	spikes_move_tbl,Y
		JSR	object_add_X
		JMP	loc_81124
; ---------------------------------------------------------------------------

loc_81112:
		LDA	spikes_move_tbl,Y
		JSR	object_sub_X

loc_81124:
		JMP	big_spikes_check_collision
; End of function object_big_rotating_spike


; =============== S U B	R O U T	I N E =======================================


obj_get_relative_pos:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	@ok
		JMP	obj_update_rel_pos_and_test ; fix bugs on death
@ok:
		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h
		STA	objects_X_relative_h,X
		LDA	objects_Y_l,X
		SEC
		SBC	sonic_Y_l
		STA	objects_Y_relative_l,X
		LDA	objects_Y_h,X
		SBC	sonic_Y_h
		STA	objects_Y_relative_h,X
		LDA	objects_Y_h,X
		CMP	sonic_Y_h
		BEQ	locret_8117A
		LDA	objects_Y_relative_h,X
		BPL	loc_81169
		LDA	objects_Y_relative_l,X
		CLC
		ADC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		ADC	#0
		STA	objects_Y_relative_h,X
		RTS
; ---------------------------------------------------------------------------

loc_81169:
		LDA	objects_Y_relative_l,X
		SEC
		SBC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		SBC	#0
		STA	objects_Y_relative_h,X

locret_8117A:
		RTS
; End of function obj_get_relative_pos


; =============== S U B	R O U T	I N E =======================================


object_29:
		JSR	obj_get_relative_pos
		LDA	Frame_Cnt
		AND	#7
		BNE	loc_8118F
		INC	objects_var_cnt,X

loc_8118F:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$F
		TAY
		LDA	obj_29_mov_tbl,Y
		STA	tmp_y_positions+1
		LDA	objects_var_cnt,X ; var/counter
		AND	#8
		STA	tmp_y_positions
		BEQ	loc_811B7
		LDA	tmp_y_positions+1
		JSR	object_add_Y
		JMP	loc_811C8
; ---------------------------------------------------------------------------

loc_811B7:
		LDA	tmp_y_positions+1
		JSR	object_sub_Y

loc_811C8:				; var/counter
		LDA	objects_var_cnt,X
		CLC
		ADC	#8
		STA	tmp_var_26
		AND	#$F
		TAY
		LDA	obj_29_mov_tbl,Y
		STA	tmp_x_positions+1
		LDA	tmp_var_26
		AND	#$10
		STA	tmp_x_positions
		BNE	loc_811F4
		LDA	objects_X_l,X
		CLC
		ADC	tmp_x_positions+1
		STA	objects_X_l,X
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,X
		JMP	loc_81205
; ---------------------------------------------------------------------------

loc_811F4:
		LDA	objects_X_l,X
		SEC
		SBC	tmp_x_positions+1
		STA	objects_X_l,X
		LDA	objects_X_h,X
		SBC	#0
		STA	objects_X_h,X

loc_81205:
		LDA	#32
		STA	hitbox_h

platforms_update_sonic_X_Y:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	loc_81213
		RTS
; ---------------------------------------------------------------------------

loc_81213:
		LDA	objects_Y_relative_h,X
		BEQ	loc_8121B
		JMP	check_platforms_delete
; ---------------------------------------------------------------------------

loc_8121B:
		LDA	objects_X_relative_h,X
		BEQ	loc_81227
		CMP	#$FF
		BEQ	loc_81231
		JMP	check_platforms_delete
; ---------------------------------------------------------------------------

loc_81227:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	change_sonic_Y
		JMP	check_platforms_delete
; ---------------------------------------------------------------------------

loc_81231:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h	; hitbox_v
		BCS	change_sonic_Y
		ADC	#8
		BCS	change_sonic_Y
		JMP	check_platforms_delete
; ---------------------------------------------------------------------------

change_sonic_Y:
		LDA	objects_Y_relative_l,X
		BNE	loc_81290
		JSR	check_for_cam_move_lock
		LDA	tmp_y_positions+1
		BEQ	platforms_update_sonic_X
		LDA	#0
		STA	move_cam_delay ; FIX (block sonic look up/down)
		LDA	tmp_y_positions
		BEQ	@minus
		LDA	tmp_y_positions+1
		CLC
		ADC	sonic_Y_l_new
		STA	sonic_Y_l_new
		CMP	#$F0
		BCC	@no_cross_page_y
		CLC
		ADC	#$10
		STA	sonic_Y_l_new
		INC	sonic_Y_h_new

@no_cross_page_y:
		JMP	platforms_update_sonic_X
; ---------------------------------------------------------------------------

@minus:
		LDA	sonic_Y_l_new
		SEC
		SBC	tmp_y_positions+1
		STA	sonic_Y_l_new
		CMP	#$F0
		BCC	platforms_update_sonic_X
		SBC	#$10
		STA	sonic_Y_l_new
		DEC	sonic_Y_h_new

platforms_update_sonic_X:
		LDA	tmp_x_positions
		BNE	loc_81283
		LDA	sonic_X_l_new
		CLC
		ADC	tmp_x_positions+1
		STA	sonic_X_l_new
		LDA	sonic_X_h_new
		ADC	#0
		STA	sonic_X_h_new
		JMP	loc_81290
; ---------------------------------------------------------------------------

loc_81283:
		LDA	sonic_X_l_new
		SEC
		SBC	tmp_x_positions+1
		STA	sonic_X_l_new
		LDA	sonic_X_h_new
		SBC	#0
		STA	sonic_X_h_new

loc_81290:
		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		LDA	objects_Y_l,X
		SEC
		SBC	sonic_Y_l_new
		STA	objects_Y_relative_l,X
		LDA	objects_Y_h,X
		SBC	sonic_Y_h_new
		STA	objects_Y_relative_h,X
		LDA	objects_Y_h,X
		CMP	sonic_Y_h_new
		BEQ	loc_812E3
		LDA	objects_Y_relative_h,X
		BPL	loc_812D2
		LDA	objects_Y_relative_l,X
		CLC
		ADC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		ADC	#0
		STA	objects_Y_relative_h,X
		JMP	loc_812E3
; ---------------------------------------------------------------------------

loc_812D2:
		LDA	objects_Y_relative_l,X
		SEC
		SBC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		SBC	#0
		STA	objects_Y_relative_h,X

loc_812E3:
		LDA	objects_X_relative_h,X
		BEQ	@same_screen_r ; fix
		CMP	#$FF           ; fix
		BEQ	@same_screen_l ; fix
		RTS
@same_screen_r:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_812FD
		RTS

@same_screen_l:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	loc_812FD
		ADC	#8
		BCC	locret_81325

loc_812FD:
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	locret_81325
		LDA	objects_Y_l,X
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		STA	sonic_Y_h_new
		LDA	#0
		STA	objects_Y_relative_l,X
		STA	objects_Y_relative_h,X
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_X_speed
		SEC
		SBC	#2
		BCS	loc_81323
		LDA	#0

loc_81323:
		STA	sonic_X_speed

locret_81325:
		RTS
; ---------------------------------------------------------------------------

check_platforms_delete:
		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		BMI	loc_81340
		CMP	#1	; 2 - platforms respawn area
		BCC	loc_81347
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81340:
		CMP	#$FF	; $FE - platforms respawn area
		BCS	loc_81347
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81347:
		LDA	objects_Y_l,X
		SEC
		SBC	sonic_Y_l_new
		STA	objects_Y_relative_l,X
		LDA	objects_Y_h,X
		SBC	sonic_Y_h_new
		STA	objects_Y_relative_h,X
		LDA	objects_Y_h,X
		CMP	sonic_Y_h_new
		BEQ	loc_81389
		LDA	objects_Y_relative_h,X
		BPL	loc_81378
		LDA	objects_Y_relative_l,X
		CLC
		ADC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		ADC	#0
		STA	objects_Y_relative_h,X
		JMP	loc_81389
; ---------------------------------------------------------------------------

loc_81378:
		LDA	objects_Y_relative_l,X
		SEC
		SBC	#$10
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,X
		SBC	#0
		STA	objects_Y_relative_h,X

loc_81389:
		LDA	objects_Y_relative_h,X
		BMI	loc_81395
		CMP	#2
		BCC	locret_8139C
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81395:
		CMP	#$FE
		BCS	locret_8139C
		JMP	object_remove
; ---------------------------------------------------------------------------

locret_8139C:
		RTS
; End of function object_29


; =============== S U B	R O U T	I N E =======================================


check_for_cam_move_lock:
		LDA	objects_type,X
		CMP	#$4D ; object_platform_move_up
		BEQ	@lock_cam_move
		CMP	#$35 ; object_steam_roller
		BEQ	@lock_cam_move
		CMP	#$6F ; object_sbz_platform
		BCS	@lock_cam_move
		;BEQ	@lock_cam_move
		;CMP	#$70 ; object_sbz_platform2
		;BEQ	@lock_cam_move
		;CMP	#$71 ; object_long_mesh_block
		;BEQ	@lock_cam_move
		RTS

@lock_cam_move
		LDA	#0
		STA	move_cam_delay ; FIX (block sonic look up/down)
		RTS


; =============== S U B	R O U T	I N E =======================================

; $28
object_caterpillar:
		LDA	Frame_Cnt
		AND	#$3F
		BEQ	loc_813A8
		JMP	loc_813D8
; ---------------------------------------------------------------------------

loc_813A8:				; var/counter
		LDA	objects_var_cnt,X
		CLC
		ADC	#8
		STA	objects_var_cnt,X ; var/counter
		BPL	loc_813C7
		LDA	#4
		JSR	object_add_X
		JMP	loc_813D8
; ---------------------------------------------------------------------------

loc_813C7:
		LDA	#4
		JSR	object_sub_X

loc_813D8:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81438
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81438:
		LDA	objects_Y_relative_h,X
		BMI	loc_8143E
		RTS
; ---------------------------------------------------------------------------

loc_8143E:
		LDA	objects_Y_relative_l,X
		CMP	#$FC
		BCC	loc_81446
		RTS
; ---------------------------------------------------------------------------

loc_81446:
		CMP	#$D8
		BCS	loc_8144B
		RTS
; ---------------------------------------------------------------------------

loc_8144B:				; var/counter
		LDA	objects_var_cnt,X
		BMI	loc_81453
		JMP	loc_81456
; ---------------------------------------------------------------------------

loc_81453:
		JMP	loc_8147C
; ---------------------------------------------------------------------------

loc_81456:
		LDA	objects_X_relative_h,X
		BMI	loc_81466
		LDA	objects_X_relative_l,X
		CMP	#8
		BCS	locret_81465
		JMP	check_kill_obj
; ---------------------------------------------------------------------------

locret_81465:
		RTS
; ---------------------------------------------------------------------------

loc_81466:
		LDA	objects_X_relative_l,X
		CMP	#$F8
		BCS	loc_81474
		CMP	#$D0
		BCC	loc_81474
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

loc_81474:
		CMP	#$E8
		BCC	locret_8147B
		JMP	check_kill_obj
; ---------------------------------------------------------------------------

locret_8147B:
		RTS
; ---------------------------------------------------------------------------

loc_8147C:
		LDA	objects_X_relative_h,X
		BPL	loc_81493
		LDA	objects_X_relative_l,X
		CMP	#$E0
		BCC	loc_8148B
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

loc_8148B:
		CMP	#$D0
		BCC	locret_81492
		JMP	check_kill_obj
; ---------------------------------------------------------------------------

locret_81492:
		RTS
; ---------------------------------------------------------------------------

loc_81493:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCS	locret_8149D
		JMP	sonic_get_hit_from_obj
; ---------------------------------------------------------------------------

locret_8149D:
		RTS
; End of function object_caterpillar


; =============== S U B	R O U T	I N E =======================================

; single spike
object_spikes:
		JSR	check_sfx_for_spikes
		BVS	loc_814AC
		BVC	spikes_hide
; ---------------------------------------------------------------------------

loc_814AC:
		LDY	#8	; single spike Y size
		BNE	loc_81506 ; JMP


; =============== S U B	R O U T	I N E =======================================

; single spike alt timer
object_spikes2:
		JSR	check_sfx_for_spikes
		BVC	loc_814AC
		BVS	spikes_hide


; =============== S U B	R O U T	I N E =======================================

; 3x spikes
object_spikes3:
		JSR	check_sfx_for_spikes
		BVS	loc_814FA
		BVC	spikes_hide


; =============== S U B	R O U T	I N E =======================================

; 3x spikes alt timer
object_spikes4:
		JSR	check_sfx_for_spikes
		BVC	loc_814FA
spikes_hide:
		LDA	#0
		STA	objects_var_cnt,X ; var/counter
		RTS
; ---------------------------------------------------------------------------

loc_814FA:
		LDY	#$18	; 3x spikes Y size

loc_81506:
		STY	tmp_var_25
		LDA	#1
		STA	objects_var_cnt,X ; var/counter
		
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81566
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81566:
		LDA	objects_X_relative_h,X
		BEQ	loc_8157C
		CMP	#$FF
		BNE	locret_8157B
		LDA	objects_X_relative_l,X
		CLC
		ADC	#$18
		BCS	loc_81584
		ADC	#8
		BCS	loc_81584

locret_8157B:
		RTS
; ---------------------------------------------------------------------------

loc_8157C:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_81584
		RTS
; ---------------------------------------------------------------------------

loc_81584:
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	locret_8157B
		LDA	objects_Y_relative_l,X
		CMP	#$FC
		BCC	loc_81595
		LDA	sonic_anim_num
		CMP	#9	; dead
		BEQ	locret_8157B
		JMP	sonic_stand_on_spikes
; ---------------------------------------------------------------------------

loc_81595:
		CLC
		ADC	tmp_var_25
		BCS	loc_8159F
		ADC	#$18
		BCS	loc_8159F
		RTS
; ---------------------------------------------------------------------------

loc_8159F:
		LDA	sonic_state	; spikes_obj_sfx_hack
		AND	#2
		BEQ	@no_shield
		JMP	sonic_get_hit_from_obj
@no_shield:
		JSR	sonic_get_hit_from_obj
play_sfx_spikes:
		LDA	sfx_to_play
		CMP	#6
		BNE	@no_hit
		LDA	#$F	; spikes_sfx
		STA	sfx_to_play
@no_hit:
		RTS
; End of function object_spikes4

; ---------------------------------------------------------------------------
spikes_move_tbl:.BYTE	 1,   1,   2,	2,   3,	  3,   3,   4,	 4,   3
		.BYTE	 3,   3,   2,	2,   1,	  1
			
obj_29_mov_tbl:	.BYTE	 0,   1,   1,	1,   1,	  1,   2,   2,	 2,   2
		.BYTE	 1,   1,   1,	1,   1,	  0
		
		
; =============== S U B	R O U T	I N E =======================================


harpoons_34_sfx:
		LDA	Frame_Cnt
		BEQ	play_spikes_sfx
		RTS

check_sfx_for_spikes:
		LDA	Frame_Cnt
		BEQ	play_spikes_sfx		
		CMP	#$C0
		BEQ	play_spikes_sfx
		CMP	#$40
		BEQ	play_spikes_sfx
harpoons_12_sfx:		
		LDA	Frame_Cnt
		CMP	#$80
		BNE	no_spikes_sfx
		
play_spikes_sfx:
		LDA	sfx_to_play
		BNE	no_spikes_sfx
		JSR	play_fire_sfx
		LDA	sfx_to_play
		BEQ	no_spikes_sfx
		LDA	#$11	; SFX: spikes open
		STA	sfx_to_play
no_spikes_sfx:
		BIT	Frame_Cnt
		RTS


; =============== S U B	R O U T	I N E =======================================


object_fire_point:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81624
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81624:				; var/counter
		LDA	objects_var_cnt,X
		BNE	loc_81631
		LDA	objects_X_relative_h,X
		CMP	#$FF
		BEQ	@chk_pos
@ret:
		RTS
; ---------------------------------------------------------------------------
@chk_pos:
		LDA	objects_X_relative_l,X
		CMP	#$E8
		BCS	@ret
;		JSR	play_fire_sfx
;		LDA	sfx_to_play
;		BEQ	loc_81631
;		LDA	#$1A	; SFX: FIRE POINT
;		STA	sfx_to_play	; moved to draw_objs_code.asm	

loc_81631:				; var/counter
		LDA	objects_var_cnt,X
		CLC
		ADC	#2
		BCC	loc_8163B
		LDA	#$FF		; max ff

loc_8163B:				; var/counter
		STA	objects_var_cnt,X
;		CMP	#$FF
;		BEQ	@no_fire_sfx
;		PHA
;		JSR	play_fire_sfx
;		PLA
;
;@no_fire_sfx:
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#7
		TAY
		LDA	fire_hit_box_x,Y
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox
; End of function object_fire_point

; ---------------------------------------------------------------------------
fire_hit_box_x:	.BYTE	 8, $10, $18, $20, $28,	$30, $38, $40

; =============== S U B	R O U T	I N E =======================================

; 30

object_spikes_badnik:
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		BEQ	loc_8168D
		TAY
		LDA	Frame_Cnt
		AND	#3
		BNE	loc_8168A
		DEY
		BNE	loc_8167E
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		AND	#$80
		STA	objects_var_cnt,X ; var/counter
		JMP	loc_816E6
; ---------------------------------------------------------------------------

loc_8167E:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter

loc_8168A:
		JMP	loc_816E6
; ---------------------------------------------------------------------------

loc_8168D:				; var/counter
		LDA	objects_var_cnt,X
		BPL	loc_816AA
		LDA	objects_X_l,X
		SEC
		SBC	#1
		STA	objects_X_l,X
		STA	tmp_result_x_l
		LDA	objects_X_h,X
		SBC	#0
		STA	objects_X_h,X
		STA	tmp_result_x_h
		JMP	loc_816BF
; ---------------------------------------------------------------------------

loc_816AA:
		LDA	objects_X_l,X
		CLC
		ADC	#1
		STA	objects_X_l,X
		STA	tmp_result_x_l
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,X
		STA	tmp_result_x_h

loc_816BF:
		LDA	tmp_result_x_l
		CLC
		ADC	#$10
		STA	tmp_result_x_l
		BCC	loc_816CA
		INC	tmp_result_x_h

loc_816CA:
		LDA	objects_Y_l,X
		CLC
		ADC	#$20
		STA	tmp_result_y_l
		LDA	objects_Y_h,X
		STA	tmp_result_y_h
		JSR	check_for_solid_block_tmp
		BNE	loc_816E6
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		ORA	#$19
		STA	objects_var_cnt,X ; var/counter

loc_816E6:
		LDA	#32
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#4	; new type = 4
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_spikes_badnik


; =============== S U B	R O U T	I N E =======================================

; 34

object_big_spike_LR:
		LDA	Frame_Cnt
		LSR	A
		BCS	@no_move
		JSR	object_move_LR

@no_move:
		JMP	big_spikes_check_collision
; End of function object_big_spike_LR


; =============== S U B	R O U T	I N E =======================================

; 35

object_big_spike_UD:
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BEQ	object_steam_roller

		LDA	Frame_Cnt
		LSR	A
		BCS	@no_move
		JSR	object_move_UD

@no_move:
		JMP	big_spikes_check_collision
; End of function object_big_spike_UD


; =============== S U B	R O U T	I N E =======================================


object_steam_roller:
		JSR	obj_update_rel_pos_and_test
		BEQ	@ok
		JMP	object_remove
@ok
		JSR	steam_roller_move_UD
		LDA	#32
		STA	hitbox_h
		LDA	#40
		STA	hitbox_v
		;JSR	platforms_update_sonic_X_Y

collision_vs_steam_roller:
		LDA	objects_Y_relative_h,X
		BMI	@loc_80A8F
		RTS
; ---------------------------------------------------------------------------

@loc_80A8F:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$F9
		BCS	@loc_80A9F
		CMP	#$C0
		BCS	@loc_80A9D
		RTS
; ---------------------------------------------------------------------------

@loc_80A9D:
		LDY	#1

@loc_80A9F:
		STY	obj_collision_flag
		LDA	objects_X_relative_h,X
		BMI	@loc_80AAE
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	@loc_80ABB
		RTS
; ---------------------------------------------------------------------------

@loc_80AAE:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	@loc_80ABB
		ADC	#8
		BCS	@loc_80ABB
@locret_80ABA:
		RTS
; ---------------------------------------------------------------------------

@loc_80ABB:				; 8 - jump roll, $1F - spin start, $20 -spin
		LDA	sonic_act_spr
		CMP	#9	; dead
		BEQ	@locret_80ABA
		LDA	obj_collision_flag
		BNE	@not_on_steamroller
		STA	move_cam_delay ; FIX (block sonic look up/down)
		LDA	objects_var_cnt,X ; var/counter
		BPL	@no_kill
		AND	#$7F
		CMP	#33
		BCC	@kill_sonic
@no_kill:
		LDA	tmp_y_positions+1
		BEQ	@cont
		LDA	tmp_y_positions ; steamroller moves down
		BNE	@clear_sonic_Y_speed
@cont:
		JMP	sonic_stand_on_monitor
@clear_sonic_Y_speed:
		JMP	clear_sonic_Y_speed
; ---------------------------------------------------------------------------

@not_on_steamroller:
		LDA	objects_Y_relative_l,X
		CMP	#$C8+4
		BCS	@okk
		LDA	objects_var_cnt,X ; var/counter
		BMI	@no_kill2
		AND	#$7F
		CMP	#72/2
		BCC	@kill_sonic
@no_kill2
		;LDA	objects_Y_l,X
		;CLC
		;ADC	#48+24-8
		;STA	sonic_Y_l_new
		;LDA	objects_Y_h,X
		;ADC	#0
		;STA	sonic_Y_h_new
		
	;	LDA	sonic_attribs
	;	AND	#MOVE_UP
	;	BEQ	@ret_platform
		CLC
		LDA	#64
		ADC	objects_Y_l,X
		BCC	@no_inc_
		ADC	#$F
		SEC
@no_inc_
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		ADC	#0
		STA	sonic_Y_h_new
		
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	@ok
		ADC	#$F
		STA	sonic_Y_l_new
		INC	sonic_Y_h_new
@ok
		LDA	sonic_attribs
		AND	#MOVE_UP^$FF
		STA	sonic_attribs
		;LDA	#0
		;STA	sonic_Y_speed
@ret_platform
		JMP	loc_81347
; ---------------------------------------------------------------------------
@okk
		LDA	#$28
		JMP	sonic_side_collision
; ---------------------------------------------------------------------------
@kill_sonic:
		JMP	sonic_set_death	
; ---------------------------------------------------------------------------

steam_roller_move_UD:
		LDA	#0
		STA	tmp_x_positions
		STA	tmp_y_positions
		STA	tmp_x_positions+1
		STA	tmp_y_positions+1 ; inc	to sonic speed
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		TAY
		DEY
		BPL	@loc_8179A
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		AND	#$80
		ORA	#100/2
		STA	objects_var_cnt,X ; var/counter
		JMP	@loc_817A6
; ---------------------------------------------------------------------------

@loc_8179A:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter
		CPY	#60/2
		BCC	@ret_no_move

@loc_817A6:
		LDA	#6
		LDY	objects_var_cnt,X
		BMI	@loc_817C6
		STA	tmp_y_positions+1 ; inc	to sonic speed
		INC	tmp_y_positions	; dir for sonic
		JMP	object_add_Y
; ---------------------------------------------------------------------------

@loc_817C6:
		STA	tmp_y_positions+1 ; inc	to sonic speed
		JMP	object_sub_Y
@ret_no_move:
		RTS
; End of function object_move_UD


; =============== S U B	R O U T	I N E =======================================

; $71
object_wall:
		LDA	objects_var_cnt,X
		CMP	#38+100
		BCS	@no_move
		INC	objects_var_cnt,X
		CMP	#100
		BCC	@no_move
		JSR	object_inc_Y
@no_move

		JSR	obj_update_rel_pos_and_test
		BEQ	@ok
		JMP	object_remove
@ok		
		LDA	#16
		STA	hitbox_h
		;LDA	#48
		;STA	hitbox_v

collision_vs_wall:
		LDA	objects_Y_relative_h,X
		BMI	@loc_80A8F
		RTS
; ---------------------------------------------------------------------------

@loc_80A8F:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$F9
		BCS	@loc_80A9F
		CMP	#$A8
		BCS	@loc_80A9D
		RTS
; ---------------------------------------------------------------------------

@loc_80A9D:
		LDY	#1

@loc_80A9F:
		STY	obj_collision_flag
		LDA	objects_X_relative_h,X
		BMI	@loc_80AAE
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	@loc_80ABB
		RTS
; ---------------------------------------------------------------------------

@loc_80AAE:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	@loc_80ABB
		ADC	#8
		BCS	@loc_80ABB
@locret_80ABA:
		RTS
; ---------------------------------------------------------------------------

@loc_80ABB:				; 8 - jump roll, $1F - spin start, $20 -spin
		LDA	sonic_act_spr
		CMP	#9	; dead
		BEQ	@locret_80ABA
		LDA	obj_collision_flag
		BEQ	@locret_80ABA
		LDA	#24
		JMP	sonic_side_collision


; =============== S U B	R O U T	I N E =======================================

; $40
object_labfish:
		LDA	Frame_Cnt
		AND	#3
		BNE	@no_move
		JSR	object_move_LR

@no_move:
		;LDA	#32
		LDA	#24	; Jaws hitbox 24x24
		STA	hitbox_h
		;LDA	#24
		STA	hitbox_v
		LDA	#0
		STA	obj_collision_flag
		LDA	objects_var_cnt,X
		BPL	@moving_r
		JMP	update_rel_pos_and_check_collision
; ---------------------------------------------------------------------------

@moving_r:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDA	objects_X_relative_l,X
		CLC
		ADC	#15
		TAY
		LDA	objects_X_relative_h,X
		ADC	#0
		BMI	@l1
		BNE	@ret
		CPY	#8
		BCC	@check_y
@ret:
		RTS
; ---------------------------------------------------------------------------

@l1:
		TYA
		CLC
		ADC	hitbox_h
		BCS	@check_y
		ADC	#8
		BCS	@check_y
		RTS
; ---------------------------------------------------------------------------

@check_y:
		JMP	loc_80A4B
; End of function object_labfish


; =============== S U B	R O U T	I N E =======================================


object_move_LR:
		LDA	#1
		STA	tmp_x_positions+1
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		TAY
		DEY
		BPL	loc_81747
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		AND	#$80
		ORA	#$50
		STA	objects_var_cnt,X ; var/counter
		JMP	loc_81753
; ---------------------------------------------------------------------------

loc_81747:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter

loc_81753:				; var/counter
		LDA	objects_var_cnt,X
		BMI	loc_8176B
		INC	objects_X_l,X
		BNE	loc_81766
		INC	objects_X_h,X

loc_81766:
		LDA	#0
		STA	tmp_x_positions
		RTS
; ---------------------------------------------------------------------------

loc_8176B:
		JSR	object_dec_X
		LDA	#1
		STA	tmp_x_positions
		RTS
; End of function object_move_LR


; =============== S U B	R O U T	I N E =======================================


object_move_UD:
		LDA	#1
		STA	tmp_y_positions+1 ; inc	to sonic speed
		LDA	objects_var_cnt,X ; var/counter
		AND	#$7F
		TAY
		DEY
		BPL	loc_8179A
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		AND	#$80
		ORA	#$50
		STA	objects_var_cnt,X ; var/counter
		JMP	loc_817A6
; ---------------------------------------------------------------------------

loc_8179A:
		STY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		AND	#$80
		ORA	tmp_var_25
		STA	objects_var_cnt,X ; var/counter

loc_817A6:				; var/counter
		LDA	objects_var_cnt,X
		BMI	loc_817C6
		JSR	object_inc_Y
		LDA	#1	; dir for sonic
		STA	tmp_y_positions
		RTS
; ---------------------------------------------------------------------------

loc_817C6:
		JSR	object_dec_Y
		LDA	#0	; dir for sonic
		STA	tmp_y_positions
		RTS
; End of function object_move_UD


; =============== S U B	R O U T	I N E =======================================


object_41:
		LDA	#0
		STA	objects_var_cnt,X ; var/counter
		JMP	object_small_blue_spike
; End of function object_41


; =============== S U B	R O U T	I N E =======================================


object_42:
		LDA	#$80
		STA	objects_var_cnt,X ; var/counter
		JMP	object_small_blue_spike
; End of function object_42


; =============== S U B	R O U T	I N E =======================================

; $78
object_bubble_spawner_H:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
@on_screen

object_bubble_spawner_H_:
		LDA	Frame_Cnt
		AND	#$F
		BNE	@limit
		
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	bubble_h_positions,Y
		STA	tmp_var_25
		
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-2
		BCS	@limit1
		JSR	@create_h_bubble
		INY
		STY	objects_cnt

@limit:
		RTS
		
@limit1:
		DEY
		LDA	#$45	 ; small bubble
@search_bubbles:
		CMP	objects_type,Y
		BEQ	@small_bubble
		DEY
		BPL	@search_bubbles
		RTS
		
@small_bubble:
		;JSR	@create_h_bubble
		
@create_h_bubble:
		LDA	#$79
		STA	objects_type,Y
		LDA	objects_var_cnt,X
		AND	#$80
		STA	objects_var_cnt,Y
		LDA	#0
		STA	objects_sav_slot,Y
		STA	objects_delay,Y
		LDA	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		STA	objects_X_h,Y
		LDA	objects_Y_l,X
		SBC	tmp_var_25
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		SBC	#0
		STA	objects_Y_h,Y
		RTS
		
bubble_h_positions:
		.BYTE	08,32,16,24
		.BYTE	12,02,20,28
		.BYTE	04,30,06,22
		.BYTE	18,14,26,10
		

; =============== S U B	R O U T	I N E =======================================

; $79
object_bubble_H:
		LDA	#3
		LDY	objects_var_cnt,X
		BPL	@right
		JSR	object_sub_X
		JMP	@left
@right:
		JSR	object_add_X
@left:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
@remove:
		JMP	remove_temp_obj
	
@on_screen:
		LDA	objects_var_cnt,X
		AND	#2
		BEQ	@c1
		JSR	object_inc_Y
		JMP	@c2
; ---------------------------------------------------------------------------

@c1:
		JSR	object_dec_Y
@c2:		
@skip
		INC	objects_var_cnt,X
		LDA	objects_var_cnt,X
		AND	#$7F
		CMP	#30
		BCS	@remove
		RTS


; =============== S U B	R O U T	I N E =======================================


object_bubble_spawner:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_817FB
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_817FB:
		LDA	Frame_Cnt
		AND	#$7F
		BNE	locret_8183F
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		AND	#$F
		TAX
		LDA	boss_func_num
		CMP	#3
		BNE	not_a_boss
		LDA	bubble_boss_tbl,X
		JMP	bubbles_on_boss
not_a_boss:
		LDA	bubble_spwn_tbl,X
bubbles_on_boss:		
		BMI	locret_8183F
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-2	; obj slot limit for big bubbles
		BCS	locret_8183F
		CMP	#$44	; big bubble?
		BEQ	@big_bubble
		CPY	#OBJECTS_SLOTS-5	; obj slot limit for small bubbles
		BCS	locret_8183F
@big_bubble		
		LDX	object_slot
		STA	objects_type,Y
		LDA	#0
		STA	objects_var_cnt,Y ; var/counter
		STA	objects_sav_slot,Y
		STA	objects_delay,Y

obj_copy_pos:
		LDA	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		STA	objects_X_h,Y
		LDA	objects_Y_l,X
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		STA	objects_Y_h,Y
		INY
		STY	objects_cnt

locret_8183F:
		RTS
; End of function object_bubble_spawner

; ---------------------------------------------------------------------------

;check_for_bubbles2:
;		CMP	#$44	; big bubble?
;		BNE	locret_8183F
;		STY	tmp_var_25 ; save obj cnt
;		
;@search_bubbles:
;		LDA	objects_type,Y
;		CMP	#$45 ; small bubble
;		BEQ	@is_bubble
;		CMP	#$46 ; medium bubble
;		BEQ	@is_bubble
;		DEY
;		BPL	@search_bubbles
;		RTS
;		
;@is_bubble:
;		LDA	#$44	; big bubble
;		STA	objects_type,Y
;		JSR	obj_copy_pos
;		LDY	tmp_var_25 ; restore obj cnt
;		STY	objects_cnt ; restore obj cnt
;		RTS
; ---------------------------------------------------------------------------
;44 Big bubble | FF No bubble | 46 Median | 45 Mini
bubble_spwn_tbl:.BYTE  $FF, $FF, $44, $FF
                .BYTE  $45, $44, $46, $FF
                .BYTE  $46, $FF, $45, $FF
                .BYTE  $44, $ff, $46, $44
		
bubble_boss_tbl:.BYTE  $FF, $FF, $44, $FF
                .BYTE  $46, $44, $FF, $FF
                .BYTE  $44, $FF, $46, $44
                .BYTE  $FF, $FF, $44, $FF
		

; =============== S U B	R O U T	I N E =======================================


object_bubble_mini:
		LDA	Frame_Cnt
		AND	#3
		BNE	object_bubble
		INC	objects_delay,X
		BNE	object_bubble
		JMP	remove_temp_obj

object_bubble:
		JSR	check_for_solid_block
		CPY	#$99
		BNE	@not_out_of_water
		JMP	remove_temp_obj
@not_out_of_water:
		LDX	object_slot
		LDY	Frame_Cnt
		LDA	objects_var_cnt,X ; var/counter
		CMP	#$81
		BCS	loc_81861
		INC	objects_var_cnt,X ; var/counter
		LDY	objects_var_cnt,X ; var/counter

loc_81861:
		TYA
		AND	#3
		BNE	loc_818A0
		TYA
		AND	#$30
		BEQ	loc_81880
		CMP	#$20
		BNE	loc_8188E
		INC	objects_X_l,X
		BNE	@no_inc_h
		INC	objects_X_h,X
@no_inc_h
		JMP	loc_8188E
; ---------------------------------------------------------------------------

loc_81880:
		JSR	object_dec_X

loc_8188E:
		JSR	object_dec_Y

loc_818A0:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_818D6
delete_small_bubble:
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

bubble_Y_dist_chk:
		LDA	objects_type,X
		CMP	#$44		; BIG BUBBLE?
		BEQ	is_big_bubble
		LDA	objects_Y_relative_l,X
		CMP	#$50
		BCC	delete_small_bubble
locret_818E7:
		RTS
; ---------------------------------------------------------------------------

loc_818D6:
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BEQ	bubble_Y_dist_chk
		
		LDA	objects_type,X
		CMP	#$44		; BIG BUBBLE?
		BNE	locret_818E7
is_big_bubble:
		LDA	objects_var_cnt,X ; var/counter
		CMP	#$81
		BCC	locret_818E7
		JMP	bubble_collision_check
; End of function object_bubble


; =============== S U B	R O U T	I N E =======================================

; decrement obj Y pos by 1
object_dec_Y:
		LDA	objects_Y_l,X
		BNE	@no_dec_h
		DEC	objects_Y_h,X
		LDA	#$F0
		STA	objects_Y_l,X
@no_dec_h
		DEC	objects_Y_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================

; increment obj Y pos by 1
object_inc_Y:
		LDA	#1
; add to obj Y pos
object_add_Y:
		CLC
		ADC	objects_Y_l,X
		CMP	#$F0
		BCC	@no_inc_h
		INC	objects_Y_h,X
		ADC	#$F
@no_inc_h:
		STA	objects_Y_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================

; sub obj Y pos
object_sub_Y:
		STA	tmp_var_26
		LDA	objects_Y_l,X
		SEC
		SBC	tmp_var_26
		BCS	@no_dec_h
		DEC	objects_Y_h,X
		SBC	#$F
@no_dec_h:
		STA	objects_Y_l,X
		RTS


; =============== S U B	R O U T	I N E =======================================

; uni-uni in lab zone
object_spike_shooter:
		JSR	uni_uni_move_LR

		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		BEQ	loc_81933
		CMP	#$FF
		BEQ	loc_81933
		JMP	loc_8194A
; ---------------------------------------------------------------------------

loc_81933:
		LDA	objects_Y_l,X
		SEC
		SBC	sonic_Y_l_new
		STA	objects_Y_relative_l,X
		LDA	objects_Y_h,X
		SBC	sonic_Y_h_new
		STA	objects_Y_relative_h,X
		BEQ	loc_81959
		CMP	#$FF
		BEQ	loc_8195D

loc_8194A:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$F
		CMP	#$F
		BEQ	loc_81956
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81956:
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_81959:
		LDA	#$F0
		BNE	loc_8195F

loc_8195D:
		LDA	#$10

loc_8195F:
		STA	tmp_var_25
		LDA	objects_Y_h,X
		CMP	sonic_Y_h_new
		BEQ	loc_81985
		LDA	tmp_var_25
		CLC
		ADC	objects_Y_relative_l,X
		STA	objects_Y_relative_l,X
		LDA	tmp_var_25
		BMI	loc_8197D
		LDA	objects_Y_relative_h,X
		ADC	#0
		JMP	loc_81982
; ---------------------------------------------------------------------------

loc_8197D:
		LDA	objects_Y_relative_h,X
		SBC	#0

loc_81982:
		STA	objects_Y_relative_h,X

loc_81985:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$10
		BNE	loc_819C3
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	loc_819C3
		LDA	objects_Y_relative_l,X
		CMP	#$A0
		BCC	loc_819C3
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_819AD
		LDA	objects_X_relative_h,X
		BNE	loc_819C3
		LDA	objects_X_relative_l,X
		CMP	#$70
		BCS	loc_819C3
		BCC	loc_819BB

loc_819AD:
		LDA	objects_X_relative_h,X
		CMP	#$FF
		BNE	loc_819C3
		LDA	objects_X_relative_l,X
		CMP	#$90
		BCC	loc_819C3

loc_819BB:				; var/counter
		LDA	objects_var_cnt,X
		ORA	#$10
		STA	objects_var_cnt,X ; var/counter

loc_819C3:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$7F	; FIX bug with Uniuni distance attack from right (object_spike_shooter)		
		CMP	#$10
		BCC	loc_81A33
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#$F
		STA	tmp_var_25
		AND	#3		; attack interval
		BNE	loc_81A33
		LDA	tmp_var_25
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	byte_81A4F,Y
		STA	tmp_var_25
		TAY
		LDA	objects_var_cnt,X ; var/counter
		AND	byte_81A4B,Y
		BNE	loc_81A33
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS	; fix - check obj limit
		BCS	loc_81A33
		LDA	objects_X_l,X
		;CLC
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		;ADC	#0
		STA	objects_X_h,Y
		LDA	objects_Y_l,X
		CLC
		ADC	#$10
		CMP	#$F0
		BCC	loc_81A0B
		CLC
		ADC	#$10

loc_81A0B:
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		ADC	#0
		STA	objects_Y_h,Y
		LDA	#$48
		STA	objects_type,Y
		LDA	objects_var_cnt,X ; var/counter
		EOR	#$80
		AND	#$80
		STA	objects_var_cnt,Y ; var/counter
		hide_obj_sprite
		INY
		STY	objects_cnt
		LDY	tmp_var_25
		LDA	objects_var_cnt,X ; var/counter
		ORA	byte_81A4B,Y
		STA	objects_var_cnt,X ; var/counter

loc_81A33:
		LDA	#16
		STA	hitbox_h
		STA	hitbox_v
		LDY	#3
		LDA	objects_var_cnt,X ; var/counter
		AND	#$F
		CMP	#$F
		BNE	loc_81A46
		LDY	#0

loc_81A46:
		STY	obj_collision_flag
		JMP	check_collision_both_hitbox
; End of function object_spike_shooter

; ---------------------------------------------------------------------------
byte_81A4B:	.BYTE	 1,   2,   4,	8
byte_81A4F:	.BYTE	 0,   3,   2,	1

; =============== S U B	R O U T	I N E =======================================


object_harpoon_Left:
		JSR	harpoons_12_sfx
		LDA	#2
		STA	obj_collision_flag
		;LDX	object_slot
		LDA	Frame_Cnt
		EOR	#$80
		AND	#$80
		BNE	loc_81A71
		LDA	#40
		STA	hitbox_h
		LDA	#8
		STA	hitbox_v
		LDA	#1
		STA	objects_var_cnt,X ; var/counter
		;JMP	update_rel_pos_and_check_collision
		JMP	harpoon_sfx_hack
; ---------------------------------------------------------------------------

loc_81A71:
		LDA	#0
		STA	objects_var_cnt,X ; var/counter

		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81AD6
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81AD6:
		LDA	objects_Y_relative_h,X
		CMP	#$FF
		BNE	locret_81AF5
		LDA	objects_Y_l,X
		CMP	#$E8
		BCC	locret_81AF5
		LDA	objects_X_relative_h,X
		CMP	#$FF
		BNE	locret_81AF5
		LDA	objects_X_relative_l,X
		CMP	#$E8
		BCS	locret_81AF5
		JMP	harpoon_sfx_hack2
; ---------------------------------------------------------------------------

locret_81AF5:
		RTS
; End of function object_harpoon_Left


; =============== S U B	R O U T	I N E =======================================


object_harpoon_UP:
		JSR	harpoons_12_sfx
		LDA	#2
		STA	obj_collision_flag
		;LDX	object_slot
		LDA	Frame_Cnt
		EOR	#$80
		AND	#$80
		BNE	loc_81B14
		LDA	#40
		STA	hitbox_v
		LDA	#8
		STA	hitbox_h
		LDA	#1
		STA	objects_var_cnt,X ; var/counter
		;JMP	update_rel_pos_and_check_collision
		JMP	harpoon_sfx_hack
; ---------------------------------------------------------------------------

loc_81B14:
		LDA	#0
		STA	objects_var_cnt,X ; var/counter

		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81B79
		JMP	object_remove
; ---------------------------------------------------------------------------
loc_81B79
		LDA	objects_Y_relative_h,X
		BNE	locret_81BA3
		LDA	objects_Y_l,X
		CMP	#$20
		BCC	locret_81BA3
		LDA	objects_X_relative_h,X
		BEQ	loc_81B8F
		CMP	#$FF
		BEQ	loc_81B99
		RTS
; ---------------------------------------------------------------------------

loc_81B8F:
		LDA	objects_X_relative_l,X
		CMP	#8
		BCS	locret_81BA3
		JMP	harpoon_sfx_hack2
; ---------------------------------------------------------------------------

loc_81B99:
		LDA	objects_X_relative_l,X
		CMP	#$F0
		BCC	locret_81BA3
		JMP	harpoon_sfx_hack2
; ---------------------------------------------------------------------------

locret_81BA3:
		RTS
; End of function object_harpoon_UP


; =============== S U B	R O U T	I N E =======================================


harpoon_sfx_hack:
		LDA	sonic_state
		AND	#2
		BEQ	@no_shield
		JMP	update_rel_pos_and_check_collision
	
@no_shield:
		LDA	sfx_to_play
		PHA
		JSR	update_rel_pos_and_check_collision
		JMP	spikes_sfx_check
		
		
; =============== S U B	R O U T	I N E =======================================
		
		
harpoon_sfx_hack2:
		LDA	sonic_state
		AND	#2
		BEQ	@no_shield
		JMP	check_collision_both_hitbox
		
@no_shield:
		LDA	sfx_to_play
		PHA
		JSR	check_collision_both_hitbox
spikes_sfx_check:
		PLA
		EOR	sfx_to_play
		BEQ	@sfx_not_changed
		JMP	play_sfx_spikes
@sfx_not_changed
		RTS


; =============== S U B	R O U T	I N E =======================================


object_harpoon_Left_alt:
		JSR	harpoons_34_sfx
		LDA	#2
		STA	obj_collision_flag
		;LDX	object_slot
		LDA	Frame_Cnt
		BMI	loc_81BBA
		LDA	#$28
		STA	hitbox_h
		LDA	#1
		BNE	loc_81BC3
		;STA	objects_var_cnt,X ; var/counter
		;JMP	loc_81BC3
; ---------------------------------------------------------------------------

loc_81BBA:
		LDA	#8
		STA	hitbox_h
		LDA	#0
		
loc_81BC3:		
		STA	objects_var_cnt,X ; var/counter

		LDA	#8
		STA	hitbox_v
		JMP	harpoon_sfx_hack
; End of function object_harpoon_Left_alt


; =============== S U B	R O U T	I N E =======================================


object_harpoon_UP_alt:
		JSR	harpoons_34_sfx
		LDA	#2
		STA	obj_collision_flag
		;LDX	object_slot
		LDA	Frame_Cnt
		BMI	loc_81BE0
		LDA	#40
		STA	hitbox_v
		LDA	#1
		BNE	loc_81BE9		
		;STA	objects_var_cnt,X ; var/counter
		;JMP	loc_81BE9
; ---------------------------------------------------------------------------

loc_81BE0:
		LDA	#8
		STA	hitbox_v
		LDA	#0
	
loc_81BE9:	
		STA	objects_var_cnt,X ; var/counter


		LDA	#8
		STA	hitbox_h
		JMP	harpoon_sfx_hack
; End of function object_harpoon_UP_alt


; =============== S U B	R O U T	I N E =======================================


object_platform_move_up:
		LDA	#0
		STA	tmp_x_positions	; x-dir
		STA	tmp_x_positions+1 ; x-inc
		STA	tmp_y_positions	; y-dir
		STA	tmp_y_positions+1 ; y-inc
		
		LDA	objects_var_cnt,X ; var/counter
		BEQ	platform_wait
		LDY	#2
		LDA	objects_var_cnt,X ; var/counter
		CLC
		ADC	#1
		STA	objects_var_cnt,X ; var/counter
		CMP	#$3C		; wait move
		BCC	loc_81C52
		CMP	#$98	; move limit
		BCC	loc_81C1B
		LDA	#$98	; move limit
		STA	objects_var_cnt,X ; var/counter
		LDY	#0	; fix (stop move)

loc_81C1B:
		STY	tmp_y_positions+1
		LDA	objects_Y_l,X
		SEC
		SBC	tmp_y_positions+1
		STA	objects_Y_l,X
		CMP	#$F0
		BCC	loc_81C32
		SBC	#$10
		STA	objects_Y_l,X
		DEC	objects_Y_h,X

loc_81C32:
		JMP	loc_81C52
; ---------------------------------------------------------------------------

platform_wait:
		LDA	objects_Y_relative_h,X
		BNE	loc_81C52
		LDA	objects_Y_relative_l,X
		BNE	loc_81C52
		LDA	objects_X_relative_h,X
		CMP	#$FF
		BNE	loc_81C52
		LDA	objects_X_relative_l,X
		CMP	#$E0		; hitbox X
		BCC	loc_81C52
		LDA	#1
		STA	objects_var_cnt,X ; var/counter

loc_81C52:
		LDA	#32
		STA	hitbox_h
		LDA	#16
		STA	hitbox_v
		JMP	platforms_update_sonic_X_Y
; End of function object_platform_move_up


; =============== S U B	R O U T	I N E =======================================

; $50, star light zone
object_uni_uni:
		JSR	uni_uni_move_LR		
		JSR	obj_update_rel_pos_and_test
		BEQ	@check_coll
		JMP	object_remove
; ---------------------------------------------------------------------------

@check_coll:
		LDA	#28
		STA	hitbox_h
		STA	hitbox_v
		LDY	#3
		STY	obj_collision_flag
		
		LDA	objects_X_relative_l,X
		SEC
		SBC	#6
		TAY
		LDA	objects_X_relative_h,X
		SBC	#0
		;BMI	@l1
		CMP	#$FF
		BEQ	@l1
		CPY	#8
		BCC	@check_y
		RTS
; ---------------------------------------------------------------------------

@l1:
		TYA
		CLC
		ADC	hitbox_h
		BCS	@check_y
		ADC	#8
		BCS	@check_y
		RTS
; ---------------------------------------------------------------------------

@check_y:
		LDA	objects_Y_relative_l,X
		SEC
		SBC	#6
		TAY
		LDA	objects_Y_relative_h,X
		SBC	#0
		CMP	#$FF
		BNE	@no_coll_y
		TYA
		JMP	coll_check_Y
		
@no_coll_y
		RTS
; End of function object_uni_uni


; =============== S U B	R O U T	I N E =======================================


uni_uni_move_LR:
		LDA	Frame_Cnt
		AND	#3
		BNE	@skip_move
		LDA	objects_var_cnt,X
		BPL	@move_right
		JMP	object_dec_X
@move_right
		JMP	object_inc_X
@skip_move
		RTS


; =============== S U B	R O U T	I N E =======================================

; $38
object_big_plat_move_LR:	; big platform
		LDA	#40
		LDY	#24
		BNE	loc_81CB7
; ---------------------------------------------------------------------------

; $39
object_small_plat_move_LR:	; scrap brain zone
; $48
object_lab_plat_move_LR:	; lab zone platform
		LDA	#32
		LDY	#16

loc_81CB7:
		JSR	platforms_sub
		LDA	Frame_Cnt
		LSR	A
		BCS	loc_81CD3
		JSR	object_move_LR

loc_81CD3:
		JMP	platforms_update_sonic_X_Y
; End of function object_big_plat_move_LR


; =============== S U B	R O U T	I N E =======================================


object_big_plat_move_UD:
		LDA	#40
		LDY	#24
		BNE	loc_81CEE
; ---------------------------------------------------------------------------

object_platform_moved_UD:
		LDA	#32
		LDY	#16

loc_81CEE:
		JSR	platforms_sub
		LDA	Frame_Cnt
		EOR	#1	; platform with water sync fix
		LSR	A
		BCS	loc_81D0A
		JSR	object_move_UD

loc_81D0A:
		JMP	platforms_update_sonic_X_Y
; End of function object_big_plat_move_UD


platforms_sub:
		STA	hitbox_h
		STY	hitbox_v

		LDA	#0
		STA	tmp_x_positions
		STA	tmp_x_positions+1
		STA	tmp_y_positions
		STA	tmp_y_positions+1
		JMP	obj_get_relative_pos


; =============== S U B	R O U T	I N E =======================================

; $51, $52
object_star_light_bomb:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81D29
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81D29:
		LDA	objects_Y_relative_h,X
		BEQ	loc_81D3B
		CMP	#$FF
		BEQ	loc_81D33
		RTS
; ---------------------------------------------------------------------------

loc_81D33:
		LDA	objects_Y_relative_l,X
		CMP	#$A0
		BCS	loc_81D43
		RTS
; ---------------------------------------------------------------------------

loc_81D3B:
		LDA	objects_Y_relative_l,X
		CMP	#$60
		BCC	loc_81D43
		RTS
; ---------------------------------------------------------------------------

loc_81D43:
		LDA	objects_X_relative_h,X
		BEQ	loc_81D55
		CMP	#$FF
		BEQ	loc_81D4D
		RTS
; ---------------------------------------------------------------------------

loc_81D4D:
		LDA	objects_X_relative_l,X
		CMP	#$A0
		BCS	loc_81D5D
		RTS
; ---------------------------------------------------------------------------

loc_81D55:
		LDA	objects_X_relative_l,X
		CMP	#$60
		BCC	loc_81D5D
		RTS
; ---------------------------------------------------------------------------

loc_81D5D:
		LDA	Frame_Cnt
		AND	#1
		BNE	loc_81D66
		INC	objects_var_cnt,X ; var/counter

loc_81D66:				; var/counter
		LDA	objects_var_cnt,X
		AND	#$7F
		CMP	#$1E
		BCS	bomb_explosion
no_bomb_explosion:
		LDA	#2
		STA	obj_collision_flag
		LDA	#16
		STA	hitbox_h
		LDA	#32
		STA	hitbox_v
		JMP	check_collision_both_hitbox
; ---------------------------------------------------------------------------

bomb_explosion:
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-1	; fix - check obj limit
		BCS	no_bomb_explosion

		LDA	objects_type,X
		CMP	#$52
		BNE	@alt_v
		LDA	#$8E
		LDY	#$E
		JMP	@alt
	
@alt_v	
		LDA	#$88
		LDY	#8
@alt
		STA	tmp_var_25
		STY	tmp_var_26
		STA	tmp_var_27
		STY	tmp_var_28
		LDY	#9	; boss hit/exp
		STY	sfx_to_play
		
		LDA	objects_Y_l,X
		LDY	objects_type,X
		CPY	#$51
		BEQ	loc_81DF3
		CLC
		ADC	#32
loc_81DF3:
		STA	tmp_var_29

		LDA	#3	; make_4_bombs
		STA	tmp_var_2B

@next_piece:
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS	; fix - check obj limit
		BCS	@limit
		
		LDX	tmp_var_2B
		LDA	tmp_var_25,X
		STA	objects_var_cnt,Y

		LDA	b_piece_types,X
		STA	objects_type,Y
		
		LDA	b_piece_x_pos,X
		LDX	object_slot
		CLC
		ADC	objects_X_l,X
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,Y
		
		LDA	tmp_var_29
		STA	objects_Y_l,Y
		
		LDA	objects_Y_h,X
		STA	objects_Y_h,Y
		
		hide_obj_sprite
		INY
		STY	objects_cnt
		DEC	tmp_var_2B
		BPL	@next_piece
@limit:
		LDA	#$1D	; object_explode
		STA	objects_type,X
		LDA	#$85
		STA	objects_var_cnt,X
		RTS
; End of function object_star_light_bomb
; ---------------------------------------------------------------------------
b_piece_x_pos:	.BYTE	$00,$10,$00,$10 ; +x
b_piece_types:	.BYTE	$1B,$1B,$0F,$0F ; type


; =============== S U B	R O U T	I N E =======================================


object_burrobot:
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	burrobot_x_tbl,Y
		BEQ	@check_y
		BMI	@move_l
		JSR	object_inc_X
		JMP	@check_y
@move_l
		JSR	object_dec_X
@check_y
		LDA	burrobot_y_tbl,Y
		BEQ	@nx
		BMI	@move_u
		JSR	object_add_Y
		JMP	@nx
@move_u
		AND	#$7F
		JSR	object_sub_Y

@nx
		LDA	#16
		STA	hitbox_h
		LDA	#32
		STA	hitbox_v
		LDA	#0
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_burrobot

; ---------------------------------------------------------------------------
burrobot_x_tbl:	.BYTE	 0,   0,   0,	0, $FF,	$FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE	 0,   0,   0,	0,   1,	  1,   1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1
burrobot_y_tbl:	.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0
		.BYTE	 0,   0,   0,	0, $85,	$82,   2,   5
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0
		.BYTE	 0,   0,   0,	0, $85,	$82,   2,   5

; =============== S U B	R O U T	I N E =======================================


update_rel_pos_and_check_collision:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81F2C
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_81F2C:
		JMP	check_collision_both_hitbox
; End of function update_rel_pos_and_check_collision


; =============== S U B	R O U T	I N E =======================================

; for temporary created objects (badnik projectiles e.t.c).
update_rel_pos_and_check_coll_temp:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_81F91
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_81F91:
		JMP	check_collision_both_hitbox
; End of function update_rel_pos_and_check_coll_temp


; =============== S U B	R O U T	I N E =======================================


;obj_update_rel_pos_and_test_ext:
;		LDX	object_slot
;		LDA	objects_X_l,X
;		SEC
;		SBC	sonic_X_l_new
;		STA	objects_X_relative_l,X
;		LDA	objects_X_h,X
;		SBC	sonic_X_h_new
;		STA	objects_X_relative_h,X
;		BMI	@cmp_m
;		CMP	#1
;		BCC	loc_81FB0
;		JMP	loc_81FF9
;@cmp_m
;		CMP	#$FE
;		BCS	loc_81FB0
;		JMP	loc_81FF9


; =============== S U B	R O U T	I N E =======================================


obj_update_rel_pos_and_test_ldx_slot:
		LDX	object_slot
obj_update_rel_pos_and_test:
		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		BEQ	loc_81FB0
		CMP	#$FF
		BEQ	loc_81FB0
		RTS	; RETURN BNE
; ---------------------------------------------------------------------------

loc_81FB0:
		LDA	objects_Y_l,X
		SEC
		SBC	sonic_Y_l_new
		STA	objects_Y_relative_l,X
		LDA	objects_Y_h,X
		SBC	sonic_Y_h_new
		STA	objects_Y_relative_h,X
		BEQ	loc_81FCA
		CMP	#$FF
		BEQ	loc_81FCE
		RTS	; RETURN BNE
; ---------------------------------------------------------------------------

loc_81FCA:
		LDA	#$F0
		BNE	loc_81FD0

loc_81FCE:
		LDA	#$10

loc_81FD0:
		STA	tmp_var_25
		LDA	objects_Y_h,X
		EOR	sonic_Y_h_new
		BEQ	loc_81FF6
		LDA	tmp_var_25
		CLC
		ADC	objects_Y_relative_l,X
		STA	objects_Y_relative_l,X
		LDA	tmp_var_25
		BMI	loc_81FEE
		LDA	objects_Y_relative_h,X
		ADC	#0
		JMP	loc_81FF3
; ---------------------------------------------------------------------------

loc_81FEE:
		LDA	objects_Y_relative_h,X
		SBC	#0

loc_81FF3:
		STA	objects_Y_relative_h,X
		LDA	#0	; return BEQ
loc_81FF6:
		RTS
; End of function obj_update_rel_pos_and_test

; ---------------------------------------------------------------------------
; BANKA:9FFC
 .pad $A000

; =============== S U B	R O U T	I N E =======================================


pro_level_objects:
		JSR	read_lvl_objects

		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$14
		STA	MMC3_bank_data
		ELSE
		LDA	#$14
		STA	VRC7_prg_8000
		ENDIF
		
		JSR	pro_objects
		LDA	capsule_func_num
		BEQ	loc_82017
		JSR	capsule_work

loc_82017:
		JMP	objects_sort
locret_8201A:
		RTS
; End of function pro_level_objects

; ---------------------------------------------------------------------------

;unused_2A02B:
		LDA	#2
;		STA	$4100
;		JSR	unused_init_level_size_DUP
;		LDA	#1
;		STA	$4100
;		RTS

read_lvl_objects:
		LDA	sonic_anim_num
		CMP	#$11	; new drowning death
		BEQ	locret_8201A
		LDX	objects_cnt
		CPX	#OBJECTS_SLOTS
		BEQ	locret_8201A ; too many objects


; =============== S U B	R O U T	I N E =======================================


;read_lvl_objects:
		LDA	level_id
		CMP	#FINAL_ZONE
		BCC	loc_82033
		JMP	loc_82243
; ---------------------------------------------------------------------------

loc_82033:
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz_a2
		LDA	act_id
		CMP	#1
		BNE	@not_sbz_a2
		LDX	#$7A000/$2000
		BNE	@sbz_a2
@not_sbz_a2:
		LDX	level_bkg_prg
@sbz_a2:

		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		STX	MMC3_bank_data
		
		ELSE
		STX	VRC7_prg_8000
		ENDIF

		LDY	sonic_Y_h
		LDA	cam_y_mults,Y
		CLC
		ADC	sonic_X_h
		TAY
		DEY
		LDA	(level_objs_ptr),Y ; BANK6:AC00	 (8C00)	 (1AC10)
		STA	tmp_x_positions+3
		INY
		INY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+4
		TYA
		CLC
		ADC	level_scr_length
		TAY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+7
		DEY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+6
		DEY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+5
		TYA
		SEC
		SBC	level_scr_length
		SEC
		SBC	level_scr_length
		TAY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions
		INY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+1
		INY
		LDA	(level_objs_ptr),Y
		STA	tmp_x_positions+2
		LDY	sonic_X_h
		STY	tmp_y_positions+1
		STY	tmp_y_positions+6
		DEY
		STY	tmp_y_positions
		STY	tmp_y_positions+3
		STY	tmp_y_positions+5
		INY
		INY
		STY	tmp_y_positions+2
		STY	tmp_y_positions+4
		STY	tmp_y_positions+7
		
		LDY	act_id
		BEQ	act1_objs
		JMP	act1_2_objs
; ---------------------------------------------------------------------------

act1_objs:
		;LDY	#0

loc_8209A:
		STY	tmp_var_2B
		LDX	tmp_x_positions,Y
		BEQ	loc_82119
		LDA	tmp_y_positions,Y
		STA	tmp_var_28

loc_820A5:
		LDA	$9100,X ; +
		CMP	tmp_var_28
		BNE	loc_82119
		LDA	$9000,X	; +
		BEQ	loc_82116
		TAY
		LDA	objs_cam_flag,Y
		BEQ	loc_820D1
		LDA	$9080,X ; +
		SEC
		SBC	camera_X_l_old
		LDA	$9100,X ; +
		SBC	camera_X_h_old
		BNE	loc_820D1
		LDA	$9180,X ; +
		SEC
		SBC	camera_Y_l_old
		LDA	$9200,X ; +
		SBC	camera_Y_h_old
		BEQ	loc_82116

loc_820D1:
		LDY	killed_objs_tbl,X
		LDA	killed_objs_mem,Y
		AND	killed_objs_mask_0,X
		BNE	loc_82116
		LDA	killed_objs_mem,Y
		ORA	killed_objs_mask_0,X
		STA	killed_objs_mem,Y
		LDY	objects_cnt
		LDA	$9100,X ; +
		STA	objects_X_h,Y
		LDA	$9080,X ; +
		STA	objects_X_l,Y
		LDA	$9000,X ; +
		STA	objects_type,Y
		LDA	$9180,X ; +
		STA	objects_Y_l,Y
		LDA	$9200,X ; +
		STA	objects_Y_h,Y
		LDA	$9280,X	; +
		STA	objects_var_cnt,Y ; var/counter
		LDA	#0	; init delay = 0
		STA	objects_delay,Y
		TXA
		STA	objects_sav_slot,Y
		INY
		STY	objects_cnt
		CPY	#OBJECTS_SLOTS
		BCS	locret_82123

loc_82116:
		INX
		BNE	loc_820A5

loc_82119:
		LDY	tmp_var_2B
		INY
		CPY	#8
		BCS	locret_82123
		JMP	loc_8209A
; ---------------------------------------------------------------------------

locret_82123:
		RTS
; ---------------------------------------------------------------------------

act1_2_objs:
		DEY
		BEQ	act2_objs
		JMP	act3_objs
; ---------------------------------------------------------------------------

act2_objs:
		;LDY	#0

loc_8212D:
		STY	tmp_var_2B
		LDX	tmp_x_positions,Y
		BEQ	loc_821AC
		LDA	tmp_y_positions,Y
		STA	tmp_var_28

loc_82138:
		LDA	$9400,X ; 
		CMP	tmp_var_28
		BNE	loc_821AC
		LDA	$9300,X	; 
		BEQ	loc_821A9
		TAY
		LDA	objs_cam_flag,Y
		BEQ	loc_82164
		LDA	$9380,X ; 
		SEC
		SBC	camera_X_l_old
		LDA	$9400,X ; 
		SBC	camera_X_h_old
		BNE	loc_82164
		LDA	$9480,X ; 
		SEC
		SBC	camera_Y_l_old
		LDA	$9500,X ; 
		SBC	camera_Y_h_old
		BEQ	loc_821A9

loc_82164:
		LDY	killed_objs_tbl,X
		LDA	killed_objs_mem,Y
		AND	killed_objs_mask_0,X
		BNE	loc_821A9
		LDA	killed_objs_mem,Y
		ORA	killed_objs_mask_0,X
		STA	killed_objs_mem,Y
		LDY	objects_cnt
		LDA	$9400,X ; 
		STA	objects_X_h,Y
		LDA	$9380,X ; 
		STA	objects_X_l,Y
		LDA	$9300,X ; 
		STA	objects_type,Y
		LDA	$9480,X ; 
		STA	objects_Y_l,Y
		LDA	$9500,X ; 
		STA	objects_Y_h,Y
		LDA	$9580,X	; 
		STA	objects_var_cnt,Y ; var/counter
		LDA	#0	; init delay = 0
		STA	objects_delay,Y
		TXA
		STA	objects_sav_slot,Y
		INY
		STY	objects_cnt
		CPY	#OBJECTS_SLOTS
		BCS	locret_821B6

loc_821A9:
		INX
		BNE	loc_82138

loc_821AC:
		LDY	tmp_var_2B
		INY
		CPY	#8
		BCS	locret_821B6
		JMP	loc_8212D
; ---------------------------------------------------------------------------

locret_821B6:
		RTS
; ---------------------------------------------------------------------------

act3_objs:
		LDY	#0

loc_821B9:
		STY	tmp_var_2B
		LDX	tmp_x_positions,Y
		BEQ	loc_82238
		LDA	tmp_y_positions,Y
		STA	tmp_var_28

loc_821C4:
		LDA	$9700,X ; 
		CMP	tmp_var_28
		BNE	loc_82238
		LDA	$9600,X ; 
		BEQ	loc_82235
		TAY
		LDA	objs_cam_flag,Y
		BEQ	loc_821F0
		LDA	$9680,X ; 
		SEC
		SBC	camera_X_l_old
		LDA	$9700,X ;
		SBC	camera_X_h_old
		BNE	loc_821F0
		LDA	$9780,X ; 
		SEC
		SBC	camera_Y_l_old
		LDA	$9800,X ; 
		SBC	camera_Y_h_old
		BEQ	loc_82235

loc_821F0:
		LDY	killed_objs_tbl,X
		LDA	killed_objs_mem,Y
		AND	killed_objs_mask_0,X
		BNE	loc_82235
		LDA	killed_objs_mem,Y
		ORA	killed_objs_mask_0,X
		STA	killed_objs_mem,Y
		LDY	objects_cnt
		LDA	$9700,X ; 
		STA	objects_X_h,Y
		LDA	$9680,X ; 
		STA	objects_X_l,Y
		LDA	$9600,X ; 
		STA	objects_type,Y
		LDA	$9780,X ; 
		STA	objects_Y_l,Y
		LDA	$9800,X ; 
		STA	objects_Y_h,Y
		LDA	$9880,X ; 
		STA	objects_var_cnt,Y ; var/counter
		LDA	#0	; init delay = 0
		STA	objects_delay,Y
		TXA
		STA	objects_sav_slot,Y
		INY
		STY	objects_cnt
		CPY	#OBJECTS_SLOTS
		BCS	locret_82242

loc_82235:
		INX
		BNE	loc_821C4

loc_82238:
		LDY	tmp_var_2B
		INY
		CPY	#8
		BCS	locret_82242
		JMP	loc_821B9
; ---------------------------------------------------------------------------

locret_82242:
		RTS
; ---------------------------------------------------------------------------

final_zone_obj_read:
		LDA	boss_func_num
		BNE	locret_8227B
		LDA	#1
		STA	boss_func_num

locret_8227B:
		RTS
; End of function read_lvl_objects
; ---------------------------------------------------------------------------

loc_82243:
;		LDA	level_id
;		CMP	#FINAL_ZONE
		BEQ	final_zone_obj_read
		;LDY	objects_cnt
		;BNE	locret_82272
		
		LDA	continues
		BMI	@already
		LDA	#$68		; object_chaos_emerald
		STA	objects_type
		LDY	emeralds_cnt
		LDA	emeralds_x_h_pos,Y
		STA	objects_X_h
		LDA	emeralds_x_l_pos,Y
		STA	objects_X_l
		LDA	emeralds_y_h_pos,Y
		STA	objects_Y_h
		LDA	emeralds_y_l_pos,Y
		STA	objects_Y_l
		;INC	objects_cnt
@already

		LDA	act_id
		CMP	#3
		BNE	@not_act4

		LDA	#$7C
		JSR	load_flipper
		LDA	#$7B
		JSR	load_flipper
@not_act4:

		LDX	#OBJECTS_SLOTS-1
@check_for_ending_point:
		LDA	objects_type,X
		AND	#$FE
		CMP	#$2E
		BEQ	locret_82272 ; already exist
		DEX
		BPL	@check_for_ending_point
		
		LDX	objects_cnt
		LDA	#$2E
		STA	objects_type,X
		LDY	act_id
		LDA	bns_signpost_x_h,Y
		STA	objects_X_h,X
		LDA	bns_signpost_x_l,Y
		STA	objects_X_l,X
		LDA	bns_signpost_y_h,Y
		STA	objects_Y_h,X
		LDA	bns_signpost_y_l,Y
		STA	objects_Y_l,X
		LDA	#0
		STA	objects_var_cnt,X	; var/counter
		;LDA	#1
		;STA	special_or_std_lvl
		INC	objects_cnt

locret_82272:
		RTS
; ---------------------------------------------------------------------------

emeralds_x_h_pos:
		.BYTE	$04,$00,$05,$01,$07,$01,$04,$01
emeralds_x_l_pos:
		.BYTE	$C5,$A7,$28,$68,$48,$08,$C0,$68
emeralds_y_h_pos:
		.BYTE	$00,$02,$01,$06,$01,$03,$03,$06
emeralds_y_l_pos:
		.BYTE	$2F,$14,$4F,$1F,$3F,$3F,$1F,$1F
	
; for 8 acts:
bns_signpost_x_h: .BYTE $06,$05,$08,$03,$09,$02,$06,$03
bns_signpost_x_l: .BYTE $70,$70,$70,$70,$70,$70,$70,$70
bns_signpost_y_h: .BYTE $01,$02,$01,$0C,$02,$05,$03,$0C
bns_signpost_y_l: .BYTE $80,$50,$90,$90,$A0,$70,$90,$90


; =============== S U B	R O U T	I N E =======================================


load_flipper:
		LDX	#OBJECTS_SLOTS-1
@search_flipper:
		CMP	objects_type,X
		BEQ	@ret
		DEX
		BPL	@search_flipper
		
		LDX	objects_cnt
		;LDA	#$7C	; flipper
		CMP	#$7C	; LEFT
		STA	objects_type,X
		LDA	#1
		STA	objects_X_h,X
		LDA	#0
		BCS	@c1
		LDA	#192	; RIGHT
@c1		
		STA	objects_X_l,X
		LDA	#11
		STA	objects_Y_h,X
		LDA	#64
		STA	objects_Y_l,X
		LDA	#0
		STA	objects_var_cnt,X	; var/counter
		INC	objects_cnt
@ret
		RTS


; =============== S U B	R O U T	I N E =======================================


pro_objects:
		LDA	lock_move_flag
		BEQ	pro_objects_
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_new
		STA	sonic_x_on_scr
		LDA	sonic_X_h_new
		SBC	camera_X_h_new
		STA	sonic_x_h_on_scr
		BNE	pro_objects_
		LDA	sonic_x_on_scr
		CMP	#$F0
		BCC	check_left
		LDA	camera_X_l_new
		SBC	#$10
		STA	sonic_X_l_new
		JMP	pro_objects_
;		BCS	pro_objects_
;sadasd		
;		BCC	sadasd
check_left:
		CMP	#$10
		BCS	pro_objects_
		LDA	camera_X_l_new
		ADC	#$10
		BCS	pro_objects_
		STA	sonic_X_l_new
		LDA	#0
		STA	sonic_X_speed

pro_objects_:
		LDX	#0

loc_8227E:
		STX	object_slot
		LDA	objects_type,X
		BEQ	loc_8228F
		JSR	pro_object
		LDX	object_slot
		INX
		CPX	objects_cnt
		BCC	loc_8227E

loc_8228F:				; in water flag
		LDA	water_timer
		BEQ	locret_822A0
		CMP	#WATER_TIMEOUT
		BCC	locret_822A0
		LDA	sonic_anim_num
		CMP	#9
		BEQ	locret_822A0
		JMP	drowning_death
; ---------------------------------------------------------------------------

locret_822A0:
		RTS
; End of function pro_objects


; =============== S U B	R O U T	I N E =======================================


pro_object:
		ASL	A
		TAY
		LDA	obj_code_ptrs,Y
		STA	tmp_ptr_l
		LDA	obj_code_ptrs+1,Y
		STA	tmp_ptr_l+1
		JMP	(tmp_ptr_l)
; End of function pro_object

; ---------------------------------------------------------------------------
obj_code_ptrs:	.WORD obj_no_code ; 0
		.WORD object_wasp ; 1
		.WORD object_wasp_shooting ; 2
		.WORD object_jumping_fish ; 3
		.WORD object_crabmeat	; 4
		.WORD object_crabmeat_shooting ; 5
		.WORD object_chameleon ; 6
		.WORD object_chameleon ; 7
		.WORD object_08 ; 8
		.WORD object_weapon_spawner ; 9
		.WORD object_fire_move_r ; A
		.WORD object_fire_move_d ; B
		.WORD object_fire_move_l ; C
		.WORD object_bat ; D
		.WORD object_0E ; E
		.WORD object_projectile ; F
		.WORD object_monitor ; $10
		.WORD object_monitor ; $11
		.WORD object_monitor ; $12
		.WORD object_monitor ; $13
		.WORD object_monitor ; $14
		.WORD object_monitor ; $15
		.WORD object_ring
		.WORD obj_no_code
		.WORD object_animal
		.WORD object_animal
		.WORD object_wasp_projectile ; wasp
		.WORD object_crabmeat_projectile ; 1b
		.WORD object_small_blue_spike ; 1c
		.WORD object_explode	; 1d
		.WORD object_lava_fire_splash ; 1e
		.WORD object_lava_fire_splash ; 1f
		.WORD object_spikes
		.WORD object_spikes2
		.WORD object_spikes
		.WORD object_spikes2
		.WORD object_spikes3
		.WORD object_spikes4
		.WORD object_spikes3
		.WORD object_spikes4
		.WORD object_caterpillar ; 28
		.WORD object_29
		.WORD object_fire_point
		.WORD object_2B
		.WORD obj_no_code
		.WORD obj_no_code
		.WORD object_ending_point ; 2E
		.WORD object_ending_point2 ; 2F
		.WORD object_spikes_badnik ; 30
		.WORD object_big_fast_rotating_spike ; 31
		.WORD object_big_rotating_spike ; 32
		.WORD object_small_spike ; 33
		.WORD object_big_spike_LR	; 34
		.WORD object_big_spike_UD	; 35
		.WORD obj_no_code ; 36
		.WORD obj_no_code ; 37
		.WORD object_big_plat_move_LR ; 38
		.WORD object_small_plat_move_LR ; 39
		.WORD object_big_plat_move_UD ; 3A
		.WORD object_platform_moved_UD ; 3B
		.WORD object_3C		; 3C
		.WORD object_3D		; 3d
		.WORD object_small_spike ; 3e
		.WORD object_3D
		.WORD object_labfish ; 40
		.WORD object_41
		.WORD object_42
		.WORD object_bubble_spawner ; 43
		.WORD object_bubble	; 44 BIG
		.WORD object_bubble_mini ; 45 MINI
		.WORD object_bubble	; 46 MEDIUM
		.WORD object_spike_shooter ; 47
		.WORD object_small_blue_spike ; 48
		.WORD object_harpoon_Left ; 49
		.WORD object_harpoon_Left_alt ; 4A
		.WORD object_harpoon_UP ; 4B
		.WORD object_harpoon_UP_alt ; 4C
		.WORD object_platform_move_up ; 4D
		.WORD object_lab_plat_move_LR ; 4E
		.WORD object_platform_moved_UD ; 4F
		.WORD object_uni_uni ; 50
		.WORD object_star_light_bomb ; 51
		.WORD object_star_light_bomb ; 52
		.WORD object_burrobot ; 53
		.WORD object_boss_spawn_point ; 54
		.WORD obj_no_code ; 55
		.WORD obj_no_code ; 56
		.WORD obj_no_code ; 57
		.WORD object_final_boss_weapon_init ; 58
		.WORD object_final_boss_weapon_init ; 59
		.WORD object_final_boss_weapon_init ; 5A
		.WORD object_final_boss_weapon_init ; 5B
		.WORD object_final_boss_weapon_create ; 5C
		.WORD object_final_boss_weapon ; 5D
		.WORD obj_no_code ; 5E
		.WORD obj_no_code ; 5F
		.WORD object_explosions ; 60
		.WORD object_eggman_fire ; 61
		.WORD object_62 ; 62
		.WORD object_63 ; 63
		.WORD object_fire_splash_on_boss2 ; 64
		.WORD object_65 ; 65
		.WORD object_65 ; 66
		.WORD object_nv_block_boss3 ; 67
		.WORD object_chaos_emerald ; $68
		.WORD object_flame	   ; $69
		.WORD object_fan	; $6A
		.WORD object_blocks_boss3 ; $6B
		.WORD object_ballhog ; $6C
		.WORD object_ballhog_ball ; $6D
		.WORD object_flame_up ; $6E
		.WORD object_sbz_platform ; $6F
		.WORD object_sbz_platform2 ; $70
		.WORD object_wall ; $71
		.WORD object_long_mesh_block ; $72
		.WORD object_circular_saw ; $73
		.WORD object_circular_saw2 ; $74
		.WORD object_circular_saw2 ; $75
		.WORD object_circular_saw2 ; $76
		.WORD object_circular_saw2 ; $77
		.WORD object_bubble_spawner_H ; $78
		.WORD object_bubble_H ; $79
		.WORD object_big_ring ; $7A
		.WORD object_flipper ; $7B
		.WORD object_flipper ; $7C
		.WORD object_pick_ring_anim ; $7D
		.WORD object_sbz_lift ; $7E
		.WORD object_checkpoint ; $7F
; ---------------------------------------------------------------------------

obj_no_code:
		RTS
; ---------------------------------------------------------------------------
objs_cam_flag:	.BYTE	 0		; 0
		.BYTE	 1		; 1
		.BYTE	 0		; 2
		.BYTE	 1		; 3
		.BYTE	 1		; 4 red crab
		.BYTE	 0		; 5
		.BYTE	 0		; 6
		.BYTE	 0		; 7
		.BYTE	 0		; 8
		.BYTE	 0		; 9
		.BYTE	 0		; 10
		.BYTE	 0		; 11
		.BYTE	 0		; 12
		.BYTE	 1		; 13
		.BYTE	 0		; 14
		.BYTE	 0		; 15
		.BYTE	 0		; 16
		.BYTE	 0		; 17
		.BYTE	 0		; 18
		.BYTE	 0		; 19
		.BYTE	 0		; 20
		.BYTE	 0		; 21
		.BYTE	 0		; 22
		.BYTE	 0		; 23
		.BYTE	 0		; 24
		.BYTE	 0		; 25
		.BYTE	 0		; 26
		.BYTE	 0		; 27
		.BYTE	 0		; 28
		.BYTE	 0		; 29
		.BYTE	 0		; 30
		.BYTE	 0		; 31
		.BYTE	 0		; 32
		.BYTE	 0		; 33
		.BYTE	 0		; 34
		.BYTE	 0		; 35
		.BYTE	 0		; 36
		.BYTE	 0		; 37
		.BYTE	 0		; 38
		.BYTE	 0		; 39
		.BYTE	 1		; 40 caterkiller
		.BYTE	 1		; 41
		.BYTE	 0		; 42
		.BYTE	 1		; 43
		.BYTE	 0		; 44
		.BYTE	 0		; 45
		.BYTE	 0		; 46
		.BYTE	 0		; 47
		.BYTE	 1		; 48
		.BYTE	 0		; 49
		.BYTE	 0		; 50
		.BYTE	 0		; 51
		.BYTE	 0		; 52
		.BYTE	 0		; 53
		.BYTE	 0		; 54
		.BYTE	 0		; 55
		.BYTE	 1		; 56
		.BYTE	 1		; 57
		.BYTE	 1		; 58
		.BYTE	 1		; 59
		.BYTE	 1		; 60
		.BYTE	 1		; 61
		.BYTE	 0		; 62
		.BYTE	 1		; 63
		.BYTE	 0		; 64
		.BYTE	 0		; 65
		.BYTE	 0		; 66
		.BYTE	 0		; 67
		.BYTE	 0		; 68
		.BYTE	 0		; 69
		.BYTE	 0		; 70
		.BYTE	 1		; 71
		.BYTE	 0		; 72
		.BYTE	 0		; 73
		.BYTE	 0		; 74
		.BYTE	 0		; 75
		.BYTE	 0		; 76
		.BYTE	 1		; 77
		.BYTE	 0		; 78
		.BYTE	 0		; 79
		.BYTE	 1		; 80
		.BYTE	 1		; $51 object_star_light_bomb
		.BYTE	 1		; $52 object_star_light_bomb
		.BYTE	 1		; $53 burrobot
		.BYTE	 0		; 84
		.BYTE	 0		; 85
		.BYTE	 0		; 86
		.BYTE	 0		; 87
		.BYTE	 0		; 88
		.BYTE	 0		; 89
		.BYTE	 0		; 90
		.BYTE	 0		; 91
		.BYTE	 0		; 92
		.BYTE	 0		; 93
		.BYTE	 0		; 94
		.BYTE	 0		; 95
		.BYTE	 0		; 96
		.BYTE	 0		; 97
		.BYTE	 0		; 98
		.BYTE	 0		; 99
		.BYTE	 0		; 100
		.BYTE	 0		; 101
		.BYTE	 0		; 102
		.BYTE	 0		; 103
		.BYTE	 0		; 104
		.BYTE	 0		; 105
		.BYTE	 0		; 106
		.BYTE	 0		; 107
		
		.BYTE	1 ; $6C
		.BYTE	0 ; $6D
		.BYTE	0 ; $6E
		.BYTE	0 ; $6F
		
		.BYTE	0 ; $70
		.BYTE	0 ; $71
		.BYTE	0 ; $72
		.BYTE	0 ; $73
		.BYTE	0 ; $74
		.BYTE	0 ; $75
		.BYTE	0 ; $76
		.BYTE	0 ; $77
		.BYTE	0 ; $78
		.BYTE	0 ; $79
		.BYTE	0 ; $7A
		.BYTE	0 ; $7B
		.BYTE	0 ; $7C
		.BYTE	0 ; $7D
		.BYTE	0 ; $7E
		.BYTE	0 ; $7F


; =============== S U B	R O U T	I N E =======================================


objects_sort:
		LDX	#0

loc_823EF:
		LDA	objects_type,X
		BEQ	loc_823FA
		INX
		CPX	objects_cnt
		BCC	loc_823EF
obj_slots_overflow:
		RTS
; ---------------------------------------------------------------------------

loc_823FA:
		CPX	#OBJECTS_SLOTS-1	; check limit fix
		BEQ	obj_slots_overflow
		TXA
		TAY
		INY

sort_objs_loop:
		LDA	objects_type,Y
		BEQ	loc_8244A
		LDA	objects_X_l,Y
		STA	objects_X_l,X
		LDA	objects_X_h,Y
		STA	objects_X_h,X
		LDA	objects_Y_l,Y
		STA	objects_Y_l,X
		LDA	objects_Y_h,Y
		STA	objects_Y_h,X
		LDA	objects_X_relative_l,Y
		STA	objects_X_relative_l,X
		LDA	objects_X_relative_h,Y
		STA	objects_X_relative_h,X
		LDA	objects_Y_relative_l,Y
		STA	objects_Y_relative_l,X
		LDA	objects_Y_relative_h,Y
		STA	objects_Y_relative_h,X
		LDA	objects_type,Y
		STA	objects_type,X
		LDA	objects_var_cnt,Y ; var/counter
		STA	objects_var_cnt,X ; var/counter
		LDA	objects_sav_slot,Y
		STA	objects_sav_slot,X
		LDA	objects_delay,Y
		STA	objects_delay,X
		LDA	#0
		STA	objects_type,Y
		INX

loc_8244A:
		INY
		CPY	objects_cnt
		BCC	sort_objs_loop
		STX	objects_cnt
		RTS
; End of function objects_sort


; =============== S U B	R O U T	I N E =======================================


drowning_death:
		LDY	#0
		STY	sonic_attribs	; clear sonic attr
		CMP	#$11	; drowining anim num
		BEQ	@already_drowned
		JSR	clear_all_objects
		LDA	sonic_state
		AND	#$80
		STA	sonic_state	; clear sonic state
		LDA	#$11	; drowining anim num
		JSR	sonic_set_death_drowning
		LDA	#0
		STA	sfx_to_play	; clear sfx
		LDA	#$34
		STA	music_to_play
		RTS
	
@already_drowned:
		LDA	#15	; drowning speed
		STA	sonic_Y_speed
		RTS


; =============== S U B	R O U T	I N E =======================================


capsule_work:
		LDA	capsule_pos_x_l
		SEC
		SBC	sonic_X_l_new
		STA	capsule_pos_x_l_rel
		LDA	capsule_pos_x_h
		SBC	sonic_X_h_new
		STA	capsule_pos_x_h_rel
		BEQ	loc_8246A
		CMP	#$FF
		BEQ	loc_8246A

locret_82469:
		RTS
; ---------------------------------------------------------------------------

loc_8246A:
		LDA	capsule_pos_y_l
		SEC
		SBC	sonic_Y_l_new
		STA	capsule_pos_y_l_rel
		LDA	capsule_pos_y_h
		SBC	sonic_Y_h_new
		STA	capsule_pos_y_h_rel
		BEQ	loc_82482
		CMP	#$FF
		BEQ	loc_82486
		RTS
; ---------------------------------------------------------------------------

loc_82482:
		LDA	#$F0
		BNE	loc_82488

loc_82486:
		LDA	#$10

loc_82488:
		STA	tmp_var_25
		LDA	capsule_pos_y_h
		CMP	sonic_Y_h_new
		BEQ	loc_824AE
		LDA	tmp_var_25
		CLC
		ADC	capsule_pos_y_l_rel
		STA	capsule_pos_y_l_rel
		LDA	tmp_var_25
		BMI	loc_824A6
		LDA	capsule_pos_y_h_rel
		ADC	#0
		JMP	loc_824AB
; ---------------------------------------------------------------------------

loc_824A6:
		LDA	capsule_pos_y_h_rel
		SBC	#0

loc_824AB:
		STA	capsule_pos_y_h_rel

loc_824AE:
		LDA	sonic_anim_num
		EOR	#9
		BEQ	@is_dead ; func = 0 if dead
		LDA	capsule_func_num
@is_dead
		JSR	jump_by_jmptable
; End of function capsule_work

; ---------------------------------------------------------------------------
caps_func_ptrs:	.WORD obj_no_code	; 0
		.WORD capsule_func1	; 1
		.WORD capsule_func2	; 2
		.WORD capsule_func3	; 3
		.WORD capsule_func4	; 4
		.WORD capsule_func5	; 5
		.WORD capsule_func6	; 6
		.WORD capsule_func7	; 7
		.WORD capsule_func8	; 8
		.WORD capsule_func9	; 9

; =============== S U B	R O U T	I N E =======================================


capsule_func1:
		LDX	level_id
		LDA	capsule_chr_bank,X
		STA	chr_bkg_bank3
		LDA	#$E6
		STA	chr_spr_bank2	; enemy	sprites	bank
		LDA	#1
		STA	lock_camera_flag
		LDA	sonic_X_l_new
		SEC
		SBC	camera_X_l_old
		STA	tmp_var_64
		LDA	sonic_X_h_new
		SBC	camera_X_h_old
		STA	tmp_var_63
		BNE	loc_8250C
		LDA	tmp_var_64
		SEC
		SBC	#$40
		STA	tmp_var_28
		BCS	loc_82508
		LDA	camera_X_l_old
		STA	camera_X_l_new

loc_82501:
		LDA	camera_X_h_old
		STA	camera_X_h_new
		JMP	loc_82519
; ---------------------------------------------------------------------------

loc_82508:
		CMP	#8
		BCC	loc_8250E

loc_8250C:
		LDA	#8

loc_8250E:
		CLC
		ADC	camera_X_l_old
		STA	camera_X_l_new
		LDA	camera_X_h_old
		ADC	#0
		STA	camera_X_h_new

loc_82519:
		LDA	camera_X_h_new
		CMP	capsule_pos_x_h
		BNE	locret_82526
		INC	capsule_func_num
		LDA	#1
		STA	lock_move_flag	; sonic	lock in	camera area

locret_82526:
		RTS
; End of function capsule_func1

; ---------------------------------------------------------------------------
capsule_chr_bank:.BYTE	$46, $1F, $27, $2F, $37, $46

; =============== S U B	R O U T	I N E =======================================


;capsule_func2:
;		LDA	#24
;		STA	hitbox_h
;		LDA	#48
;		STA	hitbox_v
;		JMP	check_capsule_collision
; End of function capsule_func2


; =============== S U B	R O U T	I N E =======================================


capsule_func3:
		LDA	#1		; set anim #1
		STA	sonic_anim_num
		LDA	#$60
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$BC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_X_h
		SEC
		SBC	capsule_pos_x_h
		CMP	#1
		BNE	loc_8255E
		LDA	#$E0
		STA	sonic_X_l_new
		LDA	capsule_pos_x_h
		STA	sonic_X_h_new
		LDA	#$FF
		STA	sonic_anim_num
		INC	capsule_func_num

loc_8255E:
capsule_func2:
		LDA	#24
		STA	hitbox_h
		LDA	#48
		STA	hitbox_v
		JMP	check_capsule_collision
; End of function capsule_func3


; =============== S U B	R O U T	I N E =======================================


capsule_func4:
		JSR	capsule_create_explosions
		INC	capsule_func_num
		LDA	#2		; wait time
		STA	level_finish_func_cnt
		RTS
; End of function capsule_func4


; =============== S U B	R O U T	I N E =======================================


capsule_func5:
		LDA	frame_cnt_for_1sec
		BNE	locret_8257E
		DEC	level_finish_func_cnt
		BNE	locret_8257E
		INC	capsule_func_num

locret_8257E:
		RTS
; End of function capsule_func5


; =============== S U B	R O U T	I N E =======================================


capsule_func6:
		INC	capsule_func_num
		LDA	capsule_pos_x_l
		SEC
		SBC	#$C
		STA	tmp_var_64
		LDA	capsule_pos_x_h
		SBC	#0
		STA	tmp_var_63
		LDA	capsule_pos_y_l
		CLC
		ADC	#$18
		STA	tmp_var_66
		LDA	capsule_pos_y_h
		ADC	#0
		STA	tmp_var_65
		LDA	tmp_var_66
		CMP	#$F0
		BCC	loc_825AC
		CLC
		ADC	#$10
		STA	tmp_var_66
		INC	tmp_var_65

loc_825AC:
		JMP	sub_8278E
; End of function capsule_func6


; =============== S U B	R O U T	I N E =======================================


capsule_func7:
;		LDX	objects_cnt
;		JMP	@check_for_big_ring
;@loop
;		CMP	objects_type,X
;		BNE	@nx
;		JSR	remove_temp_obj
;@check_for_big_ring:
;		LDA	#$7A
;@nx
;		DEX
;		BPL	@loop

		INC	capsule_func_num
		LDA	capsule_pos_x_l
		SEC
		SBC	#$C
		STA	tmp_var_64
		LDA	capsule_pos_x_h
		SBC	#0
		STA	tmp_var_63
		LDA	capsule_pos_y_l
		CLC
		ADC	#$38
		STA	tmp_var_66
		LDA	capsule_pos_y_h
		ADC	#0
		STA	tmp_var_65
		LDA	tmp_var_66
		CMP	#$F0
		BCC	loc_825DC
		CLC
		ADC	#$10
		STA	tmp_var_66
		INC	tmp_var_65

loc_825DC:
		LDA	#$22
		STA	music_to_play
		LDA	#$10
		STA	capsule_cnt
		JMP	loc_827AC
; End of function capsule_func7

; ---------------------------------------------------------------------------

capsule_func8:
		JMP	capsule_create_animals

; =============== S U B	R O U T	I N E =======================================


capsule_func9:
		LDA	#1
		STA	level_finish_func_num
		LDA	#0
		STA	capsule_func_num
		RTS
; End of function capsule_func9


; =============== S U B	R O U T	I N E =======================================


capsule_create_animals:
		LDA	Frame_Cnt
		AND	#$F
		BEQ	loc_825FB
		RTS
; ---------------------------------------------------------------------------

loc_825FB:
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS
		BCS	locret_82640
		JSR	capsule_animals_fix
		LDA	capsule_pos_x_l
		STA	objects_X_l,Y
		LDA	capsule_pos_x_h
		STA	objects_X_h,Y
		LDA	capsule_pos_y_l
		CLC
		ADC	#$40
		STA	objects_Y_l,Y
		LDA	capsule_pos_y_h
		ADC	#0
		STA	objects_Y_h,Y
		LDX	#$18
		LDA	capsule_cnt
		AND	#1
		BNE	loc_82629
		LDX	#$19

loc_82629:
		TXA
		STA	objects_type,Y
		LDX	capsule_cnt
		LDA	animals_bas_cnt_tbl,X
		STA	objects_var_cnt,Y ; var/counter
		INY
		STY	objects_cnt
		DEC	capsule_cnt
		BPL	locret_82640
		INC	capsule_func_num

locret_82640:
		RTS
; End of function capsule_create_animals

; ---------------------------------------------------------------------------
animals_bas_cnt_tbl:.BYTE  $8A,	$90,   0, $85,	 0,   3, $83, $94, $80,	  0,   8,   0, $9A,   5, $88,  $B


; =============== S U B	R O U T	I N E =======================================


capsule_animals_fix:
		TYA
		PHA	; save Y reg
	
		LDA	level_spr_chr2
		STA	chr_spr_bank2	; restore bank
	
		LDA	level_id	; restore palette
		ASL
		TAY
		LDA	palettes,Y
		CLC
		ADC	#$18
		STA	tmp_ptr_l
	
		LDA	palettes+1,Y
		ADC	#0
		STA	tmp_ptr_l+1
	
		LDY	#0
		LDX	#8
@copy_8_colors	
		LDA	(tmp_ptr_l),Y
		STA	palette_buff,Y
		INY
		DEX
		BNE	@copy_8_colors
	
		LDY	#OBJECTS_SLOTS-1
@clear_exps:
		LDA	objects_type,Y
		EOR	#$60	; explosion
		BNE	@not_exps
		STA	objects_type,Y
@not_exps:
		DEY
		BPL	@clear_exps
	
		LDA	#$3F	; setup buffer
		STA	vram_buffer_adr_h
		LDA	#$18
		STA	vram_buffer_adr_l
		LDA	#0
		STA	vram_buffer_ppu_mode
		LDA	#8
		STA	vram_buffer_h_length
		LDA	#1
		STA	vram_buffer_v_length

		PLA
		TAY	; load Y reg

		; hide explosion on animal creating (fix)
		hide_obj_sprite
		RTS


; =============== S U B	R O U T	I N E =======================================


check_capsule_collision:
		LDA	capsule_pos_y_h_rel
		BMI	loc_82657
		RTS
; ---------------------------------------------------------------------------

loc_82657:
		LDY	#0
		LDA	capsule_pos_y_l_rel
		CMP	#$FB
		BCS	loc_82667
		CMP	#$D0
		BCS	loc_82665
		RTS
; ---------------------------------------------------------------------------

loc_82665:
		LDY	#1

loc_82667:
		STY	obj_collision_flag
		LDA	capsule_pos_x_h_rel
		BMI	loc_82676
		LDA	capsule_pos_x_l_rel
		CMP	#8
		BCC	loc_82683
		RTS
; ---------------------------------------------------------------------------

loc_82676:
		LDA	capsule_pos_x_l_rel
		CLC
		ADC	hitbox_h
		BCS	loc_82683
		ADC	#8
		BCS	loc_82683
		RTS
; ---------------------------------------------------------------------------

loc_82683:
		LDA	obj_collision_flag
		BNE	loc_8268A
		JMP	capsule_collision
; ---------------------------------------------------------------------------

loc_8268A:
		JMP	sub_82696
; End of function check_capsule_collision

; ---------------------------------------------------------------------------
		;LDA	#5
		;STA	sfx_to_play
		;INC	capsule_func_num
		;JMP	capsule_collision

; =============== S U B	R O U T	I N E =======================================


sub_82696:
		LDA	capsule_pos_x_h_rel
		BMI	loc_826C2
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		CMP	#0
		BNE	loc_826B0
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	loc_826B0
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_826B0:
		LDA	capsule_pos_x_l
		SEC
		SBC	#7
		STA	sonic_X_l_new
		LDA	capsule_pos_x_h
		SBC	#0
		STA	sonic_X_h_new
		JMP	loc_826EA
; ---------------------------------------------------------------------------

loc_826C2:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$F
		CMP	#3
		BNE	loc_826D9
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_826D9
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_826D9:
		LDA	hitbox_h
		CLC
		ADC	#7
		ADC	capsule_pos_x_l
		STA	sonic_X_l_new
		LDA	capsule_pos_x_h
		ADC	#0
		STA	sonic_X_h_new

loc_826EA:
		LDA	capsule_pos_x_l
		SEC
		SBC	sonic_X_l_new
		STA	capsule_pos_x_l_rel
		LDA	capsule_pos_x_h
		SBC	sonic_X_h_new
		STA	capsule_pos_x_h_rel
		RTS
; End of function sub_82696


; =============== S U B	R O U T	I N E =======================================


sub_826FC:
		LDA	capsule_pos_x_h_rel
		BMI	loc_82713
		LDA	capsule_pos_x_l
		SEC
		SBC	#7
		STA	sonic_X_l_new
		LDA	capsule_pos_x_h
		SBC	#0
		STA	sonic_X_h_new
		JMP	loc_826EA
; ---------------------------------------------------------------------------

loc_82713:
		LDA	hitbox_h
		CLC
		ADC	#7
		ADC	capsule_pos_x_l
		STA	sonic_X_l_new
		LDA	capsule_pos_x_h
		ADC	#0
		STA	sonic_X_h_new
		JMP	loc_826EA
; End of function sub_826FC


; =============== S U B	R O U T	I N E =======================================


capsule_collision:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$C
		BEQ	loc_82730
		JMP	sub_826FC
; ---------------------------------------------------------------------------

loc_82730:
		LDA	capsule_pos_y_l
		STA	sonic_Y_l_new
		LDA	capsule_pos_y_h
		STA	sonic_Y_h_new
		LDA	#0
		STA	capsule_pos_y_h_rel
		STA	capsule_pos_y_l_rel
		STA	sonic_Y_speed
		LDA	sonic_X_speed
		SEC
		SBC	#2
		BPL	loc_8274D
		LDA	#0

loc_8274D:
		STA	sonic_X_speed
		LDA	capsule_func_num
		CMP	#3
		BCS	locret_8275B
		INC	capsule_func_num
		LDA	#0
		STA	lock_move_flag	; sonic	lock in	camera area

locret_8275B:
		RTS
; End of function capsule_collision


; =============== S U B	R O U T	I N E =======================================


capsule_create_explosions:
		LDY	objects_cnt
		LDA	capsule_pos_x_l
		SEC
		SBC	#$C
		STA	objects_X_l,Y
		LDA	capsule_pos_x_h
		SBC	#0
		STA	objects_X_h,Y
		LDA	capsule_pos_y_l
		CLC
		ADC	#$10
		STA	objects_Y_l,Y
		LDA	capsule_pos_y_h

explosion_create:
		ADC	#0
		STA	objects_Y_h,Y
		LDA	#$60
		STA	objects_type,Y
		hide_obj_sprite
		LDA	#0
		STA	objects_var_cnt,Y ; var/counter
		INY
		STY	objects_cnt
		;LDA	#0
		STA	invicible_timer
		JMP	disable_super_sonic
; End of function capsule_create_explosions


; =============== S U B	R O U T	I N E =======================================


sub_8278E:
		LDA	#6
		STA	vram_buffer_h_length
		LDA	#4
		STA	vram_buffer_v_length
		LDA	#0
		STA	vram_buffer_ppu_mode
		LDY	#0
		LDA	#$FF

loc_827A1:				; also various NT data
		STA	palette_buff,Y
		INY
		CPY	#$18
		BCC	loc_827A1
		JMP	loc_827CB
; ---------------------------------------------------------------------------

loc_827AC:
		LDA	#6
		STA	vram_buffer_h_length
		LDA	#2
		STA	vram_buffer_v_length
		LDA	#0
		STA	vram_buffer_ppu_mode
		LDY	#0
		LDX	#0

loc_827BF:
		LDA	capsule_dest_tls,X
		STA	palette_buff,Y	; also various NT data
		INY
		INX
		CPX	#$C
		BCC	loc_827BF

loc_827CB:
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
		BEQ	loc_827E3
		TXA
		SEC
		SBC	#$10
		TAX

loc_827E3:
		STX	tmp_var_2B
		LDA	hscroll_val
		CLC
		ADC	tmp_var_28
		AND	#$F0
		STA	tmp_var_28
		LDA	vscroll_val
		CLC
		ADC	tmp_var_2B
		BCS	loc_82803
		CMP	#$F0
		BCS	loc_82803
		AND	#$F0
		STA	tmp_var_2B
		LDA	ppu_tilemap_mask
		STA	tmp_var_25
		BPL	loc_82810

loc_82803:
		CLC
		ADC	#$10
		AND	#$F0
		STA	tmp_var_2B
		LDA	ppu_tilemap_mask
		EOR	#2
		STA	tmp_var_25

loc_82810:
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
		
		LDA	tmp_var_2B
		AND	#3
		ORA	#$20	; $20-$23
		
		LSR	tmp_var_63
		BCC	loc_82826
		ORA	#4
		
loc_82826:
		STA	vram_buffer_adr_h
		RTS
; End of function sub_8278E

; ---------------------------------------------------------------------------
;capsule_dest_tls:.BYTE	$AC, $AE, $B1, $B3, $FF, $B0
;		.BYTE  $9D, $9F, $A5, $A7, $AD,	$AF

capsule_dest_tls:
		.BYTE  $84, $85, $86, $87, $88, $89
		.BYTE  $94, $95, $96, $97, $98,	$99

; =============== S U B	R O U T	I N E =======================================


object_boss_spawn_point:
		JSR	obj_update_rel_pos_and_test
		BEQ	loc_82B3E
		JMP	object_remove
; ---------------------------------------------------------------------------

loc_82B3E:
		LDA	objects_X_relative_h,X
		BNE	locret_82B5C
		LDA	objects_X_relative_l,X
		CMP	#$90
		BCS	locret_82B5C
		LDA	objects_X_h,X
		TAY
		DEY
		DEY
		TYA
		STA	cam_x_h_limit_l
		LDA	#1
		STA	boss_func_num
		JMP	remove_temp_obj

locret_82B5C:
		RTS
; End of function object_boss_spawn_point


; =============== S U B	R O U T	I N E =======================================


object_fire_splash_on_boss2:
		LDA	objects_var_cnt,X
		CMP	#2
		BNE	@not_splash_start
		LDA	#$10	; sfx: fire shot
		STA	sfx_to_play
@not_splash_start:
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_82B74
		INC	objects_var_cnt,X ; var/counter
		LDA	boss_func_num
		BNE	loc_82B9D
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_82B74:
		LDY	#$FE
		LDA	objects_var_cnt,X ; var/counter
		AND	#$40
		BEQ	loc_82B7F
		LDY	#2

loc_82B7F:
		STY	tmp_var_25
		TYA
		CLC
		ADC	objects_Y_l,X
		STA	objects_Y_l,X
		LDA	tmp_var_25
		BMI	loc_82B95
		LDA	objects_Y_h,X
		ADC	#0
		JMP	loc_82B9A
; ---------------------------------------------------------------------------

loc_82B95:
		LDA	objects_Y_h,X
		SBC	#0

loc_82B9A:
		STA	objects_Y_h,X

loc_82B9D:				; var/counter
		INC	objects_var_cnt,X
		LDA	#8
		STA	hitbox_h
		LDA	#16
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_collision
; End of function object_fire_splash_on_boss2


; =============== S U B	R O U T	I N E =======================================


object_eggman_fire:
		LDA	#2
		JSR	object_add_Y
		LDA	objects_Y_l,X
		CMP	#$A0
		BCS	create_fires
		LDA	#8
		STA	hitbox_h
		LDA	#24
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; ---------------------------------------------------------------------------

create_fires:
		LDY	objects_cnt
		LDA	#$63
		STA	objects_type,X
		LDA	#$62
		STA	objects_type,Y
		LDA	#0
		STA	objects_var_cnt,X ; var/counter
		STA	objects_var_cnt,Y ; var/counter
		LDA	objects_X_h,X
		STA	objects_X_h,Y
		LDA	objects_Y_l,X
		STA	objects_Y_l,Y
		LDA	objects_Y_h,X
		STA	objects_Y_h,Y
		LDA	objects_X_l,X
		CMP	#$80
		BCS	loc_82C12
		LDA	#$20
		STA	objects_X_l,X
		LDA	#$18
		STA	objects_X_l,Y
		JMP	loc_82C1C
; ---------------------------------------------------------------------------

loc_82C12:
		LDA	#$E0
		LDA	objects_X_l,X
		LDA	#$D8
		STA	objects_X_l,Y

loc_82C1C:
		hide_obj_sprite
		INY
		STY	objects_cnt
		RTS
; End of function object_eggman_fire


; =============== S U B	R O U T	I N E =======================================


object_62:
		LDA	Frame_Cnt
		AND	#$F
		BNE	loc_82C4B
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		TAY
		CMP	#8
		BCC	loc_82C39
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_82C39:
		LDA	byte_82C68,Y
		JSR	object_sub_X

loc_82C4B:				; var/counter
		LDA	objects_var_cnt,X
		TAY
		LDA	byte_82C5F,Y
		STA	hitbox_h
		LDA	#16
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_62

; ---------------------------------------------------------------------------
byte_82C5F:	.BYTE	 8, $10, $18, $20, $18,	$10,   8,   8,	 0
byte_82C68:	.BYTE	 0,   8,   8,	8,   0,	  0,   0,   0,	 0

; =============== S U B	R O U T	I N E =======================================


object_63:
		LDA	Frame_Cnt
		AND	#$F
		BNE	loc_82C9C
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		TAY
		CMP	#8
		BCC	loc_82C8A
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

loc_82C8A:
		LDA	byte_82CB0,Y
		JSR	object_add_X

loc_82C9C:				; var/counter
		LDA	objects_var_cnt,X
		TAY
		LDA	byte_82C5F,Y
		STA	hitbox_h
		LDA	#16
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_63

; ---------------------------------------------------------------------------
byte_82CB0:	.BYTE	 0,   0,   0,	0,   8,	  8,   8,   0,	 0

; =============== S U B	R O U T	I N E =======================================


object_65:
		LDY	#1
		LDA	objects_type,X
		CMP	#$65
		BEQ	loc_82CC6
		LDY	#2
loc_82CC6
		JMP	loc_8043F


; =============== S U B	R O U T	I N E =======================================


object_nv_block_boss3:
		LDA	objects_var_cnt,X ; var/counter
		TAY
		LDA	boss_var_D1
		AND	bitfield,Y
		BEQ	@loc_82D7A
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

@loc_82D7A:
		JSR	obj_update_rel_pos_and_test
		BEQ	@loc_82DD6
		RTS
; ---------------------------------------------------------------------------

@loc_82DD6:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	@loc_82DDD
		RTS
; ---------------------------------------------------------------------------

@loc_82DDD:
		LDA	objects_Y_relative_h,X
		BMI	loc_82DE5
		RTS
; ---------------------------------------------------------------------------

loc_82DE5:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$FB
		BCS	loc_82DF5
		CMP	#$D0
		BCS	loc_82DF3
		RTS
; ---------------------------------------------------------------------------

loc_82DF3:
		LDY	#1

loc_82DF5:
		STY	obj_collision_flag
		LDA	objects_X_relative_h,X
		BMI	loc_82E04
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_82E11
		RTS
; ---------------------------------------------------------------------------

loc_82E04:
		LDA	objects_X_relative_l,X
		CLC
		ADC	#$20
		BCS	loc_82E11
		ADC	#8
		BCS	loc_82E11
		RTS
; ---------------------------------------------------------------------------

loc_82E11:
		LDA	obj_collision_flag
		BNE	loc_82E18
		JMP	loc_82EAC
; ---------------------------------------------------------------------------

loc_82E18:
		JMP	loc_82E1B

loc_82E1B:
		LDA	objects_X_relative_h,X
		BMI	loc_82E47
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		CMP	#0
		BNE	loc_82E35
		LDA	joy1_hold
		AND	#BUTTON_RIGHT
		BEQ	loc_82E35
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_82E35:
		LDA	objects_X_l,X
		SEC
		SBC	#7
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		SBC	#0
		STA	sonic_X_h_new
		JMP	loc_82E6F
; ---------------------------------------------------------------------------

loc_82E47:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$F
		CMP	#3
		BNE	loc_82E5E
		LDA	joy1_hold
		AND	#BUTTON_LEFT
		BEQ	loc_82E5E
		LDA	#$D
		STA	sonic_anim_num
		LDA	#0
		STA	sonic_X_speed

loc_82E5E:
		LDA	#$20
		CLC
		ADC	#7
		ADC	objects_X_l,X
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		ADC	#0
		STA	sonic_X_h_new

loc_82E6F:
		LDA	objects_X_l,X
		SEC
		SBC	sonic_X_l_new
		STA	objects_X_relative_l,X
		LDA	objects_X_h,X
		SBC	sonic_X_h_new
		STA	objects_X_relative_h,X
		RTS
; ---------------------------------------------------------------------------

loc_82E81:
		LDA	objects_X_relative_h,X
		BMI	loc_82E98
		LDA	objects_X_l,X
		SEC
		SBC	#7
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		SBC	#0
		STA	sonic_X_h_new
		JMP	loc_82E6F
; ---------------------------------------------------------------------------

loc_82E98:
		LDA	#$20
		CLC
		ADC	#7
		ADC	objects_X_l,X
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		ADC	#0
		STA	sonic_X_h_new
		JMP	loc_82E6F
; ---------------------------------------------------------------------------

loc_82EAC:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$C
		BEQ	loc_82EB5
		JMP	loc_82E81
; ---------------------------------------------------------------------------

loc_82EB5:
		LDA	objects_Y_l,X
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		STA	sonic_Y_h_new
		LDA	#0
		STA	objects_Y_relative_h,X
		STA	objects_Y_relative_l,X
		STA	sonic_Y_speed
		RTS
; End of function object_nv_block_boss3


; =============== S U B	R O U T	I N E =======================================


object_final_boss_weapon_create:		
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		CMP	#$30
		BCC	@wait
		JSR	create_4_electricity

@wait:
		JMP	loc_82F46
; ---------------------------------------------------------------------------

object_final_boss_weapon_init:
		LDA	objects_type,X
		AND	#3
		TAY
		INC	objects_var_cnt,X ; var/counter
		LDA	objects_var_cnt,X ; var/counter
		CMP	byte_82FC1,Y
		BCS	loc_82F06
		LDA	#4
		JSR	object_sub_X

loc_82F06:				; var/counter
		LDA	objects_var_cnt,X
		CMP	#$40
		BCC	@no_play_electro
		JSR	play_electro_sfx
@no_play_electro
		CMP	#$50
		BCC	loc_82F12
		LDA	#$5D
		STA	objects_type,X
		
	; initial AIM
		
		LDA	objects_X_relative_l,X
		LDY	objects_X_relative_h,X
		BMI	@minus
		LSR	A
		ORA	#$80
		JMP	@c2
@minus
		EOR	#$FF
		CLC
		ADC	#1
		LSR	A
@c2
		STA	objects_var_cnt,X

loc_82F12:
		JMP	loc_82F46
; ---------------------------------------------------------------------------

object_final_boss_weapon:
		JSR	play_electro_sfx
		
		;LDA	Frame_Cnt
		;AND	#1
		;BEQ	loc_82F46

		LDA	Frame_Cnt
		AND	#1
		CLC
		ADC	#1 ; 1,5X speed
		CLC
		ADC	objects_Y_l,X
		STA	objects_Y_l,X
		CMP	#$F0
		BCC	@aim
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

@aim:
		LDA	#0
		STA	tmp_var_26
		
		LDA	objects_var_cnt,X
		BPL	@move_right
		
		JSR	electroball_calc_speed
		SEC
		LDA	objects_delay,X
		SBC	tmp_var_25
		STA	objects_delay,X
		LDA	objects_X_l,X
		SBC	tmp_var_26
		STA	objects_X_l,X
		LDA	objects_X_h,X
		SBC	#0
		;STA	objects_X_h,X
		JMP	@done
		
@move_right:
		JSR	electroball_calc_speed
		CLC
		LDA	objects_delay,X
		ADC	tmp_var_25
		STA	objects_delay,X
		LDA	objects_X_l,X
		ADC	tmp_var_26
		STA	objects_X_l,X
		LDA	objects_X_h,X
		ADC	#0
@done:
		STA	objects_X_h,X

loc_82F46:
		LDA	#14
		STA	hitbox_h
		;LDA	#14
		STA	hitbox_v
		LDA	#2
		STA	obj_collision_flag
		JMP	update_rel_pos_and_check_coll_temp
; End of function object_final_boss_weapon
; ---------------------------------------------------------------------------

electroball_calc_speed:
		AND	#$7F
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		LSR	A
		ROR	tmp_var_25
		;LSR	A
		;ROR	tmp_var_25 ; 8
		STA	tmp_var_26
		RTS


; =============== S U B	R O U T	I N E =======================================

play_electro_sfx:
		LDY	noise_sfx_ptr
		BNE	@elec_sfx_played
		LDY	#$14	; sfx electricity
		STY	sfx_to_play
@elec_sfx_played
		RTS


; =============== S U B	R O U T	I N E =======================================


create_4_electricity:
		LDY	objects_cnt
		LDA	#3
		STA	tmp_var_25
@create_loop
		LDA	#0
		STA	objects_var_cnt,Y
		STA	objects_delay,Y
		LDA	#$58
		CLC
		ADC	tmp_var_25
		STA	objects_type,Y
		hide_obj_sprite
		JSR	obj_copy_pos
		DEC	tmp_var_25
		BPL	@create_loop
		JMP	remove_temp_obj
; End of function create_4_electricity

; ---------------------------------------------------------------------------
byte_82FC1:	.BYTE	 4-4, $14, $24+2, $34+4

; =============== S U B	R O U T	I N E =======================================

; block	number in Y, solid flag	in A (BEQ/BNE)

check_for_solid_block:
		LDY	objects_Y_h,X
		LDA	cam_y_mults,Y
		CLC
		ADC	objects_X_h,X
		JSR	LOAD_BLOCKS_ROOM
		LDY	objects_X_l,X
		LDA	objects_Y_l,X
		JMP	READ_SOLID_BLOCK_FLAG
; End of function check_for_solid_block


; =============== S U B	R O U T	I N E =======================================


check_for_solid_block_tmp:
		LDY	tmp_result_y_h
		LDA	cam_y_mults,Y
		CLC
		ADC	tmp_result_x_h
		JSR	LOAD_BLOCKS_ROOM
		LDY	tmp_result_x_l
		LDA	tmp_result_y_l
		
READ_SOLID_BLOCK_FLAG:
		AND	#$F0
		STA	tmp_var_2B
		TYA
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		ORA	tmp_var_2B
		TAY
		LDA	(tmp_ptr_l),Y
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
		TAY
		
		IF	(VRC7=0)
		LDA	#$86
		STA	MMC3_bank_select
		LDA	#$14
		STA	MMC3_bank_data
		ELSE
		LDA	#$14
		STA	VRC7_prg_8000
		ENDIF
		
		LDA	solid_blk_tbl,Y
		RTS
; End of function check_for_solid_block_tmp


; =============== S U B	R O U T	I N E =======================================


bubble_collision_check:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	loc_830A2
		RTS
; ---------------------------------------------------------------------------

loc_830A2:
		LDA	objects_X_relative_h,X
		BMI	loc_830AF
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	loc_830BC
		RTS
; ---------------------------------------------------------------------------

loc_830AF:
		LDA	objects_X_relative_l,X
		CLC
		ADC	#$10
		BCS	loc_830BC
		ADC	#8
		BCS	loc_830BC
		RTS
; ---------------------------------------------------------------------------

loc_830BC:
		LDA	objects_Y_relative_h,X
		BMI	loc_830C9
		LDA	objects_Y_relative_l,X
		CMP	#0
		BCC	pick_bubble
		RTS
; ---------------------------------------------------------------------------

loc_830C9:
		LDA	objects_Y_relative_l,X
		CLC
		ADC	#$10
		BCS	pick_bubble
		ADC	#$18
		BCS	pick_bubble
		RTS
; ---------------------------------------------------------------------------

pick_bubble:
		LDA	#0
		STA	sonic_X_speed
		STA	sonic_Y_speed
		LDA	#7
		STA	sfx_to_play
		LDA	#$2C
		STA	sonic_anim_num
		LDA	#$2D
		STA	sonic_air_bubble_timer
		LDA	#1
		STA	water_timer	; in water flag
		LDA	current_music
		CMP	#$21	; inviciblity music
		BEQ	@skip_set_music
		CMP	#$37	; super sonic music (s2)
		BEQ	@skip_set_music
		CMP	#$38	; super sonic music (s3k)
		BEQ	@skip_set_music
		CMP	#$3B	; super sonic music (s2)
		BEQ	@skip_set_music
		CMP	#$3C	; super sonic music (s3k)
		BEQ	@skip_set_music
		CMP	#$2C	; extra life music
		BEQ	@skip_set_music
		CMP	#$2A	; timeout music
		BNE	@not_timeout
		LDA	sonic_state ; SuperS?
		BPL	@not_timeout
		JSR	set_supers_music
		JMP	@check_for_boss
		
@not_timeout:
		LDY	level_id
		LDA	music_by_level,Y
@check_for_boss:
		LDY	boss_func_num
		BEQ	@loc_830F9
		LDA	#$29	; boss song

@loc_830F9:
		STA	music_to_play
@skip_set_music:
		JMP	remove_temp_obj
; End of function bubble_collision_check


; =============== S U B	R O U T	I N E =======================================


add_life_by_monitor:
		LDA	player_lifes
		CMP	#99
		BCS	locret_8310B
		INC	player_lifes
		LDA	#$2C	; 1up music
		STA	music_to_play
		LDA	#0	; clear current sfx to play
		STA	sfx_to_play

locret_8310B:
		RTS
; End of function add_life_by_monitor


; =============== S U B	R O U T	I N E =======================================


sonic_get_hit_from_obj:
		LDA	sonic_anim_num_old
		CMP	#9
		BNE	loc_80926
		RTS
; ---------------------------------------------------------------------------

loc_80926:
		LDA	sonic_blink_timer
		ORA	invicible_timer
		BEQ	loc_8092B
		RTS
; ---------------------------------------------------------------------------

loc_8092B:
		LDA	sonic_state	; 0x2- shield; 0x4 - rolling
		BPL	@not_super_sonic
		RTS
; ---------------------------------------------------------------------------

@not_super_sonic:
		LDA	#3	; blink timer and flag obj/bkg
		JMP	sonic_get_dmg ; to main.asm


; =============== S U B	R O U T	I N E =======================================

; ID #$68
object_chaos_emerald:
		JSR	obj_update_rel_pos_and_test
		BEQ	@emerald_on_screen
		RTS
@emerald_on_screen:
		LDA	#16
		STA	hitbox_h
		STA	hitbox_v
		LDA	#5	; type = collision with emerald
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox


; =============== S U B	R O U T	I N E =======================================


; ID #$6E
object_flame_up:
		LDA	objects_var_cnt,X
		BEQ	@sub_y
		CMP	#16
		BEQ	@sub_y
		CMP	#32
		BEQ	@sub_y
		CMP	#96
		BEQ	@add_y
		CMP	#112
		BEQ	@add_y
		CMP	#128
		BNE	@no_fix_pos
@add_y:
		LDA	#3
		JSR	object_add_Y
		JMP	@no_fix_pos
@sub_y:
		LDA	#3
		JSR	object_sub_Y

@no_fix_pos:
		LDA	objects_var_cnt,X
		AND	#3
		BEQ	@restore_Y_pos
		LDA	#2
		JSR	object_sub_Y
		JMP	flame_check_pos
@restore_Y_pos:
		LDA	#6
		JSR	object_add_Y
		JMP	flame_check_pos
; ---------------------------------------------------------------------------
; ID #$69
object_flame:
		LDA	objects_var_cnt,X
		AND	#3
		BEQ	@restore_Y_pos
		LDA	#2
		JSR	object_add_Y
		JMP	flame_check_pos
@restore_Y_pos:
		LDA	#6
		JSR	object_sub_Y

flame_check_pos:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		INC	objects_var_cnt,X
		LDA	objects_var_cnt,X
		CMP	#144
		BCC	@flame_on
		RTS
@flame_on
		LDA	objects_var_cnt,X
;		BNE	@no_sfx
;		LDY	#$1A	; SFX
;		STY	sfx_to_play  ; moved to draw_objs_code.asm
;@no_sfx
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	flame_hitbox_table,Y
		STA	hitbox_v
		LDA	#8
		STA	hitbox_h
		LDA	#2	; type = unkillable enemy
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox
		
flame_hitbox_table:
		.BYTE	24
		.BYTE	27
		.BYTE	30
		.BYTE	33
		.BYTE	33
		.BYTE	33
		.BYTE	30
		.BYTE	27
		.BYTE	24


; =============== S U B	R O U T	I N E =======================================


; ID #$6C
object_ballhog:
		LDA	objects_delay,X
		BEQ	@no_delay
		DEC	objects_delay,X
		JMP	@nx
@no_delay		
		LDY	objects_var_cnt,X
		INY
		CPY	#14
		BCC	@no_reset_anim
		LDY	#0
@no_reset_anim:
		TYA
		STA	objects_var_cnt,X
		LDA	ballhog_anim_delay,Y
		STA	objects_delay,X
		LDA	ballhog_y_pos,Y
		BMI	@sub_Y
		JSR	object_add_Y
		LDY	objects_var_cnt,X
		LDA	ballhog_frame_types,Y
		CMP	#1 ; attack?
		BNE	@nx
		JSR	ballhog_attack
		JMP	@nx
@sub_Y
		EOR	#$FF
		CLC
		ADC	#1
		JSR	object_sub_Y

@nx:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDY	objects_var_cnt,X
		LDA	ballhog_frame_types,Y
		TAY
		LDA	ballhog_hitbox_table,Y
		STA	hitbox_v
		LDA	#16
		STA	hitbox_h
		JMP	check_collision_both_hitbox_type0
		
ballhog_hitbox_table:
		.BYTE	32 ; idle
		.BYTE	32 ; attacking
		.BYTE	24 ; sit
		.BYTE	32 ; jump
		
; 0 = idle, 1 = attack, 2 = sit, 3 = jump
ballhog_frame_types:
		.BYTE	0,2,3,2
		.BYTE	0,1
		.BYTE	0,2,3,2
		.BYTE	0,2,3,2	
		
ballhog_anim_delay:
;20 idle, 20 sit, 10 jump, 10 sit.
;20 idle, 10 attack
;20 idle, 20 sit, 10 jump, 10 sit.
;20 idle, 20 sit, 10 jump, 10 sit, 
		.BYTE	20,20,10,10
		.BYTE	20,10
		.BYTE	20,20,10,10
		.BYTE	20,20,10,10
		
ballhog_y_pos:
		.BYTE	-4,04,-16,16
		.BYTE	-4,00
		.BYTE	00,04,-16,16
		.BYTE	-4,04,-16,16
		
; ---------------------------------------------------------------------------


ballhog_attack:
		LDY	objects_cnt
		CPY	#OBJECTS_SLOTS-1	; check obj limit
		BCS	@obj_limit
		
		LDA	objects_X_l,X
		LSR	A
		LDA	#0
		ROR	A	; write attack direction/ init counter
		STA	objects_var_cnt,Y ; var/counter
		
		LDA	objects_X_l,X
		CLC
		ADC	#4
		STA	objects_X_l,Y
		LDA	objects_X_h,X
		ADC	#0
		STA	objects_X_h,Y
		
		LDA	objects_Y_l,X
		CLC
		ADC	#16
		CMP	#$F0
		BCC	@ok
		ADC	#15
@ok
		STA	objects_Y_l,Y
		
		LDA	objects_Y_h,X
		ADC	#0
		STA	objects_Y_h,Y
		LDA	#$6D ; object_ballhog_ball
		STA	objects_type,Y
		hide_obj_sprite
		INY
		STY	objects_cnt
@obj_limit
		RTS


; =============== S U B	R O U T	I N E =======================================


; ID #$6D
object_ballhog_ball:
;		LDA	Frame_Cnt
;		AND	#1
;		BEQ	@skip
;		INC	objects_delay,X
;		BEQ	@del_ballhog
;@skip
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
@del_ballhog:
		JMP	remove_temp_obj
; ---------------------------------------------------------------------------

@on_screen:
		INC	objects_var_cnt,X
		
		LDA	objects_var_cnt,X
		PHP	; save high bit
		AND	#$7F
		STA	tmp_var_25
		TAY
		LDA	objects_var_cnt,X
		BMI	@move_right
		JSR	object_dec_X
		JMP	@cmp_y
@move_right
		JSR	object_inc_X
@cmp_y
		CPY	#12
		BCS	@move_down
		LDA	ball_move_tbl_Y,Y
		JSR	object_sub_Y
		JMP	@nx
		
@move_down
		LDA	#6+6
		JSR	object_add_Y
		JSR	check_for_solid_block
		PHP
		LDA	#6+6
		JSR	object_sub_Y
		PLP
		BNE	@bounce
		LDY	tmp_var_25
		LDA	ball_move_tbl2_Y-12,Y
		JSR	object_add_Y
		LDY	tmp_var_25
		CPY	#23
		BCC	@nx
		DEC	tmp_var_25
		BCS	@nx
@bounce:
		LDA	#2
		STA	tmp_var_25
@nx
		LDA	tmp_var_25
		PLP	; restore high bit
		BPL	@not_right
		ORA	#$80
@not_right:
		STA	objects_var_cnt,X

		LDA	#12	; 12x12 (round)
		STA	hitbox_v
		;LDA	#8
		STA	hitbox_h
		LDA	#2	; type = unkillable enemy
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox

ball_move_tbl_Y:
		.BYTE	0,0,0,0,2,2,2,1,1,1,1,1

ball_move_tbl2_Y:
		.BYTE	0,1,1,1,1,1,2,2,2,2,2,2


; =============== S U B	R O U T	I N E =======================================


; ID #$6A
object_fan:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------
@on_screen:

		LDA	level_id
		CMP	#LAB_ZONE
		BNE	@not_labyrinth
		JSR	object_bubble_spawner_H_
		
@not_labyrinth:

		LDY	#0
		LDA	objects_Y_relative_h,X
		BMI	@fan_cmp_Y_down
		LDA	objects_Y_relative_l,X
		CMP	#$60
		BCS	@fan_locret
		TAY
		BCC	@fan_cmp_X ; JMP
; ---------------------------------------------------------------------------

@fan_cmp_Y_down:
		LDA	objects_Y_relative_l,X
		CMP	#$F0
		BCC	@fan_locret

@fan_cmp_X:
		LDA	objects_var_cnt,X
		BPL	fan_cmp_right
		LDA	objects_X_relative_h,X
		BMI	@fan_locret
		;LDA	objects_X_relative_l,X
		;SEC
		;SBC	#96
		;BCS	@fan_locret
		LDA	#96-16
		SEC
		SBC	objects_X_relative_l,X
		BCC	@fan_locret
		JSR	fan_calc_speed
		SEC
		SBC	tmp_var_25
		STA	sonic_X_l_new
		BCS	@no_dec_h
		DEC	sonic_X_h_new
@no_dec_h
@fan_locret:
		RTS
; ---------------------------------------------------------------------------		

fan_cmp_right:
		LDA	objects_X_relative_h,X
		BPL	@fan_locret2
		LDA	objects_X_relative_l,X
		CLC
		ADC	#96
		BCC	@fan_locret2

@fan_effect:
		LDA	objects_X_relative_l,X
		SEC
		SBC	#$98
		JSR	fan_calc_speed
		CLC
		ADC	tmp_var_25
		STA	sonic_X_l_new
		BCC	@no_inc_h
		INC	sonic_X_h_new
@no_inc_h
@fan_locret2:
		RTS
; ---------------------------------------------------------------------------

fan_calc_speed:
		CMP	#$31
		BCC	@no_limit
		LDA	#$30
@no_limit:
		LSR	A
		LSR	A
		LSR	A
		CPY	#$10
		BCC	@ok
		LSR	A
@ok
		CPY	#$40
		BCC	@ok2
		LSR	A
@ok2
		STA	tmp_var_25
		LDA	sonic_X_l_new
		RTS


; =============== S U B	R O U T	I N E =======================================


object_blocks_boss3:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------
@on_screen:
		LDA	#3
		JMP	object_add_Y


; =============== S U B	R O U T	I N E =======================================

; $6F
object_sbz_platform:
		LDA	objects_var_cnt,X
		CMP	#80
		BCC	@normal
		CMP	#80+22+80
		BCS	@normal	
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		BEQ	@normal
		LDA	#0
		BEQ	@small_box
@normal
		LDA	#32
@small_box:
		LDY	#16
		JSR	platforms_sub
		LDA	Frame_Cnt
		AND	#1
		BNE	@no_inc
		INC	objects_var_cnt,X
		LDA	objects_var_cnt,X
		EOR	#80+22+80+22
		BNE	@no_inc
		STA	objects_var_cnt,X
		
@no_inc
		LDY	#0
		LDA	objects_var_cnt,X
		CMP	#80
		BCC	@nx_mov_dir
		INY
		CMP	#80+22
		BCC	@nx_mov_dir
		INY
		CMP	#80+22+80
		BCC	@nx_mov_dir
		INY
@nx_mov_dir
		
		LDA	sbz_platform_mov_tbl_X,Y
		BMI	@dec_X
		STA	tmp_x_positions+1 ; inc	to sonic speed
		JSR	object_add_X
		LDA	#0
		BEQ	@write_x_dir
@dec_X:
		EOR	#$FF
		CLC
		ADC	#1
		STA	tmp_x_positions+1 ; inc	to sonic speed
		JSR	object_sub_X
		LDA	#1
@write_x_dir:
		STA	tmp_x_positions

		LDA	Frame_Cnt
		LSR	A
		LDA	sbz_platform_mov_tbl_Y,Y
		BCC	@evenf
		LDA	sbz_platform_mov_tbl_Y_alt,Y
@evenf
		BMI	@dec_Y
		STA	tmp_y_positions+1 ; inc	to sonic speed
		JSR	object_add_Y
		LDA	#1
		BNE	@write_y_dir
@dec_Y:
		EOR	#$FF
		CLC
		ADC	#1
		STA	tmp_y_positions+1 ; inc	to sonic speed
		JSR	object_sub_Y
		LDA	#0
@write_y_dir:
		STA	tmp_y_positions

sbz_platform_update_sonic_X_Y:
		LDA	hitbox_h
		BEQ	@no_move_s
		JSR	platforms_update_sonic_X_Y
@no_move_s
		LDA	objects_Y_relative_l,X
		SEC
		SBC	#9
		STA	objects_Y_relative_l,X
		BCS	@ret
		DEC	objects_Y_relative_h,X
@ret
		RTS
		
; ---------------------------------------------------------------------------
		
sbz_platform_mov_tbl_X:
		.BYTE	1 ; right by x
		.BYTE	0 
		.BYTE	$FF ; left by x
		.BYTE	0
		
sbz_platform_mov_tbl_Y:
		.BYTE	$FF ; up/right
		.BYTE	$02 ; down
		.BYTE	$01 ; down/left
		.BYTE	$FE ; up
		
sbz_platform_mov_tbl_Y_alt:
		.BYTE	$00 ; up/right
		.BYTE	$02 ; down
		.BYTE	$00 ; down/left
		.BYTE	$FE ; up
		
		
; =============== S U B	R O U T	I N E =======================================

; $70
object_sbz_platform2:
		;LDA	objects_var_cnt,X
		;CLC
		;ADC	#1
		;AND	#$3F
		;STA	objects_var_cnt,X
		
		LDA	Frame_Cnt
		AND	#$3F
		CMP	#$20
		BCC	@normal
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		BEQ	@normal
		LDA	#0
		BEQ	@small_box
@normal
		LDA	#32
@small_box:
		LDY	#16
		JSR	platforms_sub
		JMP	sbz_platform_update_sonic_X_Y


; =============== S U B	R O U T	I N E =======================================


object_long_mesh_block:
		LDA	#12*8
		LDY	#24
		JSR	platforms_sub
		
		LDA	Frame_Cnt
		AND	#1
		BNE	@nx
		
		LDA	objects_var_cnt,X
		CLC
		ADC	#1
		CMP	#96+16
		BCC	@no_reset_cnt
		LDA	#0
@no_reset_cnt:
		STA	objects_var_cnt,X
		
		CMP	#16+8
		BCC	@move_down
		CMP	#48+8
		BCC	@move_left
		CMP	#64+16
		BCC	@move_up
		JSR	object_inc_X
		INC	tmp_x_positions+1
		JMP	@nx

@move_down:
		JSR	object_inc_Y
		INC	tmp_y_positions+1
		JMP	@nx

@move_left:
		JSR	object_dec_X
		INC	tmp_x_positions+1
		INC	tmp_x_positions
		JMP	@nx

@move_up:
		JSR	object_dec_Y
		INC	tmp_y_positions+1
		INC	tmp_y_positions

@nx:	
;		JSR	obj_update_rel_pos_and_test
;		BEQ	@ok
;		JMP	object_remove
;@ok	
		LDA	#12*8
		STA	hitbox_h
		LDA	#32
		STA	hitbox_v
		LDA	tmp_y_positions
		BNE	@skip
		JSR	obj_get_relative_pos
@skip
		;JSR	platforms_update_sonic_X_Y
		
collision_vs_mesh_block:
		LDA	sonic_act_spr
		CMP	#9	; dead
		BEQ	@ret_platform

		LDA	objects_Y_relative_h,X
		BEQ	@upper
		CMP	#$FF
		BEQ	@lower
		BNE	@ret_platform
@upper:
		LDA	objects_Y_relative_l,X
		BNE	@chk_up
		LDA	objects_X_relative_h,X
		BEQ	@left_
		CMP	#$FF
		BNE	@chk_up
		LDY	objects_X_relative_l,X
		CPY	#$E0 ; first 32 pixels
		BCC	@chk_up
@chk_l:
		LDA	objects_var_cnt,X
		CMP	#64+16 ; time when moving up
		BCS	@chk_up
		CMP	#48+8 ; time when moving up
		BCC	@chk_up
		;CPY	#$E8
		;BCC	@ret_platform
		JMP	sonic_set_death ; kill_sonic
; ---------------------------------------------------------------------------
@left_:		LDY	objects_X_relative_l,X
		CPY	#8
		BCC	@chk_l
; ---------------------------------------------------------------------------
@chk_up:	JMP	platforms_update_sonic_X_Y
; ---------------------------------------------------------------------------

@lower:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$F9
		BCS	@ret_platform
		LDA	objects_X_relative_h,X
		BMI	@loc_80AAE
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	@loc_80ABB
		BCS	@ret_platform
; ---------------------------------------------------------------------------

@loc_80AAE:
		LDY	#1
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	@loc_80ABB
		ADC	#8
		BCC	@ret_platform

@loc_80ABB:
;		LDA	sonic_act_spr
;		CMP	#9	; dead
;		BEQ	@ret_platform
		LDA	objects_Y_relative_l,X
		CPY	#1
		BEQ	@collision_bottom2
		CMP	#$D0
		BEQ	@ret_platform
		BCC	@collision_bottom
		LDA	#24
		JSR	sonic_side_collision
@ret_platform:
		JMP	check_platforms_delete
; ---------------------------------------------------------------------------

@collision_bottom2
		CMP	#$D8
		BCS	@ret_platform
@collision_bottom:
		SBC	#$C9
		BCC	@ret_platform
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	@ret_platform
;		STA	tmp_var_25
		LDA	#47
;		SBC	tmp_var_25
		ADC	objects_Y_l,X
		BCC	@no_inc_
		ADC	#$F
		SEC
@no_inc_
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		ADC	#0
		STA	sonic_Y_h_new
		
		LDA	sonic_Y_l_new
		CMP	#$F0
		BCC	@ok
		ADC	#$F
		STA	sonic_Y_l_new
		INC	sonic_Y_h_new
		
@ok		
		LDA	#0
		STA	sonic_Y_speed
		BEQ	@ret_platform


; =============== S U B	R O U T	I N E =======================================

; $73
object_circular_saw:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
;		LDX	objects_cnt
;@loop:
;		LDA	objects_type,X
;		CMP	#$6F
;		BEQ	@sbz_platform
;		CMP	#$70
;		BEQ	@sbz_platform
;		CMP	#$52
;		BNE	@not_bomb
;@sbz_platform
;		LDY	objects_X_relative_h,X
;		BNE	@not_bomb
;		LDY	objects_X_relative_l,X
;		CPY	#$90
;		BCS	@not_bomb
;		LDY	objects_Y_relative_h,X
;		BNE	@not_bomb
;		JMP	object_remove
;@not_bomb
;		DEX
;		BPL	@loop
;		LDX	object_slot

		LDA	objects_var_cnt,X
		AND	#$7F
		BNE	@move_r
		INC	objects_var_cnt,X
		;RTS
		DEC	objects_X_h,X
		LDA	#$F0
		JMP	object_sub_X
		
@move_r:
		;RTS
		CMP	#$7F
		BCS	@ok
		INC	objects_var_cnt,X
@ok:
		LDA	#6
		JSR	object_add_X
		LDA	#64
		STA	hitbox_h
		LDA	#32
		STA	hitbox_v
		
		LDA	#2
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox


; =============== S U B	R O U T	I N E =======================================

; $74,$75,$76
object_circular_saw2:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDA	Frame_Cnt
		LSR	A
		BCS	@circular_saw_check_coll
		
		LDA	objects_var_cnt,X
		PHP
		CLC
		ADC	#1
		AND	#$7F
		PLP
		BPL	@not_other_type
		ORA	#$80
@not_other_type:
		STA	objects_var_cnt,X
		
		TAY
		BMI	@moving_up_down
		CMP	#$40
		BCC	@move_l
		JSR	object_inc_X
		JMP	@circular_saw_check_coll
@move_l
		JSR	object_dec_X
		JMP	@circular_saw_check_coll
		
@moving_up_down:
		CMP	#$C0
		BCS	@move_up
		JSR	object_inc_Y
		JMP	@circular_saw_check_coll
@move_up
		JSR	object_dec_Y

@circular_saw_check_coll:
		LDA	#64-8
		LDY	objects_type,X
		CPY	#$76
		BNE	@big_circ_saws
		LDA	#48-4
		
@big_circ_saws:
		STA	hitbox_h
		STA	hitbox_v
		
		LDA	#2
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox


; =============== S U B	R O U T	I N E =======================================

; $7A
object_big_ring:
		LDA	capsule_func_num
;		CMP	#4
;		BNE	@not_blink
;		INC	objects_var_cnt,X
;@not_blink:
		CMP	#7
		BEQ	@delete_ring
		JSR	obj_update_rel_pos_and_test
		BEQ	@ring_on_screen
		RTS
		
@delete_ring:
		JMP	remove_temp_obj
		
@ring_on_screen:
		LDA	objects_var_cnt,X
		CMP	#1
		BNE	@skip_pal_set
		LDX	#3	; SS palette index
		JSR	setup_ss_palette
		LDX	object_slot
@skip_pal_set:
		INC	objects_var_cnt,X
		LDA	objects_var_cnt,X
		CMP	#210-16
		BCC	@check_coll
		BNE	@wait_anim
		LDA	#8
		JSR	object_add_X
		LDA	#8
		JSR	object_add_Y
@wait_anim:
		CMP	#210
		BCS	@delete_ring
		RTS

@check_coll:
		LDA	#32
		STA	hitbox_h
		STA	hitbox_v
		LDA	#5	; type = collision with emerald
		STA	obj_collision_flag
		JMP	check_collision_both_hitbox


; =============== S U B	R O U T	I N E =======================================

; $7B and $7C
object_flipper:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDA	objects_var_cnt,X
		BEQ	@skip_anim
		CLC
		ADC	#1
		AND	#$F
		STA	objects_var_cnt,X
@skip_anim:

		LDA	#32
		STA	hitbox_h

collision_vs_flipper:
		LDA	objects_Y_relative_h,X
		BMI	@loc_80A8F
		RTS
; ---------------------------------------------------------------------------

@loc_80A8F:
		LDY	#0
		LDA	objects_Y_relative_l,X
		CMP	#$D8
		BCC	@ret
		CMP	#$F0
		BCC	@loc_80A9F
		RTS
; ---------------------------------------------------------------------------

;@loc_80A9D:
;		LDY	#1

@loc_80A9F:
;		STY	obj_collision_flag
		LDA	objects_X_relative_h,X
		BMI	@loc_80AAE
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	@loc_80ABB
		RTS
; ---------------------------------------------------------------------------

@loc_80AAE:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	@loc_80ABB
		ADC	#8
		BCS	@loc_80ABB
		RTS
; ---------------------------------------------------------------------------

@loc_80ABB:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	@ret
		
		LDA	sonic_attribs
		ORA	#MOVE_UP
		STA	sonic_attribs
		LDA	#240
		STA	sonic_Y_speed
		INC	objects_var_cnt,X
@ret:
		RTS


; =============== S U B	R O U T	I N E =======================================


; $7E
object_sbz_lift:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDA	objects_delay,X
		BNE	@sonic_taken
		LDA	#8
		STA	hitbox_h
		LDA	#8
		STA	hitbox_v
		JSR	check_collision_std
		BCC	@ret
		;LDA	sonic_anim_num
		LDA	sonic_act_spr
		CMP	#9	; dead
		BEQ	@ret

@sonic_taken
	;	JMP	@sonic_taken
		LDY	objects_var_cnt,X	; number of lift
		INC	objects_delay,X
		LDA	objects_delay,X
		CMP	lifts_time,Y
		BCS	@free_sonic
		
		CMP	#$20
		BCC	@copy_pos_to_sonic
		LDA	lifts_speed,Y
		BMI	@move_up
		JSR	object_add_Y
		JMP	@copy_pos_to_sonic
@move_up:
		AND	#$7F
		JSR	object_sub_Y
		
@copy_pos_to_sonic:
		LDA	objects_X_l,X
		STA	sonic_X_l_new
		LDA	objects_X_h,X
		STA	sonic_X_h_new
		LDA	objects_Y_l,X
		STA	sonic_Y_l_new
		LDA	objects_Y_h,X
		STA	sonic_Y_h_new
		
		LDA	#0
		STA	objects_X_relative_l,X
		STA	objects_X_relative_h,X
		STA	objects_Y_relative_l,X
		STA	objects_Y_relative_h,X

		LDA	#$20
		STA	sonic_anim_num
		LDA	#8
		STA	sfx_to_play
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FC
		;STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		;LDA	sonic_attribs
		;ORA	#$10
		ORA	#$30
		STA	sonic_attribs
		
@ret
		RTS

@free_sonic:
		LDA	sonic_attribs
		AND	#$CF
		STA	sonic_attribs
		
		LDA	#0
		STA	sonic_anim_num
		JMP	object_remove

lifts_time:
		.BYTE	136,096,064,096,064,096, 144 ; 32*7 = moves 224 down

lifts_speed:
		.BYTE	$07,$07,$87,$07,$07,$07, $87 ; +7 to Y (down), -7 to Y (up)


; =============== S U B	R O U T	I N E =======================================

; $7F
object_checkpoint:
		JSR	obj_update_rel_pos_and_test
		BEQ	@on_screen
		JMP	object_remove
; ---------------------------------------------------------------------------

@on_screen:
		LDA	objects_var_cnt,X
		BEQ	@check_coll
		CMP	#32
		BCS	@locret_checkpoint
		INC	objects_var_cnt,X
		CMP	#1
		BNE	@locret_checkpoint
		JSR	@checkpoint_compare
		BEQ	@locret_checkpoint
		LDA	objects_X_l,X
		SEC
		SBC	#$78
		STA	checkpoint_x_l
		LDA	objects_X_h,X
		SBC	#0
		STA	checkpoint_x_h
		LDA	objects_Y_l,X
		SEC
		SBC	#$60
		BCS	@no_wrap
		SBC	#$F
		CLC
@no_wrap
		STA	checkpoint_y_l
		LDA	objects_Y_h,X
		SBC	#0
		STA	checkpoint_y_h
		LDA	#$A
		STA	sfx_to_play
;		LDA	rings_100s
;		BNE	loc_80C79
;		LDA	rings_10s
;		CMP	#5		; compare for 50 rings
;		BCS	loc_80C79
;
@locret_checkpoint:
		RTS
; ---------------------------------------------------------------------------

@check_coll:
		JSR	@checkpoint_compare
		BNE	@new
		LDA	#32
		STA	objects_var_cnt,X
		RTS
@new:
		LDA	#16
		STA	hitbox_h
		LDA	#40
		STA	hitbox_v
		JSR	check_collision_std
		BCC	@no_coll
		INC	objects_var_cnt,X
@no_coll
		RTS
; ---------------------------------------------------------------------------
		
@checkpoint_compare:
		LDA	objects_X_l,X
		SEC
		SBC	#$78
		LDA	objects_X_h,X
		SBC	#0
		CMP	checkpoint_x_h
		BEQ	@same_x
		RTS
@same_x:
		LDA	objects_Y_l,X
		SEC
		SBC	#$60
		LDA	objects_Y_h,X
		SBC	#0
		CMP	checkpoint_y_h
		RTS


; =============== S U B	R O U T	I N E =======================================
		
		
check_collision_std:
;		JMP	check_collision_std
		LDA	objects_X_relative_h,X
		BMI	@l
		LDA	objects_X_relative_l,X
		CMP	#8
		BCC	@chk_y
		CLC ; no collision
		RTS
; ---------------------------------------------------------------------------

@l:
		LDA	objects_X_relative_l,X
		CLC
		ADC	hitbox_h
		BCS	@chk_y
		ADC	#8
		BCS	@chk_y
		;CLC ; no collision
		RTS
; ---------------------------------------------------------------------------

@chk_y:
		LDA	objects_Y_relative_h,X
		BMI	@d
		CLC ; no collision
		RTS
; ---------------------------------------------------------------------------

@d:
		LDA	objects_Y_relative_l,X
		CLC
		ADC	hitbox_v
		BCS	@ret
		;LDY	sonic_anim_num
		LDY	sonic_act_spr
		ADC	sonic_hitbox_Y_by_anim,Y
		;ADC	#24
		;BCS	@ret
		;CLC ; no collision
@ret
		RTS

; ---------------------------------------------------------------------------
; custom Y hitbox table:
sonic_hitbox_Y_by_anim:
		.BYTE	24 ; 0 idle
		.BYTE	24 ; 1 walk
		.BYTE	24 ; 2 walk1
		.BYTE	24 ; 3 walk2
		.BYTE	24 ; 4 walk3
		.BYTE	24 ; 5 walk4
		.BYTE	24 ; 6 spring jump
		.BYTE	24 ; 7 skid

		.BYTE	24 ; 8 spin jump
		.BYTE	24 ; 9 death
		.BYTE	24 ; 10 get_hit
		.BYTE	24-4 ; 11 sit
		.BYTE	24 ; 12 look up
		.BYTE	24 ; 13
		.BYTE	24 ; 14
		.BYTE	24 ; 15 wait

		.BYTE	24 ; 16
		.BYTE	24 ; 17 drown
		.BYTE	24 ; 18
		.BYTE	24 ; 19
		.BYTE	24 ; 20
		.BYTE	24 ; 21
		.BYTE	24 ; 22
		.BYTE	24 ; 23

		.BYTE	24 ; 24
		.BYTE	24 ; 25
		.BYTE	24 ; 26
		.BYTE	24 ; 27
		.BYTE	24 ; 28
		.BYTE	24 ; 29
		.BYTE	24 ; 30
		.BYTE	24 ; 31 start spindash

		.BYTE	24 ; 32 spin (no jump)
		.BYTE	24 ; 33
		.BYTE	24 ; 34
		.BYTE	24 ; 35
		.BYTE	24 ; 36
		.BYTE	24 ; 37
		.BYTE	24 ; 38
		.BYTE	24 ; 39

		.BYTE	24 ; 40
		.BYTE	24 ; 41
		.BYTE	24 ; 42
		.BYTE	24 ; 43
		.BYTE	24 ; 44	bubble breath


; =============== S U B	R O U T	I N E =======================================


hide_all_sprites_fast:
		LDA	#$F8
var1 = 0
		REPT	64
		STA	sprites_Y+var1
var1 = var1+4
		ENDR
		RTS


; =============== S U B	R O U T	I N E =======================================


DEMO_PLAY:
		LDA	joy1_press
		AND	#BUTTON_START
		STA	demo_reset_f

		LDA	demo_func_id
		CMP	#4
		LDA	level_id
		BCC	@std_demos
		ADC	#3
		STA	level_finish_func_num
@std_demos
		ASL	A
		TAX
		LDA	demo_dat_ptrs,X
		STA	tmp_ptr_l
		LDA	demo_dat_ptrs+1,X
		STA	tmp_ptr_l+1
		
		LDY	demo_ptr1
		DEC	demo_cnt1
		BNE	@no_next
		INY
		INY
		
		INY
		LDA	(tmp_ptr_l),Y
		STA	demo_cnt1
		DEY
		
@no_next:
		LDA	(tmp_ptr_l),Y
		STA	joy1_hold
		STY	demo_ptr1
		
		TAX	; save new
		EOR	joy1_hold_demo  ; eor prev
		AND	joy1_hold	; and current
		
		STX	joy1_hold ; write new
		STA	joy1_press

		STX	joy1_hold_demo ; write new copy for demo
		RTS
; End of function read_demo_data

; ---------------------------------------------------------------------------
demo_dat_ptrs:	.WORD demo1_data
		.WORD demo2_data
		.WORD demo3_data
		.WORD demo4_data
		.WORD demo5_data
		.WORD demo6_data
		.WORD demo7_data
		.WORD demo8_data
		.WORD demo9_data
		.WORD demo10_data

demo1_data:
		incbin "replays\1.bin"
demo2_data:
		incbin "replays\2.bin"
demo3_data:
		incbin "replays\3.bin"
demo4_data:
		incbin "replays\4.bin"
; ending scenes
demo5_data:
		incbin "replays\5.bin"
demo6_data:
		incbin "replays\6.bin"
demo7_data:
		incbin "replays\7.bin"
demo8_data:
		incbin "replays\8.bin"
demo9_data:
		incbin "replays\9.bin"
demo10_data:
		incbin "replays\10.bin"
		
		IF	(TEST_SPR=1)
		include	test_spr.asm
		ENDIF

		org	$BD80
		
killed_objs_tbl:.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2
		.BYTE	 3,   3,   3,	3,   3,	  3,   3,   3
		.BYTE	 4,   4,   4,	4,   4,	  4,   4,   4
		.BYTE	 5,   5,   5,	5,   5,	  5,   5,   5
		.BYTE	 6,   6,   6,	6,   6,	  6,   6,   6
		.BYTE	 7,   7,   7,	7,   7,	  7,   7,   7
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 9,   9,   9,	9,   9,	  9,   9,   9
		.BYTE	$A,  $A,  $A,  $A,  $A,	 $A,  $A,  $A
		.BYTE	$B,  $B,  $B,  $B,  $B,	 $B,  $B,  $B
		.BYTE	$C,  $C,  $C,  $C,  $C,	 $C,  $C,  $C
		.BYTE	$D,  $D,  $D,  $D,  $D,	 $D,  $D,  $D
		.BYTE	$E,  $E,  $E,  $E,  $E,	 $E,  $E,  $E
		.BYTE	$F,  $F,  $F,  $F,  $F,	 $F,  $F,  $F
		
solid_blk_tbl:	.BYTE	 0,   1,   1,	1,   1,	  1,   1,   1,	 1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   1,	  1,   1,   1,	 1,   1
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   1,	  0,   1,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0,   0,   0,	 0,   0
		.BYTE	 0,   0,   0,	0,   0,	  0
		
killed_objs_mask_0:.BYTE    1,	 2,   4,   8, $10, $20,	$40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		.BYTE	 1,   2,   4,	8, $10,	$20, $40, $80
		
killed_objs_mask:.BYTE	$FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F
		.BYTE  $FE, $FD, $FB, $F7, $EF,	$DF, $BF, $7F

		.pad	$C000
