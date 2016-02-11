use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Test::PerlQual',
    AUTHOR             => q{Alexey Shrub <ashrub@yandex.ru>},
    VERSION_FROM       => 'lib/Test/PerlQual.pm',
    ABSTRACT_FROM      => 'lib/Test/PerlQual.pm',
    LICENSE            => 'artistic_2',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.006,
    EXE_FILES          => ['bin/perlqual'],
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'File::Find::Rule'         => undef,
        'File::Find::Rule::Perl'   => undef,
        'File::HomeDir'            => undef,
        'File::Spec'               => undef,
        'Path::Tiny'               => undef,
        'Perl::Metrics::Simple'    => undef,
        'Pod::Coverage'            => undef,
        'Test::EOL'                => undef,
        'Test::Fixme'              => undef,
        'Test::Kwalitee'           => undef,
        'Test::More'               => undef,
        'Test::NoBreakpoints'      => undef,
        'Test::NoTabs'             => undef,
        'Test::Perl::Critic'       => undef,
        'Test::PerlTidy'           => undef,
        'Test::Pod'                => undef,
        'Test::Pod::Coverage'      => undef,
        'Test::Portability::Files' => undef,
        'Test::Spelling'           => undef,
        'Test::Strict'             => undef,
        'YAML'                     => undef,
        'Readonly'                 => undef,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Test-PerlQual-*' },
);
