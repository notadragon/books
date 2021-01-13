\cleardoublepage

\chapter[Safe Features]{Safe Features}\label{ch-safe}

Intro text should be here.

%%%%%%%%%%%% C++11
\cftaddtitleline{toc}{section}{\sffamily\itshape C++11}{}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++11}

%T%% for f in pub.outline.sectionfiles("safe_cpp11"):
\input{${f}}
%T%% endfor

%%%%%%%%%%%%%%% C++14
\cftaddtitleline{toc}{section}{\sffamily\itshape C++14}{}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++14}

%T%% for f in pub.outline.sectionfiles("safe_cpp14"):
\input{${f}}
%T%% endfor

