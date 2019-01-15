#  This makefile generates all the output files from the source Asciidoc files.

ifndef $(LANG)
	LANG = en
endif

#  Constants
DIR = _build
DIST = dist
BOOKFILE = master
TAG = `git describe --tags --always`
TITLE = TheBookTitle

RUBYDIR = /usr/lib/ruby/gems/2.4.0/gems/
ADOCFONTSDIR =  ${RUBYDIR}/asciidoctor-pdf-1.5.0.alpha.16/data/fonts/
EPUBCSSDIR= ${RUBYDIR}/asciidoctor-epub3-1.5.0.alpha.7/data/styles/
TTFFONTSDIR = /usr/share/fonts/
KINDLEGEN_PATH = /usr/local/bin/
KINDLEGEN_OPTS = -c2

PDFOPTS = -a lang=${LANG}
EPUBOPTS = -a lang=${LANG}

#  ---------------------------------
#  Public targets
all: pdf epub kindle
	# Usage
	# make [LANG=xx] {pdf, epub, kindle}

pdf: clean create_pdf dist_pdf

epub: clean create_epub dist_epub

kindle: clean create_kindle dist_kindle

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi; \


create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
	fi; \
	cp -u images/* ${DIR}; \
	cp -u chapters/${LANG}/* ${DIR}; \
	cp -u ${EPUBCSSDIR}/* ${DIR};
	cp -u conf/* ${DIR}; \


copy_fonts:
	find ${TTFFONTSDIR} -name *ttf -exec cp -u {} ${DIR} \;
	find ${ADOCFONTSDIR} -name *ttf -exec cp -u {} ${DIR} \;


compress_images: create_folder
	cd ${DIR}; \
	for f in *.png; \
		do mogrify -depth 4 -colorspace gray -resize 504 "$$f"; \
	done; \

#  Generate PDF
create_pdf: create_folder copy_fonts
	cd ${DIR}; \
	asciidoctor-pdf --verbose ${PDFOPTS} ${BOOKFILE}.asciidoc

create_epub: create_folder copy_fonts
	cd ${DIR}; \
	asciidoctor-epub3 --verbose ${EPUBOPTS} ${BOOKFILE}.asciidoc

create_kindle: create_folder copy_fonts
	cd ${DIR}; \
	asciidoctor-epub3 -a ebook-format=kf8 --verbose ${EPUBOPTS} ${BOOKFILE}.asciidoc

create_dist:
	if [ ! -d "${DIST}/${LANG}" ]; then \
		mkdir -p ${DIST}/${LANG}; \
	fi; \

dist_pdf: create_dist
	if [ -f "${DIR}/${BOOKFILE}.pdf" ]; then \
		cp ${DIR}/${BOOKFILE}.pdf ${DIST}/${LANG}/${TITLE}_${TAG}.pdf; \
	fi; \

dist_epub: create_dist
	if [ -f "${DIR}/${BOOKFILE}.epub" ]; then \
		cp ${DIR}/${BOOKFILE}.epub ${DIST}/${LANG}/${TITLE}_${TAG}.epub; \
	fi; \

dist_kindle: create_dist
	if [ -f "${DIR}/${BOOKFILE}.mobi" ]; then \
		cp ${DIR}/${BOOKFILE}.mobi ${DIST}/${LANG}/${TITLE}_${TAG}.mobi; \
	fi; \
