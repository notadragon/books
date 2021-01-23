#!/bin/bash

for f in emcppsf_binaryliteral.tex emcppsf_consecutiveangle.tex emcppsf_decltype.tex emcppsf_delete.tex emcppsf_override.tex emcppsf_staticassert.tex emcppsf_trailingreturn.tex emcppsf_unrestrictedunion.tex emcppsf_noreturn.tex emcppsf_nullptr.tex ; do
    sed -i -e  "s,\\\\begin{lstlisting}\\[language=C++\\],\\begin{emcppslisting}," -e "s,\end{lstlisting},\end{emcppslisting}," $f
    grep -H lstlisting $f
done
