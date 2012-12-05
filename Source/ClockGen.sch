v 20121123 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=20121203
T 53900 40500 5 10 1 1 0 0 1
rev=1.0
T 53900 40200 5 10 1 1 0 0 1
auth=jpd
T 53200 40900 5 14 1 1 0 4 1
title=Non-overlapping Clock Generator
T 50500 40200 5 10 1 1 0 0 1
page=1
T 51900 40200 5 10 1 1 0 0 1
pages=1
}
C 42300 47200 1 0 0 NORP-1.sym
{
T 42800 47900 5 10 1 1 0 0 1
refdes=X2
T 46500 49100 5 10 0 0 0 0 1
symversion=1.0
}
C 42300 43300 1 0 0 NORP-1.sym
{
T 42800 44000 5 10 1 1 0 0 1
refdes=X3
T 46500 47100 5 10 0 0 0 0 1
symversion=1.0
}
C 44100 47700 1 0 0 pch.sym
{
T 44900 48500 5 10 1 1 0 0 1
refdes=M1
T 44900 48300 5 8 1 1 0 0 1
model-name=pch
T 44900 48000 5 8 1 0 0 0 1
w=1u
T 44900 47800 5 8 1 0 0 0 1
l=1u
}
C 44100 46300 1 0 0 nch.sym
{
T 44900 47100 5 10 1 1 0 0 1
refdes=M2
T 44900 46900 5 8 1 1 0 0 1
model-name=nch
T 44900 46600 5 8 1 0 0 0 1
w=3u
T 44900 46400 5 8 1 0 0 0 1
l=0.4u
}
N 45400 47500 44700 47500 4
N 44700 47300 44700 47700 4
N 44800 48200 44800 48700 4
N 44800 48700 44700 48700 4
N 45500 46800 44800 46800 4
N 44100 46800 44100 49500 4
N 43700 47500 44100 47500 4
C 45400 46500 1 0 0 Vss.sym
C 44100 43800 1 0 0 pch.sym
{
T 44900 44600 5 10 1 1 0 0 1
refdes=M3
T 44900 44400 5 8 1 1 0 0 1
model-name=pch
T 44900 44100 5 8 1 0 0 0 1
w=1u
T 44900 43900 5 8 1 0 0 0 1
l=1u
}
C 44100 42400 1 0 0 nch.sym
{
T 44900 43200 5 10 1 1 0 0 1
refdes=M4
T 44900 43000 5 8 1 1 0 0 1
model-name=nch
T 44900 42700 5 8 1 0 0 0 1
w=3u
T 44900 42500 5 8 1 0 0 0 1
l=0.4u
}
N 45400 43600 44700 43600 4
N 44700 43400 44700 43800 4
N 44800 44300 44800 44800 4
N 44800 44800 44700 44800 4
N 44100 41500 44100 44300 4
N 43700 43600 44100 43600 4
C 45200 49200 1 0 0 INV4P-1.sym
{
T 45600 49800 5 10 1 1 0 0 1
refdes=X5
T 53600 48600 5 10 0 0 0 0 1
symversion=1.0
}
C 45400 47200 1 0 0 INV1P-1.sym
{
T 45800 47800 5 10 1 1 0 0 1
refdes=X6
T 49300 48200 5 10 0 0 0 0 1
symversion=1.0
}
C 45400 43300 1 0 0 INV1P-1.sym
{
T 45800 43900 5 10 1 1 0 0 1
refdes=X9
T 49300 44300 5 10 0 0 0 0 1
symversion=1.0
}
N 46500 43600 46500 45100 4
N 42400 46200 46500 45100 4
N 42400 46200 42400 47300 4
N 46500 47500 46500 46200 4
N 46500 46200 42400 45100 4
N 42400 45100 42400 43800 4
C 44100 49200 1 0 0 INV1P-1.sym
{
T 44500 49800 5 10 1 1 0 0 1
refdes=X4
T 52500 48600 5 10 0 0 0 0 1
symversion=1.0
}
C 45200 41200 1 0 0 INV4P-1.sym
{
T 45600 41800 5 10 1 1 0 0 1
refdes=X8
T 46000 41900 5 10 0 0 0 0 1
symversion=1.0
}
C 44100 41200 1 0 0 INV1P-1.sym
{
T 44500 41800 5 10 1 1 0 0 1
refdes=X7
T 44900 41900 5 10 0 0 0 0 1
symversion=1.0
}
C 41300 47400 1 0 0 INV1P-1.sym
{
T 41700 48000 5 10 1 1 0 0 1
refdes=X1
T 49700 46800 5 10 0 0 0 0 1
symversion=1.0
}
N 41300 47700 41300 43400 4
N 41300 43400 42400 43400 4
C 46300 49200 1 0 0 io.sym
{
T 47150 49450 5 10 1 1 0 0 1
refdes=P2
}
C 46300 41200 1 0 0 io.sym
{
T 47150 41450 5 10 1 1 0 0 1
refdes=P3
}
C 41500 47400 1 0 1 io.sym
{
T 40650 47650 5 10 1 1 0 6 1
refdes=P1
}
C 40800 50000 1 0 0 subcircuit.sym
{
T 40900 50300 5 10 1 1 0 0 1
refdes=A1
T 41600 50000 5 10 1 1 0 0 1
model-name=ClockGen
T 40800 49800 5 10 1 0 0 0 1
common=Vdd1 Vss1 Vss
}
N 46500 49500 46300 49500 4
{
T 46300 49600 5 10 1 1 0 0 1
netname=Ph1
}
N 46500 41500 46300 41500 4
{
T 46300 41600 5 10 1 1 0 0 1
netname=Ph2
}
C 41000 40900 1 0 0 ClockGen.sym
{
T 42400 41600 5 10 1 1 0 0 1
refdes=X?
T 41000 40900 5 10 0 0 0 0 1
graphical=1
}
N 45500 42900 44800 42900 4
C 45400 42600 1 0 0 Vss.sym
C 44600 42100 1 0 0 Vss1.sym
C 44600 46000 1 0 0 Vss1.sym
C 44500 48700 1 0 0 Vdd1.sym
C 44500 44800 1 0 0 Vdd1.sym
