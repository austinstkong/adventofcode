#!/usr/bin/perl

$line=<STDIN>;
@chars = split //, $line;
print "totalChars:$#chars\n";
foreach $ch (@chars) {
    $charCount++;
    $counter++ if $ch eq '(';
    $counter-- if $ch eq ')';
    print "-1:$charCount\n" if $counter == -1;
}
print "finalFlor:$counter\n";
