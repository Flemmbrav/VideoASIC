CIR= InverterX.cir Q2V.cir ClockGen.cir V2Q.cir QOP.cir \
	Comparator.cir Polarity.cir Modulator.cir Filter.cir \
	CRbit.cir DACbit.cir PumpDAC.cir Preamplifier.cir DPST-NC.cir \
	Bias10uA.cir Chain.cir SwitchableTerminator.cir LVRP.cir LVDD.cir \
	TOP.cir
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

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

