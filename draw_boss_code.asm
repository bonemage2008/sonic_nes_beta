		org	$8000

; =============== S U B	R O U T	I N E =======================================


draw_boss:
		lda	level_id
		beq	@is_l1
		cmp	#SCRAP_BRAIN
		bne	draw_boss_sprites

@is_l1:
		lda	boss_func_num
		cmp	#6
		beq	boss1_case1
		bcc	draw_boss_sprites
		cmp	#9
		bcs	draw_boss_sprites
		jsr	draw_boss1_weapon
		jmp	draw_boss_sprites

boss1_case1:
		jsr	draw_boss_sprites
		jmp	draw_boss1_weapon


; =============== S U B	R O U T	I N E =======================================


draw_boss_sprites:
		LDA	boss_func_num
		BNE	@draw_boss_spr
		RTS
; ---------------------------------------------------------------------------

@draw_boss_spr:
		LDA	#0
		LDX	chr_spr_bank2
		CPX	#$FC		; last boss chr bank
		BNE	@not_final_boss_chr
		LDA	#$80
@not_final_boss_chr:
		STA	tmp_var_26	; #$80 - flag for last boss

		LDA	level_id
		ASL	A
		TAX
		LDA	boss_tls_cfg_ptrs,X
		STA	temp_ptr_l
		LDA	boss_tls_cfg_ptrs+1,X
		STA	temp_ptr_l+1
		LDX	boss_anim_num
		LDA	boss_flip_table,X
		BMI	loc_6803E
		STA	boss_flip_flag	; boss H-mirror

loc_6803E:
		TXA
		ASL	A
		ASL	A
		TAY
		LDA	Frame_Cnt
		AND	#8
		BEQ	loc_6804A
		INY
		INY

loc_6804A:
		LDA	(temp_ptr_l),Y
		STA	tmp_ptr_l
		INY
		LDA	(temp_ptr_l),Y
		STA	tmp_ptr_l+1
		LDX	#0
		LDA	boss_X_l_relative
		CLC
		ADC	sonic_x_on_scr
		STA	tmp_var_28
		LDA	boss_X_h_relative
		ADC	sonic_x_h_on_scr ; sonic-camera
		BMI	loc_68075
		BEQ	loc_68065
		RTS
; ---------------------------------------------------------------------------

loc_68065:
		LDA	tmp_var_28

loc_68067:
		STA	tmp_x_positions,X
		INX
		CPX	#6
		BCS	loc_68091
		CLC
		ADC	#8
		BCC	loc_68067
		BCS	loc_68088

loc_68075:
		LDA	tmp_var_28
		LDY	#0

loc_68079:
		STY	tmp_x_positions,X
		INX
		CPX	#6
		BCS	locret_68087
		CLC
		ADC	#8
		BCC	loc_68079
		BCS	loc_68067

locret_68087:
		RTS
; ---------------------------------------------------------------------------

loc_68088:
		LDA	#0

loc_6808A:
		STA	tmp_x_positions,X
		INX
		CPX	#6
		BCC	loc_6808A

loc_68091:
		LDX	#0
		LDA	boss_Y_l_relative
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	boss_Y_h_relative
		ADC	sonic_y_h_on_scr ; sonic-camera
		BMI	loc_680B3
		BEQ	loc_680A3
		RTS
; ---------------------------------------------------------------------------

loc_680A3:
		LDA	tmp_var_2B

loc_680A5:
		STA	tmp_y_positions,X
		INX
		CPX	#8
		BCS	loc_680CF
		CLC
		ADC	#8
		BCC	loc_680A5
		BCS	loc_680C6

loc_680B3:
		LDA	tmp_var_2B
		LDY	#0

loc_680B7:
		STY	tmp_y_positions,X
		INX
		CPX	#8
		BCS	locret_680C5
		CLC
		ADC	#8
		BCC	loc_680B7
		BCS	loc_680A5

locret_680C5:
		RTS
; ---------------------------------------------------------------------------

loc_680C6:
		LDA	#0

loc_680C8:
		STA	tmp_y_positions,X
		INX
		CPX	#8
		BCC	loc_680C8

loc_680CF:
		LDA	#0
		STA	spr_cfg_off
		LDA	boss_flip_flag	; boss H-mirror
		BEQ	boss_draw_normal
		JMP	boss_draw_flipped
