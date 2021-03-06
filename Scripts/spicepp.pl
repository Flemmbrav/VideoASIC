eval '(exit $?0)' && 
    eval 'exec perl -S $0 ${1+"$@"}' && 
    eval 'exec perl -S $0 $argv:q'
    if 0;
# Copyright 2000 by John Sheahan <john@reptechnic.com.au>
#
#  This program is free software; you may redistribute and/or modify it under
#  the terms of the GNU General Public License Version 2 as published by the
#  Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY
#  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#  for complete details.
#

$ver= '$Id: spicepp.pl,v 1.4 2008-06-10 21:22:00 jpd Exp $ ';

require "getopts.pl";
&Getopts("hi");
(defined($opt_i)) ? ($interactive=1) : ($interactive=0) ;
if (defined($opt_h)) {
   print "$0 $ver\n";
   print "  -i interactive\n";
   
   print "  hspice-like spice preprocessor for berkeley spice\n";
   die;
} 
# preprocess a hspice-like deck for berkeley spice 3f5
# expand .lib   .param  .temp  .global 
# expoand .meas  
# support $ for comment to lineend

# $debug=1;

# first pass read in deck, 
# inline continuation lines, remove comment lines

$_=<>;chop;@deck=" " . $_;   # heading/comment line passthrough 

