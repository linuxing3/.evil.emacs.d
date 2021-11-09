;; xing-init-basic.el --- Better default configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Better defaults.
;;

;;; Code:

;; ===============================================
;; 基础配置
;; ===============================================
(setq user-full-name "Xing Wenju"
      user-mail-address "linuxing3@qq.com")

(setq bookmark-default-file (dropbox-path "shared/emacs-bookmarks"))

(setq custom-theme-directory (dropbox-path  "config/emacs/themes/"))

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

(provide 'module-base)
