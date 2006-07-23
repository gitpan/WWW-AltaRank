package WWW::AltaRank;
use 5.008008;
use strict;
use warnings;
our $VERSION = '1.00';

use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;


sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};
  $self->{SITE} = "http://www.jobs.su";
  bless($self, $class);
  return $self;
}


sub site {
  my $self = shift;
  if (@_) { $self->{SITE} = shift }
  return $self->{SITE};

}


sub print {
	my $self = shift;
	my $site = $self->site;


	#GET URL
	$lwp->timeout(30);
	$lwp->agent('Mozilla/4.0');
	my $response = $lwp->get( "http://www.webalta.ru/reliance?url=$site");

	my @result;
    if ($response->is_success) {
		my $result = $response->content;
    	push (@result, "$result");
    }
    else{
	    return $response->status_line;
    }


	my $result;
    foreach (@result) {
        if ($_ =~ m/^\d+\s(\d+)$/){
    		$result = "$1";
    	}
    }


	return $result;
}


# Preloaded methods go here.

1;
__END__

=head1 NAME

WWW::AltaRank - WebAlta Thematic Index of Citing (TIC) for page

=head1 SYNOPSIS

   #!/usr/bin/perl
   use strict;
   use WWW::AltaRank;
   my $cy = WWW::AltaRank->new();
   $cy->site('http://www.jobs.su');
   my $print = $cy->print();
   print $print;


=head1 AUTHOR

Kostya Ten <lt>kostya@cpan.org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Kostya Ten

=cut
