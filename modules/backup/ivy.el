(use-package counsel
    :ensure t
    :bind
    (("M-y" . counsel-yank-pop)
    :map ivy-minibuffer-map
    ("M-y" . ivy-next-line)))


(use-package ivy
    :ensure t
    :diminish (ivy-mode)
    :bind (("C-x b" . ivy-switch-buffer))
    :config
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-switch-buffer-faces-alist
	'((emacs-lisp-mode . swiper-match-face-1)
    (dired-mode . ivy-subdir)
    (org-mode . org-level-4)))
    (setq ivy-count-format "%d/%d ")
    (setq ivy-display-style 'fancy))


(use-package swiper
    :ensure t
    :bind (("C-r" . swiper)
	("C-c C-r" . ivy-resume)
	("M-x" . counsel-M-x)
	("C-x C-p" . counsel-rg)
	("C-x C-f" . counsel-find-file))
    :config
    (progn
	(ivy-mode 1)
	(setq ivy-use-virtual-buffers t)
	(setq ivy-display-style 'fancy)
	(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))


(use-package ivy-hydra
    :ensure t
    :config
    (progn (message "ivy-hydra is enabled!")))

(use-package wgrep)
