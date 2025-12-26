sfx_badnik_inst:
@instruments_exp:
	dw @env1, @env2, @env0 ; 00 : EPSM Custom 4
	dw @env4, @env2
	dw @instrument_epsm_extra_patch0
	db $3c,$c0,$0f,$05

@instrument_epsm_extra_patch0:
	;db $1f,$19,$05,$0f,$00,$01,$00,$1f,$12,$12,$7f,$00,$03,$00,$1f,$19,$00,$ff,$00,$01,$00,$1f,$0e,$0f,$ff,$00,$00
	 db $1f,$19,$05,$0f,$00,$01,$05,$1f,$12,$12,$7f,$00,$03,$05,$1f,$19,$00,$ff,$00,$01,$05,$1f,$0e,$0f,$ff,$00,$00

@env0:
	db $00,$c0,$7f,$00,$02
@env1:
	db $00,$cf,$7f,$00,$02
@env2:
	db $c0,$7f,$00,$01
@env3:
	db $7f,$00,$00
@env4:
	db $c8,$7f,$00,$00

sfx_badnik:
@song0ch12loop:
	db $81, $80, $2e, $85, $4d, $f6, $43, $30, $4d, $0c, $43, $31, $4d, $f6, $43, $33, $4d, $06, $43, $34, $4d, $0e, $43, $35
	db $81, $4d, $06, $43, $34, $4d, $f6, $43, $33, $4d, $0c, $43, $31, $4d, $f6, $43, $30, $4d, $00, $43, $2e, $4d, $02, $43
	db $2c, $4d, $00, $43, $2a, $4d, $08, $43, $27, $4d, $f8, $43, $25, $4d, $c0, $81, $4d, $8a, $83, $4d, $00, $5a, $89, $00
;	db $93, $42
;	dw @song0ch12loop
	db $93
	db $5C ; end channel playback


sfx_spikes_inst:
@instruments_exp:
	dw @env1, @env2, @env0 ; 00 : EPSM Custom 1
	dw @env4, @env2
	dw @instrument_epsm_extra_patch0
	db $3a,$c0,$51,$7f
	dw @env1, @env2, @env0 ; 01 : EPSM Custom 2
	dw @env4, @env2
	dw @instrument_epsm_extra_patch1
	db $20,$c0,$36,$7f
	dw @env1, @env2, @env0 ; 02 : EPSM Custom 3
	dw @env4, @env2
	dw @instrument_epsm_extra_patch2
	db $14,$c0,$25,$7f
	dw @env1, @env2, @env0 ; 03 : EPSM Custom 4
	dw @env4, @env2
	dw @instrument_epsm_extra_patch3
	db $3b,$c0,$3c,$29

@instrument_epsm_extra_patch0:
	db $1e,$1f,$00,$0f,$00,$08,$7f,$1e,$1f,$00,$0f,$00,$51,$7f,$1e,$1f,$00,$0f,$00,$02,$7f,$10,$0f,$02,$1f,$00,$00
@instrument_epsm_extra_patch1:
	db $df,$07,$07,$2f,$00,$35,$7f,$df,$06,$06,$1f,$00,$30,$7f,$9f,$09,$06,$1f,$00,$31,$7f,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch2:
	db $1f,$15,$0b,$0f,$00,$33,$7f,$1f,$18,$08,$9f,$00,$36,$7f,$1f,$1c,$0d,$8f,$00,$11,$7f,$1f,$13,$09,$0f,$00,$00
@instrument_epsm_extra_patch3:
	db $df,$04,$04,$ff,$00,$39,$20,$1f,$05,$04,$0f,$00,$30,$0f,$1f,$04,$04,$1f,$00,$31,$00,$df,$01,$02,$af,$00,$00

@env0:
	db $00,$c0,$7f,$00,$02
@env1:
	db $00,$cf,$7f,$00,$02
@env2:
	db $c0,$7f,$00,$01
@env3:
	db $7f,$00,$00
@env4:
	db $c8,$7f,$00,$00

