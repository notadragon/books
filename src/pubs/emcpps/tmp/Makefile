# $Id: Makefile,v 1.7 2001/11/16 19:07:03 m Exp $
NAME=crop
ARCHNAME=$(NAME).tar.gz
ARCHIVE=$(NAME).dtx Makefile $(NAME).txt $(NAME).ins
MAKEIDXOPT=
DVIPSOPT= #-Pcmz -Pamz
DEP=$(NAME).sty

all: $(NAME).ps

print: $(NAME).ps
	psbook $(NAME).ps|psnup -2|psselect -e|lpr
	@ echo -n revert paper stack and hit return
	@ read key
	psbook $(NAME).ps|psnup -2|psselect -o -r|lpr

%.ps: %.dvi 
	dvips $(DVIPSOPT) $< -o $@

archive: $(NAME).ins
	@ tar -czf $(ARCHNAME) $(ARCHIVE) 
	@ echo $(ARCHNAME):
	@ echo ====================
	@ tar -tzf $(ARCHNAME)

clean: 
	rm -f $(NAME).{log,toc,lot,lof,idx,ilg,ind,aux,blg,bbl,dvi,ins}

distclean: clean
	rm -f $(NAME).{ps,sty} $(ARCHNAME)


REFWARN = 'Rerun to get cross-references'
LATEXMAX = 5

%.dvi: %.dtx $(DEP)
	latex $<
	RUNS=$(LATEXMAX); \
	while [ $$RUNS -gt 0 ] ; do \
		if grep $(REFWARN) $*.log > /dev/null; \
		then latex $< ; else break; fi; \
		RUNS=`expr $$RUNS - 1`; \
	done

$(NAME).sty: $(NAME).ins
	tex $(NAME).ins

$(NAME).ins:
	latex $(NAME).dtx

