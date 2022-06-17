;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Pretty slick literate config that I lifted some goodies from.
;;   https://tecosaur.github.io/emacs-config/config.html
;;
(setq
	user-full-name "Evan Lecklider"
	user-mail-address "evan@lecklider.com")

(when IS-LINUX
	(setq
		doom-font (font-spec :family "IBM Plex Mono" :size 22)
		doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 24)))

(when IS-MAC
	(setq doom-font (font-spec :family "JetBrains Mono" :size 12)))

;; Don't jump quite so much each time.
(setq doom-font-increment 1)

;; Slightly more sane scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(setq
	;; Dracula all the things.
	doom-theme 'doom-dracula
	;; Don't gimme that variable pitch nonsense.
	doom-themes-treemacs-enable-variable-pitch nil)

;; Stop bothering me about this shit.
(setq
	tags-revert-without-query t
	tags-add-tables nil)

;; Long live the tabs!
(setq-default
	tab-width 2
	indent-tabs-mode t)

;; Don't mess with my clipboard.
(setq select-enable-clipboard nil)

;; Sorting should ignore case.
(setq sort-fold-case t)

;; Map it out.
(map!
	;; Easier window movement.
	:n "C-h" #'evil-window-left
	:n "C-j" #'evil-window-down
	:n "C-k" #'evil-window-up
	:n "C-l" #'evil-window-right

	;; Because I'm a dumb ape.
	:n "C-s" #'save-buffer
	:i "C-s" #'save-buffer
	:i "C-v" #'yank

	;; Open them Earls
	:n "g x" #'browse-url-at-point)

;; Add _ as a word character.
(add-hook! ruby-mode
	(modify-syntax-entry ?_ "w"))

(add-hook! web-mode
	(modify-syntax-entry ?_ "w"))

(add-hook! js2-mode
	(modify-syntax-entry ?_ "w"))

;; Per the README and https://github.com/felipeochoa/rjsx-mode/issues/85, this
;; is the only way to get tabs in my JavaScript.
(add-hook! rjsx-mode
	(setq-local indent-line-function 'js-jsx-indent-line))

;; Disable flycheck-mode for erb web-mode files.
(add-to-list 'auto-mode-alist
	'("\\.erb\\'" . (lambda () (web-mode) (flycheck-mode -1))))

;; Disable Ruby's typeprof language server. It's not useful for me right now.
(after! lsp-mode
	(add-to-list 'lsp-disabled-clients 'typeprof-ls))

(add-hook! elixir-mode
	(add-to-list 'exec-path "~/Code/elixir-ls"))

(use-package! projectile
	:config
	;; Remove non-projects on exit.
	(setq doom-projectile-cache-purge-non-projects t)

	;; Tell Projectile where to look for projects.
	(projectile-add-known-project "~/.dotfiles")
	(setq
		projectile-auto-discover t
		projectile-project-search-path '("~/Code" "~/Code/oft" "~/Code/clones")))

;; Org it up.
;; org-archive-location
(setq
	org-directory "~/Documents/Org"
	org-default-notes-file (concat org-directory "/Inbox.org")
	+org-capture-notes-file "Inbox.org"
	+org-capture-todo-file "Inbox.org")

;; Pull this in a little bit.
(use-package! writeroom-mode
	:config
	(setq writeroom-width 72))

;; Matchit up
(use-package! evil-matchit
	:config
	(global-evil-matchit-mode 1))

;; Simple my clips already.
(use-package! simpleclip
	:config
	(simpleclip-mode 1))

;; Tree-sitter
(use-package! tree-sitter
	:config
	(require 'tree-sitter-langs)
	(global-tree-sitter-mode)
	(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
