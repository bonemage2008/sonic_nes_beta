enum $FB
var_Temp:	.BYTE 0
var_Temp16:	.BYTE 0,0
var_Temp_Pattern:.BYTE 0,0
ende

enum $706
var_Channels:	.BYTE 0

var_Frame_List:	.BYTE 0,0
var_Frame_Count:.BYTE 0
var_Pattern_Length:.BYTE 0
var_Speed:	.BYTE 0
;var_Tempo:	.BYTE 0
var_InitialBank:.BYTE 0

var_Pattern_Pos:.BYTE 0
var_Current_Frame:.BYTE	0
var_Load_Frame:	.BYTE 0
var_Tempo_Accum:.BYTE 0,0
;var_Tempo_Dec:	.BYTE 0,0
var_Tempo_Count:.BYTE 0,0

var_Jump:	.BYTE 0
var_Skip:	.BYTE 0
;var_SkipTo:	.BYTE 0

var_ch_PatternAddrLo:.BYTE 0,0,0,0,0
var_ch_PatternAddrHi:.BYTE 0,0,0,0,0
;var_ch_Bank:	.BYTE 0,0,0,0,0
var_ch_Note:	.BYTE 0,0,0,0,0
var_ch_VolColumn:.BYTE 0,0,0,0,0
var_ch_Delay:	.BYTE 0,0,0,0,0
var_ch_NoteCut:	.BYTE 0,0,0,0,0

var_ch_FinePitch:.BYTE 0,0,0,0,0

var_ch_NoteDelay:.BYTE 0,0,0,0,0
var_ch_DefaultDelay:.BYTE 0,0,0,0,0
var_ch_TimerPeriodHi:.BYTE 0,0,0,0
var_ch_TimerPeriodLo:.BYTE 0,0,0,0
var_ch_PeriodCalcLo:.BYTE 0,0,0,0
var_ch_PeriodCalcHi:.BYTE 0,0,0,0
var_ch_VolSlide:.BYTE 0,0,0,0,0

var_ch_DutyCycle:.BYTE 0,0,0,0

var_ch_Effect:	.BYTE 0,0,0,0
var_ch_EffParam:.BYTE 0,0,0,0
var_ch_PortaToHi:.BYTE 0,0,0,0
var_ch_PortaToLo:.BYTE 0,0,0,0

var_ch_VibratoPos:.BYTE	0,0,0,0
var_ch_VibratoDepth:.BYTE 0,0,0,0
var_ch_VibratoSpeed:.BYTE 0,0,0,0

var_ch_Transpose:.BYTE 0,0,0,0
var_ch_PrevFreqLow:.BYTE 0,0
var_ch_PrevFreqHigh:.BYTE 0,0


Mxx_0cc	= 1

	IF	(Mxx_0cc=1)

var_ch_VolDelay		equ	$700  ; new var
var_ch_VolDefault	equ	$788

	ENDIF
	
;noise_sound	equ	$704 ; in snd_driver.asm
;noise_sfx_ptr	equ	$705 ; in vars.asm
pulse1_sound	equ	$780
;pulse2_sound	equ	$784
	
;var_ch_Transpose	equ	$164

ende


; ===========================================================================

; Segment type:	Pure code
		;.segment ROM
		
		.base	$8000

;		JMP	ft_music_init
j_songs_to_play	JMP	songs_to_play
; ---------------------------------------------------------------------------
j_ft_music_play	JMP	ft_music_play
; ---------------------------------------------------------------------------
snd_engine_init	JMP	detectNTSC

; =============== S U B	R O U T	I N E =======================================


ft_music_init:
		ASL	A
		TAY
		
		LDA	#0
		LDX	#<var_ch_PrevFreqHigh-1
@clr_snd_ram:
		STA	var_Channels+1,X
		DEX
		BNE	@clr_snd_ram
		
		JSR	ft_load_song
		
		LDA	#0
		STA	pulse1_sound
		STA	noise_sfx_ptr
		LDY	music_to_play
		CPY	#$22	; level win
		BEQ	@stop_sfx
		CPY	#$2D
		BNE	@not_chaos_em
@stop_sfx:
		STA	pulse2_sound
@not_chaos_em:

		LDX	#3
@LoadRegs1:				; pAPU Pulse #1	Control	Register (W)
		STA	SND_SQUARE1_REG,X
		DEX
		BPL	@LoadRegs1
		
		LDX	pulse2_sound
		BNE	@skip_pulse2_clear

		LDX	#3
@LoadRegs2:				; pAPU Pulse #1	Control	Register (W)
		STA	SND_SQUARE2_REG,X
		DEX
		BPL	@LoadRegs2

@skip_pulse2_clear:
		LDX	#11

@LoadRegs:				; pAPU Pulse #1	Control	Register (W)
		STA	SND_TRIANGLE_REG,X
		DEX
		BPL	@LoadRegs
		LDA	#$30
		STA	SND_NOISE_REG	; pAPU Noise Control Register #1 (W)
		LDA	#$F
		STA	SND_MASTERCTRL_REG ; pAPU Sound/Vertical Clock Signal Register (R)
		LDA	#8
		STA	pAPU_Pulse1_Ramp_Control_Reg ; pAPU Pulse #1 Ramp Control Register (W)
		STA	pAPU_Pulse2_Ramp_Control_Reg ; pAPU Pulse #2 Ramp Control Register (W)
		LDA	#$C0
		STA	JOYPAD_PORT2	; Joypad #2/SOFTCLK (RW)
		LDA	#$40
		STA	JOYPAD_PORT2	; Joypad #2/SOFTCLK (RW)

		LDA	var_Channels
		ORA	#%00101111	; 0x20 - enable playback
		;STA	var_Channels
	
		LDX	pulse2_sound
		BEQ	@ok
		AND	#%11111101 ; disable pulse2 (if currently used by sfx)
@ok		
		STA	var_Channels
		RTS
; End of function ft_music_init


; =============== S U B	R O U T	I N E =======================================


ft_load_song:
		LDA	ft_song_list,Y
		STA	var_Temp16
		LDA	ft_song_list+1,Y
		STA	var_Temp16+1

		LDY	#6-1
@load
		LDA	(var_Temp16),Y
		STA	var_Frame_List,Y
		DEY
		BPL	@load
		
		JSR	set_music_bank

		LDX	#3	; loop 4 channels

@ClearChannels2:
		LDA	#0
		STA	var_ch_VolDelay,X

		LDA	#$7F
		STA	var_ch_VolColumn,X
		
		IF	(Mxx_0cc=1)
		sta	var_ch_VolDefault,x ; 0cc
		ENDIF
		
		LDA	#$80
		STA	var_ch_FinePitch,X
		DEX
		BPL	@ClearChannels2
		
		;LDA	#$80
		STA	var_ch_Note+4
		
		;LDX	#$FF
		STX	var_ch_PrevFreqHigh
		STX	var_ch_PrevFreqHigh+1

		LDA	#0
		;STA	var_Current_Frame
		JSR	ft_load_frame
		;JMP	ft_calculate_tempo
; End of function ft_load_song


; =============== S U B	R O U T	I N E =======================================


ft_calculate_speed:
		STY	var_Temp
		LDY	var_Speed
;		LDA	speed_shoes_timer
;		BEQ	@normal_speed
;		DEY
;@normal_speed
		LDA	tempo_table_l,Y
		STA	var_Tempo_Count
		LDA	tempo_table_h,Y
		STA	var_Tempo_Count+1
		LDY	var_Temp
		RTS
