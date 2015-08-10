#!/usr/bin/perl

use strict;
use warnings;

open my $fhin, '<', $ARGV[0] or die $!;
open my $fhout, '>', $ARGV[1] or die $!;

while (my $line = <$fhin>)
{
    $line =~ s/.//;
    print $fhout $line;
}

close $fhin;
close $fhout;
