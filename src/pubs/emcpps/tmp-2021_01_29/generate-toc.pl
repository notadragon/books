#!/bin/env perl

use strict;
use warnings;

use POSIX qw(strftime);

$|++;

=pod

From Rostislav Khlebnikov, Dec 16, 2020 11:22

Hi Mike,

we're "hacking" latex to make it what we need it to do regarding the table of
contents.  Our conclusion is that at this stage the easiest thing to do is to
write a wrapper script that will do some manipulations with the files latex
produces.  John suggested that you could do this for us.  The script seems very
simple to create, but let me know if there are some roadblocks.  Please choose
the language you think is most suitable for the task (as long as it is easily
runnable on Mac which Lori uses).

Please find attached the "test files" - they are quite messy, but should serve
the purpose.

Likely the script will have 2 inputs: the main input file (<input>) and the
"box width" (<width>), both simple strings.

The steps:

Run xelatex <input>.tex

Open <input>.tex file, and find all sections in it and files it includes:

    Ignore any line that is a comment (starts with %)

    if the line starts with \include - just treat it as a textual inclusion of a
    file with name in {} and .tex extension.

    A "section" is a line starting with \section, followed by stuff in [],
    followed by stuff in {}, e.g.:
      \section[{\tt constexpr} Functions]{The {\SecCode constexpr} Functions}
              |<-- green -------------->||<-- yellow ---------------------->|

    There might be some stuff after the yellow part, but it can be safely
    ignored.

    Note that we need to make sure the curlies are balanced to detect where the
    yellow part actually finishes. The green part is less likely to have nested
    [], but it probably won't hurt to ensure balance either.

    Green part is "short name", yellow part is the "long name".

    In the long name, replace \SecCode with \tt

    Add short-name to long-name mapping to a map

Open the <input>.toc file that should have been produced by xelatex

For each line of form \contentsline {section}{short name}{30}
    If short name is not in the map - do nothing

    Else, replace short name with: \makebox[<width>][l]{short name} long name

    Be careful when matching, there might be nested curlies in the "short name"
    (need balance again)

Write the modified '.toc' file (either overwrite or any arbitrary name will
do). I'll refer to it as tocfile.toc

In <input>.tex, replace (one) line starting with \tableofcontents with \input
tocfile.toc, save the modified file to a temporary file (e.g., texfile.tex)

Run xelatex texfile.tex - this should produce a pdf.

The pdf should have in its table of contents in chapters 1, 2, and 3, sections
that have both short name and long name, both neatly aligned (with the example
script command line of, say, the-script EMCS-testfile 40mm)

=cut

=pod
From Rostislav Khlebnikov, Dec 16,72020 12:19

Hi Lori, Mike,

let's keep the script as simple as possible and not have it try to handle every potential situation that might arise with any valid tex.

I talked to Lori again and here's an updated list of requirements:

* Chapter 0 and Chapter 4 sections might have form \section[Short]{Long}.  We
  need to filter them out and ignore them entirely when processing TOC.  It's
  up to you how to handle this - e.g., you could ignore the \include command
  that mention Ch0 or Ch4, or track the "current chapter" when processing the
  toc file (which is probably more robust).