; End of function ft_calculate_speed
; ---------------------------------------------------------------------------
tempo_table_l:
		.BYTE	<7200,<3600,<1800,<1200,<900,<720,<600,<514,<450,<400,<360,<327,<300,<276,<257,<240,<225,<212,<200,<189,<180
tempo_table_h:
		.BYTE	>7200,>3600,>1800,>1200,>900,>720,>600,>514,>450,>400,>360,>327,>300,>276,>257,>240,>225,>212,>200,>189,>180


; =============== S U B	R O U T	I N E =======================================


ft_load_frame:
		;LDY	#$87
		;STY	MMC3_bank_select
		;LDY	var_InitialBank
		;STY	MMC3_bank_data
		
		ASL	A
		CLC
		ADC	var_Frame_List
		STA	var_Temp16
		LDA	#0
		STA	var_Load_Frame
		STA	var_Jump
		STA	var_Skip
		STA	var_Pattern_Pos
		TAY
		ADC	var_Frame_List+1
		STA	var_Temp16+1
		LDA	(var_Temp16),Y
		PHA
		INY
		LDA	(var_Temp16),Y
		STA	var_Temp16+1
		PLA
		STA	var_Temp16
		LDY	#10	; for 5 channels
		LDX	#4	; for 5 channels

@LoadPatternAddr:
		DEY
		LDA	(var_Temp16),Y
		STA	var_ch_PatternAddrHi,X
		DEY
		LDA	(var_Temp16),Y
		STA	var_ch_PatternAddrLo,X
		LDA	#0
		STA	var_ch_NoteDelay,X
		STA	var_ch_Delay,X
		LDA	#$FF
		STA	var_ch_DefaultDelay,X
		DEX
		BPL	@LoadPatternAddr
		
ret_music_play:
		RTS
; ---------------------------------------------------------------------------

ft_SkipToRow:
ft_cmd_instrument:
ft_cmd_hold:
ft_cmd_tempo:
ft_cmd_effvolume:
ft_cmd_arpeggio:
ft_cmd_sweep:
ft_cmd_tremolo:
;ft_cmd_dac:
ft_cmd_sample_offset:
;ft_cmd_slide_down:
ft_cmd_retrigger:
ft_cmd_dpcm_pitch:
	IF	(Mxx_0cc=0)
ft_cmd_delayed_volume
	ENDIF
ft_cmd_note_release:
ft_cmd_linear_counter:
ft_cmd_groove:

ft_arpeggio:
		SEI
		LDA	#0
		STA	PPU_CTRL_REG1
inf2	
		JMP	inf2


; =============== S U B	R O U T	I N E =======================================


ft_music_play:
		;JSR	set_music_bank
		LDA	var_Channels
		AND	#$20	; 0x20 - enable playback
		BEQ	ret_music_play

		JSR	set_music_bank

		LDX	#4	; loop 5 channels

@ChanLoop_:
		LDA	var_ch_Delay,X
		BEQ	@SkipDelay
		DEC	var_ch_Delay,X
		BNE	@SkipDelay
		JSR	ft_read_pattern
		LDA	var_ch_NoteCut,X
		AND	#$7F
		STA	var_ch_NoteCut,X

@SkipDelay:
		DEX
		BPL	@ChanLoop_
		
		LDA	var_Tempo_Accum+1
		BMI	ft_do_row_update
		ORA	var_Tempo_Accum
		BEQ	ft_do_row_update
		JMP	ft_skip_row_update
; ---------------------------------------------------------------------------

ft_do_row_update:
		LDA	var_Load_Frame
		BEQ	@SkipFrameLoad
		
		LDX	#4	; loop 5 channels

@loc_82CA:
		LDA	var_ch_Delay,X
		BEQ	@loc_82DF
		LDA	#0
		STA	var_ch_Delay,X
		;JMP	ft_SkipToRow	; HALT
		JSR	ft_read_pattern
		LDA	var_ch_NoteCut,X
		AND	#$7F
		STA	var_ch_NoteCut,X

@loc_82DF:
		DEX
		BPL	@loc_82CA

		LDA	var_Current_Frame
		JSR	ft_load_frame

@SkipFrameLoad:

		LDX	#0

ft_read_channels:
		LDA	var_ch_Delay,X
		BEQ	loc_82FE
		LDA	#0
		STA	var_ch_Delay,X
		JSR	ft_read_pattern

loc_82FE:
		JSR	ft_read_pattern
		LDA	var_ch_NoteCut,X
		AND	#$7F
		STA	var_ch_NoteCut,X
		INX		; !no change to DEX+BPL!
		CPX	#5	; loop 5 channels
		BNE	ft_read_channels
		
		LDX	var_Jump
		BEQ	@NoJump
		DEX
		STX	var_Current_Frame
		LDA	#1
		INC	var_Load_Frame
		BNE	@NoPatternEnd	; JMP
; ---------------------------------------------------------------------------

@NoJump:
		LDX	var_Skip
		BEQ	@NoSkip
		DEX
		BEQ	@next
		JMP	ft_SkipToRow	; SkipToRow - HALT
		;DEX
		;STX	var_SkipTo
@next
		INC	var_Load_Frame
		INC	var_Current_Frame
		LDA	var_Current_Frame
		EOR	var_Frame_Count
		;BEQ	@RestartSong
		BNE	@NoPatternEnd	; JMP
; ---------------------------------------------------------------------------

@RestartSong:
		LDA	#0
		STA	var_Current_Frame
		BEQ	@NoPatternEnd	; JMP
; ---------------------------------------------------------------------------

@NoSkip:
		INC	var_Pattern_Pos
		LDA	var_Pattern_Pos
		CMP	var_Pattern_Length
		BNE	@NoPatternEnd
		INC	var_Current_Frame
		LDA	var_Current_Frame
		CMP	var_Frame_Count
		BEQ	@ResetFrame
		STA	var_Load_Frame
		BNE	@NoPatternEnd	; JMP
; ---------------------------------------------------------------------------

@ResetFrame:
		;LDX	#0
		STX	var_Current_Frame
		INC	var_Load_Frame

@NoPatternEnd:
		CLC
		LDA	var_Tempo_Accum
		BIT	var_Channels
		BPL	@ntsc_tempo
		ADC	#<3000
		STA	var_Tempo_Accum
		LDA	var_Tempo_Accum+1
		ADC	#>3000
		JMP	@pal_tempo
@ntsc_tempo		
		ADC	#<3600
		STA	var_Tempo_Accum
		LDA	var_Tempo_Accum+1
		ADC	#>3600
@pal_tempo:
		STA	var_Tempo_Accum+1

ft_skip_row_update:
		SEC
		LDA	var_Tempo_Accum
		SBC	var_Tempo_Count
		STA	var_Tempo_Accum
		LDA	var_Tempo_Accum+1
		SBC	var_Tempo_Count+1
		STA	var_Tempo_Accum+1
		
		LDA	speed_shoes_timer
		BEQ	no_music_speed_up
		SEC
		LDA	var_Tempo_Accum
		SBC	#128
		STA	var_Tempo_Accum
		BCS	no_music_speed_up
		DEC	var_Tempo_Accum+1
no_music_speed_up:
		
		LDX	#4	; loop 5 channels

loc_8384:
		LDA	var_ch_NoteCut,X
		BEQ	loc_83A9
		DEC	var_ch_NoteCut,X
		BNE	loc_83A9
		LDA	#0
		STA	var_ch_Note,X
		CPX	#4	; DPCM
		BEQ	loc_83A9
		;LDA	#0
		STA	var_ch_PortaToLo,X
		STA	var_ch_PortaToHi,X
		STA	var_ch_TimerPeriodLo,X
		STA	var_ch_TimerPeriodHi,X

