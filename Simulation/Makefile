INFRA= process.inc ../OpenIP/openIP-noglobals.inc \
 ../Source/source.inc SimPwr.cir
GNET=gnetlist -g spice-noqsi -o $@
PP=../Scripts/spicepp.pl
SPICE=ngspice-noqsi
ISPICE=rlwrap $(SPICE)


%.cir : %.sch 
	$(GNET) $<

%.sim : %.cir $(INFRA)
	echo '*' $@ | cat - $^ | ../Scripts/spicepp.pl >$@

Igm : Igm.sim
	$(ISPICE) Igm.sim

InverterXgm : InverterXgm.sim
	$(ISPICE) InverterXgm.sim

on-resistance-test : on-resistance-test.sim
	$(ISPICE) on-resistance-test.sim

InverterXac : InverterXac.sim
	$(ISPICE) InverterXac.sim

.PHONY : ../Source/source.inc

../Source/source.inc :
	cd ../Source; make -q || make

../Models/process.inc :
	cd ../Models; make -q || make

ChainTestSeq.stim : ChainTestSeq.lse ClockGen.lse Seq.lse
	lse64 ChainTestSeq.lse > $@

clean :
	rm -f *.cir *.sim \#* *~

