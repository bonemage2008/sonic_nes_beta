;sfx_to_play	equ	$82
;music_to_play	equ	$81
;current_music	equ	$83

;pulse_sound	equ	$700 ; old (replaced with var_ch_VolDelay)
;pulse_timer	equ	$701 ; old
;pulse_ptr	equ	$702 ; old
;pulse_regs	equ	$703 ; old

;triangle_ptr	equ	$704 ; unused
noise_sound	equ	$704
;noise_sfx_ptr	equ	$705 ;  ; in vars.asm

;pulse1_sound	equ	$780 ; in ftm_driver.asm
pulse1_timer	equ	$781
pulse1_ptr	equ	$782
pulse1_regs	equ	$783
;pulse2_sound	equ	$784 ; in ftm_driver.asm
pulse2_timer	equ	$785
pulse2_ptr	equ	$786
pulse2_regs	equ	$787

noise_timer	equ	$78C ; move (scroll_vals	equ	$78C)


; =============== S U B	R O U T	I N E =======================================


detectNTSC:
;		LDA	#$00
;		STA	PPU_CTRL_REG1
;		JSR	detectNTSC1
;		TAX
;		LDA	mode,X
;		STA	var_Channels
;		LDA	#$80
;		STA	PPU_CTRL_REG1
;		RTS
;mode:
;		.byte	$00 ; ntsc
;		.byte	$90 ; pal
;		.byte	$80 ; dendy
;
;detectNTSC1:	; 0 = ntsc; 1 = pal; 2 = dendy
;		bit PPU_STATUS
;@wait_vbl
;		bit PPU_STATUS
;		bpl @wait_vbl
;		ldx #0
;		ldy #24
;		jsr wait1284y
;		bpl not_ntsc
;		tya
;		rts
;not_ntsc:
;		lda #1
;		ldy #3
;		jsr wait1284y
;		bmi not_dendy
;		asl a
;not_dendy:
;		rts
;
;wait1284y
;		dex
;		bne wait1284y
;		dey
;		bne wait1284y
;		bit PPU_STATUS
NO_SOUND
		rts
		
		
;		LDA	PPU_STATUS
;wait_vblank:		
;		LDA	PPU_STATUS
;		BPL	wait_vblank
;		
;		LDX	#52
;		LDY	#24
;@loop:
;
;		DEX
;		BNE 	@loop
;		DEY
;		BNE 	@loop
;
;		LDA	PPU_STATUS
;		STA	var_Channels	;$00 PAL, $80 NTSC
;		LDA	#$80
;		STA	PPU_CTRL_REG1
;		RTS

is_singpost_sfx:
		LDY	#$A0
		BNE	s_singpost_sfx
is_big_ring_sfx:
		LDY	#$80+37
		STY	pulse1_sound
		INY
s_singpost_sfx:
		STY	pulse2_sound
		JMP	j_start_noise_sound


; =============== S U B	R O U T	I N E =======================================


songs_to_play:
		LDA	#$24
		JSR	set_bank
		
		IF	(VRC7=0)
		LDA	epsm_flag
		BPL	@no_chk
		
		LDA	famistudio_song_speed
		BPL	@no_start_music
		ENDIF
@no_chk
		LDA	music_to_play
		CMP	current_music
		BEQ	@no_start_music
		LDA	music_to_play
		STA	current_music
		BNE	@start_song
		
@no_start_music:
		LDA	sfx_to_play
		BEQ	SOUND_ENGINE
		BMI	SOUND_ENGINE

@start_song:
		TAX
		LDA	songs_tbl,X
		BMI	is_sound
		;LDY	#$80
		;STY	famistudio_song_speed
		JMP	ft_music_init	; FTM START SONG

; End of function songs_to_play

; =============== S U B	R O U T	I N E =======================================


is_sound:
		LDY	#0
		STY	sfx_to_play
		CMP	#$FF
		BEQ	NO_SOUND
		CMP	#$94
		BCC	not_noise_sound
		
;		BCS	is_noise_sfx
;		CMP	#$88
;		BNE	not_noise_sound
;is_noise_sfx		
		AND	#$7F
		CMP	#36
		BEQ	is_big_ring_sfx
		CMP	#$1F
		BEQ	is_singpost_sfx
		
j_start_noise_sound:
		STA	noise_sound
		JSR	start_noise_sound
		JMP	check_pulse
; ---------------------------------------------------------------------------
not_noise_sound:
		;CMP	#$80
		;BNE	std_pulse_sound
		;JSR	start_triangle_sound
		;JMP	check_pulse
