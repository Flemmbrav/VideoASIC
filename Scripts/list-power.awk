# Usage: awk -f list-power.awk < openIP.inc
#
# Generates a list of subcircuits and the power supplies they use

# Record the power net in ss
# Record whether we know of a power net for this subcircuit in have

function net( n ){
	if( (index( n, "VSS" ) == 1 ) || (index( n, "VDD" ) == 1)) {
		ss[subckt][n] = 1
		have[subckt] = 1
	}
}

# Skip comment
	
/^\*/{ next }

# Keep track of which subcircuit we're dealing with

/^\.SUBCKT/{
	subckt = toupper($2)
}

# Skip any other SPICE command

/^\./{next}

# Record net connections for resistors, capacitors, mosfets

/^R/{
	net( $2 )
	net( $3 )
}

/^C/{
	net( $2 )
	net( $3 )
}

/^M/{
	net( $2 )
	net( $3 )
	net( $4 )
	net( $5 )
}

# For subcircuits, need to record nets and references,
# since we must pass power down through hierarchy

/^X/{
	for( i = 2; i < NF; i += 1 ) net( $i )
	ref[subckt][toupper($NF)] = 1
}

END{

# First, follow a subcircuit's references and include their power nets.
# We have to do this until we reach a fixed point, as there's no ordering
# and thus no other way to tell when we've collected everybody's nets.

	change = 1
	while( change ) {
		change = 0
		for( subckt in ref ) {
			for( r in ref[subckt] ) {
				if( ! have[r] ) continue
				for( n in ss[r] ) {
					if( ! ss[subckt][n] ) {
						net( n )
						change = 1
					}
				}
			}
		}				
	}

# Print subcircuit name, power nets
	
	for( subckt in ss ) {
		printf "%s ", subckt
		for( n in ss[subckt] ) printf "%s ", n
		printf "\n"
	}
}
