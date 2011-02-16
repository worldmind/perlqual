#!/usr/bin/perl -w

use strict;
use Test::More tests => 11;
use Test::More::UTF8;
use Test::LectroTest::Compat;
use Test::Exception;
use Test::Timer;
use Test::MockTime qw( :all );
use Test::Weaken qw(leaks);


use lib 'lib';

BEGIN {
    $_ = 'Perl::Test::Code::Quality::Template';
    # check compile
    use_ok( $_ );
}


# check that object is created successfully
my $tpl = new_ok( $_ );
isa_ok( $tpl, $_ );


is( $tpl->function1(), 1, 'function1 must return 1' );


my $expected = { key1 => 'val1', key2 => 'val2' };
my $goted    = $tpl->function2();
is_deeply( $goted, $expected, 'function2 must return hash, see $expected variable' ) or diag explain $goted;


# test function many times with autogenerate integer arguments, see Test::LectroTest
my $prop_nonnegative = Property {
  ##[ x <- Int ]##
  cmp_ok( $tpl->function3( $x ), '>=', 0 );
}, name => "function3 output must be non-negative" ;

holds( $prop_nonnegative );


throws_ok { $tpl->function4 } 'Exception::Something', 'function4 must throw exception';


time_ok( sub { $tpl->function5 }, 1, 'function5 must be faster than 1 second');


# Get date in needed format (It's just example, for formatting date use Date::Format)
set_fixed_time( 1295854591 );
is( $tpl->get_date(), '2011-01-24 10:36:31', 'Date must be in needed format' );
restore_time();


# Search memory leakes
my $good_test = sub {
    my $obj1 = $tpl->function5;
    [ $obj1 ];
};

ok( (not leaks( $good_test)), 'function5 must be not leaky' );

# only for example
ok( leaks( sub {$tpl->function6} ), 'function6 must be leaky' );
