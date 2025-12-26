		org	$8000

blocks_000_127_phys:
		LDA	block_number
		TAX
		AND	#$F
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		TXA	;LDA	block_number
		BMI	@is_group2
		AND	#$7E
		TAY
		LDA	blk_phys_ptrs,Y
		STA	temp_ptr_l
		LDA	blk_phys_ptrs+1,Y
		STA	temp_ptr_l+1
		JMP	(temp_ptr_l)
; ---------------------------------------------------------------------------
@is_group2:
		AND	#$7E
		TAY
		LDA	blk_phys_ptrs2,Y
		STA	temp_ptr_l
		LDA	blk_phys_ptrs2+1,Y
		STA	temp_ptr_l+1
		JMP	(temp_ptr_l)
; ---------------------------------------------------------------------------
blk_phys_ptrs:	.WORD blocks_00_07_phys	; $00
		.WORD blocks_00_07_phys	; $02
		.WORD blocks_00_07_phys	; $04
		.WORD blocks_00_07_phys	; $06
		.WORD blocks_08_0F_phys	; $08
		.WORD blocks_08_0F_phys	; $0A
		.WORD blocks_08_0F_phys	; $0C
		.WORD blocks_08_0F_phys	; $0E
		.WORD blocks_10_17_phys	; $10
		.WORD blocks_10_17_phys	; $12
		.WORD blocks_10_17_phys	; $14
		.WORD blocks_10_17_phys	; $16
		.WORD blocks_18_1B_phys	; $18
		.WORD blocks_18_1B_phys	; $1A
		.WORD blocks_1C_1F_phys	; $1C
		.WORD blocks_1C_1F_phys	; $1E
		.WORD blocks_20_27_phys	; $20
		.WORD blocks_20_27_phys	; $22
		.WORD blocks_20_27_phys	; $24
		.WORD blocks_20_27_phys	; $26
		.WORD blocks_28_2F_phys	; $28
		.WORD blocks_28_2F_phys	; $2A
		.WORD blocks_28_2F_phys	; $2C
		.WORD blocks_28_2F_phys	; $2E
		.WORD blocks_30_35_phys	; $30
		.WORD blocks_30_35_phys	; $32
		.WORD blocks_30_35_phys	; $34
		.WORD blocks_30_35_phys	; $36
		.WORD blocks_38_3F_phys	; $38
		.WORD blocks_38_3F_phys	; $3A
		.WORD blocks_38_3F_phys	; $3C
		.WORD blocks_38_3F_phys	; $3E
		.WORD blocks_40_43_phys	; $40
		.WORD blocks_40_43_phys	; $42
		.WORD blocks_44_47_phys	; $44
		.WORD blocks_44_47_phys	; $46
		.WORD blocks_48_49_phys	; $48
		.WORD blocks_4A_4B_phys	; $4A
		.WORD ground_block_phys	; $4C - 2 to speed ; $4D - 1 to speed.
		.WORD blocks_4E_4F_phys	; $4E
		.WORD blocks_50_57_phys	; $50
		.WORD blocks_50_57_phys	; $52
		.WORD blocks_50_57_phys	; $54
		.WORD blocks_50_57_phys	; $56
		.WORD blocks_58_5D_phys	; $58
		.WORD blocks_58_5D_phys	; $5A
		.WORD blocks_58_5D_phys	; $5C
		.WORD blocks_5E_5F_phys	; $5E
		.WORD blocks_60_65_phys	; $60
		.WORD blocks_60_65_phys	; $62
		.WORD blocks_60_65_phys	; $64
		.WORD blocks_66_67_phys	; $66
		.WORD blocks_68_6F_phys	; $68
		.WORD blocks_68_6F_phys	; $6A
		.WORD blocks_68_6F_phys	; $6C
		.WORD blocks_68_6F_phys	; $6E
		.WORD blocks_70_78_phys	; $70
		.WORD blocks_70_78_phys	; $72
		.WORD blocks_70_78_phys	; $74
		.WORD blocks_70_78_phys	; $76
		.WORD blocks_78_7F_phys	; $78
		.WORD blocks_78_7F_phys	; $7A
		.WORD blocks_78_7F_phys	; $7C
		.WORD blocks_78_7F_phys	; $7E


; =============== S U B	R O U T	I N E =======================================


blocks_00_07_phys:
		LDA	#0
		STA	sonic_rwalk_attr
		STA	round_walk_spr_add
		LDA	#1
		STA	block_chk_coll_flag
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	dec_sonic_X_speed
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		AND	#$7F
		TAY
		LDA	blks_00_07_Ytbl,Y
		BMI	dec_sonic_X_speed
		JSR	blk_set_Y_pos		

dec_sonic_X_speed:
blk_dec_sonic_speed:
		LDA	sonic_X_speed
		BEQ	@ok
		DEC	sonic_X_speed
@ok
		RTS
; End of function blocks_00_07_phys
; ---------------------------------------------------------------------------

blk_set_Y_pos:
		STA	tmp_var_25
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	@no_coll
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed
@no_coll:
		RTS
; ---------------------------------------------------------------------------
blks_00_07_Ytbl:.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2,	 2,   2,   2,	2,   2,	  2,   2,   2
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   9,	9,  $A,	 $A,  $A,  $B,	$B,  $B,  $B,  $C,  $C,	 $C,  $D,  $D
		.BYTE	$D,  $D,  $D,  $D,  $E,	 $E,  $E,  $E,	$E,  $E,  $E,  $E,  $E,	 $E,  $E,  $E
		.BYTE	$E,  $E,  $E,  $E,  $E,	 $E,  $E,  $E,	$E,  $E,  $E,  $E,  $D,	 $D,  $D,  $D
		.BYTE	$D,  $D,  $C,  $C,  $C,	 $B,  $B,  $B,	$B,  $A,  $A,  $A,   9,	  9,   8,   8

; =============== S U B	R O U T	I N E =======================================

; GHZ diagonals (R)
blocks_08_0F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	loc_8C184
		JMP	dec_sonic_X_speed
; ---------------------------------------------------------------------------

loc_8C184:
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		AND	#$7F
		TAY
		LDA	blks_08_0E_Ytbl,Y
		BMI	loc_8C1AA
		JSR	blk_set_Y_pos

loc_8C1AA:
		LDA	sonic_attribs
		AND	#DIR_LEFT
		BEQ	@moving_right
		JMP	dec_X_speed_by_2
; ---------------------------------------------------------------------------

