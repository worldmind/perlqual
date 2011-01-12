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
as_resultset
Aux
BLOBs
CPAN
cub
cubuanic
DateTime
DBIC
deflate_datetime
deserialize
fs
FS
inflate_datetime
IRC
Kostyuk
objectid
Oleg
resultset
RT
schema
TT
unix
worldmind
