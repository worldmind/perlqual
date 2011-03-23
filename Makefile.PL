#!/usr/bin/env perl
use inc::Module::Install;
## use Module::Install::Catalyst;
use Module::Install::AuthorTests;
use Module::Install::AuthorRequires;

my $main_module = 'lib/Perl/Test/Code/Quality/Template.pm';

name 'Perl-Test-Code-Quality-Template';
author q{worldmind <world.mind@yahoo.com>};
license 'perl';
resources repository => 'git://github.com/worldmind/perl-test-code-quality-template.git';
all_from $main_module;

# just for example
requires( 'Config::General' => 0, );

# just for example
build_requires(
    'Test::More' => '0.88',
);

# just for example
test_requires(
    'Test::More'               => '0.88',
    'Test::LectroTest::Compat' => 0,
);

author_requires(
    'File::Find::Rule'         => '0.32',
    'File::Find::Rule::Perl'   => '1.09',
    'Perl::Metrics::Simple'    => '0.15',
    'Pod::Coverage'            => '0.21',
    'Test::Exception'          => '0.29',
    'Test::Kwalitee'           => '1.01',
    'Test::MockTime'           => '0.09',
    'Test::More'               => '0.96',
    'Test::More::UTF8'         => '0.02',
    'Test::NoBreakpoints'      => '0.13',
    'Test::Pod::Coverage'      => '1.08',
    'Test::Timer'              => '0.05',
    'Test::Weaken'             => '3.006000',
    'Test::EOL'                => '0.3',
    'Test::Fixme'              => 0,
    'Test::NoTabs'             => 0,
    'Test::Perl::Critic'       => 0,
    'Test::Pod'                => '1.22',
    'Test::Spelling'           => '0.11',
    'Test::Strict'             => 0,
    'Test::PerlTidy'           => 0,
);

## catalyst;
## install_script glob('script/*.pl');

auto_install;
WriteAll;

