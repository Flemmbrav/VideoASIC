v 20110115 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=20130111
T 53900 40500 5 10 1 1 0 0 1
rev=1.0
T 53900 40200 5 10 1 1 0 0 1
auth=jpd
T 53200 40900 5 14 1 1 0 4 1
title=Video ASIC
T 50500 40200 5 10 1 1 0 0 1
page=2
T 51900 40200 5 10 1 1 0 0 1
pages=7
}
C 44500 42600 1 0 0 Chain.sym
{
T 45500 43600 5 10 1 1 0 0 1
device=Chain
T 44500 44600 5 10 1 1 0 0 1
refdes=X0
}
C 42800 43900 1 0 0 PATHR-1.sym
{
T 43000 44800 5 10 1 1 0 0 1
refdes=XP9
T 42900 45800 5 10 0 0 0 0 1
symversion=1.0
}
C 42800 42700 1 0 0 PATHR-1.sym
{
T 43000 43600 5 10 1 1 0 0 1
refdes=XP10
T 42900 44600 5 10 0 0 0 0 1
symversion=1.0
}
C 43000 44600 1 180 0 io.sym
{
T 42150 44350 5 10 1 1 180 0 1
refdes=P9
}
C 43000 43400 1 180 0 io.sym
{
T 42150 43150 5 10 1 1 180 0 1
refdes=P10
}
T 46100 47600 8 10 0 0 0 0 1
symversion=1.0
C 47100 43300 1 0 0 LVDD.sym
{
T 47600 43800 5 10 1 1 0 4 1
device=LVDD
T 47300 44300 5 10 1 1 0 0 1
refdes=XD0
T 47300 45500 5 10 0 0 0 0 1
symversion=1.0
}
C 47600 43000 1 0 0 Vss1.sym
C 48300 44000 1 0 0 PDTH-1.sym
{
T 48500 44900 5 10 1 1 0 0 1
refdes=XP58
T 48400 45900 5 10 0 0 0 0 1
symversion=1.0
}
C 48300 42800 1 0 0 PDTH-1.sym
{
T 48500 43700 5 10 1 1 0 0 1
refdes=XP57
T 48400 44700 5 10 0 0 0 0 1
symversion=1.0
}
N 48300 44000 48300 44400 4
N 48300 43600 48300 43200 4
C 49300 44100 1 0 0 io.sym
{
T 50150 44350 5 10 1 1 0 0 1
refdes=P58
}
C 49300 42900 1 0 0 io.sym
{
T 50150 43150 5 10 1 1 0 0 1
refdes=P57
}
C 49300 41700 1 0 0 io.sym
{
T 50150 41950 5 10 1 1 0 0 1
refdes=P32
}
N 47100 42000 47100 43200 4
N 44500 43500 44500 43100 4
N 44500 43800 44500 44300 4
N 44900 44700 44900 45600 4
{
T 44800 45000 5 10 1 1 270 7 1
netname=Din
}
N 45200 44700 45200 46900 4
{
T 46900 46900 5 10 1 1 0 7 1
netname=Dload
}
N 45500 44700 45500 48200 4
{
T 46900 48200 5 10 1 1 0 7 1
netname=DCLK
}
N 45800 44700 45800 49500 4
{
T 47000 49500 5 10 1 1 0 7 1
netname=DRSTb
}
N 46100 44700 46100 44900 4
{
T 46100 45000 5 10 1 1 270 7 1
netname=Dout0
}
N 46400 44700 46400 44900 4
{
T 46400 45000 5 10 1 1 270 7 1
netname=Ref
}
N 46400 42600 46400 42400 4
{
T 46400 42300 5 10 1 1 90 7 1
netname=Deint
}
N 46100 42600 46100 42400 4
{
T 46100 42300 5 10 1 1 90 7 1
netname=Int
}
N 45800 42600 45800 42400 4
{
T 45800 42300 5 10 1 1 90 7 1
netname=Clamp
}
N 45500 42600 45500 42400 4
{
T 45500 42300 5 10 1 1 90 7 1
netname=Cclk
}
N 47700 44300 47700 44500 4
{
T 47700 44600 5 10 1 1 270 7 1
netname=LVH
}
C 42800 45200 1 0 0 PDIN-1.sym
{
T 43000 46100 5 10 1 1 0 0 1
refdes=XP76
T 42900 47100 5 10 0 0 0 0 1
symversion=1.0
}
N 44900 45600 44400 45600 4
C 43000 45900 1 180 0 io.sym
{
T 42150 45650 5 10 1 1 180 0 1
refdes=P76
}
C 49500 41600 1 0 1 PATHR-1.sym
{
T 49300 42500 5 10 1 1 0 6 1
refdes=XP32
T 49400 43500 5 10 0 0 0 6 1
symversion=1.0
}
N 47800 42000 47100 42000 4
C 42800 46500 1 0 0 PDIN-1.sym
{
T 43000 47400 5 10 1 1 0 0 1
refdes=XP74
T 42900 48400 5 10 0 0 0 0 1
symversion=1.0
}
C 43000 47200 1 180 0 io.sym
{
T 42150 46950 5 10 1 1 180 0 1
refdes=P74
}
C 42800 47800 1 0 0 PDIN-1.sym
{
T 43000 48700 5 10 1 1 0 0 1
refdes=XP73
T 42900 49700 5 10 0 0 0 0 1
symversion=1.0
}
C 43000 48500 1 180 0 io.sym
{
T 42150 48250 5 10 1 1 180 0 1
refdes=P73
}
C 42800 49100 1 0 0 PDIN-1.sym
{
T 43000 50000 5 10 1 1 0 0 1
refdes=XP72
T 42900 51000 5 10 0 0 0 0 1
symversion=1.0
}
C 43000 49800 1 180 0 io.sym
{
T 42150 49550 5 10 1 1 180 0 1
refdes=P72
}
N 44400 46900 46300 46900 4
N 44400 48200 46300 48200 4
N 44400 49500 46300 49500 4
T 45300 40700 9 20 1 0 0 0 1
Chain 0