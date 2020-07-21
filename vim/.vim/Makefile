# https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL := pack

PACKDIR := pack/plugins
OPTDIR := $(PACKDIR)/opt
STARTDIR := $(PACKDIR)/start

START := \
git@github.com:adelarsq/vim-matchit.git \
git@github.com:cespare/vim-toml.git \
git@github.com:dense-analysis/ale.git \
git@github.com:docunext/closetag.vim.git \
git@github.com:ekalinin/Dockerfile.vim.git \
git@github.com:elixir-editors/vim-elixir.git \
git@github.com:evanleck/vim-svelte.git \
git@github.com:itchyny/lightline.vim.git \
git@github.com:jiangmiao/auto-pairs.git \
git@github.com:junegunn/fzf.git \
git@github.com:junegunn/fzf.vim.git \
git@github.com:junegunn/vim-easy-align.git \
git@github.com:ludovicchabant/vim-gutentags.git \
git@github.com:maximbaz/lightline-ale.git \
git@github.com:moll/vim-bbye.git \
git@github.com:othree/html5.vim.git \
git@github.com:pangloss/vim-javascript.git \
git@github.com:preservim/nerdtree.git \
git@github.com:svermeulen/vim-easyclip.git \
git@github.com:tpope/vim-commentary.git \
git@github.com:tpope/vim-endwise.git \
git@github.com:tpope/vim-eunuch.git \
git@github.com:tpope/vim-fugitive.git \
git@github.com:tpope/vim-haml.git \
git@github.com:tpope/vim-repeat.git \
git@github.com:tpope/vim-surround.git \
git@github.com:tpope/vim-unimpaired.git \
git@github.com:vim-ruby/vim-ruby.git

OPT := \
git@github.com:dracula/vim.git

# Make doesn't really allow colons in file names from what I can tell, so I
# mangle the name here with two pluses to get around it.
MANGLE := ++

mangle = $(strip $(subst :,$(MANGLE), $(1)))
demangle = $(strip $(subst $(MANGLE),:, $(1)))

# Custom macro to turn a GitHub URL into a local directory.
directory = $(strip $(subst /,-, $(subst .git,, $(subst git@github.com:,, $(1)))))

# Add the directory prefix to a GitHub URL and convert it into a directory name.
prefixed = $(strip $(if $(findstring $(call demangle, $(1)), $(OPT)), $(addprefix $(OPTDIR)/, $(call directory, $(call demangle, $(1)))), $(addprefix $(STARTDIR)/, $(call directory, $(call demangle, $(1))))))

setup: backup swap undo pack
	@echo "Set up and ready."
.PHONY: setup

pack: $(call mangle, $(START)) $(call mangle, $(OPT))
	@echo "Generating helptags..."
	@vim -c "helptags ALL" -c "quit"
	@echo "  Done."
	@echo ""
.PHONY: pack

backup:
	@mkdir backup

swap:
	@mkdir swap

undo:
	@mkdir undo

%.git:
	@echo "Packing $(call demangle, $@) into $(call prefixed, $@)"
	@[ -d $(call prefixed, $@)/.git ] || git clone $(call demangle, $@) $(call prefixed, $@)
	@git -C $(call prefixed, $@) pull
	@echo "  Packed $(call demangle, $@)"
	@echo ""

clean:
	@rm -rf "$(PACKDIR)"
	@echo "$(PACKDIR) removed."
.PHONY: clean
