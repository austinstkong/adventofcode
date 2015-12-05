#!/usr/bin/perl
use List::Util qw(min max);

$debug = 0;

while ($line = <>) {
    chomp $line;
    next if $line =~ /(ab)|(cd)|(pq)|(xy)/;
    next if $line !~ /[aeiou].*[aeiou].*[aeiou]/;
    next if $line !~ /([a-z])\1/;
    print "$line is nice\n" if $debug;
    $nice++;
}
print "Nice strings: $nice\n";
