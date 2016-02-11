use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok('Test::PerlQual') || print "Bail out!\n";
}

diag("Testing Test::PerlQual $Test::PerlQual::VERSION, Perl $], $^X");
