#!/usr/bin/perl
use List::Util qw(min max);

while ($line = <>) {
    chomp $line;
    ($l, $w, $h) = split /x/, $line;
    $area = 2*$l*$w + 2*$w*$h + 2*$h*$l;
    $totalArea += $area;
    $smallestSideArea = min($l*$w, $w*$h, $h*$l);
    #print "$l x $w x $h = $area + $smallestSideArea\n";
    $totalArea += $smallestSideArea;
    $volume = $l*$w*$h;
    $totalRibbon += $volume;
    $ribbon = 2*$l+2*$w+2*$h - max(2*$l,2*$w,2*$h);
    $totalRibbon += $ribbon;
    #print "vol $volume, ribbon $ribbon\n"
}
print "Total Area: $totalArea\n";
print "Total Ribbon: $totalRibbon\n";
