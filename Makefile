#  This makefile generates all the output files from the source Asciidoc files.

ifndef $(LANG)
	LANG = en
endif

#  Constants
DIR = _build
DIST = dist
BOOK = master
EBOOK = master_epub
TAG = `git describe --tags --always`
TITLE = BookTitle
ADOCFONTSDIR =  /usr/lib/ruby/gems/2.4.0/gems/asciidoctor-pdf-1.5.0.alpha.16/data/fonts/
TTFFONTSDIR = /usr/share/fonts/
KINDLEGEN_PATH = /usr/local/bin/
KINDLEGEN_OPTS = -c2
EPUBOPTS = -f epub --stylesheet=epub3-css3-only.css
ASCIIDOC_IMAGES = /etc/asciidoc/images

#  ---------------------------------
#  Public targets
all:
	# Usage
	# LANG=en make [pdf, html, epub, kindle]

html: clean create_html dist_html

pdf: clean create_pdf dist_pdf

epub: clean create_epub dist_epub

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi; \


create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
	fi; \
	cp -v -R -L ${ASCIIDOC_IMAGES} ${DIR}; \
	cp -v images/* ${DIR}; \
	cp -v chapters/${LANG}/* ${DIR}; \
	cp -v conf/* ${DIR}; \

copy_fonts:
	find ${TTFFONTSDIR} -name *ttf -exec cp -u {} ${DIR} \;
	find ${ADOCFONTSDIR} -name *ttf -exec cp -u {} ${DIR} \;


compress_images: create_folder
	cd ${DIR}; \
	for f in *.png; \
		do mogrify -depth 4 -colorspace gray -resize 504 "$$f"; \
	done; \

#  Generate HTML
create_html: create_folder
	cd ${DIR}; \
	asciidoctor ${HTMLOPTS} --out-file=${EBOOK}.html ${EBOOK}.asciidoc; \

#  Generate PDF
create_pdf: create_folder copy_fonts
	cd ${DIR}; \
	asciidoctor-pdf --verbose master.asciidoc

create_epub: create_folder copy_fonts
	cd ${DIR}; \
	asciidoctor-epub3 --verbose master.asciidoc

create_dist:
	if [ ! -d "${DIST}" ]; then \
		mkdir ${DIST}; \
	fi; \
	if [ ! -d "${DIST}/${LANG}" ]; then \
		mkdir ${DIST}/${LANG}; \
	fi; \

dist_pdf: create_dist
	if [ -f "${DIR}/${BOOK}.pdf" ]; then \
		cp ${DIR}/${BOOK}.pdf ${DIST}/${LANG}/${TITLE}_${TAG}.pdf; \
	fi; \
