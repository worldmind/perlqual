#!/usr/bin/perl -w
# check that everying could be loaded

use strict;
use warnings;
use Test::More tests => 1;

# add every module from distribution
BEGIN {
    use_ok('Module::Name');
    use_ok('Module::Name::Extention1');
    use_ok('Module::Name::Extention2');
    use_ok('Module::Name::Extention3');
}

