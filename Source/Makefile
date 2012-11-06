CIR=CMS.cir DPST-NC.cir InverterX.cir Pump.cir Q2V.cir DiffQ2V.cir \
	Comparator.cir
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

clean :
	rm -f *.cir source.inc

