#!/usr/bin/env perl

use strict;
use warnings;

use Plack;
use Plack::Request;
use Time::HiRes;

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    my ($path_info, $query) = ($req->path_info, $req->param('query'));
    my ($status, $headers, $body) = (200, ['Content-Type' => 'text/plain'], ["OK\n"]);
    if ($path_info =~ m{/wait/([0-9]+)}) {
        my $sleep_sec = $1;
        Time::HiRes::sleep($sleep_sec);
        push @$body, "slept $sleep_sec sec\n";
    }
    return [$status, $headers, $body];
};
