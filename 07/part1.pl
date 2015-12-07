#!/usr/bin/perl

$debug = 0;

our %wires;
our %data;
while ($line = <STDIN>) {
	chomp $line;
	($lhs, $rhs) = split ' -> ', $line;
	($a, $b, $c) = split / /, $lhs;
	$wires{$rhs} = $lhs;
}

foreach $wire (sort keys %wires) {
    print "$wire = $wires{$wire}\n" if $debug;
}

foreach $wire (sort keys %data) {
    print "$wire: ",unpack('S', pack('S', $data{$wire})),"\n" if $debug;
}

evalWire('a');
print "Wire 'a' has: ", unpack('S', pack('S', $data{'a'})),"\n";

sub evalWire {
	my ($wire) = @_;
	my $op = $wires{$wire};
	my ($a, $b, $c) = split / /, $op;
	print "Eval $wire = $wires{$wire}\n" if $debug;
	if ($op =~ /AND/) {
		$data{$wire} = getWire($a) & getWire($c);
		print "$a & $c" if $debug == 2;
	} elsif ($op =~ /OR/) {
		$data{$wire} = getWire($a) | getWire($c);
		print "$a | $c" if $debug == 2;
	} elsif ($op =~ /LSHIFT/) {
		$data{$wire} = getWire($a) << $c;
		print "$a << $c" if $debug == 2;
	} elsif ($op =~ /RSHIFT/) {
		$data{$wire} = getWire($a) >> $c;
		print "$a >> $c" if $debug == 2;
	} elsif ($op =~ /NOT/) {
		$data{$wire} = ~getWire($b);
		print "~ $b" if $debug == 2;
	} else {
		$data{$wire} = getWire($a);
		print "= $a" if $debug == 2;
	}
	print " = ", unpack('S', pack('S', $data{$wire})),"\n" if $debug == 2;
}

sub getWire {
	my ($wire) = @_;
	if ($wire =~ /^\d+$/) {
		print "assign number\n" if $debug;
		return $wire;
	} elsif (!exists $data{$wire}) {
		evalWire($wire);
	}
	return $data{$wire};
}