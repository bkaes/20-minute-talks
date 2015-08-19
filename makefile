PANDOC = pandoc
PFLAGS = -N -s

MD_FILES   = $(wildcard talks/**/*.md)
PDF_FILES  = $(addprefix pdf/,$(notdir $(MD_FILES:.md=.pdf)))

all: $(PDF_FILES)

pdf/%.pdf: talks/**/%.md
	@mkdir -p pdf
	$(PANDOC) $(PFLAGS) -t beamer $^ -o $@

talks.tar.gz: $(PDF_FILES)
	tar -caf $@ $^

clean:
	rm -r pdf

.PHONY:	clean