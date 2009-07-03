use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'PratherOrg' }
BEGIN { use_ok 'PratherOrg::Controller::Family' }

ok( request('/family')->is_success, 'Request should succeed' );


