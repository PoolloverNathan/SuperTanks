includefrom "supertanks.asm"

!RAMSTART = $000000
org !RAMSTART
struct RAM !RAMSTART
    .frame: skip 2
    .oamtable: skip 5*$7F
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART