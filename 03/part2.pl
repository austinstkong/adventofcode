#!/usr/bin/perl

 $debug = 0;

$line=<STDIN>;
chomp $line;
@motions = split //, $line;

# Santa
$x = 0;
$y = 0;
# Robo-santa
$xR = 0;
$yR = 0;

$visited{$x}{$y}++;
$robotTurn = 0;
foreach $dir (@motions) {
	if ($robotTurn) {
		$robotTurn = 0;
		$xR++ if $dir eq '>';
		$xR-- if $dir eq '<';
		$yR++ if $dir eq '^';
		$yR-- if $dir eq 'v';
	    $visited{$xR}{$yR}++;
	    print "Robo-santa is going $dir  visiting ($xR,$yR)\n" if $debug;
	} else {
		$robotTurn = 1;
		$x++ if $dir eq '>';
		$x-- if $dir eq '<';
		$y++ if $dir eq '^';
		$y-- if $dir eq 'v';
	    $visited{$x}{$y}++;
	    print "Santa is going $dir  visiting ($x,$y)\n" if $debug;
	}
	
}
foreach $x (sort keys %visited) {
	foreach $y (sort keys %{$visited{$x}}) {
		print "Visited ($x,$y)\n" if $debug;
		$uniquePlaces++;
	}	
}
print "Visited $uniquePlaces unique places in total\n";
