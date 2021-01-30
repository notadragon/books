%T%<% bookname = pub.config.get("book", "name") %>

%!TEX TS-program = xelatex 
%!TEX encoding = UTF-8 Unicode






% Options for packages loaded elsewhere
% \PassOptionsToPackage{unicode}{hyperref}
% \PassOptionsToPackage{hyphens}{url}


%

% \documentclass[
% % % % % % ]{report}

% PEARSON
\documentclass[twoside,10pt,letterpaper,usenames]{newstyle-PearsonGeneric-7-38-ROMEO}
\usepackage[twoside]{geometry} % to set the dimensions of the page

% PEARSON
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

% PEARSON
%%%%%%%% Skip over this part.  These lines should remain unaltered.
%
%%    These lines input packages that are used for this template.
\usepackage[letter,cam,center]{crop-AlteredCamMarks-Romeo}  % to add trim marks; updated Nov 2015 to allow more space between marks and trim edge
\usepackage{graphicx} % for graphics layout

%T%% for f in pub.outline.sectionfiles("book_preamble"):
\input{${f}}
%T%% endfor

%%% LORI

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\fncodeincomments}{\color{grey}\ttfamily}
\newcommand{\emphincomments}{\color{purple}\ttfamily\itshape}
%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\authorsnote}{Authors' Note: }
%\newcommand{\intraref}[1]{{\textit{#1}}}
\newcommand{\intrarefsub}[1]{\textit{#1}}  % needed for V's markdown conversion


\usepackage[stable,bottom,multiple]{footmisc} % to stabilize the footnote environment and to ensure footnotes
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
\usepackage{tocloft-hacked-PearsonGeneric-ROMEO} % to allow manipulation of the TOC
\frenchspacing



%%%%%%%% Determine your indexing plan.
%
% Most of the time, the publisher will hire an independent indexing expert to create an
%    index for your book.  Your production editor can let you know the plan for your book.
% Use the line below only if your production plan includes the creation of a LaTeX index.
% Note that this situation is uncommon.
%\makeindex           % if your book will include a LaTeX-generated index
%\usepackage{See-makeidx}

%%%%%%%%%% These lines set up the Preamble of the document. You can skip over this part.
%% Preamble:
\input{definitions-PearsonGeneric-ROMEO}  % Loading the definitions needed for this book:

%%%%%%%%%%CHANGED FOR ROMEO
\setcounter{secnumdepth}{0}

% Required for PANDOC conversion
\newcommand{\passthrough}[1]{#1}
%
%% Hack to allow PANDOC to parse Markdown in inline LaTeX environments
\let\Begin\begin
\let\End\end

% PANDOC stuff
%\IfFileExists{upquote.sty}{\usepackage{upquote}}{}
%\IfFileExists{microtype.sty}{% use microtype if available
%  \usepackage[]{microtype}
%  \UseMicrotypeSet[protrusion]{basicmath} % disable protrusion for tt fonts
%}{}
%\makeatletter
%\@ifundefined{KOMAClassName}{% if non-KOMA class
%  \IfFileExists{parskip.sty}{%
%    \usepackage{parskip}
%  }{% else
%    \setlength{\parindent}{0pt}
%    \setlength{\parskip}{6pt plus 2pt minus 1pt}}
%}{% if KOMA class
%  \KOMAoptions{parskip=half}}
%\makeatother
%\usepackage{xcolor}
% \IfFileExists{xurl.sty}{\usepackage{xurl}}{} % add URL line breaks if available

% \IfFileExists{bookmark.sty}{\usepackage{bookmark}}{\usepackage{hyperref}}
% \hypersetup{
% % % % % % %   hidelinks,
% %   pdfcreator={LaTeX via pandoc}}


% \urlstyle{same} % disable monospaced font for URLs


% 
% 


%\setlength{\emergencystretch}{3em} % prevent overfull lines
%\providecommand{\tightlist}{%
%\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

% 




%%%%%%%%% Now the document begins

\begin{document}
\input{cft-definitions-PearsonGeneric-ROMEO} % Loading a few commands related to the tocloft package

\renewcommand{\thelstlisting}{\thesection--\arabic{lstlisting}}  %%% Romeo - reset listings per section


%%%%% The front matter begins:
\pagenumbering{roman}             % Roman numbering
\setcounter{page}{1}                    % Starting page number (specified by the publisher)
\cleardoublepage                         % This command is defined in our documentclass file. It tells 
                                                      % our compiler that we want the next item 
                                                       % to start on a right-hand page, and it inserts a blank left-hand 
                                                       % page if needed.    
\include{emcppsc-half-title}                        % The half-title page
\include{emcppsc-series}                             % A placeholder for the series page. The publisher normally 
%                                                       % creates this page and just adds it into the final PDF. 
\include{emcppsc-title}                               % The title page
\include{emcppsc-CIP}                                % The cataloging-in-publication page
\include{emcppsc-dedication}                      % The dedication page

%T%% for f in pub.outline.sectionfiles("book_front"):
\include{${f}}
%T%% endfor

\cleardoublepage                
\parskip 0in                         % Reset to zero interpar spacing
\include{emcppsc-foreword}               % Add foreword
\include{emcppsc-preface}                 % Add preface 
\include{emcppsc-ack}                        % Add acknowledgements 
\include{emcppsc-author}                   % Add about the author page
\cleardoublepage                  
%%%%%%%The front matter ends

\pagenumbering{arabic}		  % Arabic numbering
%T%% for f in pub.outline.sectionfiles("book_body"):
\input{${f}}
%T%% endfor

\cleardoublepage
%
%
\cleardoublepage
%%\bibliographystyle{ieeetr-hacked}
\bibliographystyle{lakos}
\bibliography{emcs}
\nocite{*}
%\cleardoublepage
%\include{EMCS-bib}
\cleardoublepage
%\include{glossary-test2}
%
%%\nocite{*}
%
\cleardoublepage
\include{emcppsc-index}

%T%% for f in pub.outline.sectionfiles("book_back"):
\input{${f}}
%T%% endfor

% 
% %
% 
% 
\end{document}
