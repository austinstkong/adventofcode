#!/usr/bin/perl

$debug = 0;
$max = 999;

foreach $x (0..$max) {
	foreach $y (0..$max) {
		$map[$x][$y] = 0;
	}
}

while ($line = <STDIN>) {
	chomp $line;
	($mode, $x1, $y1, $x2, $y2) = $line =~ /([^\d]+) (\d+),(\d+)[^\d]+(\d+),(\d+)/;
	print "$mode|($x1,$y1)|($x2,$y2)\n" if $debug;
	foreach $x ($x1..$x2) {
		foreach $y ($y1..$y2) {
			$map[$x][$y] = 1 if $mode eq "turn on";
			$map[$x][$y] = 0 if $mode eq "turn off";
			$map[$x][$y] = 1 - $map[$x][$y] if $mode eq "toggle";
		}
	}
}

foreach $x (0..$max) {
	foreach $y (0..$max) {
		print "$map[$x][$y] " if $debug;
		$lightsOn++ if $map[$x][$y] ;
	}
	print "\n" if $debug;
}

print "Number of lights on: $lightsOn\n";