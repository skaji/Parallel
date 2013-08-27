# NAME

Parallel - It's new $module

# SYNOPSIS

    use Parallel;

    my $exit_status = Parallel->run(
        map sub {
            my $index = shift;
            print "[index=$index, pid=$$] hello", "\n";
        }, 1..5
    );

    use Data::Dumper;
    print Dumper $exit_status;

# DESCRIPTION

Parallel is ...

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@outlook.com>
