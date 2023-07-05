@del supertanks.smc
@python qwc-compress.py graphics.bin graphics.rlb
@python qwc-compress.py layer3.gbc layer3.rlb
@python cgram-enc.py palette.pal palette.cgr
@C:\Users\natha\Games\+SMW\tools\asar\asar.exe --symbols=nocash ./supertanks.asm ./supertanks.smc