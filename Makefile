LATEX        = pdflatex
BUILDER      = ./resume_builder.py
EXCLUSIONS   = P003,P004,P006,P007,P010
DATA_DIR     = content
PDFS         = cv_en.pdf cv_fr.pdf
TEXS         = $(PDFS:.pdf=.tex)

all: ${PDFS}
	${RM} *.aux *.log *.out

%.tex: ${DATA_DIR}/%.yml
	${BUILDER} --exclude-entries=${EXCLUSIONS} $< > $@
	
%.pdf: %.tex
	$(LATEX) $<
	${RM} $<
	
clean:
	$(RM) *.aux *.log *.out *.gz ${PDFS} ${TEXS}