; ---------------------------------------------------------------------------

boss_draw_normal:			; index	to sprites buffer
		LDX	sprite_id
		LDY	#0
		STY	spr_cfg_attr_ptr ; temp	var

loc_680E0:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BNE	loc_680F8
		LDA	spr_cfg_off
		CLC
		ADC	#6
		STA	spr_cfg_off
		LDA	spr_cfg_attr_ptr ; temp	var
		CLC
		ADC	#6
		STA	spr_cfg_attr_ptr ; temp	var
		JMP	loc_68133
; ---------------------------------------------------------------------------

loc_680F8:
		STA	tmp_var_2B
		LDY	#0

loc_680FC:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_68128
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	(tmp_ptr_l),Y
		BNE	loc_68118
		LDA	#$F8
		STA	sprites_Y,X
		BMI	loc_68128

loc_68118:
		STA	sprites_tile,X
		LDY	spr_cfg_attr_ptr ; temp	var
		LDA	boss_attrs,Y
		BIT	tmp_var_26
		BPL	@std_attrs
		LDA	final_boss_attr,Y
@std_attrs
		STA	sprites_attr,X
		INX
		INX
		INX
		INX
		BEQ	sprite_limit_reached2

loc_68128:
		INC	spr_cfg_off
		INC	spr_cfg_attr_ptr ; temp	var
		LDY	spr_parts_counter
		INY
		CPY	#6
		BCC	loc_680FC

loc_68133:
		LDY	spr_parts_counter2
		INY
		CPY	#8
		BCC	loc_680E0
sprite_limit_reached2:
		STX	sprite_id	; index	to sprites buffer
		JMP	draw_boss_reactive_fire
; ---------------------------------------------------------------------------

boss_draw_flipped:			; index	to sprites buffer
		LDX	sprite_id
		LDY	#0
		STY	spr_cfg_attr_ptr ; temp	var

loc_68145:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BNE	loc_6815D
		LDA	spr_cfg_off
		CLC
		ADC	#6
		STA	spr_cfg_off
		LDA	spr_cfg_attr_ptr ; temp	var
		CLC
		ADC	#6
		STA	spr_cfg_attr_ptr ; temp	var
		JMP	loc_68196
; ---------------------------------------------------------------------------

loc_6815D:
		STA	tmp_var_2B
		LDY	#5

loc_68161:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_6818D
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	(tmp_ptr_l),Y
		BNE	loc_6817D
		LDA	#$F8
		STA	sprites_Y,X
		BMI	loc_6818D

loc_6817D:
		STA	sprites_tile,X
		LDY	spr_cfg_attr_ptr ; temp	var
		LDA	boss_attrs,Y
		BIT	tmp_var_26
		BPL	@std_attrs
		LDA	final_boss_attr,Y
@std_attrs

		EOR	#$40	; H-Mirror
		STA	sprites_attr,X
		INX
		INX
		INX
		INX
		BEQ	sprite_limit_reached1

loc_6818D:
		INC	spr_cfg_off
		INC	spr_cfg_attr_ptr ; temp	var
		LDY	spr_parts_counter
		DEY
		BPL	loc_68161

loc_68196:
		LDY	spr_parts_counter2
		INY
		CPY	#8
		BCC	loc_68145
sprite_limit_reached1:
		STX	sprite_id	; index	to sprites buffer
		JMP	draw_boss_reactive_fire
; End of function draw_boss_sprites


; =============== S U B	R O U T	I N E =======================================


draw_boss1_weapon:
		LDX	#0
		LDA	boss1_wpn_x_l
		CLC
		ADC	sonic_x_on_scr
		STA	tmp_var_28
		LDA	boss1_wpn_x_h
		ADC	sonic_x_h_on_scr ; sonic-camera
		BMI	loc_681C4
		BEQ	loc_681B4
		RTS
; ---------------------------------------------------------------------------

loc_681B4:
		LDA	tmp_var_28

loc_681B6:
		STA	tmp_x_positions,X
		INX
		CPX	#5
		BCS	loc_681E0
		CLC
		ADC	#8
		BCC	loc_681B6
		BCS	loc_681D7

