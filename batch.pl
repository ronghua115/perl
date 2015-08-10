#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

my @repos_shared = ( "NMS_Core_Libs",
                     "NMS_ICD_API",
                     "NMS_Lib",
                     "Stats_DDE_Shared"
                   );

my @repos = qw/Stats_BE DDE_BE Authentication Configuration_BE Update_Service/;

sub merge
{
    print `git checkout hotfix`;
    print `git pull`;
    print `git checkout chainsaw`;
    print `git pull`;
    print `git merge hotfix`;
}

sub printmake
{
    open my $cmd_fh, "make |";
    while (<$cmd_fh>)
    {
        print "$_";
    }
    close $cmd_fh;
}

my $deletedir = '~/lib64';
system("rm -rf $deletedir");
$deletedir = '~/include';
system("rm -rf $deletedir");

for my $i (0 .. $#repos_shared)
{
    chdir($repos_shared[$i]) or die"#!";
    merge;
    print `make cleanall`;
    print `make localincs`;
    printmake;
    print `make`;
    print `make fatlib`;
    print `make locallibs`;
    chdir('../');
}

for my $i (0 .. $#repos)
{
    chdir($repos[$i]) or die"#!";
    merge;
    print `make clean`;
    printmake;
    chdir('../');
}
