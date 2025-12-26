sound20:		; Fireball (NOISE)
	dc.b	54,15
	dc.b	55,15
	dc.b	56,15
	dc.b	56,15
	dc.b	2
	dc.b	56,14
	dc.b	55,14
	dc.b	1
	dc.b	48,14
	dc.b	52,1
	dc.b	5
	dc.b	51,1
	dc.b	5
	dc.b	50,1
	dc.b	12
	dc.b	49,1
	dc.b	0

sound21:		; Spikes from wall
	;dc.b	188,3
;	dc.b	191-7,0
;	dc.b	191-7,15
;	dc.b	191-7,3
;	dc.b	191-7,10
;	dc.b	190-7,7
;	dc.b	189-7,5
	;dc.b	188,3
;	dc.b	0
	
	dc.b	52,9
	dc.b	52,6
	dc.b	53,6
	dc.b	3
	dc.b	51,15
	dc.b	1
	dc.b	51,2
	dc.b	2
	dc.b	50,2
	dc.b	6
	dc.b	49,2
	dc.b	0
	
sound22:		; waterfall
	dc.b	49,4
	dc.b	49,4
	dc.b	49,4
	dc.b	15
	dc.b	50,4
	dc.b	15
	dc.b	50,4
	dc.b	15
	dc.b	50,4
	dc.b	15
	dc.b	50,4
	dc.b	15
	dc.b	50,4
	dc.b	0

sound23:		; electricity (final boss)
	dc.b	52,134
	dc.b	3
	dc.b	52,134
	dc.b	49,134
	dc.b	52,134
	dc.b	7
	dc.b	52,134
	dc.b	49,134
	dc.b	0
	
sound24:		; piston activation (final boss)
	dc.b	52,139
	dc.b	1
	dc.b	52,139
	dc.b	2
	dc.b	52,13
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	52,11
	dc.b	2
	dc.b	52,141
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	52,139
	dc.b	2
	dc.b	52,13
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	52,11
	dc.b	2
	dc.b	52,141
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	52,139
	dc.b	2
	dc.b	52,13
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	52,11
	dc.b	2
	dc.b	52,141
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	52,11
	dc.b	2
	dc.b	52,141
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	52,139
	dc.b	2
	dc.b	52,13
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	51,11
	dc.b	2
	dc.b	51,140
	dc.b	2
	dc.b	51,13
	dc.b	2
	dc.b	51,142
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	51,11
	dc.b	2
	dc.b	51,140
	dc.b	2
	dc.b	51,13
	dc.b	2
	dc.b	51,142
	dc.b	2
	dc.b	51,15
	dc.b	2
	dc.b	51,143
	dc.b	2
	dc.b	50,11
	dc.b	2
	dc.b	50,140
	dc.b	2
	dc.b	50,13
	dc.b	2
	dc.b	50,142
	dc.b	2
	dc.b	50,15
	dc.b	2
	dc.b	50,143
	dc.b	2
	dc.b	50,11
	dc.b	2
	dc.b	50,140
	dc.b	2
	dc.b	50,13
	dc.b	2
	dc.b	50,142
	dc.b	2
	dc.b	50,15
	dc.b	2
	dc.b	50,143
	dc.b	2
	dc.b	49,11
	dc.b	49,140
	dc.b	0
	
sound13:		; projectile s3k pulse part
	dc.b	1	; speed + regs
	dc.b	179,8,179,8
	dc.b	tworegs
	dc.b	180,189,8
	dc.b	180,201,8
	dc.b	179,213,8
	dc.b	179,225,8
	dc.b	178,239,8
	dc.b	178,253,8
	dc.b	177,12,9
	dc.b	177,28,9
	dc.b	0

sound25:		; projectile s3k noise part
	dc.b	51,7
	dc.b	50,6
	dc.b	49,5
	dc.b	0
	
sound14:		; projectile SMS
	dc.b	1	; speed + regs
	dc.b	182,8,11,9
	dc.b	onereg
	dc.b	48,11
	dc.b	182,171
	dc.b	48,171
	dc.b	180,13
	dc.b	48,13
	dc.b	180,171
	dc.b	48,171
	dc.b	179,11
	dc.b	48,11
	dc.b	179,171
	dc.b	48,171
	dc.b	178,13
	dc.b	48,13
	dc.b	178,171
	dc.b	48,171
	dc.b	177,11
	dc.b	48,11
	dc.b	177,171
	dc.b	48,171
	dc.b	177,13
	dc.b	48,13
	dc.b	177,171
	dc.b	48,171
	dc.b	177,11
	dc.b	48,11
	dc.b	177,171
	dc.b	0
	