sfx_spikes:
@song0ch12loop:
	db $81, $86, $35, $81, $4d, $10, $81, $4d, $f4, $43, $36, $4d, $04, $81, $4d, $00, $3d, $81, $4d, $20, $81, $4d, $f8, $43
	db $3e, $4d, $10, $81, $4d, $e0, $43, $3f, $4d, $00, $81, $4d, $20, $81, $4d, $f0, $43, $40, $4c, $4d, $10, $81, $4d, $28
	db $81, $4d, $f0, $43, $40, $4d, $4d, $10, $81, $4d, $d8, $43, $40, $4e, $4d, $f8, $81, $4d, $18, $81, $4d, $30, $81, $4d
	db $e8, $43, $40, $4f, $4d, $08, $81, $4d, $28, $81, $4d, $e0, $43, $40, $50, $4d, $00, $81, $4d, $18, $81, $4d, $d0, $43
	db $40, $51, $4d, $f0, $81, $4d, $10, $81, $4d, $30, $81, $4d, $d8, $43, $40, $52, $4d, $f0, $81, $4d, $10, $81, $4d, $30
	db $81, $4d, $d8, $43, $40, $53, $4d, $f8, $81, $4d, $18, $81, $4d, $30, $81, $4d, $c8, $43, $40, $54, $4d, $e8, $83, $00
;	db $a5, $42
;	dw @song0ch12loop
	db $a5
	db $5C ; end channel playback
	
	
	
sfx_ring_drop_inst:
@instruments_exp:
	dw @env1, @env2, @env0 ; 00 : EPSM Custom 4
	dw @env4, @env2
	dw @instrument_epsm_extra_patch0
	db $04,$c0,$37,$23
	dw @env1, @env2, @env0 ; 01 : EPSM Custom 5
	dw @env4, @env2
	dw @instrument_epsm_extra_patch1
	db $04,$c0,$37,$7f
	dw @env1, @env2, @env0 ; 02 : EPSM Custom 7
	dw @env4, @env2
	dw @instrument_epsm_extra_patch2
	db $04,$c0,$37,$23

@instrument_epsm_extra_patch0:
@instrument_epsm_extra_patch1:
@instrument_epsm_extra_patch2:
;	db $1f,$07,$00,$1f,$00,$72,$05,$1f,$0a,$0b,$0f,$00,$77,$23,$1f,$07,$00,$1f,$00,$49,$05,$1f,$0d,$0b,$0f,$00,$00
;@instrument_epsm_extra_patch1:
;	db $1f,$07,$00,$1f,$00,$72,$7f,$1f,$0a,$0b,$0f,$00,$77,$7f,$1f,$07,$00,$1f,$00,$49,$7f,$1f,$0d,$0b,$0f,$00,$00
;@instrument_epsm_extra_patch2:
;	db $1f,$07,$00,$1f,$00,$72,$08,$1f,$0a,$0b,$0f,$00,$77,$28,$1f,$07,$00,$1f,$00,$49,$08,$1f,$0d,$0b,$0f,$00,$00

	db $1f,$07,$00,$1f,$00,$72,$0f,$1f,$0a,$0b,$0f,$00,$77,$2f,$1f,$07,$00,$1f,$00,$49,$0f,$1f,$0d,$0b,$0f,$00,$00

@env0:
	db $00,$c0,$7f,$00,$02
@env1:
	db $00,$cf,$7f,$00,$02
@env2:
	db $c0,$7f,$00,$01
@env3:
	db $7f,$00,$00
@env4:
	db $c8,$7f,$00,$00

sfx_ring_drop:
@song0ch12loop:
	db $81, $80, $3a, $81, $3a, $87, $3a, $87, $3a, $87, $3a, $87, $3a, $87, $3a, $87, $3a, $89, $00 ; , $af, $42
	db $AF
	db $5C ; end channel playback
	
;sfx_ring_drop2:
;@song0ch13loop:
;	db $83, $82, $38, $84, $38, $81, $38, $87, $38, $a7, $38, $81, $38, $89, $00 ; , $af, $42
;	db $AF
;	db $5C ; end channel playback

