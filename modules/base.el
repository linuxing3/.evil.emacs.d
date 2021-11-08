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

   ;; Make modern look
   (show-paren-mode  1)
   (setq tool-bar-mode nil)
   (setq global-display-line-numbers-mode t)
   (setq scroll-bar-mode nil)
   (setq show-paren-mode t)))

(defun +moder-ui-scrolling-h ()
  "Help scrolling faster"
  (progn
  (setq frame-title-format '("%b –Evil Emacs")
        icon-title-format frame-title-format)
  (setq frame-resize-pixelwise t)
  (setq window-resize-pixelwise nil)
  (blink-cursor-mode -1)
  (setq hscroll-margin 2
        hscroll-step 1
        scroll-conservatively 101
        scroll-margin 0
        scroll-preserve-screen-position t
        auto-window-vscroll nil
        mouse-wheel-scroll-amount '(2 ((shift) . hscroll))
        mouse-wheel-scroll-amount-horizontal 2)))


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

(provide 'xing-init-base)