sound17:		; eggman jump sfx (final screen)
	dc.b	1	; speed + regs
	dc.b	114,8,128,10
	dc.b	onereg
	dc.b	114,128
	dc.b	114,128
	dc.b	tworegs
	dc.b	115,223,9
	dc.b	onereg
	dc.b	115,223
	dc.b	115,223
	dc.b	115,207
	dc.b	115,191
	dc.b	115,175
	dc.b	115,159
	dc.b	115,143
	dc.b	115,127
	dc.b	115,111
	dc.b	115,95
	dc.b	115,79
	dc.b	115,63
	dc.b	115,47
	dc.b	115,31
	dc.b	114,15
	dc.b	tworegs
	dc.b	114,255,8
	dc.b	114,239,8
	dc.b	0
	
sound28:		; Bumper pulse1
	dc.b	onereg
	dc.b	181,8,8,12
	dc.b	181,24
	dc.b	181,40
	dc.b	tworegs
	dc.b	179,255,8
	dc.b	2
	dc.b	179
	dc.b	12
	dc.b	178
	dc.b	3
	dc.b	177
	dc.b	3
	dc.b	178
	dc.b	9
	dc.b	177
	dc.b	0
	
sound29:	; BAT (Noise)
	dc.b	49,4
	dc.b	49,4
	dc.b	51,4
	dc.b	53,4
	dc.b	49,4
	dc.b	5
	dc.b	48,4
	dc.b	49,4
	dc.b	51,4
	dc.b	49,4
	dc.b	0
	
sound30:	; FIRE (Noise)
	dc.b	50,143
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	15
	dc.b	51,12
	dc.b	49,12
	dc.b	0
	
sound31:	; water splash
	dc.b	54,10
	dc.b	3
	dc.b	54,10
	dc.b	1
	dc.b	52,3
	dc.b	4
	dc.b	51,3
	dc.b	11
	dc.b	50,3
	dc.b	15
	dc.b	49,3
	dc.b	6
	dc.b	49,3
	dc.b	0
	
sound32:	; water splash pulse
	dc.b	5	; speed + regs
	dc.b	180,8,77,14
	dc.b	0
	
sound33:		; Boss Hit (NOISE)
;	dc.b	56,11
;	dc.b	56,12
;	dc.b	55,13
;	dc.b	55,11
;	dc.b	1
;	dc.b	55,12
;	dc.b	54,12
;	dc.b	2
;	dc.b	55,12
;	dc.b	9
;	dc.b	51,12
;	dc.b	3
;	dc.b	50,13
;	dc.b	5
;	dc.b	50,14
;	dc.b	9
;	dc.b	49,12
;	dc.b	0

	dc.b	63,139
	dc.b	63,143
	dc.b	63,139
	dc.b	63,143
	dc.b	63,141
	dc.b	63,143
	dc.b	63,141
	dc.b	63,143

	dc.b	53,139
	dc.b	53,143
	dc.b	53,139
	dc.b	53,143
	dc.b	53,141
	dc.b	53,143
	dc.b	53,141
	dc.b	53,143
	
	dc.b	50,139
	dc.b	50,143
	dc.b	50,139
	dc.b	50,143
	dc.b	50,141
	dc.b	50,143
	dc.b	50,141
	dc.b	50,143
	
	dc.b	49,139
	dc.b	49,143
	dc.b	49,139
	dc.b	49,143
	dc.b	49,141
	dc.b	49,143
	dc.b	49,141
	dc.b	49,143
	
	dc.b	0
	
sound34:
	dc.b	57,132
	dc.b	57,132
	dc.b	1
	dc.b	56,132
	dc.b	1
	dc.b	57,131
	dc.b	2
	dc.b	56,131
	dc.b	2
	dc.b	55,131
	dc.b	1
	dc.b	54,131
	dc.b	2
	dc.b	53,131
	dc.b	2
	dc.b	52,131
	dc.b	1
	dc.b	51,131
	dc.b	2
	dc.b	50,131
	dc.b	4
	dc.b	49,131
	dc.b	0