sfx_spring_inst:
@instruments_exp:
	dw @env1, @env2, @env0 ; 00 : EPSM Custom 6
	dw @env4, @env2
	dw @instrument_epsm_extra_patch0
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 01 : EPSM Custom 7
	dw @env4, @env2
	dw @instrument_epsm_extra_patch1
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 02 : EPSM Custom 8
	dw @env4, @env2
	dw @instrument_epsm_extra_patch2
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 03 : EPSM Custom 9
	dw @env4, @env2
	dw @instrument_epsm_extra_patch3
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 04 : EPSM Custom 10
	dw @env4, @env2
	dw @instrument_epsm_extra_patch4
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 05 : EPSM Custom 11
	dw @env4, @env2
	dw @instrument_epsm_extra_patch5
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 06 : EPSM Custom 12
	dw @env4, @env2
	dw @instrument_epsm_extra_patch6
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 07 : EPSM Custom 13
	dw @env4, @env2
	dw @instrument_epsm_extra_patch7
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 08 : EPSM Custom 14
	dw @env4, @env2
	dw @instrument_epsm_extra_patch8
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 09 : EPSM Custom 15
	dw @env4, @env2
	dw @instrument_epsm_extra_patch9
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0a : EPSM Custom 16
	dw @env4, @env2
	dw @instrument_epsm_extra_patch10
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0b : EPSM Custom 17
	dw @env4, @env2
	dw @instrument_epsm_extra_patch11
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0c : EPSM Custom 18
	dw @env4, @env2
	dw @instrument_epsm_extra_patch12
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0d : EPSM Custom 19
	dw @env4, @env2
	dw @instrument_epsm_extra_patch13
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0e : EPSM Custom 20
	dw @env4, @env2
	dw @instrument_epsm_extra_patch14
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 0f : EPSM Custom 21
	dw @env4, @env2
	dw @instrument_epsm_extra_patch15
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 10 : EPSM Custom 22
	dw @env4, @env2
	dw @instrument_epsm_extra_patch16
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 11 : EPSM Custom 23
	dw @env4, @env2
	dw @instrument_epsm_extra_patch17
	db $20,$c0,$36,$16
	dw @env1, @env2, @env0 ; 12 : EPSM Custom 24
	dw @env4, @env2
	dw @instrument_epsm_extra_patch18
	db $20,$c0,$36,$16

@instrument_epsm_extra_patch0:
	;db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$02,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch1:
	;db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$04,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch2:
	;db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$06,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch3:
	;db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$08,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch4:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$0a,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch5:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$0c,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch6:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$0e,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch7:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$10,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch8:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$12,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch9:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$14,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch10:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$16,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch11:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$18,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch12:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$1a,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch13:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$1c,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch14:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$1e,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch15:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$20,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch16:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$22,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch17:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$24,$9f,$06,$08,$ff,$00,$00
@instrument_epsm_extra_patch18:
	db $df,$07,$07,$2f,$00,$35,$30,$df,$06,$06,$1f,$00,$30,$13,$9f,$09,$06,$1f,$00,$31,$26,$9f,$06,$08,$ff,$00,$00

@env0:
	db $00,$c0,$7f,$00,$02
@env1:
	db $00,$cf,$7f,$00,$02
@env2:
	db $c0,$7f,$00,$01
@env3:
	db $7f,$00,$00
@env4:
	db $c8,$7f,$00,$00

sfx_spring:
@song0ch13:
@song0ch13loop:
	db $83, $4d, $ec, $80, $25, $85, $4d, $06, $43, $26, $4d, $f6, $43, $29, $4d, $0c, $43, $2a, $4d, $04, $43, $2c, $4d, $fa
	db $43, $2e, $4d, $0a, $43, $2f, $4d, $f2, $43, $31, $81, $4d, $00, $82, $31, $81, $84, $31, $81, $86, $31, $81, $88, $31
	db $81, $8a, $31, $81, $8c, $31, $81, $8e, $31, $81, $90, $31, $81, $92, $31, $81, $94, $31, $81, $96, $31, $81, $98, $31
	db $81, $9a, $31, $81, $9c, $31, $81, $9e, $31, $81, $a0, $31, $81, $a2, $31, $81, $a4, $31, $83, $00, $97 ; , $42
	;dw @song0ch13loop
	db $5C ; end channel playback


