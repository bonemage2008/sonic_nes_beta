MACRO	spheres6_x00
	.BYTE	$14,$37,$5A,$7C,$9E,$C1,$E4
ENDM	

MACRO	spheres6_x80
	.BYTE	$12,$35,$59,$7C,$9F,$C3,$E6
ENDM	


draw_sp_x00:
		.BYTE	$15,$78,$DC
		.BYTE	$34,$78,$BC
		.BYTE	$14,$46,$78,$AD,$de
		.BYTE	$00,$27,$52,$7C,$A6,$D1,$F8
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
		
draw_sp_x08:
		.BYTE	$13,$78,$DE
		.BYTE	$33,$78,$BD
		.BYTE	$14,$46,$78,$AD,$de
		.BYTE	$00,$27,$52,$7C,$A6,$D1,$F8
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
		
draw_sp_x10:
		.BYTE	$11,$78,$E0
		.BYTE	$32,$78,$BE
		.BYTE	$12,$45,$78,$AE,$e0
		.BYTE	$00,$27,$52,$7C,$A6,$D1,$F8
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00

draw_sp_x18:
		.BYTE	$0F,$78,$E2
		.BYTE	$31,$78,$BF
		.BYTE	$12,$45,$78,$AE,$e0
		.BYTE	$00,$27,$52,$7C,$A6,$D1,$F8
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
	
draw_sp_x20:
		.BYTE	$0D,$78,$E4
		.BYTE	$30,$78,$C0
		.BYTE	$10,$44,$78,$AF,$e2
		.BYTE	$ff,$25,$51,$7C,$A7,$D3,$FA
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
draw_sp_x28:
		.BYTE	$0B,$78,$E6
		.BYTE	$2F,$78,$C1
		.BYTE	$10,$44,$78,$AF,$e2
		.BYTE	$ff,$25,$51,$7C,$A7,$D3,$FA
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
draw_sp_x30:
		.BYTE	$09,$78,$E8
		.BYTE	$2E,$78,$C2
		.BYTE	$0E,$43,$78,$B0,$e4
		.BYTE	$ff,$25,$51,$7C,$A7,$D3,$FA
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
draw_sp_x38:
		.BYTE	$07,$78,$EA
		.BYTE	$2D,$78,$C3
		.BYTE	$0E,$43,$78,$B0,$e4
		.BYTE	$ff,$25,$51,$7C,$A7,$D3,$FA
		.BYTE	$0C,$32,$58,$7C,$A2,$C6,$EC
	spheres6_x00
draw_sp_x40:
		.BYTE	$05,$78,$EC
		.BYTE	$2C,$78,$C4
		.BYTE	$0C,$42,$78,$B1,$E6
		.BYTE	$FF,$23,$50,$7C,$A8,$D5,$FC
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x48:
		.BYTE	$03,$78,$EE
		.BYTE	$2B,$78,$C5
		.BYTE	$0C,$42,$78,$B1,$E6
		.BYTE	$FF,$23,$50,$7C,$A8,$D5,$FC
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x50:
		.BYTE	$01,$78,$F0
		.BYTE	$2A,$78,$C6
		.BYTE	$0A,$41,$78,$B2,$E8
		.BYTE	$FF,$23,$50,$7C,$A8,$D5,$FC
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x58:
		.BYTE	$00,$78,$F2
		.BYTE	$29,$78,$C7
		.BYTE	$0A,$41,$78,$B2,$E8
		.BYTE	$FF,$23,$50,$7C,$A8,$D5,$FC
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x60:
		.BYTE	$ff,$78,$F4
		.BYTE	$28,$78,$C8
		.BYTE	$08,$40,$78,$B3,$Ea
		.BYTE	$FF,$21,$4F,$7C,$A9,$D7,$FE
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x68:
		.BYTE	$ff,$78,$F6
		.BYTE	$27,$78,$C9
		.BYTE	$08,$40,$78,$B3,$Ea
		.BYTE	$FF,$21,$4F,$7C,$A9,$D7,$FE
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x70:
		.BYTE	$ff,$78,$ff
		.BYTE	$26,$78,$CA
		.BYTE	$06,$3F,$78,$B4,$Ec
		.BYTE	$FF,$21,$4F,$7C,$A9,$D7,$FE
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x78:
		.BYTE	$ff,$78,$ff
		.BYTE	$25,$78,$CB
		.BYTE	$06,$3F,$78,$B4,$Ec
		.BYTE	$FF,$21,$4F,$7C,$A9,$D7,$FE
		.BYTE	$0A,$30,$57,$7C,$A3,$C8,$EE
	spheres6_x00
