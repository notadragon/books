\ProvidesClass{wg21}[2020/06/16 version 0.0.1 A class for writing WG21 papers]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[11pt]{article}

\RequirePackage[iso,american]{isodate}  % use iso format for dates
\RequirePackage{relsize}                % provide relative font size changes
\RequirePackage{underscore}             % remove special status of '_' in ordinary text
\RequirePackage{verbatim}               % improved verbatim environment
\RequirePackage{parskip}                % handle non-indented paragraphs "properly"
\RequirePackage{color}                  % define colors for strikeouts and underlines
\RequirePackage{amsmath}                % additional math symbols
\RequirePackage{mathrsfs}               % mathscr font
\RequirePackage{etoolbox}
\RequirePackage{xspace}
\RequirePackage{fullpage}
\RequirePackage{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defines the title of the paper
% usage: \title{<title>}
\renewcommand*{\title}[1]{\def\@title{#1}}

% defines the paper number
% usage: \docnumber{<document-number>}
\newcommand*{\docnumber}[1]{\def\@docnumber{#1}}

% defines the audience working group
% usage: \audience{<audience>}
\newcommand*{\audience}[1]{\def\@audience{#1}}

% Defines the author of the paper and their email address.
% usage: \author{<author>}{<email>}
\renewcommand*{\author}[2]{\def\@author{#1} \def\@email{#2}}
\newcommand*{\authortwo}[2]{\def\@authortwo{#1} \def\@emailtwo{#2}}
\newcommand*{\authorthree}[2]{\def\@authorthree{#1} \def\@emailthree{#2}}

\renewcommand{\maketitle}{%
  \newpage \null \vskip 2em%
  {\center \LARGE \@title \par}%
  \vskip 1.5em%
  \begin{flushright}%
    \begin{tabular}{ll}%
      Document \#:&\@docnumber\\%
      Date:       &\today\\%
      Project:    &Programming Language C++\\%
      \ifdef{\@audience}{Audience:   &\@audience\\}{}%
      Reply-to:   &\@author\ \textless\href{mailto:\@email}{\@email}\textgreater%
                  \ifdef{\@authortwo}{\\&\@authortwo\ \textless\href{mailto:\@emailtwo}{\@emailtwo}\textgreater}{}%
                  \ifdef{\@authorthree}{\\&\@authorthree\ \textless\href{mailto:\@emailthree}{\@emailthree}\textgreater}{}%
    \end{tabular}%
  \end{flushright}%
}
