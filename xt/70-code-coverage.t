#!/usr/bin/perl -w
# test for tests coverage

use strict;
use warnings;
use Test::More;

eval 'use Test::Strict';    ## no critic
plan skip_all => 'Test::Strict is required' if $@;

# tweak this to change coverage acceptance level
my $coverage_threshold = 70;

all_cover_ok( 70, 't' );

