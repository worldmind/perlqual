#!/usr/bin/perl -w
# test sources for POD syntax

use strict;
use warnings;
use Test::More;

eval 'use Test::Pod 1.22';
plan skip_all => 'Test::Pod (>=1.22) is required' if $@;

all_pod_files_ok();

