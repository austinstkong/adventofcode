#!/usr/bin/perl

use List::Util qw/shuffle sum min/;

$debug = 0;

while ($line = <STDIN>) {
	chomp $line;
    @list= split / /, $line;
    print join("|", @list), "!!",$#list,"\n" if $debug;
    push @lens, $#list;
}

$min = min(@lens);
print "Minimum number of containers: $min\n";
$i = 0;
foreach $len (@lens) {
	$i++ if $len == $min;
}

print "Total combinations $i\n";

