use strict;
use warnings;

use Test::More;

use Perl::Metrics::Simple;
use File::Find::Rule       ();
use File::Find::Rule::Perl ();


my $max_complexity = 20;
my $max_lines      = 50;
my @files = File::Find::Rule->perl_file->in('./lib');
my $analzyer = Perl::Metrics::Simple->new;
my @subs;

foreach (@files) {
	my $analysis = $analzyer->analyze_files($_);
	push @subs, $_ foreach (@{$analysis->subs});
}

plan tests => (scalar @subs)*2;

foreach my $sub ( @subs ) {
	my $name = $sub->{name}.' in '.$sub->{path};
	cmp_ok( $sub->{mccabe_complexity}, '<', $max_complexity, 'Cyclomatic comlexity for '.$name );
	cmp_ok( $sub->{lines}, '<', $max_lines, 'Lines count for '.$name );
}
