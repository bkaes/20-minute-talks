PANDOC = pandoc
PFLAGS = -N -s

MD_FILES   = $(wildcard talks/**/*.md)
PDF_FILES  = $(addprefix pdf/,$(notdir $(MD_FILES:.md=.pdf)))

TALK_ARCHIVE = talks.tar.gz

all: $(PDF_FILES)

pdf/%.pdf: talks/**/%.md
	@mkdir -p pdf
	$(PANDOC) $(PFLAGS) -t beamer $^ -o $@

$(TALK_ARCHIVE): $(PDF_FILES)
	tar -caf $@ $^

archive: $(TALK_ARCHIVE)

clean:
	rm -rf pdf
	rm -f $(TALK_ARCHIVE)

.PHONY: clean archive
