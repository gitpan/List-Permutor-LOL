#!/usr/bin/perl -l

use strict;
use warnings;
use List::Permutor::LOL;
use Test::More qw(no_plan);
use YAML;

my $list = [[qw(a b)],[qw(c d)]];
my $p = List::Permutor::LOL->new($list);

my @v;
while(my $r = $p->next) {
  push @v, $r;
}

is(YAML::Dump($v[0]),YAML::Dump([[qw(a b)],[qw(c d)]]));
is(YAML::Dump($v[1]),YAML::Dump([[qw(b a)],[qw(c d)]]));
is(YAML::Dump($v[2]),YAML::Dump([[qw(a b)],[qw(d c)]]));
is(YAML::Dump($v[3]),YAML::Dump([[qw(b a)],[qw(d c)]]));


