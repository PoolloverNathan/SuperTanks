supertanks.smc: supertanks.asm graphics.rlb layer3.qbw palette.cgr menu.map.rev levels/square/bg.map.rev levels/square/fg.map.rev headers.asm levels.asm ram.asm

supertanks.smc supertanks.sym supertanks.smc.err: supertanks.asm
	x=0; $$ASAR/asar.exe --symbols=nocash ./supertanks.asm ./supertanks.smc 2> ./supertanks.smc.err ||x=$$?; cat supertanks.smc.err 1>&2; exit $$x

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