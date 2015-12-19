#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);
use Data::Dumper qw(Dumper);

my $debug = 0;

my @rules = <STDIN>;
chomp @rules;

my $targetMolecule = pop @rules;
pop @rules;

my (@froms, @tos, @elementsList);
foreach my $rule (@rules) {
    my ($from, $to) = $rule =~ /([A-Za-z][a-z]?) => (.*)/;
    push @froms, $from;
    push @tos, $to;
}

push @elementsList, 'e';

print length($targetMolecule),"\n";
my $tmp = $targetMolecule;
$tmp =~ s/[a-z]//g;
print length($tmp),"\n";
my $targetLen = length($tmp);
#print Dumper \@froms;
#print Dumper \@tos;
#print Dumper \@elementsList;

my %newMolecules;
my $steps = 0;
my $made = 0;
while ($steps < 39) {
    $steps++;
    my @newElements;
    foreach my $anElement (@elementsList) {
        my @elements = split /([A-Z][a-z]?)/, $anElement;
        my @new;
        ($made, @new) = replace($steps, @elements);
        last if $made;
        push @newElements, @new;
    }
    last if $made;
    @elementsList = ();
    @elementsList = @newElements;
}

print "Made in $steps\n" if $made;
my $totalDistinct = sum(values %newMolecules);

print "Number of new distinct molecules: $totalDistinct\n";


sub replace {
    my ($steps, @elements) = @_;
    my $i = -1;
    my $made = 0;
    my @new;
    foreach my $element (@elements) {
        $i++;
        next if $element eq '';
        print "$element:\n" if $debug;
        foreach my $j (0..$#froms) {
            next if $element ne $froms[$j];
            my $newMolecule = join('',@elements[0 .. $i-1]).$tos[$j].join('',@elements[$i+1 .. $#elements]);
            print "\t ", join('', @elements), " == $froms[$j] => $tos[$j] == $newMolecule\n" if $debug;
            next if exists $newMolecules{$newMolecule};
            #print "Made in $steps\n" if $newMolecule eq $targetMolecule;
            $made = 1 if $newMolecule eq $targetMolecule;
            my $tmp = $newMolecule;
            $tmp =~ s/[a-z]//g;
            next if $targetLen < length($tmp);
            $newMolecules{$newMolecule} = 1;
            push @new, $newMolecule;
        }
    }
    return ($made, @new);
}