; ---------------------------------------------------------------------------
std_pulse_sound:
		LDY	current_music
		CPY	#$2D	; chaos emerald
		BEQ	SOUND_ENGINE
		
		cmp	#$81
		bne	not_ring_sfx
		LDY	pulse2_sound
		CPY	#4	; BADNIK
		BEQ	SOUND_ENGINE
		CPY	#$F	; SPRING
		BEQ	SOUND_ENGINE
		
not_ring_sfx:
		CMP	#$87
		BNE	@no_same_sfx
		LDY	pulse2_sound
		CPY	#7
		;BNE	@no_same_sfx
		;LDA	$1D	; sonic spr
		;CMP	#$20
		BEQ	SOUND_ENGINE
		;LDY	pulse2_ptr
		;CPY	#$44
		;BCC	SOUND_ENGINE
@no_same_sfx		
		STA	pulse2_sound
		;CMP	#$83
		;BNE	not_ring_drop_sfx
		;LDA	#$8C
		;STA	pulse1_sound
		;BNE	SOUND_ENGINE ; JMP
;not_ring_drop_sfx:
		CMP	#$8D
		BNE	@not_s3k_projectile_sfx
		LDA	#25 ; sound25
		BNE	j_start_noise_sound ; JMP
@not_s3k_projectile_sfx
		
		CMP	#$84
		BNE	not_badnik_sfx
		LDA	#26 ; sound26
		BNE	j_start_noise_sound ; JMP
not_badnik_sfx:
		CMP	#$87
		BNE	not_spindash
		LDA	noise_sound
		CMP	#23 ; electro sound23
		BEQ	SOUND_ENGINE
		LDA	#27 ; sound27
		BNE	j_start_noise_sound ; JMP
not_spindash
		CMP	#$93
		BNE	not_spikes_sfx
		LDA	#34 ; sound34
		BNE	j_start_noise_sound ; JMP
not_spikes_sfx
		CMP	#$86
		BNE	not_bubble_sfx
		LDA	#$88
		STA	pulse1_sound
not_bubble_sfx:
		
;		CMP	#$90	; bumper sfx
;		BNE	SOUND_ENGINE
;		LDA	current_music
;		CMP	#$25	; spring yard zone song
;		BNE	SOUND_ENGINE
;		LDA	#$9C	; sound28 bumper sfx sq1
;		STA	pulse1_sound
		
SOUND_ENGINE:
		LDY	noise_sfx_ptr
		BEQ	no_play_noise
		JSR	play_noise_sound
no_play_noise:	

;		LDY	triangle_ptr
;		BEQ	no_play_triangle
;		JSR	play_triangle_sound
;no_play_triangle:


check_pulse:
		LDX	#4	; PULSE2 (SQUARE2)
		JSR	check_pulse2
		LDX	#0	; PULSE1 (SQUARE1)

check_pulse2:
		LDY	pulse1_sound,X
		BEQ	no_snd
		BPL	cont_play_snd
		JMP	start_sound
cont_play_snd

		DEC	pulse1_timer,X
		BNE	no_snd
		LDA	pulse1_regs,X
		AND	#$F
		STA	pulse1_timer,X
	
		JSR	load_sound_ptr
		LDY	pulse1_ptr,X
		LDA	pulse1_regs,X
	
read_sound_sq:
		STA	var_Temp
	
;write_apu_regs:
		LDA	(var_Temp16),Y
		BEQ	end_play_sound_sq
		CMP	#$32
		BCS	cont_read_check_49
		CMP	#$30
		BEQ	cont_read_sound
		JSR	reload_timer_and_reg_list_sq
		JMP	read_sound_sq
cont_read_check_49:
		CMP	#$FF
		BNE	cont_read_sound
		LDA	#49
		
cont_read_sound:
		INY

; swap duty cycles 25% and 50%
		BIT	var_Channels ; 0x40 - enable swap flag
		BVC	@no_swap
		PHA
		AND	#$C0
		BEQ	@skip_swap
		CMP	#$C0
		BEQ	@skip_swap
		PLA
		EOR	#$C0	; swap 40 and 80
		BNE	@no_swap ; JMP
@skip_swap
		PLA
@no_swap
; end swap	
		STA	SND_SQUARE1_REG,X
		ASL	var_Temp
		BCC	no_write_4001
		LDA	(var_Temp16),Y
		INY	
		STA	pAPU_Pulse1_Ramp_Control_Reg,X
no_write_4001:	
		ASL	var_Temp
		BCC	no_write_4002
		LDA	(var_Temp16),Y
		INY	
		STA	pAPU_Pulse1__FT__Reg,X
