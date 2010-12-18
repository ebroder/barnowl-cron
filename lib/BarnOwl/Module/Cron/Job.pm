use warnings;
use strict;

package BarnOwl::Module::Cron::Job;

use Scalar::Util qw(weaken);
use DateTime::Event::Cron;

use BarnOwl;

sub new {
    my $class = shift;
    my $set = shift;

    my $self = {
	'set' => $set,
	'timer' => undef
    };

    bless($self, $class);

    $self->schedule;

    return $self;
}

sub schedule {
    my $self = shift;

    my $now = DateTime->now;
    my $next = $self->{set}->next;
    my $delay = ($next->subtract_datetime_absolute($now))->seconds;

    my $weak = $self;
    weaken($weak);

    $self->{timer} = BarnOwl::Timer->new(
	{
	    after    => $delay,
	    interval => 0,
	    cb       => sub { $weak->run if $weak }
	});
}

sub run {
    my $self = shift;

    BarnOwl::command($self->{set}->command());
    $self->schedule;
}

1;