while (<>) {
    chop;
    # dont lowercase stuff in quotes
    if (/^(.*)([\'\"])(.*)([\"\'])(.*)/) {
	$_=lc($1) . $2 . $3 . $4 . lc($5);
    }
    else { $_ = lc($_); }
    s/\$.*//; # no trailing comments;
    s/^\*.*//;  # no comments;
    s/^\s*$//;  # no bl lines
    s/^\s+(.*)/$1/g; #get rid of blankspace
    if (/^\s*\+(.*)/) { # continuation
	$_ = pop (@deck) . " " . $1;
    }
    push @deck,$_ if (length($_) >0);  
}

while(&read_libs){}

&read_parameters;
&eval_parameters;
&expand_parameters;

&expand_eqns;

#&remove_vbracket;

#&read_globals;			ngspice now has globals -jpd
#&expand_global_subs;
#&expand_global_calls;

&fix_temp;

&expand_linearize;
&expand_meas;
&expand_control;

&process_models;

&printdeck;


if ($debug) {
    foreach $param (sort keys %param) {
	print STDERR  "param $param = $param{$param}\n";
  }
    foreach $global (sort keys %global) {
	print STDERR " global $global\n";
    }
}



################# subroutines #############

# include the specified model from the library. complain if not found.
sub libinclude {
    local ($file,$model,$found,@lib );
    $file=$_[0];
    $model=$_[1];
    @lib=();
    open (INCLUDE, "$file") || die "include file $file cannot be opened";
    $found=0;
	while (<INCLUDE>) {
      #get rid of blankspace, also allows you to optimise matches below
      s/^\s+(.*)/$1/g;
      last if ($found && /^\.endl/i);
      if ($found) {
	  	chop;
	  	# dont lowercase stuff in quotes
	  	if (/^(.*)([\'\"])(.*)([\"\'])(.*)/) {
	   	   $_=lc($1) . $2 . $3 . $4 . lc($5);
	  	}
      	else { $_ = lc($_); }
	  	s/\$.*//; # no trailing comments;
	  	s/^\*.*//;  # no comments;
	  	s/\s\s+/ /g; # shrink multiple whitespaces 
	  	s/\s*=\s*/=/g; # compress around =
	  	if (/^\+(.*)/) { # continuation
	      $_ = pop (@lib) . " " . $1;
	  	}
	  	push @lib,$_ if (length($_)>0);  
      }
      if (/^\.lib\s+$model\b/i) { $found=1}
  	}
    print STDERR "did not find model $model in library $file\n" unless ($found);
	return @lib;
}
################## &read_libs ############
sub read_libs {
    local ($i,$file,$model,$flag);
    $flag=0;
    for ($i=0;$i<@deck;$i++) {
	$_=$deck[$i];
	if (/^\.lib\s+[\'\"](.*)[\'\"]\s+(\S+)/i) {
	    $flag=1;
	    $file=$1;
	    $model=$2;
	    @lib=&libinclude($file,$model);
	    $_=@lib;
	    splice(@deck,$i,1,@lib);
	} }
    return $flag;
}


############## read globals ############ 
# record a hash of all global signals. kill the line.
sub read_globals {
    local ($i,$file,$model,@kill);
    for ($i=0;$i<@deck;$i++) {
	if ($deck[$i] =~ /^\.globals?\s+(.*)/) {
	    for (split(" ",$1)) { $global{$_}=1 }
	    push @kill,$i;
	}
  }
    &zapdeck(@kill);
}

############## kill line(s) in deck ################
sub zapdeck {
  # give it a list of lines to remove in increasing order!!!
  while ($_=pop(@_)) {
    splice @deck,$_,1;
  }
}
######### parameters #################
# find parameter define lines, remeber and delete them
sub read_parameters {
  local ($i,$j,@kill);
  for ($i=0;$i<@deck;$i++) {
    if ($deck[$i] =~/^\.param\s+(.*)/) {  # record param/value pairs
#      print STDERR "found param line $1\n";
      push @kill,$i;
      $_=$1;
      $done=0;
      until ($done) {
	if (/^\s*(\S+)\s*\=\s*\'([^\']*)\'(.*)/) {
#	  print STDERR "PARAM $1 = $2\n";
	  $param{$1}=&unit($2);
	  $_=$3;
	}
	elsif (/^\s*(\S+)\s*\=\s*(\S+)(.*)/) {
#	  print STDERR "PARAM(2) $1 = $2\n";
	  $param{$1}=&unit($2);
#	  print STDERR "PARAM(2) $1 = $param{$1}\n";
	  $_=$3;
	}
	else { $done=1; }
      }
#	  @param=split(" ",$1);
#      for ($j=0;$j<@param;$j++) {
#	if ($param[$j] =~ /(\S*)\s*=\s*(\S+)/) {
#	  $param{$1}=$2;
#	}
#	else {
#	  print STDERR "parameter parse error in line $_\n";
  } } # } 	}
  &zapdeck(@kill);
}
# replace parameters with defined string
# if the line starts with . - sub most places
# if not ., sub only last item
sub expand_parameters {
  local ($i,$j,$nline,$skip,$tmptoken);
  for ($i=0;$i<@deck;$i++) {
    $skip=&skipnumber($deck[$i]);
    if ($i==0) {$skip=0} # replace the first line
# print STDERR "skipping $skip fields $i $deck[$i]\n";
    $nline='';
    $_=$deck[$i];
    s/\(/ \( /g; # delimit openbracket
    s/\)/ \) /g; # delimit closebracket
    s/=/ = /g;
    @_=split;
    for ($j=0;$j<$skip;$j++) {
      $nline .= $_[$j]  . " ";
    }
    for ($j=$skip;$j<@_;$j++) {
	$tmptoken = $_[$j];
	while (defined($param{$tmptoken})) {
	    $tmptoken = $param{$tmptoken};	
	}
	$nline .= $tmptoken  . " ";
#      print STDERR "first $_[$j]\n" if ($j == $skip);
      
    }
#    print STDERR "$nline \n" if ($nline =~ /pwl/);
    $_=$nline;
    # undelimit openbracket for v(??) only
    s/([vi]) \(\s*([^\)\s]*)\s*\)/$1\($2\)/g; 
    s/ = /=/g; # 
    s/ $//;      # trailing space
    $deck[$i]=$_;
}  }

################## add globals to subckt IO line  ######################

# accept subroutine data 
# add used global signals to the io defn line
# remember them in $globalsub{sub} to fix other instantiate lines 
sub expand_global_subs {
  local ($i,$subroutine,$extras,%nodes,$subckt);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    if (defined($subckt)) { # remember nodes if in a subckt
      @_=split;
      for ($j=1;$j<@_-1;$j++) { # not first or last
	$nodes{$_[$j]}++ if (defined($global{$_[$j]}));
      }
    }
    if (/^\.subckt\s+(\S+)/) {
      $subckt=$1;
      $line=$i;
    }
    elsif (/^\.ends/) {
      $extras=join(" ", keys %nodes);
      $deck[$line] =~ s/^(.subckt.*)$/$1 $extras/;
      $globalsub{$subckt}=$extras;
      undef $subckt;
} } }

sub expand_global_calls {
  local ($i);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    if (/^(x.*)\s+(\S+)\s*$/ && defined($globalsub{$2})) {
      $deck[$i]="$1 $globalsub{$2} $2\n";
} } }
############ measure ####################
# appears you have to linearize it all the first time
sub expand_linearize  {
  local ($i,@xtra,$first);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    if (/^\.(tran|ac|dc)/) {
      $analysis=$1;
    }
    elsif (/^\.measu?r?e?\s+(\S+)\s+trig(.*)/) {
      $_=".meas $analysis $1 trig$2"; 
      $deck[$i]=$_;
      # fill in the missing type so I don't have to think later
    }
    if (/^\.measu?r?e? (tran|dc|ac)\s+(\S+)\s+trig\s+(\S+) .* targ\s+(\S+) .*/) {
      $first=$i unless (defined($first));
      $linearize{$3}=1;
      $linearize{$4}=1;
    }
  }
  if (defined($first)) {
    push(@xtra, ".control");
    $list=join(" ", keys %linearize);
    push(@xtra, "linearize time $list");
    push(@xtra, ".endc");
    splice(@deck,$first,0,@xtra);
    @xtra=();
  }
}
sub expand_meas  {
  local ($i,@xtra);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    if (/^\.measu?r?e? (tran|dc|ac)\s+(\S+)\s+trig\s+(\S+) .* targ\s+(\S+) .*/) {
      $name=$2;
      $trig=$3;
      $targ=$4;
      push(@xtra, ".control");
      push(@xtra, "print time $trig $targ > meas.data");
      push(@xtra, "echo $_ > meas.ctl");
      push(@xtra, "shell measure_spice $name");
      push(@xtra, ".endc");
      splice(@deck,$i,1,@xtra);
      @xtra=();
    }
  }
}
####################### control codes #############
sub expand_control  {
  local ($i,@xtra);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    if (/^\.(plot|print|tran|end)\b/) {
      $cmd=$1;
      s/^\.//; # drop initial dot
      s/\stran\s/ /;
      s/start=\S+//; # starts annow it
      push(@xtra, ".control");
      if ($cmd eq "end") {
	push(@xtra, "destroy all" ) unless ($interactive);
	push(@xtra, "quit") unless ($interactive);
      }
      else {
	push(@xtra, $_);
      }
      push(@xtra, ".endc");
      splice(@deck,$i,1,@xtra);
      @xtra=();
    }
  }
}

