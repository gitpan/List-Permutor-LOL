package List::Permutor::LOL;
use strict;
use warnings;
use vars qw($VERSION);

$VERSION = '0.01';

use List::Permutor;
use Clone qw(clone);

sub new {
  my ($class,$lol) = @_;
  my @lolp; # list of List::Permutor
  for (@$lol) {
    if(ref($_)) {
      push @lolp, List::Permutor->new(@$_);
    } else {
      push @lolp, List::Permutor->new($_);
    }
  }
  my $self = { lol => $lol, lolp => \@lolp };
  bless $self,$class;
  $self->reset();
}

sub next { _get_next($_[0],'next') }
sub peek { _get_next($_[0],'peek') }

sub _get_next {
  my $self = shift;
  my $method = shift;
  my $reset = 0;
  my $nlov  = clone($self->{lov});
  for my $i (0..@{$self->{lolp}}-1) {
    if(my @set = $self->{lolp}->[$i]->$method) {
      $nlov->[$i] = \@set;
      last;
    } else {
      $reset++;
      if($method eq 'next') {
	$self->{lolp}->[$i]->reset;
	@set = $self->{lolp}->[$i]->$method;
	$nlov->[$i] = \@set;
      } else {
	# *cough* This is the i-th value in $self->{lol}
	my $loli = $self->{lol}->[$i];
	$nlov->[$i] = ref($loli)? $loli : [ $loli ] ;
      }
    }
  }

  # Every permutor is reset, that means we reach the very end of the
  # whole big list, so we return undef which means "there is no next
  # permutation"
  return if($reset == @{$self->{lolp}});

  $self->{lov} = $nlov if($method eq 'next');

  # Build a new lov corresponding to the scalar position
  # in $self->{lol}.
  for my $i (0..@{$self->{lol}}-1) {
    unless(ref($self->{lol}->[$i])) {
      $nlov->[$i] = $nlov->[$i]->[0];
    }
  }
  return $nlov;
}

sub reset {
  my $self = shift;
  $_->reset for @{$self->{lolp}};
  my @lov;
  my @set = $self->{lolp}->[0]->peek;
  push @lov,\@set;
  for my $i (1..@{$self->{lolp}}-1) {
    my @set = $self->{lolp}->[$i]->next;
    push @lov,\@set;
  }
  $self->{lov} = \@lov;
  return $self;
}

1;

__END__

=head1 NAME

List::Permutor::LOL - Permute lists inside a list

=head1 SYNOPSIS

  my $list = [[qw(a b)],[qw(c d)]];
  my $p = List::Permutor::LOL->new($list);

  while(my $r = $p->next) {
    # ...
  }

=head1 DESCRIPTION

This module accepts an arrayref of arrayref, and behaves as a global
permutor like L<List::Permutor>. The top-level list ordering is
however, unchanged. For example, This lol has 4 permutations:

  [[qw(a b)],[qw(c d)]]

And that would be:

  [[qw(a b)],[qw(c d)]]
  [[qw(b a)],[qw(c d)]]
  [[qw(a b)],[qw(d c)]]
  [[qw(b a)],[qw(d c)]]

And this list would have only 1 permutation (itself):

  [['a'] , ['b']]

If you pass a list container non-arraryrefs, it will be keep
un touched, so this list would have 2 permutations:

  [[qw(a b)],'c']

And that would be:

  [[qw(a b)],'c']
  [[qw(b a)],'c']

=head1 METHODS

=over 4

=item new(arrayref of arrayref)

Returns a permutor for the given list-of-lists

=item next

Returns a list of the items in the next permutation.

=item peak

Returns the list of items which would be returned by next(), but
doesn't advance the sequenc.

=item reset

Resets the iterator to the start. May be used at any time, whether the
entire set has been produced or not. Has no useful return value.

=back

=head1 SEE ALSO

L<List::Permutor>, L<Algorithm::Permute>

=head1 COPYRIGHT

Copyright 2004 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

