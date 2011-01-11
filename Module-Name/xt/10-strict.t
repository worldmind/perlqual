#!/usr/bin/perl -w
# test for syntax, strict and warnings

use strict;
use warnings;
use Test::More;

eval 'use Test::Strict';
plan skip_all => 'Test::Strict required' if $@;

$Test::Strict::TEST_WARNINGS = 1;

all_perl_files_ok();