no_write_4002:
		ASL	var_Temp
		BCC	no_write_4003
		LDA	(var_Temp16),Y
		INY	
		STA	pAPU_Pulse1__CT__Reg,X
no_write_4003:
		TYA
		STA	pulse1_ptr,X
no_snd	
		RTS
; ---------------------------------------------------------------------------
end_play_sound_sq:
		STA	pulse1_sound,X
		LDA	#$10	; turn off sound in pulse
		STA	SND_SQUARE1_REG,X
		LDA	sq_or_tbl,X
		ORA	var_Channels	; channels
		STA	var_Channels	; enable pulse ftm
		
		LDA	#$FF
		CPX	#0
		BEQ	@is_sq1
		STA	var_ch_PrevFreqHigh+1
		
		IF	(VRC7=0)
		BIT	epsm_flag
		BPL	@ret
		STA	famistudio_pulse2_prev	; FAMISTUDIO
		LSR	fms_channels+1	; FAMISTUDIO
		ASL	fms_channels+1	; FAMISTUDIO
		ENDIF
@ret		
		RTS
@is_sq1:
		STA	var_ch_PrevFreqHigh
		
		IF	(VRC7=0)
		BIT	epsm_flag
		BPL	@ret2
		STA	famistudio_pulse1_prev	; FAMISTUDIO
		LSR	fms_channels+0	; FAMISTUDIO
		ASL	fms_channels+0	; FAMISTUDIO
		ENDIF
@ret2		
		RTS
; ---------------------------------------------------------------------------
start_sound:
		IF	(VRC7=0)
		BIT	epsm_flag
		BPL	@skip
		LDA	#1		; FAMISTUDIO
		CPX	#0		; FAMISTUDIO
		BNE	@disable_sq2	; FAMISTUDIO
		ORA	fms_channels	; FAMISTUDIO
		STA	fms_channels	; FAMISTUDIO
		BNE	@disabled_sq1	; FAMISTUDIO
@disable_sq2				; FAMISTUDIO
		ORA	fms_channels+1	; FAMISTUDIO
		STA	fms_channels+1	; FAMISTUDIO
@disabled_sq1
@skip
		ENDIF

		LDA	sq_and_tbl,X
		AND	var_Channels	; \ disable pulse 1/2
		STA	var_Channels	; / fmt channels
		TYA			; sound id
		AND	#$7F
		STA	pulse1_sound,X	; write id
		TAY			; sound id

		JSR	load_sound_ptr
		JSR	reload_timer_and_reg_list_sq
		LDA	#$FF		; update all regs on sound start
		JMP	read_sound_sq
; ---------------------------------------------------------------------------
sq_and_tbl:
		.BYTE	%11111110 ; sq1
		.BYTE	%11111111
		.BYTE	%11111111
		.BYTE	%11111111
		.BYTE	%11111101 ; sq2
; ---------------------------------------------------------------------------
sq_or_tbl:
		.BYTE	%00000001 ; sq1
		.BYTE	%00000000
		.BYTE	%00000000
		.BYTE	%00000000
		.BYTE	%00000010 ; sq2
; ---------------------------------------------------------------------------
load_sound_ptr:	
		LDA	snd_ptrs_l,Y
		STA	var_Temp16
		LDA	snd_ptrs_h,Y
		STA	var_Temp16+1
		LDY	#$00
		LDA	(var_Temp16),Y
		RTS
; ---------------------------------------------------------------------------
reload_timer_and_reg_list_sq:
		PHA
		AND	#$F
		STA	pulse1_timer,X	; write timer
		PLA
		ASL
		AND	#$60
		ORA	pulse1_timer,X
		STA	pulse1_regs,X	; write regs list + timer saver
		INY
		RTS


; =============== S U B	R O U T	I N E =======================================


start_noise_sound:
		LDA	#0
		STA	noise_sfx_ptr
		STA	noise_timer
		
		IF	(VRC7=0)
		BIT	epsm_flag
		BPL	@skip
		LDA	fms_channels+3	; FAMISTUDIO
		ORA	#1		; FAMISTUDIO
		STA	fms_channels+3	; FAMISTUDIO
@skip
		ENDIF

		LDA	var_Channels	; \ disable noise
		AND	#$F7		; | in
		STA	var_Channels	; / fmt channels
		;LDA	#$F8
		LDA	#8
		STA	pAPU_Noise_Frequency_Reg2 ; $400f
	
