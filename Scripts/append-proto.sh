#! /bin/bash
grep spice-prototype= $1 || cat power.txt $1 | \
 awk -f ../Scripts/openip-proto.awk >>$1
