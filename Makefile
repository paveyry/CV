LATEX            = pdflatex
BUILDER          = ./resume_builder.py
EXCLUSIONS_WEB   = P003
EXCLUSIONS_PDF   = P003,P004,P006,P007
DATA_DIR         = content
TEMPLATE_DIR     = templates
OUT              = out
PDFS             = ${OUT}/cv_en.pdf ${OUT}/cv_fr.pdf
TEXS             = $(PDFS:.pdf=.tex)
TRASH_FILES      = ${OUT}/*.aux ${OUT}/*.log ${OUT}/*.out
HTML_EN_OUTPUT   = ${OUT}/index_en.html
HTML_FR_OUTPUT   = ${OUT}/index_fr.html
HTML_OUTPUT      = ${OUT}/index.html


.PHONY: all clean web pdf

all: web pdf

web: ${HTML_FR_OUTPUT} ${HTML_EN_OUTPUT}
	mv ${HTML_EN_OUTPUT} ${HTML_OUTPUT}

pdf: ${PDFS}

${OUT}/index_%.html: ${DATA_DIR}/cv_%.yml ${OUT}
	cp -r ${TEMPLATE_DIR}/web/* ${OUT}
	${BUILDER} --exclude-entries=${EXCLUSIONS_WEB} --type=web $< > $@

${OUT}/%.tex: ${DATA_DIR}/%.yml ${OUT}
	${BUILDER} --exclude-entries=${EXCLUSIONS_PDF} --type=pdf $< > $@
	
%.pdf: %.tex
	$(LATEX) -output-directory ${OUT} $<
	${RM} ${TRASH_FILES} $<

${OUT}:
	mkdir -p $@
	
clean:
	${RM} ${OUT}
