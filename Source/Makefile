CIR=CMS.cir DPST-NC.cir InverterX.cir Pump.cir Q2V.cir DiffQ2V.cir \
	Comparator.cir CJK.cir G1.cir G2.cir Modulator.cir UnBal.cir
	

GNET=gnetlist -g spice-noqsi -o $@

%.cir : %.sch
	$(GNET) $<

source.inc : $(CIR)
	cat $(CIR) >source.inc

# Build variations of V2Q for different coefficients

CJK.cir : V2Q.cir
	sed -e 's/{cq}/390fF/' -e 's/ V2Q / K1 /' <V2Q.cir >CJK.cir
	sed -e 's/{cq}/356fF/' -e 's/ V2Q / K2 /' <V2Q.cir >>CJK.cir
	sed -e 's/{cq}/484fF/' -e 's/ V2Q / K3 /' <V2Q.cir >>CJK.cir
	sed -e 's/{cq}/367fF/' -e 's/ V2Q / K4 /' <V2Q.cir >>CJK.cir
	sed -e 's/{cq}/250fF/' -e 's/ V2Q / C123 /' <V2Q.cir >>CJK.cir

Modulator.cir : Modulator.1.sch Modulator.2.sch Modulator.3.sch
	$(GNET) $^

clean :
	rm -f *.cir source.inc *.sch~ *.sym~ 

