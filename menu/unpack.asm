byte_0_10 = $10
byte_0_11 = $11
byte_0_12 = $12
byte_0_13 = $13
byte_0_14 = $14
byte_0_15 = $15
byte_0_16 = $16
byte_0_17 = $17
byte_0_18 = $18
byte_0_19 = $19
byte_0_1A = $1A
byte_0_1B = $1B
byte_0_1C = $1C
byte_0_1D = $1D
byte_0_1E = $1E
byte_0_1F = $1F


; ---------------------------------------------------------------------------



;AP_Unpack:
		LDY	#1
		LDX	#1
		STY	byte_0_13
		DEY
		STY	byte_0_15
		STY	byte_0_11

@loc_0_800C:
		JSR	@get_src_byte
@loc_0_8067:
		JSR	@write_dest_byte

@loc_0_801C:
		STY	byte_0_10
@loc_0_8020X:


@loc_0_8020:
		JSR	@sub_0_80F2
		BCC	@loc_0_800C
		JSR	@sub_0_80F2
		BCC	@loc_0_8072
		JSR	@sub_0_80F2
		STY	byte_0_14
		STY	byte_0_15
		BCC	@loc_0_811C
@loc_0_8038:
; --------------------------------------------------------------------------
		LDX	#4
@get_bit_4_times:
		JSR	@sub_0_80F2
		ROL	byte_0_14
		DEX
		BNE	@get_bit_4_times
		INX

		LDA	byte_0_14
		BEQ	@loc_0_8067
		JSR	@new_sub
		LDA	(byte_0_1E),Y
		BCS	@loc_0_8067
; ---------------------------------------------------------------------------

@loc_0_8072:
		JSR	@sub_0_8107
		LDA	byte_0_18
		SBC	#1	; -<-2	; carry
		CLC
		ADC	byte_0_10
		BNE	@loc_0_809E

		JSR	@sub_0_8107
		LDA	byte_0_16
		STA	byte_0_14
		LDA	byte_0_17
		STA	byte_0_15
		BCC	@loc_0_813F
; ---------------------------------------------------------------------------

@loc_0_809E:
		STA	byte_0_15
		DEC	byte_0_15
		JSR	@get_src_byte
		STA	byte_0_14
		JSR	@sub_0_8107
		LDA	byte_0_15
		CMP	#5
		BCC	@loc_0_80D9
		INC	byte_0_18
		BNE	@loc_0_8137
		INC	byte_0_19
		BCS	@loc_0_8137
; ---------------------------------------------------------------------------

@loc_0_811C:
		STX	byte_0_18
		STY	byte_0_19
		JSR	@get_src_byte
		LSR	A
		BEQ	@locret_0_8179
		ROL	byte_0_18
		STA	byte_0_14
		STY	byte_0_15

@loc_0_8137:
		LDA	byte_0_14
		STA	byte_0_16
		LDA	byte_0_15
		STA	byte_0_17

@loc_0_813F:
		JSR	@new_sub

@loc_0_8154:
		LDA	(byte_0_1E),Y
		INC	byte_0_1E
		BNE	@loc_0_815E
		INC	byte_0_1F

@loc_0_815E:
		JSR	@write_dest_byte

		LDA	byte_0_18
		BNE	@loc_0_816A
		DEC	byte_0_19

@loc_0_816A:
		DEC	byte_0_18
		BNE	@loc_0_8154
		LDA	byte_0_19
		BNE	@loc_0_8154
		STX	byte_0_10
		JMP	@loc_0_8020X

; ---------------------------------------------------------------------------

@loc_0_80D9:
		CMP	#1
		BCS	@loc_0_8137
		LDA	byte_0_14
		;CMP	#$80
		;BCS	@loc_0_8137
		BMI	@loc_0_8137
		LDA	byte_0_18
		ADC	#2
		STA	byte_0_18
		BCC	@loc_0_8137
		INC	byte_0_19
		BCS	@loc_0_8137


; =============== S U B	R O U T	I N E =======================================


@sub_0_8107:
		STX	byte_0_18
		STY	byte_0_19

@loc_0_810F:
		JSR	@sub_0_80F2
		ROL	byte_0_18
		ROL	byte_0_19
		JSR	@sub_0_80F2
		BCS	@loc_0_810F
@locret_0_8179:
		RTS
; End of function sub_0_8107


; =============== S U B	R O U T	I N E =======================================


@sub_0_80F2:
		DEC	byte_0_13
		BNE	@loc_0_8104
		LDA	#8
		STA	byte_0_13
		JSR	@get_src_byte
		STA	byte_0_12

@loc_0_8104:
		ASL	byte_0_12
		RTS
; End of function sub_0_80F2

; --------------------------------------------------------------------------

@new_sub:
		LDA	byte_0_1C
		SEC
		SBC	byte_0_14
		STA	byte_0_1E
		LDA	byte_0_1D
		SBC	byte_0_15
		STA	byte_0_1F
		RTS

; --------------------------------------------------------------------------

@write_dest_byte:
		STA	PPU_DATA
		STA	(byte_0_1C),Y
		INC	byte_0_1C
		BNE	@loc_0_801Cx
		INC	byte_0_1D
@loc_0_801Cx:
		RTS
; --------------------------------------------------------------------------
@get_src_byte:
		LDA	(byte_0_1A),Y
		INC	byte_0_1A
		BNE	@loc_0_8016
		INC	byte_0_1B

@loc_0_8016:
		RTS
