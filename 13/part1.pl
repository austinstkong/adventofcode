#!/usr/bin/perl

use List::Util qw/shuffle/;

$debug = 0;

while (<STDIN>) {
    /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)./ || next;
    $happiness{$1}{$4} = $3;
    $happiness{$1}{$4} *= -1 if ($2 eq "lose");
}

$i = 0;
%tested = ();
$maxHappy = 0;
while ($i < 6000) {
	$i++;
	@arr = shuffle(keys %happiness);
	$seatingPlan = join ' ', @arr;
	next if exists $tested{$seatingPlan};
	$tested{$seatingPlan} = 1;
	$happy = 0;
	$happy += $happiness{$arr[0]}{$arr[1]};
	$happy += $happiness{$arr[0]}{$arr[$#arr]};
	foreach $j (1..$#arr-1) {
		$happy += $happiness{$arr[$j]}{$arr[$j+1]};
		$happy += $happiness{$arr[$j]}{$arr[$j-1]};
	}
	$happy += $happiness{$arr[$#arr]}{$arr[$#arr-1]};
	$happy += $happiness{$arr[$#arr]}{$arr[0]};
	print "$seatingPlan: $happy\n" if $debug;
	$maxHappy = $happy if $happy >= $maxHappy;
}

print "Max happiness: $maxHappy\n";