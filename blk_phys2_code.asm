;		org	$8000
;
;blocks_128_255_phys:
;		LDA	block_number
;		TAX
;		AND	#$F
;		TAY
;		LDA	asl4_table,Y
;		STA	block_4bits_mask
;		LDA	block_number
;		AND	#$7E
;		TAY
;		LDA	blk_phys_ptrs2,Y
;		STA	temp_ptr_l
;		LDA	blk_phys_ptrs2+1,Y
;		STA	temp_ptr_l+1
;		JMP	(temp_ptr_l)
; End of function blocks_128_255_phys

; ---------------------------------------------------------------------------
blk_phys_ptrs2:	.WORD block_128_phys	; $80
		.WORD block_128_phys	; $82
		.WORD block_128_phys	; $84
		.WORD block_128_phys	; $86
		.WORD spring_block	; $88 - normal spring, $89 - power spring
		.WORD sub_8C309		; $8A
		.WORD sub_8C3B2		; $8C
		.WORD block_8E_phys	; $8E
		.WORD sub_8C437		; $90
		.WORD sub_8C474		; $92
		.WORD block_94_phys	; $94
		.WORD block_96_phys	; $96
		.WORD water_block	; $98 - water; $99 - not water
		.WORD waterfall_block	; $9A - waterfall L, $9B - waterfall R.
		.WORD waterfall_2_block	; $9C
		.WORD water_block	; $9E - not water
		.WORD tunnel_blocks1	; $A0
		.WORD tunnel_blocks1	; $A2
		.WORD tunnel_blocks1	; $A4
		.WORD tunnel_blocks1	; $A6
		.WORD tunnel_blocks2	; $A8
		.WORD tunnel_blocks2	; $AA
		.WORD tunnel_blocks3	; $AC
		.WORD tunnel_blocks3	; $AE
		.WORD tunnel_blocks3	; $B0
		.WORD tunnel_blocks3	; $B2
		.WORD tunnel_blocks3	; $B4
		.WORD tunnel_blocks3	; $B6
		.WORD lava_block	; $B8
		.WORD upper_spikes_block ; $BA - spikes VVV
		.WORD locret_8C09D	; $BC
		.WORD locret_8C09D	; $BE
		.WORD sub_8CBC7		; $C0
		.WORD sub_8CBC7		; $C2
		.WORD sub_8CB89		; $C4
		.WORD spikes_block	; $C6 - spikes ^^^
		.WORD locret_8C09D	; $C8
		.WORD locret_8C09D	; $CA
		.WORD locret_8C09D	; $CC
		.WORD locret_8C09D	; $CE
		.WORD sub_8CDC2		; $D0
		.WORD spec_spring_block	 ; $D2
		.WORD locret_8C09D	; $D4
		.WORD locret_8C09D	; $D6
		.WORD sub_8CE09		; $D8
		.WORD sub_8CE09		; $DA
		.WORD sub_8CE62		; $DC
		.WORD sub_8CE62		; $DE
		.WORD ring_block	; $E0
		.WORD ring_block	; $E2
		.WORD ring_block	; $E4
		.WORD ring_block	; $E6
		.WORD ring_block	; $E8
		.WORD ring_block	; $EA
		.WORD ring_block	; $EC
		.WORD ring_block	; $EE
		.WORD ring_block	; $F0
		.WORD ring_block	; $F2
		.WORD ring_block	; $F4
		.WORD ring_block	; $F6
		.WORD ring_block	; $F8
		.WORD ring_block	; $FA
		.WORD ring_block	; $FC
		.WORD ring_block	; $FE
; ---------------------------------------------------------------------------

locret_8C09D:
		RTS

; =============== S U B	R O U T	I N E =======================================


block_128_phys:
		LDA	#1
		STA	block_chk_coll_flag
		JSR	loc_8C188
		LDA	tmp_var_25
		CMP	#$FF
		BEQ	locret_8C0BA
		CMP	#$F0
		BNE	loc_8C0B2
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

loc_8C0B2:
		JSR	sub_8C0BB
		LDA	#0
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

locret_8C0BA:
		RTS
; End of function block_128_phys


; =============== S U B	R O U T	I N E =======================================


sub_8C0BB:
		LDA	block_number
		AND	#7
		BNE	loc_8C0E2
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C0CE
		LDA	sonic_X_speed
		STA	sonic_Y_speed
		JMP	loc_8C0D7
; ---------------------------------------------------------------------------

loc_8C0CE:
		LDA	sonic_X_speed
		LSR	A
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed

loc_8C0D7:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8C0E2:
		CMP	#3
		BCS	loc_8C122
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8C0F1
		INC	sonic_X_speed
		INC	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C0F1:
		LDA	sonic_X_speed
		SEC
		SBC	#5
		CMP	#$F8
		BCS	loc_8C117
		STA	sonic_X_speed
		BEQ	loc_8C117
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C10F
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#3
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C10F:
		LDA	sonic_Y_speed
		CLC
		ADC	#4+2
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C117:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FE
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C122:
		CMP	#5
		BEQ	loc_8C162
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8C131
		INC	sonic_X_speed
		INC	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C131:
		LDA	sonic_X_speed
		SEC
		SBC	#4+2
		CMP	#$F8
		BCS	loc_8C157
		STA	sonic_X_speed
		BEQ	loc_8C157
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C14F
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#3
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C14F:
		LDA	sonic_Y_speed
		CLC
		ADC	#4+2
		STA	sonic_Y_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C157:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8C162:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#4
		BNE	loc_8C174
		LDA	sonic_X_speed
		LSR	A
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed
		JMP	loc_8C17D