@moving_right:
		;LDA	#2
		;JMP	add_sonic_X_speed
		RTS
; End of function blocks_08_0F_phys

; ---------------------------------------------------------------------------
blks_08_0E_Ytbl:.BYTE	 1,   1,   1,	1,   1,	  2,   3,   3,	 3,   4,   4,	5,   5,	  6,   7,   7
		.BYTE	 7,   8,   8,	9,   9,	 $A,  $A,  $B,	$B,  $C,  $C,  $D,  $D,	 $D,  $E,  $E
		.BYTE	 8,   9,  $A,  $B,  $B,	 $C,  $C,  $D,	$D,  $E,  $E,  $F,  $F,	$FF, $FF, $FF
		.BYTE	 9,   9,  $A,  $B,  $C,	 $D,  $E,  $F,	$F, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE	 1,   1,   1,	2,   2,	  2,   3,   3,	 3,   4,   4,	4,   5,	  5,   5,   6
		.BYTE	 6,   6,   7,	7,   7,	  7,   8,   8,	 8,   8,   9,	9,   9,	 $A,  $A,  $A
		.BYTE	 6,   6,   6,	6,   7,	  7,   7,   8,	 8,   8,   9,	9,  $A,	 $A,  $B,  $B

; =============== S U B	R O U T	I N E =======================================

; GHZ diagonals (L)
blocks_10_17_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	loc_8C256
		JMP	dec_sonic_X_speed
; ---------------------------------------------------------------------------

loc_8C256:
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8C29C,Y
		STA	tmp_var_25
		CMP	#$FF
		BEQ	loc_8C27A
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8C27A
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed

loc_8C27A:
		LDA	sonic_attribs
		AND	#DIR_LEFT
		BNE	@moving_left
		JMP	dec_X_speed_by_2
; ---------------------------------------------------------------------------

@moving_left:
		;LDA	#2
		;JMP	add_sonic_X_speed
		RTS
; End of function blocks_10_17_phys

; ---------------------------------------------------------------------------
byte_8C29C:	.BYTE	$E,  $E,  $E,  $D,  $D,	 $D,  $C,  $C,	$B,  $B,  $B,  $A,  $A,	  9,   9,   9
		.BYTE	 8,   7,   7,   6,   6,	  6,   5,   5,	 5,   4,   4,	3,   3,	  3,   2,   2
		.BYTE  $FF, $FF, $FF,  $F,  $F,	 $E,  $E,  $D,	$D,  $C,  $C,  $B,  $B,	 $A,   9,   8
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF,  $F,	$E,  $D,  $C,  $B,  $A,	  9,   8,   7
		.BYTE	$A,   9,   9,   9,   8,	  8,   8,   7,	 7,   7,   6,	6,   6,	  6,   5,   5
		.BYTE	 5,   5,   5,	4,   4,	  4,   4,   4,	 3,   3,   3,	2,   2,	  2,   1,   1
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	$F,  $F,  $E,  $E,  $E,	 $D,  $D,  $C
		.BYTE	$C,  $B,  $B,  $A,  $A,	  9,   9,   8,	 8,   8,   7,	7,   6,	  5,   5,   5
		.BYTE	 1,   1,   1,	1,   1,	  1,   1,   1,	 1,   2,   2,	3,   3,	  4,   5,   6
		.BYTE	 6,   5,   4,	3,   3,	  2,   2,   1,	 1,   1,   1,	1,   1,	  1,   1,   1
		.BYTE	$A,   9,   9,   9,   8,	  8,   8,   7,	 7,   7,   6,	6,   6,	  6,   5,   5
		.BYTE	 5,   5,   5,   4,   4,	  4,   4,   4,	 3,   3,   3,	2,   2,	  2,   1,   1
		.BYTE	 6,   6,   6,	6,   7,	  7,   7,   8,	 8,   8,   9,	9,  $A,	 $A,  $B,  $B

; =============== S U B	R O U T	I N E =======================================

; star light diagonals
blocks_18_1B_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#3
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8C3CB,Y
		STA	tmp_var_25
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	loc_8C392
		LDA	sonic_Y_speed
		CMP	#$10
		BCC	loc_8C39D

loc_8C392:
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8C39D
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C39D:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_attribs
		AND	#DIR_LEFT
		BNE	@moving_left
		JMP	inc_X_speed_by_2
; ---------------------------------------------------------------------------

@moving_left:
		JMP	dec_X_speed_by_2
; End of function blocks_18_1B_phys

; ---------------------------------------------------------------------------
byte_8C3CB:	.BYTE	 3,   3,   4,	4,   5,	  5,   6,   6,	 7,   7,   8,	8,   9,	  9,  $A,  $A
		.BYTE	 0,   0,   1,	1,   2,	  2,   3,   3,	 4,   4,   5,	5,   6,	  6,   7,   7
		.BYTE	 8,   8,   9,	9,  $A,	 $A,  $B,  $B,	$C,  $C,  $D,  $D,  $E,	 $E,  $F,  $F

; =============== S U B	R O U T	I N E =======================================


blocks_1C_1F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#3
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8C454,Y
		STA	tmp_var_25
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	loc_8C41B	; CHECK

loc_8C41B:
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8C426
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C426:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_attribs
		AND	#DIR_LEFT
		BEQ	dec_X_speed_by_2
		
inc_X_speed_by_2:
		LDA	#2
add_sonic_X_speed:
		CLC
		ADC	sonic_X_speed
		CMP	#$F0
		BCC	@ok
		LDA	#$F0

@ok:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

dec_X_speed_by_2:
		LDA	sonic_X_speed
		SEC
		SBC	#2
		CMP	#$F8
		BCC	@ok
		LDA	#0

@ok:
		STA	sonic_X_speed
		RTS
; End of function blocks_1C_1F_phys

; ---------------------------------------------------------------------------
byte_8C454:	.BYTE	$A,  $A,   9,	9,   8,	  8,   7,   7,	 6,   6,   5,	5,   4,	  4,   3,   3
		.BYTE	$F,  $F,  $E,  $E,  $D,	 $D,  $C,  $C,	$B,  $B,  $A,  $A,   9,	  9,   8,   8
		.BYTE	 7,   7,   6,	6,   5,	  5,   4,   4,	 3,   3,   2,	2,   1,	  1,   0,   0

; =============== S U B	R O U T	I N E =======================================


