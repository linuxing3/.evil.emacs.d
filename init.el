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


(add-to-list 'load-path (concat (file-name-directory load-file-name) "modules"))
(add-to-list 'load-path (concat (file-name-directory load-file-name) "lib"))

;; ;; ---------------------------------------------------------
;; ;; 自动加载帮助器
;; ;; ---------------------------------------------------------
(require 'module-lib)

;; ;; ---------------------------------------------------------
;; ;; 包管理器
;; ;; ---------------------------------------------------------
(require 'module-packages)

;; ;; ---------------------------------------------------------
;; ;; 功能模块
;; ;; ---------------------------------------------------------

(require 'module-base)
(require 'module-ui)
(require 'module-evil)

;; ;; ---------------------------------------------------------
;; ;; Org功能模块
;; ;; ---------------------------------------------------------

(require 'module-org)

;; ;; ---------------------------------------------------------
;; ;; 编程模块
;; ;; ---------------------------------------------------------
(require 'module-project)
(require 'module-completion)
(require 'module-snippets)
(require 'module-format)
(require 'module-coding)
(require 'module-service)

;; ;; ---------------------------------------------------------
;; ;; App模块
;; ;; ---------------------------------------------------------
(require 'module-app)
;; ;; ---------------------------------------------------------
;; ;; 快捷键绑定
;; ;; ---------------------------------------------------------
(require 'module-keybinds)