; ---------------------------------------------------------------------------

loc_8C174:
		LDA	sonic_X_speed
		LSR	A
		LSR	A
		CLC
		ADC	sonic_Y_speed
		STA	sonic_Y_speed

loc_8C17D:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FE
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8C188:
		LDA	block_number
		AND	#7
		STA	tmp_var_28
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		LDA	temp_y_l
		AND	#$F
		ORA	block_4bits_mask
		TAY
		LDA	byte_8C1F9,Y
		STA	tmp_var_25
		BMI	loc_8C1CA
		LDA	tmp_var_28
		CMP	#3
		BCS	@loc_8C1B9
		LDA	temp_x_l
		AND	#$F
		CMP	tmp_var_25
		BCS	loc_8C1CE
		LDA	temp_x_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_x_l
		RTS
; ---------------------------------------------------------------------------

@loc_8C1B9:
		LDA	temp_x_l
		AND	#$F
		CMP	tmp_var_25
		BCC	loc_8C1CE
		LDA	temp_x_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_x_l
		RTS
; ---------------------------------------------------------------------------

loc_8C1CA:
		CMP	#$FF
		BNE	loc_8C1D3

loc_8C1CE:
		LDA	#$FF
		STA	tmp_var_25
		RTS
; ---------------------------------------------------------------------------

loc_8C1D3:
		LDA	tmp_var_28
		CMP	#3
		BCS	loc_8C1E9
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		LDA	temp_x_h
		ADC	#0
		STA	temp_x_h
		RTS
; ---------------------------------------------------------------------------

loc_8C1E9:
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l
		LDA	temp_x_h
		SBC	#0
		STA	temp_x_h
		RTS
; End of function sub_8C0BB

; ---------------------------------------------------------------------------
byte_8C1F9:	.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2,	 3,   3,   3,	3,   3,	  3,   3,   3
		.BYTE	 4,   4,   4,	4,   5,	  5,   5,   5,	 6,   6,   6,	6,   7,	  7,   7,   7
		.BYTE	 8,   9,   9,	9,  $A,	 $A,  $B,  $B,	$C,  $D,  $E,  $F, $F0,	$F0, $F0, $F0
		.BYTE	 7,   6,   6,	6,   5,	  5,   4,   4,	 3,   2,   1,	0, $F0,	$F0, $F0, $F0
		.BYTE	$C,  $C,  $C,  $C,  $B,	 $B,  $B,  $B,	$A,  $A,  $A,  $A,  $A,	  9,   8,   8
		.BYTE	$D,  $D,  $D,  $D,  $D,	 $D,  $D,  $D,	$C,  $C,  $C,  $C,  $C,	 $C,  $C,  $C

; =============== S U B	R O U T	I N E =======================================


spring_block:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	sub_8C2B6
		LDA	sonic_Y_speed
		CMP	#$10
		BCC	sub_8C2B6
		LDA	sonic_X_l_new
		EOR	temp_x_l
		AND	#$F0
		;BNE	sub_8C2B6	; SPRING FIX HACK
		LDA	temp_y_l
		AND	#$F0
		ORA	#6
		STA	temp_y_l
		LDA	sonic_attribs
		ORA	#MOVE_UP
		STA	sonic_attribs
		LDY	#$80
		LDA	block_number
		CMP	#$88
		BEQ	loc_8C285
		LDY	#$B0

loc_8C285:
		STY	sonic_Y_speed
		LDA	#0
		STA	tmp_var_25
		;LDA	#1
		;STA	sonic_X_speed
		LDA	#6
		STA	sonic_anim_num
		LDA	#$0C	; SFX:SPRING
		STA	sfx_to_play
		RTS
; End of function spring_block

; ---------------------------------------------------------------------------

;unused_2E2A4:
;		LDA	temp_x_l
;		SEC
;		SBC	#$10
;		STA	temp_x_l
;		LDA	temp_x_h
;		SBC	#0
;		STA	temp_x_h
;		JMP	loc_8C2B1
; ---------------------------------------------------------------------------

;unused_2E2B4:
;		LDA	temp_x_l
;		CLC
;		ADC	#$10
;		STA	temp_x_l
;		LDA	temp_x_h
;		ADC	#0
;		STA	temp_x_h
;
;loc_8C2B1:
;		LDA	#1
;		STA	tmp_var_26
;		RTS

; =============== S U B	R O U T	I N E =======================================


sub_8C2B6:
		LDA	block_number
		CMP	#$88
		BEQ	loc_8C2BD
		RTS
; ---------------------------------------------------------------------------

loc_8C2BD:
		LDA	sonic_anim_num
		CMP	#6
		BEQ	locret_8C308
		;LDA	#1		: CHECKIT
		;STA	tmp_var_26
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C2D7
		LDA	sonic_Y_speed
		CMP	#3
		BCS	loc_8C2D7
		LDA	sonic_X_speed
		CMP	#2
		BCC	loc_8C2D7
		LDA	#$D
		STA	sonic_anim_num

loc_8C2D7:
		LDA	#1
		STA	tmp_var_26
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8C2F5
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		LDA	temp_x_h
		ADC	#0
		STA	temp_x_h
		JMP	loc_8C304
; ---------------------------------------------------------------------------

loc_8C2F5:
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l
		LDA	temp_x_h
		SBC	#0
		STA	temp_x_h

loc_8C304:
		LDA	#1
		STA	block_chk_coll_flag
locret_8C308:
		RTS
; End of function sub_8C2B6


