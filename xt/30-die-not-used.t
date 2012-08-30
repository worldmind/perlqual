#!/usr/bin/perl -w
# test sources - do not use die and warn, use functions from Carp

use strict;
#use warnings;
use Test::More;

{
    ## no critic
    eval '
        use PPI;
        use File::Find::Rule       ();
        use File::Find::Rule::Perl ();
    ';
}
plan skip_all => 'PPI, File::Find::Rule and File::Find::Rule::Perl required' if $@;

my @files = File::Find::Rule->perl_file->in(qw/ lib t xt /);

plan tests => scalar @files;

sub die_or_warn {
  my ( undef, $node ) = @_;
  if ( $node->isa('PPI::Token::Word') and ( $node->content eq 'die' or $node->content eq 'warn' ) ) {
    return 1;
  }
  return 0;
}

foreach ( @files ) {
  my $ppi_doc = PPI::Document->new( $_ );
  my $nodes = $ppi_doc->find( \&die_or_warn );
  my $count = $nodes ? scalar @{$nodes} : 0;
  is( $count, 0, "$_ does not use die or warn" ) or diag explain $nodes;
}

