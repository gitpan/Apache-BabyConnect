
From CPAN download and install DBI::BabyConnect.
Follow the instructions on how to test the DBI::BabyConnect.

From CPAN download and install Apache::BabyConnect.
Let's assume you have extracted the Apache-BabyConnect.tar.gz into /opt.

Locate the babystartup.pl in the directory
The directory /opt/Apache-BabyConnect/startupscripts


1- Edit the file babystartup.pl and make the appropriate changes
 if necessary.

-----------------------------------

2- Edit /etc/httpd/conf.d/perl.conf and load the babystartup.pl and
  make sure to set the environment variable BABYCONNECT and to
  load the babystartup.pl before anything else

PerlSetupEnv Off
PerlSetEnv BABYCONNECT /opt/DBI-BabyConnect/configuration
PerlRequire /opt/Apache-BabyConnect/startupscripts/babystartup.pl

Alias /perl /var/www/perl
<Directory /var/www/perl>
    SetHandler perl-script
    PerlResponseHandler ModPerl::Registry
    PerlOptions +ParseHeaders
    Options +ExecCGI
</Directory>


-----------------------------------

3- Restart httpd

You can tail the httpd error_log file to view the initialization
of the connection as the httpd servers start up (see LLLLL). Each server
will be started with 4 database descriptors, therefore each server
will have 4 active DBI::BabyConnect objects that will server
4 data sources. While a descriptor is uniquely identified by its
name, two or more descriptors can point to the same data source.


4- Copy test scripts from /opt/DBI-BabyConnect/test to /var/www/perl
   and test your connection from a browser:
    http://yourserver.com/perl/testbaby.pl

5- Test the caching:
    http://yourserver.com/perl/testcache.pl
Keep on requesting testcache.pl for couple of time and observe
the counter of the cached database descriptor increasing.

   Request http://yourserver.com/perl/testbaby.pl
This should display the cached database descriptor as well.
Both testbaby.pl and testcache.pl are using the DBI::BabyConnect
that have been cached by the babystartup.pl script.

6- Test the rollback
In globalconf.pl set 
ON_FAILED_DBIEXECUTE_ROLLBACK_AND_EXIT=1
and restart the httpd
this will rollback and exit on error. With Apache::BabyConnect the rollback
is effectively handled by DBI::BabyConnect, and the exit is handled by Apache
MD2. In other word your script will end at that point (after the rollback took
effect)
Test script: testrollback.pl
   Request http://yourserver.com/perl/testrollback.pl

In globalconf.pl set 
ON_FAILED_DBIEXECUTE_ROLLBACK_AND_EXIT=0
and restart the httpd
this will neither rollback nor exit on error. In addition
your script will continue past the point of the do()'s. You can
chose to rollback programmatically if you want.
Test script: testrollback.pl
   Request http://yourserver.com/perl/testrollback.pl


