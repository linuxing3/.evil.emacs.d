;; ===============================================
;; 基础配置
;; ===============================================
(setq user-full-name "Xing Wenju"
      user-mail-address "linuxing3@qq.com")

(setq bookmark-default-file (dropbox-path "shared/emacs-bookmarks"))

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Splash Screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; Happy Hacking")

;; Show matching parens
(setq show-paren-delay 0)

(show-paren-mode  1)
(setq tool-bar-mode nil)
(setq global-display-line-numbers-mode t)
(setq scroll-bar-mode nil)
(setq show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

;; 优化内存管理
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))
