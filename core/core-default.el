;; xing-init-basic.el --- Better default configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Better defaults.
;;

;;; Code:

;; ===============================================
;; 基础配置
;; ===============================================

;; Splash Screen

(defun +modern-ui-init-h ()
  "Start modern ui for emacs"
  (progn
    (setq inhibit-startup-screen t)
    (setq inhibit-default-init t)
    (setq inhibit-startup-echo-area-message user-login-name)
    (setq initial-scratch-message ";; Happy Hacking")

    ;; Show matching parens
    (setq show-paren-delay 0)

    ;; dired copy to next window
    (setq dired-dwim-target t)

    ;; Make modern look
    (show-paren-mode  1)
    (setq tool-bar-mode nil)
    (setq menu-bar-mode nil)
    (setq global-display-line-numbers-mode t)
    (scroll-bar-mode -1)
    (setq show-paren-mode t)))


;; 更好的默认设置

(defun +better-defaults-h()
  "更简洁的默认设置"
  (progn
    (setq make-backup-files nil)
    (setq auto-save-default nil)
    (fset 'yes-or-no-p 'y-or-n-p)

    (setq auto-mode-case-fold nil)
    (setq-default bidi-display-reordering 'left-to-right
                  bidi-paragraph-direction 'left-to-right)

    (setq-default cursor-in-non-selected-windows nil)
    (setq highlight-nonselected-windows nil)
    (setq fast-but-imprecise-scrolling t)
    (setq bidi-inhibit-bpa t)

    (setq frame-inhibit-implied-resize t)
    (setq inhibit-compacting-font-caches t)


    (setq gcmh-idle-delay 'auto  ; default is 15s
          gcmh-auto-idle-delay-factor 10
          gcmh-high-cons-threshold (* 16 1024 1024))  ; 16mb

    (setq idle-update-delay 1.0)

    (setq-default major-mode 'text-mode
                  fill-column 80
                  tab-width 4
                  indent-tabs-mode nil)
    (setq visible-bell t
          inhibit-compacting-font-caches t  ; Don’t compact font caches during GC.
          delete-by-moving-to-trash t       ; Deleting files go to OS's trash folder
          make-backup-files nil             ; Forbide to make backup files
          auto-save-default nil             ; Disable auto save

          uniquify-buffer-name-style 'post-forward-angle-brackets ; Show path if names are same
          adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
          adaptive-fill-first-line-regexp "^* *$"
          sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
          sentence-end-double-space nil)))

;; Helpers
(defun +config-coding-system-h()
  "configure utf-8 as default coding system"
  (progn
    (prefer-coding-system 'utf-8)
    ;;(setq locale-coding-system 'utf-8)

    (set-language-environment 'utf-8)
    ;;(set-default-coding-systems 'utf-8)
    ;;(set-buffer-file-coding-system 'utf-8)
    ;;(set-clipboard-coding-system 'utf-8)
    ;;(set-file-name-coding-system 'utf-8)
    ;;(set-keyboard-coding-system 'utf-8)
    ;;(set-terminal-coding-system 'utf-8)
    ;;(set-selection-coding-system 'utf-8)
    ;;(modify-coding-system-alist 'process "*" 'utf-8)
    ))

;; 启动设置
(+better-defaults-h)
(+modern-ui-init-h)
(+config-coding-system-h)

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))


(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-s" . swiper)
         ("C-x b" . ivy-switch-buffer)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-f" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill)
         )
  :config
  (ivy-mode 1)
  ;; NOTE: Use different regex strategies per completion command
  (push '(completion-at-point . ivy--regex-fuzzy) ivy-re-builders-alist) ;; This doesn't seem to work...
  (push '(swiper . ivy--regex-ignore-order) ivy-re-builders-alist)
  (push '(counsel-M-x . ivy--regex-ignore-order) ivy-re-builders-alist)
  ;; NOTE: Set minibuffer height for different commands
  (setf (alist-get 'counsel-projectile-ag ivy-height-alist) 15)
  (setf (alist-get 'counsel-projectile-rg ivy-height-alist) 15)
  (setf (alist-get 'swiper ivy-height-alist) 15)
  (setf (alist-get 'counsel-switch-buffer ivy-height-alist) 7)
  ;; TODO: 美化配置
  (setq ivy-use-virtual-buffers t)
  (setq ivy-wrap t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-switch-buffer-faces-alist
	    '((emacs-lisp-mode . swiper-match-face-1)
          (dired-mode . ivy-subdir)
          (org-mode . org-level-4)))
  (setq ivy-count-format "%d/%d ")
  (setq -re-builders-alist '((t . ivy--regex-fuzzy)))
  (setq ivy-display-style 'fancy))

(use-package ivy-prescient
  :after ivy
  :config
  (ivy-prescient-mode))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
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

(use-package avy
  :commands (avy-goto-char avy-goto-word-0 avy-goto-line))

(use-package wgrep)

(provide 'core-default)
