INFRA= process.inc ../OpenIP/openIP-noglobals.inc \
 ../Source/source.inc SimPwr.cir
GNET=gnetlist -g spice-noqsi -o $@
PP=../Scripts/spicepp.pl
SPICE=ngspice-noqsi


%.cir : %.sch 
	$(GNET) $<

%.sim : %.cir $(INFRA)
	echo '*' $@ | cat - $^ | ../Scripts/spicepp.pl >$@

InverterXgm : InverterXgm.sim
	$(SPICE) InverterXgm.sim

on-resistance-test : on-resistance-test.sim
	$(SPICE) on-resistance-test.sim

InverterXac : InverterXac.sim
	$(SPICE) InverterXac.sim

.PHONY : ../Source/source.inc

../Source/source.inc :
	cd ../Source; make -q || make

../Models/process.inc :
	cd ../Models; make -q || make

clean :
	rm -f *.cir *.sim \#*

