package File::Find::Rule::VCS;

=pod

=head1 NAME

File::Find::Rule::VCS - Exclude files/directories for Version Control Systems

=head1 SYNOPSIS

  use File::Find::Rule      ();
  use File::Find::Rule::VCS ();
  
  # Find all files smaller than 10k, ignoring anything in the CVS dirs
  my @files = File::Find::Rule->discard_cvs
                              ->file
                              ->size('<10Ki')
                              ->in( $dir );

=head1 DESCRIPTION

I find myself doing exclusion of CVS or Subversion directories over and
over again in almost every major FFR thing I write.

File::Find::Rule::VCS provides methods to exclude the version control
directories of several major Version Control Systems. Initially, this is
just CVS and Subversion, but if you have an snippit of FFR code for any
other VCS, I'd be happy to take and include it.

=head1 METHODS

=cut

use strict;
use UNIVERSAL;
use base 'File::Find::Rule';
use constant FFR => 'File::Find::Rule';

use vars qw{$VERSION @EXPORT};
BEGIN {
	$VERSION = '0.01';
	@EXPORT  = @File::Find::Rule::EXPORT;
}





#####################################################################
# File::Find::Rule Method Addition

=pod

=head2 discard_vcs($vcsname)

The C<discard_vcs> method excludes the files for a named Version Control
System from your L<File::Find::Rule> search. The name of the VCS is case
in-sensitive.

Names currently supported are 'cvs', 'svn' and 'subversion'.

The use of none, or any other name will throw an exception.

=cut

sub File::Find::Rule::discard_vcs {
	my $self = shift()->_force_object;
	my $vcs  = defined $_[0] ? lc shift
		: die "->discard_vcs: No Version Control System name provided";

	# Hand off to the rules for each VCS
	return $self->discard_cvs if $vcs eq 'cvs';
	return $self->discard_svn if $vcs eq 'svn';
	return $self->discard_svn if $vcs eq 'subversion';

	die "->discard_vcs: '$vcs' is not supported";
}

=pod

=head2 discard_cvs

The C<discard_cvs> method excluding all CVS directories from your
L<File::Find::Rule> search.

=cut

sub File::Find::Rule::discard_cvs {
	my $self = shift()->_force_object;
	$self->or(
		FFR->directory->name('CVS')->prune->discard,
		FFR->new,
		);
}

=pod

=head2 discard_svn

The C<discard_svn> method excluding all Subversion (C<.svn>) directories
from your L<File::Find::Rule> search.

=cut

sub File::Find::Rule::discard_svn {
	my $self = shift()->_force_object;
	$self->or(
		FFR->directory->name('.svn')->prune->discard,
		FFR->new,
		);
}

1;

=pod

=head1 TO DO

- Add support for other version control systems.

- Possibly exclude those garbage/backup files that CVS leaves lying around
after a merge

- Add other useful VCS-related methods

=head1 SUPPORT

Bugs should always be submitted via the CPAN bug tracker

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=File-Find-Rule-VCS>

For other issues, contact the maintainer

=head1 AUTHOR

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

=head1 SEE ALSO

L<File::Find::Rule>

=head1 COPYRIGHT

Copyright (c) 2005 Adam Kennedy. All rights reserved.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
