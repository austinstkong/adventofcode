#!/usr/bin/perl

$debug = 0;

$line = <STDIN>;
chomp $line;

@numbers = $line =~ /-?\d+/g;

$sum = 0;
foreach $num (@numbers) {
    $sum += $num;
}

print "Total: $sum\n";