loc_83A9:
		DEX
		BPL	loc_8384
		
		LDX	#3	; loop 4 channels

ft_loop_channels:

@BeginTranspose:
	lda var_ch_Transpose, x
	beq @DoneTranspose
	SEC
	bmi @Negative
	sbc #$10
	sta var_ch_Transpose, x
	bpl @DoneTranspose	; else var_ch_Transpose, x == #$Fx
	and #$0F
	clc
	BCC @Positive
@Negative:
	sbc #$10
	sta var_ch_Transpose, x
	bmi @DoneTranspose	; else var_ch_Transpose, x == #$7x
	eor #$8F
	sec
@Positive:
	adc var_ch_Note, x
;	sta var_ch_Note, x
	jsr ft_translate_freq_only
	lda #$00
	sta var_ch_Transpose, x	
@DoneTranspose:


		IF	(Mxx_0cc=1)
	lda var_ch_VolDelay, x
	beq @l1
	cmp #$10
	bcs @l1
	asl a
	asl a
	asl a
	asl a
	sta var_ch_VolDelay, x
@l1
		ENDIF

		JSR	ft_run_effects
		JSR	ft_calc_period
		
		IF	(Mxx_0cc=1)
;_0cc_delayed_volume
	lda var_ch_VolDelay, x
	and #$0F
	bne @l2
	lda var_ch_VolDelay, x
	and #$F0
	beq @l2
	lsr a
	sta var_ch_VolColumn, x
	lda #$00
	sta var_ch_VolDelay, x
@l2
	lda var_ch_VolDelay, x
	cmp #$10
	bcc @l3
	sbc #$10
	sta var_ch_VolDelay, x
@l3
		ENDIF

		DEX
		BPL	ft_loop_channels
		JMP	ft_update_apu
; End of function ft_music_play


; =============== S U B	R O U T	I N E =======================================


VolumeCommand:
		ASL	A
		ASL	A
		ASL	A
		AND	#$78
		STA	var_ch_VolColumn,X
		
		IF	(Mxx_0cc=1)
		sta var_ch_VolDefault, x ; 0cc
		ENDIF
		
		JMP	ft_read_note
; ---------------------------------------------------------------------------

InstCommand:
		CMP	#$F0
		BCS	VolumeCommand
		JMP	ft_read_note
; ---------------------------------------------------------------------------

Effect:
		INY
		CMP	#$E0
		BCS	InstCommand
		STY	var_Temp
		TAY
		LDA	ft_command_table-$80,Y
		STA	var_Temp16
		LDA	ft_command_table+1-$80,Y
		STA	var_Temp16+1
		LDY	var_Temp
		JMP	(var_Temp16)


; =============== S U B	R O U T	I N E =======================================


ft_read_pattern:
		LDY	var_ch_NoteDelay,X
		BEQ	loc_83D2
		DEC	var_ch_NoteDelay,X
		RTS
; ---------------------------------------------------------------------------

loc_83D2:

;		LDA	var_ch_Bank,X
;		BEQ	loc_83DD
;		JSR	set_bank
;
;loc_83DD:
		LDA	var_ch_PatternAddrLo,X
		STA	var_Temp_Pattern
		LDA	var_ch_PatternAddrHi,X
		STA	var_Temp_Pattern+1

ft_read_note:
		LDA	(var_Temp_Pattern),Y
		BMI	Effect
		BEQ	@ReadIsDone
		CMP	#$7E
		BCS	@NoteRelease
		STA	var_ch_Note,X
		JSR	ft_translate_freq
		LDA	var_ch_NoteCut,X
		BMI	@loc_8416
		LDA	#0
		STA	var_ch_NoteCut,X

@loc_8416:
		CPX	#4	; DPCM
		;BNE	@loc_8420
		;JMP	@ReadIsDone
		BEQ	@loc_8420
; ---------------------------------------------------------------------------

@loc_8420

	IF	(Mxx_0cc=1)
	lda var_ch_VolSlide, x
	bne @asd
	lda var_ch_VolDefault, x
	sta var_ch_VolColumn, x
@asd
	ENDIF

		LDA	var_ch_DutyCycle,X
		AND	#$FC
		STA	var_Temp
		;LSR	A
		;LSR	A
		LSR	A
		LSR	A
		ORA	var_Temp
		STA	var_ch_DutyCycle,X
		LDA	var_ch_Effect,X
		CMP	#6	; slide_up
		BEQ	@loc_8445
		CMP	#8	; slide_down
		BNE	@loc_844A

@loc_8445:
		LDA	#0
		STA	var_ch_Effect,X

@loc_844A:
		JMP	@ReadIsDone
; ---------------------------------------------------------------------------

@NoteRelease:
		CMP	#$7F
		BEQ	@NoteOff
		JMP	ft_SkipToRow	; NOTE RELEASE - HALT
; ---------------------------------------------------------------------------

@NoteOff:
		LDA	#0
		STA	var_ch_Note,X
		CPX	#4	; DPCM
		BEQ	@ReadIsDone
		;LDA	#0
		STA	var_ch_PortaToLo,X
		STA	var_ch_PortaToHi,X
		STA	var_ch_TimerPeriodLo,X
		STA	var_ch_TimerPeriodHi,X
		CPX	#2
		BCS	@ReadIsDone
		LDA	#$FF
		STA	var_ch_PrevFreqHigh,X

@ReadIsDone:
ReadIsDone:
		LDA	var_ch_DefaultDelay,X
		CMP	#$FF
		BNE	@LoadDefaultDelay
		INY
		LDA	(var_Temp_Pattern),Y
@LoadDefaultDelay:
		STA	var_ch_NoteDelay,X

ft_read_is_done:
		INY
ft_addr_update:
		CLC
		TYA
		ADC	var_Temp_Pattern
		STA	var_ch_PatternAddrLo,X
		LDA	#0
		ADC	var_Temp_Pattern+1
		STA	var_ch_PatternAddrHi,X
		RTS
; End of function ft_read_pattern


; =============== S U B	R O U T	I N E =======================================


		MACRO	ft_get_pattern_byte
		LDA	(var_Temp_Pattern),Y
		INY
		ENDM
; End of function ft_get_pattern_byte

; ---------------------------------------------------------------------------
ft_command_table:.WORD ft_cmd_instrument ; 00
		.WORD ft_cmd_hold ; 02
		.WORD ft_cmd_duration ; 04
		.WORD ft_cmd_noduration ; 06
		.WORD ft_cmd_speed ; 08
		.WORD ft_cmd_tempo ; 0A
		.WORD ft_cmd_jump ; 0C
		.WORD ft_cmd_skip ; 0E
		.WORD ft_cmd_halt ; 10
		.WORD ft_cmd_effvolume ; 12
		.WORD ft_cmd_clear ; 14
		.WORD ft_cmd_porta_up ; 16
		.WORD ft_cmd_porta_down ; 18
		.WORD ft_cmd_portamento ; 1a
		.WORD ft_cmd_arpeggio ; 1c
		.WORD ft_cmd_vibrato ; 1e
		.WORD ft_cmd_tremolo ; 20
		.WORD ft_cmd_pitch ; 22
		.WORD ft_cmd_reset_pitch ; 24
		.WORD ft_cmd_duty ; 26
		.WORD ft_cmd_delay ; 28
		.WORD ft_cmd_sweep ; 2a
		.WORD ft_cmd_dac ; 2c
		.WORD ft_cmd_sample_offset ; 2e
		.WORD ft_cmd_slide_up ; 30
		.WORD ft_cmd_slide_down ; 32
		.WORD ft_cmd_vol_slide ; 34
		.WORD ft_cmd_note_cut ; 36
		.WORD ft_cmd_retrigger ; 38
		.WORD ft_cmd_dpcm_pitch ; 3A
