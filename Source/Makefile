CIR= InverterX.cir Q2V.cir ClockGen.cir V2Q.cir QOP.cir \
	Comparator.cir Polarity.cir Modulator.cir Filter.cir \
	CRbit.cir DACbit.cir PumpDAC.cir Preamplifier.cir DPST-NC.cir
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

Preamplifier.cir : Preamplifier.sch Preamplifier-gain.sch
	$(GNET) Preamplifier.sch Preamplifier-gain.sch

clean :
	rm -f *.cir source.inc *.sch~ *.sym~ \#*

