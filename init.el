;;; init.el --- A Fancy and Fast Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-

;; Copyright (C) 2006-2021 Vincent Zhang

;; Author: Xing Wenju <xingwenju@gmail.com>
;; URL: https://github.com/linuxing3/evil-emacs-config
;; Version: 5.9.0
;; Keywords: .emacs.d

;;
;;                          `..`
;;                        ````+ `.`
;;                    /o:``   :+ ``
;;                .+//dho......y/..`
;;                `sdddddhysso+h` ``
;;                  /ddd+`..` +. .`
;;                 -hos+    `.:```
;;               `./dddyo+//osso/:`
;;             `/o++dddddddddddddod-
;;            `// -y+:sdddddsddsy.dy
;;                /o   `..```h+`y+/h+`
;;                .s       `++``o:  ``
;;                        `:- `:-
;;
;;   CENTAUR EMACS - Enjoy Programming & Writing

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Centaur Emacs - A Fancy and Fast Emacs Configuration.
;;

;;; Code:

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(setq auto-mode-case-fold nil)
(setq warning-minimum-level :emergency)
(global-font-lock-mode t)
(transient-mark-mode t)
;; 全屏
;; (toggle-frame-fullscreen)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

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
;; (load-file (private-module-path "coding-mode.el"))

;; ---------------------------------------------------------
;; 快捷键绑定
;; ---------------------------------------------------------
(load-file (private-module-path "key-bindings.el"))
