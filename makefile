.PHONY:

SRCS	= $(shell find . -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)

all: archive/all_id.json htmls

archive/all_id.json: archive/all.json
	./archive.sh

htmls: $(OBJS)

%.html: %.adoc
	@asciidoc -b html5 -s $<
	@./template.sh $< $@ > $@.tmp
	@mv $@.tmp $@
	@echo convert $<

archive_clean: htmls
	rm archive/all_id.json

clean:
	find . -name '*.html' -delete