blocks_20_27_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		JSR	dec_sonic_X_speed
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	@check_coll
		LDA	sonic_anim_num
		CMP	#6
		BEQ	locret_8C4C3
		LDA	sonic_attribs
		AND	#$10
		BEQ	@check_coll
		LDA	sonic_Y_speed
		CMP	#40	; hack-fix
		BCS	locret_8C4C3
@check_coll:
		JSR	dec_sonic_X_speed
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	blks_20_27_Ytbl,Y
		STA	tmp_var_25
		CMP	#$F0
		BEQ	loc_8C4C4
		LDA	temp_y_l
		AND	#$F
		;CMP	#$F
		;BCS	locret_8C4C3
		CMP	tmp_var_25
		BCC	locret_8C4C3
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed

locret_8C4C3:
		RTS
; ---------------------------------------------------------------------------

loc_8C4C4:
		LDA	temp_y_l
		AND	#$F
		CMP	#$F
		BCS	locret_8C4C3
		
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	loc_8C4DE
		SEC
		SBC	#$10
		STA	temp_y_l

loc_8C4DE:
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		RTS
; End of function blocks_20_27_phys

; ---------------------------------------------------------------------------
blks_20_27_Ytbl:.BYTE	 3,   2,   2,	2,   2,	  1,   1,   1,	 0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0,	 0,   1,   2,	2,   3,	  3,   4,   4
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0,	 0,   1,   2,	2,   3,	  4,   5,   6
		.BYTE	 6,   5,   4,	3,   2,	  2,   1,   0, $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0,	 0,   1,   2,	3,   4,	  5,   6,   7
		.BYTE	 7,   6,   5,	4,   3,	  2,   1,   0, $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 5,   5,   5,   4,   4,	  4,   4,   4,	 3,   3,   3,	2,   2,	  2,   1,   1
		.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2,	 2,   2,   2,	2,   2,	  2,   2,   2
		.BYTE	 6,   6,   6,	6,   7,	  7,   7,   8,	 8,   8,   9,	9,  $A,	 $A,  $B,  $B

; =============== S U B	R O U T	I N E =======================================


blocks_28_2F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C5A7
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		AND	#$7F
		TAY
		LDA	byte_8C5B5,Y
		STA	tmp_var_25
		CMP	#$FF
		BEQ	loc_8C5A7
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8C5A7
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed

loc_8C5A7:
		JMP	dec_sonic_X_speed
; End of function blocks_28_2F_phys

; ---------------------------------------------------------------------------
byte_8C5B5:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	$F,  $F,  $E,  $E,  $D,	 $D,  $C,  $C
		.BYTE	$C,  $C,  $D,  $D,  $E,	 $E,  $F,  $F, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE	$C,  $B,  $B,  $A,  $A,	 $A,  $A,  $A,	 9,   9,   9,	9,   9,	  9,   9,   9
		.BYTE	 9,   9,   9,	9,   9,	  9,   9,   9,	$A,  $A,  $A,  $A,  $A,	 $B,  $B,  $C
		.BYTE	$C,  $B,  $B,  $A,   9,	  9,   8,   8,	 8,   7,   7,	6,   6,	  6,   5,   4
		.BYTE	 4,   5,   6,	6,   6,	  7,   7,   8,	 8,   8,   9,	9,  $A,	 $B,  $B,  $C
		.BYTE	 4,   4,   4,	4,   4,	  4,   3,   3,	 3,   3,   3,	2,   2,	  2,   2,   2
		.BYTE	 2,   2,   2,	2,   2,	  3,   3,   3,	 3,   3,   4,	4,   4,	  4,   4,   4

; =============== S U B	R O U T	I N E =======================================


blocks_30_35_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#7
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		AND	#$7F
		TAY
		LDA	byte_8C750,Y
		STA	tmp_var_25
		CMP	#$F0
		BNE	loc_8C658
		JMP	sub_8D9D5
; ---------------------------------------------------------------------------

loc_8C658:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#4
		BNE	loc_8C671
		LDA	sonic_Y_speed
		CMP	#$10
		BCS	loc_8C671
		LDA	tmp_var_25
		CMP	#$FF
		BNE	loc_8C66E
		AND	#$F
		STA	tmp_var_25

loc_8C66E:
		JMP	loc_8C682
; ---------------------------------------------------------------------------

loc_8C671:
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	loc_8C67F
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8C682

loc_8C67F:
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C682:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	sonic_Y_speed
		BEQ	@no_chg
		LDA	#2
		STA	sonic_Y_speed
@no_chg:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8C6A2
		LDA	sonic_X_speed
		CLC
		ADC	#2
		CMP	#$F8
		BCC	loc_8C69F
		LDA	#$F8

loc_8C69F:
		JMP	loc_8C6B3
; ---------------------------------------------------------------------------

loc_8C6A2:
		LDA	sonic_X_speed
		SEC
		SBC	#2
		CMP	#$F8
		BCC	loc_8C6B3
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		EOR	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0

loc_8C6B3:
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BNE	loc_8C6C4
		LDY	#$20
		STY	round_walk_spr_add
		LDA	#$40
		STA	sonic_rwalk_attr
		RTS
; ---------------------------------------------------------------------------

loc_8C6C4:
		LDY	#0
		STY	round_walk_spr_add
		LDA	#0
		STA	sonic_rwalk_attr
		RTS
; End of function blocks_30_35_phys


; =============== S U B	R O U T	I N E =======================================


blocks_38_3F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#7
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		AND	#$7F
		TAY
		LDA	byte_8C7A0,Y
		STA	tmp_var_25
		CMP	#$F0
		BNE	loc_8C6F0
		JMP	sub_8D9D5
; ---------------------------------------------------------------------------

loc_8C6F0:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	loc_8C6F6	; CHECK
					; ???
loc_8C6F6:
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	loc_8C704
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8C707

loc_8C704:
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C707:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8C727
		LDA	sonic_X_speed
		CLC
		ADC	#2
		CMP	#$F8
		BCC	loc_8C724
		LDA	#$F8

loc_8C724:
		JMP	loc_8C738
; ---------------------------------------------------------------------------

loc_8C727:
		LDA	sonic_X_speed
		SEC
		SBC	#2
		CMP	#$F8
		BCC	loc_8C738
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		EOR	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0

loc_8C738:
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BNE	loc_8C747
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		RTS
; ---------------------------------------------------------------------------

loc_8C747:
		LDY	#$20
		STY	round_walk_spr_add
		LDA	#0
		STA	sonic_rwalk_attr
		RTS
; End of function blocks_38_3F_phys

