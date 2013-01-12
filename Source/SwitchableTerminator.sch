v 20110115 2
C 47100 51800 1 0 0 nch.sym
{
T 47900 52600 5 10 1 1 0 0 1
refdes=M1
T 47900 52400 5 8 1 1 0 0 1
model-name=nch
T 47900 52100 5 8 1 0 0 0 1
w=2u
T 47900 51900 5 8 1 0 0 0 1
l=1u
T 47100 51900 5 10 1 0 0 0 1
m=68
}
N 47800 52300 48700 52300 4
C 48300 52700 1 0 0 resistor-1.sym
{
T 48600 53100 5 10 0 0 0 0 1
device=RESISTOR
T 48500 53000 5 10 1 1 0 0 1
refdes=R1
T 48500 52500 5 10 1 1 0 0 1
value=30
}
C 48300 51500 1 0 0 resistor-1.sym
{
T 48600 51900 5 10 0 0 0 0 1
device=RESISTOR
T 48500 51800 5 10 1 1 0 0 1
refdes=R2
T 48500 51300 5 10 1 1 0 0 1
value=30
}
N 48300 51600 47700 51600 4
N 47700 51600 47700 51800 4
N 47700 52800 48300 52800 4
C 39900 47000 0 0 0 Noqsi-title-B.sym
{
T 49900 47500 5 10 1 1 0 0 1
date=20130111
T 53800 47500 5 10 1 1 0 0 1
rev=1.0
T 55300 47200 5 10 1 1 0 0 1
auth=jpd
T 53060 47916 5 14 1 1 0 4 1
title=Switchable 100 ohm terminator
}
C 51950 50400 1 0 0 SwitchableTerminator.sym
{
T 52450 50450 5 10 1 1 0 0 1
refdes=X?
T 52350 50450 5 10 0 0 0 0 1
graphical=1
}
C 47300 52000 1 0 1 io.sym
{
T 46450 52250 5 10 1 1 0 6 1
refdes=P3
}
C 49000 52500 1 0 0 io.sym
{
T 49850 52750 5 10 1 1 0 0 1
refdes=P1
}
C 48500 52000 1 0 0 io.sym
{
T 49350 52250 5 10 1 1 0 0 1
refdes=P4
}
C 49000 51300 1 0 0 io.sym
{
T 49850 51550 5 10 1 1 0 0 1
refdes=P2
}
T 50500 47200 9 10 1 0 0 0 1
1
T 51900 47250 9 10 1 0 0 0 1
1
C 47056 49330 1 0 0 subcircuit.sym
{
T 47156 49630 5 10 1 1 0 0 1
refdes=A1
T 47156 49330 5 10 1 1 0 0 1
model-name=SwitchableTerminator
T 47434 49120 5 10 1 0 0 0 1
common=Vss
}