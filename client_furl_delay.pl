#!/usr/bin/env perl

use strict;
use warnings;

use 5.012;
use Furl;

my $wait_for_sec = shift;

my $furl = Furl->new(timeout => 5);
my $req_path = sprintf "/delay/%d", $wait_for_sec;

my $res = $furl->get("http://127.0.0.1:5000" . $req_path);

say $res->is_success;
say $res->code;
say $res->status;
say $res->message;
say $res->status_line;
say $res->content_type;
say "content-length";
say $res->content_length;
say "content";
say $res->content;