draw_sp_x80:
		.BYTE	$ff,$78,$ff
		.BYTE	$24,$78,$CC
		.BYTE	$04,$3e,$78,$B5,$Ee
		.BYTE	$FF,$1F,$4E,$7C,$AA,$D9,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_x88:
		.BYTE	$ff,$78,$ff
		.BYTE	$23,$78,$CD
		.BYTE	$04,$3e,$78,$B5,$Ee
		.BYTE	$FF,$1F,$4E,$7C,$AA,$D9,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_x90:
		.BYTE	$ff,$78,$ff
		.BYTE	$22,$78,$CE
		.BYTE	$02,$3D,$78,$B6,$f0
		.BYTE	$FF,$1F,$4E,$7C,$AA,$D9,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_x98:
		.BYTE	$ff,$78,$ff
		.BYTE	$21,$78,$CF
		.BYTE	$02,$3D,$78,$B6,$f0
		.BYTE	$FF,$1F,$4E,$7C,$AA,$D9,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_xA0:
		.BYTE	$ff,$78,$ff
		.BYTE	$20,$78,$D0
		.BYTE	$00,$3C,$78,$B7,$F2
		.BYTE	$FF,$1D,$4D,$7C,$AB,$Db,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_xA8:
		.BYTE	$ff,$78,$ff
		.BYTE	$1F,$78,$D1
		.BYTE	$00,$3C,$78,$B7,$F2
		.BYTE	$FF,$1D,$4D,$7C,$AB,$Db,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_xB0:
		.BYTE	$ff,$78,$ff
		.BYTE	$1E,$78,$D2
		.BYTE	$ff,$3B,$78,$B8,$F4
		.BYTE	$FF,$1D,$4D,$7C,$AB,$Db,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_xB8:
		.BYTE	$ff,$78,$ff
		.BYTE	$1D,$78,$D3
		.BYTE	$ff,$3B,$78,$B8,$F4
		.BYTE	$FF,$1D,$4D,$7C,$AB,$Db,$ff
		.BYTE	$08,$2E,$56,$7C,$a4,$CA,$F0
		spheres6_x80
draw_sp_xC0:
		.BYTE	$ff,$78,$ff
		.BYTE	$1C,$78,$D4
		.BYTE	$ff,$3A,$78,$B9,$F6
		.BYTE	$FF,$1B,$4c,$7C,$AC,$Dd,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xC8:
		.BYTE	$ff,$78,$ff
		.BYTE	$1B,$78,$D5
		.BYTE	$ff,$3A,$78,$B9,$F6
		.BYTE	$FF,$1B,$4c,$7C,$AC,$Dd,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xD0:
		.BYTE	$ff,$78,$ff
		.BYTE	$1A,$78,$D6
		.BYTE	$ff,$39,$78,$BA,$ff
		.BYTE	$FF,$1B,$4c,$7C,$AC,$Dd,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xD8:
		.BYTE	$ff,$78,$ff
		.BYTE	$19,$78,$D7
		.BYTE	$ff,$39,$78,$BA,$ff
		.BYTE	$FF,$1B,$4c,$7C,$AC,$Dd,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xE0:
		.BYTE	$ff,$ff,$ff
		.BYTE	$18,$78,$D8
		.BYTE	$ff,$38,$78,$BB,$ff
		.BYTE	$FF,$19,$4b,$7C,$Ad,$df,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xE8:
		.BYTE	$ff,$ff,$ff
		.BYTE	$17,$78,$D9
		.BYTE	$ff,$38,$78,$BB,$ff
		.BYTE	$FF,$19,$4b,$7C,$Ad,$df,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xF0:
		.BYTE	$ff,$ff,$ff
		.BYTE	$16,$78,$DA
		.BYTE	$ff,$37,$78,$BC,$ff
		.BYTE	$FF,$19,$4b,$7C,$Ad,$df,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
draw_sp_xF8:
		.BYTE	$ff,$ff,$ff
		.BYTE	$15,$78,$DB
		.BYTE	$ff,$37,$78,$BC,$ff
		.BYTE	$FF,$19,$4b,$7C,$Ad,$df,$ff
		.BYTE	$06,$2C,$55,$7C,$a5,$CC,$f2
		spheres6_x80
		
draw_sp_y00:
		.BYTE	$B5,$B5,$B5
		.BYTE	$98,$98,$98
		.BYTE	$89,$89,$89,$89,$89
		.BYTE	$82,$82,$82,$82,$82,$82,$82
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
draw_sp_y08:
		.BYTE	$B7,$B7,$B7
		.BYTE	$99,$99,$99
		.BYTE	$89,$89,$89,$89,$89
		.BYTE	$82,$82,$82,$82,$82,$82,$82
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
draw_sp_y10:
		.BYTE	$B9,$B9,$B9
		.BYTE	$9A,$9A,$9A
		.BYTE	$8A,$8A,$8A,$8A,$8A
		.BYTE	$82,$82,$82,$82,$82,$82,$82
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
draw_sp_y18:
		.BYTE	$BB,$BB,$BB
		.BYTE	$9B,$9B,$9B
		.BYTE	$8A,$8A,$8A,$8A,$8A
		.BYTE	$82,$82,$82,$82,$82,$82,$82
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
		
draw_sp_y20:
		.BYTE	$BD,$BD,$BD
		.BYTE	$9C,$9C,$9C
		.BYTE	$8B,$8B,$8B,$8B,$8B
		.BYTE	$83,$83,$83,$83,$83,$83,$83
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y28:
		.BYTE	$BF,$BF,$BF
		.BYTE	$9D,$9D,$9D
		.BYTE	$8B,$8B,$8B,$8B,$8B
		.BYTE	$83,$83,$83,$83,$83,$83,$83
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A

draw_sp_y30:
		.BYTE	$C1,$C1,$C1
		.BYTE	$9E,$9E,$9E
		.BYTE	$8C,$8C,$8C,$8C,$8C
		.BYTE	$83,$83,$83,$83,$83,$83,$83
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y38:
		.BYTE	$C3,$C3,$C3
		.BYTE	$9F,$9F,$9F
		.BYTE	$8C,$8C,$8C,$8C,$8C
		.BYTE	$83,$83,$83,$83,$83,$83,$83
		.BYTE	$7D,$7D,$7D,$7D,$7D,$7D,$7D
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
		
draw_sp_y40:
		.BYTE	$C5,$C5,$C5
		.BYTE	$A0,$A0,$A0
		.BYTE	$8D,$8D,$8D,$8D,$8D
		.BYTE	$84,$84,$84,$84,$84,$84,$84
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y48:
		.BYTE	$C7,$C7,$C7
		.BYTE	$A1,$A1,$A1
		.BYTE	$8D,$8D,$8D,$8D,$8D
		.BYTE	$84,$84,$84,$84,$84,$84,$84
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y50:
		.BYTE	$C9,$C9,$C9
		.BYTE	$A2,$A2,$A2
		.BYTE	$8E,$8E,$8E,$8E,$8E
		.BYTE	$84,$84,$84,$84,$84,$84,$84
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y58:
		.BYTE	$CB,$CB,$CB
		.BYTE	$A3,$A3,$A3
		.BYTE	$8E,$8E,$8E,$8E,$8E
		.BYTE	$84,$84,$84,$84,$84,$84,$84
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y60:
		.BYTE	$CD,$CD,$CD
		.BYTE	$A4,$A4,$A4
		.BYTE	$8F,$8F,$8F,$8F,$8F
		.BYTE	$85,$85,$85,$85,$85,$85,$85
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y68:
		.BYTE	$CF,$CF,$CF
		.BYTE	$A5,$A5,$A5
		.BYTE	$8F,$8F,$8F,$8F,$8F
		.BYTE	$85,$85,$85,$85,$85,$85,$85
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
	
draw_sp_y70:
		.BYTE	$D1,$D1,$D1
		.BYTE	$A6,$A6,$A6
		.BYTE	$90,$90,$90,$90,$90
		.BYTE	$85,$85,$85,$85,$85,$85,$85
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
		
draw_sp_y78:
		.BYTE	$D3,$D3,$D3
		.BYTE	$A7,$A7,$A7
		.BYTE	$90,$90,$90,$90,$90
		.BYTE	$85,$85,$85,$85,$85,$85,$85
		.BYTE	$7E,$7E,$7E,$7E,$7E,$7E,$7E
	.BYTE	$7A,$7A,$7A,$7A,$7A,$7A,$7A
		
draw_sp_y80:
		.BYTE	$D5,$D5,$D5
		.BYTE	$A8,$A8,$A8
		.BYTE	$91,$91,$91,$91,$91
		.BYTE	$86,$86,$86,$86,$86,$86,$86
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_y88:
		.BYTE	$D7,$D7,$D7
		.BYTE	$A9,$A9,$A9
		.BYTE	$91,$91,$91,$91,$91
		.BYTE	$86,$86,$86,$86,$86,$86,$86
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B

draw_sp_y90:
		.BYTE	$D9,$D9,$D9
		.BYTE	$AA,$AA,$AA
		.BYTE	$92,$92,$92,$92,$92
		.BYTE	$86,$86,$86,$86,$86,$86,$86
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B

draw_sp_y98:
		.BYTE	$DB,$DB,$DB
		.BYTE	$AB,$AB,$AB
		.BYTE	$92,$92,$92,$92,$92
		.BYTE	$86,$86,$86,$86,$86,$86,$86
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yA0:
		.BYTE	$DD,$DD,$DD
		.BYTE	$AC,$AC,$AC
		.BYTE	$93,$93,$93,$93,$93
		.BYTE	$87,$87,$87,$87,$87,$87,$87
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yA8:
		.BYTE	$DF,$DF,$DF
		.BYTE	$AD,$AD,$AD
		.BYTE	$93,$93,$93,$93,$93
		.BYTE	$87,$87,$87,$87,$87,$87,$87
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yB0:
		.BYTE	$E1,$E1,$E1
		.BYTE	$AE,$AE,$AE
		.BYTE	$94,$94,$94,$94,$94
		.BYTE	$87,$87,$87,$87,$87,$87,$87
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yB8:	
		.BYTE	$E3,$E3,$E3
		.BYTE	$AF,$AF,$AF
		.BYTE	$94,$94,$94,$94,$94
		.BYTE	$87,$87,$87,$87,$87,$87,$87
		.BYTE	$7F,$7F,$7F,$7F,$7F,$7F,$7F
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yC0:
		.BYTE	$E5,$E5,$E5
		.BYTE	$B0,$B0,$B0
		.BYTE	$95,$95,$95,$95,$95
		.BYTE	$88,$88,$88,$88,$88,$88,$88
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yC8:
		.BYTE	$E7,$E7,$E7
		.BYTE	$B1,$B1,$B1
		.BYTE	$95,$95,$95,$95,$95
		.BYTE	$88,$88,$88,$88,$88,$88,$88
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yD0:
		.BYTE	$E9,$E9,$E9
		.BYTE	$B2,$B2,$B2
		.BYTE	$96,$96,$96,$96,$96
		.BYTE	$88,$88,$88,$88,$88,$88,$88
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yD8:
		.BYTE	$EB,$EB,$EB
		.BYTE	$B3,$B3,$B3
		.BYTE	$96,$96,$96,$96,$96
		.BYTE	$88,$88,$88,$88,$88,$88,$88
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yE0:
		.BYTE	$ED,$ED,$ED
		.BYTE	$B4,$B4,$B4
		.BYTE	$97,$97,$97,$97,$97
		.BYTE	$89,$89,$89,$89,$89,$89,$89
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yE8:
		.BYTE	$EF,$EF,$EF
		.BYTE	$B5,$B5,$B5
		.BYTE	$97,$97,$97,$97,$97
		.BYTE	$89,$89,$89,$89,$89,$89,$89
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yF0:
		.BYTE	$F0,$F0,$F0
		.BYTE	$B6,$B6,$B6
		.BYTE	$98,$98,$98,$98,$98
		.BYTE	$89,$89,$89,$89,$89,$89,$89
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B
		
draw_sp_yF8:
		.BYTE	$F0,$F0,$F0
		.BYTE	$B7,$B7,$B7
		.BYTE	$98,$98,$98,$98,$98
		.BYTE	$89,$89,$89,$89,$89,$89,$89
		.BYTE	$80,$80,$80,$80,$80,$80,$80
	.BYTE	$7B,$7B,$7B,$7B,$7B,$7B,$7B

