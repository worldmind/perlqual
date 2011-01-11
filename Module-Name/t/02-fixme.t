use strict;
use warnings;

use Test::Fixme;
run_tests(
	where    => ['lib'],        # where to find files to check
	match    => qr/FIXME/,   # what to check for
);
