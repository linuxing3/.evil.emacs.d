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

;; Speed up startup
(setq gc-cons-threshold (* 50 1000 1000))

(setq custom-file "~/.evil.emacs.d/custom.el")
(load-file custom-file)

(add-to-list 'load-path (concat (file-name-directory load-file-name) "core"))
(add-to-list 'load-path (concat (file-name-directory load-file-name) "modules"))

;; ;; ---------------------------------------------------------
;; ;; 自动加载核心库
;; ;; ---------------------------------------------------------
(require 'core-straight)

;; ;; ---------------------------------------------------------
;; ;; 功能模块
;; ;; ---------------------------------------------------------

(require 'module-ui)
;; (require 'editor+dired)

;; ;; ---------------------------------------------------------
;; ;; Org功能模块
;; ;; ---------------------------------------------------------

;;(require 'module-org)

;; ;; ---------------------------------------------------------
;; ;; 编程模块
;; ;; ---------------------------------------------------------
;; (require 'module-project)
;; (require 'module-completion)
;; (require 'module-snippets)
;; (require 'module-format)
;; (require 'module-coding)
;; (require 'module-service)

;; ;; ---------------------------------------------------------
;; ;; App模块
;; ;; ---------------------------------------------------------
;; (require 'module-app)
;; (require 'module-remote)
;; ;; ---------------------------------------------------------
;; ;; 快捷键绑定
;; ;; ---------------------------------------------------------
(require 'module-keybinds)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