; ---------------------------------------------------------------------------
byte_8C750:	.BYTE	$B,  $B,  $C,  $C,  $D,	 $D,  $E,  $E, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0, $F0, $F0,   0,	0,   1,	  1,   2,   2
		.BYTE	 1,   3,   5,	7,   9,	 $B,  $D,  $F, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0,	 1,   3,   5,	7,   9,	 $B,  $D,  $F
		.BYTE	 0,   1,   2,	3,   4,	  5,   6,   7,	 8,   9,  $A,  $B,  $C,	 $D,  $E,  $F
byte_8C7A0:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	$E,  $E,  $D,  $D,  $C,	 $C,  $B,  $B
		.BYTE	 2,   2,   1,	1,   0,	  0, $F0, $F0, $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	$F,  $D,  $B,	9,   7,	  5,   3,   1
		.BYTE	$F,  $D,  $B,	9,   7,	  5,   3,   1, $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	$F,  $E,  $D,  $C,  $B,	 $A,   9,   8,	 7,   6,   5,	4,   3,	  2,   1,   1

; =============== S U B	R O U T	I N E =======================================


blocks_40_43_phys:
		LDA	block_number
		CMP	#$40
		BEQ	loc_8C7F9
		JMP	loc_8C82A
; ---------------------------------------------------------------------------

loc_8C7F9:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	locret_8C829
		LDA	temp_y_l
		AND	#$F
		CMP	#$E
		BCS	@chk_coll
		CMP	#8
		BCS	locret_8C829
@chk_coll:
		LDA	sonic_attribs
		AND	#$EF
		STA	sonic_attribs
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	loc_8C821
		SEC
		SBC	#$10
		STA	temp_y_l

loc_8C821:
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed

locret_8C829:
		RTS
; ---------------------------------------------------------------------------

loc_8C82A:
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	#0
		STA	sonic_Y_speed
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	locret_8C852
		SEC
		SBC	#$10
		STA	temp_y_l

locret_8C852:
		RTS
; End of function blocks_40_43_phys


; =============== S U B	R O U T	I N E =======================================


blocks_44_47_phys:
		LDA	block_number
		CMP	#$44
		BNE	loc_8C86B
		LDA	block_some_flag
		BNE	loc_8C864
		LDA	#$4C
		STA	block_number
		JMP	ground_block_phys
; ---------------------------------------------------------------------------

loc_8C864:
		LDA	#$75
		STA	block_number
		JSR	blocks_70_78_phys
		JSR	blk_dec_sonic_speed
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C86B:
		CMP	#$45
		BNE	loc_8C87D
		LDA	block_some_flag
		BNE	loc_8C87A
		LDA	#$41
		STA	block_number
		JMP	blocks_40_43_phys
; ---------------------------------------------------------------------------

loc_8C87A:
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C87D:
		LDA	block_some_flag
		BNE	loc_8C888
		LDA	#$1D
		STA	block_number
		JMP	blocks_1C_1F_phys
; ---------------------------------------------------------------------------

loc_8C888:
		JMP	blk_dec_sonic_speed
; End of function blocks_44_47_phys


; =============== S U B	R O U T	I N E =======================================


blocks_48_49_phys:
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	block_chk_coll_flag
		BNE	loc_8C89A
		LDA	#0
		STA	block_chk_coll_flag
		RTS
; ---------------------------------------------------------------------------

loc_8C89A:
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_X_l
		EOR	temp_x_l
		AND	#$F0
		BEQ	loc_8C8CC
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_X_l
		SEC
		SBC	temp_x_l
		LDA	sonic_X_h
		SBC	temp_x_h
		BMI	loc_8C8C2
		LDA	sonic_X_l
		AND	#$F0
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		JMP	loc_8C8CC
; ---------------------------------------------------------------------------

loc_8C8C2:
		LDA	sonic_X_l
		ORA	#$F
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h

loc_8C8CC:
		LDA	sonic_Y_l
		EOR	temp_y_l
		AND	#$F0
		BEQ	loc_8C8FA
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_Y_l
		SEC
		SBC	temp_y_l
		LDA	sonic_Y_h
		SBC	temp_y_h
		BMI	loc_8C8F0
		LDA	sonic_Y_l
		AND	#$F0
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h
		JMP	loc_8C8FA
; ---------------------------------------------------------------------------

loc_8C8F0:
		LDA	sonic_Y_l
		ORA	#$F
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h

loc_8C8FA:
		LDA	#1
		STA	block_chk_coll_flag
		RTS
; End of function blocks_48_49_phys


; =============== S U B	R O U T	I N E =======================================


blocks_4A_4B_phys:
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		STA	sonic_X_speed
		LDA	sonic_X_l
		EOR	temp_x_l
		AND	#$F0
		BEQ	loc_8C93D
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_X_l
		SEC
		SBC	temp_x_l
		LDA	sonic_X_h
		SBC	temp_x_h
		BMI	loc_8C933
		LDA	sonic_X_l
		AND	#$F0
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		JMP	loc_8C93D
; ---------------------------------------------------------------------------

loc_8C933:
		LDA	sonic_X_l
		ORA	#$F
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h

loc_8C93D:
		LDA	sonic_Y_l
		EOR	temp_y_l
		AND	#$F0
		BEQ	loc_8C96B
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_Y_l
		SEC
		SBC	temp_y_l
		LDA	sonic_Y_h
		SBC	temp_y_h
		BMI	loc_8C961
		LDA	sonic_Y_l
		AND	#$F0
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h
		JMP	loc_8C96B
; ---------------------------------------------------------------------------

loc_8C961:
		LDA	sonic_Y_l
		ORA	#$F
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h

loc_8C96B:
		LDA	#1
		STA	block_chk_coll_flag
		RTS
; End of function blocks_4A_4B_phys


; =============== S U B	R O U T	I N E =======================================


ground_block_phys:
		LDA	block_number
		CMP	#$4D
		BNE	loc_8C979
		JMP	sub_8C9F6
; ---------------------------------------------------------------------------

loc_8C979:
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C98F
		LDA	temp_y_l
		AND	#$F0
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed

loc_8C98F:
		LDX	block_number
		CPX	#$4C
		BNE	loc_8C9A2
		LDA	sonic_X_speed
		SEC
		SBC	#1
		CMP	#$F8
		BCC	loc_8C9B5
		LDA	#0
		BEQ	loc_8C9B5

loc_8C9A2:
		LDA	sonic_X_speed
		SEC
		SBC	#1
		CMP	#$F8
		BCC	loc_8C9AF
		LDA	#0
		BEQ	loc_8C9B5