################# translate model level #######
# bsim3 (v3)
sub fix_temp {
  for ($i=0;$i<@deck;$i++) {
    if ($deck[$i] =~ /^\.tempe?r?a?t?u?r?e?\s*\=\s*(\S+)/) {
      $deck[$i] = ".options temp=$1";
} } }

sub printdeck {
  for (@deck) {
    print &wrapline(70,"","+","\n"," ",split(" ",$_)); 
  }
}

######################### wrapline ###############

# wrapline( linelen, header, header2, trailer, 
#           separator, list )
# where 
#  linelen max number of chars per line   eg 70
#  header   is a string stuck on to the beginning
#  header2  is a string to add to the second and all subsequent lines,
#           {if they exist]
#  trailer is a string to tack on to the end of the structure
#  separator is put between multiple elements in the list (NOT last)
#  list     
# returns string

sub wrapline {
    local($maxlen, $header, $header2, $trailer, 
          $separator, $linelen, @list, $output, $term, $last_term);

    ($maxlen, $header, $header2, $trailer, $separator, @list)=@_;
     $output=$header;
     $linelen=length($output);
     $last_term=pop(@list);
     foreach $term (@list) {
         if ((length($term)+$linelen+length($separator))>$maxlen) {
             $output .= "\n$header2" ;
             $linelen = length($header2);
         }
         $output .= "$term$separator";
         $linelen += length($term)+ length($separator);
     }
         if ((length($last_term)+$linelen+length($trailer))>$maxlen) {
             $output .= "\n$header2" ;
         }
         $output .= "$last_term$trailer";
return $output;
}

######################### equation support ########
sub isnumber {
  if (($_[0] =~ /\s*[\+\-]?[0-9\.]+\s*/) ||
      ($_[0] =~ /\s*[\+\-]?[0-9\.]+e[\+\-]?\d+/)) {
    return 1;
  }
  else {
    return 0;
  }
}
  
