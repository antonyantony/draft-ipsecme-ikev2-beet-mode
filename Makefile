ORG ?=ikev2-beet.org
DOCKRUN=

BASE := $(shell sed -e '/^\#+RFC_NAME:/!d;s/\#+RFC_NAME: *\(.*\)/\1/' $(ORG))
VERSION := $(shell sed -e '/^\#+RFC_VERSION:/!d;s/\#+RFC_VERSION: *\([0-9]*\)/\1/' $(ORG))
VERSION_NOZERO := $(shell echo "$(VERSION)" | sed -e 's/^0*//')
NEXT_VERSION := $(shell printf "%02d" "$$(($(VERSION_NOZERO) + 1))")
PREV_VERSION := $(shell printf "%02d" "$$(($(VERSION_NOZERO) - 1))")
DTYPE := $(word 2,$(subst -, ,$(BASE)))
PBRANCH := publish-$(DTYPE)-$(VERSION)
PBASE := publish/$(BASE)-$(VERSION)
VBASE := draft/$(BASE)-$(VERSION)
LBASE := draft/$(BASE)-latest
SHELL := /bin/bash

EMACSCMD := $(DOCKRUN) emacs -Q --batch --debug-init --eval '(setq-default indent-tabs-mode nil)' --eval '(setq org-confirm-babel-evaluate nil)' -l ./ox-rfc.el

all: $(VBASE).xml $(LBASE).txt $(LBASE).html # $(LBASE).pdf

clean:
	rm -f $(BASE).xml $(BASE)-*.{txt,html,pdf} $(LBASE).*

$(VBASE).xml: $(ORG) ox-rfc.el test
	mkdir -p draft
	$(EMACSCMD) $< -f ox-rfc-export-to-xml
	sed -i -e 's/<organization>secunet Security Networks AG/<organization abbrev="secunet">secunet Security Networks AG/g' $(BASE).xml
	mv $(BASE).xml $@

%-$(VERSION).txt: %-$(VERSION).xml
	$(DOCKRUN) xml2rfc --v3 --cache /tmp --text $< > $@

%-$(VERSION).html: %-$(VERSION).xml
	$(DOCKRUN) xml2rfc --v3 --cache /tmp --html $< > $@

%-$(VERSION).pdf: %-$(VERSION).xml
	$(DOCKRUN) xml2rfc --cache /tmp --pdf $< > $@

$(LBASE).%: $(VBASE).%
	cp $< $@

ox-rfc.el:
	curl -fLO 'https://raw.githubusercontent.com/choppsv1/org-rfc-export/master/ox-rfc.el'

test: $(ORG) ox-rfc.el
	@echo Testing $<
	@result="$$($(EMACSCMD) $< -f ox-rfc-run-test-blocks 2>&1)"; \
	if [ -n "$$(echo \"$$result\"|grep FAIL)" ]; then \
		grep RESULT <<< "$$result" || true; \
		exit 1; \
	else \
		grep RESULT <<< "$$result" || true; \
	fi;