loc_681C4:
		LDA	tmp_var_28
		LDY	#0

loc_681C8:
		STY	tmp_x_positions,X
		INX
		CPX	#5
		BCS	locret_681D6
		CLC

loc_681D0:
		ADC	#8
		BCC	loc_681C8
		BCS	loc_681B6

locret_681D6:
		RTS
; ---------------------------------------------------------------------------

loc_681D7:
		LDA	#0

loc_681D9:
		STA	tmp_x_positions,X
		INX
		CPX	#5
		BCC	loc_681D9

loc_681E0:
		LDX	#0
		LDA	boss1_wpn_y_l
		CLC
		ADC	sonic_y_on_scr
		STA	tmp_var_2B
		LDA	boss1_wpn_y_h
		ADC	sonic_y_h_on_scr ; sonic-camera
		BMI	loc_68202
		BEQ	loc_681F2
		RTS
; ---------------------------------------------------------------------------

loc_681F2:
		LDA	tmp_var_2B

loc_681F4:
		STA	tmp_y_positions,X
		INX
		CPX	#5
		BCS	loc_6821E
		CLC
		ADC	#8
		BCC	loc_681F4
		BCS	loc_68215

loc_68202:
		LDA	tmp_var_2B
		LDY	#0

loc_68206:
		STY	tmp_y_positions,X
		INX
		CPX	#5
		BCS	locret_68214
		CLC
		ADC	#8
		BCC	loc_68206
		BCS	loc_681F4

locret_68214:
		RTS
; ---------------------------------------------------------------------------

loc_68215:
		LDA	#0

loc_68217:
		STA	tmp_y_positions,X
		INX
		CPX	#5
		BCC	loc_68217

loc_6821E:
		LDA	Frame_Cnt
		AND	#3
		TAX
		LDA	boss1_wpn_tls_ptrs,X
		STA	spr_cfg_off
		LDA	boss1_wpn_attrs,X
		STA	tmp_var_25
		LDX	sprite_id	; index	to sprites buffer
		LDY	#0

loc_68231:
		STY	spr_parts_counter2
		LDA	tmp_y_positions,Y
		BNE	loc_68242
		LDA	spr_cfg_off
		CLC
		ADC	#5
		STA	spr_cfg_off
		JMP	loc_68279
; ---------------------------------------------------------------------------

loc_68242:
		STA	tmp_var_2B
		LDY	#0

loc_68246:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_68270
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	boss1_wpn_tls_nums,Y
		BNE	loc_68263
		LDA	#$F8
		STA	sprites_Y,X
		BMI	loc_68270

loc_68263:
		STA	sprites_tile,X
		LDA	tmp_var_25
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX

loc_68270:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#5
		BCC	loc_68246

loc_68279:
		LDY	spr_parts_counter2
		INY
		CPY	#5
		BCC	loc_68231
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_boss1_weapon


; =============== S U B	R O U T	I N E =======================================


draw_boss_reactive_fire:
		CPX	#$F8
		BCS	@limit
		TXA
		BEQ	@limit
;draw_boss_reactive_fire:
		LDX	boss_anim_num
		LDA	rfire_base,X
		BPL	loc_6828B
		RTS
@limit
		LDX	#$F8
		STX	sprite_id
		RTS
; ---------------------------------------------------------------------------

loc_6828B:
		STA	spr_cfg_off
		LDA	Frame_Cnt
		AND	#8
		BNE	loc_68294
		RTS
; ---------------------------------------------------------------------------

loc_68294:
		LDA	level_id
		CMP	#FINAL_ZONE
		BNE	@not_final_level
		LDA	#$F0
		STA	spr_parts_counter
		LDA	#$40		; final	boss fire attributes?
		STA	tmp_var_25
		JMP	use_mirrored_cfg
; ---------------------------------------------------------------------------

@not_final_level:
		LDY	#$30
		LDA	boss_flip_flag	; boss H-mirror
		BEQ	loc_682BE
		LDA	#$F0
		STA	spr_parts_counter
		LDA	#$40		; reactive fire	attributes (Caño de escape de Eggman)
		STA	tmp_var_25
use_mirrored_cfg:
		LDA	spr_cfg_off
		CLC
		ADC	#4
		STA	spr_cfg_off
		JMP	loc_682C6
