DOCKRUN ?=
# To run it in docker
# DOCKRUN = docker run --user $(shell id -u) --network=host -v $$(pwd):/work labn/org-rfc
ORG ?= ikev2-beet.org
include mk/yang.mk
