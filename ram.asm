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
    .tilebuf: skip 32*32*16
    .players: skip 8
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART

DMAFLAGS = $420B
struct DMA
    .method8: skip 1
    .baddr8: skip 1
    .aaddr16 .aaddrL: skip 1
    .aaddrH: skip 1
    .abank8: skip 1
    .size16 .sizeL: skip 1
    .sizeH: skip 1
endstruct align 16