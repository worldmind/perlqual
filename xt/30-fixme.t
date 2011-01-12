#!/usr/bin/perl -w
# test code for FIXME/BUG/TODO/XXX/NOTE labels

use strict;
use warnings;
use Test::More;

eval 'use Test::Fixme';    ## no critic
plan skip_all => 'Test::Fixme required' if $@;

# test files in t/ and xt/ could have FIXME and other words, so we testing only lib/
run_tests( match => qr/FIXME|BUG\b|XXX/, where => [qw/ lib /] );

