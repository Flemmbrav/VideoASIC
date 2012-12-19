CIR= InverterX.cir Q2V.cir ClockGen.cir V2Q.cir \
	Comparator.cir Polarity.cir Modulator.cir Filter.cir
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

clean :
	rm -f *.cir source.inc *.sch~ *.sym~ \#*

