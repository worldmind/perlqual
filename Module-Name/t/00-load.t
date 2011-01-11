use Test::More tests => 1;

BEGIN {
    use_ok( 'Module::Name' ) || print "Bail out!
";
}

diag( "Testing Module::Name $Module::Name::VERSION, Perl $], $^X" );