; ---------------------------------------------------------------------------

loc_682BE:
		LDA	#$30
		STA	spr_parts_counter
		LDA	#0		; reactive fire	attributes (Caño de escape de Eggman)
		STA	tmp_var_25

loc_682C6:
		LDA	boss_X_l_relative
		CLC
		ADC	spr_parts_counter
		STA	tmp_var_63
		LDA	spr_parts_counter
		BMI	loc_682D8
		LDA	boss_X_h_relative
		ADC	#0
		JMP	loc_682DC
; ---------------------------------------------------------------------------

loc_682D8:
		LDA	boss_X_h_relative
		SBC	#0

loc_682DC:
		STA	tmp_var_64
		LDX	#0
		LDA	tmp_var_63
		CLC
		ADC	sonic_x_on_scr
		STA	tmp_var_28
		LDA	tmp_var_64
		ADC	sonic_x_h_on_scr ; sonic-camera
		BMI	loc_68300
		BEQ	loc_682F0
		RTS
; ---------------------------------------------------------------------------

loc_682F0:
		LDA	tmp_var_28

loc_682F2:
		STA	tmp_x_positions,X
		INX
		CPX	#4
		BCS	loc_6831C
		CLC
		ADC	#8
		BCC	loc_682F2
		BCS	loc_68313

loc_68300:
		LDA	tmp_var_28
		LDY	#0

loc_68304:
		STY	tmp_x_positions,X
		INX
		CPX	#4
		BCS	locret_68312
		CLC
		ADC	#8
		BCC	loc_68304
		BCS	loc_682F2

locret_68312:
		RTS
; ---------------------------------------------------------------------------

loc_68313:
		LDA	#0

loc_68315:
		STA	tmp_x_positions,X
		INX
		CPX	#4
		BCC	loc_68315

loc_6831C:				; index	to sprites buffer
		LDX	sprite_id
		LDY	#0

loc_68320:
		STY	spr_parts_counter2
		LDA	tmp_y_positions+3,Y
		BNE	loc_68331
		LDA	spr_cfg_off
		CLC
		ADC	#2
		STA	spr_cfg_off
		JMP	loc_68368
; ---------------------------------------------------------------------------

loc_68331:
		STA	tmp_var_2B
		LDY	#0

loc_68335:
		STY	spr_parts_counter
		LDA	tmp_x_positions,Y
		BEQ	loc_6835F
		STA	sprites_X,X
		LDA	tmp_var_2B
		STA	sprites_Y,X
		LDY	spr_cfg_off
		LDA	rfire_tls_nums,Y
		BNE	loc_68352
		LDA	#$F8
		STA	sprites_Y,X
		BMI	loc_6835F

loc_68352:
		STA	sprites_tile,X
		LDA	tmp_var_25
		STA	sprites_attr,X
		TXA
		CLC
		ADC	#4
		TAX

loc_6835F:
		INC	spr_cfg_off
		LDY	spr_parts_counter
		INY
		CPY	#2
		BCC	loc_68335

loc_68368:
		LDY	spr_parts_counter2
		INY
		CPY	#2
		BCC	loc_68320
		STX	sprite_id	; index	to sprites buffer
		RTS
; End of function draw_boss_reactive_fire

; ---------------------------------------------------------------------------
;unused_22382:	.BYTE $E0		; chr nums?
;		.BYTE $E4
;		.BYTE $E8
;		.BYTE $EC
;		.BYTE $F0
;		.BYTE $FC
;		.BYTE $FC

rfire_base:	.BYTE  $FF,   0,   0, $FF,   8,	$FF, $FF, $FF, $FF, $FF, $FF, $FF,   0,	  8,   8

rfire_tls_nums:	.BYTE  $8F,   0 ; small fire
		.BYTE  $9F,   0

		.BYTE	 0, $8F ; small fire (mirrored)
		.BYTE	 0, $9F

		.BYTE  $CE, $CF	; big fire
		.BYTE  $DE, $DF

		.BYTE  $CF, $CE ; big fire (mirrored)
		.BYTE  $DF, $DE

boss1_wpn_tls_ptrs:.BYTE    0, $19, $4B, $32

