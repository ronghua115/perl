#!/usr/bin/perl
use strict;
use warnings;

my $convertdata_file = $ARGV[0];
my $result_file = $ARGV[1];

open my $fh, '<', $convertdata_file or die $!;
open my $rfh, '>', $result_file or die $!;

while (my $line = <$fh>)
{
    my $newline = $line;
    $newline =~ s/^\s+|\s+$//g;
    $newline =~ s/\r|\n//g;
    print $rfh $newline;
}

close $rfh;
close $fh;
