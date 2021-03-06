\documentclass[pdf,aspectratio=169]{beamer}
\usetheme{Pittsburgh}
\useinnertheme{rounded}

\usepackage{datetime2}
\usepackage{amsmath}
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage[multidot]{grffile}
\usepackage{forest}
\usepackage{fvextra}
\usepackage{graphicx}
\usepackage{listings}
\usepackage{makecell}
\usepackage{minted}
\usepackage{pgfpages}
\usepackage{realboxes}
\usepackage{relsize}
\usepackage{smartdiagram}
\usepackage{tcolorbox}
\usepackage[overlay,absolute]{textpos}
\usepackage{tikz}
\usepackage{underscore}
\usepackage{xspace}
\usepackage{epigraph}
\usepackage{adjustbox}

\usesmartdiagramlibrary{additions}
\usetikzlibrary{shapes.geometric, arrows}

\setlength{\epigraphwidth}{0.9\textwidth}
\setlength{\epigraphrule}{0pt}

\defbeamertemplate{footline}{my page number}
{%
  \hfill%
  \usebeamercolor[fg]{page number in head/foot}%
  \usebeamerfont{page number in head/foot}%
  \insertframenumber\,/\,\inserttotalframenumber\kern1em \insertpagenumber\,/\,\insertpresentationendpage\kern1em\vskip2pt%
}

\setbeamertemplate{footline}[my page number]
\setbeamertemplate{frametitle}[default][center]
\beamertemplatenavigationsymbolsempty
%\setbeamercovered{dynamic}
%\setbeameroption{show notes on second screen}

\graphicspath{ {./} }

\lstdefinestyle{base}{
  language=c++,
  breaklines=false,
  basicstyle=\ttfamily\color{black},
  moredelim=**[is][\color{green!50!black}]{@}{@},
  escapeinside={(*@}{@*)}
  morekeywords={audit,axiom,ignore,assume,check_maybe_continue,check_never_continue,check_always_continue}
}

\setminted{beameroverlays}
\setminted{texcomments}
\usemintedstyle{bw}

\definecolor{HighlightBG}{RGB}{147,112,219}

\def\mylexer{presentation_cpplexer.py:CppPresentationLexer -x}
\newcommand{\cc}[1]{\mintinline{\mylexer}{#1}}
\newminted[cppcode]{\mylexer}{highlightcolor=HighlightBG!40}
\newminted[cppcodebox]{\mylexer}{bgcolor=lightgray!10,highlightcolor=HighlightBG!40,escapeinside=||}
\newminted[cppcodebox2]{\mylexer}{bgcolor=pink!10,highlightcolor=HighlightBG!40}

\newminted[shellbox]{bash}{}

%wg21 stuff
\newcommand{\Cpp}{\texorpdfstring{C\kern-0.05em\protect\raisebox{.35ex}{\textsmaller[2]{+\kern-0.05em+}}}{C++}\xspace}
\newcommand{\CppXVII}{\Cpp{}17\xspace}
\newcommand{\CppXX}{\Cpp{}20\xspace}
\newcommand{\stdgrammarterm}[1]{\textit{#1}\xspace}
\newcommand{\stdnoteintro}[1]{[\,\textit{#1:}\space}
\newcommand{\stdnoteoutro}[1]{\textit{\,---\,end #1}\,]}
\newenvironment{stdnote}[1][Note]{\stdnoteintro{#1}}{\stdnoteoutro{note}\xspace}
\newenvironment{stdexample}[1][Example]{\stdnoteintro{#1}}{\stdnoteoutro{example}\xspace}

%highlighting
\newcommand<>{\highlight}[1]{{\hspace*{-\fboxsep}\raisebox{0pt}[-2\fboxsep][-2\fboxsep]{\Colorbox{HighlightBG!40}{\vphantom{X}#1}}\hspace*{-\fboxsep}}}
\newcommand{\highlightrow}{\rowcolor{HighlightBG!40}}

%T%<% name = pub.config.get("presentation", "name") %>

\include{${name}-title}

\date{\DTMusedate{presentationdate}}

\begin{document}

\frame{\titlepage}

\begin{frame}
\frametitle{Copyright Notice}
\textcopyright \DTMfetchyear{presentationdate} Bloomberg L.P. Permission is granted to copy, distribute, and display
this material, and to make derivative works and commercial use of it. The
information in this material is provided ``AS IS'', without warranty of any
kind. Neither Bloomberg nor any employee guarantees the correctness or
completeness of such information. Bloomberg, its employees, and its
affiliated entities and persons shall not be liable, directly or indirectly, in any
way, for any inaccuracies, errors or omissions in such information. Nothing
herein should be interpreted as stating the opinions, policies,
recommendations, or positions of Bloomberg.
\end{frame}

%T%% for f in pub.outline.sectionfiles("frames"):
\include{${f}}
%T%% endfor


\end{document}