sub process {
#  print STDERR "mapped $_[0] ";
  local ($nline,$r,$i,$tmptoken);
  $_=$_[0];
  s/([\(\)\*\/])/ $1 /g; # space delimit operators
  s/([^eE])([\+\-])/$1 $2 /g; # special case for 1e-10 etc.
  s/\^\^/ ^^ /g; # space delimit exponent
#  print STDERR " delim $_ ";
  @_=split;
  for ($i=0;$i<@_;$i++) {
      $tmptoken = $_[$i];
      while (defined($param{$tmptoken})) {
	  $tmptoken = $param{$tmptoken};	
      }
      $nline .= $tmptoken  . " ";
  }
# print STDERR " $nline " ;
 $r=eval($nline);
  print STDERR $@ if ($@ ne '');
#  print STDERR "to $r\n";
  return $r;
}

# probably only one level deep..
sub eval_parameters {
  local ($val, $nval, $param);
  for $param (keys %param) {
#    print STDERR "checking param $param \n";
    $val=$param{$param};
    if ($val =~ /[\'\"](.*)[\'\"]/) {
      $nval=&process($1);
#      print STDERR "eval: processed $val to $nval\n";
      $param{$param}=$nval;
    }
    else {
      $nval = &unit($val);
#      print STDERR "eval: united $val to $nval\n";
      $param{$param}=$nval;
    }
  }
}
sub expand_eqns  {
  local ($i,$head,$tail,$p);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    while (/(.*)\'([^\']*)\'(.*)/) {
      $head=$1; $tail=$3;
      $p=&process($2);
      $_=$head . " $p " . $tail;
      s/= /=/g;
#      print STDERR "translated $deck[$i]\n        to $_\n";
    }
    $deck[$i]=$_;
  }
}
# if it looks like v(pin) replace with pin
sub remove_vbracket  {
  local ($i,$nline);
  for ($i=0;$i<@deck;$i++) {
    $_=$deck[$i];
    $nline='';
    for (split) {
      if (/^v\((.*)\)$/) { 
#      print STDERR "found vbracket $_ to $1 line $i\n";
	$_=$1;
}
      $nline .=  $_  . " ";
    }
    $deck[$i]=$nline;
}  }




sub unit {
  if ($_[0] =~ /^([0-9e\+\-\.]+)(t|g|meg|k|mil|m|u|n|p|f)?(v|a|s)?$/) {
    if    ($2 eq 't')   { $mult = 1e12 } 
    elsif ($2 eq 'g')   { $mult = 1e9  } 
    elsif ($2 eq 'meg') { $mult = 1e6  } 
    elsif ($2 eq 'k')   { $mult = 1e3  } 
    elsif ($2 eq 'm')   { $mult = 1e-3   } 
    elsif ($2 eq 'u')   { $mult = 1e-6   } 
    elsif ($2 eq 'n')   { $mult = 1e-9   } 
    elsif ($2 eq 'p')   { $mult = 1e-12  } 
    elsif ($2 eq 'f')   { $mult = 1e-15  } 
    elsif ($2 eq 'mil') { $mult = 25.4e-6} 
    else                { $mult = 1  } 
#    print STDERR "unit $_[0] mult $mult val $1 letter $2 unit $3\n";
    return $1 * $mult;
  }
  return $_[0];  # maybe perl does it better??
}


# when substituting parameters , skip this number from the start
sub skipnumber {
  local ($in,$f);
  $in=$_[0];
  $_=substr($in,0,1); # get the first char in the line
  $f=$_;
  # apart from the bjt - which I treat as a 3node device - all these 
  # have a fixed number of nodes
  $n=tr/cdefghijklmoqrstuvw/2244442322443244424/; # element nodes
# print STDERR "first char $f matched $_ skip $_ \n";
  if ($n == 1) { 
    return $_+1;   # add the name of the instance to the number of nodes
  }
  @_=split(" ",$in);
  $_=@_;
  if ($f eq 'x') { # only the last on ein a subckt call
    return $_-1;
  }
  $first=shift(@_);
  if ($first =~ /^\.meas/) { return 1 }   # process this line
  elsif ($first =~ /^\.tran/) { return 1 }   # process this line
  elsif ($first =~ /^\.lib/) { return 2 }   # process last one
  elsif ($first =~ /^\.model/) { return 3 }
  else { return $_ }                      # skip the line
}

################Fix all model incompatabilites #####################

