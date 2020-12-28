#!perl
use 5.24.0;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'List::Fibonacci' ) || print "Bail out!\n";
}

diag( "Testing List::Fibonacci $List::Fibonacci::VERSION, Perl $], $^X" );
