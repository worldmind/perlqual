#!/usr/bin/perl -w
# test code for tidy

use strict;
use warnings;
use Test::More;

eval 'use Test::PerlTidy';    ## no critic
plan skip_all => 'PerlTidy required' if $@;

run_tests(
  path       => 'lib',
  perltidyrc => 'data/perltidyrc',
  exclude    => [ qr{\.t$}, 'inc/', 'blib' ]
);

