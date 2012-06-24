#!/usr/bin/perl

use warnings;

sub usage {
	print "Usage: \n";
	print "  ./parseXML.pl \
        --unknownapi|-u    : Find the list of unknown API \
        --countapi|-c      : Find the list of unknown API \
        --api|-a           : Find the list of unknown API \
";
}
my $action = undef;
my $apiname = undef;
my $debug = undef;
my $verbose = undef;
my $force = undef;
my $user = undef;
my $pass = undef;
my $userpassneeded = "false";
my @plans = ();

while (@ARGV) {
	my $opt = shift @ARGV;
	if ($opt =~ /^--unknownapi$|^-u$/) {
		$action = "unknownapi";
	} elsif ($opt =~ /^--countapi$/) { 
		$action = "countapi";
	} elsif ($opt =~ /^--api$|^-a$/) { 
		$action = "api";
		$apiname = shift @ARGV;
	} elsif ($opt =~ /^--api=(.+)$/) { 
		$action = "api";
		$apiname = $1;
	} elsif ($opt =~ /^--generel$|^-g$/) { 
		$action = "general"
	} elsif ($opt =~ /^--stat$|^-s$/) { 
		$action = "stat";
	} elsif ($opt =~ /^--user$/) { 
		$user = shift @ARGV;
	} elsif ($opt =~ /^--user=(.+)$/) { 
		$user = $1;
	} elsif ($opt =~ /^--pass$/) { 
		$pass = shift @ARGV;
	} elsif ($opt =~ /^--pass=(.+)$/) { 
		$pass = $1;
	} elsif ($opt =~ /^-v$/) { 
		$verbose = "true";
	} elsif ($opt =~ /^-d$/) { 
		$debug = "true";
	} elsif ($opt =~ /^-f$/) { 
		$force = "true";
	} elsif ($opt =~ /^-h$/) { 
		usage();
		exit 0;
	} elsif ($opt =~ /^.+\.xml$/) { 
		# This is the input XML file
		push (@plans, $opt);	
	} elsif ($opt =~ /^\d{4,}$/) { 
		# This is a plan ID
		push (@plans, $opt);	
		$userpassneeded = "true";

	} else {
		print "Unkonwn option $opt \n";
		print "Exiting ... \n\n\n";
		exit 2;
	}
}

if (!defined $action) {
	print "Error \nAction should be defined\n\n";
	usage;
	exit 3;
}
if (@plans == 0) {
	print "Error \nNo Plans specified\n\n";
	usage;
	exit 3;
	
}

if ($action eq "api") {
	if (!defined $apiname or $apiname =~ /-|\./) {
		print "Error \n";
		print "Expecting an api name after --api option \n";
		print "$apiname : is it really an api name? \n";
		print "Exiting ...";
		usage;
		exit 3;
	}
}

if ($userpassneeded eq "true" and (!defined $user or !defined $pass) ) {
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
