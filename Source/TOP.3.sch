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
page=3
T 51900 40200 5 10 1 1 0 0 1
pages=7
}
C 45700 44500 1 0 0 Chain.sym
{
T 46700 45500 5 10 1 1 0 0 1
device=Chain
T 45700 46500 5 10 1 1 0 0 1
refdes=X1
}
C 44000 45800 1 0 0 PATHR-1.sym
{
T 44200 46700 5 10 1 1 0 0 1
refdes=XP11
T 44100 47700 5 10 0 0 0 0 1
symversion=1.0
}
C 44000 44600 1 0 0 PATHR-1.sym
{
T 44200 45500 5 10 1 1 0 0 1
refdes=XP12
T 44100 46500 5 10 0 0 0 0 1
symversion=1.0
}
C 44200 46500 1 180 0 io.sym
{
T 43350 46250 5 10 1 1 180 0 1
refdes=P11
}
C 44200 45300 1 180 0 io.sym
{
T 43350 45050 5 10 1 1 180 0 1
refdes=P12
}
T 46100 47600 8 10 0 0 0 0 1
symversion=1.0
C 48300 45200 1 0 0 LVDD.sym
{
T 48800 45700 5 10 1 1 0 4 1
device=LVDD
T 48500 46200 5 10 1 1 0 0 1
refdes=XD1
T 48500 47400 5 10 0 0 0 0 1
symversion=1.0
}
C 48800 44900 1 0 0 Vss1.sym
C 49500 45900 1 0 0 PDTH-1.sym
{
T 49700 46800 5 10 1 1 0 0 1
refdes=XP54
T 49600 47800 5 10 0 0 0 0 1
symversion=1.0
}
C 49500 44700 1 0 0 PDTH-1.sym
{
T 49700 45600 5 10 1 1 0 0 1
refdes=XP53
T 49600 46600 5 10 0 0 0 0 1
symversion=1.0
}
N 49500 45900 49500 46300 4
N 49500 45500 49500 45100 4
C 50500 46000 1 0 0 io.sym
{
T 51350 46250 5 10 1 1 0 0 1
refdes=P54
}
C 50500 44800 1 0 0 io.sym
{
T 51350 45050 5 10 1 1 0 0 1
refdes=P53
}
C 50500 43600 1 0 0 io.sym
{
T 51350 43850 5 10 1 1 0 0 1
refdes=P30
}
N 48300 43900 48300 45100 4
N 45700 45400 45700 45000 4
N 45700 45700 45700 46200 4
N 46100 46600 46100 46800 4
{
T 46100 46900 5 10 1 1 270 7 1
netname=Dout0
}
N 46400 46600 46400 46800 4
{
T 46400 46900 5 10 1 1 270 7 1
netname=Dload
}
N 46700 46600 46700 46800 4
{
T 46700 46900 5 10 1 1 270 7 1
netname=DCLK
}
N 47000 46600 47000 46800 4
{
T 47000 46900 5 10 1 1 270 7 1
netname=DRSTb
}
N 47300 46600 47300 46800 4
{
T 47300 46900 5 10 1 1 270 7 1
netname=Dout1
}
N 47600 46600 47600 46800 4
{
T 47600 46900 5 10 1 1 270 7 1
netname=Ref
}
N 47600 44500 47600 44300 4
{
T 47600 44200 5 10 1 1 90 7 1
netname=Deint
}
N 47300 44500 47300 44300 4
{
T 47300 44200 5 10 1 1 90 7 1
netname=Int
}
N 47000 44500 47000 44300 4
{
T 47000 44200 5 10 1 1 90 7 1
netname=Clamp
}
N 46700 44500 46700 44300 4
{
T 46700 44200 5 10 1 1 90 7 1
netname=Cclk
}
N 48900 46200 48900 46400 4
{
T 48900 46500 5 10 1 1 270 7 1
netname=LVH
}
C 50700 43500 1 0 1 PATHR-1.sym
{
T 50500 44400 5 10 1 1 0 6 1
refdes=XP30
T 50600 45400 5 10 0 0 0 6 1
symversion=1.0
}
N 49000 43900 48300 43900 4
T 46600 41700 9 20 1 0 0 0 1
Chain 1