loc_8C9AF:
		CMP	#$30
		BCC	loc_8C9B5
		LDA	#$30

loc_8C9B5:
		STA	sonic_X_speed
		RTS
; End of function ground_block_phys

; ---------------------------------------------------------------------------

;unused_2C9C8:
;		LDA	temp_x_l
;		EOR	sonic_X_l
;		AND	#$F
;		BEQ	loc_8C98F
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#1
;		BEQ	loc_8C9DE
;		LDA	temp_x_l
;		CLC
;		ADC	#$10
;		AND	#$F0
;		STA	temp_x_l
;		LDA	temp_x_h
;		ADC	#0
;		STA	temp_x_h
;		LDA	#0
;		STA	sonic_X_speed
;		LDA	#1
;		STA	tmp_var_26
;		RTS
; ---------------------------------------------------------------------------

;loc_8C9DE:
;		LDA	temp_x_l
;		SEC
;		SBC	#$10
;		ORA	#$F
;		STA	temp_x_l
;		LDA	temp_x_h
;		SBC	#0
;		STA	temp_x_h
;		LDA	#0
;		STA	sonic_X_speed
;		LDA	#1
;		STA	tmp_var_26
;		RTS

; =============== S U B	R O U T	I N E =======================================


sub_8C9F6:
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8CA1C
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		BCS	loc_8CA1C
		SEC
		SBC	#$10
		STA	temp_y_l
		DEC	temp_y_h

loc_8CA1C:
		JMP	blk_dec_sonic_speed
; End of function sub_8C9F6


; =============== S U B	R O U T	I N E =======================================


blocks_4E_4F_phys:
		LDA	block_number
		AND	#1
		BNE	loc_8CA40
		LDA	block_some_flag
		;BEQ	loc_8CA39
		;JMP	loc_8CA4E
		BNE	loc_8CA4E
; ---------------------------------------------------------------------------

loc_8CA39:
loc_8CA47:
		LDA	#0
		STA	tmp_var_25
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

loc_8CA40:
		LDA	block_some_flag
		BNE	loc_8CA47
;		JMP	loc_8CA4E
; ---------------------------------------------------------------------------

;loc_8CA47:
;		LDA	#0
;		STA	tmp_var_25
;		STA	tmp_var_26
;		RTS
; ---------------------------------------------------------------------------

loc_8CA4E:
		LDA	sonic_X_l
		EOR	temp_x_l
		AND	#$F0
		BEQ	loc_8CA7C
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_X_l
		SEC
		SBC	temp_x_l
		LDA	sonic_X_h
		SBC	temp_x_h
		BMI	loc_8CA72
		LDA	sonic_X_l
		AND	#$F0
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		JMP	loc_8CA7C
; ---------------------------------------------------------------------------

loc_8CA72:
		LDA	sonic_X_l
		ORA	#$F
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h

loc_8CA7C:
		LDA	sonic_Y_l
		EOR	temp_y_l
		AND	#$F0
		BEQ	loc_8CAAA
		LDA	#1
		STA	tmp_var_26
		LDA	sonic_Y_l
		SEC
		SBC	temp_y_l
		LDA	sonic_Y_h
		SBC	temp_y_h
		BMI	loc_8CAA0
		LDA	sonic_Y_l
		AND	#$F0
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h
		JMP	loc_8CAAA
; ---------------------------------------------------------------------------

loc_8CAA0:
		LDA	sonic_Y_l
		ORA	#$F
		STA	temp_y_l
		LDA	sonic_Y_h
		STA	temp_y_h

loc_8CAAA:
		LDA	#1
		STA	block_chk_coll_flag
		RTS
; End of function blocks_4E_4F_phys


; =============== S U B	R O U T	I N E =======================================


blocks_50_57_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	screen_number
		CMP	#$3D
		BCC	loc_8CABD
		LDA	block_some_flag
		BNE	locret_8CAFD

loc_8CABD:
		LDX	#$14
		LDA	block_number
		CMP	#$54
		BCS	loc_8CAD7
		LDX	#$19
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BEQ	loc_8CACF
		LDX	#$20

loc_8CACF:
		STX	round_walk_spr_add
		LDA	#0
		STA	sonic_rwalk_attr
		BEQ	loc_8CAE9

loc_8CAD7:
		CMP	#$55
		BEQ	loc_8CAE9
		STX	round_walk_spr_add
		LDX	#0
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BEQ	loc_8CAE7
		LDX	#$80

loc_8CAE7:
		STX	sonic_rwalk_attr

loc_8CAE9:
		JSR	sub_8CBD0
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	locret_8CAFD
		CMP	#$F0
		BNE	sub_8CAFE
		STA	tmp_var_26
locret_8CAFD:
		RTS


; =============== S U B	R O U T	I N E =======================================


sub_8CAFE:
		LDA	block_number
		AND	#7
		BNE	loc_8CB2A
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8CB1C

loc_8CB0E:
		LDA	sonic_X_speed
		CLC
		ADC	#5
		CMP	#$E0
		BCC	loc_8CB19
		LDA	#$E0

loc_8CB19:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CB1C:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCC	loc_8CB27
		LDA	#0

loc_8CB27:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CB2A:
		CMP	#5
		BCS	loc_8CB68
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8CB37
		JMP	loc_8CB0E
; ---------------------------------------------------------------------------

loc_8CB37:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCS	loc_8CB5D
		STA	sonic_X_speed
		BEQ	loc_8CB5D
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8CB55
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#3
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CB55:
		LDA	sonic_Y_speed
		CLC
		ADC	#8
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CB5D:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#2
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CB68:
		CMP	#5
		BNE	loc_8CB7F
		LDA	sonic_X_speed
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed
		LDA	#2
		STA	sonic_X_speed

loc_8CB78:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8CB7F:
		;JMP	loc_8CB82

loc_8CB82:
		LDA	sonic_Y_speed
		BEQ	loc_8CBA9
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BEQ	loc_8CB95
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		JMP	loc_8CB9B
; ---------------------------------------------------------------------------

loc_8CB95:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_8CB9B:
		LDA	#8
		CLC
		ADC	sonic_X_speed
		CMP	#$E0
		BCC	loc_8CBA6
		LDA	#$E0

loc_8CBA6:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CBA9:
		STA	sonic_X_speed
		RTS
; End of function sub_8CAFE


; =============== S U B	R O U T	I N E =======================================


