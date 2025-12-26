	org	$8000
	
; Afecta la dirección de algunas las animaciones
sonic_spr_dir:
.byte  $40 ; 00
.byte  $C0 ; 01
.byte  $C0 ; 02
.byte  $C0 ; 03
.byte  $C0 ; 04
.byte  $C0 ; 05
.byte  $40 ; 06
.byte  $40 ; 07
.byte  $40 ; 08
.byte  $00 ; 09
.byte  $40 ; 10
.byte  $40 ; 11
.byte  $40 ; 12
.byte  $40 ; 13
.byte  $40 ; 14
.byte  $40 ; 15
.byte  $40 ; 16
.byte  $40 ; 17
.byte  $40 ; 18
.byte  $40 ; 19
.byte  $C0 ; 20
.byte  $C0 ; 21
.byte  $C0 ; 22
.byte  $C0 ; 23
.byte  $C0 ; 24
.byte  $C0 ; 25
.byte  $C0 ; 26
.byte  $C0 ; 27
.byte  $C0 ; 28
.byte  $C0 ; 29
.byte  $C0 ; 30
.byte  $40 ; 31
.byte  $40 ; 32
.byte  $C0 ; 33
.byte  $C0 ; 34
.byte  $C0 ; 35
.byte  $C0 ; 36
.byte  $C0 ; 37
.byte  $C0 ; 38
.byte  $C0 ; 39
.byte  $C0 ; 40
.byte  $C0 ; 41
.byte  $C0 ; 42
.byte  $40 ; 43
.byte  $40 ; 44

pl_spr_cfg_ptrs:
.word  PARADO_NEW
.word  CAMINAR_X1 ; 1
.word  CAMINAR_X2 ; 2
.word  CAMINAR_X3 ; 3

.word  CORRER_X1 ; 4
.word  CORRER_X2 ; 5

.word  SALTANDO ; 6
.word  RESBALANDO ; 7
.word  BOLITA_NEW ; 8
.word  MURIENDO ; 9
.word  GET_HIT_ANIM ; 10
.word  AGACHANDOSE ; 11
.word  MIRANDO_ARRIBA ; 12
.word  EMPUJANDO ; 13
.word  MIRANDO_LA_HORA ; 14
.word  MIRANDO_LA_HORA ; 15

.word  RECOSTANDOSE ; 16

.word  ANIM_DROWNING ; 17
.word  ANIM_SEQ_18 ; 18
.word  ANIM_SEQ_19 ; 19

.word  PARADO_NEW	; 20
.word  CAMINAR_ACOSTADO_X1 ; 21 $15
.word  CAMINAR_ACOSTADO_X2 ; 22 $16
.word  CAMINAR_ACOSTADO_X3 ; 23 $17

.word  CORRER_ACOSTADO_X1 ; $18
.word  CORRER_ACOSTADO_X2 ; $19

.word  CAMINAR_45_ARRIBA_X1
.word  CAMINAR_45_ARRIBA_X2
.word  CAMINAR_45_ARRIBA_X3

.word  CORRER_45_ARRIBA_X1
.word  CORRER_45_ARRIBA_X2

.word  MOMENTUM_SPINDASH
.word  BOLITA_NEW

.word  CAMINAR_45_ABAJO_X1
.word  CAMINAR_45_ABAJO_X2
.word  CAMINAR_45_ABAJO_X3

.word  CORRER_45_ABAJO_X1
.word  CORRER_45_ABAJO_X2

.word  CAMINAR_X1
.word  CAMINAR_X2
.word  CAMINAR_X3
.word  CORRER_X1
.word  CORRER_X2

.word  WATERFALL_ANIM

.word  TOMAR_AIRE
; ---------------------------------------------
CAMINAR_X1:
.word  FRAME_09 
.byte  $03,$00  ; 38B53
.word  FRAME_0A 
.byte  $03,$00  ; 38B97
.word  FRAME_0B 
.byte  $03,$00  ; 38BE3
.word  FRAME_08 
.byte  $03,$00  ; 38B17
.word  FRAME_05 
.byte  $03,$00  ; 38A33
.word  FRAME_06 
.byte  $03,$00  ; 38A7F
.word  FRAME_07 
.byte  $03,$00  ; 38ACB

.word  FRAME_08 
.byte  $03,$00  ; 38B17
.word  FRAME_07 
.byte  $03,$00  ; 38ACB
.word  FRAME_06 
.byte  $81,$00  ; 38A7F

CAMINAR_X2:
.word  FRAME_05 
.byte  $02,$00  ; 38A33
.word  FRAME_06 
.byte  $02,$00  ; 38A7F
.word  FRAME_07 
.byte  $02,$00  ; 38ACB
.word  FRAME_08 
.byte  $02,$00  ; 38B17
.word  FRAME_09 
.byte  $02,$00  ; 38B53
.word  FRAME_0A 
.byte  $02,$00  ; 38B97
.word  FRAME_0B 
.byte  $02,$00  ; 38BE3

.word  FRAME_08 
.byte  $02,$00  ; 38B17
.word  FRAME_07 
.byte  $02,$00  ; 38ACB
.word  FRAME_06 
.byte  $81,$00  ; 38A7F

CAMINAR_X3:
.word  FRAME_05
 .byte  $01,$00  ; 38A33
.word  FRAME_06
 .byte  $01,$00  ; 38A7F
.word  FRAME_07
 .byte  $01,$00  ; 38ACB
.word  FRAME_08
 .byte  $01,$00  ; 38B17
.word  FRAME_09
 .byte  $01,$00  ; 38B53
.word  FRAME_0A
 .byte  $01,$00  ; 38B97
.word  FRAME_0B 
. byte  $01,$00  ; 38BE3
.word  FRAME_08
 .byte  $01,$00  ; 38B17
.word  FRAME_07
 .byte  $01,$00  ; 38ACB
.word  FRAME_06
 .byte  $81,$00  ; 38A7F

; ---------------------------------------------
CORRER_X1:
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D 
.byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D
 .byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D
 .byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $81,$00  ; 38CD3

CORRER_X2:
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D
 .byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D
 .byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $01,$00  ; 38CD3
.word  FRAME_0D
 .byte  $01,$00  ; 38C7B
.word  FRAME_0C
 .byte  $01,$00  ; 38C2F
.word  FRAME_0E
 .byte  $81,$00  ; 38CD3

; ---------------------------------------------
SALTANDO:
.word  FRAME_0F
 .byte $0A,$00  ; 38D2B
.word  FRAME_0F
 .byte $80,$00  ; 38D2B

; ---------------------------------------------

; SKID
RESBALANDO:
.word  FRAME_10
 .byte  $08,$00
.word  FRAME_54
 .byte  $7F,$00
.word  FRAME_54
 .byte  $80,$00

; ---------------------------------------------
;BOLITA:
;.word  FRAME_41
; .byte  $00,$00  ; 398A7
;.word  FRAME_42
; .byte  $00,$00  ; 398CB
;.word  FRAME_40
; .byte  $00,$00  ; 39883
;.word  FRAME_42
; .byte  $00,$00  ; 398CB
;.word  FRAME_3F
; .byte  $00,$00  ; 3985F
;.word  FRAME_42
; .byte  $00,$00  ; 398CB
;.word  FRAME_3E
; .byte  $00,$00  ; 3983B
;.word  FRAME_42
; .byte  $00,$00  ; 398CB
;.word  FRAME_3E
; .byte  $80,$00  ; 3983B

; ---------------------------------------------
MURIENDO:
.word  FRAME_11
 .byte  $00,$00  ; 38D83
.word  FRAME_11
 .byte  $80,$00  ; 38D83

; ---------------------------------------------

; GET HIT
GET_HIT_ANIM:
 .word  FRAME_14
 .byte  $0A,$00  ; 38DE5
 .word  FRAME_14
 .byte  $80,$00  ; 38DE5
 
; WATERFALL
WATERFALL_ANIM:
 .word  FRAME_14
 .byte  $08,$00
 .word  FRAME_53
 .BYTE	$08,$00
 .word  FRAME_14
 .byte  $80,$00

; ---------------------------------------------
AGACHANDOSE:
.word  FRAME_12
 .byte  $08,$00  ; 38D9F
.word  FRAME_13
 .byte  $08,$00  ; 38DC1
.word  FRAME_12
 .byte  $81,$00  ; 38D9F

; ---------------------------------------------
MIRANDO_ARRIBA:
.word  FRAME_3D
 .byte  $02,$00  ; 3980B
.word  FRAME_3D
 .byte  $80,$00  ; 3980B

; ---------------------------------------------
EMPUJANDO:
.word  FRAME_15
 .byte  $10,$00  ; 38E0F
.word  FRAME_16
 .byte  $10,$00  ; 38E31
.word  FRAME_17
 .byte  $10,$00  ; 38E5B
.word  FRAME_18
 .byte  $10,$00  ; 38E85
.word  FRAME_15
 .byte  $80,$00  ; 38E0F

; ---------------------------------------------
MIRANDO_LA_HORA:
.word  FRAME_19
 .byte  $79,$00  ; 38EAF
.word  FRAME_1B
 .byte  $28,$00  ; 38F47
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_1A
 .byte  $19,$00  ; 38EFB
.word  FRAME_1C
 .byte  $19,$00  ; 38F71
.word  FRAME_19
 .byte  $14,$00  ; 38EAF
.word  FRAME_1C
 .byte  $81,$00  ; 38F71

; ---------------------------------------------
RECOSTANDOSE:
.word  FRAME_1D
 .byte  $0A,$00  ; 38F9B
.word  FRAME_1E
 .byte  $14,$00  ; 38FC5
.word  FRAME_1F
 .byte  $14,$00  ; 38FEF
.word  FRAME_1E
 .byte  $81,$00  ; 38FC5

; ---------------------------------------------
ANIM_DROWNING: ; 17
.word  FRAME_43
 .byte  $00,$00
.word  FRAME_43
 .byte  $80,$00

; ---------------------------------------------
;PARADO:
;.word  FRAME_04
; .byte  $0A,$00  ; 38A03
;.word  FRAME_04
; .byte  $80,$00  ; 38A03

; ---------------------------------------------
CAMINAR_ACOSTADO_X1:
.word  FRAME_29
 .byte  $04,$00  ; 39183
.word  FRAME_2A
 .byte  $04,$00  ; 391CF
.word  FRAME_2B
 .byte  $04,$00  ; 3921B
.word  FRAME_2C
 .byte  $04,$00  ; 39267
.word  FRAME_2D
 .byte  $04,$00  ; 392AB
.word  FRAME_2E
 .byte  $04,$00  ; 392E7
.word  FRAME_2F
 .byte  $04,$00  ; 39333
.word  FRAME_2C
 .byte  $04,$00  ; 39267
.word  FRAME_2B
 .byte  $04,$00  ; 3921B
.word  FRAME_2A
 .byte  $81,$00  ; 391CF
CAMINAR_ACOSTADO_X2:
.word  FRAME_29
 .byte  $02,$00  ; 39183
.word  FRAME_2A
 .byte  $02,$00  ; 391CF
.word  FRAME_2B
 .byte  $02,$00  ; 3921B
.word  FRAME_2C
 .byte  $02,$00  ; 39267
.word  FRAME_2D
 .byte  $02,$00  ; 392AB
.word  FRAME_2E
 .byte  $02,$00  ; 392E7
.word  FRAME_2F
 .byte  $02,$00  ; 39333
.word  FRAME_2C
 .byte  $02,$00  ; 39267
.word  FRAME_2B
 .byte  $02,$00  ; 3921B
.word  FRAME_2A
 .byte  $81,$00  ; 391CF
CAMINAR_ACOSTADO_X3:
.word  FRAME_29
 .byte  $01,$00  ; 39183
.word  FRAME_2A
 .byte  $01,$00  ; 391CF
.word  FRAME_2B
 .byte  $01,$00  ; 3921B
.word  FRAME_2C
 .byte  $01,$00  ; 39267
.word  FRAME_2D 
.byte  $01,$00  ; 392AB
.word  FRAME_2E
 .byte  $01,$00  ; 392E7
.word  FRAME_2F
 .byte  $01,$00  ; 39333
.word  FRAME_2C
 .byte  $01,$00  ; 39267
.word  FRAME_2B
 .byte  $01,$00  ; 3921B
.word  FRAME_2A
 .byte  $81,$00  ; 391CF

; ---------------------------------------------
CORRER_ACOSTADO_X1:
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $81,$00  ; 393CB
CORRER_ACOSTADO_X2:
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $01,$00  ; 393CB
.word  FRAME_30
 .byte  $01,$00  ; 3937F
.word  FRAME_31
 .byte  $81,$00  ; 393CB

; ---------------------------------------------
CAMINAR_45_ARRIBA_X1:
.word  FRAME_33
 .byte  $04,$00  ; 3947B
.word  FRAME_34
 .byte  $04,$00  ; 394C7
.word  FRAME_35
 .byte  $04,$00  ; 39523
.word  FRAME_36
 .byte  $04,$00  ; 3957F
.word  FRAME_37
 .byte  $04,$00  ; 395CB
.word  FRAME_38
 .byte  $04,$00  ; 39627
.word  FRAME_39
 .byte  $04,$00  ; 39693
.word  FRAME_36
 .byte  $04,$00  ; 3957F
.word  FRAME_35
 .byte  $04,$00  ; 39523
.word  FRAME_34
 .byte  $81,$00  ; 394C7
CAMINAR_45_ARRIBA_X2:
.word  FRAME_33
 .byte  $02,$00  ; 3947B
.word  FRAME_34
 .byte  $02,$00  ; 394C7
.word  FRAME_35
 .byte  $02,$00  ; 39523
.word  FRAME_36
 .byte  $02,$00  ; 3957F
.word  FRAME_37
 .byte  $02,$00  ; 395CB
.word  FRAME_38
 .byte  $02,$00  ; 39627
.word  FRAME_39
 .byte  $02,$00  ; 39693
.word  FRAME_36
 .byte  $02,$00  ; 3957F
.word  FRAME_35
 .byte  $02,$00  ; 39523
.word  FRAME_34
 .byte  $81,$00  ; 394C7
CAMINAR_45_ARRIBA_X3:
.word  FRAME_33
 .byte  $01,$00  ; 3947B
.word  FRAME_34
 .byte  $01,$00  ; 394C7
.word  FRAME_35
 .byte  $01,$00  ; 39523
.word  FRAME_36
 .byte  $01,$00  ; 3957F
.word  FRAME_37
 .byte  $01,$00  ; 395CB
.word  FRAME_38
 .byte  $01,$00  ; 39627
.word  FRAME_39
 .byte  $01,$00  ; 39693
.word  FRAME_36
 .byte  $01,$00  ; 3957F
.word  FRAME_35
 .byte  $01,$00  ; 39523
.word  FRAME_34
 .byte  $81,$00  ; 394C7

; ---------------------------------------------
CORRER_45_ARRIBA_X1:
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A 
.byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $81,$00  ; 39747
CORRER_45_ARRIBA_X2:
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A 
.byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $01,$00  ; 39747
.word  FRAME_3A
 .byte  $01,$00  ; 396EF
.word  FRAME_3B
 .byte  $81,$00  ; 39747

; ---------------------------------------------
MOMENTUM_SPINDASH:
.word  FRAME_01
 .byte  $03,$00  ; 38985
.word  FRAME_02
 .byte  $03,$00  ; 389AF
.word  FRAME_03
 .byte  $03,$00  ; 389D9
.word  FRAME_01
 .byte  $80,$00  ; 38985

; ---------------------------------------------
CAMINAR_45_ABAJO_X1:
.word  FRAME_44
 .byte  $04,$00  ; 39908
.word  FRAME_45
 .byte  $04,$00  ; 39954
.word  FRAME_46
 .byte  $04,$00  ; 399B0
.word  FRAME_47
 .byte  $04,$00  ; 39A0C
.word  FRAME_48
 .byte  $04,$00  ; 39A58
.word  FRAME_49
 .byte  $04,$00  ; 39AB4
.word  FRAME_4A
 .byte  $04,$00  ; 39B20
.word  FRAME_47
 .byte  $04,$00  ; 39A0C
.word  FRAME_46
 .byte  $04,$00  ; 399B0
.word  FRAME_45
 .byte  $81,$00  ; 39954
CAMINAR_45_ABAJO_X2:
.word  FRAME_44
 .byte  $02,$00  ; 39908
.word  FRAME_45
 .byte  $02,$00  ; 39954
.word  FRAME_46
 .byte  $02,$00  ; 399B0
.word  FRAME_47
 .byte  $02,$00  ; 39A0C
.word  FRAME_48
 .byte  $02,$00  ; 39A58
.word  FRAME_49
 .byte  $02,$00  ; 39AB4
.word  FRAME_4A
 .byte  $02,$00  ; 39B20
.word  FRAME_47
 .byte  $02,$00  ; 39A0C
.word  FRAME_46
 .byte  $02,$00  ; 399B0
.word  FRAME_45
 .byte  $81,$00  ; 39954
CAMINAR_45_ABAJO_X3:
.word  FRAME_44
 .byte  $01,$00  ; 39908
.word  FRAME_45
 .byte  $01,$00  ; 39954
.word  FRAME_46
 .byte  $01,$00  ; 399B0
.word  FRAME_47
 .byte  $01,$00  ; 39A0C
.word  FRAME_48
 .byte  $01,$00  ; 39A58
.word  FRAME_49
 .byte  $01,$00  ; 39AB4
.word  FRAME_4A
 .byte  $01,$00  ; 39B20
.word  FRAME_47
 .byte  $01,$00  ; 39A0C
.word  FRAME_46
 .byte  $01,$00  ; 399B0
.word  FRAME_45
 .byte  $81,$00  ; 39954

; ---------------------------------------------
CORRER_45_ABAJO_X1:
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $81,$00  ; 39BD4
CORRER_45_ABAJO_X2:
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $01,$00  ; 39BD4
.word  FRAME_4B
 .byte  $01,$00  ; 39B7C
.word  FRAME_4C
 .byte  $81,$00  ; 39BD4

; ---------------------------------------------
TOMAR_AIRE:
.word  FRAME_00
 .byte  $01,$00  ; 38955
.word  FRAME_00
 .byte  $80,$00  ; 38955

; ---------------------------------------------

;	org	$84B3
spr_bank_attr_cfg:
.word  COLOR_00 ; 00 Punteros distribución de color sprites
.word  COLOR_01 ; 02
.word  COLOR_02 ; 04
.word  COLOR_03 ; 06
.word  COLOR_04 ; 08
.word  COLOR_05 ; 0A
.word  COLOR_06 ; 0C
.word  COLOR_07 ; 0E
.word  COLOR_22 ; 10

COLOR_00:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 1x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$01 ; 2x
.byte  $01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3x
.byte  $00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 4x
.byte  $01,$01,$01,$01,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_01:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01 ; 1x
.byte  $01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01 ; 2x
.byte  $01,$01,$01,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 3x
.byte  $01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 4x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_02:
.byte  $01,$01,$01,$00,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$01,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01 ; 1x
.byte  $01,$01,$01,$00,$00,$00,$00,$01,$01,$00,$01,$01,$00,$00,$00,$00 ; 2x
.byte  $00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 3x
.byte  $00,$01,$01,$00,$00,$01,$01,$00,$00,$00,$00,$01,$00,$00,$00,$00 ; 4x
.byte  $00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_03:
.byte  $01,$01,$01,$01,$00,$01,$01,$01,$01,$00,$01,$01,$01,$00,$01,$01 ; 0x
.byte  $01,$01,$00,$01,$01,$00,$00,$01,$01,$00,$00,$01,$01,$00,$00,$01 ; 1x
.byte  $01,$00,$00,$01,$01,$01,$00,$01,$01,$01,$00,$01,$01,$01,$00,$01 ; 2x
.byte  $01,$00,$00,$01,$01,$01,$00,$01,$01,$01,$00,$01,$01,$00,$01,$01 ; 3x
.byte  $01,$00,$01,$01,$01,$01,$00,$01,$01,$01,$00,$01,$01,$01,$00,$01 ; 4x
.byte  $01,$01,$01,$00,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_04:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$00,$01,$01,$01,$00,$01,$00,$01,$01,$01,$01,$01,$01,$00 ; 1x
.byte  $01,$01,$01,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 2x
.byte  $01,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$01,$01 ; 3x
.byte  $01,$01,$01,$01,$01,$00,$01,$01,$01,$00,$00,$00,$00,$01,$01,$01 ; 4x
.byte  $01,$01,$01,$00,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_05:
.byte  $01,$01,$01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$00,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 1x
.byte  $01,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 2x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 3x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$01,$00,$01 ; 4x
.byte  $00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$00,$01,$01,$01,$00,$01 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_06:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$00,$01,$01,$01,$00,$01,$00,$01,$01,$00,$00,$00 ; 1x
.byte  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01 ; 2x
.byte  $00,$00,$01,$01,$01,$01,$00,$01,$01,$01,$00,$00,$01,$01,$01,$01 ; 3x
.byte  $01,$01,$01,$00,$01,$01,$01,$01,$00,$01,$01,$01,$00,$00,$01,$01 ; 4x
.byte  $01,$01,$01,$00,$00,$00,$00,$00,$01,$01,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_07:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$00,$01,$00,$01,$01,$00,$00,$01,$00,$00,$00,$00,$00 ; 1x
.byte  $00,$00,$00,$00,$00,$01,$01,$00,$00,$01,$01,$00,$00,$01,$01,$01 ; 2x
.byte  $00,$00,$01,$01,$01,$00,$01,$01,$01,$01,$00,$01,$01,$01,$00,$00 ; 3x
.byte  $01,$01,$00,$00,$01,$01,$01,$00,$01,$00,$00,$01,$01,$01,$00,$01 ; 4x
.byte  $01,$01,$00,$01,$00,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