play_noise_sound:
		DEC	noise_timer
		BPL	skip_play_noise
		LDY	noise_sound	; sfx num
		JSR	load_sound_ptr
		LDY	noise_sfx_ptr
		LDA	(var_Temp16),Y
		BEQ	end_play_noise
		CMP	#$10
		BCS	not_timer
		STA	noise_timer
		INY
		LDA	(var_Temp16),Y
not_timer:
		INY
		STA	SND_NOISE_REG
		LDA	(var_Temp16),Y
		INY		
		STA	pAPU_Noise_Frequency_Reg1
		STY	noise_sfx_ptr
skip_play_noise:
		RTS
; ---------------------------------------------------------------------------
end_play_noise:
		;STA	noise_timer
		STA	noise_sound
		STA	noise_sfx_ptr
		LDA	var_Channels	; \ enable noise
		ORA	#8		; | in
		STA	var_Channels	; / fmt channels
		LDA	#$10		; turn off sound in noise
		STA	SND_NOISE_REG
		
		IF	(VRC7=0)
		BIT	epsm_flag
		BPL	@ret
		LSR	fms_channels+3	; FAMISTUDIO
		ASL	fms_channels+3	; FAMISTUDIO
		ENDIF
@ret
		RTS


; =============== S U B	R O U T	I N E =======================================


;start_triangle_sound:
;		LDA	var_Channels	; \ disable triangle
;		AND	#$FB		; | in
;		STA	var_Channels	; / fmt channels
;		LDA	#8
;		STA	pAPU_Triangle_Frequency_Reg2
;		
;play_triangle_sound:
;		LDY	#0	; id
;		JSR	load_sound_ptr
;		LDY	triangle_ptr
;		LDA	(var_Temp16),Y
;		BEQ	end_play_triangle
;		INY
;		STA	SND_TRIANGLE_REG
;		LDA	(var_Temp16),Y
;		INY		
;		STA	pAPU_Triangle_Frequency_Reg1
;		STY	triangle_ptr
;		RTS
; ---------------------------------------------------------------------------
;end_play_triangle:
;		STA	triangle_ptr
;		LDA	var_Channels	; \ enable triangle
;		ORA	#4		; | in
;		STA	var_Channels	; / fmt channels
;		LDA	#$10		; turn off sound in triangle
;		STA	SND_TRIANGLE_REG
;		RTS
; ---------------------------------------------------------------------------
snd_ptrs_l:	
	.dl	sound0,sound1,sound2,sound3,sound4
	.dl	sound5,sound6,sound7,sound8,sound9
	.dl	sound10,sound0,sound12,sound13,sound14
	.dl	sound15,sound16,sound17,sound18,sound19
	.dl	sound20,sound21,sound22,sound23,sound24
	.dl	sound25,sound26,sound27,sound28,sound29
	.dl	sound30,sound31,sound32,sound33,sound34
	.dl	sound35,sound36,sound37,sound38
	
snd_ptrs_h:
	.dh	sound0,sound1,sound2,sound3,sound4
	.dh	sound5,sound6,sound7,sound8,sound9
	.dh	sound10,sound0,sound12,sound13,sound14
	.dh	sound15,sound16,sound17,sound18,sound19
	.dh	sound20,sound21,sound22,sound23,sound24
	.dh	sound25,sound26,sound27,sound28,sound29
	.dh	sound30,sound31,sound32,sound33,sound34
	.dh	sound35,sound36,sound37,sound38
; ---------------------------------------------------------------------------

onereg	= %00100001  ; 4003
tworegs	= %00110001  ; 4003 and 4004

sound0:			; Skid
	dc.b	onereg
	dc.b	180,8,134,8
	dc.b	180,119
	dc.b	0
	
sound1:			; Ring
	dc.b	3
	dc.b	181,8,84,8
	dc.b	1
	dc.b	180
	dc.b	onereg
	dc.b	181,70
	dc.b	2
	dc.b	181
	dc.b	1
	dc.b	180
	dc.b	onereg
	dc.b	181,52
	dc.b	2
	dc.b	181
	dc.b	2
	dc.b	180
	dc.b	1
	dc.b	178
	dc.b	4
	dc.b	179
	dc.b	2
	dc.b	178
	dc.b	0
	
sound2:			; Jump
	dc.b	3
	dc.b	179,8,63,9
	dc.b	tworegs
	dc.b	180,239,8
	dc.b	2
	dc.b	180
	dc.b	onereg
	dc.b	180,231
	dc.b	180,223
	dc.b	180,215
	dc.b	180,207
	dc.b	180,199
	dc.b	180,191
	dc.b	180,183
	dc.b	180,175
	dc.b	180,167
	dc.b	180,159
	dc.b	180,151
	dc.b	180,143
	dc.b	179,135
	dc.b	179,127
	dc.b	179,119
	dc.b	179,111
	dc.b	179,103
	dc.b	179,95
	dc.b	0
	
