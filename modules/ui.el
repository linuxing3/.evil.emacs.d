;; Theme and Font
;; ---------------------------------------------------------
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-dracula t))
(set-fontset-font "fontset-default" 'han "Microsoft YaHei UI")

;; All The Icons
(use-package all-the-icons :ensure t)

;; Powerline
(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'slant)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-evil-state-on))
