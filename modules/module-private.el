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

(provide 'module-private)
