GHZ_CHR_BANK1	  equ	$40 ; chameleons
GHZ_CHR_BANK2	  equ	$42 ; fish

MARBLE_CHR_BANK1  equ	$48 ; wasp
MARBLE_CHR_BANK2  equ	$4A ; bat

SPRING_CHR_BANK1  equ	$4C ; crabs
SPRING_CHR_BANK2  equ	$4E ; spiked badnik

LAB_CHR_BANK	  equ	$50 ; $14000
STARL_CHR_BANK	  equ	$52 ; $14800 sonic.chr
SBZ_CHR_BANK1	  equ	$54 ; $15000 sonic.chr  with ballhog
SBZ_CHR_BANK2	  equ	$56 ; $15800            with platforms
SBZ_CHR_BANK3	  equ	$88 ; $22000 with saw
SBZ_CHR_BANK4	  equ	$8A ; $22800  BALLHOG + BIG SPIKE + FLAME
SBZ_CHR_BANK3a	  equ	$FE ; $3F800 with saw (anim2)

SINGPOST_CHR_BANK  equ	$80 ; $20000

FLIPPER_CHR_BANK   equ $3E ; $F800

	MACRO	INX4
	INX
	INX
	INX
	INX
	ENDM
	
	MACRO	write_tile_attr_y
	STA	sprites_tile,X
	LDA	tmp_var_25
	STA	sprites_attr,X
	LDA	tmp_var_2B
	STA	sprites_Y,X
	INX4
	ENDM

		org	$8000

draw_objects_sprites:
		LDA	Frame_Cnt
		LSR	A
		BCS	loc_7401A
		LDX	#0

loc_74008:
		STX	object_slot
		LDA	objects_type,X
		BEQ	loc_74012
		JSR	draw_object_sprite
		LDA	sprite_id
		BEQ	locret_7402D

loc_74012:
		LDX	object_slot
		INX
		CPX	objects_cnt
		BCC	loc_74008
		RTS
; ---------------------------------------------------------------------------

loc_7401A:
		LDX	objects_cnt
		BEQ	locret_7402D
		DEX

loc_7401E:
		STX	object_slot
		LDA	objects_type,X
		BEQ	loc_74028
		JSR	draw_object_sprite
		LDA	sprite_id
		BEQ	locret_7402D

loc_74028:
		LDX	object_slot
		DEX
		BPL	loc_7401E

locret_7402D:
		RTS
; End of function draw_objects_sprites


; =============== S U B	R O U T	I N E =======================================


draw_object_sprite:
		ASL	A
		TAY
		LDA	obj_spr_code,Y
		STA	tmp_ptr_l
		LDA	obj_spr_code+1,Y
		STA	tmp_ptr_l+1
		JMP	(tmp_ptr_l)
; End of function draw_object_sprite

; ---------------------------------------------------------------------------
obj_spr_code:	.WORD locret_7410D	; 0
		.WORD draw_wasp		; 1
		.WORD draw_wasp_attack	; 2
		.WORD draw_jumping_fish	; 3
		.WORD draw_crab		; 4
		.WORD draw_crab_attack	; 5
		.WORD draw_chameleon	; 6
		.WORD draw_chameleon	; 7
		.WORD draw_chameleon2	; 8
		.WORD locret_7410D	; 9
		.WORD draw_object_0A	; 10
		.WORD draw_fire_V	; 11
		.WORD draw_object_0A	; 12
		.WORD draw_bat	; 13
		.WORD draw_unused_spikes	; 14
		.WORD draw_bullet	; 15
		.WORD draw_monitor	; 16
		.WORD draw_monitor	; 17
		.WORD draw_monitor	; 18
		.WORD draw_monitor	; 19
		.WORD draw_monitor	; 20
		.WORD draw_monitor	; 21
		.WORD draw_ring		; 22
		.WORD locret_7410D	; 23
		.WORD draw_animal	; 24
		.WORD draw_animal	; 25
		.WORD draw_bullet	; 26
		.WORD draw_bullet	; 27
		.WORD draw_bullet	; 28
		.WORD draw_explosion	; 29
		.WORD draw_fire_V	; 30
		.WORD draw_fire_V	; 31
		.WORD draw_object_20	; 32
		.WORD draw_object_20	; 33
		.WORD draw_object_20	; 34
		.WORD draw_object_20	; 35
		.WORD draw_object_24	; 36
		.WORD draw_object_24	; 37
		.WORD draw_object_24	; 38
		.WORD draw_object_24	; 39
		.WORD draw_caterpillar	; $28
		.WORD draw_object_29	; $29
		.WORD draw_fire_on_ground	; $2A
		.WORD draw_object_29	; $2B
		.WORD locret_7410D	; $2C
		.WORD locret_7410D	; $2D
		.WORD draw_singpost	; $2E
		.WORD draw_singpost	; $2F
		.WORD draw_object_30	; $30
		.WORD draw_big_spike	; $31
		.WORD draw_big_spike	; $32
		.WORD draw_small_spike	; $33
		.WORD draw_big_spike	; $34
		.WORD draw_big_spike_UD	; $35
		.WORD locret_7410D	; $36
		.WORD locret_7410D	; $37
		.WORD draw_big_platform	; $38
		.WORD draw_small_platform ; $39
		.WORD draw_big_platform	; $3A
		.WORD draw_small_platform ; $3B
		.WORD draw_big_platform	; $3C
		.WORD draw_small_platform ; $3D
		.WORD draw_small_spike	; $3E
		.WORD draw_object_3F	; 63
		.WORD draw_object_labfish	; 64
		.WORD draw_garg_projectile	; 65
		.WORD draw_garg_projectile	; 66
		.WORD locret_7410D	; 67
		.WORD draw_large_air_bubble	; $44
		.WORD draw_small_air_bubble	; $45
		.WORD draw_small_air_bubble	; $46
		.WORD draw_object_47	; 71
		.WORD draw_object_48	; 72
		.WORD draw_harpoon_Left	; 73
		.WORD draw_harpoon_Right	; 74
		.WORD draw_harpoon_Up	; 75
		.WORD draw_harpoon_Up_alt	; 76
		.WORD draw_object_3F	; 77
		.WORD draw_object_3F	; 78
		.WORD draw_object_3F	; 79
		.WORD draw_badnik_with_spikes ; 80
		.WORD draw_star_light_bomb	; 81
		.WORD draw_star_light_bomb	; 82
		.WORD draw_burrobot	; 83
		.WORD locret_7410D	; 84
		.WORD locret_7410D	; 85
		.WORD locret_7410D	; 86
		.WORD locret_7410D	; 87
		.WORD draw_final_boss_weapon ; 88
		.WORD draw_final_boss_weapon ; 89
		.WORD draw_final_boss_weapon ; 90
		.WORD draw_final_boss_weapon ; 91
		.WORD draw_final_boss_weapon ; 92
		.WORD draw_final_boss_weapon ; 93
		.WORD locret_7410D	; 94
		.WORD locret_7410D	; 95
		.WORD draw_explosions	; 96
		.WORD draw_object_61	; 97
		.WORD draw_fires	; 98
		.WORD draw_fires	; 99
		.WORD draw_object_64	; 100
		.WORD draw_object_65	; 101
		.WORD draw_object_65	; 102
		.WORD locret_7410D	; 103
		.WORD draw_chaos_emerald ; $68 (104)
		.WORD draw_flame	; $69 (105)
		.WORD locret_7410D	; $6A (106)
		.WORD draw_blocks_boss3 ; $6B (107)
		.WORD draw_ballhog ; $6C
		.WORD draw_ballhog_ball ; $6D
		.WORD draw_flame ; $6E
		.WORD draw_sbz_platform ; $6F
		.WORD draw_sbz_platform2 ; $70
		.WORD draw_wall ; $71
		.WORD draw_long_mesh_block ; $72
		.WORD draw_circular_saw ; $73
		.WORD draw_circular_saw2 ; $74
		.WORD draw_circular_saw2a ; $75
		.WORD draw_circular_saw3 ; $76
		.WORD draw_circular_saw3a ; $77
		.WORD locret_7410D ; $78
		.WORD draw_small_air_bubble ; $79
		.WORD draw_big_ring ; $7A
		.WORD draw_flipper_m ; $7B
		.WORD draw_flipper ; $7C
		.WORD draw_pick_ring_anim ; $7D
		.WORD locret_7410D ; $7E
		.WORD draw_checkpoint ; $7F
; ---------------------------------------------------------------------------

locret_7410D:
		RTS

; =============== S U B	R O U T	I N E =======================================


draw_wasp:
		LDA	#5
		LDY	#3
		JSR	pos_for_draw_object
		
		LDY	#0
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_7419D
		LDY	#$F

loc_7419D:
		STY	tmp_var_29
		LDX	sprite_id	; index	to sprites buffer

		LDA	tmp_y_positions+2
		BEQ	@draw_wasp_nx
		STA	tmp_var_28
		
		LDY	#3
		LDA	tmp_var_29
		BEQ	@normal
		LDY	#$43
		LDA	tmp_x_positions+1
		JMP	@mirored
@normal:
		LDA	tmp_x_positions+3
@mirored:
		BEQ	@draw_wasp_nx
		STA	sprites_X,X
		LDA	tmp_var_28
		STA	sprites_Y,X
		TYA
		STA	sprites_attr,X

		LDA	Frame_Cnt
		AND	#2
		BNE	@frames_3_4
		LDA	#$9C
		LDY	level_id
		CPY	#STAR_LIGHT
		BNE	@frames_1_2
		LDA	#$AC
		BNE	@frames_1_2
@frames_3_4:
		LDA	#$90
@frames_1_2:
		STA	sprites_tile,X
		INX4
		BEQ	j_set_wasp_chr_bank
		
@draw_wasp_nx:
		LDA	Frame_Cnt
		AND	#2
		TAY
		LDA	byte_74253,Y
		CLC
		ADC	tmp_var_29
		STA	spr_cfg_off
		LDA	byte_74254,Y
		TAY

loc_741B2:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_741C3
@skip:	
		LDA	spr_cfg_off
		CLC
		ADC	#5
		STA	spr_cfg_off
		JMP	loc_741FB
; ---------------------------------------------------------------------------

loc_741C3:
		STA	tmp_var_2B
		LDY	#0

loc_741C7:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_741F2
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_74D59,Y
		BEQ	loc_741F2
		STA	sprites_tile,X
		LDA	byte_74D77,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	j_set_wasp_chr_bank

loc_741F2:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#5
		BCC	loc_741C7

loc_741FB:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_741B2

j_set_wasp_chr_bank:
		JMP	set_wasp_chr_bank
; ---------------------------------------------------------------------------
byte_74253:	.BYTE 0
byte_74254:	.BYTE 0
		.BYTE 5
		.BYTE 1
; ---------------------------------------------------------------------------

draw_wasp_attack:
		LDA	#4
		LDY	#4
		JSR	pos_for_draw_object

		LDY	#0
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_742E6
		LDY	#$10

loc_742E6:
		STY	tmp_var_29
		LDX	sprite_id	; index	to sprites buffer
		LDA	Frame_Cnt
		AND	#2
		TAY
		LDA	byte_7435A,Y
		CLC
		ADC	tmp_var_29
		STA	spr_cfg_off
		LDA	byte_7435B,Y
		TAY

loc_742FB:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7430C
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#4
		STA	spr_cfg_off
		JMP	loc_74344
; ---------------------------------------------------------------------------

loc_7430C:
		STA	tmp_var_2B
		LDY	#0

loc_74310:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7433B
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_74D95,Y
		BEQ	loc_7433B
		STA	sprites_tile,X
		LDA	byte_74DB5,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	set_wasp_chr_bank

loc_7433B:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_74310

loc_74344:
		LDY	spr_parts_counter2
		INY
		CPY	#4
		BCC	loc_742FB

set_wasp_chr_bank:
		CPX	sprite_id
		BEQ	locret_74359
		STX	sprite_id
		LDA	level_id
		CMP	#MARBLE
		BNE	locret_74359
		LDA	level_spr_chr2
		STA	chr_spr_bank2	; enemy	sprites	bank

locret_74359:
		RTS
; End of function draw_wasp

; ---------------------------------------------------------------------------
byte_7435A:	.BYTE 0
byte_7435B:	.BYTE 0
		.BYTE 4
		.BYTE 1

; =============== S U B	R O U T	I N E =======================================


draw_monitor:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object
	
		LDX	object_slot
		LDA	Frame_Cnt
		AND	#3
		BNE	not_anim
		LDA	objects_type,X
		LDX	#6	; anim6
		CMP	#$11	; eggman monitor
		BNE	loc_743F2
		JSR	set_saw_chr
		INX		; anim7
		BNE	loc_743F2 ; JMP
not_anim:
		LDA	objects_type,X
		AND	#$F
		TAX

loc_743F2:
		LDA	monitor_bas_tls,X
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_743FC:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7440D
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_7443E
; ---------------------------------------------------------------------------

loc_7440D:
		STA	tmp_var_2B
		LDY	#0

loc_74411:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_74435
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	monitors_tile,Y
		BEQ	loc_74435
		STA	sprites_tile,X
		LDA	monitors_attr,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_monitor

loc_74435:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_74411

loc_7443E:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_743FC
end_draw_monitor:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_monitor


; =============== S U B	R O U T	I N E =======================================


draw_jumping_fish:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object
		
		LDY	#0
		LDA	Frame_Cnt
		AND	#$10
		BEQ	loc_744D6
		LDY	#9

loc_744D6:
		STY	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_744DC:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_744ED
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_74524
; ---------------------------------------------------------------------------

loc_744ED:
		STA	tmp_var_2B
		LDY	#0

loc_744F1:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7451B
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_74DD5,Y
		BEQ	loc_7451B
		STA	sprites_tile,X
		LDA	#0
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_jumping_fish

loc_7451B:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_744F1

loc_74524:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_744DC

end_draw_jumping_fish:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id	; index	to sprites buffer
		LDA	level_spr_chr2_nx
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret		
		RTS
; End of function draw_jumping_fish


; =============== S U B	R O U T	I N E =======================================


draw_bullet:
		JSR	draw_single_sprite_pos
		LDA	Frame_Cnt
		AND	#8
		BEQ	@tile1
		LDA	#$DF
		.BYTE	$2C
@tile1:
		LDA	#$DE
		STA	sprites_tile,Y
		LDA	#0
		STA	sprites_attr,Y
		RTS
; End of function draw_bullet


; =============== S U B	R O U T	I N E =======================================


draw_crab_attack:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object

		LDA	#0	; idle
		BEQ	draw_crab_sprites ; JMP
; End of function draw_crab_attack


; =============== S U B	R O U T	I N E =======================================


draw_crab:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_delay,X
		BEQ	@ok
		LDA	#$1B	; attack
		BNE	draw_crab_sprites ; JMP

@ok
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAX
		LDA	crab_cfg_off1,X ; walk anim

draw_crab_sprites:
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_7468A:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7469B
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_746D3
; ---------------------------------------------------------------------------

loc_7469B:
		STA	tmp_var_2B
		LDY	#0

loc_7469F:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_746CA
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	crab_tls_nums,Y
		BEQ	loc_746CA
		STA	sprites_tile,X
		LDA	byte_74E13,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_crab

loc_746CA:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_7469F

loc_746D3:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_7468A
		
end_draw_crab
		CPX	sprite_id
		BEQ	@chr_ok
		STX	sprite_id
		LDA	chr_spr_bank2	; CRAB
		CMP	#GHZ_CHR_BANK1
		BEQ	@chr_ok
		CMP	#GHZ_CHR_BANK2
		BEQ	@chr_ok
		CMP	#SPRING_CHR_BANK1
		BEQ	@chr_ok
		LDA	#SPRING_CHR_BANK1
		STA	chr_spr_bank2
@chr_ok:
		RTS
; End of function draw_crab


; =============== S U B	R O U T	I N E =======================================


draw_chameleon:
		LDY	#0
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_747EA
		LDY	#$18

loc_747EA:
		STY	tmp_var_29
		LSR	A
		LSR	A
		AND	#7
		TAY
		LDA	byte_748E6,Y
		BPL	loc_74801
		CMP	#$FF
		BEQ	locret_74800
		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_74801

locret_74800:
		RTS
; ---------------------------------------------------------------------------

loc_74801:
		CLC
		ADC	tmp_var_29
		STA	spr_cfg_off

		LDA	#3
		LDY	#4
		JSR	pos_for_draw_object

		LDX	sprite_id
		LDY	#0

loc_7488E:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7489F
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_748D7
; ---------------------------------------------------------------------------

loc_7489F:
		STA	tmp_var_2B
		LDY	#0

loc_748A3:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_748CE
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_74E37,Y
		BEQ	loc_748CE
		STA	sprites_tile,X
		LDA	byte_74E67,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_chameleon

loc_748CE:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_748A3

loc_748D7:
		LDY	spr_parts_counter2
		INY
		CPY	#4
		BCC	loc_7488E
		
end_draw_chameleon
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id	; index	to sprites buffer
		LDA	level_spr_chr2
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret
		RTS
; End of function draw_chameleon

; ---------------------------------------------------------------------------
byte_748E6:	.BYTE  $FF, $F0,   0,	0,  $C,	  0, $F0, $FF

; =============== S U B	R O U T	I N E =======================================


draw_chameleon2:
		LDA	#2
		STA	tmp_var_25
		LDY	#0
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_74901
		LDY	#$42
		STY	tmp_var_25
		LDY	#$50

loc_74901:
		STY	tmp_var_29
		LSR	A
		LSR	A
		AND	#7
		TAY
		LDA	byte_74A01,Y
		BPL	loc_74922
		CMP	#$FF
		BEQ	locret_74921
		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_74922

locret_74921:
		RTS
; ---------------------------------------------------------------------------

loc_74922:
		CLC
		ADC	tmp_var_29
		STA	spr_cfg_off
		STY	tmp_var_29
		LDA	#4
		LDY	#4
		JSR	pos_for_draw_object

		LDY	tmp_var_29
		LDA	byte_74A09,Y
		BMI	@skip_set_chr
		LDA	level_spr_chr2
		STA	chr_spr_bank2	; enemy	sprites	bank
@skip_set_chr:

		LDX	sprite_id
		LDY	#0

loc_749AF:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_749C0
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_749F7
; ---------------------------------------------------------------------------

loc_749C0:
		STA	tmp_var_2B
		LDY	#0

loc_749C4:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_749EE
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_74E97,Y
		BEQ	loc_749EE
		write_tile_attr_y
		BEQ	end_draw_chameleon2

loc_749EE:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_749C4

loc_749F7:
		LDY	spr_parts_counter2
		INY
		CPY	#4
		BCC	loc_749AF
end_draw_chameleon2:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_chameleon

; ---------------------------------------------------------------------------
byte_74A01:	.BYTE  $FF, $F0, $10, $20, $30,	$40, $40, $40
byte_74A09:	.BYTE	 0,   0,   0,	0, $FF,	$FF, $FF, $FF

; =============== S U B	R O U T	I N E =======================================


draw_animal:
		LDA	#2
		LDY	#2
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_type,X
		CMP	#$19
		BCC	loc_74AB7
		LDY	#$14
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_74AAF
		LDY	#$C
		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_74AAF
		LDY	#$10

loc_74AAF:
		STY	spr_cfg_off
		;LDA	#3
		;STA	tmp_var_25	; attributes birds
		;BNE	loc_74AC9	; JMP
		JSR	FIX_ANIMALS1
		JMP	loc_74AC9		

loc_74AB7:
		LDY	#8
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_74AC3
		LSR	A
		LSR	A
		AND	#4
		TAY

loc_74AC3:
		STY	spr_cfg_off
		;LDA	#2		; attributes rabbits
		;STA	tmp_var_25
		JSR	FIX_ANIMALS2
		;NOP

loc_74AC9:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_74ACD:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_74ADE
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_74B15
; ---------------------------------------------------------------------------

loc_74ADE:
		STA	tmp_var_2B
		LDY	#0

loc_74AE2:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_74B0C
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	animals_tls_nums,Y
		BEQ	loc_74B0C
		write_tile_attr_y
		BEQ	end_draw_animal

loc_74B0C:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_74AE2

loc_74B15:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_74ACD
end_draw_animal:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_animal
; ---------------------------------------------------------------------------

FIX_ANIMALS2:
		LDA	level_id
		CLC
		ADC	#8
		BNE	not_l	; JMP
FIX_ANIMALS1:
		LDA	level_id
not_l
		TAX
		LDA	animals_attr1,X
		LDY	chr_spr_bank2
		CPY	#$E6
		BNE	not_caps
		LDA     animals_attr2,X
not_caps			
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------
animals_attr1:
		.BYTE	$01,$00,$01,$03,$03,$01,$01,$01
		.BYTE	$03,$03,$00,$01,$00,$03,$03,$03
animals_attr2:
		.BYTE	$01,$00,$01,$03,$03,$01,$01,$01
		.BYTE	$03,$03,$00,$01,$00,$03,$03,$03


; =============== S U B	R O U T	I N E =======================================

; $16
draw_ring:
		IF	(RINGS_DROP>3)
		TXA	; SLOT
		EOR	Frame_Cnt
		AND	#1
		BEQ	@skip_draw
		ENDIF

		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		CLC
		ADC	#20
		TAY
		JSR	draw_sprite_new_tile0_attr0
		
@skip_draw
		RTS
; End of function draw_ring


; =============== S U B	R O U T	I N E =======================================

; $7A
draw_big_ring:
;		LDA	objects_var_cnt,X
;		BEQ	@ok
;		LDA	Frame_Cnt
;		AND	#2
;		BEQ	@no_draw
;@ok		
		LDA	objects_var_cnt,X
		CMP	#210-16
		BCS	draw_pick_ring_anim
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		CLC
		ADC	#44
		TAY
		JSR	draw_sprite_new_tile0_attr0
		;LDA	#SINGPOST_CHR_BANK+2 ; RING+BIG RING
		;STA	chr_spr_bank2
@no_draw:
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_pick_ring_anim:
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		CLC
		ADC	#34
		TAY
		;JSR	draw_sprite_new_tile0_attr0
		;RTS
		LDA	#3
		LDX	level_id
		CPX	#FINAL_ZONE
		BNE	@not_final_zone
		LDA	#2
