#!/usr/bin/perl

 $debug = 0;

$line=<STDIN>;
chomp $line;
@motions = split //, $line;

$x = 0;
$y = 0;
$visited{$x}{$y}++;
foreach $dir (@motions) {
	$x++ if $dir eq '>';
	$x-- if $dir eq '<';
	$y++ if $dir eq '^';
	$y-- if $dir eq 'v';
    $visited{$x}{$y}++;
    print "going $dir  visiting ($x,$y)\n" if $debug;
}
foreach $x (sort keys %visited) {
	foreach $y (sort keys %{$visited{$x}}) {
		print "Visited ($x,$y)\n" if $debug;
		$uniquePlaces++;
	}	
}
print "Visited $uniquePlaces unique places in total\n";
