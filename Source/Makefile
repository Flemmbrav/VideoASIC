CIR=DPST-NC.cir

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

clean :
	rm -f *.cir source.inc

