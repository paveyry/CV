LATEX=pdflatex
BUILDER=./resume_builder.py
EXCLUSIONS=P003,P004,P006,P007,P010
DATA_DIR=content

all: cv_en.pdf cv_fr.pdf
	$(RM) *.aux *.log *.out

%.tex:
	${BUILDER} --exclude-entries=${EXCLUSIONS} ${DATA_DIR}/%.yml > $@
	
%.pdf: %.tex
	$(LATEX) $<
	
clean:
	$(RM) *.aux *.log *.out *.gz *.pdf