sound35:	; SFX: Signpost (Rushjet1 version)
	dc.b	57,131
	dc.b	57,133
	dc.b	57,3
	dc.b	57,132
	dc.b	57,6
	dc.b	57,133
	dc.b	57,3
	dc.b	57,132
	dc.b	56,6
	dc.b	56,133
	dc.b	56,3
	dc.b	56,132
	dc.b	56,6
	dc.b	56,133
	dc.b	56,3
	dc.b	56,132
	dc.b	55,6
	dc.b	55,133
	dc.b	55,3
	dc.b	55,132
	dc.b	55,6
	dc.b	55,133
	dc.b	55,3
	dc.b	55,132
	dc.b	54,6
	dc.b	54,133
	dc.b	54,3
	dc.b	54,132
	dc.b	54,6
	dc.b	54,133
	dc.b	54,3
	dc.b	54,132
	dc.b	53,6
	dc.b	53,133
	dc.b	53,3
	dc.b	53,132
	dc.b	53,6
	dc.b	53,133
	dc.b	53,3
	dc.b	53,132
	dc.b	52,6
	dc.b	52,133
	dc.b	52,3
	dc.b	52,132
	dc.b	52,6
	dc.b	52,133
	dc.b	52,3
	dc.b	52,132
	dc.b	51,6
	dc.b	51,133
	dc.b	51,3
	dc.b	51,132
	dc.b	51,6
	dc.b	51,133
	dc.b	51,3
	dc.b	51,132
	dc.b	50,6
	dc.b	50,133
	dc.b	50,3
	dc.b	50,132
	dc.b	50,6
	dc.b	50,133
	dc.b	50,3
	dc.b	50,132
	dc.b	49,6
	dc.b	49,133
	dc.b	49,3
	dc.b	49,132
	dc.b	49,6
	dc.b	49,133
	dc.b	49,3
	dc.b	49,132
	dc.b	49,6
	dc.b	49,133
	dc.b	49,3
	dc.b	49,132
	dc.b	49,6
	dc.b	49,133
	dc.b	49,3
	dc.b	0
	
sound36:	; SFX: BIG RING (NOISE)
	dc.b	51,137
	dc.b	54,8
	dc.b	57,135
	dc.b	58,6
	dc.b	59,133
	dc.b	59,4
	dc.b	59,133
	dc.b	59,4
	dc.b	59,133
	dc.b	56,132
	dc.b	56,3
	dc.b	56,132
	dc.b	55,3
	dc.b	55,132
	dc.b	55,3
	dc.b	54,132
	dc.b	54,3
	dc.b	54,132
	dc.b	54,3
	dc.b	54,132
	dc.b	54,3
	dc.b	53,132
	dc.b	53,3
	dc.b	53,132
	dc.b	52,3
	dc.b	52,132
	dc.b	52,3
	dc.b	51,132
	dc.b	51,3
	dc.b	51,132
	dc.b	51,3
	dc.b	51,132
	dc.b	51,3
	dc.b	51,132
	dc.b	51,3
	dc.b	51,132
	dc.b	51,3
	dc.b	51,132
	dc.b	51,3
	dc.b	50,132
	dc.b	50,3
	dc.b	50,132
	dc.b	50,3
	dc.b	50,132
	dc.b	50,3
	dc.b	50,132
	dc.b	50,3
	dc.b	50,132
	dc.b	49,3
	dc.b	49,132
	dc.b	49,3
	dc.b	49,132
	dc.b	49,3
	dc.b	49,132
	dc.b	49,3
	dc.b	49,132
	dc.b	49,3
	dc.b	0
	
sound37:	; SFX: BIG RING (SQ1)
	dc.b	6
	dc.b	114,8,52,12
	dc.b	tworegs
	dc.b	114,26,10
	dc.b	5
	dc.b	114
	dc.b	15
	dc.b	113
	dc.b	12
	dc.b	113
	
	dc.b	0
	
sound38:	; SFX: BIG RING (SQ2)
	dc.b	3
	dc.b	178,8,112,8
	dc.b	3
	dc.b	179
	
	dc.b	tworegs
	dc.b	179,75,8
	dc.b	8
	dc.b	179
	dc.b	4
	dc.b	178
	dc.b	2
	dc.b	177
	dc.b	4
	dc.b	178
	dc.b	2
	dc.b	177
	dc.b	4
	dc.b	178
	dc.b	2
	dc.b	177
	dc.b	4
	dc.b	178
	dc.b	2
	dc.b	177
	dc.b	3
	dc.b	178
	dc.b	onereg
	dc.b	178,74
	dc.b	2
	dc.b	177
	dc.b	onereg+2
	dc.b	177,73
	dc.b	onereg+2
	dc.b	177,72
	dc.b	onereg+9
	dc.b	177,71
	dc.b	0