sub_8CBAC:
		LDA	sonic_Y_speed
		BEQ	loc_8CBCD
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BEQ	loc_8CBBF
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		JMP	loc_8CBC5
; ---------------------------------------------------------------------------

loc_8CBBF:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_8CBC5:
		LDA	#$A
		CLC
		ADC	sonic_X_speed
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CBCD:
		STA	sonic_X_speed
		RTS
; End of function sub_8CBAC


; =============== S U B	R O U T	I N E =======================================


sub_8CBD0:
		LDA	block_number
		AND	#7
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		CPX	#2
		BCC	loc_8CBE1
		JMP	loc_8CC20
; ---------------------------------------------------------------------------

loc_8CBE1:
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8CFCF,Y
		STA	tmp_var_25
		BMI	loc_8CC07
		LDA	temp_y_l
		AND	#$F
		SEC
		SBC	tmp_var_25
		BPL	loc_8CBFE
		EOR	#$FF
		CMP	#3
		BCS	loc_8CC0B

loc_8CBFE:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		RTS
; ---------------------------------------------------------------------------

loc_8CC07:
		CMP	#$FF
		BNE	loc_8CC10

loc_8CC0B:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CC10:
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		RTS
; ---------------------------------------------------------------------------

loc_8CC20:
		LDA	temp_y_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8CFCF,Y
		STA	tmp_var_25
		BMI	loc_8CC3F
		LDA	temp_x_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8CC43
		LDA	temp_x_l
		AND	#$F0

loc_8CC3A:
		ORA	tmp_var_25
		STA	temp_x_l
		RTS
; ---------------------------------------------------------------------------

loc_8CC3F:
		CMP	#$FF
		BNE	loc_8CC48

loc_8CC43:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CC48:
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l
		LDA	temp_x_h
		SBC	#0
		STA	temp_x_h
		RTS
; End of function sub_8CBD0


; =============== S U B	R O U T	I N E =======================================


blocks_58_5D_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#7
		LDY	screen_number
		CPY	#$3D
		BCS	loc_8CC6B
		CLC
		ADC	#$A
		BNE	loc_8CC72

loc_8CC6B:
		LDY	block_some_flag
		BEQ	loc_8CC72
		CLC
		ADC	#5

loc_8CC72:
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D04F,Y
		STA	tmp_var_25
		BMI	loc_8CCAE
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8CCB2
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	sonic_X_speed
		SEC
		SBC	#3-1
		CMP	#$F8
		BCC	loc_8CCA1
		LDA	#0

loc_8CCA1:
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$7F
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	round_walk_spr_add
		RTS
; ---------------------------------------------------------------------------

loc_8CCAE:
		CMP	#$FF
		BNE	loc_8CCB7

loc_8CCB2:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CCB7:
		STA	tmp_var_26
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		RTS
; End of function blocks_58_5D_phys


; =============== S U B	R O U T	I N E =======================================


blocks_60_65_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#7
		LDY	screen_number
		CPY	#$3D
		BCS	loc_8CCDC
		CLC
		ADC	#$C
		BNE	loc_8CCE3

loc_8CCDC:
		LDY	block_some_flag
		BEQ	loc_8CCE3
		CLC
		ADC	#6

loc_8CCE3:
		TAX
		LDA	byte_8CD52,X
		BMI	loc_8CD3B
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D13F,Y
		STA	tmp_var_25
		BMI	loc_8CD37
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8CD3B
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	block_number
		AND	#7
		CMP	#3
		BCC	loc_8CD24
		LDY	#$19
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8CD1B
		LDY	#$20

loc_8CD1B:
		STY	round_walk_spr_add
		LDA	#$C0
		STA	sonic_rwalk_attr
		JMP	sub_8CBAC
; ---------------------------------------------------------------------------

loc_8CD24:
		LDY	#$20
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8CD2E
		LDY	#$19

loc_8CD2E:
		STY	round_walk_spr_add
		LDA	#$80
		STA	sonic_rwalk_attr
		JMP	loc_8CB82
; ---------------------------------------------------------------------------

loc_8CD37:
		CMP	#$FF
		BNE	loc_8CD40

loc_8CD3B:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CD40:
		STA	tmp_var_26
		LDA	temp_y_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_y_l
		LDA	temp_y_h
		ADC	#0
		STA	temp_y_h
		RTS
; End of function blocks_60_65_phys

; ---------------------------------------------------------------------------
byte_8CD52:	.BYTE	 0, $10, $20, $FF, $FF,	$FF, $FF, $FF, $FF, $30, $40, $50
		.BYTE	 0, $10, $20, $30, $40,	$50

; =============== S U B	R O U T	I N E =======================================


blocks_68_6F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	block_number
		AND	#7
		LDY	screen_number
		CPY	#$3D

loc_8CD70:
		BCS	loc_8CD79
		TAX
		LDA	byte_8CDDE,X
		JMP	loc_8CD80
; ---------------------------------------------------------------------------

loc_8CD79:
		LDY	block_some_flag
		BEQ	loc_8CD80
		CLC
		ADC	#5

loc_8CD80:
		TAX
		LDA	byte_8CDD2,X
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D19F,Y

loc_8CD90:
		STA	tmp_var_25
		BMI	loc_8CDB7
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8CDBB
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	#$25
		STA	round_walk_spr_add
		LDY	#$80
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8CDB2
		LDY	#$C0

loc_8CDB2:
		STY	sonic_rwalk_attr
		JMP	loc_8CDE4
; ---------------------------------------------------------------------------

loc_8CDB7:
		CMP	#$FF
		BNE	loc_8CDC0

loc_8CDBB:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CDC0:
		STA	tmp_var_26
		LDA	temp_y_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_y_l
		LDA	temp_y_h
		ADC	#0
		STA	temp_y_h
		RTS
; ---------------------------------------------------------------------------
byte_8CDD2:	.BYTE	 0, $10, $20, $20, $20,	$20, $20, $20, $20, $30, $40, $50
byte_8CDDE:	.BYTE	 0, $10, $20, $30, $40,	$50
; ---------------------------------------------------------------------------

loc_8CDE4:
		LDA	block_number
		AND	#7
		BNE	loc_8CDED
		JMP	loc_8CB82
; ---------------------------------------------------------------------------

loc_8CDED:
		CMP	#1
		BNE	loc_8CE19
		LDA	sonic_attribs
		AND	#1
		BNE	loc_8CE02
		LDA	#2
		STA	sonic_Y_speed
		LDA	sonic_attribs
		AND	#$FB
		STA	sonic_attribs
		RTS
