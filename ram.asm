includefrom "supertanks.asm"

!RAMSTART = $000000
org !RAMSTART
struct RAM !RAMSTART
    .frame: skip 2
    .nmi_ran: skip 1
    .oamx: skip $7F
    .oamy: skip $7F
    .oamt: skip $7F
    .oama: skip $7F
    .oamh: skip $7F
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART