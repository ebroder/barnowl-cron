use strict;
use warnings;

use inc::Module::Install;

requires('DateTime::Event::Cron');

barnowl_module('Cron');

WriteAll;