; ---------------------------------------------------------------------------

loc_8CE02:
		LDA	sonic_attribs
		AND	#4
		BEQ	locret_8CE18
		LDA	sonic_Y_speed
		LSR	A
		CLC
		ADC	sonic_X_speed
		STA	sonic_X_speed
		CMP	#$A0
		BCC	locret_8CE18
		LDA	#$A0
		STA	sonic_X_speed

locret_8CE18:
		RTS
; ---------------------------------------------------------------------------

loc_8CE19:
		CMP	#2
		BNE	loc_8CE42
		LDY	#0
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8CE27
		LDY	#1

loc_8CE27:
		STA	block_some_flag
		LDA	sonic_Y_speed
		LSR	A
		CLC
		ADC	sonic_X_speed
		CMP	#$A0
		BCC	loc_8CE35
		LDA	#$A0

loc_8CE35:
		STA	sonic_X_speed
		LDA	#4
		STA	sonic_Y_speed
		LDA	sonic_attribs
		ORA	#4
		STA	sonic_attribs
		RTS
; ---------------------------------------------------------------------------

loc_8CE42:
		CMP	#3
		BNE	loc_8CE47
		RTS
; ---------------------------------------------------------------------------

loc_8CE47:
		JMP	sub_8CBAC
; End of function blocks_68_6F_phys


; =============== S U B	R O U T	I N E =======================================


blocks_5E_5F_phys:
		LDY	#0
		STY	block_chk_coll_flag
		LDA	block_number
		AND	#1
		BEQ	loc_8CE56
		LDY	#1

loc_8CE56:
		STY	block_some_flag
		JMP	dec_X_speed_by_2


; =============== S U B	R O U T	I N E =======================================


blocks_70_78_phys:
		LDA	#1
		STA	block_chk_coll_flag
		LDA	screen_number
		CMP	#$3D
		BCC	loc_8CE75
		LDA	block_some_flag
		BEQ	locret_8CEB1

loc_8CE75:
		LDX	#$14
		LDA	block_number
		CMP	#$74
		BCS	loc_8CE8F
		LDX	#$20
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BEQ	loc_8CE87
		LDX	#$19

loc_8CE87:
		STX	round_walk_spr_add
		LDA	#$40
		STA	sonic_rwalk_attr
		BNE	loc_8CE9D

loc_8CE8F:
		STX	round_walk_spr_add
		LDX	#$C0
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$40
		BEQ	loc_8CE9B
		LDX	#$40

loc_8CE9B:
		STX	sonic_rwalk_attr

loc_8CE9D:
		JSR	sub_8CF47
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	locret_8CEB1
		CMP	#$F0
		BNE	sub_8CEB2
		STA	tmp_var_26
locret_8CEB1:
		RTS


; =============== S U B	R O U T	I N E =======================================


sub_8CEB2:
		LDA	block_number
		AND	#7
		BNE	loc_8CEDE
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8CED0

loc_8CEC2:
		LDA	sonic_X_speed
		CLC
		ADC	#7+7
		CMP	#$E0
		BCC	loc_8CECD
		LDA	#$E0

loc_8CECD:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CED0:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCC	loc_8CEDB
		LDA	#0

loc_8CEDB:
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CEDE:
		CMP	#5
		BCS	loc_8CF1C
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8CEEB
		JMP	loc_8CEC2
; ---------------------------------------------------------------------------

loc_8CEEB:
		LDA	sonic_X_speed
		SEC
		SBC	#8
		BEQ	loc_8CF11
		CMP	#$F8
		BCS	loc_8CF11
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8CF09
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#$C
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#5
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CF09:
		LDA	sonic_Y_speed
		CLC
		ADC	#$A
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CF11:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$F0
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#2
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CF1C:
		CMP	#5
		BNE	loc_8CF44
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8CF31
		LDA	sonic_X_speed
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed
		JMP	loc_8CF39
; ---------------------------------------------------------------------------

loc_8CF31:
		LDA	sonic_X_speed
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed

loc_8CF39:
		LDA	#2
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8CF44:
		JMP	sub_8CBAC
; End of function sub_8CEB2


; =============== S U B	R O U T	I N E =======================================


sub_8CF47:
		LDA	block_number
		AND	#7
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		CPX	#2
		BCC	loc_8CF58
		JMP	loc_8CF97
; ---------------------------------------------------------------------------

loc_8CF58:
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D23F,Y
		STA	tmp_var_25
		BMI	loc_8CF7E
		LDA	temp_y_l
		AND	#$F
		SEC
		SBC	tmp_var_25
		BPL	loc_8CF75
		EOR	#$FF
		CMP	#3
		BCS	loc_8CF82

loc_8CF75:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		RTS
; ---------------------------------------------------------------------------

loc_8CF7E:
		CMP	#$FF
		BNE	loc_8CF87

loc_8CF82:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CF87:
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		RTS
; ---------------------------------------------------------------------------

loc_8CF97:
		LDA	temp_y_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D23F,Y
		STA	tmp_var_25
		BMI	loc_8CFB6
		LDA	temp_x_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8CFBA
		LDA	temp_x_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_x_l
		RTS
; ---------------------------------------------------------------------------

loc_8CFB6:
		CMP	#$FF
		BNE	loc_8CFBF

loc_8CFBA:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8CFBF:
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		LDA	temp_x_h
		ADC	#0
		STA	temp_x_h
		RTS
; End of function sub_8CF47