sound3:			; Ring lost (Pulse2)
	dc.b	1
	dc.b	183,8,63,8
	dc.b	180
	dc.b	183
	dc.b	180
	dc.b	onereg
	dc.b	183,70
	dc.b	2
	dc.b	180
	dc.b	onereg
	dc.b	183,63
	dc.b	180,63
	dc.b	183,70
	dc.b	180,70
	dc.b	180,70
	dc.b	183,63
	dc.b	2
	dc.b	180
	dc.b	2
	dc.b	179
	dc.b	1
	dc.b	183
	dc.b	2
	dc.b	180
	dc.b	2
	dc.b	179
	dc.b	1
	dc.b	183
	dc.b	2
	dc.b	180
	dc.b	2
	dc.b	179
	dc.b	1
	dc.b	183
	dc.b	2
	dc.b	180
	dc.b	onereg
	dc.b	183,70
	dc.b	180,70
	dc.b	183,63
	dc.b	1
	dc.b	181
	dc.b	180
	dc.b	onereg
	dc.b	183,70
	dc.b	181,70
	dc.b	5
	dc.b	180
	dc.b	2
	dc.b	181
	dc.b	1
	dc.b	180
	dc.b	5
	dc.b	179
	dc.b	2
	dc.b	180
	dc.b	onereg
	dc.b	179,69
	dc.b	178,70
	dc.b	178,70
	dc.b	178,71
	dc.b	178,70
	dc.b	178,69
	dc.b	179,69
	dc.b	179,70
	dc.b	178,71
	dc.b	177,70
	dc.b	4
	dc.b	177
	dc.b	0
	
sound12:		; Blue Sphere (PULSE)
	dc.b	1
	dc.b	178,8,142,8
	dc.b	onereg
	dc.b	181,134
	dc.b	180,126
	dc.b	179,119
	dc.b	178,112
	dc.b	177,106
	dc.b	178,189
	dc.b	181,213
	dc.b	181,225
	dc.b	180,239
	dc.b	tworegs
	dc.b	179,12,9
	dc.b	onereg
	dc.b	178,28
	dc.b	177,63
	dc.b	177,103
	dc.b	0
	
sound4:			; Badnik/Monitor Destroyed (PULSE)
	dc.b	1
	dc.b	48,8,0,0
	dc.b	tworegs
	dc.b	179,253,8
	dc.b	onereg
	dc.b	179,253
	dc.b	onereg
	dc.b	180,234
	dc.b	180,215
	dc.b	180,196
	dc.b	180,177
	dc.b	180,169
	dc.b	180,169
	dc.b	180,167
	dc.b	180,200
	dc.b	180,231
	dc.b	tworegs
	dc.b	180,6,9
	dc.b	onereg
	dc.b	180,37
	dc.b	180,68
	dc.b	180,82
	dc.b	179,113
	dc.b	179,144
	dc.b	179,175
	dc.b	179,206
	dc.b	178,237
	dc.b	tworegs
	dc.b	178,12,10
	dc.b	0
	
sound26:		; Badnik/Monitor Destroyed (NOISE)
	dc.b	56,11
	dc.b	1
	dc.b	55,13
	dc.b	1
	dc.b	54,13
	dc.b	3
	dc.b	53,13
	dc.b	5
	dc.b	52,13
	dc.b	6
	dc.b	50,12
	dc.b	6
	dc.b	49,12
	dc.b	0
	
sound5:			; Death
	dc.b	onereg
	dc.b	124,8,74,14
	dc.b	124,73
	dc.b	123,74
	dc.b	123,77
	dc.b	58,80
	dc.b	58,81
	dc.b	57,80
	dc.b	57,77
	dc.b	tworegs
	dc.b	122,124,15
	dc.b	onereg
	dc.b	121,255
	dc.b	2
	dc.b	121
	dc.b	3
	dc.b	120
	dc.b	3
	dc.b	119
	dc.b	6
	dc.b	118
	dc.b	6
	dc.b	117
	dc.b	6
	dc.b	116
	dc.b	6
	dc.b	115
	dc.b	5
	dc.b	114
	dc.b	5
	dc.b	113
	dc.b	0
	
