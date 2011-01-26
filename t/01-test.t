#!/usr/bin/perl -w

use strict;
use Test::More tests => 6;
use Test::More::UTF8;
use Test::LectroTest::Compat;
use lib 'lib';

BEGIN {
    $_ = 'Perl::Test::Code::Quality::Template';
    use_ok( $_ );
}

my $tpl = new_ok( $_ );

isa_ok( $tpl, $_ );

is( $tpl->function1(), 1, 'function1 result' );

is( $tpl->function2(), 2, 'function2 result' );

# test function many times with autogenerate integer arguments
my $prop_nonnegative = Property {
  ##[ x <- Int ]##
  cmp_ok( $tpl->function3( $x ), '>=', 0 );
}, name => "function3 output is non-negative" ;

holds( $prop_nonnegative );
