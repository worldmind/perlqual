package Perl::Test::Code::Quality::Template;

use warnings;
use strict;

=head1 NAME

Perl::Test::Code::Quality::Template - The great new Perl::Test::Code::Quality::Template!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Perl::Test::Code::Quality::Template;

    my $foo = Perl::Test::Code::Quality::Template->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    return bless {}, $class;
}

=head2 function1

=cut

sub function1 {
    return 1;
}

=head2 function2

=cut

sub function2 {
    return { key1 => 'val1', key2 => 'val2' };
}

=head2 function3

=cut

sub function3 {
    my ( $self, $arg ) = @_;
    return $arg*$arg;
}


=head2 function4

=cut

sub function4 {
    die bless { code => 666, message => 'Something wrong', trace => 'stack trace here' }, 'Exception::Something';
}

=head2 function5

=cut

sub function5 {
    sleep 1;
}

=head2 C<get_date>

  Returns date in needed format

=cut
sub get_date {
  my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) = localtime(time);
  $mon++;
  $year += 1900;
  return sprintf( '%d-%02d-%02d %02d:%02d:%02d', $year, $mon, $mday, $hour, $min, $sec );
}

=head1 AUTHOR

worldmind, C<< <world.mind at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-module-name at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Perl-Test-Code-Quality-Template>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Perl::Test::Code::Quality::Template


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Perl-Test-Code-Quality-Template>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Perl-Test-Code-Quality-Template>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Perl-Test-Code-Quality-Template>

=item * Search CPAN

L<http://search.cpan.org/dist/Perl-Test-Code-Quality-Template/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 worldmind.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Perl::Test::Code::Quality::Template
