use inc::Module::Install;

name 'PratherOrg';
all_from 'lib/PratherOrg.pm';

requires 'Catalyst::Runtime' => '5.7012';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';

requires 'Catalyst::Authentication::Credential::OpenID';
requires 'LWPx::ParanoidAgent';

requires 'Catalyst::Plugin::Unicode';
requires 'Catalyst::Model::Gedcom';    # for the Geneology stuff

requires 'YAML';    # This should reflect the config file format you've chosen
                    # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