COLOR_22:
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$01 ; 0x
.byte  $01,$01,$01,$01,$01,$01,$00,$00,$00,$01,$01,$01,$01,$01,$01,$00 ; 1x
.byte  $01,$01,$01,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 2x
.byte  $01,$00,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$01,$01 ; 3x
.byte  $01,$01,$01,$01,$00,$01,$01,$01,$00,$01,$01,$00,$00,$01,$01,$01 ; 4x
.byte  $01,$01,$01,$00,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00 ; 5x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 6x
.byte  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 7x

; --------------------------------------------------------------------------------  ;Respirar burbuja 0x82810
FRAME_00:	.word FRAME_00_cfg, FRAME_00_cfg_h, FRAME_00_cfg, FRAME_00_cfg_h
; frame 00
FRAME_00_cfg:	.byte $03 ; X cnt
		.byte $05 ; Y cnt
		.byte $05 ; chr bank
		.byte $F4 ; X off
		.byte $D8 ; Y off

		.byte $45,$46,$FF
		.byte $48,$49,$4A
		.byte $4B,$4C,$4D
		.byte $4E,$4F,$50
		.byte $51,$52,$53
; frame 00 - hflip
FRAME_00_cfg_h:	.byte $03 ; X cnt
		.byte $05 ; Y cnt
		.byte $05 ; chr bank
		.byte $F4 ; X off
		.byte $D8 ; Y off
		
		.byte $FF,$46,$45
		.byte $4A,$49,$48
		.byte $4D,$4C,$4B
		.byte $50,$4F,$4E
		.byte $53,$52,$51
; -------------------------------------------------------------------------------- ;Momentum Spindash 01
FRAME_01: .word  FRA01_01, FRA01_02, FRA01_01, FRA01_02
FRA01_01: .byte  $04,$03,$05,$EC,$E8,$FF,$FF,$2E,$2F,$FF,$FF,$32,$33,$3B,$3C,$3D,$3E
FRA01_02: .byte  $04,$03,$05,$F4,$E8,$2F,$2E,$FF,$FF,$33,$32,$FF,$FF,$3E,$3D,$3C,$3B

FRAME_02: .word  FRA02_01, FRA02_02, FRA02_01, FRA02_02
FRA02_01: .byte  $04,$03,$05,$EC,$E8,$FF,$FF,$2E,$30,$34,$35,$36,$37,$3F,$40,$41,$3E
FRA02_02: .byte  $04,$03,$05,$F4,$E8,$30,$2E,$FF,$FF,$37,$36,$35,$34,$3E,$41,$40,$3F

FRAME_03: .word  FRA03_01, FRA03_02, FRA03_01, FRA03_02
FRA03_01: .byte  $04,$03,$05,$EC,$E8,$FF,$FF,$2E,$31,$38,$39,$36,$3A,$42,$43,$41,$44
FRA03_02: .byte  $04,$03,$05,$F4,$E8,$31,$2E,$FF,$FF,$3A,$36,$39,$38,$44,$41,$43,$42


; -------------------------------------------------------------------------------- ;Parado 0x80010
;FRAME_04: .word  FRA04_01, FRA04_02, FRA04_01, FRA04_02
;FRA04_01: .byte  $03,$05,$00,$F4,$D8,$01,$02,$FF,$05,$06,$FF,$15,$16,$17,$27,$28,$FF,$37,$38,$39
;FRA04_02: .byte  $03,$05,$00,$F4,$D8,$FF,$02,$01,$FF,$06,$05,$17,$16,$15,$FF,$28,$27,$39,$38,$37


; -------------------------------------------------------------------------------- ;Caminar
FRAME_05: .word  FRA05_01, FRA05_02, FRA05_03, FRA05_04
FRA05_01: .byte  $03,$04,$00,$F4,$E0,$07,$08,$FF,$18,$19,$1A,$29,$2A,$FF,$3A,$3B,$FF
FRA05_02: .byte  $03,$04,$00,$F4,$E0,$FF,$08,$07,$1A,$19,$18,$FF,$2A,$29,$FF,$3B,$3A
FRA05_03: .byte  $03,$04,$00,$F4,$00,$3A,$3B,$FF,$29,$2A,$FF,$18,$19,$1A,$07,$08,$FF
FRA05_04: .byte  $03,$04,$00,$F4,$00,$FF,$3B,$3A,$FF,$2A,$29,$1A,$19,$18,$FF,$08,$07

FRAME_06: .word  FRA06_01, FRA06_02, FRA06_03, FRA06_04
FRA06_01: .byte  $03,$04,$00,$F1,$E0,$09,$0A,$0B,$1B,$1C,$1D,$2B,$2C,$2D,$3C,$3D,$3E
FRA06_02: .byte  $03,$04,$00,$F7,$E0,$0B,$0A,$09,$1D,$1C,$1B,$2D,$2C,$2B,$3E,$3D,$3C
FRA06_03: .byte  $03,$04,$00,$F1,$00,$3C,$3D,$3E,$2B,$2C,$2D,$1B,$1C,$1D,$09,$0A,$0B
FRA06_04: .byte  $03,$04,$00,$F7,$00,$3E,$3D,$3C,$2D,$2C,$2B,$1D,$1C,$1B,$0B,$0A,$09

FRAME_07: .word  FRA07_01, FRA07_02, FRA07_03, FRA07_04
FRA07_01: .byte  $03,$04,$00,$F1,$E0,$0C,$0D,$0E,$1E,$1F,$20,$2E,$2F,$30,$3F,$40,$41
FRA07_02: .byte  $03,$04,$00,$F7,$E0,$0E,$0D,$0C,$20,$1F,$1E,$30,$2F,$2E,$41,$40,$3F
FRA07_03: .byte  $03,$04,$00,$F1,$00,$3F,$40,$41,$2E,$2F,$30,$1E,$1F,$20,$0C,$0D,$0E
FRA07_04: .byte  $03,$04,$00,$F7,$00,$41,$40,$3F,$30,$2F,$2E,$20,$1F,$1E,$0E,$0D,$0C

FRAME_08: .word  FRA08_01, FRA08_02, FRA08_03, FRA08_04
FRA08_01: .byte  $02,$04,$00,$F4,$E0,$0F,$10,$21,$22,$31,$32,$42,$43
FRA08_02: .byte  $02,$04,$00,$FC,$E0,$10,$0F,$22,$21,$32,$31,$43,$42
FRA08_03: .byte  $02,$04,$00,$F4,$00,$42,$43,$31,$32,$21,$22,$0F,$10
FRA08_04: .byte  $02,$04,$00,$FC,$00,$43,$42,$32,$31,$22,$21,$10,$0F

FRAME_09: .word  FRA09_01, FRA09_02, FRA09_03, FRA09_04
FRA09_01: .byte  $02,$05,$00,$F4,$D8,$03,$FF,$11,$12,$23,$24,$33,$34,$44,$45
FRA09_02: .byte  $02,$05,$00,$FC,$D8,$FF,$03,$12,$11,$24,$23,$34,$33,$45,$44
FRA09_03: .byte  $02,$05,$00,$F4,$00,$44,$45,$33,$34,$23,$24,$11,$12,$03,$FF
FRA09_04: .byte  $02,$05,$00,$FC,$00,$45,$44,$34,$33,$24,$23,$12,$11,$FF,$03

FRAME_0A: .word  FRA0A_01, FRA0A_02, FRA0A_03, FRA0A_04
FRA0A_01: .byte  $03,$04,$00,$F1,$E0,$46,$47,$48,$4C,$4D,$4E,$52,$53,$54,$58,$59,$5A
FRA0A_02: .byte  $03,$04,$00,$F7,$E0,$48,$47,$46,$4E,$4D,$4C,$54,$53,$52,$5A,$59,$58
FRA0A_03: .byte  $03,$04,$00,$F1,$00,$58,$59,$5A,$52,$53,$54,$4C,$4D,$4E,$46,$47,$48
FRA0A_04: .byte  $03,$04,$00,$F7,$00,$5A,$59,$58,$54,$53,$52,$4E,$4D,$4C,$48,$47,$46

FRAME_0B: .word  FRA0B_01, FRA0B_02, FRA0B_03, FRA0B_04
FRA0B_01: .byte  $03,$04,$00,$F1,$E0,$49,$4A,$4B,$4F,$50,$51,$55,$56,$57,$5B,$5C,$5D
FRA0B_02: .byte  $03,$04,$00,$F7,$E0,$4B,$4A,$49,$51,$50,$4F,$57,$56,$55,$5D,$5C,$5B
FRA0B_03: .byte  $03,$04,$00,$F1,$00,$5B,$5C,$5D,$55,$56,$57,$4F,$50,$51,$49,$4A,$4B
FRA0B_04: .byte  $03,$04,$00,$F7,$00,$5D,$5C,$5B,$57,$56,$55,$51,$50,$4F,$4B,$4A,$49


; -------------------------------------------------------------------------------- ;Correr 0x83810
FRAME_0C: .word  FRA0C_01, FRA0C_02, FRA0C_03, FRA0C_04
FRA0C_01: .BYTE  $03,$04,$07,$F4,$E0,$FF,$04,$05,$0A,$0B,$0C,$13,$14,$15,$1C,$1D,$1E
FRA0C_02: .BYTE  $03,$04,$07,$F4,$E0,$05,$04,$FF,$0C,$0B,$0A,$15,$14,$13,$1E,$1D,$1C
FRA0C_03: .BYTE  $03,$04,$07,$F4,$00,$1C,$1D,$1E,$13,$14,$15,$0A,$0B,$0C,$FF,$04,$05
FRA0C_04: .byte  $03,$04,$07,$F4,$00,$1E,$1D,$1C,$15,$14,$13,$0C,$0B,$0A,$05,$04,$FF

FRAME_0D: .word  FRA0D_01, FRA0D_02, FRA0D_03, FRA0D_04
FRA0D_01: .byte  $03,$05,$07,$F4,$D8,$FF,$FF,$FF,$FF,$06,$07,$0D,$0E,$0F,$16,$17,$18,$1F,$20,$21
FRA0D_02: .byte  $03,$05,$07,$F4,$D8,$FF,$FF,$FF,$07,$06,$FF,$0F,$0E,$0D,$18,$17,$16,$21,$20,$1F
FRA0D_03: .byte  $03,$05,$07,$F4,$00,$21,$20,$1F,$18,$17,$16,$0F,$0E,$0D,$07,$06,$FF,$FF,$FF,$FF
FRA0D_04: .byte  $03,$05,$07,$F4,$00,$1F,$20,$21,$16,$17,$18,$0D,$0E,$0F,$FF,$06,$07,$FF,$FF,$FF

FRAME_0E: .word  FRA0E_01, FRA0E_02, FRA0E_03, FRA0E_04
FRA0E_01: .byte  $03,$05,$07,$F4,$D8,$FF,$FF,$FF,$FF,$08,$09,$10,$11,$12,$19,$1A,$1B,$22,$23,$24
FRA0E_02: .byte  $03,$05,$07,$F4,$D8,$FF,$FF,$FF,$09,$08,$FF,$12,$11,$10,$1B,$1A,$19,$24,$23,$22
FRA0E_03: .byte  $03,$05,$07,$F4,$E0,$22,$23,$24,$19,$1A,$1B,$10,$11,$12,$FF,$08,$09,$FF,$FF,$FF
FRA0E_04: .byte  $03,$05,$07,$F4,$E0,$24,$23,$22,$1B,$1A,$19,$12,$11,$10,$09,$08,$FF,$FF,$FF,$FF


; -------------------------------------------------------------------------------- ;Salto 0x80810
FRAME_0F: .word  FRA0F_01, FRA0F_02, FRA0F_01, FRA0F_02
FRA0F_01: .byte  $02,$05,$01,$F8,$E0,$01,$02,$06,$07,$0D,$0E,$1B,$1C,$27,$28
FRA0F_02: .byte  $02,$05,$01,$F8,$E0,$02,$01,$07,$06,$0E,$0D,$1C,$1B,$28,$27


; -------------------------------------------------------------------------------- ;Frenar 0x81010
; SKID
FRAME_10: .word  FRA10_01, FRA10_02, FRA10_01, FRA10_02

FRA10_01: .byte  $04 ; X cnt
	  .byte  $04 ; Y cnt
	  .byte  $05 ; chr bank
	  .byte  $F4 ; X off
	  .byte  $E0 ; Y off
	  .byte  $FF,$54,$55,$FF
	  .byte  $5F,$56,$57,$FF
	  .byte  $FF,$58,$59,$5A
	  .byte  $5B,$5C,$5D,$5E

; frame 10 - hflip
FRA10_02: .byte  $04 ; X cnt
	  .byte  $04 ; Y cnt
	  .byte  $05 ; chr bank
	  .byte  $F4 ; X off
	  .byte  $E0 ; Y off
	  .byte  $FF,$55,$54,$FF
	  .byte  $FF,$57,$56,$5F
	  .byte  $5A,$59,$58,$FF
	  .byte  $5E,$5D,$5C,$5B
	  
; SKID2
FRAME_54: .word  FRA54_01, FRA54_02, FRA54_01, FRA54_02

FRA54_01: .byte  $04 ; X cnt
	  .byte  $04 ; Y cnt
	  .byte  $05 ; chr bank
	  .byte  $F4 ; X off
	  .byte  $E0 ; Y off
	  .byte  $FF,$1A,$1B,$FF
	  .byte  $FF,$25,$57,$FF
	  .byte  $26,$27,$59,$5A
	  .byte  $28,$29,$2A,$5E

; frame 54 - hflip
FRA54_02: .byte  $04 ; X cnt
	  .byte  $04 ; Y cnt
	  .byte  $05 ; chr bank
	  .byte  $F4 ; X off
	  .byte  $E0 ; Y off
	  .byte  $FF,$1B,$1A,$FF
	  .byte  $FF,$57,$25,$FF
	  .byte  $5A,$59,$27,$26
	  .byte  $5E,$2A,$29,$28	  
	  
; -------------------------------------------------------------------------------- ;Muerte 0x80810
FRAME_11: .word  FRA11_01, FRA11_01, FRA11_01, FRA11_01
FRA11_01: .byte  $03,$05,$01,$F4,$E0,$03,$04,$05,$08,$09,$0A,$0F,$10,$11,$1D,$1E,$5F,$29,$2A,$2B


; -------------------------------------------------------------------------------- ;Agacharse
FRAME_12: .word  FRA12_01, FRA12_02, FRA12_01, FRA12_02
FRA12_01: .byte  $02,$04,$01,$F8,$E0,$0B,$0C,$12,$13,$1F,$20,$2C,$2D ;Agachándose
FRA12_02: .byte  $02,$04,$01,$F8,$E0,$0C,$0B,$13,$12,$20,$1F,$2D,$2C

FRAME_13: .word  FRA13_01, FRA13_02, FRA13_01, FRA13_02
FRA13_01: .byte  $03,$03,$01,$F6,$E8,$14,$15,$16,$21,$22,$23,$2E,$2F,$30 ;Agachado
FRA13_02: .byte  $03,$03,$01,$F2,$E8,$16,$15,$14,$23,$22,$21,$30,$2F,$2E


; -------------------------------------------------------------------------------- ;GET_HIT_ANIM
FRAME_14: .word  FRA14_01, FRA14_02, FRA14_01, FRA14_02

FRA14_01: .byte  $04 ; x tiles cnt
	  .byte  $03 ; y tiles cnt
	  .byte  $01 ; bank
	  .byte  $F4 ; x off
	  .byte  $E8 ; y off
	  .byte  $17,$18,$19,$1A
	  .byte  $FF,$24,$25,$26
	  .byte  $FF,$31,$32,$33
	  
FRA14_02: .byte  $04 ; x tiles cnt
	  .byte  $03 ; y tiles cnt
	  .byte  $01 ; bank
	  .byte  $F4 ; x off
	  .byte  $E8 ; y off
	  .byte  $1A,$19,$18,$17
	  .byte  $26,$25,$24,$FF
	  .byte  $33,$32,$31,$FF
; -------------------------------------------------------------------------------- ;WATERFALL_ANIM
FRAME_53: .word  FRA53_01, FRA53_02, FRA53_01, FRA53_02

FRA53_01: .byte  $04 ; x tiles cnt
	  .byte  $03 ; y tiles cnt
	  .byte  $02 ; bank
	  .byte  $F4 ; x off
	  .byte  $E8 ; y off
	  .byte  $3A,$3B,$3C,$3D
	  .byte  $41,$42,$43,$44
	  .byte  $FF,$45,$46,$47
	  
FRA53_02: .byte  $04 ; x tiles cnt
	  .byte  $03 ; y tiles cnt
	  .byte  $02 ; bank
	  .byte  $F4 ; x off
	  .byte  $E8 ; y off
	  .byte  $3D,$3C,$3B,$3A
	  .byte  $44,$43,$42,$41
	  .byte  $47,$46,$45,$FF
; -------------------------------------------------------------------------------- ;Empujar
FRAME_15: .word  FRA15_01, FRA15_02, FRA15_01, FRA15_02
FRA15_01: .byte  $02,$04,$01,$F8,$E0,$34,$35,$38,$39,$3C,$3D,$45,$46
FRA15_02: .byte  $02,$04,$01,$F8,$E0,$35,$34,$39,$38,$3D,$3C,$46,$45

FRAME_16: .word  FRA16_01, FRA16_02, FRA16_01, FRA16_02
FRA16_01: .byte  $03,$04,$01,$F0,$E0,$FF,$36,$37,$FF,$3A,$3B,$FF,$3E,$3F,$47,$48,$49
FRA16_02: .byte  $03,$04,$01,$F8,$E0,$37,$36,$FF,$3B,$3A,$FF,$3F,$3E,$FF,$49,$48,$47

FRAME_17: .word  FRA17_01, FRA17_02, FRA17_01, FRA17_02
FRA17_01: .byte  $03,$04,$01,$F0,$E0,$FF,$34,$35,$FF,$38,$39,$FF,$40,$41,$4A,$4B,$4C
FRA17_02: .byte  $03,$04,$01,$F8,$E0,$35,$34,$FF,$39,$38,$FF,$41,$40,$FF,$4C,$4B,$4A

FRAME_18: .word  FRA18_01, FRA18_02, FRA18_01, FRA18_02
FRA18_01: .byte  $03,$04,$01,$F0,$E0,$FF,$36,$37,$FF,$3A,$3B,$FF,$43,$44,$4D,$4E,$4F
FRA18_02: .byte  $03,$04,$01,$F8,$E0,$37,$36,$FF,$3B,$3A,$FF,$44,$43,$FF,$4F,$4E,$4D


; -------------------------------------------------------------------------------- ;Esperando
FRAME_19: .word  FRA19_01, FRA19_02, FRA19_01, FRA19_02
FRA19_01: .byte  $03,$04,$01,$F4,$E0,$50,$51,$FF,$53,$54,$FF,$57,$58,$FF,$5A,$5B,$5C
FRA19_02: .byte  $03,$04,$01,$F4,$E0,$FF,$51,$50,$FF,$54,$53,$FF,$58,$57,$5C,$5B,$5A
;         .byte  $03,$04,$01,$F8,$20,$5A,$5B,$5C,$57,$58,$FF,$53,$54,$FF,$50,$51,$FF
;         .byte  $03,$04,$01,$F8,$E0,$5C,$5B,$5A,$FF,$58,$57,$FF,$54,$53,$FF,$51,$50

FRAME_1A: .word  FRA1A_01, FRA1A_02, FRA1A_01, FRA1A_02
FRA1A_01: .byte  $03,$04,$01,$F4,$E0,$50,$52,$FF,$53,$55,$FF,$57,$58,$FF,$5A,$5B,$5C
FRA1A_02: .byte  $03,$04,$01,$F4,$E0,$FF,$52,$50,$FF,$55,$53,$FF,$58,$57,$5C,$5B,$5A
;         .byte  $03,$04,$01,$F8,$20,$5A,$5B,$5C,$57,$58,$FF,$53,$55,$FF,$50,$52,$FF
;         .byte  $03,$04,$01,$F8,$E0,$5C,$5B,$5A,$FF,$58,$57,$FF,$55,$53,$FF,$52,$50

FRAME_1B: .word  FRA1B_01, FRA1B_02, FRA1B_01, FRA1B_02
FRA1B_01: .byte  $03,$04,$01,$F4,$E0,$50,$52,$FF,$42,$56,$FF,$57,$59,$FF,$5A,$5B,$5C
FRA1B_02: .byte  $03,$04,$01,$F4,$E0,$FF,$52,$50,$FF,$56,$42,$FF,$59,$57,$5C,$5B,$5A

