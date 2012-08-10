SYM=AND3P-1.sym AND4P-1.sym AND5P-1.sym ANDP-1.sym BIAS-1.sym BIAS1-1.sym \
 BIAS2-1.sym BIAS4-1.sym BIAS8-1.sym BIASF-1.sym BIASGEN-1.sym BIASP-1.sym \
 CFINV-1.sym COMP0-1.sym COMP1-1.sym COMP2-1.sym COMP3-1.sym COMP4-1.sym \
 COMP5-1.sym COMP6-1.sym COUNTA-1.sym DFFP-1.sym EDFFP-1.sym FB1-1.sym \
 FB2-1.sym FB3-1.sym FB4-1.sym FB5-1.sym FBAMP-1.sym GINVP-1.sym HITR1-1.sym \
 HITR2-1.sym INV1-1.sym INV1F-1.sym INV1P-1.sym INV1S-1.sym INV4-1.sym \
 INV4P-1.sym LATCHP-1.sym LVD-1.sym LVR-1.sym LVR2-1.sym LVR3-1.sym \
 LVR4-1.sym MUX1-1.sym MUX2B-1.sym MUX3B-1.sym MUX4-1.sym NAND-1.sym \
 NAND3-1.sym NAND3P-1.sym NANDP-1.sym NOR-1.sym NORP-1.sym PAD-1.sym \
 PATH-1.sym PATHR-1.sym PDIN-1.sym PDOUT-1.sym PDTH-1.sym PDTHR-1.sym \
 PVDD-1.sym PVDD0-1.sym PVDD1-1.sym PVDDE-1.sym PVSS-1.sym PVSS0-1.sym \
 PVSS1-1.sym PVSSE-1.sym PrB-1.sym PrC-1.sym PrC2-1.sym PrD-1.sym PrE.sym \
 PrE2-1.sym PrF-1.sym RF1-1.sym RF2-1.sym RF3-1.sym RSFF1-1.sym RSFF2-1.sym \
 SELECTOR-1.sym SHIFT4-1.sym TRBUF-1.sym TROUT-1.sym

all : openIP-noglobals.inc prototypes

power.txt : openIP.inc
	awk -f ../Scripts/list-power.awk < openIP.inc >power.txt

openIP-noglobals.inc : power.txt openIP.inc
	cat power.txt openIP.inc | \
		awk -f ../Scripts/edit-openip.awk >openIP-noglobals.inc

prototypes : power.txt $(SYM)
	for s in $(SYM); do ../Scripts/append-proto.sh $$s; done
	touch prototypes

clean : 
	rm power.txt prototypes
