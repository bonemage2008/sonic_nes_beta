test_sprites_mode:
		JSR	hide_all_sprites
		
		LDA	#$10
		STA	ppu_ctrl2_val

		LDX	sonic_status
		LDA	joy1_press
		AND	#BUTTON_RIGHT
		BEQ	@no_inc
		INX
		CPX	#$57
		BNE	@no_inc	
		LDX	#0
@no_inc	

		LDA	joy1_press
		AND	#BUTTON_LEFT
		BEQ	@no_dec
		DEX
		BPL	@no_dec
		LDX	#$56
		
@no_dec
		STX	sonic_status
		
		LDA	joy1_press
		AND	#BUTTON_SELECT
		BEQ	@no_change
		LDA	sonic_state
		EOR	#$80
		STA	sonic_state
@no_change:


		LDA	joy1_press
		AND	#BUTTON_B
		BEQ	@no_changeh
		LDA	sonic_attribs
		EOR	#$40
		STA	sonic_attribs
@no_changeh:

		LDA	joy1_press
		AND	#BUTTON_A
		BEQ	@no_changev
		LDA	sonic_attribs
		EOR	#$80
		STA	sonic_attribs
@no_changev:


		;JSR	init_sonic_spr_ptr
		LDA	#$80
		STA	sonic_x_on_scr
		STA	sonic_y_on_scr
		
		;LDA	#0
		;STA	sonic_attribs
		LDA	#0
		STA	sonic_rwalk_attr
		LDA	#1
		STA	sonic_act_spr
		
		LDA	sonic_status ; test_sprite_num
		;LDA	#4
		ASL	A
		TAY
		
		BIT	sonic_state
		BPL	@normal
		LDA	test_super_frames_ptrs,Y
		LDX	test_super_frames_ptrs+1,Y
		JMP	@super
		
@normal		
		LDA	test_frames_ptrs,Y
		LDX	test_frames_ptrs+1,Y
		
@super:
		STA	sonic_spr_cfg_ptr
		STX	sonic_spr_cfg_ptr+1
		
		;LDA	sonic_spr_cfg_ptr
		ORA	sonic_spr_cfg_ptr+1
		BEQ	@skip_draw_sonic
		
		LDA	sprite_id
		STA	tmp_var_29
		JSR	j_draw_sonic
;		JSR	get_sonic_sprites_pos
;		JSR	draw_sonic_sprites
		LDX	sprite_id
		LDY	tmp_var_29
		
@copy
		LDA	sprites_Y,Y
		CLC
		ADC	#$40
		STA	sprites_Y,X
		LDA	#$62
		STA	sprites_tile,X
		LDA	sprites_attr,Y
		STA	sprites_attr,X
		LDA	sprites_X,Y
		STA	sprites_X,X
		INX
		INX
		INX
		INX
		INY
		INY
		INY
		INY
		CPY	sprite_id
		BNE	@copy
		STX	sprite_id
		
		; draw frame number
@skip_draw_sonic:
		LDX	sprite_id
		LDA	sonic_status
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		CLC
		ADC	#$EA
		STA	sprites_tile,X
		LDA	sonic_status
		AND	#$F
		ADC	#$EA
		STA	sprites_tile+4,X
		
		LDA	#$20
		STA	sprites_Y,X
		STA	sprites_Y+4,X
		STA	sprites_Y+8,X
		STA	sprites_Y+12,X
		
		STA	sprites_X,X
		LDA	#$28
		STA	sprites_X+4,X
		LDA	#$38
		STA	sprites_X+8,X
		LDA	#$48
		STA	sprites_X+12,X	
		
		LDA	#3
		STA	sprites_attr,X
		STA	sprites_attr+4,X
		STA	sprites_attr+8,X
		STA	sprites_attr+12,X
		
		; draw mode H
		LDA	#$FF
		BIT	sonic_attribs
		BVC	@no_hm
		LDA	#$D7
	
@no_hm	
		STA	sprites_tile+8,X
		
		; draw mode V
		LDA	#$FF
		BIT	sonic_attribs
		BPL	@no_vm
		LDA	#$E5
		
@no_vm		
		STA	sprites_tile+12,X
		
		JMP	test_mode_loop
		

