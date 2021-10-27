;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Pretty slick literate config that I lifted some goodies from.
;;   https://tecosaur.github.io/emacs-config/config.html
;;
(setq user-full-name "Evan Lecklider"
      user-mail-address "evan@lecklider.com")

(when IS-LINUX
  (setq doom-font (font-spec :family "IBM Plex Mono" :size 22)
        doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 24)))

(when IS-MAC
  (setq doom-font (font-spec :family "IBM Plex Mono" :size 12)))

;; Don't jump quite so much each time.
(setq doom-font-increment 1)

;; Slightly more sane scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; Dracula all the things.
(setq doom-theme 'doom-dracula)

;; Stop bothering me about this shit.
(setq tags-revert-without-query t
      tags-add-tables nil)

;; Like vim's relative line numbers.
(setq-default display-line-numbers-type 'relative)

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

(add-hook! elixir-mode
  (add-to-list 'exec-path "~/Code/elixir-ls"))

;; Tell Projectile where to look for projects.
(projectile-add-known-project "~/.dotfiles")

(setq projectile-auto-discover t
      projectile-project-search-path '("~/Code" "~/Code/prepaid" "~/Code/clones"))

;; Org it up.
;; org-archive-location
(setq org-directory "~/Documents")
