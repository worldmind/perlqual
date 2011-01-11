use inc::Module::Install;

my $main_module = 'lib/Perl/Test/Code/Quality/Template.pm';

name 'Perl-Test-Code-Quality-Template';
author q{worldmind <world.mind@yahoo.com>};
license 'perl';
resources repository => 'git://github.com/worldmind/perl-test-code-quality-template.git';
all_from $main_module;

# just for example
requires(
    'Moose'                => 0,
    'namespace::autoclean' => 0,
);

# just for example
build_requires(
    'Test::More' => '0.88',
    'Test::More' => '0.88',
    'Test::More' => '0.88',
    'Test::More' => '0.88',
);

# just for example
test_requires(
    'Test::More' => '0.88',
    'Test::More' => '0.88',
    'Test::More' => '0.88',
    'Test::More' => '0.88',
);

author_requires(
    'File::Find::Rule'       => 0,
    'File::Find::Rule::Perl' => 0,
    'Perl::Metrics::Simple'  => 0,
    'Pod::Coverage'          => '0.18',
    'Test::EOL'              => '0.3',
    'Test::Fixme'            => 0,
    'Test::More'             => '0.88',
    'Test::NoTabs'           => 0,
    'Test::Perl::Critic'     => 0,
    'Test::Pod'              => '1.22',
    'Test::Pod::Coverage'    => '1.08',
    'Test::Spelling'         => '0.11',
    'Test::Strict'           => 0,
);

if ($Module::Install::AUTHOR) {
    system("pod2text $main_module > README") and die $!;
}

auto_install;

WriteAll;

