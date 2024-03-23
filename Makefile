.PHONY: help build up

IMAGE:=lotz/haskell-notebooks
TAG?=latest
SHELL:=bash
DOCKER:=docker

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: DARGS?=
build: ## Make the latest build of the image
	$(DOCKER) build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) .

up: ## Launch JupyterLab with token=x
	$(DOCKER) run --rm -p 8888:8888 -v $(PWD):/home/jovyan/work --name haskell_notebooks $(IMAGE):$(TAG) jupyter lab --ServerApp.token=''
