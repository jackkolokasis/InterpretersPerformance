
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

LATEX=pdflatex
TARGET=cs446_Report


$(TARGET): $(TARGET).tex $(TARGET).bib
	$(LATEX) $<
	bibtex $(<:.tex=)
	$(LATEX) $<
	$(LATEX) $<


clean:
	@rm -f *.aux *.bbl *.gz *.dvi *.log *.blg *~ $(TARGET).ps $(TARGET).pdf

