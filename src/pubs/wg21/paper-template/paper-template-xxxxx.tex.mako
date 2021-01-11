\documentclass{wg21}

%T%<% papername = pub.config.get("paper", "name") %>

%T%% for f in pub.outline.sectionfiles("initial"):
\include{${f}}
%T%% endfor

\usepackage{amsmath} % to ensure attractive mathematics
\usepackage{amsfonts} % to ensure attractive mathematics
\usepackage{amssymb} % to ensure attractive mathematics

%JMB: Using Cousine as code font
\usepackage{mathspec}
\setmonofont[Ligatures=NoCommon,Scale=.9,SlantedFont={Cousine-Italic},BoldFont={Cousine Bold},BoldSlantedFont={Cousine-Bold Italic}]{Cousine-Regular} % to set our code font
\newfontface{\SecCode}[Ligatures=NoCommon,Scale=1.3]{Cousine-Bold}
\newfontface{\SubsecCode}[Ligatures=NoCommon,Scale=1.1]{Cousine-Bold}
\newfontface{\SubsubsecCode}[Ligatures=NoCommon,Scale=.91]{Cousine-Bold}
\newfontface{\ParaCode}[Ligatures=NoCommon,Scale=.9]{Cousine-Bold}
\newfontface{\SubparaCode}[Ligatures=NoCommon,Scale=.9]{Cousine-Regular}

\usepackage{titleref} % to allow cross-referencing by title
\usepackage{xr} % to allow cross-referencing between files
\usepackage{tablefootnote} % to allow footnotes in tables

\include{lstsetup}

%T%% for f in pub.outline.sectionfiles("preamble"):
\include{${f}}
%T%% endfor

\include{${papername}-title}

\begin{document}

\maketitle

\include{${papername}-abstract}

\tableofcontents

%T%% for f in pub.outline.sectionfiles("body"):
\include{${f}}
%T%% endfor

\appendix               % Change to appendix numbering
%T%% for f in pub.outline.sectionfiles("appendix"):
\include{${f}}
%T%% endfor

\bibliographystyle{ieeetr-hacked}  % Your production editor and copy editor may want you to
                                   % use a different bibliography style file.
                                   % You can input that style file here.
\bibliography{${",".join(pub.outline.sectionfiles("bib"))}}  % Loading the bibliography file.

\end{document}