boss1_wpn_attrs:.BYTE	 0, $40, $C0, $80 ;Atributos de la bola de Eggman

boss_flip_table:
		.BYTE	$FF ; 0 - idle? - undefined (use last flip)
		.BYTE	1 ; 1 - move right
		.BYTE	0 ; 2 - move left
		.BYTE	1 ; 3 - ?
		.BYTE	1 ; 4 - ?
		.BYTE	$FF ; 5 - get hit - undefined (use last flip)
		.BYTE	$FF ; 6 - attack - undefined (use last flip)
		.BYTE	1 ; 7 - ?
		.BYTE	1 ; 8 final scene
		.BYTE	1 ; 9 final scene
		.BYTE	1 ; A final scene
		.BYTE	1 ; B final scene
		.BYTE	1 ; C final scene
		.BYTE	1 ; D final scene
		.BYTE	1 ; E final scene
		.BYTE	1 ; F

boss_tls_cfg_ptrs:.WORD	boss1_tls_nums ; ghz
		.WORD boss2_tls_nums ; mar
		.WORD boss3_tls_nums ; spr
		.WORD boss1_tls_nums ; lab
		.WORD boss5_tls_nums ; star
		.WORD boss1_tls_nums ; scrap
		.WORD boss7_tls_nums ; final
		;.WORD boss7_tls_nums ; bns

boss_attrs:	.BYTE	 1,   1,   0,	0,   1,	  0
		.BYTE	 1,   1,   0,	0,   1,	  0
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2

final_boss_attr:.BYTE	 3,   3,   0,	0,   3,	  3
		.BYTE	 3,   3,   0,	0,   3,	  3
		.BYTE	 3,   3,   3,	3,   3,	  3
		.BYTE	 3,   3,   3,	3,   3,	  3
		.BYTE	 3,   3,   3,	3,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2
		.BYTE	 2,   2,   2,	2,   2,	  2

boss1_tls_nums:	.WORD GH_Front ;03_GH_Front ;Green Hill
		.WORD GH_Front ;03_GH_Front
		.WORD GH_Fly_01 ;01_GH_Fly
		.WORD GH_Fly_02 ;02_GH_Fly
		.WORD GH_Fly_01 ;01_GH_Fly
		.WORD GH_Fly_02 ;02_GH_Fly
		.WORD GH_Burn ;05_GH_Burn
		.WORD GH_Burn ;05_GH_Burn
		.WORD GH_Escaping1 ;06_GH_Escaping
		.WORD GH_Escaping2 ;07_GH_Escaping
		.WORD GH_Hit ;04_GH_Hit
		.WORD GH_Front ;03_GH_Front
		.WORD SL_Front_03 ;03_SL_Front (& Sping Yard)
		.WORD SL_Front_04 ;04_SL_Front (& Sping Yard)

boss2_tls_nums:	.WORD MB_Front ;03_MB_Front ;Marble
		.WORD MB_Front ;03_MB_Front
		.WORD MB_Fly_01 ;01_MB_Fly
		.WORD MB_Fly_02 ;02_MB_Fly
		.WORD MB_Fly_01 ;01_MB_Fly
		.WORD MB_Fly_02 ;02_MB_Fly
		.WORD MB_Burn ;05_MB_Burn
		.WORD MB_Burn ;05_MB_Burn
		.WORD MB_Escaping1 ;06_MB_Escaping
		.WORD MB_Escaping2 ;07_MB_Escaping
		.WORD MB_Hit ;04_MB_Hit
		.WORD MB_Front ;03_MB_Front
		.WORD MB_Front ;03_MB_Front
		.WORD MB_Front ;03_MB_Front
		
boss3_tls_nums	.WORD GH_Front ;03_GH_Front ;Green Hill
		.WORD GH_Front ;03_GH_Front
		.WORD GH_Fly_01 ;01_GH_Fly
		.WORD GH_Fly_02 ;02_GH_Fly
		.WORD GH_Fly_01 ;01_GH_Fly
		.WORD GH_Fly_02 ;02_GH_Fly
		.WORD GH_Burn ;05_GH_Burn
		.WORD GH_Burn ;05_GH_Burn
		.WORD GH_Escaping1 ;06_GH_Escaping
		.WORD GH_Escaping2 ;07_GH_Escaping
		.WORD GH_Hit ;04_GH_Hit
		.WORD GH_Front ;03_GH_Front
		.WORD SP_Front_03 ;03_SL_Front (& Sping Yard)
		.WORD SP_Front_04 ;04_SL_Front (& Sping Yard)