; =============== S U B	R O U T	I N E =======================================


sub_8C309:
		LDA	block_number
		CMP	#$8A
		BEQ	loc_8C312
		JMP	sub_8C362
; ---------------------------------------------------------------------------

loc_8C312:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#1
		BEQ	loc_8C33B
		LDA	sonic_Y_l
		EOR	temp_y_l
		AND	#$F0
		BNE	loc_8C33B
		LDA	temp_x_l
		AND	#$F0
		ORA	#$A
		STA	temp_x_l
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$BC
		JMP	horizontal_spring
		;STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		;LDA	#$F0
		;STA	sonic_X_speed
		;LDA	#2
		;STA	sonic_inertia_timer
		;LDA	#0
		;STA	tmp_var_25
		;LDA	#$0C	; SFX:SPRING
		;STA	sfx_to_play
		;RTS
; ---------------------------------------------------------------------------

loc_8C33B:
		LDA	temp_y_l
		AND	#$F
		CMP	#7
		BCS	loc_8C35D
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		BCS	loc_8C35D
		SEC
		SBC	#$10
		STA	temp_y_l
		DEC	temp_y_h

loc_8C35D:
		LDA	#1
		STA	block_chk_coll_flag
		RTS
; End of function sub_8C309


; =============== S U B	R O U T	I N E =======================================


sub_8C362:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8C38B
		LDA	sonic_Y_l
		EOR	temp_y_l
		AND	#$F0
		BNE	loc_8C38B
		LDA	temp_x_l
		AND	#$F0
		ORA	#$A
		STA	temp_x_l
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#$41
horizontal_spring:
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$F0
		STA	sonic_X_speed
		LDA	#2
		LDY	sonic_anim_num
		CPY	#$20
		BNE	@c1
		LDA	#1
@c1
		STA	sonic_inertia_timer
		LDA	#0
		STA	tmp_var_25
		LDA	#$0C	; SFX:SPRING
		STA	sfx_to_play
		RTS	
; ---------------------------------------------------------------------------

loc_8C38B:
		LDA	temp_y_l
		AND	#$F
		CMP	#7
		BCS	loc_8C3AD
		LDA	#1
		STA	tmp_var_26
		LDA	#0
		STA	sonic_Y_speed
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		BCS	loc_8C3AD
		SEC
		SBC	#$10
		STA	temp_y_l
		DEC	temp_y_h

loc_8C3AD:
		LDA	#1
		STA	block_chk_coll_flag
		RTS
; End of function sub_8C362


; =============== S U B	R O U T	I N E =======================================


sub_8C3B2:
		LDA	temp_x_l
		AND	#$F0
		STA	tmp_var_25
		LDA	sonic_X_l
		AND	#$F0
		CMP	tmp_var_25
		BEQ	loc_8C3DB
		BCC	loc_8C3CB
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FE
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		JMP	loc_8C3D1
; ---------------------------------------------------------------------------

loc_8C3CB:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_8C3D1:
		LDA	sonic_X_speed
		CMP	#$20
		BCS	loc_8C3DB
		LDA	#$20
		STA	sonic_X_speed

loc_8C3DB:
		LDA	temp_y_l
		AND	#$F0
		STA	tmp_var_25
		LDA	sonic_Y_l
		AND	#$F0
		CMP	tmp_var_25
		BEQ	loc_8C406
		BCC	loc_8C3F4
		LDA	sonic_attribs	; BUMPER (SPRING YARD)
		AND	#$FB
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		JMP	loc_8C3FA
; ---------------------------------------------------------------------------

loc_8C3F4:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#4		; BUMPER (SPRING YARD)
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		
loc_8C3FA:
		LDA	#$0D		; SFX:BUMPER
		STA	sfx_to_play
		LDA	#$40
		STA	sonic_Y_speed
		LDA	sonic_X_speed
		BNE	loc_8C406
		LDA	#1
		STA	sonic_X_speed

loc_8C406:
		;LDA	#1
		LDA	#8
		STA	sonic_anim_num
		RTS
; End of function sub_8C3B2


; =============== S U B	R O U T	I N E =======================================


block_8E_phys:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C434
		LDA	sonic_Y_speed
		CMP	#$18
		BCS	loc_8C434
		LDA	sonic_Y_speed
		BEQ	@no_chg
		LDA	#2
		STA	sonic_Y_speed
@no_chg:
		LDA	temp_y_l
		CLC
		ADC	#$10
		STA	temp_y_l
		CMP	#$F0
		BCC	loc_8C42B
		INC	temp_y_h
		CLC
		ADC	#$10

loc_8C42B:
		AND	#$F0
		STA	temp_y_l
		LDA	#1
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

loc_8C434:
		JMP	blk_dec_sonic_speed
; End of function block_8E_phys


; =============== S U B	R O U T	I N E =======================================


sub_8C437:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8C46F
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		LDA	temp_x_h
		ADC	#0
		STA	temp_x_h
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C462
		LDA	sonic_Y_speed
		CMP	#3
		BCS	loc_8C462
		LDA	sonic_X_speed
		CMP	#2
		BCC	loc_8C462
		LDA	#$D
		STA	sonic_anim_num

loc_8C462:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FE
		LDA	#1
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

loc_8C46F:
		LDA	#0
		STA	tmp_var_26
		RTS
; End of function sub_8C437


; =============== S U B	R O U T	I N E =======================================