; 0cc effects		
		.WORD ft_cmd_note_release ; 3C
		.WORD ft_cmd_linear_counter ; 3E
		.WORD ft_cmd_groove ; 40
		.WORD ft_cmd_delayed_volume ; 42
		.WORD ft_cmd_transpose ; 44
		
		
; =============== S U B	R O U T	I N E =======================================


ft_cmd_speed:
		ft_get_pattern_byte
		STA	var_Speed
		JSR	ft_calculate_speed
		JMP	ft_read_note
; End of function ft_cmd_speed

	
; =============== S U B	R O U T	I N E =======================================


ft_cmd_halt:
		LDA	current_music
;		CMP	#$2D
;		BEQ	set_lvl_music
		CMP	#$3B
		BEQ	@supers_act
		CMP	#$3C
		BNE	@not_supers_act
@supers_act
		SBC	#4	; 37-38
		BNE	change_music ; JMP
		
@not_supers_act
		AND	#$FE
		CMP	#$2C	; 1 up / 2d- chaos emerald
		BNE	no_set_lvl_music
		LDA	player_lifes
		BEQ	no_set_lvl_music
		;BIT	sonic_state	; super sonic
		;BMI	no_set_lvl_music
		
;set_lvl_music:
		STY	var_Temp
		LDY     level_id
		LDA     music_by_level,y
		
		CPY	#LAB_ZONE
		BNE	@not_lab
		LDY	boss_life
		CPY	#10
		BNE	@not_lab
		LDA	#$29	; boss theme
@not_lab

		BIT	sonic_state	; 0x80 - super sonic
		BPL	@not_supersonic
		;JSR	start_supers_music
		JSR	set_supers_music
@not_supersonic
		LDY	invicible_timer
		BEQ	@no_invicible
;@play_nv_song:
		LDA	#$21
@no_invicible:

change_music:
		STA	music_to_play
		LDY	var_Temp
		
no_set_lvl_music:
		ft_get_pattern_byte
		LDA	var_Channels
		AND	#%11011111 ; 0x20 - enable/disable playback
		STA	var_Channels
		JMP	ft_read_note
; End of function ft_cmd_halt

		
; =============== S U B	R O U T	I N E =======================================
		
		
ft_cmd_porta_up:
		ft_get_pattern_byte
		STA	var_ch_EffParam,X
		LDA	#3
		STA	var_ch_Effect,X
		JMP	ft_read_note
; End of function ft_cmd_porta_up
		
		
; =============== S U B	R O U T	I N E =======================================


ft_cmd_porta_down:
		ft_get_pattern_byte
		STA	var_ch_EffParam,X
		LDA	#4
		STA	var_ch_Effect,X
		JMP	ft_read_note
; End of function ft_cmd_porta_down


; =============== S U B	R O U T	I N E =======================================


ft_cmd_duration:
		ft_get_pattern_byte
		STA	var_ch_DefaultDelay,X
		JMP	ft_read_note
; End of function ft_cmd_duration


; =============== S U B	R O U T	I N E =======================================


ft_cmd_noduration:
		LDA	#$FF
		STA	var_ch_DefaultDelay,X
		JMP	ft_read_note
; End of function ft_cmd_noduration


; =============== S U B	R O U T	I N E =======================================


ft_cmd_jump:
		ft_get_pattern_byte
		STA	var_Jump
		JMP	ft_read_note
; End of function ft_cmd_jump


; =============== S U B	R O U T	I N E =======================================


ft_cmd_skip:
		ft_get_pattern_byte
		STA	var_Skip
		JMP	ft_read_note
; End of function ft_cmd_skip


; =============== S U B	R O U T	I N E =======================================


ft_cmd_portamento:
		ft_get_pattern_byte
		STA	var_ch_EffParam,X
		LDA	#2
		STA	var_ch_Effect,X
		JMP	ft_read_note
; End of function ft_cmd_portamento


; =============== S U B	R O U T	I N E =======================================


ft_cmd_clear:
		JSR	clear_effect_porta
		;LDA	#0
		STA	var_ch_EffParam,X
		;STA	var_ch_Effect,X
		;STA	var_ch_PortaToLo,X
		;STA	var_ch_PortaToHi,X
		JMP	ft_read_note
; End of function ft_cmd_clear



; =============== S U B	R O U T	I N E =======================================


ft_cmd_vibrato:
		ft_get_pattern_byte
		STA	var_Temp
		LDA	var_ch_VibratoSpeed,X
		BNE	loc_8630
		STA	var_ch_VibratoPos,X

loc_8630:
		LDA	var_Temp
		AND	#$F0
		STA	var_ch_VibratoDepth,X
		LDA	var_Temp
		AND	#$F
		STA	var_ch_VibratoSpeed,X
		JMP	ft_read_note
; End of function ft_cmd_vibrato


; =============== S U B	R O U T	I N E =======================================


ft_cmd_pitch:
		ft_get_pattern_byte
write_fine_pitch:
		STA	var_ch_FinePitch,X
		JMP	ft_read_note
; End of function ft_cmd_pitch


; =============== S U B	R O U T	I N E =======================================


ft_cmd_reset_pitch:
		LDA	#$80
		BNE	write_fine_pitch
; End of function ft_cmd_reset_pitch


; =============== S U B	R O U T	I N E =======================================


ft_cmd_delay:
		LDA	(var_Temp_Pattern),Y
		STA	var_ch_Delay,X
		JMP	ft_read_is_done
; End of function ft_cmd_delay


; =============== S U B	R O U T	I N E =======================================


ft_cmd_duty:
		ft_get_pattern_byte
		CMP	#0	; no remove!
		BEQ	@write_duty
		BIT	var_Channels
		BVC	@no_swap
		CPX	#2
		BCS	@no_swap
		CMP	#3
		BEQ	@no_swap
;@swap_duty:
		EOR	#3	; swap 1 <-> 2
@no_swap:
		STA	var_Temp
		;ASL	A
		;ASL	A
		ASL	A
		ASL	A
		ORA	var_Temp
@write_duty:
		STA	var_ch_DutyCycle,X
		JMP	ft_read_note
; End of function ft_cmd_duty


; =============== S U B	R O U T	I N E =======================================


ft_cmd_slide_up:
		ft_get_pattern_byte
		STA	var_ch_EffParam,X
		LDA	#5
j_slide_ud:		
		STA	var_ch_Effect,X
		JMP	ft_read_note
; End of function ft_cmd_slide_up


; =============== S U B	R O U T	I N E =======================================


ft_cmd_slide_down:
		ft_get_pattern_byte
		STA	var_ch_EffParam,X
		LDA	#7
		BNE	j_slide_ud
		;STA	var_ch_Effect,X
		;JMP	ft_read_note
; End of function ft_cmd_slide_up


; =============== S U B	R O U T	I N E =======================================


ft_cmd_vol_slide:
		ft_get_pattern_byte
		STA	var_ch_VolSlide,X
		JMP	ft_read_note
; End of function ft_cmd_vol_slide


; =============== S U B	R O U T	I N E =======================================


ft_cmd_note_cut:
		ft_get_pattern_byte
		ORA	#$80
			clc
			adc #1	; fix for .0cc files
		STA	var_ch_NoteCut,X
		JMP	ft_read_note
; End of function ft_cmd_note_cut

; =============== S U B	R O U T	I N E =======================================


