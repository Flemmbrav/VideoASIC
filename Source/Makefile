CIR= InverterX.cir Q2V.cir ClockGen.cir V2Q.cir QOP.cir \
	Comparator.cir Polarity.cir Modulator.cir Filter.cir \
	CRbit.cir DACbit.cir PumpDAC.cir Preamplifier.cir DPST-NC.cir \
	Bias10uA.cir Chain.cir SwitchableTerminator.cir LVRP.cir LVDD.cir \
	Sync.cir TOP.cir

PS= InverterX.ps Q2V.ps ClockGen.ps V2Q.ps QOP.ps \
	Comparator.ps Polarity.ps Modulator.ps Filter.ps \
	CRbit.ps DACbit.ps PumpDAC.ps Preamplifier.ps Preamplifier-gain.ps \
	DPST-NC.ps Bias10uA.ps Chain.1.ps Chain.2.ps SwitchableTerminator.ps \
	LVRP.ps Sync.ps \
	TOP.1.ps TOP.2.ps TOP.3.ps TOP.4.ps TOP.5.ps TOP.6.ps TOP.7.ps 
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

S2PS=gschem -p -o $@ -s print.scm $<

%.sym.ps : %.sym
	$(S2PS)

%.ps : %.sch
	$(S2PS)

# And definitions to assemble the documentation

PAPER=letter
#PAPER=a4

A2PS=a2ps -1 --medium=$(PAPER) --toc -o $@ $^
PS2PDF=ps2pdf -sPAPERSIZE=$(PAPER)

%.pdf : %.ps
	$(PS2PDF) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

Preamplifier.cir : Preamplifier.sch Preamplifier-gain.sch
	$(GNET) Preamplifier.sch Preamplifier-gain.sch

Chain.cir : Chain.1.sch Chain.2.sch
	$(GNET) Chain.1.sch Chain.2.sch


TOP.cir : TOP.1.sch TOP.2.sch TOP.3.sch TOP.4.sch TOP.5.sch \
	TOP.6.sch TOP.7.sch 
	$(GNET) TOP.1.sch TOP.2.sch TOP.3.sch TOP.4.sch TOP.5.sch \
	TOP.6.sch TOP.7.sch


clean :
	rm -f *.cir source.inc *.sch~ *.sym~ \#*

Source.ps : $(PS)
	$(A2PS)
