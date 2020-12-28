#!perl
use 5.24.0;
use strict;
use warnings;
use Test::More;

# plan tests => 4;

my $class;


BEGIN {
    $class = 'List::Fibonacci::Iterator';
    use_ok( $class ) || print "Bail out!\n";
}

diag( "Testing List::Fibonacci::Iterator $List::Fibonacci::Iterator::VERSION, Perl $], $^X" );


my $fib_i = new_ok( $class => [ [1, 1] ] );


subtest 'Original series: attributes' => sub {
    # plan tests => 2;
    is_deeply($fib_i->initial_terms, [1, 1], 'initial terms');
    is($fib_i->rank, 2, 'rank');
};


subtest 'Original series: initial terms' => sub {
    # plan tests => 2;
    is($fib_i->next, 1, 'fib[0]');
    is($fib_i->next, 1, 'fib[1]');
};


subtest 'Original series: next terms' => sub {
    # plan tests => 4;
    is($fib_i->next, 2, 'fib[2]');
    is($fib_i->next, 3, 'fib[3]');
    is($fib_i->next, 5, 'fib[4]');
    is($fib_i->next, 8, 'fib[5]');
};


my $custom_i = new_ok( $class => [ [1, -1, 2] ] );


subtest 'Custom series: attributes' => sub {
    # plan tests => 2;
    is_deeply($fib_i->initial_terms, [1, -1, 2], 'initial terms');
    is($fib_i->rank, 3, 'rank');
};


subtest 'Custom series: initial terms' => sub {
    # plan tests => 3;
    is($custom_i->next, 1, 'fib[0]');
    is($custom_i->next, -1, 'fib[1]');
    is($custom_i->next, 2, 'fib[2]');
};


subtest 'Custom series: next terms' => sub {
    # plan tests => 4;
    is($custom_i->next, 2, 'fib[3]');
    is($custom_i->next, 3, 'fib[4]');
    is($custom_i->next, 7, 'fib[5]');
    is($custom_i->next, 12, 'fib[6]');
};


my $aggr_function = sub { join '', @_ };
my $custom_aggr_i = new_ok( $class => [ ['#','|'], $aggr_function ] );


subtest 'Custom series & aggregation: attributes' => sub {
    # plan tests => 2;
    is_deeply($fib_i->initial_terms, ['#', '|'], 'initial terms');
    is($fib_i->rank, 2, 'rank');
};


subtest 'Custom series & aggregation: initial terms' => sub {
    # plan tests => 2;
    is($custom_aggr_i->next, '#', 'fib[0]');
    is($custom_aggr_i->next, '|', 'fib[1]');
};

0
subtest 'Custom series & aggregation: next terms' => sub {
    # plan tests => 5;
    is($custom_aggr_i->next, '#|', 'fib[2]');
    is($custom_aggr_i->next, '|#|', 'fib[3]');
    is($custom_aggr_i->next, '#||#|', 'fib[4]');
    is($custom_aggr_i->next, '|#|#||#|', 'fib[5]');
    is($custom_aggr_i->next, '#||#||#|#||#|', 'fib[6');
};



done_testing;
