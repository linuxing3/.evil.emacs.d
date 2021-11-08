;;; init.el --- A Fancy and Fast Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-

;; Copyright (C) 2006-2021 linuxing3

;; Author: Xing Wenju <xingwenju@gmail.com>
;; URL: https://github.com/linuxing3/evil-emacs-config
;; Version: 5.9.0
;; Keywords: .emacs.d

;;
;;   Evil EMACS - Enjoy Programming & Writing
;;

;;; Commentary:
;;
;; Centaur Emacs - A Fancy and Fast Emacs Configuration.
;;

;;; Code:

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(global-font-lock-mode t)
(transient-mark-mode t)
(setq auto-mode-case-fold nil)
(setq warning-minimum-level :emergency)
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect) ;; 显示垃圾回收信息，这个可以作为调试用 ;;
  (setq garbage-collection-messages t))

;; ---------------------------------------------------------
;; 自动加载帮助器
;; ---------------------------------------------------------
(load-file (expand-file-name "~/EnvSetup/config/evil-emacs/modules/autoloads.el"))

;; ---------------------------------------------------------
;; 包管理器
;; ---------------------------------------------------------
(load-file (private-module-path "packages.el"))

;; ---------------------------------------------------------
;; 功能模块
;; ---------------------------------------------------------

(load-file (private-module-path "base.el"))
(load-file (private-module-path "ivy.el"))
(load-file (private-module-path "ui.el"))
(load-file (private-module-path "evil-mode.el"))

;; ---------------------------------------------------------
;; Org功能模块
;; ---------------------------------------------------------

(load-file (private-module-path "org-mode.el"))

;; ---------------------------------------------------------
;; 编程模块
;; ---------------------------------------------------------
(load-file (private-module-path "project.el"))
(load-file (private-module-path "completion.el"))
(load-file (private-module-path "snippets.el"))
(load-file (private-module-path "format.el"))
(load-file (private-module-path "lang+plantuml.el"))
(load-file (private-module-path "lang+markdown.el"))
(load-file (private-module-path "coding-mode.el"))

(load-file (private-module-path "app+vagrant.el"))
(load-file (private-module-path "app+translator.el"))
;; ---------------------------------------------------------
;; 快捷键绑定
;; ---------------------------------------------------------
(load-file (private-module-path "key-bindings.el"))
