package PratherOrg::Model::Person;
use Moose;
use Moose::Util::TypeConstraints;
use MooseX::UndefTolerant;
use Digest::SHA1 qw(sha1_hex);

with qw(KiokuDB::Role::ID);
sub kiokudb_object_id { shift->sha1 }

has gedcom_record => (
    isa     => 'Gedcom::Individual',
    is      => 'ro',
    traits  => [qw(KiokuDB::DoNotSerialize)],
    handles => [
        qw(
          name
          summary
          )
    ]
);

has sha1 => (
    isa     => 'Str',
    is      => 'ro',
    lazy    => 1,
    builder => '_build_id',
);

sub _build_id {
    my $self = shift;
    no warnings 'uninitialized';
    sha1_hex( $self->summary );
}

has [qw(surname given_names)] => (
    isa     => 'Str',
    is      => 'ro',
    default => '',
);

has sex => (
    isa => enum( [qw(M F U)] ),
    is => 'ro',
    required => 1,
);

has [qw(birthplace deathplace)] => (
    isa     => 'Str',
    is      => 'ro',
    default => ''
);

has [qw(birthdate deathdate)] => (
    isa     => 'Str',
    is      => 'ro',
    default => '',
);

has [qw(father mother)] => ( isa => 'Str', is => 'ro', );
has children => ( isa => 'ArrayRef[Str]', is => 'ro', );

1;
__END__
