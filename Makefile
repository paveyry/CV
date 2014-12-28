LATEX=pdflatex

all:
	$(LATEX) cv_fr.tex
	$(LATEX) cv_en.tex
	$(RM) *.aux *.log *.out

clean:
	$(RM) *.aux *.log *.out *.gz
