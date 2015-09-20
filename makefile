PANDOC = pandoc
PFLAGS = -N -s
PDFFORMAT=beamer

MD_FILES   = $(wildcard talks/**/*.md)
PDF_FILES  = $(addprefix pdf/,$(notdir $(MD_FILES:.md=.pdf)))
HANDOUTS   = $(addprefix handouts/,$(notdir $(MD_FILES:.md=.pdf)))

TALK_ARCHIVE = talks.tar.gz
HANDOUT_ARCHIVE = handouts.tar.gz
ALL_ARCHIVE = 20-minuten.tar.gz

all: $(PDF_FILES) $(HANDOUTS)

pdf/%.pdf: talks/**/%.md
	@mkdir -p pdf
	$(PANDOC) $(PFLAGS) -t $(PDFFORMAT) $^ -o $@

handouts/%.pdf: talks/**/%.md
	@mkdir -p handouts
	$(PANDOC) $(PFLAGS) -t latex $^ -o $@

$(TALK_ARCHIVE): $(PDF_FILES)
	tar -caf $@ $^

$(HANDOUT_ARCHIVE): $(HANDOUTS)
	tar -caf $@ $^

$(ALL_ARCHIVE): $(PDF_FILES) $(HANDOUTS)
	tar -caf $@ $^

archive: $(ALL_ARCHIVE)

clean:
	rm -rf pdf
	rm -rf handouts
	rm -f $(TALK_ARCHIVE)

.PHONY: clean archive
