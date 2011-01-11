use strict;
use warnings;

use Test::More;
use Test::Strict;
use File::Find::Rule       ();
use File::Find::Rule::Perl ();


my @files = File::Find::Rule->perl_file->in('./lib');

plan tests => scalar @files;

foreach (@files) {
	warnings_ok( $_ , 'warnings in '.$_ );
}