@not_final_zone:
		LDX	#0
		JSR	draw_sprite_new
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_explosion:
		LDY	object_slot
		LDA	objects_var_cnt,Y ; var/counter
		LSR	A
		BCS	@std_exp
		JMP	draw_water_splash
@std_exp
		LSR	A
		LSR	A
		AND	#6
		TAX
		LDA	exp_pos_x,X
		STA	tmp_var_25
		LDA	exp_pos_y,X
		STA	tmp_var_26
		LDA	sonic_x_on_scr
		CLC
		;ADC	tmp_var_25
		ADC	#4
		ADC	objects_X_relative_l,Y
		STA	tmp_x_positions
		LDA	objects_X_relative_h,Y
		ADC	#0
		BEQ	loc_74C29
		CMP	#$FF
		BEQ	loc_74C31
		RTS
; ---------------------------------------------------------------------------

loc_74C29:
		LDA	tmp_x_positions
		CLC
		ADC	tmp_var_26
		BCC	loc_74C3D
		RTS
; ---------------------------------------------------------------------------

loc_74C31:
		LDA	#0
		STA	tmp_x_positions
		LDA	tmp_var_28	; ?
		CLC
		ADC	tmp_var_26
		BCS	loc_74C3D
		RTS
; ---------------------------------------------------------------------------

loc_74C3D:
		STA	tmp_x_positions+1
		LDA	sonic_y_on_scr
		CLC
		;ADC	tmp_var_26
		ADC	#4
		ADC	objects_Y_relative_l,Y
		STA	tmp_y_positions
		LDA	objects_Y_relative_h,Y
		ADC	#0
		BEQ	loc_74C53
		CMP	#$FF
		BEQ	loc_74C5B
		RTS
; ---------------------------------------------------------------------------

loc_74C53:
		LDA	tmp_y_positions
		CLC
		ADC	tmp_var_26
		BCC	loc_74C67
		RTS
; ---------------------------------------------------------------------------

loc_74C5B:
		LDA	#0
		STA	tmp_x_positions
		LDA	tmp_var_2B	; ?
		CLC
		ADC	tmp_var_26
		BCS	loc_74C67
		RTS
; ---------------------------------------------------------------------------

loc_74C67:
		STA	tmp_y_positions+1
		LDA	exp_tile,X
		STA	tmp_var_25
		LDA	#0
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_74C76:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_74C87
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_74CB5
; ---------------------------------------------------------------------------

loc_74C87:
		STA	tmp_var_2B
		LDY	#0

loc_74C8B:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_74CAC
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	tmp_var_25
		STA	sprites_tile,X
		LDA	ext_attrs,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_explosion

loc_74CAC:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_74C8B

loc_74CB5:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_74C76
end_draw_explosion:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_explosion

; ---------------------------------------------------------------------------
exp_tile:	.BYTE  $E2, $E2
		.BYTE  $E3, $E3
		.BYTE  $E1, $E1
		.BYTE  $E1, $E1
ext_attrs:	.BYTE 3
		.BYTE $43
		.BYTE $83
		.BYTE $C3
exp_pos_x:	.BYTE 8
exp_pos_y:	.BYTE 8
		.BYTE	 6,  $C
		.BYTE	 4, $10
		.BYTE	 4, $10
monitor_bas_tls:.BYTE	 0,   9, $12, $1B, $24,	$2D, $36, $3F

monitors_tile:	.BYTE $D3,$D4,$D3
		.BYTE $D5,$D8,$D5 ; ring $10
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $8D,$8E,$8F ; eggman $11
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D5,$D9,$D5 ; sonic $12
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D5,$DA,$D5 ; shoes $13
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D5,$DB,$D5 ; invic $14
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D5,$DC,$D5 ; shield $15
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D6,$D7,$D6 ; noise (anim)
		.BYTE $D0,$D1,$D2
		
		.BYTE $D3,$D4,$D3
		.BYTE $D6,$D7,$D6 ; noise (anim2 red monitor)
		.BYTE $D0,$D1,$D2		
		
monitors_attr:	.BYTE	1,  1,$41
		.BYTE	1,  3,$41
		.BYTE	1,  1,	1
		
		.BYTE	3,  3,$43
		.BYTE	3,  3,$03
		.BYTE	3,  3,	3
		
		.BYTE	1,  1,$41
		.BYTE	1,  1,$41
		.BYTE	1,  1,	1
		.BYTE	1,  1,$41
		.BYTE	1,  0,$41
		.BYTE	1,  1,	1
		.BYTE	1,  1,$41
		.BYTE	1,  1,$41
		.BYTE	1,  1,	1
		.BYTE	1,  1,$41
		.BYTE	1,  1,$41
		.BYTE	1,  1,	1
		.BYTE	1,  1,$41
		.BYTE	1,  3,$41
		.BYTE	1,  1,	1
		
		.BYTE	3,  3,$43
		.BYTE	3,  3,$43
		.BYTE	3,  3,	3		
		
byte_74D59:	.BYTE  $83, $82, $82, $83,   0
		.BYTE  $84, $85, $86, $87, $88
		.BYTE  $8C, $8D, $8E, $8F,   0
		.BYTE	 0, $83, $82, $82, $83
		.BYTE  $88, $87, $86, $85, $84
		.BYTE	 0, $8F, $8E, $8D, $8C
byte_74D77:	.BYTE  $41, $41,   1,	1,   1
		.BYTE	 1,   1,   0,	0,   0
		.BYTE	 1,   1,   0,	0,   0
		.BYTE  $41, $41, $41,	1,   1
		.BYTE  $40, $40, $40, $41, $41
		.BYTE  $40, $40, $40, $41, $41
byte_74D95:	.BYTE  $83, $82, $82, $83
		.BYTE  $89, $8A, $8B,	0
		.BYTE  $91, $92, $93, $94
		.BYTE	 0, $95, $96,	0
		.BYTE  $83, $82, $82, $83
		.BYTE	 0, $8B, $8A, $89
		.BYTE  $94, $93, $92, $91
		.BYTE	 0, $96, $95,	0
byte_74DB5:	.BYTE  $41, $41,   1,	1
		.BYTE	 1,   1,   1,	1
		.BYTE	 1,   1,   0,	0
		.BYTE	 0,   0,   0,	0
		.BYTE  $41, $41,   1,	1
		.BYTE  $41, $41, $41, $41
		.BYTE  $40, $40, $41, $41
		.BYTE  $40, $40, $40, $40
byte_74DD5:	.BYTE  $9D, $9E, $9F, $A2
		.BYTE  $A3, $A4, $A8, $A9
		.BYTE  $AA, $A0, $A1, $9F
		.BYTE  $A5, $A6, $A7, $AB
		.BYTE  $AC,   0
crab_cfg_off1:	.BYTE	 0,   9,   0, $12
;crab_cfg_off2:	.BYTE	 0, $1B, $1B,	0
crab_tls_nums:	.BYTE  $C5, $AE, $C5, $B6
		.BYTE  $B7, $B6, $BF, $C0
		.BYTE  $BF, $B0, $B1, $B2
		.BYTE  $B9, $BA, $BB, $C2
		.BYTE  $C3, $C4, $B2, $B1
		.BYTE  $B0, $BB, $BA, $B9
		.BYTE  $C4, $C3, $C2, $B3
		.BYTE  $B4, $B3, $BC, $BD
		.BYTE  $BC, $BF, $C0, $BF
byte_74E13:	.BYTE	 0,   0, $40,	0
		.BYTE	 0, $40,   0,	0
		.BYTE  $40,   0,   0,	0
		.BYTE	 0,   0,   0,	0
		.BYTE	 0,   0, $40, $40
		.BYTE  $40, $40, $40, $40
		.BYTE  $40, $40, $40,	0
		.BYTE	 0, $40,   0,	0
		.BYTE  $40,   0,   0, $40

byte_74E37:	.BYTE  $9D, $9E, $9F, $A0
		.BYTE  $A1, $A2, $A4, $A5
		.BYTE  $A6,   0, $A7, $A8
		.BYTE  $9D, $9E, $9F, $A3
		.BYTE  $A1, $A2, $A4, $A5
		.BYTE  $A6,   0, $A7, $A8
		.BYTE  $9F, $9E, $9D, $A2
		.BYTE  $A1, $A0, $A6, $A5
		.BYTE  $A4, $A8, $A7,	0
		.BYTE  $9F, $9E, $9D, $A2
		.BYTE  $A1, $A3, $A6, $A5
		.BYTE  $A4, $A8, $A7,	0
byte_74E67:	.BYTE	 2,   2,   2,	2
		.BYTE	 2,   2,   2,	2
		.BYTE	 2,   2,   2,	2
		.BYTE	 2,   2,   2,	2
		.BYTE	 2,   2,   2,	2
		.BYTE	 2,   2,   2,	2
		.BYTE  $42, $42, $42, $42
		.BYTE  $42, $42, $42, $42
		.BYTE  $42, $42, $42, $42
		.BYTE  $42, $42, $42, $42
		.BYTE  $42, $42, $42, $42
		.BYTE  $42, $42, $42, $42
byte_74E97:	.BYTE  $9D, $9E, $9F,	0
		.BYTE  $A0, $A1, $A2,	0
		.BYTE  $A4, $A5, $A6,	0
		.BYTE	 0, $A7, $A8,	0
		.BYTE  $9D, $9E, $9F,	0
		.BYTE  $A0, $A1, $A2,	0
		.BYTE  $A4, $A5, $A6,	0
		.BYTE	 0, $A7, $A8,	0
		.BYTE  $9D, $9E, $9F,	0
		.BYTE  $AA, $AB, $A9,	0
		.BYTE	 0, $AC, $AD,	0
		.BYTE	 0,   0,   0,	0
		.BYTE  $C8, $C9, $CA,	0
		.BYTE  $CB, $CC, $CD, $CE
		.BYTE	 0,   0,   0,	0
		.BYTE	 0,   0,   0,	0
		.BYTE  $C8, $C9, $CA,	0
		.BYTE  $CB, $CC, $CD, $CF
		.BYTE	 0,   0,   0,	0
		.BYTE	 0,   0,   0,	0
		.BYTE	 0, $9F, $9E, $9D
		.BYTE	 0, $A2, $A1, $A0
		.BYTE	 0, $A6, $A5, $A4
		.BYTE	 0, $A8, $A7,	0
		.BYTE	 0, $9F, $9E, $9D
		.BYTE	 0, $A2, $A1, $A0
		.BYTE	 0, $A6, $A5, $A4
		.BYTE	 0, $A8, $A7,	0
		.BYTE	 0, $9F, $9E, $9D
		.BYTE	 0, $A9, $AB, $AA
		.BYTE	 0, $AD, $AC,	0
		.BYTE	 0,   0,   0,	0
		.BYTE	 0, $CA, $C9, $C8
		.BYTE  $CE, $CD, $CC, $CB
		.BYTE	 0,   0,   0,	0
		.BYTE	 0,   0,   0,	0
		.BYTE	 0, $CA, $C9, $C8
		.BYTE  $CF, $CD, $CC, $CB
		.BYTE  $FF, $FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF
animals_tls_nums:.BYTE	$EC, $EE, $ED, $EF, $F0, $F2, $F1, $F3,	$E8, $EA, $E9, $EB, $F8, $FA, $F9, $FB
		.BYTE  $FC, $FE, $FD, $FF, $F4,	$F6, $F5, $F7

; =============== S U B	R O U T	I N E =======================================


draw_object_0A:
		LDA	#3
		LDY	#1
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_type,X
		CMP	#$A
		BNE	loc_75006
		LDA	#0
		STA	tmp_var_25

loc_75000:
		LDY	#0
		STY	spr_cfg_off
		BEQ	loc_7500E

loc_75006:
		LDA	#$40
		STA	tmp_var_25
		LDY	#3
		STY	spr_cfg_off

loc_7500E:
		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_7501A
		LDA	tmp_var_25
		ORA	#$80
		STA	tmp_var_25

loc_7501A:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_7501E:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7502F
@skip:
		INC	spr_cfg_off
		JMP	loc_7505F
; ---------------------------------------------------------------------------

loc_7502F:
		STA	tmp_var_2B
		LDY	#0

loc_75033:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75056
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_75982,Y
		BEQ	loc_75056
		write_tile_attr_y
		BEQ	end_draw_object_0A

loc_75056:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_75033

loc_7505F:
		LDY	spr_parts_counter2
		INY
		CPY	#1
		BCC	loc_7501E
end_draw_object_0A:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_object_0A


; =============== S U B	R O U T	I N E =======================================


draw_fire_V:
		LDA	#1
		LDY	#3
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_type,X
		CMP	#$B
		BNE	loc_75100
		LDA	#0
		STA	tmp_var_25
		LDA	#0
		STA	spr_cfg_off
		BEQ	loc_7511C

loc_75100:				; var/counter
		LDA	objects_var_cnt,X
		BPL	loc_75106
		RTS
; ---------------------------------------------------------------------------

loc_75106:
		CMP	#2
		BNE	@no_play_sfx
		LDY	#$10	; sfx: fire shot
		STY	sfx_to_play
@no_play_sfx
		AND	#$40
		BNE	loc_75114
		LDA	#$80
		STA	tmp_var_25
		LDY	#3
		STY	spr_cfg_off
		BNE	loc_7511C

loc_75114:
		LDA	#0
		STA	tmp_var_25
		LDY	#0
		STY	spr_cfg_off

loc_7511C:
		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_75128
		LDA	tmp_var_25
		ORA	#$40
		STA	tmp_var_25

loc_75128:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_7512C:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7513D
@skip:
		INC	spr_cfg_off
		JMP	loc_7516D
; ---------------------------------------------------------------------------

loc_7513D:
		STA	tmp_var_2B
		LDY	#0

loc_75141:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75164
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_7597C,Y
		BEQ	loc_75164
		write_tile_attr_y
		BEQ	end_draw_fire_V

loc_75164:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#1
		BCC	loc_75141

loc_7516D:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_7512C
end_draw_fire_V:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_fire_V


; =============== S U B	R O U T	I N E =======================================


draw_unused_spikes:
		LDA	Frame_Cnt
		AND	#$40
		BNE	loc_7517E
		RTS
; ---------------------------------------------------------------------------

loc_7517E:
		LDX	#0
		LDY	object_slot
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_var_28
		LDA	objects_X_h,Y
		SBC	camera_X_h_new
		BEQ	loc_75194
		CMP	#$FF
		BEQ	loc_751A4
		RTS
; ---------------------------------------------------------------------------

loc_75194:
		LDA	tmp_var_28

loc_75196:
		STA	tmp_x_positions,X
		INX
		CPX	#3
		BCS	loc_751C0
		CLC
		ADC	#$C
		BCC	loc_75196
		BCS	loc_751B7

loc_751A4:
		LDA	tmp_var_28
		LDY	#0

loc_751A8:
		STY	tmp_x_positions,X
		INX
		CPX	#3
		BCS	locret_751B6
		CLC
		ADC	#$C
		BCC	loc_751A8
		BCS	loc_75196

locret_751B6:
		RTS
; ---------------------------------------------------------------------------

loc_751B7:
		LDA	#0

loc_751B9:
		STA	tmp_x_positions,X
		INX
		CPX	#3
		BCC	loc_751B9

loc_751C0:
		LDX	#0
		LDY	object_slot
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	objects_Y_relative_h,Y
		ADC	sonic_y_h_on_scr ; sonic-camera
		BEQ	loc_751D6
		CMP	#$FF
		BEQ	loc_751E6
		RTS
; ---------------------------------------------------------------------------

loc_751D6:
		LDA	tmp_var_2B

loc_751D8:
		STA	tmp_y_positions,X
		INX
		CPX	#3
		BCS	loc_75202
		CLC
		ADC	#8
		BCC	loc_751D8
		BCS	loc_751F9

loc_751E6:
		LDA	tmp_var_2B
		LDY	#0

loc_751EA:
		STY	tmp_y_positions,X
		INX
		CPX	#3
		BCS	locret_751F8
		CLC
		ADC	#8
		BCC	loc_751EA
		BCS	loc_751D8

locret_751F8:
		RTS
; ---------------------------------------------------------------------------

loc_751F9:
		LDA	#0

loc_751FB:
		STA	tmp_y_positions,X
		INX
		CPX	#3
		BCC	loc_751FB

loc_75202:
		LDA	#0
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_7520A:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7521B
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_7524B
; ---------------------------------------------------------------------------

loc_7521B:
		STA	tmp_var_2B
		LDY	#0

loc_7521F:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75242
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_759A0,Y
		BEQ	loc_75242
		STA	sprites_tile,X
		LDA	#1
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_unused_spikes

loc_75242:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_7521F

loc_7524B:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_7520A
		
end_draw_unused_spikes:
		STX	sprite_id	; index	to sprites buffer
		
		LDA	chr_spr_bank2	; SPIKES: 0E (LAB?)
		CMP	#MARBLE_CHR_BANK1 ; SPIKES (MARBLE)
		BEQ	@chr_ok
		CMP	#MARBLE_CHR_BANK2 ; SPIKES (MARBLE)
		BEQ	@chr_ok
		CMP	#LAB_CHR_BANK	; SPIKES (LAB)
		BEQ	@chr_ok		
		LDA	#MARBLE_CHR_BANK1 ; SPIKES (MARBLE)
		STA	chr_spr_bank2
@chr_ok:
		RTS
; End of function draw_unused_spikes


; =============== S U B	R O U T	I N E =======================================


draw_bat:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_752EA
		LDA	#1
		STA	tmp_var_25
		LDA	#0
		STA	spr_cfg_off
		BEQ	loc_752F2

loc_752EA:
		LDA	#$41
		STA	tmp_var_25
		LDA	#$24
		STA	spr_cfg_off

loc_752F2:				; var/counter
		LDA	objects_var_cnt,X
		AND	#3
		BEQ	loc_75308
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#7
		TAX
		LDA	byte_75363,X
		CLC
		ADC	spr_cfg_off
		STA	spr_cfg_off

loc_75308:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_7530C:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7531D
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_75354
; ---------------------------------------------------------------------------

loc_7531D:
		STA	tmp_var_2B
		LDY	#0

loc_75321:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7534B
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_759F9,Y
		BEQ	loc_7534B
		write_tile_attr_y
		BEQ	end_draw_bat

loc_7534B:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_75321

loc_75354:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_7530C
		
end_draw_bat:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id	; index	to sprites buffer
		LDA	level_spr_chr2_nx
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret
		RTS
; End of function draw_bat

; ---------------------------------------------------------------------------
byte_75363:	.BYTE	 9,   9, $12, $12, $1B,	$1B, $12, $12

; =============== S U B	R O U T	I N E =======================================


draw_object_29:
		LDA	#4
		LDY	#2
		JSR	pos_for_draw_object

		LDA	#0
		STA	spr_cfg_off
		LDA	#3
		STA	tmp_var_25
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_753FB:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7540C
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#4
		STA	spr_cfg_off
		JMP	loc_7543C
; ---------------------------------------------------------------------------

loc_7540C:
		STA	tmp_var_2B
		LDY	#0

loc_75410:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75433
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_759A9,Y
		BEQ	loc_75433
		write_tile_attr_y
		BEQ	end_draw_object_29

loc_75433:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_75410

loc_7543C:
		LDA	#$81
		STA	tmp_var_25
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_753FB
end_draw_object_29:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_object_29


; =============== S U B	R O U T	I N E =======================================


draw_caterpillar:
		LDA	#6
		LDY	#3
		JSR	pos_for_draw_object
		
		LDY	#0
		LDA	Frame_Cnt
		AND	#$20
		BNE	loc_754D8
		LDY	#$12

loc_754D8:
		STY	spr_cfg_off
		LDA	#2
		STA	tmp_var_25
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_754F0
		LDA	spr_cfg_off
		CLC
		ADC	#$24
		STA	spr_cfg_off
		LDA	#$42
		STA	tmp_var_25

loc_754F0:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_754F4:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_75505
@skip:		
		LDA	spr_cfg_off
		CLC
		ADC	#6
		STA	spr_cfg_off
		JMP	loc_7553C
; ---------------------------------------------------------------------------

loc_75505:
		STA	tmp_var_2B
		LDY	#0

loc_75509:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75533
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	caterpillar_tls_nums,Y
		BEQ	loc_75533
		write_tile_attr_y
		BEQ	end_draw_caterkiller

loc_75533:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#6
		BCC	loc_75509

loc_7553C:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_754F4
		
end_draw_caterkiller:
		CPX	sprite_id
		BEQ	ret_caterkiller_spr
		STX	sprite_id
		
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	set_marble_chr1_or_2
		JMP	set_sbz_chr1_or_2

set_marble_chr1_or_2:
		LDA	chr_spr_bank2	; Caterpillar (Marble)
		CMP	#MARBLE_CHR_BANK1 ; Caterpillar+Wasp (Marble)
		BEQ	ret_caterkiller_spr
		CMP	#MARBLE_CHR_BANK2 ; Caterpillar+Bat (Marble)
		BEQ	ret_caterkiller_spr
		LDA	#MARBLE_CHR_BANK1 ; Caterpillar+Wasp (Marble)
		STA	chr_spr_bank2
ret_caterkiller_spr
		RTS
; End of function draw_caterpillar


; =============== S U B	R O U T	I N E =======================================


draw_object_20:
		LDA	objects_var_cnt,X ; var/counter
		BNE	loc_7554E
		RTS
; ---------------------------------------------------------------------------

loc_7554E:
		LDA	#3
		LDY	#1
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_type,X
		CMP	#$22
		BCC	loc_755E5
		LDA	#3
		STA	spr_cfg_off
		LDA	#$41
		STA	tmp_var_25
		BNE	loc_755ED

loc_755E5:
		LDA	#0
		STA	spr_cfg_off
		LDA	#1
		STA	tmp_var_25

loc_755ED:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_755F1:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_75602
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_75632
; ---------------------------------------------------------------------------

loc_75602:
		STA	tmp_var_2B
		LDY	#0

loc_75606:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75629
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_75988,Y
		BEQ	loc_75629
		write_tile_attr_y
		BEQ	end_draw_spikes1

