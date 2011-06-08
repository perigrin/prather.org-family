#!/usr/bin/env perl
use 5.14.0;
use Gedcom;
use aliased 'PratherOrg::Model::Person';
use PratherOrg::KiokuDB;
use Try::Tiny;

for my $file (@ARGV) {
    my $ged = Gedcom->new(
        grammar_version => 5.5,
        gedcom_file     => $file,
        read_only       => 1,
    );

    my $dir = PratherOrg::KiokuDB->new(
        dsn        => 'dbi:SQLite:test.db',
        extra_args => { create => 1 }
    );

    my $scope = $dir->new_scope;

    {

        package Gedcom::Individual;
        use Digest::SHA1 qw(sha1_hex);

        sub sha1 {
            my $self = shift;
            sha1_hex( $self->summary );
        }
    }

    for my $r ( $ged->individuals ) {
        my $father = $r->father;
        my $mother = $r->mother;

        my $p = Person->new(
            gedcom_record => $r,
            surname       => $r->surname || undef,
            given_names   => $r->given_names || undef,
            sex           => $r->sex || undef,
            birthdate     => $r->get_value( 'birth', 'date' ) || undef,
            birthplace    => $r->get_value( 'birth', 'place' ) || undef,
            deathdate     => $r->get_value( 'death', 'date' ) || undef,
            deathplace    => $r->get_value( 'death', 'place' ) || undef,
            father        => $father ? $father->sha1 : undef,
            mother        => $mother ? $mother->sha1 : undef,
            children => [ map { $_->sha1 } $r->children ],
        );
        try { $dir->store($p); } catch { warn $_ };
    }
}