FRAME_1C: .word  FRA1C_01, FRA1C_02, FRA1C_01, FRA1C_02
FRA1C_01: .byte  $03,$04,$01,$F4,$E0,$50,$52,$FF,$53,$55,$FF,$57,$58,$FF,$5A,$5D,$5E
FRA1C_02: .byte  $03,$04,$01,$F4,$E0,$FF,$52,$50,$FF,$55,$53,$FF,$58,$57,$5E,$5D,$5A


; -------------------------------------------------------------------------------- ;Acostarse 0x83010
FRAME_1D: .word  FRA1D_01, FRA1D_02, FRA1D_01, FRA1D_02
FRA1D_01: .byte  $03,$04,$06,$F0,$E0,$2B,$2C,$2D,$3C,$3D,$3E,$4E,$4F,$50,$FF,$5C,$5D ;Recostándose
FRA1D_02: .byte  $03,$04,$06,$F8,$E0,$2D,$2C,$2B,$3E,$3D,$3C,$50,$4F,$4E,$5D,$5C,$FF

FRAME_1E: .word  FRA1E_01, FRA1E_02, FRA1E_01, FRA1E_02
FRA1E_01: .byte  $04,$03,$07,$E8,$E8,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$55,$56,$57,$58 ;Recostado 0x83810
FRA1E_02: .byte  $04,$03,$07,$F8,$E8,$4E,$4D,$4C,$4B,$52,$51,$50,$4F,$58,$57,$56,$55

FRAME_1F: .word  FRA1F_01, FRA1F_02, FRA1F_01, FRA1F_02
FRA1F_01: .byte  $04,$03,$07,$E8,$E8,$4B,$4C,$4D,$FF,$4F,$50,$53,$54,$55,$56,$57,$59
FRA1F_02: .byte  $04,$03,$07,$F8,$E8,$FF,$4D,$4C,$4B,$54,$53,$50,$4F,$59,$57,$56,$55


; -------------------------------------------------------------------------------- ;Equilibrarse 0x81010
;FRAME_20: .word  FRA20_01, FRA20_02, FRA20_01, FRA20_02
;FRA20_01: .byte  $03,$04,$02,$F4,$E0,$00,$02,$08,$01,$03,$09,$04,$06,$0C,$05,$07,$0D ;Somari
;FRA20_02: .byte  $03,$04,$02,$F4,$E0,$08,$02,$00,$09,$03,$01,$0C,$06,$04,$0D,$07,$05

;FRAME_21: .word  FRA21_01, FRA21_02, FRA21_01, FRA21_02
;FRA21_01: .byte  $03,$04,$02,$F4,$E0,$FF,$10,$12,$0B,$11,$13,$0E,$14,$16,$0F,$15,$17
;FRA21_02: .byte  $03,$04,$02,$F4,$E0,$12,$10,$FF,$13,$11,$0B,$16,$14,$0E,$17,$15,$0F

;FRAME_22: .word  FRA22_01, FRA22_02, FRA22_01, FRA22_02
;FRA22_01: .byte  $03,$04,$02,$F4,$E0,$FF,$1A,$20,$19,$1B,$21,$1C,$1E,$24,$1D,$1F,$25
;FRA22_02: .byte  $03,$04,$02,$F4,$E0,$20,$1A,$FF,$21,$1B,$19,$24,$1E,$1C,$25,$1F,$1D
; --------------------
;FRAME_23: .word  FRA23_01, FRA23_02, FRA23_01, FRA23_02
;FRA23_01: .byte  $03,$04,$02,$F4,$E0,$FF,$28,$2A,$23,$29,$2B,$26,$2C,$FF,$27,$2D,$FF
;FRA23_02: .byte  $03,$04,$02,$F4,$E0,$2A,$28,$FF,$2B,$29,$23,$FF,$2C,$26,$FF,$2D,$27

;FRAME_24: .word  FRA24_01, FRA24_02, FRA24_01, FRA24_02
;FRA24_01: .byte  $03,$04,$02,$F4,$E0,$FF,$32,$38,$31,$33,$39,$34,$36,$3C,$27,$2D,$FF
;FRA24_02: .byte  $03,$04,$02,$F4,$E0,$38,$32,$FF,$39,$33,$31,$3C,$36,$34,$FF,$2D,$27
;
;FRAME_25: .word  FRA25_01, FRA25_02, FRA25_01, FRA25_02
;FRA25_01: .byte  $03,$04,$02,$F4,$E0,$FF,$3A,$0A,$2E,$3B,$18,$2F,$3E,$22,$27,$2D,$FF
;FRA25_02: .byte  $03,$04,$02,$F4,$E0,$0A,$3A,$FF,$18,$3B,$2E,$22,$3E,$2F,$FF,$2D,$27

;FRAME_26: .word  FRA26_01, FRA26_02, FRA26_01, FRA26_02
;FRA26_01: .byte  $03,$04,$02,$F4,$E0,$FF,$32,$38,$35,$30,$39,$3F,$3D,$37,$27,$2D,$FF
;FRA26_02: .byte  $03,$04,$02,$F4,$E0,$38,$32,$FF,$39,$30,$35,$37,$3D,$3F,$FF,$2D,$27
; --------------------
;FRAME_27: .word  FRA27_01, FRA27_02, FRA27_01, FRA27_02
;FRA27_01: .byte  $02,$04,$02,$F8,$E0,$40,$42,$41,$43,$44,$46,$45,$47
;FRA27_02: .byte  $02,$04,$02,$F8,$E0,$42,$40,$43,$41,$46,$44,$47,$45

;FRAME_28: .word  FRA28_01, FRA28_02, FRA28_01, FRA28_02
;FRA28_01: .byte  $02,$04,$02,$F8,$E0,$48,$4A,$49,$4B,$4C,$4E,$4D,$4F
;FRA28_02: .byte  $02,$04,$02,$F8,$E0,$4A,$48,$4B,$49,$4E,$4C,$4F,$4D


; -------------------------------------------------------------------------------- ; Caminar acostado 0x81810
FRAME_29: .word  FRA29_01, FRA29_02, FRA29_03, FRA29_04
FRA29_01: .byte  $04,$03,$03,$E8,$F4,$FF,$3B,$FF,$FF,$3E,$3F,$40,$41,$4B,$4C,$4D,$4E
FRA29_02: .byte  $04,$03,$03,$FA,$F4,$FF,$FF,$3B,$FF,$41,$40,$3F,$3E,$4E,$4D,$4C,$4B
FRA29_03: .byte  $04,$03,$03,$E8,$F4,$4B,$4C,$4D,$4E,$3E,$3F,$40,$41,$FF,$3B,$FF,$FF
FRA29_04: .byte  $04,$03,$03,$FA,$F4,$4E,$4D,$4C,$4B,$41,$40,$3F,$3E,$FF,$FF,$3B,$FF

FRAME_2A: .word  FRA2A_01, FRA2A_02, FRA2A_03, FRA2A_04
FRA2A_01: .byte  $04,$03,$03,$E8,$F0,$1F,$20,$21,$22,$2B,$2C,$2D,$2E,$37,$38,$39,$3A
FRA2A_02: .byte  $04,$03,$03,$FA,$F0,$22,$21,$20,$1F,$2E,$2D,$2C,$2B,$3A,$39,$38,$37
FRA2A_03: .byte  $04,$03,$03,$E8,$F0,$37,$38,$39,$3A,$2B,$2C,$2D,$2E,$1F,$20,$21,$22
FRA2A_04: .byte  $04,$03,$03,$FA,$F0,$3A,$39,$38,$37,$2E,$2D,$2C,$2B,$22,$21,$20,$1F

FRAME_2B: .word  FRA2B_01, FRA2B_02, FRA2B_03, FRA2B_04
FRA2B_01: .byte  $04,$03,$03,$E8,$F4,$17,$18,$19,$1A,$23,$24,$25,$26,$2F,$30,$31,$32
FRA2B_02: .byte  $04,$03,$03,$FA,$F4,$1A,$19,$18,$17,$26,$25,$24,$23,$32,$31,$30,$2F
FRA2B_03: .byte  $04,$03,$03,$E8,$F4,$2F,$30,$31,$32,$23,$24,$25,$26,$17,$18,$19,$1A
FRA2B_04: .byte  $04,$03,$03,$FA,$F4,$32,$31,$30,$2F,$26,$25,$24,$23,$1A,$19,$18,$17

FRAME_2C: .word  FRA2C_01, FRA2C_02, FRA2C_03, FRA2C_04
FRA2C_01: .byte  $05,$02,$03,$E0,$F8,$FF,$06,$07,$08,$09,$FF,$0F,$10,$11,$12
FRA2C_02: .byte  $05,$02,$03,$FA,$F8,$09,$08,$07,$06,$FF,$12,$11,$10,$0F,$FF
FRA2C_03: .byte  $05,$02,$03,$E0,$F8,$FF,$0F,$10,$11,$12,$FF,$06,$07,$08,$09
FRA2C_04: .byte  $05,$02,$03,$FA,$F8,$12,$11,$10,$0F,$FF,$09,$08,$07,$06,$FF

FRAME_2D: .word  FRA2D_01, FRA2D_02, FRA2D_03, FRA2D_04
FRA2D_01: .byte  $04,$02,$03,$E8,$F8,$47,$48,$49,$4A,$54,$55,$56,$57
FRA2D_02: .byte  $04,$02,$03,$FA,$F8,$4A,$49,$48,$47,$57,$56,$55,$54
FRA2D_03: .byte  $04,$02,$03,$E8,$F8,$54,$55,$56,$57,$47,$48,$49,$4A
FRA2D_04: .byte  $04,$02,$03,$FA,$F8,$57,$56,$55,$54,$4A,$49,$48,$47

FRAME_2E: .word  FRA2E_01, FRA2E_02, FRA2E_03, FRA2E_04
FRA2E_01: .byte  $04,$03,$03,$E8,$F0,$1B,$1C,$1D,$1E,$27,$28,$29,$2A,$33,$34,$35,$36
FRA2E_02: .byte  $04,$03,$03,$FA,$F0,$1E,$1D,$1C,$1B,$2A,$29,$28,$27,$36,$35,$34,$33
FRA2E_03: .byte  $04,$03,$03,$E8,$F0,$33,$34,$35,$36,$27,$28,$29,$2A,$1B,$1C,$1D,$1E
FRA2E_04: .byte  $04,$03,$03,$FA,$F0,$36,$35,$34,$33,$2A,$29,$28,$27,$1E,$1D,$1C,$1B

FRAME_2F: .word  FRA2F_01, FRA2F_02, FRA2F_03, FRA2F_04
FRA2F_01: .byte  $04,$03,$03,$E8,$F4,$01,$02,$03,$04,$0A,$0B,$0C,$0D,$13,$14,$15,$16
FRA2F_02: .byte  $04,$03,$03,$FA,$F4,$04,$03,$02,$01,$0D,$0C,$0B,$0A,$16,$15,$14,$13
FRA2F_03: .byte  $04,$03,$03,$E8,$F4,$13,$14,$15,$16,$0A,$0B,$0C,$0D,$01,$02,$03,$04
FRA2F_04: .byte  $04,$03,$03,$FA,$F4,$16,$15,$14,$13,$0D,$0C,$0B,$0A,$04,$03,$02,$01


; -------------------------------------------------------------------------------- ;Correr Acostado 0x83810
FRAME_30: .word  FRA30_01, FRA30_02, FRA30_03, FRA30_04
FRA30_01: .byte  $04,$03,$07,$E8,$F4,$25,$26,$27,$28,$32,$33,$34,$35,$40,$41,$42,$43
FRA30_02: .byte  $04,$03,$07,$FA,$F4,$28,$27,$26,$25,$35,$34,$33,$32,$43,$42,$41,$40
FRA30_03: .byte  $04,$03,$07,$E8,$F4,$40,$41,$42,$43,$32,$33,$34,$35,$25,$26,$27,$28
FRA30_04: .byte  $04,$03,$07,$FA,$F4,$43,$42,$41,$40,$35,$34,$33,$32,$28,$27,$26,$25
FRAME_31: .word  FRA31_01, FRA31_02, FRA31_03, FRA31_04
FRA31_01: .byte  $05,$03,$07,$E0,$F4,$FF,$29,$2A,$2B,$2C,$FF,$37,$38,$39,$3A,$FF,$44,$45,$46,$47
FRA31_02: .byte  $05,$03,$07,$FA,$F4,$2C,$2B,$2A,$29,$FF,$3A,$39,$38,$37,$FF,$47,$46,$45,$44,$FF
FRA31_03: .byte  $05,$03,$07,$E0,$F4,$FF,$44,$45,$46,$47,$FF,$37,$38,$39,$3A,$FF,$29,$2A,$2B,$2C
FRA31_04: .byte  $05,$03,$07,$FA,$F4,$47,$46,$45,$44,$FF,$3A,$39,$38,$37,$FF,$2C,$2B,$2A,$29,$FF

;FRAME_32: .word  FRA32_01, FRA32_02, FRA32_03, FRA32_04
;FRA32_01: .byte  $05,$03,$07,$E8,$F4,$FF,$2E,$2F,$30,$31,$FF,$3C,$3D,$3E,$3F,$FF,$FF,$48,$49,$4A ; No utilizado - Error de paleta
;FRA32_02: .byte  $05,$03,$07,$FA,$F4,$31,$30,$2F,$2E,$FF,$3F,$3E,$3D,$3C,$FF,$4A,$49,$48,$FF,$FF
;FRA32_03: .byte  $05,$03,$07,$E0,$F4,$FF,$FF,$48,$49,$4A,$FF,$3C,$3D,$3E,$3F,$FF,$2E,$2F,$30,$31
;FRA32_04: .byte  $05,$03,$07,$FA,$F4,$4A,$49,$48,$FF,$FF,$3F,$3E,$3D,$3C,$FF,$31,$30,$2F,$2E,$FF


; -------------------------------------------------------------------------------- ; Caminar 45º Arriba 0x82010
FRAME_33: .word  FRA33_01, FRA33_02, FRA33_03, FRA33_04
FRA33_01: .byte  $03,$04,$04,$E8,$E8,$01,$02,$03,$04,$05,$06,$07,$08,$09,$FF,$0A,$0B ;Error de paleta
FRA33_02: .byte  $03,$04,$04,$F8,$E8,$03,$02,$01,$06,$05,$04,$09,$08,$07,$0B,$0A,$FF
FRA33_03: .byte  $03,$04,$04,$E8,$00,$FF,$0A,$0B,$07,$08,$09,$04,$05,$06,$01,$02,$03
FRA33_04: .byte  $03,$04,$04,$F8,$F8,$0B,$0A,$FF,$09,$08,$07,$06,$05,$04,$03,$02,$01

FRAME_34: .word  FRA34_01, FRA34_02, FRA34_03, FRA34_04

FRA34_01: .byte  $04,$04,$04,$E8,$E8 ; normal
	  .byte  $0C,$0D,$0E,$FF
	  .byte  $0F,$10,$11,$12
	  .byte  $13,$14,$15,$16
	  .byte  $FF,$17,$18,$FF
	  
FRA34_02: .byte  $04,$04,$04,$F8,$E8 ; H-flip
	  .byte  $FF,$0E,$0D,$0C
	  .byte  $12,$11,$10,$0F
	  .byte  $16,$15,$14,$13
	  .byte  $FF,$18,$17,$FF
	  
FRA34_03: .byte  $04,$04,$04,$E8,$00 ; V-flip
	  .byte  $FF,$17,$18,$FF
	  .byte  $13,$14,$15,$16
	  .byte  $0F,$10,$11,$12
	  .byte  $0C,$0D,$0E,$FF
	  
FRA34_04: .byte  $04,$04,$04,$F8,$F8 ; HV-flip
	  .byte  $FF,$18,$17,$FF
	  .byte  $16,$15,$14,$13
	  .byte  $12,$11,$10,$0F
	  .byte  $FF,$0E,$0D,$0C

FRAME_35: .word  FRA35_01, FRA35_02, FRA35_03, FRA35_04
FRA35_01: .byte  $04,$04,$04,$E8,$E8,$19,$1A,$1B,$FF,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$FF,$24,$25,$26
FRA35_02: .byte  $04,$04,$04,$F8,$E8,$FF,$1B,$1A,$19,$1F,$1E,$1D,$1C,$23,$22,$21,$20,$26,$25,$24,$FF
FRA35_03: .byte  $04,$04,$04,$E8,$00,$FF,$24,$25,$26,$20,$21,$22,$23,$1C,$1D,$1E,$1F,$19,$1A,$1B,$FF
FRA35_04: .byte  $04,$04,$04,$F8,$F8,$26,$25,$24,$FF,$23,$22,$21,$20,$1F,$1E,$1D,$1C,$FF,$1B,$1A,$19

FRAME_36: .word  FRA36_01, FRA36_02, FRA36_03, FRA36_04
FRA36_01: .byte  $03,$04,$04,$E8,$E8,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$FF,$30,$31
FRA36_02: .byte  $03,$04,$04,$F8,$E8,$29,$28,$27,$2C,$2B,$2A,$2F,$2E,$2D,$31,$30,$FF
FRA36_03: .byte  $03,$04,$04,$E8,$00,$FF,$30,$31,$2D,$2E,$2F,$2A,$2B,$2C,$27,$28,$29
FRA36_04: .byte  $03,$04,$04,$F8,$F8,$31,$30,$FF,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27

FRAME_37: .word  FRA37_01, FRA37_02, FRA37_03, FRA37_04
FRA37_01: .byte  $04,$04,$04,$E8,$E8,$32,$33,$34,$FF,$35,$36,$37,$38,$FF,$39,$3A,$3B,$FF,$FF,$3C,$3D
FRA37_02: .byte  $04,$04,$04,$F8,$E8,$FF,$34,$33,$32,$38,$37,$36,$35,$3B,$3A,$39,$FF,$3D,$3C,$FF,$FF

FRA37_03: .byte  $04,$04,$04,$E8,$00,$FF,$FF,$3C,$3D,$FF,$39,$3A,$3B,$35,$36,$37,$38,$32,$33,$34,$FF
FRA37_04: .byte  $04,$04,$04,$F8,$F8,$3D,$3C,$FF,$FF,$3B,$3A,$39,$FF,$38,$37,$36,$35,$FF,$34,$33,$32

FRAME_38: .word  FRA38_01, FRA38_02, FRA38_03, FRA38_04
FRA38_01: .byte  $04,$05,$04,$E8,$E8,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$FF,$4A,$4B,$FF,$FF,$FF,$4C,$FF
FRA38_02: .byte  $04,$05,$04,$F8,$E8,$41,$40,$3F,$3E,$45,$44,$43,$42,$49,$48,$47,$46,$FF,$4B,$4A,$FF,$FF,$4C,$FF,$FF
FRA38_03: .byte  $04,$05,$04,$E8,$00,$FF,$FF,$4C,$FF,$FF,$4A,$4B,$FF,$46,$47,$48,$49,$42,$43,$44,$45,$3E,$3F,$40,$41
FRA38_04: .byte  $04,$05,$04,$F8,$F8,$FF,$4C,$FF,$FF,$FF,$4B,$4A,$FF,$49,$48,$47,$46,$45,$44,$43,$42,$41,$40,$3F,$3E

FRAME_39: .word  FRA39_01, FRA39_02, FRA39_03, FRA39_04
FRA39_01: .byte  $04,$04,$04,$E8,$E8,$4D,$4E,$4F,$FF,$50,$51,$52,$53,$54,$55,$56,$57,$FF,$58,$59,$5A
FRA39_02: .byte  $04,$04,$04,$F8,$E8,$FF,$4F,$4E,$4D,$53,$52,$51,$50,$57,$56,$55,$54,$5A,$59,$58,$FF
FRA39_03: .byte  $04,$04,$04,$E8,$00,$FF,$58,$59,$5A,$54,$55,$56,$57,$50,$51,$52,$53,$4D,$4E,$4F,$FF
FRA39_04: .byte  $04,$04,$04,$F8,$F8,$5A,$59,$58,$FF,$57,$56,$55,$54,$53,$52,$51,$50,$FF,$4F,$4E,$4D


; -------------------------------------------------------------------------------- ;Correr 45º Arriba 0x83010
FRAME_3A: .word  FRA3A_01, FRA3A_02, FRA3A_03, FRA3A_04
FRA3A_01: .byte  $03,$05,$06,$F0,$DC,$FF,$FF,$FF,$06,$07,$08,$0F,$10,$11,$18,$19,$1A,$21,$22,$23
FRA3A_02: .byte  $03,$05,$06,$F4,$DC,$FF,$FF,$FF,$08,$07,$06,$11,$10,$0F,$1A,$19,$18,$23,$22,$21
FRA3A_03: .byte  $03,$05,$06,$F0,$F8,$21,$22,$23,$18,$19,$1A,$0F,$10,$11,$06,$07,$08,$FF,$FF,$FF
FRA3A_04: .byte  $03,$05,$06,$F8,$F8,$23,$22,$21,$1A,$19,$18,$11,$10,$0F,$08,$07,$06,$FF,$FF,$FF

