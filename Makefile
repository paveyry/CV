LATEX        = pdflatex
BUILDER      = ./resume_builder.py
EXCLUSIONS   = P003,P004,P006,P007,P010
DATA_DIR     = content
OUT          = out
PDFS         = ${OUT}/cv_en.pdf ${OUT}/cv_fr.pdf
TEXS         = $(PDFS:.pdf=.tex)
TRASH_FILES  = ${OUT}/*.aux ${OUT}/*.log ${OUT}/*.out

all: ${PDFS} web
	${RM} ${TRASH_FILES}

web:
	cp -r CV_Web/* out/

${OUT}/%.tex: ${DATA_DIR}/%.yml ${OUT}
	${BUILDER} --exclude-entries=${EXCLUSIONS} $< > $@
	
%.pdf: %.tex
	$(LATEX) -output-directory ${OUT} $<
	${RM} $<

${OUT}:
	mkdir -p $@
	
clean:
	${RM} ${OUT}
