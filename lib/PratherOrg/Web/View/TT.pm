package PratherOrg::Web::View::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config(
    {
        CATALYST_VAR => 'c',
        INCLUDE_PATH => [ PratherOrg::Web->path_to( 'root', 'templates', 'src' ), ],
        ERROR        => 'error.tt2',
        TIMER        => 0
    }
);


1;
__END__