FRAME_3B: .word  FRA3B_01, FRA3B_02, FRA3B_03, FRA3B_04
FRA3B_01: .byte  $04,$05,$06,$EA,$DE,$FF,$FF,$FF,$FF,$09,$0A,$0B,$FF,$FF,$12,$13,$14,$FF,$1B,$1C,$1D,$FF,$24,$25,$26
FRA3B_02: .byte  $04,$05,$06,$F4,$DE,$FF,$FF,$FF,$FF,$FF,$0B,$0A,$09,$14,$13,$12,$FF,$1D,$1C,$1B,$FF,$26,$25,$24,$FF
FRA3B_03: .byte  $04,$05,$06,$EA,$F8,$FF,$24,$25,$26,$FF,$1B,$1C,$1D,$FF,$12,$13,$14,$09,$0A,$0B,$FF,$FF,$FF,$FF,$FF
FRA3B_04: .byte  $04,$05,$06,$F8,$F8,$26,$25,$24,$FF,$1D,$1C,$1B,$FF,$14,$13,$12,$FF,$FF,$0B,$0A,$09,$FF,$FF,$FF,$FF

;FRAME_3C: .word  FRA3C_01, FRA3C_02, FRA3C_03, FRA3C_04
;FRA3C_01: .byte  $03,$05,$06,$F0,$E0,$FF,$05,$FF,$0C,$0D,$0E,$15,$16,$17,$1E,$1F,$20,$27,$28,$29 ; No utilizado
;FRA3C_02: .byte  $03,$05,$06,$F4,$E0,$FF,$05,$FF,$0C,$0D,$0E,$15,$16,$17,$1E,$1F,$20,$27,$28,$29
;FRA3C_03: .byte  $03,$05,$06,$F0,$E8,$27,$28,$29,$1E,$1F,$20,$15,$16,$17,$0C,$0D,$0E,$FF,$05,$FF
;FRA3C_04: .byte  $03,$05,$06,$F8,$F8,$29,$28,$27,$20,$1F,$1E,$17,$16,$15,$0E,$0D,$0C,$FF,$05,$FF

; -------------------------------------------------------------------------------- ;Mirar arriba 0x80010
; LOOK UP
;FRAME_3D: .word  FRA3D_01, FRA3D_02, FRA3D_01, FRA3D_02
;FRA3D_01: .byte  $03,$05,$00,$F4,$D8,$FF,$FF,$FF,$13,$14,$FF,$25,$26,$FF,$35,$36,$FF,$37,$38,$39
;FRA3D_02: .byte  $03,$05,$00,$F4,$D8,$FF,$FF,$FF,$FF,$14,$13,$FF,$26,$25,$FF,$36,$35,$39,$38,$37

; LOOK UP (NEW)
FRAME_3D:	.WORD  FRAME_3D_new_cfg,FRAME_3D_new_cfg,FRAME_3D_new_cfg,FRAME_3D_new_cfg

FRAME_3D_new_cfg:
		.BYTE	8+$80	; 8 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	0 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
				
		.BYTE	$E0,$13,$01,$F4
		.BYTE	$E0,$14,$01,$FC
		
		.BYTE	$E8,$25,$01,$F4
		.BYTE	$E8,$26,$01,$FC
		
		.BYTE	$F0,$35,$01,$F4
		.BYTE	$F0,$36,$01,$FC
		
		.BYTE	$F8,$37,$00,$F7
		.BYTE	$F8,$38,$00,$FF

; -------------------------------------------------------------------------------- ;Bolita 0x82810
;FRAME_3E: .word  FRA3E_01, FRA3E_02, FRA3E_01, FRA3E_02
;FRA3E_01: .byte  $03,$03,$05,$F4,$E8,$01,$02,$03,$10,$11,$12,$1F,$20,$21
;FRA3E_02: .byte  $03,$03,$05,$F4,$E8,$03,$02,$01,$12,$11,$10,$21,$20,$1F

;FRAME_3F: .word  FRA3F_01, FRA3F_02, FRA3F_01, FRA3F_02
;FRA3F_01: .byte  $03,$03,$05,$F4,$E8,$07,$08,$09,$16,$17,$18,$25,$26,$27
;FRA3F_02: .byte  $03,$03,$05,$F4,$E8,$09,$08,$07,$18,$17,$16,$27,$26,$25

;FRAME_40: .word  FRA40_01, FRA40_02, FRA40_01, FRA40_02
;FRA40_01: .byte  $03,$03,$05,$F4,$E8,$04,$05,$06,$13,$14,$15,$22,$23,$24
;FRA40_02: .byte  $03,$03,$05,$F4,$E8,$06,$05,$04,$15,$14,$13,$24,$23,$22

;FRAME_41: .word  FRA41_01, FRA41_02, FRA41_01, FRA41_02
;FRA41_01: .byte  $03,$03,$05,$F4,$E8,$0A,$0B,$0C,$19,$1A,$1B,$28,$29,$2A
;FRA41_02: .byte  $03,$03,$05,$F4,$E8,$0C,$0B,$0A,$1B,$1A,$19,$2A,$29,$28

;FRAME_42: .word  FRA42_01, FRA42_02, FRA42_01, FRA42_02
;FRA42_01: .byte  $03,$03,$05,$F4,$E8,$0D,$0E,$0F,$1C,$1D,$1E,$2B,$2C,$2D
;FRA42_02: .byte  $03,$03,$05,$F4,$E8,$0F,$0E,$0D,$1E,$1D,$1C,$2D,$2C,$2B


; -------------------------------------------------------------------------------- ;Ahogado ;Roto 0x83010
FRAME_43: .word  FRA43_01, FRA43_01, FRA43_01, FRA43_01
FRA43_01: .byte  $03,$05,$02,$F4,$E0,$FF,$01,$FF,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D
;FRA43_01: .byte  $03,$04,$06,$F4,$E0,$0A,$10,$12,$0B,$11,$13,$0E,$14,$16,$0F,$15,$17 ; No utilizado - Somari


; -------------------------------------------------------------------------------- ;Caminar 45º Abajo 0x91010
FRAME_44: .word  FRA44_01, FRA44_02, FRA44_03, FRA44_04
FRA44_01: .byte  $04,$03,$22,$EB,$E8,$01,$02,$03,$FF,$04,$05,$06,$07,$08,$09,$0A,$0B  ;Error de paleta
FRA44_02: .byte  $04,$03,$22,$F5,$E8,$FF,$03,$02,$01,$07,$06,$05,$04,$0B,$0A,$09,$08
FRA44_03: .byte  $04,$03,$22,$EB,$00,$08,$09,$0A,$0B,$04,$05,$06,$07,$01,$02,$03,$FF
FRA44_04: .byte  $04,$03,$22,$F5,$00,$0B,$0A,$09,$08,$07,$06,$05,$04,$FF,$03,$02,$01

FRAME_45: .word  FRA45_01, FRA45_02, FRA45_03, FRA45_04
FRA45_01: .byte  $04,$04,$22,$ED,$E4,$0C,$0D,$0E,$FF,$0F,$10,$11,$12,$13,$14,$15,$16,$FF,$17,$18,$FF
FRA45_02: .byte  $04,$04,$22,$F3,$E4,$FF,$0E,$0D,$0C,$12,$11,$10,$0F,$16,$15,$14,$13,$FF,$18,$17,$FF
FRA45_03: .byte  $04,$04,$22,$ED,$00,$FF,$17,$18,$FF,$13,$14,$15,$16,$0F,$10,$11,$12,$0C,$0D,$0E,$FF
FRA45_04: .byte  $04,$04,$22,$F3,$00,$FF,$18,$17,$FF,$16,$15,$14,$13,$12,$11,$10,$0F,$FF,$0E,$0D,$0C

FRAME_46: .word  FRA46_01, FRA46_02, FRA46_03, FRA46_04
FRA46_01: .byte  $04,$04,$22,$EB,$E2,$19,$1A,$1B,$FF,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$FF,$24,$25,$26
FRA46_02: .byte  $04,$04,$22,$F4,$E2,$FF,$1B,$1A,$19,$1F,$1E,$1D,$1C,$23,$22,$21,$20,$26,$25,$24,$FF
FRA46_03: .byte  $04,$04,$22,$EB,$00,$FF,$24,$25,$26,$20,$21,$22,$23,$1C,$1D,$1E,$1F,$19,$1A,$1B,$FF
FRA46_04: .byte  $04,$04,$22,$F4,$00,$26,$25,$24,$FF,$23,$22,$21,$20,$1F,$1E,$1D,$1C,$FF,$1B,$1A,$19

FRAME_47: .word  FRA47_01, FRA47_02, FRA47_03, FRA47_04
FRA47_01: .byte  $04,$03,$22,$EC,$E8,$27,$28,$29,$FF,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31
FRA47_02: .byte  $04,$03,$22,$F3,$E8,$FF,$29,$28,$27,$2D,$2C,$2B,$2A,$31,$30,$2F,$2E
FRA47_03: .byte  $04,$03,$22,$EC,$00,$2E,$2F,$30,$31,$2A,$2B,$2C,$2D,$27,$28,$29,$FF
FRA47_04: .byte  $04,$03,$22,$F3,$00,$31,$30,$2F,$2E,$2D,$2C,$2B,$2A,$FF,$29,$28,$27

FRAME_48: .word  FRA48_01, FRA48_02, FRA48_03, FRA48_04
FRA48_01: .byte  $04,$04,$22,$EB,$E2,$32,$33,$FF,$FF,$34,$35,$36,$FF,$37,$38,$39,$3A,$FF,$3B,$3C,$3D
FRA48_02: .byte  $04,$04,$22,$F4,$E2,$FF,$FF,$33,$32,$FF,$36,$35,$34,$3A,$39,$38,$37,$3D,$3C,$3B,$FF
FRA48_03: .byte  $04,$04,$22,$EB,$00,$FF,$3B,$3C,$3D,$37,$38,$39,$3A,$34,$35,$36,$FF,$32,$33,$FF,$FF
FRA48_04: .byte  $04,$04,$22,$F4,$00,$3D,$3C,$3B,$FF,$3A,$39,$38,$37,$FF,$36,$35,$34,$FF,$FF,$33,$32

FRAME_49: .word  FRA49_01, FRA49_02, FRA49_03, FRA49_04
FRA49_01: .byte  $05,$04,$22,$E7,$E2,$3E,$3F,$40,$FF,$FF,$41,$42,$43,$44,$FF,$45,$46,$47,$48,$49,$4A,$4B,$4C,$FF,$FF
FRA49_02: .byte  $05,$04,$22,$F0,$E2,$FF,$FF,$40,$3F,$3E,$FF,$44,$43,$42,$41,$49,$48,$47,$46,$45,$FF,$FF,$4C,$4B,$4A
FRA49_03: .byte  $05,$04,$22,$E7,$00,$4A,$4B,$4C,$FF,$FF,$45,$46,$47,$48,$49,$41,$42,$43,$44,$FF,$3E,$3F,$40,$FF,$FF
FRA49_04: .byte  $05,$04,$22,$F0,$00,$FF,$FF,$4C,$4B,$4A,$49,$48,$47,$46,$45,$FF,$44,$43,$42,$41,$FF,$FF,$40,$3F,$3E

FRAME_4A: .word  FRA4A_01, FRA4A_02, FRA4A_03, FRA4A_04
FRA4A_01: .byte  $04,$04,$22,$E9,$E3,$4D,$4E,$4F,$FF,$50,$51,$52,$53,$54,$55,$56,$57,$FF,$58,$59,$5A
FRA4A_02: .byte  $04,$04,$22,$F6,$E3,$FF,$4F,$4E,$4D,$53,$52,$51,$50,$57,$56,$55,$54,$5A,$59,$58,$FF
FRA4A_03: .byte  $04,$04,$22,$E9,$00,$FF,$58,$59,$5A,$54,$55,$56,$57,$50,$51,$52,$53,$4D,$4E,$4F,$FF
FRA4A_04: .byte  $04,$04,$22,$F6,$00,$5A,$59,$58,$FF,$57,$56,$55,$54,$53,$52,$51,$50,$FF,$4F,$4E,$4D


; -------------------------------------------------------------------------------- ;Correr 45º Abajo 0x83010
FRAME_4B: .word  FRA4B_01, FRA4B_02, FRA4B_03, FRA4B_04
FRA4B_01: .byte  $05,$03,$06,$F0,$E8,$FF,$2E,$2F,$30,$31,$3F,$40,$41,$42,$43,$FF,$51,$52,$53,$54
FRA4B_02: .byte  $05,$03,$06,$F2,$E8,$31,$30,$2F,$2E,$FF,$43,$42,$41,$40,$3F,$54,$53,$52,$51,$FF
FRA4B_03: .byte  $05,$03,$06,$F0,$F8,$FF,$51,$52,$53,$54,$3F,$40,$41,$42,$43,$FF,$2E,$2F,$30,$31
FRA4B_04: .byte  $05,$03,$06,$F3,$F8,$54,$53,$52,$51,$FF,$43,$42,$41,$40,$3F,$31,$30,$2F,$2E,$FF

FRAME_4C: .word  FRA4C_01, FRA4C_02, FRA4C_03, FRA4C_04
FRA4C_01: .byte  $05,$04,$06,$F2,$E2,$FF,$2A,$FF,$FF,$FF,$32,$33,$34,$35,$36,$44,$45,$46,$47,$48,$FF,$FF,$55,$56,$57
FRA4C_02: .byte  $05,$04,$06,$F0,$E2,$FF,$FF,$FF,$2A,$FF,$36,$35,$34,$33,$32,$48,$47,$46,$45,$44,$57,$56,$55,$FF,$FF
FRA4C_03: .byte  $05,$04,$06,$F0,$F8,$FF,$FF,$55,$56,$57,$44,$45,$46,$47,$48,$32,$33,$34,$35,$36,$FF,$2A,$FF,$FF,$FF
FRA4C_04: .byte  $05,$04,$06,$F3,$F8,$57,$56,$55,$FF,$FF,$48,$47,$46,$45,$44,$36,$35,$34,$33,$32,$FF,$FF,$FF,$2A,$FF

;FRAME_4D: .word  FRA4D_01, FRA4D_02, FRA4D_03, FRA4D_04
;FRA4D_01: .byte  $05,$03,$06,$F0,$E8,$37,$38,$39,$3A,$3B,$49,$4A,$4B,$4C,$4D,$FF,$58,$59,$5A,$5B  ;No utilizado
;FRA4D_02: .byte  $05,$03,$06,$F8,$E8,$3B,$3A,$39,$38,$37,$4D,$4C,$4B,$4A,$49,$5B,$5A,$59,$58,$FF
;FRA4D_03: .byte  $05,$03,$06,$F0,$E8,$FF,$58,$59,$5A,$5B,$49,$4A,$4B,$4C,$4D,$37,$38,$39,$3A,$3B
;FRA4D_04: .byte  $05,$03,$06,$F3,$F8,$5B,$5A,$59,$58,$FF,$4D,$4C,$4B,$4A,$49,$3B,$3A,$39,$38,$37


; ---------------------------------------------
ANIM_SEQ_18: ; 18 SUPERS1
.word  FRAME_4E
 .byte  $05,$00
.word  FRAME_4F
 .byte  $05,$00
.word  FRAME_50
 .byte  $03,$00
.word  FRAME_51
 .byte  $01,$00
.word  FRAME_51
 .byte  $83,$00 

; ---------------------------------------------
ANIM_SEQ_19: ; 19 SUPERS2
.word  FRAME_52
 .byte  $00,$00
.word  FRAME_51
 .byte  $00,$00 
.word  FRAME_51
 .byte  $80,$00

; --------------------------------------------------------------------------------
FRAME_4E:	.word  FRAME4E, FRAME4E_Hm, FRAME4E, FRAME4E_Hm

FRAME4E:	.BYTE	3 ; sprite cnt X
		.BYTE	4 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$E0 ; Y
		
		.BYTE	$0E,$0F,$10 ; tile nums
		.BYTE	$11,$12,$13
		.BYTE	$14,$15,$16
		.BYTE	$17,$18,$19
		
FRAME4E_Hm:	.BYTE	3 ; sprite cnt X
		.BYTE	4 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$E0 ; Y
		
		.BYTE	$10,$0F,$0E ; tile nums
		.BYTE	$13,$12,$11
		.BYTE	$16,$15,$14
		.BYTE	$19,$18,$17
		
FRAME_4F: 	.word  FRAME4F, FRAME4F_Hm, FRAME4F, FRAME4F_Hm

FRAME4F:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$1A,$1B,$1C ; tile nums
		.BYTE	$1D,$1E,$1F
		.BYTE	$20,$21,$22
		.BYTE	$23,$24,$FF
		.BYTE	$25,$26,$FF
		
FRAME4F_Hm:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$1C,$1B,$1A ; tile nums
		.BYTE	$1F,$1E,$1D
		.BYTE	$22,$21,$20
		.BYTE	$FF,$24,$23
		.BYTE	$FF,$26,$25
		
FRAME_50: 	.word  FRAME50, FRAME50_Hm, FRAME50, FRAME50_Hm

FRAME50:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$27,$28,$29 ; tile nums
		.BYTE	$2A,$2B,$2C
		.BYTE	$2D,$2E,$2F
		.BYTE	$30,$31,$32
		.BYTE	$33,$34,$35
		
FRAME50_Hm:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$29,$28,$27 ; tile nums
		.BYTE	$2C,$2B,$2A
		.BYTE	$2F,$2E,$2D
		.BYTE	$32,$31,$30
		.BYTE	$35,$34,$33
		
FRAME_51: 	.word  FRAME51, FRAME51_Hm, FRAME51, FRAME51_Hm

FRAME51:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$4D,$4E,$4F ; tile nums
		.BYTE	$50,$51,$52
		.BYTE	$53,$54,$55
		.BYTE	$56,$57,$58
		.BYTE	$59,$5A,$35
		
FRAME51_Hm:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$4F,$4E,$4D ; tile nums
		.BYTE	$52,$51,$50
		.BYTE	$55,$54,$53
		.BYTE	$58,$57,$56
		.BYTE	$35,$5A,$59
		
FRAME_52: 	.word  FRAME52, FRAME52_Hm, FRAME52, FRAME52_Hm

FRAME52:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$5B,$5C,$5D ; tile nums
		.BYTE	$5E,$51,$52
		.BYTE	$5F,$54,$55
		.BYTE	$56,$57,$58
		.BYTE	$59,$5A,$35
		
FRAME52_Hm:
		.BYTE	3 ; sprite cnt X
		.BYTE	5 ; sprite cnt Y
		.BYTE	2 ; bank and attr
		.BYTE	$F4 ; X
		.BYTE	$D8 ; Y
		
		.BYTE	$5D,$5C,$5B ; tile nums
		.BYTE	$52,$51,$5E
		.BYTE	$55,$54,$5F
		.BYTE	$58,$57,$56
		.BYTE	$35,$5A,$59
; --------------------------------------------------------------------------------

pl_spr_cfg_ptrs_new:
		.WORD  PARADO_NEW
		.WORD  CAMINAR_X1 ; 1
		.WORD  CAMINAR_X2 ; 2
		.WORD  CAMINAR_X3 ; 3

		.WORD  CORRER_X1 ; 4
		.WORD  CORRER_X2 ; 5

		.WORD  SALTANDO ; 6
		.WORD  RESBALANDO ; 7
		.WORD  BOLITA_NEW ; 8
		.WORD  MURIENDO ; 9
		.WORD  GET_HIT_ANIM ; 10
		.WORD  AGACHANDOSE ; 11
		.WORD  MIRANDO_ARRIBA ; 12
		.WORD  EMPUJANDO ; 13
		.WORD  MIRANDO_LA_HORA ; 14
		.WORD  MIRANDO_LA_HORA ; 15

		.WORD  RECOSTANDOSE ; 16

		.WORD  ANIM_DROWNING ; 17
		.WORD  ANIM_SEQ_18 ; 18
		.WORD  ANIM_SEQ_19 ; 19

		.WORD  PARADO_NEW ; 20
		.WORD  CAMINAR_ACOSTADO_X1 ; 21
		.WORD  CAMINAR_ACOSTADO_X2 ; 22
		.WORD  CAMINAR_ACOSTADO_X3 ; 23

		.WORD  CORRER_ACOSTADO_X1 ; 24
		.WORD  CORRER_ACOSTADO_X2 ; 25

		.WORD  CAMINAR_45_ARRIBA_X1 ; 26
		.WORD  CAMINAR_45_ARRIBA_X2 ; 27
		.WORD  CAMINAR_45_ARRIBA_X3 ; 28

		.WORD  CORRER_45_ARRIBA_X1 ; 29
		.WORD  CORRER_45_ARRIBA_X2 ; 30

		.WORD  MOMENTUM_SPINDASH ; 31
		.WORD  BOLITA_NEW ; 32

		.WORD  CAMINAR_45_ABAJO_X1 ; 33
		.WORD  CAMINAR_45_ABAJO_X2 ; 34
		.WORD  CAMINAR_45_ABAJO_X3 ; 35

		.WORD  CORRER_45_ABAJO_X1 ; 36
		.WORD  CORRER_45_ABAJO_X2 ; 37

		.WORD  CAMINAR_X1 ; 38
		.WORD  CAMINAR_X2 ; 39
		.WORD  CAMINAR_X3 ; 40
		.WORD  CORRER_X1 ; 41
		.WORD  CORRER_X2 ; 42

		.WORD  WATERFALL_ANIM ; 43

		.WORD  TOMAR_AIRE ; 44

