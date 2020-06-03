all:booksample-peerson.tex

clean:
	rm -rf _minted-* *.xtr *.out *.log *.fls *.aux *.ext *.fdb_latexmk *.toc *.pyg

.PHONY: phony_explicit
phony_explicit:

booksample-peerson.tex: phony_explicit
	latexmk -xelatex -shell-escape -pdf -interaction=nonstopmode $*.tex > out.log
	{                                                     \
		filebase=$$(echo $* | sed -e "s/.tex//");     \
		mv $*.pdf generated/;                         \
		pdftotext -eol unix -layout generated/$*.pdf; \
	}
