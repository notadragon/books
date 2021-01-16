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

%%%%%%%%%%%%%%%%% ROMEO- Running Heads
% Set up RHs for frontmatter and Ch0; they will have to be altered again for Chs 1-3 and then revert to this again for Ch4
\usepackage{fancyhdr}
\usepackage{extramarks}
\newcommand{\cppxx}{C++xx}
\newcounter{cppxx}[chapter]
\pagestyle{fancy}
% for fancy pages, i.e., most pages
\rfoot[\fancyplain{}{\hspace{\fill}\\ \sfnine\thepage\hfill}]{\fancyplain{\hspace{\fill}\\ \sfnine\thepage}{\hspace{\fill}\\ \sfnine\thepage}}
\lfoot[\fancyplain{\bf\thepage}{}]{\fancyplain{}{}}
\cfoot[\fancyplain{}{}]{\fancyplain{}{}}
%\renewcommand{\sectionmark}[1]{\markright{{\sfnine\thesection\ #1}}} 
\renewcommand{\sectionmark}[1]{\markright{{\sfnine\ #1}}} % to remove section number   \sfnine
\renewcommand{\chaptermark}[1]{\markboth{{\sfb Chapter~\thechapter\quad {\sfb #1}}}{}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\chaptersmark}[1]{\markboth{}{\sfb #1}}
% for plain pages, like chapter openers
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\fancyfoot[RO]{\sfnine{\thepage}} 
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
}




%%%% CHANGED FOR ROMEO
% Changing code font to Cousine
\usepackage{amsmath}
\usepackage{mathspec}
\setmonofont[Ligatures=NoCommon,Scale=.9,SlantedFont={Cousine-Italic.ttf},BoldFont={Cousine-Bold.ttf},BoldSlantedFont={Cousine-BoldItalic.ttf}]{Cousine-Regular.ttf} % to set our code font
\newfontface{\SecCode}[Ligatures=NoCommon,Scale=1.3]{Cousine-Bold.ttf}
%\newfontface{\SecCode}[Ligatures=NoCommon,Scale=1.105]{Cousine-Bold.ttf}
\newfontface{\SubsecCode}[Ligatures=NoCommon,Scale=1.2]{Cousine-Bold.ttf}
%\newfontface{\SubsecCode}[Ligatures=NoCommon,Scale=1.02]{Cousine-Bold.ttf}
\newfontface{\SubsubsecCode}[Ligatures=NoCommon,Scale=1]{Cousine-Bold.ttf}
%\newfontface{\SubsubsecCode}[Ligatures=NoCommon,Scale=.935]{Cousine-Bold.ttf}
\newfontface{\ParaCode}[Ligatures=NoCommon,Scale=.9]{Cousine-Bold.ttf}
\newfontface{\SubparaCode}[Ligatures=NoCommon,Scale=.9]{Cousine-Regular.ttf}
%\newfontface{\RHCode}[Ligatures=NoCommon,Scale=.81]{Cousine-Regular.ttf}
%\newfontface{\RHCode}[Ligatures=NoCommon,Scale=.85]{Cousine-Bold.ttf}
\newfontface{\RHCode}[Ligatures=NoCommon,Scale=1.17]{Cousine-Bold.ttf} % set at scaled .9 of 13pts
\newfontface{\RHCodeEleven}[Ligatures=NoCommon,Scale=.935]{Cousine-Bold.ttf}
%\newfontface{\RHCodeTwelve}[Ligatures=NoCommon,Scale=1.02]{Cousine-Bold.ttf}
\newfontface{\RHCodeTwelve}[Ligatures=NoCommon,Scale=1.1]{Cousine-Bold.ttf}
\newfontface{\TOCCode}[Ligatures=NoCommon,Scale=.85]{Cousine-Bold.ttf}
%\newfontface{\TOCCode}[Ligatures=NoCommon,Scale=.9]{Cousine-Bold.ttf}
\newfontface{\TOCCodeR}[Ligatures=NoCommon,Scale=.85]{Cousine-Regular.ttf}
\newfontface{\TOCCodeEleven}[Ligatures=NoCommon,Scale=.935]{Cousine-Regular.ttf}
\newfontface{\TOCCodeElevenB}[Ligatures=NoCommon,Scale=.935]{Cousine-Bold.ttf}
%\newfontface{\TOCCodeElevenB}[Ligatures=NoCommon,Scale=1.1]{Cousine-Bold.ttf}
\newfontface{\TOCCodeTwelve}[Ligatures=NoCommon,Scale=1.02]{Cousine-Regular.ttf}
\newfontface{\TOCCodeThirteen}[Ligatures=NoCommon,Scale=1.105]{Cousine-Regular.ttf}

% Changing sans serif font to OpenSans
\setsansfont[Ligatures=Common,Scale=1,SlantedFont={OpenSans-LightItalic.ttf},BoldFont={OpenSans-Bold.ttf},BoldSlantedFont={OpenSans-BoldItalic.ttf}]{OpenSans-Light.ttf} % to set our sans font
%%
\newfontface{\sfbHugeRomeo}[Ligatures=Common,Scale=2.5]{OpenSans-Bold.ttf}
\newfontface{\cmssbxparttocRomeo}[Ligatures=Common,Scale=1.2]{OpenSans-Bold.ttf}
\newfontface{\cmssbxsectionRomeo}[Ligatures=Common,Scale=1.4]{OpenSans-Bold.ttf}
\newfontface{\cmssbxelevenRomeo}[Ligatures=Common,Scale=1.1]{OpenSans-Bold.ttf}
\newfontface{\cmssbxchaptocRomeo}[Ligatures=Common,Scale=1]{OpenSans-Bold.ttf}
\newfontface{\cmssbxchaptitleRomeo}[Ligatures=Common,Scale=3.0]{OpenSans-Bold.ttf}
\newfontface{\cmsschapnameRomeo}[Ligatures=Common,Scale=2.6]{OpenSans-Light.ttf}
\newfontface{\cmssbxpartRomeo}[Ligatures=Common,Scale=4.4]{OpenSans-Bold.ttf}
\newfontface{\cmssparttitleRomeo}[Ligatures=Common,Scale=3.4]{OpenSans-Light.ttf}
\newfontface{\sfiHugeRomeo}[Ligatures=Common,Scale=2.5]{OpenSans-LightItalic.ttf}
\newfontface{\sfititleRomeo}[Ligatures=Common,Scale=2.4]{OpenSans-LightItalic.ttf}
\newfontface{\sfihalftitleRomeo}[Ligatures=Common,Scale=2.0]{OpenSans-LightItalic.ttf}
\newfontface{\sfiauthorRomeo}[Ligatures=Common,Scale=1.6]{OpenSans-LightItalic.ttf}
\newfontface{\sfblargeRomeo}[Ligatures=Common,Scale=1.2]{OpenSans-Bold.ttf}
\newfontface{\sfbelevenRomeo}[Ligatures=Common,Scale=1.1]{OpenSans-Bold.ttf}
\newfontface{\sfbRomeo}[Ligatures=Common,Scale=1]{OpenSans-Bold.ttf}
\newfontface{\sfeightRomeo}[Ligatures=Common,Scale=.8]{OpenSans-Light.ttf}
\newfontface{\sfnineRomeo}[Ligatures=Common,Scale=.9]{OpenSans-Light.ttf}
\newfontface{\defnemRomeo}[Ligatures=Common,Scale=1]{OpenSans-Bold.ttf}
%%%%%
\newfontface{\sfbsectionRomeo}[Ligatures=Common,Scale=1.3]{OpenSans-Bold.ttf}
\newfontface{\sfbsubsecRomeo}[Ligatures=Common,Scale=1.2]{OpenSans-Bold.ttf}
\newfontface{\sfbsubsubRomeo}[Ligatures=Common,Scale=1.1]{OpenSans-Bold.ttf}
\newfontface{\sfbparaRomeo}[Ligatures=Common,Scale=1]{OpenSans-Bold.ttf}
\newfontface{\sfbsectionitalRomeo}[Ligatures=Common,Scale=1.3]{OpenSans-BoldItalic.ttf}
\newfontface{\sfbsubsecitalRomeo}[Ligatures=Common,Scale=1.2]{OpenSans-BoldItalic.ttf}
\newfontface{\sfbsubsubsecitalRomeo}[Ligatures=Common,Scale=1.1]{OpenSans-BoldItalic.ttf}

%% redefining existing sans serif font commands
\renewcommand{\sfbHuge}{\sfbHugeRomeo}       
\renewcommand{\cmssbxparttoc}{\cmssbxparttocRomeo}
\renewcommand{\cmssbxsection}{\cmssbxsectionRomeo}
\renewcommand{\cmssbxeleven}{\cmssbxelevenRomeo}
\renewcommand{\cmssbxchaptoc}{\cmssbxchaptocRomeo}    
\renewcommand{\cmssbxchaptitle}{\cmssbxchaptitleRomeo}
\renewcommand{\cmsschapname}{\cmsschapnameRomeo}
\renewcommand{\cmssbxpart}{\cmssbxpartRomeo}
\renewcommand{\cmssparttitle}{\cmssparttitleRomeo} 
\newcommand{\sfiHuge}{\sfiHugeRomeo}
\renewcommand{\sfititle}{\sfititleRomeo}
\renewcommand{\sfihalftitle}{\sfihalftitleRomeo} 
\renewcommand{\sfiauthor}{\sfiauthorRomeo} 
\renewcommand{\sfblarge}{\sfblargeRomeo} 
\renewcommand{\sfbeleven}{\sfbelevenRomeo}  
\renewcommand{\sfb}{\sfbRomeo} 
\renewcommand{\sfeight}{\sfeightRomeo}
\renewcommand{\sfnine}{\sfnineRomeo}
\renewcommand{\defnem}{\defnemRomeo}                  
%%%%
\renewcommand{\sfbsection}{\sfbsectionRomeo}
\renewcommand{\sfbsubsec}{\sfbsubsecRomeo}
\renewcommand{\sfbsubsub}{\sfbsubsubRomeo}
\renewcommand{\sfbpara}{\sfbparaRomeo}

%%%%%%% emoji fonts
\newcommand{\martini}{\includegraphics[scale=.0125]{1F378_color}}
% this is an open source emoji image.  Make sure to note for Right & Reprints. 

%%%%%%% strikeout text function
\usepackage[normalem]{ulem}  % used for a meredith citation
%%%%%%%%%%%%%%

%%%%%%%%%% getting picky about hyphenation
\hyphenation{name-space}
%%%%%%%%%%%%%

\newcommand\subsubemdash{\sfbsubsubRomeo\char"2014} %% for whatever reason, emdashes are not displaying properly in subsubsection heads. This creates a direct command to create them. 

\newcommand\romeovalue[1]{\textit{#1}}  % for normal text usage
\newcommand\romeovalueinside{\itshape} % for inside other environments, like table cells
\newcommand\romeogloss[1]{\textbf{#1}}
\newcommand\intraref[2]{\textit{\titleref{#1}~\intrarefdelim~\titleref{#2}} on page~\pageref{#2}}
\newcommand\intrarefsimple[1]{\textit{\titleref{#1}} on page~\pageref{#1}}
\newcommand\seealsoref[2]{``\titleref{#1}"~({#2}, p.~\pageref{#1})~\seealsodelim~}
\newcommand\featureref[2]{{#1}.``\titleref{#2}" on page~\pageref{#2}}
\newcommand{\intrarefdelim}{---}
\newcommand{\seealsodelim}{~$\blacklozenge$~}
\usepackage{ifthen}

\usepackage{cite}
%%%%%%%%%%%%%%%%% to set citations and biblabels bold 
\makeatletter
\renewcommand\@cite[2]{%
{\bfseries #1}}\ifthenelse{\boolean{@tempswa}}{,\nolinebreak[3] #2}{}
%\makeatletter
\renewcommand\@biblabel[1]{\MakeLowercase{\bfseries #1}}  % sets bib label citations are bold
\makeatother
%%%%%%%%%%%%%%%%

% Because the cppxx in the RH takes the moniker of "section" per the Au's requirement even though the Au requires that it not exist on the page and because each "feature" is a section and is unnumbered and because the Au decided when the design was almost complete that a section xref was needed for each feature, these manual commands will take the place of a working \ref for each cppxx fake section. Readdress this for the second edition and come up with a better solution; that will probably involve redefining the section command, so cppxx can be an actual section, or creating a new section-like environment for cppxx.   
\newcommand{\locationa}{Section~1.1}
\newcommand{\locationb}{Section~1.2}
\newcommand{\locationc}{Section~2.1}
\newcommand{\locationd}{Section~2.2}
\newcommand{\locatione}{Section~3.1}
\newcommand{\locationf}{Section~3.2}




%%% LORI
\usepackage{cprotect}

\usepackage{amsfonts} % to ensure attractive mathematics
\usepackage{amssymb} % to ensure attractive mathematics
\usepackage{float}      % to allow things to float even if they normally don't
\usepackage{wrapfig} % to allow text to wrap around small figures
\usepackage{outline} % to allow outline creation
\usepackage{framed-PearsonGeneric} % to create the leftside vertical bar for the example environment

\usepackage{listings}  % for setting attractive computer code
\makeatletter
\@addtoreset{lstlisting}{section}  % to renumber listings per section
\makeatother


\definecolor{maroon}{cmyk}{.26,1,.63,.17}
\definecolor{skyblue}{cmyk}{.62,.07,0,0}
\definecolor{forestgreen}{cmyk}{.9,0,.9,0}
\definecolor{mustard}{cmyk}{.22,.14,1,0}
\definecolor{purple}{cmyk}{.83,.81,0,0}
\definecolor{codegray}{cmyk}{0,0,0,.70}

%%%%% CHANGED FOR ROMEO
% changed font to Cousine, changed to 2ex indent

%%% PRINT BOOK SETTINGS
%\lstset{language=C++,basicstyle=\ttfamily\small,framerule=0.5pt,
%emph=[1]{const},
%  emphstyle=[1]{\color{forestgreen}\ttfamily},
%  moreemph=[2]{int,void,char},
%  emphstyle=[2]{\color{forestgreen}\ttfamily},
%    moreemph=[3]{decltype},
%      emphstyle=[3]{\color{forestgreen}\ttfamily},
%    keywordstyle={\color{forestgreen}\ttfamily\bfseries},
%  stringstyle={\color{forestgreen}},
%commentstyle={\color{codegray}\itshape},
%numberstyle=\color{forestgreen},
%xleftmargin=2ex,
%    escapeinside={(ù}{ù)},
%    showstringspaces=false, 
%} 
% setting the code in small sans serif font and
% setting the margin for the code.  Nov 2015: setting the rules to be 0.5pt
%%%%%%%%%%%%%
%\newcommand{\codeincomments}{\color{codegray}\ttfamily}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% EBOOK SETTINGS
\lstset{language=C++,basicstyle=\ttfamily\small,framerule=0.5pt,
emph=[1]{const},
  emphstyle=[1]{\color{mustard}\ttfamily},
  moreemph=[2]{int,void,char},
  emphstyle=[2]{\color{maroon}\ttfamily},
    moreemph=[3]{decltype},
      emphstyle=[3]{\color{forestgreen}\ttfamily},
    keywordstyle={\color{forestgreen}\ttfamily\bfseries},
  stringstyle={\color{purple}},
commentstyle={\color{skyblue}\itshape},
numberstyle=\color{purple},
xleftmargin=2ex,
    escapeinside={(ù}{ù)},
    showstringspaces=false, 
} 

\lstdefinestyle{plain}{basicstyle=\ttfamily\small,framerule=0.5pt,xleftmargin=2ex,
emph=[1]{const},
  emphstyle=[1]{\ttfamily},
  moreemph=[2]{int,void,char},
  emphstyle=[2]{\ttfamily},
    moreemph=[3]{decltype},
      emphstyle=[3]{\ttfamily},
    keywordstyle={\ttfamily},
  stringstyle={},
commentstyle={\ttfamily},
numberstyle={},
    escapeinside={(ù}{ù)},
    showstringspaces=false, 
}

% setting the code in small sans serif font and
%% setting the margin for the code.  Nov 2015: setting the rules to be 0.5pt
%%%%%%%%%%%%%%
\newcommand{\codeincomments}{\color{skyblue}\ttfamily}

\lstdefinestyle{footcode}{language=C++,
basicstyle=\ttfamily\footnotesize,framerule=0.5pt,
keywordstyle={\ttfamily\bfseries\footnotesize},
commentstyle={\color{grey}\ttfamily},
xleftmargin=2ex,
escapeinside={(ù}{ù)},
showstringspaces=false, 
}  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\fncodeincomments}{\color{grey}\ttfamily}
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
\cleardoublepage
\parskip .5ex                       % Add space between Contents items
\tableofcontents                  % Make the Table of Contents 
\cleardoublepage                
\parskip 0in                         % Reset to zero interpar spacing
\include{emcppsc-foreword}               % Add foreword
\include{emcppsc-preface}                 % Add preface 
\include{emcppsc-ack}                        % Add acknowledgements 
\include{emcppsc-author}                   % Add about the author page
\cleardoublepage                  
%%%%%%%The front matter ends

\pagenumbering{arabic}		  % Arabic numbering
\cleardoublepage
\include{emcpps-ch0}  % Chapter 0
\cleardoublepage

%%%%%% RHs redefined for Chs 1-3
%\fancyhead[RO]{\sectionmark}
\fancyhead[LO]{\sfnine\cppxx}
%\fancyhead[RE]{\sectionmark}
%\fancyhead[LE]{\chaptermark}
%%%%%%%%%%
\include{emcpps-ch1}  % Chapter 1
\cleardoublepage
\include{emcpps-ch2}  % Chapter 2
\cleardoublepage
\include{emcpps-ch3}  % Chapter 3
\cleardoublepage
%
%%%%%% RHs revert for Ch 4 + BM
\fancyhead[LO]{}
%\renewcommand{\sectionmark}[1]{\markright{{\sfnine\thesection\ #1}}}
%\renewcommand{\chaptermark}[1]{\markboth{{\sfb\thechapter\quad {\sfb #1}}}{}}
%%%%%%%%%%
\include{emcpps-ch4}  % Chapter 4
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

% 
% %
% 
% 
\end{document}
