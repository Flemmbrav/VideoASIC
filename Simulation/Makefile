INFRA=../Models/process.inc ../OpenIP/openIP-noglobals.inc \
 ../Source/source.inc SimPwr.cir
GNET=gnetlist -g spice-noqsi -o $@
PP=../Scripts/spicepp.pl
SPICE=ngspice


%.cir : %.sch 
	$(GNET) $<

%.sim : %.cir $(INFRA)
	cat $^ >$@

on-resistance-test : on-resistance-test.sim
	$(SPICE) on-resistance-test.sim

.PHONY : ../Source/source.inc

../Source/source.inc :
	cd ../Source; make -q || make

clean :
	rm -f *.cir *.sim \#*

