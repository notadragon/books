%%%%%% RHs redefined for Chs 1-3
%\fancyhead[RO]{\emcppsRHMark}
\fancyhead[LO]{\sfnine\cppxx}
%\fancyhead[RE]{\emcppsRHMark}
%\fancyhead[LE]{\chaptermark}
%%%%%%%%%%

\emcppsFeatureChapter{safe}{Safe Features}

Intro text should be here.

\emcppsStandardSection{cpp11}{C++11}

%T%% for f in pub.outline.sectionfiles("safe_cpp11"):
\include{${f}}
%T%% endfor

\emcppsStandardSection{cpp14}{C++14}

%T%% for f in pub.outline.sectionfiles("safe_cpp14"):
\include{${f}}
%T%% endfor


\emcppsFeatureChapter{conditional}{Conditionally Safe Features}

Intro text should be here.

\emcppsStandardSection{cpp11}{C++11}

%T%% for f in pub.outline.sectionfiles("conditionallysafe_cpp11"):
\include{${f}}
%T%% endfor

\emcppsStandardSection{cpp14}{C++14}

%T%% for f in pub.outline.sectionfiles("conditionallysafe_cpp14"):
\include{${f}}
%T%% endfor

\emcppsFeatureChapter{unsafe}{Unsafe Features}

Intro text should be here.

\emcppsStandardSection{cpp11}{C++11}

%T%% for f in pub.outline.sectionfiles("unsafe_cpp11"):
\include{${f}}
%T%% endfor

\emcppsStandardSection{cpp14}{C++14}

%T%% for f in pub.outline.sectionfiles("unsafe_cpp14"):
\include{${f}}
%T%% endfor

%%%%%% RHs revert for Ch 4 + BM
\fancyhead[LO]{}
%\renewcommand{\sectionmark}[1]{\markright{{\sfnine\thesection\ #1}}}
%\renewcommand{\chaptermark}[1]{\markboth{{\sfb\thechapter\quad {\sfb #1}}}{}}
%%%%%%%%%%