loc_75629:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_75606

loc_75632:
		LDY	spr_parts_counter2
		INY
		CPY	#1
		BCC	loc_755F1
end_draw_spikes1:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		JMP	set_marble_chr1_or_2
@ret		
		RTS
; End of function draw_object_20


; =============== S U B	R O U T	I N E =======================================


draw_object_24:
		LDA	objects_var_cnt,X ; var/counter
		BNE	loc_75644
		RTS
; ---------------------------------------------------------------------------

loc_75644:
		LDA	#3
		LDY	#3
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_type,X
		CMP	#$26
		BCC	loc_756DB
		LDA	#9
		STA	spr_cfg_off
		LDA	#$41
		STA	tmp_var_25
		BNE	loc_756E3

loc_756DB:
		LDA	#0
		STA	spr_cfg_off
		LDA	#1
		STA	tmp_var_25

loc_756E3:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_756E7:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_756F8
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_75728
; ---------------------------------------------------------------------------

loc_756F8:
		STA	tmp_var_2B
		LDY	#0

loc_756FC:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7571F
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_7598E,Y
		BEQ	loc_7571F
		write_tile_attr_y
		BEQ	end_draw_spikes2

loc_7571F:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_756FC

loc_75728:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_756E7
end_draw_spikes2:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		JMP	set_marble_chr1_or_2
@ret		
		RTS
; End of function draw_object_24


; =============== S U B	R O U T	I N E =======================================


draw_object_30:
		LDA	#4
		LDY	#4
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BMI	loc_757C8
		LDA	#$42
		STA	tmp_var_25
		LDA	#$30
		STA	spr_cfg_off
		JMP	loc_757D0
; ---------------------------------------------------------------------------

loc_757C8:
		LDA	#2
		STA	tmp_var_25
		LDA	#0
		STA	spr_cfg_off

loc_757D0:
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	byte_7583B,Y
		CLC
		ADC	spr_cfg_off
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_757E4:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_757F5
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#4
		STA	spr_cfg_off
		JMP	loc_7582C
; ---------------------------------------------------------------------------

loc_757F5:
		STA	tmp_var_2B
		LDY	#0

loc_757F9:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75823
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_75A41,Y
		BEQ	loc_75823
		write_tile_attr_y
		BEQ	end_draw_spiked_badnik

loc_75823:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_757F9

loc_7582C:
		LDY	spr_parts_counter2
		INY
		CPY	#4
		BCC	loc_757E4

end_draw_spiked_badnik:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		LDA	#SPRING_CHR_BANK2
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret		
		RTS
; End of function draw_object_30

; ---------------------------------------------------------------------------
byte_7583B:	.BYTE	 0, $10, $20, $10

; =============== S U B	R O U T	I N E =======================================


draw_fire_on_ground:
		LDA	objects_var_cnt,X ; var/counter
		BNE	loc_75847
		RTS
; ---------------------------------------------------------------------------

loc_75847:
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#7
		TAY
		INY
		STY	tmp_var_25 ; limit_X
		STY	tmp_var_26
		TYA
		LDY	#3
		JSR	pos_for_draw_object

		LDA	Frame_Cnt
		AND	#3
		ASL	A
		TAY
		LDA	byte_75944,Y
		STA	spr_cfg_off
		STA	tmp_var_29
		LDA	byte_75945,Y
		STA	tmp_var_25
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_758EE:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	loc_75937
		CMP	#$E8
		BCS	loc_75937
; ---------------------------------------------------------------------------

loc_758F8:
		STA	tmp_var_2B
		LDA	byte_75941,Y
		CLC
		ADC	tmp_var_29
		STA	spr_cfg_off
		LDY	#0

loc_75904:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7592E
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_7594C,Y
		BEQ	loc_7592E
		write_tile_attr_y
		BEQ	end_draw_gnd_fire

loc_7592E:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	tmp_var_26
		BCC	loc_75904

loc_75937:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_758EE
		
end_draw_gnd_fire:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id	; index	to sprites buffer
		LDX	object_slot
		LDA	objects_var_cnt,X
		CMP	#4
		BEQ	@play_fire_gnd_sfx
		CMP	#2
		BNE	@ret
@play_fire_gnd_sfx:
		LDA	#$1A	; SFX: FIRE POINT
		STA	sfx_to_play
@ret
		RTS
; End of function draw_fire_on_ground

; ---------------------------------------------------------------------------
byte_75941:	.BYTE	 0,   8, $10
byte_75944:	.BYTE 0
byte_75945:	.BYTE 0
		.BYTE  $18,   0
		.BYTE	 0, $40
		.BYTE  $18, $40
byte_7594C:	.BYTE  $AB,   0, $AB,	0, $AB,	  0, $AB,   0
		.BYTE  $AC,   0, $AC,	0, $AC,	  0, $AC,   0
		.BYTE  $AD,   0, $AD,	0, $AD,	  0, $AD,   0
		.BYTE	 0, $AB,   0, $AB,   0,	$AB,   0, $AB
		.BYTE	 0, $AC,   0, $AC,   0,	$AC,   0, $AC
		.BYTE	 0, $AD,   0, $AD,   0,	$AD,   0, $AD
byte_7597C:	.BYTE  $AB, $AC, $AD, $AD, $AC,	$AB
byte_75982:	.BYTE  $AE, $AF, $B0, $B0, $AF,	$AE
byte_75988:	.BYTE  $B1, $B2, $B3, $B3, $B2,	$B1
byte_7598E:	.BYTE  $B1, $B2, $B3, $B1, $B2,	$B3, $B1, $B2
		.BYTE  $B3, $B3, $B2, $B1, $B3,	$B2, $B1, $B3
		.BYTE  $B2, $B1
byte_759A0:	.BYTE  $B4, $B4, $B4, $B5, $B5,	$B5, $B6, $B6
		.BYTE  $B6
byte_759A9:	.BYTE  $97, $98, $97, $98, $97,	$98, $97, $98

caterpillar_tls_nums:
		.BYTE  $B7, $B8, $B9, $BA,   0,	  0 ; frame1
		.BYTE  $BB, $BC, $BD, $BE, $BF,	  0
		.BYTE  $C0, $C1, $C2, $C3, $C4,	  0
		
		.BYTE    0,   0,   0,	0,   0,	  0 ; frame2
		.BYTE  $B7, $C5, $C6, $C7, $C8,	$C9
		.BYTE  $CA, $CB, $CC, $CD, $CE,	$CF
		
		.BYTE    0,   0, $BA, $B9, $B8,	$B7 ; frame1-hflip
		.BYTE    0, $BF, $BE, $BD, $BC,	$BB
		.BYTE    0, $C4, $C3, $C2, $C1,	$C0
		
		.BYTE    0,   0,   0,	0,   0,	  0 ; frame2-hflip
		.BYTE  $C9, $C8, $C7, $C6, $C5,	$B7
		.BYTE  $CF, $CE, $CD, $CC, $CB,	$CA
		
		
byte_759F9:	.BYTE  $88, $89,   0, $8A, $8B,	  0, $8C, $8D
		.BYTE	 0, $80, $81, $82, $83,	$84, $85, $86
		.BYTE  $87,   0,   0, $9A, $9B,	$9C, $9D, $9E
		.BYTE  $9F, $A0,   0, $8E, $8F,	  0, $90, $91
		.BYTE  $92, $93, $94, $95,   0,	$89, $88,   0
		.BYTE  $8B, $8A,   0, $8D, $8C,	$82, $81, $80
		.BYTE  $85, $84, $83,	0, $87,	$86, $9B, $9A
		.BYTE	 0, $9E, $9D, $9C,   0,	$A0, $9F,   0
		.BYTE  $8F, $8E, $92, $91, $90,	$95, $94, $93
byte_75A41:	.BYTE	 0, $AD, $AE, $AF,   0,	$B0, $B1, $B2
		.BYTE  $B3, $B4, $B5, $B6,   0,	$B7, $B8, $B9
		.BYTE	 0, $AD, $AE, $AF,   0,	$B0, $BA, $B2
		.BYTE  $BB, $BC, $BD, $B6, $BE,	$BF, $C0, $C1
		.BYTE	 0, $AD, $AE, $AF,   0,	$C2, $C3, $B2
		.BYTE	 0, $C4, $C5, $B6,   0,	$C6, $C7, $B9
		.BYTE  $AF, $AE, $AD,	0, $B2,	$B1, $B0,   0
		.BYTE  $B6, $B5, $B4, $B3, $B9,	$B8, $B7,   0
		.BYTE  $AF, $AE, $AD,	0, $B2,	$BA, $B0,   0
		.BYTE  $B6, $BD, $BC, $BB, $C1,	$C0, $BF, $BE
		.BYTE  $AF, $AE, $AD,	0, $B2,	$C3, $C2,   0
		.BYTE  $B6, $C5, $C4,	0, $B9,	$C7, $C6,   0

; =============== S U B	R O U T	I N E =======================================


draw_big_spike_UD:
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BEQ	draw_steam_roller
		
draw_big_spike:
		;LDA	#2 ; attr
		LDX	#$9D ; base tile number
		LDY	#8 ; spr cfg num
		JSR	draw_sprite_new_attr0
		BEQ	no_draw_big_spike
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	set_spring_chr1_or2
		LDA	#SBZ_CHR_BANK4
		STA	chr_spr_bank2
		RTS
		
set_spring_chr1_or2:
		LDA	chr_spr_bank2	; BIG SPIKES (SPRING)
		CMP	#SPRING_CHR_BANK1
		BEQ	@chr_ok
		CMP	#SPRING_CHR_BANK2
		BEQ	@chr_ok
		LDA	#SPRING_CHR_BANK1
		STA	chr_spr_bank2
@chr_ok:
no_draw_big_spike:
		RTS
; End of function draw_big_spike


; =============== S U B	R O U T	I N E =======================================


draw_steam_roller:
		LDA	#0 ; attr
		LDX	#$82 ; base tile number
		LDY	#9 ; spr cfg num
		JSR	draw_sprite_new	
		BEQ	@no_sprites
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK2
		BEQ	@chr_ok
		CMP	#SBZ_CHR_BANK3
		BEQ	@chr_ok
		CMP	#SBZ_CHR_BANK3a
		BEQ	@chr_ok
		LDA	#SBZ_CHR_BANK2
		STA	chr_spr_bank2
@chr_ok:
@no_sprites:
		RTS


; =============== S U B	R O U T	I N E =======================================

; $6F
draw_sbz_platform:
		;LDA	#0 ; attr
		;LDX	#0 ; base tile number
		LDY	#10 ; spr cfg num
		LDA	objects_var_cnt,X
		CMP	#80
		BCC	@normal
		CMP	#80+22+80
		BCS	@normal
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		CLC
		ADC	#10
		TAY
@normal
		JSR	draw_sprite_new_tile0_attr0
		BNE	set_sbz_chr1_or2
		RTS


; =============== S U B	R O U T	I N E =======================================


; $70
draw_sbz_platform2:
		LDY	#10 ; spr cfg num
		;LDA	objects_var_cnt,X
		LDA	Frame_Cnt
		AND	#$3F
		CMP	#$20
		BCC	@normal
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		AND	#3
		CLC
		ADC	#10
		TAY
@normal		
		JSR	draw_sprite_new_tile0_attr0
		BEQ	no_sbz_plaform_sprites
set_sbz_chr1_or2:
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK1
		BEQ	@ok
		CMP	#SBZ_CHR_BANK2
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3a
		BEQ	@ok
		LDA	#SBZ_CHR_BANK2
		STA	chr_spr_bank2
@ok
no_sbz_plaform_sprites:
		RTS


; =============== S U B	R O U T	I N E =======================================

; $71
draw_wall:
		LDA	#2
		LDY	#8
		JSR	pos_for_draw_object
		
		LDY	#0
		LDX	object_slot
		LDA	objects_var_cnt,x
		LDX	#0
		CMP	#100
		BCC	@clr5
		SBC	#100
		LSR	A
		LSR	A
		LSR	A
		BEQ	@clr5
		CMP	#2
		BCC	@clr4
		BEQ	@clr3
		CMP	#4
		BCC	@clr2
		BEQ	@clr1
		BCS	@skip

@clr5
		STY	tmp_y_positions+4
		INX
@clr4
		STY	tmp_y_positions+3
		INX
@clr3
		STY	tmp_y_positions+2
		INX
@clr2
		STY	tmp_y_positions+1
		INX
@clr1
		STY	tmp_y_positions+0
		INX
@skip
		STX	tmp_var_2B

		LDX	sprite_id

		LDY	#2*8-1
		STY	spr_cfg_off
		LDY	#9-1 ; y
		STY	spr_parts_counter
@loop_y:
		LDY	#2-1 ; x
		STY	spr_parts_counter2

@loop_x:
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_X,X
		
		LDY	spr_parts_counter
		CPY	#8
		BCC	@ok
		DEY
@ok		
		LDA	tmp_y_positions,Y
		BEQ	@skip_spr_part
		BCC	@ok2
		ADC	#7
		STA	sprites_Y,X
		LDA	#$9D
		STA	sprites_tile,X
		LDA	#0
		BEQ	@no_r
		
@ok2
		STA	sprites_Y,X
		
		LDA	#$9E
		STA	sprites_tile,X
		
		LDA	#$01
		LDY	spr_parts_counter
		CPY	tmp_var_2B
		BNE	@not_first_spr
		LDA	#$21
@not_first_spr
		LDY	spr_parts_counter2
		BEQ	@no_r
		EOR	#$40
@no_r
		STA	sprites_attr,X
		INX4
		BEQ	@end_draw_wall
		
@skip_spr_part:
		DEC	spr_parts_counter2
		BPL	@loop_x
		DEC	spr_parts_counter
		BPL	@loop_y
@end_draw_wall:
		CPX	sprite_id
		BEQ	@no_draw_wall
		STX	sprite_id
		JMP	set_sbz_chr1_or2
@no_draw_wall:
		RTS



; =============== S U B	R O U T	I N E =======================================

; $72
draw_long_mesh_block:
		LDX	#0
		LDY	object_slot
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_var_28
		LDA	objects_X_h,Y
		SBC	camera_X_h_new
		BEQ	loc_75C70
		CMP	#$FF
		BEQ	loc_75C80
		RTS
; ---------------------------------------------------------------------------

loc_75C70:
		LDA	tmp_var_28

loc_75C72:
		STA	tmp_x_positions,X
		INX
		CPX	#12
		BCS	loc_75C9C
		;CLC
		ADC	#8
		BCC	loc_75C72
		BCS	loc_75C93

loc_75C80:
		LDA	tmp_var_28
		LDY	#0

loc_75C84:
		STY	tmp_x_positions,X
		INX
		CPX	#12
		BCS	locret_75C92
		;CLC
		ADC	#8
		BCC	loc_75C84
		BCS	loc_75C72

locret_75C92:
		RTS
; ---------------------------------------------------------------------------

loc_75C93:
		LDA	#0

loc_75C95:
		STA	tmp_x_positions,X
		INX
		CPX	#12
		BCC	loc_75C95

loc_75C9C:
		LDX	#0
		LDY	object_slot
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	objects_Y_relative_h,Y
		ADC	sonic_y_h_on_scr ; sonic-camera
		BEQ	loc_75CB2
		CMP	#$FF
		BEQ	loc_75CC2
		RTS
; ---------------------------------------------------------------------------

loc_75CB2:
		LDA	tmp_var_2B

loc_75CB4:
		STA	tmp_y_positions+4,X
		INX
		CPX	#3
		BCS	loc_75CDE
		;CLC
		ADC	#8
		BCC	loc_75CB4
		BCS	loc_75CD5

loc_75CC2:
		LDA	tmp_var_2B
		LDY	#0

loc_75CC6:
		STY	tmp_y_positions+4,X
		INX
		CPX	#3
		BCS	locret_75CD4
		;CLC
		ADC	#8
		BCC	loc_75CC6
		BCS	loc_75CB4

locret_75CD4:
		RTS
; ---------------------------------------------------------------------------

loc_75CD5:
		LDA	#0

loc_75CD7:
		STA	tmp_y_positions+4,X
		INX
		CPX	#3
		BCC	loc_75CD7

loc_75CDE:
		LDY	#0
		LDX	object_slot
		LDA	objects_var_cnt,X
		LDX	#11
		CMP	#16+8
		BCC	@clr_all
		SBC	#16+8
		CMP	#32
		BCC	@chk1
		SBC	#48+8
		CMP	#32
		BCS	@no_clr
		EOR	#$1F
@chk1		
		LSR	A
		LSR	A
		LSR	A
		BEQ	@clr_3
		CMP	#2
		BCC	@clr_2
		BEQ	@clr_1
		BNE	@no_clr
@clr_all
		DEX
		STY	tmp_x_positions+8
@clr_3
		DEX
		STY	tmp_x_positions+9
@clr_2
		DEX
		STY	tmp_x_positions+10
@clr_1
		DEX
		STY	tmp_x_positions+11
@no_clr
		STX	tmp_var_2B

		LDX	sprite_id
		LDA	Frame_Cnt
		LSR	A
		BCC	draw_long_mesh_block_even

		LDY	#12*3-1
		STY	spr_cfg_off
		LDY	#3-1
		STY	spr_parts_counter
@loop_y:
		LDY	#12-1
		STY	spr_parts_counter2
		
@loop_x:
		LDY	spr_cfg_off
		LDA	mesh_block_tls_nums,Y
		BEQ	@skip_spr_part
		STA	sprites_tile,X
		
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_X,X
		
		LDY	spr_parts_counter
		LDA	tmp_y_positions+4,Y
		BEQ	@skip_spr_part
		STA	sprites_Y,X
		
		LDA	#$00
		LDY	spr_parts_counter2
		CPY	tmp_var_2B
		BNE	@not_last_spr
		LDA	#$20
@not_last_spr
		STA	sprites_attr,X
		INX4
		BEQ	done_draw_mesh_block
		
@skip_spr_part:
		DEC	spr_cfg_off
		DEC	spr_parts_counter2
		BPL	@loop_x
		DEC	spr_parts_counter
		BPL	@loop_y
		BMI	done_draw_mesh_block
; ---------------------------------------------------------------------------

draw_long_mesh_block_even:
		LDY	#0
		STY	spr_cfg_off
		;LDY	#0
		STY	spr_parts_counter
@loop_y:
		LDY	#0
		STY	spr_parts_counter2
		
@loop_x:
		LDY	spr_cfg_off
		LDA	mesh_block_tls_nums,Y
		BEQ	@skip_spr_part
		STA	sprites_tile,X
		
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_X,X
		
		LDY	spr_parts_counter
		LDA	tmp_y_positions+4,Y
		BEQ	@skip_spr_part
		STA	sprites_Y,X
		
		LDA	#$00
		LDY	spr_parts_counter2
		CPY	tmp_var_2B
		BNE	@not_last_spr
		LDA	#$20
@not_last_spr
		STA	sprites_attr,X
		INX4
		BEQ	done_draw_mesh_block
		
@skip_spr_part:
		INC	spr_cfg_off
		INC	spr_parts_counter2
		LDY	spr_parts_counter2
		CPY	#12
		BCC	@loop_x
		INC	spr_parts_counter
		LDY	spr_parts_counter
		CPY	#3
		BCC	@loop_y

done_draw_mesh_block:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		LDA	#SBZ_CHR_BANK2
		STA	chr_spr_bank2
@ret:
		RTS


mesh_block_tls_nums:
		.BYTE	$91,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93
		.BYTE	$91,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90
		.BYTE	$91,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93


; =============== S U B	R O U T	I N E =======================================

; $73
draw_circular_saw:
		LDA	objects_var_cnt,X
		AND	#$7F
		CMP	#2
		BCC	@no_spr
		LDY	#24 ; full
		LDA	objects_var_cnt,X
		BPL	@ok
		LDY	#19 ; no last line
@ok:
;		LDX	#$C0	; anim1
;		LDA	Frame_Cnt
;		AND	#2
;		BEQ	@anim1
;		LDX	#$B0	; anim2
;@anim1
		LDX	#$C0 ; $C1-$CF
		JMP	DRAW_CIRC_SAW
@no_spr:
		RTS


; =============== S U B	R O U T	I N E =======================================

; $77
draw_circular_saw3a:
		LDY	#32
		LDA	Frame_Cnt
		LSR	A
		BCC	@up_part
		INY	; 33
@up_part:
		LDA	#$01	; ATTRIBUTES
		LDX	#$B5 ; tiles: $B7-$BF
		JMP	DRAW_CIRC_SAW_

; $76
draw_circular_saw3:
		LDY	#32
		LDA	Frame_Cnt
		LSR	A
		BCC	@up_part
		INY	; 33
		;NOP
@up_part:
;		LDX	#$80	; anim1
;		LDA	Frame_Cnt
;		AND	#2
;		BEQ	@anim1
;		LDX	#$90	; anim2
;@anim1
		LDX	#$B5 ; tiles: $B7-$BF
		JMP	DRAW_CIRC_SAW

; $75
draw_circular_saw2a:
		LDY	#30
		.BYTE	$2C
; $74
draw_circular_saw2:
		LDY	#24	; spr order1
;		LDA	Frame_Cnt
;		AND	#2
;		BEQ	@spr_order1
;		LDY	#30	; spr order2
;@spr_order1

		LDA	Frame_Cnt
		LSR	A
;		LDA	objects_var_cnt,X
;		BPL	@lr_move
;		LDY	#30
;		BCC	@left_part
;		INY	; 31
;		BNE	@up_part ; JMP
;		
;@lr_move
;		LDY	#24
		BCC	@up_part
		INY	; 25
@left_part:
@up_part
;		LDX	#$C0	; anim1
;		LDA	Frame_Cnt
;		AND	#2
;		BEQ	@anim1
;		LDX	#$B0	; anim2
;@anim1
		LDX	#$C0 ; tiles: $B7-$BF
		
DRAW_CIRC_SAW:
		LDA	#$21	; ATTRIBUTES
DRAW_CIRC_SAW_:
		JSR	draw_sprite_new
		BEQ	no_saw_spr

		LDA	Frame_Cnt
		AND	#3
		BNE	@no_saw_sfx
		LDA	#$14
		STA	sfx_to_play
