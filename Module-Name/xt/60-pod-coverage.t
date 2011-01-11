#!/usr/bin/perl -w
# test sources for pod coverage

use strict;
use warnings;
use Test::More;

eval '
    use Test::Pod::Coverage 1.08;
    use Pod::Coverage 0.18;
';
plan skip_all => 'Test::Pod::Coverage (>=1.08) and Pod::Coverage (>=0.18) are required' if $@;

all_pod_coverage_ok();