ft_cmd_dac:
		ft_get_pattern_byte
		STA	$4011
		JMP	ft_read_note


; =============== S U B	R O U T	I N E =======================================

		IF	(Mxx_0cc=1)
; Delayed channel volume (Mxy)   - 0cc-ft
ft_cmd_delayed_volume:
	ft_get_pattern_byte
	sta var_ch_VolDelay, x
	JMP	ft_read_note
		ENDIF
		
		
; =============== S U B	R O U T	I N E =======================================
		

ft_cmd_transpose:
	ft_get_pattern_byte
	sta var_ch_Transpose, x
	JMP	ft_read_note
	
; =============== S U B	R O U T	I N E =======================================
	
	
;ft_cmd_tremolo:
;		ft_get_pattern_byte
;		jmp	ft_read_note


; =============== S U B	R O U T	I N E =======================================


ft_load_period_table:
		ASL	A
		STY	var_Temp16
		TAY
		LDA	var_Channels
		AND	#$10
		BNE	pal_freqs
		LDA	ft_periods_ntsc+1,Y
		STA	var_Temp16+1
		LDA	ft_periods_ntsc,Y ; ntsc and dendy
		RTS

pal_freqs:
		LDA	ft_periods_pal+1,Y
		STA	var_Temp16+1
		LDA	ft_periods_pal,Y ; pal
		RTS		
; End of function ft_load_period_table



; =============== S U B	R O U T	I N E =======================================


ft_translate_freq_only:
		STA	var_ch_Note,X
		SEC
		SBC	#1
		CPX	#3
		BEQ	StoreNoise2
		JSR	ft_load_period_table

LoadFrequency:
		STA	var_ch_TimerPeriodLo,X
		LDA	var_Temp16+1
		STA	var_ch_TimerPeriodHi,X
RestoreY:
		LDY	var_Temp16 ; restore Y
		RTS
; ---------------------------------------------------------------------------

StoreNoise2:
		AND	#$F
		ORA	#$10
		STA	var_ch_TimerPeriodLo,X
		LDA	#0
		STA	var_ch_TimerPeriodHi,X
		RTS
; End of function ft_translate_freq_only


; =============== S U B	R O U T	I N E =======================================


ft_translate_freq:
		;SEC
		;SBC	#1
		SBC	#0
		CPX	#3
		BCS	StoreNoise
		JSR	ft_load_period_table
		LDY	var_ch_Effect,X
		CPY	#2
		BNE	LoadFrequency
		STA	var_ch_PortaToLo,X
		LDA	var_Temp16+1
		STA	var_ch_PortaToHi,X
		LDA	var_ch_TimerPeriodLo,X
		ORA	var_ch_TimerPeriodHi,X
		BNE	RestoreY
		LDA	var_ch_PortaToLo,X
		JMP	LoadFrequency
; ---------------------------------------------------------------------------

StoreNoise:
		ORA	#$10
		STA	var_Temp16
		LDA	var_ch_Effect,X
		CMP	#2
		BNE	@NoPorta2
		LDA	var_Temp16
		STA	var_ch_PortaToLo,X
		LDA	#0
		STA	var_ch_PortaToHi,X
		LDA	var_ch_TimerPeriodLo,X
		ORA	var_ch_TimerPeriodHi,X
		BNE	@Return2

@NoPorta2:
		LDA	var_Temp16
		STA	var_ch_TimerPeriodLo,X
		LDA	#0
		STA	var_ch_TimerPeriodHi,X

@Return2:
		RTS


; =============== S U B	R O U T	I N E =======================================


ft_portamento_down:
		LDA	var_ch_Note,X
		BEQ	NoEffect
		JSR	ft_period_add
		JMP	ft_limit_period_2a03
; ---------------------------------------------------------------------------

ft_portamento_up:
		LDA	var_ch_Note,X
		BEQ	NoEffect
		JSR	ft_period_remove

ft_limit_period_2a03:
;ft_limit_freq:
		LDA	var_ch_TimerPeriodHi,X
		BMI	@LimitMin
		CMP	#8
		BCC	@NoLimit
		LDA	#7
		STA	var_ch_TimerPeriodHi,X
		LDA	#$FF
		STA	var_ch_TimerPeriodLo,X

@NoLimit:
		RTS
; ---------------------------------------------------------------------------

@LimitMin:
write_period_0:
		LDA	#0
write_period:
		STA	var_ch_TimerPeriodLo,X
		STA	var_ch_TimerPeriodHi,X
NoEffect:
		RTS
; End of function ft_limit_period_2a03


; =============== S U B	R O U T	I N E =======================================


ft_run_effects:
		LDA	var_ch_VolSlide,X
		BEQ	ft_jump_to_effect
		AND	#$F
		STA	var_Temp
		SEC
		LDA	var_ch_VolColumn,X
		SBC	var_Temp
		BPL	loc_8888
		LDA	#0

loc_8888:
		STA	var_Temp
		LDA	var_ch_VolSlide,X
		LSR	A
		LSR	A
		LSR	A
		LSR	A
		CLC
		ADC	var_Temp
		BPL	loc_889E
		LDA	#$7F

loc_889E:
		STA	var_ch_VolColumn,X

ft_jump_to_effect:
		LDY	var_ch_Effect,X
		BEQ	NoEffect
		LDA	eff_jmptbl_l-1,Y
		STA	var_Temp16
		LDA	eff_jmptbl_h-1,Y
		STA	var_Temp16+1
		JMP	(var_Temp16)
; ---------------------------------------------------------------------------
eff_jmptbl_l:
		.BYTE	<ft_arpeggio,<ft_portamento,<ft_portamento_up,<ft_portamento_down,<ft_load_slide,<ft_slide_up,<ft_load_slide,<ft_slide_down
eff_jmptbl_h:
		.BYTE	>ft_arpeggio,>ft_portamento,>ft_portamento_up,>ft_portamento_down,>ft_load_slide,>ft_slide_up,>ft_load_slide,>ft_slide_down
; ---------------------------------------------------------------------------

ft_load_slide:
		LDA	var_ch_TimerPeriodLo,X
		PHA
		LDA	var_ch_TimerPeriodHi,X
		PHA
		LDA	var_ch_EffParam,X
		AND	#$F
		STA	var_Temp
		LDA	var_ch_Effect,X
		CMP	#5
		BEQ	@loc_88FF
		LDA	var_ch_Note,X
		SEC
		SBC	var_Temp
		BPL	@loc_88F8
		LDA	#1

@loc_88F8:
		BNE	@Done
		LDA	#1
		BNE	@Done	; JMP
; ---------------------------------------------------------------------------

@loc_88FF:
		LDA	var_ch_Note,X
		CLC
		ADC	var_Temp
		CMP	#96
		BCC	@Done
		LDA	#96

@Done:
;		STA	var_ch_Note,X
		JSR	ft_translate_freq_only
		LDA	var_ch_TimerPeriodLo,X
		STA	var_ch_PortaToLo,X
		LDA	var_ch_TimerPeriodHi,X
		STA	var_ch_PortaToHi,X
		LDA	var_ch_EffParam,X
		LSR	A
		LSR	A
		LSR	A
		ORA	#1
		STA	var_ch_EffParam,X
		PLA
		STA	var_ch_TimerPeriodHi,X
		PLA
		STA	var_ch_TimerPeriodLo,X
		CLC
		LDA	var_ch_Effect,X
		ADC	#1
		STA	var_ch_Effect,X
		CPX	#3
		BNE	@loc_894E
		CMP	#6
		BEQ	@loc_8949
		LDA	#6
		BNE	@loc_894B
