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
TITLE = TheInternetOfMoneyBonusChapter1
HTMLOPTS = -a max-width=55em
PDFOPTS = --format=pdf --conf-file=a2x.conf --fop --xsl-file=custom-docbook-styles.xsl -k --verbose
KINDLEGEN_PATH = /usr/local/bin/
KINDLEGEN_OPTS = -c2
EPUBOPTS = --format=epub --conf-file=a2x.conf --stylesheet=style.css
ASCIIDOC_IMAGES = /etc/asciidoc/images
XML_CATALOG_FILES = /usr/share/xml/docbook/schema/dtd/catalog.xml
IMAGE_NAME=Cover

#  ---------------------------------
#  Public targets
all:
	# Usage
	# LANG=en make [pdf, html, epub, kindle]

# FIXME: write this target
# html:

pdf: create_pdf create_dist
	if [ -f "${DIR}/${BOOK}.pdf" ]; then \
		cp ${DIR}/${BOOK}.pdf ${DIST}/${LANG}/${TITLE}_${TAG}.pdf; \
	fi

epub: create_epub create_dist
	if [ -f "${DIR}/${EBOOK}.epub" ]; then \
		cp ${DIR}/${EBOOK}.epub ${DIST}/${LANG}/${TITLE}_${TAG}.epub; \
	fi

kindle: create_kindle create_dist
	if [ -f "${DIR}/${EBOOK}.mobi" ]; then \
		cp ${DIR}/${EBOOK}.mobi ${DIST}/${LANG}/${TITLE}_${TAG}.mobi; \
	fi


#  ---------------------------------
#  Private targets

#  Remove the build directory
clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi

#  Recreate the build directory
create_folder: clean
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
		cp -R -L ${ASCIIDOC_IMAGES} ${DIR}; \
		cp images/* ${DIR}; \
		cp chapters/${LANG}/* ${DIR}; \
		cp conf/* ${DIR}; \
	fi

#  Compress images before building ebook
compress_images: create_folder
	cd ${DIR}; \
	for f in ${IMAGE_NAME}*.png; \
		do mogrify -depth 4 -colorspace gray -resize 504x336 "$$f"; \
	done

#  Generate HTML
create_html: create_folder
	cd ${DIR}; \
	asciidoc ${HTMLOPTS} --out-file=${BOOK}.html ${BOOK}.asciidoc

#  Generate PDF
create_pdf: create_folder
	export XML_CATALOG_FILES=${XML_CATALOG_FILES}; \
	cd ${DIR}; \
	a2x ${PDFOPTS} ${BOOK}.asciidoc

#  Generate EPUB
create_epub: compress_images
	export XML_CATALOG_FILES=${XML_CATALOG_FILES}; \
	cd ${DIR}; \
	a2x ${EPUBOPTS} ${EBOOK}.asciidoc

#  Create Kindle version (ignoring the error that it outputs)
create_kindle: create_epub
	-if [ -d "${KINDLEGEN_PATH}" ]; then \
		${KINDLEGEN_PATH}/kindlegen ${KINDLEGEN_OPTS} ${DIR}/${EBOOK}.epub; \
	fi

create_dist:
	if [ ! -d "${DIST}" ]; then \
		mkdir ${DIST}; \
	fi; \
	if [ ! -d "${DIST}/${LANG}" ]; then \
		mkdir ${DIST}/${LANG}; \
	fi