@no_saw_sfx:

set_saw_chr:
		LDY	#SBZ_CHR_BANK3
		LDA	Frame_Cnt
		AND	#2
		BEQ	@anim1
		LDY	#SBZ_CHR_BANK3a
@anim1
		STY	chr_spr_bank2
		
no_saw_spr
		RTS


; =============== S U B	R O U T	I N E =======================================

; $7F
draw_checkpoint:
		LDY	#16
		JSR	draw_sprite_new_tile0_attr0

		LDX	object_slot
		LDA	#1 ; blue
		LDY	objects_var_cnt,X
		BEQ	@draw_1
		DEY
		TYA
		AND	#$F
		TAY
		
		LDA	#0 ; red
		STA	tmp_var_2B
		LDA	checkpt_anim_tbl_x,Y
		BPL	@add_
		DEC	tmp_var_2B
@add_
		CLC
		ADC	objects_X_l,X
		STA	tmp_var_27
		LDA	objects_X_h,X
		ADC	tmp_var_2B
		STA	tmp_var_28
		
		LDA	objects_Y_relative_l,X
		CLC
		ADC	checkpt_anim_tbl_y,Y
		STA	objects_Y_relative_l,X
		BCC	@no_inc_h
		INC	objects_Y_relative_h,X
@no_inc_h
	
		LDA	#0 ; red
		LDX	#0
		LDY	#18
		JSR	draw_sprite_new_X
		RTS
@draw_1:
		LDX	#0
		LDY	#18
		JSR	draw_sprite_new
		RTS
		
checkpt_anim_tbl_x:
		.BYTE	$FB,$F7,$F4,$F4
		.BYTE	$F4,$F7,$FB,$00
		
		.BYTE	$05,$09,$0C,$0C
		.BYTE	$0C,$09,$05,$00
checkpt_anim_tbl_y:
		.BYTE	$00,$03,$07,$0C
		.BYTE	$10,$14,$17,$18
		
		.BYTE	$17,$14,$10,$0C
		.BYTE	$07,$03,$00,$00


; =============== S U B	R O U T	I N E =======================================


; $33, $3E
draw_small_spike:
		LDY	objects_type,X
		LDX	#$C6	; spring?
		CPY	#$33
		BEQ	@spring_yard_spike
		LDX	#$8C	; lab?

@spring_yard_spike:
		LDA	#2 ; attr
		LDY	#17 ; spr cfg num
		JSR	draw_sprite_new
		BEQ	@ret
		
		LDA	chr_spr_bank2
		CMP	#SPRING_CHR_BANK1
		BEQ	@chr_ok
		CMP	#SPRING_CHR_BANK2
		BEQ	@chr_ok
		CMP	#LAB_CHR_BANK
		BEQ	@chr_ok
		LDA	#LAB_CHR_BANK
		STA	chr_spr_bank2
@chr_ok:
@ret:
		RTS
; End of function draw_small_spike


; =============== S U B	R O U T	I N E =======================================

; $40
draw_object_labfish:
		LDA	#5
		LDY	#3
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_75CF0
		LDA	#0
		;STA	spr_cfg_off
		LDY	#2
		;STA	tmp_var_25
		BNE	loc_75CF8  ; JMP
; ---------------------------------------------------------------------------

loc_75CF0:
		LDA	#$1E
		;STA	spr_cfg_off
		LDY	#$42
		;STA	tmp_var_25

loc_75CF8:
		STA	spr_cfg_off
		STY	tmp_var_25

		LDA	Frame_Cnt
		AND	#$10
		BEQ	loc_75D05
		LDA	spr_cfg_off
		CLC
		ADC	#$F
		STA	spr_cfg_off

loc_75D05:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_75D09:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_75D1A
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#5
		STA	spr_cfg_off
		JMP	loc_75D51
; ---------------------------------------------------------------------------

loc_75D1A:
		STA	tmp_var_2B
		LDY	#0

loc_75D1E:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_75D48
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	labfish_tls_nums,Y
		BEQ	loc_75D48
		write_tile_attr_y
		BEQ	end_draw_labfish

loc_75D48:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#5
		BCC	loc_75D1E

loc_75D51:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_75D09
		
end_draw_labfish
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id	; index	to sprites buffer
		LDA	#LAB_CHR_BANK
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret
		RTS
; End of function draw_object_labfish

; ---------------------------------------------------------------------------
labfish_tls_nums:
		.BYTE  $80, $82, $88,	0,   0,	$81, $83, $89, $8B, $8A, $85, $86, $BF,	  0,   0, $80
		.BYTE  $82, $88,   0,	0, $81,	$83, $89, $8A,	 0, $84, $87, $BF,   0,	  0,   0,   0
		.BYTE  $88, $82, $80, $8A, $8B,	$89, $83, $81,	 0,   0, $BF, $86, $85,	  0,   0, $88
		.BYTE  $82, $80,   0, $8A, $89,	$83, $81,   0,	 0, $BF, $87, $84


; =============== S U B	R O U T	I N E =======================================


draw_small_air_bubble:
		LDA	#$C4
		LDY	objects_type,X
		CPY	#$46
		BEQ	@type1
		LDA	#$C5

@type1:
		LDY	#1
		BNE	draw_single_sprite


; =============== S U B	R O U T	I N E =======================================


draw_object_48:
		LDA	#$9F
		LDY	#1
;		BNE	draw_single_sprite


; =============== S U B	R O U T	I N E =======================================


;draw_garg_projectile:
;		LDY	#1
;		LDA	objects_var_cnt,X ; var/counter
;		BPL	@no_mirr
;		LDY	#$41
;
;@no_mirr:
;		LDA	#$9A

draw_single_sprite:
		STA	spr_cfg_off ; TILE
		STY	tmp_var_25 ; ATTR
		JSR	draw_single_sprite_pos
		LDA	spr_cfg_off
		STA	sprites_tile,Y
		LDA	tmp_var_25
		STA	sprites_attr,Y
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_large_air_bubble:
		LDA	objects_var_cnt,X ; var/counter
		CMP	#$7A
		BCS	@large
		LDA	#$C5
		LDY	#1
		BNE	draw_single_sprite
; ---------------------------------------------------------------------------

@large:
		LDA	#1 ; attr
		LDX	#$C0 ; base tile number
		LDY	#26 ; spr cfg num
		JSR	draw_sprite_new
		BEQ	@ret
		LDA	#LAB_CHR_BANK
		STA	chr_spr_bank2	; enemy	sprites	bank
@ret:
		RTS
; End of function draw_large_air_bubble


; =============== S U B	R O U T	I N E =======================================


draw_garg_projectile:
;		LDY	#1
;		LDA	objects_var_cnt,X ; var/counter
;		BPL	@no_mirr
;		LDY	#$41
;
;@no_mirr:
;		LDA	#$9A

		LDY	#57
		LDA	objects_var_cnt,X ; var/counter
		BPL	@no_mirr
		INY
@no_mirr:
		LDX	#0	; base tile
		LDA	Frame_Cnt
		;LSR	A
		;LSR	A
		LSR	A
		LSR	A
		
		LDA	#$00	; attr
		BCC	@c1
		LDA	#$80	; V-mirror
@c1
		JSR	draw_sprite_new
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_object_47:
		LDY	object_slot
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_x_positions
		STA	tmp_x_positions+2
		LDA	objects_X_h,Y
		SBC	camera_X_h_new
		STA	tmp_x_positions+3
		BEQ	loc_75F82
		CMP	#$FF
		BEQ	loc_75F92
		RTS
; ---------------------------------------------------------------------------

loc_75F82:
		LDA	tmp_x_positions
		CLC
		ADC	#8
		STA	tmp_x_positions+1
		BCC	loc_75FA1
		LDA	#0
		STA	tmp_x_positions+1
		JMP	loc_75FA1
; ---------------------------------------------------------------------------

loc_75F92:
		LDA	tmp_x_positions
		CLC
		ADC	#8
		BCS	loc_75F9B
		LDA	#0

loc_75F9B:
		STA	tmp_x_positions+1
		LDA	#0
		STA	tmp_x_positions

loc_75FA1:
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_y_positions
		STA	tmp_y_positions+2
		LDA	objects_Y_relative_h,Y
		;ADC	#0
		ADC	sonic_y_h_on_scr
		STA	tmp_y_positions+3
		BEQ	loc_75FB7
		CMP	#$FF
		BEQ	loc_75FC7
		RTS
; ---------------------------------------------------------------------------

loc_75FB7:
		LDA	tmp_y_positions
		CLC
		ADC	#8
		STA	tmp_y_positions+1
		BCC	loc_75FD6
		LDA	#0
		STA	tmp_y_positions+1
		JMP	loc_75FD6
; ---------------------------------------------------------------------------

loc_75FC7:
		LDA	tmp_y_positions
		CLC
		ADC	#8
		BCS	loc_75FD0
		LDA	#0

loc_75FD0:
		STA	tmp_y_positions+1
		LDA	#0
		STA	tmp_y_positions

loc_75FD6:
		LDA	tmp_x_positions+2
		SEC
		SBC	#8
		STA	tmp_x_positions+2
		BCS	loc_75FE1
		DEC	tmp_x_positions+3

loc_75FE1:
		LDA	tmp_y_positions+2
		SEC
		SBC	#8
		STA	tmp_y_positions+2
		BCS	loc_75FEC
		DEC	tmp_y_positions+3

loc_75FEC:
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+4
		LDA	tmp_x_positions+3

loc_75FFF:
		ADC	#0
		BEQ	loc_76009
		LDA	#0
		STA	tmp_x_positions+4
		BEQ	loc_7601B

loc_76009:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y

loc_7600F:
		STA	tmp_y_positions+4
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_7601B
		LDA	#0
		STA	tmp_y_positions+4

loc_7601B:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+5
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76036
		LDA	#0
		STA	tmp_x_positions+5
		BEQ	loc_76048

loc_76036:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+5
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_76048
		LDA	#0
		STA	tmp_y_positions+5

loc_76048:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+6
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76063
		LDA	#0
		STA	tmp_x_positions+6
		BEQ	loc_76075

loc_76063:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+6
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_76075
		LDA	#0
		STA	tmp_y_positions+6

loc_76075:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+7
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76090
		LDA	#0
		STA	tmp_x_positions+7
		BEQ	loc_760A2

loc_76090:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+7
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_760A2
		LDA	#0
		STA	tmp_y_positions+7

loc_760A2:
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_760B1
		LDA	#$40
		STA	tmp_var_25
		LDA	#4
		BNE	loc_760B7

loc_760B1:
		LDA	#0
		STA	tmp_var_25
		LDA	#0

loc_760B7:
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_760BD:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_760CE
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_760FB
; ---------------------------------------------------------------------------

loc_760CE:
		STA	tmp_var_2B
		LDY	#0

loc_760D2:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_760F2
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	object_3F_tls,Y
		write_tile_attr_y

loc_760F2:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_760D2

loc_760FB:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_760BD
		
		LDY	object_slot
		LDA	objects_var_cnt,Y
		AND	#1
		BNE	loc_76127
		LDA	tmp_x_positions+4
		BEQ	loc_76127
		STA	sprites_X,X
		LDA	tmp_y_positions+4
		BEQ	loc_76127
		JSR	write_satellite_sprite

loc_76127:
		LDA	objects_var_cnt,Y
		AND	#2
		BNE	loc_7614A
		LDA	tmp_x_positions+5
		BEQ	loc_7614A
		STA	sprites_X,X
		LDA	tmp_y_positions+5
		BEQ	loc_7614A
		JSR	write_satellite_sprite

loc_7614A:
		LDA	objects_var_cnt,Y
		AND	#4
		BNE	loc_7616F
		LDA	tmp_x_positions+6
		BEQ	loc_7616F
		STA	sprites_X,X
		LDA	tmp_y_positions+6
		BEQ	loc_7616F
		JSR	write_satellite_sprite

loc_7616F:
		LDA	objects_var_cnt,Y
		AND	#8
		BNE	loc_76194
		LDA	tmp_x_positions+7
		BEQ	loc_76194
		STA	sprites_X,X
		LDA	tmp_y_positions+7
		BEQ	loc_76194
		JSR	write_satellite_sprite

loc_76194:
		STX	sprite_id
		RTS
; End of function draw_object_47

write_satellite_sprite
		STA	sprites_Y,X
		LDA	#$9F
		STA	sprites_tile,X
		LDA	#1
		STA	sprites_attr,X
		INX4
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_badnik_with_spikes:
		LDY	object_slot
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_x_positions
		STA	tmp_x_positions+2
		LDA	objects_X_h,Y
		SBC	camera_X_h_new
		STA	tmp_x_positions+3
		BEQ	loc_761AF
		CMP	#$FF
		BEQ	loc_761BF
		RTS
; ---------------------------------------------------------------------------

loc_761AF:
		LDA	tmp_x_positions
		CLC
		ADC	#8
		STA	tmp_x_positions+1
		BCC	loc_761CE
		LDA	#0
		STA	tmp_x_positions+1
		JMP	loc_761CE
; ---------------------------------------------------------------------------

loc_761BF:
		LDA	tmp_x_positions
		CLC
		ADC	#8
		BCS	loc_761C8
		LDA	#0

loc_761C8:
		STA	tmp_x_positions+1
		LDA	#0
		STA	tmp_x_positions

loc_761CE:
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_y_positions
		STA	tmp_y_positions+2
		LDA	objects_Y_relative_h,Y
		;ADC	#0
		ADC	sonic_y_h_on_scr
		STA	tmp_y_positions+3
		BEQ	loc_761E4
		CMP	#$FF
		BEQ	loc_761F4
		RTS
; ---------------------------------------------------------------------------

loc_761E4:
		LDA	tmp_y_positions
		CLC
		ADC	#8
		STA	tmp_y_positions+1
		BCC	loc_76203
		LDA	#0
		STA	tmp_y_positions+1
		JMP	loc_76203
; ---------------------------------------------------------------------------

loc_761F4:
		LDA	tmp_y_positions
		CLC
		ADC	#8
		BCS	loc_761FD
		LDA	#0

loc_761FD:
		STA	tmp_y_positions+1
		LDA	#0
		STA	tmp_y_positions

loc_76203:
		LDA	tmp_x_positions+2
		SEC
		SBC	#8
		STA	tmp_x_positions+2
		BCS	loc_7620E
		DEC	tmp_x_positions+3

loc_7620E:
		LDA	tmp_y_positions+2
		SEC
		SBC	#8
		STA	tmp_y_positions+2
		BCS	loc_76219
		DEC	tmp_y_positions+3

loc_76219:
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+4
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76236
		LDA	#0
		STA	tmp_x_positions+4
		BEQ	loc_76248

loc_76236:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+4
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_76248
		LDA	#0
		STA	tmp_y_positions+4

loc_76248:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+5
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76263
		LDA	#0
		STA	tmp_x_positions+5
		BEQ	loc_76275

loc_76263:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+5
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_76275
		LDA	#0
		STA	tmp_y_positions+5

loc_76275:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+6
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_76290
		LDA	#0
		STA	tmp_x_positions+6
		BEQ	loc_762A2

loc_76290:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+6
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_762A2
		LDA	#0
		STA	tmp_y_positions+6

loc_762A2:
		TYA
		CLC
		ADC	#4
		AND	#$F
		TAY
		LDA	tmp_x_positions+2
		CLC
		ADC	byte_763A2,Y
		STA	tmp_x_positions+7
		LDA	tmp_x_positions+3
		ADC	#0
		BEQ	loc_762BD
		LDA	#0
		STA	tmp_x_positions+7
		BEQ	loc_762CF

loc_762BD:
		LDA	tmp_y_positions+2
		CLC
		ADC	byte_763B2,Y
		STA	tmp_y_positions+7
		LDA	tmp_y_positions+3
		ADC	#0
		BEQ	loc_762CF
		LDA	#0
		STA	tmp_y_positions+7

loc_762CF:
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_762DE
		LDA	#$42
		STA	tmp_var_25
		LDA	#4
		BNE	loc_762E4

loc_762DE:
		LDA	#2
		STA	tmp_var_25
		LDA	#0

loc_762E4:
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_762EA:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_762FB
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_76328
; ---------------------------------------------------------------------------

loc_762FB:
		STA	tmp_var_2B
		LDY	#0

loc_762FF:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7631F
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	object_3F_tls,Y
		write_tile_attr_y

loc_7631F:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_762FF

loc_76328:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_762EA
		LDA	tmp_x_positions+4
		BEQ	loc_7634B
		STA	sprites_X,X
		LDA	tmp_y_positions+4
		BEQ	loc_7634B
		JSR	write_satellite2_sprite

loc_7634B:
		LDA	tmp_x_positions+5
		BEQ	loc_76367
		STA	sprites_X,X
		LDA	tmp_y_positions+5
		BEQ	loc_76367
		JSR	write_satellite2_sprite

loc_76367:
		LDA	tmp_x_positions+6
		BEQ	loc_76383
		STA	sprites_X,X
		LDA	tmp_y_positions+6
		BEQ	loc_76383
		JSR	write_satellite2_sprite

loc_76383:
		LDA	tmp_x_positions+7
		BEQ	loc_7639F
		STA	sprites_X,X
		LDA	tmp_y_positions+7
		BEQ	loc_7639F
		JSR	write_satellite2_sprite

loc_7639F:				; index	to sprites buffer
		STX	sprite_id
		RTS
; End of function draw_badnik_with_spikes

write_satellite2_sprite
		STA	sprites_Y,X
		LDA	#$9F
		STA	sprites_tile,X
		LDA	#0
		STA	sprites_attr,X
		INX4
		RTS

; ---------------------------------------------------------------------------
byte_763A2:	.BYTE	$C, $11, $14, $17, $18,	$17, $14, $11,	$C,   7,   3,	1,   0,	  1,   3,   7
byte_763B2:	.BYTE  $18, $17, $14, $11,  $C,	  7,   3,   1,	 0,   1,   3,	7,  $C,	$11, $14, $17

; =============== S U B	R O U T	I N E =======================================


draw_harpoon_Left:
		LDA	#5
		LDY	#1
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BEQ	loc_76453
		LDA	#$F
		STA	spr_cfg_off
		BNE	loc_76457

loc_76453:
		LDA	#$A
		STA	spr_cfg_off

loc_76457:
		LDA	#$41
		STA	tmp_var_25
		JMP	draw_harpoons
; ---------------------------------------------------------------------------

draw_harpoon_Right:
		LDA	#5
		LDY	#1
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BEQ	loc_764EF
		LDA	#5
		STA	spr_cfg_off
		BNE	loc_764F3

loc_764EF:
		LDA	#0
		STA	spr_cfg_off

loc_764F3:
		LDA	#1
		STA	tmp_var_25

draw_harpoons:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_764FB:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7650C
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#5
		STA	spr_cfg_off
		JMP	loc_76543
; ---------------------------------------------------------------------------

loc_7650C:
		STA	tmp_var_2B
		LDY	#0

loc_76510:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7653A
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	harpoon_lr_tls,Y
		BEQ	loc_7653A
		write_tile_attr_y
		BEQ	end_draw_harpoon

loc_7653A:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#5
		BCC	loc_76510

loc_76543:
		LDY	spr_parts_counter2
		INY
		CPY	#1
		BCC	loc_764FB
end_draw_harpoon:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function sub_76502


; =============== S U B	R O U T	I N E =======================================


draw_harpoon_Up:
		LDA	#1
		LDY	#5
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BEQ	loc_765DE
		LDA	#5
		STA	spr_cfg_off
		BNE	loc_765E2

loc_765DE:
		LDA	#0
		STA	spr_cfg_off

loc_765E2:
		LDA	#1
		STA	tmp_var_25
		JMP	loc_76682
; ---------------------------------------------------------------------------

draw_harpoon_Up_alt:
		LDA	#1
		LDY	#5
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BEQ	loc_7667A
		LDA	#$F
		STA	spr_cfg_off
		BNE	loc_7667E

loc_7667A:
		LDA	#$A
		STA	spr_cfg_off

loc_7667E:
		LDA	#$81
		STA	tmp_var_25

loc_76682:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_76686:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_76697
@skip:
		INC	spr_cfg_off
		JMP	loc_766CE
; ---------------------------------------------------------------------------

loc_76697:
		STA	tmp_var_2B
		LDY	#0

loc_7669B:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_766C5
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	harpoon_up_tls,Y
		BEQ	loc_766C5
		write_tile_attr_y
		BEQ	end_draw_harpoon2

loc_766C5:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#1
		BCC	loc_7669B

loc_766CE:
		LDY	spr_parts_counter2
		INY
		CPY	#5
		BCC	loc_76686
end_draw_harpoon2:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_harpoon_Up


; =============== S U B	R O U T	I N E =======================================


draw_object_3F:
		LDA	#4
		LDY	#2
		JSR	pos_for_draw_object
		;LDA	#0
		;STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0
		STY	spr_cfg_off

loc_76764:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_76775
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#4
		STA	spr_cfg_off
		JMP	loc_767A4
; ---------------------------------------------------------------------------

loc_76775:
		STA	tmp_var_2B
		LDY	#0

loc_76779:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_7679B
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	object_3F_offs,Y
		STA	sprites_tile,X
		LDA	object_3F_attr,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4
		BEQ	end_draw_object_3F

loc_7679B:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#4
		BCC	loc_76779

loc_767A4:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_76764
end_draw_object_3F:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_object_3F


; =============== S U B	R O U T	I N E =======================================


draw_big_platform:
		LDX	#$CA
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz
		LDX	#$91
@not_sbz		
		LDA	#0 ; attr
		LDY	#15 ; spr cfg num
		JSR	draw_sprite_new
		BEQ	@chr_ok
		
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BEQ	@sbz_platform_bank
		
		LDA	chr_spr_bank2	; big platform (SPRING, STAR LIGHT)
		CMP	#SPRING_CHR_BANK1
		BEQ	@chr_ok
		CMP	#SPRING_CHR_BANK2
		BEQ	@chr_ok
		CMP	#STARL_CHR_BANK	; STAR LIGHT
		BEQ	@chr_ok
		LDA	#STARL_CHR_BANK	; STAR LIGHT
		STA	chr_spr_bank2
