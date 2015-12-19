#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);
use Data::Dumper qw(Dumper);

my $debug = 0;

my @rules = <STDIN>;
chomp @rules;

my $molecule = pop @rules;
pop @rules;

my (@froms, @tos);
foreach my $rule (@rules) {
    my ($from, $to) = $rule =~ /([A-Za-z][a-z]?) => (.*)/;
    push @froms, $from;
    push @tos, $to;
}

my @elements = split /([A-Z][a-z]?)/, $molecule;

#print Dumper \@froms;
#print Dumper \@tos;

my $i = -1;
my %newMolecules;
foreach my $element (@elements) {
    $i++;
    next if $element eq '';
    print "$element:\n" if $debug;
    foreach my $j (0..$#froms) {
        next if $element ne $froms[$j];
        my $newMolecule = join('',@elements[0 .. $i-1]).$tos[$j].join('',@elements[$i+1 .. $#elements]);
        print "\t$rules[$j] => $newMolecule\n" if $debug;
        $newMolecules{$newMolecule} = 1;
    }
}

my $totalDistinct = sum(values %newMolecules);

print "Number of new distinct molecules: $totalDistinct\n";