sub_8C474:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BNE	loc_8C4AC
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l
		LDA	temp_x_h
		SBC	#0
		STA	temp_x_h
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C49F
		LDA	sonic_Y_speed
		CMP	#3
		BCS	loc_8C49F
		LDA	sonic_X_speed
		CMP	#2
		BCC	loc_8C49F
		LDA	#$D
		STA	sonic_anim_num

loc_8C49F:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		LDA	#1
		STA	tmp_var_26
		RTS
; ---------------------------------------------------------------------------

loc_8C4AC:
		LDA	#0
		STA	tmp_var_26
		RTS
; End of function sub_8C474


; =============== S U B	R O U T	I N E =======================================


block_94_phys:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	loc_8C4E7
		LDA	sonic_Y_speed
		CMP	#3
		BCS	loc_8C4C7
		LDA	sonic_X_speed
		CMP	#2
		BCC	loc_8C4C7
		LDA	#$D
		STA	sonic_anim_num

loc_8C4C7:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#1
		BEQ	loc_8C4DC
		LDA	sonic_X_l
		;AND	#$F8 ; bugged (03 Sticking wall)
		AND	#$F0 ; original
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		RTS
; ---------------------------------------------------------------------------

loc_8C4DC:
		LDA	sonic_X_l
		ORA	#$F
		STA	temp_x_l
		LDA	sonic_X_h
		STA	temp_x_h
		RTS
; ---------------------------------------------------------------------------

loc_8C4E7:
		LDA	sonic_X_l
		EOR	temp_x_l
		AND	#$F0
		BNE	loc_8C50D
		LDA	temp_y_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_y_l
		CMP	#$F0
		BCC	loc_8C502
		LDA	#0
		STA	temp_y_l
		INC	temp_y_h

loc_8C502:
		LDA	#2
		STA	sonic_Y_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		;AND	#$FB
		AND	#$F3
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8C50D:
		JMP	loc_8C4C7
; End of function block_94_phys

; ---------------------------------------------------------------------------

;unused_2E520:				; 0x4 -	up, 0x43 - left, 01-left
;		LDA	sonic_attribs
;		AND	#1
;		BEQ	loc_8C523
;		LDA	sonic_X_l
;		AND	#$F0
;		STA	temp_x_l
;		LDA	sonic_X_h
;		STA	temp_x_h
;		JMP	loc_8C52D
; ---------------------------------------------------------------------------
;
;loc_8C523:
;		LDA	sonic_X_l
;		ORA	#$F
;		STA	temp_x_l
;		LDA	sonic_X_h
;		STA	temp_x_h
;
;loc_8C52D:				; 0x4 -	up, 0x43 - left, 01-left
;		LDA	sonic_attribs
;		AND	#4
;		BNE	loc_8C543
;		LDA	sonic_Y_speed
;		CMP	#3
;		BCS	loc_8C543
;		LDA	sonic_X_speed
;		CMP	#2
;		BCC	loc_8C543
;		LDA	#$D
;		STA	sonic_anim_num
;
;loc_8C543:
;		LDA	#0
;		STA	sonic_X_speed
;		LDA	#1
;		STA	tmp_var_26
;		RTS
; ---------------------------------------------------------------------------
;
;unused_2E55C:
;		LDA	sonic_Y_l
;		EOR	temp_y_l
;		AND	#$F0
;		BEQ	locret_8C57B
;		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
;		AND	#4
;		BEQ	loc_8C569
;		BEQ	locret_8C57B
;		LDA	sonic_Y_l
;		AND	#$F0
;		STA	temp_y_l
;		LDA	sonic_Y_h
;		STA	temp_y_h
;		JMP	loc_8C573
; ---------------------------------------------------------------------------
;
;loc_8C569:
;		LDA	sonic_Y_l
;		ORA	#$F
;		STA	temp_y_l
;		LDA	sonic_Y_h
;		STA	temp_y_h
;
;loc_8C573:
;		LDA	#0
;		STA	sonic_Y_speed
;		LDA	#1
;		STA	tmp_var_26
;
;locret_8C57B:
;		RTS

; =============== S U B	R O U T	I N E =======================================


block_96_phys:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	locret_8C5A7
		LDA	temp_y_l
		CLC
		ADC	#$10
		STA	temp_y_l
		LDA	temp_y_h
		ADC	#0
		STA	temp_y_h
		LDA	temp_y_l
		CMP	#$F0
		BCC	loc_8C599
		INC	temp_y_h	; CHECK
		LDA	#0

loc_8C599:
		AND	#$F0
		STA	temp_y_l
		LDA	sonic_attribs
		AND	#$F3
		STA	sonic_attribs
		LDA	#2
		STA	sonic_Y_speed

locret_8C5A7:
		RTS
; End of function block_96_phys


; =============== S U B	R O U T	I N E =======================================


water_block:
		LDA	block_number
		CMP	#$98
		BNE	@not_in_water
		LDA	sonic_anim_num
		CMP	#9
		BEQ	@loc_8C5BA
		LDA	water_timer
		BNE	@loc_8C5BA
		INC	water_timer
		JSR	create_water_splash
@loc_8C5BA:
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

@not_in_water:
		LDA	water_timer
		BEQ	@no_need_clr
		LDA	#1		; / hack for lab boss music fix
		STA	boss_life	; \ hack for lab boss music fix
		JSR	create_water_splash