boss5_tls_nums:	.WORD SL_Front_03 ;03_SL_Front (& Sping Yard)
		.WORD SL_Front_04 ;04_SL_Front (& Sping Yard)
		.WORD SL_Fly_01 ;01_SL_Fly
		.WORD SL_Fly_02 ;02_SL_Fly
		.WORD SL_Fly_01 ;01_SL_Fly
		.WORD SL_Fly_02 ;02_SL_Fly
		.WORD SL_Burn ;06_SL_Burn
		.WORD SL_Burn ;06_SL_Burn
		.WORD SL_Escaping1 ;07_SL_Escaping
		.WORD SL_Escaping2 ;08_SL_Escaping
		.WORD SL_Hit ;05_SL_Hit
		.WORD SL_Front_03 ;03_SL_Front (& Sping Yard)
		.WORD SL_Front_03 ;03_SL_Front (& Sping Yard)
		.WORD SL_Front_03 ;03_SL_Front (& Sping Yard)

boss1_wpn_tls_nums:.BYTE    0, $EC, $FC,    0,	 0 ;Ball-Eggman
		.BYTE  $ED, $EE, $EF,	0,   0
		.BYTE  $FD, $FE, $FF,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0, $FC, $EC,   0
		.BYTE	 0,   0, $EF, $EE, $ED
		.BYTE	 0,   0, $FF, $FE, $FD
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE  $FD, $FE, $FF,	0,   0
		.BYTE  $ED, $EE, $EF,	0,   0
		.BYTE	 0, $EC, $FC,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0,   0,	0,   0
		.BYTE	 0,   0, $FF, $FE, $FD
		.BYTE	 0,   0, $EF, $EE, $ED
		.BYTE	 0,   0, $FC, $EC,   0
;-------------------------------------------------------------- ;Green Hill

GH_Fly_01:	.BYTE  $80, $81, $82, $83, $8E,	  0   ;01_GH_Fly
		.BYTE  $90, $91, $92, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Fly_02:	.BYTE  $80, $81, $84, $85, $8E,	  0   ;02_GH_Fly
		.BYTE  $90, $91, $94, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Front:	.BYTE  $80, $81, $8A, $8B, $8E,	  0   ;03_GH_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Hit:		.BYTE  $80, $97, $8C, $8D, $8E,	  0   ;04_GH_Hit
		.BYTE  $90, $91, $9C, $9D, $9E,	  0
		.BYTE  $A6, $A7, $A8, $A9, $AA,	$AB
		.BYTE  $B6, $B7, $B8, $B9, $BA,	$BB
		.BYTE  $C6, $C7, $C8, $C9, $CA,	$CB
		.BYTE  $D6, $D7, $D8, $D9, $DA,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Burn:	.BYTE  $80, $81, $88, $89, $8E,	  0   ;05_GH_Burn
		.BYTE  $90, $91, $98, $99, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Escaping1:	.BYTE  $E8, $E9, $82, $86, $87,	  0   ;06_GH_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

GH_Escaping2:	.BYTE  $E8, $E9, $84, $85, $8E,	  0   ;07_GH_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
;-------------------------------------------------------------- ;Marble

MB_Fly_01:	.BYTE  $80, $81, $82, $83, $8E,	  0   ;01_MB_Fly
		.BYTE  $90, $91, $92, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Fly_02:	.BYTE  $80, $81, $84, $95, $8E,	  0   ;02_MB_Fly
		.BYTE  $90, $91, $94, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Front:	.BYTE  $80, $81, $8A, $8B, $8E,	  0   ;03_MB_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Hit:		.BYTE  $80, $97, $8C, $8D, $8E,	  0   ;04_MB_Hit
		.BYTE  $90, $91, $9C, $9D, $9E,	  0
		.BYTE  $A6, $A7, $A8, $A9, $AA,	$AB
		.BYTE  $B6, $B7, $B8, $B9, $BA,	$BB
		.BYTE  $C6, $C7, $C8, $C9, $CA,	$CB
		.BYTE  $D6, $D7, $D8, $D9, $DA,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Burn:	.BYTE  $80, $81, $88, $89, $8E,	  0   ;05_MB_Burn
		.BYTE  $90, $91, $98, $99, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Escaping1:	.BYTE  $E8, $E9, $82, $86, $87,	  0   ;06_MB_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

