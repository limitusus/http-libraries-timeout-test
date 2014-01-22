#!/usr/bin/env perl

use strict;
use warnings;

use 5.012;
use LWP::UserAgent;

my $wait_for_sec = shift;

my $ua = LWP::UserAgent->new;
$ua->timeout(3);
my $req_path = sprintf "/delay/%d", $wait_for_sec;

my $res = $ua->get("http://localhost:5000" . $req_path);

say $res->is_success;
say $res->code;
#say $res->status;
say $res->message;
say $res->status_line;
say $res->content_type;
say $res->content_length;
say $res->content;
