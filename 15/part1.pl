#!/usr/bin/perl

use List::Util qw/sum/;

$debug = 0;

while (<STDIN>) {
    /(\w+): (\w+) (-?\d+), (\w+) (-?\d+), (\w+) (-?\d+), (\w+) (-?\d+), (\w+) (-?\d+)/ || next;
    $weights{$2}{$1} = $3;
    $weights{$4}{$1} = $5;
    $weights{$6}{$1} = $7;
    $weights{$8}{$1} = $9;
    # $weights{$10}{$1} = $11;
    push @ingredients, $1;
}

@ingredients = sort @ingredients;

%tested = ();
$c = 0;
$maxScore = 0;
while ($c < 100000) {
	@formula = ();
	foreach $i (0..$#ingredients-1) {
		$formula[$i] = int(rand(101));
	}
	$total = sum(@formula);
	next if $total > 100;
	push @formula, 100-$total;
	$test = join ' ', @formula;
	next if exists $tested{$test};
	$tested{$test} = 1;

	print "$c: formula @formula\n" if $debug;
	$c++;
	$totalScore = 1;

	foreach $weight (sort keys %weights) {
		%score = ();
		$i = 0;
		foreach $ig (sort keys %{$weights{$weight}}) {
			print "$weight, $ig, $formula[$i] * $weights{$weight}{$ig} = ", $formula[$i]*$weights{$weight}{$ig}, "\n" if $debug;
			$score{$weight} += $formula[$i]*$weights{$weight}{$ig};
			$i++;
			print "score $weight: $score{$weight}\n" if $debug;
		}
		$subTotal = sum(values %score);
		$subTotal = 0 if $subTotal < 0;
		$totalScore *= $subTotal;
	}
	print "\tTotal score: $totalScore\n" if $debug;
	print "new max score: $totalScore, $c\n" if $totalScore > $maxScore;
	$maxScore = $totalScore if $totalScore > $maxScore;
}

print "Max score: $maxScore\n";