;		STA	var_ch_Effect,X
;		JMP	ft_jump_to_effect
; ---------------------------------------------------------------------------

@loc_8949:
		LDA	#8
@loc_894B:
		STA	var_ch_Effect,X

@loc_894E:
		JMP	ft_jump_to_effect
; End of function ft_run_effects

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ft_run_effects

ft_portamento:
		LDA	var_ch_EffParam,X
		BEQ	@NoPortamento
		LDA	var_ch_PortaToLo,X
		ORA	var_ch_PortaToHi,X
		BEQ	@NoPortamento
		LDA	var_ch_TimerPeriodHi,X
		CMP	var_ch_PortaToHi,X
		BCC	@Increase
		BNE	@Decrease
		LDA	var_ch_TimerPeriodLo,X
		CMP	var_ch_PortaToLo,X
		BCC	@Increase
		BNE	@Decrease
		RTS
; ---------------------------------------------------------------------------

@Decrease:
		JSR	ft_period_remove
		CMP	var_ch_PortaToHi,X
		BCC	@LoadPeriod
		BMI	@LoadPeriod
		BNE	@NoPortamento
		LDA	var_ch_TimerPeriodLo,X
		CMP	var_ch_PortaToLo,X
		BCC	@LoadPeriod
		RTS
; ---------------------------------------------------------------------------

@Increase:
		JSR	ft_period_add
		LDA	var_ch_PortaToHi,X
		CMP	var_ch_TimerPeriodHi,X
		BCC	@LoadPeriod
		BNE	@NoPortamento
		LDA	var_ch_PortaToLo,X
		CMP	var_ch_TimerPeriodLo,X
		BCC	@LoadPeriod
@NoPortamento:		
		RTS
; ---------------------------------------------------------------------------

@LoadPeriod:
		LDA	var_ch_PortaToLo,X
		STA	var_ch_TimerPeriodLo,X
		LDA	var_ch_PortaToHi,X
		STA	var_ch_TimerPeriodHi,X
locret_8A50:
		RTS


; =============== S U B	R O U T	I N E =======================================


ft_period_add:
		CLC
		LDA	var_ch_TimerPeriodLo,X
		ADC	var_ch_EffParam,X
		STA	var_ch_TimerPeriodLo,X
		BCC	locret_8A50
		INC	var_ch_TimerPeriodHi,X
		BNE	locret_8A50
		LDA	#$FF
		JMP	write_period
; End of function ft_period_add


; =============== S U B	R O U T	I N E =======================================


ft_period_remove:
		SEC
		LDA	var_ch_TimerPeriodLo,X
		SBC	var_ch_EffParam,X
		STA	var_ch_TimerPeriodLo,X
		LDA	var_ch_TimerPeriodHi,X
		SBC	#0
		STA	var_ch_TimerPeriodHi,X
		BCS	locret_8A50
		JMP	write_period_0
; End of function ft_period_remove

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ft_run_effects

ft_slide_up:
		SEC
		LDA	var_ch_TimerPeriodLo,X
		SBC	var_ch_EffParam,X
		STA	var_ch_TimerPeriodLo,X
		LDA	var_ch_TimerPeriodHi,X
		SBC	#0
		STA	var_ch_TimerPeriodHi,X
		BMI	ft_slide_done
		CMP	var_ch_PortaToHi,X
		BCC	ft_slide_done
		BNE	ft_slide_not_done
		LDA	var_ch_TimerPeriodLo,X
		CMP	var_ch_PortaToLo,X
		BCC	ft_slide_done
		RTS
; ---------------------------------------------------------------------------

ft_slide_down:
		CLC
		LDA	var_ch_TimerPeriodLo,X
		ADC	var_ch_EffParam,X
		STA	var_ch_TimerPeriodLo,X
		LDA	var_ch_TimerPeriodHi,X
		ADC	#0
		STA	var_ch_TimerPeriodHi,X
		CMP	var_ch_PortaToHi,X
		BCC	ft_slide_not_done
		BNE	ft_slide_done
		LDA	var_ch_TimerPeriodLo,X
		CMP	var_ch_PortaToLo,X
		;BCS	ft_slide_done
		BCC	ft_slide_not_done
; ---------------------------------------------------------------------------

ft_slide_done:
		LDA	var_ch_PortaToLo,X
		STA	var_ch_TimerPeriodLo,X
		LDA	var_ch_PortaToHi,X
		STA	var_ch_TimerPeriodHi,X
clear_effect_porta:
		LDA	#0
		STA	var_ch_Effect,X
		STA	var_ch_PortaToLo,X
		STA	var_ch_PortaToHi,X

ft_slide_not_done:
		RTS
		
		
; =============== S U B	R O U T	I N E =======================================


ft_calc_period:
		LDA	var_ch_TimerPeriodLo,X
		STA	var_ch_PeriodCalcLo,X
		LDA	var_ch_TimerPeriodHi,X
		STA	var_ch_PeriodCalcHi,X
		LDA	var_ch_FinePitch,X
		CMP	#$80
		BEQ	@Skip
		LDA	var_ch_Note,X
		BEQ	@Skip
		CLC
		LDA	var_ch_PeriodCalcLo,X
		ADC	#$80
		STA	var_ch_PeriodCalcLo,X
		BCC	@no_inc_h
		INC	var_ch_PeriodCalcHi,X
@no_inc_h
		SEC
		LDA	var_ch_PeriodCalcLo,X
		SBC	var_ch_FinePitch,X
		STA	var_ch_PeriodCalcLo,X
		BCS	@no_dec_h
		DEC	var_ch_PeriodCalcHi,X
@no_dec_h

@Skip:
;		JMP	ft_vibrato


; =============== S U B	R O U T	I N E =======================================


ft_vibrato:
		LDA	var_ch_VibratoSpeed,X
		BEQ	ft_slide_not_done
;		BNE	loc_8B21
;		RTS
; ---------------------------------------------------------------------------

;loc_8B21:
		CLC
		ADC	var_ch_VibratoPos,X
		AND	#$3F
		STA	var_ch_VibratoPos,X
		CMP	#$10
		BCC	@Phase1
		CMP	#$20
		BCC	@Phase2
		CMP	#$30
		BCC	@Phase3
		;SEC
		SBC	#$30
		STA	var_Temp
		SEC
		LDA	#$F
		SBC	var_Temp
		JMP	@Negate
; ---------------------------------------------------------------------------

@Phase1:
		ORA	var_ch_VibratoDepth,X
		TAY
		LDA	ft_vibrato_table,Y
		STA	var_Temp16
		LDA	#0
		STA	var_Temp16+1
		BEQ	@Calculate	; JMP
; ---------------------------------------------------------------------------

@Phase2:
		;SEC
		SBC	#$10-1
		STA	var_Temp
		SEC
		LDA	#$F
		SBC	var_Temp
		JMP	@Phase1
; ---------------------------------------------------------------------------

@Phase3:
		;SEC
		SBC	#$20-1

@Negate:
		ORA	var_ch_VibratoDepth,X
		TAY
		LDA	ft_vibrato_table,Y
		EOR	#$FF
		STA	var_Temp16
		LDA	#$FF
		STA	var_Temp16+1
		INC	var_Temp16
		BNE	@Calculate
		INC	var_Temp16+1

@Calculate:
		SEC
		LDA	var_ch_PeriodCalcLo,X
		SBC	var_Temp16
		STA	var_ch_PeriodCalcLo,X
		LDA	var_ch_PeriodCalcHi,X
		SBC	var_Temp16+1
		STA	var_ch_PeriodCalcHi,X
		RTS


; =============== S U B	R O U T	I N E =======================================