@no_need_clr:
		LDA	#0
		STA	water_timer	; in water flag
		LDX	level_id
		LDY	music_by_level,X
		LDA	level_finish_func_num
		BNE	loc_107FFD
		LDA	music_to_play
		CMP	#$37	; super sonic music (s2)
		BEQ	loc_107FFD
		CMP	#$38	; super sonic music (s3k)
		BEQ	loc_107FFD
		CMP	#$3B	; super sonic music (s2)
		BEQ	loc_107FFD
		CMP	#$3C	; super sonic music (s3k)
		BEQ	loc_107FFD
		LDA	#$2C	; extra life
		CMP	music_to_play
		BEQ	loc_107FFD
		CMP	current_music
		BEQ	loc_107FFD
		LDA	#$21	; inviciblity
		CMP	music_to_play
		BEQ	loc_107FFD
		CMP	current_music
		BEQ	loc_107FFD
		LDA	sonic_state ; SuperS?
		BPL	@not_supers
		JSR	set_supers_music
		TAY
@not_supers
		LDA	invicible_timer
		BEQ	loc_107FFB
		LDY	#$21

loc_107FFB:
		STY	music_to_play

loc_107FFD:
		JMP	blk_dec_sonic_speed
; End of function water_block


; =============== S U B	R O U T	I N E =======================================


create_water_splash:
		LDA	#$1B ; SFX:WATER_SPLASH
		STA	sfx_to_play
		LDY	objects_cnt
		CPY	#19
		BCS	@no_create_splash
		LDA	chr_spr_bank2
		CMP	#$E0	; no draw water splash with eggman chr sets
		BCS	@no_create_splash
		LDA	#$1D
		STA	objects_type,Y
		LDA	#$90
		STA	objects_var_cnt,Y
		LDA	#0
		STA	objects_sav_slot,Y
		LDA	sonic_X_l
		SEC
		SBC	#8
		STA	objects_X_l,Y
		LDA	sonic_X_h
		SBC	#0
		STA	objects_X_h,Y
		LDA	sonic_Y_l
		SEC
		SBC	#$18
		STA	objects_Y_l,Y
		LDA	sonic_Y_h
		SBC	#0
		STA	objects_Y_h,Y
		INY
		STY	objects_cnt

@no_create_splash:
		RTS


; =============== S U B	R O U T	I N E =======================================


waterfall_block:
		LDA	#$2B
		STA	sonic_anim_num
		LDA	#0
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	block_number
		AND	#1
		TAX
		LDA	asl4_table,X
		STA	block_4bits_mask
		LDA	sonic_attribs
		AND	#MOVE_UP
		BEQ	loc_8C5ED
		LDA	#8
		STA	sonic_anim_num
		JMP	blk_dec_sonic_speed
; ---------------------------------------------------------------------------

loc_8C5ED:
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		TAX
		LDA	temp_y_l
		AND	#$F0
		ORA	waterfall_Y_tbl,X
		STA	temp_y_l
		LDA	block_number
		CMP	#$9A
		BNE	loc_8C60A
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$32
		JMP	loc_8C60E
; ---------------------------------------------------------------------------

loc_8C60A:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#$41

loc_8C60E:				; 0x4 -	up, 0x43 - left, 01-left
		STA	sonic_attribs
		;LDA	#$90
		;STA	sonic_X_speed
		LDA	#0
		STA	sonic_Y_speed

		LDA	#$80
		BIT	sonic_state
		BMI	loc_107F3A
		LDY	speed_shoes_timer
		BEQ	loc_107F3C

loc_107F3A:
		LDA	#$20

loc_107F3C:
		STA	sonic_X_speed
		LDA	noise_sfx_ptr
		BNE	locret_107F47
		LDA	#$13	; SFX:WATERFALL
		STA	sfx_to_play

locret_107F47:
		RTS
; End of function waterfall_block

; ---------------------------------------------------------------------------
waterfall_Y_tbl:.BYTE	 0,   1,   2,	3,   4,	  5,   6,   7,	 8,   9,  $A,  $B,  $C,	 $D,  $E,  $F
		.BYTE	$F,  $E,  $D,  $C,  $B,	 $A,   9,   8,	 7,   6,   5,	4,   3,	  2,   1,   1

; =============== S U B	R O U T	I N E =======================================


waterfall_2_block:
		LDA	#0
		STA	sonic_X_speed
		STA	round_walk_spr_add
		STA	sonic_rwalk_attr
		LDA	#$60
		STA	sonic_Y_speed
		LDA	#$2B
		STA	sonic_anim_num
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$F3
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; End of function waterfall_2_block


; =============== S U B	R O U T	I N E =======================================


tunnel_blocks1:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#0
		STA	tmp_var_26
		LDA	block_number
		AND	#7
		TAX
		LDA	tunnel_Xspd_tbl1,X
		STA	sonic_X_speed
		LDA	tunnel_Yspd_tbl1,X
		STA	sonic_Y_speed
		LDA	asl4_table,X
		STA	tmp_var_25
		LDA	temp_x_l
		AND	#$F
		ORA	tmp_var_25
		TAY
		LDA	tunnel_pos_tbl1,Y
		STA	tmp_var_25
		BMI	loc_8C687
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		JMP	SPIN_IN_TUNNEL
; ---------------------------------------------------------------------------

loc_8C687:
		CMP	#$FF
		BEQ	SPIN_IN_TUNNEL
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	#1
		STA	tmp_var_26

SPIN_IN_TUNNEL:
		LDA	#$20
		STA	sonic_anim_num
		LDA	#8
		STA	sfx_to_play
		LDA	#0
		STA	water_timer
		LDA	sonic_attribs
		ORA	#$10
		STA	sonic_attribs
		RTS
; End of function tunnel_blocks1

