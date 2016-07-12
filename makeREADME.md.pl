#!/usr/bin/env perl
use strict;
use warnings;

use Pod::Markdown;

Pod::Markdown->new->filter('./md2html');


# usage : In md2html folder, run 'perl makeREADME.md.pl > README.md'