; --------------------------------------------------------------------------------

pl_spr_cfg_ptrs_super:
		.WORD  PARADO_SUPER
		.WORD  CAMINAR_X1_SUPER ; 1  WALK
		.WORD  CAMINAR_X2_SUPER ; 2  WALK
		.WORD  CAMINAR_X3_SUPER ; 3  WALK

		.WORD  CORRER_X1_SUPER ; 4  RUN
		.WORD  CORRER_X2_SUPER ; 5  RUN

		.WORD  SALTANDO_SUPER ; 6  SPRING JUMP
		.WORD  RESBALANDO_SUPER ; 7 SKID
		.WORD  BOLITA_NEW ; 8
		.WORD  MURIENDO ; 9
		.WORD  GET_HIT_ANIM_SUPER ; 10
		.WORD  AGACHANDOSE_SUPER ; 11  SIT
		.WORD  MIRANDO_ARRIBA_SUPER ; 12  LOOK UP
		.WORD  EMPUJANDO_SUPER ; 13  ; WALL
		.WORD  MIRANDO_LA_HORA ; 14
		.WORD  MIRANDO_LA_HORA ; 15

		.WORD  RECOSTANDOSE ; 16

		.WORD  ANIM_DROWNING ; 17
		.WORD  ANIM_SEQ_18 ; 18
		.WORD  ANIM_SEQ_19 ; 19

		.WORD  PARADO_SUPER ; 20
		.WORD  CAMINAR_ACOSTADO_X1_SUPER ; 21  WALK (ROTATED 90)
		.WORD  CAMINAR_ACOSTADO_X2_SUPER ; 22  WALK (ROTATED 90)
		.WORD  CAMINAR_ACOSTADO_X3_SUPER ; 23  WALK (ROTATED 90)

		.WORD  CORRER_ACOSTADO_X1_SUPER ; 24 RUN (ROTATED 90)
		.WORD  CORRER_ACOSTADO_X2_SUPER ; 25 RUN (ROTATED 90)

		.WORD  CAMINAR_45_ARRIBA_X1_SUPER ; 26  DIAGONAL WALK
		.WORD  CAMINAR_45_ARRIBA_X2_SUPER ; 27  DIAGONAL WALK
		.WORD  CAMINAR_45_ARRIBA_X3_SUPER ; 28  DIAGONAL WALK

		.WORD  CORRER_45_ARRIBA_X1_SUPER ; 29  DIAGONAL RUN
		.WORD  CORRER_45_ARRIBA_X2_SUPER ; 30  DIAGONAL RUN

		.WORD  MOMENTUM_SPINDASH ; 31
		.WORD  BOLITA_NEW ; 32

		.WORD  CAMINAR_45_ABAJO_X1_SUPER ; 33  DIAGONAL WALK (ROTATED 90)
		.WORD  CAMINAR_45_ABAJO_X2_SUPER ; 34  DIAGONAL WALK (ROTATED 90)
		.WORD  CAMINAR_45_ABAJO_X3_SUPER ; 35  DIAGONAL WALK (ROTATED 90)

		.WORD  CORRER_45_ABAJO_X1_SUPER ; 36  DIAGONAL RUN (ROTATED 90)
		.WORD  CORRER_45_ABAJO_X2_SUPER ; 37  DIAGONAL RUN (ROTATED 90)

		.WORD  CAMINAR_X1_SUPER ; 38
		.WORD  CAMINAR_X2_SUPER ; 39
		.WORD  CAMINAR_X3_SUPER ; 40
		.WORD  CORRER_X1_SUPER ; 41
		.WORD  CORRER_X2_SUPER ; 42

		.WORD  WATERFALL_ANIM_SUPER ; 43

		.WORD  TOMAR_AIRE_SUPER ; 44

; --------------------------------------------------------------------------------

PARADO_NEW:	; IDLE STAND
;		.WORD  FRAME_04_new
;		.BYTE  $0A,$00
;		.WORD  FRAME_04_new
;		.BYTE  $80,$00

		.WORD  FRAME_04_new
		.BYTE  $08,$00
		.WORD  FRAME_04_new
		.BYTE  $08,$00
		.WORD  FRAME_04_new
		.BYTE  $08,$00
		.WORD  FRAME_04_new
		.BYTE  $08,$00
		.WORD  FRAME_04_new
		.BYTE  $80,$00


FRAME_04_new:	.WORD  FRAME_04_new_cfg,FRAME_04_new_cfg,FRAME_04_new_cfg,FRAME_04_new_cfg

FRAME_04_new_cfg:
		.BYTE	10+$80	; 10 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	0 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$01,$01,$F5
		;.BYTE	$D8,$02,$01,$FC
		
		.BYTE	$E0,$05,$01,$F4
		.BYTE	$E0,$06,$01,$FC
		
		.BYTE	$E8,$15,$01,$F4
		.BYTE	$E8,$16,$01,$FC
		.BYTE	$E8,$17,$01,$04
		
		.BYTE	$F0,$27,$01,$F4
		.BYTE	$F0,$28,$01,$FC
		
		.BYTE	$F8,$37,$00,$F7
		.BYTE	$F8,$38,$00,$FF
		
PARADO_SUPER:	; IDLE STAND (SUPERS)

;		.WORD  FRAME_04_SUPER
;		.BYTE  $0A,$00
;		.WORD  FRAME_04_SUPER
;		.BYTE  $80,$00
		
		.WORD  FRAME_04_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_55_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_04_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_56_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_04_SUPER
		.BYTE  $80,$00

FRAME_04_SUPER:
		.WORD  FRAME_04_super_cfg,FRAME_04_super_cfg,FRAME_04_super_cfg,FRAME_04_super_cfg
		
FRAME_04_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$00,$01,($EF+00)&$FF
		.BYTE	$D8,$01,$01,($EF+08)&$FF
		.BYTE	$D8,$02,$01,($EF+16)&$FF
		
		.BYTE	$E0,$03,$01,($EF+00)&$FF
		.BYTE	$E0,$04,$01,($EF+08)&$FF
		.BYTE	$E0,$05,$01,($EF+16)&$FF
		
		.BYTE	$E8,$06,$01,($EF+00)&$FF
		.BYTE	$E8,$07,$01,($EF+08)&$FF
		.BYTE	$E8,$08,$01,($EF+16)&$FF
		
		.BYTE	$F0,$09,$01,($EF+08-3)&$FF
		.BYTE	$F0,$0A,$01,($EF+16-3)&$FF
		
		.BYTE	$F8,$0B,$00,($EF+08)&$FF
		.BYTE	$F8,$0C,$00,($EF+16)&$FF
		
FRAME_55_SUPER:
		.WORD  FRAME_55_super_cfg,FRAME_55_super_cfg,FRAME_55_super_cfg,FRAME_55_super_cfg
		
FRAME_55_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$0D,$01,($EF+00)&$FF
		.BYTE	$D8,$0E,$01,($EF+08)&$FF
		.BYTE	$D8,$0F,$01,($EF+16)&$FF
		
		.BYTE	$E0,$10,$01,($EF+00)&$FF
		.BYTE	$E0,$04,$01,($EF+08)&$FF
		.BYTE	$E0,$05,$01,($EF+16)&$FF
		
		.BYTE	$E8,$11,$01,($EF+00)&$FF
		.BYTE	$E8,$07,$01,($EF+08)&$FF
		.BYTE	$E8,$08,$01,($EF+16)&$FF
		
		.BYTE	$F0,$09,$01,($EF+08-3)&$FF
		.BYTE	$F0,$0A,$01,($EF+16-3)&$FF
		
		.BYTE	$F8,$0B,$00,($EF+08)&$FF
		.BYTE	$F8,$0C,$00,($EF+16)&$FF

FRAME_56_SUPER:
		.WORD  FRAME_56_super_cfg,FRAME_56_super_cfg,FRAME_56_super_cfg,FRAME_56_super_cfg
		
FRAME_56_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$12,$01,($EF+00)&$FF
		.BYTE	$D8,$13,$01,($EF+08)&$FF
		.BYTE	$D8,$14,$01,($EF+16)&$FF
		
		.BYTE	$E0,$15,$01,($EF+00)&$FF
		.BYTE	$E0,$04,$01,($EF+08)&$FF
		.BYTE	$E0,$05,$01,($EF+16)&$FF
		
		.BYTE	$E8,$16,$01,($EF+00)&$FF
		.BYTE	$E8,$07,$01,($EF+08)&$FF
		.BYTE	$E8,$08,$01,($EF+16)&$FF
		
		.BYTE	$F0,$09,$01,($EF+08-3)&$FF
		.BYTE	$F0,$0A,$01,($EF+16-3)&$FF
		
		.BYTE	$F8,$0B,$00,($EF+08)&$FF
		.BYTE	$F8,$0C,$00,($EF+16)&$FF


CAMINAR_X1_SUPER:	; SUPER WALK1
.word  FRAME_09_SUPER
.byte  $03,$00
.word  FRAME_0A_SUPER
.byte  $03,$00
.word  FRAME_0B_SUPER
.byte  $03,$00
.word  FRAME_08_SUPER
.byte  $03,$00
.word  FRAME_05_SUPER
.byte  $03,$00
.word  FRAME_06_SUPER
.byte  $03,$00
.word  FRAME_07_SUPER
.byte  $03,$00

.word  FRAME_08_SUPER
.byte  $03,$00
.word  FRAME_07_SUPER
.byte  $03,$00
.word  FRAME_06_SUPER
.byte  $81,$00

CAMINAR_X2_SUPER:	; SUPER WALK2
.word  FRAME_05_SUPER
.byte  $02,$00
.word  FRAME_06_SUPER
.byte  $02,$00
.word  FRAME_07_SUPER
.byte  $02,$00
.word  FRAME_08_SUPER
.byte  $02,$00
.word  FRAME_09_SUPER
.byte  $02,$00
.word  FRAME_0A_SUPER
.byte  $02,$00
.word  FRAME_0B_SUPER
.byte  $02,$00

.word  FRAME_08_SUPER
.byte  $02,$00
.word  FRAME_07_SUPER
.byte  $02,$00
.word  FRAME_06_SUPER
.byte  $81,$00

CAMINAR_X3_SUPER:	; SUPER WALK3
.word  FRAME_05_SUPER
 .byte  $01,$00
.word  FRAME_06_SUPER
 .byte  $01,$00
.word  FRAME_07_SUPER
 .byte  $01,$00
.word  FRAME_08_SUPER
 .byte  $01,$00
.word  FRAME_09_SUPER
 .byte  $01,$00
.word  FRAME_0A_SUPER
 .byte  $01,$00
.word  FRAME_0B_SUPER
. byte  $01,$00
.word  FRAME_08_SUPER
 .byte  $01,$00
.word  FRAME_07_SUPER
 .byte  $01,$00
.word  FRAME_06_SUPER
 .byte  $81,$00
 
FRAME_05_SUPER: .WORD  FRAME_05_super_cfg,FRAME_05_super_cfg,FRAME_05_super_cfg,FRAME_05_super_cfg

FRAME_05_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$0E,$01,($EC+00+3)&$FF
		.BYTE	$D8,$0F,$01,($EC+08+3)&$FF
		.BYTE	$D8,$10,$01,($EC+16+3)&$FF
		
		.BYTE	$E0,$11,$01,($EC+00+3)&$FF
		.BYTE	$E0,$12,$01,($EC+08+3)&$FF
		.BYTE	$E0,$13,$01,($EC+16+3)&$FF
		
		.BYTE	$E8,$14,$01,($EC+00+4)&$FF
		.BYTE	$E8,$15,$01,($EC+08+4)&$FF
		.BYTE	$E8,$16,$01,($EC+16+4)&$FF
		
		.BYTE	$F0,$17,$01,($EC+08)&$FF
		.BYTE	$F0,$18,$01,($EC+16)&$FF
		
		.BYTE	$F8,$19,$00,($EC+08)&$FF
		.BYTE	$F8,$1A,$00,($EC+16)&$FF
		
FRAME_06_SUPER: .WORD  FRAME_06_super_cfg,FRAME_06_super_cfg,FRAME_06_super_cfg,FRAME_06_super_cfg

FRAME_06_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$1B,$01,($EC+00+2)&$FF
		.BYTE	$D8,$1C,$01,($EC+08+2)&$FF
		.BYTE	$D8,$1D,$01,($EC+16+2)&$FF
		
		.BYTE	$E0,$1E,$01,($EC+00+2)&$FF
		.BYTE	$E0,$1F,$01,($EC+08+2)&$FF
		.BYTE	$E0,$20,$01,($EC+16+2)&$FF
		
		.BYTE	$E8,$21,$01,($EC+00+5)&$FF
		.BYTE	$E8,$15,$01,($EC+08+5)&$FF
		.BYTE	$E8,$16,$01,($EC+16+5)&$FF
		
		.BYTE	$F0,$24,$01,($EC+00+5)&$FF
		.BYTE	$F0,$25,$01,($EC+08+5)&$FF
		.BYTE	$F0,$26,$01,($EC+16+5)&$FF
		
		.BYTE	$F8,$27,$01,($EC+00+5)&$FF
		.BYTE	$F8,$28,$00,($EC+08+5)&$FF
		.BYTE	$F8,$29,$00,($EC+16+5)&$FF

FRAME_07_SUPER: .WORD  FRAME_07_super_cfg,FRAME_07_super_cfg,FRAME_07_super_cfg,FRAME_07_super_cfg

FRAME_07_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$2A,$01,($EC+00+4)&$FF
		.BYTE	$D8,$2B,$01,($EC+08+4)&$FF
		.BYTE	$D8,$2C,$01,($EC+16+4)&$FF
		
		.BYTE	$E0,$2D,$01,($EC+00+4)&$FF
		.BYTE	$E0,$2E,$01,($EC+08+4)&$FF
		.BYTE	$E0,$2F,$01,($EC+16+4)&$FF
		
		.BYTE	$E8,$30,$01,($EC+00+4)&$FF
		.BYTE	$E8,$31,$01,($EC+08+4)&$FF
		.BYTE	$E8,$32,$01,($EC+16+4)&$FF
		
		.BYTE	$F0,$33,$01,($EC+00+5)&$FF
		.BYTE	$F0,$34,$01,($EC+08+5)&$FF
		.BYTE	$F0,$35,$01,($EC+16+5)&$FF
		
		.BYTE	$F8,$36,$01,($EC+00+5)&$FF
		.BYTE	$F8,$37,$00,($EC+08+5)&$FF
		.BYTE	$F8,$38,$00,($EC+16+5)&$FF

FRAME_08_SUPER: .WORD  FRAME_08_super_cfg,FRAME_08_super_cfg,FRAME_08_super_cfg,FRAME_08_super_cfg

FRAME_08_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$39,$01,($EC+00)&$FF
		.BYTE	$D8,$3A,$01,($EC+08)&$FF
		.BYTE	$D8,$3B,$01,($EC+16)&$FF
		
		.BYTE	$E0,$3C,$01,($EC+00)&$FF
		.BYTE	$E0,$3D,$01,($EC+08)&$FF
		.BYTE	$E0,$3E,$01,($EC+16)&$FF
		
		.BYTE	$E8,$3F,$01,($EC+00)&$FF
		.BYTE	$E8,$40,$01,($EC+08)&$FF
		.BYTE	$E8,$41,$01,($EC+16)&$FF
		
		.BYTE	$F0,$42,$01,($EC+08)&$FF
		.BYTE	$F0,$43,$01,($EC+16)&$FF
		
		.BYTE	$F8,$44,$00,($EC+08)&$FF
		.BYTE	$F8,$45,$00,($EC+16)&$FF

FRAME_09_SUPER: .WORD  FRAME_09_super_cfg,FRAME_09_super_cfg,FRAME_09_super_cfg,FRAME_09_super_cfg

FRAME_09_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$46,$01,($EC+00)&$FF
		.BYTE	$D8,$47,$01,($EC+08)&$FF
		.BYTE	$D8,$48,$01,($EC+16)&$FF
		
		.BYTE	$E0,$49,$01,($EC+00)&$FF
		.BYTE	$E0,$4A,$01,($EC+08)&$FF
		.BYTE	$E0,$4B,$01,($EC+16)&$FF
		
		.BYTE	$E8,$4C,$01,($EC+00)&$FF
		.BYTE	$E8,$4D,$01,($EC+08)&$FF
		.BYTE	$E8,$4E,$01,($EC+16)&$FF
		
		.BYTE	$F0,$4F,$01,($EC+08)&$FF
		.BYTE	$F0,$50,$01,($EC+16)&$FF
		
		.BYTE	$F8,$51,$00,($EC+08)&$FF
		.BYTE	$F8,$52,$00,($EC+16)&$FF
		
FRAME_0A_SUPER: .WORD  FRAME_0A_super_cfg,FRAME_0A_super_cfg,FRAME_0A_super_cfg,FRAME_0A_super_cfg

FRAME_0A_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$53,$01,($EC+00+3)&$FF
		.BYTE	$D8,$54,$01,($EC+08+3)&$FF
		.BYTE	$D8,$55,$01,($EC+16+3)&$FF
		
		.BYTE	$E0,$56,$01,($EC+00+3)&$FF
		.BYTE	$E0,$57,$01,($EC+08+3)&$FF
		.BYTE	$E0,$58,$01,($EC+16+3)&$FF
		
		.BYTE	$E8,$59,$01,($EC+00+3)&$FF
		.BYTE	$E8,$5A,$01,($EC+08+3)&$FF
		.BYTE	$E8,$5B,$01,($EC+16+3)&$FF
		
		.BYTE	$F0,$5C,$01,($EC+00+5)&$FF
		.BYTE	$F0,$5D,$01,($EC+08+5)&$FF
		.BYTE	$F0,$5E,$01,($EC+16+5)&$FF
		
		.BYTE	$F8,$5F,$01,($EC+00+5)&$FF
		.BYTE	$F8,$22,$00,($EC+08+5)&$FF
		.BYTE	$F8,$23,$00,($EC+16+5)&$FF

FRAME_0B_SUPER: .WORD  FRAME_0B_super_cfg,FRAME_0B_super_cfg,FRAME_0B_super_cfg,FRAME_0B_super_cfg

FRAME_0B_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$00,$01,($EC+00+4)&$FF
		.BYTE	$D8,$01,$01,($EC+08+4)&$FF
		.BYTE	$D8,$02,$01,($EC+16+4)&$FF
		
		.BYTE	$E0,$03,$01,($EC+00+4)&$FF
		.BYTE	$E0,$04,$01,($EC+08+4)&$FF
		.BYTE	$E0,$05,$01,($EC+16+4)&$FF
		
		.BYTE	$E8,$06,$01,($EC+00+4)&$FF
		.BYTE	$E8,$07,$01,($EC+08+4)&$FF
		.BYTE	$E8,$08,$01,($EC+16+4)&$FF
		
		.BYTE	$F0,$09,$01,($EC+00+4)&$FF
		.BYTE	$F0,$0A,$01,($EC+08+4)&$FF
		.BYTE	$F0,$0B,$01,($EC+16+4)&$FF
		
		.BYTE	$F8,$0C,$01,($EC+00+4)&$FF
		.BYTE	$F8,$0D,$00,($EC+08+4)&$FF
		.BYTE	$F8,$0E,$00,($EC+16+4)&$FF		
		
CORRER_X1_SUPER:	; SUPER RUN
CORRER_X2_SUPER:	; SUPER RUN
 .word  FRAME_0C_SUPER
 .byte  $01,$00
 .word  FRAME_0D_SUPER 
 .byte  $01,$00
 .word  FRAME_0C_SUPER
 .byte  $01,$00
 .word  FRAME_0D_SUPER
 .byte  $01,$00
 .word  FRAME_0C_SUPER
 .byte  $01,$00
 .word  FRAME_0D_SUPER
 .byte  $01,$00
 .word  FRAME_0C_SUPER
 .byte  $01,$00
 .word  FRAME_0D_SUPER
 .byte  $01,$00
 .word  FRAME_0C_SUPER
 .byte  $01,$00
 .word  FRAME_0D_SUPER
 .byte  $81,$00
 
FRAME_0C_SUPER: .WORD  FRAME_0C_super_cfg,FRAME_0C_super_cfg,FRAME_0C_super_cfg,FRAME_0C_super_cfg
FRAME_0D_SUPER: .WORD  FRAME_0D_super_cfg,FRAME_0D_super_cfg,FRAME_0D_super_cfg,FRAME_0D_super_cfg
;FRAME_0E_SUPER: .WORD  FRAME_0E_super_cfg,FRAME_0E_super_cfg,FRAME_0E_super_cfg,FRAME_0E_super_cfg