* All Chapter 1-3 sections must have the form \section[Short]{Long}.  If they
  don't - this is a bug in the tex file, the script shouldn't care (at least
  for now, we can "warn" later if we'd like)

* The long section names should be transferred to the "toc" with the following
  modifications:
    * Replace \SecCode with \tt
    * Replace \sfbsectionitalRomeo with \it
    * If there is a \sectionmark{stuff}, it should be removed (same rules for
      balanced curlies)
    * Nothing else! Any \ttfamily \sffamily \itshape, etc. need no modification.

* Short section names should be left as they appear in the 'toc' file after
  latex generated it, no modifications.

* A duplicated short section name is (and will always be) a BUG in the tex
  file.  I suggest printing an error and halting execution so it doesn't go
  unnoticed.

Please let me know if there are any questions remaining at this point.

Thank you,
  Slava.
=cut

=pod
    From perlre:
        The following pattern matches a function "foo()" which may contain
        balanced parentheses as the argument.
=cut

my $timestamp = strftime("%Y%m%d-%H%M%S", localtime);

my $sectionNamesRE = qr!
              ^                 # start of line
              \s*               # optional whitespace
              \\section
              \s*               # optional whitespace

              # The "green" section, in brackets
              (                 # paren group 1 (green)
              (                 # paren group 2 (possibly nested brackets)
                \[              # opening bracket
                  (             # paren group 3 (contents of brackets)
                  (?:
                   (?> [^\[\]]+ ) # Non-brackets without backtracking
                  |
                   (?2)         # Recurse to start of bracket group 2
                  )*
                  )
                \]              # closing bracket
              )
              )

              \s*               # optional whitespace

              # The "yellow" section, in braces
              (                 # paren group 4 (yellow)
              (                 # paren group 5 (possibly nested braces)
                \{              # opening bracket
                  (             # paren group 6 (contents of braces)
                  (?:
                   (?> [^{}]+ ) # Non-brackets without backtracking
                  |
                   (?5)         # Recurse to start of brace group 5
                  )*
                  )
                \}              # closing brace
              )
              )

          !x;


my $contentslineNamesRE = qr!
              ^                 # start of line
              \s*               # optional whitespace
              \\contentsline
              \s*               # optional whitespace

              {section}

              \s*               # optional whitespace

              # The "short name" section, in braces
              (                 # paren group 1 (yellow)
              (                 # paren group 2 (possibly nested braces)
                \{              # opening braces
                  (             # paren group 3 (contents of braces)
                  (?:
                   (?> [^{}]+ ) # Non-brackets without backtracking
                  |
                   (?2)         # Recurse to start of braces group 2
                  )*
                  )
                \}              # closing braces
              )
              )

          !x;


if (@ARGV && $ARGV[0] eq '--test') {
    testMatches();
    exit 0;
}

my $debug = 0;
my $runXelatex = 1;

if (@ARGV > 0 && $ARGV[0] eq "-d") {
    $debug = 1;
    shift @ARGV;
}

if (@ARGV > 0 && $ARGV[0] eq "-noxelatex") {
    $runXelatex = 0;
    shift @ARGV;
}

if (@ARGV < 2 || @ARGV > 4) {
    print "USAGE: $0 [-d] [-noxelatex] inputName width [\"formattingString\"] [\"ttFormattingString\"]\n";
    print "  -d (optional): print debug traces\n\n";
    print "  -noxelatex (optional): don't run xelatex before/after processing\n";
    print "  inputName:         base name of input .tex file (without path or ext)\n";
    print "  width:             boxwidth for TOC entries (e.g., \"4cm\")\n\n";
    print " formattingString:   optional formatting string for short entries,\n",
          "                     default is \"\\large\\bfseries\".\n",
          "                     Pass \"\" to use default LaTeX formatting.\n";
    print " ttFormattingString: optional formatting string for short entries ",
          "containing \\tt.\n",
          "                     default is \"\\ttfamily\\bfseries\".\n",
          "                     Pass \"\" to use default LaTeX formatting.\n",
          "                     You need to pass a value for ",
          "formattingString\n",
          "                     to set this argument.\n";

    print "Note that this script must be run with a current working\n";
    print "directory set to the location of the files\n\n";
    print "By default, xelatex will be run before and after processing, unless\n";
    print "the '-noxelatex' flag is passed in.\n";

    exit 1;
}

my ($basename,
    $width,
    $shortEntryFormatString,
    $shortEntryTTFormatString) = (@ARGV,
                                  '\large\bfseries',
                                  '\ttfamily\bfseries');

# Make sure the format string has a trailing space if it's not empty
$shortEntryFormatString.=" " if length($shortEntryFormatString) > 0
                             && $shortEntryFormatString!~/\s$/;

my %filesToSkip = (
    'Ch0.tex' => 1,
    'Ch4.tex' => 1,
);

sub openFile {
    my ($fdArray_r, $filename) = @_;
    if (exists $filesToSkip{$filename}) {
        print "Skipping $filename\n" if $debug;
        return;
    }

    print "Opening $filename\n" if $debug;

    open(my $fh, "<", $filename) or do {
        warn "**** Skipping opening $filename: $!";
        return -1;
    };
    push @$fdArray_r, $fh;
}

sub writeFile {
    my ($filename, $dataArray_r) = @_;
    open(my $outputFD, ">", "$filename") or
                                  die "Can't open $filename, error $!";
    print $outputFD @$dataArray_r;
    close($outputFD);

    print "WROTE $filename\n";
}

sub saveFiles {
    my ($basename, $passname) = @_;

    foreach my $ext(qw(.toc .tex .pdf)) {
        system("cp $basename$ext $basename-$passname$ext");
        print "### backed up $basename$ext as $basename-$passname$ext\n";
    }
}

sub runXelatex {
    my ($basename, $pass) = (@_, "");

    return unless $runXelatex;

    $pass= "__$pass" if length($pass);

    my $logfile = "${basename}${pass}__${timestamp}.log";

    saveFiles($basename, "pre--$pass");

    system("xelatex ${basename}.tex > $logfile 2>&1");

    saveFiles($basename, "post--$pass");

    print "### xelatex invocation for ${basename}.tex done - see $logfile\n";
}

sub main {
    my ($basename, $width) = @_;

    #runXelatex($basename, "pre-processing-pass-1");
    #runXelatex($basename, "pre-processing-pass-2");
    runXelatex($basename, "pre-processing");

    my %nameMapping;
    my @fdArray;
    openFile(\@fdArray, "${basename}.tex");

    while (@fdArray) {
        while(1) {
            my $fd = $fdArray[-1];
            $_ = <$fd>;
            last unless defined($_);

            if (/^\s*\\include\{([^\}]+)\}/) {
                openFile(\@fdArray, "$1.tex");
                next;
            }

            if (/$sectionNamesRE/) {
                my ($greenShortName, $yellowLongName) = ($3, $6);

                #$greenShortName=~s/\\sffamily\\itshape/\\it/g;
                #$greenShortName=~s/\\ttfamily/\\tt/g;

                $yellowLongName=~s/\\SecCode/\\tt/g;
                $yellowLongName=~s/\\sfbsectionitalRomeo/\\it/g;
                $yellowLongName=~s/\\sectionmark.*//;
                #$yellowLongName=~s/\\ttfamily/\\tt/g;

                print "SECTION input >>$_",
                      "        short >>$greenShortName\n",
                      "        long  >>$yellowLongName\n" if $debug;

                if (exists $nameMapping{$greenShortName}) {
                    warn "***** Duplicate short name, skipping: ",
                         "$greenShortName -> $yellowLongName";
                    next;
                }

                $nameMapping{$greenShortName} = $yellowLongName;
            }
            elsif (/^\s*\\section\[/) {
                warn "ILL-FORMED \\section: <<$_>>";
            }

        }
        close($fdArray[-1]);
        pop @fdArray;
    }

    my $outputName = "${basename}__".$timestamp;

    open(my $tocFD, "<", "${basename}.toc") or
                                    die "Can't open ${basename}.toc, error $!";
    my @toclines = <$tocFD>;
    close($tocFD);

    foreach (@toclines) {
        if (/$contentslineNamesRE/) {
            my $bracedShortName = $1;
            my $shortName = $3;

            print "CONTENTSLINE input  >>$_",
                  "             short  >>$shortName\n",
                  "             braced >>$bracedShortName\n" if $debug;

            my $longName;

            if (exists $nameMapping{$shortName}) {
                $longName//=$nameMapping{$shortName};
                delete $nameMapping{$shortName};
            }

            if (exists $nameMapping{$bracedShortName}) {
                $longName//=$nameMapping{$bracedShortName};
                delete $nameMapping{$bracedShortName};
            }

            if (defined $longName) {
                my $reformattedShortName = $shortName;
                if($reformattedShortName=~s!\\tt(?:family)?!$shortEntryTTFormatString!g)      {
                    print "&&& $shortName -> $reformattedShortName\n" if $debug;
                }
                s!\Q$shortName\E}!\\makebox[$width][l]\{${shortEntryFormatString}$reformattedShortName\} $longName}!;
            }
            else {
                warn " *** no match for <<$shortName>> or <<$bracedShortName>> in mapping";
            }
        }
    }

    if (scalar keys %nameMapping) {
        print "!!!! The following sections are NOT in the TOC:\n";
        foreach my $shortName(sort keys %nameMapping) {
            printf "\t%30s -> %s\n",$shortName, $nameMapping{$shortName};
        }
    }

    my $outTocName="${outputName}.toc";

    writeFile($outTocName, \@toclines);

    open(my $texFD, "<", "${basename}.tex") or
                                    die "Can't open ${basename}.tex, error $!";
    my @texlines = <$texFD>;
    close($texFD);

    for (my $idx = 0; $idx <= $#texlines; ++$idx) {
        $_ = $texlines[$idx];
        print "TeXline: $_" if $debug;
        next unless m!^\s*\\tableofcontents(\s+|$)!;
        splice @texlines,
               $idx+1,
               0,
               qq!\\input\{$outTocName\}   % inserted after \\tableofcontents by $0\n!;
        #splice @texlines,
        #       $idx,
        #       1,
        #       (
        #           #"\\chapter*{Contents}\n",
        #           #"\\contentsname\n",
        #           qq!\\input\{$outTocName\}   % substituted for \\tableofcontents by $0\n!
        #       );

        last;
    }

    my $outTexName="${outputName}.tex";

    writeFile($outTexName, \@texlines);

    runXelatex($outputName, "final-processing-pass-1");
    # Rewrite TOC file to undo any changes \tableofcontents made
    writeFile($outTocName, \@toclines) if $runXelatex;
    runXelatex($outputName, "final-processing-pass-2");
}

