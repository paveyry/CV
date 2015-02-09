LATEX=pdflatex

all:
	$(LATEX) cv_fr.tex
	$(LATEX) cv_en.tex
	$(RM) *.aux *.log *.out
	mv *.pdf CV_Web

clean:
	$(RM) *.aux *.log *.out *.gz
