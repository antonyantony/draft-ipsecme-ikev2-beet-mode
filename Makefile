ORG ?= ikev2-beet.org
DOCKER ?= no
ifeq ($(DOCKER),yes)
  DOCKRUN ?= docker run --user $(shell id -u) --network=host -v $$(pwd):/work labn/org-rfc
else
  DOCKRUN ?=
endif
include mk/yang.mk
