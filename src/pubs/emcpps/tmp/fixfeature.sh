#!/bin/bash

for f in emcppsf_enumclass.tex emcppsf_forwardingref.tex emcppsf_underlyingenum.tex emcppsf_opaqueenum.tex emcppsf_functionstatic.tex emcppsf_externtemplate.tex  ; do
  sed -i \
      -e  "s|\\\\begin{lstlisting}\\[language=C++\\]|\\\\begin{emcppslisting}|" \
      -e  "s|\\\\begin{lstlisting}\\[language=C++, |\\\\begin{emcppslisting}[|" \
      -e "s|\end{lstlisting}|\end{emcppslisting}|" \
      $f
    grep -H lstlisting $f
done
