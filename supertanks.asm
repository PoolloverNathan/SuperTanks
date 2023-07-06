asar 1.81
lorom
incsrc "headers.asm"
incsrc "ram.asm"

!A16 = "REP #$20"
!A8 = "SEP #$20"
!X16 = "REP #$10"
!X8 = "SEP #$10"
!AX16 = "REP #$30"
!AX8 = "SEP #$30"

org $008000
START:
    CLC : XCE : REP #$FF ; clear status
    SEI
    !A8
    LDA #%10001111 : STA $2100 ; disable screen
    LDX #$01FF : TXS
    LDA.b #(!RAMSIZE)-1
    LDX.w #RAMINIT
    LDY.w #!RAMSTART
    MVN $00, $00
    JSR DECODEGFX
    JSR LOADLVL
    !AX8
    STZ $2121 ; CGADD = 0
    JSR CGLOAD
    LDA #%10110000 : STA $4200 ; enable NMI and counters
    LDA #%00001111 : STA $2100 ; enable screen
    CLI
    - ; idle loop since NMI handles everything
    WAI
    BRA -

INTERNMI:
    PHP
    PHA
    SEI
    !A16
    INC RAM.frame
    JSR OAMCPY ; also sets registers to 8-bit mode
    CLI
    PLA
    PLP
    RTI

OAMCPY:
    LDA #$0000
    STA $2102 ; OAM address, and disable priority rotation
    !AX8
    LDX #$00
    -
    LDA RAM.oamx,x
    STA $2104
    LDA RAM.oamx+1,x
    STA $2104
    LDA RAM.oamy,x
    STA $2104
    LDA RAM.oamy+1,x
    STA $2104
    LDA RAM.oamt,x
    STA $2104
    LDA RAM.oamt+1,x
    STA $2104
    LDA RAM.oama,x
    STA $2104
    LDA RAM.oama+1,x
    STA $2104
    BPL -
    RTS

DECODEGFX: ; Loads graphics data into VRAM. Assumes 16-bit X/Y and puts A in 8 bit mode.
    LDX.w #0
    !A8
    LDA #$80 : STA $2115 ; prepare vram for writing words
    !A16
    STZ $2116 ; start writing to beginning of vram
    ; start actually decoding data
    !A8
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

LOADLVL:
    PHA
    PHP
    !A8
    LDA #$01 : STA $2105
    LDA #$04 : STA $2107
    !AX16
    LDA.w #$400 : STA $2116
    LDX #NSLVL_SQR_B-NSLVL_SQR_F
    -
    LDA NSLVL_SQR_F-2,x : XBA : STA $2118
    DEX : DEX
    BPL -
    PLP
    PLA
    RTS

GFX:
    incbin "graphics.rlb"
    db $FF

STI:
    STP
NUI:
    RTI

CG:
    incbin "palette.cgr"

CGLOAD:
    PHX
    PHP
    !X16
    LDX #$0000
    -
    LDA CG,x ; load low byte of color...
    STA $2122 ; and store it
    INX ; next byte
    LDA CG,x ; load high byte...
    STA $2122 ; and store it
    BIT #$80 ; if negative...
    BMI + ; exit loop (M)
    INX ; otherwise, go to next byte...
    BRA - ; and continue looping
    +
    PLP
    PLX
    RTS

RAMINIT:
    fill $FF

warnpc $00FFB0
org $018000
bank01:
    incsrc "levels.asm"

warnpc $01FFFF
org $01FFFF
db $00 ; pad to length

print "Wrote ",bytes," bytes, ",dec(!RAMSIZE)," of which are RAM."