; ---------------------------------------------------------------------------
tunnel_Xspd_tbl1:.BYTE  $F0, $F0, $90, $10, $70, $A0, $F0, $F0
tunnel_Yspd_tbl1:.BYTE  $10, $20, $60, $60, $10, $10, $10, $10
tunnel_pos_tbl1:.BYTE	 2,   2,   2,	2,   2,	  2,   2,   2,	 2,   2,   2,	2,   2,	  2,   2,   2
		.BYTE	 2,   2,   2,	2,   3,	  3,   3,   3,	 4,   4,   4,	4,   6,	  6,   6,   6
		.BYTE	 6,   6,   7,	7,   7,	  7,   8,   8,	 8,   9,  $A,  $B,  $C,	 $D,  $E,  $F
		.BYTE	 0,   2,   4,	6,   8,	 $A,  $C,  $C,	$E,  $F, $FF, $FF, $FF,	$FF, $FF, $FF
		.BYTE  $F0, $F0, $F0, $F0, $F0,	$F0, $F0, $F0, $F0, $F0,   0,	4,   6,	  8,   9,  $B
		.BYTE  $F0, $F0, $F0, $F0,   0,	  2,   4,   5,	 6,   6,   7,	8,   8,	  9,  $A,  $C
		.BYTE  $F0, $F0, $F0, $F0, $F0,	  0,   2,   3,	 4,   4,   5,	5,   6,	  6,   7,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   9,   9,	 9,   9,   9,	9,  $A,	 $A,  $A,  $A

; =============== S U B	R O U T	I N E =======================================


tunnel_blocks2:
		LDA	#0
		STA	tmp_var_26
		LDA	asl4_table,X
		STA	tmp_var_25
		LDA	temp_x_l
		AND	#$F
		ORA	tmp_var_25
		TAY
		LDA	tunnel_pos_tbl2,Y
		STA	tmp_var_25
		BMI	loc_8C76C
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	block_number
		AND	#7
		TAX
		BEQ	loc_8C75F
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_8C75F:
		LDA	tunnel_Xspd_tbl2,X
		STA	sonic_X_speed
		LDA	tunnel_Yspd_tbl2,X
		STA	sonic_Y_speed
		JMP	SPIN_IN_TUNNEL
; ---------------------------------------------------------------------------

loc_8C76C:
		CMP	#$FF
		BEQ	loc_8C783
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		LDA	temp_y_h
		SBC	#0
		STA	temp_y_h
		LDA	#1
		STA	tmp_var_26

loc_8C783:
		JMP	SPIN_IN_TUNNEL
; End of function tunnel_blocks2

; ---------------------------------------------------------------------------
tunnel_Xspd_tbl2:.BYTE  $F0, $60, $60
tunnel_Yspd_tbl2:.BYTE  $10, $30, $30
tunnel_pos_tbl2:.BYTE	$A,  $A,  $A,  $A,  $A,	 $A,  $A,  $A,	$A,  $A,  $A,  $A,  $A,	 $A,  $A,  $A
		.BYTE	 7,   6,   4,	1,   0,	  0, $F0, $F0, $F0, $F0, $F0, $F0, $F0,	$F0, $F0,   0
		.BYTE  $FF, $FF, $FF, $FF, $FF,	 $F,  $F,  $E,	$E,  $D,  $C,  $A,   9,	  8,   8,   7

; =============== S U B	R O U T	I N E =======================================


tunnel_blocks3:
		LDA	#0
		STA	tmp_var_26
		LDA	block_number
		AND	#7
		TAX
		CMP	#1
		BNE	loc_8C7D1
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FC
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left

loc_8C7D1:
		LDA	tunnel_Xspd_tbl3,X
		STA	sonic_X_speed
		LDA	tunnel_Yspd_tbl3,X
		STA	sonic_Y_speed
		LDA	asl4_table,X
		STA	tmp_var_25
		LDA	temp_y_l
		AND	#$F
		ORA	tmp_var_25
		TAY	
		LDA	tunnel_Xpos_tbl3,Y
		STA	tmp_var_25
		LDA	temp_x_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_x_l
		JMP	SPIN_IN_TUNNEL
; End of function tunnel_blocks3
; ---------------------------------------------------------------------------
tunnel_Xspd_tbl3:.BYTE	 1, $10, $90, $10,   0,	  0,   0,   0
tunnel_Yspd_tbl3:.BYTE $60, $10, $60, $60, $60,	$60, $60, $60
tunnel_Xpos_tbl3:.BYTE	 4,   4,   4,	4,   4,	  4,   4,   4,	 4,   4,   4,	4,   4,	  4,   4,   4
		.BYTE	 5,   5,   5,	6,   6,	  6,   7,   7,	 7,   7,   7,	7,   8,	  8,   9,  $A
		.BYTE	 4,   4,   4,	4,   4,	  4,   4,   4,	 4,   4,   4,	4,   4,	  4,   4,   4
		.BYTE	 5,   5,   5,	6,   6,	  6,   7,   7,	 7,   7,   7,	7,   8,	  8,   8,   8
		.BYTE	 8,   9,  $A,  $A,  $A,	 $B,  $B,  $B,	$C,  $C,  $C,  $C,  $D,	 $D,  $D,  $D
		.BYTE	$D,  $D,  $D,  $D,  $D,	 $D,  $D,  $D,	$D,  $D,  $D,  $D,  $D,	 $D,  $D,  $D
		.BYTE	$D,  $D,  $D,  $D,  $C,	 $C,  $C,  $C,	$B,  $B,  $B,  $B,  $A,	 $A,   9,   8
		.BYTE	 8,   8,   8,	8,   8,	  8,   7,   7,	 7,   7,   7,	7,   6,	  6,   6,   6

