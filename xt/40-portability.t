#!/usr/bin/perl -w
# check file names portability
# see http://search.cpan.org/perldoc?perlport#Files_and_Filesystems

use strict;
use warnings;
use Test::More;

eval "use Test::Portability::Files"; ## no critic
plan skip_all => "Test::Portability::Files required for testing filenames portability" if $@;

#options(all_tests => 1);  # to be hyper-strict

run_tests();