sound6:			; Air Bubble
	;dc.b	onereg
	;dc.b	118,8,103,9
	;dc.b	119,82
	;dc.b	120,63
	;dc.b	121,45
	;dc.b	122,28
	;dc.b	186,12
	;dc.b	180,12
	;dc.b	6
	;dc.b	48
	;dc.b	tworegs
	;dc.b	54,239,8
	;dc.b	onereg
	;dc.b	55,225
	;dc.b	56,213
	;dc.b	57,201
	;dc.b	58,189
	;dc.b	58,179
	;dc.b	58,169
	;dc.b	52,169
	;dc.b	$00
	
			; Air Bubble SQ2
	dc.b	onereg
	dc.b	177,8,179,8
	dc.b	178,171
	dc.b	179,163
	dc.b	180,155
	dc.b	180,150
	dc.b	180,150
	dc.b	6
	dc.b	48
	dc.b	onereg
	dc.b	177,140
	dc.b	178,132
	dc.b	179,124
	dc.b	180,116
	dc.b	180,108
	dc.b	180,100
	dc.b	180,92
	dc.b	180,87
	dc.b	0
	
sound8:			; Air Bubble SQ1
	dc.b	onereg
	dc.b	114,8,103,9
	dc.b	116,87
	dc.b	120,71
	dc.b	122,55
	dc.b	122,45
	dc.b	122,45
	dc.b	6
	dc.b	48
	dc.b	onereg
	dc.b	114,25
	dc.b	116,9
	dc.b	tworegs
	dc.b	120,249,8
	dc.b	onereg
	dc.b	122,233
	dc.b	122,217
	dc.b	122,201
	dc.b	122,185
	dc.b	122,175
	dc.b	0
	
sound7:			; Spindash/Roll (PULSE)
;	dc.b	onereg
;	dc.b	115,8,100,8
;	dc.b	115,100
;	dc.b	115,100
;	dc.b	116,99
;	dc.b	116,98
;	dc.b	116,97
;	dc.b	116,96
;	dc.b	116,95
;	dc.b	116,94
;	dc.b	116,93
;	dc.b	116,92
;	dc.b	116,91
;	dc.b	116,90
;	dc.b	116,89
;	dc.b	116,88
;	dc.b	116,87
;	dc.b	116,86
;	dc.b	116,85
;	dc.b	116,84
;	dc.b	116,83
;	dc.b	116,82
;	dc.b	116,81
;	dc.b	116,80
;	dc.b	116,79
;	dc.b	116,78
;	dc.b	116,77
;	dc.b	116,76
;	dc.b	116,75
;	dc.b	116,74
;	dc.b	116,73
;	dc.b	onereg
;	dc.b	114,31
;	dc.b	14
;	dc.b	114
;	dc.b	15
;	dc.b	113
;	dc.b	12
;	dc.b	113
;	dc.b	$00

	dc.b	onereg
	dc.b	56,8,24,8
	dc.b	56,24
	dc.b	7
	dc.b	56
	dc.b	onereg
	dc.b	56,23
	dc.b	4
	dc.b	56
	dc.b	onereg
	dc.b	56,22
	dc.b	3
	dc.b	56
	dc.b	onereg
	dc.b	56,21
	dc.b	4
	dc.b	56
	dc.b	onereg
	dc.b	56,20
	dc.b	3
	dc.b	56
	dc.b	onereg
	dc.b	56,19
	dc.b	4
	dc.b	56
	dc.b	onereg
	dc.b	56,18
	dc.b	3
	dc.b	56
	dc.b	onereg
	dc.b	56,17	
	dc.b	onereg
	dc.b	55,17
	dc.b	6
	dc.b	55
	dc.b	4
	dc.b	54
	dc.b	4
	dc.b	53
	dc.b	4
	dc.b	52
	dc.b	4
	dc.b	51
	dc.b	4
	dc.b	50
	dc.b	8
	dc.b	255 ; 49
	dc.b	0

	
sound27:		; Spindash/Roll (NOISE)
;	dc.b	52,3
;	dc.b	15
;	dc.b	52,3
;	dc.b	12
;	dc.b	52,3
;	dc.b	14
;	dc.b	51,3
;	dc.b	14
;	dc.b	50,3
;	dc.b	15
;	dc.b	49,3
;	dc.b	10
;	dc.b	49,3
;	dc.b	0

	dc.b	53,4
	dc.b	15
	dc.b	53,4
	dc.b	15
	dc.b	53,4
	dc.b	3
	dc.b	53,4
	dc.b	6
	dc.b	52,4
	dc.b	4
	dc.b	51,4
	dc.b	7
	dc.b	50,4
	dc.b	14
	dc.b	49,4
	dc.b	0	
	
