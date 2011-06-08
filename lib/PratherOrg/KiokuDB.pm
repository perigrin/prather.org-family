package PratherOrg::KiokuDB;
use Moose;
use namespace::autoclean;

use SQL::Abstract;
use KiokuDB::TypeMap::Entry::Set;

extends qw(KiokuX::Model);

has columns => (
    isa        => 'ArrayRef',
    is         => 'ro',
    lazy_build => 1,
);

sub _build_columns {
    [
        # sha1 => {
        #     data_type   => "str",
        #     is_nullable => 1,
        #     extract     => sub {
        #         my $obj = shift;
        #         return $obj->sha1 if $obj->can('sha1');
        #     },
        # },
    ];
}

around _build__connect_args => sub {
    my $next = shift;
    my $self = shift;
    my $args = $self->$next(@_);
    push @$args, columns     => $self->columns;
    return $args;
};

1;

__END__