sfx_spin_inst:
@instruments_exp:
	dw @env1, @env2, @env0 ; 00 : EPSM Custom 6
	dw @env4, @env2
	dw @instrument_epsm_extra_patch0
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 01 : EPSM Custom 7
	dw @env4, @env2
	dw @instrument_epsm_extra_patch1
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 02 : EPSM Custom 8
	dw @env4, @env2
	dw @instrument_epsm_extra_patch2
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 03 : EPSM Custom 9
	dw @env4, @env2
	dw @instrument_epsm_extra_patch3
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 04 : EPSM Custom 10
	dw @env4, @env2
	dw @instrument_epsm_extra_patch4
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 05 : EPSM Custom 11
	dw @env4, @env2
	dw @instrument_epsm_extra_patch5
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 06 : EPSM Custom 12
	dw @env4, @env2
	dw @instrument_epsm_extra_patch6
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 07 : EPSM Custom 13
	dw @env4, @env2
	dw @instrument_epsm_extra_patch7
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 08 : EPSM Custom 14
	dw @env4, @env2
	dw @instrument_epsm_extra_patch8
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 09 : EPSM Custom 15
	dw @env4, @env2
	dw @instrument_epsm_extra_patch9
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0a : EPSM Custom 16
	dw @env4, @env2
	dw @instrument_epsm_extra_patch10
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0b : EPSM Custom 17
	dw @env4, @env2
	dw @instrument_epsm_extra_patch11
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0c : EPSM Custom 18
	dw @env4, @env2
	dw @instrument_epsm_extra_patch12
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0d : EPSM Custom 19
	dw @env4, @env2
	dw @instrument_epsm_extra_patch13
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0e : EPSM Custom 20
	dw @env4, @env2
	dw @instrument_epsm_extra_patch14
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 0f : EPSM Custom 21
	dw @env4, @env2
	dw @instrument_epsm_extra_patch15
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 10 : EPSM Custom 22
	dw @env4, @env2
	dw @instrument_epsm_extra_patch16
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 11 : EPSM Custom 23
	dw @env4, @env2
	dw @instrument_epsm_extra_patch17
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 12 : EPSM Custom 24
	dw @env4, @env2
	dw @instrument_epsm_extra_patch18
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 13 : EPSM Custom 25
	dw @env4, @env2
	dw @instrument_epsm_extra_patch19
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 14 : EPSM Custom 26
	dw @env4, @env2
	dw @instrument_epsm_extra_patch20
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 15 : EPSM Custom 27
	dw @env4, @env2
	dw @instrument_epsm_extra_patch21
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 16 : EPSM Custom 28
	dw @env4, @env2
	dw @instrument_epsm_extra_patch22
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 17 : EPSM Custom 29
	dw @env4, @env2
	dw @instrument_epsm_extra_patch23
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 18 : EPSM Custom 30
	dw @env4, @env2
	dw @instrument_epsm_extra_patch24
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 19 : EPSM Custom 31
	dw @env4, @env2
	dw @instrument_epsm_extra_patch25
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1a : EPSM Custom 32
	dw @env4, @env2
	dw @instrument_epsm_extra_patch26
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1b : EPSM Custom 33
	dw @env4, @env2
	dw @instrument_epsm_extra_patch27
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1c : EPSM Custom 34
	dw @env4, @env2
	dw @instrument_epsm_extra_patch28
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1d : EPSM Custom 35
	dw @env4, @env2
	dw @instrument_epsm_extra_patch29
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1e : EPSM Custom 36
	dw @env4, @env2
	dw @instrument_epsm_extra_patch30
	db $3c,$c0,$00,$0d
	dw @env1, @env2, @env0 ; 1f : EPSM Custom 37
	dw @env4, @env2
	dw @instrument_epsm_extra_patch31
	db $3c,$c0,$00,$0d

