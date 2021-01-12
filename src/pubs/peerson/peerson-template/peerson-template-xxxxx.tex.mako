% Root File for Prentice-Hall Book
%         11 point version
% Root file for Pearson Generic book
%   **** Trim size 9 x 7 ****
%
%   Prepared for LaTeX2e February, 1997
%   Derived from LaTeX 2.09 version
%  ** Updated for Style June 2002 **
%  ** Updated for Style January 2010 **
%  ** Updated with minor corrections Nov 2015 **

%%%%%%%%%% First, determine and select the trim size of the book
%
% Pearson uses three basic trim sizes.  Ask your Production Editor which one will be used for your book.
% If your book will be 7 inches wide, use that documentclass statement and comment out the other one.
% If your book will be 7 and 3/8 inches wide, use that documentclass statement and
%            comment out the other one.

%T%<% bookname = pub.config.get("book", "name") %>

%T%% if pub.config.get("book","trim") in [ "1", "2" ]:
\documentclass[twoside,10pt,letterpaper,usenames]{${pub.config.get("book","style",fallback="newstyle-PearsonGeneric-7")}}
%T%% elif pub.config.get("book","trim") == "3":
\documentclass[twoside,10pt,letterpaper,usenames]{${pub.config.get("book","style",fallback="newstyle-PearsonGeneric-7-38")}}
%T%% endif

%T%% for f in pub.outline.sectionfiles("initial"):
\include{${f}}
%T%% endfor

\usepackage[twoside]{geometry} % to set the dimensions of the page

%%%%%%%% Then, also select the trim size of the book here.
%
%    Uncomment the appropriate trim size for your book, and comment-out the others.
%T%% if pub.config.get("book","trim") == "1":
%% Trim Size 1:  7 x 9
\geometry{                           % setting all the necessary dimensions...
paperwidth=7in,                  % Do not change these settings.
paperheight=9in,                 % These set up the trim size for the book.
lmargin=1in,
rmargin=.75in,
bmargin=.525in,
tmargin=.95in,
width=5.25in,
height=7.525in,
marginparwidth=0in,
marginparsep=0in,
headheight=0.2in,
headsep=.25in,
footskip=.025in}
%T%% elif pub.config.get("book","trim") == "2":
%%%%%%%%%%%%% Trim Size 2:  7 x 9 1/8
\geometry{                           % setting all the necessary dimensions...
paperwidth=7in,                  % Do not change these settings unless you.
paperheight=9.125in,          % These set up the trim size for the book.
lmargin=1in,
rmargin=.75in,
bmargin=.65in,
tmargin=.95in,
width=5.25in,
height=7.4in,
marginparwidth=0in,
marginparsep=0in,
headheight=0.2in,
headsep=.25in,
footskip=.025in}
%T%% elif pub.config.get("book","trim") == "3":
%%%%%%%%%%%%%% Trim Size 3:  7 3/8 x 9 1/8
\geometry{                                  % setting all the necessary dimensions...
paperwidth=7.375in,                  % Do not change these settings.
paperheight=9.125in,                 % These set up the trim size for the book.
lmargin=1in,
rmargin=.875in,
bmargin=.650in,
tmargin=.95in,
width=5.5in,
height=7.4in,
marginparwidth=0in,
marginparsep=0in,
headheight=0.2in,
headsep=.25in,
footskip=.025in}
%%%%%%%%%%%%%%%%%%%%%
%T%% endif

%%%%%%%% Skip over this part.  These lines should remain unaltered.
%

\usepackage{amsmath} % to ensure attractive mathematics
\usepackage{amsfonts} % to ensure attractive mathematics
\usepackage{amssymb} % to ensure attractive mathematics

%%    These lines input packages that are used for this template.
\usepackage[letter,cam,center]{crop-AlteredCamMarks}  % to add trim marks; updated Nov 2015 to allow more space between marks and trim edge
\usepackage{graphicx} % for graphics layout
\usepackage{float}    % to allow things to float even if they normally don't
\usepackage{wrapfig}  % to allow text to wrap around small figures
\usepackage{outline}  % to allow outline creation
\usepackage{framed-PearsonGeneric} % to create the leftside vertical bar for the example environment
% The listings package isn't included in the template folder because
%       it is part of any up-to-date TeX installation
\usepackage{listings} % for setting attractive computer code
\lstset{basicstyle=\ttfamily\small,framerule=0.5pt} % setting the code in small sans serif font and
                                                    % setting the margin for the code.  Nov 2015: setting the rules to be 0.5pt
