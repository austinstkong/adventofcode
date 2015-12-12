#!/usr/bin/perl
use JSON::Parse 'parse_json';

$debug = 0;

$line = <STDIN>;
chomp $line;

$json = parse_json($line);

print "Total: $sum\n";
