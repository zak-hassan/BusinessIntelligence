#!/usr/bin/perl 
use strict;
use DBI;
use Time::localtime;
use IO::File;
use Dialog;
use ETL;
use Data::Dumper;
#Developer Name: Zakeria Hassan <zak.hassan1010@gmail.com>
#Date: Mar 26, 2014

sub db{
      my (@batch) = @_;
    my $db_name='test';
    my $uname='';
    my $upass='';
    my $dbh = DBI->connect("DBI:mysql:database=$db_name;host=localhost", $uname, $upass) or die "Cannot connect: " . $DBI::errstr;

     foreach (@batch) {
            #print "$_\n";
            Dialog::s_check();
            print "Added 1 Row \n";
    }
	# my $sth = $dbh->prepare('SELECT * FROM people WHERE lastname = ?')
	#             or die "Couldn't prepare statement: " . $dbh->errstr;
#	my $sth = $dbh->prepare("LOAD DATA LOCAL INFILE 'lifeExpect.csv' INTO TABLE lifeExpect IGNORE 1 LINES (year, male, female) ") or die(" Can not load CSV into database. ");
Dialog::s_msg("Added ".scalar(@batch)." rows in batch process");
}



#db();
#
sub main {
    my $s = time;

my @batch=();    
push(@batch, ETL::loadPopulation("../flatfiles/population_byYear_byProvince_byTerritory.csv"));
push(@batch, ETL::loadBabyNames("../flatfiles/ontariotopbabynames_male_1917-2010_english.csv",1));
push(@batch, ETL::loadLifeExpect("../flatfiles/lifeExpect.csv") );
#printf ``Dumper \@batch;
db(@batch);

my $len= time- $s;
Dialog::s_msg("Finished in: $len seconds" )
}

main();