use strict;

#use lib qw(/opt/PRSS);
$ENV{MOD_PERL} or die "not running under mod_perl!";

# Set up the ENV for BABYCONNECT in the perl.conf just before requiring the babystartup.pl as follow:
#   PerlSetEnv BABYCONNECT /opt/DBI-BabyConnect/configuration
#   PerlRequire /opt/Apache-BabyConnect/startupscripts/babystartup.pl
#
# alternatively you can uncomment the line below:
#BEGIN { $ENV{BABYCONNECT} = '/opt/DBI-BabyConnect/configuration'; }

use ModPerl::Registry ();
use LWP::UserAgent ();

use Apache::BabyConnect ();

use Carp ();
$SIG{__WARN__} = \&Carp::cluck;

$Apache::BabyConnect::DEBUG = 2;

#ATTENTION: this is only a sample example to test with Apache::BabyConnect,
#  in production environment, do not enable logging and tracing. To do so
#  just call connect_on_init() with the database descriptor only. For example:
#Apache::BabyConnect->connect_on_init('BABYDB_001');

Apache::BabyConnect->connect_on_init(
	'BABYDB_001',
	'/var/www/htdocs/logs/error_BABYDB_001.log',
	'/var/www/htdocs/logs/db_BABYDB_001.log',
	2
);

Apache::BabyConnect->connect_on_init(
	'BABYDB_002',
	'/var/www/htdocs/logs/error_BABYDB_002.log',
	'/var/www/htdocs/logs/db_BABYDB_002.log',
	2
);

Apache::BabyConnect->connect_on_init(
	'BABYCONNECT_003',
	'/var/www/htdocs/logs/error_BABYDB_003.log',
	'/var/www/htdocs/logs/db_BABYDB_003.log',
	2
);

Apache::BabyConnect->connect_on_init(
	'BABYCONNECT_004',
	'/var/www/htdocs/logs/error_BABYDB_004.log',
	'/var/www/htdocs/logs/db_BABYDB_004.log',
	2
);

#http://perl.apache.org/docs/2.0/api/Apache2/ServerUtil.html
#Apache2::ServerUtil::server_shutdown_cleanup_register(\&do_my_cleanups);

#use DBI::BabyConnect ();
#my $DBH = DBI::BabyConnect->new('/p9/PRSS/configuration/dbconf/WEBPROCESSORS_MYSQL.conf');
#$DBH->HookTracing(">>/tmp/mp-trace.log" , 2);
#$DBH->HookError(">>/tmp/mp-error.log");

1;
