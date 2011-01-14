#!/usr/bin/perl -w

use strict;
use Test::More tests => 5;
use Test::More::UTF8;
use lib 'lib';

BEGIN {
    $_ = 'Perl::Test::Code::Quality::Template';
    use_ok( $_ );
}

my $tpl = new_ok( $_ );

isa_ok( $tpl, $_ );

is( $tpl->function1(), 1, 'function1 result' );

is( $tpl->function2(), 2, 'function2 result' );
