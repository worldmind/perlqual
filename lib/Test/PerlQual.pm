package Test::PerlQual;

use 5.006;
use strict;
use warnings;
use Readonly;
use Test::More;

=head1 NAME

Test::PerlQual - The great new Test::PerlQual!

=head1 VERSION

Version 2.00

=cut

our $VERSION = '2.00';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Test::PerlQual;

    my $foo = Test::PerlQual->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 run_tests

=cut

sub run_tests {
    my ( $files, $config ) = @_;
    Readonly::Array my @files => @$files;
    my $perl_files = \@files;

    my $test_name = "Check code coverage";
    subtest $test_name => sub { check_code_coverage->( $test_name, $config->{coverage} ) };

    $test_name = "Check complexity metrics";
    subtest $test_name => sub { check_complexity_metrics( $test_name, $config->{metrics}, $perl_files ) };

    $test_name = "Check for best practice";
    subtest $test_name => sub { check_best_practice( $test_name, $config->{best_practice}, $perl_files ) };

    $test_name = "Check code style";
    subtest $test_name => sub { check_code_style( $test_name, $config->{code_style}, $perl_files ) };

    $test_name = "Check forgotten things";
    subtest $test_name => sub { check_forgotten( $test_name, $config->{forgotten}, $perl_files ) };

    $test_name = "Check distro";
    subtest $test_name => sub { check_distro( $test_name, $config->{distro} ) };

    $test_name = "Check POD";
    subtest $test_name => sub { check_pod( $test_name, $config->{pod}, $perl_files ) };

    done_testing();
}

sub check_code_coverage {
    my ( $test_name, $config ) = @_;

    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    eval 'use Test::Strict qw(all_cover_ok)';    ## no critic
                                                 # shut up warnings from Devel::Cover
    $ENV{DEVEL_COVER_OPTIONS} = '-silent,1';
    all_cover_ok( $config->{min_coverage}, $config->{unit_tests_dir} );
}

sub check_complexity_metrics {
    my ( $test_name, $config, $perl_files ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    eval 'use Perl::Metrics::Simple';            ## no critic
    complexity_ok( $perl_files, $config->{max_complexity}, $config->{max_lines_in_sub}, );
}

sub check_best_practice {
    my ( $test_name, $config, $perl_files ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    subtest $test_name => sub {
        eval 'use Test::Perl::Critic';           ## no critic
        Test::Perl::Critic->import( -profile => '.perlcriticrc' ) if -e '.perlcriticrc';
        critic_ok($_) for @$perl_files;
    };
    $test_name = "Check use warnings";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_use_warnings};
        eval 'use Test::Strict qw(warnings_ok)';    ## no critic
        my @files = @$perl_files;                   # make copy because Test::Strict modify args
        warnings_ok($_) for @files;
    };
    $test_name = "Check no die() used";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_no_die_used};
        eval 'use PPI';                             ## no critic
        no_die_ok($_) for @$perl_files;
    };
    $test_name = "Check file names portability";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_portability};
        eval "use Test::Portability::Files";        ## no critic
        options( all_tests => $config->{portability_hyper_strict} );
        run_tests();
    };
}

sub check_code_style {
    my ( $test_name, $config, $perl_files ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    subtest $test_name => sub {
        eval 'use Test::PerlTidy';                  ## no critic
        my %args;
        $args{perltidyrc} = '.perltidyrc' if -e '.perltidyrc';
        run_tests(%args);
    };
    $test_name = "Check EOL";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_eol};
        eval 'use Test::EOL qw(eol_unix_ok)';       ## no critic
        my @files = @$perl_files;                   # make copy because Test::EOL modify args
        eol_unix_ok( $_, $_, { trailing_whitespace => 1 } ) for @files;
    };
    $test_name = "Check no tabs";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_notabs};
        eval 'use Test::NoTabs qw(notabs_ok)';      ## no critic
        notabs_ok($_) for @$perl_files;
    };
}