; =============== S U B	R O U T	I N E =======================================


sub_8CB89:
		LDA	block_number
		CMP	#$C4
		BNE	loc_8CBA2
		LDA	temp_x_l
		AND	#$F
		CMP	#4
		BCC	locret_8CBC6
		LDA	temp_x_l
		AND	#$F0
		ORA	#3
		STA	temp_x_l
		JMP	loc_8CBB2
; ---------------------------------------------------------------------------

loc_8CBA2:
		LDA	temp_x_l
		AND	#$F
		CMP	#$C
		BCS	locret_8CBC6
		LDA	temp_x_l
		AND	#$F0
		ORA	#$C
		STA	temp_x_l

loc_8CBB2:
		LDA	#0
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	locret_8CBC6
		LDA	sonic_Y_speed
		CMP	#3
		BCS	locret_8CBC6
		LDA	#$D
		STA	sonic_anim_num

locret_8CBC6:
		RTS
; End of function sub_8CB89


; =============== S U B	R O U T	I N E =======================================


sub_8CBC7:
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	locret_8CC04
		LDA	block_number
		AND	#3
		TAY
		LDA	byte_8CC05,Y
		STA	tmp_var_28
		LDA	temp_x_l
		AND	#$F
		ORA	tmp_var_28
		TAY
		LDA	byte_8CC09,Y
		BMI	locret_8CC04
		STA	tmp_var_2B
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_2B
		BCC	locret_8CC04
		LDA	temp_y_l
		AND	#$F0
		ORA	#8
		STA	temp_y_l
		LDA	#0
		STA	sonic_Y_speed
		LDA	sonic_X_speed
		SEC
		SBC	#3
		;BPL	loc_8CC02
		BCS	loc_8CC02
		LDA	#0

loc_8CC02:
		STA	sonic_X_speed

locret_8CC04:
		RTS
; End of function sub_8CBC7

; ---------------------------------------------------------------------------
byte_8CC05:	.BYTE	 0, $10, $20, $30
byte_8CC09:	.BYTE  $FF, $FF, $FF, $FF,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8
		.BYTE    8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8, $FF, $FF, $FF, $FF

; =============== S U B	R O U T	I N E =======================================


spikes_block:
		LDA	sonic_attribs
		AND	#MOVE_UP
		BNE	@skip
		LDA	temp_y_l
		AND	#$F
		CMP	#8
		BCS	loc_8CC32
@skip
		RTS
; ---------------------------------------------------------------------------

loc_8CC32:
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz
		LDA	act_id
		CMP	#2
		BCC	hit_on_lava_or_spikes
@not_sbz:
		LDA	temp_y_l
		AND	#$F0
		ORA	#8
		STA	temp_y_l

hit_on_lava_or_spikes:				; 0x2- shield; 0x4 - rolling
		LDA	sonic_state
		CMP	#8
		BCS	loc_8CC44
		LDA	sonic_blink_timer
		ORA	invicible_timer
		BEQ	j_sonic_get_dmg

loc_8CC44:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#4
		BNE	loc_8CC4E
		
		LDA	level_id
		CMP	#SCRAP_BRAIN
		BNE	@not_sbz
		LDA	act_id
		CMP	#2
		BCC	loc_8CC4E
@not_sbz:

		LDA	#0
		STA	sonic_Y_speed

loc_8CC4E:
		LDA	sonic_X_speed
		SEC
		SBC	#2
		BPL	loc_8CC57
		LDA	#0

loc_8CC57:
		STA	sonic_X_speed
locret_8CC59:		
		RTS
; End of function spikes_block


; =============== S U B	R O U T	I N E =======================================


lava_block:
		LDA	temp_y_l
		AND	#$F
		CMP	#8
		BCC	hit_on_lava_or_spikes
		BCS	loc_8CC32
; End of function lava_block


; =============== S U B	R O U T	I N E =======================================


upper_spikes_block:
		LDA	sonic_state
		BMI	locret_8CC59
		LDA	sonic_blink_timer
		ORA	invicible_timer
		BNE	locret_8CC59
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BEQ	locret_8CC59
j_sonic_get_dmg:
		LDA	#6	; blink timer and flag obj/bkg
		JMP	sonic_get_dmg ; to main.asm


; =============== S U B	R O U T	I N E =======================================


;blk_dec_sonic_speed:
;		LDA	sonic_X_speed
;		BEQ	loc_8CD9C
;		DEC	sonic_X_speed
;loc_8CD9C:
;		RTS
; End of function blk_dec_sonic_speed

; ---------------------------------------------------------------------------

;unused_2EDAF:
;		LDA	temp_y_l
;		SEC
;		SBC	#$10
;		ORA	#$F
;		STA	temp_y_l
;		LDA	temp_y_h
;		SBC	#0
;		STA	temp_y_h
;		LDA	temp_y_l
;		CMP	#$F0
;		BCC	loc_8CDB9
;		SEC
;		SBC	#$10
;		STA	temp_y_l
;
;loc_8CDB9:
;		LDA	#1
;		STA	tmp_var_26
;		LDA	#0
;		STA	sonic_Y_speed
;		RTS

; =============== S U B	R O U T	I N E =======================================


sub_8CDC2:
		LDA	block_number
		CMP	#$D0
		BEQ	loc_8CDCB
		JMP	loc_8CDD2
; ---------------------------------------------------------------------------

loc_8CDCB:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		EOR	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		RTS
; ---------------------------------------------------------------------------

