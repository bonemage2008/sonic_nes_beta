	IF	(VRC7=0)

; mapper registers
MMC3_bank_select equ	$8000
MMC3_bank_data	equ	$8001
MMC3_IRQ_latch	equ	$C000
MMC3_IRQ_reload equ	$C001
MMC3_IRQ_disable equ	$E000
MMC3_IRQ_enable	equ	$E001
MMC3_mirroring	equ	$A000
MMC3_prg_ram_pr	equ	$A001

	ELSE

; VRC7 mapper registers
VRC7_prg_8000	equ	$8000
VRC7_prg_A000	equ	$8010
VRC7_prg_C000	equ	$9000

VRC7_chr_0000	equ	$A000
VRC7_chr_0400	equ	$A010
VRC7_chr_0800	equ	$B000
VRC7_chr_0C00	equ	$B010
VRC7_chr_1000	equ	$C000
VRC7_chr_1400	equ	$C010
VRC7_chr_1800	equ	$D000
VRC7_chr_1C00	equ	$D010

VRC7_mirroring	equ	$E000
VRC7_IRQ_latch	equ	$E010
VRC7_IRQ_control equ	$F000
VRC7_IRQ_ack	equ	$F010

	ENDIF

; level names
GHZ		equ 0
MARBLE		equ 1
SPRING_YARD	equ 2
LAB_ZONE	equ 3
STAR_LIGHT	equ 4
SCRAP_BRAIN	equ 5
FINAL_ZONE	equ 6
SPEC_STAGE	equ 7

; sonic flags
STATE_SHIELD	equ 2
STATE_SPIN	equ 4
STATE_SUPER	equ $80

DIR_LEFT	equ 1
MDIR_LEFT	equ 2
MOVE_LEFT	equ 3
MOVE_UP		equ 4
LOOK_LEFT	equ $40
;

temp_x_h	equ	tmp_var_63
temp_x_l	equ	tmp_var_64
temp_y_h	equ	tmp_var_65
temp_y_l	equ	tmp_var_66

tmp_var_29	equ	$29

sonic_X_sub	equ	$2C	; new var
sonic_Y_sub	equ	$2D	; new var

sonic_X_speed_s	equ	$36	; md var
sonic_X_speed_l	equ	$37	; md var
sonic_Y_speed_s	equ	$38	; md var
sonic_Y_speed_l	equ	$39	; md var

move_cam_delay	equ	$5B	; new var

vrc7_irq_mode	equ	$87	; vrc7 irq mode mask

sonic_status	equ	$8F	; md var


pulse2_sound	equ	$784	; ftm_driver.asm
noise_sfx_ptr	equ	$705	; snd_driver.asm

last_block1	equ	$7FA	; for super sonic speed limits
last_block2	equ	$7FB	; for super sonic speed limits
emeralds_cnt	equ	$7FC	; chaos emeralds count
super_em_cnt	equ	$7FD	; super emeralds count
		
;lag_counter	equ	$7FE
epsm_flag	equ	$7FE
vrc7_flag	equ	$7FE
nmi_flag2	equ	$7FF
		
Camera_X_l_new	equ	camera_X_l_new
Camera_X_h_new	equ	camera_X_h_new
killed_objs_mem	equ	killed_objs_bits
		
		
lifes_for_rings_mask	equ	$33D	; new var

checkpoint_x_h	equ	$33E
checkpoint_x_l	equ	$33F
checkpoint_y_h	equ	$340
checkpoint_y_l	equ	$341

palette2_ram	equ	$381 ; fade palette in ending.asm

level_blk_bank3	equ	$4E6 ; new var for screens 64-95
level_blk_bank4	equ	$4ED ; new var for screens 96-127

special_flag	equ	$E5 ; for new special

; demo record vars:
demo_ptr1	equ	$F0 ; f0-f1 write replay
demo_cnt1	equ	$F1 ; read replay
;demo_ptr2	equ	$F2 ; f2-f3 write replay
;demo_cnt2	equ	$F3 ; read replay
joy1_hold_demo	equ	$F2 ; save of previous joy_hold


; x2 scrolling vars:
ptr_low		equ	$F4 ; X2
ptr_high	equ	$F5 ; X2
;ptr_low_old	equ	$FE ; X1
;ptr_high_old	equ	$FF ; X1

