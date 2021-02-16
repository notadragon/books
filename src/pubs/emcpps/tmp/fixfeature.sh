#!/bin/bash




# script to do initial conversion of a feature from lstlisting to emcppslisting

for f in emcppsf_deprecated emcppsf_explicit_conversion emcppsf_extendedfriend emcppsf_inlinenamespace emcppsf_unicodestring emcppsf_variabletemplate ; do
  sed -i \
      -e  "s|\\\\begin{lstlisting}\\[language=C++\\]|\\\\begin{emcppslisting}|" \
      -e  "s|\\\\begin{emcppslisting}\\[language=C++\\]|\\\\begin{emcppslisting}|" \
      -e  "s|\\\\begin{lstlisting}\\[language=C++, |\\\\begin{emcppslisting}[|" \
      -e "s|\end{lstlisting}|\end{emcppslisting}|" \
      ${f}.tex
  grep -H lstlisting ${f}.tex | grep -v setcounter

  grep -H "include" ${f}.tex | grep "\""
  egrep -H "// .*h$" ${f}.tex
  egrep -H "// .*cpp$" ${f}.tex

  grep -H "include" ${f}.tex | grep -v codeincomments
done
