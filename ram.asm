!RAMSTART = $000000
org !RAMSTART
struct RAM !RAMSTART
    .frame16: skip 2
    .frame8: skip 1
    .end
endstruct
!RAMEND = RAM.end

!RAMSIZE = !RAMEND-!RAMSTART