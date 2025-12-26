; memory map
		include	ram.asm	; orig
		include	vars.asm ; new

; global settings

OBJECTS_SLOTS = 28 ; max slots, original 23

REPLAY_WRITE = 0 ; 1 to write replay to ram $6400
TEST_SPR equ 1 ; include test sprites code

SBZ2_DISABLE = 0 ; 1 = disable SCRAP BRAIN ZONE ACT2, 2 = plus disable in cheat menu.

TEST_MODE = 0 ; one button cheat code, allow to select emeralds/special number.

TEST_SONIC_SPR = 0 ; use old anim ptrs pl_spr_cfg_ptrs while holding select button.

WATER_TIMEOUT = 48 ; 60 in Somari , 30 in original MD version
RINGS_DROP = 3 ; max rings to drop
CHECK_SUMM = 0

SHOES_TIMER = 15
INVIC_TIMER = 15 ; (20 equal to MD)
SPRING_MODE = 3 ; 0 = original, 1 = auto-roll on falling, 2 = roll by button, 3 = both.
SONIC_ACCEL = 6 ; 4 in somari, 6 in jabu hack

SONIC_JUMP_ACC = 4 ; 2 in somari, 3 in jabu hack ; spin in air (anim $08)
JUMP_MIN_SPEED = 32 ; 48 in original; minimal jump height

SONIC_INIT_ACC = 4 ; acceleration in first step (4 in somari)
SONIC_AIR_BRK = 6 ; brake value while in air (X_speed decrease value if hold reverse dir). only if [SPIN_CTRL=0], [JUMP_CTRL=0]
SONIC_AIR_ACC = 2  ; acceleration value while in air if hold same direction button:
                   ; 0-1 = lose X_speed, 2 = keep same X_speed value, 3 or greater - adds X_speed.
SONIC_AIR_ACC_SPIN  = 3	; spin in air (anim $20) accelaretion value.

SPIN_CTRL = 0 ; allow to accelerate and skid in spin (not equal MD)
SPIN_IN_AIR = 1 ; allow to spin in air if press down (not equal MD)
JUMP_CTRL = 1 ; allow to instant dir change in jump anim (not equal MD)
AIR_SKID = 2 ; allow to skid in air (not equal MD)
SONIC_SPIN_ACC = 6 ; only if [SPIN_CTRL=1]:  2 = keep same X_speed value, 3 or greater - adds X_speed.

VRC7 = 0 ; use vrc7 mapper

; for debug
	MACRO halt
	SEI
	LDA	#0
	STA	$2000
@halt	
	BEQ	@halt
	ENDM

; rom header	
		.db	'NES',$1A
		.db	$20 ; prg banks count
		.db	$20 ; chr banks count
		IF	(VRC7=0)
		.db	$40 ; mapper #4 - MMC3
		.dsb	9,0 ; clear the remaining bytes
		ELSE
		.db	$50 ; mapper #85 - VRC7
		.db	$50 ; mapper #85 - VRC7
		.dsb	8,0 ; clear the remaining bytes
		ENDIF
; end header	
		
		.base	$8000
		incbin	res\0x00010.bin ; GHZ
		.pad	$C000,$FF
		.base	$8000
		incbin	res\0x04010.bin ; MAR
		.pad	$C000,$FF
		.base	$8000
		incbin	res\0x08010.bin ; SPR
		.pad	$C000,$FF
		.base	$8000
		incbin	res\0x0C010.bin ; LAB
		.pad	$C000,$FF
		.base	$8000
		incbin	res\0x10010.bin ; STAR
		.pad	$C000,$FF
		.base	$8000
		incbin	res\0x14010.bin ; BNS+FINAL?
		.pad	$C000,$FF
		
		.base	$8000
		incbin	res\0x18010.bin ; STAR
		;.pad	$9600,$FF ; 19610
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_01_title_theme.asm ; 0,8 kb
		include	music_FMS_410\sonic_1_nes_ost_09_robotnik.asm ; 1 kb
		ENDIF
		.pad	$A000,$FF
		
		.base	$8000
		incbin	res\0x1A010.bin ; GHZ
		;.pad	$9600,$FF ; 1B610
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_03_marble_zone.asm ; 1,8 kb
		ENDIF
		.pad	$A000,$FF
		
		.base	$8000
		incbin	res\0x1C010.bin ; MAR
		;.pad	$9600,$FF ; 1D610
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_10_final_zone.asm ; 1 kb
		include	music_FMS_410\sonic_1_nes_ost_11_stage_clear.asm ; 0,9 kb
		ENDIF
		.pad	$A000,$FF
		
		.base	$8000
		incbin	res\0x1E010.bin ; SPR
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_12_ending_theme.asm ; 1,3 kb
		ENDIF
		
		;.pad	$9600,$FF ; 1F610
		.pad	$A000,$FF
		
		.base	$8000	; 20010
		incbin	res\0x20010.bin ; LAB
		;.pad	$9600,$FF ; 21610
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_08_special_stage.asm ; 1,5 kb
		ENDIF
		.pad	$A000,$FF
		
		.base	$8000	; 22010
		include	draw_boss_code.asm
		include	boss_code.asm
		include	boss7_code.asm
		.pad	$A000,$FF
		
		.base	$8000	; 24010
		include	draw_objs_code.asm
		.pad	$B000
		.base	$9000
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_02_green_hill_zone.asm ; 3,2 kb
		ENDIF
		.pad	$A000
		;.pad	$C000,$FF
		
		.base	$8000	; 28010
		include	obj_code.asm
		.pad	$C000,$FF
		
		.base	$8000	; 2C010
		include	blk_phys1_code.asm
		include	blk_phys2_code.asm
		.pad	$A000,$FF
		
		.base	$8000	; 2E010
		;include	blk_phys2_code.asm
		
sega_nt:
		incbin	sega_logo\sega_nt.bin
		
		include	sega_logo\sonic_logo_anim1.asm
		include	sega_logo\sonic_logo_anim2.asm
		include	sega_logo\sonic_logo_anim3.asm
		include	sega_logo\sonic_logo_anim4.asm
good2:
		incbin	menu\good.nam
good_spr:
		incbin	menu\good_spr.bin
		include	menu\good_spr.asm
		
		.pad	$A000,$FF
		
		.base	$8000	; 30010
		include	menus_code.asm
		
		.pad	$A000
		.base	$A000	; 32010
		include	bkg_read_code.asm
		include	good_ending.asm
		include	menus_code2.asm
options_attribs:
		incbin	menu\options_attrs1.bin
		incbin	menu\options_attrs2.bin
		incbin	menu\options_attrs3.bin
		.pad	$C000,$FF
		
		.base	$8000	; 34010
		;incbin	res\0x34010.bin - hummer sound engine
		include	special2\special_stage2.asm
		.pad	$C000,$FF
		
		.base	$8000	; 38010
		include	anims.asm ; sonic animations
		
		;.base	$A000	; 3A010
		include	player_code.asm	
		.pad	$C000,$FF
		
		.base	$8000	; 3C010 - new music/engine
		include	music\music_0cc_c1.asm
		
		.pad	$B000,$00
		
		.base	$9000
		IF	(VRC7=0)
		include	music_FMS_410\sonic_1_nes_ost_04_spring_yard_zone.asm ; 2,0 kb
		include	music_FMS_410\sonic_1_nes_ost_08b_special_stage_beta_s1_smsgg.asm ; 1,9 kb
		ENDIF
		.pad	$A000,$00
		
		;.pad	$C000,$00
		
		;.base	$8000	; 40010 new music/engine
		;.pad	$C000,$FF
		;.base	$8000	; 44010 new music/engine
		;.pad	$C000,$FF
		;.base	$8000	; 48010 new music/engine
		;.pad	$C000,$FF
		
		.base	$8000 ; 4C010	- sms bonus screens (banks 26 27)
		incbin	res\0x4C010.bin
		.pad	$C000,$00
		.base	$8000 ; 50010
		incbin	res\0x50010.bin ; (banks 28 29)
		.pad	$C000,$00
		.base	$8000 ; 54010 ; (bank 2A) reserved ghz 64-95
		incbin	res\0x54010.bin
		.pad	$A000,$FF
		
		IF	(VRC7=0)
		.base	$8000	; 56010 ; (bank 2B)
		include	music_FMS_410\sonic_1_nes_ost_05_labyrinth_zone.asm
		include	music_FMS_410\sonic_1_nes_ost_06_star_light_zone.asm
		include	music_FMS_410\sonic_1_nes_ost_07_scrap_brain_zone.asm
		.pad	$A000,$FF
		ENDIF
		
		IF	(VRC7=1)
		.base	$8000	; 56010 ; (bank 2B)
;		include	music_VRC7\music_vrc7_part1.asm
;		include	music_VRC7\music_vrc7_part2.asm
		include music_vrc7\song_01.asm