@chr_ok:
		RTS
; End of function draw_big_platform

@sbz_platform_bank:
		LDA	#SBZ_CHR_BANK2
		STA	chr_spr_bank2
		RTS


; =============== S U B	R O U T	I N E =======================================

; $39, $3B, $3D
draw_small_platform:
		LDX	#$97
		LDA	#3 ; attr
		LDY	#14 ; spr cfg num
		JSR	draw_sprite_new
		BEQ	@chr_ok
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BEQ	@sbz_platform_bank
		JMP	set_spring_chr1_or2

@sbz_platform_bank:
		LDA	#SBZ_CHR_BANK2
		STA	chr_spr_bank2
@chr_ok:
		RTS
; End of function draw_small_platform


; =============== S U B	R O U T	I N E =======================================


draw_star_light_bomb:
		LDY	#0 ; frame 0
		LDA	Frame_Cnt
		AND	#3
		BEQ	@frame0
		INY	   ; frame 1
@frame0:
		LDA	objects_type,X
		CMP	#$51
		BEQ	@normal_bomb
		INY
		INY
		INY
		INY
@normal_bomb:
		LDA	objects_var_cnt,X ; var/counter
		BPL	@no_h_mirr
		INY
		INY
@no_h_mirr:
		LDX	#$A0 ; base tile num
		JSR	draw_sprite_new_attr0
		BEQ	@no_draw
		LDA	chr_spr_bank2
		CMP	#STARL_CHR_BANK
		BEQ	@ok
		CMP	#SBZ_CHR_BANK1
		BEQ	@ok
		CMP	#SBZ_CHR_BANK2
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3a
		BEQ	@ok	
		LDA	#STARL_CHR_BANK	; star_light_bomb
		STA	chr_spr_bank2
@ok
@no_draw:
		RTS


; =============== S U B	R O U T	I N E =======================================


draw_burrobot:
		LDA	#2
		LDY	#5
		JSR	pos_for_draw_object

		LDX	object_slot
		LDY	#0
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_76BEC
		LDY	#$40

loc_76BEC:
		STY	tmp_var_25
		;LDA	objects_var_cnt,X ; var/counter
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		TAY
		LDA	burrobot_offs,Y
		STA	spr_cfg_off
		LDA	Frame_Cnt
		AND	#4
		BEQ	loc_76C08
		LDA	spr_cfg_off
		CLC
		ADC	#$A
		STA	spr_cfg_off

loc_76C08:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_76C0C:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_76C1D
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_76C54
; ---------------------------------------------------------------------------

loc_76C1D:
		STA	tmp_var_2B
		LDY	#0

loc_76C21:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_76C4B
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	burrobot_tls,Y
		BEQ	loc_76C4B
		write_tile_attr_y
		BEQ	end_draw_burrobot

loc_76C4B:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_76C21

loc_76C54:
		LDY	spr_parts_counter2
		INY
		CPY	#5
		BCC	loc_76C0C
		
end_draw_burrobot:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		LDA	#LAB_CHR_BANK
		STA	chr_spr_bank2
@ret
		RTS
; End of function draw_burrobot


; =============== S U B	R O U T	I N E =======================================


draw_singpost:
		LDA	objects_type,X
		CMP	#$2E
		BEQ	@normal
		LDY	#52	; sonic
		LDA	level_id
		CMP	#SPEC_STAGE
		BEQ	@signpost_special
		LDA	big_ring_flag
		BEQ	@draw_signpost
		LDY	#53	; ring
		BNE	@draw_signpost
		
@signpost_special:
		LDA	objects_var_cnt,X
		BNE	@draw_signpost
		LDY	#54	; emerald
		BNE	@draw_signpost ; JMP
		
@normal:
		LDY	#48	; eggman
		LDA	objects_var_cnt,X
		BEQ	@draw_signpost
		LDA	Frame_Cnt
		LSR	A
		AND	#7
		TAX
		LDY	singpost_anim,X

@draw_signpost:	
		JSR	draw_sprite_new_tile0_attr0
		BEQ	@no_spr
		LDA	#SINGPOST_CHR_BANK
		STA	chr_spr_bank2
@no_spr:
		RTS
		
singpost_anim:
		.BYTE	48,49,50,56
		.BYTE	52,55,50,51


; =============== S U B	R O U T	I N E =======================================


;draw_singpost:
;		LDA	#5
;		LDY	#6
;		JSR	pos_for_draw_object
;
;		LDX	object_slot
;		LDA	objects_type,X
;		EOR	#$2E
;		BEQ	draw_singpost1
;		
;		LDA	#1
;		STA	tmp_var_25
;		LDA	objects_var_cnt,X ; var/counter
;		BEQ	loc_76DEC
;		LDA	#$96
;		BNE	loc_76CF7
;		
;loc_76DEC:
;		LDA	#$78
;		BNE	loc_76CF7
;		
;draw_singpost1:
;		STA	tmp_var_25
;		LDA	objects_var_cnt,X ; var/counter
;		BEQ	loc_76CF7
;		LDA	Frame_Cnt
;		LSR	A
;		AND	#3
;		TAY
;		LDA	singpost_f_off,Y
;loc_76CF7:
;		STA	spr_cfg_off
;		LDX	sprite_id
;		LDY	#0
;
;loc_76CFF:
;		STY	spr_parts_counter2
;		LDA	tmp_y_positions,Y
;		BEQ	@skip
;		CMP	#$E8
;		BCC	loc_76D10
;@skip:
;		LDA	spr_cfg_off
;		CLC
;		ADC	#5
;		STA	spr_cfg_off
;		JMP	loc_76D47
; ---------------------------------------------------------------------------
;
;loc_76D10:
;		STA	tmp_var_2B
;		LDY	#0
;
;loc_76D14:
;		STY	spr_parts_counter
;		LDA	tmp_x_positions,Y
;		BEQ	loc_76D3E
;		STA	sprites_X,X
;		LDY	spr_cfg_off
;		LDA	singpost1_tls,Y
;		BEQ	loc_76D3E
;		STA	sprites_tile,X
;		;LDA	#0
;		LDA	tmp_var_25
;		STA	sprites_attr,X
;		LDA	tmp_var_2B
;		STA	sprites_Y,X
;		INX4
;
;loc_76D3E:
;		INC	spr_cfg_off
;		LDY	spr_parts_counter
;		INY
;		CPY	#5
;		BCC	loc_76D14
;
;loc_76D47:
;		LDY	spr_parts_counter2
;		INY
;		CPY	#6
;		BCC	loc_76CFF
;		STX	sprite_id
;		
;		LDY	#SINGPOST_CHR_BANK ; SONIC + EMERALD
;		LDA	level_id
;		CMP	#SPEC_STAGE
;		BEQ	@set_chr_bank
;
;		;LDX	object_slot
;		LDA	rings_100s
;		BNE	@rings
;		LDA	rings_10s
;		CMP	#5		; compare for 50 rings
;		BCC	@set_chr_bank
;@rings:
;		LDA	big_ring_flag
;		BEQ	@set_chr_bank
;
;		LDY	#SINGPOST_CHR_BANK+2 ; RING+BIG RING
;@set_chr_bank:
;		STY	chr_spr_bank2
;		RTS
; End of function draw_singpost

; ---------------------------------------------------------------------------
;singpost_f_off:	.BYTE 0
;		.BYTE $1E
;		.BYTE $5A
;		.BYTE $3C
; ---------------------------------------------------------------------------
harpoon_lr_tls:	.BYTE  $BA,   0,   0,	0
		.BYTE	 0, $B8, $B7, $B7
		.BYTE  $B9, $BA,   0,	0
		.BYTE	 0,   0, $BA, $BA
		.BYTE  $B9, $B7, $B7, $B8
harpoon_up_tls:	.BYTE	 0,   0,   0,	0
		.BYTE  $B0, $B0, $B1, $B2
		.BYTE  $B2, $B3, $B0,	0
		.BYTE	 0,   0,   0, $B3
		.BYTE  $B2, $B2, $B1, $B0
object_3F_offs:	.BYTE  $97, $97, $97, $97
		.BYTE  $98, $98, $98, $98
object_3F_attr:	.BYTE	 3, $43,   3, $43
		.BYTE	 3, $43,   3, $43
object_3F_tls:	.BYTE  $9B, $9D, $9C, $9E
		.BYTE  $9D, $9B, $9E, $9C
		
;byte_76EA3:	.BYTE  $C0, $C2, $C1, $C3

;singpost1_tls:	.BYTE  $80, $82, $84, $86, $88,	$81, $83, $85
;		.BYTE  $87, $89, $A0, $A2, $A4,	$A6, $A8, $A1
;		.BYTE  $A3, $A5, $A7, $A9,   0,	  0, $DC,   0
;		.BYTE	 0,   0,   0, $DD,   0,	  0,   0, $94
;		.BYTE  $96, $98,   0,	0, $95,	$97, $99,   0
;		.BYTE	 0, $B4, $B6, $B8,   0,	  0, $B5, $B7
;		.BYTE  $B9,   0,   0,	0, $DC,	  0,   0,   0
;		.BYTE	 0, $DD,   0,	0,   0,	$9A, $9C, $9E
;		.BYTE	 0,   0, $9B, $9D, $9F,	  0,   0, $BA
;		.BYTE  $BC, $BE,   0,	0, $BB,	$BD, $BF,   0
;		.BYTE	 0,   0, $DC,	0,   0,	  0,   0, $DD
;		.BYTE	 0,   0,   0,	0, $C0,	  0,   0,   0
;		.BYTE	 0, $C1,   0,	0,   0,	  0, $C1,   0
;		.BYTE	 0,   0,   0, $E0,   0,	  0,   0,   0
;		.BYTE  $DC,   0,   0,	0,   0,	$DD,   0,   0
;singpost2_tls:	.BYTE  $80, $C2, $C4, $C6, $88,	$D2, $C3, $C5
;		.BYTE  $C7, $DA, $D2, $D4, $D6,	$D8, $DA, $D3
;		.BYTE  $D5, $D7, $D9, $DB,   0,	  0, $DC,   0
;		.BYTE	 0,   0,   0, $DD,   0,	  0, $8A, $8C
;		.BYTE  $8E, $90, $88, $8B, $8D,	$8F, $91, $93
;		.BYTE  $AA, $AC, $AE, $B0, $B2,	$AB, $AD, $AF
;		.BYTE  $B1, $B3,   0,	0, $DC,	  0,   0,   0
;		.BYTE	 0, $DD,   0,	0
		
burrobot_offs:	.BYTE	 0,   0,   0,	0,   0,	  0, $14, $14, $28, $28, $28, $28, $28,	$28, $3C, $3C

burrobot_tls:	.BYTE  $A9, $AA, $AB, $AC, $AD,	$AE, $AF, $BB,	 0,   0, $A9, $AA, $BC,	$AC, $AD, $AE
		.BYTE  $BD, $BE,   0,	0, $90,	$91, $92, $93, $94, $95, $96, $A0, $A1,	$A2, $A3, $91
		.BYTE  $A4, $93, $A5, $A6, $A7,	$A8, $A1, $A2, $AA, $A9, $AC, $AB, $AE,	$AD, $BB, $AF
		.BYTE	 0,   0, $AA, $A9, $AC,	$BC, $AE, $AD, $BE, $BD,   0,	0, $91,	$90, $93, $92
		.BYTE  $95, $94, $A0, $96, $A2,	$A1, $91, $A3, $93, $A4, $A6, $A5, $A8,	$A7, $A2, $A1

; =============== S U B	R O U T	I N E =======================================


draw_explosions:
		LDA	objects_var_cnt,X ; var/counter
		TAY
		AND	#3
		STA	spr_cfg_off
		TYA
		LSR	A
		LSR	A
		AND	#7
		TAY
		LDA	objects_X_relative_l,X
		CLC
		ADC	byte_77165,Y
		STA	tmp_var_28
		LDA	objects_X_relative_h,X
		ADC	#0
		STA	tmp_var_27
		LDA	objects_Y_relative_l,X
		CLC
		ADC	byte_7716D,Y
		STA	objects_Y_relative_l,X
		BCC	@no_inc_y_h
		INC	objects_Y_relative_h,X
@no_inc_y_h
		LDA	#2
		STA	tmp_ptr_l	; tiles cnt X
		STA	tmp_ptr_l+1	; tiles cnt Y
		LDX	#0
		LDY	object_slot
		LDA	tmp_var_28
		CLC
		ADC	sonic_x_on_scr
		STA	tmp_var_28
		LDA	tmp_var_27
		ADC	sonic_x_h_on_scr
		JSR	pos_for_draw_object_nx
		
		LDY	spr_cfg_off
		LDA	byte_7714D,Y
		STA	spr_cfg_off
		;LDA	byte_77151,Y
		;STA	tmp_var_25
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0
		STY	tmp_var_25

loc_770F1:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_77102
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_77139
; ---------------------------------------------------------------------------

loc_77102:
		STA	tmp_var_2B
		LDY	#0

loc_77106:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_77130
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_77155,Y
		BEQ	loc_77130
		write_tile_attr_y

loc_77130:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_77106

loc_77139:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_770F1
		STX	sprite_id	; index	to sprites buffer
		LDA	Frame_Cnt
		AND	#$F
		BNE	locret_7714C
		LDA	#9
		STA	sfx_to_play

locret_7714C:
		RTS
; End of function draw_explosions

; ---------------------------------------------------------------------------
byte_7714D:	.BYTE	 0,   4,   8,  $C
;byte_77151:	.BYTE	 0,   0,   0,	0
byte_77155:	.BYTE  $AE, $AF, $BE, $BF
		.BYTE  $AC, $AD, $BC, $BD
		.BYTE  $CC, $CD, $DC, $DD
		.BYTE	 0,   0,   0,	0
byte_77165:	.BYTE	 8, $1C,   0, $1A
		.BYTE  $10,   5, $22, $10
byte_7716D:	.BYTE	 8, $18, $18,	6
		.BYTE  $1C, $12, $16, $10

; =============== S U B	R O U T	I N E =======================================


draw_object_61:
		LDA	#1
		LDY	#3
		JSR	pos_for_draw_object

		LDY	#0
		LDA	Frame_Cnt
		AND	#$10
		BEQ	loc_77203
		LDY	#$40

loc_77203:
		STY	tmp_var_25
		LDA	#0
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_7720D:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7721E
@skip:
		INC	spr_cfg_off
		JMP	loc_7724E
; ---------------------------------------------------------------------------

loc_7721E:
		STA	tmp_var_2B
		LDY	#0

loc_77222:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_77245
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_77258,Y
		BEQ	loc_77245
		write_tile_attr_y

loc_77245:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#1
		BCC	loc_77222

loc_7724E:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_7720D
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_object_61

; ---------------------------------------------------------------------------
byte_77258:	.BYTE  $ED, $FD

; =============== S U B	R O U T	I N E =======================================


draw_fires:
		LDA	objects_type,X
		EOR	Frame_Cnt
		AND	#1
		BEQ	@draw
		RTS
@draw
		LDY	objects_var_cnt,X
		LDA	byte_7733E,Y
		STA	tmp_var_26
		
		LDA	#4
		LDY	#2
		JSR	pos_for_draw_object
		
		LDY	#0
		LDA	Frame_Cnt
		AND	#$10
		BEQ	loc_772F3
		LDY	#$40

loc_772F3:
		STY	tmp_var_25
		LDA	#$EE
		STA	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_772FD:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	loc_77330
		CMP	#$E8
		BCS	loc_77330
; ---------------------------------------------------------------------------

loc_77307:
		STA	tmp_var_2B
		LDY	#0

loc_7730B:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_77329
		STA	sprites_X,X
		LDA	spr_cfg_off
		write_tile_attr_y
		BEQ	end_draw_fires

loc_77329:
		LDY	spr_parts_counter
		INY
		CPY	tmp_var_26
		BCC	loc_7730B

loc_77330:
		LDA	#$FE
		STA	spr_cfg_off
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_772FD
end_draw_fires:
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_fires

; ---------------------------------------------------------------------------
byte_7733E:	.BYTE	 1,   2,   3,	4,   3,	  2,   1,   1,	 0

; =============== S U B	R O U T	I N E =======================================

; fire splash on marble zone boss
draw_object_64:
		LDA	#1
		LDY	#2
		JSR	pos_for_draw_object

		LDX	object_slot
		LDA	objects_var_cnt,X ; var/counter
		BPL	loc_773D3
		RTS
; ---------------------------------------------------------------------------

loc_773D3:
		AND	#$40
		BNE	loc_773E1
		LDA	#$80
		LDY	#2
		BNE	loc_773E9 ; JMP

loc_773E1:
		LDA	#0
		TAY

loc_773E9:
		STA	tmp_var_25
		STY	spr_cfg_off

		LDA	Frame_Cnt
		AND	#2
		BEQ	loc_773F5
		LDA	tmp_var_25
		ORA	#$40
		STA	tmp_var_25

loc_773F5:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_773F9:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_7740A
@skip:
		INC	spr_cfg_off
		JMP	loc_7743A
; ---------------------------------------------------------------------------

loc_7740A:
		STA	tmp_var_2B
		LDY	#0

loc_7740E:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_77431
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_77444,Y
		BEQ	loc_77431
		write_tile_attr_y

loc_77431:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#1
		BCC	loc_7740E

loc_7743A:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_773F9
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_object_64

; ---------------------------------------------------------------------------
byte_77444:	.BYTE  $EF, $FF
		.BYTE  $FF, $EF

; =============== S U B	R O U T	I N E =======================================


draw_object_65:
		JSR	draw_single_sprite_pos
		LDA	Frame_Cnt
		AND	#8
		BEQ	@tile1
		LDA	#$FF
		.BYTE	$2C
@tile1:
		LDA	#$EF
		STA	sprites_tile,Y
		LDA	#0
		STA	sprites_attr,Y
		RTS
; End of function draw_object_65


; =============== S U B	R O U T	I N E =======================================


draw_final_boss_weapon:
		LDA	#2
		LDY	#2
		JSR	pos_for_draw_object
		
		LDY	#4
		LDA	Frame_Cnt
		AND	#8
		BEQ	loc_7758A
		LDY	#0

loc_7758A:
		STY	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_77590:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_775A1
@skip:
		INC	spr_cfg_off
		INC	spr_cfg_off
		JMP	loc_775CF
; ---------------------------------------------------------------------------

loc_775A1:
		STA	tmp_var_2B
		LDY	#0

loc_775A5:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_775C6
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	byte_775D9,Y
		STA	sprites_tile,X
		LDA	#1
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4

loc_775C6:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_775A5

loc_775CF:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_77590
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_final_boss_weapon

; ---------------------------------------------------------------------------
byte_775D9:	.BYTE	$B8,$B9,$C8,$C9
		.BYTE	$BA,$BB,$CA,$CB

; =============== S U B	R O U T	I N E =======================================


draw_capsule_sprites:
		CMP	#4
		BCS	no_draw
		LDA	chr_spr_bank2
		EOR	#$E6
		BNE	no_draw
		TAX
		LDA	capsule_pos_x_l_rel
		ADC	sonic_x_on_scr
		STA	tmp_var_28
		LDA	capsule_pos_x_h_rel
		ADC	sonic_x_h_on_scr
		BMI	draw_alt
		BNE	no_draw
		LDA	tmp_var_28
loop:	
		STA	tmp_x_positions,X
		INX
		CPX	#3
		BCS	loc_C2F4F
		ADC	#8
		BCC	loop
		BCS	loc_C2F46
	
draw_alt:
		LDA	tmp_var_28
		LDY	#0
loop2	
		STY	tmp_x_positions,X
		INX
		CPX	#3
		BCS	no_draw
		ADC	#8
		BCC	loop2
		BCS	loop
no_draw:
;		RTS
locret_C2F45:
		RTS
; ---------------------------------------------------------------------------

loc_C2F46:
		LDA	#0

loc_C2F48:
		STA	tmp_x_positions,X
		INX
		CPX	#3
		BCC	loc_C2F48

loc_C2F4F:
		LDX	#0
		LDA	capsule_pos_y_l_rel
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	capsule_pos_y_h_rel
		ADC	sonic_y_h_on_scr ; sonic-camera
		BMI	loc_C2F73
		BEQ	loc_C2F63
		RTS
; ---------------------------------------------------------------------------

loc_C2F63:
		LDA	tmp_var_2B

loc_C2F65:
		STA	tmp_y_positions,X
		INX
		CPX	#3
		BCS	loc_C2F8F
		;CLC
		ADC	#8
		BCC	loc_C2F65
		BCS	loc_C2F86

loc_C2F73:
		LDA	tmp_var_2B
		LDY	#0

loc_C2F77:
		STY	tmp_y_positions,X
		INX
		CPX	#3
		BCS	locret_C2F85
		;CLC
		ADC	#8
		BCC	loc_C2F77
		BCS	loc_C2F65

locret_C2F85:
		RTS
; ---------------------------------------------------------------------------

loc_C2F86:
		LDA	#0

loc_C2F88:
		STA	tmp_y_positions,X
		INX
		CPX	#3
		BCC	loc_C2F88

loc_C2F8F:
		LDY	#0
		LDA	Frame_Cnt
		AND	#$20
		BNE	loc_C2F99
		LDY	#9

loc_C2F99:
		STY	spr_cfg_off
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_C2F9F:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BEQ	@skip
		CMP	#$E8
		BCC	loc_C2FB0
@skip:
		LDA	spr_cfg_off
		CLC
		ADC	#3
		STA	spr_cfg_off
		JMP	loc_C2FE8
; ---------------------------------------------------------------------------

loc_C2FB0:
		STA	tmp_var_2B
		LDY	#0

loc_C2FB4:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_C2FDF
		STA	sprites_X,X
		LDY	spr_cfg_off
		LDA	capsule_tls_num,Y
		BEQ	loc_C2FDF
		STA	sprites_tile,X
		LDA	capsule_attribs,Y
		STA	sprites_attr,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		INX4

loc_C2FDF:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#3
		BCC	loc_C2FB4

loc_C2FE8:
		LDY	spr_parts_counter2
		INY
		CPY	#3
		BCC	loc_C2F9F
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_capsule_sprites

