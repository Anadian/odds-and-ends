#!/usr/local/bin/perl
use strict;
use warnings;
my $stringliteral = qq{ls | grep -E -e '$ARGV[0]'};
print($stringliteral);
my @files = `$stringliteral`;
for(my $i = 0; $i <= $#files; $i++){
	print("Attempting to remove file $i\t");
	print(chomp($files[$i]),"\t$files[$i]\t");
	print(unlink($files[$i]),"\n");
}

