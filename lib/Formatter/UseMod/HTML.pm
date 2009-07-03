package Formatter::UseMod::HTML;
use strict;
use XML::LibXML;
our $VERSION = 0.01;

sub format { 
  my $that  = shift;
  my $class = ref($that) || $that;
  my $self = {  _text => shift };
  return bless($self, $class);
}

sub document {
	my $self = shift;
	$self->{_DOM} = XML::LibXML->new()->parse_html_string( $self->{_text} );
	return $self->{_DOM}->textContent;
}

sub fragment {
	goto &{ shift->can('document') };
}

sub links {}
sub title {}

__END__
