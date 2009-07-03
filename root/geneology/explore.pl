#!/usr/bin/env perl

use IO::Prompt;
use Gedcom;
use Gedcom::Foaf;

my $g = Gedcom->new(shift @ARGV);

#die 'invalid gedcom' unless $g->validate;
my $current = ( $g->individuals )[0];

sub say ($) { print shift() . "\n" }

while ( prompt "> " ) {
    my ( $cmd, $param ) = split /\s+/, $_, 2;
    if ( $cmd eq 'get' ) {
        $current = $g->get_individual($param);
        next;
    }
    my @res = $current->$cmd($param) if $current->can($cmd);
    for (@res) {
        if ( ref $_ ) {
            say $_->name if ref $_ eq 'Gedcom::Individual';
        }
        else {
            say $_;
        }
    }
}