;FRAME_0E_super_cfg:
FRAME_0C_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$10,$01,($F0+00+8)&$FF
		.BYTE	$E0,$11,$01,($F0+08+8)&$FF
		.BYTE	$E0,$12,$01,($F0+16+8)&$FF
		
		.BYTE	$E8,$13,$01,($F0+00+8)&$FF
		.BYTE	$E8,$14,$01,($F0+08+8)&$FF
		.BYTE	$E8,$15,$01,($F0+16+8)&$FF
		
		.BYTE	$F0,$16,$01,($F0+00)&$FF
		.BYTE	$F0,$17,$01,($F0+08)&$FF
		.BYTE	$F0,$18,$01,($F0+16)&$FF
		.BYTE	$F0,$19,$01,($F0+24)&$FF
		
		.BYTE	$F8,$1A,$00,($F0+00)&$FF
		.BYTE	$F8,$1B,$00,($F0+08)&$FF
		.BYTE	$F8,$1C,$01,($F0+16)&$FF
		
FRAME_0D_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$1D,$01,($F0+00+8)&$FF
		.BYTE	$E0,$1E,$01,($F0+08+8)&$FF
		.BYTE	$E0,$1F,$01,($F0+16+8)&$FF
		
		.BYTE	$E8,$20,$01,($F0+00+8)&$FF
		.BYTE	$E8,$21,$01,($F0+08+8)&$FF
		.BYTE	$E8,$22,$01,($F0+16+8)&$FF
		
		.BYTE	$F0,$23,$01,($F0+00)&$FF
		.BYTE	$F0,$24,$01,($F0+08)&$FF
		.BYTE	$F0,$18,$01,($F0+16)&$FF
		.BYTE	$F0,$19,$01,($F0+24)&$FF
		
		.BYTE	$F8,$25,$00,($F0+00)&$FF
		.BYTE	$F8,$26,$00,($F0+08)&$FF
		.BYTE	$F8,$1C,$01,($F0+16)&$FF


SALTANDO_SUPER:	; SUPER SPRING JUMP
		.WORD	FRAME_0F_SUPER
		.BYTE	$0A,$00
		.WORD	FRAME_0F_SUPER
		.BYTE	$80,$00
 
FRAME_0F_SUPER: .WORD  FRAME_0F_super_cfg,FRAME_0F_super_cfg,FRAME_0F_super_cfg,FRAME_0F_super_cfg 
	
FRAME_0F_super_cfg:
		.BYTE	11+$80	; 11 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$00,$01,($F0+00)&$FF
		.BYTE	$E0,$01,$01,($F0+08)&$FF
		.BYTE	$E0,$02,$01,($F0+16)&$FF

		.BYTE	$E8,$03,$01,($F0+00)&$FF
		.BYTE	$E8,$04,$01,($F0+08)&$FF
		.BYTE	$E8,$05,$01,($F0+16)&$FF

		.BYTE	$F0,$06,$01,($F0+00+8)&$FF
		.BYTE	$F0,$0B,$01,($F0+08+8)&$FF

		.BYTE	$F8,$0C,$00,($F0+00+8)&$FF
		.BYTE	$F8,$0D,$00,($F0+08+8)&$FF
		
		.BYTE	$00,$0E,$00,($F0+00+10)&$FF
		
		
MIRANDO_ARRIBA_SUPER:	; SUPER LOOK UP
	.word  FRAME_3D_SUPER
	.byte  $02,$00
	.word  FRAME_3D_SUPER
	.byte  $80,$00

FRAME_3D_SUPER:	 .WORD  FRAME_3D_super_cfg,FRAME_3D_super_cfg,FRAME_3D_super_cfg,FRAME_3D_super_cfg

FRAME_3D_super_cfg:
		.BYTE	10+$80	; 10 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$00,$01,($EC+00)&$FF
		.BYTE	$E0,$01,$01,($EC+08)&$FF
		.BYTE	$E0,$02,$01,($EC+16)&$FF

		.BYTE	$E8,$03,$01,($EC+00)&$FF
		.BYTE	$E8,$04,$01,($EC+08)&$FF
		.BYTE	$E8,$05,$01,($EC+16)&$FF

		.BYTE	$F0,$06,$01,($EC+00+8)&$FF
		.BYTE	$F0,$07,$01,($EC+08+8)&$FF

		.BYTE	$F8,$08,$00,($EC+00+11)&$FF
		.BYTE	$F8,$09,$00,($EC+08+11)&$FF


AGACHANDOSE_SUPER:	; SUPER SIT
	.word  FRAME_12_SUPER
	.byte  $08,$00
	.word  FRAME_13_SUPER
	.byte  $08,$00
	.word  FRAME_12_SUPER
	.byte  $81,$00
	

FRAME_13_SUPER: .WORD  FRAME_13_super_cfg,FRAME_13_super_cfg,FRAME_13_super_cfg,FRAME_13_super_cfg 

FRAME_13_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$27,$01,($EC+00+8)&$FF
		.BYTE	$E0,$28,$01,($EC+08+8)&$FF
		.BYTE	$E0,$29,$01,($EC+16+8)&$FF
		
		.BYTE	$E8,$2A,$01,($EC+00+8)&$FF
		.BYTE	$E8,$2B,$01,($EC+08+8)&$FF
		.BYTE	$E8,$2C,$01,($EC+16+8)&$FF
		
		.BYTE	$F0,$2D,$01,($EC+00)&$FF
		.BYTE	$F0,$2E,$01,($EC+08)&$FF
		.BYTE	$F0,$2F,$01,($EC+16)&$FF
		.BYTE	$F0,$30,$01,($EC+24)&$FF
		
		.BYTE	$F8,$31,$00,($EC+00)&$FF
		.BYTE	$F8,$32,$00,($EC+08)&$FF
		.BYTE	$F8,$33,$01,($EC+16)&$FF
		.BYTE	$F8,$34,$01,($EC+24)&$FF
		
FRAME_12_SUPER: .WORD  FRAME_12_super_cfg,FRAME_12_super_cfg,FRAME_12_super_cfg,FRAME_12_super_cfg 

FRAME_12_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$DC,$00,$01,($F4+00)&$FF
		.BYTE	$DC,$01,$01,($F4+08)&$FF
		.BYTE	$DC,$02,$01,($F4+16)&$FF
		
		.BYTE	$E4,$03,$01,($F4+00)&$FF
		.BYTE	$E4,$04,$01,($F4+08)&$FF
		.BYTE	$E4,$05,$01,($F4+16)&$FF
		
		.BYTE	$EC,$06,$01,($F4+00)&$FF
		.BYTE	$EC,$07,$01,($F4+08)&$FF
		.BYTE	$EC,$08,$01,($F4+16)&$FF
		
		.BYTE	$F4,$09,$00,($F4+00)&$FF
		.BYTE	$F4,$0A,$00,($F4+08)&$FF
		.BYTE	$F4,$0B,$01,($F4+16)&$FF
		
		.BYTE	$FC,$0C,$01,($F4+00+2)&$FF
		.BYTE	$FC,$0D,$01,($F4+08+2)&$FF


EMPUJANDO_SUPER:	; MOVE (SUPER)
 .word  FRAME_15_SUPER
 .byte  $10,$00
 .word  FRAME_16_SUPER
 .byte  $10,$00
 .word  FRAME_17_SUPER
 .byte  $10,$00
 .word  FRAME_18_SUPER
 .byte  $10,$00
 .word  FRAME_15_SUPER
 .byte  $80,$00	

FRAME_15_SUPER: .WORD  FRAME_15_super_cfg,FRAME_15_super_cfg,FRAME_15_super_cfg,FRAME_15_super_cfg 
FRAME_16_SUPER: .WORD  FRAME_16_super_cfg,FRAME_16_super_cfg,FRAME_16_super_cfg,FRAME_16_super_cfg 
FRAME_17_SUPER: .WORD  FRAME_17_super_cfg,FRAME_17_super_cfg,FRAME_17_super_cfg,FRAME_17_super_cfg 
FRAME_18_SUPER: .WORD  FRAME_18_super_cfg,FRAME_18_super_cfg,FRAME_18_super_cfg,FRAME_18_super_cfg 


FRAME_15_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$35,$01,($F0+00)&$FF
		.BYTE	$D8,$36,$01,($F0+08)&$FF
		.BYTE	$D8,$37,$01,($F0+16)&$FF
		
		.BYTE	$E0,$38,$01,($F0+00)&$FF
		.BYTE	$E0,$39,$01,($F0+08)&$FF
		.BYTE	$E0,$3A,$01,($F0+16)&$FF
		
		.BYTE	$E8,$3B,$01,($F0+00)&$FF
		.BYTE	$E8,$3C,$01,($F0+08)&$FF
		.BYTE	$E8,$3D,$01,($F0+16)&$FF
		
		.BYTE	$F0,$3E,$01,($F0+00)&$FF
		.BYTE	$F0,$3F,$01,($F0+08)&$FF
		.BYTE	$F0,$40,$01,($F0+16)&$FF
		
		.BYTE	$F8,$41,$00,($F0+00)&$FF
		.BYTE	$F8,$42,$00,($F0+08)&$FF
		.BYTE	$F8,$43,$00,($F0+16)&$FF
		
FRAME_17_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$35,$01,($F0+00)&$FF
		.BYTE	$D8,$36,$01,($F0+08)&$FF
		.BYTE	$D8,$37,$01,($F0+16)&$FF
		
		.BYTE	$E0,$38,$01,($F0+00)&$FF
		.BYTE	$E0,$39,$01,($F0+08)&$FF
		.BYTE	$E0,$3A,$01,($F0+16)&$FF
		
		.BYTE	$E8,$3B,$01,($F0+00)&$FF
		.BYTE	$E8,$3C,$01,($F0+08)&$FF
		.BYTE	$E8,$3D,$01,($F0+16)&$FF
		
		.BYTE	$F0,$52,$01,($F0+00)&$FF
		.BYTE	$F0,$53,$01,($F0+08)&$FF
		.BYTE	$F0,$54,$01,($F0+16)&$FF
		
		.BYTE	$F8,$55,$00,($F0+00)&$FF
		.BYTE	$F8,$56,$00,($F0+08)&$FF
		.BYTE	$F8,$57,$00,($F0+16)&$FF
		
FRAME_16_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$44,$01,($F0+00)&$FF
		.BYTE	$D8,$45,$01,($F0+08)&$FF
		.BYTE	$D8,$46,$01,($F0+16)&$FF
		
		.BYTE	$E0,$47,$01,($F0+00)&$FF
		.BYTE	$E0,$48,$01,($F0+08)&$FF
		.BYTE	$E0,$49,$01,($F0+16)&$FF
		
		.BYTE	$E8,$4A,$01,($F0+00)&$FF
		.BYTE	$E8,$4B,$01,($F0+08)&$FF
		.BYTE	$E8,$4C,$01,($F0+16)&$FF
		
		.BYTE	$F0,$4D,$01,($F0+00)&$FF
		.BYTE	$F0,$4E,$01,($F0+08)&$FF
		.BYTE	$F0,$4F,$01,($F0+16)&$FF
		
		.BYTE	$F8,$50,$00,($F0+00+1)&$FF
		.BYTE	$F8,$51,$00,($F0+08+1)&$FF
		
FRAME_18_super_cfg:		
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$34*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$44,$01,($F0+00)&$FF
		.BYTE	$D8,$45,$01,($F0+08)&$FF
		.BYTE	$D8,$46,$01,($F0+16)&$FF
		
		.BYTE	$E0,$47,$01,($F0+00)&$FF
		.BYTE	$E0,$48,$01,($F0+08)&$FF
		.BYTE	$E0,$49,$01,($F0+16)&$FF
		
		.BYTE	$E8,$4A,$01,($F0+00)&$FF
		.BYTE	$E8,$4B,$01,($F0+08)&$FF
		.BYTE	$E8,$4C,$01,($F0+16)&$FF
		
		.BYTE	$F0,$4D,$01,($F0+00)&$FF
		.BYTE	$F0,$58,$01,($F0+08)&$FF
		.BYTE	$F0,$4F,$01,($F0+16)&$FF
		
		.BYTE	$F8,$59,$00,($F0+00)&$FF
		.BYTE	$F8,$5A,$00,($F0+08)&$FF

BOLITA_NEW:	; SPIN
		.WORD  FRAME_41_new
		.BYTE  $00,$00
		.WORD  FRAME_42_new
		.BYTE  $00,$00
		.WORD  FRAME_40_new
		.BYTE  $00,$00
		.WORD  FRAME_42_new
		.BYTE  $00,$00
		.WORD  FRAME_3F_new
		.BYTE  $00,$00
		.WORD  FRAME_42_new
		.BYTE  $00,$00
		.WORD  FRAME_3E_new
		.BYTE  $00,$00
		.WORD  FRAME_42_new
		.BYTE  $00,$00
		.WORD  FRAME_3E_new
		.BYTE  $80,$00

FRAME_3F_new: .WORD  FRAME_3F_new_cfg, FRAME_3F_new_cfg, FRAME_3F_new_cfg, FRAME_3F_new_cfg
FRAME_40_new: .WORD  FRAME_40_new_cfg, FRAME_40_new_cfg, FRAME_40_new_cfg, FRAME_40_new_cfg
FRAME_41_new: .WORD  FRAME_41_new_cfg, FRAME_41_new_cfg, FRAME_41_new_cfg, FRAME_41_new_cfg
FRAME_42_new: .WORD  FRAME_42_new_cfg, FRAME_42_new_cfg, FRAME_42_new_cfg, FRAME_42_new_cfg 
FRAME_3E_new: .WORD  FRAME_3E_new_cfg, FRAME_3E_new_cfg, FRAME_3E_new_cfg, FRAME_3E_new_cfg

FRAME_3E_new_cfg:
		.BYTE	9+$80	; 9 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	5 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E8,$01,$01,$F4  ; RIGHT
		.BYTE	$E8,$02,$01,$FC
		.BYTE	$E8,$03,$01,$04
		
		.BYTE	$F0,$10,$01,$F4
		.BYTE	$F0,$11,$01,$FC
		.BYTE	$F0,$12,$01,$04
		
		.BYTE	$F8,$1F,$01,$F4
		.BYTE	$F8,$20,$01,$FC
		.BYTE	$F8,$21,$00,$04
		
FRAME_3F_new_cfg:
		.BYTE	9+$80	; 9 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	5 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		;.BYTE	$E8,$07,$00,$F8  ; LEFT(old chr)
		;.BYTE	$E8,$08,$01,$00
		;.BYTE	$E8,$09,$01,$08
		;.BYTE	$F0,$16,$01,$F8
		;.BYTE	$F0,$17,$01,$00
		;.BYTE	$F0,$18,$01,$08
		;.BYTE	$F8,$25,$01,$F8
		;.BYTE	$F8,$26,$01,$00
		;.BYTE	$F8,$27,$01,$08

		.BYTE	$E8,$21,$C0,$F4  ; RIGHT-HV-mirror
		.BYTE	$E8,$20,$C1,$FC
		.BYTE	$E8,$1F,$C1,$04
		
		.BYTE	$F0,$12,$C1,$F4
		.BYTE	$F0,$11,$C1,$FC
		.BYTE	$F0,$10,$C1,$04
		
		.BYTE	$F8,$03,$C1,$F4
		.BYTE	$F8,$02,$C1,$FC
		.BYTE	$F8,$01,$C1,$04
		
		
FRAME_40_new_cfg:
		.BYTE	9+$80	; 9 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	5 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E8,$04,$01,$F4 ; DOWN
		.BYTE	$E8,$05,$01,$FC
		.BYTE	$E8,$06,$01,$04
		
		.BYTE	$F0,$13,$01,$F4
		.BYTE	$F0,$14,$01,$FC
		.BYTE	$F0,$15,$01,$04
		
		.BYTE	$F8,$22,$00,$F4
		.BYTE	$F8,$23,$01,$FC
		.BYTE	$F8,$24,$01,$04
		
FRAME_41_new_cfg:
		.BYTE	9+$80	; 9 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	5 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		;.BYTE	$E8,$0A,$01,$F8 ; UP(old chr)
		;.BYTE	$E8,$0B,$01,$00
		;.BYTE	$E8,$0C,$00,$08
		;.BYTE	$F0,$19,$01,$F8
		;.BYTE	$F0,$1A,$01,$00
		;.BYTE	$F0,$1B,$01,$08
		;.BYTE	$F8,$28,$01,$F8
		;.BYTE	$F8,$29,$01,$00
		;.BYTE	$F8,$2A,$01,$08

		.BYTE	$E8,$24,$C1,$F4 ; DOWN-HV-mirror
		.BYTE	$E8,$23,$C1,$FC
		.BYTE	$E8,$22,$C0,$04
		
		.BYTE	$F0,$15,$C1,$F4
		.BYTE	$F0,$14,$C1,$FC
		.BYTE	$F0,$13,$C1,$04
		
		.BYTE	$F8,$06,$C1,$F4
		.BYTE	$F8,$05,$C1,$FC
		.BYTE	$F8,$04,$C1,$04
		
FRAME_42_new_cfg:
		.BYTE	9+$80	; 9 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	5 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E8,$0D,$01,$F4 ; BALL
		.BYTE	$E8,$0E,$01,$FC
		.BYTE	$E8,$0F,$01,$04
		
		.BYTE	$F0,$1C,$01,$F4
		.BYTE	$F0,$1D,$01,$FC
		.BYTE	$F0,$1E,$01,$04
		
		.BYTE	$F8,$2B,$01,$F4
		.BYTE	$F8,$2C,$01,$FC
		.BYTE	$F8,$2D,$01,$04

		;.pad	$A000,$FF

CAMINAR_45_ARRIBA_X1_SUPER:
		.WORD	FRAME_33_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_37_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_38_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_39_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$04,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$81,$00
 
CAMINAR_45_ARRIBA_X2_SUPER:
		.WORD	FRAME_33_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_37_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_38_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_39_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$02,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$81,$00
 
CAMINAR_45_ARRIBA_X3_SUPER:
		.WORD	FRAME_33_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_37_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_38_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_39_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_36_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_35_SUPER
		.BYTE	$01,$00
		.WORD	FRAME_34_SUPER
		.BYTE	$81,$00


; ---------------------------------------------
CAMINAR_45_ABAJO_X1_SUPER:
.word  FRAME_44_SUPER
 .byte  $04,$00
.word  FRAME_45_SUPER
 .byte  $04,$00
.word  FRAME_46_SUPER
 .byte  $04,$00
.word  FRAME_47_SUPER
 .byte  $04,$00
.word  FRAME_48_SUPER
 .byte  $04,$00
.word  FRAME_49_SUPER
 .byte  $04,$00
.word  FRAME_4A_SUPER
 .byte  $04,$00
.word  FRAME_47_SUPER
 .byte  $04,$00
.word  FRAME_46_SUPER
 .byte  $04,$00
.word  FRAME_45_SUPER
 .byte  $81,$00
CAMINAR_45_ABAJO_X2_SUPER:
.word  FRAME_44_SUPER
 .byte  $02,$00
.word  FRAME_45_SUPER
 .byte  $02,$00
.word  FRAME_46_SUPER
 .byte  $02,$00
.word  FRAME_47_SUPER
 .byte  $02,$00
.word  FRAME_48_SUPER
 .byte  $02,$00
.word  FRAME_49_SUPER
 .byte  $02,$00
.word  FRAME_4A_SUPER
 .byte  $02,$00
.word  FRAME_47_SUPER
 .byte  $02,$00
.word  FRAME_46_SUPER
 .byte  $02,$00
.word  FRAME_45_SUPER
 .byte  $81,$00
CAMINAR_45_ABAJO_X3_SUPER:
.word  FRAME_44_SUPER
 .byte  $01,$00
.word  FRAME_45_SUPER
 .byte  $01,$00
.word  FRAME_46_SUPER
 .byte  $01,$00
.word  FRAME_47_SUPER
 .byte  $01,$00
.word  FRAME_48_SUPER
 .byte  $01,$00
.word  FRAME_49_SUPER
 .byte  $01,$00
.word  FRAME_4A_SUPER
 .byte  $01,$00
.word  FRAME_47_SUPER
 .byte  $01,$00
.word  FRAME_46_SUPER
 .byte  $01,$00
.word  FRAME_45_SUPER
 .byte  $81,$00


FRAME_33_SUPER:	.WORD  FRAME_33_super_cfg,FRAME_33_super_cfg,FRAME_33_super_cfg,FRAME_33_super_cfg

FRAME_33_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8-8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E5,$00,$01,($D8+08)&$FF
		.BYTE	$E5,$01,$01,($D8+16)&$FF
		.BYTE	$E5,$02,$01,($D8+24)&$FF
		
		.BYTE	$ED,$03,$01,($D8+00+4)&$FF
		.BYTE	$ED,$04,$01,($D8+08+4)&$FF
		.BYTE	$ED,$05,$01,($D8+16+4)&$FF
		.BYTE	$ED,$06,$01,($D8+24+4)&$FF
		
		.BYTE	$F5,$07,$01,($D8+08)&$FF
		.BYTE	$F5,$08,$01,($D8+16)&$FF
		.BYTE	$F5,$09,$01,($D8+24)&$FF
		.BYTE	$F5,$0A,$01,($D8+32)&$FF
		
		.BYTE	$FD,$0B,$01,($D8+24)&$FF
		.BYTE	$FD,$0C,$01,($D8+32)&$FF
		
