v 20110115 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=20120813
T 53900 40500 5 10 1 1 0 0 1
rev=1.1
T 53900 40200 5 10 1 1 0 0 1
auth=jpd
T 53200 40900 5 14 1 1 0 4 1
title=Double pole single throw switch
T 50500 40200 5 10 1 1 0 0 1
page=1
T 51900 40200 5 10 1 1 0 0 1
pages=1
}
C 48800 42800 1 0 1 nch.sym
{
T 48000 43600 5 10 1 1 0 6 1
refdes=M6
T 48000 43400 5 8 1 1 0 6 1
model-name=nch
T 48000 43100 5 8 1 0 0 6 1
w=4u
T 48000 42900 5 8 1 0 0 6 1
l=0.75u
}
C 45500 42800 1 0 0 pch.sym
{
T 46300 43600 5 10 1 1 0 0 1
refdes=M5
T 46300 43400 5 8 1 1 0 0 1
model-name=pch
T 46300 43100 5 8 1 0 0 0 1
w=7.5u
T 46300 42900 5 8 1 0 0 0 1
l=0.4u
}
C 46500 48200 1 0 0 INV1-1.sym
{
T 46900 48800 5 10 1 1 0 0 1
refdes=X2
T 47300 48900 5 10 0 0 0 0 1
symversion=1.0
}
C 46700 43300 1 0 0 Vdd.sym
C 47400 43000 1 0 1 Vss.sym
N 47300 43300 48100 43300 4
N 46900 43300 46200 43300 4
N 47600 48500 48800 48500 4
{
T 47750 48550 5 10 1 1 0 0 1
netname=n
}
N 48800 48500 48800 43300 4
N 46500 48500 45300 48500 4
{
T 45800 48600 5 10 1 1 0 0 1
netname=p
}
N 45500 43300 45500 48500 4
C 44200 48200 1 0 0 INV1-1.sym
{
T 44600 48800 5 10 1 1 0 0 1
refdes=X1
T 45000 48900 5 10 0 0 0 0 1
symversion=1.0
}
C 42900 48700 1 0 0 pch.sym
{
T 43700 49500 5 10 1 1 0 0 1
refdes=M1
T 43700 49300 5 8 1 1 0 0 1
model-name=pch
T 43700 49000 5 8 1 0 0 0 1
w=1u
T 43700 48800 5 8 1 0 0 0 1
l=1u
}
C 42900 47300 1 0 0 nch.sym
{
T 43700 48100 5 10 1 1 0 0 1
refdes=M2
T 43700 47900 5 8 1 1 0 0 1
model-name=nch
T 43700 47600 5 8 1 0 0 0 1
w=3u
T 43700 47400 5 8 1 0 0 0 1
l=0.4u
}
N 44200 48500 43500 48500 4
{
T 44050 48300 5 10 1 1 0 0 1
netname=d
}
N 43500 48300 43500 48700 4
N 43600 49200 43600 49700 4
N 43600 49700 43500 49700 4
N 43500 47300 43600 47300 4
N 43600 47300 43600 47800 4
N 42900 47800 42900 49200 4
C 48800 44700 1 0 1 nch.sym
{
T 48000 45500 5 10 1 1 0 6 1
refdes=M4
T 48000 45300 5 8 1 1 0 6 1
model-name=nch
T 48000 45000 5 8 1 0 0 6 1
w=4u
T 48000 44800 5 8 1 0 0 6 1
l=0.75u
}
C 45500 44700 1 0 0 pch.sym
{
T 46300 45500 5 10 1 1 0 0 1
refdes=M3
T 46300 45300 5 8 1 1 0 0 1
model-name=pch
T 46300 45000 5 8 1 0 0 0 1
w=7.5u
T 46300 44800 5 8 1 0 0 0 1
l=0.4u
}
C 46700 45200 1 0 0 Vdd.sym
N 47300 45200 48100 45200 4
N 46900 45200 46200 45200 4
C 43300 49700 1 0 0 Vdd.sym
N 49500 42500 46100 42500 4
N 46100 42500 46100 42800 4
N 48200 42800 48200 42500 4
N 49500 44400 46100 44400 4
N 46100 44400 46100 44700 4
N 48200 44700 48200 44400 4
N 44800 45900 48200 45900 4
N 48200 45900 48200 45700 4
N 46100 45700 46100 45900 4
N 44800 44000 48200 44000 4
N 48200 44000 48200 43800 4
N 46100 43800 46100 44000 4
C 49300 44100 1 0 0 io.sym
{
T 50150 44350 5 10 1 1 0 0 1
refdes=P2
}
C 49300 42200 1 0 0 io.sym
{
T 50150 42450 5 10 1 1 0 0 1
refdes=P4
}
C 45000 45600 1 0 1 io.sym
{
T 44150 45850 5 10 1 1 0 6 1
refdes=P1
}
C 45000 43700 1 0 1 io.sym
{
T 44150 43950 5 10 1 1 0 6 1
refdes=P3
}
C 42700 48200 1 0 1 io.sym
{
T 41850 48450 5 10 1 1 0 6 1
refdes=P5
}
N 42500 48500 42900 48500 4
C 41300 41400 1 0 0 DPST-NC.sym
{
T 41500 42700 5 10 1 1 0 0 1
refdes=X?
T 41600 41500 5 8 1 1 0 1 1
device=DPST-NC
T 41850 41550 5 10 0 0 0 0 1
graphical=1
}
C 45700 41000 1 0 0 subcircuit.sym
{
T 45800 41300 5 10 1 1 0 0 1
refdes=A1
T 45800 41000 5 10 1 1 0 0 1
model-name=DPST-NC
T 45700 41000 5 10 0 0 0 0 1
common=Vdd Vss
}
C 43400 47000 1 0 0 Vss.sym
C 47200 44900 1 0 0 Vss.sym