; ---------------------------------------------------------------------------
capsule_tls_num:.BYTE  $9A, $9B, $9C
		.BYTE  $9D, $9E, $9F
		.BYTE	 0, $AA,   0
		
		.BYTE  $9A, $9B, $9C
		.BYTE  $9D, $9E, $9F
		.BYTE	 0, $AB,   0
		
capsule_attribs:.BYTE	 2,   2,   2
		.BYTE	 2,   2,   2
		.BYTE	 0,   0,   0
		.BYTE	 2,   2,   2
		.BYTE	 2,   2,   2
		.BYTE	 0,   0,   0

; =============== S U B	R O U T	I N E =======================================


draw_chaos_emerald:
		LDA	#2
		LDY	#2
		JSR	pos_for_draw_object
		
		LDA	Frame_Cnt
		ASL	A
		ASL	A	; 10>20
		ASL	A	; 20>40
		STA	tmp_var_2B
		
		LDX	sprite_id	; index	to sprites buffer
		LDY	#3
		STY	spr_cfg_off
		LDY	#1
		STY	spr_parts_counter
@write_chaos_emerald_spr2:
		LDY	#1
		STY	spr_parts_counter2
		
@write_chaos_emerald_spr:
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_X,X
		LDY	spr_parts_counter
		LDA	tmp_y_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	emerald_tls_nums,Y
		BIT	tmp_var_2B
		BVC	@tls_set1
		LDA	emerald_tls_nums2,Y
@tls_set1
		STA	sprites_tile,X
		LDA	#2	; emerald attr
		STA	sprites_attr,X
		INX4
		
@skip_spr_part:
		DEC	spr_cfg_off
		DEC	spr_parts_counter2
		BPL	@write_chaos_emerald_spr
		DEC	spr_parts_counter
		BPL	@write_chaos_emerald_spr2
		
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		AND	#3
		TAY
		LDA	chaos_em_anim_banks,Y
		STA	chr_spr_bank2
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_chaos_emerald
; ---------------------------------------------------------------------------
emerald_tls_nums:
		.BYTE	$E0,$E1,$F0,$F1
emerald_tls_nums2:
		.BYTE	$E9,$EA,$F9,$FA
		
chaos_em_anim_banks:
		.BYTE	$3A,$3A,$3C,$3C


; =============== S U B	R O U T	I N E =======================================


draw_flame:
		LDA	objects_var_cnt,X
		CMP	#144
		BCC	@draw_
@no_draw:
		RTS
@draw_:
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		LDY	objects_type,X
		CPY	#$6E
		BNE	@not_up_flame
		CLC
		ADC	#flame_anim_table_UP-flame_anim_table
		
@not_up_flame
		TAY
		LDA	flame_anim_table,Y
		STA	spr_cfg_off
		
		LDA	Frame_Cnt
		LSR	A
		LDA	#3
		BCC	@no_pal_anim
		LDA	#0
@no_pal_anim
		CPY	#flame_anim_table_UP-flame_anim_table
		BCC	@not_v_mirr
		EOR	#$80
		
@not_v_mirr
		STA	tmp_var_25
		
		LDA	#1
		LDY	#1
		JSR	pos_for_draw_object

;		LDA	Frame_Cnt
;		LSR	A
		LDA	tmp_var_25
;		BCC	@no_pal_anim
;		EOR	#2
;@no_pal_anim:
		STA	tmp_var_2B
		
		LDX	sprite_id
;		BEQ	@no_draw
		
		LDY	spr_cfg_off
		;LDY	#0 ; test frame0
		LDA	flame_tls_nums,Y
		STA	spr_parts_counter
		INY
		
@write_flame_spr:
		LDA	tmp_x_positions
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_attr,X
		LDA	flame_tls_nums,Y
		INY
		STA	sprites_tile,X
		LDA	tmp_y_positions
		CLC
		ADC	flame_tls_nums,Y
		INY
		BCS	@spr_limit ; out of screen
		CMP	#$E8
		BCS	@spr_limit ; out of screen
		STA	sprites_Y,X
		INX4
		BEQ	@spr_limit
		DEC	spr_parts_counter
		BNE	@write_flame_spr
		
@spr_limit:
		CPX	sprite_id
		BEQ	@ok
		STX	sprite_id
		LDX	object_slot
		LDA	objects_var_cnt,X
		BNE	@no_sfx
		LDY	#$1A	; SFX
		STY	sfx_to_play  ; moved to draw_objs_code.asm
@no_sfx
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK1
		BEQ	@ok
		CMP	#STARL_CHR_BANK
		BEQ	@ok
		CMP	#SBZ_CHR_BANK2
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3
		BEQ	@ok
		CMP	#SBZ_CHR_BANK3a
		BEQ	@ok
		CMP	#SBZ_CHR_BANK4
		BEQ	@ok
		LDA	#SBZ_CHR_BANK1
		STA	chr_spr_bank2
@ok		
		RTS
; ---------------------------------------------------------------------------

flame_anim_table:
		.BYTE	flame_tls_nums1-flame_tls_nums
		.BYTE	flame_tls_nums2-flame_tls_nums
		.BYTE	flame_tls_nums3-flame_tls_nums
		.BYTE	flame_tls_nums4-flame_tls_nums
		.BYTE	flame_tls_nums4-flame_tls_nums
		.BYTE	flame_tls_nums4-flame_tls_nums
		.BYTE	flame_tls_nums3-flame_tls_nums
		.BYTE	flame_tls_nums2-flame_tls_nums
		.BYTE	flame_tls_nums1-flame_tls_nums
		
flame_anim_table_UP:
		.BYTE	flame_tls_nums_up-flame_tls_nums
		.BYTE	flame_tls_nums2_up-flame_tls_nums
		.BYTE	flame_tls_nums3_up-flame_tls_nums
		.BYTE	flame_tls_nums4_up-flame_tls_nums
		.BYTE	flame_tls_nums4_up-flame_tls_nums
		.BYTE	flame_tls_nums4_up-flame_tls_nums
		.BYTE	flame_tls_nums3_up-flame_tls_nums
		.BYTE	flame_tls_nums2_up-flame_tls_nums
		.BYTE	flame_tls_nums_up-flame_tls_nums
		
ft1 = $80
ft2 = $81
ft3 = $E0
ft4 = $AD	
		
flame_tls_nums:
; size 24
flame_tls_nums1:
		.BYTE	$04 ; 4 tiles
		.BYTE	ft2,$10 ; tile num, Y pos
		.BYTE	ft1,$0A ; tile num, Y pos
		.BYTE	ft4,$08 ; tile num, Y pos
		.BYTE	ft3,$00 ; tile num, Y pos

; size 27
flame_tls_nums2:
		.BYTE	$05 ; 5 tiles
		.BYTE	ft2,$13
		.BYTE	ft1,$0C
		.BYTE	ft4,$0A
		.BYTE	ft4,$08
		.BYTE	ft3,$00 ; tile num, Y pos

; size 30
flame_tls_nums3:
		.BYTE	$06 ; 6 tiles
		.BYTE	ft2,$16
		.BYTE	ft1,$0E
		.BYTE	ft4,$0B
		.BYTE	ft3,$03
		.BYTE	ft4,$08
		.BYTE	ft3,$00
	
; size 33
flame_tls_nums4:
		.BYTE	$07 ; 7 tiles
		.BYTE	ft2,$19
		.BYTE	ft1,$11
		.BYTE	ft4,$10
		.BYTE	ft4,$0C
		.BYTE	ft3,$04
		.BYTE	ft4,$08
		.BYTE	ft3,$00
		
; VERTICALLY UP

; size 24
flame_tls_nums_up:
		.BYTE	$04 ; 4 tiles
		.BYTE	ft2,$00 ; tile num, Y pos
		.BYTE	ft1,$08 ; tile num, Y pos
		.BYTE	ft4,$0C ; tile num, Y pos
		.BYTE	ft3,$0C+8 ; tile num, Y pos
; size 27
flame_tls_nums2_up:
		.BYTE	$05 ; 5 tiles
		.BYTE	ft2,$00
		.BYTE	ft1,$08
		.BYTE	ft4,$0C
		.BYTE	ft4,$10
		.BYTE	ft3,$10+8 ; tile num, Y pos
; size 30
flame_tls_nums3_up:
		.BYTE	$06 ; 6 tiles
		.BYTE	ft2,$00
		.BYTE	ft1,$08
		.BYTE	ft4,$0C
		.BYTE	ft3,$0C+8
		.BYTE	ft4,$14
		.BYTE	ft3,$14+8
; size 33
flame_tls_nums4_up:
		.BYTE	$07 ; 7 tiles
		.BYTE	ft2,$00
		.BYTE	ft1,$08
		.BYTE	ft4,$0C
		.BYTE	ft4,$12
		.BYTE	ft3,$12+8
		.BYTE	ft4,$16
		.BYTE	ft3,$16+8


; =============== S U B	R O U T	I N E =======================================

; 0 = idle, 1 = attack, 2 = sit, 3 = jump

ballhog_frame_types_2:
		.BYTE	0,2,3,2
		.BYTE	0,1
		.BYTE	0,2,3,2
		.BYTE	0,2,3,2
		
draw_ballhog:
		LDA	#2
		LDY	#5
		JSR	pos_for_draw_object
		
		LDX	object_slot
		LDY	objects_var_cnt,X
		LDA	ballhog_frame_types_2,Y
		TAY
		LDA	#4
		CPY	#3
		BNE	@not_jump
		LDA	#5
@not_jump
		STA	tmp_var_2B
		
		LDA	#2
		STA	tmp_var_25
		LDA	objects_X_l,X
		AND	#1
		STA	tmp_var_28
		BEQ	@no_h_mirr
		LDA	#$42
		STA	tmp_var_25
@no_h_mirr:
		LDX	sprite_id
		LDA	ballhog_cfg_off,Y
		STA	spr_cfg_off
		
		LDY	#0
@write_spr2:
		STY	spr_parts_counter
		LDY	#0
@write_spr:		
		STY	spr_parts_counter2
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		BEQ	@skip_spr_part
		STA	sprites_X,X
		
		LDY	spr_parts_counter
		LDA	tmp_y_positions,Y
		BEQ	@skip_spr_part
		CMP	#$E8
		BCS	@skip_spr_part
		STA	sprites_Y,X
		
		LDA	tmp_var_25
		STA	sprites_attr,X
		
		LDA	spr_cfg_off
		EOR	tmp_var_28
		TAY
		LDA	ballhog_tiles_nums,Y
		STA	sprites_tile,X

		INX4
		BEQ	@spr_limit
		
@skip_spr_part:
		INC	spr_cfg_off
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	@write_spr
		LDY	spr_parts_counter
		INY
		CPY	tmp_var_2B
		BCC	@write_spr2
@spr_limit:
		CPX	sprite_id
		BEQ	@ret
		STX	sprite_id
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK1
		BEQ	@ret
		CMP	#SBZ_CHR_BANK4
		BEQ	@ret
		LDA	#SBZ_CHR_BANK1
		STA	chr_spr_bank2
@ret
		RTS
		
		even
ballhog_cfg_off:
		.BYTE	0
		.BYTE	ballhog_frame2-ballhog_tiles_nums
		.BYTE	ballhog_frame3-ballhog_tiles_nums
		.BYTE	ballhog_frame4-ballhog_tiles_nums

ballhog_tiles_nums:
		.BYTE	$82,$83 ; frame1
		.BYTE	$84,$85
		.BYTE	$86,$87
		.BYTE	$88,$89
		
ballhog_frame2:
		.BYTE	$8A,$8B ; frame2
		.BYTE	$84,$8D
		.BYTE	$8E,$8F
		.BYTE	$90,$91

ballhog_frame3:
		.BYTE	$82,$83 ; frame3
		.BYTE	$84,$8D
		.BYTE	$92,$93
		.BYTE	$94,$95

ballhog_frame4:
		.BYTE	$8A,$83 ; frame4
		.BYTE	$84,$8D
		.BYTE	$96,$97
		.BYTE	$98,$99
		.BYTE	$9A,$9B


; =============== S U B	R O U T	I N E =======================================

; 8x8
;draw_ballhog_ball:
;		JSR	draw_single_sprite_pos
;		LDA	Frame_Cnt
;		AND	#8
;		BEQ	@tile1
;		LDA	#$9C
;		.BYTE	$2C
;@tile1:
;		LDA	#$8C
;		STA	sprites_tile,Y
;		LDA	#2
;		STA	sprites_attr,Y

draw_ballhog_ball:
;		LDX	#$8C ; base tile number
;		LDA	Frame_Cnt
;		AND	#8
;		BEQ	@tile1
;		LDX	#$9C ; base tile number
;@tile1:

		LDX	#0 ; base tile num
		LDY	#28 ; spr cfg num
		LDA	Frame_Cnt
		AND	#8
		BEQ	@cfg1
		INY
@cfg1
		LDA	#2 ; attr
		JSR	draw_sprite_new
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK3
		BEQ	no_draw_ball
		CMP	#SBZ_CHR_BANK3a
		BEQ	no_draw_ball
		
set_sbz_chr1_or_2:
		LDA	chr_spr_bank2
		CMP	#SBZ_CHR_BANK1
		BEQ	@chr_ok
		CMP	#SBZ_CHR_BANK2
		BEQ	@chr_ok
		CMP	#SBZ_CHR_BANK4
		BEQ	@chr_ok
		LDA	#SBZ_CHR_BANK1
		STA	chr_spr_bank2
@chr_ok:
no_draw_ball:
		RTS
; End of function draw_ballhog_ball


; =============== S U B	R O U T	I N E =======================================


draw_blocks_boss3:
		LDA	#4
		LDY	#4
		JSR	pos_for_draw_object
		
		LDX	sprite_id
		
		LDA	Frame_Cnt
		AND	#1
		TAY
		LDA	blocks_cfg_off,Y
		STA	spr_cfg_off
		
		LDY	#3
		STY	spr_parts_counter
@write_spr2:
		LDY	#3
		STY	spr_parts_counter2
		
@write_spr:
		LDY	spr_cfg_off
		LDA	blocks_tls_nums,Y
		BEQ	@skip_spr_part
		STA	sprites_tile,X
		LDY	spr_parts_counter
		LDA	tmp_y_positions,Y
		BEQ	@skip_spr_part
		CMP	#$E8
		BCS	@skip_spr_part
		STA	sprites_Y,X
		LDA	#3
		STA	sprites_attr,X
		LDY	spr_parts_counter2
		LDA	tmp_x_positions,Y
		STA	sprites_X,X
		INX4
		BEQ	@spr_limit
		
@skip_spr_part:
		DEC	spr_cfg_off
		DEC	spr_parts_counter2
		BPL	@write_spr
		DEC	spr_parts_counter
		BPL	@write_spr2
@spr_limit:
		STX	sprite_id
		RTS
		
blocks_cfg_off:
		.BYTE	15,31
		
blocks_tls_nums:
		.BYTE	$E0,$E1,$00,$00
		.BYTE	$F0,$F1,$00,$00
		.BYTE	$00,$00,$E0,$E1
		.BYTE	$00,$00,$F0,$F1

		.BYTE	$00,$00,$E0,$E1
		.BYTE	$00,$00,$F0,$F1
		.BYTE	$E0,$E1,$00,$00
		.BYTE	$F0,$F1,$00,$00


; =============== S U B	R O U T	I N E =======================================

; $7B
draw_flipper_m:
		LDA	#41
		BNE	draw_flipper_
; $7C
draw_flipper:
		LDA	#38
draw_flipper_
		LDY	objects_var_cnt,X
		CLC
		ADC	flipper_anim_frames,Y
		TAY
		LDX	#0
		LDA	#1	; attr
		JSR	draw_sprite_new
		BEQ	@ret
		LDA	#FLIPPER_CHR_BANK
		STA	chr_spr_bank2
@ret
		RTS
		
flipper_anim_frames:
		.BYTE	0
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	2
		.BYTE	2
		.BYTE	2
		.BYTE	2
		.BYTE	2
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	1
		.BYTE	0


; =============== S U B	R O U T	I N E =======================================


pos_for_draw_object:
		STA	tmp_ptr_l	; tiles cnt X
		STY	tmp_ptr_l+1	; tiles cnt Y
		LDX	#0
		LDY	object_slot
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_var_28
		LDA	objects_X_h,Y
		SBC	camera_X_h_new
pos_for_draw_object_nx:
		BEQ	loc_74B35
		CMP	#$FF
		BEQ	loc_74B45
locret_74B57:
		PLA
		PLA
		RTS
; ---------------------------------------------------------------------------

loc_74B35:
		LDA	tmp_var_28

loc_74B37:
		STA	tmp_x_positions,X
		INX
		CPX	tmp_ptr_l
		BCS	loc_74B61
		CLC
		ADC	#8
		BCC	loc_74B37
		BCS	loc_74B58
; ---------------------------------------------------------------------------
loc_74B45:
		LDA	tmp_var_28
		LDY	#0

loc_74B49:
		STY	tmp_x_positions,X
		INX
		CPX	tmp_ptr_l
		BCS	locret_74B57
		CLC
		ADC	#8
		BCC	loc_74B49
		BCS	loc_74B37
; ---------------------------------------------------------------------------

loc_74B58:
		LDA	#0

loc_74B5A:
		STA	tmp_x_positions,X
		INX
		CPX	tmp_ptr_l
		BCC	loc_74B5A

loc_74B61:
		LDX	#0
		LDY	object_slot
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	objects_Y_relative_h,Y
		ADC	sonic_y_h_on_scr ; sonic-camera
		BEQ	loc_74B77
		CMP	#$FF
		BEQ	loc_74B87
locret_74B99:
		PLA
		PLA
		RTS
; ---------------------------------------------------------------------------

loc_74B77:
		LDA	tmp_var_2B

loc_74B79:
		STA	tmp_y_positions,X
		INX
		CPX	tmp_ptr_l+1
		BCS	loc_74BA3
		CLC
		ADC	#8
		BCC	loc_74B79
		LDA	#0

loc_74B9C:
		STA	tmp_y_positions,X
		INX
		CPX	tmp_ptr_l+1
		BCC	loc_74B9C

loc_74BA3:	
		RTS
; ---------------------------------------------------------------------------

loc_74B87:
		LDA	tmp_var_2B
		LDY	#0

loc_74B8B:
		STY	tmp_y_positions,X
		INX
		CPX	tmp_ptr_l+1
		BCS	locret_74B99
		CLC
		ADC	#8
		BCC	loc_74B8B
		BCS	loc_74B79
; ---------------------------------------------------------------------------


draw_water_splash:
		LDA	objects_X_l,Y
		SEC
		SBC	camera_X_l_new
		STA	tmp_var_25
		
		LDA	objects_Y_relative_l,Y
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_26
		LDY	#3
		LDX	sprite_id
@loop		
		LDA	tmp_var_25
		CLC
		ADC	splash_x,Y
		STA	sprites_X,X
		LDA	tmp_var_26
		CLC
		ADC	splash_y,Y
		STA	sprites_Y,X
		LDA	splash_tls,Y
		STA	sprites_tile,X
		LDA	splash_attr,Y
		STA	sprites_attr,X
		INX4
		BEQ	@spr_limit
		DEY
		BPL	@loop
@spr_limit:
		STX	sprite_id
		RTS
; ---------------------------------------------------------------------------

splash_x:
		.BYTE	$F8,$10,$F8,$10
splash_y:
		.BYTE	$04,$04,$0C,$0C
splash_tls:
		.BYTE	$E2,$E2,$E0,$E0
splash_attr:
		.BYTE	$03,$43,$03,$43


; =============== S U B	R O U T	I N E =======================================	


s_attr		equ	$25
base_tile_num	equ	$26
obj_Y_on_screen_h equ	$27
obj_Y_on_screen	equ	$28
;			$29
obj_X_on_screen_h equ	$2A
obj_X_on_screen equ	$2B

s_cfg_l 	equ	$3D
s_cfg_h		equ	$3E
sprite_id_prev	equ	$3F


		align	256

; fast for single sprite
draw_single_sprite_pos:
		LDA	objects_X_l,X
		SEC
		SBC	camera_X_l_new
		STA	obj_X_on_screen
		LDA	objects_X_h,X
		SBC	camera_X_h_new
		BNE	no_draw_sprite
		LDA	objects_Y_relative_l,X
		CLC
		ADC	sonic_y_on_scr
		STA	obj_Y_on_screen
		LDA	objects_Y_relative_h,X
		ADC	sonic_y_h_on_scr
		BNE	no_draw_sprite
		LDA	obj_Y_on_screen
		CMP	#$E8
		BCS	no_draw_sprite
		LDY	sprite_id
		STA	sprites_Y,Y
		LDA	obj_X_on_screen
		STA	sprites_X,Y
		TYA
		CLC
		ADC	#4
		STA	sprite_id
		RTS

no_draw_sprite:
		PLA	; exit loop
		PLA
		RTS
		
draw_sprite_new_X:
		STA	s_attr
		STX	base_tile_num

		LDX	object_slot
		LDA	tmp_var_27
		SEC
		SBC	camera_X_l_new
		STA	obj_X_on_screen
		LDA	tmp_var_28
		JMP	draw_sprite_new_x_

; input: Y = ptr number
draw_sprite_new_tile0_attr0:
		LDX	#0
draw_sprite_new_attr0:
		LDA	#0
; input: Y = ptr number, A = attribs, X = base tile number
; returns BEQ = if no sprite
draw_sprite_new:
		STA	s_attr
		STX	base_tile_num

		LDX	object_slot
		LDA	objects_X_l,X
		SEC
		SBC	camera_X_l_new
		STA	obj_X_on_screen
		LDA	objects_X_h,X
draw_sprite_new_x_:
		SBC	camera_X_h_new
		BEQ	@ok_x
		CMP	#$FF
		BNE	no_draw_sprite
@ok_x
		STA	obj_X_on_screen_h
		LDA	objects_Y_relative_l,X
		CLC
		ADC	sonic_y_on_scr
		STA	obj_Y_on_screen
		LDA	objects_Y_relative_h,X
		ADC	sonic_y_h_on_scr ; sonic-camera
		BEQ	@ok_y
		CMP	#$FF
		BNE	no_draw_sprite
