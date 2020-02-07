VERSION := $(shell cat version)
URL := https://files.pythonhosted.org/packages/source/l/lockfile/lockfile-$(VERSION).tar.gz
SRC_FILE = $(notdir $(URL))
UNTRUSTED_SUFF := .UNTRUSTED
FETCH_CMD := wget --no-use-server-timestamps -q -O
SHELL := /bin/bash

%: %.sha256
	@$(FETCH_CMD) $@$(UNTRUSTED_SUFF) $(URL)
	@sha256sum --status -c <(printf "$$(cat $<)  -\n") <$@$(UNTRUSTED_SUFF) || \
		{ echo "Wrong SHA256 checksum on $@$(UNTRUSTED_SUFF)!"; exit 1; }
	@mv $@$(UNTRUSTED_SUFF) $@

.PHONY: get-sources
get-sources: $(SRC_FILE)

verify-sources:
	@true
