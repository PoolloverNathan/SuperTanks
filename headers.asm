includefrom "supertanks.asm"

warnpc $00FFB0
org $00FFB0
    ; extended header
    db "NK" ; maker code
    db "TANK" ; game code
    rep 7 : db $00 ; fixed - unknown
    db $00 ; exSRAM size
    db $00 ; special version
    db $00 ; cartridge subtype  
    print "ExHeader ends at ",pc
    ; standard header
    db "SUPER TANKS          " ; title - 21 bytes
    db %00110000 ; fast lorom
    db $00 ; cartridge type - rom only
    db $01 ; rom size in KB, power of 2 - 2KB (increase if neccesary)
    db $00 ; sram size in KB, power of 2 - we're not using sram
    db $01 ; country - USA/NTSC
    db $33 ; developer id - 33 triggers extended header
    db $00 ; version
    skip 4 ; checksum
    print "Header ends at ",pc
    ; interrupt vector
    skip 4 ; unused
    dw NUI ; native COP
    dw NUI ; native BRK
    dw NUI ; native ABORT
    dw INTERNMI ; native NMI
    dw START ; native RESET - unused
    dw NUI ; native IRQ
    skip 4 ; unused
    dw NUI ; emulated COP
    dw NUI ; emulated BRK - unused since it shares with IRQ in emulation mode
    dw NUI ; emulated ABORT
    dw INTERNMI ; emulated NMI
    dw START ; emulated RESET
    dw NUI ; emulated IRQ
    print "Interrupt vector ends at ",pc
warnpc $010000