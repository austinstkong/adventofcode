#!/usr/bin/perl

$debug = 0;

while ($line = <STDIN>) {
	chomp $line;
	$reduced = $line;
	$reduced =~ s/^"|"$//g;
	$reduced =~ s/\\\\/./g;
	$reduced =~ s/\\"/./g;
	$reduced =~ s/\\x.././gi;
	$totalLen += length($line);
	$totalRed += length($reduced);
	print "|$line|$reduced|",length($line)," ",length($reduced),"\n" if $debug;
}

$diff = $totalLen - $totalRed;
print "Total Chars: $totalLen\n";
print "Actual Chars: $totalRed\n";
print "Difference: $diff\n";