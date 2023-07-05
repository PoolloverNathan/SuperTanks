asar 1.81
lorom

org $008000
START:
    REP $FF ; clear status
    XCE ; exit emulation
    REP $80 ; clear carry bit
    STZ $2121 ; CGADD = 0
    LDA #%10000000 : STA $2100 ; enter vblank
    LDA c1 : STA $2122 ; CGDATA[0] = c1
    LDA c1+1 : STA $2122 ; /
    LDA #%00001111 : STA $2100 ; exit vblank
    -
    BRA -

c1: dw %0111110000011111 ; purple

STI:
    STP
NUI:
    RTI

incsrc "headers.asm"

org $018000
bank01:

warnpc $020000