;tilemap_adr_h	equ	$F6
;tilemap_adr_h_v	equ	$F7
tilemap_adr_h	equ	$480 ; vscr_map_adr1_h
tilemap_adr_l	equ	$481 ; vscr_map_adr1_l

tilemap_adr_h_v		equ	$4A6	; hscr_map_adr1_h ; hscroll-column
;tilemap_adr_l_v_old	equ	$4A7	; hscr_map_adr1_l ; X1

			; F8
			; F9
;ppu_status_value equ	$FA	; test VBLANK state in X2_NMI.asm
;nmi_sp_saver		equ	$FB ; X2
;nmi_sp_saver_old	equ	$FA ; X1

;tilemap_adr_l2	equ	$FC ; X2-2
;tilemap_adr_h2	equ	$FD ; X2-2
;tilemap_adr_l	equ	$FE
;tilemap_adr_l_v	equ	$FF ; X2

tilemap_adr_l2	equ	$F6 ; X2-2
tilemap_adr_h2	equ	$F7 ; X2-2
tilemap_adr_l_v	equ	$F8 ; X2
;tilemap_adr_h_v equ	$F9
nmi_sp_saver	equ	$FA

tilemap_tile_blk	equ	blocks_vram_m ; $34E	; new empty tile number
tilemap_adr_blk_h	equ	blocks_vram_h ; $34F	; ring bkg block update
tilemap_adr_blk_l	equ	blocks_vram_l ; $350

tiles_to_upd_v	equ	$4A8	; hscroll-column ; hscroll_cnt1

tiles_to_upd	equ	$4A3	; vscroll-raw ; Vscr_atr_adr1_h

scroll_H_attrib_high equ	$4CB	; hscroll-column ; hscr_atr_adr1_h
scroll_H_attrib_low  equ	$4CC	; hscroll-column ; hscr_atr_adr1_l

scroll_V_attrib_low	equ	$4A4	; vscroll-raw ; Vscr_atr_adr1_l


; new scrolling code buffers:
raw_buffer1	equ $100 ; 34 bytes
col_buffer1	equ $122 ; 30 bytes
col_buffer2	equ $140 ; 30 bytes
raw_buffer2	equ $15E ; 34 bytes
; $180+
attrib_Hscrl_buff equ $180 ; 8 bytes
blocks_attr	equ	$188 ; 17 bytes	
nmi_xreg_saver	equ $19A
nmi_yreg_saver	equ $19B
big_ring_flag	equ $19C
demo_stage_num	equ	$19D
demo_record_flag	equ	$19E


; vars for new scrolling code:
camera_Y_h_tmp	equ	tmp_var_65
camera_Y_l_tmp	equ	tmp_var_66
camera_X_h_tmp	equ	tmp_var_65
camera_X_l_tmp	equ	tmp_var_66

attr_mask1	equ	tmp_ptr_l   ; $32	; temp
attr_mask2	equ	tmp_ptr_l+1 ; $33	; temp
attr_mask3	equ	tmp_var_2B	; temp

buffer_ptr	equ	tmp_ptr_l
blocks_ptr	equ	tmp_ptr_l+1

ptr_to_blocks_l	equ	tmp_ptr_l
ptr_to_blocks_h	equ	tmp_ptr_l+1

blocks_buff	equ	blocks_buffer
tmp_ring_mask	equ	blocks_buffer+16

VScroll_pos_h_old equ	camera_Y_h_old ; $52
VScroll_pos_old	equ	camera_Y_l_old ; $53

VScroll_pos_h	equ	camera_Y_h_old ; $52
VScroll_pos	equ	camera_Y_l_old ; $53


objects_X_l		equ	objects_type+OBJECTS_SLOTS
objects_X_h		equ	objects_type+OBJECTS_SLOTS*2
objects_Y_l		equ	objects_type+OBJECTS_SLOTS*3
objects_Y_h		equ	objects_type+OBJECTS_SLOTS*4
objects_X_relative_l	equ	objects_type+OBJECTS_SLOTS*5
objects_X_relative_h	equ	objects_type+OBJECTS_SLOTS*6
objects_Y_relative_l	equ	objects_type+OBJECTS_SLOTS*7
objects_Y_relative_h	equ	objects_type+OBJECTS_SLOTS*8

objects_delay		equ	$790	; new obj var - delay
objects_sav_slot	equ	objects_delay+OBJECTS_SLOTS
objects_var_cnt		equ	objects_delay+OBJECTS_SLOTS*2
