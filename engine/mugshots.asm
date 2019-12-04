Ichiko_Mugshot:
INCBIN "gfx/mugshots/Ichiko.2bpp.lz"

IchikoLoad::
	ld de, Ichiko_Mugshot
	ld hl, vTiles1 tile $40
	lb bc, BANK(Ichiko_Mugshot), 16 ; one whole row (for a 32x32 mugshot)
	call Get2bpp_2
	call Decompress
	ret


DrawMugshot::
	hlcoord 0, 3
	lb bc, 7, 20
	ld d, $c0
	ld e, 4
	call DrawMugshot2
	ret

DrawMugshot2::
; input:
;   hl: draw location
;   b: height
;   c: width
;   d: tile to start drawing from
;   e: number of tiles to advance for each bgrows
.bgrows
	push de
	push bc
	push hl
.col
	ld a, d
	ld [hli], a
	inc d
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	pop de
	ld a, e
	add d
	ld d, a
	dec b
	jr nz, .bgrows
	ret