sub process_models {
    $spice_scale = 1;

    &change_models;
    &change_instances;
}

################# reads all avalible models ####################
######### Translate the hspice levels to ones for ng-spice ##########
# The wise men at multigig have decided the following: 
#if level= 28 then use level=4
#  if level=49 or 53
#  Check BSIM version,
#    if version = 3.2 use level 50 (3v3.2)
#    if version = 3.1 use level 49 (3v3.1)
#    if version = 4.2 use level 14 (4v2.1)
#    else use level 8  
#               (most up to date model, 3v3.2.2 at the moment)
#     The parameters are also modified as follows:
#always remove the following:
#hspver, acm, calcasm, ldif, hdif, rd, rs, rsc, rdc (not used)
# Remove: NQSMOD if version >= 3v3.2 

sub change_models {
    local ($i,$model,@params,%default,$bin,$p);
    %default = (acm => 0, calcacm => 0, lmlt => 1, wmlt => 1, xl => 0, 
		xw => 0, php => 1, ldif => 0, hdif => 0, lmin => 0, 
		lmax => 0, wmin => 0, wmax => 0, hspver => 0, 
		rd => 0, rs => 0, rsc => 0, rdc => 0, geo => 0,
		tlev => 0, n => 0, tt => 0, binflag => 1,
		# There are from Bsim4.3 which ngspice does not have
		stimod => -1, sa0 => 0, sb0 => 0, kvsat => 0, wlod => 0,
		tku0 => 0, ku0 => 0, llodku0 => 0, wlodku0 => 0, lku0 => 0, wku0 => 0,
		pku0 => 0, kvth0 => 0, stk2 => 0, steta0 => 0, lkvth0 => 0, wkvth0 => 0,
		pkvth0 => 0, llodvth => 0, wlodvth => 0, lodk2 => 1, lodeta0 => 1,
		# A few more that TSMC uses, ngspice doesn't have -jpd
		cta => 0, ctp => 0, pta => 0, ptp => 0, sfvtflag => 0, vfbflag => 0,
		tlevc => 0);
    for ($i=0;$i<@deck;$i++) {
	$_ = $deck[$i];
	if(/^\.model\s+(\S+)\s+[np]mos/) {
#	    print STDERR "got ".$_."\n";

	    split /\./, $1 ;
	    $model = $_[0];
	    $bin = $1;
	    push @$model, $bin;
	    
	    #First read level and version info and set the level
	    #and put acm to default value

	    $_ = $deck[$i];
	    /\blevel\s*=\s*([0-9]+)\b/;

	    if($1 == 49){
		$$bin{"acm"} = 0;}
	    elsif($1 == 53){
		$$bin{"acm"} = 10;}
	    else{ 
		$$bin{"acm"} = 0; }

	    if(/\bversion\s*=\s*([0-9\.]+)\b/){
	    
		if($1 eq "3.2"){
		    $deck[$i] =~ s/\blevel\s*=\s*[0-9]+\b/level=50/;
		    $deck[$i] =~ s/(.*)\bnqsmod\s*=\s*\S*\b(.*)/$1$2/;}
		
		elsif($1 eq "3.1"){
		    $deck[$i] =~ s/\blevel\s*=\s*[0-9]+\b/level=49/;}
				
		elsif($1 eq "4.2"){
		    $deck[$i] =~ s/\blevel\s*=\s*[0-9]+\b/level=14/;
		    $deck[$i] =~ s/\bversion\s*=\s*[0-9\.]+\b/version=4.2.1/;
		} else {
		    $deck[$i] =~ s/\blevel\s*=\s*[0-9]+\b/level=8/;
		    $deck[$i] =~ s/(.*)\bnqsmod\s*=\s*\S*\b(.*)/$1$2/;}
	    }
	    
	    
	    # get rid of hspice only variables, and store them
	    foreach $p (keys %default){
			if ($p ne "acm"){
		    	$$bin{$p} = $default{$p};} 
	    }
		$newline = "";
		@list = split /[\s\(\)]/,$deck[$i];
		# zap ".model name type"
		$newline =  shift @list;
		$newline .= " " . shift @list;
		$newline .= " " . shift @list;
		foreach $item (@list) {
			($name,$value) = split /=/,$item;
			if(exists($default{$name})){
				$$bin{$name} = $value;
			} else {
				$newline .= " " . $item;
			}
		}
		$deck[$i] = $newline;
    
	    #translate some vars
	    $deck[$i] =~ s/(\b)tref(\s*=)/${1}tnom$2/;

	    #HDIFeff needed not HDIF
	    $$bin{"hdif"} *=  $$bin{"wmlt"};
	}
#end if mosfet model
	if (/\.opt\S*\s+scale=(\S+)/) {
	    $spice_scale = &unit($1);
	}
    }
#end for
}
#end sub

