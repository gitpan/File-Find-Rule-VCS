use inc::Module::Install;

name          ( 'File-Find-Rule-VCS'            );
abstract      ( 'Exclude files/directories for Version Control Systems' );
author        ( 'Adam Kennedy<cpan@ali.as>'     );
version_from  ( 'lib/File/Find/Rule/VCS.pm'     );
license       ( 'perl'                          );

requires      ( 'perl'               => '5.005' );
requires      ( 'File::Find::Rule'   => '0.20'  );

build_requires( 'File::Spec'         => '0.82'  );
build_requires( 'Test::More'         => '0.47'  );

auto_install();

&WriteAll;
