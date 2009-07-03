package PratherOrg::Controller::Family;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

PratherOrg::Controller::Family - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;
    $c->stash->{gedcom}   = $c->model('Gedcom');
    $c->stash->{template} = 'family/index.tt2';
}

sub member : Local {
    my ( $self, $c, $xref ) = @_;
    $c->stash->{person} = $c->model('Gedcom')->get_individual($xref);
    if ( $c->request->param('format') eq 'foaf' ) {
        $c->res->content_type('application/rdf+xml');
        $c->res->body( $c->stash->{person}->as_foaf );
        return;
    }
    $c->stash->{template} = 'family/person.tt2';
}

=head1 AUTHOR

Chris Prather

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
