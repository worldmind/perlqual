#!/usr/bin/perl -w
# test POD for spelling

use strict;
use warnings;
use Test::More;

eval 'use Test::Spelling 0.11';
plan skip_all => 'Test::Spelling (>=0.11) is required' if $@;

set_spell_cmd('aspell list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok();

__DATA__
BLOBs
FS
IRC
fs
resultset
semifor
