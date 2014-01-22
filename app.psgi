#!/usr/bin/env perl

use strict;
use warnings;

use Plack;
use Plack::Request;
use Time::HiRes;

use Data::Dumper;

$ENV{'psgi.streaming'} = 1;

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    my ($path_info, $query) = ($req->path_info, $req->param('query'));
    my ($status, $headers, $body) = (200, ['Content-Type' => 'text/plain'], ["OK\n"]);
    if ($path_info =~ m{/wait/([0-9]+)}) {
        my $sleep_sec = $1;
        Time::HiRes::sleep($sleep_sec);
        push @$body, "slept $sleep_sec sec\n";
    } elsif ($path_info =~ m{/delay/([0-9]+)}) {
        my $delay_sec = $1;
        return sub {
            my $respond = shift;
            my $writer = $respond->([200, ['Content-Type' => 'text/plain'], ]);
            for my $i (1 .. 7) {
                $writer->write("delayed $i\n");
                sleep $delay_sec;
            }
        }
    }
    return [$status, $headers, $body];
};
