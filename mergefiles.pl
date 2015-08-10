#!/usr/bin/perl

use strict;
use warnings;
use Tie::File;

my ($file1,$file2,$fileout)  = @ARGV;

tie my @ry1,"Tie::File",$file1 or die "$file1:$!";
tie my @ry2,"Tie::File",$file2 or die "$file2:$!";
tie my @out,"Tie::File",$fileout or die "$fileout:$!";

@out=(@ry1,@ry2);

untie @out;
untie @ry2;
untie @ry1;
