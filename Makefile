supertanks.smc: supertanks.asm graphics.rlb layer3.qbw palette.cgr menu.map.rev levels/square/bg.map.rev levels/square/fg.map.rev headers.asm levels.asm ram.asm

%.smc %.sym: %.asm
	$$ASAR/asar.exe --symbols=nocash ./supertanks.asm ./supertanks.smc

%.rev: %
	< $< xxd -p -c1 | tac | xxd -p -r > $@

%.rlb: %.bin
	python3 qwc-compress.py $< $@
%.qbw: %.gbc
	python3 qbw-compress.py $< $@
%.cgr: %.pal
	python3 cgram-enc.py $< $@

.PHONY: run
run: supertanks.smc
	cmd.exe /c $< &: