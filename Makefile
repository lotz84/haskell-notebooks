.PHONY: help build up preview publish

IMAGE:=lotz/haskell-notebooks
TAG?=latest
SHELL:=bash
DOCKER:=docker

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: DARGS?=
build: ## 実行環境のDocker Imageをビルド
	$(DOCKER) build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) .

up: ## 実行環境Jupyter notebookの立ち上げ
	$(DOCKER) run --rm -p 8888:8888 -v $(PWD):/home/jovyan/work --name haskell_notebooks $(IMAGE):$(TAG) jupyter lab --ServerApp.token=''

preview: ## Quartoでのプレビュー
	quarto preview

publish: ## GitHub Pagesへの公開
	quarto publish gh-pages
