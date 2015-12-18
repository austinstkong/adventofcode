#!/usr/bin/perl

use List::Util qw/shuffle sum/;

$debug = 0;

$i = 0;
while ($line = <STDIN>) {
	chomp $line;
    $containers{$i} = $line;
    $i++;
}

$toStore = 150;

$i = 0;
%tested = ();
$maxHappy = 0;
while (1) {
	$i++;
	@arr = shuffle(keys %containers);
	@newOrder = ();
	@keyList = ();
	foreach $size (@arr) {
		push @newOrder, $containers{$size};
		push @keyList, $size;
		$order = join ' ', sort(@keyList);
		next if exists $tested{$order};
		$tested{$order} = 1;
		$volume = sum @newOrder;
		# print "v = $volume\n";
		if ($volume == $toStore) {
			$total++;
			print "$total, @newOrder\n";
		} elsif ($volume > $toStore) {
			next;
		}
	}
}