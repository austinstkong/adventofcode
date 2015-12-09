#!/usr/bin/perl

use List::Util qw/shuffle/;

$debug = 0;

while (<STDIN>) {
    /(\w+) to (\w+) = (\d+)/ || next;
    $distance{$1}{$2} = $3;
    $distance{$2}{$1} = $3;
}

$i = 0;
%visited = ();
$max = 0;
$min = 1000000;
while ($i < 50000) {
	$i++;
	@arr = shuffle(keys %distance);
	$towns = join ' ', @arr;
	next if exists $visited{$towns};
	$visited{$towns} = 1;
	$path = 0;
	foreach $j (0..$#arr-1) {
		$path += $distance{$arr[$j]}{$arr[$j+1]};
	}
	$min = $path if $path < $min;
	$max = $path if $path > $max;
	print "$towns: $path\n" if $debug;
}

print "Shortest path: $min\n";
print "Longest path: $max\n";
