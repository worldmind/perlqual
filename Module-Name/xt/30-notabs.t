#!/usr/bin/perl -w
# test for presence of tabs in sources

use strict;
use warnings;
use Test::More;

eval 'use Test::NoTabs';
plan skip_all => 'Test::NoTabs required' if $@;

all_perl_files_ok();