ft_update_apu:
		LDA	var_Channels
		AND	#$20
		BNE	@Play
;		;LDA	#0	; clear all sound regs on music end
		STA	SND_MASTERCTRL_REG ; pAPU Sound/Vertical Clock Signal Register (R)
		
		LDX	#$F
@clear_all_regs:
		STA	SND_SQUARE1_REG,X
		DEX
		BPL	@clear_all_regs
		LDA	#$F
		STA	SND_MASTERCTRL_REG
		RTS
; ---------------------------------------------------------------------------

@Play:
		LDA	var_Channels
		AND	#1
		BNE	@pro_square1
		JMP	@Square2
; ---------------------------------------------------------------------------

@KillSquare1:
		LDA	#$30
		STA	SND_SQUARE1_REG	; pAPU Pulse #1	Control	Register (W)
		JMP	@Square2
; ---------------------------------------------------------------------------

@pro_square1:
		LDA	var_ch_Note
		BEQ	@KillSquare1
		LDA	var_ch_VolColumn
		ASL	A
		BEQ	@KillSquare1
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		BNE	@loc_90CB
		LDA	var_ch_VolColumn
		BEQ	@loc_90CB
		LDA	#1

@loc_90CB:
		PHA
		LDA	var_ch_DutyCycle
		AND	#3
		TAX
		PLA
		ORA	ft_duty_table,X
		;ORA	#$30
		STA	SND_SQUARE1_REG	; pAPU Pulse #1	Control	Register (W)
		LDA	var_ch_PeriodCalcHi
		AND	#$F8
		BEQ	@TimerOverflow1
		LDA	#7
		STA	var_ch_PeriodCalcHi
		LDA	#$FF
		STA	var_ch_PeriodCalcLo

@TimerOverflow1:

		LDA	var_ch_PrevFreqHigh
		BPL	@loc_910D
		LDA	var_ch_PeriodCalcLo
		STA	pAPU_Pulse1__FT__Reg ; pAPU Pulse #1 Fine Tune (FT) Register (W)
		STA	var_ch_PrevFreqLow
		LDA	var_ch_PeriodCalcHi
		STA	pAPU_Pulse1__CT__Reg ; pAPU Pulse #1 Coarse Tune (CT) Register (W)
		STA	var_ch_PrevFreqHigh

@loc_910D:
		LDA	var_ch_PeriodCalcLo
		CMP	var_ch_PrevFreqLow
		BEQ	@loc_911B
		STA	pAPU_Pulse1__FT__Reg ; pAPU Pulse #1 Fine Tune (FT) Register (W)
		STA	var_ch_PrevFreqLow

@loc_911B:
		LDA	var_ch_PeriodCalcHi
		CMP	var_ch_PrevFreqHigh
		BEQ	@loc_9129
		STA	pAPU_Pulse1__CT__Reg ; pAPU Pulse #1 Coarse Tune (CT) Register (W)
		STA	var_ch_PrevFreqHigh

@loc_9129:
		LDA	#8
		STA	pAPU_Pulse1_Ramp_Control_Reg ; pAPU Pulse #1 Ramp Control Register (W)
		BNE	@Square2	; JMP
; ---------------------------------------------------------------------------

@KillSquare2:
		LDA	#$30
		STA	SND_SQUARE2_REG	; pAPU Pulse #2	Control	Register (W)
		JMP	@Triangle
; ---------------------------------------------------------------------------

@Square2:
		LDA	var_Channels
		AND	#2
		BNE	@pro_square2
		JMP	@Triangle
; ---------------------------------------------------------------------------

@pro_square2:
		LDA	var_ch_Note+1
		BEQ	@KillSquare2
		LDA	var_ch_VolColumn+1
		ASL	A
		BEQ	@KillSquare2
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		BNE	@loc_9188
		LDA	var_ch_VolColumn+1
		BEQ	@loc_9188
		LDA	#1

@loc_9188:
		PHA
		LDA	var_ch_DutyCycle+1
		AND	#3
		TAX
		PLA
		ORA	ft_duty_table,X
		;ORA	#$30
		STA	SND_SQUARE2_REG	; pAPU Pulse #2	Control	Register (W)
		LDA	var_ch_PeriodCalcHi+1
		AND	#$F8
		BEQ	@TimerOverflow2
		LDA	#7
		STA	var_ch_PeriodCalcHi+1
		LDA	#$FF
		STA	var_ch_PeriodCalcLo+1

@TimerOverflow2:

		LDA	var_ch_PrevFreqHigh+1
		BPL	@fix
		LDA	var_ch_PeriodCalcLo+1
		STA	pAPU_Pulse2__FT__Reg ; pAPU Pulse #2 Fine Tune Register	(W)
		STA	var_ch_PrevFreqLow+1
		LDA	var_ch_PeriodCalcHi+1
		STA	pAPU_Pulse2__CT__Reg ; pAPU Pulse #2 Coarse Tune Register (W)
		STA	var_ch_PrevFreqHigh+1

@fix:
		LDA	var_ch_PeriodCalcLo+1
		CMP	var_ch_PrevFreqLow+1
		BEQ	@loc_91D8
		STA	pAPU_Pulse2__FT__Reg ; pAPU Pulse #2 Fine Tune Register	(W)
		STA	var_ch_PrevFreqLow+1

@loc_91D8:
		LDA	var_ch_PeriodCalcHi+1
		CMP	var_ch_PrevFreqHigh+1
		BEQ	@loc_91E6
		STA	pAPU_Pulse2__CT__Reg ; pAPU Pulse #2 Coarse Tune Register (W)
		STA	var_ch_PrevFreqHigh+1

@loc_91E6:
		LDA	#8
		STA	pAPU_Pulse2_Ramp_Control_Reg ; pAPU Pulse #2 Ramp Control Register (W)

@Triangle:
		LDA	var_Channels
		AND	#4
		BEQ	@Noise
		LDA	var_ch_VolColumn+2
		BEQ	@KillTriangle
		LDA	var_ch_Note+2
		BEQ	@KillTriangle
		LDA	#$81
		STA	SND_TRIANGLE_REG ; pAPU	Triangle Control Register #1 (W)
		LDA	var_ch_PeriodCalcHi+2
		AND	#$F8
		BEQ	@TimerOverflow3
		LDA	#7
		STA	var_ch_PeriodCalcHi+2
		LDA	#$FF
		STA	var_ch_PeriodCalcLo+2

@TimerOverflow3:
		LDA	var_ch_PeriodCalcLo+2
		STA	pAPU_Triangle_Frequency_Reg1 ; pAPU Triangle Frequency Register	#1 (W)
		LDA	var_ch_PeriodCalcHi+2
		STA	pAPU_Triangle_Frequency_Reg2 ; pAPU Triangle Frequency Register	#2 (W)
		JMP	@Noise
; ---------------------------------------------------------------------------

@KillTriangle:
		LDA	#0
		STA	SND_TRIANGLE_REG ; pAPU	Triangle Control Register #1 (W)
		STA	SND_TRIANGLE_REG+2 ; fix for triangle SFX

@Noise:
		LDA	var_Channels
		AND	#8
		BEQ	@DPCM
		LDA	var_ch_Note+3
		BEQ	@KillNoise
		LDA	var_ch_VolColumn+3
		ASL	A
		BEQ	@KillNoise
		AND	#$F0
		LSR
		LSR
		LSR
		LSR
		BNE	@loc_9274
		LDA	var_ch_VolColumn+3
		BEQ	@loc_9274
		LDA	#1

@loc_9274:
		ORA	#$30
		STA	SND_NOISE_REG	; pAPU Noise Control Register #1 (W)
