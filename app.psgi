#!/usr/bin/env perl
use strict;
use warnings;
use lib qq(lib);
use local::lib;
use PratherOrg::Web;

PratherOrg::Web->setup_engine('PSGI');
my $app = sub { PratherOrg::Web->run(@_) };

