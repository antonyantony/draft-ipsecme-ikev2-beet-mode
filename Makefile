NEW_FILE?=draft-antony-ipsecme-beet-mode
OLD_FILE?=draft-antony-ipsecme-beet-mode
TMP_FILE?=draft-antony-ipsecme-beet-mode-tmp

XML2RFC?=/Users/antony/Library/Python/3.11/bin/xml2rfc

all:
	$(XML2RFC) --v3 --text $(NEW_FILE).xml

lint:
	mv $(NEW_FILE).xml $(TMP_FILE).xml

	XMLLINT_INDENT="  " xmllint --format $(TMP_FILE).xml > $(NEW_FILE).xml && rm $(TMP_FILE).xml

rfcdiff:
	rfcdiff --body --diff  $(OLD_FILE).txt $(NEW_FILE).txt

xml2rfc:
	xml2rfc $(NEW_FILE).xml

aadiff:
	git diff draft-pwouters-ipsecme-multi-sa-performance-00.xml | grep -E "^[+-]" -A 1 -B 1 | grep -v "^--" > a

a:
	$(XML2RFC) --v3 --text a.xml