FRAME_44_SUPER:	.WORD  FRAME_44_super_cfg,FRAME_44_super_cfg,FRAME_44_super_cfg,FRAME_44_super_cfg

FRAME_44_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$DA,$37,$01,($E8+09)&$FF

		.BYTE	$E2,$38,$01,($E8+00)&$FF
		.BYTE	$E2,$39,$01,($E8+08)&$FF
		.BYTE	$E2,$3A,$01,($E8+16)&$FF
		
		.BYTE	$EA,$3B,$01,($E8+00)&$FF
		.BYTE	$EA,$3C,$01,($E8+08)&$FF
		.BYTE	$EA,$3D,$01,($E8+16)&$FF
		
		.BYTE	$F2,$3E,$01,($E8+00)&$FF
		.BYTE	$F2,$3F,$01,($E8+08)&$FF
		.BYTE	$F2,$40,$01,($E8+16)&$FF
		.BYTE	$F2,$41,$01,($E8+24)&$FF
		
		.BYTE	$FA,$42,$01,($E8+16)&$FF
		.BYTE	$FA,$43,$01,($E8+24)&$FF
		
FRAME_39_SUPER:	.WORD  FRAME_39_super_cfg,FRAME_39_super_cfg,FRAME_39_super_cfg,FRAME_39_super_cfg

FRAME_39_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E7,$26,$01,($E0+00+8)&$FF
		.BYTE	$E7,$27,$01,($E0+08+8)&$FF
		
		.BYTE	$EF,$28,$01,($E0+00)&$FF
		.BYTE	$EF,$29,$01,($E0+08)&$FF
		.BYTE	$EF,$2A,$01,($E0+16)&$FF
		.BYTE	$EF,$2B,$01,($E0+24)&$FF
		
		.BYTE	$F7,$2C,$01,($E0+00)&$FF
		.BYTE	$F7,$2D,$01,($E0+08)&$FF
		.BYTE	$F7,$2E,$01,($E0+16)&$FF
		.BYTE	$F7,$2F,$01,($E0+24)&$FF
		.BYTE	$F7,$30,$01,($E0+32)&$FF
		
		.BYTE	$FF,$31,$01,($E0+00+16)&$FF
		.BYTE	$FF,$32,$01,($E0+08+16)&$FF
		.BYTE	$FF,$33,$01,($E0+16+16)&$FF

FRAME_4A_SUPER:	.WORD  FRAME_4A_super_cfg,FRAME_4A_super_cfg,FRAME_4A_super_cfg,FRAME_4A_super_cfg

FRAME_4A_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8-1	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$F8+3	; Y_offset (for V-Mirror)
		
		.BYTE	$DB,$1A,$01,($E8+08)&$FF
		.BYTE	$DB,$1B,$01,($E8+16)&$FF
		
		.BYTE	$E3,$1C,$01,($E8+00)&$FF
		.BYTE	$E3,$1D,$01,($E8+08)&$FF
		.BYTE	$E3,$1E,$01,($E8+16)&$FF
		
		.BYTE	$EB,$1F,$01,($E8+00)&$FF
		.BYTE	$EB,$20,$01,($E8+08)&$FF
		.BYTE	$EB,$21,$01,($E8+16)&$FF
		.BYTE	$EB,$22,$01,($E8+24)&$FF
		
		.BYTE	$F3,$23,$01,($E8+08)&$FF
		.BYTE	$F3,$24,$01,($E8+16)&$FF
		.BYTE	$F3,$25,$01,($E8+24)&$FF
		
		.BYTE	$FB,$26,$01,($E8+16)&$FF
		.BYTE	$FB,$27,$01,($E8+24)&$FF
		
FRAME_34_SUPER:	.WORD  FRAME_34_super_cfg,FRAME_34_super_cfg,FRAME_34_super_cfg,FRAME_34_super_cfg

FRAME_34_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E6,$34,$01,($DF+00+4)&$FF
		.BYTE	$E6,$35,$01,($DF+08+4)&$FF
		.BYTE	$E6,$36,$01,($DF+16+4)&$FF
		
		.BYTE	$EE,$37,$01,($DF+00)&$FF
		.BYTE	$EE,$38,$01,($DF+08)&$FF
		.BYTE	$EE,$39,$01,($DF+16)&$FF
		.BYTE	$EE,$3A,$01,($DF+24)&$FF
		.BYTE	$EE,$3B,$01,($DF+32)&$FF
		
		.BYTE	$F6,$3C,$01,($DF+08-1)&$FF
		.BYTE	$F6,$3D,$01,($DF+16-1)&$FF
		.BYTE	$F6,$3E,$01,($DF+24-1)&$FF
		.BYTE	$F6,$3F,$01,($DF+32-1)&$FF
		
		.BYTE	$FE,$40,$01,($DF+16)&$FF
		.BYTE	$FE,$41,$01,($DF+24)&$FF
		
		.BYTE	$06,$42,$01,($DF+24)&$FF

FRAME_45_SUPER:	.WORD  FRAME_45_super_cfg,FRAME_45_super_cfg,FRAME_45_super_cfg,FRAME_45_super_cfg

FRAME_45_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$FC	; Y_offset (for V-Mirror)
		
		.BYTE	$DB,$28,$01,($EB+00+1)&$FF
		.BYTE	$DB,$29,$01,($EB+08+1)&$FF
		
		.BYTE	$E3,$2A,$01,($EB+00)&$FF
		.BYTE	$E3,$2B,$01,($EB+08)&$FF
		.BYTE	$E3,$2C,$01,($EB+16)&$FF
		
		.BYTE	$EB,$2D,$01,($EB+00)&$FF
		.BYTE	$EB,$2E,$01,($EB+08)&$FF
		.BYTE	$EB,$2F,$01,($EB+16)&$FF
		.BYTE	$EB,$30,$01,($EB+24)&$FF
		
		.BYTE	$F3,$31,$01,($EB+00+4)&$FF
		.BYTE	$F3,$32,$01,($EB+08+4)&$FF
		.BYTE	$F3,$33,$01,($EB+16+4)&$FF
		.BYTE	$F3,$34,$01,($EB+24+4)&$FF
		
		.BYTE	$FB,$35,$01,($EB+08)&$FF
		.BYTE	$FB,$36,$01,($EB+16)&$FF

FRAME_35_SUPER:	.WORD  FRAME_35_super_cfg,FRAME_35_super_cfg,FRAME_35_super_cfg,FRAME_35_super_cfg

FRAME_35_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E4,$43,$01,($DF+08)&$FF
		.BYTE	$E4,$44,$01,($DF+16)&$FF
		
		.BYTE	$EC,$45,$01,($DF+00)&$FF
		.BYTE	$EC,$46,$01,($DF+08)&$FF
		.BYTE	$EC,$47,$01,($DF+16)&$FF
		.BYTE	$EC,$48,$01,($DF+24)&$FF
		
		.BYTE	$F4,$49,$01,($DF+00)&$FF
		.BYTE	$F4,$4A,$01,($DF+08)&$FF
		.BYTE	$F4,$4B,$01,($DF+16)&$FF
		.BYTE	$F4,$4C,$01,($DF+24)&$FF
		.BYTE	$F4,$4D,$01,($DF+32)&$FF
		
		.BYTE	$FC,$4E,$01,($DF+16)&$FF
		.BYTE	$FC,$4F,$01,($DF+24)&$FF
		.BYTE	$FC,$50,$01,($DF+32)&$FF
		
		.BYTE	$04,$51,$01,($DF+23)&$FF
		
FRAME_46_SUPER:	.WORD  FRAME_46_super_cfg,FRAME_46_super_cfg,FRAME_46_super_cfg,FRAME_46_super_cfg

FRAME_46_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8-1	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$F8+2	; Y_offset (for V-Mirror)
		
		.BYTE	$DB,$44,$01,($EB+00)&$FF
		.BYTE	$DB,$45,$01,($EB+08)&$FF
		
		.BYTE	$E3,$46,$01,($EB+00)&$FF
		.BYTE	$E3,$47,$01,($EB+08)&$FF
		.BYTE	$E3,$48,$01,($EB+16)&$FF
		
		.BYTE	$EB,$49,$01,($EB+00)&$FF
		.BYTE	$EB,$4A,$01,($EB+08)&$FF
		.BYTE	$EB,$4B,$01,($EB+16)&$FF
		.BYTE	$EB,$4C,$01,($EB+24)&$FF
		
		.BYTE	$F3,$4D,$01,($EB+00)&$FF
		.BYTE	$F3,$4E,$01,($EB+08)&$FF
		.BYTE	$F3,$4F,$01,($EB+16)&$FF
		.BYTE	$F3,$50,$01,($EB+24)&$FF
		
		.BYTE	$FB,$51,$01,($EB+16-2)&$FF
		.BYTE	$FB,$52,$01,($EB+24-2)&$FF
		
FRAME_36_SUPER:	.WORD  FRAME_36_super_cfg,FRAME_36_super_cfg,FRAME_36_super_cfg,FRAME_36_super_cfg

FRAME_36_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8-8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E7,$18,$01,($D9+08)&$FF
		.BYTE	$E7,$19,$01,($D9+16)&$FF
		.BYTE	$E7,$1A,$01,($D9+24)&$FF
		
		.BYTE	$EF,$1B,$01,($D9+00)&$FF
		.BYTE	$EF,$1C,$01,($D9+08)&$FF
		.BYTE	$EF,$1D,$01,($D9+16)&$FF
		.BYTE	$EF,$1E,$01,($D9+24)&$FF
		.BYTE	$EF,$1F,$01,($D9+32)&$FF
		
		.BYTE	$F7,$20,$01,($D9+08)&$FF
		.BYTE	$F7,$21,$01,($D9+16)&$FF
		.BYTE	$F7,$22,$01,($D9+24)&$FF
		.BYTE	$F7,$23,$01,($D9+32)&$FF
		
		.BYTE	$FF,$24,$01,($D9+24)&$FF
		.BYTE	$FF,$25,$01,($D9+32)&$FF
		
FRAME_47_SUPER:	.WORD  FRAME_47_super_cfg,FRAME_47_super_cfg,FRAME_47_super_cfg,FRAME_47_super_cfg

FRAME_47_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8-1	; X_offset (center for H-Mirror)
		.BYTE	$3B*2 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$52,$01,($EA+08)&$FF
		
		.BYTE	$E0,$53,$01,($EA+00)&$FF
		.BYTE	$E0,$54,$01,($EA+08)&$FF
		.BYTE	$E0,$55,$01,($EA+16)&$FF
		
		.BYTE	$E8,$56,$01,($EA+00)&$FF
		.BYTE	$E8,$57,$01,($EA+08)&$FF
		.BYTE	$E8,$58,$01,($EA+16)&$FF
		
		.BYTE	$F0,$59,$01,($EA+00)&$FF
		.BYTE	$F0,$5A,$01,($EA+08)&$FF
		.BYTE	$F0,$5B,$01,($EA+16)&$FF
		.BYTE	$F0,$5C,$01,($EA+24)&$FF
		
		.BYTE	$F8,$5D,$01,($EA+08)&$FF
		.BYTE	$F8,$5E,$01,($EA+16)&$FF
		.BYTE	$F8,$5F,$01,($EA+24)&$FF
		
		
FRAME_37_SUPER:	.WORD  FRAME_37_super_cfg,FRAME_37_super_cfg,FRAME_37_super_cfg,FRAME_37_super_cfg

FRAME_37_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E5,$0D,$01,($E0+08)&$FF
		.BYTE	$E5,$0E,$01,($E0+16)&$FF
		.BYTE	$E5,$0F,$01,($E0+24)&$FF
		
		.BYTE	$ED,$10,$01,($E0+00)&$FF
		.BYTE	$ED,$11,$01,($E0+08)&$FF
		.BYTE	$ED,$12,$01,($E0+16)&$FF
		.BYTE	$ED,$13,$01,($E0+24)&$FF
		
		.BYTE	$F5,$14,$01,($E0+08)&$FF
		.BYTE	$F5,$15,$01,($E0+16)&$FF
		.BYTE	$F5,$16,$01,($E0+24)&$FF
		.BYTE	$F5,$17,$01,($E0+32)&$FF
		
		.BYTE	$FD,$18,$01,($E0+24-2)&$FF
		.BYTE	$FD,$19,$01,($E0+32-2)&$FF
		
FRAME_48_SUPER:	.WORD  FRAME_48_super_cfg,FRAME_48_super_cfg,FRAME_48_super_cfg,FRAME_48_super_cfg

FRAME_48_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8-1	; X_offset (center for H-Mirror)
		.BYTE	$3B*2+1 	; bank
		.BYTE	$04
		.BYTE	$F8+2	; Y_offset (for V-Mirror)
		
		.BYTE	$DE,$53,$01,($E9+00)&$FF
		.BYTE	$DE,$54,$01,($E9+08)&$FF
		
		.BYTE	$E6,$55,$01,($E9+00)&$FF
		.BYTE	$E6,$56,$01,($E9+08)&$FF
		.BYTE	$E6,$57,$01,($E9+16)&$FF
		
		.BYTE	$EE,$58,$01,($E9+00)&$FF
		.BYTE	$EE,$59,$01,($E9+08)&$FF
		.BYTE	$EE,$5A,$01,($E9+16)&$FF
		.BYTE	$EE,$5B,$01,($E9+24)&$FF
		
		.BYTE	$F6,$5C,$01,($E9+08-1)&$FF
		.BYTE	$F6,$5D,$01,($E9+16-1)&$FF
		.BYTE	$F6,$5E,$01,($E9+24-1)&$FF
		
		.BYTE	$FE,$5F,$01,($E9+16+3)&$FF

FRAME_38_SUPER:	.WORD  FRAME_38_super_cfg,FRAME_38_super_cfg,FRAME_38_super_cfg,FRAME_38_super_cfg

FRAME_38_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0
		.BYTE	$00	; Y_offset (for V-Mirror)
		
		.BYTE	$E4,$50,$01,($DF+08)&$FF
		.BYTE	$E4,$51,$01,($DF+16)&$FF
		.BYTE	$E4,$52,$01,($DF+24)&$FF
		
		.BYTE	$EC,$53,$01,($DF+00)&$FF
		.BYTE	$EC,$54,$01,($DF+08)&$FF
		.BYTE	$EC,$55,$01,($DF+16)&$FF
		.BYTE	$EC,$56,$01,($DF+24)&$FF
		.BYTE	$EC,$57,$01,($DF+32)&$FF
		
		.BYTE	$F4,$58,$01,($DF+08)&$FF
		.BYTE	$F4,$59,$01,($DF+16)&$FF
		.BYTE	$F4,$5A,$01,($DF+24)&$FF
		.BYTE	$F4,$5B,$01,($DF+32)&$FF
		
		.BYTE	$FC,$5C,$01,($DF+16)&$FF
		.BYTE	$FC,$5D,$01,($DF+24)&$FF

		.BYTE	$04,$5E,$01,($DF+24)&$FF
		
FRAME_49_SUPER:	.WORD  FRAME_49_super_cfg,FRAME_49_super_cfg,FRAME_49_super_cfg,FRAME_49_super_cfg

FRAME_49_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8-1	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0
		.BYTE	$F8+2	; Y_offset (for V-Mirror)
		
		.BYTE	$DB,$10,$01,($E2+08)&$FF
		.BYTE	$DB,$11,$01,($E2+16)&$FF
		
		.BYTE	$E3,$12,$01,($E2+00)&$FF
		.BYTE	$E3,$13,$01,($E2+08)&$FF
		.BYTE	$E3,$14,$01,($E2+16)&$FF
		
		.BYTE	$EB,$15,$01,($E2+00)&$FF
		.BYTE	$EB,$16,$01,($E2+08)&$FF
		.BYTE	$EB,$17,$01,($E2+16)&$FF
		.BYTE	$EB,$18,$01,($E2+24)&$FF
		
		.BYTE	$F3,$19,$01,($E2+08)&$FF
		.BYTE	$F3,$1A,$01,($E2+16)&$FF
		.BYTE	$F3,$1B,$01,($E2+24)&$FF
		
		.BYTE	$FB,$1C,$01,($E2+08)&$FF
		.BYTE	$FB,$1D,$01,($E2+16)&$FF
		
		.BYTE	$EF,$1E,$01,($E2+32)&$FF

; ---------------------------------------------
CORRER_ACOSTADO_X1_SUPER:
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $81,$00
CORRER_ACOSTADO_X2_SUPER:
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $01,$00
.word  FRAME_30_SUPER
 .byte  $01,$00
.word  FRAME_31_SUPER
 .byte  $81,$00
 
; vertical run frame 1
FRAME_30_SUPER:	.WORD  FRAME_30_super_cfg,FRAME_30_super_cfg,FRAME_30_super_cfg,FRAME_30_super_cfg

FRAME_30_super_cfg:
		.BYTE	12+$80	; 12 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F0,$11,$01,($E8+00)&$FF
		.BYTE	$F0,$12,$01,($E8+08)&$FF
		.BYTE	$F0,$13,$01,($E8+16)&$FF
		
		.BYTE	$F8,$14,$01,($E8+00+3)&$FF
		.BYTE	$F8,$15,$01,($E8+08+3)&$FF
		.BYTE	$F8,$16,$01,($E8+16+3)&$FF
		
		.BYTE	$00,$17,$01,($E8+00)&$FF
		.BYTE	$00,$18,$01,($E8+08)&$FF
		.BYTE	$00,$19,$01,($E8+16)&$FF
		.BYTE	$00,$1A,$01,($E8+24)&$FF
		
		.BYTE	$08,$1B,$01,($E8+00+16)&$FF
		.BYTE	$08,$1C,$01,($E8+08+16)&$FF

; vertical run frame 2
FRAME_31_SUPER:	.WORD  FRAME_31_super_cfg,FRAME_31_super_cfg,FRAME_31_super_cfg,FRAME_31_super_cfg

FRAME_31_super_cfg:
		.BYTE	12+$80	; 12 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F0,$1D,$01,($E8+00)&$FF
		.BYTE	$F0,$1E,$01,($E8+08)&$FF
		.BYTE	$F0,$13,$01,($E8+16)&$FF
		
		.BYTE	$F8,$1F,$01,($E8+00+3)&$FF
		.BYTE	$F8,$15,$01,($E8+08+3)&$FF
		.BYTE	$F8,$16,$01,($E8+16+3)&$FF
		
		.BYTE	$00,$20,$01,($E8+00)&$FF
		.BYTE	$00,$21,$01,($E8+08)&$FF
		.BYTE	$00,$22,$01,($E8+16)&$FF
		.BYTE	$00,$23,$01,($E8+24)&$FF
		
		.BYTE	$08,$24,$01,($E8+00+16)&$FF
		.BYTE	$08,$25,$01,($E8+08+16)&$FF

; ---------------------------------------------
CAMINAR_ACOSTADO_X1_SUPER:
.word  FRAME_29_SUPER
 .byte  $04,$00
.word  FRAME_2A_SUPER
 .byte  $04,$00
.word  FRAME_2B_SUPER
 .byte  $04,$00
.word  FRAME_2C_SUPER
 .byte  $04,$00
.word  FRAME_2D_SUPER
 .byte  $04,$00
.word  FRAME_2E_SUPER
 .byte  $04,$00
.word  FRAME_2F_SUPER
 .byte  $04,$00
.word  FRAME_2C_SUPER
 .byte  $04,$00
.word  FRAME_2B_SUPER
 .byte  $04,$00
.word  FRAME_2A_SUPER
 .byte  $81,$00
CAMINAR_ACOSTADO_X2_SUPER:
.word  FRAME_29_SUPER
 .byte  $02,$00
.word  FRAME_2A_SUPER
 .byte  $02,$00
.word  FRAME_2B_SUPER
 .byte  $02,$00
.word  FRAME_2C_SUPER
 .byte  $02,$00
.word  FRAME_2D_SUPER
 .byte  $02,$00
.word  FRAME_2E_SUPER
 .byte  $02,$00
.word  FRAME_2F_SUPER
 .byte  $02,$00
.word  FRAME_2C_SUPER
 .byte  $02,$00
.word  FRAME_2B_SUPER
 .byte  $02,$00
.word  FRAME_2A_SUPER
 .byte  $81,$00
CAMINAR_ACOSTADO_X3_SUPER:
.word  FRAME_29_SUPER
 .byte  $01,$00
.word  FRAME_2A_SUPER
 .byte  $01,$00
.word  FRAME_2B_SUPER
 .byte  $01,$00
.word  FRAME_2C_SUPER
 .byte  $01,$00
.word  FRAME_2D_SUPER
 .byte  $01,$00
.word  FRAME_2E_SUPER
 .byte  $01,$00
.word  FRAME_2F_SUPER
 .byte  $01,$00
.word  FRAME_2C_SUPER
 .byte  $01,$00
.word  FRAME_2B_SUPER
 .byte  $01,$00
.word  FRAME_2A_SUPER
 .byte  $81,$00
 
; vertical walk frame 1
FRAME_29_SUPER:	.WORD  FRAME_29_super_cfg,FRAME_29_super_cfg,FRAME_29_super_cfg,FRAME_29_super_cfg

