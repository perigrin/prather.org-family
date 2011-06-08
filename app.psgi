#!/usr/bin/env perl
use strict;
use warnings;
use lib qq(lib);
use local::lib;
use PratherOrg;

PratherOrg->setup_engine('PSGI');
my $app = sub { PratherOrg->run(@_) };

