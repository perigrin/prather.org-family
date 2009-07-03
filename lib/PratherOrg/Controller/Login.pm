package PratherOrg::Controller::Login;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

PratherOrg::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;
    $c->res->redirect( $c->uri_for('/login/openid') );
}

sub openid : Local {
    my ( $self, $c ) = @_;
    if ( $c->authenticate() ) {
        $c->flash( message => "You signed in with OpenID!" );
        $c->res->redirect( $c->uri_for('/login/success') );
    }
    else {
        $c->stash->{template} = 'login/index.tt2';
    }
}

sub success : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'login/logged_in.tt2';
}

=head1 AUTHOR

Chris Prather

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
