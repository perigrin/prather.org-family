package CGI::Wiki::Kwiki::Mozile;
use lib qw(/home/mozile_wiki/lib);
use base qw(CGI::Wiki::Kwiki);
use Formatter::UseMod::HTML;

sub commit_node {
        my ($self, $node, $content, $checksum, $ancestor, $metadata) = @_;
        if ($content =~ m/<body>/) {
                my $f = Formatter::UseMod::HTML->format($content);
                $content = $f->document;
        }
        return $self->SUPER::commit_node($node, $content, $checksum,
        $ancestor, $metadata);
}
1;
__END__
