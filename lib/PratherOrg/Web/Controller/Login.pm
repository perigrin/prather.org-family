package PratherOrg::Web::Controller::Login;

use strict;
use warnings;
use base 'Catalyst::Controller';

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

1;
__END__
