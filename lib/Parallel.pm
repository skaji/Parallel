package Parallel;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

sub run {
    (undef, my @cb) = @_;

    my %worker_pid;
    for my $i ( 0 .. $#cb ) {
        my $pid = fork;
        die "fork failed" unless defined $pid;
        if ($pid) {
            $worker_pid{$pid}++;
            next;
        }

        $cb[$i]($i);
        exit;
    }

    my %exit_status;
    while (%worker_pid) {
        my $pid = wait;
        if (exists $worker_pid{$pid}) {
            delete $worker_pid{$pid};
            $exit_status{$pid} = $?;
        }
    }
    return \%exit_status;
}

1;
__END__

=encoding utf-8

=head1 NAME

Parallel - It's new $module

=head1 SYNOPSIS

    use Parallel;

    my $exit_status = Parallel->run(
        map sub {
            my $index = shift;
            print "[index=$index, pid=$$] hello", "\n";
        }, 1..5
    );

    use Data::Dumper;
    print Dumper $exit_status;

=head1 DESCRIPTION

Parallel is ...

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@outlook.comE<gt>

=cut

