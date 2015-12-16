#!/usr/bin/perl

$debug = 0;

$key{'children'} = 3;
$key{'cats '}= 7;
$key{'samoyeds'} = 2;
$key{'pomeranians'} = 3;
$key{'akitas'} = 0;
$key{'vizslas'} = 0;
$key{'goldfish'} = 5;
$key{'trees'} = 3;
$key{'cars '}= 2;
$key{'perfumes'} = 1;

while ($line = <STDIN>) {
	chomp $line;
    ($sueNum) = $line =~ /Sue (\d+): .*/;
    $line =~ s/Sue $sueNum: //;
    print "$sueNum:" if $debug;
    @aspects = split /, /, $line;
    foreach $aspect (@aspects) {
    	($type, $num) = $aspect =~ /(\w+): (\d+)/;
    	$aunts{$sueNum}{$type} = $num;
    	print "\t$aspect, $type, $num\n" if $debug;
    }
}

foreach $aunt (1..500) {
	$score = 0;
	foreach $aspect (sort keys %{$aunts{$aunt}}) {
		if ($aspect =~ /cats|trees/) {
			$score++ if $key{$aspect} < $aunts{$aunt}{$aspect};
		} elsif ($aspect =~ /pomeranians|goldfish/) {
			$score++ if $key{$aspect} > $aunts{$aunt}{$aspect};
		} else {
			$score++ if $key{$aspect} == $aunts{$aunt}{$aspect};
		}
	}
	print "It was Aunt Sue $aunt\n" if $score == 3;
}