@instrument_epsm_extra_patch0:
;	db $1f,$00,$00,$0f,$00,$44,$05,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$05,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch1:
;	db $1f,$00,$00,$0f,$00,$44,$09,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$06,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch2:
;	db $1f,$00,$00,$0f,$00,$44,$0a,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$07,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch3:
;	db $1f,$00,$00,$0f,$00,$44,$0b,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$08,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch4:
;	db $1f,$00,$00,$0f,$00,$44,$0c,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$09,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch5:
;	db $1f,$00,$00,$0f,$00,$44,$0d,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0a,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch6:
;	db $1f,$00,$00,$0f,$00,$44,$0e,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0b,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch7:
;	db $1f,$00,$00,$0f,$00,$44,$0f,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0c,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch8:
;	db $1f,$00,$00,$0f,$00,$44,$10,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0d,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch9:
;	db $1f,$00,$00,$0f,$00,$44,$11,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0e,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch10:
;	db $1f,$00,$00,$0f,$00,$44,$12,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$0f,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch11:
;	db $1f,$00,$00,$0f,$00,$44,$13,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$10,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch12:
;	db $1f,$00,$00,$0f,$00,$44,$14,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$11,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch13:
;	db $1f,$00,$00,$0f,$00,$44,$15,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$12,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch14:
;	db $1f,$00,$00,$0f,$00,$44,$16,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$13,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch15:
;	db $1f,$00,$00,$0f,$00,$44,$17,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$14,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch16:
	db $1f,$00,$00,$0f,$00,$44,$18,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$15,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch17:
	db $1f,$00,$00,$0f,$00,$44,$19,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$16,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch18:
	db $1f,$00,$00,$0f,$00,$44,$1a,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$17,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch19:
	db $1f,$00,$00,$0f,$00,$44,$1b,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$18,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch20:
	db $1f,$00,$00,$0f,$00,$44,$1c,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$19,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch21:
	db $1f,$00,$00,$0f,$00,$44,$1d,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1a,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch22:
	db $1f,$00,$00,$0f,$00,$44,$1e,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1b,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch23:
	db $1f,$00,$00,$0f,$00,$44,$1f,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1c,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch24:
	db $1f,$00,$00,$0f,$00,$44,$20,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1d,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch25:
	db $1f,$00,$00,$0f,$00,$44,$21,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1e,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch26:
	db $1f,$00,$00,$0f,$00,$44,$22,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$1f,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch27:
	db $1f,$00,$00,$0f,$00,$44,$23,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$20,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch28:
	db $1f,$00,$00,$0f,$00,$44,$24,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$21,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch29:
	db $1f,$00,$00,$0f,$00,$44,$25,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$22,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch30:
	db $1f,$00,$00,$0f,$00,$44,$26,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$23,$15,$00,$00,$0f,$00,$00
@instrument_epsm_extra_patch31:
	db $1f,$00,$00,$0f,$00,$44,$27,$1f,$1f,$00,$0f,$00,$02,$28,$1f,$00,$00,$0f,$00,$02,$24,$15,$00,$00,$0f,$00,$00

@env0:
	db $00,$c0,$7f,$00,$02
@env1:
	db $00,$cf,$7f,$00,$02
@env2:
	db $c0,$7f,$00,$01
@env3:
	db $7f,$00,$00
@env4:
	db $c8,$7f,$00,$00

sfx_spin:
@song0ch13:
@song0ch13loop:
	db $83, $4d, $f0, $80, $40, $56, $85, $4d, $20, $81, $4d, $40, $81, $4d, $c0, $43, $40, $57, $4d, $e0, $81, $4d, $10, $81
	db $4d, $30, $81, $4d, $50, $81, $4d, $d0, $43, $40, $58, $4d, $00, $81, $4d, $20, $81, $4d, $30, $81, $4d, $50, $81, $4d
	db $d0, $43, $40, $59, $4d, $f0, $81, $4d, $10, $81, $4d, $30, $81, $4d, $b0, $43, $40, $5a, $4d, $d0, $81, $4d, $f0, $81
	db $4d, $10, $81, $4d, $40, $81, $4d, $50, $81, $4d, $a0, $43, $40, $5b, $4d, $c0, $81, $4d, $f0, $81, $4d, $10, $81, $4d
	db $30, $81, $4d, $50, $81, $4d, $b0, $43, $40, $5c, $4d, $d0, $81, $4d, $f0, $81, $4d, $10, $81, $4d, $30, $81, $4d, $00
	db $82, $40, $5c, $81, $84, $40, $5c, $81, $86, $40, $5c, $81, $88, $40, $5c, $81, $8a, $40, $5c, $81, $8c, $40, $5c, $81
	db $8e, $40, $5c, $81, $90, $40, $5c, $81, $92, $40, $5c, $81, $94, $40, $5c, $81, $96, $40, $5c, $81, $98, $40, $5c, $81
	db $9a, $40, $5c, $81, $9c, $40, $5c, $81, $9e, $40, $5c, $81, $a0, $40, $5c, $81, $a2, $40, $5c, $81, $a4, $40, $5c, $81
	db $a6, $40, $5c, $81, $a8, $40, $5c, $81, $aa, $40, $5c, $81, $ac, $40, $5c, $81, $ae, $40, $5c, $81, $b0, $40, $5c, $81
	db $b2, $40, $5c, $81, $b4, $40, $5c, $81, $b6, $40, $5c, $81, $b8, $40, $5c, $81, $ba, $40, $5c, $81, $bc, $40, $5c, $81
	db $be, $40, $5c, $81, $00, $b3 ;  , $42
	;dw @song0ch13loop
	db $5C ; end channel playback
	