\usepackage[stable,bottom]{footmisc} % to stabilize the footnote environment and to ensure footnotes
                                     % appear at the bottom of the page, even if a figure or table
                                     % appears at the bottom
\usepackage[flushleft]{threeparttable} % to set attractive footnotes within table environments
\usepackage{titleref} % to allow cross-referencing by title
\usepackage{xr} % to allow cross-referencing between files
\usepackage{colortbl} % to allow the use of color/shading in tables
\usepackage{caption} % to set the appearance of captions
\captionsetup[table]{singlelinecheck=off,labelfont={sf,bf,small},font={sf,bf,small}}
\captionsetup[figure]{labelfont={sf,bf,small},font={sf,bf,small}}
\captionsetup[lstlisting]{labelfont={sf,bf,small},font={sf,bf,small}}
\usepackage{tocloft-hacked-PearsonGeneric} % to allow manipulation of the TOC


%%%%%%%% Determine your indexing plan.
%
% Most of the time, the publisher will hire an independent indexing expert to create an
%    index for your book.  Your production editor can let you know the plan for your book.
% Use the line below only if your production plan includes the creation of a LaTeX index.
% Note that this situation is uncommon.
\makeindex           % if your book will include a LaTeX-generated index
\usepackage{See-makeidx}

%%%%%%%%%% These lines set up the Preamble of the document. You can skip over this part.
%% Preamble:
\input{definitions-PearsonGeneric}  % Loading the definitions needed for this book

%T%% for f in pub.outline.sectionfiles("preamble"):
\include{${f}}
%T%% endfor

%%%%%%%%%  You will need to enter the file names of all your chapter files here.
% These lines tell the xr package what chapters need to cross-reference one another.
% You'll need to add your chapter file names here
%T%% for section in [ "initial", "front", "body", "appendix" ]:
%T%% for f in pub.outline.sectionfiles(section):
\externaldocument{${f}}
%T%% endfor
%T%% endfor

%%%%%%%%% Now the document begins

\begin{document}
\input{cft-definitions-PearsonGeneric} % Loading a few commands related to the tocloft package

%%%%% The front matter begins:
\pagenumbering{roman}             % Roman numbering
\setcounter{page}{1}              % Starting page number (specified by the publisher)
\cleardoublepage                  % This command is defined in our documentclass file. It tells
                                  % our compiler that we want the next item
                                  % to start on a right-hand page, and it inserts a blank left-hand
                                  % page if needed.
\include{${bookname}-half-title}              % The half-title page
\include{${bookname}-series}                  % A placeholder for the series page. The publisher normally
                                  % creates this page and just adds it into the final PDF.
\include{${bookname}-title}                   % The title page
\include{${bookname}-CIP}                     % The cataloging-in-publication page
\include{${bookname}-dedication}              % The dedication page

\cleardoublepage
\parskip .5ex                     % Add space between Contents items
\tableofcontents                  % Make the Table of Contents
\cleardoublepage
\parskip 0in                      % Reset to zero interpar spacing

\include{${bookname}-foreword}                % Add foreword
\include{${bookname}-preface}                 % Add preface
\include{${bookname}-ack}                     % Add acknowledgements
\include{${bookname}-author}                  % Add about the author page

%T%% for f in pub.outline.sectionfiles("front"):
\include{${f}}
%T%% endfor

\cleardoublepage
%%%%%%%The front matter ends

%%%%%%%%%% Now we'll start on the main text for the book.
%% Main Text:
\pagenumbering{arabic}     % Arabic numbering
%T%% for f in pub.outline.sectionfiles("body"):
\include{${f}}
%T%% endfor

% Repeat this command for each part, chapter, or glossary file.
%
%%%%% End main text


%%%%%%%%%% Back matter starts
%
% If your book contains appendices, you will need to add those here.
%T%% if pub.outline.sectionfiles("appendix"):
\appendix               % Change to appendix numbering
%T%% for f in pub.outline.sectionfiles("appendix"):
\include{${f}}
%T%% endfor
%T%% endif

\cleardoublepage
\bibliographystyle{ieeetr-hacked}  % Your production editor and copy editor may want you to
                                   % use a different bibliography style file.
                                   % You can input that style file here.
%\bibliography{${",".join(pub.outline.sectionfiles("bib"))}}  % Loading the bibliography file.
%\nocite{*}  % \nocite is used because no citations appear in this sample text

\cleardoublepage
\printindex   % If your book will include a LaTeX-generated index, you'll include it with this line.
%
%T%% for f in pub.outline.sectionfiles("back"):
\include{${f}}
%T%% endfor
%%%%%%% Back matter ends


\end{document}

