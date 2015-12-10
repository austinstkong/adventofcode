#!/usr/bin/perl

$debug = 0;

$line = <STDIN>;
chomp $line;
print "0:\n$line\n" if $debug;
$i = 0;
while ($i < 50) {
	$i++;
	@chars = split(//, $line);
	$lastChar = $chars[0];
	$lastCharCount = 0;
	$line = '';
	foreach $char (@chars) {
		if ($char eq $lastChar) {
			$lastCharCount++;
		} else {
			$line .= $lastCharCount . $lastChar;
			$lastCharCount = 1;
			$lastChar = $char;
		}
	}
	$line .= $lastCharCount . $lastChar;
	print "$i:\n$line\n" if $debug;
}

print "Length: ", length($line), "\n";