MB_Escaping2:	.BYTE  $E8, $E9, $84, $85, $8E,	  0   ;07_MB_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0,   0, $E2,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
;-------------------------------------------------------------- ;Star Light

SL_Fly_01:	.BYTE  $80, $81, $82, $83, $8E,	  0   ;01_SL_Fly
		.BYTE  $90, $91, $92, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

SL_Fly_02:	.BYTE  $80, $81, $84, $95, $8E,	  0   ;02_SL_Fly
		.BYTE  $90, $91, $94, $93, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

SL_Front_03:	.BYTE  $80, $81, $8A, $8B, $8E,	  0   ;03_SL_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0, $F2,	0,   0,	  0

SL_Front_04:	.BYTE  $80, $81, $8A, $95, $8E,	  0   ;04_SL_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0, $F2,	0,   0,	  0
		
SP_Front_03:	.BYTE  $80, $81, $8A, $8B, $8E,	  0   ;03_SP_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $00, $E2, $00,   0,	  0
		.BYTE	 0,   0, $F2,	0,   0,	  0

SP_Front_04:	.BYTE  $80, $81, $8A, $95, $8E,	  0   ;04_SP_Front
		.BYTE  $90, $91, $9A, $9B, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $00, $E2, $00,   0,	  0
		.BYTE	 0,   0, $F2,	0,   0,	  0

SL_Hit:		.BYTE  $80, $97, $8C, $8D, $8E,	  0   ;05_SL_Hit
		.BYTE  $90, $91, $9C, $9D, $9E,	  0
		.BYTE  $A6, $A7, $A8, $A9, $AA,	$AB
		.BYTE  $B6, $B7, $B8, $B9, $BA,	$BB
		.BYTE  $C6, $C7, $C8, $C9, $CA,	$CB
		.BYTE  $D6, $D7, $D8, $D9, $DA,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

SL_Burn:	.BYTE  $80, $81, $88, $89, $8E,	  0   ;06_SL_Burn
		.BYTE  $90, $91, $98, $99, $9E,	  0
		.BYTE  $A0, $A1, $A2, $A3, $A4,	$A5
		.BYTE  $B0, $B1, $B2, $B3, $B4,	$B5
		.BYTE  $C0, $C1, $C2, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

SL_Escaping1:	.BYTE  $E8, $E9, $82, $86, $87,	  0   ;07_SL_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0

SL_Escaping2:	.BYTE  $E8, $E9, $84, $85, $8E,	  0   ;08_SL_Escaping
		.BYTE  $F8, $F9, $96, $9B, $9E,	  0
		.BYTE  $EA, $EB, $A2, $A3, $A4,	$A5
		.BYTE  $FA, $FB, $B2, $F6, $F7,	$B5
		.BYTE  $F3, $F4, $F5, $C3, $C4,	$C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,	  0
		.BYTE	 0, $E1, $E2, $E3,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0


boss7_tls_nums:	.WORD byte_68B63 ;Boss Eggman
		.WORD byte_68B63 ;Boss Eggman
		.WORD byte_68B93 ;Boss Eggman (Hit)
		.WORD byte_68B93 ;Boss Eggman (Hit)
		.WORD byte_68B93 ;Boss Eggman (Hit)
		.WORD byte_68B93 ;Boss Eggman (Hit)
		.WORD GH_Burn ;01_FZ_Burn
		.WORD GH_Burn ;01_FZ_Burn
		.WORD byte_68BF3 ;02_FZ_Escaping *
		.WORD byte_68C23 ;03_FZ_Escaping *
		.WORD byte_68B93 ;Boss Eggman (Hit)
		.WORD byte_68B63 ;Boss Eggman
		.WORD byte_68B93 ;Nada *
		.WORD byte_68B93 ;Nada
		.WORD byte_68B93 ;Nada
		.WORD byte_68B93 ;Nada
		.WORD byte_68C53 ;04_FZ_legs_Front
		.WORD byte_68C53 ;04_FZ_legs_Front
		.WORD byte_68C83 ;05_FZ_legs_Escaping
		.WORD byte_68C83 ;05_FZ_legs_Escaping
		.WORD byte_68CB3 ;06_FZ_legs_Escaping
		.WORD byte_68CB3 ;06_FZ_legs_Escaping
		.WORD byte_68CE3 ;07_FZ_legs_Escaping
		.WORD byte_68CE3 ;07_FZ_legs_Escaping
		.WORD GH_Burn ;01_FZ_Burn
		.WORD GH_Burn ;01_FZ_Burn
		.WORD byte_68BF3 ;02_FZ_Escaping *
		.WORD byte_68C23 ;07_GH_Escaping
		.WORD byte_68BF3 ;07_GH_Escaping
		.WORD byte_68C23 ;07_GH_Escaping

