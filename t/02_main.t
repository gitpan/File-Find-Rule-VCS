#!/usr/bin/perl -w

# Testing for File::Find::Rule::VCS

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

use Test::More tests => 4;
use File::Find::Rule      ();
use File::Find::Rule::VCS ();
use constant FFR => 'File::Find::Rule';

# Check the methods are added
ok( FFR->can('ignore_vcs'), '->ignore_vcs method exists' );
ok( FFR->can('ignore_cvs'), '->ignore_cvs method exists' );
ok( FFR->can('ignore_svn'), '->ignore_svn method exists' );

# Make an object containing all of them
my $Rule = File::Find::Rule->new->ignore_cvs->ignore_svn;
isa_ok( $Rule, 'File::Find::Rule' );

exit(0);