package List::Fibonacci::Iterator;

use 5.24.0;
use strict;
use warnings;

use List::Util qw();

our $VERSION = '0.01';

our $ORIGINAL_INITIAL_TERMS = [1, 1];
our $ORIGINAL_AGGREGATION_FUNCTION = \&List::Util::sum;

sub new {
    my ($class, $initial_terms, $aggregation_function) = @_;

    my $instance = {
        index => -1,
        initial_terms => $initial_terms // $ORIGINAL_INITIAL_TERMS,
        aggregation_function => $aggregation_function // $ORIGINAL_AGGREGATION_FUNCTION,
        rank => scalar(@$initial_terms),
        # copy initial terms to separate space
        terms => [ @$initial_terms ],
    };

    $instance->{iteration_function} = sub {
        $instance->{index} += 1;
        # if index < rank, render initial term
        if ( $instance->{index} < $instance->{rank} ) {
            my $i = $instance->{index};
            return $instance->{terms}[$i];
        }
        # if index >= rank, produce value
        my $terms = $instance->{terms};
        my $aggr = $instance->{aggregation_function};
        my $new_value = $aggr->(@{$terms});
        shift @{$terms};
        push @{$terms}, $new_value;
        return $new_value;
    };

    return bless($instance, __PACKAGE__);
}

sub initial_terms {
    my ($self) = @_;
    return $self->{initial_terms};
}

sub rank {
    my ($self) = @_;
    return $self->{rank};
}

sub iteration_function {
    my ($self) = @_;
    return $self->{iteration_function};
}

sub next {
    my ($self) = @_;
    return $self->{iteration_function}->();
}

1;
