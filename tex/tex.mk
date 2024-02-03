TEX_NAME := $(TITLE)_$(DATE).tex
PDF_NAME := $(TEX_NAME:.tex=.pdf)
TEX_FILES := $(TEX_NAME) header.tex

TEX_DIR := ../tex

PDFS := $(PDF_NAME)
CCBY := $(TEX_DIR)/by.eps

VCARD_DIR  := ../vcard
VCARD := gmm7550-vcard.png

RM := rm -f
SED := sed
CP  := cp
TEX := pdflatex -shell-escape
RST2PDF := rst2pdf

.PHONY: all pdf clean clean_vcard distclean

all: pdf

pdf: $(PDFS)

clean:
	$(RM) $(TEX_FILES)
	$(RM) $(notdir $(CCBY)) *-converted-to.pdf
	$(RM) *.out *.aux *.nav *.log *.snm *.toc
	$(RM) $(VCARD)

distclean: clean clean_vcard
	$(RM) $(PDFS)
	$(RM) *~

clean_vcard:
	$(MAKE) -C $(VCARD_DIR) clean

header.tex: $(TEX_DIR)/header.tex
	$(SED) -e's/@DATE@/$(DATE)/' $< > $@
	$(CP) $(CCBY) .

$(VCARD):
	$(MAKE) -C $(VCARD_DIR)
	$(CP) $(VCARD_DIR)/$(VCARD) .

$(TEX_NAME): $(TITLE).tex
	$(CP) $< $@

$(PDF_NAME): $(TEX_FILES) $(VCARD)
	$(TEX) $(TEX_NAME)
	$(TEX) $(TEX_NAME)
	$(TEX) $(TEX_NAME)

%.pdf: %.rst
	$(RST2PDF) $<
