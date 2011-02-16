#!/usr/bin/perl -w
# test that files do not contain soft breakpoints

use strict;
use warnings;

use Test::More;

eval "use Test::NoBreakpoints 0.10"; ## no critic
plan skip_all => "Test::NoBreakpoints 0.10 required for testing" if $@;

all_files_no_breakpoints_ok();

done_testing();
