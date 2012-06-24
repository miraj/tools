#!/usr/bin/perl
# This is a template for arguments parsing in perl
# You will have to tweak this for your need
use strict;
use warnings;
use Getopt::Long;

sub usage {
	print "Usage: \n";
	print "  ./parseXML.pl <command> <options> --plans trickplay.xml 1257

           Commands: 
              unknownapi    : Find the list of unknown APIs
              countapi      : Find the list of unavailable APIs
              search        : search a specified api in all the test cases
              general       : create a general report
              stat          : print the statistics of the plan

            Options:

              --api    : Specify the api to search for.
              --user   : Specify the username. Mandatory when a planID is specified, for downloading the XML file from testopia. 
              --pass   : Specify the password. Mandatory when a planID is specified, for downloading the XML file from testopia. 
              --plans  : Specify the testplans. This could be a XML file name or a Plan ID. Atleast 1 plan is mandatory.
              --force  : Force the script to ignore warnings. For eg: ignore existense of unknown APIs
              --verbose: Enable verbose mode.
              --debug  : Enable debug mode.
          
";
}


my $action;
my $apiname;
my $user;
my $pass;
my @plans;
my $debug = 0;
my $verbose = 0;
my $force = 0;

$action = $ARGV[0];
print "action = $action\n";
unless ($action eq "unknownapi" or $action eq "countapi" or $action eq "search" or $action eq "general" or $action eq "stat") {
	print "Error \nAction should be defined\n\n";
	usage;
	exit 3;
}
 

my $result = GetOptions (
						 "api=s"         => \$apiname,      # string
						 "user=s"        => \$user,      # string
						 "password=s"    => \$pass,      # string
						 "plans=s{1,}"   => \@plans,      # Array of strings. Size of array should 1 or higher
						 "force"         => \$force,
						 "debug"         => \$debug,
                         "verbose"       => \$verbose);  # flag

if ($result != 1) {
	print "Options Error!! \n\n";
	usage;
	print "Exiting ...\n";
	exit 3;

}


if (@plans == 0) {
	print "Error \nNo Plans specified\n\n";
	usage;
	print "Exiting ...\n";
	exit 3;
	
}

if ($action eq "search") {
	if (!defined $apiname or $apiname =~ /-|\./) {
		print "Error \n";
		usage;
		print "Exiting ...\n";
		exit 3;
	}
}

# If plan IDs are given then username password is mandatory
if (grep(/^d{4,}$/,@plans) and (!defined $user or !defined $pass) ) {
	print "Error \n";
	print "Username and Password should be given\n";
	usage;
	exit;
}

for my $plan (@plans) {
	print "plan = $plan \n"
}


# Loop through the plans and parse them
# If it's a plan ID - download XML and parse
# Use $action to find out the action todo
# complete the usage 
# Derive the plan name from the XML. Replace space with underscore
# Derive the output filename from the plan name
