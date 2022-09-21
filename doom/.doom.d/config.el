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

(after! projectile
	(projectile-add-known-project "~/.dotfiles")
	;; Remove non-projects on exit.
	(setq doom-projectile-cache-purge-non-projects t)
	;; Discover projects here.
	(setq
		projectile-auto-discover t
		projectile-project-search-path '("~/Code" "~/Code/oft" "~/Code/clones")))

;; Org it up.
(use-package! org
	:config
	(setq-local
		my-org-directory "~/Documents/Org"
		my-org-inbox "Inbox.org")

	(setq
		org-directory my-org-directory
		org-agenda-files (list my-org-directory)
		org-archive-location (concat org-directory "/Archive/" (format-time-string "%Y-%m") ".org::* From %s")
		org-default-notes-file (concat org-directory "/" my-org-inbox)
		org-archive-file-header-format nil
		org-image-actual-width 500
		+org-capture-notes-file my-org-inbox
		+org-capture-todo-file my-org-inbox))

;; Gimme that Command+B, Command+I that I know and love.
;;   https://emacs.stackexchange.com/questions/63842/standard-mac-windows-keybindings-for-italics-bold-and-underline-in-org-mode
(after! evil-org
	(map! :map evil-org-mode-map
		:v "s-b" (lambda () (interactive) (org-emphasize ?\*))
		:v "s-i" (lambda () (interactive) (org-emphasize ?\/))))

;; Pull this in a little bit.
(after! writeroom-mode
	(setq writeroom-width 72))

;; Always sit in the trees.
(after! tree-sitter
	(global-tree-sitter-mode))