test_frames_ptrs:
	.WORD	FRAME_00
	.WORD	FRAME_01
	.WORD	FRAME_02
	.WORD	FRAME_03
	.WORD	FRAME_04_new
	.WORD	FRAME_05
	.WORD	FRAME_06
	.WORD	FRAME_07
	.WORD	FRAME_08
	.WORD	FRAME_09
	.WORD	FRAME_0A
	.WORD	FRAME_0B
	.WORD	FRAME_0C
	.WORD	FRAME_0D
	.WORD	FRAME_0E
	.WORD	FRAME_0F
	
	.WORD	FRAME_10
	.WORD	FRAME_11
	.WORD	FRAME_12
	.WORD	FRAME_13
	.WORD	FRAME_14
	.WORD	FRAME_15
	.WORD	FRAME_16
	.WORD	FRAME_17
	.WORD	FRAME_18
	.WORD	FRAME_19
	.WORD	FRAME_1A
	.WORD	FRAME_1B
	.WORD	FRAME_1C
	.WORD	FRAME_1D
	.WORD	FRAME_1E
	.WORD	FRAME_1F
	
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	FRAME_29
	.WORD	FRAME_2A
	.WORD	FRAME_2B
	.WORD	FRAME_2C
	.WORD	FRAME_2D
	.WORD	FRAME_2E
	.WORD	FRAME_2F

	.WORD	FRAME_30
	.WORD	FRAME_31
	.WORD	0
	.WORD	FRAME_33
	.WORD	FRAME_34
	.WORD	FRAME_35
	.WORD	FRAME_36
	.WORD	FRAME_37
	.WORD	FRAME_38
	.WORD	FRAME_39
	.WORD	FRAME_3A
	.WORD	FRAME_3B
	.WORD	0
	.WORD	FRAME_3D
	.WORD	FRAME_3E_new
	.WORD	FRAME_3F_new
	
	.WORD	FRAME_40_new
	.WORD	FRAME_41_new
	.WORD	FRAME_42_new
	.WORD	FRAME_43
	.WORD	FRAME_44
	.WORD	FRAME_45
	.WORD	FRAME_46
	.WORD	FRAME_47
	.WORD	FRAME_48
	.WORD	FRAME_49
	.WORD	FRAME_4A
	.WORD	FRAME_4B
	.WORD	FRAME_4C
	.WORD	0
	.WORD	FRAME_4E
	.WORD	FRAME_4F
	
	.WORD	FRAME_50
	.WORD	FRAME_51
	.WORD	FRAME_52
	.WORD	FRAME_53
	.WORD	FRAME_54
	.WORD	FRAME_55_SUPER
	.WORD	FRAME_56_SUPER
	
test_super_frames_ptrs:
	.WORD	FRAME_00_SUPER
	.WORD	FRAME_01
	.WORD	FRAME_02
	.WORD	FRAME_03
	.WORD	FRAME_04_SUPER
	.WORD	FRAME_05_SUPER
	.WORD	FRAME_06_SUPER
	.WORD	FRAME_07_SUPER
	.WORD	FRAME_08_SUPER
	.WORD	FRAME_09_SUPER
	.WORD	FRAME_0A_SUPER
	.WORD	FRAME_0B_SUPER
	.WORD	FRAME_0C_SUPER
	.WORD	FRAME_0D_SUPER
	.WORD	FRAME_0C_SUPER ;FRAME_0E
	.WORD	FRAME_0F_SUPER
	
	.WORD	FRAME_10_SUPER
	.WORD	FRAME_11
	.WORD	FRAME_12_SUPER
	.WORD	FRAME_13_SUPER
	.WORD	FRAME_14_SUPER
	.WORD	FRAME_15_SUPER
	.WORD	FRAME_16_SUPER
	.WORD	FRAME_17_SUPER
	.WORD	FRAME_18_SUPER
	.WORD	FRAME_19
	.WORD	FRAME_1A
	.WORD	FRAME_1B
	.WORD	FRAME_1C
	.WORD	FRAME_1D
	.WORD	FRAME_1E
	.WORD	FRAME_1F
	
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	0
	.WORD	FRAME_29_SUPER
	.WORD	FRAME_2A_SUPER
	.WORD	FRAME_2B_SUPER
	.WORD	FRAME_2C_SUPER
	.WORD	FRAME_2D_SUPER
	.WORD	FRAME_2E_SUPER
	.WORD	FRAME_2F_SUPER

	.WORD	FRAME_30_SUPER
	.WORD	FRAME_31_SUPER
	.WORD	0
	.WORD	FRAME_33_SUPER
	.WORD	FRAME_34_SUPER
	.WORD	FRAME_35_SUPER
	.WORD	FRAME_36_SUPER
	.WORD	FRAME_37_SUPER
	.WORD	FRAME_38_SUPER
	.WORD	FRAME_39_SUPER
	.WORD	FRAME_3A_SUPER
	.WORD	FRAME_3B_SUPER
	.WORD	0
	.WORD	FRAME_3D_SUPER
	.WORD	FRAME_3E_new
	.WORD	FRAME_3F_new
	
	.WORD	FRAME_40_new
	.WORD	FRAME_41_new
	.WORD	FRAME_42_new
	.WORD	FRAME_43
	.WORD	FRAME_44_SUPER
	.WORD	FRAME_45_SUPER
	.WORD	FRAME_46_SUPER
	.WORD	FRAME_47_SUPER
	.WORD	FRAME_48_SUPER
	.WORD	FRAME_49_SUPER
	.WORD	FRAME_4A_SUPER
	.WORD	FRAME_4B_SUPER
	.WORD	FRAME_4C_SUPER
	.WORD	0
	.WORD	FRAME_4E
	.WORD	FRAME_4F
	
	.WORD	FRAME_50
	.WORD	FRAME_51
	.WORD	FRAME_52
	.WORD	FRAME_53_SUPER
	.WORD	FRAME_54_SUPER
	.WORD	FRAME_55_SUPER
	.WORD	FRAME_56_SUPER
	