sub check_forgotten {
    my ( $test_name, $config, $perl_files ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    $test_name = "Check no " . uc('fixme');
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_nofixme};
        eval 'use Test::Fixme';                     ## no critic
        run_tests( filename_match => qr/\.p[ml]$/ );
    };
    $test_name = "Check no breakpoints";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_nobreakpoints};
        eval "use Test::NoBreakpoints qw(no_breakpoints_ok)";    ## no critic
        no_breakpoints_ok($_) for @$perl_files;
    };
    $test_name = "Check that DELMEAFTER not expired";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_delmeafter};
        eval "use DateTime::Format::ISO8601";                    ## no critic
        eval "use Path::Tiny";                                   ## no critic
        delmeafter_ok($_) for @$perl_files;
    };
}

sub check_distro {
    my ( $test_name, $config ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    eval 'use Test::Kwalitee qw(kwalitee_ok)';                   ## no critic
    $ENV{AUTHOR_TESTING} = 1;
    kwalitee_ok();
}

sub check_pod {
    my ( $test_name, $config, $perl_files ) = @_;
    plan( skip_all => "$test_name test is disabled by config" ) unless $config->{enabled};
    subtest $test_name => sub {
        eval 'use Test::Pod qw(pod_file_ok)';                    ## no critic
        pod_file_ok($_) for @$perl_files;
    };
    $test_name = "Check POD coverage";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_coverage};
        eval 'use Test::Pod::Coverage qw(pod_coverage_ok)';      ## no critic
        pod_coverage_ok($_) for grep { /\.pm$/ } @$perl_files;
    };
    $test_name = "Check POD spelling";
    subtest $test_name => sub {
        plan( skip_all => "$test_name test is disabled by config" ) unless $config->{check_spelling};
        eval 'use Test::Spelling qw(pod_file_spelling_ok)';      ## no critic
        pod_file_spelling_ok($_) for @$perl_files;
    };
}

sub delmeafter_ok {
    my ($file_name)  = @_;
    my $file_content = path($file_name)->slurp_utf8;
    my $result       = 1;
    while ( $file_content =~ m{\#\s+DELMEAFTER\s+(\S+)\s}g ) {
        my $delmedate = DateTime::Format::ISO8601->parse_datetime($1);
        $result = 0 if $delmedate le DateTime->now();
    }
    ok( $result, "DELMEAFTER not expired $file_name" );
}

sub _is_die_or_warn {
    my ( undef, $node ) = @_;
    if ( $node->isa('PPI::Token::Word')
        and ( $node->content eq 'die' or $node->content eq 'warn' ) )
    {
        return 1;
    }
    return 0;
}

sub no_die_ok {
    my ($file_name) = @_;
    my $ppi_doc     = PPI::Document->new($file_name);
    my $nodes       = $ppi_doc->find( \&_is_die_or_warn );
    my $count = $nodes ? scalar @{$nodes} : 0;
    is( $count, 0, "$file_name does not use die or warn" ) or diag explain $nodes;
}

sub complexity_ok {
    my ( $perl_files, $max_complexity, $max_lines_in_sub ) = @_;
    my $analzyer = Perl::Metrics::Simple->new;
    my @subs;

    for (@$perl_files) {
        my $analysis = $analzyer->analyze_files($_);
        push( @subs, $_ ) for ( @{ $analysis->subs } );
    }

    plan tests => ( scalar @subs ) * 2;

    foreach my $sub (@subs) {
        my $name       = $sub->{name};
        my $complexity = $sub->{mccabe_complexity};
        my $lines      = $sub->{lines};

        ok( $complexity <= $max_complexity, "Cyclomatic complexity $complexity for sub $name is < $max_complexity" )
          or diag $sub->{path};
        ok( $lines <= $max_lines_in_sub, "Lines count $lines for sub $name < $max_lines_in_sub" ) or diag $sub->{path};
    }
}

=head1 AUTHOR

Alexey Shrub, C<< <ashrub at yandex.ru> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-perlqual at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-PerlQual>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::PerlQual


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-PerlQual>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-PerlQual>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-PerlQual>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-PerlQual/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 Alexey Shrub.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1;    # End of Test::PerlQual
