#!/usr/bin/perl -l

use strict;
use warnings;
use List::Permutor::LOL;
use Test::More qw(no_plan);
use YAML;

my $list = ['a',[qw(b c)]];
my $p = List::Permutor::LOL->new($list);
my $r;

$r = $p->peek;
is(YAML::Dump($r),YAML::Dump(['a',[qw(b c)]]));
$p->next;

$r = $p->peek;
is(YAML::Dump($r),YAML::Dump(['a',[qw(c b)]]));

