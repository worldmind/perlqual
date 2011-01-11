#!/usr/bin/perl -w
# check that everying could be loaded

use strict;
use warnings;
use Test::More;

BEGIN {
  TODO: {
        local $TODO = "this is just for example; add every module from distribution, and remove 'todo' label";

        ## no critic
        ## do not critic about "stringify eval" in this block
        use_ok('Module::Name');
        use_ok('Module::Name::Extention1');
        use_ok('Module::Name::Extention2');
        use_ok('Module::Name::Extention3');
    }
}

done_testing;

