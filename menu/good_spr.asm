good_frame_00:
		.BYTE	$90-1,$42,$02,$7E
		
		.BYTE	$9A-1,$43,$02,$78
		.BYTE	$9A-1,$44,$02,$80
		.BYTE	$A2-1,$45,$02,$78
		.BYTE	$A2-1,$46,$02,$80
		
		.BYTE	$90-1,$30,$00,$78
		.BYTE	$90-1,$31,$00,$80
		
		.BYTE	$98-1,$32,$00,$78
		.BYTE	$98-1,$33,$00,$80
		
		.BYTE	$A0-1,$34,$00,$70+4
		.BYTE	$A0-1,$35,$00,$78+4
		.BYTE	$A0-1,$34,$40,$80+4
		
		.BYTE	$A8-1,$36,$02,$70+4
		.BYTE	$A8-1,$37,$02,$78+4
		.BYTE	$A8-1,$36,$42,$80+4
		
		.BYTE	$F0,$00,$00,$00
		.BYTE	$F0,$00,$00,$00
		.BYTE	$F0,$00,$00,$00

good_frame_01:
		.BYTE	$90-1,$42,$42,$7A
		
		.BYTE	$9A-1,$43,$42,$80
		.BYTE	$9A-1,$44,$42,$78
		.BYTE	$A2-1,$45,$42,$80
		.BYTE	$A2-1,$46,$42,$78
		
		.BYTE	$90-1,$30,$40,$80
		.BYTE	$90-1,$31,$40,$78
		
		.BYTE	$98-1,$32,$40,$80
		.BYTE	$98-1,$33,$40,$78
		
		.BYTE	$A0-1,$34,$00,$70+4
		.BYTE	$A0-1,$35,$00,$78+4
		.BYTE	$A0-1,$34,$40,$80+4
		
		.BYTE	$A8-1,$36,$02,$70+4
		.BYTE	$A8-1,$37,$02,$78+4
		.BYTE	$A8-1,$36,$42,$80+4
		
		.BYTE	$F0,$00,$00,$00
		.BYTE	$F0,$00,$00,$00
		.BYTE	$F0,$00,$00,$00

good_frame_02:
		.BYTE	$98-1,$47,$02,$78
		.BYTE	$98-1,$48,$02,$80
		
		.BYTE	$A0-1,$49,$02,$78
		.BYTE	$A0-1,$4A,$02,$80
		
		.BYTE	$A8-1,$4B,$00,$70+4
		.BYTE	$A8-1,$4B,$40,$80+4

		.BYTE	$90-1,$38,$00,$70+4
		.BYTE	$90-1,$39,$00,$78+4
		.BYTE	$90-1,$38,$40,$80+4
		
		.BYTE	$98-1,$3A,$00,$70+4
		.BYTE	$98-1,$3B,$00,$78+4
		.BYTE	$98-1,$3A,$40,$80+4
		
		.BYTE	$A0-1,$3C,$00,$70+4
		.BYTE	$A0-1,$3D,$00,$78+4
		.BYTE	$A0-1,$3E,$00,$80+4
		
		.BYTE	$A8-1,$3F,$02,$70+4
		.BYTE	$A8-1,$40,$02,$78+4
		.BYTE	$A8-1,$41,$02,$80+4
		
good_animals:
		.BYTE	$00,$F8,$00,$00
		.BYTE	$00,$FA,$00,$00
		.BYTE	$00,$F9,$00,$00
		.BYTE	$00,$FB,$00,$00
		
		
ending_animals_X:
		.BYTE	$10,$30,$C0,$E0	; ending objects X
ending_animals_Y:
		.BYTE	$3F,$5F,$4F,$5F ; ending objects Y
ending_animals_type:
		.BYTE	$58,$4C,$EC,$F8 ; ending objects type (tile
ending_animals_attr:
		.BYTE	$00,$82,$02,$80 ; ending objects attr
ending_animals_cnt:
		.BYTE	$00,$0B,$00,$0F ; ending objects cnt
ending_animal_type:
		.BYTE	$00,$01,$01,$00
ending_animal_cnt_lim:
		.BYTE	$0F,$0B,$0B,$0F
		
ending_move_animals:
		;
		LDA	Frame_Cnt
		ROR	A
		ROR	A
		ROR	A
		AND	#3
		CLC
		ADC	#$13
		STA	chr_bkg_bank4
		
		;
		LDX	#3
		
@next_animal_move:
		LDY	objects_delay,X
		LDA	objects_var_cnt,X
		BPL	@inc
		DEC	objects_delay,X
		DEY
		JMP	@check
@inc:
		INC	objects_delay,X
		;CPY	#11 ; $0B
		TYA
		CMP	ending_animal_cnt_lim,X
@check:
		BNE	@ok
		LDA	objects_var_cnt,X
		EOR	#$80
		STA	objects_var_cnt,X
@ok:
		LDA	ending_animal_type,X
		BNE	@type2
		LDA	ending_animal_y,Y
		BNE	@type1
@type2
		LDA	ending_animal2_y,Y
@type1		
		STA	objects_Y_l,X
		DEX
		BPL	@next_animal_move
		
		JMP	ending_draw_animals

ending_animal_y:
		;.BYTE	$3F,$41,$43,$45
		;.BYTE	$48,$4B,$4E,$51
		;.BYTE	$54,$57,$5B,$5F
		
		.BYTE	$3F,$40,$41,$42
		.BYTE	$44,$46,$48,$4A
		.BYTE	$4C,$4E,$50,$53
		.BYTE	$56,$59,$5C,$5F
		
ending_animal2_y:
		.BYTE	$4F,$50,$51,$52
		.BYTE	$53,$55,$57,$59
		.BYTE	$5B,$5D,$5F,$5F
		

ending_load_animals:
		LDX	#3
@load
		LDA	ending_animals_X,X
		STA	objects_X_l,X
		LDA	ending_animals_Y,X
		STA	objects_Y_l,X
		LDA	ending_animals_type,X
		STA	objects_type,X
		LDA	ending_animals_attr,X
		STA	objects_var_cnt,X
		LDA	ending_animals_cnt,X
		STA	objects_delay,X
		DEX
		BPL	@load
;		RTS
		
ending_draw_animals:
		LDX	#3
		LDY	#256-64
@next
		LDA	objects_Y_l,X
		STA	sprites_Y,Y
		STA	sprites_Y+4,Y
		CLC
		ADC	#8
		STA	sprites_Y+8,Y
		STA	sprites_Y+12,Y
		
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LDA	ending_animal_type,X
		BEQ	@anim_fast
		LDA	Frame_Cnt
		LSR	A
		LSR	A
		LSR	A
		LSR	A
@anim_fast
		LDA	objects_type,X
		BCS	@no_alt_spr
		ADC	#4
@no_alt_spr
		STA	sprites_tile,Y
		EOR	#2
		STA	sprites_tile+4,Y
		EOR	#3
		STA	sprites_tile+8,Y
		EOR	#2
		STA	sprites_tile+12,Y

		LDA	objects_X_l,X
		STA	sprites_X,Y
		STA	sprites_X+8,Y
		CLC
		ADC	#8
		STA	sprites_X+4,Y
		STA	sprites_X+12,Y

		LDA	objects_var_cnt,X
		AND	#$7F
		STA	sprites_attr,Y
		STA	sprites_attr+4,Y
		STA	sprites_attr+8,Y
		STA	sprites_attr+12,Y

		TYA
		CLC
		ADC	#16
		TAY
		DEX
		BPL	@next
		RTS
		
