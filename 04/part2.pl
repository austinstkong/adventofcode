#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex);

$debug = 0;

$prefix=<STDIN>;
chomp $prefix;

$key= 0;
while (1) {
    $string = sprintf("%s%d",$prefix,$key);
    $digest = md5_hex($string);
    print "md5($string) = $digest\n" if $debug;
    last if $digest =~ /^000000/;
    $key++;
}
print "key is $key\n";
