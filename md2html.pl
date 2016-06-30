#!/usr/bin/env perl
use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;
use Text::Markdown 'markdown';

undef $/; # slurp mode for all


my $css_file = '' ;
my $nocss ;
my $stdout ;

GetOptions(
    'css=s' => \$css_file, 
    'nocss' => \$nocss, 
    'stdout' => \$stdout
) or print "&usage()";

# md2html.pl in.md 
# md2html.pl --css example.css input.md
# md2html.pm --nocss input.md
# md2html.pm --stdout input.md (ne crée pas input.md.html)

my $html_begin = <<'HTMLBEGIN';
<!DOCTYPE html>
<html>
<head>
<style>
HTMLBEGIN


my $html_middle = <<'HTMLMIDDLE';
</style>
</head>
<body>
HTMLMIDDLE

my $html_end = <<'HTMLEND';
</body>
</html>
HTMLEND

my $css_data = <<'CSS';
@charset "utf-8";

/**
 * markdown.css
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see http://gnu.org/licenses/lgpl.txt.
 *
 * @project      Weblog and Open Source Projects of Florian Wolters
 * @version      GIT: $Id$
 * @package      xhtml-css
 * @author       Florian Wolters <florian.wolters.85@googlemail.com>
 * @copyright    2012 Florian Wolters
 * @cssdoc       version 1.0-pre
 * @license      http://gnu.org/licenses/lgpl.txt GNU Lesser General Public License
 * @link         http://github.com/FlorianWolters/jekyll-bootstrap-theme
 * @media        all
 * @valid        true
 */

body {
    font-family: Helvetica, Arial, Freesans, clean, sans-serif;
padding:1em;
margin:auto;
max-width:42em;
background:#fefefe;
}

h1, h2, h3, h4, h5, h6 {
    font-weight: bold;
}

h1 {
    color: #000000;
    font-size: 28px;
}

h2 {
    border-bottom: 1px solid #CCCCCC;
    color: #000000;
    font-size: 24px;
}

h3 {
    font-size: 18px;
}

h4 {
    font-size: 16px;
}

h5 {
    font-size: 14px;
}

h6 {
    color: #777777;
    background-color: inherit;
    font-size: 14px;
}

hr {
    height: 0.2em;
    border: 0;
    color: #CCCCCC;
    background-color: #CCCCCC;
}

p, blockquote, ul, ol, dl, li, table, pre {
    margin: 15px 0;
}

code, pre {
    border-radius: 3px;
    background-color: #F8F8F8;
    color: inherit;
}

code {
    border: 1px solid #EAEAEA;
    margin: 0 2px;
    padding: 0 5px;
}

pre {
    border: 1px solid #CCCCCC;
    line-height: 1.25em;
    overflow: auto;
    padding: 6px 10px;
}

pre > code {
    border: 0;
    margin: 0;
    padding: 0;
}

a, a:visited {
    color: #4183C4;
    background-color: inherit;
    text-decoration: none;
}


CSS


$css_data = '' if $nocss ;
if ($css_file and -e $css_file) {
    open (my $cssf, "<", $css_file)
        or die "Impossible d'ouvrir '$css_file' : $!";
    $css_data = <$cssf>; # slurp mode enable with 'undef $/' before
    close($cssf);
}

while (<>) {
    # slurp mode enable with 'undef $/' before (see line 9)
    my $fhout;
    if ($stdout!=1 and $ARGV ne '-') {
        open($fhout,">",$ARGV.'.html')
            or die "Impossible d'ouvrir '$ARGV.html' : $!";
    } else {
        $fhout = \*STDOUT;
    }
    print $fhout 
        $html_begin,
        $css_data,
        $html_middle,
            markdown($_),
        $html_end;

    close($fhout) if ($stdout!=1 and $ARGV ne '-') ;
}

