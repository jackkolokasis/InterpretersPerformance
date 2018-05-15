
###################################################################
#
# file: Makefile
#
# @Author   Iacovos G. Kolokasis
#           Emmanouil Pavlidakis
# @Version  13-05-2018
# @email    kolokasis@ics.forth.gr
#           manospavl@ics.forth.gr
#
# @brief    Makefile for the project presentation requirements of
# CS446 - Managed RunTime Systems course
#
###################################################################

TARGET   = cs446_pres
TEXFILES = $(shell ls *.tex)
FIGFILES = $(shell ls figures/*.png)

.PHONY: clean all distclean
	
all: $(target).pdf

$(target).pdf: $(TEXFILES) $(FIGFILES)
	pdflatex  -shell-escape $(TEXFILES)
	pdflatex  -shell-escape $(TEXFILES)
	pdflatex  -shell-escape $(TEXFILES)

clean:
	rm -f *.vrb *.aux *.log *.toc *.blg *.lof *.snm *.nav *.out 

distclean:
	rm -f $(TARGET).pdf

