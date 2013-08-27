use strict;
use warnings;
use utf8;
use Test::More;
use Data::Dumper;

use Parallel;

my $exit = Parallel->run(
    sub { exit(1) },
    sub { exit(2) },
    sub { exit(3) },
    sub { die     },
);

diag Dumper $exit;
is_deeply [ sort {$a <=> $b} map {$_ >> 8} values %$exit ],
          [ 1, 2, 3, 255 ];

done_testing;

