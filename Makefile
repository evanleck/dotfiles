# https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL := stow

stow:
	stow --target $(HOME) --verbose $(wildcard */)
.PHONY: stow

Brewfile:
	brew bundle dump --force
.PHONY: Brewfile

bin/.bin/asimov:
	curl --output bin/.bin/asimov https://raw.githubusercontent.com/stevegrunwell/asimov/develop/asimov
	chmod +x bin/.bin/asimov
.PHONY: bin/.bin/asimov
