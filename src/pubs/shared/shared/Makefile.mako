all:${pub.basename}.tex

clean:
	rm -rf _minted-* *.xtr *.out *.log *.fls *.aux *.ext *.fdb_latexmk *.toc *.pyg

.PHONY: phony_explicit
phony_explicit:

DIR := \${CURDIR}
GENDIR := \$(subst /build/,/generated/,\${DIR})

%T%% for f in pub.outline.sectionfiles("makefile"):
${open(pub.loadFile(f)).read()}
%T%% endfor

${pub.basename}.tex: phony_explicit
	latexmk -xelatex -shell-escape -pdfxe -interaction=nonstopmode ${pub.basename}.tex > out.log
	mv ${pub.basename}.pdf \${GENDIR}
	pdftotext -eol unix -layout \${GENDIR}/${pub.basename}.pdf