#### selects the correct model and does l, w scaling and acm#####


sub change_instances {
    local($i,$model,$l,$w,$p,$m,$ad,$as,$pd,$ps,$nrs,$nrd);
    for ($i=0;$i<@deck;$i++) {
	$_ = $deck[$i];
	if(/^m\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+(\S+)/) {

	    #print STDERR "processing ".$_."\n";
	    $model = $1;


	    #Model binning
	    if(/.*\bl\s*=\s*(\S+)\b.*/){
		$l = &unit($1);
		$l *= $spice_scale;
	    }else {print STDERR "no l found\n";die;}

	    if(/.*\bw\s*=\s*(\S+)\b.*/){
		$w = &unit($1);
		$w *= $spice_scale;
	    }else {print STDERR "no w found\n";die;}

	    #Loops though all bins and selects one
	    foreach $p (@$model){
		if(
		   $l <= $$p{'lmax'} &&
		   $l >= $$p{'lmin'} &&
		   $w <= $$p{'wmax'} &&
		   $w >= $$p{'wmin'}
		   ){
		    $deck[$i] =~ 
			s/(^\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+)(\S+)/$1$p/;
		    $model = $p;
		    goto model_found;
		}
	    }
	    print STDERR "Model or bin not found for model=$model, w=$w, l=$l\n";
	    next;	    
	  model_found:
	    #W & L mangling and acm stuff
	    #Get m
	    if($deck[$i] =~ s/(.*)\bm\s*=\s*([0-9]+)\b(.*)/$1$3/){
		$m = $2;}else {$m = 1;}
	    
	    #get and remove pd, ps, ad, as, nrs, nrd
	    if($deck[$i] =~ s/(.*)\bpd\s*=\s*(\S+)\b(.*)/$1$3/){
		$pd = &unit($2);
		$pd *= $spice_scale;
	    }else{ $pd = 0;}

	    if($deck[$i] =~ s/(.*)\bps\s*=\s*(\S+)\b(.*)/$1$3/){
		$ps = &unit($2);
		$ps *= $spice_scale;
	    }else{ $ps = 0;}
	    
	    if($deck[$i] =~ s/(.*)\bas\s*=\s*(\S+)\b(.*)/$1$3/){
		$as = &unit($2);
		$as *= $spice_scale * $spice_scale;
	    }else{ $as = 0;}

	    if($deck[$i] =~ s/(.*)\bad\s*=\s*(\S+)\b(.*)/$1$3/){
		$ad = &unit($2);
		$ad *= $spice_scale * $spice_scale;
	    }else{ $ad = 0;}
	    
	    if($deck[$i] =~ s/(.*)\bnrs\s*=\s*(\S+)\b(.*)/$1$3/){
		$nrs = &unit($2);
	    }else{ $nrs = 1;}
	    
	    if($deck[$i] =~ s/(.*)\bnrd\s*=\s*(\S+)\b(.*)/$1$3/){
		$nrd = &unit($2);
	    }else{ $nrd = 1;}
	    
	    #Calculate Leff and Weff
	    $w = $m * ($w * $$model{"wmlt"} + $$model{"xw"});
	    $l = $l * $$model{"lmlt"} + $$model{"xl"};
	    
	    # Adjust source/drain resistances for multiplicity
	    $nrs /= $m;
	    $nrd /= $m;

	    #Now do the ACM stuff......
	    #gathered from Hspice manual release 1999.4 December 1999

	    #Now the perimeters and areas 
	    #calculated using hspice methods..
	    if( $$model{"acm"} == 0){
		#pg 869, 19-33
		$ad = $m * $ad * $$model{"wmlt"} * $$model{"wmlt"};
		$as = $m * $as * $$model{"wmlt"} * $$model{"wmlt"};
		$pd = $m * $pd * $$model{"wmlt"};
		$ps = $m * $ps * $$model{"wmlt"}; 
		
	    }

	    elsif( $$model{"acm"} == 1){
		#pg 871, 19-35
		$as = $ad =  $$model{"wmlt"} * $w;
		$ps = $pd = $w;
	    }

	    elsif( $$model{"acm"} == 2){
		#pg 874, 19-39
		if($ad){
		    $ad = $ad * $m * $$model{"wmlt"} * $$model{"wmlt"};
		}else {
		    $ad = 2 * $$model{"hdif"} * $w;}
		
		if($as){
		    $as = $m * $as * $$model{"wmlt"} * $$model{"wmlt"};
		}else{
		    $as = 2 * $$model{"hdif"} * $w;}
		
		if($pd){
		    $pd = $m * $pd * $$model{"wmlt"};
		}else {
		    $pd = 4 *  $$model{"hdif"} + 2 * $w;
		}
		
		if($ps){
		    $ps = $m * $ps * $$model{"wmlt"};
		}else{
		    $ps = 4 * $$model{"hdif"} + 2 * $w;
		}
	    }

	    elsif( $$model{"acm"} == 3){
		#pg 879, 19-43
		if($ad){
		    $ad = $m * $ad * $$model{"wmlt"} * $$model{"wmlt"};}
		elsif($$model{"geo"} == 0 || $$model{"geo"} == 2){
		    $ad = 2 * $$model{"hdif"} * $w;
		}else{
		    $ad = $$model{"hdif"} * $w;
		}

		if($as){
		    $as = $m * $as * $$model{"wmlt"} * $$model{"wmlt"};}
		elsif($$model{"geo"} == 0 || $$model{"geo"} == 1){
		    $as = 2 * $$model{"hdif"} * $w;
		}else{
		    $as = $$model{"hdif"} * $w;
		}

		if($pd){
		    $pd = $m * $pd * $$model{"wmlt"};}
		elsif($$model{"geo"} == 0 || $$model{"geo"} == 2){
		    $pd = 4 * $$model{"hdif"} + $w;
		}else{
		    $pd = 2 * $$model{"hdif"};
		}

		if($ps){
		    $ps = $m * $ps * $$model{"wmlt"};}
		elsif($$model{"geo"} == 0 || $$model{"geo"} == 1){
		    $ps = 4 * $$model{"hdif"} + $w;
		}else{
		    $ps = 2 * $$model{"hdif"};
		}
	    }

	    #following acm's from pg 1198, 26-246

	    elsif( $$model{"acm"} == 10){
		
	    }

	    elsif( $$model{"acm"} == 11){
		
	    }

	    elsif( $$model{"acm"} == 12 ){
		if( $$model{"calcacm"} == 1 ) {
		if($ad){
		    $ad = $ad * $$model{"wmlt"} * $$model{"wmlt"};
		}else{
		    $ad = 2 * $$model{"hdif"} * $w;
		}

		if($as){
		    $as = $as * $$model{"wmlt"} * $$model{"wmlt"};
		}else{
		    $as =  2 * $$model{"hdif"} * $w;
		}

		if($ps){
		    $ps = $ps *  $$model{"wmlt"};
		}else{
		    $ps = 4 * $$model{"hdif"} + 2 * $w;
		}

		if($pd){
		    $pd = $pd * $$model{"wmlt"};
		}else{
		    $pd = 4 * $$model{"hdif"} + 2 * $w;
		}
		}
	    }

	    elsif( $$model{"acm"} == 13){
    
	    } 
	    else {
		print STDERR "Bad acm number in ".$model." ".$acm."\n";
		die;
	    }

	    #Now write the values into the file......
	    $l /= $spice_scale;
	    $w /= $spice_scale;

	    $pd /= $spice_scale;
	    $ps /= $spice_scale;

	    $as /= $spice_scale * $spice_scale;
	    $ad /= $spice_scale * $spice_scale;

	    $deck[$i] =~ s/\b(l\s*=\s*)(\S+)\b/$1$l/;

	    $deck[$i] =~ s/\b(w\s*=\s*)(\S+)\b/$1$w/;
	    
	    $deck[$i] .= " pd=".$pd." ps=".$ps." as=".$as." ad=".$ad." nrs=".$nrs." nrd=".$nrd;
	}
	#end if mosfet
    }
    #end for
}
#end of sub