sound9:			; Signpost/Checkpoint
	;dc.b	1
	;dc.b	182,8,213,8
	;dc.b	182
	;dc.b	onereg
	;dc.b	181,213
	;dc.b	2
	;dc.b	181
	;dc.b	1
	;dc.b	180
	;dc.b	onereg
	;dc.b	182,253
	;dc.b	182,253
	;dc.b	onereg
	;dc.b	181,253
	;dc.b	2
	;dc.b	181
	;dc.b	7
	;dc.b	180
	;dc.b	8
	;dc.b	179
	;dc.b	10
	;dc.b	178
	;dc.b	0
	
	dc.b	1
	dc.b	125,8,213,8
	dc.b	2
	dc.b	182
	dc.b	3
	dc.b	181
	dc.b	onereg
	dc.b	125,253
	dc.b	2
	dc.b	182
	dc.b	1
	dc.b	181
	dc.b	2
	dc.b	180
	dc.b	2
	dc.b	179
	dc.b	4
	dc.b	178
	dc.b	5
	dc.b	177
	dc.b	0
	
sound10:		; Points Counter
	dc.b	1
	dc.b	179,8,126,8
	dc.b	179
	dc.b	48
	dc.b	48
	dc.b	177
	dc.b	177
	dc.b	0
	
sound15:		; Spring
	dc.b	1
	dc.b	120,8,137,11
	dc.b	120
	dc.b	120
	dc.b	onereg
	dc.b	119,9
	dc.b	tworegs
	dc.b	119,137,10
	dc.b	119,9,10
	dc.b	tworegs
	dc.b	119,171,9
	dc.b	2
	dc.b	119
	dc.b	onereg
	dc.b	55,171
	dc.b	54,171
	dc.b	3
	dc.b	54
	dc.b	4
	dc.b	53
	dc.b	1
	dc.b	52
	dc.b	onereg
	dc.b	52,170
	dc.b	52,170
	dc.b	52,171
	dc.b	2
	dc.b	52
	dc.b	onereg
	dc.b	51,172
	dc.b	2
	dc.b	51
	dc.b	onereg
	dc.b	51,171
	dc.b	51,171
	dc.b	51,170
	dc.b	2
	dc.b	51
	dc.b	onereg
	dc.b	50,171
	dc.b	2
	dc.b	50
	dc.b	onereg
	dc.b	50,172
	dc.b	50,172
	dc.b	50,171
	dc.b	2
	dc.b	50
	dc.b	onereg
	dc.b	255,170
	dc.b	2
	dc.b	255
	dc.b	onereg
	dc.b	255,171
	dc.b	255,171
	dc.b	255,172
	dc.b	255,172
		
	;dc.b	7
	;dc.b	48
	dc.b	0
	
sound16:		; Bumper pulse2
	dc.b	3
	dc.b	183,8,253,8
	dc.b	3
	dc.b	182
	dc.b	3
	dc.b	181
	dc.b	3
	dc.b	180
	dc.b	onereg
	dc.b	180,252
	dc.b	180,252
	dc.b	180,253
	dc.b	178,253
	dc.b	178,254
	dc.b	178,254	
	dc.b	179,253
	dc.b	179,253
	dc.b	179,252
	dc.b	179,252
	dc.b	179,253
	dc.b	179,253
	dc.b	179,254
	dc.b	179,254
	dc.b	179,253
	dc.b	178,253
	dc.b	178,252
	dc.b	178,252
	dc.b	178,253
	dc.b	178,253
	dc.b	178,254
	dc.b	177,253
	dc.b	3
	dc.b	177
	dc.b	0
	
sound18:		; Shield
	dc.b	1
	dc.b	182,8,128,10
	dc.b	183
	dc.b	onereg
	dc.b	184,119
	dc.b	120,92
	dc.b	3
	dc.b	120
	dc.b	4
	dc.b	119
	dc.b	onereg
	dc.b	118,92
	dc.b	118,90
	dc.b	118,90
	dc.b	118,92
	dc.b	181,93
	dc.b	181,94
	dc.b	181,92
	dc.b	181,91
	dc.b	181,90
	dc.b	181,91
	dc.b	181,92
	dc.b	181,94
	dc.b	180,93
	dc.b	180,92
	dc.b	180,90
	dc.b	180,91
	dc.b	180,92
	dc.b	180,94
	dc.b	180,94
	dc.b	180,92
	dc.b	179,91
	dc.b	179,90
	dc.b	179,92
	dc.b	179,93
	dc.b	179,94
	dc.b	179,93
	dc.b	179,92
	dc.b	179,90
	dc.b	178,91
	dc.b	178,92
	dc.b	178,94
	dc.b	178,93
	dc.b	178,92
	dc.b	178,90
	dc.b	178,90
	dc.b	178,92
	dc.b	177,93
	dc.b	177,94
	dc.b	177,92
	dc.b	177,91
	dc.b	177,90
	dc.b	177,91
	dc.b	177,92
	dc.b	177,94
	dc.b	177,93
	dc.b	177,92
	dc.b	177,90
	dc.b	177,92
	dc.b	3
	dc.b	177
	dc.b	$00
	