;-------------------------------------------------------------- ;Final (Zone)

byte_68B63:	.BYTE	 0,   0,   0,   0,   0,   0  ;Boss Eggman
		.BYTE	 0, $84, $85, $86, $87,   0
		.BYTE	 0, $94, $95, $96, $97,   0
		.BYTE	 0, $A4, $A5, $A6, $A7,   0
		.BYTE	 0, $B4, $B5, $B6, $B7,   0
		.BYTE	 0, $C4, $C5, $C6, $C7,   0
		.BYTE	 0, $D4, $D5, $D6, $D7,   0
		.BYTE	 0, $E0, $E1, $E2, $E3,   0


byte_68B93:	.BYTE	 0,   0,   0,	0,   0,	  0  ;Boss Eggman (Hit)
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
		.BYTE	 0,   0,   0,	0,   0,	  0
;-------------------------------------------------------------- ;Final (Zone)


byte_68BF3:	.BYTE  $80, $81, $82, $86, $87,   0   ;02_FZ_Escaping
		.BYTE  $90, $91, $96, $93, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,   0
		.BYTE    0,   0,   0,   0,   0,   0
		.BYTE    0,   0,   0,   0,   0,   0

byte_68C23:	.BYTE  $80, $81, $84, $85, $8E,   0   ;03_FZ_Escaping
		.BYTE  $90, $91, $96, $93, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $D0, $D1, $D2, $D3, $D4,   0
		.BYTE    0,   0,   0,   0,   0,   0
		.BYTE    0,   0,   0,   0,   0,   0

byte_68C53:	.BYTE  $80, $81, $84, $85, $8E,   0 ;07_FZ_legs_Escaping
		.BYTE  $90, $91, $98, $9B, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $D0, $D1, $D2, $D3, $D5,   0
		.BYTE    0,   0, $ED, $EE, $EF,   0
		.BYTE  $DB, $FC, $FD, $FE, $FF,   0

byte_68C83:	.BYTE  $80, $81, $8A, $8B, $8E,   0 ;06_FZ_legs_Escaping
		.BYTE  $90, $91, $98, $9B, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $D0, $D1, $D2, $D3, $D5,   0
		.BYTE    0,   0, $ED, $EE, $EF,   0
		.BYTE  $DB, $FC, $FD, $FE, $FF,   0

byte_68CB3:	.BYTE  $80, $81, $84, $86, $87,   0 ;05_FZ_legs_Escaping
		.BYTE  $90, $91, $96, $93, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $D0, $D1, $D2, $E0, $E1, $E2
		.BYTE  $DB, $FC, $FD, $FE, $FF,   0
		.BYTE    0,   0,   0,   0,   0,   0

byte_68CE3:	.BYTE  $80, $81, $82, $85, $8E,   0 ;04_FZ_legs_Front
		.BYTE  $90, $91, $96, $93, $9E,   0
		.BYTE  $A0, $A1, $A2, $A3, $A4, $A5
		.BYTE  $B0, $B1, $B2, $B3, $B4, $B5
		.BYTE  $C0, $C1, $C2, $C3, $C4, $C5
		.BYTE  $E3, $E4, $E5, $E6, $E7,   0
		.BYTE    0,   0,   0,   0,   0,   0
		.BYTE    0,   0,   0,   0,   0,   0