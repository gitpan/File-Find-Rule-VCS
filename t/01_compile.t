#!/usr/bin/perl -w

# Load testing for File::Find::Rule::VCS

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}

use Test::More tests => 2;




# Check their perl version
ok( $] >= 5.005, "Your perl is new enough" );

# Load the modules
use_ok( 'File::Find::Rule::VCS' );

exit(0);
