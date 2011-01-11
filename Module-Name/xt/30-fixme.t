#!/usr/bin/perl -w
# test code for FIXME/BUG/TODO/XXX/NOTE labels

use strict;
use warnings;
use Test::More;

eval 'use Test::Fixme';
plan skip_all => 'Test::Fixme required' if $@;

run_tests( match => qr/TODO|FIXME|BUG|XXX|NOTE/ );

