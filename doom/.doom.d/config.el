;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Evan Lecklider"
      user-mail-address "evan@lecklider.com")

(setq doom-font (font-spec :family "Fira Mono" :size 22))

;; Slightly more sane scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; Load my default theme.
(setq doom-theme 'doom-dracula)

;; Stop bothering me about this shit.
(setq tags-revert-without-query t)

;; Don't keep other tags tables.
(setq tags-add-tables nil)

;; Like vim's magic relative line numbers.
(setq-default display-line-numbers-type 'relative)

;; Easier window movement.
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right

      ;; Because I'm a dumb ape.
      :n "C-s" #'save-buffer
      :i "C-v" #'yank)

;; Always start with a maximized frame (window in the OS).
(add-hook 'window-setup-hook #'toggle-frame-maximized)

(add-hook! ruby-mode
  ;; Add _ as a word character.
  (modify-syntax-entry ?_ "w")
  ;; Use etags for ruby-mode.
  (set-company-backend! 'ruby-mode 'company-etags))

(add-hook! web-mode
  ;; Add _ as a word character.
  (modify-syntax-entry ?_ "w"))

(add-hook! js2-mode
  ;; Add _ as a word character.
  (modify-syntax-entry ?_ "w"))

;; Tell Projectile to look in ~/Code and ~/Clones for projects.
(setq projectile-auto-discover t)
(setq projectile-project-search-path '("~/Code" "~/Code/prepaid" "~/Code/prepaid/wt" "~/Code/clones"))
