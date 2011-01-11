#!/usr/bin/perl -w
# test POD for spelling

use strict;
use warnings;
use Test::More;

eval 'use Test::Spelling 0.11';    ## no critic
plan skip_all => 'Test::Spelling (>=0.11) is required' if $@;

# set_spell_cmd('aspell -l en list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok(qw/ lib t xt /);

__DATA__
AnnoCPAN
BLOBs
CPAN
fs
FS
IRC
resultset
RT
semifor
worldmind
