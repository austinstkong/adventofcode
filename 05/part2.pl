#!/usr/bin/perl

$debug = 0;

while ($line = <>) {
    chomp $line;
    next if $line !~ /([a-z])[a-z]\1/;
    next if $line !~ /([a-z][a-z]).*\1/;
    print "$line is nice\n" if $debug;
    $nice++;
}
print "Nice strings: $nice\n";