loc_8CDD2:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		EOR	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#4
		BNE	@loc_8CDE8
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		JMP	@loc_8CDF1
; ---------------------------------------------------------------------------

@loc_8CDE8:
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l

@loc_8CDF1:
		LDA	#$80
		STA	sonic_X_speed
		RTS
; End of function sub_8CDC2


; =============== S U B	R O U T	I N E =======================================


spec_spring_block:
		LDA	#$B0
		STA	sonic_Y_speed
		LDA	#$40
		STA	sonic_X_speed
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#4
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#8
		STA	sonic_anim_num
		LDA	#$0C	; SFX:SPRING
		STA	sfx_to_play
		RTS
; End of function spec_spring_block


; =============== S U B	R O U T	I N E =======================================


sub_8CE09:
		LDA	block_number
		AND	#3
		TAY
		LDA	asl4_table,Y
		STA	block_4bits_mask
		LDA	temp_x_l
		AND	#$F
		ORA	block_4bits_mask
		STA	tmp_var_2B
		TAY
		LDA	byte_8CEF2,Y
		BMI	locret_8CE61
		STA	tmp_var_25
		LDA	block_number
		CMP	#$DA
		BCS	loc_8CE34
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCC	locret_8CE61
		JMP	loc_8CE3C
; ---------------------------------------------------------------------------

loc_8CE34:
		LDA	temp_y_l
		AND	#$F
		CMP	tmp_var_25
		BCS	locret_8CE61

loc_8CE3C:
		LDA	temp_y_l
		AND	#$F0
		ORA	tmp_var_25
		STA	temp_y_l
		LDA	block_number
		AND	#3
		TAX
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$F0
		ORA	byte_8CEEE,X	; BUMPER_BONUS1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	tmp_var_2B
		AND	#$1F
		TAY
		LDA	byte_8CF32,Y
		STA	sonic_X_speed
		LDA	byte_8CF52,Y
		STA	sonic_Y_speed
		LDA	#$0D		; SFX: bumper
		STA	sfx_to_play

locret_8CE61:
		RTS
; End of function sub_8CE09


; =============== S U B	R O U T	I N E =======================================


sub_8CE62:
		LDA	#8
		STA	sonic_anim_num
		LDA	block_number
		CMP	#$DC
		BNE	not_block_DC
		LDA	temp_y_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_y_l
		CMP	#$F0
		BCC	loc_8CE80
		SEC
		SBC	#$10
		STA	temp_y_l
		DEC	temp_y_h

loc_8CE80:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		ORA	#4
		STA	sonic_attribs	; BUMPER BONUS2
		LDA	#$60
		STA	sonic_Y_speed
		LDA	#$20
		STA	sonic_X_speed
		LDA	#$0D		; SFX:BUMPER
		STA	sfx_to_play
		RTS
; ---------------------------------------------------------------------------

not_block_DC:
		CMP	#$DD
		BNE	loc_8CEB6
		LDA	temp_y_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_y_l
		CMP	#$F0
		BCC	loc_8CEA7
		CLC
		ADC	#$10
		STA	temp_y_l
		INC	temp_y_h

loc_8CEA7:				; 0x4 -	up, 0x43 - left, 01-left
		LDA	sonic_attribs
		AND	#$FB
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$60
		STA	sonic_Y_speed
		LDA	#$20
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CEB6:
		CMP	#$DE
		BNE	loc_8CED4
		LDA	temp_x_l
		SEC
		SBC	#$10
		ORA	#$F
		STA	temp_x_l
		LDA	temp_x_h
		SBC	#0
		STA	temp_x_h
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		ORA	#1
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$80
		STA	sonic_X_speed
		RTS
; ---------------------------------------------------------------------------

loc_8CED4:
		LDA	temp_x_l
		CLC
		ADC	#$10
		AND	#$F0
		STA	temp_x_l
		LDA	temp_x_h
		ADC	#0
		STA	temp_x_h
		LDA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		AND	#$FE
		STA	sonic_attribs	; 0x4 -	up, 0x43 - left, 01-left
		LDA	#$80
		STA	sonic_X_speed
		RTS
; End of function sub_8CE62

; ---------------------------------------------------------------------------
byte_8CEEE:	.BYTE	 5,   4,   1,	0
byte_8CEF2:	.BYTE  $FF, $FF,  $E,  $C,  $A,   9,   8,   7,   6,   5,   4,   4,   3,   3,   2,   2
		.BYTE    2,   2,   3,   3,   4,   4,   5,   6,   7,   8,   9,  $A,  $C,  $E, $FF, $FF
		.BYTE  $FF, $FF,   2,   4,   6,   7,   8,   9,  $A,  $B,  $C,  $C,  $D,  $D,  $E,  $E
		.BYTE   $E,  $E,  $D,  $D,  $C,  $C,  $B,  $A,   9,   8,   7,   6,   4,   2, $FF, $FF

byte_8CF32:	.BYTE  $A0, $A0, $90, $90, $80, $80, $70, $70, $60, $60, $50, $50, $40, $40, $30, $30
		.BYTE  $30, $30, $40, $40, $50, $50, $60, $60, $70, $70, $80, $80, $90, $90, $A0, $A0
		
byte_8CF52:	.BYTE  $10, $10, $20, $20, $30, $30, $40, $40, $50, $50, $60, $60, $70, $70, $80, $80
		.BYTE  $60, $60, $50, $50, $40, $40, $40, $30, $30, $30, $20, $20, $20, $10, $10, $10

		;.pad	$A000,$00
