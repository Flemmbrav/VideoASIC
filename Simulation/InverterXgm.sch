v 20111231 2
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
C 47000 45700 1 0 0 InverterX.sym
{
T 47200 46400 5 10 1 1 0 0 1
refdes=X1
}
C 45100 44800 1 0 0 vac-1.sym
{
T 45800 45450 5 10 1 1 0 0 1
refdes=V1
T 45800 45250 5 10 1 1 0 0 1
value=dc 1.63 ac 1
}
N 45400 46000 47000 46000 4
C 45300 44500 1 0 0 Vss.sym
N 48100 46000 49000 46000 4
{
T 48800 46100 5 10 1 1 0 0 1
netname=out
}
C 48900 44500 1 0 0 Vss.sym
C 48700 44800 1 0 0 vdc-1.sym
{
T 49400 45450 5 10 1 1 0 0 1
refdes=V2
T 49400 45250 5 10 1 1 0 0 1
value=DC 1.63
}