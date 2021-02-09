#!/bin/bash



# script to do initial conversion of a feature from lstlisting to emcppslisting

for f in emcppsf_attribute emcppsf_ctordelegating emcppsf_localtypes emcppsf_longlong emcppsf_using emcppsf_aggregateinit emcppsf_digitseparator emcppsf_default ; do
  sed -i \
      -e  "s|\\\\begin{lstlisting}\\[language=C++\\]|\\\\begin{emcppslisting}|" \
      -e  "s|\\\\begin{emcppslisting}\\[language=C++\\]|\\\\begin{emcppslisting}|" \
      -e  "s|\\\\begin{lstlisting}\\[language=C++, |\\\\begin{emcppslisting}[|" \
      -e "s|\end{lstlisting}|\end{emcppslisting}|" \
      ${f}.tex
    grep -H lstlisting ${f}.tex
done
