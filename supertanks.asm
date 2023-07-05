asar 1.81
lorom

incsrc "ram.asm"

org $008000
START:
    CLC : XCE : REP #$FF ; clear status
    SEP #$20 ; put A in 8-bit mode
    LDA #%10000000 : STA $2100 ; disable screen
    LDX #$01FF : TXS
    LDA.b #(!RAMSIZE)-1
    LDX.w #RAMINIT
    LDY.w #!RAMSTART
    MVN $00, $00
    SEP #%00110000 ; put registers in 8-bit mode
    LDA #%10110000 : STA $4200 ; enable NMI and counters
    LDA #%00001111 : STA $2100 ; enable screen
    - ; idle loop since NMI handles everything
    WAI
    BRA -

INTERNMI:
    PHP
    PHA
    SEI
    REP #$20 ; put A in 16-bit mode
    INC RAM.frame
    SEP #$20 ; put A in 8-bit mode
    STZ $2121 ; CGADD = 0
    LDA RAM.frame : STA $2122
    LDA RAM.frame+1 : STA $2122
    CLI
    PLA
    PLP
    RTI

STI:
    STP
NUI:
    RTI

RAMINIT:
    fill $FF

incsrc "headers.asm"

org $018000
bank01:

warnpc $01FFFF
org $01FFFF
db $00 ; pad to length

print ""
print "Wrote ",bytes," bytes."