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
ok( FFR->can('discard_vcs'), '->discard_vcs method exists' );
ok( FFR->can('discard_cvs'), '->discard_cvs method exists' );
ok( FFR->can('discard_svn'), '->discard_svn method exists' );

# Make an object containing all of them
my $Rule = File::Find::Rule->new->discard_cvs->discard_svn;
isa_ok( $Rule, 'File::Find::Rule' );

exit(0);
