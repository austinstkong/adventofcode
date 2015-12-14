#!/usr/bin/perl

use List::Util qw/max/;

$debug = 0;

while (<STDIN>) {
    /(\w+) can fly (\d+) km.s for (\d+) seconds, but then must rest for (\d+) seconds./ || next;
    $speed{$1} = $2;
    $run{$1} = $3;
    $rest{$1} = $4;
    $time{$1} = $3;
    $isRun{$1} = 1;
    $distance{$1} = 0;
}

foreach $i (1..2503) {
	foreach $deer (keys %speed) {
		if ($time{$deer} > 0) {
			$time{$deer}--
		} else {
			if ($isRun{$deer}) {
				$time{$deer} = $rest{$deer}-1;
				$isRun{$deer} = 0;
			} else {
				$time{$deer} = $run{$deer}-1;
				$isRun{$deer} = 1;
			}
		}
		$distance{$deer} += $speed{$deer} if $isRun{$deer};
		print "$i: $deer\t  $distance{$deer}\t $time{$deer}\t $isRun{$deer}\n" if $debug;
	}
}

$maxDist = max(values %distance);
print "Max distance: $maxDist\n";