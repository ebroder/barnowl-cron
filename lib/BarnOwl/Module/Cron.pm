use warnings;
use strict;

=head1 NAME

BarnOwl::Module::Cron

=head1 DESCRIPTION

Schedule commands

=cut

package BarnOwl::Module::Cron;

our $VERSION = 0.1;

use DateTime::Event::Cron;

use BarnOwl;
use BarnOwl::Module::Cron::Job;

our @jobs = ();

my $crontabpath = BarnOwl::get_config_dir() . '/crontab';
if (open(my $fh, '<', "$crontabpath")) {
    read_config($fh);
    close($fh);
}

sub read_config {
    my $fh = shift;
    @sets = DateTime::Event::Cron->fron_crontab(file => $fh);
    for my $set (@sets) {
	push @jobs, BarnOwl::Module::Cron::Job->new($set);
    }
}

1;
