#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper qw(Dumper);

my $debug = 0;

my @lights;
my $size = -1;
while (<STDIN>) {
	chomp;
    my @row = split //;
    $lights[++$size] = \@row;
}

$lights[0][0] = "#";
$lights[0][$size] = "#";
$lights[$size][0] = "#";
$lights[$size][$size] = "#";

print "Initial state:\n" if $debug;
printLights(@lights) if $debug;

foreach my $i (1..100) {
	my @toggle;
	foreach my $x (0..$size) {
		foreach my $y (0..$size) {
			my $neighbours = 0;
			$neighbours++ if ($x > 0 && $lights[$x-1][$y] eq "#");
			$neighbours++ if ($x < $size && $lights[$x+1][$y] eq "#");
			$neighbours++ if ($y > 0 && $lights[$x][$y-1] eq "#");
			$neighbours++ if ($y < $size && $lights[$x][$y+1] eq "#");
			$neighbours++ if ($x > 0 && $y > 0 && $lights[$x-1][$y-1] eq "#");
			$neighbours++ if ($x > 0 && $y < $size && $lights[$x-1][$y+1] eq "#");
			$neighbours++ if ($x < $size && $y > 0 && $lights[$x+1][$y-1] eq "#");
			$neighbours++ if ($x < $size && $y < $size && $lights[$x+1][$y+1] eq "#");
			print "$neighbours " if $debug;
			if ($lights[$x][$y] eq "#") {
				next if (($neighbours == 3) || $neighbours == 2);
				$toggle[$x][$y] = 1;
			} else {
				next if $neighbours != 3;
				$toggle[$x][$y] = 1;
			}
		} 
		print "\n" if $debug;
	}
	foreach my $x (0..$size) {
		foreach my $y (0..$size) {
			if ($toggle[$x][$y]) {
				if ($lights[$x][$y] eq "#") {
					$lights[$x][$y] = ".";
				} else {
					$lights[$x][$y] = "#";
				}
			}
		} 
	}
	$lights[0][0] = "#";
	$lights[0][$size] = "#";
	$lights[$size][0] = "#";
	$lights[$size][$size] = "#";
	print "\nAfter $i step:\n" if $debug;
	printLights(@lights) if $debug;
}

my $on = 0;
foreach my $x (0..$size) {
	foreach my $y (0..$size) {
		$on++ if $lights[$x][$y] eq "#";
	}
} 
print "Number of lights on: $on\n";



sub printLights {
	my @lights = @_;
	# print Dumper \@lights;
	foreach my $row (@lights) {
		print "@$row\n"
	} 
	return;
}