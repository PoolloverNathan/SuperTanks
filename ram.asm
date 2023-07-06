includefrom "supertanks.asm"

!RAMSTART = $000000
org !RAMSTART
struct RAM !RAMSTART
    .frame: skip 2
    .gamemode: skip 1
    .nmi_ran: skip 1
    .oamx: skip $7F
    .oamy: skip $7F
    .oamt: skip $7F
    .oama: skip $7F
    .oamh: skip $7F
    .players: skip 8
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART

DMAFLAGS = $420B
struct DMA $4300
    ; 7  bit  0
    ; ---- ----
    ; DIxA APPP
    ; |||| ||||
    ; |||| |+++- Transfer pattern (see below)
    ; |||+-+---- Address adjust mode (DMA only):
    ; |||         0:   Increment A bus address after copy
    ; |||         1/3: Fixed
    ; |||         2:   Decrement A bus address after copy
    ; ||+------- (Unused)
    ; |+-------- Indirect (HDMA only)
    ; +--------- Direction: 0=Copy from A to B, 1=Copy from B to A
    ; On power-on: DMAPn = $FF
    ;
    ;                 DMA transfer patterns
    ;     Pattern       HDMA bytes      B Bus address   Usage example
    ;       0               1               +0              WRAM, Mode 7 graphics/tilemap
    ;       1               2               +0 +1           VRAM
    ;       2               2               +0 +0           OAM, CGRAM
    ;       3               4               +0 +0 +1 +1     Scroll positions, Mode 7 parameters
    ;       4               4               +0 +1 +2 +3     Window
    ;       5               4               +0 +1 +0 +1     (Undocumented)
    ;       6               2               +0 +0           (Same as 2, undocumented)
    ;       7               4               +0 +0 +1 +1     (Same as 3, undocumented) 
    .method8: skip 1
    .baddr8: skip 1
    .aaddr16 .aaddrL: skip 1
    .aaddrH: skip 1
    .abank8: skip 1
    .size16 .sizeL: skip 1
    .sizeH: skip 1
endstruct align 16