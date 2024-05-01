NEW_FILE ?= draft-antony-ipsecme-iekv2-beet-mode
OLD_FILE ?= draft-antony-ipsecme-iekv2-beet-mode
TMP-SUFF ?= $(mktemp -u XXXXXX)
TMP_FILE ?= $(NEW_FILE)-$(TMP-SUFF)

XML2RFC?=/Users/antony/Library/Python/3.11/bin/xml2rfc

all:
	$(XML2RFC) --v3 --text $(NEW_FILE).xml

lint:
	XMLLINT_INDENT="  " xmllint --format $(NEW_FILE).xml > $(TMP_FILE).xml && mv $(TMP_FILE).xml $(NEW_FILE).xml

tidy:
	tidy -i -xml -wrap 80 -i $(NEW_FILE).xml > $(TMP_FILE).xml && mv $(TMP_FILE).xml $(NEW_FILE).xml

rfcdiff:
	rfcdiff --body --diff  $(OLD_FILE).txt $(NEW_FILE).txt

xml2rfc:
	xml2rfc $(NEW_FILE).xml

aadiff:
	git diff $(NEW_FILE) | grep -E "^[+-]" -A 1 -B 1 | grep -v "^--" > a

a:
	$(XML2RFC) --v3 --text a.xml