;		LDA	#0
;		STA	Unused		; Unused (???)
		LDA	var_ch_DutyCycle+3
		ROR	A
		ROR	A
		AND	#$80
		STA	var_Temp
		LDA	var_ch_PeriodCalcLo+3
		AND	#$F
		EOR	#$F
		ORA	var_Temp
		STA	pAPU_Noise_Frequency_Reg1 ; pAPU Noise Frequency Register #1 (W)
		LDA	#0
		STA	pAPU_Noise_Frequency_Reg2 ; pAPU Noise Frequency Register #2 (W)
		RTS

@KillNoise:
		LDA	#$30
		STA	SND_NOISE_REG	; pAPU Noise Control Register #1 (W)

@DPCM:
		RTS
; ---------------------------------------------------------------------------
ft_duty_table:	.BYTE $30, $70, $B0, $F0


; =============== S U B	R O U T	I N E =======================================


set_music_bank:
		LDA	var_InitialBank

set_bank:
		IF	(VRC7=0)
		LDY	#$87
		STY	MMC3_bank_select
		STA	MMC3_bank_data
		
		ELSE
		STA	VRC7_prg_A000
		ENDIF
		
		RTS
; End of function set_bank


; ---------------------------------------------------------------------------

ft_periods_ntsc:
	.word	$0D5B, $0C9C, $0BE6, $0B3B, $0A9A, $0A01, $0972, $08EA, $086A, $07F1, $077F, $0713
	.word	$06AD, $064D, $05F3, $059D, $054C, $0500, $04B8, $0474, $0434, $03F8, $03BF, $0389
	.word	$0356, $0326, $02F9, $02CE, $02A6, $0280, $025C, $023A, $021A, $01FB, $01DF, $01C4
	.word	$01AB, $0193, $017C, $0167, $0152, $013F, $012D, $011C, $010C, $00FD, $00EF, $00E1
	.word	$00D5, $00C9, $00BD, $00B3, $00A9, $009F, $0096, $008E, $0086, $007E, $0077, $0070
	.word	$006A, $0064, $005E, $0059, $0054, $004F, $004B, $0046, $0042, $003F, $003B, $0038
	.word	$0034, $0031, $002F, $002C, $0029, $0027, $0025, $0023, $0021, $001F, $001D, $001B
	.word	$001A, $0018, $0017, $0015, $0014, $0013, $0012, $0011, $0010, $000F, $000E, $000D

ft_periods_pal:
	.word	$0C68, $0BB6, $0B0E, $0A6F, $09D9, $094B, $08C6, $0848, $07D1, $0760, $06F6, $0692
	.word	$0634, $05DB, $0586, $0537, $04EC, $04A5, $0462, $0423, $03E8, $03B0, $037B, $0349
	.word	$0319, $02ED, $02C3, $029B, $0275, $0252, $0231, $0211, $01F3, $01D7, $01BD, $01A4
	.word	$018C, $0176, $0161, $014D, $013A, $0129, $0118, $0108, $00F9, $00EB, $00DE, $00D1
	.word	$00C6, $00BA, $00B0, $00A6, $009D, $0094, $008B, $0084, $007C, $0075, $006E, $0068
	.word	$0062, $005D, $0057, $0052, $004E, $0049, $0045, $0041, $003E, $003A, $0037, $0034
	.word	$0031, $002E, $002B, $0029, $0026, $0024, $0022, $0020, $001E, $001D, $001B, $0019
	.word	$0018, $0016, $0015, $0014, $0013, $0012, $0011, $0010, $000F, $000E, $000D, $000C
		

		; table from driver.s (v2.11) - ftm v4.
;ft_vibrato_table:
;	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;	.byte $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
;	.byte $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02
;	.byte $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03
;	.byte $00, $00, $00, $01, $01, $02, $02, $03, $03, $03, $04, $04, $04, $04, $04, $04
;	.byte $00, $00, $01, $02, $02, $03, $03, $04, $04, $05, $05, $06, $06, $06, $06, $06
;	.byte $00, $00, $01, $02, $03, $04, $05, $06, $07, $07, $08, $08, $09, $09, $09, $09
;	.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $09, $0A, $0B, $0B, $0B, $0B
;	.byte $00, $01, $02, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0C, $0D, $0D, $0D
;	.byte $00, $01, $03, $04, $06, $08, $09, $0A, $0C, $0D, $0E, $0E, $0F, $10, $10, $10
;	.byte $00, $02, $04, $06, $08, $0A, $0C, $0D, $0F, $11, $12, $13, $14, $15, $15, $15
;	.byte $00, $02, $05, $08, $0B, $0E, $10, $13, $15, $17, $18, $1A, $1B, $1C, $1D, $1D
;	.byte $00, $04, $08, $0C, $10, $14, $18, $1B, $1F, $22, $24, $26, $28, $2A, $2B, $2B
;	.byte $00, $06, $0C, $12, $18, $1E, $23, $28, $2D, $31, $35, $38, $3B, $3D, $3E, $3F
;	.byte $00, $09, $12, $1B, $24, $2D, $35, $3C, $43, $4A, $4F, $54, $58, $5B, $5E, $5F
;	.byte $00, $0C, $18, $25, $30, $3C, $47, $51, $5A, $62, $6A, $70, $76, $7A, $7D, $7F

		; table from ftm v5 disasm.
ft_vibrato_table:
	.BYTE	0,  0,	0,  0,	0,  0,	0,  0,	0,  0,	0,  0,	0,  0,	0,  0
	.BYTE	0,  0,	0,  0,	0,  0,	0,  0,	1,  1,	1,  1,	1,  1,	1,  1
	.BYTE	0,  0,	0,  0,	0,  1,	1,  1,	1,  1,	2,  2,	2,  2,	2,  2
	.BYTE	0,  0,	0,  1,	1,  1,	2,  2,	2,  3,	3,  3,	3,  3,	3,  3
	.BYTE	0,  0,	0,  1,	1,  2,	2,  3,	3,  3,	4,  4,	4,  4,	4,  4
	.BYTE	0,  0,	1,  2,	2,  3,	3,  4,	4,  5,	5,  6,	6,  6,	6,  6
	.BYTE	0,  0,	1,  2,	3,  4,	5,  6,	7,  7,	8,  8,	9,  9,	9,  9
	.BYTE	0,  1,	2,  3,	4,  5,	6,  7,	8,  9,	9, $A, $B, $B, $B, $B
	.BYTE	0,  1,	2,  4,	5,  6,	7,  8,	9, $A, $B, $C, $C, $D, $D, $D
	.BYTE	0,  1,	3,  4,	6,  8,	9, $A, $C, $D, $E, $E, $F,$10,$10,$10
	.BYTE	0,  2,	4,  6,	8, $A, $C, $D, $F,$11,$12,$13,$14,$15,$15,$15
	.BYTE	0,  2,	5,  8, $B, $E,$10,$13,$15,$17,$18,$1A,$1B,$1C,$1D,$1D
	.BYTE	0,  4,	8, $C,$10,$14,$18,$1B,$1F,$22,$24,$26,$28,$2A,$2B,$2B
	.BYTE	0,  6, $C,$12,$18,$1E,$23,$28,$2D,$31,$35,$38,$3B,$3D,$3E,$3F
	.BYTE	0,  9,$12,$1B,$24,$2D,$35,$3C,$43,$4A,$4F,$54,$58,$5B,$5E,$5F
	.BYTE	0, $C,$18,$25,$30,$3C,$47,$51,$5A,$62,$6A,$70,$76,$7A,$7D,$7F