@ok_y
		STA	obj_Y_on_screen_h
		;TAX
		
		LDA	spr_cfg_ptrs_l,Y
		STA	s_cfg_l
		LDA	spr_cfg_ptrs_h,Y
		STA	s_cfg_h
		
		LDA	sprite_id
		STA	sprite_id_prev
		TAY
		EOR	#$FF
		SEC
		ADC	s_cfg_l
		BCS	@no_dec_h
		DEC	s_cfg_h

@no_dec_h:
		STA	s_cfg_l
		
draw_sprite_new_loop:
		LDA	(s_cfg_l),Y
		BMI	@done_spr_draw
		CLC
		ADC	obj_Y_on_screen
		STA	sprites_Y,Y	; write Y
		TAX
		LDA	obj_Y_on_screen_h
		ADC	#0
		BNE	@skip_spr_partY
		CPX	#$E8
		BCS	@skip_spr_partY
		INY
		LDA	(s_cfg_l),Y
		; CLC
		ADC	base_tile_num
		STA	sprites_Y,Y ; write tile
		INY		
		LDA	(s_cfg_l),Y
		EOR	s_attr
		STA	sprites_Y,Y ; write attr
		INY
		LDA	(s_cfg_l),Y
		CLC
		ADC	obj_X_on_screen
		STA	sprites_Y,Y ; write X
		LDA	obj_X_on_screen_h
		ADC	#0
		BNE	@skip_spr_part
		INY
		BNE	draw_sprite_new_loop
		BEQ	@sprite_limit_
		
@done_spr_draw:
		;LDA	#$F0
		STA	sprites_Y,Y	; write Y
		
@sprite_limit_:
		STY	sprite_id
		CPY	sprite_id_prev
		RTS
; ---------------------------------------------------------------------------

@skip_spr_part:
		DEY
		DEY
		DEY
@skip_spr_partY:
		LDA	s_cfg_l
		CLC
		ADC	#4
		STA	s_cfg_l
		BCC	draw_sprite_new_loop
		INC	s_cfg_h
		BCS	draw_sprite_new_loop
; ---------------------------------------------------------------------------

spr_cfg_ptrs_l:
		.BYTE	<starl_bomb_spr_cfg0 ; frame1
		.BYTE	<starl_bomb_spr_cfg1 ; frame2
		.BYTE	<starl_bomb_spr_cfg2 ; frame1-h-mirror
		.BYTE	<starl_bomb_spr_cfg3 ; frame2-h-mirror
		.BYTE	<starl_bomb_spr_cfg4 ; frame1-v
		.BYTE	<starl_bomb_spr_cfg5 ; frame2-v
		.BYTE	<starl_bomb_spr_cfg6 ; frame1-vh-mirror
		.BYTE	<starl_bomb_spr_cfg7 ; frame2-vh-mirror
		
		.BYTE	<big_spike_spr_cfg ; 8
		.BYTE	<steam_roller_spr_cfg ; 9
		.BYTE	<sbz_platform_spr_cfg1 ; 10
		.BYTE	<sbz_platform_spr_cfg2 ; 11
		.BYTE	<sbz_platform_spr_cfg3 ; 12
		.BYTE	<sbz_platform_spr_cfg4 ; 13
		.BYTE	<small_platform_spr_cfg ; 14
		.BYTE	<big_platform_spr_cfg ; 15
		.BYTE	<checkpoint_spr_cfg ; 16
		.BYTE	<std_spr_cfg_16x16 ; 17
		.BYTE	<checkpoint_spr_cfg2 ; 18
		.BYTE	<circular_saw_spr_cfg1 ; 19
		.BYTE	<ring_spr_cfg1 ; 20
		.BYTE	<ring_spr_cfg2 ; 21
		.BYTE	<ring_spr_cfg3 ; 22
		.BYTE	<ring_spr_cfg4 ; 23
		.BYTE	<circular_saw_spr_cfg ; 24
		.BYTE	<circular_saw2_spr_cfg ; 25
		.BYTE	<std_spr_cfg2_16x16 ; 26
		.BYTE	<std_spr_cfg3_16x16 ; 27
		.BYTE	<ballhog_ball_16x16_cfg1 ; 28
		.BYTE	<ballhog_ball_16x16_cfg2 ; 29
		.BYTE	<circular_saw_spr_cfg_low ; 30
		.BYTE	<circular_saw2_spr_cfg_low ; 31
		.BYTE	<circular_saw3_spr_cfg ; 32
		.BYTE	<circular_saw3_spr_cfg2 ; 33
		.BYTE	<pick_ring_anim_cfg1 ; 34
		.BYTE	<pick_ring_anim_cfg2 ; 35
		.BYTE	<pick_ring_anim_cfg3 ; 36
		.BYTE	<pick_ring_anim_cfg4 ; 37
		
		.BYTE	<flipper_spr_cfg1 ; 38
		.BYTE	<flipper_spr_cfg2 ; 39
		.BYTE	<flipper_spr_cfg3 ; 40
		
		.BYTE	<flipper_spr_cfg1m ; 41
		.BYTE	<flipper_spr_cfg2m ; 42
		.BYTE	<flipper_spr_cfg3m ; 43	

		.BYTE	<big_ring_spr_cfg1 ; 44
		.BYTE	<big_ring_spr_cfg2 ; 45
		.BYTE	<big_ring_spr_cfg3 ; 46
		.BYTE	<big_ring_spr_cfg4 ; 47
		
		.BYTE	<signpost_eggman ; 48
		.BYTE	<signpost_roll1 ; 49
		.BYTE	<signpost_roll2 ; 50
		.BYTE	<signpost_roll3 ; 51
		.BYTE	<signpost_sonic ; 52
		.BYTE	<signpost_ring ; 53
		.BYTE	<signpost_emerald ; 54
		
		.BYTE	<signpost_roll1a ; 55
		.BYTE	<signpost_roll3a ; 56
		.BYTE	<gargoyle_projectile ; 57
		.BYTE	<gargoyle_projectile_r ; 58
		
spr_cfg_ptrs_h:
		.BYTE	>starl_bomb_spr_cfg0 ; frame1
		.BYTE	>starl_bomb_spr_cfg1 ; frame2
		.BYTE	>starl_bomb_spr_cfg2 ; frame1-h-mirror
		.BYTE	>starl_bomb_spr_cfg3 ; frame2-h-mirror
		.BYTE	>starl_bomb_spr_cfg4 ; frame1-v
		.BYTE	>starl_bomb_spr_cfg5 ; frame2-v
		.BYTE	>starl_bomb_spr_cfg6 ; frame1-vh-mirror
		.BYTE	>starl_bomb_spr_cfg7 ; frame2-vh-mirror
		
		.BYTE	>big_spike_spr_cfg ; 8
		.BYTE	>steam_roller_spr_cfg ; 9
		.BYTE	>sbz_platform_spr_cfg1 ; 10
		.BYTE	>sbz_platform_spr_cfg2 ; 11
		.BYTE	>sbz_platform_spr_cfg3 ; 12
		.BYTE	>sbz_platform_spr_cfg4 ; 13
		.BYTE	>small_platform_spr_cfg ; 14
		.BYTE	>big_platform_spr_cfg ; 15
		.BYTE	>checkpoint_spr_cfg ; 16
		.BYTE	>std_spr_cfg_16x16 ; 17
		.BYTE	>checkpoint_spr_cfg2 ; 18
		.BYTE	>circular_saw_spr_cfg1 ; 19
		.BYTE	>ring_spr_cfg1 ; 20
		.BYTE	>ring_spr_cfg2 ; 21
		.BYTE	>ring_spr_cfg3 ; 22
		.BYTE	>ring_spr_cfg4 ; 23
		.BYTE	>circular_saw_spr_cfg ; 24
		.BYTE	>circular_saw2_spr_cfg ; 25
		.BYTE	>std_spr_cfg2_16x16 ; 26
		.BYTE	>std_spr_cfg3_16x16 ; 27
		.BYTE	>ballhog_ball_16x16_cfg1 ; 28
		.BYTE	>ballhog_ball_16x16_cfg2 ; 29
		.BYTE	>circular_saw_spr_cfg_low ; 30
		.BYTE	>circular_saw2_spr_cfg_low ; 31
		.BYTE	>circular_saw3_spr_cfg ; 32
		.BYTE	>circular_saw3_spr_cfg2 ; 33
		.BYTE	>pick_ring_anim_cfg1 ; 34
		.BYTE	>pick_ring_anim_cfg2 ; 35
		.BYTE	>pick_ring_anim_cfg3 ; 36
		.BYTE	>pick_ring_anim_cfg4 ; 37
		
		.BYTE	>flipper_spr_cfg1 ; 38
		.BYTE	>flipper_spr_cfg2 ; 39
		.BYTE	>flipper_spr_cfg3 ; 40
		
		.BYTE	>flipper_spr_cfg1m ; 41
		.BYTE	>flipper_spr_cfg2m ; 42
		.BYTE	>flipper_spr_cfg3m ; 43
		
		.BYTE	>big_ring_spr_cfg1 ; 44
		.BYTE	>big_ring_spr_cfg2 ; 45
		.BYTE	>big_ring_spr_cfg3 ; 46
		.BYTE	>big_ring_spr_cfg4 ; 47
		
		.BYTE	>signpost_eggman ; 48
		.BYTE	>signpost_roll1 ; 49
		.BYTE	>signpost_roll2 ; 50
		.BYTE	>signpost_roll3 ; 51
		.BYTE	>signpost_sonic ; 52
		.BYTE	>signpost_ring ; 53
		.BYTE	>signpost_emerald ; 54
		
		.BYTE	>signpost_roll1a ; 55
		.BYTE	>signpost_roll3a ; 56
		
		.BYTE	>gargoyle_projectile ; 57
		.BYTE	>gargoyle_projectile_r ; 58
		
starl_bomb_spr_cfg0:
		.BYTE  $00, $00, $00, $04
		.BYTE  $08, $03, $00, $00, $08, $04, $00, $08
		.BYTE  $10, $05, $00, $00, $10, $06, $00, $08
		.BYTE  $18, $07, $00, $00, $18, $08, $00, $08
		.BYTE	$F0
		
starl_bomb_spr_cfg1:
		.BYTE  $00, $01, $00, $00, $00, $02, $00, $08
		.BYTE  $08, $03, $00, $00, $08, $04, $00, $08
		.BYTE  $10, $05, $00, $00, $10, $06, $00, $08
		.BYTE  $18, $07, $00, $00, $18, $08, $00, $08
		.BYTE	$F0
		
starl_bomb_spr_cfg2:
		.BYTE  $00, $00, $40, $04
		.BYTE  $08, $04, $40, $00, $08, $03, $40, $08
		.BYTE  $10, $06, $40, $00, $10, $05, $40, $08
		.BYTE  $18, $08, $40, $00, $18, $07, $40, $08
		.BYTE	$F0
		
starl_bomb_spr_cfg3:
		.BYTE  $00, $02, $40, $00, $00, $01, $40, $08
		.BYTE  $08, $04, $40, $00, $08, $03, $40, $08
		.BYTE  $10, $06, $40, $00, $10, $05, $40, $08
		.BYTE  $18, $08, $40, $00, $18, $07, $40, $08
		.BYTE	$F0
		
starl_bomb_spr_cfg4:
		.BYTE  $00, $07, $80, $00, $00, $08, $80, $08
		.BYTE  $08, $05, $80, $00, $08, $06, $80, $08
		.BYTE  $10, $03, $80, $00, $10, $04, $80, $08
		.BYTE  $18, $00, $80, $04
		.BYTE	$F0
		
starl_bomb_spr_cfg5:
		.BYTE  $00, $07, $80, $00, $00, $08, $80, $08
		.BYTE  $08, $05, $80, $00, $08, $06, $80, $08
		.BYTE  $10, $03, $80, $00, $10, $04, $80, $08
		.BYTE  $18, $01, $80, $00, $18, $02, $80, $08
		.BYTE	$F0
		
starl_bomb_spr_cfg6:
		.BYTE  $00, $08, $C0, $00, $00, $07, $C0, $08
		.BYTE  $08, $06, $C0, $00, $08, $05, $C0, $08
		.BYTE  $10, $04, $C0, $00, $10, $03, $C0, $08
		.BYTE  $18, $00, $C0, $04
		.BYTE	$F0
		
starl_bomb_spr_cfg7:
		.BYTE  $00, $08, $C0, $00, $00, $07, $C0, $08
		.BYTE  $08, $06, $C0, $00, $08, $05, $C0, $08
		.BYTE  $10, $04, $C0, $00, $10, $03, $C0, $08
		.BYTE  $18, $02, $C0, $00, $18, $01, $C0, $08
		.BYTE	$F0
		
big_spike_spr_cfg:
		.BYTE	$00,$00,$02,$00, $00,$01,$02,$08, $00,$02,$02,$10, $00,$03,$02,$18
		.BYTE	$08,$04,$02,$00, $08,$05,$02,$08, $08,$06,$02,$10, $08,$07,$02,$18
		.BYTE	$10,$08,$02,$00, $10,$09,$02,$08, $10,$0A,$02,$10, $10,$0B,$02,$18
		.BYTE	$18,$0C,$02,$00, $18,$0D,$02,$08, $18,$0E,$02,$10, $18,$0F,$02,$18
		.BYTE	$F0
		
steam_roller_spr_cfg:
;		.BYTE	$00,$00,$00,$00, $00,$01,$00,$08, $00,$01,$40,$10, $00,$00,$40,$18
		.BYTE	$00,$06,$03,$00, $00,$07,$03,$08, $00,$07,$03,$10, $00,$06,$43,$18
		.BYTE	$08,$02,$01,$00, $08,$03,$01,$08, $08,$03,$41,$10, $08,$02,$41,$18
		.BYTE	$10,$04,$01,$00, $10,$05,$01,$08, $10,$05,$41,$10, $10,$04,$41,$18
		.BYTE	$18,$02,$81,$00, $18,$03,$81,$08, $18,$03,$C1,$10, $18,$02,$C1,$18
;		.BYTE	$20,$00,$80,$00, $20,$01,$80,$08, $20,$01,$C0,$10, $20,$00,$C0,$18
		.BYTE	$20,$06,$03,$00, $20,$07,$03,$08, $20,$07,$03,$10, $20,$06,$43,$18
		.BYTE	$F0
		
sbz_platform_spr_cfg1:
		.BYTE	$08,$A9,$02,$00, $08,$AA,$02,$08, $08,$AA,$42,$10, $08,$A9,$42,$18
		.BYTE	$10,$A9,$82,$00, $10,$AA,$82,$08, $10,$AA,$C2,$10, $10,$A9,$C2,$18
		.BYTE	$F0
		
sbz_platform_spr_cfg2:
		.BYTE	$00,$B1,$02,$00, $00,$B2,$02,$08
		.BYTE	$08,$B3,$02,$00, $08,$B4,$02,$08, $08,$B5,$02,$10
		.BYTE	$10,$B5,$C2,$08, $10,$B4,$C2,$10, $10,$B3,$C2,$18
		.BYTE	$18,$B2,$C2,$10, $18,$B1,$C2,$18
		.BYTE	$F0
		
sbz_platform_spr_cfg3:
		.BYTE	$00,$AB,$02,$08, $00,$AB,$42,$10
		.BYTE	$08,$AC,$02,$08, $08,$AC,$42,$10
		.BYTE	$10,$AC,$82,$08, $10,$AC,$C2,$10
		.BYTE	$18,$AB,$82,$08, $18,$AB,$C2,$10
		.BYTE	$F0

sbz_platform_spr_cfg4:
		.BYTE	$00,$B2,$42,$10, $00,$B1,$42,$18
		.BYTE	$08,$B5,$42,$08, $08,$B4,$42,$10, $08,$B3,$42,$18
		.BYTE	$10,$B3,$82,$00, $10,$B4,$82,$08, $10,$B5,$82,$10
		.BYTE	$18,$B1,$82,$00, $18,$B2,$82,$08
		.BYTE	$F0

small_platform_spr_cfg:
		.BYTE	$00,$00,$00,$00, $00,$03,$00,$08, $00,$00,$00,$10, $00,$03,$00,$18
		.BYTE	$08,$01,$00,$00, $08,$04,$00,$08, $08,$01,$00,$10, $08,$04,$00,$18
		.BYTE	$F0
		
big_platform_spr_cfg:
		.BYTE	$00,$00,$02,$00, $00,$02,$02,$08, $00,$02,$02,$10, $00,$02,$02,$18, $00,$05,$02,$20
		.BYTE	$08,$01,$03,$00, $08,$03,$03,$08, $08,$03,$03,$10, $08,$03,$03,$18, $08,$04,$03,$20
		.BYTE	$10,$00,$02,$00, $10,$02,$02,$08, $10,$02,$02,$10, $10,$02,$02,$18, $10,$05,$02,$20
		.BYTE	$F0
		
checkpoint_spr_cfg:
		.BYTE	$10,$6F,$01,$04
		.BYTE	$18,$6F,$01,$04
		.BYTE	$20,$6F,$01,$04
		.BYTE	$28,$6F,$01,$04
		.BYTE	$30,$74,$03,$00, $30,$74,$43,$08
		.BYTE	$38,$75,$03,$00, $38,$75,$43,$08
		.BYTE	$F0
		
std_spr_cfg_16x16:
		.BYTE	$00,$00,$00,$00, $00,$01,$00,$08
		.BYTE	$08,$02,$00,$00, $08,$03,$00,$08
		.BYTE	$F0
		
std_spr_cfg2_16x16:
		.BYTE	$00,$00,$00,$00, $00,$02,$00,$08
		.BYTE	$08,$01,$00,$00, $08,$03,$00,$08
		.BYTE	$F0
		
std_spr_cfg3_16x16
		.BYTE	$00,$00,$00,$00, $00,$00,$40,$08
		.BYTE	$08,$00,$80,$00, $08,$00,$C0,$08
		.BYTE	$F0
		
checkpoint_spr_cfg2:
		.BYTE	$00,$60,$00,$00, $00,$60,$40,$08
		.BYTE	$08,$60,$80,$00, $08,$60,$C0,$08
		.BYTE	$F0
		
circular_saw_spr_cfg1:
		.BYTE	$00,$01,$00,$08, $00,$02,$00,$10, $00,$03,$00,$18
		.BYTE	$00,$03,$40,$20, $00,$02,$40,$28, $00,$01,$40,$30
		
		.BYTE	$08,$04,$00,$00, $08,$05,$00,$08, $08,$06,$00,$10, $08,$07,$00,$18
		.BYTE	$08,$07,$40,$20, $08,$06,$40,$28, $08,$05,$40,$30, $08,$04,$40,$38
	
		.BYTE	$10,$08,$00,$00, $10,$09,$00,$08, $10,$0A,$00,$10, $10,$0B,$00,$18
		.BYTE	$10,$0B,$40,$20, $10,$0A,$40,$28, $10,$09,$40,$30, $10,$08,$40,$38
		.BYTE	$F0
		
circular_saw_spr_cfg:
		.BYTE	$00,$01,$00,$08, $00,$02,$00,$10, $00,$03,$00,$18
		.BYTE	$00,$03,$40,$20, $00,$02,$40,$28, $00,$01,$40,$30
		
		.BYTE	$08,$04,$00,$00, $08,$05,$00,$08, $08,$06,$00,$10, $08,$07,$00,$18
		.BYTE	$08,$07,$40,$20, $08,$06,$40,$28, $08,$05,$40,$30, $08,$04,$40,$38
	
		.BYTE	$10,$08,$00,$00, $10,$09,$00,$08, $10,$0A,$00,$10, $10,$0B,$00,$18
		.BYTE	$10,$0B,$40,$20, $10,$0A,$40,$28, $10,$09,$40,$30, $10,$08,$40,$38
		
		.BYTE	$18,$0C,$00,$00, $18,$0D,$00,$08, $18,$0E,$00,$10, $18,$0F,$00,$18
		.BYTE	$18,$0F,$40,$20, $18,$0E,$40,$28, $18,$0D,$40,$30, $18,$0C,$40,$38
		
		.BYTE	$F0
		
circular_saw2_spr_cfg:
		.BYTE	$20,$0C,$80,$00, $20,$0D,$80,$08, $20,$0E,$80,$10, $20,$0F,$80,$18
		.BYTE	$20,$0F,$C0,$20, $20,$0E,$C0,$28, $20,$0D,$C0,$30, $20,$0C,$C0,$38

		.BYTE	$28,$08,$80,$00, $28,$09,$80,$08, $28,$0A,$80,$10, $28,$0B,$80,$18
		.BYTE	$28,$0B,$C0,$20, $28,$0A,$C0,$28, $28,$09,$C0,$30, $28,$08,$C0,$38
circular_saw2_spr_cfg_low:
		.BYTE	$30,$04,$80,$00, $30,$05,$80,$08, $30,$06,$80,$10, $30,$07,$80,$18
		.BYTE	$30,$07,$C0,$20, $30,$06,$C0,$28, $30,$05,$C0,$30, $30,$04,$C0,$38
		
		.BYTE	$38,$01,$80,$08, $38,$02,$80,$10, $38,$03,$80,$18
		.BYTE	$38,$03,$C0,$20, $38,$02,$C0,$28, $38,$01,$C0,$30
		
		.BYTE	$F0
		
circular_saw_spr_cfg_low:
		.BYTE	$20,$0C,$80,$00, $20,$0D,$80,$08, $20,$0E,$80,$10, $20,$0F,$80,$18
		.BYTE	$20,$0F,$C0,$20, $20,$0E,$C0,$28, $20,$0D,$C0,$30, $20,$0C,$C0,$38

		.BYTE	$28,$08,$80,$00, $28,$09,$80,$08, $28,$0A,$80,$10, $28,$0B,$80,$18
		.BYTE	$28,$0B,$C0,$20, $28,$0A,$C0,$28, $28,$09,$C0,$30, $28,$08,$C0,$38
		.BYTE	$F0
		
		
