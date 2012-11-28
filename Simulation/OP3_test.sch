v 20110115 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=?
T 53900 40500 5 10 1 1 0 0 1
rev=0.0
T 53900 40200 5 10 1 1 0 0 1
auth=jpd
T 53200 40900 5 14 1 1 0 4 1
title=TITLE
T 50500 40200 5 10 1 1 0 0 1
page=1
T 51900 40200 5 10 1 1 0 0 1
pages=1
}
C 45400 45900 1 0 0 OP3-1.sym
{
T 46100 46900 5 10 1 1 0 0 1
refdes=Xut
T 46000 47700 5 10 0 0 0 0 1
symversion=1.0
}
C 44400 43800 1 0 0 BIAS1-1.sym
{
T 44800 44600 5 10 1 1 0 0 1
refdes=Xb
T 44700 45400 5 10 0 0 0 0 1
symversion=1.0
}
N 47000 46500 47000 45600 4
{
T 47100 46200 5 10 1 1 0 0 1
netname=out
}
N 47000 45600 45400 45600 4
N 45400 45600 45400 46200 4
N 45800 44000 46000 44000 4
N 46000 44000 46000 45900 4
{
T 46100 44700 5 10 1 1 0 0 1
netname=vl
}
C 45400 42900 1 0 0 resistor-1.sym
{
T 45600 43200 5 10 1 1 0 0 1
refdes=R1
T 45800 42700 5 10 1 1 0 0 1
value=5k
}
C 46400 42900 1 0 0 resistor-1.sym
{
T 46600 43200 5 10 1 1 0 0 1
refdes=R2
T 46800 42700 5 10 1 1 0 0 1
value=5k
}
N 46400 46100 46400 43000 4
{
T 46500 45100 5 10 1 1 0 0 1
netname=vm
}
N 46400 43000 46300 43000 4
C 45200 43000 1 0 0 Vdd.sym
C 47200 42700 1 0 0 Vss.sym
C 42500 45600 1 0 0 vac-1.sym
{
T 43200 46250 5 10 1 1 0 0 1
refdes=Vi
T 43200 46050 5 10 1 1 0 0 1
value=dc 1.2 ac 1 sin 1.2 1
}
C 42700 45300 1 0 0 Vss.sym
N 45400 46800 42800 46800 4
{
T 44100 46900 5 10 1 1 0 0 1
netname=in
}
C 41700 44000 1 0 0 idc-1.sym
{
T 42400 44650 5 10 1 1 0 0 1
refdes=Ib
T 42400 44450 5 10 1 1 0 0 1
value=DC 10uA
}
N 42000 45200 42000 45600 4
N 42000 45600 42800 45600 4
N 42000 44000 44400 44000 4
{
T 43500 44100 5 10 1 1 0 0 1
netname=vb
}
C 48100 45300 1 0 0 vdc-1.sym
{
T 48800 45950 5 10 1 1 0 0 1
refdes=Vload
T 48800 45750 5 10 1 1 0 0 1
value=DC 1.2V
}
C 48300 45000 1 0 0 Vss.sym
N 48400 46500 47000 46500 4
