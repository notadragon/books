
\chapter[Conditionally Safe Features]{Conditionally Safe Features}\label{ch-conditional}

Intro text should be here.

%%%%%%%%%%%%%%% C++11
\stepcounter{cppxx}
\addtocontents{toc}{\protect\renewcommand*\protect\cftsecindent{1.25em}}
\cftaddnumtitleline{toc}{section}{\thechapter.\thecppxx}{C++11}{\thepage}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++11}

%T%% for f in pub.outline.sectionfiles("conditionallysafe_cpp11"):
\input{${f}}
%T%% endfor

%%%%%%%%%%%%%%% C++14
\stepcounter{cppxx}
\addtocontents{toc}{\protect\renewcommand*\protect\cftsecindent{1.25em}}
\cftaddnumtitleline{toc}{section}{\thechapter.\thecppxx}{C++14}{\thepage}
% to add to the TOC at the section level
\renewcommand{\cppxx}{C++14}

%T%% for f in pub.outline.sectionfiles("conditionallysafe_cpp14"):
\input{${f}}
%T%% endfor
