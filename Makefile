LATEX=pdflatex
SRC=cv_fr.tex cv_en.tex

all:
	$(LATEX) $(SRC)
	$(RM) *.aux *.log *.out

clean:
	$(RM) *.aux *.log *.out *.pdf *.gz
