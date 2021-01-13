\cleardoublepage

\chapter[Unsafe Features]{Unsafe Features}\label{ch-unsafe}

Intro text should be here.

%%%%%%%%%%%%%%% C++11
\stepcounter{cppxx}
\addtocontents{toc}{\protect\renewcommand*\protect\cftsecindent{1.25em}}
\cftaddnumtitleline{toc}{section}{\thechapter.\thecppxx}{C++11}{\thepage}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++11}

%T%% for f in pub.outline.sectionfiles("unsafe_cpp11"):
\input{${f}}
%T%% endfor

%%%%%%%%%%%%%%% C++14
\stepcounter{cppxx}
\addtocontents{toc}{\protect\renewcommand*\protect\cftsecindent{1.25em}}
\cftaddnumtitleline{toc}{section}{\thechapter.\thecppxx}{C++14}{\thepage}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++14}

%T%% for f in pub.outline.sectionfiles("unsafe_cpp14"):
\input{${f}}
%T%% endfor