; ---------------------------------------------------------------------------
byte_8CFCF:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF,	$F,  $F,  $E,  $E,  $D,	 $D,  $C,  $C
		.BYTE	$C,  $B,  $A,	9,   8,	  7,   6,   5,	 4,   3,   2, $F0, $F0,	$F0, $F0, $F0
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF,  $F,  $E,  $E,  $D,	 $D,  $C,  $C
		.BYTE	 3,   3,   3,	3,   2,	  2,   1,   1,	 0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 7,   7,   7,	7,   7,	  6,   6,   6,	 6,   5,   5,	5,   5,	  4,   4,   4
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 4,   4,   4,	5,   5,	  5,   5,   6,	 6,   6,   6,	7,   7,	  7,   7,   7
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0, $F0, $F0,   0,	1,   1,	  2,   2,   3
byte_8D04F:	.BYTE	 4,   4,   3,	3,   2,	  2,   2,   1,	 0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 8,   8,   8,	8,   7,	  7,   7,   7,	 6,   6,   6,	6,   5,	  5,   5,   5
		.BYTE	 9,   9,   9,	9,   9,	  9,   9,   9,	 9,   9,   9,	9,   9,	  9,   9,   9
		.BYTE	$F,  $F,  $E,  $E,  $D,	 $D,  $D,  $C,	$C,  $C,  $B,  $B,  $B,	 $A,  $A,  $A
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE	$A,  $A,  $A,  $B,  $B,	 $B,  $C,  $C,	$C,  $D,  $D,  $D,  $E,	 $E,  $F,  $F
		.BYTE	 9,   9,   9,	9,   9,	  9,   9,   9,	 9,   9,   9,	9,   9,	  9,   9,   9
		.BYTE	 5,   5,   5,	5,   6,	  6,   6,   6,	 7,   7,   7,	7,   8,	  8,   8,   8
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0,   0,	 1,   2,   2,	2,   3,	  3,   4,   4
		.BYTE	 4,   4,   3,	3,   2,	  2,   2,   1,	 0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 8,   8,   8,	8,   7,	  7,   7,   7,	 6,   6,   6,	6,   5,	  5,   5,   5
		.BYTE	 9,   9,   9,	9,   9,	  9,   9,   9,	 9,   9,   9,	9,   9,	  9,   9,   9
		.BYTE	 5,   5,   5,	5,   6,	  6,   6,   6,	 7,   7,   7,	7,   8,	  8,   8,   8
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0,   0,	 1,   2,   2,	2,   3,	  3,   4,   4
byte_8D13F:	.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF,   1,	2,   4,	  6,   8,   9
		.BYTE	 7,   8,   8,	9,  $A,	 $B,  $B,  $C,	$D,  $E,  $F, $F0, $F0,	$F0, $F0, $F0
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF,   0,	 0,   1,   2,	2,   3,	  3,   4,   5
		.BYTE	 5,   4,   4,	3,   3,	  3,   2,   2,	 1,   0, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0, $F0,  $F,	 $E,  $D,  $D,	$C,  $B,  $A,	9,   8,	  7,   6,   6
		.BYTE	 7,   6,   4,	2,   1,	  0, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
byte_8D19F:	.BYTE	$C,  $D,  $D,  $E,  $E,	 $F,  $F,  $F, $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 9,   9,   9,	9,  $A,	 $A,  $A,  $A,	$B,  $B,  $B,  $B,  $C,	 $C,  $C,  $C
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8
		.BYTE	$C,  $C,  $C,  $C,  $B,	 $B,  $B,  $B,	$A,  $A,  $A,  $A,   9,	  9,   9,   9
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0, $F0,  $F,  $F,  $F,  $E,	 $E,  $D,  $D
byte_8D23F:	.BYTE	$C,  $D,  $D,  $D,  $E,	 $E,  $F,  $F, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0, $F0, $F0,	  2,   3,   4,	 5,   6,   7,	8,   9,	 $A,  $B,  $C
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF,   0,   1,	1,   2,	  2,   3,   3
		.BYTE	$C,  $C,  $C,  $D,  $D,	 $D,  $E,  $E,	$F, $F0, $F0, $F0, $F0,	$F0, $F0, $F0
		.BYTE	 8,   8,   8,	9,   9,	  9,  $A,  $A,	$A,  $B,  $B,  $B,  $C,	 $C,  $C,  $C
		.BYTE	 7,   7,   7,	7,   7,	  7,   7,   7,	 7,   7,   7,	7,   7,	  7,   7,   7
		.BYTE	$C,  $C,  $C,  $C,  $B,	 $B,  $B,  $B,	$A,  $A,  $A,  $A,   9,	  9,   9,   9
		.BYTE	$F,  $F,  $F,  $F,  $F,	 $F,  $F,  $F,	$F,  $F,  $E,  $E,  $D,	 $D,  $D,  $C
asl4_table:	.BYTE	 0, $10, $20, $30, $40,	$50, $60, $70, $80, $90, $A0, $B0, $C0,	$D0, $E0, $F0


; =============== S U B	R O U T	I N E =======================================


blocks_66_67_phys:
		LDA	#1
		STA	block_chk_coll_flag
		JMP	blk_dec_sonic_speed
; End of function blocks_66_67_phys


; =============== S U B	R O U T	I N E =======================================


blocks_78_7F_phys:
		LDA	#1
		STA	block_chk_coll_flag
		JSR	sub_8D897
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	locret_8D811
		CMP	#$F0
		BNE	sub_8D817
		STA	tmp_var_26
locret_8D811:
		RTS


; =============== S U B	R O U T	I N E =======================================


sub_8D817:
		LDA	block_number
		AND	#7
		CMP	#2
		BCS	loc_8D85B
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8D82A
		INC	sonic_X_speed
		INC	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D82A:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCS	loc_8D850
		STA	sonic_X_speed
		BEQ	loc_8D850
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8D848
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#3
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D848:
		LDA	sonic_Y_speed
		CLC
		ADC	#4
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D850:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FE
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D85B:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#1
		BEQ	loc_8D866
		INC	sonic_X_speed
		INC	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D866:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCS	loc_8D88C
		STA	sonic_X_speed
		BEQ	loc_8D88C
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8D884
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#3
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D884:
		LDA	sonic_Y_speed
		CLC
		ADC	#4
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8D88C:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	sonic_X_speed
		RTS
; End of function sub_8D817


; =============== S U B	R O U T	I N E =======================================


sub_8D897:
		LDA	block_number
		AND	#7
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8D8D9,Y
		STA	tmp_var_25
		BMI	loc_8D8C0
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8D8C4
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		RTS
; ---------------------------------------------------------------------------

loc_8D8C0:
		CMP	#$FF
		BNE	loc_8D8C9

loc_8D8C4:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8D8C9:
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		RTS
; End of function sub_8D897

; ---------------------------------------------------------------------------
byte_8D8D9:	.BYTE	$D,  $E,  $F, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0,	0,   1,	  2,   2,   3,	 4,   4,   5,	6,   6,	  7,   7,   8
		.BYTE	 8,   7,   7,	6,   6,	  5,   4,   4,	 3,   2,   2,	1,   0,	$F0, $F0, $F0
		.BYTE  $FF, $FF, $FF, $FF, $FF,	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,	 $F,  $E,  $D


; =============== S U B	R O U T	I N E =======================================


sub_8D9D5:
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	@no_fix_y
		SEC
		SBC	#$10
		STA	temp_y_l

@no_fix_y:
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		RTS
; End of function sub_8D9D5

		;.pad	$A000,$00
		