main($basename, $width);

exit 0;

sub testMatches {
    my @testStrings=(
        '\section[A {\sffamily\itshape Conditionally Safe} Feature]{A {\sfbsectionitalRomeo Conditionally Safe} Feature}',
        '\section[A {\sffamily\itshape Safe} Feature]{A {\sfbsectionitalRomeo Safe} Feature}',
        '\section[An {\sffamily\itshape Unsafe} Feature]{An {\sfbsectionitalRomeo Unsafe} Feature}',
        '\section[The {\sffamily\itshape EMC++S} White Paper]{The {\sfbsectionitalRomeo EMC++S} White Paper}',
        '\section[{What Do We Mean by {\sffamily\itshape Safely}?}]{What Do We Mean by {\sfbsectionitalRomeo Safely}?}',
        '\section[Attribute Syntax]{Generalized Attribute Syntax}\label{attributes}\sectionmark{Attributes}',
        '\section[Binary Literals]{Binary Literals}\label{binary-literals}\sectionmark{Binary Literals}',
        '\section[Consecutive {\tt >}s]{Consecutive Right-Angle Brackets}\label{consecutive-right-angle-brackets}\sectionmark{Adjacent {\tt >}s}',
        '\section[Deleted Functions]{Using {\SecCode =delete} for Arbitrary Functions}\label{deleted-functions}',
        '\section[Short Title]{Longer Wordier Feature Title}\label{Feature}\label{testmaterial}',
        '\section[Trailing Return]{Trailing Function Return Types}\label{trailing-function-return-types}',
        '\section[\tt{alignas}]{The {\SecCode alignas} Decorator}\label{alignas}',
        '\section[{\tt decltype}]{Operator for Extracting Expression Types}\label{decltype}',
        '\section[{\tt override}]{The {\SecCode override} Member-Function Specifier}\label{override}',
        '\section[{\tt static\_assert}]{Compile-Time Assertions}\label{compile-time-assertions-(static_assert)}',
        '\section[{union} \'11]{Unions Having Non-Trivial Members}\label{unrestricted-unions}',
        '\section[Braced Initialization]{Braced Initialization}\label{bracedinit}',
        '\section[{\tt auto}]{{\SecCode auto}}\label{auto-feature}',
        '\section[Default Member Initializers]{Default Member Initializers}\label{Default-Member-Initializers}',
        '\section[Forwarding References]{Forwarding References\sectionmark{Forwarding References}}\label{forwardingref}',
        '\section[Generic Lambdas]{Generic Lambdas\sectionmark{Generic Lambdas}}\label{genericlambda}',
        '\section[Lambdas]{Lambda Expressions\sectionmark{Lambdas}}\label{lambda}',
    '\section[Rvalue References]{Rvalue References}\label{Rvalue-References}',
    '\section[Short Title]{Longer Wordier Title for Test\sectionmark{RH Version of Title}}\label{justfortest}\sectionmark{RH Version of Title}',
    '\section[Variadic Templates]{Variadic Templates}\label{variadictemplate}',
    '\section[{\tt noexcept}]{{\SecCode noexcept}}\label{noexcept}',
    '\section[{\ttfamily constexpr} Functions]{{\SecCode constexpr} Functions}\label{constexprfunc}',
    '\section[{\ttfamily constexpr} Variables]{{\SecCode constexpr} Variables}\label{constexprvar}',
     '\section[Deduced Return Type]{Function ({\SecCode auto}) {\SecCode return}-Type Deduction}\label{Function-Return-Type-Deduction}',
    '\section[{\tt noreturn}]{The {\SecCode [[noreturn]]} Attribute}\label{the-noreturn-attribute}',
     '\section[{\tt carries\_dependency}]{The {\SecCode [[carries\_dependency]]} Attribute}\label{carriesdependency}',
    '\section[{\tt deprecated}]{The {\SecCode [[deprecated]]} Attribute}\label{deprecated}\label{the-standard-[[deprecated]]-attribute}',
);

    printf "Testing %d strings... ", (scalar @testStrings);
    foreach my $testString(@testStrings) {
        if ($testString!~/$sectionNamesRE/) {
            die "Test match FAILED!\n String:\n$testString\n";
        }
    }
    printf "PASSED!\n";
}

## ---------------------------------------------------------------------------
## NOTICE:
##      Copyright (C) Bloomberg L.P., 2020
##      All Rights Reserved.
##      Property of Bloomberg L.P. (BLP)
##      This software is made available solely pursuant to the
##      terms of a BLP license agreement which governs its use.
## ----------------------------- END-OF-FILE ---------------------------------
