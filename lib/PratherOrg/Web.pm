package PratherOrg::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a YAML file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw(
  -Debug
  ConfigLoader
  Static::Simple

  Authentication
  Session
  Session::Store::FastMmap
  Session::State::Cookie

  Unicode
);

our $VERSION = '0.01';

use CatalystX::RoleApplicator;

__PACKAGE__->apply_request_class_roles(
    qw[
      Catalyst::TraitFor::Request::REST::ForBrowsers
      ]
);

# Configure the application.
#
# Note that settings in pratherorg.yml (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name    => 'PratherOrg',
    static  => { dirs => [qw(static/html static/css static/images static/js)] },
    session => {
        flash_to_stash => 1,
        expires        => '1800',
    },
    'View::TT' => {
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'src' ),
            __PACKAGE__->path_to( 'root', 'lib' ),
        ],
        TEMPLATE_EXTENSION => '.tt2',
        CATALYST_VAR       => 'c',
        TIMER              => 0,
    },
    authentication => {
        default_realm => 'openid',
        realms        => {
            openid => {
                ua_class => "LWPx::ParanoidAgent",
                ua_args =>
                  { whitelisted_hosts => [qw/ 127.0.0.1 localhost /], },
                credential => {
                    class => "OpenID",
                    store => { class => "OpenID", },
                },
            },

        },
    },
    'Model::Gedcom' => {
        gedcom_file => 'root/prather.ged',
        read_only   => 1,
    }
);

# Start the application
__PACKAGE__->setup;

=head1 NAME

PratherOrg::Web - Catalyst based application

=head1 SYNOPSIS

    script/pratherorg_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<PratherOrg::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Chris Prather

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