vrc7_ft_s2_frames
vrc7_ft_s3_frames
vrc7_ft_s4_frames
vrc7_ft_s5_frames
vrc7_ft_s6_frames
vrc7_ft_s7_frames
vrc7_ft_s8_frames
vrc7_ft_s9_frames
vrc7_ft_s10_frames
vrc7_ft_s11_frames
vrc7_ft_s12_frames
vrc7_ft_s13_frames
vrc7_ft_s14_frames
vrc7_ft_s15_frames
vrc7_ft_s16_frames
vrc7_ft_s17_frames
vrc7_ft_s18_frames
vrc7_ft_s19_frames
		
		.pad	$A000,$00
		ENDIF
		
		.base	$8000 ; 58010 ; (bank 2C) reserved marble 64-95
		incbin	res\0x58010.bin
		
		.pad	$A000,$FF
		.base	$8000 ; 5A010 ; (bank 2D)
		
		IF	(VRC7=0)
		;include	music_FMS_410\sonic_1_nes_ost_08b_special_stage_sms.asm
		include	"music_FMS_410\sonic_1_nes_ost_13_1_up.asm"
		include "music_FMS_410\sonic_1_nes_ost_14_game_over.asm"
		include "music_FMS_410\sonic_1_nes_ost_15_chaos_emerald.asm"
		include "music_FMS_410\sonic_1_nes_ost_16_continue.asm"
		include "music_FMS_410\sonic_1_nes_ost_17_running_out_of_air_beta.asm"
;		include "music_FMS_410\sonic_1_nes_ost_21_invincibility.asm"
		include	"music_FMS_410\sonic_1_nes_ost_21_invincibility_beta.asm"
		
		include "music_FMS_410\sonic_1_nes_ost_s3k_invincibility.asm"
		include "music_FMS_410\sonic_1_nes_ost_sonic_2_super_sonic.asm"
		include "music_FMS_410\music_get_cont.asm"
		
		ELSE
;		incbin	music_vrc7\$8A-Low-Timpani.dmc
		include	music_vrc7\song_00.asm
		ENDIF
		
		.pad	$A000,$FF
		;.pad	$C000,$00
		
		.base	$8000
		incbin	res\0x5C010.bin	; spring yard screens 64-95 (bank 2E)
		
		;include "music_FMS_410\sonic_1_ost_18_credits_medley_dpcm_beta.asm"
		
		.pad	$A000
					; (bank 2F)
		IF	(VRC7=0)
		include	music_FMS_410\famistudio_asm6.asm
		include	music_FMS_410\fm_sfx.asm
		
		ELSE
		include	music_vrc7\ft_drv_vrc7.asm
;		include	music_vrc7\music_vrc7_inst.asm
		include	music_vrc7\instruments.asm
		include	music_vrc7\sample_list.asm
		include music_vrc7\songs_ptrs.asm
		ENDIF
		
		.pad	$C000,$00
		.base	$8000 ; 60010	; (banks 30 31) reserved lab 64-127
		incbin	res\0x60010.bin
		.pad	$C000,$00
		.base	$8000 ; 64010	; (banks 32 33) reserved starl 64-127
		incbin	res\0x64010.bin
		.pad	$C000,$00
		.base	$8000
		incbin	res\0x68010.bin ; scrap2 screens (banks 34 35)
		.pad	$C000,$00
		.base	$8000
		incbin	res\0x6C010.bin ; scrap3 screens (banks 36 37)
		.pad	$C000,$00
		
		.base	$8000	; $70010
		incbin	res\0x70010.bin
		;include	sega_logo.asm
		include	sega_logo\sega_logo_new.asm
		.pad	$C000,$00
		
		.base	$8000	; $74010 ; scrap1 screens (banks 3A 3B)
		incbin	res\0x74010.bin
		.pad	$C000,$00

		.base	$8000		; $78010 - scrap3   blocks (bank 3C)
		incbin	res\0x78010.bin ; $7A010 - scrap1/2 blocks (bank 3D)
		.pad	$C000,$00
		
		IF	(VRC7=0)
		.base	$C000	; $7C010 8Kb reserved for DMC samples
		incbin	music_FMS_410\sonic_1_nes_ost.dmc
		ELSE
		
		;incbin	music_vrc7\$81-Kick.dmc
		;align	64
		;incbin	music_vrc7\$82-Snare.dmc
		;align	64
		;incbin	music_vrc7\$88-Hi-Timpani.dmc
		
		.base	$0000
		include	music_vrc7\vrc7_samples1.asm
ft_sample_6
ft_sample_7
ft_sample_8
ft_sample_9
ft_sample_10
ft_sample_11
ft_sample_12

		.pad	$2C00,$FF
		.base	$EC00
		ENDIF
		
		include	main_code.asm
		
		incbin	res\sonic_chr.chr