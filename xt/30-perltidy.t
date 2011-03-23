#!/usr/bin/perl -w
# test code for tidy

use strict;
use warnings;

use Test::PerlTidy;

run_tests(
  path       => 'lib',
  perltidyrc => 'data/perltidyrc',
  exclude    => [ qr{\.t$}, 'inc/', 'blib' ]
);

