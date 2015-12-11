#!/usr/bin/perl

$debug = 0;

$line = <STDIN>;
chomp $line;
print "inital: $line\n";
my $i = 0;
while (1) {
	$i++;
	$line++;
	printf("%6d: %s\n", $i, $line) if $debug;
	next if $line =~ /[iol]/;
	print "no [iol]\n" if $debug;
	next if $line !~ /([a-z])\1.*([a-z])\2/;
	print "got 2 doubles\n" if $debug;
	next if !straight($line);
	print "got straights\n" if $debug;
	last;
}

print "final : $line\n";

sub straight {
	($line) = @_;
	@chars = split //, $line;
	foreach my $i (0..$#chars-2) {
		$char = $chars[$i];
		next if $char =~ /[yz]/; #Generates increment yza or zab
		$str = ($char++).($char++).($char++);
		print "$str\n" if $debug;
		return 1 if $line =~ /$str/;
	}
	return 0;
}