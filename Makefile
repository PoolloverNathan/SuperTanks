supertanks.smc: supertanks.asm graphics.rlb layer3.qbw palette.cgr menu.map.rev game3.map.rev levels/square/bg.map.rev levels/square/fg.map.rev levels/caution/bg.map.rev levels/caution/fg.map.rev headers.asm levels.asm ram.asm

supertanks.smc supertanks.sym supertanks.smc.err: supertanks.asm
	rm $@
	x=0; $$ASAR/asar.exe --symbols=nocash ./supertanks.asm ./supertanks.smc 2> ./supertanks.smc.err ||x=$$?; cat supertanks.smc.err 1>&2; exit $$x

%.rev: %
	< $< xxd -p -c1 | tac | xxd -p -r > $@

%.rlb: %.bin qwc-compress.py
	python3 qwc-compress.py $< $@
%.qbw: %.gbc qbw-compress.py
	python3 qbw-compress.py $< $@
%.cgr: %.pal cgram-enc.py
	python3 cgram-enc.py $< $@

.PHONY: run
run: supertanks.smc
	cmd.exe /c $< &: