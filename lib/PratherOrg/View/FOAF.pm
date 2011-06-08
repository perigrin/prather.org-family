package PratherOrg::View::FOAF;
use strict;
use base 'Catalyst::View';

sub process {
    my ( $self, $c ) = @_;
    my $object = $c->stash->{rest}{person};
    $c->res->content_type('application/rdf+xml');
    $c->res->body( $object->as_foaf );
}

1;
__END__
