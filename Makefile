LATEX            = pdflatex
BUILDER          = ./resume_builder.py
EXCLUSIONS_WEB   = P003,P004,P006,P007,P010
EXCLUSIONS_PDF   = P003,P004,P006,P007,P010
DATA_DIR         = content
TEMPLATE_DIR     = templates
OUT              = out
PDFS             = ${OUT}/cv_en.pdf ${OUT}/cv_fr.pdf
TEXS             = $(PDFS:.pdf=.tex)
TRASH_FILES      = ${OUT}/*.aux ${OUT}/*.log ${OUT}/*.out
HTML_OUTPUT      = ${OUT}/index.html

.PHONY: all clean

all: ${PDFS} ${HTML_OUTPUT}

%.html: ${DATA_DIR}/cv_en.yml ${OUT}
	cp -r ${TEMPLATE_DIR}/web/* $(dir $@)
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
