includefrom "supertanks.asm"

namespace NSLVL
    SQR:
        .F incbin "levels/square/fg.map.rev"
        .B incbin "levels/square/bg.map.rev"
        .E
    CAU:
        .F incbin "levels/caution/fg.map.rev"
        .B incbin "levels/caution/bg.map.rev"
        .E
    E:
namespace off

L3M:
    incbin "menu.map.rev"

L3P:
    incbin "game3.map.rev"

LLL:
    pushtable
    table "text.tbl"
    db " >0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ*"
    pulltable
    .E