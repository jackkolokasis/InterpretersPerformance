
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

TARGET   = cs446_Report
TEXFILES = $(shell ls *.tex)
#FIGFILES = $(shell ls figures/*.png)
BIBFILES = $(shell ls *.bib)

.PHONY: clean all distclean
	
all: $(TARGET).pdf

$(TARGET).pdf: $(TEXFILES) $(BIBFILES) 
	pdflatex $(TARGET)
	bibtex $(TARGET)
	pdflatex $(TARGET)
	pdflatex $(TARGET)

clean:
	rm -f *.vrb *.bbl *.aux *.log *.toc *.blg *.lof *.snm *.nav *.out 

distclean:
	rm -f $(TARGET).pdf

