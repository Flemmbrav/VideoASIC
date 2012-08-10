/^v /{
	editing=1
}

{
	if(editing) {
		if( index( $1, "model-name=") == 1 ) {
			print "T 0 0 0 0 0 0 0 0 1"
			split( $1 ,df,"=")
			npf = split( db[toupper(df[2])], pf )
			printf "spice-prototype=X? %pinseq "
			for( i = 2; i <=npf; i += 1) printf "%s ", pf[i]
			printf "model-name@\n"
		}
	}
	else db[$1] = $0
}