circular_saw3_spr_cfg:
		.BYTE	$00,$02,$00,$00, $00,$03,$00,$08, $00,$04,$00,$10
		.BYTE	$00,$04,$40,$18, $00,$03,$40,$20, $00,$02,$40,$28
		
		.BYTE	$08,$05,$00,$00, $08,$06,$00,$08, $08,$07,$00,$10
		.BYTE	$08,$07,$40,$18, $08,$06,$40,$20, $08,$05,$40,$28
		
		.BYTE	$10,$08,$00,$00, $10,$09,$00,$08, $10,$0A,$00,$10
		.BYTE	$10,$0A,$40,$18, $10,$09,$40,$20, $10,$08,$40,$28
		
		.BYTE	$F0
		
circular_saw3_spr_cfg2:
		.BYTE	$18,$08,$80,$00, $18,$09,$80,$08, $18,$0A,$80,$10
		.BYTE	$18,$0A,$C0,$18, $18,$09,$C0,$20, $18,$08,$C0,$28
		
		.BYTE	$20,$05,$80,$00, $20,$06,$80,$08, $20,$07,$80,$10
		.BYTE	$20,$07,$C0,$18, $20,$06,$C0,$20, $20,$05,$C0,$28
		
		.BYTE	$28,$02,$80,$00, $28,$03,$80,$08, $28,$04,$80,$10
		.BYTE	$28,$04,$C0,$18, $28,$03,$C0,$20, $28,$02,$C0,$28
		
		.BYTE	$F0
		
;circular_saw_spr_cfg_alt:
;		.BYTE	$00,$02,$00,$10, $00,$03,$00,$18, $00,$01,$00,$08
;		.BYTE	$00,$02,$40,$28, $00,$01,$40,$30, $00,$03,$40,$20
;		
;		.BYTE	$08,$06,$00,$10, $08,$07,$00,$18, $08,$04,$00,$00, $08,$05,$00,$08
;		.BYTE	$08,$05,$40,$30, $08,$04,$40,$38, $08,$07,$40,$20, $08,$06,$40,$28
;		
;		.BYTE	$10,$0A,$00,$10, $10,$0B,$00,$18, $10,$08,$00,$00, $10,$09,$00,$08
;		.BYTE	$10,$09,$40,$30, $10,$08,$40,$38, $10,$0B,$40,$20, $10,$0A,$40,$28
;		
;		.BYTE	$18,$0E,$00,$10, $18,$0F,$00,$18, $18,$0C,$00,$00, $18,$0D,$00,$08
;		.BYTE	$18,$0D,$40,$30, $18,$0C,$40,$38, $18,$0F,$40,$20, $18,$0E,$40,$28
;		
;		.BYTE	$F0
;		
;circular_saw2_spr_cfg_alt:
;		.BYTE	$20,$0E,$80,$10, $20,$0F,$80,$18, $20,$0C,$80,$00, $20,$0D,$80,$08
;		.BYTE	$20,$0D,$C0,$30, $20,$0C,$C0,$38, $20,$0F,$C0,$20, $20,$0E,$C0,$28
;		
;		.BYTE	$28,$0A,$80,$10, $28,$0B,$80,$18, $28,$08,$80,$00, $28,$09,$80,$08
;		.BYTE	$28,$09,$C0,$30, $28,$08,$C0,$38, $28,$0B,$C0,$20, $28,$0A,$C0,$28
;		
;		.BYTE	$30,$06,$80,$10, $30,$07,$80,$18, $30,$04,$80,$00, $30,$05,$80,$08
;		.BYTE	$30,$05,$C0,$30, $30,$04,$C0,$38, $30,$07,$C0,$20, $30,$06,$C0,$28
;		
;		.BYTE	$38,$02,$80,$10, $38,$03,$80,$18, $38,$01,$80,$08
;		.BYTE	$38,$02,$C0,$28, $38,$01,$C0,$30, $38,$03,$C0,$20
;		
;		.BYTE	$F0
		
;circular_saw2_spr_cfg3:
;		.BYTE	$00,$01,$00,$08
;		.BYTE	$00,$03,$40,$20
;		
;		.BYTE	$08,$04,$00,$00, $08,$05,$00,$08
;		.BYTE	$08,$07,$40,$20, $08,$06,$40,$28
;		
;		.BYTE	$10,$08,$00,$00, $10,$09,$00,$08
;		.BYTE	$10,$0B,$40,$20, $10,$0A,$40,$28
;		
;		.BYTE	$18,$0C,$00,$00, $18,$0D,$00,$08
;		.BYTE	$18,$0F,$40,$20, $18,$0E,$40,$28
;		
;		.BYTE	$20,$0C,$80,$00, $20,$0D,$80,$08
;		.BYTE	$20,$0F,$C0,$20, $20,$0E,$C0,$28
;		
;		.BYTE	$28,$08,$80,$00, $28,$09,$80,$08
;		.BYTE	$28,$0B,$C0,$20, $28,$0A,$C0,$28
;		
;		.BYTE	$30,$04,$80,$00, $30,$05,$80,$08
;		.BYTE	$30,$07,$C0,$20, $30,$06,$C0,$28
;		
;		.BYTE	$38,$01,$80,$08
;		.BYTE	$38,$03,$C0,$20
;		
;		.BYTE	$F0
;		
;circular_saw2_spr_cfg4:
;		.BYTE	$00,$02,$00,$10, $00,$03,$00,$18
;		.BYTE	$00,$02,$40,$28, $00,$01,$40,$30
;		
;		.BYTE	$08,$06,$00,$10, $08,$07,$00,$18
;		.BYTE	$08,$05,$40,$30, $08,$04,$40,$38
;		
;		.BYTE	$10,$0A,$00,$10, $10,$0B,$00,$18
;		.BYTE	$10,$09,$40,$30, $10,$08,$40,$38
;		
;		.BYTE	$18,$0E,$00,$10, $18,$0F,$00,$18
;		.BYTE	$18,$0D,$40,$30, $18,$0C,$40,$38
;		
;		.BYTE	$20,$0E,$80,$10, $20,$0F,$80,$18
;		.BYTE	$20,$0D,$C0,$30, $20,$0C,$C0,$38
;		
;		.BYTE	$28,$0A,$80,$10, $28,$0B,$80,$18
;		.BYTE	$28,$09,$C0,$30, $28,$08,$C0,$38
;		
;		.BYTE	$30,$06,$80,$10, $30,$07,$80,$18
;		.BYTE	$30,$05,$C0,$30, $30,$04,$C0,$38
;		
;		.BYTE	$38,$02,$80,$10, $38,$03,$80,$18
;		.BYTE	$38,$02,$C0,$28, $38,$01,$C0,$30
;		
;		.BYTE	$F0

pick_ring_anim_cfg1:
		.BYTE	$00,$70,$00,$00
		.BYTE	                 $08,$71,$00,$08
		.BYTE	$F0

pick_ring_anim_cfg2:
		.BYTE	                 $00,$70,$00,$08
		.BYTE	$08,$71,$00,$00
		.BYTE	$F0
		
pick_ring_anim_cfg3:
		.BYTE	$00,$71,$00,$00
		.BYTE	                 $08,$70,$00,$08
		.BYTE	$F0

pick_ring_anim_cfg4:
		.BYTE	                 $00,$71,$00,$08
		.BYTE	$08,$70,$00,$00
		.BYTE	$F0


ring_spr_cfg1:
		.BYTE	$00,$E6,$03,$00, $00,$E6,$43,$08
		.BYTE	$08,$E6,$83,$00, $08,$E6,$C3,$08
		.BYTE	$F0

ring_spr_cfg2:
		.BYTE	$00,$E4,$03,$00, $00,$E5,$03,$08
		.BYTE	$08,$E4,$83,$00, $08,$E5,$83,$08
		.BYTE	$F0

ring_spr_cfg3:
		.BYTE	$00,$E7,$03,$00, $00,$E7,$43,$08
		.BYTE	$08,$E7,$83,$00, $08,$E7,$C3,$08
		.BYTE	$F0

ring_spr_cfg4:
		.BYTE	$00,$E5,$43,$00, $00,$E4,$43,$08
		.BYTE	$08,$E5,$C3,$00, $08,$E4,$C3,$08
		.BYTE	$F0	

		
ballhog_ball_16x16_cfg1:
		.BYTE	$00,$8C,$00,$00, $00,$B6,$00,$08
		.BYTE	$08,$8C,$80,$00, $08,$8C,$C0,$08
		.BYTE	$F0

ballhog_ball_16x16_cfg2:
		.BYTE	$00,$9C,$00,$00, $00,$DD,$00,$08
		.BYTE	$08,$9C,$80,$00, $08,$9C,$C0,$08
		.BYTE	$F0
		
flipper_spr_cfg1:
		.BYTE	$10,$F2,$00,$00, $10,$C2,$00,$08, $10,$C3,$00,$10, $14,$E3,$00,$18
		.BYTE	$18,$F0,$00,$00, $18,$D2,$00,$08, $18,$D3,$00,$10
		.BYTE	$F0
		
flipper_spr_cfg2:
		.BYTE	$08,$E4,$00,$08, $08,$E5,$00,$10, $08,$E6,$00,$18
		.BYTE	$10,$F2,$00,$00, $10,$F3,$00,$08, $10,$F4,$00,$10, $10,$F5,$00,$18
		.BYTE	$18,$F0,$00,$00, $18,$F6,$00,$08, $18,$F7,$00,$10
		.BYTE	$F0

flipper_spr_cfg3:
		.BYTE	$00,$C0,$00,$08, $00,$C1,$00,$10
		.BYTE	$08,$D0,$00,$04, $08,$D1,$00,$0C
		.BYTE	$10,$E0,$00,$00, $10,$E1,$00,$08, $10,$E2,$00,$10
		.BYTE	$18,$F0,$00,$00, $18,$F1,$00,$08
		.BYTE	$F0
		
flipper_spr_cfg1m:
		.BYTE	$10,$F2,$40,$18, $10,$C2,$40,$10, $10,$C3,$40,$08, $14,$E3,$40,$00
		.BYTE	$18,$F0,$40,$18, $18,$D2,$40,$10, $18,$D3,$40,$08
		.BYTE	$F0
		
flipper_spr_cfg2m:
		.BYTE	$08,$E4,$40,$10, $08,$E5,$40,$08, $08,$E6,$40,$00
		.BYTE	$10,$F2,$40,$18, $10,$F3,$40,$10, $10,$F4,$40,$08, $10,$F5,$40,$00
		.BYTE	$18,$F0,$40,$18, $18,$F6,$40,$10, $18,$F7,$40,$08
		.BYTE	$F0

flipper_spr_cfg3m:
		.BYTE	$00,$C0,$40,$10, $00,$C1,$40,$08
		.BYTE	$08,$D0,$40,$14, $08,$D1,$40,$0C
		.BYTE	$10,$E0,$40,$18, $10,$E1,$40,$10, $10,$E2,$40,$08
		.BYTE	$18,$F0,$40,$18, $18,$F1,$40,$10
		.BYTE	$F0
		
big_ring_spr_cfg1:
		.BYTE	$00,$D0,$03,$00, $00,$8F,$03,$08, $00,$8F,$43,$10, $00,$D0,$43,$18
		.BYTE	$08,$D1,$03,$00, $08,$92,$03,$08, $08,$92,$43,$10, $08,$D1,$43,$18
		.BYTE	$10,$D1,$83,$00, $10,$92,$83,$08, $10,$92,$C3,$10, $10,$D1,$C3,$18
		.BYTE	$18,$D0,$83,$00, $18,$8F,$83,$08, $18,$8F,$C3,$10, $18,$D0,$C3,$18
		.BYTE	$F0
big_ring_spr_cfg2:
		.BYTE	$00,$8A,$03,$04, $00,$8C,$03,$0C, $00,$8E,$03,$14
		.BYTE	$08,$8B,$03,$04,                  $08,$8D,$03,$14
		.BYTE	$10,$8B,$83,$04,                  $10,$8D,$83,$14
		.BYTE	$18,$8A,$83,$04, $18,$8C,$83,$0C, $18,$8E,$83,$14
		.BYTE	$F0
big_ring_spr_cfg3:
		.BYTE	$00,$90,$03,$08, $00,$90,$43,$10
		.BYTE	$08,$91,$03,$08, $08,$91,$43,$10
		.BYTE	$10,$B0,$03,$08, $10,$B0,$43,$10
		.BYTE	$18,$B1,$03,$08, $18,$B1,$43,$10
		.BYTE	$F0
big_ring_spr_cfg4:
		.BYTE	$00,$8E,$43,$04, $00,$8C,$43,$0C, $00,$8A,$43,$14
		.BYTE	$08,$8D,$43,$04,                  $08,$8B,$43,$14
		.BYTE	$10,$8D,$C3,$04,                  $10,$8B,$C3,$14
		.BYTE	$18,$8E,$C3,$04, $18,$8C,$C3,$0C, $18,$8A,$C3,$14
		.BYTE	$F0


;big_ring_spr_cfg1:
;		.BYTE	$00,$C7,$43,$00, $00,$DD,$43,$08, $00,$DD,$03,$10, $00,$C7,$03,$18
;		.BYTE	$08,$D7,$43,$00, $08,$8C,$43,$08, $08,$8C,$03,$10, $08,$D7,$03,$18
;		.BYTE	$10,$D7,$C3,$00, $10,$8C,$C3,$08, $10,$8C,$83,$10, $10,$D7,$83,$18
;		.BYTE	$18,$C7,$C3,$00, $18,$DD,$C3,$08, $18,$DD,$83,$10, $18,$C7,$83,$18
;		.BYTE	$F0
;big_ring_spr_cfg2:
;		.BYTE	$00,$D8,$03,$04, $00,$D9,$03,$0C, $00,$DA,$03,$14
;		.BYTE	$08,$DB,$03,$04,                  $08,$DC,$03,$14
;		.BYTE	$10,$DB,$83,$04,                  $10,$DC,$83,$14
;		.BYTE	$18,$D8,$83,$04, $18,$D9,$83,$0C, $18,$DA,$83,$14
;		.BYTE	$F0
;big_ring_spr_cfg3:
;		.BYTE	$00,$87,$43,$08, $00,$87,$03,$10
;		.BYTE	$08,$97,$43,$08, $08,$97,$03,$10
;		.BYTE	$10,$A7,$43,$08, $10,$A7,$03,$10
;		.BYTE	$18,$B7,$43,$08, $18,$B7,$03,$10
;		.BYTE	$F0
;big_ring_spr_cfg4:
;		.BYTE	$00,$DA,$43,$04, $00,$D9,$43,$0C, $00,$D8,$43,$14
;		.BYTE	$08,$DC,$43,$04,                  $08,$DB,$43,$14
;		.BYTE	$10,$DC,$C3,$04,                  $10,$DB,$C3,$14
;		.BYTE	$18,$DA,$C3,$04, $18,$D9,$C3,$0C, $18,$D8,$C3,$14
;		.BYTE	$F0
		
signpost_eggman:
		.BYTE	$00,$80,$00,$00, $00,$81,$00,$08, $00,$82,$00,$10, $00,$81,$40,$18, $00,$80,$40,$20
		.BYTE	$08,$87,$00,$00, $08,$97,$00,$08, $08,$A7,$00,$10, $08,$97,$40,$18, $08,$87,$40,$20
		.BYTE	$10,$A0,$00,$00, $10,$A1,$00,$08, $10,$A2,$00,$10, $10,$A1,$40,$18, $10,$A0,$40,$20
		.BYTE	$18,$D7,$00,$00, $18,$D8,$00,$08, $18,$B2,$00,$10, $18,$D8,$40,$18, $18,$D7,$40,$20
		.BYTE					  $20,$C1,$01,$10
		.BYTE					  $28,$C7,$01,$10
		.BYTE	$F0

signpost_sonic:
		.BYTE	$00,$88,$01,$00, $00,$89,$01,$08, $00,$D9,$01,$10, $00,$DA,$01,$18, $00,$80,$41,$20
		.BYTE	$08,$98,$01,$00, $08,$99,$01,$08, $08,$9A,$01,$10, $08,$9B,$01,$18, $08,$9C,$01,$20
		.BYTE	$10,$A8,$01,$00, $10,$A9,$01,$08, $10,$AA,$01,$10, $10,$AB,$01,$18, $10,$AC,$01,$20
		.BYTE	$18,$B8,$01,$00, $18,$B9,$01,$08, $18,$BA,$01,$10, $18,$BB,$01,$18, $18,$BC,$01,$20
		.BYTE					  $20,$C1,$01,$10
		.BYTE					  $28,$C7,$01,$10
		.BYTE	$F0
		
signpost_ring:
		;.BYTE	$08,$80,$01,$00, $08,$83,$01,$08, $08,$93,$01,$10, $08,$83,$41,$18, $08,$80,$41,$20
		.BYTE	$10,$C2,$01,$00, $10,$C2,$41,$20
		.BYTE	$18,$C2,$01,$00, $18,$C2,$41,$20
		;.BYTE	$18,$D2,$01,$00, $18,$B3,$01,$08, $18,$B3,$01,$10, $18,$B3,$01,$18, $18,$D2,$41,$20
		.BYTE					  $28,$C1,$01,$10
		.BYTE					  $30,$C7,$01,$10
		
		.BYTE	$08,$80,$01,$00, $08,$80,$41,$20
		.BYTE	$20,$D2,$01,$00, $20,$D2,$41,$20
		
		.BYTE	$04,$B3,$01,$08, $04,$C3,$01,$10, $04,$B3,$01,$18
		
		.BYTE	$0D,$84,$03,$08, $0D,$85,$03,$10, $0D,$86,$03,$18
		.BYTE	$15,$94,$03,$08,                  $15,$96,$03,$18
		.BYTE	$1D,$A4,$03,$08, $1D,$A5,$03,$10, $1D,$A6,$03,$18
		
		.BYTE	$25,$D3,$01,$08, $25,$D3,$01,$10, $25,$D3,$01,$18
		
		.BYTE	$F0
		
signpost_emerald:
		;.BYTE	$08,$80,$01,$00, $08,$83,$01,$08, $08,$93,$01,$10, $08,$83,$41,$18, $08,$80,$41,$20
		.BYTE	$10,$C2,$01,$00, $10,$C2,$41,$20
		.BYTE	$18,$C2,$01,$00, $18,$C2,$41,$20
		;.BYTE	$18,$D2,$01,$00, $18,$B3,$01,$08, $18,$B3,$01,$10, $18,$B3,$01,$18, $18,$D2,$41,$20
		.BYTE					  $28,$C1,$01,$10
		.BYTE					  $30,$C7,$01,$10
		
		.BYTE	$08,$80,$01,$00, $08,$80,$41,$20
		.BYTE	$20,$D2,$01,$00, $20,$D2,$41,$20
		
		.BYTE	$04,$B3,$01,$08, $04,$C3,$01,$10, $04,$B3,$01,$18
		
		.BYTE	$0D,$B4,$02,$08, $0D,$B5,$02,$10, $0D,$B6,$02,$18
		.BYTE	$15,$C4,$02,$08, $15,$C5,$02,$10, $15,$C6,$02,$18
		.BYTE	$1D,$D4,$02,$08, $1D,$D5,$02,$10, $1D,$D6,$02,$18
		
		.BYTE	$25,$D3,$01,$08, $25,$D3,$01,$10, $25,$D3,$01,$18
		
		.BYTE	$F0
		
signpost_roll1:
		.BYTE	$00,$DB,$00,$08, $00,$DC,$00,$10, $00,$DD,$00,$18
		.BYTE	$08,$9D,$00,$08, $08,$9E,$00,$10, $08,$9F,$00,$18
		.BYTE	$10,$AD,$00,$08, $10,$AE,$00,$10, $10,$AF,$00,$18
		.BYTE	$18,$BD,$00,$08, $18,$BE,$00,$10, $18,$BF,$00,$18
		.BYTE			 $20,$C1,$01,$10
		.BYTE			 $28,$C7,$01,$10
		.BYTE	$F0
		
signpost_roll1a:
		.BYTE	$00,$DB,$01,$08, $00,$DC,$01,$10, $00,$DD,$01,$18
		.BYTE	$08,$9D,$01,$08, $08,$9E,$01,$10, $08,$9F,$01,$18
		.BYTE	$10,$AD,$01,$08, $10,$AE,$01,$10, $10,$AF,$01,$18
		.BYTE	$18,$BD,$01,$08, $18,$BE,$01,$10, $18,$BF,$01,$18
		.BYTE			 $20,$C1,$01,$10
		.BYTE			 $28,$C7,$01,$10
		.BYTE	$F0		

signpost_roll2:
		.BYTE	$00,$C0,$01,$10
		.BYTE	$08,$B7,$01,$10
		.BYTE	$10,$B7,$01,$10
		.BYTE	$18,$E0,$01,$10
		.BYTE	$20,$C1,$01,$10
		.BYTE	$28,$C7,$01,$10
		.BYTE	$F0

signpost_roll3:
		.BYTE	$00,$DD,$40,$08, $00,$DC,$00,$10, $00,$DB,$40,$18
		.BYTE	$08,$9F,$40,$08, $08,$9E,$40,$10, $08,$9D,$40,$18
		.BYTE	$10,$AF,$40,$08, $10,$AE,$40,$10, $10,$AD,$40,$18
		.BYTE	$18,$BF,$40,$08, $18,$BE,$40,$10, $18,$BD,$40,$18
		.BYTE			 $20,$C1,$01,$10
		.BYTE			 $28,$C7,$01,$10
		.BYTE	$F0
		
signpost_roll3a:
		.BYTE	$00,$DD,$41,$08, $00,$DC,$01,$10, $00,$DB,$41,$18
		.BYTE	$08,$9F,$41,$08, $08,$9E,$41,$10, $08,$9D,$41,$18
		.BYTE	$10,$AF,$41,$08, $10,$AE,$41,$10, $10,$AD,$41,$18
		.BYTE	$18,$BF,$41,$08, $18,$BE,$41,$10, $18,$BD,$41,$18
		.BYTE			 $20,$C1,$01,$10
		.BYTE			 $28,$C7,$01,$10
		.BYTE	$F0

gargoyle_projectile:
		.BYTE	$00,$9A,$01,$00, $00,$DD,$01,$08
		.BYTE	$F0

gargoyle_projectile_r:
		.BYTE	$00,$DD,$41,$00, $00,$9A,$41,$08
		.BYTE	$F0
		