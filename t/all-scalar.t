#!/usr/bin/perl -l

use strict;
use warnings;
use List::Permutor::LOL;
use Test::More qw(no_plan);
use YAML;

my $list = ['a','b','c'];
my $p = List::Permutor::LOL->new($list);

my @p;
while(my $r = $p->next) {
  push @p, $r;
}

is(YAML::Dump($p[0]),YAML::Dump(['a','b','c']));

