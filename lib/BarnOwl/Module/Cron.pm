use warnings;
use strict;

=head1 NAME

BarnOwl::Module::Cron

=head1 DESCRIPTION

Schedule commands

=cut

package BarnOwl::Module::Cron;

our $VERSION = 0.1;

use BarnOwl;
use BarnOwl::Hooks;
use BarnOwl::Timer;

use DateTime::Event::Cron;

my $desc = <<'END_DESC';
BarnOwl::Module::Cron parses ~/.barnowl/crontab, and schedules events
based on its contents.

~/.barnowl/crontab should be a series of lines with the same columns
as documented in crontab(5). The "command" field is interpreted as a
BarnOwl command. BarnOwl::Module::Cron only supports the standard
5-column specification for recurrences (i.e. not @reboot), and does
not support things like setting environment variables in
~/.barnowl/crontab.
END_DESC

my $crontabpath = BarnOwl::get_config_dir() . '/crontab';
if (open(my $fh, '<', "$crontabpath")) {
    read_config($fh);
    close($fh);
}

sub read_config {
    my $fh = shift;
    @sets = DateTime::Event::Cron->fron_crontab(file => $fh);
}

1;
