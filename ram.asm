!RAMSTART = $000000
org !RAMSTART
struct RAM !RAMSTART
    .frame: skip 2
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART