all:${pub.basename}.tex

clean:
	rm -rf _minted-* *.xtr *.out *.log *.fls *.aux *.ext *.fdb_latexmk *.toc *.pyg

.PHONY: phony_explicit
phony_explicit:

DIR := \${CURDIR}
GENDIR :=

${pub.basename}.tex: phony_explicit
	latexmk -xelatex -shell-escape -pdfxe -interaction=nonstopmode ${pub.basename}.tex > out.log
	mv ${pub.basename}.pdf ${pub.gendir}
	pdftotext -eol unix -layout ${pub.gendir}/${pub.basename}.pdf

