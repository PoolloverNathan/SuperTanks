asar 1.81
lorom
incsrc "headers.asm"
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
    JSR DECODEGFX
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

DECODEGFX: ; Loads graphics data into VRAM. Assumes 16-bit X/Y and puts A in 8 bit mode.
    LDX.w #0
    SEP #$20 ; put A in 8-bit mode
    LDA #$80 : STA $2115 ; prepare vram for writing words
    REP #$20 ; put A in 16-bit mode
    STZ $2116 ; start writing to beginning of vram
    ; start actually decoding data
    SEP #$20 ; put A in 8-bit mode
    --
    LDA GFX,x ; load repeat count
    CMP $FF ; magic number indicating end of data
    BNE + ; if not $FF, don't return
    RTS
    +
    INX ; go to actual data
    LDY GFX,x ; load actual data
    -
    STY $2118 ; store one repeated word to vram
    DEC A ; a repeat count of $00 (1) will wrap around to $FF and set the negative flag, breaking the loop
    BPL -
    INX #2 ; go to next repeat count
    BRA --

GFX:
    incbin "graphics.rlb"
    db $FF

STI:
    STP
NUI:
    RTI

RAMINIT:
    fill $FF

warnpc $00FFB0
org $018000
bank01:

warnpc $01FFFF
org $01FFFF
db $00 ; pad to length

print "Wrote ",bytes," bytes using ",hex(!RAMSIZE,4)," bytes of RAM."