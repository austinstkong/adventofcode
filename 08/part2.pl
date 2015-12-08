#!/usr/bin/perl

$debug = 0;

while ($line = <STDIN>) {
	chomp $line;
	$encoded = $line;
	$encoded =~ s/\\/\\\\/g;
	$encoded =~ s/"/\\"/g;
	$encoded = '"'.$encoded.'"';
	$totalLen += length($line);
	$totelEnc += length($encoded);
	print "|$line|$encoded|",length($line)," ",length($encoded),"\n" if $debug;
}

$diff = $totelEnc - $totalLen;
print "Total Chars: $totalLen\n";
print "Encoded Chars: $totelEnc\n";
print "Difference: $diff\n";