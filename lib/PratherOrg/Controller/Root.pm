package PratherOrg::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    map => {
        'text/html'           => [ 'View', 'TT' ],
        'application/rdf+xml' => [ 'View', 'FOAF' ],
        'text/xml'            => [ 'View', 'FOAF' ],
    }
);

sub index : Path('/') ActionClass('REST') {
}

sub index_GET {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'index.tt2';
    $self->status_ok( $c, entity => { gedcom => $c->model('Gedcom'), } );
}

sub person : Path('/person') Args(1) ActionClass('REST') {
}

sub person_GET {
    my ( $self, $c, $xref ) = @_;
    $c->stash->{template} = 'person.tt2';
    $self->status_ok(
        $c,
        entity => {
            gedcom => $c->model('Gedcom'),
            person => $c->model('Gedcom')->get_individual($xref),
            copy   => 'Not Available.',
        }
    );
}

sub about : Path('/about') ActionClass('REST') {
}

sub about_GET {
    my ( $self, $c ) = @_;
    $self->status_ok( $c, entity => { gedcom => $c->model('Gedcom') } );
}

1;
__END__