sound19:		; Spikes
;	dc.b	onereg
;	dc.b	54+1,8,160,8
;	dc.b	52+1,159
;	dc.b	53+1,213
;	dc.b	54+1,205
;	dc.b	54+1,197
;	dc.b	54+1,189
;	dc.b	54+1,181
;	dc.b	53+1,173
;	dc.b	53+1,165
;	dc.b	53+1,157
;	dc.b	53+1,149
;	dc.b	52+1,141
;	dc.b	52+1,133
;	dc.b	52+1,125
;	dc.b	52+1,117
;	dc.b	52+1,112
;	dc.b	2
;	dc.b	52+1
;	dc.b	6
;	dc.b	51+1
;	dc.b	onereg
;	dc.b	51+1,111
;	dc.b	51+1,111
;	dc.b	50+1,112
;	dc.b	50+1,112
;	dc.b	50+1,113
;	dc.b	50+1,113
;	dc.b	50+1,112
;	dc.b	50+1,112
;	dc.b	50+1,111
;	dc.b	50+1,111
;	dc.b	50,112
;	dc.b	50,112
;	dc.b	50,113
;	dc.b	50,113
;	dc.b	50,112
;	dc.b	50,112
;	dc.b	50,111
;	dc.b	50,111
;	dc.b	255,112
;	dc.b	255,112
;	dc.b	255,113
;	dc.b	255,113
;	dc.b	255,112
;	dc.b	255,112
;	dc.b	255,111
;	dc.b	255,111
;	dc.b	$00

	dc.b	onereg
	dc.b	57,8,124,9
	dc.b	57,124
	dc.b	2
	dc.b	56
	dc.b	tworegs
	dc.b	57,189,8
	dc.b	1
	dc.b	57
	dc.b	onereg
	dc.b	56,188
	dc.b	56,187
	dc.b	56,186
	dc.b	55,185
	dc.b	55,184
	dc.b	55,183
	dc.b	54,182
	dc.b	54,181
	dc.b	53,180
	dc.b	53,179
	dc.b	53,178
	dc.b	52,177
	dc.b	52,176
	dc.b	52,175
	dc.b	51,174
	dc.b	51,173
	dc.b	50,172
	dc.b	50,171
	dc.b	50,170
	dc.b	255,169
	dc.b	255,168
	dc.b	255,167
	dc.b	255,166
	dc.b	255,165
	dc.b	0


	
; ---------------------------------------------------------------------------
songs_tbl:
		.BYTE  $FF,$8B,$81,$82,$83,$84,$85,$86
		.BYTE  $87,$A1,$89,$8A,$8F,$90,$92,$93
		.BYTE  $94,$95,$8C,$96,$97,$98,$8D,$8E
		.BYTE  $91,$9D,$9E,$9F,$A0,$A1,$A2,$A3
		
		.BYTE  $00 ; title
		.BYTE  $0D ; inviciblity
		.BYTE  $0A ; level win
		.BYTE  $01 ; green hill
		
		.BYTE  $02 ; marble
		.BYTE  $03 ; spring
		.BYTE  $04 ; labyrinth  26
		.BYTE  $05 ; star light
		
		.BYTE  $08 ; special stage
		.BYTE  $09 ; boss  29
		.BYTE  $0F ; drowning
		.BYTE  $10 ; game over
		
		.BYTE  $0C ; extra life
		.BYTE  $0E ; chaos emerald
		.BYTE  $06 ; scrap brain
		.BYTE  $07 ; final zone
		
		.BYTE  $0B ; game win
		.BYTE  $11 ; continue
		.BYTE  $12 ; credits
		.BYTE  $13 ; special stage (old)
		
		.BYTE  $14 ; drowned
		.BYTE  $15 ; continue
		.BYTE  $16 ; special stage (blue spheres)
		.BYTE  $17 ; supers-s2
		
		.BYTE  $18 ; supers-s3k
		.BYTE  $19
		.BYTE  $1A
		.BYTE  $1B

		.BYTE  $1C
		.BYTE  $1D ; supers-s3
		.BYTE  $1E ; supers-origin
		.BYTE  $0E ; chaos emerald (2)
		
		.BYTE	$80+36 		
