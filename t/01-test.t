#!/usr/bin/perl -w

use strict;
use Test::More tests => 8;
use Test::More::UTF8;
use Test::LectroTest::Compat;
use Test::Exception;
use Test::Timer;


use lib 'lib';

BEGIN {
    $_ = 'Perl::Test::Code::Quality::Template';
    use_ok( $_ );
}

my $tpl = new_ok( $_ );

isa_ok( $tpl, $_ );

is( $tpl->function1(), 1, 'function1 result' );


my $expected = { key1 => 'val1', key2 => 'val2' };
my $goted    = $tpl->function2();
is_deeply( $goted, $expected, 'function2 result' ) or diag explain $goted;


# test function many times with autogenerate integer arguments
my $prop_nonnegative = Property {
  ##[ x <- Int ]##
  cmp_ok( $tpl->function3( $x ), '>=', 0 );
}, name => "function3 output is non-negative" ;

holds( $prop_nonnegative );


throws_ok { $tpl->function4 } 'Exception::Something', 'simple error thrown';

time_ok( sub { $tpl->function5(); }, 1, 'function5 must be faster than 1 second');
