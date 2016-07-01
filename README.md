# NAME

md2html - convert markdown file to html file 

# SYNOPSIS

md2html \[options\] \[file1 \[file2 ...\]\]

    Options:
      -h --help            brief help message
      -m --man             full documentation
      -c --css             use a specific CSS file
      -n --nocss           don't use defaut CSS file
      -s --stdout          use STDOUT instead of creating a new file
      -f --force           write HTML file, even if it already exists

# DESCRIPTION

md2html converts markdown files and produces new HTML files using
a defaut CSS style, appending `.html` to each filename (with same
path).

# OPTIONS

- **--help**

    Print a brief help message.

    `md2html --help`

- **--man**

    Print the manual page.

    `md2html --man`

- **--css**

    Use a specific CSS file.

    `md2html --css mycssfile.css path-to/myfile.md [myfile2.md...]`

- **--nocss**

    Use a specific CSS file.

    `md2html --nocss myfile.md [myfile2.md...]`

- **--stdout**

    Don't create HTML file. Write to STDOUT.

    `md2html --stdout myfile.md [myfile2.md...]`

    To create HTML file in another folder:

    `md2html --stdout path/myfile.md > other-path/myname.html`

- **--force**

    Don't skip markdown file when HTML file already exists.

    `md2html --force myfile.md` write myfile.md.html
    even if it exists.

- STDIN

    md2html can read STDIN. If so, it writes to STDOUT.

    `cat somefile | md2html [options]`

    `cat somefile | md2html [options] > myfile.html`