FRAME_29_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F9,$00,$01,($E0+16)&$FF
		
		.BYTE	$FC,$01,$01,($E0+00)&$FF
		.BYTE	$FC,$02,$01,($E0+08)&$FF
		.BYTE	$01,$03,$01,($E0+16)&$FF
		.BYTE	$FC,$04,$00,($E0+24)&$FF
		.BYTE	$FC,$05,$00,($E0+32)&$FF
		
		.BYTE	$04,$06,$01,($E0+00)&$FF
		.BYTE	$04,$07,$01,($E0+08)&$FF
		.BYTE	$09,$08,$01,($E0+16)&$FF
		.BYTE	$04,$09,$01,($E0+24)&$FF
		.BYTE	$04,$0A,$00,($E0+32)&$FF
		
		.BYTE	$0C,$0B,$01,($E0+00)&$FF
		.BYTE	$0C,$0C,$01,($E0+08)&$FF
		
; vertical walk frame 2
FRAME_2E_SUPER:	.WORD  FRAME_2E_super_cfg,FRAME_2E_super_cfg,FRAME_2E_super_cfg,FRAME_2E_super_cfg

FRAME_2E_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F0	; Y_offset (for V-Mirror)
		
		.BYTE	$F2,$0D,$01,($E0+08)&$FF
		.BYTE	$F1,$00,$01,($E0+16)&$FF
		.BYTE	$F0,$0E,$01,($E0+24)&$FF ; shared with FRAME_29_SUPER
		.BYTE	$F0,$0F,$01,($E0+32)&$FF
		
		.BYTE	$F8,$10,$01,($E0+00)&$FF
		.BYTE	$FA,$11,$01,($E0+08)&$FF ; shared with FRAME_29_SUPER
		.BYTE	$F9,$03,$01,($E0+16)&$FF
		.BYTE	$F8,$12,$01,($E0+24)&$FF
		.BYTE	$F8,$13,$01,($E0+32)&$FF
		
		.BYTE	$00,$14,$01,($E0+00)&$FF
		.BYTE	$02,$15,$01,($E0+08)&$FF
		.BYTE	$01,$16,$01,($E0+16)&$FF
		.BYTE	$00,$17,$01,($E0+24)&$FF
		.BYTE	$00,$18,$01,($E0+32)&$FF
		
		.BYTE	$08,$19,$01,($E0+00)&$FF
		
; vertical walk frame 3
FRAME_2F_SUPER:	.WORD  FRAME_2F_super_cfg,FRAME_2F_super_cfg,FRAME_2F_super_cfg,FRAME_2F_super_cfg

FRAME_2F_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F4,$1C,$01,($E0+08)&$FF
		.BYTE	$F4,$1D,$01,($E0+16)&$FF
		.BYTE	$F4,$1E,$01,($E0+24)&$FF
		.BYTE	$F4,$1F,$01,($E0+32)&$FF
		
		.BYTE	$FC,$20,$01,($E0+00)&$FF
		.BYTE	$FC,$21,$01,($E0+08)&$FF
		.BYTE	$FC,$22,$01,($E0+16)&$FF
		.BYTE	$FC,$23,$01,($E0+24)&$FF
		.BYTE	$FC,$24,$01,($E0+32)&$FF
		
		.BYTE	$04,$25,$01,($E0+00)&$FF
		.BYTE	$04,$26,$01,($E0+08)&$FF
		.BYTE	$04,$27,$01,($E0+16)&$FF
		.BYTE	$04,$28,$01,($E0+24)&$FF
		.BYTE	$04,$29,$01,($E0+32)&$FF
		
		.BYTE	$0C,$2A,$01,($E0+00)&$FF
		
; vertical walk frame 4
FRAME_2D_SUPER:	.WORD  FRAME_2D_super_cfg,FRAME_2D_super_cfg,FRAME_2D_super_cfg,FRAME_2D_super_cfg

FRAME_2D_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F8,$2B,$01,($E0+00)&$FF
		.BYTE	$F8,$2C,$01,($E0+08)&$FF
		.BYTE	$F8,$2D,$01,($E0+16)&$FF
		.BYTE	$F8,$2E,$01,($E0+24)&$FF
		.BYTE	$F8,$2F,$01,($E0+32)&$FF
		
		.BYTE	$00,$30,$01,($E0+00)&$FF
		.BYTE	$00,$31,$01,($E0+08)&$FF
		.BYTE	$00,$32,$01,($E0+16)&$FF
		.BYTE	$00,$33,$01,($E0+24)&$FF
		.BYTE	$00,$34,$01,($E0+32)&$FF
		
		.BYTE	$08,$35,$01,($E0+00)&$FF
		.BYTE	$08,$36,$01,($E0+08)&$FF
		.BYTE	$08,$37,$01,($E0+16)&$FF
		
; vertical walk frame 5
FRAME_2C_SUPER:	.WORD  FRAME_2C_super_cfg,FRAME_2C_super_cfg,FRAME_2C_super_cfg,FRAME_2C_super_cfg

FRAME_2C_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F8,$38,$01,($E0+00)&$FF
		.BYTE	$F8,$39,$01,($E0+08)&$FF
		.BYTE	$F8,$3A,$01,($E0+16)&$FF
		.BYTE	$F8,$3B,$01,($E0+24)&$FF
		.BYTE	$F8,$3C,$01,($E0+32)&$FF
		
		.BYTE	$00,$3D,$01,($E0+00)&$FF
		.BYTE	$00,$3E,$01,($E0+08)&$FF
		.BYTE	$00,$3F,$01,($E0+16)&$FF
		.BYTE	$00,$40,$01,($E0+24)&$FF
		.BYTE	$00,$41,$01,($E0+32)&$FF
		
		.BYTE	$08,$42,$01,($E0+00)&$FF
		.BYTE	$08,$43,$01,($E0+08)&$FF
		.BYTE	$08,$44,$01,($E0+16)&$FF
		
; vertical walk frame 6
FRAME_2A_SUPER:	.WORD  FRAME_2A_super_cfg,FRAME_2A_super_cfg,FRAME_2A_super_cfg,FRAME_2A_super_cfg

FRAME_2A_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F0	; Y_offset (for V-Mirror)
		
		.BYTE	$F0+2,$45,$01,($E0+00)&$FF
		.BYTE	$F0+1,$46,$01,($E0+08)&$FF
		.BYTE	$F0,$47,$01,($E0+16)&$FF
		.BYTE	$F0,$48,$01,($E0+24)&$FF
		.BYTE	$F0,$49,$01,($E0+32)&$FF
		
		.BYTE	$F8+2,$4A,$01,($E0+00)&$FF
		.BYTE	$F8+1,$4B,$01,($E0+08)&$FF
		.BYTE	$F8,$4C,$01,($E0+16)&$FF
		.BYTE	$F8,$4D,$01,($E0+24)&$FF
		.BYTE	$F8,$4E,$01,($E0+32)&$FF
		
		.BYTE	$00+2,$4F,$01,($E0+00)&$FF
		.BYTE	$00+1,$50,$01,($E0+08)&$FF
		.BYTE	$00,$51,$01,($E0+16)&$FF
		.BYTE	$00,$52,$01,($E0+24)&$FF
		.BYTE	$00,$53,$01,($E0+32)&$FF

; vertical walk frame 7
FRAME_2B_SUPER:	.WORD  FRAME_2B_super_cfg,FRAME_2B_super_cfg,FRAME_2B_super_cfg,FRAME_2B_super_cfg

FRAME_2B_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8+2	; X_offset (center for H-Mirror)
		.BYTE	$3D*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$F4,$54,$01,($E2+00)&$FF
		.BYTE	$F4,$55,$01,($E2+08)&$FF
		.BYTE	$F4,$56,$01,($E2+16)&$FF
		.BYTE	$F4,$57,$01,($E2+24)&$FF
		.BYTE	$F4,$58,$01,($E2+32)&$FF
		
		.BYTE	$FC,$59,$01,($E2+00)&$FF
		.BYTE	$FC,$5A,$01,($E2+08)&$FF
		.BYTE	$FC,$5B,$01,($E2+16)&$FF
		.BYTE	$FC,$5C,$01,($E2+24)&$FF
		.BYTE	$FC,$5D,$01,($E2+32)&$FF
		
		.BYTE	$04,$5E,$01,($E0+00+3)&$FF
		.BYTE	$04,$5F,$01,($E0+08+3)&$FF
		.BYTE	$04,$1A,$01,($E0+16+3)&$FF
		.BYTE	$04,$1B,$01,($E0+24+3)&$FF

CORRER_45_ARRIBA_X1_SUPER:
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER 
.byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $81,$00
CORRER_45_ARRIBA_X2_SUPER:
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER 
.byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $01,$00
.word  FRAME_3A_SUPER
 .byte  $01,$00
.word  FRAME_3B_SUPER
 .byte  $81,$00
 
CORRER_45_ABAJO_X1_SUPER:
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $81,$00
CORRER_45_ABAJO_X2_SUPER:
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $01,$00
.word  FRAME_4B_SUPER
 .byte  $01,$00
.word  FRAME_4C_SUPER
 .byte  $81,$00
 
 
; diagonal run frame 1
FRAME_3A_SUPER:	.WORD  FRAME_3A_super_cfg,FRAME_3A_super_cfg,FRAME_3A_super_cfg,FRAME_3A_super_cfg

FRAME_3A_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E4,$20,$01,($EC+00+4)&$FF
		.BYTE	$E4,$21,$01,($EC+08+4)&$FF
		.BYTE	$E4,$22,$01,($EC+16+4)&$FF
		
		.BYTE	$EC,$23,$01,($EC+00)&$FF
		.BYTE	$EC,$24,$01,($EC+08)&$FF
		.BYTE	$EC,$25,$01,($EC+16)&$FF
		.BYTE	$EC,$26,$01,($EC+24)&$FF
		
		.BYTE	$F4,$27,$01,($EC+00)&$FF
		.BYTE	$F4,$28,$01,($EC+08)&$FF
		.BYTE	$F4,$29,$01,($EC+16)&$FF
		
		.BYTE	$FC,$2A,$01,($EC+08)&$FF
		.BYTE	$FC,$2B,$01,($EC+16)&$FF
		
		.BYTE	$04,$2C,$01,($EC+08+1)&$FF
		
; diagonal run frame 1 (rotated 90)
FRAME_4B_SUPER:	.WORD  FRAME_4B_super_cfg,FRAME_4B_super_cfg,FRAME_4B_super_cfg,FRAME_4B_super_cfg

FRAME_4B_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E4,$40,$01,($F2+08)&$FF
		
		.BYTE	$EC,$41,$01,($F2+00)&$FF
		.BYTE	$EC,$42,$01,($F2+08)&$FF
		.BYTE	$EC,$43,$01,($F2+16)&$FF
		.BYTE	$EC,$44,$01,($F2+24)&$FF
		
		.BYTE	$F4,$45,$01,($F2+00)&$FF
		.BYTE	$F4,$46,$01,($F2+08)&$FF
		.BYTE	$F4,$47,$01,($F2+16)&$FF
		.BYTE	$F4,$48,$01,($F2+24)&$FF
		.BYTE	$F4,$49,$01,($F2+32)&$FF
		
		.BYTE	$FC,$4A,$01,($F2+00)&$FF
		.BYTE	$FC,$4B,$01,($F2+08)&$FF
		.BYTE	$FC,$4C,$01,($F2+16)&$FF
		
		
; diagonal run frame 2
FRAME_3B_SUPER:	.WORD  FRAME_3B_super_cfg,FRAME_3B_super_cfg,FRAME_3B_super_cfg,FRAME_3B_super_cfg

FRAME_3B_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E4-2,$30,$01,($E7+08)&$FF
		.BYTE	$E4-2,$31,$01,($E7+16)&$FF
		.BYTE	$E4-2,$32,$01,($E7+24)&$FF
		
		.BYTE	$EC-2,$33,$01,($E7+00)&$FF
		.BYTE	$EC-2,$34,$01,($E7+08)&$FF
		.BYTE	$EC-2,$35,$01,($E7+16)&$FF
		.BYTE	$EC-2,$36,$01,($E7+24)&$FF
		
		.BYTE	$F4-2,$37,$01,($E7+08)&$FF
		.BYTE	$F4-2,$38,$01,($E7+16)&$FF
		.BYTE	$F4-2,$39,$01,($E7+24)&$FF
		
		.BYTE	$FC-2,$3A,$01,($E7+08+1)&$FF
		.BYTE	$FC-2,$3B,$01,($E7+16+1)&$FF
		
		.BYTE	$04-2,$3C,$01,($E7+16)&$FF
		
		
; diagonal run frame 2 (rotated 90)
FRAME_4C_SUPER:	.WORD  FRAME_4C_super_cfg,FRAME_4C_super_cfg,FRAME_4C_super_cfg,FRAME_4C_super_cfg

FRAME_4C_super_cfg:
		.BYTE	13+$80	; 13 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E4-1,$50,$01,($F0+08)&$FF
		
		.BYTE	$EC-1,$51,$01,($F0+00)&$FF
		.BYTE	$EC-1,$52,$01,($F0+08)&$FF
		.BYTE	$EC-1,$53,$01,($F0+16)&$FF
		.BYTE	$EC-1,$54,$01,($F0+24)&$FF
		
		.BYTE	$F4-1,$55,$01,($F0+00)&$FF
		.BYTE	$F4-1,$56,$01,($F0+08)&$FF
		.BYTE	$F4-1,$57,$01,($F0+16)&$FF
		.BYTE	$F4-1,$58,$01,($F0+24)&$FF
		.BYTE	$F4-1,$59,$01,($F0+32)&$FF
		
		.BYTE	$FC-1,$5A,$01,($F0+00+2)&$FF
		.BYTE	$FC-1,$5B,$01,($F0+08+2)&$FF
		.BYTE	$FC-1,$5C,$01,($F0+16+2)&$FF
		
		
; AIR BUBBLE
TOMAR_AIRE_SUPER:
		.WORD  FRAME_00_SUPER
		.BYTE  $01,$00
		.WORD  FRAME_00_SUPER
		.BYTE  $80,$00
		
FRAME_00_SUPER:	.WORD  FRAME_00_super_cfg,FRAME_00_super_cfg,FRAME_00_super_cfg,FRAME_00_super_cfg

FRAME_00_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$F8	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$D8,$26,$01,($F3+00)&$FF
		.BYTE	$D8+3,$27,$01,($F3+08)&$FF
		
		.BYTE	$E0,$28,$01,($F3+00)&$FF
		.BYTE	$E0+3,$29,$01,($F3+08)&$FF
		.BYTE	$E0,$2A,$01,($F3+16)&$FF
		
		.BYTE	$E8,$2B,$01,($F3+00)&$FF
		.BYTE	$E8+3,$2C,$01,($F3+08)&$FF
		.BYTE	$E8,$2D,$01,($F3+16)&$FF
		
		.BYTE	$F0,$2E,$01,($F3+00)&$FF
		.BYTE	$F0+3,$2F,$01,($F3+08)&$FF
		.BYTE	$F0,$30,$01,($F3+16)&$FF
		
		.BYTE	$F8,$31,$01,($F3+00)&$FF
		.BYTE	$F8,$32,$01,($F3+16)&$FF
		
		.BYTE	$E0,$33,$01,($F3-08)&$FF
		
; ---------------------------------------------

; SKID
RESBALANDO_SUPER:
		.WORD  FRAME_10_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_54_SUPER
		.BYTE  $7F,$00
		.WORD  FRAME_54_SUPER
		.BYTE  $80,$00

FRAME_10_SUPER:	.WORD  FRAME_10_super_cfg,FRAME_10_super_cfg,FRAME_10_super_cfg,FRAME_10_super_cfg
		
FRAME_10_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$DD,$00,$01,($F5+00)&$FF
		.BYTE	$DD,$01,$01,($F5+08)&$FF
		.BYTE	$DD,$02,$01,($F5+16)&$FF
		
		.BYTE	$E5,$03,$01,($F5+00)&$FF
		.BYTE	$E5,$04,$01,($F5+08)&$FF
		.BYTE	$E5,$05,$01,($F5+16)&$FF
		.BYTE	$E5,$06,$01,($F5+24)&$FF
		
		.BYTE	$ED,$07,$01,($F5+00)&$FF
		.BYTE	$ED,$08,$01,($F5+08)&$FF
		.BYTE	$ED,$09,$01,($F5+16)&$FF
		.BYTE	$ED,$0A,$01,($F5+24)&$FF
		
		.BYTE	$F5,$0B,$01,($F4+08)&$FF
		.BYTE	$F5,$0C,$01,($F4+16)&$FF
		.BYTE	$F5,$0D,$01,($F4+24)&$FF

		.BYTE	$FD,$0E,$01,($F5+16+3)&$FF


FRAME_54_SUPER:	.WORD  FRAME_54_super_cfg,FRAME_54_super_cfg,FRAME_54_super_cfg,FRAME_54_super_cfg
		
FRAME_54_super_cfg:
		.BYTE	15+$80	; 15 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3C*2 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$DD,$2D,$01,($F3+08)&$FF
		.BYTE	$DD,$2E,$01,($F3+16)&$FF
		.BYTE	$DD,$2F,$01,($F3+24)&$FF
		
		.BYTE	$E5,$3D,$01,($F5+00)&$FF
		.BYTE	$E5,$3E,$01,($F5+08)&$FF
		.BYTE	$E5,$3F,$01,($F5+16)&$FF
		.BYTE	$E5,$0F,$01,($F5+24)&$FF
		
		.BYTE	$ED,$4D,$01,($F5+00)&$FF
		.BYTE	$ED,$4E,$01,($F5+08)&$FF
		.BYTE	$ED,$4F,$01,($F5+16)&$FF
		.BYTE	$ED,$1F,$01,($F5+24)&$FF
		
		.BYTE	$F5,$5D,$01,($F4+08)&$FF
		.BYTE	$F5,$5E,$01,($F4+16)&$FF
		.BYTE	$F5,$0D,$01,($F4+24)&$FF

		.BYTE	$FD,$0E,$01,($F5+16+3)&$FF

; GET HIT
GET_HIT_ANIM_SUPER:
		.WORD  FRAME_14_SUPER
		.BYTE  $0A,$00
		.WORD  FRAME_14_SUPER
		.BYTE  $80,$00

; WATERFALL
WATERFALL_ANIM_SUPER:
		.WORD  FRAME_14_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_53_SUPER
		.BYTE  $08,$00
		.WORD  FRAME_14_SUPER
		.BYTE  $80,$00
		
FRAME_14_SUPER:	.WORD  FRAME_14_super_cfg,FRAME_14_super_cfg,FRAME_14_super_cfg,FRAME_14_super_cfg

FRAME_14_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$34,$01,($F5+00)&$FF
		.BYTE	$E0,$35,$01,($F5+08)&$FF
		.BYTE	$E0,$36,$01,($F5+16)&$FF
		
		.BYTE	$E8,$37,$01,($F5+00)&$FF
		.BYTE	$E8,$38,$01,($F5+08)&$FF
		.BYTE	$E8,$39,$01,($F5+16)&$FF
		.BYTE	$E8,$3A,$01,($F5+24)&$FF
		
		.BYTE	$F0,$3B,$01,($F5+00)&$FF
		.BYTE	$F0,$3C,$01,($F5+08)&$FF
		.BYTE	$F0,$3D,$01,($F5+16)&$FF
		.BYTE	$F0,$3E,$01,($F5+24)&$FF
		
		.BYTE	$F8,$3F,$01,($F5+08)&$FF
		.BYTE	$F8,$40,$01,($F5+16)&$FF
		.BYTE	$F8,$41,$01,($F5+24)&$FF
		
		
FRAME_53_SUPER:	.WORD  FRAME_53_super_cfg,FRAME_53_super_cfg,FRAME_53_super_cfg,FRAME_53_super_cfg

FRAME_53_super_cfg:
		.BYTE	14+$80	; 14 sprites + new mode flag
		.BYTE	$00	; X_offset (center for H-Mirror)
		.BYTE	$3D*2+1 	; bank
		.BYTE	0	; --
		.BYTE	$F8	; Y_offset (for V-Mirror)
		
		.BYTE	$E0,$42,$01,($F5+00)&$FF
		.BYTE	$E0,$43,$01,($F5+08)&$FF
		.BYTE	$E0,$44,$01,($F5+16)&$FF
		
		.BYTE	$E8,$45,$01,($F5+00)&$FF
		.BYTE	$E8,$46,$01,($F5+08)&$FF
		.BYTE	$E8,$47,$01,($F5+16)&$FF
		.BYTE	$E8,$48,$01,($F5+24)&$FF
		
		.BYTE	$F0,$49,$01,($F5+00)&$FF
		.BYTE	$F0,$4A,$01,($F5+08)&$FF
		.BYTE	$F0,$4B,$01,($F5+16)&$FF
		.BYTE	$F0,$4C,$01,($F5+24)&$FF
		
		.BYTE	$F8,$4D,$01,($F5+08)&$FF
		.BYTE	$F8,$4E,$01,($F5+16)&$FF
		.BYTE	$F8,$4F,$01,($F5+24)&$FF
		