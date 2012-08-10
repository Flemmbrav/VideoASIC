/^\*/{
	editing=1
}

{
	if(editing) {
		if( $1 == ".SUBCKT" ) {
			printf "%s", $0
			npf = split(db[$2],pf)
			for( i = 2; i <=npf; i += 1) printf " %s", pf[i] 
			printf "\n"
		}
		else if( index( $1, "X") == 1 ) {
			for( i = 0; i < NF ; i += 1 ) printf "%s ", $i
			npf = split(db[toupper($NF)],pf)
			for( i = 2; i <=npf; i += 1) printf "%s ", pf[i]
			print $NF
		}
		else print
	}
	else db[$1] = $0
}

