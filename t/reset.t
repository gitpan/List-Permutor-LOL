#!/usr/bin/perl -l

use strict;
use warnings;
use List::Permutor::LOL;
use Test::More qw(no_plan);
use YAML;

my $list = [[qw(a b)],[qw(c d)]];
my $p = List::Permutor::LOL->new($list);

my $a = $p->next;
$p->reset;
my $b = $p->next;

is(YAML::Dump($a),YAML::Dump($b));


